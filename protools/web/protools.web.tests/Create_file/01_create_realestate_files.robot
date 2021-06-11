*** Settings ***
Documentation                         ثبت فایل در گروه بندی رهن-اجاره و خرید-فروش آپارتمان
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${area}                               85
${priceDeposit}                       300000000
${priceRent}                          2000000
${price}                              850000000
${numFloor}                           3
${numOfUnitsPerFloor}                 5
${landArea}                           300
${fileCode}                           673467
${image_path}                         ${CURDIR}${/}..\/..\/resources\/images\/450E47.jpg

*** Test Cases ***
Create Files In Realestate Categories
  Login Alunak
  Create File In Rent And Deposit Category
  Create File In Buying And Selling Category

*** Keywords ***
Create File In Rent And Deposit Category
  Go To Submit File Page
  Upload RealEstate Images
  Select Rent And Deposit Category
  Set Location
  Set Rent And Deposit Attributes
  Fill File Description
  Set Personal Notebook
  Submit File
  Open File And Check Images

Create File In Buying And Selling Category
  Go To Submit File Page
  Select Buying And Selling Category
  Set Location
  Upload RealEstate Images
  Set Buying And Selling Attributes
  Set Personal Notebook
  Submit File
  Open File And Check Images

Select Rent And Deposit Category
  Click Element                       name:category-trigger
  Wait Until Page Contains Element    css:[role="document"]     timeout=2s
  Click Element                       name:43606
  Textfield Value Should Be           name:category             رهن و اجاره خانه و آپارتمان
  Wait Until Page Contains Element    select-a68096             timeout=2s

Set Rent And Deposit Attributes
  Select RealEstate Type              ${RealEstateType}[RD]     ${ApartmentID}[RD]    ${Apartment}
  Year Of Construction
  Select Parking For Rent And Deposit Category
  Select Warehouse For Rent And Deposit Category
  Select Elevator For Rent And Deposit Category
  Set Area
  Number Of Rooms
  Set More Detail
  Price Deposit
  Price Rent
  Ability To Convert Rent And Deposit

Set More Detail
  Select More Detail Button
  Select Geo Location Building
  Select Geo Location Unit
  Number Of Parking
  Number Of Floor
  Number Of Units Per Floor
  Resident Status
  Deed Type
  Land Area
  Villa Type
  Other Facilities
  File Code
  Apply More Detail

Select Buying And Selling Category
  Select Form Clear Button
  Click Element                       name:category-trigger
  Wait Until Page Contains Element    css:[tabindex="-1"]       timeout=2s
  Click Element                       name:43604
  Textfield Value Should Be           name:category             خرید و فروش خانه و آپارتمان
  Wait Until Page Contains Element    select-a68094             timeout=2s

Set Buying And Selling Attributes
  Select RealEstate Type              ${RealEstateType}[BS]   ${VilaID}[BS]   ${Vila}
  Year Of Construction
  Select Parking For Buying And Selling Category
  Select Warehouse For Buying And Selling Category
  Select Elevator For Buying And Selling Category
  Set Area
  Number Of Rooms
  Set Price For Buying And Selling Category

Select Geo Location Building
  Click Element                       name:a69252-trigger
  Wait Until Page Contains            شمالی                     timeout=2s
  Select North Position

Select Geo Location Unit
  Click Element                       name:a69257-trigger
  Wait Until Page Contains            شرقی                     timeout=2s
  Select Eastern Position

Number Of Parking
  Click Element                       select-a69262
  Wait Until Page Contains Element    css:[role="listbox"]     timeout=2s
  Click Element                       name:450100
  Element Text Should Be              select-a69262             بدون پارکینگ

Number Of Floor
  Input Text                          name:a69267               ${numFloor}

Number Of Units Per Floor
  Input Text                          name:a69272               ${numOfUnitsPerFloor}

Resident Status
  Click Element                       select-a69277
  Wait Until Page Contains Element    css:[role="listbox"]     timeout=2s
  Click Element                       name:450111
  Element Text Should Be              select-a69277             مستأجر

Deed Type
  Click Element                       select-a69282
  Wait Until Page Contains Element    css:[role="listbox"]     timeout=2s
  Click Element                       name:450122
  Element Text Should Be              select-a69282             بنیادی

Land Area
  Input Text                          name:a69287               ${landArea}

Villa Type
  Click Element                       select-a69292
  Wait Until Page Contains Element    css:[role="listbox"]     timeout=2s
  Click Element                       name:450132
  Element Text Should Be              select-a69292             دوبلکس

Other Facilities
  Click Element                       name:a69297-trigger
  Page Should Contain                 بالکن
  Select Checkbox                     name:checkbox-450141      #حیاط
  Checkbox Should Be Selected         name:checkbox-450141
  Select Checkbox                     name:checkbox-450146      #لابی
  Checkbox Should Be Selected         name:checkbox-450146
  Select Checkbox                     name:checkbox-450149      #سرایدار
  Checkbox Should Be Selected         name:checkbox-450149
  Select Checkbox                     name:checkbox-450145      #مبله
  Checkbox Should Be Selected         name:checkbox-450145
  Click Button                        name:select-add-action

File Code
  Input Text                          name:a90105               ${fileCode}

Select North Position
  Select Checkbox                     name:checkbox-450080
  Checkbox Should Be Selected         name:checkbox-450080
  Click Button                        name:select-add-action
  Textfield Value Should Be           name:a69252               شمالی

Select Eastern Position
  Select Checkbox                     name:checkbox-450092
  Checkbox Should Be Selected         name:checkbox-450092
  Click Button                        name:select-add-action
  Textfield Value Should Be           name:a69257               شرقی

Select RealEstate Type
  [Arguments]                         ${RealEstateType}        ${ApartmentID}    ${Apartment}
  Click Element                       ${RealEstateType}
  Wait Until Page Contains Element    css:[role="document"]    timeout=2s
  Click Element                       ${ApartmentID}
  Element Should Contain              ${RealEstateType}        ${Apartment}

Year Of Construction
  ${Status}                           Run Keyword And Return Status
  ...                                 Wait Until Page Contains Element
  ...                                 select-a92367             timeout=1s
  Run Keyword If
  ...                                 ${Status}
  ...                                 Set Year Of Construction For Rent And Deposit Category
  ...                                 ELSE
  ...                                 Set Year Of Construction For Buying And Selling Category

Set Year Of Construction For Rent And Deposit Category
  Click Element                       select-a92367
  Wait Until Page Contains Element    css:[role="listbox"]      timeout=2s
  Click Element                       name:455210
  Element Should Contain              select-a92367             1390

Set Year Of Construction For Buying And Selling Category
  Click Element                       select-a92368
  Wait Until Page Contains Element    css:[role="listbox"]      timeout=2s
  Click Element                       name:455206
  Element Should Contain              select-a92368             1394

Select Parking For Rent And Deposit Category
  Click Element                       name:switch-a69191
  Checkbox Should Be Selected         name:a69191

Select Warehouse For Rent And Deposit Category
  Click Element                       name:switch-a69193
  Checkbox Should Be Selected         name:a69193

Select Elevator For Rent And Deposit Category
  Click Element                       name:switch-a69195
  Checkbox Should Be Selected         name:a69195

Select Parking For Buying And Selling Category
  Click Element                       name:switch-a69190
  Checkbox Should Be Selected         name:a69190

Select Warehouse For Buying And Selling Category
  Click Element                       name:switch-a69192
  Checkbox Should Be Selected         name:a69192

Select Elevator For Buying And Selling Category
  Click Element                       name:switch-a69194
  Checkbox Should Be Selected         name:a69194

Set Area
  Input Text                          name:a68085               85

Set Price For Buying And Selling Category
  Input Text                          name:price                ${price}

Number Of Rooms
  Click Element                       select-a68133
  Wait Until Page Contains Element    css:[role="listbox"]      timeout=2s
  Click Element                       name:439837
  Element Should Contain              select-a68133             بدون اتاق

Price Deposit
  Input Text                          name:a68090              ${priceDeposit}

Price Rent
  Input Text                          name:a68092              ${priceRent}

Ability To Convert Rent And Deposit
  Click Element                       name:switch-a68190
  Checkbox Should Be Selected         name=a68190

Set Personal Notebook
  Click Element                       css:[name="دفترچه شخصی"]
  Wait Until Page Contains            اطلاعات این بخش فقط برای شما نمایش داده می‌شود و پر کردن آن اختیاری است     timeout=2s
  ${first_name}                       First Name
  ${last_name}                        Last Name
  Input Text                          name:a69533             ${first_name} ${last_name}
  ${owner_phone}                      Phone Number
  Input Text                          name:a69534             ${owner_phone}
  ${address}                          Address
  Input Text                          name:a69535             ${address}
  Click Button                        name:apply-action
  Execute JavaScript                  window.scrollTo(0,0)

Open File And Check Images
  Click Element                       name:file-item-0
  Wait Until Page Contains            آگهی نشده
  Reload Page
  FOR                                 ${INDEX}   IN RANGE    3
    Click Element                     name:next-slide
  END
  Element Should Contain              class:slider-control-bottomcenter     ۴ از ۴
