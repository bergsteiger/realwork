unit K606111976;
 {* [Requestlink:606111976] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K606111976.pas"
// Стереотип: "TestCase"
// Элемент модели: "K606111976" MUID: (55D729C902E7)
// Имя типа: "TK606111976"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK606111976 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:606111976] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK606111976
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK606111976.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK606111976.GetFolder

function TK606111976.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55D729C902E7';
end;//TK606111976.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK606111976.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
