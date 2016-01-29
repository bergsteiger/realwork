unit l3DictionaryPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3DictionaryPrim.pas"
// Начат: 27.02.2010 12:44
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3DictionaryPrim
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
  l3Variant,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

 {$Define l3Items_NeedsBeforeFreeItem}

 {$Undef l3Items_NoSort}

 {$Define l3Items_CaseUnsensitive}

 {$Define l3Items_NeedsAssignItem}

type
 _l3StringList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include ..\L3\l3StringList.imp.pas}
 Tl3DictionaryPrim = class(_l3StringList_)
 end;//Tl3DictionaryPrim

implementation

uses
  l3String,
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = Tl3DictionaryPrim;

{$Include ..\L3\l3StringList.imp.pas}

end.