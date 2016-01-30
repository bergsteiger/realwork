unit HorzMergeCells;
 {* Объединение ячеек по горизонтали. }

// Модуль: "w:\common\components\rtl\Garant\Daily\HorzMergeCells.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
;

type
 THorzMergeCells = {abstract} class(TTableToolsTest)
  {* Объединение ячеек по горизонтали. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
    {* Вызвать инструмент для таблицы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//THorzMergeCells
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
procedure THorzMergeCells.ApplyTools(const aRange: IedRange);
 {* Вызвать инструмент для таблицы }
//#UC START# *4C345B580083_4DCA1D3D034A_var*
//#UC END# *4C345B580083_4DCA1D3D034A_var*
begin
//#UC START# *4C345B580083_4DCA1D3D034A_impl*
 aRange.Table.Cells.Merge(ed_maHorz);
//#UC END# *4C345B580083_4DCA1D3D034A_impl*
end;//THorzMergeCells.ApplyTools
{$IfEnd} // NOT Defined(NoVCM)

function THorzMergeCells.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//THorzMergeCells.GetFolder

function THorzMergeCells.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4DCA1D3D034A';
end;//THorzMergeCells.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
