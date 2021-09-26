*** Settings ***
Documentation                         خرید بسته ویژه و تخصیص آن به اعضای فروشگاه
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${refresh}                            ۲۵ بسته
${vitrin24}                           ۱۰ بسته
${vitrin48}                           ۵ بسته

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

*** Keywords ***
Select Spacial Package
  Click Button                        ${PackageـPurchase_Button}
  Wait Until Page Contains Element    ${Special_Package_Name}                  timeout=10s
  Click Element                       ${Special_Package_Name}
  Wait Until Page Contains            پرداخت ۵۰۱,۵۰۰ تومان

Compare Selected Package With its Price
  ${Special_Price}                    Get WebElements                          ${Special_Package_Price}
  ${Price_After_Discount}             Get Text                                 ${Special_Price}[1]
  ${Price_In_Button}                  Get Text                                 ${Submit_Button}
  Should Be Equal                     پرداخت ${Price_After_Discount} تومان     ${Price_In_Button}
  Click Element                       ${Submit_Button}

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
  Wait Until Page Contains            ${Secretary_Name}
  Double Click Element                name:refresh-add
  Wait Until Page Contains            ۲+
  Double Click Element                name:vitrine48-add
  Wait Until Page Contains            ۲+
  Double Click Element                name:vitrine24-add
  Wait Until Page Contains            ۲+
  Click Element                       name:approved-action
  Wait Until Page Contains Element    name:${Secretary_Phone}-refresh_2
  Element Should Contain              name:${Secretary_Phone}-refresh_2         2
  Element Should Contain              name:${Secretary_Phone}-vitrin24_2        2
  Element Should Contain              name:${Secretary_Phone}-vitrin48_2        2
  Element Text Should Be              ${Refresh_Package_Number}                 ۲۳ بسته
  Element Text Should Be              ${Vitrin24_Package_Number}                ۸ بسته
  Element Text Should Be              ${Vitrin48_Package_Number}                ۳ بسته
  Sleep    3s

Assign Package To Consultant
  Execute JavaScript                  window.scrollTo(0,1000)
  Click Element                       name:${Consultant_Phone}_package
  Wait Until Page Contains            ${Consultant_Name}
  Double Click Element                name:refresh-add
  Wait Until Page Contains            ۲+
  Double Click Element                name:vitrine48-add
  Wait Until Page Contains            ۲+
  Double Click Element                name:vitrine24-add
  Wait Until Page Contains            ۲+
  Click Element                       name:approved-action
  Wait Until Page Contains Element    name:${Consultant_Phone}-refresh_2
  Element Should Contain              name:${Consultant_Phone}-refresh_2        2
  Element Should Contain              name:${Consultant_Phone}-vitrin24_2       2
  Element Should Contain              name:${Consultant_Phone}-vitrin48_2       2
  Element Text Should Be              ${Refresh_Package_Number}                 ۲۱ بسته
  Element Text Should Be              ${Vitrin24_Package_Number}                ۶ بسته
  Element Text Should Be              ${Vitrin48_Package_Number}                ۱ بسته
