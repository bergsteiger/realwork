unit UnderControl_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/UnderControl/UnderControl_Module.pas"
// Начат: 29.10.2010 17:08
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Работа с документом и списком документов::UnderControl::View::UnderControl::UnderControl$FP
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
  UnderControlUnit
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  UnderControl_Form,
  Common_FormDefinitions_Controls,
  PrimUnderControlOptions_Form
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  UnderControlKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TUnderControlModule = {formspack} class(TvcmModule)
 protected
  class procedure GetEntityForms(aList : TvcmClassList); override;
 protected
 // protected methods
   class procedure UnderControlOpen(const aContainer: IvcmContainer);
   class function FindUnderControlForm(const aContainer: IvcmContainer): IvcmEntityForm;
 public
 // public methods
   class procedure CloseUnderControl(const aContainer: IvcmContainer);
   class procedure OpenUnderControl(const aContainer: IvcmContainer);
   class procedure BuildUnderControlList(const aContainer: IvcmContainer);
   class procedure AddControlledObject(const aData: IControllable);
   class procedure DeleteControlledObject(const aData: IControllable);
   class procedure MarkControlledAsOpen(const aData: IControllable);
   class procedure DropChangeStatusToOpened(const aForm: IvcmEntityForm);
 end;//TUnderControlModule
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  DynamicTreeUnit,
  DynamicDocListUnit,
  deListSet,
  DataAdapter,
  SysUtils,
  BaseTypesUnit
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport
  {$IfEnd} //not NoVCM
  ,
  nsFolders,
  FoldersDomainInterfaces,
  nscTreeViewWithAdapterDragDrop
  {$If not defined(NoScripts)}
  ,
  tfwScriptingTypes
  {$IfEnd} //not NoScripts
  ,
  vcmFormSetFactory {a},
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TUnderControlModule

class procedure TUnderControlModule.CloseUnderControl(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4ABCE38D00B4_4CCAC71C0347_var*
var
 l_Form: IvcmEntityForm;
//#UC END# *4ABCE38D00B4_4CCAC71C0347_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4ABCE38D00B4_4CCAC71C0347_impl*
 Assert(aContainer <> nil);
 l_Form := FindUnderControlForm(aContainer);
 if l_Form <> nil then
  l_Form.SafeClose;
//#UC END# *4ABCE38D00B4_4CCAC71C0347_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TUnderControlModule.CloseUnderControl

class procedure TUnderControlModule.OpenUnderControl(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AC0938B0336_4CCAC71C0347_var*
//#UC END# *4AC0938B0336_4CCAC71C0347_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AC0938B0336_4CCAC71C0347_impl*
 UnderControlOpen(aContainer);
//#UC END# *4AC0938B0336_4CCAC71C0347_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TUnderControlModule.OpenUnderControl

class procedure TUnderControlModule.BuildUnderControlList(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4BC807410014_4CCAC71C0347_var*
var
 l_CatalogBase : ICatalogBase;
 l_List        : IDynList;
//#UC END# *4BC807410014_4CCAC71C0347_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4BC807410014_4CCAC71C0347_impl*
 try
  defDataAdapter.ControlMgr.GetChangedDoc(l_CatalogBase);
 except
  on ECanNotFindData do
   vcmSay(inf_NotChangedControlledDoc);
 end;
 if Supports(l_CatalogBase, IDynList, l_List) then
  try
   TdmStdRes.OpenList(TdeListSet.Make(l_List),
                      aContainer);
  finally
   l_List := nil;
  end;//try..finally
//#UC END# *4BC807410014_4CCAC71C0347_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TUnderControlModule.BuildUnderControlList

class procedure TUnderControlModule.UnderControlOpen(const aContainer: IvcmContainer);
//#UC START# *4AC09339029B_4CCAC71C0347_var*
//#UC END# *4AC09339029B_4CCAC71C0347_var*
var
 l_Form : IvcmEntityForm;
begin
//#UC START# *4AC09339029B_4CCAC71C0347_impl*
 l_Form := FindUnderControlForm(CheckContainer(aContainer));
 if (l_Form = nil) then
  l_Form := TenUnderControl.Make(vcmMakeParams(nil, CheckContainer(aContainer)));
 l_Form.SetActiveInParent;
//#UC END# *4AC09339029B_4CCAC71C0347_impl*
end;//TUnderControlModule.UnderControlOpen

class procedure TUnderControlModule.AddControlledObject(const aData: IControllable);
var
 __WasEnter : Boolean;
//#UC START# *4AC096CB03BD_4CCAC71C0347_var*
//#UC END# *4AC096CB03BD_4CCAC71C0347_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AC096CB03BD_4CCAC71C0347_impl*
 (UserFoldersTree.ControlledObj as InsControlledList).AddControllable(aData);
 UserFoldersTree.Refresh;
//#UC END# *4AC096CB03BD_4CCAC71C0347_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TUnderControlModule.AddControlledObject

class procedure TUnderControlModule.DeleteControlledObject(const aData: IControllable);
var
 __WasEnter : Boolean;
//#UC START# *4AC097080270_4CCAC71C0347_var*
//#UC END# *4AC097080270_4CCAC71C0347_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AC097080270_4CCAC71C0347_impl*
 (UserFoldersTree.ControlledObj as InsControlledList).DeleteControllable(aData);
 UserFoldersTree.Refresh;
//#UC END# *4AC097080270_4CCAC71C0347_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TUnderControlModule.DeleteControlledObject

class procedure TUnderControlModule.MarkControlledAsOpen(const aData: IControllable);
var
 __WasEnter : Boolean;
//#UC START# *4AC097240029_4CCAC71C0347_var*
//#UC END# *4AC097240029_4CCAC71C0347_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AC097240029_4CCAC71C0347_impl*
 (UserFoldersTree.ControlledObj as InsControlledList).SetOpenedFlag(aData);
//#UC END# *4AC097240029_4CCAC71C0347_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TUnderControlModule.MarkControlledAsOpen

class procedure TUnderControlModule.DropChangeStatusToOpened(const aForm: IvcmEntityForm);
var
 __WasEnter : Boolean;
//#UC START# *4AC0974303CD_4CCAC71C0347_var*
//#UC END# *4AC0974303CD_4CCAC71C0347_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AC0974303CD_4CCAC71C0347_impl*
 (UserFoldersTree.ControlledObj as InsControlledList).DropModifiedFlagForOpened(aForm);
//#UC END# *4AC0974303CD_4CCAC71C0347_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TUnderControlModule.DropChangeStatusToOpened

class function TUnderControlModule.FindUnderControlForm(const aContainer: IvcmContainer): IvcmEntityForm;
//#UC START# *4ABCD31A033C_4CCAC71C0347_var*
//#UC END# *4ABCD31A033C_4CCAC71C0347_var*
begin
//#UC START# *4ABCD31A033C_4CCAC71C0347_impl*
 Result := nil;
 if (aContainer <> nil) then
    aContainer.HasForm(fm_enUnderControl.rFormID, vcm_ztNavigator, true, @Result);
//#UC END# *4ABCD31A033C_4CCAC71C0347_impl*
end;//TUnderControlModule.FindUnderControlForm

class procedure TUnderControlModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(TenUnderControl);
end;

{$IfEnd} //not Admin AND not Monitorings

end.