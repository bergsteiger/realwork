unit NOT_FINISHED_TB97Tlbr;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "tb97"
// Модуль: "w:/common/components/rtl/external/tb97/NOT_FINISHED_TB97Tlbr.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::tb97::Toolbar::TB97Tlbr
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
  Types,
  TB97,
  tb97GraphicControl
  ;

type
 TCustomToolbar97 = class(TCustomToolWindow97)
 private
 // private fields
   f_Bounds : TRect;
   f_ResizeLockedCount : Integer;
    {* Поле для свойства ResizeLockedCount}
 protected
 // overridden protected methods
    {$If not defined(NoVCL)}
   procedure SetBounds(ALeft: Integer;
     ATop: Integer;
     AWidth: Integer;
     AHeight: Integer); override;
    {$IfEnd} //not NoVCL
 protected
 // protected methods
   procedure ExecuteHandler(Sender: TObject); virtual;
   procedure ExecuteDefered; virtual;
     {* Сигнатура метода ExecuteDefered }
   function IsGToolbarSizeNeeded: Boolean; virtual;
   procedure LockResize;
     {* Сигнатура метода LockResize }
   procedure UnlockResize;
     {* Сигнатура метода UnlockResize }
   procedure AdjustSizeForPanels; virtual;
     {* Сигнатура метода AdjustSizeForPanels }
 protected
 // protected properties
   property ResizeLockedCount: Integer
     read f_ResizeLockedCount;
 end;//TCustomToolbar97

 TToolbar97 = class(TCustomToolbar97)
 end;//TToolbar97

 TToolbarSep97 = class(Ttb97CustomGraphicControl)
 end;//TToolbarSep97

 Ttb97MoreButton = class
 end;//Ttb97MoreButton
{$IfEnd} //not NoTB97

implementation

{$If not defined(NoTB97)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TCustomToolbar97

procedure TCustomToolbar97.ExecuteHandler(Sender: TObject);
//#UC START# *5028A00600B5_502888EA0114_var*
//#UC END# *5028A00600B5_502888EA0114_var*
begin
//#UC START# *5028A00600B5_502888EA0114_impl*
 !!! Needs to be implemented !!!
//#UC END# *5028A00600B5_502888EA0114_impl*
end;//TCustomToolbar97.ExecuteHandler

procedure TCustomToolbar97.ExecuteDefered;
//#UC START# *5028A09900D5_502888EA0114_var*
//#UC END# *5028A09900D5_502888EA0114_var*
begin
//#UC START# *5028A09900D5_502888EA0114_impl*
 !!! Needs to be implemented !!!
//#UC END# *5028A09900D5_502888EA0114_impl*
end;//TCustomToolbar97.ExecuteDefered

function TCustomToolbar97.IsGToolbarSizeNeeded: Boolean;
//#UC START# *503DE79F02BA_502888EA0114_var*
//#UC END# *503DE79F02BA_502888EA0114_var*
begin
//#UC START# *503DE79F02BA_502888EA0114_impl*
 !!! Needs to be implemented !!!
//#UC END# *503DE79F02BA_502888EA0114_impl*
end;//TCustomToolbar97.IsGToolbarSizeNeeded

procedure TCustomToolbar97.LockResize;
//#UC START# *504F06E0002A_502888EA0114_var*
//#UC END# *504F06E0002A_502888EA0114_var*
begin
//#UC START# *504F06E0002A_502888EA0114_impl*
 !!! Needs to be implemented !!!
//#UC END# *504F06E0002A_502888EA0114_impl*
end;//TCustomToolbar97.LockResize

procedure TCustomToolbar97.UnlockResize;
//#UC START# *504F06EB033F_502888EA0114_var*
//#UC END# *504F06EB033F_502888EA0114_var*
begin
//#UC START# *504F06EB033F_502888EA0114_impl*
 !!! Needs to be implemented !!!
//#UC END# *504F06EB033F_502888EA0114_impl*
end;//TCustomToolbar97.UnlockResize

procedure TCustomToolbar97.AdjustSizeForPanels;
//#UC START# *5058B29A007C_502888EA0114_var*
//#UC END# *5058B29A007C_502888EA0114_var*
begin
//#UC START# *5058B29A007C_502888EA0114_impl*
 !!! Needs to be implemented !!!
//#UC END# *5058B29A007C_502888EA0114_impl*
end;//TCustomToolbar97.AdjustSizeForPanels

{$If not defined(NoVCL)}
procedure TCustomToolbar97.SetBounds(ALeft: Integer;
  ATop: Integer;
  AWidth: Integer;
  AHeight: Integer);
//#UC START# *4F2A599E0283_502888EA0114_var*
//#UC END# *4F2A599E0283_502888EA0114_var*
begin
//#UC START# *4F2A599E0283_502888EA0114_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2A599E0283_502888EA0114_impl*
end;//TCustomToolbar97.SetBounds
{$IfEnd} //not NoVCL
{$IfEnd} //not NoTB97

initialization
{$If not defined(NoScripts) AND not defined(NoTB97)}
// Регистрация TCustomToolbar97
 TtfwClassRef.Register(TCustomToolbar97);
{$IfEnd} //not NoScripts AND not NoTB97
{$If not defined(NoScripts) AND not defined(NoTB97)}
// Регистрация TToolbar97
 TtfwClassRef.Register(TToolbar97);
{$IfEnd} //not NoScripts AND not NoTB97
{$If not defined(NoScripts) AND not defined(NoTB97)}
// Регистрация TToolbarSep97
 TtfwClassRef.Register(TToolbarSep97);
{$IfEnd} //not NoScripts AND not NoTB97
{$If not defined(NoScripts) AND not defined(NoTB97)}
// Регистрация Ttb97MoreButton
 TtfwClassRef.Register(Ttb97MoreButton);
{$IfEnd} //not NoScripts AND not NoTB97

end.