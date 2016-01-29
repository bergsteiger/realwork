{$IfNDef BaseSearchPresentation_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaseSearchPresentation.imp.pas"
// Начат: 14.10.2009 18:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::BaseSearchPresentation
//
// Реализация представление к которому привязан базовый поиск. Используется для инкапсуляции
// подписки/отписки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define BaseSearchPresentation_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _BaseSearchPresentation_ = {abstract form} class(_BaseSearchPresentation_Parent_)
  {* Реализация представление к которому привязан базовый поиск. Используется для инкапсуляции подписки/отписки }
 private
 // private fields
   f_BaseSearcher : InsBaseSearcher;
 public
 // realized methods
   function FormCloseWasRequested: Boolean;
     {* Окно уже попросили закрыться
http://mdp.garant.ru/pages/viewpage.action?pageId=321989072&focusedCommentId=330698655#comment-330698655
Скорее всего его нельзя запоминать в историю. Точнее не егго а форму БП, которая на него смотрит }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure BecomeActive; override;
   {$IfEnd} //not NoVCM
 protected
 // protected methods
   procedure ForceUpdateClassForHistory;
 end;//_BaseSearchPresentation_
{$Else}

 _BaseSearchPresentation_ = _BaseSearchPresentation_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else BaseSearchPresentation_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _BaseSearchPresentation_

procedure _BaseSearchPresentation_.ForceUpdateClassForHistory;
//#UC START# *5437B84A0305_4AD5E6A60262_var*
//#UC END# *5437B84A0305_4AD5E6A60262_var*
begin
//#UC START# *5437B84A0305_4AD5E6A60262_impl*
 f_BaseSearcher.ForceUpdateClassForHistory;
//#UC END# *5437B84A0305_4AD5E6A60262_impl*
end;//_BaseSearchPresentation_.ForceUpdateClassForHistory

function _BaseSearchPresentation_.FormCloseWasRequested: Boolean;
//#UC START# *4F22C2D00369_4AD5E6A60262_var*
//#UC END# *4F22C2D00369_4AD5E6A60262_var*
begin
//#UC START# *4F22C2D00369_4AD5E6A60262_impl*
 Result := Self.VCMClosing;
//#UC END# *4F22C2D00369_4AD5E6A60262_impl*
end;//_BaseSearchPresentation_.FormCloseWasRequested

procedure _BaseSearchPresentation_.Cleanup;
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

{$If not defined(NoVCM)}
procedure _BaseSearchPresentation_.DoInit(aFromHistory: Boolean);
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
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
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

{$EndIf BaseSearchPresentation_imp}
