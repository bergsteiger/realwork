unit PrimCommon_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\PrimCommon_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimShutDown_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimLogin_Form
 , l3StringIDEx
 , PrimLongProcess_Form
;

const
 fm_ShutDownForm: TvcmFormDescriptor = (rFormID : (rName : 'ShutDownForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TShutDownForm }

const
 fm_LoginForm: TvcmFormDescriptor = (rFormID : (rName : 'LoginForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TLoginForm }

const
 fm_LongProcessForm: TvcmFormDescriptor = (rFormID : (rName : 'LongProcessForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TLongProcessForm }

type
 ShutDownFormDef = interface
  {* Идентификатор формы ShutDown }
  ['{30C1FF00-6CA8-4565-BDC9-191E8237EFAD}']
 end;//ShutDownFormDef

 TShutDownForm = {final} class(TPrimShutDownForm, ShutDownFormDef)
  {* Предупреждение }
 end;//TShutDownForm

 TShutdownWarningKind = (
  {* [$159367978] }
  wkShutDown
  , wkLogout
 );//TShutdownWarningKind

 LoginFormDef = interface
  {* Идентификатор формы Login }
  ['{96B4FBEB-A42A-4990-BCED-2F439F4E152A}']
 end;//LoginFormDef

 TLoginForm = {final} class(TPrimLoginForm, LoginFormDef)
  {* Вход в систему ГАРАНТ }
 end;//TLoginForm

 LongProcessFormDef = interface
  {* Идентификатор формы LongProcess }
  ['{D21B6517-D901-4E98-8A54-287D092EED98}']
 end;//LongProcessFormDef

 TLongProcessForm = {final} class(TPrimLongProcessForm, LongProcessFormDef)
  {* Информация }
 end;//TLongProcessForm

 TPrimCommonModule = {abstract} class
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
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ShutDownKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , LoginKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , LongProcessKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , nsTypes
 , afwFacade
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , F1_Application_Template_InternalOperations_Controls
;

const
 {* Локализуемые строки ut_LoginLocalConstants }
 str_ut_LoginCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_LoginCaption'; rValue : 'Вход в систему ГАРАНТ');
  {* Заголовок пользовательского типа "Вход в систему ГАРАНТ" }

const
 {* Локализуемые строки ut_LongProcessLocalConstants }
 str_ut_LongProcessCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_LongProcessCaption'; rValue : 'Информация');
  {* Заголовок пользовательского типа "Информация" }

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

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TShutDownForm);
 {* Регистрация ShutDown }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ShutDownForm.SetFactory(TShutDownForm.Make);
 {* Регистрация фабрики формы ShutDown }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TLoginForm);
 {* Регистрация Login }
{$IfEnd} // NOT Defined(NoScripts)
 fm_LoginForm.SetFactory(TLoginForm.Make);
 {* Регистрация фабрики формы Login }
 str_ut_LoginCaption.Init;
 {* Инициализация str_ut_LoginCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TLongProcessForm);
 {* Регистрация LongProcess }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_LongProcessCaption.Init;
 {* Инициализация str_ut_LongProcessCaption }

end.
