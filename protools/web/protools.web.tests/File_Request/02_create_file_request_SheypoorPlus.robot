*** Settings ***
Documentation                         ثبت درخواست جدید در بخش درخواست های من شیپورپلاس
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Test Cases ***
Create New File Request In Alunak
  Login Protools                      شیپورپلاس
  Create Shop In Sheypoor             خودرو
  Check File Request Toggle In Admin
  Back To Sheypoor Car Page
  Go To My Requests Page
  Submit New Request
  Check File Request Items

*** Keywords ***
Check File Request Items
  Wait Until Page Contains            فایل متناسب                   timeout=10s
  Click By Text                       پراید
  Wait Until Page Contains            توضیحات درخواست               timeout=10s
  Page Should Contain                 ${Random_User_Name}
  Click Element                       ${Close_Button}

Submit New Request
  Open Submit Customer Request Modal
  Select Pride Category
  Set Requester Name
  Set Requester Phone
  Set Location In Filters
  Select Car Model
  Select Car Payment Type
  Set Minimum and Maximum Production Year
  Set Minimum and Maximum Kilometer
  Car Paint Type
  Car Gearbox Type
  Car Fuel Type
  Car Body Condition
  Set Minimum and Maximum Price
  Submit Request
