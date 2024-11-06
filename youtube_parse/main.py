import random
import string
import yt_dlp
from mutagen.mp3 import MP3
import os

f = "".join(open("videos_zaik.txt").readlines()).splitlines()


for i in f:
    with yt_dlp.YoutubeDL({
    'outtmpl': f'output_zaik/{"".join(random.choice(string.ascii_letters) for _ in range(16))}.%(ext)s',
    'format': 'bestaudio/best',
    'postprocessors': [{
        'key': 'FFmpegExtractAudio',
        'preferredcodec': 'mp3',
        'preferredquality': '16',
    }],
}) as ydl:
        ydl.download(i)




def convert_seconds(seconds):
    hours = seconds // 3600
    seconds %= 3600
    minutes = seconds // 60
    seconds %= 60
    return "%02d:%02d:%02d" % (hours, minutes, seconds)

path = "output_zaik/"
total_length = 0
for root, dirs, files in os.walk(os.path.abspath(path)):
    for file in files:
        if file.endswith(".mp3"):
            audio = MP3(os.path.join(root, file))
            length = audio.info.length
            total_length += length

hours, minutes, seconds = convert_seconds(total_length).split(":")
print("total duration: " + str(int(hours)) + ':' + str(int(minutes)) + ':' + str(int(seconds)))