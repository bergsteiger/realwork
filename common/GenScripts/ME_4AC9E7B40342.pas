unit PrimLegalMainMenu_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\PrimLegalMainMenu_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimLegalMainMenu" MUID: (4AC9E7B40342)
// Имя типа: "TPrimLegalMainMenuForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , MainMenuWithBaseSearchSupport_Form
 {$If Defined(Nemesis)}
 , nscHideField
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTreeViewHotTruck
 {$IfEnd} // Defined(Nemesis)
;

type
 TPrimLegalMainMenuForm = {abstract} class(TMainMenuWithBaseSearchSupportForm)
  private
   f_hfReferences: TnscHideField;
    {* Поле для свойства hfReferences }
   f_tvReferences: TnscTreeViewHotTruck;
    {* Поле для свойства tvReferences }
   f_hfLawNews: TnscHideField;
    {* Поле для свойства hfLawNews }
   f_tvLawNews: TnscTreeViewHotTruck;
    {* Поле для свойства tvLawNews }
  private
   procedure UpdateMainMenuForm;
  protected
   procedure UpdateCaption;
   procedure FinishDataUpdate; override;
   procedure SettingsReplaceFinish; override;
   procedure UserSettingsChanged; override;
    {* Изменились настройки пользователя }
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure LoadTrees; override;
 end;//TPrimLegalMainMenuForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsMainMenuNew
 , smLawNewsTree
 , smNewSchoolReferencesTree
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , SysUtils
 , afwFacade
;

procedure TPrimLegalMainMenuForm.UpdateMainMenuForm;
//#UC START# *4ACC7F16032D_4AC9E7B40342_var*
//#UC END# *4ACC7F16032D_4AC9E7B40342_var*
begin
//#UC START# *4ACC7F16032D_4AC9E7B40342_impl*
 if not VCMClosing then
  if Visible then
   TdmStdRes.OpenMainMenuIfNeeded(NativeMainForm);
//#UC END# *4ACC7F16032D_4AC9E7B40342_impl*
end;//TPrimLegalMainMenuForm.UpdateMainMenuForm

procedure TPrimLegalMainMenuForm.UpdateCaption;
//#UC START# *5450DAE20391_4AC9E7B40342_var*
//#UC END# *5450DAE20391_4AC9E7B40342_var*
begin
//#UC START# *5450DAE20391_4AC9E7B40342_impl*
 Self.CCaption := nsMakeMainMenuCaption;
//#UC END# *5450DAE20391_4AC9E7B40342_impl*
end;//TPrimLegalMainMenuForm.UpdateCaption

procedure TPrimLegalMainMenuForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4AC9E7B40342_var*
//#UC END# *47EA4E9002C6_4AC9E7B40342_var*
begin
//#UC START# *47EA4E9002C6_4AC9E7B40342_impl*
 inherited;
 UpdateCaption;
//#UC END# *47EA4E9002C6_4AC9E7B40342_impl*
end;//TPrimLegalMainMenuForm.FinishDataUpdate

procedure TPrimLegalMainMenuForm.SettingsReplaceFinish;
//#UC START# *47EA8B9601FE_4AC9E7B40342_var*
//#UC END# *47EA8B9601FE_4AC9E7B40342_var*
begin
//#UC START# *47EA8B9601FE_4AC9E7B40342_impl*
 inherited;
 UpdateMainMenuForm;
//#UC END# *47EA8B9601FE_4AC9E7B40342_impl*
end;//TPrimLegalMainMenuForm.SettingsReplaceFinish

procedure TPrimLegalMainMenuForm.UserSettingsChanged;
 {* Изменились настройки пользователя }
//#UC START# *4958BE910345_4AC9E7B40342_var*
//#UC END# *4958BE910345_4AC9E7B40342_var*
begin
//#UC START# *4958BE910345_4AC9E7B40342_impl*
 inherited;
 UpdateMainMenuForm;
//#UC END# *4958BE910345_4AC9E7B40342_impl*
end;//TPrimLegalMainMenuForm.UserSettingsChanged

{$If NOT Defined(NoVCM)}
procedure TPrimLegalMainMenuForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4AC9E7B40342_var*
//#UC END# *49803F5503AA_4AC9E7B40342_var*
begin
//#UC START# *49803F5503AA_4AC9E7B40342_impl*
 inherited;
(* if not aFromHistory then
  if (f_BaseSearcher <> nil) then
   f_BaseSearcher.ActiveClass := nil;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=269069309&focusedCommentId=296624258#comment-296624258*)
//#UC END# *49803F5503AA_4AC9E7B40342_impl*
end;//TPrimLegalMainMenuForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimLegalMainMenuForm.LoadTrees;
//#UC START# *4AC9E9EC0064_4AC9E7B40342_var*
//#UC END# *4AC9E9EC0064_4AC9E7B40342_var*
begin
//#UC START# *4AC9E9EC0064_4AC9E7B40342_impl*
 inherited;
 tvReferences.TreeStruct := TsmNewSchoolReferencesTree.Make;
 tvLawNews.TreeStruct := TsmLawNewsTree.Make;
//#UC END# *4AC9E9EC0064_4AC9E7B40342_impl*
end;//TPrimLegalMainMenuForm.LoadTrees

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimLegalMainMenuForm);
 {* Регистрация PrimLegalMainMenu }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
