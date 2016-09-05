unit K537973036;
 {* [Requestlink:537973036] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K537973036.pas"
// Стереотип: "TestCase"
// Элемент модели: "K537973036" MUID: (53859C42020E)
// Имя типа: "TK537973036"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK537973036 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:537973036] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK537973036
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *53859C42020Eimpl_uses*
 //#UC END# *53859C42020Eimpl_uses*
;

function TK537973036.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK537973036.GetFolder

function TK537973036.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53859C42020E';
end;//TK537973036.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK537973036.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
