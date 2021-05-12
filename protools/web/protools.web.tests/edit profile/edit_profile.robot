*** Settings ***
Documentation                   ویرایش پروفایل رایگان
Resource                        ../../resources/resource.robot
Test Teardown                   Close Browser

*** Variables ***
${image_path}                   ${CURDIR}${/}..\/..\/resources\/images\/imageprofile.jpg

*** Test Cases ***
Edit Profile Frist Login
  Login Alunak
  Edit Profile

*** Keywords ***
Edit Profile
    Click Element               name=profile-name
    ${Status}                   Run Keyword And Return Status         Wait Until Page Contains Element    name=close-action   timeout=2s
    Run Keyword If              ${Status}==${TRUE}                    Click Button                        name=close-action
    Wait Until Page Contains    ویرایش پروفایل                        timeout=2s
    Click Element               name=edit_profile
    Wait Until Page Contains    اطلاعات شخصی                           timeout=2s
    ${prefix_male}=             Prefix
    ${first_name}=              First Name
    ${last_name}=               Last Name
    ${aboutme}=                 Sentence
    Input Text                  name=name                             ${prefix_male} ${first_name} ${last_name}
    Input Text                  name=aboutMe                          ${aboutme}
    ${choose_image_action}      Get WebElements                       name=choose-image-action
    Click Element               ${choose_image_action}[1]
    Wait Until Page Contains    افزودن تصویر جدید                     timeout=2s
    ${image_path}               Normalize Path                        ${image_path}
    Choose File                 name=pick-image                       ${image_path}
    Wait Until Page Contains    ثبت عکس                               timeout=2s
    Click Element               name=accept-crop
    Wait Until Page Contains    عکس شما با موفقیت ثبت شد              timeout=15s
    Click Element               name=form-submit-action
    Wait Until Page Contains    درباره من                             timeout=2s
