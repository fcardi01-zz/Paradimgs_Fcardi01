Franco Cardinali
Erlang Assignment 2014-2015
Valid For assignment of Paradigms for BSc
source absolutely used -->  J. Armstrong:  Programming Erlang software for a concurrent world


The Main Folder contains 2 files 

1) temp.erl 

This is the function that convert:
		a) Celsius to Fahrenheit
		b) Fahrenheit to Celsius
		
Along with an include test;

This was an interesting and much different assignment from Ruby and Scala. 
I have tried to keep it as much clear and simple as possible following the 
only book I found more useful that any another resource:

2) temperature_converter.erl which emulates Client/Server "messages passing"

To run it (command also in the erl files)


% Path to the File in My Project
1--> cd ("C:/Users/Franco/IdeaProjects/Messaging/src").

% Compile the erl FIle
2 --> c(temperature_converter).

% Process Created Ready Client/Server
3--> Control = temperature_converter:start().


% Some Examples To Run
temperature_converter:temp(Control , {c, 45}).
temperature_converter:temp(Control , {c, 113}).
temperature_converter:temp(Control , {f, 113}).
temperature_converter:temp(Control , {f, 235.4}).



