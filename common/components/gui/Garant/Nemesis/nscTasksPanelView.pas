unit nscTasksPanelView;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscTasksPanelView.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TnscTasksPanelView" MUID: (4D3424C203C2)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , afwControl
 , afwInterfaces
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmTaskPanelInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , Graphics
 , Classes
 , nscInterfaces
 , Messages
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3InternalInterfaces
 , nscHideField
 {$If NOT Defined(NoVGScene)}
 , vg_scene
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vg_objects
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vg_layouts
 {$IfEnd} // NOT Defined(NoVGScene)
 , vtPanel
 , vtSpeedButton
 , Types
 , nscTreeView
 {$If NOT Defined(NoVCM)}
 , vcmPopupMenuPrim
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
 , vtLister
 //#UC START# *4D3424C203C2intf_uses*
 //#UC END# *4D3424C203C2intf_uses*
;

const
 c_ItemIndent = 10;
 c_RowIndent = 6;

type
 TnscTasksPanelHideField = class;

 TnscCustomTasksPanelView = class(TafwControl{$If NOT Defined(DesignTimeLibrary)}
 , IafwStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , Il3ItemNotifyRecipient{$If NOT Defined(NoVCM)}
 , IvcmTaskPanelNotifyRecipient
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   f_UpdateRequests: Integer;
   f_TasksPanel: IvcmCustOps;
   f_GroupImages: TCustomImageList;
   f_CollapseGroupImage: Integer;
   f_ExpandGroupImage: Integer;
   f_GroupColor: TColor;
   f_ImageList: TCustomImageList;
   f_OnOperationExecute: TNotifyEvent;
   f_TabTable: InscTabTable;
   f_Grid: InscArrangeGrid;
  private
   procedure AddGroup(const aGroup: IvcmCustOpsGroup);
   procedure GrideSizeChanged(aSender: TObject);
   procedure LockView;
   procedure UnlockView;
   procedure WMEraseBkGnd(var aMessage: TWMEraseBkGnd); message WM_ERASEBKGND;
  protected
   procedure pm_SetTasksPanel(const aValue: IvcmCustOps);
   procedure pm_SetGroupImages(aValue: TCustomImageList); virtual;
   function pm_GetTabTable: InscTabTable; virtual;
   function pm_GetIsViewLocked: Boolean; virtual;
   function pm_GetHideField(anIndex: Integer): TnscTasksPanelHideField; virtual;
   function pm_GetCount: Integer; virtual;
   function pm_GetGrid: InscArrangeGrid; virtual;
   procedure MakeTabTable;
   procedure ArrangeGrid(aRecalc: Boolean = False);
   {$If NOT Defined(DesignTimeLibrary)}
   procedure StyleTableChanged;
    {* таблица стилей изменилась. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure Notify(const aNotifier: Il3ChangeNotifier;
    aOperation: Integer;
    aIndex: Integer);
    {* прошла операция. }
   {$If NOT Defined(NoVCM)}
   procedure TaskPanelNotify(const aNotifier: Il3ChangeNotifier;
    aOperation: TvcmTaskPanelOperation;
    const aInterface: IvcmCustOpsItem);
    {* прошла операция. }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Paint(const CN: Il3Canvas); override;
    {* процедура рисования внешнего вида управляющего элемента }
   {$If NOT Defined(NoVCL)}
   procedure Resize; override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure ClearFields; override;
  public
   procedure DoOperationExecute;
   procedure MakeTasksPanel;
   procedure RemoveGroup(aHideField: TControl);
   function SortGroups: Boolean;
   procedure DefineActiveControl;
   constructor Create(AOwner: TComponent); override;
  protected
   property TabTable: InscTabTable
    read pm_GetTabTable;
   property IsViewLocked: Boolean
    read pm_GetIsViewLocked;
   property Grid: InscArrangeGrid
    read pm_GetGrid;
  public
   property TasksPanel: IvcmCustOps
    read f_TasksPanel
    write pm_SetTasksPanel;
   property GroupImages: TCustomImageList
    read f_GroupImages
    write pm_SetGroupImages;
   property CollapseGroupImage: Integer
    read f_CollapseGroupImage
    write f_CollapseGroupImage;
   property ExpandGroupImage: Integer
    read f_ExpandGroupImage
    write f_ExpandGroupImage;
   property GroupColor: TColor
    read f_GroupColor
    write f_GroupColor;
   property ImageList: TCustomImageList
    read f_ImageList
    write f_ImageList;
   property OnOperationExecute: TNotifyEvent
    read f_OnOperationExecute
    write f_OnOperationExecute;
   property HideField[anIndex: Integer]: TnscTasksPanelHideField
    read pm_GetHideField;
   property Count: Integer
    read pm_GetCount;
 end;//TnscCustomTasksPanelView

 TnscTasksPanelHideField = class(TnscHideField, Il3ItemNotifyRecipient)
  private
   {$If Defined(HideFieldVgSceneStyle)}
   f_HeaderScene: TvgScene;
   {$IfEnd} // Defined(HideFieldVgSceneStyle)
   {$If Defined(HideFieldVgSceneStyle)}
   f_HeaderBackGround: TvgBackground;
   {$IfEnd} // Defined(HideFieldVgSceneStyle)
   {$If Defined(HideFieldVgSceneStyle)}
   f_HeaderRectangle: TvgRectangle;
   {$IfEnd} // Defined(HideFieldVgSceneStyle)
   {$If Defined(HideFieldVgSceneStyle)}
   f_HeaderText: TvgText;
   {$IfEnd} // Defined(HideFieldVgSceneStyle)
   {$If Defined(HideFieldVgSceneStyle)}
   f_HeaderNonVGLayout: TvgNonVGLayout;
   {$IfEnd} // Defined(HideFieldVgSceneStyle)
   {$If Defined(HideFieldVgSceneStyle)}
   f_HeaderPanel: TvtPanel;
   {$IfEnd} // Defined(HideFieldVgSceneStyle)
   {$If Defined(HideFieldVgSceneStyle)}
   f_HeaderSpeedButton: TvtSpeedButton;
   {$IfEnd} // Defined(HideFieldVgSceneStyle)
   f_Group: IvcmCustOpsGroup;
   f_View: TnscCustomTasksPanelView;
   f_TasksPanel: IvcmCustOps;
  private
   {$If Defined(HideFieldVgSceneStyle)}
   procedure RefreshContent;
   {$IfEnd} // Defined(HideFieldVgSceneStyle)
   {$If Defined(HideFieldVgSceneStyle)}
   procedure DoOnClick(aSender: TObject);
   {$IfEnd} // Defined(HideFieldVgSceneStyle)
   function MakeSettingFromTasksPanel: TafwSettingId;
   procedure Subscribe(aSubscribe: Boolean);
   procedure UpdateCaption;
   procedure AFWCMTextChanged(var aMsg: TMessage); message afw_CM_TEXTCHANGED;
  protected
   procedure Notify(const aNotifier: Il3ChangeNotifier;
    aOperation: Integer;
    aIndex: Integer);
    {* прошла операция. }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Paint(const CN: Il3Canvas); override;
    {* процедура рисования внешнего вида управляющего элемента }
   {$If NOT Defined(NoVCL)}
   procedure SetParent(AParent: TWinControl); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure Resize; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure AdjustClientRect(var Rect: TRect); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure DoStateChanged; override;
   procedure DoStyleTableChanged; override;
   procedure HideControl; override;
   procedure ClearFields; override;
  public
   {$If Defined(HideFieldVgSceneStyle)}
   procedure SetBitmapButton;
   {$IfEnd} // Defined(HideFieldVgSceneStyle)
   constructor Create(AOwner: TComponent;
    const aGroup: IvcmCustOpsGroup); reintroduce;
  protected
   property View: TnscCustomTasksPanelView
    read f_View
    write f_View;
   property TasksPanel: IvcmCustOps
    read f_TasksPanel
    write f_TasksPanel;
  public
   property Group: IvcmCustOpsGroup
    read f_Group
    write f_Group;
 end;//TnscTasksPanelHideField

 TnscTasksPanelTreeView = class(TnscTreeView{$If NOT Defined(NoVCM)}
 , IvcmTaskPanelNotifyRecipient
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   f_CursorItem: Integer;
   f_Group: IvcmCustOpsGroup;
   f_PopupMenu: TvcmPopupMenuPrim;
   f_View: TnscCustomTasksPanelView;
  private
   procedure AddOp(const aOp: IvcmCustOpsGroupOperation);
   procedure AddOps;
   procedure SortChilds;
   function ItemAction(aItemIndex: Integer): TCustomAction;
  protected
   function pm_GetPopupMenu: TvcmPopupMenuPrim;
   function DoOnGetCursor(aSender: TObject;
    aIndex: Integer): TCursor;
   {$If NOT Defined(NoVCM)}
   procedure TaskPanelNotify(const aNotifier: Il3ChangeNotifier;
    aOperation: TvcmTaskPanelOperation;
    const aInterface: IvcmCustOpsItem);
    {* прошла операция. }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure SetParent(AParent: TWinControl); override;
   {$IfEnd} // NOT Defined(NoVCL)
   function DoIsCommandPublished(Cmd: Tl3OperationCode): Boolean; override;
   function DoOnGetItemImageIndex(aItemIndex: LongInt;
    var aImages: TCustomImageList): Integer; override;
   procedure DoOnActionElement(Index: LongInt); override;
   procedure DoOnGetItemStyle(aItemIndex: Integer;
    const aFont: Il3Font;
    var aTextBackColor: TColor;
    var aItemBackColor: TColor;
    var aVJustify: TvtVJustify;
    var aFocused: Boolean;
    var theImageVertOffset: Integer); override;
   procedure DoOnGetItemImageState(const aItemIndex: LongInt;
    var aEnabled: Boolean); override;
   procedure ClearFields; override;
  public
   constructor Create(AOwner: TComponent;
    const aGroup: IvcmCustOpsGroup); reintroduce;
   {$If NOT Defined(NoVCL)}
   procedure InitiateAction; override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   property Group: IvcmCustOpsGroup
    read f_Group
    write f_Group;
   property PopupMenu: TvcmPopupMenuPrim
    read pm_GetPopupMenu;
   property View: TnscCustomTasksPanelView
    read f_View
    write f_View;
 end;//TnscTasksPanelTreeView

 //#UC START# *4D3424C203C2ci*
 //#UC END# *4D3424C203C2ci*
 //#UC START# *4D3424C203C2cit*
 //#UC END# *4D3424C203C2cit*
 TnscTasksPanelView = class(TnscCustomTasksPanelView)
 //#UC START# *4D3424C203C2publ*
  published
  // propertes
    property Align;
      {-}
    property PopupMenu;
      {-}
    property GroupImages;
      {-}
    property CollapseGroupImage;
      {-}
    property ExpandGroupImage;
      {-}
    property ImageList;
      {-}
    property OnOperationExecute;
      {-}
 //#UC END# *4D3424C203C2publ*
 end;//TnscTasksPanelView
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , nscTasksPanelRootNode
 , nscTasksPanelActionLink
 , nscTasksPanelOperationNode
 , SysUtils
 , vtHideField
 , nscArrangeGridCell
 , eeTreeView
 , nscTabTableCell
 , nscArrangeGrid
 , afwFacade
 , nscTabTable
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , l3Units
 , l3Region
 , Windows
 {$If NOT Defined(NoScripts)}
 , tfwClassRef
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , TaskPanelWords
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , afwConsts
 {$If NOT Defined(NoVGScene)}
 , vgTypes
 {$IfEnd} // NOT Defined(NoVGScene)
 , l3Base
 , vtF1InterfaceConst
 , evStyleTableTools
 , l3Tree_TLB
 , nscTaskPanelInterfaces
 , OvcConst
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmAction
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMenus
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUtils
 {$IfEnd} // NOT Defined(NoVCM)
 , l3String
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3ControlsTypes
 , l3Nodes
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , vtOutliner
 //#UC START# *4D3424C203C2impl_uses*
 //#UC END# *4D3424C203C2impl_uses*
;

const
 c_CaptionIndent = 5;
 c_TopClientIndent = 5;

procedure TnscCustomTasksPanelView.pm_SetTasksPanel(const aValue: IvcmCustOps);
//#UC START# *508EB28F03DA_508EBA08009Fset_var*
//#UC END# *508EB28F03DA_508EBA08009Fset_var*
begin
//#UC START# *508EB28F03DA_508EBA08009Fset_impl*
 if (f_TasksPanel <> aValue) then
 begin
  if (f_TasksPanel <> nil) then
  begin
//   MakeTasksPanel;
   f_TasksPanel.As_Il3ChangeNotifier.UnSubscribe(IvcmTaskPanelNotifyRecipient(Self));
   f_TasksPanel.As_Il3ChangeNotifier.UnSubscribe(Il3ItemNotifyRecipient(Self));
  end;//f_TasksPanel <> nil
  f_TasksPanel := aValue;
  if (f_TasksPanel <> nil) then
  begin
   f_TasksPanel.As_Il3ChangeNotifier.Subscribe(IvcmTaskPanelNotifyRecipient(Self));
   f_TasksPanel.As_Il3ChangeNotifier.Subscribe(Il3ItemNotifyRecipient(Self));
   MakeTasksPanel;
  end;//f_TasksPanel <> nil
 end;//f_TasksPanel <> aValue
//#UC END# *508EB28F03DA_508EBA08009Fset_impl*
end;//TnscCustomTasksPanelView.pm_SetTasksPanel

procedure TnscCustomTasksPanelView.pm_SetGroupImages(aValue: TCustomImageList);
//#UC START# *508EB30E0238_508EBA08009Fset_var*
//#UC END# *508EB30E0238_508EBA08009Fset_var*
begin
//#UC START# *508EB30E0238_508EBA08009Fset_impl*
 f_GroupImages := aValue;
//#UC END# *508EB30E0238_508EBA08009Fset_impl*
end;//TnscCustomTasksPanelView.pm_SetGroupImages

function TnscCustomTasksPanelView.pm_GetTabTable: InscTabTable;
//#UC START# *508EBC200154_508EBA08009Fget_var*
//#UC END# *508EBC200154_508EBA08009Fget_var*
begin
//#UC START# *508EBC200154_508EBA08009Fget_impl*
 if f_TabTable = nil then
  f_TabTable := TnscTabTable.Make;
 Result := f_TabTable;
//#UC END# *508EBC200154_508EBA08009Fget_impl*
end;//TnscCustomTasksPanelView.pm_GetTabTable

function TnscCustomTasksPanelView.pm_GetIsViewLocked: Boolean;
//#UC START# *508EBC4B00B3_508EBA08009Fget_var*
//#UC END# *508EBC4B00B3_508EBA08009Fget_var*
begin
//#UC START# *508EBC4B00B3_508EBA08009Fget_impl*
 Result := f_UpdateRequests > 0;
//#UC END# *508EBC4B00B3_508EBA08009Fget_impl*
end;//TnscCustomTasksPanelView.pm_GetIsViewLocked

function TnscCustomTasksPanelView.pm_GetHideField(anIndex: Integer): TnscTasksPanelHideField;
//#UC START# *510261DC001C_508EBA08009Fget_var*
var
 l_Group: IagControlCell;
//#UC END# *510261DC001C_508EBA08009Fget_var*
begin
//#UC START# *510261DC001C_508EBA08009Fget_impl*
 if Supports(Grid.Column[0].Cell[anIndex], IagControlCell, l_Group) then
  Result := l_Group.Control as TnscTasksPanelHideField;
//#UC END# *510261DC001C_508EBA08009Fget_impl*
end;//TnscCustomTasksPanelView.pm_GetHideField

function TnscCustomTasksPanelView.pm_GetCount: Integer;
//#UC START# *510261F0028D_508EBA08009Fget_var*
//#UC END# *510261F0028D_508EBA08009Fget_var*
begin
//#UC START# *510261F0028D_508EBA08009Fget_impl*
 if Grid.ColumnCount > 0
  then Result := Grid.Column[0].CellCount
  else Result := 0;
//#UC END# *510261F0028D_508EBA08009Fget_impl*
end;//TnscCustomTasksPanelView.pm_GetCount

function TnscCustomTasksPanelView.pm_GetGrid: InscArrangeGrid;
//#UC START# *510288E102AC_508EBA08009Fget_var*
//#UC END# *510288E102AC_508EBA08009Fget_var*
begin
//#UC START# *510288E102AC_508EBA08009Fget_impl*
 if f_Grid = nil then
 begin
  f_Grid := TnscArrangeGrid.Make(False, True);
  f_Grid.OnSizeChanged := GrideSizeChanged;
 end;//if f_Grid = nil then
 Result := f_Grid;
//#UC END# *510288E102AC_508EBA08009Fget_impl*
end;//TnscCustomTasksPanelView.pm_GetGrid

procedure TnscCustomTasksPanelView.DoOperationExecute;
//#UC START# *508EBB6A02D9_508EBA08009F_var*
//#UC END# *508EBB6A02D9_508EBA08009F_var*
begin
//#UC START# *508EBB6A02D9_508EBA08009F_impl*
 if Assigned(f_OnOperationExecute) then
  f_OnOperationExecute(Self);
//#UC END# *508EBB6A02D9_508EBA08009F_impl*
end;//TnscCustomTasksPanelView.DoOperationExecute

procedure TnscCustomTasksPanelView.MakeTasksPanel;
//#UC START# *508EBB7A001F_508EBA08009F_var*
var
 l_Iterator: IvcmCustOpsGroupsIterator;
 l_Group: IvcmCustOpsGroup;
 l_WC: TWinControl;

 I, J: Integer;
//#UC END# *508EBB7A001F_508EBA08009F_var*
begin
//#UC START# *508EBB7A001F_508EBA08009F_impl*
 if (TasksPanel <> nil) then
 begin
  f_Grid := nil;
  TabTable.Clear;
  for I := ControlCount - 1 downto 0 do
   if (Controls[I].Owner = Self) then
   begin
    if (Controls[I] is TWinControl) then
    begin
     l_WC := TWinControl(Controls[I]);
     for J := l_WC.ControlCount - 1 downto 0 do
      if (l_WC.Controls[J] is TWinControl) then
      begin
       if (l_WC.Controls[J].Owner = Self) then
       begin
        with l_WC.Controls[J] do
        begin
         Parent := nil;
         Free;
        end;
       end
       else
        TWinControl(l_WC.Controls[J]).Parent := Self.Parent;
      end//l_WC.Controls[0] is TWinControl
      else
       Assert(false);
    end;//Controls[0] is TWinControl
    with Controls[I] do
    begin
     Parent := nil;
     Free;
    end;
   end//Controls[0].Owner = Self
   else
    Assert(false);
  l_Iterator := TasksPanel.Groups;
  try
   l_Group := l_Iterator.Next;
   while l_Group <> nil do
   begin
    AddGroup(l_Group);
    l_Group := l_Iterator.Next;
   end;//while l_Group <> nil do
  finally
   l_Iterator := nil;
  end;//try..finally
  if not SortGroups then
   ArrangeGrid;
 end;//if TasksPanel <> nil then
//#UC END# *508EBB7A001F_508EBA08009F_impl*
end;//TnscCustomTasksPanelView.MakeTasksPanel

procedure TnscCustomTasksPanelView.RemoveGroup(aHideField: TControl);
//#UC START# *508EBBB1038A_508EBA08009F_var*
var
 l_Index: Integer;
 l_Cell: IagControlCell;
//#UC END# *508EBBB1038A_508EBA08009F_var*
begin
//#UC START# *508EBBB1038A_508EBA08009F_impl*
 for l_Index := 0 to Pred(Grid.RowCount) do
  if Supports(Grid.Cell[l_Index, 0], IagControlCell, l_Cell) then
  try
   if l_Cell.Control = aHideField then
   begin
    l_Cell.Control := nil;
    Grid.Row[l_Index].Delete;
    aHideField.Free;
    ArrangeGrid(True);
    MakeTabTable;
    Break;
   end;//if l_Cell.Control = TControl(AComponent) then
  finally
   l_Cell := nil;
  end;//try..finally
//#UC END# *508EBBB1038A_508EBA08009F_impl*
end;//TnscCustomTasksPanelView.RemoveGroup

function TnscCustomTasksPanelView.SortGroups: Boolean;
//#UC START# *508EBBC80102_508EBA08009F_var*
 function lp_Pos(const aGroup: IagControlCell): Integer;
 begin
  Result := TnscTasksPanelHideField(aGroup.Control).Group.Position;
 end;//lp_Pos

 function lp_ClearGroupControl(const aGroup: IagControlCell): TControl;
 begin
  Result := aGroup.Control;
   // - запомним компонент;
  aGroup.Control := nil;
   // - отпустим обработчики перекрываемые ячейкой у компонента, иначе может
   //   получиться зацикливание;
 end;//lp_ClearGroupControl

var
 l_J: Integer;
 l_Index: Integer;
 l_Group1: IagControlCell;
 l_Group2: IagControlCell;
 l_Control1: TControl;
 l_Control2: TControl;
 l_Done: Boolean;
//#UC END# *508EBBC80102_508EBA08009F_var*
begin
//#UC START# *508EBBC80102_508EBA08009F_impl*
 Result := False;
 with Grid do
  if ColumnCount > 0 then
   for l_J := 0 to Pred(Column[0].CellCount) do
   begin
    l_Done := True;
    for l_Index := Pred(Column[0].CellCount) downto Succ(l_J) do
    begin
     if Supports(Column[0].Cell[l_Index], IagControlCell, l_Group2) and
      Supports(Column[0].Cell[l_Index - 1], IagControlCell, l_Group1) and
      (lp_Pos(l_Group1) > lp_Pos(l_Group2)) then
     begin
      Result := True;
      l_Done := False;
      l_Control1 := lp_ClearGroupControl(l_Group1);
      l_Control2 := lp_ClearGroupControl(l_Group2);
      l_Group1.Control := l_Control2;
      TWinControl(l_Control2).TabOrder := l_Index - 1;
      l_Group2.Control := l_Control1;
      TWinControl(l_Control1).TabOrder := l_Index;
     end;//if Supports(Column[0].Cell[l_Index]
    end;//for l_Index := 0 to Pred(Column[0].CellCount) do
    // Во время последнего цикла не было сделано ни одной перестановки, группы
    // отсортированы, выходим:
    if l_Done then
     Break;
   end;//for l_J := 0 to Pred(Column[0].CellCount) do
 if Result then
 begin
  ArrangeGrid(True);
  MakeTabTable;
 end;//if Result then
//#UC END# *508EBBC80102_508EBA08009F_impl*
end;//TnscCustomTasksPanelView.SortGroups

procedure TnscCustomTasksPanelView.DefineActiveControl;
//#UC START# *508EBC8B0298_508EBA08009F_var*
var
 l_Cell: IagControlCell;
//#UC END# *508EBC8B0298_508EBA08009F_var*
begin
//#UC START# *508EBC8B0298_508EBA08009F_impl*
 with Grid do
  if (Grid.ColumnCount > 0) and
     (Grid.Column[0].CellCount > 0) and
     Supports(Column[0].Cell[0], IagControlCell, l_Cell) and
     TWinControl(l_Cell.Control).CanFocus then
   TWinControl(l_Cell.Control).SetFocus;
//#UC END# *508EBC8B0298_508EBA08009F_impl*
end;//TnscCustomTasksPanelView.DefineActiveControl

procedure TnscCustomTasksPanelView.MakeTabTable;
//#UC START# *508EBB87010C_508EBA08009F_var*
var
 l_Index: Integer;
 l_Cell: IagControlCell;
//#UC END# *508EBB87010C_508EBA08009F_var*
begin
//#UC START# *508EBB87010C_508EBA08009F_impl*
 TabTable.Clear;
 if Grid.ColumnCount > 0 then
  with Grid.Column[0] do
   for l_Index := 0 to Pred(CellCount) do
    if Supports(Cell[l_Index], IagControlCell, l_Cell) then
    try
     if TabTable.ColumnCount = 0 then
      TabTable.AddColumn;
     with TabTable.Column[0] do
     begin
      // HideField
      AddItem(TnscHideFieldTabCell.Make(TvtHideField(l_Cell.Control)));
      // TreeView
      AddItem(TnscTreeViewTabCell.Make(TnscTasksPanelTreeView(
       TvtHideField(l_Cell.Control).ClientControl)));
     end;//with TabTable.Column[0] do
    finally
     l_Cell := nil;
    end;//try..finally
//#UC END# *508EBB87010C_508EBA08009F_impl*
end;//TnscCustomTasksPanelView.MakeTabTable

procedure TnscCustomTasksPanelView.ArrangeGrid(aRecalc: Boolean = False);
//#UC START# *508EBB960031_508EBA08009F_var*
//#UC END# *508EBB960031_508EBA08009F_var*
begin
//#UC START# *508EBB960031_508EBA08009F_impl*
 if (f_Grid <> nil) and not IsViewLocked then
 begin
  if aRecalc then
   f_Grid.Recalc;
  agArrangeGrid(f_Grid, afw.GetParentForm(Self), Self, 0);
 end;//if f_Grid <> nil then
//#UC END# *508EBB960031_508EBA08009F_impl*
end;//TnscCustomTasksPanelView.ArrangeGrid

procedure TnscCustomTasksPanelView.AddGroup(const aGroup: IvcmCustOpsGroup);
//#UC START# *508EBB16008E_508EBA08009F_var*
var
 l_HideField: TnscTasksPanelHideField;
 l_TreeView: TnscTasksPanelTreeView;
 l_Control: TWinControl;
 l_TmpComponent: TComponent;
//#UC END# *508EBB16008E_508EBA08009F_var*
begin
//#UC START# *508EBB16008E_508EBA08009F_impl*
 if aGroup.IsLinkToExistingControl then
 begin
  l_Control := aGroup.Control;
  Assert(l_Control <> nil);
  l_TreeView := nil;
 end//aGroup.IsLinkToExistingControl
 else
 begin
  l_TreeView := TnscTasksPanelTreeView.Create(Self, aGroup);
  l_TreeView.Name := Self.Name + '_' +  IntToStr(aGroup.Position) + '_' + IntToStr(aGroup.RepGroup.ID);
  l_Control := l_TreeView;
 end;//aGroup.IsLinkToExistingControl

  // компонент может не быть удален из-за взведенного счетчика ссылок
  // http://mdp.garant.ru/pages/viewpage.action?pageId=522786290
 l_TmpComponent := Self.FindComponent('field_' + l_Control.Name);
 if Assigned(l_TmpComponent) then
 begin
  l_TmpComponent.Name := '';
 end;

 l_HideField := TnscTasksPanelHideField.Create(Self, aGroup);
 l_HideField.Name := 'field_' + l_Control.Name;
 with l_HideField do
 begin
  Parent := Self;
  ClientControl := l_Control;
  Font.Style := [fsBold];
  Options := [hfoCanHide];
  LeftHeaderIndent := 5;
  TopHeaderIndent := 5;
  ButtonImageList := GroupImages;
  {$IfDef HideFieldVgSceneStyle}
  { Для DFM-a не подходит $IfDef, и подгружаемые из TasksPanel_Form.dfm индексы картинок
    затирают значения, установленные в TPrimContentsForm.InitLists. Поэтому выставляем их явно. }
  CollapseGroupImage := 2;
  ExpandGroupImage := 3;
  {$EndIf HideFieldVgSceneStyle}
  ButtonOpenImage := ExpandGroupImage;
  ButtonCloseImage := CollapseGroupImage;
  HeaderColor := GroupColor;
  TabStop := True;
//  l_HideField.Perform(CM_FONTCHANGED, 0, 0);
 {$IfDef HideFieldVgSceneStyle}
  SetBitmapButton;
 {$EndIf HideFieldVgSceneStyle}
 end;//with l_HideField do
 if (l_TreeView = nil) then
 begin
//  l_Control.Parent := l_HideField;
 end//l_TreeView = nil
 else
  l_TreeView.Images := ImageList;
 // Сетка контролов:
 with Grid do
 begin
  AddRow;
  Cell[Pred(RowCount), 0] := TnscHideFieldCell.Make(l_HideField, false{(l_TreeView = nil)});
 end;//with f_Grid do
 // Сетка перехода фокуса:
 with TabTable do
 begin
  if ColumnCount = 0 then
   AddColumn;
  if (l_TreeView = nil) then
  begin
   if (l_Control is TeeTreeView) then
    Column[0].AddItem(TnscTreeViewTabCell.Make(TeeTreeView(l_Control)))
   else
    Column[0].AddItem(TnscTabCell.Make(l_Control));
  end//l_TreeView = nil
  else
   Column[0].AddItem(TnscTreeViewTabCell.Make(l_TreeView));
 end;//with TabTable do
//#UC END# *508EBB16008E_508EBA08009F_impl*
end;//TnscCustomTasksPanelView.AddGroup

procedure TnscCustomTasksPanelView.GrideSizeChanged(aSender: TObject);
//#UC START# *508EBB35000D_508EBA08009F_var*
//#UC END# *508EBB35000D_508EBA08009F_var*
begin
//#UC START# *508EBB35000D_508EBA08009F_impl*
 ArrangeGrid;
//#UC END# *508EBB35000D_508EBA08009F_impl*
end;//TnscCustomTasksPanelView.GrideSizeChanged

procedure TnscCustomTasksPanelView.LockView;
//#UC START# *508EBB4E0337_508EBA08009F_var*
//#UC END# *508EBB4E0337_508EBA08009F_var*
begin
//#UC START# *508EBB4E0337_508EBA08009F_impl*
 if not IsViewLocked then
  Grid.BeginUpdate;
 Inc(f_UpdateRequests);
//#UC END# *508EBB4E0337_508EBA08009F_impl*
end;//TnscCustomTasksPanelView.LockView

procedure TnscCustomTasksPanelView.UnlockView;
//#UC START# *508EBB5B038C_508EBA08009F_var*
//#UC END# *508EBB5B038C_508EBA08009F_var*
begin
//#UC START# *508EBB5B038C_508EBA08009F_impl*
 Dec(f_UpdateRequests);
 if not IsViewLocked then
 begin
  Grid.EndUpdate;
  // http://mdp.garant.ru/pages/viewpage.action?pageId=505415962
  if HandleAllocated then
   ArrangeGrid(True);
 end;//if not IsViewLocked then
//#UC END# *508EBB5B038C_508EBA08009F_impl*
end;//TnscCustomTasksPanelView.UnlockView

procedure TnscCustomTasksPanelView.WMEraseBkGnd(var aMessage: TWMEraseBkGnd);
//#UC START# *508EBAB102AA_508EBA08009F_var*
//#UC END# *508EBAB102AA_508EBA08009F_var*
begin
//#UC START# *508EBAB102AA_508EBA08009F_impl*
 aMessage.Result := 1;
//#UC END# *508EBAB102AA_508EBA08009F_impl*
end;//TnscCustomTasksPanelView.WMEraseBkGnd

{$If NOT Defined(DesignTimeLibrary)}
procedure TnscCustomTasksPanelView.StyleTableChanged;
 {* таблица стилей изменилась. }
//#UC START# *467D2CB10135_508EBA08009F_var*
var
 l_Index: Integer;
 l_Spy: IafwStyleTableSpy;
//#UC END# *467D2CB10135_508EBA08009F_var*
begin
//#UC START# *467D2CB10135_508EBA08009F_impl*
 // Применим изменения таблицы стилей, нужно чтобы до процесса размещения у
 // компонентов установились новые размеры:
 if f_Grid <> nil then
 begin
  for l_Index := 0 to Pred(ComponentCount) do
   if Supports(Components[l_Index], IafwStyleTableSpy, l_Spy) then
   try
    l_Spy.StyleTableChanged;
   finally
    l_Spy := nil;
   end;//try..finally
 end;//if f_Grid <> nil then
 // Разместим:
 ArrangeGrid(True);
//#UC END# *467D2CB10135_508EBA08009F_impl*
end;//TnscCustomTasksPanelView.StyleTableChanged
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TnscCustomTasksPanelView.Notify(const aNotifier: Il3ChangeNotifier;
 aOperation: Integer;
 aIndex: Integer);
 {* прошла операция. }
//#UC START# *46A4504B03C4_508EBA08009F_var*
//#UC END# *46A4504B03C4_508EBA08009F_var*
begin
//#UC START# *46A4504B03C4_508EBA08009F_impl*
 case TvcmTaskPanelOperation(aOperation) of
  cvcm_tpBeforeUpdate: LockView;
  cvcm_tpAfterUpdate: UnLockView;
 end;//case aOperation of
//#UC END# *46A4504B03C4_508EBA08009F_impl*
end;//TnscCustomTasksPanelView.Notify

{$If NOT Defined(NoVCM)}
procedure TnscCustomTasksPanelView.TaskPanelNotify(const aNotifier: Il3ChangeNotifier;
 aOperation: TvcmTaskPanelOperation;
 const aInterface: IvcmCustOpsItem);
 {* прошла операция. }
//#UC START# *46A450C703AE_508EBA08009F_var*
var
 l_Group: IvcmCustOpsGroup;
//#UC END# *46A450C703AE_508EBA08009F_var*
begin
//#UC START# *46A450C703AE_508EBA08009F_impl*
 if (aOperation = cvcm_tpGroupAdded) and
  Supports(aInterface, IvcmCustOpsGroup, l_Group) then
 try
  AddGroup(l_Group);
  if not SortGroups then
   ArrangeGrid;
 finally
  l_Group := nil;
 end;//try..finally
//#UC END# *46A450C703AE_508EBA08009F_impl*
end;//TnscCustomTasksPanelView.TaskPanelNotify
{$IfEnd} // NOT Defined(NoVCM)

procedure TnscCustomTasksPanelView.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_508EBA08009F_var*
//#UC END# *479731C50290_508EBA08009F_var*
begin
//#UC START# *479731C50290_508EBA08009F_impl*
 {$If not defined(DesignTimeLibrary)}
 evDelStyleTableSpy(Self);
 {$IfEnd}
 if (TasksPanel <> nil) then
  TasksPanel.As_Il3ChangeNotifier.Unsubscribe(Il3ItemNotifyRecipient(Self));
 if (TasksPanel <> nil) then
  TasksPanel.As_Il3ChangeNotifier.Unsubscribe(IvcmTaskPanelNotifyRecipient(Self));
 f_TasksPanel := nil;
 f_Grid := nil;
 f_TabTable := nil;
 inherited;
//#UC END# *479731C50290_508EBA08009F_impl*
end;//TnscCustomTasksPanelView.Cleanup

constructor TnscCustomTasksPanelView.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_508EBA08009F_var*
//#UC END# *47D1602000C6_508EBA08009F_var*
begin
//#UC START# *47D1602000C6_508EBA08009F_impl*
 inherited;
 ParentColor := False;
 f_CollapseGroupImage := -1;
 f_ExpandGroupImage := -1;
 f_GroupColor := clNavy;
 {$IfNDef DesignTimeLibrary}
 evAddStyleTableSpy(Self);
 {$EndIf DesignTimeLibrary}
 f_UpdateRequests := 0;
//#UC END# *47D1602000C6_508EBA08009F_impl*
end;//TnscCustomTasksPanelView.Create

procedure TnscCustomTasksPanelView.Paint(const CN: Il3Canvas);
 {* процедура рисования внешнего вида управляющего элемента }
//#UC START# *48C6C044025E_508EBA08009F_var*
var
{$IfDef DesignTimeLibrary}
 l_Rect: TRect;
{$Else DesignTimeLibrary}
 l_Rgn   : Il3Region;
 l_SRect : Tl3SRect;
{$EndIf DesignTimeLibrary}
//#UC END# *48C6C044025E_508EBA08009F_var*
begin
//#UC START# *48C6C044025E_508EBA08009F_impl*
 inherited;
 {$IfDef DesignTimeLibrary}
 with CN, Canvas do
 begin
  Pen.Color := clBlack;
  Pen.Width := 2;
  Brush.Color := Self.Color;
  l_Rect := Rect(0, 0, Width, Height);
  InflateRect(l_Rect, -2, -2);
  Rectangle(l_Rect);
  InflateRect(l_Rect, -4, -4);
  DrawText(l3PCharLen('TasksPanelView is RunTime control. It don`t allow ' +
   'edit anything in DesignTime.'), l_Rect, DT_CENTER or DT_VCENTER or
   DT_WORDBREAK);
 end;//with CN.Canvas do
 {$Else DesignTimeLibrary}
 // Таблица не пустая, нужно залить подложку без
 // дочерних компонентов (K<104435077>):
 if not Grid.IsEmpty then
 begin
  l_Rgn := Tl3Region.Make;
  try
   l_SRect.InitRect(ClientRect);
   l_Rgn.Rect := l_SRect;
   with Grid do
    l_SRect.InitRect(Rect(Left, Top, LastColumn.Right, LastRow.Bottom));
   if l_Rgn.CombineRect(l_SRect, RGN_DIFF) <> NULLREGION then
    with CN, Canvas do
    begin
     Brush.Color := Self.Color;
     FillRgn(l_Rgn);
    end;//with CN do
  finally
   l_Rgn := nil;
  end;
 end
 else
 begin
  l_SRect.InitRect(Self.ClientRect);
  CN.FillRect(l_SRect);
 end;//if not Grid.IsEmpty then
 {$EndIf DesignTimeLibrary}
//#UC END# *48C6C044025E_508EBA08009F_impl*
end;//TnscCustomTasksPanelView.Paint

{$If NOT Defined(NoVCL)}
procedure TnscCustomTasksPanelView.Resize;
//#UC START# *4CC8417A0288_508EBA08009F_var*
//#UC END# *4CC8417A0288_508EBA08009F_var*
begin
//#UC START# *4CC8417A0288_508EBA08009F_impl*
 inherited;
 ArrangeGrid;
//#UC END# *4CC8417A0288_508EBA08009F_impl*
end;//TnscCustomTasksPanelView.Resize
{$IfEnd} // NOT Defined(NoVCL)

procedure TnscCustomTasksPanelView.ClearFields;
begin
 TasksPanel := nil;
 f_TabTable := nil;
 f_Grid := nil;
 inherited;
end;//TnscCustomTasksPanelView.ClearFields

{$If Defined(HideFieldVgSceneStyle)}
procedure TnscTasksPanelHideField.RefreshContent;
//#UC START# *508F860C0236_508EBD7703BF_var*
var
 l_Rect, l_CaptionRect: TRect;
//#UC END# *508F860C0236_508EBD7703BF_var*
begin
//#UC START# *508F860C0236_508EBD7703BF_impl*
 if not (HasParent and Assigned(f_HeaderPanel)) then Exit;
 l_Rect := HeaderRect;
 with f_HeaderBackGround do
 begin
  Fill.Color := vgColorToStr(vgColorFromVCL(Self.Color));
 end;//with f_HeaderBackGround
 with f_HeaderScene do
 begin
  Height := l_Rect.Bottom - l_Rect.Top;
 end;//with f_HeaderScene
 with f_HeaderText do
 begin
  Position.Point := vgPoint(0,0);
  Font.Assign(Self.Font);
  Fill.Color := vgColorToStr(vgColorFromVCL(clWhite));
  Text := Self.Caption;
  // http://mdp.garant.ru/pages/viewpage.action?pageId=499495887
  f_HeaderText.Align := vaLeft; (*vaClient;*)
 end;//with f_HeaderText
 with f_HeaderRectangle do
 begin
  Position.Point := vgPoint(0, CaptionIndent);
  l_CaptionRect := CaptionRect;
  Height := l_CaptionRect.Bottom;
  Width := Self.ClientWidth;
  with Fill.Gradient do
  begin
   if Points.Count = 2 then
   begin
    with TvgGradientPoint(Points[0]) do
    begin
     Color := vgColorToStr(vgColorFromVCL(HeaderColor));
    end;
   end;
  end;
  Stroke.Style := vgBrushSolid;
 end;
//#UC END# *508F860C0236_508EBD7703BF_impl*
end;//TnscTasksPanelHideField.RefreshContent
{$IfEnd} // Defined(HideFieldVgSceneStyle)

{$If Defined(HideFieldVgSceneStyle)}
procedure TnscTasksPanelHideField.SetBitmapButton;
//#UC START# *508F861E00EF_508EBD7703BF_var*
var
 l_Image: Integer;
//#UC END# *508F861E00EF_508EBD7703BF_var*
begin
//#UC START# *508F861E00EF_508EBD7703BF_impl*
 if (f_HeaderSpeedButton = nil) then Exit;
 with f_HeaderNonVGLayout do
 begin
  Position.Point := vgPoint(f_HeaderRectangle.Width - 20, 6);
  case State of
   hfsHide:
    l_Image := ButtonOpenImage;
   hfsShow:
    l_Image := ButtonCloseImage;
   else
    l_Image := -1;
  end;
  if CheckImage(ButtonImageList, l_Image) then
  begin
   Width  := ButtonImageList.Width;
   Height := ButtonImageList.Height;
   f_HeaderSpeedButton.Images := ButtonImageList;
   f_HeaderSpeedButton.ImageIndex := l_Image;
  end;
 end;
//#UC END# *508F861E00EF_508EBD7703BF_impl*
end;//TnscTasksPanelHideField.SetBitmapButton
{$IfEnd} // Defined(HideFieldVgSceneStyle)

{$If Defined(HideFieldVgSceneStyle)}
procedure TnscTasksPanelHideField.DoOnClick(aSender: TObject);
//#UC START# *508F862C0013_508EBD7703BF_var*
//#UC END# *508F862C0013_508EBD7703BF_var*
begin
//#UC START# *508F862C0013_508EBD7703BF_impl*
//OnClick(aSender); Exit;
 SetFocus;
 case State of
  hfsHide:
   State := hfsShow;
  hfsShow:
   State := hfsHide;
 end;
 SetBitmapButton;
 RefreshContent;
//#UC END# *508F862C0013_508EBD7703BF_impl*
end;//TnscTasksPanelHideField.DoOnClick
{$IfEnd} // Defined(HideFieldVgSceneStyle)

function TnscTasksPanelHideField.MakeSettingFromTasksPanel: TafwSettingId;
//#UC START# *508F91900101_508EBD7703BF_var*
//#UC END# *508F91900101_508EBD7703BF_var*
begin
//#UC START# *508F91900101_508EBD7703BF_impl*
 Result := TasksPanel.BaseSettingId + g_afwPathSep + 'HideField' + g_afwPathSep + IntToStr(Group.RepGroup.Id);
//#UC END# *508F91900101_508EBD7703BF_impl*
end;//TnscTasksPanelHideField.MakeSettingFromTasksPanel

procedure TnscTasksPanelHideField.Subscribe(aSubscribe: Boolean);
//#UC START# *508F91A5032C_508EBD7703BF_var*
//#UC END# *508F91A5032C_508EBD7703BF_var*
begin
//#UC START# *508F91A5032C_508EBD7703BF_impl*
 if (TasksPanel <> nil) then
 begin
  if aSubscribe then
   TasksPanel.As_Il3ChangeNotifier.Subscribe(Il3ItemNotifyRecipient(Self))
  else
   TasksPanel.As_Il3ChangeNotifier.Unsubscribe(Il3ItemNotifyRecipient(Self));
 end;//TasksPanel <> nil
 if (Group <> nil) then
 begin
  if aSubscribe then
   Group.As_Il3ChangeNotifier.Subscribe(Il3ItemNotifyRecipient(Self))
  else
   Group.As_Il3ChangeNotifier.Unsubscribe(Il3ItemNotifyRecipient(Self));
  if (Group.RepGroup <> nil) then
  begin
   if aSubscribe then
    Group.RepGroup.As_Il3ChangeNotifier.Subscribe(Il3ItemNotifyRecipient(Self))
   else
    Group.RepGroup.As_Il3ChangeNotifier.Unsubscribe(Il3ItemNotifyRecipient(Self));
  end;//Group.RepGroup <> nil
 end;//Group <> nil
//#UC END# *508F91A5032C_508EBD7703BF_impl*
end;//TnscTasksPanelHideField.Subscribe

procedure TnscTasksPanelHideField.UpdateCaption;
//#UC START# *508F91D100B8_508EBD7703BF_var*
//#UC END# *508F91D100B8_508EBD7703BF_var*
begin
//#UC START# *508F91D100B8_508EBD7703BF_impl*
 {$IfDef nscTasksPanelShowPosition}
  CCaption := vcmCat(vcmCat(Group.RepGroup.Caption, ' ('), IntToStr(Group.Position) + ')');
 {$Else nscTasksPanelShowPosition}
 CCaption := Group.RepGroup.Caption;
 {$EndIf nscTasksPanelShowPosition}

 {$IfDef HideFieldVgSceneStyle}
 RefreshContent;
 {$EndIf HideFieldVgSceneStyle}
//#UC END# *508F91D100B8_508EBD7703BF_impl*
end;//TnscTasksPanelHideField.UpdateCaption

constructor TnscTasksPanelHideField.Create(AOwner: TComponent;
 const aGroup: IvcmCustOpsGroup);
//#UC START# *508F96B20262_508EBD7703BF_var*
//#UC END# *508F96B20262_508EBD7703BF_var*
begin
//#UC START# *508F96B20262_508EBD7703BF_impl*
 inherited Create(AOwner);
 Assert(AOwner is TnscCustomTasksPanelView);
 View := TnscCustomTasksPanelView(AOwner);
 TasksPanel := View.TasksPanel;
 Group := aGroup;
{$If not defined(DesignTimeLibrary)}
 Settings := afw.Settings;
{$IfEnd}
 Subscribe(true);
{$IfDef HideFieldVgSceneStyle}
 f_HeaderBackGround := TvgBackGround.Create(Self);
 with f_HeaderBackGround do
 begin
  Align := vaClient;
  Fill.Style := vgBrushSolid;
 end;//with f_HeaderBackGround
 f_HeaderScene := TvgScene.Create(Self);
 with f_HeaderScene do
 begin
  //http://mdp.garant.ru/pages/viewpage.action?pageId=508187704
  RecreateCanvas := True;
  Parent := Self;
  AddObject(f_HeaderBackGround);
  Align := alTop;
  ActivateWindowOnClick := True;
 end;//with f_HeaderScene
 f_HeaderRectangle := TvgRectangle.Create(Self);
 with f_HeaderRectangle do
 begin
  Parent := f_HeaderBackGround;
  Fill.Style := vgBrushGradient;
  Fill.Gradient.Style := vgLinearGradient;
  Fill.Gradient.StartPosition.Point := vgPoint(0, 0.5);
  Fill.Gradient.StopPosition.Point := vgPoint(1, 0.5);
  if Fill.Gradient.Points.Count = 2 then
  begin
   with TvgGradientPoint(Fill.Gradient.Points[0]) do
   begin
    Color := '#FF545DF5';
   end;
   with TvgGradientPoint(Fill.Gradient.Points[1]) do
   begin
    Color := '#FFFFFFFF';
    Offset := 1;
   end;
  end;
  Stroke.Style := vgBrushNone;
  xRadius := 5;
  yRadius := 5;
  HitTest := True;
  Corners := [vgCornerBottomLeft, vgCornerBottomRight];
  Sides   := [vgSideTop, vgSideLeft, vgSideBottom, vgSideRight];
  OnClick := DoOnClick;
 end;//with f_HeaderRectangle
 f_HeaderText := TvgText.Create(Self);
 with f_HeaderText do
 begin
  Parent := f_HeaderRectangle;
  Align := vaLeft;
  AutoSize := True;
  WordWrap := False;
  OnClick := DoOnClick;
 end;//with f_HeaderText
 f_HeaderPanel := TvtPanel.Create(Self);
 with f_HeaderPanel do
 begin
  Parent := Self;
  Align := alNone;
  BevelOuter := bvNone;
 end;//with f_HeaderPanel
 f_HeaderSpeedButton := TvtSpeedButton.Create(Self);
 with f_HeaderSpeedButton do
 begin
  Parent := f_HeaderPanel;
  Align := alClient;
  OnClick := DoOnClick;
 end;//with f_HeaderSpeedButton
 f_HeaderNonVGLayout := TvgNonVGLayout.Create(Self);
 with f_HeaderNonVGLayout do
 begin
  Parent := f_HeaderRectangle;
  Align := vaTopRight;
  NonVGControl := f_HeaderPanel;
 end;//with f_HeaderNonVGLayout
{$EndIf HideFieldVgSceneStyle}

 UpdateCaption;
 // Требования запроса CQ: OIT5-25324:
 CaptionIndent := c_CaptionIndent;
 BeforeClientSpace := c_TopClientIndent;
//#UC END# *508F96B20262_508EBD7703BF_impl*
end;//TnscTasksPanelHideField.Create

procedure TnscTasksPanelHideField.AFWCMTextChanged(var aMsg: TMessage);
//#UC START# *5492D70402F7_508EBD7703BF_var*
//#UC END# *5492D70402F7_508EBD7703BF_var*
begin
//#UC START# *5492D70402F7_508EBD7703BF_impl*
 inherited;
 {$IfDef HideFieldVgSceneStyle}
 RefreshContent;
 {$EndIf}
//#UC END# *5492D70402F7_508EBD7703BF_impl*
end;//TnscTasksPanelHideField.AFWCMTextChanged

procedure TnscTasksPanelHideField.Notify(const aNotifier: Il3ChangeNotifier;
 aOperation: Integer;
 aIndex: Integer);
 {* прошла операция. }
//#UC START# *46A4504B03C4_508EBD7703BF_var*
//#UC END# *46A4504B03C4_508EBD7703BF_var*
begin
//#UC START# *46A4504B03C4_508EBD7703BF_impl*
 case TvcmTaskPanelOperation(aOperation) of
  cvcm_tpGroupRemove:
  begin
   if (Group <> nil) then
    Group.As_Il3ChangeNotifier.Unsubscribe(Il3ItemNotifyRecipient(Self));
   View.RemoveGroup(Self);
  end;
  cvcm_tpGroupCaptionChanged: CCaption := Group.RepGroup.Caption;
  cvcm_tpGroupPosChanged:
  begin
   View.SortGroups;
   UpdateCaption;
  end;
  cvcm_tpAfterUpdate:
  begin
   {$IfNDef DesignTimeLibrary}
   SaveSettings;
   {$EndIf}
    // - сохраним развернутость группы для текущего прецедента;
   SettingId := MakeSettingFromTasksPanel;
    // - прочитаем развернутость для нового прецедента;
  end;//if aOperation = cvcm_tpUpdated then
 end;
//#UC END# *46A4504B03C4_508EBD7703BF_impl*
end;//TnscTasksPanelHideField.Notify

procedure TnscTasksPanelHideField.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_508EBD7703BF_var*
//#UC END# *479731C50290_508EBD7703BF_var*
begin
//#UC START# *479731C50290_508EBD7703BF_impl*
 {$IfNDef DesignTimeLibrary}
 SaveSettings;
 {$EndIf}
 Subscribe(False);
 TasksPanel := nil;
 Group := nil;
 {$IfDef HideFieldVgSceneStyle}
 l3Free(f_HeaderSpeedButton);
 l3Free(f_HeaderPanel);
 l3Free(f_HeaderNonVGLayout);
 l3Free(f_HeaderText);
 l3Free(f_HeaderRectangle);
 l3Free(f_HeaderBackGround);
 l3Free(f_HeaderScene);
 {$EndIf HideFieldVgSceneStyle}
 inherited;
//#UC END# *479731C50290_508EBD7703BF_impl*
end;//TnscTasksPanelHideField.Cleanup

procedure TnscTasksPanelHideField.Paint(const CN: Il3Canvas);
 {* процедура рисования внешнего вида управляющего элемента }
//#UC START# *48C6C044025E_508EBD7703BF_var*
//#UC END# *48C6C044025E_508EBD7703BF_var*
begin
//#UC START# *48C6C044025E_508EBD7703BF_impl*
 {$IfDef HideFieldVgSceneStyle}
 with f_HeaderRectangle do
  if Focused then
  begin
   Stroke.Color := vgColorToStr(vgColorFromVCL(cGarant2011KZBorderColor));
   StrokeThickness := 2;
  end
  else
  begin
   Stroke.Color := '#FFC0C0C0';
   StrokeThickness := 1;
  end;
 // родительский .Paint() специально не вызывается для HideFieldVgSceneStyle
 {$else}
 inherited;
 {$EndIf HideFieldVgSceneStyle}
//#UC END# *48C6C044025E_508EBD7703BF_impl*
end;//TnscTasksPanelHideField.Paint

{$If NOT Defined(NoVCL)}
procedure TnscTasksPanelHideField.SetParent(AParent: TWinControl);
//#UC START# *4A97E78202FC_508EBD7703BF_var*
//#UC END# *4A97E78202FC_508EBD7703BF_var*
begin
//#UC START# *4A97E78202FC_508EBD7703BF_impl*
 inherited;
 if AParent <> nil then
  SettingId := MakeSettingFromTasksPanel;
//#UC END# *4A97E78202FC_508EBD7703BF_impl*
end;//TnscTasksPanelHideField.SetParent
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TnscTasksPanelHideField.Resize;
//#UC START# *4CC8417A0288_508EBD7703BF_var*
//#UC END# *4CC8417A0288_508EBD7703BF_var*
begin
//#UC START# *4CC8417A0288_508EBD7703BF_impl*
 inherited;
 {$IfDef HideFieldVgSceneStyle}
 RefreshContent;
 {$EndIf HideFieldVgSceneStyle}
//#UC END# *4CC8417A0288_508EBD7703BF_impl*
end;//TnscTasksPanelHideField.Resize
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TnscTasksPanelHideField.AdjustClientRect(var Rect: TRect);
//#UC START# *508F957E0283_508EBD7703BF_var*
//#UC END# *508F957E0283_508EBD7703BF_var*
begin
//#UC START# *508F957E0283_508EBD7703BF_impl*
 inherited;
 Rect.Top := ClientRect.Top;
//#UC END# *508F957E0283_508EBD7703BF_impl*
end;//TnscTasksPanelHideField.AdjustClientRect
{$IfEnd} // NOT Defined(NoVCL)

procedure TnscTasksPanelHideField.DoStateChanged;
//#UC START# *508F96700139_508EBD7703BF_var*
//#UC END# *508F96700139_508EBD7703BF_var*
begin
//#UC START# *508F96700139_508EBD7703BF_impl*
 inherited;
 {$IfDef HideFieldVgSceneStyle}
 SetBitmapButton;
 {$EndIf HideFieldVgSceneStyle}
//#UC END# *508F96700139_508EBD7703BF_impl*
end;//TnscTasksPanelHideField.DoStateChanged

procedure TnscTasksPanelHideField.DoStyleTableChanged;
//#UC START# *51124356016F_508EBD7703BF_var*
var
 l_Font: TFont;
//#UC END# *51124356016F_508EBD7703BF_var*
begin
//#UC START# *51124356016F_508EBD7703BF_impl*
 l_Font := TFont.Create;
 try
  evGetDefaultFont(l_Font);
  Self.Font.Size := Succ(l_Font.Size);
   // - размер шрифта заголовка на кегль отличается от основного
   //   (CQ: OIT5-25051); 
 finally
  FreeAndNil(l_Font);
 end;//try..finally
//#UC END# *51124356016F_508EBD7703BF_impl*
end;//TnscTasksPanelHideField.DoStyleTableChanged

procedure TnscTasksPanelHideField.HideControl;
//#UC START# *5295F76F02C5_508EBD7703BF_var*
//#UC END# *5295F76F02C5_508EBD7703BF_var*
begin
//#UC START# *5295F76F02C5_508EBD7703BF_impl*
 // попробуем не скрывать контрол
 //http://mdp.garant.ru/pages/viewpage.action?pageId=505436427
//#UC END# *5295F76F02C5_508EBD7703BF_impl*
end;//TnscTasksPanelHideField.HideControl

procedure TnscTasksPanelHideField.ClearFields;
begin
 Group := nil;
 TasksPanel := nil;
 inherited;
end;//TnscTasksPanelHideField.ClearFields

function TnscTasksPanelTreeView.pm_GetPopupMenu: TvcmPopupMenuPrim;
//#UC START# *508F7DD70004_508EBD870312get_var*
//#UC END# *508F7DD70004_508EBD870312get_var*
begin
//#UC START# *508F7DD70004_508EBD870312get_impl*
 if f_PopupMenu = nil then
  f_PopupMenu := TvcmPopupMenuPrim.Create(Self);
 Result := f_PopupMenu;
//#UC END# *508F7DD70004_508EBD870312get_impl*
end;//TnscTasksPanelTreeView.pm_GetPopupMenu

procedure TnscTasksPanelTreeView.AddOp(const aOp: IvcmCustOpsGroupOperation);
//#UC START# *508F7E6E004B_508EBD870312_var*
var
 l_Root: Il3Node;
 l_Op: TnscTasksPanelOperationNode;
//#UC END# *508F7E6E004B_508EBD870312_var*
begin
//#UC START# *508F7E6E004B_508EBD870312_impl*
 if Supports(TreeStruct.RootNode, Il3Node, l_Root) then
 try
  l_Op := TnscTasksPanelOperationNode.Create(aOp);
  try
   l_Op.Link := TnscTasksPanelActionLink.Create(l_Op.Op.RepOp.Action, Self, l_Op);
   l_Root.InsertChild(l_Op);
  finally
   l3Free(l_Op);
  end;//try..finally
 finally
  l_Root := nil;
 end;//try..finally
//#UC END# *508F7E6E004B_508EBD870312_impl*
end;//TnscTasksPanelTreeView.AddOp

procedure TnscTasksPanelTreeView.AddOps;
//#UC START# *508F7E8400C4_508EBD870312_var*
var
 l_Iterator: IvcmCustOpsGroupOperationsIterator;
 l_Op: IvcmCustOpsGroupOperation;
//#UC END# *508F7E8400C4_508EBD870312_var*
begin
//#UC START# *508F7E8400C4_508EBD870312_impl*
 l_Iterator := Group.Operations;
 if (l_Iterator <> nil) then
  try
   l_Op := l_Iterator.Next;
   while l_Op <> nil do
   begin
    AddOp(l_Op);
    l_Op := l_Iterator.Next;
   end;//while l_Op <> nil do
   SortChilds;
  finally
   l_Iterator := nil;
  end;//try..finally
//#UC END# *508F7E8400C4_508EBD870312_impl*
end;//TnscTasksPanelTreeView.AddOps

procedure TnscTasksPanelTreeView.SortChilds;
//#UC START# *508F7E930197_508EBD870312_var*
var
 l_Root: Il3Node;
//#UC END# *508F7E930197_508EBD870312_var*
begin
//#UC START# *508F7E930197_508EBD870312_impl*
 if Supports(TreeStruct.RootNode, Il3Node, l_Root) then
 try
  l_Root.SortChilds;
 finally
  l_Root := nil;
 end;//try..finally
//#UC END# *508F7E930197_508EBD870312_impl*
end;//TnscTasksPanelTreeView.SortChilds

function TnscTasksPanelTreeView.ItemAction(aItemIndex: Integer): TCustomAction;
//#UC START# *508F7EA501A1_508EBD870312_var*
var
 l_Op: InscOperationNode;
//#UC END# *508F7EA501A1_508EBD870312_var*
begin
//#UC START# *508F7EA501A1_508EBD870312_impl*
 if Supports(GetNode(aItemIndex), InscOperationNode, l_Op) then
 try
  Result := l_Op.Op.RepOp.Action;
 finally
  l_Op := nil;
 end//try..finally
 else
  Result := nil;
//#UC END# *508F7EA501A1_508EBD870312_impl*
end;//TnscTasksPanelTreeView.ItemAction

function TnscTasksPanelTreeView.DoOnGetCursor(aSender: TObject;
 aIndex: Integer): TCursor;
//#UC START# *508F7FED005E_508EBD870312_var*
//#UC END# *508F7FED005E_508EBD870312_var*
begin
//#UC START# *508F7FED005E_508EBD870312_impl*
 if ItemAction(aIndex).Enabled
  then Result := crHandPoint
  else Result := crDefault;
//#UC END# *508F7FED005E_508EBD870312_impl*
end;//TnscTasksPanelTreeView.DoOnGetCursor

constructor TnscTasksPanelTreeView.Create(AOwner: TComponent;
 const aGroup: IvcmCustOpsGroup);
//#UC START# *50913263038F_508EBD870312_var*
//#UC END# *50913263038F_508EBD870312_var*
begin
//#UC START# *50913263038F_508EBD870312_impl*
 inherited Create(AOwner);
 Assert(AOwner is TnscCustomTasksPanelView);
 View := TnscCustomTasksPanelView(AOwner);
 Group := aGroup;
 if (Group <> nil) then
  Group.As_Il3ChangeNotifier.Subscribe(IvcmTaskPanelNotifyRecipient(Self));
 f_CursorItem := -1;
 ControlStyle := ControlStyle + [csActionClient];
 OnGetItemCursor := DoOnGetCursor;
{$If not defined(DesignTimeLibrary)}
 Settings := afw.Settings;
{$IfEnd} 
 BorderStyle := bsNone;
 ActionElementMode := l3_amSingleClick;
 ViewOptions := ViewOptions - [voShowLines];
 ViewOptions := ViewOptions + [voShowInterRowSpace];
//#UC END# *50913263038F_508EBD870312_impl*
end;//TnscTasksPanelTreeView.Create

{$If NOT Defined(NoVCM)}
procedure TnscTasksPanelTreeView.TaskPanelNotify(const aNotifier: Il3ChangeNotifier;
 aOperation: TvcmTaskPanelOperation;
 const aInterface: IvcmCustOpsItem);
 {* прошла операция. }
//#UC START# *46A450C703AE_508EBD870312_var*
var
 l_Op: IvcmCustOpsGroupOperation;
//#UC END# *46A450C703AE_508EBD870312_var*
begin
//#UC START# *46A450C703AE_508EBD870312_impl*
 if (aOperation = cvcm_tpOperationAdded) and
  Supports(aInterface, IvcmCustOpsGroupOperation, l_Op) then
 try
  AddOp(l_Op);
  SortChilds;
 finally
  l_Op := nil;
 end;//try..finally
//#UC END# *46A450C703AE_508EBD870312_impl*
end;//TnscTasksPanelTreeView.TaskPanelNotify
{$IfEnd} // NOT Defined(NoVCM)

procedure TnscTasksPanelTreeView.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_508EBD870312_var*
//#UC END# *479731C50290_508EBD870312_var*
begin
//#UC START# *479731C50290_508EBD870312_impl*
 if (Group <> nil) then
  Group.As_Il3ChangeNotifier.Unsubscribe(IvcmTaskPanelNotifyRecipient(Self));
 Group := nil;
 inherited;
//#UC END# *479731C50290_508EBD870312_impl*
end;//TnscTasksPanelTreeView.Cleanup

{$If NOT Defined(NoVCL)}
procedure TnscTasksPanelTreeView.SetParent(AParent: TWinControl);
//#UC START# *4F71E1460089_508EBD870312_var*
//#UC END# *4F71E1460089_508EBD870312_var*
begin
//#UC START# *4F71E1460089_508EBD870312_impl*
 inherited;
 if AParent <> nil then
 begin
  TreeStruct.RootNode := TnscTasksPanelRootNode.Make;
  AddOps;
 end;//if AParent then
//#UC END# *4F71E1460089_508EBD870312_impl*
end;//TnscTasksPanelTreeView.SetParent
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TnscTasksPanelTreeView.InitiateAction;
//#UC START# *4F884F39020F_508EBD870312_var*
 function lp_IteratorFunc(const aNode: Il3Node): Boolean;
 var
  l_Op: InscOperationNode;
 begin
  Result := False;
  if Supports(aNode, InscOperationNode, l_Op) then
  try
   l_Op.Op.RepOp.Action.Update;
  finally
   l_Op := nil;
  end;//try..finally
 end;//lp_IteratorFunc

var
 l_Root: Il3Node;
//#UC END# *4F884F39020F_508EBD870312_var*
begin
//#UC START# *4F884F39020F_508EBD870312_impl*
 inherited;
 if Supports(TreeStruct.RootNode, Il3Node, l_Root) then
 try
  l_Root.IterateF(l3L2NA(@lp_IteratorFunc));
 finally
  l_Root := nil;
 end;//try..finally
//#UC END# *4F884F39020F_508EBD870312_impl*
end;//TnscTasksPanelTreeView.InitiateAction
{$IfEnd} // NOT Defined(NoVCL)

function TnscTasksPanelTreeView.DoIsCommandPublished(Cmd: Tl3OperationCode): Boolean;
//#UC START# *508F7F930094_508EBD870312_var*
//#UC END# *508F7F930094_508EBD870312_var*
begin
//#UC START# *508F7F930094_508EBD870312_impl*
 Result := inherited DoIsCommandPublished(Cmd);
 if not Result then
  Result := Cmd in [ccTreeAllExpand, ccAllSelect, ccAllDeselect];
   // - компонент создается динамически по причине чего регистрация операций не
   //   производится и соответственно в предке значение f_Published будет False,
   //   а нам нужно запретить использование этих команд компонентом. Возможно
   //   если бы операции должны быть показаны на компоненте стоило бы сделать
   //   так чтобы операции регистрировались и для компонентов в RunTime;
//#UC END# *508F7F930094_508EBD870312_impl*
end;//TnscTasksPanelTreeView.DoIsCommandPublished

function TnscTasksPanelTreeView.DoOnGetItemImageIndex(aItemIndex: LongInt;
 var aImages: TCustomImageList): Integer;
//#UC START# *508F81110075_508EBD870312_var*
//#UC END# *508F81110075_508EBD870312_var*
begin
//#UC START# *508F81110075_508EBD870312_impl*
 Result := inherited DoOnGetItemImageIndex(aItemIndex, aImages);
 if Result = vtItemWithoutImage then
  with ItemAction(aItemIndex) do
   if ImageIndex <> -1 then
    Result := ImageIndex;
//#UC END# *508F81110075_508EBD870312_impl*
end;//TnscTasksPanelTreeView.DoOnGetItemImageIndex

procedure TnscTasksPanelTreeView.DoOnActionElement(Index: LongInt);
//#UC START# *508F81C1004D_508EBD870312_var*
 procedure lp_BuildAndShowPopupMenu(const aOp: InscOperationNode;
                                    aType: TvcmOperationType);
 var
  l_Point: TPoint;
  l_MenuItem: TMenuItem;
  l_Action: IvcmAction;
  l_Height: Integer;
 begin
  // Очистим меню, оно одно на панель задач:
  PopupMenu.Items.Clear;
  Assert(aOp.Op.RepOp.Action is TvcmAction);
  // Построим меню:
  vcmMakeComboMenu(TvcmAction(aOp.Op.RepOp.Action),
                   PopupMenu.Items,
                   True,
                   vcmMenuItemClassByOpType(aType));
  if PopupMenu.Items.Count > 0 then
  begin
   if Supports(aOp.Op.RepOp.Action, IvcmAction, l_Action) then
    l_MenuItem := PopupMenu.Items.Find(vcmStr(l_Action.SelectedString))
   else
    l_MenuItem := PopupMenu.Items.Find(aOp.Op.RepOp.Action.Caption);
   if (l_MenuItem <> nil) and l_MenuItem.RadioItem then
    l_MenuItem.Checked := True;
   // Покажем список под элементом:
   with GetDrawRect(Index) do
   begin
    l_Point := ClientToScreen(Point(Left, Bottom));
    l_Height := Bottom - Top;
   end;
   with l_Point do
    PopupMenu.Popup(X + GetItemTextIndent(Index, l_Height), Y);
  end;//if PopupMenu.Items.Count > 0 then
 end;//lp_BuildAndShowPopupMenu

 function lp_SelectDate(const anAction: IvcmAction;
                        const anOpDef: IvcmOperationDef): Boolean;
 var
  l_Date: Il3CString;
 begin
  l_Date := vcmSelectDate(anOpDef.Caption, anAction.SelectedString);
  Result := not l3IsNil(l_Date);
  if Result then
   anAction.SelectedString := l_Date;
 end;//lp_SelectDate

 procedure lp_ExecuteAction(const anAction: IvcmAction;
                            aLockUpdate: Boolean);
 begin
  if aLockUpdate then
   anAction.LockUpdate;
  try
   anAction.Execute;
  finally
   if aLockUpdate then
    anAction.UnlockUpdate;
  end;//try..finally
 end;//lp_ExecuteAction

var
 l_Op: InscOperationNode;
 l_OpDef: IvcmOperationDef;
 l_Action: IvcmAction;
 l_LockUpdate: Boolean;
//#UC END# *508F81C1004D_508EBD870312_var*
begin
//#UC START# *508F81C1004D_508EBD870312_impl*
 inherited;
 l_LockUpdate := False;
 // Операция доступна для выполнения:
 if Supports(GetNode(Index), InscOperationNode, l_Op) and
  l_Op.Op.RepOp.Action.Enabled then
 try
  View.DoOperationExecute;
  if Supports(l_Op.Op.RepOp.Action, IvcmAction, l_Action) then
  try
   if Supports(l_Op.Op.RepOp, IvcmOperationDef, l_OpDef) then
   try
    // Операции с выпадающим списком:
    if (l_OpDef.OperationType in c_ComboOperations) then
    begin
     // Если меню будет показано, то выполнять Action не нужно:
     if l_Action.HasInfoForCombo then
     begin
      lp_BuildAndShowPopupMenu(l_Op, l_OpDef.OperationType);
      Exit;
     end;
    end//if Supports(l_Op.Op.RepOp, IvcmOperationDef
    else
     // Операция типа календарная дата:
     if l_OpDef.OperationType = vcm_otDate then
     begin
      if not lp_SelectDate(l_Action, l_OpDef) then
       Exit
      else
       l_LockUpdate := True;
     end;//if l_OpDef.OperationType = vcm_otDate then
   finally
    l_OpDef := nil;
   end;//try..finally
   lp_ExecuteAction(l_Action, l_LockUpdate);
  finally
   l_Action := nil;
  end;//try..finally
 finally
  l_Op := nil;
 end;//try..finally
//#UC END# *508F81C1004D_508EBD870312_impl*
end;//TnscTasksPanelTreeView.DoOnActionElement

procedure TnscTasksPanelTreeView.DoOnGetItemStyle(aItemIndex: Integer;
 const aFont: Il3Font;
 var aTextBackColor: TColor;
 var aItemBackColor: TColor;
 var aVJustify: TvtVJustify;
 var aFocused: Boolean;
 var theImageVertOffset: Integer);
//#UC START# *508F825303E4_508EBD870312_var*
var
 l_Op: InscOperationNode;
 l_Focused: Boolean;
//#UC END# *508F825303E4_508EBD870312_var*
begin
//#UC START# *508F825303E4_508EBD870312_impl*
 inherited;
 l_Focused := Focused;
 if not l_Focused then
  aTextBackColor := Self.Color;
 // Для текущего выделенного в активном дереве не меняем цветовую схему:
 if not (l_Focused and (aItemIndex = Current)) then
  if Supports(GetNode(aItemIndex), InscOperationNode, l_Op) then
  try
   if ItemAction(aItemIndex).Enabled then
    aFont.ForeColor := Font.Color
   else
    aFont.ForeColor := clGray;
  finally
   l_Op := nil;
  end;//try..finally
//#UC END# *508F825303E4_508EBD870312_impl*
end;//TnscTasksPanelTreeView.DoOnGetItemStyle

procedure TnscTasksPanelTreeView.DoOnGetItemImageState(const aItemIndex: LongInt;
 var aEnabled: Boolean);
//#UC START# *508F83890058_508EBD870312_var*
//#UC END# *508F83890058_508EBD870312_var*
begin
//#UC START# *508F83890058_508EBD870312_impl*
 aEnabled := ItemAction(aItemIndex).Enabled;
//#UC END# *508F83890058_508EBD870312_impl*
end;//TnscTasksPanelTreeView.DoOnGetItemImageState

procedure TnscTasksPanelTreeView.ClearFields;
begin
 Group := nil;
 inherited;
end;//TnscTasksPanelTreeView.ClearFields

//#UC START# *4D3424C203C2impl*
//#UC END# *4D3424C203C2impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscCustomTasksPanelView);
 {* Регистрация TnscCustomTasksPanelView }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscTasksPanelHideField);
 {* Регистрация TnscTasksPanelHideField }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscTasksPanelTreeView);
 {* Регистрация TnscTasksPanelTreeView }
{$IfEnd} // NOT Defined(NoScripts)
//#UC START# *54D50DBA0137*
 {$IfNDef NoScripts}
 {$If not defined(NoVCM)}
 TtfwClassRef.Register(TnscTasksPanelHideField);
 TtfwClassRef.Register(TnscTasksPanelTreeView);
 {$IfEnd}
 {$EndIf}
//#UC END# *54D50DBA0137*
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscTasksPanelView);
 {* Регистрация TnscTasksPanelView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
