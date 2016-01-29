unit nscTreeViewHotTruck;

interface

uses
 l3IntfUses
 , nscTreeView
 , Messages
 , Classes
 , l3Interfaces
 , Graphics
 , vtLister
;

type
 TOnAllowHotTruck = procedure(Sender: TObject;
  anIndex: Integer;
  var Allow: Boolean) of object;
 
 TnscTreeViewHotTruck = class(TnscTreeView)
  procedure SetHotTruckIndex(aValue: Integer);
  procedure UpdateTruckFromCursor;
  procedure CMMouseLeave(var Message: TMessage);
 end;//TnscTreeViewHotTruck
 
implementation

uses
 l3ImplUses
 , Windows
 , TtfwClassRef_Proxy
;

end.
