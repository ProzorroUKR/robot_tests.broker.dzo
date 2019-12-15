*** Settings ***
Library  String
Library  DateTime
Library  dzo_service.py
Library  Selenium2Library

*** Variables ***
${locator.tenderId}                  xpath=//td[./text()='TenderID']/following-sibling::td[1]
${locator.title}                     xpath=//td[./text()='Загальна назва закупівлі']/following-sibling::td[1]
${locator.description}               xpath=//td[./text()='Предмет закупівлі']/following-sibling::td[1]
${locator.value.amount}              xpath=//td[./text()='Максимальний бюджет']/following-sibling::td[1]
${locator.minimalStep.amount}        xpath=//td[./text()='Мінімальний крок зменшення ціни']/following-sibling::td[1]
${locator.enquiryPeriod.endDate}     xpath=//td[./text()='Завершення періоду обговорення']/following-sibling::td[1]
${locator.tenderPeriod.endDate}      xpath=//td[./text()='Завершення періоду прийому пропозицій']/following-sibling::td[1]
${locator.items[0].deliveryAddress.countryName}    xpath=//td[@class='nameField'][./text()='Адреса поставки']/following-sibling::td[1]
${locator.items[0].deliveryDate.endDate}     xpath=//td[./text()='Кінцева дата поставки']/following-sibling::td[1]
${locator.items[0].classification.scheme}    xpath=//td[@class = 'nameField'][./text()='Клас CPV']
${locator.items[0].classification.id}        xpath=//td[./text()='Клас CPV']/following-sibling::td[1]/span[1]
${locator.items[0].classification.description}       xpath=//td[./text()='Клас CPV']/following-sibling::td[1]/span[2]
${locator.items[0].additionalClassifications[0].scheme}   xpath=//td[@class = 'nameField'][./text()='Клас ДКПП']
${locator.items[0].additionalClassifications[0].id}       xpath=//td[./text()='Клас ДКПП']/following-sibling::td[1]/span[1]
${locator.items[0].additionalClassifications[0].description}       xpath=//td[./text()='Клас ДКПП']/following-sibling::td[1]/span[2]
${locator.items[0].quantity}         xpath=//td[./text()='Кількість']/following-sibling::td[1]/span[1]
${locator.items[0].unit.code}        xpath=//td[./text()='Кількість']/following-sibling::td[1]/span[2]
${locator.questions[0].title}        xpath=//div[@class = 'question relative']//div[@class = 'title']
${locator.questions[0].description}  xpath = //div[@class='text']
${locator.questions[0].date}         xpath = //div[@class='date']
${locator.questions[0].answer}       xpath=//div[@class = 'answer relative']//div[@class = 'text']

##################
${plan.view.status}=  xpath=//div[@class="statusName"]
${tender.view.budget.amount}=  xpath=//td[text()="Очікувана вартість"]/following-sibling::td[1]/span
${plan.edit.budget.description}=  xpath=//input[@name="data[budget][description]"]
${plan.edit.budget.amount}=  xpath=//input[@name="data[budget][amount]"]
${plan.edit.items[0].deliveryDate.endDate}=  data[items][0][deliveryDate][endDate]
${plan.edit.items[0].quantity}=  xpath=//input[@name="data[items][0][quantity]"]
${plan.edit.budget.period}=  data[tender][tenderPeriod][startDate]

*** Keywords ***
Підготувати клієнт для користувача
  [Arguments]  ${username}
  ${chrome_options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
  Set Global Variable  ${DZO_MODIFICATION_DATE}  ${EMPTY}
  Call Method  ${chrome_options}  add_argument  --headless
  Create Webdriver  Chrome  alias=${username}  chrome_options=${chrome_options}
  Go To  ${USERS.users['${username}'].homepage}
#  Open Browser  ${USERS.users['${username}'].homepage}  ${USERS.users['${username}'].browser}  alias=${username}
  Set Window Size  @{USERS.users['${username}'].size}
  Set Window Position  @{USERS.users['${username}'].position}
  Run Keyword If  'Viewer' not in '${username}'  Login  ${username}

Login
  [Arguments]  ${username}
  Клікнути по елементу  xpath=//div[@class="authBtn"]/a
  Ввести текст  name=email  ${USERS.users['${username}'].login}
  Execute Javascript  $('input[name="email"]').attr('rel','CHANGE');
  Ввести текст  name=psw  ${USERS.users['${username}'].password}
  Клікнути по елементу  xpath=//button[contains(@class, 'btn')][./text()='Вхід']

Підготувати дані для оголошення тендера
  [Arguments]  ${username}  ${tender_data}  ${role_name}
  ${tender_data}=  adapt_data_for_role  ${role_name}  ${tender_data}
  [Return]  ${tender_data}

###############################################################################################################
######################################    СТВОРЕННЯ ПЛАНУ    ##################################################
###############################################################################################################

Створити план
  [Arguments]  ${username}  ${plan_data}
  Switch Browser  ${username}
  ${amount}=  add_second_sign_after_point  ${plan_data.data.budget.amount}
  ${breakdowns_length}=  Get Length  ${plan_data.data.budget.breakdown}
  ${items}=  Get From Dictionary  ${plan_data.data}  items
  ${items_length}=  Get Length  ${items}
  Click Element  xpath=//div[contains(text(),"Меню користувача")]
  Click Element  xpath=//a[@href="/cabinet/plans"]
  Click Element  xpath=//a[@href="/cabinet/plans/nulled"]
  Click Element  xpath=//a[@href="/plans/new"]
  Select From List By Value  name=plan_method  open_${plan_data.data.tender.procurementMethodType}
  Input Text  name=data[budget][amount]  ${amount}
  Select From List By Value  name=data[budget][currency]  ${plan_data.data.budget.breakdown[0].value.currency}
  Wait And Click  xpath=//a[@data-class="ДК021"]
  Select CPV  ${plan_data.data.classification.id}
  Wait And Input Text  xpath=//input[@name="data[budget][description]"]  ${plan_data.data.budget.description}

  :FOR  ${index}  IN RANGE  ${items_length}
  \  Add Plan Item  ${items[${index}]}  ${index}

  Click Element  xpath=//section[@id="multiBreakdowns"]/a
  :FOR  ${index}  IN RANGE  ${breakdowns_length}
  \  Add Plan Breakdown  ${plan_data.data.budget.breakdown}  ${index}

  Input Date  data[tender][tenderPeriod][startDate]  ${plan_data.data.tender.tenderPeriod.startDate}
  Click Element  xpath=//section[contains(@class, "datesBlock")]
  Wait Until Element Is Not Visible  xpath=//div[@id="ui-datepicker-div"]
  Wait And Click  xpath=//button[@value="publicate"]
  Wait And Click  xpath=//a[contains(@class, "tenderSignCommand")]
  Select Window  NEW
  Wait And Click  xpath=//a[@class="js-oldPageLink"]
  ${status}=  Run Keyword And Return Status  Wait Until Keyword Succeeds  30 x  1 s  Page Should Contain  Оберіть файл з особистим ключем (зазвичай з ім'ям Key-6.dat) та вкажіть пароль захисту
  Run Keyword If  ${status}  Wait Until Keyword Succeeds  30 x  20 s  Run Keywords
#  ...  Wait And Select From List By Label  id=CAsServersSelect  Тестовий ЦСК АТ "ІІТ"
  ...  Wait And Select From List By Label  id=CAsServersSelect  АЦСК ПАТ КБ «ПРИВАТБАНК»
  ...  AND  Execute Javascript  var element = document.getElementById('PKeyFileInput'); element.style.visibility="visible";
#  ...  AND  Choose File  id=PKeyFileInput  ${CURDIR}/Key-6.dat
#  ...  AND  Input text  id=PKeyPassword  12345677
  ...  AND  Choose File  id=PKeyFileInput  ${CURDIR}/TO_DEL.jks
  ...  AND  Input text  id=PKeyPassword  serge84tureckiy
  ...  AND  Wait And Click  id=PKeyReadButton
  ...  AND  Wait Until Page Contains  Ключ успішно завантажено  10
  Wait And Click  id=SignDataButton
  Wait Until Keyword Succeeds  60 x  1 s  Page Should Contain  Підпис успішно накладено та передано у ЦБД
  Select Window  MAIN

  ${plan_uaid}=  Get Text  xpath=//td[text()="Ідентифікатор плану"]/following-sibling::td

  Wait Until Keyword Succeeds  60 x  1 s  Run Keywords
  ...  Reload Page
  ...  AND  Element Should Be Visible  xpath=//a[@data-plan-action="scheduled"]
  Click Element  xpath=//a[@data-plan-action="scheduled"]
  Wait And Click  xpath=//a[@data-msg="jAlert OK"]

  [Return]  ${plan_uaid}

Add Plan Item
  [Arguments]  ${item}  ${index}
  ${quantity}=  add_second_sign_after_point  ${item.quantity}
  ${unit_id}=  convert_unit_id  ${item.unit.code}
  Wait And Click  xpath=//section[@id="multiItems"]/descendant::a[@class="addMultiItem"]
  Wait And Input Text  xpath=//input[@name="data[items][${index}][description]"]  ${item.description}
  Input Text  xpath=//input[@name="data[items][${index}][quantity]"]  ${quantity}
  Select From List By Value  xpath=//select[@name="data[items][${index}][unit_id]"]  ${unit_id}
  Click Element  xpath=//div[contains(@class, "tenderItemPositionElement")][@data-multiline="${index}"]/descendant::a[@data-class="ДК021"]
  Select CPV  ${item.classification.id}
  Input Date  data[items][${index}][deliveryDate][endDate]  ${item.deliveryDate.endDate}

Add Plan Breakdown
  [Arguments]  ${breakdowns}  ${index}
  ${amount}=  add_second_sign_after_point  ${breakdowns[${index}].value.amount}
  Wait And Click  xpath=//section[@id="multiBreakdowns"]/descendant::a[@class="addMultiItem"]
  Select From List By Value  xpath=//select[@name="data[budget][breakdown][${index}][title]"]  ${breakdowns[${index}].title}
  Input Text  xpath=//input[@name="data[budget][breakdown][${index}][description]"]  ${breakdowns[${index}].description}
  Input Text  xpath=//input[@name="data[budget][breakdown][${index}][value][amount]"]  ${amount}

Select CPV
  [Arguments]  ${classification_id}
  Select Frame  xpath=//iframe[contains(@src,'/js/classifications/universal/index.htm?lang=uk&shema=%D0%94%D0%9A021&relation=true')]
  Wait And Input Text  xpath=//input[@id="search"]  ${classification_id}
  Wait And Click  xpath=//a[contains(@id, "${classification_id.replace("-", "_")}")]
  Click Element  xpath=//a[@id="select"]
  Unselect Frame

Внести зміни в план
  [Arguments]  ${username}  ${tender_uaid}  ${fieldname}  ${fieldvalue}
  ${value}=  Run Keyword And Return If  "amount" in "${fieldname}" or "quantity" in "${fieldname}"  Convert To String  ${fieldvalue}
  ${fieldvalue}=  Set Variable If  ${value}  ${value}  ${fieldvalue}
  Wait And Click  xpath=//a[@class="button save"]
  Run Keyword If  "date" in "${fieldname}"  Input Date  ${plan.edit.${fieldname}}  ${fieldvalue}
  ...  ELSE IF  "period" in "${fieldname}"  Select From List By Value  data[budget][period][endDate]  ${fieldvalue["endDate"].split("-")[0]}
  ...  ELSE  Input Text  ${plan.edit.${fieldname}}  ${fieldvalue}
  Wait And Click  xpath=//button[@name="do"]

Додати предмет закупівлі в план
  [Arguments]  ${username}  ${tender_uaid}  ${item}
  Wait And Click  xpath=//a[@class="button save"]
  ${index}=  Get Matching Xpath Count  xpath=//div[@class="tenderItemElement tenderItemPositionElement"]
  ${index}=  Convert To Integer  ${index}
  Add Plan Item  ${item}  ${index - 1}
  Wait And Click  xpath=//button[@name="do"]

Видалити предмет закупівлі плану
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${lot_id}=${Empty}
  Wait And Click  xpath=//a[@class="button save"]
  Wait And Click  xpath=//input[contains(@value, "${item_id}")]/ancestor::div[contains(@class, "tenderItemElement")]/descendant::a[@class="deleteMultiItem"]
  Wait And Click  xpath=//a[@data-msg="jAlert OK"]
  Wait Until Element Is Not Visible  xpath=//div[@id="jAlertBack"]
  Wait And Click  xpath=//button[@name="do"]

Оновити сторінку з планом
  [Arguments]  ${username}  ${plan_uaid}
  Reload Page

Пошук плану по ідентифікатору
  [Arguments]  ${username}  ${plan_uaid}
  Go To  http://www.dzo.byustudio.in.ua/tenders/plans
  Select From List By Value  xpath=//select[@name="filter[object]"]  planID
  Input Text  xpath=//input[@name="filter[search]"]  ${plan_uaid}
  Click Element  xpath=//button[contains(@class,"not_toExtend")]
  Wait Until Keyword Succeeds  10 x  1 s  Locator Should Match X Times  xpath=//section[contains(@class,"list")]/descendant::div[contains(@class, "item")]  1
  Click Element  xpath=//a[contains(@class, "tenderLink")]

###############################################################################################################
###################################    ВІДОБРАЖЕННЯ ПЛАНУ    ##################################################
###############################################################################################################

Отримати інформацію із плану
  [Arguments]  ${username}  ${plan_uaid}  ${field_name}
  ${text}=  Get Text  ${plan.view.${field_name}}
  ${value}=  convert_dzo_data  ${text}  ${field_name}
  [Return]  ${value}

Отримати інформацію із тендера
  [Arguments]  ${username}  ${tender_uaid}  ${field_name}
  ${text}=  Get Text  ${tender.view.${field_name}}
  ${value}=  convert_dzo_data  ${text}  ${field_name}
#  ${value}=  Set Variable If  "amount" in "${field_name}"  ${value.replace("`", "")}  ${value}
  [Return]  ${value}



Створити тендер
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  tender_data
  #{tender_data}=   Add_time_for_GUI_FrontEnds   ${ARGUMENTS[1]}
  ${items}=         Get From Dictionary   ${ARGUMENTS[1].data}               items
  ${title}=         Get From Dictionary   ${ARGUMENTS[1].data}               title
  ${description}=   Get From Dictionary   ${ARGUMENTS[1].data}               description
  ${budget}=        Get From Dictionary   ${ARGUMENTS[1].data.value}         amount
  ${step_rate}=     Get From Dictionary   ${ARGUMENTS[1].data.minimalStep}   amount

  ${items_description}=   Get From Dictionary   ${ARGUMENTS[1].data}         description
  ${quantity}=      Get From Dictionary   ${items[0]}         quantity
  ${countryName}=   Get From Dictionary   ${ARGUMENTS[1].data.procuringEntity.address}       countryName
  ${delivery_end_date}=      Get From Dictionary   ${items[0].deliveryDate}   endDate
  ${delivery_end_date}=      convert_date_to_slash_format   ${delivery_end_date}
  ${cpv}=           Convert To String   Картонки
  ${cpv_id}=        Get From Dictionary   ${items[0].classification}         id
  ${cpv_id1}=       Replace String        ${cpv_id}   -   _
  ${dkpp_desc}=     Get From Dictionary   ${items[0].additionalClassifications[0]}   description
  ${dkpp_id}=       Get From Dictionary   ${items[0].additionalClassifications[0]}   id
  ${dkpp_id1}=      Replace String        ${dkpp_id}   -   _

  ${enquiry_end_date}=   Get From Dictionary         ${ARGUMENTS[1].data.enquiryPeriod}   endDate
  ${enquiry_end_date}=   convert_date_to_slash_format   ${enquiry_end_date}
  ${end_date}=      Get From Dictionary   ${ARGUMENTS[1].data.tenderPeriod}   endDate
  ${end_date}=      convert_date_to_slash_format   ${end_date}

  Selenium2Library.Switch Browser     ${ARGUMENTS[0]}
  Wait Until Page Contains Element    jquery=a[href="/tenders/new"]   30
  Click Element                       jquery=a[href="/tenders/new"]
  Wait Until Page Contains Element    name=tender_title   30
  Input text                          name=tender_title    ${title}
  Input text                          name=tender_description    ${description}
  Input text                          name=tender_value_amount   ${budget}
  Input text                          name=tender_minimalStep_amount   ${step_rate}

# Додати специфікацю початок
  Input text                          name=items[0][item_description]    ${items_description}
  Input text                          name=items[0][item_quantity]   ${quantity}
  Input text                          name=items[0][item_deliveryAddress_countryName]   ${countryName}
  Input text                          name=items[0][item_deliveryDate_endDate]       ${delivery_end_date}
  Click Element                       xpath=//a[contains(@data-class, 'cpv')][./text()='Визначити за довідником']
  Select Frame                        xpath=//iframe[contains(@src,'/js/classifications/cpv/uk.htm?relation=true')]
  Input text                          id=search     ${cpv}
  Wait Until Page Contains            ${cpv_id}
  Click Element                       xpath=//a[contains(@id,'${cpv_id1}')]
  Click Element                       xpath=.//*[@id='select']
  Unselect Frame
  Click Element                       xpath=//a[contains(@data-class, 'dkpp')][./text()='Визначити за довідником']
  Select Frame                        xpath=//iframe[contains(@src,'/js/classifications/dkpp/uk.htm?relation=true')]
  Input text                          id=search     ${dkpp_desc}
  Wait Until Page Contains            ${dkpp_id}
  Click Element                       xpath=//a[contains(@id,'${dkpp_id1}')]
  Click Element                       xpath=.//*[@id='select']
# Додати специфікацю кінець

  Unselect Frame
  Input text                          name=plan_date                      ${enquiry_end_date}
  Input text                          name=tender_enquiryPeriod_endDate   ${enquiry_end_date}
  Input text                          name=tender_tenderPeriod_endDate    ${end_date}

  Додати предмет    ${items[0]}   0
  Run Keyword if   '${mode}' == 'multi'   Додати багато предметів   items
  Unselect Frame

  Click Element                       xpath= //button[@value='publicate']
  Wait Until Page Contains            Тендер опубліковано    30

  ${tender_UAid}=   Get Text          xpath=//*/section[6]/table/tbody/tr[2]/td[2]
  ${Ids}=   Convert To String         ${tender_UAid}
  Run keyword if   '${mode}' == 'multi'   Set Multi Ids   ${tender_UAid}
  [return]  ${Ids}

Set Multi Ids
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[1]} ==  ${tender_UAid}
  ${id}=    Get Text   xpath=//*/section[6]/table/tbody/tr[1]/td[2]
  ${Ids}=   Create List    ${tender_UAid}   ${id}

Додати предмет
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  items
  ...      ${ARGUMENTS[1]} ==  ${INDEX}
  ${dkpp_desc1}=     Get From Dictionary   ${ARGUMENTS[0].additionalClassifications[0]}   description
  ${dkpp_id11}=      Get From Dictionary   ${ARGUMENTS[0].additionalClassifications[0]}   id
  ${dkpp_1id}=            Replace String   ${dkpp_id11}   -   _

  Wait Until Page Contains Element    xpath=//a[contains(@class, 'addMultiItem')][./text()='Додати предмет закупівлі']
  Click Element                       xpath=//a[contains(@class, 'addMultiItem')][./text()='Додати предмет закупівлі']
  ${index} =                          Convert To Integer     ${ARGUMENTS[1]}
  ${index} =                          Convert To Integer     ${index + 1}
  Wait Until Page Contains Element    name=items[${index}][item_description]   30
  Input text                          name=items[${index}][item_description]    ${description}
  Input text                          name=items[${index}][item_quantity]   ${quantity}

  Click Element                       xpath=(//a[contains(@data-class, 'cpv')][./text()='Визначити за довідником'])[${index} + 1]
  Select Frame                        xpath=//iframe[contains(@src,'/js/classifications/cpv/uk.htm?relation=true')]
  Input text                          id=search     ${cpv}
  Wait Until Page Contains            ${cpv_id}
  Click Element                       xpath=//a[contains(@id,'${cpv_id1}')]
  Click Element                       xpath=.//*[@id='select']
  Unselect Frame
  Click Element                       xpath=(//a[contains(@data-class, 'dkpp')][./text()='Визначити за довідником'])[${index} + 1]
  Select Frame                        xpath=//iframe[contains(@src,'/js/classifications/dkpp/uk.htm?relation=true')]
  Input text                          id=search     ${dkpp_desc1}
  Wait Until Page Contains            ${dkpp_id11}
  Click Element                       xpath=//a[contains(@id,'${dkpp_1id}')]
  Click Element                       xpath=.//*[@id='select']
  Unselect Frame
  Capture Page Screenshot

Додати багато предметів
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  items
  ${Items_length}=   Get Length   ${items}
  : FOR    ${INDEX}    IN RANGE    1    ${Items_length}
  \   Додати предмет   ${items[${INDEX}]}   ${INDEX}

додати предмети закупівлі
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} =  username
  ...      ${ARGUMENTS[1]} =  ${TENDER_UAID}
  ...      ${ARGUMENTS[2]} =  3
  ${period_interval}=  Get Broker Property By Username  ${ARGUMENTS[0]}  period_interval
  ${tender_data}=  prepare_test_tender_data  ${period_interval}  multi

  ${items}=         Get From Dictionary   ${tender_data.data}               items
  ${description}=   Get From Dictionary   ${tender_data.data}               description
  ${quantity}=      Get From Dictionary   ${items[0]}                       quantity
  ${cpv}=           Convert To String     Картонки
  ${cpv_id}=        Get From Dictionary   ${items[0].classification}         id
  ${cpv_id1}=       Replace String        ${cpv_id}   -   _
  ${dkpp_desc}=     Get From Dictionary   ${items[0].additionalClassifications[0]}   description
  ${dkpp_id}=       Get From Dictionary   ${items[0].additionalClassifications[0]}   id
  ${dkpp_id1}=      Replace String        ${dkpp_id}   -   _

  Selenium2Library.Switch Browser    ${ARGUMENTS[0]}
  Run keyword if   '${TEST NAME}' == 'Можливість додати позицію закупівлі в тендер'   додати позицію
  Run keyword if   '${TEST NAME}' != 'Можливість додати позицію закупівлі в тендер'   видалити позиції

додати позицію
  dzo.Пошук тендера по ідентифікатору   ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  Wait Until Page Contains Element           xpath=//a[./text()='Редагувати']   30
  Click Element                              xpath=//a[./text()='Редагувати']
  Додати багато предметів     ${ARGUMENTS[2]}
  Wait Until Page Contains Element           xpath=//button[./text()='Зберегти']   30
  Click Element                              xpath=//button[./text()='Зберегти']

видалити позиції
  dzo.Пошук тендера по ідентифікатору   ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  Wait Until Page Contains Element           xpath=//a[./text()='Редагувати']   30
  Click Element                              xpath=//a[./text()='Редагувати']
  : FOR    ${INDEX}    IN RANGE    1    ${ARGUMENTS[2]}-1
  \   sleep  5
  \   Click Element                          xpath=//a[@class='deleteMultiItem'][last()]
  \   sleep  5
  \   Click Element                          xpath=//a[@class='jBtn green']
  Wait Until Page Contains Element           xpath=//button[./text()='Зберегти']   30
  Click Element                              xpath=//button[./text()='Зберегти']

Пошук тендера по ідентифікатору
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  tenderId
  Switch browser   ${ARGUMENTS[0]}
  Go To  ${USERS.users['${ARGUMENTS[0]}'].homepage}
  Wait Until Page Contains            Держзакупівлі.онлайн   10
  Click Element                       xpath=//a[text()='Закупівлі']
  sleep  1
  Click Element                       xpath=//select[@name='filter[object]']/option[@value='tenderID']
  Input text                          xpath=//input[@name='filter[search]']  ${ARGUMENTS[1]}
  Click Element                       xpath=//button[@class='btn'][./text()='Пошук']
  Wait Until Page Contains            ${ARGUMENTS[1]}   10
  Capture Page Screenshot
  sleep  1
  Click Element                       xpath=//a[@class='reverse tenderLink']

Задати питання
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  tenderUaId
  ...      ${ARGUMENTS[2]} ==  questionId
  ${title}=        Get From Dictionary  ${ARGUMENTS[2].data}  title
  ${description}=  Get From Dictionary  ${ARGUMENTS[2].data}  description

  Selenium2Library.Switch Browser    ${ARGUMENTS[0]}
  dzo.Пошук тендера по ідентифікатору    ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  sleep  1
  Execute Javascript                  window.scroll(2500,2500)
  Wait Until Page Contains Element    xpath=//a[@class='reverse openCPart'][span[text()='Обговорення']]    20
  Click Element                       xpath=//a[@class='reverse openCPart'][span[text()='Обговорення']]
  Wait Until Page Contains Element    name=title    20
  Input text                          name=title                 ${title}
  Input text                          xpath=//textarea[@name='description']           ${description}
  Click Element                       xpath=//div[contains(@class, 'buttons')]//button[@type='submit']
  Wait Until Page Contains            ${title}   30
  Capture Page Screenshot

Відповісти на питання
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} = username
  ...      ${ARGUMENTS[1]} = tenderUaId
  ...      ${ARGUMENTS[2]} = 0
  ...      ${ARGUMENTS[3]} = answer_data

  ${answer}=     Get From Dictionary  ${ARGUMENTS[3].data}  answer
  Selenium2Library.Switch Browser     ${ARGUMENTS[0]}

  dzo.Пошук тендера по ідентифікатору   ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  Execute Javascript                  window.scroll(1500,1500)
  Wait Until Page Contains Element    xpath=//a[@class='reverse openCPart'][span[text()='Обговорення']]    20
  Click Element                       xpath=//a[@class='reverse openCPart'][span[text()='Обговорення']]
  Wait Until Page Contains Element    xpath=//textarea[@name='answer']    20
  Input text                          xpath=//textarea[@name='answer']            ${answer}
  Click Element                       xpath=//div[1]/div[3]/form/div/table/tbody/tr/td[2]/button
  Wait Until Page Contains            ${answer}   30
  Capture Page Screenshot

Подати скаргу
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} = username
  ...      ${ARGUMENTS[1]} = tenderUaId
  ...      ${ARGUMENTS[2]} = complaintsId
  ${complaint}=        Get From Dictionary  ${ARGUMENTS[2].data}  title
  ${description}=      Get From Dictionary  ${ARGUMENTS[2].data}  description

  Selenium2Library.Switch Browser    ${ARGUMENTS[0]}
  dzo.Пошук тендера по ідентифікатору   ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  sleep  1
  Execute Javascript                 window.scroll(1500,1500)
  Click Element                      xpath=//a[@class='reverse openCPart'][span[text()='Скарги']]
  Wait Until Page Contains Element   name=title    20
  Input text                         name=title                 ${complaint}
  Input text                         xpath=//textarea[@name='description']           ${description}
  Click Element                      xpath=//div[contains(@class, 'buttons')]//button[@type='submit']
  Wait Until Page Contains           ${complaint}   30
  Capture Page Screenshot

Порівняти скаргу
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} = username
  ...      ${ARGUMENTS[1]} = tenderUaId
  ...      ${ARGUMENTS[2]} = complaintsData
  ${complaint}=        Get From Dictionary  ${ARGUMENTS[2].data}  title
  ${description}=      Get From Dictionary  ${ARGUMENTS[2].data}  description

  Selenium2Library.Switch Browser    ${ARGUMENTS[0]}
  dzo.Пошук тендера по ідентифікатору   ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  sleep  1
  Execute Javascript                 window.scroll(1500,1500)
  Click Element                      xpath=//a[@class='reverse openCPart'][span[text()='Скарги']]
  Wait Until Page Contains           ${complaint}   30
  Capture Page Screenshot

Внести зміни в тендер
  #  Тест написано для уже існуючого тендеру, що знаходиться у чернетках користувача
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} = username
  ...      ${ARGUMENTS[1]} = description

  Selenium2Library.Switch Browser    ${ARGUMENTS[0]}
  Click Element                      xpath=//a[@class='reverse'][./text()='Мої закупівлі']
  Wait Until Page Contains Element   xpath=//a[@class='reverse'][./text()='Чернетки']   30
  Click Element                      xpath=//a[@class='reverse'][./text()='Чернетки']
  Wait Until Page Contains Element   xpath=//a[@class='reverse tenderLink']    30
  Click Element                      xpath=//a[@class='reverse tenderLink']
  sleep  1
  Click Element                      xpath=//a[@class='button save'][./text()='Редагувати']
  sleep  1
  Input text                         name=tender_title   ${ARGUMENTS[1]}
  sleep  1
  Click Element                      xpath=//button[@class='saveDraft']
  Wait Until Page Contains           ${ARGUMENTS[1]}   30
  Capture Page Screenshot

обновити сторінку з тендером
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} = username
  ...      ${ARGUMENTS[1]} = tenderUaId

  Selenium2Library.Switch Browser    ${ARGUMENTS[0]}
  dzo.Пошук тендера по ідентифікатору    ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  Reload Page



Отримати текст із поля і показати на сторінці
  [Arguments]   ${fieldname}
  sleep  1
  ${return_value}=   Get Text  ${locator.${fieldname}}
  [return]  ${return_value}

отримати інформацію про title
  ${title}=   Отримати текст із поля і показати на сторінці   title
  [return]  ${title.split('.')[0]}

отримати інформацію про description
  ${description}=   Отримати текст із поля і показати на сторінці   description
  [return]  ${description}

отримати інформацію про tenderId
  ${tenderId}=   Отримати текст із поля і показати на сторінці   tenderId
  [return]  ${tenderId}

отримати інформацію про value.amount
  ${valueAmount}=   Отримати текст із поля і показати на сторінці   value.amount
  ${valueAmount}=   Convert To Number   ${valueAmount.split(' ')[0]}
  [return]  ${valueAmount}

отримати інформацію про minimalStep.amount
  ${minimalStepAmount}=   Отримати текст із поля і показати на сторінці   minimalStep.amount
  ${minimalStepAmount}=   Convert To Number   ${minimalStepAmount.split(' ')[0]}
  [return]  ${minimalStepAmount}

отримати інформацію про enquiryPeriod.endDate
  ${enquiryPeriodEndDate}=   Отримати текст із поля і показати на сторінці   enquiryPeriod.endDate
  ${enquiryPeriodEndDate}=   subtract_from_time   ${enquiryPeriodEndDate}   6   5
  [return]  ${enquiryPeriodEndDate}

отримати інформацію про tenderPeriod.endDate
  ${tenderPeriodEndDate}=   Отримати текст із поля і показати на сторінці   tenderPeriod.endDate
  ${tenderPeriodEndDate}=   subtract_from_time    ${tenderPeriodEndDate}   11   0
  [return]  ${tenderPeriodEndDate}

отримати інформацію про items[0].deliveryAddress.countryName
  ${countryName}=   Отримати текст із поля і показати на сторінці   items[0].deliveryAddress.countryName
  [return]  ${countryName}

отримати інформацію про items[0].classification.scheme
  ${classificationScheme}=   Отримати текст із поля і показати на сторінці   items[0].classification.scheme
  [return]  ${classificationScheme.split(' ')[1]}

отримати інформацію про items[0].additionalClassifications[0].scheme
  ${additionalClassificationsScheme}=   Отримати текст із поля і показати на сторінці   items[0].additionalClassifications[0].scheme
  [return]  ${additionalClassificationsScheme.split(' ')[1]}

отримати інформацію про questions[0].title
  sleep  1
  Click Element                       xpath=//a[@class='reverse tenderLink']
  sleep  1
  Click Element                       xpath=//a[@class='reverse openCPart'][span[text()='Обговорення']]
  ${questionsTitle}=   Отримати текст із поля і показати на сторінці   questions[0].title
  ${questionsTitle}=   Convert To Lowercase   ${questionsTitle}
  [return]  ${questionsTitle.capitalize().split('.')[0] + '.'}

отримати інформацію про questions[0].description
  ${questionsDescription}=   Отримати текст із поля і показати на сторінці   questions[0].description
  [return]  ${questionsDescription}

отримати інформацію про questions[0].date
  ${questionsDate}=   Отримати текст із поля і показати на сторінці   questions[0].date
  log  ${questionsDate}
  [return]  ${questionsDate}

отримати інформацію про questions[0].answer
  sleep  1
  Click Element                       xpath=//a[@class='reverse tenderLink']
  sleep  1
  Click Element                       xpath=//a[@class='reverse openCPart'][span[text()='Обговорення']]
  ${questionsAnswer}=   Отримати текст із поля і показати на сторінці   questions[0].answer
  [return]  ${questionsAnswer}

отримати інформацію про items[0].deliveryDate.endDate
  ${deliveryDateEndDate}=   Отримати текст із поля і показати на сторінці   items[0].deliveryDate.endDate
  ${deliveryDateEndDate}=   subtract_from_time    ${deliveryDateEndDate}   15   0
  [return]  ${deliveryDateEndDate}

отримати інформацію про items[0].classification.id
  ${classificationId}=   Отримати текст із поля і показати на сторінці   items[0].classification.id
  [return]  ${classificationId}

отримати інформацію про items[0].classification.description
  ${classificationDescription}=   Отримати текст із поля і показати на сторінці     items[0].classification.description
  Run Keyword And Return If  '${classificationDescription}' == 'Картонки'    Convert To String  Cartons
  [return]  ${classificationDescription}

отримати інформацію про items[0].additionalClassifications[0].id
  ${additionalClassificationsId}=   Отримати текст із поля і показати на сторінці     items[0].additionalClassifications[0].id
  [return]  ${additionalClassificationsId}

отримати інформацію про items[0].additionalClassifications[0].description
  ${additionalClassificationsDescription}=   Отримати текст із поля і показати на сторінці     items[0].additionalClassifications[0].description
  ${additionalClassificationsDescription}=   Convert To Lowercase   ${additionalClassificationsDescription}
  [return]  ${additionalClassificationsDescription}

отримати інформацію про items[0].quantity
  ${itemsQuantity}=   Отримати текст із поля і показати на сторінці     items[0].quantity
  ${itemsQuantity}=   Convert To Integer    ${itemsQuantity}
  [return]  ${itemsQuantity}

отримати інформацію про items[0].unit.code
  ${unitCode}=   Отримати текст із поля і показати на сторінці     items[0].unit.code
  Run Keyword And Return If  '${unitCode}'== 'кг'   Convert To String  KGM
  [return]  ${unitCode}

отримати інформацію про procuringEntity.name
  Log       | Viewer can't see this information on DZO        console=yes

отримати інформацію про enquiryPeriod.startDate
  Log       | Viewer can't see this information on DZO        console=yes

отримати інформацію про tenderPeriod.startDate
  Log       | Viewer can't see this information on DZO        console=yes

отримати інформацію про items[0].deliveryLocation.longitude
  Log       | Viewer can't see this information on DZO        console=yes

отримати інформацію про items[0].deliveryLocation.latitude
  Log       | Viewer can't see this information on DZO        console=yes

отримати інформацію про items[0].deliveryAddress.postalCode
  Log       | Viewer can't see this information on DZO        console=yes

отримати інформацію про items[0].deliveryAddress.locality
  Log       | Viewer can't see this information on DZO        console=yes

отримати інформацію про items[0].deliveryAddress.streetAddress
  Log       | Viewer can't see this information on DZO        console=yes

отримати інформацію про items[0].deliveryAddress.region
  Log       | Viewer can't see this information on DZO        console=yes

отримати інформацію про items[0].unit.name
  Log       | Viewer can't see this information on DZO        console=yes


#####################################################################################

Підтвердити дію
  Клікнути по елементу  ${locator.ModalOK}
  Wait Until Element Is Not Visible  id=jAlertBack

Ввести текст
  [Arguments]  ${locator}  ${text}
  Wait Until Element Is Visible  ${locator}  20
  Input Text  ${locator}  ${text}

Клікнути по елементу
  [Arguments]  ${locator}
  Wait Until Element Is Visible  ${locator}  20
  Click Element  ${locator}

Wait And Click
  [Arguments]  ${locator}
  Wait Until Keyword Succeeds  5 x  1 s  Element Should Be Visible  ${locator}
  Scroll To Element  ${locator}
  Click Element  ${locator}

Wait And Input Text
  [Arguments]  ${locator}  ${text}
  Wait Until Keyword Succeeds  5 x  1 s  Element Should Be Visible  ${locator}
  Scroll To Element  ${locator}
  Input Text  ${locator}  ${text}

Wait And Select From List By Label
  [Arguments]  ${locator}  ${value}
  Wait Until Keyword Succeeds  10 x  1 s  Select From List By Label  ${locator}  ${value}

Input Date
  [Arguments]  ${elem_name_locator}  ${date}
  ${date}=  dzo_service.convert_date_to_slash_format  ${date}
  Scroll To Element  name=${elem_name_locator}
  Focus  name=${elem_name_locator}
  Execute Javascript  $("input[name|='${elem_name_locator}']").removeAttr('readonly'); $("input[name|='${elem_name_locator}']").unbind();
  Ввести текст  ${elem_name_locator}  ${date}

Scroll To Element
  [Arguments]  ${locator}
  Wait Until Page Contains Element  ${locator}  10
  ${elem_vert_pos}=  Get Vertical Position  ${locator}
  Execute Javascript  window.scrollTo(0,${elem_vert_pos - 300});

Wait Element Animation
  [Arguments]  ${locator}
  Set Test Variable  ${prev_vert_pos}  0
  Wait Until Keyword Succeeds  20 x  500 ms  Position Should Equals  ${locator}

Position Should Equals
  [Arguments]  ${locator}
  ${current_vert_pos}=  Get Vertical Position  ${locator}
  ${status}=  Run Keyword And Return Status  Should Be Equal  ${prev_vert_pos}  ${current_vert_pos}
  Set Test Variable  ${prev_vert_pos}  ${current_vert_pos}
  Should Be True  ${status}
