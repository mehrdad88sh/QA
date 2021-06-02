*** Settings ***
Documentation                  ویرایش پروفایل رایگان
Resource                       ../../resources/resource.robot
Test Teardown                  Close Browser

*** Test Cases ***
Edit Free User Profile
  Login Alunak
  Go To User Profile Page
  Go To Edit Profile Page
  Complete User Information
  Submit Profile Information
  Validate Gamification Scores

*** Keywords ***
Go To User Profile Page
  Click Element                ${profile_name_ID}
  Close Level Up Popup Message
  Wait Until Page Contains     عضو شیپور                        timeout=2s

Go To Edit Profile Page
  Click Element                ${edit_profile_ID}
  Wait Until Page Contains     اطلاعات شخصی                      timeout=2s

Complete User Information
  Edit Image Profile
  Fill Profile Name
  Fill Location Job

Fill Profile Name
  Generate Random username
  Input Text                   name:name                        ${Random_User_Name}

Fill Location Job
  Go To Location Job
  Select Alborz Province
  Select Karaj City
  Select Multi Neighborhood Of Karaj
  Submit Selected Locations

Edit Image Profile
  ${choose_image_action}       Get WebElements                  name:choose-image-action
  Click Element                ${choose_image_action}[1]
  Wait Until Page Contains     انتخاب تصویر                     timeout=2s
  Choose File                  ${Add_New_Image}                 ${image_profile}
  Wait Until Page Contains     ثبت عکس                          timeout=2s
  Click Element                ${Sumbit_Image}
  Wait Until Page Contains     عکس شما با موفقیت ثبت شد         timeout=15s

Go To Location Job
  Click Element                ${Location_Job_ID}
  Wait Until Page Contains Element                              css:[role="document"]
  Page Should Contain          انتخاب

Select Alborz Province
  Input Text                   ${Search_Input_Location}         البرز
  Click Element                ${Alborz_ID}
  Wait Until Page Contains Element                              ${Karaj_ID}

Select Karaj City
  Click Element                ${Karaj_ID}
  Wait Until Page Contains Element                              ${Golshahr_ID}

Select Multi Neighborhood Of Karaj
  Click Element                css:[name="n3981"]               #باغستان
  Click Element                css:[name="n3983"]               #جهانشهر
  Click Element                css:[name="n4000"]               #عظیمیه
  Click Element                css:[name="n4005"]               #گلشهر
  Click Element                css:[name="n4011"]               #مهرویلا

Submit Selected Locations
  Click Element                name:choose-selectedItems
  Element Should Contain       name:locations                   باغستان، جهانشهر، عظیمیه، گلشهر، مهرویلا

Submit Profile Information
  Click Element                ${Submit_Button}
  Wait Until Page Contains     عضو شیپور                        timeout=2s

Validate Gamification Scores
  Click Element                ${Your_Scores}
  Page Should Contain          امتیاز برای تعریف نام پروفایل
  Page Should Contain          امتیاز برای بارگذاری عکس پروفایل

Close Level Up Popup Message
  ${Status}                    Run Keyword And Return Status   Wait Until Page Contains Element    ${Close_Button}   timeout=2s
  Run Keyword If               ${Status}                       Click Button                        ${Close_Button}
