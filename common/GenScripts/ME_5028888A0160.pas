unit NOT_FINISHED_TB97Tlbr;

// Модуль: "w:\common\components\rtl\external\tb97\NOT_FINISHED_TB97Tlbr.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "TB97Tlbr" MUID: (5028888A0160)

{$Include w:\common\components\rtl\external\tb97\TB97VER.INC}

interface

{$If NOT Defined(NoTB97)}
uses
 l3IntfUses
 , TB97
 , Types
 , tb97GraphicControl
;

type
 TCustomToolbar97 = class(TCustomToolWindow97)
  private
   f_Bounds: TRect;
   f_ResizeLockedCount: Integer;
  protected
   procedure ExecuteHandler(Sender: TObject); virtual;
   procedure ExecuteDefered; virtual;
   function IsGToolbarSizeNeeded: Boolean; virtual;
   procedure LockResize;
   procedure UnlockResize;
   procedure AdjustSizeForPanels; virtual;
   {$If NOT Defined(NoVCL)}
   procedure SetBounds(ALeft: Integer;
    ATop: Integer;
    AWidth: Integer;
    AHeight: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
  protected
   property ResizeLockedCount: Integer
    read f_ResizeLockedCount;
 end;//TCustomToolbar97

 TToolbar97 = class(TCustomToolbar97)
 end;//TToolbar97

 TToolbarSep97 = class(Ttb97CustomGraphicControl)
 end;//TToolbarSep97

 Ttb97MoreButton = class
 end;//Ttb97MoreButton
{$IfEnd} // NOT Defined(NoTB97)

implementation

{$If NOT Defined(NoTB97)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

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

{$If NOT Defined(NoVCL)}
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
{$IfEnd} // NOT Defined(NoVCL)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCustomToolbar97);
 {* Регистрация TCustomToolbar97 }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TToolbar97);
 {* Регистрация TToolbar97 }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TToolbarSep97);
 {* Регистрация TToolbarSep97 }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ttb97MoreButton);
 {* Регистрация Ttb97MoreButton }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoTB97)

end.
