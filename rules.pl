:-[students_courses].

append_list( [], L, L).
append_list( [H|T], L2, [H|NT]):-
	append_list(T, L2, NT).
	
member_of(X, [H|T]) :- X = H; member_of(X, T).

removeHead([_|T],T).

%Task1
 
studentsInCourse(X,Y) :-
studentsInCourse(X,[],Y).

studentsInCourse(X,TmpList,Y):-
	student(Z,X,M),
	not(member_of([Z,M],TmpList)),!,
	append_list([[Z,M]],TmpList,NewTmpList),
	studentsInCourse(X,NewTmpList,Y).

studentsInCourse(_,Y,Y).

%Task2

numStudents(X,Y):-
    studentsInCourse(X,List),
	list_length(List,Y).


list_length(X,L) :- list_length(X,0,L) .

list_length( []     , L , L ) .
list_length( [_|X] , T , L ) :-
  T1 is T+1 ,
  list_length(X,T1,L).
  

%Task3

maxStudentGrade(X,Max):-
	maxStudentGrade(X,[],Y),
	list_max(Y,Max).
	

maxStudentGrade(X,TmpList,Y):-
	student(X,_,Z),
	not(member_of(Z,TmpList)),!,
	append_list([Z],TmpList,NewTmpList),
	maxStudentGrade(X,NewTmpList,Y).

maxStudentGrade(_,Y,Y).



list_max(X,L) :- list_max(X,0,L) .

list_max( []     , L , L ) .

list_max( [H|X] , T , L ) :-
  max(H,T,T1),
  list_max(X,T1,L).
  

max(X,Y,Z) :-
    (  X =< Y
    -> Z = Y
    ;  Z = X  
     ).



%Task4

gradeInWords(N,S,Digit):-
student(N,S,X),!,
M is X//10,
M =\= 10 ->
remainder(X,10,K),
getDigit([zero,one,two,three,four,five,six,seven,eight,nine],M,0,Y),
getDigit([zero,one,two,three,four,five,six,seven,eight,nine],K,0,Y1),
append_list([Y],[Y1],D),
singleDigit(D,Digit); append_list([one],[zero],D),
append_list(D,[zero],Digit).


singleDigit( [H|T] , Digit ) :-
	 H = 'zero'-> removeHead([H|T],Digit); append_list([],[H|T],Digit),!.

getDigit( [H|T] ,X,K, N ) :-
	X =\= K -> 
	K1 is K+1,
	getDigit(T,X,K1,N); N = H.
  

remainder(X,Y,Z):-
	X >= Y,!, 
	X1 is X-Y,
	remainder(X1,Y,Z); Z is X.

%Task5

remainingCourses(Y,X,List):-
	pCourses(X,L),
	rCourses(Y,L,List),!.

pCourses(X,Y) :-
pCourses(X,[],Y).

pCourses(X,TmpList,Y):-
	prerequisite(Z, X),
	not(member_of(Z,TmpList)),!,
	append_list([Z],TmpList,NewTmpList),
	pCourses(Z,NewTmpList,Y).

pCourses(_,Y,Y).

	
rCourses(Y,[H|T],L):-
 student(Y,H,G), G >=50,!,removeHead([H|T],L); rCourses(Y,T,L).





