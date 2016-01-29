unit PrimFolders_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/Forms/PrimFolders_Form.pas"
// Начат: 27.08.2009 20:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Основные прецеденты::Folders::View::Folders::PrimFolders
//
// Мои документы
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
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  Folders_Strange_Controls,
  Folders_Result_Controls,
  Base_Operations_Strange_Controls,
  Base_Operations_Editions_Controls,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  PrimFolders_utFolders_UserType
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  FoldersUnit,
  nsTypes,
  l3Interfaces,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a},
  vcmContainerForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimFoldersForm = {form} class(TvcmContainerForm)
  {* Мои документы }
 private
 // private fields
   f_IsInfoShown : Boolean;
   f_BackgroundPanel : TvtProportionalPanel;
    {* Поле для свойства BackgroundPanel}
   f_ParentZone : TvtPanel;
    {* Поле для свойства ParentZone}
   f_ChildZone : TvtSizeablePanel;
    {* Поле для свойства ChildZone}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   procedure FoldersControl_EditElement_Execute(const aNode: IFoldersNode);
     {* Начать редактирование элемента }
   procedure FoldersControl_EditElement(const aParams: IvcmExecuteParams);
     {* Начать редактирование элемента }
   function FoldersControl_DeleteElement_Execute(const aNode: IFoldersNode): TnsDeleteResult;
     {* Удалить элемент }
   procedure FoldersControl_DeleteElement(const aParams: IvcmExecuteParams);
     {* Удалить элемент }
   {$If not defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_GetState(var State: TvcmOperationStateIndex);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
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
   procedure AdditionInfo_Close_Execute(aModalResult: Integer = mrCancel);
   procedure AdditionInfo_Close(const aParams: IvcmExecuteParams);
 protected
 // overridden protected methods
   procedure FinishDataUpdate; override;
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCL)}
   procedure SetParent(AParent: TWinControl); override;
   {$IfEnd} //not NoVCL
 protected
 // protected methods
   procedure UtFoldersQueryClose(aSender: TObject);
     {* Обработчик события utFolders.OnQueryClose }
 public
 // public properties
   property BackgroundPanel: TvtProportionalPanel
     read f_BackgroundPanel;
   property ParentZone: TvtPanel
     read f_ParentZone;
   property ChildZone: TvtSizeablePanel
     read f_ChildZone;
 end;//TPrimFoldersForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base {a},
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки utFoldersLocalConstants }
  str_utFoldersCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFoldersCaption'; rValue : 'Мои документы');
   { Заголовок пользовательского типа "Мои документы" }

// start class TPrimFoldersForm

procedure TPrimFoldersForm.UtFoldersQueryClose(aSender: TObject);
//#UC START# *1BA52F720139_4A96B6AE0071_var*
//#UC END# *1BA52F720139_4A96B6AE0071_var*
begin
//#UC START# *1BA52F720139_4A96B6AE0071_impl*
 SafeClose;
//#UC END# *1BA52F720139_4A96B6AE0071_impl*
end;//TPrimFoldersForm.UtFoldersQueryClose

{$If not defined(NoVCM)}
procedure TPrimFoldersForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimFoldersForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
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
{$IfEnd} //not NoVCM

procedure TPrimFoldersForm.FoldersControl_EditElement_Execute(const aNode: IFoldersNode);
//#UC START# *4A96A9BE011C_4A96B6AE0071exec_var*
//#UC END# *4A96A9BE011C_4A96B6AE0071exec_var*
begin
//#UC START# *4A96A9BE011C_4A96B6AE0071exec_impl*
 Op_FolderElement_InternalEditByFoldersNode.Call(Aggregate, aNode);
//#UC END# *4A96A9BE011C_4A96B6AE0071exec_impl*
end;//TPrimFoldersForm.FoldersControl_EditElement_Execute

procedure TPrimFoldersForm.FoldersControl_EditElement(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IFoldersControl_EditElement_Params) do
  FoldersControl_EditElement_Execute(Node);
end;

function TPrimFoldersForm.FoldersControl_DeleteElement_Execute(const aNode: IFoldersNode): TnsDeleteResult;
//#UC START# *4A96A9D10023_4A96B6AE0071exec_var*
//#UC END# *4A96A9D10023_4A96B6AE0071exec_var*
begin
//#UC START# *4A96A9D10023_4A96B6AE0071exec_impl*
 Result := Op_FolderElement_InternalDelete.Call(Aggregate, aNode);
//#UC END# *4A96A9D10023_4A96B6AE0071exec_impl*
end;//TPrimFoldersForm.FoldersControl_DeleteElement_Execute

procedure TPrimFoldersForm.FoldersControl_DeleteElement(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IFoldersControl_DeleteElement_Params) do
  ResultValue := FoldersControl_DeleteElement_Execute(Node);
end;

{$If not defined(NoVCM)}
procedure TPrimFoldersForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimFoldersForm.Result_Ok_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4A97EBE702F8_4A96B6AE0071getstate_var*
//#UC END# *4A97EBE702F8_4A96B6AE0071getstate_var*
begin
//#UC START# *4A97EBE702F8_4A96B6AE0071getstate_impl*
 // Do nothing
//#UC END# *4A97EBE702F8_4A96B6AE0071getstate_impl*
end;//TPrimFoldersForm.Result_Ok_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimFoldersForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
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
{$IfEnd} //not NoVCM

procedure TPrimFoldersForm.Result_Append_Test(const aParams: IvcmTestParamsPrim);
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
 AdditionInfo_Show_Execute;
end;

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
 AdditionInfo_Hide_Execute;
end;

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
  AdditionInfo_SetCaption_Execute(Caption);
end;

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
 Switcher_BecomeActive_Execute;
end;

procedure TPrimFoldersForm.AdditionInfo_Close_Execute(aModalResult: Integer = mrCancel);
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
  AdditionInfo_Close_Execute(ModalResult);
end;

procedure TPrimFoldersForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4A96B6AE0071_var*
//#UC END# *47EA4E9002C6_4A96B6AE0071_var*
begin
//#UC START# *47EA4E9002C6_4A96B6AE0071_impl*
 inherited;
 ModalResult := mrCancel; // http://mdp.garant.ru/pages/viewpage.action?pageId=316506551 
//#UC END# *47EA4E9002C6_4A96B6AE0071_impl*
end;//TPrimFoldersForm.FinishDataUpdate

{$If not defined(NoVCM)}
procedure TPrimFoldersForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_4A96B6AE0071_var*
//#UC END# *49803F5503AA_4A96B6AE0071_var*
begin
//#UC START# *49803F5503AA_4A96B6AE0071_impl*
 inherited;
 ChildZone.Hide;
 f_IsInfoShown := False;
//#UC END# *49803F5503AA_4A96B6AE0071_impl*
end;//TPrimFoldersForm.DoInit
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimFoldersForm.InitControls;
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCL)}
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
{$IfEnd} //not NoVCL

procedure TPrimFoldersForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  PublishFormEntity(en_FoldersControl, nil);
  PublishFormEntity(en_AdditionInfo, nil);
  PublishFormEntity(en_Switcher, nil);
  ToolbarAtBottom(en_Result);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, nil);
  {$IfEnd} //not NoVCM

  PublishOpWithResult(en_FoldersControl, op_EditElement, FoldersControl_EditElement, nil, nil);
  PublishOpWithResult(en_FoldersControl, op_DeleteElement, FoldersControl_DeleteElement, nil, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, Result_Ok_GetState);
  {$IfEnd} //not NoVCM

  PublishOp(en_Result, op_Append, Result_Append_Execute, Result_Append_Test, nil);
  PublishOpWithResult(en_AdditionInfo, op_Show, AdditionInfo_Show, nil, nil);
  PublishOpWithResult(en_AdditionInfo, op_Hide, AdditionInfo_Hide, nil, nil);
  PublishOpWithResult(en_AdditionInfo, op_SetCaption, AdditionInfo_SetCaption, nil, nil);
  PublishOpWithResult(en_Switcher, op_BecomeActive, Switcher_BecomeActive, nil, nil);
  PublishOpWithResult(en_AdditionInfo, op_Close, AdditionInfo_Close, nil, nil);
 end;//with Entities.Entities
end;

procedure TPrimFoldersForm.MakeControls;
begin
 inherited;
 f_BackgroundPanel := TvtProportionalPanel.Create(Self);
 f_BackgroundPanel.Name := 'BackgroundPanel';
 f_BackgroundPanel.Parent := Self;
 f_ParentZone := TvtPanel.Create(Self);
 f_ParentZone.Name := 'ParentZone';
 f_ParentZone.Parent := BackgroundPanel;
 with DefineZone(vcm_ztParent, f_ParentZone) do
 begin
  FormStyle.Toolbars.Top.MergeWithContainer := vcm_bTrue;
 end;//with DefineZone(vcm_ztParent, f_ParentZone)
 f_ChildZone := TvtSizeablePanel.Create(Self);
 f_ChildZone.Name := 'ChildZone';
 f_ChildZone.Parent := BackgroundPanel;
 with DefineZone(vcm_ztChild, f_ChildZone) do
 begin
 end;//with DefineZone(vcm_ztChild, f_ChildZone)
 with AddUsertype(utFoldersName,
  str_utFoldersCaption,
  str_utFoldersCaption,
  false,
  65,
  20,
  '',
  nil,
  nil,
  UtFoldersQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utFoldersName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utFoldersCaption
 str_utFoldersCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimFolders
 TtfwClassRef.Register(TPrimFoldersForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.