unit TestStringUtils;
 {* Работа со строками }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\TestStringUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "TestStringUtils" MUID: (499C3E6803D8)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 , Classes
;

procedure Split(Delimiter: AnsiChar;
 const Input: AnsiString;
 Strings: TStrings);
{$IfEnd} // NOT Defined(XE)

implementation

{$If NOT Defined(XE)}
uses
 l3ImplUses
;

procedure Split(Delimiter: AnsiChar;
 const Input: AnsiString;
 Strings: TStrings);
//#UC START# *499C3E8E03D8_499C3E6803D8_var*
//#UC END# *499C3E8E03D8_499C3E6803D8_var*
begin
//#UC START# *499C3E8E03D8_499C3E6803D8_impl*
  Assert(Assigned(Strings)) ;
  Strings.Clear;
  Strings.Delimiter := Char(Delimiter);
  Strings.DelimitedText := Input;
//#UC END# *499C3E8E03D8_499C3E6803D8_impl*
end;//Split
{$IfEnd} // NOT Defined(XE)

end.
