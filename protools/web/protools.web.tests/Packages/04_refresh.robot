*** Settings ***
Documentation                         خرید بسته بروزرسانی و تخصیص آن به اعضای فروشگاه
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${Refresh}                            ۲۵ عدد
${Final_Price}                        ۳۱۶,۳۷۲

*** Test Cases ***
Buy Refresh Package
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Back To Protools Page
  Go To My Packages Page
  Select Refresh Package
  Compare Selected Package With its Price
  Successful Payment In Sheypoor      بسته‌ی هیبریدی: بروزرسانی
  Validation Packages In Protools
  Find Phone Number And Name Of Team Members
  Assign Package To Secretary
  Assign Package To Consultant
  Remove Package From Secretary
  Remove Package From Consultant

*** Keywords ***
Select Refresh Package
  Click Button                        ${PackageـPurchase_Button}
  Wait Until Page Contains            ۲۵ بروزرسانی                              timeout=10s
  Click Element                       ${Refresh_Package_Purchase_Button}
  Wait Until Page Contains            پرداخت ۳۱۶,۳۷۲ تومان

Compare Selected Package With its Price
  Wait Until Page Contains            پیش فاکتور                                timeout=5s
  ${PreInvoice_Payment_Button}        Get Text                                  ${PreInvoice_Payment_Button}
  Should Be Equal                     پرداخت ${Final_Price} تومان               ${PreInvoice_Payment_Button}
  Click By Text                       پرداخت ۳۱۶,۳۷۲ تومان

Validation Packages In Protools
  Wait Until Page Contains            با بروزرسانی، آگهی شما به بالاترین آگهی در گروه خود منتقل می شود                                timeout=10s
  Element Text Should Be              ${Refresh_Package_Number}                 ${Refresh}

Find Phone Number And Name Of Team Members
  Register Manager With Alunak Api
  Get Code From Mock Server With Alunak Api
  Authorization Manager With Alunak Api
  Get List Of Members In Alunak Api

Assign Package To Secretary
  Execute JavaScript                  window.scrollTo(0,1000)
  Click Element                       name:${Secretary_Phone}_package
  Wait Until Page Contains            ${Secretary_Name}                         timeout=10s
  Element Should Contain              name:refresh-pick-number                  ۰
  Double Click Element                name:refresh-add
  Element Should Contain              name:refresh-pick-number                  ۲
  Wait Until Page Contains            ۲+                                        timeout=10s
  Click Element                       name:approved-action
  Wait Until Page Contains Element    name:${Secretary_Phone}-refresh_2         timeout=10s
  Element Should Contain              name:${Secretary_Phone}-refresh_2         2
  Wait Until Page Contains            ۲۳ عدد                                    timeout=10s
  Element Should Contain              ${Refresh_Package_Number}                 ۲۳ عدد

Assign Package To Consultant
  Click Element                       name:${Consultant_Phone}_package
  Wait Until Page Contains            ${Consultant_Name}                        timeout=10s
  Element Should Contain              name:refresh-pick-number                  ۰
  Double Click Element                name:refresh-add
  Element Should Contain              name:refresh-pick-number                  ۲
  Wait Until Page Contains            ۲+                                        timeout=10s
  Click Element                       name:approved-action
  ${Status}                           Run Keyword And Return Status             Wait Until Page Contains    در ارسال اطلاعات خطایی رخ داده است   timeout=10s
  Sleep    5s
  Run Keyword If                      ${Status}   Click Element                 name:approved-action
  Wait Until Page Contains Element    name:${Consultant_Phone}-refresh_2        timeout=10s
  Element Should Contain              name:${Consultant_Phone}-refresh_2        2
  Execute JavaScript                  window.scrollTo(0,0)
  Wait Until Page Contains            ۲۱ عدد                                    timeout=10s
  Element Should Contain              ${Refresh_Package_Number}                 ۲۱ عدد

Remove Package From Secretary
  Reload Page
  Wait Until Page Contains            با بروزرسانی، آگهی شما به بالاترین آگهی در گروه خود منتقل می شود  timeout=10s
  Wait Until Page Contains Element    name:${Secretary_Phone}_package
  Execute JavaScript                  window.scrollTo(0,1000)
  Click Element                       name:${Secretary_Phone}_package
  Wait Until Page Contains            ${Secretary_Name}                         timeout=10s
  Element Should Contain              name:refresh-pick-number                  ۲
  Click Element                       name:refresh-remove
  Element Should Contain              name:refresh-pick-number                  ۱
  Wait Until Page Contains            ۱-                                        timeout=10s
  Click Element                       name:approved-action
  ${Status}                           Run Keyword And Return Status             Wait Until Page Contains    در ارسال اطلاعات خطایی رخ داده است   timeout=10s
  Sleep    3s
  Run Keyword If                      ${Status}   Click Element                 name:approved-action
  Wait Until Page Contains Element    name:${Secretary_Phone}-refresh_1         timeout=10s
  Element Should Contain              name:${Secretary_Phone}-refresh_1         1
  Wait Until Page Contains            ۲۲ عدد                                    timeout=10s
  Element Should Contain              ${Refresh_Package_Number}                 ۲۲ عدد

Remove Package From Consultant
  Reload Page
  Wait Until Page Contains            با بروزرسانی، آگهی شما به بالاترین آگهی در گروه خود منتقل می شود    timeout=10s
  Wait Until Page Contains Element    name:${Consultant_Phone}_package
  Execute JavaScript                  window.scrollTo(0,1000)
  Click Element                       name:${Consultant_Phone}_package
  Wait Until Page Contains            ${Consultant_Name}                        timeout=10s
  Element Should Contain              name:refresh-pick-number                  ۲
  Click Element                       name:refresh-remove
  Element Should Contain              name:refresh-pick-number                  ۱
  Wait Until Page Contains            ۱-                                        timeout=10s
  Click Element                       name:approved-action
  ${Status}                           Run Keyword And Return Status             Wait Until Page Contains    در ارسال اطلاعات خطایی رخ داده است   timeout=10s
  Sleep    3s
  Run Keyword If                      ${Status}   Click Element                 name:approved-action
  Wait Until Page Contains Element    name:${Consultant_Phone}-refresh_1        timeout=10s
  Element Should Contain              name:${Consultant_Phone}-refresh_1        1
  Wait Until Page Contains Element    ${Refresh_Package_Number}                 timeout=10s
  Wait Until Page Contains            ۲۳ عدد                                    timeout=10s
  Element Should Contain              ${Refresh_Package_Number}                 ۲۳ عدد
