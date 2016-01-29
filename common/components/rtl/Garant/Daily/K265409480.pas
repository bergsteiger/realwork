unit K265409480;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K265409480.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K265409480
//
// [$265409480]. Тест обычного поведения в редакторе.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  ClickOnCommentTest,
  nevTools
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK265409480 = class(TClickOnCommentTest)
  {* [$265409480]. Тест обычного поведения в редакторе. }
 protected
 // overridden protected methods
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
     {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
     {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK265409480
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK265409480

function TK265409480.GetInnerPara(const aView: InevInputView;
  const aDocument: InevPara): InevPara;
//#UC START# *4BF4E6A00093_4DDF6892033C_var*
//#UC END# *4BF4E6A00093_4DDF6892033C_var*
begin
//#UC START# *4BF4E6A00093_4DDF6892033C_impl*
 Result := aDocument.AsList.Para[0];
//#UC END# *4BF4E6A00093_4DDF6892033C_impl*
end;//TK265409480.GetInnerPara

{$If defined(nsTest) AND not defined(NoVCM)}
function TK265409480.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4DDF6892033C_var*
//#UC END# *4C07AC6F036D_4DDF6892033C_var*
begin
//#UC START# *4C07AC6F036D_4DDF6892033C_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4DDF6892033C_impl*
end;//TK265409480.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

function TK265409480.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK265409480.GetFolder

function TK265409480.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DDF6892033C';
end;//TK265409480.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK265409480.Suite);

end.