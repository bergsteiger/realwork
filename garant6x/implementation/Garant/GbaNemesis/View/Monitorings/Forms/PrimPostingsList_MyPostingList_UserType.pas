unit PrimPostingsList_MyPostingList_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Monitorings/Forms/PrimPostingsList_MyPostingList_UserType.pas"
// Начат: 15.09.2009 18:14
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::PostingOrder::View::Monitorings::PrimPostingsList::MyPostingList
//
// ПРАЙМ. Моя новостная лента
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы MyPostingList }
  MyPostingListName = 'MyPostingList';
   { Строковый идентификатор пользовательского типа "ПРАЙМ. Моя новостная лента" }
  MyPostingList = TvcmUserType(0);
   { ПРАЙМ. Моя новостная лента }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_MyPostingList = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы MyPostingList }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_MyPostingList
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_MyPostingList

class function Tkw_FormUserType_MyPostingList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::MyPostingList';
end;//Tkw_FormUserType_MyPostingList.GetWordNameForRegister

function Tkw_FormUserType_MyPostingList.GetInteger: Integer;
 {-}
begin
 Result := MyPostingList;
end;//Tkw_FormUserType_MyPostingList.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_MyPostingList
 Tkw_FormUserType_MyPostingList.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.