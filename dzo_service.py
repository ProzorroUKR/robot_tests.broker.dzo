# -*- coding: utf-8 -*-

from datetime import datetime, timedelta
from iso8601 import parse_date


DZO_dict = {u'килограммы': u'кг', u'кілограм': u'кг', u'кілограми': u'кг', u'метри': u'м', u'пара': u'пар',
            u'літр': u'л', u'набір': u'наб', u'пачок': u'пач', u'послуга': u'послуги', u'метри кубічні': u'м.куб',
            u'тони': u'т', u'метри квадратні': u'м.кв', u'кілометри': u'км', u'штуки': u'шт', u'місяць': u'міс',
            u'пачка': u'пачка', u'упаковка': u'уп', u'гектар': u'Га', u'лот': u'лот', u"грн": u"UAH",
            u"(з ПДВ)": u"True", u"(без ПДВ)": u"false", u"Код CAV": u"CAV", u"Переможець": u"active",
            u"місто Київ": u"м. Київ", u"ПЕРІОД УТОЧНЕНЬ": u"active.enquiries",
            u"ПОДАННЯ ПРОПОЗИЦІЙ": u"active.tendering", u"ПРЕДКВАЛІФІКАЦІЯ": u"active.pre-qualification",
            u"АУКЦІОН": u"active.auction", u"КВАЛІФІКАЦІЯ ПЕРЕМОЖЦЯ": u"active.qualification",
            u"ТОРГИ НЕ ВІДБУЛИСЯ": u"unsuccessful", u"ТОРГИ ВІДМІНЕНО": u"cancelled", u"ТОРГИ ЗАВЕРШЕНО": u"complete",
            u"НА РОЗГЛЯДІ": u"claim", u"Протокол торгів": u"auctionProtocol",
            u"Оголошення аукціону з продажу майна банків": u"dgfOtherAssets",
            u"Оголошення аукціону з продажу прав вимоги за кредитами банків": u"dgfFinancialAssets", u'вперше': 1,
            u'повторно (вдруге)': 2, u'повторно (втретє)': 3, u'повторно (вчетверте)': 4,
            u'Попередню кваліфікацію скасовано': u'cancelled', u'Дискваліфіковано': u'unsuccessful'}

def subtract_from_time(date_time, subtr_min, subtr_sec):
    sub = datetime.strptime(date_time, "%d.%m.%Y %H:%M")
    sub = (sub - timedelta(minutes=int(subtr_min),
                           seconds=int(subtr_sec))).isoformat()
    return sub


def convert_datetime_to_format(date, output_format):
    date_obj = parse_date(date)
    day_string = date_obj.strftime(output_format)
    return day_string


def adapt_data_for_role(role_name, tender_data):
    if role_name == "tender_owner":
        tender_data['data']['procuringEntity']['name'] = u"ТОВ prozorroytenderowner"
        tender_data['data']['procuringEntity']['identifier']['id'] = "00037256"
        tender_data['data']['procuringEntity']['identifier']['legalName'] = u"ТОВ prozorroytenderowner"
        if "classification" in tender_data['data'] and tender_data['data']['classification']['id'] == "99999999-9":
            tender_data['data']['classification']['description'] = u"Не визначено"
        for item in tender_data['data']['items']:
            item['unit']['name'] = DZO_dict.get(item['unit']['name'], item['unit']['name'])
            date = parse_date(item['deliveryDate']['endDate'])
            date = date.replace(hour=16, minute=0, second=0)
            item['deliveryDate']['endDate'] = "{}{}".format(date.strftime("%Y-%m-%dT%H:%M:%S"), "+02:00")
            item['deliveryAddress']['region'] = item['deliveryAddress']['region'].replace(u"місто Київ", u"м. Київ")
            if item['classification']['id'] == "99999999-9":
                item['classification']['description'] = u"Не визначено"

    return tender_data


def add_second_sign_after_point(amount):
    amount = str(repr(amount))
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
    if "amount" in field_name or "duration.days" in field_name:
        value_for_return = float(value.replace("`", ""))
    else:
        value_for_return = {
            u'ЗАПЛАНОВАНИЙ': "sheduled",
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
            u'Допорогові закупівлі': "belowThreshold",
            u'грн': "UAH",
            u'Код в ЄДРПОУ / ІПН': "UA-EDR",
            u'Класифікація за ДК 021-2015 (CPV)': u"ДК021"
    }.get(value, value)
    return value_for_return


def convert_string_from_dict_dzo(string):
    return DZO_dict.get(string, string)


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
    return value