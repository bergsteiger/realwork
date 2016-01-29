unit K266405030;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K266405030.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K266405030
//
// [$266405030]
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
  ScrollAndSelectPtTest
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  ,
  nevTools,
  Types,
  l3Units
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK266405030 = class(TScrollAndSelectPtTest)
  {* [$266405030] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
   {$IfEnd} //nsTest AND not NoVCM
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
     {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
   function GetScrollCount: Integer; override;
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
     {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function FormExtent: TPoint; override;
     {* Размеры формы }
   {$IfEnd} //nsTest AND not NoVCM
   function GetPoint(const aMap: InevMap): Tl3Point; override;
     {* Возвращает точку, на которую нужно спозиционироваться. }
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
   function NeedScrollByLine: Boolean; override;
 end;//TK266405030
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TextPara_Const,
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

// start class TK266405030

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TK266405030.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4DD2A5C40137_var*
//#UC END# *4BE419AF0217_4DD2A5C40137_var*
begin
//#UC START# *4BE419AF0217_4DD2A5C40137_impl*
 inherited DoVisit(aForm);
 Check(aForm.Text.Selection.Cursor.MostInner.AsObject.IsKindOf(k2_typTextPara));
//#UC END# *4BE419AF0217_4DD2A5C40137_impl*
end;//TK266405030.DoVisit
{$IfEnd} //nsTest AND not NoVCM

function TK266405030.GetInnerPara(const aView: InevInputView;
  const aDocument: InevPara): InevPara;
//#UC START# *4BF4E6A00093_4DD2A5C40137_var*
//#UC END# *4BF4E6A00093_4DD2A5C40137_var*
begin
//#UC START# *4BF4E6A00093_4DD2A5C40137_impl*
 Result := aDocument.AsList.Para[1].AsList.Para[1].AsList.Para[1];
//#UC END# *4BF4E6A00093_4DD2A5C40137_impl*
end;//TK266405030.GetInnerPara

function TK266405030.GetScrollCount: Integer;
//#UC START# *4BFE40CD0337_4DD2A5C40137_var*
//#UC END# *4BFE40CD0337_4DD2A5C40137_var*
begin
//#UC START# *4BFE40CD0337_4DD2A5C40137_impl*
 Result := 6;
//#UC END# *4BFE40CD0337_4DD2A5C40137_impl*
end;//TK266405030.GetScrollCount

{$If defined(nsTest) AND not defined(NoVCM)}
function TK266405030.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4DD2A5C40137_var*
//#UC END# *4C07AC6F036D_4DD2A5C40137_var*
begin
//#UC START# *4C07AC6F036D_4DD2A5C40137_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4DD2A5C40137_impl*
end;//TK266405030.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK266405030.FormExtent: TPoint;
//#UC START# *4C08CF700318_4DD2A5C40137_var*
//#UC END# *4C08CF700318_4DD2A5C40137_var*
begin
//#UC START# *4C08CF700318_4DD2A5C40137_impl*
 Result.X := 1000;
 Result.Y := 700;
//#UC END# *4C08CF700318_4DD2A5C40137_impl*
end;//TK266405030.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK266405030.GetPoint(const aMap: InevMap): Tl3Point;
//#UC START# *4C3C927B027E_4DD2A5C40137_var*
//#UC END# *4C3C927B027E_4DD2A5C40137_var*
begin
//#UC START# *4C3C927B027E_4DD2A5C40137_impl*
 Result.X := aMap.Bounds.Right + 150;
 Result.Y := aMap.Bounds.Top + 100;
//#UC END# *4C3C927B027E_4DD2A5C40137_impl*
end;//TK266405030.GetPoint

function TK266405030.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK266405030.GetFolder

function TK266405030.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DD2A5C40137';
end;//TK266405030.GetModelElementGUID

function TK266405030.NeedScrollByLine: Boolean;
//#UC START# *4E44C9B00324_4DD2A5C40137_var*
//#UC END# *4E44C9B00324_4DD2A5C40137_var*
begin
//#UC START# *4E44C9B00324_4DD2A5C40137_impl*
 Result := True;
//#UC END# *4E44C9B00324_4DD2A5C40137_impl*
end;//TK266405030.NeedScrollByLine

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK266405030.Suite);

end.