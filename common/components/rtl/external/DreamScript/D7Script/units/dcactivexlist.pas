{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCActiveXList;

interface

{$I DC.inc}

Uses
  Classes, ActiveX, Messages, Controls,

  DCSystem, DCdreamLib,
  DCPalette, DCImageListBox, DCInstCompListForm;

Type
  TDCActiveXListItem = class( TDCCheckListItem )
  private
    FTypeLib     : TGUID;
    FLibraryName : String;
  public
    Property TypeLib     : TGUID  Read FTypeLib Write FTypeLib;
    Property LibraryName : String Read FLibraryName Write FLibraryName;
  end;

{------------------------------------------------------------------}

  TDCCustomActiveXListBox = class( TDCCustomCheckImageListBox )
  private
    FUpdating : Boolean;

    procedure CMRegisterActiveX( Var Msg : TMessage ); message CM_RegisterActiveX;
    procedure CMUnregisterActiveX( Var Msg : TMessage ); message CM_UnregisterActiveX;
    Procedure CMActiveXChanged( Var Msg : TMessage ); message CM_ActiveXChanged;

    Procedure CMApplyOptions( Var Msg : TMessage ); message CM_ApplyOptions;

    procedure SetRegisterImmediately( AValue : Boolean );
    function GetRegisterImmediately: Boolean;
  protected
    Procedure DoCheckStateChanged( ASender : TDCCustomCheckListItem ); override;
    Function  GetListItemClass : TDCImageListItemClass; override;
    Procedure CreateHandle; override;

    Procedure SetLibraryState( Const AGUID : TGUID; AState : Boolean );
  public
    Constructor Create( AOwner : TComponent ); override;
    Destructor Destroy; override;

    Procedure Initialize;
    Procedure ShowDetails;
    Procedure SaveChanges;

    Property RegisterImmediately : Boolean Read GetRegisterImmediately Write SetRegisterImmediately;
    Property Sorted default True;
  end;

{------------------------------------------------------------------}

  TDCActiveXListBox = class( TDCCustomActiveXListBox )
  published
    Property Align;
    {$IFDEF D4}
    Property Anchors;
    {$ENDIF}
    Property ImageList;
    Property BorderStyle;
    Property Ctl3D;
    Property Color;
    Property Enabled;
    Property Font;
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
    Property HighlightItems;
    Property ShowRectWhenAcceptDrag;
    Property ShowCheckBoxes;
    Property Flat;
    Property RegisterImmediately; 

    Property OnCanMoveItem;
    Property OnItemMoved;
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
    property OnCheckStateChanged;
  end;

{------------------------------------------------------------------}

implementation

{------------------------------------------------------------------}

{ TDCCustomActiveXListBox }

procedure TDCCustomActiveXListBox.CMActiveXChanged( Var Msg : TMessage );
begin
  If FUpdating Then
    Exit;
  Initialize;
end;

{------------------------------------------------------------------}

procedure TDCCustomActiveXListBox.CMApplyOptions( Var Msg : TMessage );
begin
  If FUpdating Then
    Exit;
  FUpdating := True;
  try
    SaveChanges;
  finally
    FUpdating := False;
  end;
end;

{------------------------------------------------------------------}

Procedure TDCCustomActiveXListBox.CMRegisterActiveX( Var Msg : TMessage );
begin
  If FUpdating Then
    Exit;
  SetLibraryState( pGUID( Msg.wParam )^, True );
end;

{------------------------------------------------------------------}

Procedure TDCCustomActiveXListBox.CMUnregisterActiveX( Var Msg : TMessage );
begin
  If FUpdating Then
    Exit;
  SetLibraryState( pGUID( Msg.wParam )^, False );
end;

{------------------------------------------------------------------}

Constructor TDCCustomActiveXListBox.Create( AOwner : TComponent );
begin
  Inherited;
  RegisterNotifier( Self );
  Sorted := True;
end;

{------------------------------------------------------------------}

procedure TDCCustomActiveXListBox.CreateHandle;
begin
  Inherited;
  Initialize;
end;

{------------------------------------------------------------------}

Destructor TDCCustomActiveXListBox.Destroy;
begin
  UnregisterNotifier( Self );
  Inherited;
end;

{------------------------------------------------------------------}

procedure TDCCustomActiveXListBox.DoCheckStateChanged( ASender : TDCCustomCheckListItem );
begin
  With ASender, DCGetActiveXProvider Do
    If Checked Then
{$IFDEF BCB}
      RegisterActiveX( StringTOGUID( TTypeLibraryDesc( UserData ).GUID ) )
    Else
      UnregisterActiveX( StringTOGUID( TTypeLibraryDesc( UserData ).GUID ) );
{$ELSE}
      RegisterActiveX( TTypeLibraryDesc( UserData ).GUID )
    Else
      UnregisterActiveX( TTypeLibraryDesc( UserData ).GUID );
{$ENDIF}
  Inherited;
end;

{------------------------------------------------------------------}

Function TDCCustomActiveXListBox.GetListItemClass: TDCImageListItemClass;
begin
  Result := TDCActiveXListItem;
end;

{------------------------------------------------------------------}

Function TDCCustomActiveXListBox.GetRegisterImmediately: Boolean;
begin
  Result := DCGetActiveXProvider.RegisterImmediately;
end;

{------------------------------------------------------------------}

procedure TDCCustomActiveXListBox.Initialize;
Var
  I : Integer;
begin
  Items.BeginUpdate;
  try
    Items.Clear;

    With DCGetActiveXProvider Do
      For I := 0 To Count - 1 Do
        With TypeLibraries[ I ], TDCActiveXListItem( Items.Add ) Do
        begin
{$IFDEF BCB}
           If IsEqualGUID( StringToGUID( GUID ), GUID_NULL ) Then
{$ELSE}
           If IsEqualGUID( GUID, GUID_NULL ) Then
{$ENDIF}           
             Caption := sDCNoNameTypeLibrary
           Else
{$IFDEF BCB}
             Caption := GetTypeLibName( StringToGUID( GUID ) );
           TypeLib     := StringToGUID( GUID );
           LibraryName := DCGetInprocServer( StringToGUID( ActiveX[ 0 ] ) );
           Checked := RegisteredLibs.IndexOf( GUID ) >= 0;
{$ELSE}
             Caption := GetTypeLibName( GUID );
           TypeLib     := GUID;
           LibraryName := DCGetInprocServer( ActiveX[ 0 ] );
           Checked := RegisteredLibs.IndexOf( GUIDToString( GUID ) ) >= 0;
{$ENDIF}
           UserData := TypeLibraries[ I ];
        end;
  finally
    Items.EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TDCCustomActiveXListBox.SaveChanges;
begin
  DCGetActiveXProvider.SaveActiveXConfig;
end;

{------------------------------------------------------------------}

procedure TDCCustomActiveXListBox.SetLibraryState( Const AGUID : TGUID; AState : Boolean );
Var
  I : Integer;
begin
  With Items Do
    For I := 0 To Count - 1 Do
      With TDCCheckListItem( Items[ I ] ) Do
{$IFDEF BCB}
        If IsEqualGUID( StringToGUID( TTypeLibraryDesc( UserData ).GUID ), AGUID ) Then
{$ELSE}
        If IsEqualGUID( TTypeLibraryDesc( UserData ).GUID, AGUID ) Then
{$ENDIF}
        begin
          Checked := AState;
          break;
        end;
end;

{------------------------------------------------------------------}

procedure TDCCustomActiveXListBox.SetRegisterImmediately( AValue : Boolean );
begin
  DCGetActiveXProvider.RegisterImmediately := AValue;
end;

{------------------------------------------------------------------}

procedure TDCCustomActiveXListBox.ShowDetails;
begin
  If ItemIndex < 0 Then
    Exit;
  With TDCLibActiveXListForm.Create( Nil ) Do
    try
      InitActiveXs( TDCActiveXListItem( Items[ ItemIndex ] ).TypeLib );
      ShowModal;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

end.
