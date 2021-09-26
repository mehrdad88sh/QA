*** Settings ***
Documentation                           فیلتر کردن تاریخ و مقایسه آن با نمودار
Resource                                ../../resources/resource.robot
Test Teardown                           Close Browser

*** Test Cases ***
Filter Date And Compare With Chart
    Login Protools                      آلونک
    Create Shop In Sheypoor             املاک
    Back To Protools Page
    Go To Statistics Page
    Set Start Date
    Set End Date
    Check Filter And Chart Days
    Check Leads And Views Checkbox
    Check Tooltip In Chart

*** Keywords ***
Go To Statistics Page
    Click Element                       ${Statistics_Button}
    Wait Until Page Contains            آمار کلی

Set Start Date
    Click Element                       ${Start_Date}
    Wait Until Page Contains Element    ${Calendar}
    ${Days_Of_Current_Calendar}         Get WebElements                   ${Days_Of_Current_Calendar}
    Click Element                       ${Days_Of_Current_Calendar}[9]
    ${10th_Day_Of_Month_Is_Selected}    Get Value                         ${Start_Date}
    Textfield Value Should Be           ${Start_Date}                     ${10th_Day_Of_Month_Is_Selected}
    Set Test Variable                   ${10th_Day_Of_Month_Is_Selected}  ${10th_Day_Of_Month_Is_Selected}

Set End Date
    Click Element                       ${End_Date}
    Wait Until Page Contains Element    ${Calendar}
    Click Button                        ${Previous_Month_Button}
    ${Days_Of_Current_Calendar}         Get WebElements                   ${Days_Of_Current_Calendar}
    Click Element                       ${Days_Of_Current_Calendar}[14]
    ${15th_Day_Of_Month_Is_Selected}    Get Value                         ${End_Date}
    Textfield Value Should Be           ${End_Date}                       ${15th_Day_Of_Month_Is_Selected}
    Set Test Variable                   ${15th_Day_Of_Month_Is_Selected}  ${15th_Day_Of_Month_Is_Selected}

Check Filter And Chart Days
    Wait Until Page Contains Element    ${Contact_Information_Views}      timeout=5s
    ${Days_In_Chart}                    Get WebElements                   ${Days_In_Chart}
    ${First_Day_In_Chart}               Get Text                          ${Days_In_Chart}[0]
    Should Be Equal                     ${First_Day_In_Chart}             ${10th_Day_Of_Month_Is_Selected}
    ${Last_Day_In_Chart}                Get Text                          ${Days_In_Chart}[5]
    Should Be Equal                     ${Last_Day_In_Chart}              ${15th_Day_Of_Month_Is_Selected}

Check Leads And Views Checkbox
    ${Chart_Lines}                      Get WebElements                   ${Chart_Lines}
    Click By Text                       تعداد بازدید آگهی
    Element Should Be Visible           ${Chart_Lines}[0]
    Click By Text                       تعداد بازدید اطلاعات تماس
    Page Should Not Contain Element     css:g.recharts-layer.recharts-line
    Click By Text                       تعداد بازدید آگهی
    Wait Until Page Contains Element    ${Contact_Information_Views}
    Click By Text                       تعداد بازدید اطلاعات تماس
    Wait Until Page Contains Element    ${Chart_Lines}[1]

Check Tooltip In Chart
    ${Chart_Line_Dots}                  Get WebElements                   ${Chart_Line_Dots}
    Click Element                       ${Chart_Line_Dots}[3]
    Wait Until Page Contains Element    ${Tooltip_In_Chart}
