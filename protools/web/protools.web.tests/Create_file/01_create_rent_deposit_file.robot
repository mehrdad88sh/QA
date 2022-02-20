*** Settings ***
Documentation                         ثبت فایل در گروه بندی رهن و اجاره خانه و آپارتمان
Resource                              ../../../../Resources/all.resource
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
Create Files In Realestate Category
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Back To Protools Page
  Create File In Rent And Deposit Category

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

Set Rent And Deposit Attributes
  Select RealEstate Type              ${RealEstateType}[RD]     ${ApartmentID}[RD]    ${Apartment}
  Select Year Of Construction
  Set Building Floor
  Select Parking For Rent And Deposit Category
  Select Warehouse For Rent And Deposit Category
  Select Elevator For Rent And Deposit Category
  Set Area
  Number Of Rooms
  Set More Detail
  Set Property Facilities
  Price Deposit
  Price Rent
  Ability To Convert Rent And Deposit

Set More Detail
  Select More Detail Button
  Villa Type
  Deed Type
  Number Of Floor
  Number Of Units Per Floor
  Resident Status
  Land Area
  Select Geo Location Building
  Select Geo Location Unit
  Number Of Parking
  File Code
  Apply More Detail
  Wait Until Page Contains           ۱۰

Set Property Facilities
  Select Property Facilities Button
  Building Facade
  Kitchen
  Cabinet
  Floor Covering
  Heating And Cooling System
  Amenities And Recreation
  Sports Facilities
  Security features
  Other Facilities
  Apply Property Facilities
  Wait Until Page Contains            ۹

Select Geo Location Building
  Click Element                       name:a69252-trigger
  Wait Until Page Contains            شمالی                     timeout=10s
  Select North Position

Select Geo Location Unit
  Click Element                       name:a69257-trigger
  Wait Until Page Contains            شرقی                     timeout=10s
  Select Eastern Position

Number Of Parking
  Click Element                       select-a69262
  Wait Until Page Contains Element    css:[role="listbox"]     timeout=10s
  Click Element                       name:450100
  Element Text Should Be              select-a69262             بدون پارکینگ

Number Of Floor
  Input Text                          name:a69267               ${numFloor}

Number Of Units Per Floor
  Input Text                          name:a69272               ${numOfUnitsPerFloor}

Resident Status
  Click Element                       select-a69277
  Wait Until Page Contains Element    css:[role="listbox"]     timeout=10s
  Click Element                       name:450111
  Element Text Should Be              select-a69277             مستأجر

Deed Type
  Click Element                       select-a69282
  Wait Until Page Contains Element    css:[role="listbox"]     timeout=10s
  Click Element                       name:450122
  Element Text Should Be              select-a69282             بنیادی

Land Area
  Input Text                          name:a69287               ${landArea}

Villa Type
  Click Element                       select-a69292
  Wait Until Page Contains Element    css:[role="listbox"]     timeout=10s
  Click Element                       name:450132
  Element Text Should Be              select-a69292             دوبلکس

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

Select Parking For Rent And Deposit Category
  Click Element                       name:switch-a69191
  Checkbox Should Be Selected         name:a69191

Select Warehouse For Rent And Deposit Category
  Click Element                       name:switch-a69193
  Checkbox Should Be Selected         name:a69193

Select Elevator For Rent And Deposit Category
  Click Element                       name:switch-a69195
  Checkbox Should Be Selected         name:a69195

Price Deposit
  Input Text                          name:a68090              ${priceDeposit}

Price Rent
  Input Text                          name:a68092              ${priceRent}

Ability To Convert Rent And Deposit
  Click Element                       name:switch-a68190
  Checkbox Should Be Selected         name=a68190

Building Facade
  Click Element                       ${Building_Facade}
  Wait Until Page Contains Element    ${Cement}              timeout=5s
  Click Element                       ${Cement}
  Click Element                       name:select-add-action
  Textfield Should Contain            name:a95000             سیمانی

Kitchen
  Click Element                       ${Kitchen}
  Wait Until Page Contains Element    ${Open}                timeout=5s
  Click Element                       name:457502
  Click Element                       name:457505
  Click Element                       name:457507
  Click Element                       name:select-add-action
  Textfield Should Contain            name:a95001             گاز رومیزی, نورگیر سقفی, هواکش

Cabinet
  Click Element                       ${Cabinet}
  Wait Until Page Contains Element    ${MDF}                 timeout=5s
  Click Element                       name:457581
  Click Element                       name:457584
  Click Element                       name:457587
  Click Element                       name:select-add-action
  Textfield Should Contain            name:a95002            فایبرگلاس, فلزی, روکش چوب

Floor Covering
  Click Element                       ${Floor_Covering}
  Wait Until Page Contains Element    ${Parquet}             timeout=5s
  Click Element                       name:457601
  Click Element                       name:457605
  Click Element                       name:457608
  Click Element                       name:select-add-action
  Textfield Should Contain            name:a95003            موکت, کاشی, لمینت

Heating And Cooling System
  Click Element                       ${Heating_And_Cooling_System}
  Wait Until Page Contains Element    ${Package}             timeout=5s
  Click Element                       name:457702
  Click Element                       name:457705
  Click Element                       name:457707
  Click Element                       name:select-add-action
  Textfield Should Contain            name:a95004            گرمایش از کف, شومینه, یونیت هیتر

Amenities And Recreation
  Click Element                       ${Amenities_And_Recreation}
  Wait Until Page Contains Element    ${Lobby}               timeout=5s
  Click Element                       name:457802
  Click Element                       name:457804
  Click Element                       name:457806
  Click Element                       name:select-add-action
  Textfield Should Contain            name:a95005            باربیکیو, حیاط خلوت, فضای سبز

Sports Facilities
  Click Element                       ${Sports_Facilities}
  Wait Until Page Contains Element    ${Yoga_Salon}          timeout=5s
  Click Element                       name:457872
  Click Element                       name:457875
  Click Element                       name:457877
  Click Element                       name:select-add-action
  Textfield Should Contain            name:a95006            استخر مشاع, سالن بدنسازی, میز پینگ پنگ

Security Features
  Click Element                       ${Security_Features}
  Wait Until Page Contains Element    ${Janitor}             timeout=5s
  Click Element                       name:457901
  Click Element                       name:457904
  Click Element                       name:457906
  Click Element                       name:select-add-action
  Textfield Should Contain            name:a95007            اعلام حریق, دزد گیر, سرایدار

Other Facilities
  Click Element                       ${Other_Facilities}
  Wait Until Page Contains Element    ${Patio}               timeout=5s
  Click Element                       name:458001
  Click Element                       name:458004
  Click Element                       name:458007
  Click Element                       name:select-add-action
  Textfield Should Contain            name:a95008            خواب مستر, مبله, نشیمن مجزا
