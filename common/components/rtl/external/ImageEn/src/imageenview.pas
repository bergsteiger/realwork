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

unit imageenview;

{$R-}
{$Q-}
{$HINTS OFF}

interface

{$I ie.inc}

(*$ifdef IEKYLIX*)
uses
	SysUtils, iekdef, Types, QGraphics, Classes, QForms, QExtCtrls, QStdCtrls, QControls,
	ieview, hyiedefs, hyieutils, imageenio,imageenproc;
(*$endif*)
(*$ifdef IEDELPHI*)
uses
   Windows, Messages, Graphics, Controls, Forms, Classes, SysUtils, StdCtrls,
   ExtCtrls, hyiedefs, hyieutils, imageenio,imageenproc,ieview;
(*$endif*)

type

   TIEGrip=(ieNone, ieTopLeft, ieTopRight, ieBottomRight, ieBottomLeft,
            ieLeftSide, ieRightSide, ieTopSide, ieBottomSide);

   TIEAlignment=(iejLeft,iejRight,iejCenter,iejJustify);

   // Notify view changement 0=Viewx/y, 1=zoom <---Change
   TViewChangeEvent = procedure(Sender: TObject; Change:integer) of object;

   TIEMouseInResizingGripEvent = procedure(Sender: TObject; Grip:TIEGrip) of object;

   TIEZoomEvent = procedure(Sender: TObject; var NewZoom:double) of object;

   TIEScrollCommand=(iescPosition, iescBottom, iescTop, iescLineDown, iescLineUp, iescPageDown, iescPageUp);

   // handled mouse events
   TIEMouseInteractItems=(
                           miZoom,				// Click-sx zoom-in / click-dx zoom-out
                           miScroll,				// Hand navigation
                           miSelect,				// Rectangular selection
                           miSelectPolygon,	// Polygonal selection
                           miSelectCircle,		// Circular selection
                           miSelectZoom,		// Zoom in rectangle
                           miSelectMagicWand, // Magic Wand selection
                           miSelectLasso,		// Polygonal selection
                           miMoveLayers,		// Move layers
                           miResizeLayers		// Resize layers
                         );
   TIEMouseInteract=set of TIEMouseInteractItems;

   TIESelectionBase=(iesbClientArea, // select coordinates over client area
                     iesbBitmap);		// select coordinates over bitmap

   TIEBackgroundStyle=(iebsSolid, iebsHorizontal, iebsVertical,
                       iebsFDiagonal, iebsBDiagonal, iebsCross, iebsDiagCross,
                       iebsChessboard, iebsDiagonals, iebsCropped, iebsCropShadow, iebsGradient);

   TIESelectionOptions=set of (iesoAnimated, iesoSizeable, iesoMoveable, iesoFilled, iesoCutBorders, iesoMarkOuter, iesoCanScroll);

   TIESelOp=(iespReplace, iespAdd);

   TIEMagicWandMode=(iewInclusive, iewExclusive, iewGlobal);

   TIEVSoftShadow=class
      Enabled:boolean;
      Radius:double;
      OffsetX:integer;
      OffsetY:integer;
   end;

   TIEMagnifyStyle=(iemRectangle,iemEllipse);

   TIELayerMagnification=record
   	Enabled:boolean;
      Rate:double;	// must be >=1
      Style:TIEMagnifyStyle;
   end;

	TIELayer=class
   	private
      	fToFree:boolean;   // we need to free Bitmap and AlphaChannel (assigned to false just before destroy if this is current layer)
         ResizedWidth,ResizedHeight:integer;	// 0=original sizes
         function GetWidth:integer;
         function GetHeight:integer;
   	public
      	Bitmap:TIEBitmap;
      	Visible:boolean;  // if True the layer is visible
         VisibleBox:boolean;
      	Transparency:integer; // 255=opaque 0=transparency
      	PosX,PosY:integer;
         ClientAreaBox:TRect;
         Cropped:boolean;
         Locked:boolean;
         Magnify:TIELayerMagnification;
			Operation:TIERenderOperation;
         property Width:integer read GetWidth write ResizedWidth;	// display width of the layer
         property Height:integer read GetHeight write ResizedHeight; // display height of the layer
      	constructor Create(TemplateBitmap:TIEBitmap; JustAssign:boolean);
      	destructor Destroy; override;
  	end;

   TIELayerEvent=(ielSelected, ielMoved, ielResized, ielMoving, ielResizing);

   TIELayerNotify=procedure(Sender:TObject; layer:integer; event:TIELayerEvent) of object;

   TImageEnView = class(TIEView)
   private
      /////////////////////////
      // P R I V A T E   IN TIMAGEN
      fLegacyBitmap:boolean; // false=use TIEBitmap, true=use TBitmap
      fUseDrawDibDraw:boolean;	// for same behavior of old versions set it to True
      fLCursor:TCursor;		// Saved cursor
      fCursor:TCursor;
      fOnImageChange:TNotifyEvent;
      fOnViewChange:TViewChangeEvent;
      fCenter:boolean;	// center image
      fZoomFilter:TResampleFilter;
      fSaveZoomFilter:TResampleFilter;	// saved zoomfilter from mousedown to mouseup
      fDelayZoomFilter:boolean; // if true enables fStable, delay zoom filter
      fBackgroundStyle:TIEBackgroundStyle;
      fMagicWandMaxFilter:boolean; // if true apply a max filter to the selection
      fMagicWandTolerance:integer; // 0..255 tolerance
      fMagicWandMode:TIEMagicWandMode;
      fRXScroll,fRYScroll:double;
      fDisplayGrid:boolean;
      fVScrollBarVisible,fHScrollBarVisible:boolean;
      fAniCounter:integer;
      fOnPaint:TNotifyEvent;
      fOnMouseInResizingGrip:TIEMouseInResizingGripEvent;
      fOnZoomIn,fOnZoomOut:TIEZoomEvent;
      fDelayDisplaySelection:boolean;
      fOnProgress:TIEProgressEvent;
      fFullUpdateRequest:boolean;	// true when Paint requires to repaint full image without cliprect, Paint event set to False
      fBlockPaint: boolean;
      fRectMoving:boolean;   // true if we are moving a rectangle
      fDrawVersion:boolean;
      fOnDrawBackBuffer:TNotifyEvent;
      fOnLayerNotify:TIELayerNotify;
      fSelectionAspectRatio:double;	// -1 auto aspect , 0=absolute (fSelectionAbsWidth,fSelectionAbsHeight), >0 specify aspect
      fSelectionAbsWidth:integer;
      fSelectionAbsHeight:integer;
      //
      fLutLastZoom:double;  // last zoom used by CreateCoordConvLUT
      fLutLastFRX:integer;	// last frx used by CreateCoordConvLUT
      fLutLastFRY:integer;	// last fry used by CreateCoordConvLUT
      fLutLastMaxLayerWidth:integer;	// fMaxLayerWidth used by CreateCoordConvLUT
      fLutLastMaxLayerHeight:integer;	// fMaxLayerHeight used by CreateCoordConvLUT
      // handscroll
      fHSVX1,fHSVY1:integer; // view in mouse down
      //
      fo1x,fo1y,fo2x,fo2y:integer;
      frx,fry:integer;
      //
      fBitmapWidth,fBitmapHeight:integer;	// monitoring bitmap size
      // transition effects
      fTransition:TIETransitionEffects;		// effect engine
      fTransitionEffect:TIETransitionType;	// transition type
      fTransitionDuration:integer;				// transition duration ms
      //
      {$ifdef IEKYLIX}
      fOldVScrollBarPos:integer;
      fOldHScrollBarPos:integer;
      {$endif}
      {$ifdef IEINCLUDEDIRECTSHOW}
      fOnDShowNewFrame:TNotifyEvent;
      fOnDShowEvent:TNotifyEvent;
      {$endif}
      //
      procedure AniPolyFunc(Sender:TObject; UseLockPaint:boolean);
      procedure TimerEvent(Sender:TObject);
      procedure SetViewX(v:integer);
      procedure SetViewY(v:integer);
      procedure SetZoom(v:double);
      function GetSelX1:integer;
      function GetSelY1:integer;
      function GetSelX2:integer;
      function GetSelY2:integer;
      procedure SetCenter(v:boolean);
      function GetMouseInteract:TIEMouseInteract;
      procedure SetBackgroundStyle(v:TIEBackgroundStyle);
      procedure DoSelectionChange;
      procedure DoSelectionChanging;
      procedure DoBeforeSelectionChange;
      procedure SetSelectionOptions(v:TIESelectionOptions);
      function GetResizingGrip(x,y:integer; Shift: TShiftState):TIEGrip;
      function GetMovingGrip(x,y:integer; Shift: TShiftState):integer;
      function SelectResizeEx(grip:TIEGrip; newx,newy:integer; aspectratio:boolean):TIEGrip;
      function SelectMoveEx(fMoving,ox,oy:integer):integer;
      function GetScrollBarsAlwaysVisible:boolean;
      procedure SetScrollBarsAlwaysVisible(v:boolean);
      procedure SetDisplayGrid(v:boolean);
      function GetTransitionRunning:boolean;
      function GetLayersCount:integer;
      function GetLayer(idx:integer):TIELayer;
      procedure PaintSelection(OutBitmap:TBitmap);
      procedure PaintGrid(OutBitmap:TBitmap);
      procedure SetCursor(Value:TCursor);
      procedure SetDelayTimer(Value:integer);
      function GetDelayTimer:integer;
      procedure SetGradientEndColor(Value:TColor);
      procedure DoDrawVersion;
      procedure SetDrawVersion(v:boolean);
      procedure SetSelectionMaskDepth(value:integer);
      procedure DrawLayerBox(ABitmap:TBitmap; idx:integer);
      procedure DrawLayerGrips(ABitmap:TBitmap; idx:integer);
      procedure CalcLayerGripCoords( layeridx:integer; var coords:array of TRect );
      function FindLayerGrip(x,y:integer):TIEGrip;
      procedure MouseResizeLayer(lx,ly:integer);
      procedure DShowNewFrame(var Message:TMessage); message IEM_NEWFRAME;
      procedure DShowEvent(var Message:TMessage); message IEM_EVENT;
      procedure MouseSelectCircle(x,y:integer; Shift:TShiftState);
      procedure MouseSelectRectangle(x,y:integer; Shift:TShiftState);
    procedure SetAutoFit(const Value: boolean);
    procedure SetAutoShrink(const Value: boolean);
    procedure SetAutoStretch(const Value: boolean);
	protected
      ///////////////////////
      // P R O T E C T E D
      // view and selections stabilization
      fStableReset:integer;	// initial fStable value (also available as public property)
      fStable2Reset:integer;	// initial fStable2 value
      fStable:integer;	// stability counter (0=stable) , decremented each AniPolyFunc
                       // setted by SetZoom, SetView## (used for ZoomFilter)
      fStable2:integer;	// secondary stablity counter (for selections)
      //
      fDBToDraw:boolean; // if true draw fTBitmap
      fTBitmap:TBitmap; // back buffer for DoubleBuffer
      fTBitmapScanline:ppointerarray;
      fViewX,fViewY:integer;
      fZoom:double;			// zoom percentage (starting at 1)
      fZoomD100:double;		// fZoom/100
      f100DZoom:double;		// 100/fZoom
      fHDrawDib:HDRAWDIB;		// direct draw on the screen
      fScrollBars:TScrollStyle;
      fLockPaint:integer;		// 0=paint locked
      fOffX,fOffY:integer;	// start of view (for centered images)
      fExtX,fExtY:integer;	// view extent
      fZZWW,fZZHH:integer;	// size of zoomed bitmap
      fBitmap:TBitmap;
      fBitmapInfoHeader256:TBitmapInfoHeader256;	// used by DrawTo and PaintRect
      fDoubleBuffer:boolean;	// always true (not used)
      fAutoFit:boolean;
      fUpdateInvalidate:boolean; // Se true (default) Update chiamerà Invalidate
      fRightBottomGap:double;   // used GetMaxViewXY
      fAutoStretch:boolean;
      fAutoShrink:boolean;
      // selections
      fSel:boolean;	// True when the selection is active
      fPolySelecting:boolean; // True on polygonal selection
      fLassoSelecting:boolean; // True on polygonal and lasso selection
      fRectSelecting:boolean; // True on rectangular selection
      fCircSelecting:boolean; // True on circular selection
      fRectResizing:TIEGrip;	 // if <>ieNone we are resizing rectangular selection
      fSelectMoving:integer;	// if >-1 selection moving
      fMMoveX,fMMoveY:integer; // used on fPolySelecting
      fHSX1,fHSY1:integer;	// mouse down coordinates
      fPredX,fPredY:integer;	// last call to MouseMove coordinates
      fPredLX,fPredLY:integer;	// last call to MouseMove coordinates (real coordinates)
      fHPolySel:PIEAnimPoly;	// pointer to the current animated polygon
      fSelectionBase:TIESelectionBase; // coordinate system for selection (bitmap or client area)
      fOnSelectionChanging:TNotifyEvent;
      fOnSelectionChange:TNotifyEvent;
      fOnBeforeSelectionChange:TNotifyEvent;
      fOnMouseInSel:TNotifyEvent;
      fSelectionOptions:TIESelectionOptions;
      fStartingPolyCount:integer; // polycount at MouseDown time
      fSelectionMask:TIEMask;	  // selection mask
      fSelectionMaskDepth:integer;	// selection mask depth
      fSelectionIntensity:integer;	// must be 1 if fSelectionMaskDepth is 1, otherwise a value from 0 to 255
      fSelColor1,fSelColor2:TColor;   // selection colors
      fGripColor1,fGripColor2:TColor; // grip color
      fGripBrushStyle:TBrushStyle;
      fGripSize:integer;
      fExtendedGrips:boolean;
      fChessboardSize:integer;
      fChessboardBrushStyle:TBrushStyle;
      fForceALTkey:boolean;
      fMouseMoveScrolling:boolean;	// true if we are inside MouseMoveScroll
      fSavedSelection:TList;	// list of saved selections
      fEnableShiftKey:boolean;	// Enable/disable shift key to add multi selections
      fGradientEndColor:TColor;
      fUpdateLocked:boolean;
      // animated polygons
      fAnimPoly:TList;				// animated polygons list (TIEAnimPoly)
      fAnimPolyTimer:TTimer;	   // animation timer
      //
      fMouseInteract:TIEMouseInteract;
      fScrollBarsAlwaysVisible:boolean; // true if the scrollbars are always visible
      fVScrollBarParams:TIEScrollBarParams;
      fHScrollBarParams:TIEScrollBarParams;
      fMouseWheelParams:TIEMouseWheelParams;
      flx1,fly1,flx2,fly2:integer;
      // alpha channel
      fEnableAlphaChannel:boolean;
      //
      fIEBitmap:TIEBitmap;   // contains also the alpha channel
      // encapsulated components
      fImageEnIO:TImageEnIO;
      fImageEnProc:TImageEnProc;
      // layers
      fLayers:TList;   // list of TIELayer objects
      fLayersCurrent:integer; // 0=first layer
      fMaxLayerWidth:integer;
      fMaxLayerHeight:integer;
      fLayersSync:boolean;	// true=layers will have same size (default)
      fLayersDrawBox:boolean;
      fMovingLayer:integer;	// -1/0 no layers moving, >0 moving a layer
      fLayerResizing:TIEGrip;	// ieNone no layer grip
      // convertion LUT
      fGXScr2Bmp,fGYScr2Bmp:pintegerarray;	// LUT used to convert bitmap based coordinate to screen
      fXScr2Bmp,fYScr2Bmp:pintegerarray;	// LUT used to convert bitmap based coordinate to screen
      fXScr2BmpSize,fYScr2BmpSize:integer;	// size of fXScr2Bmp LUT
      fXBmp2Scr,fYBmp2Scr:pintegerarray;	// LUT used to convert screen based coordinate to bitmap
      fGXBmp2Scr,fGYBmp2Scr:pintegerarray;	// LUT used to convert screen based coordinate to bitmap
      fXBmp2ScrSize,fYBmp2ScrSize:integer;	// size of fYScr2Bmp LUT
      //
      procedure CalcEdges(var EdgeX,EdgeY:integer; NoVertSB,NoHorizSB:boolean);
      procedure SetBackGround(cl:TColor); override;
      procedure PolyDraw1;
      procedure SetScrollBars(v:TScrollStyle); virtual;
      procedure GetMaxViewXY(var mx,my:integer);
      function GetFitValue:double;
      function GetOptimalZoom(ibitmapwidth,ibitmapheight,iwidth,iheight:integer; bolStretch,bolShrink:Boolean):double;
      // cross platform events
      procedure DoSize;
      procedure DoVertScroll(command:TIEScrollCommand; Position:integer);
      procedure DoHorizScroll(command:TIEScrollCommand; Position:integer);
      procedure DoMouseWheelScroll(Delta:integer; mouseX,mouseY:integer; CtrlPressed:boolean);
      procedure DoDoubleClickEx(Shift:boolean);
      // platform specific events
      (*$ifdef IEDELPHI*)
      procedure WMSize(var Message: TWMSize); message WM_SIZE;
      procedure WMEraseBkgnd(var Message:TMessage); message WM_ERASEBKGND;
      procedure WMVScroll(var Message:TMessage); message WM_VSCROLL;
      procedure WMHScroll(var Message:TMessage); message WM_HSCROLL;
      procedure WMMouseWheel(var Message:TMessage); message WM_MOUSEWHEEL;
      function _CreatePalette:HPalette;
      function PaletteChanged(Foreground: Boolean): Boolean; override;
      procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
      procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
      procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
      procedure CMWantSpecialKey(var Msg: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
      procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
      procedure IEMUpdate(var Message: TMessage); message IEM_UPDATE;
      (*$endif*)
      {$ifdef IEKYLIX}
      procedure OnVertScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer); override;
      procedure OnHorizScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer); override;
      procedure Resize; override;
      {$endif}
      //
      procedure SaveCursor(newc:TCursor);
      procedure RestoreCursor;
      procedure ShowSelectionEx(d:boolean);
      procedure HideSelectionEx(dd:boolean);
      function GetIdealComponentWidth:integer;
      function GetIdealComponentHeight:integer;
      procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
      procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
      procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
      function GetPolySel(idx:integer):TPoint;
      function GetPolySelCount:integer;
      procedure SetMouseInteract(v:TIEMouseInteract); virtual;
      procedure AnimPolygonAddPtEx(ap:integer; x,y:integer);
      procedure AnimPolygonMove(ap:integer; ox,oy:integer; max_x,max_y:integer; CutSel:boolean);
      procedure AnimPolygonAddBreak(ap:integer);
      procedure AnimPolygonRemoveLast(ap:integer);
      procedure AnimPolygonRemoveLastPoint(ap:integer);
      procedure ViewChange(c:integer); virtual;
      procedure SetZoomFilter(v:TResampleFilter);
      procedure SubMouseMoveScroll(scx,scy:integer); virtual;
      function MouseMoveScroll:boolean;
      function GetFBitmap:TBitmap; override;
      function GetIEBitmap:TIEBitmap; override;
      procedure SetVisibleSelection(vv:boolean);
      function GetVisibleSelection:boolean;
      function GetPolySelArray:PPointArray;
      procedure KeyDown(var Key: Word; Shift: TShiftState); override;
      procedure KeyUp(var Key: Word; Shift: TShiftState); override;
      procedure KeyPress(var Key: Char); override;
      procedure AddSelPointEx(x,y:integer);
      procedure AddSelBreakEx;
      procedure SelectEx(x1,y1,x2,y2:integer; Op:TIESelOp; aspectratio:boolean);
      function GetClientWidth:integer; virtual;
      function GetClientHeight:integer; virtual;
      function HasParentWindow:boolean; virtual;
      procedure SetSelColor1(v:TColor);
      procedure SetSelColor2(v:TColor);
      function GetImageEnIO:TImageEnIO;
      function GetImageEnProc:TImageEnProc;
      procedure SetEnableAlphaChannel(v:boolean);
      procedure SetOnProgress(v:TIEProgressEvent); virtual;
      function GetOnProgress:TIEProgressEvent; virtual;
      function GetHasAlphaChannel:boolean; override;
      function GetAlphaChannel:TIEBitmap; override;
      function GetIsEmpty:boolean; virtual;
      function RequiresScrollBars:boolean;
      procedure SetLayersCurrent(Value:integer); virtual;
      procedure DoLayersSync;
      procedure SetLegacyBitmap(Value:boolean); virtual;
      procedure CreateCoordConvLUT; virtual;
      procedure CalcPaintCoords; virtual;
      procedure CalcPaintCoordsEx(var XSrc,YSrc,SrcWidth,SrcHeight:integer; var DstWidth,DstHeight:integer; tViewX,tViewY:integer);
      procedure SetZoomNoUpdate(v:double); virtual;
      procedure UpdateLimits; virtual;
      function QuantizeViewX(vx:integer):integer;
      function QuantizeViewY(vy:integer):integer;
      procedure HideHorizScrollBar;
      procedure HideVertScrollBar;
      procedure SetSelectionIntensity(value:integer);
      procedure SetLayersSync(value:boolean);
      procedure SetLayersDrawBox(value:boolean);
      procedure DoLayerNotify(layer:integer; event:TIELayerEvent); virtual;
      procedure SetTempCursor(Value:TCursor);
      procedure WMCopy(var Message: TMessage); message WM_Copy;
      procedure WMCut(var Message: TMessage); message WM_CUT;
	public
      /////////////////////
      // P U B L I C
      constructor Create(Owner: TComponent); override;
      destructor Destroy; override;
      procedure Paint; override;
      procedure PaintToEx(ABitmap:TBitmap; ABitmapScanline:ppointerarray; UpdRect:PRect); virtual;
      // Selection
      {$ifdef IESUPPORTDEFPARAMS}
      procedure Select(x1,y1,x2,y2:integer; Op:TIESelOp=iespReplace); virtual;
      procedure SelectMagicWand(x,y:integer; Op:TIESelOp=iespReplace);
      procedure SelectEllipse(CenterX,CenterY,Width,Height:integer; Op:TIESelOp=iespReplace);
      {$else}
      procedure Select(x1,y1,x2,y2:integer; Op:TIESelOp); virtual;
      procedure SelectMagicWand(x,y:integer; Op:TIESelOp);
      procedure SelectEllipse(CenterX,CenterY,Width,Height:integer; Op:TIESelOp);
      {$endif}
      procedure MoveSelection(OffsetX,OffsetY:integer);
      property SelectionAspectRatio:double read fSelectionAspectRatio write fSelectionAspectRatio;
      property SelectionAbsWidth:integer read fSelectionAbsWidth write fSelectionAbsWidth;
      property SelectionAbsHeight:integer read fSelectionAbsHeight write fSelectionAbsHeight;
      procedure DeSelect;
      property SelX1:integer read GetSelx1;
      property SelY1:integer read GetSely1;
      property SelX2:integer read GetSelx2;
      property SelY2:integer read GetSely2;
      procedure AddSelPoint(x,y:integer); virtual;
      procedure AddSelBreak;
      property PolySel[idx:integer]:TPoint read GetPolySel;
      property PolySelCount:integer read GetPolySelCount;
      property PolySelPoints:PPointArray read GetPolySelArray;
      property Selected:boolean read fSel;
      property VisibleSelection:boolean read GetVisibleSelection write SetVisibleSelection;
      property MagicWandMaxFilter:boolean read fMagicWandMaxFilter write fMagicWandMaxFilter;
      property MagicWandTolerance:integer read fMagicWandTolerance write fMagicWandTolerance;
      property MagicWandMode:TIEMagicWandMode read fMagicWandMode write fMagicWandMode;
      function IsPointInsideSelection(x,y:integer):boolean;
      property SelectionMask:TIEMask read fSelectionMask;
      procedure InvertSelection;
      procedure SetSelectedAreaAlpha(Alpha:integer);
      procedure SetSelectionGripStyle(GripColor1,GripColor2:TColor; GripBrushStyle:TBrushStyle; GripSize:integer; ExtendedGrips:boolean);
      procedure CopySelectionToBitmap(DestBitmap:TBitmap);
      procedure CopySelectionToIEBitmap(DestBitmap:TIEBitmap);
      procedure EndSelect; virtual;
      procedure SetSelectedPixelsColor(color:TRGB);
      procedure SetAlphaRangePixelsColor(alphaMin, alphaMax:integer; color:TRGB);
      procedure SaveSelectionToStream(Stream:TStream);
      function LoadSelectionFromStream(Stream:TStream):boolean;
      procedure SaveSelection;
      function RestoreSelection:boolean;
      property EnableShiftKey:boolean read fEnableShiftKey write fEnableShiftKey;
      property SelectionMaskDepth:integer read fSelectionMaskDepth write SetSelectionMaskDepth;
      property SelectionIntensity:integer read fSelectionIntensity write SetSelectionIntensity;
      procedure MakeSelectionFeather(radius:double);
      // Animated polygons
      function AnimPolygonNew(VColor1,VColor2:TColor; VAnimated:boolean; VSizeable:boolean):integer;
      procedure AnimPolygonDel(ap:integer);
      procedure AnimPolygonAddPt(ap:integer; x,y:integer);
      procedure AnimPolygonClear(ap:integer);
      // Polygon process
      procedure CopyFromPolygon(Source:TBitmap; const Polygon:array of TPoint; PolygonLen:integer; const Position:TPoint);
      procedure CopyToPolygon(Dest:TBitmap; const Polygon:array of TPoint; PolygonLen:integer; const Position:TPoint);
      // Display
      procedure Update; override;
      procedure UpdateNoPaint;
      procedure Fit;
      procedure FitToWidth;
      procedure FitToHeight;
      function GetIdealZoom:double;
      property ViewX:integer read fViewX write SetViewX;
      property ViewY:integer read fViewY write SetViewY;
      procedure CenterImage;
      procedure SetViewXY(x,y:integer);
      property Zoom:double read fZoom write SetZoom;
      procedure ZoomSelection;
      procedure ZoomAt(x,y:integer; ZoomVal:double);
      property ClientWidth read GetClientWidth;
      property ClientHeight read GetClientHeight;
      property IdealComponentWidth:integer read GetIdealComponentWidth;
      property IdealComponentHeight:integer read GetIdealComponentHeight;
      procedure LockPaint; override;
      function UnLockPaint:integer; override;
      function NPUnLockPaint:integer; override;
      property LockPaintCount:integer read fLockPaint;
      procedure DrawTo(Canvas:TCanvas);
      property OffsetX:integer read fOffX;
      property OffsetY:integer read fOffY;
      property ExtentX:integer read fExtX;
      property ExtentY:integer read fExtY;
      property ScrollBarsAlwaysVisible:boolean read GetScrollBarsAlwaysVisible write SetScrollBarsAlwaysVisible default false;
      property VScrollBarParams:TIEScrollBarParams read fVScrollBarParams;
      property HScrollBarParams:TIEScrollBarParams read fHScrollBarParams;
      procedure UpdateRect(rclip:TRect);
      procedure PaintRect(const rc:TRect);
      property RightBottomGap:double read fRightBottomGap write fRightBottomGap;
      procedure LockUpdate;
      procedure UnLockUpdate;
      property BackBuffer:TBitmap read fTBitmap;
      // layers
      property LayersCount:integer read GetLayersCount;
      property LayersCurrent:integer read fLayersCurrent write SetLayersCurrent;
      function LayersAdd:integer;
      procedure LayersInsert(Position:integer);
      procedure LayersRemove(idx:integer);
      procedure LayersMove(CurIndex,NewIndex:integer);
      procedure LayersMerge(Layer0, Layer1:integer);
      property Layers[idx:integer]:TIELayer read GetLayer;
      property MaxLayerWidth:integer read fMaxLayerWidth;
      property MaxLayerHeight:integer read fMaxLayerHeight;
      property LayersSync:boolean read fLayersSync write SetLayersSync;
      property LayersDrawBox:boolean read fLayersDrawBox write SetLayersDrawBox;
      function FindLayerAt(x,y:integer):integer;
      // Other
      property GradientEndColor:TColor read fGradientEndColor write SetGradientEndColor;
      property MouseCapture;
      procedure Assign(Source: TPersistent); override;
      procedure AssignSelTo(Dest: TPersistent);
      procedure ImageChange; override;
      function YScr2Bmp(y:integer):integer;
      function XScr2Bmp(x:integer):integer;
      function YBmp2Scr(y:integer):integer;
      function XBmp2Scr(x:integer):integer;
      procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
      property SelColor1:TColor read fSelColor1 write SetSelColor1 default clBlack;
      property SelColor2:TColor read fSelColor2 write SetSelColor2 default clWhite;
      procedure Clear;
      procedure Blank;
      property DisplayGrid:boolean read fDisplayGrid write SetDisplayGrid;
      property MouseWheelParams:TIEMouseWheelParams read fMouseWheelParams;
      procedure SetChessboardStyle(Size:integer;BrushStyle:TBrushStyle);
      property ForceALTkey:boolean read fForceALTkey write fForceALTkey;
      property DelayDisplaySelection:boolean read fDelayDisplaySelection write fDelayDisplaySelection;
      property DelayZoomTime:integer read fStableReset write fStableReset;
      property DelayTimer:integer read GetDelayTimer write SetDelayTimer;
      procedure CopyToBitmapWithAlpha(Dest:TBitmap; DestX,DestY:integer);
      property UseDrawDibDraw:boolean read fUseDrawDibDraw write fUseDrawDibDraw;
      function GetGripAt(x,y:integer):TIEGrip;
      {$ifdef IESUPPORTDEFPARAMS}
      procedure RemoveAlphaChannel(Merge:boolean=false); override;
      {$else}
      procedure RemoveAlphaChannel(Merge:boolean); override;
      {$endif}
      property IsEmpty:boolean read GetIsEmpty;
      // encapsulated components
      property IO:TImageEnIO read GetImageEnIO;
      property Proc:TImageEnProc read GetImageEnProc;
      // transitions
      property TransitionRunning:boolean read GetTransitionRunning;
      procedure PrepareTransition;
      procedure RunTransition(Effect:TIETransitionType; duration:integer);
	published
      ///////////////////////
      // P U B L I S H E D
      property LegacyBitmap:boolean read fLegacyBitmap write SetLegacyBitmap default true;
      property DoubleBuffer:boolean read fDoubleBuffer write fDoubleBuffer default true; // not used
      property ZoomFilter:TResampleFilter read fZoomFilter write SetZoomFilter default rfNone;
      property ScrollBars:TScrollStyle read fScrollBars write SetScrollBars default ssBoth;
      property OnViewChange:TViewChangeEvent read fOnViewChange write fOnViewChange;
      property OnImageChange:TNotifyEvent read fOnImageChange write fOnImageChange;
      property SelectionOptions:TIESelectionOptions read fSelectionOptions write SetSelectionOptions default [iesoAnimated,iesoSizeable,iesoMoveable,iesoCanScroll];
      property Center:boolean read fCenter write SetCenter default true;
      property MouseInteract:TIEMouseInteract read GetMouseInteract write SetMouseInteract default [];
      property AutoFit:boolean read fAutoFit write SetAutoFit default false;
      property SelectionBase:TIESelectionBase read fSelectionBase write fSelectionBase default iesbClientArea;
      property BackgroundStyle:TIEBackgroundStyle read fBackgroundStyle write SetBackgroundStyle default iebsSolid;
      property OnSelectionChange:TNotifyEvent read fOnSelectionChange write fOnSelectionChange;
      property OnSelectionChanging:TNotifyEvent read fOnSelectionChanging write fOnSelectionChanging;
      property OnMouseInSel:TNotifyEvent read fOnMouseInSel write fOnMouseInSel;
      property DelayZoomFilter:boolean read fDelayZoomFilter write fDelayZoomFilter default false;
      property OnPaint:TNotifyEvent read fOnPaint write fOnPaint;
      property EnableAlphaChannel:boolean read fEnableAlphaChannel write SetEnableAlphaChannel default false;
      property OnMouseInResizingGrip:TIEMouseInResizingGripEvent read fOnMouseInResizingGrip write fOnMouseInResizingGrip;
      property OnZoomIn:TIEZoomEvent read fOnZoomIn write fOnZoomIn;
      property OnZoomOut:TIEZoomEvent read fOnZoomOut write fOnZoomOut;
      property OnProgress:TIEProgressEvent read GetOnProgress write SetOnProgress;
      property AutoStretch:boolean read fAutoStretch write SetAutoStretch default false;
      property AutoShrink:boolean read fAutoShrink write SetAutoShrink default false;
      property OnBeforeSelectionChange:TNotifyEvent read fOnBeforeSelectionChange write fOnBeforeSelectionChange;
      property DrawVersion:boolean read fDrawVersion write SetDrawVersion default false;
      property OnDrawBackBuffer:TNotifyEvent read fOnDrawBackBuffer write fOnDrawBackBuffer;
      property OnLayerNotify:TIELayerNotify read fOnLayerNotify write fOnLayerNotify;
      {$ifdef IESUPPORTANCHORS}
      property Anchors;
      {$endif}
      {$ifdef IEMOUSEWHEELEVENTS}
      property OnMouseWheel;
      property OnMouseWheelDown;
      property OnMouseWheelUp;
      {$endif}
      (*$ifdef IEDELPHI*)
      property DragCursor;
      (*$endif*)
      {$ifdef IEINCLUDEDIRECTSHOW}
      property OnDShowNewFrame:TNotifyEvent read fOnDShowNewFrame write fOnDShowNewFrame;
      property OnDShowEvent:TNotifyEvent read fOnDShowEvent write fOnDShowEvent;
      {$endif}
      property Cursor:TCursor read fCursor write SetCursor default 1785;
      property Align;
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


{$ifdef IEDELPHI}
procedure SetSBPageSize(HScrollBar : THandle ; fnBar:integer; PageSize : Integer; Redraw:boolean);
function IEDrawGradient(R: TRect; DC: HDC; ColorStart, ColorStop: TColor; bVertical:boolean): Boolean;
{$endif}
function _IsRectangle(p:PPointArray; n:integer):boolean;

procedure IEDrawBackground(ComponentState:TComponentState; Canvas:TCanvas; fBackgroundStyle:TIEBackgroundStyle; fBackGround:TColor; DestX,DestY,Width,Height:integer; x1,y1,x2,y2:integer; fChessboardSize:integer; fChessboardBrushStyle:TBrushStyle; fGradientEndColor:TColor); forward;

implementation

{$ifdef IEDELPHI}
uses  NeurQuant,
      {$ifdef IEINCLUDEDIRECTSHOW}
      ieds,
      {$endif}
  Clipbrd,
  l3Base
		;

{$R IMRES.RES}
{$endif}

{$ifdef IEKYLIX}
uses neurquant;
{$endif}

{$R-}

{$ifdef IEDELPHI}



const
	GRADIENT_FILL_RECT_V = $00000001;
   GRADIENT_FILL_RECT_H = $00000000;

type
	Trivertex = packed record
   	X, Y: DWORD;
    	Red, Green, Blue, Alpha: Word;
  	end;

  	TGradientFill = function(DC: HDC; pVertex: Pointer; dwNumVertex: DWORD; pMesh: Pointer; dwNumMesh, dwMode: DWORD): LongBool; stdcall;

  	TRGBRec = packed record
   	case Integer of
      	1: (RGBVal: LongInt);
      	0: (Red, Green, Blue, None: Byte);
  	end;

  	TGradientRect = packed record
   	UpperLeft: ULONG;
   	LowerRight: ULONG;
  	end;

var
	FhGradientFill: HMODULE;
	FGradientFill: TGradientFill;

function LoadGradLibrary:boolean;
begin
   result:=True;
   if FhGradientFill=0 then begin
   	FhGradientFill := LoadLibrary('MSIMG32.DLL');
    	if FhGradientFill > 0 then
      	FGradientFill := GetProcAddress(FhGradientFill, 'GradientFill')
    	else
      	result:=false; // MSIMG32 could not be loaded
   end;
end;


function IEDrawGradient(R: TRect; DC: HDC; ColorStart, ColorStop: TColor; bVertical:boolean): Boolean;
var
	Gr: TGradientRect;
	Vert: array[0..1] of Trivertex;
	StartColor, StopColor: TRGBRec;
begin
	result:=LoadGradLibrary;
	if not result then exit;
   StartColor.RGBVal := ColorToRGB(ColorStart);
   StopColor.RGBVal := ColorToRGB(ColorStop);

   Gr.UpperLeft := 0;
   Gr.LowerRight := 1;

   Vert[0].x := r.TopLeft.x;
   Vert[0].y := r.TopLeft.y;
   Vert[0].Red := StartColor.Red shl 8;
   Vert[0].Green := StartColor.Green shl 8;
   Vert[0].Blue := StartColor.Blue shl 8;
   Vert[0].Alpha := $0000;

   Vert[1].x := r.BottomRight.x;
   Vert[1].y := r.BottomRight.y;
   Vert[1].Red := StopColor.Red shl 8;
   Vert[1].Green := StopColor.Green shl 8;
   Vert[1].Blue := StopColor.Blue shl 8;
   Vert[1].Alpha := $0000;

   if bVertical then
   	Result := FGradientFill(DC, @Vert, 2, @Gr, 1, GRADIENT_FILL_RECT_V)
   else
     	Result := FGradientFill(DC, @Vert, 2, @Gr, 1, GRADIENT_FILL_RECT_H);
end;

{$endif}


// Set cursor size (pagesize) of a scroll bar
// fnBar can be SB_HORZ or SB_VERT
(*$ifdef IEDELPHI*)
Procedure SetSBPageSize(HScrollBar : THandle ; fnBar:integer; PageSize : Integer; Redraw:boolean);
Var
   ScrollInfo : TScrollInfo ;
Begin
   ScrollInfo.cbSize:=Sizeof (ScrollInfo) ;
  	ScrollInfo.fMask:=SIF_PAGE;
   ScrollInfo.nPage:=PageSize ;
   SetScrollInfo(HScrollBar, fnBar, ScrollInfo, Redraw) ;
End;
(*$endif*)

// Initialize (load) corsors
procedure InitCursors;
(*$ifdef IEDELPHI*)
const
	imcur=1777;
   curnum=18;
   curname:array [1..curnum] of string=('ZOOMMENO',	// 1778
   												 'ZOOMPIU',		// 1779
                                        'CROCE',		// 1780
                                        'GOMMA',		// 1781
                                        'MANO',			// 1782
                                        'PENNA',		// 1783
                                        'CROCE1',		// 1784
                                        'CROCE3',		// 1785
                                        'MOVE2',		// 1786
                                        'MOVEY',		// 1787
                                        'MOVE1',		// 1788
                                        'MOVEX',		// 1789
                                        'MOVE',			// 1790
                                        'CROCE3+',		// 1791
                                        'CROCE3-',		// 1792
                                        'CROCE2',		// 1793
                                        'CROCE2+',		// 1794
                                        'CROCE2-'		// 1793
                                        );
var
	q:integer;
begin
	for q:=1 to curnum do
		//Screen.Cursors[imcur+q]:=LoadCursor(GetModuleHandle(nil), PAnsiChar(curname[q]));
      Screen.Cursors[imcur+q]:=LoadCursor(sysinit.hinstance, PAnsiChar(curname[q]));
end;
(*$else*)
begin
end;
(*$endif*)

/////////////////////////////////////////////////////////////////////////////////////
constructor TImageEnView.Create(Owner: TComponent);
begin
	fUpdateLocked:=true;
   fGXScr2Bmp:=nil;
   fGYScr2Bmp:=nil;
   fGXBmp2Scr:=nil;
   fGYBmp2Scr:=nil;
   fXScr2BmpSize:=0;
   fYScr2BmpSize:=0;
   fXBmp2ScrSize:=0;
   fYBmp2ScrSize:=0;
   fXScr2Bmp:=nil;
   fYScr2Bmp:=nil;
   fXBmp2Scr:=nil;
   fYBmp2Scr:=nil;
   //
   fImageEnIO:=nil;
   fImageEnProc:=nil;
   fLegacyBitmap:=true;
   fBitmap:=TBitmap.create;
   fBitmap.pixelformat:=pf24bit;
	{$ifndef OCXVERSION}
   fBitmap.Width:=Width;
   fBitmap.Height:=Height;
	{$endif}
   inherited Create(Owner);
   fIEBitmap:=TIEBitmap.Create;
   fIEBitmap.EncapsulateTBitmap(fBitmap,true);
   fMaxLayerWidth:=fIEBitmap.Width;
   fMaxLayerHeight:=fIEBitmap.Height;
   // layers
   fLayers:=TList.Create;
   fLayers.Add( TIELayer.Create(fIEBitmap,true) );
   with TIELayer( fLayers[0] ) do begin
   	VisibleBox:=false;
      Locked:=true;
   end;
   fLayersCurrent:=0;
   //
   fTBitmapScanline:=nil;
   fTransition:=TIETransitionEffects.Create(self);
   fTransitionEffect:=iettNone;
   fTransitionDuration:=1000;
   fVScrollBarVisible:=false;
   fHScrollBarVisible:=false;
   fScrollBarsAlwaysVisible:=false;
   fRXScroll:=1;
   fRYScroll:=1;
   fSelectionOptions:=[iesoAnimated,iesoSizeable,iesoMoveable,iesoCanScroll];
   fOnViewChange:=nil;
   fOnImageChange:=nil;
   fDelayZoomFilter:=false;
   fZoomFilter:=rfNone;
   fDBToDraw:=true;
   fFullUpdateRequest:=true;
   l3ZeroMemory(@fBitmapInfoHeader256,sizeof(TBitmapInfoHeader256));
   fMouseInteract:=[];
   fLockPaint:=0;
   (*$ifdef IEDELPHI*)
   fHDrawDib:=IEDrawDibOpen;
   (*$endif*)
	(*$ifdef IEKYLIX*)
   fHDrawDib:=0;
   (*$endif*)
   InitCursors;
   fCursor:=1785;
   inherited Cursor:=fCursor;
   fScrollBars:=ssBoth;
   fZoom:=100;
   fZoomD100:=fZoom/100;
   f100DZoom:=100/fZoom;
   Height:=105;
   Width:=105;
   fOffX:=0;
   fOffY:=0;
   fExtX:=0;
   fExtY:=0;
   fCenter:=true;
   fDoubleBuffer:=true;
	SetDPI(gDefaultDPIX,gDefaultDPIY);
   fPolySelecting:=False;
   fLassoSelecting:=False;
   fRectSelecting:=False;
   fCircSelecting:=False;
   fRectResizing:=ieNone;
   fSelectMoving:=-1;
   fSel:=false;
   fAnimPoly:=TList.Create;
   fAnimPolyTimer:=TTimer.Create(nil);
   fAnimPolyTimer.enabled:=false;
   fAnimPolyTimer.Interval:=210;
   fAnimPolyTimer.OnTimer:=TimerEvent;
   fHPolySel:=PIEAnimPoly(AnimPolygonNew(clBlack,clWhite,True,True));
   if not (csDesigning in ComponentState) then begin
   	fTBitmap:=TBitmap.Create;	// double buffer
      fTBitmap.PixelFormat:=pf24bit;
	   HideSelectionEx(false);
   end;
   fUpdateInvalidate:=true;
   fSelectionBase:=iesbClientArea;
   fBackgroundStyle:=iebsSolid;
   fOnSelectionChange:=nil;
   fOnSelectionChanging:=nil;
   fOnBeforeSelectionChange:=nil;
   fMagicWandMaxFilter:=false;
   fMagicWandMode:=iewInclusive;
   fMagicWandTolerance:=15;
   fOnMouseInSel:=nil;
   fOnMouseInResizingGrip:=nil;
   fOnZoomIn:=nil;
   fOnZoomOut:=nil;
   fDisplayGrid:=false;
   fVScrollBarParams:=TIEScrollBarParams.Create;
	fHScrollBarParams:=TIEScrollBarParams.Create;
   fMouseWheelParams:=TIEMouseWheelParams.Create;
   fSelectionMaskDepth:=1;
   fSelectionIntensity:=1;
   fSelectionMask:=TIEMask.Create;
   fSelectionMask.AllocateBits(fIEBitmap.Width,fIEBitmap.Height,fSelectionMaskDepth);
   fAniCounter:=0;
   SelColor1:=clBlack;
   SelColor2:=clWhite;
   fGripColor1:=clBlack;
   fGripColor2:=clWhite;
   fGripBrushStyle:=bsSolid;
   fGripSize:=5;
   fExtendedGrips:=true;
   fChessboardSize:=16;
   fChessboardBrushStyle:=bsSolid;
   fOnPaint:=nil;
   fOnProgress:=nil;
   fForceALTkey:=false;
   fEnableAlphaChannel:=false;
   fDelayDisplaySelection:=true;
   fRightBottomGap:=0.5;
   fAutoStretch:=false;
   fAutoShrink:=false;
   fBlockPaint:=false;
   fRectMoving:=false;
   fMouseMoveScrolling:=false;
   fSavedSelection:=TList.Create;
   fEnableShiftKey:=true;
   fStableReset:=4;
   fStable2Reset:=2;
   fLutLastZoom:=-1;
   fLutLastFRX:=-1;
   fLutLastFRY:=-1;
   fLutLastMaxLayerWidth:=-1;
   fLutLastMaxLayerHeight:=-1;
   (*$ifdef IEKYLIX*)
   LegacyBitmap:=False;
   fOldVScrollBarPos:=-1;
   fOldHScrollBarPos:=-1;
   (*$endif*)
   fGradientEndColor:=clBlue;
   fUseDrawDibDraw:=false;	// for same behavior of old versions set it to True
   fDrawVersion:=false;
   fUpdateLocked:=false;
   fOnDrawBackBuffer:=nil;
   fLayersSync:=true;
   fLayersDrawBox:=false;
   fMovingLayer:=-1;
   fLayerResizing:=ieNone;
   fOnLayerNotify:=nil;
   {$ifdef IEINCLUDEDIRECTSHOW}
   fOnDShowNewFrame:=nil;
   fOnDShowEvent:=nil;
   {$endif}
   fSelectionAspectRatio:=-1;
   fSelectionAbsWidth:=100;
   fSelectionAbsHeight:=100;
end;

/////////////////////////////////////////////////////////////////////////////////////
destructor TImageEnView.Destroy;
var
   i:integer;
begin
	DoLayersSync;
	fTransition.free;
	if assigned(fImageEnIO) then
   	fImageEnIO.free;
   if assigned(fImageEnProc) then
		fImageEnProc.free;
   if assigned(fBitmap) then begin
      fBitmap.free;
      fBitmap:=nil;
   end;
   fIEBitmap.free;
   fIEBitmap:=nil;
   if not (csDesigning in ComponentState) then begin
	   // free double buffer
	   fTBitmap.free;
      fTBitmap:=nil;
   end;
   fAnimPolyTimer.free;
   while fAnimPoly.Count>0 do begin
      freemem(PIEAnimPoly(fAnimPoly[0])^.Poly);	// free vertex array
      freemem(PIEAnimPoly(fAnimPoly[0]));	// free TIEAnimPoly structure
      fAnimPoly.Delete(0);
   end;
   fAnimPoly.free;
   (*$ifdef IEDELPHI*)
   IEDrawDibClose(fHDrawDib);
   (*$endif*)
	fVScrollBarParams.free;
   fHScrollBarParams.free;
   fMouseWheelParams.free;
   fSelectionMask.free;
   if fTBitmapScanline<>nil then
      freemem(fTBitmapScanline);
   // free layers
   for i:=0 to fLayers.Count-1 do begin
      if i=fLayersCurrent then
         TIELayer(fLayers[i]).fToFree:=false;   // do not free Bitmap and AlphaChannel
      TIELayer(fLayers[i]).Free;
   end;
   fLayers.Free;
   //
   while fSavedSelection.Count>0 do begin
   	TObject(fSavedSelection[0]).Free;
      fSavedSelection.Delete(0);
   end;
   fSavedSelection.Free;
   //
   if fGXScr2Bmp<>nil then
   	freemem(fGXScr2Bmp);
   if fGYScr2Bmp<>nil then
   	freemem(fGYScr2Bmp);
	if fGXBmp2Scr<>nil then
   	freemem(fGXBmp2Scr);
   if fGYBmp2Scr<>nil then
   	freemem(fGYBmp2Scr);
   fGXScr2Bmp:=nil;
   fGYScr2Bmp:=nil;
   fGXBmp2Scr:=nil;
   fGYBmp2Scr:=nil;
   fXScr2BmpSize:=0;
   fYScr2BmpSize:=0;
   fXBmp2ScrSize:=0;
   fYBmp2ScrSize:=0;
   //
   inherited;
end;

procedure TImageEnView.SetBackGround(cl:TColor);
begin
	inherited SetBackGround(cl);
   if csDesigning in ComponentState then
   	Clear;
   Update;
   ImageChange;
end;

procedure TImageEnView.DoSize;
begin
   if fTransition.Running then fTransition.stop;
   Update;
end;

procedure TImageEnView.SetScrollBars(v:TScrollStyle);
begin
{$ifdef IEDELPHI}
	fScrollBars:=v;
	if (fScrollBars<>ssVertical) and (fScrollBars<>ssBoth) then
	   ShowScrollBar(handle,SB_VERT,false);
	if (fScrollBars<>ssHorizontal) and (fScrollBars<>ssBoth) then
		ShowScrollBar(handle,SB_HORZ,false);
   Update;
{$endif}
end;

procedure TImageEnView.SetZoomNoUpdate(v:double);
var
	zz:double;
	max_x,max_y:integer;
   x,y:integer;
begin
   zz:=v/100;
   x:=GetClientWidth shr 1;
   x:=trunc(round((x+fViewX-fOffX)*(f100DZoom))*zz-x);
   y:=GetClientHeight shr 1;
   y:=trunc(round((y+fViewY-fOffY)*(f100DZoom))*zz-y);
   GetMaxViewXY(max_x,max_y);
   if x>max_x then fViewX:=max_x
   else if x<0 then fViewX:=0
   else fViewX:=x;
   if y>max_y then fViewY:=max_y
   else if y<0 then fViewY:=0
   else fViewY:=y;
   //
   fZoom:=v;
   fZoomD100:=fZoom/100;
   f100DZoom:=100/fZoom;
   //
end;

procedure TImageEnView.SetZoom(v:double);
begin
	if (v>0) and (v<>fZoom) then begin
   	if (fDelayZoomFilter) and (fZoomFilter<>rfNone) and (fZoom<>100) then
	   	fStable:=fStableReset;
      fStable2:=fStable2Reset;
   	LockPaint;
		SetZoomNoUpdate(v);
	   Update;  // initial update
      NPUnLockPaint;
      paint;
      LockPaint;
      Update;	// final update (without this scroll-bars aren't updated well)
      CalcPaintCoords;
      CreateCoordConvLUT; // recalculates coordinate convertion LUT
      NPUnLockPaint;
      ViewChange(1);
   end;
end;

// save the current cursor in fLCursor
procedure TImageEnView.SaveCursor(newc:TCursor);
begin
	fLCursor:=fCursor;
   SetCursor(newc);
end;

// restore the cursor for fLCursor
procedure TImageEnView.RestoreCursor;
begin
	SetCursor(fLCursor);
end;

// creates a palette for the current bitmap
{$ifdef IEDELPHI}

type
	tpal=record
   	palVersion:word;
      palNumEntries:word;
      PaletteEntry:array [0..255] of TPALETTEENTRY;
   end;
   plogpalette=^tlogpalette;

function TImageEnView._CreatePalette:HPalette;
var
   pa:tpal;
   pp:array [0..255] of TRGB;
   q:integer;
   qt:TIEQuantizer;
begin
	qt:=TIEQuantizer.Create(fIEBitmap, pp, 256, -1, 0);
	for q:=0 to 255 do begin
   	pa.PaletteEntry[q].peRed:=pp[q].r;
      pa.PaletteEntry[q].peGreen:=pp[q].g;
      pa.PaletteEntry[q].peBlue:=pp[q].b;
      pa.PaletteEntry[q].peFlags:=0;
   end;
   pa.palVersion:=$300;
   pa.palNumEntries:=256;
   qt.free;
   result:=CreatePalette(plogpalette(@pa)^);
end;

{$endif}

// ideal horizontal component size
function TImageEnView.GetIdealComponentWidth:integer;
var
	z1:integer;
begin
   z1:=trunc(fzoom*(fMaxLayerWidth/100));	// new width of the bitmap
	result:=z1+1;
   if (fScrollBars=ssHorizontal) or (fScrollBars=ssBoth) then
   	inc(result,width-GetClientWidth);
end;

// ideal vertical component size
function TImageEnView.GetIdealComponentHeight:integer;
var
	z2:integer;
begin
   z2:=trunc(fzoom*(fMaxLayerHeight/100));  // new height of the bitmap
	result:=z2+1;
   if (fScrollBars=ssVertical) or (fScrollBars=ssBoth) then
   	inc(result,height-GetClientHeight);
end;

procedure TImageEnView.DoMouseWheelScroll(Delta:integer; mouseX,mouseY:integer; CtrlPressed:boolean);
var
	zDelta,nPos,xTmp:integer;
   dPos:double;
   dir:integer;
begin
	if fMouseWheelParams.Action=iemwNone then
      exit;
   zDelta:=Delta;
   if zDelta>0 then dir:=-1 else dir:=1;
   if fMouseWheelParams.InvertDirection then dir:=-1*dir;
   case fMouseWheelParams.Action of
   	iemwVScroll:
         begin
          if fCenter then
          begin
           if (CtrlPressed and (fZZWW <= ClientWidth)) or
              (not CtrlPressed and (fZZHH <= ClientHeight)) then
            Exit;  
          end;
          case fMouseWheelParams.Variation of
           iemwAbsolute:	// bitmap based
            if CtrlPressed then
            begin
             // horizontal
             nPos:=fViewX+dir*fMouseWheelParams.Value*imax(trunc(fZoomD100),1);
             SetViewX( nPos );
            end
            else
            begin
             // vertical
             nPos:=fViewY+dir*fMouseWheelParams.Value*imax(trunc(fZoomD100),1);
             SetViewY( nPos );
            end;
           iemwPercentage: // client based
            if CtrlPressed then
            begin
             // horizontal
             xTmp:=imax(round(GetClientWidth*fMouseWheelParams.Value/100),1);
             nPos:=fViewX+dir*xTmp;
             SetViewX( nPos );
            end
            else
            begin
             // vertical
             xTmp:=imax(round(GetClientHeight*fMouseWheelParams.Value/100),1);
             nPos:=fViewY+dir*xTmp;
             SetViewY( nPos );
            end;
           end;
         end;
      iemwZoom:
      	begin
         	dPos:=fZoom;
            case fMouseWheelParams.Variation of
               iemwAbsolute:
               	dPos:=fZoom+dir*fMouseWheelParams.Value;
               iemwPercentage:
               	dPos:=fZoom + imax(round(fZoom*fMouseWheelParams.Value/100),1)*dir;
            end;
            if (dPos>fZoom) and assigned(fOnZoomIn) then
               fOnZoomIn(self,dPos);
            if (dPos<fZoom) and assigned(fOnZoomOut) then
               fOnZoomOut(self,dPos);
            if fMouseWheelParams.ZoomPosition=iemwCenter then
					SetZoom(dPos)
            else
            	ZoomAt(mouseX,mouseY,dPos);
         end;
   end;
end;

// Position is valid on when command is iescPosition
procedure TImageEnView.DoVertScroll(command:TIEScrollCommand; Position:integer);
var
	nPos:integer;
   mx,my:integer;
begin
	nPos:=0;
	case command of
   	iescPosition:
         nPos:=Position;
      iescBottom:
      	begin
         	GetMaxViewXY(mx,my);
	      	nPos:=my;
         end;
      iescTop:
      	nPos:=0;
      iescLineDown:
      	if fVScrollBarParams.LineStep=-1 then
	      	nPos:=fViewY+imax(trunc(fZoomD100),1)
         else
         	nPos:=fViewY+fVScrollBarParams.LineStep*imax(trunc(fZoomD100),1);
      iescLineUp:
      	if fVScrollBarParams.LineStep=-1 then
	      	nPos:=fViewY-imax(trunc(fZoomD100),1)
         else
         	nPos:=fViewY-fVScrollBarParams.LineStep*imax(trunc(fZoomD100),1);
      iescPageDown:
      	if fVScrollBarParams.PageStep=-1 then
            nPos:=fViewY+GetClientHeight
         else
         	nPos:=fViewY+fVScrollBarParams.PageStep*imax(trunc(fZoomD100),1);
      iescPageUp:
      	if fVScrollBarParams.PageStep=-1 then
            nPos:=fViewY-GetClientHeight
         else
         	nPos:=fViewY-fVScrollBarParams.PageStep*imax(trunc(fZoomD100),1);
   end;
   SetViewY( nPos );
end;

// Position is valid on when command is scPosition
procedure TImageEnView.DoHorizScroll(command:TIEScrollCommand; Position:integer);
var
	nPos:integer;
   mx,my:integer;
begin
	nPos:=0;
	case command of
   	iescPosition:
         nPos:=Position;
      iescBottom:
      	begin
         	GetMaxViewXY(mx,my);
	      	nPos:=mx;
         end;
      iescTop:
      	nPos:=0;
      iescLineDown:
      	if fHScrollBarParams.LineStep=-1 then
	      	nPos:=fViewX+imax(trunc(fZoomD100),1)
         else
         	nPos:=fViewX+fHScrollBarParams.LineStep*imax(trunc(fZoomD100),1);
      iescLineUp:
      	if fHScrollBarParams.LineStep=-1 then
	      	nPos:=fViewX-imax(trunc(fZoomD100),1)
         else
         	nPos:=fViewX-fHScrollBarParams.LineStep*imax(trunc(fZoomD100),1);
      iescPageDown:
      	if fHScrollBarParams.PageStep=-1 then
            nPos:=fViewX+GetClientWidth
			else
         	nPos:=fViewX+fHScrollBarParams.PageStep*imax(trunc(fZoomD100),1);
      iescPageUp:
      	if fHScrollBarParams.PageStep=-1 then
            nPos:=fViewX-GetClientWidth
         else
         	nPos:=fViewX-fHScrollBarParams.PageStep*imax(trunc(fZoomD100),1);
   end;
   SetViewX( nPos );
end;

{$ifdef IEDELPHI}
procedure TImageEnView.WMVScroll(var Message:TMessage);
var
	cmd:TIEScrollCommand;
	pos:integer;
begin
	inherited;
   pos:=0;
	case Message.WParamLo of
   	SB_THUMBTRACK,SB_THUMBPOSITION:
      	begin
         	if (not fVScrollBarParams.Tracking) and (Message.WParamLo=SB_THUMBTRACK) then
            	exit;
            cmd:=iescPosition;
            pos:=trunc(Message.WParamHi*fRYScroll);
      	end;
      SB_BOTTOM: cmd:=iescBottom;
      SB_TOP: cmd:=iescTop;
      SB_LINEDOWN: cmd:=iescLineDown;
      SB_LINEUP: cmd:=iescLineUp;
      SB_PAGEDOWN: cmd:=iescPageDown;
      SB_PAGEUP: cmd:=iescPageUp;
      else begin
      	cmd:=iescPosition;
         pos:=fViewY;
		end;
   end;
   DoVertScroll(cmd,pos);
end;

procedure TImageEnView.WMHScroll(var Message:TMessage);
var
	cmd:TIEScrollCommand;
	pos:integer;
begin
	inherited;
   pos:=0;
	case Message.WParamLo of
   	SB_THUMBTRACK,SB_THUMBPOSITION:
			begin
         	if (not fHScrollBarParams.Tracking) and (Message.WParamLo=SB_THUMBTRACK) then
            	exit;
            cmd:=iescPosition;
            pos:=trunc(Message.WParamHi*fRXScroll);
         end;
      SB_BOTTOM: cmd:=iescBottom;
      SB_TOP: cmd:=iescTop;
      SB_LINEDOWN: cmd:=iescLineDown;
      SB_LINEUP: cmd:=iescLineUp;
      SB_PAGEDOWN: cmd:=iescPageDown;
      SB_PAGEUP: cmd:=iescPageUp;
      else begin
      	cmd:=iescPosition;
      	pos:=fViewX;
      end;
   end;
   DoHorizScroll(cmd,pos);
end;

procedure TImageEnView.WMMouseWheel(var Message:TMessage);
begin
	inherited;
	DoMouseWheelScroll(smallint($ffff and (Message.wParam shr 16)), Message.LParamLo,Message.LParamHi, GetKeyState(VK_CONTROL)<0);
end;

// double click - end of polygonal selection
procedure TImageEnView.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
	inherited;
   DoDoubleClickEx( (MK_SHIFT and Message.Keys)<>0 );
end;

procedure TImageEnView.WMKillFocus(var Msg: TWMKillFocus);
begin
	inherited;
   invalidate;
end;

procedure TImageEnView.WMSetFocus(var Msg: TWMSetFocus);
begin
	inherited;
   invalidate;
end;

procedure TImageEnView.CMWantSpecialKey(var Msg: TCMWantSpecialKey);
begin
	inherited;
	case msg.CharCode of
  		VK_LEFT,VK_RIGHT,VK_UP,VK_DOWN,VK_PRIOR,VK_NEXT,VK_HOME, VK_END:
      	begin
		      msg.Result:=1;
            KeyUp(Msg.CharCode, KeyDataToShiftState(Msg.KeyData));
         end;
   end;
end;

procedure TImageEnView.WMNCPaint(var Message: TMessage);
begin
	inherited;
end;

procedure TImageEnView.IEMUpdate(var Message: TMessage);
begin
	Update;
end;

procedure TImageEnView.WMSize(var Message: TWMSize);
begin
  	inherited;
   DoSize;
end;

procedure TImageEnView.WMEraseBkgnd(var Message:TMessage);
begin
	Message.Result:=0;
end;

{$endif}	// end of IEDELPHI

{$ifdef IEKYLIX}

procedure TImageEnView.Resize;
begin
	inherited;
	Update;
end;

procedure TImageEnView.OnVertScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
var
	cmd:TIEScrollCommand;
	pos:integer;
begin
	pos:=0;
	case ScrollCode of
      scPosition,
      scTrack:
      	begin
            cmd:=iescPosition;
            pos:=ScrollPos;
         end;
		scLineUp: cmd:=iescLineUp;
      scLineDown: cmd:=iescLineDown;
      scPageUp: cmd:=iescPageUp;
      scPageDown: cmd:=iescPageDown;
      scTop: cmd:=iescTop;
      scBottom: cmd:=iescBottom;
      else begin
      	cmd:=iescPosition;
      	pos:=fViewY;
      end;
   end;
   DoVertScroll(cmd,pos);
end;

procedure TImageEnView.OnHorizScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
var
	cmd:TIEScrollCommand;
	pos:integer;
begin
	pos:=0;
	case ScrollCode of
      scPosition,
      scTrack:
      	begin
            cmd:=iescPosition;
            pos:=ScrollPos;
         end;
		scLineUp: cmd:=iescLineUp;
      scLineDown: cmd:=iescLineDown;
      scPageUp: cmd:=iescPageUp;
      scPageDown: cmd:=iescPageDown;
      scTop: cmd:=iescTop;
      scBottom: cmd:=iescBottom;
      else begin
      	cmd:=iescPosition;
      	pos:=fViewX;
      end;
   end;
   DoHorizScroll(cmd,pos);
end;

{$endif}

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnView.SetViewXY(x,y:integer);
var
	max_x,max_y:integer;
   lviewx,lviewy:integer;
begin
	lviewx:=fViewX;
   lviewy:=fViewY;
	if (x=fViewX) and (y=fViewY) then exit;
	GetMaxViewXY(max_x,max_y);
   if x>max_x then fViewX:=max_x
   else if x<0 then fViewX:=0
   else fViewX:=x;
   if y>max_y then fViewY:=max_y
   else if y<0 then fViewY:=0
   else fViewY:=y;
   if (fViewX=lviewx) and (fViewY=lviewy) then exit;
   if fDelayZoomFilter and (fZoomFilter<>rfNone) and (fZoom<>100) then
	   fStable:=fStableReset;
   fStable2:=fStable2Reset;
   fDBToDraw:=true;
   fFullUpdateRequest:=true;
   paint;
   ViewChange(0);
   if fSel then
   	AniPolyFunc(self,true);
   {$ifdef IEDELPHI}
   if (fScrollBars=ssHorizontal) or (fScrollBars=ssBoth) then
   	SetScrollPos(Handle,SB_HORZ,trunc(fViewX/fRXScroll),true);
	if (fScrollBars=ssVertical) or (fScrollBars=ssBoth) then
   	SetScrollPos(Handle,SB_VERT,trunc(fViewY/fRYScroll),true);
   {$endif}
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnView.SetViewX(v:integer);
var
	max_x,max_y:integer;
begin
	if v=fViewX then exit;
   if fDelayZoomFilter and (fZoomFilter<>rfNone) and (fZoom<>100) then
	   fStable:=fStableReset;
   fStable2:=fStable2Reset;
	GetMaxViewXY(max_x,max_y);
   if v>max_x then fViewX:=max_x
   else if v<0 then fViewX:=0
   else fViewX:=v;
   fDBToDraw:=true;
   fFullUpdateRequest:=true;
   paint;
   ViewChange(0);
   if fSel then
	   AniPolyFunc(self,true);
   {$ifdef IEDELPHI}
   if (fScrollBars=ssHorizontal) or (fScrollBars=ssBoth) then
   	SetScrollPos(Handle,SB_HORZ,trunc(fViewX/fRXScroll),true);
   {$endif}
end;

procedure TImageEnView.SetViewY(v:integer);
var
	max_x,max_y:integer;
begin
	if v=fViewY then exit;
   if fDelayZoomFilter and (fZoomFilter<>rfNone) and (fZoom<>100) then
	   fStable:=fStableReset;
   fStable2:=fStable2Reset;
	GetMaxViewXY(max_x,max_y);
   if v>max_y then fViewY:=max_y
   else if v<0 then fViewY:=0
   else fViewY:=v;
   fDBToDraw:=true;
   fFullUpdateRequest:=true;
   paint;
   ViewChange(0);
   if fSel then
	   AniPolyFunc(self,true);
   {$ifdef IEDELPHI}
   if (fScrollBars=ssVertical) or (fScrollBars=ssBoth) then
   	SetScrollPos(Handle,SB_VERT,trunc(fViewY/fRYScroll),true);
   {$endif}
end;

procedure TImageEnView.GetMaxViewXY(var mx,my:integer);
var
	z1,z2:integer;
begin
   z1:=trunc((fMaxLayerWidth)*fZoomD100);	// new bitmap width (zoom)
   z2:=trunc((fMaxLayerHeight)*fZoomD100);  // new bitmap height (zoom)
   // this avoid the bug loading a 11x11 in the open dialog
	if (z1>(GetClientWidth+10)) or (z2>(GetClientHeight+10)) then begin
      z1:=trunc((fMaxLayerWidth+fRightBottomGap)*fZoomD100);	// new bitmap width (zoom)
      z2:=trunc((fMaxLayerHeight+fRightBottomGap)*fZoomD100);  // new bitmap height (zoom)
   end;
	mx:=0; my:=0;
   if (z1>0) and (z2>0) then begin
   	mx:=z1-GetClientWidth;
		my:=z2-GetClientHeight;
      if (mx<0) or (XScr2Bmp(mx)=0) then mx:=0;
      if (my<0) or (YScr2Bmp(my)=0) then my:=0;
      if (z1<=Width) and (z2<=Height) then begin
      	mx:=0;
      	my:=0;
      end;
   end;
end;

(*
{$ifdef IEDELPHI}
procedure InitializeBitmapInfoHeader(Bitmap: HBITMAP; var BI: TBitmapInfoHeader;Colors: Integer);
var
	DS: TDIBSection;
	Bytes: Integer;
begin
	DS.dsbmih.biSize := 0;
	Bytes := GetObject(Bitmap, SizeOf(DS), @DS);
	if (Bytes >= (sizeof(DS.dsbm) + sizeof(DS.dsbmih))) and (DS.dsbmih.biSize >= sizeof(DS.dsbmih)) then
		BI := DS.dsbmih
	else begin
		FillChar(BI, sizeof(BI), 0);
		with BI, DS.dsbm do begin
			biSize := SizeOf(BI);
			biWidth := bmWidth;
			biHeight := bmHeight;
		end;
	end;
	if Colors <> 0 then
		case Colors of
			2: BI.biBitCount := 1;
			16: BI.biBitCount := 4;
			256: BI.biBitCount := 8;
		end
	else BI.biBitCount := DS.dsbm.bmBitsPixel * DS.dsbm.bmPlanes;
	BI.biPlanes := 1;
	if BI.biSizeImage = 0 then
		BI.biSizeImage := BytesPerScanLine(BI.biWidth, BI.biBitCount, 32) * Abs(BI.biHeight);
end;
{$endif}
*)

(*$ifdef IEDELPHI*)
function TImageEnView.PaletteChanged(Foreground: Boolean): Boolean;
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
(*$endif*)

// makes an event OnImageChange
procedure TImageEnView.ImageChange;
begin
	inherited;
   if assigned(fOnImageChange) then
  		fOnImageChange(self);
end;

procedure TImageEnView.Clear;
begin
	fIEBitmap.Fill(BackGround);
   RemoveAlphaChannel(false);
   Update;
end;

procedure TImageEnView.Blank;
begin
	if fTransition.Running then fTransition.stop;
	fIEBitmap.Width:=1;
   fIEBitmap.Height:=1;
   Clear;
end;

function TImageEnView.GetIsEmpty:boolean;
begin
   result:= (fIEBitmap.Width<2) and (fIEBitmap.Height<2);
end;

function TImageEnView.GetSelX1:integer;
begin
	if fPolySelecting or fRectSelecting or fCircSelecting or (fRectResizing<>ieNone) or fRectMoving then
		result:=fHPolySel^.rx1
   else
	   result:=fSelectionMask.X1;
end;

function TImageEnView.GetSelY1:integer;
begin
	if fPolySelecting or fRectSelecting or fCircSelecting or (fRectResizing<>ieNone) or fRectMoving then
		result:=fHPolySel^.ry1
   else
	   result:=fSelectionMask.Y1;
end;

function TImageEnView.GetSelX2:integer;
begin
	if fPolySelecting or fRectSelecting or fCircSelecting or (fRectResizing<>ieNone) or fRectMoving then
		result:=fHPolySel^.rx2-1
   else
	   result:=fSelectionMask.X2;
end;

function TImageEnView.GetSelY2:integer;
begin
	if fPolySelecting or fRectSelecting or fCircSelecting or (fRectResizing<>ieNone) or fRectMoving then
		result:=fHPolySel^.ry2-1
   else
	   result:=fSelectionMask.Y2;
end;

// convert an X bitmap based coordinate to a screen based coordinate
function TImageEnView.XBmp2Scr(x:integer):integer;
var
	xx:integer;
begin
	xx:=x-fo1x;
	if (xx<0) or (xx>=fXBmp2ScrSize) then
   	// aproximated value
	   result:=round( fOffX+(x+round((-QuantizeViewX(fViewX))*f100DZoom))*fZoomD100 )
   else
	   result:=fOffX+fXBmp2Scr[xx];
end;

// convert an Y bitmap base coordinate to a screen based coordinate
function TImageEnView.YBmp2Scr(y:integer):integer;
var
	yy:integer;
begin
	yy:=y-fo1y;
	if (yy<0) or (yy>=fYBmp2ScrSize) then
   	// aproximated value
		result:=round( fOffY+(y+round((-QuantizeViewY(fViewY))*f100DZoom))*fZoomD100 )
   else
	   result:=fOffY+fYBmp2Scr[yy];
end;

// convert an X screen based coordinate to a bitmap based coordinate
function TImageEnView.XScr2Bmp(x:integer):integer;
var
	xx:integer;
begin
	xx:=x-fOffX;
	if (xx<0) or (xx>=fXScr2BmpSize) then
   	// aproximated value
	   result:=trunc((X-fOffX)*f100DZoom+fo1x)
   else
   	result:=fXScr2Bmp[xx];
end;

// convert an Y screen coordinate to a bitmap based coordinate
function TImageEnView.YScr2Bmp(y:integer):integer;
var
	yy:integer;
begin
	yy:=y-fOffY;
	if (yy<0) or (yy>=fYScr2BmpSize) then
   	// aproximated value
	   result:=trunc((Y-fOffY)*f100DZoom+fo1y)
   else
   	result:=fYScr2Bmp[yy];
end;

// returns the best zoom level to display the image at autofit size
function TImageEnView.GetIdealZoom:double;
begin
	//result:=GetOptimalZoom(IEBitmap.Width,IEBitmap.Height,Width,Height,true,true);
   Result:=dmin( Width/(fMaxLayerWidth/100), Height/(fMaxLayerHeight/100) );
end;

procedure TImageEnView.CalcEdges(var EdgeX,EdgeY:integer; NoVertSB,NoHorizSB:boolean);
begin
   case fBackgroundStyle of
      iebsCropped:
         begin
            EdgeX:=gEdgeX;
            EdgeY:=gEdgeY;
         end;
      iebsCropShadow:
         begin
            EdgeX:=5;
            EdgeY:=5;
         end;
      else
         begin
         	if NoVertSB then
            	EdgeX:=gEdgeX
            else
            	EdgeX:=(Width-GetClientWidth) div 2;
            if NoHorizSB then
            	EdgeY:=gEdgeY
            else
            	EdgeY:=(Height-GetClientHeight) div 2;
         end;
   end;
end;

function TImageEnView.GetFitValue:double;
var
	EdgeX,EdgeY:integer;
begin
   CalcEdges(EdgeX,EdgeY,true,true);
   Result:=dmin( (Width-EdgeX*2)/(fMaxLayerWidth/100), (Height-EdgeY*2)/(fMaxLayerHeight/100) );
end;

procedure TImageEnView.Fit;
begin
	if (fMaxLayerWidth<>0) and (fMaxLayerHeight<>0) then begin
   	HideHorizScrollBar;
      HideVertScrollBar;
   	Zoom:=GetFitValue;
   end;
end;

function TImageEnView.GetOptimalZoom(ibitmapwidth,ibitmapheight,iwidth,iheight:integer; bolStretch,bolShrink:Boolean):double;
begin
	result:=100;
	try
	if (iwidth=0) or (iheight=0) or (ibitmapwidth=0) or (ibitmapheight=0) then exit;
   if (iBitmapHeight / iHeight)<(iBitmapWidth / iWidth) then begin  // width is important
   	if iBitmapWidth > iWidth then begin
      	if bolShrink=False then
         	result:= 100
         else
         	result:= GetFitValue;
      end else begin
      	if bolStretch=False then
         	result:= 100
         else
         	result:= GetFitValue;
      end;
   end else begin   // height is important
   	if iBitmapHeight > iHeight then begin
      	if  bolShrink=False then
         	result:= 100
         else
         	result:= GetFitValue;
      end else begin
      	if bolStretch=False then
         	result:= 100
         else
         	result:= GetFitValue;
         end;
   end;    // if wider than high
	except
  on E: Exception do
   l3System.Exception2Log(E);
 end;
end;

// makes a zoom inside the selected area
procedure TImageEnView.ZoomSelection;
var
	dx,dy:integer;
   x1,y1:integer;
   cx,cy:integer;
   z:double;
begin
	if fSel then begin
		dx:=Selx2-Selx1+1;
	   dy:=Sely2-Sely1+1;
      x1:=SelX1;
      y1:=SelY1;
      if (x1<0) or (y1<0) or (dx<2) or (dy<2) then exit;
      Deselect;
	   Zoom:= dmin( Width/(dx/100), Height/(dy/100));
      z:=Zoom/100;
      x1:=trunc(x1*z); dx:=trunc(dx*z);
      y1:=trunc(y1*z); dy:=trunc(dy*z);
     	cy:=(GetClientHeight-dy) div 2;
      cx:=(GetClientWidth-dx) div 2;
      setviewxy(x1-cx,y1-cy);
   end;
end;

// called by "initialization"
procedure InitImageEnView;
(*$ifdef IEDELPHI*)
var
   hdc:THANDLE;
begin
 // bits per pixel of display
 hdc:=getdc(0);
	gSystemColors:=GetDeviceCaps(hdc,BITSPIXEL);
 releasedc(0,hdc);
 // find DPI
 hdc:=GetDC(0);
 gSystemDPIX:=GetDeviceCaps(hdc,LOGPIXELSX);
	gSystemDPIY:=GetDeviceCaps(hdc,LOGPIXELSY);
 gDefaultDPIX:=300;
	gDefaultDPIY:=300;
 ReleaseDC(0,hdc);
 // verify MMX
	gMMX:=IEMMXSupported;
 //
 gEdgeX:=GetSystemMetrics(SM_CXEDGE);
 gEdgeY:=GetSystemMetrics(SM_CYEDGE);
 gVScrollWidth:=GetSystemMetrics(SM_CYHSCROLL);
 gHScrollHeight:=GetSystemMetrics(SM_CXVSCROLL);
 FhGradientFill:=0;
end;
(*$endif*)
(*$ifdef IEKYLIX*)
begin
	gSystemColors:=32;
   gSystemDPIX:=72;
   gSystemDPIY:=72;
   gMMX:=false;
   gEdgeX:=0;
   gEdgeY:=0;
end;
(*$endif*)

// Inc fLockPaint counter
procedure TImageEnView.LockPaint;
begin
	inc(fLockPaint);
end;

// Dec fLockPaint counter
// return current fLockPaint value (after Dec)
// Call Update if fLockPaint=0
function TImageEnView.UnLockPaint:integer;
begin
	if fLockPaint>0 then
   	dec(fLockPaint);
   if fLockPaint=0 then
   	Update;
   result:=fLockPaint;
end;

// Dec fLockPaint counter
// return current fLockPaint value (after Dec)
function TImageEnView.NPUnLockPaint:integer;
begin
	if fLockPaint>0 then
   	dec(fLockPaint);
   result:=fLockPaint;
end;

// zoom to ZoomVal at x,y coordinates (client area coordinates)
procedure TImageEnView.ZoomAt(x,y:integer; ZoomVal:double);
var
	zz:double;
begin
	LockPaint;
   x:=XScr2Bmp(x);
   y:=YScr2Bmp(y);
   Zoom:=ZoomVal;
   zz:=Zoom/100;
   SetViewXY(trunc(x*zz- (GetClientWidth div 2)),trunc(y*zz- (GetClientHeight div 2)));
   UnLockPaint;
end;

procedure TImageEnView.DrawTo(Canvas:TCanvas);
begin
   Canvas.CopyRect( Rect(0,0,frx,fry), fTBitmap.Canvas, Rect(fOffX,fOffY,fOffX+frx,fOffY+fry) );
end;

function TImageEnView.HasParentWindow:boolean;
begin
	{$ifdef IEDELPHI}
   result:= (GetParentForm(self)<>nil) or (ParentWindow<>0);
   {$endif}
	{$ifdef IEKYLIX}
   result:= GetParentForm(self)<>nil;
   {$endif}
end;

procedure TImageEnView.UpdateNoPaint;
begin
   try
   	fBlockPaint:=true;
   	Update;
   finally
   	fBlockPaint:=false;
   end;
end;

function TImageEnView.RequiresScrollBars:boolean;
var
   max_x,max_y:integer;
begin
   GetMaxViewXY(max_x,max_y);
   result:= (max_x>0) or (max_y>0);
end;

procedure TImageEnView.HideHorizScrollBar;
begin
   fHScrollBarVisible:=false;
   {$ifdef IEDELPHI}
   ShowScrollBar(handle,SB_HORZ,false);
   {$endif}
   {$ifdef IEKYLIX}
   HorzScrollBar.Visible:=false;
   {$endif}
end;

procedure TImageEnView.HideVertScrollBar;
begin
   fVScrollBarVisible:=false;
   {$ifdef IEDELPHI}
   ShowScrollBar(handle,SB_VERT,false);
   {$endif}
   {$ifdef IEKYLIX}
   VertScrollBar.Visible:=false;
   {$endif}
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnView.Update;
var
	max_x,max_y:integer;
   lClientWidth,lClientHeight:integer;
   bb:boolean;
	EdgeX,EdgeY:integer;
begin
	if fUpdateLocked then
   	exit;
	if (ComponentState=[csDesigning]) and (not HasParentWindow) then
   	exit;
	{$ifdef IEFIXUPDATE}
   if (ComponentState<>[]) and (ComponentState<>[csDesigning]) and (ComponentState<>[csFreeNotification]) then
   	exit;
   {$else}
   if (ComponentState<>[]) and (ComponentState<>[csDesigning]) then
		exit;
	{$endif}
   // check layers sizes (all layers must have same sizes)
   DoLayersSync;
   //
   if (fAutoStretch or fAutoShrink or fAutoFit) and (fMaxLayerWidth<>0) and (fMaxLayerHeight<>0) then begin
      case fBackgroundStyle of
         iebsCropped:
            begin
               EdgeX:=gEdgeX;
               EdgeY:=gEdgeY;
            end;
         iebsCropShadow:
            begin
               EdgeX:=5;
               EdgeY:=5;
            end;
         else
         	begin
	            EdgeX:=(Width-GetClientWidth) div 2;
   	         EdgeY:=(Height-GetClientHeight) div 2;
            end;
      end;
      if (fMaxLayerWidth<2) and (fMaxLayerHeight<2) then
      	fZoom:=100
      else
			fZoom:=GetOptimalZoom(fMaxLayerWidth,fMaxLayerHeight,(GetClientWidth-EdgeX*2),(GetClientHeight-EdgeY*2),
                             fAutoStretch or fautofit,fAutoShrink or fautofit);
      if fZoom<1 then fZoom:=1;
      fZoomD100:=fZoom/100;
      f100DZoom:=100/fZoom;
      CalcPaintCoords;
      CreateCoordConvLUT; // recalculates coordinate convertion LUT
      ViewChange(1);
      fStable:=0;
      fStable2:=0;
   end;
   // check bitmap size changes
   if (fBitmapWidth<>fIEBitmap.Width) or (fBitmapHeight<>fIEBitmap.Height) then begin
      fBitmapWidth:=fIEBitmap.Width;
      fBitmapHeight:=fIEBitmap.Height;
      if fSel then
          Deselect;
      fSelectionMask.AllocateBits(fIEBitmap.Width,fIEBitmap.Height,fSelectionMaskDepth);
      if fIEBitmap.HasAlphaChannel and ((fIEBitmap.AlphaChannel.Width<>fIEBitmap.Width) or (fIEBitmap.AlphaChannel.Height<>fIEBitmap.Height)) then begin
         fIEBitmap.AlphaChannel.Allocate(fIEBitmap.Width,fIEBitmap.Height,ie8g);
         fIEBitmap.AlphaChannel.Fill(255);
      end;
   end;
   if not (csDesigning in ComponentState) then begin
   	// Save client sizes because the scrollbar changes the client area, then we have to recall Update (recursive call)
      lClientWidth:=GetClientWidth;
      lClientHeight:=GetClientHeight;
   	//
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
      if HasParentWindow and ((fScrollBars=ssHorizontal) or (fScrollBars=ssBoth)) then begin
         if max_x>0 then begin
         	// we need horizontal scroll bar
            fHScrollBarVisible:=true;
            fRXScroll:=(max_x+GetClientWidth)/65536;
            (*$ifdef IEDELPHI*)
            SetScrollRange(Handle,SB_HORZ,0,65535,false);
            SetSBPageSize(Handle,SB_HORZ,trunc(GetClientWidth/fRXScroll),true);
            SetScrollPos(Handle,SB_HORZ,trunc(fViewX/fRXScroll),false);
            EnableScrollBar(Handle,SB_HORZ,ESB_ENABLE_BOTH);
            ShowScrollBar(handle,SB_HORZ,true);
            (*$endif*)
            {$ifdef IEKYLIX}
            HorzScrollBar.Visible:=true;
            HorzScrollBar.Max:=max_x(*+GetClientWidth*);
            HorzScrollBar.Position:=fViewX;
            {$endif}
         end else if fScrollBarsAlwaysVisible then begin
         	// the scroll bar is always visible
            fHScrollBarVisible:=true;
            (*$ifdef IEDELPHI*)
            EnableScrollBar(Handle,SB_HORZ,ESB_DISABLE_BOTH);
            ShowScrollBar(handle,SB_HORZ,true);
            (*$endif*)
         end else begin
         	// we don't need the horizontal scroll bar
         	HideHorizScrollBar;
         end;
      end;
      if HasParentWindow and ((fScrollBars=ssVertical) or (fScrollBars=ssBoth)) then begin
         if max_y>0 then begin
         	// we need vertical scroll bar
            fVScrollBarVisible:=true;
            fRYScroll:=(max_y+GetClientHeight)/65536;
            (*$ifdef IEDELPHI*)
            SetScrollRange(Handle,SB_VERT,0,65535,false);
            SetSBPageSize(Handle,SB_VERT,trunc(GetClientHeight/fRYScroll),true);
            SetScrollPos(Handle,SB_VERT,trunc(fViewY/fRYScroll),false);
            EnableScrollBar(Handle,SB_VERT,ESB_ENABLE_BOTH);
            ShowScrollBar(handle,SB_VERT,true);
            (*$endif*)
            {$ifdef IEKYLIX}
            VertScrollBar.Visible:=true;
            VertScrollBar.Max:=max_y(*+GetClientHeight*);
            VertScrollBar.Position:=fViewY;
            {$endif}
         end else if fScrollBarsAlwaysVisible then begin
         	// the scroll bar is always visible
            fVScrollBarVisible:=true;
            (*$ifdef IEDELPHI*)
            EnableScrollBar(Handle,SB_VERT,ESB_DISABLE_BOTH);
            ShowScrollBar(handle,SB_VERT,true);
            (*$endif*)
         end else begin
         	// we don't need the vertical scroll bar
         	HideVertScrollBar;
         end;
      end;
      except
       on E: Exception do
        l3System.Exception2Log(E);
      end;
      if (lClientWidth<>GetClientWidth) or (lClientHeight<>GetClientHeight) then
          Update;	// recursive, see above
   end;
   //
   UpdateLimits;
   //
   fDBToDraw:=true;
   fFullUpdateRequest:=true;
   if HasParentWindow and (fBlockPaint=false) and fUpdateInvalidate then
      invalidate;
end;

procedure TImageEnView.UpdateLimits;
begin
   fZZWW:=round(fMaxLayerWidth*fZoomD100);  // new Bitmap width
   fZZHH:=round(fMaxLayerHeight*fZoomD100); // new Bitmap height
   fOffX:=0; fOffY:=0;
   if not (csDesigning in ComponentState) then begin
      fExtX:=imin(fZZWW,GetClientWidth);				 // width of target bitmap
      fExtY:=imin(fZZHH,GetClientHeight);				 // height of target bitmap
      if fCenter then begin
         // center the image
         if fExtx<GetClientWidth then
             fOffX:=(GetClientWidth-fExtx) shr 1;
         if fExty<GetClientHeight then
             fOffY:=(GetClientHeight-fExty) shr 1;
      end;
   end else begin
      fExtX:=imin(fZZWW,Width);
      fExtY:=imin(fZZHH,Height);
   end;
end;

procedure TImageEnView.SetCenter(v:boolean);
begin
	if v<>fCenter then begin
		fCenter:=v;
      Update;
   end;
end;

procedure TImageEnView.SetMouseInteract(v:TIEMouseInteract);
begin
	if v<>fMouseInteract then begin
   	if fPolySelecting and (miSelectPolygon in fMouseInteract) then begin
      	AnimPolygonRemoveLastPoint(integer(fHPolySel));
      	fSelectionMask.Empty;
         EndSelect;
         fPolySelecting:=False;
         invalidate;
      end;
   	//
      if (miScroll in v) and not (miScroll in fMouseInteract) then	// miScroll
      	v:=v-[miSelect,miSelectPolygon,miSelectCircle,miSelectZoom,miSelectMagicWand,miSelectLasso,miMoveLayers,miResizeLayers]
      else if (miSelect in v) and not (miSelect in fMouseInteract) then	// miSelect
      	v:=v-[miSelectPolygon,miSelectCircle,miScroll,miSelectZoom,miSelectMagicWand,miSelectLasso,miMoveLayers,miResizeLayers]
      else if (miSelectPolygon in v) and not (miSelectPolygon in fMouseInteract) then	// miSelectPolygon
      	v:=v-[miSelect,miScroll,miSelectCircle,miSelectZoom,miZoom,miSelectMagicWand,miSelectLasso,miMoveLayers,miResizeLayers]
      else if (miSelectCircle in v) and not (miSelectCircle in fMouseInteract) then	// miSelectCircle
      	v:=v-[miSelect,miSelectPolygon,miScroll,miSelectZoom,miSelectMagicWand,miSelectLasso,miMoveLayers,miResizeLayers]
      else if (miSelectLasso in v) and not (miSelectLasso in fMouseInteract) then	// miSelectLasso
      	v:=v-[miSelect,miSelectPolygon,miScroll,miSelectZoom,miSelectMagicWand,miSelectCircle,miMoveLayers,miResizeLayers]
      else if (miSelectZoom in v) and not (miSelectZoom in fMouseInteract) then	// miSelectZoom
      	v:=v-[miScroll,miSelect,miSelectCircle,miSelectPolygon,miSelectMagicWand,miSelectLasso,miMoveLayers,miResizeLayers]
      else if (miZoom in v) and not (miZoom in fMouseInteract) then	// miZoom
      	v:=v-[miSelectPolygon,miSelectMagicWand,miMoveLayers,miResizeLayers]
      else if (miSelectMagicWand in v) and not (miSelectMagicWand in fMouseInteract) then	// miSelectMagicWand
      	v:=v-[miSelect,miScroll,miSelectCircle,miSelectZoom,miZoom,miSelectPolygon,miSelectLasso,miMoveLayers,miResizeLayers]
      else if (miMoveLayers in v) then // miMoveLayers
      	v:=v-[miSelect,miScroll,miSelectCircle,miSelectZoom,miZoom,miSelectPolygon,miSelectLasso,miSelectMagicWand]
      else if (miResizeLayers in v) then // miResizeLayers
      	v:=v-[miSelect,miScroll,miSelectCircle,miSelectZoom,miZoom,miSelectPolygon,miSelectLasso,miSelectMagicWand];
      fMouseInteract:=v;
   end;
end;

// track mouse move for polygonal selection
procedure TImageEnView.PolyDraw1;
var
	x,y:integer;
begin
   if fPolySelecting and (not fLassoSelecting) then begin
	   canvas.pen.mode:=pmNot;
		canvas.pen.width:=1;
	   canvas.pen.style:=psSolid;
      with fHPolySel^ do
      	if PolyCount>0 then begin
		      canvas.moveto(fMMoveX,fMMoveY);
            x:=XBmp2Scr(Poly^[PolyCount-1].x);
            y:=YBmp2Scr(Poly^[PolyCount-1].y);
            canvas.lineto(x,y);
			end;
	end;
end;

// paint the specified rect on control Canvas
procedure TImageEnView.PaintRect(const rc:TRect);
var
	q:integer;
   dx,dy:integer;
   ur:trect;
	{$ifdef IEDEBUG}
	t1:dword;
   {$endif}
begin
	if not HasParentWindow then
   	exit;
	{$ifdef IEDEBUG}
	t1:=gettickcount;
   {$endif}
	// prepare the back buffer
   if (fTBitmap.Width<>GetClientWidth) or (fTBitmap.Height<>GetClientHeight) then begin
      fTBitmap.Width:=GetClientWidth;
      fTBitmap.Height:=GetClientHeight;
      //
      {$ifdef IEDELPHI}
      if fTBitmapScanline<>nil then
         freemem(fTBitmapScanline);
      getmem(fTBitmapScanline,fTBitmap.Height*sizeof(pointer));
      for q:=0 to fTBitmap.Height-1 do
         fTBitmapScanline[q]:=fTBitmap.Scanline[q];
      {$endif}
      //
      fDBToDraw:=true;
   end;
   // draw on the back buffer
   if fDBToDraw then begin
      ur:=rc;
      PaintToEx(fTBitmap,fTBitmapScanline,@ur);
		if assigned(fOnDrawBackBuffer) then
      	fOnDrawBackBuffer(self);
      {$ifdef DEMOVERSION}
      _ctrlview(ftbitmap.canvas);
      {$endif}
      fDBToDraw:=false;
   end;
   // draw the back buffer to the canvas
   with fBitmapInfoHeader256 do begin
      biSize:=sizeof(TBitmapInfoHeader);
      biWidth:=GetClientWidth;
      biHeight:=GetClientHeight;
      biPlanes:=1;
      if fTBitmap.pixelformat=pf1bit then begin
          biBitCount:=1;
          Palette[1].rgbRed:=255;
          Palette[1].rgbGreen:=255;
          Palette[1].rgbBlue:=255;
      end else
          biBitCount:=24;
      biCompression:=BI_RGB;
   end;
   with rc do begin
      dx:=imin(right-left,GetClientWidth);
      dy:=imin(bottom-top,GetClientHeight);

      {$ifdef IEDELPHI}
      	if fUseDrawDibDraw or (gSystemColors<=8) then
         	// drawdibdraw. Good for dithering in system with <=256 colors
	      	IEDrawDibDraw(fHDrawDib,canvas.handle,left,top,dx,dy,PBitmapInfoHeader(@fBitmapInfoHeader256)^,fTBitmapScanline[fTBitmap.height-1],left,top,dx,dy,0)
         else begin
         	// new mode
            if (gSystemColors<24) then begin
            	// dithering needed (for example display with 16bit depth need dithering)
            	SetStretchBltMode(Canvas.Handle,HALFTONE);
					StretchBlt(canvas.Handle,left,top,dx,dy,fTBitmap.Canvas.Handle,left,top,dx,dy,SRCCOPY);
            end else begin
            	// no dithering needed (fastest way)
	            BitBlt(canvas.handle,left,top,dx,dy,fTBitmap.Canvas.Handle,left,top,SRCCOPY);
            end;
         end;
      {$endif} // end of IEDELPHI

      {$ifdef IEKYLIX}
      Canvas.StretchDraw(Rect(left,top,left+dx,top+dy),fTBitmap);
      {$endif}
   end;
	{$ifdef IEDEBUG}
	//OutputDebugString(PAnsiChar('PaintRect: '+inttostr(gettickcount-t1)+' ms'));
   {$endif}
   if fPolySelecting then
      PolyDraw1;
end;

procedure TImageEnView.DoDrawVersion;
var
	x,y:integer;
   ss:string;
begin
	with Canvas do begin
      Font.Name:='Arial';
      Font.Height:=13;
      Font.Color:=clBlack;
      Brush.style:=bsSolid;
      Brush.Color:=clWhite;
      ss:='ImageEn Version '+IEMAINVERSION+' - '+inttostr(IEMAINDATEDD)+'/'+inttostr(IEMAINDATEMM)+'/'+inttostr(IEMAINDATEYY);
      y:=ClientHeight-TextHeight(ss);
      x:=ClientWidth-TextWidth(ss);
      TextOut(x,y,ss);
   end;
end;

procedure TImageEnView.Paint;
var
	rc:trect;
begin
	try
	if (not HasParentWindow) or (GetClientWidth=0) or (GetClientHeight=0) then exit;	// environment not ready
   if csDesigning in ComponentState then begin
   	// draws only the background
   	IEDrawBackGround(ComponentState,Canvas,fBackgroundStyle,fBackground,0,0,Width,Height,0,0,0,0,fChessboardSize,fChessboardBrushStyle,fGradientEndColor);
   end else begin
      if fLockPaint=0 then begin
      	// ready to draw
         if fFullUpdateRequest then
         	rc:=Rect(0,0,GetClientWidth,GetClientHeight)
         else begin
            rc:=canvas.cliprect;
         	{$ifdef IEDEBUG}
            //OutputDebugString(PAnsiChar('Partial paint: '+inttostr(rc.left)+','+inttostr(rc.top)+','+inttostr(rc.right)+','+inttostr(rc.bottom)));
            {$endif}
            if (rc.Right=0) or (rc.bottom=0) then begin
               rc.Right:=GetClientWidth;
               rc.Bottom:=GetClientHeight;
            end;
         end;
         PaintRect(rc);
      end;
      fFullUpdateRequest:=False;
      if not fRectMoving then
         AniPolyFunc(self,false);
      if assigned(fOnPaint) then
         OnPaint(self);
   end;
   except
    on E: Exception do
     l3System.Exception2Log(E);
   end;
   if fDrawVersion then
	   DoDrawVersion;
end;

procedure TImageEnView.DoDoubleClickEx(Shift:boolean);
begin
   if fPolySelecting and (not fLassoSelecting) then begin
	   AnimPolygonRemoveLastPoint(integer(fHPolySel));
      if (not Shift) or (not fEnableShiftKey) then
         fSelectionMask.Empty;
      EndSelect;
      Update;
      fPolySelecting:=False;
      DoSelectionChange;
   end;
end;

procedure TImageEnView.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
	inherited;
   {$ifndef OCXVERSION}
   if (csReading in ComponentState) or (csDesigning in ComponentState) or
   	(csLoading in ComponentState) then
   	if assigned(fIEBitmap) then begin
	   	fIEBitmap.Width:=Width;
	      fIEBitmap.Height:=Height;
         Clear;
   	end;
   {$endif}
end;

function TImageEnView.GetPolySelArray:PPointArray;
begin
	result:=fHPolySel^.Poly;
end;

function TImageEnView.GetPolySel(idx:integer):TPoint;
begin
	result:=Point(0,0);
  	with fHPolySel^ do
   	if (idx>=0) and (idx<=PolyCount) then begin
      	if Poly^[idx].X=IESELBREAK then
         	result:=Poly^[idx]	// break code
         else
	      	result:=Point( Poly^[idx].X, Poly^[idx].Y );
      end;
end;

function TImageEnView.GetPolySelCount:integer;
begin
	result:=fHPolySel^.PolyCount;
end;

procedure TImageEnView.DeSelect;
begin
	if fSel then begin
   	fSel:=false;
      HideSelectionEx(true);
   end;
   AnimPolygonClear(integer(fHPolySel));
   fSelectionMask.Empty;
   fSel:=false;
   fPolySelecting:=false;
   fLassoSelecting:=false;
   fRectSelecting:=False;
   fCircSelecting:=False;
   fRectResizing:=ieNone;
   fSelectMoving:=-1;
   SetTempCursor(fCursor);
end;

// x2,y2 represent the right/bottom margin (not selected)
// to select an area of 1x1 pixels we need to select using 0,0,1,1 (the column 1 and the
// row 1 aren't selected)
procedure TImageEnView.Select(x1,y1,x2,y2:integer; Op:TIESelOp);
begin
	SelectEx(x1,y1,x2,y2,Op,false);
   if Op=iespReplace then
      fSelectionMask.Empty;
   EndSelect;
   fDBToDraw:=true;
   Paint;
end;

procedure TImageEnView.SelectEllipse(CenterX,CenterY,Width,Height:integer; Op:TIESelOp);
var
	dx,dy,p,g,xx,yy:integer;
begin
   if fSelectionBase=iesbClientArea then begin
   	CenterX:=XScr2Bmp(CenterX);
      CenterY:=YScr2Bmp(CenterY);
      Width:=trunc(Width*f100DZoom);
      Height:=trunc(Height*f100DZoom);
   end;
   if (Width<=0) or (Height<=0) then exit;
   fSel:=true;
   if (Op=iespAdd) and (fHPolySel^.PolyCount>0) then
      AnimPolygonAddBreak(integer(fHPolySel))
   else begin
	   AnimPolygonClear(integer(fHPolySel));
   end;
   dx:=Width div 2;
   dy:=Height div 2;
   p:=trunc(2*pi*imin(dx,dy)) shr 2;
   if p<3 then p:=3;
   for g:=0 to p-1 do begin
      xx:=round(CenterX+cos((2*pi/p)*g)*dx);
      yy:=round(CenterY+sin((2*pi/p)*g)*dy);
      xx:=imax(0,imin(fIEBitmap.Width,xx));
      yy:=imax(0,imin(fIEBitmap.Height,yy));
      AnimPolygonAddPtEx(integer(fHPolySel),xx,yy);
   end;
   if Op=iespReplace then
      fSelectionMask.Empty;
   EndSelect;
   fDBToDraw:=true;
   Paint;
   ShowSelectionEx(true);
end;


// x2,y2 represent the right/bottom margin (not selected)
// to select an area of 1x1 pixels we need to select using 0,0,1,1 (the column 1 and the
// row 1 aren't selected)
// IT DO NOT CALL "EndSelect"
procedure TImageEnView.SelectEx(x1,y1,x2,y2:integer; Op:TIESelOp; aspectratio:boolean);
begin
	if (x1=x2) or (y1=y2) then begin
      exit;
   end;
   if fSelectionBase=iesbClientArea then begin
   	x1:=XScr2Bmp(x1);
      y1:=YScr2Bmp(y1);
      x2:=XScr2Bmp(x2);
      y2:=YScr2Bmp(y2);
   end;
   fSel:=true;
   if (Op=iespAdd) and (fHPolySel^.PolyCount>0) then
      AnimPolygonAddBreak(integer(fHPolySel))
   else begin
	   AnimPolygonClear(integer(fHPolySel));
   end;
   if (Op=iespReplace) then
		fSelectionMask.Empty;
   if aspectratio then begin
   	if fSelectionAspectRatio=-1 then
			y2:=round(x2-x1+1+y1-1)
      else if fSelectionAspectRatio>0 then
      	y2:=y1+ round((x2-x1)*fSelectionAspectRatio);
   end;
   x1:=imax(0,imin(fIEBitmap.Width-1,x1));
   y1:=imax(0,imin(fIEBitmap.Height-1,y1));
   x2:=imax(0,imin(fIEBitmap.Width-1,x2));
   y2:=imax(0,imin(fIEBitmap.Height-1,y2));
   OrdCor(x1,y1,x2,y2);
   inc(x2);
   inc(y2);
   AnimPolygonAddPtEx(integer(fHPolySel),x1,y1);
	AnimPolygonAddPtEx(integer(fHPolySel),x2,y1);
   AnimPolygonAddPtEx(integer(fHPolySel),x2,y2);
   AnimPolygonAddPtEx(integer(fHPolySel),x1,y2);
   ShowSelectionEx(true);
end;

procedure TImageEnView.SelectMagicWand(x,y:integer; Op:TIESelOp);
var
	pts:ppointarray;
   npt,q:integer;
   xx,yy:integer;
begin
   if fSelectionBase=iesbClientArea then begin
   	x:=XScr2Bmp(x);
      y:=YScr2Bmp(y);
   end;
	if (x<0) or (x>fIEBitmap.Width) or (y<0) or (y>fIEBitmap.Height) then
   	exit;
   case fMagicWandMode of
   	iewInclusive:
      	begin
            pts:=_MakeMagicWandPoints(fIEBitmap,x,y, fMagicWandMaxFilter,fMagicWandTolerance,npt);
            if npt>0 then begin
               fSel:=true;
               if (Op=iespAdd) and (fHPolySel^.PolyCount>0) then
                  AnimPolygonAddBreak(integer(fHPolySel))
               else begin
                  AnimPolygonClear(integer(fHPolySel));
                  fSelectionMask.Empty;
               end;
               for q:=0 to npt-1 do begin
                  xx:=imin(imax(0,pts^[q].x),fIEBitmap.Width);
                  yy:=imin(imax(0,pts^[q].y),fIEBitmap.Height);
                  AnimPolygonAddPtEx(integer(fHPolySel),xx,yy);
               end;
               freemem(pts);
			      if Op=iespReplace then
			         fSelectionMask.Empty;
               EndSelect;
               ShowSelectionEx(true);
            end;
         end;
      iewExclusive:
      	begin
            if (Op=iespReplace) then begin
               AnimPolygonClear(integer(fHPolySel));
               fSelectionMask.Empty;
            end;
            _MakeMagicWandPointsEx(fIEBitmap,x,y,fMagicWandMaxFilter,fMagicWandTolerance,fSelectionMask);
            fSel:=not fSelectionMask.IsEmpty;
            ShowSelectionEx(true);
         end;
      iewGlobal:
      	begin
            if (Op=iespReplace) then begin
               AnimPolygonClear(integer(fHPolySel));
               fSelectionMask.Empty;
            end;
            _MakeMagicWandPointsEx2(fIEBitmap,x,y,fMagicWandTolerance,fSelectionMask);
            fSel:=not fSelectionMask.IsEmpty;
            ShowSelectionEx(true);
         end;
   end;
   fDBToDraw:=true;
   Paint;
end;

// Resize selection
// newx,newy: new point in client coords
// return new grip if changed
//
// grip:  0=left-top  1=right-top  2=right-bottom  3=left-bottom
// 4=left side
// 5=right side
// 6=top side
// 7=bottom side
function TImageEnView.SelectResizeEx(grip:TIEGrip; newx,newy:integer; aspectratio:boolean):TIEGrip;
var
   x1,y1,x2,y2,w,h:integer;
   z:double;
begin
	result:=grip;
  	with PIEAnimPoly(fHPolySel)^ do
     	if _IsRectangle(Poly,PolyCount) then begin
      	newx:=xscr2bmp(newx);
         newy:=yscr2bmp(newy);
			if aspectratio then begin
            w:=flx2-flx1+1;
            h:=fly2-fly1+1;
            if h=0 then exit;
            z:=w/h;
            case grip of
               ieTopLeft: // left-top
                  newy:=round((-flx2+newx-1+z*fly2+z)/z);
               ieTopRight: // right-top
                  newy:=round((-newx+flx1-1+z*fly2)/z);
               ieBottomRight: // right-bottom
                  newy:=round((newx-flx1+1+z*fly1-z)/z);
               ieBottomLeft: // left-bottom
                  newy:=round((flx2-newx+1+fly1*z+z)/z);
               ieLeftSide: // left side
                  begin
                     newy:=round((-flx2+newx-1+z*fly2+z)/z);
                     grip:=ieTopLeft;
                  end;
               ieRightSide: // right side
                  begin
                     newy:=round((newx-flx1+1+z*fly1-z)/z);
                     grip:=ieBottomRight;
                  end;
               ieTopSide: // top side
                  begin
                     newx:=round( -z*fly2+z*newy-z+flx2+1 );
                     grip:=ieTopLeft;
                  end;
               ieBottomSide: // bottom side
                  begin
                     newx:=round( z*newy-z*fly1+z+flx1-1 );
                     grip:=ieBottomRight;
                  end;
            end;
			end;
         if (grip=ieTopRight) or (grip=ieBottomRight) or (grip=ieRightSide) then inc(newx);
         if (grip=ieBottomRight) or (grip=ieBottomLeft) or (grip=ieBottomSide) then inc(newy);
      	x1:=RX1;
         y1:=RY1;
         x2:=RX2;
         y2:=RY2;
      	case grip of
         	ieTopLeft,ieBottomLeft,ieLeftSide:	// left
            	begin
            		x1:=newx;
                  if x1=x2 then dec(x1);
               end;
         	ieTopRight,ieBottomRight,ieRightSide:	// right
            	begin
            		x2:=newx;
                  if x1=x2 then inc(x2);
               end;
         end;
      	case grip of
         	ieTopLeft,ieTopRight,ieTopSide:	// top
            	begin
	            	y1:=newy;
                  if y1=y2 then dec(y1);
               end;
         	ieBottomRight,ieBottomLeft,ieBottomSide:	// bottom
            	begin
	            	y2:=newy;
                  if y1=y2 then inc(y2);
               end;
         end;
         if x1>x2 then begin
         	if (result=ieTopLeft) then result:=ieTopRight 	    // from left-top to right-top
	         else if (result=ieBottomLeft) then result:=ieBottomRight  // from left-bottom to right-bottom
	         else if (result=ieTopRight) then result:=ieTopLeft  // from right-top to left-top
	         else if (result=ieBottomRight) then result:=ieBottomLeft  // from right-bottom to left-bottom
	         else if (result=ieLeftSide) then result:=ieRightSide  // from left side to right side
            else if (result=ieRightSide) then result:=ieLeftSide; // from right side to left side
      	end;
         if y1>y2 then begin
            if (result=ieTopRight) then result:=ieBottomRight 	 	 // from right-top to right-bottom
            else if (result=ieTopLeft) then result:=ieBottomLeft  // from left-top to left-bottom
            else if (result=ieBottomRight) then result:=ieTopRight  // from right-bottom to right-top
            else if (result=ieBottomLeft) then result:=ieTopLeft  // from left-bottom to left-top
            else if (result=ieTopSide) then result:=ieBottomSide  // from top side to bottom side
            else if (result=ieBottomSide) then result:=ieTopSide; // from bottom side to top side
         end;
         AnimPolygonClear(integer(fHPolySel));
         OrdCor(x1,y1,x2,y2);
	      x1:=imax(0,imin(fIEBitmap.Width,x1));
	      y1:=imax(0,imin(fIEBitmap.Height,y1));
	      x2:=imax(0,imin(fIEBitmap.Width,x2));
   	   y2:=imax(0,imin(fIEBitmap.Height,y2));
         OrdCor(x1,y1,x2,y2);
         AnimPolygonAddPtEx(integer(fHPolySel),x1,y1);
         AnimPolygonAddPtEx(integer(fHPolySel),x2,y1);
         AnimPolygonAddPtEx(integer(fHPolySel),x2,y2);
         AnimPolygonAddPtEx(integer(fHPolySel),x1,y2);
         ShowSelectionEx(true);
		end;
end;

// Move selection
// fMoving must be 0
// ox,oy are moving offsets
function TImageEnView.SelectMoveEx(fMoving,ox,oy:integer):integer;
begin
   result:=fMoving;
  	with PIEAnimPoly(fHPolySel)^ do
     	fRectMoving:=_IsRectangle(Poly,PolyCount);
   if not fRectMoving then
   	fSelectionMask.TranslateBitmap(ox,oy,iesoCutBorders in fSelectionOptions);	// modify ox and oy
   if (ox=0) and (oy=0) then
   	exit;
   AnimPolygonMove(integer(fHPolySel),ox,oy,fIEBitmap.Width,fIEBitmap.Height,iesoCutBorders in fSelectionOptions);
   AniPolyFunc(self,true);
end;

procedure TImageEnVIew.MoveSelection(OffsetX,OffsetY:integer);
begin
	SelectMoveEx(0,OffsetX,OffsetY);
end;

// add a point to current selection
// To deselect use Deselect
procedure TImageEnView.AddSelPoint(x,y:integer);
begin
	AddSelPointEx(x,y);
   if fHPolySel^.PolyCount>2 then begin
   	fSelectionMask.Empty;
	   EndSelect;
   end;
   fDBToDraw:=true;
   Paint;
end;

// Same of AddSelPoint
// add a point to current selection
// To deselect use Deselect
// DO NOT CALL "EndSelect"
procedure TImageEnView.AddSelPointEx(x,y:integer);
begin
   if fSelectionBase=iesbClientArea then begin
   	x:=XScr2Bmp(x);
      y:=YScr2Bmp(y);
      x:=imax(0,imin(fIEBitmap.Width,x));
      y:=imax(0,imin(fIEBitmap.Height,y));
   end;
	AnimPolygonAddPt(integer(fHPolySel),x,y);
   ShowSelectionEx(true);
end;

// add a "break" to insert a new selection
procedure TImageEnView.AddSelBreak;
begin
	AddSelBreakEx;
end;

// add a "break" to insert a new selection
// DO NOT CALL "EndSelect"
procedure TImageEnView.AddSelBreakEx;
begin
	if fHPolySel^.PolyCount>0 then
   	AnimPolygonAddBreak(integer(fHPolySel));
end;

// Show current selection
// d=true : draw now
// d=false : draw at next timer tick
procedure TImageEnView.ShowSelectionEx(d:boolean);
begin
	PIEAnimPoly(fHPolySel)^.Enabled:=True;
   if d then
		AniPolyFunc(self,true);
end;

// Hides current selection
// dd=true : remove selection performing a Paint
// dd=false : do not remove selection now
procedure TImageEnView.HideSelectionEx(dd:boolean);
begin
	PIEAnimPoly(fHPolySel)^.Enabled:=False;
   if dd and (fLockPaint=0) then
   	Paint;
end;

procedure TImageEnView.SetVisibleSelection(vv:boolean);
begin
	if vv then
		ShowSelectionEx(true)
   else
   	HideSelectionEx(true);
   Update;
end;

function TImageEnView.GetVisibleSelection:boolean;
begin
	result:=PIEAnimPOly(fHPolySel)^.Enabled;
end;

procedure TImageEnView.SetSelectionOptions(v:TIESelectionOptions);
begin
	fSelectionOptions:=v;
   with PIEAnimPoly(fHPolySel)^ do begin
   	Animated:= iesoAnimated in fSelectionOptions;
      Sizeable:= iesoSizeable in fSelectionOptions;
   end;
   Update;
end;

// reset vertex number of the animated polygon "ap"
procedure TImageEnView.AnimPolygonClear(ap:integer);
begin
	with PIEAnimPOly(ap)^ do begin
   	freemem(Poly);
      GetMem(Poly,0);
      PolyCount:=0;
   end;
   if fLockPaint=0 then
   	Paint;
end;

// Removes last added sub-polygon
procedure TImageEnView.AnimPolygonRemoveLast(ap:integer);
var
	q:integer;
begin
   with PIEAnimPoly(ap)^ do
   	for q:=PolyCount-1 downto 0 do
      	if (Poly^[q].x=IESELBREAK) or (q=0) then begin
         	PolyCount:=q;
            if PolyCount=0 then
            	AnimPolygonClear(ap)
            else
               if fLockPaint=0 then
				   	Paint;
         	break;
      	end;
end;

// removes last point
procedure TImageEnView.AnimPolygonRemoveLastPoint(ap:integer);
begin
	with PIEAnimPoly(ap)^ do begin
	   dec(PolyCount);
      while (PolyCount>0) and (Poly^[PolyCount-1].x=IESELBREAK) do
      	dec(PolyCount);
   end;
end;

// Add a "break" in the animated polygon
procedure TImageEnView.AnimPolygonAddBreak(ap:integer);
var
   tmp:PPointArray;
begin
   with PIEAnimPoly(ap)^ do begin
      if (PolyCount mod 64)=0 then begin
         // allocate 64 points block
         GetMem(tmp,sizeof(TPoint)*(PolyCount+64));
         if PolyCount>0 then begin
            CopyMemory(tmp,Poly,sizeof(TPoint)*PolyCount);
            FreeMem(Poly);
         end;
         Poly:=tmp;
      end;
      if (PolyCount>0) and (Poly^[PolyCount-1].x=IESELBREAK) then
      	exit;
      Poly^[PolyCount]:=Point(IESELBREAK,IESELBREAK);
      inc(PolyCount);
   end;
end;

// add a vertex to animated polygon "ap", doesn't paint
procedure TImageEnView.AnimPolygonAddPtEx(ap:integer; x,y:integer);
var
   tmp:PPointArray;
begin
	// add a point
   with PIEAnimPoly(ap)^ do begin
      if (PolyCount and 63)=0 then begin
      	// allocate block of 64 points
         GetMem(tmp,sizeof(TPoint)*(PolyCount+64));
         if PolyCount>0 then begin
            CopyMemory(tmp,Poly,sizeof(TPoint)*PolyCount);
            FreeMem(Poly);
         end;
         Poly:=tmp;
      end;
      Poly^[PolyCount]:=Point(x,y);
      inc(PolyCount);
      // calc rectangle
      if PolyCount=2 then begin
      	// only two points
         RX1:=Poly^[0].x;
         RY1:=Poly^[0].y;
         RX2:=Poly^[1].x;
         RY2:=Poly^[1].y;
         OrdCor(RX1,RY1,RX2,RY2);
      end else if PolyCount>2 then begin
      	// more than two points (R__ are already valid)
         RX1:=imin(RX1,x);
         RY1:=imin(RY1,y);
         RX2:=imax(RX2,x);
         RY2:=imax(RY2,y);
      end;
   end;
   fSel:=true;
end;

// move the polygon
procedure TImageEnView.AnimPolygonMove(ap:integer; ox,oy:integer; max_x,max_y:integer; CutSel:boolean);
var
	q:integer;
   procedure LimitOXOY;
   begin
   	with PIEAnimPoly(ap)^ do begin
         if (ox+RX1)<0 then dec(ox, (ox+RX1) );
         if (ox+RX2)>=max_x then dec(ox, (ox+RX2-max_x+0) );
         if (oy+RY1)<0 then dec(oy, (oy+RY1) );
         if (oy+RY2)>=max_y then dec(oy, (oy+RY2-max_y+0) );
      end;
   end;
begin
	if (ox=0) and (oy=0) then exit;
   if fLockPaint=0 then
   	Paint;
   with PIEAnimPoly(ap)^ do begin
   	if not CutSel then begin
      	LimitOXOY;
         if RX1+ox>=max_x then exit;
         if RY1+oy>=max_y then exit;
         if RX2+ox<=0 then exit;
         if RY2+oy<=0 then exit;
		end else begin
         if RX1+ox>=max_x then
				LimitOXOY;
         if RY1+oy>=max_y then
         	LimitOXOY;
         if RX2+ox<=0 then
         	LimitOXOY;
         if RY2+oy<=0 then
         	LimitOXOY;
      end;
      RX1:=ilimit(RX1+ox,0,max_x);
      RY1:=ilimit(RY1+oy,0,max_y);
      RX2:=ilimit(RX2+ox,0,max_x);
      RY2:=ilimit(RY2+oy,0,max_y);
		for q:=0 to PolyCount-1 do
      	with Poly^[q] do
      		if x<>IESELBREAK then begin
	      		x:=ilimit(x+ox,0,max_x);
					y:=ilimit(y+oy,0,max_y);
            end;
   end;
end;

// add a vertex to the polygon "ap"
// x and y are bitmap based coordinate
procedure TImageEnView.AnimPolygonAddPt(ap:integer; x,y:integer);
begin
	AnimPolygonAddPtEx(ap,x,y);
   if fLockPaint=0 then
   	Paint;
end;

// Create a new animated polygon
// return the polygon handle
function TImageEnView.AnimPolygonNew(VColor1,VColor2:TColor; VAnimated:boolean; VSizeable:boolean):integer;
var
	pp:PIEAnimPoly;
begin
	getmem(pp,sizeof(TIEAnimPoly));
   fAnimPoly.Add(pp);
   with pp^ do begin
      PolyCount:=0;
      getmem(Poly,0);
      Color1:=VColor1;
      Color2:=VColor2;
		Animated:=VAnimated;
      Sizeable:=VSizeable;
		AniFt:=0;
      if not (csDesigning in ComponentState) then
	      Canvas:=self.Canvas;
      Enabled:=True;
      RX1:=0;
      RY1:=0;
      RX2:=0;
      RY2:=0;
   end;
   if (fAnimPoly.Count=1) and not (csDesigning in ComponentState) then
   	fAnimPolyTimer.Enabled:=True;
   result:=integer(pp);
end;

// removes the animaterd polygon "ap"
procedure TImageEnView.AnimPolygonDel(ap:integer);
begin
	freemem( PIEAnimPoly(ap)^.Poly );
   freemem( PIEAnimPoly(ap) );
	fAnimPoly.Delete( fAnimPoly.IndexOf(pointer(ap)) );
   if fAnimPoly.Count=0 then
   	fAnimPolyTimer.Enabled:=False;
   if fLockPaint=0 then
   	Paint;
end;

procedure LineDDAProc(x,y:integer; self:PIEAnimPoly); stdcall;
begin
	with self^ do begin
		if C1<4 then
			Canvas.Pixels[x,y]:=Color1
	   else if C1<7 then
			Canvas.Pixels[x,y]:=Color2
	   else begin // fC1=6
         Canvas.Pixels[x,y]:=Color2;
 	   	C1:=-1;
      end;
	   inc(C1);
   end;
end;

// this makes selection animated
procedure TImageEnView.TimerEvent(Sender:TObject);
begin
	AniPolyFunc(Sender,true);
end;

// Draw the selection
procedure TImageEnView.AniPolyFunc(Sender:TObject; UseLockPaint:boolean);
var
	q,p:integer;
   pp:PIEAnimPoly;
   x1,y1,x2,y2:integer;
   lbreak:TPoint;
   grx1,gry1,grx2,gry2:integer;
   xanimated:boolean;
begin
	if not HasParentWindow then exit;
   xanimated:=false;
	for q:=0 to fAnimPoly.Count-1 do begin
   	pp:=PIEAnimPoly(fAnimPoly[q]);
   	with pp^ do
      	if Enabled then begin
         	if Animated then
	         	xanimated:=true;
         	if Animated and (not fRectSelecting) and (not fPolySelecting)
               and (not fCircSelecting) and (Sender is TTimer) and (fRectResizing=ieNone) and (fSelectMoving<0) then begin
	            inc(AniFt);
	            if AniFt>=10 then
	               AniFt:=0;
               inc(fAniCounter);
            end;
            if (fLockPaint=0) and ((Canvas.LockCount=0) or (not UseLockPaint)) and (not fMouseMoveScrolling) then begin
               // draw grips
               if Sizeable and _IsRectangle(Poly,PolyCount) and (not fRectSelecting) and (fSelectMoving=-1) then begin
                  with Canvas do begin
                     Brush.Style:=fGripBrushStyle;
                     Brush.Color:=fGripColor2;
                     Pen.Color:=fGripColor1;
                     grx1:=10000000; gry1:=grx1;
                     gry2:=-1000000; grx2:=gry2;
                     for p:=0 to PolyCount-1 do begin
                        if Poly^[p].x<>IESELBREAK then begin
                           x1:=XBmp2Scr(Poly^[p].x);
                           y1:=YBmp2Scr(Poly^[p].y);
                           Rectangle(x1-fGripSize,y1-fGripSize,x1+fGripSize,y1+fGripSize);
                           if x1<grx1 then grx1:=x1;
                           if y1<gry1 then gry1:=y1;
                           if x1>grx2 then grx2:=x1;
                           if y1>gry2 then gry2:=y1;
                        end;
                     end;
                     if fExtendedGrips then begin
                        x1:=(grx2+grx1)div 2;
                        y1:=(gry2+gry1)div 2;
                        Rectangle(x1-fGripSize,gry1-fGripSize,x1+fGripSize,gry1+fGripSize);
                        Rectangle(grx1-fGripSize,y1-fGripSize,grx1+fGripSize,y1+fGripSize);
                        Rectangle(grx2-fGripSize,y1-fGripSize,grx2+fGripSize,y1+fGripSize);
                        Rectangle(x1-fGripSize,gry2-fGripSize,x1+fGripSize,gry2+fGripSize);
                     end;
                  end;
               end;	// end draw grips
            	// draw selection
               if (pp=fHPolySel) and (not fSelectionMask.IsEmpty) and (fRectResizing=ieNone) and (not fRectSelecting)
		               and (not fCircSelecting) and (not fPolySelecting) and (not fRectMoving) then begin
               	if (not fDelayDisplaySelection) or (fStable2=0) then begin
	                  fSelectionMask.DrawOutline(canvas,fOffX,fOffY,frx,fry, fo1x,fo1y,fo2x,fo2y,fAniCounter,fSelColor1,fSelColor2,fZoom);
                  end;
               end else begin
               	(*$ifdef IEDELPHI*)
                  C1:=AniFt;
                  Canvas.pen.mode:=pmCopy;
                  // draw polygon
                  if PolyCount>0 then begin
                  	if _IsRectangle(Poly,PolyCount) then begin
                     	// it is a rectangle
                        x1:=XBmp2Scr(Poly^[0].x);
                        y1:=YBmp2Scr(Poly^[0].y);
                        x2:=XBmp2Scr(Poly^[2].x)-1;
                        y2:=YBmp2Scr(Poly^[2].y)-1;
                        C1:=0;
								LineDDA(x1,y1,x2,y1,@LineDDAProc,integer(pp));
                        C1:=0;
                        LineDDA(x2,y1,x2,y2,@LineDDAProc,integer(pp));
                        C1:=0;
                        LineDDA(x2,y2,x1,y2,@LineDDAProc,integer(pp));
                        C1:=0;
                        LineDDA(x1,y1,x1,y2,@LineDDAProc,integer(pp));
                     end else begin
                     	// it is a polygon (never used?)
                        lbreak:=Poly^[0];
                        p:=1;
                        while p<PolyCount do begin
                           if Poly^[p].x=IESELBREAK then begin
                              // closes sub-polygon
                              x1:=XBmp2Scr(Poly^[p-1].x);
                              y1:=YBmp2Scr(Poly^[p-1].y);
                              x2:=XBmp2Scr(lbreak.x);
                              y2:=YBmp2Scr(lbreak.y);
                              LineDDA(x1,y1,x2,y2,@LineDDAProc,integer(pp));
                              inc(p);
                              lbreak:=Poly^[p];
                           end else begin
                              x1:=XBmp2Scr(Poly^[p-1].x);
                              y1:=YBmp2Scr(Poly^[p-1].y);
                              x2:=XBmp2Scr(Poly^[p].x);
                              y2:=YBmp2Scr(Poly^[p].y);
                              LineDDA(x1,y1,x2,y2,@LineDDAProc,integer(pp));
                           end;
                           inc(p);
                        end;
                        // closes last sub-polygon
                        if (not fPolySelecting) then begin
                           x1:=XBmp2Scr(Poly^[PolyCount-1].x);
                           y1:=YBmp2Scr(Poly^[PolyCount-1].y);
                           x2:=XBmp2Scr(lbreak.x);
                           y2:=YBmp2Scr(lbreak.y);
                           LineDDA(x1,y1,x2,y2,@LineDDAProc,integer(pp));
                        end;
                     end;
                  end;
                  (*$endif*) // IEDELPHI
               end;
         	end;
      	end;
   end;
   if (fStable=0) and (fStable2=0) and (not xanimated) then
		fAnimPolyTimer.Enabled:=false
   else if fAnimPolyTimer.Enabled=false then
   	fAnimPolyTimer.Enabled:=true;
   if fStable>0 then begin
	   dec(fStable);
	   if fStable=0 then
	   	Update;
   end;
   if fStable2>0 then
	   dec(fStable2);
end;

function TImageEnView.GetGripAt(x,y:integer):TIEGrip;
var
	p,x1,y1,x2,y2:integer;
begin
	result:=ieNone;
  	with PIEAnimPoly(fHPolySel)^ do
     	if Enabled and Sizeable and _IsRectangle(Poly,PolyCount) and not fRectSelecting then begin
      	// try grips
         for p:=0 to PolyCount-1 do begin
         	if Poly^[p].x<>IESELBREAK then begin
               x1:=XBmp2Scr(Poly^[p].x);
               y1:=YBmp2Scr(Poly^[p].y);
               if _InRect(x,y,x1-fGripSize,y1-fGripSize,x1+fGripSize,y1+fGripSize) then begin
                  result:=TIEGrip(p+1);
                  break;
               end;
            end;
         end;
         if result=ieNone then begin
            // try sides
            x1:=XBmp2Scr(RX1);
            y1:=YBmp2Scr(RY1);
            x2:=XBmp2Scr(RX2);
            y2:=YBmp2Scr(RY2);
            if _DistPoint2Seg(x,y,x1,y1,x1,y2)<3 then result:=ieLeftSide // left
            else if _DistPoint2Seg(x,y,x2,y1,x2,y2)<3 then result:=ieRightSide // right
            else if _DistPoint2Seg(x,y,x1,y1,x2,y1)<3 then result:=ieTopSide // top
            else if _DistPoint2seg(x,y,x1,y2,x2,y2)<3 then result:=ieBottomSide; // bottom
         end;
      end;
end;

// Return the grip on position x,y
// ieNone if none or Shift is pressed
function TImageEnView.GetResizingGrip(x,y:integer; Shift: TShiftState):TIEGrip;
begin
   if ssShift in Shift then
   	result:=ieNone
   else
   	result:=GetGripAt(x,y);
end;

// return 0 if x,y is inside selection and shift is not pressed
// -1 otherwise
function TImageEnView.GetMovingGrip(x,y:integer; Shift: TShiftState):integer;
begin
	result:=-1;
   if (not (ssShift in Shift)) and (not fSelectionMask.IsEmpty) and (not fRectSelecting) and (not fPolySelecting) and (not fCircSelecting) and
      fSelectionMask.IsPointInside(xscr2bmp(x),yscr2bmp(y)) and (iesoMoveable in fSelectionOptions) then
         result:=0;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnView.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   xsm:TIESelectionBase;
   lx,ly:integer;
begin
	inherited;
   {$ifdef OCXVERSION}
   SetFocus;
   {$else}
   if CanFocus then
	   SetFocus;
   {$endif}
   if (Button=mbLeft) or (miZoom in fMouseInteract) then begin
      //
      fSaveZoomFilter:=fZoomFilter;
      if (not (miScroll in fMouseInteract)) and fDelayZoomFilter then
	      fZoomFilter:=rfNone;
      //
      xsm:=fSelectionBase;
      fSelectionBase:=iesbClientArea;
      //
      lx:=x;
      ly:=y;
      x:=ilimit(x,fOffX,fOffX+fExtX);
      y:=ilimit(y,fOffY,fOffY+fExtY);
      //
      fPredLX:=lx;
      fPredLY:=ly;
      fPredX:=x;
      fPredY:=y;
      fHSX1:=x;
      fHSY1:=y;
      fHSVX1:=ViewX;
      fHSVY1:=ViewY;
      fMMoveX:=x;
      fMMoveY:=y;
      fStartingPolyCount:=fHPolySel^.PolyCount;
      if (miSelectPolygon in fMouseInteract) or (miSelectLasso in fMouseInteract) then begin
      	DoBeforeSelectionChange;
         fSelectMoving:=GetMovingGrip(x,y,Shift);
         if fSelectMoving=-1 then begin
            if (ssAlt in Shift) or fForceALTkey then
               with fHPolySel^ do
                  if (PolyCount>0) and (Poly^[PolyCount-1].x<>IESELBREAK) then
                     _CastPolySelCC(Poly^[PolyCount-1].x-fViewX+fOffX,Poly^[PolyCount-1].y-fViewY+fOffY,x,y);
            if (not fPolySelecting) then begin
               if (ssShift in Shift) and (fEnableShiftKey) then
                  AddSelBreakEx
               else
                  DeSelect;
            end;
            AddSelPointEx(X,Y);
            fPolySelecting:=true;
            fLassoSelecting:= miSelectLasso in fMouseInteract;
            DoSelectionChanging;
         end;
      end else if (miSelect in fMouseInteract) then begin
      	DoBeforeSelectionChange;
         fRectResizing:=GetResizingGrip(x,y,Shift);
         if fRectResizing=ieNone then
	         fSelectMoving:=GetMovingGrip(x,y,Shift);
         if (fRectResizing=ieNone) and (fSelectMoving=-1) then begin
            // new rectangular selection
            fRectSelecting:=True;
            if (fForceALTKey or (ssALT in Shift)) and (fSelectionAspectRatio=0) then begin
            	// fixed selection
               MouseSelectRectangle(x,y,Shift);
            end;
            DoSelectionChanging;
         end;
         if fRectResizing<>ieNone then
				with PIEAnimPoly(fHPolySel)^ do begin
					flx1:=RX1; flx2:=RX2; fly1:=RY1; fly2:=RY2;
	         end;
      end else if (miSelectZoom in fMouseInteract) then begin
         fRectSelecting:=True;
         DoSelectionChanging;
         if miSelectZoom in fMouseInteract then
         	SaveSelection;
      end else if (miSelectCircle in fMouseInteract) then begin
      	DoBeforeSelectionChange;
         fSelectMoving:=GetMovingGrip(x,y,Shift);
         if fSelectMoving=-1 then begin
            fCircSelecting:=True;
            ShowSelectionEx(false);
            if (fForceALTKey or (ssALT in Shift)) and (fSelectionAspectRatio=0) then begin
            	// fixed selection
               MouseSelectCircle(x,y,Shift);
            end;
            DoSelectionChanging;
         end;
      end else if (miSelectMagicWand in fMouseInteract) then begin
      	DoBeforeSelectionChange;
	      fSelectMoving:=GetMovingGrip(x,y,Shift);
      end else if ((miMoveLayers in fMouseInteract) or (miResizeLayers in fMouseInteract)) then begin
   		fLayerResizing:=FindLayerGrip(lx,ly);
         if fLayerResizing<>ieNone then begin
         	// do nothing
         end else begin
            fMovingLayer:=FindLayerAt(lx,ly);
            if fMovingLayer>-1 then begin
               SetLayersCurrent( fMovingLayer );
					DoLayerNotify(fMovingLayer,ielSelected);
            end;
            if (fMovingLayer>-1) and (not TIELayer(fLayers[fLayersCurrent]).Locked) then
               SaveCursor(1790);
         end;
      end;
      if (Button=mbLeft) and (miScroll in fMouseInteract) and RequiresScrollBars then // warning, not follows the previous if..then...else
  			SaveCursor(1782);
      fSelectionBase:=xsm;
   end;
end;

// Called by MouseMoveScroll, when it is scrolled the view (ViewXY)
// of scx and scy pixels.
procedure TImageEnView.SubMouseMoveScroll(scx,scy:integer);
begin
	dec(fMMoveX,scx);
	dec(fMMoveY,scy);
   dec(fPredX,scx);
   dec(fPredY,scy);
   dec(fPredLX,scx);
   dec(fPredLY,scy);
end;

// calls SubMouseMoveScroll method
// scroll if the mouse is out of the component
function TImageEnView.MouseMoveScroll:boolean;
var
   pt:Tpoint;
   scx,scy,lvx,lvy:integer;
begin
	fMouseMoveScrolling:=true;
   try
	result:=false;
   repeat
      // calc movement
      getcursorpos(pt);
      pt:=ScreenToClient(pt);
      if pt.x<fOffX then scx:=pt.x-fOffX
      else if pt.x>(fOffX+fExtX-1) then scx:=pt.x-(fOffX+fExtX-1)
      else scx:=0;
      if pt.y<fOffY then scy:=pt.y-fOffY
      else if pt.y>(fOffY+fExtY-1) then scy:=pt.y-(fOffY+fExtY-1)
      else scy:=0;
      if (scx=0) and (scy=0) then begin
      	break;		// EXIT POINT!
      end;
      lvx:=fViewX; lvy:=fViewY;
      SetViewXY(fViewX+scx,fViewY+scy);
      if (lvx=fViewX) and (lvy=fViewY) then begin
      	break;		// EXIT POINT!
      end;
      result:=true;
      dec(lvx,fViewX);
      dec(lvy,fViewY);
      inc(fHSX1,lvx);
      inc(fHSY1,lvy);
      SubMouseMoveScroll(scx,scy);
   until false;
   finally
   	fMouseMoveScrolling:=false;
   end;
end;

procedure TImageEnView.MouseResizeLayer(lx,ly:integer);
var
	w,h:integer;
   layer:TIELayer;
begin
   layer:=TIELayer(fLayers[fLayersCurrent]);
   if layer.ResizedWidth=0 then w:=layer.bitmap.Width else w:=layer.ResizedWidth;
   if layer.ResizedHeight=0 then h:=layer.bitmap.Height else h:=layer.ResizedHeight;
   case fLayerResizing of
      ieTopLeft: // left-top
         begin
            layer.ResizedWidth := imax(1, w - (xscr2bmp(lx)-xscr2bmp(fPredLX)));
            layer.ResizedHeight:= imax(1, h - (yscr2bmp(ly)-yscr2bmp(fPredLY)));
            if layer.ResizedWidth>1 then
               layer.PosX := layer.PosX + (xscr2bmp(lx)-xscr2bmp(fPredLX));
            if layer.ResizedHeight>1 then
               layer.PosY := layer.PosY + (yscr2bmp(ly)-yscr2bmp(fPredLY));
         end;
      ieTopRight: // right-top
         begin
            layer.ResizedWidth := imax(1, w - (-xscr2bmp(lx)+xscr2bmp(fPredLX)));
            layer.ResizedHeight:= imax(1, h - (+yscr2bmp(ly)-yscr2bmp(fPredLY)));
            if layer.ResizedHeight>1 then
               layer.PosY := layer.PosY + (yscr2bmp(ly)-yscr2bmp(fPredLY));
         end;
      ieBottomRight: // right-bottom
         begin
            layer.ResizedWidth  := imax(1, (xscr2bmp(lx)-xscr2bmp(layer.ClientAreaBox.Left)) );
            layer.ResizedHeight := imax(1, (xscr2bmp(ly)-xscr2bmp(layer.ClientAreaBox.Top)) );
         end;
      ieBottomLeft: // left-bottom
         begin
            layer.ResizedWidth := imax(1, w - (+xscr2bmp(lx)-xscr2bmp(fPredLX)));
            layer.ResizedHeight:= imax(1, h - (-yscr2bmp(ly)+yscr2bmp(fPredLY)));
            if layer.ResizedWidth>1 then
               layer.PosX := layer.PosX + (xscr2bmp(lx)-xscr2bmp(fPredLX));

         end;
      ieLeftSide: // left side
         begin
            layer.ResizedWidth := imax(1, w - (+xscr2bmp(lx)-xscr2bmp(fPredLX)));
            if layer.ResizedWidth>1 then
               layer.PosX := layer.PosX + (xscr2bmp(lx)-xscr2bmp(fPredLX));
         end;
      ieRightSide: // right side
         begin
            layer.ResizedWidth  := imax(1, (xscr2bmp(lx)-xscr2bmp(layer.ClientAreaBox.Left)) );
         end;
      ieTopSide: // top side
         begin
            layer.ResizedHeight:= imax(1, h - (+yscr2bmp(ly)-yscr2bmp(fPredLY)));
            if layer.ResizedHeight>1 then
               layer.PosY := layer.PosY + (yscr2bmp(ly)-yscr2bmp(fPredLY));
         end;
      ieBottomSide: // bottom side
         begin
            layer.ResizedHeight:= imax(1, h - (-yscr2bmp(ly)+yscr2bmp(fPredLY)));
         end;
   end;
end;

procedure TImageEnView.MouseSelectCircle(x,y:integer; Shift:TShiftState);
var
	dx,dy,p,g:integer;
   xx,yy:integer;
begin
   MouseMoveScroll;
   if (fForceALTKey or (ssALT in Shift)) and (fSelectionAspectRatio=0) then begin
      dx:=round(fSelectionAbsWidth*fZoomD100) div 2;
      dy:=round(fSelectionAbsHeight*fZoomD100) div 2;
      fHSX1:=x;
      fHSY1:=y;
      x:=x+dx;
      y:=y+dy;
   end;
   if (ssShift in Shift) and (fEnableShiftKey) then begin
      if fStartingPolyCount<>fHPolySel^.PolyCount then
         AnimPolygonRemoveLast(integer(fHPolySel));
      AddSelBreakEx;
   end else
      AnimPolygonClear(integer(fHPolySel));
   if ((ssAlt in Shift) or fForceALTkey) and (fSelectionAspectRatio<>0) then begin
      // circle (pressing ALT)
      if fSelectionAspectRatio>0 then begin
         dx:=imax( abs(fHSX1-X), abs(fHSY1-Y) );
         dy:=round(dx*fSelectionAspectRatio);
      end else begin
         dx:=imax( abs(fHSX1-X), abs(fHSY1-Y) );
         dy:=dx;
      end;
   end else begin
      dx:=abs(fHSX1-X);
      dy:=abs(fHSY1-Y);
   end;
   dx:=trunc(dx*f100DZoom);
   dy:=trunc(dy*f100DZoom);
   p:=trunc(2*pi*imin(dx,dy));
   if p<50 then p:=50;
   for g:=0 to p-1 do begin
      xx:=round(XScr2Bmp(fHSX1)+cos((2*pi/p)*g)*dx);
      yy:=round(YScr2Bmp(fHSY1)+sin((2*pi/p)*g)*dy);
      xx:=imax(0,imin(fIEBitmap.Width,xx));
      yy:=imax(0,imin(fIEBitmap.Height,yy));
      AnimPolygonAddPtEx(integer(fHPolySel),xx,yy);
   end;
   AniPolyFunc(self,true);
   DoSelectionChanging;
end;

procedure TImageEnView.MouseSelectRectangle(x,y:integer; Shift:TShiftState);
var
	dx,dy:integer;
begin
   MouseMoveScroll;
   if (fForceALTKey or (ssALT in Shift)) and (fSelectionAspectRatio=0) then begin
      dx:=round(fSelectionAbsWidth*fZoomD100) div 2;
      dy:=round(fSelectionAbsHeight*fZoomD100) div 2;
   	fHSx1:=x-dx;
      fHsy1:=y-dy;
      x:=x+dx-1;
      y:=y+dy-1;
   end;
   if (ssShift in Shift) and (fEnableShiftKey) then begin
      if fStartingPolyCount<>fHPolySel^.PolyCount then
         AnimPolygonRemoveLast(integer(fHPolySel));
      SelectEx(fHSx1,fHSy1,x,y,iespAdd, (ssAlt in Shift) or fForceALTkey)
   end else
      SelectEx(fHSx1,fHSy1,x,y,iespReplace, (ssAlt in Shift) or fForceALTkey);
   DoSelectionChanging;
end;

procedure TImageEnView.MouseMove(Shift: TShiftState; X, Y: Integer);
var
	lx,ly:integer;
   xsm:TIESelectionBase;
   grip:TIEGrip;
   ii:integer;
   layer:TIELayer;
begin
	inherited;
   xsm:=fSelectionBase;
   fSelectionBase:=iesbClientArea;
   //
   lx:=x; x:=ilimit(lx,fOffX,fOffX+fExtX);
   ly:=y; y:=ilimit(ly,fOffY,fOffY+fExtY);
   //
	if MouseCapture then begin

	   // inside Mouse Capture

   	if miScroll in fMouseInteract then
         SetViewXY(fHSVX1-(lx-fHSx1),fHSVY1-(ly-fHSy1))
      else if fRectResizing<>ieNone then begin
      	// resize rectangular selection
         MouseMoveScroll;
			fRectResizing:=SelectResizeEx(fRectResizing,x,y, (ssAlt in Shift) or fForceALTkey);
         DoSelectionChanging;
      end else if fSelectMoving>-1 then begin
   		// move selection
         if iesoCanScroll in fSelectionOptions then
	         MouseMoveScroll;
         fSelectMoving:=SelectMoveEx(fSelectMoving,xscr2bmp(x)-xscr2bmp(fPredX),yscr2bmp(y)-yscr2bmp(fPredY));
         DoSelectionChanging;
      end else if fRectSelecting then begin
      	// select rectangle
         MouseSelectRectangle(x,y,Shift);
      end else if fPolySelecting then begin
      	// select polygon
      	MouseMoveScroll;
      	Paint;
         PolyDraw1;
      	AnimPolygonAddPtEx(integer(fHPolySel),XScr2Bmp(x),YScr2Bmp(y));
         AniPolyFunc(self,true);
         DoSelectionChanging;
      end else if fCircSelecting then begin
      	// select circle
         MouseSelectCircle(x,y,Shift);
      end else if (fMovingLayer>-1) then begin
      	// Moving a layer
         layer:=TIELayer(fLayers[fMovingLayer]);
         if not layer.Locked then begin
            MouseMoveScroll;
            layer.PosX := Layer.PosX + (xscr2bmp(lx)-xscr2bmp(fPredLX));
            layer.PosY := Layer.PosY + (yscr2bmp(ly)-yscr2bmp(fPredLY));
            Update;
            DoLayerNotify(fLayersCurrent,ielMoving);
         end;
      end else if (fLayerResizing<>ieNone) and (not TIELayer(fLayers[fLayersCurrent]).Locked) then begin
      	// Resizing a layer
         MouseMoveScroll;
         MouseResizeLayer(lx,ly);
         Update;
         DoLayerNotify(fLayersCurrent,ielResizing);
      end;

	// out of Mouse Capture

   end else if fPolySelecting and not (fLassoSelecting) then begin
      PolyDraw1;
      if (ssAlt in Shift) or fForceALTkey then
      	with fHPolySel^ do
         	if (PolyCount>0) and (Poly^[PolyCount-1].x<>IESELBREAK) then
					_CastPolySelCC(Poly^[PolyCount-1].x-fViewX+fOffX,Poly^[PolyCount-1].y-fViewY+fOffY,x,y);
   	fMMoveX:=X;
      fMMoveY:=Y;
      PolyDraw1;
      DoSelectionChanging;
   end else if (miSelect in fMouseInteract) or (miSelectPolygon in fMouseInteract) or
               (miSelectCircle in fMouseInteract) (*or (miSelectZoom in fMouseInteract)*) or
               (miSelectMagicWand in fMouseInteract) or (miSelectLasso in fMouseInteract) then begin
   	grip:=GetResizingGrip(x,y,Shift);
      if assigned(fOnMouseInResizingGrip) then
         fOnMouseInResizingGrip(self,grip);
		if grip=ieNone then begin
      	ii:=GetMovingGrip(x,y,Shift);
         if ii>-1 then
         	// moving cursor
            SetTempCursor(1790)
         else
            // default cursor
            SetTempCursor(fCursor);
      end else begin
      	// resizing cursors
      	case grip of
         	ieTopLeft,ieBottomRight: SetTempCursor(1786);
            ieTopRight,ieBottomLeft: SetTempCursor(1788);
            ieLeftSide,ieRightSide: SetTempCursor(1789);
				ieTopSide,ieBottomSide: SetTempCursor(1787);
         end;
      end;
   end else if ((miResizeLayers in fMouseInteract) or (miMoveLayers in fMouseInteract)) then begin
   	grip:=ieNone;
      if (miResizeLayers in fMouseInteract) and (not TIELayer(fLayers[fLayersCurrent]).Locked) then
	   	grip:=FindLayerGrip(lx,ly);
		if grip=ieNone then begin
      	ii:=FindLayerAt(lx,ly);
         if (ii>-1) and (not TIELayer(fLayers[ii]).Locked) then
         	// moving cursor
            SetTempCursor(1790)
         else
            // default cursor
            SetTempCursor(fCursor);
      end else begin
      	// resizing cursors
      	case grip of
         	ieTopLeft,ieBottomRight: SetTempCursor(1786);
            ieTopRight,ieBottomLeft: SetTempCursor(1788);
            ieLeftSide,ieRightSide: SetTempCursor(1789);
				ieTopSide,ieBottomSide: SetTempCursor(1787);
         end;
      end;
   end;

	if fSelectionMask.IsPointInside(xscr2bmp(x),yscr2bmp(y)) then
      if assigned(fOnMouseInSel) then
         fOnMouseInSel(self);
	fMMoveX:=x;
   fMMoveY:=y;
   fSelectionBase:=xsm;
   fPredX:=x;
   fPredY:=y;
   fPredLx:=lx;
   fPredLy:=ly;
end;

function TImageEnView.IsPointInsideSelection(x,y:integer):boolean;
begin
   if fSelectionBase=iesbClientArea then begin
   	x:=XScr2Bmp(x);
      y:=YScr2Bmp(y);
   end;
   result:=fSelectionMask.IsPointInside(x,y);
end;

procedure TImageEnView.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
	NUMSCALES=8;
	scales:array [1..NUMSCALES] of integer=(2,5,10,25,33,50,75,100);
var
	w:integer;
   xsm:TIESelectionBase;
   d:double;
   ix,iy:integer;
   callselectionchange:boolean;
begin
	inherited;
   callselectionchange:=false;
   ix:=ilimit(x,fOffX,fOffX+fExtX);
   iy:=ilimit(y,fOffY,fOffY+fExtY);
   xsm:=fSelectionBase;
   fSelectionBase:=iesbClientArea;
   d:=0;
	if (miZoom in fMouseInteract) and (fHSx1=x) and (fHSy1=y) then begin
   	if Button=mbLeft then begin
         if (miScroll in fMouseInteract) then
            RestoreCursor;
      	// zoom-in (MOUSE LEFT)
         if Zoom<100 then begin
				for w:=1 to NUMSCALES do
            	if scales[w]>Zoom then begin
               	d:=scales[w];
                  break;
               end;
         end else d:=Zoom+100;
         if assigned(fOnZoomIn) then
         	fOnZoomIn(self,d);
         if d<>fZoom then
	      	ZoomAt(x,y,d)
      end else if (Button=mbRight) then begin
      	// zoom-out (MOUSE RIGHT)
         if Zoom<200 then begin
         	d:=2;
				for w:=NUMSCALES downto 1 do
            	if scales[w]<Zoom then begin
               	d:=scales[w];
                  break;
               end;
         end else d:=Zoom-100;
         if assigned(fOnZoomOut) then
         	fOnZoomOut(self,d);
         if d<>fZoom then
	      	ZoomAt(x,y,d);
      end;
      fPolySelecting:=false;
   end else if (Button=mbLeft) and (miScroll in fMouseInteract) and RequiresScrollBars then begin
   	SetViewXY(fHSVX1-(x-fHSx1),fHSVY1-(y-fHSy1));	// set "view", free by MouseCapture
      RestoreCursor;
   end else if (Button=mbLeft) and (miSelectZoom in fMouseInteract) then begin
   	ZoomSelection;
   	fRectSelecting:=false;
      RestoreSelection;
   end else if (Button=mbLeft) and (miSelect in fMouseInteract) then begin
   	if (fHSX1=ix) and (fHSY1=iy) and (fRectResizing=ieNone) and (fSelectMoving=-1) then begin
      	{$ifdef IESINGLE_CLICK_SELECTION_REMOVE}
      	DeSelect;
         callselectionchange:=true;
         {$endif}
		end else begin
         if fRectSelecting or (fRectResizing<>ieNone) then begin
            if (not (ssShift in Shift)) or (not fEnableShiftKey) then
               fSelectionMask.Empty;
            EndSelect;
         end;
         fRectSelecting:=false;
         fRectResizing:=ieNone;
         fSelectMoving:=-1;
         callselectionchange:=true;
         Update;
      end;
   end else if (Button=mbLeft) and (miSelectCircle in fMouseInteract) then begin
   	if (fHSX1=ix) and (fHSY1=iy) and (fSelectMoving=-1) and (fSelectionAspectRatio<>0) then
      	DeSelect
		else begin
         if fCircSelecting then begin
            if (not (ssShift in Shift)) or (not fEnableShiftKey) then
               fSelectionMask.Empty;
            EndSelect;
         end;
         fCircSelecting:=False;
         fSelectMoving:=-1;
         callselectionchange:=true;
         Update;
      end;
   end else if (Button=mbLeft) and (miSelectLasso in fMouseInteract) then begin
   	if (fHSX1=ix) and (fHSY1=iy) and (fSelectMoving=-1) then
      	DeSelect
		else begin
         if fLassoSelecting then begin
            if (not (ssShift in Shift)) or (not fEnableShiftKey) then
               fSelectionMask.Empty;
            EndSelect;
         end;
         fLassoSelecting:=false;
         fPolySelecting:=false;
         fSelectMoving:=-1;
         callselectionchange:=true;
         Update;
      end;
   end else if (Button=mbLeft) and (miSelectPolygon in fMouseInteract) then begin
   	if (fSelectMoving>-1) then begin
	      fSelectMoving:=-1;
	      callselectionchange:=true;
      end;
      Update;
   end else if (Button=mbLeft) and (miSelectMagicWand in fMouseInteract) then begin
      if fSelectMoving>-1 then begin
         fSelectMoving:=-1;
         callselectionchange:=true;
      end else begin
         SetTempCursor(crHourGlass);
         if (ssShift in Shift) and fEnableShiftKey then
            SelectMagicWand(x,y,iespAdd)
         else
            SelectMagicWand(x,y,iespReplace);
         SetTempCursor(fCursor);
         callselectionchange:=true;
      end;
      Update;
   end;
   if fRectMoving then begin
      fSelectionMask.Empty;
      EndSelect;
      fRectMoving:=false;
   end;
   if fMovingLayer>-1 then begin
   	fMovingLayer:=-1;
		RestoreCursor;
      DoLayerNotify(fLayersCurrent,ielMoved);
   end;
   if fLayerResizing<>ieNone then begin
   	fLayerResizing:=ieNone;
      DoLayerNotify(fLayersCurrent,ielResized);
   end;
   fZoomFilter:=fSaveZoomFilter;
   fSelectionBase:=xsm;
   fSelectMoving:=-1;
   fRectResizing:=ieNone;
   fRectSelecting:=false;
   fCircSelecting:=false;
   fLassoSelecting:=false;
   if callselectionchange then
   	DoSelectionChange;
end;

// Called whenever the zoom or viewx/y changes.
// It changes fOnViewChange
procedure TImageEnView.ViewChange(c:integer);
begin
   if assigned(fOnViewChange) then
  		fOnViewChange(self,c);
end;

// draw backgrouns on Width and Height area
procedure IEDrawBackground(ComponentState:TComponentState; Canvas:TCanvas; fBackgroundStyle:TIEBackgroundStyle; fBackGround:TColor; DestX,DestY,Width,Height:integer; x1,y1,x2,y2:integer; fChessboardSize:integer; fChessboardBrushStyle:TBrushStyle; fGradientEndColor:TColor);
const
	BS:array [iebsSolid..iebsDiagCross] of TBrushStyle=(bsSolid, bsHorizontal,
          bsVertical, bsFDiagonal, bsBDiagonal, bsCross, bsDiagCross);
var
	x,y:integer;
   b1,b2:boolean;
   rc:trect;
begin
	with Canvas do
   	case fBackgroundStyle of
      	iebsGradient:
         	(*$ifdef IEDELPHI*)
         	IEDrawGradient(Rect(DestX,DestY,width+DestX,height+DestY),Canvas.handle,fBackGround,fGradientEndColor,true);
            (*$else*)
            ;   // not implemented
            (*$endif*)
      	iebsSolid..iebsDiagCross:
         	begin
		         Brush.Color := fBackGround;
		         Brush.Style := BS[fBackgroundStyle];
		         FillRect(rect(DestX,DestY,Width+DestX,Height+DestY));
      		end;
         iebsChessBoard:
         	begin
            	Brush.Style:=fChessboardBrushStyle;
               y:=DestY; b1:=false;
               while y<Height+DestY do begin
						b2:=b1;
                  b1:=not b1;
               	x:=DestX;
               	while x<Width+DestX do begin
                  	if b2 then Brush.Color:=fBackground else Brush.Color:=not fBackground;
                     b2:=not b2;
							FillRect(rect(x,y,imin(x+fChessboardSize,DestX+Width),imin(y+fChessboardSize,DestY+Height)));
                  	inc(x,fChessboardSize);
                  end;
                  inc(y,fChessboardSize);
               end;
            end;
         iebsDiagonals:
         	begin
		         Brush.Color := fBackGround;
		         Brush.Style := bsSolid;
		         FillRect(rect(DestX,DestY,Width+DestX,Height+DestY));
               Pen.Color:=not fBackground;
               Pen.Style:=psSolid;
               moveto(DestX,DestY);
               lineto(Width+DestX,Height+DestY);
               moveto(Width+DestX,DestY);
               lineto(DestX,Height+DestY);
            end;
         iebsCropped:
            begin
            	(*$ifdef IEDELPHI*)
            	if (csDesigning in ComponentState) then begin
                  Brush.Color := fBackGround;
                  Brush.Style := bsSolid;
                  FillRect(rect(DestX,DestY,Width+DestX,Height+DestY));
               end else begin
                  Brush.Color := clBtnFace;
                  Brush.Style := bsSolid;
                  FillRect(rect(DestX,DestY,Width+DestX,Height+DestY));
                  if ((x2-x1)>1) and ((y2-y1)>1) then begin
	                  rc:=rect(x1-gedgex,y1-gedgey,x2+gedgex,y2+gedgey);
	                  DrawEdge(Canvas.Handle,rc,EDGE_SUNKEN,BF_RECT);
                  end;
               end;
               (*$endif*)
            end;
         iebsCropShadow:
         	begin
            	if (csDesigning in ComponentState) then begin
                  Brush.Color := fBackGround;
                  Brush.Style := bsSolid;
                  FillRect(rect(DestX,DestY,Width+DestX,Height+DestY));
               end else begin
                  Brush.Color := clBtnFace;
                  Brush.Style := bsSolid;
                  FillRect(rect(DestX,DestY,Width+DestX,Height+DestY));
	               if ((x2-x1)>1) and ((y2-y1)>1) then begin
                     IERightShadow(Canvas,x2,y1,x2+5,y2+3,iestSmooth1);
                     IEBottomShadow(Canvas,x1,y2,x2+4,y2+5,iestSmooth1);
                  end;
               end;
            end;
      end;
end;

// fo1x,fo1y,fo2x,fo2y ,frx,fry
procedure TImageEnView.CalcPaintCoordsEx(var XSrc,YSrc,SrcWidth,SrcHeight:integer; var DstWidth,DstHeight:integer; tViewX,tViewY:integer);
var
   rr:double;
begin
   XSrc:=0; SrcWidth:=0; YSrc:=0; SrcHeight:=0;
   if fZZWW<>0 then begin
      rr:=fMaxLayerWidth/fZZWW;
      XSrc:=round(QuantizeViewX(tViewX)*rr);
      SrcWidth:=round(fExtx*rr);
      if (XSrc+SrcWidth)>fMaxLayerWidth then
         dec(SrcWidth);
   end;
   if fZZHH<>0 then begin
       rr:=fMaxLayerHeight/fZZHH;
       YSrc:=round(QuantizeViewY(tViewY)*rr);
       SrcHeight:=round(fExty*rr);
       if (YSrc+SrcHeight)>fMaxLayerHeight then
          dec(SrcHeight);
   end;
   if fZoom>100 then begin
      DstWidth:=trunc(SrcWidth*fZoomD100);
      if (DstWidth<fExtX) and (XSrc+SrcWidth+1<=fMaxLayerWidth) then begin
         inc(SrcWidth);
         DstWidth:=trunc(SrcWidth*fZoomD100);
      end;
      DstHeight:=trunc(SrcHeight*fZoomD100);
      if (DstHeight<fExtY) and (YSrc+SrcHeight+1<=fMaxLayerHeight) then begin
         inc(SrcHeight);
         DstHeight:=trunc(SrcHeight*fZoomD100);
      end;
   end else begin
      DstWidth:=fExtX;
      DstHeight:=fExtY;
   end;
end;

procedure TImageEnView.CalcPaintCoords;
begin
	CalcPaintCoordsEx(fo1x,fo1y,fo2x,fo2y,frx,fry,fViewX,fViewY);
end;

procedure TImageEnView.SetZoomFilter(v:TResampleFilter);
begin
   fSaveZoomFilter:=v;  // used in MouseUp (but also setted in MouseDown)
	if fZoomFilter<>v then begin
		fZoomFilter:=v;
	   Update;
   end;
end;

procedure TImageEnView.Assign(Source: TPersistent);
var
	si:TImageEnView;
begin
	if Source=nil then
   	Clear
   else if Source is TImageEnView then begin
		si:=(Source as TImageEnView);
      fIEBitmap.Assign( si.fIEBitmap );
		fBackGround:=si.fBackGround;
      SetDPI(si.fDPIX,si.fDPIY);
      Update;
      ImageChange;
   end else if Source is TBitmap then begin
      fIEBitmap.CopyFromTBitmap(source as TBitmap);
      if (fIEBitmap.PixelFormat<>ie1g) and (fIEBitmap.PixelFormat<>ie24RGB) then
      	fIEBitmap.PixelFormat:=ie24RGB;
      Update;
      ImageChange;
   end;
end;

// ret True is the polygon is a rectangle
// "n" is the number of vertex
function _IsRectangle(p:PPointArray; n:integer):boolean;
var
   q:integer;
   vv:boolean;	// vv=false (x equals)   vv=true (y equals)
begin
	result:=false;
   if (n=4) then begin
   	if (p^[3].x=p^[0].x) and (p^[3].y<>p^[0].y) then vv:=true
      else if (p^[3].x<>p^[0].x) and (p^[3].y=p^[0].y) then	vv:=false
      else exit;
      for q:=0 to 2 do
	   	if (p^[q].x=p^[q+1].x) and (p^[q].y<>p^[q+1].y) and (not vv) then vv:=true
	      else if (p^[q].x<>p^[q+1].x) and (p^[q].y=p^[q+1].y) and vv then vv:=false
	      else exit;
		result:=true;
   end;
end;

function TImageEnView.GetMouseInteract:TIEMouseInteract;
begin
	result:=fMouseInteract;
end;

procedure TImageEnView.SetBackgroundStyle(v:TIEBackgroundStyle);
begin
	fBackgroundStyle:=v;
   invalidate;
   Update;
end;

procedure TImageEnView.DoSelectionChanging;
begin
   if Assigned(fOnSelectionChanging) then
   	OnSelectionChanging(self);
end;

procedure TImageEnView.DoSelectionChange;
begin
   if Assigned(fOnSelectionChange) then
   	OnSelectionChange(self);
end;

procedure TImageEnView.DoBeforeSelectionChange;
begin
	if Assigned(fOnBeforeSelectionChange) then
   	OnBeforeSelectionChange(self);
end;

// Copy the polygon Polygon of Source in Position of fBitmap
procedure TImageEnView.CopyFromPolygon(Source:TBitmap; const Polygon:array of TPoint; PolygonLen:integer; const Position:TPoint);
begin
	_CopyPolygonToPoint(Source,@Polygon,PolygonLen,fBitmap,Position);
   Update;
end;

// copy the rect at Position of fBitmap in Polygon of Dest
procedure TImageEnView.CopyToPolygon(Dest:TBitmap; const Polygon:array of TPoint; PolygonLen:integer; const Position:TPoint);
begin
	_CopyPointToPolygon(fBitmap,@Polygon,PolygonLen,Dest,Position);
end;

function TImageEnView.GetScrollBarsAlwaysVisible:boolean;
begin
	result:=fScrollBarsAlwaysVisible;
end;

procedure TImageEnView.SetScrollBarsAlwaysVisible(v:boolean);
begin
	fScrollBarsAlwaysVisible:=v;
   Update;
end;

procedure TImageEnView.SetDisplayGrid(v:boolean);
begin
	fDisplayGrid:=v;
   Update;
end;

procedure TImageEnView.KeyDown(var Key: Word; Shift: TShiftState);
begin
	inherited;
   if (ssShift in Shift) and fEnableShiftKey then begin
   	case cursor of
      	1785: SetTempCursor(1791);
         1793: SetTempCursor(1794);
      end;
   end;
end;

procedure TImageEnView.KeyUp(var Key: Word; Shift: TShiftState);
begin
	inherited;
   if (not (ssShift in Shift)) and fEnableShiftKey then begin
   	SetTempCursor(fCursor);
      (*
   	case cursor of
   		1791:	SetTempCursor(1785);
         1794: SetTempCursor(1793);
      end;
      *)
   end;
end;

procedure TImageEnView.KeyPress(var Key: Char);
begin
	inherited;
end;

// finalize selection (update fSelectionMask)
procedure TImageEnView.EndSelect;
begin
	fSelectionMask.DrawPolygon(fSelectionIntensity, fHPolySel^.Poly ,fHPolySel^.PolyCount); // update mask
   if fSelectionMask.IsEmpty then begin
   	// empty selection
   	fSel:=false;
	   AnimPolygonClear(integer(fHPolySel));
   end;
end;

function TImageEnView.GetClientWidth:integer;
begin
	if HasParentWindow then
		result:=inherited ClientWidth
   else
   	result:=50;
end;

function TImageEnView.GetClientHeight:integer;
begin
	if HasParentWindow then
		result:=inherited Clientheight
   else
   	result:=50;
end;

procedure TImageEnView.SetSelColor1(v:TColor);
begin
	PIEAnimPOly(fHPolySel)^.Color1:=v;
   fSelColor1:=v;
end;

procedure TImageEnView.SetSelColor2(v:TColor);
begin
	PIEAnimPOly(fHPolySel)^.Color2:=v;
   fSelColor2:=v;
end;

function TImageEnView.GetImageEnIO:TImageEnIO;
begin
	if not assigned(fImageEnIO) then begin
   	fImageEnIO:=TImageEnIO.Create(self);
      fImageEnIO.AttachedImageEn:=self;
      fImageEnIO.OnProgress:=fOnProgress;
   end;
   result:=fImageEnIO;
end;

function TImageEnView.GetImageEnProc:TImageEnProc;
begin
	if not assigned(fImageEnProc) then begin
   	fImageEnProc:=TImageEnProc.Create(self);
      fImageEnProc.AttachedImageEn:=self;
      fImageEnProc.OnProgress:=fOnProgress;
   end;
   result:=fImageEnProc;
end;

procedure TImageEnView.SetOnProgress(v:TIEProgressEvent);
begin
   fOnProgress:=v;
   if assigned(fImageEnIO) then
      fImageEnIO.OnProgress:=v;
   if assigned(fImageEnProc) then
      fImageEnProc.OnProgress:=v;
end;

function TImageEnView.GetOnProgress:TIEProgressEvent;
begin
   result:=fOnProgress;
end;

function TImageEnView.GetTransitionRunning:boolean;
begin
	result:=fTransition.Running;
end;

procedure TImageEnView.PrepareTransition;
begin
	if (GetClientWidth=0) or (GetClientHeight=0) then exit;
   fTransition.SetSizes(ClientWidth,ClientHeight);
  	PaintToEx(fTransition.SourceShot,nil,nil);
end;

procedure TImageEnView.RunTransition(Effect:TIETransitionType; duration:integer);
begin
	if (GetClientWidth=0) or (GetClientHeight=0) then
      exit;
   fTransitionEffect:=Effect;
   fTransitionDuration:=duration;
   fTransition.Transition:=fTransitionEffect;
   fTransition.Duration:=fTransitionDuration;
  	PaintToEx(fTransition.TargetShot,nil,nil);
   fTransition.Run(true);
   fTransitionEffect:=iettNone;
end;

function TImageEnView.GetAlphaChannel:TIEBitmap;
begin
   result:= fIEBitmap.AlphaChannel;
end;

function TImageEnView.GetHasAlphaChannel:boolean;
begin
   result:= fIEBitmap.HasAlphaChannel;
end;

procedure TImageEnView.InvertSelection;
begin
	AnimPolygonClear(integer(fHPolySel));
   ShowSelectionEx(true);
	fSelectionMask.Negative(fSelectionIntensity);
   fDBToDraw:=true;
   Paint;
end;

procedure TImageEnView.SetEnableAlphaChannel(v:boolean);
begin
	fEnableAlphaChannel:=v;
   Update;
end;

procedure TImageEnView.UpdateRect(rclip:TRect);
begin
	fDBToDraw:=true;
   {$ifdef IEDELPHI}
	invalidaterect(handle,@rclip,false);
   {$endif}
end;

procedure TImageEnView.SetSelectedAreaAlpha(Alpha:integer);
var
	y,x:integer;
begin
   if fSelectionMask.IsEmpty then
      // entire image
      GetAlphaChannel.Fill(Alpha)
   else begin
      // selected area
      for y:=0 to fSelectionMask.Height-1 do
         for x:=0 to fSelectionMask.Width-1 do
            if fSelectionMask.GetPixel(x,y)<>0 then
               GetAlphaChannel.Pixels_ie8[x,y]:=Alpha;
   end;
   Update;
end;

procedure TImageEnView.SetSelectionGripStyle(GripColor1,GripColor2:TColor; GripBrushStyle:TBrushStyle; GripSize:integer; ExtendedGrips:boolean);
begin
    fGripColor1:=GripColor1;
    fGripColor2:=GripColor2;
    fGripBrushStyle:=GripBrushStyle;
    fGripSize:=GripSize;
    fExtendedGrips:=ExtendedGrips;
end;

procedure TImageEnView.SetChessboardStyle(Size:integer;BrushStyle:TBrushStyle);
begin
    fChessboardSize:=Size;
    fChessboardBrushStyle:=BrushStyle;
end;

// note: doesn't copy alpha channel
procedure TImageEnView.CopySelectionToBitmap(DestBitmap:TBitmap);
var
	tempbmp:TIEBitmap;
begin
	tempbmp:=TIEBitmap.Create;
	DestBitmap.PixelFormat:=pf24bit;	// otherwise it cannot be encapsulated
   tempbmp.EncapsulateTBitmap(DestBitmap,true);
   CopySelectionToIEBitmap(tempbmp);
   tempbmp.free;
	(*
	if (fRectResizing>-1) or (fSelectMoving>-1) or fRectSelecting then begin
   	fSelectionMask.Empty;
      EndSelect;
   end;
   if not fSelectionMask.IsEmpty then begin
      if fIEBitmap.PixelFormat=ie1g then
         DestBitmap.PixelFormat:=pf1bit
      else if fIEBitmap.PixelFormat=ie24RGB then
         DestBitmap.PixelFormat:=pf24bit;
      DestBitmap.Width:=fSelectionMask.x2-fSelectionMask.x1+1;
      DestBitmap.Height:=fSelectionMask.y2-fSelectionMask.y1+1;
      fSelectionMask.CopyBitmap(DestBitmap,fBitmap,true,false);
   end;
   *)
end;

procedure TImageEnView.CopySelectionToIEBitmap(DestBitmap:TIEBitmap);
begin
	if (fRectResizing<>ieNone) or (fSelectMoving>-1) or fRectSelecting then begin
   	fSelectionMask.Empty;
      EndSelect;
   end;
   if not fSelectionMask.IsEmpty then begin
   	DestBitmap.PixelFormat:=fIEBitmap.PixelFormat;
      DestBitmap.Width:=fSelectionMask.x2-fSelectionMask.x1+1;
      DestBitmap.Height:=fSelectionMask.y2-fSelectionMask.y1+1;
      DestBitmap.Fill(fBackground);
      fSelectionMask.CopyIEBitmap(DestBitmap,fIEBitmap,true,false,true);
   end;
end;

// Assign selection to Dest
// Dest can be TImageEnView, TBitmap, TImage
// Copy also DPIX,Y and background
procedure TImageEnView.AssignSelTo(Dest: TPersistent);
var
	di:TImageEnView;
   db:tbitmap;
   im:TImage;
begin
	if Dest is TImageEnView then begin
   	di:=Dest as TImageEnView;
      if fSelectionMask.IsEmpty then
			//IECopyBitmap(fBitmap,di.Bitmap)
         di.IEBitmap.Assign( fIEBItmap )
      else
      	CopySelectionToIEBitmap(di.IEBitmap);
      di.fBackground:=Background;
      di.SetDPI(fDPIx,fDPIy);
		di.Update;
      di.ImageChange;
   end else if Dest is TBitmap then begin
	   db:=Dest as TBitmap;
      if fSelectionMask.IsEmpty then
			IECopyBitmap(fBitmap,db)
      else
      	CopySelectionToBitmap(db);
      db.Modified:=true;
   end else if Dest is TImage then begin
		im:=Dest as TImage;
      if fSelectionMask.IsEmpty then
			IECopyBitmap(fBitmap,im.picture.bitmap)
      else
      	CopySelectionToBitmap(im.picture.bitmap);
      im.picture.bitmap.Modified:=true;
   end;
end;

// Dest must be pf24bit
procedure TImageEnView.CopyToBitmapWithAlpha(Dest:TBitmap; DestX,DestY:integer);
var
	dummy1:ppointerarray;
   dummy2,dummy3:PInteger;
begin
   if Dest.PixelFormat<>pf24bit then
   	Dest.PixelFormat:=pf24bit;
   if fIEBitmap.HasAlphaChannel then begin
   	dummy1:=nil;
      dummy2:=nil;
      dummy3:=nil;
      fIEBitmap.RenderToTBitmap(Dest,dummy1,dummy2,dummy3,nil,DestX,DestY,fIEBitmap.Width,fIEBitmap.Height,0,0,fIEBitmap.Width,fIEBitmap.Height,true,false,255,rfNone,true,ielNormal);
   end;
end;

procedure TImageEnView.FitToWidth;
var
	EdgeX,EdgeY:integer;
begin
   CalcEdges(EdgeX,EdgeY,false,true);
	if (fMaxLayerWidth<>0) and (fMaxLayerHeight<>0) then begin
      LockPaint;
	   Zoom:=(Width-EdgeX*2)/(fMaxLayerWidth/100);
      Zoom:=(GetClientWidth)/(fMaxLayerWidth/100); // second time needed for scrollbars
      UnLockPaint;
   end;
end;

procedure TImageEnView.FitToHeight;
var
	EdgeX,EdgeY:integer;
begin
   CalcEdges(EdgeX,EdgeY,true,false);
	if (fMaxLayerWidth<>0) and (fMaxLayerHeight<>0) then begin
      LockPaint;
	   Zoom:=(Height-EdgeY*2)/(fMaxLayerHeight/100);
      Zoom:=(GetClientHeight)/(fMaxLayerHeight/100); // second time needed for scrollbars
      UnLockPaint;
   end;
end;

procedure TImageEnView.SetSelectedPixelsColor(color:TRGB);
var
	col,row:integer;
   px:PRGB;
begin
	for row:=0 to fIEBitmap.Height-1 do begin
   	px:=fIEBitmap.Scanline[row];
      for col:=0 to fIEBitmap.Width-1 do begin
      	if fSelectionMask.IsPointInside(col,row) then
				px^:=color;
      	inc(px);
      end;
   end;
   Update;
end;

procedure TImageEnView.SetAlphaRangePixelsColor(alphaMin, alphaMax:integer; color:TRGB);
var
	col,row:integer;
   px:PRGB;
   al:pbyte;
begin
	if not HasAlphaChannel then
   	exit;
	for row:=0 to fIEBitmap.Height-1 do begin
   	px:=fIEBitmap.Scanline[row];
      al:=fIEBitmap.AlphaChannel.ScanLine[row];
      for col:=0 to fIEBitmap.Width-1 do begin
      	if (al^>=alphaMin) and (al^<=alphaMax) then
				px^:=color;
      	inc(px);
         inc(al);
      end;
   end;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Layers

function TImageEnView.GetLayersCount:integer;
begin
   result:=fLayers.Count;
end;

function TImageEnView.GetLayer(idx:integer):TIELayer;
begin
   result:=TIELayer(fLayers[idx]);
end;

procedure TImageEnView.SetLayersCurrent(Value:integer);
begin
   if (Value>=0) and (Value<fLayers.Count) then begin
      // sync current layer (fLayersCurrent=-1 is a temporary state, where no layer is selected)
      if fLayersCurrent>-1 then
         Layers[fLayersCurrent].Bitmap:=fIEBitmap;
      // set new layer
      fLayersCurrent:=Value;
      fIEBitmap:=Layers[Value].Bitmap;
      if fIEBitmap.EncapsulatedFromTBitmap then
	      fBitmap:=fIEBitmap.VclBitmap
      else
      	fBitmap:=nil;
      CallBitmapChangeEvents;
      Update;
   end;
end;

// add a new layer and return its index
// create the bitmap and nil alpha channel
function TImageEnView.LayersAdd:integer;
begin
   result:= fLayers.Add( TIELayer.Create(fIEBitmap,false) );
   LayersCurrent:=result;  // this call update
end;

// insert a new layer and return its index
// create the bitmap and nil alpha channel
procedure TImageEnView.LayersInsert(Position:integer);
begin
   // sync current layer
   Layers[fLayersCurrent].Bitmap:=fIEBitmap;
   //
   fLayers.Insert( Position, TIELayer.Create(fIEBitmap,false) );
   fLayersCurrent:=-1;
   LayersCurrent:=Position;  // this call update
end;

// one layer must remain
procedure TImageEnView.LayersRemove(idx:integer);
var
   l:integer;
begin
   if (fLayers.Count>1) and (idx>-1) and (idx<fLayers.Count) then begin // fLayers.Count>1 is not a bug
      // sync current layer
      Layers[fLayersCurrent].Bitmap:=fIEBitmap;
      // free idx layer
      Layers[idx].Free;
      fLayers.Delete(idx);
      // set new current layer
      if (fLayersCurrent=idx) then begin
         fLayersCurrent:=-1;
         SetLayersCurrent(imin(idx,fLayers.Count-1));
      end else if (fLayersCurrent>idx) then begin
         l:=fLayersCurrent;
         fLayersCurrent:=-1;
         SetLayersCurrent(l-1);
      end;
   end;
end;

procedure TImageEnView.LayersMove(CurIndex,NewIndex:integer);
var
   l:integer;
begin
	if (NewIndex<0) or (NewIndex>=fLayers.Count) then exit;
   // sync current layer
   Layers[fLayersCurrent].Bitmap:=fIEBitmap;
   // save current layer index and make no current layer
   l:=fLayersCurrent;
   fLayersCurrent:=-1;
   // move layer
   fLayers.Move(CurIndex,NewIndex);
   // set new current layer
   if l=CurIndex then
      SetLayersCurrent(NewIndex)
   else if (l=NewIndex) and (NewIndex>0) then
      SetLayersCurrent(NewIndex-1)
   else if (l=NewIndex) and (NewIndex=0) then
      SetLayersCurrent(1)
   else
      SetLayersCurrent(l);
end;

// make sure all layers have same sizes
// synchornize current fBitmap and fAlphaChannel with layers list
procedure TImageEnView.DoLayersSync;
var
   i:integer;
begin
	if fBitmap<>nil then
		fIEBitmap.EncapsulateTBitmap(fBitmap,false); // only sync properties
   // sync current layer
   Layers[fLayersCurrent].Bitmap:=fIEBitmap;
   //
   fMaxLayerWidth:=Layers[0].Bitmap.Width;
   fMaxLayerHeight:=Layers[0].Bitmap.Height;
   if fLayersSync and (fLayers.Count>1) then begin	// useful only for more than one layer
      // search for maximum sizes
      for i:=1 to fLayers.Count-1 do begin
         if Layers[i].Bitmap.Width>fMaxLayerWidth then
            fMaxLayerWidth:=Layers[i].Bitmap.Width;
         if Layers[i].Bitmap.Height>fMaxLayerHeight then
            fMaxLayerHeight:=Layers[i].Bitmap.Height;
      end;
      // set all layers same sizes
      for i:=0 to fLayers.Count-1 do begin
         if (Layers[i].Bitmap.Width<>fMaxLayerWidth) or (Layers[i].Bitmap.Height<>fMaxLayerHeight) then begin
  				Layers[i].Bitmap.AlphaChannel;	// this create alpha channel (requested when resizing layers)
            Layers[i].Bitmap.Resize(fMaxLayerWidth,fMaxLayerHeight,Background,0,iehLeft,ievTop);
			end;
         if Layers[i].Bitmap.HasAlphaChannel and ((Layers[i].Bitmap.AlphaChannel.Width<>fMaxLayerWidth) or (Layers[i].Bitmap.AlphaChannel.Height<>fMaxLayerHeight)) then
            Layers[i].Bitmap.AlphaChannel.Resize(fMaxLayerWidth,fMaxLayerHeight,0,0,iehLeft,ievTop);
      end;
   end;
end;

function TImageEnView.FindLayerAt(x,y:integer):integer;
var
   rect:TRect;
begin
	for result:=fLayers.Count-1 downto 0 do begin
   	rect:=TIELayer(fLayers[result]).ClientAreaBox;
      if _InRect(x,y, rect.Left,rect.Top,rect.Right,rect.Bottom) then
      	break;
   end;
end;

constructor TIELayer.Create(TemplateBitmap:TIEBitmap; JustAssign:boolean);
var
	bmp:TBitmap;
begin
   inherited Create;
   if JustAssign then begin
      Bitmap:=TemplateBitmap;
   end else begin
      Bitmap:=TIEBitmap.Create;
      if TemplateBitmap.EncapsulatedFromTBitmap then begin
         bmp:=TBitmap.Create;
         bmp.Width:=1; bmp.Height:=1;
         bmp.PixelFormat:=TemplateBitmap.VclBitmap.PixelFormat;
         bmp.Width:=TemplateBitmap.Width;
         bmp.Height:=TemplateBitmap.Height;
         Bitmap.EncapsulateTBitmap(bmp,true);
      end else begin
         Bitmap.Location:=TemplateBitmap.Location;
         Bitmap.Allocate(TemplateBitmap.Width,TemplateBitmap.Height,TemplateBitmap.PixelFormat);
      end;
   end;
   fToFree:=true; // assigned to false just before destroy if this is current layer
   Visible:=true;
   Transparency:=255;   // full opaque
   PosX:=0;
   PosY:=0;
   ClientAreaBox:=Rect(0,0,0,0);
   ResizedWidth:=0;
   ResizedHeight:=0;
   Cropped:=false;
   VisibleBox:=true;
   Locked:=false;
   Magnify.Enabled:=false;
   Magnify.Rate:=2;
   Magnify.Style:=iemRectangle;
   Operation:=ielNormal;
end;

destructor TIELayer.Destroy;
begin
   inherited;
   if fToFree then begin
   	if Bitmap.EncapsulatedFromTBitmap then
      	Bitmap.VclBitmap.free;
      Bitmap.Free;
   end;
end;

function TIELayer.GetWidth:integer;
begin
	if ResizedWidth=0 then
   	result:=Bitmap.Width
   else
   	result:=ResizedWidth;
end;

function TIELayer.GetHeight:integer;
begin
	if ResizedHeight=0 then
   	result:=Bitmap.Height
   else
   	result:=ResizedHeight;
end;


// the output layer is always pf24bit
procedure TImageEnView.LayersMerge(Layer0, Layer1:integer);
var
	l0bitmap,l1bitmap:TIEBitmap;
   l0alpha,l1alpha:TIEBitmap;
   l0transp,l1transp:integer;
   l0palpha,l1palpha:pbyte;
   l0prgb,l1prgb:PRGB;
   outbitmap:TIEBitmap;
   outalpha:TIEBitmap;
   outlayer:TIELayer;
   row,col:integer;
   SimAlphaRow0,SimAlphaRow1:pbyte;
   ConvRGBRow0,ConvRGBRow1:PRGB;
   pdestalpha:pbyte;
   al,al10,destalpha10:integer;
   pdest:PRGB;
   lamin,lamax,df:integer;
   aa,bb,cc,opt1:double;
   maxwidth,maxheight:integer;
   all0:pbyte;
   l0posx,l0posy,l1posx,l1posy:integer;
   l0row,l1row:integer;
   l0col,l1col:integer;
   proc:TImageEnProc;
   l0width,l0height:integer;
   l1width,l1height:integer;
   vv:TRGB;
   op:TIERenderOperation;
begin
	DoLayersSync;
   lamin:=imin(Layer0,Layer1);
   lamax:=imax(Layer0,Layer1);
   op:=Layers[lamax].Operation;
   //
   proc:=TImageEnProc.Create(nil);
   // layer 0 vars
	l0bitmap:=Layers[Layer0].Bitmap;
   l0width:=Layers[Layer0].ResizedWidth; if l0width=0 then l0width:=l0bitmap.Width;
   l0height:=Layers[Layer0].ResizedHeight; if l0height=0 then l0height:=l0bitmap.Height;
   if (l0width<>l0bitmap.Width) or (l0height<>l0bitmap.Height) then begin
   	// resize the layer
      proc.AttachedIEBitmap:=l0bitmap;
      proc.Resample(l0width,l0height,fZoomFilter);
   end;
   l0posx:=Layers[Layer0].PosX;
	l0posy:=Layers[Layer0].PosY;
   if Layers[Layer0].Bitmap.HasAlphaChannel then
	   l0alpha:=Layers[Layer0].Bitmap.AlphaChannel
   else
   	l0alpha:=nil;
   l0transp:=Layers[Layer0].Transparency;
   getmem(SimAlphaRow0,l0bitmap.Width);
   l3FillChar(SimAlphaRow0^,l0bitmap.Width,255);
   getmem(ConvRGBRow0,l0bitmap.Width*sizeof(TRGB));
   // layer 1 vars
	l1bitmap:=Layers[Layer1].Bitmap;
   l1width:=Layers[Layer1].ResizedWidth; if l1width=0 then l1width:=l1bitmap.Width;
   l1height:=Layers[Layer1].ResizedHeight; if l1height=0 then l1height:=l1bitmap.Height;
   if (l1width<>l1bitmap.Width) or (l1height<>l1bitmap.Height) then begin
   	// resize the layer
      proc.AttachedIEBitmap:=l1bitmap;
      proc.Resample(l1width,l1height,fZoomFilter);
   end;
   l1posx:=Layers[Layer1].PosX;
	l1posy:=Layers[Layer1].PosY;
   if Layers[Layer1].Bitmap.HasAlphaChannel then
	   l1alpha:=Layers[Layer1].Bitmap.AlphaChannel
   else
   	l1alpha:=nil;
   l1transp:=Layers[Layer1].Transparency;
   getmem(SimAlphaRow1,l1bitmap.Width);
   l3FillChar(SimAlphaRow1^,l1bitmap.Width,255);
   getmem(ConvRGBRow1,l1bitmap.Width*sizeof(TRGB));
   // output vars
   maxwidth:=imax( l0width+l0posx, l1width+l1posx );
   maxheight:=imax( l0height+l0posy, l1height+l1posy );
	outlayer:=TIELayer.Create(l0bitmap,false);
   outbitmap:=outlayer.Bitmap;
   if outbitmap.Pixelformat<>ie24RGB then
		outbitmap.Pixelformat:=ie24RGB;
   outbitmap.Resize( maxwidth, maxheight, 0,255, iehLeft,ievTop );
   outalpha:=outlayer.Bitmap.AlphaChannel; // this creates alpha channel
   outalpha.Full:=false;
   //
   getmem(all0,maxwidth*4);
   l3FillChar(all0^,maxwidth*4,0);
   // combine images
   for row:=0 to MaxHeight-1 do begin
   	// set layer 0 pointers
      l0row:=row-l0posy;
      if (l0row>=0) and (l0row<l0bitmap.Height) then begin
         if assigned(l0alpha) then
            l0palpha:=l0alpha.Scanline[l0row]
         else
            l0palpha:=SimAlphaRow0;
         if l0bitmap.PixelFormat=ie24RGB then
            l0prgb:=l0bitmap.Scanline[l0row]
         else begin
            // convert one row of l0bitmap to 24bit
            _ConvRow1To24(l0bitmap.Scanline[l0row],pbyte(ConvRGBRow0),l0bitmap.Width);
            l0prgb:=ConvRGBRow0;
         end;
      end else begin
      	l0palpha:=all0;
         l0prgb:=PRGB(all0);
      end;
      // set layer 1 pointers
      l1row:=row-l1posy;
      if (l1row>=0) and (l1row<l1bitmap.Height) then begin
         if assigned(l1alpha) then
            l1palpha:=l1alpha.ScanLine[l1row]
         else
            l1palpha:=SimAlphaRow1;
         if l1bitmap.PixelFormat=ie24RGB then
            l1prgb:=l1bitmap.Scanline[l1row]
         else begin
            // convert one row of l1bitmap to 24bit
            _ConvRow1To24(l1bitmap.Scanline[l1row],pbyte(ConvRGBRow1),l1bitmap.Width);
            l1prgb:=ConvRGBRow1;
         end;
      end else begin
      	l1palpha:=all0;
         l1prgb:=PRGB(all0);
      end;
		// set output pointers
      pdest:=outbitmap.Scanline[row];
      pdestalpha:=outalpha.Scanline[row];
      for col:=0 to MaxWidth-1 do begin
      	l0col:=col-l0posx;
         l1col:=col-l1posx;
         // combine pixels
         if (l0col>=0) and (l1col>=0) and (l0col<l0bitmap.Width) and (l1col<l1bitmap.Width) then begin
            aa := imin(l0palpha^,l0transp)/255;
            bb := imin(l1palpha^,l1transp)/255;
            cc := bb + (1-bb)*aa;
            opt1:=(1-bb)*aa;
            if (cc=1) and (opt1=0) then begin
               pdest^.r := l0prgb^.r;
               pdest^.g := l0prgb^.g;
               pdest^.b := l0prgb^.b;
               IEBlend(l1prgb^,pdest^,op);
            end else if cc<>0 then begin
               pdest^.r := blimit(trunc( (bb*l1prgb^.r+opt1*l0prgb^.r)/cc ));
               pdest^.g := blimit(trunc( (bb*l1prgb^.g+opt1*l0prgb^.g)/cc ));
               pdest^.b := blimit(trunc( (bb*l1prgb^.b+opt1*l0prgb^.b)/cc ));
            end;
            pdestalpha^ := blimit(trunc( cc*255 ));
            inc(l0palpha);
            inc(l0prgb);
            inc(l1palpha);
            inc(l1prgb);
         end else if (l0col>=0) and (l0col<l0bitmap.Width) then begin
         	// copy only l0bitmap
         	pdest^.r := l0prgb^.r;
            pdest^.g := l0prgb^.g;
            pdest^.b := l0prgb^.b;
            pdestalpha^ := imin(l0palpha^,l0transp);
            inc(l0palpha);
            inc(l0prgb);
         end else if (l1col>=0) and (l1col<l1bitmap.Width) then begin
         	// copy only l1bitmap
         	pdest^.r := l1prgb^.r;
            pdest^.g := l1prgb^.g;
            pdest^.b := l1prgb^.b;
            pdestalpha^ := imin(l1palpha^,l1transp);
            inc(l1palpha);
            inc(l1prgb);
         end else begin
         	// transparent area
         	pdestalpha^ := 0;
            pdest^ := TColor2TRGB(fBackGround);
         end;
         inc(pdest);
         inc(pdestalpha);
      end;
   end;
   //
   //
   outlayer.Locked:=TIELayer(Layers[lamin]).Locked;
   outlayer.VisibleBox:=TIELayer(Layers[lamin]).VisibleBox;
	// remove old layers
   Layers[lamax].Free;
   fLayers.Delete(lamax);
   Layers[lamin].Free;
   fLayers.Delete(lamin);
	// insert new one
   fLayersCurrent:=-1;
	fLayers.Insert( lamin, outlayer );
   //
   freemem(SimAlphaRow0);
   freemem(SimAlphaRow1);
   freemem(ConvRGBRow0);
   freemem(ConvRGBRow1);
   freemem(all0);
   proc.free;
   // verify if outalpha si full and remove it if not needed
   outalpha.SyncFull;
   if outalpha.Full then begin
   	// remove alpha
      TIELayer(fLayers[lamin]).Bitmap.RemoveAlphaChannel;
   end;
   // make inserted layer as current layer
   LayersCurrent:=lamin;	// this call update
end;

// Layers
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// after changing sizes using Bitmap, we should call Update to sync fIEBitmap
function TImageEnView.GetFBitmap:TBitmap;
begin
	result:=fBitmap;
end;

function TImageEnView.GetIEBitmap:TIEBitmap;
begin
   result:=fIEBitmap;
end;

procedure TImageEnView.SetLegacyBitmap(Value:boolean);
begin
   if Value<>fLegacyBitmap then begin
      if fLegacyBitmap=true then begin
         // from fBitmap to fIEBitmap
         fIEBitmap.EncapsulatedFromTBitmap:=false; // this allows fIEBitmap to full own fBitmap
         fIEBitmap.Location:=ieFile;
         fBitmap:=nil;  // fBitmap freedom by fIEBitmap
      end else begin
         // from fIEBitmap to fBitmap
         fIEBitmap.Location:=ieTBitmap;
         fIEBitmap.EncapsulatedFromTBitmap:=true;  // this deny fIEBitmap to own fBitmap
         fBitmap:=fIEBitmap.VclBitmap;
      end;
      fLegacyBitmap:=Value;
      CallBitmapChangeEvents;
      Update;
   end;
end;

// fOffX,fOffY,frx,fry,fo1x,fo1y,fo2x,fo2y must be valid
procedure TImageEnView.PaintSelection(OutBitmap:TBitmap);
begin
   if (iesoFilled in fSelectionOptions) and PIEAnimPOly(fHPolySel)^.Enabled then
      fSelectionMask.InvertCanvas(OutBitmap.Canvas,fOffX,fOffY,frx,fry, fo1x,fo1y,fo2x,fo2y);
   if (iesoMarkOuter in fSelectionOptions) and PIEAnimPOly(fHPolySel)^.Enabled then
      fSelectionMask.DrawOuter(OutBitmap,fOffX,fOffY,frx,fry, fo1x,fo1y,fo2x,fo2y);
end;

// fOffX,fOffY,frx,fry,fo1x,fo1y,fo2x,fo2y must be valid
procedure TImageEnView.PaintGrid(OutBitmap:TBitmap);
var
	x1,y1,x2,y2,y,x:integer;
begin
   if fDisplayGrid and (fZoom>=400) then
      with OutBitmap.Canvas do begin
         Pen.Mode:=pmNot;
         Pen.Style:=psSolid;
         Pen.Width:=1;
         x1:=XBmp2Scr(fo1x);
         x2:=XBmp2Scr(fo1x+fo2x);
         for y:=fo1y to fo1y+fo2y do begin
            y1:=YBmp2Scr(y);
            MoveTo(x1,y1);
  	         LineTo(x2,y1);
         end;
         y1:=YBmp2Scr(fo1y);
         y2:=YBmp2Scr(fo1y+fo2y);
         for x:=fo1x to fo1x+fo2x do begin
            x1:=XBmp2Scr(x);
            MoveTo(x1,y1);
  	         LineTo(x1,y2);
         end;
      end;
end;

// ABitmap must be pf24bit, width=clientwidth height=clientheight
// ABitmapScanline can be "nil"
// If UpdRect=nil updates entire ABitmap width*height
procedure TImageEnView.PaintToEx(ABitmap:TBitmap; ABitmapScanline:ppointerarray; UpdRect:PRect);
var
	i:integer;
   lBitmap:TIEBitmap;
   IsFirst:boolean;
   Transparency:integer;   // the value of TIELayer.Transpacency field
   zf:TResampleFilter;	// effective zoom filter
   XSrc,YSrc,WidthSrc,HeightSrc:integer;
   XDst,YDst,WidthDst,HeightDst:integer;
   dummy2,dummy3:PInteger;
   layer:TIELayer;
   w,h:integer;
   x1,y1,x2,y2:integer;
   tx,ty:integer;
   //
   procedure SubDrawBackground(force:boolean);
   begin
      if force or (fOffX>0) or (fOffY>0) or (frx<ABitmap.Width) or (fry<ABitmap.Height) or
      (fEnableAlphaChannel and lBitmap.HasAlphaChannel and (not lBitmap.AlphaChannel.Full)) or (Transparency<255) then begin
         (*$ifdef IEDELPHI*)
         if UpdRect<>nil then begin
            with UpdRect^ do
               IntersectClipRect(ABitmap.canvas.handle,left,top,right+1,bottom+1);
         end;
         (*$endif*)
         IEDrawBackground(ComponentState,ABitmap.Canvas,fBackgroundStyle,fBackGround,0,0,ABitmap.Width,ABitmap.Height,fOffX,fOffY,fOffX+frx,fOffY+fry,fChessboardSize,fChessboardBrushStyle,fGradientEndColor);
         (*$ifdef IEDELPHI*)
         SelectClipRgn(ABitmap.canvas.handle,0);
         (*$endif*)
      end;
   end;
   //
begin
   DoLayersSync; // make sure all layers have same sizes
   CalcPaintCoords;
   CreateCoordConvLUT; // recalculates coordinate convertion LUT
   // check for errors in current layer
	if (csDesigning in ComponentState) or (fIEBitmap.Height=0) or (fIEBitmap.Width=0) then
      exit;		// EXIT!
   if fIEBitmap.HasAlphaChannel and ((fIEBitmap.AlphaChannel.Width<>fIEBitmap.Width) or (fIEBitmap.AlphaChannel.Height<>fIEBitmap.Height)) then
   	exit;		// EXIT!
   // draw layers
   IsFirst:=true;
   for i:=0 to fLayers.Count-1 do begin
   	layer:=TIELayer(fLayers[i]);
      lBitmap:=layer.Bitmap;
      if layer.Visible and (frx<>0) and (fry<>0) and (lBitmap.Width>1) and (lBitmap.Height>1) then begin
         Transparency:=layer.Transparency;
         if IsFirst then
            SubDrawBackground(false);
			if (fStable>0) or (fZoom=100) then
         	zf:=rfNone
         else
         	zf:=fZoomFilter;
         if fLayersSync then begin
            lBitmap.RenderToTBitmap(ABitmap,ABitmapScanline,pinteger(fXScr2Bmp),pinteger(fYScr2Bmp),UpdRect, fOffX,fOffY,frx,fry, fo1x,fo1y,fo2x,fo2y, fEnableAlphaChannel,(fBackgroundStyle=iebsSolid) and IsFirst,Transparency,zf,true,layer.Operation);
         end else begin

         	if (i>0) and (layer.Magnify.Enabled) and (layer.Magnify.Rate>=1) then begin
            	// magnify layer
					if layer.ResizedWidth>0 then lBitmap.Width:=layer.ResizedWidth;
               if layer.ResizedHeight>0 then lBitmap.Height:=layer.ResizedHeight;
               lBitmap.Location:=ieTBitmap;
               w:=trunc(lBitmap.Width/(layer.Magnify.Rate/fZoomD100));
               h:=trunc(lBitmap.Height/(layer.Magnify.Rate/fZoomD100));
	            x1:=XBmp2Scr( layer.PosX ) + trunc(lBitmap.Width*fZoomD100/2);
   	         y1:=YBmp2Scr( layer.PosY ) + trunc(lBitmap.Height*fZoomD100/2);
               x2:=x1+w;
               y2:=y1+h;
               x1:=x1- w div 2;
               y1:=y1- h div 2;
               x2:=x2- w div 2;
               y2:=y2- h div 2;
               lBitmap.VclBitmap.Canvas.CopyRect(Rect(0,0,lBitmap.Width,lBitmap.Height),ABitmap.Canvas,Rect(x1,y1,x2,y2));
					case layer.Magnify.Style of
               	iemRectangle:
                  	lBitmap.AlphaChannel.Fill(255);// do nothing
                  iemEllipse:
                  	begin
                        lBitmap.AlphaChannel.Location:=ieTBitmap;
                        lBitmap.AlphaChannel.Fill(0);
                        lBitmap.AlphaChannel.Full:=false;
                        with lBitmap.AlphaChannel.VclBitmap.Canvas do begin
                           Brush.Style:=bsSolid;
                           Brush.Color:=$01000000 or $FF;
                           Pen.Style:=psSolid;
                           Pen.Mode:=pmCopy;
                           Pen.Color:=$01000000 or $FF;
                           Pen.Width:=1;
                           Ellipse(0,0,lBitmap.Width-1,lBitmap.Height-1);
                        end;
                     end;
               end;
            end;

            XDst:=XBmp2Scr( layer.PosX );
            YDst:=YBmp2Scr( layer.PosY );
            w:=layer.ResizedWidth; if w=0 then w:=lbitmap.Width;
            WidthDst:= XBmp2Scr(layer.PosX+w)-XDst;
            h:=layer.ResizedHeight; if h=0 then h:=lbitmap.Height;
            HeightDst:=YBmp2Scr(layer.PosY+h)-YDst;
            XSrc:=0;
            YSrc:=0;
            WidthSrc:=lbitmap.Width;
            HeightSrc:=lbitmap.Height;

            layer.ClientAreaBox := Rect( XDst,YDst, XDst+WidthDst,YDst+HeightDst );

            if layer.Cropped then begin
               // cropped
               if XScr2Bmp( XDst ) <0 then begin
                  XSrc:=-trunc(layer.PosX*(lbitmap.width/w));
                  WidthSrc:=lbitmap.width-XSrc;
                  XDst:=XBmp2Scr(0);
                  WidthDst:=XBmp2Scr(w+layer.posX)-XDst;
                  tx:=layer.PosX;
               end else
               	tx:=0;
               if YScr2Bmp( YDst ) <0 then begin
                  YSrc:=-trunc(layer.PosY*(lbitmap.height/h));
                  HeightSrc:=lbitmap.height-YSrc;
                  YDst:=YBmp2Scr(0);
                  HeightDst:=YBmp2Scr(h+layer.posY)-YDst;
                  ty:=layer.PosY;
               end else
               	ty:=0;
               if XScr2Bmp( XDst+WidthDst )>fMaxLayerWidth then begin
                  WidthDst:=XBmp2Scr(fMaxLayerWidth)-XDst;
                  WidthSrc:=trunc(WidthSrc* (WidthDst/(layer.ClientAreaBox.Right-layer.ClientAreaBox.Left +tx)) );
               end;
               if YScr2Bmp( YDst+HeightDst )>fMaxLayerHeight then begin
                  HeightDst:=YBmp2Scr(fMaxLayerHeight)-YDst;
                  HeightSrc:=trunc(HeightSrc* (HeightDst/(layer.ClientAreaBox.Bottom-layer.ClientAreaBox.Top +ty)) );
               end;
            end;

            if (fStable>0) or ((layer.ResizedWidth=0) and (layer.ResizedHeight=0) and (fZoom=100)) then
               zf:=rfNone
            else
               zf:=fZoomFilter;

            dummy2:=nil;
            dummy3:=nil;
            lBitmap.RenderToTBitmap(ABitmap,ABitmapScanline,dummy2,dummy3,UpdRect, XDst,YDst,WidthDst,HeightDst, XSrc,YSrc,WidthSrc,HeightSrc, fEnableAlphaChannel,(fBackgroundStyle=iebsSolid) and IsFirst,Transparency,zf,true,layer.Operation);
            if (layer.VisibleBox) then begin
               if (i=fLayersCurrent) then begin
                  if (miMoveLayers in fMouseInteract) or (miResizeLayers in fMouseInteract) then
                     DrawLayerBox(ABitmap,i);
                  if (miResizeLayers in fMouseInteract) and (not TIELayer(fLayers[fLayersCurrent]).Locked) then
                     DrawLayerGrips(ABitmap,i);
               end else if fLayersDrawBox then
						DrawLayerBox(ABitmap,i);
            end;
         end;
         IsFirst:=False;
      end;  // end of Visible and (frx<>0) and (fry<>0)
   end;
   // check if no layer is displayed
   if IsFirst then
      SubDrawBackground(true);
   // draw selection
   PaintSelection(ABitmap);
   // draw grid
   PaintGrid(ABitmap);
end;

procedure TImageEnView.DrawLayerBox(ABitmap:TBitmap; idx:integer);
begin
   with ABitmap.Canvas do begin
      Pen.Style:=psDot;
      Pen.mode:=pmNot;
      Brush.Style:=bsClear;
      with TIELayer(fLayers[idx]).ClientAreaBox do
	      Rectangle(Left,Top,Right,Bottom);
   end;
end;

// a layer must be selected (fLayersCurrent must be >-1)
function TImageEnView.FindLayerGrip(x,y:integer):TIEGrip;
var
	coords:array [0..7] of TRect;
   i:integer;
begin
	result:=ieNone;
	if fLayersCurrent>-1 then begin
		CalcLayerGripCoords(fLayersCurrent,coords);
		for i:=0 to 7 do begin
      	with coords[i] do
	      	if _InRect(x,y, left,top,right,bottom) then begin
            	result:=TIEGrip(i+1);
            	break;
            end;
      end;
   end;
end;

// 0=left-top  1=right-top  2=right-bottom  3=left-bottom
// 4=left side
// 5=right side
// 6=top side
// 7=bottom side
procedure TImageEnView.CalcLayerGripCoords( layeridx:integer; var coords:array of TRect );
const
   HSZ=4;	// half size
begin
	with TIELayer(fLayers[layeridx]).ClientAreaBox do begin
      // left | top
      coords[0].Left:=left-HSZ;
      coords[0].Top:=top-HSZ;
      coords[0].Right:=left+HSZ;
      coords[0].Bottom:=top+HSZ;
      // right | top
      coords[1].Left:=right-HSZ;
      coords[1].Top:=top-HSZ;
      coords[1].Right:=right+HSZ;
      coords[1].Bottom:=top+HSZ;
      // right | bottom
      coords[2].Left:=right-HSZ;
      coords[2].Top:=bottom-HSZ;
      coords[2].Right:=right+HSZ;
      coords[2].Bottom:=bottom+HSZ;
      // left | bottom
      coords[3].Left:=left-HSZ;
      coords[3].Top:=bottom-HSZ;
      coords[3].Right:=left+HSZ;
      coords[3].Bottom:=bottom+HSZ;
      // left | center
      coords[4].Left:=left-HSZ;
      coords[4].Top:=((top+bottom) div 2)-HSZ;
      coords[4].Right:=left+HSZ;
      coords[4].Bottom:=((top+bottom) div 2)+HSZ;
      // right | center
      coords[5].Left:=right-HSZ;
      coords[5].Top:=((top+bottom) div 2)-HSZ;
      coords[5].Right:=right+HSZ;
      coords[5].Bottom:=((top+bottom) div 2)+HSZ;
      // top | center
      coords[6].Left:=((left+right) div 2)-HSZ;
      coords[6].Top:=top-HSZ;
      coords[6].Right:=((left+right) div 2)+HSZ;
      coords[6].Bottom:=top+HSZ;
      // bottom | center
      coords[7].Left:=((left+right) div 2)-HSZ;
      coords[7].Top:=bottom-HSZ;
      coords[7].Right:=((left+right) div 2)+HSZ;
      coords[7].Bottom:=bottom+HSZ;
   end;
end;

procedure TImageEnView.DrawLayerGrips(ABitmap:TBitmap; idx:integer);
var
	i:integer;
   coords:array [0..7] of TRect;
begin
	CalcLayerGripCoords(idx,coords);
	with ABitmap.Canvas do begin
   	Pen.Style:=psSolid;
      Pen.Mode:=pmCopy;
      Pen.Color:=clBlack;
      Brush.Style:=bsSolid;
      Brush.Color:=clWhite;
      for i:=0 to 7 do
      	with coords[i] do
	      	Rectangle( Left,Top, Right,Bottom );
   end;
end;

procedure TImageEnView.SaveSelectionToStream(Stream:TStream);
begin
	// main sizes
   Stream.Write(fSelectionMask.Width,sizeof(fSelectionMask.Width));
   Stream.Write(fSelectionMask.Height,sizeof(fSelectionMask.Height));
   // TImageEnView
   Stream.Write(fHPolySel^.PolyCount,sizeof(fHPolySel^.PolyCount));
   Stream.Write(fHPolySel^.Poly^,sizeof(TPoint)*fHPolySel^.PolyCount);
   Stream.Write(fHPolySel^.RX1,sizeof(fHPolySel^.RX1));
   Stream.Write(fHPolySel^.RY1,sizeof(fHPolySel^.RY1));
   Stream.Write(fHPolySel^.RX2,sizeof(fHPolySel^.RX2));
   Stream.Write(fHPolySel^.RY2,sizeof(fHPolySel^.RY2));
   Stream.Write(fSel,sizeof(fSel));
   // TIEMask
   Stream.Write(fSelectionMask.BitsPerPixel,sizeof(fSelectionMask.BitsPerPixel));
   Stream.Write(fSelectionMask.X1,sizeof(fSelectionMask.X1));
   Stream.Write(fSelectionMask.Y1,sizeof(fSelectionMask.Y1));
   Stream.Write(fSelectionMask.X2,sizeof(fSelectionMask.X2));
   Stream.Write(fSelectionMask.Y2,sizeof(fSelectionMask.Y2));
   Stream.Write(fSelectionMask.Full,sizeof(fSelectionMask.Full));
   Stream.Write(fSelectionMask.Bits^,fSelectionMask.Height*fSelectionMask.RowLen);
end;

// return false if cannot load the selection (the background bitmap has wrong sizes)
function TImageEnView.LoadSelectionFromStream(Stream:TStream):boolean;
var
   w,h,b,x1,y1,x2,y2:integer;
   f:boolean;
begin
	// main sizes
   result:=false;
   Stream.Read(w,sizeof(fSelectionMask.Width));
   Stream.Read(h,sizeof(fSelectionMask.Height));
   if (w=fMaxLayerWidth) and (h=fMaxLayerHeight) then begin
      // TImageEnView
      if fHPolySel^.Poly<>nil then
         freemem(fHPolySel^.Poly);
      fHPolySel^.Poly:=nil;
      Stream.Read(fHPolySel^.PolyCount,sizeof(fHPolySel^.PolyCount));
      getmem(fHPolySel^.Poly,sizeof(TPoint)*(fHPolySel^.PolyCount+64));
      Stream.Read(fHPolySel^.Poly^,sizeof(TPoint)*fHPolySel^.PolyCount);
      Stream.Read(fHPolySel^.RX1,sizeof(fHPolySel^.RX1));
      Stream.Read(fHPolySel^.RY1,sizeof(fHPolySel^.RY1));
      Stream.Read(fHPolySel^.RX2,sizeof(fHPolySel^.RX2));
      Stream.Read(fHPolySel^.RY2,sizeof(fHPolySel^.RY2));
      Stream.Read(fSel,sizeof(fSel));
      // TIEMask
      Stream.Read(b,sizeof(fSelectionMask.BitsPerPixel));
      fSelectionMask.AllocateBits(w,h,b);
      Stream.Read(x1,sizeof(fSelectionMask.X1));
      Stream.Read(y1,sizeof(fSelectionMask.Y1));
      Stream.Read(x2,sizeof(fSelectionMask.X2));
      Stream.Read(y2,sizeof(fSelectionMask.Y2));
      fSelectionMask.X1:=x1;
      fSelectionMask.Y1:=y1;
      fSelectionMask.X2:=x2;
      fSelectionMask.Y2:=y2;
      Stream.Read(f,sizeof(fSelectionMask.Full));
      fSelectionMask.Full:=f;
      Stream.Read(fSelectionMask.Bits^,fSelectionMask.Height*fSelectionMask.RowLen);
      ShowSelectionEx(true);
      Update;
      result:=true;
   end;
end;

// push current selection in fSavedSelection list
procedure TImageEnView.SaveSelection;
var
	ms:TMemoryStream;
begin
	ms:=TMemoryStream.Create;
   SaveSelectionToStream(ms);
   fSavedSelection.Add(ms);
end;

// pop a selection from fSavedSelection list
function TImageEnView.RestoreSelection:boolean;
var
	ms:TMemoryStream;
begin
	result:=false;
   if fSavedSelection.Count>0 then begin
		ms:=fSavedSelection[ fSavedSelection.Count-1 ];
   	ms.Position:=0;
		result:=LoadSelectionFromStream(ms);
		ms.free;
      fSavedSelection.Delete( fSavedSelection.Count-1 );
   end;
end;

// if merge is true merges the alpha channel with the background color
procedure TImageEnView.RemoveAlphaChannel(Merge:boolean);
var
	x,y:integer;
   px:PRGB;
   al:pbyte;
   a:integer;
   br,bg,bb:integer;
begin
	if Merge and (fIEBitmap.PixelFormat=ie24RGB) and (fIEBitmap.HasAlphaChannel) then begin
   	// merges with fBackground color
      with TColor2TRGB(fBackground) do begin
      	br:=r;
         bg:=g;
         bb:=b;
      end;
		for y:=0 to fIEBitmap.Height-1 do begin
      	px:=fIEBitmap.Scanline[y];
         al:=fIEBitmap.AlphaChannel.Scanline[y];
			for x:=0 to fIEBitmap.Width-1 do begin
				a:=al^ shl 10;
         	with px^ do begin
					r:=(a*(r-br) shr 18 +br);
               g:=(a*(g-bg) shr 18 +bg);
               b:=(a*(b-bb) shr 18 +bb);
            end;
         	inc(px);
            inc(al);
         end;
      end;
   end;
	//
   fIEBitmap.RemoveAlphaChannel;
end;

function TImageEnView.QuantizeViewX(vx:integer):integer;
begin
	result:=vx;
   if result<0 then result:=0;
   if (result<fZZWW) and (fGXBmp2Scr<>nil) and (fXScr2BmpSize>0) then
   	result:=fGXBmp2Scr[fGXScr2Bmp[result]];
end;

function TImageEnView.QuantizeViewY(vy:integer):integer;
begin
	result:=vy;
   if result<0 then result:=0;
   if (result<fZZHH) and (fGYBmp2Scr<>nil) and (fYScr2BmpSize>0) then
   	result:=fGYBmp2Scr[fGYScr2Bmp[result]];
end;

procedure TImageEnView.CreateCoordConvLUT;
var
	i,v:integer;
   scrx,scry,bmpx,bmpy:integer;
   qviewx,qviewy:integer;
begin
	if (fLutLastZoom<>fZoom) or (fLutLastFRX<>frx) or (fLutLastFRY<>fry) or (fLutLastMaxLayerWidth<>fMaxLayerWidth) or (fLutLastMaxLayerHeight<>fMaxLayerHeight) then begin
      // free olds
      if fGXScr2Bmp<>nil then
         freemem(fGXScr2Bmp);
      if fGYScr2Bmp<>nil then
         freemem(fGYScr2Bmp);
      if fGXBmp2Scr<>nil then
         freemem(fGXBmp2Scr);
      if fGYBmp2Scr<>nil then
         freemem(fGYBmp2Scr);
      fGXScr2Bmp:=nil;
      fGYScr2Bmp:=nil;
      fGXBmp2Scr:=nil;
      fGYBmp2Scr:=nil;
      fXScr2Bmp:=nil;
      fYScr2Bmp:=nil;
      fXBmp2Scr:=nil;
      fYBmp2Scr:=nil;
      fXScr2BmpSize:=0;
      fYScr2BmpSize:=0;
      fXBmp2ScrSize:=0;
      fYBmp2ScrSize:=0;
      // check validity
      if (fry=0) or (frx=0) then exit;
      if (IEBitmap.Width=0) or (IEBitmap.Height=0) then exit;
      // sizes
      fXScr2BmpSize:=frx;
      fYScr2BmpSize:=fry;
      fXBmp2ScrSize:=trunc(frx*f100DZoom);
      fYBmp2ScrSize:=trunc(fry*f100DZoom);
      //
      scrx:=fZZWW+fXScr2BmpSize+1;
      scry:=fZZHH+fYScr2BmpSize+1;
      bmpx:=trunc(scrx*f100DZoom)+1;
      bmpy:=trunc(scry*f100DZoom)+1;
      getmem(fGXScr2Bmp,(scrx+1)*sizeof(integer));
      getmem(fGYScr2Bmp,(scry+1)*sizeof(integer));
      getmem(fGXBmp2Scr,(bmpx+1)*sizeof(integer));
      getmem(fGYBmp2Scr,(bmpy+1)*sizeof(integer));
      //
      if fZoom>100 then begin
         for i:=scrx-1 downto 0 do begin
            v:=trunc(i*f100DZoom);
            fGXBmp2Scr[v]:=i;
            fGXScr2Bmp[i]:=imin(v, imax(fMaxLayerWidth-1,0) );
         end;
         for i:=scry-1 downto 0 do begin
            v:=trunc(i*f100DZoom);
            fGYBmp2Scr[v]:=i;
            fGYScr2Bmp[i]:=imin(v, imax(fMaxLayerHeight-1,0) );
         end;
      end else begin
         for i:=bmpx-1 downto 0 do begin
            v:=trunc(i*fZoomD100);
            fGXBmp2Scr[i]:=v;
            fGXScr2Bmp[v]:=imin(i, imax(fMaxLayerWidth-1,0) );
         end;
         for i:=bmpy-1 downto 0 do begin
            v:=trunc(i*fZoomD100);
            fGYBmp2Scr[i]:=v;
            fGYScr2Bmp[v]:=imin(i, imax(fMaxLayerHeight-1,0) );
         end;
      end;
      //
      fLutLastZoom:=fZoom;
      fLutLastFRX:=frx;
      fLutLastFRY:=fry;
      fLutLastMaxLayerWidth:=fMaxLayerWidth;
      fLutLastMaxLayerHeight:=fMaxLayerHeight;
   end;
   if fXScr2BmpSize>0 then begin	// check one for all (don't care YScr2BmpSize...)
   	qviewx:=QuantizeViewX(fViewX);
      qviewy:=QuantizeViewY(fViewY);
      fXBmp2Scr:=@fGXBmp2Scr[ fGXScr2Bmp[qViewX] -fo1x];
      fYBmp2Scr:=@fGYBmp2Scr[ fGYScr2Bmp[qViewY] -fo1y];
      fXScr2Bmp:=@fGXScr2Bmp[qViewX];
      fYScr2Bmp:=@fGYScr2Bmp[qViewY];
   end;
end;

procedure TImageEnView.SetCursor(Value:TCursor);
begin
	fCursor:=Value;
   SetTempCursor(Value);
end;

procedure TImageEnView.SetTempCursor(Value:TCursor);
begin
	inherited Cursor:=Value;
   (*$ifdef IEDELPHI*)
  {$IfDef Nemesis}
  if Showing then // - http://mdp.garant.ru/pages/viewpage.action?pageId=564723762
  {$EndIf Nemesis}
   Windows.SetCursor(Screen.Cursors[Value]);
   (*$endif*)
end;

procedure TImageEnView.SetDelayTimer(Value:integer);
begin
	fAnimPolyTimer.Interval:=Value;
end;

function TImageEnView.GetDelayTimer:integer;
begin
	result:=fAnimPolyTimer.Interval;
end;

procedure TImageEnView.SetGradientEndColor(Value:TColor);
begin
	fGradientEndColor:=Value;
   Update;
end;

procedure TImageEnView.CenterImage;
begin
	SetViewXY( (fIEBitmap.Width-Width) div 2 , (fIEBitmap.Height-Height) div 2 );
end;

procedure TImageEnView.LockUpdate;
begin
	fUpdateLocked:=true;
end;

procedure TImageEnView.UnLockUpdate;
begin
	fUpdateLocked:=false;
   Update;
end;

procedure TImageEnView.SetDrawVersion(v:boolean);
begin
	fDrawVersion:=v;
   Update;
end;

procedure TImageEnView.SetSelectionMaskDepth(value:integer);
begin
	if value<>fSelectionMaskDepth then begin
      if fSel then
          Deselect;
   	fSelectionMaskDepth:=value;
   	fSelectionMask.AllocateBits(fIEBitmap.Width,fIEBitmap.Height,fSelectionMaskDepth);
      fSelectionIntensity:=255;
   end;
end;

procedure TImageEnView.SetSelectionIntensity(value:integer);
var
	px:pbyte;
   i,j:integer;
begin
	fSelectionIntensity:=value;
   if fSel and (fSelectionMask.BitsPerPixel=8) then begin
   	// changes current selection
      with fSelectionMask do begin
			for i:=y1 to y2 do begin
         	px:=Scanline[i]; inc(px,x1);
         	for j:=x1 to x2 do begin
            	if px^>0 then
               	px^:=value;
            	inc(px);
            end;
   	   end;
      end;
   end;
end;

procedure TImageEnView.MakeSelectionFeather(radius:double);
var
	bmp:TIEBitmap;
   ww,x1,y1,x2,y2:integer;
begin
	if fSel and (fSelectionMask.BitsPerPixel=8) then begin
	   AnimPolygonClear(integer(fHPolySel));
		bmp:=TIEBitmap.Create;
      bmp.EncapsulateMemory(fSelectionMask.Bits,fSelectionMask.Width,fSelectionmask.Height,ie8g,false);
      ww:=imax(trunc(radius*5),1);
      x1:=imax(fSelectionMask.X1-ww,0);
		y1:=imax(fSelectionMask.Y1-ww,0);
      x2:=imin(fSelectionMask.X2+ww,fSelectionMask.Width-1);
      y2:=imin(fSelectionMask.Y2+ww,fSelectionMask.Height-1);
		_IEGBlurRect8(bmp,x1,y1,x2,y2,radius);
      bmp.free;
      fSelectionMask.SyncRect;
      ShowSelectionEx(true);
	   fDBToDraw:=true;
   	Paint;
   end;
end;

procedure TImageEnView.SetLayersSync(value:boolean);
begin
	if not fLayersSync then exit;	// you cannot set LayerSync=true (default), but only LayerSync=false
	if value<>fLayersSync then begin
   	fLayersSync:=value;
      if fLayersSync then
			DoLayersSync;
   end;
end;

procedure TImageEnView.SetLayersDrawBox(value:boolean);
begin
	if value<>fLayersDrawBox then begin
   	fLayersDrawBox:=value;
      Update;
   end;
end;

procedure TImageEnView.DoLayerNotify(layer:integer; event:TIELayerEvent);
begin
	if assigned(fOnLayerNotify) then
   	fOnLayerNotify(self,layer,event);
end;

procedure TImageEnView.WMCopy(var Message: TMessage);
begin
 Clipboard.Assign(Bitmap);
end;

procedure TImageEnView.WMCut(var Message: TMessage);
begin
 Clipboard.Assign(Bitmap);
 Blank;
 Update;
end;

procedure TImageEnView.DShowNewFrame(var Message:TMessage);
var
	dshow:TIEDirectShow;
begin
	dshow:=TIEDirectShow(pointer(Message.LParam));
	if assigned(dshow) and dshow.Connected and assigned(fOnDShowNewFrame) then
   	fOnDShowNewFrame(self);
end;

procedure TImageEnView.DShowEvent(var Message:TMessage);
var
	dshow:TIEDirectShow;
begin
	dshow:=TIEDirectShow(pointer(Message.LParam));
	if assigned(dshow) and dshow.Connected and assigned(fOnDShowEvent) then
   	fOnDShowEvent(self);
end;



procedure TImageEnView.SetAutoFit(const Value: boolean);
begin
 fAutoFit := Value;
 Update;
end;

procedure TImageEnView.SetAutoShrink(const Value: boolean);
begin
 fAutoShrink := Value;
 Update;
end;

procedure TImageEnView.SetAutoStretch(const Value: boolean);
begin
 fAutoStretch := Value;
 Update;
end;

initialization
   InitImageEnView;

finalization
	begin
   	{$ifdef IEDELPHI}
      try
        if FhGradientFill > 0 then
          FreeLibrary(fhGradientFill);
      except
       on E: Exception do
        l3System.Exception2Log(E);
      end;
		{$endif}
   end;


end.

