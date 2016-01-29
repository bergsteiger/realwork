unit K216074128;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K216074128.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K216074128
//
// [$216074128]
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
  ScrollAndSelectPtTest,
  nevTools,
  l3Units
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK216074128 = class(TScrollAndSelectPtTest)
  {* [$216074128] }
 protected
 // overridden protected methods
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
     {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
   function GetScrollCount: Integer; override;
   function GetPoint(const aMap: InevMap): Tl3Point; override;
     {* Возвращает точку, на которую нужно спозиционироваться. }
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK216074128
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

// start class TK216074128

function TK216074128.GetInnerPara(const aView: InevInputView;
  const aDocument: InevPara): InevPara;
//#UC START# *4BF4E6A00093_4BFE3F220082_var*
//#UC END# *4BF4E6A00093_4BFE3F220082_var*
begin
//#UC START# *4BF4E6A00093_4BFE3F220082_impl*
 Result := aDocument.AsList.Para[1]; // Таблица
 Result := Result.AsList.Para[8]; // Строка
 Result := Result.AsList.Para[0]; // Ячейка
//#UC END# *4BF4E6A00093_4BFE3F220082_impl*
end;//TK216074128.GetInnerPara

function TK216074128.GetScrollCount: Integer;
//#UC START# *4BFE40CD0337_4BFE3F220082_var*
//#UC END# *4BFE40CD0337_4BFE3F220082_var*
begin
//#UC START# *4BFE40CD0337_4BFE3F220082_impl*
 Result := 3;
//#UC END# *4BFE40CD0337_4BFE3F220082_impl*
end;//TK216074128.GetScrollCount

function TK216074128.GetPoint(const aMap: InevMap): Tl3Point;
//#UC START# *4C3C927B027E_4BFE3F220082_var*
//#UC END# *4C3C927B027E_4BFE3F220082_var*
begin
//#UC START# *4C3C927B027E_4BFE3F220082_impl*
 Result := l3Point(aMap.Bounds.Left - 500, aMap.Bounds.Bottom);
//#UC END# *4C3C927B027E_4BFE3F220082_impl*
end;//TK216074128.GetPoint

function TK216074128.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK216074128.GetFolder

function TK216074128.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BFE3F220082';
end;//TK216074128.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK216074128.Suite);

end.