unit nscDocumentListTreeView;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Components"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Components/nscDocumentListTreeView.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> F1 Базовые определения предметной области::LegalDomain::Components::DocumentListTree::TnscDocumentListTreeView
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  Messages,
  bsTypes,
  nscTreeViewWithAdapterDragDrop
  {$If not defined(Admin) AND not defined(Monitorings)}
  ,
  nscDocumentHistory
  {$IfEnd} //not Admin AND not Monitorings
  ,
  Classes
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  ,
  l3Interfaces,
  Graphics,
  vtLister,
  Types,
  ActiveX,
  vtOutlinerWithDragDrop
  ;

type
 TdltGetNodeTypeEvent = function (anIndex: Integer): TbsListNodeType of object;

 TnscDocumentListTreeView = class(TnscTreeViewWithAdapterDragDrop {$If not defined(Admin) AND not defined(Monitorings)}, InscDocumentHistoryListener{$IfEnd} //not Admin AND not Monitorings
 )
 private
 // private fields
   f_AllSelected : Boolean;
   f_OnGetNodeType : TdltGetNodeTypeEvent;
    {* Поле для свойства OnGetNodeType}
 private
 // private methods
   function IsFirstSnippet(aNodeIndex: Integer): Boolean;
   function IsDocumentWithSnippets(aNodeIndex: Integer): Boolean;
   procedure InternalSetSelected(anItemIndex: Integer;
     aValue: Boolean);
   function GetNextItem(var anItemIndex: Integer): Boolean;
   function GetPrevItem(var anItemIndex: Integer): Boolean;
   procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
   procedure WMRButtonDown(var Msg: TWMRButtonDown); message WM_RBUTTONDOWN;
   procedure WMGetText(var Msg: TWMGetText); message WM_GetText;
   procedure WMGetTextLength(var Msg: TWMGetTextLength); message WM_GETTEXTLENGTH;
 protected
 // realized methods
    {$If not defined(Admin) AND not defined(Monitorings)}
   procedure NewDocumentInHistory;
    {$IfEnd} //not Admin AND not Monitorings
 protected
 // overridden property methods
   procedure pm_SetTopIndex(aValue: LongInt); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   function DoOnGetItemImageIndex(aItemIndex: LongInt;
      var aImages: TCustomImageList): Integer; override;
   procedure DoOnGetItemStyle(aItemIndex: Integer;
      const aFont: Il3Font;
      var aTextBackColor: TColor;
      var aItemBackColor: TColor;
      var aVJustify: TvtVJustify;
      var aFocused: Boolean;
      var theImageVertOffset: Integer); override;
   function CalcTopIndex(aMaxVisItem: LongInt): LongInt; override;
   procedure VlbVScrollPrim(aDelta: Integer); override;
   function VlbItemHitTest(aIndex: Integer;
      const aPt: TPoint;
      fromScreen: Boolean = False): Byte; override;
   procedure DoOnGetItemColor(Index: LongInt;
      var FG: TColor;
      var BG: TColor); override;
   procedure DoOnGetItemFont(Index: LongInt;
      const aFont: Il3Font;
      anItemPart: TvtListerItemPart); override;
   function DoOnIsSelected(Index: LongInt): Integer; override;
   procedure DoOnSelect(Index: LongInt;
      aValue: Integer); override;
   procedure DoOnSelectOutRange(First: LongInt;
      Last: LongInt;
      aSelectState: Integer); override;
   function DoDoProcessCommand(Cmd: Tl3OperationCode): Boolean; override;
   procedure DoCurrentChanged(aNewCurrent: LongInt;
      aOldCurrent: LongInt); override;
   procedure DoValidateCurrent(var aIndex: LongInt); override;
   function DoOnGetItemIndentEx(anItemIndex: Integer): Integer; override;
     {* для каждой ноды можно задать свой "персональный" сдвиг }
   function GetSelectedCountForStatusbar: Integer; override;
   function NeedDrawSelectionOnItem(aItemIndex: Integer): Boolean; override;
   function CanAcceptData(const aData: IDataObject): Boolean; override;
   function GetRealClientWidth: Integer; override;
   function NeedAssignTreeStructFromHistory: Boolean; override;
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
   procedure SelectItems(aFinish: Integer); override;
     {* Создавалась, как ручка для тестов, но немного обобщает логику выделения }
   procedure HitTest(const aPt: TPoint;
      var aIndex: Integer;
      var aItemPart: Byte;
      fromScreen: Boolean = False); override;
   procedure VlbToggleSelection(Index: LongInt); override;
     {* process Ctrl-LMouseBtn }
 protected
 // protected methods
   function GetCurrentText: AnsiString; virtual;
 public
 // public properties
   property OnGetNodeType: TdltGetNodeTypeEvent
     read f_OnGetNodeType
     write f_OnGetNodeType;
 end;//TnscDocumentListTreeView

implementation

uses
  l3ControlsTypes,
  l3TreeInterfaces,
  OvcConst,
  Windows,
  l3Nodes,
  l3MinMax,
  SysUtils,
  l3Base,
  l3String,
  evStyleTableTools,
  l3Units,
  l3ScreenIC,
  evdStyles,
  DynamicDocListUnit,
  DynamicTreeUnit
  {$If not defined(NoScripts)}
  ,
  tfwClassRef
  {$IfEnd} //not NoScripts
  
  ;

// start class TnscDocumentListTreeView

function TnscDocumentListTreeView.IsFirstSnippet(aNodeIndex: Integer): Boolean;
//#UC START# *51DAD23D01ED_51D56E9F004B_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *51DAD23D01ED_51D56E9F004B_var*
begin
//#UC START# *51DAD23D01ED_51D56E9F004B_impl*
 Result := False;
 if aNodeIndex >= 0 then
  if not IsEmpty then
  begin
   l_Node := TreeStruct.Nodes[aNodeIndex];
   if Assigned(l_Node) then
    if l_Node.IsFirst then
     if Assigned(f_OnGetNodeType)
      then Result := f_OnGetNodeType(aNodeIndex) = lntBlock
      else Result := l_Node.GetLevel = 2;
  end;
//#UC END# *51DAD23D01ED_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.IsFirstSnippet

function TnscDocumentListTreeView.IsDocumentWithSnippets(aNodeIndex: Integer): Boolean;
//#UC START# *51DAD2660297_51D56E9F004B_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *51DAD2660297_51D56E9F004B_var*
begin
//#UC START# *51DAD2660297_51D56E9F004B_impl*
 {Result := False;
 if not IsEmpty then
 begin
  l_Node := TreeStruct.Nodes[aNodeIndex];
  Result := Assigned(l_Node) and (l_Node.GetLevel = 1) and l_Node.HasChild;
 end;}
 Result := (aNodeIndex >= 0) and IsFirstSnippet(aNodeIndex + 1);
//#UC END# *51DAD2660297_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.IsDocumentWithSnippets

procedure TnscDocumentListTreeView.InternalSetSelected(anItemIndex: Integer;
  aValue: Boolean);
//#UC START# *51DFB94B03C1_51D56E9F004B_var*
//#UC END# *51DFB94B03C1_51D56E9F004B_var*
begin
//#UC START# *51DFB94B03C1_51D56E9F004B_impl*
 TreeStruct.Select[anItemIndex] := aValue;
 InvalidateItem(anItemIndex);
 if IsDocumentWithSnippets(anItemIndex) then
  InvalidateItem(anItemIndex + 1);
//#UC END# *51DFB94B03C1_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.InternalSetSelected

function TnscDocumentListTreeView.GetNextItem(var anItemIndex: Integer): Boolean;
//#UC START# *51DFB9B50356_51D56E9F004B_var*
var
 l_Node, l_Next: Il3SimpleNode;
//#UC END# *51DFB9B50356_51D56E9F004B_var*
begin
//#UC START# *51DFB9B50356_51D56E9F004B_impl*
 Result := False;
 if IsEmpty or (anItemIndex = f_HighIndex) then
  Exit;

 l_Node := TreeStruct.Nodes[anItemIndex];
 if not Assigned(l_Node) then
  Exit;
  
 if l_Node.HasChild then
  if TreeStruct.IsExpanded(l_Node) then
  begin
   if IsDocumentWithSnippets(anItemIndex) then
    Inc(anItemIndex, 2)
   else
    Inc(anItemIndex, 1);
   Result := (anItemIndex < Total);
   Exit;
  end;

 l_Next := l_Node.Next;
 while Assigned(l_Node) and not Assigned(l_Next) do
 begin
  l_Node := l_Node.Parent;
  if Assigned(l_Node)
   then l_Next := l_Node.Next
   else l_Next := nil;
 end;
 Result := Assigned(l_Next);
 if Result then
  anItemIndex := TreeStruct.GetIndex(l_Next);
//#UC END# *51DFB9B50356_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.GetNextItem

function TnscDocumentListTreeView.GetPrevItem(var anItemIndex: Integer): Boolean;
//#UC START# *51DFBA2F0121_51D56E9F004B_var*
var
 l_Prev, l_Parent: Il3SimpleNode;
//#UC END# *51DFBA2F0121_51D56E9F004B_var*
begin
//#UC START# *51DFBA2F0121_51D56E9F004B_impl*
 Result := False;
 if IsEmpty then
  Exit;

 if anItemIndex = 0 then
  Exit;

 l_Prev := TreeStruct.Nodes[anItemIndex - 1];
 if not Assigned(l_Prev) then
  Exit;

 l_Parent := l_Prev.Parent;
 while Assigned(l_Parent) do
 begin
  if not TreeStruct.IsExpanded(l_Parent) then
   l_Prev := l_Parent;
  l_Parent := l_Parent.Parent; 
 end;

 anItemIndex := TreeStruct.GetIndex(l_Prev);
 if IsFirstSnippet(anItemIndex) then
  Dec(anItemIndex);

 Result := True;
//#UC END# *51DFBA2F0121_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.GetPrevItem

function TnscDocumentListTreeView.GetCurrentText: AnsiString;
//#UC START# *51E01CC7023D_51D56E9F004B_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *51E01CC7023D_51D56E9F004B_var*
begin
//#UC START# *51E01CC7023D_51D56E9F004B_impl*
 // Здесь если просто проверить IsEmpty - получаем весь список СКР к документу
 // при возврате по истории. Может что-то отъехать. 
 // http://mdp.garant.ru/pages/viewpage.action?pageId=476810519
 if IsTreeStructAssigned and (not IsEmpty) then
 begin
  l_Node := TreeStruct.Nodes[Current];
  Result := l3Str(l_Node.Text);
  if IsDocumentWithSnippets(Current) and TreeStruct.IsExpanded(l_Node) then
  begin
   l_Node := l_Node.Child;
   Result := Result + #13#10 + l3Str(l_Node.Text);
  end;
 end else
  Result := '';
//#UC END# *51E01CC7023D_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.GetCurrentText

procedure TnscDocumentListTreeView.WMLButtonDown(var Msg: TWMLButtonDown);
//#UC START# *51D7E45A02DB_51D56E9F004B_var*
//var
// l_Pt: TPoint;
// l_ItemIndex: Integer;
// l_ParentHeight: Integer;
//#UC END# *51D7E45A02DB_51D56E9F004B_var*
begin
//#UC START# *51D7E45A02DB_51D56E9F004B_impl*
// l_Pt := SmallPointToPoint(Msg.Pos);
// l_ItemIndex := ItemAtPos(l_Pt, True);
// if IsFirstSnippet(l_ItemIndex) then // если кликнули в первое вхождение, то надо перенести клик в родительский документ
// begin
//  l_ParentHeight := GetItemDim(l_ItemIndex - 1).Y;
//  repeat                                       // сдвигаем координаты клика вверх шагами, равными высоте родительского документа
//   Msg.Pos.Y := Msg.Pos.Y - l_ParentHeight;    // так точно не промахнёмся
//   l_Pt := SmallPointToPoint(Msg.Pos);
//   Assert(Msg.Pos.Y > 0);
//  until ItemAtPos(l_Pt, True) < l_ItemIndex;
// end;
 inherited;
//#UC END# *51D7E45A02DB_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.WMLButtonDown

procedure TnscDocumentListTreeView.WMRButtonDown(var Msg: TWMRButtonDown);
//#UC START# *51F2344801D4_51D56E9F004B_var*
var
 l_Pt: TPoint;
 l_ItemIndex: Integer;
 l_ParentHeight: Integer;
//#UC END# *51F2344801D4_51D56E9F004B_var*
begin
//#UC START# *51F2344801D4_51D56E9F004B_impl*
 l_Pt := SmallPointToPoint(Msg.Pos);
 l_ItemIndex := ItemAtPos(l_Pt, True);
 if IsFirstSnippet(l_ItemIndex) then // если кликнули в первое вхождение, то надо перенести клик в родительский документ
 begin
  l_ParentHeight := GetItemDim(l_ItemIndex - 1).Y;
  repeat                                       // сдвигаем координаты клика вверх шагами, равными высоте родительского документа
   Msg.Pos.Y := Msg.Pos.Y - l_ParentHeight;    // так точно не промахнёмся
   l_Pt := SmallPointToPoint(Msg.Pos);
   Assert(Msg.Pos.Y > 0);
  until ItemAtPos(l_Pt, True) < l_ItemIndex;
 end;
 inherited;
//#UC END# *51F2344801D4_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.WMRButtonDown

procedure TnscDocumentListTreeView.WMGetText(var Msg: TWMGetText);
//#UC START# *51E00D2000A7_51D56E9F004B_var*
//#UC END# *51E00D2000A7_51D56E9F004B_var*
begin
//#UC START# *51E00D2000A7_51D56E9F004B_impl*
 Msg.Result := StrLen(StrPLCopy(Msg.Text, GetCurrentText, Msg.TextMax - 1));
//#UC END# *51E00D2000A7_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.WMGetText

procedure TnscDocumentListTreeView.WMGetTextLength(var Msg: TWMGetTextLength);
//#UC START# *51E00DAD024C_51D56E9F004B_var*
//#UC END# *51E00DAD024C_51D56E9F004B_var*
begin
//#UC START# *51E00DAD024C_51D56E9F004B_impl*
 Msg.Result := Length(GetCurrentText);
//#UC END# *51E00DAD024C_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.WMGetTextLength

{$If not defined(Admin) AND not defined(Monitorings)}
procedure TnscDocumentListTreeView.NewDocumentInHistory;
//#UC START# *55E6CC91033A_51D56E9F004B_var*
//#UC END# *55E6CC91033A_51D56E9F004B_var*
begin
//#UC START# *55E6CC91033A_51D56E9F004B_impl*
 DropDrawPoints;
//#UC END# *55E6CC91033A_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.NewDocumentInHistory
{$IfEnd} //not Admin AND not Monitorings

procedure TnscDocumentListTreeView.Cleanup;
//#UC START# *479731C50290_51D56E9F004B_var*
//#UC END# *479731C50290_51D56E9F004B_var*
begin
//#UC START# *479731C50290_51D56E9F004B_impl*
 TnscDocumentHistory.Instance.RemoveListener(Self);
 inherited;
//#UC END# *479731C50290_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.Cleanup

procedure TnscDocumentListTreeView.InitFields;
//#UC START# *47A042E100E2_51D56E9F004B_var*
//#UC END# *47A042E100E2_51D56E9F004B_var*
begin
//#UC START# *47A042E100E2_51D56E9F004B_impl*
 inherited;
 TnscDocumentHistory.Instance.AddListener(Self);
//#UC END# *47A042E100E2_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.InitFields

constructor TnscDocumentListTreeView.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_51D56E9F004B_var*
//#UC END# *47D1602000C6_51D56E9F004B_var*
begin
//#UC START# *47D1602000C6_51D56E9F004B_impl*
 inherited;
 ViewOptions := [voShowInterRowSpace,
  voShowIcons,
  voShowExpandable,
  voShowOpenChip,
  voDoNotShowFocusRect,
  voFullLineSelect];
 f_AllSelected := False;
//#UC END# *47D1602000C6_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.Create

function TnscDocumentListTreeView.DoOnGetItemImageIndex(aItemIndex: LongInt;
  var aImages: TCustomImageList): Integer;
//#UC START# *508F81110075_51D56E9F004B_var*
const
 cDisbledSnippetIcon = 11;
//#UC END# *508F81110075_51D56E9F004B_var*
begin
//#UC START# *508F81110075_51D56E9F004B_impl*
 Result := inherited DoOnGetItemImageIndex(aItemIndex, aImages);

 if Selected[aItemIndex] then
  if Assigned(f_OnGetNodeType) then
  begin
   if f_OnGetNodeType(aItemIndex) = lntBlock then
    Result := cDisbledSnippetIcon;
  end else
   Assert(False);
//#UC END# *508F81110075_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.DoOnGetItemImageIndex

procedure TnscDocumentListTreeView.DoOnGetItemStyle(aItemIndex: Integer;
  const aFont: Il3Font;
  var aTextBackColor: TColor;
  var aItemBackColor: TColor;
  var aVJustify: TvtVJustify;
  var aFocused: Boolean;
  var theImageVertOffset: Integer);
//#UC START# *508F825303E4_51D56E9F004B_var*
 function l_IsVisited(const aNode: Il3SimpleNode): Boolean;
 var
  l_DocId: Integer;
  l_NB: INodeBase;
  l_DN: IDynListNode;
 begin
  if Supports(aNode, INodeBase, l_NB) then
   if Supports(l_NB, IDynListNode, l_DN) then
   begin
    l_DocId := l_DN.GetDocumentId;
    if l_DocId <> 0 then
    begin
     Assert(l_DocId >= 100000);
     if TnscDocumentHistory.Instance.HasDocument(l_DN.GetDocumentId - 100000) then
     begin
      Result := True;
      Exit;
     end;
    end;
   end;
  Result := False;
 end;
var
 l_Color: TColor;
 l_Node: Il3SimpleNode;
//#UC END# *508F825303E4_51D56E9F004B_var*
begin
//#UC START# *508F825303E4_51D56E9F004B_impl*
 if IsFirstSnippet(aItemIndex) then
  inherited DoOnGetItemStyle(aItemIndex - 1, aFont, aTextBackColor, aItemBackColor, aVJustify, aFocused, theImageVertOffset)
 else
  inherited DoOnGetItemStyle(aItemIndex, aFont, aTextBackColor, aItemBackColor, aVJustify, aFocused, theImageVertOffset);
 if Assigned(TreeStruct.Nodes[aItemIndex]) then
  if (not IsEmpty) then
  begin
   l_Color := aFont.ForeColor;
   try
    l_Node := TreeStruct.Nodes[aItemIndex];
    if (l_Node.GetLevel > 1) then
     if l_IsVisited(l_Node) then
      evGetStyleFont(aFont, ev_saVisitedSnippetInList)
     else
      evGetStyleFont(aFont, ev_saSnippet)
    else
    if l_IsVisited(l_Node) then
     evGetStyleFont(aFont, ev_saVisitedDocumentInList);
   finally
    if aFocused then
     aFont.ForeColor := l_Color;
   end;
  end;
//#UC END# *508F825303E4_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.DoOnGetItemStyle

procedure TnscDocumentListTreeView.pm_SetTopIndex(aValue: LongInt);
//#UC START# *515058D60074_51D56E9F004Bset_var*
//#UC END# *515058D60074_51D56E9F004Bset_var*
begin
//#UC START# *515058D60074_51D56E9F004Bset_impl*
 if IsFirstSnippet(aValue)
  then inherited pm_SetTopIndex(aValue + 1)
  else inherited pm_SetTopIndex(aValue);
//#UC END# *515058D60074_51D56E9F004Bset_impl*
end;//TnscDocumentListTreeView.pm_SetTopIndex

function TnscDocumentListTreeView.CalcTopIndex(aMaxVisItem: LongInt): LongInt;
//#UC START# *5151B2C70248_51D56E9F004B_var*
//#UC END# *5151B2C70248_51D56E9F004B_var*
begin
//#UC START# *5151B2C70248_51D56E9F004B_impl*
 Result := inherited CalcTopIndex(aMaxVisItem);
 if IsFirstSnippet(Result) then
  Inc(Result);
//#UC END# *5151B2C70248_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.CalcTopIndex

procedure TnscDocumentListTreeView.VlbVScrollPrim(aDelta: Integer);
//#UC START# *5152B96600E1_51D56E9F004B_var*
var
 l_TopIndex: Integer;
//#UC END# *5152B96600E1_51D56E9F004B_var*
begin
//#UC START# *5152B96600E1_51D56E9F004B_impl*
 l_TopIndex := TopIndex + aDelta;
 if IsFirstSnippet(l_TopIndex) then
 begin
  if aDelta > 0 then
   Inc(l_TopIndex)
  else
   Dec(l_TopIndex);
  TopIndex := Min(Max(l_TopIndex, 0), Total - 1);
 end else
  inherited;
//#UC END# *5152B96600E1_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.VlbVScrollPrim

function TnscDocumentListTreeView.VlbItemHitTest(aIndex: Integer;
  const aPt: TPoint;
  fromScreen: Boolean = False): Byte;
//#UC START# *5152C09F00DB_51D56E9F004B_var*
//#UC END# *5152C09F00DB_51D56E9F004B_var*
begin
//#UC START# *5152C09F00DB_51D56E9F004B_impl*
 Result := inherited VlbItemHitTest(aIndex, aPt, fromScreen);
//#UC END# *5152C09F00DB_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.VlbItemHitTest

procedure TnscDocumentListTreeView.DoOnGetItemColor(Index: LongInt;
  var FG: TColor;
  var BG: TColor);
//#UC START# *5152C79F0258_51D56E9F004B_var*
//#UC END# *5152C79F0258_51D56E9F004B_var*
begin
//#UC START# *5152C79F0258_51D56E9F004B_impl*
 inherited DoOnGetItemColor(Index, FG, BG);
{ if Assigned(TreeStruct.Nodes[Index]) then
  if (not IsEmpty) and (TreeStruct.Nodes[Index].GetLevel > 1) then
   FG := $818386;}
//#UC END# *5152C79F0258_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.DoOnGetItemColor

procedure TnscDocumentListTreeView.DoOnGetItemFont(Index: LongInt;
  const aFont: Il3Font;
  anItemPart: TvtListerItemPart);
//#UC START# *5152C7D50201_51D56E9F004B_var*
//#UC END# *5152C7D50201_51D56E9F004B_var*
begin
//#UC START# *5152C7D50201_51D56E9F004B_impl*
 inherited DoOnGetItemFont(Index, aFont, anItemPart);
 if (anItemPart in [vt_lipTextHint, vt_lipIconHint]) then
  aFont.Style := aFont.Style - [fsBold]; 
//#UC END# *5152C7D50201_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.DoOnGetItemFont

function TnscDocumentListTreeView.DoOnIsSelected(Index: LongInt): Integer;
//#UC START# *5152C8300174_51D56E9F004B_var*
//#UC END# *5152C8300174_51D56E9F004B_var*
begin
//#UC START# *5152C8300174_51D56E9F004B_impl*
 Result := inherited DoOnIsSelected(Index);

 if not IsEmpty then
  if IsFirstSnippet(Index) then
   Result := 0;
//#UC END# *5152C8300174_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.DoOnIsSelected

procedure TnscDocumentListTreeView.DoOnSelect(Index: LongInt;
  aValue: Integer);
//#UC START# *5152C85403DA_51D56E9F004B_var*
var
 l_NewNodeIndex: Integer;
 l_FullInvalidate: Boolean;
//#UC END# *5152C85403DA_51D56E9F004B_var*
begin
//#UC START# *5152C85403DA_51D56E9F004B_impl*
 inherited DoOnSelect(Index, aValue);

 l_FullInvalidate := f_AllSelected or (Index = vt_smAllSelect);
 f_AllSelected := False;

 if Index = vt_smAllSelect then
  f_AllSelected := Boolean(aValue)
 else
 if IsDocumentWithSnippets(Index) then
  InvalidateItem(Index + 1);

 if l_FullInvalidate then
  Invalidate;
//#UC END# *5152C85403DA_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.DoOnSelect

procedure TnscDocumentListTreeView.DoOnSelectOutRange(First: LongInt;
  Last: LongInt;
  aSelectState: Integer);
//#UC START# *5152C88400DC_51D56E9F004B_var*
//#UC END# *5152C88400DC_51D56E9F004B_var*
begin
//#UC START# *5152C88400DC_51D56E9F004B_impl*
 inherited;
 Invalidate;
//#UC END# *5152C88400DC_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.DoOnSelectOutRange

function TnscDocumentListTreeView.DoDoProcessCommand(Cmd: Tl3OperationCode): Boolean;
//#UC START# *5152C93400EB_51D56E9F004B_var*
var
 l_Curr: Integer;
//#UC END# *5152C93400EB_51D56E9F004B_var*
begin
//#UC START# *5152C93400EB_51D56E9F004B_impl*
 case Cmd of
  ccDown:
   begin
    Result := True;
    l_Curr := Current;
    if GetNextItem(l_Curr) then
     Current := l_Curr
    else
     FooterSelected := True;
   end;
  ccUp:
   begin
    if FooterSelected then
     FooterSelected := False
    else
    begin
     l_Curr := Current;
     if GetPrevItem(l_Curr) then
      Current := l_Curr;
    end;
    Result := True;
   end;
  ccExtendDown:
   begin
    l_Curr := Current;
    Result := GetNextItem(l_Curr);
    if Result then
    begin
     if TreeStruct.Select[l_Curr] then
      InternalSetSelected(Current, False)
     else
      InternalSetSelected(l_Curr, True);
     InternalSetCurrent(l_Curr);
     VlbMakeItemVisible(l_Curr);
    end;
   end;
  ccExtendUp:
   begin
    l_Curr := Current;
    Result := GetPrevItem(l_Curr);
    if Result then
    begin
     if TreeStruct.Select[l_Curr] then
      InternalSetSelected(Current, False)
     else
      InternalSetSelected(l_Curr, True);
     InternalSetCurrent(l_Curr);
     VlbMakeItemVisible(l_Curr);
    end;
   end;
 else
  Result := inherited DoDoProcessCommand(Cmd);
 end;
//#UC END# *5152C93400EB_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.DoDoProcessCommand

procedure TnscDocumentListTreeView.DoCurrentChanged(aNewCurrent: LongInt;
  aOldCurrent: LongInt);
//#UC START# *5152CA8601A6_51D56E9F004B_var*
var
 l_Node: Il3SimpleNode;
 l_LastSnippetIdx: LongInt;
//#UC END# *5152CA8601A6_51D56E9F004B_var*
begin
//#UC START# *5152CA8601A6_51D56E9F004B_impl*
 inherited;
 // Костыль: в случае, если последним в списке оказывался документ с одним сниппетом,
 // ссылка "показать полный список" не появлялась. Поэтому, здесь
 // пытаемся определить, не последний ли документ в списке выбран и не с одним
 // ли он сниппетом. Если так - то делаем видимым этот его сниппет, чтобы
 // появилась ссылка.
 // http://mdp.garant.ru/pages/viewpage.action?pageId=469800200
 if IsDocumentWithSnippets(aOldCurrent) then
  InvalidateItem(aOldCurrent + 1);
 if IsDocumentWithSnippets(aNewCurrent) then
 begin
  l_Node := TreeStruct.Nodes[aNewCurrent];
  if (l_Node.HasChild) and (l_Node.ThisChildrenCount = 1) then
  begin
   l_LastSnippetIdx := TreeStruct.GetIndex(l_Node.Child);
   if (l_LastSnippetIdx = f_HighIndex) then
    vlbMakeItemVisible(l_LastSnippetIdx);
  end;
  InvalidateItem(aNewCurrent + 1);
 end;
//#UC END# *5152CA8601A6_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.DoCurrentChanged

procedure TnscDocumentListTreeView.DoValidateCurrent(var aIndex: LongInt);
//#UC START# *5152CBED028E_51D56E9F004B_var*
//#UC END# *5152CBED028E_51D56E9F004B_var*
begin
//#UC START# *5152CBED028E_51D56E9F004B_impl*
 if IsFirstsnippet(aIndex) then
  Dec(aIndex);
 inherited DoValidateCurrent(aIndex);
//#UC END# *5152CBED028E_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.DoValidateCurrent

procedure TnscDocumentListTreeView.SelectItems(aFinish: Integer);
//#UC START# *515584B701A0_51D56E9F004B_var*
//#UC END# *515584B701A0_51D56E9F004B_var*
begin
//#UC START# *515584B701A0_51D56E9F004B_impl*
 if IsDocumentWithSnippets(aFinish) then
  Inc(aFinish);
 inherited SelectItems(aFinish);
//#UC END# *515584B701A0_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.SelectItems

procedure TnscDocumentListTreeView.HitTest(const aPt: TPoint;
  var aIndex: Integer;
  var aItemPart: Byte;
  fromScreen: Boolean = False);
//#UC START# *515586660348_51D56E9F004B_var*
//#UC END# *515586660348_51D56E9F004B_var*
begin
//#UC START# *515586660348_51D56E9F004B_impl*
 inherited HitTest(aPt, aIndex, aItemPart, fromScreen);

 if IsFirstSnippet(aIndex) then
  Dec(aIndex);
//#UC END# *515586660348_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.HitTest

procedure TnscDocumentListTreeView.VlbToggleSelection(Index: LongInt);
//#UC START# *51558804036E_51D56E9F004B_var*
var
 l_Node: Il3SimpleNode;
 l_Index: Integer;

 function lp_FindFirstSelected: Il3SimpleNode;
  function lp_Iterator(const aNode: Il3SimpleNode): Boolean;
  begin
   Result := True;
  end;//lpIterator
 var
  l_Tree: Il3ExpandedSimpleTree;
 begin
  Supports(TreeStruct, Il3ExpandedSimpleTree, l_Tree);
  Assert(Assigned(l_Tree));
  Result := l_Tree.FlagIterateF(l3L2SNA(@lp_Iterator), FM_SELECTION, 0, nil, True);
 end;

//#UC END# *51558804036E_51D56E9F004B_var*
begin
//#UC START# *51558804036E_51D56E9F004B_impl*
 if IsFirstSnippet(Index) then
 begin
  InternalSetSelected(Index, False); // первые сниппеты никогда не выделяем
  Dec(Index);
 end;

 if not (TreeStruct.Select[Index] and (SelectedCount = 1)) then
  inherited VlbToggleSelection(Index);

 // при снятии выделения с ноды ставим курсор на другую выделенную ноду
 if (Current = Index) and not TreeStruct.Select[Index] then
 begin
  l_Node := lp_FindFirstSelected;
  if Assigned(l_Node) then
   l_Index := TreeStruct.GetIndex(l_Node)
  else
   l_Index := -1;
  InternalSetCurrent(l_Index);
 end;
//#UC END# *51558804036E_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.VlbToggleSelection

function TnscDocumentListTreeView.DoOnGetItemIndentEx(anItemIndex: Integer): Integer;
//#UC START# *51D2DC290320_51D56E9F004B_var*
//#UC END# *51D2DC290320_51D56E9F004B_var*
begin
//#UC START# *51D2DC290320_51D56E9F004B_impl*
 Result := 0;
 if Assigned(TreeStruct.Nodes[anItemIndex]) then
  if (not IsEmpty) and (TreeStruct.Nodes[anItemIndex].GetLevel > 1) then
   if Assigned(f_OnGetNodeType) then
    if f_OnGetNodeType(anItemIndex) = lntBlock then
     Result := l3CrtIC.LP2DP(l3PointX(evGetStyleFirstIndent(ev_saSnippet))).X
    else
     Result := 5;
//#UC END# *51D2DC290320_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.DoOnGetItemIndentEx

function TnscDocumentListTreeView.GetSelectedCountForStatusbar: Integer;
//#UC START# *51DBCA8C0206_51D56E9F004B_var*
//#UC END# *51DBCA8C0206_51D56E9F004B_var*
begin
//#UC START# *51DBCA8C0206_51D56E9F004B_impl*
 Result := inherited GetSelectedCountForStatusbar;
//#UC END# *51DBCA8C0206_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.GetSelectedCountForStatusbar

function TnscDocumentListTreeView.NeedDrawSelectionOnItem(aItemIndex: Integer): Boolean;
//#UC START# *51E8006D030E_51D56E9F004B_var*
//#UC END# *51E8006D030E_51D56E9F004B_var*
begin
//#UC START# *51E8006D030E_51D56E9F004B_impl*
 if IsFirstSnippet(aItemIndex) then
  Dec(aItemIndex);
 Result := inherited NeedDrawSelectionOnItem(aItemIndex);
//#UC END# *51E8006D030E_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.NeedDrawSelectionOnItem

function TnscDocumentListTreeView.CanAcceptData(const aData: IDataObject): Boolean;
//#UC START# *51EEB81F017C_51D56E9F004B_var*
var
 l_List: IDynList;
//#UC END# *51EEB81F017C_51D56E9F004B_var*
begin
//#UC START# *51EEB81F017C_51D56E9F004B_impl*
 if Supports(TreeStruct, IDynList, l_List) and l_List.GetIsSnippet then
  Result := False
 else
  Result := inherited CanAcceptData(aData);
//#UC END# *51EEB81F017C_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.CanAcceptData

function TnscDocumentListTreeView.GetRealClientWidth: Integer;
//#UC START# *543239ED008D_51D56E9F004B_var*
//#UC END# *543239ED008D_51D56E9F004B_var*
begin
//#UC START# *543239ED008D_51D56E9F004B_impl*
 Result := inherited GetRealClientWidth;
  if (not IsVScrollVisible) then
   Dec(Result, GetSystemMetrics(SM_CXVSCROLL));
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=516166484
//#UC END# *543239ED008D_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.GetRealClientWidth

function TnscDocumentListTreeView.NeedAssignTreeStructFromHistory: Boolean;
//#UC START# *5604EC1403A8_51D56E9F004B_var*
//#UC END# *5604EC1403A8_51D56E9F004B_var*
begin
//#UC START# *5604EC1403A8_51D56E9F004B_impl*
 Result := (not LoadingCloneState);
//#UC END# *5604EC1403A8_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.NeedAssignTreeStructFromHistory

initialization
{$If not defined(NoScripts)}
// Регистрация TnscDocumentListTreeView
 TtfwClassRef.Register(TnscDocumentListTreeView);
{$IfEnd} //not NoScripts

end.