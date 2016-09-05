unit K537974183;
 {* [RequestLink:537974183] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K537974183.pas"
// Стереотип: "TestCase"
// Элемент модели: "K537974183" MUID: (5385BF7E0260)
// Имя типа: "TK537974183"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK537974183 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:537974183] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK537974183
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5385BF7E0260impl_uses*
 //#UC END# *5385BF7E0260impl_uses*
;

function TK537974183.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK537974183.GetFolder

function TK537974183.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5385BF7E0260';
end;//TK537974183.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK537974183.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
