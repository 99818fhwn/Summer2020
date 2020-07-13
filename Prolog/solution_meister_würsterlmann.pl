/* Danger lies before you, while safety lies behind,
Two of us will help you, whichever you would find,
One among us seven will let you move ahead,
Another will transport the drinker back instead,
Two among our number hold only nettle wine,
Three of us are killers, waiting hidden in line.
Choose, unless you wish to stay here for evermore,
To help you in your choice, we give you these clues four:
First, however slyly the poison tries to hide
You will always find some on nettle wine’s left side;
Second, different are those who stand at either end,
But if you would move onwards, neither is your friend;
Third, as you see clearly, all are different size,
Neither dwarf nor giant holds death in their insides;
Fourth, the second left and the second on the right
Are twins once you taste them, though different at first sight.
*/

liquid(wine).
liquid(poison).
liquid(back).
liquid(onwards).

%Asume that a potion contains an liquid
assumption(X):- liquid(X).

%If there is wine it has to be a poison on the left next to it
poison([A,B,C,D,E,F,G]):-  nth0(N1,[A,B,C,D,E,F,G],poison), nth0(N2,[A,B,C,D,E,F,G],wine), N2 is N1 + 1,
    						nth0(N3,[A,B,C,D,E,F,G],poison), nth0(N4,[A,B,C,D,E,F,G],wine),  N2 \= N4, N4 is N3 + 1.
%Bottle 1 and bottle 7 have to be different.
different([A,_,_,_,_,_,G]):- assumption(A), assumption(G), A \= G.

%If you already moved onwards and you drink one of these you are done for, so it cant be onwaords which would the let you pass.
notfriend([onwards,_,_,_,_,_,G]):- assumption(G).
notfriend([A,_,_,_,_,_,onwards]):- assumption(A).

%Not the smalest nor the biggest bottle contains poison.
size([_,_,C,_,_,F,_]):- assumption(C), assumption(F), C \= poison, F \= poison.

%Bottle 2 and bottle 6 contain the same liquid.
twins([_,B,_,_,_,B,_]):- assumption(B).

%Solves the puzzle where the list is a position related bottle representation of liquids.
puzzle([A,B,C,D,E,F,G]):- poison([A,B,C,D,E,F,G]),different([A,B,C,D,E,F,G]), \+notfriend([A,B,C,D,E,F,G]), 
    						size([A,B,C,D,E,F,G]), twins([A,B,C,D,E,F,G]), count(poison,[A,B,C,D,E,F,G],3), 
    						count(onwards,[A,B,C,D,E,F,G],1), count(back,[A,B,C,D,E,F,G],1), 
    						count(wine,[A,B,C,D,E,F,G],2).

puzzle_without_picture([A,B,C,D,E,F,G]):- poison([A,B,C,D,E,F,G]),different([A,B,C,D,E,F,G]), \+notfriend([A,B,C,D,E,F,G]), 
    						twins([A,B,C,D,E,F,G]),
    						count(onwards,[A,B,C,D,E,F,G],1), 
    						count(poison,[A,B,C,D,E,F,G],3), 
    						count(back,[A,B,C,D,E,F,G],1), 
    						count(wine,[A,B,C,D,E,F,G],2).

count(_, [], 0).
count(X, [X | T], N) :- !,
    liquid(X),
  	count(X, T, N1),
 	N is N1 + 1.
count(X, [_ | T], N) :-
    liquid(X),
  	count(X, T, N).
