{$IfNDef afwVGSceneUpdater_imp}

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\afwVGSceneUpdater.imp.pas"
// Стереотип: "Impurity"

{$Define afwVGSceneUpdater_imp}

 _afwVGSceneUpdater_ = class(_afwVGSceneUpdater_Parent_)
  protected
   {$If NOT Defined(NoVCL)}
   procedure WndProc(var Message: TMessage); override;
   {$IfEnd} // NOT Defined(NoVCL)
 end;//_afwVGSceneUpdater_

{$Else afwVGSceneUpdater_imp}

{$IfNDef afwVGSceneUpdater_imp_impl}

{$Define afwVGSceneUpdater_imp_impl}

{$If NOT Defined(NoVCL)}
procedure _afwVGSceneUpdater_.WndProc(var Message: TMessage);
//#UC START# *47E136A80191_4DA7235700F3_var*
//#UC END# *47E136A80191_4DA7235700F3_var*
begin
//#UC START# *47E136A80191_4DA7235700F3_impl*
 if (Message.Msg = CM_INVALIDATE) or (Message.Msg = WM_SETCURSOR) then
  if (afwFacade.g_DisableMessageHook <= 0) then
   if Assigned(afwFacade.g_MessageHook) then
    afwFacade.g_MessageHook(Self, Message);
 inherited;
//#UC END# *47E136A80191_4DA7235700F3_impl*
end;//_afwVGSceneUpdater_.WndProc
{$IfEnd} // NOT Defined(NoVCL)

{$EndIf afwVGSceneUpdater_imp_impl}

{$EndIf afwVGSceneUpdater_imp}

