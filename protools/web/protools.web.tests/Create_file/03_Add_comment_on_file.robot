*** Settings ***
Documentation                         ثبت یادداشت در فایل
Resource                              ../../resources/resource.robot
Test Setup                            Run Keywords     Open Browser On Test Enviroment
Test Teardown                         Close Browser

*** Test Cases ***
Add Comment On File
  [Tags]                              Listing                   Alunak
  Login Alunak
  Create RealEstate Shop
  Back To Alunak Page
  Create File In Land And Garden Category
  Add Comment On File

*** Keywords ***
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
