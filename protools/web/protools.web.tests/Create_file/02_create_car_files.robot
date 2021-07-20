*** Settings ***
Documentation                         ثبت فایل و اگهی در گروه خودرو و موتورسیکلت
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variable ***
${image_path}                         ${CURDIR}${/}..\/..\/resources\/images\/SilverPride.jpg

*** Test Cases ***
Post Listing ‌In Vehicle Category
  Login Protools                      شیپورپلاس
  Create Shop In Sheypoor             خودرو
  Go To Sheypoor Car Page
  Create File In Car Category
  Create Listing
  Create File In Motorcycle Category
  Create Listing

*** Keywords ***
Create File In Car Category
  Go To Submit File Page
  Select Pride Category
  Set Location
  Set Car Attributes
  Fill File Description
  Set More Detail Car
  Upload Image
  Submit File

Create File In Motorcycle Category
  Go To Submit File Page
  Set Motorcycle Category
  Set Location
  Set Motorcycle Attributes
  Fill File Description
  Set Motorcycle More Detail
  Submit File

Create Listing
  Click Element                       name=file-item-0
  Reload Page
  Wait Until Keyword Succeeds         3x     2s                        Page Should Contain  آگهی نشده
  Click Button                        name=advertise-action
  Wait Until Page Contains            توضیحات                          timeout=5s
  Fill File Description
  Click Button                        name=apply-action
  Wait Until Page Contains            آگهی شما با موفقیت ثبت شد        timeout=5s
  Click Element                       name=listing-management-action
  Wait Until Page Contains Element    name:listing-item-0              timeout=5s

Go To Submit File Page
  Click Element                       name:list-item-new-file
  Wait Until Page Contains            ثبت فایل و آگهی                  timeout=5s

Select Pride Category
  Select Vehicle Category
  Select Pride Brand

Select Vehicle Category
  Wait Until Page Contains Element    name=category-trigger            timeout=5s
  Click Element                       name=category-trigger
  Page Should Contain Element         css:[role="document"]
  Click Element                       name=43627
  Wait Until Page Contains Element    name=43976                      timeout=5s

Select Pride Brand
  Click Element                       name=43976
  Textfield Value Should Be           name=category                    پراید
  Wait Until Page Contains Element    select-a68143                   timeout=5s

Set Motorcycle Category
  Wait Until Keyword Succeeds         3x   3s                         Click Element      name:form-clear-action
  Wait Until Page Contains            از انصراف اطمینان دارید؟        timeout=5s
  Click Element                       ${Confirm_Button}
  Page Should Contain Element         css:[tabindex="-1"]                                #دکمه ثبت فایل غیرفعال باشه
  Wait Until Keyword Succeeds         3x    2s                         Click Element     name:category-trigger
  Wait Until Page Contains Element    css:[tabindex="-1"]              timeout=5s        #نمایش دسته بندی
  Click Element                       name=43628
  Wait Until Page Contains Element    name=45202                       timeout=5s
  Click Element                       name=45202
  Textfield Value Should Be           name=category                    هوندا
  Wait Until Page Contains            حجم موتور

Set Car Attributes
  Select Saba Model
  Car Payment Type
  Production Year
  Car Function
  Car Color
  Car Gearbox Type
  Car Fuel Type
  Car Body Condition
  Price

Set Motorcycle Attributes
  Production Year
  Engine Capacity
  Motorcycle Kilometer
  Motorcycle Gearbox Type
  Motorcycle Tip
  Motorcycle Payment Type
  Motorcycle Color
  Price

Select Saba Model
  Click Element                       select-a68143
  Page Should Contain Element         css:[role="listbox"]
  Click Element                       name=440665
  Element Should Contain              select-a68143                    صبا (صندوقدار)

Car Payment Type
  Click Element                       select-a69150
  Page Should Contain Element         css:[role="listbox"]
  Click Element                       name=445097
  Element Should Contain              select-a69150                    نقدی

Production Year
  ${Production Year}                  Evaluate  random.randint(1365, 1400)  random
  ${Status}                           Run Keyword And Return Status  Wait Until Page Contains Element    name=a68101    timeout=1s
  Run Keyword If                      ${Status}                      Input Text                          name=a68101    ${Production Year}
  ...  ELSE                           Input Text                     name=a68140                                        ${Production Year}

Car Function
  Input Text                          name=a68102                    200000

Car Color
  Click Element                       select-a69130
  Page Should Contain Element         css:[role="listbox"]
  Click Element                       name=445303
  Element Should Contain              select-a69130                 نقره‌ای

Car Gearbox Type
  Click Element                       select-a69140
  Page Should Contain Element         css:[role="listbox"]
  Click Element                       name=445313
  Element Should Contain              select-a69140                 اتوماتیک

Car Fuel Type
  Click Element                       select-a69602
  Page Should Contain Element         css:[role="listbox"]
  Click Element                       name=450676
  Element Should Contain              select-a69602                دوگانه سوز

Car Body Condition
  Click Element                       select-a69160
  Page Should Contain Element         css:[role="listbox"]
  Click Element                       name=445332
  Element Should Contain              select-a69160                دو لکه رنگ

Engine Capacity
  Click Element                       select-a68105
  Page Should Contain Element         css:[role="listbox"]
  Click Element                       name=440582
  Element Should Contain              select-a68105               (150cc - 174cc)

Motorcycle Kilometer
  Input Text                          name:a68141                 40000

Motorcycle Gearbox Type
  Click Element                       select-a92350
  Page Should Contain Element         css:[role="listbox"]
  Click Element                       name=455033
  Element Should Contain              select-a92350                نیمه اتوماتیک

Motorcycle Tip
  Click Element                       select-a91888
  Page Should Contain Element         css:[role="listbox"]
  Click Element                       name=455000
  Element Should Contain              select-a91888                سه چرخ

Motorcycle Payment Type
  Click Element                       select-a92360
  Page Should Contain Element         css:[role="listbox"]
  Click Element                       name=455034
  Element Should Contain              select-a92360                نقدی

Motorcycle Color
  Click Element                       select-a93000
  Page Should Contain Element         css:[role="listbox"]
  Click Element                       name=455272
  Element Should Contain              select-a93000                آلبالویی

Price
  Input Text                          name=price                   50000000

Set More Detail Car
  Select More Detail Button
  Color Inside Car
  Car License Plate Type
  In-vehicle Equipment
  Out-of-vehicle Equipment
  Car Safety Equipment
  Apply More Detail

Set Motorcycle More Detail
  Click Element                       name=افزودن جزئیات بیشتر
  Page Should Contain Element         css:[role="document"]
  Motorcycle Fuel Type
  Motorcycle License Plate Type
  Click Button                        name:apply-action

Color Inside Car
  Click Element                       select-a69600
  Page Should Contain Element         css:[role="listbox"]
  Wait Until Keyword Succeeds         3x  2s    Click Element      name=450663
  Page Should Contain                 سرمه ای

Car License Plate Type
  Click Element                       select-a69601
  Page Should Contain Element         css:[role="listbox"]
  Click Element                       name=450673
  Element Should Contain              select-a69601                منطقه آزاد

In-vehicle Equipment
  Click Element                       name=a69603-trigger
  Page Should Contain                 بلوتوث
  Select Checkbox                     name:checkbox-450679        #بلوتوث
  Checkbox Should Be Selected         name:checkbox-450679
  Select Checkbox                     name:checkbox-450686        #ماساژور
  Checkbox Should Be Selected         name:checkbox-450686
  Select Checkbox                     name=checkbox-450691        #صندلی برقی
  Checkbox Should Be Selected         name:checkbox-450691
  Click Button                        name=select-add-action

Out-of-vehicle Equipment
  Click Element                       name=a69604-trigger
  Page Should Contain                 آینه برقی
  Select Checkbox                     name:checkbox-450696        #آینه برقی
  Checkbox Should Be Selected         name:checkbox-450696
  Select Checkbox                     name:checkbox-450698        #سانروف
  Checkbox Should Be Selected         name:checkbox-450698
  Select Checkbox                     name=checkbox-450700        #لاستیک آفرود
  Checkbox Should Be Selected         name:checkbox-450700
  Click Button                        name=select-add-action

Car Safety Equipment
  Click Element                       name=a69605-trigger
  Page Should Contain                 دزدگیر
  Select Checkbox                     name:checkbox-450703        #دزدگیر
  Checkbox Should Be Selected         name:checkbox-450703
  Select Checkbox                     name:checkbox-450705        #ایربگ
  Checkbox Should Be Selected         name:checkbox-450705
  Select Checkbox                     name=checkbox-450711        #سنسور پارکینگ
  Checkbox Should Be Selected         name:checkbox-450711
  Click Button                        name=select-add-action

Motorcycle Fuel Type
  Click Element                       select-a69606
  Page Should Contain Element         css:[role="listbox"]
  Click Element                       name=450712
  Element Should Contain              select-a69606               بنزین

Motorcycle License Plate Type
  Click Element                       select-a69607
  Page Should Contain Element         css:[role="listbox"]
  Click Element                       name=450714
  Element Should Contain              select-a69607               ملی

Upload Image
  Execute JavaScript                  window.scrollTo(0,0)
  ${image_path}                       Normalize Path             ${image_path}
  Choose File                         name=select-images-action  ${image_path}
  Wait Until Page Contains Element    name:form-delete-action    timeout=5s
