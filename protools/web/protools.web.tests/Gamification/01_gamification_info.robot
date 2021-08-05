*** Settings ***
Documentation                         بررسی اکشن ها و امتیازات هر اکشن
Resource                              ../../../../Resources/all.resource
Test Teardown                         Close Browser

*** Variables ***
${row_1}                              بارگذاری عکس پروفایل
${score_1}                            10
${row_2}                              تعریف نام پروفایل
${score_2}                            10
${row_3}                              ثبت آگهی جدید
${score_3}                            2
${row_4}                              ثبت آگهی عکس‌دار
${score_4}                            1
${row_5}                              ثبت آگهی با بیش از ۳ عکس
${score_5}                            1
${row_6}                              ثبت آگهی با بیش از ۸ عکس
${score_6}                            1
${row_7}                              ثبت آگهی با جزئیات بیشتر
${score_7}                            1
${row_8}                              استفاده از بسته‌ی بروزرسانی
${score_8}                            2
${row_9}                              استفاده از بسته‌ی ویترین ۲۴ ساعته
${score_9}                            4
${row_10}                             استفاده از بسته‌ی ویترین ۴۸ ساعته
${score_10}                           6
${row_11}                             استفاده از تگ فوری
${score_11}                           2
${row_12}                             ثبت آگهی با بسته‌ی افزایش ظرفیت
${score_12}                           1
${row_13}                             تمدید آگهی منقضی شده
${score_13}                           1
${row_14}                             خرید بسته‌های همراه فایل
${score_14}                           20
${row_15}                             خرید بسته‌های بانک درخواست
${score_15}                           20
${row_16}                             خرید بسته‌های بروزرسانی
${score_16}                           20
${row_17}                             خرید بسته‌های ویترین ۲۴ ساعته
${score_17}                           20
${row_18}                             خرید بسته‌های ویترین ۴۸ ساعته
${score_18}                           20
${row_19}                             خرید بسته‌های تگ فوری
${score_19}                           20
${row_20}                             خرید بسته‌های ظرفیت اضافه ثبت آگهی
${score_20}                           20

*** Test Cases ***
Check Gamification Information And Scores
  Login Protools                      آلونک
  Create Shop In Sheypoor             املاک
  Back To Protools Page
  Go To User Profile Page
  Go To Information Popup
  Check Scores Of Each Action

*** Keywords ***
Go To Information Popup
  Click By Text                       سطح‌بندی و امتیازات
  Wait Until Page Contains            امتیازها چگونه محاسبه می‌شود؟

Check Scores Of Each Action
  FOR   ${INDEX}    IN RANGE    20
    Table Cell Should Contain         //*[@id="content"]/div/table        ${INDEX+1}    1    ${row_${INDEX+1}}
    Table Cell Should Contain         //*[@id="content"]/div/table        ${INDEX+1}    2    ${score_${INDEX+1}}
  END
