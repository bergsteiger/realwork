unit MainMenuWithBaseSearchSupport_Form;
 {* Основное меню с поддержкой базового поиска }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\MainMenuWithBaseSearchSupport_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "MainMenuWithBaseSearchSupport" MUID: (4AC99EBE0106)
// Имя типа: "TMainMenuWithBaseSearchSupportForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimMainMenu_Form
 , BaseSearchInterfaces
;

type
 _BaseSearchPresentationFor296635421_Parent_ = TPrimMainMenuForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearchPresentationFor296635421.imp.pas}
 TMainMenuWithBaseSearchSupportForm = {abstract} class(_BaseSearchPresentationFor296635421_, InsBaseSearchPresentation, InsMainMenuLikeBaseSearchOwner)
  {* Основное меню с поддержкой базового поиска }
  protected
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
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CreateFormGUID(var theGUID: TGUID); override;
    {* Создаёт идентификатор формы. Для того, чтобы отличать однотипные формы друг от друга. В частности для истории. }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function SupportDisabled: Boolean;
   {$If Defined(l3HackedVCL) AND NOT Defined(NoVCL)}
   function NeedAutoScroll: Boolean; override;
   {$IfEnd} // Defined(l3HackedVCL) AND NOT Defined(NoVCL)
 end;//TMainMenuWithBaseSearchSupportForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsMainMenuFormGUIDFactory
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 , l3InterfacesMisc
 , nsBaseSearchService
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , afwFacade
;

type _Instance_R_ = TMainMenuWithBaseSearchSupportForm;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearchPresentationFor296635421.imp.pas}

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

{$If NOT Defined(NoVCM)}
procedure TMainMenuWithBaseSearchSupportForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If Defined(l3HackedVCL) AND NOT Defined(NoVCL)}
function TMainMenuWithBaseSearchSupportForm.NeedAutoScroll: Boolean;
//#UC START# *4B0E845502C1_4AC99EBE0106_var*
//#UC END# *4B0E845502C1_4AC99EBE0106_var*
begin
//#UC START# *4B0E845502C1_4AC99EBE0106_impl*
 Result := false;
//#UC END# *4B0E845502C1_4AC99EBE0106_impl*
end;//TMainMenuWithBaseSearchSupportForm.NeedAutoScroll
{$IfEnd} // Defined(l3HackedVCL) AND NOT Defined(NoVCL)

{$If NOT Defined(NoVCM)}
procedure TMainMenuWithBaseSearchSupportForm.CreateFormGUID(var theGUID: TGUID);
 {* Создаёт идентификатор формы. Для того, чтобы отличать однотипные формы друг от друга. В частности для истории. }
//#UC START# *4EBBC63E032A_4AC99EBE0106_var*
//#UC END# *4EBBC63E032A_4AC99EBE0106_var*
begin
//#UC START# *4EBBC63E032A_4AC99EBE0106_impl*
 TnsMainMenuFormGUIDFactory.Instance.CreateFormGUID(Self.As_IvcmEntityForm, theGUID);
 // http://mdp.garant.ru/pages/viewpage.action?pageId=326773370&focusedCommentId=330698414#comment-330698414
//#UC END# *4EBBC63E032A_4AC99EBE0106_impl*
end;//TMainMenuWithBaseSearchSupportForm.CreateFormGUID
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMainMenuWithBaseSearchSupportForm);
 {* Регистрация MainMenuWithBaseSearchSupport }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
