unit nsTrialSupport;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsTrialSupport.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

procedure nsDisableOperationInTrialMode(const aParams: IvcmTestParamsPrim);
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , DataAdapter
;

procedure nsDisableOperationInTrialMode(const aParams: IvcmTestParamsPrim);
//#UC START# *495260290250_4951292D01DA_var*
//#UC END# *495260290250_4951292D01DA_var*
begin
//#UC START# *495260290250_4951292D01DA_impl*
 if (aParams.Op.Flag[vcm_ofVisible] and aParams.Op.Flag[vcm_ofEnabled]) then
  aParams.Op.Flag[vcm_ofEnabled] := not(DefDataAdapter.IsTrialMode);
//#UC END# *495260290250_4951292D01DA_impl*
end;//nsDisableOperationInTrialMode
{$IfEnd} // NOT Defined(Admin)

end.
