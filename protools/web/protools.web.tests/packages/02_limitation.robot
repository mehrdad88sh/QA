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
  Successful Payment In Sheypoor
  Validation Packages In Protools

*** Keywords ***
Select Limitation Package
  Click Button                        name:packageManage-action
  Wait Until Page Contains Element    name:simple-package-limitation  timeout=2s
  Click Element                       name:simple-package-limitation
  Wait Until Page Contains            پرداخت ۴۵,۰۰۰ تومان

Compare Selected Package With its Price
  ${price_value}                      Get WebElements                 name=simple-package-limitation-price
  ${priceA}                           Get Text                        ${price_value}[1]
  ${priceB}                           Get Text                        ${Submit_Button}
  Should Be Equal                     پرداخت ${priceA} تومان          ${priceB}
  Click Element                       ${Submit_Button}

Successful Payment In Sheypoor
  Wait Until Page Contains            درحال انتقال به درگاه پرداخت    timeout=2s
  Click Element                       class:button-bar
  Wait Until Page Contains            پرداخت شما با موفقیت انجام شد.  timeout=2s
  Element Text Should Be              class:text-right                 بسته‌ی هیبریدی: ظرفیت ثبت آگهی
  Click Link                          بازگشت به برنامه

Validation Packages In Protools
  Wait Until Page Contains            افزایش ظرفیت تعداد آگهی کاربر   timeout=2s
  Element Text Should Be              name:limitation                 ${limitation}
