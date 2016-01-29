unit K253664689;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K253664689.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K253664689
//
// [$253664689]
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
  MergeCellsTest,
  nevTools
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK253664689 = class(TMergeCellsTest)
  {* [$253664689] }
 protected
 // overridden protected methods
   function SelectTableWholly: Boolean; override;
     {* Вылять таблицу целиком }
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetTablePara(const aDocument: InevParaList): InevParaList; override;
     {* Возвращает параграф с таблицей }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK253664689
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evMsgCode,
  evOp
  {$If defined(k2ForEditor)}
  ,
  evCursorTools
  {$IfEnd} //k2ForEditor
  
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

// start class TK253664689

function TK253664689.SelectTableWholly: Boolean;
//#UC START# *4C34625E021F_4D53A238027E_var*
//#UC END# *4C34625E021F_4D53A238027E_var*
begin
//#UC START# *4C34625E021F_4D53A238027E_impl*
 Result := True;
//#UC END# *4C34625E021F_4D53A238027E_impl*
end;//TK253664689.SelectTableWholly

function TK253664689.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK253664689.GetFolder

function TK253664689.GetTablePara(const aDocument: InevParaList): InevParaList;
//#UC START# *4CC818F4022D_4D53A238027E_var*
//#UC END# *4CC818F4022D_4D53A238027E_var*
begin
//#UC START# *4CC818F4022D_4D53A238027E_impl*
 Result := aDocument.Para[1].AsList;
//#UC END# *4CC818F4022D_4D53A238027E_impl*
end;//TK253664689.GetTablePara

function TK253664689.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D53A238027E';
end;//TK253664689.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK253664689.Suite);

end.