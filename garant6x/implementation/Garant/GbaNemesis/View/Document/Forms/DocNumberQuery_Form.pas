unit DocNumberQuery_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/Forms/DocNumberQuery_Form.pas"
// Начат: 16.09.2009 22:49
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Работа с документом и списком документов::Document::View::Document::Document::DocNumberQuery
//
// Открыть документ по номеру
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
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx,
  PrimDocNumberQueryOptions_Form
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  DocNumberQuery_ut_DocNumberQuery_UserType,
  vtLabel
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtCheckBox,
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
    { DocNumberQueryIDs }
   fm_DocNumberQueryForm : TvcmFormDescriptor = (rFormID : (rName : 'DocNumberQueryForm'; rID : 0); rFactory : nil);
    { Идентификатор формы TDocNumberQueryForm }

type
 DocNumberQueryFormDef = interface(IUnknown)
  {* Идентификатор формы DocNumberQuery }
   ['{A522FA71-1132-495B-A68D-0533C12052F1}']
 end;//DocNumberQueryFormDef

  TDocNumberQueryForm = {final form} class(TPrimDocNumberQueryOptionsForm, DocNumberQueryFormDef)
   {* Открыть документ по номеру }
  Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
  end;//TDocNumberQueryForm
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
  l3MessageID
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  DocNumberQueryKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
    { Локализуемые строки ut_DocNumberQueryLocalConstants }
   str_ut_DocNumberQueryCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_DocNumberQueryCaption'; rValue : 'Открыть документ по номеру');
    { Заголовок пользовательского типа "Открыть документ по номеру" }

// start class TDocNumberQueryForm

procedure TDocNumberQueryForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_DocNumberQueryName,
  str_ut_DocNumberQueryCaption,
  str_ut_DocNumberQueryCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_DocNumberQueryName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация DocNumberQuery
 TtfwClassRef.Register(TDocNumberQueryForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_ut_DocNumberQueryCaption
 str_ut_DocNumberQueryCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.