*** Settings ***
Documentation                         خرید بسته ظرفیت ثبت اگهی
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${limitation}                         ۱۰ بسته

*** Test Cases ***
Buy Limitation Package
  Login Protools                      آلونک
  Go To My Packages Page
  Select Limitation Package
  Compare Selected Package With its Price
  Successful Payment In Sheypoor      بسته‌ی هیبریدی: ظرفیت ثبت آگهی
  Validation Packages In Protools

*** Keywords ***
Select Limitation Package
  Click Button                        ${PackageـPurchase_Button}
  Wait Until Page Contains Element    ${Limitation_Package_Name}               timeout=10s
  Click Element                       ${Limitation_Package_Name}
  Wait Until Page Contains            پرداخت ۴۵,۰۰۰ تومان

Compare Selected Package With its Price
  ${Limitation_Price}                 Get WebElements                          ${Limitation_Package_Price}
  ${Price_After_Discount}             Get Text                                 ${Limitation_Price}[1]
  ${Price_In_Button}                  Get Text                                 ${Submit_Button}
  Should Be Equal                     پرداخت ${Price_After_Discount} تومان     ${Price_In_Button}
  Click Element                       ${Submit_Button}

Validation Packages In Protools
  Wait Until Page Contains            افزایش ظرفیت تعداد آگهی کاربر            timeout=10s
  Element Text Should Be              ${Limitation_Package_Number}             ${limitation}
