*** Settings ***
Documentation                         دریافت اعلان جدید پس از منقضی شدن اگهی
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Test Cases ***
Get New Notification When Listing Is Expired
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Back To Protools Page
  Create File In Land And Garden Category
  Convert File To Listing             املاک
  Check Empty Notification Message
  Expire The Listing
  Get Notification Message
  Go To Notification Page

*** Keywords ***
Check Empty Notification Message
  Click Element                       ${Notification_Button}
  Wait Until Page Contains            اعلانی جهت نمایش وجود ندارد.
  Reload Page

Get Notification Message
  Wait Until Page Contains Element    ${Notification_Button}
  Click Element                       ${Notification_Button}
  Wait Until Page Contains            مشاهده همه اعلانات

Go To Notification Page
  Click Element                       ${Show_More_Notification}
  Wait Until Page Contains            اعلانات
