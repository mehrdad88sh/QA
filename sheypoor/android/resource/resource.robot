*** Settings ***
Library                               AppiumLibrary                timeout=30
Library                               DateTime

*** Variables ***
${APPIUM}                             http://127.0.0.1:4723/wd/hub
${ANDROID_APP}                        ${CURDIR}/Sheypoor-PlayStoreDebug.apk
${APK_VERSION}                        6.7.0
${NO-RESET}                           ${TRUE}
${FULL-RESET}                         ${FALSE}
${APP_PACKAGE}                        com.sheypoor.mobile.debug
${APKNAME}                            ${APP_PACKAGE}
${deviceName}                         192.168.57.101:5555
${android_version}                    8.1
${avdName}                            Pixel_2_API_28
${SPLASH_ACTIVITY}                    com.sheypoor.mobile.MainActivity
${STAGING_BUTTON}                     com.sheypoor.mobile.debug:id/fragmentDebugStaging
${HOME_ACTIVITY}                      com.sheypoor.presentation.ui.home.HomeActivity

*** Keywords ***
Install App And open
  Open Application                    ${APPIUM}                        platformName=Android
    ...   device=${AVDname}           app=${ANDROID_APP}               automationName=UiAutomator2
    ...   version=8.1                 appActivity=${SPLASH_ACTIVITY}   appPackage=${APP_PACKAGE}
    ...   platform=ANDROID            disableAndroidWatchers=${TRUE}   uiautomator2ServerLaunchTimeout=60000
    ...   adbExecTimeout=50000        commandTimeout=20                uiautomator2ServerInstallTimeout=40000
    ...   newCommandTimeout=90        deviceName=${deviceName}         deviceReadyTimeout=30
    ...   isHeadless=${TRUE}          remoteAppsCacheLimit=0           autoGrantPermissions=${TRUE}
    ...   gpsEnabled=${TRUE}          resetKeyboard=${TRUE}            unicodeKeyboard=${TRUE}
    ...   noReset=${NO-RESET}         fullReset=${FULL-RESET}          deviceOrientation=portrait
    ...   idleTimeout=15              ignoreUnimportantViews=${TRUE}   AndroidMobileCapabilityType.ACCESS_FINE_LOCATION=${TRUE}
    ...   AndroidMobileCapabilityType.AUTO_GRANT_PERMISSIONS=${TRUE}   appWaitActivity=${SPLASH_ACTIVITY}
    ${currentAct}                       get Activity
    Wait Until Page Contains Element    id=${STAGING_BUTTON}      timeout=10
    Click Element                       id=${STAGING_BUTTON}
    Wait Until Page Contains Element    id=com.sheypoor.mobile.debug:id/postAdFab

Check App is Ready
    [Arguments]                         ${Activity}=${HOME_ACTIVITY}
    ${Start}                          	Get Current Date	result_format=epoch
    FOR    ${INDEX}    IN RANGE    0    20
         ${act}                         Get Activity
         Exit For Loop If              '${act}' == '${Activity}'
         Sleep     3s
    END
    ${Finish}                         	Get Current Date	result_format=epoch
    ${Timer}                            Evaluate    ${Finish} - ${Start}
    Run Keyword If                      ${Timer} > 60    Fail	  Long time to Load ${Timer}s
