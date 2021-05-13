*** Settings ***
Library                               SeleniumLibrary
Library                               Collections
Library                               String
Library                               FakerLibrary                    locale=fa_IR
Library                               splitwords
Library                               OperatingSystem
Variables                             ../variables/Variables.py

*** Keywords ***
Open Browser On Staging
    Open Browser                      ${staging}                      browser=chrome
    Maximize Browser Window
    Wait Until Page Contains          با ثبت نام در شیپور از مزایای کسب و کار اینترنتی بهره‌مند شوید       timeout=2s

Login Alunak
  Set Log Level                       trace
  Open Browser On Staging
  Click Element                       name=alounak
  Wait Until Page Contains            با آلونک کسب و کار خود را متحول کنید
  Click Element                       name=intro-action
  Wait Until Page Contains            ورود / ثبت‌نام
  Input Random Mobile
  Click Element                       name=submit
  Wait Until Page Contains            تائید شماره موبایل
  Get Code From Mock Server
  Input Verification Code
  Wait Until Page Contains Element    css:[role="document"]            timeout=2s
  ${Status}                           Run Keyword And Return Status    Wait Until Page Contains Element   name=close-action
  Run Keyword If                      ${Status}==${TRUE}               Click Button                       name=close-action
  Wait Until Page Contains            در اینجا فایل خود را ثبت و مدیریت کنید.

Login Sheypoor Car
  Set Log Level                       trace
  Open Browser On Staging
  Click Element                       name=sheypoor-cars
  Wait Until Page Contains            با شیپور کسب و کار خود را متحول کنید
  Click Element                       name=intro-action
  Wait Until Page Contains            ورود / ثبت‌نام
  Input Random Mobile
  Click Element                       name=submit
  Wait Until Page Contains            تائید شماره موبایل
  Get Code From Mock server
  Input Verification Code
  Wait Until Page Contains Element    css:[role="document"]
  ${Status}                           Run Keyword And Return Status    Wait Until Page Contains Element  name=close-action
  Run Keyword If                      ${Status}==${TRUE}               Click Button                      name=close-action
  Wait Until Page Contains            در اینجا فایل خود را ثبت و مدیریت کنید.

Input Random Mobile
    ${Random_Number}                  Generate Random String           7   [NUMBERS]
    Set Suite Variable                ${Random_User_Mobile}            0900${Random_Number}
    Input Text                        name:cellphone                   ${Random_User_Mobile}

Get Code From Mock Server
   Execute Javascript                 window.open('${stagingMock}=${Random_User_Mobile}');
   Switch Window                      NEW
   ${mycode}                          Get Text                         css:pre
   ${mycode}                          Get Regexp Matches               ${mycode}     \\d{4}
   ${mycode}                          Convert To String                ${mycode[0]}
   ${mycode}                          split                            ${mycode}
   Set Suite Variable                 ${mycode}                        ${mycode}
   Close Window
   Switch Window                      MAIN

Input Verification Code
  Wait Until Page Contains Element    css:[tabindex="-1"]
  FOR   ${INDEX}   IN RANGE   4
        @{Pincode}                    get WebElements                  class=pincode-input-text
        Input Text                    ${Pincode[${INDEX}]}             ${mycode[${INDEX}]}
  END
  Wait Until Page Contains Element    css:[tabindex="0"]
  Click Element                       //*[@name='submit']/span[text()='تایید']

Set Location
  Click Element                       name:location-trigger
  Wait Until Page Contains Element    name:location-0                  #نمایش لیست استان ها
  Click Element                       name:8
  Wait Until Page Contains Element    name:location-1                  #نمایش لیست شهرها
  Click Element                       name:301
  Wait Until Page Contains Element    name:location-2                  #نمایش لیست محله ها
  ${search-input}                     Get WebElements                  name=search-input-html
  Input Text                          ${search-input}[2]               نارمک
  Click Element                       name:n4774                       #قنات کوثر
  Textfield Should Contain            name:location                   تهران > قنات کوثر

Submit File
  Execute JavaScript                  window.scrollTo(0,0)
  Click Element                       name:form-submit-action
  Wait Until Keyword Succeeds         3x  2s  Page Should Contain     فایل شما با موفقیت ثبت شد
  Click Element                       name:file-management-action
  Wait Until Page Contains Element    css:[name="search-input-html"]  timeout=2s
  Page Should Contain Element         name:file-item-0

Go To Submit File Page
  Click Element                       name:list-item-new-file
  Wait Until Page Contains            انتخاب عکس‌های آگهی
  Wait Until Page Contains Element    css:[tabindex="-1"]

Select More Detail Button
  Click Element                       name:افزودن جزئیات بیشتر
  Wait Until Page Contains Element    css:[role="document"]

Apply More Detail
  Click Button                        name:apply-action

Select Form Clear Button
  Wait Until Keyword Succeeds         3x   2s                           Click Element            name:form-clear-action
  Wait Until Page Contains Element    css:[role="document"]
  Wait Until Page Contains            از انصراف اطمینان دارید؟
  Click Element                       name:confirm-accept-action
  Page Should Contain Element         css:[tabindex="-1"]
