{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCImageListBox;

interface

{$I DC.inc}

uses
  Windows, Messages, Classes, Controls, Forms, Graphics, CommCtrl,
  SysUtils, StdCtrls,

  DCCommon, DCdreamLib, DCSystem,
  DCGraphFunc;

type
  TDCCustomImageListItem = class( TCollectionItem )
  private
    FImageIndex : Integer;
    FUserData   : Pointer;
    FCaption    : String;

    Procedure SetCaption( Const Value : String );
    Procedure SetImageIndex( Value : Integer );
  protected
    Function GetDisplayName : String; override;

    Function GetImageList : TImageList;
    Procedure DrawImage( ACanvas : TCanvas; Var AItemRect : TRect; AImageList : TImageList ); virtual;
    Procedure CaptionChanged; virtual;

    Procedure DrawAt( ACanvas : TCanvas; AItemRect : TRect; AHighlightItem : Boolean ); Virtual;
  public
    Constructor Create( ACollection : TCollection ); override;
    Destructor Destroy; override;

    Procedure Assign( ASource : TPersistent ); Override;
    Function  GetItemTextWidth( ACanvas : TCanvas; AHighlightItems : Boolean ) : Integer; virtual;

    Property UserData : Pointer Read FUserData Write FUserData;

    Property Caption    : String  Read FCaption    Write SetCaption;
    Property ImageIndex : Integer Read FImageIndex Write SetImageIndex;
  end;

{------------------------------------------------------------------}

  TDCImageListItem = class( TDCCustomImageListItem )
  published
    Property Caption;
    Property ImageIndex;
  end;

  TDCImageListItemClass = class of TDCCustomImageListItem;

{------------------------------------------------------------------}

  TDCCustomImageListBox = class;
  TDCImageListItems = class(TCollection)
  private
    FOwner : TDCCustomImageListBox;
  protected
    Procedure Update( Item : TCollectionItem ); override;
    Function  GetOwner : TPersistent; override;
    Procedure SetItemName( AItem : TCollectionItem ); override;
  public
    Procedure MoveItemTo( ASourceIndex, ADestIndex : Integer );
    property ImageListBox:TDCCustomImageListBox Read FOwner Write FOwner;
    property Items[Index: Integer]: TCollectionItem read GetItem write SetItem; default;
    {$IFNDEF D6}
    Property Owner:TDCCustomImageListBox Read FOwner Write FOwner;
    {$ENDIF}
  end;

{------------------------------------------------------------------}

  TDCCanMoveItemEvent = Procedure( ASender : TObject; AOriginIndex, ADestIndex : Integer;
    Var ACanMove : Boolean ) of object;
  TDCItemMovedEvent = Procedure( ASender : TObject; AOriginIndex, ADestIndex : Integer ) of object;

  TDCCustomImageListBox = class( TCustomControl )
  private
    FItems            : TDCImageListItems;
    FImageList        : TImageList;
    FBorderStyle      : TBorderStyle;
    FQuickSearch      : Boolean;
    FHighlightItems   : Boolean;
    FSorted           : Boolean;
    FNeedToResort     : Boolean;
    FSampleTextHeight : Integer;

    FCanDragItems           : Boolean;
    FShowRectWhenAcceptDrag : Boolean;
    FDraggingItem           : Integer;
    FOldDragSelItem         : Integer;
    FOldDragSelItemRect     : TRect;

    FTopIndex       : Integer;
    FItemIndex      : Integer;
    FHorzPosition   : Integer;

    FLengthNeed     : Boolean;
    FMaxLength      : Integer;
    FMaxLengthIndex : Integer;
    FSoftSorting    : Boolean;

    FScrollTimer   : UINT;
    FActivatedByKeyboard : Boolean;
    FKeyStrokeMiss : Integer;
    FSearchString  : String;

    FSelectedColor     : TColor;
    FSelectedTextColor : TColor;

    FOnChanged          : TNotifyEvent;
    FOnSelectionChanged : TNotifyEvent;
    FOnCanMoveItem      : TDCcanMoveItemEvent;
    FOnItemMoved        : TDCItemMovedEvent;
    FWheelDelta         : Integer;

    FScrollStepHorz : Integer;
    FScrollStepVert : Integer;

    procedure SetImageList( Const Value : TImageList );
    procedure SetBorderStyle( Const Value : TBorderStyle );
    procedure SetItems( Const Value : TDCImageListItems );
    procedure SetSelectedColor( Const Value : TColor );
    procedure SetTextSelectedColor( Const Value : TColor );
    procedure SetItemIndex( Value : Integer );
    procedure SetTopIndex( Value : Integer );
    Procedure SetHorzPosition( Value : Integer );
    Procedure SetSorted( Value : Boolean );
    Procedure SetCanDragItems( Value : Boolean );
    Procedure SetHighlightItems( Value : Boolean );

    Procedure WMEraseBkgnd( Var Msg : TWMEraseBkgnd ); message WM_EraseBkgnd;
    Procedure WMGetDlgCode( Var Msg : TWMGetDlgCode ); message WM_GetDlgCode;
    procedure WMSetFocus( Var Message : TWMSetFocus ); message WM_SetFocus;
    procedure WMKillFocus( Var Message : TWMSetFocus ); message WM_KillFocus;
    procedure CMFontChanged( Var Message : TMessage ); message CM_FontChanged;
    Procedure WMLButtonDown( Var Message : TWMLButtonDown ); message WM_LBUTTONDOWN;
    Procedure WMMouseWheel( Var Message : TMessage ); message WM_MOUSEWHEEL;

    Procedure WMVScroll( Var Message : TWMScroll ); message WM_VSCROLL;
    Procedure WMHScroll( Var Message : TWMScroll ); message WM_HSCROLL;
    Procedure WMTimer( Var Message : TWMTimer); message WM_TIMER;
    Procedure WMSize( Var Message : TWMSize ); message WM_Size;

    Procedure CheckNewTopIndex( Var ANewTopIndex : Integer );
    Procedure CheckNewItemIndex( Var ANewItemIndex : Integer );

    procedure UpdateScrollPos;
    procedure UpdateScrollSize;
    procedure UpdateScrollBars;
    Procedure InitTimer;
    procedure KillTimer;

    Procedure UpdatePositions;
    Procedure UpdateMeasurements( Item : TDCCustomImageListItem );

    Function  CompareItems( AFirstItem, ASecondItem : Integer ) : Integer;
    Procedure ChangeItems( AOrigin, ADestination : Integer );

    Function VertScrollVisible : Boolean;
    Function HorzScrollVisible : Boolean;
    Function GetScrollPageSize : Integer;

    Function VisibleItemCount : Integer;

    Procedure RecalculateLength;
    Procedure ItemDeleting( AIndex : Integer );
    Procedure ItemCaptionChanged( AIndex : Integer );
    Procedure SoftSorting( AItem : TDCCustomImageListItem );

    Procedure DrawFocusRectOnDragItem;
    Procedure DrawItem( ARect : TRect; AIndex : Integer );
    Procedure ScrollByLines( LinesCount : Integer );
  protected
    Procedure MouseMove( Shift : TShiftState; X, Y : Integer ); override;
    Procedure MouseUp( Button : TMouseButton; Shift : TShiftState; X, Y : Integer ); override;
    Procedure KeyDown( Var Key : Word; Shift : TShiftState ); override;

    procedure DoStartDrag( Var DragObject : TDragObject ); override;
    Procedure DragOver( Source : TObject; X, Y : Integer; State : TDragState;
                        Var Accept : Boolean ); override;
    Procedure DoEndDrag( Target : TObject; X, Y : Integer ); override;
    Function  DoCanMoveItem( AOriginIndex, ADestIndex : Integer ) : Boolean; virtual;
    Procedure DoItemMoved( AOriginIndex, ADestIndex : Integer ); virtual;

    Procedure CreateParams( Var Params : TCreateParams ); override;
    Procedure Paint; override;
    procedure SetParent( AParent : TWinControl ); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    procedure ShiftLineDown;
    procedure ShiftLineUp;
    procedure ShiftPageUp;
    procedure ShiftPageDown;

    Procedure FontChanged;
    Function  GetItemsHeight : Integer; virtual;
    Function  GetImageWidth : Integer; virtual;
    Function  GetItemsMaxWidth( Var AIndex : Integer ) : Integer; virtual;
    Procedure DoChanged; dynamic;
    Procedure DoSelectionChanged; dynamic;

    Function  GetListItemClass : TDCImageListItemClass; virtual;
    Procedure InvalidateFocusRect;
    Procedure InvalidateItem( AItemRect : TRect; AIndex : Integer );
    Function  Find( Const AText : String; Var AIndex : Integer ) : Boolean;

    Function  GetSortingField( AIndex : Integer ) : String; virtual;
    Procedure ResortItems; virtual;

    Property ImageList    : TImageList Read FImageList Write SetImageList;
    Property TopIndex     : Integer    Read FTopIndex Write SetTopIndex;
    Property HorzPosition : Integer    Read FHorzPosition Write SetHorzPosition;
  public
    Constructor Create( AOwner : TComponent ); override;
    Destructor Destroy; override;

    Procedure DragDrop( Source : TObject; X, Y : Integer); override;
    
    Procedure ScrollLineDown;
    Procedure ScrollLineUp;
    Procedure ScrollPageUp;
    Procedure ScrollPageDown;
    Procedure ScrollCharLeft;
    Procedure ScrollCharRight;
    Procedure ScrollPageLeft;
    Procedure ScrollPageRight;

    procedure CheckAllItems;
    procedure UnCheckAllItems;
    procedure SetItemsChecked(NewChecked:boolean);

    Function IndexOf( Const AItemCaption : String ) : Integer;
    Function IndexWithStart( Const AItemCaption : String ) : Integer;
    Function ItemCount : Integer;

    Function GetItemRect( AIndex : Integer ) : TRect;
    Function ItemAtPos( X, Y : Integer; Existing : Boolean ) : Integer;

    Procedure Delete( AIndex : Integer ); virtual;

    Property DraggingItem      : Integer Read FDraggingItem;
    Property SelDraggingItem   : Integer Read FOldDragSelItem;

    Property BorderStyle       : TBorderStyle Read FBorderStyle Write SetBorderStyle Default bsSingle;
    Property Items             : TDCImageListItems Read FItems Write SetItems;
    Property SelectedColor     : TColor  Read FSelectedColor Write SetSelectedColor default clHighlight;
    Property SelectedTextColor : TColor  Read FSelectedTextColor Write SetTextSelectedColor default clHighlightText;
    Property ItemIndex         : Integer Read FItemIndex Write SetItemIndex;
    Property Sorted            : Boolean Read FSorted Write SetSorted default False;
    Property QuickSearch       : Boolean Read FQuickSearch Write FQuickSearch default False;
    Property CanDragItems      : Boolean Read FCanDragItems Write SetCanDragItems default False;
    Property HighlightItems    : Boolean Read FHighlightItems Write SetHighlightItems default False;
    Property ShowRectWhenAcceptDrag : Boolean Read FShowRectWhenAcceptDrag Write FShowRectWhenAcceptDrag;
    Property ScrollStepHorz    : Integer Read FScrollStepHorz Write FScrollStepHorz;
    Property ScrollStepVert    : Integer Read FScrollStepVert Write FScrollStepVert;

    Property OnCanMoveItem      : TDCCanMoveItemEvent Read FOnCanMoveItem Write FOnCanMoveItem;
    Property OnItemMoved        : TDCItemMovedEvent   Read FOnItemMoved Write FOnItemMoved;
    Property OnChanged          : TNotifyEvent        Read FOnChanged Write FOnChanged;
    Property OnSelectionChanged : TNotifyEvent        Read FOnSelectionChanged Write FOnSelectionChanged;

    Property Canvas;
  end;

{------------------------------------------------------------------}

  TDCImageListBox = class( TDCCustomImageListBox )
  published
    property Align;
{$IFDEF D4}
    property Anchors;
{$ENDIF}
    Property ImageList;
    Property BorderStyle;
    Property Ctl3D;
    property Color default clWindow;
    Property CanDragItems;
    property Enabled;
    property Font;
    Property Items;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    Property QuickSearch;
    property ShowHint;
    Property SelectedColor;
    Property SelectedTextColor;
    property TabOrder;
    property TabStop Default True;
    property Visible;
    Property Sorted;
    Property HighlightItems;
    Property ShowRectWhenAcceptDrag;  
    Property ScrollStepHorz;
    Property ScrollStepVert;

    Property OnCanMoveItem;
    Property OnItemMoved;
    Property OnChanged;
    Property OnSelectionChanged;

    property OnClick;
{$IFDEF D5}
    property OnContextPopup;
    property OnEndDock;
{$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF D4}
    property OnStartDock;
{$ENDIF}
    property OnStartDrag;
  end;

{------------------------------------------------------------------}

  TDCImageListDragObject = class( TDragControlObject )
  private
    FNotifyObject : TDCCustomImageListBox;
  protected
    Function GetDragCursor( Accepted : Boolean; X, Y : Integer ) : TCursor; override;
//    Procedure EndDrag( Target : TObject; X, Y : Integer ); override;
    Procedure Finished( Target : TObject; X, Y : Integer; Accepted : Boolean ); override;
  public
    Property NotifyObject : TDCCustomImageListBox Read FNotifyObject Write FNotifyObject;
  end;

{------------------------------------------------------------------}

  TDCCustomBtnImageListItem = class( TDCCustomImageListItem )
  protected
    procedure DrawImage( ACanvas : TCanvas; Var AItemRect : TRect; AImageList : TImageList ); override;
  end;

{------------------------------------------------------------------}

  TDCBtnImageListItem = class( TDCCustomBtnImageListItem )
  published
    Property Caption;
    Property ImageIndex;
  end;

{------------------------------------------------------------------}

  TDCCustomBtnImageListBox = class( TDCCustomImageListBox )
  private
    FImageBackgroudColor : TColor;

    Procedure SetImageBackgroudColor( AValue : TColor );
  protected
    Function GetListItemClass : TDCImageListItemClass; override;
    Function GetItemsHeight : Integer; override;
    Function GetImageWidth : Integer; override;
  public
    Constructor Create( AOwner : TComponent ); override;

    Property ImageBackgroudColor : TColor Read FImageBackgroudColor Write SetImageBackgroudColor default clBtnFace;
  end;

{------------------------------------------------------------------}

  TDCBtnImageListBox = class( TDCCustomBtnImageListBox )
  published
    property Align;
{$IFDEF D4}
    property Anchors;
{$ENDIF}
    Property ImageList;
    Property BorderStyle;
    Property Ctl3D;
    property Color default clWindow;
    Property CanDragItems;
    property Enabled;
    property Font;
    Property Items;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    Property QuickSearch;
    property ShowHint;
    Property SelectedColor;
    Property SelectedTextColor;
    property TabOrder;
    property TabStop Default True;
    property Visible;
    Property Sorted;
    Property HighlightItems;
    Property ShowRectWhenAcceptDrag;
    Property ImageBackgroudColor;

    Property OnSelectionChanged;
    Property OnCanMoveItem;
    Property OnItemMoved;
    Property OnChanged;

    property OnClick;
{$IFDEF D5}
    property OnContextPopup;
{$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
{$IFDEF D4}
    property OnEndDock;
{$ENDIF}
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF D4}
    property OnStartDock;
{$ENDIF}
    property OnStartDrag;
  end;

{------------------------------------------------------------------}

  TDCCustomCheckListItem = class( TDCCustomImageListItem )
  private
    FState : TCheckBoxState;

    Function GetChecked : Boolean;
    Procedure SetChecked( AValue : Boolean );
    Procedure SetState( AValue : TCheckBoxState );
  protected
    Procedure DrawCheckBox( ACanvas : TCanvas; Var AItemRect : TRect; AFlat : Boolean );
    Procedure DrawAt( ACanvas : TCanvas; AItemRect : TRect; AHighlightItem : Boolean ); override;
  public
    Property State   : TCheckBoxState Read FState Write SetState default cbUnchecked;
    Property Checked : Boolean        Read GetChecked Write SetChecked default False;
  end;

{------------------------------------------------------------------}

  TDCCheckListItem = class( TDCCustomCheckListItem )
  published
    Property Caption;
    Property ImageIndex;
    Property Checked;
    Property State;
  end;

{------------------------------------------------------------------}

  TDCOnCheckStateChanged = Procedure( AObject : TObject; ASender : TDCCustomCheckListItem ) of object;

  TDCCustomCheckImageListBox = class( TDCCustomImageListBox )
  private
    FShowCheckBoxes      : Boolean;
    FOnCheckStateChanged : TDCOnCheckStateChanged;
    FFlat: Boolean;

    procedure SetShowCheckBoxes( Value : Boolean );
    procedure SetFlat( AValue : Boolean );

    Procedure WMLButtonDown( Var Message : TWMLButtonDown ); message WM_LBUTTONDOWN;
    Procedure WMKeyDown( Var Message : TWMKeyDown ); message WM_KeyDown;
  protected
    Procedure CheckStateChanged( ASender : TDCCustomCheckListItem );

    Procedure DoCheckStateChanged( ASender : TDCCustomCheckListItem ); virtual;
    Function  IsOverCheckBox( AIndex, X, Y : Integer ) : Boolean;

    Function  GetListItemClass : TDCImageListItemClass; override;
    Function  GetImageWidth : Integer; override;
  public
    Constructor Create( AOwner : TComponent ); override;

    Property ShowCheckBoxes : Boolean Read FShowCheckBoxes Write SetShowCheckBoxes default True;
    Property Flat           : Boolean Read FFlat Write SetFlat default False;

    Property OnCheckStateChanged : TDCOnCheckStateChanged Read FOnCheckStateChanged Write FOnCheckStateChanged;
  end;

{------------------------------------------------------------------}

  TDCCheckImageListBox = class( TDCCustomCheckImageListBox )
  published
    Property Align;
{$IFDEF D4}
    Property Anchors;
{$ENDIF}
    Property ImageList;
    Property BorderStyle;
    Property Ctl3D;
    Property Color default clWindow;
    Property CanDragItems;
    Property Enabled;
    Property Font;
    Property Items;
    Property ParentColor default False;
    Property ParentFont;
    Property ParentShowHint;
    Property PopupMenu;
    Property QuickSearch;
    Property ShowHint;
    Property SelectedColor;
    Property SelectedTextColor;
    Property TabOrder;
    Property TabStop Default True;
    Property Visible;
    Property Sorted;
    Property HighlightItems;
    Property ShowRectWhenAcceptDrag;
    Property ShowCheckBoxes;
    Property Flat; 

    Property OnSelectionChanged;
    Property OnCanMoveItem;
    Property OnItemMoved;
    Property OnChanged;

    property OnClick;
{$IFDEF D5}
    property OnContextPopup;
{$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
{$IFDEF D4}
    property OnEndDock;
{$ENDIF}
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF D4}
    property OnStartDock;
{$ENDIF}
    property OnStartDrag;
    property OnCheckStateChanged;
  end;

{------------------------------------------------------------------}

Const
  sDCDefaultImageWidth = 24;
  sDCDefaultImageHeight = 24;
  sDCIconBorder = 1;

implementation

{$IFNDEF D4}
{$HINTS OFF}
type
  THCollection = class( TPersistent )
  private
    FItemClass: TCollectionItemClass;
    FItems: TList;
    FUpdateCount: Integer;
    FNextID: Integer;
    FPropName: string;
  end;
{$HINTS ON}
{$ENDIF}

{------------------------------------------------------------------}

Const
  sDCImageListBoxDefaultHeight = 120;
  sDCImageListBoxDefaultWidth = 220;
  sDCSpaceX = 1;
  sDCSpaceY = 1;
  sDCImageSpaceX = 2;
  sDCCheckSpace = 2;

  sDCTextTemplate = 'W';

  sDCMaxIdlePeriod = 3;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.CheckAllItems;
begin
  SetItemsChecked(True);
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.SetItemsChecked(NewChecked:boolean);
Var
  I : Integer;
begin
  For I := 0 To Items.Count - 1 Do
    TDCCheckListItem(Items[I]).Checked := NewChecked;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.UnCheckAllItems;
begin
  SetItemsChecked(False);
end;

{------------------------------------------------------------------}

Procedure TDCCustomImageListBox.CheckNewTopIndex( Var ANewTopIndex : Integer );
Var
  VisCount : Integer;
begin
  VisCount := ItemCount - ClientHeight Div GetItemsHeight;

  If ANewTopIndex > VisCount Then
    ANewTopIndex := VisCount;
  If ANewTopIndex < 0 Then
    ANewTopIndex := 0;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.CMFontChanged( Var Message : TMessage );
begin
  Inherited;
  FontChanged;
end;

{------------------------------------------------------------------}

Constructor TDCCustomImageListBox.Create( AOwner : TComponent );
begin
  Inherited;

  FTopIndex := 0;
  FItemIndex := -1;
  FDraggingItem := -1;
  FOldDragSelItem := -1;
  Width := sDCImageListBoxDefaultWidth;
  Height := sDCImageListBoxDefaultHeight;

  Ctl3D := True;
  TabStop := True;
  ParentColor := False;
  Color := clWindow;

  FSelectedColor := clHighlight;
  FSelectedTextColor := clHighlightText;
  FBorderStyle := bsSingle;

  FScrollStepHorz := 1;
  FScrollStepVert := 1;

  FItems := TDCImageListItems.Create( GetListItemClass );
  FItems.ImageListBox:=Self;
end;

{------------------------------------------------------------------}

Procedure TDCCustomImageListBox.CreateParams(var Params: TCreateParams);
begin
  Inherited CreateParams( Params );
  Params.Style := Params.Style Or WS_HSCROLL Or WS_VSCROLL Or WS_TABSTOP;
  Params.WindowClass.Style := Params.WindowClass.Style Or CS_DBLCLKS;
  UpdateParamsWithBorderStyle( Params, FBorderStyle, Ctl3D );
end;

{------------------------------------------------------------------}

Destructor TDCCustomImageListBox.Destroy;
begin
  FreeObject( FItems ,FItems );
  Inherited;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.DoChanged;
begin
  If Assigned( FOnChanged ) Then
    FOnChanged( Self );
end;

{------------------------------------------------------------------}

Procedure TDCCustomImageListBox.DrawItem( ARect : TRect; AIndex : Integer );
begin
  If ( AIndex >= 0 ) And ( AIndex < FItems.Count ) Then
    TDCCustomImageListItem( FItems[ AIndex ] ).DrawAt( Canvas, ARect, HighlightItems );
end;

{------------------------------------------------------------------}

Function TDCCustomImageListBox.Find( Const AText : String; Var AIndex : Integer ) : Boolean;
Var
  L, H, I, C : Integer;
begin
  Result := False;
  L := 0;
  H := ItemCount - 1;
  While L <= H Do
  begin
    I := ( L + H ) Shr 1;
    C := AnsiCompareText( TDCCustomImageListItem( Items[ I ] ).Caption, AText );
    If C < 0 Then
      L := I + 1
    Else
    begin
      H := I - 1;
      If C = 0 Then
        Result := True;
    end;
  end;
  AIndex := L;
end;

{------------------------------------------------------------------}

Procedure TDCCustomImageListBox.FontChanged;
begin
  UpdateMeasurements( Nil );
end;

{------------------------------------------------------------------}

Function TDCCustomImageListBox.GetItemsHeight: Integer;
begin
  Result := FSampleTextHeight;
  If Assigned( ImageList ) And ( Result < ImageList.Height ) Then
    Result := ImageList.Height;
  Result := Result + sDCSpaceY Shl 1;
end;

{------------------------------------------------------------------}

Function TDCCustomImageListBox.GetItemRect( AIndex : Integer ) : TRect;
Var
  ItemHeight : Integer;
begin
  ItemHeight := GetItemsHeight;

  Result.Left := 0;
  Result.Right := Max( FMaxLength + 1, ClientWidth );
  Result.Top := ( AIndex - FTopIndex ) * ItemHeight;
  Result.Bottom := Result.Top + ItemHeight;
end;

{------------------------------------------------------------------}

Function TDCCustomImageListBox.GetListItemClass : TDCImageListItemClass;
begin
  Result := TDCImageListItem;
end;

{------------------------------------------------------------------}

Function TDCCustomImageListBox.HorzScrollVisible : Boolean;
begin
  Result := FMaxLength > ClientWidth;
end;

{------------------------------------------------------------------}

Function TDCCustomImageListBox.IndexOf( Const AItemCaption : String ) : Integer;
begin
  If Not Sorted Then
  begin
    For Result := 0 To ItemCount - 1 Do
      If AnsiCompareText( TDCCustomImageListItem( Items[ Result ] ).Caption, AItemCaption ) = 0 Then
        Exit;
    Result := -1;
  end
  Else
    If Not Find( AItemCaption, Result ) Then
      Result := -1;
end;

{------------------------------------------------------------------}

Function TDCCustomImageListBox.IndexWithStart( Const AItemCaption : String ) : Integer;
Var
  ItemText : String;
begin
  ItemText := AnsiLowerCase( AItemCaption );
  For Result := 0 To ItemCount - 1 Do
    If Pos( ItemText, AnsiLowerCase( TDCCustomImageListItem( Items[ Result ] ).Caption ) ) = 1 Then
      Exit;
  Result := -1;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.InitTimer;
begin
  If FScrollTimer = 0 Then
    FScrollTimer := SetTimer( Handle, 1, 50, Nil );
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.InvalidateFocusRect;
begin
  If ( ItemIndex >= 0 ) And ( ItemIndex < ItemCount ) Then
    InvalidateItem( GetItemRect( ItemIndex ), ItemIndex );
  If ItemIndex = -1 Then
    InvalidateItem( GetItemRect( 0 ), -1 );
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.InvalidateItem( AItemRect : TRect; AIndex : Integer );
begin
  If AIndex = FItemIndex Then
  begin
    Canvas.Brush.Color := SelectedColor;
    Canvas.Font.Color := SelectedTextColor;
  end
    Else
  begin
    Canvas.Brush.Color := Color;
    Canvas.Font.Color := Font.Color;
  end;

  OffsetRect( AItemRect, -HorzPosition, 0 );
  DrawItem( AItemRect, AIndex );
  OffsetRect( AItemRect, HorzPosition, 0 );

  If //( AIndex = -1 ) Or
     ( ( AIndex = FItemIndex ) And Focused And ( FOldDragSelItem <> FItemIndex ) ) Then
    With Canvas Do
    begin
      Font.Color := clWhite;
      Brush.Color := clBlack;
      DrawFocusRect( Rect( 0, AItemRect.Top, ClientWidth, AItemRect.Bottom ) );
    end;
end;

{------------------------------------------------------------------}

Function TDCCustomImageListBox.ItemAtPos( X, Y : Integer; Existing : Boolean ) : Integer;
Var
  I, Top, H  : Integer;
  ItemHeight : Integer;
begin
  Top := 0;
  I := TopIndex;
  H := ClientHeight;
  ItemHeight := GetItemsHeight;
  While ( Top < H ) And ( I < Items.Count ) Do
  begin
    If ( Top < Y ) And ( Y <= Top + ItemHeight ) Then
    begin
      Result := I;
      Exit;
    end;
    Inc( Top, ItemHeight );
    Inc( I );
  end;
  If Existing Then
    Result := -1
  Else
    Result := Items.Count - 1;
end;

{------------------------------------------------------------------}

Function TDCCustomImageListBox.ItemCount : Integer;
begin
  Result := FItems.Count;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.KeyDown( Var Key : Word; Shift : TShiftState );
Var
  NewIndex : Integer;
begin
  Inherited;
  If QuickSearch And ( Key > 31 ) Then
  begin
    InitTimer;
    FActivatedByKeyboard := True;
    FKeyStrokeMiss := 0;
    FSearchString := FSearchString + Char( Key );
    NewIndex := IndexWithStart( FSearchString );
    If NewIndex >= 0 Then
      ItemIndex := NewIndex; 
  end;
  If Shift <> [] Then
    Exit;
  Case Key Of
    VK_UP    : ScrollLineUp;
    VK_DOWN  : ScrollLineDown;
    VK_NEXT  : ScrollPageDown;
    VK_PRIOR : ScrollPageUp;
    VK_HOME  : ItemIndex := 0;
    VK_END   : ItemIndex := ItemCount - 1;
    VK_LEFT  : ScrollCharRight;
    VK_RIGHT : ScrollCharLeft;
  End;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.KillTimer;
begin
  If FScrollTimer <> 0 Then
  begin
    Windows.KillTimer( Handle, FScrollTimer );
    FScrollTimer := 0;
  end;
end;

{------------------------------------------------------------------}

Procedure TDCCustomImageListBox.WMLButtonDown( Var Message : TWMLButtonDown );
Var
  Item : Integer;
begin
  Inherited;
  If Not ( csDesigning in ComponentState ) And ( Not Focused ) And CanFocus Then
    SetFocus;
  Item := ItemAtPos( Message.XPos, Message.YPos, True );
  If Item <> -1 Then
    ItemIndex := Item;

  If CanDragItems And ( Item >= 0 ) Then
  begin
    BeginDrag( False{$IFDEF D4}, 2{$ENDIF} );
    FOldDragSelItem := Item;
    FOldDragSelItemRect := GetItemRect( Item );
    FOldDragSelItemRect := Rect( 0, FOldDragSelItemRect.Top, ClientWidth, FOldDragSelItemRect.Bottom );
    FDraggingItem := Item;
  end;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.MouseMove( Shift : TShiftState; X, Y : Integer );
Var
  Item : Integer;
begin
  Inherited MouseMove( Shift, X, Y );

  If Not MouseCapture Then
    KillTimer
  Else
    If ( Y >= 0 ) And ( Y < ClientHeight ) And
       ( X >= 0 ) And ( X < ClientWidth ) Then
    begin
      KillTimer;
      Item := ItemAtPos( X, Y, True );
      If Item <> -1 Then
        ItemIndex := Item;
    end
    Else
      InitTimer;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.MouseUp( Button : TMouseButton; Shift : TShiftState;
  X, Y : Integer );
begin
  Inherited MouseUp( Button, Shift, X, Y );
  If Button = mbLeft Then
  begin
    MouseCapture := False;
    KillTimer;
  end;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  Inherited;
  If Operation = opRemove Then
    If FImageList = AComponent Then
      ImageList := Nil;
end;

{------------------------------------------------------------------}

Procedure TDCCustomImageListBox.Paint;
Var
  I, ItemHeight : Integer;
  AItemRect     : TRect;
begin
  Canvas.Brush.Style := bsSolid;
  Canvas.Font := Font;

  ItemHeight := GetItemsHeight;
  AItemRect := Rect( 0, 0, ClientWidth, ItemHeight );
  If ClientWidth < FMaxLength Then
    AItemRect.Right := FMaxLength + 1;
  For I := FTopIndex To ItemCount - 1 Do
  begin
    InvalidateItem( AItemRect, I );

    OffsetRect( AItemRect, 0, ItemHeight );
    If AItemRect.Top >= ClientHeight Then
      break;
  end;
  With Canvas Do
  begin
    Brush.Color := Self.Color;
    Brush.Style := bsSolid;
    If AItemRect.Top < ClientHeight Then
      FillRect( Rect( 0, AItemRect.Top, ClientWidth, ClientHeight ) );
  end;
  DrawFocusRectOnDragItem;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.ScrollCharLeft;
begin
  HorzPosition := HorzPosition + ScrollStepHorz;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.ScrollCharRight;
begin
  HorzPosition := HorzPosition - ScrollStepHorz;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.ScrollLineDown;
begin
  ItemIndex := ItemIndex + 1;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.ScrollLineUp;
begin
  If ItemIndex > 0 Then
    ItemIndex := ItemIndex - 1;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.ScrollPageDown;
begin
  ItemIndex := ItemIndex + VisibleItemCount - 1;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.ScrollPageLeft;
begin
  HorzPosition := HorzPosition + ClientWidth;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.ScrollPageRight;
begin
  HorzPosition := HorzPosition - ClientWidth;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.ScrollPageUp;
Var
  PageSize : Integer;
begin
  PageSize := VisibleItemCount - 1;
  If ItemIndex - PageSize >= 0 Then
    ItemIndex := ItemIndex - PageSize
  Else
    ItemIndex := 0;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.SetBorderStyle( Const Value : TBorderStyle );
begin
  If FBorderStyle <> Value Then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.SetHorzPosition( Value : Integer );
begin
  If Not HorzScrollVisible Then
    Value := 0;
  If FHorzPosition <> Value Then
  begin
    If Value < 0 Then
      Value := 0;
    If Value > FMaxLength - ClientWidth Then
      Value := FMaxLength - ClientWidth + 1;
    FHorzPosition := Value;
    UpdateScrollPos;
    Invalidate;
  end;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.SetImageList(const Value: TImageList);
begin
{$IFDEF D5}
  If FImageList <> Nil Then
    FImageList.RemoveFreeNotification( Self );
{$ENDIF}
  FImageList := Value;
  If Value <> Nil Then
    Value.FreeNotification( Self );
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.SetItemIndex( Value : Integer );
begin
  If Value >= ItemCount Then
    Value := ItemCount - 1;
  If FItemIndex <> Value Then
  begin
    If Value >= -1 Then
    begin
      If Value < -1 Then
        Value := 0;
      FItemIndex := Value;
      If ( Value < TopIndex ) And ( Value <> -1 ) Then
        TopIndex := Value
      Else
        If VisibleItemCount <= Value - TopIndex Then
          TopIndex := Value - VisibleItemCount + 1
        Else
  {$IFDEF D4}
          If Items.UpdateCount = 0 then
  {$ELSE}
          If THCollection( Items ).FUpdateCount = 0 then
  {$ENDIF}
            Invalidate;
    end;
    DoSelectionChanged;
  end;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.SetItems( Const Value : TDCImageListItems );
begin
  FItems.Assign( Value );
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.SetParent( AParent : TWinControl );
begin
  Inherited;
  If AParent <> Nil Then
    FontChanged;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.SetSelectedColor(const Value: TColor);
begin
  FSelectedColor := Value;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.SetSorted( Value : Boolean );
begin
  If FSorted = Value Then
    Exit;
  FSorted := Value;
  If Value Then
    ResortItems;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.SetTextSelectedColor( Const Value : TColor );
begin
  FSelectedTextColor := Value;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.SetTopIndex( Value : Integer );
begin
  If FTopIndex <> Value Then
  begin
    CheckNewTopIndex( Value );
    FTopIndex := Value;
{$IFDEF D4}
    If Items.UpdateCount = 0 then
{$ELSE}
    If THCollection( Items ).FUpdateCount = 0 then
{$ENDIF}
      Invalidate;
  end;
  UpdateScrollPos;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.ShiftLineDown;
begin
  TopIndex := TopIndex + ScrollStepVert;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.ShiftLineUp;
begin
  TopIndex := TopIndex - ScrollStepVert;
end;

{------------------------------------------------------------------}

Function TDCCustomImageListBox.GetScrollPageSize : Integer;
begin
  Result := ClientHeight Div GetItemsHeight - 1;
  If Result <= 0 Then
    Result := 1;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.ShiftPageDown;
begin
  TopIndex := TopIndex + GetScrollPageSize;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.ShiftPageUp;
begin
  TopIndex := TopIndex - GetScrollPageSize;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.UpdateMeasurements( Item : TDCCustomImageListItem );
begin
  If FLengthNeed Then
    RecalculateLength;

  If Parent <> Nil Then
    FSampleTextHeight := GetMaxFontHeight( Font );

  UpdateScrollBars;
  If FNeedToResort Then
    ResortItems;

  ItemIndex := ItemIndex;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.UpdateScrollBars;
begin
  UpdateScrollSize;
  UpdateScrollPos;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.UpdateScrollPos;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure SetVertScroll;
  begin
    _SetScrollPos( Handle, SB_Vert, TopIndex );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure SetHorzScroll;
  begin
    _SetScrollPos( Handle, SB_Horz, FHorzPosition );
    FHorzPosition := GetScrollPos( Handle, SB_Horz );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  If HandleAllocated Then
  begin
    If VertScrollVisible Then
      SetVertScroll;
    If HorzScrollVisible Then
      SetHorzScroll;
  end;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.UpdateScrollSize;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure SetHorzScroll;
  Var
    ScrollVisible : Boolean;
  begin
    ScrollVisible := HorzScrollVisible;
    If ScrollVisible Then
      _SetScrollSize( Handle, SB_Horz, 0, FMaxLength, ClientWidth )
    Else
    begin
      _SetScrollSize( Handle, SB_HORZ, 0, 0, -1 );
      FHorzPosition := 0;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure SetVertScroll;
  Var
    ScrollVisible : Boolean;
    Index         : Integer;
  begin
    ScrollVisible := VertScrollVisible;

    Index := ItemCount - 1;

    If ScrollVisible Then
      _SetScrollSize( Handle, SB_Vert, 0, Index, VisibleItemCount )
    Else
      _SetScrollSize( Handle, SB_Vert, 0, 0, -1 );

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

Function TDCCustomImageListBox.VertScrollVisible : Boolean;
begin
  Result := ItemCount >= ClientHeight Div GetItemsHeight;
end;

{------------------------------------------------------------------}

function TDCCustomImageListBox.VisibleItemCount: Integer;
begin
  Result := ClientHeight Div GetItemsHeight;
  If Result > ItemCount - FTopIndex Then
    Result := ItemCount - FTopIndex;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
begin
  Msg.Result := 1;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.WMGetDlgCode( Var Msg : TWMGetDlgCode );
begin
  Msg.Result := DLGC_WANTARROWS;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.WMHScroll( Var Message : TWMScroll );
begin
  Case Message.ScrollCode Of
    SB_LINEDOWN	  : ScrollCharLeft;
    SB_LINEUP     : ScrollCharRight;
    SB_PAGEUp     : ScrollPageRight;
    SB_PAGEDown   : ScrollPageLeft;
    SB_THUMBTRACK : HorzPosition := Message.Pos;
  End;
  Message.Result := 0;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.WMKillFocus( Var Message : TWMSetFocus );
begin
  Inherited;
  InvalidateFocusRect;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.WMSetFocus(var Message: TWMSetFocus);
begin
  Inherited;
  InvalidateFocusRect;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.WMSize( Var Message : TWMSize );
begin
  Inherited;
  UpdatePositions;
  UpdateScrollBars;
//  UpdateMeasurements( Nil );
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.WMTimer(var Message: TWMTimer);
Var
  Kill : Boolean;
  P    : TPoint;
begin
  If Message.TimerID <> 1 Then
  begin
    Inherited;
    Exit;
  end;
  If FActivatedByKeyBoard Then
  begin
    Inc( FKeyStrokeMiss );
    If FKeyStrokeMiss > sDCMaxIdlePeriod Then
    begin
      FActivatedByKeyBoard := False;
      FSearchString := '';
      KillTimer;
    end;
    Exit;
  end;
  If Not MouseCapture Then
  begin
    KillTimer;
    Exit;
  end;
  GetCursorPos( P );
  P := ScreenToClient( P );
  Kill := False;
  If P.Y < 0 Then
    ScrollLineUp
  Else
    If P.Y >= ClientHeight Then
      ScrollLineDown
    Else
      Kill := True;
  If P.X < 0 Then
    ScrollCharRight
  Else
    If P.X >= ClientWidth Then
      ScrollCharLeft
    Else
      If Kill Then
        KillTimer;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.WMVScroll( Var Message : TWMScroll );
begin
  Case Message.ScrollCode Of
    SB_LINEDOWN	  : ShiftLineDown;
    SB_LINEUP     : ShiftLineUp;
    SB_PAGEUp     : ShiftPageUp;
    SB_PAGEDown   : ShiftPageDown;
    SB_THUMBTRACK : TopIndex := Message.Pos;
  End;
  Message.Result := 0;
end;

{------------------------------------------------------------------}

Procedure TDCCustomImageListBox.SetCanDragItems( Value : Boolean );
begin
  If Sorted Then
    Exit;
  FCanDragItems := Value;
end;

{------------------------------------------------------------------}

Procedure TDCCustomImageListBox.DragOver( Source : TObject; X, Y : Integer;
  State : TDragState; Var Accept : Boolean );
Var
  SelItem : Integer;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _DrawFocusRect;
  begin
    If FOldDragSelItem <> SelItem Then
    begin
      DrawFocusRectOnDragItem;
      FOldDragSelItem := SelItem;
      FOldDragSelItemRect := GetItemRect( SelItem );
      FOldDragSelItemRect := Rect( 0, FOldDragSelItemRect.Top, ClientWidth, FOldDragSelItemRect.Bottom );
      DrawFocusRectOnDragItem;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  SelItem := ItemAtPos( X, Y, True );
  If DraggingItem < 0 Then
  begin
    If Source Is TDCImageListDragObject Then
      Inherited DragOver( TDCImageListDragObject( Source ).Control, X, Y, State, Accept )
    Else
      Inherited;

    If ShowRectWhenAcceptDrag And ( Source Is TDCImageListDragObject ) Then
    begin
      _DrawFocusRect;
      If FOldDragSelItem > 0 Then
        TDCImageListDragObject( Source ).NotifyObject := Self;
    end;
    Exit;
  end;
  Accept := ( SelItem >= 0 ) And ( SelItem <> FItemIndex ) And
            DoCanMoveItem( DraggingItem, SelItem );
  _DrawFocusRect;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.DrawFocusRectOnDragItem;
begin
  Canvas.Font.Color := clWhite;
  Canvas.Brush.Color := clBlack;
  If FOldDragSelItem >= 0 Then
    DrawFocusRect( Canvas.Handle, FOldDragSelItemRect );
end;

{------------------------------------------------------------------}

Procedure TDCCustomImageListBox.DoEndDrag( Target : TObject; X, Y : Integer );
begin
  If DraggingItem >= 0 Then
  begin
    DrawFocusRectOnDragItem;
    If ( DraggingItem <> FOldDragSelItem ) And ( FOldDragSelItem >= 0 ) And
       DoCanMoveItem( DraggingItem, FOldDragSelItem ) Then
      Items.MoveItemTo( DraggingItem, FOldDragSelItem );
    FDraggingItem := -1;
    FOldDragSelItem := -1;
    Invalidate;
  end
  Else
    Inherited;
end;

{------------------------------------------------------------------}

Function TDCCustomImageListBox.DoCanMoveItem( AOriginIndex, ADestIndex : Integer ) : Boolean;
begin
  Result := True;
  If Assigned( FOnCanMoveItem ) Then
    FOnCanMoveItem( Self, AOriginIndex, ADestIndex, Result );
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.DoItemMoved( AOriginIndex, ADestIndex : Integer );
begin
  If ItemIndex = AOriginIndex Then
    ItemIndex := ADestIndex;
  DoChanged;
  If Assigned( FOnItemMoved ) Then
    FOnItemMoved( Self, AOriginIndex, ADestIndex );
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.SetHighlightItems( Value : Boolean );
begin
  FHighlightItems := Value;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.UpdatePositions;
begin
  CheckNewItemIndex( FItemIndex ); 
  CheckNewTopIndex( FTopIndex );
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.CheckNewItemIndex( Var ANewItemIndex : Integer );
begin
  If ANewItemIndex >= ItemCount Then
    ANewItemIndex := ItemCount - 1;
  If ANewItemIndex < -1 Then
    ANewItemIndex := -1;
end;

{------------------------------------------------------------------}

Function TDCCustomImageListBox.GetItemsMaxWidth( Var AIndex : Integer ) : Integer;
Var
  I, ALength : Integer;
begin
  Result := 0;
  Canvas.Font := Font;
  For I := 0 To ItemCount - 1 Do
  begin
    ALength := TDCCustomImageListItem( Items[ I ] ).GetItemTextWidth( Canvas, False{HighlightItems} );
    If Result < ALength Then
    begin
      Result := ALength;
      AIndex := I;
    end;
  end;

  Result := Result + GetImageWidth;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.Delete( AIndex : Integer );
begin
  Items.BeginUpdate;
  try
    Items[ AIndex ].Free;
    If AIndex > ItemIndex Then
      Dec( FItemIndex );
    CheckNewItemIndex( FItemIndex );
  finally
    Items.EndUpdate;
    DoChanged;
  end;
end;

{------------------------------------------------------------------}

Function TDCCustomImageListBox.GetImageWidth : Integer;
begin
  Result := 0;
  If Assigned( ImageList ) Then
    Result := ImageList.Width + sDCSpaceX + sDCIconBorder Shl 1;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.ItemDeleting( AIndex : Integer );
begin
  If Parent = Nil Then
    Exit;
{$IFDEF D4}
  If Items.UpdateCount > 0 then
{$ELSE}
  If THCollection( Items ).FUpdateCount > 0 then
{$ENDIF}
  begin
    FLengthNeed := True;
    Exit;
  end;
  If AIndex < FMaxLengthIndex Then
  begin
    If FMaxLengthIndex = 0 Then
      RecalculateLength;
    Dec( FMaxLengthIndex );
    Exit;
  end;
  If AIndex = FMaxLengthIndex Then
    RecalculateLength;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.RecalculateLength;
begin
{$IFDEF D4}
  If Items.UpdateCount > 0 then
{$ELSE}
  If THCollection( Items ).FUpdateCount > 0 then
{$ENDIF}
  begin
    FLengthNeed := True;
    Exit;
  end;
  FMaxLength := GetItemsMaxWidth( FMaxLengthIndex );
  FLengthNeed := False;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.ItemCaptionChanged( AIndex : Integer );
Var
  ALength : Integer;
begin
  SoftSorting( TDCCustomImageListItem( Items[ AIndex ] ) );

  If Parent = Nil Then
    Exit;
{$IFDEF D4}
  If Items.UpdateCount > 0 then
{$ELSE}
  If THCollection( Items ).FUpdateCount > 0 then
{$ENDIF}
  begin
    FLengthNeed := True;
    Exit;
  end;
  ALength := TDCCustomImageListItem( Items[ AIndex ] ).GetItemTextWidth( Canvas, HighlightItems ) + GetImageWidth;
  Invalidate;
  If AIndex <> FMaxLengthIndex Then
  begin
    If FMaxLength < ALength Then
    begin
      FMaxLength := ALength;
      FMaxLengthIndex := AIndex;
      UpdateScrollSize;
    end;
    Exit;
  end;
  If FMaxLength < ALength Then
    FMaxLength := ALength
  Else
    RecalculateLength;
  UpdateScrollSize;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.DoStartDrag( Var DragObject : TDragObject );
begin
  Inherited;
  If DragObject = Nil Then
    DragObject := TDCImageListDragObject.Create( Self );
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.ResortItems;
begin
  FNeedToResort := Sorted And
     ( {$IFDEF D4}Items.UpdateCount > 0{$ELSE}THCollection( Items ).FUpdateCount > 0{$ENDIF} );
  If ( Not Sorted ) Or ( {$IFDEF D4}Items.UpdateCount > 0{$ELSE}THCollection( Items ).FUpdateCount > 0{$ENDIF} ) Then
    Exit;

  Items.BeginUpdate;
  try
    DCQuickSort( 0, ItemCount - 1, CompareItems, ChangeItems );
  finally
    Items.EndUpdate;
  end;
  FNeedToResort := False;
end;

{------------------------------------------------------------------}

Function TDCCustomImageListBox.GetSortingField( AIndex : Integer ) : String;
begin
  Result := TDCCustomImageListItem( Items[ AIndex ] ).Caption;
end;

{------------------------------------------------------------------}

Procedure TDCCustomImageListBox.ChangeItems( AOrigin, ADestination : Integer );
begin
  If AOrigin = ADestination Then
    Exit;
  Items[ AOrigin ].Index := ADestination;
  If ADestination = 0 Then
    Items[ 0 ].Index := AOrigin
  Else
    Items[ ADestination - 1 ].Index := AOrigin;
end;

{------------------------------------------------------------------}

Function TDCCustomImageListBox.CompareItems( AFirstItem, ASecondItem : Integer ) : Integer;
begin
  Result := AnsiCompareText( GetSortingField( AFirstItem ), GetSortingField( ASecondItem ) );
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.DragDrop( Source : TObject; X, Y : Integer );
begin
  If DraggingItem < 0 Then
    Inherited;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListBox.DoSelectionChanged;
begin
  If Assigned( FOnSelectionChanged ) Then
    FOnSelectionChanged( Self );
end;

{------------------------------------------------------------------}

Procedure TDCCustomImageListBox.WMMouseWheel( Var Message : TMessage );
Var
  Delta : Integer;
  Lines : Integer;
Begin
  Inc( FWheelDelta, SmallInt( Message.wParamHi ) );
  Delta := FWheelDelta Div WHEEL_DELTA;

  If Delta <> 0 Then
  Begin
    SystemParametersInfo( SPI_GETWHEELSCROLLLINES, 0, @Lines, 0 );
    ScrollByLines( -Delta * Lines );
    Dec( FWheelDelta, Delta * WHEEL_DELTA );
  End;
  Message.Result := 1;
end;

{------------------------------------------------------------------}

Procedure TDCCustomImageListBox.ScrollByLines( LinesCount : Integer );
begin
  TopIndex := TopIndex + LinesCount;
end;

{------------------------------------------------------------------}

Procedure TDCCustomImageListBox.SoftSorting( AItem : TDCCustomImageListItem );
Var
  NewIndex : Integer;
begin
  If FSoftSorting Then
    Exit;
  FSoftSorting := True;
  try
    If Sorted And ( Items.Count > 1 ) Then
    begin
      AItem.Collection := Nil;
      Find( AItem.Caption, NewIndex );
      AItem.Collection := Items;
      AItem.Index := NewIndex;
    end;
  finally
    FSoftSorting := False;
  end;
end;

{------------------------------------------------------------------}

{ TDCCustomImageListItem }

procedure TDCCustomImageListItem.Assign( ASource : TPersistent );
begin
  With TDCCustomImageListItem( ASource ) Do
  begin
    Self.FImageIndex := FImageIndex;
    Self.FCaption    := FCaption;
    Self.FUserData   := FUserData;
  end;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListItem.CaptionChanged;
begin
  TDCImageListItems( Collection ).ImageListBox.ItemCaptionChanged( Index );
end;

{------------------------------------------------------------------}

constructor TDCCustomImageListItem.Create( ACollection : TCollection );
begin
  Inherited;
  FImageIndex := -1;
end;

{------------------------------------------------------------------}

Destructor TDCCustomImageListItem.Destroy;
begin
  If ( Collection <> Nil ) And
     Not ( csDestroying In TDCImageListItems( Collection ).ImageListBox.ComponentState ) Then
    TDCImageListItems( Collection ).ImageListBox.ItemDeleting( Index );
  Inherited;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListItem.DrawAt( ACanvas : TCanvas; AItemRect : TRect; AHighlightItem : Boolean );
Var
  ImageList : TImageList;
  LabelTop  : Integer;
begin
  ImageList := GetImageList;
  If Assigned( ImageList ) Then
    DrawImage( ACanvas, AItemRect, ImageList );
  AItemRect.Right := AItemRect.Right;
  With ACanvas Do
  begin
    LabelTop := AItemRect.Top + ( AItemRect.Bottom - AItemRect.Top - TextHeight( sDCTextTemplate ) ) Shr 1;
    If AHighlightItem Then
      DCDrawHighlightedText( ACanvas, AItemRect, AItemRect.Left + sDCSpaceX, LabelTop, Caption )
    Else
      TextRect( AItemRect, AItemRect.Left + sDCSpaceX, LabelTop, Caption );
  end;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListItem.DrawImage( ACanvas : TCanvas; Var AItemRect : TRect; AImageList : TImageList );
Var
  BkColor              : TColor;
  ImageRect, OuterRect : TRect;
begin
  With ACanvas Do
  begin
    OuterRect := AItemRect;
    OuterRect.Right := OuterRect.Left + AImageList.Width + sDCIconBorder Shl 1;
    AItemRect.Left := OuterRect.Right;
    ImageRect := OuterRect;
    InflateRect( ImageRect, -sDCIconBorder, -sDCIconBorder );

    If ( ImageIndex < 0 ) Or ( ImageIndex >= AImageList.Count ) Then
    begin
      FillRect( OuterRect );
      Exit;
    end;

    BkColor := AImageList.BkColor;
    If BkColor = clNone Then
      BkColor := ACanvas.Brush.Color;
    ImageList_DrawEx( AImageList.Handle, ImageIndex, ACanvas.Handle, ImageRect.Left,
                      ImageRect.Top, AImageList.Width, AImageList.Height,
                      ColorToRGB( BkColor ), CLR_NONE, ILD_NORMAL );
    DCFillExcludeRect( ACanvas, OuterRect, ImageRect );
  end;
end;

{------------------------------------------------------------------}

Function TDCCustomImageListItem.GetDisplayName : String;
begin
  If Trim( Caption ) = '' Then
    Result := Inherited GetDisplayName
  Else
    Result := Caption;
end;

{------------------------------------------------------------------}

Function TDCCustomImageListItem.GetImageList : TImageList;
begin
  Result := Nil;
  If ( Collection = Nil ) Or ( TDCImageListItems( Collection ).FOwner = Nil ) Then
    Exit;
  Result := TDCImageListItems( Collection ).FOwner.ImageList;
end;

{------------------------------------------------------------------}

Function TDCCustomImageListItem.GetItemTextWidth( ACanvas : TCanvas; AHighlightItems : Boolean ) : Integer;
begin
  If AHighlightItems Then
    Result := DCGetHighlightedTextWidth( ACanvas, Caption )
  Else
    Result := ACanvas.TextWidth( Caption );
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListItem.SetCaption( Const Value : String );
begin
  If FCaption = Value Then
    Exit;
  FCaption := Value;
  CaptionChanged;
end;

{------------------------------------------------------------------}

procedure TDCCustomImageListItem.SetImageIndex( Value : Integer );
begin
  If FImageIndex = Value Then
    Exit;
  FImageIndex := Value;
  Changed( False );
end;

{------------------------------------------------------------------}

{ TDCImageListItems }

procedure TDCImageListItems.MoveItemTo( ASourceIndex, ADestIndex : Integer );
begin
  BeginUpdate;
  try
    If ASourceIndex = ADestIndex Then
      Exit;
    Items[ ASourceIndex ].Index := ADestIndex;
    FOwner.DoItemMoved( ASourceIndex, ADestIndex );
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

Function TDCImageListItems.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

{------------------------------------------------------------------}

procedure TDCImageListItems.Update( Item : TCollectionItem );
begin
  Inherited;
  ImageListBox.UpdateMeasurements( TDCCustomImageListItem( Item ) );
end;

{------------------------------------------------------------------}

{ TDCImageListDragObject }

{procedure TDCImageListDragObject.EndDrag(Target: TObject; X, Y: Integer);
begin
  Inherited;
  If Assigned( NotifyObject ) Then
    With NotifyObject Do
    begin
      DrawFocusRectOnDragItem;
      FOldDragSelItem := -1;
    end;
end;

{------------------------------------------------------------------}

Procedure TDCImageListDragObject.Finished( Target : TObject; X, Y : Integer;
  Accepted : Boolean);
begin
  Inherited;
  If Assigned( NotifyObject ) Then
    With NotifyObject Do
    begin
      DrawFocusRectOnDragItem;
      FOldDragSelItem := -1;
    end;
end;

{------------------------------------------------------------------}

Function TDCImageListDragObject.GetDragCursor( Accepted : Boolean; X, Y : Integer ) : TCursor;
Var
  Pos : TPoint;
{------------------------------------------------------------------}
  Function _CheckSelection( AObject : TDCCustomImageListBox ) : Boolean;
  begin
    Result := False;
    With AObject Do
      If ( FOldDragSelItem >= 0 ) And Not PtInRect( ClientRect, ScreenToClient( Pos ) ) Then
      begin
        DrawFocusRectOnDragItem;
        FOldDragSelItem := -1;
        Result := True;
      end;
  end;
{------------------------------------------------------------------}
begin
  Result := Inherited GetDragCursor( Accepted, X, Y );
  If Not ( Control Is TDCCustomImageListBox ) Then
    Exit;
  Pos.X := X;
  Pos.Y := Y;
  _CheckSelection( TDCCustomImageListBox( Control ) );
  If Assigned( NotifyObject ) And _CheckSelection( NotifyObject ) Then
    NotifyObject := Nil;
end;

{------------------------------------------------------------------}

Procedure TDCImageListItems.SetItemName( AItem : TCollectionItem );
begin
  Inherited;
  ImageListBox.SoftSorting( TDCCustomImageListItem( AItem ) );
end;

{------------------------------------------------------------------}

procedure TDCCustomCheckListItem.DrawAt( ACanvas : TCanvas; AItemRect : TRect;
  AHighlightItem : Boolean );
begin
  With TDCCustomCheckImageListBox( TDCImageListItems( Collection ).Owner ) Do
  If ShowCheckBoxes Then
    DrawCheckBox( ACanvas, AItemRect, Flat );
  Inherited DrawAt( ACanvas, AItemRect, AHighlightItem );
end;

{------------------------------------------------------------------}

procedure TDCCustomCheckListItem.DrawCheckBox( ACanvas : TCanvas; Var AItemRect : TRect;
  AFlat : Boolean );
Var
  DefaultWidth, DefaultHeight : Integer;
  DrawRect                    : TRect;
begin
  DefaultWidth := DefaultCheckWidth;
  DefaultHeight := DefaultCheckHeight;
  With AItemRect Do
  begin
    DrawRect.Left := Left + sDCCheckSpace;
    DrawRect.Top := Top + ( Bottom - Top - DefaultHeight ) Div 2;
  end;
  DrawRect.Right := DrawRect.Left + DefaultWidth;
  DrawRect.Bottom := DrawRect.Top + DefaultHeight;

  DCDrawCheckBox( ACanvas, DrawRect, State, AFlat, False, False );

  DCFillExcludeRect( ACanvas,
                     Rect( AItemRect.Left, AItemRect.Top, DrawRect.Right + sDCCheckSpace, AItemRect.Bottom ),
                     DrawRect );
  AItemRect.Left := DrawRect.Right + sDCCheckSpace;
end;

{------------------------------------------------------------------}

Function TDCCustomCheckListItem.GetChecked : Boolean;
begin
  Result := State = cbChecked;
end;

{------------------------------------------------------------------}

procedure TDCCustomCheckListItem.SetChecked( AValue : Boolean );
begin
  If AValue Then
    State := cbChecked
  Else
    State := cbUnchecked;
end;

{------------------------------------------------------------------}

procedure TDCCustomCheckListItem.SetState( AValue : TCheckBoxState );
begin
  If FState = AValue Then
    Exit;
  FState := AValue;
  With TDCImageListItems( Collection ) Do
{$IFDEF D4}
    If UpdateCount = 0 Then
{$ELSE}
    If THCollection( Collection ).FUpdateCount = 0 Then
{$ENDIF}
      TDCCustomCheckImageListBox( Owner ).CheckStateChanged( Self );
end;

{------------------------------------------------------------------}

{ TDCCustomCheckImageListBox }

procedure TDCCustomCheckImageListBox.CheckStateChanged( ASender : TDCCustomCheckListItem );
begin
  Invalidate;
  DoCheckStateChanged( ASender );
end;

{------------------------------------------------------------------}

constructor TDCCustomCheckImageListBox.Create( AOwner : TComponent );
begin
  Inherited;
  ShowCheckBoxes := True;
end;

{------------------------------------------------------------------}

procedure TDCCustomCheckImageListBox.DoCheckStateChanged( ASender : TDCCustomCheckListItem );
begin
  If Assigned( FOnCheckStateChanged ) Then
    FOnCheckStateChanged( Self, ASender );
end;

{------------------------------------------------------------------}

Function TDCCustomCheckImageListBox.GetImageWidth: Integer;
begin
  Result := Inherited GetImageWidth + DefaultCheckWidth + sDCCheckSpace Shl 1;
end;

{------------------------------------------------------------------}

Function TDCCustomCheckImageListBox.GetListItemClass : TDCImageListItemClass;
begin
  Result := TDCCheckListItem;
end;

{------------------------------------------------------------------}

Function TDCCustomCheckImageListBox.IsOverCheckBox( AIndex, X, Y : Integer ) : Boolean;
Var
  MousePt  : TPoint;
  ItemRect : TRect;
begin
  ItemRect := GetItemRect( AIndex );
  ItemRect.Right := ItemRect.Left + DefaultCheckWidth + sDCCheckSpace Shl 1;
  MousePt.X := X;
  MousePt.Y := Y;
  Result := PtInRect( ItemRect, MousePt );
end;

{------------------------------------------------------------------}

procedure TDCCustomCheckImageListBox.SetFlat( AValue : Boolean );
begin
  If FFlat = AValue Then
    Exit;
  FFlat := AValue;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TDCCustomCheckImageListBox.SetShowCheckBoxes( Value : Boolean );
begin
  If FShowCheckBoxes = Value Then
    Exit;
  FShowCheckBoxes := Value;
  Invalidate;
end;

{------------------------------------------------------------------}

Procedure TDCCustomCheckImageListBox.WMKeyDown( Var Message : TWMKeyDown );
begin
  If ( Message.CharCode = 32 ) And ( ItemIndex <> -1 ) Then
  begin
    With TDCCustomCheckListItem( Items[ ItemIndex ] ) Do
      Checked := Not Checked;
    Message.Result := -1;
    Exit;
  end;
  Inherited;
end;

{------------------------------------------------------------------}

Procedure TDCCustomCheckImageListBox.WMLButtonDown( Var Message : TWMLButtonDown );
Var
  Item : Integer;
begin
  Inherited;
  Item := ItemAtPos( Message.XPos, Message.YPos, True );
  If Item = -1 Then
    Exit;
  If IsOverCheckBox( Item, Message.XPos, Message.YPos ) Then
    With TDCCustomCheckListItem( Items[ Item ] ) Do
      Checked := Not Checked;
end;

{------------------------------------------------------------------}

{ TDCCustomBtnImageListBox }

Constructor TDCCustomBtnImageListBox.Create( AOwner : TComponent );
begin
  Inherited;
  FImageBackgroudColor := clBtnFace;
end;

{------------------------------------------------------------------}

Function TDCCustomBtnImageListBox.GetImageWidth : Integer;
begin
  Result := Inherited GetImageWidth + 2 + sDCIconBorder Shl 1;
end;

{------------------------------------------------------------------}

Function TDCCustomBtnImageListBox.GetItemsHeight : Integer;
begin
  Result := Inherited GetItemsHeight + 2 + sDCIconBorder Shl 1;
end;

{------------------------------------------------------------------}

Function TDCCustomBtnImageListBox.GetListItemClass : TDCImageListItemClass;
begin
  Result := TDCBtnImageListItem;
end;

{------------------------------------------------------------------}

procedure TDCCustomBtnImageListBox.SetImageBackgroudColor( AValue : TColor );
begin
  If FImageBackgroudColor = AValue Then
    Exit;
  FImageBackgroudColor := AValue;
  Invalidate;     
end;

{------------------------------------------------------------------}

{ TDCCustomBtnImageListItem }

procedure TDCCustomBtnImageListItem.DrawImage(ACanvas: TCanvas;
  var AItemRect: TRect; AImageList: TImageList);
Var
  SaveColor            : TColor;
  OuterRect, ImageRect : TRect;
begin
  If ImageIndex < 0 Then
    Exit;
  ImageRect := AItemRect;
  InflateRect( ImageRect, -1 - sDCIconBorder, -1 - sDCIconBorder );
  SaveColor := ACanvas.Brush.Color;
  ACanvas.Brush.Color := TDCCustomBtnImageListBox( TDCImageListItems( Collection ).Owner ).ImageBackgroudColor;
  Inherited DrawImage( ACanvas, ImageRect, AImageList );
  ACanvas.Brush.Color := SaveColor;

  OuterRect := AItemRect;
  OuterRect.Right := ImageRect.Left + 1 + sDCIconBorder;
  ImageRect := OuterRect;
  InflateRect( ImageRect, -sDCIconBorder, -sDCIconBorder );

  DrawEdge( ACanvas.Handle, ImageRect, BDR_RAISEDINNER, BF_TOPLEFT Or BF_BOTTOMRIGHT );
  DCFillExcludeRect( ACanvas, OuterRect, ImageRect );

  AItemRect.Left := OuterRect.Right;
end;

{------------------------------------------------------------------}

end.
