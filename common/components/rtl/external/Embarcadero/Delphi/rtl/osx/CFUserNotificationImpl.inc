{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


function CFUserNotificationCheckBoxChecked(i: CFIndex): CFOptionFlags;
begin
  Result := 1 shl (8 + i);
end;

function CFUserNotificationSecureTextField(i: CFIndex): CFOptionFlags;
begin
  Result := 1 shl (16 + i);
end;

function CFUserNotificationPopUpSelection(n: CFIndex): CFOptionFlags;
begin
  Result := n shl 24;
end;


var
  _kCFUserNotificationIconURLKey: Pointer = nil;
  _kCFUserNotificationSoundURLKey: Pointer = nil;
  _kCFUserNotificationLocalizationURLKey: Pointer = nil;
  _kCFUserNotificationAlertHeaderKey: Pointer = nil;
  _kCFUserNotificationAlertMessageKey: Pointer = nil;
  _kCFUserNotificationDefaultButtonTitleKey: Pointer = nil;
  _kCFUserNotificationAlternateButtonTitleKey: Pointer = nil;
  _kCFUserNotificationOtherButtonTitleKey: Pointer = nil;
  _kCFUserNotificationProgressIndicatorValueKey: Pointer = nil;
  _kCFUserNotificationPopUpTitlesKey: Pointer = nil;
  _kCFUserNotificationTextFieldTitlesKey: Pointer = nil;
  _kCFUserNotificationCheckBoxTitlesKey: Pointer = nil;
  _kCFUserNotificationTextFieldValuesKey: Pointer = nil;
  _kCFUserNotificationPopUpSelectionKey: Pointer = nil;
  _kCFUserNotificationAlertTopMostKey: Pointer = nil;
  _kCFUserNotificationKeyboardTypesKey: Pointer = nil;

function kCFUserNotificationIconURLKey: CFStringRef;
begin
  if _kCFUserNotificationIconURLKey = nil then
    _kCFUserNotificationIconURLKey := dlsym(CFModule, MarshaledAString('kCFUserNotificationIconURLKey'));
  Result := CFStringRef(_kCFUserNotificationIconURLKey^);
end;

function kCFUserNotificationSoundURLKey: CFStringRef;
begin
  if _kCFUserNotificationSoundURLKey = nil then
    _kCFUserNotificationSoundURLKey := dlsym(CFModule, MarshaledAString('kCFUserNotificationSoundURLKey'));
  Result := CFStringRef(_kCFUserNotificationSoundURLKey^);
end;

function kCFUserNotificationLocalizationURLKey: CFStringRef;
begin
  if _kCFUserNotificationLocalizationURLKey = nil then
    _kCFUserNotificationLocalizationURLKey := dlsym(CFModule, MarshaledAString('kCFUserNotificationLocalizationURLKey'));
  Result := CFStringRef(_kCFUserNotificationLocalizationURLKey^);
end;

function kCFUserNotificationAlertHeaderKey: CFStringRef;
begin
  if _kCFUserNotificationAlertHeaderKey = nil then
    _kCFUserNotificationAlertHeaderKey := dlsym(CFModule, MarshaledAString('kCFUserNotificationAlertHeaderKey'));
  Result := CFStringRef(_kCFUserNotificationAlertHeaderKey^);
end;

function kCFUserNotificationAlertMessageKey: CFStringRef;
begin
  if _kCFUserNotificationAlertMessageKey = nil then
    _kCFUserNotificationAlertMessageKey := dlsym(CFModule, MarshaledAString('kCFUserNotificationAlertMessageKey'));
  Result := CFStringRef(_kCFUserNotificationAlertMessageKey^);
end;

function kCFUserNotificationDefaultButtonTitleKey: CFStringRef;
begin
  if _kCFUserNotificationDefaultButtonTitleKey = nil then
    _kCFUserNotificationDefaultButtonTitleKey := dlsym(CFModule, MarshaledAString('kCFUserNotificationDefaultButtonTitleKey'));
  Result := CFStringRef(_kCFUserNotificationDefaultButtonTitleKey^);
end;

function kCFUserNotificationAlternateButtonTitleKey: CFStringRef;
begin
  if _kCFUserNotificationAlternateButtonTitleKey = nil then
    _kCFUserNotificationAlternateButtonTitleKey := dlsym(CFModule, MarshaledAString('kCFUserNotificationAlternateButtonTitleKey'));
  Result := CFStringRef(_kCFUserNotificationAlternateButtonTitleKey^);
end;

function kCFUserNotificationOtherButtonTitleKey: CFStringRef;
begin
  if _kCFUserNotificationOtherButtonTitleKey = nil then
    _kCFUserNotificationOtherButtonTitleKey := dlsym(CFModule, MarshaledAString('kCFUserNotificationOtherButtonTitleKey'));
  Result := CFStringRef(_kCFUserNotificationOtherButtonTitleKey^);
end;

function kCFUserNotificationProgressIndicatorValueKey: CFStringRef;
begin
  if _kCFUserNotificationProgressIndicatorValueKey = nil then
    _kCFUserNotificationProgressIndicatorValueKey := dlsym(CFModule, MarshaledAString('kCFUserNotificationProgressIndicatorValueKey'));
  Result := CFStringRef(_kCFUserNotificationProgressIndicatorValueKey^);
end;

function kCFUserNotificationPopUpTitlesKey: CFStringRef;
begin
  if _kCFUserNotificationPopUpTitlesKey = nil then
    _kCFUserNotificationPopUpTitlesKey := dlsym(CFModule, MarshaledAString('kCFUserNotificationPopUpTitlesKey'));
  Result := CFStringRef(_kCFUserNotificationPopUpTitlesKey^);
end;

function kCFUserNotificationTextFieldTitlesKey: CFStringRef;
begin
  if _kCFUserNotificationTextFieldTitlesKey = nil then
    _kCFUserNotificationTextFieldTitlesKey := dlsym(CFModule, MarshaledAString('kCFUserNotificationTextFieldTitlesKey'));
  Result := CFStringRef(_kCFUserNotificationTextFieldTitlesKey^);
end;

function kCFUserNotificationCheckBoxTitlesKey: CFStringRef;
begin
  if _kCFUserNotificationCheckBoxTitlesKey = nil then
    _kCFUserNotificationCheckBoxTitlesKey := dlsym(CFModule, MarshaledAString('kCFUserNotificationCheckBoxTitlesKey'));
  Result := CFStringRef(_kCFUserNotificationCheckBoxTitlesKey^);
end;

function kCFUserNotificationTextFieldValuesKey: CFStringRef;
begin
  if _kCFUserNotificationTextFieldValuesKey = nil then
    _kCFUserNotificationTextFieldValuesKey := dlsym(CFModule, MarshaledAString('kCFUserNotificationTextFieldValuesKey'));
  Result := CFStringRef(_kCFUserNotificationTextFieldValuesKey^);
end;

function kCFUserNotificationPopUpSelectionKey: CFStringRef;
begin
  if _kCFUserNotificationPopUpSelectionKey = nil then
    _kCFUserNotificationPopUpSelectionKey := dlsym(CFModule, MarshaledAString('kCFUserNotificationPopUpSelectionKey'));
  Result := CFStringRef(_kCFUserNotificationPopUpSelectionKey^);
end;

(*
{$IF DEFINED(TARGET_OS_EMBEDDED) OR DEFINED(TARGET_OS_IPHONE)}
function kCFUserNotificationAlertTopMostKey: CFStringRef;
begin
  if _kCFUserNotificationAlertTopMostKey = nil then
    _kCFUserNotificationAlertTopMostKey := dlsym(CFModule, PAnsiChar('kCFUserNotificationAlertTopMostKey'));
  Result := CFStringRef(_kCFUserNotificationAlertTopMostKey^);
end;

function kCFUserNotificationKeyboardTypesKey: CFStringRef;
begin
  if _kCFUserNotificationKeyboardTypesKey = nil then
    _kCFUserNotificationKeyboardTypesKey := dlsym(CFModule, PAnsiChar('kCFUserNotificationKeyboardTypesKey'));
  Result := CFStringRef(_kCFUserNotificationKeyboardTypesKey^);
end;
{$ENDIF}
*)

