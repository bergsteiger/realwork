{$IfNDef afwSettingsPrim_imp}

// Модуль: "w:\common\components\gui\Garant\AFW\afwSettingsPrim.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "afwSettingsPrim" MUID: (4F6C6DF70131)
// Имя типа: "_afwSettingsPrim_"

{$Define afwSettingsPrim_imp}

 _IStringType_ = Il3CString;
 _KeyType_ = TafwSettingId;
 _BooleanType_ = Boolean;
 _nsAbstractSettingsPrim_Parent_ = _afwSettingsPrim_Parent_;
 {$Include w:\common\components\gui\Garant\AFW\nsAbstractSettingsPrim.imp.pas}
 _afwSettingsPrim_ = {abstract} class(_nsAbstractSettingsPrim_)
 end;//_afwSettingsPrim_

{$Else afwSettingsPrim_imp}

{$IfNDef afwSettingsPrim_imp_impl}

{$Define afwSettingsPrim_imp_impl}

function SettingIDtoKeyType(const aSettingID: TafwSettingId): _KeyType_; forward;

function Il3CStringToAString(const aStr: Il3CString): Il3AString; forward;

function StringToPChar(const aString: AnsiString): PAnsiChar; forward;

function IStringTypeToIl3CString(const aStr: _IStringType_): Il3CString;
//#UC START# *4F6C56D90012_4F6C6DF70131_var*
//#UC END# *4F6C56D90012_4F6C6DF70131_var*
begin
//#UC START# *4F6C56D90012_4F6C6DF70131_impl*
 Result := aStr;
//#UC END# *4F6C56D90012_4F6C6DF70131_impl*
end;//IStringTypeToIl3CString

function SettingIDtoKeyType(const aSettingID: TafwSettingId): _KeyType_;
//#UC START# *4F6C651603A5_4F6C6DF70131_var*
//#UC END# *4F6C651603A5_4F6C6DF70131_var*
begin
//#UC START# *4F6C651603A5_4F6C6DF70131_impl*
 Result := aSettingID;
//#UC END# *4F6C651603A5_4F6C6DF70131_impl*
end;//SettingIDtoKeyType

function Il3CStringToAString(const aStr: Il3CString): Il3AString;
//#UC START# *4F6C65E2024F_4F6C6DF70131_var*
//#UC END# *4F6C65E2024F_4F6C6DF70131_var*
begin
//#UC START# *4F6C65E2024F_4F6C6DF70131_impl*
 Result := TafwAString.Make(aStr);
//#UC END# *4F6C65E2024F_4F6C6DF70131_impl*
end;//Il3CStringToAString

function StringToPChar(const aString: AnsiString): PAnsiChar;
//#UC START# *4F6C699E009A_4F6C6DF70131_var*
//#UC END# *4F6C699E009A_4F6C6DF70131_var*
begin
//#UC START# *4F6C699E009A_4F6C6DF70131_impl*
 Result := PAnsiChar(aString); 
//#UC END# *4F6C699E009A_4F6C6DF70131_impl*
end;//StringToPChar

{$Include w:\common\components\gui\Garant\AFW\nsAbstractSettingsPrim.imp.pas}

{$EndIf afwSettingsPrim_imp_impl}

{$EndIf afwSettingsPrim_imp}

