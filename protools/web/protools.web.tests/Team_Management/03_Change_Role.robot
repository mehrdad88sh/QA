*** Settings ***
Documentation                         تغییر نقش منشی و مشاور در فروشگاه از پنل آلونک
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Test Cases ***
Change Secretary And Consultant Roles In Shop
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Back To Protools Page
  Go To Team Management Page
  Add New Colleague                   منشی
  Change Secretary To Consultant Role
  Add New Colleague                   مشاور
  Change Consultant To Secretary Role
  Reload Page

*** Keywords ***
Change Secretary To Consultant Role
  Reload Page
  Wait Until Page Contains            افزودن همکار جدید
  Click Element                       name:member-${Random_User_Mobile}
  Wait Until Page Contains Element    ${Colleague_Menu}
  Click By Text                       تغییر نقش به مشاور
  Wait Until Page Contains            تغییر نقش کاربر با موفقیت انجام شد

Change Consultant To Secretary Role
  Reload Page
  Wait Until Page Contains            افزودن همکار جدید
  Click Element                       name:member-${Random_User_Mobile}
  Wait Until Page Contains Element    ${Colleague_Menu}
  Click By Text                       تغییر نقش به منشی
  Wait Until Page Contains            تغییر نقش کاربر با موفقیت انجام شد

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
    IF                                  "${Colleague_Type}" == "مشاور"
    Click Element                     ${Consultant}
    Element Should Contain            select-role         ${Colleague_Type}
    ELSE IF                           "${Colleague_Type}" == "منشی"
    Click Element                     ${Secretary}
    Element Should Contain            select-role         ${Colleague_Type}
    END

Submit Colleague
  Click Button                        name:apply-action
  Wait Until Page Contains            همکار با موفقیت اضافه شد
