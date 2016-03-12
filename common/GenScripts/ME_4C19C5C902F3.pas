unit K217691845;
 {* [$217691845] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K217691845.pas"
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
 TK217691845 = class(TScrollTest)
  {* [$217691845] }
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
 end;//TK217691845
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
function TK217691845.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4C19C5C902F3_var*
//#UC END# *4C07AC6F036D_4C19C5C902F3_var*
begin
//#UC START# *4C07AC6F036D_4C19C5C902F3_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C19C5C902F3_impl*
end;//TK217691845.GetNormalFontSize

function TK217691845.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4C19C5C902F3_var*
//#UC END# *4C08CF700318_4C19C5C902F3_var*
begin
//#UC START# *4C08CF700318_4C19C5C902F3_impl*
 Result.X := 1024;
 Result.Y := 603;
//#UC END# *4C08CF700318_4C19C5C902F3_impl*
end;//TK217691845.FormExtent

function TK217691845.SendKey: Boolean;
 {* Управлять ли окном реактора посредсвом посылки клавиш, а не вызова методов редактора }
//#UC START# *4C091B9A0305_4C19C5C902F3_var*
//#UC END# *4C091B9A0305_4C19C5C902F3_var*
begin
//#UC START# *4C091B9A0305_4C19C5C902F3_impl*
 Result := True;
//#UC END# *4C091B9A0305_4C19C5C902F3_impl*
end;//TK217691845.SendKey

function TK217691845.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK217691845.GetFolder

function TK217691845.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C19C5C902F3';
end;//TK217691845.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217691845.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
