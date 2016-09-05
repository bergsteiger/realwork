unit K596386207;
 {* [Requestlink:596386207] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K596386207.pas"
// Стереотип: "TestCase"
// Элемент модели: "K596386207" MUID: (55277CB702C8)
// Имя типа: "TK596386207"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK596386207 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:596386207] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK596386207
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *55277CB702C8impl_uses*
 //#UC END# *55277CB702C8impl_uses*
;

function TK596386207.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK596386207.GetFolder

function TK596386207.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55277CB702C8';
end;//TK596386207.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK596386207.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
