unit K211878862;
 {* [$211878862] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K211878862.pas"
// Стереотип: "TestCase"
// Элемент модели: "K211878862" MUID: (4BEBDEBA0161)
// Имя типа: "TK211878862"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK211878862 = class(TEVDtoNSRCOldWriterTest)
  {* [$211878862] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK211878862
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4BEBDEBA0161impl_uses*
 //#UC END# *4BEBDEBA0161impl_uses*
;

function TK211878862.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TK211878862.GetFolder

function TK211878862.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BEBDEBA0161';
end;//TK211878862.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK211878862.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
