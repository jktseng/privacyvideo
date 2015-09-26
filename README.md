# PRIVACY RECORDING

A small app demonstrating how OpenCV can be used on iOS to perform face recognition, face detection and also blocking out faces.

This application is derived from iOS-OpenCV-FaceRec.

All credits goes to Engin Kurutepe for making a tutorial for this project to be possible. Please check out: https://www.objc.io/issues/21-camera-and-photos/face-recognition-with-opencv/ for further information about implementing face recognition. 

## HARDWARE REQUIREMENT:
Any Apple product that run on iOS will be able to run this application however it is recommended to use iPhone 5 or similar devices for the application to run.

## SOFTWARE REQUIREMENT:
XCODE 7 or higher since the application will need to be side loaded.  

## SET-UP:
* Navigate and double click on “iOS-OpenCV-FaceRec.xcworkspace” in the folder.
* Run it by changing the device option to your own device. Click run.
* There will be a warning pop up asking for security permission. Go to your device’s settings  > general > Profiles and click on the account you are using to run the application. It should be under “Developer App”
* Click the play button again in the project and the application should be downloaded to the phone.

## HOW TO USE THE APPLICATION:
* After a fresh install of the application, it requires at least 5-10 pictures of the subject you want to recognize the face of. (NOTE: This applies to both the front facing camera and back facing camera. That means in total you should have at least 10-20 images.) The rest of the faces will be blurred out. When taking the pictures, make sure to take it from different angles. The picture can be taken by taping once on the subjects face. Another view will appear and ask you if it the image is correct or the image is the wrong person. The numbers are assigned to each person. Since it is the first subject it will start with “Person 1”. When you take a picture of the same face of the person that is recognized it should always be “Person 1”.  The more pictures of the same person the more accurate it will be. 
* After more than 10 pictures are taken tap on a face that should not be in the video. Instead of taping “correct”, tap “Wrong. This is another face”. The person’s face should be blocked after that. If other faces appear in the frame you can do the same procedure to block out the faces.
* If you take a bad photo or the application gives you a wrong person that it recognizes you can exit without saving. This will help getting rid of faulty data.
* When you are ready to film, tap anywhere on the screen except the peoples face in the frame. You will notice that the button to switch camera from front camera to back camera disappears. This is when you will know you are filming. When you are done filming press anywhere on the screen except the peoples faces again and it will bring back the “Switch camera” button. This is when you know you have stopped filming. (NOTE: The video is recoding the screen not the actual video feed, so there is no sound)

** Please be aware this is a proof of concept and a prototype. If the application crashes or freezes please restart the application.**
___

Directed study project under the supervision of Carman Neustaedter <br />
Contributer: Jordan Tseng

