*** Settings ***
Documentation                        ویرایش پروفایل حرفه ای آلونک
Resource                             ../../resources/resource.robot
Test Teardown                        Close Browser

*** Test Cases ***
Edit Premium User Profile
  Login Protools                     آلونک
  Create Shop In Sheypoor            املاک
  Check Premium Toggle In Admin
  Back To Protools Page
  Upgrade User To Premium Profile
  Go To Edit Profile Page
  Complete User Information
  Submit Profile Information
  Validate Gamification Scores
  Confirm Profile Image By Admin
  Back To Protools Page
  Validate Profile Image In Profile Page

*** Keywords ***
Validate Profile Image In Profile Page
  Go To User Profile Page
  Go To Edit Profile Page
  Page Should Contain                 تصویر شما تایید شده است.

Complete User Information
  Fill Profile Name
  Fill Telegram ID
  Fill Instagram ID
  Fill AboutMe
  Fill Consultant Specialty
  Add Profile Image
  Fill Location Job

Fill Consultant Specialty
  Click Element                      ${Consultant_Specialty}
  Wait Until Page Contains Element   ${Consultant_Specialty_Dropdown}
  FOR    ${INDEX}   IN RANGE  5
      Select Checkbox                css:[value="${INDEX}"]
      Checkbox Should Be Selected    css:[value="${INDEX}"]
  END
  Click Element                      name:select-add-action

Fill Telegram ID
  Input Text                         name:telegram                          Sheypoor

Fill Instagram ID
  Input Text                         name:instagram                         Sheypoor

Fill AboutMe
  Generate Random AboutMe Sentence
  Input Text                         ${aboutMe_ID}                          ${Random_AboutMe_Sentence}
