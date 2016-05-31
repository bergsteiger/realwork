unit PrimStyleEditorNavigator_Form;
 {* Дерево стилей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorNavigator_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimStyleEditorNavigator" MUID: (4AE8247501DA)
// Имя типа: "TPrimStyleEditorNavigatorForm"

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
 , eeInterfaces
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 WM_AFTERINSERT = WM_USER  + 111;

type
 TPrimStyleEditorNavigatorForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Дерево стилей }
  private
   f_StyleTreeView: TnscTreeViewWithAdapterDragDrop;
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
   procedure WMAfterInsert(var aMsg: TMessage); message WM_AFTERINSERT;
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FormInsertedIntoContainer; override;
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
   procedure StyleEditor_ReloadStylesTree_Execute(const aStyleName: Il3CString);
    {* ReloadStylesTree }
   procedure StyleEditor_ReloadStylesTree(const aParams: IvcmExecuteParams);
    {* ReloadStylesTree }
   procedure StyleEditor_ReloadStyleTable_Execute;
   procedure StyleEditor_ReloadStyleTable(const aParams: IvcmExecuteParams);
  public
   property StyleTreeView: TnscTreeViewWithAdapterDragDrop
    read f_StyleTreeView;
 end;//TPrimStyleEditorNavigatorForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
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
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimStyleEditorNavigator_utStyleEditorNavigator_UserType
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4AE8247501DAimpl_uses*
 , eeTreeViewExport
 , eeTreeView
 , l3ControlsTypes
 //#UC END# *4AE8247501DAimpl_uses*
;

{$If NOT Defined(NoVCM)}
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

procedure TPrimStyleEditorNavigatorForm.StyleEditor_ReloadStylesTree_Execute(const aStyleName: Il3CString);
 {* ReloadStylesTree }
//#UC START# *4AE8250D03D5_4AE8247501DAexec_var*
 function lp_IsInArray(const aArray: array of Integer; aValue: Integer): Boolean;
 var
  l_Index: Integer;
 begin
  Result := False;
  for l_Index := Low(aArray) to High(aArray) do
  begin
   Result := aArray[l_Index] = aValue;
   if Result then
    Exit;
  end;
 end;//lp_IsInArray

 function lp_CorrectStylesArray(const anArray: TLongArray): TLongArray;
 var
  l_Index: Integer;
  l_IsEnglish: Boolean;
 begin
  l_IsEnglish := afw.Application.LocaleInfo.Language <> afw_lngRussian;
  SetLength(Result, 0);
  for l_Index := Low(anArray) to High(anArray) do
   // Исключаем стили, которых не должно быть в английской версии
   //http://mdp.garant.ru/pages/viewpage.action?pageId=421127387
   if (not l_IsEnglish) or (not lp_IsInArray([ev_saHeaderAACLeftWindow, ev_saHeaderAACRightWindow,
    ev_saTxtNormalAACSeeAlso], anArray[l_Index])) then
   begin
    SetLength(Result, Succ(Length(Result)));
    Result[High(Result)] := anArray[l_Index];
   end;
 end;//lp_CorrectStylesArray

var
 l_Node: Il3Node;
 l_Root: IeeNode;
 l_Current: Integer;
 l_RootChanged: TeeRootChangedEvent;
 l_CurrentChanged: TeeCurrentChanged;
 l_Styles: array of Integer;
 l_ResultStyles: TLongArray;
 l_IDX: Integer;
//#UC END# *4AE8250D03D5_4AE8247501DAexec_var*
begin
//#UC START# *4AE8250D03D5_4AE8247501DAexec_impl*
 with TevStyleInterface.Make do
  try
   with f_StyleTreeView do
    with TreeView do
    begin
     l_RootChanged := OnRootChanged;
     try
      OnRootChanged := nil;
      //
      with Tree do
      begin
       l_Root := Root;
       try
        l_CurrentChanged := OnCurrentChanged;
        try
         OnCurrentChanged := nil;
         //
         SetLength(l_Styles, 0);
         SetLength(l_ResultStyles, 0);
         //
         //Во внутренней версии нужно показывать все стили
         //http://mdp.garant.ru/pages/viewpage.action?pageId=485427672 
         if (not afw.Application.IsInternal) then
         begin
          for l_Idx := Low(VisibleStyleTable) to High (VisibleStyleTable) do
           if VisibleStyleTable[l_IDX].ForAll or afw.Application.IsInternal then
           begin
            SetLength(l_Styles, Length(l_Styles) + 1);
            l_Styles[High(l_Styles)] := VisibleStyleTable[l_IDX].ID;
           end;//VisibleStyleTable[l_IDX].ForAll or afw.Application.IsInternal
          l_ResultStyles := l3CatLongArray(l_Styles, [ev_saInterface,
                                           ev_saHeaderForChangesInfo,
                                           ev_saFooterForChangesInfo,
                                           ev_saTextForChangesInfo,
                                           ev_saSubHeaderForChangesInfo,
                                           ev_saChangesInfo,
                                           ev_saDialogs,
                                           ev_saEnclosureHeader,
                                           ev_saEditionInterval,
                                           ev_saEdition,
                                           ev_saEditionNumber,
                                           ev_saNodeGroupHeader,
                                           ev_saTOC,
                                           ev_saWriteToUs,
                                           ev_saHeaderAACLeftWindow,
                                           ev_saHeaderAACRightWindow,
                                           ev_saTxtNormalAACSeeAlso,
                                           ev_saSnippet,
                                           ev_saAbolishedDocumentLink,
                                           ev_saVisitedDocumentInList
                                           {,
                                           ev_saContextAACRightWindows}
                                          ]);
         end;//if (not afw.Application.IsInternal)
         // http://mdp.garant.ru/pages/viewpage.action?pageId=421127387
         Root := TeeNode.Make(MakeStylesTreeRoot(lp_CorrectStylesArray(l_ResultStyles)));
         ExpandAll;
        finally
         OnCurrentChanged := l_CurrentChanged;
        end;//try..finally
        //
        l_Node := l3SearchByName(Root as Il3Node, aStyleName);
        if (l_Node <> nil) then
         try
          l_Current := Current;
          if (GotoNode(TeeNode.Make(l_Node)) <> -1) then
          begin
           if (l_Current = Current) then
            SendToAggregateSetNewContentNotify(GetStyleIdFromTreeByIndex(l_Current));
           Exit;
          end;
         finally
          l_Node := nil;
         end;
        //
        if Assigned(l_RootChanged) then
         l_RootChanged(Self, l_Root, Root);
       finally
        l_Root := nil;
       end;
      end;
     finally
      OnRootChanged := l_RootChanged;
     end;
    end;
  finally
   Free;
  end;
//#UC END# *4AE8250D03D5_4AE8247501DAexec_impl*
end;//TPrimStyleEditorNavigatorForm.StyleEditor_ReloadStylesTree_Execute

procedure TPrimStyleEditorNavigatorForm.StyleEditor_ReloadStylesTree(const aParams: IvcmExecuteParams);
 {* ReloadStylesTree }
begin
 with (aParams.Data As IStyleEditor_ReloadStylesTree_Params) do
  Self.StyleEditor_ReloadStylesTree_Execute(StyleName);
end;//TPrimStyleEditorNavigatorForm.StyleEditor_ReloadStylesTree

procedure TPrimStyleEditorNavigatorForm.StyleEditor_ReloadStyleTable_Execute;
//#UC START# *4AF8660E0079_4AE8247501DAexec_var*
var
 l_StyleTableSpy: IafwStyleTableSpy;
//#UC END# *4AF8660E0079_4AE8247501DAexec_var*
begin
//#UC START# *4AF8660E0079_4AE8247501DAexec_impl*
 if Supports(f_StyleTreeView, IafwStyleTableSpy, l_StyleTableSpy) then
  try
   l_StyleTableSpy.StyleTableChanged;
  finally
   l_StyleTableSpy := nil;
  end;
//#UC END# *4AF8660E0079_4AE8247501DAexec_impl*
end;//TPrimStyleEditorNavigatorForm.StyleEditor_ReloadStyleTable_Execute

procedure TPrimStyleEditorNavigatorForm.StyleEditor_ReloadStyleTable(const aParams: IvcmExecuteParams);
begin
 Self.StyleEditor_ReloadStyleTable_Execute;
end;//TPrimStyleEditorNavigatorForm.StyleEditor_ReloadStyleTable

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

procedure TPrimStyleEditorNavigatorForm.FormInsertedIntoContainer;
//#UC START# *4F7C65380244_4AE8247501DA_var*
//#UC END# *4F7C65380244_4AE8247501DA_var*
begin
//#UC START# *4F7C65380244_4AE8247501DA_impl*
 PostMessage(Handle, WM_AFTERINSERT, 0, 0);
//#UC END# *4F7C65380244_4AE8247501DA_impl*
end;//TPrimStyleEditorNavigatorForm.FormInsertedIntoContainer

procedure TPrimStyleEditorNavigatorForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_StyleEditor, nil);
  PublishOpWithResult(en_StyleEditor, op_ReloadStylesTree, StyleEditor_ReloadStylesTree, nil, nil);
  PublishOpWithResult(en_StyleEditor, op_ReloadStyleTable, StyleEditor_ReloadStyleTable, nil, nil);
 end;//with Entities.Entities
end;//TPrimStyleEditorNavigatorForm.InitEntities

procedure TPrimStyleEditorNavigatorForm.MakeControls;
begin
 inherited;
 with AddUsertype(utStyleEditorNavigatorName,
  str_utStyleEditorNavigatorCaption,
  str_utStyleEditorNavigatorSettingsCaption,
  True,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utStyleEditorNavigatorName
 f_StyleTreeView := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_StyleTreeView.Name := 'StyleTreeView';
 f_StyleTreeView.Parent := Self;
end;//TPrimStyleEditorNavigatorForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimStyleEditorNavigatorForm);
 {* Регистрация PrimStyleEditorNavigator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
