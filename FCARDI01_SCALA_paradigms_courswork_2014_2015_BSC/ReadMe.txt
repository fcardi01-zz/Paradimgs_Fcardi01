
Scala Assignment valid for Paradigms Coursework 
For BSC 2014-2015 

Franco Cardinali


A) The Scala project in the /src/main/scala/com.playfair/Playfair.scala contains and Object named MenuPlayfair
B) The testing are contained in same folder /src/main/scala/com.playfair/PlayfairTesting.scala  --> 
C) Two files are absolutely needed
	
	1) Playfair\src\main\scala\testodecode.txt
	2) Playfair\src\main\scala\testoencode.txt
	
D) Those two files store temporary and just for one session the messages to decode / encode 
E) The key will last one session only as well then destroyed :)
F) Please do not hesitate to view the PlayfairStructureFolder.png to visualize the folder structure which I have used
G) The Main folder  FCARDI01_SCALA_paradigms_courswork_1204_2015_BSC also contained the scalatest_2.11-2.2.4.jar which I have used for my testing in IntelliJ IDE 
H) Also I have dropped in this Folder the build.sbt for the manual dependencies adjusted with lots of pain to make Scala work and all the modules related



Instruction to Run

Run this in IntelliJ IDEA 14.0.3 and you will be prompt with a UI Menu

EXAMPLE OUTPUT
###################################################################################
                       PLAYFAIR IN SCALA                                 
__________________________________________________________________________

               Welcome To The Playfair Main Menu                          
               Franco Cardinali 12th April 2015                           
__________________________________________________________________________

                              MENU                                         

 Firstly you will be Prompt to insert a keyword to use for encrypt or decrypt
 1 -> Encode > 
 2 -> Decode > 
 3 -> EXIT from Playfair
__________________________________________________________________________

                     Example TO ENCRYPT                                   
An anonymous reader sends word of a proof-of-concept Google Chrome browser
extension that steals users' login details. The developer, Andreas Grech, 
says that he is trying to raise awareness about security among end users, 
and therefore chose Chrome as a test-bed because of its reputation as the 
safest browser.
__________________________________________________________________________

                       Example KEYWORD                                    
                        Pennsylvania                                      
__________________________________________________________________________

Welcome....please digit a keyword => 
##########################################################################################
END EXAMPLE OUTPUT

1) FIRSTLY INSERT A KEY WHICH YOU WILL USE FOR ENCODE AND DECODE -
	1A) THE SAME KEY WILL BE USED UNTILL YOU WILL NOT EXIT --> OPTION 3

2) THE PROGRAM WILL PROMPT YOU THE ASSIGNMENT EXAMPLE KEY "Pennsylvania"

3) DIGIT ANY KEY WORD AND IT WILL PRINT YOU THE PLAYFAIR 5X5 MATRIX TO HELP YOU UNDERSTAND VISUALLY

			Welcome....please digit a keyword => Pennsylvania

									GRID SETUP  5x5                                  
			pensy
			lvaib
			cdfgh
			kmoqr
			tuwxz

Please Choose Option from above menu....



4) DIGIT 1 TO ENCODE
4B) WRITE ANY PHRASE YOU WILL LOVE TO ENCRYPT 
4C) WATCH THE RESULT


EXAMPLE

Please enter the message you like to encrypt with the Keyword just given 
Hello world i will encrypt a message for you with your key: WE WILL ATTACK THE GERMANS ON THE FIFTH OF JUNE 1944 IN NORMANDY GOOD LUCK

>> Text To Encode Loaded into file
>> File Converted Into a String
>> Encoding with keyword: pennsylvania
>> Encoded.....
dyita knwkb gvxai tvppf zblpv onyni dsowz bmwxa zpmwk mnpun xaitv iuzwl ktzcs dymov sywaz
cndag zcwov xsnas awkof ahefq mfvtk t


5) YOU WILL BE PROMPT AGAIN

6) SELECT OPTION 2 OR 1 AGAIN TO ENCRYPT ANOTHER MESSAGE USING THE SAME KEY
6B) OPTION 2 SELECTED


Please Choose Option from above menu
2


Please Enter The message you like to decrypt with the Keyword just given 

6C) TRY TO REVERSE YOUR PREVIOUSE MESSAGE

Please Enter The message you like to decrypt with the Keyword just given 
dyita knwkb gvxai tvppf zblpv onyni dsowz bmwxa zpmwk mnpun xaitv iuzwl ktzcs dymov sywaz cndag zcwov xsnas awkof ahefq mfvtk t

>> Text To Decode Loaded into file
>> File Converted Into a String
>> Decoding with keyword: pennsylvania
>> Decoded:

helxl oworl diwil xlenc rypta messa gefor youwi tyour keywe wilxl atxta ckthe germa nsont hefif thofi unein norma ndygo odluc k

7) 3 FOR EXIT

Please Choose Option from above menu
3

Exiting Gracefully

Process finished with exit code .