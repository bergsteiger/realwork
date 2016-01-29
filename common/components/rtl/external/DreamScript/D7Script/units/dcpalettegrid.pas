{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCPaletteGrid;

interface

uses
  Controls, Classes, Windows, Messages, Forms, Graphics,
  DCCommon, DCdreamLib,
  DCGraphFunc, DCImageListBox;

Const
  sDCDefaultWidth     = 320;
  sDCHeaderCellHeight = 24;

type
  TDCCustomPaletteGridSubItem = class( TCollectionItem )
  private
    FText : String;

    Procedure SetText( Const AValue : String );
  public
    Procedure DrawCell( ACanvas : TCanvas; ACellRect : TRect );
    Procedure Assign( ASource : TPersistent ); Override;

    Property Text : String Read FText Write SetText;
  end;

{------------------------------------------------------------------}

  TDCPaletteGridSubItem = class( TDCCustomPaletteGridSubItem )
  published
    Property Text;
  end;

{------------------------------------------------------------------}

  TDCCustomPaletteGridLineItem = class;

  TDCPaletteGridSubItems = class( TCollection )
  private
    FOwner : TDCCustomPaletteGridLineItem;
  protected
    Procedure Update( Item : TCollectionItem ); override;
    Function GetOwner : TPersistent; override;
  public
    Property PaletteGrid:TDCCustomPaletteGridLineItem Read FOwner Write FOwner;
    property Items[Index: Integer]: TCollectionItem read GetItem write SetItem; default;
  end;

{------------------------------------------------------------------}

  TDCPaletteGridSubItemClass = class of TDCPaletteGridSubItem;

  TDCCustomPaletteGridLineItem = class( TDCCustomBtnImageListItem )
  private
    FRows : TDCPaletteGridSubItems;

    Procedure SetRows( Value : TDCPaletteGridSubItems );
  protected
    Procedure DrawAt( ACanvas : TCanvas; AItemRect : TRect; AHighlightItem : Boolean ); override;

    Function GetRowsClass : TDCPaletteGridSubItemClass; virtual;
    Procedure UpdateMeasurements;
  public
    Constructor Create( Collection : TCollection ); override;
    Destructor Destroy; override;

    Procedure Assign( ASource : TPersistent ); Override;

    Property Rows : TDCPaletteGridSubItems Read FRows Write SetRows;
  end;

{------------------------------------------------------------------}

  TDCPaletteGridLineItem = class( TDCCustomPaletteGridLineItem )
  published
    Property ImageIndex;
    Property Rows;
  end;

{------------------------------------------------------------------}

  TDCPaletteGridListBox = class( TDCCustomBtnImageListBox )
  private
    FSortingCollumn : Integer;

    procedure SetSortingCollumn( Value : Integer );
  protected
    Function GetListItemClass : TDCImageListItemClass; override;
    Function GetColCount : Integer;

    Procedure DoEndDrag( Target : TObject; X, Y : Integer ); override;

    Function  GetSortingField( AIndex : Integer ) : String; override;
    Procedure ResortItems; override;

    Procedure ColCountChanged( ARow : TDCCustomPaletteGridLineItem; AColCount : Integer );
  public
    Constructor Create( AOwner : TComponent ); override;

    Procedure SetNewColCount( AColCount : Integer ); virtual;
  published
    Property SortingCollumn : Integer Read FSortingCollumn Write SetSortingCollumn;
  end;

{------------------------------------------------------------------}

  TDCCustomPaletteGridHeaderItem = class( TCollectionItem )
  private
    FWidth   : Integer;
    FCaption : String;

    procedure SetCaption( Const Value : String );
    procedure SetWidth( AValue : Integer );
  public
    Constructor Create( Collection : TCollection ); override;

    Procedure DrawCol( ACanvas : TCanvas; ARect : TRect; ABtnDown : Boolean ); virtual;

    Property Width   : Integer Read FWidth Write SetWidth;
    Property Caption : String  Read FCaption Write SetCaption;
  end;

  TDCPaletteGridHeaderItemClass = class of TDCCustomPaletteGridHeaderItem;

{------------------------------------------------------------------}

  TDCPaletteGridHeaderItem = class( TDCCustomPaletteGridHeaderItem )
  published
    Property Width;
    Property Caption;
  end;

{------------------------------------------------------------------}

  TDCCustomPaletteGridHeader = class;

  TDCPaletteGridHeaderItems = class( TCollection )
  private
    FOwner : TDCCustomPaletteGridHeader;
  protected
    Function  GetOwner : TPersistent; override;
    Procedure Update( Item : TCollectionItem ); override;
  public
    Property GridHeader:TDCCustomPaletteGridHeader Read FOwner Write FOwner;
    property Items[Index: Integer]: TCollectionItem read GetItem write SetItem; default;
  end;

{------------------------------------------------------------------}

  TDCColChangedEvent = Procedure( ASender : TObject; AColSelected : Integer ) of object;
  TDCCanColResizeEvent = Procedure( ASender : TObject; AColSelected : Integer;
                                    Var AWidth : Integer ) of object;

  TDCCustomPaletteGridHeader = class( TCustomControl )
  private
    FFlat              : Boolean;
    FAutoSizeCol       : Integer;
    FFontHeight        : Integer;
    FItems             : TDCPaletteGridHeaderItems;

    FOnColCountChanged : TNotifyEvent;
    FOnColClick        : TDCColChangedEvent;
    FOnCanColResize    : TDCCanColResizeEvent;

    FColDownState      : Boolean;
    FDownedBtn         : Integer;
    FDownedBtnRect     : TRect;
    FResizingCol       : Integer;
    FResizingColStart  : Integer;
    FResizingColStart2 : Integer;

    procedure SetAutoSizeCol( AValue : Integer );
    Function  GetColCount : Integer;
    procedure SetFlat( Value : Boolean );
    procedure SetItems( Value : TDCPaletteGridHeaderItems );

    Procedure WMEraseBkgnd( Var Msg : TWMEraseBkgnd ); message WM_EraseBkgnd;
    Procedure WMWindowPosChanging( Var Message : TWMWindowPosChanging ); message WM_WINDOWPOSCHANGING;
    Procedure CMFontChanged( Var Message : TMessage ); message CM_FONTCHANGED;
    Procedure WMLButtonDown( Var Message : TWMLButtonDown ); message WM_LBUTTONDOWN;
  protected
    Procedure Paint; override;

    Procedure MouseMove( Shift : TShiftState; X, Y : Integer ); override;
    Procedure MouseUp( Button : TMouseButton; Shift : TShiftState; X, Y : Integer ); override;

    Procedure SetParent( AParent : TWinControl ); override;

    Procedure DoColCountChanged; virtual;
    Procedure UpdateMeasurements; virtual;
    Procedure DoColClick( ACol : Integer ); virtual;
    Procedure DoCanColResize( ACol : Integer; Var AWidth : Integer ); virtual;

    Function  GetItemClass : TDCPaletteGridHeaderItemClass;
    Procedure SetNewColCount( AColCount : Integer ); virtual;

    Function GetItemsWidth : Integer;
    Function GetRealColWidth( ACol : Integer ) : Integer;
    Function IsMouseOverDivider( X, Y : Integer ) : Integer;
    Function ButtonAt( X, Y : Integer; Var ABtnRect : TRect ) : Integer;

    Procedure InvalidateItem( AIndex : Integer; Const AItemRect : TRect ); virtual;
  public
    Constructor Create( AOwner : TComponent ); override;
    Destructor Destroy; override;

    Function GetColRect( ACol : Integer ) : TRect;

    Property ColCount    : Integer Read GetColCount;
    Property AutoSizeCol : Integer Read FAutoSizeCol Write SetAutoSizeCol default 1;
    Property Flat        : Boolean Read FFlat        Write SetFlat default False;

    Property Items : TDCPaletteGridHeaderItems Read FItems Write SetItems;

    Property Width default sDCDefaultWidth;
    Property Height default sDCHeaderCellHeight;
    Property Color default clBtnFace;

    Property OnColCountChanged : TNotifyEvent         Read FOnColCountChanged Write FOnColCountChanged;
    Property OnColClick        : TDCColChangedEvent   Read FOnColClick Write FOnColClick;
    Property OnCanColResize    : TDCCanColResizeEvent Read FOnCanColResize Write FOnCanColResize;
  end;

  TDCPaletteGridHeaderClass = class of TDCCustomPaletteGridHeader;

{------------------------------------------------------------------}

  TDCPaletteGridHeader = class( TDCCustomPaletteGridHeader )
  published
    Property Align;
    Property ColCount;
    Property AutoSizeCol;
    Property Color;
    Property Flat;
    Property Items;

    Property OnColCountChanged;
    Property OnColClick;
    Property OnCanColResize;
  end;

{------------------------------------------------------------------}

  TDCCustomPaletteGrid = class( TWinControl )
  private
    FBorderStyle : TBorderStyle;
    FListBox     : TDCPaletteGridListBox;
    FHeader      : TDCCustomPaletteGridHeader;
    FColCount    : Integer;

    function GetImageList : TImageList;
    function GetItems : TDCImageListItems;
    function GetCanDragItems : Boolean;
    function GetCaptions : TDCPaletteGridHeaderItems;
    function GetAutoSizeCol : Integer;
    function GetItemIndex : Integer;
    function GetOnCanMoveItem : TDCCanMoveItemEvent;
    function GetOnChanged : TNotifyEvent;
    function GetOnItemMoved : TDCItemMovedEvent;
    function GetSorted : Boolean;
    function GetSortingCollumn : Integer;
    function GetOnSelectionChanged : TNotifyEvent;
    procedure SetBorderStyle( Value: TBorderStyle );
    procedure SetImageList( Value : TImageList );
    procedure SetItems( Const Value : TDCImageListItems );
    procedure SetCanDragItems( AValue : Boolean );
    procedure SetCaptions( AValue : TDCPaletteGridHeaderItems );
    procedure SetAutoSizeCol( AValue : Integer );
    procedure SetItemIndex( AValue : Integer );
    procedure SetOnCanMoveItem( AValue : TDCCanMoveItemEvent );
    procedure SetOnChanged( AValue : TNotifyEvent );
    procedure SetOnItemMoved( AValue : TDCItemMovedEvent );
    procedure SetSorted( AValue : Boolean );
    procedure SetSortingCollumn( Value : Integer );
    procedure SetOnSelectionChanged( AValue : TNotifyEvent );

    Procedure WMEraseBkgnd( Var Msg : TWMEraseBkgnd ); message WM_EraseBkgnd;
    Procedure WMWindowPosChanging( Var Message : TWMWindowPosChanging ); message WM_WINDOWPOSCHANGING;

    Procedure CanColResize( ASender : TObject; AColSelected : Integer; Var AWidth : Integer );
    Procedure ColClick( ASender : TObject; AColSelected : Integer );
  protected
    Procedure CreateParams( Var Params : TCreateParams ); override;
    Procedure SetParent( AParent : TWinControl ); override;

    Procedure SetNewColCount( AColCount : Integer );
    Function  GetHeaderClass : TDCPaletteGridHeaderClass; virtual;

    Property Header  : TDCCustomPaletteGridHeader Read FHeader;
    Property ListBox : TDCPaletteGridListBox      Read FListBox;
  public
    Constructor Create( AOwner : TComponent ); override;

    Procedure Clear;

    Property ItemIndex    : Integer Read GetItemIndex Write SetItemIndex;

    Property AutoSizeCol  : Integer            Read GetAutoSizeCol Write SetAutoSizeCol default 1;
    Property BorderStyle  : TBorderStyle       Read FBorderStyle Write SetBorderStyle Default bsSingle;
    Property ImageList    : TImageList         Read GetImageList Write SetImageList;
    Property CanDragItems : Boolean            Read GetCanDragItems Write SetCanDragItems;
    Property ColCount     : Integer            Read FColCount;
    Property Items        : TDCImageListItems  Read GetItems Write SetItems;
    Property Captions     : TDCPaletteGridHeaderItems Read GetCaptions Write SetCaptions;
    Property Sorted         : Boolean          Read GetSorted Write SetSorted default False;
    Property SortingCollumn : Integer          Read GetSortingCollumn Write SetSortingCollumn default -1;

    Property OnCanMoveItem      : TDCCanMoveItemEvent Read GetOnCanMoveItem Write SetOnCanMoveItem;
    Property OnItemMoved        : TDCItemMovedEvent   Read GetOnItemMoved Write SetOnItemMoved;
    Property OnChanged          : TNotifyEvent        Read GetOnChanged Write SetOnChanged;
    Property OnSelectionChanged : TNotifyEvent        Read GetOnSelectionChanged Write SetOnSelectionChanged;
  end;

{------------------------------------------------------------------}

  TDCPaletteGrid = class( TDCCustomPaletteGrid )
  published
    Property Align;
    Property BorderStyle;
    Property Ctl3D;

    Property AutoSizeCol;
    Property ImageList;
    Property CanDragItems;
    Property Items;
    Property Captions;
    Property Sorted;
    Property SortingCollumn;

    Property OnCanMoveItem;
    Property OnItemMoved;
    Property OnChanged;
    Property OnSelectionChanged;

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

implementation

{------------------------------------------------------------------}

Const
  sDCDefaultHeight = 120;

  sDCHeaderCellDefaultWidth = 64;
  sDCTextSpace              = 3;
  sDCHorzCellTextSpace      = 3;

  sDCMovingSpace = 3;

{------------------------------------------------------------------}

{ TDCCustomPaletteGrid }

procedure TDCCustomPaletteGrid.CanColResize( ASender : TObject; AColSelected : Integer;
  Var AWidth : Integer );
begin
  If AColSelected <> 0 Then
    Exit;
  If AWidth < FListBox.GetImageWidth Then
    AWidth := FListBox.GetImageWidth;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGrid.Clear;
begin
  Items.Clear;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGrid.ColClick( ASender : TObject; AColSelected : Integer );
begin
  SortingCollumn := AColSelected; 
end;

{------------------------------------------------------------------}

Constructor TDCCustomPaletteGrid.Create( AOwner: TComponent );
begin
  Inherited;
  Width := sDCDefaultWidth;
  Height := sDCDefaultHeight;

  FBorderStyle := bsSingle;
  FHeader := GetHeaderClass.Create( Self );
  With FHeader Do
  begin
    Align := alTop;
    OnCanColResize := CanColResize;
    OnColClick := ColClick;
  end;
  FColCount := FHeader.ColCount;
  FListBox := TDCPaletteGridListBox.Create( Self );
  FListBox.Align := alClient;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGrid.CreateParams(var Params: TCreateParams);
begin
  Inherited CreateParams( Params );
  Params.Style := Params.Style Or WS_TABSTOP;
  Params.WindowClass.Style := Params.WindowClass.Style Or CS_DBLCLKS;
  UpdateParamsWithBorderStyle( Params, FBorderStyle, Ctl3D );
end;

{------------------------------------------------------------------}

Function TDCCustomPaletteGrid.GetAutoSizeCol : Integer;
begin
  Result := FHeader.AutoSizeCol;
end;

{------------------------------------------------------------------}

Function TDCCustomPaletteGrid.GetCanDragItems: Boolean;
begin
  Result := FListBox.CanDragItems;
end;

{------------------------------------------------------------------}

Function TDCCustomPaletteGrid.GetCaptions : TDCPaletteGridHeaderItems;
begin
  Result := FHeader.Items;
end;

{------------------------------------------------------------------}

Function TDCCustomPaletteGrid.GetHeaderClass : TDCPaletteGridHeaderClass;
begin
  Result := TDCPaletteGridHeader
end;

{------------------------------------------------------------------}

Function TDCCustomPaletteGrid.GetImageList : TImageList;
begin
  Result := FListBox.ImageList;
end;

{------------------------------------------------------------------}

Function TDCCustomPaletteGrid.GetItemIndex : Integer;
begin
  Result := FListBox.ItemIndex;
end;

{------------------------------------------------------------------}

Function TDCCustomPaletteGrid.GetItems : TDCImageListItems;
begin
  Result := FListBox.Items;
end;

{------------------------------------------------------------------}

Function TDCCustomPaletteGrid.GetOnCanMoveItem : TDCCanMoveItemEvent;
begin
  Result := FListBox.OnCanMoveItem;
end;

{------------------------------------------------------------------}

Function TDCCustomPaletteGrid.GetOnChanged : TNotifyEvent;
begin
  Result := FListBox.OnChanged;
end;

{------------------------------------------------------------------}

Function TDCCustomPaletteGrid.GetOnItemMoved : TDCItemMovedEvent;
begin
  Result := FListBox.OnItemMoved;
end;

{------------------------------------------------------------------}

Function TDCCustomPaletteGrid.GetOnSelectionChanged : TNotifyEvent;
begin
  Result := FListBox.OnSelectionChanged;
end;

{------------------------------------------------------------------}

Function TDCCustomPaletteGrid.GetSorted : Boolean;
begin
  Result := FListBox.Sorted;
end;

{------------------------------------------------------------------}

Function TDCCustomPaletteGrid.GetSortingCollumn : Integer;
begin
  Result := FListBox.SortingCollumn;
end;

{------------------------------------------------------------------}

Procedure TDCCustomPaletteGrid.SetAutoSizeCol( AValue : Integer );
begin
  FHeader.AutoSizeCol := AValue;
end;

{------------------------------------------------------------------}

Procedure TDCCustomPaletteGrid.SetBorderStyle( Value : TBorderStyle );
begin
  If FBorderStyle <> Value Then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

{------------------------------------------------------------------}

Procedure TDCCustomPaletteGrid.SetCanDragItems( AValue : Boolean );
begin
  FListBox.CanDragItems := AValue;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGrid.SetCaptions( AValue : TDCPaletteGridHeaderItems );
begin
  FHeader.Items.Assign( AValue );
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGrid.SetImageList( Value : TImageList );
begin
  FListBox.ImageList := Value;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGrid.SetItemIndex( AValue : Integer );
begin
  FListBox.ItemIndex := AValue;
end;

{------------------------------------------------------------------}

Procedure TDCCustomPaletteGrid.SetItems( Const Value : TDCImageListItems );
begin
  FListBox.Items := Value;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGrid.SetNewColCount( AColCount : Integer );
begin
  If FColCount = AColCount Then
    Exit;
  If FHeader <> Nil Then
  begin
    FHeader.SetNewColCount( AColCount );
    FColCount := FHeader.ColCount;
  end;
  If FListBox <> Nil Then
    FListBox.SetNewColCount( FColCount );
end;

{------------------------------------------------------------------}

Procedure TDCCustomPaletteGrid.SetOnCanMoveItem( AValue : TDCCanMoveItemEvent );
begin
  FListBox.OnCanMoveItem := AValue;
end;

{------------------------------------------------------------------}

Procedure TDCCustomPaletteGrid.SetOnChanged( AValue : TNotifyEvent );
begin
  FListBox.OnChanged := AValue;
end;

{------------------------------------------------------------------}

Procedure TDCCustomPaletteGrid.SetOnItemMoved( AValue : TDCItemMovedEvent );
begin
  FListBox.OnItemMoved := AValue;
end;

{------------------------------------------------------------------}

Procedure TDCCustomPaletteGrid.SetOnSelectionChanged( AValue : TNotifyEvent );
begin
  FListBox.OnSelectionChanged := AValue;
end;

{------------------------------------------------------------------}

Procedure TDCCustomPaletteGrid.SetParent( AParent : TWinControl );
begin
  Inherited;
  If AParent = Nil Then
    Exit;
  FListBox.Parent := Self;
  FHeader.Parent := Self;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGrid.SetSorted( AValue : Boolean );
begin
  FListBox.Sorted := AValue;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGrid.SetSortingCollumn( Value : Integer );
begin
  FListBox.SortingCollumn := Value;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGrid.WMEraseBkgnd( Var Msg : TWMEraseBkgnd );
begin
  Msg.Result := 1;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGrid.WMWindowPosChanging( Var Message : TWMWindowPosChanging );
Var
  Len : Integer;
begin
  With Message.WindowPos^ Do
    If Flags And SWP_NOSIZE = 0 Then
    begin
      Len := Header.GetItemsWidth;
      If CX < Len Then
        CX := Len;
    end;
end;

{------------------------------------------------------------------}

{ TDCPaletteGridListBox }

procedure TDCPaletteGridListBox.ColCountChanged( ARow : TDCCustomPaletteGridLineItem; AColCount : Integer );
begin
  If AColCount = GetColCount Then
  begin
    Invalidate;
    Exit;
  end;
  TDCCustomPaletteGrid( Owner ).SetNewColCount( AColCount );
end;

{------------------------------------------------------------------}

Constructor TDCPaletteGridListBox.Create( AOwner : TComponent );
begin
  Inherited;
  BorderStyle := bsNone;
  Ctl3D := False;
  FSortingCollumn := -1;
end;

{------------------------------------------------------------------}

procedure TDCPaletteGridListBox.DoEndDrag( Target : TObject; X, Y : Integer );
begin
  Inherited;
  TDCCustomPaletteGrid( Owner ).DoEndDrag( Target, X, Y );
end;

{------------------------------------------------------------------}

Function TDCPaletteGridListBox.GetColCount : Integer;
begin
  Result := TDCCustomPaletteGrid( Owner ).ColCount;
end;

{------------------------------------------------------------------

Function TDCPaletteGridListBox.GetItemsHeight: Integer;
begin
  Result := Inherited GetItemsHeight + 2 + sDCIconBorder Shl 1;
end;

{------------------------------------------------------------------}

Function TDCPaletteGridListBox.GetListItemClass : TDCImageListItemClass;
begin
  Result := TDCPaletteGridLineItem;
end;

{------------------------------------------------------------------}

Function TDCPaletteGridListBox.GetSortingField( AIndex : Integer ) : String;
begin
  Result := '';
  If SortingCollumn < 0 Then
    Exit;
  Result := TDCCustomPaletteGridSubItem( TDCCustomPaletteGridLineItem( Items[ AIndex ] ).Rows[ SortingCollumn ] ).Text;
end;

{------------------------------------------------------------------}

Procedure TDCPaletteGridListBox.ResortItems;
begin
  If SortingCollumn = -1 Then
    Exit;
  Inherited ResortItems;
end;

{------------------------------------------------------------------}

procedure TDCPaletteGridListBox.SetNewColCount( AColCount : Integer );
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _SetNewColNumbers( AItem : TDCCustomPaletteGridLineItem );
  Var
    I : Integer;
  begin
    With AItem Do
    begin
      For I := FRows.Count - 1 DownTo AColCount Do
        FRows[ I ].Free;
      For I := FRows.Count To AColCount - 1 Do
        FRows.Add;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
Var
  I : Integer;
begin
  AColCount := GetColCount;
  If AColCount = ItemCount Then
    Exit;
  Items.BeginUpdate;
  try
    For I := 0 To ItemCount - 1 Do
      _SetNewColNumbers( TDCCustomPaletteGridLineItem( Items[ I ] ) );
  finally
    Items.EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPaletteGridListBox.SetSortingCollumn( Value : Integer );
begin
  If FSortingCollumn = Value Then
    Exit;
  FSortingCollumn := Value;
  ResortItems;
end;

{------------------------------------------------------------------}

{ TDCCustomPaletteGridHeader }

Function TDCCustomPaletteGridHeader.ButtonAt( X, Y: Integer; Var ABtnRect : TRect ) : Integer;
Var
  I       : Integer; 
  MousePt : TPoint;
begin
  MousePt.X := X;
  MousePt.Y := Y;
  ABtnRect := Rect( 0, 0, 0, sDCHeaderCellHeight );
  Result := -1;

  For I := 0 To ColCount - 1 Do
  begin
    ABtnRect.Left := ABtnRect.Right;
    ABtnRect.Right := ABtnRect.Left + GetRealColWidth( I );
    If PtInRect( ABtnRect, MousePt ) Then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridHeader.CMFontChanged( Var Message : TMessage );
begin
  Inherited;
  UpdateMeasurements;
end;

{------------------------------------------------------------------}

Constructor TDCCustomPaletteGridHeader.Create( AOwner : TComponent );
begin
  Inherited;
  Width := sDCDefaultWidth;
  Height := sDCHeaderCellHeight;
  Color := clBtnFace;

  FItems := TDCPaletteGridHeaderItems.Create( GetItemClass );
  With FItems Do
  begin
    GridHeader:=Self;
    BeginUpdate;
    try
      Add;
      Add;
    finally
      EndUpdate;
    end;
  end;

  FAutoSizeCol := 1;
  FDownedBtn := -1;
  FResizingCol := -1;
end;

{------------------------------------------------------------------}

Destructor TDCCustomPaletteGridHeader.Destroy;
begin
  FItems.Free;
  Inherited;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridHeader.DoColClick( ACol : Integer );
begin
  If Assigned( FOnColClick ) Then
    FOnColClick( Self, ACol );
end;

{------------------------------------------------------------------}

Procedure TDCCustomPaletteGridHeader.DoColCountChanged;
begin
  If Assigned( FOnColCountChanged ) Then
    FOnColCountChanged( Self );
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridHeader.DoCanColResize( ACol : Integer; Var AWidth : Integer );
begin
  If Assigned( FOnCanColResize ) Then
    FOnCanColResize( Self, ACol, AWidth );
end;

{------------------------------------------------------------------}

Function TDCCustomPaletteGridHeader.GetColCount : Integer;
begin
  Result := FItems.Count;
end;

{------------------------------------------------------------------}

Function TDCCustomPaletteGridHeader.GetColRect( ACol : Integer ) : TRect;
Var
  I : Integer; 
begin
  Result := Rect( 0, 0, 0, sDCHeaderCellHeight );
  For I := 0 To ACol - 1 Do
    Result.Left := Result.Left + GetRealColWidth( I );
  Result.Right := Result.Left + GetRealColWidth( ACol );
end;

{------------------------------------------------------------------}

Function TDCCustomPaletteGridHeader.GetItemsWidth : Integer;
Var
  I : Integer;
begin
  Result := 0;
  For I := 0 To ColCount - 1 Do
    If I <> AutoSizeCol Then
      Result := Result + TDCCustomPaletteGridHeaderItem( Items[ I ] ).Width;
end;

{------------------------------------------------------------------}

Function TDCCustomPaletteGridHeader.GetRealColWidth( ACol : Integer ) : Integer;
begin
  If ACol = AutoSizeCol Then
    Result := ClientWidth - GetItemsWidth
  Else
    Result := TDCCustomPaletteGridHeaderItem( Items[ ACol ] ).Width;
end;

{------------------------------------------------------------------}

Function TDCCustomPaletteGridHeader.IsMouseOverDivider( X, Y : Integer ) : Integer;
Var
  I, Shift : Integer;
begin
  Shift := GetRealColWidth( 0 );
  For I := 1 To ColCount - 1 Do
  begin
    If ( Shift - sDCMovingSpace <= X ) And ( X <= Shift + sDCMovingSpace ) Then
    begin
      Result := I - 1;
      Exit;
    end;
    If Shift > X Then
      break;
    Shift := Shift + GetRealColWidth( I );
  end;
  Result := -1;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridHeader.MouseMove( Shift : TShiftState; X, Y : Integer );
Var
  NewState : Boolean;
  MousePt  : TPoint;
begin
  Inherited;
  If FResizingCol >= 0 Then
  begin
    If FResizingCol >= AutoSizeCol Then
    begin
      If X < FResizingColStart2 Then
        X := FResizingColStart2;
      TDCCustomPaletteGridHeaderItem( Items[ FResizingCol ] ).Width := X - FResizingColStart2;
      TDCCustomPaletteGridHeaderItem( Items[ FResizingCol + 1 ] ).Width := FResizingColStart - X;
    end
    Else
      TDCCustomPaletteGridHeaderItem( Items[ FResizingCol ] ).Width := X - FResizingColStart;
    Exit;
  end;
  If FDownedBtn >= 0 Then
  begin
    MousePt.X := X;
    MousePt.Y := Y;
    NewState := PtInRect( FDownedBtnRect, MousePt );
    If NewState <> FColDownState Then
    begin
      FColDownState := NewState;
      InvalidateItem( FDownedBtn, FDownedBtnRect );
    end;
    Exit;
  end;
  If IsMouseOverDivider( X, Y ) < 0 Then
    Cursor := crDefault
  Else
    Cursor := crHSplit;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridHeader.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Var
  MousePt : TPoint;
begin
  Inherited;
  If FResizingCol >= 0 Then
  begin
    FResizingCol := -1;
    Exit;
  end;
  If FDownedBtn >= 0 Then
  begin
    MousePt.X := X;
    MousePt.Y := Y;
    If PtInRect( FDownedBtnRect, MousePt ) Then
      DoColClick( FDownedBtn );
    FDownedBtn := -1;
    Invalidate;
    Exit;
  end;
end;

{------------------------------------------------------------------}

Procedure TDCCustomPaletteGridHeader.Paint;
Var
  I       : Integer;
  ColRect : TRect;
begin
  Canvas.Brush.Color := Color;
  ColRect := Rect( 0, 0, 0, sDCHeaderCellHeight );
  For I := 0 To ColCount - 1 Do
  begin
    ColRect.Left := ColRect.Right;
    ColRect.Right := ColRect.Left + GetRealColWidth( I );
    InvalidateItem( I, ColRect );
  end;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridHeader.SetAutoSizeCol( AValue : Integer );
begin
  If AValue >= ColCount Then
    AValue := ColCount - 1;
  If AValue < 0 Then
    AValue := 0;
  FAutoSizeCol := AValue;
  AValue := 0; 
  DoCanColResize( FAutoSizeCol, AValue );
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridHeader.SetFlat( Value : Boolean );
begin
  If FFlat = Value Then
    Exit;
  FFlat := Value;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridHeader.UpdateMeasurements;
begin
  If Parent = Nil Then
    Exit;
  FFontHeight := Canvas.TextHeight( 'W' );
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridHeader.WMEraseBkgnd( Var Msg : TWMEraseBkgnd );
begin
  Msg.Result := 1;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridHeader.WMLButtonDown( Var Message : TWMLButtonDown );
Var
  ColRect : TRect;
begin
  Inherited;
  FResizingCol := IsMouseOverDivider( Message.XPos, Message.YPos );
  If FResizingCol >= 0 Then
  begin
    ColRect := GetColRect( FResizingCol );
    If FResizingCol >= AutoSizeCol Then
    begin
      FResizingColStart := GetColRect( FResizingCol + 1 ).Right;
      FResizingColStart2 := ColRect.Left;
    end
    Else
      FResizingColStart := ColRect.Left;
    Exit;
  end;
  FDownedBtn := ButtonAt( Message.XPos, Message.YPos, FDownedBtnRect );
  If FDownedBtn < 0 Then
    Exit;
  FColDownState := True;
  InvalidateItem( FDownedBtn, FDownedBtnRect );
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridHeader.WMWindowPosChanging( Var Message : TWMWindowPosChanging );
Var
  Len : Integer;
begin
  With Message.WindowPos^ Do
    If Flags And SWP_NOSIZE = 0 Then
    begin
      Len := GetItemsWidth;
      If CX < Len Then
        CX := Len; 
      CY := sDCHeaderCellHeight;
    end;
end;

{------------------------------------------------------------------}

Function TDCCustomPaletteGridHeader.GetItemClass : TDCPaletteGridHeaderItemClass;
begin
  Result := TDCPaletteGridHeaderItem;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridHeader.SetItems( Value : TDCPaletteGridHeaderItems );
begin
  FItems.Assign( Value );
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridHeader.InvalidateItem( AIndex : Integer; Const AItemRect : TRect );
begin
  TDCCustomPaletteGridHeaderItem( Items[ AIndex ] ).DrawCol( Canvas, AItemRect,
    FColDownState And ( FDownedBtn = AIndex ) );
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridHeader.SetParent( AParent : TWinControl );
begin
  Inherited;
  UpdateMeasurements;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridHeader.SetNewColCount( AColCount : Integer );
Var
  I : Integer;
begin
  If AColCount = Items.Count Then
   Exit;
  With Items Do
  begin
    BeginUpdate;
    try
      For I := Count - 1 DownTo AColCount Do
        Items[ I ].Free;
      For I := Count To AColCount - 1 Do
        Add;
    finally
      EndUpdate;
    end;
  end;
end;

{------------------------------------------------------------------}

{ TDCCustomPaletteGridLineItem }

Procedure TDCCustomPaletteGridLineItem.Assign( ASource : TPersistent );
begin
  Inherited;
  FRows.Assign( TDCCustomPaletteGridLineItem( ASource ).FRows );
end;

{------------------------------------------------------------------}

Constructor TDCCustomPaletteGridLineItem.Create( Collection : TCollection );
Var
  I, ColCount : Integer;
begin
  Inherited;
  FRows := TDCPaletteGridSubItems.Create( GetRowsClass );
  ColCount := TDCPaletteGridListBox( TDCImageListItems( Collection ).Owner ).GetColCount;

  With FRows Do
  begin
    PaletteGrid:=Self;
    BeginUpdate;
    try
      Clear;
      For I := 1 To ColCount Do
        Add;
    finally
      EndUpdate;
    end;
  end;
end;

{------------------------------------------------------------------}

Destructor TDCCustomPaletteGridLineItem.Destroy;
begin
  FRows.Free;
  Inherited;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridLineItem.DrawAt( ACanvas : TCanvas; AItemRect : TRect;
  AHighlightItem : Boolean );
Var
  I, Shift  : Integer;
  ImageList : TImageList;
  Header    : TDCCustomPaletteGridHeader;
begin
  ImageList := GetImageList;
  If Assigned( ImageList ) Then
    DrawImage( ACanvas, AItemRect, ImageList );
  AItemRect.Right := AItemRect.Left;
  Shift := AItemRect.Left;
  Header := TDCCustomPaletteGrid( TDCImageListItems( Collection ).ImageListBox.Owner ).Header;
  For I := 0 To FRows.Count - 1 Do
  begin
    AItemRect.Left := AItemRect.Right;
    AItemRect.Right := AItemRect.Left + Header.GetRealColWidth( I );
    If I = 0 Then
      AItemRect.Right := AItemRect.Right - Shift;
    TDCCustomPaletteGridSubItem( FRows[ I ] ).DrawCell( ACanvas, AItemRect );
  end;
end;

{------------------------------------------------------------------

procedure TDCCustomPaletteGridLineItem.DrawImage( ACanvas : TCanvas; Var AItemRect : TRect;
  AImageList : TImageList );
Var
  SaveColor            : TColor;
  OuterRect, ImageRect : TRect;
begin
  If ImageIndex < 0 Then
    Exit;
  ImageRect := AItemRect;
  InflateRect( ImageRect, -1 - sDCIconBorder, -1 - sDCIconBorder );
  SaveColor := ACanvas.Brush.Color;
  ACanvas.Brush.Color := clBtnFace;
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

Function TDCCustomPaletteGridLineItem.GetRowsClass: TDCPaletteGridSubItemClass;
begin
  Result := TDCPaletteGridSubItem;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridLineItem.SetRows( Value : TDCPaletteGridSubItems );
begin
  FRows.Assign( Value );
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridLineItem.UpdateMeasurements;
begin
  TDCPaletteGridListBox( TDCImageListItems( Collection ).Owner ).ColCountChanged( Self, FRows.Count );
end;

{------------------------------------------------------------------}

{ TDCPaletteGridSubItems }

Function TDCPaletteGridSubItems.GetOwner : TPersistent;
begin
  Result := FOwner;
end;

{------------------------------------------------------------------}

procedure TDCPaletteGridSubItems.Update( Item : TCollectionItem );
begin
  Inherited;
  PaletteGrid.UpdateMeasurements;
end;

{------------------------------------------------------------------}

{ TDCCustomPaletteGridSubItem }

procedure TDCCustomPaletteGridSubItem.Assign(ASource: TPersistent);
begin
  With TDCCustomPaletteGridSubItem( ASource ) Do
    Self.FText := FText;
end;

{------------------------------------------------------------------}

Procedure TDCCustomPaletteGridSubItem.DrawCell( ACanvas : TCanvas; ACellRect : TRect );
Var
  TextTop : Integer;
begin
  With ACellRect Do
    TextTop := Top + ( Bottom - Top - ACanvas.TextHeight( Text ) ) Shr 1;
  DCSmartTextOut( ACanvas, ACellRect, ACellRect.Left + sDCHorzCellTextSpace, TextTop, Text );
end;

{------------------------------------------------------------------}

Procedure TDCCustomPaletteGridSubItem.SetText( Const AValue : String );
begin
  If FText = AValue Then
    Exit;
  FText := AValue;
  TDCPaletteGridSubItems( Collection ).PaletteGrid.CaptionChanged;
end;

{------------------------------------------------------------------}

{ TDCPaletteGridHeaderItems }

Function TDCPaletteGridHeaderItems.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

{------------------------------------------------------------------}

procedure TDCPaletteGridHeaderItems.Update( Item : TCollectionItem );
begin
  Inherited;
  With FOwner Do
  begin
    While Count < 2 Do
      Add;
    SetAutoSizeCol( AutoSizeCol );
    If ( Owner <> Nil ) And ( Owner Is TDCCustomPaletteGrid ) Then
      With TDCCustomPaletteGrid( Owner ) Do
      begin
        SetNewColCount( Count );
        Invalidate;
        Exit
      end
    Else
      Invalidate;
  end;
end;

{------------------------------------------------------------------}

Constructor TDCCustomPaletteGridHeaderItem.Create( Collection : TCollection );
begin
  Inherited;
  With TDCPaletteGridHeaderItems( Collection ).GridHeader Do
    If Parent <> Nil Then
      FWidth := Min( sDCHeaderCellDefaultWidth, ClientWidth - TDCPaletteGridHeaderItems( Collection ).GridHeader.GetItemsWidth )
    Else
      FWidth := sDCHeaderCellDefaultWidth;
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridHeaderItem.DrawCol( ACanvas : TCanvas; ARect : TRect; ABtnDown : Boolean );
Const
  _ColState : Array[ Boolean ] Of UINT = ( 0, BF_FLAT );
  _FlatColState : Array[ Boolean ] Of UINT = ( BDR_RAISEDINNER, BDR_SUNKENOUTER );
Var
  TextTop : Integer;
  Header  : TDCCustomPaletteGridHeader;
begin
  If ARect.Left = ARect.Right Then
    Exit;
  Header := TDCPaletteGridHeaderItems( Collection ).GridHeader;
  If Header.Flat Then
    DrawEdge( ACanvas.Handle, ARect, _FlatColState[ ABtnDown ], BF_ADJUST Or BF_RECT )
  Else
    DrawEdge( ACanvas.Handle, ARect, EDGE_RAISED, BF_ADJUST Or BF_RECT Or BF_SOFT Or _ColState[ ABtnDown ] );
  TextTop := ARect.Top + ( ARect.Bottom - ARect.Top - Header.FFontHeight ) Div 2;
  DCSmartTextOut( ACanvas, ARect, ARect.Left + sDCTextSpace, TextTop, Caption );
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridHeaderItem.SetCaption( Const Value : String );
begin
  If FCaption = Value Then
    Exit;
  FCaption := Value;
  Changed( False );
end;

{------------------------------------------------------------------}

procedure TDCCustomPaletteGridHeaderItem.SetWidth( AValue : Integer );
Var
  SpaceLeft : Integer;
  Control   : TDCCustomPaletteGridHeader;
begin
  If FWidth = AValue Then
    Exit;

  Control := TDCPaletteGridHeaderItems( Collection ).FOwner;

  SpaceLeft := Control.ClientWidth - Control.GetItemsWidth;
  If Index <> Control.AutoSizeCol Then
    SpaceLeft := SpaceLeft + FWidth;
  If AValue > SpaceLeft Then
    AValue := SpaceLeft;
  If AValue < 0 Then
    AValue := 0;

  If FWidth = AValue Then
    Exit;

  Control.DoCanColResize( Index, AValue );
  FWidth := AValue;
  
  Changed( False );
end;

{------------------------------------------------------------------}

end.
