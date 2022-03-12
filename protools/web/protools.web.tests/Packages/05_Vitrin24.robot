*** Settings ***
Documentation                         خرید بسته ویترین ۲۴ ساعته و تخصیص آن به اعضای فروشگاه
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${vitrine_24}                         ۱۰ بسته
${Final_Price}                        ۲۷۸,۶۰۴

*** Test Cases ***
Buy Vitrin24 Package
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Back To Protools Page
  Go To My Packages Page
  Select Vitrin24 Package
  Compare Selected Package With its Price
  Successful Payment In Sheypoor      بسته‌ی هیبریدی: ویترین ۲۴ ساعته
  Validation Packages In Protools
  Find Phone Number And Name Of Team Members
  Assign Package To Secretary
  Assign Package To Consultant
  Remove Package From Secretary
  Remove Package From Consultant

*** Keywords ***
Select Vitrin24 Package
  Click Button                        ${PackageـPurchase_Button}
  Wait Until Page Contains            ۱۰ ویترین ۲۴ ساعته                        timeout=10s
  Click Element                       ${Vitrin24_Package_Purchase_Button}
  Wait Until Page Contains            پرداخت ۲۷۸,۶۰۴ تومان

Compare Selected Package With its Price
  Wait Until Page Contains            پیش فاکتور                                timeout=5s
  ${PreInvoice_Payment_Button}        Get Text                                  ${PreInvoice_Payment_Button}
  Should Be Equal                     پرداخت ${Final_Price} تومان               ${PreInvoice_Payment_Button}
  Click By Text                       پرداخت ۲۷۸,۶۰۴ تومان

Validation Packages In Protools
  Wait Until Page Contains            با ۲۴ ساعت ویترین، آگهی شما یک بار بروزرسانی شده و به مدت ۲۴ ساعت نیز ویترین میشود                          timeout=10s
  Element Text Should Be              ${Vitrin24_Package_Number}                ${vitrine_24}

Find Phone Number And Name Of Team Members
  Register Manager With Alunak Api
  Get Code From Mock Server With Alunak Api
  Authorization Manager With Alunak Api
  Get List Of Members In Alunak Api

Assign Package To Secretary
  Execute JavaScript                  window.scrollTo(0,1000)
  Click Element                       name:${Secretary_Phone}_package
  Wait Until Page Contains            ${Secretary_Name}                         timeout=10s
  Element Should Contain              name:vitrine24-pick-number                ۰
  Double Click Element                name:vitrine24-add
  Element Should Contain              name:vitrine24-pick-number                ۲
  Wait Until Page Contains            ۲+                                        timeout=10s
  Click Element                       name:approved-action
  Wait Until Page Contains Element    name:${Secretary_Phone}-vitrin24_2        timeout=10s
  Element Should Contain              name:${Secretary_Phone}-vitrin24_2        2
  Wait Until Page Contains            ۸ بسته                                    timeout=10s
  Element Should Contain              ${Vitrin24_Package_Number}                ۸ بسته

Assign Package To Consultant
  Click Element                       name:${Consultant_Phone}_package
  Wait Until Page Contains            ${Consultant_Name}                        timeout=10s
  Element Should Contain              name:vitrine24-pick-number                ۰
  Double Click Element                name:vitrine24-add
  Element Should Contain              name:vitrine24-pick-number                ۲
  Wait Until Page Contains            ۲+                                        timeout=10s
  Click Element                       name:approved-action
  ${Status}                           Run Keyword And Return Status             Wait Until Page Contains    در ارسال اطلاعات خطایی رخ داده است   timeout=10s
  Sleep    5s
  Run Keyword If                      ${Status}   Click Element                 name:approved-action
  Wait Until Page Contains Element    name:${Consultant_Phone}-vitrin24_2       timeout=10s
  Element Should Contain              name:${Consultant_Phone}-vitrin24_2       2
  Execute JavaScript                  window.scrollTo(0,0)
  Wait Until Page Contains            ۶ بسته                                    timeout=10s
  Element Should Contain              ${Vitrin24_Package_Number}                ۶ بسته

Remove Package From Secretary
  Reload Page
  Wait Until Page Contains            با ۲۴ ساعت ویترین، آگهی شما یک بار بروزرسانی شده و به مدت ۲۴ ساعت نیز ویترین میشود    timeout=10s
  Wait Until Page Contains Element    name:${Secretary_Phone}_package
  Execute JavaScript                  window.scrollTo(0,1000)
  Click Element                       name:${Secretary_Phone}_package
  Wait Until Page Contains            ${Secretary_Name}                         timeout=10s
  Element Should Contain              name:vitrine24-pick-number                ۲
  Click Element                       name:vitrine24-remove
  Element Should Contain              name:vitrine24-pick-number                ۱
  Wait Until Page Contains            ۱-                                        timeout=10s
  Click Element                       name:approved-action
  ${Status}                           Run Keyword And Return Status             Wait Until Page Contains    در ارسال اطلاعات خطایی رخ داده است   timeout=10s
  Sleep    3s
  Run Keyword If                      ${Status}   Click Element                 name:approved-action
  Wait Until Page Contains Element    name:${Secretary_Phone}-vitrin24_1        timeout=10s
  Element Should Contain              name:${Secretary_Phone}-vitrin24_1        1
  Wait Until Page Contains            ۷ بسته                                    timeout=10s
  Element Should Contain              ${Vitrin24_Package_Number}                ۷ بسته

Remove Package From Consultant
  Reload Page
  Wait Until Page Contains            با ۲۴ ساعت ویترین، آگهی شما یک بار بروزرسانی شده و به مدت ۲۴ ساعت نیز ویترین میشود    timeout=10s
  Wait Until Page Contains Element    name:${Consultant_Phone}_package
  Execute JavaScript                  window.scrollTo(0,1000)
  Click Element                       name:${Consultant_Phone}_package
  Wait Until Page Contains            ${Consultant_Name}                        timeout=10s
  Element Should Contain              name:vitrine24-pick-number                ۲
  Click Element                       name:vitrine24-remove
  Element Should Contain              name:vitrine24-pick-number                ۱
  Wait Until Page Contains            ۱-                                        timeout=10s
  Click Element                       name:approved-action
  ${Status}                           Run Keyword And Return Status             Wait Until Page Contains    در ارسال اطلاعات خطایی رخ داده است   timeout=10s
  Sleep    3s
  Run Keyword If                      ${Status}   Click Element                 name:approved-action
  Wait Until Page Contains Element    name:${Consultant_Phone}-vitrin24_1       timeout=10s
  Element Should Contain              name:${Consultant_Phone}-vitrin24_1       1
  Wait Until Page Contains Element    ${Vitrin24_Package_Number}                timeout=10s
  Wait Until Page Contains            ۸ بسته                                    timeout=10s
  Element Should Contain              ${Vitrin24_Package_Number}                ۸ بسته
