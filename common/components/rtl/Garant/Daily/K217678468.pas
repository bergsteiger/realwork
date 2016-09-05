unit K217678468;
 {* [RequestLink:217678468]. }

// Модуль: "w:\common\components\rtl\Garant\Daily\K217678468.pas"
// Стереотип: "TestCase"
// Элемент модели: "K217678468" MUID: (4C1A41370283)
// Имя типа: "TK217678468"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDSectionRepairTest
;

type
 TK217678468 = class(TEVDtoEVDSectionRepairTest)
  {* [RequestLink:217678468]. }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK217678468
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4C1A41370283impl_uses*
 //#UC END# *4C1A41370283impl_uses*
;

function TK217678468.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK217678468.GetFolder

function TK217678468.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C1A41370283';
end;//TK217678468.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217678468.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
