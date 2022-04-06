
============================================================
Android Automation Test With Appium & Robot Framework
============================================================

.. contents:: **Contents:**
   :depth: 1
   :local:

Install Java JDK
------------------------

For installing Java JDK there is good instructions in the oracle site, besides that, there are  numbers of tutorial you will find in google search. Here’s what I did to install

   sudo add-apt-repository ppa:webupd8team/java
   sudo apt-get update
   sudo apt-get install oracle-java8-installer
   sudo update-alternatives --config java

Verify Java installation:

  java -version


Set Java_Home
-------------

For setting JAVA_HOME open your `~/.bashrc` OR `~/.zshrc` file in any text editor and add the following 2 lines at the end of the file:

   vim ~/.zshrc

Add these 2 lines:

Please note: your JAVA_HOME path should be exactly as the output for the sudo update-alternatives –config java command

   export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
   export PATH=${JAVA_HOME}/bin:$PATH
