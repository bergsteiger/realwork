unit K332563400;
 {* [RequestLink:332563400] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K332563400.pas"
// Стереотип: "TestCase"
// Элемент модели: "K332563400" MUID: (4F2694F901CD)
// Имя типа: "TK332563400"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDWriterTest
;

type
 TK332563400 = class(TEVDtoEVDWriterTest)
  {* [RequestLink:332563400] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK332563400
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK332563400.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRC 7.7';
end;//TK332563400.GetFolder

function TK332563400.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F2694F901CD';
end;//TK332563400.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK332563400.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
