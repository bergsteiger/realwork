unit dsBasesAccess;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\dsBasesAccess.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsBasesAccess" MUID: (495504A000F2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , dsTreeAttributeSelect
 , SearchDomainInterfaces
;

type
 TdsBasesAccess = class(TdsTreeAttributeSelect)
  protected
   function GetOperations: TLogicOperationSet; override;
 end;//TdsBasesAccess
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 //#UC START# *495504A000F2impl_uses*
 //#UC END# *495504A000F2impl_uses*
;

function TdsBasesAccess.GetOperations: TLogicOperationSet;
//#UC START# *492406340209_495504A000F2_var*
//#UC END# *492406340209_495504A000F2_var*
begin
//#UC START# *492406340209_495504A000F2_impl*
 Result := [loNot];
//#UC END# *492406340209_495504A000F2_impl*
end;//TdsBasesAccess.GetOperations
{$IfEnd} // Defined(Admin)

end.
