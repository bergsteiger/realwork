unit K462555879;
 {* [Requestlink:462555879] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K462555879.pas"
// Стереотип: "TestCase"
// Элемент модели: "K462555879" MUID: (51D52BC501F9)
// Имя типа: "TK462555879"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AppConfigBaseTest
;

type
 TK462555879 = class(TAppConfigBaseTest)
  {* [Requestlink:462555879] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK462555879
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
 //#UC START# *51D52BC501F9impl_uses*
 //#UC END# *51D52BC501F9impl_uses*
;

function TK462555879.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.9';
end;//TK462555879.GetFolder

function TK462555879.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51D52BC501F9';
end;//TK462555879.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK462555879.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
