unit K213713837;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K213713837.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K213713837
//
// [$213713837]
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
  SelectPtTest,
  nevTools,
  l3Units
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK213713837 = class(TSelectPtTest)
  {* [$213713837] }
 protected
 // overridden protected methods
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
     {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
   function GetPoint(const aMap: InevMap): Tl3Point; override;
     {* Возвращает точку, на которую нужно спозиционироваться. }
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK213713837
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

// start class TK213713837

function TK213713837.GetInnerPara(const aView: InevInputView;
  const aDocument: InevPara): InevPara;
//#UC START# *4BF4E6A00093_4BF4E93C03C3_var*
//#UC END# *4BF4E6A00093_4BF4E93C03C3_var*
begin
//#UC START# *4BF4E6A00093_4BF4E93C03C3_impl*
 Result := aDocument.AsList.Para[2]; // Таблица
 Result := Result.AsList.Para[2]; // Строка
 Result := Result.AsList.Para[3]; // Ячейка
 Result := Result.AsList.Para[Result.ChildrenCount - 1]; // Текст
//#UC END# *4BF4E6A00093_4BF4E93C03C3_impl*
end;//TK213713837.GetInnerPara

function TK213713837.GetPoint(const aMap: InevMap): Tl3Point;
//#UC START# *4C3C927B027E_4BF4E93C03C3_var*
//#UC END# *4C3C927B027E_4BF4E93C03C3_var*
begin
//#UC START# *4C3C927B027E_4BF4E93C03C3_impl*
 Result := l3Point(aMap.Bounds.Left + 500, aMap.Bounds.Bottom + 500);
//#UC END# *4C3C927B027E_4BF4E93C03C3_impl*
end;//TK213713837.GetPoint

function TK213713837.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK213713837.GetFolder

function TK213713837.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BF4E93C03C3';
end;//TK213713837.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK213713837.Suite);

end.