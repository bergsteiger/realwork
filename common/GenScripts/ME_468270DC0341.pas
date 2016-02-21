unit nsNodeDataObject;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Components\nsNodeDataObject.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , evNodeDataObject
;

type
 TnsNodeDataObject = class(TevNodeDataObject)
  protected
   function DataClass: RStorable; override;
 end;//TnsNodeDataObject

implementation

uses
 l3ImplUses
 , nsNodeStorable
;

function TnsNodeDataObject.DataClass: RStorable;
//#UC START# *48F8CD5401AD_468270DC0341_var*
//#UC END# *48F8CD5401AD_468270DC0341_var*
begin
//#UC START# *48F8CD5401AD_468270DC0341_impl*
 Result := TnsNodeStorable;
//#UC END# *48F8CD5401AD_468270DC0341_impl*
end;//TnsNodeDataObject.DataClass

end.
