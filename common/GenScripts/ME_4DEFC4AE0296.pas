unit l3CustomRecListView;

interface

uses
 l3IntfUses
 , l3ProtoPtrRecListPrim
 , l3PureMixIns
;

type
 Tl3CustomRecListView = class(_l3OtherListView_)
  function CompareRecs(aRec1: PItemType;
   aRec2: PItemType): Integer;
  function CompareData(const anItem1: _ItemType_;
   const anItem2: _ItemType_): Integer;
 end;//Tl3CustomRecListView
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
;

end.
