unit K610084627;
 {* [Requestlink:610084627] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K610084627.pas"
// Стереотип: "TestCase"
// Элемент модели: "K610084627" MUID: (5629C5B002A0)
// Имя типа: "TK610084627"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK610084627 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:610084627] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK610084627
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5629C5B002A0impl_uses*
 //#UC END# *5629C5B002A0impl_uses*
;

function TK610084627.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK610084627.GetFolder

function TK610084627.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5629C5B002A0';
end;//TK610084627.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK610084627.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
