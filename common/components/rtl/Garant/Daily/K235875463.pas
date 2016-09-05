unit K235875463;
 {* [$235875463] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K235875463.pas"
// Стереотип: "TestCase"
// Элемент модели: "K235875463" MUID: (4CB6D8DE0165)
// Имя типа: "TK235875463"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ScrollByLineTest
;

type
 TK235875463 = class(TScrollByLineTest)
  {* [$235875463] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK235875463
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4CB6D8DE0165impl_uses*
 //#UC END# *4CB6D8DE0165impl_uses*
;

function TK235875463.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK235875463.GetFolder

function TK235875463.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CB6D8DE0165';
end;//TK235875463.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235875463.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
