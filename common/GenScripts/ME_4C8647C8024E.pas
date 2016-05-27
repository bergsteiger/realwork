unit PrimAttributesOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimAttributesOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimAttributesOptions" MUID: (4C8647C8024E)
// Имя типа: "TPrimAttributesOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimAttributes_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Document_Strange_Controls
 , afwInterfaces
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3TreeInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , nscTreeViewWithAdapterDragDrop
;

type
 TPrimAttributesOptionsForm = class(TPrimAttributesForm)
  protected
   function MakePreview: IafwDocumentPreview;
   function HasTree: Boolean;
   function tvAttributesGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure tvAttributesMakeTreeSource(out theTree: Il3SimpleTree);
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
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
   procedure File_Print_Test(const aParams: IvcmTestParamsPrim);
    {* Печать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Печать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
    {* Печать... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Печать... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
    {* Предварительный просмотр }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Предварительный просмотр }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Copy_GetState(var State: TvcmOperationStateIndex);
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Attribute_Copy_Test(const aParams: IvcmTestParamsPrim);
   procedure Attribute_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
 end;//TPrimAttributesOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , afwFacade
 , l3Base
 , evTreeDataObject
 , evTreeStorable
 , nsSingleAttributeData
 , DynamicTreeUnit
 , Printers
 , DocumentRes
 , eeInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3ControlsTypes
 , nsDocumentPreview
 , nsHAFPainter
 , evFormatHAFMacroReplacer
 , nsDocInfoHAFMacroReplacer
 , nevBase
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , DataAdapter
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

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

function TPrimAttributesOptionsForm.tvAttributesGetItemImage(Sender: TObject;
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
end;//TPrimAttributesOptionsForm.tvAttributesGetItemImage

procedure TPrimAttributesOptionsForm.tvAttributesMakeTreeSource(out theTree: Il3SimpleTree);
//#UC START# *511A3D5D01FA_4C8647C8024E_var*
//#UC END# *511A3D5D01FA_4C8647C8024E_var*
begin
//#UC START# *511A3D5D01FA_4C8647C8024E_impl*
 if Assigned(CoDS) then
  theTree := CoDS.SimpleTree;
//#UC END# *511A3D5D01FA_4C8647C8024E_impl*
end;//TPrimAttributesOptionsForm.tvAttributesMakeTreeSource

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesOptionsForm.File_Print_Test(const aParams: IvcmTestParamsPrim);
 {* Печать }
//#UC START# *49521D8E0295_4C8647C8024Etest_var*
//#UC END# *49521D8E0295_4C8647C8024Etest_var*
begin
//#UC START# *49521D8E0295_4C8647C8024Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := {not DefDataAdapter.IsTrialMode and }HasTree;
//#UC END# *49521D8E0295_4C8647C8024Etest_impl*
end;//TPrimAttributesOptionsForm.File_Print_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesOptionsForm.File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Печать }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesOptionsForm.File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
 {* Печать... }
//#UC START# *495220DE0298_4C8647C8024Etest_var*
//#UC END# *495220DE0298_4C8647C8024Etest_var*
begin
//#UC START# *495220DE0298_4C8647C8024Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := {not DefDataAdapter.IsTrialMode and }HasTree;
//#UC END# *495220DE0298_4C8647C8024Etest_impl*
end;//TPrimAttributesOptionsForm.File_PrintDialog_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesOptionsForm.File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Печать... }
//#UC START# *495220DE0298_4C8647C8024Eexec_var*
//#UC END# *495220DE0298_4C8647C8024Eexec_var*
begin
//#UC START# *495220DE0298_4C8647C8024Eexec_impl*
 if (afw.Application <> nil) AND (afw.Application.PrintManager <> nil) then
  afw.Application.PrintManager.PrintDialog(MakePreview);
//#UC END# *495220DE0298_4C8647C8024Eexec_impl*
end;//TPrimAttributesOptionsForm.File_PrintDialog_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesOptionsForm.File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
 {* Предварительный просмотр }
//#UC START# *495220F2033A_4C8647C8024Etest_var*
//#UC END# *495220F2033A_4C8647C8024Etest_var*
begin
//#UC START# *495220F2033A_4C8647C8024Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := {not DefDataAdapter.IsTrialMode and} (Printer.Printers.Count > 0) AND HasTree;
//#UC END# *495220F2033A_4C8647C8024Etest_impl*
end;//TPrimAttributesOptionsForm.File_PrintPreview_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesOptionsForm.File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Предварительный просмотр }
//#UC START# *495220F2033A_4C8647C8024Eexec_var*
//#UC END# *495220F2033A_4C8647C8024Eexec_var*
begin
//#UC START# *495220F2033A_4C8647C8024Eexec_impl*
 TdmStdRes.MakePreview(MakePreview);
//#UC END# *495220F2033A_4C8647C8024Eexec_impl*
end;//TPrimAttributesOptionsForm.File_PrintPreview_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesOptionsForm.Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
 {* Копировать }
//#UC START# *4C7D0C7B0185_4C8647C8024Etest_var*
//#UC END# *4C7D0C7B0185_4C8647C8024Etest_var*
begin
//#UC START# *4C7D0C7B0185_4C8647C8024Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := {not DefDataAdapter.IsTrialMode and} (tvAttributes.Current > -1);
//#UC END# *4C7D0C7B0185_4C8647C8024Etest_impl*
end;//TPrimAttributesOptionsForm.Edit_Copy_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesOptionsForm.Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Копировать }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesOptionsForm.Edit_Copy_GetState(var State: TvcmOperationStateIndex);
 {* Копировать }
//#UC START# *4C7D0C7B0185_4C8647C8024Egetstate_var*
//#UC END# *4C7D0C7B0185_4C8647C8024Egetstate_var*
begin
//#UC START# *4C7D0C7B0185_4C8647C8024Egetstate_impl*
 State := st_user_Edit_Copy_AttributesCopy;
//#UC END# *4C7D0C7B0185_4C8647C8024Egetstate_impl*
end;//TPrimAttributesOptionsForm.Edit_Copy_GetState
{$IfEnd} // NOT Defined(NoVCM)

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

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesOptionsForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_4C8647C8024E_var*
//#UC END# *497469C90140_4C8647C8024E_var*
begin
//#UC START# *497469C90140_4C8647C8024E_impl*
 inherited;
 if Assigned(CoDS) and not Dispatcher.History.InBF then
  tvAttributes.TreeStruct := nil;
//#UC END# *497469C90140_4C8647C8024E_impl*
end;//TPrimAttributesOptionsForm.NotifyDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesOptionsForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4C8647C8024E_var*
//#UC END# *49803F5503AA_4C8647C8024E_var*
begin
//#UC START# *49803F5503AA_4C8647C8024E_impl*
 inherited;
 tvAttributes.Images := nsDocumentRes.DocumentItemsImageList;
//#UC END# *49803F5503AA_4C8647C8024E_impl*
end;//TPrimAttributesOptionsForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesOptionsForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_File, nil);
  PublishFormEntity(en_Attribute, nil);
  PublishOp(en_File, op_Print, File_Print_Execute, File_Print_Test, nil);
  PublishOp(en_File, op_PrintDialog, File_PrintDialog_Execute, File_PrintDialog_Test, nil);
  PublishOp(en_File, op_PrintPreview, File_PrintPreview_Execute, File_PrintPreview_Test, nil);
  PublishOp(en_Edit, op_Copy, Edit_Copy_Execute, Edit_Copy_Test, Edit_Copy_GetState);
  PublishOp(en_Attribute, op_Copy, Attribute_Copy_Execute, Attribute_Copy_Test, nil);
 end;//with Entities.Entities
end;//TPrimAttributesOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesOptionsForm.MakeControls;
begin
 inherited;
 tvAttributes.Parent := Self;
end;//TPrimAttributesOptionsForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimAttributesOptionsForm);
 {* Регистрация PrimAttributesOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
