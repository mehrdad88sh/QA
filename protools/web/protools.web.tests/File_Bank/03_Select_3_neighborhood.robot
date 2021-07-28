*** Settings ***
Documentation                        خرید بسته همراه فایل سه محله از شهر تهران
Resource                             ../../resources/resource.robot
Test Teardown                        Close Browser

*** Test Cases ***
Buy 3 Neighborhood Package
  Login Protools                      آلونک
  Go To File Bank Page
  Purchase File Bank Package
  Validation Purchased File Bank Package In Alunak

*** Keywords ***
Purchase File Bank Package
  Select 3 Neighborhood Package
  Select One Month Subscription
  Successful Payment In Sheypoor     انتخاب سه محله از یک شهر

Select 3 Neighborhood Package
  Reload Page
  ${Status}                          Run Keyword And Return Status
  ...                                Click By Text           خرید بسته جدید
  Run Keyword Unless                 ${status}
  ...                                Click By Text           خرید همراه فایل
  Wait Until Page Contains           انتخاب سه محله از یک شهر
  Click Element                      ${Select_3_Neighborhood}
  Click Button                       ${Selection_Button}
  Wait Until Page Contains           انتخاب محدوده
  Select Neighborhoods

Select One Month Subscription
  Click By Text                      اشتراک یک ماهه
  Page Should Contain                پرداخت ۲۹,۰۰۰ تومان             timeout=10s
  Click By Text                      پرداخت ۲۹,۰۰۰ تومان
  Wait Until Page Contains           درحال انتقال به درگاه پرداخت     timeout=10s

Validation Purchased File Bank Package In Alunak
  Wait Until Page Contains           فایل یافت شد
  Click By Text                      فیلتر بسته‌ها
  Wait Until Page Contains           بسته فایلینگ سه محله از یک شهر
  Wait Until Page Contains           ۳۰ روز
  Click Element                      ${Close_Button}
  Wait Until Page Contains           خرید بسته جدید

Select Neighborhoods
  Click Element                      ${Tehran_Province}
  Wait Until Page Contains Element   ${Tehran_City}
  Click Element                      ${Tehran_City}
  Wait Until Page Contains Element   name:area_n5262
  FOR                                ${INDEX}   IN RANGE    3
        Click Element                css:[nameid="n92${INDEX+6}"]
        Checkbox Should Be Selected  name:area_n92${INDEX+6}
  END
  Click Button                       ${Selection_Button}
  Wait Until Page Contains           خرید اشتراک
