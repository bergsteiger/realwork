unit PrimAttributesOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimAttributesOptions_Form.pas"
// Начат: 07.09.2010 18:10
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::Attributes::PrimAttributesOptions
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
  afwInterfaces,
  l3TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Text_Controls
  {$IfEnd} //not NoVCM
  ,
  PrimAttributes_Form,
  Document_Strange_Controls,
  Base_Operations_Editions_Controls
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimAttributesOptionsForm = {form} class(TPrimAttributesForm)
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure File_Print_Test(const aParams: IvcmTestParamsPrim);
     {* Печать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Печать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
     {* Печать... }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Печать... }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
     {* Предварительный просмотр }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Предварительный просмотр }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
     {* Копировать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Copy_GetState(var State: TvcmOperationStateIndex);
     {* Копировать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Копировать }
   {$IfEnd} //not NoVCM
   procedure Attribute_Copy_Test(const aParams: IvcmTestParamsPrim);
   procedure Attribute_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 protected
 // protected methods
   function MakePreview: IafwDocumentPreview;
   function HasTree: Boolean;
   function TvAttributesGetItemImage(Sender: TObject;
     Index: Integer;
     var aImages: TCustomImageList): Integer;
   procedure TvAttributesMakeTreeSource(out theTree: Il3SimpleTree);
 end;//TPrimAttributesOptionsForm

 TvcmEntityFormRef = TPrimAttributesOptionsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  afwFacade,
  l3Base,
  evTreeDataObject,
  evTreeStorable,
  nsSingleAttributeData,
  DynamicTreeUnit,
  Printers,
  DocumentRes,
  eeInterfaces
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3ControlsTypes,
  nsDocumentPreview,
  nsHAFPainter,
  evFormatHAFMacroReplacer,
  nsDocInfoHAFMacroReplacer,
  nevBase
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Tree_Controls
  {$IfEnd} //not NoVCM
  ,
  DataAdapter
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimAttributesOptionsForm

function TPrimAttributesOptionsForm.MakePreview: IafwDocumentPreview;
//#UC START# *4C864C08016E_4C8647C8024E_var*
//#UC END# *4C864C08016E_4C8647C8024E_var*
begin
//#UC START# *4C864C08016E_4C8647C8024E_impl*
 if HasTree then
  Result := TnsDocumentPreview.Make(TevTreeStorable.MakeStorable(TevTreeStorableData_C(tvAttributes.
   TreeStruct)), evDefaultPreviewCacheKey,
   TnsHAFPainter.Make(TevFormatHAFMacroReplacer.Make(TnsDocInfoHAFMacroReplacer.Make(nil, CoDS.DocInfo),
    vcmCStr(str_AttributesHAFPrefix))))
 else
  Result := nil;
//#UC END# *4C864C08016E_4C8647C8024E_impl*
end;//TPrimAttributesOptionsForm.MakePreview

function TPrimAttributesOptionsForm.HasTree: Boolean;
//#UC START# *4C864DD70182_4C8647C8024E_var*
//#UC END# *4C864DD70182_4C8647C8024E_var*
begin
//#UC START# *4C864DD70182_4C8647C8024E_impl*
 with tvAttributes do
  Result := IsTreeAssign and (TreeStruct.RootNode <> nil);
//#UC END# *4C864DD70182_4C8647C8024E_impl*
end;//TPrimAttributesOptionsForm.HasTree

function TPrimAttributesOptionsForm.TvAttributesGetItemImage(Sender: TObject;
  Index: Integer;
  var aImages: TCustomImageList): Integer;
//#UC START# *511A3C6F0383_4C8647C8024E_var*
var
 l_eeNode : IeeNode;
//#UC END# *511A3C6F0383_4C8647C8024E_var*
begin
//#UC START# *511A3C6F0383_4C8647C8024E_impl*
 Result := -1;
 l_eeNode := tvAttributes.TreeView.GetNode(Index);
 if (l_eeNode <> nil) then
  if l_eeNode.HasChild
   then Result := diilFolderIcon
   else Result := diilAttribute;
//#UC END# *511A3C6F0383_4C8647C8024E_impl*
end;//TPrimAttributesOptionsForm.TvAttributesGetItemImage

procedure TPrimAttributesOptionsForm.TvAttributesMakeTreeSource(out theTree: Il3SimpleTree);
//#UC START# *511A3D5D01FA_4C8647C8024E_var*
//#UC END# *511A3D5D01FA_4C8647C8024E_var*
begin
//#UC START# *511A3D5D01FA_4C8647C8024E_impl*
 if Assigned(CoDS) then
  theTree := CoDS.SimpleTree;
//#UC END# *511A3D5D01FA_4C8647C8024E_impl*
end;//TPrimAttributesOptionsForm.TvAttributesMakeTreeSource

{$If not defined(NoVCM)}
procedure TPrimAttributesOptionsForm.File_Print_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49521D8E0295_4C8647C8024Etest_var*
//#UC END# *49521D8E0295_4C8647C8024Etest_var*
begin
//#UC START# *49521D8E0295_4C8647C8024Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := {not DefDataAdapter.IsTrialMode and }HasTree;
//#UC END# *49521D8E0295_4C8647C8024Etest_impl*
end;//TPrimAttributesOptionsForm.File_Print_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAttributesOptionsForm.File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49521D8E0295_4C8647C8024Eexec_var*
var
 l_Preview : IafwDocumentPreview;
//#UC END# *49521D8E0295_4C8647C8024Eexec_var*
begin
//#UC START# *49521D8E0295_4C8647C8024Eexec_impl*
 l_Preview := MakePreview;
 if (l_Preview <> nil) then
  l_Preview.Print;
//#UC END# *49521D8E0295_4C8647C8024Eexec_impl*
end;//TPrimAttributesOptionsForm.File_Print_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAttributesOptionsForm.File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495220DE0298_4C8647C8024Etest_var*
//#UC END# *495220DE0298_4C8647C8024Etest_var*
begin
//#UC START# *495220DE0298_4C8647C8024Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := {not DefDataAdapter.IsTrialMode and }HasTree;
//#UC END# *495220DE0298_4C8647C8024Etest_impl*
end;//TPrimAttributesOptionsForm.File_PrintDialog_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAttributesOptionsForm.File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495220DE0298_4C8647C8024Eexec_var*
//#UC END# *495220DE0298_4C8647C8024Eexec_var*
begin
//#UC START# *495220DE0298_4C8647C8024Eexec_impl*
 if (afw.Application <> nil) AND (afw.Application.PrintManager <> nil) then
  afw.Application.PrintManager.PrintDialog(MakePreview);
//#UC END# *495220DE0298_4C8647C8024Eexec_impl*
end;//TPrimAttributesOptionsForm.File_PrintDialog_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAttributesOptionsForm.File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495220F2033A_4C8647C8024Etest_var*
//#UC END# *495220F2033A_4C8647C8024Etest_var*
begin
//#UC START# *495220F2033A_4C8647C8024Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := {not DefDataAdapter.IsTrialMode and} (Printer.Printers.Count > 0) AND HasTree;
//#UC END# *495220F2033A_4C8647C8024Etest_impl*
end;//TPrimAttributesOptionsForm.File_PrintPreview_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAttributesOptionsForm.File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495220F2033A_4C8647C8024Eexec_var*
//#UC END# *495220F2033A_4C8647C8024Eexec_var*
begin
//#UC START# *495220F2033A_4C8647C8024Eexec_impl*
 TdmStdRes.MakePreview(MakePreview);
//#UC END# *495220F2033A_4C8647C8024Eexec_impl*
end;//TPrimAttributesOptionsForm.File_PrintPreview_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAttributesOptionsForm.Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7D0C7B0185_4C8647C8024Etest_var*
//#UC END# *4C7D0C7B0185_4C8647C8024Etest_var*
begin
//#UC START# *4C7D0C7B0185_4C8647C8024Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := {not DefDataAdapter.IsTrialMode and} (tvAttributes.Current > -1);
//#UC END# *4C7D0C7B0185_4C8647C8024Etest_impl*
end;//TPrimAttributesOptionsForm.Edit_Copy_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAttributesOptionsForm.Edit_Copy_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4C7D0C7B0185_4C8647C8024Egetstate_var*
//#UC END# *4C7D0C7B0185_4C8647C8024Egetstate_var*
begin
//#UC START# *4C7D0C7B0185_4C8647C8024Egetstate_impl*
 State := st_user_Edit_Copy_AttributesCopy;
//#UC END# *4C7D0C7B0185_4C8647C8024Egetstate_impl*
end;//TPrimAttributesOptionsForm.Edit_Copy_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAttributesOptionsForm.Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7D0C7B0185_4C8647C8024Eexec_var*
var
 l_Flag : Word;
 l_Tree : Il3SimpleTree;
//#UC END# *4C7D0C7B0185_4C8647C8024Eexec_var*
begin
//#UC START# *4C7D0C7B0185_4C8647C8024Eexec_impl*
 l_Tree := tvAttributes.TreeStruct;
 if (l_Tree.SelectCount > 1) then
  l_Flag := FM_SELECTION
 else
  l_Flag := 0;
 l3System.SetClipboardData(TevTreeDataObject.Make(TevTreeStorableData_C(l_Tree, l_Flag)));
//#UC END# *4C7D0C7B0185_4C8647C8024Eexec_impl*
end;//TPrimAttributesOptionsForm.Edit_Copy_Execute
{$IfEnd} //not NoVCM

procedure TPrimAttributesOptionsForm.Attribute_Copy_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C864A87020E_4C8647C8024Etest_var*
//#UC END# *4C864A87020E_4C8647C8024Etest_var*
begin
//#UC START# *4C864A87020E_4C8647C8024Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := tvAttributes.Current > -1;
//#UC END# *4C864A87020E_4C8647C8024Etest_impl*
end;//TPrimAttributesOptionsForm.Attribute_Copy_Test

procedure TPrimAttributesOptionsForm.Attribute_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C864A87020E_4C8647C8024Eexec_var*
//#UC END# *4C864A87020E_4C8647C8024Eexec_var*
begin
//#UC START# *4C864A87020E_4C8647C8024Eexec_impl*
 l3System.SetClipboardData(TnsSingleAttributeData.Make(tvAttributes.GetCurrentNode, nil));
//#UC END# *4C864A87020E_4C8647C8024Eexec_impl*
end;//TPrimAttributesOptionsForm.Attribute_Copy_Execute

{$If not defined(NoVCM)}
procedure TPrimAttributesOptionsForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_4C8647C8024E_var*
//#UC END# *497469C90140_4C8647C8024E_var*
begin
//#UC START# *497469C90140_4C8647C8024E_impl*
 inherited;
 if Assigned(CoDS) and not Dispatcher.History.InBF then
  tvAttributes.TreeStruct := nil;
//#UC END# *497469C90140_4C8647C8024E_impl*
end;//TPrimAttributesOptionsForm.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAttributesOptionsForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_4C8647C8024E_var*
//#UC END# *49803F5503AA_4C8647C8024E_var*
begin
//#UC START# *49803F5503AA_4C8647C8024E_impl*
 inherited;
 tvAttributes.Images := nsDocumentRes.DocumentItemsImageList;
//#UC END# *49803F5503AA_4C8647C8024E_impl*
end;//TPrimAttributesOptionsForm.DoInit
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAttributesOptionsForm.InitControls;
//#UC START# *4A8E8F2E0195_4C8647C8024E_var*
//#UC END# *4A8E8F2E0195_4C8647C8024E_var*
begin
//#UC START# *4A8E8F2E0195_4C8647C8024E_impl*
 with tvAttributes do
 begin
  Align := alClient;
  BorderStyle := bsNone;
  MultiSelect := True;
  MultiStrokeItem := True;
  ViewOptions := [voShowInterRowSpace, voShowIcons, voShowExpandable, voShowLines, voShowOpenChip];
  OnMakeTreeSource := tvAttributesMakeTreeSource;
  OnGetItemImage := tvAttributesGetItemImage;
  SettingId := 'stidAttributeTree';
 end;
//#UC END# *4A8E8F2E0195_4C8647C8024E_impl*
end;//TPrimAttributesOptionsForm.InitControls
{$IfEnd} //not NoVCM

procedure TPrimAttributesOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_File, nil);
  PublishFormEntity(en_Attribute, nil);
  ContextMenuWeight(en_File, 10);
  ContextMenuWeight(en_Edit, 20);
  ContextMenuWeight(en_Attribute, 30);
  ContextMenuWeight(en_Tree, 40);
  {$If not defined(NoVCM)}
  PublishOp(en_File, op_Print, File_Print_Execute, File_Print_Test, nil);
  ShowInContextMenu(en_File, op_Print, true);
  ShowInToolbar(en_File, op_Print, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_PrintDialog, File_PrintDialog_Execute, File_PrintDialog_Test, nil);
  ShowInContextMenu(en_File, op_PrintDialog, false);
  ShowInToolbar(en_File, op_PrintDialog, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_PrintPreview, File_PrintPreview_Execute, File_PrintPreview_Test, nil);
  ShowInContextMenu(en_File, op_PrintPreview, true);
  ShowInToolbar(en_File, op_PrintPreview, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Copy, Edit_Copy_Execute, Edit_Copy_Test, Edit_Copy_GetState);
  ShowInContextMenu(en_Edit, op_Copy, true);
  ShowInToolbar(en_Edit, op_Copy, true);
  {$IfEnd} //not NoVCM

  PublishOp(en_Attribute, op_Copy, Attribute_Copy_Execute, Attribute_Copy_Test, nil);
  ShowInContextMenu(en_Attribute, op_Copy, true);
  ShowInToolbar(en_Attribute, op_Copy, false);
 end;//with Entities.Entities
end;

procedure TPrimAttributesOptionsForm.MakeControls;
begin
 inherited;
 tvAttributes.Parent := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimAttributesOptions
 TtfwClassRef.Register(TPrimAttributesOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.