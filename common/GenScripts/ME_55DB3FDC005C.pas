unit K606118757;
 {* [RequestLink:606118757] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K606118757.pas"
// Стереотип: "TestCase"
// Элемент модели: "K606118757" MUID: (55DB3FDC005C)
// Имя типа: "TK606118757"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK606118757 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:606118757] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK606118757
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK606118757.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK606118757.GetFolder

function TK606118757.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55DB3FDC005C';
end;//TK606118757.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK606118757.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
