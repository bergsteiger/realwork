unit TableToolsTestPrim;

// Модуль: "w:\common\components\gui\Garant\Daily\TableToolsTestPrim.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextViaEditorProcessor
 , evEditorInterfaces
 , PrimTextLoad_Form
;

type
 TTableToolsTestPrim = {abstract} class(TTextViaEditorProcessor)
  protected
   procedure ApplyTools(const aRange: IedRange); virtual; abstract;
    {* Вызвать инструмент для таблицы }
   procedure CheckOperation(aForm: TPrimTextLoadForm); virtual; abstract;
    {* Проверка после применения инструмента. }
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* Собственно процесс обработки текста }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TTableToolsTestPrim
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

procedure TTableToolsTestPrim.Process(aForm: TPrimTextLoadForm);
 {* Собственно процесс обработки текста }
//#UC START# *4BE13147032C_4CE38AD60265_var*
//#UC END# *4BE13147032C_4CE38AD60265_var*
begin
//#UC START# *4BE13147032C_4CE38AD60265_impl*
 ApplyTools(aForm.Text.Range);
 CheckOperation(aForm);
//#UC END# *4BE13147032C_4CE38AD60265_impl*
end;//TTableToolsTestPrim.Process

function TTableToolsTestPrim.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TTableToolsTestPrim.GetFolder

function TTableToolsTestPrim.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CE38AD60265';
end;//TTableToolsTestPrim.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
