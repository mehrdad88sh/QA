*** Settings ***
Documentation                   Sending And Showing User Invitation Alunak v2
Variables                       ../../../../Variables/Variables.py
Resource                        ../../../../Resources/resource.robot

*** Test Cases ***
User Invitation In Alunak
    Set Log Level               TRACE
    Login Protools Api          v2      real-estate
    Invitation Sent Successfully     v2
    Sending Duplicate Invitation     v2
    Sending Invitation For Wrong Phone Number    v2
    Showing Sent Successful Invitation        v2

*** Keywords ***
Invitation Sent Successfully
    [Arguments]                 ${protools_version}
    Clear Expectations
    Set Headers                 {"X-Ticket": "${access_token}"}
    Set Headers                 {"source": "protools"}
    Generate Random Phone Number
    Post                        /${protools_version}/user-invitations
    ...                         {"cellphone": "${Random_User_Mobile}"}
    Integer                     response status                    200
    ${response}                 Output                             response body
    String                      response body message              دعوت‌‌نامه با موفقیت ارسال شد

Sending Duplicate Invitation
    [Arguments]                 ${protools_version}
    Post                        /${protools_version}/user-invitations
    ...                         {"cellphone": "${Random_User_Mobile}"}
    Integer                     response status                    400
    ${response}                 Output                             response body
    String                      response body error                همکار شما از قبل دعوت شده است

Sending Invitation For Wrong Phone Number
    [Arguments]                 ${protools_version}
    Post                        /${protools_version}/user-invitations
    ...                         {"cellphone": "1234567890"}
    Integer                     response status                    400
    ${response}                 Output                             response body
    ${reason}                   Get Value From Json                ${response}            $.errors[0].reason
    ${reason}                   Convert To String                  ${reason[0]}
    Should Be Equal             ${reason}                          شماره موبایل وارد شده اشتباه است

Showing Sent Successful Invitation
    [Arguments]                 ${protools_version}
    Get                         /${protools_version}/user-invitations
    Integer                     response status                    200
    ${response}                 Output                             response body
    ${item}                     Get Value From Json                ${response}            $.items[0].title
    ${item}                     Convert To String                  ${item[0]}
    Should Be Equal             ${item}                             در انتظار
    ${name}                     Get Value From Json                ${response}            $.items[0].name
    ${name}                     Convert To String                  ${name[0]}
    Should Be Equal             ${name}                            ${Random_User_Mobile}
