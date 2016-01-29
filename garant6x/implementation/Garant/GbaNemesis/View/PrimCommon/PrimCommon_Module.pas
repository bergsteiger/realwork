unit PrimCommon_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/PrimCommon_Module.pas"
// Начат: 21.08.2009 20:15
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Базовые определения предметной области::F1 Application Template::View::PrimCommon::PrimCommon
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  vtPanel,
  ShutDown_Form,
  PrimShutDown_Form,
  PrimLogin_Form,
  Login_Form,
  PrimLongProcess_Form,
  LongProcess_Form,
  vtFocusLabel,
  vtGroupBox
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtLabel
  {$If defined(Nemesis)}
  ,
  nscComboBoxWithReadOnly
  {$IfEnd} //Nemesis
  ,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  ,
  vtButton,
  vtCheckBox,
  ElPopBtn,
  vtGradientWaitbar
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  ShutDownKeywordsPack
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  LoginKeywordsPack
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  LongProcessKeywordsPack
  {$IfEnd} //not NoScripts
  ,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;

type
 TShutdownWarningKind = (
  {* [$159367978] }
   wkShutDown
 , wkLogout
 );//TShutdownWarningKind

 TPrimCommonModule = {abstract formspack} class(TvcmModule)
 protected
  class procedure GetEntityForms(aList : TvcmClassList); override;
 public
 // public methods
   class function MakeUpdateMessage: IvcmEntityForm;
     {* Создаёт окно с сообщением об обновлении базы }
   class function MakeShutdownWindow(aCloseInterval: LongWord;
     aKind: TShutdownWarningKind): IvcmEntityForm;
     {* Создаёт окно сообщающее о закрытии приложения }
 end;//TPrimCommonModule

implementation

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID,
  nsTypes,
  afwFacade
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  F1_Application_Template_InternalOperations_Controls
  {$If not defined(NoScripts)}
  ,
  tfwScriptingTypes
  {$IfEnd} //not NoScripts
  ,
  TypInfo
  {$If not defined(NoScripts)}
  ,
  tfwTypeRegistrator
  {$IfEnd} //not NoScripts
  ,
  vcmFormSetFactory {a},
  StdRes {a}
  ;

// start class TPrimCommonModule

class function TPrimCommonModule.MakeUpdateMessage: IvcmEntityForm;
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

class procedure TPrimCommonModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(TShutDownForm);
 aList.Add(TLoginForm);
 aList.Add(TLongProcessForm);
end;

end.