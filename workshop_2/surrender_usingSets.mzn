


%-----------------------------------------------------------------------------------------------------------
%%% define parameters %%%

int: l; % lower bound for negotiation set
int: u; % upper bound for negotiation set

int: m; %minimum strength threshold

enum NEGOTIATOR; %list of negotiators
NEGOTIATOR: dummy; 

%not sure abouty this one 
%dummy = D; 
array[NEGOTIATOR] of int: honor; %associated honors w negotiators

array[NEGOTIATOR, NEGOTIATOR] of int: joint; %pairwise joint strength


%-----------------------------------------------------------------------------------------------------------
%%% define variables %%%
%array[1..u] of var NEGOTIATOR: party;  %using array instead of subset
var set of NEGOTIATOR: party;
var int: minhonor;

%var int totalHonor = sum(p in party)(honor[p]);

        
%-----------------------------------------------------------------------------------------------------------
%%% define constraints %%%

% upper bound cardinality definition
%constraint length(party) <= u;
constraint card(party) <= u;

% lower bound cardinality definition
%constraint length(party) >= l;
constraint card(party) >= l;

% threshold constraint, the sum of the strengths in our party must be greater than our minimum 
constraint sum(i,j in party where i < j)(joint[i,j]) >= m;

constraint minhonor = min([honor[i] | i in NEGOTIATOR where i in party]);

constraint not(dummy in party);
%-----------------------------------------------------------------------------------------------------------

%%% solve objective %%%
solve maximize minhonor;

output ["party = \(party) \nobj = \(minhonor)\n"]