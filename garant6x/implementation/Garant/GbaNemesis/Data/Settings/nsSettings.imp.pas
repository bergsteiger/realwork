{$IfNDef nsSettings_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Settings\nsSettings.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "nsSettings" MUID: (4F6C571A00B2)
// Имя типа: "_nsSettings_"

{$Define nsSettings_imp}

 _IStringType_ = IString;
 _KeyType_ = PAnsiChar;
 _BooleanType_ = ByteBool;
 _nsAbstractSettingsPrim_Parent_ = _nsSettings_Parent_;
 {$Include w:\common\components\gui\Garant\AFW\nsAbstractSettingsPrim.imp.pas}
 _nsSettings_ = {abstract} class(_nsAbstractSettingsPrim_)
 end;//_nsSettings_

{$Else nsSettings_imp}

{$IfNDef nsSettings_imp_impl}

{$Define nsSettings_imp_impl}

function SettingIDtoKeyType(const aSettingID: TafwSettingId): _KeyType_; forward;

function Il3CStringToAString(const aStr: Il3CString): Il3AString; forward;

function StringToPChar(const aString: AnsiString): PAnsiChar; forward;

function IStringTypeToIl3CString(const aStr: _IStringType_): Il3CString;
//#UC START# *4F6C56D90012_4F6C571A00B2_var*
//#UC END# *4F6C56D90012_4F6C571A00B2_var*
begin
//#UC START# *4F6C56D90012_4F6C571A00B2_impl*
 Result := nsCStr(aStr);
//#UC END# *4F6C56D90012_4F6C571A00B2_impl*
end;//IStringTypeToIl3CString

function SettingIDtoKeyType(const aSettingID: TafwSettingId): _KeyType_;
//#UC START# *4F6C651603A5_4F6C571A00B2_var*
//#UC END# *4F6C651603A5_4F6C571A00B2_var*
begin
//#UC START# *4F6C651603A5_4F6C571A00B2_impl*
 Result := nsAStr(aSettingID);
//#UC END# *4F6C651603A5_4F6C571A00B2_impl*
end;//SettingIDtoKeyType

function Il3CStringToAString(const aStr: Il3CString): Il3AString;
//#UC START# *4F6C65E2024F_4F6C571A00B2_var*
//#UC END# *4F6C65E2024F_4F6C571A00B2_var*
begin
//#UC START# *4F6C65E2024F_4F6C571A00B2_impl*
 Result := nsAStr(aStr);
//#UC END# *4F6C65E2024F_4F6C571A00B2_impl*
end;//Il3CStringToAString

function StringToPChar(const aString: AnsiString): PAnsiChar;
//#UC START# *4F6C699E009A_4F6C571A00B2_var*
//#UC END# *4F6C699E009A_4F6C571A00B2_var*
begin
//#UC START# *4F6C699E009A_4F6C571A00B2_impl*
 Result := nsAStr(aString);
//#UC END# *4F6C699E009A_4F6C571A00B2_impl*
end;//StringToPChar

{$Include w:\common\components\gui\Garant\AFW\nsAbstractSettingsPrim.imp.pas}

{$EndIf nsSettings_imp_impl}

{$EndIf nsSettings_imp}

