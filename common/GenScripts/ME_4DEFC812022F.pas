unit l3EventedRecListView;

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
  procedure Create(aList: Tl3ProtoPtrRecListPrim;
   aCompareItemsEvent: Tl3CompareItemsEvent);
  function CompareRecs(aRec1: PItemType;
   aRec2: PItemType): Integer;
 end;//Tl3EventedRecListView
 
implementation

uses
 l3ImplUses
;

end.
