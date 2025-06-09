flight(canakkale, erzincan, 6).
flight(erzincan, antalya, 3).
flight(antalya, izmir, 2).
flight(antalya, diyarbakir, 4).
flight(izmir, istanbul, 2).
flight(izmir, ankara, 6).
flight(istanbul, ankara, 1).
flight(ankara, diyarbakir, 8).
flight(istanbul, rize, 4).
flight(rize, ankara, 5).
flight(ankara, van, 4).
flight(van, gaziantep, 3).

% flight(X, Y, C) :- flight(Y, X, C). // results in an infinite loop but lack of this line causes the program to find longer routes

route(X, Y, C) :- 
	flight(X, Y, C). % program knows that there is a route from Y and X but not a flight
%	find_cost(costs, Cost),
%	format('~nThe cost is ~w~n~n', [Cost]).

route(X, Y, C) :- 
	flight(X, Z, A),
	format('from ~w to ~w with cost ~w ~n', [X, Z, A]),
%	add_element(Z, cities, cities) :- \+ (element(Z, cities)), // cities list stores the cities the route passes through
%	add_element(A, costs, costs), // costs list stores the cost of each flight
	route(Z, X, C).

route(X, Y, C) :- % this rule shouldn't exist but it's necessary for the program to work somewhat correctly
	flight(Y, Z, A),
	format('from ~w to ~w with cost ~w ~n', [Y, Z, A]),
	route(Z, X, C).

find_cost([],0).
find_cost([H|T], Cost) :- % finds the cost of the route by calculating the sum of all the flights
  	find_cost(T,Temp_cost),
  	Cost is H + Temp_cost.

element(L,[L|_]).
element(L,[_|T]) :- element(L,T). % returns 'yes' if the list has the item

add_element(L,T,T).
add_element(L,T,[L|T]). % adds the new item to the list