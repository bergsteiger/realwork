unit K251334429;
 {* [$251334429] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K251334429.pas"
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
 TK251334429 = class(TDrawTest)
  {* [$251334429] }
  protected
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* Размеры формы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK251334429
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
function TK251334429.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4D42A997020E_var*
//#UC END# *4C08CF700318_4D42A997020E_var*
begin
//#UC START# *4C08CF700318_4D42A997020E_impl*
 Result.X := 1024;
 Result.Y := 710; 
//#UC END# *4C08CF700318_4D42A997020E_impl*
end;//TK251334429.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK251334429.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK251334429.GetFolder

function TK251334429.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D42A997020E';
end;//TK251334429.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK251334429.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
