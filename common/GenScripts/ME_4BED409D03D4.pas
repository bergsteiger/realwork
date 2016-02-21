unit K210043147;
 {* [RequestLink:210043147] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K210043147.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK210043147 = class(TNSRCtoEVDTest)
  {* [RequestLink:210043147] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK210043147
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK210043147.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK210043147.GetFolder

function TK210043147.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BED409D03D4';
end;//TK210043147.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK210043147.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
