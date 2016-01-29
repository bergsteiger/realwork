unit vgInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/external/VGScene/vgInterfaces.pas"
// Начат: 11.02.2011 13:15
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::VGScene::vgInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VGScene\vg_define.inc}

interface

{$If not defined(NoVGScene)}
uses
  Messages,
  vgTypes,
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  vgCustomObject,
  vgCustomResources,
  vgCustomBitmap,
  vgCustomCanvas
  ;

type
 IvgScene = interface(IUnknown)
   ['{90B0431B-6C80-49C0-AD27-124E5D0CE4D6}']
   procedure AddObject(AObject: TvgCustomObject);
   procedure RemoveObject(AObject: TvgCustomObject);
   procedure BeginDrag;
   procedure BeginResize;
   procedure AddUpdateRect(const R: TvgRect);
   {$If defined(vgDesign) AND not defined(NoVGScene)}
   procedure InsertObject(const ClassName: AnsiString);
   {$IfEnd} //vgDesign AND not NoVGScene
   function GetActiveControl: TvgCustomObject;
   function GetDisableUpdate: Boolean;
   procedure SetDisableUpdate(Value: Boolean);
   {$If defined(vgDesign) AND not defined(NoVGScene)}
   function GetDesignTime: Boolean;
   {$IfEnd} //vgDesign AND not NoVGScene
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
   {$If defined(vgDesign) AND not defined(NoVGScene)}
   function GetSelected: TvgCustomObject;
   {$IfEnd} //vgDesign AND not NoVGScene
   {$If defined(vgDesign) AND not defined(NoVGScene)}
   function GetDesignPlaceObject: TvgCustomObject;
   {$IfEnd} //vgDesign AND not NoVGScene
   function GetUpdateRectsCount: integer;
   function GetUpdateRect(Index: integer): TvgRect;
   procedure SetCaptured(Value: TvgCustomObject);
   function GetCaptured: TvgCustomObject;
   procedure SetFocused(Value: TvgCustomObject);
   function GetFocused: TvgCustomObject;
   {$If defined(vgDesign) AND not defined(NoVGScene)}
   procedure SetDesignRoot(Value: TvgCustomObject);
   {$IfEnd} //vgDesign AND not NoVGScene
   function GetMousePos: TvgPoint;
   function LocalToScreen(const Point: TvgPoint): TvgPoint;
   procedure BeginVCLDrag(Source: TObject;
    ABitmap: TvgCustomBitmap);
   {$If defined(vgDesign) AND not defined(NoVGScene)}
   procedure DoDesignSelect(AObject: TObject);
   {$IfEnd} //vgDesign AND not NoVGScene
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

 TOnPaintEvent = procedure (Sender: TObject;
  Canvas: TvgCustomCanvas;
  const ARect: TvgRect) of object;
{$IfEnd} //not NoVGScene

implementation

end.