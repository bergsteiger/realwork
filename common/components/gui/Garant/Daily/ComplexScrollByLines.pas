unit ComplexScrollByLines;
 {* Тест вида - прокрутили на несколько строк вниз, а потом на несколько вверх. }

// Модуль: "w:\common\components\gui\Garant\Daily\ComplexScrollByLines.pas"
// Стереотип: "TestCase"
// Элемент модели: "ComplexScrollByLines" MUID: (4C1B135F02B0)
// Имя типа: "TComplexScrollByLines"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextEditorVisitor
 , PrimTextLoad_Form
;

type
 TComplexScrollByLines = {abstract} class(TTextEditorVisitor)
  {* Тест вида - прокрутили на несколько строк вниз, а потом на несколько вверх. }
  protected
   function GetScrollLineCount2Down: Integer; virtual; abstract;
    {* количество строк для прокрутки вниз }
   function GetScrollLineCount2Up: Integer; virtual; abstract;
    {* количество строк для прокрутки вверх }
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TComplexScrollByLines
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

procedure TComplexScrollByLines.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
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
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TComplexScrollByLines.GetFolder

function TComplexScrollByLines.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C1B135F02B0';
end;//TComplexScrollByLines.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
