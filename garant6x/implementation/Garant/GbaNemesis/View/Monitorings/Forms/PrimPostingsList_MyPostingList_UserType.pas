unit PrimPostingsList_MyPostingList_UserType;
 {* ПРАЙМ. Моя новостная лента }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\Forms\PrimPostingsList_MyPostingList_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "MyPostingList" MUID: (4BD71E5E01D4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки MyPostingListLocalConstants }
 str_MyPostingListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MyPostingListCaption'; rValue : 'ПРАЙМ. Моя новостная лента');
  {* Заголовок пользовательского типа "ПРАЙМ. Моя новостная лента" }
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

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_MyPostingList = {final} class(TtfwInteger)
  {* Слово словаря для типа формы MyPostingList }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_MyPostingList
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_MyPostingList.GetInteger: Integer;
begin
 Result := MyPostingList;
end;//Tkw_FormUserType_MyPostingList.GetInteger

class function Tkw_FormUserType_MyPostingList.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::MyPostingList';
end;//Tkw_FormUserType_MyPostingList.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_MyPostingListCaption.Init;
 {* Инициализация str_MyPostingListCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_MyPostingList.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_MyPostingList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
