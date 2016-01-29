{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCPalettePropUnit;

interface

{$I dc.inc}

Uses
  StdCtrls, Controls, ExtCtrls, ComCtrls, Buttons, Classes, Forms, Windows,
  {$IFDEF D4}ImgList, {$ENDIF}Graphics, Messages, Dialogs, ActiveX, dcconsts, 
  DCSystem, DCGen, DCdreamLib,
  DCImageListBox, DCPalette, DCRenPropPageUnit, DCPaletteGrid, DCGraphFunc;

Type
  TDCDescription = class
    ItemName    : String;
    RealPage    : String;
    DefaultPage : String;
    Image       : Integer;
  end;

{------------------------------------------------------------------}

  TDCComponentDesc = Class( TDCDescription )
    ComponentClass : TComponentClass;
    PackageID      : THandle;
    PackageName    : String;
  end;

{------------------------------------------------------------------}

  TDCActiveXDesc = Class( TDCDescription )
    GUIDName    : String;
    LibraryName : String;
  end;

{------------------------------------------------------------------}

  TDCPalettePropForm = class(TForm)
    ImageList: TImageList;
    Panel1: TPanel;
    PagesLabel: TLabel;
    PagesList: TDCImageListBox;
    ControlBtnPanel: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    ComponentLabel: TLabel;
    ComponentsGrid: TDCPaletteGrid;
    Panel3: TPanel;
    DefaultPagesBtn: TBitBtn;
    MoveDownBtn: TBitBtn;
    MoveUpBtn: TBitBtn;
    RenameBtn: TBitBtn;
    DeleteBtn: TBitBtn;
    AddBtn: TBitBtn;
    procedure PagesListCanMoveItem(ASender: TObject; AOriginIndex,
      ADestIndex: Integer; var ACanMove: Boolean);
    procedure PagesListItemMoved(ASender: TObject; AOriginIndex,
      ADestIndex: Integer);
    procedure ListEnter(Sender: TObject);
    procedure MoveUpBtnClick(Sender: TObject);
    procedure MoveDownBtnClick(Sender: TObject);
    procedure RenameBtnClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure ComponentsGridChanged(Sender: TObject);
    procedure ComponentsGridCanMoveItem(ASender: TObject; AOriginIndex,
      ADestIndex: Integer; var ACanMove: Boolean);
    procedure ComponentsGridItemMoved(ASender: TObject; AOriginIndex,
      ADestIndex: Integer);
    procedure DefaultPagesBtnClick(Sender: TObject);
    procedure PagesListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ComponentsGridEndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure PagesListSelectionChanged(Sender: TObject);
  private
    FComponentList  : TList;
    FActiveXList    : TList;
    FPaletteStorage : IDCPaletteStorage;
    FLastControl    : TObject;
    FShowActiveX    : Boolean;

    FDontUpdate     : Boolean;

    procedure CMRefreshPalette( Var Msg : TMessage ); message CM_RefreshPalette;
//    procedure CMPACKAGEUNLOADED( Var Msg : TMessage ); message CM_PACKAGEUNLOADED;
//    procedure CMREGISTERCOMPS( Var Msg : TMessage ); message CM_REGISTERCOMPS;

    Function  GetComponents( Index : Integer ) : TDCComponentDesc;

    Procedure CMApplyOptions( Var Msg : TMessage ); message CM_ApplyOptions;

    Procedure Clear;
    Procedure EnumAllPageNames( ANameList : TStrings; Const ExcludeName : String );
    Procedure UpdateButtons;
    Procedure RefreshComponents;
    Procedure GetActiveList( Var AIndex : Integer; Var AItems : TDCImageListItems );
    Function  GetCurrentPageInfo : TDCStoredPageInfo;
    Function  InsertNewPage( Const APageName : String; AInfo : TDCStoredPageInfo;
                             AIndex : Integer ) : TDCCustomImageListItem;
    procedure SetRegistryKey( Const AValue : String );
    Function GetRegistryKey : String;
    Procedure SetShowActiveX( AValue : Boolean );
  protected
    Function  ComponentCount : Integer;
    Procedure MoveComponent( ASrcPage, AComponentIndex, ADestPage : Integer );
    Procedure HideComponent( Const APageName, AComponentName : String );
    Procedure ShowComponent( Const AComponentName : String; ADestPage : Integer );
    Function  GetComponentIndex( APageIndex : Integer; Const AComponentName : String ) : Integer;
    Function  GetPageIndex( Const APageName : String ) : Integer;

    Property Components[ Index : Integer ] : TDCComponentDesc Read GetComponents;
  public
    Constructor Create( AOwner : TComponent ); override;
    Destructor Destroy; override;

    Property RegistryKey : String  Read GetRegistryKey Write SetRegistryKey;
    Property ShowActiveX : Boolean Read FShowActiveX Write SetShowActiveX default True;

    Procedure RefreshPalette;
  end;

implementation

{$R *.DFM}

{------------------------------------------------------------------}

Type
  TMItems = class( TDCImageListItems );

{------------------------------------------------------------------}

{ TDCPalettePropForm }

Constructor TDCPalettePropForm.Create( AOwner : TComponent );
Var
  SaveCursor : TCursor;
begin
  Inherited;
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FShowActiveX := True;
    
    Caption := sDCPalettePropFormCaption;
    AddBtn.Caption := sDCAddBtnCaption;
    DeleteBtn.Caption := sDCHideBtnCaption;
    RenameBtn.Caption := sDCRenameBtnCaption;
    MoveUpBtn.Caption := sDCMoveUpBtnCaption;
    MoveDownBtn.Caption := sDCMoveDownBtnCaption;
    PagesLabel.Caption := sDCPagesLabelCaption;
    ComponentLabel.Caption := sDCComponentLabelCaption;
    DefaultPagesBtn.Caption := sDCDefaultPagesBtnCaption;

    TDCPaletteGridHeaderItem( ComponentsGrid.Captions[ 0 ] ).Caption := sDCNameColCaption;
    TDCPaletteGridHeaderItem( ComponentsGrid.Captions[ 1 ] ).Caption := sDCPackageColCaption;

    FComponentList := TList.Create;
    FActiveXList := TList.Create;
    FPaletteStorage := TDCPaletteStorage.Create( Self );
    FLastControl := PagesList;

    FPaletteStorage.Initialize;

    RegisterNotifier( Self );
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

{------------------------------------------------------------------}

Function DCGetPackageName( AHandle : THandle ) : String;
Var
  NameLength : Integer;
begin
  Result := '';
  SetLength( Result, 100 );
  NameLength := GetModuleFileName( AHandle, pChar( Result ), 100 );
  If NameLength = 0 Then
    Exit;
  SetLength( Result, NameLength );
end;

{------------------------------------------------------------------}

Procedure TDCPalettePropForm.RefreshPalette;
Var
  AGlyph     : TBitmap;
  HandleList : TStrings;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _LoadAllComponents;
  Var
    I      : Integer;
    NewCom : TDCComponentDesc;
  begin
    Clear;
    With ClassItems Do
      For I := 0 To Count - 1 Do
        With TClassItem( Items[ I ] ) Do
          If ( Categories * [ icNoIcon, icShowinPalette ] = [ icShowInPalette ] ) And
             ClassPtr.InheritsFrom( TComponent ) Then
          begin
            NewCom := TDCComponentDesc.Create;
            With NewCom Do
            begin
              ComponentClass := TComponentClass( ClassPtr );
              ItemName       := ComponentClass.ClassName;
              PackageID      := PackageHandle;
              PackageName    := DCGetPackageName( PackageHandle );
              DefaultPage    := PalettePage;
              RealPage       := FPaletteStorage.QueryComponentPage( PalettePage, ItemName );

              LoadBitmapForClass( AGlyph, ComponentClass );
              Image := DCAddImageInList( ImageList, AGlyph );
            end;
            FComponentList.Add( NewCom );
          end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure __LoadActiveXImage( AGlyph : TBitmap; Const AItemGUID : TGUID );
  Var
    PictIndex : Integer;
    PictName  : String;
    Idx       : Integer;
    H         : THandle;
  begin
    DCGetActiveXPictureInfo( AItemGUID, PictIndex, PictName );
    Idx := HandleList.IndexOf( PictName );
    If Idx < 0 Then
    begin
      H := LoadLibrary( PChar( PictName ) );
      If H <> 0 Then
        HandleList.AddObject( PictName, Pointer( H ) );
    end
    Else
      H := THandle( HandleList.Objects[ Idx ] );

    If ( ImageList <> Nil ) And
       ( FindResource( H, PChar( PictIndex ), RT_BITMAP ) <> 0 ) Then
      AGlyph.LoadFromResourceID( H, PictIndex )
    Else
      LoadUnknownGlyph( AGlyph );
    DCFitBitmap( AGlyph, ImageList.Width, ImageList.Height );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _LoadAllActiveX;
  Var
    I, J         : Integer;
    _LibraryName : String;
    NewDesc      : TDCActiveXDesc;
  begin
    If Not DCAreAnyActiveXAvailable Then
      Exit;

    With DCGetActiveXProvider Do
    begin
      If RegisteredLibs.Count = 0 Then
        Exit;
      For I := 0 To Count - 1 Do
        With TypeLibraries[ I ] Do
        begin
{$IFDEF BCB}
          If RegisteredLibs.IndexOf( GUID ) < 0 Then
{$ELSE}
          If RegisteredLibs.IndexOf( GUIDToString( GUID ) ) < 0 Then
{$ENDIF}
            continue;

{$IFDEF BCB}
          If IsEqualGUID( StringToGUID( GUID ), GUID_NULL ) Then
{$ELSE}
          If IsEqualGUID( GUID, GUID_NULL ) Then
{$ENDIF}
            _LibraryName := sDCNoNameTypeLibrary
          Else
{$IFDEF BCB}
            _LibraryName := GetTypeLibName( StringToGUID( GUID ) );
{$ELSE}
            _LibraryName := GetTypeLibName( GUID );
{$ENDIF}
          For J := 0 To Count - 1 Do
          begin
            NewDesc := TDCActiveXDesc.Create;
            With NewDesc Do
            begin
{$IFDEF BCB}
              ItemName := ActiveX[ J ];
              GUIDName := DCGetActiveXHint( StringToGUID( ActiveX[ J ] ) );
              __LoadActiveXImage( AGlyph, StringToGUID( ActiveX[ J ] ) );
{$ELSE}
              ItemName := GUIDToString( ActiveX[ J ] );
              GUIDName := DCGetActiveXHint( ActiveX[ J ] );
              __LoadActiveXImage( AGlyph, ActiveX[ J ] );
{$ENDIF}
              LibraryName := _LibraryName;
              RealPage    := FPaletteStorage.QueryComponentPage( sDCPalActiveX, ItemName );
              DefaultPage := sDCPalActiveX;

              Image := DCAddImageInList( ImageList, AGlyph );
            end;
            FActiveXList.Add( NewDesc );
          end;
        end;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _InitPagesList;
  Var
    I : Integer;
  begin
    With PagesList.Items Do
    begin
      BeginUpdate;
      try
        Clear;
        For I := 0 To FPaletteStorage.Count - 1 Do
          InsertNewPage( FPaletteStorage[ I ].PageName, FPaletteStorage[ I ], I );
        TDCImageListItem( Add ).Caption := sDCAllCompItemCaption;
      finally
        EndUpdate;
      end;
    end;
    PagesList.ItemIndex := 0;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
Var
  I : Integer;
begin
  AGlyph := TBitmap.Create;
  try
    _LoadAllComponents;
    HandleList := CreateSortedStringList;
    try
      _LoadAllActiveX;
    finally
      For I := 0 To HandleList.Count - 1 Do
        FreeLibrary( Integer( HandleList.Objects[ I ] ) );
      HandleList.Free;
    end;
  finally
    AGlyph.Free;
  end;
  _InitPagesList;
end;

{------------------------------------------------------------------}

Destructor TDCPalettePropForm.Destroy;
begin
  UnregisterNotifier( Self );
  Clear;
  FComponentList.Free;
  FActiveXList.Free;
  Inherited;
end;

{------------------------------------------------------------------}

Function TDCPalettePropForm.GetComponents( Index : Integer ) : TDCComponentDesc;
begin
  Result := TDCComponentDesc( FComponentList[ Index ] );
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.Clear;
Var
  I : Integer;
begin
  For I := 0 To FComponentList.Count - 1 Do
    TDCComponentDesc( FComponentList[ I ] ).Free;
  FComponentList.Clear;
  For I := 0 To FActiveXList.Count - 1 Do
    TDCActiveXDesc( FActiveXList[ I ] ).Free;
  FActiveXList.Clear;
  ImageList.Clear;
end;

{------------------------------------------------------------------}

Function TDCPalettePropForm.ComponentCount: Integer;
begin
  Result := FComponentList.Count;
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.PagesListCanMoveItem(ASender: TObject;
  AOriginIndex, ADestIndex: Integer; var ACanMove: Boolean);
Var
  ItemCount : Integer;
begin
  ItemCount := PagesList.Items.Count - 1;
  ACanMove := ( AOriginIndex <> ItemCount ) And ( ADestIndex <> ItemCount );
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.PagesListItemMoved(ASender: TObject;
  AOriginIndex, ADestIndex: Integer);
begin
  FPaletteStorage.MoveItemTo( AOriginIndex, ADestIndex );
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.ListEnter(Sender: TObject);
begin
  FLastControl := Sender;
  If Sender = PagesList Then
    DeleteBtn.Caption := sDCDeleteBtnCaption
  Else
    DeleteBtn.Caption := sDCHideBtnCaption;
  UpdateButtons;  
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.MoveUpBtnClick(Sender: TObject);
Var
  Index : Integer;
  Items : TDCImageListItems;
begin
  If Not Assigned( FLastControl ) Then
    Exit;

  GetActiveList( Index, Items );

  Items.MoveItemTo( Index, Index - 1 );
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.MoveDownBtnClick(Sender: TObject);
Var
  Index : Integer;
  Items : TDCImageListItems;
begin
  If Not Assigned( FLastControl ) Then
    Exit;

  GetActiveList( Index, Items );

  Items.MoveItemTo( Index, Index + 1 );
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.RenameBtnClick(Sender: TObject);
Var
  NameList : TStringList;
begin
  With PagesList, TDCImageListItem( Items[ ItemIndex ] ) Do
  begin
    NameList := CreateSortedStringList;
    try
      EnumAllPageNames( NameList, Caption );
      Caption := DCEditPalettePageName( NameList, Caption );
    finally
      NameList.Free;
    end;
    FPaletteStorage.Pages[ ItemIndex ].PageName := Caption;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.AddBtnClick(Sender: TObject);
Var
  NewPageName : String;
  NameList    : TStringList;
begin
  NameList := CreateSortedStringList;
  try
    EnumAllPageNames( NameList, '' );
    NewPageName := DCAddPalettePageName( NameList );
  finally
    NameList.Free;
  end;

  If NewPageName = '' Then
    Exit;

  With PagesList, FPaletteStorage Do
  begin
    InsertNewPage( NewPageName, Pages[ AddNewPage( NewPageName ) ], ItemCount - 1 );
    ItemIndex := Items.Count - 2;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.EnumAllPageNames( ANameList : TStrings;
  Const ExcludeName : String );
Var
  I : Integer;
begin
  ANameList.Clear;
  With PagesList Do
    For I := 0 To Items.Count - 2 Do
      With TDCImageListItem( Items[ I ]) Do
        If Caption <> ExcludeName Then
          ANameList.Add( Caption );
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.DeleteBtnClick(Sender: TObject);
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _DeletePalettePage;
  begin
    If ComponentsGrid.Items.Count <> 0 Then
    begin
      MessageDlg( SDCFullPageError, mtError, [mbOk], 0 );
      Exit;
    end;
    FPaletteStorage.DeletePage( PagesList.ItemIndex );
    PagesList.Delete( PagesList.ItemIndex );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
Var
  NewPageIndex, OldCountNumber : Integer;
begin
  If FLastControl = PagesList Then
    _DeletePalettePage
  Else
  begin
    With ComponentsGrid, TDCDescription( TDCCustomImageListItem( Items[ ItemIndex ] ).UserData ) Do
      If RealPage = '' Then
      begin
        OldCountNumber := FPaletteStorage.Count;
        NewPageIndex := FPaletteStorage.AddNewPage( DefaultPage );
        If OldCountNumber <> FPaletteStorage.Count Then
        begin
          InsertNewPage( DefaultPage, FPaletteStorage.Pages[ NewPageIndex ], NewPageIndex );
          PagesList.ItemIndex := PagesList.ItemIndex + 1;
        end;
        ShowComponent( ItemName, NewPageIndex )
      end
      Else
        HideComponent( RealPage, ItemName );
    RefreshComponents;
    UpdateButtons;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.RefreshComponents;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _ShowAllComponent;
  Var
    I : Integer;
  begin
    If ComponentsGrid.ColCount = 2 Then
      With TDCPaletteGridHeaderItem( ComponentsGrid.Captions.Add ) Do
      begin
        Caption := sDCPageColCaption;
        Width := 100;
      end;
    For I := 0 To FComponentList.Count - 1 Do
      With TDCComponentDesc( FComponentList[ I ] ) Do
        With TDCCustomPaletteGridLineItem( ComponentsGrid.Items.Add ) Do
        begin
          ImageIndex := Image;
          TDCCustomPaletteGridSubItem( Rows[ 0 ] ).Text := ItemName;
          TDCCustomPaletteGridSubItem( Rows[ 1 ] ).Text := PackageName;
          If RealPage = '' Then
            TDCCustomPaletteGridSubItem( Rows[ 2 ] ).Text := sDCHiddenComponent
          Else
            TDCCustomPaletteGridSubItem( Rows[ 2 ] ).Text := RealPage;
          UserData := FComponentList[ I ];
        end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _ShowAllActiveX;
  Var
    I : Integer;
  begin
    For I := 0 To FActiveXList.Count - 1 Do
      With TDCActiveXDesc( FActiveXList[ I ] ) Do
        With TDCCustomPaletteGridLineItem( ComponentsGrid.Items.Add ) Do
        begin
          ImageIndex := Image;
          TDCCustomPaletteGridSubItem( Rows[ 0 ] ).Text := GUIDName;
          TDCCustomPaletteGridSubItem( Rows[ 1 ] ).Text := LibraryName;
          If RealPage = '' Then
            TDCCustomPaletteGridSubItem( Rows[ 2 ] ).Text := sDCHiddenComponent
          Else
            TDCCustomPaletteGridSubItem( Rows[ 2 ] ).Text := RealPage;
          UserData := FActiveXList[ I ];
        end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Function __GetItemPage( AList : TList; Const AName : String ) : TDCDescription;
  Var
    I : Integer;
  begin
    Result := Nil;
    For I := 0 To AList.Count - 1 Do
      If TDCDescription( AList[ I ] ).ItemName = AName Then
        Result := TDCDescription( AList[ I ] );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _CustomizeComponent;
  Var
    I          : Integer;
    FoundTopic : Pointer;
  begin
    If ComponentsGrid.ColCount = 3 Then
      ComponentsGrid.Captions.Items[ 2 ].Free;

    If PagesList.ItemIndex = -1 Then
      Exit;
      
    With PagesList, GetCurrentPageInfo Do
      For I := 0 To Count - 1 Do
      begin
        If Components[ I ][ 1 ] = '{' Then
          FoundTopic := __GetItemPage( FActiveXList, Components[ I ] )
        Else
          FoundTopic := __GetItemPage( FComponentList, Components[ I ] );

        If FoundTopic = Nil Then
          continue;

        With TDCCustomPaletteGridLineItem( ComponentsGrid.Items.Add ) Do
        begin
          If Components[ I ][ 1 ] = '{' Then
          begin
            UserData := FoundTopic;
            With TDCActiveXDesc( UserData ) Do
            begin
              TDCCustomPaletteGridSubItem( Rows[ 0 ] ).Text := GUIDName;
              ImageIndex := Image;
              TDCCustomPaletteGridSubItem( Rows[ 1 ] ).Text := LibraryName;
            end;
          end
            Else
          begin
            TDCCustomPaletteGridSubItem( Rows[ 0 ] ).Text := Components[ I ];
            UserData := FoundTopic;
            With TDCComponentDesc( UserData ) Do
            begin
              ImageIndex := Image;
              TDCCustomPaletteGridSubItem( Rows[ 1 ] ).Text := PackageName;
            end;
          end;
        end;
      end;
    ComponentsGrid.ItemIndex := 0;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  ComponentsGrid.Items.BeginUpdate;
  try
    ComponentsGrid.Clear;
    If PagesList.ItemIndex = PagesList.ItemCount - 1 Then
    begin
      _ShowAllComponent;
      _ShowAllActiveX;
      If Not ComponentsGrid.Sorted Then
      begin
        ComponentsGrid.Sorted := True;
        ComponentsGrid.SortingCollumn := 0;
      end;
      Exit;
    end;
    _CustomizeComponent;
    ComponentsGrid.Sorted := False;
  finally
    ComponentsGrid.Items.EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.UpdateButtons;
Var
  CanMoveUp        : Boolean;
  Index, ItemCount : Integer;
begin
  ControlBtnPanel.DisableAlign;
  try
    DefaultPagesBtn.Visible := PagesList.ItemIndex = PagesList.Items.Count - 1;
    MoveUpBtn.Visible := Not DefaultPagesBtn.Visible;
    MoveDownBtn.Visible := MoveUpBtn.Visible;
  finally
    ControlBtnPanel.EnableAlign;
  end;

  If FLastControl = PagesList Then
    DeleteBtn.Caption := sDCDeleteBtnCaption
  Else
    If ComponentsGrid.ItemIndex >= 0 Then
      With ComponentsGrid, TDCDescription( TDCCustomImageListItem( Items[ ItemIndex ] ).UserData ) Do
        If RealPage = '' Then
          DeleteBtn.Caption := sDCShowBtnCaption
        Else
          DeleteBtn.Caption := sDCHideBtnCaption;

  DeleteBtn.Enabled := ( ( FLastControl <> PagesList ) And ( ComponentsGrid.ItemIndex >= 0 ) ) Or
                       ( ( FLastControl = PagesList ) And ( PagesList.ItemIndex <> PagesList.Items.Count - 1 ) );
  RenameBtn.Enabled := DeleteBtn.Enabled;
  If FLastControl = PagesList Then
  begin
    Index := PagesList.ItemIndex;
    ItemCount := PagesList.Items.Count - 1;
    CanMoveUp := Index < ItemCount;
  end
    Else
  begin
    Index := ComponentsGrid.ItemIndex;
    ItemCount := ComponentsGrid.Items.Count;
    CanMoveUp := True;
  end;
  MoveUpBtn.Enabled := CanMoveUp And ( Index > 0 );
  MoveDownBtn.Enabled := Index < ItemCount - 1;
  AddBtn.Enabled := ( FLastControl = PagesList );
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.ComponentsGridChanged(Sender: TObject);
begin
  UpdateButtons;
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.ComponentsGridCanMoveItem(ASender: TObject;
  AOriginIndex, ADestIndex: Integer; var ACanMove: Boolean);
begin
  ACanMove := PagesList.ItemIndex < PagesList.Items.Count - 1;
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.ComponentsGridItemMoved(ASender: TObject;
  AOriginIndex, ADestIndex: Integer);
begin
  GetCurrentPageInfo.MoveComponent( AOriginIndex, ADestIndex );
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.GetActiveList( Var AIndex: Integer; Var AItems : TDCImageListItems );
begin
  If FLastControl = PagesList Then
  begin
    AIndex := TDCImageListBox( FLastControl ).ItemIndex;
    AItems := TDCImageListBox( FLastControl ).Items;
    Exit;
  end;
  AIndex := TDCPaletteGrid( FLastControl ).ItemIndex;
  AItems := TDCPaletteGrid( FLastControl ).Items;
end;

{------------------------------------------------------------------}

function TDCPalettePropForm.GetCurrentPageInfo: TDCStoredPageInfo;
begin
  With PagesList Do
    Result := TDCStoredPageInfo( TDCCustomImageListItem( Items[ ItemIndex ] ).UserData );
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.DefaultPagesBtnClick(Sender: TObject);
begin
  FDontUpdate := True;
  try
    FPaletteStorage.ResetPalette;
    RefreshPalette;
    PagesList.ItemIndex := PagesList.Items.Count - 1;
  finally
    FDontUpdate := False;
    UpdateButtons;
    RefreshComponents;
  end;
end;

{------------------------------------------------------------------

procedure TDCPalettePropForm.CMPACKAGEUNLOADED( Var Msg : TMessage );
begin
  Inherited;
  RefreshPalette;
end;

{------------------------------------------------------------------

procedure TDCPalettePropForm.CMREGISTERCOMPS( Var Msg : TMessage );
begin
  Inherited;
  RefreshPalette;
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.PagesListDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
Var
  TargetItem : Integer;
begin
  Accept := False;
  If Source = PagesList Then
    Exit;
  TargetItem := PagesList.ItemAtPos( X, Y, True );
  Accept := ( TargetItem >= 0 ) And ( TargetItem <> PagesList.ItemIndex );
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.ComponentsGridEndDrag( Sender, Target : TObject;
  X, Y : Integer );
Var
  TargetItem, SrcPage : Integer;
begin
  If Target <> PagesList Then
    Exit;
  TargetItem := PagesList.ItemAtPos( X, Y, True );

  With ComponentsGrid, TDCDescription( TDCCustomImageListItem( Items[ ItemIndex ] ).UserData ) Do
  begin
    If ( TargetItem = PagesList.ItemCount - 1 ) Then
      HideComponent( RealPage, ItemName )
    Else
      If ( PagesList.ItemIndex = PagesList.ItemCount - 1 ) Then
        If RealPage = '' Then
          ShowComponent( ItemName, TargetItem )
        Else
        begin
          SrcPage := GetPageIndex( RealPage );
          MoveComponent( SrcPage, GetComponentIndex( SrcPage, ItemName ),
                         TargetItem );
        end
      Else
        MoveComponent( PagesList.ItemIndex, GetComponentIndex( PagesList.ItemIndex, ItemName ), TargetItem );
  end;
  UpdateButtons;
  RefreshComponents;
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.MoveComponent( ASrcPage, AComponentIndex, ADestPage : Integer );
begin
  With ComponentsGrid, TDCDescription( TDCCustomImageListItem( Items[ ItemIndex ] ).UserData ) Do
  begin
    RealPage := TDCCustomImageListItem( PagesList.Items[ ADestPage ] ).Caption;
    FPaletteStorage.MoveComponent( ASrcPage, AComponentIndex, ADestPage );
  end;
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.HideComponent( Const APageName, AComponentName : String );
Var
  SrcPage : Integer;
begin
  With ComponentsGrid, TDCDescription( TDCCustomImageListItem( Items[ ItemIndex ] ).UserData ) Do
  begin
    RealPage := '';
    SrcPage := GetPageIndex( APageName );
    FPaletteStorage.HideComponent( SrcPage, GetComponentIndex( SrcPage, AComponentName ) );
  end;
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.ShowComponent( Const AComponentName : String; ADestPage : Integer );
begin
  With ComponentsGrid, TDCDescription( TDCCustomImageListItem( Items[ ItemIndex ] ).UserData ) Do
  begin
    RealPage := FPaletteStorage.Pages[ ADestPage ].PageName;
    FPaletteStorage.ShowComponentEx( AComponentName, ADestPage );
  end;
end;

{------------------------------------------------------------------}

Function TDCPalettePropForm.GetComponentIndex( APageIndex : Integer; Const AComponentName : String ) : Integer;
begin
  Result := FPaletteStorage.Pages[ APageIndex ].GetComponentOnPage( AComponentName );
end;

{------------------------------------------------------------------}

Function TDCPalettePropForm.InsertNewPage( Const APageName : String;
  AInfo : TDCStoredPageInfo; AIndex : Integer ) : TDCCustomImageListItem;
begin
{$IFDEF D4}
  Result := TDCImageListItem( PagesList.Items.Insert( AIndex ) );
{$ELSE}
  Result := TDCImageListItem( PagesList.Items.Add );
  Result.Index := AIndex;
{$ENDIF}
  With Result Do
  begin
    Caption := APageName;
    UserData := AInfo;
  end;
end;

{------------------------------------------------------------------}

Function TDCPalettePropForm.GetPageIndex( Const APageName : String ) : Integer;
Var
  I : Integer;
begin
  For I := 0 To FPaletteStorage.Count - 1 Do
    If FPaletteStorage.Pages[ I ].PageName = APageName Then
    begin
      Result := I;
      Exit;
    end;
  Result := -1;
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.CMApplyOptions( Var Msg : TMessage );
begin
  FPaletteStorage.SavePalette;
  BroadCastToNotifiers( Self, CM_PaletteChanged, 0, 0 );
end;

{------------------------------------------------------------------}

Procedure TDCPalettePropForm.PagesListSelectionChanged(Sender: TObject);
begin
  If PagesList.ItemIndex = -1 Then
    Exit;
  If Not FDontUpdate Then
  begin
    UpdateButtons;
    RefreshComponents;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPalettePropForm.SetRegistryKey( Const AValue : String );
begin
  FPaletteStorage.SetNewRegKey( AValue );
end;

{------------------------------------------------------------------}

Function TDCPalettePropForm.GetRegistryKey : String;
begin
  Result := FPaletteStorage.GetRegKeyName;
end;

{------------------------------------------------------------------}

Procedure TDCPalettePropForm.SetShowActiveX( AValue : Boolean );
begin
  If FShowActiveX = AValue Then
    Exit;
  FShowActiveX := AValue;
  RefreshComponents;
end;

{------------------------------------------------------------------}

Procedure TDCPalettePropForm.CMRefreshPalette( Var Msg : TMessage );
begin
  Inherited;
  RefreshPalette;
end;

{------------------------------------------------------------------}

end.
