*** Settings ***
Library  Selenium2Screenshots
Library  String
Library  DateTime
Library  dzo_service.py

*** Variables ***
${doc_index}                       0
${locator.tenderId}                xpath=//td[contains(text(),'Ідентифікатор аукціону')]/following-sibling::td[1]
${locator.title}                   xpath=//div[@class='topInfo']/h1
${locator.dgfID}                   xpath=//h3[text()='Банк']/following-sibling::table/tbody/tr[4]/td[2]
${locator.eligibilityCriteria}     xpath=//h3[text()='Банк']/following-sibling::table/tbody/tr[5]/td[2]
${locator.description}             xpath=//h2[@class='tenderDescr']
${locator.value.amount}            xpath=//section[2]/h3[contains(text(),'Параметри аукціону')]/following-sibling::table//tr[1]/td[2]/span[1]
${locator.legalName}               xpath=//td[contains(text(),'Найменування організатора')]/following-sibling::td//span
${locator.minimalStep.amount}      xpath=//td[contains(text(),'Мінімальний крок аукціону')]/following-sibling::td/span[1]
${locator.enquiryPeriod.endDate}   xpath=//td[contains(text(),'Дата завершення періоду уточнень')]/following-sibling::td[1]
${locator.tenderPeriod.endDate}    xpath=//td[contains(text(),'Кінцевий строк подання пропозицій')]/following-sibling::td[1]
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
${locator.items.quantity}         /tr[3]/td[2]/span[1]
${locator.items.unit.code}        /tr[3]/td[2]/span[2]
${locator.items.unit.name}        /tr[3]/td[2]/span[2]
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
${locator.currency}                  xpath=//section[2]/h3[contains(text(),'Параметри аукціону')]/following-sibling::table//tr[1]/td[2]/span[2]
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
${locator.auctionPeriod.startDate}     xpath=//td[contains(text(), 'Електронний аукціон відбудеться')]/following-sibling::td[1]/span


*** Keywords ***
Підготувати дані для оголошення тендера
  [Arguments]  ${username}  ${tender_data}  ${role_name}
  ${tender_data}=   adapt_data_for_role   ${role_name}   ${tender_data}
  Log Many   ${tender_data}
  [return]  ${tender_data}

Підготувати клієнт для користувача
  [Arguments]  ${username}
  Set Global Variable   ${DZO_MODIFICATION_DATE}   ${EMPTY}
  Run Keyword If   "${USERS.users['${username}'].browser}" == "Firefox"   Створити драйвер для Firefox   ${username}
  ...   ELSE   Open Browser   ${USERS.users['${username}'].homepage}   ${USERS.users['${username}'].browser}   alias=${username}
  Set Window Size   @{USERS.users['${username}'].size}
  Set Window Position   @{USERS.users['${username}'].position}
  Run Keyword If   'Viewer' not in '${username}'   Login   ${username}
  
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
  Клікнути по елементу   xpath=(//a[@href="/cabinet"])[2]
  Ввести текст   name=email   ${USERS.users['${username}'].login}
  Execute Javascript   $('input[name="email"]').attr('rel','CHANGE');
  Ввести текст   name=psw   ${USERS.users['${username}'].password}
  Клікнути по елементу   xpath=//button[contains(@class, 'btn')][./text()='Вхід в кабінет']

###############################################################################################################
######################################    СТВОРЕННЯ ТЕНДЕРУ    ################################################
###############################################################################################################

Створити тендер
  [Arguments]  ${username}  ${tender_data}
  ${guarantee}=   add_second_sign_after_point   ${tender_data.data.guarantee.amount}
  ${minimalStep}=   add_second_sign_after_point   ${tender_data.data.minimalStep.amount}
  Selenium2Library.Switch Browser   ${username}
  Клікнути по елементу   jquery=a[href="/tenders/new"]
  Wait Until Page Contains Element   name=data[title]   30
  Run Keyword And Ignore Error   Click Element   xpath=//a[@class="close icons"]
  Run Keyword If   '${tender_data.data.procurementMethodType}' != 'dgfOtherAssets'   Run Keywords
  ...   Select From List   name=tender_method   open_${tender_data.data.procurementMethodType}
  ...   AND   Підтвердити дію
  Ввести текст   name=data[title]   ${tender_data.data.title}
  Ввести текст   name=data[description]   ${tender_data.data.description}
  Ввести текст   name=data[dgfID]   ${tender_data.data.dgfID}
  Ввести Цінові Дані   ${EMPTY}   ${tender_data.data.value.amount}   ${tender_data.data.value.valueAddedTaxIncluded}
  Ввести текст   name=data[guarantee][amount]   ${guarantee}
  Ввести текст   name=data[minimalStep][amount]   ${minimalStep}
  Клікнути по елементу   xpath=//section[@id="multiItems"]/a
  Додати багато предметів   ${tender_data}
  Input Date   data[tenderPeriod][endDate]   ${tender_data.data.auctionPeriod.startDate}
  Клікнути по елементу   xpath= //button[@value='publicate']
  Wait Until Page Contains   Аукціон опубліковано   30
  ${tender_uaid}=   Get Text   ${locator.tenderId}
  [return]  ${tender_uaid}

Додати предмет
  [Arguments]  ${item}
  ${item_description_en}=   Set Variable If   "${mode}" == "openeu"   ${item.description_en} 
  ${unit_name}=   convert_string_from_dict_dzo   ${item.unit.name}
  ${region}=   convert_string_from_dict_dzo   ${item.deliveryAddress.region}
  ${delivery_end_date}=   dzo_service.convert_date_to_slash_format   ${item.deliveryDate.endDate}
  ${index}=   Get Element Attribute   xpath=(//div[@class="tenderItemElement tenderItemPositionElement"])[last()]@data-multiline
  Execute Javascript   $(".topFixed").remove();
  Ввести текст   name=data[items][${index}][description]   ${item.description}
  Ввести текст   name=data[items][${index}][quantity]   ${item.quantity}
  Select From List By Label   name=data[items][${index}][unit_id]   ${unit_name}
  Focus   name=data[items][${index}][quantity]
  Клікнути по елементу   xpath=//input[@name='data[items][${index}][cav_id]']/preceding-sibling::a
  Select Frame   xpath=//iframe[contains(@src,'/js/classifications/universal/index.htm?lang=uk&shema=CAV&relation=true')]
  Run Keyword If   '000000' not in '${item.classification.id}'   Ввести текст   id=search   ${item.classification.description}
  Wait Until Page Contains   ${item.classification.id}
  Клікнути по елементу   xpath=//a[contains(@id,'${item.classification.id.replace('-','_')}')]
  Клікнути по елементу   xpath=//*[@id='select']
  Unselect Frame
  Select From List By Label   name=data[items][${index}][country_id]   ${item.deliveryAddress.countryName}
  Select From List By Label   name=data[items][${index}][region_id]    ${region}
  Ввести текст   name=data[items][${index}][address][locality]   ${item.deliveryAddress.locality}
  Ввести текст   name=data[items][${index}][address][streetAddress]   ${item.deliveryAddress.streetAddress}
  Ввести текст   name=data[items][${index}][address][postalCode]   ${item.deliveryAddress.postalCode}

Додати багато предметів
  [Arguments]  ${tender_data}
  ${items}=   Get From Dictionary   ${tender_data.data}   items
  ${Items_length}=   Get Length   ${items}
  :FOR   ${index}   IN RANGE   ${Items_length}
  \   ${location_index}=   Get Element Attribute   xpath=(//div[@class="tenderItemElement tenderItemPositionElement"])[last()]@data-multiline
  \   ${status}=   Run Keyword And Return Status   Textfield Value Should Be   name=data[items][${location_index}][description]   ${EMPTY}
  \   Run Keyword If   not ${status}   Клікнути по елементу   jquery=a:contains("Додати предмет закупівлі"):visible
  \   Додати предмет   ${items[${index}]}

Додати предмет закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${item}
  ${item}=   adapt_one_item   ${item}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//a[./text()='Редагувати']
  Execute Javascript   $(".topFixed").remove();
  Клікнути по елементу   id=multiItems
  Клікнути по елементу   xpath=//section[@id="multiItems"]//a[@class="addMultiItem"]
  Додати предмет   ${item}
  Клікнути по елементу   xpath=//button[@value="save"]
  
Видалити предмет закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//a[./text()='Редагувати']
  Execute Javascript   $(".topFixed").remove(); $('.blockedId').removeClass('blockedId');
  Клікнути по елементу   xpath=//input[contains(@value, '${item_id}')]/ancestor::div[@class="tenderItemElement tenderItemPositionElement"]/descendant::a[@class="deleteMultiItem"]
  Підтвердити дію
  Клікнути по елементу   xpath=//button[@value="save"]

Input Date
  [Arguments]  ${elem_name_locator}  ${date}
  ${date}=   dzo_service.convert_date_to_slash_format   ${date}
  Focus   name=${elem_name_locator}
  Execute Javascript   $("input[name|='${elem_name_locator}']").removeAttr('readonly'); $("input[name|='${elem_name_locator}']").unbind();
  Ввести текст  ${elem_name_locator}  ${date}

Ввести Цінові Дані
  [Arguments]  ${currency}  ${amount}  ${valueAddedTaxIncluded}
  ${budget}=   add_second_sign_after_point   ${amount}
  ${tax}=   Convert To String   ${valueAddedTaxIncluded}
  ${tax}=   Convert To Lowercase  ${tax}
  Ввести текст   name=data[value][amount]   ${budget}
  Select From List By Value   name=data[value][valueAddedTaxIncluded]   ${tax}

#############################################################################################################

Завантажити документ
  [Arguments]  ${username}  ${filepath}  ${tender_uaid}  ${illustration}=False
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//a[contains(text(),'Редагувати')]
  Клікнути по елементу   xpath=//h3[contains(text(),'Документація до лоту')]/following-sibling::a
  Execute Javascript    $('body > div').attr('style', '');
  Choose File   xpath=//div[1]/form/input[@name="upload"]  ${filepath}
  Ввести текст   xpath=//div[@style="display: block;"]/descendant::input[@value="${filepath.split('/')[-1]}"]   ${filepath.replace('/tmp/', '')}
  Run Keyword If   ${illustration}   Select From List By Value   xpath=//*[@class='js-documentType']   illustration
  Click Button   xpath=//button[@value='save']
  # Сліп необхідний для корректної роботи з загруженим файлом користувачами Квінти, оскільки завантаження фалу у ЦБД може сягати 3-4 хвилин. 
  Sleep   180

Завантажити ілюстрацію
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}
  dzo.Завантажити документ   ${username}  ${filepath}  ${tender_uaid}  True

Додати Virtual Data Room
  [Arguments]  ${username}  ${tender_uaid}  ${vdr_url}  ${title}=Sample Virtual Data Room
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//a[contains(text(),'Редагувати')]
  Клікнути по елементу   xpath=//h3[contains(text(),'Документація до лоту')]/following-sibling::a
  Клікнути по елементу   xpath=//a[contains(@class,'js-uploadVDR')]
  Ввести текст   name=url   ${vdr_url}
  Клікнути по елементу   xpath=//button[@class="bidAction"]
  Run Keyword And Ignore Error   Wait Until Element Is Not Visible   xpath=//button[@class="bidAction"]
  Wait Until Element Is Visible   name=do
  Click Button   name=do

Пошук тендера по ідентифікатору
  [Arguments]  ${username}  ${tender_uaid}
  Switch browser   ${username}
  Go To   ${USERS.users['${username}'].homepage}
  Клікнути по елементу   xpath=//a[text()='Аукціони']
  Клікнути по елементу   xpath=//a[@href='/tenders/all']
  Execute Javascript   $(".topFixed").remove();
  Wait Until Page Contains Element   xpath=//select[@name='filter[object]']/option[@value='auctionID']
  Клікнути по елементу   xpath=//select[@name='filter[object]']/option[@value='auctionID']
  Ввести текст   xpath=//input[@name='filter[search]']   ${tender_uaid}
  Focus   name=filter[search2]
  Клікнути по елементу   xpath=//button[@class='btn not_toExtend'][./text()='Пошук']
  Wait Until Page Contains   ${tender_uaid}   10
  Клікнути по елементу   xpath=//span[contains('${tender_uaid}', text()) and contains(text(), '${tender_uaid}')]/../preceding-sibling::h2/a
  Wait Until Page Does Not Contain Element   xpath=//form[@name="filter"]
  Execute Javascript   $(".topFixed").remove();

###############################################################################################################
##########################################    СКАСУВАННЯ    ###################################################
###############################################################################################################

Скасувати закупівлю
  [Arguments]  ${username}  ${tender_uaid}  ${cancellation_reason}  ${document}  ${new_description}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//a[contains(@class,'tenderCancelCommand')]
  Підтвердити дію
  Execute Javascript   $("input[type|='file']").css({height: "20px", width: "40px", opacity: 1, left: 0, top: 0, position: "static"});
  Choose File   xpath=//input[@type="file"]   ${document}
  Ввести текст   name=title   ${document.split('/')[-1]}
  Клікнути по елементу   xpath=//button[text()="Додати"]
  Ввести текст  name=reason   ${cancellation_reason}
  Клікнути по елементу   xpath=//button[@class="bidAction"]
  Wait Until Page Contains   Причини скасування аукціону
  Wait Until Keyword Succeeds  10 x   1 m   Звірити статус тендера   ${username}  ${tender_uaid}  ТОРГИ ВІДМІНЕНО


###############################################################################################################
###########################################    ПИТАННЯ    #####################################################
###############################################################################################################

Задати запитання на тендер
  [Arguments]  ${username}  ${tender_uaid}  ${question}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//section[@class="content"]/descendant::a[contains(@href, 'questions')]
  Execute Javascript   $(".topFixed").remove();
  Ввести текст   xpath=//form[@id="question_form"]/descendant::input[@name="title"]   ${question.data.title}
  Ввести текст   xpath=//form[@id="question_form"]/descendant::textarea[@name="description"]   ${question.data.description}
  Клікнути по елементу   xpath=//button[contains(text(), 'Надіслати запитання')]
  
Задати запитання на предмет
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${question}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//section[@class="content"]/descendant::a[contains(@href, 'questions')]
  Execute Javascript   $(".topFixed").remove();
  Ввести текст   xpath=//form[@id="question_form"]/descendant::input[@name="title"]   ${question.data.title}
  Select From List By Value   name=questionOf   item
  ${item_option}=   Get Text   //option[contains(text(), '${item_id}')]
  Select From List By Label   name=relatedItem   ${item_option}
  Ввести текст   xpath=//form[@id="question_form"]/descendant::textarea[@name="description"]   ${question.data.description}
  Клікнути по елементу   xpath=//button[contains(text(), 'Надіслати запитання')]
  
Відповісти на запитання
  [Arguments]  ${username}  ${tender_uaid}  ${answer_data}  ${question_id}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//section[@class="content"]/descendant::a[contains(@href, 'questions')]
  Execute Javascript   $(".topFixed").remove();
  Ввести текст   xpath=//div[contains(text(), '${question_id}')]/../following-sibling::div/descendant::textarea[@name="answer"]   ${answer_data.data.answer}
  Клікнути по елементу   xpath=//button[contains(text(), 'Опублікувати відповідь')]

###############################################################################################################
##########################################   СКАРГИ ТА ВИМОГИ   ###############################################
###############################################################################################################

Створити вимогу про виправлення умов закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${claim}  ${document}=${None}
  ${complaintID}=   Створити вимогу про виправлення   ${username}   ${tender_uaid}   ${claim}   ${document}
  [return]  ${complaintID}
  
Перетворити вимогу про виправлення умов закупівлі в скаргу
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${escalating_data}
  Перетворити вимогу в скаргу   ${username}   ${tender_uaid}   ${complaintID}   ${escalating_data}
  
Скасувати вимогу про виправлення умов закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${cancellation_data}
  Скасувати вимогу   ${username}   ${tender_uaid}   ${complaintID}   ${cancellation_data}

Відповісти на вимогу про виправлення умов закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}
  Відповісти на вимогу   ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}
  
Скасувати вимогу
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${cancellation_data}
  ${claim_location}=   Set Variable   //span[contains(text(), '${complaintID}')]/ancestor::div[contains(@class, "compStatus")]
  dzo.Пошук тендера по ідентифікатору    ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//section[@class="content"]/descendant::a[contains(@href, 'complaints')]
  Клікнути по елементу   xpath=${claim_location}/descendant::a[@data-complaint-action="cancelled"]
  Підтвердити дію
  Ввести текст   name=cancellationReason   ${cancellation_data.data.cancellationReason}
  Wait Until Element Is Not Visible   id=jAlertBack
  Клікнути по елементу   xpath=//button[contains(text(), 'Зберегти')]
  
Створити вимогу про виправлення
  [Arguments]  ${username}  ${tender_uaid}  ${claim}  ${document}=${None}
  dzo.Пошук тендера по ідентифікатору    ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//section[@class="content"]/descendant::a[contains(@href, 'complaints')]
  Wait Until Page Contains Element   xpath=//a[@class="addComplaint"]
  Клікнути по елементу   xpath=//a[@class="addComplaint"]
  Підтвердити дію
  Wait Until Page Contains  Вимога учасника   10
  Ввести текст   xpath=//form[@name='tender_complaint']/descendant::input[@name='title']   ${claim.data.title}
  Ввести текст   xpath=//textarea[@name='description']   ${claim.data.description}
  Run Keyword IF   '${document}' != '${None}'   Run Keywords
  ...   Ввести текст   xpath=//input[@placeholder="Вкажіть назву докумету"]   ${document.split('/')[2]}
  ...   AND   Execute Javascript   $("input[name|='upload']").css({height: "20px", width: "40px"});
  ...   AND   Choose File   name=upload   ${document}
  ...   AND   Клікнути по елементу   xpath=//button[contains(text(), 'Додати')]
  Wait Until Page Contains Element   xpath=//span[@class="docTitle"]   60
  Execute Javascript        $('.info').css('height', '550px');
  Клікнути по елементу   xpath=//button[contains(text(), 'Зберегти')]
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
  Клікнути по елементу   xpath=//section[@class="content"]/descendant::a[contains(@href, 'complaints')]
  Sleep  2
  Клікнути по елементу   xpath=${claim_location}/descendant::a[@data-complaint-action="estimate"]
  Підтвердити дію
  Клікнути по елементу   xpath=//input[@value="pending"]/following-sibling::span
  Клікнути по елементу   xpath=//button[contains(text(), 'Зберегти')]
  
Відповісти на вимогу
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}
  ${claim_location}=   Set Variable   //span[contains(text(), '${complaintID}')]/ancestor::div[contains(@class, "compStatus")]
  dzo.Пошук тендера по ідентифікатору    ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//section[@class="content"]/descendant::a[contains(@href, 'complaints')]
  Дочекатися появи вимоги для відповіді   ${complaintID}
  Клікнути по елементу   xpath=${claim_location}/descendant::a[@class="answerComplaint"]
  Клікнути по елементу   xpath=//input[@value="${answer_data.data.resolutionType}"]/following-sibling::span
  Ввести текст   name=resolution   ${answer_data.data.resolution}
  Клікнути по елементу   xpath=//button[@class="bidAction"]
  
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
  Клікнути по елементу   xpath=//a[@class='button save'][./text()='Редагувати']
  sleep   1
  Run Keyword If   '${fieldname}' == 'value'   Ввести Цінові Дані   ${EMPTY}   ${fieldvalue.amount}   ${fieldvalue.valueAddedTaxIncluded}
  ...   ELSE IF   '${fieldname}' != 'tenderPeriod.endDate'   Ввести текст   ${field_locator}   ${fieldvalue}
  ...   ELSE   Execute Javascript   $("input[name|='data[tenderPeriod][endDate]']").attr('value', '${fieldvalue}');
  sleep   1
  Клікнути по елементу   xpath=//button[@value='save']

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
  ${item_value}=   Get Text   xpath=//td[contains(text(), '${item_id}')]/../..${locator.items.${field_name}}
  ${item_value}=   adapt_items_data   ${field_name}   ${item_value}
  [return]  ${item_value}
  
Отримати інформацію із запитання
  [Arguments]  ${username}  ${tender_uaid}  ${question_id}  ${field_name}
  Пошук тендера у разі наявності змін   ${TENDER['LAST_MODIFICATION_DATE']}   ${username}   ${tender_uaid}
  Execute Javascript   window.scroll(2500,2500); $(".topFixed").remove();
  Клікнути по елементу   xpath=//section[@class="content"]/descendant::a[contains(@href, 'questions')]
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
  Execute Javascript   window.scroll(2500,2500); $(".topFixed").remove();
  Клікнути по елементу   xpath=//section[@class="content"]/descendant::a[contains(@href, 'complaints')]
  Wait Until Keyword Succeeds   15 x   20 s   Дочекатися відображення скарги на сторінці   ${complaintID}
  ${class_incl}=   Get Element Attribute   xpath=//span[contains(text(), '${complaintID}')]/../../..@class
  ${status}=   get_claim_status   ${class_incl}
  ${value}=   Get Text   xpath=//span[contains(text(), '${complaintID}')]/../../..${locator.complaint.${field_name}}
  ${complaint_value}=   Set Variable If   '${field_name}' == 'status'    ${status}   ${value}
  Execute Javascript   $('.back').click();
  [return]  ${complaint_value}
  
Отримати документ до скарги
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${doc_id}
  ${value}=   dzo.Отримати інформацію із документа до скарги   ${username}   ${tender_uaid}   ${complaintID}   ${doc_id}   doc_content
  [return]  ${value}
  
Отримати інформацію із документа до скарги
  [Arguments]  ${username}  ${tender_uaid}  ${complaintID}  ${doc_id}  ${field_name}
  Пошук тендера у разі наявності змін   ${TENDER['LAST_MODIFICATION_DATE']}   ${username}   ${tender_uaid}
  Execute Javascript   $(".topFixed").remove();
  Клікнути по елементу   xpath=//section[@class="content"]/descendant::a[contains(@href, 'complaints')]
  Wait Until Keyword Succeeds   15 x   20 s   Дочекатися відображення скарги на сторінці   ${complaintID} 
  Клікнути по елементу   xpath=//span[contains(text(), '${complaintID}')]/../../../descendant::a[@class="viewDocs"]
  Wait Until Page Contains Element   xpath=//span[@class="docTitle"]
  ${value}=   Run Keyword If   "${field_name}" == "title"   Get Text   xpath=//span[@class="docTitle"]
  ...   ELSE   dzo.Отримати документ   ${username}   ${tender_uaid}   ${doc_id}
  Execute Javascript   $('.back').click();
  [return]  ${value.split('/')[-1]}
  
Дочекатися відображення скарги на сторінці
  [Arguments]  ${text_for_view}
  Reload Page
  Execute Javascript   $(".topFixed").remove();
  Клікнути по елементу   xpath=//section[@class="content"]/descendant::a[contains(@href, 'complaints')]
  Wait Until Page Contains   ${text_for_view}

Отримати документ
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}
  Пошук тендера у разі наявності змін   ${TENDER['LAST_MODIFICATION_DATE']}   ${username}   ${tender_uaid}
  Execute Javascript   $(".topFixed").remove();
  ${file_name}=   Get Text   xpath=//span[contains(text(),'${doc_id}')]
  ${url}=   Get Element Attribute   xpath=//span[contains(text(),'${doc_id}')]/..@href
  dzo_download_file   ${url}  ${file_name.split('/')[-1]}  ${OUTPUT_DIR}
  [return]  ${file_name.split('/')[-1]}
  
Отримати інформацію із пропозиції
  [Arguments]  ${username}  ${tender_uaid}  ${field}
  Пошук тендера у разі наявності змін   ${TENDER['LAST_MODIFICATION_DATE']}   ${username}   ${tender_uaid}
  ${bid_value}=   Get Text   xpath=//span[@class="bidAmountValue"]
  ${bid_value}=   Convert To Number   ${bid_value.replace(' ', '')}
  [return]  ${bid_value}
  
Отримати інформацію із документа
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}  ${field}
  Пошук тендера у разі наявності змін   ${TENDER['LAST_MODIFICATION_DATE']}   ${username}   ${tender_uaid}
  Run Keyword If   '${field}' == 'description'   Fail    ***** Опис документу скасування закупівлі не виводиться на ДЗО *****
  Run Keyword If   'скасування' in '${TEST_NAME}'   Клікнути по елементу   xpath=//a[@class="cancelInfo"]
  Wait Until Element Is Visible   xpath=//*[contains(text(),'${doc_id}')]
  ${value}=   Get Text   xpath=//*[contains(text(),'${doc_id}')]
  [return]  ${value.split('/')[-1]}

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
  ${return_value}=    Get Text  ${locator.${fieldname}}
  [return]  ${return_value}
  
Отримати інформацію про status
  Reload Page
  ${status}=   Get Text   xpath=(//div[@class="statusItem active"]/descendant::div[@class="statusName"])[last()]
  ${status}=   convert_string_from_dict_dzo  ${status} 
  [return]  ${status}

Отримати інформацію про title
  Execute Javascript   $('.topInfo>h1').css('text-transform', 'initial');
  ${title}=   Отримати текст із поля і показати на сторінці   title
#  ${title}=   convert_title_dzo    ${title}
  [return]  ${title}

Отримати інформацію про dgfID
  ${dgfID}=   Get Text   ${locator.dgfID}
  [return]  ${dgfID}

Отримати інформацію про eligibilityCriteria
  ${eligibilityCriteria}=   Get Text   ${locator.eligibilityCriteria}
  [return]  ${eligibilityCriteria}

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

Отримати інформацію про auctionId
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
  Клікнути по елементу   xpath=//a[@class="biderInfo"]
  ${country_name}=   Get Text   ${locator.supplier.address}
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
  ${auction_startDate}=   subtract_from_time    ${auction_startDate}   0   0
  [return]  ${auction_startDate}

Отримати інформацію про auctionPeriod.endDate
  ${auction_endDate}=    Get Text            ${locator.auctionPeriod.startDate}
  ${auction_endDate}=   subtract_from_time    ${auction_endDate.split('-')[-1]}   0   0
  [return]  ${auction_endDate}
  
Отримати інформацію про complaintPeriod.endDate
  ${complaint_endDate}=   Get Text   
  [return]  ${complaint_endDate}

Отримати інформацію про contracts[-1].status
  ${contract_status}=   Get Text   xpath=//a[text()='Контракт']/../preceding-sibling::div[contains(@class,'bstatus')]
  ${contract_status}=   convert_string_from_dict_dzo   ${contract_status}
  [return]   ${contract_status}

Звірити координати тендера
  [Arguments]  ${viewer}  ${tender_data}  ${items_coord_index}
  Fail   ***** Координати доставки не виводяться на ДЗО *****

###############################################################################################################
######################################    ПОДАННЯ ПРОПОЗИЦІЙ   ################################################
###############################################################################################################

Подати цінову пропозицію
  [Arguments]   ${username}  ${tender_uaid}  ${bid}
  ${amount}=   add_second_sign_after_point   ${bid.data.value.amount}
  ${status}=   Run Keyword And Return Status   Dictionary Should Contain Key   ${bid['data']}   qualified
  ${qualified}=   Set Variable If   ${status}   &bad=1   ${EMPTY}
  ${filePath}=   get_upload_file_path
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Run keyword if   '${PREV TEST NAME}' != 'Неможливість подати пропозицію першим учасником без кваліфікації'
  ...   dzo.Скасувати цінову пропозицію   ${username}  ${tender_uaid}
  Execute Javascript   $(".topFixed").remove();
  ${status_doc_upload}=   Run Keyword And Return Status   Element Should Not Be Visible   xpath=//select[@class="documents_url"]
  Run Keyword If   ${status_doc_upload}   Run Keywords
  ...   Run Keyword And Ignore Error   Click Element   xpath=//a[@class="uploadFile"]
  ...   AND   Choose File   xpath=/html/body/div[1]/form/input   ${filePath}
  ...   AND   Wait Until Element Is Visible   xpath=//select[@class="documents_url"]
  ...   AND   Run Keyword And Ignore Error   Select From List By Value   xpath=//select[@class="documents_url"]   financialLicense
  Input Text   name=data[value][amount]   ${amount}
  Клікнути по елементу   name=do
  Клікнути по елементу   xpath=//a[./text()= 'Закрити']
  Перевірити і підтвердити пропозицію   ${qualified}
  Wait Until Page Contains   Гарантійний платіж сплачено
  [return]  ${bid}

Перевірити і підтвердити пропозицію
  [Arguments]  ${qualified}
  Wait Until Element Is Not Visible   id=jAlertBack
  Клікнути по елементу   name=pay
  Клікнути по елементу   xpath=//a[./text()= 'OK']
  Wait Until Page Contains Element   xpath=//div[@class="jContent"]
  Клікнути по елементу   xpath=//a[./text()= 'Закрити']
  Run Keyword And Ignore Error   Wait Until Element Is Not Visible   xpath=//button[@value="to_operator"]
  ${url}=   Log Location
  patch_tender_bid   ${url}   ${qualified}
  Reload Page
  Клікнути по елементу   name=pay
  Підтвердити дію

Завантажити фінансову ліцензію
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}
  dzo.Завантажити документ в ставку   ${username}  ${filepath}  ${tender_uaid}

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
  ${filePath}=   get_upload_file_path
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  dzo.Скасувати цінову пропозицію   ${username}   ${tender_uaid}
  Execute Javascript   $(".topFixed").remove();
  Input Text   name=data[value][amount]   ${fieldvalue}
  Run Keyword And Ignore Error   Click Element   xpath=//a[@class="uploadFile"]
  Choose File   xpath=//input[@type='file']   ${filePath}
  Wait Until Element Is Visible   xpath=//select[@class="documents_url"]
  Run Keyword And Ignore Error   Select From List By Value   xpath=//select[@class="documents_url"]   financialLicense
  Клікнути по елементу   name=do
  Клікнути по елементу   xpath=//a[./text()= 'Закрити']
  Перевірити і підтвердити пропозицію   ${EMPTY}
  Wait Until Page Contains   Гарантійний платіж сплачено
  [return]  ${fieldname}

Скасувати цінову пропозицію
  [Arguments]  ${username}  ${tender_uaid}
  #dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//a[@class='button save bidToEdit']
  Execute Javascript   $(".topFixed").remove(); $(".bottomFixed").remove();
  Клікнути по елементу   name=do
  Підтвердити дію
  Ввести текст   xpath=//div[@id="contactForm"]/descendant::input[@name="checkMPhone"]    203986723
  Клікнути по елементу   xpath=//button[./text()='Надіслати']
  Клікнути по елементу   xpath=//a[./text()= 'Закрити']
  Wait Until Element Is Not Visible   id=jAlertBack

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
  ${amount}=   Get Text   xpath=//span[@class="bidAmountValue"]
  dzo.Скасувати цінову пропозицію   ${username}   ${tender_uaid}
  Execute Javascript   $(".topFixed").remove();
  Input Text   name=data[value][amount]   ${amount}
  Run Keyword And Ignore Error   Click Element   xpath=//a[@class="uploadFile"]
  Choose File   xpath=/html/body/div[1]/form/input   ${filePath}
  Wait Until Element Is Visible   xpath=//select[@class="documents_url"]
  Run Keyword And Ignore Error   Select From List By Value   xpath=//select[@class="documents_url"]   financialLicense
  Клікнути по елементу   name=do
  Клікнути по елементу   xpath=//a[./text()= 'Закрити']
  Перевірити і підтвердити пропозицію   ${EMPTY}
  Wait Until Page Contains   Гарантійний платіж сплачено

Змінити документ в ставці
  [Arguments]  ${username}  ${tender_uaid}  ${path}  ${docid}
  dzo.Завантажити документ в ставку  ${username}  ${path}  ${tender_uaid}

Отримати посилання на аукціон для глядача
  [Arguments]  ${username}  ${tender_uaid}  ${lot_id}=${Empty}
  Sleep   120
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  ${url}=   Get Element Attribute   xpath=//section/h3/a[@class="reverse"]@href
  [return]  ${url}

Отримати посилання на аукціон для учасника
  [Arguments]  ${username}  ${tender_uaid}  ${lot_id}=${Empty}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//a[@class="reverse getAuctionUrl"]
  Wait Until Page Contains Element   xpath=//a[contains(text(),"Перейдіть до аукціону")]
  ${url}=   Get Element Attribute   xpath=//a[contains(text(),"Перейдіть до аукціону")]@href
  [return]  ${url}

###############################################################################################################
#########################################    КВАЛІФІКАЦІЯ   ###################################################
###############################################################################################################

Підтвердити постачальника
  [Arguments]  ${username}  ${tender_uaid}  ${award_num}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Wait Until Keyword Succeeds   15 x   1 m   Run Keywords
  ...   Reload Page
  ...   AND   Execute Javascript   $(".topFixed").remove();
  ...   AND   Клікнути по елементу   xpath=//a[@data-bid-action="protocol"]
  Підтвердити дію
  Wait Until Page Contains   Підтвердження протоколу
  Wait Until Keyword Succeeds   10 x   30 s   Run Keywords
  ...   Reload Page
  ...   AND   Execute Javascript   $(".topFixed").remove();
  ...   AND   Клікнути по елементу   xpath=//a[@data-bid-action="paid"]
  Підтвердити дію
  Wait Until Page Contains   оплату отримано

Завантажити протокол аукціону
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}  ${award_index}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//span[text()="Моя пропозиція"]/..
  Wait Until Page Contains   Документи пропозиції
  Execute Javascript   $("input[type|='file']").css({height: "20px", width: "40px", opacity: 1, left: 0, top: 0, position: "static"});
  Choose File   xpath=//input[@type="file"]   ${file_path}
  Select From List By Value   name=documentType   auctionProtocol
  Клікнути по елементу   xpath=//button[text()="Додати"]
  Підтвердити дію
  Клікнути по елементу   xpath=//button[@class="bidAction"]
  Wait Until Keyword Succeeds   10 x   60 s   Перевірити завантаження протоколу

Перевірити завантаження протоколу
  Reload Page
  Execute Javascript   $(".topFixed").remove();
  Клікнути по елементу   xpath=//preceding-sibling::div[text()='На розгляді']/following-sibling::div/descendant::span[text()='Моя пропозиція']
  Wait Until Page Contains   Документи пропозиції
  Wait Until Page Does Not Contain Element   xpath=//span[@title="документ не завантажено в ЦБД"]
  Wait Until Page Does Not Contain Element   xpath=//span[@title="Поставлено в чергу на завантаження в ЦБД"]

Скасування рішення кваліфікаційної комісії
  [Arguments]  ${username}  ${tender_uaid}  ${award_num}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Wait Until Keyword Succeeds   5 x   1 m   Run Keywords
  ...   Reload Page
  ...   AND   Execute Javascript   $(".topFixed").remove();
  ...   AND   Клікнути по елементу   xpath=//a[@data-bid-action="award cancel"]
  Підтвердити дію

Отримати кількість документів в ставці
  [Arguments]  ${username}  ${tender_uaid}  ${bid_index}
  Дочекатись синхронізації з майданчиком   ${username}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Wait Until Keyword Succeeds   15 x   1 m   Run Keywords
  ...   Reload Page
  ...   AND   Execute Javascript   $(".topFixed").remove();
  ...   AND   Клікнути по елементу   xpath=//preceding-sibling::div[text()='На розгляді']/following-sibling::div/descendant::span[text()='Пропозиція']
  Wait Until Element Is Visible   xpath=//tr[@class="line docItem documents_url_documents"]
  ${bid_doc_number}=   Get Matching Xpath Count   //tr[@class="line docItem documents_url_documents"]
  [return]  ${bid_doc_number}

Отримати дані із документу пропозиції
  [Arguments]  ${username}  ${tender_uaid}  ${bid_index}  ${document_index}  ${field}
  ${status}  ${doc_value}=   Run Keyword And Ignore Error   Get Text   //tr[@class="line docItem documents_url_documents"][${document_index + 1}]/descendant::span[@class='docType']
  ${doc_value}=   Set Variable If   '${status}' == 'FAIL'   Document type not assigned   ${doc_value}
  ${doc_value}=   convert_string_from_dict_dzo   ${doc_value}
  [return]  ${doc_value}

Завантажити документ рішення кваліфікаційної комісії
  [Arguments]  ${username}  ${document}  ${tender_uaid}  ${award_num}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Клікнути по елементу   xpath=//a[@data-bid-action="cancel"]
  Wait Until Page Contains   Дискваліфікація учасника
  Execute Javascript   $("input[type|='file']").css({height: "20px", width: "40px", opacity: 1, left: 0, top: 0, position: "static"});
  Choose File   xpath=//input[@type="file"]   ${document}
  Клікнути по елементу   xpath=//button[text()="Додати"]
  Підтвердити дію
  Wait Until Keyword Succeeds   20 x   20 s   Перевірити завантаження рішення кваліфікаційної комісії

Дискваліфікувати постачальника
  [Arguments]  ${username}  ${tender_uaid}  ${award_num}  ${description}
  Клікнути по елементу   xpath=(//label[@class="relative inp empty"])[1]
  Ввести текст   name=data[description]   ${description}
  Клікнути по елементу   xpath=//button[@class="bidAction"]
  Підтвердити дію

Перевірити завантаження рішення кваліфікаційної комісії
  Reload Page
  Execute Javascript   $(".topFixed").remove();
  Клікнути по елементу   xpath=//a[@data-bid-action="cancel"]
  Wait Until Page Contains   Дискваліфікація учасника
  Wait Until Page Does Not Contain Element   xpath=//span[@title="документ не завантажено в ЦБД"]
  Wait Until Page Does Not Contain Element   xpath=//span[@title="Поставлено в чергу на завантаження в ЦБД"]

Завантажити угоду до тендера
  [Arguments]  ${username}  ${tender_uaid}  ${contract_num}  ${filepath}
  dzo.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Wait Until Keyword Succeeds   10 x   30 s   Run Keywords
  ...   Reload Page
  ...   AND   Execute Javascript   $(".topFixed").remove();
  ...   AND   Клікнути по елементу   xpath=//a[@data-bid-action="contract"]
  Sleep  3
  Execute Javascript   $("input[type|='file']").css({height: "20px", width: "40px", opacity: 1, left: 0, top: 0, position: "static"});
  Sleep  3
  Choose File   xpath=//input[@type="file"]   ${filepath}
  Select From List By Value   name=documentType   contractSigned
  Клікнути по елементу   xpath=//button[text()="Додати"]
  Підтвердити дію

Підтвердити підписання контракту
  [Arguments]  ${username}  ${tender_uaid}  ${contract_num}
  Ввести текст   name=data[contractNumber]   777
  Клікнути по елементу   name=data[dateSigned]
  Клікнути по елементу   xpath=//td[contains(@class,'ui-datepicker-today')]
  Клікнути по елементу   xpath=//button[@class="bidAction"]
  Підтвердити дію

##############################################################################################################

Підтвердити дію
  Клікнути по елементу   ${locator.ModalOK}
  Wait Until Element Is Not Visible   id=jAlertBack

Ввести текст
  [Arguments]  ${locator}  ${text}
  Wait Until Element Is Visible   ${locator}   20
  Input Text   ${locator}   ${text}

Клікнути по елементу
  [Arguments]  ${locator}
  Wait Until Element Is Visible   ${locator}   20
  Click Element   ${locator}
