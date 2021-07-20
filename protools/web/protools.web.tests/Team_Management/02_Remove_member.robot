*** Settings ***
Documentation                         حذف منشی و مشاور از فروشگاه پنل آلونک
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Test Cases ***
Remove Secretary And Consultant From Shop
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Go To Alunak Page
  Go To Team Management Page
  Add New Colleague                   منشی
  Remove Secretary
  Add New Colleague                   مشاور
  Remove Consultant

*** Keywords ***
Remove Consultant
  Reload Page
  Wait Until Page Contains            افزودن همکار جدید
  Click Element                       name:member-${Random_User_Mobile}
  Wait Until Page Contains Element    ${Colleague_Menu}
  Click Element                       ${Colleague_Delete_Button}
  Wait Until Page Contains            درخواست حذف همکار
  Click Element                       ${Confirm_Button}
  Wait Until Page Contains            همکار با موفقیت حذف شد

Remove Secretary
  Reload Page
  Wait Until Page Contains            افزودن همکار جدید
  Click Element                       name:member-${Random_User_Mobile}
  Wait Until Page Contains Element    ${Colleague_Menu}
  Click Element                       ${Colleague_Delete_Button}
  Wait Until Page Contains            درخواست حذف همکار
  Click Element                       ${Confirm_Button}
  Wait Until Page Contains            همکار با موفقیت حذف شد

Add New Colleague
  [Arguments]                         ${Colleague_Type}
  Click Button                        ${Add_New_Colleague}
  Wait Until Page Contains            نقش همکار
  Input Random Mobile
  Select Colleague Role               ${Colleague_Type}
  Submit Colleague

Select Colleague Role
  [Arguments]                         ${Colleague_Type}
  Click Element                       select-role
  Wait Until Page Contains Element    ${Secretary}
    IF                                "${Colleague_Type}" == "مشاور"
    Click Element                     ${Consultant}
    Element Should Contain            select-role         ${Colleague_Type}
    ELSE IF                           "${Colleague_Type}" == "منشی"
    Click Element                     ${Secretary}
    Element Should Contain            select-role         ${Colleague_Type}
    END

Submit Colleague
  Click Button                        name:apply-action
  Wait Until Page Contains            همکار با موفقیت اضافه شد
