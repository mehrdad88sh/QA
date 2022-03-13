*** Settings ***
Documentation                         خرید بسته به تعداد دلخواه
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${refresh}                            ۵ بسته
${vitrin24}                           ۱۰ بسته
${vitrin48}                           ۱۵ بسته
${limitation}                         ۲۰ بسته
${instant_tag}                        ۲۵ بسته
${Final_Price}                        ۱,۶۴۲,۱۹۳

*** Test Cases ***
Buy Custom Package
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Back To Protools Page
  Go To Package Purchase Page
  Go To Custom Package Purchase Page
  Select Custom Packages
  Review PreInvoice Prices
  Successful Payment In Sheypoor      خرید بسته به تعداد دلخواه
  Validation Packages In Protools

*** Keywords ***
Select Custom Packages
  Select 5 Refresh Packages
  Select 10 Vitrin24 Packages
  Select 15 Vitrin48 Packages
  Select 20 Limitation Packages
  Select 25 Instant Tag Packages

Select 5 Refresh Packages
  Increase Refresh Package To 10
  Decrease Refresh Package To 5
  Refresh Package Should Be 5

Select 10 Vitrin24 Packages
  Increase Vitrin24 Package To 20
  Decrease Vitrin24 Package To 10
  Vitrin24 Package Should Be 10

Select 15 Vitrin48 Packages
  Increase Vitrin48 Package To 30
  Decrease Vitrin48 Package To 15
  Vitrin48 Package Should Be 15

Select 20 Limitation Packages
  Limitation Vitrin48 Package To 40
  Limitation Vitrin48 Package To 20
  Limitation Package Should Be 20

Select 25 Instant Tag Packages
  Limitation Instant Tag Package To 50
  Limitation Instant Tag Package To 25
  Instant Tag Package Should Be 25

Review PreInvoice Prices
  Click Element                       ${Continue_Buying_Button}
  Wait Until Page Contains            پیش فاکتور                                timeout=5s
  Element Text Should Be              ${PreInvoice_Payment_Button}              پرداخت ${Final_Price} تومان
  Click By Text                       پرداخت ۱,۶۴۲,۱۹۳ تومان

Increase Refresh Package To 10
  FOR   ${INDEX}   IN RANGE    1      11
      Click Element                   ${Refresh_Positive_Button}
      ${Credit_Count}                 Get Text                                  ${Refresh_Credit_Count}
      ${Credit_Count}                 Convert FA to EN                          ${Credit_Count}
      ${Credit_Count}                 Convert To Integer                        ${Credit_Count}
      Should Be Equal                 ${Credit_Count}                           ${INDEX}
  END

Decrease Refresh Package To 5
  FOR   ${INDEX}   IN RANGE    1      6
      Click Element                   ${Refresh_Negative_Button}
      ${Credit_Count}                 Get Text                                  ${Refresh_Credit_Count}
      ${Credit_Count}                 Convert FA to EN                          ${Credit_Count}
      ${Credit_Count}                 Convert To Integer                        ${Credit_Count}
      ${INDEX}                        Evaluate    (${INDEX} - 10) * (-1)
      Should Be Equal                 ${Credit_Count}                           ${INDEX}
  END

Refresh Package Should Be 5
  Page Should Contain                 ۵ عدد بروزرسانی
  Element Text Should Be              ${Total_Cost}                             ۵۸,۰۵۰ تومان
  Element Text Should Be              ${Total_Discount}                         جمع تخفیف ۶,۴۵۰ تومان

Increase Vitrin24 Package To 20
  FOR   ${INDEX}   IN RANGE    1      21
      Click Element                   ${Vitrin24_Positive_Button}
      ${Credit_Count}                 Get Text                                  ${Vitrin24_Credit_Count}
      ${Credit_Count}                 Convert FA to EN                          ${Credit_Count}
      ${Credit_Count}                 Convert To Integer                        ${Credit_Count}
      Should Be Equal                 ${Credit_Count}                           ${INDEX}
  END

Decrease Vitrin24 Package To 10
  FOR   ${INDEX}   IN RANGE    1      11
      Click Element                   ${Vitrin24_Negative_Button}
      ${Credit_Count}                 Get Text                                  ${Vitrin24_Credit_Count}
      ${Credit_Count}                 Convert FA to EN                          ${Credit_Count}
      ${Credit_Count}                 Convert To Integer                        ${Credit_Count}
      ${INDEX}                        Evaluate    (${INDEX} - 10) * (-1) + 10
      Should Be Equal                 ${Credit_Count}                           ${INDEX}
  END

Vitrin24 Package Should Be 10
  Page Should Contain                 ،  ۱۰ عدد ویترین ۲۴ ساعته
  Element Text Should Be              ${Total_Cost}                             ۳۱۳,۶۵۰ تومان
  Element Text Should Be              ${Total_Discount}                         جمع تخفیف ۳۴,۸۵۰ تومان

Increase Vitrin48 Package To 30
  FOR   ${INDEX}   IN RANGE    1      31
      Click Element                   ${Vitrin48_Positive_Button}
      ${Credit_Count}                 Get Text                                  ${Vitrin48_Credit_Count}
      ${Credit_Count}                 Convert FA to EN                          ${Credit_Count}
      ${Credit_Count}                 Convert To Integer                        ${Credit_Count}
      Should Be Equal                 ${Credit_Count}                           ${INDEX}
  END

Decrease Vitrin48 Package To 15
  FOR   ${INDEX}   IN RANGE    1      16
      Click Element                   ${Vitrin48_Negative_Button}
      ${Credit_Count}                 Get Text                                  ${Vitrin48_Credit_Count}
      ${Credit_Count}                 Convert FA to EN                          ${Credit_Count}
      ${Credit_Count}                 Convert To Integer                        ${Credit_Count}
      ${INDEX}                        Evaluate    (${INDEX} - 10) * (-1) + 20
      Should Be Equal                 ${Credit_Count}                           ${INDEX}
  END

Vitrin48 Package Should Be 15
  Page Should Contain                 ،  ۱۵ عدد ویترین ۴۸ ساعته
  Element Text Should Be              ${Total_Cost}                             ۱,۰۴۲,۶۵۰ تومان
  Element Text Should Be              ${Total_Discount}                         جمع تخفیف ۱۱۵,۸۵۰ تومان

Limitation Vitrin48 Package To 40
  FOR   ${INDEX}   IN RANGE    1      41
      Click Element                   ${Limitation_Positive_Button}
      ${Credit_Count}                 Get Text                                  ${Limitation_Credit_Count}
      ${Credit_Count}                 Convert FA to EN                          ${Credit_Count}
      ${Credit_Count}                 Convert To Integer                        ${Credit_Count}
      Should Be Equal                 ${Credit_Count}                           ${INDEX}
  END

Limitation Vitrin48 Package To 20
  FOR   ${INDEX}   IN RANGE    1      21
      Click Element                   ${Limitation_Negative_Button}
      ${Credit_Count}                 Get Text                                  ${Limitation_Credit_Count}
      ${Credit_Count}                 Convert FA to EN                          ${Credit_Count}
      ${Credit_Count}                 Convert To Integer                        ${Credit_Count}
      ${INDEX}                        Evaluate    (${INDEX} - 10) * (-1) + 30
      Should Be Equal                 ${Credit_Count}                           ${INDEX}
  END

Limitation Package Should Be 20
  Page Should Contain                 ،  ۲۰ عدد ظرفیت تعداد آگهی
  Element Text Should Be              ${Total_Cost}                             ۱,۲۷۴,۸۵۰ تومان
  Element Text Should Be              ${Total_Discount}                         جمع تخفیف ۱۴۱,۶۵۰ تومان

Limitation Instant Tag Package To 50
  FOR   ${INDEX}   IN RANGE    1      51
      Click Element                   ${InstantTag_Positive_Button}
      ${Credit_Count}                 Get Text                                  ${InstantTag_Credit_Count}
      ${Credit_Count}                 Convert FA to EN                          ${Credit_Count}
      ${Credit_Count}                 Convert To Integer                        ${Credit_Count}
      Should Be Equal                 ${Credit_Count}                           ${INDEX}
  END

Limitation Instant Tag Package To 25
  FOR   ${INDEX}   IN RANGE    1      26
      Click Element                   ${InstantTag_Negative_Button}
      ${Credit_Count}                 Get Text                                  ${InstantTag_Credit_Count}
      ${Credit_Count}                 Convert FA to EN                          ${Credit_Count}
      ${Credit_Count}                 Convert To Integer                        ${Credit_Count}
      ${INDEX}                        Evaluate    (${INDEX} - 10) * (-1) + 40
      Should Be Equal                 ${Credit_Count}                           ${INDEX}
  END

Instant Tag Package Should Be 25
  Page Should Contain                 ،  ۲۵ عدد نشان فوری
  Element Text Should Be              ${Total_Cost}                             ۱,۵۰۶,۶۰۰ تومان
  Element Text Should Be              ${Total_Discount}                         جمع تخفیف ۱۶۷,۴۰۰ تومان

Validation Packages In Protools
  Wait Until Page Contains            با بروزرسانی، آگهی شما به بالاترین آگهی در گروه خود منتقل می شود                                             timeout=10s
  Element Text Should Be              ${Refresh_Package_Number}                 ${refresh}
  Element Text Should Be              ${Vitrin24_Package_Number}                ${vitrin24}
  Element Text Should Be              ${Vitrin48_Package_Number}                ${vitrin48}
  Element Text Should Be              ${Limitation_Package_Number}              ${limitation}
  Element Text Should Be              ${InstantTag_Package_Number}              ${instant_tag}
