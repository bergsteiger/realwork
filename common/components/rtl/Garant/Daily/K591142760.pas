unit K591142760;
 {* [Requestlink:591142760] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K591142760.pas"
// Стереотип: "TestCase"
// Элемент модели: "K591142760" MUID: (550C03B600B4)
// Имя типа: "TK591142760"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK591142760 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:591142760] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK591142760
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK591142760.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK591142760.GetFolder

function TK591142760.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '550C03B600B4';
end;//TK591142760.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK591142760.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
