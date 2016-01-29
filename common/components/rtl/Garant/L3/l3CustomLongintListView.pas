unit l3CustomLongintListView;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3CustomLongintListView.pas"
// Начат: 08.06.2011 21:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::Containers::Tl3CustomLongintListView
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3LongintList,
  l3PureMixIns,
  l3CustomOtherListView
  ;

type
 _ListType_ = Tl3LongintList;
 _ItemType_ = Integer;
 {$Include ..\L3\l3OtherTypedListView.imp.pas}
 Tl3CustomLongintListView = {abstract} class(_l3OtherTypedListView_)
 end;//Tl3CustomLongintListView

implementation

uses
  l3Base,
  SysUtils
  ;

{$Include ..\L3\l3OtherTypedListView.imp.pas}

end.