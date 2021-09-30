*** Settings ***
Documentation                        ویرایش پروفایل حرفه ای آلونک
Resource                             ../../resources/resource.robot
Test Teardown                        Close Browser

*** Test Cases ***
Edit Premium User Profile
  Login Protools                     آلونک
  Create Shop In Sheypoor            املاک
  Check Premium Toggle In Admin
  Upgrade User To Premium Profile
  Go To Edit Profile Page
  Complete User Information
  Submit Profile Information
  Validate Gamification Scores

*** Keywords ***
Complete User Information
  Fill Profile Name
  Fill Telegram ID
  Fill Instagram ID
  Fill AboutMe
  Fill Consultant Specialty
  Add Image Profile
  Fill Location Job

Fill Consultant Specialty
  Click Element                      ${Consultant_Specialty}
  Wait Until Page Contains Element   ${Consultant_Specialty_Dropdown}
  FOR    ${INDEX}   IN RANGE  5
      Select Checkbox                css:[value="${INDEX}"]
      Checkbox Should Be Selected    css:[value="${INDEX}"]
  END

  Double Click Element               name:name

Fill Telegram ID
  Input Text                         name:telegram                          Sheypoor

Fill Instagram ID
  Input Text                         name:instagram                         Sheypoor

Fill AboutMe
  Generate Random AboutMe Sentence
  Input Text                         ${aboutMe_ID}                          ${Random_AboutMe_Sentence}

Check Premium Toggle In Admin
  Go To                              ${staging}/trumpet/features/search
  Wait Until Page Contains           قابلیت های عمومی
  Click By Text                      بستن / باز کردن همه
  Execute JavaScript                 window.scrollTo(0,1700)
  Wait Until Page Contains           امکان آپگرید کردن کاربران به پریمیوم
  FOR   ${INDEX}    IN RANGE    2
        ${Status}                          Run Keyword And Return Status
        ...                                Wait Until Page Contains Element       ${Inactive_Premium_Toggle}          timeout=3s
        Run Keyword If                     ${Status}
        ...                                Click Element                          ${Inactive_Premium_Toggle}
        Wait Until Page Contains Element   ${Active_Premium_Toggle}               timeout=3s
  Exit For Loop If                         ${Status} == False
  END
  Back To Protools Page
