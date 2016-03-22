unit K540414443;
 {* [Requestlink:540414443] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K540414443.pas"
// Стереотип: "TestCase"
// Элемент модели: "K540414443" MUID: (53901E3D023F)
// Имя типа: "TK540414443"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK540414443 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:540414443] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK540414443
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK540414443.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK540414443.GetFolder

function TK540414443.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53901E3D023F';
end;//TK540414443.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK540414443.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
