unit K610745715;
 {* [Requestlink:610745715] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K610745715.pas"
// Стереотип: "TestCase"
// Элемент модели: "K610745715" MUID: (563B44190171)
// Имя типа: "TK610745715"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK610745715 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:610745715] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK610745715
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *563B44190171impl_uses*
 //#UC END# *563B44190171impl_uses*
;

function TK610745715.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK610745715.GetFolder

function TK610745715.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '563B44190171';
end;//TK610745715.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK610745715.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
