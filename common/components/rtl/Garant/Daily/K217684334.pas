unit K217684334;
 {* [RequestLink:217684334] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K217684334.pas"
// Стереотип: "TestCase"
// Элемент модели: "K217684334" MUID: (4C0E4A360101)
// Имя типа: "TK217684334"

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
 TK217684334 = class({$If NOT Defined(NoVCM)}
 TScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [RequestLink:217684334] }
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
 end;//TK217684334
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
 //#UC START# *4C0E4A360101impl_uses*
 //#UC END# *4C0E4A360101impl_uses*
;

{$If NOT Defined(NoVCM)}
function TK217684334.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4C0E4A360101_var*
//#UC END# *4C07AC6F036D_4C0E4A360101_var*
begin
//#UC START# *4C07AC6F036D_4C0E4A360101_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C0E4A360101_impl*
end;//TK217684334.GetNormalFontSize

function TK217684334.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4C0E4A360101_var*
//#UC END# *4C08CF700318_4C0E4A360101_var*
begin
//#UC START# *4C08CF700318_4C0E4A360101_impl*
 Result.X := 798;
 Result.Y := 296{200};
//#UC END# *4C08CF700318_4C0E4A360101_impl*
end;//TK217684334.FormExtent

function TK217684334.SendKey: Boolean;
 {* Управлять ли окном реактора посредсвом посылки клавиш, а не вызова методов редактора }
//#UC START# *4C091B9A0305_4C0E4A360101_var*
//#UC END# *4C091B9A0305_4C0E4A360101_var*
begin
//#UC START# *4C091B9A0305_4C0E4A360101_impl*
 Result := true;
//#UC END# *4C091B9A0305_4C0E4A360101_impl*
end;//TK217684334.SendKey

function TK217684334.MaxHeight: Integer;
 {* Если возвращается не 0, то будет организован цикл подбора высоты от FormExtent.Y до MaxHeight }
//#UC START# *4C0E56F000A4_4C0E4A360101_var*
//#UC END# *4C0E56F000A4_4C0E4A360101_var*
begin
//#UC START# *4C0E56F000A4_4C0E4A360101_impl*
 Result := 0{600}; 
//#UC END# *4C0E56F000A4_4C0E4A360101_impl*
end;//TK217684334.MaxHeight

function TK217684334.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK217684334.GetFolder

function TK217684334.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C0E4A360101';
end;//TK217684334.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217684334.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
