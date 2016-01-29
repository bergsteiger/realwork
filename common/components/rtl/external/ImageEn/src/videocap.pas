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

unit videocap;

{$R-}
{$Q-}


{$I ie.inc}

{$ifdef IEINCLUDEVIDEOCAPTURE}

interface

uses
  Windows, Messages, SysUtils, StdCtrls, Classes, Graphics, Controls, Forms, ImageEnView, ImageEnProc,
  hyiedefs, ievect, ieview, hyieutils;

type

  TVideoCapException=class(Exception);

  TVCDisplayMode=(dmPreview,dmOverlay);

  TVideoFrameEvent = procedure(Sender:TObject; Bitmap:TIEDibBitmap) of object;
  TVideoFrameRawEvent = procedure(Sender:TObject; hDib:Thandle; pData:pointer) of object;

  TCAPDRIVERCAPS = record
  		wDeviceIndex:integer;
      fHasOverlay:longbool;
      fHasDlgVideoSource:longbool;
      fHasDlgVideoFormat:longbool;
      fHasDlgVideoDisplay:longbool;
      fCaptureInitialized:longbool;
      fDriverSuppliesPalettes:longbool;
      hVideoIn:THandle;
      hVideoOut:THandle;
      hVideoExtIn:THandle;
      hVideoExtout:THandle;
  end;
  PCAPDRIVERCAPS=^TCAPDRIVERCAPS;

  TVIDEOHDR = record
  		lpData:pbyte;
      dwBufferLength:dword;
      dwBytesUsed:dword;
      dwTimeCaptured:dword;
      dwUser:dword;
      dwFlags:dword;
      dwReserved:array [0..3] of dword;
  end;
  PVIDEOHDR=^TVIDEOHDR;

  TCAPSTATUS = record
    uiImageWidth:dword;
    uiImageHeight:dword;
    fLiveWindow:longbool;
    fOverlayWindow:longbool;
    fScale:longbool;
    ptScroll:TPOINT;
    fUsingDefaultPalette:longbool;
    fAudioHardware:longbool;
    fCapFileExists:longbool;
    dwCurrentVideoFrame:dword;
    dwCurrentVideoFramesDropped:dword;
    dwCurrentWaveSamples:dword;
    dwCurrentTimeElapsedMS:dword;
    hPalCurrent:THandle;
    fCapturingNow:longbool;
    dwReturn:dword;
    wNumVideoAllocated:dword;
    wNumAudioAllocated:dword;
  end;
  PCAPSTATUS=^TCAPSTATUS;


  PCAPTUREPARMS=^TCAPTUREPARMS;
  TCAPTUREPARMS = record
     dwRequestMicroSecPerFrame :DWORD;    // Requested capture rate
     fMakeUserHitOKToCapture   :longbool;     // Show "Hit OK to cap" dlg?

     //wPercentDropForError      :WORD;     // Give error msg if > (10%)
     wPercentDropForError      :dword;     // Give error msg if > (10%)

     fYield                    :longbool;     // Capture via background task?
     dwIndexSize               :DWORD;    // Max index size in frames (32K)

     //wChunkGranularity         :WORD;     // Junk chunk granularity (2K)
     wChunkGranularity         :dword;     // Junk chunk granularity (2K)

     fUsingDOSMemory           :longbool;     // Use DOS buffers?

     //wNumVideoRequested        :WORD;     // # video buffers, If 0, autocalc
     wNumVideoRequested        :dword;     // # video buffers, If 0, autocalc

     fCaptureAudio             :longbool;     // Capture audio?

     //wNumAudioRequested        :WORD;     // # audio buffers, If 0, autocalc
     //vKeyAbort                 :WORD;     // Virtual key causing abort
     wNumAudioRequested        :dword;     // # audio buffers, If 0, autocalc
     vKeyAbort                 :dword;     // Virtual key causing abort

     fAbortLeftMouse           :longbool;     // Abort on left mouse?
     fAbortRightMouse          :longbool;     // Abort on right mouse?
     fLimitEnabled             :longbool;     // Use wTimeLimit?

     //wTimeLimit                :WORD;     // Seconds to capture
     wTimeLimit                :dword;     // Seconds to capture

     fMCIControl               :longbool;     // Use MCI video source?
     fStepMCIDevice            :longbool;     // Step MCI device?
     dwMCIStartTime            :DWORD;    // Time to start in MS
     dwMCIStopTime             :DWORD;    // Time to stop in MS
     fStepCaptureAt2x          :longbool;     // Perform spatial averaging 2x

     //wStepCaptureAverageFrames :WORD;     // Temporal average n Frames
     wStepCaptureAverageFrames :dword;     // Temporal average n Frames

     dwAudioBufferSize         :DWORD;    // Size of audio bufs (0 = default)
     fDisableWriteCache        :longbool;     // Attempt to disable write cache

     //AVStreamMaster            :WORD;     // Indicates whether the audio stream controls the clock when writing an AVI file.
     AVStreamMaster            :dword;     // Indicates whether the audio stream controls the clock when writing an AVI file.
  end;

  PWAVEFORMATEX = ^TWAVEFORMATEX;
  TWAVEFORMATEX = record
     wFormatTag:word;
     nChannels:word;
     nSamplesPerSec:dword;
     nAvgBytesPerSec:dword;
     nBlockAlign:word;
     wBitsPerSample:word;
     cbSize:word;
  end;

  //TcapVideoStreamCallback = function(hWnd:HWND; lpVHdr:PVIDEOHDR):LRESULT; stdcall;

  TImageEnVideoView = class(TImageEnVect)
  private
    fShowVideo:boolean;	// se true visualizza video input
    fFreeze:boolean;	// se true l'immagine è statica e salvata in Bitmap
    fDisplayMode:TVCDisplayMode;	// Preview/Overlay...
    fWndC:HWND;	// Handle finestra Video Capture (0=da creare)
 	 fDrivers:TStringList;	// driver disponibili
    fVideoSource:integer;	// indice video source corrente
    fSScrollBars:TScrollStyle;	// ombra di fScrollBars
    fPreviewRate:integer;
  	 fCallBackFrame:boolean;	// Se True chiama attiva la callback CallBackFrameFunc
    fOnVideoFrame:TVideoFrameEvent;
    fOnVideoFrameRaw:TVideoFrameRawEvent;
    fhBitmapInfo:THandle;	// Handle della Bitmapinfo riempita da FillBitmapInfo
    fBitmapInfoUp:boolean;	// true se fhBitmapInfo è aggiornata (serve a FillBitmapInfo)
    fConnected:boolean;	// true se connesso al driver
    fFitFreeze:boolean; // true adatta il freeze alla dimensione del componente
    fOnJob:TIEJobEvent;
    fHDrawDib:HDRAWDIB;
    fGrabFrame:boolean;	// se true la callback acquisisce il frame in Bitmap
    // per registrazione
    fRecFileName:string;	// nome file destinazione
    fRecFrameRate:integer; // frames per secondo (dwRequestMicroSecPerFrame)
	 fRecAudio:boolean;		// true cattura audio (fCaptureAudio)
    fRecMultitask:boolean; // false disabilita multitasking (fYeld) [ESC=abort]
    fRecording:boolean;	// true se in registrazione
  protected
    procedure SetShowVideo(v:boolean);
    procedure SetFreeze(v:boolean);
    procedure SetDisplayMode(v:TVCDisplayMode);
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    function DriverConnect:boolean;
    function DriverConnectNE:boolean;
    procedure DriverDisconnect;
    procedure SetVideoSource(v:integer);
    procedure SetScrollBars(v:TScrollStyle); override;
    function GetHasDlgVideoSource:boolean;
    function GetHasDlgVideoFormat:boolean;
    function GetHasDlgVideoDisplay:boolean;
    function GetHasOverlay:boolean;
    procedure GetCaps(var fDriverCaps:TCAPDRIVERCAPS);
    procedure SetPreviewRate(v:integer);
    procedure SetCallBackFrame(v:boolean);
    procedure SetOnVideoFrame(v:TVideoFrameEvent);
    procedure SetOnVideoFrameRaw(v:TVideoFrameRawEvent);
    function FillBitmapInfo:boolean;
    procedure CreateCaptureWindow;
    procedure DestroyCaptureWindow;
    procedure DoJob(job:TIEJob; per:integer);
	 procedure DecompRawFrame(OutBitmap:TIEDibBitmap; pix:pointer);
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
    procedure FillDrivers;
    procedure Paint; override;
    procedure Select(x1,y1,x2,y2:integer; Op:TIESelOp); override;
    function DoConfigureSource:boolean;
    function DoConfigureFormat:boolean;
    function DoConfigureDisplay:boolean;
    function DoConfigureCompression:boolean;
    procedure Freeze;
    procedure UnFreeze;
    property Frozen:boolean read fFreeze write SetFreeze default false;
    procedure SaveFrame;
    property VideoSourceList:TStringList read fDrivers;
    property HasOverlay:boolean read GetHasOverlay;
    property HasDlgVideoSource:boolean read GetHasDlgVideoSource;
    property HasDlgVideoFormat:boolean read GetHasDlgVideoFormat;
    property HasDlgVideoDisplay:boolean read GetHasDlgVideoDisplay;
    function StartRecord:boolean;
    procedure StopRecord;
    property RecFileName:string read fRecFileName write fRecFileName;
    property RecFrameRate:integer read fRecFrameRate write fRecFrameRate;
	 property RecAudio:boolean read fRecAudio write fRecAudio;
    property RecMultitask:boolean read fRecMultitask write fRecMultitask;
    property WndCaptureHandle:HWND read fWndC;
    function GetVideoSize:TRect;
    property AudioFormat:word read GetAudioFormat write SetAudioFormat;
    property AudioChannels:word read GetAudioChannels write SetAudioChannels;
    property AudioSamplesPerSec:dword read GetAudioSamplesPerSec write SetAudioSamplesPerSec;
    property AudioBitsPerSample:word read GetAudioBitsPerSample write SetAudioBitsPerSample;
  published
  	 property FitFreeze:boolean read fFitFreeze write fFitFreeze default true;
    property DisplayMode:TVCDisplayMode read fDisplayMode write SetDisplayMode default dmPreview;
    property ShowVideo:boolean read fShowVideo write SetShowVideo default false;
    property VideoSource:integer read fVideoSource write SetVideoSource default 0;
    property PreviewRate:integer read fPreviewRate write SetPreviewRate default 60;
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
   WM_CAP_DRIVER_CONNECT = WM_CAP_START + 10;
   WM_CAP_SEQUENCE = WM_CAP_START + 62;
   WM_CAP_STOP = WM_CAP_START + 68;
   WM_CAP_FILE_SET_CAPTURE_FILE = WM_CAP_START + 20;
   WM_CAP_SETPREVIEW = WM_CAP_START + 50;
   WM_CAP_SETPREVIEWRATE = WM_CAP_START + 52;
   WM_CAP_SETOVERLAY = WM_CAP_START + 51;
   WM_CAP_SET_SCALE = WM_CAP_START + 53;
   WM_CAP_DRIVER_DISCONNECT = WM_CAP_START + 11;
   WM_CAP_GRAB_FRAME = WM_CAP_START + 60;
   WM_CAP_GRAB_FRAME_NOSTOP = WM_CAP_START + 61;
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
	WM_CAP_SET_AUDIOFORMAT = WM_CAP_START+  35;
	WM_CAP_GET_AUDIOFORMAT = WM_CAP_START+  36;

// AVICAP
function capCreateCaptureWindowA(lpszWindowName:PAnsiChar; dwStyle:dword; x,y,nWidth,nHeight:integer; hwndParent:HWND; nID:integer):HWND; stdcall; external DLL2;
function capGetDriverDescriptionA(wDriverIndex:integer; lpszName:PAnsiChar; cnName:integer; lpszVer:PAnsiChar; cbVer:integer):longbool; stdcall; external DLL2;

function CallBackFrameFunc(hWnd:HWND; lpVHdr:PVIDEOHDR):LRESULT; stdcall; forward;


/////////////////////////////////////////////////////////////////////////////////////
constructor TImageEnVideoView.Create(Owner: TComponent);
begin
	inherited Create(Owner);
   //
   fFitFreeze:=true;
   fCallBackFrame:=false;
   fDrivers:=TStringList.Create;
   fPreviewRate:=60;
   fVideoSource:=0;
   {$ifndef OCXVERSION}
   FillDrivers;
	{$endif}
   fWndC:=0;
   fShowVideo:=false;
   fFreeze:=false;
   fDisplayMode:=dmPreview;
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
end;

/////////////////////////////////////////////////////////////////////////////////////
destructor TImageEnVideoView.Destroy;
begin
	fDrivers.free;
   DestroyCaptureWindow;
 	GlobalFree(fhBitmapInfo);
   IEDrawDibClose(fHDrawDib);
   //
   inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.FillDrivers;
var
	DeviceName:array [0..79] of char;
   DeviceVersion:array [0..79] of char;
   q:integer;
begin
	fDrivers.Clear;
	for q:=0 to 9 do begin
   	if capGetDriverDescriptionA(q,DeviceName,80,DeviceVersion,80) then
			fDrivers.Add(string(DeviceName)+' '+string(DeviceVersion));
   end;
end;


/////////////////////////////////////////////////////////////////////////////////////
// fWndC=0 allora SetShowVideo sarà richiamata da Paint
// - Se il driver è occupato genera l'eccezione TVideoCapException.
procedure TImageEnVideoView.SetShowVideo(v:boolean);
begin
	if v=fShowVideo then
   	exit;
	if v then begin
		fFreeze:=false;
      // hide scrollsbars if visible
   	if fScrollBars<>ssNone then
      	inherited SetScrollBars(ssNone);
   	// VISUALIZZA VIDEO INPUT
   	if fWndC=0 then
      	exit;
      if not fConnected then
	     	if not DriverConnect then
         	exit;
      SendMessage(fWndC,WM_CAP_SET_SCALE,1,0);
      SetDisplayMode(fDisplayMode);
      SetCallBackFrame(fCallBackFrame);	// ribadisce...
      ShowWindow(fWndC,SW_SHOWNORMAL);
      UpdateWindow(fWndC);
      SendMessage(fWndC,WM_CAP_SET_USER_DATA,0,integer(pointer(self)));
      fShowVideo:=true;
   end else begin
      // Hide video input
      SendMessage(fWndC,WM_CAP_SET_USER_DATA,0,0);
      DriverDisconnect;
      //SendMessage(fWndC,WM_CAP_SETPREVIEW,0,0);
		//SendMessage(fWndC,WM_CAP_SETOVERLAY,0,0);
      ShowWindow(fWndC,SW_HIDE);
      fShowVideo:=false;
      // if was present enables scrollbars
      if (fSScrollBars<>ssNone) and not (csDestroying in ComponentState) then
      	inherited SetScrollBars(fSScrollBars);
	end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// nota: eseguire sempre anche se v=fDisplaymode. (vedi SetShowVideo o SetFreeze)
// se fWndC=0 allora SetDisplayMode sarà richiamato da Paint
procedure TImageEnVideoView.SetDisplayMode(v:TVCDisplayMode);
begin
	fDisplayMode:=v;
   if fConnected then begin
		Deselect;
	   if not fFreeze then begin
		   if fDisplayMode=dmPreview then begin
         	// preview
			   SendMessage(fWndC,WM_CAP_SETPREVIEWRATE,fPreviewRate,0);
			   SendMessage(fWndC,WM_CAP_SETPREVIEW,1,0);
		   end else begin
         	// overlay
         	SendMessage(fWndC,WM_CAP_SETPREVIEW,1,0);
            SendMessage(fWndC,WM_CAP_SETOVERLAY,1,0);
		   end;
	   end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.Select(x1,y1,x2,y2:integer; Op:TIESelOp);
begin
	if (fFreeze) or (not fShowVideo) then
   	inherited Select(x1,y1,x2,y2,Op);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.WMSize(var Message: TWMSize);
begin
 	inherited;
   //
   if fWndC<>0 then
      MoveWindow(fWndC,0,0,ClientWidth,ClientHeight,true);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Assegna fWndC
// nota: prima di chiamare questa funzione assicurarsi che fWndC sia ZERO
procedure TImageEnVideoView.CreateCaptureWindow;
begin
   fWndC:=capCreateCaptureWindowA(PAnsiChar(name),WS_CHILD,0,0,ClientWidth,ClientHeight,IEFindHandle(self),0);
   if fShowVideo then
      SetShowVideo(true);	// qui richiama anche SetDisplayMode
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TimageEnvideoView.DestroyCaptureWindow;
begin
   if fWndC<>0 then begin
      SendMessage(fWndC,WM_CAP_SET_USER_DATA,0,0);
		ShowVideo:=false;
	   DestroyWindow(fWndC);
      fWndC:=0;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.Paint;
begin
	if fWndC=0 then
   	CreateCaptureWindow;
	if (not fShowVideo) then
   	inherited Paint;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.Freeze;
begin
	Frozen:=true;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.UnFreeze;
begin
	Frozen:=false;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.DriverDisconnect;
begin
	SendMessage(fWndC,WM_CAP_DRIVER_DISCONNECT,0,0);
   fConnected:=false;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.SetVideoSource(v:integer);
begin
	fVideoSource:=v;
   if fShowVideo then begin
    	SetShowVideo(false);
      SetShowVideo(true);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// In questo modo posso escludere le scrollbars e poi riattivarle in modo pulito, utilizzando
// fSScrollBars (ombra di fScrollBars).
procedure TImageEnVideoView.SetScrollBars(v:TScrollStyle);
begin
	fSScrollBars:=v;
   inherited SetScrollBars(v);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoView.DriverConnect:boolean;
begin
	DoJob(iejVIDEOCAP_CONNECTING,0);
	result:= SendMessage(fWndC,WM_CAP_DRIVER_CONNECT,fVideoSource,0)<>0;
   if result then begin
      fConnected:=true;
      fBitmapInfoUp:=false;
      FillBitmapInfo;
      DoJob(iejNOTHING,0);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Come DriverConnect, ma rest. false se la connessione fallisce
function TImageEnVideoView.DriverConnectNE:boolean;
begin
	result:=SendMessage(fWndC,WM_CAP_DRIVER_CONNECT,fVideoSource,0)<>0;
   fConnected:=result;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoView.GetHasDlgVideoSource:boolean;
var
    fDriverCaps:TCAPDRIVERCAPS;
begin
	GetCaps(fDriverCaps);
	result:=fDriverCaps.fHasDlgVideoSource;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoView.GetHasDlgVideoFormat:boolean;
var
    fDriverCaps:TCAPDRIVERCAPS;
begin
	GetCaps(fDriverCaps);
	result:=fDriverCaps.fHasDlgVideoFormat;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoView.GetHasDlgVideoDisplay:boolean;
var
    fDriverCaps:TCAPDRIVERCAPS;
begin
	GetCaps(fDriverCaps);
	result:=fDriverCaps.fHasDlgVideoDisplay;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoView.GetHasOverlay:boolean;
var
    fDriverCaps:TCAPDRIVERCAPS;
begin
	GetCaps(fDriverCaps);
	result:=fDriverCaps.fHasOverlay;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.GetCaps(var fDriverCaps:TCAPDRIVERCAPS);
var
	lcon:boolean;
begin
	lcon:=fConnected;
	if not fConnected then DriverConnect;
	SendMessage(fWndC,WM_CAP_DRIVER_GET_CAPS,sizeof(TCAPDRIVERCAPS),integer(@fDriverCaps));
   if not lcon then DriverDisconnect;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.SetPreviewRate(v:integer);
begin
	fPreviewRate:=v;
   if fConnected then
	   SendMessage(fWndC,WM_CAP_SETPREVIEWRATE,fPreviewRate,0);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Se ci sono errori genera l'eccezione TVideoCapException
function TImageEnVideoView.StartRecord:boolean;
var
	cp:TCAPTUREPARMS;
begin
	result:=false;
	if fRecording then
   	exit;
	SendMessage(fWndC,WM_CAP_GET_SEQUENCE_SETUP,sizeof(cp),integer(@cp));
   cp.fYield:=fRecMultitask;
   cp.fLimitEnabled:=false;
   cp.fCaptureAudio:=fRecAudio;
   cp.fAbortLeftMouse:=false;
   cp.fAbortRightMouse:=false;
   cp.dwRequestMicroSecPerFrame:=round( (1/fRecFrameRate)*1000000 );
   SendMessage(fWndC,WM_CAP_SET_SEQUENCE_SETUP,sizeof(cp),integer(@cp));
	if SendMessage(fWndC,WM_CAP_FILE_SET_CAPTURE_FILE,0,integer(PAnsiChar(fRecFileName)))=0 then
   	exit;
   if SendMessage(fWndC,WM_CAP_SEQUENCE,0,0)=0 then
		exit;
   fRecording:=true;
   result:=true;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.StopRecord;
begin
	if not fRecording then exit;
	SendMessage(fWndC,WM_CAP_STOP,0,0);
   fRecording:=false;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoView.DoConfigureSource:boolean;
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
function TImageEnVideoView.DoConfigureFormat:boolean;
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
function TImageEnVideoView.DoConfigureDisplay:boolean;
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
function TImageEnVideoView.FillBitmapInfo:boolean;
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
function TImageEnVideoView.GetVideoSize:TRect;
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
procedure TImageEnVideoView.SetCallBackFrame(v:boolean);
begin
	fCallBackFrame:=v;
   if fConnected then begin
   	// attiva/disattiva "al volo"
		if v then
	   	SendMessage(fWndC,WM_CAP_SET_CALLBACK_FRAME,0,integer(@CallBackFrameFunc))
      else
			SendMessage(fWndC,WM_CAP_SET_CALLBACK_FRAME,0,0);
	end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.SetOnVideoFrame(v:TVideoFrameEvent);
begin
	fOnVideoFrame:=v;
   SetCallBackFrame( assigned(fOnVideoFrame) or assigned(fOnVideoFrameRaw) );
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.SetOnVideoFrameRaw(v:TVideoFrameRawEvent);
begin
	fOnVideoFrameRaw:=v;
   SetCallBackFrame( assigned(fOnVideoFrame) or assigned(fOnVideoFrameRaw) );
end;

/////////////////////////////////////////////////////////////////////////////////////
// Decompress raw frame
// OutBitmap has to be created
procedure TImageEnVideoView.DecompRawFrame(OutBitmap:TIEDibBitmap; pix:pointer);
var
   pbi:PBITMAPINFOHEADER;
begin
   pbi:=GlobalLock(fhBitmapInfo);
   if pbi^.biBitCount=1 then
      OutBitmap.AllocateBits(pbi^.biWidth,pbi^.biHeight,1)
   else
      OutBitmap.AllocateBits(pbi^.biWidth,pbi^.biHeight,24);
   IEDrawDibDraw(fHDrawDib,OutBitmap.HDC,0,0,OutBitmap.Width,OutBitmap.Height,
               pbi^,pix,0,0,OutBitmap.Width,OutBitmap.Height,0);
   GlobalUnLock(fhBitmapInfo);
end;

/////////////////////////////////////////////////////////////////////////////////////
// callback frame function
function CallBackFrameFunc(hWnd:HWND; lpVHdr:PVIDEOHDR):LRESULT;
var
	xBitmap:TIEDibBitmap;
   pobj:pointer;
   obj:TImageEnVideoView;
begin
	result:=0;
   pobj:=pointer(SendMessage(hWnd,WM_CAP_GET_USER_DATA,0,0));
   if assigned(pobj) then begin
      obj:=pobj;
      with obj do begin
         if assigned(fOnVideoFrame) then begin
            xBitmap:=TIEDibBitmap.Create;
            DecompRawFrame(xBitmap,lpVHdr^.lpData);
            fOnVideoFrame(obj,xBitmap);
            xBitmap.free;
         end;
         if assigned(fOnVideoFrameRaw) then
            fOnVideoFrameRaw(obj,fhBitmapInfo,lpVHdr^.lpData);
         if fGrabFrame then begin
            xBitmap:=TIEDibBitmap.Create;
            DecompRawFrame(xBitmap,lpVHdr^.lpData);
            xBitmap.CopyToTBitmap(fBitmap);
            xBitmap.free;
            fGrabFrame:=false;
         end;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.SetFreeze(v:boolean);
var
	fImageEnProc:TImageEnProc;
begin
  	fFreeze:=v;
	if (fShowVideo) and (fConnected) then begin
	   if fFreeze then begin
         fGrabFrame:=true;
         SetCallBackFrame( true );
         SendMessage(fWndC,WM_CAP_SETPREVIEW,1,0);
         SendMessage(fWndC,WM_CAP_GRAB_FRAME,0,0);
         while fGrabFrame do;
         SetCallBackFrame( assigned(fOnVideoFrame) or assigned(fOnVideoFrameRaw) );
         if fFitFreeze then begin
            fImageEnProc:=TImageEnProc.Create(self);
            fImageEnProc.AttachedBitmap:=Bitmap;
            if (ClientWidth>Bitmap.Width) or (ClientHeight>Bitmap.Height) then
               fImageEnProc.Resample(ClientWidth,ClientHeight,rfFastLinear)
            else
               fImageEnProc.Resample(ClientWidth,ClientHeight,rfNone);
            fImageEnProc.free;
         end;
         Update;
	   end else begin
	   	SetDisplayMode(fDisplayMode);
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.SaveFrame;
var
	fImageEnProc:TImageEnProc;
begin
	if (fShowVideo) and (fConnected) then begin
      fGrabFrame:=true;
      SetCallBackFrame( true );
      SendMessage(fWndC,WM_CAP_SETPREVIEW,1,0);
      SendMessage(fWndC,WM_CAP_GRAB_FRAME_NOSTOP,0,0);
      while fGrabFrame do;
      SetCallBackFrame( assigned(fOnVideoFrame) or assigned(fOnVideoFrameRaw) );
      if fFitFreeze then begin
         fImageEnProc:=TImageEnProc.Create(self);
         fImageEnProc.AttachedBitmap:=Bitmap;
         if (ClientWidth>Bitmap.Width) or (ClientHeight>Bitmap.Height) then
            fImageEnProc.Resample(ClientWidth,ClientHeight,rfFastLinear)
         else
            fImageEnProc.Resample(ClientWidth,ClientHeight,rfNone);
         fImageEnProc.free;
      end;
      Update;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoView.DoConfigureCompression:boolean;
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
procedure TImageEnVideoView.DoJob(job:TIEJob; per:integer);
begin
	if assigned(fOnJob) then
   	fOnJob(self,job,per);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.GetWaveFormat(var wf:TWAVEFORMATEX);
var
	lcon:boolean;
begin
	lcon:=fConnected;
	if not fConnected then DriverConnect;
	SendMessage(fWndC,WM_CAP_GET_AUDIOFORMAT,sizeof(TWAVEFORMATEX),integer(@wf));
   if not lcon then DriverDisconnect;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.SetWaveFormat(var wf:TWAVEFORMATEX);
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
function TImageEnVideoView.GetAudioFormat:word;
var
	wf:TWAVEFORMATEX;
begin
	GetWaveFormat(wf);
	result:=wf.wFormatTag
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.SetAudioFormat(v:word);
var
	wf:TWAVEFORMATEX;
begin
	GetWaveFormat(wf);
   wf.wFormatTag:=v;
   SetWaveFormat(wf);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoView.GetAudioChannels:word;
var
	wf:TWAVEFORMATEX;
begin
	GetWaveFormat(wf);
   result:=wf.nChannels;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.SetAudioChannels(v:word);
var
	wf:TWAVEFORMATEX;
begin
	GetWaveFormat(wf);
   wf.nChannels:=v;
   SetWaveFormat(wf);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoView.GetAudioSamplesPerSec:dword;
var
	wf:TWAVEFORMATEX;
begin
	GetWaveFormat(wf);
   result:=wf.nSamplesPerSec;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.SetAudioSamplesPerSec(v:dword);
var
	wf:TWAVEFORMATEX;
begin
	GetWaveFormat(wf);
   wf.nSamplesPerSec:=v;
   SetWaveFormat(wf);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnVideoView.GetAudioBitsPerSample:word;
var
	wf:TWAVEFORMATEX;
begin
	GetWaveFormat(wf);
   result:=wf.wBitsPerSample;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnVideoView.SetAudioBitsPerSample(v:word);
var
	wf:TWAVEFORMATEX;
begin
	GetWaveFormat(wf);
   wf.wBitsPerSample:=v;
   SetWaveFormat(wf);
end;


{$else}	// IEINCLUDEVIDEOCAPTURE

interface
implementation

{$endif}

end.
