unit SelectColumnAndDelete;
 {* Тест выделения и удаления колонки. }

// Модуль: "w:\common\components\rtl\Garant\Daily\SelectColumnAndDelete.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TSelectColumnAndDelete = {abstract} class(TTableToolsTest)
  {* Тест выделения и удаления колонки. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
    {* Вызвать инструмент для таблицы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$If NOT Defined(NoVCM)}
   procedure CheckOperation(aForm: TPrimTextLoadForm); override;
    {* Проверка после применения инструмента. }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TSelectColumnAndDelete
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , nevTools
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
procedure TSelectColumnAndDelete.ApplyTools(const aRange: IedRange);
 {* Вызвать инструмент для таблицы }
//#UC START# *4C345B580083_4C99945800BC_var*
//#UC END# *4C345B580083_4C99945800BC_var*
begin
//#UC START# *4C345B580083_4C99945800BC_impl*
 aRange.Delete;
//#UC END# *4C345B580083_4C99945800BC_impl*
end;//TSelectColumnAndDelete.ApplyTools
{$IfEnd} // NOT Defined(NoVCM)

function TSelectColumnAndDelete.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TSelectColumnAndDelete.GetFolder

{$If NOT Defined(NoVCM)}
procedure TSelectColumnAndDelete.CheckOperation(aForm: TPrimTextLoadForm);
 {* Проверка после применения инструмента. }
//#UC START# *4C9999C50326_4C99945800BC_var*
var
 l_Leaf: InevLeafPoint;
//#UC END# *4C9999C50326_4C99945800BC_var*
begin
//#UC START# *4C9999C50326_4C99945800BC_impl*
 l_Leaf := aForm.Text.Selection.Cursor.MostInner.AsLeaf;
 Assert(l_Leaf <> nil);
//#UC END# *4C9999C50326_4C99945800BC_impl*
end;//TSelectColumnAndDelete.CheckOperation
{$IfEnd} // NOT Defined(NoVCM)

function TSelectColumnAndDelete.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C99945800BC';
end;//TSelectColumnAndDelete.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
