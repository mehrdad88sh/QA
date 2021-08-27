*** Settings ***
Documentation              Register and login SheypoorPlus
Variables                  ../../../Variables/Variables.py
Resource                   ../../../Resources/resource.robot

*** Variables ***

*** Test Cases ***
Register And Login SheypoorPlus
    [Tags]                  api        login
    Set Log Level           TRACE
    Register Request Valid                  v1
    Authenticate By Password                v1
    Register Request Invalid Phone Number   v1
    Authenticate By Invalid Password        v1

*** Keywords ***
Register Request Valid
    [Arguments]             ${protools_version}
    Expect Request	        {"body": {"required": ["cellphone", "user_type"]}}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Expect Response         ${CURDIR}/../Versions/${protools_version}/schema/register.json
    Generate Random Phone Number
    Post                    /${protools_version}/auth/register      {"cellphone": "${Random_User_Mobile}", "user_type": "car-sale"}
    Integer                 response status        200
    ${response}             output                 response body
    ${token}                Get Value From Json    ${response}           $.token
    ${token}                Convert To String      ${token[0]}
    Set Test Variable       ${token}               ${token}

Authenticate By Password
    [Arguments]             ${protools_version}
    Expect Request	        {"body": {"required": ["username", "password"]}}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Get Code From Mock Server
    Expect Response         ${CURDIR}/../Versions/${protools_version}/schema/authenticate-by-password.json
    Post                    /${protools_version}/auth/authorize     {"grant_type": "password", "username": "${token}", "password": "${Code}", "scope": "full"}
    Integer                 response status        200
    ${response}             output                 response body

Register Request Invalid Phone Number
    [Arguments]             ${protools_version}
    Expect Response         ${CURDIR}/../Versions/${protools_version}/schema/invalid-phone-number.json
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Post                    /${protools_version}/auth/register      {"cellphone": "123456789", "user_type": "car-sale"}
    Integer                 response status        400
    ${response}             output                 response body

Authenticate By Invalid Password
    [Arguments]             ${protools_version}
    Expect Request	        {"body": {"required": ["username", "password"]}}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Expect Response         ${CURDIR}/../Versions/${protools_version}/schema/authenticate-by-invalid-password.json
    Post                    /${protools_version}/auth/authorize     {"grant_type": "password", "username": "${token}", "password": "4567", "scope": "full"}
    Integer                 response status        400
    ${response}             output                 response body
