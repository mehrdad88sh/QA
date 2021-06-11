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
  Successful Payment In Sheypoor      بسته‌ی هیبریدی: بسته ویژه
  Validation Packages In Protools

*** Keywords ***
Select Spacial Package
  Click Button                        name:packageManage-action
  Wait Until Page Contains Element    name:special-package            timeout=2s
  Click Element                       name:special-package
  Wait Until Page Contains            پرداخت ۵۰۱,۵۰۰ تومان

Compare Selected Package With its Price
  ${price_value}                      Get WebElements                 name=simple-package-special-price
  ${priceA}                           Get Text                        ${price_value}[1]
  ${priceB}                           Get Text                        ${Submit_Button}
  Should Be Equal                     پرداخت ${priceA} تومان          ${priceB}
  Click Element                       ${Submit_Button}

Validation Packages In Protools
  Wait Until Page Contains            بروزرسانی                       timeout=2s
  Element Text Should Be              name:refresh                    ${refresh_item}
  Element Text Should Be              name:vitrine_24                 ${vitrin24}
  Element Text Should Be              name:vitrine_48                 ${vitrin48}
