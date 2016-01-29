unit k2CustomTagView;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2CustomTagView.pas"
// Начат: 09.06.2011 17:11
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::TagViews::Tk2CustomTagView
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3Variant,
  l3PureMixIns,
  l3CustomOtherListView
  ;

 {$Define l3ViewListIsTag}

type
 _ListType_ = Tl3Variant;
 _ItemType_ = Tl3Variant;
 {$Include w:\common\components\rtl\Garant\L3\l3OtherTypedListView.imp.pas}
 Tk2CustomTagView = {abstract} class(_l3OtherTypedListView_)
 end;//Tk2CustomTagView

implementation

uses
  l3Base,
  SysUtils
  ;

{$Include w:\common\components\rtl\Garant\L3\l3OtherTypedListView.imp.pas}

end.