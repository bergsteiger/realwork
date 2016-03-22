unit K415729926;
 {* [Requestlink:415729926] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K415729926.pas"
// Стереотип: "TestCase"
// Элемент модели: "K415729926" MUID: (50C898FC02F5)
// Имя типа: "TK415729926"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFWriterTest
;

type
 TK415729926 = class(TEVDtoRTFWriterTest)
  {* [Requestlink:415729926] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK415729926
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK415729926.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK415729926.GetFolder

function TK415729926.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50C898FC02F5';
end;//TK415729926.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK415729926.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
