unit K234363136;
 {* [RequestLink:234363136] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K234363136.pas"
// Стереотип: "TestCase"
// Элемент модели: "K234363136" MUID: (4C8E19CE01C2)
// Имя типа: "TK234363136"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDSectionRepairTest
;

type
 TK234363136 = class(TEVDtoEVDSectionRepairTest)
  {* [RequestLink:234363136] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK234363136
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK234363136.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK234363136.GetFolder

function TK234363136.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C8E19CE01C2';
end;//TK234363136.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK234363136.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
