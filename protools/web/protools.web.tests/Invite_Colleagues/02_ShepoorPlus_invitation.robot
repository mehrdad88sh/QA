*** Settings ***
Documentation                         دعوت از همکاران شیپورپلاس
Resource                              ../../../../Resources/all.resource
Test Teardown                         Close Browser
Library    SeleniumLibrary

*** Test Cases ***
Invite Alunak Colleagues
  Login Protools                       شیپورپلاس
  Create Shop In Sheypoor              خودرو
  Back To Sheypoor Car Page
  Go To Invite Colleagues Page
  Invite A Colleagues
  Validate Invitation

*** Keywords ***
Go To Invite Colleagues Page
  Click By Text                        دعوت از همکاران
  Wait Until Page Contains             شماره تلفن همکار خود را در بالا وارد و ارسال کنید.

Invite A Colleagues
  Generate Random Consultant Phone
  Input Text                           name:cellphone     ${Random_consultant_Mobile}
  Click Element                        name:submit
  Wait Until Page Contains             لیست دعوت‌شدگان

Validate Invitation
  Click By Text                        لیست دعوت‌شدگان
  Wait Until Page Contains             در انتظار
  Click Button                         ${Close_Button}
