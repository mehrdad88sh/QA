*** Settings ***
Library                               SeleniumLibrary                           timeout=30s
Library                               Collections
Library                               String
Library                               FakerLibrary                              locale=fa_IR
Library                               ../../../lib/splitwords.py
Library                               ../../../lib/captcha.py
Library                               OperatingSystem
Variables                             ../variables/Variables.py
Resource                              ../../../Resources/all.resource

*** Variables ***
# RD = Rent & Deposit
# BS = Buying & Seller
${image_profile_path}                 ${CURDIR}/images/imageprofile.jpg
${images_Realestate_path}             ${CURDIR}/images

*** Keywords ***
Open Browser On Test Enviroment
  Set Log Level                       trace
  Open Browser                        chrome://version                          browser=chrome
  Maximize Browser Window
  Go To                               ${Test_Enviroment.format('${trumpet_env}')}/pro
  Wait Until Page Contains            با شیپور کسب و کار خود را متحول کنید      timeout=10s

Login Alunak
  Login Protools                      آلونک

Login SheypoorPlus
  Login Protools                      شیپورپلاس

Login Protools
  [Arguments]                         ${Category_Type}
  IF                                  '${Category_Type}' == 'آلونک'
      Click Element                   ${Alunak}
      Wait Until Page Contains        با آلونک کسب و کار خود را متحول کنید      timeout=10s
  ELSE IF                             '${Category_Type}' == 'شیپورپلاس'
      Click Element                   ${SheypoorCar}
      Wait Until Page Contains        با شیپور کسب و کار خود را متحول کنید      timeout=10s
  END
  Click Element                       ${Register_Button}
  Wait Until Page Contains            ورود / ثبت‌نام                             timeout=10s
  Check Error Message For Wrong Phone Number
  Input Random Mobile
  Click Element                       ${Login_Button}
  Wait Until Page Contains            تائید شماره موبایل                        timeout=10s
  Get Code From Mock Server
  Input Verification Code
  Close Edit Profile Popup Message
  Listing Status

Listing Status
  ${Status}                           Run Keyword And Return Status
  ...                                 Wait Until Page Contains Element          name:file-item-0       timeout=3s
  IF                                  ${Status} == False
      Wait Until Page Contains        در اینجا فایل خود را ثبت و مدیریت کنید.   timeout=3s
  ELSE IF                             ${Status}
      Wait Until Page Contains        فایل موجود می‌باشد                         timeout=3s
  END

Convert RealEstate File To Listing
  Convert File To Listing             املاک

Convert Car File To Listing
  Convert File To Listing             خودرو

Convert File To Listing
  [Arguments]                         ${Category_Type}
  Go To File Management Page          ${Category_Type}
  Click Element                       name=file-item-0
  Reload Page
  Wait Until Keyword Succeeds         3x     2s                        Page Should Contain  آگهی نشده
  Click Button                        name=advertise-action
  Wait Until Page Contains            توضیحات                          timeout=10s
  Fill File Description
  Click Button                        name=apply-action
  Wait Until Page Contains            آگهی شما با موفقیت ثبت شد        timeout=10s
  Click Element                       name=listing-management-action
  Wait Until Page Contains Element    name:listing-item-0              timeout=10s

Check Error Message For Wrong Phone Number
  ${Wrong_Phone_Number}               Generate Random String           12   [NUMBERS]
  Input Text                          ${Phone_Number_Field}            ${Wrong_Phone_Number}
  Click Element                       ${Login_Button}
  Wait Until Page Contains           لطفا یک شماره تلفن صحیح وارد کنید   timeout=5s
  Press Keys                          ${Phone_Number_Field}            CTRL+a+DELETE

Input Random Mobile
  ${Random_Number}                    Generate Random String           7   [NUMBERS]
  Set Suite Variable                  ${Random_User_Mobile}            0900${Random_Number}
  Input Text                          ${Phone_Number_Field}            ${Random_User_Mobile}

Input Random User Name
  Generate Random username
  Input Text                          name:firstName                   ${Random_User_Name}

Get Code From Mock Server
  Execute Javascript                  window.open('${Test_Enviroment_Mock.format('${trumpet_env}')}=${Random_User_Mobile}');
  Switch Window                       NEW
  Wait Until Page Contains Element    ${Verification_Code_Element}     timeout=10s
  ${Verification_Code}                Get Text                         ${Verification_Code_Element}
  ${Verification_Code}                Get Regexp Matches               ${Verification_Code}     \\d{4}
  ${Verification_Code}                Convert To String                ${Verification_Code[0]}
  ${Verification_Code}                split                            ${Verification_Code}
  Set Suite Variable                  ${Verification_Code}             ${Verification_Code}
  Close Window
  Switch Window                       MAIN

Input Verification Code
  Wait Until Page Contains Element    ${Gray_Sumbit_Button}            timeout=10s
  FOR   ${INDEX}   IN RANGE   0   4
        ${Pincode}                    Get WebElements                  ${Input_Code_Container}
        Input Text                    ${Pincode[${INDEX}]}             ${Verification_Code[${INDEX}]}
  END
  Page Should Not Contain Element     ${Gray_Sumbit_Button}
  Click By Text                       تایید

Set Location
  Click Element                       name:location-trigger
  Wait Until Page Contains Element    name:location-0                  timeout=10s
  Click Element                       ${Alborz_ID}
  Wait Until Page Contains Element    name:location-1                  timeout=10s
  Click Element                       ${Karaj_ID}
  Wait Until Page Contains Element    name:location-2                  timeout=10s
  ${Input_Search}                     Get WebElements                  ${Input_Search}
  Input Text                          ${Input_Search}[2]               گلشهر
  Click Element                       ${Golshahr_ID}
  Element Should Contain              name:location                    کرج > گلشهر

Set Personal Notebook
  Click Element                       css:[name="دفترچه شخصی"]
  Wait Until Page Contains            اطلاعات این بخش فقط برای شما نمایش داده می‌شود و پر کردن آن اختیاری است     timeout=10s
  ${first_name}                       First Name
  ${last_name}                        Last Name
  Input Text                          name:a69533             ${first_name} ${last_name}
  Input Text                          name:a69534             ${Random_User_Mobile}
  ${address}                          Address
  Input Text                          name:a69535             ${address}
  Click Button                        name:apply-action
  Execute JavaScript                  window.scrollTo(0,0)

Number Of Rooms
  Click Element                       select-a68133
  Wait Until Page Contains Element    css:[role="listbox"]      timeout=10s
  Click Element                       name:439837
  Element Should Contain              select-a68133             بدون اتاق

Set Area
  Input Text                          name:a68085                 85

Set Location In Filters
  Click Element                       name:location-trigger
  Wait Until Page Contains Element    name:location-0                  timeout=10s
  Click Element                       ${Alborz_ID}
  Wait Until Page Contains Element    name:location-1                  timeout=10s
  Click Element                       ${Karaj_ID}
  Wait Until Page Contains Element    name:location-2                  timeout=10s
  ${Input_Search}                     Get WebElements                  ${Input_Search}
  Input Text                          ${Input_Search}[2]               گلشهر
  Click Element                       ${Golshahr_ID}
  Click Element                       name:choose-selectedItems

Submit File
  Execute JavaScript                  window.scrollTo(0,0)
  Click Element                       ${Submit_Button}
  Wait Until Keyword Succeeds         3x  2s  Page Should Contain      فایل شما با موفقیت ثبت شد
  Click Element                       name:file-management-action
  Reload Page
  Wait Until Page Contains Element    css:[name="search-input-html"]   timeout=10s
  Page Should Contain Element         name:file-item-0

Go To Submit File Page
  Click Element                       name:list-item-new-file
  Wait Until Page Contains            انتخاب عکس‌های آگهی               timeout=10s
  Wait Until Page Contains Element    css:[tabindex="-1"]              timeout=10s

Select More Detail Button
  Click Element                       name:افزودن جزئیات بیشتر
  Wait Until Page Contains Element    css:[role="document"]            timeout=10s

Select Property Facilities Button
  Click Element                       name:افزودن امکانات ملک
  Wait Until Page Contains Element    css:[role="document"]            timeout=10s

Apply More Detail
  Click Button                        name:apply-action

Apply Property Facilities
  Click Button                        name:apply-action

Select Form Clear Button
  Wait Until Keyword Succeeds         3x   2s                          Click Element                      name:form-clear-action
  Wait Until Keyword Succeeds         3x   2s                          Wait Until Page Contains Element   css:[role="document"]      timeout=10s
  Wait Until Page Contains            از انصراف اطمینان دارید؟         timeout=10s
  Click Element                       ${Confirm_Button}

Go To My Packages Page
  Click Element                       ${My_Packages_Button}
  Wait Until Page Contains            با بروزرسانی، آگهی شما به بالاترین آگهی در گروه خود منتقل می شود                                timeout=10s

Go To Package Purchase Page
  Click Element                       ${Buy_Package_Button}
  Wait Until Page Contains            انتخاب و خرید بسته به تعداد مورد نیاز شما!                          timeout=10s

Go To Custom Package Purchase Page
  Click Element                       ${Custom_Package_Button}
  Wait Until Page Contains            هنوز هیچ موردی انتخاب نکرده اید  timeout=10s

Upload RealEstate Images
  FOR                                 ${INDEX}   IN RANGE    4
   Execute JavaScript                 window.document.getElementsByName('select-images-action')[0].value='${EMPTY}'
   Choose File                        name:select-images-action        ${images_Realestate_path}/0${INDEX}.jpg
   Wait Until Page Does Not Contain Element                            name:image-upload-loading          timeout=20s
   Wait Until Keyword Succeeds        3x   2s  Check Trash Icon For Each Image                            ${INDEX+1}
  END

Check Trash Icon For Each Image
  [Arguments]                         ${count}
      ${TrashIcon}                    Get Element Count                name:form-delete-action
      ${Status}                       Should Be Equal                  ${count}       ${TrashIcon}

Successful Payment In Sheypoor
  [Arguments]                         ${Package_Type}
  Wait Until Page Contains            درحال انتقال به درگاه پرداخت     timeout=10s
  Click Element                       css:button.button.green
  Wait Until Page Contains            پرداخت شما با موفقیت انجام شد.   timeout=10s
  Element Should Contain              class:text-right                 ${Package_Type}
  Click Link                          بازگشت به برنامه

Go To User Profile Page
  Wait Until Page Contains Element    ${profile_name_ID}
  Click Element                       ${profile_name_ID}
  Close Level Up Popup Message
  Wait Until Page Contains            فعال در ${Company}               timeout=10s

Go To Reviews Tab
  Click Element                       name:reviews
  Wait Until Page Contains Element    id:rate-and-review-average       timeout=10s
  Wait Until Page Contains            ${Submit_Comment}                timeout=10s

Go To Edit Profile Page
  Click Element                       ${edit_profile_ID}
  Wait Until Page Contains            ویرایش پروفایل                   timeout=10s

Add Profile Image
  Execute JavaScript                  window.scrollTo(0,0)
  Click Element                       ${Add_Profile_Image}
  Wait Until Page Contains            انتخاب تصویر                     timeout=10s
  Choose File                         ${Add_New_Image}                 ${image_profile_path}
  Wait Until Page Contains            ثبت عکس                          timeout=10s
  Click Element                       ${Sumbit_Image}
  Wait Until Page Contains            عکس شما با موفقیت ثبت شد، پس از بررسی توسط ادمین نمایش داده می‌شود         timeout=10s

Remove Profile Image
  Execute JavaScript                  window.scrollTo(0,0)
  Click Element                       ${Remove_Profile_Image}
  Wait Until Page Contains            آیا از حذف تصویر مطمئن هستید؟
  Click Element                       ${Confirm_Button}
  Wait Until Page Contains            حذف عکس پروفایل با موفقیت انجام شد.       timeout=3s

Profile Image Validation In Profile Page
  Go To User Profile Page
  Go To Edit Profile Page
  Profile Image Status

Profile Image Status
  Image In Review Status
  Image Rejected Status
  Image Verified Status

Image In Review Status
  Wait Until Page Contains             تصویر بعد از تایید ادمین نمایش داده میشود.    timeout=3s
  Add Profile Image
  Wait Until Page Contains             تصویر بارگذاری شده و درحال بررسی است.         timeout=3s

Image Rejected Status
  Reject Profile Image By Admin
  Back To Protools Page
  Go To User Profile Page
  Go To Edit Profile Page
  Wait Until Page Contains             تصویر بارگذاری شده تایید نشد.                 timeout=3s

Image Verified Status
  Add Profile Image
  Confirm Profile Image By Admin
  Back To Protools Page
  Go To User Profile Page
  Go To Edit Profile Page
  Wait Until Page Contains             تصویر شما تایید شده است.                      timeout=3s
  Go To User Profile Page

Fill Profile Name
  Generate Random username
  Input Text                          name:name                        ${Random_User_Name}

Fill Location Job
  Go To Location Job
  Select Alborz Province
  Select Karaj City
  Select Multi Neighborhood Of Karaj
  Submit Selected Locations

Go To Location Job
  Click Element                       ${Location_Job_ID}
  Wait Until Page Contains Element                                     css:[role="document"]
  Page Should Contain                 انتخاب

Select Alborz Province
  Input Text                          ${Input_Search}         البرز
  Click Element                       ${Alborz_ID}
  Wait Until Page Contains Element                                     ${Karaj_ID}

Select Karaj City
  Click Element                       ${Karaj_ID}
  Wait Until Page Contains Element                                     ${Golshahr_ID}

Select Multi Neighborhood Of Karaj
  Click Element                       css:[name="n3981"]               #باغستان
  Click Element                       css:[name="n3983"]               #جهانشهر
  Click Element                       css:[name="n4000"]               #عظیمیه
  Click Element                       css:[name="n4005"]               #گلشهر
  Click Element                       css:[name="n4011"]               #مهرویلا

Submit Selected Locations
  Click Element                       name:choose-selectedItems
  Element Should Contain              name:locations                   باغستان، جهانشهر، عظیمیه، گلشهر، مهرویلا

Submit Profile Information
  Execute JavaScript                  window.scrollTo(0,0)
  Click Element                       ${Profile_Submit_Button}
  Wait Until Page Contains            اطلاعات با موفقیت بروز شد.        timeout=10s
  Wait Until Page Contains            عضو شیپور                        timeout=10s

Validate Gamification Scores
  Execute JavaScript                  window.scrollTo(0,500)
  Page Should Contain                 امتیاز برای تعریف نام پروفایل
  Page Should Contain                 امتیاز برای بارگذاری عکس پروفایل

Confirm Profile Image By Admin
  Go To                               ${Users_Search_Page.format('${trumpet_env}')}
  Input Text                          ${Contact_Number_Field}          ${Random_User_Mobile}
  Click Element                       ${Search_Button}
  Wait Until Page Contains            ${Random_User_Name}              timeout=10s
  Click By Text                       تایید عکس
  Sleep    500ms
  Wait Until Page Contains            آیا مطمئن هستید؟                timeout=10s
  Click By Text                       بله
  Wait Until Page Contains            عملیات با موفقیت انجام شد       timeout=10s

Reject Profile Image By Admin
  Go To                               ${Users_Search_Page.format('${trumpet_env}')}
  Input Text                          ${Contact_Number_Field}          ${Random_User_Mobile}
  Click Element                       ${Search_Button}
  Wait Until Page Contains            ${Random_User_Name}              timeout=10s
  Click By Text                       رد عکس
  Wait Until Page Contains            دلیل رد عکس
  Click Element                       ${Reject_Image_Button}
  Sleep    500ms
  Wait Until Page Contains            عملیات با موفقیت انجام شد       timeout=10s

Close Level Up Popup Message
  FOR   ${INDEX}   IN RANGE   3
        ${Status}                     Run Keyword And Return Status
  ...   Wait Until Page Contains Element    ${Close_Button}           timeout=5s
        Run Keyword If     ${Status}        Click Element             ${Close_Button}
        Exit For Loop If   ${Status} == False
  END

Close Edit Profile Popup Message
  FOR   ${INDEX}   IN RANGE   3
        ${Status}                     Run Keyword And Return Status
  ...   Wait Until Page Contains Element    ${Close_Button}           timeout=5s
        Run Keyword If     ${Status}        Click Element             ${Close_Button}
        Exit For Loop If   ${Status} == False
  END

Upgrade User To Premium Profile
  Close Level Up Popup Message
  Wait Until Page Contains Element    ${Premium_Button}                timeout=10s
  Click Element                       ${Premium_Button}
  Page Should Contain                 ارتقاء پروفایل
  Wait Until Page Contains            ۱۵۰,۰۰۰ تومان                    timeout=10s
  Click Button                        پرداخت
  Successful Payment In Sheypoor      پروفایل حرفه‌ای
  Wait Until Page Contains            اعتبار پروفایل حرفه‌ای            timeout=10s
  Close Level Up Popup Message

Fill File Description
  Press Keys                          name:description                 CTRL+a+DELETE
  ${File_Description}                 Sentence                         nb_words=20
  Set Suite Variable                  ${File_Description}
  Input Text                          css:[name=description]           ${File_Description}

Fill About Shop
  Press Keys                          name:about                       CTRL+a+DELETE
  ${About_Shop}                       Sentence                         nb_words=20
  Set Suite Variable                  ${About_Shop}
  Input Text                          css:[name=about]                 ${About_Shop}
  Click Element                       name:save-action
  Wait Until Page Contains            ${About_Shop}

Fill Slogan Shop
  Press Keys                          name:slogan                      CTRL+a+DELETE
  ${Slogan_Shop}                      Sentence                         nb_words=5
  Set Suite Variable                  ${Slogan_Shop}
  Input Text                          css:[name=slogan]                ${Slogan_Shop}
  Click Element                       name:save-action
  Wait Until Page Contains            ${Slogan_Shop}

Open File And Check Images
  Click Element                       name:file-item-0
  Wait Until Page Contains            آگهی نشده                        timeout=10s
  Sleep    1s
  Wait Until Page Contains Element    ${Image_In_Listing_Details}      timeout=10s
  FOR   ${INDEX}   IN RANGE    3
    Click Element                     ${Next_Slide_Button}
    Sleep    1s
  END
  Click Element                       ${Image_In_Listing_Details}
  ${Next_Slide_Button}                Get WebElements                  ${Next_Slide_Button}
  Wait Until Page Contains Element    ${Next_Slide_Button}[1]          timeout=10s
  Sleep    1s
  FOR   ${INDEX}   IN RANGE    3
    Click Element                     ${Next_Slide_Button}[1]
    Sleep    1s
  END
  Click Element                       ${Close_Slider_Button}

Go To Listing Management Page
  Click Element                       ${Listing_Management_Button}
  Wait Until Page Contains            مدیریت آگهی‌ها

Go To File Management Page
  [Arguments]                         ${Category_Type}
  Click Element                       ${File_Management_Button}
  IF                                  "${Category_Type}" == "املاک"
  Wait Until Page Contains            مدیریت فایل‌ها                             timeout=10s
  ELSE IF                             "${Category_Type}" == "خودرو"
  Wait Until Page Contains            مدیریت پارکینگ                            timeout=10s
  END

  Wait Until Page Contains Element    css:[name="search-input-html"]   timeout=10s
  Page Should Contain Element         name:file-item-0

Go To File Bank Page
  Click Element                       ${File_Bank_Button}
  Wait Until Page Contains            خرید همراه فایل                  timeout=10s

Go To Team Management Page
  Click Element                       ${Team_Management_Menu}
  Wait Until Page Contains            افزودن همکار جدید
  Page Should Contain                 برای اضافه کردن اعضای جدید و تعیین نقش آنها در تیم روی دکمه روبرو کلیک کنید.

Go To My Requests Page
  Click Element                       ${My_Requests_Button}
  Wait Until Page Contains            ثبت درخواست مشتری

Select Rent And Deposit Category
  Click Element                       ${Category_Selection}
  ${Status}                           Run Keyword And Return Status    Wait Until Page Contains Element    css:[id=content]                 timeout=5s
  IF                                  ${Status} == False
  Click Element                       ${Category_Selection}
  END
  Click Element                       name:43606
  Textfield Value Should Be           name:category                    رهن و اجاره خانه و آپارتمان
  Wait Until Page Contains Element    select-a68096                    timeout=10s

Select Buying And Selling Category
  Click Element                       ${Category_Selection}
  Wait Until Page Contains Element    css:[tabindex="-1"]              timeout=10s
  Click Element                       name:43604
  Textfield Value Should Be           name:category                    خرید و فروش خانه و آپارتمان
  Wait Until Page Contains Element    select-a68094                    timeout=10s

Select Land And Garden Category
  Click Element                       ${Category_Selection}
  Wait Until Page Contains Element    css:[role="document"]       timeout=10s
  Click Element                       name:44099
  Textfield Value Should Be           name:category               زمین و باغ
  Wait Until Page Contains Element    select-a69120               timeout=10s

Create File In Land And Garden Category
  Go To Submit File Page
  Select Land And Garden Category
  Set Location
  Set Area
  Fill File Description
  Submit File

Select Property Type In Rent and Deposit Category
  Click Element                       ${Property_Type_Apartment}
  Wait Until Page Contains Element    ${Property_Type_List}
  Select Property Type                آپارتمان

Select Property Type In Buying And Selling Category
  Click Element                       ${Property_Type_Vila}
  Wait Until Page Contains Element    ${Property_Type_List}
  Select Property Type                ویلا

Select Property Type
  [Arguments]                         ${Property_Type}
  IF       '${Property_Type}' == 'آپارتمان'
                                      Click Element                    ${Apartment}
                                      Element Text Should Be           ${Property_Type_Apartment}    آپارتمان
  ELSE IF  '${Property_Type}' == 'ویلا'
                                      Click Element                    ${Vila}
                                      Element Text Should Be           ${Property_Type_Vila}         ویلا
  END

Select Year Of Construction
  ${Status}                           Run Keyword And Return Status
  ...                                 Wait Until Page Contains Element
  ...                                 select-a92367                    timeout=10s
  Run Keyword If
  ...                                 ${Status}
  ...                                 Set Year Of Construction For Rent And Deposit Category
  ...                                 ELSE
  ...                                 Set Year Of Construction For Buying And Selling Category

Set Year Of Construction For Rent And Deposit Category
  Click Element                       select-a92367
  Wait Until Page Contains Element    css:[role="listbox"]             timeout=10s
  Click Element                       name:455210
  Element Should Contain              select-a92367                    1390

Set Year Of Construction For Buying And Selling Category
  Click Element                       select-a92368
  Wait Until Page Contains Element    css:[role="listbox"]             timeout=10s
  Click Element                       name:455206
  Element Should Contain              select-a92368                    1394

Set Building Floor
  ${Status}                           Run Keyword And Return Status
  ...                                 Wait Until Page Contains Element
  ...                                 select-a94551                    timeout=10s
  Run Keyword If
  ...                                 ${Status}
  ...                                 Set Building Floor For Rent And Deposit Category
  ...                                 ELSE
  ...                                 Set Building Floor For Buying And Selling Category

Set Building Floor For Rent And Deposit Category
  Click Element                       select-a94551
  Wait Until Page Contains Element    css:[role="listbox"]             timeout=10s
  Sleep    1s
  Click By Text                       زیر همکف
  Element Should Contain              select-a94551                    زیر همکف

Set Building Floor For Buying And Selling Category
  Click Element                       select-a94550
  Wait Until Page Contains Element    css:[role="listbox"]             timeout=10s
  Sleep    1s
  Click By Text                       زیر همکف
  Element Should Contain              select-a94550                    زیر همکف

Open Submit Customer Request Modal
  Click Element                       ${Customer_Request_Submission_Button}
  Wait Until Page Contains Element    ${Request_Save_Button}

Set Requester Name
  Generate Random username
  Input Text                          name:name                        ${Random_User_Name}
  Set Suite Variable                  ${Random_User_Name}              ${Random_User_Name}

Set Requester Phone
  Generate Random Phone Number
  Input Text                          name:telephoneNumber             ${Random_User_Mobile}
  Set Suite Variable                  ${Random_User_Mobile}            ${Random_User_Mobile}

Set Minimum and Maximum Area
  Input Text                          name:mn68085                     100
  Input Text                          name:mx68085                     300

Set Minimum and Maximum Rent
  Input Text                          name:mn68090                     250000000
  Input Text                          name:mx68090                     650000000

Set Minimum and Maximum Deposit
  Input Text                          name:mn68092                     4000000
  Input Text                          name:mx68092                     8000000

Submit Request
  Click Element                       ${Request_Save_Button}
  Wait Until Page Contains            درخواست با موفقیت اضافه شد.

Select Pride Category
  Select Vehicle Category
  Select Pride Brand

Select Vehicle Category
  Wait Until Page Contains Element    ${Category_Selection}            timeout=10s
  Click Element                       ${Category_Selection}
  Wait Until Page Contains Element    ${Vehicle_Category}              timeout=10s
  Click Element                       ${Vehicle_Category}
  Wait Until Page Contains Element    ${Pride_Category}                timeout=10s

Select Pride Brand
  ${Input_Search}                     Get WebElements                  ${Input_Search}
  Input Text                          ${Input_Search}[1]               پراید
  Click Element                       ${Pride_Category}
  Textfield Value Should Be           ${Category_Select_Value}         پراید
  Wait Until Page Contains Element    ${Car_Model_Selection}           timeout=10s

Select Car Model
  Click Element                       ${Car_Model_Selection}
  Wait Until Page Contains Element    ${Car_Model_List}                timeout=10s
  Click Element                       ${Saba_Car_Model}
  Element Should Contain              ${Car_Model_Selection}           صبا (صندوقدار)

Select Car Payment Type
  Click Element                       ${Payment_Type_Selection}
  Wait Until Page Contains Element    ${Payment_Type_List}             timeout=10s
  Click Element                       ${Cash_Peyment}
  Element Should Contain              ${Payment_Type_Selection}        نقدی

Set Minimum and Maximum Production Year
  Input Text                          name:mn68101                     1390
  Input Text                          name:mx68101                     1400

Set Minimum and Maximum Kilometer
  Input Text                          name:mn68102                     80000
  Input Text                          name:mx68102                     140000

Car Paint Type
  Click Element                       ${Paint_Selection}
  Wait Until Page Contains Element    ${Paint_List}                    timeout=10s
  Click Element                       ${Silver_Color}
  Element Should Contain              ${Paint_Selection}               نقره‌ای

Car Gearbox Type
  Click Element                       ${Gearbox_Type_Selection}
  Wait Until Page Contains Element    ${Gearbox_Type_List}             timeout=10s
  Click Element                       ${Automatic_Gearbox}
  Element Should Contain              ${Gearbox_Type_Selection}        اتوماتیک

Car Fuel Type
  Click Element                       ${Fuel_Type_Selection}
  Wait Until Page Contains Element    ${Fuel_Type_List}                timeout=10s
  Click Element                       ${Gasoline}
  Element Should Contain              ${Fuel_Type_Selection}           گازوئیل(دیزل)

Car Body Condition
  Click Element                       ${Body_Condition_Selection}
  Wait Until Page Contains Element    ${Body_Condition_List}           timeout=10s
  Click Element                       ${Two_Spots_Of_Paint}
  Element Should Contain              ${Body_Condition_Selection}      دو لکه رنگ

Set Minimum and Maximum Price
  Input Text                          name:mnprice                     750000000
  Input Text                          name:mxprice                     950000000

Expire The Listing
  Wait Until Page Contains Element    name=listing-item-0              timeout=5s
  Click Element                       name=listing-item-0
  Wait Until Page Contains            پذیرفته شد
  Get Listing ID From Listing Details
  Expire Listing With Mock
  Check Listing Status From Listing Details

Expire Listing With Mock
  Go to                               ${Test_Enviroment_Expire_Mock.format('${trumpet_env}')}?listingId=${Listing_ID}&expireAt=30day

Check Listing Status From Listing Details
  Go To                               ${Test_Enviroment.format('${trumpet_env}')}/pro/real-estate/file/${Listing_ID}
  Wait Until Page Contains            منقضی شد

Go To Store Page
  Click Element                       ${Store_Management_Button}
  Wait Until Page Contains            درباره فروشگاه                   timeout=5s
