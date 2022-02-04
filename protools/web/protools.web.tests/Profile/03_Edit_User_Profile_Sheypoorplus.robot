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
  Confirm Profile Image By Admin
  Back To Sheypoor Car Page
  Go To User Profile Page
  Validate Gamification Scores

*** Keywords ***
Complete User Information
  Add Profile Image
  Fill Profile Name
  Fill Location Job
