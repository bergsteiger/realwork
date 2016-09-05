unit kwSubPanelGetPopupMenuForSub;
 {* *Описание*: возвращает меню для саба на сабпанели.
*Формат:*
[code]
aSubPanel aSubPanelSub SubPanel:GetPopupMenuForSub
[code]
aSubPanel - контрол саб панели.
aSubPanelSub - объект класса TevSubPanelSub }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwSubPanelGetPopupMenuForSub.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "SubPanel_GetPopupMenuForSub" MUID: (53EE014B03AC)
// Имя типа: "TkwSubPanelGetPopupMenuForSub"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwSubPanelFromStackWord
 , evSubPn
 , tfwScriptingInterfaces
;

type
 TkwSubPanelGetPopupMenuForSub = {final} class(TkwSubPanelFromStackWord)
  {* *Описание*: возвращает меню для саба на сабпанели.
*Формат:*
[code]
aSubPanel aSubPanelSub SubPanel:GetPopupMenuForSub
[code]
aSubPanel - контрол саб панели.
aSubPanelSub - объект класса TevSubPanelSub }
  protected
   procedure DoWithSubPanel(aControl: TevCustomSubPanel;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwSubPanelGetPopupMenuForSub
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evSubPanelSub
 , nevFacade
 , l3Interfaces
 , Types
 {$If NOT Defined(NoVCL)}
 , l3PopupMenuHelper
 {$IfEnd} // NOT Defined(NoVCL)
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *53EE014B03ACimpl_uses*
 //#UC END# *53EE014B03ACimpl_uses*
;

procedure TkwSubPanelGetPopupMenuForSub.DoWithSubPanel(aControl: TevCustomSubPanel;
 const aCtx: TtfwContext);
//#UC START# *52D6471802DC_53EE014B03AC_var*
var
 l_SPoint     : Tl3_SPoint;
 l_SubPanelSub: TevSubPanelSub;
//#UC END# *52D6471802DC_53EE014B03AC_var*
begin
//#UC START# *52D6471802DC_53EE014B03AC_impl*
 //aControl.PopupMenu;
 RunnerAssert(aCtx.rEngine.IsTopObj, 'Не задан объект класса aSubPanelSub!', aCtx);
 l_SubPanelSub := aCtx.rEngine.PopObj as TevSubPanelSub;
 l_SPoint := nev.CrtIC.LP2DP(l_SubPanelSub.DrawRect.TopLeft);
 aCtx.rEngine.PushObj(Tl3PopupMenuHelper.Instance.GetPopupMenu(aControl, Point(l_SPoint.X, l_SPoint.Y)));
//#UC END# *52D6471802DC_53EE014B03AC_impl*
end;//TkwSubPanelGetPopupMenuForSub.DoWithSubPanel

class function TkwSubPanelGetPopupMenuForSub.GetWordNameForRegister: AnsiString;
begin
 Result := 'SubPanel:GetPopupMenuForSub';
end;//TkwSubPanelGetPopupMenuForSub.GetWordNameForRegister

initialization
 TkwSubPanelGetPopupMenuForSub.RegisterInEngine;
 {* Регистрация SubPanel_GetPopupMenuForSub }
{$IfEnd} // NOT Defined(NoScripts)

end.
