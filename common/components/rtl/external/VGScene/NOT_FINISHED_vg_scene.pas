unit NOT_FINISHED_vg_scene;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Модуль: "w:/common/components/rtl/external/VGScene/NOT_FINISHED_vg_scene.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VGScene::Impl::vg_scene
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\VGScene\vg_define.inc}

interface

{$If not defined(NoVGScene)}
uses
  Classes,
  vgVisualObject,
  vgPersistent,
  vgComponent,
  vgTypes,
  vgCustomResources,
  vgCustomCanvas,
  vgInterfaces,
  vgSceneList,
  vgGradientPoint,
  vgGradientPoints,
  vgScenePrim,
  vgObjectList,
  vgVisual,
  vgCustomObject,
  vgCustomBitmap
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  Messages
  ;

type
 TvgBrushStyle = (
   
 );//TvgBrushStyle

 TvgCustomScene = class(TvgScenePrim, IvgScene)
 private
 // private fields
   FChildren : TvgObjectList;
 protected
 // realized methods
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
 end;//TvgCustomScene

var
   ResourceList : TvgObjectList;

type
 TvgControl = class(TvgVisualObject)
 protected
 // protected fields
   fBindingObjects : TvgObjectList;
 protected
 // protected methods
   procedure ApplyStyle; virtual;
 end;//TvgControl

 TvgCanvas = class(TvgCustomCanvas)
 end;//TvgCanvas

 TvgResources = class(TvgCustomResources)
 private
 // private fields
   FSceneList : TvgSceneList;
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
 protected
 // property methods
   function pm_GetVisual: TvgVisual;
   procedure pm_SetVisual(aValue: TvgVisual);
 public
 // public properties
   property Visual: TvgVisual
     read pm_GetVisual
     write pm_SetVisual;
 end;//TvgBrush

 TvgBackground = class(TvgControl)
 end;//TvgBackground
procedure VgColorToStr;
   {* Сигнатура метода vgColorToStr }
procedure VgStrToColor;
   {* Сигнатура метода vgStrToColor }
procedure VgDoTab;
   {* Сигнатура метода vgDoTab }
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3ProcessMessagesManager,
  vg_extctrls,
  vg_services
  ;

type
 THackComponent = class(TComponent)
 end;//THackComponent

// start class TvgCustomScene

procedure TvgCustomScene.AddObject(AObject: TvgCustomObject);
//#UC START# *4D550CFB029F_4D54170F00D8_var*
//#UC END# *4D550CFB029F_4D54170F00D8_var*
begin
//#UC START# *4D550CFB029F_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550CFB029F_4D54170F00D8_impl*
end;//TvgCustomScene.AddObject

procedure TvgCustomScene.RemoveObject(AObject: TvgCustomObject);
//#UC START# *4D550D1300CE_4D54170F00D8_var*
//#UC END# *4D550D1300CE_4D54170F00D8_var*
begin
//#UC START# *4D550D1300CE_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550D1300CE_4D54170F00D8_impl*
end;//TvgCustomScene.RemoveObject

procedure TvgCustomScene.BeginDrag;
//#UC START# *4D550D1C01FC_4D54170F00D8_var*
//#UC END# *4D550D1C01FC_4D54170F00D8_var*
begin
//#UC START# *4D550D1C01FC_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550D1C01FC_4D54170F00D8_impl*
end;//TvgCustomScene.BeginDrag

procedure TvgCustomScene.BeginResize;
//#UC START# *4D550D2D0250_4D54170F00D8_var*
//#UC END# *4D550D2D0250_4D54170F00D8_var*
begin
//#UC START# *4D550D2D0250_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550D2D0250_4D54170F00D8_impl*
end;//TvgCustomScene.BeginResize

procedure TvgCustomScene.AddUpdateRect(const R: TvgRect);
//#UC START# *4D550D3C0043_4D54170F00D8_var*
//#UC END# *4D550D3C0043_4D54170F00D8_var*
begin
//#UC START# *4D550D3C0043_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550D3C0043_4D54170F00D8_impl*
end;//TvgCustomScene.AddUpdateRect

{$If defined(vgDesign) AND not defined(NoVGScene)}
procedure TvgCustomScene.InsertObject(const ClassName: AnsiString);
//#UC START# *4D550D4B00A9_4D54170F00D8_var*
//#UC END# *4D550D4B00A9_4D54170F00D8_var*
begin
//#UC START# *4D550D4B00A9_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550D4B00A9_4D54170F00D8_impl*
end;//TvgCustomScene.InsertObject
{$IfEnd} //vgDesign AND not NoVGScene

function TvgCustomScene.GetActiveControl: TvgCustomObject;
//#UC START# *4D550D5F0167_4D54170F00D8_var*
//#UC END# *4D550D5F0167_4D54170F00D8_var*
begin
//#UC START# *4D550D5F0167_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550D5F0167_4D54170F00D8_impl*
end;//TvgCustomScene.GetActiveControl

function TvgCustomScene.GetDisableUpdate: Boolean;
//#UC START# *4D550D6A0205_4D54170F00D8_var*
//#UC END# *4D550D6A0205_4D54170F00D8_var*
begin
//#UC START# *4D550D6A0205_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550D6A0205_4D54170F00D8_impl*
end;//TvgCustomScene.GetDisableUpdate

procedure TvgCustomScene.SetDisableUpdate(Value: Boolean);
//#UC START# *4D550D780131_4D54170F00D8_var*
//#UC END# *4D550D780131_4D54170F00D8_var*
begin
//#UC START# *4D550D780131_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550D780131_4D54170F00D8_impl*
end;//TvgCustomScene.SetDisableUpdate

{$If defined(vgDesign) AND not defined(NoVGScene)}
function TvgCustomScene.GetDesignTime: Boolean;
//#UC START# *4D550D94001B_4D54170F00D8_var*
//#UC END# *4D550D94001B_4D54170F00D8_var*
begin
//#UC START# *4D550D94001B_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550D94001B_4D54170F00D8_impl*
end;//TvgCustomScene.GetDesignTime
{$IfEnd} //vgDesign AND not NoVGScene

function TvgCustomScene.GetCanvas: TvgCustomCanvas;
//#UC START# *4D550DA002A9_4D54170F00D8_var*
//#UC END# *4D550DA002A9_4D54170F00D8_var*
begin
//#UC START# *4D550DA002A9_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550DA002A9_4D54170F00D8_impl*
end;//TvgCustomScene.GetCanvas

function TvgCustomScene.GetRoot: TvgCustomObject;
//#UC START# *4D550DB102FE_4D54170F00D8_var*
//#UC END# *4D550DB102FE_4D54170F00D8_var*
begin
//#UC START# *4D550DB102FE_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550DB102FE_4D54170F00D8_impl*
end;//TvgCustomScene.GetRoot

function TvgCustomScene.GetOwner: TComponent;
//#UC START# *4D550DBD026F_4D54170F00D8_var*
//#UC END# *4D550DBD026F_4D54170F00D8_var*
begin
//#UC START# *4D550DBD026F_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550DBD026F_4D54170F00D8_impl*
end;//TvgCustomScene.GetOwner

function TvgCustomScene.GetComponent: TComponent;
//#UC START# *4D550DCB00CC_4D54170F00D8_var*
//#UC END# *4D550DCB00CC_4D54170F00D8_var*
begin
//#UC START# *4D550DCB00CC_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550DCB00CC_4D54170F00D8_impl*
end;//TvgCustomScene.GetComponent

function TvgCustomScene.GetStyle: TvgCustomResources;
//#UC START# *4D550DDC0210_4D54170F00D8_var*
//#UC END# *4D550DDC0210_4D54170F00D8_var*
begin
//#UC START# *4D550DDC0210_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550DDC0210_4D54170F00D8_impl*
end;//TvgCustomScene.GetStyle

procedure TvgCustomScene.SetStyle(Value: TvgCustomResources);
//#UC START# *4D550DF103B0_4D54170F00D8_var*
//#UC END# *4D550DF103B0_4D54170F00D8_var*
begin
//#UC START# *4D550DF103B0_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550DF103B0_4D54170F00D8_impl*
end;//TvgCustomScene.SetStyle

function TvgCustomScene.GetTransparency: Boolean;
//#UC START# *4D550DFE00F6_4D54170F00D8_var*
//#UC END# *4D550DFE00F6_4D54170F00D8_var*
begin
//#UC START# *4D550DFE00F6_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550DFE00F6_4D54170F00D8_impl*
end;//TvgCustomScene.GetTransparency

procedure TvgCustomScene.UpdateResource;
//#UC START# *4D550E0F00A3_4D54170F00D8_var*
//#UC END# *4D550E0F00A3_4D54170F00D8_var*
begin
//#UC START# *4D550E0F00A3_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550E0F00A3_4D54170F00D8_impl*
end;//TvgCustomScene.UpdateResource

procedure TvgCustomScene.Notification(AComponent: TComponent;
  Operation: TOperation);
//#UC START# *4D550E1C03A3_4D54170F00D8_var*
//#UC END# *4D550E1C03A3_4D54170F00D8_var*
begin
//#UC START# *4D550E1C03A3_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550E1C03A3_4D54170F00D8_impl*
end;//TvgCustomScene.Notification

{$If defined(vgDesign) AND not defined(NoVGScene)}
function TvgCustomScene.GetSelected: TvgCustomObject;
//#UC START# *4D550E2B0389_4D54170F00D8_var*
//#UC END# *4D550E2B0389_4D54170F00D8_var*
begin
//#UC START# *4D550E2B0389_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550E2B0389_4D54170F00D8_impl*
end;//TvgCustomScene.GetSelected
{$IfEnd} //vgDesign AND not NoVGScene

{$If defined(vgDesign) AND not defined(NoVGScene)}
function TvgCustomScene.GetDesignPlaceObject: TvgCustomObject;
//#UC START# *4D550E380297_4D54170F00D8_var*
//#UC END# *4D550E380297_4D54170F00D8_var*
begin
//#UC START# *4D550E380297_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550E380297_4D54170F00D8_impl*
end;//TvgCustomScene.GetDesignPlaceObject
{$IfEnd} //vgDesign AND not NoVGScene

function TvgCustomScene.GetUpdateRectsCount: integer;
//#UC START# *4D550E470234_4D54170F00D8_var*
//#UC END# *4D550E470234_4D54170F00D8_var*
begin
//#UC START# *4D550E470234_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550E470234_4D54170F00D8_impl*
end;//TvgCustomScene.GetUpdateRectsCount

function TvgCustomScene.GetUpdateRect(Index: integer): TvgRect;
//#UC START# *4D550E5403DC_4D54170F00D8_var*
//#UC END# *4D550E5403DC_4D54170F00D8_var*
begin
//#UC START# *4D550E5403DC_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550E5403DC_4D54170F00D8_impl*
end;//TvgCustomScene.GetUpdateRect

procedure TvgCustomScene.SetCaptured(Value: TvgCustomObject);
//#UC START# *4D550E600298_4D54170F00D8_var*
//#UC END# *4D550E600298_4D54170F00D8_var*
begin
//#UC START# *4D550E600298_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550E600298_4D54170F00D8_impl*
end;//TvgCustomScene.SetCaptured

function TvgCustomScene.GetCaptured: TvgCustomObject;
//#UC START# *4D550E6B0247_4D54170F00D8_var*
//#UC END# *4D550E6B0247_4D54170F00D8_var*
begin
//#UC START# *4D550E6B0247_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550E6B0247_4D54170F00D8_impl*
end;//TvgCustomScene.GetCaptured

procedure TvgCustomScene.SetFocused(Value: TvgCustomObject);
//#UC START# *4D550E7901D5_4D54170F00D8_var*
//#UC END# *4D550E7901D5_4D54170F00D8_var*
begin
//#UC START# *4D550E7901D5_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550E7901D5_4D54170F00D8_impl*
end;//TvgCustomScene.SetFocused

function TvgCustomScene.GetFocused: TvgCustomObject;
//#UC START# *4D550E8703BA_4D54170F00D8_var*
//#UC END# *4D550E8703BA_4D54170F00D8_var*
begin
//#UC START# *4D550E8703BA_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550E8703BA_4D54170F00D8_impl*
end;//TvgCustomScene.GetFocused

{$If defined(vgDesign) AND not defined(NoVGScene)}
procedure TvgCustomScene.SetDesignRoot(Value: TvgCustomObject);
//#UC START# *4D550E990086_4D54170F00D8_var*
//#UC END# *4D550E990086_4D54170F00D8_var*
begin
//#UC START# *4D550E990086_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550E990086_4D54170F00D8_impl*
end;//TvgCustomScene.SetDesignRoot
{$IfEnd} //vgDesign AND not NoVGScene

function TvgCustomScene.GetMousePos: TvgPoint;
//#UC START# *4D550EA30324_4D54170F00D8_var*
//#UC END# *4D550EA30324_4D54170F00D8_var*
begin
//#UC START# *4D550EA30324_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550EA30324_4D54170F00D8_impl*
end;//TvgCustomScene.GetMousePos

function TvgCustomScene.LocalToScreen(const Point: TvgPoint): TvgPoint;
//#UC START# *4D550EB50056_4D54170F00D8_var*
//#UC END# *4D550EB50056_4D54170F00D8_var*
begin
//#UC START# *4D550EB50056_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550EB50056_4D54170F00D8_impl*
end;//TvgCustomScene.LocalToScreen

procedure TvgCustomScene.BeginVCLDrag(Source: TObject;
  ABitmap: TvgCustomBitmap);
//#UC START# *4D550EC50042_4D54170F00D8_var*
//#UC END# *4D550EC50042_4D54170F00D8_var*
begin
//#UC START# *4D550EC50042_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550EC50042_4D54170F00D8_impl*
end;//TvgCustomScene.BeginVCLDrag

{$If defined(vgDesign) AND not defined(NoVGScene)}
procedure TvgCustomScene.DoDesignSelect(AObject: TObject);
//#UC START# *4D550ED5014D_4D54170F00D8_var*
//#UC END# *4D550ED5014D_4D54170F00D8_var*
begin
//#UC START# *4D550ED5014D_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550ED5014D_4D54170F00D8_impl*
end;//TvgCustomScene.DoDesignSelect
{$IfEnd} //vgDesign AND not NoVGScene

function TvgCustomScene.GetAnimatedCaret: Boolean;
//#UC START# *4D550EE303DA_4D54170F00D8_var*
//#UC END# *4D550EE303DA_4D54170F00D8_var*
begin
//#UC START# *4D550EE303DA_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550EE303DA_4D54170F00D8_impl*
end;//TvgCustomScene.GetAnimatedCaret

function TvgCustomScene.ShowKeyboardForControl(AObject: TvgCustomObject): Boolean;
//#UC START# *4D550EF00002_4D54170F00D8_var*
//#UC END# *4D550EF00002_4D54170F00D8_var*
begin
//#UC START# *4D550EF00002_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550EF00002_4D54170F00D8_impl*
end;//TvgCustomScene.ShowKeyboardForControl

function TvgCustomScene.HideKeyboardForControl(AObject: TvgCustomObject): Boolean;
//#UC START# *4D550EFB034B_4D54170F00D8_var*
//#UC END# *4D550EFB034B_4D54170F00D8_var*
begin
//#UC START# *4D550EFB034B_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D550EFB034B_4D54170F00D8_impl*
end;//TvgCustomScene.HideKeyboardForControl

function TvgCustomScene.DoTab(aControl: TControl;
  aShift: Boolean): Boolean;
//#UC START# *4D5D02B90284_4D54170F00D8_var*
//#UC END# *4D5D02B90284_4D54170F00D8_var*
begin
//#UC START# *4D5D02B90284_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5D02B90284_4D54170F00D8_impl*
end;//TvgCustomScene.DoTab

procedure TvgCustomScene.SetFocus;
//#UC START# *4D5E7F6C0016_4D54170F00D8_var*
//#UC END# *4D5E7F6C0016_4D54170F00D8_var*
begin
//#UC START# *4D5E7F6C0016_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5E7F6C0016_4D54170F00D8_impl*
end;//TvgCustomScene.SetFocus

procedure TvgCustomScene.UnicodeKeyDown(var Key: Word;
  var Char: WideChar;
  Shift: TShiftState);
//#UC START# *4D5E7FD70051_4D54170F00D8_var*
//#UC END# *4D5E7FD70051_4D54170F00D8_var*
begin
//#UC START# *4D5E7FD70051_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5E7FD70051_4D54170F00D8_impl*
end;//TvgCustomScene.UnicodeKeyDown

function TvgCustomScene.IsAcceptableControlForTabNavigation(aControl: TWinControl): Boolean;
//#UC START# *4D6285E60219_4D54170F00D8_var*
//#UC END# *4D6285E60219_4D54170F00D8_var*
begin
//#UC START# *4D6285E60219_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D6285E60219_4D54170F00D8_impl*
end;//TvgCustomScene.IsAcceptableControlForTabNavigation

procedure TvgCustomScene.FocusHook(aControl: TWinControl;
  aGot: Boolean);
//#UC START# *4D8B889E03D0_4D54170F00D8_var*
//#UC END# *4D8B889E03D0_4D54170F00D8_var*
begin
//#UC START# *4D8B889E03D0_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D8B889E03D0_4D54170F00D8_impl*
end;//TvgCustomScene.FocusHook

procedure TvgCustomScene.ControlMessageHook(aControl: TWinControl;
  const aMessage: TMessage);
//#UC START# *4DA724DD0394_4D54170F00D8_var*
//#UC END# *4DA724DD0394_4D54170F00D8_var*
begin
//#UC START# *4DA724DD0394_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DA724DD0394_4D54170F00D8_impl*
end;//TvgCustomScene.ControlMessageHook

function TvgCustomScene.ScreenToLocal(const Point: TvgPoint): TvgPoint;
//#UC START# *533E81870210_4D54170F00D8_var*
//#UC END# *533E81870210_4D54170F00D8_var*
begin
//#UC START# *533E81870210_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *533E81870210_4D54170F00D8_impl*
end;//TvgCustomScene.ScreenToLocal

function TvgCustomScene.GetSceneControl: TControl;
//#UC START# *538DBFB202DE_4D54170F00D8_var*
//#UC END# *538DBFB202DE_4D54170F00D8_var*
begin
//#UC START# *538DBFB202DE_4D54170F00D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *538DBFB202DE_4D54170F00D8_impl*
end;//TvgCustomScene.GetSceneControl
// start class TvgControl

procedure TvgControl.ApplyStyle;
//#UC START# *4F90008B02C6_4D49560D0013_var*
//#UC END# *4F90008B02C6_4D49560D0013_var*
begin
//#UC START# *4F90008B02C6_4D49560D0013_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F90008B02C6_4D49560D0013_impl*
end;//TvgControl.ApplyStyle
// unit methods

procedure VgColorToStr;
//#UC START# *4D555FED002F_4CFE3E000371_var*
//#UC END# *4D555FED002F_4CFE3E000371_var*
begin
//#UC START# *4D555FED002F_4CFE3E000371_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D555FED002F_4CFE3E000371_impl*
end;//VgColorToStr

procedure VgStrToColor;
//#UC START# *4D555FFC0179_4CFE3E000371_var*
//#UC END# *4D555FFC0179_4CFE3E000371_var*
begin
//#UC START# *4D555FFC0179_4CFE3E000371_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D555FFC0179_4CFE3E000371_impl*
end;//VgStrToColor

procedure VgDoTab;
//#UC START# *4D5D148101F9_4CFE3E000371_var*
//#UC END# *4D5D148101F9_4CFE3E000371_var*
begin
//#UC START# *4D5D148101F9_4CFE3E000371_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5D148101F9_4CFE3E000371_impl*
end;//VgDoTab
// start class TvgBrush

function TvgBrush.pm_GetVisual: TvgVisual;
//#UC START# *4D5EB9AF02AE_4D5EB9810101get_var*
//#UC END# *4D5EB9AF02AE_4D5EB9810101get_var*
begin
//#UC START# *4D5EB9AF02AE_4D5EB9810101get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5EB9AF02AE_4D5EB9810101get_impl*
end;//TvgBrush.pm_GetVisual

procedure TvgBrush.pm_SetVisual(aValue: TvgVisual);
//#UC START# *4D5EB9AF02AE_4D5EB9810101set_var*
//#UC END# *4D5EB9AF02AE_4D5EB9810101set_var*
begin
//#UC START# *4D5EB9AF02AE_4D5EB9810101set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5EB9AF02AE_4D5EB9810101set_impl*
end;//TvgBrush.pm_SetVisual
{$IfEnd} //not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgCustomScene
 TtfwClassRef.Register(TvgCustomScene);
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgControl
 TtfwClassRef.Register(TvgControl);
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgScene
 TtfwClassRef.Register(TvgScene);
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgBackground
 TtfwClassRef.Register(TvgBackground);
{$IfEnd} //not NoScripts AND not NoVGScene

end.