unit K608627112;
 {* [Requestlink:608627112] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K608627112.pas"
// Стереотип: "TestCase"
// Элемент модели: "K608627112" MUID: (561CC1270105)
// Имя типа: "TK608627112"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK608627112 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:608627112] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK608627112
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK608627112.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK608627112.GetFolder

function TK608627112.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '561CC1270105';
end;//TK608627112.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK608627112.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
