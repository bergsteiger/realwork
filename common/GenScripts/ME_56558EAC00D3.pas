unit evSCSub;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , evSubCompareInterfaces
 , evSCSubAttrList
;

type
 TevSCSub = class(Tl3ProtoObject, IevSCSub)
  procedure Create(aSubType: TevSCSubType);
  function Make(aSubType: TevSCSubType): IevSCSub;
  function Handle: Integer;
  function AttrCount: Integer;
  function Attr: IevSCAttrElement;
  procedure Add(const aAttr: IevSCAttrElement);
  function SubType: TevSCSubType;
 end;//TevSCSub
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Types
;

end.
