unit K217680744;
 {* [RequestLink:217680744] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K217680744.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK217680744 = class(TScrollTest)
  {* [RequestLink:217680744] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK217680744
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK217680744.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK217680744.GetFolder

function TK217680744.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C1F3E7901A7';
end;//TK217680744.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217680744.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
