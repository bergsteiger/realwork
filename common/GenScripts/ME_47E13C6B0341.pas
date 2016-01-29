unit Forms;

interface

uses
 l3IntfUses
 , Classes
 , Controls
;

type
 TApplication = class(TComponent)
  {* TApplication is the type used for a GUI windowed application. }
 end;//TApplication
 
 TBorderStyle = (
 );//TBorderStyle
 
 TScrollingWinControl = class(TWinControl)
 end;//TScrollingWinControl
 
 TCloseAction = (
 );//TCloseAction
 
 TCustomForm = class(TScrollingWinControl)
  function ShowModal: Integer;
  procedure UpdateActions;
  procedure DoClose(var Action: TCloseAction);
  function CloseQuery: Boolean;
   {* CloseQuery is called automatically when an attempt is made to close the form. CloseQuery can allow the form to close by returning true, or prevent the form from closing by returning false.

As implemented in TCustomForm, CloseQuery polls any MDI children by calling their CloseQuery methods. If no child form aborts the close, CloseQuery then calls the OnCloseQuery event handler, if it exists, to determine if the close should be allowed. If no such event handler exists, CloseQuery returns true. }
  function NeedAutoScroll: Boolean;
  function IsRealInstance: Boolean;
  procedure DoShow;
  procedure CreateNew(AOwner: TComponent;
   Dummy: Integer);
 end;//TCustomForm
 
 TWindowState = (
  {* TWindowState indicates whether a form is maximized, minimized, or normally sized. }
  wsNormal
   {* The form is in its normal state (that is, neither minimized nor maximized). }
  , wsMinimized
   {* The form is minimized. }
  , wsMaximized
   {* The form is maximized. }
 );//TWindowState
 
 TScreen = class(TComponent)
  {* TScreen represents the state of the screen in which an application runs. }
 end;//TScreen
 
 // TApplication
 
 // TScrollingWinControl
 
 // TCustomForm
 
 // TForm
 
 TFormClass = class of TForm;
 
 TScrollBarKind = (
 );//TScrollBarKind
 
 TScrollBarInc = ;
 
 TCustomFrame = class
 end;//TCustomFrame
 
 TFrame = class(TCustomFrame)
 end;//TFrame
 
 TCloseQueryEvent = procedure(Sender: TObject;
  var CanClose: Boolean) of object;
 
 TScrollBox = class(TScrollingWinControl)
 end;//TScrollBox
 
 TCMHintShow = record
 end;//TCMHintShow
 
 TForm = class(TCustomForm)
 end;//TForm
 
 TBorderIcons = (
 );//TBorderIcons
 
 TFormBorderStyle = (
 );//TFormBorderStyle
 
 TFormStyle = (
 );//TFormStyle
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , ScrollingWinControlWordsPack
 , FormsProcessingPack
 , CustomFormProcessingPack
;

end.
