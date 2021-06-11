*** Settings ***
Documentation                         خرید بسته ویترین ۴۸ ساعته
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${vitrine_48}                         ۵ بسته

*** Test Cases ***
Buy Vitrin48 Package
  Login Alunak
  Go To My Packages Page
  Select Vitrin48 Package
  Compare Selected Package With its Price
  Successful Payment In Sheypoor      بسته‌ی هیبریدی: ویترین ۴۸ ساعته
  Validation Packages In Protools

*** Keywords ***
Select Vitrin48 Package
  Click Button                        ${PackageـPurchase_Button}
  Wait Until Page Contains Element    ${Vitrin48_Package_Name}                 timeout=5s
  Click Element                       ${Vitrin48_Package_Name}
  Wait Until Page Contains            پرداخت ۱۷۱,۰۰۰ تومان

Compare Selected Package With its Price
  ${Vitrin48_Price}                   Get WebElements                          ${Vitrin48_Package_Price}
  ${Price_After_Discount}             Get Text                                 ${Vitrin48_Price}[1]
  ${Price_In_Button}                  Get Text                                 ${Submit_Button}
  Should Be Equal                     پرداخت ${Price_After_Discount} تومان     ${Price_In_Button}
  Click Element                       ${Submit_Button}

Validation Packages In Protools
  Wait Until Page Contains            ویترین ۴۸ ساعته                          timeout=5s
  Element Text Should Be              ${Vitrin48_Package_Number}               ${vitrine_48}
