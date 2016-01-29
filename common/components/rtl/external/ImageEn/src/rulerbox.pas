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

unit rulerbox;

{$R-}
{$Q-}


{$I ie.inc}

{$ifdef IEDELPHI}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ImageEnProc,hyiedefs;

const
	MAXPOLYGLINES=10;

type

  TPolyg = array [0..MAXPOLYGLINES-1] of TPoint;

  TGripKind = (gkTriangle, gkLeftTriangle, gkRightTriangle, gkArrow, gkArrow2);
  TGripsDir = (gdUp, gdDown);

  TRulerDir = (rdHorizontal, rdVertical);

  // Notifica cambiamento posizione grip (grip=numero del grip)
  TRulerPosChangeEvent = procedure(Sender: TObject; Grip:integer) of object;

  // Notifica click su grip (non è generato se il grip è stato spostato)
  TRulerGripClickEvent = procedure(Sender: TObject; Grip:integer) of object;

  // Notifica doppio click su grip
  TRulerGripDblClickEvent = procedure(Sender: TObject; Grip:integer) of object;

  // Notifica click sul ruler (non sul grip)
  TRulerClickEvent = procedure(Sender: TObject; ps:double) of object;

  TRulerBox = class(TCustomControl)
  private
    { Private declarations }
    Bitmap:TBitMap;
    fBackground:TColor;
    fGrips:TList;			// lista di grips
    fGripBaseDim:integer;	// dimensione base dei grip (triangoli)
    fSelGrip:integer;	// grip selezionato (-1=nessuno)
    fSelGripSt:integer;	// posizione iniziale durante il mouse-dragging
    fMX1,fMY1:integer;	// posizioni iniziali del mouse durante il mouse-dragging
    fGripsDir:TGripsDir;	// Direzione per tutti i grips
    fRuler:boolean;		// rullo + etichette numeriche
    fViewPos:double;		// posizione iniziale del righello
    fDPU:double;			// DotPerUnit - corrispondenza righello con pixels
    fFrequency:double;	// Ogni quante Unit visualizzare una tacca
    fLabelFreq:double;  // Ogni quante Unit visualizzare una etichetta
    fRulerColor:TColor; // Colore ruler
    fRulerDir:TRulerDir;// Orientamento ruler
    fViewMin,fViewMax:double; // Max e Min per fViewPos
    fOnRulerPosChange:TRulerPosChangeEvent;	// evento
    fOnRulerGripClick:TRulerGripClickEvent; 	// evento
    fOnRulerGripDblClick:TRulerGripDblClickEvent; // evento
    fOnRulerClick:TRulerClickEvent; // evento
    fFitInView:boolean;	// aggiusta fDPU in base a fViewMin e fViewMax
    fHexLabels:boolean; // true visualizza labels in esadecimale
    procedure SetBackground(bk:TColor);
    procedure SetGripsCount(v:integer);
    function GetGripsCount:integer;
    procedure SetGripsPos(i:integer; p:double);
    function GetGripsPos(i:integer):double;
    procedure SetGripsCol(i,p:integer);
    function GetGripsCol(i:integer):integer;
    procedure SetGripBaseDim(v:integer);
    procedure SetGripsKind(i:integer; v:TGripKind);
    function GetGripsKind(i:integer):TGripKind;
    procedure SetGripsDir(v:TGripsDir);
    procedure SetRuler(v:boolean);
    procedure SetViewPos(v:double);
    procedure SetDPU(v:double);
    procedure SetFrequency(v:double);
    procedure SetLabelFreq(v:double);
    procedure SetRulerColor(v:TColor);
    procedure SetRulerDir(v:TRulerDir);
    procedure SetGripsMax(i:integer; v:double);
    procedure SetGripsMin(i:integer; v:double);
    function GetGripsMax(i:integer):double;
    function GetGripsMin(i:integer):double;
    procedure SetViewMin(v:double);
    procedure SetViewMax(v:double);
    procedure SetFitInView(v:boolean);
    function GetWidthInUnit:double;
    procedure SetHexLabels(v:boolean);
  protected
    { Protected declarations }
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMEraseBkgnd(var Message:TMessage); message WM_ERASEBKGND;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
	 procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
	 procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    function GetClickedGrip(x,y:integer):integer;
    procedure GetGripPoly(gn:integer; var poly:TPolyg);
    procedure GetGripRect(gn:integer; var rc:TRect);
    function GetRulerHeight:integer;
    procedure RepaintGrips;
    procedure RepaintRuler;
    function GetXGripPos(gn:integer):integer;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure AdjustGripLimits(gn:integer);
    procedure AdjustViewLimits;
  public
    { Public declarations }
    procedure Paint; override;
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure Update; override;
    property GripsPos[g:integer]:double read GetGripsPos write SetGripsPos; default;
    property GripsColor[g:integer]:integer read GetGripsCol write SetGripsCol;
    property GripsKind[g:integer]:TGripKind read GetGripsKind write SetGripsKind;
    property GripsMin[g:integer]:double read GetGripsMin write SetGripsMin;
    property GripsMax[g:integer]:double read GetGripsMax write SetGripsMax;
  published
    { Published declarations }
    property ViewPos:double read fViewPos write SetViewPos;
    property Background:TColor read fBackground write SetBackground default clBtnFace;
    property GripBaseDim:integer read fGripBaseDim write SetGripBaseDim default 12;
    property GripsDir:TGripsDir read fGripsDir write SetGripsDir default gdUp;
    property Ruler:boolean read fRuler write SetRuler default true;
    property DotPerUnit:double read fDPU write SetDPU;
    property Frequency:double read fFrequency write SetFrequency;
    property LabelFreq:double read fLabelFreq write SetLabelFreq;
    property RulerColor:TColor read fRulerColor write SetRulerColor default clBtnFace;
    property RulerDir:TRulerDir read fRulerDir write SetRulerDir default rdHorizontal;
    property ViewMin:double read fViewMin write SetViewMin;
    property ViewMax:double read fViewMax write SetViewMax;
    property OnRulerPosChange:TRulerPosChangeEvent read fOnRulerPosChange write fOnRulerPosChange;
    property OnRulerGripClick:TRulerGripClickEvent read fOnRulerGripClick write fOnRulerGripClick;
	 property OnRulerGripDblClick:TRulerGripDblClickEvent read fOnRulerGripDblClick write fOnRulerGripDblClick;
	 property OnRulerClick:TRulerClickEvent read fOnRulerClick write fOnRulerClick;
    property FitInView:boolean read fFitInView write SetFitInView default false;
    property GripsCount:integer read GetGripsCount write SetGripsCount default 1;
    property HexLabels:boolean read fHexLabels write SetHexLabels default false;
    property Align;
    property DragCursor;
    property DragMode;
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
    property Width default 300;
    property Height default 40;
    property Font;
  end;

implementation

{$R-}

type

  TGrip = record
  		Pos:double;	// posizione
      Color:TColor;	// colore
      Kind:TGripKind;	// tipo
      Min:double;	// posizione minima
      Max:double; // posizione massima
  end;
  PGrip = ^TGrip;

const
	// numero di punti per ogni tipo di grip
	NumLinesGKind:array [gkTriangle..gkArrow2] of integer=(
   			3,	// gkTriangle
            3, // gkLeftTriangle
            3, // gkRightTriangle
            7, // gkArrow
            5);// gkArrow2

	DISTRULLAB=3;	// Distanza fra ruler ed etichette

/////////////////////////////////////////////////////////////////////////////////////
constructor TRulerBox.Create(Owner: TComponent);
begin
	inherited Create(Owner);
   controlstyle:=controlstyle+[csOpaque];
   fHexLabels:=false;
   fGripsDir:=gdUp;
   fBackground:=clBtnFace;
   fGripBaseDim:=12;
   fRuler:=true;
   fViewPos:=0;
   fDPU:=1;
   fFrequency:=10;
   fLabelFreq:=40;
   fRulerColor:=clBtnFace;
   fViewMin:=0;
   fViewMax:=0;
   fOnRulerPosChange:=nil;
   fOnRulerGripClick:=nil;
   fOnRulerGripDblClick:=nil;
   fOnRulerClick:=nil;
   fFitInView:=false;
   Height := 40;
   Width := 300;
   bitmap:=TBitmap.create;
   bitmap.PixelFormat:=pf24bit;
   bitmap.Width:=width;
   bitmap.Height:=height;
   fGrips:=TList.Create;
   SetGripsCount(1);
   fSelGrip:=-1;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
destructor TRulerBox.Destroy;
begin
	bitmap.free;
   while fGrips.Count>0 do begin
   	dispose( fGrips[0] );
		fGrips.Delete(0);
   end;
   fGrips.free;
   inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.Paint;
begin
	canvas.Draw(0,0,bitmap);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.WMEraseBkgnd(var Message:TMessage);
begin
	Message.Result:=0;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.WMSize(var Message: TWMSize);
begin
  	inherited;
   bitmap.Width:=message.Width;
   bitmap.Height:=message.Height;
   update;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetBackground(bk:TColor);
begin
	fBackground:=bk;
   update;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetGripsCount(v:integer);
var
	ex,q:integer;
begin
 	ex:=fGrips.Count;
	if v<>ex then begin
   	if v<ex then
	   	// free
   	   for q:=v-1 downto ex do
      		dispose( fGrips[q] );
      //
   	fGrips.Count:=v;
      // init
		for q:=ex to v-1 do begin
      	fGrips[q]:=new(PGrip);
         // defaults
			PGrip(fGrips[q])^.Pos:=0;
         PGrip(fGrips[q])^.Color:=fBackground;
         PGrip(fGrips[q])^.Kind:=gkTriangle;
			PGrip(fGrips[q])^.Min:=fViewMin;
         PGrip(fGrips[q])^.Max:=fViewMax;
      end;
      Update;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TRulerBox.GetGripsCount:integer;
begin
	result:=fGrips.Count;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetGripsPos(i:integer;p:double);
begin
	if (i<fGrips.Count) then begin
		PGrip(fGrips[i])^.Pos:=p;
      AdjustGripLimits(i);
      if assigned(fOnRulerPosChange) then
	      fOnRulerPosChange(self,i);
      Update;
      Paint;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TRulerBox.GetGripsPos(i:integer):double;
begin
	if i<fGrips.Count then
   	result:=PGrip(fGrips[i])^.Pos
   else
   	result:=0;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetGripsCol(i,p:integer);
begin
	if i<fGrips.Count then begin
		PGrip(fGrips[i])^.Color:=p;
      Update;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TRulerBox.GetGripsCol(i:integer):integer;
begin
	if i<fGrips.Count then
   	result:=PGrip(fGrips[i])^.Color
   else
   	result:=0;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetGripBaseDim(v:integer);
begin
	fGripBaseDim:=v;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// pressione di un bottone del mouse
procedure TRulerBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	inherited;
   if (Button=mbLeft) then begin
   	fSelGrip:=GetClickedGrip(x,y);
      fMX1:=X;
      fMY1:=Y;
      if fSelGrip>=0 then begin
		  	if (ssDouble in Shift) and assigned(fOnRulerGripDblClick) then
		   	fOnRulerGripDblClick(Self,fSelGrip);
	      fSelGripSt:=GetXGripPos(fSelGrip);
      end else begin
	   	if assigned(fOnRulerClick) then
   	   	fOnRulerClick(self,X/fDPU+fViewPos);
   	end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetGripsKind(i:integer; v:TGripKind);
begin
	if i<fGrips.Count then
		PGrip(fGrips[i])^.Kind:=v;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TRulerBox.GetGripsKind(i:integer):TGripKind;
begin
	result:=gkTriangle;	// default
	if i<fGrips.Count then
		result:=PGrip(fGrips[i])^.Kind;
end;

/////////////////////////////////////////////////////////////////////////////////////
// rest. -1=nessuno
function TRulerBox.GetClickedGrip(x,y:integer):integer;
var
   q:integer;
   rc:TRect;
begin
	result:=-1;
	for q:=fGrips.Count-1 downto 0 do begin
		GetGripRect(q,rc);
		if PtInRect(rc,Point(x,y)) then begin
      	result:=q;
         break;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// restituisce il rettangolo in cui è contenuto il grip gn.
// I bordi destro e basso sono incrementati di 1, al fine di renderli
// compatibili con PtInRect.
procedure TRulerBox.GetGripRect(gn:integer; var rc:TRect);
var
	poly:TPolyg;
   q:integer;
begin
	GetGripPoly(gn,poly);
   rc.TopLeft:=poly[0];
   rc.BottomRight:=poly[0];
	for q:=1 to NumLinesGKind[GripsKind[gn]]-1 do begin
   	if poly[q].X<rc.Left then
      	rc.Left:=poly[q].X;
      if poly[q].X>rc.Right then
      	rc.Right:=poly[q].X;
      if poly[q].Y<rc.Top then
      	rc.Top:=poly[q].Y;
      if poly[q].Y>rc.Bottom then
      	rc.Bottom:=poly[q].Y;
   end;
   inc(rc.Bottom);
   inc(rc.Right);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetGripsDir(v:TGripsDir);
begin
	fGripsDir:=v;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetRuler(v:boolean);
begin
	fRuler:=v;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Rest. altezza del ruler+text
function TRulerBox.GetRulerHeight:integer;
begin
	if fRuler then
		result:=trunc(abs(Font.Height)*1.7)+DISTRULLAB
   else
   	result:=0;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.Update;
begin
   if fFitinView then begin
	   fDPU:=bitmap.width/(fViewMax-fViewMin);
      AdjustViewLimits;
   end;
   RepaintGrips;
   RepaintRuler;
   invalidate;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetViewPos(v:double);
begin
   fViewPos:=v;
   AdjustViewLimits;
   Update;
   Paint;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetFrequency(v:double);
begin
	fFrequency:=v;
   Update;
   Paint;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetLabelFreq(v:double);
begin
	fLabelFreq:=v;
   Update;
   Paint;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Rest. posizione X in pixel del grip gn
function TRulerBox.GetXGripPos(gn:integer):integer;
begin
	result:=round(fDPU*(GripsPos[gn]-fViewPos));
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetRulerColor(v:TColor);
begin
	fRulerColor:=v;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.CMFontChanged(var Message: TMessage);
begin
	Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetRulerDir(v:TRulerDir);
begin
	fRulerDir:=v;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Rest. le coordinate dei punti che formano il grip
procedure TRulerBox.GetGripPoly(gn:integer; var poly:TPolyg);
var
   w,h,b:integer;
begin
	b:=0;
   h:=0;
	if csDesigning in Componentstate then
   	w:=(fGripBaseDim+5)*gn
   else
		w:=GetXGripPos(gn);
   if fGripsDir=gdUp then begin
   	if fRulerDir=rdHorizontal then
		   h:=bitmap.height-1
      else
      	h:=bitmap.width-1;
  		b:=0;
	   if fRuler then
			inc(b,GetRulerHeight);
   end;
   if fGripsDir=gdDown then begin
   	if fRulerDir=rdHorizontal then
		   b:=bitmap.height-1
      else
         b:=bitmap.width-1;
  		h:=0;
      if fRuler then
      	dec(b,GetRulerHeight);
   end;
   case GripsKind[gn] of
   	gkTriangle:
      	begin
			   poly[0].x := w - (fGripBaseDim div 2);  poly[0].y := h;
			   poly[1].x := w + (fGripBaseDim div 2);	 poly[1].y := h;
			   poly[2].x := w;  poly[2].y := b;
         end;
   	gkLeftTriangle:
      	begin
			   poly[0].x := w - (fGripBaseDim div 2);  poly[0].y := h;
			   poly[1].x := w;  poly[1].y := h;
			   poly[2].x := w;  poly[2].y := b;
			end;
		gkRightTriangle:
			begin
			   poly[0].x := w;  poly[0].y := h;
			   poly[1].x := w + (fGripBaseDim div 2);	 poly[1].y := h;
			   poly[2].x := w;  poly[2].y := b;
			end;
      gkArrow:
      	begin
         	poly[0].x := w - (fGripBaseDim div 4);  poly[0].y := h;
            poly[1].x := w + (fGripBaseDim div 4);  poly[1].y := poly[0].y;
            poly[2].x := poly[1].x;
				if fGripsDir=gdUp then
	            poly[2].y := b+ ((h-b) div 3)
            else
					poly[2].y := h+ ((b-h) div 3)*2;
            poly[3].x := w + (fGripBaseDim div 2);  poly[3].y := poly[2].y;
            poly[4].x := w;  poly[4].y := b;
            poly[5].x := w - (fGripBaseDim div 2);  poly[5].y := poly[2].y;
            poly[6].x := poly[0].x;  poly[6].y := poly[2].y;
         end;
      gkArrow2:
      	begin
         	poly[0].x := w - (fGripBaseDim div 2);  poly[0].y := h;
            poly[1].x := w + (fGripBaseDim div 2);  poly[1].y := poly[0].y;
            poly[2].x := poly[1].x;
				if fGripsDir=gdUp then
	            poly[2].y := b+ (h-b) div 2
            else
					poly[2].y := h+ (b-h) div 2;
            poly[3].x := w;  poly[3].y := b;
            poly[4].x := poly[0].x;  poly[4].y := poly[2].y;
         end;
   end;
	if fRulerDir=rdVertical then
     	for w:=0 to NumLinesGKind[GripsKind[gn]]-1 do
        	iswap(poly[w].x,poly[w].y);
end;

/////////////////////////////////////////////////////////////////////////////////////
// ridisegna grips
procedure TRulerBox.RepaintGrips;
var
	q,rh:integer;
   poly:TPolyg;
begin
	bitmap.Canvas.Brush.Color:=fBackground;
   rh:=GetRulerHeight;
   if fRulerDir=rdHorizontal then begin
	   if fGripsDir=gdUp then
   	   bitmap.canvas.fillrect(rect(0,rh,bitmap.width,bitmap.height))
	   else if fgripsDir=gdDown then
   		bitmap.canvas.fillrect(rect(0,0,bitmap.width,bitmap.height-rh));
   end else begin
	   if fGripsDir=gdUp then
   	   bitmap.canvas.fillrect(rect(rh,0,bitmap.width,bitmap.height))
	   else if fgripsDir=gdDown then
   		bitmap.canvas.fillrect(rect(0,0,bitmap.width-rh,bitmap.height));
   end;
   //
	for q:=0 to fGrips.Count-1 do begin
   	GetGripPoly(q,poly);
      // Disegna grip
      bitmap.Canvas.Brush.Color := GripsColor[q];
		bitmap.Canvas.Pen.Color := clBlack;
      bitmap.Canvas.Polygon(slice(poly,NumLinesGKind[GripsKind[q]]));
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// rilascio mouse
// fMouseSel 0=niente  1=capture su sat/val  2=capture su hue
procedure TRulerBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	inherited;
	//
   if fSelGrip>=0 then begin
   	if (fMX1=X) and (fMY1=Y) and assigned(fOnRulerGripClick) then
      	fOnRulerGripClick(self,fSelGrip);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// aggiusta limiti del grip specificato (in base ai suoi Max e Min)
procedure TRulerBox.AdjustGripLimits(gn:integer);
begin
	if GripsMin[gn]<GripsMax[gn] then begin
		if GripsPos[gn]<GripsMin[gn] then
   		GripsPos[gn]:=GripsMin[gn]
	   else if GripsPos[gn]>GripsMax[gn] then
      	GripsPos[gn]:=GripsMax[gn];
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// rest. dimensione orizzontale in units
function TRulerBox.GetWidthInUnit:double;
begin
	result:=(bitmap.width)/fDPU;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Aggiusta limiti di fViewPos (in base a fViewMin e fViewMax)
procedure TRulerBox.AdjustViewLimits;
begin
	if fViewMin<fViewMax then begin
   	if fViewPos<fViewMin then
      	fViewPos:=fViewMin
      else if fViewPos>(fViewMax-GetWidthInUnit) then
        	fViewpos:=dmax(0,fViewMax-GetWidthInUnit);
	end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// movimento mouse
procedure TRulerBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
   p:tpoint;
begin
	inherited;
   //
   if MouseCapture then
      if (fSelGrip>=0) then begin
      	if fRulerDir=rdHorizontal then begin
         	if X<0 then begin
					repeat
               	getcursorpos(p);
                  p:=screentoclient(p);
                  PGrip(fGrips[fSelGrip])^.Pos:=(fSelGripSt-fMX1)/fDPU+fViewPos-(1/fDPU);
                  AdjustGripLimits(fSelGrip);
                  fViewPos:=fViewPos-(1/fDPU); 	// sposta di un pixel (poi conv. in unit)
                  AdjustViewLimits;
                  RepaintGrips;
					   RepaintRuler;
                  Paint;
   	            if assigned(fOnRulerPosChange) then
		 			   	fOnRulerPosChange(self,fSelGrip);
               until (p.x>=0) or (GetAsyncKeyState(VK_LBUTTON)=0);
            end else if X>bitmap.width then begin
					repeat
               	getcursorpos(p);
                  p:=screentoclient(p);
  						PGrip(fGrips[fSelGrip])^.Pos:=(fSelGripSt+bitmap.width-1-fMX1)/fDPU+fViewPos+(1/fDPU);
                  AdjustGripLimits(fSelGrip);
                  fViewPos:=fViewPos+(1/fDPU);
                  AdjustViewLimits;
                  RepaintGrips;
					   RepaintRuler;
                  Paint;
   	            if assigned(fOnRulerPosChange) then
		 			   	fOnRulerPosChange(self,fSelGrip);
               until (p.x<bitmap.width) or (GetAsyncKeyState(VK_LBUTTON)=0);
            end else begin
					SetGripsPos(fSelGrip,(fSelGripSt+X-fMX1)/fDPU+fViewPos);
               Paint;
            end;
         end else begin
         	if Y<0 then begin
					repeat
               	getcursorpos(p);
                  p:=screentoclient(p);
                  PGrip(fGrips[fSelGrip])^.Pos:=(fSelGripSt-fMY1)/fDPU+fViewPos-(1/fDPU);
                  AdjustGripLimits(fSelGrip);
                  fViewPos:=fViewPos-(1/fDPU);
                  AdjustViewLimits;
                  RepaintGrips;
					   RepaintRuler;
                  Paint;
   	            if assigned(fOnRulerPosChange) then
		 			   	fOnRulerPosChange(self,fSelGrip);
               until (p.y>=0) or (GetAsyncKeyState(VK_LBUTTON)=0);
            end else if Y>=bitmap.height then begin
					repeat
               	getcursorpos(p);
                  p:=screentoclient(p);
						PGrip(fGrips[fSelGrip])^.Pos:=(fSelGripSt+bitmap.height-1-fMY1)/fDPU+fViewPos+(1/fDPU);
                  AdjustGripLimits(fSelGrip);
                  fViewPos:=fViewPos+(1/fDPU);
                  AdjustViewLimits;
                  RepaintGrips;
					   RepaintRuler;
                  Paint;
   	            if assigned(fOnRulerPosChange) then
		 			   	fOnRulerPosChange(self,fSelGrip);
               until (p.y<bitmap.height) or (GetAsyncKeyState(VK_LBUTTON)=0);
         	end else begin
	         	SetGripsPos(fSelGrip,(fSelGripSt+Y-fMY1)/fDPU+fViewPos);
               Paint;
            end;
         end;
      end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetGripsMax(i:integer; v:double);
var
	q:integer;
begin
	if (i<fGrips.Count) then begin
		PGrip(fGrips[i])^.Max:=v;
		for q:=0 to fGrips.Count-1 do
      	AdjustGripLimits(q);
      Update;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetGripsMin(i:integer; v:double);
var
	q:integer;
begin
	if (i<fGrips.Count) then begin
		PGrip(fGrips[i])^.Min:=v;
		for q:=0 to fGrips.Count-1 do
      	AdjustGripLimits(q);
      Update;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TRulerBox.GetGripsMax(i:integer):double;
begin
	if i<fGrips.Count then
   	result:=PGrip(fGrips[i])^.Max
   else
   	result:=0;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TRulerBox.GetGripsMin(i:integer):double;
begin
	if i<fGrips.Count then
   	result:=PGrip(fGrips[i])^.Min
   else
   	result:=0;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetViewMin(v:double);
var
	q:integer;
begin
	fViewMin:=v;
   AdjustViewLimits;
   for q:=0 to fGrips.Count-1 do
   	PGrip(fGrips[q])^.Min:=fViewMin;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetViewMax(v:double);
var
	q:integer;
begin
	fViewMax:=v;
   AdjustViewLimits;
   for q:=0 to fGrips.Count-1 do
   	PGrip(fGrips[q])^.Max:=fViewMax;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// ridisegna ruler+testo
procedure TRulerBox.RepaintRuler;
var
	z,v:double;		// pos in unit
   x,y:integer;		// pos in pixel
   rl:integer;		// ruler height
   fh:integer;		// font height (abs)
   lb1,lb:string;
   xx,yy:integer;
   LogFont:TLogFont;
	SaveFont:TFont;
   q,w,e:integer;
begin
	if not fRuler then
   	exit;
	bitmap.Canvas.Brush.Color:=fRulerColor;
   rl:=GetRulerHeight;
   fh:=abs(Font.Height);
   if fRulerDir=rdHorizontal then begin
	   if fGripsDir=gdDown then
	      bitmap.canvas.fillrect(rect(0,bitmap.height-rl,bitmap.width,bitmap.height))
	   else
	   	bitmap.canvas.fillrect(rect(0,0,bitmap.width,rl+1));
   end else begin
	   if fGripsDir=gdDown then
      	bitmap.canvas.fillrect(rect(bitmap.width-rl,0,bitmap.width,bitmap.height))
	   else
			bitmap.canvas.fillrect(rect(0,0,rl,bitmap.height));
	end;
   // disegna
   bitmap.canvas.Pen.Color:=Font.Color;
   bitmap.canvas.Font:=Font;
	if fRulerDir=rdVertical then begin
   	// VERTICAL
      // prepara font verticale
		SaveFont:=TFont.Create;
		SaveFont.assign(bitmap.canvas.font);
      GetObject(SaveFont.Handle,sizeof(TLogFont),@LogFont);
      if fGripsDir=gdDown then
	   	LogFont.lfEscapement:=-900	// 90 gradi
      else
			LogFont.lfEscapement:=900;	// 90 gradi
   	LogFont.lfPitchAndFamily:=FIXED_PITCH or FF_DONTCARE;
      bitmap.canvas.font.handle:=CreateFontIndirect(LogFont);
      //
      // Disegna tacca piccola
      w:= trunc((bitmap.height/fDPU) / fFrequency);	// numero di tacche piccole
      for q:=0 to w+1 do begin
      	v:=((fViewPos/fFrequency)-trunc(fViewPos/fFrequency))*fFrequency;
			z:=q*fFrequency+fViewPos-v;
         y:=round( (z-fViewPos)*fDPU );
         if fGripsDir=gdDown then begin	// DOWN
         	Bitmap.Canvas.MoveTo(bitmap.width-rl,y);
	         bitmap.Canvas.LineTo(bitmap.width-rl+(rl div 4),y);
         end else begin	// UP
         	Bitmap.Canvas.MoveTo(rl,y);
				bitmap.Canvas.LineTo(rl-(rl div 4),y);
         end;
      end;
		// Disegna tacca lunga e testo
      w:= trunc((bitmap.height/fDPU) / fLabelFreq);	// numero di tacche lunghe
      for q:=0 to w+1 do begin
      	v:=((fViewPos/fLabelFreq)-trunc(fViewPos/fLabelFreq))*fLabelFreq;
	      z:=q*fLabelFreq+fViewPos-v;
         if fHexLabels then begin
  				lb1:=inttohex(trunc(abs(z)),6);
            // toglie zeri iniziali
            lb:='0';
         	for e:=1 to length(lb1) do
            	if lb1[e]<>'0' then begin
               	lb:=copy(lb1,e,length(lb1));
                  break;
               end;
            if z<0 then
            	lb:='-'+lb;
         end else
			   lb:=floattostrF(z,ffGeneral,15,3);
         y:=round( (z-fViewPos)*fDPU );
         if fGripsDir=gdDown then begin	// DOWN
           	yy:=y-(Bitmap.Canvas.TextWidth(lb) div 2);
         	Bitmap.Canvas.MoveTo(bitmap.width-rl,y);
	         bitmap.Canvas.LineTo(bitmap.width-rl+(rl div 2),y);
            Bitmap.Canvas.TextOut(bitmap.width,yy, lb);
         end else begin	// UP
            yy:=y+(Bitmap.Canvas.TextWidth(lb) div 2);
         	Bitmap.Canvas.MoveTo(rl,y);
				bitmap.Canvas.LineTo(rl-(rl div 2),y);
            Bitmap.Canvas.TextOut(0,yy, lb);
         end;
      end;
      // libera font
      bitmap.canvas.font.assign(SaveFont);
      SaveFont.free;
   end else begin
   	// HORIZONTAL
      // Disegna tacca piccola
      w:= trunc((bitmap.width/fDPU) / fFrequency);	// numero di tacche piccole
      for q:=0 to w+1 do begin
      	v:=((fViewPos/fFrequency)-trunc(fViewPos/fFrequency))*fFrequency;
			z:=q*fFrequency+fViewPos-v;
         x:=round( (z-fViewPos)*fDPU );
         if fGripsDir=gdDown then begin	// DOWN
         	Bitmap.Canvas.MoveTo(x,bitmap.height-rl);
	         bitmap.Canvas.LineTo(x,bitmap.height-rl+(rl div 4));
         end else begin	// UP
         	Bitmap.Canvas.MoveTo(x,rl);
				bitmap.Canvas.LineTo(x,rl-(rl div 4));
         end;
		end;
		// Disegna tacca lunga e testo
      w:= trunc((bitmap.width/fDPU) / fLabelFreq);	// numero di tacche lunghe
      for q:=0 to w+1 do begin
      	v:=((fViewPos/fLabelFreq)-trunc(fViewPos/fLabelFreq))*fLabelFreq;
	      z:=q*fLabelFreq+fViewPos-v;
         if fHexLabels then begin
  				lb1:=inttohex(trunc(abs(z)),6);
            // toglie zeri iniziali
            lb:='0';
         	for e:=1 to length(lb1) do
            	if lb1[e]<>'0' then begin
               	lb:=copy(lb1,e,length(lb1));
                  break;
               end;
            if z<0 then
            	lb:='-'+lb;
         end else
			   lb:=floattostrF(z,ffGeneral,15,3);
         x:=round( (z-fViewPos)*fDPU );
     	 	xx:=x-(Bitmap.Canvas.TextWidth(lb) div 2);
         if fGripsDir=gdDown then begin	// DOWN
         	Bitmap.Canvas.MoveTo(x,bitmap.height-rl);
	         bitmap.Canvas.LineTo(x,bitmap.height-rl+(rl div 2));
            Bitmap.Canvas.TextOut(xx, bitmap.height-fh, lb);
         end else begin	// UP
         	Bitmap.Canvas.MoveTo(x,rl);
				bitmap.Canvas.LineTo(x,rl-(rl div 2));
            Bitmap.Canvas.TextOut(xx, 0, lb);
         end;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetFitInView(v:boolean);
begin
	fFitInView:=v;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetDPU(v:double);
begin
	if (csDesigning in Componentstate) and fFitInView then
   	exit;
   fDPU:=v;
	Update;
   Paint;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TRulerBox.SetHexLabels(v:boolean);
begin
	fHexLabels:=v;
   Update;
end;

{$else}
interface

implementation
{$endif}

end.
