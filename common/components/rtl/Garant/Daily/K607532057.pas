unit K607532057;
 {* [RequestLink:607532057] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K607532057.pas"
// Стереотип: "TestCase"
// Элемент модели: "K607532057" MUID: (55FFDDFD0132)
// Имя типа: "TK607532057"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK607532057 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:607532057] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK607532057
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK607532057.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK607532057.GetFolder

function TK607532057.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55FFDDFD0132';
end;//TK607532057.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK607532057.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
