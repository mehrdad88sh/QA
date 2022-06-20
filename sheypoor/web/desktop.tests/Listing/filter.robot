*** Settings ***
Library                                          SeleniumLibrary
Resource                                         ../../resources/resource.robot
Test Setup                                       Run Keywords
...                                              Open Browser In Test Enviroment
Test Teardown                                    Close Browser

*** Variables ***
${neighborhood}                                  css:#search-fields span[data-popup="popup-districts"]
${neighborhood_popup}                            css:.popup.list-menu.open
${neighborhood_selection}                        css:.button-bar.fixed
@{neighborhoods}

*** Test Cases ***
Filter neighborhood
  Select 5 neighborhood with FOR Loop in-range
  Select 3 neighborhood with FOR Loops type 2



*** Keywords ***
Select 5 neighborhood with FOR Loop in-range
  Click Element                                  ${neighborhood}
  Wait Until Page Contains Element               ${neighborhood_popup}
  FOR  ${index}   IN RANGE    5
       Click Element                             css:[data-district-id="93${index}"]
       ${neighborhood_name}                      Get Text    css:[data-district-id="93${index}"]
       Append To List                            ${neighborhoods}     ${neighborhood_name}
  END
  Log                                            ${neighborhoods} are in Tehran city
  Click Element                                  ${neighborhood_selection}
  Page Should Not Contain Element                ${neighborhood_popup}
  Wait Until Element Contains                    css:#tags span.tag:nth-child(2)                       محله: آجودانیه، آذربایجان، آذری، آرژانتین و ...     timeout=3s

Select 3 neighborhood with FOR Loops type 2
  Click Element                                  ${neighborhood}
  Wait Until Page Contains Element               ${neighborhood_popup}
  FOR  ${index}   IN RANGE    1   6   2
       Click Element                             css:[data-district-id="471${index}"]
       ${neighborhood_name}                      Get Text    css:[data-district-id="471${index}"]
       Append To List                            ${neighborhoods}     ${neighborhood_name}
  END
  Log                                            ${neighborhoods} are in Tehran city
