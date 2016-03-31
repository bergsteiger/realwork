unit PrimCommon_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\PrimCommon_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "PrimCommon" MUID: (4A8EC78503BB)
// Имя типа: "TPrimCommonModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
;

type
 TShutdownWarningKind = (
  {* [$159367978] }
  wkShutDown
  , wkLogout
 );//TShutdownWarningKind

 TPrimCommonModule = {abstract} class(TvcmModule)
  public
   procedure MakeUpdateMessage;
    {* Создаёт окно с сообщением об обновлении базы }
   procedure MakeShutdownWindow(aCloseInterval: LongWord;
    aKind: TShutdownWarningKind);
    {* Создаёт окно сообщающее о закрытии приложения }
 end;//TPrimCommonModule

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsTypes
 , afwFacade
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , F1_Application_Template_InternalOperations_Controls
;

{$If NOT Defined(NoVCM)}
procedure TPrimCommonModule.MakeUpdateMessage;
 {* Создаёт окно с сообщением об обновлении базы }
//#UC START# *4A93DE1B0371_4A8EC78503BB_var*
//#UC END# *4A93DE1B0371_4A8EC78503BB_var*
begin
//#UC START# *4A93DE1B0371_4A8EC78503BB_impl*
 Result := TLongProcessForm.Make(TnsLongProcessData_C(nil, lptUpdate, nil));
//#UC END# *4A93DE1B0371_4A8EC78503BB_impl*
end;//TPrimCommonModule.MakeUpdateMessage

procedure TPrimCommonModule.MakeShutdownWindow(aCloseInterval: LongWord;
 aKind: TShutdownWarningKind);
 {* Создаёт окно сообщающее о закрытии приложения }
//#UC START# *4A93A8AB0239_4A8EC78503BB_var*
//#UC END# *4A93A8AB0239_4A8EC78503BB_var*
begin
//#UC START# *4A93A8AB0239_4A8EC78503BB_impl*
 Result := TShutDownForm.Make(vcmMakeParams(nil, nil, Application));
 afw.ProcessMessages;
 Op_System_InitShutdown.Call(Result.Entity, aKind = wkShutDown, aCloseInterval);
//#UC END# *4A93A8AB0239_4A8EC78503BB_impl*
end;//TPrimCommonModule.MakeShutdownWindow
{$IfEnd} // NOT Defined(NoVCM)

end.
