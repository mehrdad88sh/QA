*** Settings ***
Documentation              Get Total Scores Alunak v2
Variables                  ../../../Variables/Variables.py
Resource                   ../../../Resources/resource.robot

*** Test Cases ***
Total Scores Alunak
    Set Log Level          TRACE
    Register To Alunak        v2
    Authentication In Alunak  v2
    Edit User Profile         v2
    Get Total Scores          v2

*** Keywords ***
Register To Alunak
    [Arguments]             ${protools_version}
    Expect Request	        {"body": {"required": ["cellphone", "user_type"]}}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Expect Response         ${CURDIR}/../../Authentication/Versions/${protools_version}/schema/register.json
    Generate Random Phone Number
    Post                    /${protools_version}/auth/register
    ...                     {"cellphone": "${Random_Number}", "user_type": "real-estate"}
    Integer                 response status        200
    ${response}             output                 response body
    ${token}                Get Value From Json    ${response}                 $.token
    ${token}                Convert To String      ${token[0]}
    Set Test Variable       ${token}               ${token}

Authentication In Alunak
    [Arguments]             ${protools_version}
    Expect Request	        {"body": {"required": ["username", "password"]}}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Get Code From Mock Server
    Expect Response         ${CURDIR}/../../Authentication/Versions/${protools_version}/schema/authenticate-by-password.json
    Post                    /${protools_version}/auth/authorize
    ...                     {"grant_type": "password", "username": "${token}", "password": "${Code}", "scope": "full"}
    Integer                 response status        200
    ${response}             output                 response body
    ${access_token}         Get Value From Json    ${response}                 $.access_token
    ${access_token}         Convert To String      ${access_token[0]}
    Set Test Variable       ${access_token}        ${access_token}

Edit User Profile
    [Arguments]             ${protools_version}
    Clear Expectations
    Set Headers             {"X-Ticket": "${access_token}"}
    Set Headers             {"source": "protools"}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Generate Username       ${protools_version}
    Post                    /${protools_version}/profile
    ...                     {"full_name": "${Random_User_Name}"}
    Integer                 response status        200
    Get                     /${protools_version}/profile
    Integer                 response status        200
    ${response}             output                 response body
    ${full_name}            Get Value From Json    ${response}                 $.full_name
    ${full_name}            Convert To String      ${full_name[0]}
    Should Be Equal         ${full_name}           ${Random_User_Name}

Get Total Scores
  [Arguments]             ${protools_version}
  Clear Expectations
  Set Headers             {"X-Ticket": "${access_token}"}
  Set Headers             {"source": "protools"}
  Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
  Get                     /${protools_version}/profile/total-scores
  Integer                 response status        200
  ${response}             output                 response body
  ${score}                Get Value From Json    ${response}                   $.items[0].score
  ${score}                Convert To String      ${score[0]}
  Should Be Equal         ${score}               10
  ${name}                 Get Value From Json    ${response}                   $.items[0].name
  ${name}                 Convert To String      ${name[0]}
  Should Be Equal         ${name}                ${Random_User_Name}
  ${loggedInUser}         Get Value From Json    ${response}                   $.items[0].loggedInUser
  ${loggedInUser}         Convert To String      ${loggedInUser[0]}
  Should Be Equal         ${loggedInUser}        True
