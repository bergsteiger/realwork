unit vtOutlinerWithDragDrop;

interface

uses
 l3IntfUses
 , vtOutlinerWithQuickSearch
 , ActiveX
 , l3TreeInterfaces
;

type
 Tl3CanBeginDrag = procedure(const aNode: Il3SimpleNode;
  var aOkEffect: LongInt) of object;
 
 Tl3CanAcceptData = function(const aData: IDataObject): Boolean of object;
 
 Tl3DoDrop = function(const aData: Il3SimpleNode;
  aWantMenu: Boolean;
  var dwEffect: LongInt): Boolean of object;
 
 RvtNodeDataObject = ;
 
 TvtOutlinerWithDragDrop = class(TvtOutlinerWithQuickSearch)
  function CanAcceptData(const aData: IDataObject): Boolean;
  function DataObjectClass: RvtNodeDataObject;
 end;//TvtOutlinerWithDragDrop
 
implementation

uses
 l3ImplUses
 , vtOutlinerWithDragDropRes
 , TtfwClassRef_Proxy
;

end.
