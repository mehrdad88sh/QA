*** Settings ***
Library                               SeleniumLibrary                  timeout=30s
Library                               Collections
Library                               String
Library                               FakerLibrary                     locale=fa_IR
Library                               splitwords
Library                               OperatingSystem
Variables                             ../variables/Variables.py

*** Variables ***
&{RealEstateType}                     RD=select-a68096                 BS=select-a68094
&{ApartmentID}                        RD=name:440477                   BS=name:440470
&{VilaID}                             RD=name:440479                   BS=name:440472
${Apartment}                          آپارتمان
${Vila}                               ویلا
${image_profile_path}                 ${CURDIR}/images/imageprofile.jpg
${images_Realestate_path}             ${CURDIR}/images
${profile_name_ID}                    name:profile-name
${edit_profile_ID}                    name:edit_profile
${aboutMe_ID}                         name:aboutMe
${Location_Job_ID}                    name:locations-trigger
${Search_Input_Location}              name:search-input-html
${Alborz_ID}                          css:[name="5"]
${Karaj_ID}                           css:[name="229"]
${Golshahr_ID}                        css:[name="n4005"]
${Submit_Button}                      name:form-submit-action
${Close_Button}                       name:close-action
${Add_New_Image}                      name:pick-image
${Sumbit_Image}                       name:accept-crop
${Your_Scores}                        name:score
${Rating}                             name:level
${Premium_Button}                     //*[@id="react-view"]/div/nav/div[2]/div/li/div/span

*** Keywords ***
Open Browser On Staging
  Open Browser                        ${staging}                       browser=chrome
  Maximize Browser Window
  Wait Until Page Contains            با ثبت نام در شیپور از مزایای کسب و کار اینترنتی بهره‌مند شوید       timeout=2s

Login Alunak
  Set Log Level                       trace
  Open Browser On Staging
  Click Element                       name:alounak
  Wait Until Page Contains            با آلونک کسب و کار خود را متحول کنید                                timeout=2s
  Click Element                       name:intro-action
  Wait Until Page Contains            ورود / ثبت‌نام                                                       timeout=2s
  Input Random Mobile
  Click Element                       name:submit
  Wait Until Page Contains            تائید شماره موبایل                                                  timeout=2s
  Get Code From Mock Server
  Input Verification Code
  Wait Until Page Contains Element    css:[role="document"]            timeout=2s
  ${Status}                           Run Keyword And Return Status    Wait Until Page Contains Element   ${Close_Button}     timeout=2s
  Run Keyword If                      ${Status}                        Click Button                       ${Close_Button}
  Wait Until Page Contains            در اینجا فایل خود را ثبت و مدیریت کنید.                             timeout=2s

Login Sheypoor Car
  Set Log Level                       trace
  Open Browser On Staging
  Click Element                       name:sheypoor-cars
  Wait Until Page Contains            با شیپور کسب و کار خود را متحول کنید                                timeout=2s
  Click Element                       name:intro-action
  Wait Until Page Contains            ورود / ثبت‌نام                                                       timeout=2s
  Input Random Mobile
  Click Element                       name:submit
  Wait Until Page Contains            تائید شماره موبایل                                                  timeout=2s
  Get Code From Mock server
  Input Verification Code
  Wait Until Page Contains Element    css:[role="document"]                                               timeout=2s
  ${Status}                           Run Keyword And Return Status    Wait Until Page Contains Element   ${Close_Button}
  Run Keyword If                      ${Status}                        Click Button                       ${Close_Button}
  Wait Until Page Contains            در اینجا فایل خود را ثبت و مدیریت کنید.                             timeout=2s

Input Random Mobile
  ${Random_Number}                    Generate Random String           7   [NUMBERS]
  Set Suite Variable                  ${Random_User_Mobile}            0900${Random_Number}
  Input Text                          name:cellphone                   ${Random_User_Mobile}

Get Code From Mock Server
  Execute Javascript                  window.open('${stagingMock}=${Random_User_Mobile}');
  Switch Window                       NEW
  ${mycode}                           Get Text                         css:pre
  ${mycode}                           Get Regexp Matches               ${mycode}     \\d{4}
  ${mycode}                           Convert To String                ${mycode[0]}
  ${mycode}                           split                            ${mycode}
  Set Suite Variable                  ${mycode}                        ${mycode}
  Close Window
  Switch Window                       MAIN

Input Verification Code
  Wait Until Page Contains Element    css:[tabindex="-1"]              timeout=2s
  FOR   ${INDEX}   IN RANGE   4
        @{Pincode}                    get WebElements                  class=pincode-input-text
        Input Text                    ${Pincode[${INDEX}]}             ${mycode[${INDEX}]}
  END
  Wait Until Page Contains Element    css:[tabindex="0"]               timeout=2s
  Click Element                       //*[@name='submit']/span[text()='تایید']

Set Location
  Click Element                       name:location-trigger
  Wait Until Page Contains Element    name:location-0                  timeout=2s
  Click Element                       ${Alborz_ID}
  Wait Until Page Contains Element    name:location-1                  timeout=2s
  Click Element                       ${Karaj_ID}
  Wait Until Page Contains Element    name:location-2                  timeout=2s
  ${search-input}                     Get WebElements                  ${Search_Input_Location}
  Input Text                          ${search-input}[2]               گلشهر
  Click Element                       ${Golshahr_ID}
  Element Should Contain              name:location                    کرج > گلشهر

Submit File
  Execute JavaScript                  window.scrollTo(0,0)
  Click Element                       ${Submit_Button}
  Wait Until Keyword Succeeds         3x  2s  Page Should Contain      فایل شما با موفقیت ثبت شد
  Click Element                       name:file-management-action
  Reload Page
  Wait Until Page Contains Element    css:[name="search-input-html"]   timeout=3s
  Page Should Contain Element         name:file-item-0

Go To Submit File Page
  Click Element                       name:list-item-new-file
  Wait Until Page Contains            انتخاب عکس‌های آگهی               timeout=2s
  Wait Until Page Contains Element    css:[tabindex="-1"]              timeout=2s

Select More Detail Button
  Click Element                       name:افزودن جزئیات بیشتر
  Wait Until Page Contains Element    css:[role="document"]            timeout=2s

Apply More Detail
  Click Button                        name:apply-action

Select Form Clear Button
  Wait Until Keyword Succeeds         3x   2s                          Click Element                      name:form-clear-action
  Wait Until Keyword Succeeds         3x   2s                          Wait Until Page Contains Element   css:[role="document"]      timeout=2s
  Wait Until Page Contains            از انصراف اطمینان دارید؟         timeout=2s
  Click Element                       name:confirm-accept-action

Generate Random username
  ${prefix_name}                      Prefix
  ${first_name}                       First Name
  ${last_name}                        Last Name
  Set Suite Variable                  ${Random_User_Name}              ${prefix_name} ${first_name} ${last_name}

Generate Random AboutMe Sentence
  ${aboutme}                          Sentence                         nb_words=30
  Set Suite Variable                  ${Random_AboutMe_Sentence}       ${aboutme}

Go To My Packages Page
  Click Element                       name:list-item-packageManagement
  Wait Until Page Contains            موجودی من                        timeout=2s

Upload RealEstate Images
  FOR                                 ${INDEX}   IN RANGE    4
   Execute JavaScript                 window.document.getElementsByName('select-images-action')[0].value='${EMPTY}'
   Choose File                        name:select-images-action        ${images_Realestate_path}/0${INDEX}.jpg
   Wait Until Page Does Not Contain Element                            name:image-upload-loading          timeout=20s
   Wait Until Keyword Succeeds        3x   2s  Check Trash Icon For Each Image                            ${INDEX+1}
  END

Check Trash Icon For Each Image
  [Arguments]                         ${count}
      ${TrashIcon}                    Get Element Count                name:form-delete-action
      ${Status}                       Should Be Equal                  ${count}       ${TrashIcon}

Successful Payment In Sheypoor
  [Arguments]                         ${Package_Type}
  Wait Until Page Contains            درحال انتقال به درگاه پرداخت     timeout=2s
  Click Element                       class:button-bar
  Wait Until Page Contains            پرداخت شما با موفقیت انجام شد.   timeout=2s
  Element Text Should Be              class:text-right                 ${Package_Type}
  Click Link                          بازگشت به برنامه

Go To User Profile Page
  Click Element                       ${profile_name_ID}
  Close Level Up Popup Message
  Wait Until Page Contains            عضو شیپور                        timeout=2s

Go To Edit Profile Page
  Click Element                       ${edit_profile_ID}
  Close Level Up Popup Message
  Wait Until Page Contains            اطلاعات شخصی                      timeout=2s

Add Image Profile
  ${choose_image_action}              Get WebElements                  name:choose-image-action
  Click Element                       ${choose_image_action}[1]
  Wait Until Page Contains            انتخاب تصویر                     timeout=2s
  Choose File                         ${Add_New_Image}                 ${image_profile_path}
  Wait Until Page Contains            ثبت عکس                          timeout=2s
  Click Element                       ${Sumbit_Image}
  Wait Until Page Contains            عکس شما با موفقیت ثبت شد         timeout=15s

Fill Profile Name
  Generate Random username
  Input Text                          name:name                        ${Random_User_Name}

Fill Location Job
  Go To Location Job
  Select Alborz Province
  Select Karaj City
  Select Multi Neighborhood Of Karaj
  Submit Selected Locations

Go To Location Job
  Click Element                       ${Location_Job_ID}
  Wait Until Page Contains Element                                     css:[role="document"]
  Page Should Contain                 انتخاب

Select Alborz Province
  Input Text                          ${Search_Input_Location}          البرز
  Click Element                       ${Alborz_ID}
  Wait Until Page Contains Element                                     ${Karaj_ID}

Select Karaj City
  Click Element                       ${Karaj_ID}
  Wait Until Page Contains Element                                     ${Golshahr_ID}

Select Multi Neighborhood Of Karaj
  Click Element                       css:[name="n3981"]               #باغستان
  Click Element                       css:[name="n3983"]               #جهانشهر
  Click Element                       css:[name="n4000"]               #عظیمیه
  Click Element                       css:[name="n4005"]               #گلشهر
  Click Element                       css:[name="n4011"]               #مهرویلا

Submit Selected Locations
  Click Element                       name:choose-selectedItems
  Element Should Contain              name:locations                   باغستان، جهانشهر، عظیمیه، گلشهر، مهرویلا

Submit Profile Information
  Click Element                       ${Submit_Button}
  Wait Until Page Contains            عضو شیپور                        timeout=2s

Validate Gamification Scores
  Click Element                       ${Your_Scores}
  Page Should Contain                 امتیاز برای تعریف نام پروفایل
  Page Should Contain                 امتیاز برای بارگذاری عکس پروفایل

Close Level Up Popup Message
  ${Status}                           Run Keyword And Return Status    Wait Until Page Contains Element   ${Close_Button}   timeout=2s
  Run Keyword If                      ${Status}                        Click Button                       ${Close_Button}

Upgrade User To Premium Profile
  Click Element                       ${Premium_Button}
  Page Should Contain                 ارتقاء پروفایل
  Wait Until Page Contains            ۱۵۰,۰۰۰ تومان                    timeout=2s
  Click Button                        پرداخت
  Successful Payment In Sheypoor      پروفایل حرفه‌ای
  Wait Until Page Contains            اعتبار پروفایل حرفه‌ای            timeout=2s
  Close Level Up Popup Message

Fill File Description
  ${File_Description}                 Sentence                         nb_words=30
  Input Text                          css:[name=description]           ${File_Description}
  Sleep    2s
