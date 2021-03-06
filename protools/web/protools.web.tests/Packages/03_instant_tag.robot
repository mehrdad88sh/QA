*** Settings ***
Documentation                         خرید بسته نشان فوری و تخصیص آن به اعضای فروشگاه
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${instant_tag}                        ۳۰ عدد
${Final_Price}                        ۳۰۳,۱۲۹

*** Test Cases ***
Buy Instant Tag Package
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Back To Protools Page
  Go To My Packages Page
  Select Instant Tag Package
  Compare Selected Package With its Price
  Successful Payment In Sheypoor      بسته‌ی هیبریدی: نشان فوری
  Validation Packages In Protools
  Find Phone Number And Name Of Team Members
  Assign Package To Secretary
  Assign Package To Consultant
  Remove Package From Secretary
  Remove Package From Consultant

*** Keywords ***
Select Instant Tag Package
  Click Button                        ${PackageـPurchase_Button}
  Wait Until Page Contains            ۳۰ نشان فوری                              timeout=10s
  Click Element                       ${InstantTag_Package_Purchase_Button}
  Wait Until Page Contains            پرداخت ۳۰۳,۱۲۹ تومان

Compare Selected Package With its Price
  Wait Until Page Contains            پیش فاکتور                                timeout=5s
  ${PreInvoice_Payment_Button}        Get Text                                  ${PreInvoice_Payment_Button}
  Should Be Equal                     پرداخت ${Final_Price} تومان               ${PreInvoice_Payment_Button}
  Click By Text                       پرداخت ۳۰۳,۱۲۹ تومان

Validation Packages In Protools
  Wait Until Page Contains            این قابلیت، نشان فوری را روی آگهی شما نمایش میدهد                                timeout=10s
  Element Text Should Be              ${InstantTag_Package_Number}              ${instant_tag}

Find Phone Number And Name Of Team Members
  Register Manager With Alunak Api
  Get Code From Mock Server With Alunak Api
  Authorization Manager With Alunak Api
  Get List Of Members In Alunak Api

Assign Package To Secretary
  Execute JavaScript                  window.scrollTo(0,1000)
  Click Element                       name:${Secretary_Phone}_package
  Wait Until Page Contains            ${Secretary_Name}                         timeout=10s
  Double Click Element                name:urgent-add
  Wait Until Page Contains            ۲+                                        timeout=10s
  Click Element                       name:approved-action
  Wait Until Page Contains Element    name:${Secretary_Phone}-urgent_2          timeout=10s
  Element Should Contain              name:${Secretary_Phone}-urgent_2          2
  Wait Until Page Contains            ۲۸ عدد                                    timeout=10s
  Element Should Contain              ${InstantTag_Package_Number}              ۲۸ عدد

Assign Package To Consultant
  Click Element                       name:${Consultant_Phone}_package
  Wait Until Page Contains            ${Consultant_Name}                        timeout=10s
  Double Click Element                name:urgent-add
  Wait Until Page Contains            ۲+                                        timeout=10s
  Click Element                       name:approved-action
  ${Status}                           Run Keyword And Return Status             Wait Until Page Contains    در ارسال اطلاعات خطایی رخ داده است   timeout=10s
  Sleep    5s
  Run Keyword If                      ${Status}   Click Element                 name:approved-action
  Wait Until Page Contains Element    name:${Consultant_Phone}-urgent_2         timeout=10s
  Element Should Contain              name:${Consultant_Phone}-urgent_2         2
  Execute JavaScript                  window.scrollTo(0,0)
  Wait Until Page Contains            ۲۶ عدد                                    timeout=10s
  Element Should Contain              ${InstantTag_Package_Number}              ۲۶ عدد

Remove Package From Secretary
  Reload Page
  Wait Until Page Contains            این قابلیت، نشان فوری را روی آگهی شما نمایش میدهد     timeout=10s
  Wait Until Page Contains Element    name:${Secretary_Phone}_package
  Execute JavaScript                  window.scrollTo(0,1000)
  Click Element                       name:${Secretary_Phone}_package
  Wait Until Page Contains            ${Secretary_Name}                         timeout=10s
  Click Element                       name:urgent-remove
  Wait Until Page Contains            ۱-                                        timeout=10s
  Click Element                       name:approved-action
  ${Status}                           Run Keyword And Return Status             Wait Until Page Contains    در ارسال اطلاعات خطایی رخ داده است   timeout=10s
  Sleep    3s
  Run Keyword If                      ${Status}   Click Element                 name:approved-action
  Wait Until Page Contains Element    name:${Secretary_Phone}-urgent_1          timeout=10s
  Element Should Contain              name:${Secretary_Phone}-urgent_1          1
  Wait Until Page Contains            ۲۷ عدد                                    timeout=10s
  Element Should Contain              ${InstantTag_Package_Number}              ۲۷ عدد

Remove Package From Consultant
  Reload Page
  Wait Until Page Contains            این بسته به شما امکان ثبت آگهی بیشتر از سقف تعداد آگهی را میدهد    timeout=10s
  Wait Until Page Contains Element    name:${Consultant_Phone}_package
  Execute JavaScript                  window.scrollTo(0,1000)
  Click Element                       name:${Consultant_Phone}_package
  Wait Until Page Contains            ${Consultant_Name}                        timeout=10s
  Click Element                       name:urgent-remove
  Wait Until Page Contains            ۱-                                        timeout=10s
  Click Element                       name:approved-action
  ${Status}                           Run Keyword And Return Status             Wait Until Page Contains    در ارسال اطلاعات خطایی رخ داده است   timeout=10s
  Sleep    3s
  Run Keyword If                      ${Status}   Click Element                 name:approved-action
  Wait Until Page Contains Element    name:${Consultant_Phone}-urgent_1         timeout=10s
  Element Should Contain              name:${Consultant_Phone}-urgent_1         1
  Wait Until Page Contains Element    ${InstantTag_Package_Number}              timeout=10s
  Wait Until Page Contains            ۲۸ عدد                                    timeout=10s
  Element Should Contain              ${InstantTag_Package_Number}              ۲۸ عدد
