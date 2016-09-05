unit K274825304;
 {* [RequestLink:274825304] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K274825304.pas"
// Стереотип: "TestCase"
// Элемент модели: "K274825304" MUID: (4E84927503A3)
// Имя типа: "TK274825304"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFWriterTest
;

type
 TK274825304 = class(TEVDtoRTFWriterTest)
  {* [RequestLink:274825304] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK274825304
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4E84927503A3impl_uses*
 //#UC END# *4E84927503A3impl_uses*
;

function TK274825304.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7 Lulin';
end;//TK274825304.GetFolder

function TK274825304.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E84927503A3';
end;//TK274825304.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK274825304.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
