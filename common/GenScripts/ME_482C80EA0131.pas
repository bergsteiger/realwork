unit AbstractDropDown;

interface

uses
 l3IntfUses
 , ctAbstractEdit
 , vcmExternalInterfaces
 , l3Interfaces
 , ctTypes
 , Classes
 , StdCtrls
 , Messages
 , Controls
 , Windows
 , ElUxTheme
;

type
 TAbstractDropDown = class(TctAbstractEdit, IvcmPopupIgnoresAction, Il3WndProcListener, Il3MouseListener)
  procedure DropDown;
  procedure ButtonClick(Sender: TObject);
  procedure TriggerDropCloseEvent(aDropped: Boolean);
  procedure DoWndProc(var Message: TMessage);
  function TranslateHomeEndToDropDown: Boolean;
  procedure DoSelect(aStart: Integer;
   aEnd: Integer);
  procedure DoMoveCursor(aIndex: Integer);
  procedure DoUnselect;
  procedure EscapePressed;
  procedure CloseUp;
  function GetActiveSub: TWinControl;
  procedure HideDropDown;
  procedure WMSetFocus(var Message: TWMSetFocus);
  procedure CNKeyDown(var Message: TWMKeyDown);
  procedure WMKillFocus(var Message: TWMKillFocus);
  procedure WMActivateApp(var Message: TWMActivateApp);
  procedure WMMouseWheel(var Msg: TWMMouseWheel);
  procedure CMEnabledChanged(var Msg: TMessage);
  procedure ELThemeChanged(var Message: TMessage);
  function PopupIgnoresAction: Boolean;
  procedure MouseListenerNotify(aMouseMessage: WPARAM;
   aHookStruct: PMouseHookStruct;
   var theResult: Tl3HookProcResult);
  procedure WndProcListenerNotify(Msg: PCWPStruct;
   var theResult: Tl3HookProcResult);
 end;//TAbstractDropDown
 
implementation

uses
 l3ImplUses
 , l3ListenersManager
 , nevTools
 , ElPopBtn
 , l3Bitmap
 , Graphics
 , ElVclUtils
 , l3Base
 , afwFacade
 , l3GetCaptureHelper
 , TtfwClassRef_Proxy
;

end.
