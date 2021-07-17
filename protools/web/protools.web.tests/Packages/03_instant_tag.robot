*** Settings ***
Documentation                         خرید بسته نشان فوری
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${instant_tag}                        ۳۰ بسته

*** Test Cases ***
Buy Instant Tag Package
  Login Alunak
  Go To My Packages Page
  Select Instant Tag Package
  Compare Selected Package With its Price
  Successful Payment In Sheypoor      بسته‌ی هیبریدی: نشان فوری
  Go To                               ${My_Packages_Page}
  Validation Packages In Protools

*** Keywords ***
Select Instant Tag Package
  Click Button                        ${PackageـPurchase_Button}
  Wait Until Page Contains Element    ${InstantTag_Package_Name}               timeout=5s
  Click Element                       ${InstantTag_Package_Name}
  Wait Until Page Contains            پرداخت ۱۳۵,۰۰۰ تومان

Compare Selected Package With its Price
  ${InstantTag_Price}                 Get WebElements                          ${InstantTag_Package_Price}
  ${Price_After_Discount}             Get Text                                 ${InstantTag_Price}[1]
  ${Price_In_Button}                  Get Text                                 ${Submit_Button}
  Should Be Equal                     پرداخت ${Price_After_Discount} تومان     ${Price_In_Button}
  Click Element                       ${Submit_Button}

Validation Packages In Protools
  Wait Until Page Contains            نشان فوری                                timeout=5s
  Element Text Should Be              ${InstantTag_Package_Number}             ${instant_tag}
