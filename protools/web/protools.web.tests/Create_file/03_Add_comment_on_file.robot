*** Settings ***
Documentation                         ثبت یادداشت در فایل
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Test Cases ***
Add Comment On File
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Back To Protools Page
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
  Wait Until Page Contains Element    name:file-item-0          timeout=10s
  Click Element                       name:note-action
  Wait Until Page Contains            شما هنوز هیچ یادداشتی درباره‌ی این فایل ننوشته‌اید
  Add New Comment

Add New Comment
  FOR   ${INDEX}   IN RANGE   3
    ${Comments}                       Sentence                    nb_words=30
    Set Suite Variable                ${Comments}
    Input Text                        name:description            ${Comments}
    Element Should Contain            name:description            ${Comments}
    Click Element                     name:save-form-action
    Sleep    200ms
    ${Status}                         Run Keyword And Return Status
    ...                               Wait Until Page Contains    لطفا حداکثر 250 حرف وارد کنید       timeout=3s
    IF                                "${Status}" == "True"
                                      Press Keys                  name:description                    CTRL+a+DELETE
                                      ${NewComment}               Sentence                            nb_words=20
                                      Input Text                  name:description                    ${NewComment}
                                      Click Element               name:save-form-action
                                      Sleep    200ms
    END
  END

Select Land And Garden Category
  Click Element                       name:category-trigger
  Wait Until Page Contains Element    css:[role="document"]       timeout=10s
  Click Element                       name:44099
  Textfield Value Should Be           name:category               زمین و باغ
  Wait Until Page Contains Element    select-a69120               timeout=10s

Set Land And Garden Attributes
  Applied Type
  Set Area
  Set Price

Applied Type
  Click Element                       select-a69120
  Wait Until Page Contains Element    css:[role="listbox"]       timeout=10s
  Click Element                       name:445096
  Element Text Should Be              select-a69120               کشاورزی

Set Price
  Input Text                          name:price                  7000000

Set Area
  Input Text                          name:a68085                 85
