unit PrimScrollTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Daily/PrimScrollTest.pas"
// Начат: 21.09.2010 15:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TPrimScrollTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  TextEditorVisitor
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TPrimScrollTest = {abstract} class(TTextEditorVisitor)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 public
 // overridden public methods
   function NotForTerminalSession: Boolean; override;
     {* Не запускать тест в терминальной сессии }
 end;//TPrimScrollTest
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  TestFrameWork,
  vcmBase,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

// start class TPrimScrollTest

function TPrimScrollTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TPrimScrollTest.GetFolder

function TPrimScrollTest.NotForTerminalSession: Boolean;
//#UC START# *4C988C1B0246_4C9899150030_var*
//#UC END# *4C988C1B0246_4C9899150030_var*
begin
//#UC START# *4C988C1B0246_4C9899150030_impl*
 Result := true;
//#UC END# *4C988C1B0246_4C9899150030_impl*
end;//TPrimScrollTest.NotForTerminalSession

function TPrimScrollTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C9899150030';
end;//TPrimScrollTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.