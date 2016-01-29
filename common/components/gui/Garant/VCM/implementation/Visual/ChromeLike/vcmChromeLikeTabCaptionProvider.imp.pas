{$IfNDef vcmChromeLikeTabCaptionProvider_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/ChromeLike/vcmChromeLikeTabCaptionProvider.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VCM$Visual::Visual$ChromeLike::vcmChromeLikeTabCaptionProvider
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmChromeLikeTabCaptionProvider_imp}
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
 _vcmChromeLikeTabCaptionProvider_ = {mixin} class(_vcmChromeLikeTabCaptionProvider_Parent_, IvcmFormSetCaptionProvider)
 protected
 // realized methods
   function pm_GetFormSetCaption: IvcmCString;
   function pm_GetFormSetTabCaption: IvcmCString;
 protected
 // protected methods
   procedure UpdateTabCaption(const aCaption: IvcmCString);
   function DoGetFormSetCaption: IvcmCString; virtual;
   function DoGetFormSetTabCaption: IvcmCString; virtual;
 end;//_vcmChromeLikeTabCaptionProvider_
{$Else}

 _vcmChromeLikeTabCaptionProvider_ = _vcmChromeLikeTabCaptionProvider_Parent_;

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$Else vcmChromeLikeTabCaptionProvider_imp}

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}

// start class _vcmChromeLikeTabCaptionProvider_

procedure _vcmChromeLikeTabCaptionProvider_.UpdateTabCaption(const aCaption: IvcmCString);
//#UC START# *53D89F9A03D1_53D89F52011D_var*
//#UC END# *53D89F9A03D1_53D89F52011D_var*
begin
//#UC START# *53D89F9A03D1_53D89F52011D_impl*
 TvcmTabbedContainerFormDispatcher.Instance.UpdateTabCaption(As_IvcmEntityForm,
  aCaption);
//#UC END# *53D89F9A03D1_53D89F52011D_impl*
end;//_vcmChromeLikeTabCaptionProvider_.UpdateTabCaption

function _vcmChromeLikeTabCaptionProvider_.DoGetFormSetCaption: IvcmCString;
//#UC START# *53D8B307018F_53D89F52011D_var*
//#UC END# *53D8B307018F_53D89F52011D_var*
begin
//#UC START# *53D8B307018F_53D89F52011D_impl*
 Result := nil;
//#UC END# *53D8B307018F_53D89F52011D_impl*
end;//_vcmChromeLikeTabCaptionProvider_.DoGetFormSetCaption

function _vcmChromeLikeTabCaptionProvider_.DoGetFormSetTabCaption: IvcmCString;
//#UC START# *54058CBC0182_53D89F52011D_var*
//#UC END# *54058CBC0182_53D89F52011D_var*
begin
//#UC START# *54058CBC0182_53D89F52011D_impl*
 Result := nil;
//#UC END# *54058CBC0182_53D89F52011D_impl*
end;//_vcmChromeLikeTabCaptionProvider_.DoGetFormSetTabCaption

function _vcmChromeLikeTabCaptionProvider_.pm_GetFormSetCaption: IvcmCString;
//#UC START# *53D8A0900146_53D89F52011Dget_var*
//#UC END# *53D8A0900146_53D89F52011Dget_var*
begin
//#UC START# *53D8A0900146_53D89F52011Dget_impl*
 Result := DoGetFormSetCaption;
//#UC END# *53D8A0900146_53D89F52011Dget_impl*
end;//_vcmChromeLikeTabCaptionProvider_.pm_GetFormSetCaption

function _vcmChromeLikeTabCaptionProvider_.pm_GetFormSetTabCaption: IvcmCString;
//#UC START# *540585F303B3_53D89F52011Dget_var*
//#UC END# *540585F303B3_53D89F52011Dget_var*
begin
//#UC START# *540585F303B3_53D89F52011Dget_impl*
 Result := DoGetFormSetTabCaption;
//#UC END# *540585F303B3_53D89F52011Dget_impl*
end;//_vcmChromeLikeTabCaptionProvider_.pm_GetFormSetTabCaption

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$EndIf vcmChromeLikeTabCaptionProvider_imp}
