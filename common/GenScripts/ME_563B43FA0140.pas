unit K610745702;
 {* [Requestlink:610745702] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K610745702.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK610745702 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:610745702] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK610745702
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK610745702.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK610745702.GetFolder

function TK610745702.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '563B43FA0140';
end;//TK610745702.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK610745702.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
