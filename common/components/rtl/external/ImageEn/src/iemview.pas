(*
Copyright (c) 1998-2004 by HiComponents. All rights reserved.

This software comes without any warranty either implied or expressed.
In no case shall the author be liable for any damage or unwanted behavior of any
computer hardware and/or software.

HiComponents grants you the right to include the compiled component
in your application, whether COMMERCIAL, SHAREWARE, or FREEWARE,
BUT YOU MAY NOT DISTRIBUTE THIS SOURCE CODE OR ITS COMPILED .DCU IN ANY FORM.

ImageEn may not be included in any commercial, shareware or freeware DELPHI
libraries or components.

email: support@hicomponents.com

http://www.hicomponents.com

*)

unit iemview;

{$R-}
{$Q-}


{$I ie.inc}

{$ifdef IEINCLUDEMULTIVIEW}

interface



uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, 
  ExtCtrls, Clipbrd, stdctrls, hyieutils, hyiedefs, ImageEnView, ImageEnProc, ImageEnIO,ieview,iemio;

type

  // Evento generato ogni volta che l'utente seleziona un'immagine (non quando
  // viene impostata la proprietà SelectedImage).
  TIEImageSelectEvent = procedure(Sender:TObject; idx:integer) of object;

  // Bitmap viene copiata in ImageEn. Per questo si può assegnare semplicemente con =
  // la bitmap da disegnare, poi ci penserà ImageEn a liberarla.
  TIEImageIDRequestEvent = procedure(Sender: TObject; ID:integer; var Bitmap:TBitmap) of object;
  TIEImageIDRequestExEvent = procedure(Sender: TObject; ID:integer; var Bitmap:TIEBitmap) of object;

  // Evento del progress PaintTo (idx=indice immagine da disegnare)
  TIEMProgressEvent = procedure(Sender: TObject; per:integer; idx:integer) of object;

  TIEWrongImageEvent = procedure(Sender:TObject; OutBitmap:TIEBitmap; idx:integer; var Handled:boolean) of object;


  // Questo evento viene generato ogni volta che viene visualizzata un'immagine.
  // Il parametro "idx" è l'indice dell'immagine (non l'ID assegnato dall'utente)
  // BackColor si riferisce al background all'interno di ImWidth e ImHeight
  // ImWidth e ImHeight possono essere modificati qui affinchè l'immagine sia di
  // domensioni diverse da quelle standard (cioè delle proprietà ThumbWidth e ThumbHeight).
  // Comunque deve essere sempre ImWidth<ThumbWidth e ImHeight<ThumbHeight.
  // Left,Top sono le coordinate alto-sinistro dove verrà scritta l'immagine. Notare che
  // l'utente non può scrivere dove sarà disegnata l'immagine ed il suo sfondo.
  TIEImageDrawEvent = procedure(Sender:TObject; idx:integer; Left,Top:integer; Canvas:TCanvas) of object;

  // Compare is a comparison function that indicates how the items are to be ordered.
  // Compare returns < 0 if Item1 is less and Item2, 0 if they are equal and > 0 if Item1 is greater than Item2.
  TIEImageEnMViewSortCompare = function (Item1, Item2: integer): Integer;


  // specifies how load the images
  TIEStoreType=(
                // the image will be full loaded
  					 ietNormal,
                // the image will loaded as thumbnail (see ThumbWidth, ThumbHeight))
  					 ietThumb
                );

  TIEMTextPos=(iemtpTop, iemtpBottom, iemtpInfo);

  TIEMText=class
      private
         fCaption:WideString;
         fFont:TFont;
         fBackground:TColor;
         fOwner:TComponent;
         fPos:TIEMTextPos;
         procedure SetCaption(value:WideString);
      public
         constructor Create(Owner:TComponent; Position:TIEMTextPos);
         destructor Destroy; override;
         property Caption:WideString read fCaption write SetCaption;
         property Font:TFont read fFont;
         property Background:TColor read fBackground write fBackground;
  end;


  // this structure contains single image info (except bitmaps)
  TIEImageInfo=record
  	 // the parent TImageEnMView object
    parent:TObject;	// the TImageEnMView parent object
  	 // image contained in fImageList[]
    // if image is nil the image is not handled by component
	 image:pointer;
    // image contained in fCacheList[]
    // if nil we need to repaint the image
    cacheImage:pointer;
    // posizione angolo top,left
    X,Y:integer;
    // riga e colonna dell'immagine (calcolati da UpdateCoords)
    row,col:integer;
    // background immagine
    Background:TColor;
    // Nome del file da caricare. Valore di invalidità: ''
    name:PAnsiChar;
    // numero immagine. Valore di invalidità: -1
    ID:integer;
    // Delay time, tempo di visualizzazione per questa immagine (in millisecondi)
    DTime:integer;
    // Texts info
    TopText:TIEMText;
    BottomText:TIEMText;
    InfoText:TIEMText;
  end;
  PIEImageInfo=^TIEImageInfo;

  // automatic interactions with mouse
  TIEMMouseInteractItems=(
  								  mmiScroll,			// hand-scroll
                          mmiSelect			// images selection
  								);
  TIEMMouseInteract=set of TIEMMouseInteractItems;

  // automatic interaction with keyboard
  TIEMKeyInteractItems=(
  								  mkiMoveSelected		// move selected item (up,down,left,right)
  							  );
  TIEMKeyInteract=set of TIEMKeyInteractItems;

  // display mode
  TIEMDisplayMode=(
                    mdGrid,			// grid (active fGridWidth property)
                    mdSingle			// single frame
  						);

  TIESeek=(iskLeft, iskRight, iskUp, iskDown, iskFirst, iskLast, iskPagDown, iskPagUp);

  TIEMStyle=(iemsFlat, iemsACD);

  TIESStyle=(iessAround, iessACD);

  TIEMultiSelectionOptions=set of (
  					iemoRegion,
               iemoSelectOnMouseUp
               );

  TIEWallPaperStyle=(iewoNormal, iewoStretch, iewoTile);

  TImageEnMView=class;

  TIEStarter=class(TThread)
	  public
     	 mview:TImageEnMView;
   	 procedure Execute; override;
  end;

  TImageEnMView = class(TIEView)
  private
    /////////////////////////
    // P R I V A T E
    fMDown:boolean;
    fBackBuffer:TIEBitmap;
    fHSVX1,fHSVY1:integer; // view in mouse down
    fScrollBars:TScrollStyle;
    fRXScroll,fRYScroll:double;
    fViewX,fViewY:integer;
    fImageList:TIEVirtualDIBList;
    fCacheList:TIEVirtualDIBList;
    fImageInfo:TList;   // contiene strutture TIEImageInfo
    fStoreType:TIEStoreType;	// tipo immagazzinamento immagini
    fThumbWidth,fThumbHeight:integer;	// dimensioni thumbs
    fHorizBorder:integer; // bordo orizzontale tra immagini
    fVertBorder:integer;	// bordo verticale tra immagini
    fVWidth,fVHeight:integer; // larghezza spazio virtuale (agg. da UpdateCoords)
    fOnViewChange:TViewChangeEvent;
    fOnDrawProgress:TIEMProgressEvent;
    fOnWrongImage:TIEWrongImageEvent;
    fHDrawDib:HDRAWDIB;		// per disegno su schermo
    fOnImageIDRequest:TIEImageIDRequestEvent;
    fOnImageIDRequestEx:TIEImageIDRequestExEvent;
    fOnImageDraw:TIEImageDrawEvent;
    fOnIOProgress:TIEProgressEvent;
    fBottomGap:integer; // fThumbHeight-fBottomGap-fUpperGap=altezza reale dell'immagine
    fUpperGap:integer;	// fThumbHeight-fBottomGap-fUpperGap=altezza reale dell'immagine
    fDisplayMode:TIEMDisplayMode;	// modo di visualizzazione
    fGridWidth:integer;	// immagini in orizzontale (1=in verticale, altri griglia)
    fHSX1,fHSY1:integer;	// coordinate mouse down
    fHSIDX,fLHSIDX:integer;
    fImageEnIO:TImageEnIO;	// per caricamento automatico immagini da file (Name)
    fLockPaint:integer;		// 0=paint sbloccato
    fRemoveCorrupted:boolean; // works only when ImageFileName[] contains valid names
    fDrawImageBackground:boolean; // true=draw image background  false=draw component background
    fScrollBarsAlwaysVisible:boolean; // true if the scrollbars are always visible
    fVScrollBarParams:TIEScrollBarParams;
    fHScrollBarParams:TIEScrollBarParams;
    fThumbnailResampleFilter:TResampleFilter;
    fThumbnailDisplayFilter:TResampleFilter;
    fDestroying:boolean; // component is destroying
    fStyle:TIEMStyle;
    fSelectionStyle:TIESStyle;
    fDoubleClicking:boolean;
    fThumbnailsBackground:TColor;
    fThumbnailsBorderWidth:integer;
    fThumbnailsBorderColor:TColor;
    fUpdating:boolean;
    fEnableResamplingOnMinor:boolean;  // Enable resampling when the image has width and height < of thumbnail width and height
                                       // when true (default) the image will be resized to the thumbnail sizes
	 fEnableAlphaChannel:boolean;
    fBackgroundStyle:TIEBackgroundStyle;
    fThumbnailsBackgroundStyle:TIEBackgroundStyle;
    fFillThumbnail:boolean;
    fCurrentCompare: TIEImageEnMViewSortCompare;
    // Multithread
    fThreadPoolSize:integer;  // maximum threads count (0=disable multithread)
    fThreadPoolIO:TList;      // list of TImageEnIO objects (maximum size is fThreadPoolSize)
    fThreadRequests:TList;    // list of integers, the indexes of the image to load (no maximum size)
    fThreadStarter:TIEStarter;	// starter main thread
    // Wall paper
    fWallPaper:TPicture;
    fWallPaperStyle:TIEWallPaperStyle;
    // Selections
    fSelectedItem:integer;	// indice dell'immagine selezionata (-1 nessuna)
    fVisibleSelection:boolean;
    fSelectionWidth:integer; // spessore selezione
    fSelectionColor:TColor;  // colore selezione
    fOnImageSelect:TIEImageSelectEvent;
    fMouseInteract:TIEMMouseInteract;
    fKeyInteract:TIEMKeyInteract;
    fSelectedBitmap:TIEBitmap;
    fImageCacheSize:integer;	// stored in fImageList.MaxImagesInMemory
    fMultiSelecting:boolean;
    fEnableMultiSelect:boolean;
    fHaveMultiselected:boolean;	// last mouseMove has selected images
    fSelectInclusive:boolean;	// when true reselecting an image doesn't unselect it
    fMultiSelectionOptions:TIEMultiSelectionOptions;
    fSelectImages:boolean;	// if true we are inside BeginSelectImages and EndSelectImages
    // Play
    fPlaying:boolean;	// true=play attivo
    fPlayTimer:integer; // handle del timer (0=non allocato)
    fPlayLoop:boolean;	// se true esegue in loop
    fTimerInProgress:boolean;
    fFrame:integer;	// current frame on single image mode
    fSaveDM:TIEMDisplayMode; // displaymode prima del play
    fSaveSel:integer;	// SelectedImage prima del play
    // Queste due variabili occorrono a TImageEnMIO per mantenersi aggiornata
    // sulle immagini inserite o eliminate.
    fLastImOp:integer; // ultima operazione di insert(1)/delete(2) effettuata (0=no op)
    fLastImIdx:integer; // indice immagine elaborata, in riferimento a fLastImOp
    // transition effects
    fTransition:TIETransitionEffects;		// effect engine
    fTransitionEffect:TIETransitionType;	// transition type
    fTransitionDuration:integer;				// transition duration ms
    //
    fOnProgress:TIEProgressEvent;
    fOnBeforeImageDraw:TIEImageDrawEvent;
    fEnableImageCaching:boolean;
    fSoftShadow:TIEVSoftShadow;
    fChessboardSize:integer;
    fChessboardBrushStyle:TBrushStyle;
    fGradientEndColor:TColor;
    fShowText:boolean;
    fSetUpperGap,fSetBottomGap:integer;
    procedure GetMaxViewXY(var mx,my:integer);
    procedure SetViewX(v:integer);
    procedure SetViewY(v:integer);
    function GetImageX(idx:integer):integer;
    function GetImageY(idx:integer):integer;
    function GetImageCol(idx:integer):integer;
    function GetImageRow(idx:integer):integer;
    procedure SetThumbWidth(v:integer);
    procedure SetThumbHeight(v:integer);
    function GetImageCount:integer;
    procedure SetImageFileName(idx:integer; v:string);
    function GetImageFileName(idx:integer):string;
    procedure SetImageID(idx,v:integer);
    function GetImageID(idx:integer):integer;
    procedure SetHorizBorder(v:integer);
    procedure SetVertBorder(v:integer);
    function DeleteImageNU(idx:integer):boolean;
    procedure SetVisibleSelection(v:boolean);
    procedure SetSelectionWidth(v:integer);
    procedure SetSelectionColor(v:TColor);
    procedure SetSelectedItem(v:integer);
    procedure SetBottomGap(v:integer);
    procedure SetUpperGap(v:integer);
    procedure SetImageBackground(idx:integer; v:TColor);
    function GetImageBackground(idx:integer):TColor;
    procedure SetImageDelayTime(idx:integer; v:integer);
    function GetImageDelayTime(idx:integer):integer;
    function ObtainImageNow(idx:integer):boolean;
    function ObtainImageThreaded(idx:integer):boolean;
    procedure SetDisplayMode(v:TIEMDisplayMode);
    procedure SetGridWidth(v:integer);
    procedure SetPlaying(v:boolean);
    procedure PlayFrame;
    procedure SetSelectedItemNU(v:integer);
    procedure DeselectNU;
    procedure SetVisibleFrame(v:integer);
    function GetMouseInteract:TIEMMouseInteract;
    function GetKeyInteract:TIEMKeyInteract;
    procedure SetRemoveCorrupted(v:boolean);
    procedure SetDrawImageBackground(v:boolean);
    function GetScrollBarsAlwaysVisible:boolean;
    procedure SetScrollBarsAlwaysVisible(v:boolean);
    procedure SetImageCacheSize(v:integer);
    function GetTransitionRunning:boolean;
    function GetImageTopText(idx:integer):TIEMText;
    function GetImageBottomText(idx:integer):TIEMText;
    function GetImageInfoText(idx:integer):TIEMText;
    procedure SetStyle(value:TIEMStyle);
    procedure SetSelectionStyle(value:TIESStyle);
    procedure SetEnableMultiSelect(Value:boolean);
    function GetMultiSelectedImages(index:integer):integer;
	 function GetMultiSelectedImagesCount:integer;
    procedure SetThumbnailsBorderWidth(Value:integer);
    procedure SetThumbnailsBorderColor(Value:TColor);
    procedure SetEnableResamplingOnMinor(Value:boolean);
    procedure DrawImage(DestBitmap:TBitmap; info:PIEImageInfo; IsSelected:boolean; Index:integer);
    procedure ThreadFinish(Sender:TObject);
    function GetImageBitCount(idx:integer):integer;
    function GetMaximumViewX:integer;
    function GetMaximumViewY:integer;
    procedure SetEnableImageCaching(v:boolean);
    function SetImageFromStreamOrFile(idx:integer; Stream:TStream; const FileName:string):boolean;
    procedure SetEnableAlphaChannel(v:boolean);
    procedure SetBackgroundStyle(v:TIEBackgroundStyle);
    procedure SetThumbnailsBackgroundStyle(v:TIEBackgroundStyle);
    procedure SetGradientEndColor(Value:TColor);
    procedure SetFillThumbnail(Value:boolean);
    procedure SetShowText(Value:boolean);
  protected
  	 ///////////////////////
    // P R O T E C T E D
    //
    // encapsulated components
    fImageEnMIO:TImageEnMIO;
    fImageEnProc:TImageEnProc;
    // selections
    fMultiSelectedImages:TList;	// array of selected images (pointer=integer=index of the selected image)
    //
    function GetImageEnMIO:TImageEnMIO; virtual;
    function GetImageEnProc:TImageEnProc; virtual;
    procedure SetScrollBars(v:TScrollStyle); virtual;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMEraseBkgnd(var Message:TMessage); message WM_ERASEBKGND;
    procedure WMVScroll(var Message:TMessage); message WM_VSCROLL;
    procedure WMHScroll(var Message:TMessage); message WM_HSCROLL;
    procedure WMTimer(var Message:TWMTimer); message WM_TIMER;
    procedure CMWantSpecialKey(var Msg: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
	 procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMMouseWheel(var Message:TMessage); message WM_MOUSEWHEEL;
    procedure ViewChange(c:integer); virtual;
    function PaletteChanged(Foreground: Boolean): Boolean; override;
    procedure SetBackGround(cl:TColor); override;
    function GetFBitmap:TBitmap; override;
    function GetIEBitmap:TIEBitmap; override;
    procedure SetMouseInteract(v:TIEMMouseInteract); virtual;
    procedure SetKeyInteract(v:TIEMKeyInteract); virtual;
    function GetImageWidth(idx:integer):integer;
    function GetImageHeight(idx:integer):integer;
    function GetImageOriginalWidth(idx:integer):integer;
    function GetImageOriginalHeight(idx:integer):integer;
    procedure SetImageOriginalWidth(idx:integer; Value:integer);
    procedure SetImageOriginalHeight(idx:integer; Value:integer);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure SelectAtPos(X,Y:integer; Shift:TShiftState);
    procedure SetWallPaper(Value:TPicture);
    procedure SetWallPaperStyle(Value:TIEWallPaperStyle);
    function GetHasAlphaChannel:boolean; override;
    function GetAlphaChannel:TIEBitmap; override;
    procedure SetOnProgress(v:TIEProgressEvent); virtual;
    function GetOnProgress:TIEProgressEvent; virtual;
    procedure ClearThreadsAndRequests; virtual;
    procedure ClearCache;
    procedure DoWrongImage(OutBitmap:TIEBitmap; idx:integer); virtual;
  public                 
    /////////////////////
    // P U B L I C
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    // display
    procedure Update; override;
    procedure PaintTo(DestBitmap:TBitmap); virtual;
    procedure Paint; override;
    property ClientWidth;
    property ClientHeight;
    property ViewX:integer read fViewX write SetViewX;
    property ViewY:integer read fViewY write SetViewY;
    property MaximumViewX:integer read GetMaximumViewX;
    property MaximumViewY:integer read GetMaximumViewY;
    procedure SetViewXY(x,y:integer);
    procedure CenterSelected;
    procedure CenterFrame;
    procedure LockPaint; override;
    function UnLockPaint:integer; override;
    function NPUnLockPaint:integer; override;
    property LockPaintCount:integer read fLockPaint;
    property SoftShadow:TIEVSoftShadow read fSoftShadow;
    procedure SetChessboardStyle(Size:integer;BrushStyle:TBrushStyle);
    property GradientEndColor:TColor read fGradientEndColor write SetGradientEndColor;
    property FillThumbnail:boolean read fFillThumbnail write SetFillThumbnail;
    // others
    property MouseCapture;
    procedure Assign(Source: TPersistent); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    function GetLastOp:integer;
    function GetLastOpIdx:integer;
    property ScrollBarsAlwaysVisible:boolean read GetScrollBarsAlwaysVisible write SetScrollBarsAlwaysVisible default false;
    property VScrollBarParams:TIEScrollBarParams read fVScrollBarParams;
    property HScrollBarParams:TIEScrollBarParams read fHScrollBarParams;
    procedure RemoveAlphaChannel(Merge:boolean); override;
    procedure CallBitmapChangeEvents; override;
    procedure FillFromDirectory(const Directory:string);
    // cache
    procedure ClearImageCache(idx:integer);
    property EnableImageCaching:boolean read fEnableImageCaching write SetEnableImageCaching default true;
    // images
    property ImageWidth[idx:integer]:integer read GetImageWidth;
    property ImageHeight[idx:integer]:integer read GetImageHeight;
    property ImageOriginalWidth[idx:integer]:integer read GetImageOriginalWidth write SetImageOriginalWidth;
    property ImageOriginalHeight[idx:integer]:integer read GetImageOriginalHeight write SetImageOriginalHeight;
    property ImageBitCount[idx:integer]:integer read GetImageBitCount;
    property ImageX[idx:integer]:integer read GetImageX;
	 property ImageY[idx:integer]:integer read GetImageY;
    property ImageRow[idx:integer]:integer read GetImageRow;
    property ImageCol[idx:integer]:integer read GetImageCol;
    property ImageFileName[idx:integer]:string read GetImageFileName write SetImageFileName;
    property ImageID[idx:integer]:integer read GetImageID write SetImageID;
    property ImageBackground[idx:integer]:TColor read GetImageBackground write SetImageBackground;
	 property ImageDelayTime[idx:integer]:integer read GetImageDelayTime write SetimageDelayTime;
    property ImageTopText[idx:integer]:TIEMText read GetImageTopText;
    property ImageBottomText[idx:integer]:TIEMText read GetImageBottomText;
    property ImageInfoText[idx:integer]:TIEMText read GetImageInfoText;
    property ShowText:boolean read fShowText write SetShowText;
    procedure UpdateImage(idx:integer);
    procedure InsertImage(idx:integer);
    procedure InsertImageEx(idx:integer);
    procedure MoveImage(idx:integer; destination:integer);
    procedure Sort(Compare: TIEImageEnMViewSortCompare);
    function AppendImage:integer;
    procedure DeleteImage(idx:integer);
    procedure DeleteSelectedImages;
    property ImageCount:integer read GetImageCount;
    procedure UpdateCoords;
    procedure SetImage(idx:integer; v:TBitmap);
    procedure SetImageEx(idx:integer; v:TBitmap);
    procedure SetIEBitmapEx(idx:integer; v:TIEBaseBitmap);
    procedure SetIEBitmap(idx:integer; v:TIEBaseBitmap);
    function SetImageFromFile(idx:integer; const FileName:String):boolean;
    function SetImageFromStream(idx:integer; Stream:TStream):boolean;
    procedure SetImageRect(idx:integer; v:TBitmap; x1,y1,x2,y2:integer);
    procedure Clear;
    function GetBitmap(idx:integer):TBitmap;
    procedure ReleaseBitmap(idx:integer);
    function GetTIEBitmap(idx:integer):TIEBitmap;
    function GetImageVisibility(idx:integer):integer;
    function ImageAtPos(x,y:integer):integer;
    function ImageAtGridPos(row,col:integer):integer;
    function InsertingPoint(x,y:integer):integer;
    property ThumbnailResampleFilter:TResampleFilter read fThumbnailResampleFilter write fThumbnailResampleFilter;
    property ThumbnailDisplayFilter:TResampleFilter read fThumbnailDisplayFilter write fThumbnailDisplayFilter;
    property EnableResamplingOnMinor:boolean read fEnableResamplingOnMinor write SetEnableResamplingOnMinor;
    procedure CopyToIEBitmap(idx:integer; bmp:TIEBitmap);
    function IsVisible(idx:integer):boolean;
    // allocations
    procedure PrepareSpaceFor(Width,Height:integer; Bitcount:integer; ImageCount:integer);
    // selection
  	 property SelectedImage:integer read fSelectedItem write SetSelectedItem;
    procedure Deselect;
    procedure SelectSeek(pos:TIESeek);
    property MultiSelecting:boolean read fMultiSelecting write fMultiSelecting;
    property MultiSelectedImages[index:integer]:integer read GetMultiSelectedImages;
    property MultiSelectedImagesCount:integer read GetMultiSelectedImagesCount;
    procedure MultiSelectSortList;
    procedure UnSelectImage(idx:integer);
    procedure SelectAll;
    procedure BeginSelectImages;
    procedure EndSelectImages;
    function IsSelected(idx:integer):boolean;
    // play
    property Playing:boolean read fPlaying write SetPlaying;
    property PlayLoop:boolean read fPlayLoop write fPlayLoop;
    property VisibleFrame:integer read fFrame write SetVisibleFrame;
    //
	 property TransitionRunning:boolean read GetTransitionRunning;
    // encapsulated components
    property MIO:TImageEnMIO read GetImageEnMIO;
    property Proc:TImageEnProc read GetImageEnProc;
  published
    ///////////////////////
    // P U B L I S H E D
    property ScrollBars:TScrollStyle read fScrollBars write SetScrollBars default ssBoth;
    property StoreType:TIEStoreType read fStoreType write fStoreType default ietNormal;
    property ThumbWidth:integer read fThumbWidth write SetThumbWidth default 100;
    property ThumbHeight:integer read fThumbHeight write SetThumbHeight default 100;
    property HorizBorder:integer read fHorizBorder write SetHorizBorder default 4;
    property VertBorder:integer read fVertBorder write SetVertBorder default 4;
    property BottomGap:integer read fBottomGap write SetBottomGap default 0;
    property UpperGap:integer read fUpperGap write SetUpperGap default 0;
    property OnViewChange:TViewChangeEvent read fOnViewChange write fOnViewChange;
    property OnImageIDRequest:TIEImageIDRequestEvent read fOnImageIDRequest write fOnImageIDRequest;
    property OnImageIDRequestEx:TIEImageIDRequestExEvent read fOnImageIDRequestEx write fOnImageIDRequestEx;
    property OnBeforeImageDraw:TIEImageDrawEvent read fOnBeforeImageDraw write fOnBeforeImageDraw;
	 property OnImageDraw:TIEImageDrawEvent read fOnImageDraw write fOnImageDraw;
    property OnImageSelect:TIEImageSelectEvent read fOnImageSelect write fOnImageSelect;
    property OnIOProgress:TIEProgressEvent read fOnIOProgress write fOnIOProgress;
    property OnDrawProgress:TIEMProgressEvent read fOnDrawProgress write fOnDrawProgress;
    property OnWrongImage:TIEWrongImageEvent read fOnWrongImage write fOnWrongImage;
    property VisibleSelection:boolean read fVisibleSelection write SetVisibleSelection default true;
    property MouseInteract:TIEMMouseInteract read GetMouseInteract write SetMouseInteract default [mmiSelect];
    property KeyInteract:TIEMKeyInteract read GetKeyInteract write SetKeyInteract default [mkiMoveSelected];
	 property DisplayMode:TIEMDisplayMode read fDisplayMode write SetDisplayMode default mdGrid;
    property GridWidth:integer read fGridWidth write SetGridWidth default 0;
    property SelectionWidth:integer read fSelectionWidth write SetSelectionWidth;
    property SelectionColor:TColor read fSelectionColor write SetSelectionColor;
    property RemoveCorrupted:boolean read fRemoveCorrupted write SetRemoveCorrupted default false;
    property DrawImageBackground:boolean read fDrawImageBackground write SetDrawImageBackground default false;
    property ImageCacheSize:integer read fImageCacheSize write SetImageCacheSize default 10;
    property TransitionEffect:TIETransitionType read fTransitionEffect write fTransitionEffect default iettNone;
    property TransitionDuration:integer read fTransitionDuration write fTransitionDuration default 1000;
    property Style:TIEMStyle read fStyle write SetStyle default iemsACD;
    property SelectionStyle:TIESStyle read fSelectionStyle write SetSelectionStyle default iessAround;
    property ThumbnailsBackground:TColor read fThumbnailsBackground write fThumbnailsBackground default clBtnFace;
    property EnableMultiSelect:boolean read fEnableMultiSelect write SetEnableMultiSelect default false;
    property MultiSelectionOptions:TIEMultiSelectionOptions read fMultiSelectionOptions write fMultiSelectionOptions default [];
    property ThumbnailsBorderWidth:integer read fThumbnailsBorderWidth write SetThumbnailsBorderWidth default 0;
    property ThumbnailsBorderColor:TColor read fThumbnailsBOrderColor write SetThumbnailsBorderColor default clBtnFace;
    property WallPaper:TPicture read fWallPaper write SetWallPaper;
    property WallPaperStyle:TIEWallPaperStyle read fWallPaperStyle write SetWallPaperStyle default iewoNormal;
    property OnProgress:TIEProgressEvent read GetOnProgress write SetOnProgress;
    property ThreadPoolSize:integer read fThreadPoolSize write fThreadPoolSize default 5;
    property EnableAlphaChannel:boolean read fEnableAlphaChannel write SetEnableAlphaChannel default true;
    property BackgroundStyle:TIEBackgroundStyle read fBackgroundStyle write SetBackgroundStyle default iebsSolid;
    property ThumbnailsBackgroundStyle:TIEBackgroundStyle read fThumbnailsBackgroundStyle write SetThumbnailsBackgroundStyle default iebsSolid;
    {$ifdef IESUPPORTANCHORS}
	 property Anchors;
	 {$endif}
    {$ifdef IEMOUSEWHEELEVENTS}
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    {$endif}
    property Align;
    property DragCursor;
    property DragMode;
    property Enabled;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property TabOrder;
    property TabStop;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

implementation

{$R-}


/////////////////////////////////////////////////////////////////////////////////////
constructor TImageEnMView.Create(Owner: TComponent);
begin
	fBackBuffer:=TIEBitmap.Create;
   fBackBuffer.Location:=ieTBitmap;
   fImageEnMIO:=nil;
   fImageEnProc:=nil;
   inherited Create(Owner);
   fUpdating:=false;
   fMultiSelectedImages:=TList.Create;
   fDestroying:=false;
   fScrollBarsAlwaysVisible:=false;
   fRXScroll:=1;
   fRYScroll:=1;
   fScrollBars:=ssBoth;
   Height:=90;
   Width:=180;
   fImageInfo:=TList.Create;
   fStoreType:=ietNormal;
   fThumbWidth:=100;
   fThumbHeight:=100;
   fHorizBorder:=4;
   fVertBorder:=4;
   fVWidth:=0;
   fVHeight:=0;
   fOnViewChange:=nil;
   fOnImageIDRequest:=nil;
   fOnImageIDRequestEx:=nil;
   fOnImageDraw:=nil;
   fOnImageSelect:=nil;
   fOnDrawProgress:=nil;
   fOnWrongImage:=nil;
   fHDrawDib:=IEDrawDibOpen;
   fImageEnIO:=TImageEnIO.Create(self);
   fSelectedItem:=-1;
   fVisibleSelection:=true;
   fSelectionWidth:=3;
   fSelectionColor:=clRed;
   fBottomGap:=0;
   fUpperGap:=0;
   fMouseInteract:=[mmiSelect];
   fKeyInteract:=[mkiMoveSelected];
   fDisplayMode:=mdGrid;
   fGridWidth:=0;
   fPlayTimer:=0;
   fPlayLoop:=true;
	fLastImOp:=0;
   fLastImIdx:=0;
   fTimerInProgress:=false;
   fFrame:=0;
   fLockPaint:=0;
   fOnIOProgress:=nil;
   fRemoveCorrupted:=false;
   fDrawImageBackground:=false;
   fThumbnailResampleFilter:=rfFastLinear;
   fThumbnailDisplayFilter:=rfNone;
   fVScrollBarParams:=TIEScrollBarParams.Create;
	fHScrollBarParams:=TIEScrollBarParams.Create;
   fImageCacheSize:=10;
   fImageList:=TIEVirtualDIBList.Create;
   fImageList.MaxImagesInMemory:=fImageCacheSize;
   fCacheList:=TIEVirtualDIBList.Create;
   fTransition:=TIETransitionEffects.Create(self);
   fTransitionEffect:=iettNone;
   fTransitionDuration:=1000;
   fStyle:=iemsACD;
   fSelectionStyle:=iessAround;
   fDoubleClicking:=false;
   fThumbnailsBackground:=clBtnFace;
   fMultiSelecting:=false;
   fEnableMultiSelect:=false;
   fSelectInclusive:=false;
   fMultiSelectionOptions:=[];
   fThumbnailsBorderWidth:=0;
   fThumbnailsBOrderColor:=clBtnFace;
   fWallPaper:=TPicture.Create;
   fWallPaperStyle:=iewoNormal;
   fEnableResamplingOnMinor:=true;
   fOnProgress:=nil;
   fOnBeforeImageDraw:=nil;
   fThreadPoolSize:=5;
   fThreadPoolIO:=TList.Create;
   fThreadRequests:=TList.Create;
   fThreadStarter:=TIEStarter.Create(true);
   fThreadStarter.mview:=self;
   fSelectImages:=false;
   fEnableImageCaching:=true;
   fHaveMultiselected:=false;
   fSoftShadow:=TIEVSoftShadow.Create;
   fSoftShadow.Enabled:=false;
   fSoftShadow.Radius:=3;
   fSoftShadow.OffsetX:=3;
   fSoftShadow.OffsetY:=3;
   fEnableAlphaChannel:=true;
   fBackgroundStyle:=iebsSolid;
   fThumbnailsBackgroundStyle:=iebsSolid;
   fChessboardSize:=16;
   fChessboardBrushStyle:=bsSolid;
   fGradientEndColor:=clBlue;
   fFillThumbnail:=true;
   fMDown:=false;
   fShowText:=true;
   fSetUpperGap:=0;
   fSetBottomGap:=0;
   fCurrentCompare:=nil;
end;

procedure TImageEnMView.ClearThreadsAndRequests;
var
   i:integer;
begin
	EnterCriticalSection(gThreadCS);
   fThreadRequests.Clear;
	for i:=0 to fThreadPoolIO.Count-1 do begin
      if TImageEnIO(fThreadPoolIO[i]).Tag>-1 then begin
         TImageEnIO(fThreadPoolIO[i]).Tag:=-2;
         TImageEnIO(fThreadPoolIO[i]).Aborting:=true;
      end;
   end;
   LeaveCriticalSection(gThreadCS);
   // wait up to 1 second
   for i:=1 to 10 do
   	if fThreadPoolIO.Count>0 then
      	sleep(100);
end;

// note: the timer object is not destroyed because the win32 should destroy it.
destructor TImageEnMView.Destroy;
var
	toDestroy:TIEbitmap;
begin
   DeselectNU;
	// threads
   ClearThreadsAndRequests;
   while fThreadPoolIO.Count>0 do begin
      toDestroy:=TImageEnIO(fThreadPoolIO[0]).IEBitmap;
      TImageEnIO(fThreadPoolIO[0]).free;
      toDestroy.free;
      fThreadPoolIO.Delete(0);
   end;
	fThreadStarter.free;
   fThreadRequests.free;
   fThreadPoolIO.free;
   //
	if assigned(fImageEnMIO) then
   	fImageEnMIO.free;
   if assigned(fImageEnProc) then
		fImageEnProc.free;
	// remove all objects
   while fImageInfo.Count>0 do
		DeleteImageNU(fImageInfo.Count-1);
   //
	fWallPaper.free;
	fTransition.free;
	fDestroying:=true;
	Deselect;
   fImageList.free;
   fCacheList.free;
   fImageInfo.free;
   IEDrawDibClose(fHDrawDib);
   fImageEnIO.free;
   fMultiSelectedImages.free;
   //
	fVScrollBarParams.free;
   fHScrollBarParams.free;
   fBackBuffer.free;
   fSoftShadow.free;
   inherited;
end;

procedure TImageEnMView.SetScrollBars(v:TScrollStyle);
begin
	fScrollBars:=v;
   if (GetParentForm(self)=nil) and (ParentWindow=0) then
      exit;
   if (fScrollBars=ssHorizontal) or (fScrollBars=ssBoth) then
 		ShowScrollBar(handle,SB_HORZ,false);
   if (fScrollBars=ssVertical) or (fScrollBars=ssBoth) then
	   ShowScrollBar(handle,SB_VERT,false);
   Update;
end;

procedure TImageEnMView.WMSize(var Message: TWMSize);
begin
  	inherited;
   Update;
end;

procedure TImageEnMView.WMEraseBkgnd(var Message:TMessage);
begin
	Message.Result:=0;
end;

procedure TImageEnMView.WMMouseWheel(var Message:TMessage);
var
	zDelta,nPos:integer;
   dir:integer;
begin
	inherited;
   zDelta:=smallint($ffff and (Message.wParam shr 16));
   if zDelta>0 then dir:=-1 else dir:=1;
   nPos:=fViewY+dir*(fThumbHeight+fVertBorder);
   SetViewY( nPos );
end;

procedure TImageEnMView.WMVScroll(var Message:TMessage);
var
	nPos:integer;
   mx,my:integer;
begin
	inherited;
	case Message.WParamLo of
	   SB_THUMBPOSITION,SB_THUMBTRACK:
      	begin
	      	if (not fVScrollBarParams.Tracking) and (Message.WParamLo=SB_THUMBTRACK) then
	         	exit;
	      	nPos:=trunc(Message.WParamHi*fRYScroll);
         end;
      SB_BOTTOM:
      	begin
         	GetMaxViewXY(mx,my);
	      	nPos:=my;
         end;
      SB_TOP:
      	nPos:=0;
      SB_LINEDOWN:
      	if fVScrollBarParams.LineStep=-1 then
	      	nPos:=fViewY+fThumbHeight+fVertBorder
         else
         	nPos:=fViewY+fVScrollBarParams.LineStep;
      SB_LINEUP:
			if fVScrollBarParams.LineStep=-1 then
	      	nPos:=fViewY-fThumbHeight-fVertBorder
         else
         	nPos:=fViewY-fVScrollBarParams.LineStep;
      SB_PAGEDOWN:
      	if fVScrollBarParams.PageStep=-1 then
      		nPos:=fViewY+ClientHeight
			else
         	nPos:=fViewY+fVScrollBarParams.PageStep;
      SB_PAGEUP:
      	if fVScrollBarParams.PageStep=-1 then
	      	nPos:=fViewY-ClientHeight
         else
         	nPos:=fViewY-fVScrollBarParams.PageStep;
      else
      	nPos:=fViewY;
   end;
   SetViewY( nPos );
end;

procedure TImageEnMView.WMHScroll(var Message:TMessage);
var
	nPos:integer;
   mx,my:integer;
begin
	inherited;
	case Message.WParamLo of
      SB_THUMBPOSITION,SB_THUMBTRACK:
      	begin
	      	if (not fHScrollBarParams.Tracking) and (Message.WParamLo=SB_THUMBTRACK) then
	         	exit;
	      	nPos:=trunc(Message.WParamHi*fRXScroll);
         end;
      SB_BOTTOM:
      	begin
         	GetMaxViewXY(mx,my);
	      	nPos:=mx;
         end;
      SB_TOP:
      	nPos:=0;
      SB_LINEDOWN:
      	if fHScrollBarParams.LineStep=-1 then
	      	nPos:=fViewX+fThumbWidth+fHorizBorder
         else
         	nPos:=fViewX+fVScrollBarParams.LineStep;
      SB_LINEUP:
      	if fVScrollBarParams.LineStep=-1 then
	      	nPos:=fViewX-fThumbWidth-fHorizBorder
         else
         	nPos:=fViewX-fVScrollBarParams.LineStep;
      SB_PAGEDOWN:
      	if fHScrollBarParams.PageStep=-1 then
	      	nPos:=fViewX+ClientWidth
         else
         	nPos:=fViewX+fVScrollBarParams.PageStep;
      SB_PAGEUP:
      	if fVScrollBarParams.PageStep=-1 then
	      	nPos:=fViewX-ClientWidth
         else
         	nPos:=fViewX-fVScrollBarParams.PageStep;
      else
      	nPos:=fViewX;
   end;
   SetViewX( nPos );
end;

// double click
procedure TImageEnMView.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
	fDoubleClicking:=true;
	inherited;
end;

procedure TImageEnMView.Assign(Source: TPersistent);
begin
	//
end;

procedure TImageEnMView.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
	inherited;
end;

procedure TImageEnMView.GetMaxViewXY(var mx,my:integer);
begin
	mx:=imax(fVWidth-ClientWidth,0);
   my:=imax(fVHeight-ClientHeight,0);
end;

procedure TImageEnMView.SetViewX(v:integer);
var
	max_x,max_y:integer;
begin
	if v=fViewX then exit;
	GetMaxViewXY(max_x,max_y);
   fViewX:=ilimit(v,0,max_x);
   invalidate;
   if (fScrollBars=ssHorizontal) or (fScrollBars=ssBoth) then
   	SetScrollPos(Handle,SB_HORZ,trunc(fViewX/fRXScroll),true);
end;

procedure TImageEnMView.SetViewY(v:integer);
var
	max_x,max_y:integer;
begin
	if v=fViewY then exit;
	GetMaxViewXY(max_x,max_y);
   fViewY:=ilimit(v,0,max_y);
   invalidate;
   if (fScrollBars=ssVertical) or (fScrollBars=ssBoth) then
   	SetScrollPos(Handle,SB_VERT,trunc(fViewY/fRYScroll),true);
end;

procedure TImageEnMView.SetViewXY(x,y:integer);
var
	max_x,max_y:integer;
begin
	if (x=fViewX) and (y=fViewY) then exit;
	GetMaxViewXY(max_x,max_y);
   fViewX:=ilimit(x,0,max_x);
   fViewY:=ilimit(y,0,max_y);
   invalidate;
   if (fScrollBars=ssHorizontal) or (fScrollBars=ssBoth) then
   	SetScrollPos(Handle,SB_HORZ,trunc(fViewX/fRXScroll),true);
   if (fScrollBars=ssVertical) or (fScrollBars=ssBoth) then
   	SetScrollPos(Handle,SB_VERT,trunc(fViewY/fRYScroll),true);
end;

procedure TImageEnMView.Paint;
begin
	if fLockPaint=0 then begin
   	if (fBackBuffer.Width<>ClientWidth) or (fBackBuffer.Height<>ClientHeight) then
      	fBackBuffer.Allocate(ClientWidth,ClientHeight,ie24RGB);
		PaintTo(fBackBuffer.VclBitmap);
      if gSystemColors<24 then begin
         // dithering needed (for example display with 16bit depth need dithering)
         SetStretchBltMode(Canvas.Handle,HALFTONE);
         StretchBlt(canvas.Handle,0,0,fBackBuffer.Width,fBackBuffer.Height,fBackBuffer.Canvas.Handle,0,0,fBackBuffer.Width,fBackBuffer.Height,SRCCOPY);
      end else begin
         // no dithering needed (fastest way)
         BitBlt(canvas.handle,0,0,fBackBuffer.Width,fBackBuffer.Height,fBackBuffer.Canvas.Handle,0,0,SRCCOPY);
      end;
   end;
   {$ifdef DEMOVERSION}
   _ctrlview(canvas);
   {$endif}
end;

function TImageEnMView.GetImageWidth(idx:integer):integer;
begin
	result:=0;
	if (idx>=0) and (idx<fImageInfo.Count) then
   	with PIEImageInfo(fImageInfo[idx])^ do
         if image<>nil then
         	result:=fImageList.GetImageWidth(image);
end;

function TImageEnMView.GetImageHeight(idx:integer):integer;
begin
	result:=0;
	if (idx>=0) and (idx<fImageInfo.Count) then
   	with PIEImageInfo(fImageInfo[idx])^ do
         if image<>nil then
				result:=fImageList.GetImageHeight(image);
end;

function TImageEnMView.GetImageOriginalWidth(idx:integer):integer;
begin
	result:=0;
	if (idx>=0) and (idx<fImageInfo.Count) then
   	with PIEImageInfo(fImageInfo[idx])^ do
         if image<>nil then
         	result:=fImageList.GetImageOriginalWidth(image);
end;

function TImageEnMView.GetImageOriginalHeight(idx:integer):integer;
begin
	result:=0;
	if (idx>=0) and (idx<fImageInfo.Count) then
   	with PIEImageInfo(fImageInfo[idx])^ do
         if image<>nil then
				result:=fImageList.GetImageOriginalHeight(image);
end;

procedure TImageEnMView.SetImageOriginalWidth(idx:integer; Value:integer);
begin
	if (idx>=0) and (idx<fImageInfo.Count) then
   	with PIEImageInfo(fImageInfo[idx])^ do
         if image<>nil then
         	fImageList.SetImageOriginalWidth(image,Value);
end;

procedure TImageEnMView.SetImageOriginalHeight(idx:integer; Value:integer);
begin
	if (idx>=0) and (idx<fImageInfo.Count) then
   	with PIEImageInfo(fImageInfo[idx])^ do
         if image<>nil then
         	fImageList.SetImageOriginalHeight(image,Value);
end;

function TImageEnMView.GetImageBitCount(idx:integer):integer;
begin
	result:=0;
	if (idx>=0) and (idx<fImageInfo.Count) then
   	with PIEImageInfo(fImageInfo[idx])^ do
         if image<>nil then
				result:=fImageList.GetImageBitCount(image);
end;

function TImageEnMView.GetImageY(idx:integer):integer;
begin
	if (idx>=0) and (idx<fImageInfo.Count) then
   	result:=PIEImageInfo(fImageInfo[idx])^.Y
   else
   	result:=0;
end;

function TImageEnMView.GetImageX(idx:integer):integer;
begin
	if (idx>=0) and (idx<fImageInfo.Count) then
   	result:=PIEImageInfo(fImageInfo[idx])^.X
   else
   	result:=0;
end;

function TImageEnMView.GetImageRow(idx:integer):integer;
begin
	if (idx>=0) and (idx<fImageInfo.Count) then
   	result:=PIEImageInfo(fImageInfo[idx])^.row
   else
   	result:=0;
end;

function TImageEnMView.GetImageCol(idx:integer):integer;
begin
	if (idx>=0) and (idx<fImageInfo.Count) then
   	result:=PIEImageInfo(fImageInfo[idx])^.col
   else
   	result:=0;
end;

// La stringa Name è trattata come PAnsiChar (null terminating string) per permettere
// path e nomi di file di lunghezza illimitata
// Pone ID=-1
procedure TImageEnMView.SetImageFileName(idx:integer; v:string);
begin
	if (idx>=0) and (idx<fImageInfo.Count) then
   	with PIEImageInfo(fImageInfo[idx])^ do begin
      	if assigned(Name) then
         	freemem(Name);
         getmem(Name,length(v)+1);
			strcopy(Name,PAnsiChar(v));
         ID:=-1;
      end;
end;

function TImageEnMView.GetImageFileName(idx:integer):string;
begin
	if (idx>=0) and (idx<fImageInfo.Count) then
		result:=PIEImageInfo(fImageInfo[idx])^.Name
   else
   	result:='';
end;

// set name=''
procedure TImageEnMView.SetImageID(idx,v:integer);
begin
	if (idx>=0) and (idx<fImageInfo.Count) then
   	with PIEImageInfo(fImageInfo[idx])^ do begin
			ID:=v;
         freemem(Name);
         Name:=nil;
	   end;
end;

function TImageEnMView.GetImageID(idx:integer):integer;
begin
	if (idx>=0) and (idx<fImageInfo.Count) then
		result:=PIEImageInfo(fImageInfo[idx])^.ID
   else
   	result:=-1;
end;

procedure TImageEnMView.SetImageBackground(idx:integer; v:TColor);
begin
	if (idx>=0) and (idx<fImageInfo.Count) then begin
   	PIEImageInfo(fImageInfo[idx])^.Background:=v;
      Update;
   end;
end;

function TImageEnMView.GetImageBackground(idx:integer):TColor;
begin
	if (idx>=0) and (idx<fImageInfo.Count) then
   	result:=PIEImageInfo(fImageInfo[idx])^.Background
   else
   	result:=0;
end;

procedure TImageEnMView.SetImageDelayTime(idx:integer; v:integer);
begin
	if (idx>=0) and (idx<fImageInfo.Count) then
   	PIEImageInfo(fImageInfo[idx])^.DTime:=v;
end;

function TImageEnMView.GetImageDelayTime(idx:integer):integer;
begin
	if (idx>=0) and (idx<fImageInfo.Count) then
   	result:=PIEImageInfo(fImageInfo[idx])^.DTime
   else
   	result:=0;
end;

procedure TImageEnMView.SetThumbWidth(v:integer);
begin
	fThumbWidth:=v;
   ClearCache;
   Update;
end;

procedure TImageEnMView.SetThumbHeight(v:integer);
begin
	fThumbHeight:=v;
   ClearCache;
   Update;
end;

function TImageEnMView.GetImageCount:integer;
begin
	result:=fImageInfo.Count;
end;

procedure TImageEnMView.SetHorizBorder(v:integer);
begin
	fHorizBorder:=v;
   Update;
end;

procedure TImageEnMView.SetVertBorder(v:integer);
begin
	fVertBorder:=v;
   Update;
end;

// recalc x,y image positions
// update fVWidth and fVHeight
procedure TImageEnMView.UpdateCoords;
var
	q,xx,yy,gw:integer;
begin
	if fGridWidth=-1 then
		gw:=(clientwidth-fHorizBorder) div (fThumbWidth+fHorizBorder)
   else
		gw:=fGridWidth;
   xx:=0;
   yy:=0;
   fVWidth:=0;
   fVHeight:=0;
	for q:=0 to fImageInfo.Count-1 do begin
		with PIEImageInfo(fImageInfo[q])^ do begin
         x:=xx*(fThumbWidth+fHorizBorder);
         y:=yy*(fThumbHeight+fVertBorder);
      	if fDisplayMode=mdGrid then begin
            inc(x,HorizBorder);
            inc(y,VertBorder);
      	end;
         row:=yy;
         col:=xx;
         if x>fVWidth then fVWidth:=x;
         if y>fVHeight then fVHeight:=y;
      end;
      // calculates next position
      inc(xx);
      if (fDisplayMode=mdSingle) or (xx=gw) then begin
         // horizontal limit, clear column, go to next row
         xx:=0;
         inc(yy);
         if fDisplayMode=mdSingle then begin
            // vertical limit, go back to top-left side
            yy:=0;
            xx:=0;
         end;
      end;
   end;
   inc(fVWidth,fThumbWidth+fHorizBorder);
   inc(fVHeight,fThumbHeight+fVertBorder);
end;

// Insert new image
// idx è l'indice dell'immagine al posto della quale va inserita la nuova
// Se idx è uguale a ImageCount viene aggiunta alla fine
// La bitmap (Image[]) viene creata come "nil"
// La posizione della bitmap è decisa in base a fHorizImages e fVertImages
// Chiama Update
// L'immagine viene selezionata
// Disattiva player
procedure TImageEnMView.InsertImage(idx:integer);
var
   newinfo:PIEImageInfo;
begin
	SetPlaying(false);
   getmem(newinfo,sizeof(TIEImageInfo));
   newinfo^.name:=nil;
   newinfo^.ID:=-1;
   newinfo^.Background:=fBackground;
   newinfo^.DTime:=0;
   newinfo^.image:=nil;
   newinfo^.TopText:=TIEMText.Create(self,iemtpTop);
   newinfo^.BottomText:=TIEMText.Create(self,iemtpBottom);
   newinfo^.InfoText:=TIEMText.Create(self,iemtpInfo);
   newinfo^.cacheImage:=nil;
   newinfo^.parent:=self;
   if idx<fImageInfo.Count then begin
   	// insert
      fImageInfo.Insert(idx,newinfo);	// info
      SetSelectedItemNU(idx);
   end else begin
   	// append
      fImageInfo.Add(newinfo); // info
      SetSelectedItemNU(fImageInfo.Count-1);
   end;
	fLastImOp:=1;	// insert...
   fLastImIdx:=fSelectedItem;	//...image
   CallBitmapChangeEvents;
	Update;
end;

// Insert a new image
// idx è l'indice dell'immagine al posto della quale va inserita la nuova
// Se idx è uguale a ImageCount viene aggiunta alla fine
// La bitmap (Image[]) viene creata come "nil"
// La posizione della bitmap è decisa in base a fHorizImages e fVertImages
// Chiama Update
// L'immagine NON viene selezionata
// Disattiva player
procedure TImageEnMView.InsertImageEx(idx:integer);
var
   newinfo:PIEImageInfo;
begin
	SetPlaying(false);
   getmem(newinfo,sizeof(TIEImageInfo));
   newinfo^.name:=nil;
   newinfo^.ID:=-1;
   newinfo^.Background:=fBackground;
   newinfo^.DTime:=0;
   newinfo^.image:=nil;
   newinfo^.TopText:=TIEMText.Create(self,iemtpTop);
   newinfo^.BottomText:=TIEMText.Create(self,iemtpBottom);
   newinfo^.InfoText:=TIEMText.Create(self,iemtpInfo);
   newinfo^.cacheImage:=nil;
   newinfo^.parent:=self;
   if idx<fImageInfo.Count then begin
   	// insert
      fImageInfo.Insert(idx,newinfo);	// info
   end else begin
   	// append
      fImageInfo.Add(newinfo); // info
   end;
	fLastImOp:=1;	// insert...
   fLastImIdx:=idx;	//...image
   CallBitmapChangeEvents;
	Update;
end;

// Come InsertImage(ImageCount), rest. indice immagine inserita
function TImageEnMView.AppendImage:integer;
begin
   result:=fImageInfo.Count;
   InsertImage(fImageInfo.Count);
end;

// Delete image idx
// doesn't call Update
// Return true if image correctly deleted
// Disable playing
function TImageEnMView.DeleteImageNU(idx:integer):boolean;
var
	psel:integer;
begin
	SetPlaying(false);
	if idx<fImageInfo.Count then begin
   	psel:=fSelectedItem;
      DeselectNU;
      if PIEImageInfo(fImageInfo[idx])^.image<>nil then begin
	      fImageList.Delete( PIEImageInfo(fImageInfo[idx])^.image );
			ClearImageCache( idx );
      end;
      with PIEImageInfo(fImageInfo[idx])^ do begin
         // free file name (PAnsiChar)
         if assigned( Name ) then
            freemem(Name);
         TopText.free;
         BottomText.free;
         InfoText.free;
      end;
      // free imageinfo
      freemem( fImageInfo[idx] );
      fImageInfo.Delete(idx);
      //
      if (psel=idx) and (idx>=fImageInfo.Count) then
        	SetSelectedItemNU(fImageInfo.Count-1)
      else if psel>idx then
      	SetSelectedItemNU(psel-1)
      else
      	SetSelectedItemNU(psel);
      //
      fLastImOp:=2;	// delete...
      fLastImIdx:=idx;	//...image
      CallBitmapChangeEvents;
      result:=true;
   end else
   	result:=false;
end;

procedure TImageEnMView.DeleteSelectedImages;
var
	q:integer;
   cp:TList;
	//
   function Compare(Item1, Item2: Pointer): Integer;
	begin
   	result:= integer(Item1)-integer(Item2);
   end;
   //
begin
	fMultiSelectedImages.Sort(@Compare);
   cp:=TList.Create;
   for q:=0 to fMultiSelectedImages.Count-1 do
   	cp.Add( fMultiSelectedImages[q] );
   for q:=cp.Count-1 downto 0 do begin
      DeleteImageNU( integer(cp[q]) );
   end;
   cp.free;
   Update;
end;

// delete image idx
procedure TImageEnMView.DeleteImage(idx:integer);
begin
	if DeleteImageNU(idx) then
      Update;
end;

// Questa funzione è chiamata ogni volta che varia lo zoom o viewx/y
// A sua volta richiama fOnViewChange
procedure TImageEnMView.ViewChange(c:integer);
begin
   if assigned(fOnViewChange) then
  		fOnViewChange(self,c);
end;

// this calls UpdateCoords
procedure TImageEnMView.Update;
var
    max_x,max_y,i:integer;
    lClientWidth,lClientHeight:integer;
    bb:boolean;
begin
	if fLockPaint>0 then
   	exit;
	if fUpdating then
   	exit;
   if fDestroying then
   	exit;
   {$ifdef IEFIXUPDATE}
   if (ComponentState<>[]) and (ComponentState<>[csDesigning]) and (ComponentState<>[csFreeNotification]) then
      exit;
   {$else}
   if (ComponentState<>[]) and (ComponentState<>[csDesigning]) then
      exit;
   {$endif}
   if (GetParentForm(self)=nil) and (ParentWindow=0) then
      exit;
   if not (csDesigning in ComponentState) then begin
   	fUpdating:=true;
      ClearCache;
      UpdateCoords;
      for i:=0 to 8 do begin
         lClientWidth:=ClientWidth;
         lClientHeight:=ClientHeight;
         bb:=false;
         GetMaxViewXY(max_x,max_y);
         if fViewX>max_x then begin
            fViewX:=max_x;
            bb:=true;
         end;
         if fViewY>max_y then begin
            fViewY:=max_y;
            bb:=true;
         end;
         if bb then
            ViewChange(0);
         try
         if (fScrollBars=ssHorizontal) or (fScrollBars=ssBoth) then begin
            if (max_x>0) then begin
               fRXScroll:=(max_x+ClientWidth-1)/65536;
               SetScrollRange(Handle,SB_HORZ,0,65535,false);
               SetSBPageSize(Handle,SB_HORZ, trunc(ClientWidth/fRXScroll),true);
               SetScrollPos(Handle,SB_HORZ,trunc(fViewX/fRXScroll),false);
               EnableScrollBar(Handle,SB_HORZ,ESB_ENABLE_BOTH);
               ShowScrollBar(handle,SB_HORZ,true);
            end else if fScrollBarsAlwaysVisible then begin
               EnableScrollBar(Handle,SB_HORZ,ESB_DISABLE_BOTH);
               ShowScrollBar(handle,SB_HORZ,true);
            end else
               ShowScrollBar(handle,SB_HORZ,false);
         end;
         if (fScrollBars=ssVertical) or (fScrollBars=ssBoth) then begin
            if (max_y>0) then begin
               fRYScroll:=(max_y+ClientHeight-1)/65536;
               SetScrollRange(Handle,SB_VERT,0,65535,false);
               SetSBPageSize(Handle,SB_VERT, trunc(ClientHeight/fRYScroll),true);
               SetScrollPos(Handle,SB_VERT,trunc(fViewY/fRYScroll),false);
               EnableScrollBar(Handle,SB_VERT,ESB_ENABLE_BOTH);
               ShowScrollBar(handle,SB_VERT,true);
            end else if fScrollBarsAlwaysVisible then begin
               EnableScrollBar(Handle,SB_VERT,ESB_DISABLE_BOTH);
               ShowScrollBar(handle,SB_VERT,true);
            end else
               ShowScrollBar(handle,SB_VERT,false);
         end;
         except
         end;
         if (lClientWidth=ClientWidth) and (lClientHeight=ClientHeight) then
         	break;	// exit from for loop (no other adjustments necessary)
      end;
      CallBitmapChangeEvents;
	   fUpdating:=false;
   end;
   invalidate;
   redrawwindow(handle,nil,0,  RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN	);
end;

function TImageEnMView.PaletteChanged(Foreground: Boolean): Boolean;
begin
	{$ifndef OCXVERSION}
   if assigned(application) and assigned(application.mainform) and assigned(application.mainform.canvas) then begin
	   if IEDrawDibRealize(fHDrawDib,application.mainform.canvas.handle,false)>0 then
	   	invalidate;
   end else
   	invalidate;
   {$else}
   invalidate;
	{$endif}
   result:=true;
end;

procedure TImageEnMView.SetBackGround(cl:TColor);
begin
	inherited SetBackGround(cl);
   Update;
end;

procedure TImageEnMView.SetImageEx(idx:integer; v:TBitmap);
var
   tbmp:TIEBitmap;
begin
	if v<>nil then begin
      tbmp:=TIEBitmap.Create;
      tbmp.EncapsulateTBitmap(v,true);
      SetIEBitmapEx(idx,tbmp);
      tbmp.free;
   end;
end;

procedure TImageEnMView.SetIEBitmap(idx:integer; v:TIEBaseBitmap);
begin
	if v<>nil then begin
		SetIEBitmapEx(idx,v);
   	Update;
   end;
end;

// Viene effettuata una copia di v (percio' v dopo può essere liberato)
// Non chiama update
procedure TImageEnMView.SetIEBitmapEx(idx:integer; v:TIEBaseBitmap);
var
	bmp:TIEBitmap;
   ww,hh:integer;
begin
	if v<>nil then begin
      if (idx>-1) and (idx<fImageInfo.Count) then begin
         if PIEImageInfo(fImageInfo[idx])^.image<>nil then begin
            fImageList.Delete( PIEImageInfo(fImageInfo[idx])^.image );
            ClearImageCache( idx );
         end;
         if (fStoreType=ietThumb) and (fEnableResamplingOnMinor or (v.Width>fThumbWidth) or (v.Height>fThumbHeight)) then begin
            if (v.width=0) or (v.height=0) then begin
               ww:=fThumbWidth;
               hh:=fThumbHeight;
            end else
               IEFitResample(v.width,v.height,fThumbWidth,fThumbHeight,ww,hh);
            if (v.Width<>ww) or (v.Height<>hh) then begin
               bmp:=TIEBitmap.Create;
               bmp.allocate(ww,hh,ie24RGB);

               if (v as TIEBitmap).HasAlphaChannel then
               	_IESetAlpha0Color(v as TIEBitmap,CreateRGB(128,128,128));
               if v.pixelformat=ie1g then begin
                  _SubResample1bitFilteredEx(v,0,0,v.width-1,v.height-1,bmp)
               end else begin
                  if fThumbnailResampleFilter=rfNone then
                     _IEBmpStretchEx(v,bmp,nil,nil)
                  else begin
                     _ResampleEx(v,bmp,fThumbnailResampleFilter,nil,nil);
                  end;
               end;
               if (v is TIEBitmap) and (v as TIEBitmap).HasAlphaChannel then begin
                  if fThumbnailResampleFilter=rfNone then
                     _resamplealphaex((v as TIEBitmap).AlphaChannel,bmp.AlphaChannel,rfFastLinear)
                  else
                     _resamplealphaex((v as TIEBitmap).AlphaChannel,bmp.AlphaChannel,fThumbnailResampleFilter);
                  bmp.AlphaChannel.Full:=(v as TIEBitmap).AlphaChannel.Full;
               end;

               PIEImageInfo(fImageInfo[idx])^.image:=fImageList.AddIEBitmap(bmp);
               bmp.free;
            end else
               PIEImageInfo(fImageInfo[idx])^.image:=fImageList.AddIEBitmap(v);
         end else begin
            PIEImageInfo(fImageInfo[idx])^.image:=fImageList.AddIEBitmap(v);
         end;
         fImageList.SetImageOriginalWidth( PIEImageInfo(fImageInfo[idx])^.image , v.Width );
         fImageList.SetImageOriginalHeight( PIEImageInfo(fImageInfo[idx])^.image , v.Height );
      end;
      if idx=fSelectedItem then begin
         fSelectedBitmap:=nil;
         //fSelectedBitmap:=GetBitmap(fSelectedItem);
         CallBitmapChangeEvents;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMView.SetImage(idx:integer; v:TBitmap);
begin
	SetImageEx(idx,v);
   Update;
end;

// Viene effettuata una copia di v (perciò v dopo può essere liberato)
procedure TImageEnMView.SetImageRect(idx:integer; v:TBitmap; x1,y1,x2,y2:integer);
begin
	if idx<fImageInfo.Count then begin
      x1:=imin(v.width-1,x1);
      y1:=imin(v.height-1,y1);
      x2:=imin(v.width-1,x2);
      y2:=imin(v.height-1,y2);
      if PIEImageInfo(fImageInfo[idx])^.image<>nil then begin
	      fImageList.Delete( PIEImageInfo(fImageInfo[idx])^.image );
         ClearImageCache( idx );
      end;
     	PIEImageInfo(fImageInfo[idx])^.image:=fImageList.AddBitmapRect(v,x1,y1,x2-x1+1,y2-y1+1);
      fImageList.SetImageOriginalWidth( PIEImageInfo(fImageInfo[idx])^.image , v.Width );
      fImageList.SetImageOriginalHeight( PIEImageInfo(fImageInfo[idx])^.image , v.Height );
	   if idx=fSelectedItem then begin
		   //fSelectedBitmap:=GetBitmap(fSelectedItem);
         fSelectedBitmap:=nil;
         CallBitmapChangeEvents;
      end;
      Update;
   end;
end;

// returns image index at x,y position
// -1 no image
function TImageEnMView.ImageAtPos(x,y:integer):integer;
var
   ix,iy:integer;
   x1,y1,x2,y2:integer;
   info:PIEImageInfo;
begin
   ix:=(x+fViewX) div (fHorizBorder+fThumbWidth);
   iy:=(y+fViewY) div (fVertBorder+fThumbHeight);
   result:=ImageAtGridPos(iy,ix);
   if result>=fImageInfo.Count then result:=-1;
   if result>=0 then begin
      // verify if inside the thumbnail rectangle
      info:=PIEImageInfo(fImageInfo[result]);
      x1:=info^.X-fViewX;
      y1:=info^.Y-fViewY;
      x2:=x1+fThumbWidth-1;
      y2:=y1+fThumbHeight;
      if not _InRect(x,y,x1,y1,x2,y2) then
         result:=-1;
   end;
end;

function TImageEnMView.ImageAtGridPos(row,col:integer):integer;
var
	gw:integer;
begin
	if fGridWidth=-1 then
		gw:=(clientwidth-fHorizBorder) div (fThumbWidth+fHorizBorder)
   else
		gw:=fGridWidth;
	result:=row*gw+col;
end;

// return =fImageInfo.Count if after last thumbnail
function TImageEnMView.InsertingPoint(x,y:integer):integer;
var
   ix,iy,gw:integer;
begin
   ix:=(x+fViewX) div (fHorizBorder+fThumbWidth);
   iy:=(y+fViewY) div (fVertBorder+fThumbHeight);
	if fGridWidth=-1 then
		gw:=(clientwidth-fHorizBorder) div (fThumbWidth+fHorizBorder)
   else
		gw:=fGridWidth;
   if (gw>0) and (ix>gw) then ix:=gw;
   result:=imin(iy*gw+ix,fImageInfo.Count);	// not fImageInfo.Count-1 !!
end;

procedure TImageEnMView.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	inherited;
   if fDoubleClicking then begin
   	fDoubleClicking:=false;
      exit;
   end;
   {$ifdef OCXVERSION}
   SetFocus;
   {$else}
   if CanFocus then
	   SetFocus;
   {$endif}
	fHSX1:=x;
   fHSY1:=y;
   fHSVX1:=ViewX;
   fHSVY1:=ViewY;
   fHSIDX:=ImageAtPos(x,y);
   fLHSIDX:=fHSIDX;
   fHaveMultiselected:=false;
   fMDown:=true;
   if not (iemoSelectOnMouseUp in fMultiSelectionOptions) and (Button=mbLeft) and (mmiSelect in fMouseInteract) then begin
   	// select on mouse down
   	SelectAtPos(X,Y,Shift);
	end;
end;

procedure TImageEnMView.MouseMove(Shift: TShiftState; X, Y: Integer);
var
	lSelectInclusive:boolean;
   lMultiSelecting:boolean;
   idx:integer;
begin
	inherited;
   if MouseCapture then begin
   	if (mmiSelect in fMouseInteract) and fEnableMultiSelect then begin
         idx:=ImageAtPos(x,y);
         if idx<>fLHSIDX then begin
            fLHSIDX:=idx;
         	idx:=fHSIDX;
            if idx<0 then idx:=0;
            lSelectInclusive:=fSelectInclusive;
            lMultiSelecting:=fMultiSelecting;
            fMultiSelecting:=false;
            fSelectInclusive:=true;
            DeselectNU;
            SetSelectedItemNU(idx);
            fMultiSelecting:=lMultiSelecting;
            SelectAtPos(X,Y,[ssShift]);
            fSelectInclusive:=lSelectInclusive;
            fHaveMultiselected:=true;
         end;
      end;
   	if mmiScroll in fMouseInteract then
			SetViewXY(fHSVX1-(X-fHSx1),fHSVY1-(Y-fHSy1))
   end;
end;

procedure TImageEnMView.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	inherited;
   if not fMDown then exit;
   fMDown:=false;
   if fPlaying then exit;
   if Button=mbLeft then begin
      if (iemoSelectOnMouseUp in fMultiSelectionOptions) and (not fHaveMultiselected) and (mmiSelect in fMouseInteract) then
         SelectAtPos(X,Y,Shift);
      if (mmiScroll in fMouseInteract) then
         SetViewXY(fHSVX1-(X-fHSx1),fHSVY1-(Y-fHSy1))
   end;
end;

procedure TImageEnMView.SelectAtPos(X,Y:integer; Shift:TShiftState);
var
	idx,q,col,row:integer;
   lMultiSelecting:boolean;
   row1,row2,col1,col2:integer;
begin
   // find the image where user has clicked (put in fSelectedItem)
   lMultiSelecting:=fMultiSelecting;
   if (ssCtrl in Shift) or (ssShift in Shift) then
      fMultiSelecting:=true;
   idx:=ImageAtPos(x,y);
   if idx>=0 then begin
      if (idx<>fSelectedItem) or (fMultiSelecting and fEnableMultiSelect) then begin
         if ssShift in Shift then begin
            // SHIFT pressed, select range
            if iemoRegion in fMultiSelectionOptions then begin
            	row1:=ImageRow[fSelectedItem];
               row2:=ImageRow[idx];
               col1:=ImageCol[fSelectedItem];
               col2:=ImageCol[idx];
               if row1>row2 then iswap(row1,row2);
               if col1>col2 then iswap(col1,col2);
               for row:=row1 to row2 do
                  for col:=col1 to col2 do begin
                     q:=ImageAtGridPos(row,col);
                     if (q<>fSelectedItem) and (q<>idx) and (fMultiSelectedImages.IndexOf(pointer(q))=-1) then
                        SetSelectedItemNU(q);
                  end;
            end else begin
               if fSelectedItem<idx then begin
                  for q:=fSelectedItem+1 to idx-1 do
                     if fMultiSelectedImages.IndexOf(pointer(q))=-1 then
                        SetSelectedItemNU(q);
               end else begin
                  for q:=fSelectedItem-1 downto idx+1 do
                     if fMultiSelectedImages.IndexOf(pointer(q))=-1 then
                        SetSelectedItemNU(q);
               end;
            end;
         end;
      end;
      SetSelectedItemNU(idx);
      if fVisibleSelection then
         Update;
      if assigned(fOnImageSelect) then
         fOnImageSelect(self,fSelectedItem);
      CallBitmapChangeEvents;
   end;
   fMultiSelecting:=lMultiSelecting;
end;

procedure TImageEnMView.SetVisibleSelection(v:boolean);
begin
	fVisibleSelection:=v;
   Update;
end;

procedure TImageEnMView.SetSelectionWidth(v:integer);
begin
	fSelectionWidth:=v;
   Update;
end;

procedure TImageEnMView.SetSelectionColor(v:TColor);
begin
	fSelectionColor:=v;
   Update;
end;

procedure TImageEnMView.BeginSelectImages;
begin
	DeselectNU;
	fSelectImages:=true;
   fMultiSelecting:=true;
end;

procedure TImageEnMView.EndSelectImages;
begin
	fSelectImages:=false;
   fMultiSelecting:=false;
   if fMultiSelectedImages.Count>0 then begin
      fSelectedItem:=integer(fMultiSelectedImages[fMultiSelectedImages.Count-1]);	// select last selected image
      //fSelectedBitmap:=GetBitmap(fSelectedItem);
      fSelectedBitmap:=nil;
   end;
   CallBitmapChangeEvents;
   Update;
end;

procedure TImageEnMView.SetSelectedItem(v:integer);
begin
	if fPlaying then exit;
	SetSelectedItemNU(v);
   if not fSelectImages then begin
      Update;
      if assigned(fOnImageSelect) then
         fOnImageSelect(self,fSelectedItem);
   end;
end;

// doesn't call Update
// indexes that isn't inside bounds are ignored
procedure TImageEnMView.SetSelectedItemNU(v:integer);
var
	q:integer;
begin
	if fPlaying then exit;
	if (v<fImageInfo.Count) and (v>=0) then begin
   	if fSelectedItem>=0 then begin
      	if fSelectedBitmap<>nil then
      		fImageList.ReleaseBitmap( fSelectedBitmap, true );
 			ClearImageCache( fSelectedItem );
      end;
      if fEnableMultiSelect then begin
	      if not fMultiSelecting then begin
		      fMultiSelectedImages.clear;
         end else begin
         	if not fSelectImages then begin
               q:=fMultiSelectedImages.IndexOf(pointer(v));
               if q>-1 then begin
                  // item already selected, unselect when fMultiSelecting is True
                  fMultiSelectedImages.Delete(q);
                  if not fSelectInclusive then begin
                     fSelectedItem:=-1;
                     EXIT;	// EXIT POINT!!
                  end;
               end;
            end;
         end;
         fMultiSelectedImages.Add(pointer( v ));
      end;
      if fSelectImages then begin
      	// inside BeginSelectImages...EndSelectimages the SelectedItem doesn't change (also fSelectedBitmap doesn't change)
      	fSelectedItem:=-1;
      end else begin
			fSelectedItem:=v;
	      //fSelectedBitmap:=GetBitmap(fSelectedItem);
         fSelectedBitmap:=nil;
         CallBitmapChangeEvents;
      end;
   end;
end;

procedure TImageEnMView.Deselect;
begin
	DeselectNU;
   Update;
end;

// doesn't call Update
procedure TImageEnMView.DeselectNU;
begin
   if fSelectedItem>=0 then begin
   	fImageList.ReleaseBitmapByImage( PIEImageInfo(fImageInfo[fSelectedItem])^.image, true );
		ClearImageCache( fSelectedItem );
   end;
	fSelectedItem:=-1;
   if fEnableMultiSelect then
		fMultiSelectedImages.clear;
end;

procedure TImageEnMView.UnSelectImage(idx:integer);
begin
	if (idx>=0) and (idx<ImageCount) then begin
      if idx=fSelectedItem then begin
         fImageList.ReleaseBitmapByImage( PIEImageInfo(fImageInfo[fSelectedItem])^.image, true );
			ClearImageCache( fSelectedItem );
         fMultiSelectedImages.Remove(pointer(idx));
         fSelectedItem:=-1;
      end else begin
      	fMultiSelectedImages.Remove(pointer(idx));
      end;
   end;
   Update;
end;

procedure TImageEnMView.CopyToIEBitmap(idx:integer; bmp:TIEBitmap);
begin
   with PIEImageInfo(fImageInfo[idx])^ do begin
      // transform hbi to TBitmap object
      if image=nil then
         ObtainImageNow(idx);
      if image<>nil then begin
         // image present
         fImageList.CopyToIEBitmap(image,bmp);
      end;
   end;
end;

function TImageEnMView.GetBitmap(idx:integer):TBitmap;
begin
	result:=nil;
   with PIEImageInfo(fImageInfo[idx])^ do begin
      // transform hbi to TBitmap object
      if image=nil then
         ObtainImageNow(idx);
      if image<>nil then begin
         // image present
         result:=fImageList.GetBitmap(image).VclBitmap;
      end;
   end;
end;

function TImageEnMView.GetTIEBitmap(idx:integer):TIEBitmap;
begin
	result:=nil;
   with PIEImageInfo(fImageInfo[idx])^ do begin
      // transform hbi to TBitmap object
      if image=nil then
         ObtainImageNow(idx);
      if image<>nil then begin
         // image present
         result:=fImageList.GetBitmap(image);
      end;
   end;
end;

procedure TImageEnMView.ReleaseBitmap(idx:integer);
begin
	fImageList.ReleaseBitmapByImage( PIEImageInfo(fImageInfo[idx])^.image, true );
   ClearImageCache( idx );
end;

// Make sure that at index "idx" there is a valid image (load from FileName or request it using ID).
// Returns true if the image load is ok, false otherwise
function TImageEnMView.ObtainImageNow(idx:integer):boolean;
var
	info:PIEImageInfo;
   bmp:TBitmap;
   iebmp:TIEBitmap;
begin
	EnterCriticalSection(gThreadCS);
	result:=true;
	bmp:=nil;
  	info:=PIEImageInfo(fImageInfo[idx]);
   if (info^.ID>-1) and assigned(fOnImageIDRequest) then begin
      // request by ID
      bmp:=nil;
      fOnImageIDRequest(self,info^.ID,bmp);
      SetImageEx(idx,bmp);
   end else if (info^.ID>-1) and assigned(fOnImageIDRequestEx) then begin
      // request by ID
      iebmp:=nil;
      fOnImageIDRequestEx(self,info^.ID,iebmp);
      SetIEBitmapEx(idx,iebmp);
   end else if assigned(info^.Name) then begin
      // load from 'Name'
      iebmp:=TIEBitmap.Create;
      fImageEnIO.Background:=info^.Background;
      fImageEnIO.attachediebitmap:=iebmp;
      fImageEnIO.OnProgress:=fOnIOProgress;
      if fStoreType=ietThumb then begin
	      fImageEnIO.Params.JPEG_Scale:=IOJPEG_AUTOCALC;
         fImageEnIO.Params.Width:=fThumbWidth;
         fImageEnIO.Params.Height:=fThumbHeight;
      end else
			fImageEnIO.Params.JPEG_Scale:=IOJPEG_FULLSIZE;
      try
      fImageEnIO.LoadFromFile(info^.Name);
      except
      	fImageEnIO.Aborting:=true;
      end;
      //
      if fImageEnIO.Aborting then begin
      	DoWrongImage(iebmp,idx);
			result:=false;
      end;
      // updates params of encapsulated TImageEnMIO object
      GetImageEnMIO.Params[idx].Assign( fImageEnIO.Params );   // GetImageEnMIO creates TImageEnMIO if it doesn't exist
      // set the image
      info^.Background:=fImageEnIO.Background;
      SetIEBitmapEx(idx,iebmp);
      if fImageEnIO.Params.FileType=ioJPEG then begin
         ImageOriginalWidth[idx]:=fImageEnIO.Params.JPEG_OriginalWidth;
         ImageOriginalHeight[idx]:=fImageEnIO.Params.JPEG_OriginalHeight;
      end else begin
         ImageOriginalWidth[idx]:=fImageEnIO.Params.Width;
         ImageOriginalHeight[idx]:=fImageEnIO.Params.Height;
      end;
		//
      fImageEnIO.attachediebitmap:=nil;
      iebmp.free;
   end;
   LeaveCriticalSection(gThreadCS);
end;

// remove available threads or threads that want to load a no more invisible image
procedure FreeUseLessThreads(mview:TImageEnMView);
var
   i:integer;
begin
	i:=0;
   with mview do
      while i<fThreadPoolIO.Count do begin
         if TImageEnIO(fThreadPoolIO[i]).Tag=-1 then begin
            // finished thread
            TImageEnIO(fThreadPoolIO[i]).IEBitmap.free;
            TImageEnIO(fThreadPoolIO[i]).AttachedIEBitmap:=nil;
            TImageEnIO(fThreadPoolIO[i]).free;
            fThreadPoolIO.delete(i);
         end else if (TImageEnIO(fThreadPoolIO[i]).Tag>=0) and (not IsVisible(TImageEnIO(fThreadPoolIO[i]).Tag)) then begin
            // invisible image
            TImageEnIO(fThreadPoolIO[i]).Tag:=-2;	// -2 controlled abort
            TImageEnIO(fThreadPoolIO[i]).Aborting:=true;
            inc(i);
         end else
         	inc(i);
      end;
end;

procedure FreeInvisibleRequests(mview:TImageEnMView);
var
   i:integer;
begin
	i:=0;
   with mview do
	   while i<fThreadRequests.Count do begin
      	if not IsVisible(integer(fThreadRequests[i])) then
         	fThreadRequests.delete(i)
         else
         	inc(i);
      end;
end;

// return false if info^.ID>-1 and assigned OnImageIDRequest. Works only with info^.Name (FileName)
// return falso if fThreadPoolIO.Count>=fThreadPoolSize
function TImageEnMView.ObtainImageThreaded(idx:integer):boolean;
var
	info:PIEImageInfo;
   i:integer;
begin
	try
	EnterCriticalSection(gThreadCS);
   info:=PIEImageInfo(fImageInfo[idx]);
   if info^.image<>nil then begin
   	result:=true;
   	exit;
   end;
   // free no more visible requests
   FreeInvisibleRequests(self);
   // check if already requested
   for i:=0 to fThreadRequests.Count-1 do begin
      if integer(fThreadRequests[i])=idx then begin
         // already requested
         result:=true;
         exit;
      end;
   end;
   // check if processing it
   for i:=0 to fThreadPoolIO.Count-1 do
      if TImageEnIO(fThreadPoolIO[i]).Tag=idx then begin
         // already in progress
         result:=true;
         exit;
      end;
   // free available threads
   FreeUseLessThreads(self);
   //
	result:=false;
   if (info^.ID>-1) and assigned(fOnImageIDRequest) then begin
      // request by ID, it is better to use ObtainImageNow
      exit;
   end else if (info^.ID>-1) and assigned(fOnImageIDRequestEx) then begin
      // request by ID, it is better to use ObtainImageNow
      exit;
   end else if assigned(info^.Name) then begin
      // Load from 'Name'.
      // Add this request to the requests list.
      fThreadRequests.Add(pointer(idx));
      result:=true;
      exit;
   end;
   finally
      if fThreadStarter.Suspended then
     	   fThreadStarter.Resume;
   	LeaveCriticalSection(gThreadCS);
   end;
end;

procedure TImageEnMView.DoWrongImage(OutBitmap:TIEBitmap; idx:integer);
var
   OBitmap:TIEDibBitmap;
   cv:TCanvas;
   Handled:boolean;
   ww,hh:integer;
begin
   Handled:=false;
   if assigned(fOnWrongImage) then begin
      OutBitmap.Allocate(fThumbWidth,fThumbHeight,ie24RGB);
      fOnWrongImage(self,OutBitmap,idx,Handled);
   end;
   if not Handled then begin
     	OBitmap:=TIEDibBitmap.Create;
      OBitmap.AllocateBits(fThumbWidth,fThumbHeight,24);
      cv:=TCanvas.Create;
      cv.Handle:=OBitmap.HDC;
      cv.Brush.Color:=clWhite;
      cv.Brush.Style:=bsSolid;
      cv.FillRect(rect(0,0,OBitmap.Width,OBitmap.Height));
      cv.Font.Name:='Arial';
      cv.Font.Size:=fThumbHeight;
      cv.Font.Style:=[fsBold];
      ww:=cv.TextWidth('?');
      hh:=cv.TextHeight('?');
      cv.Font.Color:=clGray;
      cv.Brush.Style:=bsClear;
      cv.TextOut((integer(OBitmap.Width)-ww)div 2+3,(integer(OBitmap.Height)-hh) div 2+3,'?');
      cv.Font.Color:=clBlue;
      cv.TextOut((integer(OBitmap.Width)-ww)div 2,(integer(OBitmap.Height)-hh) div 2,'?');
      OutBitmap.CopyFromTDibBitmap(OBitmap);
      cv.free;
      OBitmap.free;
   end;
end;

procedure TImageEnMView.ThreadFinish(Sender:TObject);
var
   io:TImageEnIO;
   idx,ww,hh:integer;
   bmp:TIEBitmap;
begin
   io:=Sender as TImageEnIO;
   // prepare the thumbnail in this thread (instead of in SetIEBitmapEx that must be in monothread mode)
   if (csDestroying in ComponentState) or (csDestroying in io.ComponentState) or (io.IEBitmap=nil) then begin
   	EnterCriticalSection(gThreadCS);
		io.Tag:=-1;
      if fThreadStarter.Suspended then
         fThreadStarter.Resume;
      LeaveCriticalSection(gThreadCS);
   	exit;
   end;
   if io.Aborting then begin
      EnterCriticalSection(gThreadCS);
      outputdebugstringA(PAnsiChar('Aborting '+io.Params.filename));
      DoWrongImage(io.IEBitmap,io.Tag);
      LeaveCriticalSection(gThreadCS);
   end;
   if (fStoreType=ietThumb) and (fEnableResamplingOnMinor or (io.IEBitmap.Width>fThumbWidth) or (io.IEBitmap.Height>fThumbHeight)) then begin
      if (io.IEBitmap.width=0) or (io.IEBitmap.height=0) then begin
         ww:=fThumbWidth;
         hh:=fThumbHeight;
      end else
         IEFitResample(io.IEBitmap.width,io.IEBitmap.height,fThumbWidth,fThumbHeight,ww,hh);
      if (io.IEBitmap.Width<>ww) or (io.IEBitmap.Height<>hh) then begin
         bmp:=TIEBitmap.Create;
         bmp.allocate(ww,hh,ie24RGB);
         if io.IEBitmap.pixelformat=ie1g then begin
            _SubResample1bitFilteredEx(io.IEBitmap,0,0,io.IEBitmap.width-1,io.IEBitmap.height-1,bmp)
         end else begin
            if fThumbnailResampleFilter=rfNone then
               _IEBmpStretchEx(io.IEBitmap,bmp,nil,nil)
            else
               _ResampleEx(io.IEBitmap,bmp,fThumbnailResampleFilter,nil,nil)
         end;
         if io.IEBitmap.HasAlphaChannel then begin
            if fThumbnailResampleFilter=rfNone then
               _resamplealphaex(io.IEBitmap.AlphaChannel,bmp.AlphaChannel,rfFastLinear)
            else
               _resamplealphaex(io.IEBitmap.AlphaChannel,bmp.AlphaChannel,fThumbnailResampleFilter);
            bmp.AlphaChannel.Full:=io.IEBitmap.AlphaChannel.Full;
         end;
      end else
         bmp:=io.IEBitmap;
   end else
      bmp:=io.IEBitmap;
   //
   EnterCriticalSection(gThreadCS);
   idx:=io.Tag;
   if idx>=0 then begin
      GetImageEnMIO.Params[idx].Assign( io.Params );
      PIEImageInfo(fImageInfo[idx])^.Background:=io.Background;
      SetIEBitmapEx(idx,bmp);
      if io.Params.FileType=ioJPEG then begin
         ImageOriginalWidth[idx]:=io.Params.JPEG_OriginalWidth;
         ImageOriginalHeight[idx]:=io.Params.JPEG_OriginalHeight;
      end else begin
         ImageOriginalWidth[idx]:=io.Params.Width;
         ImageOriginalHeight[idx]:=io.Params.Height;
      end;
   end;
   if assigned(bmp) and (bmp<>io.IEBitmap) then
      bmp.free;
   io.Tag:=-1;
   if fThreadStarter.Suspended then
      fThreadStarter.Resume;
   LeaveCriticalSection(gThreadCS);
	invalidate;
end;

procedure TIEStarter.Execute;
var
	info:PIEImageInfo;
   bmp:TIEBitmap;
   io:TImageEnIO;
   idx:integer;
begin
	while not Terminated do begin
   	EnterCriticalSection(gThreadCS);
      FreeUseLessThreads(mview);
      FreeInvisibleRequests(mview);
      while (not Terminated) and (mview.fThreadRequests.Count>0) and (mview.fThreadPoolIO.Count<mview.fThreadPoolSize) do begin
         idx:=integer(mview.fThreadRequests[0]);
         bmp:=TIEBitmap.Create;
         io:=TImageEnIO.Create(nil);
         io.Tag:=idx;
         mview.fThreadRequests.Delete(0);
         mview.fThreadPoolIO.add(io);
         io.AttachedIEBitmap:=bmp;
         info:=PIEImageInfo(mview.fImageInfo[idx]);
         io.Background:=info^.Background;
         if mview.fStoreType=ietThumb then begin
            io.Params.JPEG_Scale:=IOJPEG_AUTOCALC;
            io.Params.Width:=mview.fThumbWidth;
            io.Params.Height:=mview.fThumbHeight;
         end else
            io.Params.JPEG_Scale:=IOJPEG_FULLSIZE;
         io.OnFinishWork:=mview.ThreadFinish;
         io.AsyncMode:=true;
         io.LoadFromFile(info^.Name);  // LoadFromFile cannot throw exceptions, but just add a new thread
      end;
      LeaveCriticalSection(gThreadCS);
      if (not Terminated) and (mview.fThreadRequests.Count=0) then
         Suspend;
   end;
end;

procedure TImageEnMView.SetBottomGap(v:integer);
begin
	fBottomGap:=v;
   fSetBottomGap:=v;
   Update;
end;

procedure TImageEnMView.SetUpperGap(v:integer);
begin
	fUpperGap:=v;
   fSetUpperGap:=v;
   Update;
end;

function TImageEnMView.GetFBitmap:TBitmap;
begin
	result:=nil;
	if fSelectedItem>=0 then begin
   	if fSelectedBitmap=nil then
      	fSelectedBitmap:=GetTIEBitmap(fSelectedItem);
      if assigned(fSelectedBitmap) then
	      result:=fSelectedBitmap.VclBitmap;
   end;
end;

function TImageEnMView.GetIEBitmap:TIEBitmap;
begin
	if fSelectedItem>=0 then begin
   	if fSelectedBitmap=nil then
      	fSelectedBitmap:=GetTIEBitmap(fSelectedItem);
      result:=fSelectedBitmap;
   end else
   	result:=nil;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMView.SetMouseInteract(v:TIEMMouseInteract);
begin
	if v<>fMouseInteract then
      fMouseInteract:=v;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMView.SetKeyInteract(v:TIEMKeyInteract);
begin
	if v<>fKeyInteract then
      fKeyInteract:=v;
end;

// info^.image can be nil
procedure TImageEnMView.DrawImage(DestBitmap:TBitmap; info:PIEImageInfo; IsSelected:boolean; Index:integer);
var
	q,w,ww,hh,iw,ih,sw:integer;
   x1,y1,cx1,cy1:integer;
   ImHeight:integer;
   pix,alpha:pbyte;
   tw:integer;
   ith:integer; // infotext height
   bth:integer; // bottomtext height
   xsel:boolean;  // true if display as selected
   iebmp,ietmp:TIEBitmap;
   DestBitmapScanline:ppointerarray;
   XLUT,YLUT:pinteger;
   filt:TResampleFilter;
   //ss:string;
   ws,ws1:WideString;
   cl:TColor;
   ActUpperGap,ActBottomGap:integer;
begin
	try
	EnterCriticalSection(gThreadCS);
   if fShowText then begin
   	ActUpperGap:=fUpperGap;
      ActBottomGap:=fBottomGap;
   end else begin
   	ActUpperGap:=fSetUpperGap;
      ActBottomGap:=fSetBottomGap;
   end;
   xsel:=IsSelected;
   x1:=info^.X-fViewX;
   y1:=info^.Y-fViewY;
	if assigned(fOnBeforeImageDraw) then
   	fOnBeforeImageDraw(self,Index,x1,y1,DestBitmap.Canvas);
   // Now in info^.hbi there is the image to paint (or nil if it isn't possible to obtain the image)
   if fShowText and (info^.InfoText.Caption<>'') then begin
      DestBitmap.Canvas.Font.Assign(info^.InfoText.Font);
      ith:=DestBitmap.Canvas.TextHeight(info^.InfoText.Caption);
   end else
      ith:=0;
   ImHeight:=fThumbHeight-ActBottomGap-ActUpperGap-ith;
   cx1:=0; cy1:=0;
   ww:=0;
   hh:=0;
   //
   if (info^.image<>nil) then begin

      if fFillThumbnail then begin
         if xsel and (fSelectionStyle=iessACD) then
            cl:=clHighlight
         else begin
            if fDrawImageBackground then
               cl:=info^.Background
            else
               cl:=fThumbnailsBackground;
         end;
         IEDrawBackground([],DestBitmap.Canvas,fThumbnailsBackgroundStyle,cl,x1,y1,fThumbWidth,fThumbHeight,x1,y1,x1+fThumbWidth,y1+fThumbHeight,fChessboardSize,fChessboardBrushStyle,fGradientEndColor);
      end;

      // paint the image
      if info^.cacheImage=nil then begin
         // cache empty
         iw:=fImageList.GetImageWidth(info^.image);
         ih:=fImageList.GetImageHeight(info^.image);
         if (iw<1) or (ih<1) then
         	pix:=nil
         else
         	pix:=fImageList.GetImageBits(info^.image);
         alpha:=fImageList.GetAlphaBits(info^.image);
         if fEnableResamplingOnMinor or ((iw>fThumbWidth) or (ih>ImHeight)) then
            IEFitResample(iw,ih,fThumbWidth,ImHeight,ww,hh)
         else begin
            ww:=iw;
            hh:=ih;
         end;
         cx1:=x1+abs(fThumbWidth-ww) div 2;
         cy1:=y1+ActUpperGap+abs(ImHeight-hh) div 2;
         if pix<>nil then begin
            ietmp:=TIEBitmap.Create;
            case fImageList.GetImageBitcount(info^.image) of
	            1:  ietmp.EncapsulateMemory(pix,iw,ih,ie1g,false);
               24: ietmp.EncapsulateMemory(pix,iw,ih,ie24RGB,false);
            end;
            if alpha<>nil then begin
            	ietmp.AlphaChannel.EncapsulateMemory(alpha,iw,ih,ie8g,true);
               ietmp.AlphaChannel.Full:=false;
            end;
            iebmp:=TIEBitmap.Create;
            iebmp.Location:=ieMemory;
            if (ietmp.PixelFormat=ie1g) and ((ww<iw) or (hh<ih)) then begin
            	filt:=rfFastLinear;
               iebmp.Allocate(ww,hh,ie24RGB);
            end else begin
            	filt:=fThumbnailDisplayFilter;
            	iebmp.Allocate(ww,hh,ietmp.PixelFormat);
            end;
            _IEResampleIEBitmap(ietmp,iebmp,filt,nil,nil);
            // draw shadow
            if fSoftShadow.Enabled then begin
               iebmp.SwitchTo(ietmp);
               ietmp.PixelFormat:=ie24RGB;
               _IEAddSoftShadow(ietmp,fSoftShadow.Radius,fSoftShadow.OffsetX,fSoftShadow.OffsetY,true,creatergb(0,0,0),nil,nil);
               iebmp.Allocate(ww,hh,ie24RGB);
               _IEResampleIEBitmap(ietmp,iebmp,rfNone,nil,nil);
            end;
				//
            DestBitmapScanline:=nil; XLut:=nil; YLut:=nil;
            iebmp.RenderToTBitmap(DestBitmap,DestBitmapScanline,XLut,YLut,nil,cx1,cy1,ww,hh,0,0,iebmp.Width,iebmp.Height,fEnableAlphaChannel,false,255,filt,true,ielNormal);
            if fEnableImageCaching then
	            info^.cacheImage:=fCacheList.AddIEBitmap(iebmp);
            ietmp.free;
            iebmp.free;
         end;
      end else begin
         // use cached image
         ww:=fCacheList.GetImageWidth(info^.cacheImage);
         hh:=fCacheList.GetImageHeight(info^.cacheImage);
         cx1:=x1+abs(fThumbWidth-ww) div 2;
         cy1:=y1+ActUpperGap+abs(ImHeight-hh) div 2;
         pix:=fCacheList.GetImageBits(info^.cacheImage);
         alpha:=fCacheList.GetAlphaBits(info^.cacheImage);
         ietmp:=TIEBitmap.Create;
         case fCacheList.GetImageBitcount(info^.cacheImage) of
            1:  ietmp.EncapsulateMemory(pix,ww,hh,ie1g,false);
            24: ietmp.EncapsulateMemory(pix,ww,hh,ie24RGB,false);
         end;
         if alpha<>nil then begin
            ietmp.AlphaChannel.EncapsulateMemory(alpha,ww,hh,ie8g,true);
            ietmp.AlphaChannel.Full:=false;
         end;
         DestBitmapScanline:=nil; XLut:=nil; YLut:=nil;
         ietmp.RenderToTBitmap(DestBitmap,DestBitmapScanline,XLut,YLut,nil,cx1,cy1,ww,hh,0,0,ietmp.Width,ietmp.Height,true,false,255,rfNone,true,ielNormal);
         ietmp.free;
      end;

      // draw sides background
      if fFillThumbnail then
         with DestBitmap.canvas do begin
            if xsel and (fSelectionStyle=iessACD) then
               Brush.Color:=clHighlight
            else begin
               if fDrawImageBackground then
                  Brush.Color:=info^.Background
               else
                  Brush.Color:=fThumbnailsBackground;
            end;
            Brush.Style := bsSolid;
            FillRect(rect(x1,y1,cx1,y1+fThumbHeight));	// left
            FillRect(rect(cx1+ww,y1,x1+fThumbWidth,y1+fThumbHeight)); // right
            FillRect(rect(cx1,y1,cx1+ww,cy1));	// up
            FillRect(rect(cx1,cy1+hh,cx1+ww,y1+fThumbHeight));  // bottom
         end;
   end;
   // draw top, bottom, info texts
   bth:=0;
   if fShowText then begin
      if info^.TopText.Caption<>'' then begin
         DestBitmap.Canvas.Font.Assign(info^.TopText.Font);
         DestBitmap.Canvas.Brush.Style:=bsSolid;
         if xsel and (fSelectionStyle=iessACD) then begin
            DestBitmap.Canvas.Font.Color:=clHighlightText;
            DestBitmap.Canvas.Brush.Color:=clHighlight;
         end else
            DestBitmap.Canvas.Brush.Color:=info^.TopText.Background;
         ws:=info^.TopText.Caption;
         q:=1;
         repeat
            tw:=DestBitmap.Canvas.TextWidth(ws);
            if (tw<=fThumbWidth) or (length(ws)<2) then
               break;
            inc(q);
            ws1:=copy(info^.TopText.Caption,q,length(info^.TopText.Caption));
            if ws1='' then break;
            ws:='...'+ws1;
         until false;
         //DestBitmap.Canvas.TextOut(x1+(fThumbWidth-tw) div 2,y1,ss);
         TextOutW(DestBitmap.Canvas.Handle,x1+(fThumbWidth-tw) div 2,y1,@ws[1],length(ws));
      end;
      if info^.InfoText.Caption<>'' then begin
         DestBitmap.Canvas.Font.Assign(info^.InfoText.Font);
         DestBitmap.Canvas.Brush.Style:=bsSolid;
         if xsel and (fSelectionStyle=iessACD) then begin
            DestBitmap.Canvas.Font.Color:=clHighlightText;
            DestBitmap.Canvas.Brush.Color:=clHighlight;
         end else
            DestBitmap.Canvas.Brush.Color:=info^.InfoText.Background;
         ws:=info^.InfoText.Caption;
         q:=1;
         repeat
            tw:=DestBitmap.Canvas.TextWidth(ws);
            if (tw<=fThumbWidth) or (length(ws)<2) then
               break;
            inc(q);
            ws1:=copy(info^.InfoText.Caption,q,length(info^.InfoText.Caption));
            if ws1='' then break;
            ws:='...'+ws1;
         until false;
         //DestBitmap.Canvas.TextOut(x1+(fThumbWidth-tw) div 2,y1+fThumbHeight-ActBottomGap-ith,ws);
         TextOutW(DestBitmap.Canvas.Handle,x1+(fThumbWidth-tw) div 2,y1+fThumbHeight-ActBottomGap-ith,@ws[1],length(ws));
      end;
      if info^.BottomText.Caption<>'' then begin
         DestBitmap.Canvas.Font.Assign(info^.BottomText.Font);
         DestBitmap.Canvas.Brush.Style:=bsSolid;
         if xsel and (fSelectionStyle=iessACD) then begin
            DestBitmap.Canvas.Font.Color:=clHighlightText;
            DestBitmap.Canvas.Brush.Color:=clHighlight;
         end else
            DestBitmap.Canvas.Brush.Color:=info^.BottomText.Background;
         ws:=info^.BottomText.Caption;
         q:=1;
         repeat
            tw:=DestBitmap.Canvas.TextWidth(ws);
            if (tw<=fThumbWidth) or (length(ws)<2) then
               break;
            inc(q);
            ws1:=copy(info^.BottomText.Caption,q,length(info^.BottomText.Caption));
            if ws1='' then break;
            ws:='...'+ws1;
         until false;
         bth:=DestBitmap.Canvas.TextHeight(ws);
         DestBitmap.Canvas.FillRect(rect(x1,y1+fThumbHeight-bth-1,x1+fThumbWidth,y1+fThumbHeight));
         //DestBitmap.Canvas.TextOut(1+x1+(fThumbWidth-tw-2) div 2,y1+fThumbHeight-bth-1,ws);
         TextOutW(DestBitmap.Canvas.Handle,1+x1+(fThumbWidth-tw-2) div 2,y1+fThumbHeight-bth-1,@ws[1],length(ws));
         inc(bth,3);
      end;
   end;	// end of fShowText
   // iemsACD style
   if fStyle=iemsACD then begin
      IEDraw3DRect(DestBitmap.Canvas,cx1,cy1,cx1+ww-1,cy1+hh-1,clGray,clWhite); // around the image
      if (ActBottomGap+ActUpperGap>0) or (fShowText and (info^.InfoText.Caption<>'')) then
         IEDraw3DRect(DestBitmap.Canvas,x1,y1,x1+fThumbWidth-1,y1+fThumbHeight-1-bth,clWhite,clBlack);  // around entire thumbnail
      if fShowText and (info^.BottomText.Caption<>'') then
         IEDraw3DRect(DestBitmap.Canvas,x1,y1+fThumbHeight-bth-1+3,x1+fThumbWidth-1,y1+fThumbHeight-1,clGray,clWhite);   // around bottomtext
   end;
   // call OnImageDraw
   if assigned(fOnImageDraw) then
      fOnImageDraw(self,Index,x1,y1,DestBitmap.Canvas);
   // thumbnail border
   DestBitmap.Canvas.Pen.Width:=1;
   DestBitmap.Canvas.Pen.Color:=fThumbnailsBorderColor;
   DestBitmap.Canvas.Brush.Style:=bsClear;
   sw:=fThumbnailsBorderWidth;
   for w:=1 to sw do
      DestBitmap.Canvas.Rectangle(x1-w,y1-w,x1+fThumbWidth+w,y1+fThumbHeight+w);
   // selection
   if xsel and (fSelectionStyle<>iessACD) then begin
      DestBitmap.Canvas.Pen.Width:=1;
      DestBitmap.Canvas.Pen.Color:=fSelectionColor;
      DestBitmap.Canvas.Brush.Style:=bsClear;
      if Focused then
         sw:=fSelectionWidth
      else
         sw:=1;
      for w:=1 to sw do
         DestBitmap.Canvas.Rectangle(x1-w,y1-w,x1+fThumbWidth+w,y1+fThumbHeight+w);
   end;
   finally
   	LeaveCriticalSection(gThreadCS);
   end;
end;

function TImageEnMView.IsVisible(idx:integer):boolean;
var
   x1,y1:integer;
   info:PIEImageInfo;
begin
   info:=PIEImageInfo(fImageInfo[idx]);
   x1:=info^.X-fViewX;
   y1:=info^.Y-fViewY;
   result:=_RectXRect(0,0,width-1,height-1,x1,y1,x1+fThumbWidth-1,y1+fThumbHeight-1);
end;

procedure TImageEnMView.PaintTo(DestBitmap:TBitmap);
var
	q,ne,nn,e,x1,y1:integer;
   info:PIEImageInfo;
   reloop:boolean;
   xsel:boolean;  // true if display as selected
begin
   // draw global background
   (*
   with DestBitmap.canvas do begin
      Brush.Color := fBackGround;
      Brush.Style := bsSolid;
      FillRect(rect(0,0,ClientWidth,ClientHeight));
   end;
   *)
   IEDrawBackground([],DestBitmap.Canvas,fBackgroundStyle,fBackground,0,0,ClientWidth,ClientHeight,0,0,0,0,fChessboardSize,fChessboardBrushStyle,fGradientEndColor);
   // draw wallpaper
   if assigned(fWallPaper.Graphic) then begin
   	case fWallPaperStyle of
			iewoNormal:
         	begin
	            DestBitmap.Canvas.Draw(0,0, fWallPaper.Graphic );
               //excludecliprect(DestBitmap.canvas.handle,0,0,fWallPaper.Graphic.Width,fWallPaper.Graphic.Height);
            end;
         iewoStretch:
         	begin
            	DestBitmap.Canvas.StretchDraw(rect(0,0,ClientWidth,ClientHeight),fWallPaper.Graphic);
            end;
         iewoTile:
         	begin
					x1:=0; y1:=0;
               while (y1<ClientHeight) do begin
						DestBitmap.Canvas.Draw(x1,y1, fWallPaper.Graphic );
						inc(x1, fWallPaper.Graphic.Width);
                  if x1>=ClientWidth then begin
                  	x1:=0;
                     inc(y1, fWallPaper.Graphic.Height);
                  end;
               end;
            end;
      end;
   end;
	repeat
   	reloop:=false;
      if (fDisplayMode=mdSingle) and (fImageInfo.Count>0) then
         ne:=1	// one image at the time
      else
         ne:=fImageInfo.Count;
      if fPlaying or (fDisplayMode=mdSingle) then begin
         if fFrame>=fImageInfo.Count then fFrame:=fImageInfo.Count-1;
         if fFrame<0 then fFrame:=0;
         q:=fFrame;
      end else
         q:=0;
      for nn:=0 to ne-1 do begin
         if assigned(fOnDrawProgress) and (ne>1) then
            fOnDrawProgress(Self, trunc(nn/ne*100),q);
         info:=PIEImageInfo(fImageInfo[q]);
         // check that the image is visible
         if IsVisible(q) then begin
            // try to obtain the image if not available
            if (info^.image=nil) then begin
               if (fSelectedItem=q) or (fThreadPoolSize=0) or (ObtainImageThreaded(q)=false) then begin
                  if (not ObtainImageNow(q)) and fRemoveCorrupted then begin
                     // remove corrupted image and re-loop
                     DeleteImageNU(nn);
                     reloop:=true;
                     break;
                  end;
               end;
            end;
            //
            if fSelectedItem<>q then begin
               xsel:=false;
               if fEnableMultiSelect then begin
                  e:=fMultiSelectedImages.IndexOf(pointer(q));
                  xsel:= e>-1;
               end;
            end else
               xsel:=true;
            xsel:= xsel and (fVisibleSelection) and (fDisplayMode=mdGrid);
            //
            DrawImage(DestBitmap,info,xsel,q);
         end;
         //
         inc(q);
         if q=fImageInfo.Count then q:=0;
      end;
   until not reloop;
   // draw done
  	if assigned(fOnDrawProgress) and (ne>1) then
     	fOnDrawProgress(Self, 100,0);
end;

procedure TImageEnMView.SetDisplayMode(v:TIEMDisplayMode);
begin
	if fPlaying then
   	fSaveDM:=v
   else begin
      fDisplayMode:=v;
      Update;
   end;
end;

procedure TImageEnMView.SetGridWidth(v:integer);
begin
	fGridWidth:=v;
   Update;
end;

procedure TImageEnMView.SetPlaying(v:boolean);
begin
	if v=fPlaying then exit;
	if v then begin
	   fSaveDM:=fDisplayMode;
      fSaveSel:=fSelectedItem;
      Deselect;
   end;
	fPlaying:=v;
   PlayFrame;
   if not fPlaying then begin
   	SetDisplayMode(fSaveDM);
      SetSelectedItem(fSaveSel);
   end;
end;

// show the image indexed by VisibleFrame, put it at the center (when applicable)
procedure TImageEnMView.CenterFrame;
var
	info:PIEImageInfo;
   x,y:integer;
begin
	if fSelectedItem>=0 then begin
   	info:=PIEImageInfo(fImageInfo[fFrame]);
		X:=info^.X-((ClientWidth-fThumbWidth) div 2);
      Y:=info^.Y-((ClientHeight-fThumbHeight) div 2);
      SetViewXY(X,Y);
	end;
end;

procedure TImageEnMView.PlayFrame;
var
   info:PIEImageInfo;
   rr:TRect;
begin
	if fTimerInProgress then exit;
   if csDestroying in ComponentState then exit;
   fTimerInProgress:=true;
   // remove timer
	if fPlayTimer<>0 then begin
   	KillTimer(self.handle,1);
      fPlayTimer:=0;
   end;
   if fPlaying then begin
      if fDisplayMode<>mdSingle then begin
         fDisplayMode:=mdSingle;
         Update;
      end;
      if fFrame>=fImageInfo.Count then fFrame:=fImageInfo.Count-1;
      if fFrame<0 then exit;
      info:=PIEImageInfo(fImageInfo[fFrame]);
      // show current frame
      Paint;
      rr:=rect(0,0,clientwidth,clientheight);
      ValidateRect(self.handle,@rr);	// cancel invalidate executed by CenterSelected
	   // another loop
      // prepare for next frame
      if fFrame=fImageInfo.Count-1 then begin
      	fFrame:=0;
        	CallBitmapChangeEvents;
      	if not fPlayLoop then begin
				fPlaying:=false;
            fTimerInProgress:=false;
            exit;					// EXIT!
         end;
      end else
      	inc(fFrame);
      // run timer
      fPlayTimer:=SetTimer(self.handle,1,imax(info^.DTime,10),nil);
	end;
   fTimerInProgress:=false;
end;

procedure TImageEnMView.WMTimer(var Message:TWMTimer);
begin
	PlayFrame;
end;

// look at fLastImOp
function TImageEnMView.GetLastOp:integer;
begin
	result:=fLastImOp;
end;

// look at fLastImIdx
function TImageEnMView.GetLastOpIdx:integer;
begin
	result:=fLastImIdx;
end;

// erase fLastImOp (in prev versions this was done by GetLastOp)
procedure TImageEnMView.CallBitmapChangeEvents;
begin
	inherited;
   fLastImOp:=0;
end;

/////////////////////////////////////////////////////////////////////////////////////
// remove all images
// recreate temp file (you can change the DefTEMPPATH and call Clear to make changes active)
procedure TImageEnMView.Clear;
begin
	Deselect;
   ClearThreadsAndRequests;
	while fImageInfo.Count>0 do
		DeleteImageNU(0);
   fImageList.free;
	fImageList:=TIEVirtualDIBList.Create;
   fImageList.MaxImagesInMemory:=fImageCacheSize;
   fCacheList.free;
   fCacheList:=TIEVirtualDIBList.Create;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Incrementa il conteggio fLockPaint
procedure TImageEnMView.LockPaint;
begin
	inc(fLockPaint);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Decrementa il conteggio fLockPaint
// rest. valore corrente (dopo il decremento)
function TImageEnMView.UnLockPaint:integer;
begin
	if fLockPaint>0 then
   	dec(fLockPaint);
   if fLockPaint=0 then
   	Update;
   result:=fLockPaint;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Decrementa il conteggio fLockPaint
// rest. valore corrente (dopo il decremento)
// non chiama Update se fLockpaint=0
function TImageEnMView.NPUnLockPaint:integer;
begin
	if fLockPaint>0 then
   	dec(fLockPaint);
   result:=fLockPaint;
end;

/////////////////////////////////////////////////////////////////////////////////////
// 0= non visibile
// 1= parzialmente
// 2= totalmente
function TImageEnMView.GetImageVisibility(idx:integer):integer;
var
   x1,y1:integer;
   info:PIEImageInfo;
begin
	result:=0;
	if (idx>=0) and (idx<fImageInfo.Count) then begin
      info:=PIEImageInfo(fImageInfo[idx]);
      x1:=info^.X-fViewX;
      y1:=info^.Y-fViewY;
		result:=_RectPRect(0,0,clientwidth-1,clientheight-1,x1,y1,x1+fThumbWidth-1,y1+fThumbHeight-1);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMView.UpdateImage(idx:integer);
var
	rc:TRect;
   x1,y1:integer;
   info:PIEImageInfo;
begin
	if (idx>=0) and (idx<fImageInfo.Count) then begin
      Update;
      ValidateRect(self.handle,nil);
      //
      info:=PIEImageInfo(fImageInfo[idx]);
      x1:=info^.X-fViewX;
      y1:=info^.Y-fViewY;
      rc:=Rect(x1,y1,x1+fThumbWidth,y1+fThumbHeight);
      InvalidateRect(self.handle,@rc,false);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMView.CMWantSpecialKey(var Msg: TCMWantSpecialKey);
begin
	inherited;
	case msg.CharCode of
  		VK_LEFT,VK_RIGHT,VK_UP,VK_DOWN,
      VK_PRIOR,VK_NEXT,VK_HOME, VK_END: msg.Result:=1;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Mostra l'immagine selezionata, ponendola al centro del componente (se possibile)
procedure TImageEnMView.CenterSelected;
var
	info:PIEImageInfo;
   x,y:integer;
begin
	if fSelectedItem>=0 then begin
   	info:=PIEImageInfo(fImageInfo[fSelectedItem]);
		X:=info^.X-((ClientWidth-fThumbWidth) div 2);
      Y:=info^.Y-((ClientHeight-fThumbHeight) div 2);
      SetViewXY(X,Y);
	end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMView.SelectSeek(pos:TIESeek);
var
	info:PIEImageInfo;
	gw,gh:integer;
begin
	if fImageInfo.Count=0 then
   	exit;
   if fGridWidth=-1 then
      gw:=(clientwidth-fHorizBorder) div (fThumbWidth+fHorizBorder)
   else
      gw:=fGridWidth;
   gh:=(clientheight-fVertBorder) div (fThumbHeight+fVertBorder);
   //
	case pos of
		iskLeft:
      	if fSelectedItem>=0 then begin
            SetSelectedItem( fSelectedItem-1 );
            if (fSelectedItem>=0) and (GetImageVisibility(fSelectedItem)<>2) then begin
               info:=PIEImageInfo(fImageInfo[fSelectedItem]);
               SetViewXY(info^.X-fHorizBorder,info^.Y-fVertBorder);
            end;
         end;
      iskRight:
      	if fSelectedItem>=-1 then begin
            SetSelectedItem( fSelectedItem+1 );
            if (fSelectedItem>=0) and (GetImageVisibility(fSelectedItem)<>2) then begin
               info:=PIEImageInfo(fImageInfo[fSelectedItem]);
               SetViewXY(info^.X-clientwidth+fThumbWidth+fHorizBorder,info^.Y-clientheight+fThumbHeight+fVertBorder);
            end;
         end;
		iskUp:
      	if fSelectedItem>=0 then begin
            if fGridWidth=0 then
               // una sola riga di infinite colonne
               SetSelectedItem( fSelectedItem-1 )
            else
               // più righe di gw colonne
               SetSelectedItem( IMAX(fSelectedItem-gw,0) );
            if (fSelectedItem>=0) and (GetImageVisibility(fSelectedItem)<>2) then begin
               info:=PIEImageInfo(fImageInfo[fSelectedItem]);
               SetViewY(info^.Y-fVertBorder);
               if GetImageVisibility(fSelectedItem)<>2 then
                  SetViewX(info^.X-fHorizBorder);
            end;
         end;
      iskDown:
      	if fSelectedItem>=-1 then begin
            if fGridWidth=0 then
               // una sola riga di infinite colonne
               SetSelectedItem( fSelectedItem+1 )
            else
               // più righe di gw colonne
               SetSelectedItem( IMIN(fSelectedItem+gw,fImageInfo.Count-1) );
            if (fSelectedItem>=0) and (GetImageVisibility(fSelectedItem)<>2) then begin
               info:=PIEImageInfo(fImageInfo[fSelectedItem]);
               SetViewY(info^.Y-clientheight+fThumbHeight+fVertBorder);
               if GetImageVisibility(fSelectedItem)<>2 then
                  SetViewX(info^.X-clientwidth+fThumbWidth+fHorizBorder);
            end;
         end;
      iskFirst:
      	begin
            SetSelectedItem( 0 );
            if (fSelectedItem>=0) and (GetImageVisibility(fSelectedItem)<>2) then
               SetViewXY(0,0);
         end;
      iskLast:
      	begin
            SetSelectedItem( fImageInfo.Count-1 );
            if (fSelectedItem>=0) and (GetImageVisibility(fSelectedItem)<>2) then begin
               info:=PIEImageInfo(fImageInfo[fSelectedItem]);
               SetViewY(info^.Y-clientheight+fThumbHeight+fVertBorder);
               if GetImageVisibility(fSelectedItem)<>2 then
                  SetViewX(info^.X-clientwidth+fThumbWidth+fHorizBorder);
            end;
         end;
      iskPagDown:
      	if fSelectedItem>=-1 then begin
            SetSelectedItem( fSelectedItem+gw*gh );
            if (fSelectedItem>=0) and (GetImageVisibility(fSelectedItem)<>2) then begin
               info:=PIEImageInfo(fImageInfo[fSelectedItem]);
               SetViewY(info^.Y-clientheight+fThumbHeight+fVertBorder);
               if GetImageVisibility(fSelectedItem)<>2 then
                  SetViewX(info^.X-clientwidth+fThumbWidth+fHorizBorder);
            end;
         end;
      iskPagUp:
      	if fSelectedItem>=0 then begin
            SetSelectedItem( fSelectedItem-gw*gh );
            if (fSelectedItem>=0) and (GetImageVisibility(fSelectedItem)<>2) then begin
               info:=PIEImageInfo(fImageInfo[fSelectedItem]);
               SetViewY(info^.Y-fVertBorder);
               if GetImageVisibility(fSelectedItem)<>2 then
                  SetViewX(info^.X-fHorizBorder);
            end;
         end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMView.KeyDown(var Key: Word; Shift: TShiftState);
var
	lMultiSelecting:boolean;
   lSelectInclusive:boolean;
begin
	inherited;
  	if fPlaying then exit;
   if mkiMoveSelected in fKeyInteract then begin
      lMultiSelecting:=fMultiSelecting;
      lSelectInclusive:=fSelectInclusive;
      if fEnableMultiSelect and ((ssCtrl in Shift) or (ssShift in Shift)) then begin
         fMultiSelecting:=true;
         fSelectInclusive:=true;
      end;
      try
      case Key of
         VK_LEFT:
            SelectSeek(iskLeft);
         VK_RIGHT:
            SelectSeek(iskRight);
         VK_UP:
            SelectSeek(iskUp);
         VK_DOWN:
            SelectSeek(iskDown);
         VK_PRIOR:
            SelectSeek(iskPagUp);
         VK_NEXT:
            SelectSeek(iskPagDown);
         VK_HOME:
            SelectSeek(iskFirst);
         VK_END:
            SelectSeek(iskLast);
         else
            exit;
      end;
      finally
         fMultiSelecting:=lMultiSelecting;
         fSelectInclusive:=lSelectInclusive;
      end;
      Update;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMView.KeyUp(var Key: Word; Shift: TShiftState);
begin
	inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMView.WMKillFocus(var Msg: TWMKillFocus);
begin
	inherited;
   invalidate;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMView.WMSetFocus(var Msg: TWMSetFocus);
begin
	inherited;
   invalidate;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnMView.GetMouseInteract:TIEMMouseInteract;
begin
	result:=fMouseInteract;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnMView.GetKeyInteract:TIEMKeyInteract;
begin
	result:=fKeyInteract;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMView.SetRemoveCorrupted(v:boolean);
begin
	fRemoveCorrupted:=v;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMView.SetDrawImageBackground(v:boolean);
begin
	fDrawImageBackground:=v;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnMView.GetScrollBarsAlwaysVisible:boolean;
begin
	result:=fScrollBarsAlwaysVisible;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMView.SetScrollBarsAlwaysVisible(v:boolean);
begin
	fScrollBarsAlwaysVisible:=v;
   Update;
end;

// return true if ok
function TImageEnMView.SetImageFromFile(idx:integer; const FileName:String):boolean;
begin
	result:=SetImageFromStreamOrFile(idx,nil,FileName);
end;

// return true if ok
function TImageEnMView.SetImageFromStream(idx:integer; Stream:TStream):boolean;
begin
	result:=SetImageFromStreamOrFile(idx,Stream,'');
end;

function TImageEnMView.SetImageFromStreamOrFile(idx:integer; Stream:TStream; const FileName:string):boolean;
var
	bmp:TIEBitmap;
	info:PIEImageInfo;
begin
	if idx>=fImageInfo.Count then begin
   	result:=false;
      exit;
   end;
	result:=true;
  	info:=PIEImageInfo(fImageInfo[idx]);
	bmp:=TIEBitmap.Create;
   fImageEnIO.Background:=info^.Background;
   fImageEnIO.attachediebitmap:=bmp;
   fImageEnIO.OnProgress:=fOnIOProgress;
   if fStoreType=ietThumb then begin
		fImageEnIO.Params.JPEG_Scale:=IOJPEG_AUTOCALC;
      fImageEnIO.Params.Width:=fThumbWidth;
      fImageEnIO.Params.Height:=fThumbHeight;
   end else
   	fImageEnIO.Params.JPEG_Scale:=IOJPEG_FULLSIZE;
   try
   if Stream<>nil then
	   fImageEnIO.LoadFromStream(Stream)
   else
   	fImageEnIO.LoadFromFile(FileName);
   except
   	fImageEnIO.Aborting:=true;
   end;
   //
   if fImageEnIO.Aborting then begin
      DoWrongImage(bmp,idx);
      result:=false;
   end;
   // updates params of encapsulated TImageEnMIO object
   GetImageEnMIO.Params[idx].Assign( fImageEnIO.Params );   // GetImageEnMIO creates TImageEnMIO if it doesn't exist
   // set the image
   info^.Background:=fImageEnIO.Background;
   SetIEBitmapEx(idx,bmp);
   if fImageEnIO.Params.FileType=ioJPEG then begin
      ImageOriginalWidth[idx]:=fImageEnIO.Params.JPEG_OriginalWidth;
      ImageOriginalHeight[idx]:=fImageEnIO.Params.JPEG_OriginalHeight;
   end else begin
      ImageOriginalWidth[idx]:=fImageEnIO.Params.Width;
      ImageOriginalHeight[idx]:=fImageEnIO.Params.Height;
   end;
   //
   fImageEnIO.attachediebitmap:=nil;
   bmp.free;
   Update;
end;

//
procedure TImageEnMView.PrepareSpaceFor(Width,Height:integer; Bitcount:integer; ImageCount:integer);
begin
	fImageList.PrepareSpaceFor(Width,Height,Bitcount,ImageCount);
end;

//
procedure TImageEnMView.SetImageCacheSize(v:integer);
begin
	fImageCacheSize:=v;
	fImageList.MaxImagesInMemory:=fImageCacheSize;
end;

//
procedure TImageEnMView.SetVisibleFrame(v:integer);
begin
	if (v=fFrame) or (v<0) or (v>=fImageInfo.Count) then exit;
   if fTransitionEffect<>iettNone then begin
   	fTransition.Transition:=fTransitionEffect;
      fTransition.Duration:=fTransitionDuration;
      fTransition.SetSizes(fThumbWidth,fThumbHeight);
      PaintTo(fTransition.SourceShot);
      fFrame:=v;
      PaintTo(fTransition.TargetShot);
      fTransition.Run(true);
   end else begin
   	fFrame:=v;
      Update;
   end;
end;

function TImageEnMView.GetTransitionRunning:boolean;
begin
	result:=fTransition.Running;
end;

procedure TImageEnMView.RemoveAlphaChannel(Merge:boolean);
begin
	// nothing
end;

// return nil
function TImageEnMView.GetAlphaChannel:TIEBitmap;
begin
	result:=nil;
end;

function TImageEnMView.GetHasAlphaChannel:boolean;
begin
	result:=false;
end;

function TImageEnMView.GetImageTopText(idx:integer):TIEMText;
begin
   result:=nil;
	if (idx>=0) and (idx<fImageInfo.Count) then
   	with PIEImageInfo(fImageInfo[idx])^ do
         result:=TopText;
end;

function TImageEnMView.GetImageBottomText(idx:integer):TIEMText;
begin
   result:=nil;
	if (idx>=0) and (idx<fImageInfo.Count) then
   	with PIEImageInfo(fImageInfo[idx])^ do
         result:=BottomText;
end;

function TImageEnMView.GetImageInfoText(idx:integer):TIEMText;
begin
   result:=nil;
	if (idx>=0) and (idx<fImageInfo.Count) then
   	with PIEImageInfo(fImageInfo[idx])^ do
         result:=InfoText;
end;


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
// TIEMText

constructor TIEMText.Create(Owner:TComponent; Position:TIEMTextPos);
var
   iem:TImageEnMView;
begin
   inherited Create;
   //
   fCaption:='';
   fFont:=TFont.Create;
   fOwner:=Owner;
   fPos:=Position;
   if fOwner is TImageEnMView then begin
      iem:=(fOwner as TImageEnMView);
      fBackground:= iem.fBackground;
      fFont.assign(iem.font);
   end else begin
      fBackground:=clBtnFace;
   end;
end;

destructor TIEMText.Destroy;
begin
   fFont.free;
   //
   inherited;
end;

procedure TIEMText.SetCaption(value:WideString);
var
   iem:TImageEnMView;
   h:integer;
begin
   if fOwner is TImageEnMView then begin
      iem:=(fOwner as TImageEnMView);
      // adjust top or bottom gap if needed
      iem.Canvas.Font.Assign(fFont);
      h:=iem.Canvas.TextHeight(value);
      if (fPos=iemtpTop) and (iem.fUpperGap<(h+2)) then
         iem.fUpperGap:=h+2;
      if (fPos=iemtpBottom) and (iem.fBottomGap<(h+2)) then begin
         if iem.fStyle=iemsACD then
            iem.fBottomGap:=h+4
         else
            iem.fBottomGap:=h+2;
      end;
   end;
   fCaption:=value;
end;

// end of TIEMText
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

procedure TImageEnMView.SetStyle(value:TIEMStyle);
begin
   if fStyle<>value then begin
      fStyle:=value;
      Update;
   end;
end;

procedure TImageEnMView.SetSelectionStyle(value:TIESStyle);
begin
   if fSelectionStyle<>value then begin
      fSelectionStyle:=value;
      Update;
   end;
end;

procedure TImageEnMView.SetEnableMultiSelect(Value:boolean);
begin
	if fEnableMultiSelect<>Value then begin
		fEnableMultiSelect:=Value;
	   Update;
   end;
end;

procedure TImageEnMView.SetThumbnailsBorderWidth(Value:integer);
begin
	if fThumbnailsBorderWidth<>Value then begin
   	fThumbnailsBorderWidth:=Value;
      Update;
   end;
end;

procedure TImageEnMView.SetThumbnailsBorderColor(Value:TColor);
begin
	if fThumbnailsBorderColor<>Value then begin
		fThumbnailsBorderColor:=Value;
      Update;
   end;
end;

function TImageEnMView.GetMultiSelectedImages(index:integer):integer;
begin
	result:=-1;
	if (index>=0) and (index<fMultiSelectedImages.Count) then
   	result:=integer(fMultiSelectedImages[index]);
end;

function TImageEnMView.GetMultiSelectedImagesCount:integer;
begin
	result:=fMultiSelectedImages.Count;
end;

procedure TImageEnMView.SetWallPaper(Value:TPicture);
begin
	fWallPaper.Assign(Value);
   Update;
end;

procedure TImageEnMView.SetWallPaperStyle(Value:TIEWallPaperStyle);
begin
	if Value<>fWallPaperStyle then begin
   	fWallPaperStyle:=Value;
      Update;
   end;
end;

procedure TImageEnMView.SelectAll;
var
	q:integer;
   lMultiSelecting:boolean;
begin
	if fEnableMultiSelect then begin
   	DeselectNU;
      lMultiSelecting:=fMultiSelecting;
      fMultiSelecting:=true;
      for q:=0 to fImageInfo.Count-2 do
      	fMultiSelectedImages.Add(pointer( q ));
		SetSelectedItemNU(fImageInfo.Count-1);	// last item also is current selected item (own Bitmap object)
		fMultiSelecting:=lMultiSelecting;      
      Update;
   end;
end;

procedure TImageEnMView.SetEnableResamplingOnMinor(Value:boolean);
begin
   fEnableResamplingOnMinor:=Value;
   Update;
end;

function TImageEnMView.GetImageEnMIO:TImageEnMIO;
begin
	if not assigned(fImageEnMIO) then begin
   	fImageEnMIO:=TImageEnMIO.Create(self);
      fImageEnMIO.AttachedMView:=self;
      fImageEnMIO.OnProgress:=fOnProgress;
   end;
   result:=fImageEnMIO;
end;

function TImageEnMView.GetImageEnProc:TImageEnProc;
begin
	if not assigned(fImageEnProc) then begin
   	fImageEnProc:=TImageEnProc.Create(self);
      fImageEnProc.AttachedImageEn:=self;
      fImageEnProc.OnProgress:=fOnProgress;
   end;
   result:=fImageEnProc;
end;

procedure TImageEnMView.SetOnProgress(v:TIEProgressEvent);
begin
   fOnProgress:=v;
   if assigned(fImageEnMIO) then
      fImageEnMIO.OnProgress:=v;
   if assigned(fImageEnProc) then
      fImageEnProc.OnProgress:=v;
end;

function TImageEnMView.GetOnProgress:TIEProgressEvent;
begin
   result:=fOnProgress;
end;

function TImageEnMView.GetMaximumViewX:integer;
begin
   result:=imax(fVWidth-ClientWidth,0);
end;

function TImageEnMView.GetMaximumViewY:integer;
begin
   result:=imax(fVHeight-ClientHeight,0);
end;

procedure TImageEnMView.ClearImageCache(idx:integer);
var
   info:PIEImageInfo;
begin
   info:=PIEImageInfo(fImageInfo[idx]);
   if info^.cacheImage<>nil then begin
      fcacheList.Delete( info^.cacheImage );
      info^.cacheImage:=nil;
   end;
end;

procedure TImageEnMView.ClearCache;
var
   i:integer;
begin
   for i:=0 to fImageInfo.Count-1 do
      ClearImageCache(i);
end;

procedure TImageEnMView.SetEnableImageCaching(v:boolean);
begin
	fEnableImageCaching:=v;
   if not fEnableImageCaching then begin
   	ClearCache;
      update;
   end;
end;

function TImageEnMView.IsSelected(idx:integer):boolean;
begin
	result:=  fMultiSelectedImages.IndexOf(pointer(idx))>-1;
end;

// sort selected index
procedure TImageEnMView.MultiSelectSortList;
	//
	function comp(Item1, Item2: Pointer): Integer;
	begin
   	result:=integer(Item1)-integer(Item2);
   end;
begin
	fMultiSelectedImages.Sort(@comp);
end;

procedure TImageEnMView.SetEnableAlphaChannel(v:boolean);
begin
	fEnableAlphaChannel:=v;
   Update;
end;

procedure TImageEnMView.SetBackgroundStyle(v:TIEBackgroundStyle);
begin
	fBackgroundStyle:=v;
   Update;
end;

procedure TImageEnMView.SetThumbnailsBackgroundStyle(v:TIEBackgroundStyle);
begin
	fThumbnailsBackgroundStyle:=v;
   Update;
end;


procedure TImageEnMView.SetChessboardStyle(Size:integer;BrushStyle:TBrushStyle);
begin
    fChessboardSize:=Size;
    fChessboardBrushStyle:=BrushStyle;
end;

procedure TImageEnMView.SetGradientEndColor(Value:TColor);
begin
	fGradientEndColor:=Value;
   Update;
end;

procedure TImageEnMView.SetFillThumbnail(Value:boolean);
begin
	fFillThumbnail:=Value;
   Update;
end;

procedure TImageEnMView.SetShowText(Value:boolean);
begin
   fShowText:=Value;
   Update;
end;

procedure TImageEnMView.FillFromDirectory(const Directory:string);
var
	sr:TSearchRec;
   Found,idx:integer;
   fpath:string;
begin
	LockPaint;
	Found:=FindFirst(Directory+'\*.*',faArchive,sr);
   if Found=0 then begin
      while Found=0 do begin
         fpath:=Directory+'\'+sr.Name;
         if IsKnownFormat(fpath) then begin
            idx:=AppendImage;
            ImageFileName[idx]:=fpath;
            ImageBottomText[idx].Caption:=extractfilename(fpath);
         end;
         Found:=FindNext(sr);
      end;
      FindClose(sr);
	end;
   UnLockPaint;
end;

// move image idx to destination index
// doesn't move assocated IOParams
procedure TImageEnMView.MoveImage(idx:integer; destination:integer);
var
	psel:integer;
begin
	if (idx>=0) and (idx<fImageInfo.Count) and (destination>=0) and (destination<>idx) then begin
      SetPlaying(false);
      psel:=fSelectedItem;
      DeselectNU;
      if destination>=fImageInfo.Count then begin
         fImageInfo.Add(fImageInfo[idx]);
	      fImageInfo.Delete(idx);
      end else
	      fImageInfo.Move(idx,destination);
      if idx=psel then
      	SetSelectedItemNU(destination)
      else
	      SetSelectedItemNU(psel);
      Update;
   end;
end;

function IEMultiSort(Item1, Item2: Pointer): Integer;
var
   mview:TImageEnMView;
begin
	mview:=TImageEnMView( PIEImageInfo(Item1)^.parent );
	result := mview.fCurrentCompare( mview.fImageInfo.indexof(Item1), mview.fImageInfo.indexof(Item2) ); 
end;

procedure TImageEnMView.Sort(Compare: TIEImageEnMViewSortCompare);
var
	psel:integer;
begin
	if fImageInfo.Count>0 then begin
      SetPlaying(false);
      psel:=fSelectedItem;
      DeselectNU;
      fCurrentCompare:=Compare;
      fImageInfo.Sort( IEMultiSort );
      SetSelectedItemNU(psel);
      Update;
   end;
end;


{$else}	// {$ifdef IEINCLUDEMULTIVIEW}

interface
implementation

{$endif}


end.

