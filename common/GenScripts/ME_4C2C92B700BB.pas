unit K221251978;
 {* [RequestLink:221251978] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K221251978.pas"
// Стереотип: "TestCase"
// Элемент модели: "K221251978" MUID: (4C2C92B700BB)
// Имя типа: "TK221251978"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDSectionRepairTest
;

type
 TK221251978 = class(TEVDtoEVDSectionRepairTest)
  {* [RequestLink:221251978] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK221251978
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK221251978.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK221251978.GetFolder

function TK221251978.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C2C92B700BB';
end;//TK221251978.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK221251978.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
