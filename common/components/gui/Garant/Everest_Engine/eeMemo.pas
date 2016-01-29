unit eeMemo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/eeMemo.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Everest Engine::Editor::TeeMemo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  evCustomMemo
  ;

type
//#UC START# *54C26D790097ci*
//#UC END# *54C26D790097ci*
//#UC START# *54C26D790097cit*
//#UC END# *54C26D790097cit*
 TeeCustomMemo = class(TevCustomMemo)
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
//#UC START# *54C26D790097publ*
   property NeedDefaultPopupMenu default false;
//#UC END# *54C26D790097publ*
 end;//TeeCustomMemo

 TBevelKind = Controls.TBevelKind;

//#UC START# *4AC5D3DB0371ci*
//#UC END# *4AC5D3DB0371ci*
//#UC START# *4AC5D3DB0371cit*
//#UC END# *4AC5D3DB0371cit*
 TeeMemo = class(TeeCustomMemo)
//#UC START# *4AC5D3DB0371publ*
  published
  // published properties
    property AutoSelect;
    property Canvas;
    property TextSource;
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Text;
    property Wrap;
    property NeedDefaultPopupMenu;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
//#UC END# *4AC5D3DB0371publ*
 end;//TeeMemo

implementation

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TeeCustomMemo

constructor TeeCustomMemo.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_54C26D790097_var*
//#UC END# *47D1602000C6_54C26D790097_var*
begin
//#UC START# *47D1602000C6_54C26D790097_impl*
 inherited;
 NeedDefaultPopupMenu := false;
//#UC END# *47D1602000C6_54C26D790097_impl*
end;//TeeCustomMemo.Create

//#UC START# *54C26D790097impl*
//#UC END# *54C26D790097impl*

//#UC START# *4AC5D3DB0371impl*
//#UC END# *4AC5D3DB0371impl*

initialization
{$If not defined(NoScripts)}
// Регистрация TeeCustomMemo
 TtfwClassRef.Register(TeeCustomMemo);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация TeeMemo
 TtfwClassRef.Register(TeeMemo);
{$IfEnd} //not NoScripts

end.