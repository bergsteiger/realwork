unit K252520765;
 {* [$252520765] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K252520765.pas"
// Стереотип: "TestCase"
// Элемент модели: "K252520765" MUID: (4D80BA2F01D0)
// Имя типа: "TK252520765"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ScrollByArrowAndCheckShapesTest
 , Types
;

type
 TK252520765 = class(TScrollByArrowAndCheckShapesTest)
  {* [$252520765] }
  protected
   function GetScrollCount: Integer; override;
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
 end;//TK252520765
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 , l3InternalInterfaces
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , nevTools
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Base
;

function TK252520765.GetScrollCount: Integer;
//#UC START# *4D80BB670151_4D80BA2F01D0_var*
//#UC END# *4D80BB670151_4D80BA2F01D0_var*
begin
//#UC START# *4D80BB670151_4D80BA2F01D0_impl*
 Result := 44;
//#UC END# *4D80BB670151_4D80BA2F01D0_impl*
end;//TK252520765.GetScrollCount

{$If NOT Defined(NoVCM)}
function TK252520765.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4D80BA2F01D0_var*
//#UC END# *4C07AC6F036D_4D80BA2F01D0_var*
begin
//#UC START# *4C07AC6F036D_4D80BA2F01D0_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4D80BA2F01D0_impl*
end;//TK252520765.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK252520765.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4D80BA2F01D0_var*
//#UC END# *4C08CF700318_4D80BA2F01D0_var*
begin
//#UC START# *4C08CF700318_4D80BA2F01D0_impl*
 Result.X := 950;
 Result.Y := 670;
//#UC END# *4C08CF700318_4D80BA2F01D0_impl*
end;//TK252520765.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK252520765.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK252520765.GetFolder

function TK252520765.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D80BA2F01D0';
end;//TK252520765.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK252520765.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
