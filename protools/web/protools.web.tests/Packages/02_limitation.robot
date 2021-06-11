*** Settings ***
Documentation                         خرید بسته ظرفیت ثبت اگهی
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${limitation}                         ۱۰ بسته

*** Test Cases ***
Buy Limitation Package
  Login Alunak
  Go To My Packages Page
  Select Limitation Package
  Compare Selected Package With its Price
  Successful Payment In Sheypoor      بسته‌ی هیبریدی: ظرفیت ثبت آگهی
  Validation Packages In Protools

*** Keywords ***
Select Limitation Package
  Click Button                        ${PackageـPurchase_Button}
  Wait Until Page Contains Element    name:simple-package-limitation  timeout=5s
  Click Element                       name:simple-package-limitation
  Wait Until Page Contains            پرداخت ۴۵,۰۰۰ تومان

Compare Selected Package With its Price
  ${price_value}                      Get WebElements                 name=simple-package-limitation-price
  ${priceA}                           Get Text                        ${price_value}[1]
  ${priceB}                           Get Text                        ${Submit_Button}
  Should Be Equal                     پرداخت ${priceA} تومان          ${priceB}
  Click Element                       ${Submit_Button}

Validation Packages In Protools
  Wait Until Page Contains            افزایش ظرفیت تعداد آگهی کاربر   timeout=5s
  Element Text Should Be              name:limitation                 ${limitation}
