*** Settings ***
Documentation                        Base resource file for All tests
Library                              SeleniumLibrary
Variables                            ../protools/web/variables/Variables.py
Resource                             ../protools/web/resources/resource.robot

*** Keywords ***
Login Admin Page
  Go To                              ${Admin_Page}
  ${User_Is_Loggedin}                Run Keyword And Return Status   Wait Until Page Contains Element    id:email     timeout=5s
  Run Keyword If	                   ${User_Is_Loggedin}             Input Login Form

Input Login Form
  Input Text                         name:email                      ${Admin_User}
  Input Text                         name:password                   trumpet
  Click Element                      css:button.btn.btn-primary
  Wait Until Page Contains           داشبورد

Click By Text
  [Arguments]                        ${Text}
  Click Element                      //*[contains(text(),'${Text}')]

Generate Random username
  ${prefix_name}                     Prefix
  ${first_name}                      First Name
  ${last_name}                       Last Name
  Set Suite Variable                 ${Random_User_Name}             ${prefix_name} ${first_name} ${last_name}

Generate Random AboutMe Sentence
  ${aboutme}                         Sentence                        nb_words=30
  Set Suite Variable                 ${Random_AboutMe_Sentence}      ${aboutme}

Create Shop In Sheypoor
  Login Admin Page
  Go To                              ${staging}/trumpet/shop/profile/new
  Wait Until Page Contains           فروشگاه جدید
  Generate Random Shop Name
  Generate Random Slug
  Input Owner Shop Phone
  Registration Consultant
  Generate Random Address
  Generate Random Email
  Generate Random Website
  Input Primary Phone
  Generate Random Other Phone
  Select Shop Category
  Fill Description
  Fill Business Slogan
  Add Latitude
  Add Longitude
  Add Social Media
  Apply Shop

Generate Random Shop Name
  ${Company}                         Company
  Input Text                         Title                           ${Company}
  Set Suite Variable                 ${Company}

Generate Random Slug
  ${Slug}                            Lexify
  Input Text                         Slug                            ${Slug}

Input Owner Shop Phone
  Input Text                         OwnerPhone                      ${Random_User_Mobile}

Generate Random Consultant Phone
  ${Random_Number}                   Generate Random String          7   [NUMBERS]
  Set Suite Variable                 ${Random_consultant_Mobile}     0900${Random_Number}

Registration Consultant
  FOR   ${INDEX}   IN RANGE   2
    Click By Text                    ثبت مشاور
    Generate Random Consultant Phone
    ${ConsultantPhones}              Get WebElements                 name:ConsultantPhones[]
    ${ConsultantRoles}               Get WebElements                 name:ConsultantRoles[]
    IF                               "${INDEX}" == "${1}"
    Select From List By Value        ${ConsultantRoles}[${1}]        1
    END
    Input Text                       ${ConsultantPhones}[${INDEX}]   ${Random_consultant_Mobile}
    ${ConsultantNameElements}        Get WebElements                 name:ConsultantNames[]
    ${ConsultantNames}               Last Name
    Input Text                       ${ConsultantNameElements}[${INDEX}]       ${ConsultantNames}
  END

Generate Random Address
  ${Address}                         Address
  Input Text                         name:Address                    ${Address}

Generate Random Email
  ${Email}                           Company Email
  Input Text                         name:Email                      ${Email}

Generate Random Website
  ${Website}                         Url
  Input Text                         Website                         ${Website}

Input Primary Phone
  Input Text                         PrimaryPhone                    ${Random_User_Mobile}

Generate Random Other Phone
  FOR   ${INDEX}   IN RANGE   2
    Click By Text                    ثبت شماره تماس های دیگر
    Generate Random Consultant Phone
    ${OtherPhones}                   Get WebElements                 name:ShopPhonesMultiple[]
    Input Text                       ${OtherPhones[${INDEX}]}        ${Random_consultant_Mobile}
    Sleep    1s
  END

Select Shop Category
  Select From List By Value          id:CategoryId                   43603
  Element Should Contain             CategoryId                      املاک

Fill Description
  ${Description}                     sentence                        nb_words=6
  Input Text                         Description                     ${Description}

Fill Business Slogan
  ${TagLine}                         sentence                        nb_words=6
  Input Text                         TagLine                         ${TagLine}

Add Latitude
  ${Latitude}                        Latitude
  Input Text                         Latitude                        ${Latitude}

Add Longitude
  ${Longitude}                       Longitude
  Input Text                         Longitude                       ${Longitude}

Add Social Media
  Click By Text                      افزودن شبکه اجتماعی
  Click Element                      name:socialNetworkTypes[]
  Click By Text                      instagram
  Element Should Contain             name:socialNetworkTypes[]       instagram
  Input Text                         name:socialNetworkUrls[]        https://www.instagram.com/sheypoor

Apply Shop
  Replace Arabic Fonts               ${Company}
  Click Element                      css:input.btn.btn-success
  Wait Until Page Contains           ${Company}

Replace Arabic Fonts
    [Arguments]                      ${Company}
    ${Company}                       Replace String                  ${Company}  ي  ی
    ${Company}                       Replace String                  ${Company}  ى  ی
    ${Company}                       Replace String                  ${Company}  ك  ک
    Set Test Variable                ${Company}

Go To Alunak Page
  Go To                              ${staging}/pro/real-estate
  Wait Until Page Contains Element   ${profile_name_ID}              timeout=5s
