unit PrimFoldersElementInfoOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersElementInfoOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimFoldersElementInfoOptions" MUID: (4C7E91560315)
// Имя типа: "TPrimFoldersElementInfoOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFoldersElementInfo_Form
 , Folders_Result_Controls
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimFoldersElementInfoOptionsForm = class(TPrimFoldersElementInfoForm)
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure ResultExt_Cancel_Test(const aParams: IvcmTestParamsPrim);
    {* Отмена }
   procedure ResultExt_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   procedure ResultExt_Ok_Test(const aParams: IvcmTestParamsPrim);
    {* OK }
   procedure ResultExt_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   procedure ResultExt_Ok_GetState(var State: TvcmOperationStateIndex);
    {* OK }
   procedure ResultExt_Append_Test(const aParams: IvcmTestParamsPrim);
    {* Добавить }
   procedure ResultExt_Append_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Добавить }
   procedure ResultExt_Append_GetState(var State: TvcmOperationStateIndex);
    {* Добавить }
 end;//TPrimFoldersElementInfoOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , BaseTreeSupportUnit
 , SysUtils
 , FoldersDomainInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Folders_Strange_Controls
 , FoldersUnit
 , eeInterfaces
 , nsFolders
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , BaseTypesUnit
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4C7E91560315impl_uses*
 //#UC END# *4C7E91560315impl_uses*
;

procedure TPrimFoldersElementInfoOptionsForm.ResultExt_Cancel_Test(const aParams: IvcmTestParamsPrim);
 {* Отмена }
//#UC START# *4AFAEBEA0018_4C7E91560315test_var*
//#UC END# *4AFAEBEA0018_4C7E91560315test_var*
begin
//#UC START# *4AFAEBEA0018_4C7E91560315test_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4AFAEBEA0018_4C7E91560315test_impl*
end;//TPrimFoldersElementInfoOptionsForm.ResultExt_Cancel_Test

procedure TPrimFoldersElementInfoOptionsForm.ResultExt_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *4AFAEBEA0018_4C7E91560315exec_var*
var
 l_OperationType : TFoldersInfoType;
//#UC END# *4AFAEBEA0018_4C7E91560315exec_var*
begin
//#UC START# *4AFAEBEA0018_4C7E91560315exec_impl*
 l_OperationType := fiNone;
 if (Aggregate <> nil) then
  if Container.AsForm.ZoneType = vcm_ztManualModal then
   Op_AdditionInfo_Close.Call(Aggregate, mrCancel)
  else
  begin
   l_OperationType := f_CurType;
   f_CurType := fiNone;
   Aggregate.Operation(opcode_AdditionInfo_Hide);
  end;
 DropModifiedState;
 if (l_OperationType = fiNewFolder) then
  Op_FolderElement_InternalDelete.Call(Aggregate, f_CurNode As IFoldersNode, False);
//#UC END# *4AFAEBEA0018_4C7E91560315exec_impl*
end;//TPrimFoldersElementInfoOptionsForm.ResultExt_Cancel_Execute

procedure TPrimFoldersElementInfoOptionsForm.ResultExt_Ok_Test(const aParams: IvcmTestParamsPrim);
 {* OK }
//#UC START# *4C765D0002E2_4C7E91560315test_var*
var
 l_AdapterNode : INode;
 l_Folder: IeeNode;
 l_Node: IeeNode;
//#UC END# *4C765D0002E2_4C7E91560315test_var*
begin
//#UC START# *4C765D0002E2_4C7E91560315test_impl*
 case f_CurType of
  fiEdit : aParams.Op.Flag[vcm_ofEnabled] := CheckModifiedState;
  fiLoad,
  fiSelect :
   begin
    if Supports(f_CurNode, INode, l_AdapterNode) then
    begin
     try
      aParams.Op.Flag[vcm_ofEnabled] := TFoldersItemType(l_AdapterNode.GetObjectType) <> FIT_FOLDER;
     finally
      l_AdapterNode := nil;
     end;
    end
    else
     aParams.Op.Flag[vcm_ofEnabled] := False;
   end;
  fiSave :
   begin
    aParams.Op.Flag[vcm_ofEnabled] := (f_SavedObject <> nil);
    if aParams.Op.Flag[vcm_ofEnabled] then
    begin
     l_Folder := FindCorrespondingFolder(f_CurNode);
     if Supports(l_Folder, INode, l_AdapterNode) then
     begin
      try
       if (TFoldersItemType(l_AdapterNode.GetObjectType) = FIT_FOLDER) then
        aParams.Op.Flag[vcm_ofEnabled] := CheckFolderElementRights(l_Folder, faAddChild);
       if aParams.Op.Flag[vcm_ofEnabled] then
       begin
        l_Node := FindNodeByName(l_Folder, ElementName.Text, cTypeMap[f_SavedObjType]);
        if Assigned(l_Node) then
        begin
         if f_SaveControlState = cbChecked then
          aParams.Op.Flag[vcm_ofEnabled] := False
         else
          aParams.Op.Flag[vcm_ofEnabled] := CheckFolderElementRights(l_Node, faModify);
        end
        else
         aParams.Op.Flag[vcm_ofEnabled] := True;
       end;
      finally
       l_AdapterNode := nil;
      end;
     end;
    end
    else
     aParams.Op.Flag[vcm_ofEnabled] := False;
   end;
 end;
//#UC END# *4C765D0002E2_4C7E91560315test_impl*
end;//TPrimFoldersElementInfoOptionsForm.ResultExt_Ok_Test

procedure TPrimFoldersElementInfoOptionsForm.ResultExt_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4C765D0002E2_4C7E91560315exec_var*
var
 l_OpsResult : Boolean;
//#UC END# *4C765D0002E2_4C7E91560315exec_var*
begin
//#UC START# *4C765D0002E2_4C7E91560315exec_impl*
 case f_CurType of
  fiNewFolder,
  fiEdit   : l_OpsResult := SaveCurInfo;
  fiLoad,
  fiSelect : l_OpsResult := SendChosenObject;
  fiSave   : l_OpsResult := SaveOrOverrideCurObj;
  else
   l_OpsResult := False;
 end;

 if l_OpsResult then
 begin
  if (Aggregate <> nil) then
   if Container.AsForm.ZoneType = vcm_ztManualModal then
    Op_AdditionInfo_Close.Call(Aggregate, mrOK)
   else
   begin
    f_CurType := fiNone;
    Aggregate.Operation(opcode_AdditionInfo_Hide);
   end;
 end;
 AfterSaveExceptionCheck;
//#UC END# *4C765D0002E2_4C7E91560315exec_impl*
end;//TPrimFoldersElementInfoOptionsForm.ResultExt_Ok_Execute

procedure TPrimFoldersElementInfoOptionsForm.ResultExt_Ok_GetState(var State: TvcmOperationStateIndex);
 {* OK }
//#UC START# *4C765D0002E2_4C7E91560315getstate_var*
//#UC END# *4C765D0002E2_4C7E91560315getstate_var*
begin
//#UC START# *4C765D0002E2_4C7E91560315getstate_impl*
 case f_CurType of
  fiNone : State := st_user_ResultExt_Ok_None;
  fiNewFolder : State := st_user_ResultExt_Ok_NewFolder;
  fiEdit : State := st_user_ResultExt_Ok_Edit;
  fiLoad : State := st_user_ResultExt_Ok_Load;
  fiSelect : State := st_user_ResultExt_Ok_Select;
  fiSave : State := st_user_ResultExt_Ok_FolderSave;
 else
  State := vcm_DefaultOperationState;
 end;
//#UC END# *4C765D0002E2_4C7E91560315getstate_impl*
end;//TPrimFoldersElementInfoOptionsForm.ResultExt_Ok_GetState

procedure TPrimFoldersElementInfoOptionsForm.ResultExt_Append_Test(const aParams: IvcmTestParamsPrim);
 {* Добавить }
//#UC START# *4C7672F903BF_4C7E91560315test_var*
var
 l_AdapterNode : INode;
//#UC END# *4C7672F903BF_4C7E91560315test_var*
begin
//#UC START# *4C7672F903BF_4C7E91560315test_impl*
 aParams.Op.Flag[vcm_ofVisible] := True;
 case f_CurType of
  fiNone:
   aParams.Op.Flag[vcm_ofEnabled] := False;
  fiNewFolder, fiEdit, fiLoad, fiSelect:
   aParams.Op.Flag[vcm_ofVisible] := False;
  fiSave:
   if Supports(f_CurNode, INode, l_AdapterNode) then
   begin
    try
     case f_SavedObjType of
      fetBookmark, fetList, fetDrugList:
       aParams.Op.Flag[vcm_ofEnabled] :=
         (TFoldersItemType(l_AdapterNode.GetObjectType) = FIT_LIST) and
         CheckFolderElementRights(f_CurNode, faModify);
      fetQuery{, fetFilter}:
       aParams.Op.Flag[vcm_ofEnabled] := False;
      fetDrugBookMark:
       aParams.Op.Flag[vcm_ofEnabled] := False;
      else
       Assert(false); 
     end;//case f_SavedObjType
    finally
     l_AdapterNode := nil;
    end;//try..finally
   end//Supports(f_CurNode, INode, l_AdapterNode)
   else
    aParams.Op.Flag[vcm_ofEnabled] := False;
 end;//case f_CurType
//#UC END# *4C7672F903BF_4C7E91560315test_impl*
end;//TPrimFoldersElementInfoOptionsForm.ResultExt_Append_Test

procedure TPrimFoldersElementInfoOptionsForm.ResultExt_Append_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Добавить }
//#UC START# *4C7672F903BF_4C7E91560315exec_var*
var
 l_AdapterNode: INode;
 l_Object: IUnknown;

 l_Entity: IEntityBase;
 l_Storage: IEntityStorage;

//#UC END# *4C7672F903BF_4C7E91560315exec_var*
begin
//#UC START# *4C7672F903BF_4C7E91560315exec_impl*
 if SaveCurInfo(False, True) then
 begin
  if Supports(f_CurNode, INode, l_AdapterNode) then
   try
    try
     l_AdapterNode.Open(l_Object);
    except
     on ECanNotFindData do
      exit; //TODO: нода "пропала" что делать?
    end;

    // Добавление объектов к списку
    if (TFoldersItemType(l_AdapterNode.GetObjectType) in [FIT_LIST]) and
      Supports(f_SavedObject, IEntityBase, l_Entity) then
     try
      l_Entity.AppendTo(l_AdapterNode, l_Storage);
     finally
      l_Entity := nil;
     end;

   finally
    l_AdapterNode := nil;
   end;

  if (Aggregate <> nil) then
   if Container.AsForm.ZoneType = vcm_ztManualModal then
    Op_AdditionInfo_Close.Call(Aggregate, mrOK)
   else
   begin
    f_CurType := fiNone;
    Aggregate.Operation(opcode_AdditionInfo_Hide);
   end;
 end;
 AfterSaveExceptionCheck;
//#UC END# *4C7672F903BF_4C7E91560315exec_impl*
end;//TPrimFoldersElementInfoOptionsForm.ResultExt_Append_Execute

procedure TPrimFoldersElementInfoOptionsForm.ResultExt_Append_GetState(var State: TvcmOperationStateIndex);
 {* Добавить }
//#UC START# *4C7672F903BF_4C7E91560315getstate_var*
//#UC END# *4C7672F903BF_4C7E91560315getstate_var*
begin
//#UC START# *4C7672F903BF_4C7E91560315getstate_impl*
 State := vcm_DefaultOperationState;
 if (f_CurType = fiSave) then
 begin
  case f_SavedObjType of
   fetBookmark, fetDrugBookmark:
    State := st_user_ResultExt_Append_Bookmark;
   fetList, fetDrugList:
    State := st_user_ResultExt_Append_List;
   fetQuery{, fetFilter}:
    State := st_user_ResultExt_Append_Query;
   else
    Assert(false); 
  end;//case f_SavedObjType
 end;//f_CurType = fiSave
//#UC END# *4C7672F903BF_4C7E91560315getstate_impl*
end;//TPrimFoldersElementInfoOptionsForm.ResultExt_Append_GetState

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersElementInfoOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_ResultExt, nil);
  ToolbarAtBottom(en_ResultExt);
  PublishOp(en_ResultExt, op_Cancel, ResultExt_Cancel_Execute, ResultExt_Cancel_Test, nil);
  ShowInContextMenu(en_ResultExt, op_Cancel, False);
  ShowInToolbar(en_ResultExt, op_Cancel, True);
  PublishOp(en_ResultExt, op_Ok, ResultExt_Ok_Execute, ResultExt_Ok_Test, ResultExt_Ok_GetState);
  ShowInContextMenu(en_ResultExt, op_Ok, False);
  ShowInToolbar(en_ResultExt, op_Ok, False);
  PublishOp(en_ResultExt, op_Append, ResultExt_Append_Execute, ResultExt_Append_Test, ResultExt_Append_GetState);
  ShowInContextMenu(en_ResultExt, op_Append, False);
  ShowInToolbar(en_ResultExt, op_Append, False);
 end;//with Entities.Entities
end;//TPrimFoldersElementInfoOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimFoldersElementInfoOptionsForm);
 {* Регистрация PrimFoldersElementInfoOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
