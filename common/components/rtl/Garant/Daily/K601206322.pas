unit K601206322;
 {* [Requestlnk:601206322] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K601206322.pas"
// Стереотип: "TestCase"
// Элемент модели: "K601206322" MUID: (557ECAB103A9)
// Имя типа: "TK601206322"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK601206322 = class(TRTFtoEVDWriterTest)
  {* [Requestlnk:601206322] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK601206322
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *557ECAB103A9impl_uses*
 //#UC END# *557ECAB103A9impl_uses*
;

function TK601206322.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK601206322.GetFolder

function TK601206322.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '557ECAB103A9';
end;//TK601206322.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK601206322.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
