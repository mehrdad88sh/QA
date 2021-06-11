*** Settings ***
Documentation                         خرید بسته ویترین ۲۴ ساعته
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${vitrine_24}                         ۱۰ بسته

*** Test Cases ***
Buy Vitrin24 Package
  Login Alunak
  Go To My Packages Page
  Select Vitrin24 Package
  Compare Selected Package With its Price
  Successful Payment In Sheypoor      بسته‌ی هیبریدی: ویترین ۲۴ ساعته
  Validation Packages In Protools

*** Keywords ***
Select Vitrin24 Package
  Click Button                        ${PackageـPurchase_Button}
  Wait Until Page Contains Element    ${Vitrin24_Package_Name}                 timeout=5s
  Click Element                       ${Vitrin24_Package_Name}
  Wait Until Page Contains            پرداخت ۱۸۰,۰۰۰ تومان

Compare Selected Package With its Price
  ${Vitrin24_Price}                   Get WebElements                          ${Vitrin24_Package_Price}
  ${Price_After_Discount}             Get Text                                 ${Vitrin24_Price}[1]
  ${Price_In_Button}                  Get Text                                 ${Submit_Button}
  Should Be Equal                     پرداخت ${Price_After_Discount} تومان     ${Price_In_Button}
  Click Element                       ${Submit_Button}

Validation Packages In Protools
  Wait Until Page Contains            ویترین ۲۴ ساعته                          timeout=5s
  Element Text Should Be              ${Vitrin24_Package_Number}               ${vitrine_24}
