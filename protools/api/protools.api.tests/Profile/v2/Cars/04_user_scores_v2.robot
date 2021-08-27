*** Settings ***
Documentation               Get User Scores Alunak v2
Variables                   ../../../../Variables/Variables.py
Resource                    ../../../../Resources/resource.robot

*** Test Cases ***
User Scores Alunak
    Set Log Level           TRACE
    Login Protools Api      v2       car-sale
    Edit User Profile       v2
    Get User Scores         v2

*** Keywords ***
Edit User Profile
    [Arguments]             ${protools_version}
    Clear Expectations
    Set Headers             {"X-Ticket": "${access_token}"}
    Set Headers             {"source": "protoolsCars"}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Generate Username       ${protools_version}
    Post                    /${protools_version}/profile
    ...                     {"full_name": "${Random_User_Name}"}
    Integer                 response status        200
    Get                     /${protools_version}/profile
    Integer                 response status        200
    ${response}             output                 response body
    ${full_name}            Get Value From Json    ${response}                $.full_name
    ${full_name}            Convert To String      ${full_name[0]}
    Should Be Equal         ${full_name}           ${Random_User_Name}

Get User Scores
  [Arguments]             ${protools_version}
  Clear Expectations
  Set Headers             {"X-Ticket": "${access_token}"}
  Set Headers             {"source": "protools"}
  Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
  Get                     /${protools_version}/profile/user-scores
  Integer                 response status        200
  ${response}             output                 response body
  ${actionDescription}    Get Value From Json    ${response}                   $.items[0].actionDescription
  ${actionDescription}    Convert To String      ${actionDescription[0]}
  Should Be Equal         ${actionDescription}   امتیاز برای تعریف نام پروفایل
  ${score}                Get Value From Json    ${response}                   $.items[0].score
  ${score}                Convert To String      ${score[0]}
  Should Be Equal         ${score}               10
