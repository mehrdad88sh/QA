*** Settings ***
Documentation                         ثبت یادداشت در فایل
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Test Cases ***
Add Comment On File
  Login Alunak
  Create File In Land And Garden Category
  Add Comment On File

*** Keywords ***
Create File In Land And Garden Category
  Go To Submit File Page
  Select Land And Garden Category
  Set Location
  Set Land And Garden Attributes
  Fill File Description
  Submit File

Add Comment On File
  Go To                               ${staging}/pro/real-estate/files/act
  Wait Until Page Contains Element    name:file-item-0          timeout=5s
  Click Element                       name:note-action
  Wait Until Page Contains            شما هنوز هیچ یادداشتی درباره‌ی این فایل ننوشته‌اید
  FOR   ${INDEX}   IN RANGE   3
    Add Comment
    Click Element                     name:save-form-action
    Sleep    150ms
  END
  Click Element                       name:close-form-action


Add Comment
  ${Comments}                         Sentence                  nb_words=30
  Input Text                          css:[name=description]    ${Comments}

Select Land And Garden Category
  Click Element                       name:category-trigger
  Wait Until Page Contains Element    css:[role="document"]     timeout=5s
  Click Element                       name:44099
  Textfield Value Should Be           name:category             زمین و باغ
  Wait Until Page Contains Element    select-a69120             timeout=5s

Set Land And Garden Attributes
  Applied Type
  Set Area
  Set Price

Applied Type
  Click Element                       select-a69120
  Wait Until Page Contains Element    css:[role="listbox"]     timeout=5s
  Click Element                       name:445096
  Element Text Should Be              select-a69120             کشاورزی

Set Price
  Input Text                          name:price                7000000

Set Area
  Input Text                          name:a68085               85
