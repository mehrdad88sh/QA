*** Settings ***
Documentation                        Api resources
Library                              REST                     ${staging}/api/protools
Library                              JSONLibrary
Library                              String

*** Keywords ***
Generate Random Phone Number
  ${Random_Number}                   Generate Random String    7   [NUMBERS]
  Set Suite Variable                 ${Random_Number}          0900${Random_Number}

Get Code From Mock Server
  Expect Response                    ${CURDIR}/../protools.api.tests/Authentication/Versions/V2/schema/getcode.json
  Get                                ${stagingMock}=${Random_Number}
  ...                                headers={"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
  Integer                            response status           200
  ${response}                        output                    response body
  ${Code}                            Get Value From Json       ${response}     $.code
  ${Code}                            Convert To String         ${Code[0]}
  Set Suite Variable                 ${Code}                   ${Code}
