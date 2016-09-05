unit K602703982;
 {* [Requestlink:602703982] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K602703982.pas"
// Стереотип: "TestCase"
// Элемент модели: "K602703982" MUID: (5593B9130064)
// Имя типа: "TK602703982"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK602703982 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:602703982] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK602703982
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5593B9130064impl_uses*
 //#UC END# *5593B9130064impl_uses*
;

function TK602703982.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK602703982.GetFolder

function TK602703982.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5593B9130064';
end;//TK602703982.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK602703982.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
