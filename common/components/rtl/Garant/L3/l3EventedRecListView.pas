unit l3EventedRecListView;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3EventedRecListView.pas"
// Начат: 08.06.2011 23:06
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::RecListView::Tl3EventedRecListView
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ProtoPtrRecListPrim,
  l3CustomRecListView
  ;

type
 Tl3CompareItemsEvent = function (anItem1: PItemType;
  anItem2: PItemType): Integer of object;

 Tl3EventedRecListView = class(Tl3CustomRecListView)
 private
 // private fields
   f_CompareItemsEvent : Tl3CompareItemsEvent;
 protected
 // realized methods
   function CompareRecs(aRec1: PItemType;
     aRec2: PItemType): Integer; override;
 public
 // public methods
   constructor Create(aList: Tl3ProtoPtrRecListPrim;
     aCompareItemsEvent: Tl3CompareItemsEvent); reintroduce;
 end;//Tl3EventedRecListView

implementation

// start class Tl3EventedRecListView

constructor Tl3EventedRecListView.Create(aList: Tl3ProtoPtrRecListPrim;
  aCompareItemsEvent: Tl3CompareItemsEvent);
//#UC START# *4DEFC86E0263_4DEFC812022F_var*
//#UC END# *4DEFC86E0263_4DEFC812022F_var*
begin
//#UC START# *4DEFC86E0263_4DEFC812022F_impl*
 Assert(Assigned(aCompareItemsEvent));
 f_CompareItemsEvent := aCompareItemsEvent;
 inherited Create(aList);
//#UC END# *4DEFC86E0263_4DEFC812022F_impl*
end;//Tl3EventedRecListView.Create

function Tl3EventedRecListView.CompareRecs(aRec1: PItemType;
  aRec2: PItemType): Integer;
//#UC START# *4DEFCA7603C4_4DEFC812022F_var*
//#UC END# *4DEFCA7603C4_4DEFC812022F_var*
begin
//#UC START# *4DEFCA7603C4_4DEFC812022F_impl*
 Result := f_CompareItemsEvent(aRec1, aRec2);
//#UC END# *4DEFCA7603C4_4DEFC812022F_impl*
end;//Tl3EventedRecListView.CompareRecs

end.