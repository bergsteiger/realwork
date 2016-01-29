unit PrimLegalMainMenu_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/MainMenu/Forms/PrimLegalMainMenu_Form.pas"
// Начат: 05.10.2009 16:34
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Интерфейсные элементы::MainMenu::View::MainMenu::PrimLegalMainMenu
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  PrimMainMenu_Form,
  MainMenuWithBaseSearchSupport_Form
  {$If defined(Nemesis)}
  ,
  nscHideField
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTreeViewHotTruck
  {$IfEnd} //Nemesis
  ,
  l3TreeInterfaces,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimLegalMainMenuForm = {abstract form} class(TMainMenuWithBaseSearchSupportForm)
 private
 // private fields
   f_hfReferences : TnscHideField;
    {* Поле для свойства hfReferences}
   f_tvReferences : TnscTreeViewHotTruck;
    {* Поле для свойства tvReferences}
   f_hfLawNews : TnscHideField;
    {* Поле для свойства hfLawNews}
   f_tvLawNews : TnscTreeViewHotTruck;
    {* Поле для свойства tvLawNews}
 protected
  procedure MakeControls; override;
 private
 // private methods
   procedure UpdateMainMenuForm;
 protected
 // overridden protected methods
   procedure FinishDataUpdate; override;
   procedure SettingsReplaceFinish; override;
   procedure UserSettingsChanged; override;
     {* Изменились настройки пользователя }
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   procedure LoadTrees; override;
 protected
 // protected methods
   procedure UpdateCaption;
 public
 // public properties

   property hfReferences: TnscHideField
     read f_hfReferences;
     {* Бизнес-справки }
   property tvReferences: TnscTreeViewHotTruck
     read f_tvReferences;
   property hfLawNews: TnscHideField
     read f_hfLawNews;
     {* Изменения в законодательстве }
   property tvLawNews: TnscTreeViewHotTruck
     read f_tvLawNews;
 end;//TPrimLegalMainMenuForm

 TvcmEntityFormRef = TPrimLegalMainMenuForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  nsMainMenuNew,
  smLawNewsTree,
  smNewSchoolReferencesTree
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(DesignTimeLibrary)}
  ,
  evStyleTableSpy
  {$IfEnd} //not DesignTimeLibrary
  ,
  SysUtils,
  afwFacade
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimLegalMainMenuForm

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
//#UC START# *4958BE910345_4AC9E7B40342_var*
//#UC END# *4958BE910345_4AC9E7B40342_var*
begin
//#UC START# *4958BE910345_4AC9E7B40342_impl*
 inherited;
 UpdateMainMenuForm;
//#UC END# *4958BE910345_4AC9E7B40342_impl*
end;//TPrimLegalMainMenuForm.UserSettingsChanged

{$If not defined(NoVCM)}
procedure TPrimLegalMainMenuForm.DoInit(aFromHistory: Boolean);
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
{$IfEnd} //not NoVCM

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

procedure TPrimLegalMainMenuForm.MakeControls;
begin
 inherited;
 pnlMain.Parent := Self;
 f_hfReferences := TnscHideField.Create(Self);
 f_hfReferences.Name := 'hfReferences';
 f_hfReferences.Parent := pnlMain;
 f_hfReferences.Caption := 'Бизнес-справки';
 f_tvReferences := TnscTreeViewHotTruck.Create(Self);
 f_tvReferences.Name := 'tvReferences';
 f_tvReferences.Parent := hfReferences;
 f_hfLawNews := TnscHideField.Create(Self);
 f_hfLawNews.Name := 'hfLawNews';
 f_hfLawNews.Parent := pnlMain;
 f_hfLawNews.Caption := 'Изменения в законодательстве';
 f_tvLawNews := TnscTreeViewHotTruck.Create(Self);
 f_tvLawNews.Name := 'tvLawNews';
 f_tvLawNews.Parent := hfLawNews;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimLegalMainMenu
 TtfwClassRef.Register(TPrimLegalMainMenuForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.