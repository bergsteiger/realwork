unit nscDocumentListTreeView;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Components\nscDocumentListTreeView.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TnscDocumentListTreeView" MUID: (51D56E9F004B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nscTreeViewWithAdapterDragDrop
 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , nscDocumentHistory
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 , Messages
 , Classes
 , l3Interfaces
 , Graphics
 , vtLister
 , ActiveX
 , bsTypes
;

type
 TdltGetNodeTypeEvent = function(anIndex: Integer): TbsListNodeType of object;

 TnscDocumentListTreeView = class(TnscTreeViewWithAdapterDragDrop{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , InscDocumentHistoryListener
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 )
  private
   f_OnGetNodeType: TdltGetNodeTypeEvent;
  private
   procedure WMGetText(var Msg: TWMGetText); message WM_GetText;
   procedure WMGetTextLength(var Msg: TWMGetTextLength); message WM_GETTEXTLENGTH;
  protected
   function GetCurrentText: AnsiString; virtual;
   {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
   procedure NewDocumentInHistory;
   {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure DoOnGetItemStyle(aItemIndex: Integer;
    const aFont: Il3Font;
    var aTextBackColor: TColor;
    var aItemBackColor: TColor;
    var aVJustify: TvtVJustify;
    var aFocused: Boolean;
    var theImageVertOffset: Integer); override;
   procedure DoOnGetItemFont(Index: LongInt;
    const aFont: Il3Font;
    anItemPart: TvtListerItemPart); override;
   function DoOnGetItemIndentEx(anItemIndex: Integer): Integer; override;
    {* для каждой ноды можно задать свой "персональный" сдвиг }
   function CanAcceptData(const aData: IDataObject): Boolean; override;
   function GetRealClientWidth: Integer; override;
   function NeedAssignTreeStructFromHistory: Boolean; override;
  public
   constructor Create(AOwner: TComponent); override;
  public
   property OnGetNodeType: TdltGetNodeTypeEvent
    read f_OnGetNodeType
    write f_OnGetNodeType;
 end;//TnscDocumentListTreeView

implementation

uses
 l3ImplUses
 , l3ControlsTypes
 , l3TreeInterfaces
 , Windows
 , SysUtils
 , l3String
 , evStyleTableTools
 , l3Units
 , l3ScreenIC
 , evdStyles
 , DynamicDocListUnit
 , DynamicTreeUnit
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *51D56E9F004Bimpl_uses*
 //#UC END# *51D56E9F004Bimpl_uses*
;

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
 end
 else
  Result := '';
//#UC END# *51E01CC7023D_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.GetCurrentText

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

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
procedure TnscDocumentListTreeView.NewDocumentInHistory;
//#UC START# *55E6CC91033A_51D56E9F004B_var*
//#UC END# *55E6CC91033A_51D56E9F004B_var*
begin
//#UC START# *55E6CC91033A_51D56E9F004B_impl*
 DropDrawPoints;
//#UC END# *55E6CC91033A_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.NewDocumentInHistory
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

procedure TnscDocumentListTreeView.Cleanup;
 {* Функция очистки полей объекта. }
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
  voShowOpenChip{,
  voDoNotShowFocusRect,
  voFullLineSelect}];
//#UC END# *47D1602000C6_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.Create

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
 inherited DoOnGetItemStyle(aItemIndex, aFont, aTextBackColor, aItemBackColor, aVJustify, aFocused, theImageVertOffset);
 if not SelfDrawNodes then
  if Assigned(TreeStruct.Nodes[aItemIndex]) then
   if not IsEmpty then
   begin
    l_Color := aFont.ForeColor;
    try
     l_Node := TreeStruct.Nodes[aItemIndex];
     if l_IsVisited(l_Node) then
      evGetStyleFont(aFont, ev_saVisitedDocumentInList);
    finally
     if aFocused then
      aFont.ForeColor := l_Color;
    end;
   end;
//#UC END# *508F825303E4_51D56E9F004B_impl*
end;//TnscDocumentListTreeView.DoOnGetItemStyle

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

function TnscDocumentListTreeView.DoOnGetItemIndentEx(anItemIndex: Integer): Integer;
 {* для каждой ноды можно задать свой "персональный" сдвиг }
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
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscDocumentListTreeView);
 {* Регистрация TnscDocumentListTreeView }
{$IfEnd} // NOT Defined(NoScripts)

end.
