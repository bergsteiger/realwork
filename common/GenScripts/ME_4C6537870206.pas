unit K224133855;
 {* [$224133855] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K224133855.pas"
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
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK224133855 = class(TScrollTest)
  {* [$224133855] }
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* Размеры формы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK224133855
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
procedure TK224133855.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
//#UC START# *4BE419AF0217_4C6537870206_var*
//#UC END# *4BE419AF0217_4C6537870206_var*
begin
//#UC START# *4BE419AF0217_4C6537870206_impl*
 inherited DoVisit(aForm);
 Check(Self.ScrollCount > 2);
//#UC END# *4BE419AF0217_4C6537870206_impl*
end;//TK224133855.DoVisit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK224133855.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4C6537870206_var*
//#UC END# *4C08CF700318_4C6537870206_var*
begin
//#UC START# *4C08CF700318_4C6537870206_impl*
 Result.X := 1024;
 Result.Y := 768;
//#UC END# *4C08CF700318_4C6537870206_impl*
end;//TK224133855.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK224133855.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK224133855.GetFolder

function TK224133855.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C6537870206';
end;//TK224133855.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK224133855.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
