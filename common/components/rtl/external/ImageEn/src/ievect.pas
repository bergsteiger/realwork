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

unit ievect;

{$R-}
{$Q-}


{$I ie.inc}

(*$ifdef IEDELPHI*)

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, ImageEnView,
   Controls, StdCtrls, Forms, hyieutils, hyiedefs ,ietextc;

const
   strunits:array [0..7] of AnsiString=('pixels','inches','km','mt','cm','mm','microns','nanometers');
   NULLOBJ=-4;
   DEFWIDTH=64;
   DEFHEIGHT=64;
	IEVECTCLIPFORMAT_NAME:AnsiString='IMAGEEN VECT';
	// IEV file format
	IEVMAGIC='IEV';	// magic number
   IEVVER:byte=65;	// current version

var
	IEVECTCLIPFORMAT:integer;

type

	TIECurve=(iecNone,iecEllipse,iecCosine,iecVertical,iecHorizontal,iecArc);

   TDPoint=record
   	X,y:double;
   end;
   TDPointArray=array [0..Maxint div 32] of TDPoint;
   PDPointArray=^TDPointArray;

   // objects types
   TIEVObjectKind=(iekNONE,iekLINE,iekBOX,iekELLIPSE,iekARC,iekBITMAP,iekTEXT,iekRULER,iekPOLYLINE,iekANGLE,iekMEMO,iekLINELABEL);

   // shape types for iekLINE/iekLINELABEL (initial and ending shapes)
   TIEShape=(iesNONE,iesINARROW,iesOUTARROW);

   // Ruler types
   TIEVRulerType=(iertRULER, iertQUOTEBEGIN, iertQUOTECENTER, iertQUOTEEND);

   // Bitmap for a iekBitmap object
   TIEVBitmap=record
   	fBitmap:TIEBitmap;
      fRefCount:integer; // objects count that own this bitmap (0 is not allowed)
   end;
   PIEVBitmap=^TIEVBitmap;
   TIEVBitmapArray=array [0..MaxInt div 128] of TIEVBitmap;
   PIEVBitmapArray=^TIEVBitmapArray;

   TIEVStyle=set of (ievsSelectable, ievsMoveable, ievsSizeable, ievsVisible);

   PIEVObject=^TIEVObject;

	// mesure unit
   TIEUnits=(ieuPIXELS, ieuINCHES, ieuKM, ieuMETERS, ieuCENTIMETERS, ieuMILLIMETERS, ieuMICRONS, ieuNANOMETERS);

   // text label position
   TIELabelPos=(ielBegin,ielEnd);

   // the object
   TIEVObject=record
   	// shared fields
   	x1,y1,x2,y2:integer; // object rectangle (in pixel, with zoom at 100%). The coordinates are sorted (but not for Kind=iekLINE,iekLINELABEL).
      Kind:TIEVObjectKind; // object type
      Transparency:integer;
      // iekLINE / iekLINELABEL
      BeginShape:TIEShape;
      EndShape:TIEShape;
      ShapeWidth:integer;
      ShapeHeight:integer;
      // iekLINELABEL
      LabelBrushColor:TColor;
      LabelBrushStyle:TBrushStyle;
      LabelPosition:TIELabelPos;
	   // pen
   	PenColor:TColor;
      PenStyle:TPenStyle;
      PenWidth:integer;
		// brush
      BrushColor:TColor;
      BrushStyle:TBrushStyle;
      BoxHighlight:boolean;
      // iekARC
      a1,a2:double;  // starting and ending angle (radians)
	   // iekBITMAP
      BitmapIdx:integer;
      // iekTEXT / iekMEMO / iekLINELABEL / iekRULER
      Text:PAnsiChar;	// allocated
      LogFont:PLogFont;	// allocated
      TextAlign:TIEAlignment;
      TextAutoSize:boolean;
      FontLocked:boolean;
      CurvedPos:PDPointArray;
      CurvedLen:integer;
      CurvedCharRot:integer;
      // iekMEMO
      TextFormatRef:pintegerarray;	// allocated
      TextFormat:TList;					// allocated
      LineSpace:integer;
      MemoBorderColor:TColor;
      MemoBorderStyle:TPenStyle;
      MemoFixedHeight:integer;
      // others
      Name:PAnsiChar;	// object user name (allocated)
      ID:integer; // object user ID
      Style:TIEVStyle;
      // iekRULER
      RulerUnit:TIEUnits;
      RulerType:TIEVRulerType;
      // iekPOLYLINE
      PolyPoints:pointer;		// array of TPoint. Coordinates are in bitmap pixels, they are never translated or resized.
      								// C++Builder doesn't work with PolyPoints as PPointArray
      PolyPointsCount:integer;	// PolyPoints count
      PolyBaseX1,PolyBaseY1,PolyBaseX2,PolyBaseY2:integer; 			// original rectangle
      PolyClosed:boolean;	// the polygon is closes (filled with a brush)
      DrawnPoints:pointer;
      DrawnPointsCount:integer;
   	// iekANGLE
      AnglePoints:array [0..2] of TPoint;
      // working fields
      lx1,ly1,lx2,ly2:integer;	// used when resizing objects to store original coordinates
      plim:trect; // paint limits (last paint limits)
      pwidth:integer;	// painted width
      // softshadow
      softShadow:TIEVSoftShadow;	// allocated
   end;

   TIEVObjectArray=array [0..MaxInt div 256] of TIEVObject;
   PIEVObjectArray=^TIEVObjectArray;

   // automatic mouse interactions
   TIEMouseInteractVtItems=(
  								  miArea,			// Area of rectangle/polygon
                          miLineLen,		// Measure line length
                          miPutLine,		// Insert a line object
                          miPutBox,			// Insert a rectangle object
                          miPutEllipse,	// Insert a ellipse object
                          miPutBitmap,		// Insert a bitmap object
                          miPutText,      // Insert a text object
                          miObjectSelect, // Select/modify object
                          miDragLen,		// dynamically measure distance
                          miPutRuler,		// Insert a ruler object
                          miPutPolyLine,	// Insert a polyline object
                          miPutAngle,		// Insert an angle object
                          miPutMemo,		// Insert a multi line text object
                          miPutLineLabel, // Insert a line with a label
                          miEditPolyline	// Edit points of a polyline
  								);
   TIEMouseInteractVt=set of TIEMouseInteractVtItems;

   TIEVMeasureHintEvent = procedure(Sender: TObject; var Text:AnsiString; Value:double) of object;

   TIEVDragLenEndEvent = procedure(Sender:TObject; Value:double) of object;

   TIEVNewObject = procedure(Sender:TObject; hobj:integer) of object;

	TIEVObjectMoveResizeEvent = procedure(Sender:TObject; hobj:integer; Grip:integer; var OffsetX,OffsetY:integer) of object;

   TIEVObjectClickEvent = procedure(Sender:TObject; hobj:integer) of object;


	TImageEnVect=class(TImageEnView)
		private
      	fCacheBitmap:TIEBitmap;
			fMouseInteractVt:TIEMouseInteractVt;
         fScale:double;	// scale factor (e.g. for 1/100000 is 100000)
         fMUnit:TIEUnits;	// measure unit for all tasks
         fCoefX,fCoefY:double; // Coef measure unit (includes DPI,Scale and MUnit)
         fFloatPrecision:integer;	// to display values
         fFloatDigits:integer;		// to display values
         fMeasureTrack:boolean;		// nelle misure considera coordinate temporanee
         fVMoveX,fVMoveY:integer;	// coordinate mousemove
         fOnSelectObject:TNotifyEvent;
         fOnMeasureHint:TIEVMeasureHintEvent;
         fOnDragLenEnd:TIEVDragLenEndEvent;
         fZoomObjectsWidth:boolean;
         fOnVectorialChanged:TNotifyEvent;
         fOnBeforeVectorialChanged:TNotifyEvent;
         fLastHintValue:double;
         fMaxSelectionDistance:integer;
         flx,fly:integer;
         fHintSaveBitmap:TBitmap;
         fShowHint:boolean;
         fHintX,fHintY:integer;
         fMovX,fMovY:integer;
         fMeasureHintFont:TFont;
         fMeasureHintBrush:TBrush;
         fMeasureHintBorder1:TColor;
         fMeasureHintBorder2:TColor;
         fGripSize:integer;
         fGripPen:TPen;
         fGripBrush:TBrush;
         fMemoWriteFormattedString:PIEVObject;	// nil no write, otherwise is an object pointer
         fMemoFormattedString:AnsiString;
         fUseCentralGrip:boolean;
         fCurPolylineGrip:integer;
         fCurPolylineIntraGrip:integer;
         fSelectOnMouseDown:boolean;
         // Contains a list of PIEVObject. The order of the objects indicates the display order.
         // The first obejct [0] is painted first.
	   	fObjCount:integer;	// TIEVObject objects count
	      fObj:pintegerarray; // object indexes
         // Objects
         fVectorialChanging:boolean;
         fInserting:TIEVObjectKind; // Current inserting object kind (none=iekNONE)
         fInsertingPolylineObject:integer;
         fInsertingPolylineLastX,fInsertingPolylineLastY:integer;
         fInsertingAngleObject:integer;
			fNewObj:TIEVObject; // data of next object to insert
         fSelObj:pintegerarray; // selected objects
         fSelObjCount:integer; // selected objects count
         fGripping:integer; // changing selected objects (index of modifier grip 0=nothing)
			fTextEditing:integer; // >=0 object iekTEXT/iekMEMO that we are editing (-1=nothing)
         fTextEdit:TEdit;	// Component for editing (fTextEditing)
         fMemoEdit:TIETextControl;
         fObjAntialias:boolean;
         // objects storage
         // Objects are allocated in sequence. Free items are reused for new objects.
         fObjHeap:PIEVObjectArray;	// here are objects
         fObjHeapCount:integer; 		// allocated objects (could be not equal to existing objects)
			// Bitmaps di iekBitmap
         fBitmaps:PIEVBitmapArray; // bitmap array (iebBITMAP)
         fBitmapsCount:integer; // fBitmaps count
         fShareBitmaps:boolean;	// Se false ogni bitmap è individuale
			fAllObjectsHidden: boolean; // true if we temporarily hide all objects
         fOnNewObject:TIEVNewObject;
         fBitmapResampleFilter:TResampleFilter;
         fOnObjectMoveResize:TIEVObjectMoveResizeEvent;
         fOnObjectClick:TIEVObjectClickEvent;
         fOnObjectDblClick:TIEVObjectClickEvent;
         fOnObjectOver:TIEVObjectClickEvent;
         fObjDrawed:integer;	// drawn objects at last paint
         fObjGraphicRender:boolean;
         // Undo
         fObjUndoList:TList;
         fObjUndoLimit:integer;
         fObjAutoUndo:boolean;
         //
         procedure HintRestore;
         procedure HintShow(x,y:integer);
			procedure SetAllObjectsHidden(Value: boolean);
         procedure TextEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
         procedure TextEditOnChange(Sender:TObject);
         procedure MemoEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
         //
         procedure CalcCoef(var cx,cy:double; mu:TIEUnits);
         procedure DrawLineInserting;
         procedure DrawBoxInserting;
         procedure DrawEllipseInserting;
         procedure DrawRulerInserting;
         procedure DrawAngleInserting;
         procedure DrawRuler(wcanvas:TCanvas; x1,y1,x2,y2:integer; um:TIEUnits; Color:TColor; PW:integer; RulerType:TIEVRulerType; zz:double; var plim:trect; logfont:PLogFont);
         procedure DrawAngle(wcanvas:TCanvas; AnglePoints:array of TPoint; Color:TColor; PW:integer; var plim:trect; usezoom:boolean; mul:integer; zz:double);
         // Objects
         procedure RemoveVObjData(var obj:TIEVObject);
         procedure RemoveVObjDataAll;
         function AddVObject(const aObj:TIEVObject):integer;
         procedure RemoveVObject(hobj:integer);
         function GetObj(hobj:integer):PIEVObject;
         function DrawObject(var aobj:TIEVObject; BBitmap:TBitmap; CheckLimits:boolean; UseZoom:boolean; DrawOnTIEBitmap:TIEBitmap; mul:integer; drawingalpha:boolean):boolean;
         procedure DrawObjectAll(re:boolean; BBitmap:TBitmap; antialias:boolean);
         procedure DrawObjectText(wcanvas:TCanvas; x1,y1,x2,y2:integer; var aobj:TIEVObject; zz:double; drawingalpha:boolean; var plim:trect);
         procedure DrawObjectLineLabel(wcanvas:TCanvas; lx1,ly1,lx2,ly2:integer; const aobj:TIEVObject; zz:double; var plim:trect);
         procedure DrawObjectGrips(Canvas:TCanvas; const aobj:TIEVObject);
         function FindNearObj(x,y:integer; var ds:double; mustbeselectable:boolean):integer;
         function FindPolylineIntraPoint(x,y:integer):integer;
         function CalcDistPtObj(Obj:PIEVObject; x,y:integer):double;
         procedure DrawSelGrips(Canvas:TCanvas);
         function FindSelGrip(x,y:integer; var gr:integer):integer;
         procedure TraslateObject(o:integer; ox,oy:integer);
			procedure ChangeObjectCoor(o:integer; ox1,oy1,ox2,oy2:integer; AspectRatio:boolean; grip:integer);
         procedure SelInRect(aobj:integer; xx1,yy1,xx2,yy2:integer);
         procedure DrawLineShape(aobj:TIEVObject; Canvas:TCanvas;x1,y1,x2,y2:integer;Shape:TIEShape; w,h:integer; var plim:trect);
         procedure AddSelObjectNS(hobj:integer);
         procedure ActiveTextEdit;
         procedure RemoveTextEdit;
         procedure SaveObj(Stream:TStream; hobj:integer);
         function ReadObj(Stream:TStream; ver:byte; LoadBitmapIdx:boolean):integer;
         procedure CalcZxZyPolyline(Obj:PIEVObject; var zx,zy:double);
         //
         function GetObjKind(hobj:integer):TIEVObjectKind;
         procedure SetObjKind(hobj:integer; v:TIEVObjectKind);
         function GetObjPenColor(hobj:integer):TColor;
         procedure SetObjPenColor(hobj:integer; v:TColor);
         function GetObjPenStyle(hobj:integer):TPenStyle;
         procedure SetObjPenStyle(hobj:integer; v:TPenStyle);
         function GetObjPenWidth(hobj:integer):integer;
         procedure SetObjPenWidth(hobj:integer; v:integer);
         function GetObjBrushColor(hobj:integer):TColor;
         procedure SetObjBrushColor(hobj:integer; v:TColor);
         function GetObjBrushStyle(hobj:integer):TBrushStyle;
         procedure SetObjBrushStyle(hobj:integer; v:TBrushStyle);
         function GetObjBoxHighLight(hobj:integer):boolean;
         procedure SetObjBoxHighLight(hobj:integer; v:boolean);
         function GetObjBitmap(hobj:integer):TIEBitmap;
         procedure SetObjBitmap(hobj:integer; v:TIEBitmap);
         function GetObjBitmapAlpha(hobj:integer):TIEBitmap;
         procedure SetObjBitmapAlpha(hobj:integer; v:TIEBitmap);
         function GetSelObjects(idx:integer):integer;
         procedure SetObjBeginShape(hobj:integer; v:TIEShape);
         function GetObjBeginShape(hobj:integer):TIEShape;
         procedure SetObjEndShape(hobj:integer; v:TIEShape);
         function GetObjEndShape(hobj:integer):TIEShape;
         procedure SetObjLabelPos(hobj:integer; v:TIELabelPos);
         function GetObjLabelPos(hobj:integer):TIELabelPos;
         procedure SetObjShapeWidth(hobj:integer; v:integer);
         function GetObjShapeWidth(hobj:integer):integer;
         procedure SetObjShapeHeight(hobj:integer; v:integer);
         function GetObjShapeHeight(hobj:integer):integer;
         procedure SetObjText(hobj:integer; v:AnsiString);
         function GetObjText(hobj:integer):AnsiString;
         procedure SetObjName(hobj:integer; v:AnsiString);
         function GetObjName(hobj:integer):AnsiString;
         procedure SetObjFontAngle(hobj:integer; v:double);
         function GetObjFontAngle(hobj:integer):double;
         function GetObjFontHeight(hobj:integer):integer;
         procedure SetObjFontHeight(hobj:integer; v:integer);
			function GetObjFontName(hobj:integer):AnsiString;
         procedure SetObjFontName(hobj:integer; v:AnsiString);
         function GetObjFontStyles(hobj:integer):TFontStyles;
         procedure SetObjFontStyles(hobj:integer; v:TFontStyles);
         procedure SetObjTextAlign(hobj:integer; v:TIEAlignment);
         function GetObjTextAlign(hobj:integer):TIEAlignment;
         procedure SetObjTextAutoSize(hobj:integer; v:boolean);
         function GetObjTextAutoSize(hobj:integer):boolean;
			procedure SetObjTextCurveCharRot(hobj:integer; v:double);
         function GetObjTextCurveCharRot(hobj:integer):double;
         procedure SetObjMemoLineSpace(hobj:integer; v:integer);
         function GetObjMemoLineSpace(hobj:integer):integer;
         procedure SetObjLeft(hobj:integer; v:integer);
         function GetObjLeft(hobj:integer):integer;
         procedure SetObjTop(hobj:integer; v:integer);
         function GetObjTop(hobj:integer):integer;
         procedure SetObjWidth(hobj:integer; v:integer);
         function GetObjWidth(hobj:integer):integer;
         procedure SetObjHeight(hobj:integer; v:integer);
         function GetObjHeight(hobj:integer):integer;
         procedure SetObjRulerUnit(hobj:integer; v:TIEUnits);
         function GetObjRulerUnit(hobj:integer):TIEUnits;
         procedure SetObjRulerType(hobj:integer; v:TIEVRulerType);
         function GetObjRulerType(hobj:integer):TIEVRulerType;
         procedure SetObjTransparency(hobj:integer; v:integer);
         function GetObjTransparency(hobj:integer):integer;
         procedure SetObjID(hobj:integer; v:integer);
         function GetObjID(hobj:integer):integer;
         procedure SetObjStyle(hobj:integer; v:TIEVStyle);
         function GetObjStyle(hobj:integer):TIEVStyle;
         procedure SetZoomObjectsWidth(Value:boolean);
         function GetObjectsExtents:TRect;
         function GetObjPolylinePoints(hobj,index:integer):TPoint;
         function GetObjPolylinePointsCount(hobj:integer):integer;
         function GetObjPolylineClosed(hobj:integer):boolean;
         procedure SetObjPolylineClosed(hobj:integer; Value:boolean);
         function GetObjSoftShadow(hobj:integer):TIEVSoftShadow;
         procedure DrawGrip(destcanvas:TCanvas; x,y:integer; ty:integer);
         function InGrip(xg,yg,xp,yp:integer):boolean;
         function GetObjLabelBrushColor(hobj:integer):TColor;
         procedure SetObjLabelBrushColor(hobj:integer; v:TColor);
         function GetObjLabelBrushStyle(hobj:integer):TBrushStyle;
         procedure SetObjLabelBrushStyle(hobj:integer; v:TBrushStyle);
         function GetObjFontLocked(hobj:integer):boolean;
         procedure SetObjFontLocked(hobj:integer; value:boolean);
         function GetObjMemoBorderColor(hobj:integer):TColor;
         procedure SetObjMemoBorderColor(hobj:integer; value:TColor);
         function GetObjMemoBorderStyle(hobj:integer):TPenStyle;
         procedure SetObjMemoBorderStyle(hobj:integer; value:TPenStyle);
         procedure SetObjMemoFixedHeight(hobj:integer; value:integer);
         function GetObjMemoFixedHeight(hobj:integer):integer;
         //
         function GetBitmap(idx:integer):TIEBitmap;
         function GetBitmapAlpha(idx:integer):TIEBitmap;
         procedure FreeBitmap(idx:integer);
         function AllocBitmap:integer;
         procedure PackBMP;
         function FindBitmap(SBitmap:TIEBitmap):integer;
         procedure SetObjBitmapNU(hobj:integer; v:TIEBitmap);
         procedure SetObjBitmapIdxNU(hobj:integer; idx:integer);
         procedure SetBitmapResampleFilter(v:TResampleFilter);
			//
         function GetObjCanUndo:boolean;
         function GetObjUndoCount:integer;
         procedure SetObjAntialias(value:boolean);
         procedure MouseSelect(Shift:TShiftState; x,y:integer);
      protected
	      fVStable:integer;
         procedure VPaintTo(BBitmap:TBitmap);
      	procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
	      procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
	      procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
			procedure SetMouseInteract(v:TIEMouseInteract); override;
         procedure SetMouseInteractVt(v:TIEMouseInteractVt);
         function GetMouseInteract:TIEMouseInteractVt;
         procedure SetMUnit(v:TIEUnits);
         procedure SetScale(v:double);
         procedure SetFloatDigits(v:integer);
         procedure SetFloatPrecision(v:integer);
         procedure UpdateHint(x,y:integer);
         procedure ViewChange(c:integer); override;
         procedure SubMouseMoveScroll(scx,scy:integer); override;
         function GetObjPos(hobj:integer):integer;
         procedure ReInsertVObject(hobj:integer; pos:integer);
         procedure KeyDown(var Key: Word; Shift: TShiftState); override;
         procedure WMSize(var Message: TWMSize); message WM_SIZE;
         procedure DoVectorialChanged; virtual;
         procedure UpdateTextEdit; virtual;
         procedure DrawBitmapObject(BBitmap:TBitmap; aobj:TIEVObject; x1,y1,x2,y2:integer; DrawOnTIEBitmap:TIEBitmap);
         procedure DoObjectMoveResize(hobj:integer; Grip:integer; var OffsetX,OffsetY:integer);
         procedure DoObjectClick(hobj:integer);
         procedure DoObjectDblClick(hobj:integer);
         procedure DoObjectOver(hobj:integer);
         procedure AddPolyLinePoint(hobj:integer; X,Y:integer);
         function CountAnglePoints(AnglePoints:array of TPoint):integer;
         function AdjustCoords(const aobj:TIEVObject; var x1,y1,x2,y2,x3,y3:integer; zz:double):integer;
         procedure SetObjGraphicRender(Value:boolean); virtual;
         function VXBmp2Scr(x:integer; UseZoom:boolean; mul:integer):integer;
         function VYBmp2Scr(y:integer; UseZoom:boolean; mul:integer):integer;
         procedure DoBeforeVectorialChange; virtual;
         procedure DrawPolylinePoints(Canvas:TCanvas);
         function FindPolylinePoint(x,y:integer):integer;
         procedure RecalcPolylineBox(Obj:PIEVObject);
      public
      	constructor Create(Owner: TComponent); override;
			destructor Destroy; override;
			procedure Paint; override;
         procedure PaintToEx(ABitmap:TBitmap; ABitmapScanline:ppointerarray; UpdRect:PRect); override;
			procedure Assign(Source: TPersistent); override;
         procedure Update; override;
         property MouseInteractVt:TIEMouseInteractVt read GetMouseInteract write SetMouseInteractVt default [];
         procedure SetDPIX(dpiX:integer); override;
         procedure SetDPIY(dpiY:integer); override;
         property ObjGraphicRender:boolean read fObjGraphicRender write SetObjGraphicRender;
         property UseCentralGrip:boolean read fUseCentralGrip write fUseCentralGrip;
         property GripSize:integer read fGripSize write fGripSize;
         property GripPen:TPen read fGripPen;
         property GripBrush:TBrush read fGripBrush;
         // Measure
         function GetSelectionArea:double;
         function GetSelectionLen:double;
         function GetSelectionCentroid:TPoint;
         function GetPolylineLen(hobj:integer):double;
         function GetPolylineArea(hobj:integer):double;
         function GetPolylineCentroid(hobj:integer):TPoint;
         property MeasureTrack:boolean read fMeasureTrack write fMeasureTrack default true;
         procedure SetScaleFromPixels(px:integer; mm:double);
			property ScaleFactor:double read fScale write SetScale;
         procedure SetScaleFromSelectionLen(mm:double);
         property MeasureCoefX:double read fCoefX;
         property MeasureCoefY:double read fCoefY;
         function GetObjDiagLen(hobj:integer):double;
         //
         procedure AddSelPoint(x,y:integer); override;
         {$ifdef IESUPPORTDEFPARAMS}
         procedure Select(x1,y1,x2,y2:integer; Op:TIESelOp=iespReplace); override;
         {$else}
         procedure Select(x1,y1,x2,y2:integer; Op:TIESelOp); override;
			{$endif}
         procedure CancelInteracts;
         // objects
         property ObjectsCount:integer read fObjCount;
         property ObjectsExtents:TRect read GetObjectsExtents;
         property ObjKind[hobj:integer]:TIEVObjectKind read GetObjKind write SetObjKind;
         property ObjPenColor[hobj:integer]:TColor read GetObjPenColor write SetObjPenColor;
         property ObjPenStyle[hobj:integer]:TPenStyle read GetObjPenStyle write SetObjPenStyle;
			property ObjPenWidth[hobj:integer]:integer read GetObjPenWidth write SetObjPenWidth;
         property ObjBrushColor[hobj:integer]:TColor read GetObjBrushColor write SetObjBrushColor;
			property ObjBrushStyle[hobj:integer]:TBrushStyle read GetObjBrushStyle write SetObjBrushStyle;
         property ObjBoxHighlight[hobj:integer]:boolean read GetObjBoxHighlight write SetObjBoxHighlight;
         property ObjLabelBrushColor[hobj:integer]:TColor read GetObjLabelBrushColor write SetObjLabelBrushColor;
			property ObjLabelBrushStyle[hobj:integer]:TBrushStyle read GetObjLabelBrushStyle write SetObjLabelBrushStyle;
		   property ObjBitmap[hobj:integer]:TIEBitmap read GetObjBitmap write SetObjBitmap;
         property ObjBitmapAlpha[hobj:integer]:TIEBitmap read GetObjBitmapAlpha write SetObjBitmapAlpha;
         property ObjBeginShape[hobj:integer]:TIEShape read GetObjBeginShape write SetObjBeginShape;
			property ObjEndShape[hobj:integer]:TIEShape read GetObjEndShape write SetObjEndShape;
         property ObjShapeWidth[hobj:integer]:integer read GetObjShapeWidth write SetObjShapeWidth;
			property ObjShapeHeight[hobj:integer]:integer read GetObjShapeHeight write SetObjShapeHeight;
         property ObjLabelPosition[hobj:integer]:TIELabelPos read GetObjLabelPos write SetObjLabelPos;
         property ObjText[hobj:integer]:AnsiString read GetObjText write SetObjText;
         property ObjTextAutoSize[hobj:integer]:boolean read GetObjTextAutoSize write SetObjTextAutoSize;
         property ObjTextCurveCharRot[hobj:integer]:double read GetObjTextCurveCharRot write SetObjTextCurveCharRot;
         property ObjMemoLineSpace[hobj:integer]:integer read GetObjMemoLineSpace write SetObjMemoLineSpace;
         property ObjFontAngle[hobj:integer]:double read GetObjFontAngle write SetObjFontAngle;
         property ObjFontHeight[hobj:integer]:integer read GetObjFontHeight write SetObjFontHeight;
			property ObjFontName[hobj:integer]:AnsiString read GetObjFontName write SetObjFontName;
         property ObjFontStyles[hobj:integer]:TFontStyles read GetObjFontStyles write SetObjFontStyles;
			property ObjTextAlign[hobj:integer]:TIEAlignment read GetObjTextAlign write SetObjTextAlign;
         property ObjLeft[hobj:integer]:integer read GetObjLeft write SetObjLeft;
         property ObjTop[hobj:integer]:integer read GetObjTop write SetObjTop;
         property ObjWidth[hobj:integer]:integer read GetObjWidth write SetObjWidth;
         property ObjHeight[hobj:integer]:integer read GetObjHeight write SetObjHeight;
         property ObjName[hobj:integer]:AnsiString read GetObjName write SetObjName;
         property ObjID[hobj:integer]:integer read GetObjID write SetObjID;
         property ObjStyle[hobj:integer]:TIEVStyle read GetObjStyle write SetObjStyle;
         property ObjRulerUnit[hobj:integer]:TIEUnits read GetObjRulerUnit write SetObjRulerUnit;
         property ObjRulerType[hobj:integer]:TIEVRulerType read GetObjRulerType write SetObjRulerType;
         property ObjTransparency[hobj:integer]:integer read GetObjTransparency write SetObjTransparency;
         property ObjPolylinePoints[hobj:integer; index:integer]:TPoint read GetObjPolylinePoints;
         property ObjPolylinePointsCount[hobj:integer]:integer read GetObjPolylinePointsCount;
         property ObjPolylineClosed[hobj:integer]:boolean read GetObjPolylineClosed write SetObjPolylineClosed;
         property ObjSoftShadow[hobj:integer]:TIEVSoftShadow read GetObjSoftShadow;
         property ObjFontLocked[hobj:integer]:boolean read GetObjFontLocked write SetObjFontLocked;
         property ObjMemoBorderColor[hobj:integer]:TColor read GetObjMemoBorderColor write SetObjMemoBorderColor;
         property ObjMemoBorderStyle[hobj:integer]:TPenStyle read GetObjMemoBorderStyle write SetObjMemoBorderStyle;
         property ObjMemoFixedHeight[hobj:integer]:integer read GetObjMemoFixedHeight write SetObjMemoFixedHeight;
         procedure ObjSetTBitmap(hobj:integer; bmp:TBitmap);
         function GetAngleValue(hobj:integer):double;
         procedure SetObjPolylinePoints(hobj:integer; Points:array of TPoint);
         procedure GetObjRect(hobj:integer; var Rect:TRect);
         procedure SetObjRect(hobj:integer; const Rect:TRect);
			property AllObjectsHidden: boolean read fAllObjectsHidden write SetAllObjectsHidden;
         procedure SetObjFont(hobj:integer; v:TFont);
         procedure SetObjBitmapICO(hobj:integer; ico:integer; iwidth,iheight:integer);
         function SetObjBitmapFromFile(hobj:integer; const FileName:AnsiString):boolean;
         procedure SetObjFrontOf(hobj:integer; refobj:integer);
         procedure SetObjBackTo(hobj:integer; refobj:integer);
         function IsSelObject(hobj:integer):boolean;
         procedure UnSelObject(hobj:integer);
         procedure AddSelObject(hobj:integer);
         procedure UnSelAllObjects;
         procedure SelAllObjects;
         property MaxSelectionDistance:integer read fMaxSelectionDistance write fMaxSelectionDistance;
         procedure RemoveAllObjects;
         procedure RemoveObject(hobj:integer);
         function AddNewObject:integer;
         property SelObjects[idx:integer]:integer read GetSelObjects;
         property SelObjectsCount:integer read fSelObjCount;
         function GetObjFromName(const oName:AnsiString):integer;
			function GetObjFromID(oID:integer):integer;
         function GetObjFromIndex(idx:integer):integer;
         procedure CopyObjectTo(hobj:integer; Dest:TImageEnVect);
         procedure CopyAllObjectsTo(Dest:TImageEnVect);
         procedure CopySelectedObjectsTo(Dest:TImageEnVect);
         function FindObjectAt(x,y:integer; var Distance:double):integer;
         function CreatePolygonFromEdge(x,y:integer; maxfilter:boolean; tolerance:integer):integer;
			procedure SetObjTextCurve(hobj:integer; x,y:double);
         procedure SetObjTextCurveShape(hobj:integer; shape:TIECurve; phase:integer; dforward:boolean);
         procedure SetObjTextCurveFromPolyline(hobj:integer; source:integer);
         {$ifdef IESUPPORTDEFPARAMS}
         function CreateImageFromSelectedArea(feather: integer=0; smooth: boolean=false): integer;
         procedure CopyObjectsToBack(Antialias:boolean=false);
         {$else}
         function CreateImageFromSelectedArea(feather: integer; smooth: boolean): integer;
         procedure CopyObjectsToBack(Antialias:boolean);
         {$endif}
         procedure DrawObjectsToBitmap(target:TIEBitmap; Antialias:boolean);
         function RemovePolygonJaggedEdges(hobj:integer):boolean;
         procedure SimplifyPolygon(hobj:integer; MaxPoints:integer);
         function GetMemoFormattedString(hobj:integer):AnsiString;
         //procedure CalcPolygonMoments(hobj:integer; var Centroid:TPoint; var MajorAxis,MinorAxis:TRect; var m00,m10,m01,m11,m20,m02:double; var mu00,mu11,mu20,mu02:double; var rad_gyr:double; var phi_1,phi_2:double; var tg_th1,tg_th2:double; var BoundingQuad:array of TPoint);
         property ObjDrawed:integer read fObjDrawed;
         function IsEditMode:boolean;
			// measure hint
         property MeasureHintFont:TFont read fMeasureHintFont;
         property MeasureHintBrush:TBrush read fMeasureHintBrush;
         property MeasureHintBorder1:TColor read fMeasureHintBorder1 write fMeasureHintBorder1;
         property MeasureHintBorder2:TColor read fMeasureHintBorder2 write fMeasureHintBorder2;
         // I/O
         procedure SaveToFileIEV(const nf:AnsiString);
         procedure SaveToStreamIEV(Stream:TStream);
         function LoadFromFileIEV(const nf:AnsiString):boolean;
         function LoadFromStreamIEV(Stream:TStream):boolean;
			function ImportDXF(const nf:AnsiString):boolean;
         // Cut/Copy/Paste
         procedure ObjCopyToClipboard;
         procedure ObjCutToClipboard;
         procedure ObjPasteFromClipboard(OffsetX,OffsetY:integer);
         // Undo
         procedure ObjSaveUndo;
         procedure ObjClearUndo;
         procedure ObjClearAllUndo;
         property ObjCanUndo:boolean read GetObjCanUndo;
         property ObjUndoCount:integer read GetObjUndoCount;
         procedure ObjUndoAt(Position:integer);
         procedure ObjUndo;
      published
         property MUnit:TIEUnits read fMUnit write SetMUnit default ieuPIXELS;
         property FloatDigits:integer read fFloatDigits write SetFloatDigits default 2;
         property FloatPrecision:integer read fFloatPrecision write SetFloatPrecision default 15;
         property ShareBitmaps:boolean read fShareBitmaps write fShareBitmaps default true;
         property OnSelectObject:TNotifyEvent read fOnSelectObject write fOnSelectObject;
         property OnMeasureHint:TIEVMeasureHintEvent read fOnMeasureHint write fOnMeasureHint;
         property ZoomObjectsWidth:boolean read fZoomObjectsWidth write SetZoomObjectsWidth default true;
			property OnVectorialChanged:TNotifyEvent read fOnVectorialChanged write fOnVectorialChanged;
         property OnBeforeVectorialChanged:TNotifyEvent read fOnBeforeVectorialChanged write fOnBeforeVectorialChanged;
         property OnDragLenEnd:TIEVDragLenEndEvent read fOnDragLenEnd write fOnDragLenEnd;
         property OnNewObject:TIEVNewObject read fOnNewObject write fOnNewObject;
         property BitmapResampleFilter:TResampleFilter read fBitmapResampleFilter write SetBitmapResampleFilter default rfNone;
         property OnObjectMoveResize:TIEVObjectMoveResizeEvent read fOnObjectMoveResize write fOnObjectMoveResize;
         property OnObjectClick:TIEVObjectClickEvent read fOnObjectClick write fOnObjectClick;
         property OnObjectDblClick:TIEVObjectClickEvent read fOnObjectDblClick write fOnObjectDblClick;
         property OnObjectOver:TIEVObjectClickEvent read fOnObjectOver write fOnObjectOver;
         property ObjUndoLimit:integer read fObjUndoLimit write fObjUndoLimit default 1;
         property ObjAutoUndo:boolean read fObjAutoUndo write fObjAutoUndo default false;
         property ObjAntialias:boolean read fObjAntialias write SetObjAntialias default false;
         property SelectOnMouseDown:boolean read fSelectOnMouseDown write fSelectOnMouseDown default true;
   end;

implementation

uses
ImageEnProc, ImageEnIO, pngfilt, ieview;

{$R-}

const

	ALLOCBLOCK=512; // number of object allocated. High values increases performance, but requires much more memory

	A90=PI/2;

	POLYLINEGDIM=3;


function _DistPoint2Ellipse(x,y,x1,y1,x2,y2:integer):double; forward;

// like moveto/lineto but draw also last point
procedure DrawLine(Canvas:TCanvas; x1,y1,x2,y2:integer);
var
	p2:array [0..1] of TPoint;
begin
   p2[0].x:=x1; p2[0].y:=y1;
   p2[1].x:=x2; p2[1].y:=y2;
	Canvas.Polygon(p2);
end;


// Calc angle (rad) of segment x1,y1-x2,y2 relative to the X axis
function _Angle2(x1,y1,x2,y2:integer):double;
begin
   if (x1<x2) and (y2<y1) then				// 1
      result:=pi-ieangle(x2,y2,x1,y1,x2,y1)
   else if (x1<x2) and (y1<y2) then			// 4
      result:=pi+ieangle(x2,y1,x1,y1,x2,y2)
   else if (x2<x1) and (y1<y2) then			// 3
      result:=2*pi-ieangle(x2,y1,x1,y1,x2,y2)
   else if (x2<x1) and (y2<y1) then			// 2
      result:=ieangle(x2,y1,x1,y1,x2,y2)
   else if (x2=x1) and (y1>y2) then
      result:=pi/2
   else if (x2=x1) and (y1<y2) then
      result:=1.5*pi
   else if (y1=y2) and (x1>x2) then
      result:=pi
   else
      result:=0;
end;

// duplicate PAnsiChar AnsiString
function _StrDup(s:PAnsiChar):PAnsiChar;
begin
   if s<>nil then begin
   	getmem(result, strlen(s)+1 );
      StrCopy(result,s);
   end else
      result:=nil;
end;

constructor TImageEnVect.Create(Owner: TComponent);
begin
   fTextEditing:=-1;	// no iekTEXT/iekMEMO in editing
   fTextEdit:=TEdit.Create(self);
   fTextEdit.Visible:=false;
   fMemoEdit:=TIETextControl.Create(self);
   fMemoEdit.Visible:=false;
	inherited;
   fCacheBitmap:=nil;
   fObjGraphicRender:=false;
   fOnDragLenEnd:=nil;
   fOnVectorialChanged:=nil;
   fOnBeforeVectorialChanged:=nil;
   fZoomObjectsWidth:=true;
	fAllObjectsHidden:=false;
   fBitmaps:=nil;
   fBitmapsCount:=0;
   fObjCount:=0;
   fShareBitmaps:=True;
   fObjHeap:=nil;
   fObjHeapCount:=0;
   getmem(fSelObj,0);
   fSelObjCount:=0;
   fScale:=1;
   fMouseInteractVt:=[];
   fMUnit:=ieuPIXELS;
   fFloatDigits:=2;
   fFloatPrecision:=15;
   fMeasureTrack:=true;
   CalcCoef(fCoefX,fCoefY,fMUnit);
   // new object initial values
	with fNewObj do begin
   	x1:=0;
      y1:=0;
      x2:=DEFWIDTH-1;
      y2:=DEFHEIGHT-1;
      a1:=0;
      a2:=2*pi;
   	PenColor:=clWhite;
	   PenStyle:=psSolid;
	   PenWidth:=1;
   	BrushColor:=clWhite;
   	BrushStyle:=bsClear;
      BoxHighLight:=false;
   	LabelBrushColor:=clWhite;
   	LabelBrushStyle:=bsSolid;
      BeginShape:=iesNONE;
      EndShape:=iesNONE;
      ShapeWidth:=10;
      ShapeHeight:=20;
      LabelPosition:=ielEnd;
      BitmapIdx:=-1;
	   SetObjBitmapICO(-1,OIC_HAND,DEFWIDTH,DEFHEIGHT);
      LogFont:=nil;
      TextFormatRef:=nil;
      TextFormat:=nil;
      CurvedPos:=nil;
      CurvedLen:=0;
      Canvas.Font.Name:='Arial';
      SetObjFont(-1,Canvas.Font);
      Text:=nil;
		Name:=nil;
      ID:=0;
      TextAlign:=iejLeft;
      TextAutoSize:=false;
      LineSpace:=0;
      MemoBorderColor:=clWhite;
      MemoBorderStyle:=psSolid;
      MemoFixedHeight:=0;
      CurvedCharRot:=-1;
      FontLocked:=true;
      Style:=[ievsSelectable, ievsMoveable, ievsSizeable, ievsVisible];
      RulerUnit:=fMUnit;
      RulerType:=iertQUOTECENTER;
      PolyPoints:=nil;
      PolyPointsCount:=0;
      PolyBaseX1:=0;
      PolyBaseY1:=0;
      PolyBaseX2:=0;
      PolyBaseY2:=0;
      PolyClosed:=false;
		DrawnPoints:=nil;
      DrawnPointsCount:=0;
		AnglePoints[0]:=Point(0,0);
		AnglePoints[0]:=Point(50,0);
      AnglePoints[0]:=Point(50,50);
      Transparency:=255;
      softShadow:=TIEVSoftShadow.Create;
      with softShadow do begin
			Enabled:=false;
			Radius:=3;
         OffsetX:=0;
         OffsetY:=0;
      end;
   end;
   //
   fInserting:=iekNONE;
   fGripping:=0;
   fOnSelectObject:=nil;
   fOnMeasureHint:=nil;
   fLastHintValue:=0;
   fOnNewObject:=nil;
   fBitmapResampleFilter:=rfNone;
   fVStable:=0;
   MaxSelectionDistance:=-1;
   fOnObjectMoveResize:=nil;
   fOnObjectClick:=nil;
   fOnObjectDblClick:=nil;
   fOnObjectOver:=nil;
   fHintSaveBitmap:=TBitmap.Create;
   fShowHint:=false;
   fHintX:=0;
   fHintY:=0;
   fMeasureHintFont:=TFont.Create;
   fMeasureHintFont.Color:=clBlack;
	fMeasureHintFont.Style:=[fsBold];
   fMeasureHintBrush:=TBrush.Create;
   fMeasureHintBrush.Color:=$0060FFFF;
   fMeasureHintBrush.Style:=bsSolid;
   fMeasureHintBorder2:=clGray;
   fMeasureHintBorder1:=clWhite;
   fMovX:=0;
   fMovY:=0;
   // grips properties
   fGripSize:=4;
   fGripPen:=TPen.Create;
   fGripPen.Color:=clBlack;
   fGripPen.Style:=psSolid;
   fGripPen.Mode:=pmCopy;
   fGripPen.Width:=1;
   fGripBrush:=TBrush.Create;   
   fGripBrush.Color:=clBlack;
   fGripBrush.Style:=bsSolid;
   //
   fObjUndoList:=TList.Create;
   fObjUndoLimit:=1;
   fMemoWriteFormattedString:=nil;
   fMemoFormattedString:='';
   fUseCentralGrip:=false;
   fVectorialChanging:=false;
   fObjAutoUndo:=false;
   fObjAntialias:=false;
   fCurPolylineGrip:=-1;
   fCurPolylineIntraGrip:=-1;
   fSelectOnMouseDown:=true;
end;

destructor TImageEnVect.Destroy;
var
	q:integer;
begin
	RemoveTextEdit;
   RemoveVObjDataAll;	// free objects data
   RemoveVObjData( fNewObj ); // free new object data
  	freemem(fSelObj);
   freemem(fObjHeap);	// remove heap memory of objects
   // free bitmaps
   for q:=0 to fBitmapsCount-1 do
   	if fBitmaps^[q].fBitmap<>nil then
	   	fBitmaps^[q].fBitmap.free;
   freemem(fBitmaps);
   fHintSaveBitmap.free;
   fMeasureHintFont.free;
   fMeasureHintBrush.free;
   fTextEdit.free;
   fMemoEdit.free;
   if assigned(fCacheBitmap) then
   	fCacheBitmap.free;
   // undo
   ObjClearAllUndo;
   fObjUndoList.free;
   //
   fGripPen.free;
   fGripBrush.free;
   //
	inherited;
end;

// Cancel:
//   fInserting (object inserting)
//   fGripping (coordinate/size changing)
//   fTextEditing (text inserting)
procedure TImageEnVect.CancelInteracts;
begin
   fInserting:=iekNONE;
   fGripping:=0;
   RemoveTextEdit;
   if fTextEditing>=0 then begin
	   fTextEditing:=-1;
      Update;
   end;
end;

// MouseInteract of TImageEnView
procedure TImageEnVect.SetMouseInteract(v:TIEMouseInteract);
begin
  	inherited;
   if v<>[] then
	   fMouseInteractVt:=fMouseInteractVt-[miPutLine,miPutBox,miPutEllipse,
      												miPutBitmap,miPutText,miObjectSelect,
                                          miPutRuler,miDragLen,miPutPolyLine,
                                          miPutAngle,miPutMemo,miPutLineLabel,miEditPolyLine
                                          ];
	CancelInteracts;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetMouseInteractVt(v:TIEMouseInteractVt);
var
	ToUpdate:boolean;
begin
	ToUpdate:=false;
	CancelInteracts;
	if v<>fMouseInteractVt then begin
   	if miEditPolyLine in fMouseInteractVt then
      	ToUpdate:=true;

      if (miArea in v) and not (miArea in fMouseInteractVt) then begin
      	// miArea
      	v:=[miArea];
      end else if (miLineLen in v) and not (miLineLen in fMouseInteractVt) then begin
      	// miLineLen
      	v:=[miLineLen];
      end else if (miPutLine in v) and not (miPutLine in fMouseInteractVt) then begin
			// miPutLine
         v:=[miPutLine];
         SetMouseInteract([]);
      end else if (miPutLineLabel in v) and not (miPutLineLabel in fMouseInteractVt) then begin
			// miPutLineLabel
         v:=[miPutLineLabel];
         SetMouseInteract([]);
      end else if (miPutBox in v) and not (miPutBox in fMouseInteractVt) then begin
			// miPutBox
         v:=[miPutBox];
         SetMouseInteract([]);
      end else if (miPutEllipse in v) and not (miPutEllipse in fMouseInteractVt) then begin
			// miPutEllipse
         v:=[miPutEllipse];
         SetMouseInteract([]);
      end else if (miPutBitmap in v) and not (miPutBitmap in fMouseInteractVt) then begin
			// miPutBitmap
         v:=[miPutBitmap];
         SetMouseInteract([]);
      end else if (miPutText in v) and not (miPutText in fMouseInteractVt) then begin
			// miPutText
         v:=[miPutText];
         SetMouseInteract([]);
      end else if (miPutMemo in v) and not (miPutMemo in fMouseInteractVt) then begin
			// miPutMemo
         v:=[miPutMemo];
         SetMouseInteract([]);
      end else if (miObjectSelect in v) and not (miObjectSelect in fMouseInteractVt) then begin
			// miSelectObject
         v:=[miObjectSelect];
         SetMouseInteract([]);
      end else if (miDragLen in v) and not (miDragLen in fMouseInteractVt) then begin
         // miDragLen - measure distance by dragging a temporary line
         v:=[miDragLen];
         SetMouseInteract([]);
      end else if (miPutRuler in v) and not (miPutRuler in fMouseInteractVt) then begin
			// miPutRuler
         v:=[miPutRuler];
         SetMouseInteract([]);
		end else if (miPutPolyLine in v) and not (miPutPolyLine in fMouseInteractVt) then begin
      	// miPutPolyLine
         v:=[miPutPolyLine];
         SetMouseInteract([]);
      end else if (miPutAngle in v) and not (miPutAngle in fMouseInteractVt) then begin
      	// miPutAngle
         v:=[miPutAngle];
         SetMouseInteract([]);
      end else if (miEditPolyLine in v) and not (miEditPolyLine in fMouseInteractVt) then begin
      	// miEditPolyLine
         v:=[miEditPolyLine];
         SetMouseInteract([]);
         ToUpdate:=true;
      end;
      fMouseInteractVt:=v;
      if (not (miArea in v)) and (not (miLineLen in v)) then begin
			HintRestore;
         fShowHint:=false;
         fLastHintValue:=0;
      end else begin
      	fLastHintValue:=0;
         HintRestore;
         fShowHint:=True;
         HintShow(width div 2, height div 2);
		end;
   end;
   if ToUpdate then
   	Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetDPIX(dpiX:integer);
begin
	inherited;
   CalcCoef(fCoefX,fCoefY,fMUnit);
   UpdateHint(-1000000,-1000000);
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetDPIY(dpiY:integer);
begin
	inherited;
   CalcCoef(fCoefX,fCoefY,fMUnit);
   UpdateHint(-1000000,-1000000);
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetMUnit(v:TIEUnits);
begin
	fNewObj.RulerUnit:=v;
	fMUnit:=v;
   CalcCoef(fCoefX,fCoefY,fMUnit);
   UpdateHint(-1000000,-1000000);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetFloatDigits(v:integer);
begin
	fFloatDigits:=v;
	UpdateHint(-1000000,-1000000);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetFloatPrecision(v:integer);
begin
	fFloatPrecision:=v;
   UpdateHint(-1000000,-1000000);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Ricalcola fCoefX e fCoefY
// fCoef? rappresenta a quanti fMUnit corrisponde ogni pixel
procedure TImageEnVect.CalcCoef(var cx,cy:double; mu:TIEUnits);
begin
	if mu=ieuPIXELS then begin
   	cx:=1;
      cy:=1;
   end else begin
		cx:=1/fDPIX;
      cy:=1/fDPIY;
	   case mu of
      	ieuKM: 			 begin cx:=(cx*2.54)/100000; 	cy:=(cy*2.54)/100000; end;
	      ieuMETERS: 		 begin cx:=(cx*2.54)/100; 		cy:=(cy*2.54)/100; end;
	      ieuCENTIMETERS: begin cx:=cx*2.54; 				cy:=cy*2.54; end;
	      ieuMILLIMETERS: begin cx:=(cx*2.54)*10; 		cy:=(cy*2.54)*10; end;
         ieuMICRONS: begin cx := (cx * 2.54) * 10000; cy := (cy * 2.54) * 10000; end;
			ieuNANOMETERS: begin cx:=(cx*2.54) * 10000000; cy:=(cy*2.54) * 10000000; end;
      end;
	end;
   cx:=cx*fScale;
   cy:=cy*fScale;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.AddSelPoint(x,y:integer);
begin
	inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.Select(x1,y1,x2,y2:integer; Op:TIESelOp);
begin
	inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Calcola il perimetro della selezione corrente
// Nota: Se fPolySelecting è vero (selezione poligono in corso), il calcolo del
// perimetro non include il segmento di raccordo tra l'ultimo punto inserito e quello
// iniziale. Se invece fPRectSelecting è vero viene calcolato il perimetro di tutto il rect.
function TImageEnVect.GetSelectionLen:double;
var
	i:integer;
   dx,dy:double;
   lx,ly:double;
   lbreak:integer;
begin
	dx:=fCoefX;
   dy:=fCoefY;
   result:=0;
   with fHPolySel^ do begin
   	if PolyCount>1 then begin
      	lbreak:=0;
      	i:=0;
         while i<PolyCount-1 do begin
         	if Poly^[i+1].x=IESELBREAK then begin
               lx:=abs(Poly^[lbreak].x-Poly^[i].x)*dx;
               ly:=abs(Poly^[lbreak].y-Poly^[i].y)*dy;
               result:=result+ sqrt( lx*lx+ly*ly );
               inc(i);
               lbreak:=i+1;
            end else begin
               lx:=abs(Poly^[i+1].x-Poly^[i].x)*dx;
               ly:=abs(Poly^[i+1].y-Poly^[i].y)*dy;
               result:=result+ sqrt( lx*lx+ly*ly );
            end;
            inc(i);
         end;
         if (not fPolyselecting) and (PolyCount>2) then begin
         	// include segmento finale (fine misurazione)
         	lx:=abs(Poly^[lbreak].x-Poly^[PolyCount-1].x)*dx;
            ly:=abs(Poly^[lbreak].y-Poly^[PolyCount-1].y)*dy;
         	result:=result+ sqrt( lx*lx+ly*ly );
         end
      end;
      if fMeasureTrack and (PolyCount>0) and fPolySelecting then begin
        // fMMoveX e fMMoveY sono le coordinate correnti del mouse
        lx:=abs(XScr2Bmp(fMMoveX)-Poly^[PolyCount-1].x)*dx;
        ly:=abs(YScr2Bmp(fMMoveY)-Poly^[PolyCount-1].y)*dy;
        result:=result+ sqrt( lx*lx+ly*ly );
     end;
   end;
end;

// draws ruler on inserting
procedure TImageEnVect.DrawRulerInserting;
begin
   DrawRuler(Canvas,fHSX1,fHSY1,fVMoveX,fVMoveY,fNewObj.RulerUnit,fNewObj.PenColor,fNewObj.PenWidth,fNewObj.RulerType,f100DZoom,fNewObj.plim,fNewObj.LogFont);
end;

procedure TImageEnVect.DrawAngleInserting;
var
	tmp_points:array [0..2] of TPoint;
   i:integer;
begin
	with GetObj(fInsertingAngleObject)^ do begin
   	move(AnglePoints[0],tmp_points[0],sizeof(TPoint)*3);
		for i:=0 to 2 do
   		if AnglePoints[i].x=-1000000 then begin
         	tmp_points[i]:=Point(XScr2Bmp(fVMoveX),YScr2Bmp(fVMoveY));
            break;
         end;
		DrawAngle(Canvas,tmp_points,PenColor,PenWidth,plim,true,1,100/fZoom);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Disegna una linea durante il suo inserimento
procedure TImageEnVect.DrawLineInserting;
begin
	with canvas do begin
   	pen.Mode:=pmNot;
   	pen.width:=1;
   	pen.style:=psSolid;
   	moveto(fHSX1,fHSY1);
   	lineto(fVMoveX,fVMoveY);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Disegna un box durante il suo inserimento
procedure TImageEnVect.DrawBoxInserting;
begin
	with canvas do begin
      pen.Mode:=pmNot;
      pen.width:=1;
      pen.style:=psSolid;
      moveto(fHSX1,fHSY1);
      lineto(fVMoveX,fHSY1);
      lineto(fVMoveX,fVMoveY);
      lineto(fHSX1,fVMoveY);
      lineto(fHSX1,fHSY1);
	end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Disegna un'ellisse durante il suo inserimento
procedure TImageEnVect.DrawEllipseInserting;
var
	x1,y1,x2,y2:integer;
begin
	with canvas do begin
      pen.Mode:=pmNot;
      pen.width:=1;
      pen.style:=psSolid;
      brush.style:=bsClear;
      x1:=fHSX1; y1:=fHSY1; x2:=fVMoveX; y2:=fVMoveY;
      OrdCor(x1,y1,x2,y2);
      Ellipse(x1,y1,x2+1,y2+1);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
function TImageEnVect.GetObjKind(hobj:integer):TIEVObjectKind;
begin
	with GetObj(hobj)^ do
		result:=Kind;
end;


/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
procedure TImageEnVect.SetObjKind(hobj:integer; v:TIEVObjectKind);
var
	pobj:PIEVObject;
   //
   procedure AllocLogFont;
   begin
      with pobj^ do
         if LogFont=nil then begin
            getmem(LogFont,sizeof(TLogFont));
            copymemory(LogFont,fNewObj.LogFont,sizeof(TLogFont));
         end;
   end;
	//
begin
	pobj:=GetObj(hobj);
	with pobj^ do begin
   	Kind:=v;
      case Kind of
      	iekTEXT, iekLINELABEL:
         	begin
               AllocLogFont;
               if Text=nil then
                  Text:=_StrDup('');
            end;
         iekMEMO, iekRULER:
         	AllocLogFont;
      end;
   end;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
function TImageEnVect.GetObjPenColor(hobj:integer):TColor;
begin
	with GetObj(hobj)^ do
   	result:=PenColor;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
procedure TImageEnVect.SetObjPenColor(hobj:integer; v:TColor);
begin
	with GetObj(hobj)^ do
   	PenColor:=v;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
function TImageEnVect.GetObjStyle(hobj:integer):TIEVStyle;
begin
	with GetObj(hobj)^ do
   	result:=Style;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
procedure TImageEnVect.SetObjStyle(hobj:integer; v:TIEVStyle);
begin
	if not (ievsSelectable in v) then
		UnSelObject(hobj);
	with GetObj(hobj)^ do
   	Style:=v;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.GetObjRect(hobj:integer; var Rect:TRect);
begin
	with GetObj(hobj)^ do begin
		Rect.Left:=x1;
      Rect.Top:=y1;
      Rect.Right:=x2;
      Rect.Bottom:=y2;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetObjRect(hobj:integer; const Rect:TRect);
begin
	with GetObj(hobj)^ do begin
   	x1:=Rect.Left;
      y1:=Rect.Top;
      x2:=Rect.Right;
      y2:=Rect.Bottom;
   end;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
procedure TImageEnVect.SetObjLeft(hobj:integer; v:integer);
begin
	with GetObj(hobj)^ do begin
      inc(x2, v-x1 );
   	inc(x1, v-x1 );
   end;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
function TImageEnVect.GetObjLeft(hobj:integer):integer;
begin
	with GetObj(hobj)^ do
   	result:=x1;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
procedure TImageEnVect.SetObjRulerUnit(hobj:integer; v:TIEUnits);
begin
	with GetObj(hobj)^ do
		RulerUnit:=v;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
function TImageEnVect.GetObjRulerUnit(hobj:integer):TIEUnits;
begin
	with GetObj(hobj)^ do
		result:=RulerUnit;
end;

procedure TImageEnVect.SetObjPolylineClosed(hobj:integer; Value:boolean);
begin
	with GetObj(hobj)^ do
   	PolyClosed:=Value;
   if hobj<>-1 then
   	Update;
end;

function TImageEnVect.GetObjPolylineClosed(hobj:integer):boolean;
begin
	with GetObj(hobj)^ do
   	result:=PolyClosed;
end;

function TImageEnVect.GetObjSoftShadow(hobj:integer):TIEVSoftShadow;
begin
	with GetObj(Hobj)^ do
   	result:=softShadow;
end;

// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
procedure TImageEnVect.SetObjRulerType(hobj:integer; v:TIEVRulerType);
begin
	with GetObj(hobj)^ do
		RulerType:=v;
   if hobj<>-1 then
	   Update;
end;

// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
function TImageEnVect.GetObjRulerType(hobj:integer):TIEVRulerType;
begin
	with GetObj(hobj)^ do
		result:=RulerType;
end;

// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
procedure TImageEnVect.SetObjTransparency(hobj:integer; v:integer);
begin
	with GetObj(hobj)^ do
		Transparency:=v;
   if hobj<>-1 then
	   Update;
end;

// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
function TImageEnVect.GetObjTransparency(hobj:integer):integer;
begin
	with GetObj(hobj)^ do
		result:=Transparency;
end;

function TImageEnVect.GetObjFontLocked(hobj:integer):boolean;
begin
	with GetObj(hobj)^ do
   	result:=FontLocked;
end;

function TImageEnVect.GetObjMemoBorderColor(hobj:integer):TColor;
begin
	with GetObj(hobj)^ do
		result:=MemoBorderColor;
end;

procedure TImageEnVect.SetObjMemoBorderColor(hobj:integer; value:TColor);
begin
	with GetObj(hobj)^ do
   	MemoBorderColor:=value;
   if hobj<>-1 then
   	Update;
end;

function TImageEnVect.GetObjMemoBorderStyle(hobj:integer):TPenStyle;
begin
	with GetObj(hobj)^ do
		result:=MemoBorderStyle;
end;

procedure TImageEnVect.SetObjMemoBorderStyle(hobj:integer; value:TPenStyle);
begin
	with GetObj(hobj)^ do
   	MemoBorderStyle:=value;
   if hobj<>-1 then
   	Update;
end;

procedure TImageEnVect.SetObjMemoFixedHeight(hobj:integer; value:integer);
begin
	with GetObj(hobj)^ do
		MemoFixedHeight:=value;
end;

function TImageEnVect.GetObjMemoFixedHeight(hobj:integer):integer;
begin
	with GetObj(hobj)^ do
		result:=MemoFixedHeight;

end;

procedure TImageEnVect.SetObjFontLocked(hobj:integer; value:boolean);
begin
	with GetObj(hobj)^ do
   	FontLocked:=value;
   if hobj<>-1 then
   	Update;
end;

function TImageEnVect.GetObjPolylinePoints(hobj,index:integer):TPoint;
var
	zx,zy:double;
begin
	with GetObj(hobj)^ do
      if index<PolyPointsCount then begin
         CalcZxZyPolyline(GetObj(hobj),zx,zy);
         result.x:=round((PPointArray(PolyPoints)[index].x-PolyBaseX1)*zx)+x1;
         result.y:=round((PPointArray(PolyPoints)[index].y-PolyBaseY1)*zy)+y1;
	   end;
end;

function TImageEnVect.GetObjPolylinePointsCount(hobj:integer):integer;
begin
	with GetObj(hobj)^ do
		result:=PolyPointsCount;
end;

procedure TImageEnVect.SetObjPolylinePoints(hobj:integer; Points:array of TPoint);
var
   i:integer;
begin
	with GetObj(hobj)^ do begin
      if PolyPoints<>nil then
      	freemem(PolyPoints);
      PolyPoints:=nil;
      PolyPointsCount:=0;
      PolyBaseX1:=0;
      PolyBaseY1:=0;
      PolyBaseX2:=0;
      PolyBaseY2:=0;
      x1:=1000000; y1:=1000000;
      x2:=-1000000; y2:=-1000000;
		for i:=0 to High(Points) do
      	AddPolyLinePoint(hobj,Points[i].x,Points[i].y);
      Update;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
procedure TImageEnVect.SetObjTop(hobj:integer; v:integer);
begin
	with GetObj(hobj)^ do begin
      inc(y2, v-y1);
   	inc(y1, v-y1);
   end;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
function TImageEnVect.GetObjTop(hobj:integer):integer;
begin
	with GetObj(hobj)^ do
   	result:=y1;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
procedure TImageEnVect.SetObjWidth(hobj:integer; v:integer);
begin
	with GetObj(hobj)^ do
   	x2:=x1+v-1;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
function TImageEnVect.GetObjWidth(hobj:integer):integer;
begin
	with GetObj(hobj)^ do
   	result:=x2-x1+1;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
procedure TImageEnVect.SetObjHeight(hobj:integer; v:integer);
begin
	with GetObj(hobj)^ do
   	y2:=y1+v-1;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////|
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
function TImageEnVect.GetObjHeight(hobj:integer):integer;
begin
	with GetObj(hobj)^ do
   	result:=y2-y1+1;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetObjID(hobj:integer; v:integer);
begin
	with GetObj(hobj)^ do
   	ID:=v;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVect.GetObjID(hobj:integer):integer;
begin
	with GetObj(hobj)^ do
   	result:=ID;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
function TImageEnVect.GetObjPenStyle(hobj:integer):TPenStyle;
begin
	with GetObj(hobj)^ do
   	result:=PenStyle;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
procedure TImageEnVect.SetObjPenStyle(hobj:integer; v:TPenStyle);
begin
	with GetObj(hobj)^ do
   	PenStyle:=v;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
function TImageEnVect.GetObjPenWidth(hobj:integer):integer;
begin
	with GetObj(hobj)^ do
   	result:=PenWidth;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
procedure TImageEnVect.SetObjPenWidth(hobj:integer; v:integer);
begin
	with GetObj(hobj)^ do
   	PenWidth:=v;
   if hobj<>-1 then
	   Update;
end;

// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
function TImageEnVect.GetObjBrushColor(hobj:integer):TColor;
begin
	with GetObj(hobj)^ do
   	result:=BrushColor;
end;

// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
procedure TImageEnVect.SetObjBrushColor(hobj:integer; v:TColor);
begin
	with GetObj(hobj)^ do
   	BrushColor:=v;
   if hobj<>-1 then
	   Update;
end;

// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
function TImageEnVect.GetObjBrushStyle(hobj:integer):TBrushStyle;
begin
	with GetObj(hobj)^ do
   	result:=BrushStyle;
end;

// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
procedure TImageEnVect.SetObjBrushStyle(hobj:integer; v:TBrushStyle);
begin
	with GetObj(hobj)^ do
   	BrushStyle:=v;
   if hobj<>-1 then
	   Update;
end;

function TImageEnVect.GetObjBoxHighLight(hobj:integer):boolean;
begin
	with GetObj(hobj)^ do
   	result:=BoxHighLight;
end;

procedure TImageEnVect.SetObjBoxHighLight(hobj:integer; v:boolean);
begin
	with GetObj(hobj)^ do
   	BoxHighLight:=v;
   if hobj<>-1 then
	   Update;
end;


// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
function TImageEnVect.GetObjLabelBrushColor(hobj:integer):TColor;
begin
	with GetObj(hobj)^ do
   	result:=LabelBrushColor;
end;

// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
procedure TImageEnVect.SetObjLabelBrushColor(hobj:integer; v:TColor);
begin
	with GetObj(hobj)^ do
   	LabelBrushColor:=v;
   if hobj<>-1 then
	   Update;
end;

// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
function TImageEnVect.GetObjLabelBrushStyle(hobj:integer):TBrushStyle;
begin
	with GetObj(hobj)^ do
   	result:=LabelBrushStyle;
end;

// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
procedure TImageEnVect.SetObjLabelBrushStyle(hobj:integer; v:TBrushStyle);
begin
	with GetObj(hobj)^ do
   	LabelBrushStyle:=v;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
function TImageEnVect.GetObjBitmap(hobj:integer):TIEBitmap;
begin
	with GetObj(hobj)^ do
   	result:=GetBitmap(BitmapIdx);
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
// Questa funzione crea una copia di v
// Se v è nil, annulla precedente assegnazione
procedure TImageEnVect.SetObjBitmap(hobj:integer; v:TIEBitmap);
begin
	SetObjBitmapNU(hobj,v);
   if hobj<>-1 then
	   Update;
end;

procedure TImageEnVect.ObjSetTBitmap(hobj:integer; bmp:TBitmap);
var
	iebmp:TIEBitmap;
begin
	iebmp:=TIEBitmap.Create;
   iebmp.EncapsulateTBitmap(bmp,false);
   SetObjBitmap(hobj,iebmp);
   iebmp.free;
end;

//
function TImageEnVect.GetObjBitmapAlpha(hobj:integer):TIEBitmap;
begin
	with GetObj(hobj)^ do
   	result:=GetBitmapAlpha(BitmapIdx);
end;

//
procedure TImageEnVect.SetObjBitmapAlpha(hobj:integer; v:TIEBitmap);
begin
	with GetObj(hobj)^ do
   	GetBitmapAlpha(BitmapIdx).assign(v);
   if hobj<>-1 then
	   Update;
end;

procedure TImageEnVect.SetObjBeginShape(hobj:integer; v:TIEShape);
begin
	with GetObj(hobj)^ do
   	BeginShape:=v;
   if hobj<>-1 then
	   Update;
end;

function TImageEnVect.GetObjBeginShape(hobj:integer):TIEShape;
begin
	with GetObj(hobj)^ do
   	result:=BeginShape;
end;

procedure TImageEnVect.SetObjLabelPos(hobj:integer; v:TIELabelPos);
begin
	with GetObj(hobj)^ do
   	LabelPosition:=v;
   if hobj<>-1 then
	   Update;
end;

function TImageEnVect.GetObjLabelPos(hobj:integer):TIELabelPos;
begin
	with GetObj(hobj)^ do
   	result:=LabelPosition;
end;


/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetObjEndShape(hobj:integer; v:TIEShape);
begin
	with GetObj(hobj)^ do
   	EndShape:=v;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVect.GetObjEndShape(hobj:integer):TIEShape;
begin
	with GetObj(hobj)^ do
   	result:=EndShape;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetObjShapeWidth(hobj:integer; v:integer);
begin
	with GetObj(hobj)^ do
   	ShapeWidth:=v;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVect.GetObjShapeWidth(hobj:integer):integer;
begin
	with GetObj(hobj)^ do
   	result:=ShapeWidth;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVect.GetObjShapeHeight(hobj:integer):integer;
begin
	with GetObj(hobj)^ do
   	result:=ShapeHeight;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetObjShapeHeight(hobj:integer; v:integer);
begin
	with GetObj(hobj)^ do
   	ShapeHeight:=v;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Setta anche pencolor
procedure TImageEnVect.SetObjFont(hobj:integer; v:TFont);
var
	xlog:TLogFont;
begin
	with GetObj(hobj)^ do begin
   	if LogFont=nil then
         getmem(LogFont,sizeof(TLogFont));
      GetObject(v.Handle,sizeof(TLogFont),@xlog);
      copymemory(LogFont,@xlog,sizeof(TLogFont));
      PenColor:=v.Color;
   end;
   if hobj<>-1 then
	   Update;
end;

// replaces 1310 with 10
function Adjust1310(const v:AnsiString):AnsiString;
var
	i:integer;
begin
   result:='';
	for i:=1 to length(v) do
   	if (v[i]<>#13) then
      	result:=result+v[i];
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetObjText(hobj:integer; v:AnsiString);
begin
	with GetObj(hobj)^ do begin
   	if Text<>nil then
      	freemem(Text);
      Text:=_StrDup(PAnsiChar(Adjust1310(v)));
   end;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVect.GetObjText(hobj:integer):AnsiString;
begin
	with GetObj(hobj)^ do
   	result:=Text;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetObjName(hobj:integer; v:AnsiString);
begin
	with GetObj(hobj)^ do begin
   	if Name<>nil then
      	freemem(Name);
      Name:=_StrDup(PAnsiChar(v));
   end;
   if hobj<>-1 then
   	Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVect.GetObjName(hobj:integer):AnsiString;
begin
	with GetObj(hobj)^ do
   	result:=Name;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVect.GetObjFontAngle(hobj:integer):double;
begin
	with GetObj(hobj)^ do
   	if LogFont<>nil then
	   	result:=LogFont^.lfEscapement/10
      else
      	result:=0;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Aggiunge oggetto alla lista di oggetti selezionati
// Se hobj è -2 rappresenta l'ultimo oggetto inserito
procedure TImageEnVect.AddSelObject(hobj:integer);
begin
	AddSelObjectNS(hobj);
   if assigned(fOnSelectObject) then
   	fOnSelectObject(Self);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Select all objects
procedure TImageEnVect.SelAllObjects;
begin
	UnSelAllObjects;
	SelInRect(-3,0,0,1000000,1000000);
   if assigned(fOnSelectObject) then
      fOnSelectObject(Self);
	Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Aggiunge oggetto alla lista di oggetti selezionati
// Se hobj è -2 rappresenta l'ultimo oggetto inserito
// A differenza di AddSelObject non chiama fOnSelectObject
procedure TImageEnVect.AddSelObjectNS(hobj:integer);
var
	tmp:pintegerarray;
begin
	if hobj=-2 then hobj:=fObjHeapCount-1;
   if ievsSelectable in GetObj(hobj)^.Style then begin
      getmem(tmp,sizeof(integer)*(fSelObjCount+1));
      copymemory(tmp,fSelObj,sizeof(integer)*fSelObjCount);
      freemem(fSelObj);
      fSelObj:=tmp;
      fSelObj^[fSelObjCount]:=hobj;
      inc(fSelObjCount);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Rest. true se l'oggetto specificato è selezionato
// Se hobj è -2 rappresenta l'ultimo oggetto inserito
function TImageEnVect.IsSelObject(hobj:integer):boolean;
var
	q:integer;
begin
	result:=false;
	if hobj=-2 then hobj:=fObjHeapCount-1;
   for q:=0 to fSelObjCount-1 do
   	if fSelObj^[q]=hobj then begin
      	result:=true;
         break;
      end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Elimina l'oggetto specificato dalla lista di oggetti selezionati
// Se hobj è -2 rappresenta l'ultimo oggetto inserito
procedure TImageEnVect.UnSelObject(hobj:integer);
var
	tmp:pintegerarray;
   idx:integer;
begin
	if hobj=-2 then hobj:=fObjHeapCount-1;
	// trova oggetto
   idx:=0;
   while (idx<fSelObjCount) and (fSelObj^[idx]<>hobj) do
   	inc(idx);
   if idx=fSelObjCount then
   	exit;	// oggetto non trovato
   // elimina oggetto idx
   dec(fSelObjCount);
	getmem(tmp,sizeof(integer)*fSelObjCount);
   // copia da 0 a idx-1
   copymemory(tmp,fSelObj,sizeof(integer)*idx);
   // copia da idx+1 a SelObjCount
   copymemory(@(tmp^[idx]),@(fSelObj^[idx+1]),sizeof(integer)*(fSelObjCount-idx));
   freemem(fSelObj);
   fSelObj:=tmp;
   if assigned(fOnSelectObject) then
   	fOnSelectObject(Self);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Annulla tutte le selezioni
procedure TImageEnVect.UnSelAllObjects;
begin
   freemem(fSelObj);
   fSelObj:=nil;
   fSelObjCount:=0;
   if assigned(fOnSelectObject) then
   	fOnSelectObject(Self);
end;

/////////////////////////////////////////////////////////////////////////////////////
// libera (o decrementa reference count) bitmap idx da fBitmaps
procedure TImageEnVect.FreeBitmap(idx:integer);
begin
	if idx>=0 then begin
      if fBitmaps^[Idx].fRefCount=1 then begin
         // libera bitmap
         fBitmaps^[Idx].fBitmap.free;
         fBitmaps^[Idx].fBitmap:=nil;	// da qui la casella idx è libera
         fBitmaps^[Idx].fRefCount:=0;
      end else
         // decrementa reference count
         dec( fBitmaps^[Idx].fRefCount );
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Alloca una TIEVBitmap in fBitmaps.
// Cerca prima di tutto una casella libera (con fBitmap=nil)
// Rest. indice oggetto allocato
function TImageEnVect.AllocBitmap:integer;
var
   p:PIEVBitmapArray;
begin
	for result:=0 to fBitmapsCount-1 do
   	if fBitmaps^[result].fBitmap=nil then
         exit;
   // incrementa fBitmaps
   getmem(p,sizeof(TIEVBitmap)*(fBitmapsCount+1));
   copymemory(p,fBitmaps,sizeof(TIEVBitmap)*(fBitmapsCount));
   freemem(fBitmaps);
   fBitmaps:=p;
   result:=fBitmapsCount;
   inc(fBitmapsCount);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Assegna o copia la bitmap idx all'oggetto hobj
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
// Idx può essere -1 per rappresentare nessuna bitmap
// NO UPDATE
procedure TImageEnVect.SetObjBitmapIdxNU(hobj:integer; idx:integer);
var
   i:integer;
begin
	with GetObj(hobj)^ do begin
   	if BitmapIdx>=0 then
      	// libera precedente bitmap (se necessario)
         FreeBitmap(BitmapIdx);
      if idx>=0 then begin
         if not fShareBitmaps then begin
            // non condividere, aggiungi alla lista
            i:=AllocBitmap;
            fBitmaps^[i].fRefCount:=1;
            fBitmaps^[i].fBitmap:=TIEBitmap.Create;
            fBitmaps^[i].fBitmap.Assign(fBitmaps^[idx].fBitmap);
            BitmapIdx:=i;
         end else begin
            // condividi, aumenta reference count
            BitmapIdx:=idx;
            inc( fBitmaps^[BitmapIdx].fRefCount );
         end;
      end else
      	BitmapIdx:=idx;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// hobj=-1 is the next obejct to insert
// hobj=-2 is the last object inserted
// Se v è nil, annulla precedente assegnazione
// Alpha can be nil
// NO UPDATE
procedure TImageEnVect.SetObjBitmapNU(hobj:integer; v:TIEBitmap);
var
	q:integer;
   i:integer;
begin
	with GetObj(hobj)^ do begin
   	if BitmapIdx>=0 then
      	// libera precedente bitmap (se necessario)
         FreeBitmap(BitmapIdx);
      if v<>nil then begin
         if fShareBitmaps then
            q:=FindBitmap(v)	// cerca se bitmap è già presente
         else
            q:=-1;	// no, non cercare, non condividiamo bitmaps...
         if q=-1 then begin
            // no, non è presente oppure fShareBitmaps=false, aggiungi alla lista
            i:=AllocBitmap;
            fBitmaps^[i].fRefCount:=1;
            fBitmaps^[i].fBitmap:=TIEBitmap.Create;
            fBitmaps^[i].fBitmap.Assign(v);
            //
            BitmapIdx:=i;
         end else begin
            // si, presente, aumenta reference count
            BitmapIdx:=q;
            inc( fBitmaps^[BitmapIdx].fRefCount );
         end;
      end else
      	BitmapIdx:=-1;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Converte hobj in puntatore a TIEVObject
// hobj=-1 is the next object to insert (fNewObjXXXXX).
// hobj=-2 is the last object inserted
// hobj=-3 is all objects (return nil)
// hobj=-4 return nil
function TImageEnVect.GetObj(hobj:integer):PIEVObject;
begin
	case hobj of
      -1: result:=@fNewObj;
   	-2: result:=@(fObjHeap^[fObjHeapCount-1]);
   	-3: result:=nil;
   	-4: result:=nil;
	   else
   		result:=@(fObjHeap^[hobj]);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Setta la bitmap dell'oggetto specificato (-1=del nuovo oggetto) come icona
// ico può essere OIC_SAMPLE,OIC_HAND,OIC_QUES,OIC_BANG,OIC_NOTE,OIC_WINLOGO
// OIC_WARNING,OIC_ERROR,OIC_INFORMATION
procedure TImageEnVect.SetObjBitmapICO(hobj:integer; ico:integer; iwidth,iheight:integer);
var
	hic:HICON;
   OBitmap:TBitmap;
   en:TIEBitmap;
begin
   with GetObj(hobj)^ do begin
     	OBitmap:=TBitmap.Create;
      OBitmap.PixelFormat:=pf24bit;
      OBitmap.Width:=iwidth;
      OBitmap.Height:=iheight;
      hic:=LoadImageA(0,PAnsiChar(ico),IMAGE_ICON,iwidth,iheight,LR_SHARED);
      if hic<>0 then begin
         DrawIconEx(OBitmap.Canvas.Handle,0,0,hic,iwidth,iheight,0,0,DI_NORMAL);
         DestroyIcon(hic);
      end;
      en:=TIEBitmap.Create;
      en.EncapsulateTBitmap(OBitmap,false);
      SetObjBitmapNU(hobj,en);
      en.free;
      OBitmap.free;
   end;
   if hobj<>-1 then
	   Update;
end;

// ret false on abort
function TImageEnVect.SetObjBitmapFromFile(hobj:integer; const FileName:AnsiString):boolean;
var
	io:TImageEnIO;
   bmp:TIEBitmap;
begin
	bmp:=TIEBitmap.Create;
	io:=TImageEnIO.Create(self);
   io.AttachedIEBitmap:=bmp;
   io.LoadFromFile(FileName);
   result:=not io.Aborting;
   if result then
   	SetObjBitmapNU(hobj,bmp);
   io.free;
   bmp.free;
end;

// Disegna un grip (x,y sono coordinate del componente)
// x,y è il centro del grip, mentre la dimensione è data dalla costante fGripSize
// ty=0 grip quadrato
// ty=1 grip rombo
procedure TImageEnVect.DrawGrip(destcanvas:TCanvas; x,y:integer; ty:integer);
begin
	with destcanvas do begin
   	pen.Assign( fGripPen );
      brush.Assign( fGripBrush );
	   if ty=0 then begin
         // boxed grip
         Rectangle(x-fGripSize,y-fGripSize,x+fGripSize,y+fGripSize);
      end else if ty=1 then begin
      	// triangular grip
         pen.width:=1;	// fGripPenWidth doesn't work with central grip
         MoveTo(x,y-fGripSize);
         LineTo(x+fGripSize,y);
         LineTo(x,y+fGripSize);
         LineTo(x-fGripSize,y);
         LineTo(x,y-fGripSize);
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Rest. true se la coordinata xp,yp è nel grip xg,yg
function TImageEnVect.InGrip(xg,yg,xp,yp:integer):boolean;
var
	rc:trect;
begin
	rc:=rect(xg-fGripSize,yg-fGripSize,xg+fGripSize,yg+fGripSize);
	result:=PtInRect(rc,point(xp,yp));
end;

/////////////////////////////////////////////////////////////////////////////////////
// Draw grips of specifies object
procedure TImageEnVect.DrawObjectGrips(Canvas:TCanvas; const aobj:TIEVObject);
var
   x1,y1,x2,y2,x3,y3:integer;
begin
	// convert bitmap coordinates to client
   x1:=XBmp2Scr(aobj.x1);
   y1:=YBmp2Scr(aobj.y1);
   x2:=XBmp2Scr(aobj.x2);
   y2:=YBmp2Scr(aobj.y2);
   x3:=XBmp2Scr(aobj.x2+1);
   y3:=YBmp2Scr(aobj.y2+1);
   // adjust with pen width
   AdjustCoords(aobj,x1,y1,x2,y2,x3,y3,fZoomD100);
   // check rectangles intersection
   if _RectXRect(x1,y1,x2,y2, fOffX,fOffY,fOffX+fExtX,fOffY+fExtY) then begin
   	// draw grips
      if aobj.Kind<>iekANGLE then begin
         DrawGrip(Canvas,x1,y1,0);
         DrawGrip(Canvas,x2,y2,0);
         if (aobj.Kind<>iekLINE) and (aobj.Kind<>iekRULER) and (aobj.Kind<>iekLINELABEL) then begin
            DrawGrip(Canvas,x2,y1,0);
            DrawGrip(Canvas,x1,y2,0);
            // side grips
            DrawGrip(Canvas,x1,(y1+y2)div 2,0);	// left
            DrawGrip(Canvas,x2,(y1+y2)div 2,0);	// right
            DrawGrip(Canvas,(x1+x2)div 2,y1,0);	// top
            DrawGrip(Canvas,(x1+x2)div 2,y2,0);	// bottom
         end;
      end;
      ordcor(x1,y1,x2,y2);
      if fUseCentralGrip then
      	DrawGrip(Canvas,x1+((x2-x1+1) shr 1),y1+((y2-y1+1) shr 1),1);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Trova l'oggetto più vicino alle coordinate x e y (bitmap 100%)
// Rest. -3 se nessun oggetto trovato
// ds è la distanza di x,y dall'oggetto restituito (valore di output).
// Esclude tutti gli oggetti che sono fuori dal campo visivo
// mustbeselectable: true if the object must selectable
function TImageEnVect.FindNearObj(x,y:integer; var ds:double; mustbeselectable:boolean):integer;
var
	q:integer;
   tds:double;
	cx1,cy1,cx2,cy2:integer;
   aobj:PIEVObject;
begin
   cx1:=trunc(fViewX*f100DZoom); cy1:=trunc(fViewY*f100DZoom);
   cx2:=trunc((fViewX+fExtX)*f100DZoom); cy2:=trunc((fViewY+fExtY)*f100DZoom);
	ds:=2147483647;	// maximum distance
	result:=-3;
	for q:=fObjCount-1 downto 0 do begin
   	aobj:=GetObj(fObj^[q]);
   	with aobj^ do begin
         if ((ievsSelectable in Style) or not mustbeselectable) and _RectXRect(x1,y1,x2,y2, cx1,cy1,cx2,cy2) then begin
            // the object is visible
            tds:=CalcDistPtObj( aobj,x,y );
            if tds<ds then begin
            	ds:=tds;
               result:=fObj^[q];
            end;
         end;
      end;
   end;
   if (fMaxSelectionDistance>-1) then begin
   	tds:=fMaxSelectionDistance*f100DZoom;
   	if ds>tds then
	   	result:=-3;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Calculate the distance (in bitmap pixels 100%) between a point and specified object
function TImageEnVect.CalcDistPtObj(Obj:PIEVObject; x,y:integer):double;
var
	zx,zy:double;
begin
	with Obj^ do
      case Kind of
      	iekBITMAP, iekBOX, iekTEXT, iekMEMO:
            begin
              	// distance from borders
               result:=dmin( _DistPoint2Seg(x,y,x1,y1,x2,y1),
   	                  	dmin( _DistPoint2Seg(x,y,x2,y1,x2,y2),
	  	                     	dmin( _DistPoint2Seg(x,y,x2,y2,x1,y2),
                                  _DistPoint2Seg(x,y,x1,y2,x1,y1) ) ) );
					if ((Kind=iekBITMAP) or (Kind=iekTEXT) or (Kind=iekMEMO) or ((Kind=iekBOX) and (BrushStyle<>bsClear))) and _InRect(x,y,x1,y1,x2,y2) then
               	// it is inside of a una bitmap,text or filled box, then distance is null
               	result:=0;
            end;
         iekLINE,iekLINELABEL: result:=_DistPoint2Seg(x,y,x1,y1,x2,y2);
         iekRULER: result:=_DistPoint2Seg(x,y,x1,y1,x2,y2);
         iekELLIPSE: result:=_DistPoint2Ellipse(x,y,x1,y1,x2,y2);
         iekARC: result:=_DistPoint2Ellipse(x,y,x1,y1,x2,y2);
         iekPOLYLINE:
         	begin
               CalcZxZyPolyline(Obj,zx,zy);
		         result:=_DistPoint2Polyline(x,y,PolyPoints,PolyPointsCount,PolyBaseX1,PolyBaseY1,x1,y1,zx,zy);
            end;
         iekANGLE:
         	result:=_DistPoint2Polyline(x,y,@(AnglePoints[0]),CountAnglePoints(AnglePoints),0,0,0,0,1,1);
         else
            result:=-1;	// ...it is impossible
      end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.DrawSelGrips(Canvas:TCanvas);
var
	q:integer;
begin
	for q:=0 to fSelObjCount-1 do
     	DrawObjectGrips(Canvas,GetObj(fSelObj^[q])^);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Add the fNewObj object
// return the object handle
function TImageEnVect.AddNewObject:integer;
begin
	result:=AddVObject(fNewObj);
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Aggiunge l'oggetto "Obj"
// Viene effettuata una copia di Obj (e dei suoi dati locali).
// Incrementa fObjCount
// Restituisce l'handle dell'oggetto
function TImageEnVect.AddVObject(const aObj:TIEVObject):integer;
var
	tmp:pintegerarray;
   pobj:PIEVObject;
   heap:PIEVObjectArray;
   i,l:integer;
   ci:PIECharInfo;
   //
   procedure AllocLogFont;
   begin
   	with pobj^ do
         if aObj.LogFont<>nil then begin
            getmem(LogFont,sizeof(TLogFont));
            copymemory(LogFont,aObj.LogFont,sizeof(TLogFont));
         end;
   end;
   //
begin
	// resize array
   if (fObjCount mod ALLOCBLOCK)=0 then begin
		getmem(tmp,sizeof(integer)*(fObjCount+ALLOCBLOCK+10));
	   copymemory(tmp,fObj,sizeof(integer)*fObjCount);
	   freemem(fObj);
	   fObj:=tmp;
   end;
   // add the object to the heap
   if (fObjHeapCount mod ALLOCBLOCK)=0 then begin
		getmem(heap,sizeof(TIEVObject)*(fObjHeapCount+ALLOCBLOCK+10));
	   copymemory(heap,fObjHeap,sizeof(TIEVObject)*fObjHeapCount);
	   freemem(fObjHeap);
	   fObjHeap:=heap;
   end;
   pobj:=@(fObjHeap^[fObjHeapCount]); // new object address
   copymemory(pobj,@aObj,sizeof(TIEVObject));  // copy Obj to the new object
   fObj^[fObjCount]:=fObjHeapCount; // assign new object index
   result:=fObjHeapCount;
   inc(fObjHeapCount);
   inc(fObjCount);
   with pobj^ do begin
      BitmapIdx:=-1;
      Text:=nil;
      LogFont:=nil;
      TextFormatRef:=nil;
      TextFormat:=nil;
      CurvedPos:=nil;
      CurvedLen:=0;
      DrawnPoints:=nil;
      DrawnPointsCount:=0;
      softShadow:=TIEVSoftShadow.Create;
      softShadow.Enabled:=aObj.softShadow.Enabled;
      softShadow.Radius:=aObj.softShadow.Radius;
      softShadow.OffsetX:=aOBj.softShadow.OffsetX;
      softShadow.OffsetY:=aObj.softShadow.OffsetY;
	   if Kind=iekBITMAP then
      	// clone the bitmap
         SetObjBitmapIdxNU(fObjHeapCount-1,aObj.BitmapIdx);
      if (Kind=iekTEXT) or (Kind=iekLINELABEL) then begin
      	// clone text and font
			if aObj.Text<>nil then
         	Text:=_StrDup(aObj.Text)
         else
         	Text:=_StrDup('');	// set empty AnsiString
         AllocLogFont;
         if aObj.CurvedLen>0 then begin
         	CurvedLen:=aObj.CurvedLen;
         	getmem(CurvedPos,sizeof(TDPoint)*CurvedLen);
            move(aObj.CurvedPos[0],CurvedPos[0],sizeof(TDPoint)*CurvedLen);
         end;
      end;
      if Kind=iekMEMO then begin
      	Text:=_StrDup(aObj.Text);
         AllocLogFont;
         if aObj.TextFormatRef<>nil then begin
         	l:=strlen(Text);
         	getmem(TextFormatRef,sizeof(integer)*(l+1));
            move(aObj.TextFormatRef^,TextFormatRef^,sizeof(integer)*l);
				TextFormat:=TList.Create;
            for i:=0 to aObj.TextFormat.Count-1 do begin
            	getmem(ci,sizeof(TIECharInfo));
               move(PIECharInfo(aObj.TextFormat[i])^,ci^,sizeof(TIECharInfo));
               TextFormat.Add(ci);
            end;
         end;
      end;
      if Kind=iekRULER then
      	AllocLogFont;
      if aObj.Name<>nil then
      	Name:=_StrDup(aObj.Name)
      else
      	Name:=_StrDup('');
      if (Kind<>iekLINE) and (Kind<>iekRULER) and (Kind<>iekPOLYLINE) and (Kind<>iekLINELABEL) then
	     	OrdCor(x1,y1,x2,y2);
      if Kind=iekPOLYLINE then begin
         PolyPointsCount:=aobj.PolyPointsCount;
         getmem(PolyPoints,PolyPointsCount*sizeof(TPoint));
         copymemory(PolyPoints,aobj.PolyPoints,PolyPointsCount*sizeof(TPoint));
         PolyBaseX1:=aobj.PolyBaseX1;
         PolyBaseY1:=aobj.PolyBaseY1;
         PolyBaseX2:=aobj.PolyBaseX2;
         PolyBaseY2:=aobj.PolyBaseY2;
      end else begin
         PolyPoints:=nil;
         PolyPointsCount:=0;
         PolyBaseX1:=0;
         PolyBaseY1:=0;
         PolyBaseX2:=0;
         PolyBaseY2:=0;
         move(aobj.AnglePoints[0],AnglePoints[0],3*sizeof(TPoint));
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Rimuove (distacca) l'oggetto "hobj"
// Non libera la memoria per l'oggetto hobj
procedure TImageEnVect.RemoveVObject(hobj:integer);
var
	tmp:pintegerarray;
   idx:integer;	// indice di hobj
begin
   for idx:=0 to fObjCount-1 do
   	if fObj^[idx]=hobj then
      	break;
   dec(fObjCount);
	getmem(tmp,sizeof(integer)*(fObjCount+ALLOCBLOCK+10));
   // copia da 0 a idx-1
   copymemory(tmp,fObj,sizeof(integer)*idx);
   // copia da idx+1 a ObjCount
   copymemory(@(tmp^[idx]),@(fObj^[idx+1]),sizeof(integer)*(fObjCount-idx));
   freemem(fObj);
   fObj:=tmp;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Rimuove i dati allocati dinamicamente di tutti gli oggetti
// (dati iekBITMAP)
// Gli oggetti stessi non vengono rimossi.
procedure TImageEnVect.RemoveVObjDataAll;
var
	q:integer;
begin
   for q:=0 to fObjCount-1 do
      RemoveVObjData( GetObj(fObj^[q])^ );
   freemem( fobj ); // memoria array
   fObjCount:=0;
   fObj:=nil;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Rimuove i dati allocati dinamicamente di un oggetto TIEVObject
// (dati iekBITMAP)
// L'oggetto stesso non viene rimosso.
procedure TImageEnVect.RemoveVObjData(var obj:TIEVObject);
begin
   if obj.BitmapIdx>=0 then begin
      // Libera dati immagine
      FreeBitmap(obj.BitmapIdx);
      obj.BitmapIdx:=-1;
   end;
   // free name
   if obj.Name<>nil then
      freemem(obj.Name);
   // free text and font
   if obj.Text<>nil then
      freemem(obj.Text);
   obj.Text:=nil;
   if obj.LogFont<>nil then
      freemem(obj.LogFont);
   obj.LogFont:=nil;
   if obj.TextFormatRef<>nil then
   	freemem(obj.TextFormatRef);
   obj.TextFormatRef:=nil;
   if obj.TextFormat<>nil then begin
      while obj.TextFormat.Count>0 do begin
      	freemem( obj.TextFormat[ obj.TextFormat.Count-1 ] );
         obj.TextFormat.Delete( obj.TextFormat.Count-1 );
      end;
   end;
   if obj.CurvedLen>0 then begin
   	freemem(obj.CurvedPos);
   end;
   obj.CurvedLen:=0;
   obj.CurvedPos:=nil;
   obj.TextFormat:=nil;
   // polypoints
   if obj.PolyPoints<>nil then
   	freemem(obj.PolyPoints);
   obj.PolyPoints:=nil;
   obj.PolyPointsCount:=0;
   obj.PolyBaseX1:=0;
   obj.PolyBaseY1:=0;
   obj.PolyBaseX2:=0;
   obj.PolyBaseY2:=0;
   if obj.DrawnPoints<>nil then begin
   	freemem(obj.DrawnPoints);
      obj.DrawnPoints:=nil;
   end;
   obj.DrawnPointsCount:=0;
   // softshadow
   obj.softShadow.free;
   obj.softShadow:=nil;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Rimuove tutti gli oggetti e i loro dati
// Libera heap oggetti (fObjHeap)
// Rimuove selezione oggetti
procedure TImageEnVect.RemoveAllObjects;
var
	q:integer;
begin
	CancelInteracts;
	// Libera dati
   RemoveVObjDataAll;
   // libera selezione
  	freemem(fSelObj);
   fSelObj:=nil;
   fSelObjCount:=0;
   // libera heap
   freemem(fObjHeap);	// libera fisicamente tutti gli oggetti
   fObjHeap:=nil;
   fObjHeapCount:=0;
   // libera bitmaps
   for q:=0 to fBitmapsCount-1 do
   	if fBitmaps^[q].fBitmap<>nil then begin
	   	fBitmaps^[q].fBitmap.free;
      end;
   freemem(fBitmaps);
   fBitmaps:=nil;
   fBitmapsCount:=0;
   //
   fNewObj.BitmapIdx:=-1;
   fObjCount:=0;
	DoVectorialChanged;
   //
   Update;
end;

// changes PolyLinePoints, PolyLineCount, x1,y1,x2,y2, PolyBaseWidth, PolyBaseHeight
// x,y must be in bitmap coordinates
procedure TImageEnVect.AddPolyLinePoint(hobj:integer; X,Y:integer);
var
	nn:PPointArray;
begin
	with GetObj(hobj)^ do
   	if (PolyPointsCount=0) or (X<>PPointarray(PolyPoints)[PolyPointsCount-1].x) or (Y<>PPointarray(PolyPoints)[PolyPointsCount-1].Y) then begin
        inc(PolyPointsCount);
        getmem(nn,PolyPointsCount*sizeof(TPoint));
        move(PPointArray(PolyPoints)[0],nn[0],(PolyPointsCount-1)*sizeof(TPoint));
        freemem(PolyPoints);
        PolyPoints:=nn;
        PPointArray(PolyPoints)[PolyPointsCount-1].x:=X;
        PPointArray(PolyPoints)[PolyPointsCount-1].y:=Y;
        if X<x1 then x1:=X;
        if X>x2 then x2:=X;
        if Y<y1 then y1:=Y;
        if Y>y2 then y2:=Y;
        PolyBaseX1:=x1;
        PolyBaseY1:=y1;
        PolyBaseX2:=x2;
        PolyBaseY2:=y2;
   	end;
end;

procedure CalcAngleBox(AnglePoints:array of TPoint; var x1,y1,x2,y2:integer);
var
   xc,yc,mx,my:integer;
begin
	x1:=1000000; y1:=1000000; x2:=-1000000; y2:=-1000000;
   xc:=AnglePoints[1].x;
   yc:=AnglePoints[1].y;
	mx:=abs( xc- imax( AnglePoints[0].x , AnglePoints[2].x ) );
   my:=abs( yc- imax( AnglePoints[0].y , AnglePoints[2].y ) );
   x1:= xc-mx;
   y1:= yc-my;
   x2:= xc+mx;
   y2:= yc+my;
end;

/////////////////////////////////////////////////////////////////////////////////////
// From TImageEnView:
//		fHSX1	: starting mousedown X coordinate
// 	fHSY1 : starting mousedown Y coordinate
procedure TImageEnVect.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	nobj,q:integer;
   xx,yy:integer;
   ds:double;
begin
	inherited;
   if (Button=mbLeft) then begin
      RemoveTextEdit;
      fTextEditing:=-1;
      fCurPolyLineIntraGrip:=-1;
      if miPutLine in fMouseInteractVt then
         fInserting:=iekLINE
      else if miPutLineLabel in fMouseInteractVt then
         fInserting:=iekLINELABEL
      else if miPutRuler in fMouseInteractVt then
         fInserting:=iekRULER
      else if miPutBox in fMouseInteractVt then
         fInserting:=iekBOX
      else if miPutEllipse in fMouseInteractVt then
         fInserting:=iekELLIPSE
      else if miPutBitmap in fMouseInteractVt then
         fInserting:=iekBITMAP
      else if miPutText in fMouseInteractVt then
         fInserting:=iekTEXT
      else if miPutMemo in fMouseInteractVt then
         fInserting:=iekMEMO
      else if miDragLen in fMouseInteractVt then
         fInserting:=iekLINE
      else if miPutAngle in fMouseInteractVt then begin
      	if fInserting<>iekANGLE then begin
         	// begin iekANGLE inserting
	      	fInserting:=iekANGLE;
            xx:=xScr2Bmp(x);
            yy:=yScr2Bmp(y);
            with fNewObj do begin
            	Kind:=iekANGLE;
               AnglePoints[0]:=Point(xx,yy);
               AnglePoints[1]:=Point(-1000000,-1000000);
               AnglePoints[2]:=Point(-1000000,-1000000);
               x1:=1000000; y1:=1000000; x2:=-1000000; y2:=-1000000;
				end;
            fInsertingAngleObject:=AddVObject(fNewObj);
            UnSelAllObjects;
            Update;
         end else begin
         	// continue iekANGLE inserting
				with GetObj(fInsertingAngleObject)^ do begin
		         xx:=xScr2Bmp(x);
		         yy:=yScr2Bmp(y);
            	if AnglePoints[1].x=-1000000 then
               	AnglePoints[1]:=Point(xx,yy)
               else begin
               	// finalize iekANGLE inserting
               	AnglePoints[2]:=Point(xx,yy);
                  CalcAngleBox(AnglePoints,x1,y1,x2,y2);
                  AddSelObject(-2);
                  DoVectorialChanged;
                  if assigned(fOnNewObject) then
                     fOnNewObject(self,fObjHeapCount-1);
                  fInserting:=iekNONE;
					end;
            end;
            Update;
         end;
      end else if miPutPolyLine in fMouseInteractVt then begin
      	if fInserting<>iekPOLYLINE then begin
         	// begin iekPOLYLINE inserting
            fInserting:=iekPOLYLINE;
            with fNewObj do begin
            	Kind:=iekPOLYLINE;
               x1:=1000000; y1:=1000000; x2:=-1000000; y2:=-1000000;
            end;
            fInsertingPolylineObject:=AddVObject(fNewObj);
            fInsertingPolylineLastX:=X;
            fInsertingPolylineLastY:=Y;
            AddPolyLinePoint(fInsertingPolylineObject,xScr2Bmp(X),yScr2Bmp(Y));
            UnSelAllObjects;
            Update;
         end else begin
         	// continue iekPOLYLINE inserting
            fInsertingPolylineLastX:=X;
            fInsertingPolylineLastY:=Y;
				AddPolyLinePoint(fInsertingPolylineObject,xScr2Bmp(X),yScr2Bmp(Y));
            if (ssDouble in Shift) then begin
            	// double click, finalize the polyline inserting
               with GetObj(fInsertingPolylineObject)^ do begin
                  fNewObj.x1:=x1;
                  fNewObj.y1:=y1;
                  fNewObj.x2:=x2;
                  fNewObj.y2:=y2;
               end;
	            AddSelObject(-2);
               DoVectorialChanged;
	            if assigned(fOnNewObject) then
	            	fOnNewObject(self,fObjHeapCount-1);
               fInserting:=iekNONE;
            end;
            Update;
			end;
      end else if miEditPolyLine in fMouseInteractVt then begin
         fCurPolylineGrip:=FindPolyLinePoint(x,y);
         if fCurPolylineGrip=-1 then
         	fCurPolylineIntraGrip:=FindPolyLineIntraPoint(x,y)
         else
         	fCurPolylineIntraGrip:=-1;
      end else if (miObjectSelect in fMouseInteractVt) then begin
         if (ssDouble in Shift) then begin
            // double click
            xx:=xScr2Bmp(x);
            yy:=yScr2Bmp(y);
            nobj:=FindNearObj(xx,yy,ds,true);
            if nobj>=0 then
            	DoObjectDblClick(nobj);
            if (GetObj(nobj)<>nil) and ((GetObj(nobj)^.Kind=iekTEXT) or (GetObj(nobj)^.Kind=iekMEMO)) and (ds=0) then begin
               // double click on iekTEXT or iekMEMO object
               // enables text modify
               DrawSelGrips(Canvas);
               // object selection
               UnSelAllObjects;
               AddSelObject(nobj);
               DrawSelGrips(Canvas);
               //
               fTextEditing:=nobj;
               ActiveTextEdit;
               Update;
            end;
         end else begin
         	if fSelectOnMouseDown then
	         	MouseSelect(Shift,x,y);
            FindSelGrip(x,y,fGripping);
            if fGripping>0 then begin
	            for q:=0 to fSelObjCount-1 do
   	            with GetObj(fSelObj^[q])^ do begin
							lx1:=x1;
                     ly1:=y1;
                     lx2:=x2;
                     ly2:=y2;
                  end;
      		end;
         end;
      end;
      fVMoveX:=x;
      fVMoveY:=y;
      flx:=0;
      fly:=0;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// update Hint if present
procedure TImageEnVect.UpdateHint(x,y:integer);
begin
	HintRestore;
   HintShow(x,y);
end;

procedure TImageEnVect.HintRestore;
begin
   if fShowHint and (fHintSaveBitmap.Width>1) then begin
      Canvas.Draw(fHintX,fHintY,fHintSaveBitmap);
      fHintSaveBitmap.Width:=1;	// this invalidates the hint
   end;
end;

procedure TImageEnVect.HintShow(x,y:integer);
var
	ss:AnsiString;
   vv:double;
	dx, dy: double;
	lx, ly: double;
begin
   if fShowHint then begin
   	if x=-1000000 then x:=fHintX;
      if y=-1000000 then y:=fHintY;
      if x<0 then x:=0;
      if y<0 then y:=0;
      if (miArea in fMouseInteractVt) then begin
      	// AREA
         vv:=GetSelectionArea;
         if vv=0 then vv:=fLastHintValue;
         fLastHintValue:=vv;
         ss:=floattostrf(vv,ffFixed,fFloatPrecision,fFloatDigits)+' '+strunits[ord(fMUnit)]+chr(178);
         if assigned(fOnMeasureHint) then
            fOnMeasureHint(self,ss,vv);
      end else if (miLineLen in fMouseInteractVt) then begin
      	// PERIMETER
	      vv:=GetSelectionLen;
         if vv=0 then vv:=fLastHintValue;
         fLastHintValue:=vv;
         ss:=floattostrf(vv,ffFixed,fFloatPrecision,fFloatDigits)+' '+strunits[ord(fMUnit)];
         if assigned(fOnMeasureHint) then
            fOnMeasureHint(self,ss,vv);
      end else if (miDragLen in fMouseInteractVt) then begin
      	// LINE LEN
         dx := fCoefX*f100DZoom;
         dy := fCoefY*f100DZoom;
         lx := (x - fHSX1 +1)*dx;
         ly := (y - fHSY1 +1)*dy;
         vv := Sqrt(lx*lx + ly*ly);
         if vv=0 then vv:=fLastHintValue;
         fLastHintValue:=vv;
         ss := floattostrf(vv,ffFixed,fFloatPrecision,fFloatDigits)+' '+strunits[ord(fMUnit)];
         if assigned(fOnMeasureHint) then
            fOnMeasureHint(self,ss,vv);
      end;
      IEDrawHint(Canvas,x,y,ss,fMeasureHintFont,fMeasureHintBrush,fHintSaveBitmap,ClientWidth,ClientHeight,fMeasureHintBorder1,fMeasureHintBorder2);
      fHintX:=x;
      fHintY:=y;
   end;
end;

// of selected polyline
// -1 no grip
function TImageEnVect.FindPolylinePoint(x,y:integer):integer;
var
	i:integer;
   pobj:PIEVObject;
   pts:ppointarray;
begin
	result:=-1;
	if (fSelObjCount=1) then begin
		pobj:=GetObj(fSelObj^[0]);
      if (pobj^.Kind=iekPOLYLINE) then
         with pobj^ do
            for i:=0 to DrawnPointsCount-1 do begin
            	pts:=ppointarray(DrawnPoints);
            	if _InRect(x,y, pts[i].x-POLYLINEGDIM,pts[i].y-POLYLINEGDIM,pts[i].x+POLYLINEGDIM,pts[i].y+POLYLINEGDIM) then begin
               	result:=i;
                  break;
               end;
            end;
   end;
end;

// of selected polyline
// -1 no grip
function TImageEnVect.FindPolylineIntraPoint(x,y:integer):integer;
var
	i:integer;
   pobj:PIEVObject;
   pts:ppointarray;
   d:double;
begin
	result:=-1;
	if (fSelObjCount=1) then begin
		pobj:=GetObj(fSelObj^[0]);
      if (pobj^.Kind=iekPOLYLINE) then
         with pobj^ do begin
         	pts:=ppointarray(DrawnPoints);
            for i:=0 to DrawnPointsCount-2 do begin
               d:=_DistPoint2Seg(x,y, pts[i].x,pts[i].y,pts[i+1].x,pts[i+1].y);
               if d<1.5 then begin
               	result:=i;
                  exit;
               end;
            end;
            if PolyClosed then begin
               d:=_DistPoint2Seg(x,y, pts[DrawnPointsCount-1].x,pts[DrawnPointsCount-1].y,pts[0].x,pts[0].y);
               if d<1.5 then
               	result:=DrawnPointsCount-1;
            end;
         end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.MouseMove(Shift: TShiftState; X, Y: Integer);
var
	dx:integer;
	q,ox,oy,lx,ly:integer;
	nobj:integer;
   xx,yy:integer;
   ds:double;
   ux1,uy1,ux2,uy2:integer;
begin
   HintRestore;
   inherited;
	// adjust point
   fMovX:=x;
   fMovY:=y;
   x:=ilimit(x,fOffX,fOffX+fExtX-1);
   y:=ilimit(y,fOffY,fOffY+fExtY-1);
   if MouseCapture then begin

   	// inside mouse capture

   	if fInserting<>iekNONE then begin
     	   fVStable:=1;
         // inserting objects
         case fInserting of
            iekLINE,iekLINELABEL:
               begin
						if (miDragLen in fMouseInteractVt) then begin
                  	x:=fMovX;
                     y:=fMovY;
                     fShowHint:=true;
                  end;
                  DrawLineInserting;	// remove old line
						MouseMoveScroll;
                  if (ssCtrl in Shift) then
                     _CastPolySelCC(fHSX1,fHSY1,x,y);
                  fVMoveX:=X;
                  fVMoveY:=Y;
                  DrawLineInserting;	// draw new line
               end;
            iekRULER:
               begin
						MouseMoveScroll;
                  if (ssCtrl in Shift) then
                     _CastPolySelCC(fHSX1,fHSY1,x,y);
                  fVMoveX:=X;
                  fVMoveY:=Y;
                  Paint;
                  DrawRulerInserting;
               end;
            iekANGLE:
            	begin
               	MouseMoveScroll;
                  fVMoveX:=X;
                  fVMoveY:=Y;
                  Paint;
                  DrawAngleInserting;
               end;
            iekBOX:
               begin
                  DrawBoxInserting;
                  MouseMoveScroll;
                  fVMoveX:=X;
                  fVMoveY:=Y;
                  DrawBoxInserting;
               end;
            iekELLIPSE:
               begin
                  DrawEllipseInserting;
                  MouseMoveScroll;
                  if (ssCtrl in Shift) then begin
                     // circle (pressing CTRL)
                     if abs(fHSX1-X)>abs(fHSY1-Y) then
                        dx:=X-fHSX1
                     else
                        dx:=Y-fHSY1;
                     fVMoveX:=fHSX1+dx;
                     fVMoveY:=fHSY1+dx;
                  end else begin
                     fVMoveX:=X;
                     fVMoveY:=Y;
                  end;
                  DrawEllipseInserting;
               end;
            iekBITMAP:
               begin
                  DrawBoxInserting;
                  MouseMoveScroll;
                  fVMoveX:=X;
                  fVMoveY:=Y;
                  DrawBoxInserting;
               end;
            iekTEXT, iekMEMO:
               begin
                  DrawBoxInserting;
                  MouseMoveScroll;
                  fVMoveX:=X;
                  fVMoveY:=Y;
                  DrawBoxInserting;
               end;
            iekPOLYLINE:
            	begin
                  // continue iekPOLYLINE inserting
		            fInsertingPolylineLastX:=fMovX;
		            fInsertingPolylineLastY:=fMovY;
                  AddPolyLinePoint(fInsertingPolylineObject,xScr2Bmp(fMovX),yScr2Bmp(fMovY));
                  Update;
					end;
         end;
      end else if fGripping<>0 then begin
         // changes object coordinates
         DoBeforeVectorialChange;
         fVStable:=1;
         MouseMoveScroll;
         ox:=trunc((x-fHSX1)*f100DZoom);
         oy:=trunc((y-fHSY1)*f100DZoom);
         lx:=ox;
         ly:=oy;
         ox:=ox-flx;
         oy:=oy-fly;
         flx:=lx;
         fly:=ly;
         for q:=0 to fSelObjCount-1 do
         	with GetObj(fSelObj^[q])^ do begin
            	DoObjectMoveResize(fSelObj^[q],fGripping,ox,oy);
               if (ievsSizeable in Style) and (Kind<>iekANGLE) then
                  case fGripping of
                     1: ChangeObjectCoor(fSelObj^[q],ox,oy,0,0,(ssAlt in Shift) or fForceALTkey,1);
                     2: ChangeObjectCoor(fSelObj^[q],0,0,ox,oy,(ssAlt in Shift) or fForceALTkey,2);
                     4: ChangeObjectCoor(fSelObj^[q],0,oy,ox,0,(ssAlt in Shift) or fForceALTkey,4);
                     5: ChangeObjectCoor(fSelObj^[q],ox,0,0,oy,(ssAlt in Shift) or fForceALTkey,5);

                     6: ChangeObjectCoor(fSelObj^[q],ox,0,0,0,(ssAlt in Shift) or fForceALTkey,6);
                     7: ChangeObjectCoor(fSelObj^[q],0,0,ox,0,(ssAlt in Shift) or fForceALTkey,7);
                     8: ChangeObjectCoor(fSelObj^[q],0,oy,0,0,(ssAlt in Shift) or fForceALTkey,8);
                     9: ChangeObjectCoor(fSelObj^[q],0,0,0,oy,(ssAlt in Shift) or fForceALTkey,9);
                  end;
               if (ievsMoveable in Style) and (fGripping=3) then
                  TraslateObject(fSelObj^[q],ox,oy);
	         end;
         Update;
      end else if miEditPolyLine in fMouseInteractVt then begin
      	MouseMoveScroll;
         if fCurPolylineGrip>-1 then begin
            ox:=trunc((x-fHSX1)*f100DZoom);
            oy:=trunc((y-fHSY1)*f100DZoom);
            lx:=ox;
            ly:=oy;
            ox:=ox-flx;
            oy:=oy-fly;
            flx:=lx;
            fly:=ly;
            with GetObj(fSelObj^[0])^ do begin
               ux1:=VXBmp2Scr(x1-8,true,1);
               uy1:=VYBmp2Scr(y1-8,true,1);
               ux2:=VXBmp2Scr(x2+8,true,1);
               uy2:=VYBmp2Scr(y2+8,true,1);
            	with ppointarray(PolyPoints)^[fCurPolylineGrip] do begin
            		inc(x, ox);
                  inc(y, oy);
               end;
               RecalcPolylineBox(GetObj(fSelObj^[0]));
               ux1:=imin(ux1,VXBmp2Scr(x1-8,true,1));
               uy1:=imin(uy1,VYBmp2Scr(y1-8,true,1));
               ux2:=imax(ux2,VXBmp2Scr(x2+8,true,1));
               uy2:=imax(uy2,VYBmp2Scr(y2+8,true,1));
            end;
            UpdateRect(rect(ux1,uy1,ux2,uy2));
         end;
      end else begin
         // no objects to change and no objects to insert
         if miObjectSelect in fMouseInteractVt then begin
            // selecting more objects with rectangle selection
            DrawBoxInserting;
            MouseMoveScroll;
            fVMoveX:=X;
            fVMoveY:=Y;
            DrawSelGrips(Canvas);
            if not (ssShift in Shift) then
	            UnSelAllObjects;
            ox:=XScr2Bmp(fHSX1);
            oy:=YScr2Bmp(fHSY1);
            lx:=XScr2Bmp(fVMoveX);
            ly:=YScr2Bmp(fVMoveY);
            OrdCor(ox,oy,lx,ly);
            SelInRect(-3,ox,oy,lx,ly);
            if assigned(fOnSelectObject) then
			   	fOnSelectObject(Self);
            DrawSelGrips(Canvas);
            DrawBoxInserting;
         end;
      end;
   end else begin

   	// not mouse capture

      if fInserting=iekPOLYLINE then begin
      	// inserting Polyline, show a line from last clicked point to the current
         DrawLineInserting;
         MouseMoveScroll;
         if (ssCtrl in Shift) then
            _CastPolySelCC(fHSX1,fHSY1,fMovx,fMovy);
         fVMoveX:=fMovX;
         fVMoveY:=fMovY;
         DrawLineInserting;
         if (miDragLen in fMouseInteractVt) then
	         fShowHint:=True;
      end else if fInserting=iekANGLE then begin
      	// inserting angle
         MouseMoveScroll;
         if (ssCtrl in Shift) then
            _CastPolySelCC(fHSX1,fHSY1,x,y);
         fVMoveX:=X;
         fVMoveY:=Y;
         Paint;
         DrawAngleInserting;
      end else begin
         xx:=xScr2Bmp(x);
         yy:=yScr2Bmp(y);
         nobj:=FindNearObj(xx,yy,ds,false);
         if nobj>=0 then
            DoObjectOver(nobj);
      end;
      if miEditPolyLine in fMouseInteractVt then begin
         if FindPolyLinePoint(x,y)>-1 then begin
         	if ssCtrl in Shift then
            	// remove cursor
               SetTempCursor(1792)
            else
            	// move cursor
	         	SetTempCursor(1790);
         end else if FindPolyLineIntraPoint(x,y)>-1 then
         	SetTempCursor(1791)
      	else
         	SetTempCursor(Cursor);
      end;
      if miObjectSelect in fMouseInteractVt then begin
      	FindSelGrip(x,y,q);
         if q>0 then begin
         	case q of
            	1: SetTempCursor(1786);
               2: SetTempCursor(1786);
               3: SetTempCursor(1790);
               4: SetTempCursor(1788);
               5: SetTempCursor(1788);
               6: SetTempCursor(1789);
               7: SetTempCursor(1789);
               8: SetTempCursor(1787);
               9: SetTempCursor(1787);
            end;
         end else
         	SetTempCursor(Cursor);
      end;
   end;
   HintRestore;
   HintShow(fMovX,fMovY);
end;

procedure TImageEnVect.MouseSelect(Shift:TShiftState; x,y:integer);
var
	xx,yy:integer;
   ds:double;
   nobj:integer;
begin
   xx:=xScr2Bmp(x);
   yy:=yScr2Bmp(y);
   nobj:=FindNearObj(xx,yy,ds,true);
   if nobj>=0 then
      DoObjectClick(nobj);
   if GetObj(nobj)<>nil then begin
      // found object (click on/near the object)
      DrawSelGrips(Canvas);
      if IsSelObject(nobj) then begin
         // already selected
         if (ssShift in Shift) then
            // SHIFT pressed, then deselect
            UnSelObject(nobj)
         else begin
            // SHIFT not pressed, then release selected
            UnSelAllObjects;
            AddSelObject(nobj);
         end;
      end else begin
         // to select
         if not (ssShift in Shift) then
            UnSelAllObjects;	// deselect all (SHIFT not pressed)
         AddSelObject(nobj);  // select object
      end;
      DrawSelGrips(Canvas);
   end else if not (ssShift in Shift) then
      UnSelAllObjects;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   xx,yy:integer;
   pts:ppointarray;
begin
	inherited;
   if (fInserting=iekPOLYLINE) and (Button=mbLeft) then begin
      fHSX1:=x;
      fHSY1:=y;
      DrawLineInserting;
	end;
   if (fInserting<>iekPOLYLINE) and (fInserting<>iekANGLE) and (Button=mbLeft) then begin
      if fTextEditing>=0 then
         exit;
      if (fInserting<>iekNONE) then begin
         with fNewObj do begin
            // ottiene coordinate oggetto rispetto alla bitmap al 100%
            if (fHSX1<>fVMoveX) or (fHSY1<>fVMoveY) then begin
               x1:=xScr2Bmp(fHSX1);
               y1:=yScr2Bmp(fHSY1);
               x2:=xScr2Bmp(fVMoveX);
               y2:=yScr2Bmp(fVMoveY);
            end else begin
               // lascia dimensioni oggetto precedente, ma varia posizione
               xx:=x2-x1;
               yy:=y2-y1;
               x1:=xScr2Bmp(fHSX1);
               y1:=yScr2Bmp(fHSY1);
               x2:=x1+xx;
               y2:=y1+yy;
            end;
            Kind:=fInserting;
         end;
         if not (miDragLen in fMouseInteractVt) then begin
         	DoBeforeVectorialChange;
            AddVObject(fNewObj);
            UnSelAllObjects;
            AddSelObject(-2);
            if (fNewObj.Kind=iekTEXT) or (fNewObj.Kind=iekMEMO) then begin
            	// just added a text object, go to at inserting text mode
               fTextEditing:=fObjHeapCount-1;
               ActiveTextEdit;
            end else
               DoVectorialChanged;
            if assigned(fOnNewObject) then
            	fOnNewObject(self,fObjHeapCount-1);
         end else begin
	         HintRestore;
         	fShowHint:=False;
            if assigned(fOnDragLenEnd) then
               fOnDragLenEnd(Self,fLastHintValue);
         end;
      end else if (fGripping=0) and
                  ( (miObjectSelect in fMouseInteractVt) or (miEditPolyLine in fMouseInteractVt) )
                  and (fHSX1=fVMoveX) and (fHSY1=fVMoveY) then begin
         // select object using a click
         MouseSelect(Shift,x,y);
      end else if fGripping<>0 then begin
         // coordinates of selected objects are changed, reorder coordinates
         for xx:=0 to fSelObjCount-1 do
            with GetObj(fSelObj[xx])^ do
               if (Kind<>iekLINE) and (Kind<>iekRuler) and (Kind<>iekPOLYLINE) and (Kind<>iekLINELABEL) then
                  OrdCor(x1,y1,x2,y2);
         DoVectorialChanged;
      end;
      if (fCurPolyLineGrip>-1) and (ssCtrl in Shift) and (fSelObjCount=1) then begin
      	// CTRL - delete a point
         with GetObj(fSelObj^[0])^ do begin
         	if PolyPointsCount>2 then begin
               getmem(pts,sizeof(TPoint)*PolyPointsCount);
               move(ppointarray(PolyPoints)[0],pts[0],sizeof(TPoint)*PolyPointsCount);
               freemem(PolyPoints);
               PolyPoints:=pts;
               if fCurPolyLineGrip<PolyPointsCount-1 then
                  move(pts[fCurPolyLineGrip+1],pts[fCurPolyLineGrip],sizeof(TPoint)*(PolyPointsCount-fCurPolyLineGrip-1));
               dec(PolyPointsCount);
               RecalcPolylineBox(GetObj(fSelObj^[0]));
            end;
         end;
      end;
      if (fCurPolyLineIntraGrip>-1) and (fSelObjCount=1) then begin
         with GetObj(fSelObj^[0])^ do begin
            xx:=x;
            yy:=y;
            // add a point
            getmem(pts,sizeof(TPoint)*(PolyPointsCount+1));
            move(ppointarray(PolyPoints)[0],pts[0],sizeof(TPoint)*PolyPointsCount);
            freemem(PolyPoints);
            PolyPoints:=pts;
            if fCurPolyLineIntraGrip<PolyPointsCount-1 then
               move( pts[fCurPolyLineIntraGrip+1],
                     pts[fCurPolyLineIntraGrip+2],
                     sizeof(TPoint)*(PolyPointsCount-fCurPolyLineIntraGrip-1) );
            with pts[fCurPolyLineIntraGrip+1] do begin
               x:=XScr2Bmp(xx);
               y:=YScr2Bmp(yy);
            end;
            inc(PolyPointsCount);
         end;
         fCurPolyLineIntraGrip:=-1;
      end;
      Update;
      fInserting:=iekNONE;
      fGripping:=0;
      if fVStable>0 then begin
         fVStable:=0;
         invalidate;
      end;
   end;

   HintShow(x,y);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Traslate specified object
// Do not update the client area
procedure TImageEnVect.TraslateObject(o:integer; ox,oy:integer);
var
   i,p:integer;
begin
	with GetObj(o)^ do begin
		inc(x1,ox);
      inc(y1,oy);
      inc(x2,ox);
      inc(y2,oy);
      if Kind=iekANGLE then begin
         p:=CountAnglePoints(AnglePoints);
         for i:=0 to p-1 do begin
            inc(AnglePoints[i].x,ox);
            inc(AnglePoints[i].y,oy);
         end;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Change coordinates of the specified object
procedure TImageEnVect.ChangeObjectCoor(o:integer; ox1,oy1,ox2,oy2:integer; AspectRatio:boolean; grip:integer);
var
   nn,dd:double;
begin
	with GetObj(o)^ do begin
      if AspectRatio then begin
         inc(x1,ox1);
         inc(y1,oy1);
         inc(x2,ox2);
         inc(y2,oy2);
         nn:=(x2-x1)*(ly2-ly1);
         dd:=(lx2-lx1);
         if (nn<>0) and (dd<>0) then begin
            case grip of
               1: // left-top
                  y1:=round( y2 - (nn/dd) );
               4: // right-top
                  y1:=round( y2 - (nn/dd) );
               2: // right-bottom
                  y2:=round( (nn/dd) + y1 );
               5: // left-bottom
                  y2:=round( (nn/dd) + y1 );
            end;
         end;
      end else begin
         inc(x1,ox1);
         inc(y1,oy1);
         inc(x2,ox2);
         inc(y2,oy2);
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Return the owner of the selected grip
// "gr" return selected grip:
//    0=nothing
//    1=top-left
//    2=bottom-right
//    3=center-translation
//    4=top-right (only boxes)
//    5=bottom-left (only boxes)
//    6=left (only boxes)
//    7=right (only boxes)
//    8=top (only boxes)
//    9=bottom (only boxes)
// If nothing found return NULLOBJ and gr=0
function TImageEnVect.FindSelGrip(x,y:integer; var gr:integer):integer;
var
	q:integer;
   xx1,yy1,xx2,yy2,xx3,yy3:integer;
   oxx1,oyy1,oxx2,oyy2:integer;
   aobj:PIEVObject;
begin
	result:=NULLOBJ;
   gr:=0;
	for q:=0 to fSelObjCount-1 do begin
   	aobj:=GetObj(fSelObj^[q]);
		with aobj^ do begin
      	// converts bitmap coordinates to client area coordinates
         xx1:=XBmp2Scr(x1);
         yy1:=YBmp2Scr(y1);
         xx2:=XBmp2Scr(x2);
         yy2:=YBmp2Scr(y2);
         xx3:=XBmp2Scr(x2+1);
         yy3:=YBmp2Scr(y2+1);
         AdjustCoords(aobj^,xx1,yy1,xx2,yy2,xx3,yy3,fZoomD100);
         oxx1:=xx1;
         oyy1:=yy1;
         oxx2:=xx2;
         oyy2:=yy2;
         ordcor(oxx1,oyy1,oxx2,oyy2);
         if _RectXRect(xx1,yy1,xx2,yy2, fOffX,fOffY,fOffX+fExtX,fOffY+fExtY) then begin
         	if (not fUseCentralGrip) and PtInRect(rect(oxx1, oyy1, oxx2, oyy2), point(x, y)) then
            	gr := 3;
				if InGrip(xx1,yy1,x,y) then
            	gr:=1
            else if InGrip(xx2,yy2,x,y) then
            	gr:=2
         	else if InGrip(oxx1+((oxx2-oxx1+1) shr 1),oyy1+((oyy2-oyy1+1) shr 1),x,y) then
            	gr:=3;
            if (Kind<>iekLINE) and (Kind<>iekRULER) and (Kind<>iekLINELABEL) then begin
            	if InGrip(xx2,yy1,x,y) then
               	gr:=4
               else if InGrip(xx1,yy2,x,y) then
               	gr:=5
               else if InGrip(xx1,(yy1+yy2)div 2,x,y) then
               	gr:=6
               else if InGrip(xx2,(yy1+yy2)div 2,x,y) then
               	gr:=7
               else if InGrip((xx1+xx2)div 2,yy1,x,y) then
               	gr:=8
               else if InGrip((xx1+xx2)div 2,yy2,x,y) then
               	gr:=9;
            end;
            if gr<>0 then begin
         		result:=q;
               break;
            end;
         end;
	   end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Seleziona tutti gli oggetti inclusi nel rettangolo (Bitmap100%)
// Le coordinate xx1,yy1,xx2,yy2 devono essere ordinate
// Non chiama fOnSelectObject
// aobj=-3 tutti gli oggetti
procedure TImageEnVect.SelInRect(aobj:integer; xx1,yy1,xx2,yy2:integer);
var
	o:integer;
   ax1,ay1,ax2,ay2:integer;
begin
	if aobj=-3 then begin
      for o:=0 to fObjCount-1 do
         SelInRect(fObj^[o],xx1,yy1,xx2,yy2)	// chiamata ricorsiva
   end else begin
      // verifica intersezione rettangoli
      with GetObj(aobj)^ do begin
         ax1:=x1; ay1:=y1; ax2:=x2; ay2:=y2;
         if (Kind=iekLINE) or (Kind=iekRULER) or (Kind=iekPOLYLINE) or (Kind=iekANGLE) or (Kind=iekLINELABEL) then
            OrdCor(ax1,ay1,ax2,ay2);
         if (ax1>=xx1) and (ax2<=xx2) and (ay1>=yy1) and (ay2<=yy2) and (not IsSelObject(aobj)) then
            // seleziona
            AddSelObjectNS(aobj);
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVect.ImportDXF(const nf:AnsiString):boolean;
const
	SECS:array [1..6] of AnsiString=('HEADER','CLASSES','TABLES','BLOCKS','ENTITIES','OBJECTS');
var
	tf:TextFile;
   q,section:integer;
   s1,s2:AnsiString;
   ii:integer;
   newobj:TIEVObject;
   dc:AnsiChar;
   xx,yy:double;
   pa:boolean;	// true, processa ii e ss correnti
   xymult:double;
   d1:double;
   ww,hh:integer;
   XEXTMIN,YEXTMIN:double;
   XEXTMAX,YEXTMAX:double;
   AY:integer;
// legge un valore necessario
procedure Read1d(var v1:double; n1:integer);
begin
	while (n1>=0) and not eof(tf) do begin
   	if not pa then begin
	   	readln(tf,s1);
	      readln(tf,s2);
      end else
      	pa:=false;
      ii:=strtointdef(s1,-2);
      if ii=n1 then begin
      	v1:=strtofloat(s2);
         n1:=-1;
      end;
   end;
end;
// legge due valori necessari
procedure Read2d(var v1,v2:double; n1,n2:integer);
begin
	while ((n1>=0) or (n2>=0)) and not eof(tf) do begin
   	if not pa then begin
	   	readln(tf,s1);
	      readln(tf,s2);
      end else
      	pa:=false;
      ii:=strtointdef(s1,-2);
      if ii=n1 then begin
      	v1:=strtofloat(s2);
         n1:=-1;
      end else if ii=n2 then begin
      	v2:=strtofloat(s2);
         n2:=-1;
      end;
   end;
end;
// legge un valore opzionale (se non trova ripristina posizione)
procedure Read1do(var vv:double; nn:integer);
begin
	if not pa then begin
		readln(tf,s1);
	   readln(tf,s2);
   end else
   	pa:=false;
   ii:=strtointdef(s1,-1);
   if ii=nn then
   	vv:=strtofloat(s2)
   else
      pa:=true;	// mantieni s1 e s2
end;
//
procedure CalcCoef;
begin
   xymult:=dmin((1/(XEXTMAX-XEXTMIN+1))*ww,(1/(YEXTMAX-YEXTMIN+1))*hh);
   AY:=hh-trunc((YEXTMAX-YEXTMIN)*xymult);
end;
begin
	result:=true;
   {$IfDef XE}
   assert(false);
   {$Else}
   dc:=decimalseparator;
   decimalseparator:='.';
   {$EndIf}
   ww:=bitmap.width;
   hh:=bitmap.height;
	try
   assignfile(tf,nf);
   reset(tf);
   section:=0;
   newobj.PenColor:=clWhite;
   newobj.PenStyle:=psSolid;
   newobj.PenWidth:=1;
   newobj.BrushColor:=clWhite;
   newobj.BrushStyle:=bsClear;
   newobj.LabelBrushColor:=clWhite;
   newobj.LabelBrushStyle:=bsSolid;
   newobj.Style:=[ievsSelectable, ievsMoveable, ievsSizeable, ievsVisible];
   newobj.BoxHighlight:=false;
   pa:=false;
   xymult:=1;
   AY:=0;
   newobj:=fNewObj;
   with newobj do begin
      BeginShape:=iesNONE;
      EndShape:=iesNONE;
      ShapeWidth:=10;
      ShapeHeight:=20;
      PenWidth:=1;
      LabelPosition:=ielEnd;
   end;
   XEXTMIN:=0; YEXTMIN:=0;
   XEXTMAX:=1000; YEXTMAX:=1000;
   CalcCoef;
   while not eof(tf) do begin
   	if not pa then begin
			readln(tf,s1);
	      readln(tf,s2);
      end else
	      pa:=false;
      ii:=strtointdef(s1,-1);
      case ii of
			0:
         	begin
               if s2='SECTION' then begin
               	// SECTION
                  readln(tf,ii);
                  readln(tf,s2);
                  section:=0;
                  if (ii=2) then
                  	for q:=1 to 6 do
                     	if s2=SECS[q] then section:=q;
               end else if (section=5) then begin
               	// ENTITIES
               	if (s2='LINE') then begin
                  	// LINE
	                  newobj.Kind:=iekLINE;
                     read2d(xx,yy,10,20);
                     xx:=xx-XEXTMIN;
                     yy:=yy-YEXTMIN;
                     newobj.x1:=trunc(xx*xymult);
                     newobj.y1:=hh-trunc(yy*xymult)-AY;
                     read2d(xx,yy,11,21);
                     xx:=xx-XEXTMIN;
                     yy:=yy-YEXTMIN;
                     with newobj do begin
                        x2:=trunc(xx*xymult);
                        y2:=hh-trunc(yy*xymult)-AY;
                     end;
                 		AddVObject(newobj);
                  end else if (s2='CIRCLE') then begin
							// CIRCLE
							newobj.Kind:=iekELLIPSE;
                     read2d(xx,yy,10,20);	// centro
                     xx:=xx-XEXTMIN;
                     yy:=yy-YEXTMIN;
                     read1d(d1,40);	// raggio
                     with newobj do begin
                        x1:=trunc((xx-d1)*xymult);
                        y1:=hh-trunc((yy-d1)*xymult)-AY;
                        x2:=trunc((xx+d1)*xymult);
                        y2:=hh-trunc((yy+d1)*xymult)-AY;
                  	end;
                     AddVObject(newobj);
                  end else if (s2='ARC') then begin
							// ARC
							newobj.Kind:=iekARC;
                     read2d(xx,yy,10,20);	// centro
                     xx:=xx-XEXTMIN;
                     yy:=yy-YEXTMIN;
                     read1d(d1,40);	// raggio
                     with newobj do begin
                        x1:=trunc((xx+d1)*xymult);
                        y1:=hh-trunc((yy+d1)*xymult)-AY;
                        x2:=trunc((xx-d1)*xymult);
                        y2:=hh-trunc((yy-d1)*xymult)-AY;
                        read2d(a1,a2,50,51); // angolo inzio e fine
                        a1:=2*PI-a1*PI/180;
                        a2:=2*PI-a2*PI/180;
                     end;
                     AddVObject(newobj);
                  end;
               end;
            end;
         9: // HEADER-$EXTMIN, HEADER-$EXTMAX
         	begin
            	if section=1 then begin
               	// siamo nell'HEADER, leggi variabili
                  if s2='$EXTMIN' then
                     read2d(XEXTMIN,YEXTMIN,10,20)
                  else if s2='$EXTMAX' then begin
                     read2d(XEXTMAX,YEXTMAX,10,20);
                     (*
                     xymult:=dmin((1/(XEXTMAX-XEXTMIN+1))*ww,(1/(YEXTMAX-YEXTMIN+1))*hh);
                     AY:=hh-trunc((YEXTMAX-YEXTMIN)*xymult);
                     *)
                     CalcCoef;
                  end;
               end;
            end;
      end;
   end;
   closefile(tf);
   except
   {$IfDef XE}
   assert(false);
   {$Else}
	   decimalseparator:=dc;
           {$EndIf}
      result:=false;
   end;
   {$IfDef XE}
   assert(false);
   {$Else}
   decimalseparator:=dc;
   {$EndIf}
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVect.GetSelObjects(idx:integer):integer;
begin
	if (idx>=0) and (idx<fSelObjCount) then
		result:=fSelObj^[idx]
   else
   	result:=0;
end;

// Rest. distanza tra il punto x,y e l'ellisse contenuta in x1,y1,x2,y2
// le coordinate x1,y1,x2,y2 devono essere già ordinate
// ATTENZIONE! SOLUZIONE TEMPORANEA - OTTIMIZZARE
function _DistPoint2Ellipse(x,y,x1,y1,x2,y2:integer):double;
var
	g,xr1,yr1,xr2,yr2,dx,dy,p:integer;
   d:double;
begin
	result:=2147483647;
	dx:=(x2-x1) shr 1;	// raggio x
   dy:=(y2-y1) shr 1;	// raggio y
   dec(x,x1+dx);
   dec(y,y1+dy);
   p:=trunc(2*pi*imin(dx,dy)) shr 3;
   xr1:=dx;
   yr1:=0;
   for g:=1 to p-1 do begin
   	xr2:=trunc(cos((2*pi/p)*g)*dx);
      yr2:=trunc(sin((2*pi/p)*g)*dy);
   	d:=_DistPoint2Seg(x,y,xr1,yr1,xr2,yr2);
      if d<result then
      	result:=d;
      xr1:=xr2;
      yr1:=yr2;
	end;
end;

procedure SetGrayPal(hdc:integer);
var
	pe:array [0..255] of TRGBQuad;
   i:integer;
begin
	for i:=0 to 255 do
   	with pe[i] do begin
      	rgbRed:=i;
         rgbGreen:=i;
         rgbBlue:=i;
         rgbReserved:=0;
      end;
   SetDibColorTable(hdc,0,256,pe);
end;

// draw all objects
// re: if true it doesn't look at zoom, viewxy, foffx and it doesn't verify that the object is inside the client area
procedure TImageEnVect.DrawObjectAll(re:boolean; BBitmap:TBitmap; antialias:boolean);
var
	o,c:integer;
   obj:PIEVObject;
   ww,hh,w,h:integer;
   lpencolor,lbrushcolor,lLabelBrushColor:TColor;
   tab1:ppointerarray;
   tab2,tab3:pinteger;
   x1,y1,x2,y2:integer;
   sz:integer;
   ax1,ay1,ax2,ay2:integer;
   mul:integer;
   antimul:integer; // 1=no antialias, 2=antialias (it is a multiplier)
begin
	if fAllObjectsHidden then
   	exit;
   mul:=1;
   if antialias then
   	antimul:=2
   else
   	antimul:=1;
   if fObjGraphicRender and (fObjCount>0) then begin
      ww:=BBitmap.Width * antimul;
      hh:=BBitmap.Height * antimul;
      if assigned(fCacheBitmap) and ((fCacheBitmap.Width<>ww) or (fCacheBitmap.Height<>hh)) then begin
      	fCacheBitmap.free;
         fCacheBitmap:=nil;
      end;
   	if not assigned(fCacheBitmap) then begin
	      fCacheBitmap:=TIEBitmap.Create;
	      fCacheBitmap.Location:=ieTBitmap;	// we need a canvas
         fCacheBitmap.Allocate(ww,hh,ie24RGB);
         fCacheBitmap.AlphaChannel.Location:=ieTBitmap;
         fCacheBitmap.AlphaChannel.PixelFormat:=ie8g;
         fCacheBitmap.AlphaChannel.VclBitmap.PixelFormat:=pf8bit;
         SetGrayPal( fCacheBitmap.AlphaChannel.VclBitmap.Canvas.Handle );
      end;
      tab1:=nil;
      mul:=mul*antimul;
		for o:=0 to fObjCount-1 do begin
      	obj:=GetObj(fObj[o]);
         fCacheBitmap.Fill(obj^.PenColor);
         if obj^.BoxHighlight then begin
            ax1:=VXBmp2Scr(obj^.x1,not re,mul);
			   ay1:=VYBmp2Scr(obj^.y1,not re,mul);
			   ax2:=VXBmp2Scr(obj^.x2+1,not re,mul);
   			ay2:=VYBmp2Scr(obj^.y2+1,not re,mul);
            fIEBitmap.StretchRectTo(fCacheBitmap,ax1,ay1,ax2-ax1+1,ay2-ay1+1, obj^.x1,obj^.y1,obj^.x2-obj^.x1+1,obj^.y2-obj^.y1+1 ,ZoomFilter,255);
         end;
         fCacheBitmap.AlphaChannel.Fill(0);

         if DrawObject(obj^,fCacheBitmap.VclBitmap,not re,not re,fCacheBitmap,mul,false) then begin
         	if (obj^.Kind<>iekBITMAP) then begin
               // makes alpha
               lpencolor:=obj^.PenColor;
               lbrushcolor:=obj^.BrushColor;
               lLabelBrushColor:=obj^.LabelBrushColor;
               c:=$02000000 or (obj^.Transparency) or (obj^.Transparency shl 8) or (obj^.Transparency shl 16);
               obj^.PenColor:=c;
               obj^.BrushColor:=c;
               obj^.LabelBrushColor:=c;
               DrawObject(obj^,fCacheBitmap.AlphaChannel.VclBitmap,not re,not re,nil,mul,true);
               obj^.PenColor:=lpencolor;
               obj^.BrushColor:=lbrushcolor;
               obj^.LabelBrushColor:=llabelbrushcolor;
            end;
            // adjust output coordinates
            x1:=imin(imax(obj.plim.Left-obj.pwidth,0),ww-1);
            y1:=imin(imax(obj.plim.Top-obj.pwidth,0),hh-1);
            x2:=imin(imax(obj.plim.Right+obj.pwidth,0),ww-1);
            y2:=imin(imax(obj.plim.Bottom+obj.pwidth,0),hh-1);
            OrdCor(x1,y1,x2,y2);
            w:=imin(x2-x1+1,ww);
            h:=imin(y2-y1+1,hh);
            // softshadow
            if obj^.softShadow.Enabled then begin
               sz:=_IEAddSoftShadowRect(fCacheBitmap,(obj^.softShadow.Radius*mul),(mul*obj^.softShadow.OffsetX),(mul*obj^.softShadow.OffsetY), x1,y1,x1+w-1,y1+h-1);
               (*
               // fast but less accurate
               _IEAddSoftShadowRect2(fCacheBitmap,trunc(obj^.softShadow.Radius*4*mul),80,(mul*obj^.softShadow.OffsetX),(mul*obj^.softShadow.OffsetY), x1,y1,x1+w-1,y1+h-1);
               sz:=trunc(obj^.softShadow.Radius*4*mul);
               //*)
               w:=imin(w+sz*2,fCacheBitmap.Width);
               h:=imin(h+sz*2,fCacheBitmap.Height);
               dec(x1,sz); if x1<0 then x1:=0;
               dec(y1,sz); if y1<0 then y1:=0;
            end;
            // draw on BBitmap
            tab2:=nil;
            tab3:=nil;
            fCacheBitmap.AlphaChannel.Full:=false;
            if antimul>1 then
	            fCacheBitmap.RenderToTBitmap(BBitmap,tab1,tab2,tab3,nil,x1 div antimul,y1 div antimul,w div antimul,h div antimul,x1,y1,w,h,true,false,255,rfTriangle,false,ielNormal)
            else
            	fCacheBitmap.RenderToTBitmap(BBitmap,tab1,tab2,tab3,nil,x1,y1,w,h,x1,y1,w,h,true,false,255,rfnone,false,ielNormal);
            freemem(tab2);
            freemem(tab3);
         end;
      end;

      freemem(tab1);
   end else begin
      for o:=0 to fObjCount-1 do
         DrawObject(GetObj(fObj^[o])^,BBitmap,not re,not re,nil,mul,false);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Draw a shape at the line sides, on the line x1,y1,x2,y2
// brush and color must be already set
procedure TImageEnVect.DrawLineShape(aobj:TIEVObject; Canvas:TCanvas;x1,y1,x2,y2:integer;Shape:TIEShape; w,h:integer; var plim:trect);
var
   aa,bb,hw:double;
   pp:array [0..2] of TPoint;
   p1x,p1y:integer;
begin
	case Shape of
   	iesINARROW, iesOUTARROW:
      	with Canvas do begin
         	hw:=w/2;
				aa:=ieangle(x1,y1,x2,y2,x1,y2);
            if x1=x2 then
            	if y1<y2 then
		            aa:=-A90
               else
               	aa:=A90;
            if ((x1>x2) and (y2<y1)) or ((x1<x2) and (y1<y2)) then
	            bb:=2*pi-aa+A90
            else
            	bb:=aa+A90;
            if ((x2<x1) and (y2>y1)) or ((x2<x1) and (y2<y1)) or ((x1<x2) and (y1=y2)) then begin
					p1x:=x1+trunc(cos(bb-A90)*h);
	            p1y:=y1+trunc(sin(bb-A90)*h);
            end else begin
					p1x:=x1+trunc(cos(bb+A90)*h);
	            p1y:=y1+trunc(sin(bb+A90)*h);
				end;
            if Shape=iesINARROW then begin
               pp[0].x:=x1+trunc(cos(bb)*hw);
               pp[0].y:=y1+trunc(sin(bb)*hw);
               pp[1].x:=x1+trunc(cos(bb+pi)*hw);
               pp[1].y:=y1+trunc(sin(bb+pi)*hw);
               pp[2].x:=p1x;
               pp[2].y:=p1y;
            end else begin
               pp[0].x:=p1x+trunc(cos(bb)*hw);
               pp[0].y:=p1y+trunc(sin(bb)*hw);
               pp[1].x:=p1x+trunc(cos(bb+pi)*hw);
               pp[1].y:=p1y+trunc(sin(bb+pi)*hw);
               pp[2].x:=x1;
               pp[2].y:=y1;
            end;
            Polygon(pp);
            iesetplim(plim,pp[0].x,pp[0].y);
            iesetplim(plim,pp[1].x,pp[1].y);
            iesetplim(plim,pp[2].x,pp[2].y);
         end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Restituisce la bitmap idx della lista fBitmaps
// Se idx=-1 rest. nil
function TImageEnVect.GetBitmap(idx:integer):TIEBitmap;
begin
	if idx>=0 then
		result:=fBitmaps^[idx].fBitmap
   else
   	result:=nil;
end;

//
function TImageEnVect.GetBitmapAlpha(idx:integer):TIEBitmap;
begin
	if idx>=0 then
		result:=fBitmaps^[idx].fBitmap.AlphaChannel
   else
   	result:=nil;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Cerca SBitmap all'interno della lista fBitmaps
// -1 nulla
function TImageEnVect.FindBitmap(SBitmap:TIEBitmap):integer;
begin
	for result:=fBitmapsCount-1 downto 0 do
		if (fBitmaps^[result].fBitmap<>nil) and _BitmapCompareXEx(SBitmap,fBitmaps^[result].fBitmap) then
      	exit;	// found
	result:=-1;	// not found
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SaveToFileIEV(const nf:AnsiString);
var
	fs:TFileStream;
begin
	fs:=TFileStream.Create(nf,fmCreate);
	SaveToStreamIEV(fs);
   fs.free;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVect.LoadFromFileIEV(const nf:AnsiString):boolean;
var
	fs:TFileStream;
begin
	fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
	result:=LoadFromStreamIEV(fs);
   fs.free;
end;

/////////////////////////////////////////////////////////////////////////////////////
// removes all null occurrences to fBitmaps and reindicizes all iekBITMAP objects
procedure TImageEnVect.PackBMP;
var
	corr:PIntegerArray;
   //
   procedure PackBMP1(hobj:integer);
   begin
      with GetObj(hobj)^ do
         if BitmapIdx>=0 then
            // -1 means no bitmap
            BitmapIdx:=corr^[ BitmapIdx ];
   end;
var
   num:integer;
   tmp:PIEVBitmapArray;
   q:integer;
begin
	getmem(corr,sizeof(integer)*fBitmapsCount);
   // create corrispondences table
   num:=0;
   for q:=0 to fBitmapsCount-1 do
		if fBitmaps^[q].fBitmap<>nil then begin
         corr^[q]:=num;
      	inc(num);
      end;
   getmem(tmp,sizeof(TIEVBitmap)*num);
   // Compact fBitmaps
   for q:=0 to fBitmapsCount-1 do
		if fBitmaps^[q].fBitmap<>nil then
      	tmp^[ corr^[q] ] := fBitmaps^[q];
   freemem(fBitmaps);
   fBitmaps:=tmp;
   fBitmapsCount:=num;
   // adjust pointers to iekBITMAP
	PackBMP1(-1);	// next obj to insert
   for q:=0 to fObjCount-1 do
   	PackBmp1(fObj^[q]);
   //
   freemem(corr);
end;

/////////////////////////////////////////////////////////////////////////////////////
// remove the object and its data
// call Update
procedure TImageEnVect.RemoveObject(hobj:integer);
var
	pobj:PIEVObject;
begin
	CancelInteracts;
   if fObjAutoUndo then
   	ObjSaveUndo;
	UnSelObject(hobj);
	pobj:=GetObj(hobj);
   RemoveVObjData(pobj^);	// remove object data
   RemoveVObject(hobj);  // remove object
   if hobj=fObjHeapCount-1 then
   	// decrease the heap (but it doesn't realloc), because it is last object inserted
      dec(fObjHeapCount);
   DoVectorialChanged;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetObjFontAngle(hobj:integer; v:double);
begin
	with GetObj(hobj)^ do
   	if LogFont<>nil then
	   	LogFont^.lfEscapement:=trunc(v*10);
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVect.GetObjFontHeight(hobj:integer):integer;
begin
	with GetObj(hobj)^ do
   	if LogFont<>nil then
	   	result:=LogFont^.lfHeight
      else
      	result:=0;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetObjTextAlign(hobj:integer; v:TIEAlignment);
begin
	with GetObj(hobj)^ do
   	TextAlign:=v;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVect.GetObjTextAlign(hobj:integer):TIEAlignment;
begin
	with GetObj(hobj)^ do
   	result:=TextAlign;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetObjTextAutoSize(hobj:integer; v:boolean);
begin
	with GetObj(hobj)^ do
   	TextAutoSize:=v;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVect.GetObjTextAutoSize(hobj:integer):boolean;
begin
	with GetObj(hobj)^ do
   	result:=TextAutoSize;
end;

procedure TImageEnVect.SetObjTextCurveCharRot(hobj:integer; v:double);
begin
	with GetObj(hobj)^ do
   	CurvedCharRot:=trunc(v*10);
   if hobj<>-1 then
   	Update;
end;

function TImageEnVect.GetObjTextCurveCharRot(hobj:integer):double;
begin
	with GetObj(hobj)^ do
   	result:=CurvedCharRot/10;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetObjMemoLineSpace(hobj:integer; v:integer);
begin
	with GetObj(hobj)^ do
   	LineSpace:=v;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVect.GetObjMemoLineSpace(hobj:integer):integer;
begin
	with GetObj(hobj)^ do
   	result:=LineSpace;
end;


/////////////////////////////////////////////////////////////////////////////////////
// v=0 indica di stretchare il font all'interno del rettangolo contenitore
procedure TImageEnVect.SetObjFontHeight(hobj:integer; v:integer);
begin
	with GetObj(hobj)^ do
   	if LogFont<>nil then
	   	LogFont^.lfHeight:=v;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVect.GetObjFontName(hobj:integer):AnsiString;
begin
	with GetObj(hobj)^ do
   	if LogFont<>nil then
	   	result:=LogFont^.lfFaceName
      else
      	result:='';
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetObjFontName(hobj:integer; v:AnsiString);
begin
	with GetObj(hobj)^ do
   	if LogFont<>nil then
	   	strpcopy(LogFont^.lfFaceName,copy(v,1,LF_FACESIZE-1)); // strpcopy make sure that other charachetrs are ignored
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVect.GetObjFontStyles(hobj:integer):TFontStyles;
begin
	with GetObj(hobj)^ do
   	result:=IEExtractStylesFromLogFont(LogFont);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetObjFontStyles(hobj:integer; v:TFontStyles);
begin
	with GetObj(hobj)^ do
   	if LogFont<>nil then
      	with LogFont^ do begin
            if fsBold in v then
               lfWeight:=FW_BOLD
            else
               lfWeight:=FW_NORMAL;
            lfItalic := Byte(fsItalic in v);
            lfUnderline := Byte(fsUnderline in v);
            lfStrikeOut := Byte(fsStrikeOut in v);
         end;
   if hobj<>-1 then
	   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.Update;
begin
	inherited;
	UpdateTextEdit;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.ViewChange(c:integer);
begin
	inherited;
   if fTextEditing>=0 then begin
	   RemoveTextEdit;
      ActiveTextEdit;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Save object to Stream
procedure TImageEnVect.SaveObj(Stream:TStream; hobj:integer);
var
   i,w,l:integer;
   o:PIEVObject;
   b:boolean;
begin
   o:=GetObj(hobj);
   if o=nil then begin
      // Saves all objects
      for w:=0 to fObjCount-1 do
         SaveObj(Stream,fObj^[w]);
   end else begin
      // Save object
      if hobj>=0 then
         with o^ do begin
            // general info
            Stream.Write(hobj,sizeof(integer));	// used only for connected objects
            Stream.Write(x1,sizeof(integer));
            Stream.Write(y1,sizeof(integer));
            Stream.Write(x2,sizeof(integer));
            Stream.Write(y2,sizeof(integer));
            Stream.Write(Kind,sizeof(TIEVObjectKind));
            // softshadow
            Stream.Write(softShadow.Enabled,sizeof(boolean));
            Stream.Write(softShadow.Radius,sizeof(double));
            Stream.Write(softShadow.OffsetX,sizeof(integer));
            Stream.Write(softShadow.OffsetY,sizeof(integer));
            // Name
            w:=strlen(Name);
            Stream.Write(w,sizeof(integer));
            Stream.Write(Name^,w);
            //
            Stream.Write(ID,sizeof(integer));
            Stream.Write(PenColor,sizeof(TColor));
            Stream.Write(PenStyle,sizeof(TPenStyle));
            Stream.Write(PenWidth,sizeof(integer));
            Stream.Write(BrushColor,sizeof(TColor));
            Stream.Write(BrushStyle,sizeof(TBrushStyle));
            Stream.Write(Style,sizeof(TIEVStyle));
            Stream.Write(Transparency,sizeof(integer));
            Stream.Write(BoxHighLight,sizeof(boolean));
				// iekLINELABEL
            if Kind=iekLINELABEL then begin
            	Stream.Write(LabelBrushColor,sizeof(TColor));
            	Stream.Write(LabelBrushStyle,sizeof(TBrushStyle));
               Stream.Write(LabelPosition,sizeof(TIELabelPos));
				end;
            // iekLINE/iekLINELABEL fields
            if (Kind=iekLINE) or (Kind=iekLINELABEL) then begin
               Stream.Write(BeginShape,sizeof(TIEShape));
               Stream.Write(EndShape,sizeof(TIEShape));
               Stream.Write(ShapeWidth,sizeof(integer));
               Stream.Write(ShapeHeight,sizeof(integer));
            end;
            // iekARC fields
            if Kind=iekARC then begin
               Stream.Write(a1,sizeof(double));
               Stream.Write(a2,sizeof(double));
            end;
            // iekBITMAP fields
            if Kind=iekBITMAP then
               Stream.Write(BitmapIdx,sizeof(integer));
            // iekTEXT/iekLINELABEL fields
            if (Kind=iekTEXT) or (Kind=iekLINELABEL) then begin
               Stream.Write(TextAlign,sizeof(TIEAlignment));
               Stream.Write(TextAutoSize,sizeof(boolean));
               // save text
               w:=strlen(Text);
               Stream.Write(w,sizeof(integer));	// AnsiString length (without final zero)
               Stream.Write(Text^,w);  // save AnsiString (no final zero)
               // save font
               if LogFont<>nil then begin
                  b:=true; Stream.Write(b,sizeof(boolean));
                  Stream.Write(LogFont^,sizeof(TLogFont));
               end else begin
                  b:=false; Stream.Write(b,sizeof(boolean));
               end;
               //
               Stream.Write(CurvedLen,sizeof(integer));
               if CurvedLen>0 then begin
                  Stream.Write(CurvedPos[0],sizeof(TDPoint)*CurvedLen);
                  Stream.Write(CurvedCharRot,sizeof(integer));
               end;
            end;
            // iekMEMO fields
            if Kind=iekMEMO then begin
            	if Text=nil then
               	w:=0
               else
            		w:=strlen(Text);
               Stream.Write(w,sizeof(integer));
               if Text<>nil then
	               Stream.Write(Text^,w);
               // save font
               if LogFont<>nil then begin
                  b:=true; Stream.Write(b,sizeof(boolean));
                  Stream.Write(LogFont^,sizeof(TLogFont));
               end else begin
                  b:=false; Stream.Write(b,sizeof(boolean));
               end;
               // save format
               Stream.Write(TextFormatRef^,sizeof(integer)*w);
               l:=TextFormat.Count;
               Stream.Write(l,sizeof(integer));
					for i:=0 to l-1 do
						Stream.Write(PIECharInfo(TextFormat[i])^,sizeof(TIECharInfo));
               Stream.Write(FontLocked,sizeof(boolean));
               Stream.Write(TextAutoSize,sizeof(boolean));
               Stream.Write(LineSpace,sizeof(integer));
               Stream.Write(MemoBorderColor,sizeof(TColor));
               Stream.Write(MemoBorderStyle,sizeof(TPenStyle));
               Stream.Write(TextAlign,sizeof(TIEAlignment));
               Stream.Write(MemoFixedHeight,sizeof(integer));
            end;
            // iekRULER fields
            if Kind=iekRULER then begin
               Stream.Write(RulerUnit,sizeof(TIEUnits));
               Stream.Write(RulerType,sizeof(TIEVRulerType));
               // save font
               if LogFont<>nil then begin
                  b:=true; Stream.Write(b,sizeof(boolean));
                  Stream.Write(LogFont^,sizeof(TLogFont));
               end else begin
                  b:=false; Stream.Write(b,sizeof(boolean));
               end;
            end;
            // iekPOLYLINE fields
            if Kind=iekPOLYLINE then begin
            	Stream.Write(PolyPointsCount,sizeof(integer));
               Stream.Write(pbyte(PolyPoints)^,sizeof(TPoint)*PolyPointsCount);
               Stream.Write(PolyBaseX1,sizeof(integer));
               Stream.Write(PolyBaseY1,sizeof(integer));
               Stream.Write(PolyBaseX2,sizeof(integer));
               Stream.Write(PolyBaseY2,sizeof(integer));
               Stream.Write(PolyClosed,sizeof(boolean));
            end;
            // iekANGLE fields
            if Kind=iekANGLE then begin
            	Stream.Write(AnglePoints[0],sizeof(TPoint)*3);
            end;
         end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Load objects from stream
// Supported ver (last byte of old ver AnsiString)
// 49 = IEV1
// 50 = IEV2
// 51 = IEV3
// 52 = IEV4
// 53 = IEV5
// 54 = IEV6
// 55 = IEV7
// 56 = IEV8
// 57 = IEV9
// 58
// 59 (ver 2.0.8)
// 60 (ver 2.0.9)
// 61 (ver 2.1.0)
// 62 (ver 2.1.1 - a)
// 63 (ver 2.1.1 - b)
// 64 (ver 2.1.1 - release)
// 65 (ver 2.1.4)
// LoadBitmapIdx: if true read BitmaPidx from file, otherwise set it to -1
// return the obj created handle (or -4 if no applicable)
function TImageEnVect.ReadObj(Stream:TStream; ver:byte; LoadBitmapIdx:boolean):integer;
var
   o:TIEVObject;
   i,q:integer;
   b:boolean;
   ObjCount:integer;
   filehobj:integer;
   ci:PIECharInfo;
begin
	result:=-4;
	with o do begin
   	TextFormatRef:=nil;
      TextFormat:=nil;
      FontLocked:=true;
      CurvedLen:=0;
      CurvedPos:=nil;
      BoxHighLight:=false;
      DrawnPoints:=nil;
      DrawnPointsCount:=0;
      // general fields
      if ver>=60 then
      	Stream.read(filehobj,sizeof(integer));	// the original saved hobj (not the current hobj)
      Stream.read(x1,sizeof(integer));
      Stream.read(y1,sizeof(integer));
      Stream.read(x2,sizeof(integer));
      Stream.read(y2,sizeof(integer));
      Stream.read(Kind,sizeof(TIEVObjectKind));
      // softshadow
      softShadow:=TIEVSoftShadow.Create;
      if ver>=61 then begin
         Stream.Read(softShadow.Enabled,sizeof(boolean));
         Stream.Read(softShadow.Radius,sizeof(double));
         Stream.Read(softShadow.OffsetX,sizeof(integer));
         Stream.Read(softShadow.OffsetY,sizeof(integer));
      end else begin
         with softShadow do begin
            Enabled:=false;
            Radius:=3;
            OffsetX:=2;
            OffsetY:=2;
         end;
		end;
      // Name
      Stream.Read(q,sizeof(integer));	// read AnsiString length (excluded final zero)
      getmem(Name,q+1);
      Stream.Read(Name^,q);
      Name[q]:=#0;
      //
      Stream.read(ID,sizeof(integer));
      Stream.read(PenColor,sizeof(TColor));
      Stream.read(PenStyle,sizeof(TPenStyle));
      Stream.read(PenWidth,sizeof(integer));
      Stream.read(BrushColor,sizeof(TColor));
      Stream.read(BrushStyle,sizeof(TBrushStyle));
      Stream.read(Style,sizeof(TIEVStyle));
      if ver>=61 then
      	Stream.Read(Transparency,sizeof(integer));
      if ver>=64 then
      	Stream.Read(BoxHighLight,sizeof(boolean));
      // old iekFRAME fields
      if Kind=iekNONE then
         Stream.read(ObjCount,sizeof(integer));
      // iekLINELABEL
      if Kind=iekLINELABEL then begin
         Stream.read(LabelBrushColor,sizeof(TColor));
         Stream.read(LabelBrushStyle,sizeof(TBrushStyle));
         Stream.read(LabelPosition,sizeof(TIELabelPos));
      end;
      // iekLINE/iekLINELABEL fields
      if (Kind=iekLINE) or (Kind=iekLINELABEL) then begin
         Stream.read(BeginShape,sizeof(TIEShape));
         Stream.read(EndShape,sizeof(TIEShape));
         Stream.read(ShapeWidth,sizeof(integer));
         Stream.read(ShapeHeight,sizeof(integer));
      end;
      // iekARC fields
      if Kind=iekARC then begin
         Stream.read(a1,sizeof(double));
         Stream.read(a2,sizeof(double));
      end;
      // iekBITMAP fields
      if Kind=iekBITMAP then begin
      	Stream.read(BitmapIdx,sizeof(integer));
      	if not LoadBitmapIdx then
         	BitmapIdx:=-1;
      end;
      // iekTEXT/iekLINELABEL fields
      if (Kind=iekTEXT) or (Kind=iekLINELABEL) then begin
      	if ver>=52 then
	      	Stream.read(TextAlign,sizeof(TIEAlignment));
         if ver>=57 then
            Stream.read(TextAutoSize,sizeof(boolean));
         // allocate and read iekTEXT/iekLINELABEL fields
         Stream.Read(q,sizeof(integer));	// read AnsiString length (without ending zero)
         getmem(text,q+1);
         Stream.Read(Text^,q);
         Text[q]:=#0;
         Stream.Read(b,sizeof(boolean));
         if b then begin
            getmem(LogFont,sizeof(TLogFont));
            Stream.Read(LogFont^,sizeof(TLogFont));
         end;
         if ver>=63 then begin
         	Stream.Read(CurvedLen,sizeof(integer));
            if CurvedLen>0 then begin
               getmem(CurvedPos,sizeof(TDPoint)*CurvedLen);
               Stream.Read(CurvedPos[0],sizeof(TDPoint)*CurvedLen);
               Stream.Read(CurvedCharRot,sizeof(integer));
            end else begin
            	CurvedPos:=nil;
               CurvedCharRot:=-1;
            end;
         end;
      end;
      // iekMEMO fields
      if Kind=iekMEMO then begin
         Stream.Read(q,sizeof(integer));
         getmem(text,q+1);
         Stream.Read(Text^,q);
         Text[q]:=#0;
         Stream.Read(b,sizeof(boolean));
         if b then begin
            getmem(LogFont,sizeof(TLogFont));
            Stream.Read(LogFont^,sizeof(TLogFont));
         end;
         TextFormat:=nil;
         TextFormatRef:=nil;
         getmem(TextFormatRef,sizeof(integer)*(q+1));
         Stream.Read(TextFormatRef^,sizeof(integer)*q);
         Stream.Read(q,sizeof(integer));
         TextFormat:=TList.Create;
         for i:=0 to q-1 do begin
            getmem(ci,sizeof(TIECharInfo));
            Stream.Read(ci^,sizeof(TIECharInfo));
            TextFormat.Add(ci);
         end;
         Stream.read(FontLocked,sizeof(boolean));
         Stream.read(TextAutoSize,sizeof(boolean));
         Stream.read(LineSpace,sizeof(integer));
         Stream.Read(MemoBorderColor,sizeof(TColor));
         Stream.Read(MemoBorderStyle,sizeof(TPenStyle));
         Stream.read(TextAlign,sizeof(TIEAlignment));
         Stream.read(MemoFixedHeight,sizeof(integer));
      end;
      // iekRULER fields
      if Kind=iekRULER then
      	if ver>=53 then begin
         	Stream.Read(RulerUnit,sizeof(TIEUnits));
            Stream.Read(RulerType,sizeof(TIEVRulerType));
            getmem(LogFont,sizeof(TLogFont));
            b:=false;
            if ver>=65 then begin
               Stream.Read(b,sizeof(boolean));
               if b then
                  Stream.Read(LogFont^,sizeof(TLogFont));
            end;
            if not b then begin
               copymemory(LogFont,fNewObj.LogFont,sizeof(TLogFont));
               LogFont^.lfHeight:=12;
               LogFont^.lfFaceName:='Arial';
            end;
         end;
      // iekPOLYLINE fields
      if Kind=iekPOLYLINE then begin
			if ver>=56 then begin
            Stream.Read(PolyPointsCount,sizeof(integer));
            getmem(PolyPoints,sizeof(TPoint)*PolyPointsCount);
            Stream.Read(pbyte(PolyPoints)^,sizeof(TPoint)*PolyPointsCount);
            Stream.Read(PolyBaseX1,sizeof(integer));
            Stream.Read(PolyBaseY1,sizeof(integer));
            Stream.Read(PolyBaseX2,sizeof(integer));
            Stream.Read(PolyBaseY2,sizeof(integer));
            if ver>=59 then
            	Stream.Read(PolyClosed,sizeof(boolean));
         end else begin
            PolyPoints:=nil;
            PolyPointsCount:=0;
            PolyBaseX1:=0;
            PolyBaseY1:=0;
            PolyBaseX2:=0;
            PolyBaseY2:=0;
            PolyClosed:=false;
         end;
      end;
      // iekANGLE fields
      if Kind=iekANGLE then begin
      	if ver>=58 then begin
         	Stream.Read(AnglePoints[0],sizeof(TPoint)*3);
         end;
      end;
      //
      if Kind=iekNONE then begin
         for q:=0 to ObjCount-1 do
            ReadObj(Stream,ver,true);
      end else begin
         result:=AddVObject(o);
         // free temporaney fields (because AddVObject make a copy of them)
         if (Kind=iekTEXT) or (Kind=iekMEMO) or (Kind=iekLINELABEL) then begin
            freemem(Text);
            freemem(LogFont);
            if TextFormatRef<>nil then
            	freemem(TextFormatRef);
            if TextFormat<>nil then begin
               while TextFormat.Count>0 do begin
                  freemem( TextFormat[ TextFormat.Count-1 ] );
                  TextFormat.Delete( TextFormat.Count-1 );
               end;
            end;
            TextFormat.free;
            if CurvedPos<>nil then
            	freemem(CurvedPos);
         end;
         if (Kind=iekRULER) and (LogFont<>nil) then
         	freemem(LogFont);
         freemem(Name);
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// stream format:
//    3 AnsiChar   : 'IEV' magic AnsiString
//    1 byte   : version number (starting from 51)
//    DWORD    : dimensione del file (da 'IEV') in byte
//    QWORD    : fattore di scala (double)
//    DWORD    : numero bitmap (inclusa quella di newobj, il cui reference sarà decrementato)
//    ....     : bitmaps (formato BMP)
//    DWORD    : numero oggetti presenti
//    ....     : oggetti
// Questa funzione esegue un PackBMP prima del salvataggio per eliminare bitmap vuote
// all'interno di fBitmaps.
procedure TImageEnVect.SaveToStreamIEV(Stream:TStream);
var
	p1,p2:integer;
   dw:DWORD;
   q,rf:integer;
   fImageEnIO:TImageEnIO;
   LZStream:TZCompressionStream;
begin
	PackBMP;	// impacchetta le bitmap
	p1:=Stream.Position;	// posizione
   Stream.Write(IEVMAGIC,3); // Magic
	Stream.Write(IEVVER,1);	 // version
	Stream.Write(dw,sizeof(integer));	// salta dimensione file
   Stream.Write(fScale,sizeof(double)); // fattore di scala
   // save bitmaps
   Stream.Write(fBitmapsCount,sizeof(integer));	// numero bitmaps
  	fImageEnIO:=TImageEnIO.Create(self);
   for q:=0 to fBitmapsCount-1 do begin
   	rf:=fBitmaps^[q].fRefCount;
      if q=fNewObj.BitmapIdx then
      	dec(rf);	// non salvare la bitmap se è usata da fNewObj
   	Stream.Write(rf,sizeof(integer));	// reference count
      // salva solo se reference è >0
      if rf>0 then begin
			fImageEnIO.AttachedIEBitmap:=fBitmaps^[q].fBitmap;
         {$ifdef IEINCLUDEPNG}
	      fImageEnIO.SaveToStreamPNG(Stream);	// bitmap
         {$else}
         fImageEnIO.SaveToStreamBMP(Stream);
         {$endif}
      end;
	end;
   fImageEnIO.free;
   // salva oggetti
  	LZStream:=TZCompressionStream.Create(Stream,zcDefault);
   LZStream.Write(fObjCount,sizeof(integer)); // numero oggetti
   SaveObj(LZStream,-3);
   LZStream.free;
   //
   p2:=Stream.Position;	// posizione fine stream
   Stream.Position:=p1+sizeof(integer);	// posizione su dimensione file
   q:=p2-p1; Stream.Write(q,sizeof(integer));	// salva dimensione file
   Stream.Position:=p2;	// posizione su fine stream
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVect.LoadFromStreamIEV(Stream:TStream):boolean;
var
	magic:array [0..2] of AnsiChar;
   ver:byte;
   dm:integer;	// dim file
   no:integer;	// num oggetti
   q,w,ii,i:integer;
   lfs:boolean;
   fImageEnIO:TImageEnIO;
   predbmp:TIEBitmap;
   ms:TMemoryStream;
   LZStream:TZDecompressionStream;
begin
	Stream.Read(magic,3);	// read magic
   Stream.Read(ver,1);	// read versione
	if (magic<>'IEV') or (ver<49) or (ver>IEVVER) then begin
      result:=false;
      exit;
   end;
	result:=true;
	lfs:=fShareBitmaps;
   fShareBitmaps:=True;
   if fNewObj.BitmapIdx>=0 then begin
   	// salvo bitmap nuovo oggetto
	   predbmp:=TIEBitmap.Create;
		predbmp.Assign(fBitmaps^[fNewObj.BitmapIdx].fBitmap);
      // remove bitmap of new object
      SetObjBitmapNU(-1,nil);
   end else
   	predbmp:=nil;
	RemoveAllObjects;
	Stream.Read(dm,sizeof(integer));	// dimensione file
   if ver=49 then begin
		Stream.Read(q,sizeof(integer));	// fattore di scala
      fScale:=q;
   end else
		Stream.Read(fScale,sizeof(double));	// fattore di scala
   // read images
   fImageEnIO:=TImageEnIO.Create(self);
   Stream.Read(fBitmapsCount,sizeof(integer));	// numero bitmaps
   fBitmaps:=allocmem(sizeof(TIEVBitmap)*fBitmapsCount); // init a ZERO
   for q:=0 to fBitmapsCount-1 do begin
		Stream.Read(w,sizeof(integer));	// reference count
      if w>0 then begin
      	fBitmaps^[q].fBitmap:=TIEBitmap.Create;
         fImageEnIO.AttachedIEBitmap:=fBitmaps^[q].fBitmap;
         if ver<=50 then
	         fImageEnIO.LoadFromStreamBMP(Stream)
         else
            {$ifdef IEINCLUDEPNG}
				fImageEnIO.LoadFromStreamPNG(Stream);
            {$else}
            fImageEnIO.LoadFromStreamBMP(Stream);
            {$endif}
         if ver<61 then begin
         	// old versions still load the alpha separated by the bitmap
            if ver>=55 then begin
               // load alpha channel
               Stream.Read(ii,sizeof(integer));
               ms:=TMemoryStream.Create;
               ms.CopyFrom(Stream,ii);
               ms.position:=0;
               LZStream:=TZDecompressionStream.Create(ms);
               for i:=fBitmaps^[q].fBitmap.AlphaChannel.Height-1 downto 0 do
               	LZStream.Read((fBitmaps^[q].fBitmap.AlphaChannel.Scanline[i])^,fBitmaps^[q].fBitmap.AlphaChannel.Rowlen);
               LZStream.free;
               ms.free;
            end;
         end;
         // Il reference count della bitmap deve essere comunque a zero.
         // Ci penserà ReadOBj ad incrementarlo.
      end;
   end;
   fImageEnIO.free;
   // read objects
   LZStream:=TZDecompressionStream.Create(Stream);
   LZStream.Read(no,sizeof(integer));	// objects count
   for q:=0 to no-1 do
      ReadObj(LZStream,ver,true);
   LZStream.free;
   //
   fShareBitmaps:=lfs;
   if predbmp<>nil then begin
		// restore new object bitmap
      SetObjBitmapNU(-1,predbmp);
      predbmp.free;
   end;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SubMouseMoveScroll(scx,scy:integer);
begin
	inherited;
   dec(fVMoveX,scx);
   dec(fVMoveY,scy);
end;

procedure TImageEnVect.CopyObjectsToBack(Antialias:boolean);
begin
   DrawObjectsToBitmap(IEBitmap,Antialias);
end;

procedure TImageEnVect.DrawObjectsToBitmap(target:TIEBitmap; Antialias:boolean);
(*
const
	MUL=2;
var
	proc:TImageEnProc;
   *)
begin
	target.Location:=ieTBitmap;	// we need a canvas
   (*
	if antialias then begin
   	// antialias
      proc:=TImageEnProc.Create(nil);
      proc.AttachedIEBitmap:=target;
      proc.Resample(target.Width*MUL,target.Height*MUL,rfNone);
      DrawObjectAll(true,target.VclBitmap,MUL);
      proc.Resample(target.Width div MUL, target.Height div MUL, rfLanczos3);
      proc.free;
   end else begin
   *)
      DrawObjectAll(true,target.VclBitmap,Antialias);
   //end;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetScale(v:double);
begin
	fScale:=v;
   CalcCoef(fCoefX,fCoefY,fMUnit);
   UpdateHint(-1000000,-1000000);
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Forza fScale affinchè px (pixels) misurino mm (fMUnit)
// Al forcing non influisce lo zoom
procedure TImageEnVect.SetScaleFromPixels(px:integer; mm:double);
begin
	SetScale((mm/px)/(fCoefX/fScale));
end;

/////////////////////////////////////////////////////////////////////////////////////
// Forza fScale affinchè la lunghezza della selezione corrente misuri mm (fMUnit)
procedure TIMageEnVect.SetScaleFromSelectionLen(mm:double);
var
	sl:double;
   cx,cy:double;
begin
	cx:=fCoefX; cy:=fCoefY;
   fCoefX:=1; fCoefY:=1;
	sl:=GetSelectionLen;	// misura in pixel
   fCoefX:=cx; fCoefY:=cy;
	SetScaleFromPixels(round(sl),mm);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVect.GetMouseInteract:TIEMouseInteractVt;
begin
	result:=fMouseInteractVt;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Trova l'oggetto con il nome specificato
// Rest. -1 se oggetto non trovato
function TImageEnVect.GetObjFromName(const oName:AnsiString):integer;
var
	w:integer;
begin
	result:=-1;
   for w:=0 to fObjCount-1 do begin
   	if GetObj(fObj^[w]).name=oName then
	      result:=fObj^[w];
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Trova l'oggetto con l'ID specificato
// Rest. -1 se oggetto non trovato
function TImageEnVect.GetObjFromID(oID:integer):integer;
var
	w:integer;
begin
	result:=-1;
   for w:=0 to fObjCount-1 do begin
   	if GetObj(fObj^[w]).id=oId then
	      result:=fObj^[w];
   end;
end;

function TImageEnVect.GetObjFromIndex(idx:integer):integer;
begin
   if (idx>=0) and (idx<fObjCount) then
      result:=fObj^[idx]
   else
      result:=-1;
end;

/////////////////////////////////////////////////////////////////////////////////////
// return hobj index
function TImageEnVect.GetObjPos(hobj:integer):integer;
begin
   for result:=0 to fObjCount-1 do
   	if fObj^[result]=hobj then
      	exit;
   result:=-1;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Insert an existing object (useful for moving tasks)
procedure TImageEnVect.ReInsertVObject(hobj:integer; pos:integer);
var
	tmp:pintegerarray;
begin
	// ridimensiona array
   if (fObjCount mod ALLOCBLOCK)=0 then begin
		getmem(tmp,sizeof(integer)*(fObjCount+ALLOCBLOCK+10));
	   copymemory(tmp,fObj,sizeof(integer)*fObjCount);
	   freemem(fObj);
	   fObj:=tmp;
   end;
   // Inserisce oggetto nella posizione "pos"
   move( pbyte(integer(fObj)+sizeof(integer)*(pos))^,
   	   pbyte(integer(fObj)+sizeof(integer)*(pos+1))^,
         sizeof(integer)*(fObjCount-pos) );
   inc(fObjCount);
   fObj^[pos]:=hobj;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Muove hobj di una posizione dopo di refobj
// Se refobj=-1 muove difronte a tutti
procedure TImageEnVect.SetObjFrontOf(hobj:integer; refobj:integer);
var
   inspos:integer;
begin
	RemoveVObject(hobj);	// remove hobj
   if refobj>=0 then begin
		inspos:=GetObjPos(refobj);
      ReInsertVObject(hobj,inspos+1);
   end else
   	ReInsertVObject(hobj,fObjCount);
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Muove hobj di una posizione prima di refobj 
procedure TImageEnVect.SetObjBackTo(hobj:integer; refobj:integer);
var
   inspos:integer;
begin
	RemoveVObject(hobj);	// remove hobj
   if refobj>=0 then begin
		inspos:=GetObjPos(refobj);
      ReInsertVObject(hobj,inspos);
   end else begin
   	ReInsertVObject(hobj,0);
   end;
   Update;
end;

procedure TImageEnVect.SetAllObjectsHidden(Value: boolean);
begin
	if Value <> fAllObjectsHidden	then begin
		fAllObjectsHidden := value;
		Repaint;
	end;
end;

procedure TImageEnVect.SetZoomObjectsWidth(Value:boolean);
begin
	fZoomObjectsWidth:=Value;
   Update;
end;

procedure TImageEnVect.KeyDown(var Key: Word; Shift: TShiftState);
begin
	case Key of
		VK_F2:
      	begin
            if fSelObjCount > 0 then
               if (GetObj(fSelObj^[0])^.Kind=iekTEXT) or (GetObj(fSelObj^[0])^.Kind=iekMEMO) then begin
                  fTextEditing := fSelObj^[0];
                  ActiveTextEdit;
               end;
	      end;
		VK_ESCAPE:
      	begin
            RemoveTextEdit;
            fTextEditing := -1;
			end;
	end;
	inherited;
end;

// return the rect that contains all objects
function TImageEnVect.GetObjectsExtents:TRect;
var
   o:integer;
begin
	result:=Rect(0,0,0,0);
   for o:=0 to fObjCount-1 do begin
   	with GetObj(fObj^[o])^ do begin
         result.Right:=imax(result.Right,imax(x1,x2)+1);
         result.Bottom:=imax(result.Bottom,imax(y1,y2)+1);
		end;
   end;
end;

function TImageEnVect.CountAnglePoints(AnglePoints:array of TPoint):integer;
var
   i:integer;
begin
   result:=0;
   for i:=0 to 2 do
      if AnglePoints[i].x=-1000000 then
         break
      else
         inc(result);
end;

function ccw(x0,y0,x1,y1,x2,y2:integer):integer;
var
	dx1,dx2,dy1,dy2:integer;
begin
	dx1:=x1-x0; dy1:=y1-y0;
   dx2:=x2-x0; dy2:=y2-y0;
   if dx1*dy2 > dy1*dx2 then result:=1
   else if dx1*dy2 < dy1*dx2 then result:=-1
   else if (dx1*dx2<0) or (dy1*dy2<0) then result:=-1
   else if (dx1*dx1+dy1*dy1) < (dx2*dx2+dy2*dy2) then result:=1
	else result:=0;
end;

function _angle3(x1,y1,xc,yc,x2,y2:integer):double;
var
	a,b,c:double;
begin
	// a is (xc,yc)-(x2,y2)
   // b is (x1,y1)-(x2,y2)
   // c is (xc,yc)-(x1,y1)
	a := sqrt(sqr(x2 - xc) + sqr(y2 - yc)); if a=0 then a:=1;
	b := sqrt(sqr(x2 - x1) + sqr(y2 - y1)); if b=0 then b:=1;
	c := sqrt(sqr(xc - x1) + sqr(yc - y1)); if c=0 then c:=1;
	result := iearccos( (sqr(a) + sqr(c) - sqr(b))/(2*a*c) );
   if ccw(x1,y1,xc,yc,x2,y2)=-1 then
   	result:=2*PI-result;
end;

// zz=100/Zoom
// pw=pen width
// AnglePoints must be in bitmap coordinates
procedure TImageEnVect.DrawAngle(wcanvas:TCanvas; AnglePoints:array of TPoint; Color:TColor; PW:integer; var plim:trect; UseZoom:boolean; mul:integer; zz:double);
var
   i,setpoint,xc,yc,x1,y1,x2,y2,ll,l1,l2,xx,yy:integer;
   tw,th:integer;
   aa:double;
   ss:AnsiString;
begin
   if AnglePoints[0].x<>-1000000 then
      with wcanvas do begin
         pen.Mode:=pmCopy;
         pen.width:=pw;
         pen.style:=psSolid;
         pen.Color:=Color;
         Font.Name:='Arial';
         Font.Size:=imax(3,trunc(10/zz));
         Font.Color:=Color;
         if syslocale.PriLangID=LANG_GREEK then
            Font.Charset := GREEK_CHARSET;
         brush.Style:=bsClear;
         setpoint:=1;
         xx:=VXBmp2Scr(AnglePoints[0].x,UseZoom,mul);
         yy:=VYBmp2Scr(AnglePoints[0].y,UseZoom,mul);
         moveto( xx,yy ); iesetplim(plim,xx,yy);
         for i:=1 to 2 do
            if AnglePoints[i].x<>-1000000 then begin
               xx:=VXBmp2Scr(AnglePoints[i].x,UseZoom,mul);
               yy:=VYBmp2Scr(AnglePoints[i].y,UseZoom,mul);
               lineto( xx,yy ); iesetplim(plim,xx,yy);
               inc(setpoint);
            end else
               break;
         if setpoint=3 then begin
         	// can calculate the angle
            aa:=_angle3(AnglePoints[0].x,AnglePoints[0].y,AnglePoints[1].x,AnglePoints[1].y,AnglePoints[2].x,AnglePoints[2].y);
            aa:=aa/PI*180;
            xc:=VXBmp2Scr(AnglePoints[1].x,UseZoom,mul);
            yc:=VYBmp2Scr(AnglePoints[1].y,UseZoom,mul);
            ss:=floattostrf(aa,ffFixed,fFloatPrecision,fFloatDigits)+'°';
				textout( xc,yc, ss );
            tw:=textwidth(ss);
            th:=textheight(ss);
            iesetplim(plim,xc,yc);
            iesetplim(plim,xc+tw,yc+th);
            x1:=VXBmp2Scr(AnglePoints[0].x,UseZoom,mul);
            y1:=VYBmp2Scr(AnglePoints[0].y,UseZoom,mul);
            x2:=VXBmp2Scr(AnglePoints[2].x,UseZoom,mul);
            y2:=VYBmp2Scr(AnglePoints[2].y,UseZoom,mul);
            l1:=trunc(sqrt(sqr(xc - x2) + sqr(yc - y2))) div 4;
            l2:=trunc(sqrt(sqr(xc - x1) + sqr(yc - y1))) div 4;
            ll:=imin(l1,l2);
				arc(xc-ll,yc-ll,xc+ll,yc+ll,x1,y1,x2,y2);
            iesetplim(plim,xc-ll,yc-ll);
            iesetplim(plim,xc+ll,yc+ll);
         end;
      end;
end;

// return angle for iekAngle objects
function TImageEnVect.GetAngleValue(hobj:integer):double;
begin
	result:=0;
	with GetObj(hobj)^ do begin
   	if CountAnglePoints(AnglePoints)=3 then begin
	      result:=_angle3(AnglePoints[0].x,AnglePoints[0].y,AnglePoints[1].x,AnglePoints[1].y,AnglePoints[2].x,AnglePoints[2].y);
		   result:=result/PI*180;	// convert to degrees
      end;
   end;
end;

// zz= 100/Zoom
// pw = pen width
procedure TImageEnVect.DrawRuler(wcanvas:TCanvas; x1,y1,x2,y2:integer; um:TIEUnits; Color:TColor; PW:integer; RulerType:TIEVRulerType; zz:double; var plim:trect; logfont:PLogFont);
var
   aa,bb,hw,mhw1,mhw2,hh:double;
   ll:double;
   mfreq1:integer;
   fl:boolean;
   xx,yy,xa,ya,xb,yb:integer;
   th,tw:integer;
   ss:AnsiString;
   cosbb,sinbb:double;
   cosbbpi,sinbbpi:double;
   cosbbpi2:double;
   cosbbmpi:double;
   rx,ry,rw:double;
   px,py,rh:double;
   dst:integer;
   cx,cy:double;
   xlog:TLogFont;
   hfont:THandle;
   hpred:THandle;
begin
   if (x1=x2) and (y1=y2) then exit;
	with wcanvas do begin
   	pen.Mode:=pmCopy;
      pen.width:=pw;
      pen.style:=psSolid;
      aa:=ieangle(x1,y1,x2,y2,x1,y2);
      if x1=x2 then
         if y1<y2 then
            aa:=-A90
         else
            aa:=A90;
      fl:=((x1>x2) and (y2<y1)) or ((x1<x2) and (y1<y2));
      if fl then
         bb:=2*pi-aa+A90
      else
         bb:=aa+A90;
      cosbb:=cos(bb);
      sinbb:=sin(bb);
      cosbbpi:=cos(bb+pi);
      sinbbpi:=sin(bb+pi);
      cosbbpi2:=cos(bb+pi*2);
      cosbbmpi:=cos(bb-pi);
      Font.Name:=logfont^.lfFaceName;
      Font.Size:=imax(3,trunc( abs(logfont^.lfHeight) /zz));
      Font.Color:=Color;
      if syslocale.PriLangID=LANG_GREEK then
			Font.Charset := GREEK_CHARSET;
      brush.Style:=bsClear;
      pen.Color:=Color;
      ll:=_DistPoint2Point(x1,y1,x2,y2);
      //moveto(x1,y1);
      //lineto(x2,y2);
      DrawLine(wcanvas,x1,y1,x2,y2);
      iesetplim(plim,x1,y1);
      iesetplim(plim,x2,y2);
      case RulerType of
	      iertQUOTEBEGIN, iertQUOTECENTER, iertQUOTEEND:
            begin
               hw:=trunc(9/zz);
               xa:=trunc(cosbb*hw);
               ya:=trunc(sinbb*hw);
               xb:=trunc(cosbbpi*hw);
               yb:=trunc(sinbbpi*hw);
               moveto(x1+xa,y1+ya); iesetplim(plim,x1+xa,y1+ya);
               lineto(x1+xb,y1+yb); iesetplim(plim,x1+xb,y1+yb);
               moveto(x2+xa,y2+ya); iesetplim(plim,x2+xa,y2+ya);
               lineto(x2+xb,y2+yb); iesetplim(plim,x2+xb,y2+yb);
               //
               aa:=2*pi-_angle2(x1,y1,x2,y2);
               GetObject(Font.Handle,sizeof(TLogFont),@xlog);
               xlog.lfEscapement:=trunc(((-aa)*180/pi)*10);
               hfont:=CreateFontIndirect(xlog);
               hpred:=selectobject(wcanvas.handle,hfont);
					CalcCoef(cx,cy,um);
               rx:=abs(x2-x1+1)*cx*zz;
               ry:=abs(y2-y1+1)*cy*zz;
               cx:=sqrt(rx*rx+ry*ry);
               ss:=floattostrf(cx,ffFixed,fFloatPrecision,fFloatDigits)+' '+strunits[ord(um)];
               tw:=TextWidth(ss);
               th:=TextHeight(ss);
               case RulerType of
						iertQUOTEBEGIN:
                  	begin
                        xa:=x1;
                        ya:=y1;
								TextOut(xa,ya,' '+ss);
                     end;
                  iertQUOTECENTER:
                  	begin
                        xa:=x1+trunc( (ll-tw)/2*cos(aa) );
                        ya:=y1+trunc( (ll-tw)/2*sin(aa) );
                        TextOut(xa,ya,ss);
                     end;
                  iertQUOTEEND:
                  	begin
                        xa:=x1+trunc( (ll-tw)*cos(aa) );
                        ya:=y1+trunc( (ll-tw)*sin(aa) );
                        TextOut(xa,ya,ss+' ');
                     end;
               end;
               iesetplim(plim,xa,ya);
               xb:=trunc(tw*1*cos(aa)-th*1*sin(aa));
               yb:=trunc(tw*1*sin(aa)+th*1*cos(aa));
               iesetplim(plim,xa+xb,ya+yb);
               iesetplim(plim,xa-15,ya-15);
               iesetplim(plim,xa+15,ya+15);
               iesetplim(plim,xa+xb+15,ya+yb+15);
               iesetplim(plim,xa+xb-15,ya+yb-15);
               //
               selectobject(wcanvas.handle,hpred);
               DeleteObject(hfont);
            end;
         iertRULER:
            begin
               hw:=trunc(6/zz);
               mhw1:=trunc(8/zz);
               mhw2:=trunc(12/zz);
               // cx: quanti fMUnit/10 corrisponde ogni pixel in X
               // cy: quanti fMUint/10 corrisponde ogni pixel in Y
               CalcCoef(cx,cy,um);
               cx:=cx*zz*10;
               cy:=cy*zz*10;
               if (cx=0) or (cy=0) then exit;
               rx:=1/cx;
               ry:=1/cy;
               // rx: quanti pixel in X corrispondono a un fMUnit
               // ry: quanti pixel in Y corrispondono a un fMUnit
               mfreq1:=0;
               px:=0;
               py:=0;
               dst:=0;
               while dst<ll do begin
                  if x2<x1 then begin
                     rw:=px*sinbb;
                     rh:=py*cosbbpi;
                  end else begin
                     rw:=px*sinbbpi;
                     rh:=py*cosbb;
                  end;
                  if mfreq1 mod 10=0 then
                     hh:=mhw2
                  else if mfreq1 mod 5=0 then
                     hh:=mhw1
                  else
                     hh:=hw;
                  if _InRectO(x1+trunc(rw),y1+trunc(rh),x1,y1,x2,y2) then begin
                     xa:=x1+trunc(rw+cosbb*hh);
                     ya:=y1+trunc(rh+sinbb*hh);
                     xb:=x1+trunc(rw+cosbbpi*hh);
                     yb:=y1+trunc(rh+sinbbpi*Hh);
                     moveto( xa,ya ); iesetplim( plim,xa,ya );
                     lineto( xb,yb ); iesetplim( plim,xb,yb );
                     if mfreq1 mod 10=0 then begin
                        ss:=inttostr(mfreq1 div 10);
                        th:=TextHeight(ss)*2;
                        tw:=TextWidth(ss) shr 1;
                        if fl then begin
                        	xx:=trunc(xa+th*cosbbpi2-tw*cosbb*2+tw*sinbb);
                           yy:=trunc(ya+th*sinbb+tw*cosbbmpi)+20;
                           TextOut(xx,yy,ss);
                        end else begin
                        	xx:=trunc(xa+th*cosbb+tw*sinbb);
                           yy:=trunc(ya+th*sinbb+tw*cosbb)+20;
                           TextOut(xx,yy,ss);
                        end;
                        iesetplim(plim,xx-15,yy-15);
								iesetplim(plim,xx+15,yy+15);
                     end;
                  end;
                  //
                  inc(mfreq1,1);
                  px:=px+rx;
                  py:=py+ry;
                  dst:=trunc(sqrt(rw*rw+rh*rh));
               end;
            end;
      end;	// end case
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.WMSize(var Message: TWMSize);
begin
  	inherited;
   CancelInteracts;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Calcola l'area della selezione corrente.
// nota: l'algoritmo usato non funziona su aree che si auto intersecano.
function TImageEnVect.GetSelectionArea:double;
var
	i:integer;
   dxy:double;
   lbreak:integer;
begin
   dxy:=(fCoefX)*(fCoefY);
  	result:=0;
   with fHPolySel^ do begin
      if PolyCount>2 then begin
      	lbreak:=0;
         i:=0;
         while i<PolyCount do begin
         	if (Poly^[i+1].x=IESELBREAK) or (i=PolyCount-1) then begin
            	result:=result+dxy*(Poly^[i].X-Poly^[lbreak].X)*(Poly^[lbreak].Y+Poly^[i].Y);
               inc(i);
					lbreak:=i+1;
            end else
	            result:=result+dxy*(Poly^[i].X-Poly^[i+1].X)*(Poly^[i+1].Y+Poly^[i].Y);
            inc(i);
         end;
         result:=abs(result/2);
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Calculates x,y coordinates of the selection centroid
// The point is in bitmap coordinates
function TImageEnVect.GetSelectionCentroid:TPoint;
var
	oldMUnit:TIEUnits;
   i,j,n:integer;
   ai,atmp,xtmp,ytmp:double;
begin
	oldMUnit:=MUnit;
   MUnit:=ieuPIXELS;
	result.x:=0;
   result.y:=0;
   atmp := 0;
   xtmp := 0;
   ytmp := 0;
   with fHPolySel^ do
      if PolyCount>2 then begin
      	n:=PolyCount;
         for i:=0 to n-1 do
         	if Poly^[i].x=IESELBREAK then begin
            	n:=i;
               break;
            end;
      	i := n-1;
         j := 0;
      	while j < n do begin
            ai := Poly^[i].x * Poly^[j].y - Poly^[j].x * Poly^[i].y;
            atmp := atmp+ai;
            xtmp := xtmp+ (Poly^[j].x + Poly^[i].x) * ai;
            ytmp := ytmp+ (Poly^[j].y + Poly^[i].y) * ai;
            i := j;
            inc(j);
         end;
         if (atmp <> 0) then begin
            result.x :=	trunc( xtmp / (3 * atmp) );
            result.y :=	trunc( ytmp / (3 * atmp) );
         end;
      end;
   MUnit:=oldMUnit;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.SetBitmapResampleFilter(v:TResampleFilter);
begin
	if v<>fBitmapResampleFilter then
		fBitmapResampleFilter:=v;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.DoVectorialChanged;
begin
	fVectorialChanging:=false;
   if assigned(fOnVectorialChanged) then
      fOnVectorialChanged(self);
end;

procedure TImageEnVect.DoBeforeVectorialChange;
begin
	if fObjAutoUndo then
		ObjSaveUndo;
	if not fVectorialChanging then
      if assigned(fOnVectorialChanged) then
         fOnVectorialChanged(self);
	fVectorialChanging:=true;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Copy vectorial (all) objects
procedure TImageEnVect.CopyAllObjectsTo(Dest:TImageEnVect);
var
	q:integer;
begin
	for q:=0 to fObjCount-1 do
   	CopyObjectTo(fObj^[q],Dest);
   Dest.Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Copy specified object
procedure TImageEnVect.CopyObjectTo(hobj:integer; Dest:TImageEnVect);
var
	obj:PIEVObject;
   i:integer;
begin
	obj:=GetObj(hobj);
   if obj^.Kind=iekBitmap then begin
      i:=Dest.AllocBitmap;
      Dest.fBitmaps^[i].fRefCount:=1;
      Dest.fBitmaps^[i].fBitmap:=TIEBitmap.Create;
      Dest.fBitmaps^[i].fBitmap.Assign( fBitmaps^[obj^.BitmapIdx].fBitmap );
   end;
	Dest.AddVObject( obj^ );
   Dest.Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Copy selected objects
procedure TImageEnVect.CopySelectedObjectsTo(Dest:TImageEnVect);
var
	q:integer;
begin
   for q:=0 to fSelObjCount-1 do
   	Dest.AddVObject( GetObj(fSelObj^[q])^ );
   Dest.Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.Assign(Source: TPersistent);
var
	src:TImageEnVect;
begin
	inherited;
   if Source=nil then begin
		CancelInteracts;
   	RemoveAllObjects;
   end else if Source is TImageEnVect then begin
		CancelInteracts;
   	RemoveAllObjects;
   	src:=(Source as TImageEnVect);
      src.CopyAllObjectsTo(self);
      //
		SetScale(src.fScale);
   	//
      DoVectorialChanged;
      Update;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.Paint;
begin
	inherited;
   fHintSaveBitmap.Width:=1;	// this invalidates the hint
   if (fStable2=0) then
      HintShow(fMovX,fMovY);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVect.VPaintTo(BBitmap:TBitmap);
begin
	fObjDrawed:=0;
	DrawObjectAll(false,BBitmap,fObjAntialias);
   DrawSelGrips(BBitmap.Canvas);
   if miEditPolyline in fMouseInteractVt then
      DrawPolylinePoints(BBitmap.Canvas);
end;

//
procedure TImageEnVect.PaintToEx(ABitmap:TBitmap; ABitmapScanline:ppointerarray; UpdRect:PRect);
begin
	inherited;
   VPaintTo(ABitmap);
end;

// return required pen width
function TImageEnVect.AdjustCoords(const aobj:TIEVObject; var x1,y1,x2,y2,x3,y3:integer; zz:double):integer;
var
	pw:integer;
begin
	if fZoomObjectsWidth then begin
      result := ieceil(dmax(1,aobj.PenWidth*zz));
      if (aobj.Kind=iekLINE) or (aobj.Kind=iekBOX) or (aobj.Kind=iekELLIPSE) or (aobj.Kind=iekARC) or (aobj.Kind=iekLINELABEL) then begin
         pw:=result div 2;
         inc(x1,pw);
         inc(y1,pw);
         inc(x2,pw);
         inc(y2,pw);
      end;
      if (aobj.Kind=iekBITMAP) and (zz<>1) then begin
      	x2:=x3-1;
         y2:=y3-1;
      end;
   end else
   	result := aobj.PenWidth;
end;

function TImageEnVect.VXBmp2Scr(x:integer; UseZoom:boolean; mul:integer):integer;
begin
	if UseZoom then
   	result:=XBmp2Scr(x)*mul
   else
   	result:=x*mul;
end;

function TImageEnVect.VYBmp2Scr(y:integer; UseZoom:boolean; mul:integer):integer;
begin
	if UseZoom then
   	result:=YBmp2Scr(y)*mul
   else
   	result:=y*mul;
end;

procedure iehighlight(bitmap:TBitmap; x1,y1,x2,y2:integer; color:TRGB);
var
	x,y:integer;
   px:PRGB;
   pb:pbyte;
begin
	x1:=imax(0,imin(x1,bitmap.Width-1));
   y1:=imax(0,imin(y1,bitmap.Height-1));
	x2:=imax(0,imin(x2,bitmap.Width-1));
   y2:=imax(0,imin(y2,bitmap.Height-1));
   case bitmap.PixelFormat of
   	pf8bit:
         for y:=y1 to y2 do begin
            pb:=bitmap.Scanline[y]; inc(pb,x1);
            for x:=x1 to x2 do begin
            	pb^:=color.r;
               inc(pb);
            end;
         end;
      pf24bit:
         for y:=y1 to y2 do begin
            px:=bitmap.Scanline[y]; inc(px,x1);
            for x:=x1 to x2 do begin
               with px^ do begin
                  r:=color.r and r;
                  g:=color.g and g;
                  b:=color.b and b;
               end;
               inc(px);
            end;
         end;
   end;
end;

// Draw specified object
// UseZoom: if true it doesn't look at zoom, viewxy, foffx
// CheckLimits: if true it doesn't verify that the object is inside the client area
// ret true if displayed
function TImageEnVect.DrawObject(var aobj:TIEVObject; BBitmap:TBitmap; CheckLimits:boolean; UseZoom:boolean; DrawOnTIEBitmap:TIEBitmap; mul:integer; drawingalpha:boolean):boolean;
var
   ax1,ay1,ax2,ay2,ax3,ay3:integer;
   x3,y3,x4,y4:integer;
   sw,sh,i:integer;
   xx,yy:double;
   zz,zx,zy:double;
   pts:PPointArray;
   pw:integer;
begin
	result:=false;
	if fAllObjectsHidden then
   	exit;
   // converts bitmap coordinates to clientarea coordintes
   if UseZoom then
      zz:=fZoomD100
   else
      zz:=1;
   if mul>1 then
   	zz:=zz*mul;
   ax1:=VXBmp2Scr(aobj.x1,UseZoom,mul);
   ay1:=VYBmp2Scr(aobj.y1,UseZoom,mul);
   ax2:=VXBmp2Scr(aobj.x2,UseZoom,mul);
   ay2:=VYBmp2Scr(aobj.y2,UseZoom,mul);
   ax3:=VXBmp2Scr(aobj.x2+1,UseZoom,mul);
   ay3:=VYBmp2Scr(aobj.y2+1,UseZoom,mul);
   if mul>1 then
   	pw:=aobj.PenWidth
   else
   	pw:=AdjustCoords(aobj,ax1,ay1,ax2,ay2,ax3,ay3,zz);
   with BBitmap.Canvas do begin
      Pen.Color:=aobj.PenColor;
      Pen.Style:=aobj.PenStyle;
      Pen.Width:=pw;
      Pen.Mode:=pmCopy;
   end;
   aobj.plim:=rect(2000000000,2000000000,-2000000000,-2000000000);
   aobj.pwidth:=pw;
   // verify rectangle intersection
   if (ievsVisible in aobj.Style) and (_RectXRect(ax1,ay1,ax2,ay2, fOffX*mul,fOffY*mul,fOffX*mul+fExtX*mul,fOffY*mul+fExtY*mul) or (not CheckLimits)) then begin
   	result:=true;
      case aobj.Kind of
         iekLINE,iekLINELABEL:
            with BBitmap.canvas do begin
               // Line
               DrawLine(BBitmap.Canvas,ax1,ay1,ax2,ay2);
               (*
			      moveto(ax1,ay1);
			      lineto(ax2,ay2);
               *)
			      iesetplim(aobj.plim,ax1,ay1);
			      iesetplim(aobj.plim,ax2,ay2);
               sw:=trunc(aobj.ShapeWidth*zz);
               sh:=trunc(aobj.ShapeHeight*zz);
               Brush.Color:=aobj.BrushColor;
               Brush.Style:=aobj.BrushStyle;
               DrawLineShape(aobj,BBitmap.Canvas,ax1,ay1,ax2,ay2,aobj.BeginShape,sw,sh,aobj.plim);
               DrawLineShape(aobj,BBitmap.Canvas,ax2,ay2,ax1,ay1,aobj.EndShape,sw,sh,aobj.plim);
               inc(fObjDrawed);
               if aobj.Kind=iekLINELABEL then
	               DrawObjectLineLabel(BBitmap.Canvas,ax1,ay1,ax2,ay2,aobj,zz,aobj.plim);
            end;
         iekRULER:
            begin
               // Ruler
               BBitmap.canvas.Brush.Color:=aobj.BrushColor;
               BBitmap.canvas.Brush.Style:=aobj.BrushStyle;
               DrawRuler(BBitmap.Canvas,ax1,ay1,ax2,ay2,aobj.RulerUnit,aobj.PenColor,aobj.PenWidth,aobj.RulerType,1/zz,aobj.plim,aobj.LogFont);
               inc(fObjDrawed);
            end;
         iekANGLE:
            begin
               // Angle
               BBitmap.canvas.Brush.Color:=aobj.BrushColor;
               BBitmap.canvas.Brush.Style:=aobj.BrushStyle;
               DrawAngle(BBitmap.Canvas,aobj.AnglePoints,aobj.PenColor,aobj.PenWidth,aobj.plim,UseZoom,mul,1/zz);
               inc(fObjDrawed);
            end;
         iekBOX:
            with BBitmap.Canvas do begin
               // box
               BBitmap.canvas.Brush.Color:=aobj.BrushColor;
               BBitmap.canvas.Brush.Style:=aobj.BrushStyle;
               iesetplim(aobj.plim,ax1,ay1);
               iesetplim(aobj.plim,ax2,ay2);
					if aobj.BoxHighlight then
						iehighlight(BBitmap,ax1,ay1,ax2,ay2,TColor2TRGB(aobj.BrushColor))
               else
               	Rectangle(ax1,ay1,ax2+1,ay2+1);
               inc(fObjDrawed);
            end;
         iekELLIPSE:
            with BBitmap.Canvas do begin
               // ellipse
               BBitmap.canvas.Brush.Color:=aobj.BrushColor;
               BBitmap.canvas.Brush.Style:=aobj.BrushStyle;
               iesetplim(aobj.plim,ax1,ay1);
               iesetplim(aobj.plim,ax2,ay2);
               Ellipse(ax1,ay1,ax2+1,ay2+1);
               inc(fObjDrawed);
            end;
         iekARC:
            with BBitmap.Canvas do begin
               // arc
               BBitmap.canvas.Brush.Color:=aobj.BrushColor;
               BBitmap.canvas.Brush.Style:=aobj.BrushStyle;
               xx:=(ax2-ax1) / 2;
               yy:=(ay2-ay1) / 2;
               x3:=ax1+trunc(xx+xx*cos(aobj.a1));
               y3:=ay1+trunc(yy+yy*sin(aobj.a1));
               x4:=ax1+trunc(xx+xx*cos(aobj.a2));
               y4:=ay1+trunc(yy+yy*sin(aobj.a2));
               arc(ax1,ay1,ax2+1,ay2+1,x3,y3,x4,y4);
               iesetplim(aobj.plim,ax1,ay1);
               iesetplim(aobj.plim,ax2,ay2);
               inc(fObjDrawed);
            end;
         iekBITMAP:
         	begin
               // bitmap
               BBitmap.canvas.Brush.Color:=aobj.BrushColor;
               BBitmap.canvas.Brush.Style:=aobj.BrushStyle;
               iesetplim(aobj.plim,ax1,ay1);
               iesetplim(aobj.plim,ax2,ay2);
               DrawBitmapObject(BBitmap,aobj,ax1,ay1,ax2,ay2,DrawOnTIEBitmap);
               inc(fObjDrawed);
            end;
         iekTEXT, iekMEMO:
         	begin
               // text
               BBitmap.canvas.Brush.Color:=aobj.BrushColor;
               BBitmap.canvas.Brush.Style:=aobj.BrushStyle;
               iesetplim(aobj.plim,ax1,ay1);
               iesetplim(aobj.plim,ax2,ay2);
               DrawObjectText(BBitmap.Canvas,ax1,ay1,ax2,ay2,aobj,zz,drawingalpha,aobj.plim);
               inc(fObjDrawed);
            end;
         iekPOLYLINE:
            	// polyline
               with aobj,BBitmap.Canvas do begin
                  Brush.Color:=aobj.BrushColor;
                  Brush.Style:=aobj.BrushStyle;
               	if (PolyBaseX1<>PolyBaseX2) and (PolyBaseY1<>PolyBaseY2) and (PolyPointsCount>0) then begin
                  	if DrawnPointsCount<>PolyPointsCount then begin
                     	if assigned(DrawnPoints) then
                        	freemem(DrawnPoints);
                        getmem(DrawnPoints,PolyPointsCount*sizeof(TPoint));
                        DrawnPointsCount:=PolyPointsCount;
                     end;
                     CalcZxZyPolyline(@aobj,zx,zy);
                     x3:=VXBmp2Scr(round((PPointArray(PolyPoints)[0].x-PolyBaseX1)*zx)+x1,UseZoom,mul);
                     y3:=VYBmp2Scr(round((PPointArray(PolyPoints)[0].y-PolyBaseY1)*zy)+y1,UseZoom,mul);
                     pts:=ppointarray(DrawnPoints);
                     pts[0].x:=x3; pts[0].y:=y3;
                     for i:=1 to PolyPointsCount-1 do begin
                        x3:=VXBmp2Scr(round((PPointArray(PolyPoints)[i].x-PolyBaseX1)*zx)+x1,UseZoom,mul);
                        y3:=VYBmp2Scr(round((PPointArray(PolyPoints)[i].y-PolyBaseY1)*zy)+y1,UseZoom,mul);
                        pts[i].x:=x3; pts[i].y:=y3;
                     end;
                     if PolyClosed then
                     	Polygon(slice(pts^,PolyPointsCount))
                     else
                     	Polyline(slice(pts^,PolyPointsCount));
                     if mul<>1 then begin
                     	for i:=0 to PolyPointsCount-1 do begin
                        	pts[i].x:=pts[i].x div mul;
                           pts[i].y:=pts[i].y div mul;
                        end;
                     end;
                  end;
                  iesetplim(aobj.plim,ax1,ay1);
                  iesetplim(aobj.plim,ax2,ay2);
                  inc(fObjDrawed);
               end;
      end;
   end;
end;

// draw grips (points) of the selected polyline (if there is one)
procedure TImageEnVect.DrawPolylinePoints(Canvas:TCanvas);
var
	i:integer;
   pobj:PIEVObject;
   pts:ppointarray;
begin
	if (fSelObjCount=1) then begin
		pobj:=GetObj(fSelObj^[0]);
      if (pobj^.Kind=iekPOLYLINE) then
         with Canvas, pobj^ do begin
            Brush.Color:=clRed;
            Brush.Style:=bsSolid;
            Pen.Color:=clBlack;
            Pen.Style:=psSolid;
            Pen.Mode:=pmCopy;
            Pen.Width:=1;
            pts:=ppointarray(DrawnPoints);
            for i:=0 to DrawnPointsCount-1 do
               //Rectangle(pts[i].x-POLYLINEGDIM,pts[i].y-POLYLINEGDIM,pts[i].x+POLYLINEGDIM,pts[i].y+POLYLINEGDIM);
               Ellipse(pts[i].x-POLYLINEGDIM,pts[i].y-POLYLINEGDIM,pts[i].x+POLYLINEGDIM,pts[i].y+POLYLINEGDIM);
         end;
   end;
end;

procedure TImageEnVect.DrawBitmapObject(BBitmap:TBitmap; aobj:TIEVObject; x1,y1,x2,y2:integer; DrawOnTIEBitmap:TIEBitmap);
var
   sourcebmp:TIEBitmap;
   tab1:ppointerarray;
   tab2,tab3:pinteger;
begin
   if aobj.BitmapIdx>=0 then begin
   	sourcebmp:=GetBitmap(aobj.BitmapIdx);
      // OrdCor is necessary because when modify objects the coordinates could not be ordered.
      OrdCor(x1,y1,x2,y2);
      if DrawOnTIEBitmap=nil then begin
      	// draw on BBitmap
         tab1:=nil; tab2:=nil; tab3:=nil;
         if fVStable>0 then
            sourcebmp.RenderToTBitmap(BBitmap,tab1,tab2,tab3,nil,x1,y1,x2-x1+1,y2-y1+1,0,0,sourcebmp.Width,sourcebmp.Height,true,false,aobj.Transparency,rfNone,true,ielNormal)
         else
            sourcebmp.RenderToTBitmap(BBitmap,tab1,tab2,tab3,nil,x1,y1,x2-x1+1,y2-y1+1,0,0,sourcebmp.Width,sourcebmp.Height,true,false,aobj.Transparency,fBitmapResampleFilter,true,ielNormal);
   	end else begin
      	// draw on TIEBitmap
         if fVStable>0 then
            sourcebmp.StretchRectTo(DrawOnTIEBitmap,x1,y1,x2-x1+1,y2-y1+1,0,0,sourcebmp.Width,sourcebmp.Height,rfNone,aobj.Transparency)
         else
            sourcebmp.StretchRectTo(DrawOnTIEBitmap,x1,y1,x2-x1+1,y2-y1+1,0,0,sourcebmp.Width,sourcebmp.Height,fBitmapResampleFilter,aobj.Transparency);
      end;
   end else
      with BBitmap.Canvas do begin
         // bitmap non present, draw "X"
         moveto(x1,y1);
         lineto(x2,y2);
         moveto(x2,y1);
         lineto(x1,y2);
         Rectangle(x1,y1,x2+1,y2+1);
      end;
end;

procedure TImageEnVect.DoObjectMoveResize(hobj:integer; Grip:integer; var OffsetX,OffsetY:integer);
begin
	if assigned(fOnObjectMoveResize) then
   	fOnObjectMoveResize(self,hobj,Grip,OffsetX,OffsetY);
end;

procedure TImageEnVect.DoObjectClick(hobj:integer);
begin
	if assigned(fOnObjectClick) then
   	fOnObjectClick(self,hobj);
end;

procedure TImageEnVect.DoObjectDblClick(hobj:integer);
begin
	if assigned(fOnObjectDblClick) then
   	fOnObjectDblClick(self,hobj);
end;

procedure TImageEnVect.DoObjectOver(hobj:integer);
begin
	if assigned(fOnObjectOver) then
   	fOnObjectOver(self,hobj);
end;

// x,y expressed in client area coordinates
// return:
// <0 no object found
// note: see MaxSelectionDistance
function TImageEnVect.FindObjectAt(x,y:integer; var Distance:double):integer;
begin
   result:=FindNearObj(xScr2Bmp(x),yScr2Bmp(y),Distance,false);
end;

procedure TImageEnVect.ObjCopyToClipboard;
var
	hmem:THandle;
   ms:TMemoryStream;
   ptr:pointer;
   q,hobj:integer;
   o:PIEVObject;
   io:TImageEnIO;
begin
	if OpenClipboard(0) then begin
      EmptyClipboard;
      ms:=TMemoryStream.Create;
      //
      io:=TImageEnIO.Create(self);
      ms.write(fSelObjCount,sizeof(integer));
	   for q:=0 to fSelObjCount-1 do begin
      	hobj:=fSelObj^[q];
      	SaveObj( ms, hobj );
         o:=GetObj(hobj);
         if o.Kind=iekBITMAP then begin
         	// save bitmap
				io.AttachedIEBitmap:=fBitmaps^[o.BitmapIdx].fBitmap;
            {$ifdef IEINCLUDEPNG}
            io.SaveToStreamPNG(ms);
            {$else}
            io.SaveToStreamBMP(ms);
            {$endif}
         end;
		end;
      io.free;
      //
      hmem:=GlobalAlloc(GMEM_MOVEABLE or GMEM_DDESHARE,ms.size);
      ptr:=GlobalLock(hmem);
      CopyMemory(ptr,ms.memory,ms.size);
      ms.free;
      GlobalUnLock(hmem);
   	SetClipboardData(IEVECTCLIPFORMAT,hmem);
   	CloseClipboard;
      //GlobalFree(hbi);	// the system own the memory
   end;
end;

procedure TImageEnVect.ObjPasteFromClipboard(OffsetX,OffsetY:integer);
var
	hmem:THandle;
   ptr:pointer;
   ms:TMemoryStream;
   q,cc,hobj:integer;
   o:PIEVObject;
   io:TImageEnIO;
   bmp:TIEBitmap;
begin
	if OpenClipboard(0) then begin
		if IsClipboardFormatAvailable(IEVECTCLIPFORMAT) then begin
      	if fObjAutoUndo then
         	ObjSaveUndo;
			hmem:=GetClipboardData(IEVECTCLIPFORMAT);
         if hmem<>0 then begin
				// remove selected objects
            while fSelObjCount>0 do begin
		      	hobj:=fSelObj^[0];
               RemoveObject(hobj);
            end;
            // load objects from clipboard
				ptr:=GlobalLock(hmem);
				ms:=TMemoryStream.Create;
            ms.Write(pbyte(ptr)^, GlobalSize(hmem) );
            ms.position:=0;
				//
            bmp:=TIEBitmap.Create;
            io:=TImageEnIO.Create(self);
            io.attachediebitmap:=bmp;
            ms.read(cc,sizeof(integer));
            for q:=0 to cc-1 do begin
					hobj:=ReadObj(ms,IEVVER,false);
					o:=GetObj(hobj);
               inc(o.x1,OffsetX);
					inc(o.x2,OffsetX);
               inc(o.y1,OffsetY);
					inc(o.y2,OffsetY);
               if o.Kind=iekBITMAP then begin
						// load bitmap
                  {$ifdef IEINCLUDEPNG}
                  io.LoadFromStreamPNG(ms);
                  {$else}
                  io.LoadFromStreamBMP(ms);
                  {$endif}
						SetObjBitmap(hobj,bmp);
               end;
               AddSelObjectNS(hobj);
            end;
            io.free;
            bmp.free;
            //
				ms.free;
            GlobalUnLock(hmem);
            Update;
         end;
      end;
   	CloseClipboard;
   end;
end;

procedure TImageEnVect.ObjCutToClipboard;
begin
	if fObjAutoUndo then
   	ObjSaveUndo;
	ObjCopyToClipboard;
   // remove selected objects
   while fSelObjCount>0 do
      RemoveObject( fSelObj^[0] );
end;

procedure _ierotate(basex,basey,px,py:double; arc:double; var outx,outy:integer);
   function ArcTan2(Y, X: Extended): Extended;
   asm
      FLD     Y
      FLD     X
      FPATAN
      FWAIT
   end;
var
	Dx, Dy, D:double;
begin
   Dx := Px - basex;
   Dy := Py - basey;
   if (Dx = 0) and (Dy = 0) then begin
   	outx := round( Px );
		outy := round( Py );
   end else begin
   	D := sqrt(Dx * Dx + Dy * Dy);
      arc := arc+arctan2(Dy, Dx);
      outx := round( basex + D * cos(arc) );
      outy := round( basey + D * sin(arc) );
	end;
end;

// x,y in component coordinates (mousedown)
function TImageEnVect.CreatePolygonFromEdge(x,y:integer; maxfilter:boolean; tolerance:integer):integer;
var
	pp:PPointArray;
   pcount:integer;
begin
	x:=XScr2Bmp(x);
   y:=YScr2Bmp(y);
	pp:=_MakeMagicWandPoints(fIEBitmap,x,y,maxfilter,tolerance,pcount);
   if pcount>0 then begin
      result:=AddNewObject;
      with GetObj(result)^ do
         Kind:=iekPOLYLINE;
      SetObjPolylinePoints(result,slice(pp^,pcount));
      // close polygon
      AddPolyLinePoint(result,pp^[0].x,pp^[0].y);
      //
      freemem(pp);
      Update;
   end else
   	result:=-1;
end;

function TImageEnVect.GetPolylineLen(hobj:integer):double;
var
	zx,zy:double;
	xa,ya,xb,yb,lx,ly:double;
   i:integer;
begin
	result:=0;
	with GetObj(hobj)^ do
   	if Kind=iekPOLYLINE then begin
         CalcZxZyPolyline(GetObj(hobj),zx,zy);
         if PolyPointsCount>0 then begin
            xa:=(PPointArray(PolyPoints)[0].x-PolyBaseX1)*zx+x1;
            ya:=(PPointArray(PolyPoints)[0].y-PolyBaseY1)*zy+y1;
            for i:=1 to PolyPointsCount-1 do begin
               xb:=(PPointArray(PolyPoints)[i].x-PolyBaseX1)*zx+x1;
               yb:=(PPointArray(PolyPoints)[i].y-PolyBaseY1)*zy+y1;
					lx:=abs(xa-xb)*fCoefX;
               ly:=abs(ya-yb)*fCoefY;
               result:=result+ sqrt( lx*lx+ly*ly );
               xa:=xb;
               ya:=yb;
            end;
         end;
      end;
end;

function TImageEnVect.GetObjDiagLen(hobj:integer):double;
var
	lx,ly:double;
begin
	with GetObj(hobj)^ do begin
      lx:=abs(x2-x1+1)*fCoefX;
      ly:=abs(y2-y1+1)*fCoefY;
      result:=sqrt( lx*lx+ly*ly );
   end;
end;

function TImageEnVect.GetPolylineArea(hobj:integer):double;
var
	zx,zy:double;
	xa,ya,xb,yb:double;
   i:integer;
   dxy:double;
begin
	result:=0;
   dxy:=(fCoefX)*(fCoefY);
	with GetObj(hobj)^ do
   	if Kind=iekPOLYLINE then begin
         CalcZxZyPolyline(GetObj(hobj),zx,zy);
         if PolyPointsCount>0 then begin
            xa:=(PPointArray(PolyPoints)[0].x-PolyBaseX1)*zx+x1;
            ya:=(PPointArray(PolyPoints)[0].y-PolyBaseY1)*zy+y1;
            for i:=1 to PolyPointsCount-1 do begin
               xb:=(PPointArray(PolyPoints)[i].x-PolyBaseX1)*zx+x1;
               yb:=(PPointArray(PolyPoints)[i].y-PolyBaseY1)*zy+y1;
               result:=result+dxy*(xa-xb)*(ya+yb);
               xa:=xb;
               ya:=yb;
            end;
            result:=abs(result/2);
         end;
      end;
end;

function TImageEnVect.GetPolylineCentroid(hobj:integer):TPoint;
var
	oldMUnit:TIEUnits;
   i,j:integer;
   ai,atmp,xtmp,ytmp:double;
   zx,zy:double;
   xi,yi,xj,yj:double;
begin
	oldMUnit:=MUnit;
   MUnit:=ieuPIXELS;
	result.x:=0;
   result.y:=0;
   atmp:=0;
   xtmp:=0;
   ytmp:=0;
   with GetObj(hobj)^ do
   	if Kind=iekPOLYLINE then begin
         CalcZxZyPolyline(GetObj(hobj),zx,zy);
      	i:=PolyPointsCount-1;
         j:=0;
      	while j<PolyPointsCount do begin
            xi:=(PPointArray(PolyPoints)[i].x-PolyBaseX1)*zx+x1;
            yi:=(PPointArray(PolyPoints)[i].y-PolyBaseY1)*zy+y1;
            xj:=(PPointArray(PolyPoints)[j].x-PolyBaseX1)*zx+x1;
            yj:=(PPointArray(PolyPoints)[j].y-PolyBaseY1)*zy+y1;
            ai:=xi*yj-xj*yi;
            atmp:=atmp+ai;
            xtmp:=xtmp+(xj+xi)*ai;
            ytmp:=ytmp+(yj+yi)*ai;
            i:=j;
            inc(j);
         end;
         if (atmp<>0) then begin
            result.x:=trunc(xtmp/(3*atmp));
            result.y:=trunc(ytmp/(3*atmp));
         end;
      end;
   MUnit:=oldMUnit;
end;

function IESIGN(a:double):integer;
begin
	if a=0 then
   	result:=0
   else if a<0 then
   	result:=-1
   else result:=1;
end;

function IEIntersect(Ax,Ay,Bx,By,Cx,Cy,Dx,Dy:integer; var x,y:integer):boolean;
var
	r,s,den:double;
begin
	x:=0; y:=0;
   if (Ax=Bx) and (Ay=By) then begin
   	r:=_DistPoint2Seg(Ax,Ay,Cx,Cy,Dx,Dy);
      x:=Ax; y:=By;
      result:= r=0;
   end else if (Cx=Dx) and (Cy=Dy) then begin
   	r:=_DistPoint2Seg(Cx,Cy,Ax,Ay,Bx,By);
      x:=Cx; y:=Cy;
      result:= r=0;
   end else begin
   	den:=(Bx-Ax)*(Dy-Cy)-(By-Ay)*(Dx-Cx);
      if den<>0 then begin
	      r:= ((Ay-Cy)*(Dx-Cx)-(Ax-Cx)*(Dy-Cy)) / den;
	      s:= ((Ay-Cy)*(Bx-Ax)-(Ax-Cx)*(By-Ay)) / den;
      end else begin
      	r:=-1;
         s:=-1;
      end;
      if (r<0) or (r>1) or (s<0) or (s>1) then
         result:=false
      else begin
         x:=round(Ax+r*(Bx-Ax));
         y:=round(Ay+r*(By-Ay));
         result:=true;
      end;
   end;
end;


(*
the output:
   Centroid:
      pvc^.x, pvc^.y
   Principal axis directions
      pvc^.x, pvc^.y, x_major, y_major
      pvc^.x, pvc^.y, x_minor, y_minor
   Moments:
      m00
      m10
      m01
      m11
      m20
      m02
   Central moments:
      mu00 (mu)
      mu11
      mu20
      mu02
   Radius of gyration:
      rad_gyr
   Is a Circle:
      circle (1=circle)
   Is horizontal:
      horizontal (1=horizontal)
   Is vertical:
      vertical (1=vertical)
   Invariant moments:
      phi_1
      phi_2
   Principal axes:
      tg_th1
      tg_th2
*)
(*
procedure TImageEnVect.CalcPolygonMoments(hobj:integer; var Centroid:TPoint; var MajorAxis,MinorAxis:TRect; var m00,m10,m01,m11,m20,m02:double; var mu00,mu11,mu20,mu02:double; var rad_gyr:double; var phi_1,phi_2:double; var tg_th1,tg_th2:double; var BoundingQuad:array of TPoint);
const
	DENT_CUTOFF=0.001;
   TANGENT_LIMIT=1.0e06;
   MU11_EPS=5.0e03;
var
   i, i_max, i_min:integer;
   size:integer;
   circle, horizontal, vertical:integer;
   ximm, xi, yimm, yi:double;
   d_xy, d_min, d_max:double;
   m00_sum:double;
   m10_sum, m01_sum, m11_sum:double;
   m20_sum, m02_sum:double;
   mu, dent:double;
   musq:double;
   tg_tth, sq_root:double;
   mu02_div_mu20, mu11mu20_sign:double;
   x2_major, y2_major, x2_minor, y2_minor:double;
   x1_major, y1_major, x1_minor, y1_minor:double;
   majorA,majorB,minorA,minorB:TPoint;
   imajorA,imajorB,iminorA,iminorB:integer;
   quad_IV, quad_I:integer;
   pvc:PPoint;
   vc:TPoint;
   color_index:integer;
   nv:integer;
   ppc:integer;
   dd,x,y:integer;
   ptop,pbottom:tpoint;
   pleft,pright:tpoint;
   zx,zy:double;
begin
	with GetObj(hobj)^ do begin
		if Kind<>iekPOLYLINE then
      	EXIT;	// EXIT POINT
      ppc:=PolyPointsCount;
      nv:=PolyPointsCount+1;
      CalcZxZyPolyline(GetObj(hobj),zx,zy);
      size:=30;
      circle:=0;
      horizontal:=0;
      vertical:=0;
      quad_IV := 0;
      quad_I := 0;
      color_index := 191;
      pvc := @vc;
      // Compute moments
      m00 := 0;
      m10 := 0;
      m01 := 0;
      m11 := 0;
      m20 := 0;
      m02 := 0;
      for i := 1 to nv-1 do begin
         ximm:=round((PPointArray(PolyPoints)[i-1].x-PolyBaseX1)*zx)+x1;
         yimm:=round((PPointArray(PolyPoints)[i-1].y-PolyBaseY1)*zy)+y1;
         if i=ppc then begin
            // close polygon
            xi:=round((PPointArray(PolyPoints)[0].x-PolyBaseX1)*zx)+x1;
            yi:=round((PPointArray(PolyPoints)[0].y-PolyBaseY1)*zy)+y1;
         end else begin
            xi:=round((PPointArray(PolyPoints)[i].x-PolyBaseX1)*zx)+x1;
            yi:=round((PPointArray(PolyPoints)[i].y-PolyBaseY1)*zy)+y1;
         end;
         m00_sum := 0.5 * (yi * ximm - xi * yimm);
         m00 := m00+ m00_sum;
         m10_sum := 0.5 * (xi + ximm) * m00_sum;
         m10_sum := m10_sum- (0.5 * ((yi - yimm) * (xi * xi + xi * ximm + ximm * ximm) / 6.0));
         m10 := m10+m10_sum;
         m01_sum := 0.5 * (yi + yimm) * m00_sum;
         m01_sum := m01_sum+(0.5 * ((xi - ximm) * (yi * yi + yi * yimm + yimm * yimm) / 6.0));
         m01 := m01+ m01_sum;
         m11_sum := 0.5 * m00_sum;
         m11 := m11+(m11_sum * (2.0 * xi * yi + ximm * yi + xi * yimm + 2.0 * ximm * yimm) / 6.0);
         m20_sum := m00_sum * (xi * xi + xi * ximm + ximm * ximm) / 3.0;
         m20_sum := m20_sum-(0.5 * (yi - yimm) * (xi * xi * xi + xi * xi * ximm + xi * ximm * ximm + ximm * ximm * ximm) / 6.0);
         m20 := m20+m20_sum;
         m02_sum := m00_sum * (yi * yi + yi * yimm + yimm * yimm) / 3.0;
         m02_sum := m02_sum+(0.5 * (xi - ximm) * (yi * yi * yi + yi * yi * yimm + yi * yimm * yimm + yimm * yimm * yimm) / 6.0);
         m02 := m02+m02_sum;
      end;
      // correct sign of raw moments if necessary
      if (m00 < 0) then begin
         m00 := m00*(-1.0);
         m10 := m10*(-1.0);
         m01 := m01*(-1.0);
         m11 := m11*(-1.0);
         m20 := m20*(-1.0);
         m02 := m02*(-1.0);
      end;
      // centroid
      pvc^.x := trunc(m10 / m00);
      pvc^.y := trunc(m01 / m00);
      // find curvature points closest to and farthest from the centroid
      i_max := 0;
      i_min := 0;
      d_max := 0;
      d_min := 1000;
      for i := 1 to nv-1 do begin
         if i=ppc then begin
            // close polygon
            xi:=round((PPointArray(PolyPoints)[0].x-PolyBaseX1)*zx)+x1;
            yi:=round((PPointArray(PolyPoints)[0].y-PolyBaseY1)*zy)+y1;
         end else begin
            xi:=round((PPointArray(PolyPoints)[i].x-PolyBaseX1)*zx)+x1;
            yi:=round((PPointArray(PolyPoints)[i].y-PolyBaseY1)*zy)+y1;
         end;
         d_xy := sqrt(SQR(xi - pvc^.x) + SQR(yi - pvc^.y));
         if (d_xy > d_max) then begin
            d_max := d_xy;
            i_max := i;
         end;
         if (d_xy < d_min) then begin
            d_min := d_xy;
            i_min := i;
         end;
      end;
      // central moments and radius of gyration
      mu := m00;
      mu11 := m11 - m00 * (m10 / m00) * (m01 / m00);
      mu20 := m20 - m00 * SQR(m10 / m00);
      mu02 := m02 - m00 * SQR(m01 / m00);
      rad_gyr := sqrt(ABS(mu20 + mu02) / mu);
      dent := ABS(((mu02 / mu20) - 1.0));
      if ((dent < DENT_CUTOFF) and (ABS(mu11) < MU11_EPS)) then
         circle := 1;
      // invariant moments
      musq := SQR(mu);
      phi_1 := (mu20 + mu02) / musq;
      phi_2 := SQR((mu20 - mu02) / musq) + 4.0 * SQR (mu11 / musq);
      // determine principal axes
      mu02_div_mu20 := mu02 / mu20;
      tg_tth := 2.0 * (mu11 / mu20) / (1.0 - mu02_div_mu20);
      // check limits
      if (ABS(tg_tth) < 0.01) then begin
         if (ABS(mu20) / ABS(mu02) >= 1.0) then
            horizontal := 1;
         if (ABS(mu20) / ABS(mu02) <= 1.0) then
            vertical := 1;
      end;
      sq_root := sqrt(1.0 + 1.0 / SQR(tg_tth));
      // determine proper direction of principal (major) axis
      mu11mu20_sign := IESIGN(mu11) * IESIGN(mu20);
      if ( mu11mu20_sign > 0) then begin
         quad_IV := 1;             // quadr II->IV
         if (mu02_div_mu20 <= 1.0) then
            tg_tth := -ABS(tg_tth)
         else
            tg_tth := ABS (tg_tth);
         tg_th1 := (-1.0 / tg_tth) - sq_root;
         tg_th2 := (-1.0 / tg_tth) + sq_root;
      end else if (mu11mu20_sign < 0) then begin
         quad_I := 1;              // quadr III->I
         if (mu02_div_mu20 <= 1.0) then
            tg_tth := ABS (tg_tth)
         else
            tg_tth := -ABS (tg_tth);
         tg_th1 := (-1.0 / tg_tth) + sq_root;
         tg_th2 := (-1.0 / tg_tth) - sq_root;
      end;
      // determine coordinates of endpoints of line segments
      x2_major := (d_max / sqrt(1.0 + SQR(tg_th1)));
      x2_minor := (d_max / sqrt (1.0 + SQR(tg_th2)));
      if (quad_I = 1) then begin
         y2_major := pvc^.y - ABS(tg_th1) * x2_major;
         y2_minor := pvc^.y + ABS(tg_th2) * x2_minor;
      end;
      if (quad_IV = 1) then begin
         y2_major := pvc^.y + ABS(tg_th1) * x2_major;
         y2_minor := pvc^.y - ABS(tg_th2) * x2_minor;
      end;
      x2_major := x2_major+ pvc^.x;
      x2_minor := x2_minor+ pvc^.x;
      // axes mirror
      dd:=trunc(abs(pvc^.x-x2_major));
      if x2_major>pvc^.x then
         x1_major:=pvc^.x-dd
      else
         x1_major:=pvc^.x+dd;
      dd:=trunc(abs(pvc^.y-y2_major));
      if y2_major>pvc^.y then
         y1_major:=pvc^.y-dd
      else
         y1_major:=pvc^.y+dd;
      dd:=trunc(abs(pvc^.x-x2_minor));
      if x2_minor>pvc^.x then
         x1_minor:=pvc^.x-dd
      else
         x1_minor:=pvc^.x+dd;
      dd:=trunc(abs(pvc^.y-y2_minor));
      if y2_minor>pvc^.y then
         y1_minor:=pvc^.y-dd
      else
         y1_minor:=pvc^.y+dd;
      // find the intersection with original polygon
      majorA:=Point(-1,-1);
      majorB:=Point(-1,-1);
      minorA:=Point(-1,-1);
      minorB:=Point(-1,-1);
      for i := 1 to nv-1 do begin
         ximm:=round((PPointArray(PolyPoints)[i-1].x-PolyBaseX1)*zx)+x1;
         yimm:=round((PPointArray(PolyPoints)[i-1].y-PolyBaseY1)*zy)+y1;
         if i=ppc then begin
            // close polygon
            xi:=round((PPointArray(PolyPoints)[0].x-PolyBaseX1)*zx)+x1;
            yi:=round((PPointArray(PolyPoints)[0].y-PolyBaseY1)*zy)+y1;
         end else begin
            xi:=round((PPointArray(PolyPoints)[i].x-PolyBaseX1)*zx)+x1;
            yi:=round((PPointArray(PolyPoints)[i].y-PolyBaseY1)*zy)+y1;
         end;
         if IEIntersect( trunc(x1_major),trunc(y1_major),trunc(x2_major),trunc(y2_major), trunc(ximm),trunc(yimm),trunc(xi),trunc(yi), x,y ) then begin
            if (majorA.x)=-1 then begin
               majorA.x:=x;
               majorA.y:=y;
               imajorA:=i;
            end else begin
               majorB.x:=x;
               majorB.y:=y;
               imajorB:=i;
            end;
         end;
         if IEIntersect( trunc(x1_minor),trunc(y1_minor),trunc(x2_minor),trunc(y2_minor), trunc(ximm),trunc(yimm),trunc(xi),trunc(yi), x,y ) then begin
            if (minorA.x)=-1 then begin
               minorA.x:=x;
               minorA.y:=y;
               iminorA:=i;
            end else begin
               minorB.x:=x;
               minorB.y:=y;
               iminorB:=i;
            end;
         end;
      end;
      OrdCor(majorA.x,majorA.y,majorB.x,majorB.y);
      OrdCor(minorA.x,minorA.y,minorB.x,minorB.y);
      Centroid:=Point(trunc(pvc^.x), trunc(pvc^.y));
      MajorAxis:=Rect(majorA.x,majorA.y,majorB.x,majorB.y);
      MinorAxis:=Rect(minorA.x,minorA.y,minorB.x,minorB.y);
      mu00:=mu;
      // calc bounding quadrilater

      i:=addnewobject;
      objkind[i]:=iekLINE;
      objpencolor[i]:=clred;
      setobjrect(i,MajorAxis);
      i:=addnewobject;
      objkind[i]:=iekLINE;
      objpencolor[i]:=clred;
      setobjrect(i,MinorAxis);

      if PolyPointsCount>3 then begin
         ptop:=point(1000000,1000000);
         pleft:=point(1000000,1000000);
         pbottom:=point(-1000000,-1000000);
         pright:=point(-1000000,-1000000);
         for i:=0 to PolyPointsCount-1 do begin
            x:=round((PPointArray(PolyPoints)[i].x-PolyBaseX1)*zx)+x1;
            y:=round((PPointArray(PolyPoints)[i].y-PolyBaseY1)*zy)+y1;
            if y<ptop.y then begin
               ptop.y:=y;
               ptop.x:=x;
            end;
            if y>pbottom.y then begin
               pbottom.y:=y;
               pbottom.x:=x;
            end;
            if x<pleft.x then begin
               pleft.x:=x;
               pleft.y:=y;
            end;
            if x>pright.x then begin
               pright.x:=x;
               pright.y:=y;
            end;
         end;
      end;

      i:=addnewobject;
      objkind[i]:=iekBITMAP;
      setobjrect(i,rect(ptop.x-5,ptop.y-5,ptop.x+5,ptop.y+5));
      i:=addnewobject;
      objkind[i]:=iekBITMAP;
      setobjrect(i,rect(pbottom.x-5,pbottom.y-5,pbottom.x+5,pbottom.y+5));
      i:=addnewobject;
      objkind[i]:=iekBITMAP;
      setobjrect(i,rect(pleft.x-5,pleft.y-5,pleft.x+5,pleft.y+5));
      i:=addnewobject;
      objkind[i]:=iekBITMAP;
      setobjrect(i,rect(pright.x-5,pright.y-5,pright.x+5,pright.y+5));

   end;
end;
*)

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Remove jagged edges

//(*
type PixelEdge=record
	x,y:integer;
 	dir:integer;
end;
PixelEdgeArray=array [0..Maxint div 16] of PixelEdge;
PPixelEdgeArray=^PixelEdgeArray;

type Edgelist=record
	Nedges:integer;
	current:integer;
	list:PPixelEdgeArray;
end;

type IntPoint2=record
	x, y:integer;
end;
PIntPoint2=^IntPoint2;
IntPoint2Array=array [0..Maxint div 16] of IntPoint2;
PIntPoint2Array=^IntPoint2Array;

type Pedge=record
   x1,y1:integer;
   x2,y2:integer;
end;
PPedge=^Pedge;

type Bound=record
   ly,lx:integer;
   uy,ux:integer;
end;
PBound=^Bound;

const HRZ=1;
const VRT=2;
const SUBPIXRES=32;
//const SUBPIXRES=2;

const HalfSUBPIXRES=(SUBPIXRES div 2);
const ESTABLISHED=127;
const MAXRUN=2000;

function MidX(e:Pedge):integer;
begin
	result:= (e.x1+e.x2) div 2;
end;

function MidY(e:Pedge):integer;
begin
	result:=(e.y1+e.y2) div 2;
end;

function Is_Horizontal(d:integer):boolean;
begin
	result:= abs(d)=HRZ;
end;

function Is_Vertical(d:integer):boolean;
begin
	result:= abs(d)=VRT;
end;

function against(a:integer; b:integer):boolean;
begin
	result:= (a+b)=0;
end;

function slopecmp(dy1,dx1, dy2,dx2:integer):boolean;
begin
   result:= (dx2*dy1) > (dx1*dy2);
end;


function Bound_OK(b:Bound):boolean;
begin
	result:= slopecmp(b.uy,b.ux,b.ly,b.lx);
end;

function Get_Pedge(el:Edgelist; var e:Pedge):PPedge;
var
	dir:integer;
begin
   if (el.current>=el.Nedges) then begin
   	result:=nil;
      exit;
   end;
   dir:=el.list[el.current].dir;
   if (Is_Horizontal(dir)) then begin
   	e.y2:=el.list[el.current].y*SUBPIXRES + HalfSUBPIXRES;
      e.y1:=e.y2;
      if dir>0 then
	      e.x1:=el.list[el.current].x*SUBPIXRES- (HalfSUBPIXRES)
      else
			e.x1:=el.list[el.current].x*SUBPIXRES- (-HalfSUBPIXRES);
      if dir>0 then
      	e.x2:=e.x1 + (SUBPIXRES)
      else
			e.x2:=e.x1 + (-SUBPIXRES);
 	end else begin
   	e.x2:=el.list[el.current].x*SUBPIXRES + HalfSUBPIXRES;
      e.x1:=e.x2;
      if dir>0 then
	      e.y1:=el.list[el.current].y*SUBPIXRES- (HalfSUBPIXRES)
      else
      	e.y1:=el.list[el.current].y*SUBPIXRES- (-HalfSUBPIXRES);
      if dir>0 then
	      e.y2:=e.y1 + (SUBPIXRES)
      else
      	e.y2:=e.y1 + (-SUBPIXRES);
 	end;
   result:=@e;
end;

function wayof(e:Pedge):integer;
var
	d:integer;
begin
 	d:=e.x2-e.x1;
   if d<>0 then
	   result:= d div SUBPIXRES
   else
		result:= (e.y2 - e.y1) div HalfSUBPIXRES;
end;

procedure qforward(var el:EdgeList);
begin
	inc(el.current);
end;

procedure backward(var el:EdgeList);
begin
	dec(el.current);
end;

procedure calcbound(dominantdir:integer; e:Pedge; Sx, Sy:integer; b:PBound; gradU:PIntPoint2; gradL:PIntPoint2);
var
	dy,dx:integer;
   p:IntPoint2;
begin
   if Is_Horizontal(dominantdir) then begin
      b^.uy := (e.y1+e.y2+SUBPIXRES)div 2-Sy;
      b^.ux := (e.x1+e.x2)div 2          -Sx;
      b^.ly := (e.y1+e.y2-SUBPIXRES)div 2-Sy;
      b^.lx := b^.ux;
      gradL^.x := b^.lx;
      gradU^.x := gradL^.x;
      gradU^.y := b^.uy-1;
      gradL^.y := b^.ly+1;
   end else begin
      b^.uy := (e.y1+e.y2)div 2 -Sy;
      b^.ux := (e.x1+e.x2+SUBPIXRES)div 2-Sx;
      b^.ly := b^.uy;
      gradL^.y := b^.ly;
      gradU^.y := gradL^.y;
      b^.lx := (e.x1+e.x2-SUBPIXRES)div 2-Sx;
      gradU^.x := b^.ux-1;
      gradL^.x := b^.lx+1;
   end;
   if (not Bound_OK(b^)) then begin
      dx:=b^.ux;    dy:=b^.uy;
      b^.ux:=b^.lx; b^.uy:=b^.ly;
      b^.lx:=dx;    b^.ly:=dy;
      p:=gradU^; gradU^:=gradL^; gradL^:=p;
   end;
end;

function WithinBound(dy,dx:integer;b:Bound):boolean;
begin
	result:= slopecmp(dy,dx,b.ly,b.lx) and slopecmp(b.uy,b.ux,dy,dx);
end;

function XIF(cmp:boolean; v1,v2:integer):integer;
begin
	if cmp then
   	result:=v1
   else
   	result:=v2;
end;

// reversible straight line edge reconstruction
function fitlines(el:Edgelist; Pretest:boolean; TryAllEndPts:boolean; lines:PIntPoint2Array; MaxNLine:integer):integer;
var
   i,linescount,startp,Nendpt,Nstartpt,NPedges,Nbound:integer;
   Sx,Sy,Ex,Ey,  Ux,Uy,Lx,Ly,  maindir,trnsvrse,dnow,  ndir:integer;
   dir:array [0..2] of integer;
   breaktrace, starttrace:boolean;
   currentsave, bestpt, maxlen, bestpt_currentsave, bestpt_Nendpt:integer;
   startpts,endlist,bestpt_endlist:array [0..SUBPIXRES-1] of IntPoint2;
   Pedgehistory:array [0..MAXRUN-1] of Pedge;
   e,last,estartsave,bestpt_last:Pedge;
   nextp:PPedge;
   qbound:array [0..MAXRUN-1] of Bound;
   b:Bound;
   gradU,gradL:IntPoint2;
   lowerupdated, upperupdated:boolean;
   dx,dy,tmp:integer;
   exact,EndptOK:boolean;
   h,addy,addx:integer;
   staticpedge:Pedge;
   hori:boolean;
begin
	Ex:=0;
   Ey:=0;
   Nendpt:=0;
   dnow:=0;
   Nstartpt:=0;
   ndir:=0;
   breaktrace:=false;
   NPedges:=0;
   maindir:=0;
   currentsave:=0;
	maxlen:=0;
   trnsvrse:=0;
   el.current:=0;
   startp:=0;
   e := Get_Pedge(el,staticpedge)^;
   Sx := MidX(e);
   Sy := MidY(e);
 	if (not TryAllEndPts) then begin
      lines[0].x := Sx;
      lines[0].y := Sy;
      linescount:=1;
 	end else begin
  		hori := Is_Horizontal(wayof(e));
      Nstartpt:=0;
      startpts[0].x := Sx;
      startpts[0].y := Sy;
      //(*
      for i:=1 to HalfSUBPIXRES-1 do begin
      	if hori then
         	startpts[Nstartpt  ].x :=  Sx-i
         else
         	startpts[Nstartpt  ].x :=  Sx;
         if not hori then
	         startpts[Nstartpt].y := Sy+i
         else
         	startpts[Nstartpt].y := Sy;
         inc(Nstartpt);
         if hori then
	         startpts[Nstartpt  ].x :=  Sx-i
         else
         	startpts[Nstartpt  ].x :=  Sx;
         if not hori then
	         startpts[Nstartpt].y := Sy+i
         else
         	startpts[Nstartpt].y := Sy;
         inc(Nstartpt);
      end;
      //*)
      currentsave:=el.current;
      bestpt_currentsave:=currentsave;
      estartsave:=e;
      bestpt:=-1;
      maxlen:=bestpt;
      linescount:=0;
	end;
   Nbound:=0;
   starttrace:=true;
   while true do begin
   	if (starttrace) then begin
         dir[0]:=wayof(e);
         ndir:=1;
         starttrace:=false;
         breaktrace:=false;
         Pedgehistory[0]:=e;
         NPedges:=1;
         Nbound:=0;
    	end;
	   last:=e;
  		qforward(el);
      nextp:=Get_Pedge(el,staticpedge);
      if nextp<>nil then begin
         Pedgehistory[NPedges]:=nextp^;
         inc(NPedges);
         e:=nextp^;
         dnow:=wayof(e);
      end;
		if (nextp=nil) or (ndir=ESTABLISHED) then begin
		   if (nextp<>nil) then begin
    			calcbound(maindir,e,Sx,Sy,@b,@gradU,@gradL);
            qbound[Nbound]:=qbound[Nbound-1];
		    	lowerupdated:=upperupdated=FALSE;
    			if (slopecmp(qbound[Nbound-1].uy,qbound[Nbound-1].ux,b.uy,b.ux)) then begin
               qbound[Nbound].uy:=b.uy;
               qbound[Nbound].ux:=b.ux;
               upperupdated:=TRUE;
    			end;
    			if (slopecmp(b.ly,b.lx,qbound[Nbound-1].ly,qbound[Nbound-1].lx)) then begin
               qbound[Nbound].ly:=b.ly;
               qbound[Nbound].lx:=b.lx;
               lowerupdated:=TRUE;
    			end;
   		end;
   		if (nextp=nil) or
         ((dnow<>trnsvrse) and (dnow<>maindir)) or
         ((dnow=trnsvrse) and (dnow=wayof(last))) or
         (not Bound_OK(qbound[Nbound])) or
         (Pretest and
          ((lowerupdated and (not WithinBound(gradU.y,gradU.x,qbound[Nbound]))) or
           (upperupdated and (not WithinBound(gradL.y,gradL.x,qbound[Nbound]))))) then begin
    			while true do begin
            	Ex:=MidX(last); Ey:=MidY(last);
     				if (Nbound=0) then begin
      				if (TryAllEndPts) then begin
       					endlist[0].x:=Ex;
                     endlist[0].y:=Ey;
       					Nendpt:=1;
      				end;
      				break;
     				end;
     				b := qbound[Nbound-1];
               dx:= Ex - Sx;
               dy:= Ey - Sy;
     				if TryAllEndPts and (el.current-currentsave>maxlen) then begin
       				if abs(maindir)=1 then begin
                  	addy:=1;
                     addx:=0;
                  end else begin
                  	addy:=0;
                  	addx:=1;
               	end;
       				if WithinBound(dy,dx,b) then begin
        					endlist[0].x:=Ex;
                  	endlist[0].y:=Ey;
                  	Nendpt:=1;
       				end else
               		Nendpt:=0;
                  //(*
                  for h:=1 to (SUBPIXRES div 2)-1 do begin
                     if (WithinBound(dy+addy*h,dx+addx*h,b)) then begin
                        endlist[Nendpt  ].x := Ex + addx*h;
                        endlist[Nendpt].y := Ey + addy*h;
                        inc(Nendpt);
                     end else if (WithinBound(dy-addy*h,dx-addx*h,b)) then begin
                        endlist[Nendpt  ].x := Ex - addx*h;
                        endlist[Nendpt].y := Ey - addy*h;
                        inc(Nendpt);
                     end;
                  end;
                  //*)
                  Ex:=endlist[0].x;
                  Ey:=endlist[0].y;
                  EndptOK := Nendpt>0;
         		end else begin
      				if not slopecmp(dy,dx,b.ly,b.lx) then begin
       					if Is_Horizontal(maindir) then begin
        						tmp:= dx*b.ly;
                        exact:= (dx=0) or ((tmp mod b.lx)=0);
        						Ey := tmp div b.lx + Sy + XIF(b.lx>0, XIF(b.ly>0,1,integer(exact)) , XIF(b.ly>0,-integer(exact),-1) );
       					end else begin
        						tmp:= dy*b.lx;
                        exact:= (dy=0) or ((tmp mod b.ly)=0);
        						Ex := tmp div b.ly + Sx + XIF(b.ly>0, XIF(b.lx>0,-integer(exact),-1) , XIF(b.lx>0,1,integer(exact)));
       					end;
       					EndptOK := Pretest or WithinBound(Ey-Sy,Ex-Sx,b);
      				end else if (not slopecmp(b.uy,b.ux,dy,dx)) then begin
       					if (Is_Horizontal(maindir)) then begin
        						tmp:= dx*b.uy;
                        exact:= ((tmp mod b.ux)=0);
        						Ey := tmp div b.ux + Sy + XIF(b.ux>0, XIF(b.uy>0,-integer(exact),1) , XIF(b.uy>0,1,integer(exact)));
       					end else begin
        						tmp:= dy*b.ux;
                        exact:= ((tmp mod b.uy)=0);
        						Ex := tmp div b.uy + Sx + XIF(b.uy>0, XIF(b.ux>0,1,integer(exact)) , XIF(b.ux>0,-integer(exact),-1));
       					end;
       					EndptOK := Pretest or WithinBound(Ey-Sy,Ex-Sx,b);
      				end else
      					EndptOK:=true;
            	end;
               if (EndptOK) then
                  break
               else begin
                  backward(el);
                  dec(NPedges);
                  last := Pedgehistory[NPedges-2];
                  dec(Nbound);
               end;
    			end;
    			breaktrace:=TRUE;
         end else begin
            inc(Nbound);
            continue;
         end;
      end else begin
         breaktrace := FALSE;
         if (ndir<3) then begin
            for i:=0 to ndir-1 do begin
               if (against(dnow,dir[i])) then begin
                  breaktrace := TRUE;
                  Ex:=MidX(last);
                  Ey:=MidY(last);
                  if (TryAllEndPts) then begin
                     endlist[0].x:=Ex;
                     endlist[0].y:=Ey;
                     Nendpt:=1;
                  end;
               end;
            end;
            if ((ndir<2) or (dnow<>dir[1]) or (dir[0]<>dir[1])) then begin
               dir[ndir]:=dnow;
               inc(ndir);
            end;
         end;
         if (ndir=3) then begin
            if (dir[0]<>dir[1]) then begin
               maindir:=dir[2];
               if (dir[1]=dir[2]) then begin
                  trnsvrse:=dir[0];
                  if (Is_Horizontal(maindir)) then begin
                  	Lx := MidX(e) - Sx;
                     Ux := Lx;
                     Ly := e.y1-Sy-HalfSUBPIXRES;
                     Uy := Ly +SUBPIXRES;
                  end else begin
                  	Ly := MidY(e) - Sy;
                     Uy := Ly;
                     Lx := e.x1-Sx-HalfSUBPIXRES;
                     Ux := Lx +SUBPIXRES;
                  end;
               end else begin
                  trnsvrse:=dir[1];
                  if (Is_Horizontal(maindir)) then begin
                  	Ux := MidX(e)-Sx;
                     Lx := Ux;
                     Uy := MidY(e)+HalfSUBPIXRES-Sy;
                     Ly := Uy -SUBPIXRES;
                  end else begin
                  	Uy := MidY(e)-Sy;
                     Ly := Uy;
                     Ux := MidX(e)+HalfSUBPIXRES-Sx;
                     Lx := Ux -SUBPIXRES;
                  end;
               end;
            end else begin
               maindir:=dir[0];
               trnsvrse:=dir[2];
               if (Is_Horizontal(maindir)) then begin
                  Lx := e.x1 + XIF(maindir>0, -HalfSUBPIXRES , HalfSUBPIXRES) - Sx;
                  Ux := Lx + XIF(maindir>0 , SUBPIXRES , -SUBPIXRES);
                  Ly := MidY(e) - Sy;
                  Uy := Ly;
               end else begin
                  Ly := e.y1 + XIF(maindir>0 , -HalfSUBPIXRES , HalfSUBPIXRES) - Sy ;
                  Uy := Ly + XIF(maindir>0 , SUBPIXRES , -SUBPIXRES);
                  Lx := MidX(e) - Sx;
                  Ux := Lx;
               end;
            end;
            if (slopecmp(Ly,Lx,Uy,Ux)) then begin
               qbound[0].uy:=Ly; qbound[0].ux:=Lx;
               qbound[0].ly:=Uy; qbound[0].lx:=Ux;
            end else begin
               qbound[0].uy:=Uy; qbound[0].ux:=Ux;
               qbound[0].ly:=Ly; qbound[0].lx:=Lx;
            end;
            Nbound:=1;
            ndir := ESTABLISHED;
         end;
      end;
      if (breaktrace) then begin
         backward(el);
         if (TryAllEndPts) then begin
            if (maxlen < (el.current-currentsave)) then begin
               maxlen := el.current-currentsave;
               bestpt_last:=last;
               bestpt:=startp;
               bestpt_currentsave:=el.current;
               for i:=0 to Nendpt-1 do
                  bestpt_endlist[i]:=endlist[i];
               bestpt_Nendpt:=Nendpt;
            end;
            inc(startp);
            if (startp >= Nstartpt) then begin
            	el.current:=bestpt_currentsave;
               currentsave:=el.current;
               e:=bestpt_last;
               estartsave:=e;
               lines[linescount] := startpts[bestpt];
					inc(linescount);
               if (linescount>=MaxNLine) then begin
                  result:=-1;
                  exit;
               end;
               if (bestpt_currentsave>=el.Nedges-1) then begin
                  lines[linescount]:=bestpt_endlist[0];
                  inc(linescount);
                  result:= XIF(linescount>=MaxNLine , -1 , linescount);
                  exit;
               end;
               Nstartpt:=bestpt_Nendpt;
               for i:=0 to bestpt_Nendpt-1 do
                  startpts[i]:=bestpt_endlist[i];
               startp:=0;
               Sx:=startpts[0].x;
               Sy:=startpts[0].y;
               bestpt:=-1;
               maxlen:=bestpt;
            end else begin
               Sx:=startpts[startp].x;
               Sy:=startpts[startp].y;
               el.current:=currentsave;
               last:=estartsave;
               e:=last;
            end;
         end else begin
            Sx:=Ex; Sy:=Ey; e:=last;
            lines[linescount].x:=Ex;
            lines[linescount].y:=Ey;
            inc(linescount);
            if (linescount>=MaxNLine) then begin
               result:=-1;
               exit;
            end;
            if (el.current>=el.Nedges-1) then begin
               result:=linescount;
               exit;
            end;
         end;
         starttrace:=TRUE;
      end;
 	end;
end;

// the routine can fail (return false)
// can smooth angles
function TImageEnVect.RemovePolygonJaggedEdges(hobj:integer):boolean;
var
   zx,zy:double;
   i:integer;
   el:EdgeList;
   lines:PIntPoint2Array;
   cc:integer;
	//
   procedure CalcDir(a,b:integer);
   begin
      if el.list[a].x=el.list[b].x then begin
         if el.list[a].y<el.list[b].y then
            el.list[a].dir:=VRT
         else
            el.list[a].dir:=-VRT;
      end else begin
         if el.list[a].y<el.list[b].y then
            el.list[a].dir:=HRZ
         else
            el.list[a].dir:=-HRZ;
      end;
   end;
   //
begin
	result:=false;
	with GetObj(hobj)^ do
   	if Kind=iekPOLYLINE then begin
      	el.Nedges:=PolyPointsCount;
      	getmem(el.list,el.Nedges * sizeof(PixelEdge));
         CalcZxZyPolyline(GetObj(hobj),zx,zy);
         for i:=0 to PolyPointsCount-1 do begin
            el.list[i].x:=(round((PPointArray(PolyPoints)[i].x-PolyBaseX1)*zx)+x1);
            el.list[i].y:=(round((PPointArray(PolyPoints)[i].y-PolyBaseY1)*zy)+y1);
            if i>0 then
            	CalcDir(i-1,i);
			end;
			CalcDir(PolyPointsCount-1,0);
         getmem(lines, PolyPointsCount * sizeof(IntPoint2) );
         try
			cc:=fitlines(el,true,true, lines, PolyPointsCount);
         if cc>2 then begin
            for i:=0 to cc-1 do begin
               lines[i].x:=lines[i].x div SUBPIXRES ;
               lines[i].y:=lines[i].y div SUBPIXRES ;
            end;
            SetObjPolylinePoints(hobj,slice(ppointarray(lines)^,cc));
            result:=true;
         end;
         except
	         freemem(el.list);
   	      freemem(lines);
         end;
         freemem(el.list);
         freemem(lines);
      end;
   Update;
end;

//*)

// end of remove jagged edges
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Polyline simplify

type Vector=record
	x,y:double;
end;
type Segment=record
	P0,P1:Vector;
end;

// difference
function diff(u,v:Vector):Vector;
begin
	result.x:=u.x-v.x;
   result.y:=u.y-v.y;
end;
// dot product
function dot(u,v:Vector):double;
begin
	result:= u.x * v.x + u.y * v.y;
end;
// squared length of vector
function norm2(v:Vector):double;
begin
	result:=dot(v,v);
end;
// length of vector
function norm(v:Vector):double;
begin
	result:=sqrt(norm2(v));
end;
// distance squared
function d2(u,v:Vector):double;
begin
	result:=norm2(diff(u,v));
end;
// distance
function d(u,v:Vector):double;
begin
	result:=norm(diff(u,v));
end;
// sum
function sum(u,v:Vector):Vector;
begin
	result.x:=u.x+v.x;
   result.y:=u.y+v.y;
end;
// vector*scalar
function mulvs(u:Vector; s:double):Vector;
begin
	result.x:=u.x*s;
   result.y:=u.y*s;
end;
// TPoint to Vector
function tpv(p:TPoint):Vector;
begin
	result.x:=p.x;
   result.y:=p.y;
end;

//  This is the Douglas-Peucker recursive simplification routine
procedure simplifyDP( tol:double; v:PPointArray; j, k:integer; mk:pintegerarray );
var
	maxi,i:integer;
   maxd2:double;
   tol2:double;
   S:Segment;
   u:Vector;
   cu:double;
   w:Vector;
   Pb:Vector;
   b, cw, dv2:double;
begin
	if (k <= j+1) then
   	exit;
   maxi := j;
   maxd2 := 0;
   tol2 := tol * tol;
   S.P0 := tpv(v[j]);
   S.P1 := tpv(v[k]);
   u := diff(S.P1 , S.P0);
   cu := dot(u,u);
   for i:=j+1 to k-1 do begin
   	w := diff(tpv(v[i]) , S.P0);
      cw := dot(w,u);
      if ( cw <= 0 ) then
      	dv2 := d2(tpv(v[i]), S.P0)
      else if ( cu <= cw ) then
      	dv2 := d2(tpv(v[i]), S.P1)
      else begin
      	b := cw / cu;
         Pb := sum(S.P0 , mulvs(u,b));
         dv2 := d2(tpv(v[i]), Pb);
      end;
      if (dv2 <= maxd2) then
      	continue;
      maxi := i;
      maxd2 := dv2;
    end;
    if (maxd2 > tol2) then begin
        mk[maxi] := 1;
        simplifyDP( tol, v, j, maxi, mk );
        simplifyDP( tol, v, maxi, k, mk );
    end;
end;

// tol = tolerance
// V : input array
// n : length of input array
// sV : output array
// ret length of output array
function poly_simplify(tol:double; V:PPointArray; n:integer; sV:PPointArray ):integer;
var
   i, k, m, pv:integer;
   tol2:double;
   vt:PPointArray;
   mk:pintegerarray;
begin
	tol2 := tol * tol;
   getmem(vt,n * sizeof(TPoint));
   mk := allocmem(n * sizeof(integer));	// need to zero
   // Vertex Reduction within tolerance of prior vertex cluster
   vt[0] := V[0];
   k:=1; pv:=0;
   for i:=1 to n-1 do begin
   	if d2(tpv(V[i]),tpv(V[pv])) < tol2 then
      	continue;
      vt[k] := V[i];
      inc(k);
      pv := i;
   end;
   if (pv < n-1) then begin
   	vt[k] := V[n-1];
      inc(k);
   end;
   // Douglas-Peucker polyline simplification
   mk[k-1] := 1;
   mk[0] := mk[k-1];
   simplifyDP( tol, vt, 0, k-1, mk );
   //
   m:=0;
   for i:=0 to k-1 do
   	if (mk[i]<>0) then begin
      	sV[m] := vt[i];
         inc(m);
      end;
   freemem(vt);
   freemem(mk);
   result:=m;
end;

procedure TImageEnVect.SimplifyPolygon(hobj:integer; MaxPoints:integer);
var
   zx,zy:double;
   i:integer;
   ia,oa:PPointArray;
   tolerance:double;
begin
	with GetObj(hobj)^ do
   	if Kind=iekPOLYLINE then begin
         tolerance:=0.1;
         repeat
            getmem(ia,sizeof(TPoint)*PolyPointsCount);
            getmem(oa,sizeof(TPoint)*PolyPointsCount);
            CalcZxZyPolyline(GetObj(hobj),zx,zy);
            for i:=0 to PolyPointsCount-1 do begin
               ia[i].x:=(round((PPointArray(PolyPoints)[i].x-PolyBaseX1)*zx)+x1);
               ia[i].y:=(round((PPointArray(PolyPoints)[i].y-PolyBaseY1)*zy)+y1);
            end;
            i:=poly_simplify(tolerance,ia,PolyPointsCount,oa);
            SetObjPolylinePoints(hobj,slice(ppointarray(oa)^,i));
            freemem(oa);
            freemem(ia);
            tolerance:=tolerance+0.1;
         until i<=MaxPoints;
      end;
   Update;
end;

// End of Polyline simplify
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


procedure TImageEnVect.CalcZxZyPolyline(Obj:PIEVObject; var zx,zy:double);
var
	dd:integer;
begin
	with Obj^ do begin
      dd:=PolyBaseX2-PolyBaseX1;
      if dd<>0 then zx:=(x2-x1)/dd else zx:=1;
      dd:=PolyBaseY2-PolyBaseY1;
      if dd<>0 then zy:=(y2-y1)/dd else zy:=1;
   end;
end;

procedure TImageEnVect.RecalcPolylineBox(Obj:PIEVObject);
var
	zx,zy:double;
   xx,yy,i:integer;
   pts:ppointarray;
   nx1,ny1,nx2,ny2:integer;
begin
	CalcZxZyPolyline(Obj,zx,zy);
   with Obj^ do begin
   	pts:=ppointarray(PolyPoints);
      nx1:=1000000; ny1:=1000000; nx2:=-1000000; ny2:=-1000000;
      for i:=0 to PolyPointsCount-1 do begin
         xx:=round((PPointArray(PolyPoints)[i].x-PolyBaseX1)*zx)+x1;
         yy:=round((PPointArray(PolyPoints)[i].y-PolyBaseY1)*zy)+y1;
         nx1:=imin(nx1,xx);
         ny1:=imin(ny1,yy);
         nx2:=imax(nx2,xx);
         ny2:=imax(ny2,yy);
      end;
      x1:=nx1; y1:=ny1; x2:=nx2; y2:=ny2;
      PolyBasex1:=1000000; PolyBasey1:=1000000; PolyBasex2:=-1000000; PolyBasey2:=-1000000;
   	for i:=0 to PolyPointsCount-1 do begin
	   	PolyBaseX1:=imin(PolyBaseX1,pts[i].x);
         PolyBaseY1:=imin(PolyBaseY1,pts[i].y);
         PolyBaseX2:=imax(PolyBaseX2,pts[i].x);
         PolyBaseY2:=imax(PolyBaseY2,pts[i].y);
      end;
   end;
end;

// thanks to Roy Magne Klever for feather and smooth algorithms
function TImageEnVect.CreateImageFromSelectedArea(feather: integer; smooth: boolean): integer;
var
	x, y, i: integer;
	bmp: TIEBitmap;
  	// Snowing routine
  	cur_level, step, mvalue: integer;
   procedure snow_mpixel(x, y: integer);
   begin
      mvalue := bmp.AlphaChannel.Pixels_ie8[x,y];
      if (mvalue > cur_level) then begin
      	inc(cur_level, step);
      	if cur_level > 255 then
         	cur_level := 255;
        	bmp.AlphaChannel.Pixels_ie8[x,y]:=cur_level;
      end else
      	cur_level := mvalue;
   end;
	//
begin
	bmp := TIEBitmap.Create;
	CopySelectionToIEBitmap(bmp);
   bmp.AlphaChannel.Fill(0);
	for y := 0 to bmp.AlphaChannel.Height - 1 do
		for x := 0 to bmp.AlphaChannel.Width - 1 do
   		if SelectionMask.IsPointInside(x+selx1, y+sely1 ) then
        		bmp.AlphaChannel.Pixels_ie8[x,y]:=255;
	if feather > 0 then begin
		step := 256 div feather; // feather must not be 0
      // The two horizontal passes
      for y := 0 to bmp.AlphaChannel.Height - 1 do begin
         cur_level := 0;
         for x := 0 to bmp.AlphaChannel.Width - 1 do
            snow_mpixel(x, y);
         cur_level := 0;
         for x := bmp.AlphaChannel.Width - 1 downto 0 do
            snow_mpixel(x, y);
      end;
      // The two vertical passes
      for x := 0 to bmp.AlphaChannel.Width - 1 do begin
         cur_level := 0;
         for y := 0 to bmp.AlphaChannel.Height - 1 do
            snow_mpixel(x, y);
         cur_level := 0;
         for y := bmp.AlphaChannel.Height - 1 downto 0 do
            snow_mpixel(x, y);
      end;
	end;
  	if smooth then begin
   	for y := 0 to bmp.AlphaChannel.Height - 1 do
      	for x := 0 to bmp.AlphaChannel.Width - 1 do begin
        		i := 0;
        		if bmp.AlphaChannel.Pixels_ie8[x,y] <> 0 then begin
               if bmp.AlphaChannel.Pixels_ie8[x - 1, y] <> 0 then i := i + bmp.AlphaChannel.Pixels_ie8[x - 1, y];
               if bmp.AlphaChannel.Pixels_ie8[x + 1, y] <> 0 then i := i + bmp.AlphaChannel.Pixels_ie8[x + 1, y];
               if bmp.AlphaChannel.Pixels_ie8[x, y - 1] <> 0 then i := i + bmp.AlphaChannel.Pixels_ie8[x, y - 1];
               if bmp.AlphaChannel.Pixels_ie8[x, y + 1] <> 0 then i := i + bmp.AlphaChannel.Pixels_ie8[x, y + 1];
               i := i shr 2;
               bmp.AlphaChannel.Pixels_ie8[x, y]:= i;
        		end;
      	end;
	end;
   result := AddNewObject;
   ObjKind[result] := iekBitmap;
   ObjBitmap[result] := bmp;
   SetObjRect(result, rect(SelX1, SelY1, SelX2, SelY2));
   bmp.free;
end;

procedure TImageEnVect.DrawObjectLineLabel(wcanvas:TCanvas; lx1,ly1,lx2,ly2:integer; const aobj:TIEVObject; zz:double; var plim:trect);
var
   hfont:THandle;
   hpred:THandle;
   ph:integer;
   ox,oy:integer;
   dx,dy:integer;
   fa:double;
   x1,y1,x2,y2:integer;
begin
	if aobj.Text<>nil then begin
   	if aobj.LabelPosition=ielEnd then begin
	   	iswap(lx1,lx2);
	      iswap(ly1,ly2);
      end;
      // draw text
      with aobj.LogFont^ do begin
         lfQuality:=ANTIALIASED_QUALITY;
         ph:=lfHeight;
         lfHeight:=trunc(ph*zz);
         hfont:=CreateFontIndirect(aobj.LogFont^);
         lfHeight:=ph;
      end;
      WCanvas.Font.Color:=aobj.PenColor;
      hpred:=selectobject(wcanvas.handle,hfont);
      //
      fa:=(aobj.LogFont^.lfEscapement/10)*PI/180;	// angle in radians
      dx:=WCanvas.TextWidth(aobj.Text);
      dy:=WCanvas.TextHeight(aobj.Text);
		if lx1<lx2 then
         x1:=lx1-dx
      else
      	x1:=lx1;
      if ly1<ly2 then
      	y1:=ly1-dy
      else
      	y1:=ly1;
      x2:=x1+dx;
      y2:=y1+dy;
      ox:=0;
      oy:=trunc(y2-y1-dy*cos(fa)+dx*sin(fa)) shr 1;
      case aobj.TextAlign of
      	iejLeft:
            begin
               ox:=abs(trunc(dy*sin(fa)));
            end;
         iejRight:
            begin
               ox:=trunc(x2-x1-dx*cos(fa))
            end;
         iejCenter,iejJustify:
            begin
               ox:=trunc(x2-x1-dx*cos(fa)-dy*sin(fa)) shr 1;
            end;
      end;
      // draw rect
      WCanvas.Brush.Color:=aobj.LabelBrushColor;
      WCanvas.Brush.Style:=aobj.LabelBrushStyle;
      WCanvas.Rectangle(x1,y1,x2+1,y2+1);
      iesetplim(plim,x1,y1);
		iesetplim(plim,x2+1,y2+1);
      // draw text
      wcanvas.brush.style:=bsClear;
      WCanvas.TextRect(rect(x1,y1,x2,y2),x1+ox,y1+oy,aobj.Text);
      selectobject(wcanvas.handle,hpred);
      DeleteObject(hfont);
   end;
end;

procedure TImageEnVect.SetObjGraphicRender(Value:boolean);
begin
	fObjGraphicRender:=Value;
   Update;
end;

function dis(x0,y0,x1,y1:double):double;
begin
	x1:=x1-x0;
   y1:=y1-y0;
   result:=sqrt(x1*x1+y1*y1);
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// iekTEXT and iekMEMO text objects

procedure drawc(canvas:TCanvas; rect:TRect; x0,y0,x1,y1:double; ch:AnsiChar; rot:integer; var plim:trect);
var
	esc,x,y,w,h:integer;
   angle:double;
   lf:TLOGFONT;
   hfont:THandle;
   inv:boolean;
begin
	inv:=x0>x1;
	x1:=x1-x0;
   y1:=y1-y0;
   if rot=-10 then begin
      if ( (x1<0.01) and (x1>-0.01) ) then begin
         if y1>0 then
            esc:=2700
         else
            esc:=900;
      end else begin
         if inv then
            angle:=arctan(-y1/x1)+pi
         else
            angle:=arctan(-y1/x1);
         esc:=trunc(angle*180/PI*10+0.5);
      end;
   end else
   	esc:=rot;
	GetObject(GetCurrentObject(Canvas.Handle,OBJ_FONT),sizeof(lf),@lf);
   if lf.lfEscapement<>esc then begin
   	lf.lfEscapement:=esc;
		hfont:=CreateFontIndirect(lf);
      if hfont=0 then exit;
      DeleteObject(SelectObject(Canvas.Handle,hfont));
   end;
   x:=rect.left+trunc(x0);
   y:=rect.top+trunc(y0);
   Canvas.TextOut(x,y,ch);
   w:=Canvas.TextWidth(ch);
   h:=Canvas.TextHeight(ch);
   iesetplim(plim,x,y);
   iesetplim(plim,x-w,y-h);
	iesetplim(plim,x+w,y+h);
end;

// draw object iekTEXT or iekMEMO to the coordinates x1,y1,x2,y2 on WCanvas.
procedure TImageEnVect.DrawObjectText(wcanvas:TCanvas; x1,y1,x2,y2:integer; var aobj:TIEVObject; zz:double; drawingalpha:boolean; var plim:trect);
var
   hfont:THandle;
   hpred:THandle;
   i,ph:integer;
   ox,oy:integer;
   dx,dy:integer;
   fa:double;
   tmpMemo:TIETextControl;
   length:integer;
   dx0,dy0,dx1,dy1,curlen,lx,ly:double;
   pc:PAnsiChar;
   x00,y00:double;
   olda,slen:integer;
   perim:double;
begin
  	if aobj.Kind=iekText then begin
      if aobj.Text<>nil then
         if @aobj=GetObj(fTextEditing) then begin
            // we are painting the editing text object
            wcanvas.brush.style:=bsClear;
            wcanvas.rectangle(x1-1,y1-1,x2+1,y2+1);
         end else begin
            // draw text
            if aobj.CurvedLen=0 then begin
            	// normal draw
               with aobj.LogFont^ do begin
                  lfQuality:=ANTIALIASED_QUALITY;
                  ph:=lfHeight;
                  if lfHeight=0 then
                     lfHeight:=y2-y1
                  else
                     lfHeight:=trunc(ph*zz);
                  hfont:=CreateFontIndirect(aobj.LogFont^);
                  lfHeight:=ph;
               end;
               WCanvas.Font.Color:=aobj.PenColor;
               hpred:=selectobject(wcanvas.handle,hfont);
               //
               fa:=(aobj.LogFont^.lfEscapement/10)*PI/180;	// angle in radians
               dx:=WCanvas.TextWidth(aobj.Text);
               dy:=WCanvas.TextHeight(aobj.Text);
               ox:=0;
               oy:=trunc(y2-y1-dy*cos(fa)+dx*sin(fa)) shr 1;
               case aobj.TextAlign of
                  iejLeft:
                     begin
                        ox:=abs(trunc(dy*sin(fa)));
                     end;
                  iejRight:
                     begin
                        ox:=trunc(x2-x1-dx*cos(fa))
                     end;
                  iejCenter,iejJustify:
                     begin
                        ox:=trunc(x2-x1-dx*cos(fa)-dy*sin(fa)) shr 1;
                     end;
               end;
               // draw rect
               WCanvas.Rectangle(x1,y1,x2+1,y2+1);
               // draw text
               wcanvas.brush.style:=bsClear;
               WCanvas.TextRect(rect(x1,y1,x2,y2),x1+ox,y1+oy,aobj.Text);
               selectobject(wcanvas.handle,hpred);
               DeleteObject(hfont);
            end else begin
            	// curved text
               slen:=strlen(aobj.Text);
               if slen=0 then
						exit;
               dx:=abs(x2-x1);
               dy:=abs(y2-y1);
               olda:=SetTextAlign(wcanvas.Handle,TA_BASELINE or TA_CENTER);
               with aobj.LogFont^ do begin
                  lfQuality:=ANTIALIASED_QUALITY;
                  ph:=lfHeight;
                  if lfHeight=0 then
                     lfHeight:=y2-y1
                  else
                     lfHeight:=trunc(ph*zz);
                  hfont:=CreateFontIndirect(aobj.LogFont^);
                  lfHeight:=ph;
               end;
               WCanvas.Font.Color:=aobj.PenColor;
               hpred:=selectobject(wcanvas.handle,hfont);
               pc:=aobj.Text;
               // calc perim (perimeter)
               perim:=0;
               dx0:=aobj.curvedpos[0].x;
               dy0:=aobj.curvedpos[0].y;
					for i:=1 to aobj.CurvedLen-1 do begin
                  dx1:=aobj.curvedpos[i].x;
                  dy1:=aobj.curvedpos[i].y;
                  x00:=abs(dx0-dx1)*dx;
                  y00:=abs(dy0-dy1)*dy;
                  perim:=perim+ sqrt( x00*x00+y00*y00 );
                  dx0:=dx1;
                  dy0:=dy1;
               end;
               //
               length:=trunc(perim/slen);
               dx0:=aobj.curvedpos[0].x*dx; lx:=dx0;
               dy0:=aobj.curvedpos[0].y*dy; ly:=dy0;
               curlen:=0;
					for i:=1 to aobj.CurvedLen-1 do begin
                  dx1:=aobj.curvedpos[i].x*dx;
                  dy1:=aobj.curvedpos[i].y*dy;
                  x00:=abs(dx0-dx1);
                  y00:=abs(dy0-dy1);
                  curlen:=curlen+ sqrt( x00*x00+y00*y00 );
                  while (curlen>=length) and (pc^<>#0) do begin
                  	x00:=dx0;
                     y00:=dy0;
                     if curlen<>0 then begin
                        dx0:=dx0+(dx1-dx0)*length/curlen;
                        dy0:=dy0+(dy1-dy0)*length/curlen;
                        drawc(WCanvas,rect(x1,y1,x2,y2),x00,y00,dx0,dy0,pc^,aobj.CurvedCharRot,plim);
                     end;
                     curlen:=curlen-length;
                     inc(pc);
                  end;
                  dx0:=dx1;
                  dy0:=dy1;
               end;
               selectobject(wcanvas.handle,hpred);
               DeleteObject(hfont);
               SetTextAlign(wcanvas.Handle,olda);
            end;
         end;
   end else if aobj.Kind=iekMemo then begin
      // draw memo
      tmpMemo:=TIETextControl.Create(nil);
      with tmpMemo do begin
         Text:=aobj.Text;
         TextFormat:=aobj.TextFormat;
         TextFormatRef:=aobj.TextFormatRef;
         Zoom:=zz;
         DefaultFont.Name:=aobj.LogFont^.lfFaceName;
         DefaultFont.Style:=IEExtractStylesFromLogFont(aobj.LogFont);
         DefaultFont.Color:=aobj.PenColor;
         DefaultFont.Height:=aobj.LogFont^.lfHeight;
         DefaultFontBrush.Color:=aobj.BrushColor;
         DefaultFontBrush.Style:=aobj.BrushStyle;
         DefaultAlign:=aobj.TextAlign;
         Brush.Color:=aobj.BrushColor;
         Brush.Style:=aobj.BrushStyle;
         ForceDefaultColors:=drawingalpha;
         IsFontLocked:=aobj.FontLocked;
         AutoSize:=aobj.TextAutoSize;
         GlobalLineSpace:=aobj.LineSpace;
         BorderPen.Color:=aobj.MemoBorderColor;
         BorderPen.Style:=aobj.MemoBorderStyle;
         GlobalFixedHeight:=aobj.MemoFixedHeight;
         WriteFormattedString:= fMemoWriteFormattedString=@aobj;
         Init;
         PaintTo(wcanvas,x1,y1,aobj.x2-aobj.x1+1,aobj.y2-aobj.y1+1);	// for width and height PaintTo wants non zoomed values (first x1,y1 then aobj.x2...)
         aobj.Text:=Text;
         aobj.TextFormat:=TextFormat;
         aobj.TextFormatRef:=TextFormatRef;
         Text:=nil;
         TextFormat:=nil;
         TextFormatRef:=nil;
         fMemoFormattedString:=FormattedString;
         WriteFormattedString:=false;
      end;
      tmpMemo.free;
   end;
end;

function TImageEnVect.GetMemoFormattedString(hobj:integer):AnsiString;
var
   obj:PIEVObject;
   plim:TRect;
begin
	(*
	fMemoWriteFormattedString:=GetObj(hobj);
   Update;
	inherited Paint;
   result:=fMemoFormattedString;
   fMemoWriteFormattedString:=nil;
   *)
   obj:=GetObj(hobj);
	fMemoWriteFormattedString:=obj;
   DrawObjectText(fTBitmap.Canvas,obj^.x1,obj^.y1,obj^.x2,obj^.y2,obj^,1,false,plim);
   result:=fMemoFormattedString;
   fMemoWriteFormattedString:=nil;
end;

// updates text edit properties
procedure TImageEnVect.UpdateTextEdit;
var
	xx1,yy1,xx2,yy2:integer;
begin
	if (fTextEditing=-1) then
   	exit;
	with GetObj(fTextEditing)^ do begin
	   xx1:=XBmp2Scr(x1);
	   yy1:=YBmp2Scr(y1);
	   xx2:=XBmp2Scr(x2);
	   yy2:=YBmp2Scr(y2);
      if Kind=iekTEXT then
         with fTextEdit do begin
            Top:=yy1;
            Left:=xx1;
            Height:=yy2-yy1;
            Width:=xx2-xx1;
            Font.Color:=PenColor;
            if BrushStyle=bsSolid then
               Color:=BrushColor
            else
               Color:=Background;
            if LogFont^.lfHeight=0 then
               Font.Height:=yy2-yy1
            else
               Font.Height:=trunc(LogFont^.lfHeight*fZoomD100);
            Font.Name:=LogFont^.lfFaceName;
            Font.Style:=GetObjFontStyles(fTextEditing);
         end;
      if Kind=iekMEMO then
      	with fMemoEdit do begin
            Top:=yy1;
            Left:=xx1;
            Height:=yy2-yy1+1;
            Width:=xx2-xx1+1;
            DefaultFont.Name:=LogFont^.lfFaceName;
            DefaultFont.Style:=GetObjFontStyles(fTextEditing);
            DefaultFont.Color:=PenColor;
            DefaultFont.Height:=LogFont^.lfHeight;
            DefaultFontBrush.Color:=BrushColor;
            DefaultFontBrush.Style:=BrushStyle;
            DefaultAlign:=TextAlign;
            Brush.Color:=BrushColor;
            Brush.Style:=bsSolid;	// must be solid on edit
            IsFontLocked:=FontLocked;
            AutoSize:=TextAutoSize;
            GlobalLineSpace:=LineSpace;
	         BorderPen.Color:=MemoBorderColor;
   	      BorderPen.Style:=MemoBorderStyle;
            GlobalFixedHeight:=MemoFixedHeight;
            Zoom:=fZoom/100;
         end;
   end;
end;

// Activate text object editing
procedure TImageEnVect.ActiveTextEdit;
begin
	with GetObj(fTextEditing)^ do begin
      if Kind=iekTEXT then begin
         with fTextEdit do begin
            Parent:=self;
            AutoSize:=false;
            fTextEdit.BorderStyle:=bsNone;
            Ctl3D:=false;
         end;
         UpdateTextEdit;
         windows.SetFocus(fTextEdit.handle);
         case syslocale.PriLangID of
            LANG_GREEK:
               Font.Charset := GREEK_CHARSET;
            LANG_RUSSIAN:
               Font.Charset := RUSSIAN_CHARSET;
         end;
         fTextEdit.OnKeyDown := TextEditKeyDown;
         fTextEdit.OnChange := TextEditOnChange;
         fTextEdit.Text:=Text;
         fTextEdit.Visible:=True;
      end;
      if Kind=iekMEMO then begin
         fMemoEdit.Parent:=self;
         UpdateTextEdit;
         windows.SetFocus(fMemoEdit.handle);
         case syslocale.PriLangID of
            LANG_GREEK:
               Font.Charset := GREEK_CHARSET;
            LANG_RUSSIAN:
               Font.Charset := RUSSIAN_CHARSET;
         end;
         fMemoEdit.OnKeyDown := MemoEditKeyDown;
         fMemoEdit.Text:=Text;
         fMemoEdit.TextFormatRef:=TextFormatRef;
         fMemoEdit.TextFormat:=TextFormat;
         fMemoEdit.Init;
         fMemoEdit.Visible:=True;
      end;
   end;
end;

procedure TImageEnVect.TextEditOnChange(Sender:TObject);
var
	tw,mm:integer;
begin
	with GetObj(fTextEditing)^ do
   	if TextAutoSize then begin
         Canvas.Font.Assign(fTextEdit.Font);
         tw:=Canvas.TextWidth(fTextEdit.Text);
         mm:=Canvas.TextWidth('M');
         fTextEdit.Width:=tw;
         tw:=trunc((tw+mm)/fZoomD100);
         x2:=x1+tw;
         Update;
      end;
end;

procedure TImageEnVect.TextEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	inherited;
	case Key of
		VK_ESCAPE:
      	begin
            Key := 0;
            SendMessage((Sender as TEdit).Handle, WM_UNDO, 0, 0);
            CancelInteracts;
         end;
		VK_RETURN:
    		begin
            Key := 0;
            CancelInteracts;
            DoVectorialChanged;
			end;
	end;
end;

procedure TImageEnVect.MemoEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	inherited;
	case Key of
		VK_ESCAPE:
      	begin
            Key := 0;
            CancelInteracts;
         end;
	end;
end;

// Disable iekTEXT object editing (fTextEditing)
// Update Text with edit control content
procedure TImageEnVect.RemoveTextEdit;
var
	canvas_avl:boolean;
begin
	if (fTextEditing>=0) then begin
   	canvas_avl:=not (csDestroying in ComponentState);
		with GetObj(fTextEditing)^ do begin
         if Kind=iekTEXT then begin
            if Text<>nil then
               freemem(Text);
            Text:=_StrDup(PAnsiChar(fTextEdit.Text));
            if canvas_avl and TextAutoSize then begin
               Canvas.Font.Assign(fTextEdit.Font);
               x2:=x1 + trunc(Canvas.TextWidth(fTextEdit.Text)/fZoomD100);
            end;
            fTextEdit.Visible:=false;
         end;
         if Kind=iekMEMO then begin
         	fMemoEdit.RemoveUnreferenced;
         	if TextAutoSize and not (csDestroying in ComponentState) then
            	y2:=y1 + trunc(fMemoEdit.ClientHeight/fZoomD100);
            Text:=fMemoEdit.Text;
            TextFormat:=fMemoEdit.TextFormat;
            TextFormatRef:=fMemoEdit.TextFormatRef;
            fMemoEdit.Text:=nil;
            fMemoEdit.TextFormat:=nil;
            fMemoEdit.TextFormatRef:=nil;
            fMemoEdit.Visible:=false;
         end;
	   end;
      if canvas_avl then
	  		SetFocus;
      DoVectorialChanged;
   end;
end;

// iekTEXT and iekMEMO text objects
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TImageEnVect.ObjClearAllUndo;
begin
   while fObjUndoList.Count>0 do begin
   	TObject(fObjUndoList[0]).free;
   	fObjUndoList.delete(0);
   end;
end;

// remove only last undo
procedure TImageEnVect.ObjClearUndo;
var
	uc:integer;
begin
   uc:=fObjUndoList.Count;
   if uc>0 then begin
		TObject(fObjUndoList[uc-1]).free;
      fObjUndoList.delete(uc-1);
   end;
end;

// Position: 0=last saved undo, 1=before last saved undo,  2...  up to UndoCount-1
procedure TImageEnVect.ObjUndoAt(Position:integer);
var
	uc:integer;
   obj:TObject;
   ms:TMemoryStream;
begin
   uc:=fObjUndoList.Count;
   if (uc>0) and (Position<uc) then begin
   	obj:=fObjUndoList[uc-1-Position];
      if obj is TMemoryStream then begin
			ms:=TMemoryStream(obj);
         ms.Position:=0;
      	LoadFromStreamIEV(ms);
      end;
   end;
end;

function TImageEnVect.GetObjCanUndo: boolean;
begin
	result:= fObjUndoList.Count>0;
end;

function TImageEnVect.GetObjUndoCount:integer;
begin
	result:= fObjUndoList.Count;
end;

procedure TImageEnVect.ObjSaveUndo;
	//
   procedure SaveUndoObject(obj:TObject);
   begin
      while fObjUndoList.Count>=fObjUndoLimit do begin
         TObject(fObjUndoList[0]).free;
         fObjUndoList.delete(0);
      end;
      fObjUndoList.Add(obj);
   end;
var
   ms:TMemoryStream;
begin
   ms:=TMemoryStream.Create;
   SaveToStreamIEV(ms);
   SaveUndoObject(ms);
end;

procedure TImageEnVect.ObjUndo;
begin
   ObjUndoAt(0);
end;

function TImageEnVect.IsEditMode:boolean;
begin
	result:= fTextEditing>-1;
end;

procedure TImageEnVect.SetObjTextCurve(hobj:integer; x,y:double);
begin
	with GetObj(hobj)^ do begin
      inc(CurvedLen);
      reallocmem(CurvedPos,sizeof(TDPoint)*CurvedLen);
		CurvedPos[CurvedLen-1].x:=x;
      CurvedPos[CurvedLen-1].y:=y;
   end;
end;

// phase is in grades (0-360)
procedure TImageEnVect.SetObjTextCurveShape(hobj:integer; shape:TIECurve; phase:integer; dforward:boolean);
var
   a,p,x,y,pha:double;
begin
	with GetObj(hobj)^ do begin
   	// remove old curve
   	if CurvedLen>0 then
      	freemem(CurvedPos);
      CurvedPos:=nil;
      CurvedLen:=0;
		// create new curve
      case shape of
			iecNone: ;	// do nothing
         iecEllipse:
         	begin
            	pha:=phase*PI/180;
               p:=2*PI+pha;
               a:=pha;
               if dforward then
               	iedswap(p,a);
               while true do begin
                  x:=0.5+sin(a)/(2);
                  y:=0.5+cos(a)/(2);
                  SetObjTextCurve(hobj,x,y);
                  if dforward then begin
                  	if a<=p then break;
                  	a:=a- 0.01745329252;	// dec by 1 grade
                  end else begin
                  	if a>=p then break;
	                  a:=a+ 0.01745329252	// inc by 1 grade
                  end;
               end;
            end;
         iecArc:
         	begin
            	pha:=phase*PI/180-PI/2;
               p:=PI+pha;
               a:=pha;
               if dforward then
               	iedswap(p,a);
               while true do begin
                  x:=0.5+sin(a)/(2);
                  y:=0.5+cos(a)/(2);
                  SetObjTextCurve(hobj,x,y);
                  if dforward then begin
                  	if a<=p then break;
                  	a:=a- 0.01745329252;	// dec by 1 grade
                  end else begin
                  	if a>=p then break;
	                  a:=a+ 0.01745329252	// inc by 1 grade
                  end;
               end;
            end;
         iecCosine:
         	begin
            	pha:=phase*PI/180;
               p:=pha;
               a:=2*PI+pha;
               x:=0;
               while true do begin
                  x:=x + 1/360;
                  y:=0.5+cos(a)/(2);
                  SetObjTextCurve(hobj,x,y);
                  if a<=p then break;
                  a:=a- 0.01745329252;	// dec by 1 grade
               end;
            end;
         iecVertical:
         	begin
               if dforward then begin
                  SetObjTextCurve(hobj,0.5,0);
                  SetObjTextCurve(hobj,0.5,1);
               end else begin
                  SetObjTextCurve(hobj,0.5,1);
                  SetObjTextCurve(hobj,0.5,0);
               end;
            end;
         iecHorizontal:
         	begin
               if dforward then begin
                  SetObjTextCurve(hobj,0,0.5);
                  SetObjTextCurve(hobj,1,0.5);
               end else begin
                  SetObjTextCurve(hobj,1,0.5);
                  SetObjTextCurve(hobj,0,0.5);
               end;
            end;
      end;
   end;
   Update;
end;

procedure TImageEnVect.SetObjTextCurveFromPolyline(hobj:integer; source:integer);
var
	psource:PIEVObject;
   pdest:PIEVObject;
   i,dx,dy:integer;
   x,y:double;
begin
   pdest:=GetObj(hobj);
   psource:=GetObj(source);
   // remove old curve
   if pdest^.CurvedLen>0 then
      freemem(pdest^.CurvedPos);
   pdest^.CurvedPos:=nil;
   pdest^.CurvedLen:=0;
   // create new curve
   dx:=abs(psource^.PolyBaseX2-psource^.PolyBaseX1);
   dy:=abs(psource^.PolyBaseY2-psource^.PolyBaseY1);
	for i:=0 to psource^.PolyPointsCount-1 do begin
   	x:=(PPointArray(psource^.PolyPoints)[i].x-psource^.PolyBaseX1) / dx;
      y:=(PPointArray(psource^.PolyPoints)[i].y-psource^.PolyBaseY1) / dy;
   	SetObjTextCurve(hobj,x,y);
   end;
end;

procedure TImageEnVect.SetObjAntialias(value:boolean);
begin
	if value<>fObjAntialias then begin
		fObjAntialias:=value;
      Update;
   end;
end;

initialization
	begin
   	IEVECTCLIPFORMAT:=RegisterClipboardFormatA(PAnsiChar(@IEVECTCLIPFORMAT_NAME));
   end;

(*$else*)
interface
implementation
(*$endif*)

end.

