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
${internal_id}

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
#${tender.view.items.quantity}=  xpath=//td[contains(text(),"Кількість")]/following-sibling::td[1]/span[1]
${tender.view.items.quantity}=  xpath=//td[3]/div/span[2]
${tender.view.items.deliveryDate.endDate}=  xpath=//*[contains(text(),"Кінцевий строк поставки")]/../following-sibling::span[2]
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

${tender.edit.lot.value.amount}  xpath=//input[@name="data[lots][0][value][amount]"]
${tender.edit.lot.description}  xpath=//input[@name="data[lots][0][description]"]
${tender.edit.lot.minimalStep.amount}  xpath=//input[@name="data[lots][0][minimalStep][amount]"]
${tender.edit.maxAwardsCount}  xpath=//input[@name="data[maxAwardsCount]"]
${tender.edit.items[0].quantity}  xpath=//input[@name="data[items][0][quantity]"]

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
${tender.view.procurementMethodType}=  xpath=//td[contains(text(),"Процедура закупівлі")]/following-sibling::td[1]
${tender.view.title}=  xpath=//h1[@class="t_title"]/span
${tender.view.description}=  xpath=//h2[@class='tenderDescr']
${tender.view.mainProcurementCategory}=  xpath=//td[text()="Вид предмету закупівлі"]/following-sibling::td[1]
${tender.view.value.currency}=  xpath=//span[@class="price"]/span[@class="small"][2]/span[1]
${tender.view.value.valueAddedTaxIncluded}=  xpath=//span[@class="taxIncluded"]/span
${tender.view.tenderID}=  xpath=//span[@class="js-apiID"]
#${tender.view.procuringEntity.name}=  xpath=//td[text()="Найменування організації"]/following-sibling::td/span
${tender.view.procuringEntity.name}=  xpath=//section[contains(@class,"orgInfo")]/descendant::td[text()="Найменування організації"]/following-sibling::td[1]
${tender.view.procuringEntity.address.countryName}=  xpath=//section[contains(@class,"orgInfo")]/descendant::td[text()="Юридична адреса"]/following-sibling::td[1]
${tender.view.procuringEntity.address.locality}=  xpath=//section[contains(@class,"orgInfo")]/descendant::td[text()="Юридична адреса"]/following-sibling::td[1]
${tender.view.procuringEntity.address.postalCode}=  xpath=//section[contains(@class,"orgInfo")]/descendant::td[text()="Юридична адреса"]/following-sibling::td[1]
${tender.view.procuringEntity.address.region}=  xpath=//section[contains(@class,"orgInfo")]/descendant::td[text()="Юридична адреса"]/following-sibling::td[1]
${tender.view.procuringEntity.address.streetAddress}=  xpath=//section[contains(@class,"orgInfo")]/descendant::td[text()="Юридична адреса"]/following-sibling::td[1]
${tender.view.procuringEntity.contactPoint.name}=  xpath=//div[contains(@class,"contactsList")]/descendant::span[contains(@class, "contactFIO")]
${tender.view.procuringEntity.contactPoint.telephone}=  xpath=//div[contains(@class,"contactsList")]/descendant::div[@data-svg="/images/svg/orgstruct_phone.svg"]
#${tender.view.procuringEntity.contactPoint.url}
${tender.view.procuringEntity.identifier.legalName}=  xpath=//section[contains(@class,"orgInfo")]/descendant::td[text()="Найменування організації"]/following-sibling::td[1]
${tender.view.procuringEntity.identifier.scheme}=  xpath=//section[contains(@class,"orgInfo")]/descendant::td[contains(text(),"ЄДРПОУ")]
${tender.view.procuringEntity.identifier.id}=  xpath=//section[contains(@class,"orgInfo")]/descendant::td[contains(text(),"ЄДРПОУ")]/following-sibling::td[1]
${tender.view.documents[0].title}=  xpath=//span[@class="docType docTitle"]
${tender.view.awards[0].documents[0].title}
${tender.view.awards[0].status}=  xpath=(//div[@class="qualificationBidAmount"])[2]/div[1]
${tender.view.awards[0].suppliers[0].address.countryName}
${tender.view.awards[0].suppliers[0].address.locality}
${tender.view.awards[0].suppliers[0].address.postalCode}
${tender.view.awards[0].suppliers[0].address.region}
${tender.view.awards[0].suppliers[0].address.streetAddress}
${tender.view.lots[0].title}  xpath=(//span[@class="js-lot-title"])[1]
${tender.view.lots[0].minimalStep.amount}  xpath=(//td[contains(text(),"Розмір мінімального кроку")]/following-sibling::td/span[1])[1]

${tender.view.minimalStep.amount}=  xpath=//td[contains(text(),'Розмір мінімального кроку')]/following-sibling::td/span[1]
${tender.view.funders[0].name}=  xpath=//div[@class="fundersItem"]/descendant::td[text()="Найменування організації"]/following-sibling::td[1]
${tender.view.funders[0].address.countryName}=  xpath=//div[@class="fundersItem"]/descendant::td[contains(text(),"Юридична адреса")]/following-sibling::td[1]
${tender.view.funders[0].address.locality}=  xpath=//div[@class="fundersItem"]/descendant::td[contains(text(),"Юридична адреса")]/following-sibling::td[1]
${tender.view.funders[0].address.postalCode}=  xpath=//div[@class="fundersItem"]/descendant::td[contains(text(),"Юридична адреса")]/following-sibling::td[1]
${tender.view.funders[0].address.region}=  xpath=//div[@class="fundersItem"]/descendant::td[contains(text(),"Юридична адреса")]/following-sibling::td[1]
${tender.view.funders[0].address.streetAddress}=  xpath=//div[@class="fundersItem"]/descendant::td[contains(text(),"Юридична адреса")]/following-sibling::td[1]
${tender.view.funders[0].identifier.id}=  xpath=//div[@class="fundersItem"]/descendant::td[contains(text(),"ЄДРПОУ")]/following-sibling::td[1]
${tender.view.funders[0].identifier.legalName}=  xpath=//div[@class="fundersItem"]/descendant::td[text()="Найменування організації"]/following-sibling::td[1]
${tender.view.funders[0].identifier.scheme}=  xpath=//div[@class="fundersItem"]/descendant::td[contains(text(),"ЄДРПОУ")]/following-sibling::td[1]
${tender.view.awards[0].complaintPeriod.endDate}=  xpath=//span[@class="complaintEndDate"]/span[2]
${tender.view.awards[1].complaintPeriod.endDate}=  xpath=//span[@class="complaintEndDate"]/span[2]
${tender.view.awards[2].complaintPeriod.endDate}=  xpath=//span[@class="complaintEndDate"]/span[2]
${tender.view.awards[3].complaintPeriod.endDate}=  xpath=//span[@class="complaintEndDate"]/span[2]
${tender.view.contracts[0].status}=  xpath=(//div[@class="statusItem active"]/descendant::div[@class="statusName"])[last()]
${tender.view.contracts[1].status}=  xpath=(//div[@class="statusItem active"]/descendant::div[@class="statusName"])[last()]
${tender.view.contracts[2].status}=  xpath=(//div[@class="statusItem active"]/descendant::div[@class="statusName"])[last()]
${tender.view.contracts[1].dateSigned}=  xpath=//div[text()="Дата підписання"]/following-sibling::div
${tender.view.minimalStepPercentage}=  xpath=//td[contains(text(), "Мінімальний крок підвищення показника ефективності")]/following-sibling::td/span[1]
${tender.view.yearlyPaymentsPercentageRange}=  xpath=//td[contains(text(), "Фіксований відсоток суми скорочення")]/following-sibling::td/span[1]
${tender.view.fundingKind}=  xpath=//td[contains(text(), "Джерело фінансування закупівлі")]/following-sibling::td/span[1]
${tender.view.qualifications[0].status}=  xpath=(//div[contains(@class,"qualificationDocsExist")])[1]/div/a/span
${tender.view.qualifications[1].status}=  xpath=(//div[contains(@class,"qualificationDocsExist")])[2]/div/a/span
${tender.view.qualifications[2].status}=  xpath=(//div[contains(@class,"qualificationDocsExist")])[3]/div/a/span
${tender.view.NBUdiscountRate}=  xpath=//td[text()="Облікова ставка НБУ"]/following-sibling::td/span[1]
${tender.view.maxAwardsCount}=  xpath=//td[contains(text(), "Кіл-ть учасників")]/following-sibling::td[1]
${tender.view.agreementDuration}=  xpath=//td[contains(text(), "Строк, на який укладається рамкова угода")]/following-sibling::td[1]
${tender.view.auctionPeriod.startDate}=  xpath=//td[contains(text(),"Дата початку аукціону")]/following-sibling::td[1]/span
${tender.view.lots[0].auctionPeriod.startDate}=  xpath=//td[contains(text(),"Дата початку аукціону")]/following-sibling::td[1]/span
${tender.view.agreements[0].agreementID}=  xpath=//div[contains(text(),"Ідентифікатор рамкової угоди")]/following-sibling::div
${tender.view.agreements[0].status}=  xpath=//div[contains(text(),"Статус угоди")]/following-sibling::div
${tender.view.causeDescription}=  xpath=//td[contains(text(), "Обгрунтування")]/following-sibling::td[1]
${tender.view.cause}=  xpath=//td[contains(text(), "Підстава")]/following-sibling::td[1]

${locator.agreement.changes.rationaleType}=  xpath=(//td[contains(text(),"Підстава внесення змін")]/following-sibling::td[1])
${locator.agreement.changes.rationale}=  xpath=(//h3[contains(text(),"Деталізація внесених змін")]/following-sibling::table/tbody/tr[2]/td[1])
${locator.agreement.changes.status}=  xpath=(//div[@class="changeStatus"])


${tender.edit.description}=  xpath=//input[@name="data[description]"]
${tender.edit.tenderPeriod.endDate}=  xpath=//input[@name="data[tenderPeriod][endDate]"]

${locator.lots.title}=  /descendant::span[@class="js-lot-title"]
${locator.lots.description}=  /descendant::div[@class="lead"]
${locator.lots.value.amount}=  /descendant::td[contains(text(),"очікувана вартість")]/following-sibling::td/span[1]
${locator.lots.value.currency}=  /descendant::td[contains(text(),"очікувана вартість")]/following-sibling::td/span[2]
${locator.lots.value.valueAddedTaxIncluded}=  /descendant::span[@class="taxIncluded"]
${locator.lots.minimalStep.amount}=  /descendant::td[contains(text(),"Розмір мінімального кроку")]/following-sibling::td/span[1]
${locator.lots.minimalStep.currency}=  /descendant::td[contains(text(),"Розмір мінімального кроку")]/following-sibling::td/span[2]
${locator.lots.minimalStep.valueAddedTaxIncluded}=  /descendant::span[@class="taxIncluded"]
${locator.lots.minimalStepPercentage}=  /descendant::td[contains(text(),"Мінімальний крок підвищення показника")]/following-sibling::td/span[1]
${locator.lots.yearlyPaymentsPercentageRange}=  /descendant::td[contains(text(), "Фіксований відсоток суми скорочення")]/following-sibling::td/span[1]
${locator.lots.fundingKind}=  /descendant::td[contains(text(), "Джерело фінансування закупівлі")]/following-sibling::td/span[1]

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

${locator.complaint.description}  /descendant::div[@class="title"]/following-sibling::div
${locator.complaint.title}  /descendant::div[@class="title"]
${locator.complaint.resolution}  /descendant::div[text()="Відповідь замовника"]/following-sibling::div

${locator.feature.title}  /div[1]
${locator.feature.description}  /descendant::div[@class="featureDescr"]
${locator.feature.featureOf}  /descendant::div[@class="featureDescr"]

${locator.bids.lotValues[0].value.amount}  xpath=//td[text()="Цінова пропозиція"]/following-sibling::td[2]/span[1]
${locator.bids.value.amount}  xpath=//td[text()="Цінова пропозиція"]/following-sibling::td[2]/span[1]
${locator.bids.status}  xpath=//td[text()="Статус пропозиції"]/following-sibling::td[2]

${locator.complaint.status}  xpath=(//div[@class="complaintStatus"]/div/div[1])[last()]

${contract.value.amountNet}  xpath=//input[@name="data[value][amountNet]"]
${contract.value.amount}  xpath=//input[@name="data[value][amount]"]

${locator.agreement.changes.modifications.itemId}  xpath=(//div[@data-change-id])[last()]

${award.view.awards[0].suppliers[0].address.countryName}  xpath=//div[contains(@class,"bidDocuments")]/descendant::td[text()="Юридична адреса"]
${award.view.awards[0].suppliers[0].address.locality}  xpath=//div[contains(@class,"bidDocuments")]/descendant::td[text()="Юридична адреса"]
${award.view.awards[0].suppliers[0].address.postalCode}  xpath=//div[contains(@class,"bidDocuments")]/descendant::td[text()="Юридична адреса"]
${award.view.awards[0].suppliers[0].address.region}  xpath=//div[contains(@class,"bidDocuments")]/descendant::td[text()="Юридична адреса"]
${award.view.awards[0].suppliers[0].address.streetAddress}  xpath=//div[contains(@class,"bidDocuments")]/descendant::td[text()="Юридична адреса"]
${award.view.awards[0].suppliers[0].contactPoint.telephone}  xpath=//div[contains(@class,"bidDocuments")]/descendant::td[text()="Телефон"]/following-sibling::td
${award.view.awards[0].suppliers[0].contactPoint.name}  xpath=//div[contains(@class,"bidDocuments")]/descendant::td[text()="Особа відповідальна за процедуру"]/following-sibling::td
${award.view.awards[0].suppliers[0].contactPoint.email}  xpath=//div[contains(@class,"bidDocuments")]/descendant::td[text()="E-mail"]/following-sibling::td

${locator.ModalOK}=  xpath=//a[@data-msg="jAlert OK"]

*** Keywords ***
Підготувати клієнт для користувача
  [Arguments]  ${username}
  ${chrome_options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
  Set Global Variable  ${DZO_MODIFICATION_DATE}  ${EMPTY}
  Set Global Variable  ${dzo_internal_id}  ${None}
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
  Wait And Input Text  name=email  ${USERS.users['${username}'].login}
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
  ${procurementMethodType}=  Set Variable If  "${plan_data.data.tender.procurementMethodType}" == "reporting" or "${plan_data.data.tender.procurementMethodType}" == "negotiation"
  ...  limited_${plan_data.data.tender.procurementMethodType}  open_${plan_data.data.tender.procurementMethodType}
  Click Element  xpath=//div[contains(text(),"Меню користувача")]
  Click Element  xpath=//a[@href="/cabinet/plans"]
  Click Element  xpath=//a[@href="/cabinet/plans/nulled"]
  Click Element  xpath=//a[@href="/plans/new"]
  Select From List By Value  name=plan_method  ${procurementMethodType}
  Input Text  name=data[budget][amount]  ${amount}
  Select From List By Value  name=data[budget][currency]  ${plan_data.data.budget.breakdown[0].value.currency}
  Wait And Click  xpath=//a[@data-class="ДК021"]
  Select CPV  ${plan_data.data.classification.id}
  Click Element  xpath=//input[@name="procuringEntity[manual]"]/..
  Clear Element Text  xpath=//input[@name="data[procuringEntity][name]"]
  Sleep  2
  Input Text  xpath=//input[@name="data[procuringEntity][name]"]  ${plan_data.data.procuringEntity.name}
  Sleep  2
#  Clear Element Text  xpath=//input[@name="data[procuringEntity][identifier][id]"]
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
  Run Keyword If  "planning" in "${SUITE NAME.lower()}"  Sleep  360
  ${search_page}=  Set Variable If  "Owner" in "${username}"  https://www.stage.dzo.com.ua/cabinet/plans/publicated  https://www.stage.dzo.com.ua/tenders/plans
  Go To  ${search_page}
  Select From List By Value  xpath=//select[@name="filter[object]"]  planID
  Input Text  xpath=//input[@name="filter[search]"]  ${plan_uaid}
  Click Element  xpath=//button[contains(@class,"not_toExtend")]
  Wait Until Keyword Succeeds  10 x  1 s  Locator Should Match X Times  xpath=//section[contains(@class,"list")]/descendant::div[contains(@class, "item")]  1
  Click Element  xpath=//a[contains(@class, "tenderLink")]

###############################################################################################################
#########################################    ВІДОБРАЖЕННЯ    ##################################################
###############################################################################################################

Пошук тендера у разі наявності змін
  [Arguments]  ${last_mod_date}  ${username}  ${tender_uaid}
  ${status}=   Run Keyword And Return Status   Should Not Be Equal   ${DZO_MODIFICATION_DATE}   ${last_mod_date}
  refresh_tender   ${dzo_internal_id}
  Run Keyword If   ${status}   dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Set Global Variable  ${DZO_MODIFICATION_DATE}  ${last_mod_date}

Отримати інформацію із плану
  [Arguments]  ${username}  ${plan_uaid}  ${field_name}
  Switch Browser  ${username}
  ${text}=  Run Keyword If  "item" in "${field_name}"  Get From Item  ${field_name}
  ...  ELSE  Get Text  ${plan.view.${field_name}}
  ${text}=  Set Variable If  "deliveryDate" in "${field_name}"  ${text} 00:00  ${text}
  ${value}=  convert_dzo_data  ${text}  ${field_name}
  [Return]  ${value}

Отримати інформацію із тендера
  [Arguments]  ${username}  ${tender_uaid}  ${field_name}
  Switch Browser  ${username}
  Run Keyword If  "${TEST NAME}" == "Відображення статусу підписаної угоди з постачальником закупівлі" or "${TEST NAME}" == "Можливість дочекатися початку періоду очікування" or "${TEST NAME}" == "Відображення дати закінчення періоду блокування перед початком аукціону"  Sleep  300
  Run Keyword If  "planning" not in "${SUITE NAME.lower()}"  Пошук тендера у разі наявності змін  ${TENDER['LAST_MODIFICATION_DATE']}  ${username}  ${tender_uaid}
  Run Keyword If  "Відображення вартості угоди" in "${TEST NAME}"  Run Keywords
  ...  Sleep  360
  ...  AND  refresh_tender  ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Page Should Contain Element  xpath=//div[text()="Ціна договору"]/following-sibling::div
  Reload Page
  Run Keyword If  "status" in "${field_name}" and "reporting" in "${SUITE NAME.lower()}"  Wait Until Keyword Succeeds  20 x  20 s  Run Keywords
  ...  refresh_tender  ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Page Should Contain  Завершена
  Run Keyword And Return If  "${field_name}" == "agreements[0].agreementID" and "${MODE}" == "framework_selection"  Get Agreement Id
  ${text}=  Run Keyword If
  ...  "value.amount" in "${field_name}" and "contracts" in "${field_name}"  Get Text  xpath=//div[text()="Ціна договору"]/following-sibling::div
  ...  ELSE IF  "value.amountNet" in "${field_name}" and "contracts" in "${field_name}"  Get Text  xpath=//div[text()="Ціна договору без ПДВ"]/following-sibling::div
  ...  ELSE IF  "value.amount" in "${field_name}"  Get Amount
  ...  ELSE IF  "milestones" in "${field_name}"  Get From Milestone  ${field_name}
  ...  ELSE IF  "item" in "${field_name}"  Get From Item  ${field_name}
  ...  ELSE IF  "awards[0].documents[0].title" in "${field_name}"  Get Award Document Title
  ...  ELSE IF  "awards[0].suppliers" in "${field_name}"  Get Award Info  ${field_name}
  ...  ELSE IF  "qualifications" in "${field_name}" and "status" in "${field_name}"  Get Qualification Status  ${field_name}
  ...  ELSE IF  "qualificationPeriod.endDate" in "${field_name}"  Run Keyword And Return  Get Element Attribute  xpath=//div[contains(@class, "prequalificationDoneDate")]/span[2]@data-qualificationperiod-enddate
  ...  ELSE IF  "${field_name}" == "complaintPeriod.endDate"  Run Keyword And Return  Get Element Attribute  xpath=//div[@data-status="1.1"]@data-dateorig
  ...  ELSE  Get Text  ${tender.view.${field_name}}
  ${value}=  convert_dzo_data  ${text}  ${field_name}
#  ${value}=  Set Variable If  "amount" in "${field_name}"  ${value.replace("`", "")}  ${value}
  [Return]  ${value}

Get Agreement Id
  ${current_url}=  Get Location
  Wait And Click  xpath=//a[contains(@href, "agreement")]
  Wait Until Page Contains Element  xpath=//td[text()="Ідентифікатор угоди"]/following-sibling::td[1]
  ${value}=  Get Text  xpath=//td[text()="Ідентифікатор угоди"]/following-sibling::td[1]
  Go To  ${current_url}
  [Return]  ${value}

Get Qualification Status
  [Arguments]  ${field_name}
  ${match}=  Get Regexp Matches  ${field_name}  \\[(\\d+)\\]  1
  ${index}=  Convert To Integer  ${match[0]}
  ${value}=  Get Element Attribute  xpath=(//div[@class="num l" and text()="${index + 1}"])[last()]/ancestor::div[@data-status]@data-status
  [Return]  ${value}


Get Award Document Title
  Wait And Click  xpath=//a[contains(@href, "award") and contains(@href, "documents") and not (contains(@href, "contract"))]
  Wait Until Keyword Succeeds  10 x  2 s  Page Should Contain Element  xpath=//span[@class="docTitle"]
  ${value}=  Get Text  xpath=//span[@class="docTitle"]
  Wait And Click  xpath=//a[@onclick="modalClose();"]
  [Return]  ${value}

Get Award Info
  [Arguments]  ${field_name}
  Wait And Click  xpath=//a[@class="biderInfo"]
  Wait Until Keyword Succeeds  10 x  1 s  Page Should Contain Element  xpath=//div[contains(@class,"bidDocuments")]/descendant::td[text()="Юридична адреса"]
  ${value}=  Get Text  ${award.view.${field_name}}
  ${value}=  convert_dzo_data  ${value}  ${field_name}
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
  ${value}=  Run Keyword If  "deliveryDate.endDate" in "${field_name}"
  ...  Get Text  xpath=(//*[contains(text(),"Кінцевий строк поставки")]/../following-sibling::span[2])[${item_index}]
  ...  ELSE  Get Text  ${tender.view.${field_name}}
  [Return]  ${value}

Отримати інформацію із лоту
  [Arguments]  ${username}  ${tender_uaid}  ${lot_id}  ${field_name}
  Switch Browser  ${username}
  Пошук тендера у разі наявності змін  ${TENDER['LAST_MODIFICATION_DATE']}  ${username}  ${tender_uaid}
  ${lot_value}=  Get Text  xpath=//*[contains(text(), '${lot_id}')]/ancestor::div[contains(@class,"tenderLotItemElement")]${locator.lots.${field_name}}
  ${lot_value}=  convert_dzo_data  ${lot_value}  ${field_name}
  [Return]  ${lot_value}

Отримати інформацію із предмету
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${field_name}
  Switch Browser  ${username}
  Пошук тендера у разі наявності змін  ${TENDER['LAST_MODIFICATION_DATE']}  ${username}  ${tender_uaid}
  ${item_value}=  Get Text  xpath=//div[contains(text(), '${item_id}')]/ancestor::tr[contains(@class,"tenderFullListElement")]${locator.items.${field_name}}
  ${item_value}=  adapt_items_data  ${field_name}  ${item_value}
  [Return]  ${item_value}

Отримати інформацію із запитання
  [Arguments]  ${username}  ${tender_uaid}  ${question_id}  ${field_name}
  Switch Browser  ${username}
  Пошук тендера у разі наявності змін  ${TENDER['LAST_MODIFICATION_DATE']}  ${username}  ${tender_uaid}
  Reload Page
  Wait And Click  xpath=//section[@class="content"]/descendant::a[contains(@href, 'questions')]
  Wait Until Element Is Visible  xpath=//div[@id='questions']
  Wait Until Keyword Succeeds  15 x  20 s  Дочекатися відображення запитання на сторінці  ${question_id}
  Run Keyword If  "${field_name}" == "answer"  Wait Until Keyword Succeeds  15 x  20 s  Run Keywords
  ...  refresh_tender  ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Page Should Contain Element  xpath=//div[contains(text(),'${question_id}')]/../following-sibling::div[@class="answer relative"]/div[@class="text"]
  ${question_value}=  Get Text  xpath=//div[contains(text(),'${question_id}')]${locator.questions.${field_name}}
  [Return]  ${question_value}

Дочекатися відображення запитання на сторінці
  [Arguments]  ${text_for_view}
  Reload Page
  Wait Until Page Contains  ${text_for_view}

Отримати інформацію із документа
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}  ${field}
  Пошук тендера у разі наявності змін  ${TENDER['LAST_MODIFICATION_DATE']}  ${username}  ${tender_uaid}
  Wait Until Keyword Succeeds  20 x  20 s  Run Keywords
  ...  refresh_tender  ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Page Should Contain  ${doc_id}
  Run Keyword If  "contract signing" in "${SUITE NAME.lower()}"  Wait And Click  xpath=//div[@class="btn docs"]/a
  Wait Until Element Is Visible   xpath=//*[contains(text(),'${doc_id}')]
  ${value}=   Get Text   xpath=//*[contains(text(),'${doc_id}')]
  [Return]  ${value.split('/')[-1]}

Отримати документ
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}
  Пошук тендера у разі наявності змін  ${TENDER['LAST_MODIFICATION_DATE']}  ${username}  ${tender_uaid}
  Execute Javascript   $(".topFixed").remove(); $(".bottomFixed").remove();
  ${file_name}=   Get Text   xpath=//span[contains(text(),'${doc_id}')]
  ${url}=   Get Element Attribute   xpath=//span[contains(text(),'${doc_id}')]/../preceding-sibling::a[contains(@class,"js-download-link")]@href
  dzo_download_file   ${url}  ${file_name.split('/')[-1]}  ${OUTPUT_DIR}
  [Return]  ${file_name.split('/')[-1]}

Отримати інформацію із пропозиції
  [Arguments]  ${username}  ${tender_uaid}  ${field_name}
  Пошук тендера у разі наявності змін  ${TENDER['LAST_MODIFICATION_DATE']}  ${username}  ${tender_uaid}
  Run Keyword If  "status" in "${field_name}" and "після редагування" in "${TEST_NAME}"  Run Keywords
  ...  Sleep  300
  ...  AND  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  Wait And Click  xpath=//a[contains(@class, "js-viewBid")]
  Wait Until Keyword Succeeds  20 x  1 s  Page Should Contain Element  xpath=//*[contains(text(),"Інформація про пропозицію учасника")]
  ${bid_value}=  Get Text  ${locator.bids.${field_name}}
#  ${bid_value}=  Run Keyword If  "amount" in "${field_name}"  Convert To Number  ${bid_value.replace('`', '')}
#  ...  ELSE  Set Variable  ${bid_value}
  Click Element  xpath=//a[@onclick="modalClose();"]
  ${bid_value}=  convert_dzo_data  ${bid_value}  ${field_name}
  [Return]  ${bid_value}

Отримати інформацію із нецінового показника
  [Arguments]  ${username}  ${tender_uaid}  ${feature_id}  ${field_name}
  Пошук тендера у разі наявності змін  ${TENDER['LAST_MODIFICATION_DATE']}  ${username}  ${tender_uaid}
  Wait Until Keyword Succeeds  20 x  20 s  Run Keywords
  ...  refresh_tender  ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Page Should Contain  ${feature_id}
  ${value}=  Get Text  xpath=//div[contains(text(),"${feature_id}")]/..${locator.feature.${field_name}}
  [Return]  ${value}

Отримати тендер другого етапу та зберегти його
  [Arguments]  ${username}  ${tender_uaid}
  Sleep  360
  Reload Page
  Wait And Click  xpath=//span[text()="Перебіг другого етапу процедури"]/..

Отримати інформацію із скарги
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${field_name}  ${award_index}=${None}
  Run Keyword And Return If  "визначення переможця" in "${TEST NAME}"  Get Award Complaint Info  ${complaintID}  ${field_name}
  Wait Until Keyword Succeeds  20 x  30 s  Run Keywords
  ...  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Go To Complaint Page
  ...  AND  Page Should Contain  ${complaintID}
  ${value}=  Run Keyword If  "${field_name}" == "status"  Get Element Attribute  xpath=//span[text()="${complaintID}"]/ancestor::div[contains(@class, "compStatus_")]@class
  ...  ELSE  Get Text  xpath=//span[text()="${complaintID}"]/ancestor::div[contains(@class, "compStatus_")]${locator.complaint.${field_name}}
  ${value}=  convert_dzo_data  ${value}  complaint.${field_name}
  [Return]  ${value}

Get Award Complaint Info
  [Arguments]  ${complaintID}  ${field_name}
  Wait Until Keyword Succeeds  20 x  20 s  Run Keywords
  ...  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Wait And Click  xpath=//a[contains(@href, "award") and contains(@href, "complaints")]
  ...  AND  Wait Until Keyword Succeeds  10 x  1 s  Page Should Contain  Оскарження кваліфікації
  ...  AND  Page Should Contain  ${complaintID}
  ${value}=  Run Keyword If  "${field_name}" == "status"  Get Element Attribute  xpath=//span[contains(text(), "${complaintID}")]/ancestor::div[contains(@class, "compStatus_")]@class
  ...  ELSE  Get Text  xpath=//span[text()="${complaintID}"]/ancestor::div[contains(@class, "compStatus_")]${locator.complaint.${field_name}}
  ${value}=  convert_dzo_data  ${value}  complaint.${field_name}
  [Return]  ${value}

Go To Complaint Page
  ${current_url}=  Get Location
  ${is_on_complaints_page}=  Run Keyword And Return Status  Should Contain  ${current_url}  complaints
  Run Keyword If  not ${is_on_complaints_page}  Wait And Click  xpath=(//section[@class="content"]/descendant::a[contains(@href, 'complaints')])[1]

Отримати інформацію із документа до скарги
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${doc_id}  ${field_name}  ${award_id}=${None}
  Wait And Click  xpath=//span[text()="${complaintID}"]/ancestor::div[contains(@class, "compStatus_")]/descendant::a[@class="viewDocs"]
  Wait Until Keyword Succeeds  5 x  1 s  Element Should Be Visible  xpath=//span[@class="docTitle"]
  ${value}=  Get Text  xpath=//span[@class="docTitle"]
  [Return]  ${value}

Отримати посилання на аукціон для глядача
  [Arguments]  ${username}  ${tender_uaid}  ${lot_id}=${Empty}
  refresh_tender   ${dzo_internal_id}
  Reload Page
  ${value}=  Get Element Attribute  xpath=//a[contains(@href,"auction-staging")]@href
  [Return]  ${value}

Отримати посилання на аукціон для учасника
  [Arguments]  ${username}  ${tender_uaid}  ${relatedLot}=${Empty}
  Wait Until Keyword Succeeds  20 x  20 s  Run Keywords
  ...  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Page Should Contain Element  xpath=//a[@class="reverse getAuctionUrl"]
  Wait And Click  xpath=//a[@class="reverse getAuctionUrl"]
  Wait Until Page Contains Element   xpath=//a[contains(@href,"auction-staging")]
  ${value}=   Get Element Attribute   xpath=//a[contains(@href,"auction-staging")]@href
  [Return]  ${value}

###############################################################################################################
###################################    СТВОРЕННЯ ТЕНДЕРУ    ###################################################
###############################################################################################################

Створити тендер
  [Arguments]  ${username}  ${tender_data}  ${plan_uaid}
  Switch Browser  ${username}
  ${dzo_accelerator}=  Set Variable If
  ...  "esco" in "${tender_data.data.procurementMethodType}" or "competitive" in "${tender_data.data.procurementMethodType}" or "FrameworkAgreement" in "${tender_data.data.procurementMethodType}"  5760
  ...  "Complaints" in "${SUITE NAME}"  360
  ...  1440
  ${rate}=  Run Keyword If  ${tender_data.data.has_key("NBUdiscountRate")}  Convert To String  ${tender_data.data.NBUdiscountRate * 100}
  ${valueAddedTaxIncluded}=  Run Keyword If  "${tender_data.data.procurementMethodType}" != "esco"  Set Variable If  ${tender_data.data.value.valueAddedTaxIncluded}  true  false
  ${enquiry_end_date}=  Run Keyword If  ${tender_data.data.has_key("enquiryPeriod")}  convert_datetime_to_format  ${tender_data.data.enquiryPeriod.endDate}  %d/%m/%Y %H:%M
  ${tender_end_date}=   Run Keyword If  ${tender_data.data.has_key("tenderPeriod")}  convert_datetime_to_format  ${tender_data.data.tenderPeriod.endDate}  %d/%m/%Y %H:%M
  ${procurementMethodType}=  Set Variable If  ${tender_data.data.has_key("procurementMethodType")}  ${tender_data.data.procurementMethodType}  open_belowThreshold
  ${file_path}=  Get Variable Value  ${ARTIFACT_FILE}  artifact_plan.yaml
  ${artifact}=  load_data_from  ${file_path}
  ${plan_id}=  Set Variable  ${artifact.tender_uaid}
  ${is_lot}=  Set Variable If  ${tender_data.data.has_key('lots')}  ${True}  ${False}
  ${tender_type}=  Set Variable If  ${tender_data.data.has_key("features")}  features_lots
  ...  ${is_lot}  lots

  dzo.Пошук плану по ідентифікатору  ${username}  ${plan_id}
  Wait And Click  xpath=//a[contains(@href,"/tenders/new")]


  Run Keyword If  ${is_lot}  Run Keywords  Select From List By Value  name=tender_type  ${tender_type}
  ...  AND  Wait Element Animation  xpath=//a[@data-msg="jAlert OK"]
  ...  AND  Підтвердити Дію

  Run Keyword If  "${tender_data.data.procurementMethodType}" == "esco"  Input Text  xpath=//input[@name="data[NBUdiscountRate]"]  ${rate}

  ${maxAwardsCount}=  Run Keyword If  ${tender_data.data.has_key("maxAwardsCount")}  Convert To String  ${tender_data.data.maxAwardsCount}
  Run Keyword If  ${tender_data.data.has_key("maxAwardsCount")}  Input Text  xpath=//input[@name="data[maxAwardsCount]"]  ${maxAwardsCount}

  Run Keyword If  ${tender_data.data.has_key("agreementDuration")}  Run Keywords
  ...  Mouse Over  xpath=//div[@class="durationPicker-ui"]
  ...  AND  Wait Until Keyword Succeeds  5 x  0.5 s  Element Should Be Visible  xpath=//div[contains(@class,"durationPicker-select-field-0-Y")]/div/input
  ...  AND  Input Text  xpath=//div[contains(@class,"durationPicker-select-field-0-Y")]/div/input  ${tender_data.data.agreementDuration[1]}
  ...  AND  Input Text  xpath=//div[contains(@class,"durationPicker-select-field-0-M")]/div/input  ${tender_data.data.agreementDuration[3]}
  ...  AND  Input Text  xpath=//div[contains(@class,"durationPicker-select-field-0-D")]/div/input  ${tender_data.data.agreementDuration[5]}

  Run Keyword If  "${MODE}" == "negotiation"  Run Keywords
  ...  Wait And Click  xpath=//input[@value="${tender_data.data.cause}"]/..
  ...  AND  Input Text  xpath=//input[@name="data[causeDescription]"]  ${tender_data.data.causeDescription}

  Select From List By Value  xpath=//select[@name="data[mainProcurementCategory]"]  ${tender_data.data.mainProcurementCategory}
  Input Text  xpath=//input[@name="data[title]"]  ${tender_data.data.title}
  Input Text En  xpath=//input[@name="data[title_en]"]  ${tender_data.data.title_en}
  Input Text  xpath=//input[@name="data[description]"]  ${tender_data.data.description}
  Run Keyword If  "${tender_data.data.procurementMethodType}" != "esco"  Select From List By Value  xpath=//select[@name="data[value][valueAddedTaxIncluded]"]  ${valueAddedTaxIncluded}

#  Input Text  name=data[budget][amount]  ${amount}
#  Select From List By Value  name=data[budget][currency]  ${tender_data.data.budget.breakdown[0].value.currency}
#  Wait And Click  xpath=//a[@data-class="ДК021"]
#  Select CPV  ${tender_data.data.classification.id}
#  Wait And Input Text  xpath=//input[@name="data[budget][description]"]  ${tender_data.data.budget.description}

  Run Keyword If  not ${is_lot}  Fill Form For Tender Without Lots  ${tender_data}
  ...  ELSE  Fill Form Tender With Lots  ${tender_data}

  Run Keyword If  ${tender_data.data.has_key('funders')}
  ...  Execute Javascript  $('.js-choosenInit')[0].value = ${tender_data.data.funders[0].name.replace(u"Світовий Банк","0").replace(u"Глобальний фонд","1")}

  Run Keyword If  ${tender_data.data.has_key("features")} and "${tender_data.data.procurementMethodType}" != "reporting" and "${tender_data.data.procurementMethodType}" != "negotiation"  Add Features  ${tender_data}

  Run Keyword If  ${tender_data.data.has_key("enquiryPeriod")}  Run Keywords
  ...  Input Date  data[enquiryPeriod][endDate]  ${enquiry_end_date.split(" ")[0]}
  ...  AND  Input Date  enquiryPeriod_time  ${enquiry_end_date.split(" ")[1]}
  Run Keyword If  ${tender_data.data.has_key("tenderPeriod")}  Run Keywords
  ...  Input Date  data[tenderPeriod][endDate]  ${tender_end_date.split(" ")[0]}
  ...  AND  Input Date  tenderPeriod_time  ${tender_end_date.split(" ")[1]}
#  Click Element  xpath=//select[@name="tender_enquiry_timeout"]
  Run Keyword If  ${tender_data.data.has_key("tenderPeriod")}  Click Element  xpath=//*[contains(text(),"Надайте календарну")]
  Wait Until Element Is Not Visible  xpath=//div[@id="ui-datepicker-div"]
#  Execute Javascript  history.replaceState({}, null, window.location.pathname+'?accelerator=${dzo_accelerator}');
  Run Keyword If  "${MODE}" in "openeu open_competitive_dialogue" or "Complaints" in "${SUITE NAME}" and "Reporting" not in "${SUITE NAME}" and "Negotiation" not in "${SUITE NAME}"  Execute Javascript  history.replaceState({}, null, window.location.pathname+'?accelerator=${dzo_accelerator}&submissionMethodDetails=quick(mode:fast-forward)');
  ...  ELSE IF  "Reporting" not in "${SUITE NAME}" and "Negotiation" not in "${SUITE NAME}"  Execute Javascript  history.replaceState({}, null, window.location.pathname+'?accelerator=${dzo_accelerator}&submissionMethodDetails=quick');
  Wait And Click  xpath=//button[@value="publicate"]
  Wait Until Page Contains Element  xpath=//span[@class="js-apiID"]
  ${tender_uaid}=  Get Text  xpath=//span[@class="js-apiID"]
  ${internal_id}=  Get Text  id=tender_id
  Set Global Variable  ${dzo_internal_id}  ${internal_id}
  [Return]  ${tender_uaid}

Input Text En
  [Arguments]  ${locator}  ${value}
  Wait And Click  xpath=//span[text()="In English"]/../..
  Wait And Input Text  ${locator}  ${value}
  Wait And Click  xpath=//span[text()="Українська"]/../..

Fill Form For Tender Without Lots
  [Arguments]  ${tender_data}
  ${amount}=  add_second_sign_after_point  ${tender_data.data.value.amount}
  ${minimal_step_amount}=  Run Keyword If  ${tender_data.data.has_key("minimalStep")}   add_second_sign_after_point  ${tender_data.data.minimalStep.amount}
  ${items}=  Get From Dictionary  ${tender_data.data}  items
  ${items_length}=  Get Length  ${items}
  ${milestones_length}=  Get Length  ${tender_data.data.milestones}
  Input Text  xpath=//input[@name="data[value][amount]"]  ${amount}
  Run Keyword If  ${tender_data.data.has_key("minimalStep")}  Input Text  xpath=//input[@name="data[minimalStep][amount]"]  ${minimal_step_amount}
  Wait And Click  xpath=//section[contains(@id, "multiItems")]/a
  :FOR  ${index}  IN RANGE  ${items_length}
  \  Run Keyword If  ${index} != 0  Click Element  xpath=//section[contains(@id, "multiItems")]/descendant::a[@class="addMultiItem"]
  \  Add Tender Item  ${tender_data}  ${items[${index}]}  ${index}

  Wait And Click  xpath=//section[contains(@id, "multiMilestones")]/a
  :FOR  ${index}  IN RANGE  ${milestones_length}
  \  Wait And Click  xpath=//section[contains(@id, "multiMilestones")]/descendant::a[@class="addMultiItem"]
  \  Add Milestone  ${tender_data.data.milestones[${index}]}  ${index}

Fill Form Tender With Lots
  [Arguments]  ${tender_data}
  ${lots_length}=  Get Length  ${tender_data.data.lots}

  Wait And Click  xpath=//section[contains(@id, "multiLots")]/a
  :FOR  ${index}  IN RANGE  ${lots_length}
  \  Run Keyword If  ${index} != 0  Click Element  xpath=//section[contains(@id, "multiItems")]/descendant::a[@class="addMultiItem"]
  \  Add Tender Lot  ${tender_data}  ${tender_data.data.lots[${index}]}  ${index}

Add Tender Lot
  [Arguments]  ${tender_data}  ${lot}  ${index}
  ${amount}=  Run Keyword If  "${tender_data.data.procurementMethodType}" != "esco"  add_second_sign_after_point  ${lot.value.amount}
  ${minimal_step_amount}=  Run Keyword If  "${tender_data.data.procurementMethodType}" != "esco"  add_second_sign_after_point  ${lot.minimalStep.amount}
  ${minimalStepPercentage}=  Run Keyword If  "${tender_data.data.procurementMethodType}" == "esco"  Convert To String  ${lot.minimalStepPercentage * 100}
  ${yearlyPaymentsPercentageRange}=  Run Keyword If  "${tender_data.data.procurementMethodType}" == "esco"  Convert To String  ${lot.yearlyPaymentsPercentageRange * 100}
  ${items}=  get_items_by_lot_id  ${tender_data}  ${tender_data.data.lots[${index}].id}
#  ${milestones}=  Run Keyword If  "${tender_data.data.procurementMethodType}" != "esco"  get_milestone_by_lot_id  ${tender_data}  ${tender_data.data.lots[${index}].id}
#  ${items}=  Get From Dictionary  ${tender_data.data}  items
  ${items_length}=  Get Length  ${items}
#  ${milestones_length}=  Run Keyword If  "${tender_data.data.procurementMethodType}" != "esco"  Get Length  ${milestones}
  Wait And Input Text  xpath=//input[@name="data[lots][${index}][title]"]  ${lot.title}
  Input Text En  xpath=//input[@name="data[lots][${index}][title_en]"]  ${lot.title_en}
  Wait And Input Text  xpath=//input[@name="data[lots][${index}][description]"]  ${lot.description}
  Run Keyword If  "${tender_data.data.procurementMethodType}" != "esco"  Wait And Input Text  xpath=//input[@name="data[lots][${index}][value][amount]"]  ${amount}
  Run Keyword If  "${tender_data.data.procurementMethodType}" != "esco"  Wait And Input Text  xpath=//input[@name="data[lots][${index}][minimalStep][amount]"]  ${minimal_step_amount}
  Run Keyword If  "${tender_data.data.procurementMethodType}" == "esco"  Wait And Input Text  xpath=//input[@name="data[lots][${index}][minimalStepPercentage]"]  ${minimalStepPercentage}
  Run Keyword If  "${tender_data.data.procurementMethodType}" == "esco"  Wait And Input Text  xpath=//input[@name="data[lots][${index}][yearlyPaymentsPercentageRange]"]  ${yearlyPaymentsPercentageRange}
  :FOR  ${index}  IN RANGE  ${items_length}
  \  Run Keyword If  ${index} != 0  Click Element  xpath=//section[contains(@id, "multiItems")]/descendant::a[@class="addMultiItem"]
  \  Add Tender Item  ${tender_data}  ${items[${index}]}  ${index}
  Run Keyword If  "${tender_data.data.procurementMethodType}" != "esco"  Add Milestones  ${tender_data}  ${index}

Add Milestones
  [Arguments]  ${tender_data}  ${index}
  ${milestones}=  get_milestone_by_lot_id  ${tender_data}  ${tender_data.data.lots[${index}].id}
  ${milestones_length}=  Get Length  ${milestones}
  Wait And Click  xpath=(//section[contains(@class, "multiMilestones")]/a)[1]
  :FOR  ${index}  IN RANGE  ${milestones_length}
  \  Wait And Click  xpath=(//section[contains(@class, "multiMilestones")]/descendant::a[@class="addMultiItem"])[1]
  \  Add Milestone  ${milestones[${index}]}  ${index}

Add Tender Item
  [Arguments]  ${tender_data}  ${item}  ${index}
  ${quantity}=  add_second_sign_after_point  ${item.quantity}
  ${unit_id}=  Run Keyword If  "${tender_data.data.procurementMethodType}" != "esco"  convert_unit_id  ${item.unit.code}
  ${delivery_end_date}=  Run Keyword If  "${tender_data.data.procurementMethodType}" != "esco"  convert_datetime_to_format  ${item.deliveryDate.endDate}  %d/%m/%Y
  Wait And Input Text  xpath=//input[@name="data[items][${index}][description]"]  ${item.description}
  Input Text En  xpath=//input[@name="data[items][${index}][description_en]"]  ${item.description_en}
  Run Keyword If  "${tender_data.data.procurementMethodType}" != "esco"  Input Text  xpath=//input[@name="data[items][${index}][quantity]"]  ${quantity}
  Run Keyword If  "${tender_data.data.procurementMethodType}" != "esco"  Select From List By Value  xpath=//select[@name="data[items][${index}][unit_id]"]  ${unit_id}
  Wait And Click  xpath=//div[contains(@class, "tenderItemPositionElement")][@data-multiline="${index}"]/descendant::a[@data-class="ДК021"]
  Select CPV  ${item.classification.id}
  Run Keyword And Ignore Error  Run Keywords
  ...  Wait Until Keyword Succeeds  10 x  1 s  Element Should Be Visible  xpath=//a[@data-msg="jAlert Close"]
  ...  AND  Click Element  xpath=//a[@data-msg="jAlert Close"]
  ...  AND  Wait Until Page Does Not Contain Element  xpath=//a[@data-msg="jAlert Close"]
  Run Keyword If  "${tender_data.data.procurementMethodType}" != "esco"  Input Date  data[items][${index}][deliveryDate][endDate]  ${delivery_end_date}
  Select From List By Value  xpath=//select[@name="data[items][${index}][country_id]"]  461
  Select From List By Label  xpath=//select[@name="data[items][${index}][region_id]"]  ${item.deliveryAddress.region}
  Input Text  xpath=//input[@name="data[items][${index}][deliveryAddress][locality]"]  ${item.deliveryAddress.locality}
  Input Text  xpath=//input[@name="data[items][${index}][deliveryAddress][streetAddress]"]  ${item.deliveryAddress.streetAddress}
  Execute Javascript  $('input[name="data[items][${index}][deliveryAddress][postalCode]"]').val('${item.deliveryAddress.postalCode}')
#  Input Text  xpath=//input[@name="data[items][${index}][deliveryAddress][postalCode]"]  ${item.deliveryAddress.postalCode}
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

Add Features
  [Arguments]  ${tender_data}
  ${feature_length}=  Get Length  ${tender_data.data.features}
  Wait And Click  xpath=(//section[contains(@class, "multiFeatures")]/a)[last()]
  :FOR  ${index}  IN RANGE  ${feature_length}
  \  Run Keyword If  "${index}" != "0"  Wait And Click  xpath=(//section[contains(@class, "multiFeatures")]/descendant::a[@class="addMultiItem"])[last()]
  \  Add Feature  ${tender_data.data.features[${index}]}  ${index}

Add Feature
  [Arguments]  ${feature}  ${index}
  ${enum_length}=  Get Length  ${feature.enum}
  Input Text  xpath=//input[@name="data[features][${index}][title]"]  ${feature.title}
  Input Text En  xpath=//input[@name="data[features][${index}][title_en]"]  ${feature.title_en}
  Input Text  xpath=//input[@name="data[features][${index}][description]"]  ${feature.description}
  :FOR  ${enum_index}  IN RANGE  ${enum_length}
  \  ${enum_value}=  Convert To String  ${feature.enum[${enum_index}].value * 100}
  \  Run Keyword If  "${enum_index}" != "0"  Wait And Click  xpath=(//a[@class="addFeatureOptItem"])[last()]
  \  Wait And Input Text  xpath=//input[@name="data[features][${index}][enum][${enum_index}][title]"]  ${feature.enum[${enum_index}].title}
  \  Input Text En  xpath=//input[@name="data[features][${index}][enum][${enum_index}][title_en]"]  test
  \  Input Text  xpath=//input[@name="data[features][${index}][enum][${enum_index}][value]"]  ${enum_value.split(".")[0]}

Пошук тендера по ідентифікатору
  [Arguments]  ${username}  ${tender_uaid}  ${save_key}=tender_data
  Switch Browser  ${username}
  ${dzo_internal_id}=  Set Variable If  "Selection" in "${SUITE NAME}" and "${TEST NAME}" == "Можливість оголосити тендер другого етапу"  ${None}  ${dzo_internal_id}
  Run Keyword If  "${dzo_internal_id}" == "${None}" and ("openProcedure" in "${SUITE NAME}" or "Complaints" in "${SUITE NAME}" or "Reporting" in "${SUITE NAME}" or "Negotiation" in "${SUITE NAME}" or "Selection" in "${SUITE NAME}") or "${save_key}" == "second_stage_data"  Sleep  360
#  ${search_page}=  Set Variable If  "${TEST NAME}" == "Можливість знайти звіт про укладений договір по ідентифікатору" and "Viewer" not in "${username}"  https://www.stage.dzo.com.ua/cabinet/tenders/purchase  https://www.stage.dzo.com.ua/tenders/public
  ${search_page}=  Set Variable If  "Owner" in "${username}"  https://www.stage.dzo.com.ua/cabinet/tenders/purchase  https://www.stage.dzo.com.ua/tenders/public
  ${dzo_internal_id}=  Set Variable If  "${username}" != "DZO_Owner" and "${TEST NAME}" == "Можливість знайти тендер по ідентифікатору"  ${USERS.users['Tender_Owner'].id_map['${tender_uaid}']}  ${dzo_internal_id}
  refresh_tender  ${dzo_internal_id}
  Go To  ${search_page}
  Select From List By Value  xpath=//select[@name="filter[object]"]  tenderID
  Input Text  xpath=//input[@name="filter[search]"]  ${tender_uaid}
  Click Element  xpath=(//button[text()="Пошук"])[1]
  Wait Until Keyword Succeeds  10 x  30 s  Locator Should Match X Times  xpath=//section[contains(@class,"list")]/descendant::div[contains(@class, "item")]/a[contains(@href,"/tenders/")]  1
  Click Element  xpath=//a[contains(@class, "tenderLink")]
  ${internal_id}=  Run Keyword If  "${dzo_internal_id}" == "${None}"  Get Text  id=tender_id
  ...  ELSE  Set Variable  ${dzo_internal_id}
  Set Global Variable  ${dzo_internal_id}  ${internal_id}
  Run Keyword If  "${SUITE NAME.lower()}" == "qualification" and "${TEST NAME}" == "Можливість знайти закупівлю по ідентифікатору"
  ...  Wait Until Keyword Succeeds  40 x  30 s  Status Should Be  ${username}  ${tender_uaid}  active.qualification

Status Should Be
  [Arguments]  ${status}
  ${cur_status}=  Отримати інформацію із тендера  ${username}  ${tender_uaid}  status
  Should Be Equal  ${status}  ${cur_status}

Оновити сторінку з тендером
  [Arguments]  ${username}  ${tender_uaid}
  Switch Browser  ${username}
  Run Keyword If  "${TEST NAME}" != "Можливість укласти угоду для закупівлі"  Reload Page


Створити постачальника, додати документацію і підтвердити його
  [Arguments]  ${username}  ${tender_uaid}  ${supplier_data}  ${document}
  Sleep  30
  Wait Until Keyword Succeeds  10 x  1 s  Run Keywords
  ...  Reload Page
  ...  AND  Page Should Contain Element  xpath=//a[contains(@class, "tenderSignCommand")]
  Накласти ЕЦП
  Wait Until Keyword Succeeds  10 x  1 s  Run Keywords
  ...  Reload Page
  ...  AND  Page Should Contain Element  xpath=//a[contains(@class, "addAward")]
  Wait And Click  xpath=//a[contains(@class, "addAward")]
  Підтвердити Дію
  Wait Until Keyword Succeeds  10 x  1 s  Element Should Be Visible  xpath=//*[@name="data[suppliers][0][name]" ]
  Input Text  xpath=//*[@name="data[suppliers][0][name]"]  ${supplier_data.data.suppliers[0].name}
  Select From List By Value  xpath=//*[@name="data[suppliers][0][identifier][scheme]"]  ${supplier_data.data.suppliers[0].identifier.scheme}
  Input Text  xpath=//*[@name="data[suppliers][0][identifier][id]"]  ${supplier_data.data.suppliers[0].identifier.id}
  Select From List By Value  xpath=//*[@name="data[suppliers][0][scale]"]  ${supplier_data.data.suppliers[0].scale}
  Select From List By Value  xpath=//*[@name="data[suppliers][0][address][countryName]"]  ${supplier_data.data.suppliers[0].address.countryName}
  Select From List By Value  xpath=//*[@name="data[suppliers][0][address][region]"]  ${supplier_data.data.suppliers[0].address.region}
  Input Text  xpath=//*[@name="data[suppliers][0][address][locality]"]  ${supplier_data.data.suppliers[0].address.locality}
  Input Text  xpath=//*[@name="data[suppliers][0][address][postalCode]"]  ${supplier_data.data.suppliers[0].address.postalCode}
  Input Text  xpath=//*[@name="data[suppliers][0][contactPoint][name]"]  ${supplier_data.data.suppliers[0].contactPoint.name}
  Input Text  xpath=//*[@name="data[suppliers][0][contactPoint][email]"]  ${supplier_data.data.suppliers[0].contactPoint.email}
  Input Text  xpath=//*[@name="data[suppliers][0][contactPoint][telephone]"]  ${supplier_data.data.suppliers[0].contactPoint.telephone}
  Input Text  xpath=//*[@name="data[suppliers][0][contactPoint][faxNumber]"]  ${supplier_data.data.suppliers[0].contactPoint.faxNumber}
#  Input Text  xpath=//*[@name="data[suppliers][0][contactPoint][url]"]  ${supplier_data.data.suppliers[0].contactPoint.url}
  Input Text  xpath=//*[@name="data[suppliers][0][contactPoint][url]"]  http://sfs.gov.ua/
  Input Text  xpath=//*[@name="data[value][amount]"]  ${supplier_data.data.value.amount}
  Wait And Click   xpath=//button[text()="Зберегти"]
  Wait Until Keyword Succeeds  20 x  5 s  Page Should Not Contain Element  xpath=//body[@class="blocked"]
  Wait And Click  xpath=//a[@onclick="modalClose();"]
  Run Keyword If  "${MODE}" == "negotiation"  Run Keywords
  ...  Wait And Click  xpath=//a[@data-bid-action="aply"]
  ...  AND  Wait Until Keyword Succeeds  20 x  1 s  Element Should Be Visible  xpath=//input[@name="data[qualified]"]/..
  ...  AND  Choose File  xpath=//input[@type="file"]  ${document}
  ...  AND  Input Text  xpath=//input[@placeholder="Вкажіть назву докумету"]  ${document.split("/")[-1]}
  ...  AND  Wait And Click  xpath=//button[text()="Додати"]
  ...  AND  Wait Until Keyword Succeeds  20 x  1 s  Element Should Be Visible  xpath=//input[@name="data[qualified]"]/..
  ...  AND  Wait Until Keyword Succeeds  20 x  1 s  Wait And Click  xpath=//input[@name="data[qualified]"]/..
  ...  AND  Wait And Click  xpath=//button[@class="bidAction"]
  ...  AND  Wait Until Keyword Succeeds  20 x  5 s  Page Should Not Contain Element  xpath=//body[@class="blocked"]
  ...  AND  Wait And Click  xpath=//a[@onclick="modalClose();"]
  Wait Until Keyword Succeeds  20 x  3 s  Run Keywords
  ...  Reload Page
  ...  AND  Element Should Be Visible  xpath=//a[contains(text(),'ЕЦП/КЕП')]
  Wait And Click  xpath=//a[contains(text(),'ЕЦП/КЕП')]
  Wait Element Animation  xpath=//a[contains(@class,"tenderSignCommand")]
  Накласти ЕЦП
  Sleep  360


###############################################################################################################
###################################    РЕДАГУВАННЯ ТЕНДЕРУ    #################################################
###############################################################################################################

Внести зміни в тендер
  [Arguments]  ${username}  ${tender_uaid}  ${fieldname}  ${fieldvalue}
  ${fieldvalue}=  Run Keyword If  "${fieldname}" == "maxAwardsCount" or "quantity" in "${fieldname}" or "amount" in "${fieldname}"  Convert To String  ${fieldvalue}
  ...  ELSE  Set Variable  ${fieldvalue}
  Switch Browser  ${username}
  refresh_tender  ${dzo_internal_id}
  Reload Page
  Wait And Click  xpath=//section[@class="content"]/descendant::a[contains(text(), 'Процедура закупівлі')]
  Run Keyword If  "framework_selection" in "${MODE}"  Wait Until Keyword Succeeds  10 x  20 s  Run Keywords
  ...  refresh_tender  ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Element Should Be Visible  xpath=//a[contains(@class, "save")]
  Wait And Click  xpath=//a[contains(@class, "save")]
  Run Keyword If  "items" in "${fieldname}" or "minimalStep" in "${fieldname}"  Wait And Click  xpath=//section[contains(@id, "multiLots")]/a
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

Видалити донора
  [Arguments]  ${username}  ${tender_uaid}  ${funders_index}
  Switch Browser  ${username}
  Wait And Click  xpath=//section[@class="content"]/descendant::a[contains(text(), 'Процедура закупівлі')]
  Wait And Click  xpath=//a[contains(@class, "save")]
  Wait And Click  xpath=//a[@class="search-choice-close"]
  Wait And Click  xpath=//button[@value="save"]

Додати донора
  [Arguments]  ${username}  ${tender_uaid}  ${funders_data}
  Switch Browser  ${username}
  Wait And Click  xpath=//section[@class="content"]/descendant::a[contains(text(), 'Процедура закупівлі')]
  Wait And Click  xpath=//a[contains(@class, "save")]
  Wait And Click  xpath=//input[@value="Визначте організацію-донора"]
  Wait Until Element Is Visible  xpath=//li[text()="${funders_data.name}"]
  Wait Until Keyword Succeeds  5 x  1 s  CLick Element  xpath=//li[text()="${funders_data.name}"]
  Wait And Click  xpath=//button[@value="save"]

Змінити лот
  [Arguments]  ${username}  ${tender_uaid}  ${lot_id}   ${fieldname}  ${fieldvalue}
  ${fieldvalue}=  Run Keyword If  "amount" in "${fieldname}"  add_second_sign_after_point  ${fieldvalue}
  ...  ELSE  Set Variable  ${fieldvalue}
  Switch Browser  ${username}
  Wait And Click  xpath=//a[contains(@class, "save")]
  Wait And Click  xpath=//section[contains(@id, "multiLots")]/a
  Wait And Input Text  ${tender.edit.lot.${fieldname}}  ${fieldvalue}
  Wait And Click  xpath=//button[@value="save"]

Додати неціновий показник на тендер
  [Arguments]  ${username}  ${tender_uaid}  ${feature}
  Wait And Click  xpath=//section[@class="content"]/descendant::a[contains(text(), 'Процедура закупівлі')]
  Wait And Click  xpath=//a[contains(@class, "save")]
  Wait And Click  xpath=(//section[contains(@class, "multiFeatures")]/a)[last()]
  ${index}=  Get Matching Xpath Count  xpath=//a[@class="deleteFeatureItem"]
  ${index}=  Convert To Integer  ${index}
  Wait And Click  xpath=(//section[contains(@class, "multiFeatures")]/descendant::a[@class="addMultiItem"])[last()]
  Add Feature  ${feature}  ${index}
  Wait And Click  xpath=//button[@value="save"]

Видалити неціновий показник
  [Arguments]  ${username}  ${tender_uaid}  ${feature_id}
  Wait And Click  xpath=//section[@class="content"]/descendant::a[contains(text(), 'Процедура закупівлі')]
  Wait And Click  xpath=//a[contains(@class, "save")]
  Wait And Click  xpath=(//section[contains(@class, "multiFeatures")]/a)[last()]
  Wait And Click  xpath=(//input[contains(@value,"${feature_id}")]/ancestor::div[contains(@class,"tenderFeatureItemElement")])[1]/descendant::a[@class="deleteFeatureItem"]
  Підтвердити Дію
  Wait And Click  xpath=//button[@value="save"]

Активувати другий етап
  [Arguments]  ${username}  ${tender_uaid}
  Wait Until Keyword Succeeds  30 x  30 s  Run Keywords
  ...  Reload Page
  ...  AND  Element Should Be Visible  xpath=//a[contains(@class, "save")]
  ${tender_end_date}=  retrieve_date_for_second_stage
  Wait And Click  xpath=//a[contains(@class, "save")]
  Capture Page Screenshot  test_screenshot.png
  Run Keyword And Ignore Error  Wait And Click  xpath=//a[@data-msg="jAlert Close"]
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//div[@id="jAlertBack"]
  Input Date  data[tenderPeriod][endDate]  ${tender_end_date.split(" ")[0]}
  Input Date  tenderPeriod_time  ${tender_end_date.split(" ")[1]}
  Wait And Click  xpath=//button[@value="save"]
  Capture Page Screenshot  test2_screenshot.png
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//div[@id="jAlertBack"]
  Wait And Click  xpath=//a[contains(@class, "save")]
  Run Keyword And Ignore Error  Wait And Click  xpath=//a[@data-msg="jAlert Close"]
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//div[@id="jAlertBack"]
  Wait And Click  xpath=//button[@value="save"]
  Capture Page Screenshot  test2_screenshot.png
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//div[@id="jAlertBack"]

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
  Wait And Click  xpath=//a[@data-msg="jAlert Close"]
#  Wait Until Keyword Succeeds  30 x  1 s  Page Should Not Contain Element  xpath=//div[@id="jAlertBack"]

###############################################################################################################
#############################################    СКАРГИ    ####################################################
###############################################################################################################

Відповісти на вимогу про виправлення умов закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}
  Пошук тендера у разі наявності змін  ${TENDER['LAST_MODIFICATION_DATE']}  ${username}  ${tender_uaid}
  Wait And Click  xpath=(//section[@class="content"]/descendant::a[contains(@href, 'complaints')])[1]
  Wait Until Keyword Succeeds  30 x  10 s  Run Keywords
  ...  refresh_tender  ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Page Should Contain  ${complaintID}
  Wait And Click  xpath=//span[contains(text(), "${complaintID}")]/ancestor::div[contains(@class, "compStatus_claim")]/descendant::a[@class="answerComplaint"]
  Wait And Click  xpath=//input[@value="${answer_data.data.resolutionType}"]/..
  Input Text  xpath=//textarea[@name="resolution"]  ${answer_data.data.resolution}
  Click Element  xpath=//button[@class="bidAction"]
  Wait Until Keyword Succeeds  20 x  1 s  Page Should Not Contain Element  xpath=//textarea[@name="resolution"]
  Wait And Click  xpath=//a[@onclick="modalClose();"]

Створити вимогу про виправлення умов закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${claim}  ${document}=${None}
  ${complaint_id}=  Create Claim  ${claim}  ${None}  ${document}
  [Return]  ${complaint_id}

Створити вимогу про виправлення умов лоту
  [Arguments]  ${username}  ${tender_uaid}  ${claim}  ${lot_id}  ${document}=${None}
  ${complaint_id}=  Create Claim  ${claim}  ${lot_id}   ${document}
  [Return]  ${complaint_id}

Create Claim
  [Arguments]  ${claim}  ${lot_id}=${None}  ${document}=${None}
  ${current_url}=  Get Location
  ${is_on_complaints_page}=  Run Keyword And Return Status  Should Contain  ${current_url}  complaints
  Run Keyword If  not ${is_on_complaints_page}  Wait And Click  xpath=(//section[@class="content"]/descendant::a[contains(@href, 'complaints')])[1]
  Wait And Click  xpath=//a[@class="addComplaint"]
  Підтвердити Дію
  Wait Until Keyword Succeeds  10 x  1 s  Element Should Be Visible  xpath=//form[@name="tender_complaint"]/descendant::input[@name="title"]
  Input Text  xpath=//form[@name="tender_complaint"]/descendant::input[@name="title"]  ${claim.data.title}
  Input Text  xpath=//form[@name="tender_complaint"]/descendant::textarea[@name="description"]  ${claim.data.description}
  Run Keyword If  "${lot_id}" != "${None}"  Select From List By Label Contains Text  xpath=//select[@name="relatedLot"]  ${lot_id}
  Run Keyword If  "${document}" != "${None}"  Run Keywords
  ...  Input Text  xpath=//input[@placeholder="Вкажіть назву докумету"]  ${document.split("/")[-1]}
  ...  AND  Choose File  xpath=//input[@type="file"]  ${document}
  ...  AND  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//div[@id="jAlertBack"]
  ...  AND  Click Element  xpath=//button[contains(@class,"icon_upload")]
  ...  AND  Sleep  5
  Wait And Click  xpath=//button[@class="bidAction"]
  Run Keyword And Ignore Error  Підтвердити Дію
  Wait Until Keyword Succeeds  10 x  5 s  Page Should Not Contain Element  xpath=//form[@name="tender_complaint"]/descendant::input[@name="title"]
  Wait And Click  xpath=//a[@onclick="modalClose();"]
  Wait Until Keyword Succeeds  60 x  20 s  Run Keywords
  ...  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Page Should Not Contain  В процесі публікації
  ${complaint_id}=  Get Text  xpath=(//div[contains(@class,"compStatus_claim")]/descendant::span[3])[last()]
  ${complaint_id}=  convert_compaint_id_to_test_format  ${complaint_id}
  [Return]  ${complaint_id}

Скасувати вимогу про виправлення умов закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${cancellation_data}
  Wait Until Keyword Succeeds  60 x  20 s  Run Keywords
  ...  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Page Should Not Contain  В процесі публікації
  Wait And Click  xpath=//a[@data-complaint-action="cancelled"][last()]
  Підтвердити Дію
  Wait Until Keyword Succeeds  10 x  1 s  Element Should Be Visible  xpath=//textarea[@name="cancellationReason"]
  Input Text  xpath=//textarea[@name="cancellationReason"]  ${cancellation_data.data.cancellationReason}
  Wait And Click  xpath=//button[@class="bidAction"]
  Wait Until Keyword Succeeds  10 x  1 s  Page Should Not Contain Element  xpath=//textarea[@name="cancellationReason"]
  Wait And Click  xpath=//a[@onclick="modalClose();"]

Скасувати вимогу про виправлення умов лоту
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${cancellation_data}
  dzo.Скасувати вимогу про виправлення умов закупівлі  ${username}  ${tender_uaid}  ${complaintID}  ${cancellation_data}

Підтвердити вирішення вимоги про виправлення умов закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${confirmation_data}
  Wait Until Keyword Succeeds  60 x  20 s  Run Keywords
  ...  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Page Should Contain Element  xpath=//a[@data-complaint-action="estimate"]
  Wait And Click  xpath=//a[@data-complaint-action="estimate"]
  Підтвердити Дію
  Wait Until Keyword Succeeds  10 x  1 s  Element Should Be Visible  xpath=//input[@name="estimateType" and @value="resolved_1"]/..
  Click Element  xpath=//input[@name="estimateType" and @value="resolved_1"]/..
  Wait And Click  xpath=//button[@class="bidAction"]
  Wait Until Keyword Succeeds  10 x  1 s  Page Should Not Contain Element  xpath=//textarea[@name="cancellationReason"]
  Wait And Click  xpath=//a[@onclick="modalClose();"]


Відповісти на вимогу про виправлення визначення переможця
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}  ${award_index}
#  Пошук тендера у разі наявності змін  ${TENDER['LAST_MODIFICATION_DATE']}  ${username}  ${tender_uaid}
  refresh_tender  ${dzo_internal_id}
  Reload Page
  Wait And Click  xpath=//a[contains(@href,"award") and contains(@href, "complaints")]
  Wait Until Keyword Succeeds  20 x  1 s  Page Should Contain Element  xpath=//a[@class="answerComplaint"]
  Wait And Click  xpath=//a[@class="answerComplaint"]
  Wait And Click  xpath=//input[@value="${answer_data.data.resolutionType}"]/..
  Input Text  xpath=//textarea[@name="resolution"]  ${answer_data.data.resolution}
  Click Element  xpath=//button[@class="bidAction"]
  Wait Until Keyword Succeeds  20 x  1 s  Page Should Not Contain Element  xpath=//textarea[@name="resolution"]
  Wait And Click  xpath=//a[@onclick="modalClose();"]


Створити вимогу про виправлення визначення переможця
  [Arguments]  ${username}  ${tender_uaid}  ${claim}  ${award_index}  ${document}=${None}
  Wait Until Keyword Succeeds  60 x  20 s  Run Keywords
  ...  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Page Should Contain Element  xpath=//a[contains(@href,"complaints/add")]
  Wait And Click  xpath=//a[contains(@href,"complaints/add")]
  Підтвердити Дію
  Wait Until Keyword Succeeds  10 x  1 s  Element Should Be Visible  xpath=//form[@name="tender_complaint"]/descendant::input[@name="title"]
  Run Keyword If  "${document}" != "${None}"  Run Keywords
  ...  Input Text  xpath=//input[@placeholder="Вкажіть назву докумету"]  ${document.split("/")[-1]}
  ...  AND  Choose File  xpath=//input[@type="file"]  ${document}
  ...  AND  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//div[@id="jAlertBack"]
  ...  AND  Click Element  xpath=//button[contains(@class,"icon_upload")]
  ...  AND  Sleep  5
  Input Text  xpath=//form[@name="tender_complaint"]/descendant::input[@name="title"]  ${claim.data.title}
  Input Text  xpath=//form[@name="tender_complaint"]/descendant::textarea[@name="description"]  ${claim.data.description}
  Run Keyword And Ignore Error  Select From List By Value  xpath=//select[@name="status"]  claim
  Capture Page Screenshot
  Wait And Click  xpath=//button[@class="bidAction"]
  Capture Page Screenshot
  Run Keyword And Ignore Error  Підтвердити Дію
  Capture Page Screenshot
  Wait Until Keyword Succeeds  10 x  5 s  Page Should Not Contain Element  xpath=//form[@name="tender_complaint"]/descendant::input[@name="title"]
  Wait And Click  xpath=//a[@onclick="modalClose();"]
  Wait Until Keyword Succeeds  60 x  20 s  Run Keywords
  ...  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Locator Should Match X Times  xpath=//a[contains(@href,"award") and contains(@href, "complaints")]  2
  Wait And Click  xpath=//a[contains(@href,"award") and contains(@href, "complaints") and not(contains(@href, "add"))]
  Wait Until Keyword Succeeds  10 x  2 s  Page Should Contain Element  xpath=//div[contains(@class,"question")]/div/span[3]
  ${complaint_id}=  Get Text  xpath=(//div[contains(@class,"question")]/div/span[3])[last()]
  ${complaint_id}=  convert_compaint_id_to_test_format  ${complaint_id}
  Run Keyword If  "${document}" != "${None}"  Sleep  60
  [Return]  ${complaint_id}

Підтвердити вирішення вимоги про виправлення визначення переможця
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${confirmation_data}  ${award_index}
  Wait Until Keyword Succeeds  20 x  20 s  Run Keywords
  ...  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Wait And Click  xpath=//a[contains(@href, "award") and contains(@href, "complaints") and not(contains(@href, "add"))]
  ...  AND  Wait Until Keyword Succeeds  10 x  1 s  Page Should Contain  Оскарження кваліфікації
  ...  AND  Page Should Contain Element  xpath=//span[contains(text(), "${complaintID}")]/ancestor::div[contains(@class, "compStatus_")]/descendant::a[@data-complaint-action="estimate"]
  Wait And Click  xpath=//span[contains(text(), "${complaintID}")]/ancestor::div[contains(@class, "compStatus_")]/descendant::a[@data-complaint-action="estimate"]
  Підтвердити Дію
  Wait Until Keyword Succeeds  10 x  1 s  Element Should Be Visible  xpath=//input[@name="estimateType" and @value="resolved_1"]/..
  Click Element  xpath=//input[@name="estimateType" and @value="resolved_1"]/..
  Wait And Click  xpath=//button[@class="bidAction"]
  Wait Until Keyword Succeeds  10 x  1 s  Page Should Not Contain Element  xpath=//textarea[@name="cancellationReason"]
  Wait And Click  xpath=//a[@onclick="modalClose();"]

Скасувати вимогу про виправлення визначення переможця
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${cancellation_data}  ${award_index}
  Wait Until Keyword Succeeds  20 x  20 s  Run Keywords
  ...  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Wait And Click  xpath=//a[contains(@href, "award") and contains(@href, "complaints") and not(contains(@href, "add"))]
  ...  AND  Wait Until Keyword Succeeds  10 x  1 s  Page Should Contain  Оскарження кваліфікації
  ...  AND  Execute Javascript  document.querySelector('.message').scrollTo(0, document.querySelector('.message').scrollHeight)
  ...  AND  Page Should Contain Element  xpath=//span[contains(text(), "${complaintID}")]/ancestor::div[contains(@class, "compStatus_")]/descendant::a[@data-complaint-action="cancelled"]
  Wait And Click  xpath=//span[contains(text(), "${complaintID}")]/ancestor::div[contains(@class, "compStatus_")]/descendant::a[@data-complaint-action="cancelled"]
  Підтвердити Дію
  Wait Until Keyword Succeeds  10 x  1 s  Element Should Be Visible  xpath=//textarea[@name="cancellationReason"]
  Input Text  xpath=//textarea[@name="cancellationReason"]  ${cancellation_data.data.cancellationReason}
  Wait And Click  xpath=//button[@class="bidAction"]
  Wait Until Keyword Succeeds  10 x  3 s  Page Should Not Contain Element  xpath=//textarea[@name="cancellationReason"]
  Wait And Click  xpath=//a[@onclick="modalClose();"]

Створити скаргу про виправлення визначення переможця
  [Arguments]  ${username}  ${tender_uaid}  ${claim}  ${award_index}  ${document}=${None}
  Wait Until Keyword Succeeds  60 x  20 s  Run Keywords
  ...  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Page Should Contain Element  xpath=//a[contains(@href,"complaints/add")]
  Wait And Click  xpath=//a[contains(@href,"complaints/add")]
  Підтвердити Дію
  Wait Until Keyword Succeeds  10 x  1 s  Element Should Be Visible  xpath=//form[@name="tender_complaint"]/descendant::input[@name="title"]
  Run Keyword If  "${document}" != "${None}"  Run Keywords
  ...  Input Text  xpath=//input[@placeholder="Вкажіть назву докумету"]  ${document.split("/")[-1]}
  ...  AND  Choose File  xpath=//input[@type="file"]  ${document}
  ...  AND  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//div[@id="jAlertBack"]
  ...  AND  Click Element  xpath=//button[contains(@class,"icon_upload")]
  ...  AND  Sleep  5
  Input Text  xpath=//form[@name="tender_complaint"]/descendant::input[@name="title"]  ${claim.data.title}
  Input Text  xpath=//form[@name="tender_complaint"]/descendant::textarea[@name="description"]  ${claim.data.description}
  Select From List By Value  xpath=//select[@name="status"]  pending
  Capture Page Screenshot
  Wait And Click  xpath=//button[@class="bidAction"]
  Capture Page Screenshot
  Run Keyword And Ignore Error  Підтвердити Дію
  Capture Page Screenshot
  Wait Until Keyword Succeeds  10 x  5 s  Page Should Not Contain Element  xpath=//form[@name="tender_complaint"]/descendant::input[@name="title"]
  Wait And Click  xpath=//a[@onclick="modalClose();"]
  Wait Until Keyword Succeeds  60 x  20 s  Run Keywords
  ...  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Locator Should Match X Times  xpath=//a[contains(@href,"award") and contains(@href, "complaints")]  2
  Wait And Click  xpath=//a[contains(@href,"award") and contains(@href, "complaints") and not(contains(@href, "add"))]
  Wait Until Keyword Succeeds  10 x  2 s  Page Should Contain Element  xpath=//div[contains(@class,"question")]/div/span[3]
  ${complaint_id}=  Get Text  xpath=(//div[contains(@class,"question")]/div/span[3])[last()]
  ${complaint_id}=  convert_compaint_id_to_test_format  ${complaint_id}
  Sleep  300
  [Return]  ${complaint_id}

###############################################################################################################
#########################################    ПРОПОЗИЦІЇ    ####################################################
###############################################################################################################

Подати цінову пропозицію
  [Arguments]  ${username}  ${tender_uaid}  ${bid}  ${lots_ids}=${None}  ${features_ids}=${None}
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
  Run Keyword And Return If  "${MODE}" == "open_esco"  Send Bid Esco  ${bid}
  ${is_lot}=  Run Keyword And Return Status  Page Should Contain Element  xpath=//input[contains(@name, "lotValues")]
  ${is_self_declaration}=  Run Keyword And Return Status  Page Should Contain Element  xpath=//input[@name="data_competitive[lotValues][0][value][amount]"]/..
  ${amount}=  Set Variable If  ${is_lot}  ${bid.data.lotValues[0].value.amount}  ${bid.data.value.amount}
  ${amount}=  add_second_sign_after_point   ${amount}
  ${locator_pref}=  Set Variable If  ${is_lot}  [lotValues][0]  ${EMPTY}
  Wait And Click  xpath=//a[text()="Процедура закупівлі"]
  Run Keyword If  ${is_self_declaration}  Wait And Click  xpath=//input[@name="data_competitive[lotValues][0][value][amount]"]/..
  ...  ELSE  Run Keywords
  ...  Scroll To Element  name=data${locator_pref}[value][amount]
  ...  AND  Input Text  name=data${locator_pref}[value][amount]  ${amount}
  ${parameter_value}=  Run Keyword If  ${bid.data.has_key("parameters")}  Convert To String  ${bid.data.parameters[0]['value']}
  ${parameter_value}=  Set Variable If  "${parameter_value}" == "0"  0.0  ${parameter_value}
  Run Keyword If  ${bid.data.has_key("parameters")}  Wait And Select From List By Value  name=data[parameters][0][value]  ${parameter_value}
  ${is_self_qualified}=  Run Keyword And Return Status  Page Should Contain Element  xpath=//input[@name="data[selfQualified]"]/..
  Run Keyword If  ${is_self_qualified}  Wait And Click  xpath=//input[@name="data[selfQualified]"]/..
  ${is_self_eligible}=  Run Keyword And Return Status  Page Should Contain Element  xpath=//input[@name="data[selfEligible]"]/..
  Run Keyword If  ${is_self_qualified}  Wait And Click  xpath=//input[@name="data[selfEligible]"]/..
  ${is_bottom}=  Run Keyword And Return Status  Element Should Be Visible  xpath=//div[@id="bottomFixed"]
  Run Keyword If  ${is_bottom}  Click Element  xpath=//a[@class="close icons"]
  Wait And Click  name=do
  Wait And Click  xpath=//a[@data-msg="jAlert Close"]
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//div[@id="jAlertBack"]
  Wait And Click  xpath=//button[@name="pay"]
  Підтвердити дію
  [Return]  ${bid}

Send Bid Esco
  [Arguments]  ${bid}
  ${years}=  Convert To String  ${bid.data.lotValues[0].value.contractDuration.years}
  ${days}=  Convert To String  ${bid.data.lotValues[0].value.contractDuration.days}
  ${yearlyPaymentsPercentage}=  Convert To String  ${bid.data.lotValues[0].value.yearlyPaymentsPercentage * 100}
  Wait And Select From List By Value  name=data[lotValues][0][value][contractDuration][years]  ${years}
  Input Text  xpath=//input[@name="data[lotValues][0][value][contractDuration][days]"]  ${days}
  Input Text  xpath=//input[@name="data[lotValues][0][value][yearlyPaymentsPercentage]"]  ${yearlyPaymentsPercentage}
  ${inputs_counter}=  Get Matching Xpath Count  xpath=//tr[@style="display: table-row;"]/descendant::input[contains(@name, "annualCostsReduction")]
  ${inputs_counter}=  Convert To Integer  ${inputs_counter}
  :FOR  ${index}  IN RANGE  ${inputs_counter}
  \  ${annualCostsReduction}=  Convert To String  ${bid.data.lotValues[0].value.annualCostsReduction[${index}]}
  \  Input Text  xpath=//input[@name="data[lotValues][0][value][annualCostsReduction][${index}]"]  ${annualCostsReduction}
  ${parameter_value}=  Run Keyword If  ${bid.data.has_key("parameters")}  Convert To String  ${bid.data.parameters[0]['value']}
  ${parameter_value}=  Set Variable If  "${parameter_value}" == "0"  0.0  ${parameter_value}
  Run Keyword If  ${bid.data.has_key("parameters")}  Wait And Select From List By Value  name=data[parameters][0][value]  ${parameter_value}
  Wait And Click  xpath=//button[@value="save"]
  Wait And Click  xpath=//a[@data-msg="jAlert Close"]
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//div[@id="jAlertBack"]
  Wait And Click  xpath=//button[@name="pay"]
  Підтвердити дію
  [Return]  ${bid}

Завантажити документ в ставку
  [Arguments]  ${username}  ${path}  ${tender_uaid}  ${doc_name}=documents  ${doc_type}=qualificationDocuments
  ${doc_type}=  Set Variable If  "${doc_type}" == "${None}" or "${doc_type}" == "winningBid"  qualificationDocuments  ${doc_type}
  Wait Until Page Contains  Ваша пропозиція  10
  Wait And Click  xpath=//a[contains(@class,'bidToEdit')]
  Choose File  xpath=/html/body/div[1]/form/input[2]  ${path}
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//div[@id="jAlertBack"]
  Sleep  5
  Run Keyword And Ignore Error  Wait Until Element Is Visible   xpath=//select[@class="documents_url"]
  Run Keyword And Ignore Error  Select From List By Value  xpath=(//select[@class="documents_url"])[last()]  ${doc_type}
  ${is_bottom}=  Run Keyword And Return Status  Element Should Be Visible  xpath=//div[@id="bottomFixed"]
  Run Keyword If  ${is_bottom}  Click Element  xpath=//a[@class="close icons"]
  Wait And Click  xpath=//div[contains(@class,"hide_onBided")]/descendant::button[@value="save"]
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Be Visible  xpath=//div[@class="form sms_sended"]/descendant::input[@name="checkMPhone"]
  Wait And Input Text  xpath=//div[@class="form sms_sended"]/descendant::input[@name="checkMPhone"]  123456789
  Click Element  xpath=//button[@class="bidAction"]
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//div[@id="jAlertBack"]
  Capture Page Screenshot
  Wait Until Keyword Succeeds  30 x  30 s  Run Keywords
  ...  Reload Page
  ...  AND  Wait And Click  xpath=//a[contains(@class, "js-viewBid")]
  ...  AND  Wait Until Keyword Succeeds  20 x  1 s  Page Should Contain Element  xpath=//*[contains(text(),"Інформація про пропозицію учасника")]
  ...  AND  Page Should Not Contain Element  xpath=//div[@data-type="unuploaded"]
  ...  AND  Click Element  xpath=//a[@onclick="modalClose();"]
  ...  AND  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//div[@id="jAlertBack"]


Змінити документ в ставці
  [Arguments]  ${username}  ${tender_uaid}  ${path}  ${doc_id}  ${doc_type}=technicalSpecifications
  Wait Until Page Contains  Ваша пропозиція  10
  Wait And Click  xpath=//a[contains(@class,'bidToEdit')]
  Choose File  xpath=/html/body/div[1]/form/input[2]  ${path}
  Sleep  5
  Run Keyword And Ignore Error  Wait Until Element Is Visible   xpath=//select[@class="documents_url"]
  Run Keyword And Ignore Error  Select From List By Value  xpath=(//select[@class="documents_url"])[last()]  ${doc_type}
  Wait And Click  xpath=//div[contains(@class,"hide_onBided")]/descendant::button[@value="save"]
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Be Visible  xpath=//div[@class="form sms_sended"]/descendant::input[@name="checkMPhone"]
  Input Text  xpath=//div[@class="form sms_sended"]/descendant::input[@name="checkMPhone"]  123456789
  Click Element  xpath=//button[@class="bidAction"]
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//div[@id="jAlertBack"]

Змінити цінову пропозицію
  [Arguments]  ${username}  ${tender_uaid}  ${fieldname}  ${fieldvalue}
  Пошук тендера у разі наявності змін  ${TENDER['LAST_MODIFICATION_DATE']}  ${username}  ${tender_uaid}
  Run Keyword And Return If  "Можливість підтвердити цінову пропозицію після зміни умов" in "${TEST NAME}"  Confirm Invalid Bid
  ${amount}=  add_second_sign_after_point  ${fieldvalue}
  Wait And Click  xpath=//a[text()="Процедура закупівлі"]
  Wait And Click  xpath=//a[contains(@class, "bidToEdit")]
  ${is_lot}=  Run Keyword And Return Status  Page Should Contain Element  xpath=//input[contains(@name, "lotValues")]
  ${locator_pref}=  Set Variable If  ${is_lot}  [lotValues][0]  ${EMPTY}
  Scroll To Element  name=data${locator_pref}[value][amount]
  Input Text  name=data${locator_pref}[value][amount]  ${amount}
  Wait And Click  xpath=//div[contains(@class,"hide_onBided")]/descendant::button[@value="save"]
#  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//div[@id="jAlertBack"]
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Be Visible  xpath=//div[@class="form sms_sended"]/descendant::input[@name="checkMPhone"]
  Input Text  xpath=//div[@class="form sms_sended"]/descendant::input[@name="checkMPhone"]  123456789
  Click Element  xpath=//button[@class="bidAction"]
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//div[@id="jAlertBack"]

Confirm Invalid Bid
  Wait And Click  xpath=//button[contains(@class, "invalidSave")]
  Capture Page Screenshot
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Be Visible  xpath=//div[@class="form sms_sended"]/descendant::input[@name="checkMPhone"]
  Input Text  xpath=//div[@class="form sms_sended"]/descendant::input[@name="checkMPhone"]  123456789
  Capture Page Screenshot
  Click Element  xpath=//button[@class="bidAction"]
  Capture Page Screenshot
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//div[@id="jAlertBack"]
  Capture Page Screenshot

Змінити документацію в ставці
  [Arguments]  ${username}  ${tender_uaid}  ${doc_data}  ${doc_id}
  Wait And Click  xpath=//a[contains(@class, "bidToEdit")]
  Wait And Click  xpath=//input[contains(@value,"${doc_id}")]/ancestor::tr[contains(@class,"docItem")]/descendant::input[@class="confidentialityRationale"]/..
  Wait And Input Text  xpath=//input[contains(@value,"${doc_id}")]/ancestor::tr[contains(@class,"docItem")]/descendant::input[contains(@name,"confidentialityRationale")]  ${doc_data.data.confidentialityRationale}
  Wait And Click  xpath=//button[text()="Зберегти"]
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Be Visible  xpath=//div[@class="form sms_sended"]/descendant::input[@name="checkMPhone"]
  Input Text  xpath=//div[@class="form sms_sended"]/descendant::input[@name="checkMPhone"]  123456789
  Click Element  xpath=//button[@class="bidAction"]
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//div[@id="jAlertBack"]

###############################################################################################################
#########################################    КВАЛІФІКАЦІЯ    ##################################################
###############################################################################################################

Підтвердити кваліфікацію
  [Arguments]  ${username}  ${tender_uaid}  ${qualification_num}
  ${qualification_num}=  Convert To Integer  ${qualification_num}
  Пошук тендера у разі наявності змін  ${TENDER['LAST_MODIFICATION_DATE']}  ${username}  ${tender_uaid}
  Wait And Click  xpath=//div[contains(@class, "qualificationItem tenderLotItemElement awardLotStatus_active")]/descendant::*[text()="${qualification_num * -1 + 1}"]/../descendant::a[@data-bid-action="aply"]
  Wait Until Keyword Succeeds  5 x  1 s  Element Should Be Visible  xpath=//input[@name="data[qualified]"]/..
  Wait And Click  xpath=//input[@name="data[qualified]"]/..
  Wait And Click  xpath=//input[@name="data[eligible]"]/..
  Wait And Click  xpath=//button[@class="bidAction"]
  Wait Until Keyword Succeeds  5 x  1 s  Element Should Be Visible  xpath=//a[@onclick="modalClose();"]
  Wait And Click  xpath=//a[@onclick="modalClose();"]
  Wait Until Keyword Succeeds  20 x  5 s  Run Keywords
  ...  Reload Page
  ...  AND  Page Should Contain Element  xpath=//div[contains(@class, "qualificationItem tenderLotItemElement awardLotStatus_active")]/descendant::*[text()="${qualification_num * -1 + 1}"]/../descendant::a[@data-bid-action="award cancel"]
#  ...  AND  Page Should Contain Element  xpath=(//div[contains(@class," award ")])[${qualification_num * -1 + 1}]/descendant::a[@data-bid-action="award cancel"]

Затвердити остаточне рішення кваліфікації
  [Arguments]  ${username}  ${tender_uaid}
  Wait Until Keyword Succeeds  10 x  5 s  Element Should Be Visible  xpath=//a[@data-bid-action="done"]
  Wait And Click  xpath=//a[@data-bid-action="done"]
  Підтвердити Дію
  Wait Until Keyword Succeeds  20 x  10 s  Run Keywords
  ...  Reload Page
  ...  AND  Page Should Contain Element  xpath=//span[@data-qualificationperiod-enddate]

Перевести тендер на статус очікування обробки мостом
  [Arguments]  ${username}  ${tender_uaid}
  Wait Until Keyword Succeeds  10 x  5 s  Element Should Be Visible  xpath=//a[@data-stage="/stage2"]
  Wait And Click  xpath=//a[@data-stage="/stage2"]
  Підтвердити Дію

Завантажити документ рішення кваліфікаційної комісії
  [Arguments]  ${username}  ${document}  ${tender_uaid}  ${award_num}
  ${index}=  Convert To Integer  ${award_num}
  ${apply_locator}=  Set Variable If  "${MODE}" in "openeu open_competitive_dialogue framework_selection"  xpath=//a[@data-bid-action="aply"]  xpath=//div[@class="num l" and text()="${index + 1}"]/../descendant::a[@data-bid-action="aply"]
  Пошук тендера у разі наявності змін  ${TENDER['LAST_MODIFICATION_DATE']}  ${username}  ${tender_uaid}
  Wait Until Keyword Succeeds  30 x  10 s  Run Keywords
  ...  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Element Should Be Visible  ${apply_locator}
  Wait And Click  ${apply_locator}
  Wait Element Animation  xpath=//input[@placeholder="Вкажіть назву докумету"]
#  Wait Until Keyword Succeeds  10 x  1 s  Element Should Be Visible  xpath=//input[@placeholder="Вкажіть назву докумету"]
  Input Text  xpath=//input[@placeholder="Вкажіть назву докумету"]  ${document.split("/")[-1]}
  Choose File  xpath=//input[@type="file"]  ${document}
  Wait Until Keyword Succeeds  5 x  1 s  Select From List By Value  name=documentType  notice
  Wait And Click  xpath=//div[contains(@class, "buttonAdd")]/div/button
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//*[@id="jAlertBack"]
  Wait Element Animation  xpath=//a[@onclick="modalClose();"]
  Wait And Click  xpath=//a[@onclick="modalClose();"]
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//*[@id="jAlertBack"]

Підтвердити постачальника
  [Arguments]  ${username}  ${tender_uaid}  ${award_num}
  ${index}=  Convert To Integer  ${award_num}
  ${notice_locator}=  Set Variable If  "${MODE}" in "openeu open_competitive_dialogue framework_selection"  xpath=//div[contains(@class,"qualificationItem")]/descendant::a[text()="Повідомлення"]  xpath=//div[@class="num l" and text()="${index + 1}"]/../descendant::a[text()="Повідомлення"]
  Run Keyword If  "${TEST NAME}" == "Неможливість підтвердити постачальника після закінчення періоду кваліфікації"  Sleep  600
  refresh_tender   ${dzo_internal_id}
  Reload Page
  Wait And Click  xpath=//a[@data-bid-action="aply"]
  Wait Until Keyword Succeeds  10 x  1 s  Element Should Be Visible  xpath=//input[@placeholder="Вкажіть назву докумету"]
  Run Keyword And Ignore Error  Click Element  xpath=//input[@name="data[qualified]"]/..
  Run Keyword And Ignore Error  Click Element  xpath=//input[@name="data[eligible]"]/..
  Click Element  xpath=//button[@class="bidAction"]
  Wait Until Page Contains  Рішення по кваліфікації даного учасника прийнято та знаходиться в обробці
  ${is_eds_needed}=  Run Keyword And Return Status  Page Should Contain  Цей документ треба підтвердити ЕЦП.
  Run Keyword If  ${is_eds_needed}  Run Keywords
  ...  Wait Until Keyword Succeeds  10 x  20 s  Дочекатися Кнопки Для Підпису
  ...  AND  Click Element  xpath=(//a[@data-bid-action="aply"])[1]
  ...  AND  Накласти ЕЦП
  Click Element  xpath=//a[@onclick="modalClose();"]
  Wait Until Keyword Succeeds  30 x  10 s  Run Keywords
  ...  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Element Should Be Visible  ${notice_locator}

Дискваліфікувати постачальника
  [Arguments]  ${username}  ${tender_uaid}  ${award_num}
  ${document}=  get_upload_file_path
  Wait Until Keyword Succeeds  10 x  2 s  Element Should Be Visible  xpath=//a[@data-bid-action="cancel"]
  Wait And Click  xpath=//a[@data-bid-action="cancel"]
  Wait Until Keyword Succeeds  20 x  5 s  Element Should Be Visible  xpath=//input[@name="title"]
  Choose File  xpath=//input[@type="file"]  ${document}
  Input Text  xpath=//input[@name="title"]  test
  Wait And Click  xpath=//div[contains(@class, "buttonAdd")]/div/button
  Sleep  5
  Wait And Click  xpath=//input[contains(@data-description,"Учасник не відповідає кваліфікаційним")]/..
  Wait And Click  xpath=//button[@class="bidAction"]
  Підтвердити Дію
  ${is_eds_needed}=  Run Keyword And Return Status  Page Should Contain  Цей документ треба підтвердити ЕЦП.
  Run Keyword If  ${is_eds_needed}  Run Keywords
  ...  Wait Until Keyword Succeeds  10 x  20 s  Дочекатися Кнопки Для Підпису
  ...  AND  Click Element  xpath=(//a[@data-bid-action="cancel"])[1]
  ...  AND  Накласти ЕЦП
  Wait And Click  xpath=//a[@onclick="modalClose();"]
  Wait Until Keyword Succeeds  20 x  5 s  Run Keywords
  ...  Reload Page
  ...  AND  Page Should Contain  Дискваліфіковано

Відхилити кваліфікацію
  [Arguments]  ${username}  ${tender_uaid}  ${qualification_num}
  ${index}=  Convert To Integer  ${qualification_num}
  refresh_tender   ${dzo_internal_id}
  Reload Page
  Wait And Click  xpath=//div[@class="num l" and text()="${index + 1}"]/../descendant::a[@data-bid-action="cancel"]
  Wait And Click  xpath=//input[contains(@data-description,"Учасник не відповідає кваліфікаційним")]/..
  Wait And Click  xpath=//button[@class="bidAction"]
  Wait Element Animation  xpath=//a[@onclick="modalClose();"]
  Wait And Click  xpath=//a[@onclick="modalClose();"]
  Wait Until Keyword Succeeds  10 x  5 s  Run Keywords
  ...  Reload Page
  ...  AND  Page Should Not Contain Element  xpath=//div[@class="num l" and text()="${index + 1}"]/../descendant::a[@data-bid-action="cancel"]

Скасувати кваліфікацію
  [Arguments]  ${username}  ${tender_uaid}  ${qualification_num}
  ${index}=  Convert To Integer  ${qualification_num}
  refresh_tender   ${dzo_internal_id}
  Reload Page
  Wait And Click  xpath=//div[@class="num l" and text()="${index + 1}"]/../descendant::a[@data-bid-action="award cancel"]
  Підтвердити Дію
  Wait Until Keyword Succeeds  10 x  5 s  Run Keywords
  ...  Reload Page
  ...  AND  Page Should Not Contain Element  xpath=//div[@class="num l" and text()="${index + 1}"]/../descendant::a[@data-bid-action="award cancel"]

Дочекатися Кнопки Для Підпису
  Reload Page
  Page Should Contain Element  xpath=//div[contains(@class, "awardActionSign")]

Скасування рішення кваліфікаційної комісії
  [Arguments]  ${username}  ${tender_uaid}  ${award_num}
  Wait And Click  xpath=//a[@data-bid-action="award cancel"]
  Підтвердити Дію

Затвердити постачальників
  [Arguments]  ${username}  ${tender_uaid}
  Wait Until Keyword Succeeds  20 x  30 s  Run Keywords
  ...  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Element Should Be Visible  xpath=//a[@data-bid-action="done"]
  Wait And Click  xpath=//a[@data-bid-action="done"]
  Підтвердити Дію
  Run Keyword If  "${MODE}" == "open_framework"  Sleep  1000

Накласти ЕЦП
#  Wait Until Element Is Visible  xpath=//a[contains(@class, "tenderSignCommand")]
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

###############################################################################################################
##########################################    КОНТРАКТІНГ    ##################################################
###############################################################################################################

Редагувати угоду
  [Arguments]  ${username}  ${tender_uaid}  ${contract_index}  ${fieldname}  ${fieldvalue}
  ${amount}=  add_second_sign_after_point  ${fieldvalue}
  Wait Until Keyword Succeeds  20 x  30 s  Run Keywords
  ...  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Page Should Contain Element  xpath=//a[@data-bid-action="contract"]/..
  Wait And Click  xpath=//a[@data-bid-action="contract"]/..
  Wait Until Keyword Succeeds  10 x  1 s  Element Should Be Visible  xpath=//input[@name="data[value][amount]"]
  Input Text  ${contract.${fieldname}}  ${amount}

Підтвердити підписання контракту
  [Arguments]  ${username}  ${tender_uaid}  ${contract_num}
  ${document}=  get_upload_file_path
  ${is_contract_modal_opened}=  Run Keyword And Return Status  Element Should Be Visible  xpath=//input[@name="data[value][amountNet]"]
  Run Keyword If  not ${is_contract_modal_opened}  Run Keywords
  ...  Page Should Contain Element  xpath=//a[@data-bid-action="contract"]/..
  ...  AND  Wait And Click  xpath=//a[@data-bid-action="contract"]/..
  Wait Until Keyword Succeeds  10 x  1 s  Page Should Contain Element  xpath=//input[@type="file"]
  Choose File  xpath=//input[@type="file"]  ${document}
  Input Text  xpath=//input[@name="title"]  test
  Click Element  xpath=//div[contains(@class, "buttonAdd")]/div/button
  Wait Until Element Is Not Visible  xpath=//*[@id="jAlertBack"]
  Sleep  5
#  Wait Until Keyword Succeeds  5 x  1 s  Run Keywords
#  ...  Element Should Be Visible  xpath=//input[@name="data[contractNumber]"]
#  ...  AND  Input Text  xpath=//input[@name="data[contractNumber]"]  123456
  ${date}=  Run Keyword If  "${MODE}" == "reporting"  retrieve_date_for_second_stage
  ...  ELSE  Get Text  xpath=//span[contains(text(), "Мінімальна можлива дата")]/following-sibling::span
  ${amount_net}=  Get Element Attribute  xpath=//input[@name="data[value][amountNet]"]@value
  ${amount_net}=  Convert To Number  ${amount_net}
  ${amount_net}=  add_second_sign_after_point_with_round  ${amount_net / 1.2}
  Clear Element Text  xpath=//input[@name="data[value][amountNet]"]
  Input Text  xpath=//input[@name="data[value][amountNet]"]  ${amount_net}
  Input Date  data[dateSigned]  ${date.replace(".", "/").split(" ")[0]}
  Input Date  data[period][startDate]  ${date.replace(".", "/").split(" ")[0]}
  Input Date  data[period][endDate]  ${date.replace(".", "/").split(" ")[0]}
  Input Text  xpath=//input[@name="data[contractNumber]"]  123456
  Capture Page Screenshot
  Click Element  xpath=//button[@class="bidAction"]
  Capture Page Screenshot
  Підтвердити дію
  Capture Page Screenshot
  Wait Until Keyword Succeeds  10 x  1 s  Page Should Not Contain Element  ${locator.ModalOK}
  Wait And Click  xpath=//a[@onclick="modalClose();"]
  Wait Until Keyword Succeeds  20 x  20 s  Run Keywords
  ...  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Run Keyword If  "${MODE}" != "reporting"  Page Should Contain Element  xpath=//a[contains(@href, "/contract/documents")]
#  ...  AND  Page Should Contain  Завершена
  ${is_eds_needed}=  Run Keyword And Return Status  Run Keywords
  ...  Wait And Click  xpath=//a[@data-bid-action="contract"]
  ...  AND  Sleep  5
  ...  AND  Page Should Contain  Цей документ необхідно підтвердити ЕЦП.
  Run Keyword If  ${is_eds_needed}  Run Keywords
  ...  Wait Until Keyword Succeeds  10 x  20 s  Дочекатися Кнопки Для Підпису Контракту
#  ...  AND  Click Element  xpath=(//a[@data-bid-action="aply"])[1]
  ...  AND  Накласти ЕЦП
  Run Keyword And Ignore Error  Click Element  xpath=//a[@onclick="modalClose();"]
  Wait Until Keyword Succeeds  20 x  20 s  Run Keywords
  ...  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Page Should Contain  Завершена


Дочекатися Кнопки Для Підпису Контракту
  Reload Page
  Wait And Click  xpath=//a[@data-bid-action="contract"]/..
  Wait Until Page Contains Element  xpath=//a[contains(@class, "tenderSignCommand")]  10

Встановити дату підписання угоди
  [Arguments]  ${username}  ${tender_uaid}  ${contract_index}  ${fieldvalue}
  ${date}=  convert_datetime_to_format  ${fieldvalue}  %d/%m/%Y
  Log  ${date}

Вказати період дії угоди
  [Arguments]  ${username}  ${tender_uaid}  ${contract_index}  ${startDate}  ${endDate}
  ${startDate}=  convert_datetime_to_format  ${startDate}  %d/%m/%Y
  ${endDate}=  convert_datetime_to_format  ${endDate}  %d/%m/%Y
  Log  ${startDate}
  Log  ${endDate}

Завантажити документ в угоду
  [Arguments]  ${username}  ${path}  ${tender_uaid}  ${contract_index}  ${doc_type}=documents
  Log  ${path}


###############################################################################################################
################################################    УГОДИ    ##################################################
###############################################################################################################

Пошук угоди по ідентифікатору
  [Arguments]  ${username}  ${agreement_uaid}  ${save_key}=agreement_data  ${tender_uaid}=${None}
  ${tender_uaid}=  Set Variable If  "${tender_uaid}" == "${None}"  ${agreement_uaid[:-3]}  ${tender_uaid}
  Switch Browser  ${username}
  Run Keyword If  "${TEST NAME}" == "Можливість знайти угоду по ідентифікатору"  Run Keywords
  ...  Sleep  400
  ...  AND  Set Global Variable  ${dzo_internal_id}  ${None}
#  refresh_agreement  ${dzo_internal_id}
  Go To  https://www.stage.dzo.com.ua/tenders/public
  Select From List By Value  xpath=//select[@name="filter[object]"]  tenderID
  Input Text  xpath=//input[@name="filter[search]"]  ${tender_uaid}
  Click Element  xpath=(//button[text()="Пошук"])[1]
  Wait Until Keyword Succeeds  10 x  1 s  Locator Should Match X Times  xpath=//section[contains(@class,"list")]/descendant::div[contains(@class, "item")]/a[contains(@href,"/tenders/")]  1
  Click Element  xpath=//a[contains(@class, "tenderLink")]
  Wait And Click  xpath=//nav[contains(@class,"infoBlock")]/descendant::a[contains(@href, "agreements")]
  ${internal_id}=  Run Keyword If  "${dzo_internal_id}" == "${None}"  Get Text  xpath=//a[@title="Оголошення в ЦБД"]/span
  ...  ELSE  Set Variable  ${dzo_internal_id}
  Set Global Variable  ${dzo_internal_id}  ${internal_id}
#  Run Keyword If  "${SUITE NAME.lower()}" == "qualification" and "${TEST NAME}" == "Можливість знайти закупівлю по ідентифікатору"
#  ...  Wait Until Keyword Succeeds  40 x  30 s  Status Should Be  ${username}  ${tender_uaid}  active.qualification

Отримати інформацію із угоди
  [Arguments]  ${username}  ${agreement_uaid}  ${field_name}
  ${match}=  Get Regexp Matches  ${field_name}  \\[(\\d+)\\]  1
  ${index}=  Convert To Integer  ${match[0]}
  ${field_name}=  Remove String Using Regexp  ${field_name}  \\[(\\d+)\\]
  refresh_agreement  ${dzo_internal_id}
  Reload Page
  ${value}=  Get Text  ${locator.agreement.${field_name}}[${index + 1}]
  ${value}=  convert_agreement  ${value}
  [Return]  ${value}

Встановити ціну за одиницю для контракту
  [Arguments]  ${username}  ${tender_uaid}  ${contract_data}
  ${amount}=  Convert To String  ${contract_data.data.unitPrices[0].value.amount}
  refresh_agreement   ${dzo_internal_id}
  Reload Page
  Wait And Click  xpath=//a[contains(@href, "${contract_data.data.id}") and @data-bid-action="active"]
  Підтвердити Дію
  Wait Element Animation  xpath=//input[@name="data[unitPrices][0][value][amount]"]
  Wait And Input Text  xpath=//input[@name="data[unitPrices][0][value][amount]"]  ${amount}
  Wait And Click  xpath=//button[@class="bidAction"]
  Wait Until Keyword Succeeds  20 x  5 s  Page Should Not Contain Element  xpath=//body[@class="blocked"]
  Wait And Click  xpath=//a[@onclick="modalClose();"]

Зареєструвати угоду
  [Arguments]  ${username}  ${tender_uaid}  ${period}
  refresh_agreement   ${dzo_internal_id}
  Reload Page
  Wait And Click  xpath=//a[@data-bid-question="agreement_active_sure"]
  Підтвердити Дію
  Wait Element Animation  xpath=//input[@name="data[agreementNumber]"]
  ${date}=  Get Text  xpath=//span[contains(text(), "дата підписання угоди")]/following-sibling::span
  ${end_date}=  Add Time To Date  ${date}  8 days  date_format=%d.%m.%Y  result_format=%d/%m/%Y
  Input Date  data[dateSigned]  ${date.replace(".","/")}
  Input Date  data[period][startDate]  ${date.replace(".", "/")}
  Input Date  data[period][endDate]  ${end_date}
#  Input Date  data[period][endDate]  ${date.replace(".", "/")}
  Wait And Input Text  xpath=//input[@name="data[agreementNumber]"]  123456789
  Wait And Click  xpath=//button[@class="bidAction"]
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Not Be Visible  xpath=//*[@id="jAlertBack"]
  Wait And Click  xpath=//a[@onclick="modalClose();"]
  Wait Until Keyword Succeeds  20 x  20 s  Run Keywords
  ...  refresh_tender   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Wait And Click  xpath=//a[@data-bid-question="agreement_active_sure"]
  ...  AND  Підтвердити Дію
  ...  AND  Page Should Contain  Цей документ необхідно підтвердити ЕЦП.
  Накласти ЕЦП
  Sleep  360

Отримати доступ до угоди
  [Arguments]  ${username}  ${agreement_uaid}
  Log  ${agreement_uaid}

Завантажити документ в рамкову угоду
  [Arguments]  ${username}  ${filepath}  ${agreement_uaid}
  Log  ${filepath}

Внести зміну в угоду
  [Arguments]  ${username}  ${agreement_uaid}  ${change_data}
  Wait And Click  xpath=//a[@data-agreement-action="change"]
  Підтвердити Дію
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Be Visible  xpath=//input[@name="data[rationale]"]
  ${date}=  Get Text  xpath=//span[contains(text(), "Дата підписання зміни")]/following-sibling::span
  Input Text  xpath=//input[@name="data[rationale]"]  ${change_data.data.rationale}
  Select From List By Value  xpath=//select[@name="data[rationaleType]"]  ${change_data.data.rationaleType}
  Input Date  data[dateSigned]  ${date.replace(".","/")}
  Wait And Click  xpath=//button[@class="bidAction"]
  Wait Until Keyword Succeeds  20 x  2 s  Page Should Not Contain  Дата підписання зміни до угоди повинна бути не раніше
  Run Keyword If  "${change_data.data.rationaleType}" != "partyWithdrawal"  Wait And Input Text  xpath=//input[contains(@name,"feature[modifications_items]")]  10
  ...  ELSE  Wait And Click  xpath=(//input[contains(@name,"feature[modifications_contracts]")]/..)[1]
  Wait And Click  xpath=//button[@class="bidAction"]
  Wait Until Keyword Succeeds  20 x  5 s  Page Should Not Contain Element  xpath=//body[@class="blocked"]


Оновити властивості угоди
  [Arguments]  ${username}  ${agreement_uaid}  ${data}
  Wait And Click  xpath=//a[@data-agreement-action="change"]
  Підтвердити Дію
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Be Visible  xpath=//input[@name="data[rationale]"]
  Capture Page Screenshot
  Run Keyword If  ${data.data.modifications[0].has_key("addend")}  Select From List By Value  //select[contains(@name,"feature[modifications_items]")]  addend
  ...  ELSE IF  ${data.data.modifications[0].has_key("factor")}  Select From List By Value  //select[contains(@name,"feature[modifications_items]")]  factor
  ...  ELSE IF  ${data.data.modifications[0].has_key("contractId")}  Wait And Click  xpath=(//input[contains(@name,"feature[modifications_contracts]")]/..)[1]
  Capture Page Screenshot
  ${field_value}=  Run Keyword If  ${data.data.modifications[0].has_key("addend")}  add_second_sign_after_point  ${data.data.modifications[0].addend}
  ...  ELSE IF  ${data.data.modifications[0].has_key("factor")}  Evaluate  str((${data.data.modifications[0].factor} - 1) * 100)
#  ${field_value}=  Convert To Integer  ${data.data.modifications[0].addend * 100}
#  ${field_value}=  Convert To String  ${field_value}
  Run Keyword If  ${data.data.modifications[0].has_key("contractId")}  Wait And Click  xpath=//input[@name="feature[modifications_contracts][${data.data.modifications[0].contractId}]"]/..
  ...  ELSE  Wait And Input Text  xpath=//input[contains(@name,"feature[modifications_items]")]  ${field_value}
  Capture Page Screenshot
  Wait And Click  xpath=//button[@class="bidAction"]
  Capture Page Screenshot

Завантажити документ для зміни у рамковій угоді
  [Arguments]  ${username}  ${filepath}  ${agreement_uaid}  ${item_id}
  Wait And Click  xpath=//a[@data-agreement-action="change"]
  Підтвердити Дію
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Be Visible  xpath=//input[@name="data[rationale]"]
  Choose File  xpath=//input[@type="file"]  ${filepath}
  Input Text  xpath=//input[@placeholder="Вкажіть назву докумету"]  ${filepath.split("/")[-1]}
  Wait And Click  xpath=//button[text()="Додати"]
  Wait Until Keyword Succeeds  20 x  5 s  Page Should Not Contain Element  xpath=//body[@class="blocked"]
  Wait And Click  xpath=//button[@class="bidAction"]
  Wait Until Keyword Succeeds  20 x  5 s  Page Should Contain  Дані поточної зміни завантажуються до ЦБД
  Wait And Click  xpath=//a[@onclick="modalClose();"]

Застосувати зміну для угоди
  [Arguments]  ${username}  ${agreement_uaid}  ${dateSigned}  ${status}
  Wait Until Keyword Succeeds  10 x  20 s  Run Keywords
  ...  refresh_agreement   ${dzo_internal_id}
  ...  AND  Reload Page
  ...  AND  Page Should Contain Element  xpath=//a[@data-agreement-action="active"]
  Run Keyword And Return If  "${status}" == "cancelled"  Run Keywords
  ...  Wait And Click  xpath=//a[@data-agreement-action="cancelled"]
  ...  AND  Підтвердити Дію
  ...  AND  Wait Until Keyword Succeeds  20 x  5 s  Page Should Not Contain Element  xpath=//body[@class="blocked"]
  Wait And Click  xpath=//a[@data-agreement-action="active"]
  Підтвердити Дію
  Wait Until Keyword Succeeds  20 x  5 s  Page Should Not Contain Element  xpath=//body[@class="blocked"]



Створити тендер другого етапу
  [Arguments]  ${username}  ${tender_data}
  ${file_path}=  Get Variable Value  ${ARTIFACT_FILE}  artifact.yaml
  ${artifact}=  load_data_from  ${file_path}
  ${tender_uaid}=  Set Variable  ${artifact.tender_uaid}
  dzo.Пошук угоди по ідентифікатору  ${username}  ${tender_uaid}  ${None}  ${tender_uaid}
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
  Wait Until Keyword Succeeds  60 x  1 s  Page Should Contain  Попередній підпис успішно завантажено
  Wait And Click  xpath=//button[text()="Підписати зміни"]
  Wait Until Keyword Succeeds  60 x  1 s  Page Should Contain  Підпис успішно накладено та передано у ЦБД
  Select Window  MAIN
  Wait Until Keyword Succeeds  10 x  20 s  Run Keywords
  ...  Reload Page
  ...  AND  Page Should Contain Element  xpath=//a[text()="Оголосити відбір для закупівлі за рамковою угодою"]
  Wait And Click  xpath=//a[text()="Оголосити відбір для закупівлі за рамковою угодою"]
  Execute Javascript  history.replaceState({}, null, window.location.pathname+'?accelerator=160&submissionMethodDetails=quick');
  Wait And Click  xpath=//button[@value="publicate"]
  Wait Until Keyword Succeeds  20 x  5 s  Page Should Not Contain Element  xpath=//body[@class="blocked"]
  ${tender_uaid}=  Get Text  xpath=//span[@class="js-apiID"]
  [Return]  ${tender_uaid}

#####################################################################################

Підтвердити дію
  Wait Element Animation  ${locator.ModalOK}
  Wait And Click  ${locator.ModalOK}
  Wait Until Keyword Succeeds  10 x  1 s  Element Should Not Be Visible  id=jAlertBack

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
  Wait Until Keyword Succeeds  20 x  1 s  Element Should Be Visible  ${locator}
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

Select From List By Label Contains Text
  [Arguments]  ${locator}  ${element_text}
  ${label}=  Get Text  xpath=//*[contains(text(), "${element_text}")]
  Select From List By Label  ${locator}  ${label}