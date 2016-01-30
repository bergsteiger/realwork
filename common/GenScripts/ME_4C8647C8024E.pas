unit PrimAttributesOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimAttributesOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

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
  public
   {$If NOT Defined(NoVCM)}
   procedure Print; override;
    {* Печать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintDialog; override;
    {* Печать... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintPreview; override;
    {* Предварительный просмотр }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Copy; override;
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Copy; override;
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
procedure TPrimAttributesOptionsForm.Print;
 {* Печать }
//#UC START# *49521D8E0295_4C8647C8024E_var*
//#UC END# *49521D8E0295_4C8647C8024E_var*
begin
//#UC START# *49521D8E0295_4C8647C8024E_impl*
 !!! Needs to be implemented !!!
//#UC END# *49521D8E0295_4C8647C8024E_impl*
end;//TPrimAttributesOptionsForm.Print
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesOptionsForm.PrintDialog;
 {* Печать... }
//#UC START# *495220DE0298_4C8647C8024E_var*
//#UC END# *495220DE0298_4C8647C8024E_var*
begin
//#UC START# *495220DE0298_4C8647C8024E_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220DE0298_4C8647C8024E_impl*
end;//TPrimAttributesOptionsForm.PrintDialog
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesOptionsForm.PrintPreview;
 {* Предварительный просмотр }
//#UC START# *495220F2033A_4C8647C8024E_var*
//#UC END# *495220F2033A_4C8647C8024E_var*
begin
//#UC START# *495220F2033A_4C8647C8024E_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220F2033A_4C8647C8024E_impl*
end;//TPrimAttributesOptionsForm.PrintPreview
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesOptionsForm.Copy;
 {* Копировать }
//#UC START# *4C7D0C7B0185_4C8647C8024E_var*
//#UC END# *4C7D0C7B0185_4C8647C8024E_var*
begin
//#UC START# *4C7D0C7B0185_4C8647C8024E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0C7B0185_4C8647C8024E_impl*
end;//TPrimAttributesOptionsForm.Copy
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimAttributesOptionsForm.Copy;
//#UC START# *4C864A87020E_4C8647C8024E_var*
//#UC END# *4C864A87020E_4C8647C8024E_var*
begin
//#UC START# *4C864A87020E_4C8647C8024E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C864A87020E_4C8647C8024E_impl*
end;//TPrimAttributesOptionsForm.Copy

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

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimAttributesOptionsForm);
 {* Регистрация PrimAttributesOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
