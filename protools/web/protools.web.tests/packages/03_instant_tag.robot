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
  Successful Payment In Sheypoor
  Validation Packages In Protools

*** Keywords ***
Select Instant Tag Package
  Click Button                        name:packageManage-action
  Wait Until Page Contains Element    name:simple-package-instant_tag  timeout=2s
  Click Element                       name:simple-package-instant_tag
  Wait Until Page Contains            پرداخت ۱۳۵,۰۰۰ تومان

Compare Selected Package With its Price
  ${price_value}                      Get WebElements                 name=simple-package-instant_tag-price
  ${priceA}=                          Get Text                        ${price_value}[1]
  ${priceB}=                          Get Text                        ${Submit_Button}
  Should Be Equal                      پرداخت ${priceA} تومان         ${priceB}
  Click Element                       ${Submit_Button}

Successful Payment In Sheypoor
  Wait Until Page Contains            درحال انتقال به درگاه پرداخت    timeout=2s
  Click Element                       class:button-bar
  Wait Until Page Contains            پرداخت شما با موفقیت انجام شد.  timeout=2s
  Element Text Should Be              class:text-right                بسته‌ی هیبریدی: نشان فوری
  Click Link                          بازگشت به برنامه

Validation Packages In Protools
  Wait Until Page Contains            نشان فوری                       timeout=2s
  Element Text Should Be              name:instant_tag                ${instant_tag}
