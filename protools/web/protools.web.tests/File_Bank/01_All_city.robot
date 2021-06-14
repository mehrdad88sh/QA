*** Settings ***
Documentation                         خرید بسته همراه فایل کل یک شهر
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***


*** Test Cases ***
Buy All City File Bank Package
  Login Alunak
  Go To File Bank Page
  Select All City Package
  Select Subscription Period
  Successful Payment In Sheypoor      انتخاب کل یک شهر
  Validation Purchased File Bank Package In Alunak

*** Keywords ***
Select All City Package
  Click Element                      ${File_Bank_Purchase_Button}
  Wait Until Page Contains           برای مشاهده‌ی فایل‌ها، ابتدا یکی از بسته‌های زیر را انتخاب کنید.
  Click Element                      name:انتخاب کل یک شهر
  Click Button                       name:choose-action
  Wait Until Page Contains           انتخاب محدوده
  Click Element                      css:[nameid="8"]
  Wait Until Page Contains Element   css:[nameid="301"]
  Click Element                      css:[nameid="301"]
  Page Should Contain Radio Button   name:area_301
  Click Button                       name:choose-action
  Wait Until Page Contains           خرید اشتراک

Select Subscription Period
  Click Element                      //*[@id="react-view"]/div/main/div[3]/div[4]/div[1]/div[1]/div[1]
  Wait Until Page Contains           پرداخت ۵۹,۰۰۰ تومان
  Click Element                      //*[@id="react-view"]/div/main/div[4]/span/span[1]

Validation Purchased File Bank Package In Alunak
  Wait Until Page Contains          فیلتر بسته‌ها
  Click Element                     //*[@id="react-view"]/div/main/div[3]/div[1]/div[2]/span/span[1]/span
  Wait Until Page Contains          بسته فایلینگ کل یک شهر
  Wait Until Page Contains          ۳۰ روز
  Click Element                     ${Close_Button}
  Wait Until Page Contains          خرید بسته جدید
