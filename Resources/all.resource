*** Settings ***
Documentation                        Base resource file for All tests
Library                              SeleniumLibrary
Variables                            ../protools/web/variables/Variables.py
Resource                             ../protools/web/resources/resource.robot


*** Keywords ***
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
    Input Text                       ${ConsultantPhones[${INDEX}]}   ${Random_consultant_Mobile}
    Sleep    1s
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
  Click Element                      //*[@id="CategoryId"]/option[2]
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
    ${Company}                       Replace String                 ${Company}  ي  ی
    ${Company}                       Replace String                 ${Company}  ى  ی
    ${Company}                       Replace String                 ${Company}  ك  ک
    Set Test Variable                ${Company}

Go To Alunak Page
  Go To                              ${staging}/pro/real-estate
  Wait Until Page Contains Element   ${profile_name_ID}             timeout=5s
