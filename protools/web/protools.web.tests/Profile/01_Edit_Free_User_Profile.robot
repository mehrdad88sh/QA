*** Settings ***
Documentation                       ویرایش پروفایل رایگان آلونک
Resource                            ../../resources/resource.robot
Test Teardown                       Close Browser

*** Test Cases ***
Edit Free User Profile
  Login Protools                    آلونک
  Create Shop In Sheypoor           املاک
  Back To Protools Page
  Go To User Profile Page
  Go To Edit Profile Page
  Complete User Information
  Submit Profile Information
  Validate Gamification Scores

*** Keywords ***
Complete User Information
  Add Image Profile
  Fill Profile Name
  Fill Location Job
