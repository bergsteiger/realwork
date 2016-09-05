unit K590757091;
 {* [Requestlink:590757091] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K590757091.pas"
// Стереотип: "TestCase"
// Элемент модели: "K590757091" MUID: (5510067D003A)
// Имя типа: "TK590757091"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK590757091 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:590757091] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK590757091
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5510067D003Aimpl_uses*
 //#UC END# *5510067D003Aimpl_uses*
;

function TK590757091.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK590757091.GetFolder

function TK590757091.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5510067D003A';
end;//TK590757091.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK590757091.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
