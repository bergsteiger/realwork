unit ddAppConfigConst;

// Модуль: "w:\common\components\rtl\Garant\dd\ddAppConfigConst.pas"
// Стереотип: "UtilityPack"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
;

const
 ddEmptyValue: TddConfigValue = (Kind: dd_vkString; AsString: '');
 ddEmptyIntValue: TddConfigValue = (Kind: dd_vkInteger; AsInteger: 0);
 ddEmptyDateValue: TddConfigValue = (Kind: dd_vkDateTime; AsDateTime: 1);
 ddEmptyObjectValue: TddConfigValue = (Kind: dd_vkObject; AsObject: nil);
 c_ConfigItemLeft = 10;
 c_ConfigItemTop = 4;
 ddBooleanNames: ddStringArrayOfBool = ('False', 'True');
 ddPasswordChar: AnsiChar = #149;
 ddRequiredSign: AnsiChar = '*';
 ddRequiredFont: AnsiString = 'Windings2';
 {$If Defined(ddUseVTSpin)}
 ddMaxInt = High(Integer);
 {$IfEnd} // Defined(ddUseVTSpin)
 {$If NOT Defined(ddUseVTSpin)}
 ddMaxInt = High(SmallInt);
 {$IfEnd} // NOT Defined(ddUseVTSpin)
 {$If Defined(ddUseVTSpin)}
 ddMinInt = Succ(Low(Integer));
 {$IfEnd} // Defined(ddUseVTSpin)
 {$If NOT Defined(ddUseVTSpin)}
 ddMinInt = Succ(Low(Smallint));
 {$IfEnd} // NOT Defined(ddUseVTSpin)

type
 TddValueKind = (
  dd_vkString
  , dd_vkInteger
  , dd_vkBoolean
  , dd_vkDateTime
  , dd_vkObject
 );//TddValueKind

 TddConfigValue = record
  Kind: TddValueKind;
  AsString: ShortString;
  AsInteger: Integer;
  AsBoolean: Boolean;
  AsDateTime: TDateTime;
  AsObject: TObject;
 end;//TddConfigValue

 TddConfigItemType = (
  dd_citUserDefined
  , dd_citGroup
  , dd_citString
  , dd_citBoolean
  , dd_citInteger
  , dd_citRadioGroup
  , dd_citDate
  , dd_citTime
  , dd_citFileName
  , dd_citFolderName
  , dd_citList
  , dd_citColorName
  , dd_citFont
 );//TddConfigItemType

 ddStringArrayOfBool = array [Boolean] of AnsiString;

function EmptyConfigValue: TddConfigValue;
function IsValueEmpty(const aValue: TddConfigValue): Boolean;
function MakeIntValue(aValue: Integer): TddConfigValue;
function MakeBoolValue(aValue: Boolean = False): TddConfigValue;
function MakeDateValue(aDateTime: TDateTime): TddConfigValue; overload;
function MakeDateValue(aYear: Word = 0;
 aMonth: Word = 1;
 aDay: Word = 1): TddConfigValue; overload;
function MakeStrValue(const aValue: AnsiString): TddConfigValue;

var c_ScrollBarWidth: Integer;
var c_ConfigItemRight: Integer;

implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , Windows
;

function EmptyConfigValue: TddConfigValue;
//#UC START# *522DAC7C00FA_4E304DD10316_var*
//#UC END# *522DAC7C00FA_4E304DD10316_var*
begin
//#UC START# *522DAC7C00FA_4E304DD10316_impl*
 l3FillChar(Result, SizeOf(Result), 0);
//#UC END# *522DAC7C00FA_4E304DD10316_impl*
end;//EmptyConfigValue

function IsValueEmpty(const aValue: TddConfigValue): Boolean;
//#UC START# *522DAC9D010F_4E304DD10316_var*
//#UC END# *522DAC9D010F_4E304DD10316_var*
begin
//#UC START# *522DAC9D010F_4E304DD10316_impl*
 case aValue.Kind of
  dd_vkString:  Result := aValue.AsString = '';
  dd_vkDateTime: Result := aValue.AsDateTime = 0;
  dd_vkObject : Result:= aValue.AsObject = nil;
 else
  Result := False;
 end;
//#UC END# *522DAC9D010F_4E304DD10316_impl*
end;//IsValueEmpty

function MakeIntValue(aValue: Integer): TddConfigValue;
//#UC START# *522DADCB0268_4E304DD10316_var*
//#UC END# *522DADCB0268_4E304DD10316_var*
begin
//#UC START# *522DADCB0268_4E304DD10316_impl*
 Result := ddEmptyIntValue;
 Result.AsInteger:= aValue;
//#UC END# *522DADCB0268_4E304DD10316_impl*
end;//MakeIntValue

function MakeBoolValue(aValue: Boolean = False): TddConfigValue;
//#UC START# *522DADEB02C0_4E304DD10316_var*
//#UC END# *522DADEB02C0_4E304DD10316_var*
begin
//#UC START# *522DADEB02C0_4E304DD10316_impl*
 Result := ddEmptyValue;
 Result.Kind:= dd_vkBoolean;
 Result.AsBoolean:= aValue;
//#UC END# *522DADEB02C0_4E304DD10316_impl*
end;//MakeBoolValue

function MakeDateValue(aDateTime: TDateTime): TddConfigValue;
//#UC START# *522DAE100037_4E304DD10316_var*
//#UC END# *522DAE100037_4E304DD10316_var*
begin
//#UC START# *522DAE100037_4E304DD10316_impl*
 Result := ddEmptyValue;
 Result.Kind:= dd_vkDateTime;
 Result.AsDateTime:= aDateTime;
//#UC END# *522DAE100037_4E304DD10316_impl*
end;//MakeDateValue

function MakeDateValue(aYear: Word = 0;
 aMonth: Word = 1;
 aDay: Word = 1): TddConfigValue;
//#UC START# *522DAE820041_4E304DD10316_var*
//#UC END# *522DAE820041_4E304DD10316_var*
begin
//#UC START# *522DAE820041_4E304DD10316_impl*
 Result := ddEmptyValue;
 Result.Kind:= dd_vkDateTime;
 Result.AsDateTime:= EncodeDate(aYear, aMonth, aDay);
//#UC END# *522DAE820041_4E304DD10316_impl*
end;//MakeDateValue

function MakeStrValue(const aValue: AnsiString): TddConfigValue;
//#UC START# *522DAEA70090_4E304DD10316_var*
//#UC END# *522DAEA70090_4E304DD10316_var*
begin
//#UC START# *522DAEA70090_4E304DD10316_impl*
 Result := ddEmptyValue;
 Result.AsString:= aValue;
//#UC END# *522DAEA70090_4E304DD10316_impl*
end;//MakeStrValue

initialization
//#UC START# *522DAA88028E*
 c_ScrollBarWidth := GetSystemMetrics(SM_CYVSCROLL);
 c_ConfigItemRight := 10;
//#UC END# *522DAA88028E*

end.
