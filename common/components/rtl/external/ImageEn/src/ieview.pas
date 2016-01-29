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

unit ieview;

{$R-}
{$Q-}
{$HINTS OFF}


{$I ie.inc}


interface


(*$ifdef IEKYLIX*)
uses SysUtils, Types, Classes, Qt,QGraphics,QControls,QForms,iekdef,hyieutils,QStdCtrls;
(*$endif*)
(*$ifdef IEDELPHI*)
uses Windows,
     Messages,
     controls,
     forms,
     classes,
     graphics,
     hyieutils
     {$IfDef ImageEnNeedOvc}
     ,
     l3Types,
     l3InternalInterfaces,
     OvcBase,
     OvcCmd,
     OvcConst
     {$EndIf ImageEnNeedOvc}
     ;
(*$endif*)

type

   // called to notify that Bitmap has changed
   TIEBitmapChangeEvent=procedure(Sender:TObject; destroying:boolean) of object;
   PIEBitmapChangeEvent=^TIEBitmapChangeEvent;

   // Base class for TImageEnView and TImageEnMView
   {$IfDef ImageEnNeedOvc}
   TIEView = class(TCustomControl, Il3CommandTarget)
   {$Else ImageEnNeedOvc}
   TIEView = class(TCustomControl)
   {$EndIf ImageEnNeedOvc}
 		private
         FBorderStyle: TBorderStyle;
		   fBmpChange:TList;	// methods list to call when Bitmap changes
         fOnMouseEnter:TNotifyEvent;
         fOnMouseLeave:TNotifyEvent;
         {$ifdef IEKYLIX}
         //FCanvas: TCanvas;
         fHorzScrollBar:TScrollBar;
         fVertScrollBar:TScrollBar;
         {$endif}
	      procedure SetBorderStyle(Value: TBorderStyle);
         (*$ifdef IEDELPHI*)
         function GetCtl3D:boolean;
         procedure SetCtl3D(v:boolean);
         (*$endif*)
		protected
			fBackGround:TColor;
         fDPIX,fDPIY:integer;	// horizontal and vertical dpi
         procedure SetBackGround(cl:TColor); virtual;
         function GetFBitmap:TBitmap; virtual;
         function GetIEBitmap:TIEBitmap; virtual;
         (*$ifdef IEDELPHI*)
         procedure CreateParams(var Params: TCreateParams); override;
         procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    		procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
         (*$endif*)
         function GetAlphaChannel:TIEBitmap; virtual; abstract;
         function GetHasAlphaChannel:boolean; virtual; abstract;
			{$ifdef IEKYLIX}
         function WidgetFlags: Integer; override;
         function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;
		 	procedure OnVertScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer); virtual; abstract;
			procedure OnHorizScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer); virtual; abstract;
			{$endif}

     {$IfDef ImageEnNeedOvc}
     procedure WMSysKeyDown(var Message: TWMSysKeyDown);
       message WM_SYSKEYDOWN;
     procedure CNKeyDown(var Msg: TWMKeyDown); message CN_KEYDOWN;
     function  ProcessCommand(Cmd    : Tl3OperationCode;
                              aForce : Boolean;
                              aCount : Integer): Boolean;
     function CheckStamp(const aGUID: TGUID): Boolean;
     {$EndIf ImageEnNeedOvc}
		public
         {$ifdef OCXVERSION}
         ReplyMessageTo:HWND;
         {$endif}
         procedure RemoveAlphaChannel(Merge:boolean); virtual; abstract;
         procedure LockPaint; virtual; abstract;
         function UnLockPaint:integer; virtual; abstract;
         function NPUnLockPaint:integer; virtual; abstract;
         procedure SetDPIX(dpiX:integer); virtual;
         procedure SetDPIY(dpiY:integer); virtual;
			procedure SetDPI(dpiX,dpiY:integer); virtual;
			procedure ImageChange; virtual;
			constructor Create(Owner: TComponent); override;
			destructor Destroy; override;
			property DpiX:integer read fDpiX write SetDPIX;
			property DpiY:integer read fDpiY write SetDPIY;
			property Bitmap:TBitmap read GetFBitmap;
         property IEBitmap:TIEBitmap read GetIEBitmap;
         procedure CallBitmapChangeEvents; virtual;
		   function RegisterBitmapChangeEvent(v:TIEBitmapChangeEvent):integer;
			procedure RemoveBitmapChangeEvent(idx:integer);
         function GetCanvas:TCanvas;
         property AlphaChannel:TIEBitmap read GetAlphaChannel;
         property HasAlphaChannel:boolean read GetHasAlphaChannel;
         {$ifdef OCXVERSION}
         procedure WndProc(var Message: TMessage); override;
         {$endif}
         {$ifdef IEKYLIX}
         //property Canvas: TCanvas read FCanvas;
         property HorzScrollBar:TScrollBar read fHorzScrollBar;
         property VertScrollBar:TScrollBar read fVertScrollBar;
         {$endif}
		published
	      property Background:TColor read fBackGround write SetBackGround default clBtnFace;
         (*$ifdef IEDELPHI*)
         property Ctl3D read GetCtl3D write SetCtl3d default true;
         property ParentCtl3D;
         property OnMouseEnter:TNotifyEvent read fOnMouseEnter write fOnMouseEnter;
         property OnMouseLeave:TNotifyEvent read fOnMouseLeave write fOnMouseLeave;
         (*$endif*)
         property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
   end;

// GLOBAL FIELDS
var
   gSystemColors:integer; // display colors number (bit per pixel)
   gSystemDPIX,gSystemDPIY:integer; // system's DPIX and DPIY
   gDefaultDPIX,gDefaultDPIY:integer; // default DPIX and DPIY
   gMMX:boolean;	// CPU supports MMX
   gEdgeX,gEdgeY:integer;	// system border edges
   gVScrollWidth,gHScrollHeight:integer; // system scrollbar sizes

implementation

uses iemview;

/////////////////////////////////////////////////////////////////////////////////////
procedure TIEView.ImageChange;
begin
	//
end;

/////////////////////////////////////////////////////////////////////////////////////
constructor TIEView.Create(Owner: TComponent);
begin
   {$ifdef OCXVERSION}
   ReplyMessageTo:=0;
   {$endif}
	inherited;
   {$ifdef IEDELPHI}
   	(*$ifdef IEDELPHI7*)
   	ControlStyle := ControlStyle + [csOpaque, csAcceptsControls, csReplicatable, csNeedsBorderPaint];
   	(*$else*)
   	ControlStyle := ControlStyle + [csOpaque, csAcceptsControls, csReplicatable];
   	(*$endif*)
	   if not NewStyleControls then ControlStyle := ControlStyle + [csFramed];
  		fOnMouseEnter:=nil;
   	fOnMouseLeave:=nil;
      controlstyle:=controlstyle+[csOpaque];
   (*$endif*)
	fBackground:=clBtnFace;
   FBorderStyle := bsSingle;
   fBmpChange:=TList.Create;
   (*$ifdef IEDELPHI*)
   Ctl3D:=true;
   (*$endif*)
   {$ifdef IEKYLIX}
   fHorzScrollBar:=TScrollBar.Create(self);
   fHorzScrollBar.Parent:=self;
   fHorzScrollBar.Kind:=sbHorizontal;
   fHorzScrollBar.Align:=alBottom;
   fHorzScrollBar.OnScroll:=OnHorizScroll;
   fVertScrollBar:=TScrollBar.Create(self);
   fVertScrollBar.Parent:=self;
   fVertScrollBar.Kind:=sbVertical;
   fVertScrollBar.Align:=alRight;
   fVertScrollBar.OnScroll:=OnVertScroll;
	{$endif}
end;

/////////////////////////////////////////////////////////////////////////////////////
destructor TIEView.Destroy;
begin
	while fBmpChange.Count>0 do begin
   	if assigned(fBmpChange[0]) then
      	PIEBitmapChangeEvent(fBmpChange[0])^(self,true);
   	dispose( fBmpChange[0] );
      fBmpChange.Delete(0);
   end;
   fBmpChange.free;
   {$ifdef IEKYLIX}
   //FCanvas.Free;
   fHorzScrollBar.free;
   fVertScrollBar.free;
   {$endif}
	inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Setta il rate tramite i dpi orizzontali e verticali
procedure TIEView.SetDPI(dpiX,dpiY:integer);
begin
	SetDPIX(dpiX);
   SetDPIY(dpiY);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Setta il rate tramite i dpi orizzontali
procedure TIEView.SetDPIX(dpiX:integer);
begin
	if dpiX<>0 then
		fDPIX:=dpiX;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Setta il rate tramite i dpi verticali
procedure TIEView.SetDPIY(dpiY:integer);
begin
	if dpiY<>0 then
	   fDPIY:=dpiY;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TIEView.GetFBitmap:TBitmap;
begin
	result:=nil;
end;

function TIEView.GetIEBitmap:TIEBitmap;
begin
   result:=nil;
end;

/////////////////////////////////////////////////////////////////////////////////////
// La proprietà Background corrisponde a Color di TControl, le due sono sincronizzate
procedure TIEView.SetBackGround(cl:TColor);
begin
	fBackground:=cl;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TIEView.SetBorderStyle(Value: TBorderStyle);
begin
	if FBorderStyle <> Value then begin
		FBorderStyle := Value;
      (*$ifdef IEDELPHI*)
		RecreateWnd;
      (*$endif*)
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEDELPHI}
procedure TIEView.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do begin
    if FBorderStyle = bsSingle then
      if NewStyleControls and Ctl3D then
        ExStyle := ExStyle or WS_EX_CLIENTEDGE
      else
        Style := Style or WS_BORDER;
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;
{$endif}

// Aggiunge il metodo "v" alla lista di metodi da chiamare quando la proprietà Bitmap
// cambia (nel senso che punta ad un'altra bitmap)
function TIEView.RegisterBitmapChangeEvent(v:TIEBitmapChangeEvent):integer;
var
	x:PIEBitmapChangeEvent;
begin
	new(x);
   x^:=v;
	fBmpChange.Add(x);
   result:=integer(x);
end;

// Rimuove il metodo "idx" dalla lista di metodi da chiamare quando la proprietà Bitmap
// cambia (nel senso che punta ad un'altra bitmap)
procedure TIEView.RemoveBitmapChangeEvent(idx:integer);
var
   i:integer;
begin
   if (idx>-1) then begin
      i:=fBmpChange.IndexOf(pointer(idx));
      if i>-1 then begin
         dispose(fBmpChange[i]);
         fBmpChange.Delete(i);
      end;
   end;
end;

// Chiama gli eventi registrati con RegisterBitmapChangeEvent()
procedure TIEView.CallBitmapChangeEvents;
var
	q:integer;
begin
	for q:=0 to fBmpChange.Count-1 do
   	if assigned(fBmpChange[q]) then
      	PIEBitmapChangeEvent(fBmpChange[q])^(self,false);
end;

{$ifdef IEDELPHI}
function TIEView.GetCtl3D:boolean;
begin
	result:=inherited Ctl3D;
end;

procedure TIEView.SetCtl3D(v:boolean);
begin
	if v<>(inherited Ctl3D) then begin
		inherited Ctl3D:=v;
   	RecreateWnd;
   end;
end;

procedure TIEView.CMMouseEnter(var Message: TMessage);
begin
	inherited;
   if assigned(fOnMouseEnter) then
   	fOnMouseEnter(Self);
end;

procedure TIEView.CMMouseLeave(var Message: TMessage);
begin
	inherited;
   if assigned(fOnMouseLeave) then
   	fOnMouseLeave(Self);
end;

{$endif}	// end of IEDELPHI

function TIEView.GetCanvas:TCanvas;
begin
	result:=Canvas;
end;

{$ifdef OCXVERSION}
procedure TIEView.WndProc(var Message: TMessage);
begin
   inherited WndProc(Message);
   if (ReplyMessageTo<>0) then
   	case Message.Msg of
      	WM_MOUSEMOVE,
         WM_ENABLE,
         WM_QUERYDRAGICON,
         WM_COPYDATA,
         WM_HELP,
         WM_CONTEXTMENU,
        	WM_KEYDOWN,
         WM_KEYUP,
			(* selection doesn't work with these messages in .NET
         WM_LBUTTONDOWN,
  			WM_LBUTTONUP,
  			WM_LBUTTONDBLCLK,
         WM_RBUTTONDOWN,
         WM_RBUTTONUP,
         WM_RBUTTONDBLCLK,
         WM_MBUTTONDOWN,
         WM_MBUTTONUP,
         WM_MBUTTONDBLCLK,
         WM_MOUSEWHEEL,
         WM_MOUSEHOVER,
  			WM_MOUSELEAVE,
			*)
         WM_SYSKEYDOWN,
         WM_SYSKEYUP,
         WM_KEYLAST,
         WM_ENTERMENULOOP,
         WM_EXITMENULOOP,
         WM_NEXTMENU,
         WM_DROPFILES,
         WM_HOTKEY
         :
         	begin
			      PostMessage(ReplyMessageTo,Message.Msg,Message.WParam,Message.LParam);
            end;
      end;
end;
{$endif}	// end of OCXVERSION

{$ifdef IEKYLIX}

function TIEView.WidgetFlags: Integer;
begin
  Result := inherited WidgetFlags or Integer(WidgetFlags_WResizeNoErase) or integer(WidgetFlags_WRepaintNoErase);
end;

function TIEView.EventFilter(Sender: QObjectH; Event: QEventH): Boolean;
var
  EType: QEventType;
begin
  try
    Result := True;
    EType := QEvent_type(Event);
    case EType of
      QEventType_Paint:
        if not (csWidgetPainting in ControlState) then
        begin
          inherited EventFilter(Sender, Event);
          TControlCanvas(Canvas).StartPaint;
          try
            Paint;
          finally
            TControlCanvas(Canvas).StopPaint;
          end;
        end else
          Result := False;
    else
      Result := inherited EventFilter(Sender, Event);
    end;
  except
    Application.HandleException(Self);
    Result := False;
  end;
end;


{$endif}  // end of IEKYLIX

{$IfDef ImageEnNeedOvc}
procedure TIEView.CNKeyDown(var Msg: TWMKeyDown);
var
 l_Controller: TOvcController;
 l_Translation: Word;
begin
 l_Controller := GetDefController;
 if l_Controller <> nil then
  with l_Controller.EntryCommands do
  begin
   l_Translation := TranslateUsing(OvcCmd.ovcTextEditorCommands,
                                   TMessage(Msg),
                                   GetTickCount,
                                   Self as Il3CommandTarget);
   case l_Translation of
    ccShortCut: begin
     Msg.CharCode := 0;
     Msg.Result := 1;
     exit;
    end;
   end;
  end;
end;

procedure TIEView.WMSysKeyDown(var Message: TWMSysKeyDown);
var
 l_Controller: TOvcController;
 l_Translation: Word;
begin
 l_Controller := GetDefController;
 if l_Controller <> nil then
  with l_Controller.EntryCommands do
  begin
   if TranslateUsing(OvcCmd.ovcTextEditorCommands,
                                   TMessage(Message),
                                   GetTickCount,
                                   Self as Il3CommandTarget) <> ccShortcut then
    inherited;
  end;
end;

function TIEView.ProcessCommand(Cmd    : Tl3OperationCode;
                                aForce : Boolean;
                                aCount : Integer): Boolean;
begin
 Result := False;
end;

function TIEView.CheckStamp(const aGUID: TGUID): Boolean;
begin
 Result := False;
end;
{$EndIf ImageEnNeedOvc}

end.



