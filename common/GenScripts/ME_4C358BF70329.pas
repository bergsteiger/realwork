unit K224788868;
 {* [RequestLink:224788868] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K224788868.pas"
// Стереотип: "TestCase"

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
 TK224788868 = class(TSearchAndReplaceTest)
  {* [RequestLink:224788868] }
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
 end;//TK224788868
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
;

{$If NOT Defined(NoVCM)}
function TK224788868.StringForSearch: AnsiString;
 {* Строка для поиска }
//#UC START# *4BE051200169_4C358BF70329_var*
//#UC END# *4BE051200169_4C358BF70329_var*
begin
//#UC START# *4BE051200169_4C358BF70329_impl*
 Result := 'хаба';
//#UC END# *4BE051200169_4C358BF70329_impl*
end;//TK224788868.StringForSearch
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK224788868.StringForReplace: AnsiString;
 {* Строка для замены }
//#UC START# *4BE0513800C9_4C358BF70329_var*
//#UC END# *4BE0513800C9_4C358BF70329_var*
begin
//#UC START# *4BE0513800C9_4C358BF70329_impl*
 Result := 'дабамаба';
//#UC END# *4BE0513800C9_4C358BF70329_impl*
end;//TK224788868.StringForReplace
{$IfEnd} // NOT Defined(NoVCM)

function TK224788868.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK224788868.GetFolder

function TK224788868.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C358BF70329';
end;//TK224788868.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK224788868.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
