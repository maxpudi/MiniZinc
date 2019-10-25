


%%% define parameters %%%

int: l; % lower bound for negotiation set
int: u; % upper bound for negotiation set

int: m; %minimum strength threshold

enum NEGOTIATOR; %list of negotiators
NEGOTIATOR: dummy; 

%not sure abotu this one 
%dummy = D; 

array[NEGOTIATOR] of int: honor; %associated honors w negotiators

array[NEGOTIATOR, NEGOTIATOR] of int: joint; %pairwise joint strength



%%% define variables %%%
array[1..u] of var NEGOTIATOR: party;  %using array instead of subset
%var set of NEGOTIATOR: PARTY;

var int totalHonor = sum(p in party)(honor[p]);



% cardinality constraint, if selected once, it cant be slected again 

constraint forall( in SYMB)(sum(i in 1..size)(attacks[i] in group[s]) <= 1);


constraint forall(i in 1..size-1)(attacks[i] >= (attacks[i] != 0) + attacks[i+1]);

constraint sum(i,j in party where i < j)(joint[i,j]) >= m;
       
        
%%% define constraints %%%



constraint length(party) <= u;
%constraint card(party) <= u;

constraint length(party) >= l;
%constraint card(party) >= l;







%%% solve objective %%%

