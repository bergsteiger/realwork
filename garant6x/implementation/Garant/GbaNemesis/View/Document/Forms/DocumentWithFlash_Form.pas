unit DocumentWithFlash_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/Forms/DocumentWithFlash_Form.pas"
// Начат: 05.02.2009 19:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Работа с документом и списком документов::Document::View::Document::Document::DocumentWithFlash
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
  Common_FormDefinitions_Controls,
  PrimDocumentWithFlashOptions_Form,
  Classes {a},
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  TDocumentWithFlashForm = {final form} class(TPrimDocumentWithFlashOptionsForm, DocumentWithFlashFormDef)
  Entities : TvcmEntities;
  protected
  // realized methods
   procedure Document_CommonDocumentOpenNewWindow_Execute(aUserType: Integer);
     {* Что это? }
   procedure Document_CommonDocumentOpenNewWindow(const aParams: IvcmExecuteParams);
     {* Что это? }
   procedure Document_CommonDocumentOpenNewTab_Execute(aUserType: Integer);
   procedure Document_CommonDocumentOpenNewTab(const aParams: IvcmExecuteParams);
  end;//TDocumentWithFlashForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$R *.DFM}

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  DocumentWithFlashKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  Common_Strange_Controls
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TDocumentWithFlashForm

procedure TDocumentWithFlashForm.Document_CommonDocumentOpenNewWindow_Execute(aUserType: Integer);
//#UC START# *4A8EF02E007D_4989E67D00C0exec_var*
//#UC END# *4A8EF02E007D_4989E67D00C0exec_var*
begin
//#UC START# *4A8EF02E007D_4989E67D00C0exec_impl*
 Assert(false, 'Коллеги, тут что-то кто-то недоделал');
//#UC END# *4A8EF02E007D_4989E67D00C0exec_impl*
end;//TDocumentWithFlashForm.Document_CommonDocumentOpenNewWindow_Execute

procedure TDocumentWithFlashForm.Document_CommonDocumentOpenNewWindow(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IDocument_CommonDocumentOpenNewWindow_Params) do
  Document_CommonDocumentOpenNewWindow_Execute(UserType);
end;

procedure TDocumentWithFlashForm.Document_CommonDocumentOpenNewTab_Execute(aUserType: Integer);
//#UC START# *55545C63026E_4989E67D00C0exec_var*
//#UC END# *55545C63026E_4989E67D00C0exec_var*
begin
//#UC START# *55545C63026E_4989E67D00C0exec_impl*
 Assert(false, 'Коллеги, тут что-то кто-то недоделал');
//#UC END# *55545C63026E_4989E67D00C0exec_impl*
end;//TDocumentWithFlashForm.Document_CommonDocumentOpenNewTab_Execute

procedure TDocumentWithFlashForm.Document_CommonDocumentOpenNewTab(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IDocument_CommonDocumentOpenNewTab_Params) do
  Document_CommonDocumentOpenNewTab_Execute(UserType);
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация DocumentWithFlash
 TtfwClassRef.Register(TDocumentWithFlashForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// Регистрация фабрики формы DocumentWithFlash
 fm_DocumentWithFlashForm.SetFactory(TDocumentWithFlashForm.Make);
{$IfEnd} //not Admin AND not Monitorings

end.