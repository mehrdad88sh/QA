*** Settings ***
Documentation                         بایگانی و بازگرداندن فایل
Resource                              ../../resources/resource.robot
Test Setup                            Run Keywords     Open Browser On Test Enviroment
Test Teardown                         Close Browser

*** Test Cases ***
Archive And Unarchive File
  [Tags]                              Listing                   Alunak
  Login Alunak
  Create RealEstate Shop
  Back To Alunak Page
  Create File In Land And Garden Category
  Archive File By Archive Button
  Unarchive File By Unarchive Button
  Unarchive File From File Details Page

*** Keywords ***
Unarchive File From File Details Page
  Archive File By Archive Button
  Open Archived File
  Unarchive File
  Go To File Management Page          املاک

Archive File By Archive Button
  Wait Until Page Contains            ۱ فایل موجود می‌باشد                        timeout=10s
  Click Element                       ${Archive_Button}
  Wait Until Page Contains            آیا از بایگانی کردن این فایل مطمئن هستید؟  timeout=10s
  Click Element                       ${Confirm_Button}
  Wait Until Page Contains            فایل موردنظر شما بایگانی شد                timeout=10s
  Wait Until Page Does Not Contain    فایل موردنظر شما بایگانی شد                timeout=10s
  Click Element                       ${Archive_Tab}
  Wait Until Page Contains            ۱ فایل موجود می‌باشد                        timeout=10s

Unarchive File By Unarchive Button
  Click Element                       ${UnArchive_Button}
  Wait Until Page Contains            فایل مورد نظر شما باز شد                   timeout=10s
  Wait Until Page Does Not Contain    فایل مورد نظر شما باز شد                   timeout=10s
  Click Element                       ${Open_File_Tab}
  Wait Until Page Contains            ۱ فایل موجود می‌باشد                        timeout=10s

Open Archived File
  Click Element                       name:file-item-0
  Wait Until Page Contains            بایگانی شده                                timeout=10s

Unarchive File
  Click Element                       name:advertise-action
  Wait Until Page Contains            فایل مورد نظر شما باز شد                   timeout=10s
  Page Should Contain                 آگهی نشده
