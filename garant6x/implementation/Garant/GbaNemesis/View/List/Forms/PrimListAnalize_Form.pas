unit PrimListAnalize_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/List/Forms/PrimListAnalize_Form.pas"
// Начат: 01.08.2011 16:01
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::WorkWithList::View::List::PrimListAnalize
//
// Анализ списка
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
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  ,
  WorkWithListInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  ListAnalizeUserTypes_Analize_UserType,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmControllers {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _ListAnalizeUserTypes_Parent_ = TvcmEntityForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\ListAnalizeUserTypes.imp.pas}
 TPrimListAnalizeForm = {form} class(_ListAnalizeUserTypes_)
  {* Анализ списка }
 private
 // private fields
   ViewArea : IdsListAnalize;
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
 private
 // private methods
   procedure UpdateTabAction(aSender: TObject);
   procedure ExecuteTabAction(aSender: TObject);
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure BecomeActive; override;
   {$IfEnd} //not NoVCM
 protected
 // protected fields
   sdsList : IsdsList;
 end;//TPrimListAnalizeForm

 TvcmEntityFormRef = TPrimListAnalizeForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoVCL)}
  ,
  ActnList
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\ListAnalizeUserTypes.imp.pas}

// start class TPrimListAnalizeForm

procedure TPrimListAnalizeForm.UpdateTabAction(aSender: TObject);
//#UC START# *4E36B621000E_4E369558035D_var*
//#UC END# *4E36B621000E_4E369558035D_var*
begin
//#UC START# *4E36B621000E_4E369558035D_impl*
 // - ничего пока не делаем, но скорее всео придётся - параметры вкладки править
 // Так и есть:
 (aSender As TAction).Caption := str_AnalizeCaption.AsStr;
//#UC END# *4E36B621000E_4E369558035D_impl*
end;//TPrimListAnalizeForm.UpdateTabAction

procedure TPrimListAnalizeForm.ExecuteTabAction(aSender: TObject);
//#UC START# *4E36B63D016B_4E369558035D_var*
//#UC END# *4E36B63D016B_4E369558035D_var*
begin
//#UC START# *4E36B63D016B_4E369558035D_impl*
 if not Self.FocusLocked then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=356848399
  TdmStdRes.MakeListAnalizer(sdsList.dsList.MakeAnalizeTree);
//#UC END# *4E36B63D016B_4E369558035D_impl*
end;//TPrimListAnalizeForm.ExecuteTabAction

{$If not defined(NoVCM)}
procedure TPrimListAnalizeForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_4E369558035D_var*
var
 l_Action : TAction;
//#UC END# *49803F5503AA_4E369558035D_var*
begin
//#UC START# *49803F5503AA_4E369558035D_impl*
 inherited;
 if (Parent <> nil) then
 begin
  l_Action := TAction.Create(Self);
  l_Action.OnUpdate := UpdateTabAction;
  l_Action.OnExecute := ExecuteTabAction;
  Parent.Action := l_Action;
 end;//Parent <> nil
//#UC END# *49803F5503AA_4E369558035D_impl*
end;//TPrimListAnalizeForm.DoInit
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListAnalizeForm.BecomeActive;
//#UC START# *4A8AE0FA03B2_4E369558035D_var*
//#UC END# *4A8AE0FA03B2_4E369558035D_var*
begin
//#UC START# *4A8AE0FA03B2_4E369558035D_impl*
 inherited;
 Assert(false);
 //SetInactiveInParent;
 // TdmStdRes.MakeListAnalizer(dsDocumentList.MakeAnalizeTree);
//#UC END# *4A8AE0FA03B2_4E369558035D_impl*
end;//TPrimListAnalizeForm.BecomeActive
{$IfEnd} //not NoVCM

procedure TPrimListAnalizeForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  ViewArea := nil;
  sdsList := nil;
 end//aDsNew = nil
 else
 begin
  Supports(aDsNew, IdsListAnalize, ViewArea);
  aDsNew.CastUCC(IsdsList, sdsList);
 end;//aDsNew = nil
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\ListAnalizeUserTypes.imp.pas}
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimListAnalize
 TtfwClassRef.Register(TPrimListAnalizeForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.