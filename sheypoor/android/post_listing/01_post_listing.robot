*** Settings ***
Documentation                         ثبت اگهی در گروه رهن و اجاره آپارتمان
Resource                              ../resource/resource.robot
Test Setup                            set log level                trace
Test Teardown                         Close Application

*** Variables ***

*** Test Cases ***
Post Listing In Realstate Category
  Install App And Open
  Post Listing

*** Keywords ***
Post Listing
  Click Element                       id=com.sheypoor.mobile.debug:id/postAdFab
  Wait Until Page Contains Element    id=com.sheypoor.mobile.debug:id/toolbarTitle
  Click Element                       id=com.sheypoor.mobile.debug:id/fragmentPostAdCategory
  Wait Until Page Contains Element    android=UiSelector().text("املاک")
  Click Element                       android=UiSelector().descriptionContains("املاک")
  Click Element                       android=UiSelector().descriptionContains("رهن و اجاره خانه و آپارتمان")
