unit NOT_FINISHED_TB97;

// Модуль: "w:\common\components\rtl\external\tb97\NOT_FINISHED_TB97.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "TB97" MUID: (502889FF0054)

{$Include w:\common\components\rtl\external\tb97\TB97VER.INC}

interface

{$If NOT Defined(NoTB97)}
uses
 l3IntfUses
 , tb97Control
;

type
 TCustomToolWindow97 = class(Ttb97Control)
  protected
   procedure UpdateEmpty(aUpdateVisibility: Boolean = True); virtual;
   function NeedActivateMainForm: Boolean; virtual;
   procedure ActivateMainForm; virtual;
  public
   procedure BeginUpdate; virtual;
   procedure EndUpdate; virtual;
 end;//TCustomToolWindow97

 TDock97 = class(Ttb97Control)
  protected
   function SizeGripWidth: Integer; virtual;
 end;//TDock97
{$IfEnd} // NOT Defined(NoTB97)

implementation

{$If NOT Defined(NoTB97)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *502889FF0054impl_uses*
 //#UC END# *502889FF0054impl_uses*
;

procedure TCustomToolWindow97.UpdateEmpty(aUpdateVisibility: Boolean = True);
//#UC START# *5028A1220383_50288A3D023C_var*
//#UC END# *5028A1220383_50288A3D023C_var*
begin
//#UC START# *5028A1220383_50288A3D023C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5028A1220383_50288A3D023C_impl*
end;//TCustomToolWindow97.UpdateEmpty

procedure TCustomToolWindow97.BeginUpdate;
//#UC START# *5028A78000B6_50288A3D023C_var*
//#UC END# *5028A78000B6_50288A3D023C_var*
begin
//#UC START# *5028A78000B6_50288A3D023C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5028A78000B6_50288A3D023C_impl*
end;//TCustomToolWindow97.BeginUpdate

procedure TCustomToolWindow97.EndUpdate;
//#UC START# *5028A78B015A_50288A3D023C_var*
//#UC END# *5028A78B015A_50288A3D023C_var*
begin
//#UC START# *5028A78B015A_50288A3D023C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5028A78B015A_50288A3D023C_impl*
end;//TCustomToolWindow97.EndUpdate

function TCustomToolWindow97.NeedActivateMainForm: Boolean;
//#UC START# *552E0FD5016D_50288A3D023C_var*
//#UC END# *552E0FD5016D_50288A3D023C_var*
begin
//#UC START# *552E0FD5016D_50288A3D023C_impl*
 !!! Needs to be implemented !!!
//#UC END# *552E0FD5016D_50288A3D023C_impl*
end;//TCustomToolWindow97.NeedActivateMainForm

procedure TCustomToolWindow97.ActivateMainForm;
//#UC START# *552E10010067_50288A3D023C_var*
//#UC END# *552E10010067_50288A3D023C_var*
begin
//#UC START# *552E10010067_50288A3D023C_impl*
 !!! Needs to be implemented !!!
//#UC END# *552E10010067_50288A3D023C_impl*
end;//TCustomToolWindow97.ActivateMainForm

function TDock97.SizeGripWidth: Integer;
//#UC START# *5028DD25024B_5028DD12007F_var*
//#UC END# *5028DD25024B_5028DD12007F_var*
begin
//#UC START# *5028DD25024B_5028DD12007F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5028DD25024B_5028DD12007F_impl*
end;//TDock97.SizeGripWidth

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCustomToolWindow97);
 {* Регистрация TCustomToolWindow97 }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TDock97);
 {* Регистрация TDock97 }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoTB97)

end.
