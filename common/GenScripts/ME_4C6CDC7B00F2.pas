unit K233014754;
 {* [$233014754] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K233014754.pas"
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
 TK233014754 = class(TScrollTest)
  {* [$233014754] }
  protected
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* Размеры формы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK233014754
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
function TK233014754.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4C6CDC7B00F2_var*
//#UC END# *4C07AC6F036D_4C6CDC7B00F2_var*
begin
//#UC START# *4C07AC6F036D_4C6CDC7B00F2_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C6CDC7B00F2_impl*
end;//TK233014754.GetNormalFontSize

function TK233014754.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4C6CDC7B00F2_var*
//#UC END# *4C08CF700318_4C6CDC7B00F2_var*
begin
//#UC START# *4C08CF700318_4C6CDC7B00F2_impl*
 Result.X := 768;
 Result.Y := 400;
//#UC END# *4C08CF700318_4C6CDC7B00F2_impl*
end;//TK233014754.FormExtent

function TK233014754.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK233014754.GetFolder

function TK233014754.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C6CDC7B00F2';
end;//TK233014754.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK233014754.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
