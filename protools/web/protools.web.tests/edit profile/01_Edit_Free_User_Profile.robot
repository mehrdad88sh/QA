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
  Click Element                name:profile-name
  ${Status}                    Run Keyword And Return Status   Wait Until Page Contains Element    name:close-action   timeout=2s
  Run Keyword If               ${Status}                       Click Button                        name:close-action
  Wait Until Page Contains     عضو شیپور                       timeout=2s

Go To Edit Profile Page
  Click Element                name:edit_profile
  Wait Until Page Contains     اطلاعات شخصی                     timeout=2s

Complete User Information
  Fill Profile Name
  Fill About Me
  Fill Location Job
  Edit Image Profile

Fill Profile Name
  ${prefix_male}               Prefix
  ${first_name}                First Name
  ${last_name}                 Last Name
  Input Text                   name:name                        ${prefix_male} ${first_name} ${last_name}

Fill About Me
  ${aboutme}                   Sentence
  Input Text                   name:aboutMe                     ${aboutme}

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
  Choose File                  name:pick-image                  ${image_profile}
  Wait Until Page Contains     ثبت عکس                          timeout=2s
  Click Element                name:accept-crop
  Wait Until Page Contains     عکس شما با موفقیت ثبت شد         timeout=15s

Go To Location Job
  Click Element                name:locations-trigger
  Wait Until Page Contains Element                              css:[role="document"]
  Page Should Contain          انتخاب

Select Alborz Province
  Input Text                   name:search-input-html           البرز
  Click Element                css:[name="5"]
  Wait Until Page Contains Element                              css:[name="229"]

Select Karaj City
  Click Element                css:[name="229"]
  Wait Until Page Contains Element                              css:[name="n6975"]

Select Multi Neighborhood Of Karaj
  Click Element                css:[name="n3981"]
  Click Element                css:[name="n3983"]
  Click Element                css:[name="n4000"]
  Click Element                css:[name="n4005"]
  Click Element                css:[name="n4011"]

Submit Selected Locations
  Click Element                name:choose-selectedItems
  Element Should Contain       name:locations                   باغستان، جهانشهر، عظیمیه، گلشهر، مهرویلا

Submit Profile Information
  Click Element                name:form-submit-action
  Wait Until Page Contains     عضو شیپور                        timeout=2s
  Page Should Contain          محدوده کاری                      timeout=2s
  Page Should Contain          درباره من                        timeout=2s

Validate Gamification Scores
  Click Element               name:score
  Page Should Contain         امتیاز برای تعریف نام پروفایل
  Page Should Contain         امتیاز برای بارگذاری عکس پروفایل
