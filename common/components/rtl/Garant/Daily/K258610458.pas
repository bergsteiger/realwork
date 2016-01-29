unit K258610458;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K258610458.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K258610458
//
// [$258610458]
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
  MouseSelectPtTest,
  nevTools,
  l3Units
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK258610458 = class(TMouseSelectPtTest)
  {* [$258610458] }
 protected
 // overridden protected methods
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
     {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
     {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure CheckTopAnchor(const aView: InevInputView); override;
     {* проверить якорь начала отрисовки после окончания прокрутки }
   {$IfEnd} //nsTest AND not NoVCM
   function GetPoint(const aMap: InevMap): Tl3Point; override;
     {* Возвращает точку, на которую нужно спозиционироваться. }
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK258610458
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

// start class TK258610458

function TK258610458.GetInnerPara(const aView: InevInputView;
  const aDocument: InevPara): InevPara;
//#UC START# *4BF4E6A00093_4D88869000F9_var*
//#UC END# *4BF4E6A00093_4D88869000F9_var*
begin
//#UC START# *4BF4E6A00093_4D88869000F9_impl*
 Result := aDocument.AsList.Para[0].AsList.Para[0].AsList.Para[0];
                          //^- таблица     ^- строка      ^- ячейка
//#UC END# *4BF4E6A00093_4D88869000F9_impl*
end;//TK258610458.GetInnerPara

{$If defined(nsTest) AND not defined(NoVCM)}
function TK258610458.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4D88869000F9_var*
//#UC END# *4C07AC6F036D_4D88869000F9_var*
begin
//#UC START# *4C07AC6F036D_4D88869000F9_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4D88869000F9_impl*
end;//TK258610458.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TK258610458.CheckTopAnchor(const aView: InevInputView);
//#UC START# *4C1F0A260192_4D88869000F9_var*
//#UC END# *4C1F0A260192_4D88869000F9_var*
begin
//#UC START# *4C1F0A260192_4D88869000F9_impl*
 Check(aView.TopAnchor.AtStart);
//#UC END# *4C1F0A260192_4D88869000F9_impl*
end;//TK258610458.CheckTopAnchor
{$IfEnd} //nsTest AND not NoVCM

function TK258610458.GetPoint(const aMap: InevMap): Tl3Point;
//#UC START# *4C3C927B027E_4D88869000F9_var*
//#UC END# *4C3C927B027E_4D88869000F9_var*
begin
//#UC START# *4C3C927B027E_4D88869000F9_impl*
 Assert(aMap <> nil);
 Result.X := aMap.Bounds.Left + 50;
 Result.Y := aMap.Bounds.Bottom - 200;
//#UC END# *4C3C927B027E_4D88869000F9_impl*
end;//TK258610458.GetPoint

function TK258610458.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK258610458.GetFolder

function TK258610458.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D88869000F9';
end;//TK258610458.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK258610458.Suite);

end.