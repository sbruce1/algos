\d .ascii
clear:{-1 "\033[2J\033[H"};
home:{-1 "\033[H"};
block:{"\033[48;5;",string[x],"m \033[0m"};
colours: 21 27 33 39 45 51 50 49 48 47 46 82 118 154 190 226 220 214 208 202 196;
greys:reverse 255 - til 24;
num2block:{[x;y] x "j"$y*-1+count x};
showMatrix:{-1 each raze@/:(block@/:)each x};
showGrey:{showMatrix num2block[greys;x]};
showColour:{showMatrix num2block[colours;x]};
\d .

/ showMatrix num2block[greys;](0 0.1 0.2;0.3 0.4 0.5; 0.6 0.7 0.8)
/ showMatrix num2block[colours;](0 0.1 0.2;0.3 0.4 0.5; 0.6 0.7 0.8)
