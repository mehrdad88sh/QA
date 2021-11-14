*** Settings ***
Documentation                         ثبت درخواست جدید در بخش درخواست های من آلونک
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Test Cases ***
Create New File Request In Alunak
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Check File Request Toggle In Admin
  Back To Protools Page
  Go To My Requests Page
  Submit New Request
  Check File Request Items

*** Keywords ***
Check File Request Items
  Wait Until Page Contains            فایل متناسب                   timeout=10s
  Click By Text                       رهن و اجاره خانه و آپارتمان
  Wait Until Page Contains            توضیحات درخواست               timeout=10s
  Page Should Contain                 ${Random_User_Name}
  Click Element                       ${Close_Button}

Submit New Request
  Open Submit Customer Request Modal
  Select Rent And Deposit Category
  Set Requester Name
  Set Requester Phone
  Set Location In Filters
  Select RealEstate Type                ${RealEstateType}[RD]       ${ApartmentID}[RD]    ${Apartment}
  Select Year Of Construction
  Set Building Floor
  Set Minimum and Maximum Area
  Set Minimum and Maximum Rent
  Set Minimum and Maximum Deposit
  Submit Request
