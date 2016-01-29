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

unit iegradientbar;

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

  TIEGradientDir = (gdHorizontal, gdVertical);

  // Interazioni automatiche con il mouse
  TIEMouseInteractItemsGr=(
  								  migDragGrip
  								);
  TIEMouseInteractGr=set of TIEMouseInteractItemsGr;

  TIEGradientBar = class(TCustomControl)
  private
    { Private declarations }
    fColorIndex:integer;
    fBeginColor:TColor;
    fEndColor:TColor;
    fGradient:array [0..255] of TColor;
    fDirection:TIEGradientDir;
    fOnChange:TNotifyEvent;
    fMouseInteract:TIEMouseInteractGr;
    procedure SetColorIndex(v:integer);
    procedure SetBeginColor(v:TColor);
    procedure SetEndColor(v:TColor);
    function GetColor:TColor;
    function GetRGB:TRGB;
    procedure SetDirection(v:TIEGradientDir);
    procedure SetMouseInteractGr(v:TIEMouseInteractGr);
    function GetMouseInteractGr:TIEMouseInteractGr;
  protected
    { Protected declarations }
    {$ifdef IEDELPHI}
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMEraseBkgnd(var Message:TMessage); message WM_ERASEBKGND;
    {$endif}
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
	 procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
	 procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure CalcGradient;
    procedure DrawGrip;
  public
    { Public declarations }
    procedure Paint; override;
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    property ColorIndex:integer read fColorIndex write SetColorIndex;
    property Color:TColor read GetColor;
    property RGB:TRGB read GetRGB;
  published
    { Published declarations }
    property BeginColor:TColor read fBeginColor write SetBeginColor default clBlack;
    property EndColor:TColor read fEndColor write SetEndColor default clWhite;
    property Direction:TIEGradientDir read fDirection write SetDirection default gdVertical;
    property OnChange:TNotifyEvent read fOnChange write fOnChange;
    property MouseInteract:TIEMouseInteractGr read GetMouseInteractGr write SetmouseInteractGr default [migDragGrip];
    property Width default 40;
    property Height default 300;
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
  end;

implementation

{$R-}

/////////////////////////////////////////////////////////////////////////////////////
constructor TIEGradientBar.Create(Owner: TComponent);
begin
	inherited Create(Owner);
   //controlstyle:=controlstyle+[csOpaque];
   ControlStyle := ControlStyle + [csOpaque, csAcceptsControls];
   Height := 300;
   Width  := 40;
   fColorIndex:=0;
   fBeginColor:=clBlack;
   fEndColor:=clWhite;
   fDirection:=gdVertical;
   fMouseInteract:=[migDragGrip];
   CalcGradient;
end;

/////////////////////////////////////////////////////////////////////////////////////
destructor TIEGradientBar.Destroy;
begin
   inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEDELPHI}
procedure TIEGradientBar.WMEraseBkgnd(var Message:TMessage);
begin
	Message.Result:=0;
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEDELPHI}
procedure TIEGradientBar.WMSize(var Message: TWMSize);
begin
  	inherited;
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
procedure TIEGradientBar.SetColorIndex(v:integer);
begin
	fColorIndex:=v;
   invalidate;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TIEGradientBar.SetBeginColor(v:TColor);
begin
	fBeginColor:=v;
   CalcGradient;
   invalidate;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TIEGradientBar.SetEndColor(v:TColor);
begin
	fEndColor:=v;
   CalcGradient;
   invalidate;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TIEGradientBar.GetColor:TColor;
begin
	result:=fGradient[fColorIndex];
end;

/////////////////////////////////////////////////////////////////////////////////////
function TIEGradientBar.GetRGB:TRGB;
begin
	result:=TColor2TRGB(fGradient[fColorIndex]);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TIEGradientBar.SetDirection(v:TIEGradientDir);
begin
	fDirection:=v;
   invalidate;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TIEGradientBar.CalcGradient;
var
	BeginRGB,EndRGB:TRGB;
   ir,ig,ib:double;
   q:integer;
begin
	BeginRGB:=TColor2TRGB(fBeginColor);
   EndRGB:=TColor2TRGB(fEndColor);
   ir:=(-EndRGB.r+BeginRGB.r)/255;
   ig:=(-EndRGB.g+BeginRGB.g)/255;
   ib:=(-EndRGB.b+BeginRGB.b)/255;
   for q:=0 to 255 do
		fGradient[q]:=RGB2TColor(blimit(EndRGB.r+trunc(q*ir)),
               	   	       blimit(EndRGB.g+trunc(q*ig)),
                               blimit(EndRGB.b+trunc(q*ib)));
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TIEGradientBar.Paint;
var
   ii:double;
   q:integer;
begin
   Canvas.Pen.Style:=psSolid;
   Canvas.Pen.Mode:=pmCopy;
	case fDirection of
   	gdVertical:
      	begin
         	if ClientHeight<2 then exit;
         	ii:=255/(ClientHeight-1);
				for q:=0 to ClientHeight-1 do begin
            	Canvas.Pen.Color:=fGradient[trunc(ii*q)];
            	Canvas.MoveTo(0,q);
               Canvas.LineTo(ClientWidth,q);
            end;
         end;
      gdHorizontal:
      	begin
         	if ClientWidth<2 then exit;
         	ii:=255/(ClientWidth-1);
				for q:=0 to ClientWidth-1 do begin
            	Canvas.Pen.Color:=fGradient[trunc(ii*q)];
               Canvas.MoveTo(q,0);
               Canvas.LineTo(q,ClientHeight);
            end;
         end;
   end;
   if (not (csDesigning in ComponentState)) and (migDragGrip in fMouseInteract) then
	   DrawGrip;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Disegna grip alla posizione fColorIndex
procedure TIEGradientBar.DrawGrip;
var
	ii:double;
   pp:integer;
begin
   Canvas.Pen.Style:=psSolid;
   Canvas.Pen.Mode:=pmNot;
   Canvas.Brush.Style:=bsClear;
	case fDirection of
   	gdVertical:
      	begin
         	ii:=(ClientHeight-1)/255;
				pp:=trunc(fColorIndex*ii);
            Canvas.Rectangle(0,pp+3,clientwidth,pp-3);
         end;
      gdHorizontal:
      	begin
         	ii:=(ClientWidth-1)/255;
				pp:=trunc(fColorIndex*ii);
            Canvas.Rectangle(pp-3,0,pp+3,clientheight);
         end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// movimento mouse
procedure TIEGradientBar.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
	inherited;
   //
   y:=ilimit(y,0,clientheight-1);
   x:=ilimit(x,0,clientwidth-1);
   if MouseCapture then begin
   	if (migDragGrip in fMouseInteract) then begin
         DrawGrip;
         case fDirection of
            gdVertical:   fColorIndex:= trunc(y/(clientheight-1)*255);
            gdHorizontal: fColorIndex:= trunc(x/(clientwidth-1)*255);
         end;
         DrawGrip;
         if Assigned(fOnChange) then
            fOnChange(Self);
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// pressione di un bottone del mouse
procedure TIEGradientBar.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	inherited;
   y:=ilimit(y,0,clientheight-1);
   x:=ilimit(x,0,clientwidth-1);
   if (Button=mbLeft) then begin
   	if (migDragGrip in fMouseInteract) then begin
         DrawGrip;
         case fDirection of
            gdVertical:   fColorIndex:= trunc(y/(clientheight-1)*255);
            gdHorizontal: fColorIndex:= trunc(x/(clientwidth-1)*255);
         end;
         DrawGrip;
         if Assigned(fOnChange) then
            fOnChange(Self);
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// rilascio mouse
procedure TIEGradientBar.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TIEGradientBar.SetMouseInteractGr(v:TIEMouseInteractGr);
begin
	fMouseInteract:=v;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TIEGradientBar.GetMouseInteractGr:TIEMouseInteractGr;
begin
	result:=fMouseInteract;
end;



end.
