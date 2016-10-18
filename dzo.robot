*** Settings ***
Library  Selenium2Screenshots
Library  String
Library  DateTime
Library  dzo_service.py

*** Variables ***
${doc_index}                       0
${locator.tenderId}                xpath=//td[contains(text(),'Ідентифікатор закупівлі')]/following-sibling::td[1]
${locator.title}                   xpath=//div[@class='topInfo']/h1
${locator.description}             xpath=//h2[@class='tenderDescr']
${locator.value.amount}            xpath=//section[2]/h3[contains(text(),'Параметри торгів')]/following-sibling::table//tr[1]/td[2]/span[1]
${locator.legalName}               xpath=//td[contains(text(),'Найменування замовника')]/following-sibling::td//span
${locator.minimalStep.amount}      xpath=//td[contains(text(),'Розмір мінімального кроку пониження ціни')]/following-sibling::td/span[1]
${locator.enquiryPeriod.endDate}   xpath=//td[contains(text(),'Дата завершення періоду уточнень')]/following-sibling::td[1]
${locator.tenderPeriod.endDate}    xpath=//td[contains(text(),'Кінцевий строк подання тендерних пропозицій')]/following-sibling::td[1]
${locator.tenderPeriod.startDate}  xpath=//td[contains(text(),'Дата початку прийому пропозицій')]/following-sibling::td[1]
${locator.items.Description}       /tr[1]/td[2]
${locator.items.deliveryAddress.countryName}      /tr[5]/td[2]
${locator.items.deliveryAddress.postalCode}       /tr[5]/td[2]
${locator.items.deliveryAddress.locality}         /tr[5]/td[2]
${locator.items.deliveryAddress.streetAddress}    /tr[5]/td[2]
${locator.items.deliveryAddress.region}           /tr[5]/td[2]
${locator.items.deliveryDate.endDate}             /tr[6]/td[2]
${locator.items.classification.scheme}            /tr[2]/td[1]
${locator.items.classification.id}                /tr[2]/td[2]/span[1]
${locator.items.classification.description}       /tr[2]/td[2]/span[2]
${locator.items.additionalClassifications[0].scheme}        /tr[3]/td[1]
${locator.items.additionalClassifications[0].id}            /tr[3]/td[2]/span[1]
${locator.items.additionalClassifications[0].description}   /tr[3]/td[2]/span[2]
${locator.items.quantity}         /tr[4]/td[2]/span[1]
${locator.items.unit.code}        /tr[4]/td[2]/span[2]
${locator.items.unit.name}        /tr[4]/td[2]/span[2]
${locator.questions.title}        
${locator.questions.description}  /following-sibling::div[@class="text"]
${locator.questions.date}         /preceding-sibling::div[@class="date"]
${locator.questions.answer}       /../following-sibling::div[@class="answer relative"]/div[@class="text"]
${locator.complaint.title}        /descendant::div[@class="title"]
${locator.complaint.description}  /div[1]/div[@class="text"]
${locator.complaint.status}       /div[@class="complaintStatus"]/div[1]
${locator.complaint.complaintID}  /descendant::div[@class="date"]/span[3]
${locator.complaint.resolution}   /div[@class="answer relative"]/div[@class="text"]
${locator.complaint.cancellationReason}   /div[@class="answer relative"]/div[@class="text"]
${locator.bids}                      xpath=//div[@class="qualificationBidAmount"]/span
${locator.currency}                  xpath=//section[2]/h3[contains(text(),'Параметри торгів')]/following-sibling::table//tr[1]/td[2]/span[2]
${locator.tax}                       xpath=//span[@class='taxIncluded']
${locator.procurementMethodType}     xpath=//td[contains(text(),'Процедура закупівлі')]//following-sibling::td/div
${locator.cancellations[0].reason}   xpath=//div[@class="tenderCancelReason bidName"]
${locator.cancellations[0].documents[0].title}   xpath=//span[@class="docTitle"]
${locator.ModalOK}                   xpath=//a[@class="jBtn green"]
${locator.causeDescription}          xpath=//td[contains(text(), 'Обгрунтування')]/following-sibling::td[1]
${locator.cause}                     xpath=//td[contains(text(), 'Підстава')]/following-sibling::td[1]
${locator.procuringEntity.address}   xpath=//td[contains(text(), 'Юридична адреса')]/following-sibling::td[1]
${locator.procuringEntity.contactPoint.name}        xpath=//td[contains(text(), "Ім'я")]/following-sibling::td[1]
${locator.procuringEntity.contactPoint.telephone}   xpath=//td[contains(text(), "Телефон")]/following-sibling::td[1]
${locator.procuringEntity.contactPoint.url}         xpath=//td[contains(text(), "Веб сайт")]/following-sibling::td[1]
${locator.procuringEntity.identifier.id}            xpath=//td[contains(text(), "Код в ЄДРПОУ / ІПН")]/following-sibling::td[1]
${locator.documents.title}       xpath=//tr[${doc_index} + ${1}]//span[@class="docTitle"]
${locator.supplier.address}      xpath=//div[@class="message"]//td[contains(text(), 'Юридична адреса')]/following-sibling::td[1]
${locator.supplier.telephone}    xpath=//div[@class="message"]//td[contains(text(), "Телефон")]/following-sibling::td[1]
${locator.supplier.name}         xpath=//div[@class="message"]//td[contains(text(), "Ім'я")]/following-sibling::td[1]
${locator.supplier.email}        xpath=//div[@class="message"]//td[contains(text(), "E-mail")]/following-sibling::td[1]
${locator.supplier.companyName}  xpath=//div[@class="message"]//td[contains(text(), "Повна назва")]/following-sibling::td[1]
${locator.supplier.id}           xpath=//div[@class="message"]//td[contains(text(), "Код в ЄДРПОУ / ІПН")]/following-sibling::td[1]
${locator.supplier.amount}       xpath=//div[@class="qualificationBidAmount"]/span[1]
${locator.supplier.currency}     xpath=//div[@class="qualificationBidAmount"]/span[2]
${locator.auctionPeriod.startDate}     xpath=//td[contains(text(), 'Дата початку аукціону')]/following-sibling::td[1]
${locator.lots.title}                  /h3/span[3]
${locator.lots.description}            /div[1]
${locator.lots.value.amount}           /descendant::td[contains(text(),'Очікувана вартість')]/../td[2]/span[1]
${locator.lots.value.currency}         /descendant::td[contains(text(),'Очікувана вартість')]/../td[2]/span[2]
${locator.lots.value.valueAddedTaxIncluded}  /descendant::td[contains(text(),'Очікувана вартість')]/../td[2]/span[3]
${locator.lots.minimalStep.amount}     /descendant::td[contains(text(),'Розмір мінімального кроку пониження ціни')]/../td[2]/span[1]
${locator.lots.minimalStep.currency}   /descendant::td[contains(text(),'Розмір мінімального кроку пониження ціни')]/../td[2]/span[2]
${locator.lots.minimalStep.valueAddedTaxIncluded}   /descendant::td[contains(text(),'Очікувана вартість')]/../td[2]/span[3]
${locator.feature.title}               
${locator.feature.description}         /following-sibling::div[@class="featureDescr"]
${locator.feature.code}                /following-sibling::div[@class="featureRelatedItem"]/span[2]             
${locator.feature.featureOf}           
${locator.create_lot.title}            /descendant::td[contains(text(), 'назва частини (лоту)')]/following-sibling::td/div[1]/input
${locator.create_lot.description}      /descendant::td[contains(text(), 'Примітки')]/following-sibling::td/div[1]/input
${locator.create_lot.value.amount}     /descendant::td[contains(text(), 'Очікувана вартість')]/following-sibling::td/div[1]/input
${locator.create_lot.minimalStep.amount}   /descendant::td[contains(text(), 'мінімального кроку')]/following-sibling::td/div[1]/div[1]/div/input


*** Keywords ***
Підготувати дані для оголошення тендера
  [Arguments]  ${username}  ${tender_data}  ${role_name}
  ${tender_data}=   adapt_data_for_role   ${role_name}   ${tender_data}
  [return]  ${tender_data}

Підготувати клієнт для користувача
  [Arguments]  ${username}
  Set Global Variable   ${DZO_MODIFICATION_DATE}   ${EMPTY}
  Run Keyword If   "${USERS.users['${username}'].browser}" == "Firefox"   Створити драйвер для Firefox   ${username}
  ...   ELSE   Open Browser   ${USERS.users['${username}'].homepage}   ${USERS.users['${username}'].browser}   alias=${username}
  Set Window Size   @{USERS.users['${username}'].size}
  Set Window Position   @{USERS.users['${username}'].position}
  Run Keyword If   '${username}' != 'DZO_Viewer'   Login   ${username}
  
Створити драйвер для Firefox
  [Arguments]  ${username}
  ${download_path}=   get_download_file_path
  ${folderList_param}=   Convert To Integer   2
  ${profile}=   Evaluate   sys.modules['selenium.webdriver'].FirefoxProfile()   sys 
  Call Method   ${profile}   set_preference   browser.download.dir   ${OUTPUT_DIR}
  Call Method   ${profile}   set_preference   browser.download.folderList   ${folderList_param}
  Call Method   ${profile}   set_preference   browser.download.manager.showWhenStarting   ${False}
  Call Method   ${profile}   set_preference   browser.download.manager.useWindow   false
  Call Method   ${profile}   set_preference   browser.helperApps.neverAsk.openFile   application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/pdf
  Call Method   ${profile}   set_preference   browser.helperApps.neverAsk.saveToDisk   application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/pdf
  Call Method   ${profile}   set_preference   pdfjs.disabled  ${True}
  Create WebDriver   ${USERS.users['${username}'].browser}   alias=${username}   firefox_profile=${profile}
  Go To   ${USERS.users['${username}'].homepage}

Login
  [Arguments]  ${username}
  Wait Until Page Contains Element   jquery=a[href="/cabinet"]
  Click Element   jquery=a[href="/cabinet"]
  Sleep   1
  Wait Until Page Contains Element   name=email
  Input text   name=email   ${USERS.users['${username}'].login}
  Wait Until Element Is Visible   name=psw
  Input text   name=psw   ${USERS.users['${username}'].password}
  Wait Until Element Is Visible   xpath=//button[contains(@class, 'btn')][./text()='Вхід в кабінет']
  Click Element   xpath=//button[contains(@class, 'btn')][./text()='Вхід в кабінет']

###############################################################################################################
######################################    СТВОРЕННЯ ТЕНДЕРУ    ################################################
###############################################################################################################

Створити тендер
  [Arguments]  ${username}  ${tender_data}
  ${budget}=   add_second_sign_after_point   ${tender_data.data.value.amount}
  ${tax}=   Convert To String   ${tender_data.data.value.valueAddedTaxIncluded}
  ${tax}=   Convert To Lowercase  ${tax}
  Selenium2Library.Switch Browser   ${username}
  Reload Page
  Wait Until Page Contains Element   jquery=a[href="/tenders/new"]   30
  Click Element   jquery=a[href="/tenders/new"]
  Wait Until Page Contains Element   name=data[title]   30
  Run Keyword And Ignore Error   Click Element   xpath=//a[@class="close icons"]
  Run Keyword If   '${mode}' == 'belowThreshold'   Створити допороговий тендер   ${tender_data}
  ...   ELSE IF   'open' in '${mode}'   Створити надпороговий тендер   ${tender_data}
  ...   ELSE   Створити переговорну процедуру   ${tender_data}
  Input Text   name=data[title]   ${tender_data.data.title}
  Input Text   name=data[description]   ${tender_data.data.description} 
  Run Keyword And Ignore Error   Input Text   name=data[value][amount]   ${budget}
  Select From List By Value   name=data[value][currency]   ${tender_data.data.value.currency}
  Select From List By Value   name=data[value][valueAddedTaxIncluded]   ${tax}
  Click Element   xpath= //button[@value='publicate']
  ${status}=   Run Keyword And Return Status   Wait Until Page Contains   Тендер опубліковано
  Run Keyword If   not ${status}   Wait Until Keyword Succeeds   20 min   1 min   Дочекатися публікації тендера
  ${tender_uaid}=   Get Text   ${locator.tenderId}  
  [return]  ${tender_uaid}

Дочекатися публікації тендера
  Reload Page
  Click Element   xpath=//a[./text()='Редагувати']
  Wait Until Element Is Visible   xpath=//button[@value="save"]
  Click Element   xpath=//button[@value="save"]
  Wait Until Element Is Not Visible   xpath=//div[contains(text(),'Чернетка')]

Створити допороговий тендер
  [Arguments]  ${tender_data}
  ${minimalStep}=   add_second_sign_after_point   ${tender_data.data.minimalStep.amount}
  ${meat}=   Evaluate   ${tender_meat} + ${lot_meat} + ${item_meat}
  Execute Javascript   $(".topFixed").remove();
  Wait Until Page Contains Element   name=data[title]   30
  Run Keyword If   ${number_of_lots} > 0 and ${meat} > 0   Select From List   name=tender_type   features_lots
  ...   ELSE IF    ${number_of_lots} < 1 and ${meat} > 0   Select From List   name=tender_type   features
  ...   ELSE IF    ${number_of_lots} > 0 and ${meat} < 1   Select From List   name=tender_type   lots
  Wait Until Element Is Visible   ${locator.ModalOK}
  Click Element   ${locator.ModalOK}
  Wait Until Element Is Not Visible   id=jAlertBack
  Input Date   data[enquiryPeriod][endDate]   ${tender_data.data.enquiryPeriod.endDate}
  Input Date   data[tenderPeriod][endDate]   ${tender_data.data.tenderPeriod.endDate}
  Run Keyword If   ${number_of_lots} == 0   Run Keywords
  ...          Input Text   name=data[minimalStep][amount]   ${minimalStep}
  ...          AND   Click Element   xpath=//section[@id="multiItems"]/a
  ...          AND   Додати багато предметів   ${tender_data}
  ...   ELSE   Run Keywords   Click Element   xpath=//section[@id="multiLots"]/a   AND   Додати багато лотів   ${tender_data}
  Run Keyword If   ${meat} > 0   Додати нецінові критерії   ${tender_data}

Створити надпороговий тендер
  [Arguments]  ${tender_data}
  ${minimalStep}=   add_second_sign_after_point   ${tender_data.data.minimalStep.amount}
  ${tendering_end_date}=   convert_date_to_slash_format   ${tender_data.data.tenderPeriod.endDate}
  ${meat}=   Evaluate   ${tender_meat} + ${lot_meat} + ${item_meat}
  Select From List   name=tender_method   open_${tender_data.data.procurementMethodType}
  Click Element                       ${locator.ModalOK}
  Wait Until Element Is Not Visible   id=jAlertBack
  Wait Until Page Contains Element    name=data[title]                     30
  Run Keyword If   ${number_of_lots} > 0 and ${meat} > 0   Select From List   name=tender_type   features_lots
  ...   ELSE IF    ${number_of_lots} < 1 and ${meat} > 0   Select From List   name=tender_type   features
  ...   ELSE IF    ${number_of_lots} > 0 and ${meat} < 1   Select From List   name=tender_type   lots
  Click Element    ${locator.ModalOK}
  Wait Until Element Is Not Visible   id=jAlertBack
  Run Keyword If   ${number_of_lots} == 0   Run Keywords
  ...      Input Text   name=data[minimalStep][amount]   ${minimalStep}
  ...      AND   Click Element   id=multiItems
  ...      AND   Додати багато предметів   ${tender_data}
  ...   ELSE   Run Keywords   Click Element   id=multiLots   AND   Додати багато лотів   ${tender_data}
  Run Keyword If   ${meat} > 0   Додати нецінові критерії   ${tender_data}
  Run Keyword If   "${mode}" == "openeu"   Run Keywords
  ...   Click Element   xpath=//label[@class="item l relative"][input[@value="en"]]
  ...   AND   Input Text   name=data[title_en]   ${tender_data.data.title_en}
  ...   AND   Input Text   name=data[description_en]    ${tender_data.data.description_en}
  ...   AND   Click Element   xpath=//label[@class="item l relative"][input[@value="uk"]]
  Focus   name=data[tenderPeriod][endDate]
  Execute Javascript   $("input[name|='data[tenderPeriod][endDate]']").removeAttr('readonly');
  Input text   name=data[tenderPeriod][endDate]   ${tendering_end_date}

Створити переговорну процедуру
  [Arguments]  ${tender_data}
  ${title_en}=           Get From Dictionary               ${tender_data.data}     title_en
  ${description_en}=     Get From Dictionary               ${tender_data.data}     description_en
  ${tender_method}=      Catenate   SEPARATOR=             limited_                ${mode}
  Select From List       name=tender_method                ${tender_method}
  Click Element          ${locator.ModalOK}
  Sleep   1
  Run Keyword If         '${mode}' != 'reporting'          Вказати підставу і обгрунтування   ${tender_data}
  Click Element          id=multiItems
  Додати багато предметів         ${tender_data}
  Click Element          xpath=//span[contains(text(),"In English")]
  Input text             name=data[title_en]               ${title_en}
  Input text             name=data[description_en]         ${description_en}
  Click Element          xpath=//span[contains(text(),"Українською")]

Вказати підставу і обгрунтування
  [Arguments]  ${tender_data}
  ${cause}=              Get From Dictionary               ${tender_data.data}     cause
  ${causeDescription}=   Get From Dictionary               ${tender_data.data}     causeDescription
  Click Element          xpath=//div[label[@class='relative']/input[@value="${cause}"]]
  Input text             name=data[causeDescription]       ${causeDescription}

Додати нецінові критерії
  [Arguments]  ${tender_data}
  ${features}=   Get From Dictionary   ${tender_data.data}   features
  ${features_length}=   Get Length   ${features}
  ${tender_feature_index}=   Convert To Integer   -1
  ${lot_feature_index}=   Convert To Integer   -1
  Set Test Variable   ${tender_feature_index}
  Set Test Variable   ${lot_feature_index}
  :FOR   ${index}   IN RANGE   ${features_length}
### Вибір блока для додавання нецінових критеріїв в залежності від медоду закупівлі. Ці гілки необхідні оскільки
### для тендерів з лотами і без них нецінові показники додаються в різних блоках.
  \   ${lot_id}=   Run Keyword If   ${number_of_lots} > 0 and '${features[${index}].featureOf}' != 'tenderer'   Get Lot Title   ${features[${index}].relatedItem}   ${tender_data}
  \   Run Keyword If   ${number_of_lots} > 0 and '${features[${index}].featureOf}' != 'tenderer'   Run Keywords
  ...   Розкрити блок з неціновими показниками лота   ${lot_id}
  ...   AND   Set Test Variable   ${lot_feature_index}   ${lot_feature_index + 1}
  ...   AND   Додати показник   ${features[${index}]}   ${lot_feature_index}   ${tender_data}
  \   Run Keyword If   ${number_of_lots} < 1 or '${features[${index}].featureOf}' == 'tenderer'   Run Keywords
  ...   Click Element   xpath=//section[@id='multiFeatures']/a
  ...   AND   Run Keyword if   ${tender_feature_index} >= 0   Click Element   xpath=//section[@id='multiFeatures']//a[contains(text(), 'Додати критерій')]
  ...   AND   Set Test Variable   ${tender_feature_index}   ${tender_feature_index + 1}
  ...   AND   Додати показник   ${features[${index}]}   ${index}   ${tender_data}
  
Розкрити блок з неціновими показниками лота
  [Arguments]  ${lot_id}
  Execute Javascript   $(".topFixed").remove();
  Capture Page Screenshot
  ${status}=   Run Keyword And Return Status   Element Should Not Be Visible   xpath=//h4[@class="lotTitle"]/span[contains(text(), '${lot_id}')]/../../a
  Run Keyword If   ${status}   Click Element   xpath=//section[@id='multiLots']/a
  ${status}=   Run Keyword And Return Status   Element Should Not Be Visible   xpath=//span[contains(text(), 'Нецінові критерії до лоту')]/following-sibling::span[contains(text(),'${lot_id}')]/../../a
  Run Keyword If   ${status}   Click Element   xpath=//h4[@class="lotTitle"]/span[contains(text(), '${lot_id}')]/../../a
  ${status}=   Run Keyword And Return Status   Element Should Not Be Visible   xpath=//span[contains(text(), 'Нецінові критерії до лоту')]/following-sibling::span[contains(text(),'${lot_id}')]/../..//a[contains(text(), 'Додати критерій')]
  Run Keyword If   ${status}   Click Element   xpath=//span[contains(text(), 'Нецінові критерії до лоту')]/following-sibling::span[contains(text(),'${lot_id}')]/../../a
  Click Element   xpath=//span[contains(text(), 'Нецінові критерії до лоту')]/following-sibling::span[contains(text(),'${lot_id}')]/../..//a[contains(text(), 'Додати критерій')]

Додати показник
  [Arguments]   ${feature}  ${feature_index}  ${tender_data}=${EMPTY}  ${relatedItem}=${EMPTY}
  ${enum_length}=   Get Length   ${feature.enum}
  ${relatedItem}=   Run Keyword If   "${feature.featureOf}" == "item" and '${relatedItem}' == '${EMPTY}'  
  ...   get_relatedItem_description   ${tender_data}   ${feature.relatedItem}
  ...   ELSE   Set Variable   ${relatedItem}
  Input text   name=data[features][${feature_index}][title]   ${feature.title}
  Input text   name=data[features][${feature_index}][description]   ${feature.description}
  Select From List By Value   name=data[features][${feature_index}][featureOf]   ${feature.featureOf}
  Run Keyword If   "${feature.featureOf}" == "item"   Select From List By Label   name=data[features][${feature_index}][relatedItem]   ${relatedItem}
  :FOR   ${index}   IN RANGE   ${enum_length}
  \   Run Keyword if   ${index} != 0   Click Element   xpath=//input[@name="data[features][${feature_index}][title]"]/ancestor::tbody/descendant::a[@class='addFeatureOptItem']
  \   Додати опцію   ${feature.enum[${index}]}   ${index}   ${feature_index}

Додати опцію
  [Arguments]  ${enum}  ${index}  ${feature_index}
  ${enum_value}=   Convert To Integer   ${enum.value * 100}
  Input Text   name=data[features][${feature_index}][enum][${index}][title]   ${enum.title}
  Input Text   name=data[features][${feature_index}][enum][${index}][value]   ${enum_value}
  Wait Until Element Is Not Visible   id=jAlertBack
  
Додати неціновий показник на тендер
  [Arguments]  ${username}  ${tender_uaid}  ${feature}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Click Element   xpath=//a[./text()='Редагувати']
  Wait Until Element Is Visible   id=multiFeatures
  Click Element   id=multiFeatures
  ${feature_index}=   Get Matching Xpath Count   xpath=//div[@class="tenderItemElement tenderFeatureItemElement"]
  Click Element   xpath=//section[@id='multiFeatures']//a[contains(text(), 'Додати критерій')]
  Додати показник   ${feature}   ${feature_index}
  Click Element   xpath=//button[@value="save"]
  
Додати неціновий показник на лот
  [Arguments]  ${username}  ${tender_uaid}  ${feature}  ${lot_id}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Click Element   xpath=//a[./text()='Редагувати']
  Wait Until Page Contains Element   xpath=//section[@id="multiLots"]/descendant::div[@class="tenderItemElement tenderFeatureItemElement"]
  ${feature_index}=   Get Matching Xpath Count   xpath=//section[@id="multiLots"]/descendant::div[@class="tenderItemElement tenderFeatureItemElement"]
  Розкрити блок з неціновими показниками лота   ${lot_id}
  Додати показник   ${feature}   ${feature_index}
  Click Element   xpath=//button[@value="save"]
  
Додати неціновий показник на предмет
  [Arguments]  ${username}  ${tender_uaid}  ${feature}  ${item_id}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  ${status}  ${lot_id}=   Run Keyword And Ignore Error   Get Text   xpath=//span[contains(text(),'${item_id}')]/ancestor::div[contains(@class,'tenderLotItemElement')]/h3/span[3]
  ${relatedItem}=   Get Text   xpath=//td[contains(text(),'${item_id}')]
  Click Element   xpath=//a[./text()='Редагувати']
  ${feature_index}=   Get Matching Xpath Count   xpath=//section[@id="multiLots"]/descendant::div[@class="tenderItemElement tenderFeatureItemElement"]
  Run Keyword If   '${status}' == 'PASS'   Розкрити блок з неціновими показниками лота   ${lot_id.split(':')[0].lower()}
  Додати показник   ${feature}   ${feature_index}   ${EMPTY}   ${relatedItem}
  Click Element   xpath=//button[@value="save"]
  
Видалити неціновий показник
  [Arguments]  ${username}  ${tender_uaid}  ${feature_id}  ${obj_id}=${Empty}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  ${status}  ${elem_title}=   Run Keyword And Ignore Error   Get Text   xpath=//div[contains(text(),'${feature_id}')]/following-sibling::div[@class="featureRelatedItem"]/ancestor::div[contains(@class,'tenderLotItemElement')]/h3/span[3]
  Click Element   xpath=//a[./text()='Редагувати']
  Execute Javascript   $('.blockedId').removeClass('blockedId'); $(".topFixed").remove();
  Run Keyword If   '${elem_title[0]}' in 'LI'   Run Keywords
  ...      Click Element   id=multiLots
  ...      AND   Click Element   xpath=//h4[@class="lotTitle"]/span[contains(text(), '${elem_title.split(':')[0].lower()}')]/../..
  ...      AND   Click Element   xpath=//span[contains(text(), 'Нецінові критерії до лоту')]/following-sibling::span[contains(text(),'${elem_title.split(':')[0].lower()}')]/../..
  ...   ELSE   Run Keywords   Wait Until Element Is Visible   id=multiFeatures
  ...      AND   Click Element   id=multiFeatures
  Wait Until Element Is Visible   xpath=//input[contains(@value, '${feature_id}')]/ancestor::div[@class="tenderItemElement tenderFeatureItemElement"]/descendant::a[@class="deleteFeatureItem"]
  Click Element   xpath=//input[contains(@value, '${feature_id}')]/ancestor::div[@class="tenderItemElement tenderFeatureItemElement"]/descendant::a[@class="deleteFeatureItem"]
  Wait Until Element Is Visible   ${locator.ModalOK}
  Click Element   ${locator.ModalOK}
  Wait Until Element Is Not Visible   id=jAlertBack
  Click Element   xpath=//button[@value="save"]

Додати предмет
  [Arguments]  ${item}
  ${item_description_en}=   Set Variable If   "${mode}" == "openeu"   ${item.description_en} 
  ${unit_name}=   convert_string_from_dict_dzo   ${item.unit.name}
  ${region}=   convert_string_from_dict_dzo   ${item.deliveryAddress.region}
  ${delivery_end_date}=   convert_date_to_slash_format   ${item.deliveryDate.endDate}
  ${index}=   Get Element Attribute   xpath=(//div[@class="tenderItemElement tenderItemPositionElement"])[last()]@data-multiline
  Execute Javascript   $(".topFixed").remove();
  Wait Until Page Contains Element   name=data[items][${index}][description]
  Input text   name=data[items][${index}][description]   ${item.description}
  Input text   name=data[items][${index}][quantity]   ${item.quantity}
  Select From List By Label   name=data[items][${index}][unit_id]   ${unit_name}
  Focus   name=data[items][${index}][quantity]
  Click Element   xpath=//input[@name='data[items][${index}][cpv_id]']/preceding-sibling::a
  Select Frame   xpath=//iframe[contains(@src,'/js/classifications/universal/index.htm?lang=uk&shema=CPV&relation=true')]
  Input text   id=search   ${item.classification.description}
  Wait Until Element Is Visible   xpath=//a[contains(@id,'${item.classification.id.replace('-', '_')}')]
  Click Element   xpath=//a[contains(@id,'${item.classification.id.replace('-', '_')}')]
  Click Element   xpath=//*[@id='select']
  Unselect Frame
  Click Element   xpath=//input[@name='data[items][${index}][dkpp_id]']/preceding-sibling::a
  Select Frame   xpath=//iframe[contains(@src,'/js/classifications/universal/index.htm?lang=uk&shema=ДКПП;ДК015;ДК018;ДК003;NONE&relation=true')]
  Input text   id=search   ${item.additionalClassifications[0].description}
  Wait Until Page Contains   ${item.additionalClassifications[0].id}
  Sleep   1
  Click Element   xpath=//a[contains(text(), '${item.additionalClassifications[0].id} - ${item.additionalClassifications[0].description}')]
  Click Element   xpath=//*[@id='select']
  Unselect Frame
  Select From List By Label   name=data[items][${index}][country_id]   ${item.deliveryAddress.countryName}
  Select From List By Label   name=data[items][${index}][region_id]    ${region}
  Input text   name=data[items][${index}][deliveryAddress][locality]   ${item.deliveryAddress.locality}
  Input text   name=data[items][${index}][deliveryAddress][streetAddress]   ${item.deliveryAddress.streetAddress}
  Input text   name=data[items][${index}][deliveryAddress][postalCode]   ${item.deliveryAddress.postalCode}
### Ввод дати JS-ом зумовлений наявністю атрибута readonly для цього поля і пов’язаними з цим проблемами при вводі кейвордом Input 
### Text для більш ніж одного айтіма 
  Execute Javascript   $("input[name|='data[items][${index}][deliveryDate][endDate]']").val('${delivery_end_date}');
  Run Keyword If   "${mode}" == "openeu"   Run Keywords
  ...   Click Element   xpath=//label[@class="item l relative"][input[@value="en"]]
  ...   AND   Input text   name=data[items][${index}][description_en]   ${item_description_en}
  ...   AND   Click Element   xpath=//label[@class="item l relative"][input[@value="uk"]]

Додати багато предметів
  [Arguments]  ${tender_data}  ${related_lot}=0
  ${items}=   Get From Dictionary   ${tender_data.data}   items
  ${Items_length}=   Get Length   ${items}
  :FOR   ${index}   IN RANGE   ${Items_length}
  \   ${location_index}=   Get Element Attribute   xpath=(//div[@class="tenderItemElement tenderItemPositionElement"])[last()]@data-multiline
  \   ${item_related_lot}=   Set Variable If   '${related_lot}' != '0'   ${items[${index}].relatedLot}   
  \   ${status}=   Run Keyword And Return Status   Textfield Value Should Be   name=data[items][${location_index}][description]   ${EMPTY}
  \   Run Keyword If   '${related_lot}' == '0' or '${related_lot}' == '${item_related_lot}'   Run Keywords
  ...   Run Keyword If   not ${status}   Click Element   jquery=a:contains("Додати предмет закупівлі"):visible
  ...   AND   Додати предмет   ${items[${index}]}

Додати предмет закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${item}
  ${item}=   adapt_one_item   ${item}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Click Element   xpath=//a[./text()='Редагувати']
  Execute Javascript   $(".topFixed").remove();
  Click Element   id=multiItems
  Click Element   xpath=//section[@id="multiItems"]//a[@class="addMultiItem"]
  Додати предмет   ${item}
  Click Element   xpath=//button[@value="save"]
  
Додати предмет закупівлі в лот
  [Arguments]  ${username}  ${tender_uaid}  ${lot_id}  ${item}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Click Element   xpath=//a[@class='button save'][./text()='Редагувати']
  Execute Javascript   $(".topFixed").remove();
  Click Element   id=multiLots 
  Click Element   xpath=//span[contains(text(),'${lot_id}')]/ancestor::div[contains(@class,'tenderLotItemElement')]
  Click Element   xpath=//span[contains(text(),'${lot_id}')]/ancestor::div[contains(@class,'tenderLotItemElement')]/descendant::a[@class="addMultiItem"]
  Додати предмет   ${item}
  Click Button   xpath=//button[@value='save']

Видалити предмет закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${lot_id}=${Empty}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Click Element   xpath=//a[./text()='Редагувати']
  Execute Javascript   $(".topFixed").remove(); $('.blockedId').removeClass('blockedId');
  Run Keyword If   ${number_of_lots} > 0   Run Keywords
  ...   Click Element   id=multiLots
  ...   AND   Click Element   xpath=//span[contains(text(),'${lot_id}')]/ancestor::div[contains(@class,'tenderLotItemElement')]
  Click Element   xpath=//input[contains(@value, '${item_id}')]/ancestor::div[@class="tenderItemElement tenderItemPositionElement"]/descendant::a[@class="deleteMultiItem"]
  Wait Until Element Is Visible   ${locator.ModalOK}
  Click Element   ${locator.ModalOK}
  Wait Until Element Is Not Visible   id=jAlertBack
  Click Element   xpath=//button[@value="save"]

Додати багато лотів
  [Arguments]  ${tender_data}
  ${lots}=           Get From Dictionary   ${tender_data.data}   lots
  ${lots_length}=   Get Length   ${lots}
  : FOR    ${index}    IN RANGE   ${lots_length}
  \   Run Keyword if   ${index} != 0      Click Element    xpath=//a[@class="addMultiItem addMultiLot"]
  \   dzo.Створити лот   DZO_Owner   ${None}   ${lots[${index}]}   ${tender_data}

Створити лот
  [Arguments]  ${username}  ${tender_uaid}  ${lot}   ${tender_data}=${EMPTY}
  ${lot}=   Set Variable If   '${tender_uaid}' != '${None}'   ${lot.data}   ${lot}
  ${value_amount}=   add_second_sign_after_point   ${lot.value.amount}
  ${step_amount}=   add_second_sign_after_point   ${lot.minimalStep.amount}
  ${lot_index}=   Get Matching Xpath Count   xpath=//div[contains(@class, 'tenderLotItemElement')]
  ${lot_index}=   Evaluate   int($lot_index) - 1
  Execute Javascript     $(".topFixed").remove();
  Run Keyword If   '${tender_uaid}' != '${None}'   Run Keywords
  ...   dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  ...   AND    Click Element   xpath=//a[@class='button save'][./text()='Редагувати']
  ...   AND    Click Element   id=multiLots 
  ...   AND    Click Element   xpath=//a[@class="addMultiItem addMultiLot"]
  Input text   name=data[lots][${lot_index}][title]                 ${lot.title}
  Input text   name=data[lots][${lot_index}][description]           ${lot.description}
  Input text   name=data[lots][${lot_index}][value][amount]         ${value_amount}
  Input text   name=data[lots][${lot_index}][minimalStep][amount]   ${step_amount}
  Run Keyword If   '${mode}' == 'openeu'   Run Keywords
  ...   Click Element   xpath=//label[@class="item l relative"][input[@value="en"]]
  ...   AND   Input Text   name=data[lots][${lot_index}][title_en]   ${lot.title}
  ...   AND   Input Text   name=data[lots][${lot_index}][description_en]    ${lot.description}
  ...   AND   Click Element    xpath=//label[@class="item l relative"][input[@value="uk"]]
  Додати багато предметів   ${tender_data}   ${lot.id}
  
Створити лот із предметом закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${lot}  ${item}
  ${value_amount}=   add_second_sign_after_point   ${lot.data.value.amount}
  ${step_amount}=   add_second_sign_after_point   ${lot.data.minimalStep.amount}
  ${lot_index}=   Get Matching Xpath Count   xpath=//div[contains(@class, 'tenderLotItemElement')]
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Click Element   xpath=//a[@class='button save'][./text()='Редагувати']
  Execute Javascript   $(".topFixed").remove();
  Click Element   id=multiLots 
  Click Element   xpath=//a[@class="addMultiItem addMultiLot"] 
  Input text   name=data[lots][${lot_index}][title]   ${lot.data.title}
  Input text   name=data[lots][${lot_index}][description]   ${lot.data.description}
  Input text   name=data[lots][${lot_index}][value][amount]   ${value_amount}
  Input text   name=data[lots][${lot_index}][minimalStep][amount]   ${step_amount}
  Run Keyword If   '${mode}' == 'openeu'   Run Keywords
  ...   Click Element   xpath=//label[@class="item l relative"][input[@value="en"]]
  ...   AND   Input Text   name=data[lots][${lot_index}][title_en]   ${lot.title}
  ...   AND   Input Text   name=data[lots][${lot_index}][description_en]   ${lot.description}
  ...   AND   Click Element   xpath=//label[@class="item l relative"][input[@value="uk"]]
  Додати предмет   ${item}
  Click Button   xpath=//button[@value='save']
  [return]  ${lot}
  
Input Date
  [Arguments]  ${elem_name_locator}  ${date}
  ${date}=   convert_date_to_slash_format   ${date}
  Focus   name=${elem_name_locator}
  Execute Javascript   $("input[name|='${elem_name_locator}']").removeAttr('readonly'); $("input[name|='${elem_name_locator}']").unbind();
  Input Text  ${elem_name_locator}  ${date}  

#############################################################################################################

Завантажити документ
  [Arguments]  ${username}  ${filepath}  ${tender_uaid}
  Пошук тендера в Мої Закупівлі   ${username}   ${tender_uaid}
  Wait Until Element Is Visible   xpath=//a[contains(text(),'Редагувати')]
  Click Element   xpath=//a[contains(text(),'Редагувати')]
  Wait Until Element Is Visible   xpath=//h3[contains(text(),'Тендерна документація')]/following-sibling::a
  Click Element   xpath=//h3[contains(text(),'Тендерна документація')]/following-sibling::a  
  Execute Javascript    $('body > div').attr('style', '');
  Choose File   xpath=//div[1]/form/input[@name="upload"]  ${filepath}
  Wait Until Element Is Visible   xpath=//div[@style="display: block;"]/descendant::input[@value="${filepath.split('/')[-1]}"]
  Input Text   xpath=//div[@style="display: block;"]/descendant::input[@value="${filepath.split('/')[-1]}"]   ${filepath.replace('/tmp/', '')}
  Click Button   xpath=//button[@value='save']
  # Сліп необхідний для корректної роботи з загруженим файлом користувачами Квінти, оскільки завантаження фалу у ЦБД може сягати 3-4 хвилин. 
  Sleep   180

Завантажити документ в лот
  [Arguments]  ${username}  ${filepath}  ${tender_uaid}  ${lotID}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Click Element   xpath=//a[contains(text(),'Редагувати')]
  Wait Until Element Is Visible   //section[@id="multiLots"]/a
  Click Element   //section[@id="multiLots"]/a
  Execute Javascript   $(".topFixed").remove();
  Click Element   xpath=//span[contains(text(), '${lotID}')]/preceding-sibling::span[contains(text(), 'Тендерна документація до лоту')]/../../a
#  Execute Javascript   var lot=$('.tenderLotItemElement span.lotNameText:contains(${lotID})').parents('.tenderLotItemElement:first');$($('.uploadFile',lot)[0].upclick.fileinput).attr('tid','${lotID}'); $('input[tid]').parent().parent().css({height: "20px", width: "40px"});
  Focus   xpath=//span[contains(text(), '${lotID}')]/preceding-sibling::span[contains(text(), 'Тендерна документація до лоту')]/../../descendant::a[@class="uploadFile"]
  Get Element Attribute   xpath=//body/div[3]@style
  Choose File   xpath=//div[contains(@style,'width: 40px; height: 80px;')]/descendant::input[@type='file']    ${filepath}
  Wait Until Element Is Visible   xpath=//div[@style="display: block;"]/descendant::input[@value="${filepath.split('/')[-1]}"]
  Input Text   xpath=//div[@style="display: block;"]/descendant::input[@value="${filepath.split('/')[-1]}"]   ${filepath.replace('/tmp/', '')}
  Click Button   xpath=//button[@value='save']
  # Сліп необхідний для корректної роботи з загруженим файлом користувачами Квінти, оскільки завантаження фалу у ЦБД може сягати 3-4 хвилин. 
  Sleep   180

Пошук тендера по ідентифікатору
  [Arguments]  ${username}  ${tender_uaid}
  Switch browser   ${username}
  Go To   ${USERS.users['${username}'].homepage}
  Wait Until Page Contains   Держзакупівлі.онлайн   10
  Click Element   xpath=//a[text()='Закупівлі']
  Wait Until Element Is Visible   xpath=//a[@href='/tenders/all']
  Click Element   xpath=//a[@href='/tenders/all']
  Wait Until Page Contains Element   xpath=//select[@name='filter[object]']/option[@value='tenderID']
  Click Element   xpath=//select[@name='filter[object]']/option[@value='tenderID']
  Input text   xpath=//input[@name='filter[search]']   ${tender_uaid}
  Focus   name=filter[search2]
  Click Element   xpath=//button[@class='btn not_toExtend'][./text()='Пошук']
  Wait Until Page Contains   ${tender_uaid}   10
  Click Element   xpath=//span[contains('${tender_uaid}', text()) and contains(text(), '${tender_uaid}')]/../preceding-sibling::h2/a
  Wait Until Page Contains    ${tender_uaid}


###############################################################################################################
###########################################    ПИТАННЯ    #####################################################
###############################################################################################################

Задати запитання на тендер
  [Arguments]  ${username}  ${tender_uaid}  ${question}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Click Element   xpath=//section[@class="content"]/descendant::a[contains(@href, 'questions')]
  Wait Until Element Is Visible   xpath=//form[@id="question_form"]/descendant::input[@name="title"]
  Execute Javascript   window.scroll(2500,2500)
  Input Text   xpath=//form[@id="question_form"]/descendant::input[@name="title"]   ${question.data.title}
  Input Text   xpath=//form[@id="question_form"]/descendant::textarea[@name="description"]   ${question.data.description}
  Click Element   xpath=//button[contains(text(), 'Надіслати запитання')]
  
Задати запитання на предмет
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${question}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Click Element   xpath=//section[@class="content"]/descendant::a[contains(@href, 'questions')]
  Wait Until Element Is Visible   xpath=//form[@id="question_form"]/descendant::input[@name="title"]
  Execute Javascript   window.scroll(2500,2500)
  Input Text   xpath=//form[@id="question_form"]/descendant::input[@name="title"]   ${question.data.title}
  Select From List By Value   name=questionOf   item
  ${item_option}=   Get Text   //option[contains(text(), '${item_id}')]
  Select From List By Label   name=relatedItem   ${item_option}
  Input Text   xpath=//form[@id="question_form"]/descendant::textarea[@name="description"]   ${question.data.description}
  Click Element   xpath=//button[contains(text(), 'Надіслати запитання')]
  
Задати запитання на лот
  [Arguments]  ${username}  ${tender_uaid}  ${lot_id}  ${question}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Click Element   xpath=//section[@class="content"]/descendant::a[contains(@href, 'questions')]
  Wait Until Element Is Visible   xpath=//form[@id="question_form"]/descendant::input[@name="title"]
  Execute Javascript   window.scroll(2500,2500)
  Input Text   xpath=//form[@id="question_form"]/descendant::input[@name="title"]   ${question.data.title}
  Select From List By Value   name=questionOf   lot
  ${lot_option}=   Get Text   //option[contains(text(), '${lot_id}')]
  Select From List By Label   name=relatedItem   ${lot_option}
  Input Text   xpath=//form[@id="question_form"]/descendant::textarea[@name="description"]   ${question.data.description}
  Click Element   xpath=//button[contains(text(), 'Надіслати запитання')]
  
Відповісти на запитання
  [Arguments]  ${username}  ${tender_uaid}  ${answer_data}  ${question_id}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Click Element   xpath=//section[@class="content"]/descendant::a[contains(@href, 'questions')]
  Wait Until Element Is Visible   xpath=//div[contains(text(), '${question_id}')]/../following-sibling::div/descendant::textarea[@name="answer"]  
  Execute Javascript   window.scroll(2500,2500)
  Input Text   xpath=//div[contains(text(), '${question_id}')]/../following-sibling::div/descendant::textarea[@name="answer"]   ${answer_data.data.answer}
  Click Element   xpath=//button[contains(text(), 'Опублікувати відповідь')]

###############################################################################################################
##########################################   СКАРГИ ТА ВИМОГИ   ###############################################
###############################################################################################################

Створити вимогу про виправлення умов закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${claim}  ${document}=${None}
  ${complaintID}=   Створити вимогу про виправлення   ${username}   ${tender_uaid}   ${claim}   ${document}
  [return]  ${complaintID}
  
Створити вимогу про виправлення умов лоту
  [Arguments]  ${username}  ${tender_uaid}  ${claim}  ${lot_index}  ${document}=${None}
  ${complaintID}=   Створити вимогу про виправлення   ${username}   ${tender_uaid}   ${claim}   ${document}   ${lot_index}
  [return]  ${complaintID}
   
Перетворити вимогу про виправлення умов закупівлі в скаргу
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${escalating_data}
  Перетворити вимогу в скаргу   ${username}   ${tender_uaid}   ${complaintID}   ${escalating_data}
  
Перетворити вимогу про виправлення умов лоту в скаргу
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${escalating_data}
  Перетворити вимогу в скаргу   ${username}   ${tender_uaid}   ${complaintID}   ${escalating_data}
  
Скасувати вимогу про виправлення умов закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${cancellation_data}
  Скасувати вимогу   ${username}   ${tender_uaid}   ${complaintID}   ${cancellation_data}

Скасувати вимогу про виправлення умов лоту
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${cancellation_data}
  Скасувати вимогу   ${username}   ${tender_uaid}   ${complaintID}   ${cancellation_data}

Відповісти на вимогу про виправлення умов закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}
  Відповісти на вимогу   ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}
  
Відповісти на вимогу про виправлення умов лоту
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}
  Відповісти на вимогу   ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}
  
Скасувати вимогу
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${cancellation_data}
  ${claim_location}=   Set Variable   //span[contains(text(), '${complaintID}')]/ancestor::div[contains(@class, "compStatus")]
  dzo.Пошук тендера по ідентифікатору    ${username}   ${tender_uaid}
  Click Element   xpath=//section[@class="content"]/descendant::a[contains(@href, 'complaints')]
  Wait Until Element Is Visible   xpath=${claim_location}/descendant::a[@data-complaint-action="cancelled"]
  Click Element   xpath=${claim_location}/descendant::a[@data-complaint-action="cancelled"]
  Wait Until Element Is Visible   ${locator.ModalOK}
  Click Element   ${locator.ModalOK}
  Wait Until Element Is Visible   name=cancellationReason
  Input Text   name=cancellationReason   ${cancellation_data.data.cancellationReason}
  Wait Until Element Is Not Visible   id=jAlertBack
  Click Element   xpath=//button[contains(text(), 'Зберегти')]
  
Створити вимогу про виправлення
  [Arguments]  ${username}  ${tender_uaid}  ${claim}  ${document}=${None}  ${lot_index}=${None}
  dzo.Пошук тендера по ідентифікатору    ${username}   ${tender_uaid}
  Click Element   xpath=//section[@class="content"]/descendant::a[contains(@href, 'complaints')]
  Wait Until Page Contains Element   xpath=//a[@class="addComplaint"]
  Click Element   xpath=//a[@class="addComplaint"]
  Wait Until Page Contains Element   ${locator.ModalOK}
  Sleep   1
  Click Element   ${locator.ModalOK}
  Wait Until Page Contains  Вимога учасника   10
  Run Keyword If   '${lot_index}' != '${None}'   Select From List By Index   name=relatedLot   1
  Input Text                xpath=//form[@name='tender_complaint']/descendant::input[@name='title']   ${claim.data.title}   
  Input Text                xpath=//textarea[@name='description']   ${claim.data.description}
  Run Keyword IF   '${document}' != '${None}'   Run Keywords
  ...   Input Text          xpath=//input[@placeholder="Вкажіть назву докумету"]   ${document.split('/')[2]}
  ...   AND   Execute Javascript   $("input[name|='upload']").css({height: "20px", width: "40px"});
  ...   AND   Choose File   name=upload   ${document}
  ...   AND   Wait Until Element Is Visible   xpath=//button[contains(text(), 'Додати')]
  ...   AND   Click Element   xpath=//button[contains(text(), 'Додати')]
  Wait Until Page Contains Element   xpath=//span[@class="docTitle"]   60
  Capture Page Screenshot
  Execute Javascript        $('.info').css('height', '550px');
  Click Element             xpath=//button[contains(text(), 'Зберегти')]
  Capture Page Screenshot
  Wait Until Keyword Succeeds   20 x   10 s   Дочекатися публікації вимоги
  Wait Until Page Contains Element   xpath=//div[@id="complaints"]/descendant::div[@class="date"][last()-2]/span[3]
  ${complaintID}=   Get Text   xpath=//div[@id="complaints"]/descendant::div[@class="date"][last()-2]/span[3]
  [return]  ${complaintID}
  
Дочекатися публікації вимоги
  Reload Page
  Wait Until Page Contains   На розгляді   5
  
Перетворити вимогу в скаргу
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${escalating_data}
  ${claim_location}=   Set Variable   //span[contains(text(), '${complaintID}')]/ancestor::div[contains(@class, "compStatus")]
  dzo.Пошук тендера по ідентифікатору    ${username}   ${tender_uaid}
  Click Element   xpath=//section[@class="content"]/descendant::a[contains(@href, 'complaints')]
  Sleep  2
  Click Element   xpath=${claim_location}/descendant::a[@data-complaint-action="estimate"]
  Wait Until Element Is Visible   ${locator.ModalOK}
  Click Element   ${locator.ModalOK}
  Wait Until Element Is Not Visible   id=jAlertBack
  Wait Until Element Is Visible   xpath=//input[@value="pending"]/following-sibling::span
  Click Element   xpath=//input[@value="pending"]/following-sibling::span
  Click Element   xpath=//button[contains(text(), 'Зберегти')]
  
Відповісти на вимогу
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}
  ${claim_location}=   Set Variable   //span[contains(text(), '${complaintID}')]/ancestor::div[contains(@class, "compStatus")]
  dzo.Пошук тендера по ідентифікатору    ${username}   ${tender_uaid}
  Click Element   xpath=//section[@class="content"]/descendant::a[contains(@href, 'complaints')]
  Дочекатися появи вимоги для відповіді   ${complaintID}
  Click Element   xpath=${claim_location}/descendant::a[@class="answerComplaint"]
  Wait Until Element Is Visible   xpath=//input[@value="${answer_data.data.resolutionType}"]/following-sibling::span
  Click Element   xpath=//input[@value="${answer_data.data.resolutionType}"]/following-sibling::span   
  Input Text   name=resolution   ${answer_data.data.resolution}
  Click Element   xpath=//button[@class="bidAction"]
  
Дочекатися появи вимоги для відповіді
  [Arguments]  ${complaintID}
  Reload Page
  Wait Until Page Contains   ${complaintID}
  
###############################################################################################################
###################################    ВНЕСЕННЯ ЗМІН У ТЕНДЕР   ###############################################
###############################################################################################################

Внести зміни в тендер
  [Arguments]  ${username}  ${tender_uaid}  ${fieldname}  ${fieldvalue}
  ${field_locator}=   get_field_locator   ${fieldname}
  ${fieldvalue}=   adapt_data_for_document   ${fieldname}   ${fieldvalue}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Click Element   xpath=//a[@class='button save'][./text()='Редагувати']
  sleep   1
  Run Keyword If   '${fieldname}' != 'tenderPeriod.endDate'   Input Text   ${field_locator}   ${fieldvalue}
  ...   ELSE   Execute Javascript   $("input[name|='data[tenderPeriod][endDate]']").attr('value', '${fieldvalue}');
  sleep   1
  Click Element   xpath=//button[@value='save']

Змінити лот
  [Arguments]  ${username}  ${tender_uaid}  ${lot_id}   ${fieldname}  ${fieldvalue}
  ${fieldvalue}=   add_second_sign_after_point   ${fieldvalue}
  Selenium2Library.Switch Browser   ${username}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Click Element   xpath=//a[@class='button save'][./text()='Редагувати']
  Wait Until Element Is Visible   id=multiLots
  Click Element   id=multiLots
  Click Element   xpath=//h4[@class="lotTitle"]/span[contains(text(), '${lot_id}')]/../..
  Clear Element Text   xpath=//h4[@class="lotTitle"]/span[contains(text(), '${lot_id}')]/../..${locator.create_lot.${fieldname}}
  Input Text   xpath=//h4[@class="lotTitle"]/span[contains(text(), '${lot_id}')]/../..${locator.create_lot.${fieldname}}   ${fieldvalue}
  Click Element   xpath=//button[@value='save']
  Wait Until Page Contains   Зміни збережено, дані в ЦБД оновлено   10

###############################################################################################################

Оновити сторінку з тендером
  [Arguments]  ${username}  ${tender_uaid}
  Selenium2Library.Switch Browser   ${username}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Reload Page

###############################################################################################################
###################################    ПЕРЕВІРКА ВІДОБРАЖЕННЯ   ###############################################
###############################################################################################################

Пошук тендера у разі наявності змін
  [Arguments]  ${last_mod_date}  ${username}  ${tender_uaid}
  ${status}=   Run Keyword And Return Status   Should Not Be Equal   ${DZO_MODIFICATION_DATE}   ${last_mod_date}
  Run Keyword If   ${status}   dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Set Global Variable   ${DZO_MODIFICATION_DATE}   ${last_mod_date}

Отримати інформацію із предмету
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${field_name}
  Пошук тендера у разі наявності змін   ${TENDER['LAST_MODIFICATION_DATE']}   ${username}   ${tender_uaid}
 # dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  ${item_value}=   Get Text   xpath=//td[contains(text(), '${item_id}')]/../..${locator.items.${field_name}}
  ${item_value}=   adapt_items_data   ${field_name}   ${item_value}
  [return]  ${item_value}
  
Отримати інформацію із лоту
  [Arguments]  ${username}  ${tender_uaid}  ${lot_id}  ${field_name}
  Пошук тендера у разі наявності змін   ${TENDER['LAST_MODIFICATION_DATE']}   ${username}   ${tender_uaid}
#  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Execute Javascript   $('h3').css('text-transform', 'inherit');
  ${lot_value}=   Get Text   xpath=//span[contains(text(), '${lot_id}')]/../..${locator.lots.${field_name}}
  ${lot_value}=   adapt_lot_data   ${field_name}   ${lot_value}
  [return]  ${lot_value}

Отримати інформацію із нецінового показника
  [Arguments]  ${username}  ${tender_uaid}  ${feature_id}  ${field_name}
  Пошук тендера у разі наявності змін   ${TENDER['LAST_MODIFICATION_DATE']}   ${username}   ${tender_uaid}
#  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  ${feature_type}=   Get Element Attribute   xpath=//div[contains(text(), '${feature_id}')]/following-sibling::div[2]@class
  ${feature_value}=   Run Keyword If   '${field_name}' != 'featureOf'   Get Text   xpath=//div[contains(text(), '${feature_id}')]${locator.feature.${field_name}}
  ...   ELSE IF   '${feature_type}' == 'featureRelatedItem'   Get Text   xpath=//div[contains(text(), '${feature_id}')]/following-sibling::div[2]/span[1]
  ...   ELSE   Set Variable   tenderer
  ${feature_value}=   convert_string_from_dict_dzo   ${feature_value}
  [return]  ${feature_value}

Отримати інформацію із запитання
  [Arguments]  ${username}  ${tender_uaid}  ${question_id}  ${field_name}
  Пошук тендера у разі наявності змін   ${TENDER['LAST_MODIFICATION_DATE']}   ${username}   ${tender_uaid}
 # dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Execute Javascript   window.scroll(2500,2500); $(".topFixed").remove();
  Click Element   xpath=//section[@class="content"]/descendant::a[contains(@href, 'questions')]
  Wait Until Element Is Visible   xpath=//div[@id='questions']
  Wait Until Keyword Succeeds   15 x   20 s   Дочекатися відображення запитання на сторінці  ${question_id} 
  ${question_value}=   Get Text   xpath=//div[contains(text(), '${question_id}')]${locator.questions.${field_name}}
  [return]  ${question_value}
  
Дочекатися відображення запитання на сторінці
  [Arguments]  ${text_for_view}
  Reload Page
  Wait Until Page Contains   ${text_for_view}

Отримати інформацію із скарги
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${field_name}  ${award_index}=${None}
  Пошук тендера у разі наявності змін   ${TENDER['LAST_MODIFICATION_DATE']}   ${username}   ${tender_uaid}
 # dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Execute Javascript   window.scroll(2500,2500); $(".topFixed").remove();
  Click Element   xpath=//section[@class="content"]/descendant::a[contains(@href, 'complaints')]
  Wait Until Keyword Succeeds   15 x   20 s   Дочекатися відображення скарги на сторінці   ${complaintID}
  Capture Page Screenshot
  ${class_incl}=   Get Element Attribute   xpath=//span[contains(text(), '${complaintID}')]/../../..@class
  ${status}=   get_claim_status   ${class_incl}
  ${value}=   Get Text   xpath=//span[contains(text(), '${complaintID}')]/../../..${locator.complaint.${field_name}}
  ${complaint_value}=   Set Variable If   '${field_name}' == 'status'    ${status}   ${value}
  Execute Javascript   $('.back').click();
  [return]  ${complaint_value}
  
Отримати поле документації до скарги
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${document_id}  ${field_name}  ${award_index}=${None}
  Пошук тендера у разі наявності змін   ${TENDER['LAST_MODIFICATION_DATE']}   ${username}   ${tender_uaid}
#  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Execute Javascript   $(".topFixed").remove();
  Click Element   xpath=//section[@class="content"]/descendant::a[contains(@href, 'complaints')]
  Wait Until Keyword Succeeds   15 x   20 s   Дочекатися відображення скарги на сторінці   ${complaintID} 
  Click Element   xpath=//span[contains(text(), '${complaintID}')]/../../../descendant::a[@class="viewDocs"]
  Wait Until Page Contains Element   xpath=//span[@class="docTitle"]
  ${doc_title}=   Get Text   xpath=//span[@class="docTitle"]
  Execute Javascript   $('.back').click();
  [return]  ${doc_title}
  
Отримати документ до скарги
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${doc_id}
  ${value}=   dzo.Отримати інформацію із документа до скарги   ${username}   ${tender_uaid}   ${complaintID}   ${doc_id}   doc_content
  [return]  ${value}
  
Отримати інформацію із документа до скарги
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${doc_id}  ${field_name}
  Пошук тендера у разі наявності змін   ${TENDER['LAST_MODIFICATION_DATE']}   ${username}   ${tender_uaid}
  Execute Javascript   $(".topFixed").remove();
  Click Element   xpath=//section[@class="content"]/descendant::a[contains(@href, 'complaints')]
  Wait Until Keyword Succeeds   15 x   20 s   Дочекатися відображення скарги на сторінці   ${complaintID} 
  Click Element   xpath=//span[contains(text(), '${complaintID}')]/../../../descendant::a[@class="viewDocs"]
  Wait Until Page Contains Element   xpath=//span[@class="docTitle"]
  ${value}=   Run Keyword If   "${field_name}" == "title"   Get Text   xpath=//span[@class="docTitle"]
  ...   ELSE   dzo.Отримати документ   ${username}   ${tender_uaid}   ${doc_id}
  Execute Javascript   $('.back').click();
  [return]  ${value.split('/')[-1]}
  
Дочекатися відображення скарги на сторінці
  [Arguments]  ${text_for_view}
  Reload Page
  Execute Javascript   $(".topFixed").remove();
  Click Element   xpath=//section[@class="content"]/descendant::a[contains(@href, 'complaints')]
  Wait Until Page Contains   ${text_for_view}

Отримати документ
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}
  Пошук тендера у разі наявності змін   ${TENDER['LAST_MODIFICATION_DATE']}   ${username}   ${tender_uaid}
 # dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Execute Javascript   $(".topFixed").remove();
  ${file_name}=   Get Text   xpath=//span[contains(text(),'${doc_id}')]
  ${url}=   Get Element Attribute   xpath=//span[contains(text(),'${doc_id}')]/..@href
  dzo_download_file   ${url}  ${file_name.split('/')[-1]}  ${OUTPUT_DIR}
 # Click Element   xpath=//span[contains(text(),'${doc_id}')]
 # Wait Until Keyword Succeeds   10 x   10 s   Get File   ${OUTPUT_DIR}${/}${file_name}
 # ${doc_content}  ${path_to_file}=   Wait Until Keyword Succeeds   20 sec   1 sec   get_doc_content   ${file_name}
 # Wait Until Keyword Succeeds   20 sec   1 sec   delete_doc   ${path_to_file}
  [return]  ${file_name.split('/')[-1]}
  
Отримати документ до лоту
  [Arguments]  ${username}  ${tender_uaid}  ${lot_id}  ${doc_id}
  ${file_name}=   dzo.Отримати документ   ${username}  ${tender_uaid}  ${doc_id}
  [return]  ${file_name}
  
Отримати інформацію із пропозиції
  [Arguments]  ${username}  ${tender_uaid}  ${field}
  Пошук тендера у разі наявності змін   ${TENDER['LAST_MODIFICATION_DATE']}   ${username}   ${tender_uaid}
#  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  ${bid_value}=   Get Text   xpath=//span[@class="bidAmountValue"]
  ${bid_value}=   Convert To Number   ${bid_value.replace(' ', '')}
  [return]  ${bid_value}
  
Отримати інформацію із документа
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}  ${field}
  Пошук тендера у разі наявності змін   ${TENDER['LAST_MODIFICATION_DATE']}   ${username}   ${tender_uaid}
  ${file_title}=   Get Text   xpath=//span[contains(text(),'${doc_id}')]
  [return]  ${file_title.split('/')[-1]}

Отримати інформацію із тендера
  [Arguments]  ${username}  ${tender_uaid}  ${field_name}
  [Documentation]
  ${doc_index}=         Get Substring    ${field_name}    10   11
  Set Test Variable     ${doc_index}     ${doc_index}
  Switch browser        ${username}
  Run Keyword And Return  Отримати інформацію про ${field_name}

Отримати текст із поля і показати на сторінці
  [Arguments]   ${fieldname}
  sleep  1
  Capture Page Screenshot
  ${return_value}=    Get Text  ${locator.${fieldname}}
  [return]  ${return_value}
  
Отримати інформацію про features[${feature_index}].code
  ${feature_code}=    Get Text  ${locator.feature.code}}
  [return]  ${feature_code}
  
Отримати інформацію про status
  Reload Page
  ${status}=   Get Text   xpath=//div[@class="statusItem active"]/descendant::div[@class="statusName"]
  ${status}=   convert_string_from_dict_dzo  ${status} 
  [return]  ${status}

Отримати інформацію про title
  Execute Javascript   $('.topInfo>h1').css('text-transform', 'initial');
  ${title}=   Отримати текст із поля і показати на сторінці   title
#  ${title}=   convert_title_dzo    ${title}
  [return]  ${title}

Отримати інформацію про title_en
  ${url}=    Get Location
  Log   ${url}
  ${url_en}=   switch_to_en    ${url}
  Go To     ${url_en}
  ${title_en}=    Отримати інформацію про title
  Go To     ${url}
  [return]  ${title_en}

Отримати інформацію про title_ru
  Fail    ***** ДЗО не підтримує локалізацію російською мовою *****

Отримати інформацію про description
  ${description}=   Отримати текст із поля і показати на сторінці   description
  [return]  ${description}

Отримати інформацію про description_en
  ${url}=    Get Location
  Log   ${url}
  ${url_en}=   switch_to_en    ${url}
  Go To     ${url_en}
  ${description_en}=    Отримати інформацію про description
  Go To     ${url}
  [return]  ${description_en}

Отримати інформацію про description_ru
  Fail    ***** ДЗО не підтримує локалізацію російською мовою *****

Отримати інформацію про tenderId
  ${tenderId}=   Отримати текст із поля і показати на сторінці   tenderId
  [return]  ${tenderId}

Отримати інформацію про value.amount
  ${valueAmount}=   Отримати текст із поля і показати на сторінці   value.amount
  ${valueAmount}=   Replace String      ${valueAmount}   `   ${EMPTY}
  ${valueAmount}=   Convert To Number   ${valueAmount}
  [return]  ${valueAmount}

Отримати інформацію про minimalStep.amount
  ${minimalStepAmount}=   Отримати текст із поля і показати на сторінці   minimalStep.amount
  ${minimalStepAmount}=   Replace String      ${minimalStepAmount}   `   ${EMPTY}
  ${minimalStepAmount}=   Convert To Number   ${minimalStepAmount.split(' ')[0]}
  [return]  ${minimalStepAmount}

Отримати інформацію про enquiryPeriod.startDate
  Fail    ***** Дата початку періоду уточнень не виводиться на ДЗО *****

Отримати інформацію про enquiryPeriod.endDate
  ${enquiryPeriodEndDate}=   Отримати текст із поля і показати на сторінці   enquiryPeriod.endDate
  ${enquiryPeriodEndDate}=   subtract_from_time   ${enquiryPeriodEndDate}   0   -1
  [return]  ${enquiryPeriodEndDate}

Отримати інформацію про tenderPeriod.startDate
  ${tenderPeriodStartDate}=   Отримати текст із поля і показати на сторінці   tenderPeriod.startDate
  ${tenderPeriodStartDate}=   subtract_from_time    ${tenderPeriodStartDate}   -1   0
  [return]  ${tenderPeriodStartDate}

Отримати інформацію про tenderPeriod.endDate
  ${tenderPeriodEndDate}=   Отримати текст із поля і показати на сторінці   tenderPeriod.endDate
  ${tenderPeriodEndDate}=   subtract_from_time    ${tenderPeriodEndDate}   0   0
  [return]  ${tenderPeriodEndDate}

Отримати інформацію про items[0].deliveryAddress.countryName_ru
  Fail    ***** ДЗО не підтримує локалізацію російською мовою *****

Отримати інформацію про items[0].deliveryAddress.countryName_en
  Fail    ***** На ДЗО, адреса доставки не виводиться англійською мовою *****

Отримати інформацію про procuringEntity.name
  ${legalName}=   Отримати текст із поля і показати на сторінці   legalName
  [return]  ${legalName}

Отримати інформацію про bids
  ${bids}=    Отримати текст із поля і показати на сторінці   bids
  [return]  ${bids}

Отримати інформацію про value.currency
  ${currency}=   Отримати текст із поля і показати на сторінці   currency
  ${currency}=   convert_string_from_dict_dzo                    ${currency}
  [return]  ${currency}

Отримати інформацію про value.valueAddedTaxIncluded
  ${tax}=   Отримати текст із поля і показати на сторінці   tax
  ${tax}=   convert_string_from_dict_dzo                    ${tax}
  ${tax}=   Convert To Boolean                              ${tax}
  [return]  ${tax}

Отримати інформацію про procurementMethodType
  ${procurementMethodType}=   Отримати текст із поля і показати на сторінці    procurementMethodType
  ${procurementMethodType}=   convert_string_from_dict_dzo                     ${procurementMethodType}
  [return]  ${procurementMethodType}

Отримати інформацію про cancellations[0].status
  ${cancellations[0].status}=   Get Element Attribute    xpath=//div[@id="tenderStatus"]/div[4]@class
  ${cancellations[0].status}=   Set Variable If   '${cancellations[0].status}' == 'statusItem active'    active    pending
  [return]  ${cancellations[0].status}

Отримати інформацію про cancellations[0].reason
  Run Keyword And Ignore Error   Click Element   xpath=//a[@class="cancelInfo"]
  ${cancellations[0].reason}=   Отримати текст із поля і показати на сторінці   cancellations[0].reason
  [return]  ${cancellations[0].reason}

Отримати інформацію про cancellations[0].documents[0].description
  Fail    ***** Опис документу скасування закупівлі не виводиться на ДЗО *****
  
Отримати інформацію про cancellations[0].documents[0].title
  Run Keyword And Ignore Error   Click Element   xpath=//a[@class="cancelInfo"]
  ${cancellations[0].documents[0].title}=   Отримати текст із поля і показати на сторінці   cancellations[0].documents[0].title
  [return]  ${cancellations[0].documents[0].title}

Отримати інформацію про causeDescription
  ${causeDescription}=   Отримати текст із поля і показати на сторінці   causeDescription
  [return]  ${causeDescription}

Отримати інформацію про cause
  ${cause}=   Отримати текст із поля і показати на сторінці   cause
  ${cause}=   convert_cause_dzo   ${cause}
  [return]  ${cause}

Отримати інформацію про procuringEntity.address.countryName
  ${countryName}=   Отримати текст із поля і показати на сторінці   procuringEntity.address
  [return]  ${countryName.split(',')[1].strip()}

Отримати інформацію про procuringEntity.address.locality
  ${locality}=   Отримати текст із поля і показати на сторінці   procuringEntity.address
  [return]  ${locality.split(',')[3].strip()}

Отримати інформацію про procuringEntity.address.postalCode
  ${postalCode}=   Отримати текст із поля і показати на сторінці   procuringEntity.address
  [return]  ${postalCode.split(',')[0]}

Отримати інформацію про procuringEntity.address.region
  ${region}=   Отримати текст із поля і показати на сторінці   procuringEntity.address
  [return]  ${region.split(',')[2].strip()}

Отримати інформацію про procuringEntity.address.streetAddress
  ${streetAddress}=   Отримати текст із поля і показати на сторінці   procuringEntity.address
  [return]  ${streetAddress.split(',')[4:].__str__()}

Отримати інформацію про procuringEntity.contactPoint.name
  ${name}=   Отримати текст із поля і показати на сторінці   procuringEntity.contactPoint.name
  [return]  ${name}

Отримати інформацію про procuringEntity.contactPoint.telephone
  ${telephone}=   Отримати текст із поля і показати на сторінці   procuringEntity.contactPoint.telephone
  [return]  ${telephone}

Отримати інформацію про procuringEntity.contactPoint.url
  ${url}=   Отримати текст із поля і показати на сторінці   procuringEntity.contactPoint.url
  [return]  ${url}

Отримати інформацію про procuringEntity.identifier.legalName
  Fail    ***** Офіційне ім’я замовника не виводиться на ДЗО (відповідає найменуванню замовника) *****

Отримати інформацію про procuringEntity.identifier.scheme
  Fail    ***** Схема ідентифікації замовника не виводиться на сторінці тендера на ДЗО *****

Отримати інформацію про procuringEntity.identifier.id
  ${identifier_id}=   Отримати текст із поля і показати на сторінці   procuringEntity.identifier.id
  [return]  ${identifier_id}

Отримати інформацію про documents[${doc_index}].title
  ${doc_title}=   Отримати текст із поля і показати на сторінці   documents.title
  [return]  ${doc_title}

Отримати інформацію про awards[0].status
  ${awards_status}=    Get Text    xpath=//div[@class="clear"]/div[@class="bstatus l"]
  ${awards_status}=    convert_string_from_dict_dzo    ${awards_status}
  [return]  ${awards_status}

Отримати інформацію про awards[0].suppliers[0].address.countryName
  Click Element         xpath=//a[@class="biderInfo"]
  ${country_name}=      Get Text   ${locator.supplier.address}
  [return]  ${country_name.split(',')[3].strip()}

Отримати інформацію про awards[0].suppliers[0].address.locality
  ${locality}=    Get Text   ${locator.supplier.address}
  [return]  ${locality.split(',')[1].strip()}

Отримати інформацію про awards[0].suppliers[0].address.postalCode
  ${postalCode}=    Get Text   ${locator.supplier.address}
  [return]  ${postalCode.split(',')[4].strip()}

Отримати інформацію про awards[0].suppliers[0].address.region
  ${region}=    Get Text   ${locator.supplier.address}
  [return]  ${region.split(',')[2].strip()}

Отримати інформацію про awards[0].suppliers[0].address.streetAddress
  ${streetAddress}=    Get Text   ${locator.supplier.address}
  [return]  ${streetAddress.split(',')[0].strip()}

Отримати інформацію про awards[0].suppliers[0].contactPoint.telephone
  ${supplier_phone}=    Get Text   ${locator.supplier.telephone}
  [return]  ${supplier_phone}

Отримати інформацію про awards[0].suppliers[0].contactPoint.name
  ${supplier_name}=    Get Text   ${locator.supplier.name}
  [return]  ${supplier_name}

Отримати інформацію про awards[0].suppliers[0].contactPoint.email
  ${supplier_email}=    Get Text   ${locator.supplier.email}
  [return]  ${supplier_email}

Отримати інформацію про awards[0].suppliers[0].identifier.scheme
  Fail    ***** Схеми ідентифікації постачальника не виводиться на ДЗО *****

Отримати інформацію про awards[0].suppliers[0].identifier.legalName
  Fail    ***** Офіційне ім’я постачальника не виводиться на ДЗО *****

Отримати інформацію про awards[0].suppliers[0].identifier.id
  ${supplier_id}=    Get Text   ${locator.supplier.id}
  [return]  ${supplier_id}

Отримати інформацію про awards[0].suppliers[0].name
  ${supplier_name}=    Get Text   ${locator.supplier.companyName}
  [return]  ${supplier_name}

Отримати інформацію про awards[0].value.valueAddedTaxIncluded
  ${supplier_tax}=    Get Text                       ${locator.tax}
  ${supplier_tax}=    convert_string_from_dict_dzo   ${supplier_tax}
  ${supplier_tax}=    Convert To Boolean             ${supplier_tax}
  [return]  ${supplier_tax}

Отримати інформацію про awards[0].value.currency
  ${supplier_currency}=    Get Text                        ${locator.supplier.currency}
  ${supplier_currency}=    convert_string_from_dict_dzo    ${supplier_currency}
  [return]  ${supplier_currency}

Отримати інформацію про awards[0].value.amount
  ${supplier_amount}=    Get Text            ${locator.supplier.amount}
  ${supplier_amount}=    Replace String      ${supplier_amount}   `   ${EMPTY}
  ${supplier_amount}=    Convert To Integer  ${supplier_amount.split('.')[0]}
  [return]  ${supplier_amount}

Отримати інформацію про auctionPeriod.startDate
  ${auction_startDate}=    Get Text            ${locator.auctionPeriod.startDate}
  [return]  ${auction_startDate}
  
Отримати інформацію про complaintPeriod.endDate
  ${complaint_endDate}=   Get Text   
  [return]  ${complaint_endDate}

Звірити координати тендера
  [Arguments]  ${viewer}  ${tender_data}  ${items_coord_index}
  Fail   ***** Координати доставки не виводяться на ДЗО *****

###############################################################################################################
######################################    ПОДАННЯ ПРОПОЗИЦІЙ   ################################################
###############################################################################################################

Подати цінову пропозицію
  [Arguments]   ${username}  ${tender_uaid}  ${bid}  ${lots_ids}=${None}  ${features_ids}=${None}
  ${amount}=   Set Variable If   ${lots_ids}   ${bid.data.lotValues[0].value.amount}   ${bid.data.value.amount}  
  ${amount}=   add_second_sign_after_point   ${amount}
  ${meat}=   Evaluate   ${tender_meat} + ${lot_meat} + ${item_meat}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Run keyword if   '${TEST NAME}' != 'Неможливість подати цінову пропозицію до початку періоду подачі пропозицій першим учасником'
  ...   Wait Until Keyword Succeeds   10 x   60 s   Дочекатися синхронізації для періоду подачі пропозицій
  Run Keyword If   ${number_of_lots} < 1   Input Text   name=data[value][amount]   ${amount}
  ...   ELSE   Input Text   xpath=//span[contains(text(), ${lots_ids[0]})]/ancestor::section[@id="bid"]/descendant::input[@class="lotValue"]   ${amount}
  Run Keyword If   "${mode}" == "openua"   Run Keywords
  ...   Click Element   xpath=//input[@name='data[selfQualified]']/following-sibling::span
  ...   AND   Click Element   xpath=//input[@name='data[selfEligible]']/following-sibling::span
  Run Keyword If   ${meat} > 0   Вибрати нецінові показники   ${bid}   ${features_ids}
  Click Button   name=do
  Wait Until Element Is Visible   xpath=//a[./text()= 'Закрити']
  Click Element   xpath=//a[./text()= 'Закрити']
  Wait Until Element Is Not Visible   id=jAlertBack
  Click Button   name=pay
  Wait Until Element Is Visible   xpath=//a[./text()= 'OK']
  Click Element   xpath=//a[./text()= 'OK']
  [return]  ${bid}

Вибрати нецінові показники
  [Arguments]  ${bid}  ${features_ids}
  ${feature_lenght}=   Get Length   ${features_ids}
  :FOR  ${feature_index}   IN RANGE   ${feature_lenght}
  \   ${value}=  Get From Dictionary   ${bid.data.parameters[${feature_index}]}   value
  \   ${value}=  Convert To String   ${value}
  \   ${features_id}=   Get From List 	 ${features_ids}   ${feature_index}
  \   Select From List By Value   xpath=//div[contains(text(), '${features_id}')]/ancestor::tr[contains(@class, 'featureBidItem')]/descendant::select[@name="data[parameters][${feature_index}][value]"]  ${value}
  

########## Видалити після встановлення коректних часових проміжків для періодів #######################
Дочекатися синхронізації для періоду подачі пропозицій
  Reload Page
  Wait Until Page Contains    Ваша пропозиція

Дочекатися синхронізації для періоду аукціон
  Reload Page
  Wait Until Page Contains    Кваліфікація учасників
########################################################################################################


Змінити цінову пропозицію
  [Arguments]  ${username}  ${tender_uaid}  ${fieldname}  ${fieldvalue}
  ${fieldvalue}=   add_second_sign_after_point   ${fieldvalue}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Wait Until Element Is Visible   xpath=//a[@class='button save bidToEdit']
  Click Element   xpath=//a[@class='button save bidToEdit']
  Run Keyword If   ${number_of_lots} < 1   Input Text   name=data[value][amount]   ${fieldvalue}
  ...   ELSE   Input Text   xpath=//input[@class="lotValue"]   ${fieldvalue}
  Click Element   xpath=//button[@value='save']
  Wait Until Page Contains   Підтвердіть зміни в пропозиції
  Input Text   xpath=//div[2]/form/table/tbody/tr[1]/td[2]/div/input    203986723
  Click Element   xpath=//button[./text()='Надіслати']
  [return]  ${fieldname}

Скасувати цінову пропозицію
 [Arguments]  ${username}  ${tender_uaid}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Wait Until Page Contains   Ваша пропозиція   10
  Click Element   xpath=//a[@class='button save bidToEdit']
  Wait Until Page Contains   Відкликати пропозицію   10
  Click Element   xpath=//button[@value='unbid']
  Sleep   1
  Click Element   xpath=//a[@class='jBtn green']
  Sleep   2
  Wait Until Page Contains   Підтвердіть зміни в пропозиції
  Input Text   xpath=//div[2]/form/table/tbody/tr[1]/td[2]/div/input    203986723
  Click Element   xpath=//button[./text()='Надіслати']
  Wait Until Page Contains   Вашу пропозицію відкликано   30
  Click Element   xpath=//a[./text()= 'Закрити']

Отримати пропозицію
  [Arguments]  ${username}  ${tender_uaid}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  ${resp}=   Run Keyword And Return Status   Element Should Be Visible   xpath=//div[@class="payBid bidPaid_invalid"]
  ${status}=   Set Variable If   "${resp}" == "True"   invalid   active
  ${data}=   Create Dictionary   status=${status}
  ${bid}=   Create Dictionary   data=${data}
  [return]  ${bid}

Завантажити документ в ставку
  [Arguments]  ${username}  ${filePath}  ${tender_uaid}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Wait Until Page Contains   Ваша пропозиція   10
  Click Element   xpath=//a[@class='button save bidToEdit']
  Execute Javascript   $("body > div").removeAttr("style");
  Choose File   xpath=/html/body/div[1]/form/input   ${filePath}
  Click Element   xpath=//button[@value='save']

Змінити документ в ставці
  [Arguments]  ${username}  ${tender_uaid}  ${path}  ${docid}
  Switch browser   ${username}
  Execute Javascript   $(".topFixed").remove();
  Sleep   1
  Execute Javascript   $("body > div").removeAttr("style");
  Choose File   xpath=//input[@title='Завантажити оновлену версію']   ${path}
  Click Element   xpath=//button[@value='save']

Отримати посилання на аукціон для глядача
  [Arguments]  ${username}  ${tender_uaid}
  Sleep   120
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  ${url}=   Get Element Attribute   xpath=//section/h3/a[@class="reverse"]@href
  [return]  ${url}

Отримати посилання на аукціон для учасника
  [Arguments]  ${username}  ${tender_uaid}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Click Element   xpath=//a[@class="reverse getAuctionUrl"]
  Sleep   3
  ${url}=   Get Element Attribute   xpath=//a[contains(text(),"Перейдіть до редукціону")]@href
  [return]  ${url}

###############################################################################################################
####################################    Переговорна процедура    ##############################################
###############################################################################################################

Скасувати закупівлю
  [Arguments]  ${username}  ${tender_uaid}  ${cancellation_reason}  ${document}  ${new_description}
  Switch browser   ${username}
  Go To   ${USERS.users['${username}'].homepage}
  Wait Until Page Contains   Держзакупівлі.онлайн   10
  Пошук тендера в Мої Закупівлі   ${username}   ${tender_uaid}
  Sleep   1
  Click Element   xpath=//a[@class="button tenderCancelCommand"]
  Click Element   ${locator.ModalOK}
  Sleep   1
  Execute Javascript   $('input[name=upload]').css({ visibility: "visible", height: "20px", width: "40px"}); $('#jAlertBack').remove();
  Choose File   name=upload   ${document} 
  Input text   name=title   set var document here
  Click Element   xpath=//button[@class="icons icon_upload relative"]
  Input text   name=reason   ${cancellation_reason}
  Click Element   xpath=//button[@class="bidAction"]
  Sleep   2
  Execute Javascript   modalClose();

Модифікувати закупівлю
  [Arguments]  ${username}  ${tender_uaid}
  Пошук тендера в Мої Закупівлі   ${username}   ${tender_uaid}
# ПОТРІБНО ДОПИСАТИ КЕЙВОРД КОЛИ БУДЕ РЕАЛІЗОВАНИЙ СЛОВНИК З ДАНИМИ ДЛЯ МОДИФІКАЦІЇ


Пошук тендера в Мої Закупівлі
  [Arguments]  ${username}  ${tender_uaid}
  Switch browser   ${username}
  Go To   ${USERS.users['${username}'].homepage}
  Wait Until Page Contains   Держзакупівлі.онлайн   10
  Click Element   xpath=//div[@class="item l relative um_tenders"]/a[@href='/cabinet/tenders/purchase']
  Execute Javascript   $('.topFixed').remove(); $('.sorting').removeClass("floatMenu");
  Click Element   xpath=//div[@class="cd"][span[2][contains(text(),"${tender_uaid}")]]/preceding-sibling::h2/a

Створити постачальника, додати документацію і підтвердити його
  [Arguments]  ${username}  ${tender_uaid}  ${supplier_data}  ${document}
  Пошук тендера в Мої Закупівлі   ${username}   ${tender_uaid}
  Додати інформацію про постачальника   ${supplier_data}
  Завантажити документи щодо визначення переможця   ${document}
  Sleep   300 
  Reload Page
  Підтвердити переможця процедури

Додати інформацію про постачальника
  [Arguments]  ${supplier_data}
  ${supplierCompanyName}=     Get From Dictionary   ${supplier_data.data.suppliers[0]}                name
  ${supplierIdentifier}=      Get From Dictionary   ${supplier_data.data.suppliers[0].identifier}     id
  ${supplierScheme}=          Get From Dictionary   ${supplier_data.data.suppliers[0].identifier}     scheme
  ${supplierCountryName}=     Get From Dictionary   ${supplier_data.data.suppliers[0].address}        countryName
  ${supplierRegion}=          Get From Dictionary   ${supplier_data.data.suppliers[0].address}        region
  ${supplierRegion}=   convert_string_from_dict_dzo   ${supplierRegion}
  ${supplierLocality}=        Get From Dictionary   ${supplier_data.data.suppliers[0].address}        locality
  ${supplierStreetAddress}=   Get From Dictionary   ${supplier_data.data.suppliers[0].address}        streetAddress
  ${supplierPostalCode}=      Get From Dictionary   ${supplier_data.data.suppliers[0].address}        postalCode
  ${supplierName}=            Get From Dictionary   ${supplier_data.data.suppliers[0].contactPoint}   name
  ${supplierEmail}=           Get From Dictionary   ${supplier_data.data.suppliers[0].contactPoint}   email
  ${supplierTelephone}=       Get From Dictionary   ${supplier_data.data.suppliers[0].contactPoint}   telephone
#  ${supplierTelephone}=       Fetch From Right      ${supplierTelephone}                              380
  ${supplierUrl}=             Get From Dictionary   ${supplier_data.data.suppliers[0].contactPoint}     url  
  ${supplierValueAmount}=     Get From Dictionary   ${supplier_data.data.value}                       amount  
  Wait Until Element Is Visible   xpath=//a[@class="button reverse addAward"]
  Click Element                           xpath=//a[@class="button reverse addAward"]
  Click Element                           ${locator.ModalOK}
  Input text                              name=data[suppliers][0][name]                     ${supplierCompanyName}                     
  Input text                              name=data[suppliers][0][identifier][id]           ${supplierIdentifier}
  Select From List By Value               name=data[suppliers][0][identifier][scheme]       ${supplierScheme}
  Select From List By Value               name=data[suppliers][0][address][countryName]     ${supplierCountryName}
  Select From List By Value               name=data[suppliers][0][address][region]          ${supplierRegion}
  Input text                              name=data[suppliers][0][address][locality]        ${supplierLocality}
  Input text                              name=data[suppliers][0][address][streetAddress]   ${supplierStreetAddress}
  Input text                              name=data[suppliers][0][address][postalCode]      ${supplierPostalCode}
  Input text                              name=data[suppliers][0][contactPoint][name]       ${supplierName}
  Input text                              name=data[suppliers][0][contactPoint][email]      ${supplierEmail}
  Input text                              name=data[suppliers][0][contactPoint][telephone]  ${supplierTelephone[-9:]}
  Input text                              name=data[suppliers][0][contactPoint][url]        ${supplierUrl}
  Input text                              name=data[value][amount]                          ${supplierValueAmount}
  Capture Page Screenshot
  Execute Javascript                      $(".message").scrollTop(1000);
  Sleep   1
  Click Element              xpath=//div[@class="bidDocuments addAward"]//button[@type="submit"]
  Sleep   3
  Execute Javascript         modalClose();

Завантажити документи щодо визначення переможця
  [Arguments]  ${document}
  Click Element              xpath=//a[@data-bid-action="aply"]
  Input text                 name=title    test_doc
  Execute Javascript         $('input[name=upload]').css({ visibility: "visible", height: "20px", width: "40px"}); $('#jAlertBack').remove();
  Choose File                name=upload     ${document}
  Click Element              xpath=//button[@class="icons icon_upload relative"]
  Sleep   2
  Click Element              xpath=//button[@class="bidAction"]
  Sleep   2
  Execute Javascript         modalClose(); 

Підтвердити переможця процедури
  Click Element              xpath=//span[@class="awardActionItem awardActionSign"]//a
  Click Element              xpath=//a[@class="reverse button tenderSignCommand"]
  Select Window              title=sign
  Sleep   1
  Select From List By Label  id=CAsServersSelect                          Тестовий ЦСК АТ "ІІТ"
  Execute Javascript         var element = document.getElementById('PKeyFileInput'); element.style.visibility="visible";
  Choose File                id=PKeyFileInput                             /home/username/robot_tests/src/robot_tests.broker.dzo/Key-6.dat
  Input text                 id=PKeyPassword                              qwerty
  Click Element              id=PKeyReadButton
  Wait Until Page Contains   Горобець                                     10
  Click Element              id=SignDataButton
  Wait Until Page Contains   Підпис успішно накладено та передано у ЦБД   30
  Select Window