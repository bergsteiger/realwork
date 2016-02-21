unit PrimPostingsList_MyPostingList_UserType;
 {* ПРАЙМ. Моя новостная лента }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\Forms\PrimPostingsList_MyPostingList_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы MyPostingList }
 MyPostingListName = 'MyPostingList';
  {* Строковый идентификатор пользовательского типа "ПРАЙМ. Моя новостная лента" }
 MyPostingList = TvcmUserType(0);
  {* ПРАЙМ. Моя новостная лента }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_MyPostingList = {final} class(TtfwInteger)
  {* Слово словаря для типа формы MyPostingList }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_MyPostingList
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_MyPostingList.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::MyPostingList';
end;//Tkw_FormUserType_MyPostingList.GetWordNameForRegister

function Tkw_FormUserType_MyPostingList.GetInteger: Integer;
begin
 Result := MyPostingList;
end;//Tkw_FormUserType_MyPostingList.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_MyPostingList.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_MyPostingList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
