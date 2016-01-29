{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit AviPlay;
interface
{$I dc.inc}
//{$DEFINE DEMO}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  mmsystem, dcsystem, dcconsts, dcdreamlib;

const
  WM_NEXTFRAME = WM_USER + 1;

  cBufSize = 2048;     {audio buffer size}
  CAheadBuffers = 8;

type
   TAudioPlay = class
   private
     fBufferSize    : integer;
     fAVI           : pointer;
     fSampleSize    : integer;
     fEnd           : integer;
     fPlaying       : boolean;
     fWaveOut       : HWAVEOUT;
     fBegin         : integer;
     fCurrent       : integer;

     function   OpenDevice(W : HWND; pAvi : pointer) : boolean;
     function   FillBuffer : boolean;
   public
     destructor Destroy; override;
     procedure  AudioPlayMessage(W : PWAVEHDR);
     procedure  Stop;
     function   Play(W : HWND; pAvi : Pointer; lStart, lEnd : longint) : boolean;
   end;

  TDCAVIPlay = class(TCustomControl)
  private
    _dc           : THandle;
    fActive       : boolean;
    fAutoSize     : boolean;
    fCenter       : boolean;
    fFileName     : string;
    fOpen         : boolean;
    fRepetitions  : integer;
    fStartFrame   : integer;
    fStopFrame    : integer;
    fTransparent  : boolean;
    fSkipFrames   : boolean;
    fStretch      : boolean;
    fLength       : integer;
    fFrameWidth   : integer;
    fFrameHeight  : integer;
    fPlaySound    : boolean;

    fOnClose      : TNotifyEvent;
    fOnOpen       : TNotifyEvent;
    fOnStart      : TNotifyEvent;
    fOnStop       : TNotifyEvent;

    favifile      : pointer;
    faudiostream  : pointer;
    fvideostream  : pointer;
    fFrame        : integer;
    fTimer        : THandle;
    fgetframe     : pointer;
    fdrawing      : boolean;
    fdrawcontrol  : integer;
    ftempdc       : THandle;
    ftempbitmap   : THandle;
    foldbitmap    : THandle;
    frepeatcount  : integer;
    fdelay        : integer;
    fbackchanged  : boolean;
    fBlockChanges : boolean;
    faudioplay    : TAudioPlay;
    hdrawdib      : THandle;

    fxstart       : integer;
    fystart       : integer;
    fofs          : integer;
    fxofs         : integer;
    fyofs         : integer;
    fiwidth       : integer;
    fiheight      : integer;

    FVersion      : TDCVersion;

    procedure PlayNextFrame(var Msg : TMessage); message WM_NEXTFRAME;
    procedure SaveBackground;
    procedure AdjustControlsize;
    procedure ShowRect;
    procedure KillTempDC;
    procedure HookWndProc;
    procedure UnHookWndProc;
    procedure MMWOM_DONE(var M:TMessage); message MM_WOM_DONE;
    procedure PlayAudio(startframe, endframe : integer);
    procedure CalcFrameLayout;
    procedure DisplayChange(var Msg : TMessage); message WM_DISPLAYCHANGE;
    procedure ValidateFrameNumber(var val : integer);
    procedure UpdateFrameNumber;
    function  ZOrder : integer;
    procedure StartDrawing;
    procedure DrawFrameToDC(dc : THandle);
  protected
    procedure UpdateOtherAVIPlayers;
    function  PaintDisabled : boolean;
    procedure CreateParams (var Params: TCreateParams); override;
    procedure ShowFrame;
    procedure WMPaint(var Msg : TWMPaint); message WM_PAINT;
    procedure WMEraseBkgnd(var Msg : TMessage); message WM_ERASEBKGND;
    procedure WMMove (var Msg : TMessage); message WM_MOVE;
    procedure WMSize (var Msg : TMessage); message WM_SIZE;

    procedure Loaded; override;
    procedure SetActive (val : boolean);   virtual;
    procedure InternalSetAutoSize (val : boolean); virtual;
    procedure SetCenter (val : boolean);   virtual;
    procedure SetFileName (val : string);  virtual;
    procedure SetRepetitions (val : integer); virtual;
    procedure SetStartFrame (val : integer);  virtual;
    procedure SetStopFrame (val : integer);   virtual;
    procedure SetTransparent (val : boolean); virtual;
    procedure SetStretch (val : boolean); virtual;
    procedure SetPlaySound(val : boolean); virtual;

    procedure OpenFile; virtual;
    procedure CloseFile; virtual;

    procedure DoOpen; virtual;
    procedure DoClose; virtual;
    procedure DoStart; virtual;
    procedure DoStop; virtual;
  public
    constructor Create (AOwner : TComponent); override;
    destructor  Destroy; override;
    procedure   Play (FromFrame, ToFrame: Word; Count: Integer);
    procedure   Reset;
    procedure   Seek (Frame : integer);
    procedure   Stop;

    property    FrameCount : integer read fLength;
    property    FrameHeight: Integer read FFrameHeight;
    property    FrameWidth : Integer read FFrameWidth;

    property    Open : boolean read fOpen;

  published
    property Active      : boolean read fActive write SetActive default false;
    property AutoSize    : boolean read fAutoSize write InternalSetAutoSize default true;
    property Center      : boolean read fCenter write SetCenter default true;
    property FileName    : string  read fFileName write SetFileName;
    property PlaySound   : boolean read fPlaySound write SetPlaySound default true;
    property Repetitions : integer read fRepetitions write SetRepetitions default 0;
    property StartFrame  : integer read fStartFrame write SetStartFrame default 1;
    property StopFrame   : integer read fStopFrame write SetStopFrame default 0;
    property Stretch     : boolean read fStretch write SetStretch default false;
    property Transparent : boolean read fTransparent write SetTransparent default true;

    property Position : integer read fFrame write Seek;
    
    property OnOpen: TNotifyEvent read fOnOpen write fOnOpen;
    property OnClose: TNotifyEvent read fOnClose write fOnClose;
    property OnStart: TNotifyEvent read fOnStart write fOnStart;
    property OnStop: TNotifyEvent read fOnStop write fOnStop;

    property Align;
    property Color;
    property ParentColor;
    property ParentShowHint;
    property ShowHint;
    property Visible;

    property OnMouseDown;
    property OnClick;
    property Version : TDCVersion read FVersion write FVersion stored false;
  end;

type
  TAVIStream = record
    fccType    : longint;
    fccHandler : longint;
    dwFlags    : longint;
    dwCaps     : longint;
    wPriority  : word;
    wLanguage  : word;
    dwScale    : longint;
    dwRate     : longint;
    dwStart    : longint;
    dwLength   : longint;
    dwInitialFrames : longint;
    dwSuggestedBufferSize : longint;
    dwQuality    : longint;
    dwSampleSize : longint;
    rcFrame      : TRect;
    dwEditCount  : longint;
    dwFormatChangeCount : longint;
    Name : array [0..64] of char;
  end;

  PAVIStream = ^TAVIStream;

  PAVIFile = pointer;

  TAVIFileInfo = record
    dwMaxBytesPerSec : longint; // max. transfer rate
    dwFlags          : longint; // the ever-present flags
    dwCaps           : longint;
    dwStreams        : longint;
    dwSuggestedBufferSize : longint;

    dwWidth          : longint;
    dwHeight         : longint;

    dwScale          : longint;
    dwRate           : longint; // dwRate / dwScale == samples/second
    dwLength         : longint;

    dwEditCount      : longint;

    szFileType       : array[0..63] of char; // descriptive string for file type?
  end;

  PAVIFileInfo = ^TAVIFileInfo;

  TAVIStreamInfo = record
    fccType               : longint;
    fccHandler            : longint;
    dwFlags               : longint; // Contains AVITF_* flags
    dwCaps                : longint;
    wPriority             : word;
    wLanguage             : word;
    dwScale               : longint;
    dwRate                : longint; // dwRate / dwScale == samples/second
    dwStart               : longint;
    dwLength              : longint; // In units above...
    dwInitialFrames       : longint;
    dwSuggestedBufferSize : longint;
    dwQuality             : longint;
    dwSampleSize          : longint;
    rcFrame               : TRect;
    dwEditCount           : longint;
    dwFormatChangeCount   : longint;
    szName  : array[0..63] of char;
  end;

  PAVIStreamInfo = ^TAVIStreamInfo;


//BeginSkipConst
procedure AVIFileInit; stdcall; external 'avifil32.dll' name 'AVIFileInit';

procedure AVIFileExit; stdcall; external 'avifil32.dll' name 'AVIFileExit';

function  AVIFileOpen(avifile : pointer; filename : pchar; mode : integer;
                   CLSID : pointer) : integer; stdcall; external 'avifil32.dll' name 'AVIFileOpen';

function  AVIFileRelease(avifile : pointer) : longint; stdcall; external 'avifil32.dll' name 'AVIFileRelease';

function  AVIFileGetStream(avifile : pointer; avistream : PAVIStream;
                           streamtype : longint; lParam : longint) : integer; stdcall; external 'avifil32.dll' name 'AVIFileGetStream';

function  AVIStreamGetFrameOpen(avistream : PAVIStream; bitmapwanted : pointer) : pointer; stdcall; external 'avifil32.dll' name 'AVIStreamGetFrameOpen';

procedure AVIStreamGetFrameClose(pget : pointer); stdcall; external 'avifil32.dll' name 'AVIStreamGetFrameClose';

function  AVIStreamGetFrame(getframe : pointer; position : longint) : pointer; stdcall; external 'avifil32.dll' name 'AVIStreamGetFrame';

function  AVIStreamOpenFromFile(avistream : PAVIStream; filename : pchar;
                                streamtype : word; lParam : longint;
                                mode : longint; clsid : pointer) : integer; stdcall; external 'avifil32.dll' name 'AVIStreamOpenFromFile';

procedure AVIStreamRelease(avistream : PAVIStream); stdcall; external 'avifil32.dll' name 'AVIStreamRelease';
function  AVIFileInfo(pfile : PAVIFile; pfi : PAVIFileInfo; lSize : longint) : integer; stdcall; external 'avifil32.dll' name 'AVIFileInfo';

function  AVIStreamInfo(pstream : PAVIStream; psi : PAVISTREAMINFO; lsize : longint) : integer; stdcall; external 'avifil32.dll' name 'AVIStreamInfo';
function  AVIStreamRead(pavi : PAVIStream; lStart, lSamples : longint;
                        lpBuffer : pointer; cbBuffer : longint;
                        plBytes,  plSamples : pointer) : integer; stdcall; external 'avifil32.dll' name 'AVIStreamRead';

function  AVIStreamReadFormat(pavi : PAVIStream; lPos : longint;
                              lpFormat : pointer; lpcbFormat : pointer) : integer; stdcall; external 'avifil32.dll' name 'AVIStreamReadFormat';

function  AVIStreamBeginStreaming(pavi : PAVIStream; lStart, lEnd, lRate : longint) : integer; stdcall; external 'avifil32.dll' name 'AVIStreamBeginStreaming';
function  AVIStreamEndStreaming(pavi : PAVIStream) : integer; stdcall; external 'avifil32.dll' name 'AVIStreamEndStreaming';
function  AVIStreamStart(pavi : PAVIStream) : longint; stdcall; external 'avifil32.dll' name 'AVIStreamStart';
function  AVIStreamLength(pavi: PAVIStream) : longint; stdcall; external 'avifil32.dll' name 'AVIStreamLength';
function  AVIStreamSampleToTime(pavi : PAVIStream; lSample : longint) : longint; stdcall; external 'avifil32.dll' name 'AVIStreamSampleToTime';
function  AVIStreamTimeToSample(pavi : PAVIStream; Time : longint) : longint; stdcall; external 'avifil32.dll' name 'AVIStreamTimeToSample';

function  DrawDIBOpen : THandle; stdcall; external 'msvfw32.dll' name 'DrawDibOpen';
procedure DrawDIBClose (h : THandle); stdcall; external 'msvfw32.dll' name 'DrawDibClose';
procedure DrawDibDraw (hdib, dc : THandle; xDst, yDst, dxDst, dyDst : integer;
                       lpbi, lpBits : pointer; xSrc, ySrc, dxSrc, dySrc, wFlags : integer); stdcall; external 'msvfw32.dll' name 'DrawDibDraw';

//EndSkipConst
const
  streamtypeAUDIO : longint = $73647561;
  streamtypeVIDEO : longint = $73646976;

//  TIME_ONESHOT  = 0;  { program timer for single event }
//  TIME_PERIODIC = 1;  { program for continuous periodic event }

const
  AVISTREAMREAD_CONVENIENT  = -1;


const DDF_HALFTONE = $1000;

{-----------------------------------------------------------------------}

implementation

function  AVIStreamEnd  (pavi : PAVIStream) : longint;
begin
  result := AVIStreamStart(pavi) + AVIStreamLength(pavi);
end;

{-----------------------------------------------------------------------}

function  AVIStreamFormatSize (pavi : PAVIStream; lPos : longint; plSize : pointer) : longint;
begin
  result := AVIStreamReadFormat(pavi, lPos, nil, plSize);
end;

{-----------------------------------------------------------------------}

constructor TDCAVIPlay.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
  width := 100;
  height := 50;

  fAutoSize := true;
  fCenter := true;
  fStartFrame := 1;
  fTransparent := true;
  fSkipFrames := true;
  fAutoSize := true;
  fBackChanged := true;
  fblockchanges := true;
  fPlaySound := true;

  AVIFileInit;
  faudioplay := TAudioPlay.Create;
  HookWndProc;
  hdrawdib := DrawDIBOpen;
end;

{------------------------------------------------------------------}

destructor TDCAVIPlay.Destroy;
begin
  Stop;
  UnHookWndProc;
  DrawDIBClose(hdrawdib);
  KillTempDC;
  CloseFile;
  faudioplay.Free;
  AVIFileExit;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT;
end;

{------------------------------------------------------------------}

function  TDCAVIPlay.ZOrder : integer;
begin
  if Parent <> nil then
    with Parent do
      for result := 0 to ControlCount - 1 do
        if Controls[result] = self then
          exit;

  result := -1
end;

{------------------------------------------------------------------}

procedure Timer(uID, uMsg, dwUser, dw1, dw2 : longint); stdcall;
begin
  with TDCAVIPlay(dwUser) do
    if not PaintDisabled then
      PostMessage(Handle, WM_NEXTFRAME, 0, 0);
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.PlayAudio(startframe, endframe : integer);
var
  astart : integer;
  aend   : integer;
begin
  if (faudiostream = nil) or not fPlaySound then
    exit;

  astart := AVIStreamTimeToSample(faudiostream, AVIStreamSampleToTime(fvideostream, startFrame));
  aend   := AVIStreamTimeToSample(faudiostream, AVIStreamSampleToTime(fvideostream, endFrame));
  faudioplay.play(handle, faudiostream, astart, aend);
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.Play (FromFrame, ToFrame: Word; Count: Integer);
var
  info   : TAVIStreamInfo;
  ainfo  : TAVIStreamInfo;
begin
  Stop;
  if not Assigned(fvideostream) then
    exit;

  fFrame := FromFrame;
  fStartFrame := FromFrame;
  fStopFrame := ToFrame;
  frepeatCount := Count;
  AVIStreamInfo(fvideostream, @info, sizeof(info));
  fdelay := MulDiv(info.dwScale, 1000, info.dwRate);

  DoStart;
  fActive := true;
  if Assigned(faudiostream) then
    begin
      AVIStreamInfo(fvideostream, @ainfo, sizeof(info));
      PlayAudio(fFrame, fStopFrame);
    end;

  fTimer := timeSetEvent(fdelay, 0, @Timer, integer(self), TIME_PERIODIC);
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.Stop;
begin
  if ftimer <> 0 then
    begin
      timeKillEvent(fTimer);
      fTimer := 0;
    end;

  if not fActive then
    exit;

  faudioplay.stop;
  fActive := false;
  DoStop;
  ShowFrame;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.Seek (Frame : integer);
begin
  if Frame = fFrame then
    exit;

  Stop;
  ValidateFrameNumber(Frame);
  fFrame := Frame;
  Invalidate;
end;

{------------------------------------------------------------------}
type
  TMControl = class(TWinControl);

procedure TDCAVIPlay.Loaded;
var
  _startframe : integer;
  _stopframe  : integer;
begin
  inherited Loaded;

  if ffilename <> '' then
    begin
      fBlockChanges := false;
      _startframe := fstartframe;
      _stopframe := fStopFrame;
      OpenFile;
      fstartframe := _startframe;
      fStopFrame := _stopframe;
      fBlockChanges := true;
    end;

  if fActive then
    if fOpen then
      Play(fStartFrame, fStopFrame, fRepetitions)
    else
      fActive := false
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.SetActive(val : boolean);
begin
  if val = fActive then
    exit;

//  fActive := val;
  if not (csReading in ComponentState) then
    if val then
      begin
        Play(fStartFrame, fStopFrame, fRepetitions)
      end
    else
      begin
        Stop;
        if csDesigning in ComponentState then
          begin
            fFrame := 0;
            ShowFrame;
          end;
      end;

end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.InternalSetAutoSize(val : boolean);
begin
  if val = fAutoSize then
    exit;

  fAutoSize := val;
  AdjustControlsize;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.SetCenter(val : boolean);
begin
  if val = fCenter then
    exit;

  fCenter := val;
  if not fTransparent then
    Invalidate;

  ShowFrame;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.SetFileName(val : string);
var
  wasactive : boolean;
begin
  if val = fFileName then
    exit;

  ffilename := val;
  if csReading in ComponentState then
    exit;

  wasactive := fActive;

  Reset;

  Invalidate;
  ShowFrame;

  if val = '' then
    begin
      fbackchanged := true;
      Parent.Invalidate;
      UpdateWindow(Parent.Handle);
    end;

  if wasActive then
    if not (csReading in ComponentState) then
      Active := true
    else
      fActive := true;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.SetRepetitions(val : integer);
begin
  if val = fRepetitions then
    exit;

  fRepetitions := val;
  if csDesigning in ComponentState then
    begin
      Stop;
      fFrame := 0;
      ShowFrame;
    end;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.ValidateFrameNumber(var val : integer);
begin
  if fOpen then
    if val > fLength - 1 then
      val := fLength - 1
    else
      if val < 0 then
        val := 0;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.SetStartFrame(val : integer);
begin
  if (val = fStartFrame) then
    exit;

  ValidateFrameNumber(val);
  fStartFrame := val;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.SetStopFrame(val : integer);
begin
  if val = fStopFrame then
    exit;

  ValidateFrameNumber(val);
  fStopFrame := val;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.SetTransparent(val : boolean);
begin
  if val = fTransparent then
    exit;

  fTransparent := val;
  Invalidate;
  ShowFrame;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.SetStretch (val : boolean);
begin
  if val = fStretch then
    exit;

  fStretch := val;
  if not (csReading in ComponentState) then
    begin
      if not val then
        invalidate;

      if not fActive then
        ShowFrame;
    end;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.SetPlaySound (val : boolean);
begin
  if val = fPlaySound then
    exit;

  fPlaySound := val;
  if fActive then
    if val then
      PlayAudio(fFrame, fStopFrame)
    else
      faudioplay.Stop;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.AdjustControlsize;
var
  info  : TAVIStreamInfo;
  r     : TRect;
  r2    : TRect;
  i     : integer;
  crect : TRect;
begin
  if fautosize and fOpen then
    begin
      AVIStreamInfo(fvideostream, @info, sizeof(info));
      if fblockchanges then
        Parent.Perform(WM_SETREDRAW, 0, 0);
      r := Rect(left, top, left + width, top + height);
      with info.rcframe do
        SetBounds(self.left, self.top, right - left, bottom - top);
      if fblockchanges then
        begin
          Parent.Perform(WM_SETREDRAW, 1, 0);
          r2 := Rect(left, top, left + width, top + height);
          SubtractRect(r, r, r2);
          InvalidateRect(Parent.Handle, @r, true);
          with Parent do
            for i := 0 to ControlCount - 1 do
              begin
                with Controls[i] do
                  crect := Rect(left, top, left + width, top + height);

                if (Controls[i] is TWinControl) and (Controls[i] <> self) and
                InterSectRect(r2, r, crect) then
                  Controls[i].Invalidate;
              end;
        end;
    end;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.OpenFile;
var
  info : TAVIStreamInfo;
begin
  if ffilename = '' then
    exit;

  if (AVIFileOpen(@favifile, @(ffilename[1]), 0, nil) <> 0) then
    exit;

  if (AVIFileGetStream(favifile, @fvideostream, streamtypeVIDEO, 0) <> 0) then
    begin
      AVIFileRelease(favifile);
      exit;
    end;

  fgetframe := AVIStreamGetFrameOpen(fvideostream, nil);

  if fgetframe = nil then
    begin
      AVIStreamRelease(fvideostream);
      AVIFileRelease(favifile);
      exit;
    end;

  AVIFileGetStream(favifile, @faudiostream, streamtypeAUDIO, 0);

  AVIStreamInfo(fvideostream, @info, sizeof(info));
  with info do
    begin
      fLength := dwlength;
      fFrameWidth := rcframe.right - rcframe.left;
      fFrameHeight := rcframe.bottom - rcframe.top;
      fStartFrame := dwStart;
      fStopFrame := fLength - 1;
    end;
  fFrame := fStartFrame;
  fOpen := true;
  SetWindowLong(handle, GWL_EXSTYLE, GetWindowLong(handle, GWL_EXSTYLE) and (not WS_EX_TRANSPARENT));
  AdjustControlsize;
  fbackchanged := true;
  Invalidate;
{  ShowFrame;
  Parent.Invalidate;}
  DoOpen;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.CloseFile;
begin
  if not fOpen then
    exit;

  if fActive then
    Stop;

  if Assigned(fgetframe) then
    AVIStreamGetFrameClose(fgetframe);

  if Assigned(faudiostream) then
    AVIStreamRelease(faudiostream);

  if Assigned(fvideostream) then
    AVIStreamRelease(fvideostream);

  if Assigned(favifile) then
    AVIFileRelease(favifile);

  faudiostream := nil;
  fvideostream := nil;
  favifile := nil;
  fgetframe := nil;
  fOpen := false;
  fLength := 0;
  DoClose;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.CalcFrameLayout;
begin
  fxstart := 0;
  fystart := 0;
  if csDesigning in ComponentState then
    fofs := 1
  else
    fofs := 0;

  if fOpen then
    begin
      fiwidth  := FrameWidth;
      fiheight := FrameHeight;
    end
  else
    begin
      fiwidth  := self.width;
      fiheight := self.height;
    end;

  if not Stretch and fCenter then
    begin
      fxstart := (self.width - fiwidth) div 2;
      fystart := (self.height - fiheight) div 2;
    end;

  if not Transparent then
    begin
      if fxstart > 0  then
        fxofs := 0
      else
        fxofs := fofs;

      if fystart > 0  then
        fyofs := 0
      else
        fyofs := fofs;
    end;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.StartDrawing;
begin
  fdrawing := true;
  fdrawcontrol := ZOrder;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.DrawFrameToDC(dc : THandle);
var
  memdc        : THandle;
  formdc       : THandle;
  image        : pointer;
  imagestart   : integer;
  bitmap       : THandle;
  fbitmap      : THandle;
  oldmemobject : THandle;
  oldfobject   : THandle;
  width        : integer;
  height       : integer;
  framenum     : integer;

begin
  if PaintDisabled then
    exit;

  if fTransparent and (fBackChanged or not fActive) then
    begin
      SaveBackGround;
      fBackChanged := false;
    end;

  StartDrawing;
  memdc := CreateCompatibleDC(dc);
  formdc := CreateCompatibleDC(dc);
  try
    framenum := fFrame;
    ValidateFrameNumber(framenum);
    image := AVIStreamGetFrame(fgetframe, framenum);
    CalcFrameLayout;

    if fStretch then
      begin
        width   := self.width;
        height  := self.height;
      end
    else
      begin
        width  := fiwidth;
        height := fiheight;
      end;

    imagestart := 0;

    if Assigned(image) then
      begin
        SetStretchBltMode(memdc, HALFTONE);
        imagestart := TBitmapInfoHeader(image^).biSize + TBitmapInfoHeader(image^).biClrUsed * 4;
      end;

    if fTransparent then
      begin
        bitmap := CreateCompatibleBitmap(dc, width, height);
        oldmemobject := SelectObject(memdc, bitmap);

        StretchDIBits(memdc, 0, 0, width, height, 0, 0, fiwidth, fiheight, pchar(image) + imagestart,
                  TBitmapInfo(image^), 0, SRCCOPY);

        fbitmap := CreateCompatibleBitmap(dc, self.width, self.height);
        oldfobject := SelectObject(formdc, fbitmap);

        BitBlt(formdc, 0, 0, self.width, self.height, ftempdc, 0, 0, SRCCOPY);

        if Assigned(image) then
          TransparentBitBlt(memdc, formdc, Rect(0, 0, width, height),
                            GetTransparentColor(memdc, Rect(0, 0, width - 1, height - 1)),
                            fxstart, fystart);

        BitBlt(dc, fofs, fofs, self.width - fofs * 2, self.height - fofs * 2, formdc, fofs, fofs, SRCCOPY);

        SelectObject(formdc, oldfobject);
        DeleteObject(fbitmap);
        SelectObject(memdc, oldmemobject);
        DeleteObject(bitmap);
      end
    else
      DrawDibDraw(hdrawdib, dc, fxstart, fystart, width - fxofs * 2, height - fyofs * 2,
                  image, pchar(image) + imagestart, 0, 0, fiwidth, fiheight, DDF_HALFTONE);

  finally
    DeleteDC(memdc);
    DeleteDC(formdc);
    fdrawing := false;
  end;
end;

{------------------------------------------------------------------}

function TDCAVIPlay.PaintDisabled : boolean;
begin
  result := fDrawing or ([csReading, csLoading] * ComponentState <> []) or (Parent = nil)
    or ([csReading, csLoading] * Parent.ComponentState <> [])
   or not HandleAllocated or not (visible or (csDesigning in ComponentState));
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.ShowFrame;
var
  dc           : THandle;
  brush        : THandle;
//  i            : integer;
//  r            : TRect;
begin
  if PaintDisabled then
     exit;

  if _dc = 0 then
    dc := GetDC(handle)
  else
    dc := _dc;

  if not (fTransparent or fOpen) then
    begin
      brush := CreateSolidBrush(ColorToRGB(Color));
      FillRect(dc, ClientRect, brush);
      DeleteObject(brush);
    end
  else
    DrawFrameToDC(dc);

  if _dc = 0 then
    ReleaseDC(handle, dc);

  ShowRect;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.UpdateFrameNumber;
begin
  if (fFrame >= fStopFrame) then
    begin
      if frepeatcount > 0 then
        begin
          dec(fRepeatCount);
          if fRepeatCount = 0 then
            begin
              Stop;
              exit;
            end;
        end;

      fFrame := fStartFrame - 1;
      PlayAudio(fStartFrame, fStopFrame);
    end;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.UpdateOtherAVIPlayers;
var
  r : TRect;
  i : integer;
begin
  with Parent do
    for i := ControlCount - 1 downto 0 do
      begin
        if (Controls[i] = self) then
          break;

        if (Controls[i].Visible) and (Controls[i] is TDCAVIPlay) then
          with TDCAVIPlay(Controls[i]) do
            if [csDestroying, csLoading] * ComponentState = [] then
              begin
                fbackchanged := true;
                r := ClientRect;
                InvalidateRect(Handle, @r, true);
              end;
      end;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.PlayNextFrame(var Msg : TMessage);
begin
  UpdateFrameNumber;
  inc(fFrame);
  if fActive and not fDrawing then
    begin
      ShowFrame;
      UpdateOtherAVIPlayers;
    end;  
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.SaveBackground;
var
  dc         : THandle;
  formdc     : THandle;
  oldfbitmap : THandle;
  fbitmap    : THandle;
  fdc        : THandle;
//  i          : integer;
begin
  if Parent = nil then
    exit;

  StartDrawing;
  dc := GetDC(handle);
  fdc := GetDC(parent.handle);
  formdc := CreateCompatibleDC(fdc);
  fbitmap := CreateCompatibleBitmap(fdc, parent.width, parent.height);
  oldfbitmap := SelectObject(formdc, fbitmap);

  if ftempdc = 0 then
    begin
      ftempdc := CreateCompatibleDC(dc);
      ftempbitmap := CreateCompatibleBitmap(dc, width, height);
      foldbitmap := SelectObject(ftempdc, ftempbitmap);
    end;

//  IntersectClipRect(formdc, left, top, left + width + 1, top + height + 1);

  with parent do
    PaintTo(formdc, 0, 0);

//  SetViewPortOrgEx(formDC, 0, 0, nil);
  BitBlt(ftempdc, 0, 0, width, height, formdc, left + 1, top + 1, SRCCOPY);
  SelectObject(formdc, oldfbitmap);
  DeleteObject(fbitmap);
  DeleteDC(formdc);
  ReleaseDC(Parent.Handle, fdc);
  ReleaseDC(handle, dc);

  fdrawing := false;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.WMPaint(var Msg : TWMPaint);
var
  ps : TPaintStruct;
begin
  _dc := Msg.DC;
  if _dc = 0 then
    _dc := BeginPaint(handle, ps);

  try
    Msg.result := 0;
    ShowFrame;

  finally
    if Msg.DC = 0 then
      EndPaint(handle, ps);
    _dc := 0;
  end;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.WMEraseBkgnd(var Msg : TMessage);
var
  brush        : THandle;
  r            : TRect;
  dc           : THandle;
  width        : integer;
  height       : integer;
begin
  if PaintDisabled then
     exit;

   if not (fTransparent or fStretch) then
     begin
       CalcFrameLayout;
       if fStretch then
         begin
           width   := self.width;
           height  := self.height;
         end
       else
         begin
           width  := fiwidth;
           height := fiheight;
         end;

       dc := GetDC(handle);
       brush := CreateSolidBrush(ColorToRGB(Color));
       r := rect(fofs, fofs, self.width, fystart);
       FillRect(dc, r, brush);

       r := rect(fofs, fystart, fxstart, self.height);
       FillRect(dc, r, brush);

       r := rect(fxstart, fystart + height, self.width - fofs * 2, self.height - fofs * 2);
       FillRect(dc, r, brush);

       r := rect(fxstart + width, fystart, self.width - fofs * 2, fystart + height);
       FillRect(dc, r, brush);

       DeleteObject(brush);
       ReleaseDC(handle, dc);
   end;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.WMMove (var Msg : TMessage);
begin
  inherited;
  fbackchanged := true;
  ShowFrame;
  UpdateOtherAVIPlayers;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.KillTempDC;
begin
  if ftempdc <> 0 then
    begin
      SelectObject(ftempdc, foldbitmap);
      DeleteObject(ftempbitmap);
      DeleteDC(ftempdc);
      ftempdc := 0;
    end;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.WMSize (var Msg : TMessage);
begin
  StartDrawing;
  KillTempDC;
  inherited;
  fBackChanged := true;
  fdrawing := false;
  AdjustControlsize;
  if not Active then
    ShowFrame;
  UpdateOtherAVIPlayers;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.ShowRect;
var
  DC        : THandle;
  Pen       : THandle;
  SavePen   : THandle;
  SaveBrush : THandle;
begin
  if not (csDesigning in ComponentState) then
    exit;

  dc := GetDC(Handle);
  Pen := CreatePen(PS_DOT, 1, clBlack);
  SavePen := SelectObject(dc, Pen);
  SaveBrush := SelectObject(dc, GetStockobject(HOLLOW_BRUSH));
  Rectangle(dc, 0, 0, width, height);
  SelectObject(DC, SavePen);
  DeleteObject(Pen);
  SelectObject(DC, SaveBrush);
  ReleaseDC(Handle, DC);
end;

{------------------------------------------------------------------}

var
  WHook : HHook;
  hooks : TList;

type TCWPStruct = packed record
    lParam  : LPARAM;
    wParam  : WPARAM;
    message : integer;
    wnd     : HWND;
end;

function CallWndProcHook(nCode : integer; wParam : Longint; var Msg : TCWPStruct) : longint; stdcall;
var
  i  : integer;
  r  : TRect;
  r2 : TRect;

  function IsPaintMsg : boolean;
  var
    c  : TWinControl;
  begin
    result := false;
    c := FindControl(msg.wnd);
    if (c <> nil) and not (c is TDCAVIPlay) and
       TDCAVIPlay(hooks[i]).HandleAllocated and
       (TDCAVIPlay(hooks[i]).owner = c.owner) or
       (TDCAVIPlay(hooks[i]).owner = c) then
          begin
            GetWindowRect(msg.wnd , r);
            GetWindowRect(TDCAVIPlay(hooks[i]).handle, r2);
            result := IntersectRect(r, r, r2);
          end;
  end;

begin
  Result := CallNextHookEx(WHook, nCode, wParam, Longint(@Msg));

  if ((msg.message > CN_BASE) and (msg.message < CN_BASE + 500)) or
      (msg.message = WM_PAINT) or (msg.message = WM_SIZE)
{ or     (msg.message = WM_ERASEBKGND)} then
    for i := 0 to hooks.Count - 1 do
      with TDCAVIPlay(hooks[i]) do
        if HandleAllocated and Transparent and IsPaintMsg then
          begin
            fbackchanged := true;
            r := ClientRect;
            InvalidateRect(Handle, @r, true);
          end;
end;

{------------------------------------------------------------------}

procedure AddHook(o : TDCAVIPlay);
begin
  if hooks.Count = 0 then
    WHook := SetWindowsHookEx(WH_CALLWNDPROC, @CallWndProcHook, 0, GetCurrentThreadId);
  hooks.Add(o);
end;

{------------------------------------------------------------------}

procedure RemoveHook(o : TDCAVIPlay);
begin
  hooks.Remove(o);
  if hooks.Count = 0 then
    UnHookWindowsHookEx(WHook);
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.HookWndProc;
begin
  AddHook(self);
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.UnHookWndProc;
begin
  RemoveHook(self);
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.Reset;
begin
  CloseFile;
  OpenFile;
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.DoOpen;
begin
  if Assigned(fOnOpen) then
    fOnOpen(self);
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.DoClose;
begin
  if Assigned(fOnClose) then
    fOnClose(self);
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.DoStart;
begin
  if Assigned(fOnStart) then
    fOnStart(self);
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.MMWOM_DONE(var M:TMessage);
begin
   faudioplay.AudioPlayMessage(PWAVEHDR(M.lParam));
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.DoStop;
begin
  if Assigned(fOnStop) then
    fOnStop(Self);
end;

{------------------------------------------------------------------}

procedure TDCAVIPlay.DisplayChange(var Msg : TMessage);
begin
  DrawDIBClose(hdrawdib);
  hdrawdib := DrawDIBOpen;
end;

{------------------------------------------------------}

destructor TAudioPlay.Destroy;
begin
  Stop;
  inherited;
end;

{--------------------------------------------------------------}

procedure TAudioPlay.AudioPlayMessage(W : PWAVEHDR);
begin
  waveOutUnprepareHeader(FWaveOut, W, sizeof(TWAVEHDR));
  FreeMem(W, FBufferSize + sizeof(TWAVEHDR));
  if FPlaying then
    FillBuffer;
end;

{--------------------------------------------------------------}

function TAudioPlay.FillBuffer : Boolean;
var
  AudioBuf      : PWAVEHDR;
  SamplesToPlay : integer;
  lRead         : integer;
begin
  Result := false;
  GetMem(AudioBuf, fBufferSize + sizeof(TWAVEHDR));
  with AudioBuf^ do
    begin
      dwuser  := integer(Self);
      dwFlags := WHDR_DONE;
      lpData  := pointer(integer(AudioBuf) + sizeof(TWAVEHDR));
      dwBufferLength := fBufferSize;
    end;
  if waveOutPrepareHeader(FWaveOut, AudioBuf,
                          sizeof(TWAVEHDR)) <> MMSYSERR_NOERROR then
    begin
      FreeMem(AudioBuf, fBufferSize + sizeof(TWAVEHDR));
      exit;
    end;

  SamplesToPlay := Min(fEnd - fCurrent, fBufferSize div fSampleSize);
  if SamplesToPlay > 0 then
    begin
      AVIStreamRead(fAvi, fCurrent, SamplesToPlay, AudioBuf.lpData,
                         fBufferSize, @AudioBuf.dwBufferLength, @lRead);
      if LRead = SamplesToPlay then
        begin
          inc(fCurrent, lRead);
          waveOutWrite(fWaveOut, AudioBuf, sizeof(TWAVEHDR));
        end;
    end;
  fPlaying := true;
  result := true;
end;

{--------------------------------------------------------------}

function  TAudioPlay.OpenDevice(W : HWND; pAvi : pointer) : boolean;
var
  strhdr   : TAVISTREAMINFO;
  lpFormat : pointer;
  cbFormat : longint;
begin
  result := false;
  fAVI := pAvi;
  AVIStreamInfo(pAvi, @StrHdr, sizeof(StrHdr));
  fSampleSize := StrHdr.dwSampleSize;
  if (fSampleSize <= 0) then
    exit;

  fBufferSize := Max(fSampleSize, cBufSize);
  AVIStreamFormatSize(pavi, 0, @cbFormat);
  GetMem(lpFormat, cbFormat);
  FillChar(lpFormat^, cbFormat, 0);
  AVIStreamReadFormat(pAvi, 0, lpFormat, @cbFormat);
  sndPlaySound(nil, 0);
  if waveOutOpen(@FWaveOut, WAVE_MAPPER, lpFormat,
                 W, 0, CALLBACK_WINDOW) = 0 then
   result := true;

  FreeMem(lpFormat, cbFormat);
end;

{--------------------------------------------------------------}

procedure TAudioPlay.Stop;
begin
  if fWaveOut <> 0 then
    begin
      FPlaying := false;
      waveOutReset(FWaveOut);
      waveOutClose(FWaveOut);
      fWaveOut := 0;
    end;
end;

{--------------------------------------------------------------}

function TAudioPlay.Play(W : HWND; pAvi : Pointer; lStart, lEnd : longint) : boolean;
var
  i : integer;
begin
  if fPlaying then
    Stop;

  Result := false;
  if lStart < 0 then
    lStart := AVIStreamStart(pavi);

  if lEnd < 0 then
    lEnd := AVIStreamEnd(pavi);

  if lStart >= lEnd then
    exit;

  if not OpenDevice(W, pAvi) then
    exit;

  waveOutPause(fWaveOut);
  fBegin := lStart;
  FCurrent := lStart;
  fEnd := lEnd;
  fPlaying := true;
  for i := 1 to CAheadBuffers do
    FillBuffer;

  waveOutRestart(FWaveOut);
  result := true;
end;

{******************************************************************}

procedure RunRegister;
begin

end;

{---------------------------------------------------------------------}

initialization
  RunRegister;
  hooks := TList.Create;
finalization
  if hooks.Count > 0 then
    UnHookWindowsHookEx(WHook);

  hooks.Free;
end.
