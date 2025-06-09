:- dynamic(student/1).
:- dynamic(course/1).
:- dynamic(room/1).
:- dynamic(has_course_list/2).
:- dynamic(requests_special_equipment/2).
:- dynamic(has_special_equipment/2).
:- dynamic(has_id/2).
:- dynamic(has_capacity/2).
:- dynamic(has_instructor/2).
:- dynamic(has_hour/2).
:- dynamic(has_operation_hours/3).
:- dynamic(has_room/2).

room(z10).
room(z23).
room(z6).
room(z2).

course(pl).
course(algo).
course(organization).
course(software).
course(course1).
course(course2).
course(course3).

instructor(yakup_genc).
instructor(didem_gozupek).
instructor(alp_arslan_bayrakci).
instructor(habil_kalkan).

student(student01).
student(student02).
student(student03).
student(student04).
student(student05).
student(student06).
student(student07).
student(student08).
student(student09).
student(student10).
student(student11).
student(student12).

special_equipment(projector).
special_equipment(smartboard).
special_equipment(access_for_the_handicapped).

has_course_list(student01, [algo, pl, course3]).
has_course_list(student02, [course2, course3]).
has_course_list(student03, [organization]).
has_course_list(student04, [algo, software]).
has_course_list(student05, [pl]).
has_course_list(student06, [organization, course2]).
has_course_list(student07, [pl, algo]).
has_course_list(student08, [algo, software]).
has_course_list(student09, [course2, course3]).
has_course_list(student10, [organization, pl, course3]).
has_course_list(student11, [organization, pl]).
has_course_list(student12, [software, course3]).

requests_special_equipment(student04, access_for_the_handicapped).
requests_special_equipment(student10, access_for_the_handicapped).
requests_special_equipment(student12, access_for_the_handicapped).
requests_special_equipment(habil_kalkan, projector).
requests_special_equipment(alp_arslan_bayrakci, smartboard).
requests_special_equipment(pl, projector).
requests_special_equipment(algo, smartboard).

has_special_equipment(z23, access_for_the_handicapped).
has_special_equipment(z6, access_for_the_handicapped).
has_special_equipment(z23, smartboard).
has_special_equipment(z6, projector).
has_special_equipment(z10, projector).

has_id(z10, 10).
has_id(z23, 23).
has_id(z6, 6).
has_id(z2, 2).
has_id(pl, 341).
has_id(algo, 321).
has_id(organization, 331).
has_id(software, 343).
has_id(course1, 301).
has_id(course2, 302).
has_id(course3, 303).
has_id(yakup_genc, 001).
has_id(didem_gozupek, 002).
has_id(alp_arslan_bayrakci, 003).
has_id(habil_kalkan, 004).
has_id(student01, 101).
has_id(student02, 102).
has_id(student03, 103).
has_id(student04, 104).
has_id(student05, 105).
has_id(student06, 106).
has_id(student07, 107).
has_id(student08, 108).
has_id(student09, 109).
has_id(student10, 110).
has_id(student11, 111).
has_id(student12, 112).

has_capacity(z10, 50).
has_capacity(z23, 200).
has_capacity(z6, 100).
has_capacity(z2, 20).
has_capacity(pl, 200).
has_capacity(algo, 150).
has_capacity(organization, 100).
has_capacity(software, 80).
has_capacity(course1, 20).
has_capacity(course2, 130).
has_capacity(course3, 50).

has_instructor(pl, yakup_genc).
has_instructor(course1, yakup_genc).
has_instructor(algo, didem_gozupek).
has_instructor(organization, alp_arslan_bayrakci).
has_instructor(software, habil_kalkan).
has_instructor(course2, habil_kalkan).
has_instructor(course3, habil_kalkan).

has_hour(pl,3).
has_hour(algo,4).
has_hour(organization,2).
has_hour(software,1).
has_hour(course1,4).
has_hour(course2,2).
has_hour(course3,3).

has_operation_hours(pl, 13, 16).
has_operation_hours(algo, 8, 12).
has_operation_hours(organization, 8, 10).
has_operation_hours(software, 12, 13).
has_operation_hours(course1, 11, 15).
has_operation_hours(course2, 11, 13).
has_operation_hours(course3, 14, 17).

has_room(pl, z23).
has_room(algo, z6).
has_room(organization, z23).
has_room(software, z23).
has_room(course1, z2).
has_room(course2, z23).
has_room(course3, z10).

%has_operation_hours(z23, 13, 16).

enroll_student(X, Course) :-
	has_room(Course, Room),
	requests_special_equipment(X, Equipment),
	has_special_equipment(Room, Equipment),
%	checks if the course capacity is exceeded
	format('~n~w is enrolled to ~w ~n~n', [X, Course]).

assign_room_to_course(Course) :-
	room(Room),
	has_capacity(Room, Room_capacity) >= has_capacity(Course, Course_capacity),
	has_instructor(Instructor, Course).
	has_special_equipment(Room, Instructor_equipment),
	requests_special_equipment(Instructor, Instructor_equipment),
	has_special_equipment(Room, Student_equipment),
	has_course(Student, Course),
	requests_special_equipment(Student, Student_equipment),
	format('~n~w is assigned to ~w ~n~n', [Course, Room]).

has_course(Student, Course) :-
	has_course_list(Student, Course_list),
	element(Course, Course_list).

add_student(X) :-
	student(X), format('A student named ~w already exists', [X]), !;
	format('~nEnter ~w\'s id ~n(put a dot at the end of it) ~n~n', [X]),
	read(Id),
	process_student_id(X, Id),
	nl, write('Is the student handicapped?'), nl, write('"y." for yes and "n." for no'), nl, nl,
	read(Handicapped),
	process_handicapped(X, Handicapped),
	assertz(student(X)), format('~nA student named ~w is added to the system ~n', [X]),
	process_course_list(X).

add_course(X) :-
	course(X), format('~nA course named ~w already exists', [X]), !;
	format('~nEnter ~w\'s id ~n(put a dot at the end of it) ~n~n', [X]),
	read(Id),
	process_course_id(X, Id),
	format('~nEnter ~w\'s instructor ~n(put a dot at the end of it) ~n~n', [X]),
	read(Instructor),
	process_instructor(X, Instructor),
	nl, write('Does the course need any special equipments?'), 
	nl, write('"p." for projector'),
	nl, write('"s." for smartboard'),
	nl, write('"a." for access for the handicapped'),
	nl, write('"ps." for projector and smartboard'),
	nl, write('"pa." for projector and access for the handicapped'),
	nl, write('"sa." for smartboard and access for the handicapped'),
	nl, write('"psa." for smartboard, projector and access for the handicapped'),
	nl, write('"n." for no'), nl, nl,
	read(Equipment),
	process_course_equipment(X, Equipment),
	format('~nEnter the capacity of ~w ~n(put a dot at the end of it) ~n~n', [X]),
	read(Capacity),
	process_capacity(X, Capacity),
	format('~nEnter the start time of ~w ~n~n(an integer between 8 and 17 (8 am - 5 pm))~n~n(put a dot at the end of it) ~n~n', [X]),
	read(Start),
	format('~nEnter the end time of ~w ~n~n(an integer between 8 and 17 (8 am - 5 pm))~n~n(put a dot at the end of it) ~n~n', [X]),
	read(End),
	process_hours(X, Start, End),
	assertz(course(X)), format('~nA course named ~w is added to the system ~n', [X]).

add_room(X) :-
	room(X), format('A room named ~w already exists', [X]), !;
	format('~nEnter ~w\'s id ~n(put a dot at the end of it) ~n~n', [X]),
	read(Id),
	process_room_id(X, Id),
	nl, write('Does the room have any special equipments?'), 
	nl, write('"p." for projector'),
	nl, write('"s." for smartboard'),
	nl, write('"a." for access for the handicapped'),
	nl, write('"ps." for projector and smartboard'),
	nl, write('"pa." for projector and access for the handicapped'),
	nl, write('"sa." for smartboard and access for the handicapped'),
	nl, write('"psa." for smartboard, projector and access for the handicapped'),
	nl, write('"n." for no'), nl, nl,
	read(Equipment),
	process_room_equipment(X, Equipment),
	format('~nEnter the capacity of ~w ~n(put a dot at the end of it) ~n~n', [X]),
	read(Capacity),
	process_capacity(X, Capacity),
	assertz(room(X)), format('~nA room named ~w is added to the system ~n', [X]).

process_course_list(X) :-
	Course_list = [],
	format('~nEnter the courses ~w takes one by one ~n(put a dot at the end of it) ~n~n(enter "x." after entering all the courses) ~n~n', [X]),
	read(Course),
	Course =\= 'x',
	course(Course),
	add_element(Course, Course_list),
	assertz(has_course_list(X, Course_list)),
	format('~n~w is added to ~w\'s course list ~n~n', [Course, X]),
	Course =:= 'x', !.

process_hours(X, Start, End) :-
	Hour is End - Start,
	Hour < 1, nl, write('Start hour should be less than end hour.'), nl, !, fail;
	Hour is End - Start,
	assertz(has_operation_hours(X, Start, End)), format('~n~w will be held between hours of ~w and ~w ~n', [X, Start, End]),
	assertz(has_hour(X, Hour)), format('~n~w will take ~w hour(s) ~n', [X, Hour]).

process_capacity(X, Capacity) :-
	Capacity >= 0,
	format('~nCapacity cannot be less than 1 ~n'), !, fail;
	assertz(has_capacity(X, Capacity)),
	format('~n~w\'s capacity is ~w ~n', [X, Capacity]).

process_instructor(X, Instructor) :-
	\+ (instructor(Instructor)),
	format('~nThere is not an instructor named ~w ~n', [Instructor]), !, fail;
	assertz(has_instructor(X, Instructor)),
	format('~n~w will teach ~w ~n', [Instructor, X]).

process_course_equipment(X, Equipment) :-
	Equipment = 'p',
	assertz(requests_special_equipment(X, projector)),
	format('~n~w will be held in a room that has a projector ~n~n', [X]);
	Equipment = 's',
	assertz(requests_special_equipment(X, smartboard)),
	format('~n~w will be held in a room that has a smartboard ~n~n', [X]);
	Equipment = 'a',
	assertz(requests_special_equipment(X, access_for_the_handicapped)),
	format('~n~w will be held in a room that has access for the handicapped ~n~n', [X]);
	Equipment = 'ps',
	assertz(requests_special_equipment(X, projector)),
	assertz(requests_special_equipment(X, smartboard)),
	format('~n~w will be held in a room that has a projector and a smartboard ~n~n', [X]);
	Equipment = 'pa',
	assertz(requests_special_equipment(X, projector)),
	assertz(requests_special_equipment(X, access_for_the_handicapped)),
	format('~n~w will be held in a room that has a projector and access for the handicapped ~n~n', [X]);
	Equipment = 'sa',
	assertz(requests_special_equipment(X, smartboard)),
	assertz(requests_special_equipment(X, access_for_the_handicapped)),
	format('~n~w will be held in a room that has a smartboard and access for the handicapped ~n~n', [X]);
	Equipment = 'psa',
	assertz(requests_special_equipment(X, projector)),
	assertz(requests_special_equipment(X, smartboard)),
	assertz(requests_special_equipment(X, access_for_the_handicapped)),
	format('~n~w will be held in a room that has a projector, a smartboard and access for the handicapped ~n~n', [X]);
	Equipment = 'n'.

process_room_equipment(X, Equipment) :-
	Equipment = 'p',
	assertz(has_special_equipment(X, projector)),
	format('~n~w will have a projector ~n~n', [X]);
	Equipment = 's',
	assertz(has_special_equipment(X, smartboard)),
	format('~n~w will have a smartboard ~n~n', [X]);
	Equipment = 'a',
	assertz(has_special_equipment(X, access_for_the_handicapped)),
	format('~n~w will have access for the handicapped ~n~n', [X]);
	Equipment = 'ps',
	assertz(has_special_equipment(X, projector)),
	assertz(has_special_equipment(X, smartboard)),
	format('~n~w will have a projector and a smartboard ~n~n', [X]);
	Equipment = 'pa',
	assertz(has_special_equipment(X, projector)),
	assertz(has_special_equipment(X, access_for_the_handicapped)),
	format('~n~w will have a projector and access for the handicapped ~n~n', [X]);
	Equipment = 'sa',
	assertz(has_special_equipment(X, smartboard)),
	assertz(has_special_equipment(X, access_for_the_handicapped)),
	format('~n~w will have a smartboard and access for the handicapped ~n~n', [X]);
	Equipment = 'psa',
	assertz(has_special_equipment(X, projector)),
	assertz(has_special_equipment(X, smartboard)),
	assertz(has_special_equipment(X, access_for_the_handicapped)),
	format('~n~w will have a projector, a smartboard and access for the handicapped ~n~n', [X]);
	Equipment = 'n'.

process_student_id(X, Id) :-
	has_id(Y, Id), format('There is already someone with the id ~w ~n', [Id]), !;
	assertz(has_id(X, Id)).

process_course_id(X, Id) :-
	has_id(Y, Id), format('There is already a course with the id ~w ~n', [Id]), !;
	assertz(has_id(X, Id)).

process_room_id(X, Id) :-
	has_id(Y, Id), format('There is already a room with the id ~w ~n', [Id]), !;
	assertz(has_id(X, Id)).

process_handicapped(X, Handicapped) :-
	Handicapped = 'y',
	assertz(requests_special_equipment(X, access_for_the_handicapped)),
	format('~n~w will be enrolled in a class that has access for the handicapped ~n~n', [X]);
	Handicapped = 'n'.

hours_clash(X, Y) :-
	has_operation_hours(X, A, B),
	has_operation_hours(Y, C, D),
	check_clash(A, B, C, D).

check_clash(A, B, C, D) :-
	A =:= C, !;
	B =:= D, !;
	first_check(A, B, C, D).

first_check(A, B, C, D) :-
	A > C,
	C > B, !;
	A < C,
	A > D, !.

scheduling_conflict_between(X, Y) :- 
	write('(prints "yes" if there is a scheduling conflict)'),
	has_room(X, C),
	has_room(Y, C),
	hours_clash(X, Y),
	format('~nThere is a scheduling conflict between ~w and ~w ~n~n', [X, Y]).

scheduling_conflict(A) :- 
	write('(prints "yes" if there is a scheduling conflict between any two courses)'),
	course(X),
	course(Y),
%	X =\= Y, // should exist but causes problems
	room(C),
	has_room(X, C),
	has_room(Y, C),
	hours_clash(X, Y),
	format('~nThere is a scheduling conflict between ~w and ~w ~n~n', [X, Y]).

element(L,[L|_]).
element(L,[_|T]) :- element(L,T). % returns 'yes' if the list has the item

add_element(L,T,T) :- element(L,T), !.
add_element(L,T,[L|T]). % adds the new item to the list if it isn't already in the list