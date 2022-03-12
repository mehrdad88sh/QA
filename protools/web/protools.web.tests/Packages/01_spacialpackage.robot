*** Settings ***
Documentation                         خرید بسته ویژه و تخصیص آن به اعضای فروشگاه
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${refresh}                            ۲۵ بسته
${vitrin24}                           ۱۰ بسته
${vitrin48}                           ۵ بسته
${Final_Price}                        ۸۱۲,۰۷۷

*** Test Cases ***
Buy Spacial Package
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Back To Protools Page
  Go To My Packages Page
  Select Spacial Package
  Compare Selected Package With its Price
  Successful Payment In Sheypoor      بسته‌ی هیبریدی: بسته ویژه
  Validation Packages In Protools
  Find Phone Number And Name Of Team Members
  Assign Package To Secretary
  Assign Package To Consultant
  Remove Package From Secretary
  Remove Package From Consultant

*** Keywords ***
Select Spacial Package
  Click Button                        ${PackageـPurchase_Button}
  Wait Until Page Contains            بسته ویژه                                 timeout=10s
  Click Element                       ${Special_Package_Purchase_Button}
  Wait Until Page Contains            پرداخت ۸۱۲,۰۷۷ تومان                      timeout=10s

Compare Selected Package With its Price
  Wait Until Page Contains            پیش فاکتور                                timeout=5s
  ${PreInvoice_Payment_Button}        Get Text                                  ${PreInvoice_Payment_Button}
  Should Be Equal                     پرداخت ${Final_Price} تومان               ${PreInvoice_Payment_Button}
  Click By Text                       پرداخت ۸۱۲,۰۷۷ تومان

Validation Packages In Protools
  Wait Until Page Contains            با بروزرسانی، آگهی شما به بالاترین آگهی در گروه خود منتقل می شود                  timeout=10s
  Element Text Should Be              ${Refresh_Package_Number}                 ${refresh}
  Element Text Should Be              ${Vitrin24_Package_Number}                ${vitrin24}
  Element Text Should Be              ${Vitrin48_Package_Number}                ${vitrin48}

Find Phone Number And Name Of Team Members
  Register Manager With Alunak Api
  Get Code From Mock Server With Alunak Api
  Authorization Manager With Alunak Api
  Get List Of Members In Alunak Api

Assign Package To Secretary
  Execute JavaScript                  window.scrollTo(0,1000)
  Click Element                       name:${Secretary_Phone}_package
  Wait Until Page Contains            ${Secretary_Name}                         timeout=10s
  Double Click Element                name:refresh-add
  Wait Until Page Contains            ۲+                                        timeout=10s
  Double Click Element                name:vitrine48-add
  Wait Until Page Contains            ۲+                                        timeout=10s
  Double Click Element                name:vitrine24-add
  Wait Until Page Contains            ۲+                                        timeout=10s
  Click Element                       name:approved-action
  Wait Until Page Contains Element    name:${Secretary_Phone}-refresh_2         timeout=10s
  Element Should Contain              name:${Secretary_Phone}-refresh_2         2
  Element Should Contain              name:${Secretary_Phone}-vitrin24_2        2
  Element Should Contain              name:${Secretary_Phone}-vitrin48_2        2
  Wait Until Page Contains            ۲۳ بسته                                   timeout=10s
  Element Should Contain              ${Refresh_Package_Number}                 ۲۳ بسته
  Element Should Contain              ${Vitrin24_Package_Number}                ۸ بسته
  Element Should Contain              ${Vitrin48_Package_Number}                ۳ بسته

Assign Package To Consultant
  Click Element                       name:${Consultant_Phone}_package
  Wait Until Page Contains            ${Consultant_Name}                        timeout=10s
  Double Click Element                name:refresh-add
  Wait Until Page Contains            ۲+                                        timeout=10s
  Double Click Element                name:vitrine48-add
  Wait Until Page Contains            ۲+                                        timeout=10s
  Double Click Element                name:vitrine24-add
  Wait Until Page Contains            ۲+                                        timeout=10s
  Click Element                       name:approved-action
  ${Status}                           Run Keyword And Return Status             Wait Until Page Contains    در ارسال اطلاعات خطایی رخ داده است   timeout=10s
  Sleep    3s
  Run Keyword If                      ${Status}   Click Element                 name:approved-action
  Wait Until Page Contains Element    name:${Consultant_Phone}-refresh_2        timeout=10s
  Element Should Contain              name:${Consultant_Phone}-refresh_2        2
  Element Should Contain              name:${Consultant_Phone}-vitrin24_2       2
  Element Should Contain              name:${Consultant_Phone}-vitrin48_2       2
  Execute JavaScript                  window.scrollTo(0,0)
  Wait Until Page Contains            ۲۱ بسته                                   timeout=10s
  Element Should Contain              ${Refresh_Package_Number}                 ۲۱ بسته
  Element Should Contain              ${Vitrin24_Package_Number}                ۶ بسته
  Element Should Contain              ${Vitrin48_Package_Number}                ۱ بسته

Remove Package From Secretary
  Reload Page
  Wait Until Page Contains            با بروزرسانی، آگهی شما به بالاترین آگهی در گروه خود منتقل می شود      timeout=10s
  Wait Until Page Contains Element    name:${Secretary_Phone}_package
  Execute JavaScript                  window.scrollTo(0,1000)
  Click Element                       name:${Secretary_Phone}_package
  Wait Until Page Contains            ${Secretary_Name}                         timeout=10s
  Click Element                       name:refresh-remove
  Wait Until Page Contains            ۱-                                        timeout=10s
  Click Element                       name:vitrine48-remove
  Wait Until Page Contains            ۱-                                        timeout=10s
  Click Element                       name:vitrine24-remove
  Wait Until Page Contains            ۱-                                        timeout=10s
  Click Element                       name:approved-action
  ${Status}                           Run Keyword And Return Status             Wait Until Page Contains    در ارسال اطلاعات خطایی رخ داده است   timeout=10s
  Sleep    3s
  Run Keyword If                      ${Status}   Click Element                 name:approved-action
  Wait Until Page Contains Element    name:${Secretary_Phone}-refresh_1         timeout=10s
  Element Should Contain              name:${Secretary_Phone}-refresh_1         1
  Element Should Contain              name:${Secretary_Phone}-vitrin24_1        1
  Element Should Contain              name:${Secretary_Phone}-vitrin48_1        1
  Wait Until Page Contains            ۲۲ بسته                                   timeout=10s
  Element Should Contain              ${Refresh_Package_Number}                 ۲۲ بسته
  Element Should Contain              ${Vitrin24_Package_Number}                ۷ بسته
  Element Should Contain              ${Vitrin48_Package_Number}                ۲ بسته

Remove Package From Consultant
  Reload Page
  Wait Until Page Contains            با بروزرسانی، آگهی شما به بالاترین آگهی در گروه خود منتقل می شود      timeout=10s
  Wait Until Page Contains Element    name:${Consultant_Phone}_package
  Execute JavaScript                  window.scrollTo(0,1000)
  Click Element                       name:${Consultant_Phone}_package
  Wait Until Page Contains            ${Consultant_Name}                        timeout=10s
  Click Element                       name:refresh-remove
  Wait Until Page Contains            ۱-                                        timeout=10s
  Click Element                       name:vitrine48-remove
  Wait Until Page Contains            ۱-                                        timeout=10s
  Click Element                       name:vitrine24-remove
  Wait Until Page Contains            ۱-                                        timeout=10s
  Click Element                       name:approved-action
  ${Status}                           Run Keyword And Return Status             Wait Until Page Contains    در ارسال اطلاعات خطایی رخ داده است   timeout=10s
  Sleep    3s
  Run Keyword If                      ${Status}   Click Element                 name:approved-action
  Wait Until Page Contains Element    name:${Consultant_Phone}-refresh_1        timeout=10s
  Element Should Contain              name:${Consultant_Phone}-refresh_1        1
  Element Should Contain              name:${Consultant_Phone}-vitrin24_1       1
  Element Should Contain              name:${Consultant_Phone}-vitrin48_1       1
  Wait Until Page Contains Element    ${Refresh_Package_Number}                 timeout=10s
  Wait Until Page Contains            ۲۳ بسته                                   timeout=10s
  Element Should Contain              ${Refresh_Package_Number}                 ۲۳ بسته
  Element Should Contain              ${Vitrin24_Package_Number}                ۸ بسته
  Element Should Contain              ${Vitrin48_Package_Number}                ۳ بسته
