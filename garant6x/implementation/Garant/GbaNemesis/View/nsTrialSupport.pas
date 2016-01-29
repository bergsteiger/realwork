unit nsTrialSupport;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$Strange"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsTrialSupport.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Common For Shell And Monitoring::Search::View$Strange::Printing::nsTrialSupport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  ;

procedure NsDisableOperationInTrialMode(const aParams: IvcmTestParamsPrim);
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  DataAdapter
  ;

// unit methods

procedure NsDisableOperationInTrialMode(const aParams: IvcmTestParamsPrim);
//#UC START# *495260290250_4951292D01DA_var*
//#UC END# *495260290250_4951292D01DA_var*
begin
//#UC START# *495260290250_4951292D01DA_impl*
 if (aParams.Op.Flag[vcm_ofVisible] and aParams.Op.Flag[vcm_ofEnabled]) then
  aParams.Op.Flag[vcm_ofEnabled] := not(DefDataAdapter.IsTrialMode);
//#UC END# *495260290250_4951292D01DA_impl*
end;//NsDisableOperationInTrialMode
{$IfEnd} //not Admin

end.