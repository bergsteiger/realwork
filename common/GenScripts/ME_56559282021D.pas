unit evSCSubAttr;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , evSubCompareInterfaces
;

type
 TevSCSubAttr = class(Tl3ProtoObject, IevSCAttrElement)
  procedure Create(aType: TevSCAttrType;
   aID: Integer;
   aSubID: Integer);
  function Make(aType: TevSCAttrType;
   aID: Integer;
   aSubID: Integer): IevSCAttrElement;
  function AttrType: TevSCAttrType;
  function ID: Integer;
  function SubID: Integer;
 end;//TevSCSubAttr
 
implementation

uses
 l3ImplUses
;

end.
