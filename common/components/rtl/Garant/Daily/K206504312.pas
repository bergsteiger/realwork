unit K206504312;
 {* [RequestLink:206504312] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K206504312.pas"
// Стереотип: "TestCase"
// Элемент модели: "K206504312" MUID: (4BD6754101C4)
// Имя типа: "TK206504312"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK206504312 = class(TEVDtoNSRCOldWriterTest)
  {* [RequestLink:206504312] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK206504312
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4BD6754101C4impl_uses*
 //#UC END# *4BD6754101C4impl_uses*
;

function TK206504312.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK206504312.GetFolder

function TK206504312.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BD6754101C4';
end;//TK206504312.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK206504312.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
