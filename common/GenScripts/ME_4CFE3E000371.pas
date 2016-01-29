unit vg_scene;

interface

uses
 l3IntfUses
 , vgScenePrim
 , vgInterfaces
 , vgObjectList
 , vgCustomObject
 , vgCustomCanvas
 , Classes
 , vgCustomResources
 , vgTypes
 , Controls
 , vgCustomBitmap
 , Messages
 , vgVisualObject
 , vgSceneList
 , vgComponent
 , vgGradientPoint
 , vgGradientPoints
 , vgPersistent
 , vgVisual
;

type
 TvgBrushStyle = (
 );//TvgBrushStyle
 
 TvgCustomScene = class(TvgScenePrim, IvgScene)
  procedure AddObject(AObject: TvgCustomObject);
  procedure RemoveObject(AObject: TvgCustomObject);
  procedure BeginDrag;
  procedure BeginResize;
  procedure AddUpdateRect(const R: TvgRect);
  procedure InsertObject(const ClassName: AnsiString);
  function GetActiveControl: TvgCustomObject;
  function GetDisableUpdate: Boolean;
  procedure SetDisableUpdate(Value: Boolean);
  function GetDesignTime: Boolean;
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
  function GetSelected: TvgCustomObject;
  function GetDesignPlaceObject: TvgCustomObject;
  function GetUpdateRectsCount: integer;
  function GetUpdateRect(Index: integer): TvgRect;
  procedure SetCaptured(Value: TvgCustomObject);
  function GetCaptured: TvgCustomObject;
  procedure SetFocused(Value: TvgCustomObject);
  function GetFocused: TvgCustomObject;
  procedure SetDesignRoot(Value: TvgCustomObject);
  function GetMousePos: TvgPoint;
  function LocalToScreen(const Point: TvgPoint): TvgPoint;
  procedure BeginVCLDrag(Source: TObject;
   ABitmap: TvgCustomBitmap);
  procedure DoDesignSelect(AObject: TObject);
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
 end;//TvgCustomScene
 
 TvgControl = class(TvgVisualObject)
  procedure ApplyStyle;
 end;//TvgControl
 
 TvgCanvas = class(TvgCustomCanvas)
 end;//TvgCanvas
 
 TvgResources = class(TvgCustomResources)
 end;//TvgResources
 
 TvgLang = class(TvgComponent)
 end;//TvgLang
 
 TvgDesigner = class(TvgComponent)
 end;//TvgDesigner
 
 TvgScene = class(TvgCustomScene)
 end;//TvgScene
 
 TvgRect = vgTypes.TvgRect;
 
 TvgPoint = vgTypes.TvgPoint;
 
 IvgScene = vgInterfaces.IvgScene;
 
 TvgColor = vgTypes.TvgColor;
 
 PvgColor = vgTypes.PvgColor;
 
 TvgGradientPoint = vgGradientPoint.TvgGradientPoint;
 
 TvgGradientPoints = vgGradientPoints.TvgGradientPoints;
 
 TvgBrush = class(TvgPersistent)
 end;//TvgBrush
 
 TvgBackground = class(TvgControl)
 end;//TvgBackground
 
implementation

uses
 l3ImplUses
 , vg_extctrls
 , vg_services
 , TtfwClassRef_Proxy
 , l3ProcessMessagesManager
;

type
 THackComponent = class(TComponent)
 end;//THackComponent
 
end.
