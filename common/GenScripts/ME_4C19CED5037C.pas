unit K217693956;
 {* [$217693956] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K217693956.pas"
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
 TK217693956 = class(TScrollTest)
  {* [$217693956] }
  protected
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* Размеры формы }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function SendKey: Boolean; override;
    {* Управлять ли окном реактора посредсвом посылки клавиш, а не вызова методов редактора }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK217693956
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
function TK217693956.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4C19CED5037C_var*
//#UC END# *4C07AC6F036D_4C19CED5037C_var*
begin
//#UC START# *4C07AC6F036D_4C19CED5037C_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C19CED5037C_impl*
end;//TK217693956.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK217693956.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4C19CED5037C_var*
//#UC END# *4C08CF700318_4C19CED5037C_var*
begin
//#UC START# *4C08CF700318_4C19CED5037C_impl*
 Result.X := 1024;
 Result.Y := 400;
//#UC END# *4C08CF700318_4C19CED5037C_impl*
end;//TK217693956.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK217693956.SendKey: Boolean;
 {* Управлять ли окном реактора посредсвом посылки клавиш, а не вызова методов редактора }
//#UC START# *4C091B9A0305_4C19CED5037C_var*
//#UC END# *4C091B9A0305_4C19CED5037C_var*
begin
//#UC START# *4C091B9A0305_4C19CED5037C_impl*
 Result := True;
//#UC END# *4C091B9A0305_4C19CED5037C_impl*
end;//TK217693956.SendKey
{$IfEnd} // NOT Defined(NoVCM)

function TK217693956.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK217693956.GetFolder

function TK217693956.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C19CED5037C';
end;//TK217693956.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217693956.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
