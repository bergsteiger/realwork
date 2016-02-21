unit K226005005;
 {* [$226005005] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K226005005.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDOEMTableFlagTest
;

type
 TK226005005 = class(TEVDtoEVDOEMTableFlagTest)
  {* [$226005005] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK226005005
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK226005005.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK226005005.GetFolder

function TK226005005.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C3FEEC100C1';
end;//TK226005005.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK226005005.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
