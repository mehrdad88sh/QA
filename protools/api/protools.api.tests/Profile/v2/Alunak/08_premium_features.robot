*** Settings ***
Documentation               Show All Of Premium Features
Variables                   ../../../../Variables/Variables.py
Resource                    ../../../../Resources/resource.robot

*** Test Cases ***
Show All Of Premium Features
    Set Log Level           TRACE
    Login Protools Api      v2       real-estate
    Get Premium Features    v2

*** Keywords ***
Get Premium Features
    [Arguments]             ${protools_version}
    Clear Expectations
    Set Headers             {"X-Ticket": "${access_token}"}
    Set Headers             {"source": "protools"}
    Set Headers             {"Authorization": "Basic dHJ1bXBldDpuZXdzaXRl"}
    Get                     /${protools_version}/profile/premium/features
    Integer                 response status           200
    ${response}             output                    response body

    ${title}                Get Value From Json       ${response}                $.title
    ${title}                Convert To String         ${title[0]}
    Should Be Equal         ${title}                  پروفایل خود را به مشاور حرفه‌ای ارتقا دهید

    ${price}                Get Value From Json       ${response}                $.price
    ${price}                Convert To String         ${price[0]}
    Should Be Equal         ${price}                  ۱۵۰۰۰۰ تومان

    ${expire}               Get Value From Json       ${response}                $.expire
    ${expire}               Convert To String         ${expire[0]}
    Should Be Equal         ${expire}                 مهلت استفاده تا یک ماه

    ${title1}               Get Value From Json       ${response}                $.informations[0].title
    ${title1}               Convert To String         ${title1[0]}
    Should Be Equal         ${title1}                 درج تصویر و رزومه

    ${title2}               Get Value From Json       ${response}                $.informations[1].title
    ${title2}               Convert To String         ${title2[0]}
    Should Be Equal         ${title2}                 نمایش و لینک پروفایل در جزئیات آگهی

    ${title3}               Get Value From Json       ${response}                $.informations[2].title
    ${title3}               Convert To String         ${title3[0]}
    Should Be Equal         ${title3}                 نمایش پروفایل در آگهی‌های شما در فروشگاه

    ${title4}               Get Value From Json       ${response}                $.informations[3].title
    ${title4}               Convert To String         ${title4[0]}
    Should Be Equal         ${title4}                 نمایش نشان پروفایل (Badge)

    ${title5}               Get Value From Json       ${response}                $.informations[4].title
    ${title5}               Convert To String         ${title5[0]}
    Should Be Equal         ${title5}                 اولویت نمایش در لیست همه مشاوران

    ${title6}               Get Value From Json       ${response}                $.informations[5].title
    ${title6}               Convert To String         ${title6[0]}
    Should Be Equal         ${title6}                 اولویت نمایش در لیست مشاورین داخل شاپ

    ${title7}               Get Value From Json       ${response}                $.informations[6].title
    ${title7}               Convert To String         ${title7[0]}
    Should Be Equal         ${title7}                 امکان درج شبکه‌های اجتماعی در پروفایل

    ${title8}               Get Value From Json       ${response}                $.informations[7].title
    ${title8}               Convert To String         ${title8[0]}
    Should Be Equal         ${title8}                 همراه فایل یک ماهه رایگان برای ۳ محله (در تهران)

    ${title9}               Get Value From Json       ${response}                $.informations[8].title
    ${title9}               Convert To String         ${title9[0]}
    Should Be Equal         ${title9}                 امکان درج توضیحات درباره من
