unit K217683893;
 {* [RequestLink:217683893]. }

// Модуль: "w:\common\components\rtl\Garant\Daily\K217683893.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollBackTest
 {$IfEnd} // NOT Defined(NoVCM)
 , Types
;

type
 TK217683893 = class(TScrollBackTest)
  {* [RequestLink:217683893]. }
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
 end;//TK217683893
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
function TK217683893.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4C0E207401DD_var*
//#UC END# *4C07AC6F036D_4C0E207401DD_var*
begin
//#UC START# *4C07AC6F036D_4C0E207401DD_impl*
 Result := 14;
//#UC END# *4C07AC6F036D_4C0E207401DD_impl*
end;//TK217683893.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK217683893.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4C0E207401DD_var*
//#UC END# *4C08CF700318_4C0E207401DD_var*
begin
//#UC START# *4C08CF700318_4C0E207401DD_impl*
 Result.X := 798;
 Result.Y := 465;
//#UC END# *4C08CF700318_4C0E207401DD_impl*
end;//TK217683893.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK217683893.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK217683893.GetFolder

function TK217683893.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C0E207401DD';
end;//TK217683893.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217683893.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
