unit NOT_FINISHED_AutoPipeServerForm;

// Модуль: "w:\archi\source\projects\PipeInAuto\NOT_FINISHED_AutoPipeServerForm.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TArchiServerForm = class(TForm)
 end;//TArchiServerForm

 TAutoPipeServerForm = class
 end;//TAutoPipeServerForm
{$IfEnd} // Defined(AppServerSide)

implementation

{$If Defined(AppServerSide)}
uses
 l3ImplUses
 , alcuServer
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TArchiServerForm);
 {* Регистрация TArchiServerForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(AppServerSide)

end.
