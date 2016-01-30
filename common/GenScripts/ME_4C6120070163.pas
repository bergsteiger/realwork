unit K232097143;
 {* [$232097143] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K232097143.pas"
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
 TK232097143 = class(TScrollTest)
  {* [$232097143] }
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
 end;//TK232097143
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
function TK232097143.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4C6120070163_var*
//#UC END# *4C07AC6F036D_4C6120070163_var*
begin
//#UC START# *4C07AC6F036D_4C6120070163_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C6120070163_impl*
end;//TK232097143.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK232097143.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4C6120070163_var*
//#UC END# *4C08CF700318_4C6120070163_var*
begin
//#UC START# *4C08CF700318_4C6120070163_impl*
 Result.X := 1280;
 Result.Y := 400;
//#UC END# *4C08CF700318_4C6120070163_impl*
end;//TK232097143.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK232097143.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK232097143.GetFolder

function TK232097143.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C6120070163';
end;//TK232097143.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK232097143.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
