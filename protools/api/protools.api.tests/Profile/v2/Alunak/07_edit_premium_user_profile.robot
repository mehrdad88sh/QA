*** Settings ***
Documentation                     Edit Premium User In Alunak v2
Variables                         ../../../../Variables/Variables.py
Resource                          ../../../../Resources/resource.robot
Library                           SeleniumLibrary

*** Test Cases ***
Edit Premium User Profile
    Set Log Level                 TRACE
    Login Protools Api            v2                                  real-estate
    Upgrade To Premium            v2
    Validate User Is Premium      v2
    Edit Premium User             v2
    Validate Premium User Information  v2

*** Keywords ***
Upgrade To Premium
    [Arguments]                   ${protools_version}
    Clear Expectations
    Set Headers                   {"X-Ticket": "${access_token}"}
    Set Headers                   {"source": "protools"}
    Set Headers                   {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Post                          /${protools_version}/profile/upgrade
    Integer                       response status                     200
    ${response}                   output                              response body
    ${Payment_URL}                Get Value From Json                 ${response}         $.url
    ${Payment_URL}                Convert To String                   ${Payment_URL[0]}
    Set Test Variable             ${Payment_URL}                      ${Payment_URL}
    Check Payment In Sheypoor     پروفایل حرفه‌ای

Validate User Is Premium
    [Arguments]                   ${protools_version}
    Get                           /${protools_version}/profile
    Integer                       response status                     200
    ${response}                   output                              response body
    ${isUpgrade}                  Get Value From Json                 ${response}         $.upgradeButton.isUpgrade
    ${isUpgrade}                  Convert To String                   ${isUpgrade[0]}
    Should Be Equal               ${isUpgrade}                        False
    Get                           /${protools_version}/profile/details
    Integer                       response status                     200
    ${response}                   output                              response body
    ${isPremium}                  Get Value From Json                 ${response}         $.isPremium
    ${isPremium}                  Convert To String                   ${isPremium[0]}
    Should Be Equal               ${isPremium}                        True

Edit Premium User
    [Arguments]                   ${protools_version}
    Clear Expectations
    Generate Username             v2
    Generate Random AboutMe Sentence
    Set Headers                   {"X-Ticket": "${access_token}"}
    Set Headers                   {"source": "protools"}
    Set Headers                   {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Post                          /${protools_version}/profile/consultant
    ...                           {"name": "${Random_User_Name}","phonenum": "${Random_User_Mobile}","telegram": "sheypoor","instagram": "sheypoor","displayCurrentAgency": true,"aboutMe": "${Random_AboutMe_Sentence}","fields": ["0","1","2","3","4"],"locations": ["n5364","n5370","n4000","n4005","294","228"]}
    Integer                       response status                     200
    String                        response body message               اطلاعات با موفقیت بروز شد.

Validate Premium User Information
    [Arguments]                   ${protools_version}
    Clear Expectations
    Set Headers                   {"X-Ticket": "${access_token}"}
    Set Headers                   {"source": "protools"}
    Set Headers                   {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Get                           /${protools_version}/profile/consultant/form
    Integer                       response status                     200
    ${response}                   output                              response body
    ${name}                       Get Value From Json                 ${response}         $.initialData.name
    ${name}                       Convert To String                   ${name[0]}
    Should Be Equal               ${name}                             ${Random_User_Name}
    ${phonenum}                   Get Value From Json                 ${response}         $.initialData.phonenum
    ${phonenum}                   Convert To String                   ${phonenum[0]}
    Should Be Equal               ${phonenum}                         ${Random_User_Mobile}
    ${telegram}                   Get Value From Json                 ${response}         $.initialData.telegram
    ${telegram}                   Convert To String                   ${telegram[0]}
    Should Be Equal               ${telegram}                         sheypoor
    ${instagram}                  Get Value From Json                 ${response}         $.initialData.instagram
    ${instagram}                  Convert To String                   ${instagram[0]}
    Should Be Equal               ${instagram}                        sheypoor
    ${aboutMe}                    Get Value From Json                 ${response}         $.initialData.aboutMe
    ${aboutMe}                    Convert To String                   ${aboutMe[0]}
    Should Be Equal               ${aboutMe}                          ${Random_AboutMe_Sentence}
    ${fields0}                    Get Value From Json                 ${response}         $.initialData.fields[0].title
    ${fields0}                    Convert To String                   ${fields0[0]}
    Should Be Equal               ${fields0}                          رهن و اجاره
    ${fields1}                    Get Value From Json                 ${response}         $.initialData.fields[1].title
    ${fields1}                    Convert To String                   ${fields1[0]}
    Should Be Equal               ${fields1}                          خرید و فروش
    ${location0}                  Get Value From Json                 ${response}         $.initialData.locations[0].title
    ${location0}                  Convert To String                   ${location0[0]}
    Should Be Equal               ${location0}                        طالقان
    ${location1}                  Get Value From Json                 ${response}         $.initialData.locations[1].title
    ${location1}                  Convert To String                   ${location1[0]}
    Should Be Equal               ${location1}                        عظیمیه
