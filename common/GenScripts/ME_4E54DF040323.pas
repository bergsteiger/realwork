unit K267328230;
 {* [$267328230] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K267328230.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ScrollAndLinesTest
 , Types
;

type
 TK267328230 = class(TScrollAndLinesTest)
  {* [$267328230] }
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
 end;//TK267328230
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK267328230.GetScrollCount: Integer;
//#UC START# *4E54E5E2009E_4E54DF040323_var*
//#UC END# *4E54E5E2009E_4E54DF040323_var*
begin
//#UC START# *4E54E5E2009E_4E54DF040323_impl*
 Result := 30;
//#UC END# *4E54E5E2009E_4E54DF040323_impl*
end;//TK267328230.GetScrollCount

{$If NOT Defined(NoVCM)}
function TK267328230.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4E54DF040323_var*
//#UC END# *4C07AC6F036D_4E54DF040323_var*
begin
//#UC START# *4C07AC6F036D_4E54DF040323_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4E54DF040323_impl*
end;//TK267328230.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK267328230.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4E54DF040323_var*
//#UC END# *4C08CF700318_4E54DF040323_var*
begin
//#UC START# *4C08CF700318_4E54DF040323_impl*
 Result.X := 950;
 Result.Y := 650;
//#UC END# *4C08CF700318_4E54DF040323_impl*
end;//TK267328230.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK267328230.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK267328230.GetFolder

function TK267328230.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E54DF040323';
end;//TK267328230.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK267328230.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
