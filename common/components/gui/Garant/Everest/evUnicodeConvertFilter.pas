unit evUnicodeConvertFilter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evUnicodeConvertFilter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Generators::TevUnicodeConvertFilter
//
// Фильтр, преобразующий Unicode в кодировку по умолчанию.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2TagFilter,
  l3Variant
  ;

type
 TevUnicodeConvertFilter = class(Tk2TagFilter)
  {* Фильтр, преобразующий Unicode в кодировку по умолчанию. }
 protected
 // overridden protected methods
   procedure AddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
 end;//TevUnicodeConvertFilter

implementation

uses
  k2Tags,
  l3Base,
  l3StringEx,
  l3Interfaces
  ;

// start class TevUnicodeConvertFilter

procedure TevUnicodeConvertFilter.AddAtomEx(AtomIndex: Integer;
  const Value: Ik2Variant);
//#UC START# *4836D52400D9_52EB5D3401B7_var*
var
 l_OS       : Tl3WString;
 l_Str      : Tl3Str;
 l_Old      : Tl3PrimString;
 l_New      : Tl3PrimString;
// l_NewValue : Tk2Variant;
//#UC END# *4836D52400D9_52EB5D3401B7_var*
begin
//#UC START# *4836D52400D9_52EB5D3401B7_impl*
 if (AtomIndex = k2_tiText) then
 begin
  if (Value.Kind = k2_vkString) then
  begin
   l_Old := Value.AsString;
   l_OS := l_Old.AsWStr;
   if (l_OS.SCodePage = CP_Unicode) then
   begin
    l_Str.Init(l_Old.AsWStr, CS_Default);
    l_New := l_Old.Clone;
    try
     l_New.AsWStr := l_Str;
     AddStringAtom(AtomIndex, l_New.AsWStr);
//     l_NewValue.Kind := k2_vkString;
//     l_NewValue.AsString := l_New;
//     inherited AddAtomEx(AtomIndex, l_NewValue)
    finally
     l_Str.Clear;
     l3Free(l_New);
    end;{try..finally}
   end // if (l_OS.SCodePage = CP_Unicode) then
   else
    inherited AddAtomEx(AtomIndex, Value);
  end  // if (Value.Kind = k2_vkString) then
  else
   ConvertErrorEx(Value.Kind);
 end // if (AtomIndex = k2_tiText) then
 else
  inherited AddAtomEx(AtomIndex, Value)
//#UC END# *4836D52400D9_52EB5D3401B7_impl*
end;//TevUnicodeConvertFilter.AddAtomEx

end.