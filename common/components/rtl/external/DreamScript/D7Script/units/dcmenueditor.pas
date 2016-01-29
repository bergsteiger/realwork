{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCMenuEditor;

interface

{$I dc.inc}

Uses
  Controls, Menus, Classes, Windows, Graphics, Messages, Forms, StdCtrls, CommCtrl, SysUtils,
  {$IFDEF D4}ImgList,{$ENDIF}

  DCdreamLib, DCSystem, DCGen, DCCommon, DCConsts,
  DCGraphFunc;

//{$DEFINE USEINDELPHIENV}

{$IFNDEF D4}
{$WARNINGS OFF}
{$ENDIF}

Type
  TDCMenuFolder = class;
  TDCCustomMenuEditor = class;

  TDCMenuItem = class
  private
    FItemInMenu : Boolean;
    FMenuItem   : TMenuItem;
    FSubMenu    : TDCMenuFolder;
    FUnderLayer : TWinControl;
    FMenuFolder : TDCMenuFolder;

    Function GetIndex : Integer;
    procedure SetUnderLayer( AValue : TWinControl );
  protected
    Function GetTextDrawingFlags : Integer;
    Function HasImage : Boolean;
    Function GetWidth : Integer; virtual;
    Function GetImageWidth : Integer;

    Procedure ValidateMenuItem;

    Function IsDragSource : Boolean;

    Procedure InitSubMenu( Const AItemRect : TRect ); virtual;
    Procedure DrawEmptyItem( ACanvas : TCanvas; Var AItemRect : TRect; ASelected : Boolean ); virtual;
    Procedure InitCanvas( ACanvas : TCanvas; ASelected : Boolean );
    Procedure DrawImage( ACanvas : TCanvas; Var AItemRect : TRect; ASelected : Boolean ); virtual;
    Procedure InitFontForDefault( AFont : TFont );

    Property SubMenu    : TDCMenuFolder Read FSubMenu;
    Property UnderLayer : TWinControl   Read FUnderLayer Write SetUnderLayer;
    Property MenuFolder : TDCMenuFolder Read FMenuFolder;
    Property ItemInMenu : Boolean       Read FItemInMenu;
    Property Index      : Integer       Read GetIndex;
  public
    Constructor Create( AMenuFolder : TDCMenuFolder; AMenuItem : TMenuItem ); virtual;
    Destructor Destroy; override;

    Procedure DrawItem( ACanvas : TCanvas; AItemRect : TRect; ASelected : Boolean ); virtual;

    Procedure ShowSubMenu( Const AItemRect : TRect ); virtual;
    Procedure HideSubMenu;

    Procedure CreateSubMenu;

    Property MenuItem : TMenuItem Read FMenuItem;
    Property Width    : Integer   Read GetWidth;
  end;

{------------------------------------------------------------------}

  TDCMainMenuItem = class( TDCMenuItem )
  protected
    Procedure DrawImage( ACanvas : TCanvas; Var AItemRect : TRect; ASelected : Boolean ); override;
    Procedure InitSubMenu( Const AItemRect : TRect ); override;
    Function GetWidth : Integer; override;
  public
    Procedure ShowSubMenu( Const AItemRect : TRect ); override;
  end;

{------------------------------------------------------------------}

  TDCPopupMenuItem = class( TDCMenuItem )
  protected
    Function ShowShortCut : Boolean;

    Procedure InitSubMenu( Const AItemRect : TRect ); override;
    Function GetWidth : Integer; override;
  public
    Procedure DrawItem( ACanvas : TCanvas; AItemRect : TRect; ASelected : Boolean ); override;
  end;

{------------------------------------------------------------------}

  TDCMenuItemClass = class of TDCMenuItem;
  TDCOnSelectionChanged = procedure( ASender : TObject; AOldItem, ANewItem : TDCMenuItem ) of object;
  TDCSimpleNotifyEvent = procedure of object;

  TDCMenuFolder = class( TCustomControl )
  private
    FInserting          : Boolean;
    FSelectedItem       : Integer;
    FSelectedItemRect   : TRect;
    FItems              : TList;
    FMenuItem           : TMenuItem;
    FParentItem         : TDCMenuItem;

    FDraggingItem       : Integer;
    FDropTargetItem     : Integer;
    FDropTargetItemRect : TRect;
    FDraggedOver        : Boolean;

    FOnSelectionChanged : TDCOnSelectionChanged;
    FOnGlobalMenuClick  : TDCSimpleNotifyEvent;
    FOnGlobalMenuDblClick : TDCSimpleNotifyEvent; // by Volkoff

    Procedure WMEraseBkgnd( Var Msg : TWMEraseBkgnd ); message WM_EraseBkgnd;
    Procedure WMGetDlgCode( Var Msg : TWMGetDlgCode ); message WM_GetDlgCode;
    Procedure WMLButtonDown( Var Msg : TWMLButtonDown ); message WM_LBUTTONDOWN;
    Procedure CMRelease( Var Msg : TMessage ); message CM_RELEASE;
    Procedure WMChar( Var Msg : TWMChar ); message WM_CHAR;
    Procedure WMWindowPosChanged( Var Msg : TWMWindowPosChanged ); message WM_WINDOWPOSCHANGED;

    Procedure InsertMenuItem( AIndex : Integer; AItem : TMenuItem );

    Function GetCount : Integer;
    Function GetItems( AIndex : Integer ) : TDCMenuItem;
    Procedure SetSelectedItem( AValue : Integer );
    procedure SetDropTargetItem( AValue : Integer );
  protected
    Procedure SetParent( AParent : TWinControl ); override;
    Procedure KeyDown( Var AKey : Word; AShift : TShiftState ); override;
    Procedure Click; override;
    procedure DblClick; override;

    procedure DoStartDrag( Var DragObject : TDragObject ); override;
    Procedure DragOver( Source : TObject; X, Y : Integer; State : TDragState;
                        Var Accept : Boolean ); override;
    Procedure DoEndDrag( Target : TObject; X, Y : Integer ); override;
    Procedure DrawImageOnDragItem; virtual;

    Function GetMenuItemClass : TDCMenuItemClass; virtual;
    Function GetRootFolder : TDCMenuFolder;

    Procedure ValidateChanges( AIndex : Integer ); virtual;
    Procedure CheckFictitiousItem; virtual;

    Procedure MoveSelectionUp;
    Procedure MoveSelectionDown;
    Procedure JumpFirstItem;

    Procedure UpdateSize; virtual;
    Procedure RealignControls;
    Procedure ShowSubMenuForSelectedItem;

    Procedure MoveUpward; virtual;
    Procedure MoveDownward; virtual;
    Procedure MoveRightward; virtual;
    Procedure MoveLeftward; virtual;
    Procedure MoveSelectionToParent; virtual;

    Function  GetMaxItemsWidth : Integer;
    Function  GetItemRect( AIndex : Integer ) : TRect; virtual;
    Procedure SetNewSelectedItem( Var AValue : Integer );
    Function  GetImageShift : Integer; virtual;
    Function  GetItemHeight : Integer; virtual;

    Procedure InvalidateItems( Var AItemRect : TRect );

    Procedure DoSelectionChanged( AOldItem, ANewItem : TDCMenuItem ); dynamic;
    Procedure DoGlobalMenuClick; dynamic;
    procedure DoGlobalMenuDblClick; dynamic;

    Procedure InitItemRect( Var AItemRect : TRect ); virtual;
    Procedure ShiftRectOnNextItem( Var AItemRect : TRect; ANewItem : Integer ); virtual;

    Property MenuItem       : TMenuItem   Read FMenuItem;
    Property ImageShift     : Integer     Read GetImageShift;
    Property ItemHeight     : Integer     Read GetItemHeight;
    Property ParentItem     : TDCMenuItem Read FParentItem;
    Property DropTargetItem : Integer     Read FDropTargetItem Write SetDropTargetItem;
  public
    Constructor Create( AOwner : TComponent; AParentItem : TDCMenuItem;
                        AMenuItem : TMenuItem ); {$IFDEF D4}reintroduce;{$ENDIF} virtual;
    Destructor Destroy; override;
    Procedure Release;

    Procedure Initialize; virtual;
    Procedure InitRegions( ACanvas : TCanvas );
    Function GetItemAt( X, Y : Integer ) : Integer;

    Procedure InsertItem( AIndex : Integer ); virtual;
    Procedure DeleteItem( AIndex : Integer; AForce : Boolean ); virtual;
    Procedure CreateSubMenu( AIndex : Integer );

    Procedure CheckMenuAttributes; virtual;

    Property Count : Integer        Read GetCount;
    Property Items[ Index : Integer ] : TDCMenuItem Read GetItems;

    Property SelectedItem       : Integer               Read FSelectedItem Write SetSelectedItem;
    Property OnSelectionChanged : TDCOnSelectionChanged Read FOnSelectionChanged Write FOnSelectionChanged;
    Property OnGlobalMenuClick  : TDCSimpleNotifyEvent  Read FOnGlobalMenuClick Write FOnGlobalMenuClick;
    Property OnGlobalMenuDblClick  : TDCSimpleNotifyEvent  Read FOnGlobalMenuDblClick Write FOnGlobalMenuDblClick;
  end;

{------------------------------------------------------------------}

  TDCMainMenuFolder = class( TDCMenuFolder )
  protected
    Procedure Paint; override;
    Procedure DrawImageOnDragItem; override;

    Procedure CheckFictitiousItem; override;
    Procedure ValidateChanges( AIndex : Integer ); override;

    Function GetMenuItemClass : TDCMenuItemClass; override;

    Function  GetItemRect( AIndex : Integer ) : TRect; override;
    Procedure InitItemRect( Var AItemRect : TRect ); override;
    Procedure ShiftRectOnNextItem( Var AItemRect : TRect; ANewItem : Integer ); override;

    Procedure UpdateSize; override;

    Procedure MoveUpward; override;
    Procedure MoveDownward; override;
    Procedure MoveRightward; override;
    Procedure MoveLeftward; override;
    Procedure MoveSelectionToParent; override;

    Function  GetImageShift : Integer; override;
  public
    Constructor Create( AOwner : TComponent; AParentItem : TDCMenuItem;
                        AMenuItem : TMenuItem ); override;

    Procedure Initialize; override;
  end;

{------------------------------------------------------------------}

  TDCPopupMenuFolder = class( TDCMenuFolder )
  protected
    Procedure Paint; override;
    Procedure DrawImageOnDragItem; override;

    Procedure ValidateChanges( AIndex : Integer ); override;
    Procedure CheckFictitiousItem; override;

    Function GetMenuItemClass : TDCMenuItemClass; override;

    Function  GetItemRect( AIndex : Integer ) : TRect; override;
    Procedure InitItemRect( Var AItemRect : TRect ); override;
    Procedure ShiftRectOnNextItem( Var AItemRect : TRect; ANewItem : Integer ); override;

    Procedure UpdateSize; override;

    Procedure MoveUpward; override;
    Procedure MoveDownward; override;
    Procedure MoveRightward; override;
    Procedure MoveLeftward; override;
    Procedure MoveSelectionToParent; override;
  public
    Procedure DeleteItem( AIndex : Integer; AForce : Boolean); override;

    Procedure Initialize; override;
  end;

{------------------------------------------------------------------}

  TDCCustomMenuEditor = class( TCustomControl )
  private
    FMenu               : TMenu;
    FMenuDesigner       : TDCMenuFolder;
    FOnSelectionChanged : TDCOnSelectionChanged;

    FVertPosition       : Integer;
    FHorzPosition       : Integer;
    FMaxWidth           : Integer;
    FMaxHeight          : Integer;

    MissNotification    : Boolean;

    FUpdateCount        : Integer;
    FNeedUpdateBorders  : Boolean;
    FPropChanging       : Boolean;

    FScrollTimer        : UINT;

{$IFDEF USEINDELPHIENV}
    FOldMenuChangeHandler : TMenuChangeEvent;
{$ENDIF}

    Procedure SetMenu( AValue : TMenu );
    procedure SetHorzPosition( AValue : Integer );
    procedure SetVertPosition( AValue : Integer );
    Function GetSelectedItem : TDCMenuItem;

    Procedure WMEraseBkgnd( Var Msg : TWMEraseBkgnd ); message WM_EraseBkgnd;
    Procedure WMLButtonDown( Var Msg : TWMLButtonDown ); message WM_LBUTTONDOWN;
    Procedure WMVScroll( Var Msg : TWMScroll ); message WM_VSCROLL;
    Procedure WMHScroll( Var Msg : TWMScroll ); message WM_HSCROLL;
    Procedure WMTimer( Var Msg : TWMTimer); message WM_TIMER;
    Procedure WMSize( Var Msg : TWMSize ); message WM_Size;
    Procedure WMSetFocus( Var Msg : TWMSetFocus ); message WM_SetFocus;

    Procedure ShiftControls( AXOffset, AYOffset : Integer );

    Procedure CMPROPCHANGED( Var Msg : TMessage ); message CM_PROPCHANGED;

{$IFDEF USEINDELPHIENV}
    Procedure MenuChangeHandler( ASender : TObject; ASource : TMenuItem; ARebuild : Boolean );
{$ENDIF}
    Procedure SelectionChanged( ASender : TObject; AOldItem, ANewItem : TDCMenuItem );
  protected
    Procedure Loaded; override;
    Procedure Paint; override;
    Procedure Notification( AComponent : TComponent; Operation : TOperation ); override;
    Procedure CreateParams( Var Params : TCreateParams ); override;
    Procedure CreateHandle; override;

    Procedure RebuildMenu;
    Procedure HookMenu;
    Procedure UnhookMenu;

    Procedure UpdateBorders; virtual;

    Procedure CheckNewHorzPosition( Var AValue : Integer );
    Procedure CheckNewVertPosition( Var AValue : Integer );

    Procedure UpdateScrollPos;
    Procedure UpdateScrollSize;
    Procedure UpdateScrollBars;

    Function VertScrollVisible : Boolean;
    Function HorzScrollVisible : Boolean;

    Function GetTopMenu : TDCMenuFolder;

    Procedure DoSelectionChanged( AOldItem, ANewItem : TDCMenuItem ); dynamic;

    Procedure BeginUpdate;
    Procedure EndUpdate;

    Procedure InitTimer;
    Procedure KillTimer;

    Property MenuDesigner : TDCMenuFolder Read FMenuDesigner;
    Property HorzPosition : Integer Read FHorzPosition Write SetHorzPosition;
    Property VertPosition : Integer Read FVertPosition Write SetVertPosition;
    Property UpdateCount  : Integer Read FUpdateCount;
  public
    Constructor Create( AOwner : TComponent ); override;
    Destructor Destroy; override;

    Property Menu         : TMenu       Read FMenu Write SetMenu;
    Property SelectedItem : TDCMenuItem Read GetSelectedItem;

    Property OnSelectionChanged : TDCOnSelectionChanged Read FOnSelectionChanged Write FOnSelectionChanged;
  end;

{------------------------------------------------------------------}

  TDCMenuEditor = class( TDCCustomMenuEditor )
  published
    Property Menu;

    Property Align;
    Property Color;
    Property TabStop;
    Property TabOrder;
    Property PopupMenu;

    Property OnSelectionChanged;

    Property OnClick;
    property OnDblClick; //by Volkoff
  end;

{$IFNDEF D4}
{$WARNINGS ON}
{$ENDIF}

{------------------------------------------------------------------}

Procedure DCCreateMenuItemName( AItem : TMenuItem );

//Procedure Register;

implementation

{$IFNDEF D5}
Var
  DCRemovingFictiousItem : Integer = 0;
{$ENDIF}

{$R *.dcr}

{Procedure Register;
begin
  RegisterComponents( sPalDreamDes, [TDCMenuEditor] );
end;}

{------------------------------------------------------------------}

Const
  sDCMenuEditorWidth = 200;
  sDCMenuEditorHeight = 150;
  sDCDefaultItemWidth = 43;
  sDCDefaultItemHeight = 19;

  sDCMenuItemSpace = 8;
  sDCSubMenuItemSpaceLeft = 3;
  sDCSubMenuItemSpaceRight = 10;

  sDCCheckBoxSpaceBefore = 1;
  sDCCheckBoxSpaceAfter = 1;

  sDCSubMenuImageWidth = 20;
  sDCShortCutSpaceLeft = 2;
  sDCShortCutSpaceRight = 4 - sDCSubMenuImageWidth Div 2;

  sDCButtonShift = 0;
  sDCButtonSpaceAfter = 1;

  sDCPopupSpaceTop = 1;
  sDCPopupSpaceBottom = 1;
  sDCPopupSpaceRight = 2;
  sDCPopupSpaceLeft = 2;

  sDCHorzScrollStep = 1;
  sDCVertScrollStep = 1;
  sDCHorzTimerScrollStep = 5;
  sDCVertTimerScrollStep = 5;

{------------------------------------------------------------------}

{$IFNDEF D5}
{$WARNINGS OFF}
Type
  TMMenuItem = class( TMenuItem );
  TMMenu     = class( TMenu );
{$ENDIF}

Type
  TDCFictitiousMenuItem = class( TMenuItem )
  private
    FMenuItem : TDCMenuItem;
  protected
    Procedure MenuChanged( ARebuild : Boolean ); override;
    Procedure CreateRealItem; virtual;

    Property MenuItem : TDCMenuItem Read FMenuItem;
  public
    Constructor Create( AOwner : TComponent; AMenuItem : TDCMenuItem ); {$IFDEF D4}reintroduce;{$ENDIF} virtual;
    Destructor Destroy; override;
  end;
{$IFNDEF D4}
{$WARNINGS ON}
{$ENDIF}

{------------------------------------------------------------------}

  TDCMenuDragObject = class( TDragControlObject )
  private
    FNotifyObject  : TDCMenuFolder;

    procedure SetNotifyObject( AValue : TDCMenuFolder );
  protected
    Function GetDragCursor( Accepted : Boolean; X, Y : Integer ) : TCursor; override;
{$IFDEF D4}
    Procedure EndDrag( Target : TObject; X, Y : Integer ); override;
{$ELSE}
    Procedure Finished( Target : TObject; X, Y : Integer; Accepted : Boolean ); override;
{$ENDIF}
  public
    Property NotifyObject : TDCMenuFolder Read FNotifyObject Write SetNotifyObject;
  end;

{------------------------------------------------------------------}

Procedure DCAssignMenuItems( SourceItem, DestItem : TMenuItem );
begin
  With DestItem Do
  begin
{$IFDEF D4}
    Bitmap := SourceItem.Bitmap;
    ImageIndex := SourceItem.ImageIndex;
{$ENDIF}
    Break := SourceItem.Break;
    Caption := SourceItem.Caption;
    Checked := SourceItem.Checked;
    Enabled := SourceItem.Enabled;
    GroupIndex := SourceItem.GroupIndex;
    HelpContext := SourceItem.HelpContext;
    Hint := SourceItem.Hint;
    RadioItem := SourceItem.RadioItem;
    ShortCut := SourceItem.ShortCut;
    Tag := SourceItem.Tag;
    Visible := SourceItem.Visible;

    OnClick := SourceItem.OnClick;
  end;
end;

{------------------------------------------------------------------}

{$IFDEF D4}
{$IFNDEF D5}
Function DCGetMenuImageListD4( AMenuItem : TMenuItem ) : TCustomImageList;
Var
  ParentMenu : TMenu;
begin
  ParentMenu := AMenuItem.GetParentMenu;
  If ParentMenu <> Nil Then
    Result := ParentMenu.Images
  Else
    Result := Nil;
end;
{$ENDIF}
{$ENDIF}

{------------------------------------------------------------------}

{ TDCMenuEditor }

procedure TDCCustomMenuEditor.BeginUpdate;
begin
  If UpdateCount = 0 Then
    FNeedUpdateBorders := False;
    
  Inc( FUpdateCount );
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.CheckNewHorzPosition( Var AValue : Integer );
begin
  If AValue > FMaxWidth - ClientWidth Then
    AValue := FMaxWidth - ClientWidth;
  If AValue < 0 Then
    AValue := 0;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.CheckNewVertPosition( Var AValue : Integer );
begin
  If AValue > FMaxHeight - ClientHeight Then
    AValue := FMaxHeight - ClientHeight;
  If AValue < 0 Then
    AValue := 0;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.CMPROPCHANGED( Var Msg : TMessage );
Var
  I : Integer;
begin
  If {$IFNDEF D5}( DCRemovingFictiousItem <> 0 ) Or{$ENDIF} FPropChanging Or ( csDestroying In ComponentState ) Then
    Exit;

//  BeginUpdate;
  FPropChanging := True;
  try
    With TList( Msg.wParam ) Do
      For I := 0 To Count - 1 Do
      begin
        If TObject( Items[ I ] ).InheritsFrom( TDCFictitiousMenuItem ) And
           ( TMenuItem( Items[ I ] ).Name <> '' ) Then
        begin
          TDCFictitiousMenuItem( Items[ I ] ).CreateRealItem;
          Exit;
        end;
        If TObject( Items[ I ] ).InheritsFrom( TMenuItem ) Then
        begin
          If ( TMenuItem( Items[ I ] ).Name = '' ) And ( TMenuItem( Items[ I ] ).Caption <> '' ) Then
            DCCreateMenuItemName( TMenuItem( Items[ I ] ) );
          Invalidate;
          If Assigned( MenuDesigner ) Then
            MenuDesigner.CheckMenuAttributes;
          Exit;
        end;
      end;
  finally
//    EndUpdate;
    FPropChanging := False;
  end;
end;

{------------------------------------------------------------------}

constructor TDCCustomMenuEditor.Create( AOwner : TComponent );
begin
  Inherited;
  Width := sDCMenuEditorWidth;
  Height := sDCMenuEditorHeight;

  RegisterNotifier( Self );
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.CreateHandle;
begin
  Inherited;
  UpdateScrollBars;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.CreateParams( Var Params : TCreateParams );
begin
  Inherited;
  Params.Style := Params.Style Or WS_HSCROLL Or WS_VSCROLL Or WS_TABSTOP;
end;

{------------------------------------------------------------------}

Destructor TDCCustomMenuEditor.Destroy;
begin
  KillTimer;
  UnregisterNotifier( Self );

  UnhookMenu;
  FreeObject( FMenuDesigner ,FMenuDesigner );
  Inherited;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.DoSelectionChanged( AOldItem, ANewItem : TDCMenuItem );
begin
  If Assigned( FOnSelectionChanged ) Then
    FOnSelectionChanged( Self, AOldItem, ANewItem );
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.EndUpdate;
begin
  If UpdateCount = 0 Then
    Exit;

  Dec( FUpdateCount );
  If UpdateCount = 0 Then
    If FNeedUpdateBorders Then
      UpdateBorders;
end;

{------------------------------------------------------------------}

Function TDCCustomMenuEditor.GetSelectedItem : TDCMenuItem;
begin
  Result := Nil;
  If Not Assigned( MenuDesigner ) Then
    Exit;
  With GetTopMenu Do
    If SelectedItem >= 0 Then
      Result := Items[ SelectedItem ];
end;

{------------------------------------------------------------------}

Function TDCCustomMenuEditor.GetTopMenu : TDCMenuFolder;
begin
  Result := MenuDesigner;
  If Result <> Nil Then
  begin
    While ( Result.SelectedItem >= 0 ) And
          Assigned( Result.Items[ Result.SelectedItem ].SubMenu ) And
          ( Result.Items[ Result.SelectedItem ].SubMenu.SelectedItem >= 0 ) Do
      Result := Result.Items[ Result.SelectedItem ].SubMenu;
  end;
end;

{------------------------------------------------------------------}

Type
  THackMenu = class( TMenu )
  end;

procedure TDCCustomMenuEditor.HookMenu;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure HookMenuItem( AItem : TMenuItem );
  Var
    I : Integer;
  begin
    AItem.FreeNotification( Self );
    For I := 0 To AItem.Count - 1 Do
      HookMenuItem( AItem[ I ] );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  If Not Assigned( Menu ) Then
    Exit;
  Menu.FreeNotification( Self );
  HookMenuItem( Menu.Items );
{$IFDEF USEINDELPHIENV}
  FOldMenuChangeHandler := THackMenu( Menu ).OnChange;
  THackMenu( Menu ).OnChange := MenuChangeHandler;
{$ENDIF}
end;

{------------------------------------------------------------------}

Function TDCCustomMenuEditor.HorzScrollVisible : Boolean;
begin
  Result := FMaxWidth > ClientWidth;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.InitTimer;
begin
  If FScrollTimer = 0 Then
    FScrollTimer := SetTimer( Handle, 1, 50, Nil );
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.KillTimer;
begin
  If FScrollTimer <> 0 Then
  begin
    Windows.KillTimer( Handle, FScrollTimer );
    FScrollTimer := 0;
  end;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.Loaded;
begin
  Inherited;
  RebuildMenu;
end;

{------------------------------------------------------------------}

{$IFDEF USEINDELPHIENV}
procedure TDCCustomMenuEditor.MenuChangeHandler( ASender : TObject; ASource : TMenuItem;
  ARebuild : Boolean );
begin
  If ARebuild Then
    RebuildMenu;
  If Assigned( FMenuDesigner ) Then
    FMenuDesigner.CheckMenuAttributes;
  Invalidate;
  If Assigned( FOldMenuChangeHandler ) Then
    FOldMenuChangeHandler( ASender, ASource, ARebuild )
end;
{$ENDIF}


{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.Notification( AComponent : TComponent; Operation : TOperation );
begin
  Inherited;
  If ( Operation <> opRemove ) Or MissNotification Then
    Exit;
  If AComponent.InheritsFrom( TDCMenuFolder ) Then
    UpdateBorders
  Else
    If Assigned( Menu ) And ( csDestroying In Menu.ComponentState ) Then
    begin
      FreeObject( FMenuDesigner ,FMenuDesigner );
      Menu := Nil;
    end
      Else
    begin
      If AComponent.InheritsFrom( TMenuItem ) Then
        RebuildMenu;
      If Menu = AComponent Then
        Menu := Nil;
    end;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.Paint;
Var
  Rgn : HRgn;
begin
  If Assigned( FMenuDesigner ) Then
  begin
    Rgn := CreateRectRgnIndirect( ClientRect );
    GetClipRgn( Canvas.Handle, Rgn );

    FMenuDesigner.InitRegions( Canvas );
  end;
  Canvas.Brush.Color := Color;
  Canvas.FillRect( ClientRect );
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.RebuildMenu;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure ResetBorders;
  begin
    FHorzPosition := 0;
    FVertPosition := 0;
    FMaxWidth := 0;
    FMaxHeight := 0;
    UpdateScrollBars;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  If Assigned( MenuDesigner ) Then
    MenuDesigner.SelectedItem := -1;

  BeginUpdate;
{$IFNDEF D5}
  Inc( DCRemovingFictiousItem );
{$ENDIF}
  try
    FreeObject( FMenuDesigner ,FMenuDesigner );
    Application.ProcessMessages;
  finally
{$IFNDEF D5}
    Dec( DCRemovingFictiousItem );
{$ENDIF}    
    EndUpdate;
  end;

  ResetBorders;

  If Menu = Nil Then
    Exit;
  If Menu Is TMainMenu Then
    FMenuDesigner := TDCMainMenuFolder.Create( Self, Nil, Menu.Items )
  Else
    FMenuDesigner := TDCPopupMenuFolder.Create( Self, Nil, Menu.Items );

  With FMenuDesigner Do
  begin
    Parent := Self;
    OnSelectionChanged := SelectionChanged;
    OnGlobalMenuClick := Self.Click;
    OnGlobalMenuDblClick := Self.DblClick;
    If Not( Menu Is TMainMenu ) Then
      FMenuDesigner.SelectedItem := 0;
  end;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.SelectionChanged( ASender : TObject; AOldItem, ANewItem : TDCMenuItem );
begin
  DoSelectionChanged( AOldItem, ANewItem );
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.SetHorzPosition( AValue : Integer );
begin
  CheckNewHorzPosition( AValue );
  If FHorzPosition = AValue Then
    Exit;
  ShiftControls( FHorzPosition - AValue, 0 );
  FHorzPosition := AValue;
  UpdateScrollPos;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.SetMenu( AValue : TMenu );
begin
  If FMenu = AValue Then
    Exit;
  UnhookMenu;
  FMenu := AValue;
  HookMenu;
  If Not ( csLoading In ComponentState ) Then
    RebuildMenu;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.SetVertPosition( AValue : Integer );
begin
  CheckNewVertPosition( AValue );
  If FVertPosition = AValue Then
    Exit;
  ShiftControls( 0, FVertPosition - AValue );
  FVertPosition := AValue;
  UpdateScrollPos;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.ShiftControls( AXOffset, AYOffset : Integer );
Var
  I : Integer;
begin
  BeginUpdate;
  try
    For I := 0 To ControlCount - 1 Do
      With Controls[ I ] Do
        SetBounds( Left + AXOffset, Top + AYOffset, Width, Height );
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.UnhookMenu;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure UnhookMenuItem( AItem : TMenuItem );
  Var
    I : Integer;
  begin
  {$IFDEF D5}
    AItem.RemoveFreeNotification( Self );
  {$ELSE}
//    TMMenuItem( AItem ).Notification( Self, opRemove );
  {$ENDIF}
    For I := 0 To AItem.Count - 1 Do
      UnhookMenuItem( AItem[ I ] );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  If Not Assigned( Menu ) Then
    Exit;
{$IFDEF D5}
  Menu.RemoveFreeNotification( Self );
{$ELSE}
//  TMMenu( Menu ).Notification( Self, opRemove );
{$ENDIF}
  UnhookMenuItem( Menu.Items );

{$IFDEF USEINDELPHIENV}
  THackMenu( Menu ).OnChange := FOldMenuChangeHandler;
{$ENDIF}
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.UpdateBorders;
Var
  I, X, Y : Integer;
begin
  If csDestroying In ComponentState Then
    Exit;

  If UpdateCount <> 0 Then
  begin
    FNeedUpdateBorders := True;
    Exit;
  end;

  BeginUpdate;
  try
    FMaxWidth := 0;
    FMaxHeight := 0;
    X := 0;
    Y := 0;
    For I := 0 To ControlCount - 1 Do
      With Controls[ I ] Do
      begin
        If X > Left Then
          X := Left;
        If Y > Top Then
          Y := Top;
      end;
    For I := 0 To ControlCount - 1 Do
      With Controls[ I ] Do
      begin
        If -X + Left + Width > FMaxWidth Then
          FMaxWidth := -X + Left + Width;
        If -Y + Top + Height > FMaxHeight Then
          FMaxHeight := -Y + Top + Height;
      end;
    UpdateScrollSize;
  finally
    FNeedUpdateBorders := False;
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.UpdateScrollBars;
begin
  UpdateScrollPos;
  UpdateScrollSize;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.UpdateScrollPos;
begin
  If HandleAllocated Then
  begin
    If VertScrollVisible Then
    begin
      _SetScrollPos( Handle, SB_Vert, VertPosition );
      VertPosition := GetScrollPos( Handle, SB_Vert );
    end;
    If HorzScrollVisible Then
    begin
      _SetScrollPos( Handle, SB_Horz, HorzPosition );
      HorzPosition := GetScrollPos( Handle, SB_Horz );
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.UpdateScrollSize;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure SetHorzScroll;
  Var
    ScrollVisible : Boolean;
  begin
    ScrollVisible := HorzScrollVisible;
    If ScrollVisible Then
    begin
      _SetScrollSize( Handle, SB_Horz, 0, FMaxWidth - 1, ClientWidth );
      HorzPosition := GetScrollPos( Handle, SB_Horz );
    end
      Else
    begin
      _SetScrollSize( Handle, SB_Horz, 0, 0, -1 );
      HorzPosition := 0;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure SetVertScroll;
  Var
    ScrollVisible : Boolean;
  begin
    ScrollVisible := VertScrollVisible;
    If ScrollVisible Then
    begin
      _SetScrollSize( Handle, SB_Vert, 0, FMaxHeight - 1, ClientHeight );
      VertPosition := GetScrollPos( Handle, SB_Vert );
    end
      Else
    begin
      _SetScrollSize( Handle, SB_Vert, 0, 0, -1 );
      VertPosition := 0;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  If HandleAllocated Then
  begin
    SetVertScroll;
    SetHorzScroll;
  end;
end;

{------------------------------------------------------------------}

Function TDCCustomMenuEditor.VertScrollVisible : Boolean;
begin
  Result := FMaxHeight > ClientHeight;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.WMEraseBkgnd( Var Msg : TWMEraseBkgnd );
begin
  Msg.Result := 1;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.WMHScroll( Var Msg : TWMScroll );
begin
  Case Msg.ScrollCode Of
    SB_LineDown	  : HorzPosition := HorzPosition + sDCHorzScrollStep;
    SB_LineUp     : HorzPosition := HorzPosition - sDCHorzScrollStep;
    SB_PageDown   : HorzPosition := HorzPosition + ClientWidth;
    SB_PageUp     : HorzPosition := HorzPosition - ClientWidth;
    SB_ThumbTrack : HorzPosition := Msg.Pos;
  End;
  Msg.Result := 0;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.WMLButtonDown( Var Msg : TWMLButtonDown );
Var
  TopMenu : TDCMenuFolder;
begin
  Inherited;
  TopMenu := GetTopMenu;
  If TopMenu <> Nil Then
    TopMenu.SetFocus;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.WMSetFocus( Var Msg : TWMSetFocus );
begin
  Inherited;
  If Not Assigned( MenuDesigner ) Then
    Exit;
  MenuDesigner.SetFocus;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.WMSize( Var Msg : TWMSize );
begin
  Inherited;
  UpdateBorders;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.WMTimer( Var Msg : TWMTimer );
Var
  MousePos               : TPoint;
  OldHorzPos, OldVertPos : Integer;
begin
  If Msg.TimerID <> 1 Then
  begin
    Inherited;
    Exit;
  end;

  GetCursorPos( MousePos );
  MousePos := ScreenToClient( MousePos );

  OldHorzPos := HorzPosition;
  OldVertPos := VertPosition;
  If MousePos.X < 0 Then
    HorzPosition := HorzPosition - sDCHorzTimerScrollStep;
  If MousePos.X > ClientWidth Then
    HorzPosition := HorzPosition + sDCHorzTimerScrollStep;
  If MousePos.Y < 0 Then
    VertPosition := VertPosition - sDCVertTimerScrollStep;
  If MousePos.Y > ClientHeight Then
    VertPosition := VertPosition + sDCVertTimerScrollStep;

  If ( OldHorzPos = HorzPosition ) And ( OldVertPos = VertPosition ) Then
  begin
    KillTimer;
    Exit;
  end;
end;

{------------------------------------------------------------------}

procedure TDCCustomMenuEditor.WMVScroll( Var Msg : TWMScroll );
begin
  Case Msg.ScrollCode Of
    SB_LINEDown	  : VertPosition := VertPosition + sDCVertScrollStep;
    SB_LINEUp     : VertPosition := VertPosition - sDCVertScrollStep;
    SB_PAGEDown   : VertPosition := VertPosition + ClientHeight;
    SB_PAGEUp     : VertPosition := VertPosition - ClientHeight;
    SB_THUMBTRACK : VertPosition := Msg.Pos;
  End;
  Msg.Result := 0;
end;

{------------------------------------------------------------------}

{ TDCMenuFolder }

procedure TDCMenuFolder.CheckMenuAttributes;
begin
  If FInserting Or ( csDestroying In ComponentState ) Then
    Exit;

  CheckFictitiousItem;
  UpdateSize;

  If SelectedItem >= 0 Then
    With Items[ SelectedItem ] Do
      If Assigned( SubMenu ) Then
        SubMenu.CheckMenuAttributes;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.Click;
begin
  Inherited;
  GetRootFolder.DoGlobalMenuClick;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.DblClick;
begin
  Inherited;
  GetRootFolder.DoGlobalMenuDblClick;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.CMRelease( Var Msg : TMessage );
begin
  Inherited;
  Free;
end;

{------------------------------------------------------------------}

Function DCGetRealOwner( AMenuItem : TMenuItem ) : TComponent;
begin
  Result := AMenuItem.Owner;
  If AMenuItem.Parent = Nil Then // It is a root node of the menu
    Result := Result.Owner;
end;

Constructor TDCMenuFolder.Create( AOwner : TComponent; AParentItem : TDCMenuItem;
  AMenuItem : TMenuItem );
begin
  Inherited Create( AOwner );
  FMenuItem := AMenuItem;
  If Not Assigned( FMenuItem ) Then
    FMenuItem := TDCFictitiousMenuItem.Create( DCGetRealOwner( AParentItem.MenuItem ), AParentItem );

  FParentItem := AParentItem;
  FSelectedItem := -1;
  FDraggingItem := -1;
  FDropTargetItem := -1;

  FItems := TList.Create;
  Color := clBtnFace;

  Initialize;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.CreateSubMenu( AIndex : Integer );
begin
  If Items[ AIndex ].MenuItem Is TDCFictitiousMenuItem Then
    InsertItem( AIndex );
  Items[ AIndex ].CreateSubMenu;
  UpdateSize;
end;

{------------------------------------------------------------------}

Destructor TDCMenuFolder.Destroy;
Var
  I : Integer;
begin
  For I := 0 To Count - 1 Do
    Items[ I ].Free;
  FItems.Free;
  Inherited;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.DeleteItem( AIndex : Integer; AForce : Boolean );
Var
  WasRealItem : Boolean;
begin
  If ( AIndex < 0 ) Or ( Not Items[ AIndex ].ItemInMenu And Not AForce ) Then
    Exit;
  If ( AIndex < SelectedItem ) Or ( SelectedItem = Count - 1 ) Then
    SelectedItem := SelectedItem - 1;
  If ( AIndex = SelectedItem ) And ( SelectedItem < Count - 1 ) Then
    DoSelectionChanged( Items[ AIndex ], Items[ AIndex + 1 ] );
  WasRealItem := Items[ AIndex ].ItemInMenu;

{$IFNDEF D5}
  Inc( DCRemovingFictiousItem );
{$ENDIF}
  try
    Items[ AIndex ].Free;
    FItems.Delete( AIndex );
  finally
{$IFNDEF D5}
    Dec( DCRemovingFictiousItem );
{$ENDIF}
  end;
  
  If WasRealItem And ( MenuItem.Count <= 1 ) And Assigned( ParentItem ) Then
    With ParentItem.MenuFolder Do
    begin
      SelectedItem := SelectedItem;
      Invalidate;
      SetFocus;
    end;

  If AIndex = SelectedItem Then
    ShowSubMenuForSelectedItem;

  If WasRealItem Then
  begin
    TDCCustomMenuEditor( Parent ).MissNotification := True;
    try
      MenuItem.Items[ AIndex ].Free;
    finally
      TDCCustomMenuEditor( Parent ).MissNotification := False;
    end;
  end;

  UpdateSize;
  SelectedItem := SelectedItem;
  CheckFictitiousItem;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.DoGlobalMenuClick;
begin
  If Assigned( FOnGlobalMenuClick ) Then
    FOnGlobalMenuClick;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.DoGlobalMenuDblClick;
begin
  If Assigned( FOnGlobalMenuDblClick ) Then
    FOnGlobalMenuDblClick;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.DoSelectionChanged( AOldItem, ANewItem : TDCMenuItem );
begin
  If Assigned( FOnSelectionChanged ) Then
    FOnSelectionChanged( Self, AOldItem, ANewItem );
  If ParentItem <> Nil Then
    ParentItem.MenuFolder.DoSelectionChanged( AOldItem, ANewItem );
end;

{------------------------------------------------------------------}

Function TDCMenuFolder.GetCount : Integer;
begin
  Result := FItems.Count;
end;

{------------------------------------------------------------------}

Function TDCMenuFolder.GetImageShift: Integer;
{$IFDEF D4}
Var
  I         : Integer;
  ImageList : TCustomImageList;
{$ENDIF}
begin
  Result := sDCDefaultItemHeight - 2;
{$IFDEF D4}
  {$IFDEF D5}
  ImageList := MenuItem.SubMenuImages;//GetImageList;
  {$ELSE}
  ImageList := DCGetMenuImageListD4( MenuItem );
  {$ENDIF}
  If ImageList <> Nil Then
    For I := 0 To Count - 1 Do
      With Items[ I ].MenuItem Do
        If ( ImageIndex > -1 ) And ( ImageIndex < ImageList.Count ) Then
        begin
          Result := ImageList.Width + 3 + sDCButtonShift + sDCButtonSpaceAfter;
          System.break;
        end;
{$ENDIF}
  Result := Max( Result, sDCCheckBoxSpaceBefore + DefaultCheckWidth + sDCCheckBoxSpaceAfter );
end;

{------------------------------------------------------------------}

Function TDCMenuFolder.GetItemAt( X, Y : Integer ) : Integer;
Var
  MousePt  : TPoint;
  ItemRect : TRect;
begin
  InitItemRect( ItemRect );
  MousePt.X := X;
  MousePt.Y := Y;
  For Result := 0 To Count - 1 Do
  begin
    ShiftRectOnNextItem( ItemRect, Result );
    If PtInRect( ItemRect, MousePt ) Then
      Exit;
  end;
  Result := -1;
end;

{------------------------------------------------------------------}

Function TDCMenuFolder.GetItemHeight : Integer;
{$IFDEF D4}
Var
  ImageList : TCustomImageList;
{$ENDIF}  
begin
  Result := sDCDefaultItemHeight;
{$IFDEF D4}
  {$IFDEF D5}
  ImageList := MenuItem.SubMenuImages;
  If ImageList = Nil Then
    ImageList := MenuItem.GetImageList;
  {$ELSE}
  ImageList := DCGetMenuImageListD4( MenuItem );
  {$ENDIF}
  If ( ImageList <> Nil ) And ( ImageList.Height > sDCDefaultItemHeight - 2 ) Then
    Result := ImageList.Height + 2;
{$ENDIF}
end;

{------------------------------------------------------------------}

Function TDCMenuFolder.GetItems( AIndex : Integer ) : TDCMenuItem;
begin
  Result := TDCMenuItem( FItems[ AIndex ] );
end;

{------------------------------------------------------------------}

Function TDCMenuFolder.GetRootFolder : TDCMenuFolder;
begin
  Result := Self;
  While Result.ParentItem <> Nil Do
    Result := Result.ParentItem.MenuFolder;
end;

{------------------------------------------------------------------}

Function TDCMenuFolder.GetMaxItemsWidth : Integer;
Var
  I : Integer;
begin
  Result := 0;
  For I := 0 To Count - 1 Do
    If Result < Items[ I ].Width Then
      Result := Items[ I ].Width;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.Initialize;
Var
  I : Integer;
begin
  If Assigned( MenuItem ) Then
    With MenuItem Do
      For I := 0 To Count - 1 Do
        InsertMenuItem( I, Items[ I ] );
  UpdateSize;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.InitRegions( ACanvas : TCanvas );
Var
  I : Integer;
begin
  ExcludeClipRect( ACanvas.Handle, Left, Top, Left + Width, Top + Height );
  For I := 0 To Count - 1 Do
    With Items[ I ] Do
      If Assigned( SubMenu ) Then
        SubMenu.InitRegions( ACanvas );
end;

{------------------------------------------------------------------}

Procedure TDCMenuFolder.InsertItem( AIndex : Integer );
Var
  CreatedItem : TMenuItem;
begin
  CreatedItem := TMenuItem.Create( DCGetRealOwner( MenuItem ) );
  MenuItem.Insert( AIndex, CreatedItem );
  InsertMenuItem( AIndex, CreatedItem );
  If AIndex < SelectedItem Then
    FSelectedItem := FSelectedItem + 1
  Else
    If AIndex = SelectedItem Then
      DoSelectionChanged( Items[ AIndex + 1 ], Items[ AIndex ] );
  If ( Count = 2 ) And Items[ 1 ].ItemInMenu Then
    InsertMenuItem( 2, Nil );
  UpdateSize;
  Invalidate;
end;

{------------------------------------------------------------------}

Procedure TDCMenuFolder.InsertMenuItem( AIndex : Integer; AItem : TMenuItem );
begin
  FInserting := True;
  try
    If ( AIndex <= SelectedItem ) And ( SelectedItem >= 0 ) Then
      Items[ SelectedItem ].HideSubMenu;
    FItems.Insert( AIndex, GetMenuItemClass.Create( Self, AItem ) );
    Items[ AIndex ].UnderLayer := Parent;
    If AIndex <= SelectedItem Then
    begin
      AIndex := SelectedItem;
      FSelectedItem := -1;
      SelectedItem := AIndex;
    end;
  finally
    FInserting := False;
  end;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.InvalidateItems( Var AItemRect : TRect );
Var
  I : Integer;
begin
  InitItemRect( AItemRect );
  For I := 0 To Count - 1 Do
  begin
    ShiftRectOnNextItem( AItemRect, I );
    If I = SelectedItem Then
      FSelectedItemRect := AItemRect; 
    Items[ I ].DrawItem( Canvas, AItemRect, SelectedItem = I );
  end;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.JumpFirstItem;
begin
  SetFocus;
  SelectedItem := 0;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.KeyDown( Var AKey : Word; AShift : TShiftState );
begin
  Inherited;
  Case AKey Of
    VK_ESCAPE : MoveSelectionToParent;
    VK_LEFT   : MoveLeftward;
    VK_UP     : MoveUpward;
    VK_RIGHT  : If ssCtrl In AShift Then
                  CreateSubMenu( SelectedItem )
                Else
                  MoveRightward;
    VK_DOWN   : MoveDownward;
    VK_INSERT : InsertItem( SelectedItem );
    VK_DELETE : DeleteItem( SelectedItem, False );
  end;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.MoveSelectionDown;
begin
  If SelectedItem = Count - 1 Then
    SelectedItem := 0
  Else
    SelectedItem := SelectedItem + 1; 
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.MoveSelectionUp;
begin
  If SelectedItem = 0 Then
    SelectedItem := Count - 1
  Else
    SelectedItem := SelectedItem - 1;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.Release;
begin
  PostMessage( Handle, CM_RELEASE, 0, 0 );
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.SetNewSelectedItem( Var AValue : Integer );
begin
  If AValue < -1 Then
    AValue := -1;
  If AValue >= Count Then
    AValue := Count - 1;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.SetParent( AParent : TWinControl );
Var
  I : Integer;
begin
  Inherited SetParent( AParent );
  If csDestroying In ComponentState Then
    Exit;
  For I := 0 To Count - 1 Do
    Items[ I ].UnderLayer := Parent;
  UpdateSize;
end;

{------------------------------------------------------------------}

Procedure TDCMenuFolder.SetSelectedItem( AValue : Integer );
Var
  OldItem : TDCMenuItem;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Function GetMenuItem( AIndex : Integer ) : TDCMenuItem;
  begin
    If FSelectedItem = -1 Then
      Result := Nil
    Else
      Result := Items[ SelectedItem ];
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _MakeItemVisible;
  Var
    AMenuItemRect : TRect;
  begin
    If ( Parent = Nil ) Or ( SelectedItem < 0 ) Then
      Exit;
    AMenuItemRect := FSelectedItemRect;
    OffsetRect( AMenuItemRect, Left, Top );

    With TDCCustomMenuEditor( Parent ), AMenuItemRect Do
    begin
      If Left < 0 Then
         HorzPosition:= HorzPosition + Left
      Else
        If Right > ClientWidth Then
          If Right - Left > ClientWidth Then
            HorzPosition := HorzPosition - AMenuItemRect.Left
          Else
            HorzPosition := HorzPosition + Right - ClientWidth;

      If Top < 0 Then
        VertPosition := VertPosition + Top
      Else
        If Bottom > ClientHeight Then
          VertPosition := VertPosition + Bottom - ClientHeight;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  SetNewSelectedItem( AValue );

  If ( FSelectedItem >= 0 ) And ( Assigned( Items[ FSelectedItem ].SubMenu ) ) Then
    With Items[ FSelectedItem ].SubMenu Do
    begin
      If ( SelectedItem >= 0 ) And ( Self.SelectedItem = AValue ) Then
        DoSelectionChanged( Items[ SelectedItem ], Self.Items[ Self.SelectedItem ] );
      SelectedItem := -1;
    end;

  If FSelectedItem = AValue Then
  begin
    _MakeItemVisible;
    Exit;
  end;

  If FSelectedItem >= 0 Then
    With Items[ FSelectedItem ] Do
    begin
      HideSubMenu;
      If HandleAllocated Then
        DrawItem( Canvas, FSelectedItemRect, False );
    end;

  OldItem := GetMenuItem( FSelectedItem );
  FSelectedItem := AValue;
  If FSelectedItem >= 0 Then
  begin
    ShowSubMenuForSelectedItem;
    If HandleAllocated Then
    begin
      Items[ FSelectedItem ].DrawItem( Canvas, FSelectedItemRect, True );
      SetFocus;
    end;
    _MakeItemVisible;
  end;
  DoSelectionChanged( OldItem, GetMenuItem( FSelectedItem ) );
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.WMEraseBkgnd( Var Msg : TWMEraseBkgnd );
begin
  Msg.Result := 1;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.WMGetDlgCode( Var Msg : TWMGetDlgCode );
begin
  Msg.Result := DLGC_WANTARROWS;
end;

{------------------------------------------------------------------}

Procedure TDCMenuFolder.WMLButtonDown( Var Msg : TWMLButtonDown );
Var
  NewItem : Integer;
begin
  Inherited;
  NewItem := GetItemAt( Msg.XPos, Msg.YPos );
  If NewItem >= 0 Then
    SelectedItem := NewItem;
//  SetFocus;
  If ( NewItem >= 0 ) And Items[ NewItem ].ItemInMenu Then
  begin
    BeginDrag( False{$IFDEF D4}, 2{$ENDIF} );
    FDraggingItem := NewItem;
  end;
end;

{------------------------------------------------------------------}

Procedure DCCreateNewMenuItem( AMenuItem : TMenuItem; Var AExistingItem : TMenuItem );
Var
  CreatedItem : TMenuItem;
  SaveName    : TComponentName;
begin
  CreatedItem := TMenuItem.Create( DCGetRealOwner( AMenuItem ) );
  DCAssignMenuItems( AExistingItem, CreatedItem );
  SaveName := AExistingItem.Name;
  AExistingItem.Name := '';
  TDCFictitiousMenuItem( AExistingItem ).Free;
  AExistingItem := CreatedItem;
  CreatedItem.Name := SaveName;
  AMenuItem.Insert( AMenuItem.Count, CreatedItem );
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.ValidateChanges( AIndex : Integer );
begin
  If Items[ AIndex ].ItemInMenu Then
    Exit;
  With Items[ AIndex ] Do
  begin
    ValidateMenuItem;
    If SelectedItem = AIndex Then
      ShowSubMenu( GetItemRect( AIndex ) );
  end;
  InsertMenuItem( Count, Nil );
  UpdateSize;
  Click;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.WMChar( Var Msg : TWMChar );
begin
  Inherited;
  If ( Msg.CharCode > 31 ) Or ( Msg.CharCode = 13 ) Then
  begin
    ShowInspectorEx( True );
    If Screen.ActiveControl <> Self Then
      Screen.ActiveControl.Dispatch( Msg );
  end;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.UpdateSize;
begin
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.DragOver( Source : TObject; X, Y : Integer; State : TDragState;
  Var Accept : Boolean );
Var
  DragOverItem : Integer;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Function TraceParent : Boolean;
  Var
    SourceItem, TraceItem : TDCMenuItem;
  begin
    Result := TDCMenuDragObject( Source ).Control = Self;
    If Result Then
      Exit;

    With TDCMenuFolder( TDCMenuDragObject( Source ).Control ) Do
      SourceItem := Items[ FDraggingItem ];
    TraceItem := ParentItem;
    While TraceItem <> Nil Do
    begin
      If SourceItem = TraceItem Then
        Exit;
      TraceItem := TraceItem.MenuFolder.ParentItem;
    end;
    Result := True;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  Inherited;
  Accept := Source.InheritsFrom( TDCMenuDragObject );
  If Not Accept Then
    Exit; 

  FDraggedOver := True;
  DragOverItem := GetItemAt( X, Y );
  Accept := ( DragOverItem >= 0 ) And ( DragOverItem <> FDraggingItem ) And
            ( ( FDraggingItem < 0 ) Or Items[ DragOverItem ].ItemInMenu ) And TraceParent;
  TDCMenuDragObject( Source ).NotifyObject := Self;
  If Accept Then
    DropTargetItem := DragOverItem;
  If DragOverItem = FDraggingItem Then
    TDCMenuDragObject( Source ).NotifyObject := Nil;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.DoEndDrag( Target : TObject; X, Y : Integer );
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _ChangeSelection( AFolder : TDCMenuFolder; ANewSection : Integer );
  begin
    With AFolder Do
    begin
      If SelectedItem = ANewSection Then
        Exit;
      If Assigned( ParentItem ) Then
        _ChangeSelection( ParentItem.MenuFolder, ParentItem.Index );
      SelectedItem := ANewSection;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
Var
  SaveItem : TMenuItem;
begin
  If FDraggingItem < 0 Then
    Exit;

  If Target = Nil Then
    Target := Self;

  If Not Target.InheritsFrom( TDCMenuFolder ) Then
  begin
    FDraggingItem := -1;
    Exit;
  end;

  With TDCMenuFolder( Target ) Do
    If DropTargetItem >= 0 Then
      Items[ DropTargetItem ].HideSubMenu;
  If ( ( Target <> Self ) Or ( FDraggingItem <> DropTargetItem ) ) And
     ( TDCMenuFolder( Target ).DropTargetItem >= 0 ) Then
  begin
    SelectedItem := -1;
    SaveItem := Items[ FDraggingItem ].MenuItem;
    Items[ FDraggingItem ].Free;
    FItems.Delete( FDraggingItem );
    MenuItem.Delete( FDraggingItem );

    With TDCMenuFolder( Target ) Do
    begin
      MenuItem.Insert( DropTargetItem, SaveItem );
      InsertMenuItem( DropTargetItem, SaveItem );
      CheckFictitiousItem;
      SetFocus;
    end;
    If Target <> Self Then
    begin
      UpdateSize;
      TDCMenuFolder( Target ).UpdateSize;
    end;
    _ChangeSelection( TDCMenuFolder( Target ), TDCMenuFolder( Target ).DropTargetItem );
    Invalidate;
  end;
  TDCMenuFolder( Target ).FDropTargetItem := -1;
  FDraggingItem := -1;
  Inherited;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.DrawImageOnDragItem;
begin
  Canvas.Font.Color := clBlack;
  Canvas.Brush.Color := clWhite;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.SetDropTargetItem( AValue : Integer );
Var
  Save : Integer;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Function DraggingOver( MenuFolder : TDCMenuFolder ) : Boolean;
  Var
    Pt : TPoint;
  begin
    Result := Not Assigned( MenuFolder );
    If Result Then
      Exit;
    GetCursorPos( Pt );
    With MenuFolder Do
      Result := PtInRect( ClientRect, ScreenToClient( Pt ) );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _HideFromRootUnselected( AStartItem : TDCMenuItem );
  Var
    Item : TDCMenuItem;
    Pt   : TPoint;
  begin
    Item := AStartItem;
    If Item.MenuFolder.SelectedItem >= 0 Then
      Exit;
    GetCursorPos( Pt );
    Pt := Item.MenuFolder.ScreenToClient( Pt );
    While ( Item.MenuFolder.FDraggingItem < 0 ) And ( Item.MenuFolder.DropTargetItem < 0 ) And
          ( Item.MenuFolder.ParentItem <> Nil ) And
          Not PtInRect( Item.MenuFolder.ClientRect, Pt ) Do
      Item := Item.MenuFolder.ParentItem;
    If Item <> AStartItem Then
      Item.HideSubMenu;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
Var
  Pt : TPoint;
begin
  GetCursorPos( Pt );
  If ( FDropTargetItem < 0 ) And ( AValue < 0 ) And FDraggedOver And
     Not PtInRect( ClientRect, ScreenToClient( Pt ) ) Then
    _HideFromRootUnselected( Items[ 0 ] );

  If FDropTargetItem = AValue Then
    Exit;
  DrawImageOnDragItem;
  If ( FDropTargetItem >= 0 ) And ( FDropTargetItem <> FDraggingItem ) And
     Not Items[ FDropTargetItem ].IsDragSource And
     Not DraggingOver( Items[ FDropTargetItem ].SubMenu ) Then
    Items[ FDropTargetItem ].HideSubMenu;
  Save := FDropTargetItem;
  FDropTargetItem := AValue;
  GetCursorPos( Pt );
  If AValue >= 0 Then
  begin
    FDropTargetItemRect := GetItemRect( AValue );
    If AValue >= 0 Then
      Items[ AValue ].ShowSubMenu( FDropTargetItemRect );
  end
  Else
    With Items[ Save ] Do
      If Not Assigned( SubMenu ) Or
         Not PtInRect( SubMenu.ClientRect, SubMenu.ScreenToClient( Pt ) ) Then
        _HideFromRootUnselected( Items[ Save ] );
  DrawImageOnDragItem;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.DoStartDrag( Var DragObject : TDragObject );
begin
  Inherited;
  If DragObject = Nil Then
    DragObject := TDCMenuDragObject.Create( Self );
end;

{------------------------------------------------------------------}

Function TDCMenuFolder.GetItemRect( AIndex : Integer ) : TRect;
begin
  Result := Rect( 0, 0, 0, 0 );
end;

{------------------------------------------------------------------}

Function TDCMenuFolder.GetMenuItemClass : TDCMenuItemClass;
begin
  Result := TDCMenuItem; 
end;

{------------------------------------------------------------------}

Procedure TDCMenuFolder.InitItemRect( Var AItemRect : TRect );
begin
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.MoveDownward;
begin
end;

{------------------------------------------------------------------}

Procedure TDCMenuFolder.MoveLeftward;
begin
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.MoveRightward;
begin
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.MoveSelectionToParent;
begin
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.MoveUpward;
begin
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.ShiftRectOnNextItem( Var AItemRect : TRect; ANewItem : Integer );
begin
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.WMWindowPosChanged( Var Msg : TWMWindowPosChanged );
begin
  Inherited;
  If ( Parent <> Nil ) And Not ( csDestroying In ComponentState ) Then
    TDCCustomMenuEditor( Parent ).UpdateBorders;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.RealignControls;
begin
  If ( SelectedItem >= 0 ) And Assigned( Items[ SelectedItem ].SubMenu ) Then
    With Items[ SelectedItem ] Do
    begin
      FSelectedItemRect := GetItemRect( SelectedItem );
      InitSubMenu( FSelectedItemRect );
    end;
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.ShowSubMenuForSelectedItem;
begin
  If SelectedItem < 0 Then
    Exit;
  FSelectedItemRect := GetItemRect( SelectedItem );
  Items[ SelectedItem ].ShowSubMenu( FSelectedItemRect );
end;

{------------------------------------------------------------------}

procedure TDCMenuFolder.CheckFictitiousItem;
begin
  If Count = 0 Then
  begin
    InsertMenuItem( Count, Nil );
    UpdateSize;
  end;
end;

{------------------------------------------------------------------}

{ TDCMainMenuFolder }

Constructor TDCMainMenuFolder.Create( AOwner : TComponent; AParentItem : TDCMenuItem;
  AMenuItem : TMenuItem );
begin
  Inherited;
  SelectedItem := 0;
end;

{------------------------------------------------------------------}

Function TDCMainMenuFolder.GetItemRect( AIndex : Integer ) : TRect;
Var
  I : Integer;
begin
  Result.Left := 0;
  For I := 0 To AIndex - 1 Do
    Result.Left := Result.Left + Items[ I ].Width;
  Result.Right := Result.Left + Items[ AIndex ].Width;
  Result.Top := 0;
  Result.Bottom := ItemHeight;
end;

{------------------------------------------------------------------}

Function TDCMainMenuFolder.GetImageShift: Integer;
begin
  Result := 0;
end;

{------------------------------------------------------------------}

procedure TDCMainMenuFolder.Initialize;
begin
  Inherited;
  CheckFictitiousItem;
end;

{------------------------------------------------------------------}

Procedure TDCMainMenuFolder.Paint;
Var
  ItemRect : TRect;
begin
  InvalidateItems( ItemRect );

  ItemRect.Left := ItemRect.Right;
  ItemRect.Right := ClientWidth;
  Canvas.Brush.Color := clMenu;
  Canvas.FillRect( ItemRect );
  
  DrawImageOnDragItem;
end;

{------------------------------------------------------------------}

procedure TDCMainMenuFolder.ShiftRectOnNextItem( Var AItemRect : TRect; ANewItem : Integer );
begin
  AItemRect.Left := AItemRect.Right;
  AItemRect.Right := AItemRect.Left + Items[ ANewItem ].Width;
end;

{------------------------------------------------------------------}

procedure TDCMainMenuFolder.InitItemRect( Var AItemRect: TRect );
begin
  AItemRect := Rect( 0, 0, 0, ClientHeight );
end;

{------------------------------------------------------------------}

Function TDCMainMenuFolder.GetMenuItemClass : TDCMenuItemClass;
begin
  Result := TDCMainMenuItem;
end;

{------------------------------------------------------------------}

procedure TDCMainMenuFolder.MoveRightward;
begin
  MoveSelectionDown;
//  SetFocus;
end;

{------------------------------------------------------------------}

procedure TDCMainMenuFolder.MoveLeftward;
begin
  MoveSelectionUp;
//  SetFocus;
end;

{------------------------------------------------------------------}

procedure TDCMainMenuFolder.MoveDownward;
begin
  If Assigned( Items[ SelectedItem ].SubMenu ) Then
    Items[ SelectedItem ].SubMenu.JumpFirstItem;
end;

{------------------------------------------------------------------}

procedure TDCMainMenuFolder.MoveUpward;
begin
  // Do nothing.
end;

{------------------------------------------------------------------}

procedure TDCMainMenuFolder.UpdateSize;
Var
  I, Len : Integer;
begin
  Len := 0;
  For I := 0 To Count - 1 Do
    Len := Len + Items[ I ].Width;

  Height := ItemHeight;
  Width := Len;

  RealignControls;
  Inherited;
end;

{------------------------------------------------------------------}

procedure TDCMainMenuFolder.MoveSelectionToParent;
begin
end;

{------------------------------------------------------------------}

procedure TDCMainMenuFolder.DrawImageOnDragItem;
begin
  If DropTargetItem < 0 Then
    Exit;
  Inherited;
  With FDropTargetItemRect Do
    If ( FDraggingItem >= 0 ) And ( DropTargetItem > FDraggingItem ) Then
      Canvas.DrawFocusRect( Rect( Right - 2, Top, Right, Bottom ) )
    Else
      Canvas.DrawFocusRect( Rect( Left, Top, Left + 2, Bottom ) );
end;

{------------------------------------------------------------------}

procedure TDCMainMenuFolder.ValidateChanges( AIndex : Integer );
begin
  Inherited;
  If ( AIndex = SelectedItem ) And Assigned( Items[ AIndex ].SubMenu ) Then
    Items[ AIndex ].SubMenu.SelectedItem := 0
end;

{------------------------------------------------------------------}

procedure TDCMainMenuFolder.CheckFictitiousItem;
begin
  Inherited;
  If Items[ Count - 1 ].ItemInMenu Then
  begin
    InsertMenuItem( Count, Nil );
    UpdateSize;
  end;
end;

{------------------------------------------------------------------}

{ TDCMenuItem }

constructor TDCMenuItem.Create( AMenuFolder : TDCMenuFolder; AMenuItem : TMenuItem );
begin
  Inherited Create;
  FMenuFolder := AMenuFolder;
  FMenuItem := AMenuItem;
  FItemInMenu := Assigned( AMenuItem );
  If Not FItemInMenu Then
    FMenuItem := TDCFictitiousMenuItem.Create( DCGetRealOwner( FMenuFolder.MenuItem ), Self );
end;

{------------------------------------------------------------------}

Destructor TDCMenuItem.Destroy;
begin
  If Not ItemInMenu Then
    FMenuItem.Free;
  FSubMenu.Free;
  Inherited;
end;

{------------------------------------------------------------------}

procedure TDCMenuItem.DrawItem( ACanvas : TCanvas; AItemRect : TRect; ASelected : Boolean );
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _DrawItemText( AShift : Integer );
  Var
    TextRect : TRect;
    Text     : String;
  begin
    TextRect := AItemRect;
    TextRect.Left := TextRect.Left + AShift;
    TextRect.Top := TextRect.Top + 1;
    Text := MenuItem.Caption;
    InitFontForDefault( ACanvas.Font );
    DrawText( ACanvas.Handle, pChar( Text ), Length( Text ), TextRect, GetTextDrawingFlags Or DT_CALCRECT Or DT_NOCLIP );
    If Not MenuItem.Enabled Then
      If ASelected Then
      begin
        ACanvas.Font.Color := clBtnShadow;
        DrawText( ACanvas.Handle, pChar( Text ), Length( Text ), TextRect, GetTextDrawingFlags );
      end
      Else
        DCDrawDisabledText( ACanvas, TextRect, Text, GetTextDrawingFlags )
    Else
      DrawText( ACanvas.Handle, pChar( Text ), Length( Text ), TextRect, GetTextDrawingFlags );
    DCFillExcludeRect( ACanvas, AItemRect, TextRect );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _DrawDividerItem;
  Var
    TextRect : TRect;
  begin
    TextRect := AItemRect;
    With TextRect Do
    begin
      Inc( Left, 2 );
      Top := Top + ( Bottom - Top - 2 ) Shr 1;
      Bottom := Top + 2;
      Dec( Right, 2 );
    end;
    DrawEdge( ACanvas.Handle, TextRect, EDGE_ETCHED, BF_TOP );
    DCFillExcludeRect( ACanvas, AItemRect, TextRect );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  InitCanvas( ACanvas, ASelected );
  If MenuItem.Caption = {$IFDEF D5}cLineCaption{$ELSE}'-'{$ENDIF} Then
  begin
    _DrawDividerItem;
    Exit;
  end;
  If HasImage Or ( MenuItem.Caption <> '' ) Then
    DrawImage( ACanvas, AItemRect, ASelected );
  If MenuItem.Caption = '' Then
    DrawEmptyItem( ACanvas, AItemRect, ASelected )
  Else
    If MenuFolder Is TDCMainMenuFolder Then
      _DrawItemText( sDCMenuItemSpace - 2 )
    Else
      _DrawItemText( sDCSubMenuItemSpaceLeft );
end;

{------------------------------------------------------------------}

Function TDCMenuItem.GetTextDrawingFlags : Integer;
begin
  Result := DT_VCENTER;// Or DT_NOCLIP;
end;

{------------------------------------------------------------------}

Function TDCMenuItem.HasImage : Boolean;
begin
{$IFDEF D4}
  With MenuItem Do
    Result := ( ( {$IFDEF D5}GetImageList{$ELSE}DCGetMenuImageListD4( MenuItem ){$ENDIF} <> Nil ) And ( ImageIndex > -1 ) And
                ( ImageIndex < {$IFDEF D5}GetImageList{$ELSE}DCGetMenuImageListD4( MenuItem ){$ENDIF}.Count ) ) Or
              ( ( Bitmap <> Nil ) And Not Bitmap.Empty );
{$ELSE}
  Result := False;
{$ENDIF}
end;

{------------------------------------------------------------------}

procedure TDCMenuItem.HideSubMenu;
begin
  If FSubMenu = Nil Then
    Exit;
  FSubMenu.Release;
  FSubMenu := Nil;
end;

{------------------------------------------------------------------}

procedure TDCMenuItem.SetUnderLayer( AValue : TWinControl );
begin
  If FUnderLayer = AValue Then
    Exit;
  FUnderLayer := AValue;
  If Assigned( SubMenu ) Then
    SubMenu.Parent := AValue;
end;

{------------------------------------------------------------------}

procedure TDCMenuItem.ShowSubMenu( Const AItemRect : TRect );
begin
  If Assigned( FSubMenu ) Or ( MenuItem.Count = 0 ) Then
    Exit;
  FSubMenu := TDCPopupMenuFolder.Create( MenuFolder.Owner, Self, MenuItem );
  FSubMenu.Parent := UnderLayer;

  InitSubMenu( AItemRect );
end;

{------------------------------------------------------------------}

Function TDCMenuItem.GetWidth : Integer;
Var
  DC         : HDC;
  SaveIndex  : Integer;
  ItemRect   : TRect;
  ImageShift : Integer;
  Canvas     : TControlCanvas;
begin
  If MenuItem.Caption = '' Then
    Result := sDCDefaultItemWidth
  Else
  begin
    DC := GetWindowDC( 0 );
    try
      Canvas := TControlCanvas.Create;
      With Canvas Do
      try
        SaveIndex := SaveDC( DC );
        try
          Handle := DC;
        {$IFDEF D5}
          Font := Screen.MenuFont;
        {$ENDIF}
          InitFontForDefault( Font );
          DrawText( Handle, pChar( MenuItem.Caption ), Length( MenuItem.Caption ), ItemRect, GetTextDrawingFlags Or DT_CALCRECT Or DT_NOCLIP );
          Result := ItemRect.Right - ItemRect.Left;
        finally
          Handle := 0;
          RestoreDC( DC, SaveIndex );
        end;
      finally
        Canvas.Free;
      end;
    finally
      ReleaseDC( 0, DC );
    end;
  end;
  ImageShift := MenuFolder.ImageShift;
  If ImageShift = 0 Then
    ImageShift := GetImageWidth; 
  Result := Result + ImageShift;
end;

{------------------------------------------------------------------}

procedure TDCMenuItem.DrawEmptyItem( ACanvas : TCanvas; Var AItemRect : TRect; ASelected : Boolean );
begin
  ACanvas.FillRect( AItemRect );
  InflateRect( AItemRect, -2, -2 );
  DrawFocusRect( ACanvas.Handle, AItemRect );
end;

{------------------------------------------------------------------}

Procedure TDCMenuItem.DrawImage( ACanvas : TCanvas; Var AItemRect : TRect; ASelected : Boolean );
Const
  CheckState : Array[ Boolean ] Of TCheckBoxState = ( cbUnchecked, cbChecked );
Var
  ImageShift     : Integer;
{$IFDEF D4}
  ShowImage      : Boolean;
{$ENDIF}
  OuterCheckRect : TRect;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _DrawImageFrame( Var ARect : TRect; AChecked : Boolean );
  begin
    With ACanvas Do
    begin
      With ARect Do
      begin
        ACanvas.FillRect( Rect( Left, Top, Left + sDCButtonShift, Bottom ) );
        Inc( Left, sDCButtonShift );
      end;
      If Not AChecked Then
        If ASelected Then
          DrawEdge( Handle, ARect, BDR_RAISEDINNER, BF_ADJUST Or BF_RECT )
        Else
          With ACanvas Do
          begin
            Pen.Color := clMenu;
            DCDrawEmptyRect( ACanvas, ARect );
            InflateRect( ARect, -1, -1 );
          end
      Else
        DrawEdge( Handle, ARect, BDR_SUNKENOUTER, BF_ADJUST Or BF_RECT );
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _DrawBitmapImage( ARect : TRect; AChecked : Boolean; ABitmap : TBitmap );
  Var
    ImageRect : TRect;
  begin
    _DrawImageFrame( ARect, AChecked );
    ImageRect := ARect;
    With ImageRect Do
    begin
      If ABitmap.Width < Right - Left Then
      begin
        Left := Left + ( Right - Left - ABitmap.Width ) Shr 1;
        Right := Left + ABitmap.Width;
      end;
      If ABitmap.Height < Bottom - Top Then
      begin
        Top := Top + ( Bottom - Top - ABitmap.Height ) Shr 1;
        Bottom := Top + ABitmap.Height;
      end;
    end;
    DCStretchDraw( ACanvas, ImageRect, ABitmap );
    DCFillExcludeRect( ACanvas, ARect, ImageRect );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _DrawImageFromList( ARect : TRect; AChecked : Boolean; AImageList : TImageList;
    AImageIndex : Integer );
  begin
    _DrawImageFrame( ARect, AChecked );
    DCImageList_DrawCentered( AImageList, AImageIndex, ACanvas, ARect,
                              ColorToRGB( ACanvas.Brush.Color ), CLR_NONE, ILD_NORMAL );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _DrawCheckBox;
  Var
    ImageType : UINT;
  begin
    If MenuItem.Checked Then
    begin
      With OuterCheckRect Do
      begin
        ACanvas.FillRect( Rect( Left, Top, Left + sDCCheckBoxSpaceBefore, Bottom ) );
        Left := Left + sDCCheckBoxSpaceBefore;
      end;
      If MenuItem.RadioItem Then
        ImageType := DFCS_MenuBullet
      Else
        ImageType := DFCS_MenuCheck;
      DCDrawMenuItemImage( ACanvas, OuterCheckRect, True, ImageType );
    end
    Else
      ACanvas.FillRect( OuterCheckRect );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
{$IFDEF D4}
  With MenuItem Do
    ShowImage := HasImage;
{$ENDIF}

  OuterCheckRect := AItemRect;
  ImageShift := MenuFolder.ImageShift;
  If ImageShift = 0 Then
    ImageShift := GetImageWidth;
  OuterCheckRect.Right := OuterCheckRect.Left + ImageShift;
  AItemRect.Left := OuterCheckRect.Right;

{$IFDEF D4}
  If ShowImage Then
  begin
    ACanvas.Brush.Color := clMenu;
    With MenuItem Do
      If ( Bitmap <> Nil ) And Not Bitmap.Empty Then
        _DrawBitmapImage( OuterCheckRect, Checked, Bitmap )
      Else
        _DrawImageFromList( OuterCheckRect, Checked, TImageList( {$IFDEF D5}GetImageList{$ELSE}DCGetMenuImageListD4( MenuItem ){$ENDIF} ),
                            ImageIndex );
      With OuterCheckRect Do
      begin
        ACanvas.FillRect( Rect( Right, Top,
                                Right + sDCButtonSpaceAfter, Bottom ) );
        Inc( AItemRect.Left, sDCButtonSpaceAfter );
      end;
    InitCanvas( ACanvas, ASelected );
  end
  Else
{$ENDIF}  
    _DrawCheckBox;
end;

{------------------------------------------------------------------}

procedure TDCMenuItem.InitCanvas( ACanvas : TCanvas; ASelected : Boolean );
begin
  If ASelected Then
  begin
    ACanvas.Font.Color := clHighLightText;
    ACanvas.Brush.Color := clHighLight;
  end
    Else
  begin
    ACanvas.Font.Color := clMenuText;
    ACanvas.Brush.Color := clMenu;
  end;
end;

{------------------------------------------------------------------}

procedure TDCMenuItem.CreateSubMenu;
Var
  Idx      : Integer;
  ItemRect : TRect;
begin
  If MenuItem.Count = 0 Then
    MenuItem.Insert( 0, TMenuItem.Create( DCGetRealOwner( MenuItem ) ) );
  Idx := Index;
  ItemRect := MenuFolder.GetItemRect( Idx );
  DrawItem( MenuFolder.Canvas, ItemRect, Idx = MenuFolder.SelectedItem );
  ShowSubMenu( ItemRect );
  SubMenu.JumpFirstItem;
end;

{------------------------------------------------------------------}

Function TDCMenuItem.GetImageWidth : Integer;
{$IFDEF D4}
Var
  ImageList : TCustomImageList;
{$ENDIF}
begin
  Result := 0;
{$IFDEF D4}
  With MenuItem Do
  begin
    ImageList := {$IFDEF D5}GetImageList{$ELSE}DCGetMenuImageListD4( MenuItem ){$ENDIF};
    If ( ImageList <> Nil ) And ( ImageIndex > -1 ) And ( ImageIndex < ImageList.Count ) Then
      Result := ImageList.Width
    Else
      If ( Bitmap <> Nil ) And Not Bitmap.Empty Then
        Result := MenuFolder.ItemHeight;
  end;
{$ENDIF}  
end;

{------------------------------------------------------------------}

Function TDCMenuItem.GetIndex : Integer;
begin
  Result := MenuFolder.FItems.IndexOf( Self );
end;

{------------------------------------------------------------------}

procedure TDCMenuItem.ValidateMenuItem;
begin
  If ItemInMenu Then
    Exit;
  DCCreateNewMenuItem( MenuFolder.MenuItem, FMenuItem );
  FItemInMenu := True;
end;

{------------------------------------------------------------------}

Function TDCMenuItem.IsDragSource : Boolean;
begin
  Result := Assigned( SubMenu );
  If Result Then
    With SubMenu Do
      Result := ( FDraggingItem >= 0 ) Or
                ( ( SelectedItem >= 0 ) And ( Items[ SelectedItem ].IsDragSource ) );
end;

{------------------------------------------------------------------}

procedure TDCMenuItem.InitSubMenu( Const AItemRect : TRect );
begin
end;

{------------------------------------------------------------------}

procedure TDCMenuItem.InitFontForDefault( AFont : TFont );
begin
  If MenuItem.Default Then
    AFont.Style := AFont.Style + [fsBold]
  Else
    AFont.Style := AFont.Style - [fsBold];
end;

{------------------------------------------------------------------}

{ TDCPopupMenuFolder }

procedure TDCPopupMenuFolder.CheckFictitiousItem;
begin
  Inherited;
  If ( MenuItem.Count = 1 ) And ( MenuItem.Items[0].Caption <> '' ) And ( Count = 1 ) Then
  begin
    InsertMenuItem( Count, Nil );
    UpdateSize;
  end;
  If ( Count = 2 ) And ( MenuItem.Count = 1 ) And ( MenuItem.Items[0].Caption = '' ) And
     ( ParentItem <> Nil ) And ParentItem.InheritsFrom( TDCPopupMenuItem ) Then
    DeleteItem( Count - 1, True );
end;

{------------------------------------------------------------------}

procedure TDCPopupMenuFolder.DeleteItem( AIndex : Integer; AForce : Boolean );
begin
  Inherited;
  If ( MenuItem.Count = 0 ) And Assigned( ParentItem ) And
     ParentItem.InheritsFrom( TDCPopupMenuItem ) Then
  begin
    ParentItem.HideSubMenu;
    ParentItem.MenuFolder.UpdateSize;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPopupMenuFolder.DrawImageOnDragItem;
begin
  If DropTargetItem < 0 Then
    Exit;
  Inherited;
  With FDropTargetItemRect Do
    If ( FDraggingItem >= 0 ) And ( DropTargetItem > FDraggingItem ) Then
      Canvas.DrawFocusRect( Rect( Left, Bottom - 2, Right, Bottom ) )
    Else
      Canvas.DrawFocusRect( Rect( Left, Top, Right, Top + 2 ) );
end;

{------------------------------------------------------------------}

Function TDCPopupMenuFolder.GetItemRect( AIndex : Integer ) : TRect;
begin
  Result.Top := 2 + ItemHeight * AIndex + sDCPopupSpaceTop;
  Result.Bottom := Result.Top + ItemHeight;
  Result.Left := 2 + sDCPopupSpaceLeft;
  Result.Right := Width - 2 - sDCPopupSpaceRight;
end;

{------------------------------------------------------------------}

Function TDCPopupMenuFolder.GetMenuItemClass : TDCMenuItemClass;
begin
  Result := TDCPopupMenuItem;
end;

{------------------------------------------------------------------}

procedure TDCPopupMenuFolder.Initialize;
begin
  If ( ParentItem = Nil ) Or ParentItem.InheritsFrom( TDCMainMenuItem ) Or 
     Not ( ( MenuItem.Count = 1 ) And ( MenuItem.Items[0].Caption = '' ) ) Then
    InsertMenuItem( 0, Nil );
  Inherited;
end;

{------------------------------------------------------------------}

procedure TDCPopupMenuFolder.InitItemRect( Var AItemRect : TRect );
begin
  AItemRect := Rect( 2 + sDCPopupSpaceLeft, 2 + sDCPopupSpaceTop,
                     Width - 2 - sDCPopupSpaceRight, 2 + sDCPopupSpaceBottom );
end;

{------------------------------------------------------------------}

procedure TDCPopupMenuFolder.MoveDownward;
begin
  MoveSelectionDown;
end;

{------------------------------------------------------------------}

procedure TDCPopupMenuFolder.MoveLeftward;
begin
  If Not Assigned( ParentItem ) Then
    Exit;
  If ParentItem Is TDCMainMenuItem Then
  begin
    ParentItem.MenuFolder.MoveLeftward;
    ParentItem.MenuFolder.SetFocus;
  end
  Else
    MoveSelectionToParent;
end;

{------------------------------------------------------------------}

procedure TDCPopupMenuFolder.MoveRightward;
begin
  If Assigned( Items[ SelectedItem ].SubMenu ) Then
    With Items[ SelectedItem ].SubMenu Do
      JumpFirstItem
  Else
    If Assigned( ParentItem ) Then
      GetRootFolder.MoveRightward;
end;

{------------------------------------------------------------------}

procedure TDCPopupMenuFolder.MoveSelectionToParent;
begin
  If ParentItem = Nil Then
    Exit;
  With ParentItem.MenuFolder Do
    SelectedItem := SelectedItem;
  ParentItem.MenuFolder.SetFocus;
end;

{------------------------------------------------------------------}

procedure TDCPopupMenuFolder.MoveUpward;
begin
  MoveSelectionUp; 
end;

{------------------------------------------------------------------}

Procedure TDCPopupMenuFolder.Paint;
Var
  ItemRect : TRect;
begin
  ItemRect := Rect( 0, 0, ClientWidth, ClientHeight );
  DrawEdge( Canvas.Handle, ItemRect, EDGE_RAISED, BF_ADJUST Or BF_RECT );
  Canvas.Brush.Color := clMenu;
  With ItemRect Do
    Canvas.FillRect( Rect( Left, Top, Right, Top + sDCPopupSpaceTop ) );

  InvalidateItems( ItemRect );

  Canvas.Brush.Color := clMenu;
  With ItemRect Do
  begin
    Canvas.FillRect( Rect( Left, Bottom, Right, Bottom + sDCPopupSpaceBottom ) );
    Canvas.FillRect( Rect( Left - sDCPopupSpaceLeft, 2, Left, Bottom + sDCPopupSpaceBottom ) );
    Canvas.FillRect( Rect( Right, 2, Right + sDCPopupSpaceRight, Bottom + sDCPopupSpaceBottom ) );
  end;
  DrawImageOnDragItem;
end;

{------------------------------------------------------------------}

procedure TDCPopupMenuFolder.ShiftRectOnNextItem( Var AItemRect : TRect; ANewItem : Integer );
begin
  AItemRect.Top := AItemRect.Bottom;
  AItemRect.Bottom := AItemRect.Top + ItemHeight;
end;

{------------------------------------------------------------------}

procedure TDCPopupMenuFolder.UpdateSize;
begin
  Width := GetMaxItemsWidth + 4;
  Height := ItemHeight * Count + 4 + sDCPopupSpaceTop + sDCPopupSpaceBottom;

  RealignControls;
  Inherited;
end;

{------------------------------------------------------------------}

procedure TDCPopupMenuFolder.ValidateChanges(AIndex: Integer);
begin
  Inherited;
  If SelectedItem = AIndex Then
  begin
    SelectedItem := Count - 1;
    SetFocus;
  end;
end;

{------------------------------------------------------------------}

{ TDCMainMenuItem }

procedure TDCMainMenuItem.DrawImage( ACanvas : TCanvas; Var AItemRect : TRect;
  ASelected : Boolean );
begin
  If HasImage Then
    Inherited;
end;

{------------------------------------------------------------------}

Function TDCMainMenuItem.GetWidth: Integer;
begin
  Result := Inherited GetWidth;
  If MenuItem.Caption <> '' Then
    Result := Result + sDCMenuItemSpace Shl 1;
end;

{------------------------------------------------------------------}

procedure TDCMainMenuItem.InitSubMenu( Const AItemRect : TRect );
begin
  SubMenu.Left := MenuFolder.Left + AItemRect.Left;
  SubMenu.Top := MenuFolder.Top + AItemRect.Bottom;
end;

{------------------------------------------------------------------}

procedure TDCMainMenuItem.ShowSubMenu( Const AItemRect : TRect );
begin
  If Assigned( FSubMenu ) Then
    Exit;
  If ( MenuItem.Count = 0 ) And ItemInMenu Then
  begin
    FSubMenu := TDCPopupMenuFolder.Create( MenuFolder.Owner, Self, MenuItem );
    FSubMenu.Parent := UnderLayer;

    InitSubMenu( AItemRect );
  end
  Else
    Inherited;
end;

{------------------------------------------------------------------}

{ TDCPopupMenuItem }

procedure TDCPopupMenuItem.DrawItem( ACanvas : TCanvas; AItemRect : TRect; ASelected : Boolean );
Var
  ShortCutLength : Integer;
  ShortCutText   : String;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _DrawSubMenuImage;
  begin
    AItemRect.Left := AItemRect.Right;
    AItemRect.Right := AItemRect.Right + sDCSubMenuImageWidth;
    DCDrawMenuItemImage( ACanvas, AItemRect, False, DFCS_MENUARROW );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _DrawShortCut;
  begin
    With AItemRect Do
    begin
      Left := Right;
      Right := Right + ShortCutLength + sDCShortCutSpaceLeft + sDCShortCutSpaceRight +
                       sDCSubMenuImageWidth;
      With ACanvas Do
        TextRect( AItemRect, Left + sDCShortCutSpaceLeft, Top + 1,
                  ShortCutText );
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
Var
  AShowSubMenuImage : Boolean;
  AShowShortCut     : Boolean;
begin
  AShowSubMenuImage := MenuItem.Count > 0;
  AShowShortCut := False;
  If AShowSubMenuImage Then
    AItemRect.Right := AItemRect.Right - sDCSubMenuImageWidth
  Else
  begin
    With MenuItem Do
      AShowShortCut := ShowShortCut;
    If AShowShortCut Then
    begin
      InitFontForDefault( ACanvas.Font );
      ShortCutText := ShortCutToText( MenuItem.ShortCut );
      ShortCutLength := ACanvas.TextWidth( ShortCutText );
      AItemRect.Right := AItemRect.Right - ( sDCShortCutSpaceLeft + ShortCutLength + sDCShortCutSpaceRight + sDCSubMenuImageWidth );
    end;
  end;

  Inherited DrawItem( ACanvas, AItemRect, ASelected );

  If AShowSubMenuImage Then
    _DrawSubMenuImage
  Else
    If AShowShortCut Then
      _DrawShortCut;
end;

{------------------------------------------------------------------}

Function TDCPopupMenuItem.GetWidth : Integer;
Var
  DC        : HDC;
  SaveIndex : Integer;
  Canvas    : TControlCanvas;
begin
  Result := Inherited GetWidth + sDCPopupSpaceRight + sDCPopupSpaceLeft;
  If ShowShortCut Then
  begin
    DC := GetWindowDC( 0 );
    try
      Canvas := TControlCanvas.Create;
      With Canvas Do
      try
        SaveIndex := SaveDC( DC );
        try
          Handle := DC;
        {$IFDEF D5}
          Font := Screen.MenuFont;
        {$ENDIF}
          InitFontForDefault( Font );
          Result := Result + sDCShortCutSpaceLeft + sDCShortCutSpaceRight +
                             TextWidth( ShortCutToText( MenuItem.ShortCut ) );
        finally
          Handle := 0;
          RestoreDC( DC, SaveIndex );
        end;
      finally
        Canvas.Free;
      end;
    finally
      ReleaseDC( 0, DC );
    end;
  end;

  If MenuItem.Caption <> '' Then
    Result := sDCSubMenuItemSpaceLeft + Result + sDCSubMenuItemSpaceRight;
  Result := Result + sDCSubMenuImageWidth;
end;

{------------------------------------------------------------------}

procedure TDCPopupMenuItem.InitSubMenu( Const AItemRect : TRect );
begin
  SubMenu.Left := MenuFolder.Left + AItemRect.Right;
  SubMenu.Top := MenuFolder.Top + AItemRect.Top;
end;

{------------------------------------------------------------------}

Function TDCPopupMenuItem.ShowShortCut : Boolean;
begin
  With MenuItem Do
    Result := ( Count = 0 ) And ( Caption <> '' ) And ( Caption <> {$IFDEF D5}cLineCaption{$ELSE}'-'{$ENDIF} ) And ( ShortCut <> 0 );
end;

{------------------------------------------------------------------}

{ TDCFictitiousMenuItem }

Constructor TDCFictitiousMenuItem.Create( AOwner : TComponent; AMenuItem : TDCMenuItem );
begin
  Inherited Create( AOwner );
  FMenuItem := AMenuItem;
end;

{------------------------------------------------------------------}

procedure TDCFictitiousMenuItem.CreateRealItem;
begin
  With MenuItem Do
    MenuFolder.ValidateChanges( Index );
end;

{------------------------------------------------------------------}

Destructor TDCFictitiousMenuItem.Destroy;
begin
  If Not Assigned( Owner ) And Not ( csDestroying In MenuItem.MenuFolder.ComponentState ) Then
  begin
    MenuItem.FMenuItem := Nil;
    TDCCustomMenuEditor( MenuItem.MenuFolder.Parent ).Notification( Self, opRemove );
  end;
  Inherited;
end;

{------------------------------------------------------------------}

Procedure TDCFictitiousMenuItem.MenuChanged( ARebuild : Boolean );
begin
  Inherited;
  If Caption <> '' Then
    DCCreateMenuItemName( Self );
end;

{------------------------------------------------------------------}

Procedure DCCreateMenuItemName( AItem : TMenuItem );
begin
  With AItem Do
    Name := UniqueName( Owner, 'N' +
                        RemoveCharSet( [ #0..#47, #58..#64, #91..#96, #123..#255 ], Caption ) );
end;

{------------------------------------------------------------------}

{ TDCMenuDragObject }

{$IFDEF D4}
Procedure TDCMenuDragObject.EndDrag( Target : TObject; X, Y : Integer );
begin
  TDCCustomMenuEditor( Control.Parent ).KillTimer;
  Inherited;
end;

{------------------------------------------------------------------}
{$ELSE}
Procedure TDCMenuDragObject.Finished( Target : TObject; X, Y : Integer; Accepted : Boolean );
begin
  Inherited;
  TDCCustomMenuEditor( Control.Parent ).KillTimer;
end;
{$ENDIF}

{------------------------------------------------------------------}

Function TDCMenuDragObject.GetDragCursor( Accepted : Boolean; X, Y : Integer ) : TCursor;
Var
  Pos           : TPoint;
  IsOverControl : Boolean;
begin
  Pos.X := X;
  Pos.Y := Y;
  With Control.Parent Do
    IsOverControl := PtInRect( ClientRect, ScreenToClient( Pos ) );
  Accepted := Accepted And IsOverControl;

  If Not IsOverControl Then
    TDCCustomMenuEditor( Control.Parent ).InitTimer;

  Result := Inherited GetDragCursor( Accepted, X, Y );
  If Not ( Control Is TDCMenuFolder ) Or Not Assigned( NotifyObject ) Then
    Exit;
  With NotifyObject Do
  begin
    If csDestroying In ComponentState Then
    begin
      FNotifyObject := Nil;
      Exit;
    end;
{    If Not PtInRect( ClientRect, ScreenToClient( Pos ) ) Then
      NotifyObject := Nil;}
  end;
end;

{------------------------------------------------------------------}

procedure TDCMenuDragObject.SetNotifyObject( AValue : TDCMenuFolder );
begin
  If FNotifyObject = AValue Then
    Exit;
  If FNotifyObject <> Nil Then
    FNotifyObject.DropTargetItem := -1;
  FNotifyObject := AValue;
end;

{------------------------------------------------------------------}

end.
