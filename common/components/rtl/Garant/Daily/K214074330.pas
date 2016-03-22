unit K214074330;
 {* [RequestLink:214074330] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K214074330.pas"
// Стереотип: "TestCase"
// Элемент модели: "K214074330" MUID: (4C10D71D00E5)
// Имя типа: "TK214074330"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDSectionRepairTest
;

type
 TK214074330 = class(TEVDtoEVDSectionRepairTest)
  {* [RequestLink:214074330] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK214074330
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK214074330.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK214074330.GetFolder

function TK214074330.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C10D71D00E5';
end;//TK214074330.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK214074330.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
