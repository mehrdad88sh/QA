*** Settings ***
Documentation                         بایگانی و بازگرداندن فایل
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Test Cases ***
Archive And Unarchive File
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Back To Protools Page
  Create File In Land And Garden Category
  Archive File
  Unarchive File

*** Keywords ***
Archive File
  Wait Until Page Contains            ۱ فایل موجود می‌باشد                        timeout=10s
  Click Element                       ${Archive_Button}
  Wait Until Page Contains            آیا از بایگانی کردن این فایل مطمئن هستید؟  timeout=10s
  Click Element                       ${Confirm_Button}
  Wait Until Page Contains            فایل موردنظر شما بایگانی شد                timeout=10s
  Wait Until Page Does Not Contain    فایل موردنظر شما بایگانی شد                timeout=10s
  Click Element                       ${Archive_Tab}
  Wait Until Page Contains            ۱ فایل موجود می‌باشد                        timeout=10s

Unarchive File
  Click Element                       ${UnArchive_Button}
  Wait Until Page Contains            فایل مورد نظر شما باز شد                   timeout=10s
  Wait Until Page Does Not Contain    فایل مورد نظر شما باز شد                   timeout=10s
  Click Element                       ${Open_File_Tab}
  Wait Until Page Contains            ۱ فایل موجود می‌باشد                        timeout=10s
