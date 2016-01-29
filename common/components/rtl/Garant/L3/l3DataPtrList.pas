unit l3DataPtrList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3DataPtrList.pas"
// Начат: 07.02.2008 10:10
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3DataPtrList
//
// Список указателей на куски памяти. Ничего не освобождает.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3SimpleDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Pointer;
 _l3DataPtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include ..\L3\l3DataPtrList.imp.pas}
 Tl3DataPtrList = class(_l3DataPtrList_)
  {* Список указателей на куски памяти. Ничего не освобождает. }
 end;//Tl3DataPtrList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = Tl3DataPtrList;

{$Include ..\L3\l3DataPtrList.imp.pas}

end.