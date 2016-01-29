unit evSubCompareInterfaces;

interface

uses
 l3IntfUses
;

type
 TevSCAttrType = (
  sca_Class
  , sca_Type
  , sca_Link
  , sca_Keyword
 );//TevSCAttrType
 
 IevSCAttrElement = interface
 end;//IevSCAttrElement
 
 TevSCSubType = (
  sct_Block
  , sct_Label
 );//TevSCSubType
 
 IevSCSub = interface
  procedure Add(const aAttr: IevSCAttrElement);
 end;//IevSCSub
 
implementation

uses
 l3ImplUses
;

end.
