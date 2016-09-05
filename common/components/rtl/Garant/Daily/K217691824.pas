unit K217691824;
 {* [$217691824] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K217691824.pas"
// Стереотип: "TestCase"
// Элемент модели: "K217691824" MUID: (4C19B3FC026E)
// Имя типа: "TK217691824"

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
 TK217691824 = class({$If NOT Defined(NoVCM)}
 TScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [$217691824] }
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
   {$If NOT Defined(NoVCM)}
   function MaxHeight: Integer; override;
    {* Если возвращается не 0, то будет организован цикл подбора высоты от FormExtent.Y до MaxHeight }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK217691824
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
 //#UC START# *4C19B3FC026Eimpl_uses*
 //#UC END# *4C19B3FC026Eimpl_uses*
;

{$If NOT Defined(NoVCM)}
function TK217691824.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4C19B3FC026E_var*
//#UC END# *4C07AC6F036D_4C19B3FC026E_var*
begin
//#UC START# *4C07AC6F036D_4C19B3FC026E_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C19B3FC026E_impl*
end;//TK217691824.GetNormalFontSize

function TK217691824.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4C19B3FC026E_var*
//#UC END# *4C08CF700318_4C19B3FC026E_var*
begin
//#UC START# *4C08CF700318_4C19B3FC026E_impl*
 Result.X := 1024;
 Result.Y := 603;
//#UC END# *4C08CF700318_4C19B3FC026E_impl*
end;//TK217691824.FormExtent

function TK217691824.SendKey: Boolean;
 {* Управлять ли окном реактора посредсвом посылки клавиш, а не вызова методов редактора }
//#UC START# *4C091B9A0305_4C19B3FC026E_var*
//#UC END# *4C091B9A0305_4C19B3FC026E_var*
begin
//#UC START# *4C091B9A0305_4C19B3FC026E_impl*
 Result := True;
//#UC END# *4C091B9A0305_4C19B3FC026E_impl*
end;//TK217691824.SendKey

function TK217691824.MaxHeight: Integer;
 {* Если возвращается не 0, то будет организован цикл подбора высоты от FormExtent.Y до MaxHeight }
//#UC START# *4C0E56F000A4_4C19B3FC026E_var*
//#UC END# *4C0E56F000A4_4C19B3FC026E_var*
begin
//#UC START# *4C0E56F000A4_4C19B3FC026E_impl*
 Result := 0{768};
//#UC END# *4C0E56F000A4_4C19B3FC026E_impl*
end;//TK217691824.MaxHeight

function TK217691824.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK217691824.GetFolder

function TK217691824.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C19B3FC026E';
end;//TK217691824.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217691824.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
