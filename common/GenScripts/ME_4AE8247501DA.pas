unit PrimStyleEditorNavigator_Form;
 {* Дерево стилей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorNavigator_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , Settings_Strange_Controls
 , nscTreeViewWithAdapterDragDrop
 , Messages
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , eeInterfaces
;

const
 WM_AFTERINSERT = WM_USER  + 111;

type
 TPrimStyleEditorNavigatorForm = class(TvcmEntityForm)
  {* Дерево стилей }
  private
   f_StyleTreeView: TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства StyleTreeView }
  private
   function StyleTreeViewGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure StyleTreeViewCurrentChanged(aSender: TObject;
    aNewCurrent: Integer;
    aOldCurrent: Integer);
   procedure StyleTreeViewRootChanged(aSender: TObject;
    const anOldRoot: IeeNode;
    const aNewRoot: IeeNode);
   function GetStyleIdFromTreeByIndex(aIndex: Integer): Integer;
   procedure SendToAggregateSetNewContentNotify(aStyleId: Integer);
   function GetStyleIdFromNode(const aNode: IeeNode): Integer;
   procedure WMAfterInsert(var aMsg: TMessage);
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FormInsertedIntoContainer; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure ReloadStylesTree; override;
    {* ReloadStylesTree }
   procedure ReloadStyleTable; override;
  public
   property StyleTreeView: TnscTreeViewWithAdapterDragDrop
    read f_StyleTreeView;
 end;//TPrimStyleEditorNavigatorForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , evStyleInterface
 , eeNode
 , l3Nodes
 , nsStyleEditor
 , l3Tree_TLB
 , afwFacade
 , SysUtils
 , afwInterfaces
 , l3Base
 , evdStyles
 , l3Types
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Windows
 , StyleTableRes
 , l3TreeInterfaces
 , evdTextStyle_Const
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки utStyleEditorNavigatorLocalConstants }
 str_utStyleEditorNavigatorCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utStyleEditorNavigatorCaption'; rValue : 'Дерево стилей');
  {* Заголовок пользовательского типа "Дерево стилей" }
 str_utStyleEditorNavigatorSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utStyleEditorNavigatorSettingsCaption'; rValue : 'Дерево стилей');
  {* Заголовок пользовательского типа "Дерево стилей" для настройки панелей инструментов }

function TPrimStyleEditorNavigatorForm.StyleTreeViewGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *527214490340_4AE8247501DA_var*
//#UC END# *527214490340_4AE8247501DA_var*
begin
//#UC START# *527214490340_4AE8247501DA_impl*
 with TevStyleInterface.Make do
 try
  SelectStyle(GetStyleIdFromTreeByIndex(Index));
  if Apply2Para then
   Result := CParagraphImageIndex
  else
   Result := CSelectionImageIndex;
 finally
  Free;
 end;
//#UC END# *527214490340_4AE8247501DA_impl*
end;//TPrimStyleEditorNavigatorForm.StyleTreeViewGetItemImage

procedure TPrimStyleEditorNavigatorForm.StyleTreeViewCurrentChanged(aSender: TObject;
 aNewCurrent: Integer;
 aOldCurrent: Integer);
//#UC START# *527214520382_4AE8247501DA_var*
//#UC END# *527214520382_4AE8247501DA_var*
begin
//#UC START# *527214520382_4AE8247501DA_impl*
 if aNewCurrent <> -1 then
  SendToAggregateSetNewContentNotify(GetStyleIdFromTreeByIndex(aNewCurrent));
//#UC END# *527214520382_4AE8247501DA_impl*
end;//TPrimStyleEditorNavigatorForm.StyleTreeViewCurrentChanged

procedure TPrimStyleEditorNavigatorForm.StyleTreeViewRootChanged(aSender: TObject;
 const anOldRoot: IeeNode;
 const aNewRoot: IeeNode);
//#UC START# *5272145F0183_4AE8247501DA_var*
//#UC END# *5272145F0183_4AE8247501DA_var*
begin
//#UC START# *5272145F0183_4AE8247501DA_impl*
 if (aNewRoot <> nil) then
  with aNewRoot do
   if HasChild then
    SendToAggregateSetNewContentNotify(GetStyleIdFromNode(ChildNode));
//#UC END# *5272145F0183_4AE8247501DA_impl*
end;//TPrimStyleEditorNavigatorForm.StyleTreeViewRootChanged

function TPrimStyleEditorNavigatorForm.GetStyleIdFromTreeByIndex(aIndex: Integer): Integer;
//#UC START# *52721E5102E7_4AE8247501DA_var*
//#UC END# *52721E5102E7_4AE8247501DA_var*
begin
//#UC START# *52721E5102E7_4AE8247501DA_impl*
 with f_StyleTreeView.TreeView do
  Result := GetStyleIdFromNode(GetNode(aIndex));
//#UC END# *52721E5102E7_4AE8247501DA_impl*
end;//TPrimStyleEditorNavigatorForm.GetStyleIdFromTreeByIndex

procedure TPrimStyleEditorNavigatorForm.SendToAggregateSetNewContentNotify(aStyleId: Integer);
//#UC START# *52721E70013B_4AE8247501DA_var*
//#UC END# *52721E70013B_4AE8247501DA_var*
begin
//#UC START# *52721E70013B_4AE8247501DA_impl*
 op_StyleEditor_SetNewContent.Call(Aggregate, aStyleId);
//#UC END# *52721E70013B_4AE8247501DA_impl*
end;//TPrimStyleEditorNavigatorForm.SendToAggregateSetNewContentNotify

function TPrimStyleEditorNavigatorForm.GetStyleIdFromNode(const aNode: IeeNode): Integer;
//#UC START# *52721E8E00BF_4AE8247501DA_var*
//#UC END# *52721E8E00BF_4AE8247501DA_var*
begin
//#UC START# *52721E8E00BF_4AE8247501DA_impl*
 Result := -1;
 if (aNode <> nil) then
  with aNode as Il3HandleNode do
   Result := Integer(Handle)
 else
  Abort;
//#UC END# *52721E8E00BF_4AE8247501DA_impl*
end;//TPrimStyleEditorNavigatorForm.GetStyleIdFromNode

procedure TPrimStyleEditorNavigatorForm.WMAfterInsert(var aMsg: TMessage);
//#UC START# *52724A1F0013_4AE8247501DA_var*
//#UC END# *52724A1F0013_4AE8247501DA_var*
begin
//#UC START# *52724A1F0013_4AE8247501DA_impl*
 Windows.SetFocus(f_StyleTreeView.Handle);
 StyleTreeViewCurrentChanged(f_StyleTreeView, f_StyleTreeView.Current, f_StyleTreeView.Current); 
//#UC END# *52724A1F0013_4AE8247501DA_impl*
end;//TPrimStyleEditorNavigatorForm.WMAfterInsert

procedure TPrimStyleEditorNavigatorForm.ReloadStylesTree;
 {* ReloadStylesTree }
//#UC START# *4AE8250D03D5_4AE8247501DA_var*
//#UC END# *4AE8250D03D5_4AE8247501DA_var*
begin
//#UC START# *4AE8250D03D5_4AE8247501DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE8250D03D5_4AE8247501DA_impl*
end;//TPrimStyleEditorNavigatorForm.ReloadStylesTree

procedure TPrimStyleEditorNavigatorForm.ReloadStyleTable;
//#UC START# *4AF8660E0079_4AE8247501DA_var*
//#UC END# *4AF8660E0079_4AE8247501DA_var*
begin
//#UC START# *4AF8660E0079_4AE8247501DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF8660E0079_4AE8247501DA_impl*
end;//TPrimStyleEditorNavigatorForm.ReloadStyleTable

procedure TPrimStyleEditorNavigatorForm.InitFields;
//#UC START# *47A042E100E2_4AE8247501DA_var*
//#UC END# *47A042E100E2_4AE8247501DA_var*
begin
//#UC START# *47A042E100E2_4AE8247501DA_impl*
 inherited;

 f_StyleTreeView.Images := nsStyleTableRes.StyleTreeImageList;
 op_StyleEditor_ReloadStylesTree.Call(Self.As_IvcmEntityForm, nil);
 
 ActiveControl := f_StyleTreeView;
 Anchors := [];
 BorderIcons := [];
//#UC END# *47A042E100E2_4AE8247501DA_impl*
end;//TPrimStyleEditorNavigatorForm.InitFields

{$If NOT Defined(NoVCM)}
procedure TPrimStyleEditorNavigatorForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4AE8247501DA_var*
//#UC END# *4A8E8F2E0195_4AE8247501DA_var*
begin
//#UC START# *4A8E8F2E0195_4AE8247501DA_impl*
 inherited;
 
 with f_StyleTreeView do
 begin
  Align := alClient;
  ShowHeader := False;
  PickedList := False;
  MultiSelect := False;
  MultiStrokeItem := False;
  ActionElementMode := l3_amDoubleClick;
  StyleId := evd_saInterface;
  AllowWithoutCurrent := False;
  OnGetItemImage := StyleTreeViewGetItemImage;
  OnCurrentChanged := StyleTreeViewCurrentChanged;
  OnRootChanged := StyleTreeViewRootChanged;
  FooterVisible := False;
  FooterStyleID := evd_saHyperLink;
  FooterActiveStyleID := evd_saActiveHyperLink;
  SettingId := 'stidStyleTreeView';
 end;
//#UC END# *4A8E8F2E0195_4AE8247501DA_impl*
end;//TPrimStyleEditorNavigatorForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimStyleEditorNavigatorForm.FormInsertedIntoContainer;
//#UC START# *4F7C65380244_4AE8247501DA_var*
//#UC END# *4F7C65380244_4AE8247501DA_var*
begin
//#UC START# *4F7C65380244_4AE8247501DA_impl*
 PostMessage(Handle, WM_AFTERINSERT, 0, 0);
//#UC END# *4F7C65380244_4AE8247501DA_impl*
end;//TPrimStyleEditorNavigatorForm.FormInsertedIntoContainer
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_utStyleEditorNavigatorCaption.Init;
 {* Инициализация str_utStyleEditorNavigatorCaption }
 str_utStyleEditorNavigatorSettingsCaption.Init;
 {* Инициализация str_utStyleEditorNavigatorSettingsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimStyleEditorNavigatorForm);
 {* Регистрация PrimStyleEditorNavigator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
