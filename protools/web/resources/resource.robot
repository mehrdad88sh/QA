*** Settings ***
Library                               SeleniumLibrary                  timeout=30s
Library                               Collections
Library                               String
Library                               FakerLibrary                     locale=fa_IR
Library                               splitwords
Library                               OperatingSystem
Variables                             ../variables/Variables.py
Resource                              ../../../Resources/all.resource

*** Variables ***
&{RealEstateType}                     RD=select-a68096                 BS=select-a68094
&{ApartmentID}                        RD=name:440477                   BS=name:440470
&{VilaID}                             RD=name:440479                   BS=name:440472
${image_profile_path}                 ${CURDIR}/images/imageprofile.jpg
${images_Realestate_path}             ${CURDIR}/images

*** Keywords ***
Open Browser On Staging
  Open Browser                        chrome://version                 browser=chrome
  Maximize Browser Window
  Go To                               ${staging}/pro
  Wait Until Page Contains            با ثبت نام در شیپور از مزایای کسب و کار اینترنتی بهره‌مند شوید       timeout=10s

Login Protools
  [Arguments]                         ${Category_Type}
  Set Log Level                       trace
  Open Browser On Staging
    IF                                "${Category_Type}" == "آلونک"
    Click Element                     ${Alunak}
    Wait Until Page Contains          با آلونک کسب و کار خود را متحول کنید                                timeout=10s
    ELSE IF                           "${Category_Type}" == "شیپورپلاس"
    Click Element                     ${SheypoorCar}
    Wait Until Page Contains          با شیپور کسب و کار خود را متحول کنید                              timeout=10s
    END
  Click Element                       name:intro-action
  Wait Until Page Contains            ورود / ثبت‌نام                                                       timeout=10s
  Check Error Message For Wrong Phone Number
  Input Random Mobile
  Click Element                       name:submit
  Wait Until Page Contains            تائید شماره موبایل                                                  timeout=10s
  Get Code From Mock Server
  Input Verification Code
  Close Level Up Popup Message
  Reload Page
  Wait Until Page Contains            در اینجا فایل خود را ثبت و مدیریت کنید.                             timeout=10s

Check Error Message For Wrong Phone Number
  ${Wrong_Number}                     Generate Random String           12   [NUMBERS]
  Input Text                          name:cellphone                   ${Wrong_Number}
  Click Element                       name:submit
  Wait Until Page Contains            لطفا یک شماره تلفن صحیح وارد کنید
  Press Keys                          name:cellphone                   CTRL+a+DELETE

Input Random Mobile
  ${Random_Number}                    Generate Random String           7   [NUMBERS]
  Set Suite Variable                  ${Random_User_Mobile}            0900${Random_Number}
  Input Text                          name:cellphone                   ${Random_User_Mobile}

Get Code From Mock Server
  Execute Javascript                  window.open('${stagingMock}=${Random_User_Mobile}');
  Switch Window                       NEW
  Wait Until Page Contains Element    css:pre                          timeout=10s
  ${mycode}                           Get Text                         css:pre
  ${mycode}                           Get Regexp Matches               ${mycode}     \\d{4}
  ${mycode}                           Convert To String                ${mycode[0]}
  ${mycode}                           split                            ${mycode}
  Set Suite Variable                  ${mycode}                        ${mycode}
  Close Window
  Switch Window                       MAIN

Input Verification Code
  Wait Until Page Contains Element    css:[tabindex="-1"]              timeout=10s
  FOR   ${INDEX}   IN RANGE   4
        @{Pincode}                    get WebElements                  class=pincode-input-text
        Input Text                    ${Pincode[${INDEX}]}             ${mycode[${INDEX}]}
  END
  Wait Until Page Contains Element    css:[tabindex="0"]               timeout=10s
  Click Element                       //*[@name='submit']/span[text()='تایید']

Set Location
  Click Element                       name:location-trigger
  Wait Until Page Contains Element    name:location-0                  timeout=10s
  Click Element                       ${Alborz_ID}
  Wait Until Page Contains Element    name:location-1                  timeout=10s
  Click Element                       ${Karaj_ID}
  Wait Until Page Contains Element    name:location-2                  timeout=10s
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
  Wait Until Page Contains Element    css:[name="search-input-html"]   timeout=10s
  Page Should Contain Element         name:file-item-0

Go To Submit File Page
  Click Element                       name:list-item-new-file
  Wait Until Page Contains            انتخاب عکس‌های آگهی               timeout=10s
  Wait Until Page Contains Element    css:[tabindex="-1"]              timeout=10s

Select More Detail Button
  Click Element                       name:افزودن جزئیات بیشتر
  Wait Until Page Contains Element    css:[role="document"]            timeout=10s

Apply More Detail
  Click Button                        name:apply-action

Select Form Clear Button
  Wait Until Keyword Succeeds         3x   2s                          Click Element                      name:form-clear-action
  Wait Until Keyword Succeeds         3x   2s                          Wait Until Page Contains Element   css:[role="document"]      timeout=10s
  Wait Until Page Contains            از انصراف اطمینان دارید؟         timeout=10s
  Click Element                       ${Confirm_Button}

Go To My Packages Page
  Click Element                       ${My_Packages_Button}
  Wait Until Page Contains            خرید بسته                     timeout=10s

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
  Wait Until Page Contains            درحال انتقال به درگاه پرداخت     timeout=10s
  Click Element                       css:button.button.green
  Wait Until Page Contains            پرداخت شما با موفقیت انجام شد.   timeout=10s
  Element Should Contain              class:text-right                 ${Package_Type}
  Click Link                          بازگشت به برنامه

Go To User Profile Page
  Wait Until Page Contains Element    ${profile_name_ID}
  Click Element                       ${profile_name_ID}
  Close Level Up Popup Message
  Page Should Contain                 فعال در ${Company}              timeout=10s

Go To Edit Profile Page
  Click Element                       ${edit_profile_ID}
  Close Level Up Popup Message
  Wait Until Page Contains            اطلاعات شخصی                      timeout=10s

Add Image Profile
  Execute JavaScript                  window.scrollTo(0,0)
  ${choose_image_action}              Get WebElements                  name:choose-image-action
  Click Element                       ${choose_image_action}[1]
  Wait Until Page Contains            انتخاب تصویر                     timeout=10s
  Choose File                         ${Add_New_Image}                 ${image_profile_path}
  Wait Until Page Contains            ثبت عکس                          timeout=10s
  Click Element                       ${Sumbit_Image}
  Wait Until Page Contains            عکس شما با موفقیت ثبت شد، پس از بررسی توسط ادمین نمایش داده می‌شود         timeout=20s

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
  Execute JavaScript                  window.scrollTo(0,0)
  Click Element                       ${Submit_Button}
  Wait Until Page Contains            عضو شیپور                        timeout=10s

Validate Gamification Scores
  Execute JavaScript                  window.scrollTo(0,500)
  Click Element                       ${Your_Scores}
  Page Should Contain                 امتیاز برای تعریف نام پروفایل
  Page Should Contain                 امتیاز برای بارگذاری عکس پروفایل

Close Level Up Popup Message
  ${Status}                           Run Keyword And Return Status    Wait Until Page Contains Element   ${Close_Button}   timeout=10s
  Run Keyword If                      ${Status}                        Click Button                       ${Close_Button}

Upgrade User To Premium Profile
  Wait Until Page Contains Element    ${Premium_Button}                timeout=10s
  Click Element                       ${Premium_Button}
  Page Should Contain                 ارتقاء پروفایل
  Wait Until Page Contains            ۱۵۰,۰۰۰ تومان                    timeout=10s
  Click Button                        پرداخت
  Successful Payment In Sheypoor      پروفایل حرفه‌ای
  Wait Until Page Contains            اعتبار پروفایل حرفه‌ای            timeout=10s
  Close Level Up Popup Message

Fill File Description
  Press Keys                          name:description                 CTRL+a+DELETE
  ${File_Description}                 Sentence                         nb_words=20
  Set Suite Variable                  ${File_Description}
  Input Text                          css:[name=description]           ${File_Description}
  Element Should Contain              css:[name=description]           ${File_Description}

Open File And Check Images
  Click Element                       name:file-item-0
  Wait Until Page Contains            آگهی نشده                        timeout=10s
  FOR                                 ${INDEX}   IN RANGE    3
    Click Element                     name:next-slide
    Sleep    1s
  END
  Element Should Contain              class:slider-control-bottomcenter     ۴ از ۴

Go To File Bank Page
  Click Element                       ${File_Bank_Button}
  Wait Until Page Contains            خرید همراه فایل                  timeout=10s

Go To Team Management Page
  Click Element                       ${Team_Management_Menu}
  Wait Until Page Contains            افزودن همکار جدید

Go To My Requests Page
  Click Element                       ${My_Requests_Button}
  Wait Until Page Contains            ثبت درخواست مشتری
