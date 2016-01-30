unit ColumnAlignHorisontallyTest;
 {* Выравнивание текста в колонке горизотально. }

// Модуль: "w:\common\components\rtl\Garant\Daily\ColumnAlignHorisontallyTest.pas"
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
 TColumnAlignHorisontallyTest = {abstract} class(TTableToolsTest)
  {* Выравнивание текста в колонке горизотально. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
    {* Вызвать инструмент для таблицы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TColumnAlignHorisontallyTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
procedure TColumnAlignHorisontallyTest.ApplyTools(const aRange: IedRange);
 {* Вызвать инструмент для таблицы }
//#UC START# *4C345B580083_4C3C2BE800AF_var*
//#UC END# *4C345B580083_4C3C2BE800AF_var*
begin
//#UC START# *4C345B580083_4C3C2BE800AF_impl*
 aRange.TextParagraph.Formatting.HorizontalAligment := ed_halLeft; 
//#UC END# *4C345B580083_4C3C2BE800AF_impl*
end;//TColumnAlignHorisontallyTest.ApplyTools
{$IfEnd} // NOT Defined(NoVCM)

function TColumnAlignHorisontallyTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TColumnAlignHorisontallyTest.GetFolder

function TColumnAlignHorisontallyTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C3C2BE800AF';
end;//TColumnAlignHorisontallyTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
