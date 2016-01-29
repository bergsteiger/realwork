unit l3FontManagerPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3FontManagerPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3Canvas::Tl3FontManagerPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3LogFont,
  l3FontManagerPrimPrim,
  l3Interfaces,
  l3Types
  ;

type
 _StringType_ = Tl3LogFont;
 _l3DictionaryPrimPrim_Parent_ = Tl3FontManagerPrimPrim;
 {$Include ..\L3\l3DictionaryPrimPrim.imp.pas}
 Tl3FontManagerPrim = class(_l3DictionaryPrimPrim_)
 end;//Tl3FontManagerPrim

implementation

uses
  l3String
  ;

// start class Tl3FontManagerPrim

function ItemToWStr(const anItem: _ItemType_): Tl3WString;
//#UC START# *5304D6C5002B_5314807A0393_var*
//#UC END# *5304D6C5002B_5314807A0393_var*
begin
//#UC START# *5304D6C5002B_5314807A0393_impl*
 Result := anItem.AsWStr;
//#UC END# *5304D6C5002B_5314807A0393_impl*
end;//ItemToWStr

type _Instance_R_ = Tl3FontManagerPrim;

{$Include ..\L3\l3DictionaryPrimPrim.imp.pas}

end.