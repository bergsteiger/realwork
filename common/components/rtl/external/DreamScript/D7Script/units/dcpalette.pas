{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCPalette;

{$I dc.inc}

interface

Uses
  Classes, Dialogs, Windows, Controls, Graphics, Messages, ComCtrls, Forms, SysUtils, ActiveX,

  DCGen, DCSystem, DCCommon, DCAPI, DCdreamLib, DCConsts, DCEnvOpt,

  DCGraphFunc;


const
  sDCCannotSaveToRegistry = 'Error occurs while saving palette to registry.';
  sDCIndexOutOfBound = 'Index out of bounds';

Type
  TDCSinglePaletterBar = class;
  TOnGetHintEvent = procedure(Sender : TObject; var AHint : string) of object;

{------------------------------------------------------------------}

  TDCPaletteButton = class( TPersistent )
  private
    FOwner      : TDCSinglePaletterBar;
    FImageIndex : Integer;
  protected
    Procedure InitImage; virtual;
    Function GetComponentHint : String; virtual;

    Property ImageIndex : Integer Read FImageIndex Write FImageIndex;
    Function ButtonName : String; virtual;
  public
    Constructor Create( AOwner : TDCSinglePaletterBar ); virtual;
    Destructor Destroy; override;

    Function  ImageInitilized : Boolean; virtual;
    Procedure Assign( ASource : TPersistent ); override;

    Procedure DrawBtn( ACanvas : TCanvas; X, Y : Integer;
                       AMouseOver, ASelected : Boolean ); virtual;
  end;

{------------------------------------------------------------------}

  TDCCompButton = class( TDCPaletteButton )
  private
    FComponentClass : TComponentClass;
    FPackageID      : THandle;

    procedure SetComponentClass( Const Value: TComponentClass );
  protected
    Procedure InitImage; override;
    Function ButtonName : String; override;

    Function GetComponentHint : String; override;
  public
    Procedure Assign( ASource : TPersistent ); override;
    Procedure InitButton( AComponentClass : TComponentClass; APackageID : THandle );

    Function  ImageInitilized : Boolean; override;

    Property ComponentClass : TComponentClass Read FComponentClass;
    Property PackageID      : THandle         Read FPackageID;
  end;

{------------------------------------------------------------------}

  TDCActiveXButton = class( TDCPaletteButton )
  private
    FGUID    : TGUID;
    FTypeLib : TGUID;
    FHint    : String;
  protected
    Function GetComponentHint : String; override;
    Function ButtonName : String; override;
  public
    Procedure Assign( ASource : TPersistent ); override;
    Procedure InitButton( AGUID, ATypeLib : TGUID; Const AHint : String;
                          APicModule : THandle; APicIndex : Integer );

{$IFNDEF BCB}
    Property GUID    : TGUID Read FGUID;
    Property TypeLib : TGUID Read FTypeLib;
{$ENDIF}
  end;

{------------------------------------------------------------------}

  TDCStoredPageInfo = class;

  TDCSinglePaletterBar = class( TCustomControl )
  private
    FPermanentSelection : Boolean;
    FScrollBtnDown      : Integer;
    FButtons            : TList;
    FArrowBtn           : TDCPaletteButton;
    FTopButton          : Integer;
    FSelectedItem       : Integer;
    FLastActive         : Integer;
    FScrollTimer        : UINT;

    FClearing           : Boolean;

    Function  GetButtons( AIndex : Integer ) : TDCPaletteButton;
    Procedure SetButtons( AIndex : Integer; Const AValue : TDCPaletteButton );
    Procedure SetTopButton( Value : Integer );
    Procedure SetSelectedItem( AValue : Integer );
    Function  GetSelectedComponent : String;
    Procedure SetSelectedComponent( Const AValue : String );
    Procedure SetPermanentSelection( Value : Boolean );

    Procedure CMMouseLeave( Var Message : TMessage ); message CM_MOUSELEAVE;
    Procedure CMVisibleChanged( Var Message : TMessage ); message CM_VISIBLECHANGED;
    Procedure WMEraseBkgnd( Var Msg : TWMEraseBkgnd ); message WM_EraseBkgnd;
    Procedure WMTimer( Var Message : TWMTimer); message WM_TIMER;
    Procedure WMLButtonDblClk( Var Message : TWMLButtonDblClk ); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown( Var Message : TWMLButtonDown ); message WM_LBUTTONDOWN;
    procedure WMSize( Var Message : TWMSize ); message WM_SIZE;

    Function  GetButtonCount : Integer;
    Procedure InvalidateButton( AIndex : Integer );
    Procedure DrawArrowBtn;
    Procedure DrawScrollArrow( ABtnType : Integer );
    Procedure InitTimer( AScrollBar : Integer );
    Procedure KillTimer;
    Procedure DeleteImage( AImageIndex : Integer );
  protected
    Procedure Paint; override;
    Procedure MouseMove( Shift : TShiftState; X, Y : Integer ); override;
    Procedure MouseUp( Button : TMouseButton; Shift : TShiftState; X, Y : Integer ); override;

    Procedure AddButtonToCollection( AButton : TDCPaletteButton );
    Function  GetImageList : TImageList;
    Function  GetMouseCoord : TPoint;
    Function  GetVisibleCount : Integer;
    Procedure CheckTopButtonValue( Var AValue : Integer );
    Procedure DrawButton( ABtn : TDCPaletteButton; X, Y : Integer;
                          AMouseOver, ASelected : Boolean ); virtual;
    Function  CanShowHint : Boolean;
    Function  FindElementEx( AStartPos : Integer; Const AElementName : String ) : Integer;

    Property TopButton : Integer Read FTopButton Write SetTopButton;
  public
    Constructor Create( AOwner : TComponent ); override;
    Destructor Destroy; override;

    Procedure Clear;
    Procedure ResetSelection;

    Function FindElement( Const AElementName : String ) : Integer;
    Function AddComponent( AComponentClass : TComponentClass; APackageID : THandle ) : TDCPaletteButton;
    Function AddActiveX( AGUID, ATypeLib : TGUID; Const AHint : String; APicModule : THandle;
                         APicIndex : Integer ) : TDCPaletteButton;
    Function GetButtonAt( X, Y : Integer ) : Integer;
    Procedure DeleteButton( AIndex : Integer );

    Procedure ResetBarOrder( APageInfo : TDCStoredPageInfo );

    Property ButtonCount : Integer Read GetButtonCount;
    Property Buttons[ Index : Integer ] : TDCPaletteButton Read GetButtons Write SetButtons;

    Property SelectedItem       : Integer Read FSelectedItem Write SetSelectedItem;
    Property SelectedComponent  : String  Read GetSelectedComponent Write SetSelectedComponent;
    Property PermanentSelection : Boolean Read FPermanentSelection Write SetPermanentSelection;

    Property ShowHint default True;
  end;

{------------------------------------------------------------------}

  IDCPaletteStorage = Interface;

  TDCCustomComponentState = ( ccsRefreshing, ccsClearing );
  TDCCustomComponentStates = set of TDCCustomComponentState;

  TDCCustomComponentPalette = class( TCustomTabControl )
  private
    FPages            : TList;
    FImageList        : TImageList;
    FPaletteStorage   : IDCPaletteStorage;
    FMouseGlyph       : TBitmap;

    FUseGlobalOptions : Boolean;
    FOnlyDefinedItems : Boolean;
    FPredefinedPages  : TStrings;
    FRegistryKey      : String;

    FOnGetButtonHint  : TOnGetHintEvent;

    FPaletteState     : TDCCustomComponentStates;
//    FIsRefreshing     : Boolean;

    FShowActiveX      : Boolean;
    FAutoSize         : Boolean;

//    Procedure CMPackageUnloaded( Var Msg : TMessage ); message CM_PackageUnloaded;
//    Procedure CMRegisterComps( Var Msg : TMessage ); message CM_RegisterComps;
    procedure CMRefreshPalette( Var Msg : TMessage ); message CM_RefreshPalette;
    procedure CMObjectChanged( Var Msg : TMessage ); message CM_ObjectChanged;
    procedure CMObjInsert( Var Msg : TMessage ); message CM_ObjInsert;
    procedure CMRegisterActiveX( Var Msg : TMessage ); message CM_RegisterActiveX;
    procedure CMUnregisterActiveX( Var Msg : TMessage ); message CM_UnregisterActiveX;
    Procedure CMPaletteChanged( Var Msg : TMessage ); message CM_PaletteChanged;
//    Procedure CMActiveXChanged( Var Msg : TMessage ); message CM_ActiveXChanged;
    Procedure WMWindowPosChanging( Var Msg : TWMWindowPosChanging ); message WM_WINDOWPOSCHANGING;
    Procedure WMSYSCOLORCHANGE( Var Msg : TMessage ); message WM_SYSCOLORCHANGE;

    Procedure CMShowHintChanged( Var Msg : TMessage ); message CM_SHOWHINTCHANGED;

    Procedure DeleteImage( AImageIndex : Integer );
    Procedure ApplyPagesOnStorage;
    Procedure PagesOnChange( Sender : TObject );
    Procedure MouseGlyphChanged( Sender : TObject );

    Function  GetSelectedComponent : String;
    Procedure SetSelectedComponent( Const AValue : String );
    Function  GetButtonTabs( AIndex : Integer ) : TDCSinglePaletterBar;
    Function  GetPredefinedPages : TStrings;
    Procedure SetPredefinedPages( AValue : TStrings );
    Procedure SetOnlyDefinedItems( AValue : Boolean );
    Procedure SetRegistryKey( Const AValue : String );
    Procedure SetShowActiveX( AValue : Boolean );
    Procedure SetMouseGlyph( AValue : TBitmap );
    Procedure SetUseGlobalOptions( AValue : Boolean );
    Procedure InternalSetAutoSize( AValue : Boolean );
  protected
    Procedure SetParent( AParent : TWinControl ); override;
    Procedure Change; override;
    Procedure Loaded; override;
    Procedure SetName( Const AValue : TComponentName ); override;
    Procedure CreateHandle; override;

  {$IFNDEF D4}
    Procedure AdjustSize; dynamic;
  {$ENDIF}

    Function GetBarByName( Const APageName : String ) : TDCSinglePaletterBar;
    Function CreateNewPage( Const APageName : String ) : TDCSinglePaletterBar;
    Function AddNewPage( Const APageName : String ) : TDCSinglePaletterBar;

    Procedure ValidateRegKey;
    Procedure AdjustPaletteSize( Var AWidth, AHeight : Integer );

    Procedure DeletePage( AIndex : Integer );

    Property  PaletteState : TDCCustomComponentStates Read FPaletteState;
  public
    Constructor Create( AOwner : TComponent ); override;
    Destructor Destroy; override;

    Procedure RefreshData;
    Procedure Clear;
    Procedure ResetSelection;
    Procedure SetNewTabIndex( ATabIndex : Integer );

    Procedure RegisterComp( Const APageName : String; AComponentClass : TComponentClass;
                            APackageID : THandle );
    Procedure RegisterActiveX( AGuid, ATypeLib : TGUID; Const AHint : String;
                               APicModule : THandle; APicIndex : Integer );
    Procedure UnregisterActiveX( AGUID : TGUID );

    Function PageCount : Integer;

    procedure LoadGlobalOptions;
    procedure SelectMouseButton;

    Property ButtonTabs[ Index : Integer ] : TDCSinglePaletterBar Read GetButtonTabs;
    Property SelectedComponent : String   Read GetSelectedComponent Write SetSelectedComponent;

    Property MouseGlyph       : TBitmap  Read FMouseGlyph        Write SetMouseGlyph;

    Property AutoSize         : Boolean  Read FAutoSize          Write InternalSetAutoSize default True;
    Property OnlyDefinedItems : Boolean  Read FOnlyDefinedItems  Write SetOnlyDefinedItems default False;
    Property PredefinedPages  : TStrings Read GetPredefinedPages Write SetPredefinedPages;
    Property RegistryKey      : String   Read FRegistryKey       Write SetRegistryKey;
    Property ShowActiveX      : Boolean  Read FShowActiveX       Write SetShowActiveX default True;
    Property UseGlobalOptions : Boolean  Read FUseGlobalOptions  Write SetUseGlobalOptions stored False default True;

    property OnGetButtonHint : TOnGetHintEvent read FOnGetButtonHint write FOnGetButtonHint;

    Property ShowHint default True;
  end;

{------------------------------------------------------------------}

  TDCComponentPalette = class( TDCCustomComponentPalette )
  published
    property Align;
{$IFDEF D4}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DockSite;
    property DragKind;
    property DragMode;
    property Images;
    property ParentBiDiMode;
    property RaggedRight;
    property Style;
{$ENDIF}
    property Caption;
    property DragCursor;
    property Enabled;
    property Font;
    property HotTrack;
    property MouseGlyph;
    property MultiLine;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ScrollOpposite;
    property ShowHint;
    property TabHeight;
    property TabOrder;
    property TabPosition;
    property TabStop;
    property TabWidth;
    property Visible;

    Property AutoSize;
    Property OnlyDefinedItems;
    Property PredefinedPages;
    Property RegistryKey;
    Property ShowActiveX;
    Property UseGlobalOptions;

    property OnChange;
    property OnChanging;
{$IFDEF D5}
    property OnContextPopup;
{$ENDIF}
{$IFDEF D4}
    property OnDockDrop;
    property OnDockOver;
    property OnDrawTab;
    property OnEndDock;
    property OnGetImageIndex;
    property OnGetSiteInfo;
    property OnResize;
    property OnStartDock;
    property OnUnDock;
{$ENDIF}
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

{------------------------------------------------------------------}

  IDCPaletteStorage = Interface
  ['{9B4AE600-2BE1-11D4-BE6B-00E07D7432B8}']
    Function  GetRegKeyName : String;
    Procedure SetNewRegKey( Const ANewKeyName : String );
    Function  GetPages( Index : Integer ) : TDCStoredPageInfo;
    Procedure Clear;
    Function  IsClear : Boolean;
    Procedure Initialize;
    Procedure ResetPalette;
    Function  QueryComponentPage( Const AOldPage, AComponentName : String ) : String;
    Function  QueryComponentPageEx( Const AOldPage, AComponentName : String;
                                    Var AStoragePageIndex, AStorageCompIndex : Integer ) : String;
    Function  PageByName( Const APageName : String ) : Integer;
    Procedure InsertPage( APageIndex : Integer; Const APageName : String );
    Procedure MovePage( AOldPosition, ANewPosition : Integer );

    Procedure MoveItemTo( ASourceIndex, ADestIndex : Integer );
    Function  AddNewPage( Const APageName : String ) : Integer;
    Procedure DeletePage( AIndex : Integer );
    Function  MoveComponent( ASrcPage, AComponentIndex, ADestPage : Integer ) : Integer;
    Function  HideComponent( ASrcPage, AComponentIndex : Integer ) : Integer;
    Function  ShowComponent( AComponentIndex, ADestPage : Integer ) : Integer;
    Function  ShowComponentEx( Const AComponentName : String; ADestPage : Integer ) : Integer;

    Procedure SavePalette;

    Function Count : Integer;
    Property Pages[ Index : Integer ] : TDCStoredPageInfo Read GetPages; default;
  end;

{------------------------------------------------------------------}
// - by Volkoff - options file support
  TDCPaletteStorage = class( TInterfacedObject, IDCPaletteStorage )
  private
    FNoItems        : Boolean;
    FOpenedKey      : HKEY;
    FPages          : TList;
    FHiddenControls : TStrings;
    FRegKey         : String;
    FOwner          : TObject;

    Function GetHiddenControls( AIndex : Integer ) : String;
    Procedure SetHiddenControls( AIndex : Integer; Const AValue : String );

    procedure CMPACKAGEUNLOADED( Var Msg : TMessage ); message CM_PACKAGEUNLOADED;
    procedure CMREGISTERCOMPS( Var Msg : TMessage ); message CM_REGISTERCOMPS;

    Procedure CMActiveXChanged( Var Msg : TMessage ); message CM_ActiveXChanged;

    Function GetPages( Index : Integer ) : TDCStoredPageInfo;
  protected
    Function  GetPalleteRegKey : String;
    Function  CreateRegKey( AMode : REGSAM ) : Boolean;
    Function  OpenRegKey( AMode : REGSAM ) : Boolean;
    Procedure CloseRegKey;
    Procedure SentMessageOwner( AMsg : Cardinal; AWParam, ALParam : Longint );

    Procedure Clear;
    Procedure AddToList( Const APageName, AComponentName : String;
                         Var AStoragePageIndex, AStorageCompIndex : Integer );

    Procedure ExchangeItems( ASourceIndex, ADestIndex : Integer );
    Procedure LoadDefaultPages;
    Procedure LoadDefaultActiveX;

    Property Owner : TObject Read FOwner;
  public
    Constructor Create( AOwner : TObject ); virtual;
    Destructor Destroy; override;

    Function  GetRegKeyName : String;
    Procedure SetNewRegKey( Const ANewKeyName : String );
    Function  IsClear : Boolean;

    Procedure Initialize;
    Procedure ResetPalette;

    Function  QueryComponentPage( Const AOldPage, AComponentName : String ) : String;
    Function  QueryComponentPageEx( Const AOldPage, AComponentName : String;
                                    Var AStoragePageIndex, AStorageCompIndex : Integer ) : String;
    Function  PageByName( Const APageName : String ) : Integer;
    Procedure InsertPage( APageIndex : Integer; Const APageName : String );
    Procedure MovePage( AOldPosition, ANewPosition : Integer );

    Function  AddNewPage( Const APageName : String ) : Integer;

    Procedure MoveItemTo( ASourceIndex, ADestIndex : Integer );
    Procedure DeletePage( AIndex : Integer );
    Function  MoveComponent( ASrcPage, AComponentIndex, ADestPage : Integer ) : Integer;
    Function  HideComponent( ASrcPage, AComponentIndex : Integer ) : Integer;
    Function  ShowComponent( AComponentIndex, ADestPage : Integer ) : Integer;
    Function  ShowComponentEx( Const AComponentName : String; ADestPage : Integer ) : Integer;

    Procedure SavePalette;

    Function Count : Integer;
    Function HiddenCount : Integer;
    Property Pages[ Index : Integer ] : TDCStoredPageInfo Read GetPages; default;
    Property HiddenControls[ Index : Integer ] : String Read GetHiddenControls Write SetHiddenControls;
  end;

{------------------------------------------------------------------}

  TDCStoredPageInfo = class
  private
    FPageName   : String;
    FComponents : TStrings;

    Function GetComponents( AIndex: Integer ) : String;
    Function GetCount : Integer;
    Procedure SetComponents( AIndex : Integer; Const AValue : String );
  public
    Constructor Create( Const AName, AValues : String ); virtual;
    Destructor Destroy; override;

    Procedure Clear;
    Function  GetComponentOnPage( Const AComponentName : String ) : Integer;
    Function  AddComponent( Const AComponentName : String ) : Integer;
    Procedure InsertComponent( AIndex : Integer; Const AComponentName : String );
    Procedure DeleteComponent( AIndex : Integer );
    Function  GetComponentsSet : String;
    Procedure MoveComponent( AStartIndex, ADestIndex : Integer );

    Property PageName : String Read FPageName Write FPageName;
    Property Count : Integer Read GetCount;
    Property Components[ Index : Integer ] : String Read GetComponents Write SetComponents;
  end;

{------------------------------------------------------------------}

  pGUIDArray = ^TGUIDArray;
  TGUIDArray = Array[ 0 .. Maxint Div SizeOf( TGUID ) - 1 ] Of TGUID;

  TTypeLibraryDesc = class
  private
    FGUID    : TGUID;
    FCount   : Integer;
    FActiveX : PGUIDArray;

{$IFDEF BCB}
    Function GetGUID : String;
    Function GetActiveX( AIndex : Integer ) : String;
{$ELSE}
    Function GetActiveX( AIndex : Integer ) : TGUID;
    Procedure SetActiveX( AIndex : Integer; Const AValue : TGUID );
{$ENDIF}

    Procedure CheckRange( AIndex : Integer );
  protected
    Procedure Clear;
    Function AddActiveX( AGUID : TGUID ) : Integer;
  public
    Destructor Destroy; override;

{$IFDEF BCB}
    Property GUID : String Read GetGUID;
    Property ActiveX[ Index : Integer ] : String Read GetActiveX;
{$ELSE}
    Property GUID : TGUID Read FGUID;
    Property ActiveX[ Index : Integer ] : TGUID Read GetActiveX Write SetActiveX;
{$ENDIF}

    Property Count : Integer Read FCount;
  End;

{------------------------------------------------------------------}

  TActiveXProvider = class
  private
    FInitiliazed         : Boolean;
    FTypeLibraries       : TList;
    FRegisteredLibs      : TStrings;
    FRegisterImmediately : Boolean;

    Function GetCount : Integer;
    Function GetTypeLibraries( AIndex : Integer ) : TTypeLibraryDesc;
    Function GetRegisteredLibs : TStrings;
    procedure SetRegisterImmediately( AValue: Boolean);
  protected
    Procedure InitNeeded;
    Procedure Clear;
    Procedure AddActiveX( AActiveX, ATypeLib : TGUID );
    Function FindTypeLib( ATypeLib : TGUID ) : Integer;
    Procedure InitRegisteredLibs;
  public
    Constructor Create; virtual;
    Destructor Destroy; override;

    Procedure Initialize;

    Procedure RegisterActiveX( Const AActiveXLib : TGUID );
    Procedure UnregisterActiveX( Const AActiveXLib : TGUID );
    Procedure SaveActiveXConfig;
    Function WasAnyChanges : Boolean;

    Property RegisteredLibs : TStrings Read GetRegisteredLibs;

    Property Count : Integer Read GetCount;
    Property TypeLibraries[ Index : Integer ] : TTypeLibraryDesc Read GetTypeLibraries;
    Property RegisterImmediately : Boolean Read FRegisterImmediately Write SetRegisterImmediately;
  End;

{------------------------------------------------------------------}

Function  DCAreAnyActiveXAvailable : Boolean;
Function  DCGetActiveXProvider : TActiveXProvider;
Function  DCGetTypeLibraryGUID( AGUID : TGUID ) : TGUID;
Procedure DCGetActiveXPictureInfo( AItemGUID : TGUID; Var PictIndex : Integer;
  Var PictName : String );
Function  DCGetActiveXHint( AItemGUID : TGUID ) : String;
Function  DCGetInprocServer( AItemGUID : TGUID ) : String;
Procedure DCLoadActiveXPicture( AGlyph : TBitmap; APicModule : THandle; APicIndex : Integer );
Function  DCIsActiveXRegisteres( Const AStrGUID : String ) : Boolean;

Function DCReadValueFromRegistry( AOpenKey : HKEY; Const AValue : String ) : String;

{------------------------------------------------------------------}

Const
  sDCNoNameTypeLibrary = '[No type library]';
  sDCPalActiveX = 'ActiveX';        

{------------------------------------------------------------------}

Implementation

Const
  ClassPrefix = 'T';

{$IFNDEF C4}
Const
  CLSID_StdComponentCategoryMgr: TGUID = '{0002E005-0000-0000-C000-000000000046}';
  
Type
  PCATEGORYINFO = ^TCATEGORYINFO;
  TCATEGORYINFO = record
    catid: TGUID;
    lcid: UINT;
    szDescription: array[0..127] of WideChar;
  end;

  IEnumCATEGORYINFO = interface(IUnknown)
    ['{0002E011-0000-0000-C000-000000000046}']
    function Next(celt: UINT; out rgelt: TCATEGORYINFO; out pceltFetched: UINT): HResult; stdcall;
    function Skip(celt: UINT): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppenum: IEnumCATEGORYINFO): HResult; stdcall;
  end;

  IEnumGUID = interface(IUnknown)
    ['{0002E000-0000-0000-C000-000000000046}']
    function Next(celt: UINT; out rgelt: TGUID; out pceltFetched: UINT): HResult; stdcall;
    function Skip(celt: UINT): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppenum: IEnumGUID): HResult; stdcall;
  end;

  ICatInformation = interface(IUnknown)
    ['{0002E013-0000-0000-C000-000000000046}']
    function EnumCategories(lcid: UINT; out ppenumCategoryInfo: IEnumCATEGORYINFO): HResult; stdcall;
    function GetCategoryDesc(const rcatid: TGUID; lcid: UINT; out pszDesc: PWideChar): HResult; stdcall;
    function EnumClassesOfCategories(cImplemented: UINT; rgcatidImpl: Pointer; cRequired: UINT; rgcatidReq: Pointer; out ppenumClsid: IEnumGUID): HResult; stdcall;
    function IsClassOfCategories(const rclsid: TGUID; cImplemented: UINT; rgcatidImpl: Pointer; cRequired: UINT; rgcatidReq: Pointer): HResult; stdcall;
    function EnumImplCategoriesOfClass(var rclsid: TGUID; out ppenumCatid: IEnumGUID): HResult; stdcall;
    function EnumReqCategoriesOfClass(var rclsid: TGUID; out ppenumCatid: IEnumGUID): HResult; stdcall;
  end;
{$ENDIF}

Function DCDeleteRegKey( ABaseKey : HKey; Const AKeyPath, ADeletingKey : String ) : Boolean;
Var
  I                             : Integer;
  Len                           : DWORD;
  SubKeyNumber, MaxSubKeyLength : Integer;
  DeleteKey                     : HKey;
  NewKeyPath, SubKeyName        : String;
begin
  Result := False;
  NewKeyPath := AddSlash( AKeyPath ) + ADeletingKey;
  If NewKeyPath[1] = '\' Then
    Delete( NewKeyPath, 1, 1 );
  If RegOpenKeyEx( ABaseKey, PChar( NewKeyPath ), 0, KEY_ALL_ACCESS, DeleteKey ) = ERROR_SUCCESS Then
  try
    If RegQueryInfoKey( DeleteKey, Nil, Nil, Nil, @SubKeyNumber, @MaxSubKeyLength, Nil, Nil, Nil, Nil, Nil, Nil ) <> ERROR_SUCCESS Then
      Exit;
    Inc( MaxSubKeyLength );

    SetLength( SubKeyName, MaxSubKeyLength );
    For I := 0 To SubKeyNumber - 1 Do
    begin
      Len := MaxSubKeyLength;
      If RegEnumKeyEx( DeleteKey, I, PChar( SubKeyName ), Len, Nil, Nil, Nil, Nil ) = ERROR_SUCCESS Then
        DCDeleteRegKey( ABaseKey, NewKeyPath, PChar( SubKeyName ) );
    end;
  finally
    RegCloseKey( DeleteKey );
  end;
  Result := RegDeleteKey( HKEY_CURRENT_USER, PChar( NewKeyPath ) ) In [ ERROR_SUCCESS, 2 ];
end;

{------------------------------------------------------------------}

Const
  sDCDefaultImageWidth = 24;
  sDCDefaultImageHeight = 24;
  sDCScrollButtonWidth = 12;
  sDCButtonSpace = 1;
  sDCBtnWidth = sDCDefaultImageWidth + 2 + sDCButtonSpace * 2;
  sDCBtnHeight = sDCDefaultImageHeight + 2 + sDCButtonSpace * 2;

  ab_ArrowBtn       = -1;
  ab_LeftScrollBtn  = -2;
  ab_RightScrollBtn = -3;
  ab_NoneBtn        = -4;

  sDCPaletteRegKeyPrefix    = 'Palette'; //don't resource
  sDCHiddenControlsRegValue = '.Hidden'; //don't resource
  sDCRegValueDataType       = REG_SZ;
  sDCPermSelColor           = TColor( $FF8080 );

  SKnownActiveXs = 'KnownActiveXs'; // don't resource

  sDCPaletteSection = 'Palette'; // don't resource // by Volkoff
  cDCPalleteSaveBufSize = 16384;

{------------------------------------------------------------------}

Function PackStringList( AStrings : TStrings; ADivider : Char ) : String;
Var
  I : Integer;
begin
  Result := '';
  For I := 0 To AStrings.Count - 1 Do
    Result := Result + AStrings[ I ] + ADivider;
  SetLength( Result, Length( Result ) - 1 );
end;

{------------------------------------------------------------------}

Var
  FActiveXProvider : TActiveXProvider;

{------------------------------------------------------------------}

{ TDCPaletteButton }

procedure TDCPaletteButton.Assign( ASource : TPersistent );
begin
  If Not ( ASource Is TDCPaletteButton ) Then
    Inherited;
  With TDCPaletteButton( ASource ) Do
    Self.FImageIndex := FImageIndex;
end;

{------------------------------------------------------------------}

Function TDCPaletteButton.ButtonName: String;
begin
  Result := '';
end;

{------------------------------------------------------------------}

Constructor TDCPaletteButton.Create( AOwner : TDCSinglePaletterBar );
begin
  Inherited Create;
  FOwner := AOwner;
  FImageIndex := -1;

  If AOwner <> Nil Then
    AOwner.AddButtonToCollection( Self );
end;

{------------------------------------------------------------------}

Destructor TDCPaletteButton.Destroy;
begin
  If ImageIndex >= 0 Then
    FOwner.DeleteImage( ImageIndex );  
  Inherited;
end;

{------------------------------------------------------------------}

Procedure TDCPaletteButton.DrawBtn( ACanvas : TCanvas; X, Y : Integer;
                                    AMouseOver, ASelected : Boolean );
Var
  ImageRect  : TRect;
  OuterRect  : TRect;
  ImageList  : TImageList;
  Save       : TColor;
begin
  ImageList := FOwner.GetImageList;
  With ACanvas Do
  begin
    OuterRect := Rect( X, Y, X + sDCBtnWidth, Y + sDCBtnWidth );
    ImageRect := OuterRect;
    InflateRect( ImageRect, -sDCButtonSpace - 1, -sDCButtonSpace - 1 );
    If AMouseOver Or ASelected Then
    begin
      If ASelected And FOwner.PermanentSelection Then
      begin
        Save := ACanvas.Pen.Color;
        ACanvas.Pen.Color := sDCPermSelColor;
        DCDrawEmptyRect( ACanvas, OuterRect );
        ACanvas.Pen.Color := Save;
      end
      Else
        DCDrawEdge( Handle, OuterRect, AMouseOver And ( Not ASelected ) )
    end
    Else
      DCDrawEmptyRect( ACanvas, OuterRect );
    InflateRect( OuterRect, -1, -1 );
    FillRectEx( ACanvas, OuterRect, ImageRect );
    If Not ImageInitilized Then
      InitImage;
    If AMouseOver Or ( Not ASelected ) Then
      ImageList.Draw( ACanvas, ImageRect.Left, ImageRect.Top, FImageIndex{$IFDEF D4}, True{$ENDIF} )
    Else
      DCDrawImageWithBackground( ACanvas, ImageList, FImageIndex, 1, ImageRect.Left, ImageRect.Top );
  end;
end;

{------------------------------------------------------------------}

Function TDCPaletteButton.GetComponentHint : String;
begin
  Result := '';
end;

{------------------------------------------------------------------}

Function TDCPaletteButton.ImageInitilized : Boolean;
begin
  Result := True;
end;

{------------------------------------------------------------------}

Procedure TDCPaletteButton.InitImage;
begin
end;

{------------------------------------------------------------------}

{ TDCSinglePaletterBar }

Function TDCSinglePaletterBar.AddActiveX( AGUID, ATypeLib : TGUID; Const AHint : String;
  APicModule : THandle; APicIndex : Integer ) : TDCPaletteButton;
begin
  Result := TDCActiveXButton.Create( Self );
  TDCActiveXButton( Result ).InitButton( AGUID, ATypeLib, AHint, APicModule, APicIndex );
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.AddButtonToCollection( AButton : TDCPaletteButton );
begin
  FButtons.Add( AButton );
end;

{------------------------------------------------------------------}

Function TDCSinglePaletterBar.AddComponent( AComponentClass : TComponentClass;
  APackageID : THandle ) : TDCPaletteButton;
Var
  Index : Integer;
begin
  Index := FindElement( AComponentClass.ClassName );
  If Index < 0 Then
    Result := TDCCompButton.Create( Self )
  Else
    Result := Buttons[ Index ];
  TDCCompButton( Result ).InitButton( AComponentClass, APackageID );
end;

{------------------------------------------------------------------}

Function TDCSinglePaletterBar.CanShowHint : Boolean;
begin
  Result := TDCCustomComponentPalette( Parent ).ShowHint;
end;

{------------------------------------------------------------------}

Procedure TDCSinglePaletterBar.CheckTopButtonValue( Var AValue : Integer );
Var
  VisCount : Integer;
begin
  VisCount := GetVisibleCount;
  If AValue > ButtonCount - VisCount Then
    AValue := ButtonCount - VisCount;
  If AValue < 0 Then
    AValue := 0;
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.Clear;
Var
  I : Integer;
begin
  FClearing := True;
  try
    For I := 0 To FButtons.Count - 1 Do
      TDCPaletteButton( Buttons[ I ] ).Free;
    FButtons.Count := 0;
  finally
    FClearing := False;
  end;
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.CMMouseLeave( Var Message : TMessage );
begin
  Inherited;
  If ( Parent <> Nil ) And ( csDesigning In Parent.ComponentState ) Then
    Exit;
  FLastActive := ab_NoneBtn;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.CMVisibleChanged( Var Message : TMessage );
begin
  Inherited;
  If Not Visible Then
    ResetSelection;
end;

{------------------------------------------------------------------}

Constructor TDCSinglePaletterBar.Create( AOwner : TComponent );
begin
  Inherited;
  FButtons := TList.Create;
  FArrowBtn := TDCPaletteButton.Create( Nil );
  FArrowBtn.FOwner := Self;
  FArrowBtn.FImageIndex := 0;
  FSelectedItem := ab_ArrowBtn;
  FLastActive := ab_NoneBtn;
  FScrollBtnDown := ab_NoneBtn;

  ShowHint := True;
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.DeleteButton( AIndex : Integer );
begin
  Buttons[ AIndex ].Free;
  FButtons.Delete( AIndex );
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.DeleteImage( AImageIndex : Integer );
begin
  TDCCustomComponentPalette( Parent ).DeleteImage( AImageIndex );
end;

{------------------------------------------------------------------}

Destructor TDCSinglePaletterBar.Destroy;
begin
  Clear;
  FreeObject( FArrowBtn ,FArrowBtn );
  FreeObject( FButtons , FButtons );
  Inherited;
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.DrawArrowBtn;
Var
  BtnRect : TRect;
begin
  BtnRect := Rect( 0, 0, sDCBtnWidth, sDCBtnWidth );
  DrawButton( FArrowBtn, 0, 0, PtInRect( BtnRect, GetMouseCoord ), FSelectedItem = ab_ArrowBtn );
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.DrawButton( ABtn : TDCPaletteButton; X, Y: Integer;
  AMouseOver, ASelected : Boolean );
begin
  ABtn.DrawBtn( Canvas, X, Y, AMouseOver And ( FScrollBtnDown = ab_NoneBtn ) And
                Not ( ( Parent <> Nil ) And ( csDesigning In Parent.ComponentState ) ),
                ASelected );
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.DrawScrollArrow( ABtnType : Integer );
Var
  BtnRaised, HideBtn : Boolean;
  AMouseOver         : Boolean;
  BtnRect            : TRect;
begin
  If ABtnType = ab_LeftScrollBtn Then
  begin
    BtnRect := Rect( sDCBtnWidth, 0, sDCBtnWidth + sDCScrollButtonWidth, sDCBtnHeight );
    HideBtn := TopButton = 0;
  end
  Else
    If ABtnType = ab_RightScrollBtn Then
    begin
      BtnRect := Rect( ClientWidth - sDCScrollButtonWidth, 0, ClientWidth, sDCBtnHeight );
      HideBtn := ( TopButton + ( ClientWidth - sDCScrollButtonWidth Shl 1 ) Div sDCBtnWidth ) > ButtonCount;
    end
    Else
      Exit;

  If HideBtn Then
  begin
    Canvas.FillRect( BtnRect );
    Exit;
  end;

  AMouseOver := PtInRect( BtnRect, GetMouseCoord );
  BtnRaised := ( AMouseOver And ( FScrollBtnDown = ab_NoneBtn ) ) Or
               ( Not AMouseOver And ( FScrollBtnDown = ABtnType ) );
  AMouseOver := ( FScrollBtnDown = ABtnType ) Or
                ( AMouseOver And ( FScrollBtnDown = ab_NoneBtn ) );

  If AMouseOver And  Not ( ( Parent <> Nil ) And ( csDesigning In Parent.ComponentState ) ) Then
    DCDrawEdge( Canvas.Handle, BtnRect, BtnRaised )
  Else
    DCDrawEmptyRect( Canvas, BtnRect );

  DCDrawArrow( Canvas, ABtnType = ab_LeftScrollBtn, BtnRect, True );
end;

{------------------------------------------------------------------}

Function TDCSinglePaletterBar.FindElement( Const AElementName : String ) : Integer;
begin
  Result := FindElementEx( 0, AElementName ); 
end;

{------------------------------------------------------------------}

Function TDCSinglePaletterBar.FindElementEx( AStartPos : Integer;
  Const AElementName : String ) : Integer;
Var
  I : Integer;
begin
  For I := AStartPos To FButtons.Count - 1 Do
    If Buttons[ I ].ButtonName = AElementName Then
    begin
      Result := I;
      Exit;
    end;
  Result := -1;
end;

Function TDCSinglePaletterBar.GetButtonAt( X, Y : Integer ) : Integer;
Var
  Coord : TPoint;
begin
  Result := ab_ArrowBtn;
  Coord.X := X;
  Coord.Y := Y;
  If PtInRect( Rect( 0, 0, sDCBtnWidth, sDCBtnHeight ), Coord ) Then
    Exit;
  If PtInRect( Rect( sDCBtnWidth, 0, ClientWidth, sDCBtnHeight ), Coord ) Then
  begin
    If X >= ClientWidth - sDCScrollButtonWidth Then
    begin
      Result := ab_RightScrollBtn;
      Exit;
    end;
    X := X - sDCScrollButtonWidth - sDCBtnWidth;
    If X < 0 Then
    begin
      Result := ab_LeftScrollBtn;
      Exit;
    end;
    Result := TopButton + X Div sDCBtnWidth;
    If ( Result >= ButtonCount ) Or ( Result - TopButton >= GetVisibleCount ) Then
      Result := ab_NoneBtn;
  end
  Else
    Result := ab_NoneBtn;
end;

{------------------------------------------------------------------}

Function TDCSinglePaletterBar.GetButtonCount : Integer;
begin
  Result := FButtons.Count;
end;

{------------------------------------------------------------------}

Function TDCSinglePaletterBar.GetButtons( AIndex : Integer ) : TDCPaletteButton;
begin
  Result := TDCPaletteButton( FButtons[ AIndex ] )
end;

{------------------------------------------------------------------}

Function TDCSinglePaletterBar.GetImageList : TImageList;
begin
  Result := TDCCustomComponentPalette( Parent ).FImageList;
end;

{------------------------------------------------------------------}

Function TDCSinglePaletterBar.GetMouseCoord: TPoint;
begin
  GetCursorPos( Result );
  Result := ScreenToClient( Result );
end;

{------------------------------------------------------------------}

Function TDCSinglePaletterBar.GetSelectedComponent : String;
begin
  Result := '';
  If SelectedItem >= 0 Then
    Result := Buttons[ SelectedItem ].ButtonName;
end;

{------------------------------------------------------------------}

Function TDCSinglePaletterBar.GetVisibleCount : Integer;
begin
  Result := ( ClientWidth - sDCBtnWidth - sDCScrollButtonWidth Shl 1 ) Div sDCBtnWidth;
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.InitTimer( AScrollBar : Integer );
begin
  If FScrollTimer = 0 Then
    FScrollTimer := SetTimer( Handle, 1, 150, Nil );
  FScrollBtnDown := AScrollBar;
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.InvalidateButton( AIndex : Integer );
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure __DrawButton( ABtn : Integer );
  Var
    HintPos : TPoint;
    palette : TDCCustomComponentPalette;
    ahint   : string;
  begin
    ABtn := ABtn - TopButton;
    If ( ABtn < 0 ) Or
       ( ABtn >= ButtonCount ) Or
       ( sDCScrollButtonWidth Shl 1 + sDCBtnWidth * ( ABtn + 2 ) > ClientWidth ) Then
      Exit;
    ABtn := ABtn + TopButton;
    HintPos.X := sDCScrollButtonWidth + sDCBtnWidth * ( ABtn + 1 - TopButton );
    HintPos.Y := sDCBtnHeight Shr 1;
    DrawButton( Buttons[ ABtn ], HintPos.X,
                0, AIndex = ABtn, SelectedItem = ABtn );
    If CanShowHint Then
    begin
      ahint := Buttons[ ABtn ].GetComponentHint;

      palette := TDCCustomComponentPalette(Owner);
      if Assigned(palette.OnGetButtonHint) then
          palette.OnGetButtonHint(palette, ahint);

      Hint := ahint;
      HintPos := ClientToScreen( HintPos );
    {$IFDEF D5}
      Application.ActivateHint( HintPos );
    {$ELSE}
      Application.ShowHint := True;
    {$ENDIF}
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _RedrawButton( ABtn : Integer );
  begin
    Case ABtn Of
      ab_NoneBtn        :;
      ab_ArrowBtn       : DrawArrowBtn;
      ab_LeftScrollBtn,
      ab_RightScrollBtn : DrawScrollArrow( ABtn );
      Else
        __DrawButton( ABtn );
    End;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  If FLastActive < 0 Then
    Application.HideHint;
  If FLastActive = AIndex Then
    Exit;
  _RedrawButton( FLastActive );
  Application.HideHint;
  _RedrawButton( AIndex );
  FLastActive := AIndex;
end;

{------------------------------------------------------------------}

Procedure TDCSinglePaletterBar.KillTimer;
Var
  Save : Integer;
begin
  If FScrollTimer <> 0 Then
  begin
    Windows.KillTimer( Handle, FScrollTimer );
    FScrollTimer := 0;
    Save := FScrollBtnDown;
    FScrollBtnDown := ab_NoneBtn;
    DrawScrollArrow( Save );
  end;
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.MouseMove( Shift : TShiftState; X, Y : Integer );
begin
  Inherited;
  If ( Parent <> Nil ) And ( csDesigning In Parent.ComponentState ) Then
    Exit;
  InvalidateButton( GetButtonAt( X, Y ) );
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If ( Parent <> Nil ) And ( csDesigning In Parent.ComponentState ) Then
  begin
    Inherited;
    Exit;
  end;
  If FScrollBtnDown <> ab_NoneBtn Then
    KillTimer
  Else
    Inherited;
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.Paint;
Var
  MouseCoord : TPoint;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _DrawButtons;
  Var
    OverButtons            : Boolean;
    I, BtnLeft, RightRange : Integer;
  begin
    BtnLeft := sDCBtnWidth + sDCScrollButtonWidth;
    RightRange := ClientWidth - BtnLeft;
    OverButtons := ( 0 <= MouseCoord.Y ) And ( MouseCoord.Y <= sDCBtnHeight );

    For I := TopButton To ButtonCount - 1 Do
    begin
      If BtnLeft > RightRange Then
        break;
      If Buttons[ I ].ImageInitilized Then
        DrawButton( Buttons[ I ], BtnLeft, 0,
                    OverButtons And ( BtnLeft <= MouseCoord.X ) And ( MouseCoord.X < BtnLeft + sDCBtnWidth ),
                    FSelectedItem = I )
      Else
        Canvas.FillRect( Rect( BtnLeft, 0, BtnLeft + sDCBtnWidth, sDCBtnWidth ) );
      BtnLeft := BtnLeft + sDCBtnWidth;
    end;

    Canvas.FillRect( Rect( BtnLeft, 0, ClientWidth - sDCScrollButtonWidth, sDCBtnHeight ) );

    BtnLeft := sDCBtnWidth + sDCScrollButtonWidth;
    For I := TopButton To ButtonCount - 1 Do
    begin
      If BtnLeft > RightRange Then
        break;
      If Not Buttons[ I ].ImageInitilized Then
        DrawButton( Buttons[ I ], BtnLeft, 0,
                    OverButtons And ( BtnLeft <= MouseCoord.X ) And ( MouseCoord.X < BtnLeft + sDCBtnWidth ),
                    FSelectedItem = I );
      BtnLeft := BtnLeft + sDCBtnWidth;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  GetCursorPos( MouseCoord );
  MouseCoord := ScreenToClient( MouseCoord );
  Canvas.Brush.Color := TDCCustomComponentPalette( Parent ).Color;
  Canvas.Pen.Color := TDCCustomComponentPalette( Parent ).Color;

  DrawArrowBtn;
  Canvas.FillRect( Rect( 0, sDCBtnHeight, ClientWidth, ClientHeight ) );
  DrawScrollArrow( ab_LeftScrollBtn );
  DrawScrollArrow( ab_RightScrollBtn );
  _DrawButtons;
end;

{------------------------------------------------------------------}

Procedure TDCSinglePaletterBar.ResetBarOrder( APageInfo : TDCStoredPageInfo );
Var
  I, CurPos, OldPos : Integer;
begin
  CurPos := 0;
  For I := 0 To APageInfo.Count - 1 Do
  begin
    OldPos := FindElementEx( CurPos, APageInfo.Components[ I ] );
    If OldPos < 0 Then
      continue;
    If OldPos <> CurPos Then
      FButtons.Move( OldPos, CurPos );
    Inc( CurPos );
  end;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.ResetSelection;
begin
  SelectedItem := ab_ArrowBtn;
end;

{------------------------------------------------------------------}

Procedure TDCSinglePaletterBar.SetButtons( AIndex : Integer; Const AValue : TDCPaletteButton );
begin
  If AValue = FButtons[ AIndex ] Then
    Exit;
  TDCPaletteButton( FButtons[ AIndex ] ).Assign( AValue );
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.SetPermanentSelection( Value : Boolean );
begin
  If FPermanentSelection = Value Then
    Exit;
  FPermanentSelection := Value;
  Invalidate;
  BroadCastToNotifiers( Self, CM_PALETTECLICK, Integer( DesignerInsertClass ), Byte( PermanentSelection ) );
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.SetSelectedComponent( Const AValue : String );
Var
  I : Integer;
begin
  SelectedItem := ab_ArrowBtn;
  For I := 0 To ButtonCount - 1 Do
    If Buttons[ I ].ButtonName = AValue Then
    begin
      SelectedItem := I;
      break;
    end;
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.SetSelectedItem( AValue : Integer );
begin
  If FSelectedItem = AValue Then
    Exit;
  FSelectedItem := AValue;

  If AValue >= 0 Then
    DesignerInsertClass := SelectedComponent
  Else
  begin
    DesignerInsertClass := '';
    FPermanentSelection := False;
  end;

  Repaint;
  BroadCastToNotifiers( Self, CM_PALETTECLICK, Integer( DesignerInsertClass ), Byte( PermanentSelection ) );
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.SetTopButton( Value : Integer );
begin
  CheckTopButtonValue( Value );
  If FTopButton = Value Then
    Exit;
  FTopButton := Value;
  If Visible Then
    Invalidate;
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.WMEraseBkgnd( Var Msg : TWMEraseBkgnd );
begin
  Msg.Result := 1;
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.WMLButtonDblClk( Var Message : TWMLButtonDblClk );
Var
  ComponentClass : String;
  ShiftState     : TShiftState;
begin
  Inherited;
  Case GetButtonAt( Message.XPos, Message.YPos ) Of
    ab_LeftScrollBtn :
        begin
          TopButton := TopButton - 1;
          InitTimer( ab_LeftScrollBtn );
          Exit;
        end;
    ab_RightScrollBtn :
        begin
          TopButton := TopButton + 1;
          InitTimer( ab_RightScrollBtn );
          Exit;
        end;
  End;

  ComponentClass := SelectedComponent;
  DesignerInsertClass := ComponentClass;
  ShiftState := [ssDouble];
  BroadCastToNotifiers( Self, CM_PALETTECLICK, Integer( ComponentClass ), Byte( ShiftState ) );
  DesignerInsertClass := '';
  ResetSelection;
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.WMLButtonDown( Var Message : TWMLButtonDown );
Var
  CurrentBtn : Integer;
begin
  Inherited;
  If ( Parent <> Nil ) And ( csDesigning In Parent.ComponentState ) Then
    Exit;
  CurrentBtn := GetButtonAt( Message.XPos, Message.YPos );
  Case CurrentBtn Of
    ab_NoneBtn :;
    ab_LeftScrollBtn :
        begin
          TopButton := TopButton - 1;
          InitTimer( ab_LeftScrollBtn );
        end;
    ab_RightScrollBtn :
        begin
          TopButton := TopButton + 1;
          InitTimer( ab_RightScrollBtn );
        end;
    Else
        begin
          FPermanentSelection := MK_SHIFT And Message.Keys <> 0;
          SelectedItem := CurrentBtn;
        end;
  End;
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.WMSize( Var Message : TWMSize );
begin
  CheckTopButtonValue( FTopButton );
end;

{------------------------------------------------------------------}

procedure TDCSinglePaletterBar.WMTimer( Var Message : TWMTimer );
Var
  OldTop : Integer;
begin
  If Message.TimerID <> 1 Then
  begin
    Inherited;
    Exit;
  end;
  If FScrollBtnDown = ab_NoneBtn Then
    KillTimer
  Else
    If FScrollBtnDown = FLastActive Then
    begin
      OldTop := TopButton;
      If FScrollBtnDown = ab_LeftScrollBtn Then
        TopButton := TopButton - 1
      Else
        TopButton := TopButton + 1;
      If OldTop = TopButton Then
        KillTimer;
    end;
end;

{------------------------------------------------------------------}

{ TDCCustomComponentPalette }

Function TDCCustomComponentPalette.AddNewPage( Const APageName : String ) : TDCSinglePaletterBar;
Var
  Index : Integer;
begin
  Tabs.Add( APageName );
  Index := FPages.Add( TDCSinglePaletterBar.Create( Self ) );
  Result := ButtonTabs[ Index ];
  Result.Parent := Self;
  Result.Align := alClient;
  Result.Visible := Index = TabIndex;
  If Tabs.Count = 1 Then
    AdjustSize;
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.AdjustPaletteSize( Var AWidth, AHeight : Integer );
begin
  If Not AutoSize Or ( ccsRefreshing In PaletteState ) Then
    Exit;
  AHeight := DisplayRect.Top + Height - DisplayRect.Bottom + sDCBtnWidth + 2; 
end;

{------------------------------------------------------------------}

{Procedure TDCCustomComponentPalette.CMPACKAGEUNLOADED( Var Msg : TMessage );
begin
  RefreshData;
end;

{------------------------------------------------------------------}

{Procedure TDCCustomComponentPalette.CMREGISTERCOMPS( Var Msg : TMessage );
begin
  RefreshData;
end;}

{------------------------------------------------------------------}

procedure TDCCustomComponentPalette.CMRefreshPalette( Var Msg : TMessage );
begin
  If FPaletteStorage.IsClear Then
    ApplyPagesOnStorage;
  RefreshData;
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.SelectMouseButton;
begin
  ResetSelection;
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.LoadGlobalOptions;
begin
//!!!!!
//  with GlobalPaletteOptions do
//    self.PredefinedPages :=  PageItems;
end;

{------------------------------------------------------------------}

procedure TDCCustomComponentPalette.Change;
Var
  I : Integer;
begin
  ButtonTabs[ TabIndex ].Visible := True;
  For I := 0 To PageCount - 1 Do
    ButtonTabs[ I ].Visible := I = TabIndex;
  Inherited;
end;

{------------------------------------------------------------------}

procedure TDCCustomComponentPalette.Clear;
Var
  I : Integer;
begin
  Include( FPaletteState, ccsClearing );
  try
    FImageList.AllocBy := 2;
    For I := 0 To PageCount - 1 Do
      ButtonTabs[ I ].Free;
    FPages.Clear;
    If Parent <> Nil Then
      Tabs.Clear;
    If Not ( ccsRefreshing In FPaletteState ) Then
      AdjustSize;
  finally
    Exclude( FPaletteState, ccsClearing );
  end;
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.CMObjectChanged( Var Msg : TMessage );
begin
  Change;
end;

{------------------------------------------------------------------}

procedure TDCCustomComponentPalette.CMObjInsert( Var Msg : TMessage );
begin
  If ( PageCount <> 0 ) And ( TabIndex >= 0 ) And
     ButtonTabs[ TabIndex ].PermanentSelection Then
    Exit;
  ResetSelection;
end;

{------------------------------------------------------------------}

procedure TDCCustomComponentPalette.CMRegisterActiveX( Var Msg : TMessage );
Var
  LibGUID    : TGUID;
  HandleList : TStrings;
  I, J       : Integer;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure _AddActiveX( Const AItemGUID : TGUID );
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
    RegisterActiveX( AItemGUID, LibGUID, DCGetActiveXHint( AItemGUID ), H, PictIndex );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  If csDesigning In ComponentState Then
    Exit;

  LibGUID := pGUID( Msg.wParam )^;

  HandleList := CreateSortedStringList;
  try
    With DCGetActiveXProvider Do
      For I := 0 To Count - 1 Do
        With TypeLibraries[ I ] Do
{$IFDEF BCB}
          If IsEqualGUID( StringToGUID( GUID ), LibGUID ) Then
{$ELSE}
          If IsEqualGUID( GUID, LibGUID ) Then
{$ENDIF}
          begin
            For J := 0 To Count - 1 Do
{$IFDEF BCB}
              _AddActiveX( StringToGUID( ActiveX[ J ] ) );
{$ELSE}
              _AddActiveX( ActiveX[ J ] );
{$ENDIF}
            break;
          end;
  finally
    For I := 0 To HandleList.Count - 1 Do
      FreeLibrary( Integer( HandleList.Objects[ I ] ) );
    FreeObject( HandleList ,HandleList );
  end;
end;

{------------------------------------------------------------------}

procedure TDCCustomComponentPalette.CMShowHintChanged( Var Msg : TMessage );
Var
  I : Integer;
begin
  Inherited;
  For I := 0 To PageCount - 1 Do
    ButtonTabs[ I ].Hint := '';
end;

{------------------------------------------------------------------}

procedure TDCCustomComponentPalette.CMUnregisterActiveX( Var Msg : TMessage );
begin
  UnregisterActiveX( pGUID( Msg.wParam )^ );
end;

{------------------------------------------------------------------}

Constructor TDCCustomComponentPalette.Create( AOwner : TComponent );
Var
  _Temp : TBitmap;
begin
  Inherited;
  FRegistryKey := sDCPaletteRegKeyPrefix;
  FShowActiveX := True;
  FPaletteStorage := TDCPaletteStorage.Create( Self );

  FPredefinedPages := TStringList.Create;
  TStringList( FPredefinedPages ).OnChange := PagesOnChange;

  FMouseGlyph := TBitmap.Create;

  FPages := TList.Create;
  FImageList := TImageList.CreateSize( sDCDefaultImageWidth, sDCDefaultImageHeight );
  FImageList.BkColor := clBtnFace;

  _Temp := TBitmap.Create;
  try
    CreateBrushPattern( FMouseGlyph );
    _Temp.Width := sDCDefaultImageWidth;
    _Temp.Height := sDCDefaultImageHeight;
    _Temp.Canvas.Brush.Bitmap := FMouseGlyph;
    _Temp.Canvas.FillRect( Rect( 0, 0, sDCDefaultImageWidth, sDCDefaultImageHeight ) );

    LoadBitmapFromResource( FMouseGlyph, 'PAL_MOUSEGLYPH' ); //don't resource

    DCAddImageInList( FImageList, FMouseGlyph );
    DCAddImageInList( FImageList, _Temp );
  finally
    FreeObject( _Temp ,_Temp );
  end;

  FMouseGlyph.OnChange := MouseGlyphChanged;
  
  RegisterNotifier( Self );

  ShowHint := True;
  FAutoSize := True;
end;

{------------------------------------------------------------------}

Function TDCCustomComponentPalette.CreateNewPage( Const APageName : String ) : TDCSinglePaletterBar;
begin
  Result := GetBarByName( APageName );
  If Result = Nil Then
    Result := AddNewPage( APageName );
end;

{------------------------------------------------------------------}

Destructor TDCCustomComponentPalette.Destroy;
begin
  UnregisterNotifier( Self );
  Clear;
  FreeObject( FPages ,FPages );
  FreeObject( FImageList,FImageList );
  FreeObject( FPredefinedPages,FPredefinedPages );
  FreeObject( FMouseGlyph,FMouseGlyph );
  Inherited;
end;

{------------------------------------------------------------------}

Function TDCCustomComponentPalette.GetBarByName( Const APageName : String ) : TDCSinglePaletterBar;
Var
  Index : Integer;
begin
  Result := Nil;
  Index := Tabs.IndexOf( APageName );
  If Index < 0 Then
    Exit;
  Result := ButtonTabs[ Index ];
end;

{------------------------------------------------------------------}

Function TDCCustomComponentPalette.GetButtonTabs( AIndex : Integer ) : TDCSinglePaletterBar;
begin
  Result := TDCSinglePaletterBar( FPages[ AIndex ] );
end;

{------------------------------------------------------------------}

Function TDCCustomComponentPalette.GetSelectedComponent : String;
begin
  Result := '';
  If ( PageCount = 0 ) Or ( TabIndex < 0 ) Then
    Exit;
  Result := ButtonTabs[ TabIndex ].SelectedComponent;
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.RefreshData;
Var
  I, J       : Integer;
  HandleList : TStrings;
  NewPage    : TDCSinglePaletterBar;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure _AddActiveX( Const APageName, AActiveXGUID : String );
  Var
    ItemGUID, TypeLib : TGUID;
    PictIndex         : Integer;
    PictName          : String;
    Idx               : Integer;
    H                 : THandle;
  begin
    If Not ShowActiveX Then
      Exit;
    If Not DCIsActiveXRegisteres( AActiveXGUID ) Then
      Exit;
    ItemGUID := StringToGUID( AActiveXGUID );
    TypeLib := DCGetTypeLibraryGUID( ItemGUID );
    If DCGetActiveXProvider.GetRegisteredLibs.IndexOf( GUIDToString( TypeLib ) ) < 0 Then
      Exit;
    DCGetActiveXPictureInfo( ItemGUID, PictIndex, PictName );
    Idx := HandleList.IndexOf( PictName );
    If Idx < 0 Then
    begin
      H := LoadLibrary( PChar( PictName ) );
      If H <> 0 Then
        HandleList.AddObject( PictName, Pointer( H ) );
    end
    Else
      H := THandle( HandleList.Objects[ Idx ] );
    If NewPage = Nil Then
      NewPage := AddNewPage( APageName );
    NewPage.AddActiveX( ItemGUID, TypeLib, DCGetActiveXHint( ItemGUID ), H, PictIndex );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _AddComponent( Const APageName, ACompName : String );
  Var
    ComponentClass : TPersistentClass;
    PackageID      : THandle;
  begin
    ComponentClass := GetClass( ACompName );
    If ComponentClass = Nil Then
      Exit;
    PackageID := 0;
    If NewPage = Nil Then
      NewPage := AddNewPage( APageName );
    NewPage.AddComponent( TComponentClass( ComponentClass ), PackageID );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  If ( ccsRefreshing In FPaletteState ) Or ( csDesigning In ComponentState ) Then
    Exit;

  Include( FPaletteState, ccsRefreshing );
  try
    HandleList := CreateSortedStringList;
    try
      Clear;
      For I := 0 To FPaletteStorage.Count - 1 Do
        With FPaletteStorage.Pages[ I ] Do
          If Count > 0 Then
          begin
            NewPage := Nil;
            For J := 0 To Count - 1 Do
              If Components[ J ][ 1 ] = '{' Then
                _AddActiveX( PageName, Components[ J ] )
              Else
                _AddComponent( PageName, Components[ J ] );
          end;
    finally
      For I := 0 To HandleList.Count - 1 Do
        FreeLibrary( Integer( HandleList.Objects[ I ] ) );
      FreeObject( HandleList ,HandleList );
    end;
  finally
    Exclude( FPaletteState, ccsRefreshing );
    AdjustSize;
  end;
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.RegisterComp( Const APageName : String;
  AComponentClass : TComponentClass; APackageID : THandle );
Var
  ActiveBar : TDCSinglePaletterBar;
begin
  ActiveBar := CreateNewPage( APageName );
  ActiveBar.AddComponent( AComponentClass, APackageID );
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.ResetSelection;
begin
  If ( PageCount = 0 ) Or ( TabIndex < 0 ) Then
    Exit;
  ButtonTabs[ TabIndex ].ResetSelection;
end;

{------------------------------------------------------------------}

procedure TDCCustomComponentPalette.SetNewTabIndex( ATabIndex : Integer );
begin
  TabIndex := ATabIndex;
  Change;
end;

{------------------------------------------------------------------}

procedure TDCCustomComponentPalette.SetParent( AParent : TWinControl );
begin
  Inherited;
  If AParent <> Nil Then
    RefreshData;
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.SetSelectedComponent( Const AValue : String );
Var
  I : Integer;
begin
  For I := 0 To PageCount - 1 Do
  begin
    ButtonTabs[ I ].SelectedComponent := AValue;
    If ButtonTabs[ I ].SelectedComponent <> '' Then
    begin
      SetNewTabIndex( I );
      Exit;
    end;
  end;
end;

{------------------------------------------------------------------}

Function TDCCustomComponentPalette.PageCount : Integer;
begin
  Result := FPages.Count;
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.RegisterActiveX( AGUID, ATypeLib : TGUID;
  Const AHint: String; APicModule : THandle; APicIndex : Integer );
Var
  PageIndex, CompIndex : Integer;
  PageName             : String;
  ActiveBar            : TDCSinglePaletterBar;
begin
  PageName := FPaletteStorage.QueryComponentPageEx( sDCPalActiveX, GUIDToString( AGUID ),
                                                    PageIndex, CompIndex );
  If PageName = '' Then
    Exit;
  ActiveBar := CreateNewPage( PageName );
  ActiveBar.AddActiveX( AGUID, ATypeLib, AHint, APicModule, APicIndex );
  ActiveBar.ResetBarOrder( FPaletteStorage.Pages[ PageIndex ] );
end;

{------------------------------------------------------------------}

procedure TDCCustomComponentPalette.UnregisterActiveX( AGUID : TGUID );
Var
  I, J : Integer;
begin
  For I := 0 To PageCount - 1 Do
    With ButtonTabs[ I ] Do
    begin
      J := 0;
      While J < ButtonCount Do
        With TDCActiveXButton( Buttons[ J ] ) Do
          If IsEqualGUID( AGUID, FGUID ) Or IsEqualGUID( AGUID, FTypeLib ) Then
            DeleteButton( J )
          Else
            Inc( J );
      If ButtonCount = 0 Then
        DeletePage( I );
    end;
end;

{------------------------------------------------------------------}

procedure TDCCustomComponentPalette.DeletePage( AIndex : Integer );
begin
  ButtonTabs[ AIndex ].Free;
  FPages.Delete( AIndex );
  If TabIndex = AIndex Then
  begin
    TabIndex := 0;
    Change;
  end;
  Tabs.Delete( AIndex );
end;

{------------------------------------------------------------------}

procedure TDCCustomComponentPalette.CMPaletteChanged( Var Msg : TMessage );
begin
  If csDesigning In ComponentState Then
    Exit;

  FPaletteStorage.Initialize;
//  RefreshData;
end;

{------------------------------------------------------------------}

procedure TDCCustomComponentPalette.DeleteImage( AImageIndex : Integer );
Var
  I, J : Integer;
begin
  If ( AImageIndex <= 1 ) Or ( ccsClearing In FPaletteState ) Then
    Exit;
  FImageList.Delete( AImageIndex );
  For I := 0 To PageCount - 1 Do
    With ButtonTabs[ I ] Do
      If Not FClearing Then
        For J := 0 To ButtonCount - 1 Do
          With Buttons[ J ] Do
            If FImageIndex > AImageIndex Then
              Dec( FImageIndex );
end;

{------------------------------------------------------------------

procedure TDCCustomComponentPalette.CMActiveXChanged( Var Msg : TMessage );
begin
  RefreshData;
end;

{------------------------------------------------------------------}

Function TDCCustomComponentPalette.GetPredefinedPages : TStrings;
begin
  Result := FPredefinedPages;
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.SetPredefinedPages( AValue : TStrings );
begin
  FPredefinedPages.Assign( AValue );
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.SetOnlyDefinedItems( AValue : Boolean );
begin
  If FOnlyDefinedItems = AValue Then
    Exit;
  FOnlyDefinedItems := AValue;
  If Not AValue Then
    FPaletteStorage.Initialize
  Else
    RefreshData;
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.SetRegistryKey( Const AValue : String );
begin
  If FRegistryKey = AValue Then
    Exit;
  FRegistryKey := AValue;
  If Not ( csLoading In ComponentState ) Then
  begin
    ValidateRegKey;
    If Not OnlyDefinedItems Then
      RefreshData;
  end;
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.ValidateRegKey;
begin
  If csDesigning In ComponentState Then
    Exit;

  If RegistryKey = '' Then
    FPaletteStorage.SetNewRegKey( Name )
  Else
    FPaletteStorage.SetNewRegKey( RegistryKey );
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.Loaded;
begin
  Inherited;
  AdjustSize;
  ValidateRegKey;
  RefreshData;
  ApplyPagesOnStorage;
end;

{------------------------------------------------------------------}

procedure TDCCustomComponentPalette.SetName( Const AValue : TComponentName );
begin
  Inherited;
  If Not ( csLoading In ComponentState ) Then
  begin
    ValidateRegKey;
    If Not OnlyDefinedItems Then
      RefreshData;
  end;
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.PagesOnChange( Sender : TObject );
begin
  If ( csDesigning In ComponentState ) Or ( csLoading In ComponentState ) Then
    Exit;

  If FPaletteStorage.IsClear Then
  begin
    ApplyPagesOnStorage;
    RefreshData;
  end;
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.ApplyPagesOnStorage;
Var
  I, J, Idx, RealIndex : Integer;
  PageName             : String;
  Comps                : TStringList;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _InitPagesOrder;
  Var
    I, J : Integer;
  begin
    If OnlyDefinedItems Then
      FPaletteStorage.Clear;
    For I := 0 To PredefinedPages.Count - 1 Do
    begin
      PageName := PredefinedPages.Names[ I ];
      If PageName = '' Then
        PageName := PredefinedPages[ I ];

      If OnlyDefinedItems Then
        Comps.Clear;

      J := Comps.Count;
      ParseString( Copy( PredefinedPages[ I ], Length( PageName ) + 2, MaxInt ), ',', Comps );
      With Comps Do
        For J := J To Count - 1 Do
        begin
          Strings[ J ] := Trim( Strings[ J ] );
          Objects[ J ] := Pointer( I );
        end;

      PageName := Trim( PageName );

      If OnlyDefinedItems Then
      begin
        If ( Comps.Count = 0 ) Or ( PageName = '' ) Then
          continue;
        With FPaletteStorage, Pages[ AddNewPage( PageName ) ] Do
          For J := 0 To Comps.Count - 1 Do
            AddComponent( Comps[ J ] );
      end;

      With FPaletteStorage Do
      begin
        Idx := PageByName( PageName );
        If Idx < 0 Then
          InsertPage( I, PageName )
        Else
          If I >= Count Then
            MovePage( Idx, Count - 1 )
          Else
            MovePage( Idx, I );
      end;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  If ( csLoading In ComponentState ) Or ( csDesigning In ComponentState ) Then
    Exit;

  If ( PredefinedPages.Count = 0 ) And OnlyDefinedItems Then
  begin
    FPaletteStorage.Initialize;
    Exit;
  end;

  Comps := TStringList.Create;
  try
    _InitPagesOrder;
    If OnlyDefinedItems Then
      Exit;

    Idx := 0;
    RealIndex := 0;
    With FPaletteStorage Do
    begin
      I := 0;
      While I < Count Do
        With Pages[ I ] Do
        begin
          J := Idx;
          While Idx < Comps.Count Do
            If Integer( Comps.Objects[ Idx ] ) = RealIndex Then
            begin
              If Comps[ Idx ] <> '' Then
                InsertComponent( Idx - J, Comps[ Idx ] );
              Inc( Idx );
            end
            Else
              break;

          J := Idx - J;
          While J < Count Do
            If Comps.IndexOf( Components[ J ] ) >= 0 Then
              DeleteComponent( J )
            Else
              Inc( J );

          If Count = 0 Then
            DeletePage( I )
          Else
            Inc( I );
          Inc( RealIndex );
        end;
    end;
  finally
    Comps.Free;
  end;
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.SetShowActiveX( AValue : Boolean );
begin
  If FShowActiveX = AValue Then
    Exit;
  FShowActiveX := AValue;
  RefreshData;
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.SetMouseGlyph( AValue : TBitmap );
begin
  FMouseGlyph.Assign( AValue );
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.InternalSetAutoSize( AValue : Boolean );
begin
  If FAutoSize = AValue Then
    Exit;
  FAutoSize := AValue;
  AdjustSize;
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.SetUseGlobalOptions( AValue : Boolean );
begin
  If FUseGlobalOptions <> AValue Then
  begin
    FUseGlobalOptions := AValue;
    RefreshData;
  end;
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.MouseGlyphChanged( Sender : TObject );
Var
  Index       : Integer;
  Transformed : TBitmap;
begin
  Transformed := TBitmap.Create;
  try
    Transformed.Assign( FMouseGlyph );
    Index := DCAddImageInList( FImageList, Transformed );
    With FImageList Do
    begin
      Delete( 0 );
      Move( Index - 1, 0 );
    end;
  finally
    Transformed.Free;
  end;
  Invalidate;
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.WMWindowPosChanging( Var Msg : TWMWindowPosChanging );
begin
  Inherited;
  With Msg.WindowPos^ Do
    If Flags And SWP_NOSIZE = 0 Then
      AdjustPaletteSize( CX, CY );
end;

{------------------------------------------------------------------}

procedure TDCCustomComponentPalette.CreateHandle;
begin
  Inherited;
  AdjustSize;
end;

{------------------------------------------------------------------}

Procedure TDCCustomComponentPalette.WMSYSCOLORCHANGE( Var Msg : TMessage );
begin
  Inherited;
// This message should be called when system color scheme is chnaged. But ... it's Windows. 
end;

{------------------------------------------------------------------}

{$IFNDEF D4}
Procedure TDCCustomComponentPalette.AdjustSize;
Var
  NewWidth, NewHeight : Integer;
begin
  If [csLoading, csDestroying] * ComponentState = [] Then
  begin
    NewWidth := Width;
    NewHeight := Height;
    AdjustPaletteSize( NewWidth, NewHeight );
    SetBounds( Left, Top, NewWidth, NewHeight );
  end;
end;
{$ENDIF}

{------------------------------------------------------------------}

{ TDCPaletteStorage }

procedure TDCPaletteStorage.Clear;
Var
  I : Integer;
begin
  For I := 0 To FPages.Count - 1 Do
    TDCStoredPageInfo( FPages[ I ] ).Free;
  FPages.Clear;
  FHiddenControls.Clear;
end;

{------------------------------------------------------------------}

Procedure TDCPaletteStorage.CloseRegKey;
begin
  If FOpenedKey = 0 Then
    Exit;
  RegCloseKey( FOpenedKey );
  FOpenedKey := 0;
end;

{------------------------------------------------------------------}

Constructor TDCPaletteStorage.Create( AOwner : TObject );
begin
  Inherited Create;
  FPages := TList.Create;
  FHiddenControls := CreateSortedStringList;
  FOpenedKey := 0;
  FOwner := AOwner;

  RegisterNotifier( Self );
end;

{------------------------------------------------------------------}

Destructor TDCPaletteStorage.Destroy;
begin
  UnregisterNotifier( Self );

  CloseRegKey;
  Clear;
  FreeObject( FHiddenControls,FHiddenControls );
  FreeObject( FPages,FPages );
  Inherited;
end;

{------------------------------------------------------------------}

Function TDCPaletteStorage.QueryComponentPage( Const AOldPage, AComponentName : String ) : String;
Var
  StoragePageIndex, StorageCompIndex : Integer;
begin
  Result := QueryComponentPageEx( AOldPage, AComponentName, StoragePageIndex, StorageCompIndex );
end;

{------------------------------------------------------------------}

Procedure TDCPaletteStorage.Initialize;
var
  Index, NameMaxLen, ValueMaxLen       : DWORD;
  CurNameLength, CurValueLength, Flags : DWORD;
  NameBuf, ValueBuf                    : String;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _InitBufs;
  begin
    SetLength( NameBuf, NameMaxLen );
    SetLength( ValueBuf, ValueMaxLen );
    CurNameLength := NameMaxLen;
    CurValueLength := ValueMaxLen;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
// by volkoff - opt file support
  Procedure _LoadFromIni;
  Var
    Buffer, P : PChar;
    I         : Integer;
    TmpList   : TStringList;
    PInfo     : TDCStoredPageInfo;
  begin
    TmpList := TStringList.Create;
    GetMem( Buffer, cDCPalleteSaveBufSize );
    try
      If GetPrivateProfileSection( sDCPaletteSection, Buffer, cDCPalleteSaveBufSize, PChar( OptionsFileName ) ) <> 0 Then
      begin
        P := Buffer;
        While P^ <> #0 Do
        begin
          TmpList.Add(P);
          Inc( P, StrLen(P) + 1 );
        end;
      end;
      FNoItems := TmpList.Count > 0;

      I := TmpList.IndexOfName( sDCHiddenControlsRegValue );
      If I <> -1 Then
      begin
        FHiddenControls.CommaText := TmpList.Values[sDCHiddenControlsRegValue];
        TmpList.Delete(I);
      end;

      For I := 0 To TmpList.Count - 1 Do
      begin
        PInfo := TDCStoredPageInfo.Create( TmpList.Names[I], '' );
        PInfo.FComponents.CommaText := TmpList.Values[ TmpList.Names[I] ]; // much faster, isnt it?
        FPages.Add( PInfo );
      end;
    finally
      FreeObject( TmpList ,TmpList );
      FreeMem( Buffer );
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _LoadFromReg;
  begin
    FNoItems := IsClear;
    If Not FNoItems And OpenRegKey( KEY_READ ) Then
      try
        If RegQueryInfoKey( FOpenedKey, Nil, Nil, Nil, Nil, Nil, Nil, Nil, @NameMaxLen,
                            @ValueMaxLen, Nil, Nil ) <> ERROR_SUCCESS Then
          Exit;
        Inc( NameMaxLen );
        Inc( ValueMaxLen );
        _InitBufs;
        Flags := sDCRegValueDataType;
        Index := 0;
        While RegEnumValue( FOpenedKey, Index, PChar( NameBuf ), CurNameLength, Nil, @Flags,
                            Pointer( PChar( ValueBuf ) ), @CurValueLength ) = ERROR_SUCCESS Do
        begin
          SetLength( NameBuf, CurNameLength );
          SetLength( ValueBuf, CurValueLength );
          If NameBuf = sDCHiddenControlsRegValue Then
            ParseString( ValueBuf, ';', FHiddenControls )
          Else
            FPages.Add( TDCStoredPageInfo.Create( NameBuf, ValueBuf ) );
          _InitBufs;
          Inc( Index );
        end;
      finally
        CloseRegKey;
      end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  Clear;

  // By Volkoff
  If StoreOptionsInFile Then
    _LoadFromIni
  Else
    _LoadFromReg;

  LoadDefaultPages;
  LoadDefaultActiveX;

  SentMessageOwner( CM_RefreshPalette, 0, 0 );
end;

{------------------------------------------------------------------}

Function TDCPaletteStorage.IsClear : Boolean;
Var
  ValueNumbers : Integer;
  Buffer       : PChar;
begin
  If StoreOptionsInFile Then
  begin
    GetMem( Buffer, cDCPalleteSaveBufSize );
    try
      Result := GetPrivateProfileSection( sDCPaletteSection, Buffer, cDCPalleteSaveBufSize, PChar( OptionsFileName ) ) <> 0;
    finally
      FreeMem( Buffer );
    end;
    Exit;
  end;

  Result := True;
  If Not OpenRegKey( KEY_QUERY_VALUE ) Then
    Exit;
  try
    If RegQueryInfoKey( FOpenedKey, Nil, Nil, Nil, Nil, Nil, Nil, @ValueNumbers, Nil, Nil, Nil, Nil ) <> ERROR_SUCCESS Then
      Exit;
    Result := ValueNumbers = 0;
  finally
    CloseRegKey;
  end;
end;

{------------------------------------------------------------------}

Function TDCPaletteStorage.OpenRegKey( AMode : REGSAM ) : Boolean;
Var
  RegKey : String;
begin
  CloseRegKey;
  RegKey := GetPalleteRegKey;
  Result := RegOpenKeyEx( HKEY_CURRENT_USER, PChar( RegKey ), 0, AMode, FOpenedKey ) = ERROR_SUCCESS;
end;

{------------------------------------------------------------------}

Procedure TDCPaletteStorage.AddToList( Const APageName, AComponentName : String;
  Var AStoragePageIndex, AStorageCompIndex : Integer );
begin
  AStoragePageIndex := PageByName( APageName );
  If AStoragePageIndex < 0 Then
  begin
    AStoragePageIndex := FPages.Add( TDCStoredPageInfo.Create( APageName, AComponentName ) );
    AStorageCompIndex := 0;
  end
  Else
    AStorageCompIndex := Pages[ AStoragePageIndex ].AddComponent( AComponentName );
end;

{------------------------------------------------------------------}

Function TDCPaletteStorage.PageByName( Const APageName : String ) : Integer;
begin
  For Result := 0 To FPages.Count - 1 Do
    If TDCStoredPageInfo( FPages[ Result ] ).PageName = APageName Then
      Exit;
  Result := -1;
end;

{------------------------------------------------------------------}

Function TDCPaletteStorage.Count : Integer;
begin
  Result := FPages.Count;
end;

{------------------------------------------------------------------}

Function TDCPaletteStorage.GetPages( Index : Integer ) : TDCStoredPageInfo;
begin
  Result := TDCStoredPageInfo( FPages[ Index ] );
end;

{------------------------------------------------------------------}

procedure TDCPaletteStorage.ExchangeItems( ASourceIndex, ADestIndex : Integer );
Var
  Save : Pointer;
begin
  Save := FPages[ ASourceIndex ];
  FPages[ ASourceIndex ] := FPages[ ADestIndex ];
  FPages[ ADestIndex ] := Save;
end;

{------------------------------------------------------------------}

Procedure TDCPaletteStorage.SavePalette;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
// by Volkoff - opt file support
  Procedure _SaveIniSectionLine( Const APageName, APageCommaText : String );
  begin
    WritePrivateProfileString( sDCPaletteSection, PChar(APageName), PChar(APageCommaText), PChar(OptionsFileName) );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _SaveToIni;
  Var
    I : Integer;
  begin
    WritePrivateProfileString( sDCPaletteSection, Nil, Nil, PChar(OptionsFileName) );
    _SaveIniSectionLine( sDCHiddenControlsRegValue, FHiddenControls.CommaText );
    For I := 0 To Count - 1 Do
      With Pages[I] Do
        _SaveIniSectionLine( PageName, FComponents.CommaText );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _ClearAllValues( Const AKeyPath, ADeletingKey : String );
  begin
    If Not DCDeleteRegKey( HKEY_CURRENT_USER, AKeyPath, ADeletingKey ) Then
      raise Exception.Create( sDCCannotSaveToRegistry );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _SavePaletteLine( Const APageName, PaletteSet : String );
  begin
    RegSetValueEx( FOpenedKey, PChar( APageName ), 0, sDCRegValueDataType,
                   PChar( PaletteSet ), Length( PaletteSet ) );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _SaveToReg;
  Var
    I : Integer;
  begin
    CloseRegKey;
   _ClearAllValues( RegistryKey, GetRegKeyName );
    If Not CreateRegKey( KEY_QUERY_VALUE Or KEY_SET_VALUE ) Then
      Exit;
    try
      If HiddenCount > 0 Then
        _SavePaletteLine( sDCHiddenControlsRegValue, PackStringList( FHiddenControls, ';' ) );

      For I := 0 To Count - 1 Do
        With Pages[ I ] Do
          _SavePaletteLine( PageName, GetComponentsSet );
    finally
      CloseRegKey;
    end;
 end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
// By Volkoff
  If StoreOptionsInFile Then
    _SaveToIni
  Else
    _SaveToReg;
end;

{------------------------------------------------------------------}

procedure TDCPaletteStorage.MoveItemTo( ASourceIndex, ADestIndex : Integer );
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure ShiftItemsUp( AStartIndex, AFinishIndex : Integer );
  Var
    I    : Integer;
    Save : Pointer;
  begin
    Save := FPages[ AStartIndex ];
    For I := AStartIndex DownTo AFinishIndex + 1 Do
      FPages[ I ] := FPages[ I - 1 ];
    FPages[ AFinishIndex ] := Save;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure ShiftItemsDown( AStartIndex, AFinishIndex : Integer );
  Var
    I    : Integer;
    Save : Pointer;
  begin
    Save := FPages[ AStartIndex ];
    For I := AStartIndex To AFinishIndex - 1 Do
      FPages[ I ] := FPages[ I + 1 ];
    FPages[ AFinishIndex ] := Save;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  If ADestIndex >= Count Then
    ADestIndex := Count - 1;
  If ADestIndex < 0 Then
    ADestIndex := 0;
  If ASourceIndex = ADestIndex Then
    Exit;
  If ADestIndex > ASourceIndex Then
    ShiftItemsDown( ASourceIndex, ADestIndex )
  Else
    ShiftItemsUp( ASourceIndex, ADestIndex );
end;

{------------------------------------------------------------------}

Function TDCPaletteStorage.AddNewPage( Const APageName : String ) : Integer;
begin
  Result := PageByName( APageName );
  If Result < 0 Then
    Result := FPages.Add( TDCStoredPageInfo.Create( APageName, '' ) );
end;

{------------------------------------------------------------------}

procedure TDCPaletteStorage.DeletePage( AIndex : Integer );
begin
  Pages[ AIndex ].Free;
  FPages.Delete( AIndex );
end;

{------------------------------------------------------------------}

procedure TDCPaletteStorage.ResetPalette;
begin
  Clear;
  FNoItems := True;
  LoadDefaultPages;
end;

{------------------------------------------------------------------}

procedure TDCPaletteStorage.LoadDefaultPages;
Var
  I : Integer;
begin
  With ClassItems Do
    For I := 0 To Count - 1 Do
      With TClassItem( Items[ I ] ) Do
        If ( Categories * [ icNoIcon, icShowinPalette ] = [ icShowInPalette ] ) And
           ClassPtr.InheritsFrom( TComponent ) Then
          QueryComponentPage( PalettePage, TComponentClass( ClassPtr ).ClassName );
end;

{------------------------------------------------------------------}

procedure TDCPaletteStorage.CMPACKAGEUNLOADED( Var Msg : TMessage );
begin
  Inherited;
  Initialize;
end;

{------------------------------------------------------------------}

procedure TDCPaletteStorage.CMREGISTERCOMPS( Var Msg : TMessage );
begin
  Inherited;
  Initialize;
end;

{------------------------------------------------------------------}

Function TDCPaletteStorage.MoveComponent( ASrcPage, AComponentIndex,
  ADestPage : Integer ) : Integer;
begin
  Result := AComponentIndex; 
  If ADestPage = ASrcPage Then
    Exit;
  Result := Pages[ ADestPage ].AddComponent( Pages[ ASrcPage ].Components[ AComponentIndex ] );
  Pages[ ASrcPage ].DeleteComponent( AComponentIndex );
end;

{------------------------------------------------------------------}

Function TDCPaletteStorage.QueryComponentPageEx( Const AOldPage, AComponentName : String;
  Var AStoragePageIndex, AStorageCompIndex : Integer ) : String;
Var
  I : Integer;
begin
  Result := '';
  AStoragePageIndex := -1;

  For I := 0 To HiddenCount - 1 Do
    If FHiddenControls[ I ] = AComponentName Then
    begin
      AStoragePageIndex := I;
      Exit;
    end;

  For I := 0 To FPages.Count - 1 Do
    With TDCStoredPageInfo( FPages[ I ] ) Do
    begin
      AStorageCompIndex := GetComponentOnPage( AComponentName );
      If AStorageCompIndex >= 0 Then
      begin
        Result := PageName;
        AStoragePageIndex := I;
        Exit;
      end;
    end;
  Result := AOldPage;
  AddToList( AOldPage, AComponentName, AStoragePageIndex, AStorageCompIndex );
end;

{------------------------------------------------------------------}

Function TDCPaletteStorage.GetHiddenControls( AIndex : Integer ) : String;
begin
  Result := FHiddenControls[ AIndex ];
end;

{------------------------------------------------------------------}

Function TDCPaletteStorage.HiddenCount: Integer;
begin
  Result := FHiddenControls.Count;
end;

{------------------------------------------------------------------}

Procedure TDCPaletteStorage.SetHiddenControls( AIndex : Integer; Const AValue : String );
begin
  FHiddenControls[ AIndex ] := AValue;
end;

{------------------------------------------------------------------}

Function TDCPaletteStorage.HideComponent( ASrcPage, AComponentIndex : Integer ) : Integer;
begin
  Result := FHiddenControls.Add( Pages[ ASrcPage ].Components[ AComponentIndex ] );
  Pages[ ASrcPage ].DeleteComponent( AComponentIndex );
end;

{------------------------------------------------------------------}

Function TDCPaletteStorage.ShowComponent( AComponentIndex, ADestPage : Integer ) : Integer;
begin
  Result := Pages[ ADestPage ].AddComponent( FHiddenControls[ AComponentIndex ] );
  FHiddenControls.Delete( AComponentIndex );
end;

{------------------------------------------------------------------}

Function TDCPaletteStorage.ShowComponentEx( Const AComponentName : String;
  ADestPage : Integer ) : Integer;
begin
  Result := ShowComponent( FHiddenControls.IndexOf( AComponentName ), ADestPage );
end;

{------------------------------------------------------------------}

procedure TDCPaletteStorage.LoadDefaultActiveX;
Var
  I, Idx, J : Integer;
begin
  If Not DCAreAnyActiveXAvailable Then
    Exit;

  With DCGetActiveXProvider, RegisteredLibs Do
    For I := 0 To Count - 1 Do
    begin
      Idx := FindTypeLib( StringTOGUID( Strings[ I ] ) );
      If Idx < 0 Then
        Continue;
      With TypeLibraries[ Idx ] Do
        For J := 0 To Count - 1 Do
{$IFDEF BCB}
          QueryComponentPage( sDCPalActiveX, ActiveX[ J ] );
{$ELSE}
          QueryComponentPage( sDCPalActiveX, GUIDToString( ActiveX[ J ] ) );
{$ENDIF}
    end;
end;

{------------------------------------------------------------------}

Function TDCPaletteStorage.CreateRegKey( AMode : REGSAM ) : Boolean;
Var
  RegKey      : String;
  ReturnValue : Integer;
  Disposition : Integer;
begin
  CloseRegKey;
  RegKey := GetPalleteRegKey; 
  ReturnValue := RegCreateKeyEx( HKEY_CURRENT_USER, PChar( RegKey ), 0, Nil, REG_OPTION_NON_VOLATILE,
                                 AMode, Nil, FOpenedKey, @Disposition );
  Result := ReturnValue = ERROR_SUCCESS;
end;

{------------------------------------------------------------------}

Function TDCPaletteStorage.GetPalleteRegKey : String;
begin
  Result := AddSlash( RegistryKey ) + GetRegKeyName;
  If Result[1] = '\' Then
    Delete( Result, 1, 1 );
end;

{------------------------------------------------------------------}

Procedure TDCPaletteStorage.SetNewRegKey( Const ANewKeyName : String );
begin
  If FRegKey = ANewKeyName Then
    Exit;
  FRegKey := ANewKeyName;
  Initialize;
end;

{------------------------------------------------------------------}

Function TDCPaletteStorage.GetRegKeyName : String;
begin
  If FRegKey = '' Then
    Result := sDCPaletteRegKeyPrefix
  Else
    Result := FRegKey;
end;

{------------------------------------------------------------------}

Procedure TDCPaletteStorage.InsertPage( APageIndex : Integer; Const APageName : String );
Var
  Index : Integer;
begin
  Index := PageByName( APageName );
  If Index < 0 Then
    FPages.Insert( APageIndex, TDCStoredPageInfo.Create( APageName, '' ) )
  Else
    FPages.Move( Index, APageIndex );
end;

{------------------------------------------------------------------}

Procedure TDCPaletteStorage.MovePage( AOldPosition, ANewPosition : Integer );
begin
  FPages.Move( AOldPosition, ANewPosition );
end;

{------------------------------------------------------------------}

Procedure TDCPaletteStorage.SentMessageOwner( AMsg : Cardinal; AWParam, ALParam : Integer );
Var
  Msg : TMessage;
begin
  If Not Assigned( Owner ) Then
    Exit;
  Msg.wParam := AWParam;
  Msg.lParam := ALParam;
  Msg.Msg := AMsg;
  Msg.Result := 0;
  TObject( Owner ).Dispatch( Msg );
end;

{------------------------------------------------------------------}

Procedure TDCPaletteStorage.CMActiveXChanged( Var Msg : TMessage );
begin
  Initialize;
end;

{------------------------------------------------------------------}

{ TDCStoredPageInfo }

Function TDCStoredPageInfo.AddComponent( Const AComponentName : String ) : Integer;
begin
  Result := FComponents.Add( AComponentName );
end;

{------------------------------------------------------------------}

Constructor TDCStoredPageInfo.Create( Const AName, AValues : String );
begin
  Inherited Create;
  FComponents := TStringList.Create;
  FPageName := AName;
  ParseString( AValues, ';', FComponents );
end;

{------------------------------------------------------------------}

procedure TDCStoredPageInfo.DeleteComponent( AIndex : Integer );
begin
  FComponents.Delete( AIndex );
end;

{------------------------------------------------------------------}

Destructor TDCStoredPageInfo.Destroy;
begin
  FreeObject( FComponents ,FComponents );
  Inherited;
end;

{------------------------------------------------------------------}

Function TDCStoredPageInfo.GetComponents( AIndex : Integer ) : String;
begin
  Result := FComponents[ AIndex ];
end;

{------------------------------------------------------------------}

Function TDCStoredPageInfo.GetComponentsSet : String;
begin
  Result := PackStringList( FComponents, ';' );
end;

{------------------------------------------------------------------}

Function TDCStoredPageInfo.GetCount : Integer;
begin
  Result := FComponents.Count;
end;

{------------------------------------------------------------------}

Function TDCStoredPageInfo.GetComponentOnPage( Const AComponentName : String ) : Integer;
Var
  I : Integer;
begin
  For I := 0 To Count - 1 Do
    If Components[ I ] = AComponentName Then
    begin
      Result := I;
      Exit;
    end;
  Result := -1;
end;

{------------------------------------------------------------------}

procedure TDCStoredPageInfo.MoveComponent( AStartIndex, ADestIndex : Integer );
begin
  FComponents.Move( AStartIndex, ADestIndex );
end;

{------------------------------------------------------------------}

Procedure TDCStoredPageInfo.SetComponents( AIndex : Integer; Const AValue : String );
begin
  FComponents[ AIndex ] := AValue;
end;

{------------------------------------------------------------------}

Procedure TDCStoredPageInfo.Clear;
begin
  FComponents.Clear;
end;

{------------------------------------------------------------------}

Procedure TDCStoredPageInfo.InsertComponent( AIndex : Integer; Const AComponentName : String );
begin
  FComponents.Insert( AIndex, AComponentName );
end;

{------------------------------------------------------------------}

{ TDCCompButton }

procedure TDCCompButton.Assign( ASource : TPersistent );
begin
  Inherited;
  With TDCPaletteButton( ASource ) Do
  begin
    Self.FComponentClass := FComponentClass;
    Self.FPackageID := FPackageID;
  end;
end;

{------------------------------------------------------------------}

Function TDCCompButton.ButtonName : String;
begin
  Result := ComponentClass.ClassName;
end;

{------------------------------------------------------------------}

Function TDCCompButton.GetComponentHint: String;
begin
  If Not Assigned( FComponentClass ) Then
  begin
    Result := '';
    Exit;
  end;
  Result := FComponentClass.ClassName;
  If CompareText(Copy(Result,1,Length(ClassPrefix)), ClassPrefix) = 0 Then
    Delete( Result, 1, Length(ClassPrefix));
end;

{------------------------------------------------------------------}

Function TDCCompButton.ImageInitilized: Boolean;
begin
  Result := FImageIndex >= 0;
end;

{------------------------------------------------------------------}

procedure TDCCompButton.InitButton( AComponentClass : TComponentClass; APackageID : THandle );
begin
  FPackageID := APackageID;
  SetComponentClass( AComponentClass );
end;

{------------------------------------------------------------------}

procedure TDCCompButton.InitImage;
Var
  _Glyph : TBitmap;
begin
  _Glyph := TBitmap.Create;
  try
    LoadBitmapForClass( _Glyph, FComponentClass );
    FImageIndex := DCAddImageInList( FOwner.GetImageList, _Glyph );
  finally
    _Glyph.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TDCCompButton.SetComponentClass( Const Value : TComponentClass );
begin
  FComponentClass := Value;
  ImageIndex := -1;
  FOwner.Invalidate;
end;

{------------------------------------------------------------------}

{ TDCActiveXButton }

procedure TDCActiveXButton.Assign( ASource : TPersistent );
begin
  Inherited;
  With TDCActiveXButton( ASource ) Do
  begin
    Self.FGUID := FGUID;
    Self.FHint := FHint;
  end;
end;

{------------------------------------------------------------------}

Function TDCActiveXButton.ButtonName : String;
begin
  Result := GUIDToString( FGUID );
end;

{------------------------------------------------------------------}

Function TDCActiveXButton.GetComponentHint: String;
begin
  Result := FHint;
end;

{------------------------------------------------------------------}

procedure TDCActiveXButton.InitButton( AGUID, ATypeLib : TGUID; Const AHint : String;
  APicModule : THandle; APicIndex : Integer );
Var
  _Glyph : TBitmap;
begin
  _Glyph := TBitmap.Create;
  try
    DCLoadActiveXPicture( _Glyph, APicModule, APicIndex );
    FImageIndex := DCAddImageInList( FOwner.GetImageList, _Glyph );

    FGUID    := AGUID;
    FTypeLib := ATypeLib;
    FHint    := AHint;
  finally
    _Glyph.Free;
  end;
end;

{------------------------------------------------------------------}

{ TActiveXProvider }

Procedure TActiveXProvider.AddActiveX( AActiveX, ATypeLib : TGUID );
Var
  Page : Integer;
begin
  Page := FindTypeLib( ATypeLib );
  If Page < 0 Then
  begin
    Page := FTypeLibraries.Add( TTypeLibraryDesc.Create );
    TypeLibraries[ Page ].FGUID := ATypeLib;
  end;
  TypeLibraries[ Page ].AddActiveX( AActiveX );
end;

{------------------------------------------------------------------}

Procedure TActiveXProvider.Clear;
Var
  I : Integer;
begin
  For I := 0 To FTypeLibraries.Count - 1 Do
    TTypeLibraryDesc( FTypeLibraries[ I ] ).Free;
  FTypeLibraries.Clear;
end;

{------------------------------------------------------------------}

Constructor TActiveXProvider.Create;
begin
  Inherited;
  FTypeLibraries := TList.Create;
  Initialize;
end;

{------------------------------------------------------------------}

Destructor TActiveXProvider.Destroy;
begin
  Clear;
  FreeObject( FTypeLibraries ,FTypeLibraries );
  FreeObject( FRegisteredLibs,FRegisteredLibs );
  Inherited;
end;

{------------------------------------------------------------------}

Function TActiveXProvider.FindTypeLib( ATypeLib : TGUID ) : Integer;
Var
  I : Integer;
begin
  For I := 0 To Count - 1 Do
{$IFDEF BCB}
    If IsEqualGUID( StringToGUID( TypeLibraries[ I ].GUID ), ATypeLib ) Then
{$ELSE}
    If IsEqualGUID( TypeLibraries[ I ].GUID, ATypeLib ) Then
{$ENDIF}
    begin
      Result := I;
      Exit;
    end;
  Result := -1;
end;

{------------------------------------------------------------------}

Function TActiveXProvider.GetCount : Integer;
begin
  InitNeeded;
  Result := FTypeLibraries.Count;
end;

{------------------------------------------------------------------}

Function TActiveXProvider.GetRegisteredLibs : TStrings;
begin
  InitRegisteredLibs;
  ReadStringsFromRegistry( SKnownActiveXs, FRegisteredLibs );
  If FRegisteredLibs.Count > 0 Then
    InitNeeded;
  Result := FRegisteredLibs;
end;

{------------------------------------------------------------------}

Function TActiveXProvider.GetTypeLibraries( AIndex : Integer ) : TTypeLibraryDesc;
begin
  InitNeeded;
  Result := TTypeLibraryDesc( FTypeLibraries[ AIndex ] );
end;

{------------------------------------------------------------------}

Procedure TActiveXProvider.Initialize;
var
  CategoriesManager : ICatInformation;
  CategoriesEnum    : IEnumCATEGORYINFO;
  CategoryInfo      : TCATEGORYINFO;
  Res               : DWORD;
  ControlsID        : TGUID;
  AxticeXEnum       : IEnumGUID;
  ActiveXGUID       : TGUID;
  SaveCursor        : TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    Clear;
    If CoCreateInstance( CLSID_StdComponentCategoryMgr, Nil, CLSCTX_INPROC_SERVER, {$IFDEF D3}ICatInformation{$ELSE}IID_ICatInformation{$ENDIF}, CategoriesManager ) <> S_OK Then
      Exit;

    FInitiliazed := True;

    CategoriesManager.EnumCategories( 0, CategoriesEnum );
    While CategoriesEnum.Next( 1, CategoryInfo, Res ) = 0 Do
      If ( CompareText( WideCharToString( CategoryInfo.szDescription ), 'Control' ) = 0) Or //don't resource
         ( CompareText( WideCharToString( CategoryInfo.szDescription ), 'Controls' ) = 0 ) Then //don't resource
      begin
        ControlsID := CategoryInfo.CatID;
        break;
      end;

    If CategoriesManager.EnumClassesOfCategories( 1, @ControlsID, 0, Nil, AxticeXEnum ) = S_OK Then
      While AxticeXEnum.Next( 1, ActiveXGUID, Res ) = 0 Do
        AddActiveX( ActiveXGUID, DCGetTypeLibraryGUID( ActiveXGUID ) );
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

{------------------------------------------------------------------}

procedure TActiveXProvider.InitNeeded;
begin
  If Not FInitiliazed Then
    Initialize;
end;

{------------------------------------------------------------------}

procedure TActiveXProvider.InitRegisteredLibs;
begin
  If Not Assigned( FRegisteredLibs ) Then
    FRegisteredLibs := CreateSortedStringList;
end;

{------------------------------------------------------------------}

procedure TActiveXProvider.RegisterActiveX( Const AActiveXLib : TGUID );
begin
  InitRegisteredLibs;
  If FRegisteredLibs.IndexOf( GUIDToString( AActiveXLib ) ) >= 0 Then
    Exit;
  FRegisteredLibs.Add( GUIDToString( AActiveXLib ) );
  If RegisterImmediately Then
  begin
    SaveActiveXConfig;
    BroadCastToNotifiers( Self, CM_RegisterActiveX, Integer( @AActiveXLib ), 0 );
  end;
end;

{------------------------------------------------------------------}

procedure TActiveXProvider.SaveActiveXConfig;
begin
  If ( Not RegisterImmediately ) And Not WasAnyChanges Then
    Exit;
  WriteStringsToRegistry( SKnownActiveXs, FRegisteredLibs );
  If Not RegisterImmediately Then
    BroadCastToNotifiers( Self, CM_ActiveXChanged, 0, 0 );
end;

{------------------------------------------------------------------}

procedure TActiveXProvider.SetRegisterImmediately( AValue : Boolean );
begin
  If FRegisterImmediately = AValue Then
    Exit;
  FRegisterImmediately := AValue;
  If RegisterImmediately And WasAnyChanges Then
    SaveActiveXConfig;
end;

{------------------------------------------------------------------}

procedure TActiveXProvider.UnregisterActiveX( Const AActiveXLib : TGUID );
Var
  I : Integer;
begin
  InitRegisteredLibs;
  If TStringList( FRegisteredLibs ).Find( GUIDTOString( AActiveXLib ), I ) Then
  begin
    FRegisteredLibs.Delete( I );
    If RegisterImmediately Then
    begin
      SaveActiveXConfig;
      BroadCastToNotifiers( Self, CM_UNREGISTERACTIVEX, Integer( @AActiveXLib ), 0 );
    end;
  end;
end;

{------------------------------------------------------------------}

Function TActiveXProvider.WasAnyChanges : Boolean;
begin
  Result := ( FRegisteredLibs = Nil ) Or
            ( ReadFromRegistry( SKnownActiveXs, '' ) <> FRegisteredLibs.Text );
end;

{------------------------------------------------------------------}

{ TTypeLibraryDesc }

Function TTypeLibraryDesc.AddActiveX( AGUID : TGUID ) : Integer;
begin
  Result := FCount;
  Inc( FCount );
  ReallocMem( FActiveX, FCount * SizeOf( TGUID ) );
  FActiveX^[ Result ] := AGUID;
end;

{------------------------------------------------------------------}

procedure TTypeLibraryDesc.CheckRange( AIndex : Integer );
begin
  If ( AIndex < 0 ) Or ( AIndex >= Count ) Then
    Error( sDCIndexOutOfBound );
end;

{------------------------------------------------------------------}

procedure TTypeLibraryDesc.Clear;
begin
  ReallocMem( FActiveX, 0 );
  FCOunt := 0;
end;

{------------------------------------------------------------------}

Destructor TTypeLibraryDesc.Destroy;
begin
  Clear;
  Inherited;
end;

{------------------------------------------------------------------}

{$IFDEF BCB}
Function TTypeLibraryDesc.GetGUID : String;
begin
  Result := GUIDToString( FGUID );
end;

{------------------------------------------------------------------}

Function TTypeLibraryDesc.GetActiveX( AIndex : Integer ) : String;
begin
  CheckRange( AIndex );
  Result := GUIDToString( FActiveX^[ AIndex ] );
end;

{------------------------------------------------------------------}

{$ELSE}
Function TTypeLibraryDesc.GetActiveX( AIndex : Integer ) : TGUID;
begin
  CheckRange( AIndex );
  Result := FActiveX^[ AIndex ];
end;

{------------------------------------------------------------------}

Procedure TTypeLibraryDesc.SetActiveX( AIndex : Integer; Const AValue : TGUID );
begin
  CheckRange( AIndex );
  FActiveX^[ AIndex ] := AValue;
end;
{$ENDIF}

{------------------------------------------------------------------}

Function DCAreAnyActiveXAvailable : Boolean;
Var
  ActiveXList : TStringList;
begin
  ActiveXList := TStringList.Create;
  try
    ReadStringsFromRegistry( SKnownActiveXs, ActiveXList );
    Result := ActiveXList.Count > 0;
  finally
    ActiveXList.Free;
  end;
end;

{------------------------------------------------------------------}

Function DCGetActiveXProvider : TActiveXProvider;
begin
  If FActiveXProvider = Nil Then
    FActiveXProvider := TActiveXProvider.Create;
  Result := FActiveXProvider;
end;

{------------------------------------------------------------------}

Function DCReadValueFromRegistry( AOpenKey : HKEY; Const AValue : String ) : String;
Var
  ValueMaxLen : Integer;
  Mode        : DWORD;
begin
  Result := '';
  If RegQueryInfoKey( AOpenKey, Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil,
                      @ValueMaxLen, Nil, Nil ) <> ERROR_SUCCESS Then
    Exit;
  Inc( ValueMaxLen );
  SetLength( Result, ValueMaxLen );
  Mode := REG_SZ;
  RegQueryValueEx( AOpenKey, pChar( AValue ), Nil, @MODE, pByte( Result ), @ValueMaxLen );
  SetLength( Result, ValueMaxLen );
end;

{------------------------------------------------------------------}

Function DCGetTypeLibraryGUID( AGUID : TGUID ) : TGUID;
Var
  OpenedKey  : HKEY;
  TypeLibStr : String;
begin
  Result := GUID_NULL;
  If RegOpenKeyEx( HKEY_CLASSES_ROOT, PChar( 'CLSID\' + GUIDToString( AGUID ) + '\TypeLib' ),
                   0, KEY_READ, OpenedKey ) <> ERROR_SUCCESS Then
    Exit;
  try
    TypeLibStr := DCReadValueFromRegistry( OpenedKey, '' );
    If TypeLibStr <> '' Then
      Result := StringToGUID( TypeLibStr );
  finally
    RegCloseKey( OpenedKey );
  end;
end;

{------------------------------------------------------------------}

Procedure DCGetActiveXPictureInfo( AItemGUID : TGUID; Var PictIndex : Integer;
  Var PictName : String );
Var
  OpenedKey : HKEY;
  PictInfo  : String;
begin
  PictName := '';
  PictIndex := -1;
  If RegOpenKeyEx( HKEY_CLASSES_ROOT, PChar( 'CLSID\' + GUIDToString( AItemGUID ) + '\ToolboxBitmap32' ),
                   0, KEY_READ, OpenedKey ) <> ERROR_SUCCESS Then
    Exit;
  try
    PictInfo := DCReadValueFromRegistry( OpenedKey, '' );
  finally
    RegCloseKey( OpenedKey );
  end;

  PictIndex := Pos( ',', PictInfo );
  If PictIndex > 0 Then
  begin
    PictName := Copy( PictInfo, 1, PictIndex - 1 );
    PictIndex := StrToIntDef( Copy( PictInfo, PictIndex + 1, Length( PictInfo ) - PictIndex ), 0 );
  end
  Else
    PictName := PictInfo;
end;

{------------------------------------------------------------------}

Function DCGetActiveXHint( AItemGUID : TGUID ) : String;
Var
  pwHint : pWideChar;
begin
  ProgIDFromCLSID( AItemGUID, pwHint );
  If pwhint <> Nil Then
    Result := ExtractControlName( WideCharToString( pwHint ) )
  Else
    Result := '';
end;

{------------------------------------------------------------------}

Function DCGetInprocServer( AItemGUID : TGUID ) : String;
Var
  OpenedKey : HKEY;
begin
  Result := '';
  If RegOpenKeyEx( HKEY_CLASSES_ROOT, PChar( 'CLSID\' + GUIDToString( AItemGUID ) + '\InprocServer32' ),
                   0, KEY_READ, OpenedKey ) <> ERROR_SUCCESS Then
    Exit;
  try
    Result := DCReadValueFromRegistry( OpenedKey, '' );
  finally
    RegCloseKey( OpenedKey );
  end;
end;

{------------------------------------------------------------------}

Procedure DCLoadActiveXPicture( AGlyph : TBitmap; APicModule : THandle; APicIndex : Integer );
begin
  If ( APicModule <> 0 ) And
     ( FindResource( APicModule, PChar( APicIndex ), RT_BITMAP ) <> 0 ) Then
    try
      AGlyph.LoadFromResourceID( APicModule, APicIndex )
    except
      LoadUnknownGlyph( AGlyph );
    end
  Else
    LoadUnknownGlyph( AGlyph );
  DCFitBitmap( AGlyph, sDCDefaultImageWidth, sDCDefaultImageHeight );
end;

{------------------------------------------------------------------}

Function  DCIsActiveXRegisteres( Const AStrGUID : String ) : Boolean;
Var
  OpenedKey : HKey;
begin
  Result := RegOpenKeyEx( HKEY_CLASSES_ROOT, PChar( 'CLSID\' + AStrGUID ), 0,
                          KEY_QUERY_VALUE, OpenedKey ) = ERROR_SUCCESS;
  If Result Then
    RegCloseKey( OpenedKey );
end;

{------------------------------------------------------------------}

initialization
finalization
  FreeObject( FActiveXProvider ,FActiveXProvider );
end.
