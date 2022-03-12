*** Settings ***
Documentation                         خرید بسته به تعداد دلخواه
Resource                              ../../resources/resource.robot
Test Teardown                         Close Browser

*** Variables ***
${refresh}                            ۵ بسته
${vitrin24}                           ۱۰ بسته
${vitrin48}                           ۱۵ بسته
${instant_tag}                        ۲۵ بسته
${limitation}                         ۲۰ بسته
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
  Select Custom Refresh Package
  Select Custom Vitrin24 Package
  Select Custom Vitrin48 Package
  Select Custom Limitation Package
  Select Custom Instant Tag Package

Select Custom Refresh Package
  FOR   ${INDEX}   IN RANGE    10
  Click Element                       ${Refresh_Positive_Button}
  END
  FOR   ${INDEX}   IN RANGE    5
  Click Element                       ${Refresh_Negative_Button}
  END
  Wait Until Page Contains            ۵ عدد بروزرسانی                           timeout=5s
  Page Should Contain                 ۵۸,۰۵۰ تومان                              #z>> جمع قیمت کل (بدون مالیات)
  Page Should Contain                 ۶,۴۵۰ تومان                               #z>>  جمع تخفیف

Select Custom Vitrin24 Package
  FOR   ${INDEX}   IN RANGE    20
  Click Element                       ${Vitrin24_Positive_Button}
  END
  FOR   ${INDEX}   IN RANGE    10
  Click Element                       ${Vitrin24_Negative_Button}
  END
  Wait Until Page Contains            ۵ عدد بروزرسانی، ۱۰ عدد ویترین ۲۴ ساعته   timeout=5s
  Page Should Contain                 ۳۱۳,۶۵۰ تومان                             #z>> جمع قیمت کل (بدون مالیات)
  Page Should Contain                 ۳۴,۸۵۰ تومان                              #z>>  جمع تخفیف

Select Custom Vitrin48 Package
  FOR   ${INDEX}   IN RANGE    30
  Click Element                       ${Vitrin48_Positive_Button}
  END
  FOR   ${INDEX}   IN RANGE    15
  Click Element                       ${Vitrin48_Negative_Button}
  END
  Wait Until Page Contains            ۵ عدد بروزرسانی، ۱۰ عدد ویترین ۲۴ ساعته، ۱۵ عدد ویترین ۴۸ ساعته   timeout=5s
  Page Should Contain                 ۱,۰۴۲,۶۵۰ تومان                           #z>> جمع قیمت کل (بدون مالیات)
  Page Should Contain                 ۱۱۵,۸۵۰ تومان                             #z>>  جمع تخفیف

Select Custom Limitation Package
  FOR   ${INDEX}   IN RANGE    40
  Click Element                       ${Limitation_Positive_Button}
  END
  FOR   ${INDEX}   IN RANGE    20
  Click Element                       ${Limitation_Negative_Button}
  END
  Wait Until Page Contains            ۵ عدد بروزرسانی، ۱۰ عدد ویترین ۲۴ ساعته، ۱۵ عدد ویترین ۴۸ ساعته، ۲۰ عدد ظرفیت تعداد آگهی                    timeout=5s
  Page Should Contain                 ۱,۲۷۴,۸۵۰ تومان                           #z>> جمع قیمت کل (بدون مالیات)
  Page Should Contain                 ۱۴۱,۶۵۰ تومان                             #z>>  جمع تخفیف

Select Custom Instant Tag Package
  FOR   ${INDEX}   IN RANGE    50
  Click Element                       ${InstantTag_Positive_Button}
  END
  FOR   ${INDEX}   IN RANGE    25
  Click Element                       ${InstantTag_Negative_Button}
  END
  Wait Until Page Contains            ۵ عدد بروزرسانی، ۱۰ عدد ویترین ۲۴ ساعته، ۱۵ عدد ویترین ۴۸ ساعته، ۲۰ عدد ظرفیت تعداد آگهی، ۲۵ عدد نشان فوری  timeout=5s
  Page Should Contain                 ۱,۵۰۶,۶۰۰ تومان                           #z>> جمع قیمت کل (بدون مالیات)
  Page Should Contain                 ۱۶۷,۴۰۰ تومان                             #z>>  جمع تخفیف

Review PreInvoice Prices
  Page Should Contain                 ۵ عدد بروزرسانی، ۱۰ عدد ویترین ۲۴ ساعته، ۱۵ عدد ویترین ۴۸ ساعته، ۲۰ عدد ظرفیت تعداد آگهی، ۲۵ عدد نشان فوری
  Click Element                       ${Continue_Buying_Button}
  Wait Until Page Contains            پیش فاکتور                                timeout=5s
  ${PreInvoice_Payment_Button}        Get Text                                  ${PreInvoice_Payment_Button}
  Should Be Equal                     پرداخت ${Final_Price} تومان               ${PreInvoice_Payment_Button}
  Click By Text                       پرداخت ۱,۶۴۲,۱۹۳ تومان

Validation Packages In Protools
  Wait Until Page Contains            با بروزرسانی، آگهی شما به بالاترین آگهی در گروه خود منتقل می شود                                             timeout=10s
  Element Text Should Be              ${Refresh_Package_Number}                 ${refresh}
  Element Text Should Be              ${Vitrin24_Package_Number}                ${vitrin24}
  Element Text Should Be              ${Vitrin48_Package_Number}                ${vitrin48}
  Element Text Should Be              ${Limitation_Package_Number}              ${limitation}
  Element Text Should Be              ${InstantTag_Package_Number}              ${instant_tag}
