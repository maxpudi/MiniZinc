


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
array[1..u] of var NEGOTIATOR: party;  %using array instead of subset
%var set of NEGOTIATOR: party;
var int: obj;

%var int totalHonor = sum(p in party)(honor[p]);

        
%-----------------------------------------------------------------------------------------------------------
%%% define constraints %%%


% upper bound cardinality definition
%constraint length(party) <= u;
%constraint card(party) <= u;

% lower bound cardinality definition

%constraint sum(i in 1..u)(party[i] != 0) >= l;
%first l elements are not dummy (at least "l" negotiators 
constraint forall(i in 1..l)(party[i] > dummy);

%define uniqueness by removing symmmetric combos
%decreasing but can use zero 
constraint forall(i in 1..u-1)(party[i] >= party[i+1] + (party[i] != dummy));


% threshold constraint, the sum of the strengths in our party must be greater than our minimum 
constraint sum(i, j in 1..u where i < j)(joint[party[i], party[j]]) >= m;

%constraint not(dummy in party);

%define obj as constraint for output
constraint obj = (min(i in 1..u)(honor[party[i]]  +  (party[i] = dummy) * (max(honor) + 1)));


%-----------------------------------------------------------------------------------------------------------

%%% solve objective %%%
solve maximize obj;

/*
array[1..n] of var OBJx: s; %% actual decision variables 
set of OBJx: os :: output_only %% remove the dummy value
= { fix(s[i]) | i in 1..n } diff { dummy };
*/

%array[1..n] of var NEGOTIATOR: ; %% actual decision variables 
set of NEGOTIATOR: os :: output_only = { fix(party[i]) | i in 1..u } diff {dummy};


output ["party = \(os) \nobj = \(obj)\n"]