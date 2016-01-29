{$IfNDef afwVGSceneUpdater_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AFW"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/AFW/implementation/afwVGSceneUpdater.imp.pas"
// Начат: 14.04.2011 20:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::AFW::afwMixIns::afwVGSceneUpdater
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define afwVGSceneUpdater_imp}
 _afwVGSceneUpdater_ = {mixin} class(_afwVGSceneUpdater_Parent_)
 protected
 // overridden protected methods
   {$If not defined(NoVCL)}
   procedure WndProc(var Message: TMessage); override;
   {$IfEnd} //not NoVCL
 end;//_afwVGSceneUpdater_

{$Else afwVGSceneUpdater_imp}

// start class _afwVGSceneUpdater_

{$If not defined(NoVCL)}
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
{$IfEnd} //not NoVCL

{$EndIf afwVGSceneUpdater_imp}
