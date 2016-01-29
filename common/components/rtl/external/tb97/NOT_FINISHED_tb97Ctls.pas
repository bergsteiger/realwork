unit NOT_FINISHED_tb97Ctls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "tb97"
// Модуль: "w:/common/components/rtl/external/tb97/NOT_FINISHED_tb97Ctls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::tb97::Buttons::tb97Ctls
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\tb97\TB97VER.INC}

interface

{$If not defined(NoTB97)}
uses
  Types
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  tb97GraphicControl
  ;

type
 TCustomToolbarButton97 = class(Ttb97GraphicTextControl)
 protected
 // protected methods
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
 // protected methods
   function GetFormToResize: TCustomForm; virtual;
 end;//TSizeGripPanel

 TToolbarButton97ActionLink = class(TControlActionLink)
 end;//TToolbarButton97ActionLink
{$IfEnd} //not NoTB97

implementation

{$If not defined(NoTB97)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoTB97)}
  ,
  tb97WordsPack
  {$IfEnd} //not NoScripts AND not NoTB97
  
  ;

// start class TCustomToolbarButton97

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
// start class TSizeGripPanel

function TSizeGripPanel.GetFormToResize: TCustomForm;
//#UC START# *53CE39CD0045_5058B6600074_var*
//#UC END# *53CE39CD0045_5058B6600074_var*
begin
//#UC START# *53CE39CD0045_5058B6600074_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CE39CD0045_5058B6600074_impl*
end;//TSizeGripPanel.GetFormToResize
{$IfEnd} //not NoTB97

initialization
{$If not defined(NoScripts) AND not defined(NoTB97)}
// Регистрация TCustomToolbarButton97
 TtfwClassRef.Register(TCustomToolbarButton97);
{$IfEnd} //not NoScripts AND not NoTB97
{$If not defined(NoScripts) AND not defined(NoTB97)}
// Регистрация TToolbarButton97
 TtfwClassRef.Register(TToolbarButton97);
{$IfEnd} //not NoScripts AND not NoTB97
{$If not defined(NoScripts) AND not defined(NoTB97)}
// Регистрация TCustomToolbarPanel97
 TtfwClassRef.Register(TCustomToolbarPanel97);
{$IfEnd} //not NoScripts AND not NoTB97
{$If not defined(NoScripts) AND not defined(NoTB97)}
// Регистрация TSizeGripPanel
 TtfwClassRef.Register(TSizeGripPanel);
{$IfEnd} //not NoScripts AND not NoTB97

end.