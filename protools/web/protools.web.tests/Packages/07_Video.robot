*** Settings ***
Documentation                         خرید بسته ویدئو و تخصیص آن به اعضای فروشگاه
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${video}                              ۱۰۰ عدد

*** Test Cases ***
Buy Consultant Video Package
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Go To Consultants List Page
  Validate Consultant Phone Number
  Go To Consultant Package Page
  Activate Video Package
  Validate Video Package In My Packages
  Find Phone Number And Name Of Team Members
  Assign Package To Secretary
  Assign Package To Consultant
  Remove Package From Secretary
  Remove Package From Consultant

*** Keywords ***
Go To Consultants List Page
  Go To                               ${Consultants_List_Page.format('${trumpet_env}')}

Validate Consultant Phone Number
  Input Text                          name:mobile                               ${Random_User_Mobile}
  Click Element                       ${Search_Button}
  Wait Until Page Contains Element    ${Consultant_Number}
  Element Text Should Be              ${Consultant_Number}                      ${Random_User_Mobile}
  Element Should Contain              ${Consultant_Status}                      فعال

Go To Consultant Package Page
  Wait Until Keyword Succeeds         3x    3s     Click By Text                بسته مشاور
  Wait Until Page Contains            ظرفیت آپلود ویدئو                         timeout=10s

Activate Video Package
  Click By Text                       ظرفیت آپلود ویدئو
  Checkbox Should Be Selected         ${CheckBox_Video}
  ${Input_Forms}                      Get WebElements                           css:input.form-control
  Input Text                          ${Input_Forms}[1]                         100
  Input Text                          ${Consultant_Package_Price}               50000
  Input Text                          ${Consultant_Package_Duration}            30
  Click Element                       ${Add_Button}
  Wait Until Page Contains            ۵۰۰۰۰                                     timeout=10s
  Click Element                       ${Activation_Button}
  Wait Until Page Contains            فعال‌‌سازی این بسته غیرقابل بازگشت خواهد بود. آیا از فعال‌سازی اطمینان دارید؟            timeout=10s
  Wait Until Keyword Succeeds         3x    3s     Click By Text                بله
  Wait Until Keyword Succeeds         3x    3s     Element Should Contain       ${Consultant_Package_Status}                  فعال شده
  Click Element                       ${Consultant_Package_Details}
  Wait Until Page Contains            ظرفیت آپلود ویدئو 100 عدد                 timeout=10s

Validate Video Package In My Packages
  Go To                               ${Test_Enviroment.format('${trumpet_env}')}/pro/real-estate/packages
  Wait Until Page Contains            این بسته به شما امکان آپلود ویدئو در فایل و آگهی را میدهد.                       timeout=10s
  Element Text Should Be              ${Video_Package_Number}                   ${video}

Find Phone Number And Name Of Team Members
  Register Manager With Alunak Api
  Get Code From Mock Server With Alunak Api
  Authorization Manager With Alunak Api
  Get List Of Members In Alunak Api

Assign Package To Secretary
  Execute JavaScript                  window.scrollTo(0,1000)
  Click Element                       name:${Secretary_Phone}_package
  Wait Until Page Contains            ${Secretary_Name}                         timeout=10s
  Element Should Contain              name:video-pick-number                    ۰
  Double Click Element                name:video-add
  Element Should Contain              name:video-pick-number                    ۲
  Wait Until Page Contains            ۲+                                        timeout=10s
  Click Element                       name:approved-action
  Wait Until Page Contains Element    name:${Secretary_Phone}-video_2           timeout=10s
  Element Should Contain              name:${Secretary_Phone}-video_2           2
  Wait Until Page Contains            ۹۸ عدد                                    timeout=10s
  Element Should Contain              ${Video_Package_Number}                   ۹۸ عدد

Assign Package To Consultant
  Click Element                       name:${Consultant_Phone}_package
  Wait Until Page Contains            ${Consultant_Name}                        timeout=10s
  Element Should Contain              name:video-pick-number                    ۰
  Double Click Element                name:video-add
  Element Should Contain              name:video-pick-number                    ۲
  Wait Until Page Contains            ۲+                                        timeout=10s
  Click Element                       name:approved-action
  ${Status}                           Run Keyword And Return Status             Wait Until Page Contains    در ارسال اطلاعات خطایی رخ داده است   timeout=10s
  Sleep    5s
  Run Keyword If                      ${Status}   Click Element                 name:approved-action
  Wait Until Page Contains Element    name:${Consultant_Phone}-video_2          timeout=10s
  Element Should Contain              name:${Consultant_Phone}-video_2          2
  Execute JavaScript                  window.scrollTo(0,0)
  Wait Until Page Contains            ۹۶ عدد                                    timeout=10s
  Element Should Contain              ${Video_Package_Number}                   ۹۶ عدد

Remove Package From Secretary
  Reload Page
  Wait Until Page Contains            این بسته به شما امکان آپلود ویدئو در فایل و آگهی را میدهد.                       timeout=10s
  Wait Until Page Contains Element    name:${Secretary_Phone}_package
  Execute JavaScript                  window.scrollTo(0,1000)
  Click Element                       name:${Secretary_Phone}_package
  Wait Until Page Contains            ${Secretary_Name}                         timeout=10s
  Element Should Contain              name:video-pick-number                    ۲
  Click Element                       name:video-remove
  Element Should Contain              name:video-pick-number                    ۱
  Wait Until Page Contains            ۱-                                        timeout=10s
  Click Element                       name:approved-action
  ${Status}                           Run Keyword And Return Status             Wait Until Page Contains    در ارسال اطلاعات خطایی رخ داده است   timeout=10s
  Sleep    3s
  Run Keyword If                      ${Status}   Click Element                 name:approved-action
  Wait Until Page Contains Element    name:${Secretary_Phone}-video_1           timeout=10s
  Element Should Contain              name:${Secretary_Phone}-video_1           1
  Wait Until Page Contains            ۹۷ عدد                                    timeout=10s
  Element Should Contain              ${Video_Package_Number}                   ۹۷ عدد

Remove Package From Consultant
  Reload Page
  Wait Until Page Contains            این بسته به شما امکان آپلود ویدئو در فایل و آگهی را میدهد.                       timeout=10s
  Wait Until Page Contains Element    name:${Consultant_Phone}_package
  Execute JavaScript                  window.scrollTo(0,1000)
  Click Element                       name:${Consultant_Phone}_package
  Wait Until Page Contains            ${Consultant_Name}                        timeout=10s
  Element Should Contain              name:video-pick-number                    ۲
  Click Element                       name:video-remove
  Element Should Contain              name:video-pick-number                    ۱
  Wait Until Page Contains            ۱-                                        timeout=10s
  Click Element                       name:approved-action
  ${Status}                           Run Keyword And Return Status             Wait Until Page Contains    در ارسال اطلاعات خطایی رخ داده است   timeout=10s
  Sleep    3s
  Run Keyword If                      ${Status}   Click Element                 name:approved-action
  Wait Until Page Contains Element    name:${Consultant_Phone}-video_1          timeout=10s
  Element Should Contain              name:${Consultant_Phone}-video_1          1
  Wait Until Page Contains Element    ${Video_Package_Number}                   timeout=10s
  Wait Until Page Contains            ۹۸ عدد                                    timeout=10s
  Element Should Contain              ${Video_Package_Number}                   ۹۸ عدد
