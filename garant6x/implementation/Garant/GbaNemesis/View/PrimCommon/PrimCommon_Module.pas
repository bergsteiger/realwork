unit PrimCommon_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\PrimCommon_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "PrimCommon" MUID: (4A8EC78503BB)
// Имя типа: "TPrimCommonModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TShutdownWarningKind = (
  {* [$159367978] }
  wkShutDown
  , wkLogout
 );//TShutdownWarningKind

 TPrimCommonModule = {abstract} class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function MakeUpdateMessage: IvcmEntityForm;
    {* Создаёт окно с сообщением об обновлении базы }
   class function MakeShutdownWindow(aCloseInterval: LongWord;
    aKind: TShutdownWarningKind): IvcmEntityForm;
    {* Создаёт окно сообщающее о закрытии приложения }
 end;//TPrimCommonModule

implementation

uses
 l3ImplUses
 , nsTypes
 , afwFacade
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , F1_Application_Template_InternalOperations_Controls
 , ShutDown_Form
 , Login_Form
 , LongProcess_Form
 //#UC START# *4A8EC78503BBimpl_uses*
 , PrimLongProcess_Form
 //#UC END# *4A8EC78503BBimpl_uses*
;

{$If NOT Defined(NoVCM)}
class function TPrimCommonModule.MakeUpdateMessage: IvcmEntityForm;
 {* Создаёт окно с сообщением об обновлении базы }
var
 __WasEnter : Boolean;
//#UC START# *4A93DE1B0371_4A8EC78503BB_var*
//#UC END# *4A93DE1B0371_4A8EC78503BB_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4A93DE1B0371_4A8EC78503BB_impl*
 Result := TLongProcessForm.Make(TnsLongProcessData_C(nil, lptUpdate, nil));
//#UC END# *4A93DE1B0371_4A8EC78503BB_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TPrimCommonModule.MakeUpdateMessage

class function TPrimCommonModule.MakeShutdownWindow(aCloseInterval: LongWord;
 aKind: TShutdownWarningKind): IvcmEntityForm;
 {* Создаёт окно сообщающее о закрытии приложения }
var
 __WasEnter : Boolean;
//#UC START# *4A93A8AB0239_4A8EC78503BB_var*
//#UC END# *4A93A8AB0239_4A8EC78503BB_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4A93A8AB0239_4A8EC78503BB_impl*
 Result := TShutDownForm.Make(vcmMakeParams(nil, nil, Application));
 afw.ProcessMessages;
 Op_System_InitShutdown.Call(Result.Entity, aKind = wkShutDown, aCloseInterval);
//#UC END# *4A93A8AB0239_4A8EC78503BB_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TPrimCommonModule.MakeShutdownWindow

class procedure TPrimCommonModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TShutDownForm);
 aList.Add(TLoginForm);
 aList.Add(TLongProcessForm);
end;//TPrimCommonModule.GetEntityForms
{$IfEnd} // NOT Defined(NoVCM)

end.
