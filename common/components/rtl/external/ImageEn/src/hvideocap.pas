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

unit hvideocap;

{$R-}
{$Q-}


{$I ie.inc}

{$ifdef IEINCLUDEVIDEOCAPTURE}

interface


uses
  Windows, Messages, SysUtils, StdCtrls, Classes, Graphics, Controls, Forms, ImageEnView,
  ImageEnProc, hyiedefs, videocap, ieview, hyieutils;

const
	VH_FRAMEMESSAGE=WM_USER+5000;
   VH_DESTROYWINDOW=WM_USER+5001;

type

  //TcapVideoStreamCallback = function(hWnd:HWND; lpVHdr:PVIDEOHDR):LRESULT; stdcall;

  TImageEnVideoCap = class(TComponent)
  private
    fCapture:boolean;	// se true inizia cattura
    fWndC:HWND;	// Handle finestra Video Capture (0=da creare)
 	 fDrivers:TStringList;	// driver disponibili
    fVideoSource:integer;	// indice video source corrente
  	 fCallBackFrame:boolean;	// Se True chiama attiva la callback CallBackFrameFunc
    fOnVideoFrame:TVideoFrameEvent;
    fOnVideoFrameRaw:TVideoFrameRawEvent;
    fhBitmapInfo:THandle;	// Handle della Bitmapinfo riempita da FillBitmapInfo
    fBitmapInfoUp:boolean;	// true se fhBitmapInfo è aggiornata (serve a FillBitmapInfo)
    fConnected:boolean;	// true se connesso al driver
    fOnJob:TIEJobEvent;
    fHDrawDib:HDRAWDIB;
    fBitmap:TIEDibBitmap;
    fPix:pointer;
    fDone:boolean;
    fDriverBusy:boolean;
    fEnding:boolean;
    fUseWindowsCodec:boolean;
    // per registrazione
    fRecFileName:string;	// nome file destinazione
    fRecFrameRate:integer; // frames per secondo (dwRequestMicroSecPerFrame)
	 fRecAudio:boolean;		// true cattura audio (fCaptureAudio)
    fRecMultitask:boolean; // false disabilita multitasking (fYeld) [ESC=abort]
    fRecording:boolean;	// true se in registrazione
    fWinHandle:HWND;
  protected
    procedure SetCapture(v:boolean);
    procedure DriverConnect;
    function DriverConnectNE:boolean;
    procedure DriverDisconnect;
    procedure FillDrivers;
    procedure SetVideoSource(v:integer);
    function GetHasDlgVideoSource:boolean;
    function GetHasDlgVideoFormat:boolean;
    function GetHasDlgVideoDisplay:boolean;
    function GetHasOverlay:boolean;
    procedure GetCaps(var fDriverCaps:TCAPDRIVERCAPS);
    procedure SetCallBackFrame(v:boolean);
    procedure SetOnVideoFrame(v:TVideoFrameEvent);
    procedure SetOnVideoFrameRaw(v:TVideoFrameRawEvent);
    function FillBitmapInfo:boolean;
    procedure CreateCaptureWindow;
    procedure DestroyCaptureWindow;
    procedure DoJob(job:TIEJob; per:integer);
    procedure AllocateWindow;
    function GetAudioFormat:word;
    procedure SetAudioFormat(v:word);
    function GetAudioChannels:word;
    procedure SetAudioChannels(v:word);
    function GetAudioSamplesPerSec:dword;
    procedure SetAudioSamplesPerSec(v:dword);
    function GetAudioBitsPerSample:word;
    procedure SetAudioBitsPerSample(v:word);
    procedure GetWaveFormat(var wf:TWAVEFORMATEX);
    procedure SetWaveFormat(var wf:TWAVEFORMATEX);
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    property Capture:boolean read fCapture write SetCapture default false;
    function DoConfigureSource:boolean;
    function DoConfigureFormat:boolean;
    function DoConfigureDisplay:boolean;
    function DoConfigureCompression:boolean;
    property VideoSourceList:TStringList read fDrivers;
    property HasOverlay:boolean read GetHasOverlay;
    property HasDlgVideoSource:boolean read GetHasDlgVideoSource;
    property HasDlgVideoFormat:boolean read GetHasDlgVideoFormat;
    property HasDlgVideoDisplay:boolean read GetHasDlgVideoDisplay;
    procedure StartRecord;
    procedure StopRecord;
    property RecFileName:string read fRecFileName write fRecFileName;
    property RecFrameRate:integer read fRecFrameRate write fRecFrameRate;
	 property RecAudio:boolean read fRecAudio write fRecAudio;
    property RecMultitask:boolean read fRecMultitask write fRecMultitask;
    property WndCaptureHandle:HWND read fWndC;
    property AudioFormat:word read GetAudioFormat write SetAudioFormat;
    property AudioChannels:word read GetAudioChannels write SetAudioChannels;
    property AudioSamplesPerSec:dword read GetAudioSamplesPerSec write SetAudioSamplesPerSec;
    property AudioBitsPerSample:word read GetAudioBitsPerSample write SetAudioBitsPerSample;
    // Formato video
    function GetVideoSize:TRect;
    property UseWindowsCodec:boolean read fUseWindowsCodec write fUseWindowsCodec;
  published
    property VideoSource:integer read fVideoSource write SetVideoSource default 0;
    property OnVideoFrame:TVideoFrameEvent read fOnVideoFrame write SetOnVideoFrame;
    property OnVideoFrameRaw:TVideoFrameRawEvent read fOnVideoFrameRaw write SetOnVideoFrameRaw;
    property OnJob:TIEJobEvent read fOnJob write fOnJob;
  end;

implementation


{$R-}

const

	DLL2 = 'AVICAP32.DLL';

   // VIDEOCAP CONSTS
   WM_CAP_START = WM_USER;
   WM_CAP_GET_STATUS = WM_CAP_START + 54;
	WM_CAP_SET_CALLBACK_STATUS = WM_CAP_START + 3;
   WM_CAP_DRIVER_CONNECT = WM_CAP_START + 10;
   WM_CAP_SEQUENCE = WM_CAP_START + 62;
   WM_CAP_STOP = WM_CAP_START + 69;
   WM_CAP_ABORT = WM_CAP_START + 68;
   WM_CAP_FILE_SET_CAPTURE_FILE = WM_CAP_START + 20;
   WM_CAP_SETPREVIEW = WM_CAP_START + 50;
   WM_CAP_SETPREVIEWRATE = WM_CAP_START + 52;
   WM_CAP_SETOVERLAY = WM_CAP_START + 51;
   WM_CAP_SET_SCALE = WM_CAP_START + 53;
   WM_CAP_DRIVER_DISCONNECT = WM_CAP_START + 11;
   WM_CAP_GRAB_FRAME = WM_CAP_START + 60;
   WM_CAP_SET_CALLBACK_FRAME = WM_CAP_START + 5;
   WM_CAP_DLG_VIDEOFORMAT = WM_CAP_START + 41;
   WM_CAP_DLG_VIDEOSOURCE = WM_CAP_START + 42;
   WM_CAP_DLG_VIDEODISPLAY = WM_CAP_START + 43;
   WM_CAP_DRIVER_GET_CAPS = WM_CAP_START + 14;
   WM_CAP_GET_VIDEOFORMAT = WM_CAP_START + 44;
   WM_CAP_SET_VIDEOFORMAT = WM_CAP_START + 45;
	WM_CAP_DRIVER_GET_NAME = WM_CAP_START + 12;
   WM_CAP_SET_SEQUENCE_SETUP = WM_CAP_START + 64;
   WM_CAP_GET_SEQUENCE_SETUP = WM_CAP_START + 65;
   WM_CAP_DLG_VIDEOCOMPRESSION = WM_CAP_START + 46;
   WM_CAP_FILE_SAVEDIB = WM_CAP_START+  25;
   WM_CAP_EDIT_COPY = WM_CAP_START+  30;
   WM_CAP_SET_USER_DATA = WM_CAP_START+  9;
   WM_CAP_GET_USER_DATA = WM_CAP_START+  8;
   WM_CAP_SEQUENCE_NOFILE = WM_CAP_START+ 63;
   WM_CAP_SET_CALLBACK_VIDEOSTREAM = WM_CAP_START+ 6;
   WM_CAP_SET_CALLBACK_YIELD = WM_CAP_START+ 4;
  	WM_CAP_SET_CALLBACK_ERROR = WM_CAP_START+ 2;
	WM_CAP_SET_AUDIOFORMAT = WM_CAP_START+  35;
	WM_CAP_GET_AUDIOFORMAT = WM_CAP_START+  36;

	IDS_CAP_BEGIN = 300;  // "Capture Start" */
	IDS_CAP_END   = 301;  // "Capture End" */



// AVICAP
function capCreateCaptureWindowA(lpszWindowName:PAnsiChar; dwStyle:dword; x,y,nWidth,nHeight:integer; hwndParent:HWND; nID:integer):HWND; stdcall; external DLL2;
function capGetDriverDescriptionA(wDriverIndex:integer; lpszName:PAnsiChar; cnName:integer; lpszVer:PAnsiChar; cbVer:integer):longbool; stdcall; external DLL2;
function CallBackFrameFunc(hWnd:HWND; lpVHdr:PVIDEOHDR):LRESULT; stdcall; forward;
function CallBackYeldFunc(hWnd:HWND):LRESULT; stdcall; forward;
function CallBackStatusFunc(hWnd:HWND; nID:integer; lpsz:PAnsiChar):LRESULT; stdcall; forward;
function capErrorCallback(hWnd:HWND; nID:integer; lpsz:PAnsiChar):LRESULT; stdcall; forward;



/////////////////////////////////////////////////////////////////////////////////////
constructor TImageEnVideoCap.Create(Owner: TComponent);
begin
	inherited Create(Owner);
   //
   fUseWindowsCodec:=true;
   fEnding:=false;
   fCallBackFrame:=false;
   fDrivers:=TStringList.Create;
   fVideoSource:=0;
   FillDrivers;
   fWndC:=0;
   fCapture:=false;
   fOnVideoFrame:=nil;
   fhBitmapInfo:=GlobalAlloc(GHND,sizeof(TBITMAPINFO)+sizeof(TRGBQUAD)*256);
   fConnected:=false;
   fBitmapInfoUp:=false;
   fRecFileName:='Capture.avi';
   fRecFrameRate:=15;	// 15 frames per second (dwRequestMicroSecPerFrame=66667)
   fRecAudio:=false;
   fRecMultitask:=true;
   fRecording:=false;
   fOnJob:=nil;
  	fHDrawDib:=IEDrawDibOpen;
   fBitmap:=TIEDibBitmap.create;
   fPix:=nil;
   fDone:=true;
   fDriverBusy:=false;
   AllocateWindow;
end;

/////////////////////////////////////////////////////////////////////////////////////
destructor TImageEnVideoCap.Destroy;
begin
   if fCapture then
      SetCapture(false);	// qui richiama anche SetDisplayMode
	fDrivers.free;
   DestroyCaptureWindow;
 	GlobalFree(fhBitmapInfo);
   IEDrawDibClose(fHDrawDib);
   fBitmap.free;
   PostMessage(fWinHandle, VH_DESTROYWINDOW, 0, 0);
   if fPix<>nil then
      freemem(fPix);
   //
   inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoCap.FillDrivers;
var
	DeviceName:array [0..79] of char;
   DeviceVersion:array [0..79] of char;
   q:integer;
begin
	fDrivers.Clear;
	for q:=0 to 9 do
   	if capGetDriverDescriptionA(q,DeviceName,80,DeviceVersion,80) then
			fDrivers.Add(string(DeviceName)+' '+string(DeviceVersion));
end;

/////////////////////////////////////////////////////////////////////////////////////
// - Se il driver è occupato genera l'eccezione TVideoCapException.
procedure TImageEnVideoCap.SetCapture(v:boolean);
var
	cp:TCAPTUREPARMS;
begin
	if fWndC=0 then
   	CreateCaptureWindow;
	if v then begin
   	// START VIDEO INPUT
      fEnding:=false;
      fCapture:=true;
   	if fWndC<>0 then begin
      	if not fConnected then
	      	DriverConnect;
		   SendMessage(fWndC,WM_CAP_SET_SCALE,1,0);
         SendMessage(fWndC,WM_CAP_SET_USER_DATA,0,integer(pointer(self)));
			//
			SendMessage(fWndC,WM_CAP_GET_SEQUENCE_SETUP,sizeof(cp),integer(@cp));
         cp.fAbortLeftMouse:=false;
         cp.fAbortRightMouse:=false;
         cp.fLimitEnabled:=false;
         cp.dwRequestMicroSecPerFrame:=round( (1/fRecFrameRate)*1000000 );
         cp.wPercentDropForError:=100;
         if fRecording then begin
            cp.fYield:=fRecMultitask;
            cp.fCaptureAudio:=fRecAudio;
            SendMessage(fWndC,WM_CAP_SET_SEQUENCE_SETUP,sizeof(cp),integer(@cp));
            if SendMessage(fWndC,WM_CAP_FILE_SET_CAPTURE_FILE,0,integer(PAnsiChar(fRecFileName)))=0 then
               raise TVideoCapException.Create('Unable to create AVI file');
            SetCallBackFrame(fCallBackFrame);
            if SendMessage(fWndC,WM_CAP_SEQUENCE,0,0)=0 then
               raise TVideoCapException.Create('Unable to start video recording');
			end else begin
            cp.fYield:=true;
            cp.fCaptureAudio:=false;
            //cp.wNumVideoRequested:=120;
            //cp.fStepCaptureAt2x:=true;
            SendMessage(fWndC,WM_CAP_SET_SEQUENCE_SETUP,sizeof(cp),integer(@cp));
            SetCallBackFrame(fCallBackFrame);
				SendMessage(fWndC,WM_CAP_SEQUENCE_NOFILE,0,0);
         end;
      end;
   end else begin
   	// STOP VIDEO INPUT
      fEnding:=true;
      SendMessage(fWndC,WM_CAP_STOP,0,0);
      SendMessage(fWndC,WM_CAP_SET_USER_DATA,0,0);
      DriverDisconnect;
      fCapture:=false;
      DestroyCaptureWindow;
	end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Assegna fWndC
// nota: prima di chiamare questa funzione assicurarsi che fWndC sia ZERO
procedure TImageEnVideoCap.CreateCaptureWindow;
begin
   fWndC:=capCreateCaptureWindowA(PAnsiChar(name),WS_CHILD,0,0,50,50,IEFindHandle(self),0);
   //if fCapture then
   //   SetCapture(true);	// qui richiama anche SetDisplayMode
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoCap.DestroyCaptureWindow;
begin
   if fWndC<>0 then begin
      SendMessage(fWndC,WM_CAP_SET_USER_DATA,0,0);
	   DestroyWindow(fWndC);
      fWndC:=0;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoCap.DriverDisconnect;
begin
	SendMessage(fWndC,WM_CAP_DRIVER_DISCONNECT,0,0);
   fConnected:=false;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoCap.SetVideoSource(v:integer);
begin
	fVideoSource:=v;
   if fCapture then begin
    	SetCapture(false);
      SetCapture(true);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoCap.DriverConnect;
begin
	if fWndC=0 then
   	CreateCaptureWindow;
	DoJob(iejVIDEOCAP_CONNECTING,0);
	if SendMessage(fWndC,WM_CAP_DRIVER_CONNECT,fVideoSource,0)=0 then
		raise TVideoCapException.Create('Unable to open video capture driver');
   fConnected:=true;
   fBitmapInfoUp:=false;
   FillBitmapInfo;
   DoJob(iejNOTHING,0);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Come DriverConnect, ma rest. false se la connessione fallisce
function TImageEnVideoCap.DriverConnectNE:boolean;
begin
	if fWndC=0 then
   	CreateCaptureWindow;
	result:=SendMessage(fWndC,WM_CAP_DRIVER_CONNECT,fVideoSource,0)<>0;
   fConnected:=result;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoCap.GetHasDlgVideoSource:boolean;
var
    fDriverCaps:TCAPDRIVERCAPS;
begin
	GetCaps(fDriverCaps);
	result:=fDriverCaps.fHasDlgVideoSource;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoCap.GetHasDlgVideoFormat:boolean;
var
    fDriverCaps:TCAPDRIVERCAPS;
begin
	GetCaps(fDriverCaps);
	result:=fDriverCaps.fHasDlgVideoFormat;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoCap.GetHasDlgVideoDisplay:boolean;
var
    fDriverCaps:TCAPDRIVERCAPS;
begin
	GetCaps(fDriverCaps);
	result:=fDriverCaps.fHasDlgVideoDisplay;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoCap.GetHasOverlay:boolean;
var
    fDriverCaps:TCAPDRIVERCAPS;
begin
	GetCaps(fDriverCaps);
	result:=fDriverCaps.fHasOverlay;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoCap.GetCaps(var fDriverCaps:TCAPDRIVERCAPS);
var
	lcon:boolean;
begin
	lcon:=fConnected;
	if not fConnected then DriverConnect;
	SendMessage(fWndC,WM_CAP_DRIVER_GET_CAPS,sizeof(TCAPDRIVERCAPS),integer(@fDriverCaps));
   if not lcon then DriverDisconnect;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Se ci sono errori genera l'eccezione TVideoCapException
procedure TImageEnVideoCap.StartRecord;
(*
var
	cp:TCAPTUREPARMS;
begin
	fEnding:=false;
	if fRecording then exit;
	SendMessage(fWndC,WM_CAP_GET_SEQUENCE_SETUP,sizeof(cp),integer(@cp));
   cp.fYield:=fRecMultitask;
   cp.fCaptureAudio:=fRecAudio;
   cp.fAbortLeftMouse:=false;
   cp.fAbortRightMouse:=false;
   cp.dwRequestMicroSecPerFrame:=round( (1/fRecFrameRate)*1000000 );
   SendMessage(fWndC,WM_CAP_SET_SEQUENCE_SETUP,sizeof(cp),integer(@cp));
	if SendMessage(fWndC,WM_CAP_FILE_SET_CAPTURE_FILE,0,integer(PAnsiChar(fRecFileName)))=0 then
   	raise TVideoCapException.Create('Unable to create AVI file');
   if SendMessage(fWndC,WM_CAP_SEQUENCE,0,0)=0 then
		raise TVideoCapException.Create('Unable to start video recording');
   fRecording:=true;
end;
*)
begin
	fRecording:=true;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoCap.StopRecord;
begin
	fRecording:=false;
end;
(*
begin
	fEnding:=true;
	if not fRecording then exit;
	SendMessage(fWndC,WM_CAP_STOP,0,0);
   fRecording:=false;
end;
*)

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoCap.DoConfigureSource:boolean;
var
	lcon:boolean;
begin
	lcon:=fConnected;
   result:=fConnected;
	if not fConnected then
   	result:=DriverConnectNE;
   if result then begin
		result:=SendMessage(fWndC,WM_CAP_DLG_VIDEOSOURCE,0,0)<>0;
      fBitmapInfoUp:=false;
      FillBitmapInfo;
	   if not lcon then
      	DriverDisconnect
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoCap.DoConfigureFormat:boolean;
var
	lcon:boolean;
begin
	lcon:=fConnected;
   result:=fConnected;
	if not fConnected then
   	result:=DriverConnectNE;
   if result then begin
		result:=SendMessage(fWndC,WM_CAP_DLG_VIDEOFORMAT,0,0)<>0;
		fBitmapInfoUp:=false;
      FillBitmapInfo;
	   if not lcon then
      	DriverDisconnect
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoCap.DoConfigureDisplay:boolean;
var
	lcon:boolean;
begin
	lcon:=fConnected;
   result:=fConnected;
	if not fConnected then
   	result:=DriverConnectNE;
   if result then begin
		result:=SendMessage(fWndC,WM_CAP_DLG_VIDEODISPLAY,0,0)<>0;
      fBitmapInfoUp:=false;
      FillBitmapInfo;
	   if not lcon then
      	DriverDisconnect
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoCap.FillBitmapInfo:boolean;
var
	sz:integer;
   pt:PBITMAPINFO;
	lcon:boolean;
begin
	if not fBitmapInfoUp then begin
      lcon:=fConnected;
      result:=fConnected;
      if not fConnected then
         result:=DriverConnectNE;
      if result then begin
         GlobalFree(fhBitmapInfo);
         sz:=SendMessage(fWndC,WM_CAP_GET_VIDEOFORMAT,0,0);	// get size
         fhBitmapInfo:=GlobalAlloc(GHND,IMAX(sizeof(TBITMAPINFO)+sizeof(TRGBQUAD)*256,sz));
         pt:=GlobalLock(fhBitmapInfo);
         SendMessage(fWndC,WM_CAP_GET_VIDEOFORMAT,sz,integer(pt));
		   if pt^.bmiHeader.biBitCount=1 then
            fBitmap.AllocateBits(pt^.bmiHeader.biWidth,pt^.bmiHeader.biHeight,1)
		   else
		      fBitmap.AllocateBits(pt^.bmiHeader.biWidth,pt^.bmiHeader.biHeight,24);
         if fPix<>nil then
         	freemem(fPix);
         getmem(fPix,pt^.bmiHeader.biSizeImage);
         GlobalUnLock(fhBitmapInfo);
         if not lcon then
            DriverDisconnect;
      end;
      fBitmapInfoUp:=true;
   end else
   	result:=true;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Rest. dimensioni dell'input video
function TImageEnVideoCap.GetVideoSize:TRect;
var
   pt:PBITMAPINFO;
begin
	if fWndC=0 then
   	CreateCaptureWindow;
	FillBitmapInfo;
	with result do begin
   	Left:=0;
      Top:=0;
		pt:=GlobalLock(fhBitmapInfo);
      Right:=pt^.bmiHeader.biWidth-1;
      Bottom:=pt^.bmiHeader.biHeight-1;
  	   GlobalUnLock(fhBitmapInfo);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Attiva/disattiva chiamata funzione CallBackFrameFunc()
procedure TImageEnVideoCap.SetCallBackFrame(v:boolean);
begin
	fCallBackFrame:=v;
   if fConnected then begin
   	// attiva/disattiva "al volo"
		if v then begin
	   	SendMessage(fWndC,WM_CAP_SET_CALLBACK_VIDEOSTREAM,0,integer(@CallBackFrameFunc));
			SendMessage(fWndC,WM_CAP_SET_CALLBACK_ERROR,0,integer(@capErrorCallback));
			SendMessage(fWndC,WM_CAP_SET_CALLBACK_YIELD,0,integer(@CallBackYeldFunc));
         SendMessage(fWndC,WM_CAP_SET_CALLBACK_STATUS,0,integer(@CallBackStatusFunc));
      end else begin
			SendMessage(fWndC,WM_CAP_SET_CALLBACK_VIDEOSTREAM,0,0);
         SendMessage(fWndC,WM_CAP_SET_CALLBACK_ERROR,0,0);
         SendMessage(fWndC,WM_CAP_SET_CALLBACK_YIELD,0,0);
         SendMessage(fWndC,WM_CAP_SET_CALLBACK_STATUS,0,0);
      end;
	end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoCap.SetOnVideoFrame(v:TVideoFrameEvent);
begin
	fOnVideoFrame:=v;
   SetCallBackFrame( assigned(fOnVideoFrame) or assigned(fOnVideoFrameRaw) );
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoCap.SetOnVideoFrameRaw(v:TVideoFrameRawEvent);
begin
	fOnVideoFrameRaw:=v;
   SetCallBackFrame( assigned(fOnVideoFrame) or assigned(fOnVideoFrameRaw) );
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoCap.DoConfigureCompression:boolean;
var
	lcon:boolean;
begin
	lcon:=fConnected;
   result:=fConnected;
	if not fConnected then
   	result:=DriverConnectNE;
   if result then begin
		result:=SendMessage(fWndC,WM_CAP_DLG_VIDEOCOMPRESSION,0,0)<>0;
      fBitmapInfoUp:=false;
      FillBitmapInfo;
	   if not lcon then
      	DriverDisconnect
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoCap.DoJob(job:TIEJob; per:integer);
begin
	if assigned(fOnJob) then
   	fOnJob(self,job,per);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Funzione callback frame
(*
/* dwFlags field of VIDEOHDR */
#define VHDR_DONE      0x00000001  /* Done bit */
#define VHDR_PREPARED  0x00000002  /* Set if this header has been prepared */
#define VHDR_INQUEUE    0x00000004  /* Reserved for driver */
#define VHDR_KEYFRAME  0x00000008  /* Key Frame */
*)

function CallBackFrameFunc(hWnd:HWND; lpVHdr:PVIDEOHDR):LRESULT;
var
   pobj:pointer;
   obj:TImageEnVideoCap;
{$ifdef IEDELPHI3}
   i:integer;
{$else}
	{$ifdef IECPPBUILDER3}
	   i:integer;
   {$else}
	   i:cardinal;
   {$endif}
{$endif}
begin
	result:=0;
	if (lpVHdr^.dwFlags and 1=0) or (lpVHdr^.dwFlags and 2=0) then
   	exit;
   if SendMessageTimeOut(hWnd,WM_CAP_GET_USER_DATA,0,0,SMTO_ABORTIFHUNG or SMTO_BLOCK,100,i)<>0 then begin
	   pobj:=pointer(i);
      if assigned(pobj) then begin
         obj:=pobj;
         if (obj.fDone) and (not obj.fEnding) then begin
            obj.fDone:=false;
            copymemory(obj.fpix,lpVHdr^.lpData,lpVHdr^.dwBufferLength);
            PostMessage(obj.fWinHandle,VH_FRAMEMESSAGE,0,cardinal(pobj));
         end;
      end;
   end;
end;

function capErrorCallback(hWnd:HWND; nID:integer; lpsz:PAnsiChar):LRESULT;
begin
	result:=0;
end;

function CallBackYeldFunc(hWnd:HWND):LRESULT;
begin
	result:=1;
end;

function CallBackStatusFunc(hWnd:HWND; nID:integer; lpsz:PAnsiChar):LRESULT;
var
   pobj:pointer;
   obj:TImageEnVideoCap;
{$ifdef IEDELPHI3}
   i:integer;
{$else}
	{$ifdef IECPPBUILDER3}
	   i:integer;
   {$else}
	   i:cardinal;
   {$endif}
{$endif}
begin
	if SendMessageTimeOut(hWnd,WM_CAP_GET_USER_DATA,0,0,SMTO_ABORTIFHUNG or SMTO_BLOCK,100,i)<>0 then begin
	   pobj:=pointer(i);
      if assigned(pobj) then begin
         obj:=pobj;
         case nID of
            IDS_CAP_BEGIN:
            	obj.fDriverBusy:=true;
            IDS_CAP_END:
            	obj.fDriverBusy:=false;
         end;
      end;
   end;
	result:=0;
end;

function VideoCapWndProc(Window: HWND; Message, wParam, lParam: Longint): Longint; stdcall;
var
   pbi:PBITMAPINFOHEADER;
   obj:TImageEnVideoCap;
begin
  case Message of
    VH_FRAMEMESSAGE: begin
     	obj:=TImageEnVideoCap(lParam);
      with obj do begin
         if assigned(fOnVideoFrame) and (not fEnding) then begin
            pbi:=GlobalLock(fhBitmapInfo);
            if fUseWindowsCodec then
            	IEDrawDibDraw(fHDrawDib,fBitmap.HDC,0,0,pbi^.biWidth,pbi^.biHeight,pbi^,fPix,0,0,pbi^.biWidth,pbi^.biHeight,0)
            else
	            _CopyDIB2BitmapEx(integer(pbi),fBitmap,fPix,false);
            GlobalUnLock(fhBitmapInfo);
            fOnVideoFrame(obj,fBitmap);
         end;
         if assigned(fOnVideoFrameRaw) and (not fEnding) then
            fOnVideoFrameRaw(obj,fhBitmapInfo,fpix);
         fDone:=true;
		   Result := 0;
      end;
    end;
    VH_DESTROYWINDOW:
      begin
        DestroyWindow(Window);
        Result := 0;
      end;
  else
    Result := DefWindowProc(Window, Message, wParam, lParam);
  end;
end;

var
  VideoCapWindowClass: TWndClass = (
    style: 0;
    lpfnWndProc: @VideoCapWndProc;
    cbClsExtra: 0;
    cbWndExtra: 0;
    hInstance: 0;
    hIcon: 0;
    hCursor: 0;
    hbrBackground: 0;
    lpszMenuName: nil;
    lpszClassName: 'TVideoCapWindow');

procedure TImageEnVideoCap.AllocateWindow;
var
	TempClass: TWndClass;
	ClassRegistered: Boolean;
begin
	VideoCapWindowClass.hInstance := HInstance;
	ClassRegistered := GetClassInfo(HInstance, VideoCapWindowClass.lpszClassName,TempClass);
	if not ClassRegistered or (TempClass.lpfnWndProc <> @VideoCapWndProc) then begin
	   if ClassRegistered then
			Windows.UnregisterClass(VideoCapWindowClass.lpszClassName, HInstance);
		Windows.RegisterClass(VideoCapWindowClass);
	end;
	fWinHandle:= CreateWindow(VideoCapWindowClass.lpszClassName, '', 0, 0, 0, 0, 0, 0, 0, HInstance, nil);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoCap.GetWaveFormat(var wf:TWAVEFORMATEX);
var
	lcon:boolean;
begin
	lcon:=fConnected;
	if not fConnected then DriverConnect;
	SendMessage(fWndC,WM_CAP_GET_AUDIOFORMAT,sizeof(TWAVEFORMATEX),integer(@wf));
   if not lcon then DriverDisconnect;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoCap.SetWaveFormat(var wf:TWAVEFORMATEX);
var
	lcon:boolean;
begin
	lcon:=fConnected;
	if not fConnected then DriverConnect;
   wf.nAvgBytesPerSec:=0;
   wf.cbSize:=0;
	SendMessage(fWndC,WM_CAP_SET_AUDIOFORMAT,sizeof(TWAVEFORMATEX),integer(@wf));
   if not lcon then DriverDisconnect;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoCap.GetAudioFormat:word;
var
	wf:TWAVEFORMATEX;
begin
	GetWaveFormat(wf);
	result:=wf.wFormatTag
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoCap.SetAudioFormat(v:word);
var
	wf:TWAVEFORMATEX;
begin
	GetWaveFormat(wf);
   wf.wFormatTag:=v;
   SetWaveFormat(wf);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoCap.GetAudioChannels:word;
var
	wf:TWAVEFORMATEX;
begin
	GetWaveFormat(wf);
   result:=wf.nChannels;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoCap.SetAudioChannels(v:word);
var
	wf:TWAVEFORMATEX;
begin
	GetWaveFormat(wf);
   wf.nChannels:=v;
   SetWaveFormat(wf);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoCap.GetAudioSamplesPerSec:dword;
var
	wf:TWAVEFORMATEX;
begin
	GetWaveFormat(wf);
   result:=wf.nSamplesPerSec;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoCap.SetAudioSamplesPerSec(v:dword);
var
	wf:TWAVEFORMATEX;
begin
	GetWaveFormat(wf);
   wf.nSamplesPerSec:=v;
   SetWaveFormat(wf);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoCap.GetAudioBitsPerSample:word;
var
	wf:TWAVEFORMATEX;
begin
	GetWaveFormat(wf);
   result:=wf.wBitsPerSample;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoCap.SetAudioBitsPerSample(v:word);
var
	wf:TWAVEFORMATEX;
begin
	GetWaveFormat(wf);
   wf.wBitsPerSample:=v;
   SetWaveFormat(wf);
end;


{$else}	// {$ifdef IEINCLUDEVIDEOCAPTURE}

interface
implementation

{$endif}


end.
