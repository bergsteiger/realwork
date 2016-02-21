unit K276537900;
 {* [Requestlink:276537900]. Тест на проверку изменения широкой ячейки после изменения ширины ячейки под ней. }

// Модуль: "w:\common\components\rtl\Garant\Daily\K276537900.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AutoTest
;

type
 TK276537900 = class(TAutoTest)
  {* [Requestlink:276537900]. Тест на проверку изменения широкой ячейки после изменения ширины ячейки под ней. }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK276537900
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK276537900.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ScriptTest';
end;//TK276537900.GetFolder

function TK276537900.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E3684550188';
end;//TK276537900.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK276537900.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
