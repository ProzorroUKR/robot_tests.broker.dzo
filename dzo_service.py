# -*- coding: utf-8 -*-

from datetime import datetime, timedelta
import time
import urllib

import os
from pytz import timezone
from iso8601 import parse_date
import requests

DZO_dict = {u'килограммы': u'кг', u'кілограм': u'кг', u'кілограми': u'кг', u'метри': u'м', u'пара': u'пар',
            u'літр': u'л', u'набір': u'наб', u'пачок': u'пач', u'послуга': u'послуги', u'метри кубічні': u'м.куб',
            u'тони': u'т', u'метри квадратні': u'м.кв', u'кілометри': u'км', u'штуки': u'шт', u'місяць': u'міс',
            u'пачка': u'пачка',
            # u'упаковка': u'уп',
            u'гектар': u'Га', u'лот': u'лот', u"грн": u"UAH",
            u"(з ПДВ)": u"True", u"(без ПДВ)": u"false", u"Код CAV": u"CAV", u"Переможець": u"active",
            u"місто Київ": u"м. Київ", u"ПЕРІОД УТОЧНЕНЬ": u"active.enquiries",
            u"ПОДАННЯ ПРОПОЗИЦІЙ": u"active.tendering", u"ПРЕДКВАЛІФІКАЦІЯ": u"active.pre-qualification",
            u"АУКЦІОН": u"active.auction", u"КВАЛІФІКАЦІЯ ПЕРЕМОЖЦЯ": u"active.qualification",
            u"ТОРГИ НЕ ВІДБУЛИСЯ": u"unsuccessful", u"ТОРГИ ВІДМІНЕНО": u"cancelled", u"ТОРГИ ЗАВЕРШЕНО": u"complete",
            u"НА РОЗГЛЯДІ": u"claim", u"Протокол торгів": u"auctionProtocol",
            u"Оголошення аукціону з продажу майна банків": u"dgfOtherAssets",
            u"Оголошення аукціону з продажу прав вимоги за кредитами банків": u"dgfFinancialAssets", u'вперше': 1,
            u'повторно (вдруге)': 2, u'повторно (втретє)': 3, u'повторно (вчетверте)': 4,
            u'Попередню кваліфікацію скасовано': u'cancelled', u'Дискваліфіковано': u'unsuccessful',
            u'Класифікація за ДК 021-2015 (CPV)': u'ДК021'}


def subtract_from_time(date_time, subtr_min, subtr_sec):
    sub = datetime.strptime(date_time, "%d.%m.%Y %H:%M")
    sub = (sub - timedelta(minutes=int(subtr_min),
                           seconds=int(subtr_sec))).isoformat()
    return sub


def convert_time_to_tests_format(date):
    date = datetime.strptime(date, "%d.%m.%Y %H:%M")
    return "{}{}".format(date.strftime('%Y-%m-%dT%H:%M:%S'), "+02:00")


def convert_datetime_to_format(date, output_format):
    date_obj = parse_date(date)
    day_string = date_obj.strftime(output_format)
    return day_string


def retrieve_date_for_second_stage():
    now = datetime.now()
    return (now + timedelta(minutes=20)).strftime("%d/%m/%Y %H:%M")


def adapt_data_for_role(role_name, tender_data):
    if role_name == "tender_owner":
        tender_data['data']['procuringEntity']['name'] = u"ТОВ prozorroytenderowner"
        tender_data['data']['procuringEntity']['identifier']['id'] = "31212423"
        tender_data['data']['procuringEntity']['identifier']['legalName'] = u"ТОВ prozorroytenderowner"
        if "classification" in tender_data['data'] and tender_data['data']['classification']['id'] == "99999999-9":
            tender_data['data']['classification']['description'] = u"Не визначено"
        for item in tender_data['data']['items']:
            # item['unit']['name'] = DZO_dict.get(item['unit']['name'], item['unit']['name'])
            if 'deliveryDate' in item:
                date = parse_date(item['deliveryDate']['endDate'])
                date = date.replace(hour=16, minute=0, second=0)
                item['deliveryDate']['endDate'] = "{}{}".format(date.strftime("%Y-%m-%dT%H:%M:%S"), "+02:00")
            if "deliveryAddress" in item:
                item['deliveryAddress']['region'] = item['deliveryAddress']['region'].replace(u"місто Київ", u"м. Київ")
            if item['classification']['id'] == "99999999-9":
                item['classification']['description'] = u"Не визначено"
        if tender_data['data'].has_key("funders"):
            tender_data['data']["funders"][0]["address"]["locality"] = tender_data['data']["funders"][0]["address"]["locality"].replace("Washington", u"Вашингтон").replace("Geneva", u"Женева")
    for item in tender_data['data']['items']:
        if item.has_key('unit'):
            item['unit']['name'] = DZO_dict.get(item['unit']['name'], item['unit']['name'])
    return tender_data


def add_second_sign_after_point(amount):
    amount = str(repr(amount))
    if '.' in amount and len(amount.split('.')[1]) == 1:
        amount += '0'
    return amount


def add_second_sign_after_point_with_round(amount):
    amount = str(repr(round(amount, 2)))
    if '.' in amount and len(amount.split('.')[1]) == 1:
        amount += '0'
    return amount


def convert_unit_id(unit_code):
    return {
        "H87": "934",
        "LO": "935",
        "SET": "922",
        "KGM": "938",
        "PK": "924"
    }.get(unit_code, None)


def convert_date_to_slash_format(isodate):
    iso_dt = parse_date(isodate)
    date_string = iso_dt.strftime("%d/%m/%Y")
    return date_string


def convert_dzo_data(value, field_name):
    if "contracts" in field_name and "amount" in field_name:
        value = value.split(" ")[0]
    if "amount" in field_name or "quantity" in field_name or "duration.days" in field_name or "maxAwardsCount" in field_name:
        value_for_return = float(value.replace("`", ""))
    elif "Date" in field_name:
        value_for_return = convert_time_to_tests_format(value)
        if "awards" in field_name and "complaintPeriod.endDate" in field_name:
            value_for_return = value_for_return.replace(":00+", ":59+")
    elif field_name == "funders[0].identifier.id":
        value_for_return = value.split(":")[1]
    elif field_name == "funders[0].identifier.scheme":
        value_for_return = value.split(":")[0]
    elif field_name == "complaint.status":
        class_with_status = [_class for _class in value.split(" ") if "compStatus_" in _class][0]
        value_for_return = class_with_status.replace("compStatus_", "")
    elif "address" in field_name:
        value_for_return = adapt_items_data(field_name, value)
    elif field_name == "agreementDuration":
        l = value.split(" ")
        value_for_return = "P{}Y{}M{}D".format(l[0], l[2], l[4])
    elif field_name in ["NBUdiscountRate", "minimalStepPercentage", "yearlyPaymentsPercentageRange"]:
        value_for_return = round(float(value) / 100, 5)
    elif "funders" in field_name:
        value_for_return = adapt_items_data(field_name, value)
        if "legalName" in field_name:
            value_for_return = {u"Глобальний фонд": u"Глобальний Фонд для боротьби зі СНІДом, туберкульозом і малярією",
                                u"Світовий Банк": u"Міжнародний банк реконструкції та розвитку (МБРР)"}.get(value, value)
    # elif "unit" in field_name:
    #     value_for_return = DZO_dict.get(value, value)
    else:
        value_for_return = {
            u'ПЕРІОД УТОЧНЕНЬ': "active.enquiries",
            u'ПЕРІОД ПОДАННЯ ПРОПОЗИЦІЙ': "active.tendering",
            u'АУКЦІОН': "active.auction",
            u'КВАЛІФІКАЦІЯ': "active.qualification",
            u'ПРЕКВАЛІФІКАЦІЯ': "active.pre-qualification",
            u'ЗАПЛАНОВАНИЙ': "scheduled",
            u'ЗАВЕРШЕНА': "active",
            u'ОЧІКУВАННЯ АКТИВАЦІЇ 2ГО ЕТАПУ': "active.stage2.pending",
            u'ПЕРШИЙ ЕТАП ЗАВЕРШЕНО': "complete",
            u'ОСКАРЖЕННЯ ПРЕКВАЛІФІКАЦІЇ': "active.pre-qualification.stand-still",
            u'ВАШУ ПРОПОЗИЦІЮ ЗАБЛОКОВАНО ЧЕРЕЗ ЗМІНИ, ВНЕСЕНІ ЗАМОВНИКОМ В УМОВИ ОГОЛОШЕННЯ. ДЛЯ ПОВТОРНОЇ АКТИВАЦІЇ ПРОПОЗИЦІЇ, ЇЇ НЕОБХІДНО ПІДТВЕРДИТИ, ПОВТОРНО ЗБЕРІГШИ ЇЇ СКЛАД': "invalid",
            u'ВІДКЛИКАНО': "cancelled",
            u'НЕ ЗАДОВОЛЕНА': "declined",
            u'ВІДХИЛЕНО': "invalid",
            u'РОЗГЛЯНУТО': "answered",
            u'ВИРІШЕНА': "resolved",
            u'Укладена рамкова угода': "active",
            u'Переможець': "active",
            u'Післяоплата': "postpayment",
            u'Аванс': "prepayment",
            u'виконання робіт': "executionOfWorks",
            u'поставка товару': "deliveryOfGoods",
            u'надання послуг': "submittingServices",
            u'підписання договору': "signingTheContract",
            u'дата подання заявки': "submissionDateOfApplications",
            u'дата виставлення рахунку': "dateOfInvoicing",
            u'дата закінчення звітного періоду': "endDateOfTheReportingPeriod",
            u'інша подія': "anotherEvent",
            u'календарні дні': "calendar",
            u'робочі дні': "working",
            u'банківські дні': "banking",
            u'Співфінансування з бюджетних коштів': "budget",
            u'Допорогові закупівлі': "belowThreshold",
            u'Конкурентний діалог 1-ий етап': "competitiveDialogueUA",
            u'Конкурентний діалог з публікацією англійською мовою 1-ий етап': "competitiveDialogueEU",
            u'Відкриті торги для закупівлі енергосервісу': "esco",
            u'Переговорна процедура для потреб оборони': "aboveThresholdUA.defense",
            u'Укладання рамкової угоди': "closeFrameworkAgreementUA",
            u'грн': "UAH",
            u'Код в ЄДРПОУ / ІПН': "UA-EDR",
            u'Класифікація за ДК 021-2015 (CPV)': u"ДК021",
            u'послуги': 'services',
            u'товари': 'goods',
            u'роботи': 'works',
            u'НА РОЗГЛЯДІ': 'pending',
            u"(з ПДВ)": True,
            u"(без ПДВ)": False,
            u"з ПДВ": True,
            u"без ПДВ": False
    }.get(value, value)
    return value_for_return


def convert_agreement(value):
    return {
        u"Підтверджена зміна": "active",
        u"Скасована зміна": "cancelled",
        u"Припинення участі у рамковій угоді учасника": "partyWithdrawal",
        u"Зміна сторонніх показників (курсу, тарифів...)": "thirdParty",
        u"Зміна ціни за одиницю товару": "itemPriceVariation",
        u"Зміна ціни у зв’язку із зміною ставок податків і зборів": "taxRate",
    }.get(value, value)


def convert_string_from_dict_dzo(string):
    return DZO_dict.get(string, string)


def get_street_from_tuple(string):
    return ','.join(string).strip()


def adapt_items_data(field_name, value):
    if 'countryName' in field_name:
        value = value.split(',')[1].strip()
    elif 'postalCode' in field_name:
        value = value.split(',')[0].strip()
    elif 'locality' in field_name:
        value = value.split(',')[3].strip()
    elif 'streetAddress' in field_name:
        value = get_street_from_tuple(value.split(',')[4:])
    elif 'region' in field_name:
        value = value.split(',')[2].strip()
    elif field_name == 'quantity':
        value = float(value)
    elif field_name != 'deliveryAddress.region' and field_name != 'unit.name':
        value = convert_string_from_dict_dzo(value)
    return value


def dzo_download_file(url, file_name, output_dir):
    urllib.urlretrieve(url, ('{}/{}'.format(output_dir, file_name)))


def get_upload_file_path():
    return os.path.join(os.getcwd(), 'src/robot_tests.broker.tendersallbiz/testFileForUpload.txt')


def get_items_by_lot_id(tender_data, lot_id):
    items = [item for item in tender_data['data']['items'] if item['relatedLot'] == lot_id]
    return items


def get_milestone_by_lot_id(tender_data, lot_id):
    items = [item for item in tender_data['data']['milestones'] if item['relatedLot'] == lot_id]
    return items


def refresh_tender(tender_id):
    resp = requests.get("https://www.sandbox.dzo.com.ua/cron/J7hdfks7_jlsdfn.php?tender_id={}&CDB_Number=0&run=KUgfjduk*tgkBkusdh&type=tenders".format(tender_id))
    return resp.content


def convert_compaint_id_to_test_format(complaint_id):
    return complaint_id[:-5] + complaint_id[-5:].lower()