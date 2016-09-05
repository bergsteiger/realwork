unit UnderControl_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControl\UnderControl_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "UnderControl" MUID: (4CCAC71C0347)
// Имя типа: "TUnderControlModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
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
 TUnderControlModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   class procedure UnderControlOpen(const aContainer: IvcmContainer);
   class function FindUnderControlForm(const aContainer: IvcmContainer): IvcmEntityForm;
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TUnderControlModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModuleContractImplementation
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Services_Contracts
 , UnderControlUnit
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , FoldersDomainInterfaces
 , nsFolders
 , deListSet
 , DynamicDocListUnit
 , DynamicTreeUnit
 , BaseTypesUnit
 , SysUtils
 , DataAdapter
 , l3Base
 , UnderControl_Form
 , Common_FormDefinitions_Controls
 //#UC START# *4CCAC71C0347impl_uses*
 , StdRes
 //#UC END# *4CCAC71C0347impl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TUnderControlServiceImpl = {final} class(TvcmModuleContractImplementation, IUnderControlService)
  public
   procedure AddControlledObject(const aData: IControllable);
   procedure BuildUnderControlList(const aContainer: IvcmContainer);
   procedure CloseUnderControl(const aContainer: IvcmContainer);
   procedure DeleteControlledObject(const aData: IControllable);
   procedure DropChangeStatusToOpened(const aForm: IvcmEntityForm);
   procedure MarkControlledAsOpen(const aData: IControllable);
   procedure OpenUnderControl(const aContainer: IvcmContainer);
   class function Instance: TUnderControlServiceImpl;
    {* Метод получения экземпляра синглетона TUnderControlServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TUnderControlServiceImpl

var g_TUnderControlServiceImpl: TUnderControlServiceImpl = nil;
 {* Экземпляр синглетона TUnderControlServiceImpl }

procedure TUnderControlServiceImplFree;
 {* Метод освобождения экземпляра синглетона TUnderControlServiceImpl }
begin
 l3Free(g_TUnderControlServiceImpl);
end;//TUnderControlServiceImplFree

procedure TUnderControlServiceImpl.AddControlledObject(const aData: IControllable);
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
end;//TUnderControlServiceImpl.AddControlledObject

procedure TUnderControlServiceImpl.BuildUnderControlList(const aContainer: IvcmContainer);
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
   TListService.Instance.OpenList(TdeListSet.Make(l_List), aContainer);
  finally
   l_List := nil;
  end;//try..finally
//#UC END# *4BC807410014_4CCAC71C0347_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TUnderControlServiceImpl.BuildUnderControlList

procedure TUnderControlServiceImpl.CloseUnderControl(const aContainer: IvcmContainer);
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
 l_Form := TUnderControlModule.FindUnderControlForm(aContainer);
 if l_Form <> nil then
  l_Form.SafeClose;
//#UC END# *4ABCE38D00B4_4CCAC71C0347_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TUnderControlServiceImpl.CloseUnderControl

procedure TUnderControlServiceImpl.DeleteControlledObject(const aData: IControllable);
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
end;//TUnderControlServiceImpl.DeleteControlledObject

procedure TUnderControlServiceImpl.DropChangeStatusToOpened(const aForm: IvcmEntityForm);
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
end;//TUnderControlServiceImpl.DropChangeStatusToOpened

procedure TUnderControlServiceImpl.MarkControlledAsOpen(const aData: IControllable);
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
end;//TUnderControlServiceImpl.MarkControlledAsOpen

procedure TUnderControlServiceImpl.OpenUnderControl(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AC0938B0336_4CCAC71C0347_var*
//#UC END# *4AC0938B0336_4CCAC71C0347_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AC0938B0336_4CCAC71C0347_impl*
  TUnderControlModule.UnderControlOpen(aContainer);
//#UC END# *4AC0938B0336_4CCAC71C0347_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TUnderControlServiceImpl.OpenUnderControl

class function TUnderControlServiceImpl.Instance: TUnderControlServiceImpl;
 {* Метод получения экземпляра синглетона TUnderControlServiceImpl }
begin
 if (g_TUnderControlServiceImpl = nil) then
 begin
  l3System.AddExitProc(TUnderControlServiceImplFree);
  g_TUnderControlServiceImpl := Create;
 end;
 Result := g_TUnderControlServiceImpl;
end;//TUnderControlServiceImpl.Instance

class function TUnderControlServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TUnderControlServiceImpl <> nil;
end;//TUnderControlServiceImpl.Exists

class procedure TUnderControlModule.UnderControlOpen(const aContainer: IvcmContainer);
var l_Form: IvcmEntityForm;
//#UC START# *4AC09339029B_4CCAC71C0347_var*
//#UC END# *4AC09339029B_4CCAC71C0347_var*
begin
//#UC START# *4AC09339029B_4CCAC71C0347_impl*
 l_Form := FindUnderControlForm(CheckContainer(aContainer));
 if (l_Form = nil) then
  l_Form := TenUnderControl.Make(vcmMakeParams(nil, CheckContainer(aContainer)));
 l_Form.SetActiveInParent;
//#UC END# *4AC09339029B_4CCAC71C0347_impl*
end;//TUnderControlModule.UnderControlOpen

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

class procedure TUnderControlModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TenUnderControl);
end;//TUnderControlModule.GetEntityForms

initialization
 TUnderControlService.Instance.Alien := TUnderControlServiceImpl.Instance;
 {* Регистрация TUnderControlServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
