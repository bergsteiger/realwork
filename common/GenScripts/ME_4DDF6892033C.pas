unit K265409480;
 {* [$265409480]. Тест обычного поведения в редакторе. }

// Модуль: "w:\common\components\rtl\Garant\Daily\K265409480.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ClickOnCommentTest
 , nevTools
;

type
 TK265409480 = class(TClickOnCommentTest)
  {* [$265409480]. Тест обычного поведения в редакторе. }
  protected
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
    {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK265409480
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

function TK265409480.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
//#UC START# *4BF4E6A00093_4DDF6892033C_var*
//#UC END# *4BF4E6A00093_4DDF6892033C_var*
begin
//#UC START# *4BF4E6A00093_4DDF6892033C_impl*
 Result := aDocument.AsList.Para[0];
//#UC END# *4BF4E6A00093_4DDF6892033C_impl*
end;//TK265409480.GetInnerPara

{$If NOT Defined(NoVCM)}
function TK265409480.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4DDF6892033C_var*
//#UC END# *4C07AC6F036D_4DDF6892033C_var*
begin
//#UC START# *4C07AC6F036D_4DDF6892033C_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4DDF6892033C_impl*
end;//TK265409480.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

function TK265409480.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK265409480.GetFolder

function TK265409480.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4DDF6892033C';
end;//TK265409480.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK265409480.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
