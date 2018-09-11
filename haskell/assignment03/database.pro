%% I SEEM TO HAVE AN ERROR IN MY DATABASE
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
prereqFor(cpsc481, [C]) :- member(C, [seng300, seng301, data311]).
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