*** Settings ***
Documentation                         ثبت فایل در گروه بندی خرید و فروش خانه و آپارتمان
Resource                              ../../../../Resources/all.resource
Test Setup                            Run Keywords     Open Browser On Test Enviroment
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
  [Tags]                              Listing                   Alunak
  Login Alunak
  Create RealEstate Shop
  Back To Alunak Page
  Create File In Buying And Selling Category
  Convert RealEstate File To Listing

*** Keywords ***
Create File In Buying And Selling Category
  Go To Submit File Page
  Select Buying And Selling Category
  Set Location
  Upload RealEstate Images
  Set Buying And Selling Attributes
  Set Personal Notebook
  Submit File
  Open File And Check Images

Set Buying And Selling Attributes
  Select Property Type In Buying And Selling Category
  Select Year Of Construction
  Set Building Floor
  Select Parking For Buying And Selling Category
  Select Warehouse For Buying And Selling Category
  Select Elevator For Buying And Selling Category
  Set Area
  Number Of Rooms
  Set Property Facilities
  Set More Detail
  Set Price For Buying And Selling Category

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
  Checking Badge Counter On Property Facilities

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
  Checking Badge Counter On More Detail

Building Facade
  Click Element                       ${Building_Facade}
  Wait Until Page Contains Element    ${Cement}               timeout=5s
  Click Element                       ${Cement}
  Click Element                       name:select-add-action
  Textfield Should Contain            name:a95000              سیمانی

Kitchen
  Click Element                       ${Kitchen}
  Wait Until Page Contains Element    ${Open}                 timeout=5s
  Click Element                       name:457502
  Click Element                       name:457505
  Click Element                       name:457507
  Click Element                       name:select-add-action
  Textfield Should Contain            name:a95001             گاز رومیزی, نورگیر سقفی, هواکش

Cabinet
  Click Element                       ${Cabinet}
  Wait Until Page Contains Element    ${MDF}                  timeout=5s
  Click Element                       name:457581
  Click Element                       name:457584
  Click Element                       name:457587
  Click Element                       name:select-add-action
  Textfield Should Contain            name:a95002             فایبرگلاس, فلزی, روکش چوب

Floor Covering
  Click Element                       ${Floor_Covering}
  Wait Until Page Contains Element    ${Parquet}              timeout=5s
  Click Element                       name:457601
  Click Element                       name:457605
  Click Element                       name:457608
  Click Element                       name:select-add-action
  Textfield Should Contain            name:a95003             موکت, کاشی, لمینت

Heating And Cooling System
  Click Element                       ${Heating_And_Cooling_System}
  Wait Until Page Contains Element    ${Package}              timeout=5s
  Click Element                       name:457702
  Click Element                       name:457705
  Click Element                       name:457707
  Click Element                       name:select-add-action
  Textfield Should Contain            name:a95004             گرمایش از کف, شومینه, یونیت هیتر

Amenities And Recreation
  Click Element                       ${Amenities_And_Recreation}
  Wait Until Page Contains Element    ${Lobby}                timeout=5s
  Click Element                       name:457802
  Click Element                       name:457804
  Click Element                       name:457806
  Click Element                       name:select-add-action
  Textfield Should Contain            name:a95005             باربیکیو, حیاط خلوت, فضای سبز

Sports Facilities
  Click Element                       ${Sports_Facilities}
  Wait Until Page Contains Element    ${Yoga_Salon}           timeout=5s
  Click Element                       name:457872
  Click Element                       name:457875
  Click Element                       name:457877
  Click Element                       name:select-add-action
  Textfield Should Contain            name:a95006             استخر مشاع, سالن بدنسازی, میز پینگ پنگ

Security Features
  Click Element                       ${Security_Features}
  Wait Until Page Contains Element    ${Janitor}              timeout=5s
  Click Element                       name:457901
  Click Element                       name:457904
  Click Element                       name:457906
  Click Element                       name:select-add-action
  Textfield Should Contain            name:a95007             اعلام حریق, دزد گیر, سرایدار

Other Facilities
  Click Element                       ${Other_Facilities}
  Wait Until Page Contains Element    ${Patio}                timeout=5s
  Click Element                       name:458001
  Click Element                       name:458004
  Click Element                       name:458007
  Click Element                       name:select-add-action
  Textfield Should Contain            name:a95008             خواب مستر, مبله, نشیمن مجزا

Villa Type
  Click Element                       select-a69242
  Wait Until Page Contains Element    css:[role="listbox"]    timeout=10s
  Click Element                       name:450051
  Element Text Should Be              select-a69242           برج

Deed Type
  Click Element                       select-a69232
  Wait Until Page Contains Element    css:[role="listbox"]    timeout=10s
  Click Element                       name:450043
  Element Text Should Be              select-a69232            تعاونی

Number Of Floor
  Input Text                          name:a69217              ${numFloor}

Number Of Units Per Floor
  Input Text                          name:a69222              ${numOfUnitsPerFloor}

Resident Status
  Click Element                       select-a69227
  Wait Until Page Contains Element    css:[role="listbox"]     timeout=10s
  Click Element                       name:450032
  Element Text Should Be              select-a69227             مالک

Land Area
  Input Text                          name:a69237              ${landArea}

Select Geo Location Building
  Click Element                       name:a69202-trigger
  Wait Until Page Contains            جنوبی                    timeout=10s
  Select Southern Position

Select Geo Location Unit
  Click Element                       name:a69207-trigger
  Wait Until Page Contains            غربی                    timeout=10s
  Select Western Position

Number Of Parking
  Click Element                       select-a69212
  Wait Until Page Contains Element    css:[role="listbox"]    timeout=10s
  Click Element                       name:450025
  Element Text Should Be              select-a69212           ۵ به بالا

File Code
  Input Text                          name:a90105             ${fileCode}

Select Southern Position
  Select Checkbox                     name:checkbox-450001
  Checkbox Should Be Selected         name:checkbox-450001
  Click Button                        name:select-add-action
  Textfield Value Should Be           name:a69202             جنوبی

Select Western Position
  Select Checkbox                     name:checkbox-450013
  Checkbox Should Be Selected         name:checkbox-450013
  Click Button                        name:select-add-action
  Textfield Value Should Be           name:a69207             غربی

Select Parking For Buying And Selling Category
  Click Element                       name:switch-a69190
  Checkbox Should Be Selected         name:a69190

Select Warehouse For Buying And Selling Category
  Click Element                       name:switch-a69192
  Checkbox Should Be Selected         name:a69192

Select Elevator For Buying And Selling Category
  Click Element                       name:switch-a69194
  Checkbox Should Be Selected         name:a69194

Set Price For Buying And Selling Category
  Input Text                          name:price              ${price}

Checking Badge Counter On Property Facilities
  Wait Until Page Contains           ۹

Checking Badge Counter On More Detail
  Wait Until Page Contains           ۱۰
