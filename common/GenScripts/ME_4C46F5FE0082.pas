unit K227478018;
 {* [$227478018] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K227478018.pas"
// Стереотип: "TestCase"
// Элемент модели: "K227478018" MUID: (4C46F5FE0082)
// Имя типа: "TK227478018"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , DrawLineTest
 {$IfEnd} // NOT Defined(NoVCM)
 , Types
;

type
 TK227478018 = class(TDrawLineTest)
  {* [$227478018] }
  protected
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* Размеры формы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK227478018
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
;

{$If NOT Defined(NoVCM)}
function TK227478018.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4C46F5FE0082_var*
//#UC END# *4C08CF700318_4C46F5FE0082_var*
begin
//#UC START# *4C08CF700318_4C46F5FE0082_impl*
 Result.X := 1000;
 Result.Y := 600;
//#UC END# *4C08CF700318_4C46F5FE0082_impl*
end;//TK227478018.FormExtent

function TK227478018.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK227478018.GetFolder

function TK227478018.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C46F5FE0082';
end;//TK227478018.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK227478018.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
