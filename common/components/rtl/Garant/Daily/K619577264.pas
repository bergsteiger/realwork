unit K619577264;
 {* [RequestLink:619577264] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K619577264.pas"
// Стереотип: "TestCase"
// Элемент модели: "K619577264" MUID: (56E6A57A00E2)
// Имя типа: "TK619577264"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK619577264 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:619577264] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK619577264
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619577264.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK619577264.GetFolder

function TK619577264.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56E6A57A00E2';
end;//TK619577264.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619577264.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
