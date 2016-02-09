unit K209584437;
 {* [RequestLink:209584437] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K209584437.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , SearchAndReplaceTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK209584437 = class(TSearchAndReplaceTest)
  {* [RequestLink:209584437] }
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
 end;//TK209584437
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
function TK209584437.StringForSearch: AnsiString;
 {* Строка для поиска }
//#UC START# *4BE051200169_4BE122870343_var*
//#UC END# *4BE051200169_4BE122870343_var*
begin
//#UC START# *4BE051200169_4BE122870343_impl*
 Result := 'атестационная';
//#UC END# *4BE051200169_4BE122870343_impl*
end;//TK209584437.StringForSearch
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK209584437.StringForReplace: AnsiString;
 {* Строка для замены }
//#UC START# *4BE0513800C9_4BE122870343_var*
//#UC END# *4BE0513800C9_4BE122870343_var*
begin
//#UC START# *4BE0513800C9_4BE122870343_impl*
 Result := 'XXX';
//#UC END# *4BE0513800C9_4BE122870343_impl*
end;//TK209584437.StringForReplace
{$IfEnd} // NOT Defined(NoVCM)

function TK209584437.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK209584437.GetFolder

function TK209584437.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BE122870343';
end;//TK209584437.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK209584437.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
