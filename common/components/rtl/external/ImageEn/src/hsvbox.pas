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

unit hsvbox;

{$R-}
{$Q-}


{$I ie.inc}

interface

{$ifdef IEKYLIX}
uses SysUtils, iekdef, Types, QGraphics, Classes, QForms, QExtCtrls, QStdCtrls, QControls,
	 ieview, hyiedefs, hyieutils, ImageEnIO,ImageEnProc;
{$endif}
{$ifdef IEDELPHI}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ImageEnProc,hyiedefs;
{$endif}

type

  THSVBox = class(TCustomControl)
  private
    { Private declarations }
    fHue:integer;		// da 0 a 359
    fSat:integer;		// da 0 a 99
    fVal:integer;		// da 0 a 99
    fRed:byte;
    fGreen:byte;
    fBlue:byte;
    bitmap:TBitMap;
    fBackground:TColor;
    fOnChange:TNotifyEvent;
    fMouseSel:integer;	// 0=niente  1=capture su sat/val  2=capture su hue
    fColor:TColor;
    fHueBarWidth:integer;
    fBarsDistance:integer;
  protected
    { Protected declarations }
    procedure SetHue(h:integer);
    procedure SetSat(s:integer);
    procedure SetVal(v:integer);
    {$ifdef IEDELPHI}
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMEraseBkgnd(var Message:TMessage); message WM_ERASEBKGND;
    {$endif}
    procedure SetBackground(bk:TColor);
    procedure DrawValSat;
    procedure DrawHue;
    procedure DrawGrips;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
	 procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
	 procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
	 procedure XMouseMove(X,Y:integer);
    procedure SetHueBarWidth(v:integer);
    procedure SetBarsDistance(v:integer);
  public
    { Public declarations }
    procedure Paint; override;
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure SetRGB(r,g,b:byte);
    procedure SetColor(cl:TColor);
    function GetColorAt(x,y:integer):TColor;
  published
    { Published declarations }
    property Hue:integer read fHue write SetHue default 0;	// da 0 a 359
    property Sat:integer read fSat write SetSat default 0;	// da 0 a 99
    property Val:integer read fVal write SetVal default 0;	// da 0 a 99
    property Red:byte read fRed;			// ATN!! IT MUST BE READ-ONLY!!
    property Green:byte read fGreen;	// ATN!! IT MUST BE READ-ONLY!!
    property Blue:byte read fBlue;		// ATN!! IT MUST BE READ-ONLY!!
    property Color:TColor read fColor;	// ATN!! IT MUST BE READ-ONLY!!
    property Background:TColor read fBackground write SetBackground default clBtnFace;
    property OnChange:TNotifyEvent read fOnChange write fOnChange;
    property HueBarWidth:integer read fHueBarWidth write SetHueBarWidth default 20;
    property BarsDistance:integer read fBarsDistance write SetBarsDistance default 5;
    property Align;
    {$ifdef IESUPPORTANCHORS}
	 property Anchors;
	 {$endif}
    {$ifdef IEDELPHI}
    property DragCursor;
    property DragMode;
    {$endif}
    property Enabled;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

implementation

{$R-}

//const
   //HWIDTH:integer=20;	// larghezza barra Hue
   //WDIST:integer=5;		// distanza orizzontale fra barra hue e quadrato Sat/Val

/////////////////////////////////////////////////////////////////////////////////////
constructor THSVBox.Create(Owner: TComponent);
begin
	inherited Create(Owner);
   //controlstyle:=controlstyle+[csOpaque];
   ControlStyle := ControlStyle + [csOpaque, csAcceptsControls];
   fHueBarWidth:=20;
   fBarsDistance:=5;
   fOnChange:=nil;
   fBackground:=clBtnFace;
   fMouseSel:=0;	// nessun capture
   Height := 105;
   Width := 105;
   fHue:=0;
   fSat:=0;
   fVal:=0;
   fRed:=0;
   fGreen:=0;
   fBlue:=0;
   fColor:=0;
   bitmap:=TBitmap.create;
   bitmap.PixelFormat:=pf24bit;
   bitmap.Width:=width;
   bitmap.Height:=height;
   DrawHue;
   DrawValSat;
   DrawGrips;
end;

/////////////////////////////////////////////////////////////////////////////////////
destructor THSVBox.Destroy;
begin
	bitmap.free;
   inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure THSVBox.Paint;
begin
	canvas.Draw(0,0,bitmap);
end;

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEDELPHI}
procedure THSVBox.WMEraseBkgnd(var Message:TMessage);
begin
	Message.Result:=0;
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEDELPHI}
procedure THSVBox.WMSize(var Message: TWMSize);
begin
  	inherited;
   bitmap.Width:=message.Width;
   bitmap.Height:=message.Height;
   DrawHue;
   DrawValSat;
   DrawGrips;
   invalidate;
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
procedure THSVBox.SetBackground(bk:TColor);
begin
	fBackground:=bk;
   DrawHue;
   DrawValSat;
   DrawGrips;
   invalidate;
end;

/////////////////////////////////////////////////////////////////////////////////////
// disegna quadrato Sat/val, non invalida
procedure THSVBox.DrawValSat;
var
	SLWIDTH:integer;  // larghezza in pixel del quadrato Sat/Val
	v:integer;
   ss,sv:single;
   col,row:integer;
   px:pRGB;
begin
   SLWIDTH:=bitmap.width-fBarsDistance-fHueBarWidth;
   if SLWIDTH>0 then begin
      ss:=100/SLWIDTH;
      sv:=100/bitmap.height;
      // disegna quadrato Sat/Val
      for row:=0 to bitmap.height-1 do begin
         v:=trunc(sv*row);
         px:=bitmap.ScanLine[bitmap.height-row-1];
         for col:=0 to SLWIDTH-1 do begin
            HSV2RGB(px^,fHue,trunc(ss*col),v);
            inc(px);
         end;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// disegna barra hue
// e intermezzo tra barra hue e quadrato
procedure THSVBox.DrawHue;
var
	SLWIDTH:integer;  // larghezza in pixel del quadrato Sat/Val
   sh:single;
   col,row:integer;
   px:pRGB;
   bk:TRGB;
   fo:TRGB;
begin
   SLWIDTH:=bitmap.width-fBarsDistance-fHueBarWidth;
   if SLWIDTH>0 then begin
      sh:=360/bitmap.height;
      // draws hue bar
      bk:=TColor2TRGB(fBackground);
      for row:=0 to bitmap.height-1	do begin
         px:=bitmap.ScanLine[bitmap.height-row-1];
         inc(px,SLWIDTH);
         for col:=SLWIDTH to SLWIDTH+fBarsDistance-1 do begin
            px^:=bk;	// background
            inc(px);
         end;
         HSV2RGB(fo,trunc(sh*row),99,99);
         for col:=SLWIDTH+fBarsDistance to width-1 do begin
            px^:=fo;
            inc(px);
         end;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// disegna grips barra hue e quadrato valsat
procedure THSVBox.DrawGrips;
var
	x,y:integer;
   SLWIDTH:integer;  // larghezza in pixel del quadrato Sat/Val
begin
	bitmap.canvas.pen.style:=psSolid;
	bitmap.canvas.pen.mode:=pmNot;
	bitmap.canvas.Brush.style:=bsClear;
	bitmap.canvas.pen.width:=1;
   SLWIDTH:=bitmap.width-fBarsDistance-fHueBarWidth;
   if SLWIDTH>0 then begin
      // hue
      y:=round((359-fHue)/360*(bitmap.height-1));
      bitmap.Canvas.rectangle(SLWIDTH+fBarsDistance,y-2,width,y+2);
      // sat/val
      x:=round(fSat/99*(SLWIDTH-1));
      y:=bitmap.height-round((bitmap.height-1)*fVal/99)-1;
      bitmap.Canvas.rectangle(x-3,y-3,x+3,y+3);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// movimento mouse
procedure THSVBox.XMouseMove(X,Y:integer);
var
	SLWIDTH:integer;  // larghezza in pixel del quadrato Sat/Val
   px:TRGB;
begin
	SLWIDTH:=bitmap.width-fBarsDistance-fHueBarWidth;
   if SLWIDTH>0 then begin
      if X<SLWIDTH then begin
         // quadrato sat/val
         DrawGrips;
         fSat:=round(X/(SLWIDTH-1)*99);
         fVal:=99-round(Y/(bitmap.height-1)*99);
      end else if X>=SLWIDTH+fBarsDistance then begin
         // barra hue
         DrawGrips;
         fHue:=359-round(y/(bitmap.height-1)*359);
         DrawValSat;
      end;
      HSV2RGB(px,fHue,fSat,fVal);
      fColor:=TRGB2TColor(px);
      fRed:=px.r;  fGreen:=px.g;  fBlue:=px.b;
      if Assigned(fOnChange) then
         fOnChange(Self);
      DrawGrips;
      paint;
   end;
end;

function THSVBox.GetColorAt(x,y:integer):TColor;
var
	s,v:integer;
   px:TRGB;
   SLWIDTH:integer;
begin
	SLWIDTH:=bitmap.width-fBarsDistance-fHueBarWidth;
   if x<SLWIDTH then begin
		s:=round(X/(SLWIDTH-1)*99);
   	v:=99-round(Y/(bitmap.height-1)*99);
   	HSV2RGB(px,fHue,s,v);
   	result:=TRGB2TColor(px);
   end else
   	result:=fColor;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure THSVBox.SetHue(h:integer);
var
	px:TRGB;
begin
	if h<0 then h:=0;
   if h>359 then h:=359;
  	DrawGrips;
	fHue:=h;
   HSV2RGB(px,fHue,fSat,fVal);
   fColor:=TRGB2TColor(px);
   fRed:=px.r;  fGreen:=px.g;  fBlue:=px.b;
   DrawValSat;
   DrawGrips;
   paint;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure THSVBox.SetSat(s:integer);
var
	px:TRGB;
begin
	if s<0 then s:=0;
   if s>99 then s:=99;
	DrawGrips;
	fSat:=s;
   HSV2RGB(px,fHue,fSat,fVal);
   fColor:=TRGB2TColor(px);
   fRed:=px.r;  fGreen:=px.g;  fBlue:=px.b;
   DrawGrips;
   paint;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure THSVBox.SetVal(v:integer);
var
	px:TRGB;
begin
	if v<0 then v:=0;
   if v>99 then v:=99;
	DrawGrips;
	fVal:=v;
   HSV2RGB(px,fHue,fSat,fVal);
   fColor:=TRGB2TColor(px);
   fRed:=px.r;  fGreen:=px.g;  fBlue:=px.b;
   DrawGrips;
   paint;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure THSVBox.SetRGB(r,g,b:byte);
var
	px:TRGB;
begin
 	DrawGrips;
	fRed:=r; fGreen:=g; fBlue:=b;
   px:=creatergb(fRed,fGreen,fBlue);
   RGB2HSV(px,fHue,fSat,fVal);
   fColor:=TRGB2TColor(px);
   DrawValSat;
   DrawGrips;
   paint;
end;

/////////////////////////////////////////////////////////////////////////////////////
// movimento mouse
procedure THSVBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
	SLWIDTH:integer;  // larghezza in pixel del quadrato Sat/Val
begin
	inherited;
   //
   if MouseCapture then begin
   	SLWIDTH:=bitmap.width-fBarsDistance-fHueBarWidth;
      if SLWIDTH>0 then begin
         if x<0 then x:=0;
         if y<0 then y:=0;
         if y>=bitmap.height then y:=bitmap.height-1;
         if fMouseSel=1 then begin
            if x>=SLWIDTH then x:=SLWIDTH-1;
            XMouseMove(x,y);
         end else if fMouseSel=2 then begin
            if x<SLWIDTH+fBarsDistance then x:=SLWIDTH+fBarsDistance
            else if x>=bitmap.width then x:=bitmap.width-1;
            XMouseMove(x,y);
         end;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// pressione di un bottone del mouse
procedure THSVBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	SLWIDTH:integer;  // larghezza in pixel del quadrato Sat/Val
begin
	inherited;
   if (Button=mbLeft) then begin
   	SLWIDTH:=bitmap.width-fBarsDistance-fHueBarWidth;
      if SLWIDTH>0 then begin
         if x<SLWIDTH then begin
            fMouseSel:=1;		// capture val/sat
            XMouseMove(x,y);
         end else if x>=SLWIDTH+fBarsDistance then begin
            fMouseSel:=2;		// capture hue
            XMouseMove(x,y);
         end else
            fMouseSel:=0;	// nessun capture
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// rilascio mouse
// fMouseSel 0=niente  1=capture su sat/val  2=capture su hue
procedure THSVBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	inherited;
	fMouseSel:=0;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure THSVBox.SetColor(cl:TColor);
var
	rgb:TRGB;
begin
 	DrawGrips;
   rgb:=TColor2TRGB(cl);
	fRed:=rgb.r; fGreen:=rgb.g; fBlue:=rgb.b;
   RGB2HSV(rgb,fHue,fSat,fVal);
   fColor:=cl;
   DrawValSat;
   DrawGrips;
   paint;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure THSVBox.SetHueBarWidth(v:integer);
begin
	if v>=0 then begin
		fHueBarWidth:=v;
	   DrawHue;
	   DrawValSat;
	   DrawGrips;
	   invalidate;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure THSVBox.SetBarsDistance(v:integer);
begin
	if v>=0 then begin
		fBarsDistance:=v;
	   DrawHue;
	   DrawValSat;
	   DrawGrips;
	   invalidate;
   end;
end;



end.
