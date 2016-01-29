unit evSCCollectFilter;

interface

uses
 l3IntfUses
 , evdBufferedFilter
 , evSCSubList
 , evSubCompareInterfaces
 , l3Variant
 , k2TagGen
;

type
 TevSCCollectFilter = class(TevdBufferedFilter)
  procedure AddToSub(const aSub: IevSCSub;
   aAttrType: TevSCAttrType;
   aTag: Tl3Variant);
 end;//TevSCCollectFilter
 
implementation

uses
 l3ImplUses
 , SysUtils
 , Block_Const
 , k2Tags
 , evSCSub
 , evSCSubAttr
 , evdTypes
 , Address_Const
 , Document_Const
;

end.
