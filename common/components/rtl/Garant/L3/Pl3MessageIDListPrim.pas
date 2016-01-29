unit Pl3MessageIDListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/Pl3MessageIDListPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::Поддержка локализованных сообщений::TPl3MessageIDListPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ProtoDataContainer,
  l3MessageID,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Pl3MessageID;
 _l3AtomicListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include ..\L3\l3AtomicListPrim.imp.pas}
 TPl3MessageIDListPrim = class(_l3AtomicListPrim_)
 end;//TPl3MessageIDListPrim

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TPl3MessageIDListPrim

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4F9BCAD90297_var*
//#UC END# *47B99D4503A2_4F9BCAD90297_var*
begin
//#UC START# *47B99D4503A2_4F9BCAD90297_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4F9BCAD90297_impl*
end;//CompareExistingItems

type _Instance_R_ = TPl3MessageIDListPrim;

{$Include ..\L3\l3AtomicListPrim.imp.pas}

end.