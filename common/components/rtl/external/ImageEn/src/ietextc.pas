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

unit ietextc;

{$R-}
{$Q-}


{$I ie.inc}

(*$ifdef IEDELPHI*)

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, ImageEnView,
   Controls, StdCtrls, Forms, hyieutils, hyiedefs;

type TIECharInfo=record
	refcount:integer;
	// single AnsiChar info
	name:String[255];
	height:integer;
	style:TFontStyles;
   color:TColor;
	brushColor:TColor;
   brushStyle:TBrushStyle;
   // paragraph info (all chars inside before the #10 must have equal values)
   align:TIEAlignment;
end;
PIECharInfo=^TIECharInfo;


TIETextControl = class(TCustomControl)
	private
	protected
      fText:PAnsiChar;
      fTextLength:integer;	// without ZERO ending
      fInsertPos:integer;
      fBackbuf:TBitmap;
      fCaretX,fCaretY,fCaretH:integer;
      fDefaultFont:TFont;
      fDefaultFontBrush:TBrush;
      fBorderPen:TPen;
      fBrush:TBrush;
      fInsMode:boolean;
      fDefaultAlign:TIEAlignment;
      fZoom:double;
      fSelStart:integer;
      fSelStop:integer;
      fMouseDownX,fMouseDownY:integer;
      fInsertingCharInfo:PIECharInfo;
      fForceDefaultColors:boolean;
      fFontLocked:boolean;
      fAutoSize:boolean;
      fLineSpace:integer;
      fFixedHeight:integer;
		//
      fcache_h:pbytearray;
      fcache_w:pbytearray;
      fcache_InternalLeading:pbytearray;
      fposxarray,fposyarray:pintegerarray;
      fCharInfo:TList;
      fCharRef:pintegerarray;	// reference to fCharInfo for each character
      fWriteFormattedString:boolean;
      fFormattedString:AnsiString;
		procedure CreateParams(var Params: TCreateParams); override;
      procedure WMSize(var Message: TWMSize); message WM_SIZE;
      procedure WMEraseBkgnd(var Message:TMessage); message WM_ERASEBKGND;
      procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
      procedure CMWantSpecialKey(var Msg: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
      procedure WMCut(var Message: TMessage); message WM_CUT;
      procedure WMCopy(var Message: TMessage); message WM_COPY;
      procedure WMPaste(var Message: TMessage); message WM_PASTE;
      procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
      procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
      procedure KeyDown(var Key: Word; Shift: TShiftState); override;
      procedure KeyUp(var Key: Word; Shift: TShiftState); override;
      procedure GoBack(var CurPos:PAnsiChar);
      function GoBackIdx(var CurPos:integer):boolean;
      procedure GoForwardIdx(var CurPos:integer);
      procedure SaveCharInfo(idx:integer; charinf:PIECharInfo);
      function FindCharInfo(info:PIECharInfo):integer;
      procedure RestoreCharInfo(idx:integer; XCanvas:TCanvas);
      procedure CopyCharInfoTo(source:integer; charinf:PIECharInfo);
      function DelChar(idx:integer):integer;
      procedure IncFontSize;
      procedure DecFontSize;
      procedure MoveUp;
      procedure MoveDown;
      procedure MoveHome;
      procedure MoveEnd;
      procedure MoveTo(x,y:integer);
      procedure ClearBitmap;
      procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
      procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
      procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
      procedure ResetSelection;
      procedure SStop(PrevPos:integer; Shift:TShiftState);
      procedure RemoveSelected;
      procedure CopyToClipboard;
      procedure PasteFromClipboard;
      procedure ResetCache(from,len:integer);
      procedure SetXFont(fnt:TFont);
      procedure SwitchFontStyle(sty:TFontStyle);
		procedure GoWordBackIdx(var CurPos:integer);
		procedure GoWordForwardIdx(var CurPos:integer);
      procedure SetXBackColor(bk:TColor);
      procedure SetFontLocked(value:boolean);
   public
   	constructor Create(Owner: TComponent); override;
      destructor Destroy; override;
      procedure Paint; override;
		procedure Update; override;
      property Text:PAnsiChar read fText write fText;
      property TextFormatRef:pintegerarray read fCharRef write fCharRef;
      property TextFormat:TList read fCharInfo write fCharInfo;
      procedure KeyPress(var Key: Char); override;
      procedure PaintTo(DestCanvas:TCanvas; DestX,DestY,NonZoomDestWidth,NonZoomDestHeight:integer);
      procedure AddChar(key:AnsiChar);
      procedure InsertAlign(Align:TIEAlignment);
      procedure Init;
      procedure RemoveUnreferenced;
      property DefaultFont:TFont read fDefaultFont;
      property DefaultFontBrush:TBrush read fDefaultFontBrush;
      property DefaultAlign:TIEAlignment read fDefaultAlign write fDefaultAlign;
      property BorderPen:TPen read fBorderPen;
      property Brush:TBrush read fBrush;
      property Zoom:double read fZoom write fZoom;
      property OnKeyDown;
      property ForceDefaultColors:boolean read fForceDefaultColors write fForceDefaultColors;
      property IsFontLocked:boolean read fFontLocked write SetFontLocked;
      property AutoSize:boolean read fAutoSize write fAutoSize;
      property GlobalLineSpace:integer read fLineSpace write fLineSpace;
      property GlobalFixedHeight:integer read fFixedHeight write fFixedHeight;	// 0=use font size (default)
      property WriteFormattedString:boolean read fWriteFormattedString write fWriteFormattedString;
      property FormattedString:AnsiString read fFormattedString;
end;

implementation

uses imageenproc,dialogs;

const IETEXTMEMOCLIPFORMAT_NAME:AnsiString='IMAGEEN TEXTMEMO';

var
	IETEXTMEMOCLIPFORMAT:integer;


constructor TIETextControl.Create(Owner: TComponent);
begin
	inherited;
   fWriteFormattedString:=false;
   fFormattedString:='';
   fLineSpace:=0;
   fFixedHeight:=0;
   fAutoSize:=false;
   fFontLocked:=false;
   fDefaultFont:=TFont.Create;
   fDefaultFontBrush:=TBrush.Create;
   fBorderPen:=TPen.Create;
   fBrush:=TBrush.Create;
   ControlStyle := ControlStyle + [csOpaque];
   fText:=nil;
   fBackbuf:=TBitmap.Create;
   fBackbuf.PixelFormat:=pf24bit;
   fcache_h:=nil;
   fcache_w:=nil;
   fcache_InternalLeading:=nil;
   fCaretX:=0;
   fCaretY:=0;
   fCaretH:=0;
   fTextLength:=0;
   fCharInfo:=nil;
   fCharRef:=nil;
   fposxarray:=nil;
	fposyarray:=nil;
   fInsMode:=true;
   fDefaultAlign:=iejLeft;
   fZoom:=1;
   Cursor:=crIBeam;
   fSelStart:=0;
   fSelStop:=0;
   fMouseDownX:=0;
   fMouseDownY:=0;
   fForceDefaultColors:=false;
   getmem(fInsertingCharInfo,sizeof(TIECharInfo));
end;

destructor TIETextControl.Destroy;
begin
	freemem(fInsertingCharInfo);
	freemem(fcache_h);
   freemem(fcache_w);
   freemem(fcache_internalLeading);
   freemem(fCharRef);
   freemem(fposxarray);
   freemem(fposyarray);
	fBackbuf.free;
   if fCharInfo<>nil then
      while fCharInfo.count>0 do begin
         freemem(fCharInfo[0]);
         fCharInfo.Delete(0);
      end;
   fCharInfo.Free;
   fDefaultFont.free;
   fDefaultFontBrush.free;
   fBrush.Free;
   fBorderPen.Free;
	inherited;
end;

procedure TIETextControl.RemoveUnreferenced;
var
	ref:pintegerarray;	//1=referenced 0=unref
   i,j:integer;
   ci:PIECharInfo;
begin
	getmem(ref,sizeof(integer)*fCharInfo.Count);
   i:=0;
   while i<fCharInfo.Count do begin
		ci:=PIECharInfo(fCharInfo[i]);
      if ci^.refcount=0 then begin
         for j:=0 to fTextLength-1 do
         	if fCharRef[j]>i then
            	dec(fCharRef[j]);
         freemem(ci);
         fCharInfo.Delete(i);
      end else
      	inc(i);
   end;
   freemem(ref);
end;

procedure TIETextControl.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);
   with Params do
	   WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TIETextControl.WMSize(var Message: TWMSize);
begin
  	inherited;
   Update;
end;

procedure TIETextControl.WMEraseBkgnd(var Message:TMessage);
begin
	Message.Result:=0;
end;

procedure TIETextControl.CMWantSpecialKey(var Msg: TCMWantSpecialKey);
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

function irealloc(old:pointer; oldsize,newsize:integer):pointer;
const
	BLOCKSIZE=256;
var
   ab:integer;	// already allocated blocks
   rb:integer;	// required blocks
begin
   ab:=(oldsize div BLOCKSIZE);
	rb:=(newsize div BLOCKSIZE) +1;
   if (rb>ab) or (oldsize=0) then begin
		reallocmem(old,rb*BLOCKSIZE);
   	result:=old;
   end else
   	result:=old;
end;

// insert at fInsertPos
procedure TIETextControl.AddChar(key:AnsiChar);
var
   ll,ol,xl:integer;
begin
   if fText<>nil then begin
   	ol:=fTextLength+1;	// +1 is the ending Zero
      ll:=ol+1;
      fText:=irealloc(fText,ol,ll);
      move(fText[fInsertPos],fText[fInsertPos+1],ol-fInsertPos);
      fCharRef:=irealloc(fCharRef,ol*sizeof(integer),ll*sizeof(integer));
      move(fCharRef[fInsertPos],fCharRef[fInsertPos+1],(ol-fInsertPos)*sizeof(integer));
   end else begin
   	ol:=0;
      ll:=2;
      getmem(fText,2);
      fText[1]:=#0;
      getmem(fCharRef,2*sizeof(integer));
   end;
   fText[fInsertPos]:=Key;
   SaveCharInfo(fInsertPos,fInsertingCharInfo);
   // resize
   fcache_h:=irealloc(fcache_h,ol,ll);
   fcache_w:=irealloc(fcache_w,ol,ll);
   fcache_InternalLeading:=irealloc(fcache_InternalLeading,ol,ll);
   fposxarray:=irealloc(fposxarray,sizeof(integer)*ol,sizeof(integer)*ll);
   fposyarray:=irealloc(fposyarray,sizeof(integer)*ol,sizeof(integer)*ll);
   // reset all from inserting position
   xl:=ll-fInsertPos;
   ResetCache(fInsertPos,xl);
   //
   inc(fInsertPos);
   inc(fTextLength);
end;

procedure TIETextControl.ResetCache(from,len:integer);
begin
   zeromemory(@fcache_h[from],len);
   zeromemory(@fcache_w[from],len);
   zeromemory(@fcache_InternalLeading[from],len);
   fillchar(fposxarray[from],sizeof(integer)*len,255);	// set to -1
   fillchar(fposyarray[from],sizeof(integer)*len,255);	// set to -1
end;

// delete the idx AnsiChar
// return the modified idx (only if it need to be changed)
function TIETextControl.DelChar(idx:integer):integer;
var
	xl:integer;
begin
	result:=idx;
   if idx>=fTextLength then
   	exit;
   if (idx<fTextLength) then begin
   	with PIECharInfo(fCharInfo[fCharRef[idx]])^ do
	   	if refcount>0 then dec(refcount);
      move(fText[idx+1],fText[idx],fTextLength-idx);
      move(fCharRef[idx+1],fCharRef[idx],(fTextLength-idx)*sizeof(integer));
      dec(fTextLength);
      xl:=fTextLength-idx;
      ResetCache(idx,xl);
      result:=idx;
   end;
end;

procedure TIETextControl.GoBack(var CurPos:PAnsiChar);
begin
	dec(CurPos);
   if integer(CurPos)<integer(fText) then
   	CurPos:=fText;
end;

// return true if CurPos has changed
function TIETextControl.GoBackIdx(var CurPos:integer):boolean;
begin
	result:=CurPos>0;
   if result then
   	dec(CurPos);
end;

procedure TIETextControl.GoForwardIdx(var CurPos:integer);
begin
	if CurPos<fTextLength then
   	inc(CurPos);
end;

procedure TIETextControl.GoWordBackIdx(var CurPos:integer);
begin
	dec(CurPos);
	while (CurPos>0) and (fText[CurPos]<#33) do
   	dec(CurPos);
	while (CurPos>0) and (fText[CurPos]>#32) do
   	dec(CurPos);
   if CurPos<0 then CurPos:=0;
   if (CurPos<fTextLength) and (fText[CurPos]<#33) then inc(CurPos);
   CurPos:= imax(imin(CurPos,fTextLength-1),0);
end;

procedure TIETextControl.GoWordForwardIdx(var CurPos:integer);
begin
	inc(CurPos);
	while (CurPos<fTextLength) and (fText[CurPos]<#33) do
   	inc(CurPos);
	while (CurPos<fTextLength) and (fText[CurPos]>#32) do
   	inc(CurPos);
   CurPos:= imax(imin(CurPos,fTextLength-1),0);
end;

procedure TIETextControl.SStop(PrevPos:integer; Shift:TShiftState);
begin
   if not (ssShift in Shift) then
   	ResetSelection
   else begin
   	if fSelStop=0 then begin
      	// no existing selection
         fSelStart:=PrevPos;
         fSelStop:=fInsertPos;
      end else begin
      	// already exists a selection
         if PrevPos<fInsertPos then begin
         	// going right
            if fInsertPos>fSelStop then
            	fSelStop:=fInsertPos
            else
					fSelStart:=fInsertPos;	// return back
         end else begin
         	// going left
            if fInsertPos<fSelStart then
            	fSelStart:=fInsertPos
            else
            	fSelStop:=fInsertPos;	// return back
         end;
      end;
   end;
   if fSelStart>fSelStop then
   	iswap(fSelStart,fSelStop);
end;

procedure TIETextControl.KeyDown(var Key: Word; Shift: TShiftState);
var
	PrevInsertPos:integer;
   fd:TFontDialog;
   cl:TColorDialog;
begin
	PrevInsertPos:=fInsertPos;
	case Key of
		VK_F2:
	      if (ssShift in Shift) then begin
         	IncFontSize;
            Update;
         end;
      VK_F1:
      	if (ssShift in Shift) then begin
	         DecFontsize;
            Update;
         end;
      VK_LEFT:
      	begin
         	if ssCtrl in Shift then
            	GoWordBackIdx(fInsertPos)
            else
            	GoBackIdx(fInsertPos);
            if fInsertPos<>PrevInsertPos then begin
            	CopyCharInfoTo(fInsertPos-1,fInsertingCharInfo);
	            SStop(PrevInsertPos,Shift);
	            Update;
            end;
         end;
      VK_RIGHT:
      	begin
         	if ssCtrl in Shift then
            	GoWordForwardIdx(fInsertPos)
            else
            	GoForwardIdx(fInsertPos);
            if fInsertPos<>PrevInsertPos then begin
            	CopyCharInfoTo(fInsertPos-1,fInsertingCharInfo);
	            SStop(PrevInsertPos,Shift);
   	         Update;
            end;
         end;
      VK_RETURN:
      	begin
            AddChar(#10);
            Update;
         end;
      VK_DELETE:
      	begin
         	if fSelStop>fSelStart then
            	RemoveSelected
            else
	            fInsertPos:=DelChar(fInsertPos);
            Update;
         end;
      VK_BACK:
      	begin
         	if fSelStop>fSelStart then begin
            	RemoveSelected;
               Update;
            end else begin
               if GoBackIdx(fInsertPos) then begin
                  fInsertPos:=DelChar(fInsertPos);
                  Update;
               end;
            end;
         end;
      VK_UP:
      	begin
	      	MoveUp;
            if fInsertPos<>PrevInsertPos then begin
            	CopyCharInfoTo(fInsertPos-1,fInsertingCharInfo);
	            SStop(PrevInsertPos,Shift);
   	         Update;
            end;
         end;
      VK_DOWN:
      	begin
	      	MoveDown;
            if fInsertPos<>PrevInsertPos then begin
            	CopyCharInfoTo(fInsertPos-1,fInsertingCharInfo);
	            SStop(PrevInsertPos,Shift);
   	         Update;
            end;
         end;
      VK_HOME:
      	begin
         	if ssCtrl in Shift then
            	// go home, (start of document)
               fInsertPos:=0
            else
            	// go home (start of line)
               MoveHome;
            if fInsertPos<>PrevInsertPos then begin
               CopyCharInfoTo(fInsertPos-1,fInsertingCharInfo);
               SStop(PrevInsertPos,Shift);
               Update;
            end;
         end;
      VK_END:
      	begin
         	if ssCtrl in Shift then
            	// go end, (end of document)
               fInsertPos:=fTextLength
            else
            	// go end, (end of line)
               MoveEnd;
            if fInsertPos<>PrevInsertPos then begin
               CopyCharInfoTo(fInsertPos-1,fInsertingCharInfo);
               SStop(PrevInsertPos,Shift);
               Update;
            end;
         end;
      VK_INSERT:
      	fInsMode:=not fInsMode;
      ord('L'):	// Left align
      	if ssCtrl in Shift then begin
         	InsertAlign(iejLeft);
            Update;
         end;
      ord('E'):	// center align
      	if ssCtrl in Shift then begin
         	InsertAlign(iejCenter);
            Update;
         end;
      ord('R'):	// right align
      	if ssCtrl in Shift then begin
         	InsertAlign(iejRight);
            Update;
         end;
      ord('J'):	// justified
      	if ssCtrl in Shift then begin
         	InsertAlign(iejJustify);
            Update;
         end;
      ord('C'):	// copy to clipboard
      	if ssCtrl in Shift then begin
         	CopyToClipboard;
         end;
      ord('X'):	// cut to clipboard
      	if ssCtrl in Shift then begin
         	CopyToClipboard;
            RemoveSelected;
            Update;
         end;
      ord('V'):	// paste from clipboard
      	if ssCtrl in Shift then begin
         	RemoveSelected;
         	PasteFromClipboard;
            Update;
         end;
      ord('F'):	// open font dialog
      	if (not fFontLocked) and (ssCtrl in Shift) then begin
				fd:=TFontDialog.Create(self);
            fd.Font.Name:=fInsertingCharInfo^.name;
            fd.Font.Height:=fInsertingCharInfo^.height;
            fd.Font.Style:=fInsertingCharInfo^.style;
            fd.Font.Color:=fInsertingCharInfo^.color;
            if fd.Execute then
	         	SetXFont(fd.Font);
            fd.free;
            Update;
         end;
      ord('B'):	// bold
      	if ssCtrl in Shift then begin
         	SwitchFontStyle(fsBold);
            Update;
         end;
      ord('I'):	// italic
      	if ssCtrl in Shift then begin
         	SwitchFontStyle(fsItalic);
            Update;
         end;
		ord('U'):	// underline
      	if ssCtrl in Shift then begin
         	SwitchFontStyle(fsUnderline);
            Update;
         end;
      ord('G'):	// select background color
      	if (not fFontLocked) and (ssCtrl in Shift) then begin
				cl:=TColorDialog.Create(self);
            cl.Color:=fInsertingCharInfo^.brushColor;
            if cl.Execute then
            	SetXBackColor(cl.Color);
            cl.free;
            Update;
         end;
   end;
	inherited;
end;

procedure TIETextControl.MoveHome;
begin
	while (fInsertPos>0) and (fposyarray[fInsertPos]>=fCaretY) do
   	dec(fInsertPos);
   if fInsertPos>0 then
	   inc(fInsertPos);
end;

procedure TIETextControl.MoveEnd;
begin
	while (fInsertPos<fTextLength) and (fposyarray[fInsertPos]=fCaretY) do
   	inc(fInsertPos);
   if fInsertPos<fTextLength then
   	dec(fInsertPos);
end;

procedure TIETextControl.MoveUp;
var
	ip:integer;
begin
	// go to at the end of prev line
   ip:=fInsertPos;
   while (ip>0) and (fposyarray[ip]>=fCaretY) do
   	dec(ip);
   if fposyarray[ip]<>fposyarray[fInsertPos] then begin
   	fInsertPos:=ip;
      // go to the requested position
      while (fInsertPos>0) and (fposxarray[fInsertPos]>fCaretX) do
         dec(fInsertPos);
      if (fposyarray[fInsertPos+1]=fposyarray[fInsertPos]) and (abs(fposxarray[fInsertPos+1]-fCaretX)<abs(fposxarray[fInsertPos]-fCaretX)) then
         inc(fInsertPos);	// it is better next position
      if fposyarray[ip]<>fposyarray[fInsertPos] then
      	fInsertPos:=ip;
   end;
end;

procedure TIETextControl.MoveDown;
var
	ip:integer;
begin
	// go to at the start of next line
   ip:=fInsertPos;
   while (ip<fTextLength) and (fposyarray[ip]=fCaretY) do
   	inc(ip);
   if fposyarray[ip]<>fposyarray[fInsertPos] then begin
   	fInsertPos:=ip;
      // go to the requested position
      while (fInsertPos<fTextLength) and (fposxarray[fInsertPos]<fCaretX) do
         inc(fInsertPos);
      if (fInsertPos>0) and (fposyarray[fInsertPos-1]=fposyarray[fInsertPos]) and (abs(fposxarray[fInsertPos-1]-fCaretX)<abs(fposxarray[fInsertPos]-fCaretX)) then
         dec(fInsertPos);	// it is better prev position
      if fposyarray[ip]<>fposyarray[fInsertPos] then
      	fInsertPos:=ip;
   end;
   CopyCharInfoTo(fInsertPos-1,fInsertingCharInfo);
end;

// x,y client area coordinates
procedure TIETextControl.MoveTo(x,y:integer);
begin
	fInsertPos:=0;
   while (fInsertPos<fTextLength) and (fposyarray[fInsertPos]<y) do
      inc(fInsertPos);
   if fposyarray[fInsertPos]>=y then
	   dec(fInsertPos);
   while (fInsertPos>=0) and (fposxarray[fInsertPos]-1>x) do
   	dec(fInsertPos);
   if fInsertPos<0 then fInsertPos:=0;
end;

procedure TIETextControl.KeyUp(var Key: Word; Shift: TShiftState);
begin
	inherited;
end;

procedure TIETextControl.KeyPress(var Key: Char);
begin
	if (Key>#31) and (key<>#127) then begin
   	RemoveSelected;
   	if fInsMode then
			AddChar(AnsiChar(Key))
      else begin
      	fInsertPos:=DelChar(fInsertPos);
         AddChar(AnsiChar(Key));
		end;
   end;
   Paint;
end;

procedure TIETextControl.ClearBitmap;
begin
	fBackbuf.Canvas.Brush.Style:=bsSolid;
   fBackbuf.Canvas.Brush.Color:=fBrush.Color;
   fBackbuf.Canvas.FillRect(rect(0,0,fBackbuf.Width,fBackbuf.Height));
end;

procedure TIETextControl.Paint;
begin
   if Visible then begin
 		DestroyCaret;
   	if (fBackbuf.Width<>ClientWidth) or (fBackbuf.Height<>ClientHeight) then begin
      	fBackbuf.Width:=ClientWidth;
      	fBackbuf.Height:=ClientHeight;
         ClearBitmap;
      end;
      PaintTo(fBackbuf.Canvas,0,0,trunc(ClientWidth/fZoom),trunc(ClientHeight/fZoom));
      Canvas.Draw(0,0,fBackbuf);
      //
      CreateCaret(handle,0,0,fCaretH);
      SetCaretPos(fCaretX,fCaretY);
      ShowCaret(handle);
   end;
end;

procedure TIETextControl.Init;
var
	ci:PIECharInfo;
begin
   fSelStart:=0;
   fSelStop:=0;
	fInsertPos:=0;
   if fText<>nil then
	   fTextLength:=strlen(fText)
   else
   	fTextLength:=0;
   if fCharRef=nil then begin
   	getmem(fCharRef,fTextLength*sizeof(integer));
      fillchar(fCharRef^,sizeof(integer)*fTextLength,0);	// all points to first item of fCharInfo
   end;
   if fCharInfo=nil then begin
   	fCharInfo:=TList.Create;
      if fTextLength>0 then begin
      	getmem(ci,sizeof(TIECharInfo));
         ci^.refcount:=fTextLength;
         ci^.name:=fDefaultFont.Name;
         ci^.height:=fDefaultFont.Height;
         ci^.style:=fDefaultFont.Style;
         ci^.color:=fDefaultFont.Color;
         ci^.brushColor:=fDefaultFontBrush.Color;
         ci^.brushStyle:=fDefaultFontBrush.Style;
         ci^.align:=fDefaultAlign;
      	fCharInfo.Add(ci);
      end;
   end;
	if fcache_h<>nil then freemem(fcache_h);
   if fcache_w<>nil then freemem(fcache_w);
   if fcache_internalLeading<>nil then freemem(fcache_internalLeading);
   if fposxarray<>nil then freemem(fposxarray);
   if fposyarray<>nil then freemem(fposyarray);
   fcache_h:=allocmem(fTextLength+1);
   fcache_w:=allocmem(fTextLength+1);
   fcache_InternalLeading:=allocmem(fTextLength+1);
   getmem(fposxarray,sizeof(integer)*(fTextLength+1));
   fillchar(fposxarray^,sizeof(integer)*(fTextLength+1),255);	// set to -1
   getmem(fposyarray,sizeof(integer)*(fTextLength+1));
   fillchar(fposyarray^,sizeof(integer)*(fTextLength+1),255);	// set to -1
   fInsertingCharInfo^.name:=fDefaultFont.Name;
	fInsertingCharInfo^.height:=fDefaultFont.Height;
	fInsertingCharInfo^.style:=fDefaultFont.Style;
   fInsertingCharInfo^.color:=fDefaultFont.Color;
   fInsertingCharInfo^.brushColor:=fDefaultFontBrush.Color;
   fInsertingCharInfo^.brushStyle:=fDefaultFontBrush.Style;
   fInsertingCharInfo^.align:=fDefaultAlign;
   ClearBitmap;
end;

procedure TIETextControl.Update;
begin
	invalidate;
end;

procedure TIETextControl.WMKillFocus(var Msg: TWMKillFocus);
begin
	inherited;
   HideCaret(handle);
   DestroyCaret;
end;

procedure TIETextControl.WMSetFocus(var Msg: TWMSetFocus);
begin
	inherited;
end;

function TIETextControl.FindCharInfo(info:PIECharInfo):integer;
begin
	for result:=0 to fCharInfo.Count-1 do
   	if comparemem(@pbytearray(fCharInfo[result])[sizeof(integer)],@pbytearray(info)[sizeof(integer)],sizeof(TIECharInfo)-sizeof(integer)) then begin	// [sizeof(integer)] to bypass reference count
      	exit;
      end;
   result:=-1;
end;

procedure TIETextControl.SaveCharInfo(idx:integer; charinf:PIECharInfo);
var
	i:integer;
   ci:PIECharInfo;
begin
   i:=FindCharInfo(charinf);
   if i<0 then begin
   	// not saved, save now
      getmem(ci,sizeof(TIECharInfo));
      move(charinf^,ci^,sizeof(TIECharInfo));
      ci^.refcount:=0;
      i:=fCharInfo.Add(ci)
   end;
   fCharRef[idx]:=i;
   inc( PIECharInfo(fCharInfo[fCharRef[idx]])^.refcount );
end;

procedure TIETextControl.CopyCharInfoTo(source:integer; charinf:PIECharInfo);
begin
	source:=imin(imax(0,source),fTextLength-1);
	move( PIECharInfo(fCharInfo[fCharRef[source]])^, charinf^, sizeof(TIECharInfo) );
end;

procedure TIETextControl.RestoreCharInfo(idx:integer; XCanvas:TCanvas);
begin
	if not fFontLocked then begin
      with PIECharInfo(fCharInfo[fCharRef[idx]])^ do begin
         if XCanvas.Font.Name<>name then XCanvas.Font.Name:=name;
         if XCanvas.Font.Height<>height then XCanvas.Font.Height:=height;
         if XCanvas.Font.Style<>style then XCanvas.Font.Style:=style;
         if (XCanvas.Font.Color<>color) and (not fForceDefaultColors) then XCanvas.Font.Color:=color;
         if (XCanvas.Brush.Color<>brushColor) and (not fForceDefaultColors) then XCanvas.Brush.Color:=brushColor;
         if XCanvas.Brush.Style<>brushStyle then XCanvas.Brush.Style:=brushStyle;
      end;
   end else begin
         if XCanvas.Font.Name<>fDefaultFont.Name then XCanvas.Font.Name:=fDefaultFont.Name;
         if XCanvas.Font.Height<>fDefaultFont.height then XCanvas.Font.Height:=fDefaultFont.height;
         if XCanvas.Font.Style<>fDefaultFont.style then XCanvas.Font.Style:=fDefaultFont.style;
         if (XCanvas.Font.Color<>color) and (not fForceDefaultColors) then XCanvas.Font.Color:=fDefaultFont.Color;
         if (XCanvas.Brush.Color<>fDefaultFontBrush.Color) and (not fForceDefaultColors) then XCanvas.Brush.Color:=fDefaultFontBrush.Color;
         if XCanvas.Brush.Style<>fDefaultFontBrush.Style then XCanvas.Brush.Style:=fDefaultFontBrush.Style;
   end;
end;

// fText is simple ASCII test, except for following special tags:
//   #10 : carriage return and new line
//   #0 : end of stream
procedure TIETextControl.PaintTo(DestCanvas:TCanvas; DestX,DestY,NonZoomDestWidth,NonZoomDestHeight:integer);
type
	TDiff=record
   	x,y:integer;
      c:AnsiChar;
      idx:integer;
   end;
   PDiff=^TDiff;
var
   c:PAnsiChar;
   printed,enters,fetched,x,y,xx:integer;
   firstpos:integer;
   i,j,il,idx:integer;
   fetch:boolean; // false=draw directly, true=fetching the row
   fetchpos:PAnsiChar;
   maxh,maxi,h,w:integer;
   posx,posy,rposx,prevend:integer;
   lasth,lasti:integer;
   tm:TTEXTMETRIC;
   PixelMult:double;
   oldta:integer;
   fStopAt:PAnsiChar;
   ofx,ofy:integer;
   diffbuf,diff,nextdiff:PDiff;
   difflen:integer;
   //
   // set also PixelMult
   function CalcJust(lastpos:integer):integer;
   var
   	d:integer;
      just:TIEAlignment;
   begin
      PixelMult:=1;
      result:=0;
      d:=imax(0,lastpos-1);
      if d<fTextLength then
	      just:=PIECharInfo(fCharInfo[fCharRef[ d ]])^.align
      else
      	just:=fInsertingCharInfo^.align;
      if fFontLocked then
      	just:=fDefaultAlign;
      if just<>iejLeft then begin
         dec(lastpos);
         if fText[lastpos]=#0 then dec(lastpos);
         if fText[lastpos]=#10 then dec(lastpos);
         if fText[lastpos]=#32 then dec(lastpos);
         if lastpos=-1 then lastpos:=0;
         result:=0;
         if lastpos>=0 then
         	case Just of
            	iejCenter: result:=(NonZoomDestWidth-fposxarray[lastpos]-fcache_w[lastpos]) div 2;
            	iejRight: result:=NonZoomDestWidth-fposxarray[lastpos]-fcache_w[lastpos]-1;	// -1 for the cursor
            	iejJustify:
               	begin
                  	if (fText[lastpos+1]<>#0) and ((lastpos+2<fTextLength) or (fText[lastpos+2]<>#0)) and (fText[lastpos+1]<>#10) then begin
                     	d:=fposxarray[lastpos]+fcache_w[lastpos]+1;
                        if d<>0 then
		                  	PixelMult:=NonZoomDestWidth/d
                        else
                        	PixelMult:=1;
                     end;
                  end;
            end;
      end;
   end;
   // new line (new paragraph)
   procedure DoNewLine;
   begin
      if fetch then begin
         // now write
         fetch:=false;
         posx:=CalcJust(idx);
         rposx:=posx;
         prevend:=0;
         c:=fetchpos;   // backtrack
      end else begin
         // continue to next row
         if fWriteFormattedString then
            fFormattedString:=fFormattedString+#10;
         inc(posy,maxh+fLineSpace);
         fetchpos:=c;
         fetch:=true;
         maxh:=lasth;
         maxi:=lasti;
         fStopAt:=nil;
         posx:=0;
         rposx:=posx;
         prevend:=0;
         PixelMult:=1;
      end;
   end;
   // new line because the line is too much large - only fetching
   procedure LineLarge;
   var
   	cc,o:PAnsiChar;
   begin
      // go back to the last #32
      cc:=c;
      while (integer(cc)>integer(fetchpos)) and (cc^<>#32) do begin
      	o:=cc;
         GoBack(cc);
         if cc=o then break;	// not moved, exit
      end;
      if integer(cc)<=integer(fetchpos) then
      	cc:=c;
      if (cc^=#32) then
	      inc(cc);	// bypass the #32
      fStopAt:=cc;
      // now write
      fetch:=false;
      c:=fetchpos;   // backtrack
     	posx:=CalcJust(integer(fStopAt)-integer(fText));
      rposx:=posx;
      prevend:=0;
   end;
   procedure CalcSizes;
   var
   	cc:AnsiChar;
   begin
   	if (c^<#31) or (c^=#127) then
      	cc:=#32
      else
      	cc:=c^;
      RestoreCharInfo(idx,DestCanvas); // load only if the font changes
      if fcache_w[idx]=0 then
         fcache_w[idx]:=DestCanvas.TextWidth(cc);
      w:=fcache_w[idx];
      if fcache_h[idx]=0 then begin
         if fFixedHeight=0 then begin
         	GetTextMetrics(DestCanvas.Handle,tm);
            fcache_h[idx]:=tm.tmHeight;
            fcache_InternalLeading[idx]:=abs(tm.tmInternalLeading);
         end else begin
            fcache_h[idx]:=fFixedHeight;
            fcache_InternalLeading[idx]:=0;
			end;
      end;
      h:=fcache_h[idx];
      il:=fcache_internalLeading[idx];
      if fetch then begin
         // only calc the max height
         lasth:=h;
         lasti:=il;
         if h>maxh then
            maxh:=h;
         if il>maxi then
            maxi:=il;
      end;
   end;
   //
begin
	if (NonZoomDestWidth<=1) or (NonZoomDestHeight<=1) then exit;
   fFormattedString:='';
	printed:=0;
   enters:=0;
   fetched:=0;
   firstpos:=-1;
   PixelMult:=1;
   fStopAt:=nil;
   difflen:=0;
   if fZoom<>1 then begin
   	getmem(diffbuf,fTextLength*10*sizeof(TDiff));
      diff:=diffbuf;
   end else begin
      diffbuf:=nil;
      diff:=nil;
   end;
   //
   DestCanvas.Pen.Width:=1;
   DestCanvas.Font.Color:=DefaultFont.Color;
   DestCanvas.Pen.Color:=DefaultFont.Color;
   DestCanvas.Pen.Style:=fBorderPen.Style;
   DestCanvas.Pen.Color:=fBorderPen.Color;
   DestCanvas.Pen.Mode:=pmCopy;
   DestCanvas.Brush.Color:=fBrush.Color;
   DestCanvas.Brush.Style:=fBrush.Style;
   DestCanvas.Rectangle(DestX,DestY,DestX+round(NonZoomDestWidth*fZoom),DestY+round(NonZoomDestHeight*fZoom));
   DestCanvas.Pen.Style:=psSolid;
   //
   ofx:=1;
   ofy:=1;
	dec(NonZoomDestWidth,2);
   dec(NonZoomDestHeight,2);
   // draw text
   oldta:=SetTextAlign(DestCanvas.Handle,TA_BASELINE);
   c:=fText;
   if c<>nil then begin
      fetch:=true;
      fetchpos:=c;
      maxh:=0;
      maxi:=0;
      posy:=0;
      posx:=0;
      rposx:=0;
      prevend:=0;
      lasth:=0;
      lasti:=0;
      repeat
      	idx:=integer(c)-integer(fText);
         fposxarray[idx]:=ofx+rposx;
         fposyarray[idx]:=ofy+posy;
         case c^ of
            #0:   // end of stream
               begin
                  if (not fetch) then
                     break;   // exit loop
                  DoNewLine;
                  fStopAt:=nil;
               end;
            #10:  // new line
            	begin
               	if firstpos=-1 then firstpos:=idx;
                 	CalcSizes;	// we need at least a size
               	inc(c);
               	if (fInsertPos=firstpos) and (idx=firstpos) then begin
                  	fCaretX:=ofx+0;
                     fCaretY:=ofy+0;
                     fCaretH:=maxh;
                  end;
                  if idx<fInsertPos then begin
                  	fCaretX:=ofx+0;
                     fCaretY:=ofy+posy+maxh;
                     fCaretH:=maxh;
                  end;
                  if (not fetch) then
                  	inc(enters);
                  if (not fetch) and (c^=#0) then
                  	break;	// exit loop
	              	DoNewLine;
               end;
            else begin
	            // printable character
               if firstpos=-1 then firstpos:=idx;
               if fetch then
               	inc(fetched);
               if (not fetch) and (c=fStopAt) then begin
               	DoNewLine;
                  continue;
               end;
               CalcSizes;	// set also w with the AnsiChar width
               if fetch and (rposx+w+2>=NonZoomDestWidth) then begin
                  LineLarge;	// new line because the line is too much large
                  if fStopAt=c then break;
                  continue;
               end;
               if (not fetch) then begin
                  // print the character
                  x:=DestX+ofx+rposx;
                  y:=DestY+ofy+(posy+maxh-maxi);
                  if y<DestY+ofy+NonZoomDestHeight then begin
                     if (idx>=fSelStart) and (idx<fSelStop) then begin
                     	// selected
                        DestCanvas.Brush.Color:=$00FFFFFF and (not DestCanvas.Brush.Color);
                        DestCanvas.Font.Color:=$00FFFFFF and (not DestCanvas.Font.Color);
                        DestCanvas.Brush.Style:=bsSolid;
                     end;
                     if posx<>rposx then begin
                     	// full justify, draw intra-spaces
                     	while prevend<rposx do begin
                        	xx:=DestX+ofx+prevend;
                        	if diff<>nil then begin
                           	diff^.x:=xx;
                              diff^.y:=y;
                              diff^.c:=' ';
                              diff^.idx:=idx;
                              inc(difflen);
                              inc(diff);
                           end else
                              DestCanvas.TextOut(xx,y,' ');
                           inc(prevend);
                        end;
                     end;
                     if diff<>nil then begin
                     	diff^.x:=x;
                        diff^.y:=y;
                        diff^.c:=c^;
                        diff^.idx:=idx;
                        inc(diff);
                        inc(difflen);
                     end else begin
		                  DestCanvas.TextOut(x,y,c^);
                     end;
                     if fWriteFormattedString then
                     	fFormattedString:=fFormattedString+c^;
                  end else begin
                  	if fAutoSize and Visible then begin
                     	// only in edit mode
								Height:=Height+h;
                     	if diffbuf<>nil then
                        	freemem(diffbuf);
                     	exit;
                     end;
                  end;
                  inc(printed);
                  if idx=fInsertPos then begin
                  	fCaretX:=ofx+rposx;
                     fCaretY:=ofy+posy;
                     fCaretH:=maxh;
                  end else if idx<fInsertPos then begin
                  	fCaretX:=ofx+rposx+w;
                     fCaretY:=ofy+posy;
                     fCaretH:=maxh;
						end;
               end;
               inc(posx,w);
               prevend:=rposx+w;
               rposx:=trunc(posx*PixelMult);
               inc(c);
            end;
         end;
      until False;
   end;
   if (printed+fetched+enters=0) then begin
   	fCaretX:=ofx+0;
      fCaretH:=DestCanvas.Font.Height;
      fCaretY:=ofy+0;
   end;
	//
   if fZoom<>1 then begin
   	// differited painting
   	diff:=diffbuf;
   	for i:=0 to difflen-1 do begin
			RestoreCharInfo(diff^.idx,DestCanvas);
         DestCanvas.Font.Height:=trunc(DestCanvas.Font.Height*fZoom);
         x:=trunc((diff^.x-DestX)*fZoom);
         y:=trunc((diff^.y-DestY)*fZoom);
         if (diff^.idx>=fSelStart) and (diff^.idx<fSelStop) then begin
         	// selected
            DestCanvas.Brush.Color:=$00FFFFFF and (not DestCanvas.Brush.Color);
            DestCanvas.Font.Color:=$00FFFFFF and (not DestCanvas.Font.Color);
            DestCanvas.Brush.Style:=bsSolid;
         end;
			//
         if i<difflen-1 then begin
            nextdiff:=diff; inc(nextdiff);
	         if nextdiff^.y=diff^.y then
   	         for j:=DestX+x to DestX+trunc((nextdiff^.x-DestX)*fZoom) do
      	         DestCanvas.TextOut(j,DestY+y,' ');
         end;
			//
         DestCanvas.TextOut(DestX+x,DestY+y,diff^.c);
         inc(diff);
      end;
   	freemem(diffbuf);
      for i:=0 to fTextLength-1 do begin
         fposxarray[i]:=trunc(fposxarray[i]*fZoom);
         fposyarray[i]:=trunc(fposyarray[i]*fZoom);
		end;
      fCaretX:=trunc(fCaretX*fZoom);
      fCaretY:=trunc(fCaretY*fZoom);
      fCaretH:=trunc(fCaretH*fZoom);
   end;
   if fAutoSize and (fCaretY+fCaretH>NonZoomDestHeight) and Visible then begin
      // only in edit mode
      Height:=Height+fCaretH;
   end;
	//
   fposxarray[fInsertPos]:=fCaretX;
   fposyarray[fInsertPos]:=fCaretY;
   SetTextAlign(DestCanvas.Handle,oldta);
end;

procedure TIETextControl.WMLButtonDblClk(var Message: TWMLButtonDblClk);
var
	i:integer;
begin
	inherited;
   if fTextLength=0 then exit;
   // select word
   ResetSelection;
	// search first letter (we suppose MouseDown has already set the correct cursor position)
   GoWordBackIdx(fInsertPos);
   i:=fInsertPos;
   // search last letter
	GoWordForwardIdx(fInsertPos);
   // return back until a AnsiChar is found
   while (fInsertPos>0) and (fText[fInsertPos]<#33) do
   	dec(fInsertPos);
   inc(fInsertPos);
   // select
   CopyCharInfoTo(fInsertPos-1,fInsertingCharInfo);
   SStop(i,[ssShift]);
   Update;
end;

procedure TIETextControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	PrevInsertPos:integer;
begin
	inherited;
   if ssShift in Shift then begin
   	// select from last position
   	MoveTo(fMouseDownX,fMouseDownY);
   	PrevInsertPos:=fInsertPos;
      MoveTo(x,y);
      if fInsertPos<>PrevInsertPos then begin
         SStop(PrevInsertPos,[ssShift]);
         Update;
      end;
      fMouseDownX:=X;
      fMouseDownY:=Y;
   end else begin
      fMouseDownX:=X;
      fMouseDownY:=Y;
	   ResetSelection;
		MoveTo(x,y);
   end;
   Update;
end;

procedure TIETextControl.MouseMove(Shift: TShiftState; X, Y: Integer);
var
	PrevInsertPos:integer;
begin
	inherited;
	if MouseCapture then begin
   	ResetSelection;
   	MoveTo(fMouseDownX,fMouseDownY);
   	PrevInsertPos:=fInsertPos;
      MoveTo(x,y);
      if fInsertPos<>PrevInsertPos then begin
         SStop(PrevInsertPos,[ssShift]);
         Update;
      end;
	end;
end;

procedure TIETextControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	inherited;
end;

procedure TIETextControl.ResetSelection;
begin
	fSelStart:=0;
   fSelStop:=0;
end;

procedure TIETextControl.RemoveSelected;
begin
	if fSelStop>fSelStart then begin
      dec(fSelStop);
      while fSelStop>=fSelStart do begin
         DelChar(fSelStop);
         dec(fSelStop);
      end;
      fInsertPos:=fSelStart;
      ResetSelection;
   end;
end;

procedure TIETextControl.CopyToClipboard;
var
	ht:THandle;
   i,j,l:integer;
   ascii,cust:PAnsiChar;
begin
	l:=fSelStop-fSelStart;
	if l>0 then begin
      if OpenClipboard(0) then begin
         EmptyClipboard;
         // ascii text
         ht:=GlobalAlloc(GMEM_MOVEABLE or GMEM_DDESHARE,l*2);
         ascii:=GlobalLock(ht);
         i:=fSelStart;
         j:=0;
         while i<fSelStop do begin
            ascii[j]:=fText[i];
            if ascii[j]=#10 then begin
               ascii[j]:=#13;
               ascii[j+1]:=#10;
               inc(j);
            end;
            inc(j);
            inc(i);
         end;
      	ascii[j]:=#0;
         GlobalUnlock(ht);
         SetClipboardData(CF_TEXT,ht);
         // custom text
         ht:=GlobalAlloc(GMEM_MOVEABLE or GMEM_DDESHARE,l+1+l*sizeof(TIECharInfo));
         cust:=GlobalLock(ht);
         move(fText[fSelStart],cust[0],l);
         cust[l]:=#0;
         for i:=fSelStart to fSelStop-1 do
         	move( PIECharInfo(fCharInfo[fCharRef[i]])^, cust[l+1+(i-fSelStart)*sizeof(TIECharInfo)], sizeof(TIECharInfo) );
         GlobalUnlock(ht);
         SetClipboardData(IETEXTMEMOCLIPFORMAT,ht);
         //
         CloseClipboard;
      end;
   end;
end;

procedure TIETextControl.PasteFromClipboard;
var
	hmem:THandle;
   ptr:PAnsiChar;
   i,l:integer;
begin
   if OpenClipboard(0) then begin
   	if IsClipboardFormatAvailable(IETEXTMEMOCLIPFORMAT) then begin
      	// custom text
			hmem:=GetClipboardData(IETEXTMEMOCLIPFORMAT);
         if hmem<>0 then begin
         	ptr:=GlobalLock(hmem);
            l:=strlen(ptr);
            i:=0;
				while ptr[i]<>#0 do begin
					move( ptr[l+1+i*sizeof(TIECharInfo)], fInsertingCharInfo^, sizeof(TIECharInfo) );
            	AddChar(ptr[i]);
               inc(i);
            end;
            GlobalUnlock(hmem);
         end;
      end else if IsClipboardFormatAvailable(CF_TEXT) then begin
      	// ascii text
			hmem:=GetClipboardData(CF_TEXT);
         if hmem<>0 then begin
         	ptr:=GlobalLock(hmem);
				while ptr^<>#0 do begin
            	if ptr^<>#13 then
	            	AddChar(ptr^);
               inc(ptr);
            end;
            GlobalUnlock(hmem);
         end;
      end;
      CloseClipboard;
   end;
end;

procedure IncFont(ci:PIECharInfo);
begin
   if ci^.height<0 then
      dec(ci^.height)
   else
      inc(ci^.height);
   if ci^.height=0 then ci^.height:=1;
end;

procedure DecFont(ci:PIECharInfo);
begin
	if ci^.height<0 then
		inc(ci^.height)
   else
   	dec(ci^.height);
   if ci^.height=0 then ci^.height:=1;
end;

procedure TIETextControl.IncFontSize;
var
	i:integer;
   ci:TIECharInfo;
begin
	if fSelStop>fSelStart then begin
   	// apply to selection
		for i:=fSelStart to fSelStop-1 do begin
      	move(fCharInfo[ fCharRef[i] ]^, ci, sizeof(TIECharInfo));
      	IncFont( @ci );
         SaveCharInfo(i,@ci);
      end;
      ResetCache(fSelStart,fTextLength-fSelStart);
   end;
   IncFont(fInsertingCharInfo);
end;

procedure TIETextControl.DecFontSize;
var
	i:integer;
   ci:TIECharInfo;
begin
	if fSelStop>fSelStart then begin
   	// apply to selection
		for i:=fSelStart to fSelStop-1 do begin
      	move(fCharInfo[ fCharRef[i] ]^, ci, sizeof(TIECharInfo));
      	DecFont( @ci );
         SaveCharInfo(i,@ci);
      end;
      ResetCache(fSelStart,fTextLength-fSelStart);
   end;
   DecFont(fInsertingCharInfo);
end;

procedure TIETextControl.InsertAlign(Align:TIEAlignment);
var
	i:integer;
   ci:TIECharInfo;
begin
	// search for start of line
	i:=fInsertPos-1;
   while (i>0) and (fText[i]<>#10) do
   	dec(i);
   if i<0 then
   	i:=0;
   if (i<fTextLength) and (fText[i]=#10) then
   	inc(i);
	// set align until end of line
   while (i<fTextLength) and (fText[i]<>#10) do begin
   	CopyCharInfoTo(i,@ci);
      ci.align:=Align;
      SaveCharInfo(i,@ci);
      inc(i);
   end;
   fInsertingCharInfo^.align:=Align;
end;

procedure setfnt(ci:PIECharInfo; fnt:TFont);
begin
   ci^.name:=fnt.Name;
	ci^.height:=fnt.Height;
   ci^.style:=fnt.Style;
   ci^.color:=fnt.Color;
end;

procedure TIETextControl.SetXFont(fnt:TFont);
var
	i:integer;
   ci:TIECharInfo;
begin
	if fSelStop>fSelStart then begin
   	// apply to selection
		for i:=fSelStart to fSelStop-1 do begin
      	move(fCharInfo[ fCharRef[i] ]^, ci, sizeof(TIECharInfo));
         setfnt(@ci,fnt);
         SaveCharInfo(i,@ci);
      end;
      ResetCache(fSelStart,fTextLength-fSelStart);
   end;
   setfnt(fInsertingCharInfo,fnt);
end;

procedure TIETextControl.SetXBackColor(bk:TColor);
var
	i:integer;
   ci:TIECharInfo;
begin
	if fSelStop>fSelStart then begin
   	// apply to selection
		for i:=fSelStart to fSelStop-1 do begin
      	move(fCharInfo[ fCharRef[i] ]^, ci, sizeof(TIECharInfo));
         ci.brushColor:=bk;
         SaveCharInfo(i,@ci);
      end;
      ResetCache(fSelStart,fTextLength-fSelStart);
   end;
   fInsertingCharInfo^.brushColor:=bk;
end;

procedure TIETextControl.SwitchFontStyle(sty:TFontStyle);
var
	i:integer;
   ci:TIECharInfo;
   ss:TFontStyles;
begin
	if fSelStop>fSelStart then begin
   	// apply to selection
      ss:=PIECharInfo(fCharInfo[ fCharRef[fSelStart] ])^.style;	// get the first AnsiChar style, and use only it
      if sty in ss then
      	ss:=ss-[sty]
      else
      	ss:=ss+[sty];
		for i:=fSelStart to fSelStop-1 do begin
      	move(fCharInfo[ fCharRef[i] ]^, ci, sizeof(TIECharInfo));
			ci.style:=ss;
         SaveCharInfo(i,@ci);
      end;
      ResetCache(fSelStart,fTextLength-fSelStart);
   end else begin
   	if sty in fInsertingCharInfo^.style then
			fInsertingCharInfo^.style:=fInsertingCharInfo^.style-[sty]
      else
			fInsertingCharInfo^.style:=fInsertingCharInfo^.style+[sty];
   end;
end;

procedure TIETextControl.WMCut(var Message: TMessage);
var
	key:word;
begin
	key:=ord('X');
	KeyDown(key,[ssCtrl]);
end;

procedure TIETextControl.WMCopy(var Message: TMessage);
var
	key:word;
begin
	key:=ord('C');
	KeyDown(key,[ssCtrl]);
end;

procedure TIETextControl.WMPaste(var Message: TMessage);
var
	key:word;
begin
	key:=ord('V');
	KeyDown(key,[ssCtrl]);
end;

procedure TIETextControl.SetFontLocked(value:boolean);
begin
	fFontLocked:=value;
   Update;
end;


initialization
	begin
	   IETEXTMEMOCLIPFORMAT:=RegisterClipboardFormatA(PAnsiChar(@IETEXTMEMOCLIPFORMAT_NAME));
   end;

{$else}
interface
implementation
{$endif}

end.
