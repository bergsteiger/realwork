unit ListAnalizer_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/List/Forms/ListAnalizer_Form.pas"
// Начат: 31.08.2009 20:51
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Работа с документом и списком документов::WorkWithList::View::List::List$FP::ListAnalizer
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
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  PrimListAnalizer_Form,
  vtPanel,
  eeTreeView,
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
    { ListAnalizerIDs }
   fm_ListAnalizerForm : TvcmFormDescriptor = (rFormID : (rName : 'ListAnalizerForm'; rID : 0); rFactory : nil);
    { Идентификатор формы TListAnalizerForm }

type
 ListAnalizerFormDef = interface(IUnknown)
  {* Идентификатор формы ListAnalizer }
   ['{534B1ADF-ACC6-4DD9-AF54-C92914E3CBA4}']
 end;//ListAnalizerFormDef

  TListAnalizerForm = {final form} class(TPrimListAnalizerForm, ListAnalizerFormDef)
   {* Анализ списка }
  Entities : TvcmEntities;
  end;//TListAnalizerForm
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
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ListAnalizerKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация ListAnalizer
 TtfwClassRef.Register(TListAnalizerForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.