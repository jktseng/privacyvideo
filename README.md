# PRIVACY RECORDING

A small app demonstrating how OpenCV can be used on iOS to perform face recognition, face detection and also blocking out faces.

This application is derived from iOS-OpenCV-FaceRec.

This project was made possible by using Engin Kurutepe tutorial on face recognition. Please check out: https://www.objc.io/issues/21-camera-and-photos/face-recognition-with-opencv/ for further information about implementing face recognition. 

## HARDWARE REQUIREMENT:
Any Apple product that supports iOS 9 and higher. It is recommended to use iPhone 6 or similiar specification for the application to run smoothly.

## SOFTWARE REQUIREMENT:
iOS 9 or higher <br />
XCODE 7 or higher since the application will need to be side loaded.  

## SET-UP:
Open a new terminal and run the following commands:
* after cloning the repo cd into the project and run the following commands. <br />
1) sudo gem install cocoapods <br />
2) pod setup <br />
3) pod install <br />
* Navigate and open the project “iOS-OpenCV-FaceRec.xcworkspace”
* Navigate to the project settings. In “General” change bundle identifier to something unique.
* Make sure the iOS device is part of the “Team” you selected.
* Run it by changing the device option to your own device. Click run.
* If there is a prompt to fix issues click “Fix Issue”
* There will be a warning pop up asking for security permission. Go to your device’s settings  > general > Profiles and click on the account you are using to run the application. It should be under “Developer App”
* Click the play button again in the project and the application should be downloaded to the phone.

## HOW TO USE THE APPLICATION:
* After a fresh install of the application, for the facial recognition to work properly it requires at least 5-10 pictures of the subject you want to recognize. (NOTE: Do this for both the front facing camera and back facing camera. That means in total you should have at least 10-20 images.) When taking the pictures, make sure to take it from different angles. The picture can be taken by tapping once on the subjects face. Another view will appear and ask you if the image is correct or the image is the wrong person, or you want to retake the picuture. A number will be assigned to each person. Since it is the first subject it will start with “Person 1”. When you take a picture of the same face of the person that is recognized it should always be “Person 1”.  The more pictures of the same person the more accurate it will be. 
* After more than 10 pictures are taken tap on a face that should not be in the video. Instead of taping “correct”, tap “Wrong. This is another face”. The person’s face should be blocked after that. If other faces appear in the frame you can do the same procedure to block out the faces.
* If you take a bad photo or the application gives you a wrong person that it recognizes you can exit without saving. This will help getting rid of faulty data.
* When you are ready to film, tap anywhere on the screen except the peoples face in the frame. You will notice that the button to switch camera from front camera to back camera disappears. This is when you will know you are filming. When you are done filming press anywhere on the screen except the peoples faces again and it will bring back the “Switch camera” button. This is when you know you have stopped filming. The video is stored inside the photos application of the iPhone.

## MACHINE LEARNING:
* The software requires a good amount of images to make the correct decisions. The "Recognized Person" is a unique ID that the application thinks the image corresponds to. Since machine learning uses adaptive learning, the user need to make correct decisions for the application so that the chances of recognizing a face is improved.
* The demo uses LBPH algoirthm to do the face recognition since it can be updated with user input without requiring a complete retraining every time a new person is added or a wrong recognition is corrected.

*** Please be aware this is a proof of concept and a prototype. If the application crashes or freezes please restart the application.***
___

Directed study project under the supervision of Carman Neustaedter <br />
Contributer: Jordan Tseng

