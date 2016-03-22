unit K252520444;
 {* [$252520444] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K252520444.pas"
// Стереотип: "TestCase"
// Элемент модели: "K252520444" MUID: (4D676F85029E)
// Имя типа: "TK252520444"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , DrawTest
 , Types
;

type
 TK252520444 = class(TDrawTest)
  {* [$252520444] }
  protected
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* Размеры формы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK252520444
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , nevTools
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
function TK252520444.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4D676F85029E_var*
//#UC END# *4C08CF700318_4D676F85029E_var*
begin
//#UC START# *4C08CF700318_4D676F85029E_impl*
 Result.X := 850;
 Result.Y := 600;
//#UC END# *4C08CF700318_4D676F85029E_impl*
end;//TK252520444.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK252520444.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK252520444.GetFolder

function TK252520444.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D676F85029E';
end;//TK252520444.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK252520444.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
