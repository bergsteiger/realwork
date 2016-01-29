{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


var
  _kCFNumberFormatterCurrencyCode: Pointer = nil;
  _kCFNumberFormatterDecimalSeparator: Pointer = nil;
  _kCFNumberFormatterCurrencyDecimalSeparator: Pointer = nil;
  _kCFNumberFormatterAlwaysShowDecimalSeparator: Pointer = nil;
  _kCFNumberFormatterGroupingSeparator: Pointer = nil;
  _kCFNumberFormatterUseGroupingSeparator: Pointer = nil;
  _kCFNumberFormatterPercentSymbol: Pointer = nil;
  _kCFNumberFormatterZeroSymbol: Pointer = nil;
  _kCFNumberFormatterNaNSymbol: Pointer = nil;
  _kCFNumberFormatterInfinitySymbol: Pointer = nil;
  _kCFNumberFormatterMinusSign: Pointer = nil;
  _kCFNumberFormatterPlusSign: Pointer = nil;
  _kCFNumberFormatterCurrencySymbol: Pointer = nil;
  _kCFNumberFormatterExponentSymbol: Pointer = nil;
  _kCFNumberFormatterMinIntegerDigits: Pointer = nil;
  _kCFNumberFormatterMaxIntegerDigits: Pointer = nil;
  _kCFNumberFormatterMinFractionDigits: Pointer = nil;
  _kCFNumberFormatterMaxFractionDigits: Pointer = nil;
  _kCFNumberFormatterGroupingSize: Pointer = nil;
  _kCFNumberFormatterSecondaryGroupingSize: Pointer = nil;
  _kCFNumberFormatterRoundingMode: Pointer = nil;
  _kCFNumberFormatterRoundingIncrement: Pointer = nil;
  _kCFNumberFormatterFormatWidth: Pointer = nil;
  _kCFNumberFormatterPaddingPosition: Pointer = nil;
  _kCFNumberFormatterPaddingCharacter: Pointer = nil;
  _kCFNumberFormatterDefaultFormat: Pointer = nil;
  _kCFNumberFormatterMultiplier: Pointer = nil;
  _kCFNumberFormatterPositivePrefix: Pointer = nil;
  _kCFNumberFormatterPositiveSuffix: Pointer = nil;
  _kCFNumberFormatterNegativePrefix: Pointer = nil;
  _kCFNumberFormatterNegativeSuffix: Pointer = nil;
  _kCFNumberFormatterPerMillSymbol: Pointer = nil;
  _kCFNumberFormatterInternationalCurrencySymbol: Pointer = nil;
  _kCFNumberFormatterCurrencyGroupingSeparator: Pointer = nil;
  _kCFNumberFormatterIsLenient: Pointer = nil;
  _kCFNumberFormatterUseSignificantDigits: Pointer = nil;
  _kCFNumberFormatterMinSignificantDigits: Pointer = nil;
  _kCFNumberFormatterMaxSignificantDigits: Pointer = nil;

function kCFNumberFormatterCurrencyCode: CFStringRef;
begin
  if _kCFNumberFormatterCurrencyCode = nil then
    _kCFNumberFormatterCurrencyCode := dlsym(CFModule, MarshaledAString('kCFNumberFormatterCurrencyCode'));
  Result := CFStringRef(_kCFNumberFormatterCurrencyCode^);
end;

function kCFNumberFormatterDecimalSeparator: CFStringRef;
begin
  if _kCFNumberFormatterDecimalSeparator = nil then
    _kCFNumberFormatterDecimalSeparator := dlsym(CFModule, MarshaledAString('kCFNumberFormatterDecimalSeparator'));
  Result := CFStringRef(_kCFNumberFormatterDecimalSeparator^);
end;

function kCFNumberFormatterCurrencyDecimalSeparator: CFStringRef;
begin
  if _kCFNumberFormatterCurrencyDecimalSeparator = nil then
    _kCFNumberFormatterCurrencyDecimalSeparator := dlsym(CFModule, MarshaledAString('kCFNumberFormatterCurrencyDecimalSeparator'));
  Result := CFStringRef(_kCFNumberFormatterCurrencyDecimalSeparator^);
end;

function kCFNumberFormatterAlwaysShowDecimalSeparator: CFStringRef;
begin
  if _kCFNumberFormatterAlwaysShowDecimalSeparator = nil then
    _kCFNumberFormatterAlwaysShowDecimalSeparator := dlsym(CFModule, MarshaledAString('kCFNumberFormatterAlwaysShowDecimalSeparator'));
  Result := CFStringRef(_kCFNumberFormatterAlwaysShowDecimalSeparator^);
end;

function kCFNumberFormatterGroupingSeparator: CFStringRef;
begin
  if _kCFNumberFormatterGroupingSeparator = nil then
    _kCFNumberFormatterGroupingSeparator := dlsym(CFModule, MarshaledAString('kCFNumberFormatterGroupingSeparator'));
  Result := CFStringRef(_kCFNumberFormatterGroupingSeparator^);
end;

function kCFNumberFormatterUseGroupingSeparator: CFStringRef;
begin
  if _kCFNumberFormatterUseGroupingSeparator = nil then
    _kCFNumberFormatterUseGroupingSeparator := dlsym(CFModule, MarshaledAString('kCFNumberFormatterUseGroupingSeparator'));
  Result := CFStringRef(_kCFNumberFormatterUseGroupingSeparator^);
end;

function kCFNumberFormatterPercentSymbol: CFStringRef;
begin
  if _kCFNumberFormatterPercentSymbol = nil then
    _kCFNumberFormatterPercentSymbol := dlsym(CFModule, MarshaledAString('kCFNumberFormatterPercentSymbol'));
  Result := CFStringRef(_kCFNumberFormatterPercentSymbol^);
end;

function kCFNumberFormatterZeroSymbol: CFStringRef;
begin
  if _kCFNumberFormatterZeroSymbol = nil then
    _kCFNumberFormatterZeroSymbol := dlsym(CFModule, MarshaledAString('kCFNumberFormatterZeroSymbol'));
  Result := CFStringRef(_kCFNumberFormatterZeroSymbol^);
end;

function kCFNumberFormatterNaNSymbol: CFStringRef;
begin
  if _kCFNumberFormatterNaNSymbol = nil then
    _kCFNumberFormatterNaNSymbol := dlsym(CFModule, MarshaledAString('kCFNumberFormatterNaNSymbol'));
  Result := CFStringRef(_kCFNumberFormatterNaNSymbol^);
end;

function kCFNumberFormatterInfinitySymbol: CFStringRef;
begin
  if _kCFNumberFormatterInfinitySymbol = nil then
    _kCFNumberFormatterInfinitySymbol := dlsym(CFModule, MarshaledAString('kCFNumberFormatterInfinitySymbol'));
  Result := CFStringRef(_kCFNumberFormatterInfinitySymbol^);
end;

function kCFNumberFormatterMinusSign: CFStringRef;
begin
  if _kCFNumberFormatterMinusSign = nil then
    _kCFNumberFormatterMinusSign := dlsym(CFModule, MarshaledAString('kCFNumberFormatterMinusSign'));
  Result := CFStringRef(_kCFNumberFormatterMinusSign^);
end;

function kCFNumberFormatterPlusSign: CFStringRef;
begin
  if _kCFNumberFormatterPlusSign = nil then
    _kCFNumberFormatterPlusSign := dlsym(CFModule, MarshaledAString('kCFNumberFormatterPlusSign'));
  Result := CFStringRef(_kCFNumberFormatterPlusSign^);
end;

function kCFNumberFormatterCurrencySymbol: CFStringRef;
begin
  if _kCFNumberFormatterCurrencySymbol = nil then
    _kCFNumberFormatterCurrencySymbol := dlsym(CFModule, MarshaledAString('kCFNumberFormatterCurrencySymbol'));
  Result := CFStringRef(_kCFNumberFormatterCurrencySymbol^);
end;

function kCFNumberFormatterExponentSymbol: CFStringRef;
begin
  if _kCFNumberFormatterExponentSymbol = nil then
    _kCFNumberFormatterExponentSymbol := dlsym(CFModule, MarshaledAString('kCFNumberFormatterExponentSymbol'));
  Result := CFStringRef(_kCFNumberFormatterExponentSymbol^);
end;

function kCFNumberFormatterMinIntegerDigits: CFStringRef;
begin
  if _kCFNumberFormatterMinIntegerDigits = nil then
    _kCFNumberFormatterMinIntegerDigits := dlsym(CFModule, MarshaledAString('kCFNumberFormatterMinIntegerDigits'));
  Result := CFStringRef(_kCFNumberFormatterMinIntegerDigits^);
end;

function kCFNumberFormatterMaxIntegerDigits: CFStringRef;
begin
  if _kCFNumberFormatterMaxIntegerDigits = nil then
    _kCFNumberFormatterMaxIntegerDigits := dlsym(CFModule, MarshaledAString('kCFNumberFormatterMaxIntegerDigits'));
  Result := CFStringRef(_kCFNumberFormatterMaxIntegerDigits^);
end;

function kCFNumberFormatterMinFractionDigits: CFStringRef;
begin
  if _kCFNumberFormatterMinFractionDigits = nil then
    _kCFNumberFormatterMinFractionDigits := dlsym(CFModule, MarshaledAString('kCFNumberFormatterMinFractionDigits'));
  Result := CFStringRef(_kCFNumberFormatterMinFractionDigits^);
end;

function kCFNumberFormatterMaxFractionDigits: CFStringRef;
begin
  if _kCFNumberFormatterMaxFractionDigits = nil then
    _kCFNumberFormatterMaxFractionDigits := dlsym(CFModule, MarshaledAString('kCFNumberFormatterMaxFractionDigits'));
  Result := CFStringRef(_kCFNumberFormatterMaxFractionDigits^);
end;

function kCFNumberFormatterGroupingSize: CFStringRef;
begin
  if _kCFNumberFormatterGroupingSize = nil then
    _kCFNumberFormatterGroupingSize := dlsym(CFModule, MarshaledAString('kCFNumberFormatterGroupingSize'));
  Result := CFStringRef(_kCFNumberFormatterGroupingSize^);
end;

function kCFNumberFormatterSecondaryGroupingSize: CFStringRef;
begin
  if _kCFNumberFormatterSecondaryGroupingSize = nil then
    _kCFNumberFormatterSecondaryGroupingSize := dlsym(CFModule, MarshaledAString('kCFNumberFormatterSecondaryGroupingSize'));
  Result := CFStringRef(_kCFNumberFormatterSecondaryGroupingSize^);
end;

function kCFNumberFormatterRoundingMode: CFStringRef;
begin
  if _kCFNumberFormatterRoundingMode = nil then
    _kCFNumberFormatterRoundingMode := dlsym(CFModule, MarshaledAString('kCFNumberFormatterRoundingMode'));
  Result := CFStringRef(_kCFNumberFormatterRoundingMode^);
end;

function kCFNumberFormatterRoundingIncrement: CFStringRef;
begin
  if _kCFNumberFormatterRoundingIncrement = nil then
    _kCFNumberFormatterRoundingIncrement := dlsym(CFModule, MarshaledAString('kCFNumberFormatterRoundingIncrement'));
  Result := CFStringRef(_kCFNumberFormatterRoundingIncrement^);
end;

function kCFNumberFormatterFormatWidth: CFStringRef;
begin
  if _kCFNumberFormatterFormatWidth = nil then
    _kCFNumberFormatterFormatWidth := dlsym(CFModule, MarshaledAString('kCFNumberFormatterFormatWidth'));
  Result := CFStringRef(_kCFNumberFormatterFormatWidth^);
end;

function kCFNumberFormatterPaddingPosition: CFStringRef;
begin
  if _kCFNumberFormatterPaddingPosition = nil then
    _kCFNumberFormatterPaddingPosition := dlsym(CFModule, MarshaledAString('kCFNumberFormatterPaddingPosition'));
  Result := CFStringRef(_kCFNumberFormatterPaddingPosition^);
end;

function kCFNumberFormatterPaddingCharacter: CFStringRef;
begin
  if _kCFNumberFormatterPaddingCharacter = nil then
    _kCFNumberFormatterPaddingCharacter := dlsym(CFModule, MarshaledAString('kCFNumberFormatterPaddingCharacter'));
  Result := CFStringRef(_kCFNumberFormatterPaddingCharacter^);
end;

function kCFNumberFormatterDefaultFormat: CFStringRef;
begin
  if _kCFNumberFormatterDefaultFormat = nil then
    _kCFNumberFormatterDefaultFormat := dlsym(CFModule, MarshaledAString('kCFNumberFormatterDefaultFormat'));
  Result := CFStringRef(_kCFNumberFormatterDefaultFormat^);
end;

function kCFNumberFormatterMultiplier: CFStringRef;
begin
  if _kCFNumberFormatterMultiplier = nil then
    _kCFNumberFormatterMultiplier := dlsym(CFModule, MarshaledAString('kCFNumberFormatterMultiplier'));
  Result := CFStringRef(_kCFNumberFormatterMultiplier^);
end;

function kCFNumberFormatterPositivePrefix: CFStringRef;
begin
  if _kCFNumberFormatterPositivePrefix = nil then
    _kCFNumberFormatterPositivePrefix := dlsym(CFModule, MarshaledAString('kCFNumberFormatterPositivePrefix'));
  Result := CFStringRef(_kCFNumberFormatterPositivePrefix^);
end;

function kCFNumberFormatterPositiveSuffix: CFStringRef;
begin
  if _kCFNumberFormatterPositiveSuffix = nil then
    _kCFNumberFormatterPositiveSuffix := dlsym(CFModule, MarshaledAString('kCFNumberFormatterPositiveSuffix'));
  Result := CFStringRef(_kCFNumberFormatterPositiveSuffix^);
end;

function kCFNumberFormatterNegativePrefix: CFStringRef;
begin
  if _kCFNumberFormatterNegativePrefix = nil then
    _kCFNumberFormatterNegativePrefix := dlsym(CFModule, MarshaledAString('kCFNumberFormatterNegativePrefix'));
  Result := CFStringRef(_kCFNumberFormatterNegativePrefix^);
end;

function kCFNumberFormatterNegativeSuffix: CFStringRef;
begin
  if _kCFNumberFormatterNegativeSuffix = nil then
    _kCFNumberFormatterNegativeSuffix := dlsym(CFModule, MarshaledAString('kCFNumberFormatterNegativeSuffix'));
  Result := CFStringRef(_kCFNumberFormatterNegativeSuffix^);
end;

function kCFNumberFormatterPerMillSymbol: CFStringRef;
begin
  if _kCFNumberFormatterPerMillSymbol = nil then
    _kCFNumberFormatterPerMillSymbol := dlsym(CFModule, MarshaledAString('kCFNumberFormatterPerMillSymbol'));
  Result := CFStringRef(_kCFNumberFormatterPerMillSymbol^);
end;

function kCFNumberFormatterInternationalCurrencySymbol: CFStringRef;
begin
  if _kCFNumberFormatterInternationalCurrencySymbol = nil then
    _kCFNumberFormatterInternationalCurrencySymbol := dlsym(CFModule, MarshaledAString('kCFNumberFormatterInternationalCurrencySymbol'));
  Result := CFStringRef(_kCFNumberFormatterInternationalCurrencySymbol^);
end;

function kCFNumberFormatterCurrencyGroupingSeparator: CFStringRef;
begin
  if _kCFNumberFormatterCurrencyGroupingSeparator = nil then
    _kCFNumberFormatterCurrencyGroupingSeparator := dlsym(CFModule, MarshaledAString('kCFNumberFormatterCurrencyGroupingSeparator'));
  Result := CFStringRef(_kCFNumberFormatterCurrencyGroupingSeparator^);
end;

function kCFNumberFormatterIsLenient: CFStringRef;
begin
  if _kCFNumberFormatterIsLenient = nil then
    _kCFNumberFormatterIsLenient := dlsym(CFModule, MarshaledAString('kCFNumberFormatterIsLenient'));
  Result := CFStringRef(_kCFNumberFormatterIsLenient^);
end;

function kCFNumberFormatterUseSignificantDigits: CFStringRef;
begin
  if _kCFNumberFormatterUseSignificantDigits = nil then
    _kCFNumberFormatterUseSignificantDigits := dlsym(CFModule, MarshaledAString('kCFNumberFormatterUseSignificantDigits'));
  Result := CFStringRef(_kCFNumberFormatterUseSignificantDigits^);
end;

function kCFNumberFormatterMinSignificantDigits: CFStringRef;
begin
  if _kCFNumberFormatterMinSignificantDigits = nil then
    _kCFNumberFormatterMinSignificantDigits := dlsym(CFModule, MarshaledAString('kCFNumberFormatterMinSignificantDigits'));
  Result := CFStringRef(_kCFNumberFormatterMinSignificantDigits^);
end;

function kCFNumberFormatterMaxSignificantDigits: CFStringRef;
begin
  if _kCFNumberFormatterMaxSignificantDigits = nil then
    _kCFNumberFormatterMaxSignificantDigits := dlsym(CFModule, MarshaledAString('kCFNumberFormatterMaxSignificantDigits'));
  Result := CFStringRef(_kCFNumberFormatterMaxSignificantDigits^);
end;


