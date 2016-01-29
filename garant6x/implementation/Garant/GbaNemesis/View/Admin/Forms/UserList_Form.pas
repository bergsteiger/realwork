unit UserList_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/UserList_Form.pas"
// Начат: 07.09.2009 18:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Администратор::Admin::View::Admin::Admin::UserList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  PrimUserListOptions_Form,
  Admin_FormDefinitions_Controls,
  vtPanel
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  eeTreeView,
  Classes {a},
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
  TefUserList = {final form} class(TPrimUserListOptionsForm, UserListFormDef)
  Entities : TvcmEntities;
  end;//TefUserList

  TUserListForm = TefUserList;
{$IfEnd} //Admin

implementation

{$R *.DFM}

{$If defined(Admin)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If defined(Admin) AND not defined(NoScripts)}
  ,
  UserListKeywordsPack
  {$IfEnd} //Admin AND not NoScripts
  
  ;
{$IfEnd} //Admin

{$If defined(Admin)}


{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация UserList
 TtfwClassRef.Register(TefUserList);
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin)}
// Регистрация фабрики формы UserList
 fm_efUserList.SetFactory(TefUserList.Make);
{$IfEnd} //Admin

end.