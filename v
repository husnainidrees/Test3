

# From Video Convert 

# phaly hum movie k audio phir text mein

from flask import Flask,request

import speech_recognition as sr


# yeh movie k liye ha 
import moviepy.editor as mp

app=Flask(__name__)

@app.route('/vid',methods=['POST'])

def video_convert():
    
    audio_file = request.files['audio']
    movie_data=request.files['mov']

    clip = mp.VideoFileClip(movie_data) #specify the correct file path to your video file 
    clip.audio.write_audiofile(audio_file) #this the name of the coverted audio file

    # yeh to recoginzer ha
    r = sr.Recognizer()

    audio =sr.AudioFile(audio_file) # give the audio file name here
    with audio as source:
        audio_file = r.record(source)


        result = r.recognize_google(audio_file)
        with open('recognized_text_file.txt', mode='w') as file:
         file.write("speech recognized")
         file.write("\n")
        file.write(result)

        print("Now the file is ready")

    return "The Invalid  Format "

    



if __name__=='__main__':
    
    app.run(debug=True,port=8332)
