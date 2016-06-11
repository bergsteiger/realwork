{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.VideoView;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Media,
  Androidapi.JNI.Net,
  Androidapi.JNI.Util,
  Androidapi.JNI.Widget;

type
// ===== Forward declarations =====

  JMediaController = interface;//android.widget.MediaController
  JMediaController_MediaPlayerControl = interface;//android.widget.MediaController$MediaPlayerControl
  JVideoView = interface;//android.widget.VideoView

// ===== Interface declarations =====

  JMediaControllerClass = interface(JFrameLayoutClass)
    ['{DF006611-A831-4E6D-92EF-9D03B98C99E0}']
    {class} function init(context: JContext; attrs: JAttributeSet): JMediaController; cdecl; overload;
    {class} function init(context: JContext; useFastForward: Boolean): JMediaController; cdecl; overload;
    {class} function init(context: JContext): JMediaController; cdecl; overload;
  end;

  [JavaSignature('android/widget/MediaController')]
  JMediaController = interface(JFrameLayout)
    ['{18253CF1-90C2-43A0-A928-490468F4DD1A}']
    function dispatchKeyEvent(event: JKeyEvent): Boolean; cdecl;
    function getAccessibilityClassName: JCharSequence; cdecl;
    procedure hide; cdecl;
    function isShowing: Boolean; cdecl;
    procedure onFinishInflate; cdecl;
    function onTouchEvent(event: JMotionEvent): Boolean; cdecl;
    function onTrackballEvent(ev: JMotionEvent): Boolean; cdecl;
    procedure setAnchorView(view: JView); cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
    procedure setMediaPlayer(player: JMediaController_MediaPlayerControl); cdecl;
    procedure setPrevNextListeners(next: JView_OnClickListener; prev: JView_OnClickListener); cdecl;
    procedure show; cdecl; overload;
    procedure show(timeout: Integer); cdecl; overload;
  end;
  TJMediaController = class(TJavaGenericImport<JMediaControllerClass, JMediaController>) end;

  JMediaController_MediaPlayerControlClass = interface(IJavaClass)
    ['{31BC739A-5B96-48E4-B4D9-7486683FA117}']
  end;

  [JavaSignature('android/widget/MediaController$MediaPlayerControl')]
  JMediaController_MediaPlayerControl = interface(IJavaInstance)
    ['{57C4DECE-8BAC-4153-ACEB-919DF5FE6844}']
    function canPause: Boolean; cdecl;
    function canSeekBackward: Boolean; cdecl;
    function canSeekForward: Boolean; cdecl;
    function getAudioSessionId: Integer; cdecl;
    function getBufferPercentage: Integer; cdecl;
    function getCurrentPosition: Integer; cdecl;
    function getDuration: Integer; cdecl;
    function isPlaying: Boolean; cdecl;
    procedure pause; cdecl;
    procedure seekTo(pos: Integer); cdecl;
    procedure start; cdecl;
  end;
  TJMediaController_MediaPlayerControl = class(TJavaGenericImport<JMediaController_MediaPlayerControlClass, JMediaController_MediaPlayerControl>) end;

  JVideoViewClass = interface(JSurfaceViewClass)
    ['{E393C1DD-943D-4190-B984-25FF211E020F}']
    {class} function init(context: JContext): JVideoView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JVideoView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JVideoView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JVideoView; cdecl; overload;
  end;

  [JavaSignature('android/widget/VideoView')]
  JVideoView = interface(JSurfaceView)
    ['{03A73FEC-6252-431B-904E-67581CD109DF}']
    procedure addSubtitleSource(is_: JInputStream; format: JMediaFormat); cdecl;
    function canPause: Boolean; cdecl;
    function canSeekBackward: Boolean; cdecl;
    function canSeekForward: Boolean; cdecl;
    procedure draw(canvas: JCanvas); cdecl;
    function getAccessibilityClassName: JCharSequence; cdecl;
    function getAudioSessionId: Integer; cdecl;
    function getBufferPercentage: Integer; cdecl;
    function getCurrentPosition: Integer; cdecl;
    function getDuration: Integer; cdecl;
    function isPlaying: Boolean; cdecl;
    function onKeyDown(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function onTouchEvent(ev: JMotionEvent): Boolean; cdecl;
    function onTrackballEvent(ev: JMotionEvent): Boolean; cdecl;
    procedure pause; cdecl;
    function resolveAdjustedSize(desiredSize: Integer; measureSpec: Integer): Integer; cdecl;
    procedure resume; cdecl;
    procedure seekTo(msec: Integer); cdecl;
    procedure setMediaController(controller: JMediaController); cdecl;
    procedure setOnCompletionListener(l: JMediaPlayer_OnCompletionListener); cdecl;
    procedure setOnErrorListener(l: JMediaPlayer_OnErrorListener); cdecl;
    procedure setOnInfoListener(l: JMediaPlayer_OnInfoListener); cdecl;
    procedure setOnPreparedListener(l: JMediaPlayer_OnPreparedListener); cdecl;
    procedure setVideoPath(path: JString); cdecl;
    procedure setVideoURI(uri: Jnet_Uri); cdecl; overload;
    procedure setVideoURI(uri: Jnet_Uri; headers: JMap); cdecl; overload;
    procedure start; cdecl;
    procedure stopPlayback; cdecl;
    procedure suspend; cdecl;
  end;
  TJVideoView = class(TJavaGenericImport<JVideoViewClass, JVideoView>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.VideoView.JMediaController', TypeInfo(Androidapi.JNI.VideoView.JMediaController));
  TRegTypes.RegisterType('Androidapi.JNI.VideoView.JMediaController_MediaPlayerControl', TypeInfo(Androidapi.JNI.VideoView.JMediaController_MediaPlayerControl));
  TRegTypes.RegisterType('Androidapi.JNI.VideoView.JVideoView', TypeInfo(Androidapi.JNI.VideoView.JVideoView));
end;

initialization
  RegisterTypes;
end.


