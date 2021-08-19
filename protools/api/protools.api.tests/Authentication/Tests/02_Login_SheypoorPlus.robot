*** Settings ***
Documentation              Register and login SheypoorPlus
Variables                  ../../../Variables/Variables.py
Resource                   ../../../Resources/resource.robot

*** Variables ***

*** Test Cases ***
Register And Login SheypoorPlus
    [Tags]                  api        login     v2
    Set Log Level           TRACE
    Register Request Valid
    Register Request Invalid Phone Number
    Authenticate By Password
    Authenticate By Invalid Password

*** Keywords ***
Register Request Valid
    Expect Request	        {"body": {"required": ["cellphone", "user_type"]}}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Expect Response         ${CURDIR}/../Versions/V2/schema/register.json
    Generate Random Phone Number
    Post                    /v2/auth/register      {"cellphone": "${Random_Number}", "user_type": "car-sale"}
    Integer                 response status        200
    ${response}             output                 response body
    ${token}                Get Value From Json    ${response}           $.token
    ${token}                Convert To String      ${token[0]}
    Set Test Variable       ${token}               ${token}

Authenticate By Password
    Expect Request	        {"body": {"required": ["username", "password"]}}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Get Code From Mock Server
    Expect Response         ${CURDIR}/../Versions/V2/schema/authenticate-by-password.json
    Post                    /v2/auth/authorize     {"grant_type": "password", "username": "${token}", "password": "${Code}", "scope": "full"}
    Integer                 response status        200
    ${response}             output                 response body

Register Request Invalid Phone Number
    Expect Response         ${CURDIR}/../Versions/V2/schema/invalid-phone-number.json
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Post                    /v2/auth/register      {"cellphone": "123456789", "user_type": "car-sale"}
    Integer                 response status        400
    ${response}             output                 response body

Authenticate By Invalid Password
    Expect Request	        {"body": {"required": ["username", "password"]}}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Expect Response         ${CURDIR}/../Versions/V2/schema/authenticate-by-invalid-password.json
    Post                    /v2/auth/authorize     {"grant_type": "password", "username": "${token}", "password": "4567", "scope": "full"}
    Integer                 response status        400
    ${response}             output                 response body
