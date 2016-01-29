unit vcmDialogs;

interface

uses
 l3IntfUses
 , l3MessageID
 , Classes
 , Windows
 , Pl3StringIDExList
 , evCustomEditorWindow
 , Types
 , l3PrinterInterfaces
 , vcmMessageFormPrim
 , ExtCtrls
 , nevBase
 , Messages
 , Controls
 , Dialogs
 , vtVGButton
;

type
 TvtEffectiveDialogButton = class(TvtVGButton)
 end;//TvtEffectiveDialogButton
 
 TButtonWidths = array [TMsgDlgBtn] of integer;
 
 TMessageForm = class(TvcmMessageFormPrim)
  procedure SetCloseInterval(aCloseInterval: Integer);
  procedure HelpButtonClick(Sender: TObject);
  procedure evntOnCloseTimer(Sender: TObject);
  procedure evntOnClickFocusLabel(Sender: TObject);
  procedure UpdateAutoCloseButton;
  procedure SetAutoCloseButton(const Value: TvtEffectiveDialogButton);
  procedure TextSourceGetControlItemImg(aSender: TObject;
   const aControl: TnevControlInfo;
   out theImageInfo: TnevControlImageInfo);
  procedure DoAfterAdjustHeight(Sender: TObject;
   anOldHeight: Integer;
   aNewHeight: Integer);
  procedure CreateNewEx(aWndParent: HWND;
   AOwner: TComponent;
   Dummy: Integer);
 end;//TMessageForm
 
 TMessageFormClass = class of TMessageForm;
 
implementation

uses
 l3ImplUses
 , vtDialogsRes
 , vtVGSceneRes
 , vtF1InterfaceConst
 , vtDialogsResEx
 , vg_scene
 , afwAnswer
 , vcmMessagesSupport
 , SysUtils
 , vtCheckBox
 , afwFacade
 , l3BatchService
 , l3Interfaces
 , Forms
 , vtFocusLabel
 , l3Base
 , Graphics
 , l3String
 , vg_controls
 , StdCtrls
 , l3WinControlCanvas
 , l3FormCanvas
 , l3Math
 , l3MinMax
 , Cloak_Const
 , vg_objects
 , vtUtils
 , afwVCL
 , vcmInterfaces
 , TtfwClassRef_Proxy
 , nscSimpleEditorForDialogs
 , vtStdRes
;

end.
