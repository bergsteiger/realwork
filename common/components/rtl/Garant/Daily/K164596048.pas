unit K164596048;
 {* [$164596048] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K164596048.pas"
// Стереотип: "TestCase"
// Элемент модели: "K164596048" MUID: (4B7C1B6B02F2)
// Имя типа: "TK164596048"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK164596048 = class(TEVDtoNSRCPlusWriterTest)
  {* [$164596048] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK164596048
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4B7C1B6B02F2impl_uses*
 //#UC END# *4B7C1B6B02F2impl_uses*
;

function TK164596048.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TK164596048.GetFolder

function TK164596048.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4B7C1B6B02F2';
end;//TK164596048.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK164596048.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
