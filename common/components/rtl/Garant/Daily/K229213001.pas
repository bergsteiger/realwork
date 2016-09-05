unit K229213001;
 {* [RequestLink:229213001] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K229213001.pas"
// Стереотип: "TestCase"
// Элемент модели: "K229213001" MUID: (4C5183260027)
// Имя типа: "TK229213001"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , SearchAndReplaceTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK229213001 = class({$If NOT Defined(NoVCM)}
 TSearchAndReplaceTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [RequestLink:229213001] }
  protected
   {$If NOT Defined(NoVCM)}
   function StringForSearch: AnsiString; override;
    {* Строка для поиска }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function StringForReplace: AnsiString; override;
    {* Строка для замены }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK229213001
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4C5183260027impl_uses*
 //#UC END# *4C5183260027impl_uses*
;

{$If NOT Defined(NoVCM)}
function TK229213001.StringForSearch: AnsiString;
 {* Строка для поиска }
//#UC START# *4BE051200169_4C5183260027_var*
//#UC END# *4BE051200169_4C5183260027_var*
begin
//#UC START# *4BE051200169_4C5183260027_impl*
 Result := 'bbb';
//#UC END# *4BE051200169_4C5183260027_impl*
end;//TK229213001.StringForSearch

function TK229213001.StringForReplace: AnsiString;
 {* Строка для замены }
//#UC START# *4BE0513800C9_4C5183260027_var*
//#UC END# *4BE0513800C9_4C5183260027_var*
begin
//#UC START# *4BE0513800C9_4C5183260027_impl*
 Result := #13#10;
//#UC END# *4BE0513800C9_4C5183260027_impl*
end;//TK229213001.StringForReplace

function TK229213001.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK229213001.GetFolder

function TK229213001.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C5183260027';
end;//TK229213001.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK229213001.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
