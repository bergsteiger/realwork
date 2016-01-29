unit BaseWorkJournal_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/WorkJournal/BaseWorkJournal_Module.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Основные прецеденты::WorkJournal::View::WorkJournal::BaseWorkJournal
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
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  WorkJournal_Form,
  WorkJournalInterfaces,
  PrimWorkJournalOptions_Form
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
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
  nscTreeViewWithAdapterDragDrop
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  WorkJournalKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TBaseWorkJournalModule = {formspack} class(TvcmModule)
 protected
  procedure Loaded; override;
  class procedure GetEntityForms(aList : TvcmClassList); override;
 protected
 // protected methods
   procedure opOpenJournalTest(const aParams: IvcmTestParamsPrim);
   procedure opOpenJournal(const aParams: IvcmExecuteParamsPrim);
 public
 // public methods
   class function MakeWorkJournal: IbsWorkJournal;
 end;//TBaseWorkJournalModule
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  bsWorkJournal,
  PrimWorkJournal_utWorkJournal_UserType
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
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_WorkJournal_opOpenJournal
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  vcmFormSetFactory {a},
  StdRes {a},
  vcmModuleDef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TBaseWorkJournalModule

class function TBaseWorkJournalModule.MakeWorkJournal: IbsWorkJournal;
var
 __WasEnter : Boolean;
//#UC START# *4A827E40004E_4A811C1A0293_var*
//#UC END# *4A827E40004E_4A811C1A0293_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4A827E40004E_4A811C1A0293_impl*
 Result := TbsWorkJournal.Make;
//#UC END# *4A827E40004E_4A811C1A0293_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TBaseWorkJournalModule.MakeWorkJournal

procedure TBaseWorkJournalModule.opOpenJournalTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4A97C7C0019C_4A811C1A0293test_var*
//#UC END# *4A97C7C0019C_4A811C1A0293test_var*
begin
//#UC START# *4A97C7C0019C_4A811C1A0293test_impl*
// Do nothing
//#UC END# *4A97C7C0019C_4A811C1A0293test_impl*
end;//TBaseWorkJournalModule.opOpenJournalTest

procedure TBaseWorkJournalModule.opOpenJournal(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A97C7C0019C_4A811C1A0293exec_var*
var
 l_Window: IvcmEntityForm;
//#UC END# *4A97C7C0019C_4A811C1A0293exec_var*
begin
//#UC START# *4A97C7C0019C_4A811C1A0293exec_impl*
 l_Window := TWorkJournalForm.MakeSingleChild(DefaultContainer,
                               vcmMakeParams(nil, DefaultContainer),
                               vcm_ztNavigator,
                               Ord(utWorkJournal));
 l_Window.SetActiveInParent;
//#UC END# *4A97C7C0019C_4A811C1A0293exec_impl*
end;//TBaseWorkJournalModule.opOpenJournal

procedure TBaseWorkJournalModule.Loaded;
begin
 inherited;
 PublishOp('opOpenJournal', opOpenJournal, opOpenJournalTest);
end;

class procedure TBaseWorkJournalModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(TWorkJournalForm);
end;

{$IfEnd} //not Admin AND not Monitorings

end.