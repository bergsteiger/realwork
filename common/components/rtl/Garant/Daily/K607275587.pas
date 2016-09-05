unit K607275587;
 {* [Requestlink:607275587] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K607275587.pas"
// Стереотип: "TestCase"
// Элемент модели: "K607275587" MUID: (5625E4B7020D)
// Имя типа: "TK607275587"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK607275587 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:607275587] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK607275587
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5625E4B7020Dimpl_uses*
 //#UC END# *5625E4B7020Dimpl_uses*
;

function TK607275587.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK607275587.GetFolder

function TK607275587.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5625E4B7020D';
end;//TK607275587.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK607275587.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
