*** Settings ***
Documentation                         خرید بسته ویژه
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${refresh_item}                       ۲۵ بسته
${vitrin24}                           ۱۰ بسته
${vitrin48}                           ۵ بسته

*** Test Cases ***
Buy Spacial Package
  Login Alunak
  Go To My Packages Page
  Select Spacial Package
  Compare Selected Package With its Price
  Successful Payment In Sheypoor
  Validation Packages In Protools

*** Keywords ***
Go To My Packages Page
  Click Element                       name:list-item-packageManagement
  Wait Until Page Contains            موجودی من                       timeout=2s

Select Spacial Package
  Click Button                        name:packageManage-action
  Wait Until Page Contains Element    name:special-package            timeout=2s      #نمایش مودال خرید بسته
  Click Element                       name:special-package
  Page Should Contain Radio Button    //input[@type='radio' and @value='501500']

Compare Selected Package With its Price
  ${price_value}                      Get WebElements                 name=simple-package-special-price
  ${priceA}                           Get Text                        ${price_value}[1]
  ${priceB}                           Get Text                        ${Submit_Button}
  Should Be Equal                     پرداخت ${priceA} تومان          ${priceB}
  Click Element                       ${Submit_Button}

Successful Payment In Sheypoor
  Wait Until Page Contains            درحال انتقال به درگاه پرداخت    timeout=2s
  Click Element                       class:button-bar
  Wait Until Page Contains            پرداخت شما با موفقیت انجام شد.  timeout=2s
  Element Text Should Be              class:text-right                بسته‌ی هیبریدی: بسته ویژه
  Click Link                          بازگشت به برنامه

Validation Packages In Protools
  Wait Until Page Contains            بروزرسانی                       timeout=2s
  Element Text Should Be              name:refresh                    ${refresh_item}
  Element Text Should Be              name:vitrine_24                 ${vitrin24}
  Element Text Should Be              name:vitrine_48                 ${vitrin48}
