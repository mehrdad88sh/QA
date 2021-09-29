*** Settings ***
Documentation                        خرید بسته همراه فایل کل یک شهر
Resource                             ../../resources/resource.robot
Test Teardown                        Close Browser

*** Test Cases ***
Buy All City File Bank Package
  Login Protools                      آلونک
  Go To File Bank Page
  Purchase File Bank Package
  Validation Purchased File Bank Package In Alunak

*** Keywords ***
Purchase File Bank Package
  Select All City Package
  Select Three Months Subscription
  Successful Payment In Sheypoor     انتخاب کل یک شهر

Select All City Package
  Reload Page
  ${Status}                          Run Keyword And Return Status
  ...                                Click By Text           خرید بسته جدید
  Run Keyword Unless                 ${status}
  ...                                Click By Text           خرید همراه فایل
  Wait Until Page Contains           انتخاب کل یک شهر
  Click Element                      ${Select_All_City}
  Click Button                       ${Selection_Button}
  Wait Until Page Contains           تهران
  Select City Range

Select Three Months Subscription
  Click By Text                      اشتراک سه ماهه
  Page Should Contain                پرداخت ۱۵۹,۳۰۰ تومان             timeout=10s
  Click By Text                      پرداخت ۱۵۹,۳۰۰ تومان
  Wait Until Page Contains           درحال انتقال به درگاه پرداخت     timeout=10s

Validation Purchased File Bank Package In Alunak
  Wait Until Page Contains           فیلتر بسته‌ها
  Click By Text                      فیلتر بسته‌ها
  Wait Until Page Contains           بسته فایلینگ کل یک شهر
  Wait Until Page Contains           ۹۰ روز
  Click Element                      ${Close_Button}
  Wait Until Page Contains           خرید بسته جدید

Select City Range
  Click Element                      ${Tehran_Province}
  Wait Until Page Contains Element   ${Tehran_City}
  Click Element                      ${Tehran_City}
  Page Should Contain Radio Button   name:area_301
  Click Button                       ${Selection_Button}
  Wait Until Page Contains           خرید اشتراک
