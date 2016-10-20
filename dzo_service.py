# !/usr/bin/python
# -*- coding: utf-8 -*-

from datetime import datetime, timedelta
from iso8601 import parse_date
import os
import urllib

DZO_dict = {u'килограммы': u'кг', u'кілограм': u'кг', u'кілограми': u'кг', u'метри': u'м', u'пара': u'пар',
            u'літр': u'л', u'набір': u'наб', u'пачок': u'пач', u'послуга': u'послуги', u'метри кубічні': u'м.куб',
            u'тони': u'т', u'метри квадратні': u'м.кв', u'кілометри': u'км', u'штуки': u'шт', u'місяць': u'міс',
            u'пачка': u'пачка', u'упаковка': u'уп', u'гектар': u'Га', u'лот': u'лот', u"грн": u"UAH",
            u"(з ПДВ)": u"True", u"(без ПДВ)": u"false", u"Код CAV": u"CAV", u"Код ДК": u"ДКПП",
            u"ДК": u"ДКПП", u"Відкриті торги": u"aboveThresholdUA",
            u"Відкриті торги з публікацією англ.мовою": u"aboveThresholdEU", u"Переможець": u"active",
            u"місто Київ": u"м. Київ", u"НЕЦІНОВІ КРИТЕРІЇ ДО ПРЕДМЕТУ ЗАКУПІВЛІ": u"item",
            u"НЕЦІНОВІ КРИТЕРІЇ ДО ЛОТУ": u"lot", u"ПЕРІОД УТОЧНЕНЬ": u"active.enquiries",
            u"ПОДАННЯ ПРОПОЗИЦІЙ": u"active.tendering", u"ПРЕДКВАЛІФІКАЦІЯ": u"active.pre-qualification",
            u"АУКЦІОН": u"active.auction", u"НА РОЗГЛЯДІ": u"claim"}


def convert_date_to_slash_format(isodate):
    iso_dt = parse_date(isodate)
    date_string = iso_dt.strftime("%d/%m/%Y")
    return date_string


def subtract_from_time(date_time, subtr_min, subtr_sec):
    sub = datetime.strptime(date_time, "%d.%m.%Y %H:%M")
    sub = (sub - timedelta(minutes=int(subtr_min),
                           seconds=int(subtr_sec))).isoformat()
    return str(sub) + '.000000+03:00'


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
        tender_data = adapt_unit_names(adapt_procuringEntity(adapt_address(adapt_delivery_end_date(tender_data))))
    return tender_data


def adapt_unit_names(tender_data):
    if 'unit' in tender_data['data']['items'][0]:
        for i in tender_data['data']['items']:
            i['unit']['name'] = DZO_dict[i['unit']['name']]
    return tender_data


def adapt_one_item(item_data):
    if 'unit' in item_data:
        item_data['unit']['name'] = DZO_dict.get(item_data['unit']['name'])
    if item_data['deliveryAddress']['region'] == u'місто Київ':
        item_data['deliveryAddress']['region'] = u'м. Київ'
    return item_data


def adapt_procuringEntity(tender_data):
    tender_data['data']['procuringEntity']['name'] = u"Володілець"
    tender_data['data']['procuringEntity']['contactPoint']['name'] = u"Той Кого Не Можна Називати"
    tender_data['data']['procuringEntity']['contactPoint']['telephone'] = u"+380878787887"
    tender_data['data']['procuringEntity']['contactPoint']['email'] = u"ovramet.s@gmail.com"
    tender_data['data']['procuringEntity']['contactPoint']['url'] = u"http://byustudio.in.ua"
    tender_data['data']['procuringEntity']['identifier']['scheme'] = u"UA-EDR"
    tender_data['data']['procuringEntity']['identifier']['id'] = u"11112122"
    tender_data['data']['procuringEntity']['identifier']['legalName'] = u"ПрАТ <Комбайн Інк.>"
    tender_data['data']['procuringEntity']['address']['postalCode'] = u"11111"
    tender_data['data']['procuringEntity']['address']['countryName'] = u"Україна"
    tender_data['data']['procuringEntity']['address']['streetAddress'] = u"Жовківська, 35/3"
    tender_data['data']['procuringEntity']['address']['region'] = u"Львівська область"
    tender_data['data']['procuringEntity']['address']['locality'] = u"Жовква"
    return tender_data


def adapt_address(tender_data):
    for item in tender_data['data']['items']:
        if item['deliveryAddress']['region']:
            item['deliveryAddress']['region'] = u'м. Київ'
    return tender_data


def adapt_delivery_end_date(tender_data):
    for item in tender_data['data']['items']:
        end_date = item['deliveryDate']['endDate'].split('+')
        end_date_mod = datetime.strptime(end_date[0], "%Y-%m-%dT%H:%M:%S.%f")
        end_date_mod = str(end_date_mod.replace(hour=16, minute=00).strftime("%Y-%m-%dT%H:%M:%S")) + '+' + end_date[1]
        item['deliveryDate']['endDate'] = end_date_mod
    return tender_data


def add_second_sign_after_point(amount):
    amount = str(repr(amount))
    if '.' in amount and len(amount.split('.')[1]) == 1:
        amount += '0'
    return amount


def switch_to_en(url):
    url = url.split('.ua/')
    return url[0] + '.ua/en/' + url[1]


def convert_cause_dzo(cause):
    return {
        u'cт. 35, п 1': u'artContestIP',
        u'cт. 35, п 2': u'noCompetition',
        u'cт. 35, п 3': u'quick',
        u'cт. 35, п 4': u'twiceUnsuccessful',
        u'cт. 35, п 5': u'additionalPurchase',
        u'cт. 35, п 6': u'additionalConstruction',
        u'cт. 35, п7 ': u'stateLegalServices'
    }.get(cause[0:11], cause[0:11])


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
        value = int(value)
    elif field_name != 'deliveryAddress.region' and field_name != 'unit.name':
        value = convert_string_from_dict_dzo(value)
    elif field_name == 'deliveryDate.endDate':
        value += '00.000000+03:00'
    return value


def adapt_lot_data(field_name, value):
    if field_name == 'value.amount':
        value = float(value.replace("`", ""))
    elif field_name == 'value.currency':
        value = convert_string_from_dict_dzo(value)
    elif 'valueAddedTaxIncluded' in field_name:
        value = bool(convert_string_from_dict_dzo(value))
    elif field_name == 'minimalStep.amount':
        value = float(value.replace("`", ""))
    elif field_name == 'minimalStep.currency':
        value = convert_string_from_dict_dzo(value)
    return value


def adapt_feature_data(field_name, value):
    if field_name == 'featureOf':
        value = convert_string_from_dict_dzo(value)
    elif field_name == 'code':
        value = value.split(': ')[0]
    return value


def adapt_data_for_document(field, value):
    if field == 'tenderPeriod.endDate':
        value = convert_date_to_slash_format(value)
    return value


def get_lot_title(related_id, tender_data):
    for item in tender_data['data']['items']:
        if 'id' in item and item['id'] == related_id:
            related_id = item['relatedLot']
    for lot in tender_data['data']['lots']:
        if lot['id'] == related_id:
            lot_title = lot['title']
    return lot_title.split(':')[0]


def get_item_rel_id(tender_data, item_id):
    for item in tender_data:
        if item_id in item['description']:
            item_rel_id = item['id']
    return item_rel_id


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