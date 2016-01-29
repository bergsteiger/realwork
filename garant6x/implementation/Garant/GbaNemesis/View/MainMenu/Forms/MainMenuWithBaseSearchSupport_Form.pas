unit MainMenuWithBaseSearchSupport_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/MainMenu/Forms/MainMenuWithBaseSearchSupport_Form.pas"
// Начат: 05.10.2009 11:23
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Интерфейсные элементы::MainMenu::View::MainMenu::MainMenuWithBaseSearchSupport
//
// Основное меню с поддержкой базового поиска
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
  BaseSearchInterfaces,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _BaseSearchPresentationFor296635421_Parent_ = TPrimMainMenuForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearchPresentationFor296635421.imp.pas}
 TMainMenuWithBaseSearchSupportForm = {abstract form} class(_BaseSearchPresentationFor296635421_, InsBaseSearchPresentation, InsMainMenuLikeBaseSearchOwner)
  {* Основное меню с поддержкой базового поиска }
 protected
 // realized methods
   function WindowRequired: Boolean;
   function WindowCloseable: Boolean;
   function CanCloseWindow: Boolean;
   function IsQueryCard: Boolean;
   function TreatSuccessSearchAsManualOpen: Boolean;
   function AutoActivateWindow: Boolean;
   function Get_ContainerForBaseSearch: TnsContainerForBaseSearchInfo;
   function Get_ContextSearcher: InsContextSearcher;
   function Get_NeedSaveActiveClassBeforeSearch: Boolean;
   function IsIt: Boolean;
 public
 // realized methods
   function SupportDisabled: Boolean;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   procedure CreateFormGUID(var theGUID: TGUID); override;
     {* Создаёт идентификатор формы. Для того, чтобы отличать однотипные формы друг от друга. В частности для истории. }
    {$IfEnd} //not NoVCM
 public
 // overridden public methods
   {$If defined(l3HackedVCL) AND not defined(NoVCL)}
   function NeedAutoScroll: Boolean; override;
   {$IfEnd} //l3HackedVCL AND not NoVCL
 end;//TMainMenuWithBaseSearchSupportForm

 TvcmEntityFormRef = TMainMenuWithBaseSearchSupportForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsMainMenuFormGUIDFactory
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  SysUtils,
  l3Base,
  l3InterfacesMisc,
  nsBaseSearchService
  {$If not defined(DesignTimeLibrary)}
  ,
  evStyleTableSpy
  {$IfEnd} //not DesignTimeLibrary
  ,
  afwFacade
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TMainMenuWithBaseSearchSupportForm;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearchPresentationFor296635421.imp.pas}

// start class TMainMenuWithBaseSearchSupportForm

function TMainMenuWithBaseSearchSupportForm.WindowRequired: Boolean;
//#UC START# *496B4C41023E_4AC99EBE0106_var*
//#UC END# *496B4C41023E_4AC99EBE0106_var*
begin
//#UC START# *496B4C41023E_4AC99EBE0106_impl*
 Result := True;
//#UC END# *496B4C41023E_4AC99EBE0106_impl*
end;//TMainMenuWithBaseSearchSupportForm.WindowRequired

function TMainMenuWithBaseSearchSupportForm.WindowCloseable: Boolean;
//#UC START# *496B4C500246_4AC99EBE0106_var*
//#UC END# *496B4C500246_4AC99EBE0106_var*
begin
//#UC START# *496B4C500246_4AC99EBE0106_impl*
 Result := False;
//#UC END# *496B4C500246_4AC99EBE0106_impl*
end;//TMainMenuWithBaseSearchSupportForm.WindowCloseable

function TMainMenuWithBaseSearchSupportForm.CanCloseWindow: Boolean;
//#UC START# *496B4CA000B6_4AC99EBE0106_var*
//#UC END# *496B4CA000B6_4AC99EBE0106_var*
begin
//#UC START# *496B4CA000B6_4AC99EBE0106_impl*
 Result := False;
//#UC END# *496B4CA000B6_4AC99EBE0106_impl*
end;//TMainMenuWithBaseSearchSupportForm.CanCloseWindow

function TMainMenuWithBaseSearchSupportForm.IsQueryCard: Boolean;
//#UC START# *496B4CD9005F_4AC99EBE0106_var*
//#UC END# *496B4CD9005F_4AC99EBE0106_var*
begin
//#UC START# *496B4CD9005F_4AC99EBE0106_impl*
 Result := False;
//#UC END# *496B4CD9005F_4AC99EBE0106_impl*
end;//TMainMenuWithBaseSearchSupportForm.IsQueryCard

function TMainMenuWithBaseSearchSupportForm.TreatSuccessSearchAsManualOpen: Boolean;
//#UC START# *496B4CE30132_4AC99EBE0106_var*
//#UC END# *496B4CE30132_4AC99EBE0106_var*
begin
//#UC START# *496B4CE30132_4AC99EBE0106_impl*
 Result := True;
//#UC END# *496B4CE30132_4AC99EBE0106_impl*
end;//TMainMenuWithBaseSearchSupportForm.TreatSuccessSearchAsManualOpen

function TMainMenuWithBaseSearchSupportForm.AutoActivateWindow: Boolean;
//#UC START# *496B4CED0306_4AC99EBE0106_var*
//#UC END# *496B4CED0306_4AC99EBE0106_var*
begin
//#UC START# *496B4CED0306_4AC99EBE0106_impl*
 Result := True;
//#UC END# *496B4CED0306_4AC99EBE0106_impl*
end;//TMainMenuWithBaseSearchSupportForm.AutoActivateWindow

function TMainMenuWithBaseSearchSupportForm.SupportDisabled: Boolean;
//#UC START# *4ACA17770179_4AC99EBE0106_var*
//#UC END# *4ACA17770179_4AC99EBE0106_var*
begin
//#UC START# *4ACA17770179_4AC99EBE0106_impl*
 Result := false;
//#UC END# *4ACA17770179_4AC99EBE0106_impl*
end;//TMainMenuWithBaseSearchSupportForm.SupportDisabled

function TMainMenuWithBaseSearchSupportForm.Get_ContainerForBaseSearch: TnsContainerForBaseSearchInfo;
//#UC START# *4ACA195801CB_4AC99EBE0106get_var*
//#UC END# *4ACA195801CB_4AC99EBE0106get_var*
begin
//#UC START# *4ACA195801CB_4AC99EBE0106get_impl*
 Result.rContainer := Self.ContainerForBaseSearch;
 Result.rZone := vcm_ztAny;
//#UC END# *4ACA195801CB_4AC99EBE0106get_impl*
end;//TMainMenuWithBaseSearchSupportForm.Get_ContainerForBaseSearch

function TMainMenuWithBaseSearchSupportForm.Get_ContextSearcher: InsContextSearcher;
//#UC START# *4AD6EAA3034A_4AC99EBE0106get_var*
//#UC END# *4AD6EAA3034A_4AC99EBE0106get_var*
begin
//#UC START# *4AD6EAA3034A_4AC99EBE0106get_impl*
 Result := nil;
//#UC END# *4AD6EAA3034A_4AC99EBE0106get_impl*
end;//TMainMenuWithBaseSearchSupportForm.Get_ContextSearcher

function TMainMenuWithBaseSearchSupportForm.Get_NeedSaveActiveClassBeforeSearch: Boolean;
//#UC START# *4F1D607E0027_4AC99EBE0106get_var*
//#UC END# *4F1D607E0027_4AC99EBE0106get_var*
begin
//#UC START# *4F1D607E0027_4AC99EBE0106get_impl*
 Result := false;
//#UC END# *4F1D607E0027_4AC99EBE0106get_impl*
end;//TMainMenuWithBaseSearchSupportForm.Get_NeedSaveActiveClassBeforeSearch

function TMainMenuWithBaseSearchSupportForm.IsIt: Boolean;
//#UC START# *4F20313F00E3_4AC99EBE0106_var*
//#UC END# *4F20313F00E3_4AC99EBE0106_var*
begin
//#UC START# *4F20313F00E3_4AC99EBE0106_impl*
 Result := true;
//#UC END# *4F20313F00E3_4AC99EBE0106_impl*
end;//TMainMenuWithBaseSearchSupportForm.IsIt

{$If not defined(NoVCM)}
procedure TMainMenuWithBaseSearchSupportForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_4AC99EBE0106_var*
//#UC END# *49803F5503AA_4AC99EBE0106_var*
begin
//#UC START# *49803F5503AA_4AC99EBE0106_impl*
 inherited;
 if (not aFromHistory) then
  BecomeActive;
(* if not aFromHistory then
  if (f_BaseSearcher <> nil) then
   f_BaseSearcher.DropActiveClass;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=269069309&focusedCommentId=296624258#comment-296624258*)
//#UC END# *49803F5503AA_4AC99EBE0106_impl*
end;//TMainMenuWithBaseSearchSupportForm.DoInit
{$IfEnd} //not NoVCM

{$If defined(l3HackedVCL) AND not defined(NoVCL)}
function TMainMenuWithBaseSearchSupportForm.NeedAutoScroll: Boolean;
//#UC START# *4B0E845502C1_4AC99EBE0106_var*
//#UC END# *4B0E845502C1_4AC99EBE0106_var*
begin
//#UC START# *4B0E845502C1_4AC99EBE0106_impl*
 Result := false;
//#UC END# *4B0E845502C1_4AC99EBE0106_impl*
end;//TMainMenuWithBaseSearchSupportForm.NeedAutoScroll
{$IfEnd} //l3HackedVCL AND not NoVCL

{$If not defined(NoVCM)}
procedure TMainMenuWithBaseSearchSupportForm.CreateFormGUID(var theGUID: TGUID);
//#UC START# *4EBBC63E032A_4AC99EBE0106_var*
//#UC END# *4EBBC63E032A_4AC99EBE0106_var*
begin
//#UC START# *4EBBC63E032A_4AC99EBE0106_impl*
 TnsMainMenuFormGUIDFactory.Instance.CreateFormGUID(Self.As_IvcmEntityForm, theGUID);
 // http://mdp.garant.ru/pages/viewpage.action?pageId=326773370&focusedCommentId=330698414#comment-330698414
//#UC END# *4EBBC63E032A_4AC99EBE0106_impl*
end;//TMainMenuWithBaseSearchSupportForm.CreateFormGUID
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MainMenuWithBaseSearchSupport
 TtfwClassRef.Register(TMainMenuWithBaseSearchSupportForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.