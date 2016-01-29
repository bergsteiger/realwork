unit l3StringMap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/Implementation/l3StringMap.pas"
// Начат: 01.03.2010 16:25
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::L3 for VCM::Tl3StringMap
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3StringMapPrim,
  l3KeyWrd,
  l3IDIndex,
  l3Interfaces,
  l3Types
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
 {$Define l3Items_NeedsBeforeFreeItem}

 {$Undef l3Items_NoSort}

type
 _l3Dictionary_Parent_ = Tl3StringMapPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Dictionary.imp.pas}
 Tl3StringMap = class(_l3Dictionary_)
 private
 // private fields
   f_Hi : Integer;
 public
 // public methods
   function ResolveString(const aString: AnsiString): Integer;
     {* Возвращает идентификатор строки }
 end;//Tl3StringMap
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base,
  SysUtils,
  l3String
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

type _Instance_R_ = Tl3StringMap;

{$Include w:\common\components\rtl\Garant\L3\l3Dictionary.imp.pas}

// start class Tl3StringMap

function Tl3StringMap.ResolveString(const aString: AnsiString): Integer;
//#UC START# *4B8BC0D40179_4B8BC059018C_var*
//#UC END# *4B8BC0D40179_4B8BC059018C_var*
var
 l_Item : Tl3KeyWord;
begin
//#UC START# *4B8BC0D40179_4B8BC059018C_impl*
 l_Item := Tl3KeyWord(DRByName[aString]);
 if (l_Item = nil) then
 begin
  l_Item := Tl3KeyWord.Create(aString, f_Hi);
  try
   Add(l_Item);
  finally
   l3Free(l_Item);
  end;{try..finally}
  Result := f_Hi;
  Inc(f_Hi);
 end else
  Result := l_Item.StringID;
//#UC END# *4B8BC0D40179_4B8BC059018C_impl*
end;//Tl3StringMap.ResolveString

{$IfEnd} //not NoVCM

end.