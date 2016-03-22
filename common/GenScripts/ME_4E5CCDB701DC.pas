unit K280859294;
 {* [$280859294] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K280859294.pas"
// Стереотип: "TestCase"
// Элемент модели: "K280859294" MUID: (4E5CCDB701DC)
// Имя типа: "TK280859294"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK280859294 = class(TEVDtoNSRCPlusWriterTest)
  {* [$280859294] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK280859294
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK280859294.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRC 7.7';
end;//TK280859294.GetFolder

function TK280859294.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E5CCDB701DC';
end;//TK280859294.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK280859294.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
