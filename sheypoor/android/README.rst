============================================================
Android Automation Test With Appium & Robot Framework
============================================================

.. contents:: **Dependencies:**
   :depth: 1
   :local:

Install Java JDK
------------------------

For installing Java JDK there is good instructions in the oracle site, besides that, there are  numbers of tutorial you will find in google search. Here’s what I did to install::

   sudo add-apt-repository ppa:webupd8team/java

   sudo apt-get update

   sudo apt-get install oracle-java8-installer

   sudo update-alternatives --config java

Verify Java installation::

   java -version


Set Java_Home
-------------

For setting JAVA_HOME open your ``~/.bashrc`` OR ``~/.zshrc`` file in any text editor and add the following 2 lines at the end of the file::

   vim ~/.zshrc

Add these 2 lines:

Please note: your JAVA_HOME path should be exactly as the output for the sudo update-alternatives –config java command::

   export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
   export PATH=${JAVA_HOME}/bin:$PATH

Install Selenium
-------------

Please follow this post for the Selenium installation tutorial:
`How To Install Selenium`_

Install Robot Framework Appium library
-------------

Use this command::

    pip install robotframework-appiumlibrary

Install Appium
-------------

Please follow this post for the Appium installation tutorial:
`Installing Appium`_

Now, run appium command to check the appium server is running properly::

   appium --relaxed-security

Also, run appium-doctor command to check the missing configuration::

   appium-doctor


Install Android SDK
-------------

During the installation, the latest Android Studio zip file will be downloaded from Google server. Once the installation is finished, you can open Android Studio from Unity Dash or your preferred app launcher::

  sudo add-apt-repository ppa:maarten-fonville/android-studio

  sudo apt update

  sudo apt install android-studio

Set Android_Home
-----------------

Open the  ``~/.bashrc`` OR ``~/.zshrc`` file and add the following 2 lines at the bottom of the file then save the file::

  export ANDROID_HOME=/home/abqu/Android/Sdk
  export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

Install Genymotion
--------------------

Create and Run android device emulator with `Genymotion`_

See the list of devices ::

    adb devices

UIAutomatorViewer
--------------------

This can be done by the following method

open uiautomatorviewer file in the Android installation folder with the following command::

  Android/Sdk/tools/bin
  
  ./uiautomatorviewer


.. _How To Install Selenium: https://selenium-python.readthedocs.io/installation.html
.. _Installing Appium: https://appium.io/docs/en/about-appium/getting-started/?lang=en
.. _Genymotion: https://www.genymotion.com/download/
