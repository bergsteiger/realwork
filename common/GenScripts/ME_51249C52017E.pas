unit K356070665;
 {* [Reqeustlink:356070665] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K356070665.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK356070665 = class(TRTFtoEVDWriterTest)
  {* [Reqeustlink:356070665] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK356070665
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK356070665.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK356070665.GetFolder

function TK356070665.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51249C52017E';
end;//TK356070665.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK356070665.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
