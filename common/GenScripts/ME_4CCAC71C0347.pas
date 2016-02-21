unit UnderControl_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControl\UnderControl_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , UnderControlUnit
;

type
 TUnderControlModule = class
  protected
   procedure UnderControlOpen(const aContainer: IvcmContainer);
   function FindUnderControlForm(const aContainer: IvcmContainer): IvcmEntityForm;
  public
   procedure CloseUnderControl(const aContainer: IvcmContainer);
   procedure OpenUnderControl(const aContainer: IvcmContainer);
   procedure BuildUnderControlList(const aContainer: IvcmContainer);
   procedure AddControlledObject(const aData: IControllable);
   procedure DeleteControlledObject(const aData: IControllable);
   procedure MarkControlledAsOpen(const aData: IControllable);
   procedure DropChangeStatusToOpened(const aForm: IvcmEntityForm);
 end;//TUnderControlModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , DynamicTreeUnit
 , DynamicDocListUnit
 , deListSet
 , DataAdapter
 , SysUtils
 , BaseTypesUnit
 , nsFolders
 , FoldersDomainInterfaces
;

procedure TUnderControlModule.CloseUnderControl(const aContainer: IvcmContainer);
//#UC START# *4ABCE38D00B4_4CCAC71C0347_var*
var
 l_Form: IvcmEntityForm;
//#UC END# *4ABCE38D00B4_4CCAC71C0347_var*
begin
//#UC START# *4ABCE38D00B4_4CCAC71C0347_impl*
 Assert(aContainer <> nil);
 l_Form := FindUnderControlForm(aContainer);
 if l_Form <> nil then
  l_Form.SafeClose;
//#UC END# *4ABCE38D00B4_4CCAC71C0347_impl*
end;//TUnderControlModule.CloseUnderControl

procedure TUnderControlModule.OpenUnderControl(const aContainer: IvcmContainer);
//#UC START# *4AC0938B0336_4CCAC71C0347_var*
//#UC END# *4AC0938B0336_4CCAC71C0347_var*
begin
//#UC START# *4AC0938B0336_4CCAC71C0347_impl*
 UnderControlOpen(aContainer);
//#UC END# *4AC0938B0336_4CCAC71C0347_impl*
end;//TUnderControlModule.OpenUnderControl

procedure TUnderControlModule.BuildUnderControlList(const aContainer: IvcmContainer);
//#UC START# *4BC807410014_4CCAC71C0347_var*
var
 l_CatalogBase : ICatalogBase;
 l_List        : IDynList;
//#UC END# *4BC807410014_4CCAC71C0347_var*
begin
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
end;//TUnderControlModule.BuildUnderControlList

procedure TUnderControlModule.UnderControlOpen(const aContainer: IvcmContainer);
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

procedure TUnderControlModule.AddControlledObject(const aData: IControllable);
//#UC START# *4AC096CB03BD_4CCAC71C0347_var*
//#UC END# *4AC096CB03BD_4CCAC71C0347_var*
begin
//#UC START# *4AC096CB03BD_4CCAC71C0347_impl*
 (UserFoldersTree.ControlledObj as InsControlledList).AddControllable(aData);
 UserFoldersTree.Refresh;
//#UC END# *4AC096CB03BD_4CCAC71C0347_impl*
end;//TUnderControlModule.AddControlledObject

procedure TUnderControlModule.DeleteControlledObject(const aData: IControllable);
//#UC START# *4AC097080270_4CCAC71C0347_var*
//#UC END# *4AC097080270_4CCAC71C0347_var*
begin
//#UC START# *4AC097080270_4CCAC71C0347_impl*
 (UserFoldersTree.ControlledObj as InsControlledList).DeleteControllable(aData);
 UserFoldersTree.Refresh;
//#UC END# *4AC097080270_4CCAC71C0347_impl*
end;//TUnderControlModule.DeleteControlledObject

procedure TUnderControlModule.MarkControlledAsOpen(const aData: IControllable);
//#UC START# *4AC097240029_4CCAC71C0347_var*
//#UC END# *4AC097240029_4CCAC71C0347_var*
begin
//#UC START# *4AC097240029_4CCAC71C0347_impl*
 (UserFoldersTree.ControlledObj as InsControlledList).SetOpenedFlag(aData);
//#UC END# *4AC097240029_4CCAC71C0347_impl*
end;//TUnderControlModule.MarkControlledAsOpen

procedure TUnderControlModule.DropChangeStatusToOpened(const aForm: IvcmEntityForm);
//#UC START# *4AC0974303CD_4CCAC71C0347_var*
//#UC END# *4AC0974303CD_4CCAC71C0347_var*
begin
//#UC START# *4AC0974303CD_4CCAC71C0347_impl*
 (UserFoldersTree.ControlledObj as InsControlledList).DropModifiedFlagForOpened(aForm);
//#UC END# *4AC0974303CD_4CCAC71C0347_impl*
end;//TUnderControlModule.DropChangeStatusToOpened

function TUnderControlModule.FindUnderControlForm(const aContainer: IvcmContainer): IvcmEntityForm;
//#UC START# *4ABCD31A033C_4CCAC71C0347_var*
//#UC END# *4ABCD31A033C_4CCAC71C0347_var*
begin
//#UC START# *4ABCD31A033C_4CCAC71C0347_impl*
 Result := nil;
 if (aContainer <> nil) then
    aContainer.HasForm(fm_enUnderControl.rFormID, vcm_ztNavigator, true, @Result);
//#UC END# *4ABCD31A033C_4CCAC71C0347_impl*
end;//TUnderControlModule.FindUnderControlForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
