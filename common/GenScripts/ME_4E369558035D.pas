unit PrimListAnalize_Form;
 {* Анализ списка }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\PrimListAnalize_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimListAnalize" MUID: (4E369558035D)
// Имя типа: "TPrimListAnalizeForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , WorkWithListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _ListAnalizeUserTypes_Parent_ = TvcmEntityForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\ListAnalizeUserTypes.imp.pas}
 TPrimListAnalizeForm = class(_ListAnalizeUserTypes_)
  {* Анализ списка }
  private
   ViewArea: IdsListAnalize;
  protected
   sdsList: IsdsList;
  private
   procedure UpdateTabAction(aSender: TObject);
   procedure ExecuteTabAction(aSender: TObject);
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure BecomeActive; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimListAnalizeForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

{$If NOT Defined(NoVCM)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\ListAnalizeUserTypes.imp.pas}

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

procedure TPrimListAnalizeForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
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

procedure TPrimListAnalizeForm.SignalDataSourceChanged(const anOld: IvcmFormDataSource;
 const aNew: IvcmFormDataSource);
begin
 inherited;
end;//TPrimListAnalizeForm.SignalDataSourceChanged

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimListAnalizeForm);
 {* Регистрация PrimListAnalize }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
