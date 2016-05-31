unit PrimFolders_Form;
 {* Мои документы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFolders_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimFolders" MUID: (4A96B6AE0071)
// Имя типа: "TPrimFoldersForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_Strange_Controls
 , Folders_Result_Controls
 , Folders_Strange_Controls
 , vtProportionalPanel
 , vtPanel
 , vtSizeablePanel
 , nsTypes
 , FoldersUnit
 , l3Interfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimFoldersForm = class({$If NOT Defined(NoVCM)}
 TvcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Мои документы }
  private
   f_IsInfoShown: Boolean;
   f_BackgroundPanel: TvtProportionalPanel;
   f_ParentZone: TvtPanel;
   f_ChildZone: TvtSizeablePanel;
  protected
   procedure UtFoldersQueryClose(aSender: TObject);
    {* Обработчик события utFolders.OnQueryClose }
   procedure FinishDataUpdate; override;
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCL)}
   procedure SetParent(AParent: TWinControl); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure FoldersControl_EditElement_Execute(const aNode: IFoldersNode);
    {* Начать редактирование элемента }
   procedure FoldersControl_EditElement(const aParams: IvcmExecuteParams);
    {* Начать редактирование элемента }
   function FoldersControl_DeleteElement_Execute(const aNode: IFoldersNode): TnsDeleteResult;
    {* Удалить элемент }
   procedure FoldersControl_DeleteElement(const aParams: IvcmExecuteParams);
    {* Удалить элемент }
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_GetState(var State: TvcmOperationStateIndex);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Result_Append_Test(const aParams: IvcmTestParamsPrim);
    {* Добавить }
   procedure Result_Append_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Добавить }
   procedure AdditionInfo_Show_Execute;
   procedure AdditionInfo_Show(const aParams: IvcmExecuteParams);
   procedure AdditionInfo_Hide_Execute;
   procedure AdditionInfo_Hide(const aParams: IvcmExecuteParams);
   procedure AdditionInfo_SetCaption_Execute(const aCaption: Il3CString);
   procedure AdditionInfo_SetCaption(const aParams: IvcmExecuteParams);
   procedure Switcher_BecomeActive_Execute;
   procedure Switcher_BecomeActive(const aParams: IvcmExecuteParams);
   procedure AdditionInfo_Close_Execute(aModalResult: Integer = Controls.mrCancel);
   procedure AdditionInfo_Close(const aParams: IvcmExecuteParams);
  public
   property BackgroundPanel: TvtProportionalPanel
    read f_BackgroundPanel;
   property ParentZone: TvtPanel
    read f_ParentZone;
   property ChildZone: TvtSizeablePanel
    read f_ChildZone;
 end;//TPrimFoldersForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimFolders_utFolders_UserType
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4A96B6AE0071impl_uses*
 , vcmEntityForm
 //#UC END# *4A96B6AE0071impl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersForm.UtFoldersQueryClose(aSender: TObject);
 {* Обработчик события utFolders.OnQueryClose }
//#UC START# *1BA52F720139_4A96B6AE0071_var*
//#UC END# *1BA52F720139_4A96B6AE0071_var*
begin
//#UC START# *1BA52F720139_4A96B6AE0071_impl*
 SafeClose;
//#UC END# *1BA52F720139_4A96B6AE0071_impl*
end;//TPrimFoldersForm.UtFoldersQueryClose

procedure TPrimFoldersForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
 {* Отмена }
//#UC START# *4A8AD46D0226_4A96B6AE0071test_var*
//#UC END# *4A8AD46D0226_4A96B6AE0071test_var*
begin
//#UC START# *4A8AD46D0226_4A96B6AE0071test_impl*
 if f_IsInfoShown then
 begin
  aParams.Op.Flag[vcm_ofVisible] := True;
  aParams.Op.Flag[vcm_ofEnabled] := True;
 end
 else
 begin
  aParams.Op.Flag[vcm_ofVisible] := False;
  aParams.Op.Flag[vcm_ofEnabled] := False;
 end;
//#UC END# *4A8AD46D0226_4A96B6AE0071test_impl*
end;//TPrimFoldersForm.Result_Cancel_Test

procedure TPrimFoldersForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *4A8AD46D0226_4A96B6AE0071exec_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4A8AD46D0226_4A96B6AE0071exec_var*
begin
//#UC START# *4A8AD46D0226_4A96B6AE0071exec_impl*
 if f_IsInfoShown and
    HasForm(vcm_ztChild, False, @l_Form) then
  try
   l_Form.Entity.Operation(TdmStdRes.opcode_ResultExt_Cancel, aParams As IvcmExecuteParams);
  finally
   l_Form := nil;
  end;
//#UC END# *4A8AD46D0226_4A96B6AE0071exec_impl*
end;//TPrimFoldersForm.Result_Cancel_Execute

procedure TPrimFoldersForm.FoldersControl_EditElement_Execute(const aNode: IFoldersNode);
 {* Начать редактирование элемента }
//#UC START# *4A96A9BE011C_4A96B6AE0071exec_var*
//#UC END# *4A96A9BE011C_4A96B6AE0071exec_var*
begin
//#UC START# *4A96A9BE011C_4A96B6AE0071exec_impl*
 Op_FolderElement_InternalEditByFoldersNode.Call(Aggregate, aNode);
//#UC END# *4A96A9BE011C_4A96B6AE0071exec_impl*
end;//TPrimFoldersForm.FoldersControl_EditElement_Execute

procedure TPrimFoldersForm.FoldersControl_EditElement(const aParams: IvcmExecuteParams);
 {* Начать редактирование элемента }
begin
 with (aParams.Data As IFoldersControl_EditElement_Params) do
  Self.FoldersControl_EditElement_Execute(Node);
end;//TPrimFoldersForm.FoldersControl_EditElement

function TPrimFoldersForm.FoldersControl_DeleteElement_Execute(const aNode: IFoldersNode): TnsDeleteResult;
 {* Удалить элемент }
//#UC START# *4A96A9D10023_4A96B6AE0071exec_var*
//#UC END# *4A96A9D10023_4A96B6AE0071exec_var*
begin
//#UC START# *4A96A9D10023_4A96B6AE0071exec_impl*
 Result := Op_FolderElement_InternalDelete.Call(Aggregate, aNode);
//#UC END# *4A96A9D10023_4A96B6AE0071exec_impl*
end;//TPrimFoldersForm.FoldersControl_DeleteElement_Execute

procedure TPrimFoldersForm.FoldersControl_DeleteElement(const aParams: IvcmExecuteParams);
 {* Удалить элемент }
begin
 with (aParams.Data As IFoldersControl_DeleteElement_Params) do
  ResultValue := Self.FoldersControl_DeleteElement_Execute(Node);
end;//TPrimFoldersForm.FoldersControl_DeleteElement

procedure TPrimFoldersForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
 {* OK }
//#UC START# *4A97EBE702F8_4A96B6AE0071test_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4A97EBE702F8_4A96B6AE0071test_var*
begin
//#UC START# *4A97EBE702F8_4A96B6AE0071test_impl*
 if f_IsInfoShown and
    HasForm(vcm_ztChild, False, @l_Form) then
  try
   l_Form.Entity.Operation(TdmStdRes.opcode_ResultExt_Ok, aParams As IvcmTestParams);
  finally
   l_Form := nil;
  end
 else
 begin
  aParams.Op.Flag[vcm_ofVisible] := False;
  aParams.Op.Flag[vcm_ofEnabled] := False;
 end;
//#UC END# *4A97EBE702F8_4A96B6AE0071test_impl*
end;//TPrimFoldersForm.Result_Ok_Test

procedure TPrimFoldersForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4A97EBE702F8_4A96B6AE0071exec_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4A97EBE702F8_4A96B6AE0071exec_var*
begin
//#UC START# *4A97EBE702F8_4A96B6AE0071exec_impl*
 if f_IsInfoShown and
    HasForm(vcm_ztChild, False, @l_Form) then
  try
   l_Form.Entity.Operation(TdmStdRes.opcode_ResultExt_Ok, aParams As IvcmExecuteParams);
  finally
   l_Form := nil;
  end;//try..finally
//#UC END# *4A97EBE702F8_4A96B6AE0071exec_impl*
end;//TPrimFoldersForm.Result_Ok_Execute

procedure TPrimFoldersForm.Result_Ok_GetState(var State: TvcmOperationStateIndex);
 {* OK }
//#UC START# *4A97EBE702F8_4A96B6AE0071getstate_var*
//#UC END# *4A97EBE702F8_4A96B6AE0071getstate_var*
begin
//#UC START# *4A97EBE702F8_4A96B6AE0071getstate_impl*
 // Do nothing
//#UC END# *4A97EBE702F8_4A96B6AE0071getstate_impl*
end;//TPrimFoldersForm.Result_Ok_GetState

procedure TPrimFoldersForm.Result_Append_Test(const aParams: IvcmTestParamsPrim);
 {* Добавить }
//#UC START# *4A98000500BA_4A96B6AE0071test_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4A98000500BA_4A96B6AE0071test_var*
begin
//#UC START# *4A98000500BA_4A96B6AE0071test_impl*
 if f_IsInfoShown and
    HasForm(vcm_ztChild, False, @l_Form) then
  try
   l_Form.Entity.Operation(TdmStdRes.opcode_ResultExt_Append, aParams As IvcmTestParams);
  finally
   l_Form := nil;
  end
 else
 begin
  aParams.Op.Flag[vcm_ofVisible] := False;
  aParams.Op.Flag[vcm_ofEnabled] := False;
 end;
//#UC END# *4A98000500BA_4A96B6AE0071test_impl*
end;//TPrimFoldersForm.Result_Append_Test

procedure TPrimFoldersForm.Result_Append_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Добавить }
//#UC START# *4A98000500BA_4A96B6AE0071exec_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4A98000500BA_4A96B6AE0071exec_var*
begin
//#UC START# *4A98000500BA_4A96B6AE0071exec_impl*
 if f_IsInfoShown and
    HasForm(vcm_ztChild, False, @l_Form) then
  try
   l_Form.Entity.Operation(TdmStdRes.opcode_ResultExt_Append, aParams As IvcmExecuteParams);
  finally
   l_Form := nil;
  end;
//#UC END# *4A98000500BA_4A96B6AE0071exec_impl*
end;//TPrimFoldersForm.Result_Append_Execute

procedure TPrimFoldersForm.AdditionInfo_Show_Execute;
//#UC START# *4A980672034B_4A96B6AE0071exec_var*
//#UC END# *4A980672034B_4A96B6AE0071exec_var*
begin
//#UC START# *4A980672034B_4A96B6AE0071exec_impl*
 ChildZone.Show;
 f_IsInfoShown := True;
 ManualUpdateActions;
 //
 op_FolderElement_Redraw.Call(Aggregate);
 //
 if (ChildZone.Controls[0] is TvcmEntityForm) then
  TvcmEntityForm(ChildZone.Controls[0]).SetActiveControl;
//#UC END# *4A980672034B_4A96B6AE0071exec_impl*
end;//TPrimFoldersForm.AdditionInfo_Show_Execute

procedure TPrimFoldersForm.AdditionInfo_Show(const aParams: IvcmExecuteParams);
begin
 Self.AdditionInfo_Show_Execute;
end;//TPrimFoldersForm.AdditionInfo_Show

procedure TPrimFoldersForm.AdditionInfo_Hide_Execute;
//#UC START# *4A9806B600E8_4A96B6AE0071exec_var*
//#UC END# *4A9806B600E8_4A96B6AE0071exec_var*
begin
//#UC START# *4A9806B600E8_4A96B6AE0071exec_impl*
 if (ParentZone.Controls[0] is TvcmEntityForm) then
  TvcmEntityForm(ParentZone.Controls[0]).SetActiveControl;
 //
 ChildZone.Hide;
 f_IsInfoShown := False;
//#UC END# *4A9806B600E8_4A96B6AE0071exec_impl*
end;//TPrimFoldersForm.AdditionInfo_Hide_Execute

procedure TPrimFoldersForm.AdditionInfo_Hide(const aParams: IvcmExecuteParams);
begin
 Self.AdditionInfo_Hide_Execute;
end;//TPrimFoldersForm.AdditionInfo_Hide

procedure TPrimFoldersForm.AdditionInfo_SetCaption_Execute(const aCaption: Il3CString);
//#UC START# *4A9806D7038D_4A96B6AE0071exec_var*
//#UC END# *4A9806D7038D_4A96B6AE0071exec_var*
begin
//#UC START# *4A9806D7038D_4A96B6AE0071exec_impl*
 CCaption := vcmFmt(str_MyDocumentsCaption, [aCaption]);
//#UC END# *4A9806D7038D_4A96B6AE0071exec_impl*
end;//TPrimFoldersForm.AdditionInfo_SetCaption_Execute

procedure TPrimFoldersForm.AdditionInfo_SetCaption(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IAdditionInfo_SetCaption_Params) do
  Self.AdditionInfo_SetCaption_Execute(Caption);
end;//TPrimFoldersForm.AdditionInfo_SetCaption

procedure TPrimFoldersForm.Switcher_BecomeActive_Execute;
//#UC START# *4A9807F801F9_4A96B6AE0071exec_var*
//#UC END# *4A9807F801F9_4A96B6AE0071exec_var*
begin
//#UC START# *4A9807F801F9_4A96B6AE0071exec_impl*
 SetActiveInParent;
//#UC END# *4A9807F801F9_4A96B6AE0071exec_impl*
end;//TPrimFoldersForm.Switcher_BecomeActive_Execute

procedure TPrimFoldersForm.Switcher_BecomeActive(const aParams: IvcmExecuteParams);
begin
 Self.Switcher_BecomeActive_Execute;
end;//TPrimFoldersForm.Switcher_BecomeActive

procedure TPrimFoldersForm.AdditionInfo_Close_Execute(aModalResult: Integer = Controls.mrCancel);
//#UC START# *4AE9BF890271_4A96B6AE0071exec_var*
//#UC END# *4AE9BF890271_4A96B6AE0071exec_var*
begin
//#UC START# *4AE9BF890271_4A96B6AE0071exec_impl*
 if (ZoneType = vcm_ztManualModal) then
  Self.ModalResult := aModalResult
 else
  SafeClose;
//#UC END# *4AE9BF890271_4A96B6AE0071exec_impl*
end;//TPrimFoldersForm.AdditionInfo_Close_Execute

procedure TPrimFoldersForm.AdditionInfo_Close(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IAdditionInfo_Close_Params) do
  Self.AdditionInfo_Close_Execute(ModalResult);
end;//TPrimFoldersForm.AdditionInfo_Close

procedure TPrimFoldersForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4A96B6AE0071_var*
//#UC END# *47EA4E9002C6_4A96B6AE0071_var*
begin
//#UC START# *47EA4E9002C6_4A96B6AE0071_impl*
 inherited;
 ModalResult := mrCancel; // http://mdp.garant.ru/pages/viewpage.action?pageId=316506551 
//#UC END# *47EA4E9002C6_4A96B6AE0071_impl*
end;//TPrimFoldersForm.FinishDataUpdate

procedure TPrimFoldersForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4A96B6AE0071_var*
//#UC END# *49803F5503AA_4A96B6AE0071_var*
begin
//#UC START# *49803F5503AA_4A96B6AE0071_impl*
 inherited;
 ChildZone.Hide;
 f_IsInfoShown := False;
//#UC END# *49803F5503AA_4A96B6AE0071_impl*
end;//TPrimFoldersForm.DoInit

procedure TPrimFoldersForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4A96B6AE0071_var*
//#UC END# *4A8E8F2E0195_4A96B6AE0071_var*
begin
//#UC START# *4A8E8F2E0195_4A96B6AE0071_impl*
 Height := 531;
 ActiveControl := ParentZone;
 with BackgroundPanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;
 with ParentZone do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;
 with ChildZone do
 begin
  Height := 233;
  ResizeAreaWidth := 5;
  SizeableSides := [szTop];
  SplitterBevel := bvRaised;
  Align := alBottom;
  BevelOuter := bvNone;
 end;
//#UC END# *4A8E8F2E0195_4A96B6AE0071_impl*
end;//TPrimFoldersForm.InitControls

{$If NOT Defined(NoVCL)}
procedure TPrimFoldersForm.SetParent(AParent: TWinControl);
//#UC START# *4A97E78202FC_4A96B6AE0071_var*
//#UC END# *4A97E78202FC_4A96B6AE0071_var*
begin
//#UC START# *4A97E78202FC_4A96B6AE0071_impl*
 inherited;
 // При отстыковки закладки по DblClick-у или из настроек, форма в childzone
 // могла занимать все пространство, т.к. Align = alBottom поделим место если
 // это так
 if Assigned(aParent) and (Parent.ClientHeight > 0) and
   (ChildZone.Height > Parent.ClientHeight) then
  ChildZone.Height := Parent.ClientHeight div 2;
//#UC END# *4A97E78202FC_4A96B6AE0071_impl*
end;//TPrimFoldersForm.SetParent
{$IfEnd} // NOT Defined(NoVCL)

procedure TPrimFoldersForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  PublishFormEntity(en_FoldersControl, nil);
  PublishFormEntity(en_AdditionInfo, nil);
  PublishFormEntity(en_Switcher, nil);
  ToolbarAtBottom(en_Result);
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, nil);
  PublishOpWithResult(en_FoldersControl, op_EditElement, FoldersControl_EditElement, nil, nil);
  PublishOpWithResult(en_FoldersControl, op_DeleteElement, FoldersControl_DeleteElement, nil, nil);
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, Result_Ok_GetState);
  PublishOp(en_Result, op_Append, Result_Append_Execute, Result_Append_Test, nil);
  PublishOpWithResult(en_AdditionInfo, op_Show, AdditionInfo_Show, nil, nil);
  PublishOpWithResult(en_AdditionInfo, op_Hide, AdditionInfo_Hide, nil, nil);
  PublishOpWithResult(en_AdditionInfo, op_SetCaption, AdditionInfo_SetCaption, nil, nil);
  PublishOpWithResult(en_Switcher, op_BecomeActive, Switcher_BecomeActive, nil, nil);
  PublishOpWithResult(en_AdditionInfo, op_Close, AdditionInfo_Close, nil, nil);
 end;//with Entities.Entities
end;//TPrimFoldersForm.InitEntities

procedure TPrimFoldersForm.MakeControls;
begin
 inherited;
 with AddUsertype(utFoldersName,
  str_utFoldersCaption,
  str_utFoldersCaption,
  False,
  65,
  20,
  '',
  nil,
  nil,
  UtFoldersQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utFoldersName
 f_BackgroundPanel := TvtProportionalPanel.Create(Self);
 f_BackgroundPanel.Name := 'BackgroundPanel';
 f_BackgroundPanel.Parent := Self;
 f_ParentZone := TvtPanel.Create(Self);
 f_ParentZone.Name := 'ParentZone';
 f_ParentZone.Parent := BackgroundPanel;
 with DefineZone(vcm_ztParent, ParentZone) do
 begin
  FormStyle.Toolbars.Top.MergeWithContainer := vcm_bTrue;
 end;//with DefineZone(vcm_ztParent
 f_ChildZone := TvtSizeablePanel.Create(Self);
 f_ChildZone.Name := 'ChildZone';
 f_ChildZone.Parent := BackgroundPanel;
 with DefineZone(vcm_ztChild, ChildZone) do
 begin
 end;//with DefineZone(vcm_ztChild
end;//TPrimFoldersForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimFoldersForm);
 {* Регистрация PrimFolders }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
