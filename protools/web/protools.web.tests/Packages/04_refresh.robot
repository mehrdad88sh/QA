*** Settings ***
Documentation                         خرید بسته بروزرسانی
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${Refresh}                            ۲۵ بسته

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

*** Keywords ***
Select Refresh Package
  Click Button                        ${PackageـPurchase_Button}
  Wait Until Page Contains Element    ${Refresh_Package_Name}                  timeout=10s
  Click Element                       ${Refresh_Package_Name}
  Wait Until Page Contains            پرداخت ۱۸۰,۰۰۰ تومان

Compare Selected Package With its Price
  ${Refresh_Price}                    Get WebElements                          ${Refresh_Package_Price}
  ${Price_After_Discount}             Get Text                                 ${Refresh_Price}[1]
  ${Price_In_Button}                  Get Text                                 ${Submit_Button}
  Should Be Equal                     پرداخت ${Price_After_Discount} تومان     ${Price_In_Button}
  Click Element                       ${Submit_Button}

Validation Packages In Protools
  Wait Until Page Contains            با بروزرسانی، آگهی شما به بالاترین آگهی در گروه خود منتقل می شود                                timeout=10s
  Element Text Should Be              ${Refresh_Package_Number}                ${Refresh}
