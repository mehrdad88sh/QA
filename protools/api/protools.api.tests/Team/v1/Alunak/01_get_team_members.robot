*** Settings ***
Documentation               Create Shop In Sheypoor
Variables                   ../../../../Variables/Variables.py
Resource                    ../../../../Resources/resource.robot
Library                     RequestsLibrary

*** Test Cases ***
Get Alunak Profile
    Set Log Level               TRACE
    Login to Admin

*** Keywords ***
Login to Admin
    Create Session          sheypoor                https://staging.mielse.com
    ${headers}              create dictionary       Content-Type=application/x-www-form-urlencoded
    ${data}                 Evaluate                {'csrf-key': 'bDJPWEpoaDFtWmVsbnZVeWR4SDV3QT09', 'email': 'admin1060@mielse.com', 'password': 'trumpet'}
    ${response}             POST On Session           sheypoor        /trumpet/login          data=${data}       headers=${headers}
    Should Be Equal         ${response.status_code}         ${200}
    Create Session          sheypoor                https://staging.mielse.com
    ${headers}              create dictionary       Content-Type=multipart/form-data; boundary=----WebKitFormBoundarye4HX5jMcvQBm8GxR               authorization=Basic dHJ1bXBldDpuZXdzaXRl           cookie=tsb=d23f61fcd4a2f70f6522d6b4c4a8ed8a; plog=False; track_id=e147c8b29ca03366b9d4384c5947091f; analytics_campaign={%22source%22:%22direct%22%2C%22medium%22:null}; analytics_token=268234a4-84f8-4d62-1100-eba7565c94bb; _yngt_iframe=1; _yngt=47a8887a-6119-41ea-ae9d-2f3145e68382; _ga=GA1.2.318068445.1631710558; _gid=GA1.2.933876109.1631710558; ts=b81c9954cbb98611b4620cb1f862c16b; saved_items=%5B%22384426644%22%2C%22384427151%22%5D; searchKey=eyJfdXJsIjoic2VhcmNoIn0%3D; geo=dont-care; yektanet_session_last_activity=9/16/2021
    ${data}                 Evaluate                {'Title': 'تست فروشگاه پنجم', 'Slug': 'testshop5', 'OwnerPhone': '09002551155', 'PrimaryPhone': '09002551155', 'CityId': '301', 'CategoryId': '43603'}
    ${response}             POST On Session            sheypoor        /trumpet/shop/profile/create      data=${data}       headers=${headers}
    Should Be Equal         ${response.status_code}         ${200}

Library                               sheypoorlib
Convert FA to ENs
  ${FA_Number}                       ۳۴۲۵۲۵۲
  ${EN_Number}                       convert number                         ${FA_Number}

${staging.format('${trumpet_env}')}/pro
'staging': 'https://{}.mielse.com',

${listing_text}                     Get Text             css:.section.pending strong
${listing_ID}                       Fetch From Right     ${listing_text}      ${SPACE}
