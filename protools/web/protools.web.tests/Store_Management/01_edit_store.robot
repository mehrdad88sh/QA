*** Settings ***
Documentation                       ویرایش شاپ از پنل املاک آلونک
Resource                            ../../resources/resource.robot
Test Teardown                       Close Browser

*** Test Cases ***
Edit Shop In Alunak
  Login Protools                    آلونک
  Create Shop In Sheypoor           املاک
  Back To Protools Page
  Go To Store Page
  Edit About Shop
  Edit Shop Slogan
  Edit Contact Information
  Click Element                     ${Save_Button}

*** Keywords ***
Edit About Shop
  Click Element                     ${About_Shop}
  Wait Until Page Contains          ویرایش توضیحات فروشگاه            timeout=3s
  Fill About Shop

Edit Shop Slogan
  Click Element                     ${Slogan_Shop}
  Wait Until Page Contains          ویرایش شعار فروشگاه               timeout=3s
  Fill Slogan Shop

Edit Contact Information
  Wait Until Page Contains Element  ${Contact_Info}                   timeout=3s
  Click Element                     ${Contact_Info}
  Wait Until Page Contains          ویرایش اطلاعات تماس فروشگاه        timeout=3s
  Generate Email
  Generate Website
  Generate Address

Generate Email
  ${Email}                          Company Email
  Press Keys                        name:email                        CTRL+a+DELETE
  Input Text                        name:email                        ${Email}

Generate Website
  ${Website}                        Url
  Press Keys                        name:website                      CTRL+a+DELETE
  Input Text                        name:website                      ${Website}

Generate Address
  ${Address}                        Address
  Press Keys                        name:address                      CTRL+a+DELETE
  Input Text                        name:address                      ${Address}
