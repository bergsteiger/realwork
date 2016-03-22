unit K599800930;
 {* [Requestlink:599800930] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K599800930.pas"
// Стереотип: "TestCase"
// Элемент модели: "K599800930" MUID: (5559ED00003A)
// Имя типа: "TK599800930"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK599800930 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:599800930] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK599800930
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK599800930.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK599800930.GetFolder

function TK599800930.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5559ED00003A';
end;//TK599800930.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK599800930.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
