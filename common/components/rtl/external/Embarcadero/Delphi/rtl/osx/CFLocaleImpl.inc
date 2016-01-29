{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


var
  _kCFLocaleCurrentLocaleDidChangeNotification: Pointer = nil;

  // Locale Keys
  _kCFLocaleIdentifier: Pointer = nil;
  _kCFLocaleLanguageCode: Pointer = nil;
  _kCFLocaleCountryCode: Pointer = nil;
  _kCFLocaleScriptCode: Pointer = nil;
  _kCFLocaleVariantCode: Pointer = nil;

  _kCFLocaleExemplarCharacterSet: Pointer = nil;
  _kCFLocaleCalendarIdentifier: Pointer = nil;
  _kCFLocaleCalendar: Pointer = nil;
  _kCFLocaleCollationIdentifier: Pointer = nil;
  _kCFLocaleUsesMetricSystem: Pointer = nil;
  _kCFLocaleMeasurementSystem: Pointer = nil;
  _kCFLocaleDecimalSeparator: Pointer = nil;
  _kCFLocaleGroupingSeparator: Pointer = nil;
  _kCFLocaleCurrencySymbol: Pointer = nil;
  _kCFLocaleCurrencyCode: Pointer = nil;
  _kCFLocaleCollatorIdentifier: Pointer = nil;
  _kCFLocaleQuotationBeginDelimiterKey: Pointer = nil;
  _kCFLocaleQuotationEndDelimiterKey: Pointer = nil;
  _kCFLocaleAlternateQuotationBeginDelimiterKey: Pointer = nil;
  _kCFLocaleAlternateQuotationEndDelimiterKey: Pointer = nil;

  // Values for kCFLocaleCalendarIdentifier
  _kCFGregorianCalendar: Pointer = nil;
  _kCFBuddhistCalendar: Pointer = nil;
  _kCFChineseCalendar: Pointer = nil;
  _kCFHebrewCalendar: Pointer = nil;
  _kCFIslamicCalendar: Pointer = nil;
  _kCFIslamicCivilCalendar: Pointer = nil;
  _kCFJapaneseCalendar: Pointer = nil;
  _kCFRepublicOfChinaCalendar: Pointer = nil;
  _kCFPersianCalendar: Pointer = nil;
  _kCFIndianCalendar: Pointer = nil;
  _kCFISO8601Calendar: Pointer = nil;

function kCFLocaleCurrentLocaleDidChangeNotification: CFStringRef;
begin
  if _kCFLocaleCurrentLocaleDidChangeNotification = nil then
    _kCFLocaleCurrentLocaleDidChangeNotification := dlsym(CFModule,
      MarshaledAString('kCFLocaleCurrentLocaleDidChangeNotification'));
  Result := CFStringRef(_kCFLocaleCurrentLocaleDidChangeNotification^);
end;

function kCFLocaleIdentifier: CFStringRef;
begin
  if _kCFLocaleIdentifier = nil then
    _kCFLocaleIdentifier := dlsym(CFModule, MarshaledAString('kCFLocaleIdentifier'));
  Result := CFStringRef(_kCFLocaleIdentifier^);
end;

function kCFLocaleLanguageCode: CFStringRef;
begin
  if _kCFLocaleLanguageCode = nil then
    _kCFLocaleLanguageCode := dlsym(CFModule, MarshaledAString('kCFLocaleLanguageCode'));
  Result := CFStringRef(_kCFLocaleLanguageCode^);
end;

function kCFLocaleCountryCode: CFStringRef;
begin
  if _kCFLocaleCountryCode = nil then
    _kCFLocaleCountryCode := dlsym(CFModule, MarshaledAString('kCFLocaleCountryCode'));
  Result := CFStringRef(_kCFLocaleCountryCode^);
end;

function kCFLocaleScriptCode: CFStringRef;
begin
  if _kCFLocaleScriptCode = nil then
    _kCFLocaleScriptCode := dlsym(CFModule, MarshaledAString('kCFLocaleScriptCode'));
  Result := CFStringRef(_kCFLocaleScriptCode^);
end;

function kCFLocaleVariantCode: CFStringRef;
begin
  if _kCFLocaleVariantCode = nil then
    _kCFLocaleVariantCode := dlsym(CFModule, MarshaledAString('kCFLocaleVariantCode'));
  Result := CFStringRef(_kCFLocaleVariantCode^);
end;

function kCFLocaleExemplarCharacterSet: CFStringRef;
begin
  if _kCFLocaleExemplarCharacterSet = nil then
    _kCFLocaleExemplarCharacterSet := dlsym(CFModule, MarshaledAString('kCFLocaleExemplarCharacterSet'));
  Result := CFStringRef(_kCFLocaleExemplarCharacterSet^);
end;

function kCFLocaleCalendarIdentifier: CFStringRef;
begin
  if _kCFLocaleCalendarIdentifier = nil then
    _kCFLocaleCalendarIdentifier := dlsym(CFModule, MarshaledAString('kCFLocaleCalendarIdentifier'));
  Result := CFStringRef(_kCFLocaleCalendarIdentifier^);
end;

function kCFLocaleCalendar: CFStringRef;
begin
  if _kCFLocaleCalendar = nil then
    _kCFLocaleCalendar := dlsym(CFModule, MarshaledAString('kCFLocaleCalendar'));
  Result := CFStringRef(_kCFLocaleCalendar^);
end;

function kCFLocaleCollationIdentifier: CFStringRef;
begin
  if _kCFLocaleCollationIdentifier = nil then
    _kCFLocaleCollationIdentifier := dlsym(CFModule, MarshaledAString('kCFLocaleCollationIdentifier'));
  Result := CFStringRef(_kCFLocaleCollationIdentifier^);
end;

function kCFLocaleUsesMetricSystem: CFStringRef;
begin
  if _kCFLocaleUsesMetricSystem = nil then
    _kCFLocaleUsesMetricSystem := dlsym(CFModule, MarshaledAString('kCFLocaleUsesMetricSystem'));
  Result := CFStringRef(_kCFLocaleUsesMetricSystem^);
end;

function kCFLocaleMeasurementSystem: CFStringRef;
begin
  if _kCFLocaleMeasurementSystem = nil then
    _kCFLocaleMeasurementSystem := dlsym(CFModule, MarshaledAString('kCFLocaleMeasurementSystem'));
  Result := CFStringRef(_kCFLocaleMeasurementSystem^);
end;

function kCFLocaleDecimalSeparator: CFStringRef;
begin
  if _kCFLocaleDecimalSeparator = nil then
    _kCFLocaleDecimalSeparator := dlsym(CFModule, MarshaledAString('kCFLocaleDecimalSeparator'));
  Result := CFStringRef(_kCFLocaleDecimalSeparator^);
end;

function kCFLocaleGroupingSeparator: CFStringRef;
begin
  if _kCFLocaleGroupingSeparator = nil then
    _kCFLocaleGroupingSeparator := dlsym(CFModule, MarshaledAString('kCFLocaleGroupingSeparator'));
  Result := CFStringRef(_kCFLocaleGroupingSeparator^);
end;

function kCFLocaleCurrencySymbol: CFStringRef;
begin
  if _kCFLocaleCurrencySymbol = nil then
    _kCFLocaleCurrencySymbol := dlsym(CFModule, MarshaledAString('kCFLocaleCurrencySymbol'));
  Result := CFStringRef(_kCFLocaleCurrencySymbol^);
end;

function kCFLocaleCurrencyCode: CFStringRef;
begin
  if _kCFLocaleCurrencyCode = nil then
    _kCFLocaleCurrencyCode := dlsym(CFModule, MarshaledAString('kCFLocaleCurrencyCode'));
  Result := CFStringRef(_kCFLocaleCurrencyCode^);
end;

function kCFLocaleCollatorIdentifier: CFStringRef;
begin
  if _kCFLocaleCollatorIdentifier = nil then
    _kCFLocaleCollatorIdentifier := dlsym(CFModule,
      MarshaledAString('kCFLocaleCollatorIdentifier'));
  Result := CFStringRef(_kCFLocaleCollatorIdentifier^);
end;

function kCFLocaleQuotationBeginDelimiterKey: CFStringRef;
begin
  if _kCFLocaleQuotationBeginDelimiterKey = nil then
    _kCFLocaleQuotationBeginDelimiterKey := dlsym(CFModule,
      MarshaledAString('kCFLocaleQuotationBeginDelimiterKey'));
  Result := CFStringRef(_kCFLocaleQuotationBeginDelimiterKey^);
end;

function kCFLocaleQuotationEndDelimiterKey: CFStringRef;
begin
  if _kCFLocaleQuotationEndDelimiterKey = nil then
    _kCFLocaleQuotationEndDelimiterKey := dlsym(CFModule,
      MarshaledAString('kCFLocaleQuotationEndDelimiterKey'));
  Result := CFStringRef(_kCFLocaleQuotationEndDelimiterKey^);
end;

function kCFLocaleAlternateQuotationBeginDelimiterKey: CFStringRef;
begin
  if _kCFLocaleAlternateQuotationBeginDelimiterKey = nil then
    _kCFLocaleAlternateQuotationBeginDelimiterKey := dlsym(CFModule,
      MarshaledAString('kCFLocaleAlternateQuotationBeginDelimiterKey'));
  Result := CFStringRef(_kCFLocaleAlternateQuotationBeginDelimiterKey^);
end;

function kCFLocaleAlternateQuotationEndDelimiterKey: CFStringRef;
begin
  if _kCFLocaleAlternateQuotationEndDelimiterKey = nil then
    _kCFLocaleAlternateQuotationEndDelimiterKey := dlsym(CFModule,
      MarshaledAString('kCFLocaleAlternateQuotationEndDelimiterKey'));
  Result := CFStringRef(_kCFLocaleAlternateQuotationEndDelimiterKey^);
end;

function kCFGregorianCalendar: CFStringRef;
begin
  if _kCFGregorianCalendar = nil then
    _kCFGregorianCalendar := dlsym(CFModule, MarshaledAString('kCFGregorianCalendar'));
  Result := CFStringRef(_kCFGregorianCalendar^);
end;

function kCFBuddhistCalendar: CFStringRef;
begin
  if _kCFBuddhistCalendar = nil then
    _kCFBuddhistCalendar := dlsym(CFModule, MarshaledAString('kCFBuddhistCalendar'));
  Result := CFStringRef(_kCFBuddhistCalendar^);
end;

function kCFChineseCalendar: CFStringRef;
begin
  if _kCFChineseCalendar = nil then
    _kCFChineseCalendar := dlsym(CFModule, MarshaledAString('kCFChineseCalendar'));
  Result := CFStringRef(_kCFChineseCalendar^);
end;

function kCFHebrewCalendar: CFStringRef;
begin
  if _kCFHebrewCalendar = nil then
    _kCFHebrewCalendar := dlsym(CFModule, MarshaledAString('kCFHebrewCalendar'));
  Result := CFStringRef(_kCFHebrewCalendar^);
end;

function kCFIslamicCalendar: CFStringRef;
begin
  if _kCFIslamicCalendar = nil then
    _kCFIslamicCalendar := dlsym(CFModule, MarshaledAString('kCFIslamicCalendar'));
  Result := CFStringRef(_kCFIslamicCalendar^);
end;

function kCFIslamicCivilCalendar: CFStringRef;
begin
  if _kCFIslamicCivilCalendar = nil then
    _kCFIslamicCivilCalendar := dlsym(CFModule, MarshaledAString('kCFIslamicCivilCalendar'));
  Result := CFStringRef(_kCFIslamicCivilCalendar^);
end;

function kCFJapaneseCalendar: CFStringRef;
begin
  if _kCFJapaneseCalendar = nil then
    _kCFJapaneseCalendar := dlsym(CFModule, MarshaledAString('kCFJapaneseCalendar'));
  Result := CFStringRef(_kCFJapaneseCalendar^);
end;

function kCFRepublicOfChinaCalendar: CFStringRef;
begin
  if _kCFRepublicOfChinaCalendar = nil then
    _kCFRepublicOfChinaCalendar := dlsym(CFModule, MarshaledAString('kCFRepublicOfChinaCalendar'));
  Result := CFStringRef(_kCFRepublicOfChinaCalendar^);
end;

function kCFPersianCalendar: CFStringRef;
begin
  if _kCFPersianCalendar = nil then
    _kCFPersianCalendar := dlsym(CFModule, MarshaledAString('kCFPersianCalendar'));
  Result := CFStringRef(_kCFPersianCalendar^);
end;

function kCFIndianCalendar: CFStringRef;
begin
  if _kCFIndianCalendar = nil then
    _kCFIndianCalendar := dlsym(CFModule, MarshaledAString('kCFIndianCalendar'));
  Result := CFStringRef(_kCFIndianCalendar^);
end;

function kCFISO8601Calendar: CFStringRef;
begin
  if _kCFISO8601Calendar = nil then
    _kCFISO8601Calendar := dlsym(CFModule, MarshaledAString('kCFISO8601Calendar'));
  Result := CFStringRef(_kCFISO8601Calendar^);
end;


