unit K207006496;
 {* [RequestLink:207006496] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K207006496.pas"
// Стереотип: "TestCase"
// Элемент модели: "K207006496" MUID: (4C1A5CE401A0)
// Имя типа: "TK207006496"

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
 TK207006496 = class({$If NOT Defined(NoVCM)}
 TScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [RequestLink:207006496] }
  protected
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* Размеры формы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK207006496
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
 //#UC START# *4C1A5CE401A0impl_uses*
 //#UC END# *4C1A5CE401A0impl_uses*
;

{$If NOT Defined(NoVCM)}
function TK207006496.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4C1A5CE401A0_var*
//#UC END# *4C08CF700318_4C1A5CE401A0_var*
begin
//#UC START# *4C08CF700318_4C1A5CE401A0_impl*
 Result.X := 800;
 Result.Y := 400;
//#UC END# *4C08CF700318_4C1A5CE401A0_impl*
end;//TK207006496.FormExtent

function TK207006496.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK207006496.GetFolder

function TK207006496.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C1A5CE401A0';
end;//TK207006496.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK207006496.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
