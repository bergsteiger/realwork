unit ChatHistory_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Chat/Forms/ChatHistory_Form.pas"
// Начат: 2009/07/28 06:34:54
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Встроенные продукты::Chat::View::Chat::BaseChat::ChatHistory
//
// История переписки
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
  BaseHistoryWindow_Form
  {$If defined(Nemesis)}
  ,
  nscChatMemo
  {$IfEnd} //Nemesis
  ,
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
    { ChatHistoryIDs }
   fm_ChatHistoryForm : TvcmFormDescriptor = (rFormID : (rName : 'ChatHistoryForm'; rID : 0); rFactory : nil);
    { Идентификатор формы TChatHistoryForm }

type
 ChatHistoryFormDef = interface(IUnknown)
  {* Идентификатор формы ChatHistory }
   ['{5B6E40C6-04D1-47E4-B97A-0C7AB1B3D1F9}']
 end;//ChatHistoryFormDef

  TChatHistoryForm = {final form} class(TBaseHistoryWindowForm, ChatHistoryFormDef)
   {* История переписки }
  Entities : TvcmEntities;
  end;//TChatHistoryForm
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
  ChatHistoryKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация ChatHistory
 TtfwClassRef.Register(TChatHistoryForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// Регистрация фабрики формы ChatHistory
 fm_ChatHistoryForm.SetFactory(TChatHistoryForm.Make);
{$IfEnd} //not Admin AND not Monitorings

end.