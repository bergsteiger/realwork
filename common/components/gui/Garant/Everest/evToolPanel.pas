unit evToolPanel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evToolPanel.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::ToolPanel::evToolPanel
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Interfaces,
  vtPanel,
  evVisualInterfaces
  ;

type
 TevCustomToolPanel = class(TvtCustomPanel, IevToolWindow)
  {* базовый класс для инструментальных панелей }
 private
 // private fields
   f_Orientation : Tl3Orientation1;
    {* Поле для свойства Orientation}
 protected
 // property methods
   procedure pm_SetOrientation(aValue: Tl3Orientation1);
 protected
 // realized methods
   procedure Scroll(iD: Tl3Inch);
   procedure Invalidate;
     {* Сигнатура метода Invalidate }
   function pm_GetVisible: Boolean;
   procedure pm_SetVisible(aValue: Boolean);
 protected
 // protected methods
   procedure OrientationChanged; virtual;
     {* Сигнатура метода OrientationChanged }
 public
 // public methods
   procedure DoScroll(iD: Tl3Inch); virtual;
 public
 // public properties
   property Orientation: Tl3Orientation1
     read f_Orientation
     write pm_SetOrientation;
 end;//TevCustomToolPanel

implementation

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TevCustomToolPanel

procedure TevCustomToolPanel.OrientationChanged;
//#UC START# *547CB4C800EA_547CB3C6025E_var*
//#UC END# *547CB4C800EA_547CB3C6025E_var*
begin
//#UC START# *547CB4C800EA_547CB3C6025E_impl*
 Invalidate;
//#UC END# *547CB4C800EA_547CB3C6025E_impl*
end;//TevCustomToolPanel.OrientationChanged

procedure TevCustomToolPanel.DoScroll(iD: Tl3Inch);
//#UC START# *547CC36E00D5_547CB3C6025E_var*
//#UC END# *547CC36E00D5_547CB3C6025E_var*
begin
//#UC START# *547CC36E00D5_547CB3C6025E_impl*
//#UC END# *547CC36E00D5_547CB3C6025E_impl*
end;//TevCustomToolPanel.DoScroll

procedure TevCustomToolPanel.pm_SetOrientation(aValue: Tl3Orientation1);
//#UC START# *547CB49A021A_547CB3C6025Eset_var*
//#UC END# *547CB49A021A_547CB3C6025Eset_var*
begin
//#UC START# *547CB49A021A_547CB3C6025Eset_impl*
 if (f_Orientation <> aValue) then
 begin
  f_Orientation := aValue;
  case Orientation of
   ev_orHorizontal: Align := alTop;
   ev_orVertical: Align := alLeft;
  end;{Case Orientation}
  OrientationChanged;
 end;{f_Delta <> Value}
//#UC END# *547CB49A021A_547CB3C6025Eset_impl*
end;//TevCustomToolPanel.pm_SetOrientation

procedure TevCustomToolPanel.Scroll(iD: Tl3Inch);
//#UC START# *547CA089003C_547CB3C6025E_var*
//#UC END# *547CA089003C_547CB3C6025E_var*
begin
//#UC START# *547CA089003C_547CB3C6025E_impl*
 DoScroll(iD);
//#UC END# *547CA089003C_547CB3C6025E_impl*
end;//TevCustomToolPanel.Scroll

procedure TevCustomToolPanel.Invalidate;
//#UC START# *547CA0940115_547CB3C6025E_var*
//#UC END# *547CA0940115_547CB3C6025E_var*
begin
//#UC START# *547CA0940115_547CB3C6025E_impl*
 inherited Invalidate;
//#UC END# *547CA0940115_547CB3C6025E_impl*
end;//TevCustomToolPanel.Invalidate

function TevCustomToolPanel.pm_GetVisible: Boolean;
//#UC START# *547CA0B40252_547CB3C6025Eget_var*
//#UC END# *547CA0B40252_547CB3C6025Eget_var*
begin
//#UC START# *547CA0B40252_547CB3C6025Eget_impl*
 Result := Visible;
//#UC END# *547CA0B40252_547CB3C6025Eget_impl*
end;//TevCustomToolPanel.pm_GetVisible

procedure TevCustomToolPanel.pm_SetVisible(aValue: Boolean);
//#UC START# *547CA0B40252_547CB3C6025Eset_var*
//#UC END# *547CA0B40252_547CB3C6025Eset_var*
begin
//#UC START# *547CA0B40252_547CB3C6025Eset_impl*
 Visible := aValue;
//#UC END# *547CA0B40252_547CB3C6025Eset_impl*
end;//TevCustomToolPanel.pm_SetVisible

initialization
{$If not defined(NoScripts)}
// Регистрация TevCustomToolPanel
 TtfwClassRef.Register(TevCustomToolPanel);
{$IfEnd} //not NoScripts

end.