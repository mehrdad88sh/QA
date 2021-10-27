*** Settings ***
Documentation                         ثبت امتیاز به مشاور
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Test Cases ***
Submit Rate To Consultant Listing
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Create New Listing With API
  Submit Rate To Consultant Listing With Various Users

*** Keywords ***
Create New Listing With API
  Create File And Publish File In Land And Garden Category
  Get Listing ID From API

Create File And Publish File In Land And Garden Category
  Register Manager With Alunak Api
  Get Code From Mock Server With Alunak Api
  Authorization Manager With Alunak Api
  Creat File With Alunak Api
  Publish File With Alunak API

Submit Rate To Consultant Listing With Various Users
  FOR   ${INDEX}   IN RANGE   2
      Login Sheypoor
      Go To Listing In Sheypoor Page
      Submit New Rate In Listing
      Logout Sheypoor
      Approve Comment In Admin Page
  END

Approve Comment In Admin Page
  Login Admin Page
  Go To User Comments
  Approve Comment

Submit New Rate In Listing
  Click Element                       ${Rate_Button}
  Wait Until Page Contains            به کیفیت خدمت‌رسانی این آگهی دهنده چه امتیازی می‌دهید؟     timeout=10s
  ${Overall_Rate}                     Get WebElements                 ${Overall_Stars}
  Click Element                       ${Overall_Rate}[2]
  Wait Until Page Contains            متوسط                         timeout=10s
  ${Sub_Rate}                         Get WebElements               ${Sub_Rate_Stars}
  ${Response_Speed}                   Click Element                 ${Sub_Rate}[1]
  Sleep    2s
  ${Dealing_With_Customer}            Click Element                 ${Sub_Rate}[7]
  Sleep    2s
  ${Accuracy_Of_information}          Click Element                 ${Sub_Rate}[13]
  Sleep    2s
  ${Sub_Rate_Selected}                Get WebElements               ${Sub_Rate_Stars_Selected}
  Wait Until Page Contains Element    ${Sub_Rate_Selected}[1]
  Wait Until Page Contains Element    ${Sub_Rate_Selected}[4]
  Wait Until Page Contains Element    ${Sub_Rate_Selected}[8]
  ${Submit_Comment}                   Sentence                      nb_words=15
  Input Text                          ${Sumbit_Comment_Field}       ${Submit_Comment}
  Click By Text                       ثبت امتیاز
  Wait Until Page Contains            امتیاز شما به این فروشنده ثبت شد          timeout=10s

Approve Comment
  Input Text                          ${Phone_Search_Bar}           ${Random_User_Mobile}
  Wait Until Keyword Succeeds         3x  3s   Click Element        ${Search_Button}
  Wait Until Page Contains Element    ${Review_Comment_State}       timeout=15s
  Element Should Contain              ${Review_Comment_State}       در حال بررسی
  Click Element                       ${Confirm_Comment_Button}
  Wait Until Page Contains Element    ${Accepted_Comment_State}     timeout=15s
  Element Should Contain              ${Accepted_Comment_State}     تایید شده
