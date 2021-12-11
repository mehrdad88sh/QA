*** Settings ***
Documentation                         حذف منشی و مشاور از فروشگاه پنل آلونک
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Test Cases ***
Remove Secretary And Consultant From Shop
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Back To Protools Page
  Go To Team Management Page
  Add New Colleague                   منشی
  Validate New Colleague
  Remove Secretary
  Add New Colleague                   مشاور
  Validate New Colleague
  Remove Consultant

*** Keywords ***
Remove Consultant
  Reload Page
  Wait Until Page Contains            افزودن همکار جدید                     timeout=3s
  Click Element                       name:member-${Random_User_Mobile}
  Wait Until Page Contains Element    ${Colleague_Menu}
  Click Element                       ${Colleague_Delete_Button}
  Wait Until Page Contains            آیا از حذف این کاربر مطمئن هستید؟
  Click Element                       ${Confirm_Button}
  Wait Until Page Contains            همکار با موفقیت حذف شد

Remove Secretary
  Reload Page
  Wait Until Page Contains            افزودن همکار جدید                     timeout=3s
  Click Element                       name:member-${Random_User_Mobile}
  Wait Until Page Contains Element    ${Colleague_Menu}
  Click Element                       ${Colleague_Delete_Button}
  Wait Until Page Contains            آیا از حذف این کاربر مطمئن هستید؟
  Click Element                       ${Confirm_Button}
  Wait Until Page Contains            همکار با موفقیت حذف شد
  Reload Page

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
    Element Should Contain              ${Adding_Snackbar}                همکار با موفقیت اضافه شد
