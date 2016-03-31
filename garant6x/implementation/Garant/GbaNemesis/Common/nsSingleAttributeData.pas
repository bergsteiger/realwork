unit nsSingleAttributeData;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsSingleAttributeData.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsSingleAttributeData" MUID: (48F72B630069)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , evNodeData
;

type
 TnsSingleAttributeData = class(TevNodeData)
  protected
   function ExtDataClass: RDataClass; override;
 end;//TnsSingleAttributeData
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsSingleAttributeDataObject
;

function TnsSingleAttributeData.ExtDataClass: RDataClass;
//#UC START# *48F8D47302FD_48F72B630069_var*
//#UC END# *48F8D47302FD_48F72B630069_var*
begin
//#UC START# *48F8D47302FD_48F72B630069_impl*
 Result := TnsSingleAttributeDataObject;
//#UC END# *48F8D47302FD_48F72B630069_impl*
end;//TnsSingleAttributeData.ExtDataClass
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
