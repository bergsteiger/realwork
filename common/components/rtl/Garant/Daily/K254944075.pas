unit K254944075;
 {* [RequestLink:254944075] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K254944075.pas"
// Стереотип: "TestCase"
// Элемент модели: "K254944075" MUID: (4D6BE7A702E7)
// Имя типа: "TK254944075"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , WikiToEVDWriterTest
;

type
 TK254944075 = class(TWikiToEVDWriterTest)
  {* [RequestLink:254944075] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK254944075
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK254944075.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7 Lulin';
end;//TK254944075.GetFolder

function TK254944075.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D6BE7A702E7';
end;//TK254944075.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK254944075.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
