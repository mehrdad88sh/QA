*** Settings ***
Documentation                         دعوت از همکاران آلونک
Resource                              ../../../../Resources/all.resource
Test Teardown                         Close Browser

*** Test Cases ***
Invite Alunak Colleagues
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Back To Protools Page
  Go To Invite Colleagues Page
  Invite A Colleagues
  Validate Invitation

*** Keywords ***
Go To Invite Colleagues Page
  Click By Text                      دعوت از همکاران
  Wait Until Page Contains           با دعوت و اضافه شدن همکاران خود به جمع کاربران آلونک و کسب اولین امتیاز توسط آن‌ها، ۱۰۰ امتیاز از ما هدیه بگیرید.
  Set Selenium Speed                 0.5 seconds

Invite A Colleagues
  FOR   ${INDEX}   IN RANGE   3
    Generate Random Consultant Phone
    Input Text                       name:cellphone     ${Random_consultant_Mobile}
    Textfield Value Should Be        name:cellphone     ${Random_consultant_Mobile}
    Click Element                    name:submit
    Wait Until Page Contains         شماره تلفن همکار خود را در بالا وارد و ارسال کنید.
  END

Validate Invitation
  Click By Text                      لیست دعوت‌شدگان
  Wait Until Page Contains           در انتظار
  Click Button                       ${Close_Button}
