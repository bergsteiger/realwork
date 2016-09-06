unit atStringToBitMaskConverterBase;

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atStringToBitMaskConverterBase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatStringToBitMaskConverterBase" MUID: (504F268A02FD)

interface

uses
 l3IntfUses
 , SysUtils
;

type
 _BitMaskValueType_ = AnsiString;
 _BitMaskType_ = Integer;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atBitMaskConverter.imp.pas}
 _atStringConverterImp_Parent_ = _atBitMaskConverter_;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atStringConverterImp.imp.pas}
 TatStringToBitMaskConverterBase = {abstract} class(_atStringConverterImp_)
  public
   function ToMaskCI(const aValues: array of _BitMaskValueType_): _BitMaskType_; virtual;
   function ToValues(const aMask: _BitMaskType_;
    const aDelim: AnsiString): AnsiString; overload; virtual;
 end;//TatStringToBitMaskConverterBase

implementation

uses
 l3ImplUses
 , TypInfo
 //#UC START# *504F268A02FDimpl_uses*
 //#UC END# *504F268A02FDimpl_uses*
;

{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atBitMaskConverter.imp.pas}

{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atStringConverterImp.imp.pas}

function TatStringToBitMaskConverterBase.ToMaskCI(const aValues: array of _BitMaskValueType_): _BitMaskType_;
//#UC START# *504F3866005D_504F268A02FD_var*
  var
    i : Integer;
//#UC END# *504F3866005D_504F268A02FD_var*
begin
//#UC START# *504F3866005D_504F268A02FD_impl*
  Result := 0;
  for i := Low(aValues) to High(aValues) do
    Result := Result OR ToValueCI(aValues[i]);
//#UC END# *504F3866005D_504F268A02FD_impl*
end;//TatStringToBitMaskConverterBase.ToMaskCI

function TatStringToBitMaskConverterBase.ToValues(const aMask: _BitMaskType_;
 const aDelim: AnsiString): AnsiString;
//#UC START# *504F8645031F_504F268A02FD_var*
  var
    l_Arr : TBitMaskValues;
    i : Integer;
//#UC END# *504F8645031F_504F268A02FD_var*
begin
//#UC START# *504F8645031F_504F268A02FD_impl*
  Result := '';
  l_Arr := ToValues(aMask);
  if l_Arr <> nil then
  begin
    for i := Low(l_Arr) to High(l_Arr) do
      Result := Result + l_Arr[i] + aDelim;
    SetLength(Result, Length(Result) - Length(aDelim));
  end;
//#UC END# *504F8645031F_504F268A02FD_impl*
end;//TatStringToBitMaskConverterBase.ToValues

initialization
{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atBitMaskConverter.imp.pas}


end.
