unit K278135327;
 {* [$278135327] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K278135327.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , DrawTest
 , Types
;

type
 TK278135327 = class(TDrawTest)
  {* [$278135327] }
  protected
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function WebStyle: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* Размеры формы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK278135327
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
function TK278135327.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4E3BD18A01A3_var*
//#UC END# *4C07AC6F036D_4E3BD18A01A3_var*
begin
//#UC START# *4C07AC6F036D_4E3BD18A01A3_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4E3BD18A01A3_impl*
end;//TK278135327.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK278135327.WebStyle: Boolean;
//#UC START# *4C08CF4300BE_4E3BD18A01A3_var*
//#UC END# *4C08CF4300BE_4E3BD18A01A3_var*
begin
//#UC START# *4C08CF4300BE_4E3BD18A01A3_impl*
 Result := True;
//#UC END# *4C08CF4300BE_4E3BD18A01A3_impl*
end;//TK278135327.WebStyle
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK278135327.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4E3BD18A01A3_var*
//#UC END# *4C08CF700318_4E3BD18A01A3_var*
begin
//#UC START# *4C08CF700318_4E3BD18A01A3_impl*
 Result.X := 1000;
 Result.Y := 710; 
//#UC END# *4C08CF700318_4E3BD18A01A3_impl*
end;//TK278135327.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK278135327.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK278135327.GetFolder

function TK278135327.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E3BD18A01A3';
end;//TK278135327.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK278135327.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
