unit NOT_FINISHED_tb97Ctls;

// Модуль: "w:\common\components\rtl\external\tb97\NOT_FINISHED_tb97Ctls.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "tb97Ctls" MUID: (4C43E892032F)

{$Include w:\common\components\rtl\external\tb97\TB97VER.INC}

interface

{$If NOT Defined(NoTB97)}
uses
 l3IntfUses
 , tb97GraphicControl
 , Types
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TCustomToolbarButton97 = class(Ttb97GraphicTextControl)
  protected
   function IsGtbToolbarButtonSizeNeeded: Boolean; virtual;
   function GetIsAutoCenter: Boolean; virtual;
   procedure CalcSize(var aSize: TSize); virtual;
   function NeedAutoDown: Boolean; virtual;
   function AutoAllUp: Boolean; virtual;
 end;//TCustomToolbarButton97

 TToolbarButton97 = class(TCustomToolbarButton97)
 end;//TToolbarButton97

 TCustomToolbarPanel97 = class(TCustomToolbarButton97)
 end;//TCustomToolbarPanel97

 TSizeGripPanel = class(TCustomToolbarPanel97)
  protected
   function GetFormToResize: TCustomForm; virtual;
 end;//TSizeGripPanel

 TToolbarButton97ActionLink = class({$If NOT Defined(NoVCL)}
 TControlActionLink
 {$IfEnd} // NOT Defined(NoVCL)
 )
 end;//TToolbarButton97ActionLink
{$IfEnd} // NOT Defined(NoTB97)

implementation

{$If NOT Defined(NoTB97)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tb97WordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TCustomToolbarButton97.IsGtbToolbarButtonSizeNeeded: Boolean;
//#UC START# *503DE82B0311_4F69EF8C027C_var*
//#UC END# *503DE82B0311_4F69EF8C027C_var*
begin
//#UC START# *503DE82B0311_4F69EF8C027C_impl*
 !!! Needs to be implemented !!!
//#UC END# *503DE82B0311_4F69EF8C027C_impl*
end;//TCustomToolbarButton97.IsGtbToolbarButtonSizeNeeded

function TCustomToolbarButton97.GetIsAutoCenter: Boolean;
//#UC START# *503E27CA010E_4F69EF8C027C_var*
//#UC END# *503E27CA010E_4F69EF8C027C_var*
begin
//#UC START# *503E27CA010E_4F69EF8C027C_impl*
 !!! Needs to be implemented !!!
//#UC END# *503E27CA010E_4F69EF8C027C_impl*
end;//TCustomToolbarButton97.GetIsAutoCenter

procedure TCustomToolbarButton97.CalcSize(var aSize: TSize);
//#UC START# *504779E00385_4F69EF8C027C_var*
//#UC END# *504779E00385_4F69EF8C027C_var*
begin
//#UC START# *504779E00385_4F69EF8C027C_impl*
 !!! Needs to be implemented !!!
//#UC END# *504779E00385_4F69EF8C027C_impl*
end;//TCustomToolbarButton97.CalcSize

function TCustomToolbarButton97.NeedAutoDown: Boolean;
//#UC START# *50477A430157_4F69EF8C027C_var*
//#UC END# *50477A430157_4F69EF8C027C_var*
begin
//#UC START# *50477A430157_4F69EF8C027C_impl*
 !!! Needs to be implemented !!!
//#UC END# *50477A430157_4F69EF8C027C_impl*
end;//TCustomToolbarButton97.NeedAutoDown

function TCustomToolbarButton97.AutoAllUp: Boolean;
//#UC START# *52A08B2C0001_4F69EF8C027C_var*
//#UC END# *52A08B2C0001_4F69EF8C027C_var*
begin
//#UC START# *52A08B2C0001_4F69EF8C027C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A08B2C0001_4F69EF8C027C_impl*
end;//TCustomToolbarButton97.AutoAllUp

function TSizeGripPanel.GetFormToResize: TCustomForm;
//#UC START# *53CE39CD0045_5058B6600074_var*
//#UC END# *53CE39CD0045_5058B6600074_var*
begin
//#UC START# *53CE39CD0045_5058B6600074_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CE39CD0045_5058B6600074_impl*
end;//TSizeGripPanel.GetFormToResize

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCustomToolbarButton97);
 {* Регистрация TCustomToolbarButton97 }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TToolbarButton97);
 {* Регистрация TToolbarButton97 }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCustomToolbarPanel97);
 {* Регистрация TCustomToolbarPanel97 }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TSizeGripPanel);
 {* Регистрация TSizeGripPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoTB97)

end.
