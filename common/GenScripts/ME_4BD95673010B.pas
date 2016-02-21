unit K207389888;
 {* [RequestLink:207389888] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K207389888.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK207389888 = class(TEVDtoNSRCOldWriterTest)
  {* [RequestLink:207389888] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK207389888
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK207389888.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK207389888.GetFolder

function TK207389888.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BD95673010B';
end;//TK207389888.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK207389888.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
