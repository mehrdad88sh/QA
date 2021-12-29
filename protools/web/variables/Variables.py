class Variables(object):

    def __init__(self):
        pass

    def get_variables(self):
        return {
        'Alunak': 'name:alounak',
        'SheypoorCar': 'name:sheypoor-cars',
        'staging': 'https://staging.mielse.com',
        'stagingMock': 'https://staging.mielse.com/mock/getCode?mobile',
        'Apartment': 'آپارتمان',
        'Vila': 'ویلا',
        'profile_name_ID': 'name:profile-name',
        'edit_profile_ID': 'name:edit_profile',
        'aboutMe_ID': 'name:aboutMe',
        'Location_Job_ID': 'name:locations-trigger',
        'Input_Search': 'name:search-input-html',
        'Alborz_ID': 'css:[name="5"]',
        'Karaj_ID': 'css:[name="229"]',
        'Golshahr_ID': 'css:[name="n4005"]',
        'Submit_Button': 'name:form-submit-action',
        'Close_Button':  'name:close-action',
        'Complete_Profile_Button': 'name:edit-profile-action',
        'Add_Profile_Image': 'id:choose-avatar-action-desktop',
        'Add_New_Image': 'name:pick-image',
        'Sumbit_Image':  'name:accept-crop',
        'Your_Scores': 'name:score',
        'Rating': 'name:level',
        'Premium_Button': 'name:upgradeButton',
        'My_Packages_Button': 'name:list-item-packageManagement',
        'PackageـPurchase_Button': 'name:packageManage-action',
        'Refresh_Package_Name': 'name:simple-package-refresh',
        'Refresh_Package_Price': 'name=simple-package-refresh-price',
        'Refresh_Package_Number': 'name:refresh',
        'Special_Package_Name': 'name:special-package',
        'Special_Package_Price': 'name=simple-package-special-price',
        'Limitation_Package_Name': 'name:simple-package-limitation',
        'Limitation_Package_Price': 'name=simple-package-limitation-price',
        'Limitation_Package_Number': 'name:limitation',
        'InstantTag_Package_Name': 'name:simple-package-instant_tag',
        'InstantTag_Package_Price': 'name=simple-package-instant_tag-price',
        'InstantTag_Package_Number': 'name:instant_tag',
        'Vitrin24_Package_Name': 'name:simple-package-vitrine_24',
        'Vitrin24_Package_Price': 'name:simple-package-vitrine_24-price',
        'Vitrin24_Package_Number': 'name:vitrine_24',
        'Vitrin48_Package_Name': 'name:simple-package-vitrine_48',
        'Vitrin48_Package_Price': 'name:simple-package-vitrine_48-price',
        'Vitrin48_Package_Number': 'name:vitrine_48',
        'Video_Package_Number': 'name:listing_video',
        'My_Packages_Page': 'https://staging.mielse.com/pro/real-estate/packages',
        'File_Bank_Button': 'name:list-item-file-bank',
        'File_Bank_Purchase_Button': 'name:add-new-request-bank-item-empty-list-action',
        'New_Package_Purchase_Button': 'name:add-new-file',
        'File_Bank_Page': 'https://staging.mielse.com/pro/real-estate/file-bank',
        'Select_All_City': 'name:انتخاب کل یک شهر',
        'Select_7_Neighborhood': 'name:انتخاب هفت محله از یک شهر',
        'Select_3_Neighborhood': 'name:انتخاب سه محله از یک شهر',
        'Selection_Button': 'name:choose-action',
        'Tehran_Province': 'css:[nameid="8"]',
        'Tehran_City': 'css:[nameid="301"]',
        'Admin_User': 'admin1060@mielse.com',
        'Admin_Page': 'https://staging.mielse.com/trumpet/login',
        'Users_Search_Page': 'https://staging.mielse.com/trumpet/user/search',
        'Contact_Number_Field': 'css:[name=phone]',
        'Consultants_List_Page': 'https://staging.mielse.com/trumpet/consultant/list',
        'Search_Button': 'css:input.btn.btn-block.btn-primary',
        'Consultant_Number': '//*[@id="consultant-results-generic"]/tbody/tr/td[3]',
        'Consultant_Status': 'css:strong.text-success.listing-status',
        'CheckBox_Video': 'css:[name="8"]',
        'Consultant_Package_Price': 'css:[id=price]',
        'Consultant_Package_Duration': 'css:[id=duration]',
        'Add_Button': 'css:button.btn.btn-success',
        'Activation_Button': 'css:button.btn.btn-success.btn-block.package-activate',
        'Consultant_Package_Status': 'css:div.alert.alert-info',
        'Consultant_Package_Details': 'css:span.icon-info',
        'Team_Management_Menu': 'name:list-item-team-management',
        'Add_New_Colleague': 'name:new-member-action',
        'Consultant': 'name:radio-consultant',
        'Secretary': 'name:radio-secretary',
        'Colleague_Name': 'name:firstName',
        'Colleague_Menu': 'css:[role="menu"]',
        'Colleague_Delete_Button': 'name:menu-kick',
        'Colleague_Edit_Button': 'name:menu-edit',
        'Confirm_Button': 'name:confirm-accept-action',
        'Consultant_Specialty': 'css:[aria-pressed="false"]',
        'Consultant_Specialty_Dropdown': 'css:[aria-pressed="true"]',
        'Statistics_Button': 'name:list-item-statistics',
        'Start_Date': 'name:select-date-from',
        'End_Date': 'name:select-date-to',
        'Calendar': 'css:div.dayPickerContainer',
        'Days_Of_Current_Calendar': 'css:div.dayWrapper.currentMonth',
        'Days_In_Chart': 'css:g.recharts-layer.recharts-cartesian-axis-tick',
        'Previous_Month_Button': 'css:button.prev',
        'Contact_Information_Views_Chart': 'css:g.recharts-layer.recharts-line-dots',
        'Chart_Lines': 'css:g.recharts-layer.recharts-line',
        'Chart_Line_Dots': 'css:circle.recharts-dot.recharts-line-dot',
        'Right_Tooltip_In_Chart': 'css:div.recharts-tooltip-wrapper.recharts-tooltip-wrapper-right.recharts-tooltip-wrapper-top',
        'Left_Tooltip_In_Chart': 'css:div.recharts-tooltip-wrapper.recharts-tooltip-wrapper-left.recharts-tooltip-wrapper-top',
        'Active_Premium_Toggle': 'css:a.toggle-state.active.icon-ok[data-id="981"]',
        'Inactive_Premium_Toggle': 'css:a.toggle-state.inactive.icon-close[data-id="981"]',
        'Active_File_Request_Toggle': 'css:a.toggle-state.active.icon-ok[data-id="1118"]',
        'Inactive_File_Request_Toggle': 'css:a.toggle-state.inactive.icon-close[data-id="1118"]',
        'User_Comments_Page': 'https://staging.mielse.com/trumpet/user/comment',
        'Rate_Button': 'css:span.link.icon-rate.flex-icon.blue',
        'Overall_Stars': 'css:[class=icon-star]',
        'Sub_Rate_Stars': 'css:span.icon-star.qu-star',
        'Sub_Rate_Stars_Selected': 'css:span.icon-star.qu-star.selected',
        'Sumbit_Comment_Field': '//*[@id="popup-rating"]/div/div[2]/div[2]/div[3]/textarea',
        'Phone_Search_Bar': 'name:TelephonePrimary',
        'Confirm_Comment_Button': 'css:button.btn.btn-sm.btn-block.btn-success.comment-accept.hide-if-accept',
        'Review_Comment_State': 'css:strong.label.label-warning',
        'Accepted_Comment_State': 'css:strong.label.label-success',
        'Captcha_PopUp': 'css:div#popup-captcha.popup.open',
        'Close_Button_Captcha_PopUp': 'id:popup-captcha >> css:span.close',
        'Phone_Number_XXX': 'class:underlined',
        'My_Requests_Button': 'name:list-item-request-management',
        'Customer_Request_Submission_Button': 'add-new-request-list-empty-action',
        'Category_Selection': 'name:category-trigger',
        'Request_Save_Button': 'css:[name="save-form-action"]',
        'Image_In_Listing_Details': 'css:div.slider-frame',
        'Next_Slide_Button': 'name:next-slide',
        'Close_Slider_Button': 'css:[d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"]',
        'Category_Select_Value': 'name:category',
        'Vehicle_Category': 'name:43627',
        'Pride_Category': 'name:43976',
        'Car_Model_Selection': 'id:select-a68143',
        'Car_Model_List': 'css:[role="listbox"]',
        'Saba_Car_Model': 'name:440665',
        'Payment_Type_Selection': 'id:select-a69150',
        'Payment_Type_List': 'css:[role="listbox"]',
        'Cash_Peyment': 'name:445097',
        'Paint_Selection': 'id:select-a69130',
        'Paint_List': 'css:[role="listbox"]',
        'Silver_Color': 'name:445303',
        'Gearbox_Type_Selection': 'id:select-a69140',
        'Gearbox_Type_List': 'css:[role="listbox"]',
        'Automatic_Gearbox': 'name:445313',
        'Fuel_Type_Selection': 'id:select-a69602',
        'Fuel_Type_List': 'css:[role="listbox"]',
        'Gasoline': 'name:450678',
        'Body_Condition_Selection': 'id:select-a69160',
        'Body_Condition_List': 'css:[role="listbox"]',
        'Two_Spots_Of_Paint': 'name:445332',
        'Adding_Snackbar': 'css:[id="client-snackbar"]'
}
