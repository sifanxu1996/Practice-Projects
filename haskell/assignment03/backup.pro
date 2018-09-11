neededCoursesCG([math267, cpsc587, cpsc589, cpsc481, cpsc535, art231], X).

      2    2  Exit: prereqFor(graphics,[math267,cpsc453,cpsc587,cpsc589,cpsc481,cpsc535,art231]) ?
     12    2  Call: sort([math267,cpsc453,cpsc587,cpsc589,cpsc481,cpsc535,art231],_461) ?
     12    2  Exit: sort([math267,cpsc453,cpsc587,cpsc589,cpsc481,cpsc535,art231],[art231,cpsc453,cpsc481,cpsc535,cpsc587,cpsc589,math267]) ?
     13    2  Call: sort([math267,cpsc587,cpsc589,cpsc481,cpsc535,art231],_500) ?
     13    2  Exit: sort([math267,cpsc587,cpsc589,cpsc481,cpsc535,art231],[art231,cpsc481,cpsc535,cpsc587,cpsc589,math267]) ?
     14    2  Call: sublist([art231,cpsc481,cpsc535,cpsc587,cpsc589,math267],[art231,cpsc453,cpsc481,cpsc535,cpsc587,cpsc589,math267]) ?
     14    2  Exit: sublist([art231,cpsc481,cpsc535,cpsc587,cpsc589,math267],[art231,cpsc453,cpsc481,cpsc535,cpsc587,cpsc589,math267]) ?
     15    2  Call: subtract([art231,cpsc453,cpsc481,cpsc535,cpsc587,cpsc589,math267],[art231,cpsc481,cpsc535,cpsc587,cpsc589,math267],_54) ?
     15    2  Exit: subtract([art231,cpsc453,cpsc481,cpsc535,cpsc587,cpsc589,math267],[art231,cpsc481,cpsc535,cpsc587,cpsc589,math267],[cpsc453]) ?
      1    1  Exit: neededCoursesCG([math267,cpsc587,cpsc589,cpsc481,cpsc535,art231],[cpsc453]) ?



      2    2  Exit: prereqFor(graphics,[math267,cpsc453,cpsc587,cpsc589,cpsc535,cpsc481,art231]) ?
     12    2  Call: sort([math267,cpsc453,cpsc587,cpsc589,cpsc535,cpsc481,art231],_461) ?
     12    2  Exit: sort([math267,cpsc453,cpsc587,cpsc589,cpsc535,cpsc481,art231],[art231,cpsc453,cpsc481,cpsc535,cpsc587,cpsc589,math267]) ?
     13    2  Call: sort([math267,cpsc587,cpsc589,cpsc481,cpsc535,art231],_500) ?
     13    2  Exit: sort([math267,cpsc587,cpsc589,cpsc481,cpsc535,art231],[art231,cpsc481,cpsc535,cpsc587,cpsc589,math267]) ?
     14    2  Call: sublist([art231,cpsc481,cpsc535,cpsc587,cpsc589,math267],[art231,cpsc453,cpsc481,cpsc535,cpsc587,cpsc589,math267]) ?
     14    2  Exit: sublist([art231,cpsc481,cpsc535,cpsc587,cpsc589,math267],[art231,cpsc453,cpsc481,cpsc535,cpsc587,cpsc589,math267]) ?
     15    2  Call: subtract([art231,cpsc453,cpsc481,cpsc535,cpsc587,cpsc589,math267],[art231,cpsc481,cpsc535,cpsc587,cpsc589,math267],_54) ?
     15    2  Exit: subtract([art231,cpsc453,cpsc481,cpsc535,cpsc587,cpsc589,math267],[art231,cpsc481,cpsc535,cpsc587,cpsc589,math267],[cpsc453]) ?
      1    1  Exit: neededCoursesCG([math267,cpsc587,cpsc589,cpsc481,cpsc535,art231],[cpsc453]) ?
