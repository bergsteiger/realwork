unit vcmToolbar;

interface

uses
 l3IntfUses
 , Classes
 , TB97
 , TB97Tlbr
 , vcmUserControls
 , vcmControl
 , ComCtrls
 , Controls
 , ExtCtrls
 , Messages
 , vcmExternalInterfaces
 , Types
 , vcmLocalInterfaces
 , tb97Ctls
 , Forms
;

type
 TvcmDockDefPrim = class(TDock97)
 end;//TvcmDockDefPrim
 
 TvcmToolbarDef = class(TToolbar97)
  procedure vcmDeleteLastIfSeparator;
  procedure DeleteControls;
  procedure LockDock;
 end;//TvcmToolbarDef
 
 TvcmToolbarDockPanel = class;
 
 TvcmDockPanelButton = class;
 
 TvcmDockPanel = class(TvcmControl)
  function CreateMaximizedBtn(const aLink: IvcmFormHandler): TvcmDockPanelButton;
  function CreateCloseBtn(const aLink: IvcmFormHandler): TvcmDockPanelButton;
  function CreateOpenBtn(const aLink: IvcmFormHandler): TvcmDockPanelButton;
  function CheckLink(const aLink: IvcmFormHandler): Boolean;
  function CreateBtn(aImageIndex: Integer;
   const aLink: IvcmFormHandler;
   const aName: AnsiString): TvcmDockPanelButton;
  procedure SetDockBounds(var ALeft: Integer;
   var ATop: Integer;
   var AWidth: Integer;
   var AHeight: Integer);
  procedure CreateToolbar;
  procedure UpdateToolbarSize;
  procedure WMSize(var Message: TWMSize);
  procedure WMEraseBkgnd(var Message: TWMEraseBkgnd);
 end;//TvcmDockPanel
 
 TvcmDockDef = class(TvcmDockDefPrim, IvcmDock)
  procedure SetHandlers(const aMaximizedLink: IvcmFormHandler;
   const aOpenLink: IvcmFormHandler;
   const aCloseLink: IvcmFormHandler);
  procedure SetFasten(aFasten: Boolean);
  function Make(anOwner: TComponent;
   const aName: AnsiString;
   aPos: TvcmEffectiveToolBarPos): TvcmDockDef;
  function SizeGripValid: Boolean;
  procedure WMSize(var Message: TWMSize);
  procedure WMNCCalcSize(var Message: TWMNCCalcSize);
  procedure WMNCPaint(var Message: TMessage);
  procedure WMNChitTest(var Msg: TWMNCHitTest);
  function FullWidth: Integer;
   {* полная ширина dock-а toolbar-ов с учетом того, что dock может быть
           вставлен еще в какой-нибудь компонент }
  function FullHeight: Integer;
   {* полная высота dock-а toolbar-ов с учетом того, что dock может быть
           вставлен еще в какой-нибудь компонент }
  function Pos: TvcmEffectiveToolBarPos;
   {* позиция dock-а на форме }
 end;//TvcmDockDef
 
 TvcmSeparatorDef = class(TToolbarSep97)
 end;//TvcmSeparatorDef
 
 TvcmToolbarDockPanel = class(TCustomPanel)
  function Make(AOwner: TComponent;
   aDock: TvcmDockDef): TvcmToolbarDockPanel;
 end;//TvcmToolbarDockPanel
 
 TvcmDockPanelButton = class(TCustomToolbarButton97)
  function Make(aOwner: TComponent;
   const aLink: IvcmFormHandler;
   aDockPanel: TvcmDockPanel;
   const aName: AnsiString): TvcmDockPanelButton;
 end;//TvcmDockPanelButton
 
 TvcmToolbarOption = (
  vcm_toModulesInMainToolbar
  , vcm_toEntitiesInMainToolbar
  , vcm_toEntitiesInChildToolbar
 );//TvcmToolbarOption
 
 TvcmToolbarOptions = set of TvcmToolbarOption;
 
 TvcmToolbar = class(TvcmToolbarDef)
  procedure Create(anOwner: TComponent;
   aDock: TvcmDockDef);
 end;//TvcmToolbar
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Defaults
 , ToolWin
 , Graphics
 , vcmBase
 , Windows
 , vcmInternalConst
 , vcmInterfaces
 , afwDrawing
 , vcmToolbarUtils
 , afwInterfaces
 , afwFacade
 , TtfwClassRef_Proxy
 , vcmBaseMenuManager
 , vcmMenuManager
;

end.
