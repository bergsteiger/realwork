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
  ShutDown_Form,
  PrimShutDown_Form,
  PrimLogin_Form,
  Login_Form,
  PrimLongProcess_Form,
  LongProcess_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
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
  nsTypes,
  afwFacade
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  F1_Application_Template_InternalOperations_Controls,
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