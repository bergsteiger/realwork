unit AACContainerPrim_AACContentsContainer_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACContainerPrim_AACContentsContainer_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "AACContentsContainer" MUID: (504879B60226)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , AACContainerPrim_AACContainer_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки AACContentsContainerLocalConstants }
 str_AACContentsContainerCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AACContentsContainerCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Константы для типа формы AACContentsContainer }
 AACContentsContainerName = 'AACContentsContainer';
  {* Строковый идентификатор пользовательского типа "" }
 AACContentsContainer = TvcmUserType(AACContainer + 1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_AACContentsContainer = {final} class(TtfwInteger)
  {* Слово словаря для типа формы AACContentsContainer }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_AACContentsContainer
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_AACContentsContainer.GetInteger: Integer;
begin
 Result := AACContentsContainer;
end;//Tkw_FormUserType_AACContentsContainer.GetInteger

class function Tkw_FormUserType_AACContentsContainer.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::AACContentsContainer';
end;//Tkw_FormUserType_AACContentsContainer.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_AACContentsContainerCaption.Init;
 {* Инициализация str_AACContentsContainerCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_AACContentsContainer.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_AACContentsContainer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
