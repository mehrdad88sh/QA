*** Settings ***
Documentation                         خرید بسته ظرفیت ثبت اگهی
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${limitation}                         ۱۰ بسته

*** Test Cases ***
Buy Limitation Package
  Login Alunak
  Choose Limitation Package
  Successful Payment In Sheypoor
  Validation Packages In Protools

*** Keywords ***
Choose Limitation Package
  Click Element                       name:list-item-packageManagement
  Wait Until Page Contains            موجودی من                       timeout=2s
  Click Button                        name:packageManage-action
  Wait Until Page Contains Element    name:special-package            timeout=2s   #نمایش مودال خرید بسته
  Click Element                       name:simple-package-limitation
  ${price_value}                      Get WebElements                 name=simple-package-limitation-price
  ${priceA}=                          Get Text                        ${price_value}[1]
  ${priceB}=                          Get Text                        name:form-submit-action
  Should Be Equal                      پرداخت ${priceA} تومان         ${priceB}
  Click Element                       name:form-submit-action

Successful Payment In Sheypoor
  Wait Until Page Contains            درحال انتقال به درگاه پرداخت    timeout=2s
  Click Element                       class:button-bar
  Wait Until Page Contains            پرداخت شما با موفقیت انجام شد.  timeout=2s
  Element Text Should Be              class:text-right                 بسته‌ی هیبریدی: ظرفیت ثبت آگهی
  Wait Until Keyword Succeeds         3x    3s                        Click Link   بازگشت به برنامه

Validation Packages In Protools
  Wait Until Page Contains            افزایش ظرفیت تعداد آگهی کاربر   timeout=2s
  Element Text Should Be              name:limitation                 ${limitation}
