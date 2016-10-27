unit QFLikeTextLoad_ut_QFLikeTextLoad_UserType;
 {* Форма для работы с КЗ }

// Модуль: "w:\common\components\gui\Garant\Daily\Forms\QFLikeTextLoad_ut_QFLikeTextLoad_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ut_QFLikeTextLoad" MUID: (15CBBB7D03D3)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки ut_QFLikeTextLoadLocalConstants }
 str_ut_QFLikeTextLoadCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_QFLikeTextLoadCaption'; rValue : 'Форма для работы с КЗ');
  {* Заголовок пользовательского типа "Форма для работы с КЗ" }
 {* Константы для типа формы ut_QFLikeTextLoad }
 ut_QFLikeTextLoadName = 'ut_QFLikeTextLoad';
  {* Строковый идентификатор пользовательского типа "Форма для работы с КЗ" }
 ut_QFLikeTextLoad = TvcmUserType(0);
  {* Форма для работы с КЗ }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_QFLikeTextLoad = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_QFLikeTextLoad }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_QFLikeTextLoad
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_QFLikeTextLoad.GetInteger: Integer;
begin
 Result := ut_QFLikeTextLoad;
end;//Tkw_FormUserType_ut_QFLikeTextLoad.GetInteger

class function Tkw_FormUserType_ut_QFLikeTextLoad.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_QFLikeTextLoad';
end;//Tkw_FormUserType_ut_QFLikeTextLoad.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_QFLikeTextLoadCaption.Init;
 {* Инициализация str_ut_QFLikeTextLoadCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_QFLikeTextLoad.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_QFLikeTextLoad }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
