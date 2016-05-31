{$IfNDef BaseSearchPresentation_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearchPresentation.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "BaseSearchPresentation" MUID: (4AD5E6A60262)
// Имя типа: "_BaseSearchPresentation_"

{$Define BaseSearchPresentation_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _BaseSearchPresentation_ = {abstract} class(_BaseSearchPresentation_Parent_)
  {* Реализация представление к которому привязан базовый поиск. Используется для инкапсуляции подписки/отписки }
  private
   f_BaseSearcher: InsBaseSearcher;
  protected
   procedure ForceUpdateClassForHistory;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure BecomeActive; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function FormCloseWasRequested: Boolean;
    {* Окно уже попросили закрыться
http://mdp.garant.ru/pages/viewpage.action?pageId=321989072&focusedCommentId=330698655#comment-330698655
Скорее всего его нельзя запоминать в историю. Точнее не егго а форму БП, которая на него смотрит }
 end;//_BaseSearchPresentation_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_BaseSearchPresentation_ = _BaseSearchPresentation_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else BaseSearchPresentation_imp}

{$IfNDef BaseSearchPresentation_imp_impl}

{$Define BaseSearchPresentation_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
procedure _BaseSearchPresentation_.ForceUpdateClassForHistory;
//#UC START# *5437B84A0305_4AD5E6A60262_var*
//#UC END# *5437B84A0305_4AD5E6A60262_var*
begin
//#UC START# *5437B84A0305_4AD5E6A60262_impl*
 f_BaseSearcher.ForceUpdateClassForHistory;
//#UC END# *5437B84A0305_4AD5E6A60262_impl*
end;//_BaseSearchPresentation_.ForceUpdateClassForHistory

function _BaseSearchPresentation_.FormCloseWasRequested: Boolean;
 {* Окно уже попросили закрыться
http://mdp.garant.ru/pages/viewpage.action?pageId=321989072&focusedCommentId=330698655#comment-330698655
Скорее всего его нельзя запоминать в историю. Точнее не егго а форму БП, которая на него смотрит }
//#UC START# *4F22C2D00369_4AD5E6A60262_var*
//#UC END# *4F22C2D00369_4AD5E6A60262_var*
begin
//#UC START# *4F22C2D00369_4AD5E6A60262_impl*
 Result := Self.VCMClosing;
//#UC END# *4F22C2D00369_4AD5E6A60262_impl*
end;//_BaseSearchPresentation_.FormCloseWasRequested

procedure _BaseSearchPresentation_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AD5E6A60262_var*
//#UC END# *479731C50290_4AD5E6A60262_var*
begin
//#UC START# *479731C50290_4AD5E6A60262_impl*
 if (f_BaseSearcher <> nil) then
  f_BaseSearcher.RemovePresentation(_Instance_R_(Self));
 f_BaseSearcher := nil;
 inherited;
//#UC END# *479731C50290_4AD5E6A60262_impl*
end;//_BaseSearchPresentation_.Cleanup

{$If NOT Defined(NoVCM)}
procedure _BaseSearchPresentation_.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4AD5E6A60262_var*
var
 l_NMF: IvcmContainer;
 l_AE  : IvcmEntity;
//#UC END# *49803F5503AA_4AD5E6A60262_var*
begin
//#UC START# *49803F5503AA_4AD5E6A60262_impl*
 inherited;
 f_BaseSearcher := TnsBaseSearchService.Instance.GetBaseSearcher(_Instance_R_(Self).As_IvcmEntityForm);
 l_NMF := NativeMainForm;
 if (f_BaseSearcher <> nil) then
 begin
  l_AE := Dispatcher.ActiveEntity;
  if l3IEQ(l_AE, Self.Entity) OR
     l3IEQ(l_AE, l_NMF.AsForm.Entity)
     // http://mdp.garant.ru/pages/viewpage.action?pageId=265410447&focusedCommentId=265413804#comment-265413804
     then
  begin
   f_BaseSearcher.ValidateBaseSearchForm(Self.As_IvcmEntityForm);
   f_BaseSearcher.Presentation := _Instance_R_(Self);
  end;//l3IEQ(l_AE, Self.Entity)..
 end;//f_BaseSearcher <> nil
//#UC END# *49803F5503AA_4AD5E6A60262_impl*
end;//_BaseSearchPresentation_.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _BaseSearchPresentation_.BecomeActive;
//#UC START# *4A8AE0FA03B2_4AD5E6A60262_var*
//#UC END# *4A8AE0FA03B2_4AD5E6A60262_var*
begin
//#UC START# *4A8AE0FA03B2_4AD5E6A60262_impl*
 inherited;
 if (f_BaseSearcher <> nil) then
 begin
  f_BaseSearcher.ValidateBaseSearchForm(Self.As_IvcmEntityForm);
  f_BaseSearcher.Presentation := _Instance_R_(Self);
 end;//f_BaseSearcher <> nil
//#UC END# *4A8AE0FA03B2_4AD5E6A60262_impl*
end;//_BaseSearchPresentation_.BecomeActive
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf BaseSearchPresentation_imp_impl}

{$EndIf BaseSearchPresentation_imp}

