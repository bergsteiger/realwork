unit K590758825;
 {* [Requestlink:590758825] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K590758825.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK590758825 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:590758825] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK590758825
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK590758825.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK590758825.GetFolder

function TK590758825.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55100F3F014E';
end;//TK590758825.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK590758825.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
