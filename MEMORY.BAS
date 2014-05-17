'This game tests your ability to memorize a sequence of numbers.
'Programmed by Carmen Alvarez and Benoit "BoD" Lubek.
'May 6, 2007, in Los Corrales de Buelna, Cantabria, Spain.

DECLARE SUB wrt (clr%, row%, value$)
DECLARE SUB printNum (num%)
DECLARE SUB print0 ()
DECLARE SUB print1 ()
DECLARE SUB print2 ()
DECLARE SUB print3 ()
DECLARE SUB print4 ()
DECLARE SUB print5 ()
DECLARE SUB print6 ()
DECLARE SUB print7 ()
DECLARE SUB print9 ()
DECLARE SUB printVertLine (x%, y%)
DECLARE SUB printHorizLine (x%, y%)
DECLARE SUB print8 ()
DECLARE SUB printTop ()
DECLARE SUB printMiddle ()
DECLARE SUB printBottom ()
DECLARE SUB printTopLeft ()
DECLARE SUB printTopRight ()
DECLARE SUB printBottomLeft ()
DECLARE SUB printBottomRight ()
DECLARE SUB correctsound ()
DECLARE SUB incorrectsound ()
DECLARE SUB game ()
DECLARE FUNCTION readguess% ()
DECLARE SUB init ()
DECLARE SUB show ()
DECLARE SUB fill ()

'number of numbers we will try to guess
DIM SHARED size AS INTEGER
size = 2

'when in expert mode, we only see one digit at a time
DIM SHARED expert AS INTEGER
DIM SHARED numbers(size) AS INTEGER

CLS

'start the game
CALL init
CALL game

SUB correctsound
SOUND 2000, 3
SOUND 1500, 3

END SUB

'redims the numbers array to the current size
'fills each element with a random number from 0 to 9
SUB fill
REDIM numbers(size)

FOR i% = 1 TO size
  numbers(i%) = RND * 9
NEXT i%

END SUB

'Main loop.
SUB game

'if cont is 1 then we have correctly repeated the sequence and
'we continue to the next level
cont = 1
WHILE cont = 1
  'populate the numbers array
  CALL fill
  'display the numbers
  CALL show
  'ask the user to repeat the sequence
  guess = readguess
  'if the user failed, let him try once more
  IF guess = 0 THEN
    CALL wrt(12, 13, "Incorrect, but try once again!")
    SLEEP 2
    'show the numbers again
    CALL show
    'let the user try again
    guess = readguess
    IF guess = 1 THEN
      cont = 1
    ELSE
      cont = 0
    END IF
  END IF
  'go to the next level
  size = size + 1

WEND
CLS
'if we get here, that means we screwed up.
'show the number of numbers correctly repeated
CALL wrt(12, 12, "Sorry, that was incorrect. You remembered up to " + LTRIM$(STR$(size - 2)) + " numbers.")
CALL wrt(10, 14, "Thanks for playing!")
COLOR 7
END SUB

SUB incorrectsound
SOUND 100, 2
SOUND 0, 1
SOUND 100, 4

END SUB

'Get the user's parameters:
'expert mode
'starting level
SUB init
'seed the random numbers
RANDOMIZE TIMER

'Ask the user which level he wants to start at
CLS
CALL wrt(13, 12, "Starting level? [2 - 10] ")
COLOR 7
INPUT "", size

'Ask the user if he wants to play in expert mode
CLS
CALL wrt(13, 12, "Expert mode? (y/n) ")
COLOR 7
INPUT "", ans$
IF ans$ = "y" THEN
  expert = 1
END IF
END SUB

SUB print0
CALL printTop
CALL printBottom
CALL printTopLeft
CALL printTopRight
CALL printBottomLeft
CALL printBottomRight

END SUB

SUB print1
CALL printTopRight
CALL printBottomRight
END SUB

SUB print2
CALL printTop
CALL printBottom
CALL printTopRight
CALL printBottomLeft
CALL printMiddle

END SUB

SUB print3

CALL printTop
CALL printBottom
CALL printTopRight
CALL printBottomRight
CALL printMiddle

END SUB

SUB print4
CALL printTopLeft
CALL printTopRight
CALL printBottomRight
CALL printMiddle

END SUB

SUB print5
CALL printTop
CALL printBottom
CALL printTopLeft
CALL printBottomRight
CALL printMiddle

END SUB

SUB print6
CALL printTop
CALL printBottom
CALL printTopLeft
CALL printBottomLeft
CALL printBottomRight
CALL printMiddle

END SUB

SUB print7
CALL printTop
CALL printTopRight
CALL printBottomRight

END SUB

SUB print8

CALL printTop
CALL printBottom
CALL printTopLeft
CALL printTopRight
CALL printBottomLeft
CALL printBottomRight
CALL printMiddle

END SUB

SUB print9
CALL printTop
CALL printBottom
CALL printTopLeft
CALL printTopRight
CALL printBottomRight
CALL printMiddle

END SUB

SUB printBottom
CALL printHorizLine(31, 24)
END SUB

SUB printBottomLeft
CALL printVertLine(29, 13)
END SUB

SUB printBottomRight
CALL printVertLine(51, 13)
END SUB

SUB printHorizLine (x%, y%)
LOCATE y%, x%
FOR i% = 1 TO 20
  PRINT "л";
NEXT i%
END SUB

SUB printMiddle
CALL printHorizLine(31, 12)
END SUB

SUB printNum (num%)

SELECT CASE num%
  CASE 0
    CALL print0
  CASE 1
    CALL print1
  CASE 2
    CALL print2
  CASE 3
    CALL print3
  CASE 4
    CALL print4
  CASE 5
    CALL print5
  CASE 6
    CALL print6
  CASE 7
    CALL print7
  CASE 8
    CALL print8
  CASE 9
    CALL print9
END SELECT
END SUB

SUB printTop
CALL printHorizLine(31, 1)

END SUB

SUB printTopLeft
CALL printVertLine(29, 1)
END SUB

SUB printTopRight
CALL printVertLine(51, 1)
END SUB

SUB printVertLine (x%, y%)

FOR i% = 0 TO 11
  LOCATE y% + i%, x%
  PRINT "лл";
NEXT i%

END SUB

'Read the user's attempt to repeat the sequence
FUNCTION readguess%

'Create a string of the sequence of numbers.
FOR i% = 1 TO size
  correctAnswer$ = correctAnswer$ + LTRIM$(STR$(numbers(i%)))
NEXT i%

'The user will attempt to repeat the sequence of numbers
LOCATE 12, 39 - size / 2
COLOR 5
PRINT "> ";
COLOR 11
INPUT "", guess$

'res is 1 if the guess was correct
IF guess$ <> correctAnswer$ THEN
  res% = 0
  CALL incorrectsound
ELSE
  res% = 1
  CALL correctsound
  CALL wrt(10, 13, "Correct!")
  SLEEP 1
END IF

'return value
readguess% = res%
END FUNCTION

'Display the sequence of numbers.
'In expert mode, only one number is shown at a time
'otherwise, the whole sequence is shown
SUB show
CLS
'Determine the position on the screen to show the sequence
IF size > 80 THEN
  x% = 0
ELSE
  x% = 40 - size / 2
END IF
LOCATE 12, x%
COLOR 15

FOR i% = 1 TO size
  IF expert = 1 THEN
    'One big number at a time in expert mode
    CLS
    COLOR RND * 6 + 9
    CALL printNum(numbers(i%))
  ELSE
    'Add this number to the displayed sequence in normal mode
    PRINT LTRIM$(STR$(numbers(i%)));
  END IF
  SLEEP 1
NEXT i%

CLS

END SUB

'Display a line of text at the given row in the screen,
'centered horizontally and in the given color
'
SUB wrt (clr%, row%, text$)
x% = 40 - LEN(text$) / 2
COLOR clr%
LOCATE row%, x%
PRINT text$;
END SUB

