*** Settings ***
Documentation                         خرید بسته نشان فوری
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${instant_tag}                        ۳۰ بسته

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

*** Keywords ***
Select Instant Tag Package
  Click Button                        ${PackageـPurchase_Button}
  Wait Until Page Contains Element    ${InstantTag_Package_Name}               timeout=10s
  Click Element                       ${InstantTag_Package_Name}
  Wait Until Page Contains            پرداخت ۱۳۵,۰۰۰ تومان

Compare Selected Package With its Price
  ${InstantTag_Price}                 Get WebElements                          ${InstantTag_Package_Price}
  ${Price_After_Discount}             Get Text                                 ${InstantTag_Price}[1]
  ${Price_In_Button}                  Get Text                                 ${Submit_Button}
  Should Be Equal                     پرداخت ${Price_After_Discount} تومان     ${Price_In_Button}
  Click Element                       ${Submit_Button}

Validation Packages In Protools
  Wait Until Page Contains            این قابلیت، نشان فوری را روی آگهی شما نمایش میدهد                                timeout=10s
  Element Text Should Be              ${InstantTag_Package_Number}             ${instant_tag}
