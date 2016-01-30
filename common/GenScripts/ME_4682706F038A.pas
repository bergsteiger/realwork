unit nsSingleAttributeDataObject;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsSingleAttributeDataObject.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , evNodeDataObject
;

type
 TnsSingleAttributeDataObject = class(TevNodeDataObject)
  protected
   function DataClass: RStorable; override;
 end;//TnsSingleAttributeDataObject
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsSingleAttributeStorable
;

function TnsSingleAttributeDataObject.DataClass: RStorable;
//#UC START# *48F8CD5401AD_4682706F038A_var*
//#UC END# *48F8CD5401AD_4682706F038A_var*
begin
//#UC START# *48F8CD5401AD_4682706F038A_impl*
 Result := TnsSingleAttributeStorable;
//#UC END# *48F8CD5401AD_4682706F038A_impl*
end;//TnsSingleAttributeDataObject.DataClass
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
