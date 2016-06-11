{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.InputMethodService;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os,
  Androidapi.JNI.Util,
  Androidapi.JNI.Widget;

type
// ===== Forward declarations =====

  JAbstractInputMethodService = interface;//android.inputmethodservice.AbstractInputMethodService
  JAbstractInputMethodService_AbstractInputMethodImpl = interface;//android.inputmethodservice.AbstractInputMethodService$AbstractInputMethodImpl
  JAbstractInputMethodService_AbstractInputMethodSessionImpl = interface;//android.inputmethodservice.AbstractInputMethodService$AbstractInputMethodSessionImpl
  JExtractEditText = interface;//android.inputmethodservice.ExtractEditText
  JInputMethodService = interface;//android.inputmethodservice.InputMethodService
  JInputMethodService_InputMethodImpl = interface;//android.inputmethodservice.InputMethodService$InputMethodImpl
  JInputMethodService_InputMethodSessionImpl = interface;//android.inputmethodservice.InputMethodService$InputMethodSessionImpl
  JInputMethodService_Insets = interface;//android.inputmethodservice.InputMethodService$Insets
  JKeyboard = interface;//android.inputmethodservice.Keyboard
  JKeyboard_Key = interface;//android.inputmethodservice.Keyboard$Key
  JKeyboard_Row = interface;//android.inputmethodservice.Keyboard$Row
  JKeyboardView = interface;//android.inputmethodservice.KeyboardView
  JKeyboardView_OnKeyboardActionListener = interface;//android.inputmethodservice.KeyboardView$OnKeyboardActionListener

// ===== Interface declarations =====

  JAbstractInputMethodServiceClass = interface(JServiceClass)
    ['{65936083-8001-4263-B08D-AF9EB3818754}']
    {class} function init: JAbstractInputMethodService; cdecl;
  end;

  [JavaSignature('android/inputmethodservice/AbstractInputMethodService')]
  JAbstractInputMethodService = interface(JService)
    ['{76A44416-D321-44FE-8DC9-CA4905BA14AF}']
    function getKeyDispatcherState: JKeyEvent_DispatcherState; cdecl;
    function onBind(intent: JIntent): JIBinder; cdecl;
    function onCreateInputMethodInterface: JAbstractInputMethodService_AbstractInputMethodImpl; cdecl;
    function onCreateInputMethodSessionInterface: JAbstractInputMethodService_AbstractInputMethodSessionImpl; cdecl;
    function onGenericMotionEvent(event: JMotionEvent): Boolean; cdecl;
    function onTrackballEvent(event: JMotionEvent): Boolean; cdecl;
  end;
  TJAbstractInputMethodService = class(TJavaGenericImport<JAbstractInputMethodServiceClass, JAbstractInputMethodService>) end;

  JAbstractInputMethodService_AbstractInputMethodImplClass = interface(JObjectClass)
    ['{59CB1E26-657A-4437-B964-FE56B62FFC5B}']
    {class} function init: JAbstractInputMethodService_AbstractInputMethodImpl; cdecl;
  end;

  [JavaSignature('android/inputmethodservice/AbstractInputMethodService$AbstractInputMethodImpl')]
  JAbstractInputMethodService_AbstractInputMethodImpl = interface(JObject)
    ['{4BA1739F-1C71-4182-B6C8-B4884FBA7F42}']
    procedure createSession(callback: JInputMethod_SessionCallback); cdecl;
    procedure revokeSession(session: JInputMethodSession); cdecl;
    procedure setSessionEnabled(session: JInputMethodSession; enabled: Boolean); cdecl;
  end;
  TJAbstractInputMethodService_AbstractInputMethodImpl = class(TJavaGenericImport<JAbstractInputMethodService_AbstractInputMethodImplClass, JAbstractInputMethodService_AbstractInputMethodImpl>) end;

  JAbstractInputMethodService_AbstractInputMethodSessionImplClass = interface(JObjectClass)
    ['{7E04E9F4-F218-4249-81A1-2A85C94750F9}']
    {class} function init: JAbstractInputMethodService_AbstractInputMethodSessionImpl; cdecl;
  end;

  [JavaSignature('android/inputmethodservice/AbstractInputMethodService$AbstractInputMethodSessionImpl')]
  JAbstractInputMethodService_AbstractInputMethodSessionImpl = interface(JObject)
    ['{32455BA6-922B-4AD4-BFBC-6E1305890C3B}']
    procedure dispatchGenericMotionEvent(seq: Integer; event: JMotionEvent; callback: JInputMethodSession_EventCallback); cdecl;
    procedure dispatchKeyEvent(seq: Integer; event: JKeyEvent; callback: JInputMethodSession_EventCallback); cdecl;
    procedure dispatchTrackballEvent(seq: Integer; event: JMotionEvent; callback: JInputMethodSession_EventCallback); cdecl;
    function isEnabled: Boolean; cdecl;
    function isRevoked: Boolean; cdecl;
    procedure revokeSelf; cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
  end;
  TJAbstractInputMethodService_AbstractInputMethodSessionImpl = class(TJavaGenericImport<JAbstractInputMethodService_AbstractInputMethodSessionImplClass, JAbstractInputMethodService_AbstractInputMethodSessionImpl>) end;

  JExtractEditTextClass = interface(JEditTextClass)
    ['{B369E49F-E699-4912-A4E6-BCBF578FFE74}']
    {class} function init(context: JContext): JExtractEditText; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JExtractEditText; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JExtractEditText; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JExtractEditText; cdecl; overload;
  end;

  [JavaSignature('android/inputmethodservice/ExtractEditText')]
  JExtractEditText = interface(JEditText)
    ['{09E89DEE-6973-47FE-8FC5-A68EB74B34F1}']
    procedure finishInternalChanges; cdecl;
    function hasFocus: Boolean; cdecl;
    function hasVerticalScrollBar: Boolean; cdecl;
    function hasWindowFocus: Boolean; cdecl;
    function isFocused: Boolean; cdecl;
    function isInputMethodTarget: Boolean; cdecl;
    function onTextContextMenuItem(id: Integer): Boolean; cdecl;
    function performClick: Boolean; cdecl;
    procedure setExtractedText(text: JExtractedText); cdecl;
    procedure startInternalChanges; cdecl;
  end;
  TJExtractEditText = class(TJavaGenericImport<JExtractEditTextClass, JExtractEditText>) end;

  JInputMethodServiceClass = interface(JAbstractInputMethodServiceClass)
    ['{7DE4CFF2-4B59-44A3-A3CA-1870175FF807}']
    {class} function _GetBACK_DISPOSITION_DEFAULT: Integer; cdecl;
    {class} function _GetBACK_DISPOSITION_WILL_DISMISS: Integer; cdecl;
    {class} function _GetBACK_DISPOSITION_WILL_NOT_DISMISS: Integer; cdecl;
    {class} function init: JInputMethodService; cdecl;
    {class} property BACK_DISPOSITION_DEFAULT: Integer read _GetBACK_DISPOSITION_DEFAULT;
    {class} property BACK_DISPOSITION_WILL_DISMISS: Integer read _GetBACK_DISPOSITION_WILL_DISMISS;
    {class} property BACK_DISPOSITION_WILL_NOT_DISMISS: Integer read _GetBACK_DISPOSITION_WILL_NOT_DISMISS;
  end;

  [JavaSignature('android/inputmethodservice/InputMethodService')]
  JInputMethodService = interface(JAbstractInputMethodService)
    ['{A0954F9A-CF37-4E9B-943F-AAA9A6828992}']
    function enableHardwareAcceleration: Boolean; cdecl;//Deprecated
    function getBackDisposition: Integer; cdecl;
    function getCandidatesHiddenVisibility: Integer; cdecl;
    function getCurrentInputBinding: JInputBinding; cdecl;
    function getCurrentInputConnection: JInputConnection; cdecl;
    function getCurrentInputEditorInfo: JEditorInfo; cdecl;
    function getCurrentInputStarted: Boolean; cdecl;
    function getInputMethodWindowRecommendedHeight: Integer; cdecl;
    function getLayoutInflater: JLayoutInflater; cdecl;
    function getMaxWidth: Integer; cdecl;
    function getTextForImeAction(imeOptions: Integer): JCharSequence; cdecl;
    function getWindow: JDialog; cdecl;
    procedure hideStatusIcon; cdecl;
    procedure hideWindow; cdecl;
    function isExtractViewShown: Boolean; cdecl;
    function isFullscreenMode: Boolean; cdecl;
    function isInputViewShown: Boolean; cdecl;
    function isShowInputRequested: Boolean; cdecl;
    procedure onAppPrivateCommand(action: JString; data: JBundle); cdecl;
    procedure onBindInput; cdecl;
    procedure onComputeInsets(outInsets: JInputMethodService_Insets); cdecl;
    procedure onConfigurationChanged(newConfig: JConfiguration); cdecl;
    procedure onConfigureWindow(win: JWindow; isFullscreen: Boolean; isCandidatesOnly: Boolean); cdecl;
    procedure onCreate; cdecl;
    function onCreateCandidatesView: JView; cdecl;
    function onCreateExtractTextView: JView; cdecl;
    function onCreateInputMethodInterface: JAbstractInputMethodService_AbstractInputMethodImpl; cdecl;
    function onCreateInputMethodSessionInterface: JAbstractInputMethodService_AbstractInputMethodSessionImpl; cdecl;
    function onCreateInputView: JView; cdecl;
    procedure onDestroy; cdecl;
    procedure onDisplayCompletions(completions: TJavaObjectArray<JCompletionInfo>); cdecl;
    function onEvaluateFullscreenMode: Boolean; cdecl;
    function onEvaluateInputViewShown: Boolean; cdecl;
    function onExtractTextContextMenuItem(id: Integer): Boolean; cdecl;
    procedure onExtractedCursorMovement(dx: Integer; dy: Integer); cdecl;
    procedure onExtractedSelectionChanged(start: Integer; end_: Integer); cdecl;
    procedure onExtractedTextClicked; cdecl;
    procedure onExtractingInputChanged(ei: JEditorInfo); cdecl;
    procedure onFinishCandidatesView(finishingInput: Boolean); cdecl;
    procedure onFinishInput; cdecl;
    procedure onFinishInputView(finishingInput: Boolean); cdecl;
    function onGenericMotionEvent(event: JMotionEvent): Boolean; cdecl;
    procedure onInitializeInterface; cdecl;
    function onKeyDown(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyLongPress(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyMultiple(keyCode: Integer; count: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyUp(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function onShowInputRequested(flags: Integer; configChange: Boolean): Boolean; cdecl;
    procedure onStartCandidatesView(info: JEditorInfo; restarting: Boolean); cdecl;
    procedure onStartInput(attribute: JEditorInfo; restarting: Boolean); cdecl;
    procedure onStartInputView(info: JEditorInfo; restarting: Boolean); cdecl;
    function onTrackballEvent(event: JMotionEvent): Boolean; cdecl;
    procedure onUnbindInput; cdecl;
    procedure onUpdateCursor(newCursor: JRect); cdecl;//Deprecated
    procedure onUpdateCursorAnchorInfo(cursorAnchorInfo: JCursorAnchorInfo); cdecl;
    procedure onUpdateExtractedText(token: Integer; text: JExtractedText); cdecl;
    procedure onUpdateExtractingViews(ei: JEditorInfo); cdecl;
    procedure onUpdateExtractingVisibility(ei: JEditorInfo); cdecl;
    procedure onUpdateSelection(oldSelStart: Integer; oldSelEnd: Integer; newSelStart: Integer; newSelEnd: Integer; candidatesStart: Integer; candidatesEnd: Integer); cdecl;
    procedure onViewClicked(focusChanged: Boolean); cdecl;
    procedure onWindowHidden; cdecl;
    procedure onWindowShown; cdecl;
    procedure requestHideSelf(flags: Integer); cdecl;
    function sendDefaultEditorAction(fromEnterKey: Boolean): Boolean; cdecl;
    procedure sendDownUpKeyEvents(keyEventCode: Integer); cdecl;
    procedure sendKeyChar(charCode: Char); cdecl;
    procedure setBackDisposition(disposition: Integer); cdecl;
    procedure setCandidatesView(view: JView); cdecl;
    procedure setCandidatesViewShown(shown: Boolean); cdecl;
    procedure setExtractView(view: JView); cdecl;
    procedure setExtractViewShown(shown: Boolean); cdecl;
    procedure setInputView(view: JView); cdecl;
    procedure setTheme(theme: Integer); cdecl;
    procedure showStatusIcon(iconResId: Integer); cdecl;
    procedure showWindow(showInput: Boolean); cdecl;
    procedure switchInputMethod(id: JString); cdecl;
    procedure updateFullscreenMode; cdecl;
    procedure updateInputViewShown; cdecl;
  end;
  TJInputMethodService = class(TJavaGenericImport<JInputMethodServiceClass, JInputMethodService>) end;

  JInputMethodService_InputMethodImplClass = interface(JAbstractInputMethodService_AbstractInputMethodImplClass)
    ['{BEDEA638-BFD1-4AB1-8875-09804265A5FE}']
    {class} function init: JInputMethodService_InputMethodImpl; cdecl;
  end;

  [JavaSignature('android/inputmethodservice/InputMethodService$InputMethodImpl')]
  JInputMethodService_InputMethodImpl = interface(JAbstractInputMethodService_AbstractInputMethodImpl)
    ['{84058E99-B0CE-4CE8-8B41-2723E697C4A9}']
    procedure attachToken(token: JIBinder); cdecl;
    procedure bindInput(binding: JInputBinding); cdecl;
    procedure changeInputMethodSubtype(subtype: JInputMethodSubtype); cdecl;
    procedure hideSoftInput(flags: Integer; resultReceiver: JResultReceiver); cdecl;
    procedure restartInput(ic: JInputConnection; attribute: JEditorInfo); cdecl;
    procedure showSoftInput(flags: Integer; resultReceiver: JResultReceiver); cdecl;
    procedure startInput(ic: JInputConnection; attribute: JEditorInfo); cdecl;
    procedure unbindInput; cdecl;
  end;
  TJInputMethodService_InputMethodImpl = class(TJavaGenericImport<JInputMethodService_InputMethodImplClass, JInputMethodService_InputMethodImpl>) end;

  JInputMethodService_InputMethodSessionImplClass = interface(JAbstractInputMethodService_AbstractInputMethodSessionImplClass)
    ['{54A7E06B-0E98-4B57-ADFF-353732851EBF}']
    {class} function init: JInputMethodService_InputMethodSessionImpl; cdecl;
  end;

  [JavaSignature('android/inputmethodservice/InputMethodService$InputMethodSessionImpl')]
  JInputMethodService_InputMethodSessionImpl = interface(JAbstractInputMethodService_AbstractInputMethodSessionImpl)
    ['{50561A9E-9EDD-44EC-9690-3CD9EA7E11EA}']
    procedure appPrivateCommand(action: JString; data: JBundle); cdecl;
    procedure displayCompletions(completions: TJavaObjectArray<JCompletionInfo>); cdecl;
    procedure finishInput; cdecl;
    procedure toggleSoftInput(showFlags: Integer; hideFlags: Integer); cdecl;
    procedure updateCursor(newCursor: JRect); cdecl;
    procedure updateCursorAnchorInfo(info: JCursorAnchorInfo); cdecl;
    procedure updateExtractedText(token: Integer; text: JExtractedText); cdecl;
    procedure updateSelection(oldSelStart: Integer; oldSelEnd: Integer; newSelStart: Integer; newSelEnd: Integer; candidatesStart: Integer; candidatesEnd: Integer); cdecl;
    procedure viewClicked(focusChanged: Boolean); cdecl;
  end;
  TJInputMethodService_InputMethodSessionImpl = class(TJavaGenericImport<JInputMethodService_InputMethodSessionImplClass, JInputMethodService_InputMethodSessionImpl>) end;

  JInputMethodService_InsetsClass = interface(JObjectClass)
    ['{F0ED3F1A-3152-4BCF-926B-57CBC40FCD5D}']
    {class} function _GetTOUCHABLE_INSETS_CONTENT: Integer; cdecl;
    {class} function _GetTOUCHABLE_INSETS_FRAME: Integer; cdecl;
    {class} function _GetTOUCHABLE_INSETS_REGION: Integer; cdecl;
    {class} function _GetTOUCHABLE_INSETS_VISIBLE: Integer; cdecl;
    {class} function init: JInputMethodService_Insets; cdecl;
    {class} property TOUCHABLE_INSETS_CONTENT: Integer read _GetTOUCHABLE_INSETS_CONTENT;
    {class} property TOUCHABLE_INSETS_FRAME: Integer read _GetTOUCHABLE_INSETS_FRAME;
    {class} property TOUCHABLE_INSETS_REGION: Integer read _GetTOUCHABLE_INSETS_REGION;
    {class} property TOUCHABLE_INSETS_VISIBLE: Integer read _GetTOUCHABLE_INSETS_VISIBLE;
  end;

  [JavaSignature('android/inputmethodservice/InputMethodService$Insets')]
  JInputMethodService_Insets = interface(JObject)
    ['{60F3EDB8-4C1B-411B-8466-7C849D07C475}']
    function _GetcontentTopInsets: Integer; cdecl;
    procedure _SetcontentTopInsets(Value: Integer); cdecl;
    function _GettouchableInsets: Integer; cdecl;
    procedure _SettouchableInsets(Value: Integer); cdecl;
    function _GettouchableRegion: JRegion; cdecl;
    function _GetvisibleTopInsets: Integer; cdecl;
    procedure _SetvisibleTopInsets(Value: Integer); cdecl;
    property contentTopInsets: Integer read _GetcontentTopInsets write _SetcontentTopInsets;
    property touchableInsets: Integer read _GettouchableInsets write _SettouchableInsets;
    property touchableRegion: JRegion read _GettouchableRegion;
    property visibleTopInsets: Integer read _GetvisibleTopInsets write _SetvisibleTopInsets;
  end;
  TJInputMethodService_Insets = class(TJavaGenericImport<JInputMethodService_InsetsClass, JInputMethodService_Insets>) end;

  JKeyboardClass = interface(JObjectClass)
    ['{91B42F2E-9703-4C17-AAEB-27B8D1E33E7C}']
    {class} function _GetEDGE_BOTTOM: Integer; cdecl;
    {class} function _GetEDGE_LEFT: Integer; cdecl;
    {class} function _GetEDGE_RIGHT: Integer; cdecl;
    {class} function _GetEDGE_TOP: Integer; cdecl;
    {class} function _GetKEYCODE_ALT: Integer; cdecl;
    {class} function _GetKEYCODE_CANCEL: Integer; cdecl;
    {class} function _GetKEYCODE_DELETE: Integer; cdecl;
    {class} function _GetKEYCODE_DONE: Integer; cdecl;
    {class} function _GetKEYCODE_MODE_CHANGE: Integer; cdecl;
    {class} function _GetKEYCODE_SHIFT: Integer; cdecl;
    {class} function init(context: JContext; xmlLayoutResId: Integer): JKeyboard; cdecl; overload;
    {class} function init(context: JContext; xmlLayoutResId: Integer; modeId: Integer; width: Integer; height: Integer): JKeyboard; cdecl; overload;
    {class} function init(context: JContext; xmlLayoutResId: Integer; modeId: Integer): JKeyboard; cdecl; overload;
    {class} function init(context: JContext; layoutTemplateResId: Integer; characters: JCharSequence; columns: Integer; horizontalPadding: Integer): JKeyboard; cdecl; overload;
    {class} property EDGE_BOTTOM: Integer read _GetEDGE_BOTTOM;
    {class} property EDGE_LEFT: Integer read _GetEDGE_LEFT;
    {class} property EDGE_RIGHT: Integer read _GetEDGE_RIGHT;
    {class} property EDGE_TOP: Integer read _GetEDGE_TOP;
    {class} property KEYCODE_ALT: Integer read _GetKEYCODE_ALT;
    {class} property KEYCODE_CANCEL: Integer read _GetKEYCODE_CANCEL;
    {class} property KEYCODE_DELETE: Integer read _GetKEYCODE_DELETE;
    {class} property KEYCODE_DONE: Integer read _GetKEYCODE_DONE;
    {class} property KEYCODE_MODE_CHANGE: Integer read _GetKEYCODE_MODE_CHANGE;
    {class} property KEYCODE_SHIFT: Integer read _GetKEYCODE_SHIFT;
  end;

  [JavaSignature('android/inputmethodservice/Keyboard')]
  JKeyboard = interface(JObject)
    ['{1E09EB21-68A8-4014-B9B5-3533B484F606}']
    function getHeight: Integer; cdecl;
    function getKeys: JList; cdecl;
    function getMinWidth: Integer; cdecl;
    function getModifierKeys: JList; cdecl;
    function getNearestKeys(x: Integer; y: Integer): TJavaArray<Integer>; cdecl;
    function getShiftKeyIndex: Integer; cdecl;
    function isShifted: Boolean; cdecl;
    function setShifted(shiftState: Boolean): Boolean; cdecl;
  end;
  TJKeyboard = class(TJavaGenericImport<JKeyboardClass, JKeyboard>) end;

  JKeyboard_KeyClass = interface(JObjectClass)
    ['{97E00498-38CE-40C5-BF50-AE916672F4EA}']
    {class} function init(parent: JKeyboard_Row): JKeyboard_Key; cdecl; overload;
    {class} function init(res: JResources; parent: JKeyboard_Row; x: Integer; y: Integer; parser: JXmlResourceParser): JKeyboard_Key; cdecl; overload;
  end;

  [JavaSignature('android/inputmethodservice/Keyboard$Key')]
  JKeyboard_Key = interface(JObject)
    ['{244EF65E-2ECB-404B-BAB5-F2354EFFCCEB}']
    function _Getcodes: TJavaArray<Integer>; cdecl;
    procedure _Setcodes(Value: TJavaArray<Integer>); cdecl;
    function _GetedgeFlags: Integer; cdecl;
    procedure _SetedgeFlags(Value: Integer); cdecl;
    function _Getgap: Integer; cdecl;
    procedure _Setgap(Value: Integer); cdecl;
    function _Getheight: Integer; cdecl;
    procedure _Setheight(Value: Integer); cdecl;
    function _Geticon: JDrawable; cdecl;
    procedure _Seticon(Value: JDrawable); cdecl;
    function _GeticonPreview: JDrawable; cdecl;
    procedure _SeticonPreview(Value: JDrawable); cdecl;
    function _Getlabel: JCharSequence; cdecl;
    procedure _Setlabel(Value: JCharSequence); cdecl;
    function _Getmodifier: Boolean; cdecl;
    procedure _Setmodifier(Value: Boolean); cdecl;
    function _Geton: Boolean; cdecl;
    procedure _Seton(Value: Boolean); cdecl;
    function _GetpopupCharacters: JCharSequence; cdecl;
    procedure _SetpopupCharacters(Value: JCharSequence); cdecl;
    function _GetpopupResId: Integer; cdecl;
    procedure _SetpopupResId(Value: Integer); cdecl;
    function _Getpressed: Boolean; cdecl;
    procedure _Setpressed(Value: Boolean); cdecl;
    function _Getrepeatable: Boolean; cdecl;
    procedure _Setrepeatable(Value: Boolean); cdecl;
    function _Getsticky: Boolean; cdecl;
    procedure _Setsticky(Value: Boolean); cdecl;
    function _Gettext: JCharSequence; cdecl;
    procedure _Settext(Value: JCharSequence); cdecl;
    function _Getwidth: Integer; cdecl;
    procedure _Setwidth(Value: Integer); cdecl;
    function _Getx: Integer; cdecl;
    procedure _Setx(Value: Integer); cdecl;
    function _Gety: Integer; cdecl;
    procedure _Sety(Value: Integer); cdecl;
    function getCurrentDrawableState: TJavaArray<Integer>; cdecl;
    function isInside(x: Integer; y: Integer): Boolean; cdecl;
    procedure onPressed; cdecl;
    procedure onReleased(inside: Boolean); cdecl;
    function squaredDistanceFrom(x: Integer; y: Integer): Integer; cdecl;
    property codes: TJavaArray<Integer> read _Getcodes write _Setcodes;
    property edgeFlags: Integer read _GetedgeFlags write _SetedgeFlags;
    property gap: Integer read _Getgap write _Setgap;
    property height: Integer read _Getheight write _Setheight;
    property icon: JDrawable read _Geticon write _Seticon;
    property iconPreview: JDrawable read _GeticonPreview write _SeticonPreview;
    property &label: JCharSequence read _Getlabel write _Setlabel;
    property modifier: Boolean read _Getmodifier write _Setmodifier;
    property on: Boolean read _Geton write _Seton;
    property popupCharacters: JCharSequence read _GetpopupCharacters write _SetpopupCharacters;
    property popupResId: Integer read _GetpopupResId write _SetpopupResId;
    property pressed: Boolean read _Getpressed write _Setpressed;
    property repeatable: Boolean read _Getrepeatable write _Setrepeatable;
    property sticky: Boolean read _Getsticky write _Setsticky;
    property text: JCharSequence read _Gettext write _Settext;
    property width: Integer read _Getwidth write _Setwidth;
    property x: Integer read _Getx write _Setx;
    property y: Integer read _Gety write _Sety;
  end;
  TJKeyboard_Key = class(TJavaGenericImport<JKeyboard_KeyClass, JKeyboard_Key>) end;

  JKeyboard_RowClass = interface(JObjectClass)
    ['{70EFB31D-C849-4E18-B877-4FA6FF21C9C0}']
    {class} function init(parent: JKeyboard): JKeyboard_Row; cdecl; overload;
    {class} function init(res: JResources; parent: JKeyboard; parser: JXmlResourceParser): JKeyboard_Row; cdecl; overload;
  end;

  [JavaSignature('android/inputmethodservice/Keyboard$Row')]
  JKeyboard_Row = interface(JObject)
    ['{1D90FE86-1727-42D8-8C2A-1AF5306F4208}']
    function _GetdefaultHeight: Integer; cdecl;
    procedure _SetdefaultHeight(Value: Integer); cdecl;
    function _GetdefaultHorizontalGap: Integer; cdecl;
    procedure _SetdefaultHorizontalGap(Value: Integer); cdecl;
    function _GetdefaultWidth: Integer; cdecl;
    procedure _SetdefaultWidth(Value: Integer); cdecl;
    function _Getmode: Integer; cdecl;
    procedure _Setmode(Value: Integer); cdecl;
    function _GetrowEdgeFlags: Integer; cdecl;
    procedure _SetrowEdgeFlags(Value: Integer); cdecl;
    function _GetverticalGap: Integer; cdecl;
    procedure _SetverticalGap(Value: Integer); cdecl;
    property defaultHeight: Integer read _GetdefaultHeight write _SetdefaultHeight;
    property defaultHorizontalGap: Integer read _GetdefaultHorizontalGap write _SetdefaultHorizontalGap;
    property defaultWidth: Integer read _GetdefaultWidth write _SetdefaultWidth;
    property mode: Integer read _Getmode write _Setmode;
    property rowEdgeFlags: Integer read _GetrowEdgeFlags write _SetrowEdgeFlags;
    property verticalGap: Integer read _GetverticalGap write _SetverticalGap;
  end;
  TJKeyboard_Row = class(TJavaGenericImport<JKeyboard_RowClass, JKeyboard_Row>) end;

  JKeyboardViewClass = interface(JViewClass)
    ['{42940038-508B-45EF-A693-06F5A4FD13A7}']
    {class} function init(context: JContext; attrs: JAttributeSet): JKeyboardView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JKeyboardView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JKeyboardView; cdecl; overload;
  end;

  [JavaSignature('android/inputmethodservice/KeyboardView')]
  JKeyboardView = interface(JView)
    ['{E1D3273B-0921-4ADA-BF8E-6CDAB5D52F52}']
    procedure closing; cdecl;
    function getKeyboard: JKeyboard; cdecl;
    function handleBack: Boolean; cdecl;
    procedure invalidateAllKeys; cdecl;
    procedure invalidateKey(keyIndex: Integer); cdecl;
    function isPreviewEnabled: Boolean; cdecl;
    function isProximityCorrectionEnabled: Boolean; cdecl;
    function isShifted: Boolean; cdecl;
    procedure onDetachedFromWindow; cdecl;
    procedure onDraw(canvas: JCanvas); cdecl;
    function onHoverEvent(event: JMotionEvent): Boolean; cdecl;
    procedure onMeasure(widthMeasureSpec: Integer; heightMeasureSpec: Integer); cdecl;
    procedure onSizeChanged(w: Integer; h: Integer; oldw: Integer; oldh: Integer); cdecl;
    function onTouchEvent(me: JMotionEvent): Boolean; cdecl;
    procedure setKeyboard(keyboard: JKeyboard); cdecl;
    procedure setOnKeyboardActionListener(listener: JKeyboardView_OnKeyboardActionListener); cdecl;
    procedure setPopupOffset(x: Integer; y: Integer); cdecl;
    procedure setPopupParent(v: JView); cdecl;
    procedure setPreviewEnabled(previewEnabled: Boolean); cdecl;
    procedure setProximityCorrectionEnabled(enabled: Boolean); cdecl;
    function setShifted(shifted: Boolean): Boolean; cdecl;
    procedure setVerticalCorrection(verticalOffset: Integer); cdecl;
  end;
  TJKeyboardView = class(TJavaGenericImport<JKeyboardViewClass, JKeyboardView>) end;

  JKeyboardView_OnKeyboardActionListenerClass = interface(IJavaClass)
    ['{6236A842-C447-47FA-8A41-5EADA3BDCF4B}']
  end;

  [JavaSignature('android/inputmethodservice/KeyboardView$OnKeyboardActionListener')]
  JKeyboardView_OnKeyboardActionListener = interface(IJavaInstance)
    ['{5EA363D7-B77D-49A3-B54B-5DA8FAE2CD75}']
    procedure onKey(primaryCode: Integer; keyCodes: TJavaArray<Integer>); cdecl;
    procedure onPress(primaryCode: Integer); cdecl;
    procedure onRelease(primaryCode: Integer); cdecl;
    procedure onText(text: JCharSequence); cdecl;
    procedure swipeDown; cdecl;
    procedure swipeLeft; cdecl;
    procedure swipeRight; cdecl;
    procedure swipeUp; cdecl;
  end;
  TJKeyboardView_OnKeyboardActionListener = class(TJavaGenericImport<JKeyboardView_OnKeyboardActionListenerClass, JKeyboardView_OnKeyboardActionListener>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.InputMethodService.JAbstractInputMethodService', TypeInfo(Androidapi.JNI.InputMethodService.JAbstractInputMethodService));
  TRegTypes.RegisterType('Androidapi.JNI.InputMethodService.JAbstractInputMethodService_AbstractInputMethodImpl', TypeInfo(Androidapi.JNI.InputMethodService.JAbstractInputMethodService_AbstractInputMethodImpl));
  TRegTypes.RegisterType('Androidapi.JNI.InputMethodService.JAbstractInputMethodService_AbstractInputMethodSessionImpl', TypeInfo(Androidapi.JNI.InputMethodService.JAbstractInputMethodService_AbstractInputMethodSessionImpl));
  TRegTypes.RegisterType('Androidapi.JNI.InputMethodService.JExtractEditText', TypeInfo(Androidapi.JNI.InputMethodService.JExtractEditText));
  TRegTypes.RegisterType('Androidapi.JNI.InputMethodService.JInputMethodService', TypeInfo(Androidapi.JNI.InputMethodService.JInputMethodService));
  TRegTypes.RegisterType('Androidapi.JNI.InputMethodService.JInputMethodService_InputMethodImpl', TypeInfo(Androidapi.JNI.InputMethodService.JInputMethodService_InputMethodImpl));
  TRegTypes.RegisterType('Androidapi.JNI.InputMethodService.JInputMethodService_InputMethodSessionImpl', TypeInfo(Androidapi.JNI.InputMethodService.JInputMethodService_InputMethodSessionImpl));
  TRegTypes.RegisterType('Androidapi.JNI.InputMethodService.JInputMethodService_Insets', TypeInfo(Androidapi.JNI.InputMethodService.JInputMethodService_Insets));
  TRegTypes.RegisterType('Androidapi.JNI.InputMethodService.JKeyboard', TypeInfo(Androidapi.JNI.InputMethodService.JKeyboard));
  TRegTypes.RegisterType('Androidapi.JNI.InputMethodService.JKeyboard_Key', TypeInfo(Androidapi.JNI.InputMethodService.JKeyboard_Key));
  TRegTypes.RegisterType('Androidapi.JNI.InputMethodService.JKeyboard_Row', TypeInfo(Androidapi.JNI.InputMethodService.JKeyboard_Row));
  TRegTypes.RegisterType('Androidapi.JNI.InputMethodService.JKeyboardView', TypeInfo(Androidapi.JNI.InputMethodService.JKeyboardView));
  TRegTypes.RegisterType('Androidapi.JNI.InputMethodService.JKeyboardView_OnKeyboardActionListener', TypeInfo(Androidapi.JNI.InputMethodService.JKeyboardView_OnKeyboardActionListener));
end;

initialization
  RegisterTypes;
end.


