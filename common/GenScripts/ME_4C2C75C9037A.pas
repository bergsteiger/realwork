unit K221250480;
 {* [$221250480] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K221250480.pas"
// Стереотип: "TestCase"
// Элемент модели: "K221250480" MUID: (4C2C75C9037A)
// Имя типа: "TK221250480"

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
 TK221250480 = class(TScrollTest)
  {* [$221250480] }
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
 end;//TK221250480
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
function TK221250480.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4C2C75C9037A_var*
//#UC END# *4C07AC6F036D_4C2C75C9037A_var*
begin
//#UC START# *4C07AC6F036D_4C2C75C9037A_impl*
 Result := 14;
//#UC END# *4C07AC6F036D_4C2C75C9037A_impl*
end;//TK221250480.GetNormalFontSize

function TK221250480.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4C2C75C9037A_var*
//#UC END# *4C08CF700318_4C2C75C9037A_var*
begin
//#UC START# *4C08CF700318_4C2C75C9037A_impl*
 Result.X := 798;
 Result.Y := 453;
//#UC END# *4C08CF700318_4C2C75C9037A_impl*
end;//TK221250480.FormExtent

function TK221250480.SendKey: Boolean;
 {* Управлять ли окном реактора посредсвом посылки клавиш, а не вызова методов редактора }
//#UC START# *4C091B9A0305_4C2C75C9037A_var*
//#UC END# *4C091B9A0305_4C2C75C9037A_var*
begin
//#UC START# *4C091B9A0305_4C2C75C9037A_impl*
 Result := True;
//#UC END# *4C091B9A0305_4C2C75C9037A_impl*
end;//TK221250480.SendKey

function TK221250480.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK221250480.GetFolder

function TK221250480.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C2C75C9037A';
end;//TK221250480.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK221250480.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
