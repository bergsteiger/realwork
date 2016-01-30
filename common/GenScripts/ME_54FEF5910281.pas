unit K590541952;
 {* [Requestlink:590541952] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K590541952.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK590541952 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:590541952] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK590541952
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK590541952.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK590541952.GetFolder

function TK590541952.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '54FEF5910281';
end;//TK590541952.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK590541952.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
