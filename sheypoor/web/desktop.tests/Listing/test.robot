*** Settings ***
Library                               SeleniumLibrary

*** Variables ***
@{list}                               Red    Blue    Green    Black   White
&{dict}                               firstname=Mehrdad       lastname=Shahbazi
${condition}                          ${TRUE}
${test}                               qa
@{NUMBERS}                            ${1}    ${2}    ${5}
@{NAMES}                              one     two     five
@{ABC}                                a    b    c
@{XYZ}                                x    y    z
@{NUM}                                1    2    3    4    5
${rc}                                -1

*** Test Cases ***
My Informations
  # Personal Information                &{dict}
  # Favorite color                      @{list}
  # For loop type
  IF condition

*** Keywords ***
Personal Information
  [Arguments]                         &{dict}
  ${personal_info}                    Create Dictionary        &{dict}
  Log                                 ${personal_info.lastname}


Favorite color
  [Arguments]                         @{list}
  ${favorite_color}                   Create List              @{list}
  Log                                 ${favorite_color}[3]


For loop type
  FOR   ${index}   IN   @{list}
      IF     '${index}' == 'Green'
             Log    رنگ سبز شد از حلقه بیا بیرون
             Exit For Loop
      END
      Log    ${index}
  END

  FOR   ${index}   ${i}  IN ENUMERATE   @{list}
      Continue For Loop If        '${index}' == '1'
      Exit For Loop If            '${i}' == 'Black'
      Log    ${i}
  END

  # [Documentation]    Loops over values from 0 to 9.
  FOR    ${index}    IN RANGE    10
      Continue For Loop If    '${index}' == '2'
      Exit For Loop If        '${index}' == '7'
      Log    ${index}
  END

  # [Documentation]    Loops over values from 1 to 10.
  FOR    ${index}    IN RANGE    1    11
      IF     '${index}' == '3'
             Log    از ایندکس سوم بپر
             Continue For Loop
      END
      Log    ${index}
  END

  # [Documentation]    Loops over values 5, 15, and 25.
  FOR    ${index}    IN RANGE    5    26    10
      Log    ${index}
  END

  # [Documentation]    Loops over values 13, 3, and -7.
  FOR    ${index}    IN RANGE    13    -13    -10
      Log    ${index}
  END

  # [Documentation]    Arithmetic with variable.
  FOR    ${index}    IN RANGE    ${rc} + 1
      Log    ${index}
  END

  # [Documentation]    Loops over values 3.14, 4.34, and 5.54.
  FOR    ${index}    IN RANGE    3.14    6.09    1.2
      Log    ${index}
  END

  FOR   ${index}  IN   word1   word2   word3
      Log    ${index}
  END

  FOR    ${root}    IN    r1    r2
    FOR    ${child}    IN    c1   c2    c3
        FOR    ${grandchild}    IN    g1    g2
            Log Many    ${root}    ${child}    ${grandchild}
        END
    END
    FOR    ${sibling}    IN    s1    s2    s3
        IF    '${sibling}' != 's2'
            Log Many    ${root}    ${sibling}
        END
    END
  END

  FOR    ${index}    ${en}    ${fa}    IN ENUMERATE
  ...    cat      گربه
  ...    dog      سگ
  ...    horse    اسب
    Log    "${en}" in English is "${fa}" in Farsi (index: ${index})
  END

  FOR    ${number}    ${name}    IN ZIP    ${NUMBERS}    ${NAMES}
          Log Many    ${number}    ${name}
  END

  FOR    ${a}    ${x}    ${n}    IN ZIP    ${ABC}    ${XYZ}    ${NUM}
        Log Many    ${a}    ${x}    ${n}
  END

if condition
  IF      ${condition}
      Log    if condition is true
  END

  IF      '${test}' == 'qa'
      Log    condition test is QA
  ELSE
      Log    condition is not true
  END

  IF         ${rc} > 2
      Log    more than 2
  ELSE IF    1 < ${rc} < 2
      Log    between 1 $ 2
  ELSE IF    ${rc} == 0
      Log    zero
  ELSE
      Fail    rc is negative: ${rc}
  END

  Run Keyword If    ${condition}    Log    condition is TRUE

  Run Keyword Unless    ${condition}    Log  condition is FALSE
