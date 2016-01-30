unit K608626880;
 {* [Requestlink:608626880] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K608626880.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK608626880 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:608626880] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK608626880
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK608626880.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK608626880.GetFolder

function TK608626880.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '561CDC9B03CA';
end;//TK608626880.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK608626880.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
