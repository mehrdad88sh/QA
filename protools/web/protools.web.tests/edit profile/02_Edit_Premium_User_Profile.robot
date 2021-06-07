*** Settings ***
Documentation                        ویرایش پروفایل حرفه ای
Resource                             ../../resources/resource.robot
Test Teardown                        Close Browser

*** Test Cases ***
Edit Premium User Profile
  Login Alunak
  Upgrade User To Premium Profile
  Go To Edit Profile Page
  Complete User Information
  # Submit Profile Information
  # Validate Gamification Scores

*** Keywords ***
Complete User Information
  Add Image Profile
  Fill Profile Name
  Fill Location Job
  Fill Telegram ID
  Fill Instagram ID
  Generate Random AboutMe Sentence

Fill Telegram ID
  Input Text    name:telegram    Sheypoor

Fill Instagram ID
  Input Text    name:instagram    Sheypoor   
