unit ColumnAlignHorisontallyTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/ColumnAlignHorisontallyTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TColumnAlignHorisontallyTest
//
// Выравнивание текста в колонке горизотально.
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
  TableToolsTest,
  evEditorInterfaces
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TColumnAlignHorisontallyTest = {abstract} class(TTableToolsTest)
  {* Выравнивание текста в колонке горизотально. }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
     {* Вызвать инструмент для таблицы }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TColumnAlignHorisontallyTest
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

// start class TColumnAlignHorisontallyTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TColumnAlignHorisontallyTest.ApplyTools(const aRange: IedRange);
//#UC START# *4C345B580083_4C3C2BE800AF_var*
//#UC END# *4C345B580083_4C3C2BE800AF_var*
begin
//#UC START# *4C345B580083_4C3C2BE800AF_impl*
 aRange.TextParagraph.Formatting.HorizontalAligment := ed_halLeft; 
//#UC END# *4C345B580083_4C3C2BE800AF_impl*
end;//TColumnAlignHorisontallyTest.ApplyTools
{$IfEnd} //nsTest AND not NoVCM

function TColumnAlignHorisontallyTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TColumnAlignHorisontallyTest.GetFolder

function TColumnAlignHorisontallyTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C3C2BE800AF';
end;//TColumnAlignHorisontallyTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.