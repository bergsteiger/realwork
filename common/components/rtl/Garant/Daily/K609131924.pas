unit K609131924;
 {* [Requestlink:609131924] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K609131924.pas"
// Стереотип: "TestCase"
// Элемент модели: "K609131924" MUID: (561F3A590343)
// Имя типа: "TK609131924"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK609131924 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:609131924] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK609131924
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *561F3A590343impl_uses*
 //#UC END# *561F3A590343impl_uses*
;

function TK609131924.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK609131924.GetFolder

function TK609131924.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '561F3A590343';
end;//TK609131924.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK609131924.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
