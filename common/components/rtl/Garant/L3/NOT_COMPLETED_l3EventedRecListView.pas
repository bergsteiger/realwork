unit NOT_COMPLETED_l3EventedRecListView;

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_COMPLETED_l3EventedRecListView.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3EventedRecListView" MUID: (4DEFC812022F)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3CustomRecListView
 , l3ProtoPtrRecListPrim
;

type
 Tl3CompareItemsEvent = function(anItem1: PItemType;
  anItem2: PItemType): Integer of object;

 Tl3EventedRecListView = class(Tl3CustomRecListView)
  private
   f_CompareItemsEvent: Tl3CompareItemsEvent;
  protected
   function CompareRecs(aRec1: PItemType;
    aRec2: PItemType): Integer; override;
  public
   constructor Create(aList: Tl3ProtoPtrRecListPrim;
    aCompareItemsEvent: Tl3CompareItemsEvent); reintroduce;
 end;//Tl3EventedRecListView

implementation

uses
 l3ImplUses
;

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
