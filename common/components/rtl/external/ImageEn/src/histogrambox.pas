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

unit histogrambox;

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

  THistogramKind = set of (hkRed,hkGreen,hkBlue,hkGray);

  THistogramLabels = set of (hlVertical,hlHorizontal);

  THistogramStyle = (hsBars,hsLines);

  THistogramBox = class(TCustomControl)
  private
    { Private declarations }
    Bitmap:TBitMap;
    fBackground:TColor;
    fAIEP:TImageEnProc;		// abb. fAttachedImageEnProc (!)
    fHistKind:THistogramKind;
    fLabels:THistogramLabels;
    fCompBar:boolean;
    fHistogramStyle:THistogramStyle;
    fHistogramXPos:integer;
    fGrayColor:TColor;
    procedure SetBackground(bk:TColor);
    procedure SetLabels(v:THistogramLabels);
    procedure SetCompBar(v:boolean);
    procedure SetHistogramStyle(v:THistogramStyle);
    procedure SetHistogramKind(v:THistogramKind);
    procedure SetAIEP(v:TImageEnProc);
    function GetHistogramKind:THistogramKind;
    function GetLabels:THistogramLabels;
  protected
    { Protected declarations }
    {$ifdef IEDELPHI}
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMEraseBkgnd(var Message:TMessage); message WM_ERASEBKGND;
    {$endif}
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
	 procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
	 procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    { Public declarations }
    procedure Paint; override;
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure Update; override;
    property HistogramXPos:integer read fHistogramXPos;
  published
    { Published declarations }
    property AttachedImageEnProc:TImageEnProc read fAIEP write SetAIEP;
    property Background:TColor read fBackground write SetBackground default clWhite;
    property HistogramKind:THistogramKind read GetHistogramKind write SetHistogramKind default [hkGray];
    property Labels:THistogramLabels read GetLabels write SetLabels default [hlVertical,hlHorizontal];
    property CompBar:boolean read fCompBar write SetCompBar default true;
    property HistogramStyle:THistogramStyle read fHistogramStyle write SetHistogramStyle default hsBars;
    property GrayColor:TColor read fGrayColor write fGrayColor default clBlack;
    property Align;
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
    property Font;
    property Width default 256;
    property Height default 105;
  end;

implementation

{$R-}

/////////////////////////////////////////////////////////////////////////////////////
constructor THistogramBox.Create(Owner: TComponent);
begin
	inherited Create(Owner);
   //controlstyle:=controlstyle+[csOpaque];
   ControlStyle := ControlStyle + [csOpaque, csAcceptsControls];
   fBackground:=clWhite;
   fHistKind:=[hkGray];
   fLabels:=[hlVertical,hlHorizontal];
   fCompBar:=true;
   fHistogramStyle:=hsBars;
   fGrayColor:=clBlack;
   Height := 105;
   Width := 256;
   bitmap:=TBitmap.create;
   bitmap.PixelFormat:=pf24bit;
   bitmap.Width:=width;
   bitmap.Height:=height;
   fAIEP:=nil;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
destructor THistogramBox.Destroy;
begin
	bitmap.free;
   inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure THistogramBox.Paint;
begin
	canvas.Draw(0,0,bitmap);
end;

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEDELPHI}
procedure THistogramBox.WMEraseBkgnd(var Message:TMessage);
begin
	Message.Result:=0;
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEDELPHI}
procedure THistogramBox.WMSize(var Message: TWMSize);
begin
  	inherited;
   bitmap.Width:=message.Width;
   bitmap.Height:=message.Height;
   Update;
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
procedure THistogramBox.SetBackground(bk:TColor);
begin
	fBackground:=bk;
   update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// movimento mouse
procedure THistogramBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
	inherited;
   //
end;

/////////////////////////////////////////////////////////////////////////////////////
// pressione di un bottone del mouse
procedure THistogramBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	inherited;
   if (Button=mbLeft) then begin
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// rilascio mouse
// fMouseSel 0=niente  1=capture su sat/val  2=capture su hue
procedure THistogramBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	inherited;
	//
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure THistogramBox.SetLabels(v:THistogramLabels);
begin
	if v<>fLabels then begin
   	fLabels:=v;
      Update;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure THistogramBox.SetCompBar(v:boolean);
begin
	if v<>fCompBar then begin
   	fCompBar:=v;
      Update;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure THistogramBox.SetHistogramStyle(v:THistogramStyle);
begin
	if v<>fHistogramStyle then begin
   	fHistogramStyle:=v;
      Update;
   end;
end;

procedure THistogramBox.SetHistogramKind(v:THistogramKind);
begin
	if v<>fHistKind then begin
   	fHistKind:=v;
      Update;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// ricostruisce l'istogramma in base alla selezione corrente
procedure THistogramBox.Update;
var
   MaxV:dword;	// massimo valore tra r,g,b,gray (max valore verticale)
   q,w,e:integer;
   PHist:PHistogram;
   dx,dy,x1:integer;
   xx:integer;
   sz:TSize;
   compdy:integer;
   px:pRGBROW;
begin
	bitmap.Canvas.Brush.Color:=fBackground;
   bitmap.canvas.fillrect(rect(0,0,bitmap.width,bitmap.height));
	if (assigned(fAIEP) and assigned(fAIEP.AttachedIEBitmap)) or (csDesigning in ComponentState) then begin
   	new(pHist);
      if csDesigning in ComponentState then
      	for q:=0 to 255 do begin
         	pHist^[q].r:=random(256);
            pHist^[q].g:=random(256);
            pHist^[q].b:=random(256);
            pHist^[q].Gray:=random(256);
         end
      else
  	   	fAIEP.GetHistogram(pHist^);
	   // trova massimo valore nell'istogramma
      MaxV:=0;
      for q:=0 to 255 do begin
        	if (hkRed in fHistKind)   and (PHist^[q].r    > MaxV) then
           	MaxV:=PHist^[q].r;
        	if (hkGreen in fHistKind) and (PHist^[q].g    > MaxV) then
           	MaxV:=PHist^[q].g;
        	if (hkBlue in fHistKind)  and (PHist^[q].b    > MaxV) then
           	MaxV:=PHist^[q].b;
        	if (hkGray in fHistKind)  and (PHist^[q].Gray > MaxV) then
           	MaxV:=PHist^[q].Gray;
		end;
      if MaxV>0 then begin
         dx:=width;
	      dy:=height;
         x1:=0;
         compdy:=trunc(abs(Font.Height)*1.2);
         if fCompBar then
				dec(dy,compdy+2);
         // LABELS
         if (hlVertical in fLabels) then begin
	      	// disegna asse verticale con numerazioni
         	bitmap.canvas.font:=Font;
            //sz:=bitmap.canvas.textextent(inttostr(MaxV));
            if assigned(fAIEP) and assigned(fAIEP.AttachedIEBitmap) then
	            sz:=bitmap.canvas.textextent(inttostr(fAIEP.AttachedIEBitmap.Width*fAIEP.AttachedIEBitmap.Height))
            else
            	sz:=bitmap.canvas.textextent(inttostr(MaxV));
            bitmap.canvas.TextOut(0,dy div 2,inttostr(MaxV div 2));
            bitmap.canvas.TextOut(0,0,inttostr(MaxV));
            bitmap.canvas.pen.Color:=Font.Color;
	         dec(dx,sz.cx+2);
	         inc(x1,sz.cx+2);
         end;
			if (hlHorizontal in fLabels) then begin
	   	   // disegna asse orizzontale con numerazioni
         	bitmap.canvas.font:=Font;
            if assigned(fAIEP) and assigned(fAIEP.AttachedIEBitmap) then
	            sz:=bitmap.canvas.textextent(inttostr(fAIEP.AttachedIEBitmap.Width*fAIEP.AttachedIEBitmap.Height))
            else
            	sz:=bitmap.canvas.textextent(inttostr(MaxV));
            for q:=0 to 3 do
            	bitmap.canvas.TextOut(x1+round(((q*64)/256)*dx),dy-abs(Font.Height)-1,inttostr(q*64));
				q:=bitmap.canvas.TextWidth('255');
				bitmap.canvas.TextOut(x1+dx-q,dy-abs(Font.Height)-1,'255');
				dec(dy,sz.cy+2);
            // assi
            bitmap.Canvas.MoveTo(x1-1,0);
            bitmap.Canvas.LineTo(x1-1,dy);
            bitmap.Canvas.LineTo(x1+dx,dy);
         end;
         //
         fHistogramXPos:=Left+x1;
         // COMPBAR
         if fCompBar then begin
				for w:=0 to compdy-1 do begin	// row
            	px:=bitmap.ScanLine[bitmap.height-w-1];
               for q:=0 to dx-1 do begin
               	px^[x1+q].r:=0; px^[x1+q].g:=0; px^[x1+q].b:=0;
                  e:=round(q/dx*256);
               	if (hkRed in fHistKind) or (hkGray in fHistKind) then
	               	px^[x1+q].r:=e;
               	if (hkGreen in fHistKind) or (hkGray in fHistKind) then
	               	px^[x1+q].g:=e;
               	if (hkBlue in fHistKind) or (hkGray in fHistKind) then
	               	px^[x1+q].b:=e;
					end;
            end;
         end;
         // disegna istogramma su Bitmap
         // hsBars
         if fHistogramStyle=hsBars then
				for xx:=0 to dx-1 do begin
            	q:=trunc(xx/dx*256);
		         if hkRed in fHistKind then begin
			         bitmap.canvas.pen.color:=clRed;
		            bitmap.canvas.MoveTo( xx+x1, dy-1 );
                  e:=round((PHist^[q].r/MaxV)*dy);
                  if (PHist^[q].r>0) and (e=0) then e:=1;
		            bitmap.canvas.LineTo( xx+x1, dy-1-e );
		         end;
		         if hkGreen in fHistKind then begin
		         	bitmap.canvas.pen.color:=clGreen;
		            bitmap.canvas.MoveTo( xx+x1, dy-1 );
                  e:=round((PHist^[q].g/MaxV)*dy);
						if (PHist^[q].g>0) and (e=0) then e:=1;
		            bitmap.canvas.LineTo( xx+x1, dy-1-e );
		         end;
		         if hkBlue in fHistKind then begin
		         	bitmap.canvas.pen.color:=clBlue;
		            bitmap.canvas.MoveTo( xx+x1, dy-1 );
                  e:=round((PHist^[q].b/MaxV)*dy);
                  if (PHist^[q].b>0) and (e=0) then e:=1;
		            bitmap.canvas.LineTo( xx+x1, dy-1-e );
		         end;
					if hkGray in fHistKind then begin
		         	bitmap.canvas.pen.color:=fGrayColor;
		            bitmap.canvas.MoveTo( xx+x1, dy-1 );
                  e:=round((PHist^[q].Gray/MaxV)*dy);
						if (PHist^[q].Gray>0) and (e=0) then e:=1;
		            bitmap.canvas.LineTo( xx+x1, dy-1-e );
               end;
	   	   end;
         // hsLines
         if fHistogramStyle=hsLines then begin
	         if hkRed in fHistKind then begin
		         bitmap.canvas.pen.color:=clRed;
	         	bitmap.canvas.moveto(x1,dy-1);
		         for xx:=0 to dx-1 do begin
	   	         q:=trunc(xx/dx*256);
						bitmap.canvas.LineTo( xx+x1, dy-1-round((PHist^[q].r/MaxV)*dy)+1 );
		         end;
	         end;
	         if hkGreen in fHistKind then begin
	         	bitmap.canvas.pen.color:=clGreen;
	         	bitmap.canvas.moveto(x1,dy-1);
		         for xx:=0 to dx-1 do begin
	   	         q:=trunc(xx/dx*256);
						bitmap.canvas.LineTo( xx+x1, dy-1-round((PHist^[q].g/MaxV)*dy)+1 );
		         end;
	         end;
	         if hkBlue in fHistKind then begin
	         	bitmap.canvas.pen.color:=clBlue;
	         	bitmap.canvas.moveto(x1,dy-1);
		         for xx:=0 to dx-1 do begin
	   	         q:=trunc(xx/dx*256);
                  bitmap.canvas.LineTo( xx+x1, dy-1-round((PHist^[q].b/MaxV)*dy)+1 );
		         end;
	         end;
				if hkGray in fHistKind then begin
	         	bitmap.canvas.pen.color:=fGrayColor;
	         	bitmap.canvas.moveto(x1,dy-1);
		         for xx:=0 to dx-1 do begin
	   	         q:=trunc(xx/dx*256);
	               bitmap.canvas.LineTo( xx+x1, dy-1-round((PHist^[q].Gray/MaxV)*dy)+1 );
		         end;
	   	   end;
         end;
      end;
      //
      dispose(pHist);
   end;
   invalidate;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure THistogramBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
	inherited Notification(AComponent, Operation);
	if (AComponent=fAIEP) and (Operation=opRemove) then fAIEP:=nil;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure THistogramBox.SetAIEP(v:TImageEnProc);
begin
   fAIEP:=v;
   if assigned(fAIEP) then
      fAIEP.FreeNotification(self);
end;

/////////////////////////////////////////////////////////////////////////////////////
function THistogramBox.GetHistogramKind:THistogramKind;
begin
	result:=fHistKind;
end;

/////////////////////////////////////////////////////////////////////////////////////
function THistogramBox.GetLabels:THistogramLabels;
begin
	result:=fLabels;
end;


end.
