unit vtAbstractScrollingDropDownWindow;

// Модуль: "w:\common\components\gui\Garant\VT\vtAbstractScrollingDropDownWindow.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtAbstractScrollingDropDownWindow" MUID: (57F4D92C029E)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , vtAbstractDropDownWindow
 , Messages
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TvtAbstractScrollingDropDownWindow = class(TvtAbstractDropDownWindow)
  private
   procedure WMSize(var Msg: TWMSize); message WM_SIZE;
   procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
   procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
  protected
   procedure UpdateScrollInfo;
   procedure InitFields; override;
   {$If NOT Defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure CreateWnd; override;
   {$IfEnd} // NOT Defined(NoVCL)
 end;//TvtAbstractScrollingDropDownWindow

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57F4D92C029Eimpl_uses*
 //#UC END# *57F4D92C029Eimpl_uses*
;

procedure TvtAbstractScrollingDropDownWindow.UpdateScrollInfo;
//#UC START# *57F3C62D038B_57F4D92C029E_var*
//#UC END# *57F3C62D038B_57F4D92C029E_var*
begin
//#UC START# *57F3C62D038B_57F4D92C029E_impl*
 !!! Needs to be implemented !!!
//#UC END# *57F3C62D038B_57F4D92C029E_impl*
end;//TvtAbstractScrollingDropDownWindow.UpdateScrollInfo

procedure TvtAbstractScrollingDropDownWindow.WMSize(var Msg: TWMSize);
//#UC START# *57F3C8350020_57F4D92C029E_var*
//#UC END# *57F3C8350020_57F4D92C029E_var*
begin
//#UC START# *57F3C8350020_57F4D92C029E_impl*
 !!! Needs to be implemented !!!
//#UC END# *57F3C8350020_57F4D92C029E_impl*
end;//TvtAbstractScrollingDropDownWindow.WMSize

procedure TvtAbstractScrollingDropDownWindow.WMHScroll(var Msg: TWMHScroll);
//#UC START# *57F4DAEA00FB_57F4D92C029E_var*
//#UC END# *57F4DAEA00FB_57F4D92C029E_var*
begin
//#UC START# *57F4DAEA00FB_57F4D92C029E_impl*
 !!! Needs to be implemented !!!
//#UC END# *57F4DAEA00FB_57F4D92C029E_impl*
end;//TvtAbstractScrollingDropDownWindow.WMHScroll

procedure TvtAbstractScrollingDropDownWindow.WMVScroll(var Msg: TWMVScroll);
//#UC START# *57F4DAFC0079_57F4D92C029E_var*
//#UC END# *57F4DAFC0079_57F4D92C029E_var*
begin
//#UC START# *57F4DAFC0079_57F4D92C029E_impl*
 !!! Needs to be implemented !!!
//#UC END# *57F4DAFC0079_57F4D92C029E_impl*
end;//TvtAbstractScrollingDropDownWindow.WMVScroll

procedure TvtAbstractScrollingDropDownWindow.InitFields;
//#UC START# *47A042E100E2_57F4D92C029E_var*
//#UC END# *47A042E100E2_57F4D92C029E_var*
begin
//#UC START# *47A042E100E2_57F4D92C029E_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_57F4D92C029E_impl*
end;//TvtAbstractScrollingDropDownWindow.InitFields

{$If NOT Defined(NoVCL)}
procedure TvtAbstractScrollingDropDownWindow.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_57F4D92C029E_var*
//#UC END# *48C7925A02E5_57F4D92C029E_var*
begin
//#UC START# *48C7925A02E5_57F4D92C029E_impl*
 !!! Needs to be implemented !!!
//#UC END# *48C7925A02E5_57F4D92C029E_impl*
end;//TvtAbstractScrollingDropDownWindow.CreateParams
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtAbstractScrollingDropDownWindow.CreateWnd;
//#UC START# *4CC8414403B8_57F4D92C029E_var*
//#UC END# *4CC8414403B8_57F4D92C029E_var*
begin
//#UC START# *4CC8414403B8_57F4D92C029E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CC8414403B8_57F4D92C029E_impl*
end;//TvtAbstractScrollingDropDownWindow.CreateWnd
{$IfEnd} // NOT Defined(NoVCL)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtAbstractScrollingDropDownWindow);
 {* Регистрация TvtAbstractScrollingDropDownWindow }
{$IfEnd} // NOT Defined(NoScripts)

end.
