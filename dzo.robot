# -*- coding: utf-8 -*-

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


##################
${plan.view.status}=  xpath=//div[@class="statusName"]
${plan.view.tender.procurementMethodType}=  xpath=//td[text()="Тип процедури"]/following-sibling::td[1]
${plan.view.budget.description}=  xpath=//div[@class="topInfo"]/h1
${plan.view.budget.currency}=  xpath=//td[text()="Очікувана вартість"]/following-sibling::td[1]/span[2]
${plan.view.procuringEntity.name}=  xpath=(//td[text()="Найменування організації"])[1]/following-sibling::td[1]
${plan.view.procuringEntity.identifier.id}=  xpath=(//td[text()="Код в ЄДРПОУ / ІПН"])[1]/following-sibling::td[1]
${plan.view.procuringEntity.identifier.scheme}=  xpath=(//td[text()="Код в ЄДРПОУ / ІПН"])[1]
${plan.view.procuringEntity.identifier.legalName}=  xpath=(//td[text()="Найменування організації"])[1]/following-sibling::td[1]
${plan.view.classification.description}=  xpath=//td[text()="Класифікація за ДК 021-2015 (CPV)"]/following-sibling::td[1]/span[2]
${plan.view.classification.scheme}=  xpath=//td[text()="Класифікація за ДК 021-2015 (CPV)"]
${plan.view.classification.id}=  xpath=//td[text()="Класифікація за ДК 021-2015 (CPV)"]/following-sibling::td[1]/span[1]

${tender.view.items.description}=  xpath=//td[contains(text(),"Опис окремої частини")]/following-sibling::td[1]
${tender.view.items.quantity}=  xpath=//td[contains(text(),"Кількість")]/following-sibling::td[1]/span[1]
${tender.view.items.deliveryDate.endDate}=  xpath=//td[contains(text(),"Кінцевий строк поставки")]/following-sibling::td[1]
${tender.view.items.unit.code}=  xpath=//td[contains(text(),"Кількість")]/following-sibling::td[1]/span[2]
${tender.view.items.unit.name}=  xpath=//td[contains(text(),"Кількість")]/following-sibling::td[1]/span[2]
${tender.view.items.classification.description}=  xpath=//td[contains(text(),"Класифікація за ДК 021")]/following-sibling::td[1]/span[2]
${tender.view.items.classification.scheme}=  xpath=//td[contains(text(),"Класифікація за ДК 021")]
${tender.view.items.classification.id}=  xpath=//td[contains(text(),"Класифікація за ДК 021")]/following-sibling::td[1]/span[1]

${tender.view.budget.amount}=  xpath=//td[text()="Очікувана вартість"]/following-sibling::td[1]/span
${plan.edit.budget.description}=  xpath=//input[@name="data[budget][description]"]
${plan.edit.budget.amount}=  xpath=//input[@name="data[budget][amount]"]
${plan.edit.items[0].deliveryDate.endDate}=  data[items][0][deliveryDate][endDate]
${plan.edit.items[0].quantity}=  xpath=//input[@name="data[items][0][quantity]"]
${plan.edit.budget.period}=  data[tender][tenderPeriod][startDate]

${milestone_index}
${tender.view.milestones.code}=  xpath=//h3[contains(text(),"Умови оплати")]/../descendant::div[${milestone_index}]/descendant::td[text()="Тип оплати"]/following-sibling::td
${tender.view.milestones.title}=  xpath=//h3[contains(text(),"Умови оплати")]/../descendant::div[${milestone_index}]/descendant::td[text()="Подія"]/following-sibling::td
${tender.view.milestones.percentage}=  xpath=//h3[contains(text(),"Умови оплати")]/../descendant::div[${milestone_index}]/descendant::td[contains(text(),"Розмір оплати")]/following-sibling::td
${tender.view.milestones.duration.days}=  xpath=//h3[contains(text(),"Умови оплати")]/../descendant::div[${milestone_index}]/descendant::td[text()="Період"]/following-sibling::td/span[1]
${tender.view.milestones.duration.type}=  xpath=//h3[contains(text(),"Умови оплати")]/../descendant::div[${milestone_index}]/descendant::td[text()="Період"]/following-sibling::td/span[2]
${tender.view.value.amount}=  xpath=//span[@class="value js-pricedecor"]
${tender.view.enquiryPeriod.startDate}=  xpath=//span[contains(text(),"Процедура закупівлі оголошена")]/following-sibling::span[1]
${tender.view.enquiryPeriod.endDate}=  xpath=//td[contains(text(),"Завершення періоду уточнень")]/following-sibling::td[1]
${tender.view.tenderPeriod.startDate}=  xpath=//td[contains(text(),"Початок періоду прийому пропозицій")]/following-sibling::td[1]
${tender.view.tenderPeriod.endDate}=  xpath=//td[contains(text(),"Кінцевий строк подання тендерних пропозицій")]/following-sibling::td[1]
${tender.view.status}=  xpath=(//div[@class="statusItem active"]/descendant::div[@class="statusName"])[last()]
${tender.view.title}=  xpath=//h1[@class="t_title"]/span
${tender.view.description}=  xpath=//h2[@class='tenderDescr']
${tender.view.mainProcurementCategory}=  xpath=//td[text()="Вид предмету закупівлі"]/following-sibling::td[1]
${tender.view.value.currency}=  xpath=//span[@class="price"]/span[@class="small"][2]/span[1]
${tender.view.value.valueAddedTaxIncluded}=  xpath=//span[@class="taxIncluded"]/span
${tender.view.tenderID}=  xpath=//span[@class="js-apiID"]
${tender.view.procuringEntity.name}=  xpath=//td[text()="Найменування організації"]/following-sibling::td/span
${tender.view.minimalStep.amount}=  xpath=//td[contains(text(),'Розмір мінімального кроку')]/following-sibling::td/span[1]

${tender.edit.description}=  xpath=//input[@name="data[description]"]
${tender.edit.tenderPeriod.endDate}=  xpath=//input[@name="data[tenderPeriod][endDate]"]


${locator.items.description}  /td[2]/div[1]
${locator.items.deliveryAddress.countryName}  /descendant::span[contains(text(), "Місце поставки ")]/following-sibling::span
${locator.items.deliveryAddress.postalCode}  /descendant::span[contains(text(), "Місце поставки ")]/following-sibling::span
${locator.items.deliveryAddress.locality}  /descendant::span[contains(text(), "Місце поставки ")]/following-sibling::span
${locator.items.deliveryAddress.streetAddress}  /descendant::span[contains(text(), "Місце поставки ")]/following-sibling::span
${locator.items.deliveryAddress.region}  /descendant::span[contains(text(), "Місце поставки ")]/following-sibling::span
${locator.items.classification.scheme}  /td[2]/div[2]/span[1]
${locator.items.classification.id}  /td[2]/div[2]/span[2]
${locator.items.classification.description}  /td[2]/div[2]/span[3]
${locator.items.quantity}  /td[3]/div/span[2]
${locator.items.unit.code}  /td[3]/div/span[3]
${locator.items.unit.name}  /td[3]/div/span[3]

${locator.questions.title}
${locator.questions.description}  /following-sibling::div[@class="text"]
${locator.questions.date}  /preceding-sibling::div[@class="date"]
${locator.questions.answer}  /../following-sibling::div[@class="answer relative"]/div[@class="text"]

${locator.ModalOK}=  xpath=//a[@data-msg="jAlert OK"]

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
  Wait And Click  xpath=//div[@class="authBtn"]/a
  Ввести текст  name=email  ${USERS.users['${username}'].login}
  Execute Javascript  $('input[name="email"]').attr('rel','CHANGE');
  Ввести текст  name=psw  ${USERS.users['${username}'].password}
  Wait And Click  xpath=//button[contains(@class, 'btn')][./text()='Вхід']

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
  ${tender_start_date}=  convert_datetime_to_format  ${plan_data.data.tender.tenderPeriod.startDate}  %d/%m/%Y
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
  Click Element  xpath=//input[@name="procuringEntity[manual]"]/..
  Clear Element Text  xpath=//input[@name="data[procuringEntity][name]"]
  Input Text  xpath=//input[@name="data[procuringEntity][name]"]  ${plan_data.data.procuringEntity.name}
  Clear Element Text  xpath=//input[@name="data[procuringEntity][identifier][id]"]
  Input Text  xpath=//input[@name="data[procuringEntity][identifier][id]"]  ${plan_data.data.procuringEntity.identifier.id}
  Wait And Input Text  xpath=//input[@name="data[budget][description]"]  ${plan_data.data.budget.description}

  :FOR  ${index}  IN RANGE  ${items_length}
  \  Add Plan Item  ${items[${index}]}  ${index}

  Click Element  xpath=//section[@id="multiBreakdowns"]/a
  :FOR  ${index}  IN RANGE  ${breakdowns_length}
  \  Add Plan Breakdown  ${plan_data.data.budget.breakdown}  ${index}

  Input Date  data[tender][tenderPeriod][startDate]  ${tender_start_date}
  Click Element  xpath=//section[contains(@class, "datesBlock")]
  Wait Until Element Is Not Visible  xpath=//div[@id="ui-datepicker-div"]
  Wait And Click  xpath=//button[@value="publicate"]
  Wait And Click  xpath=//a[contains(@class, "tenderSignCommand")]
  Select Window  NEW
  Wait And Click  xpath=//a[@class="js-oldPageLink"]
  ${status}=  Run Keyword And Return Status  Wait Until Keyword Succeeds  30 x  1 s  Page Should Contain  Оберіть файл з особистим ключем (зазвичай з ім'ям Key-6.dat) та вкажіть пароль захисту
  Run Keyword If  ${status}  Wait Until Keyword Succeeds  30 x  20 s  Run Keywords
  ...  Wait And Select From List By Label  id=CAsServersSelect  Тестовий ЦСК АТ "ІІТ"
  ...  AND  Execute Javascript  var element = document.getElementById('PKeyFileInput'); element.style.visibility="visible";
  ...  AND  Choose File  id=PKeyFileInput  ${CURDIR}/Key-6.dat
  ...  AND  Input text  id=PKeyPassword  12345677
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
  Підтвердити дію

  [Return]  ${plan_uaid}

Add Plan Item
  [Arguments]  ${item}  ${index}
  ${quantity}=  add_second_sign_after_point  ${item.quantity}
  ${unit_id}=  convert_unit_id  ${item.unit.code}
  ${delivery_end_date}=  convert_datetime_to_format  ${item.deliveryDate.endDate}  %d/%m/%Y
  Wait And Click  xpath=//section[@id="multiItems"]/descendant::a[@class="addMultiItem"]
  Wait And Input Text  xpath=//input[@name="data[items][${index}][description]"]  ${item.description}
  Input Text  xpath=//input[@name="data[items][${index}][quantity]"]  ${quantity}
  Select From List By Value  xpath=//select[@name="data[items][${index}][unit_id]"]  ${unit_id}
  Click Element  xpath=//div[contains(@class, "tenderItemPositionElement")][@data-multiline="${index}"]/descendant::a[@data-class="ДК021"]
  Select CPV  ${item.classification.id}
  Input Date  data[items][${index}][deliveryDate][endDate]  ${delivery_end_date}

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
  Switch Browser  ${username}
  ${value}=  Run Keyword And Return If  "amount" in "${fieldname}" or "quantity" in "${fieldname}"  Convert To String  ${fieldvalue}
  ${fieldvalue}=  Set Variable If  ${value}  ${value}  ${fieldvalue}
  Wait And Click  xpath=//a[@class="button save"]
  Run Keyword If  "date" in "${fieldname}"  Input Date  ${plan.edit.${fieldname}}  ${fieldvalue}
  ...  ELSE IF  "period" in "${fieldname}"  Select From List By Value  data[budget][period][endDate]  ${fieldvalue["endDate"].split("-")[0]}
  ...  ELSE  Input Text  ${plan.edit.${fieldname}}  ${fieldvalue}
  Wait And Click  xpath=//button[@name="do"]

Додати предмет закупівлі в план
  [Arguments]  ${username}  ${tender_uaid}  ${item}
  Switch Browser  ${username}
  Wait And Click  xpath=//a[@class="button save"]
  ${index}=  Get Matching Xpath Count  xpath=//div[@class="tenderItemElement tenderItemPositionElement"]
  ${index}=  Convert To Integer  ${index}
  Add Plan Item  ${item}  ${index - 1}
  Wait And Click  xpath=//button[@name="do"]

Видалити предмет закупівлі плану
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${lot_id}=${Empty}
  Switch Browser  ${username}
  Wait And Click  xpath=//a[@class="button save"]
  Wait And Click  xpath=//input[contains(@value, "${item_id}")]/ancestor::div[contains(@class, "tenderItemElement")]/descendant::a[@class="deleteMultiItem"]
  Підтвердити дію
  Wait And Click  xpath=//button[@name="do"]

Оновити сторінку з планом
  [Arguments]  ${username}  ${plan_uaid}
  Reload Page

Пошук плану по ідентифікатору
  [Arguments]  ${username}  ${plan_uaid}
  Switch Browser  ${username}
#  ${url}=  Set Variable If  'Viewer' in '${username}'  http://www.dzo.byustudio.in.ua/tenders/plans?test_mode=0  http://www.dzo.byustudio.in.ua/tenders/plans
  Go To  http://www.dzo.byustudio.in.ua/tenders/plans
  Select From List By Value  xpath=//select[@name="filter[object]"]  planID
  Input Text  xpath=//input[@name="filter[search]"]  ${plan_uaid}
  Click Element  xpath=//button[contains(@class,"not_toExtend")]
  Wait Until Keyword Succeeds  10 x  1 s  Locator Should Match X Times  xpath=//section[contains(@class,"list")]/descendant::div[contains(@class, "item")]  1
  Click Element  xpath=//a[contains(@class, "tenderLink")]

###############################################################################################################
#########################################    ВІДОБРАЖЕННЯ    ##################################################
###############################################################################################################

Отримати інформацію із плану
  [Arguments]  ${username}  ${plan_uaid}  ${field_name}
  Switch Browser  ${username}
  ${text}=  Run Keyword If  "item" in "${field_name}"  Get From Item  ${field_name}
  ...  ELSE  Get Text  ${plan.view.${field_name}}
  ${value}=  convert_dzo_data  ${text}  ${field_name}
  [Return]  ${value}

Отримати інформацію із тендера
  [Arguments]  ${username}  ${tender_uaid}  ${field_name}
  Switch Browser  ${username}
  ${text}=  Run Keyword If
  ...  "value.amount" in "${field_name}"  Get Amount
  ...  ELSE IF  "milestones" in "${field_name}"  Get From Milestone  ${field_name}
  ...  ELSE IF  "item" in "${field_name}"  Get From Item  ${field_name}
  ...  ELSE  Get Text  ${tender.view.${field_name}}
  ${value}=  convert_dzo_data  ${text}  ${field_name}
#  ${value}=  Set Variable If  "amount" in "${field_name}"  ${value.replace("`", "")}  ${value}
  [Return]  ${value}

Get Amount
  ${integer}=  Get Text  xpath=//span[@class="value js-pricedecor"]
  ${fractional}=  Get Text  xpath=//span[@class="value js-pricedecor"]/following-sibling::span[1]
  [Return]  ${integer}.${fractional}

Get From Milestone
  [Arguments]  ${field_name}
  ${match}=  Get Regexp Matches  ${field_name}  \\[(\\d+)\\]  1
  ${milestone_index}=  Convert To Integer  ${match[0]}
  ${milestone_index}=  Set Variable  ${milestone_index + 1}
  ${field_name}=  Remove String Using Regexp  ${field_name}  \\[(\\d+)\\]
  ${value}=  Get Text  ${tender.view.${field_name}}
  ${value}=  Run Keyword If  "percentage" in "${field_name}"  Convert To Number  ${value.replace("%", "")}
  ...  ELSE  Set Variable  ${value}
  [Return]  ${value}

Get From Item
  [Arguments]  ${field_name}
  ${match}=  Get Regexp Matches  ${field_name}  \\[(\\d+)\\]  1
  ${item_index}=  Convert To Integer  ${match[0]}
  ${item_index}=  Set Variable  ${item_index + 1}
  ${field_name}=  Remove String Using Regexp  ${field_name}  \\[(\\d+)\\]
  ${value}=  Get Text  ${tender.view.${field_name}}
  [Return]  ${value}

Отримати інформацію із предмету
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${field_name}
  Switch Browser  ${username}
  ${item_value}=  Get Text  xpath=//div[contains(text(), '${item_id}')]/ancestor::tr[contains(@class,"tenderFullListElement")]${locator.items.${field_name}}
  ${item_value}=  adapt_items_data  ${field_name}  ${item_value}
  [Return]  ${item_value}

Отримати інформацію із запитання
  [Arguments]  ${username}  ${tender_uaid}  ${question_id}  ${field_name}
  Switch Browser  ${username}
  Reload Page
  Wait And Click  xpath=//section[@class="content"]/descendant::a[contains(@href, 'questions')]
  Wait Until Element Is Visible  xpath=//div[@id='questions']
  Wait Until Keyword Succeeds  15 x  20 s  Дочекатися відображення запитання на сторінці  ${question_id}
  ${question_value}=  Get Text  xpath=//div[contains(text(),'${question_id}')]${locator.questions.${field_name}}
  [Return]  ${question_value}

Дочекатися відображення запитання на сторінці
  [Arguments]  ${text_for_view}
  Reload Page
  Wait Until Page Contains  ${text_for_view}

Отримати інформацію із документа
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}  ${field}
  Wait Until Element Is Visible   xpath=//*[contains(text(),'${doc_id}')]
  ${value}=   Get Text   xpath=//*[contains(text(),'${doc_id}')]
  [Return]  ${value.split('/')[-1]}

Отримати документ
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}
  Execute Javascript   $(".topFixed").remove(); $(".bottomFixed").remove();
  ${file_name}=   Get Text   xpath=//span[contains(text(),'${doc_id}')]
  ${url}=   Get Element Attribute   xpath=//span[contains(text(),'${doc_id}')]/..@href
  dzo_download_file   ${url}  ${file_name.split('/')[-1]}  ${OUTPUT_DIR}
  [Return] ${file_name.split('/')[-1]}

###############################################################################################################
###################################    СТВОРЕННЯ ТЕНДЕРУ    ###################################################
###############################################################################################################

Створити тендер
  [Arguments]  ${username}  ${tender_data}  ${plan_uaid}
  Switch Browser  ${username}
  ${amount}=  add_second_sign_after_point  ${tender_data.data.value.amount}
  ${minimal_step_amount}=  add_second_sign_after_point  ${tender_data.data.minimalStep.amount}
  ${valueAddedTaxIncluded}=  Set Variable If  ${tender_data.data.value.valueAddedTaxIncluded}  true  false
  ${enquiry_end_date}=  convert_datetime_to_format  ${tender_data.data.enquiryPeriod.endDate}  %d/%m/%Y %H:%M
  ${tender_end_date}=  convert_datetime_to_format  ${tender_data.data.tenderPeriod.endDate}  %d/%m/%Y %H:%M
  ${milestones_length}=  Get Length  ${tender_data.data.milestones}
  ${items}=  Get From Dictionary  ${tender_data.data}  items
  ${items_length}=  Get Length  ${items}
  ${procurementMethodType}=  Set Variable If  ${tender_data.data.has_key("procurementMethodType")}  ${tender_data.data.procurementMethodType}  open_belowThreshold
  ${file_path}=  Get Variable Value  ${ARTIFACT_FILE}  artifact_plan.yaml
  ${artifact}=  load_data_from  ${file_path}
  ${plan_id}=  Set Variable  ${artifact.tender_uaid}
  dzo.Пошук плану по ідентифікатору  ${username}  ${plan_id}

  Wait And Click  xpath=//a[contains(@href,"/tenders/new")]
  Input Text  xpath=//input[@name="data[minimalStep][amount]"]  ${minimal_step_amount}
  Select From List By Value  xpath=//select[@name="data[mainProcurementCategory]"]  ${tender_data.data.mainProcurementCategory}
  Input Text  xpath=//input[@name="data[title]"]  ${tender_data.data.title}
  Input Text  xpath=//input[@name="data[description]"]  ${tender_data.data.description}
  Input Text  xpath=//input[@name="data[value][amount]"]  ${amount}
  Select From List By Value  xpath=//select[@name="data[value][valueAddedTaxIncluded]"]  ${valueAddedTaxIncluded}

#  Input Text  name=data[budget][amount]  ${amount}
#  Select From List By Value  name=data[budget][currency]  ${tender_data.data.budget.breakdown[0].value.currency}
#  Wait And Click  xpath=//a[@data-class="ДК021"]
#  Select CPV  ${tender_data.data.classification.id}
#  Wait And Input Text  xpath=//input[@name="data[budget][description]"]  ${tender_data.data.budget.description}

  Wait And Click  xpath=//section[contains(@id, "multiItems")]/a
  :FOR  ${index}  IN RANGE  ${items_length}
  \  Run Keyword If  ${index} != 0  Click Element  xpath=//section[contains(@id, "multiItems")]/descendant::a[@class="addMultiItem"]
  \  Add Tender Item  ${items[${index}]}  ${index}

  Wait And Click  xpath=//section[contains(@id, "multiMilestones")]/a
  :FOR  ${index}  IN RANGE  ${milestones_length}
  \  Wait And Click  xpath=//section[contains(@id, "multiMilestones")]/descendant::a[@class="addMultiItem"]
  \  Add Milestone  ${tender_data.data.milestones[${index}]}  ${index}

  Input Date  data[enquiryPeriod][endDate]  ${enquiry_end_date.split(" ")[0]}
  Input Date  enquiryPeriod_time  ${enquiry_end_date.split(" ")[1]}
  Input Date  data[tenderPeriod][endDate]  ${tender_end_date.split(" ")[0]}
  Input Date  tenderPeriod_time  ${tender_end_date.split(" ")[1]}
  Click Element  xpath=//select[@name="tender_enquiry_timeout"]
  Wait Until Element Is Not Visible  xpath=//div[@id="ui-datepicker-div"]
  Wait And Click  xpath=//button[@value="publicate"]
  Wait Until Page Contains Element  xpath=//span[@class="js-apiID"]
  ${tender_uaid}=  Get Text  xpath=//span[@class="js-apiID"]
  [Return]  ${tender_uaid}

Add Tender Item
  [Arguments]  ${item}  ${index}
  ${quantity}=  add_second_sign_after_point  ${item.quantity}
  ${unit_id}=  convert_unit_id  ${item.unit.code}
  ${delivery_end_date}=  convert_datetime_to_format  ${item.deliveryDate.endDate}  %d/%m/%Y
  Wait And Input Text  xpath=//input[@name="data[items][${index}][description]"]  ${item.description}
  Input Text  xpath=//input[@name="data[items][${index}][quantity]"]  ${quantity}
  Select From List By Value  xpath=//select[@name="data[items][${index}][unit_id]"]  ${unit_id}
  Click Element  xpath=//div[contains(@class, "tenderItemPositionElement")][@data-multiline="${index}"]/descendant::a[@data-class="ДК021"]
  Select CPV  ${item.classification.id}
  Run Keyword And Ignore Error  Run Keywords
  ...  Wait Until Page Contains Element  xpath=//a[@data-msg="jAlert Close"]
  ...  AND  Click Element  xpath=//a[@data-msg="jAlert Close"]
  ...  AND  Wait Until Page Does Not Contain Element  xpath=//a[@data-msg="jAlert Close"]
  Input Date  data[items][${index}][deliveryDate][endDate]  ${delivery_end_date}
  Select From List By Value  xpath=//select[@name="data[items][${index}][country_id]"]  461
  Select From List By Label  xpath=//select[@name="data[items][${index}][region_id]"]  ${item.deliveryAddress.region}
  Input Text  xpath=//input[@name="data[items][${index}][deliveryAddress][locality]"]  ${item.deliveryAddress.locality}
  Input Text  xpath=//input[@name="data[items][${index}][deliveryAddress][streetAddress]"]  ${item.deliveryAddress.streetAddress}
  Input Text  xpath=//input[@name="data[items][${index}][deliveryAddress][postalCode]"]  ${item.deliveryAddress.postalCode}
  Run Keyword And Ignore Error  Run Keywords
  ...  Click Element  xpath=//a[@data-msg="jAlert Close"]
  ...  AND  Wait Until Page Does Not Contain Element  xpath=//a[@data-msg="jAlert Close"]
  Wait Until Element Is Not Visible  xpath=//*[@id="jAlertBack"]
  Click Element  xpath=//input[@name="data[items][${index}][deliveryAddress][postalCode]"]
  Wait Until Element Is Not Visible  xpath=//div[@id="ui-datepicker-div"]

Add Milestone
  [Arguments]  ${milestone}  ${index}
  Select From List By Value  xpath=//select[@name="data[milestones][${index}][title]"]  ${milestone.title}
  Run Keyword If  ${milestone.has_key("description")}  Input Text  xpath=//input[@name="data[milestones][${index}][description]"]  ${milestone.description}
  Select From List By Value  xpath=//select[@name="data[milestones][${index}][code]"]  ${milestone.code}
  Input Text  xpath=//input[@name="data[milestones][${index}][percentage]"]  ${milestone.percentage}
  Input Text  xpath=//input[@name="data[milestones][${index}][duration][days]"]  ${milestone.duration.days}
  Select From List By Value  xpath=//select[@name="data[milestones][${index}][duration][type]"]  ${milestone.duration.type}

Пошук тендера по ідентифікатору
  [Arguments]  ${username}  ${tender_uaid}
  Switch Browser  ${username}
  Go To  http://www.dzo.byustudio.in.ua/tenders/public
  Select From List By Value  xpath=//select[@name="filter[object]"]  tenderID
  Input Text  xpath=//input[@name="filter[search]"]  ${tender_uaid}
  Click Element  xpath=(//button[text()="Пошук"])[1]
  Wait Until Keyword Succeeds  10 x  1 s  Locator Should Match X Times  xpath=//section[contains(@class,"list")]/descendant::div[contains(@class, "item")]/a[contains(@href,"/tenders/")]  1
  Click Element  xpath=//a[contains(@class, "tenderLink")]

Оновити сторінку з тендером
  [Arguments]  ${username}  ${tender_uaid}
  Switch Browser  ${username}
  Reload Page


###############################################################################################################
###################################    РЕДАГУВАННЯ ТЕНДЕРУ    #################################################
###############################################################################################################

Внести зміни в тендер
  [Arguments]  ${username}  ${tender_uaid}  ${fieldname}  ${fieldvalue}
  Switch Browser  ${username}
  Reload Page
  Wait And Click  xpath=//section[@class="content"]/descendant::a[contains(text(), 'Процедура закупівлі')]
  Wait And Click  xpath=//a[contains(@class, "save")]
  Run Keyword If  "Date" in "${fieldname}"  Input Tender Period End Date  ${fieldvalue}
  ...  ELSE  Input Text  ${tender.edit.${fieldname}}  ${fieldvalue}
  Wait And Click  xpath=//button[@value="save"]

Input Tender Period End Date
  [Arguments]  ${value}
  ${tender_end_date}=  convert_datetime_to_format  ${value}  %d/%m/%Y %H:%M
  Input Date  data[tenderPeriod][endDate]  ${tender_end_date.split(" ")[0]}
  Input Date  tenderPeriod_time  ${tender_end_date.split(" ")[1]}

Завантажити документ
  [Arguments]  ${username}  ${filepath}  ${tender_uaid}
  Switch Browser  ${username}
  Wait And Click  xpath=//a[contains(@class, "save")]
  Wait And Click  xpath=//section[contains(@class, "documentsList") and contains(@class, "multiBlock")]/a
  Choose File  xpath=//div[1]/form/input[@name="upload"]  ${filepath}
  Wait And Select From List By Value  xpath=(//*[@class='js-documentType'])[last()]  biddingDocuments
  Wait And Click  xpath=//button[@value="save"]
  # Сліп необхідний для корректної роботи з загруженим файлом користувачами Квінти, оскільки завантаження фалу у ЦБД може сягати 3-4 хвилин.
  Sleep  180

###############################################################################################################
##########################################    ЗАПИТАННЯ    ####################################################
###############################################################################################################

Задати запитання на тендер
  [Arguments]  ${username}  ${tender_uaid}  ${question}
  Wait And Click  xpath=//section[@class="content"]/descendant::a[contains(@href, 'questions')]
#  Execute Javascript   $(".topFixed").remove(); $(".bottomFixed").remove();
  Wait And Input Text  xpath=//form[@id="question_form"]/descendant::input[@name="title"]  ${question.data.title}
  Wait And Input Text  xpath=//form[@id="question_form"]/descendant::textarea[@name="description"]  ${question.data.description}
  Wait And Click  xpath=//button[contains(text(), 'Надіслати запитання')]
  Wait And Click  xpath=//a[@data-msg="jAlert Close"]

Відповісти на запитання
  [Arguments]  ${username}  ${tender_uaid}  ${answer_data}  ${question_id}
  Switch Browser  ${username}
  Reload Page
  Wait And Click  xpath=//section[@class="content"]/descendant::a[contains(@href, 'questions')]
  Wait And Input Text  xpath=//div[contains(text(),'${question_id}')]/../following-sibling::div/descendant::textarea[@name="answer"]  ${answer_data.data.answer}
  Wait And Click  xpath=//button[contains(text(), 'Опублікувати відповідь')]

###############################################################################################################
#########################################    ПРОПОЗИЦІЇ    ####################################################
###############################################################################################################

Подати цінову пропозицію
  [Arguments]   ${username}  ${tender_uaid}  ${bid}
  ${amount}=   add_second_sign_after_point   ${bid.data.value.amount}
#  ${status}=   Get From Dictionary   ${bid['data']}   qualified
#  ${qualified}=   Set Variable If   ${status}   ${EMPTY}   &bad=1
#  ${filePath}=   get_upload_file_path
#  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
#  ${bid_status}=   Run Keyword And Return Status   Element Should Not Be Visible   xpath=//div[@class="priceFormated"]
#  Run keyword if   ${bid_status}   Click Element  xpath=//a[contains(@class,'bidToEdit')]
#  Execute Javascript   $(".topFixed").remove(); $(".bottomFixed").remove();
#  ${status_doc_upload}=   Run Keyword And Return Status   Element Should Not Be Visible   xpath=//select[@class="documents_url"]
#  Run Keyword If   ${status_doc_upload}   Run Keywords
#  ...   Run Keyword And Ignore Error   Click Element   xpath=//a[@class="uploadFile"]
#  ...   AND   Choose File   xpath=/html/body/div[1]/form/input   ${filePath}
#  ...   AND   Wait Until Element Is Visible   xpath=//select[@class="documents_url"]
#  ...   AND   Run Keyword And Ignore Error   Select From List By Value   xpath=//select[@class="documents_url"]   financialLicense
#  Clear Element Text   name=data[value][amount]
  Wait And Input Text  name=data[value][amount]   ${amount}
  Wait And Click  name=do
  Wait And Click  xpath=//a[./text()= 'Закрити']
  Wait Element Animation  xpath=//a[./text()= 'Закрити']
  Wait And Click  xpath=//button[@name="pay"]
  Підтвердити дію
  [Return]  ${bid}


#####################################################################################

Підтвердити дію
  Wait And Click  ${locator.ModalOK}
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
  Wait Until Keyword Succeeds  5 x  1 s  Run Keywords
  ...  Scroll To Element  ${locator}
  ...  AND  Element Should Be Visible  ${locator}
  Scroll To Element  ${locator}
  Input Text  ${locator}  ${text}

Wait And Select From List By Label
  [Arguments]  ${locator}  ${value}
  Wait Until Keyword Succeeds  10 x  1 s  Select From List By Label  ${locator}  ${value}

Wait And Select From List By Value
  [Arguments]  ${locator}  ${value}
  Wait Until Keyword Succeeds  10 x  1 s  Select From List By Value  ${locator}  ${value}

Input Date
  [Arguments]  ${elem_name_locator}  ${date}
#  ${date}=  dzo_service.convert_date_to_slash_format  ${date}
  Scroll To Element  ${elem_name_locator}
  Execute Javascript  document.querySelector('[name="${elem_name_locator}"]').value="${date}"

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
