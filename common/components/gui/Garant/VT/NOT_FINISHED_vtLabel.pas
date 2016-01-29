unit NOT_FINISHED_vtLabel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Модуль: "w:/common/components/gui/Garant/VT/NOT_FINISHED_vtLabel.pas"
// Начат: 03.02.2012
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT::Labels::TvtLabel
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
  l3Interfaces,
  afwInterfaces,
  evdTypes,
  Messages,
  Controls,
  StdCtrls,
  l3GraphicControlCanvas,
  Classes,
  Types
  ;

type
 TvtDrawDirection = (
   ddHorizontal
 , ddVertical
 );//TvtDrawDirection

 {$Define _UnknownIsComponent}

//#UC START# *4F29240F0204ci*
//#UC END# *4F29240F0204ci*
 _l3Unknown_Parent_ = TCustomLabel;
{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 TvtCustomLabel = class(_l3Unknown_, IafwTextControl)
 private
 // private fields
   f_Canvas : Tl3GraphicControlCanvas;
   f_InAdjustBounds : Boolean;
 private
 // property fields
   f_EndEllipsis : Boolean;
   f_CCaption : Il3CString;
   f_VerticalAligment : TevVerticalAligment;
   f_DrawDirection : TvtDrawDirection;
   f_Caption : Tl3DString;
 private
 // private methods
   procedure WMGetText(var Msg: TMessage); message WM_GetText;
   procedure WMGetTextLength(var Msg: TMessage); message WM_GetTextLength;
   procedure WMSetText(var Msg: TMessage); message WM_SetText;
 protected
 // property methods
   procedure pm_SetEndEllipsis(aValue: Boolean);
   procedure pm_SetDrawDirection(aValue: TvtDrawDirection);
   function pm_GetCaption: Tl3DString; virtual;
   procedure pm_SetCaption(aValue: Tl3DString); virtual;
 protected
 // realized methods
   function pm_GetCCaption: IafwCString;
   procedure pm_SetCCaption(const aValue: IafwCString);
 protected
 // overridden protected methods
   function GetLabelText: String; override;
   procedure DoDrawText(var Rect: TRect;
    Flags: Integer); override;
   procedure SetBounds(ALeft: Integer;
    ATop: Integer;
    AWidth: Integer;
    AHeight: Integer); override;
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 protected
 // protected methods
   {$If defined(DesignTimeLibrary)}
   function CheckStamp(const aGUID: TGUID): Boolean;
   {$IfEnd} //DesignTimeLibrary
   function CaptionStored: Boolean;
     {* "Функция определяющая, что свойство Caption сохраняется" }
 public
 // public properties
   property EndEllipsis: Boolean
     read f_EndEllipsis
     write pm_SetEndEllipsis
     default False;
   property CCaption: Il3CString
     read f_CCaption
     write pm_SetCCaption;
   property VerticalAligment: TevVerticalAligment
     read f_VerticalAligment
     write f_VerticalAligment;
   property DrawDirection: TvtDrawDirection
     read f_DrawDirection
     write pm_SetDrawDirection;
   property Caption: Tl3DString
     read pm_GetCaption
     write pm_SetCaption
     stored CaptionStored;
//#UC START# *4F29240F0204publ*
 protected
   property ParentFont default False;
 protected
   {$I l3DefineCleanup.inc}
//#UC END# *4F29240F0204publ*
 end;//TvtCustomLabel

//#UC START# *4AE8541A01AEci*
//#UC END# *4AE8541A01AEci*
 TvtLabel = class(TvtCustomLabel)
//#UC START# *4AE8541A01AEpubl*
   published
     property Align;
     property Alignment;
     property Anchors;
     property AutoSize;
     property BiDiMode;
     property Caption;
     property Color nodefault;
     property Constraints;
     property DragCursor;
     property DragKind;
     property DragMode;
     property Enabled;
     property FocusControl;
     property Font;
     property ParentBiDiMode;
     property ParentColor;
     property ParentFont;
     property ParentShowHint;
     property PopupMenu;
     property ShowAccelChar;
     property ShowHint;
     property Transparent;
     property Layout;
     property Visible;
     property WordWrap;
     property EndEllipsis;
     property OnClick;
     property OnContextPopup;
     property OnDblClick;
     property OnDragDrop;
     property OnDragOver;
     property OnEndDock;
     property OnEndDrag;
     property OnMouseDown;
     property OnMouseMove;
     property OnMouseUp;
     property OnMouseEnter;
     property OnMouseLeave;
     property OnStartDock;
     property OnStartDrag;
     property DrawDirection;
//#UC END# *4AE8541A01AEpubl*
 end;//TvtLabel

implementation

uses
  l3String,
  afwVCL,
  Graphics,
  l3Types,
  SysUtils,
  l3Base,
  l3Core,
  Windows
  ;

type
  THackLink = class(TControlActionLink)
  end;//THackLink

type _Instance_R_ = TvtCustomLabel;
type _l3Unknown_R_ = TvtCustomLabel;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

// start class TvtCustomLabel

procedure TvtCustomLabel.pm_SetEndEllipsis(aValue: Boolean);
//#UC START# *4F2A579F0395_4F29240F0204set_var*
//#UC END# *4F2A579F0395_4F29240F0204set_var*
begin
//#UC START# *4F2A579F0395_4F29240F0204set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2A579F0395_4F29240F0204set_impl*
end;//TvtCustomLabel.pm_SetEndEllipsis

procedure TvtCustomLabel.pm_SetDrawDirection(aValue: TvtDrawDirection);
//#UC START# *4F29387A0298_4F29240F0204set_var*
//#UC END# *4F29387A0298_4F29240F0204set_var*
begin
//#UC START# *4F29387A0298_4F29240F0204set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F29387A0298_4F29240F0204set_impl*
end;//TvtCustomLabel.pm_SetDrawDirection

function TvtCustomLabel.pm_GetCaption: Tl3DString;
//#UC START# *4F2A554F01F4_4F29240F0204get_var*
//#UC END# *4F2A554F01F4_4F29240F0204get_var*
begin
//#UC START# *4F2A554F01F4_4F29240F0204get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2A554F01F4_4F29240F0204get_impl*
end;//TvtCustomLabel.pm_GetCaption

procedure TvtCustomLabel.pm_SetCaption(aValue: Tl3DString);
//#UC START# *4F2A554F01F4_4F29240F0204set_var*
//#UC END# *4F2A554F01F4_4F29240F0204set_var*
begin
//#UC START# *4F2A554F01F4_4F29240F0204set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2A554F01F4_4F29240F0204set_impl*
end;//TvtCustomLabel.pm_SetCaption

procedure TvtCustomLabel.WMGetText(var Msg: TMessage);
//#UC START# *4F2932F103B5_4F29240F0204_var*
//#UC END# *4F2932F103B5_4F29240F0204_var*
begin
//#UC START# *4F2932F103B5_4F29240F0204_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2932F103B5_4F29240F0204_impl*
end;//TvtCustomLabel.WMGetText

procedure TvtCustomLabel.WMGetTextLength(var Msg: TMessage);
//#UC START# *4F2933200190_4F29240F0204_var*
//#UC END# *4F2933200190_4F29240F0204_var*
begin
//#UC START# *4F2933200190_4F29240F0204_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2933200190_4F29240F0204_impl*
end;//TvtCustomLabel.WMGetTextLength

procedure TvtCustomLabel.WMSetText(var Msg: TMessage);
//#UC START# *4F293E2A012A_4F29240F0204_var*
//#UC END# *4F293E2A012A_4F29240F0204_var*
begin
//#UC START# *4F293E2A012A_4F29240F0204_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F293E2A012A_4F29240F0204_impl*
end;//TvtCustomLabel.WMSetText

{$If defined(DesignTimeLibrary)}
function TvtCustomLabel.CheckStamp(const aGUID: TGUID): Boolean;
//#UC START# *4F293EBE00D9_4F29240F0204_var*
//#UC END# *4F293EBE00D9_4F29240F0204_var*
begin
//#UC START# *4F293EBE00D9_4F29240F0204_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F293EBE00D9_4F29240F0204_impl*
end;//TvtCustomLabel.CheckStamp
{$IfEnd} //DesignTimeLibrary

function TvtCustomLabel.CaptionStored: Boolean;
//#UC START# *6B1BE297C357_4F29240F0204_var*
//#UC END# *6B1BE297C357_4F29240F0204_var*
begin
//#UC START# *6B1BE297C357_4F29240F0204_impl*
 !!! Needs to be implemented !!!
//#UC END# *6B1BE297C357_4F29240F0204_impl*
end;//TvtCustomLabel.CaptionStored

function TvtCustomLabel.pm_GetCCaption: IafwCString;
//#UC START# *473DAC05025F_4F29240F0204get_var*
//#UC END# *473DAC05025F_4F29240F0204get_var*
begin
//#UC START# *473DAC05025F_4F29240F0204get_impl*
 !!! Needs to be implemented !!!
//#UC END# *473DAC05025F_4F29240F0204get_impl*
end;//TvtCustomLabel.pm_GetCCaption

procedure TvtCustomLabel.pm_SetCCaption(const aValue: IafwCString);
//#UC START# *473DAC05025F_4F29240F0204set_var*
////#UC END# *473DAC05025F_4F29240F0204set_var*
begin
//#UC START# *473DAC05025F_4F29240F0204set_impl*
 !!! Needs to be implemented !!!
////#UC END# *473DAC05025F_4F29240F0204set_impl*
end;//TvtCustomLabel.pm_SetCCaption

constructor TvtCustomLabel.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4F29240F0204_var*
//#UC END# *47D1602000C6_4F29240F0204_var*
begin
//#UC START# *47D1602000C6_4F29240F0204_impl*
 !!! Needs to be implemented !!!
//#UC END# *47D1602000C6_4F29240F0204_impl*
end;//TvtCustomLabel.Create

function TvtCustomLabel.GetLabelText: String;
//#UC START# *4F2A45C40091_4F29240F0204_var*
//#UC END# *4F2A45C40091_4F29240F0204_var*
begin
//#UC START# *4F2A45C40091_4F29240F0204_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2A45C40091_4F29240F0204_impl*
end;//TvtCustomLabel.GetLabelText

procedure TvtCustomLabel.DoDrawText(var Rect: TRect;
  Flags: Integer);
//#UC START# *4F2A461702D8_4F29240F0204_var*
//#UC END# *4F2A461702D8_4F29240F0204_var*
begin
//#UC START# *4F2A461702D8_4F29240F0204_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2A461702D8_4F29240F0204_impl*
end;//TvtCustomLabel.DoDrawText

procedure TvtCustomLabel.SetBounds(ALeft: Integer;
  ATop: Integer;
  AWidth: Integer;
  AHeight: Integer);
//#UC START# *4F2A599E0283_4F29240F0204_var*
//#UC END# *4F2A599E0283_4F29240F0204_var*
begin
//#UC START# *4F2A599E0283_4F29240F0204_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2A599E0283_4F29240F0204_impl*
end;//TvtCustomLabel.SetBounds

//#UC START# *4F29240F0204impl*
type
 _Unknown_Child_ = _l3Unknown_R_;
{$I l3ImplCleanup.inc}
begin
 f_Text := nil;
 l3Free(f_Canvas);
 inherited;
end;
//#UC END# *4F29240F0204impl*

//#UC START# *4AE8541A01AEimpl*
//#UC END# *4AE8541A01AEimpl*

end.