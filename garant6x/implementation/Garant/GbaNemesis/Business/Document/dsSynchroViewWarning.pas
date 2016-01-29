unit dsSynchroViewWarning;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsSynchroViewWarning.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::Document::TdsSynchroViewWarning
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsWarning
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdsSynchroViewWarning = {vac} class(TdsWarning)
 protected
 // overridden protected methods
   function GetIsForSynchroView: Boolean; override;
 end;//TdsSynchroViewWarning
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdsSynchroViewWarning

function TdsSynchroViewWarning.GetIsForSynchroView: Boolean;
//#UC START# *4EFC5A6501C9_4EFC5A8502E2_var*
//#UC END# *4EFC5A6501C9_4EFC5A8502E2_var*
begin
//#UC START# *4EFC5A6501C9_4EFC5A8502E2_impl*
 Result := true;
//#UC END# *4EFC5A6501C9_4EFC5A8502E2_impl*
end;//TdsSynchroViewWarning.GetIsForSynchroView

{$IfEnd} //not Admin AND not Monitorings

end.