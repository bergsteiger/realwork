unit l3LongintList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3LongintList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3LongintList
//
// Список целых чисел
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3LongintListPrim
  ;

type
 _ListType_ = Tl3LongintListPrim;
 _l3ListOperations_Parent_ = Tl3LongintListPrim;
 {$Include ..\L3\l3ListOperations.imp.pas}
 Tl3LongintList = class(_l3ListOperations_)
  {* Список целых чисел }
 end;//Tl3LongintList

implementation

{$Include ..\L3\l3ListOperations.imp.pas}

end.