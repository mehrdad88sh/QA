*** Settings ***
Documentation                       ویرایش پروفایل رایگان آلونک
Resource                            ../../resources/resource.robot
Test Teardown                       Close Browser

*** Test Cases ***
Edit Free User Profile Alounak
  Login Protools                    آلونک
  Create Shop In Sheypoor           املاک
  Back To Protools Page
  Go To User Profile Page
  Go To Edit Profile Page
  Complete User Information
  Submit Profile Information
  Validate Gamification Scores
  Confirm Profile Image By Admin
  Validate Profile Image In Profile Page


*** Keywords ***
Validate Profile Image In Profile Page
  Back To Protools Page
  Go To User Profile Page
  Go To Edit Profile Page
  Page Should Contain                 تصویر شما تایید شده است.

Complete User Information
  Add Image Profile
  Fill Profile Name
  Fill Location Job
