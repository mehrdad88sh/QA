*** Settings ***
Documentation                        ویرایش پروفایل حرفه ای
Resource                             ../../resources/resource.robot
Test Teardown                        Close Browser

*** Test Cases ***
Edit Premium User Profile
  Login Alunak
  Upgrade To Premium Profile
  # Go To Edit Profile Page
  # Complete User Information
  # Submit Profile Information
  # Validate Gamification Scores

*** Keywords ***
Upgrade To Premium Profile
  Click Element                       ${Premium_Button} 
  Page Should Contain                 ارتقاء پروفایل
  Wait Until Page Contains            ۱۵۰,۰۰۰ تومان
  Click Button                        پرداخت
  Wait Until Page Contains            درحال انتقال به درگاه پرداخت    timeout=2s
  Click Element                       class:button-bar
  Wait Until Page Contains            پرداخت شما با موفقیت انجام شد   timeout=2s
  Element Text Should Be              class:text-right                پروفایل حرفه‌ای
  Click Link                          بازگشت به برنامه
  Wait Until Page Contains            اعتبار پروفایل حرفه‌ای
