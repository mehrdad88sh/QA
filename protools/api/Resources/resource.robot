*** Settings ***
Documentation                        Api resources
Library                              REST                      ${staging}/api/protools
Library                              JSONLibrary
Library                              String
Library                              FakerLibrary              locale=fa_IR

*** Keywords ***
Generate Random Phone Number
  ${Random_Number}                   Generate Random String    7   [NUMBERS]
  Set Suite Variable                 ${Random_Number}          0900${Random_Number}

Get Code From Mock Server
  Clear Expectations
  Get                                ${stagingMock}=${Random_Number}
  ...                                headers={"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
  Integer                            response status           200
  ${response}                        output                    response body
  ${Code}                            Get Value From Json       ${response}     $.code
  ${Code}                            Convert To String         ${Code[0]}
  Set Suite Variable                 ${Code}                   ${Code}

Generate Username 
  [Arguments]                        ${protools_version}
  IF                                 "${protools_version}" == "v1"
      ${prefix_name}                 Prefix Male
      ${first_name}                  First Name Male
      ${last_name}                   Last Name Male
      Set Suite Variable             ${Random_User_Name}       ${prefix_name} ${first_name} ${last_name}
  ELSE IF                            "${protools_version}" == "v2"
      ${prefix_name}                 Prefix Female
      ${first_name}                  First Name Female
      ${last_name}                   Last Name Female
      Set Suite Variable             ${Random_User_Name}       ${prefix_name} ${first_name} ${last_name}
  END
