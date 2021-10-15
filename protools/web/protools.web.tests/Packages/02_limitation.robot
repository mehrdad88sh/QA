*** Settings ***
Documentation                         خرید بسته ظرفیت تعداد آگهی و تخصیص آن به اعضای فروشگاه
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${limitation}                         ۱۰ بسته

*** Test Cases ***
Buy Limitation Package
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Back To Protools Page
  Go To My Packages Page
  Select Limitation Package
  Compare Selected Package With its Price
  Successful Payment In Sheypoor      بسته‌ی هیبریدی: ظرفیت ثبت آگهی
  Validation Packages In Protools
  Find Phone Number And Name Of Team Members
  Assign Package To Secretary
  Assign Package To Consultant
  Remove Package From Secretary
  Remove Package From Consultant

*** Keywords ***
Select Limitation Package
  Click Button                        ${PackageـPurchase_Button}
  Wait Until Page Contains Element    ${Limitation_Package_Name}               timeout=10s
  Click Element                       ${Limitation_Package_Name}
  Wait Until Page Contains            پرداخت ۴۵,۰۰۰ تومان

Compare Selected Package With its Price
  ${Limitation_Price}                 Get WebElements                          ${Limitation_Package_Price}
  ${Price_After_Discount}             Get Text                                 ${Limitation_Price}[1]
  ${Price_In_Button}                  Get Text                                 ${Submit_Button}
  Should Be Equal                     پرداخت ${Price_After_Discount} تومان     ${Price_In_Button}
  Click Element                       ${Submit_Button}

Validation Packages In Protools
  Wait Until Page Contains            این بسته به شما امکان ثبت آگهی بیشتر از سقف تعداد آگهی را میدهد            timeout=10s
  Element Text Should Be              ${Limitation_Package_Number}             ${limitation}

Find Phone Number And Name Of Team Members
  Register Manager With Alunak Api
  Get Code From Mock Server With Alunak Api
  Authorization Manager With Alunak Api
  Get List Of Members In Alunak Api

Assign Package To Secretary
  Execute JavaScript                  window.scrollTo(0,1000)
  Click Element                       name:${Secretary_Phone}_package
  Wait Until Page Contains            ${Secretary_Name}                         timeout=10s
  Double Click Element                name:limitation-add
  Wait Until Page Contains            ۲+                                        timeout=10s
  Click Element                       name:approved-action
  Wait Until Page Contains Element    name:${Secretary_Phone}-limitation_2      timeout=10s
  Element Should Contain              name:${Secretary_Phone}-limitation_2      2
  Wait Until Page Contains            ۸ بسته                                    timeout=10s
  Element Should Contain              ${Limitation_Package_Number}              ۸ بسته

Assign Package To Consultant
  Click Element                       name:${Consultant_Phone}_package
  Wait Until Page Contains            ${Consultant_Name}                        timeout=10s
  Double Click Element                name:limitation-add
  Wait Until Page Contains            ۲+                                        timeout=10s
  Click Element                       name:approved-action
  ${Status}                           Run Keyword And Return Status             Wait Until Page Contains    در ارسال اطلاعات خطایی رخ داده است   timeout=10s
  Sleep    5s
  Run Keyword If                      ${Status}   Click Element                 name:approved-action
  Wait Until Page Contains Element    name:${Consultant_Phone}-limitation_2     timeout=10s
  Element Should Contain              name:${Consultant_Phone}-limitation_2     2
  Execute JavaScript                  window.scrollTo(0,0)
  Wait Until Page Contains            ۶ بسته                                    timeout=10s
  Element Should Contain              ${Limitation_Package_Number}              ۶ بسته

Remove Package From Secretary
  Reload Page
  Wait Until Page Contains            این بسته به شما امکان ثبت آگهی بیشتر از سقف تعداد آگهی را میدهد     timeout=10s
  Wait Until Page Contains Element    name:${Secretary_Phone}_package
  Execute JavaScript                  window.scrollTo(0,1000)
  Click Element                       name:${Secretary_Phone}_package
  Wait Until Page Contains            ${Secretary_Name}                         timeout=10s
  Click Element                       name:limitation-remove
  Wait Until Page Contains            ۱-                                        timeout=10s
  Click Element                       name:approved-action
  ${Status}                           Run Keyword And Return Status             Wait Until Page Contains    در ارسال اطلاعات خطایی رخ داده است   timeout=10s
  Sleep    3s
  Run Keyword If                      ${Status}   Click Element                 name:approved-action
  Wait Until Page Contains Element    name:${Secretary_Phone}-limitation_1      timeout=10s
  Element Should Contain              name:${Secretary_Phone}-limitation_1      1
  Wait Until Page Contains            ۷ بسته                                    timeout=10s
  Element Should Contain              ${Limitation_Package_Number}              ۷ بسته

Remove Package From Consultant
  Reload Page
  Wait Until Page Contains            این بسته به شما امکان ثبت آگهی بیشتر از سقف تعداد آگهی را میدهد    timeout=10s
  Wait Until Page Contains Element    name:${Consultant_Phone}_package
  Execute JavaScript                  window.scrollTo(0,1000)
  Click Element                       name:${Consultant_Phone}_package
  Wait Until Page Contains            ${Consultant_Name}                        timeout=10s
  Click Element                       name:limitation-remove
  Wait Until Page Contains            ۱-                                        timeout=10s
  Click Element                       name:approved-action
  ${Status}                           Run Keyword And Return Status             Wait Until Page Contains    در ارسال اطلاعات خطایی رخ داده است   timeout=10s
  Sleep    3s
  Run Keyword If                      ${Status}   Click Element                 name:approved-action
  Wait Until Page Contains Element    name:${Consultant_Phone}-limitation_1     timeout=10s
  Element Should Contain              name:${Consultant_Phone}-limitation_1     1
  Wait Until Page Contains Element    ${Limitation_Package_Number}              timeout=10s
  Wait Until Page Contains            ۸ بسته                                    timeout=10s
  Element Should Contain              ${Limitation_Package_Number}              ۸ بسته
