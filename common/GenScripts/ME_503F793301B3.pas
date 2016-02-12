unit atStringToStringConverterBase;

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atStringToStringConverterBase.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
;

type
 _FirstType_ = AnsiString;
 _SecondType_ = AnsiString;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atConverter.imp.pas}
 TatStringToStringConverterBase = {abstract} class(_atConverter_)
  public
   function FirstToSecondCI(const aFirst: _FirstType_): _SecondType_; virtual;
   function SecondToFirstCI(const aSecond: _SecondType_): _FirstType_; virtual;
 end;//TatStringToStringConverterBase

implementation

uses
 l3ImplUses
 , TypInfo
;

{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atConverter.imp.pas}

function TatStringToStringConverterBase.FirstToSecondCI(const aFirst: _FirstType_): _SecondType_;
//#UC START# *503F7A2601F6_503F793301B3_var*
  var
    i : Integer;
//#UC END# *503F7A2601F6_503F793301B3_var*
begin
//#UC START# *503F7A2601F6_503F793301B3_impl*
  for i := Low(f_ConvertMap) to High(f_ConvertMap) do
    if AnsiSameText(aFirst, f_ConvertMap[i].First) then
    begin
      Result := f_ConvertMap[i].Second;
      Exit;
    end;
  Error1St(aFirst);
//#UC END# *503F7A2601F6_503F793301B3_impl*
end;//TatStringToStringConverterBase.FirstToSecondCI

function TatStringToStringConverterBase.SecondToFirstCI(const aSecond: _SecondType_): _FirstType_;
//#UC START# *503F7A40002D_503F793301B3_var*
  var
    i : Integer;
//#UC END# *503F7A40002D_503F793301B3_var*
begin
//#UC START# *503F7A40002D_503F793301B3_impl*
  for i := Low(f_ConvertMap) to High(f_ConvertMap) do
    if AnsiSameText(aSecond, f_ConvertMap[i].Second) then
    begin
      Result := f_ConvertMap[i].First;
      Exit;
    end;
  Error2nd(aSecond);
//#UC END# *503F7A40002D_503F793301B3_impl*
end;//TatStringToStringConverterBase.SecondToFirstCI

end.
