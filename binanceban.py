import botogram, os

try:
	from PIL import Image
except ImportError:
	import Image
import imagehash, pytesseract, os

from pony.orm import *

bot=botogram.create(os.environ["TOKEN_TG"])
db = Database()
db.bind(provider='mysql', host=os.environ['MYSQL_HOST'],#+':'+os.environ["MYSQL_PORT"],
                user=os.environ['MYSQL_USER'],  passwd=os.environ['MYSQL_PASSWORD'],
                db=os.environ['MYSQL_DATABASE'])

class Ocr(db.Entity):
    id = PrimaryKey(int, auto=True)
    ocr = Required(str)

class Hash(db.Entity):
    id = PrimaryKey(int, auto=True)
    hash = Required(str)

db.generate_mapping(create_tables=True)

def hash_core(filename):
	img=Image.open(filename)
	hash=str(imagehash.average_hash(img))
	with db_session:
		p1 = db.select('SELECT * FROM hash')
		for i in p1:
			if hash == i[1]:
				return True
	img.close()
	return False

def hash2_core(filename):
	img=Image.open(filename)
	hash=str(imagehash.average_hash(img))
	with db_session:
		p1 = db.select('SELECT * FROM hash')
		for i in p1:
			tot=0
			different=0
			for world in i[1]:
				if world != hash[tot]:
					different+=1
				tot+=1

			if ((100*different)/tot) <=18:
				return True
	img.close()
	return False


def ocr_core(filename):
	img=Image.open(filename)
	with db_session:
		p1 = db.select('SELECT * FROM ocr')
		text=pytesseract.image_to_string(img,config='--psm 6').lower()
		for i in p1:
			if i[1] in text:
				return True
	img.close()
	return False

def img_core(filename):
	path="blacklist/"
	arr_img = [x for x in os.listdir(path) if x.endswith(".jpg")]
	i1 = Image.open(filename)
	for img in arr_img:
		i2 = Image.open(path+img)
		#assert i1.mode == i2.mode, "Different kinds of images."
		#assert i1.size == i2.size, "Different sizes."

		pairs = zip(i1.getdata(), i2.getdata())
		if len(i1.getbands()) == 1:
		    # for gray-scale jpegs
		    dif = sum(abs(p1-p2) for p1,p2 in pairs)
		else:
		    dif = sum(abs(c1-c2) for p1,p2 in pairs for c1,c2 in zip(p1,p2))

		ncomponents = i1.size[0] * i1.size[1] * 3
		percentage=(dif / 255.0 * 100) / ncomponents
		if percentage <= 5:
			return True
		i2.close()
	i1.close()
	return False

@bot.message_edited
@bot.process_message
def message_ban(chat, message):
	if message.photo:
		name="/tmp/"+message.photo.file_id
		message.photo.save(name)
		if hash_core(name) or img_core(name) or ocr_core(name) or hash2_core(name):
			try:
				message.delete()
				chat.ban(message.sender)
				chat.send("Utente bannato per immagine spam")
			except Exception:
				chat.send("Non posso bannare l'utente")
		os.remove(name)


if __name__ == '__main__':
	print('@'+bot.itself.username)
	bot.run()
