unit NOT_FINISHED_vtStdRes;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtStdRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vtStdRes" MUID: (49213DFA02CB)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , Classes
;

type
 TvtStdResources = class(TDataModule)
 end;//TvtStdResources

procedure vtStdResources;

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure vtStdResources;
//#UC START# *49213E3A030E_49213DFA02CB_var*
//#UC END# *49213E3A030E_49213DFA02CB_var*
begin
//#UC START# *49213E3A030E_49213DFA02CB_impl*
 !!! Needs to be implemented !!!
//#UC END# *49213E3A030E_49213DFA02CB_impl*
end;//vtStdResources

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtStdResources);
 {* Регистрация TvtStdResources }
{$IfEnd} // NOT Defined(NoScripts)

end.
