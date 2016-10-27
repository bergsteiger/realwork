unit DocumentUserTypes_dftNone_UserType;
 {* Документ }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftNone_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "dftNone" MUID: (4B040A4A0373)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки dftNoneLocalConstants }
 str_dftNoneCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftNoneCaption'; rValue : 'Документ');
  {* Заголовок пользовательского типа "Документ" }
 {* Константы для типа формы dftNone }
 dftNoneName = 'dftNone';
  {* Строковый идентификатор пользовательского типа "Документ" }
 dftNone = TvcmUserType(0);
  {* Документ }
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
 Tkw_FormUserType_dftNone = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftNone }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftNone
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftNone.GetInteger: Integer;
begin
 Result := dftNone;
end;//Tkw_FormUserType_dftNone.GetInteger

class function Tkw_FormUserType_dftNone.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftNone';
end;//Tkw_FormUserType_dftNone.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftNoneCaption.Init;
 {* Инициализация str_dftNoneCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftNone.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftNone }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
