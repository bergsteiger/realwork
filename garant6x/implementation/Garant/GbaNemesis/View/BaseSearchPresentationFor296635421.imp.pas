{$IfNDef BaseSearchPresentationFor296635421_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaseSearchPresentationFor296635421.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::BaseSearchPresentationFor296635421
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define BaseSearchPresentationFor296635421_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _BaseSearchPresentation_Parent_ = _BaseSearchPresentationFor296635421_Parent_;
 {$Include ..\View\BaseSearchPresentation.imp.pas}
 _BaseSearchPresentationFor296635421_ = {abstract form} class(_BaseSearchPresentation_)
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 end;//_BaseSearchPresentationFor296635421_
{$Else}

 _BaseSearchPresentation_Parent_ = _BaseSearchPresentationFor296635421_Parent_;
 {$Include ..\View\BaseSearchPresentation.imp.pas}
 _BaseSearchPresentationFor296635421_ = _BaseSearchPresentation_;

{$IfEnd} //not Admin AND not Monitorings

{$Else BaseSearchPresentationFor296635421_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include ..\View\BaseSearchPresentation.imp.pas}

// start class _BaseSearchPresentationFor296635421_

{$If not defined(NoVCM)}
procedure _BaseSearchPresentationFor296635421_.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_4EB7BDAB01D0_var*
//#UC END# *49803F5503AA_4EB7BDAB01D0_var*
begin
//#UC START# *49803F5503AA_4EB7BDAB01D0_impl*
 inherited;
 if not aFromHistory then
  if (f_BaseSearcher <> nil) then
   f_BaseSearcher.DropActiveClass;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=269069309&focusedCommentId=296624258#comment-296624258
//#UC END# *49803F5503AA_4EB7BDAB01D0_impl*
end;//_BaseSearchPresentationFor296635421_.DoInit
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

{$EndIf BaseSearchPresentationFor296635421_imp}
