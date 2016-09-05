unit evToolPanel;

// Модуль: "w:\common\components\gui\Garant\Everest\evToolPanel.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evToolPanel" MUID: (547CB3B5032B)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , vtPanel
 , evVisualInterfaces
 , l3Interfaces
;

type
 TevCustomToolPanel = class(TvtCustomPanel, IevToolWindow)
  {* базовый класс для инструментальных панелей }
  private
   f_Orientation: Tl3Orientation1;
  protected
   procedure pm_SetOrientation(aValue: Tl3Orientation1);
   procedure OrientationChanged; virtual;
   procedure Scroll(iD: Tl3Inch);
   procedure Invalidate;
   function pm_GetVisible: Boolean;
   procedure pm_SetVisible(aValue: Boolean);
  public
   procedure DoScroll(iD: Tl3Inch); virtual;
  public
   property Orientation: Tl3Orientation1
    read f_Orientation
    write pm_SetOrientation;
 end;//TevCustomToolPanel

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *547CB3B5032Bimpl_uses*
 //#UC END# *547CB3B5032Bimpl_uses*
;

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
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevCustomToolPanel);
 {* Регистрация TevCustomToolPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
