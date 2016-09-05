unit PrimCommon_Module;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\PrimCommon_Module.pas"
// ���������: "VCMFormsPack"
// ������� ������: "PrimCommon" MUID: (4A8EC78503BB)
// ��� ����: "TPrimCommonModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , F1_Application_Template_Services
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ������ ��� �������� Services.TShutdownWarningKind }
 wkShutDown = F1_Application_Template_Services.wkShutDown;
 wkLogout = F1_Application_Template_Services.wkLogout;

type
 TShutdownWarningKind = F1_Application_Template_Services.TShutdownWarningKind;

 TPrimCommonModule = {abstract} class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimCommonModule

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModuleContractImplementation
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , F1_Application_Template_InternalOperations_Controls
 , afwFacade
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , nsTypes
 , SysUtils
 , l3Base
 , ShutDown_Form
 , Login_Form
 , LongProcess_Form
 //#UC START# *4A8EC78503BBimpl_uses*
 , PrimLongProcess_Form
 //#UC END# *4A8EC78503BBimpl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TShutdownServiceImpl = {final} class(TvcmModuleContractImplementation, IShutdownService)
  public
   function MakeShutdownWindow(aCloseInterval: LongWord;
    aKind: TShutdownWarningKind): IvcmEntityForm;
    {* ������ ���� ���������� � �������� ���������� }
   class function Instance: TShutdownServiceImpl;
    {* ����� ��������� ���������� ���������� TShutdownServiceImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TShutdownServiceImpl

 TLongProcessServiceImpl = {final} class(TvcmModuleContractImplementation, ILongProcessService)
  public
   function MakeUpdateMessage: IvcmEntityForm;
    {* ������ ���� � ���������� �� ���������� ���� }
   class function Instance: TLongProcessServiceImpl;
    {* ����� ��������� ���������� ���������� TLongProcessServiceImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TLongProcessServiceImpl

var g_TShutdownServiceImpl: TShutdownServiceImpl = nil;
 {* ��������� ���������� TShutdownServiceImpl }
var g_TLongProcessServiceImpl: TLongProcessServiceImpl = nil;
 {* ��������� ���������� TLongProcessServiceImpl }

procedure TShutdownServiceImplFree;
 {* ����� ������������ ���������� ���������� TShutdownServiceImpl }
begin
 l3Free(g_TShutdownServiceImpl);
end;//TShutdownServiceImplFree

procedure TLongProcessServiceImplFree;
 {* ����� ������������ ���������� ���������� TLongProcessServiceImpl }
begin
 l3Free(g_TLongProcessServiceImpl);
end;//TLongProcessServiceImplFree

function TShutdownServiceImpl.MakeShutdownWindow(aCloseInterval: LongWord;
 aKind: TShutdownWarningKind): IvcmEntityForm;
 {* ������ ���� ���������� � �������� ���������� }
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
end;//TShutdownServiceImpl.MakeShutdownWindow

class function TShutdownServiceImpl.Instance: TShutdownServiceImpl;
 {* ����� ��������� ���������� ���������� TShutdownServiceImpl }
begin
 if (g_TShutdownServiceImpl = nil) then
 begin
  l3System.AddExitProc(TShutdownServiceImplFree);
  g_TShutdownServiceImpl := Create;
 end;
 Result := g_TShutdownServiceImpl;
end;//TShutdownServiceImpl.Instance

class function TShutdownServiceImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TShutdownServiceImpl <> nil;
end;//TShutdownServiceImpl.Exists

function TLongProcessServiceImpl.MakeUpdateMessage: IvcmEntityForm;
 {* ������ ���� � ���������� �� ���������� ���� }
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
end;//TLongProcessServiceImpl.MakeUpdateMessage

class function TLongProcessServiceImpl.Instance: TLongProcessServiceImpl;
 {* ����� ��������� ���������� ���������� TLongProcessServiceImpl }
begin
 if (g_TLongProcessServiceImpl = nil) then
 begin
  l3System.AddExitProc(TLongProcessServiceImplFree);
  g_TLongProcessServiceImpl := Create;
 end;
 Result := g_TLongProcessServiceImpl;
end;//TLongProcessServiceImpl.Instance

class function TLongProcessServiceImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TLongProcessServiceImpl <> nil;
end;//TLongProcessServiceImpl.Exists

class procedure TPrimCommonModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TShutDownForm);
 aList.Add(TLoginForm);
 aList.Add(TLongProcessForm);
end;//TPrimCommonModule.GetEntityForms

initialization
 TShutdownService.Instance.Alien := TShutdownServiceImpl.Instance;
 {* ����������� TShutdownServiceImpl }
 TLongProcessService.Instance.Alien := TLongProcessServiceImpl.Instance;
 {* ����������� TLongProcessServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

end.
