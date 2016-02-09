unit K217681540;
 {* [RequestLink:217681540] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K217681540.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

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
 TK217681540 = class(TScrollTest)
  {* [RequestLink:217681540] }
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
 end;//TK217681540
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
function TK217681540.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4C09139A00FE_var*
//#UC END# *4C07AC6F036D_4C09139A00FE_var*
begin
//#UC START# *4C07AC6F036D_4C09139A00FE_impl*
 Result := 14;
//#UC END# *4C07AC6F036D_4C09139A00FE_impl*
end;//TK217681540.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK217681540.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4C09139A00FE_var*
//#UC END# *4C08CF700318_4C09139A00FE_var*
begin
//#UC START# *4C08CF700318_4C09139A00FE_impl*
 Result.X := 798;
 Result.Y := 465;
//#UC END# *4C08CF700318_4C09139A00FE_impl*
end;//TK217681540.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK217681540.SendKey: Boolean;
 {* Управлять ли окном реактора посредсвом посылки клавиш, а не вызова методов редактора }
//#UC START# *4C091B9A0305_4C09139A00FE_var*
//#UC END# *4C091B9A0305_4C09139A00FE_var*
begin
//#UC START# *4C091B9A0305_4C09139A00FE_impl*
 Result := true;
//#UC END# *4C091B9A0305_4C09139A00FE_impl*
end;//TK217681540.SendKey
{$IfEnd} // NOT Defined(NoVCM)

function TK217681540.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK217681540.GetFolder

function TK217681540.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C09139A00FE';
end;//TK217681540.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217681540.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
