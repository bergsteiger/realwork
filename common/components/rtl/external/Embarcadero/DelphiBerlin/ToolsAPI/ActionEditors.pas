{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit ActionEditors;

// In this module, are editors for action. Code moved from VCLEditors
interface

uses System.Types, System.SysUtils, System.Classes, System.Actions, System.Generics.Collections,
  DesignIntf, DesignEditors, Vcl.Graphics, Vcl.ImgList, Vcl.Menus, Vcl.ComCtrls, Vcl.Controls;

type
{$REGION 'The interaction of action with an IDE. This new code'}

  /// <summary>
  ///  This class is designed to interact actions and surface of form in IDE.
  ///  The implementation of the methods implemented in inheritors
  /// </summary>
  TIDEActions = class
  public
    /// <summary>
    ///  This procedure should give some specific properties, such as: ImageIndex.
    /// </summary>
    class procedure AssignAction(Source, Destination: TBasicAction); virtual;
    class function CreateImageLink(const OnChanged: TNotifyEvent): TObject; virtual;
    /// <summary>
    ///  This procedure create and retrive ImageList with a symbolic image of action to show in the IDE.
    /// </summary>
    class function CreateImageList(ActionList: TContainedActionList): TCustomImageList; virtual;
    /// <summary>
    ///  Class action created by default when you select menu item "New Action"
    /// </summary>
    class function DefaultActionClass: TContainedActionClass; virtual;
    /// <summary>
    ///  The base class of actions that are added to the combobox of available actions in the IDE.
    /// </summary>
    class function BaseActionClass: TContainedActionClass; virtual;
    /// <summary>
    ///  The base class of actions that are added to the combobox of available actions lists in the IDE.
    /// </summary>
    class function BaseActionListClass: TContainedActionListClass; virtual;
    /// <summary>
    ///  This procedure is to create and fill bitmaps with a symbolic image of new action to add in TImageList
    /// </summary>
    class procedure CopyImageIfAvailable(const NewAction: TContainedAction;
      const ActionList: TContainedActionList); virtual;
    /// <summary>
    ///  This procedure registered changes in TImageList
    /// </summary>
    class procedure RegisterImageLink(const ActionList: TContainedActionList; const ImageLink: TObject); virtual;
    /// <summary>
    ///  This procedure unregistered changes in TImageList
    /// </summary>
    class procedure UnregisterImageLink(const ActionList: TContainedActionList; const ImageLink: TObject); virtual;
  end;

  TIDEActionsClass = class of TIDEActions;

/// <summary>
/// You can edit the module is not currently of selected project. The function returns the framework of the current module being edited.
/// </summary>
function GetFrameworkType: string;
/// <summary>
///  Adds a class to communicate with the IDE, for a specified framework.
///  If a specified framework has already been registered class, then raised an exception.
/// To cancel this registration, use the procedure <see cref="UnregisterActionsInFramework"/>
/// </summary>
/// <param name="FrameworkType">
///  The name of the framework. For example <c>'VCL'</c>, <c>'FMX'</c>
/// </param>
/// <param name="AIDEActions">
///  The class that is implemented for each platform, it provides
///  the interaction of action with an IDE.
/// </param>
procedure RegisterActionsInFramework(const FrameworkType: string;
                                     const AIDEActions: TIDEActionsClass);
/// <summary>
/// This procedure unregisters a class, performed by the procedure of <see cref="RegisterActionsInFramework"/>.
/// </summary>
/// <param name="FrameworkType">
/// Name of framework (<c>FMX</c>, <c>VCL</c>)
/// </param>
procedure UnregisterActionsInFramework(const FrameworkType: string);
/// <summary>
///  Search a class for interacting action with the IDE, by name of framework.
/// <param name="FrameworkType">
///  Name of framework
/// </param>
/// </summary>
/// <returns>
///   The registered class for framework.
///   If neither of class is not registered, or the name is not specified,
///   returns <see cref="vOldIDEActions"/>. If among the registered classes
///   is not appropriate, it returns <c>nil</c>.
/// </returns>
function GetIDEActions(const FrameworkType: string): TIDEActionsClass; overload;
/// <summary>
///  Search a class for interacting action with the IDE, by list of actions
/// </summary>
/// <param name="ActionList">
///  The list of actions for which is determined by the framework.
///  If <c>nil</c>, is used function <see cref="GetFrameworkType"/> to determine the framework
///  and <see cref="GetIDEActions"/> for sherch by FrameworkType
/// </param>
/// <param name="FrameworkType">
///  Name of framework
/// </param>
/// <returns>
///   The registered class for framework
/// </returns>
function GetIDEActions(const ActionList: TContainedActionList;
                         var FrameworkType: string): TIDEActionsClass; overload;
function GetIDEActionsList(List: TStringList): integer;


var
/// <summary>
///   This global variable that contains a class of TIDEActions in VCL.
///   if trimed input param <c>FrameworkType</c> is empty, then used this value
///   for compatibility with older applications.
///   <para>see <see cref = "CreateAction"/>, <see cref = "EnumRegisteredActions"/>, <see cref = "GetIDEActions"/></para>
/// </summary>
    vOldIDEActions: TIDEActionsClass;

{$ENDREGION}
{$REGION 'TActionListView. This code moved from VclEditors'}
type
{ TActionListView }
  TNewActionEvent = procedure(Sender: TObject; const Category: string;
    ActionClass: TContainedActionClass; ActionList: TContainedActionList) of object;
  TSelectActionEvent = procedure(Sender: TObject; Action: TContainedAction) of object;

  TActionListView = class(TCustomListView)
  private const
    FDefItemHeight = 17;
  private
    FActionList: TContainedActionList;
    FDesigner: IDesigner;
    FImageList: TImageList;
    FNewActnPopupMenu: TPopupMenu;
    FNewStdActnPopupMenu: TPopupMenu;
    FStdActionList: TStrings;
    FTempStringList: TStrings;
    FIDEActions: TIDEActionsClass;
    FFrameworkType: string;
    FOnNewAction: TNewActionEvent;
    FOnSelectAction: TSelectActionEvent;
    FMsg: string;
    procedure AddStdAction(const Category: string; ActionClass: TBasicActionClass; Info: Pointer);
    procedure AddTempString(const S: string);
    function CreateMenuItem(const Caption: string; Event: TNotifyEvent; CustomData: Pointer)
      : TMenuItem;
    procedure DoNewActionClick(Sender: TObject);
    procedure DoNewStdActionClick(Sender: TObject);
    procedure RebuildListView;
    procedure RebuildPopupMenus;
    procedure SetDesigner(const Value: IDesigner);
    procedure ShowPopupMenu(Item: TListItem; PopupMenu: TPopupMenu);
    procedure DoShowMsg(Sender: TObject);
  protected
    procedure CreateWnd; override;
    function CustomDrawItem(Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage)
      : Boolean; override;
    function IsCustomDrawn(Target: TCustomDrawTarget; Stage: TCustomDrawStage): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
    property Designer: IDesigner read FDesigner write SetDesigner;
    property OnNewAction: TNewActionEvent read FOnNewAction write FOnNewAction;
    property OnSelectAction: TSelectActionEvent read FOnSelectAction write FOnSelectAction;
  end;
{$ENDREGION}
{$REGION 'TActionProperty. This code moved from VclEditors'}
{ TActionProperty }

  TActionProperty = class(TComponentProperty, IProperty80)
  private type
    TRegisteredAction = record
      Category: string;
      ActionClass: TBasicActionClass
    end;
  private
    FActionListView: TActionListView;
    FHost: IPropertyHost;
    FRegisteredActionList: TList<TRegisteredAction>;
    procedure CreateNewAction(Sender: TObject; const Category: string;
      ActionClass: TContainedActionClass; ActionList: TContainedActionList);
    procedure SelectAction(Sender: TObject; Action: TContainedAction);
    procedure AddAction(const Category: string; ActionClass: TBasicActionClass; Info: Pointer);
  public
    destructor Destroy; override;
    // IProperty80
    procedure Edit(const Host: IPropertyHost; DblClick: Boolean); reintroduce; overload;
    function GetAttributes: TPropertyAttributes; override;
  end;
{$ENDREGION}
{$REGION 'Action Registration. This code moved from VclEditors'}

type

  TNotifyActionListChange = procedure;

var
  NotifyActionListChange: TNotifyActionListChange = nil;

  procedure RegActions(const ACategory: string;
                       const AClasses: array of TBasicActionClass;
                             AResource: TComponentClass);
  procedure UnRegActions(const Classes: array of TBasicActionClass);
  procedure EnumActions(Proc: TEnumActionProc;
                        Info: Pointer;
                        const FrameworkType: string);
  function CreateAction(AOwner: TComponent;
                        ActionClass: TBasicActionClass;
                        const FrameworkType: string): TBasicAction;
{$ENDREGION}

function GetNewActionName(const Action: TBasicAction;
                          const FrameworkType: string): string;

implementation

uses System.RTLConsts, System.Math, System.TypInfo, ToolsAPI,
  DsnConst, DesignConst, ComponentDesigner, Winapi.Windows, Winapi.UxTheme,
  Vcl.GraphUtil, Vcl.Themes, Vcl.Forms, Vcl.Dialogs;

var vGetIDEActions: TStringList;

{$REGION 'TActionListView. This code moved from VclEditors'}
{ TActionListView }

constructor TActionListView.Create(AOwner: TComponent);
begin
  inherited;
  FFrameworkType := GetFrameworkType;
  FIDEActions := GetIDEActions(FFrameworkType);
  FImageList := TImageList.Create(nil);
  FNewActnPopupMenu := TPopupMenu.Create(nil);
  FNewStdActnPopupMenu := TPopupMenu.Create(nil);
  FTempStringList := TStringList.Create;
  BorderStyle := bsNone;
  Columns.Add;
  Height := FDefItemHeight;
  ReadOnly := True;
  RowSelect := True;
  ShowColumnHeaders := False;
  SmallImages := FImageList;
  ViewStyle := vsReport;
  Width := 200;
end;

destructor TActionListView.Destroy;
begin
  FreeAndNil(FImageList);
  FreeAndNil(FNewActnPopupMenu);
  FreeAndNil(FNewStdActnPopupMenu);
  FreeAndNil(FTempStringList);
  inherited;
end;

procedure TActionListView.AddStdAction(const Category: string; ActionClass: TBasicActionClass;
  Info: Pointer);
var
  I: integer;
  LCategory: string;
  List: TList<TBasicActionClass>;
begin
  if Category <> '' then
    LCategory := Category
  else
    LCategory := SActionCategoryNone;

  I := FStdActionList.IndexOf(LCategory);
  if I = -1 then
  begin
    List := TList<TBasicActionClass>.Create;
    List.Add(ActionClass);
    FStdActionList.AddObject(LCategory, List);
  end
  else
  begin
    List := TList<TBasicActionClass>(FStdActionList.Objects[I]);
    List.Add(ActionClass);
  end;
end;

procedure TActionListView.AddTempString(const S: string);
begin
  FTempStringList.Add(S);
end;

procedure TActionListView.Click;
var
  P: TPoint;
  Item: TListItem;
  DefaultActionClass: TContainedActionClass;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);
  Item := GetItemAt(P.X, P.Y);

  if FIDEActions <> nil then
    DefaultActionClass := FIDEActions.DefaultActionClass
  else
    DefaultActionClass := nil;

  if Item <> nil then
  begin
    if Item.Index <= 1 then
    begin
      if (FMsg = '') and (Item.Index = 0) and (FNewActnPopupMenu.Items.Count = 0) then
      begin
        if Assigned(FOnNewAction) and (DefaultActionClass <> nil) then
          FOnNewAction(Self, '', DefaultActionClass, FActionList);
      end
      else
      begin
        if Item.Index = 0 then
        begin
          if FMsg <> '' then
            DoShowMsg(self)
          else
            ShowPopupMenu(Item, FNewActnPopupMenu)
        end
        else
          ShowPopupMenu(Item, FNewStdActnPopupMenu);
      end;
    end
    else if (Item.Index <> 2) and Assigned(FOnSelectAction) then
    begin
      if (Item.Data <> nil) and (not(TObject(Item.Data) is TContainedAction)) then
        raise EActionError.CreateFMT(StrEClassAction, [TContainedAction.ClassName]);
      FOnSelectAction(Self, TContainedAction(Item.Data));
    end;
  end
  else if Assigned(FOnSelectAction) then
    FOnSelectAction(Self, nil);
end;

function TActionListView.CreateMenuItem(const Caption: string; Event: TNotifyEvent;
  CustomData: Pointer): TMenuItem;
begin
  Result := NewItem(Caption, 0, False, True, Event, 0, '');
  Result.Tag := NativeInt(CustomData);
end;

procedure TActionListView.CreateWnd;
begin
  inherited;
  if Designer.Root <> nil then
    RebuildListView;
end;

function TActionListView.CustomDrawItem(Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage): Boolean;
var
  LRect: TRect;
begin
  Result := True;
  Canvas.Brush.Style := bsClear;
  LRect := Item.DisplayRect(drLabel);

  case Stage of
    cdPrePaint:
      // Draw separator
      if Item.Index = 2 then
      begin
        Canvas.Pen.Color := clSilver;
        Canvas.MoveTo(LRect.Left, LRect.Top + (LRect.Bottom - LRect.Top) div 2);
        Canvas.LineTo(LRect.Right - LRect.Left, LRect.Top + (LRect.Bottom - LRect.Top) div 2);
        Result := False; // Prevent default drawing of highlight bar
      end;
    cdPostPaint:
      // Draw arrow for New Action and New Standard Action items
      if ((Item.Index <= 1) and (FNewStdActnPopupMenu.Items.Count > 1)) and
        (((Item.Index = 0) and (FNewActnPopupMenu.Items.Count > 1)) or
        ((Item.Index = 1) and (FNewStdActnPopupMenu.Items.Count > 1))) then
      begin
        LRect.Left := LRect.Right - 20;
        if ThemeServices.ThemesEnabled and (Win32MajorVersion >= 6) then
          DrawThemeBackground(ThemeServices.Theme[teMenu], Canvas.Handle, MENU_POPUPSUBMENU,
            MSM_NORMAL, LRect, nil)
        else
          DrawArrow(Canvas, sdRight, Point(LRect.Right - 15,
            LRect.Top + ((LRect.Bottom - LRect.Top - 8) div 2)), 4);
      end;
  end;
end;

procedure TActionListView.DoNewActionClick(Sender: TObject);
var
  DefaultActionClass: TContainedActionClass;
begin
  if Assigned(FOnNewAction) and (Sender is TMenuItem) and (FIDEActions <> nil) then
  begin
    DefaultActionClass := FIDEActions.DefaultActionClass;
    if DefaultActionClass <> nil then
      FOnNewAction(Self, '', DefaultActionClass, TContainedActionList(TMenuItem(Sender).Tag));
  end;
end;

procedure TActionListView.DoShowMsg(Sender: TObject);
var
  Form: TForm;
begin
  if (FMsg <> '') then
  begin
    Form := CreateMessageDialog(FMsg, mtInformation, [mbOK]);
    try
      Form.Caption := SNoSetProp;
      Form.ShowModal;
    finally
      Form.Free;
    end;
  end;
end;


procedure TActionListView.DoNewStdActionClick(Sender: TObject);
begin
  if Assigned(FOnNewAction) and (Sender is TMenuItem) then
    FOnNewAction(Self, '', TContainedActionClass(TMenuItem(Sender).Tag),
      TContainedActionList(TMenuItem(Sender).Parent.Tag));
end;

function TActionListView.IsCustomDrawn(Target: TCustomDrawTarget; Stage: TCustomDrawStage): Boolean;
begin
  Result := (Stage = cdPrePaint) or (Stage = cdPostPaint);
end;

procedure TActionListView.KeyDown(var Key: Word; Shift: TShiftState);
var
  DefaultActionClass: TContainedActionClass;
begin
  case Key of
    VK_RETURN:
      if Assigned(FOnSelectAction) and (Selected <> nil) then
      begin
        if FIDEActions <> nil then
          DefaultActionClass := FIDEActions.DefaultActionClass
        else
          DefaultActionClass := nil;
        if (DefaultActionClass <> nil) and (Selected.Index = 0) and (FActionList <> nil) and
          Assigned(FOnNewAction) then
          FOnNewAction(Self, '', DefaultActionClass, FActionList)
        else if Selected.Index = 0 then
          ShowPopupMenu(Selected, FNewActnPopupMenu)
        else if Selected.Index = 1 then
          ShowPopupMenu(Selected, FNewStdActnPopupMenu)
        else if Selected.Index <> 2 then
        begin
          if (Selected.Data <> nil) and (not(TObject(Selected.Data) is TContainedAction)) then
            raise EActionError.CreateFMT(StrEClassAction, [TContainedAction.ClassName]);
          FOnSelectAction(Self, TContainedAction(Selected.Data));
        end;
      end;
    VK_RIGHT:
      if Selected <> nil then
      begin
        if Selected.Index = 0 then
          ShowPopupMenu(Selected, FNewActnPopupMenu)
        else
          ShowPopupMenu(Selected, FNewStdActnPopupMenu);
      end;
    else
      inherited;
  end;
end;

procedure TActionListView.RebuildListView;
var
  LRect: TRect;
  LImages: TCustomImageList;
  LLastActionList: TContainedActionList;
  ListItem: TListItem;
  LComp: TComponent;
  LAction: TContainedAction;
  I, LWidth, MinWidth: integer;
  BaseActionClass: TContainedActionClass;

  procedure AddActionIcon(ListItem: TListItem; Action: TContainedAction);
  var
    LIcon: TIcon;
  begin
    if (FIDEActions <> nil) and (Action <> nil) and (Action.ActionList <> nil) then
    begin
      if Action.ActionList <> LLastActionList then
      begin
        FreeAndNil(LImages);
        LLastActionList := Action.ActionList;
        if LLastActionList <> nil then
          LImages := FIDEActions.CreateImageList(LLastActionList);
      end;
      if LImages <> nil then
      begin
        LIcon := TIcon.Create;
        try
          LImages.GetIcon(Action.ImageIndex, LIcon);
          ListItem.ImageIndex := FImageList.AddIcon(LIcon);
        finally
          LIcon.Free;
        end;
      end;
    end;
  end;

begin
  // Add actions to listview
  if FNewStdActnPopupMenu.Items.Count > 0 then
  begin
    if FIDEActions <> nil then
      BaseActionClass := FIDEActions.BaseActionClass
    else
      BaseActionClass := nil;
    Items.BeginUpdate;
    try
      Items.Clear;
      FImageList.Clear;
      if FMsg = '' then
      begin
        // Set initial max width
        MinWidth := Max(Width, Canvas.TextWidth(SNoSetProp) + 25);

        // Find all actions
        FTempStringList.Clear;
        if (BaseActionClass <> nil) then
        begin
          LImages := nil;
          LLastActionList := nil;
          try
            Designer.GetComponentNames(GetTypeData(TypeInfo(TContainedAction)), AddTempString);
            for I := 0 to FTempStringList.Count - 1 do
            begin
              LComp := Designer.GetComponent(FTempStringList[I]);
              if (not(LComp is TContainedAction)) then
                raise EActionError.CreateFMT(StrEClassAction, [TContainedAction.ClassName]);
              LAction := TContainedAction(LComp);
              if LAction is BaseActionClass then
              begin
                ListItem := Items.Add;
                ListItem.Caption := FTempStringList[I];
                ListItem.Data := LAction;
                ListItem.ImageIndex := -1;
                LWidth := Canvas.TextWidth(ListItem.Caption);
                if (LWidth + 40) > MinWidth then
                  MinWidth := LWidth + 40;
                AddActionIcon(ListItem, LAction);
              end;
            end;
          finally
            FreeAndNil(LImages);
          end;
        end;

        // Sort list items before adding "special" items
        CustomSort(nil, 0);

        // Add "New Action" item
        ListItem := Items.Insert(0);
        ListItem.Caption := SCreateNewAction;
        ListItem.ImageIndex := -1;

        // Add "New Standard Action" item
        ListItem := Items.Insert(1);
        ListItem.Caption := SCreateNewStdAction;
        ListItem.ImageIndex := -1;

        // Add dummy item for divider line
        if Items.Count > 2 then
        begin
          ListItem := Items.Insert(2);
          ListItem.ImageIndex := -1;
        end;
      end
      else
      begin
        MinWidth := Max(Width, Canvas.TextWidth(SNoSetProp) + 25);
        ListItem := Items.Insert(0);
        ListItem.Caption := ' ' + SNoSetProp;
        ListItem.ImageIndex := -1;
      end;
    finally
      Items.EndUpdate;
    end;

    // Set Height to fit 14 items
    LWidth := 0;
    if Items.Count > 14 then
    begin
      I := 14;
      LWidth := GetSystemMetrics(SM_CXVSCROLL);
    end
    else
      I := Items.Count;
    LRect := Items[0].DisplayRect(drBounds);
    Height := LRect.Bottom * I;

    // Set width to widest + space for icon and gutters (20 pixels each side)
    Width := MinWidth + LWidth + FImageList.Width;
    Columns[0].Width := Width - LWidth;
  end
  else
    Height := FDefItemHeight;
end;

procedure TActionListView.RebuildPopupMenus;
var
  LName: string;
  J, I, K: integer;
  LComp: TComponent;
  MenuItem, SubItem: TMenuItem;
  LActionList: TContainedActionList;
  LActionLists: TList<TContainedActionList>;
  ActionClassList: TList<TBasicActionClass>;
  LImages: TCustomImageList;
  BaseActionListClass: TContainedActionListClass;
begin
  SmallImages := nil;
  MenuItem := nil;
  if FIDEActions <> nil then
    BaseActionListClass := FIDEActions.BaseActionListClass
  else
    BaseActionListClass := nil;

  // Build popup menus
  FMsg := '';
  FNewActnPopupMenu.Items.Clear;
  FNewStdActnPopupMenu.Items.Clear;
  FStdActionList := TStringList.Create;
  try
    // Gather list of registered action classes
    if Assigned(EnumRegisteredActionsProc) then
      System.Actions.EnumRegisteredActions(AddStdAction, nil, FFrameworkType);

    LActionLists := TList<TContainedActionList>.Create;
    try
      // Build list of ActionLists
      FTempStringList.Clear;
      if BaseActionListClass = nil then
      begin
        FActionList := nil;
        if FIDEActions = nil then
          FMsg := Format(SNoActionsImpl, [FFrameworkType])
        else
          FMsg := SNoDefineBase;
      end
      else
      begin
        Designer.GetComponentNames(GetTypeData(TypeInfo(TContainedActionList)), AddTempString);
        for I := 0 to FTempStringList.Count - 1 do
        begin
          LComp := Designer.GetComponent(FTempStringList[I]);
          if (not(LComp is TContainedActionList)) then
            raise EActionError.CreateFMT(StrEClassAction, [TContainedAction.ClassName]);
          if LComp is BaseActionListClass then
            LActionLists.Add(TContainedActionList(LComp));
        end;
        if LActionLists.Count = 0 then
          FMsg := Format(SNoActionLists, [BaseActionListClass.ClassName]);

        // If there's just one, save it in FActionList
        if LActionLists.Count = 1 then
          FActionList := LActionLists[0]
        else
          FActionList := nil;
      end;

      if FMsg <> '' then
      begin
        MenuItem := CreateMenuItem(SNoSetProp, DoShowMsg, nil);
        FNewStdActnPopupMenu.Items.Add(MenuItem);
      end
      else // Build popupmenus for actionlists and standard actions
      for LActionList in LActionLists do
      begin
        // Build a popup menu for each ActionList
        if (FIDEActions <> nil) and (SmallImages = nil) then
        begin
          LImages := FIDEActions.CreateImageList(LActionList);
          try
            if LImages <> nil then
              SmallImages := FImageList;
          finally
            FreeAndNil(LImages);
          end;
        end;
        // If more than 1 actionlist, add a popupmenu to select
        // where the create the action
        if LActionLists.Count > 1 then
        begin
          if LActionList.Owner = Designer.Root then
            LName := LActionList.Name
          else
            LName := LActionList.Owner.Name + DotSep + LActionList.Name;

          MenuItem := CreateMenuItem(LName, DoNewActionClick, LActionList);
          FNewActnPopupMenu.Items.Add(MenuItem);
          MenuItem := CreateMenuItem(LName, nil, nil);
          FNewStdActnPopupMenu.Items.Add(MenuItem);
        end;

        // For standard actions popup, add each standard action category
        for J := 0 to FStdActionList.Count - 1 do
        begin
          SubItem := CreateMenuItem(FStdActionList[J], nil, LActionList);
          if LActionLists.Count > 1 then
            MenuItem.Add(SubItem)
          else
            FNewStdActnPopupMenu.Items.Add(SubItem);

          // For each category, add each registered action class
          ActionClassList := TList<TBasicActionClass>(FStdActionList.Objects[J]);
          for K := 0 to ActionClassList.Count - 1 do
            SubItem.Add(CreateMenuItem(ActionClassList[K].ClassName, DoNewStdActionClick,
              ActionClassList[K]));
        end;
      end;
    finally
      LActionLists.Free;
    end;

    // Free lists of registered action classes
    for I := 0 to FStdActionList.Count - 1 do
      FStdActionList.Objects[I].Free;
  finally
    FreeAndNil(FStdActionList);
  end;
end;

procedure TActionListView.SetDesigner(const Value: IDesigner);
var
  N, I: integer;
  LComp: TComponent;
  BaseActionClass: TContainedActionClass;
begin
  FMsg := '';
  if Value <> FDesigner then
  begin
    FDesigner := Value;
    if FIDEActions <> nil then
      BaseActionClass := FIDEActions.BaseActionClass
    else
      BaseActionClass := nil;

    // Set initial height based on default item height
    FTempStringList.Clear;
    N := 0;
    if BaseActionClass <> nil then
    begin
      Designer.GetComponentNames(GetTypeData(TypeInfo(TContainedAction)), AddTempString);
      for I := 0 to FTempStringList.Count - 1 do
      begin
        LComp := Designer.GetComponent(FTempStringList[I]);
        if (not(LComp is TContainedAction)) then
          raise EActionError.CreateFMT(StrEClassAction, [TContainedAction.ClassName]);
        if LComp is BaseActionClass then
          inc(N);
      end;
    end;
    if N > 0 then
      Height := (Min(N, 11) + 3) * FDefItemHeight
    else
      Height := FDefItemHeight;

    // Rebuild popup menus and listview
    RebuildPopupMenus;
    if HandleAllocated then
      RebuildListView;
  end;
end;

procedure TActionListView.ShowPopupMenu(Item: TListItem; PopupMenu: TPopupMenu);
var
  P: TPoint;
  LRect: TRect;
begin
  LRect := Item.DisplayRect(drBounds);
  P := Item.Owner.Owner.ClientToScreen(Point(LRect.Right, LRect.Top));
  PopupMenu.Tag := NativeInt(Item.Data);
  PopupMenu.Popup(P.X, P.Y);
end;
{$ENDREGION}
{$REGION 'TActionProperty. This code moved from VclEditors'}
{ TActionProperty }

procedure TActionProperty.AddAction(const Category: string; ActionClass: TBasicActionClass; Info: Pointer);
var
  R: TRegisteredAction;
begin
  if not Category.IsEmpty then
  begin
    R.Category := Category;
    R.ActionClass := ActionClass;
    if FRegisteredActionList = nil then
      FRegisteredActionList := TList<TRegisteredAction>.Create;
    FRegisteredActionList.Add(R);
  end;
end;

procedure TActionProperty.CreateNewAction(Sender: TObject; const Category: string;
  ActionClass: TContainedActionClass; ActionList: TContainedActionList);
var
  LRoot: IRoot;
  LCategory, LFramework, LName: string;
  NewAction: TContainedAction;
  LIDEActions: TIDEActionsClass;
  I: Integer;
begin
  LCategory := Category;
  if AnsiCompareText(LCategory, SActionCategoryNone) = 0 then
    LCategory := '';

  // Create new action
  LFramework := GetFrameworkType;
  LIDEActions := GetIDEActions(LFramework);
  NewAction := CreateAction(ActionList.Owner, ActionClass, LFramework) as TContainedAction;
  try
    LName := GetNewActionName(NewAction, LFramework);
    if ActionList.Owner = Designer.Root then
      NewAction.Name := Designer.UniqueName(LName)
    else
    begin
      LRoot := ActiveDesigner.FindRoot(ActionList.Owner);
      if LRoot <> nil then
        NewAction.Name := LRoot.GetDesigner.UniqueName(LName)
      else
        raise Exception.CreateResFmt(@SUnableToFindComponent, [ActionList.Owner.Name]);
    end;
    if Category.IsEmpty then
    begin
      if (NewAction.Category.IsEmpty) and Assigned(EnumRegisteredActionsProc) then
      begin
        if FRegisteredActionList = nil then
          System.Actions.EnumRegisteredActions(AddAction, nil, LFramework);
        if FRegisteredActionList <> nil then
          for I := 0 to FRegisteredActionList.Count - 1 do
            if FRegisteredActionList[I].ActionClass = NewAction.ClassType then
            begin
              NewAction.Category := FRegisteredActionList[I].Category;
              Break;
            end;
      end;
    end
    else
      NewAction.Category := LCategory;
    NewAction.ActionList := ActionList;
    if (LIDEActions <> nil) then
      LIDEActions.CopyImageIfAvailable(NewAction, ActionList);
    // Update property
    SelectAction(Sender, NewAction);
  except
    NewAction.Free;
    raise;
  end;
end;

destructor TActionProperty.Destroy;
begin
  FActionListView.Free;
  FRegisteredActionList.Free;
  inherited;
end;

procedure TActionProperty.Edit(const Host: IPropertyHost; DblClick: Boolean);
var
  LHost20: IPropertyHost20;
begin
  FHost := Host;
  if FActionListView <> nil then
    FActionListView.Free;

  FActionListView := TActionListView.Create(nil);
  if Supports(FHost, IPropertyHost20, LHost20) then
    FActionListView.Width := LHost20.GetDropDownWidth;
  FActionListView.OnNewAction := CreateNewAction;
  FActionListView.OnSelectAction := SelectAction;
  FActionListView.Designer := Designer;
  FActionListView.Visible := True;
  FHost.DropDownControl(FActionListView);
end;

function TActionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited + [paCustomDropDown, paVolatileSubProperties] - [paValueList, paSortList];
end;

procedure TActionProperty.SelectAction(Sender: TObject; Action: TContainedAction);
begin
  FHost.CloseDropDown;
  if Action <> nil then
    SetValue(Action.Owner.Name + DotSep + Action.Name)
  else
    SetValue('');
end;
{$ENDREGION}
{$REGION 'The interaction of action with an IDE. This new code'}
function GetFrameworkType: string;
var
  Proj: IOTAProject;
  function GetCurrentProject: IOTAProject;
  var
    Services: IOTAModuleServices;
    Module: IOTAModule;
    Project: IOTAProject;
    ProjectGroup: IOTAProjectGroup;
    MultipleProjects: boolean;
    I: integer;
  begin
    Result   := nil;
    MultipleProjects := False;
    Services := BorlandIDEServices as IOTAModuleServices;
    Module := Services.CurrentModule;
    if (Module = nil) or (Module.OwnerModuleCount <> 1) then
    begin
      for I := 0 to Services.ModuleCount - 1 do
      begin
        Module := Services.Modules[I];
        if Module.QueryInterface(IOTAProjectGroup, ProjectGroup) = S_OK then
        begin
          Result := ProjectGroup.ActiveProject;
          Exit;
        end
        else if Module.QueryInterface(IOTAProject, Project) = S_OK then
        begin
          if Result = nil then
            Result := Project
          else
            MultipleProjects := True;
        end;
      end;
      if MultipleProjects then
        Result := nil;
    end
    else
      Result := Module.Owners[0];
  end;
begin
  Result := '';
  Proj := GetCurrentProject; //GetActiveProject;
  if Proj <> nil then
    Result := Proj.FrameworkType;
end;

procedure RegisterActionsInFramework(const FrameworkType: string;
                                     const AIDEActions: TIDEActionsClass);
var S: string;
    I: integer;
begin
  S := AnsiUppercase(Trim(FrameworkType));
  if S = '' then
    raise EActionError.Create(SInvalidString);
  if AIDEActions = nil then
    raise EActionError.CreateFmt(SParamIsNil, ['AIDEActions']);
  if vGetIDEActions = nil then
  begin
    vGetIDEActions := TStringList.Create;
    vGetIDEActions.Sorted := True;
    vGetIDEActions.Duplicates := dupError;
  end;
  if (vGetIDEActions.Find(S, I)) then
  begin
    if (TObject(AIDEActions) <> vGetIDEActions.Objects[I]) then
      raise EActionError.CreateFmt(StrEFalreadyReg, [S])
  end
  else
    vGetIDEActions.AddObject(S, TObject(AIDEActions));
end;

procedure UnregisterActionsInFramework(const FrameworkType: string);
var S: string;
    I: integer;
begin
  if (vGetIDEActions <> nil) then
  begin
    if (vGetIDEActions.Count > 0) then
    begin
      S := AnsiUppercase(Trim(FrameworkType));
      if S <> '' then
      begin
        I := vGetIDEActions.IndexOf(S);
        if I >= 0 then
          vGetIDEActions.Delete(I);
      end;
    end;
    if vGetIDEActions.Count = 0 then
      FreeAndNil(vGetIDEActions);
  end;
end;

function GetIDEActions(const FrameworkType: string): TIDEActionsClass;
var S: string;
    I: integer;
begin
  Result := vOldIDEActions;
  if (vGetIDEActions <> nil) then
  begin
    S := AnsiUppercase(Trim(FrameworkType));
    if S <> '' then
    begin
      I := vGetIDEActions.IndexOf(S);
      if I >= 0 then
        Result := TIDEActionsClass(vGetIDEActions.Objects[I])
      else
        Result := nil;
    end;
  end;
end;

function GetIDEActions(const ActionList: TContainedActionList; var FrameworkType: string): TIDEActionsClass; overload;
var
  I: Integer;
  IDEActions: TIDEActionsClass;
  ActionListClass: TContainedActionListClass;
begin
  if (ActionList = nil) or (vGetIDEActions = nil) then
  begin
    FrameworkType := GetFrameworkType;
    Result := GetIDEActions(FrameworkType);
  end
  else
  begin
    FrameworkType := '';
    Result := nil;
    for I := 0 to vGetIDEActions.Count - 1 do
    begin
      IDEActions := TIDEActionsClass(vGetIDEActions.Objects[I]);
      if (IDEActions <> nil) then
      begin
        ActionListClass := IDEActions.BaseActionListClass;
        if (ActionListClass <> nil) and (ActionList.InheritsFrom(ActionListClass)) then
        begin
          FrameworkType := vGetIDEActions[I];
          Result := IDEActions;
        end;
      end;
    end;
  end;
end;

function GetIDEActionsList(List: TStringList): integer;
var I: integer;
begin
  Result := 0;
  if List <> nil then
  begin
    List.Clear;
    if vGetIDEActions <> nil then
    for I := 0 to vGetIDEActions.Count - 1 do
    begin
      List.AddObject(vGetIDEActions[I], vGetIDEActions.Objects[I]);
      inc(Result);
    end;
  end
  else
    raise EActionError.CreateFMT(SParamIsNil, ['List']);
end;

{ TIDEActions }

class function TIDEActions.CreateImageLink(const OnChanged: TNotifyEvent): TObject;
begin
  Result := nil;
end;

class function TIDEActions.CreateImageList(ActionList: TContainedActionList): TCustomImageList;
begin
  Result := nil;
end;

class procedure TIDEActions.AssignAction(Source, Destination: TBasicAction);
begin
  if (Source is TContainedAction) and (Destination is TContainedAction) then
    TContainedAction(Destination).Category := TContainedAction(Source).Category;
end;

class function TIDEActions.BaseActionClass: TContainedActionClass;
begin
  Result := nil;
end;

class function TIDEActions.BaseActionListClass: TContainedActionListClass;
begin
  Result := nil;
end;

class function TIDEActions.DefaultActionClass: TContainedActionClass;
begin
  Result := nil;
end;

class procedure TIDEActions.CopyImageIfAvailable(const NewAction: TContainedAction;
  const ActionList: TContainedActionList);
begin

end;

class procedure TIDEActions.RegisterImageLink(const ActionList: TContainedActionList; const ImageLink: TObject);
begin

end;

class procedure TIDEActions.UnregisterImageLink(const ActionList: TContainedActionList; const ImageLink: TObject);
begin

end;

{$ENDREGION}
{$REGION 'Registry Information. This code moved from VclEditors'}

type

  TBasicActionRecord = record
    ActionClass: TBasicActionClass;
    GroupId: integer;
    Resource: TComponentClass;
  end;

  TActionClassArray = array of TBasicActionRecord;

  TActionClassesEntry = record
    Category: string;
    Actions: TActionClassArray;
  end;

  TActionClassesArray = array of TActionClassesEntry;

  TActionResourceCache = class
  type
    TResourceCache = TDictionary<TComponentClass, TComponent>;
  private
    FCache: TResourceCache;
    function GetCache: TResourceCache;
  public
    destructor Destroy; override;
    procedure Add(ComponentClass: TComponentClass; Instance: TComponent);
    procedure Clear;
    function GetInstance(ComponentClass: TComponentClass): TComponent;
    procedure Remove(ComponentClass: TComponentClass);
    property Cache: TResourceCache read GetCache;
  end;

var
  DesignersList: TList = nil;
  ActionClasses: TActionClassesArray = nil;
  vActionResourceCache: TActionResourceCache = nil;

{ TActionResourceCache }

function ActionResourceCache: TActionResourceCache;
begin
  if vActionResourceCache = nil then
    vActionResourceCache := TActionResourceCache.Create;
  Result := vActionResourceCache;
end;

destructor TActionResourceCache.Destroy;
begin
  Clear; // Free stored items
  FreeAndNil(FCache);
end;

procedure TActionResourceCache.Add(ComponentClass: TComponentClass; Instance: TComponent);
begin
  Cache.Add(ComponentClass, Instance);
end;

procedure TActionResourceCache.Clear;
var
  P: TPair<TComponentClass, TComponent>;
begin
  if FCache <> nil then
  begin
    for P in FCache do
      if P.Value <> nil then
        P.Value.Free;
    FCache.Clear;
  end;
end;

function TActionResourceCache.GetCache: TResourceCache;
begin
  if FCache = nil then
    FCache := TResourceCache.Create;
  Result := FCache;
end;

function TActionResourceCache.GetInstance(ComponentClass: TComponentClass): TComponent;
begin
  if (FCache <> nil) and (FCache.ContainsKey(ComponentClass)) then
    Result := FCache.Items[ComponentClass]
  else
    Result := nil;
end;

procedure TActionResourceCache.Remove(ComponentClass: TComponentClass);
begin
  if (FCache <> nil) and (FCache.ContainsKey(ComponentClass)) then
  begin
    if FCache.Items[ComponentClass] <> nil then
      FCache.Items[ComponentClass].Free;
    FCache.Remove(ComponentClass);
  end;
end;
{$ENDREGION}
{$REGION 'Action Registration. This code moved from VclEditors'}

procedure RegActions(const ACategory: string; const AClasses: array of TBasicActionClass;
  AResource: TComponentClass);
var
  CategoryIndex, Len, I, J, NewClassCount: integer;
  NewClasses: array of TBasicActionClass;
  Skip: Boolean;
  S: string;
  lClasses: array of TContainedActionClass;

begin
  for I := Low(AClasses) to High(AClasses) do
    if (AClasses[I] <> nil) and (AClasses[I].InheritsFrom(TContainedAction)) then
    begin
      SetLength(lClasses, Length(lClasses) + 1);
      lClasses[Length(lClasses) - 1] := TContainedActionClass(AClasses[I]);
    end;

  // Remove resource from cache if it's there
  if ActionResourceCache.GetInstance(AResource) <> nil then
    ActionResourceCache.Remove(AResource);

  { Determine whether we're adding a new category, or adding to an existing one }
  CategoryIndex := -1;
  for I := Low(ActionClasses) to High(ActionClasses) do
    if CompareText(ActionClasses[I].Category, ACategory) = 0 then
    begin
      CategoryIndex := I;
      Break;
    end;

  { Adding a new category }
  if CategoryIndex = -1 then
  begin
    CategoryIndex := Length(ActionClasses);
    SetLength(ActionClasses, CategoryIndex + 1);
  end;

  with ActionClasses[CategoryIndex] do
  begin
    SetLength(NewClasses, Length(AClasses));
    { Remove duplicate classes }
    NewClassCount := 0;
    for I := Low(AClasses) to High(AClasses) do
    begin
      Skip := False;
      for J := Low(Actions) to High(Actions) do
        if AClasses[I] = Actions[J].ActionClass then
        begin
          Skip := True;
          Break;
        end;
      if not Skip then
      begin
        NewClasses[Low(NewClasses) + NewClassCount] := AClasses[I];
        inc(NewClassCount);
      end;
    end;

    { Pack NewClasses }
    SetLength(NewClasses, NewClassCount);

    SetString(S, PChar(ACategory), Length(ACategory));
    Category := S;
    Len := Length(Actions);
    SetLength(Actions, Len + Length(NewClasses));
    for I := Low(NewClasses) to High(NewClasses) do
    begin
      RegisterNoIcon([NewClasses[I]]);
      System.Classes.RegisterClass(NewClasses[I]);
      with Actions[Len + I] do
      begin
        ActionClass := NewClasses[I];
        GroupId := CurrentGroup;
        Resource := AResource;
      end;
    end;
  end;
  { Notify all available designers of new TAction class }
  if (DesignersList <> nil) and Assigned(NotifyActionListChange) then
    NotifyActionListChange;
end;

procedure UnRegActions(const Classes: array of TBasicActionClass);
var
  I, J, K: integer;
  LActionClass: TBasicActionClass;
  lClasses: array of TContainedActionClass;

begin
  for I := Low(Classes) to High(Classes) do
    if (Classes[I] <> nil) and (Classes[I].InheritsFrom(TContainedAction)) then
    begin
      SetLength(lClasses, Length(lClasses) + 1);
      lClasses[Length(lClasses) - 1] := TContainedActionClass(Classes[I]);
    end;

  // Clear the resource cache
  ActionResourceCache.Clear;

  for I := Low(Classes) to High(Classes) do
  begin
    LActionClass := Classes[I];
    for J := Low(ActionClasses) to High(ActionClasses) do
      for K := Low(ActionClasses[J].Actions) to High(ActionClasses[J].Actions) do
        with ActionClasses[J].Actions[K] do
          if LActionClass = ActionClass then
          begin
            ActionClass := nil;
            GroupId := -1;
          end;
  end;
  if Assigned(NotifyActionListChange) then
    NotifyActionListChange;
end;

procedure UnregisterActionGroup(AGroupId: integer);
var
  I, J: integer;
begin
  for I := Low(ActionClasses) to High(ActionClasses) do
    for J := Low(ActionClasses[I].Actions) to High(ActionClasses[I].Actions) do
      with ActionClasses[I].Actions[J] do
        if GroupId = AGroupId then
        begin
          ActionClass := nil;
          GroupId := -1;
        end;
  if Assigned(NotifyActionListChange) then
    NotifyActionListChange;
end;

procedure EnumActions(Proc: TEnumActionProc;
                      Info: Pointer;
                      const FrameworkType: string);
var
  I, J, Count: integer;
  ActionClass: TBasicActionClass;
  BaseActionClass: TContainedActionClass;
  CurrClass: TClass;
  IDEActions: TIDEActionsClass;
begin
  IDEActions := GetIDEActions(FrameworkType);
  if (ActionClasses <> nil) and
     (IDEActions <> nil) and
     (IDEActions.BaseActionClass <> nil) then
  begin
    BaseActionClass := IDEActions.BaseActionClass;
    for I := Low(ActionClasses) to High(ActionClasses) do
    begin
      Count := 0;
      for J := Low(ActionClasses[I].Actions) to High(ActionClasses[I].Actions) do
      begin
        ActionClass := ActionClasses[I].Actions[J].ActionClass;
        if ActionClass <> nil then
        begin
          CurrClass := ActionClass;
          while (CurrClass <> nil) and
                (CurrClass <> BaseActionClass) do
            CurrClass := CurrClass.ClassParent;
          if CurrClass <> nil then
            Proc(ActionClasses[I].Category, ActionClass, Info);
          inc(Count);
        end;
      end;
      if Count = 0 then
        SetLength(ActionClasses[I].Actions, 0);
    end;
  end;
end;

function CreateAction(AOwner: TComponent;
                      ActionClass: TBasicActionClass;
                      const FrameworkType: string): TBasicAction;
var
  I, J: integer;
  Res: TComponentClass;
  Instance: TComponent;
  Action: TBasicAction;
  IDEActions: TIDEActionsClass;

  function FindComponentByClass(AOwner: TComponent; const AClassName: string): TComponent;
  var
    I: integer;
  begin
    if (AClassName <> '') and (AOwner.ComponentCount > 0) then
      for I := 0 to AOwner.ComponentCount - 1 do
      begin
        Result := AOwner.Components[I];
        if CompareText(Result.ClassName, AClassName) = 0 then
          Exit;
      end;
    Result := nil;
  end;

begin
  if not ActionClass.InheritsFrom(TContainedAction) then
    raise EActionError.CreateFMT(StrEClassAction, [TContainedAction.ClassName]);

  Result := ActionClass.Create(AOwner);
  { Attempt to find the first action with the same class Type as ActionClass in
    the Resource component's resource stream, and use its property values as
    our defaults. }
  Res := nil;
  for I := Low(ActionClasses) to High(ActionClasses) do
  begin
      for J := Low(ActionClasses[I].Actions) to High(ActionClasses[I].Actions) do
      begin
        if ActionClasses[I].Actions[J].ActionClass = ActionClass then
        begin
          Res := ActionClasses[I].Actions[J].Resource;
          Break;
        end;
      end;
    if Res <> nil then Break;
  end;
  if Res <> nil then
  begin
    // Look for this resource in the cache
    Instance := ActionResourceCache.GetInstance(Res);
    if Instance = nil then
    begin
      // Not found, create it and add it
      Instance := Res.Create(nil);
      ActionResourceCache.Add(Res, Instance);
    end;

    Action := FindComponentByClass(Instance, ActionClass.ClassName) as TBasicAction;
    if Action <> nil then
    begin
      IDEActions := GetIDEActions(FrameworkType);
      if (IDEActions <> nil) then
        IDEActions.AssignAction(Action, Result)
      else
      with Action as TContainedAction do
      begin
        // Old code
        TContainedAction(Result).Caption := Caption;
        TContainedAction(Result).Checked := Checked;
        TContainedAction(Result).Enabled := Enabled;
        TContainedAction(Result).HelpContext := HelpContext;
        TContainedAction(Result).Hint := Hint;
        TContainedAction(Result).ImageIndex := ImageIndex;
        TContainedAction(Result).ShortCut := ShortCut;
        TContainedAction(Result).Visible := Visible;
      end;
    end;
  end;
end;
{$ENDREGION}

function GetNewActionName(const Action: TBasicAction; const FrameworkType: string): string;
var Cat: string;
  procedure DropPart(var S: string; Part: string);
  begin
    Part := StringReplace(Part, ' ', '', [rfReplaceAll]);
    if (Length(S) > (Length(Part) + 2)) and
       (WideSameText(System.Copy(S, 1, Length(Part)), Part)) then
      Delete(S, 1, Length(Part));
  end;
begin
  Result := Action.ClassName;
  if Action is TContainedAction then
  begin
    DropPart(Result, 't');
    DropPart(Result, FrameworkType);
    Cat := StringReplace(TContainedAction(Action).Category, ' ', '', [rfReplaceAll]);
    DropPart(Result, Cat);
    Result := 'T' + Cat + Result;
  end;
end;

initialization
vGetIDEActions := nil;
vOldIDEActions := nil;
RegisterActionsProc := nil; //RegActions;
UnRegisterActionsProc := nil; //UnRegActions;
EnumRegisteredActionsProc := nil; //EnumActions;
CreateActionProc := nil; //CreateAction;

NotifyGroupChange(UnregisterActionGroup);

finalization

UnNotifyGroupChange(UnregisterActionGroup);
FreeAndNil(vActionResourceCache);
FreeAndNil(vGetIDEActions);

end.
