-- Title: NumericTextFields
-- Name: Desmt MJ
-- Course: ICS2O/3C
-- This program...

--hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--sets the background colour
display.setDefault("background", 124/255, 249/255, 199/255)

-------------------------------------------------------------------------------------------
--LOCAL VARIABLES
-------------------------------------------------------------------------------------------

--create local variables
local questionObject
local correctObject
local numericField
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local incorrectAnswer

-------------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-------------------------------------------------------------------------------------------

local function AskQuestion()
    --generate 2 random numbers between a max. and a min. number
    randomNumber1 = math.random(0, 10)
    randomNumber2 = math.random(0, 10)

    correctAnswer = randomNumber1 + randomNumber2

-- create question in text object
    questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "

end

local function HideCorrect()
	correctObject.isVisible = false
	AskQuestion()
end

local function HideIncorrect()
	incorrectAnswer.isVisible = false
	AskQuestion()
end

local function NumericFieldListener( event )

-- User begins editing "numericField"
if ( event.phase == "began") then

	--clear text field
	event.target.text = ""

elseif event.phase == "submitted" then

	--when the answer is submitted (enyer key is pressed) set user inout to user's answer
	userAnswer = tonumber(event.target.text)

	--if the users answer and the correct answer are the same:
	   if (userAnswer == correctAnswer) then
		   correctObject.isVisible = true
		   timer.performWithDelay(1000, HideCorrect)
        else
        incorrectAnswer.isVisible = true
        timer.performWithDelay(1000,HideIncorrect)
	    end
    end
end

-------------------------------------------------------------------------------------------
--OBJECT CREATION
-------------------------------------------------------------------------------------------

--displays a question and sets the colour
questionObject = display.newText( "", display.contentWidth/3, display.contentHeight/2, nil, 50)
questionObject:setTextColor(155/255, 42/255, 198/255)

--create the correct text object and make it invisible
correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
correctObject:setTextColor(155/255, 42/255, 198/255)
correctObject.isVisible = false

--Create numeric field
numericField = native.newTextField( display.contentWidth/2, display.contentHeight/2, 150, 80 )
numericField.inputType = "number"

--create the correct text object and make it invisible
incorrectAnswer = display.newText( "Incorrect!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
incorrectAnswer:setTextColor(155/255, 42/255, 198/255)
incorrectAnswer.isVisible = false


--add the event listener for the numeric field
numericField:addEventListener( "userInput", NumericFieldListener)

------------------------------------------------------------------------------------------
--FUNCTION CALLS
------------------------------------------------------------------------------------------

--call the function to ask the question
AskQuestion()