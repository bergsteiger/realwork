unit PrimUnderControlOptions_Form;
 {* На контроле }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControl\Forms\PrimUnderControlOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimUnderControl_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , UnderControl_Strange_Controls
 , L10nInterfaces
 , FoldersDomainInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimUnderControlOptionsForm = class(TPrimUnderControlForm)
  {* На контроле }
  private
   f_SortTypeMap: InsIntegerValueMap;
  protected
   function pm_GetUnderControlInfo: InsUnderControlInfo;
   procedure enControlCenterNullListTest(const aParams: IvcmTestParamsPrim);
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   {$If NOT Defined(NoVCM)}
   procedure Edit_Paste_Test(const aParams: IvcmTestParamsPrim);
    {* Вставка }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_GetState(var State: TvcmOperationStateIndex);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ControlCenter_Add_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure ControlCenter_CreateList_Test(const aParams: IvcmTestParamsPrim);
   procedure ControlCenter_CreateList_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure ControlCenter_Sort_Test(const aParams: IvcmTestParamsPrim);
   procedure ControlCenter_Sort_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure ControlCenter_ClearAllStatus_Test(const aParams: IvcmTestParamsPrim);
   procedure ControlCenter_ClearAllStatus_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure ControledObject_Open_Test(const aParams: IvcmTestParamsPrim);
   procedure ControledObject_Open_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure ControledObject_ClearStatus_Test(const aParams: IvcmTestParamsPrim);
   procedure ControledObject_ClearStatus_Execute(const aParams: IvcmExecuteParamsPrim);
  protected
   property UnderControlInfo: InsUnderControlInfo
    read pm_GetUnderControlInfo;
 end;//TPrimUnderControlOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , eeInterfaces
 , SysUtils
 , nsValueMaps
 , nsValueMapsIDs
 {$If Defined(Nemesis)}
 , eeTreeMisc
 {$IfEnd} // Defined(Nemesis)
 , nsFolders
 , nsOpenUtils
 , nsFolderFilterInfo
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TPrimUnderControlOptionsForm.pm_GetUnderControlInfo: InsUnderControlInfo;
//#UC START# *4C7E4FB400A8_4C7E4A45018Fget_var*
//#UC END# *4C7E4FB400A8_4C7E4A45018Fget_var*
begin
//#UC START# *4C7E4FB400A8_4C7E4A45018Fget_impl*
 Supports(UnderControlList.TreeStruct, InsUnderControlInfo, Result);
//#UC END# *4C7E4FB400A8_4C7E4A45018Fget_impl*
end;//TPrimUnderControlOptionsForm.pm_GetUnderControlInfo

procedure TPrimUnderControlOptionsForm.enControlCenterNullListTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E584D02A3_4C7E4A45018F_var*
//#UC END# *4C7E584D02A3_4C7E4A45018F_var*
begin
//#UC START# *4C7E584D02A3_4C7E4A45018F_impl*
 with aParams do
 begin
  if (UnderControlList.TreeView.Tree.SelectedCount >= 1) then
   Op.Flag[vcm_ofEnabled] := Supports(UnderControlList.TreeView.CurrentNode, InsUnderControlNode)
  else
   Op.Flag[vcm_ofEnabled] := False;
 end;
//#UC END# *4C7E584D02A3_4C7E4A45018F_impl*
end;//TPrimUnderControlOptionsForm.enControlCenterNullListTest

{$If NOT Defined(NoVCM)}
procedure TPrimUnderControlOptionsForm.Edit_Paste_Test(const aParams: IvcmTestParamsPrim);
 {* Вставка }
//#UC START# *49EDFA3701B0_4C7E4A45018Ftest_var*
//#UC END# *49EDFA3701B0_4C7E4A45018Ftest_var*
begin
//#UC START# *49EDFA3701B0_4C7E4A45018Ftest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *49EDFA3701B0_4C7E4A45018Ftest_impl*
end;//TPrimUnderControlOptionsForm.Edit_Paste_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimUnderControlOptionsForm.Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
 {* Копировать }
//#UC START# *4C7D0C7B0185_4C7E4A45018Ftest_var*
//#UC END# *4C7D0C7B0185_4C7E4A45018Ftest_var*
begin
//#UC START# *4C7D0C7B0185_4C7E4A45018Ftest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4C7D0C7B0185_4C7E4A45018Ftest_impl*
end;//TPrimUnderControlOptionsForm.Edit_Copy_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimUnderControlOptionsForm.Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
 {* Удалить }
//#UC START# *4C7D0CC90052_4C7E4A45018Ftest_var*
//#UC END# *4C7D0CC90052_4C7E4A45018Ftest_var*
begin
//#UC START# *4C7D0CC90052_4C7E4A45018Ftest_impl*
 enControlCenterNullListTest(aParams);
//#UC END# *4C7D0CC90052_4C7E4A45018Ftest_impl*
end;//TPrimUnderControlOptionsForm.Edit_Delete_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimUnderControlOptionsForm.Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Удалить }
//#UC START# *4C7D0CC90052_4C7E4A45018Fexec_var*
var
 l_Node: IeeNode;
 l_Desision: Boolean;
 l_List: InsControlledList;
//#UC END# *4C7D0CC90052_4C7E4A45018Fexec_var*
begin
//#UC START# *4C7D0CC90052_4C7E4A45018Fexec_impl*
 with UnderControlList.TreeView.Tree do
 begin
  if (SelectedCount > 0) then
  begin
   if (SelectedCount > 1) then
    l_Desision := Ask(qr_RemoveControlStatus)
   else
    l_Desision := Ask(qr_RemoveDocumentFromControl);

   if l_Desision then
   begin
    Changing;
    try
     repeat
      l_Node := GetNextSelected(Root);
      if Assigned(l_Node) then
       l_Node.Delete
      else
       break;
     until false;

     if Supports(UserFoldersTree.ControlledObj, InsControlledList, l_List) then
      l_List.AddFakeNode;
    finally
     Changed;
    end;//try..finally
   end;
  end
 end;
//#UC END# *4C7D0CC90052_4C7E4A45018Fexec_impl*
end;//TPrimUnderControlOptionsForm.Edit_Delete_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimUnderControlOptionsForm.Edit_Delete_GetState(var State: TvcmOperationStateIndex);
 {* Удалить }
//#UC START# *4C7D0CC90052_4C7E4A45018Fgetstate_var*
//#UC END# *4C7D0CC90052_4C7E4A45018Fgetstate_var*
begin
//#UC START# *4C7D0CC90052_4C7E4A45018Fgetstate_impl*
 State := st_user_Edit_Delete_Controlled;
//#UC END# *4C7D0CC90052_4C7E4A45018Fgetstate_impl*
end;//TPrimUnderControlOptionsForm.Edit_Delete_GetState
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimUnderControlOptionsForm.ControlCenter_Add_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E4B830292_4C7E4A45018Fexec_var*
//#UC END# *4C7E4B830292_4C7E4A45018Fexec_var*
begin
//#UC START# *4C7E4B830292_4C7E4A45018Fexec_impl*
 TdmStdRes.SelectOpen(Self.as_IvcmEntityForm,
                      TnsFolderFilterInfo.Make(ffNone, ns_ffDocument),
                      str_SetToControl);
//#UC END# *4C7E4B830292_4C7E4A45018Fexec_impl*
end;//TPrimUnderControlOptionsForm.ControlCenter_Add_Execute

procedure TPrimUnderControlOptionsForm.ControlCenter_CreateList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E4BA000A6_4C7E4A45018Ftest_var*
//#UC END# *4C7E4BA000A6_4C7E4A45018Ftest_var*
begin
//#UC START# *4C7E4BA000A6_4C7E4A45018Ftest_impl*
 EnControlCenterNullListTest(aParams);
//#UC END# *4C7E4BA000A6_4C7E4A45018Ftest_impl*
end;//TPrimUnderControlOptionsForm.ControlCenter_CreateList_Test

procedure TPrimUnderControlOptionsForm.ControlCenter_CreateList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E4BA000A6_4C7E4A45018Fexec_var*
//#UC END# *4C7E4BA000A6_4C7E4A45018Fexec_var*
begin
//#UC START# *4C7E4BA000A6_4C7E4A45018Fexec_impl*
 TdmStdRes.BuildUnderControlList((aParams As IvcmExecuteParams).Container);
//#UC END# *4C7E4BA000A6_4C7E4A45018Fexec_impl*
end;//TPrimUnderControlOptionsForm.ControlCenter_CreateList_Execute

procedure TPrimUnderControlOptionsForm.ControlCenter_Sort_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E4BB800D4_4C7E4A45018Ftest_var*
var
 l_Strings: IvcmStrings;
 l_UnderControlInfo: InsUnderControlInfo;
 l_StringSource: InsStringsSource;
//#UC END# *4C7E4BB800D4_4C7E4A45018Ftest_var*
begin
//#UC START# *4C7E4BB800D4_4C7E4A45018Ftest_impl*
 l_UnderControlInfo := UnderControlInfo;
 if (l_UnderControlInfo <> nil) then
  try
   aParams.Op.Flag[vcm_ofEnabled] := True;
   l_Strings := aParams.Op.SubItems;
   if (l_Strings <> nil) then
   begin
    aParams.Op.SelectedString := f_SortTypeMap.
     ValueToDisplayName(Ord(l_UnderControlInfo.SortType));
    if l_Strings.Count = 0 then
    if Supports(f_SortTypeMap, InsStringsSource, l_StringSource) then
     l_StringSource.FillStrings(l_Strings);
   end;//l_Strings <> nil
  finally
   l_UnderControlInfo := nil;
  end//try..finally
 else
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4C7E4BB800D4_4C7E4A45018Ftest_impl*
end;//TPrimUnderControlOptionsForm.ControlCenter_Sort_Test

procedure TPrimUnderControlOptionsForm.ControlCenter_Sort_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E4BB800D4_4C7E4A45018Fexec_var*
var
 l_UnderControlInfo : InsUnderControlInfo;
//#UC END# *4C7E4BB800D4_4C7E4A45018Fexec_var*
begin
//#UC START# *4C7E4BB800D4_4C7E4A45018Fexec_impl*
 l_UnderControlInfo := UnderControlInfo;
 if (l_UnderControlInfo <> nil) then
  try
   l_UnderControlInfo.SortType := TnsUCSortType(f_SortTypeMap.DisplayNameToValue(aParams.SelectedString));
  finally
   l_UnderControlInfo := nil;
  end;//try..finally
//#UC END# *4C7E4BB800D4_4C7E4A45018Fexec_impl*
end;//TPrimUnderControlOptionsForm.ControlCenter_Sort_Execute

procedure TPrimUnderControlOptionsForm.ControlCenter_ClearAllStatus_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E4BD301B7_4C7E4A45018Ftest_var*
//#UC END# *4C7E4BD301B7_4C7E4A45018Ftest_var*
begin
//#UC START# *4C7E4BD301B7_4C7E4A45018Ftest_impl*
 EnControlCenterNullListTest(aParams);
//#UC END# *4C7E4BD301B7_4C7E4A45018Ftest_impl*
end;//TPrimUnderControlOptionsForm.ControlCenter_ClearAllStatus_Test

procedure TPrimUnderControlOptionsForm.ControlCenter_ClearAllStatus_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E4BD301B7_4C7E4A45018Fexec_var*

 function DropStatus(const anIntf: IeeNode) : Boolean;
 var
  l_UCNode  : InsUnderControlNode;
 begin
  Result := False;
  if Supports(anIntf, InsUnderControlNode, l_UCNode) then
   try
    l_UCNode.ResetStatus;
   finally
    l_UCNode := nil;
   end;
 end;

//#UC END# *4C7E4BD301B7_4C7E4A45018Fexec_var*
begin
//#UC START# *4C7E4BD301B7_4C7E4A45018Fexec_impl*
 if IsChangeObjects and Ask(qr_DropChangeStatusAllObjects) then
  UnderControlList.TreeView.Tree.Root.IterateF(eeL2NA(@DropStatus));
//#UC END# *4C7E4BD301B7_4C7E4A45018Fexec_impl*
end;//TPrimUnderControlOptionsForm.ControlCenter_ClearAllStatus_Execute

procedure TPrimUnderControlOptionsForm.ControledObject_Open_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E4C3001B6_4C7E4A45018Ftest_var*
//#UC END# *4C7E4C3001B6_4C7E4A45018Ftest_var*
begin
//#UC START# *4C7E4C3001B6_4C7E4A45018Ftest_impl*
 EnControlCenterNullListTest(aParams);
//#UC END# *4C7E4C3001B6_4C7E4A45018Ftest_impl*
end;//TPrimUnderControlOptionsForm.ControledObject_Open_Test

procedure TPrimUnderControlOptionsForm.ControledObject_Open_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E4C3001B6_4C7E4A45018Fexec_var*
//#UC END# *4C7E4C3001B6_4C7E4A45018Fexec_var*
begin
//#UC START# *4C7E4C3001B6_4C7E4A45018Fexec_impl*
 OpenControllableElement(self.as_IvcmEntityForm, UnderControlList.GetCurrentNode,
  vcm_okInCurrentTab);
//#UC END# *4C7E4C3001B6_4C7E4A45018Fexec_impl*
end;//TPrimUnderControlOptionsForm.ControledObject_Open_Execute

procedure TPrimUnderControlOptionsForm.ControledObject_ClearStatus_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E4C470330_4C7E4A45018Ftest_var*
//#UC END# *4C7E4C470330_4C7E4A45018Ftest_var*
begin
//#UC START# *4C7E4C470330_4C7E4A45018Ftest_impl*
 with UnderControlList.TreeView do
  if Tree.SelectedCount > 1 then
   aParams.Op.Flag[vcm_ofEnabled] := True
  else
   aParams.Op.Flag[vcm_ofEnabled] := IsObjectChanged(CurrentNode);
//#UC END# *4C7E4C470330_4C7E4A45018Ftest_impl*
end;//TPrimUnderControlOptionsForm.ControledObject_ClearStatus_Test

procedure TPrimUnderControlOptionsForm.ControledObject_ClearStatus_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E4C470330_4C7E4A45018Fexec_var*
var
 l_Node : IeeNode;
//#UC END# *4C7E4C470330_4C7E4A45018Fexec_var*
begin
//#UC START# *4C7E4C470330_4C7E4A45018Fexec_impl*
 with UnderControlList.TreeView do
 begin
  if Tree.SelectedCount > 1 then
  begin
   if Ask(qr_DropChangeStatusToSelected) then
    with Tree do
    begin
     Changing;
     try
      l_Node := Root;
      repeat
       l_Node := GetNextSelected(l_Node);
       if Assigned(l_Node) then
        ResetElementStatus(l_Node)
       else
        break;
      until false;
     finally
      Changed;
     end;//try..finally
    end;
  end
  else
   ResetElementStatus(CurrentNode);
 end;
//#UC END# *4C7E4C470330_4C7E4A45018Fexec_impl*
end;//TPrimUnderControlOptionsForm.ControledObject_ClearStatus_Execute

{$If NOT Defined(NoVCM)}
procedure TPrimUnderControlOptionsForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4C7E4A45018F_var*
//#UC END# *49803F5503AA_4C7E4A45018F_var*
begin
//#UC START# *49803F5503AA_4C7E4A45018F_impl*
 inherited;
 f_SortTypeMap := nsIntegerMapManager.Map[imap_UnderControlSortType];
//#UC END# *49803F5503AA_4C7E4A45018F_impl*
end;//TPrimUnderControlOptionsForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimUnderControlOptionsForm.ClearFields;
begin
 f_SortTypeMap := nil;
 inherited;
end;//TPrimUnderControlOptionsForm.ClearFields

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimUnderControlOptionsForm);
 {* Регистрация PrimUnderControlOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
