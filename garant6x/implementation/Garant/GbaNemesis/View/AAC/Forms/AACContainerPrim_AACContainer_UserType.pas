unit AACContainerPrim_AACContainer_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACContainerPrim_AACContainer_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "AACContainer" MUID: (4FF2EADD02A4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки AACContainerLocalConstants }
 str_AACContainerCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AACContainerCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Константы для типа формы AACContainer }
 AACContainerName = 'AACContainer';
  {* Строковый идентификатор пользовательского типа "" }
 AACContainer = TvcmUserType(0);
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
 Tkw_FormUserType_AACContainer = {final} class(TtfwInteger)
  {* Слово словаря для типа формы AACContainer }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_AACContainer
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_AACContainer.GetInteger: Integer;
begin
 Result := AACContainer;
end;//Tkw_FormUserType_AACContainer.GetInteger

class function Tkw_FormUserType_AACContainer.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::AACContainer';
end;//Tkw_FormUserType_AACContainer.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_AACContainerCaption.Init;
 {* Инициализация str_AACContainerCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_AACContainer.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_AACContainer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
