*** Settings ***
Documentation                        ویرایش پروفایل حرفه ای آلونک
Resource                             ../../resources/resource.robot
Test Teardown                        Close Browser

*** Test Cases ***
Edit Premium User Profile
  Login Protools                     آلونک
  Create Shop In Sheypoor            املاک
  Back To Protools Page
  Upgrade User To Premium Profile
  Go To Edit Profile Page
  Complete User Information
  Submit Profile Information
  Validate Gamification Scores

*** Keywords ***
Complete User Information
  Add Image Profile
  Fill Profile Name
  Fill Location Job
  Fill Telegram ID
  Fill Instagram ID
  Fill AboutMe

Fill Telegram ID
  Input Text                         name:telegram         Sheypoor

Fill Instagram ID
  Input Text                         name:instagram        Sheypoor

Fill AboutMe
  Generate Random AboutMe Sentence
  Input Text                         ${aboutMe_ID}         ${Random_AboutMe_Sentence}
