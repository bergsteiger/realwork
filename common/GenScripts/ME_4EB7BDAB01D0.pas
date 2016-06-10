{$IfNDef BaseSearchPresentationFor296635421_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearchPresentationFor296635421.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "BaseSearchPresentationFor296635421" MUID: (4EB7BDAB01D0)
// Имя типа: "_BaseSearchPresentationFor296635421_"

{$Define BaseSearchPresentationFor296635421_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _BaseSearchPresentation_Parent_ = _BaseSearchPresentationFor296635421_Parent_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearchPresentation.imp.pas}
 _BaseSearchPresentationFor296635421_ = {abstract} class(_BaseSearchPresentation_)
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_BaseSearchPresentationFor296635421_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_BaseSearchPresentation_Parent_ = _BaseSearchPresentationFor296635421_Parent_;
{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearchPresentation.imp.pas}
_BaseSearchPresentationFor296635421_ = _BaseSearchPresentation_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else BaseSearchPresentationFor296635421_imp}

{$IfNDef BaseSearchPresentationFor296635421_imp_impl}

{$Define BaseSearchPresentationFor296635421_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearchPresentation.imp.pas}

{$If NOT Defined(NoVCM)}
procedure _BaseSearchPresentationFor296635421_.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4EB7BDAB01D0_var*
//#UC END# *49803F5503AA_4EB7BDAB01D0_var*
begin
//#UC START# *49803F5503AA_4EB7BDAB01D0_impl*
 inherited;
 if (not aFromHistory) and (not TvcmHistoryService.Instance.IsInBF(As_IvcmEntityForm)) then
  if (f_BaseSearcher <> nil) then
   f_BaseSearcher.DropActiveClass;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=269069309&focusedCommentId=296624258#comment-296624258
//#UC END# *49803F5503AA_4EB7BDAB01D0_impl*
end;//_BaseSearchPresentationFor296635421_.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf BaseSearchPresentationFor296635421_imp_impl}

{$EndIf BaseSearchPresentationFor296635421_imp}

