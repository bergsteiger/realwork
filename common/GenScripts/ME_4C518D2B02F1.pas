unit K228693052;
 {* [RequestLink:228693052] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K228693052.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDSectionRepairTest
;

type
 TK228693052 = class(TEVDtoEVDSectionRepairTest)
  {* [RequestLink:228693052] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK228693052
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK228693052.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK228693052.GetFolder

function TK228693052.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C518D2B02F1';
end;//TK228693052.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK228693052.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
