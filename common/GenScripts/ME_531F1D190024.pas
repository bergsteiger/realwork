unit k2ChildrenPath;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Types
;

type
 Tk2ChildrenPath = class(Tl3ProtoObject)
  procedure Create(aTagType: Integer;
   const aPath: TLongArray);
 end;//Tk2ChildrenPath
 
implementation

uses
 l3ImplUses
;

end.
