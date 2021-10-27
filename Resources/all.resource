*** Settings ***
Documentation                        Base resource file for All tests
Library                              SeleniumLibrary
Library                              REST                            https://staging.mielse.com/api/protools
Library                              JSONLibrary
Variables                            ../protools/web/variables/Variables.py
Resource                             ../protools/web/resources/resource.robot

*** Keywords ***
Login Admin Page
  Go To                              ${Admin_Page}
  ${User_Is_Loggedin}                Run Keyword And Return Status   Wait Until Page Contains Element    id:email     timeout=10s
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
  ${prefix_name}                     Prefix Male
  ${first_name}                      First Name Male
  ${last_name}                       Last Name Male
  Set Suite Variable                 ${Random_User_Name}             ${prefix_name} ${first_name} ${last_name}

Generate Random AboutMe Sentence
  ${aboutme}                         Sentence                        nb_words=30
  Set Suite Variable                 ${Random_AboutMe_Sentence}      ${aboutme}

Create Shop In Sheypoor
  [Arguments]                        ${Category}
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
  Select Shop Category               ${Category}
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
  Set Suite Variable                 ${Random_User_Mobile}           ${Random_User_Mobile}

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
    Input Text                       ${ConsultantNameElements}[${INDEX}]                       ${ConsultantNames}
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
  [Arguments]                        ${Category}
  IF                                 "${Category}" == "خودرو"
  Select From List By Value          id:SubCategoryId                43627
  Element Should Contain             SubCategoryId                   خودرو
  ELSE IF                            "${Category}" == "املاک"
  Select From List By Value          id:CategoryId                   43603
  Element Should Contain             CategoryId                      املاک
  END

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

Back To Protools Page
  Go To                              ${staging}/pro/real-estate
  Wait Until Page Contains Element   ${profile_name_ID}              timeout=10s

Back To Sheypoor Car Page
  Go To                              ${staging}/pro/cars
  Wait Until Page Contains Element   ${profile_name_ID}              timeout=10s

Register Manager With Alunak Api
  Post                               /v2/auth/register
  ...                                {"cellphone": "${Random_User_Mobile}", "user_type": "real-estate"}
  Integer                            response status                 200
  ${response}                        output                          response body
  ${token}                           Get Value From Json             ${response}                $.token
  ${token}                           Convert To String               ${token[0]}
  Set Suite Variable                 ${token}                        ${token}

Get Code From Mock Server With Alunak Api
  Get                                ${staging}/mock/getCode?mobile=${Random_User_Mobile}
  ...                                headers={"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
  Integer                            response status                 200
  ${response}                        output                          response body
  ${Code}                            Get Value From Json             ${response}                $.code
  ${Code}                            Convert To String               ${Code[0]}
  Set Suite Variable                 ${Code}                         ${Code}

Authorization Manager With Alunak Api
  Post                               /v2/auth/authorize
  ...                                {"grant_type": "password", "username": "${token}", "password": "${Code}", "scope": "full"}
  Integer                            response status                 200
  ${response}                        output                          response body
  ${access_token}                    Get Value From Json             ${response}                $.access_token
  ${access_token}                    Convert To String               ${access_token[0]}
  Set Suite Variable                 ${access_token}                 ${access_token}

Get List Of Members In Alunak Api
  Set Headers                        {"X-Ticket": "${access_token}"}
  Set Headers                        {"source": "protools"}
  Get                                /v2/bank/members/list
  Integer                            response status                 200
  ${response}                        output                          response body
  ${Secretary_Phone}                 Get Value From Json             ${response}                $[0].cellphone
  ${Secretary_Phone}                 Convert To String               ${Secretary_Phone[0]}
  Set Suite Variable                 ${Secretary_Phone}              ${Secretary_Phone}
  ${Secretary_Name}                  Get Value From Json             ${response}                $[0].full_name
  ${Secretary_Name}                  Convert To String               ${Secretary_Name[0]}
  Set Suite Variable                 ${Secretary_Name}               ${Secretary_Name}
  ${Consultant_Phone}                Get Value From Json             ${response}                $[1].cellphone
  ${Consultant_Phone}                Convert To String               ${Consultant_Phone[0]}
  Set Suite Variable                 ${Consultant_Phone}             ${Consultant_Phone}
  ${Consultant_Name}                 Get Value From Json             ${response}                $[1].full_name
  ${Consultant_Name}                 Convert To String               ${Consultant_Name[0]}
  Set Suite Variable                 ${Consultant_Name}              ${Consultant_Name}

Get Listing ID From API   
  Register Manager With Alunak Api
  Get Code From Mock Server With Alunak Api
  Authorization Manager With Alunak Api
  Set Headers                        {"X-Ticket": "${access_token}"}
  Set Headers                        {"source": "protools"}
  Get                                /v2/listings?active=true&published=true
  Integer                            response status                 200
  ${response}                        output                          response body
  ${ID}                              Get Value From Json             ${response}                $.items[0].human_readable_id
  ${ID}                              Convert To String               ${ID[0]}
  Set Suite Variable                 ${ID}                           ${ID}

Get Listing ID From Listing Details
  ${URL}                             Get Location
  ${Listing_ID}                      Get Regexp Matches              ${URL}     \\d{6,10}
  ${Listing_ID}                      Convert To String               ${Listing_ID[0]}
  Set Suite Variable                 ${Listing_ID}                   ${Listing_ID}

Login Sheypoor
  Go To                              ${staging}/session
  Generate Random Phone Number
  Input Text                         name:username                   ${Random_User_Mobile}
  Click By Text                      ورود یا ثبت نام در شیپور
  Get Code From Mock Server With Alunak Api
  Input Verification Code In Sheypoor
  Wait Until Page Contains           آگهی‌‌های من                      timeout=10s

Logout Sheypoor
  Go To                              ${staging}/session/logout

Generate Random Phone Number
  ${Random_User_Mobile}              Generate Random String          7   [NUMBERS]
  Set Suite Variable                 ${Random_User_Mobile}           0900${Random_User_Mobile}

Input Verification Code In Sheypoor
  Wait Until Page Contains           تائید شماره موبایل              timeout=10s
  Input Text                         name:verification_code          ${Code}
  Click By Text                      تائید نهایی و ورود به شیپور

Go To User Comments
  Go To                              ${User_Comments_Page}
  Wait Until Page Contains           نظر کاربر                       timeout=10s

Go To Listing In Sheypoor Page
  Go To                              ${staging}/${Listing_ID}
  Wait Until Page Contains           مشاور این آگهی                  timeout=10s
