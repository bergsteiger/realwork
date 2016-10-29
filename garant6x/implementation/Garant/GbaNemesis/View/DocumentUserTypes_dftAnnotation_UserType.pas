unit DocumentUserTypes_dftAnnotation_UserType;
 {* Аннотация }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAnnotation_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "dftAnnotation" MUID: (4B040AD300BB)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftDictSubEntry_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки dftAnnotationLocalConstants }
 str_dftAnnotationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAnnotationCaption'; rValue : 'Аннотация');
  {* Заголовок пользовательского типа "Аннотация" }
 str_dftAnnotationSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAnnotationSettingsCaption'; rValue : 'Документ: Дополнительная информация');
  {* Заголовок пользовательского типа "Аннотация" для настройки панелей инструментов }
 {* Константы для типа формы dftAnnotation }
 dftAnnotationName = 'dftAnnotation';
  {* Строковый идентификатор пользовательского типа "Аннотация" }
 dftAnnotation = TvcmUserType(dftDictSubEntry + 1);
  {* Аннотация }
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
 Tkw_FormUserType_dftAnnotation = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftAnnotation }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftAnnotation
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftAnnotation.GetInteger: Integer;
begin
 Result := dftAnnotation;
end;//Tkw_FormUserType_dftAnnotation.GetInteger

class function Tkw_FormUserType_dftAnnotation.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftAnnotation';
end;//Tkw_FormUserType_dftAnnotation.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftAnnotationCaption.Init;
 {* Инициализация str_dftAnnotationCaption }
 str_dftAnnotationSettingsCaption.Init;
 {* Инициализация str_dftAnnotationSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAnnotation.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftAnnotation }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
