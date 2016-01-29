unit vgObject;

interface

uses
 l3IntfUses
 , vgCustomObject
 , vgAnyObjectList
 , vgSortableObjectList
 , vgCustomObjectList
;

type
 TvgObject = class(TvgCustomObject)
  procedure AddObjectsToList(aList: TvgCustomObjectList);
  procedure AddControlsToList(aList: TvgCustomObjectList);
  function IsVisual: Boolean;
 end;//TvgObject
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
