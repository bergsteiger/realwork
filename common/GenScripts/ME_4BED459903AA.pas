unit K210043095;
 {* [RequestLink:210043095] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K210043095.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK210043095 = class(TNSRCtoEVDTest)
  {* [RequestLink:210043095] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK210043095
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK210043095.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK210043095.GetFolder

function TK210043095.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BED459903AA';
end;//TK210043095.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK210043095.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
