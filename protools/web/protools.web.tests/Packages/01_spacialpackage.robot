*** Settings ***
Documentation                         خرید بسته ویژه
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${refresh}                            ۲۵ بسته
${vitrin24}                           ۱۰ بسته
${vitrin48}                           ۵ بسته

*** Test Cases ***
Buy Spacial Package
  Login Alunak
  Go To My Packages Page
  Select Spacial Package
  Compare Selected Package With its Price
  Successful Payment In Sheypoor      بسته‌ی هیبریدی: بسته ویژه
  Go To                               ${My_Packages_Page}
  Validation Packages In Protools

*** Keywords ***
Select Spacial Package
  Click Button                        ${PackageـPurchase_Button}
  Wait Until Page Contains Element    ${Special_Package_Name}                  timeout=5s
  Click Element                       ${Special_Package_Name}
  Wait Until Page Contains            پرداخت ۵۰۱,۵۰۰ تومان

Compare Selected Package With its Price
  ${Special_Price}                    Get WebElements                          ${Special_Package_Price}
  ${Price_After_Discount}             Get Text                                 ${Special_Price}[1]
  ${Price_In_Button}                  Get Text                                 ${Submit_Button}
  Should Be Equal                     پرداخت ${Price_After_Discount} تومان     ${Price_In_Button}
  Click Element                       ${Submit_Button}

Validation Packages In Protools
  Wait Until Page Contains            بروزرسانی                                timeout=5s
  Element Text Should Be              ${Refresh_Package_Number}                ${refresh}
  Element Text Should Be              ${Vitrin24_Package_Number}               ${vitrin24}
  Element Text Should Be              ${Vitrin48_Package_Number}               ${vitrin48}
