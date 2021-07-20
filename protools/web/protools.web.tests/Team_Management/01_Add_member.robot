*** Settings ***
Documentation                         اضافه کردن منشی و مشاور به فروشگاه از پنل آلونک
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Test Cases ***
Add Secretary And Consultant In Shop
  Login Alunak
  Create Shop In Sheypoor             "املاک"
  Go To Alunak Page
  Go To Team Management Page
  Add New Colleague                   منشی
  Add New Colleague                   مشاور

*** Keywords ***
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
    Click Element       ${Consultant}
    Element Should Contain             select-role         ${Colleague_Type}
    ELSE IF                             "${Colleague_Type}" == "منشی"
    Click Element       ${Secretary}
    Element Should Contain             select-role         ${Colleague_Type}
    END

Submit Colleague
  Click Button                        name:apply-action
  Wait Until Page Contains            همکار با موفقیت اضافه شد
