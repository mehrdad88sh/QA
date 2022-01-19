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
  Profile Image Validation In Profile Page
  Validate Gamification Scores


*** Keywords ***
Profile Image Validation In Profile Page
  Go To User Profile Page
  Go To Edit Profile Page
  Profile Image Status

Profile Image Status
  Image In Review Status
  Image Rejected Status
  Image Verified Status

Image In Review Status
  Wait Until Page Contains             تصویر بعد از تایید ادمین نمایش داده میشود.    timeout=3s
  Add Profile Image
  Wait Until Page Contains             تصویر بارگذاری شده و درحال بررسی است.         timeout=3s

Image Rejected Status
  Reject Profile Image By Admin
  Back To Protools Page
  Go To User Profile Page
  Go To Edit Profile Page
  Wait Until Page Contains             تصویر بارگذاری شده تایید نشد.                 timeout=3s

Image Verified Status
  Add Profile Image
  Confirm Profile Image By Admin
  Back To Protools Page
  Go To User Profile Page
  Go To Edit Profile Page
  Wait Until Page Contains             تصویر شما تایید شده است.                      timeout=3s
  Go To User Profile Page

Complete User Information
  Fill Profile Name
  Fill Location Job
