unit K619938529;
 {* [Requestlink:619938529] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K619938529.pas"
// Стереотип: "TestCase"
// Элемент модели: "K619938529" MUID: (56E90B390171)
// Имя типа: "TK619938529"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK619938529 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:619938529] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK619938529
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56E90B390171impl_uses*
 //#UC END# *56E90B390171impl_uses*
;

function TK619938529.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK619938529.GetFolder

function TK619938529.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56E90B390171';
end;//TK619938529.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619938529.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
