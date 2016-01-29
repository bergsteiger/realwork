unit ListUserTypes_lftUserCRList2_SynchorForm_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftUserCRList2_SynchorForm_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftUserCRList2_SynchorForm
//
// Синхронный просмотр (настраиваемая вкладка связанных документов 2)
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
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  ListUserTypes_lftUserCRList1_SynchorForm_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы lftUserCRList2_SynchorForm }
  lftUserCRList2_SynchorFormName = 'lftUserCRList2_SynchorForm';
   { Строковый идентификатор пользовательского типа "Синхронный просмотр (настраиваемая вкладка связанных документов 2)" }
  lftUserCRList2_SynchorForm = TvcmUserType(lftUserCRList1_SynchorForm + 1);
   { Синхронный просмотр (настраиваемая вкладка связанных документов 2) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftUserCRList2_SynchorForm = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы lftUserCRList2_SynchorForm }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftUserCRList2_SynchorForm
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftUserCRList2_SynchorForm

class function Tkw_FormUserType_lftUserCRList2_SynchorForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::lftUserCRList2_SynchorForm';
end;//Tkw_FormUserType_lftUserCRList2_SynchorForm.GetWordNameForRegister

function Tkw_FormUserType_lftUserCRList2_SynchorForm.GetInteger: Integer;
 {-}
begin
 Result := lftUserCRList2_SynchorForm;
end;//Tkw_FormUserType_lftUserCRList2_SynchorForm.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_lftUserCRList2_SynchorForm
 Tkw_FormUserType_lftUserCRList2_SynchorForm.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.