unit K610746048;
 {* [Requestlink:610746048] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K610746048.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK610746048 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:610746048] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK610746048
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK610746048.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK610746048.GetFolder

function TK610746048.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '563C60A6017B';
end;//TK610746048.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK610746048.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
