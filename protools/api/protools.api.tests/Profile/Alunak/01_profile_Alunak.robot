*** Settings ***
Variables                  ../../../variables/Variables.py
Resource                   ../../../../../../Resources/all.resource

*** Variables ***


*** Test Cases ***
Register To Alunak
  Set Log Level            TRACE
  Post Request Register
  Post Request Authorization
  Get Request Profile

*** Keywords ***
Post Request Register
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Post                    /v2/auth/register         {"cellphone": "09007000000", "user_type": "real-estate"}
    Integer                 response status        200
    ${res}                  output                 response body
    ${token}                Get Value From Json    ${res}          $.token
    ${token}                Convert To String      ${token[0]}
    Set Test Variable       ${token}               ${token}

Post Request Authorization
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Post                    /v2/auth/authorize        {"grant_type": "password", "username": "${token}", "password": "1234", "scope": "full"}
    Integer                 response status        200
    ${res}                  output                 response body
    ${access_token}         Get Value From Json    ${res}          $.access_token
    ${access_token}         Convert To String       ${access_token[0]}
    Set Test Variable       ${access_token}        ${access_token}

Get Request Profile
    Set Headers             {"X-Ticket": "${access_token}"}
    Set Headers             {"source": "protools"}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Get                     /v2/profile
    Integer                 response status        200
    ${res}                  output                 response body
    ${cellphone}            Get Value From Json    ${res}         $.cellphone
    ${cellphone}            Convert To String      ${cellphone[0]}
    ${isProfileCompleted}   Get Value From Json    ${res}         $.isProfileCompleted
    ${isProfileCompleted}   Convert To String      ${isProfileCompleted[0]}
    ${shop}                 Get Value From Json    ${res}         $.shop
    ${shop}                 Convert To String      ${shop[0]}
    Should Be Equal         ${cellphone}           09007000000
    Should Be Equal         ${isProfileCompleted}  True
    Should Be Equal         ${shop}                پلنگ شاپ املاک
