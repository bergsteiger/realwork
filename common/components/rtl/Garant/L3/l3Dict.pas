unit l3Dict;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3Dict.pas"
// Начат: 11.10.1999 12:50
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3Dict
//
// описание объекта-"словаря"
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3DictionaryPrim,
  l3IDIndex,
  l3Interfaces,
  l3Types
  ;

 {$Define l3Items_NeedsBeforeFreeItem}

 {$Undef l3Items_NoSort}

type
 _l3Dictionary_Parent_ = Tl3DictionaryPrim;
 {$Include ..\L3\l3Dictionary.imp.pas}
 Tl3Dictionary = class(_l3Dictionary_)
  {* Словарь. Используется для преобразования строки в идентификатор и наоборот. Имеет два индекса сортировки }
 end;//Tl3Dictionary

implementation

uses
  l3Base,
  SysUtils,
  l3String
  ;

type _Instance_R_ = Tl3Dictionary;

{$Include ..\L3\l3Dictionary.imp.pas}

end.