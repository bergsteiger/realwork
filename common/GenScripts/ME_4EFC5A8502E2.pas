unit dsSynchroViewWarning;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsSynchroViewWarning.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsWarning
;

type
 TdsSynchroViewWarning = class(TdsWarning)
  protected
   function GetIsForSynchroView: Boolean; override;
 end;//TdsSynchroViewWarning
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

function TdsSynchroViewWarning.GetIsForSynchroView: Boolean;
//#UC START# *4EFC5A6501C9_4EFC5A8502E2_var*
//#UC END# *4EFC5A6501C9_4EFC5A8502E2_var*
begin
//#UC START# *4EFC5A6501C9_4EFC5A8502E2_impl*
 Result := true;
//#UC END# *4EFC5A6501C9_4EFC5A8502E2_impl*
end;//TdsSynchroViewWarning.GetIsForSynchroView
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
