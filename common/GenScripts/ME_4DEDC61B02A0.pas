unit K265409725;
 {* [$265409725] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K265409725.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , DrawTest
 , Types
;

type
 TK265409725 = class(TDrawTest)
  {* [$265409725] }
  protected
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* Размеры формы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK265409725
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
function TK265409725.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4DEDC61B02A0_var*
//#UC END# *4C08CF700318_4DEDC61B02A0_var*
begin
//#UC START# *4C08CF700318_4DEDC61B02A0_impl*
 Result.X := 1024;
 Result.Y := 710; 
//#UC END# *4C08CF700318_4DEDC61B02A0_impl*
end;//TK265409725.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK265409725.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK265409725.GetFolder

function TK265409725.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4DEDC61B02A0';
end;//TK265409725.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK265409725.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
