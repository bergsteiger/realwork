unit K213713120;
 {* [RequestLink:213713120] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K213713120.pas"
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
 TK213713120 = class(TScrollTest)
  {* [RequestLink:213713120] }
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
 end;//TK213713120
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
function TK213713120.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4C08A9F20321_var*
//#UC END# *4C07AC6F036D_4C08A9F20321_var*
begin
//#UC START# *4C07AC6F036D_4C08A9F20321_impl*
 Result := 14;
//#UC END# *4C07AC6F036D_4C08A9F20321_impl*
end;//TK213713120.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK213713120.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4C08A9F20321_var*
//#UC END# *4C08CF700318_4C08A9F20321_var*
begin
//#UC START# *4C08CF700318_4C08A9F20321_impl*
 Result.X := 798;
 Result.Y := 440;
//#UC END# *4C08CF700318_4C08A9F20321_impl*
end;//TK213713120.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK213713120.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK213713120.GetFolder

function TK213713120.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C08A9F20321';
end;//TK213713120.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK213713120.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
