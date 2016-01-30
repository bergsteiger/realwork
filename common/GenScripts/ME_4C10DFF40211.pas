unit K204931515;
 {* [RequestLink:204931515]. }

// Модуль: "w:\common\components\rtl\Garant\Daily\K204931515.pas"
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
 TK204931515 = class(TScrollTest)
  {* [RequestLink:204931515]. }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK204931515
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK204931515.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK204931515.GetFolder

function TK204931515.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C10DFF40211';
end;//TK204931515.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK204931515.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
