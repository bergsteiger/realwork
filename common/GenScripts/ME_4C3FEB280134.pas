unit ChangeAllTablesTest;
 {* Работа со всеми таблицами документа. }

// Модуль: "w:\common\components\gui\Garant\Daily\ChangeAllTablesTest.pas"
// Стереотип: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextViaEditorProcessor
 , evCustomEditor
 , PrimTextLoad_Form
;

type
 TChangeAllTablesTest = {abstract} class(TTextViaEditorProcessor)
  {* Работа со всеми таблицами документа. }
  protected
   procedure ApplyEditorTool(aEditor: TevCustomEditor); virtual; abstract;
    {* Вызов инструмента из редактора }
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* Собственно процесс обработки текста }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TChangeAllTablesTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , evTypes
 , TestFrameWork
;

procedure TChangeAllTablesTest.Process(aForm: TPrimTextLoadForm);
 {* Собственно процесс обработки текста }
//#UC START# *4BE13147032C_4C3FEB280134_var*
//#UC END# *4BE13147032C_4C3FEB280134_var*
begin
//#UC START# *4BE13147032C_4C3FEB280134_impl*
 aForm.Text.Select(ev_stDocument);
 ApplyEditorTool(aForm.Text);
//#UC END# *4BE13147032C_4C3FEB280134_impl*
end;//TChangeAllTablesTest.Process

function TChangeAllTablesTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TChangeAllTablesTest.GetFolder

function TChangeAllTablesTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C3FEB280134';
end;//TChangeAllTablesTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
