*** Settings ***
Documentation                          ثبت اگهی در گروه رهن و اجاره
Resource                               ../../resources/resource.resource
Test Setup                             Run Keywords
...                                    Open Browser In Test Enviroment
...                                    Login Sheypoor
Test Teardown                          Close Browser

*** Test Cases ***
Post Listing In Categories
  Go To Post Listing Page
  Select A Category From Categories List
  Set Location
  Set Rent And Deposit Attributes
  Upload Images
  Set Title And Description
  Submit Listing
  Validate Listing In Serp Page

*** Keywords ***
Set Rent And Deposit Attributes
  Set Area
  Set Property Type
  Set Year Of Construction
  Select Parking
  Set Number Of Room

Set Area
  ${Area_Value}                        Evaluate  random.randint(80, 200)        random
  Input Text                           ${Area}                                  ${Area_Value}
  Textfield Value Should Be            ${Area}                                  ${Area_Value}

Set Property Type
  Choose Property Type Component
  Select Apartmant Attribute

Set Year Of Construction
  Choose Year Of Construction Component
  Select Year Of Construction 1396

Set Number Of Room
  Choose Number Of Room Component
  Select Number Of Room 3

Choose Property Type Component
  Click Element                        ${Property_Type_Component}
  Wait Until Element Contains          ${Popup_Title}                           ${Property_Type_Title}     timeout=3s

Select Apartmant Attribute
  Click Element                        ${Apartmant_Attribute}
  Element Attribute Value Should Be    ${Property_Type_Component_Contain}       value                      ${Apartmant}

Select Year Of Construction 1396
  Click Element                        ${Year_Of_Construction_1396}
  Element Attribute Value Should Be    ${Year_Of_Construction_Component_Contain}   value                  ۱۳۹۶

Choose Year Of Construction Component
  Click Element                        ${Year_Of_Construction_Component}
  Wait Until Page Contains Element     ${Popup_Title}                           timeout=3s

Select Parking
  Click Element                        ${Parking_CheckBox}
  Element Attribute Value Should Be    ${Parking_Selected_CheckBox}             value      true

Choose Number Of Room Component
  Click Element                        ${Number_Of_Room_Component}
  Wait Until Page Contains Element     ${Popup_Title}                           timeout=3s

Select Number Of Room 3
  Click Element                        ${Number_Of_Room_3}
  Element Attribute Value Should Be    ${Number_Of_Room_Component_Contain}      value      ۳
