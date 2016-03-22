unit vgInterfaces;

// Модуль: "w:\common\components\rtl\external\VGScene\vgInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "vgInterfaces" MUID: (4D550C220363)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vgCustomObject
 , vgCustomCanvas
 , Classes
 , vgCustomResources
 , vgTypes
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , vgCustomBitmap
 , Messages
;

type
 IvgScene = interface
  ['{90B0431B-6C80-49C0-AD27-124E5D0CE4D6}']
  procedure AddObject(AObject: TvgCustomObject);
  procedure RemoveObject(AObject: TvgCustomObject);
  procedure BeginDrag;
  procedure BeginResize;
  procedure AddUpdateRect(const R: TvgRect);
  {$If Defined(vgDesign)}
  procedure InsertObject(const ClassName: AnsiString);
  {$IfEnd} // Defined(vgDesign)
  function GetActiveControl: TvgCustomObject;
  function GetDisableUpdate: Boolean;
  procedure SetDisableUpdate(Value: Boolean);
  {$If Defined(vgDesign)}
  function GetDesignTime: Boolean;
  {$IfEnd} // Defined(vgDesign)
  function GetCanvas: TvgCustomCanvas;
  function GetRoot: TvgCustomObject;
  function GetOwner: TComponent;
  function GetComponent: TComponent;
  function GetStyle: TvgCustomResources;
  procedure SetStyle(Value: TvgCustomResources);
  function GetTransparency: Boolean;
  procedure UpdateResource;
  procedure Notification(AComponent: TComponent;
   Operation: TOperation);
  {$If Defined(vgDesign)}
  function GetSelected: TvgCustomObject;
  {$IfEnd} // Defined(vgDesign)
  {$If Defined(vgDesign)}
  function GetDesignPlaceObject: TvgCustomObject;
  {$IfEnd} // Defined(vgDesign)
  function GetUpdateRectsCount: integer;
  function GetUpdateRect(Index: integer): TvgRect;
  procedure SetCaptured(Value: TvgCustomObject);
  function GetCaptured: TvgCustomObject;
  procedure SetFocused(Value: TvgCustomObject);
  function GetFocused: TvgCustomObject;
  {$If Defined(vgDesign)}
  procedure SetDesignRoot(Value: TvgCustomObject);
  {$IfEnd} // Defined(vgDesign)
  function GetMousePos: TvgPoint;
  function LocalToScreen(const Point: TvgPoint): TvgPoint;
  procedure BeginVCLDrag(Source: TObject;
   ABitmap: TvgCustomBitmap);
  {$If Defined(vgDesign)}
  procedure DoDesignSelect(AObject: TObject);
  {$IfEnd} // Defined(vgDesign)
  function GetAnimatedCaret: Boolean;
  function ShowKeyboardForControl(AObject: TvgCustomObject): Boolean;
  function HideKeyboardForControl(AObject: TvgCustomObject): Boolean;
  function DoTab(aControl: TControl;
   aShift: Boolean): Boolean;
  procedure SetFocus;
  procedure UnicodeKeyDown(var Key: Word;
   var Char: WideChar;
   Shift: TShiftState);
  function IsAcceptableControlForTabNavigation(aControl: TWinControl): Boolean;
  procedure FocusHook(aControl: TWinControl;
   aGot: Boolean);
  procedure ControlMessageHook(aControl: TWinControl;
   const aMessage: TMessage);
  function ScreenToLocal(const Point: TvgPoint): TvgPoint;
  function GetSceneControl: TControl;
 end;//IvgScene

 TOnPaintEvent = procedure(Sender: TObject;
  Canvas: TvgCustomCanvas;
  const ARect: TvgRect) of object;
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
