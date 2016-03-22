unit K598118986;
 {* [Requestlink:598118986] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K598118986.pas"
// Стереотип: "TestCase"
// Элемент модели: "K598118986" MUID: (553E2D2501E2)
// Имя типа: "TK598118986"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK598118986 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:598118986] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK598118986
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK598118986.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK598118986.GetFolder

function TK598118986.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '553E2D2501E2';
end;//TK598118986.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK598118986.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
