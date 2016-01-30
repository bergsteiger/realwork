unit K590774242;
 {* [Requestlink:590774242] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K590774242.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK590774242 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:590774242] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK590774242
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK590774242.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK590774242.GetFolder

function TK590774242.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5509207E0200';
end;//TK590774242.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK590774242.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
