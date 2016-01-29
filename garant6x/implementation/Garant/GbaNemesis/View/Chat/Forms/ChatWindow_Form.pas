unit ChatWindow_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Chat/Forms/ChatWindow_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Встроенные продукты::Chat::View::Chat::BaseChat::ChatWindow
//
// Переписка
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
  BaseChatWindowOptions_Form
  {$If defined(Nemesis)}
  ,
  nscChatMemo
  {$IfEnd} //Nemesis
  ,
  vtProportionalPanel,
  vtSizeablePanel,
  vtPanel,
  AbstractHistory_Form,
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
    { ChatWindowIDs }
   fm_ChatWindowForm : TvcmFormDescriptor = (rFormID : (rName : 'ChatWindowForm'; rID : 0); rFactory : nil);
    { Идентификатор формы TChatWindowForm }

type
 ChatWindowFormDef = interface(IUnknown)
  {* Идентификатор формы ChatWindow }
   ['{BD39AB6D-74A5-4A07-80BA-F529342D3B8A}']
 end;//ChatWindowFormDef

  TChatWindowForm = {final form} class(TBaseChatWindowOptionsForm, ChatWindowFormDef)
   {* Переписка }
  Entities : TvcmEntities;
  end;//TChatWindowForm
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
  ChatWindowKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация ChatWindow
 TtfwClassRef.Register(TChatWindowForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// Регистрация фабрики формы ChatWindow
 fm_ChatWindowForm.SetFactory(TChatWindowForm.Make);
{$IfEnd} //not Admin AND not Monitorings

end.