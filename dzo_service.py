# -*- coding: utf-8 -*-

from datetime import datetime, timedelta
from iso8601 import parse_date


DZO_dict = {u'килограммы': u'кг', u'кілограм': u'кг', u'кілограми': u'кг', u'метри': u'м', u'пара': u'пар',
            u'літр': u'л', u'набір': u'наб', u'пачок': u'пач', u'послуга': u'послуги', u'метри кубічні': u'м.куб',
            u'тони': u'т', u'метри квадратні': u'м.кв', u'кілометри': u'км', u'штуки': u'шт', u'місяць': u'міс',
            u'пачка': u'пачка', u'гектар': u'Га', u'лот': u'лот'}

def subtract_from_time(date_time, subtr_min, subtr_sec):
    sub = datetime.strptime(date_time, "%d.%m.%Y %H:%M")
    sub = (sub - timedelta(minutes=int(subtr_min),
                           seconds=int(subtr_sec))).isoformat()
    return sub


def adapt_data_for_role(role_name, tender_data):
    tender_data['data']['procuringEntity']['name'] = u"ТОВ prozorroytenderowner"
    tender_data['data']['procuringEntity']['identifier']['id'] = "31212423"
    tender_data['data']['procuringEntity']['identifier']['legalName'] = u"ТОВ prozorroytenderowner"
    if tender_data['data']['classification']['id'] == "99999999-9":
        tender_data['data']['classification']['description'] = u"Не визначено"
    for item in tender_data['data']['items']:
        item['unit']['name'] = DZO_dict.get(item['unit']['name'], item['unit']['name'])
        date = parse_date(item['deliveryDate']['endDate'])
        date = date.replace(hour=16, minute=0, second=0)
        item['deliveryDate']['endDate'] = "{}{}".format(date.strftime("%Y-%m-%dT%H:%M:%S"), "+02:00")
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
    if "amount" in field_name:
        value_for_return = float(value.replace("`", ""))
    else:
        value_for_return = {
        'ЗАПЛАНОВАНИЙ': "sheduled"
    }.get(value, value)
    return value_for_return