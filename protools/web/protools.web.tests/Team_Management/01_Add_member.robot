*** Settings ***
Documentation                         اضافه کردن منشی و مشاور به فروشگاه از پنل آلونک
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Test Cases ***
Add Secretary And Consultant In Shop
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Back To Protools Page
  Go To Team Management Page
  Add New Colleague                   منشی
  Validate New Colleague
  Add New Colleague                   مشاور
  Validate New Colleague

*** Keywords ***
Add New Colleague
  [Arguments]                         ${Colleague_Type}
  Click Button                        ${Add_New_Colleague}
  Wait Until Page Contains            در هر زمان می توانید از طریق صفحه مدیریت تیم، نقش همکار را تغییر دهید.     timeout=3s
  Input Random User Name
  Input Random Mobile
  Select Colleague Role               ${Colleague_Type}
  Submit Colleague

Validate New Colleague
  Page Should Contain                 ${Random_User_Name}

Select Colleague Role
  [Arguments]                         ${Colleague_Type}
  Wait Until Page Contains Element    ${Secretary}
  IF                                  "${Colleague_Type}" == "مشاور"
  Click Element                       ${Consultant}
  ELSE IF                             "${Colleague_Type}" == "منشی"
  Click Element                       ${Secretary}
  END

Submit Colleague
  Click Button                        name:apply-action
  ${status}                           Run Keyword And Return Status     Wait Until Page Contains    این کاربر در فروشگاه دیگری عضو می باشد.       timeout=3s
  Run Keyword If                      ${status}                         Input Random Mobile
  Element Should Contain              ${Adding_Snackbar}        همکار با موفقیت اضافه شد
