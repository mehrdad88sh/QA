*** Settings ***
Library                               SeleniumLibrary                      timeout=30s
Library                               Collections
Library                               String
Library                               FakerLibrary                         locale=fa_IR
Library                               OperatingSystem
Variables                             Variables.py

*** Variables ***
${Images_Realestate_path}             ${CURDIR}/images

*** Keywords ***
Open Browser In Test Enviroment
  [Arguments]                         ${ENV}=staging
  Open Browser                        chrome://version                      browser=chrome
  Maximize Browser Window
  Go To                               https://${ENV}.mielse.com/
  Wait Until Page Contains            ${Home_Page_Message}             timeout=10s

Login Sheypoor
  Click My Account Button
  Click Login/Register Button
  Input Phone Number
  Input Verification Code
  Wait Until Page Contains            ${My_Listing_Message}                 timeout=3s

Click My Account Button
  Click Element                       ${My_account_button}
  Wait Until Page Does Not Contain Element    ${My_Account_Icon_Loading}    timeout=5s

Click Login/Register Button
  Click Link                          ${Login_Register_Button}
  Wait Until Page Contains            ${Login_Message}                     timeout=10s

Input Phone Number
  Input Text                          ${Mobile_Number_TextField}            09007000000
  Click Button                        ${Login_Button}
  Wait Until Page Contains            ${Phone_Number_Verification_Message}  timeout=3s

Input Verification Code
  Input Text                          ${Verfication_Code_Textfield}         1234
  Click Element                       ${Confirm_Button}

Click By Text
  [Arguments]                         ${Text}
  Click Element                       //*[contains(text(),'${Text}')]

Upload Images
  Element Should Contain              ${Image_placeholder}                  افزودن عکس
  FOR                                 ${INDEX}   IN RANGE    1   4
   Choose File                        ${Upload_file_attach}                 ${Images_Realestate_path}/0${INDEX}.jpg
   Wait Until Page Does Not Contain Element                                 ${Image_loading}            timeout=30s
  END

Go To Post Listing Page
  Click Button                         ${Free_Listing_Submit_Button}
  Wait Until Page Contains             ${Form_Clear_Button}                     timeout=5s

Select A Category From Categories List
  Choose Category Component
  Select Category                      43603
  Select A SubCategory                 43606

Choose Category Component
  Click Element                        ${Listing_Select_Category}
  Wait Until Page Contains Element     ${Categories_list}                       timeout=3s
  Wait Until Page Does Not Contain Element                                      ${Categories_Loding_Icon}        timeout=3s

Select Category
  [Arguments]                          ${Category_ID}
  Click Element                        ${Main_Categry.format('${Category_ID}')}
  Wait Until Page Contains Element     ${SubCategories_list}                    timeout=3s

Select A SubCategory
  [Arguments]                          ${SubCategory_ID}
  Click Element                        ${Sub_Category.format('${SubCategory_ID}')}
  Wait Until Page Does Not Contain Element                                      ${SubCategories_list}            timeout=3s

Submit Listing
  Click Element                        ${Submit_Listing_Button}
  Wait Until Page Contains             ${Successful_Post_Listing_Message}       timeout=5s

Set Title And Description
  Set Listing Title
  Set Listing Description

Set Listing Title
  ${Listing_Title}                     Sentence                                 nb_words=6
  Input Text                           ${Listing_Title_TextField}               ${Listing_Title}
  Set Test Variable                    ${Listing_Title}

Set Listing Description
  ${Listing_Description}               Sentence                                 nb_words=20
  Input Text                           ${Listing_Description_TextField}         ${Listing_Description}

Set Location
  Choose Location Component
  Select Province
  Select City
  Check Location Component

Select Province
  Get Provinces ID
  Get The Selected Province Name
  Select Province From List

Select City
  Get Cities ID
  Get The Selected City Name
  Select City From List

Select District
  Get The Selected District Name
  Select District From List

Get Provinces ID
  Append Provinces ID In A List
  Generate Random_Number 0 To Province_Count

Get Cities ID
  Append Cities ID In A List
  Generate Random_Number 0 To Cities_Count

Get Districts ID
  Append Districts ID In A List
  Generate Random_Number 0 To Districts_Count

Append Provinces ID In A List
  Get Province Count
  Append Provinces To List

Append Cities ID In A List
  Get Cities Count
  Append Cities To List

Append Districts ID In A List
  Get Districts Count
  Append Districts To List

Select Province From List
  Set Test Variable                    ${Location_ID}                           ${Provinces_ID}[${Random_Number}]
  Click Element                        ${Select_Province.format('${Location_ID}')}
  Wait Until Page Contains Element     ${Cities_List}                           timeout=5s

Select City From List
  Set Test Variable                    ${Location_ID}                           ${Cities_ID}[${Random_Number}]
  Check The Selected City Has A Neighborhood Or Not

Select District From List
  Set Test Variable                    ${Location_ID}                           ${Districts_ID}[${Random_Number}]
  Click Element                        ${Select_District.format('${Location_ID}')}
  Wait Until Page Does Not Contain Element                                      ${Popup_Title}             timeout=5s

Get The Selected Province Name
  ${The_Selected_Province_Name}        Get Text
  ...                                  ${Select_Province.format('${Provinces_ID}[${Random_Number}]')}
  Set Test Variable                    ${The_Selected_Province_Name}

Get The Selected City Name
  ${The_Selected_City_Name}            Get Text
  ...                                  ${Select_City.format('${Cities_ID}[${Random_Number}]')}
  Set Test Variable                    ${The_Selected_City_Name}

Get The Selected District Name
  ${The_Selected_District_Name}        Get Text
  ...                                  ${Select_District.format('${Districts_ID}[${Random_Number}]')}
  Set Test Variable                    ${The_Selected_District_Name}

Generate Random_Number 0 To Province_Count
  ${Random_Number}                     Evaluate  random.randint(0,${Province_Count-2})  random
  Set Test Variable                    ${Random_Number}

Generate Random_Number 0 To Cities_Count
  ${Random_Number}                     Evaluate  random.randint(0,${Cities_Count-1})  random
  Set Test Variable                    ${Random_Number}

Generate Random_Number 0 To Districts_Count
  ${Random_Number}                     Evaluate  random.randint(0,${Districts_Count-1})  random
  Set Test Variable                    ${Random_Number}

Check The Selected City Has A Neighborhood Or Not
  ${status}                            Run Keyword And Return Status
  ...                                  Page Should Contain Element
  ...                                  ${Select_City.format('${Location_ID}')} span
  Set Test Variable                    ${status}
  IF    ${status}
        Click Element                  ${Select_City.format('${Location_ID}')}
        Wait Until Page Contains Element                                        ${Districts_List}   timeout=5s
        Get Districts ID
        Select District
  ELSE
        Click Element                  ${Select_City.format('${Location_ID}')}
        Wait Until Page Does Not Contain Element                                ${Popup_Title}      timeout=5s
        Input Custom District
  END

Get Province Count
  ${Province_Count}                    Get Element Count                        ${Province_Count}
  Set Test Variable                    ${Province_Count}

Get Cities Count
  ${Cities_Count}                      Get Element Count                        ${Cities_Count}
  Set Test Variable                    ${Cities_Count}

Get Districts Count
  ${Districts_Count}                   Get Element Count                        ${Districts_Count}
  Set Test Variable                    ${Districts_Count}

Append Provinces To List
  ${Provinces_ID}                      Create List
  FOR   ${INDEX}     IN RANGE          2   ${Province_Count+1}
    ${Provinces_Attribute}             Get Element Attribute
    ...                                ${Provinces_List_Popup.format('${INDEX}')}
    ...                                data-test-id
    ${ID}                              Fetch From Right    ${Provinces_Attribute}   t-province-
    Append To List                     ${Provinces_ID}                          ${ID}
  END
  Set Test Variable                    ${Provinces_ID}

Append Cities To List
  ${Cities_ID}                         Create List
    FOR   ${INDEX}     IN RANGE        1   ${Cities_Count+1}
      ${Cities_Attribute}              Get Element Attribute
      ...                              ${Cities_List_Popup.format('${INDEX}')}
      ...                              data-test-id
      ${ID}                            Fetch From Right    ${Cities_Attribute}  t-city-
      Append To List                   ${Cities_ID}                             ${ID}
    END
    Set Test Variable                  ${Cities_ID}

Append Districts To List
  ${Districts_ID}                      Create List
    FOR   ${INDEX}     IN RANGE        1   ${Districts_Count+1}
      ${Districts_Attribute}           Get Element Attribute
      ...                              ${Districts_List_Popup.format('${INDEX}')}
      ...                              data-test-id
      ${ID}                            Fetch From Right    ${Districts_Attribute}  t-district-
      Append To List                   ${Districts_ID}                          ${ID}
    END
    Set Test Variable                  ${Districts_ID}

Input Custom District
  ${Custom_District}                   City
  Input Text                           ${Neighborhood_TextField}                ${Custom_District}
  Set Test Variable                    ${Custom_District}

Check Location Component
  ${Location_Component_Value}          Get Value                                ${Location_Label}
  IF    ${status}
        Should Be Equal                ${Location_Component_Value}
        ...                            ${The_Selected_Province_Name} > ${The_Selected_City_Name} > ${The_Selected_District_Name}
  ELSE
        Should Be Equal                ${Location_Component_Value}
        ...                            ${The_Selected_Province_Name} > ${The_Selected_City_Name}
  END

Choose Location Component
  Click Element                        ${Location_Component}
  Wait Until Page Contains Element     ${Provinces_List}                        timeout=5s


Validate Listing In Serp Page
  Go To                                https://staging.mielse.com/ایران
  Wait Until Keyword Succeeds          3x    2s     Wait Until Listing Is Appeared

Wait Until Listing Is Appeared
  ${key}                               Generate Random String     6
  ${value}                             Generate Random String     6     [NUMBERS]
  ${location}                          Get Location
  Go To                                ${location}?${key}=${value}
  Wait Until Page Contains Element     ${Listing_In_Serp.format('${Listing_Title}')}          timeout=3s
