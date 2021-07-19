*** Settings ***
Documentation                        خرید بسته همراه فایل هفت محله از شهر تهران
Resource                             ../../resources/resource.robot
Test Teardown                        Close Browser

*** Test Cases ***
Buy 7 Neighborhood Package
  Login Alunak
  Go To File Bank Page
  Purchase File Bank Package
  Validation Purchased File Bank Package In Alunak

*** Keywords ***
Purchase File Bank Package
  Select 7 Neighborhood Package
  Select Six Months Subscription
  Successful Payment In Sheypoor     انتخاب هفت محله از یک شهر
  Go To                              ${File_Bank_Page}

Select 7 Neighborhood Package
  Reload Page
  ${Status}                          Run Keyword And Return Status
  ...                                Click By Text           خرید بسته جدید
  Run Keyword Unless                 ${status}
  ...                                Click By Text           خرید همراه فایل
  Wait Until Page Contains           برای مشاهده‌ی فایل‌ها، ابتدا یکی از بسته‌های زیر را انتخاب کنید.
  Click Element                      ${Select_7_Neighborhood}
  Click Button                       ${Selection_Button}
  Wait Until Page Contains           انتخاب محدوده
  Select Neighborhoods

Select Six Months Subscription
  Click By Text                      اشتراک شش ماهه
  Page Should Contain                پرداخت ۱۶۳,۸۰۰ تومان             timeout=10s
  Click By Text                      پرداخت ۱۶۳,۸۰۰ تومان
  Wait Until Page Contains           درحال انتقال به درگاه پرداخت     timeout=10s

Validation Purchased File Bank Package In Alunak
  Wait Until Page Contains           فایل یافت شد
  Click By Text                      فیلتر بسته‌ها
  Wait Until Page Contains           بسته فایلینگ هفت محله از یک شهر
  Wait Until Page Contains           ۱۸۰ روز
  Click Element                      ${Close_Button}
  Wait Until Page Contains           خرید بسته جدید

Select Neighborhoods
  Click Element                      ${Tehran_Province}
  Wait Until Page Contains Element   ${Tehran_City}
  Click Element                      ${Tehran_City}
  Wait Until Page Contains Element   name:area_n5262
  FOR                                ${INDEX}    IN RANGE    0   10   2
        Click Element                css:[nameid="n93${INDEX}"]
        Checkbox Should Be Selected  name:area_n93${INDEX}
  END
  Click Button                       ${Selection_Button}
  Wait Until Page Contains           خرید اشتراک
