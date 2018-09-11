/*
** Name: Sifan Xu
** UCID: 10146334
*/

/*
** Starter code for CPSC 449 Assignment #3
**
** Search for "Part <n>" to find the insertion points for the different
** parts of the assignment.
*/

/*
** Prerequisite information for non-computer science courses.
*/

prereqFor(data211, []).
prereqFor(data311, [data211 | [X]]) :-
  member(X, [data211, cpsc217, cpsc231, cpsc235, engg233]).
prereqFor(math211, []).
prereqFor(math213, []).
prereqFor(math249, []).
prereqFor(math265, []).
prereqFor(math267, [X]) :- member(X, [math249, math265, math275]).
prereqFor(math271, [X]) :- member(X, [math211, math213]).
prereqFor(math273, []).
prereqFor(math275, []).
prereqFor(math277, [math211, math275]).
prereqFor(math311, [X]) :- member(X, [math211, math213]).
prereqFor(math313, [math213]).
prereqFor(math315, [X]) :- member(X, [math271, math273]).
prereqFor(math331, [X, Y]) :- member(X, [math211, math213]), member(Y, [math267, math277]).
prereqFor(math376, [X]) :- member(X, [math267, math277]).
prereqFor(stat205, []).
prereqFor(stat213, []).
prereqFor(stat321, [X]) :- member(X, [math267, math277]).
prereqFor(phil279, []).
prereqFor(phil377, []).
prereqFor(encm335, [engg233]).
prereqFor(encm369, [enel353 | [X]]) :- member(X, [encm335, ensf337]).
prereqFor(ensf337, [engg233]).
prereqFor(engg233, []).
prereqFor(seng300, [X]) :- member(X, [cpsc319, cpsc331]).
prereqFor(enel353, X) :- member(X, [[admit_ENEL_or_ENSF], [cpsc233, math271]]).
prereqFor(admit_ENEL_or_ENSF, []).

/*
** Courses that require consent of the department should include consent
** followed by the course number in their prerequisite lists.
*/
prereqFor(consent235, []).
prereqFor(consent399, []).
prereqFor(consent499, []).
prereqFor(consent502, []).
prereqFor(consent503, []).
prereqFor(consent527, []).
prereqFor(consent528, []).
prereqFor(consent550, []).
prereqFor(consent568, []).
prereqFor(consent581, []).
prereqFor(consent585, []).
prereqFor(consent594, []).
prereqFor(consent598, []).
prereqFor(consent599, []).

/*
** Prerequisites for computer science courses that can only have their
** prerequisites satisfied in one way.
*/
prereqFor(cpsc203, []).
prereqFor(cpsc217, []).
prereqFor(cpsc231, []).
prereqFor(cpsc233, [cpsc231]).
prereqFor(cpsc235, [consent235]).
prereqFor(cpsc399, [consent399]).
prereqFor(cpsc405, [seng300]).
prereqFor(cpsc409, [cpsc355]).
prereqFor(cpsc499, [consent499]).
prereqFor(cpsc501, [cpsc449]).
prereqFor(cpsc502, [consent502]).
prereqFor(cpsc503, [consent503]).
prereqFor(cpsc511, [cpsc413]).
prereqFor(cpsc513, [cpsc313]).
prereqFor(cpsc517, [cpsc413]).
prereqFor(cpsc521, [cpsc313, cpsc449]).
prereqFor(cpsc522, [cpsc413]).
prereqFor(cpsc526, [cpsc441]).
prereqFor(cpsc527, [cpsc313, cpsc457, consent527]).
prereqFor(cpsc528, [cpsc313, cpsc457, consent528]).
prereqFor(cpsc550, [cpsc457, consent550]).
prereqFor(cpsc559, [cpsc441, cpsc457]).
prereqFor(cpsc561, [cpsc413]).
prereqFor(cpsc565, [cpsc433]).
prereqFor(cpsc567, [cpsc457, cpsc433]).
prereqFor(cpsc568, [cpsc433, consent568]).
prereqFor(cpsc571, [cpsc471]).
prereqFor(cpsc572, [cpsc571]).
prereqFor(cpsc575, [seng300]).
prereqFor(cpsc577, [cpsc453]).
prereqFor(cpsc581, [cpsc481, consent581]).
prereqFor(cpsc584, [cpsc481]).
prereqFor(cpsc585, [cpsc453, consent585]).
prereqFor(cpsc587, [cpsc453]).
prereqFor(cpsc589, [cpsc453]).
prereqFor(cpsc591, [cpsc453]).
prereqFor(cpsc594, [consent594]).
prereqFor(cpsc598, [consent598]).
prereqFor(cpsc599, [consent599]).

/*
** Part 1: Add rules for the other computer science courses here.  (I have
**         given you cpsc219 and cpsc331 to help you get started, and I have
**         given you cpsc530 because I noticed a very minor error in the
**         calendar).
*/
prereqFor(cpsc219, [X]) :- member(X, [cpsc217, data211]).
prereqFor(cpsc313, [M, P, C]) :-
  member(M, [math271, math273]),
  member(P, [phil279, phil377]),
  member(C, [cpsc219, cpsc233, cpsc235]).
prereqFor(cpsc319, [C]) :- member(C, [cpsc219, cpsc233, cpsc235, encm335, ensf337]).
prereqFor(cpsc329, [C]) :- member(C, [cpsc217, cpsc231, cpsc235, data211, engg233]).
prereqFor(cpsc331, [M, C]) :-
  member(M, [math271, math273]),
  member(C, [cpsc219, cpsc233, cpsc235]).
prereqFor(cpsc335, [C]) :- member(C, [cpsc319, cpsc331]).
prereqFor(cpsc355, [C]) :- member(C, [cpsc219, cpsc233, cpsc235]).
prereqFor(cpsc359, [C, P]) :-
  member(C, [cpsc355]),
  member(P, [phil279, phil377]).
prereqFor(cpsc411, [C]) :- member(C, [cpsc319, cpsc331]).
prereqFor(cpsc413, [C1, C2, M1, M2]) :-
  member(C1, [cpsc313]),
  member(C2, [cpsc331]),
  member(M1, [math211, math213]),
  member(M2, [math249, math265, math275]).
prereqFor(cpsc418, [C, M]) :-
  member(C, [cpsc331]),
  member(M, [math271, math273, math315]).
prereqFor(cpsc433, [C, P]) :-
  member(C, [cpsc313]),
  member(P, [phil279, phil377]).
prereqFor(cpsc441, [C1, C2]) :-
  member(C1, [cpsc319, cpsc331]),
  member(C2, [cpsc359, encm369]).
prereqFor(cpsc449, [C, P]) :-
  member(C, [cpsc319, cpsc331]),
  member(P, [phil279, phil377]).
prereqFor(cpsc453, [C, M1, M2]) :-
  member(C, [cpsc319, cpsc331]),
  member(M1, [math211, math213]),
  member(M2, [math267, math277]).
prereqFor(cpsc457, [C1, C2]) :-
  member(C1, [cpsc319, cpsc331]),
  member(C2, [cpsc359, encm369]).
prereqFor(cpsc461, [C1, C2]) :-
  member(C1, [cpsc355]),
  member(C2, [cpsc319, cpsc331]).
prereqFor(cpsc471, [C]) :- member(C, [cpsc319, cpsc331]).
prereqFor(cpsc481, [C]) :- member(C, [seng300, data311]).
prereqFor(cpsc491, [C, M1, M2]) :-
  member(C, [cpsc319, cpsc331]),
  member(M1, [math211, math213]),
  member(M2, [math249, math265, math275]).
prereqFor(cpsc518, [C, M]) :-
  member(C, [cpsc413]),
  member(M, [math211, math213]).
prereqFor(cpsc519, [C, M]) :-
  member(C, [cpsc413]),
  member(M, [math311, math313]).
prereqFor(cpsc525, [C, M]) :-
  member(C, [cpsc457]),
  member(M, [math271, math273]).
prereqFor(cpsc530, [C, M, S]) :-
  member(C, [cpsc219, cpsc233, cpsc235]),
  member(M, [math271, math273, math315]),
  member(S, [stat205]).
prereqFor(cpsc531, [C, S]) :-
  member(C, [cpsc457]),
  member(S, [stat205, stat213, stat321]).
prereqFor(cpsc535, [M]) :- member(M, [math311, math313, math331, math376]).
prereqFor(cpsc583, [C]) :- member(C, [cpsc319, cpsc331, data311]).


/*
** Note that the online calendar contains a very minor error in that stat213
** and stat321 aren't links when they should be.
*/
prereqFor(cpsc530, [X, Y, Z]) :-
  member(X, [cpsc219, cpsc233, cpsc235]),
  member(Y, [math271, math273, math315]),
  member(Z, [stat205, stat213, stat321]).

/*
** Additional Challenge
*/

prereqFor(graphics, Prereqs) :-
  member(M, [math267, math277]),
  member(C, [cpsc453]),
  member(A, [art231, art233, art235, art241, art349, art373, art377, art379, phys211, phys221, phys227]),
  sublist(X, [cpsc587, cpsc589, cpsc591]),
  length(X, Xlength),
  Xlength == 2,
  sublist(Y, [cpsc481, cpsc535, cpsc585, cpsc587, cpsc589, cpsc591, cpsc599]),
  length(Y, Ylength),
  Ylength == 2,
  append([M,C,A], X, Result),
  append(Result, Y, Prereqs).

/*
** Courses that are antirequisite to each other.
*/
antireqs([cpsc217, cpsc231, cpsc235, data211, engg233]).
antireqs([cpsc219, cpsc233, cpsc235]).
antireqs([cpsc319, cpsc331]).
antireqs([cpsc355, encm369]).
antireqs([cpsc441, enel573]).
antireqs([cpsc471, btma331]).
antireqs([cpsc491, engg407]).
antireqs([cpsc502, cpsc503]).
antireqs([math211, math213]).
antireqs([math249, math265, math275]).
antireqs([math267, math277]).
antireqs([math311, math313]).
antireqs([math318, cpsc418]).
antireqs([math331, math367, math377]).
antireqs([math335, math355]).
antireqs([math361, math313]).
antireqs([math375, math376]).
antireqs([math391, cpsc491]).
antireqs([stat205, stat213, stat217, stat327]).
antireqs([phil279, phil377]).
antireqs([ensf480, seng300]).
/*
** Math 271 and Math 273 aren't actually antirequisite to each other, but
** Math 271 is a valid prerequisite for every course under consideration in
** this assignment that has Math 273 as a prequisite.  As a result, there is
** never a circumstance where a student would need to make both of them.
** Marking them as antirequisite to each other (even though they technically
** aren't) ensures that we don't see both of them in the same result for
** Parts 3 and 4 of the assignment.
*/
antireqs([math271, math273]).

/*
** Part 2: Insert your implementation for allPrereqFor here
*/

/*
** allPrereqFor, where
**  Course is the course and AllPrereqsSorted is a list of all its direct and
**  indirect prerequisites
*/
allPrereqFor(Course, AllPrereqsSorted) :-
  prereqFor(Course, DirPrereq),
  allPrereqHelper(DirPrereq, IndPrereq),
  append(DirPrereq, IndPrereq, AllPrereq),
  sort(AllPrereq, AllPrereqsSorted).

/*
** allPrereqHelper, where
**   [Course|Courses] is a list of courses and Prereqs is a list of the
**   direct and indirect requisites of those courses
*/
allPrereqHelper([], []).
allPrereqHelper([Course|Courses], Prereqs) :-
  allPrereqFor(Course, A),
  allPrereqHelper(Courses, B),
  append(A, B, Prereqs).

/*
** Part 3: Insert your implementation for allPrereqFor_NoAnti here
*/

/*
** allPrereqFor_NoAnti, where
**   AllReq_NoAnti is a list of prerequisites for Course, excluding antirequisites
*/

allPrereqFor_NoAnti(Course, AllReq_NoAnti) :-
  allPrereqFor(Course, AllReq_NoAnti),
  \+ containsAnti(AllReq_NoAnti).

/*
** containsAnti, where
**   AllReq_NoAnti is a list of prerequisites and if it contains any pair A, B
**   where A, B are antirequisites, the rule will fail
*/
containsAnti(AllReq_NoAnti) :-
  member(A, AllReq_NoAnti),
  member(B, AllReq_NoAnti),
  A \= B,
  antireqs(AntiList),
  member(A, AntiList),
  member(B, AntiList).

/*
** Part 4: Insert your implementation for neededCourses here
*/

/*
** neededCourses, where
**   CoursesCompleted is a list of completed courses,
**   Course is a desire course to be taken,
**   and CoursesNeeded is a list of prerequisites for Course
*/
neededCourses(CoursesCompleted, Course, CoursesNeeded) :-
  allPrereqFor_NoAnti(Course, AllPrereqs),
  sort(CoursesCompleted, CoursesCompletedSorted),
  sublist(CoursesCompletedSorted, AllPrereqs),
  subtract(AllPrereqs, CoursesCompletedSorted, CoursesNeeded).

/*
** Additional Challenge
*/

/*
** neededCoursesCG, where
**   CoursesCompleted is a list of completed courses,
**   and CoursesNeeded is a list of prerequisites for a CG concentration
*/
neededCoursesCG(CoursesCompleted, CoursesNeeded) :-
  prereqFor(graphics, Prereqs),
  sort(Prereqs, PrereqsSorted),
  sort(CoursesCompleted, CoursesCompletedSorted),
  sublist(CoursesCompletedSorted, PrereqsSorted),
  subtract(PrereqsSorted, CoursesCompletedSorted, CoursesNeeded).
