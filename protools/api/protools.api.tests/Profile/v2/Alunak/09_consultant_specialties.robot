*** Settings ***
Documentation               Show consultant specialties
Variables                   ../../../../Variables/Variables.py
Resource                    ../../../../Resources/resource.robot

*** Test Cases ***
Show Consultant Specialties
    Set Log Level           TRACE
    Get Consultant Specialties    v2

*** Keywords ***
Get Consultant Specialties
    [Arguments]             ${protools_version}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Get                     /${protools_version}/profile/consultant/specialties
    Integer                 response status           200
    ${response}             output                    response body

    ${specialties1}         Get Value From Json       ${response}                $.specialties[0].title
    ${specialties1}          Convert To String        ${specialties1[0]}
    Should Be Equal         ${specialties1}           رهن و اجاره

    ${specialties2}         Get Value From Json       ${response}                $.specialties[1].title
    ${specialties2}         Convert To String         ${specialties2[0]}
    Should Be Equal         ${specialties2}           خرید و فروش

    ${specialties3}         Get Value From Json       ${response}                $.specialties[2].title
    ${specialties3}         Convert To String         ${specialties3[0]}
    Should Be Equal         ${specialties3}           خانه و آپارتمان

    ${specialties4}         Get Value From Json       ${response}                $.specialties[3].title
    ${specialties4}         Convert To String         ${specialties4[0]}
    Should Be Equal         ${specialties4}           ویلا و سوئیت

    ${specialties5}         Get Value From Json       ${response}                $.specialties[4].title
    ${specialties5}         Convert To String         ${specialties5[0]}
    Should Be Equal         ${specialties5}           اداری، تجاری و صنعتی
