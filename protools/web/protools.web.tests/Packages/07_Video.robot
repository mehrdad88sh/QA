*** Settings ***
Documentation                         خرید بسته ویدئو مشاور
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${video}                              ۱۰۰ بسته

*** Test Cases ***
Buy Consultant Video Package
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Go To Consultants List Page
  Validate Consultant Phone Number
  Go To Consultant Package Page
  Activate Video Package
  Validate Video Package In My Packages

*** Keywords ***
Go To Consultants List Page
  Go To                               ${Consultants_List_Page}

Validate Consultant Phone Number
  Input Text                          name:mobile                             ${Random_User_Mobile}
  Click Element                       ${Search_Button}
  Element Text Should Be              ${Consultant_Number}                    ${Random_User_Mobile}
  Element Should Contain              ${Consultant_Status}                    فعال

Go To Consultant Package Page
  Wait Until Keyword Succeeds         2x    2s     Click By Text              بسته مشاور
  Wait Until Page Contains            ویدئو                                   timeout=10s

Activate Video Package
  Click By Text                       ویدئو
  Checkbox Should Be Selected         ${CheckBox_Video}
  Input Text                          //*[@id="consultant-packages"]/div/div[1]/div/section/div[6]/div/div/div[2]/input     100
  Input Text                          ${Consultant_Package_Price}             50000
  Input Text                          ${Consultant_Package_Duration}          30
  Click Element                       ${Add_Button}
  Wait Until Page Contains            ۵۰۰۰۰                                   timeout=10s
  Click Element                       ${Activation_Button}
  Wait Until Page Contains            فعال‌‌سازی این بسته غیرقابل بازگشت خواهد بود. آیا از فعال‌سازی اطمینان دارید؟            timeout=10s
  Wait Until Keyword Succeeds         2x    2s     Click By Text    بله
  Wait Until Keyword Succeeds         2x    2s     Element Should Contain     ${Consultant_Package_Status}                  فعال شده
  Click Element                       ${Consultant_Package_Details}
  Wait Until Page Contains            ویدئو 100 عدد                           timeout=10s

Validate Video Package In My Packages
  Go To                               ${staging}/pro/real-estate/packages
  Wait Until Page Contains            ظرفیت آپلود ویدئو                       timeout=10s
  Element Text Should Be              ${Video_Package_Number}                 ${video}
