unit K220594340;
 {* [$220594340] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K220594340.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
 , Types
;

type
 TK220594340 = class(TScrollTest)
  {* [$220594340] }
  protected
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* Размеры формы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK220594340
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
function TK220594340.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4C29A17903A9_var*
//#UC END# *4C08CF700318_4C29A17903A9_var*
begin
//#UC START# *4C08CF700318_4C29A17903A9_impl*
 Result.X := 1024;
 Result.Y := 600;
//#UC END# *4C08CF700318_4C29A17903A9_impl*
end;//TK220594340.FormExtent

function TK220594340.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK220594340.GetFolder

function TK220594340.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C29A17903A9';
end;//TK220594340.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK220594340.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
