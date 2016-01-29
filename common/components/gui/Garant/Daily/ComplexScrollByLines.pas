unit ComplexScrollByLines;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Модуль: "w:/common/components/gui/Garant/Daily/ComplexScrollByLines.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::ComplexScrollByLines
//
// Тест вида - прокрутили на несколько строк вниз, а потом на несколько вверх.
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
  TextEditorVisitor,
  PrimTextLoad_Form
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TComplexScrollByLines = {abstract} class(TTextEditorVisitor)
  {* Тест вида - прокрутили на несколько строк вниз, а потом на несколько вверх. }
 protected
 // realized methods
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   function GetScrollLineCount2Down: Integer; virtual; abstract;
     {* количество строк для прокрутки вниз }
   function GetScrollLineCount2Up: Integer; virtual; abstract;
     {* количество строк для прокрутки вверх }
 end;//TComplexScrollByLines
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

// start class TComplexScrollByLines

procedure TComplexScrollByLines.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4C1B135F02B0_var*
//#UC END# *4BE419AF0217_4C1B135F02B0_var*
begin
//#UC START# *4BE419AF0217_4C1B135F02B0_impl*
 ScrollByLine(aForm, GetScrollLineCount2Down, False, False);
 ScrollByLine(aForm, GetScrollLineCount2Up, True, False);
 CheckTopAnchor(aForm.Text.View);
//#UC END# *4BE419AF0217_4C1B135F02B0_impl*
end;//TComplexScrollByLines.DoVisit

function TComplexScrollByLines.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TComplexScrollByLines.GetFolder

function TComplexScrollByLines.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C1B135F02B0';
end;//TComplexScrollByLines.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.