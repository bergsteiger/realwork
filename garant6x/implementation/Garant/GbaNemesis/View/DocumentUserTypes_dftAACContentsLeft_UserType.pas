unit DocumentUserTypes_dftAACContentsLeft_UserType;
 {* Левая часть оглавления Энциклопедии решений }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAACContentsLeft_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "dftAACContentsLeft" MUID: (4FF43F4B0071)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAACRight_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки dftAACContentsLeftLocalConstants }
 str_dftAACContentsLeftCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACContentsLeftCaption'; rValue : 'Левая часть оглавления Энциклопедии решений');
  {* Заголовок пользовательского типа "Левая часть оглавления Энциклопедии решений" }
 {* Константы для типа формы dftAACContentsLeft }
 dftAACContentsLeftName = 'dftAACContentsLeft';
  {* Строковый идентификатор пользовательского типа "Левая часть оглавления Энциклопедии решений" }
 dftAACContentsLeft = TvcmUserType(dftAACRight + 1);
  {* Левая часть оглавления Энциклопедии решений }
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
 Tkw_FormUserType_dftAACContentsLeft = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftAACContentsLeft }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftAACContentsLeft
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftAACContentsLeft.GetInteger: Integer;
begin
 Result := dftAACContentsLeft;
end;//Tkw_FormUserType_dftAACContentsLeft.GetInteger

class function Tkw_FormUserType_dftAACContentsLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftAACContentsLeft';
end;//Tkw_FormUserType_dftAACContentsLeft.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftAACContentsLeftCaption.Init;
 {* Инициализация str_dftAACContentsLeftCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAACContentsLeft.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftAACContentsLeft }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
