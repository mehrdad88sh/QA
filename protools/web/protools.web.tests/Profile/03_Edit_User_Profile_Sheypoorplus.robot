*** Settings ***
Documentation                       ویرایش پروفایل کاربر شیپورپلاس
Resource                            ../../resources/resource.robot
Test Teardown                       Close Browser

*** Test Cases ***
Edit Free User Profile SheypoorPlus
  Login Protools                    شیپورپلاس
  Create Shop In Sheypoor           خودرو
  Back To Sheypoor Car Page
  Go To User Profile Page
  Go To Edit Profile Page
  Complete User Information
  Submit Profile Information
  Validate Gamification Scores
  Confirm Profile Image By Admin
  Back To Sheypoor Car Page
  Validate Profile Image In Profile Page

*** Keywords ***
Validate Profile Image In Profile Page
  Go To User Profile Page
  Go To Edit Profile Page
  Page Should Contain                 تصویر شما تایید شده است.

Complete User Information
  Add Image Profile
  Fill Profile Name
  Fill Location Job
