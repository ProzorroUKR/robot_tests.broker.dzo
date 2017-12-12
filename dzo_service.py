# !/usr/bin/python
# -*- coding: utf-8 -*-

from datetime import datetime, timedelta
from iso8601 import parse_date
from pytz import timezone
import os
import urllib
import json

DZO_dict = {u'килограммы': u'кг', u'кілограм': u'кг', u'кілограми': u'кг', u'метри': u'м', u'пара': u'пар',
            u'літр': u'л', u'набір': u'наб', u'пачок': u'пач', u'послуга': u'послуги', u'метри кубічні': u'м.куб',
            u'тони': u'т', u'метри квадратні': u'м.кв', u'кілометри': u'км', u'штуки': u'шт', u'місяць': u'міс',
            u'пачка': u'пачка', u'упаковка': u'уп', u'гектар': u'Га', u'лот': u'лот', u"грн": u"UAH",
            u"(з ПДВ)": u"True", u"(без ПДВ)": u"false", u"Код CPV": u"CPV", u"Переможець": u"active",
            u"місто Київ": u"м. Київ", u"ПЕРІОД УТОЧНЕНЬ": u"active.enquiries",
            u"ПОДАННЯ ПРОПОЗИЦІЙ": u"active.tendering", u"ПРЕДКВАЛІФІКАЦІЯ": u"active.pre-qualification",
            u"АУКЦІОН": u"active.auction", u"КВАЛІФІКАЦІЯ ПЕРЕМОЖЦЯ": u"active.qualification",
            u"ТОРГИ НЕ ВІДБУЛИСЯ": u"unsuccessful", u"ТОРГИ ВІДМІНЕНО": u"cancelled", u"ТОРГИ ЗАВЕРШЕНО": u"complete",
            u"НА РОЗГЛЯДІ": u"claim", u"Протокол торгів": u"auctionProtocol",
            u"Оголошення аукціону з продажу майна": u"dgfOtherAssets",
            u"Оголошення аукціону з продажу прав вимоги за кредитами банків": u"dgfFinancialAssets", u'вперше': 1,
            u'повторно (вдруге)': 2, u'повторно (втретє)': 3, u'повторно (вчетверте)': 4,
            u'Попередню кваліфікацію скасовано': u'cancelled', u'Дискваліфіковано': u'unsuccessful',
            u'?:tender method open_dgfInsider': u'dgfInsider', u'Очікування протоколу': u'pending.verification',
            u'Очікування оплати': u'pending.payment', u'В черзі': u'pending.waiting',
            u'Пропозицію відкликано': u'cancelled'}


def convert_date_to_slash_format(isodate):
    iso_dt = parse_date(isodate)
    date_string = iso_dt.strftime("%d/%m/%Y")
    return date_string


def convert_date_to_template_format(date, template_in, template_out):
    return datetime.strptime(date, template_in).strftime(template_out)


def subtract_from_time(date_time, subtr_min=0, subtr_sec=0):
    sub = datetime.strptime(date_time, "%d.%m.%Y %H:%M")
    sub = (sub - timedelta(minutes=int(subtr_min),
                           seconds=int(subtr_sec)))
    return timezone('Europe/Kiev').localize(sub).strftime('%Y-%m-%dT%H:%M:%S%f%z')


def subtract_from_time_questions(date_time, subtr_min, subtr_sec):
    sub = datetime.strptime(date_time, "%d.%m.%Y, %H:%M")
    sub = (sub - timedelta(minutes=int(subtr_min),
                           seconds=int(subtr_sec))).isoformat()
    return sub


def convert_title_dzo(string):
    return string.replace(string[14:], string[14:].lower())


def convert_string_from_dict_dzo(string):
    return DZO_dict.get(string, string)


def adapt_data_for_role(role_name, tender_data):
    if role_name == 'tender_owner':
        tender_data = adapt_unit_names(adapt_procuringEntity(adapt_address(tender_data)))
    return tender_data


def adapt_unit_names(tender_data):
    if 'unit' in tender_data['data']['items'][0]:
        for i in tender_data['data']['items']:
            i['unit']['name'] = DZO_dict[i['unit']['name']]
            i['contractPeriod']['endDate'] = "{}T00:00:00+02:00".format(
                (datetime.strptime(i['contractPeriod']['endDate'].split("T")[0], "%Y-%m-%d")
                 + timedelta(days=2)).strftime("%Y-%m-%d"))
            i['contractPeriod']['startDate'] = "{}T00:00:00+02:00".format(
                (datetime.strptime(i['contractPeriod']['startDate'].split("T")[0], "%Y-%m-%d")
                 + timedelta(days=1)).strftime("%Y-%m-%d"))
    return tender_data


def adapt_one_item(item_data):
    if 'unit' in item_data:
        item_data['unit']['name'] = DZO_dict.get(item_data['unit']['name'])
    if item_data['deliveryAddress']['region'] == u'місто Київ':
        item_data['deliveryAddress']['region'] = u'м. Київ'
    return item_data


def adapt_procuringEntity(tender_data):
    tender_data['data']['procuringEntity']['name'] = u"Байстрюкович і Ко"
    return tender_data


def adapt_address(tender_data):
    for item in tender_data['data']['items']:
        if item['deliveryAddress']['region']:
            item['deliveryAddress']['region'] = u'м. Київ'
    return tender_data


def add_second_sign_after_point(amount):
    amount = str(repr(amount))
    if '.' in amount and len(amount.split('.')[1]) == 1:
        amount += '0'
    return amount


def switch_to_en(url):
    url = url.split('.ua/')
    return url[0] + '.ua/en/' + url[1]


def get_street_from_tuple(string):
    return ','.join(string).strip()


def adapt_items_data(field_name, value):
    if field_name == 'deliveryAddress.countryName':
        value = value.split(',')[1].strip()
    elif field_name == 'deliveryAddress.postalCode':
        value = value.split(',')[0].strip()
    elif field_name == 'deliveryAddress.locality':
        value = value.split(',')[3].strip()
    elif field_name == 'deliveryAddress.streetAddress':
        value = get_street_from_tuple(value.split(',')[4:])
    elif field_name == 'deliveryAddress.region':
        value = value.split(',')[2].strip()
    elif field_name == 'quantity':
        value = float(value)
    elif 'contractPeriod' in field_name:
        value = "{}T00:00:00+02:00".format(convert_date_to_template_format(value, "%d.%m.%Y %H:%M", "%Y-%m-%d"))
    elif field_name != 'deliveryAddress.region' and field_name != 'unit.name':
        value = convert_string_from_dict_dzo(value)
    return value


def adapt_data_editing(field, value):
    if field == 'tenderPeriod.endDate':
        value = convert_date_to_slash_format(value)
    if field == 'minimalStep.amount':
        value = add_second_sign_after_point(value)
    return value


def get_field_locator(fieldname):
    field_locator = 'name=data[' + fieldname.replace('.', '][') + ']'
    return field_locator


def get_claim_status(class_incl):
    for elem in class_incl.split(' '):
        if elem.startswith('compStatus'):
            status = elem.split('_')[1]
    return status


def get_download_file_path():
    return os.path.join(os.getcwd(), 'test_output')


def get_upload_file_path():
    return os.path.join(os.getcwd(), 'src/robot_tests.broker.dzo/testFileForUpload.txt')


def get_relatedItem_description(tender_data, item_id):
    for item in tender_data['data']['items']:
        if item_id == item['id']:
            return item['description']


def get_doc_content(file_name):
    file_name = file_name.replace('/tmp/', '_tmp_')
    path_to_file = get_download_file_path() + '/' + file_name
    downloaded_file = open(path_to_file)
    doc_content = downloaded_file.read()
    downloaded_file.close()
    return str(doc_content), path_to_file


def delete_doc(path_to_file):
    if os.path.exists(path_to_file):
        os.remove(path_to_file)


def dzo_download_file(url, file_name, output_dir):
    urllib.urlretrieve(url, ('{}/{}'.format(output_dir, file_name)))


def check_path_exist(path):
    return os.path.exists(path)


def check_file_exist(path):
    return os.path.isfile(path)


def patch_tender_bid(url, decline, user_id):
    tender_id = url.split('/')[-1]
    url = 'http://www.dz3.byustudio.in.ua/bidAply.php?tender_id={}{}&user_id={}'.format(tender_id, decline, user_id)
    status = urllib.urlopen(url)
    return status.read(), url


def get_award_legal_name(internal_id, award_index):
    r = urllib.urlopen('https://lb.api-sandbox.ea.openprocurement.org/api/2.4/auctions/{}'.format(internal_id)).read()
    auction = json.loads(r)
    return auction['data']['awards'][int(award_index)]["suppliers"][0]['name']
