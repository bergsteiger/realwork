unit k2Dictionary;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2Dictionary.pas"
// Начат: 11.10.1999 12:08
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2Dictionary
//
// Словарь.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2DictionaryPrim,
  k2DictionaryIDIndex,
  l3Variant,
  l3Interfaces,
  l3Types
  ;

type
 _IDIndexType_ = Tk2DictionaryIDIndex;
 _StringType_ = Tl3Variant;
 _l3DictionaryPrim_Parent_ = Tk2DictionaryPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3DictionaryPrim.imp.pas}
 Tk2Dictionary = class(_l3DictionaryPrim_)
  {* Словарь. }
 end;//Tk2Dictionary

implementation

uses
  l3String,
  k2Tags,
  k2BaseTypes,
  l3Base,
  SysUtils
  ;

// start class Tk2Dictionary

function ItemToWStr(const anItem: _ItemType_): Tl3WString;
//#UC START# *5304D6C5002B_4860AF86034F_var*
//#UC END# *5304D6C5002B_4860AF86034F_var*
begin
//#UC START# *5304D6C5002B_4860AF86034F_impl*
 Result := anItem.PCharLenA[k2_tiName];
//#UC END# *5304D6C5002B_4860AF86034F_impl*
end;//ItemToWStr

type _Instance_R_ = Tk2Dictionary;

{$Include w:\common\components\rtl\Garant\L3\l3DictionaryPrim.imp.pas}

end.