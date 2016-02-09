unit Translate2TextTest;
 {* Преобразовать таблицу или её часть в текст }

// Модуль: "w:\common\components\rtl\Garant\Daily\Translate2TextTest.pas"
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
 TTranslate2TextTest = {abstract} class(TTableToolsTest)
  {* Преобразовать таблицу или её часть в текст }
  protected
   {$If NOT Defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
    {* Вызвать инструмент для таблицы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TTranslate2TextTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$If NOT Defined(NoVCM)}
procedure TTranslate2TextTest.ApplyTools(const aRange: IedRange);
 {* Вызвать инструмент для таблицы }
//#UC START# *4C345B580083_4C3463D800E5_var*
//#UC END# *4C345B580083_4C3463D800E5_var*
begin
//#UC START# *4C345B580083_4C3463D800E5_impl*
 aRange.Table.Cells.Translate2Text;
//#UC END# *4C345B580083_4C3463D800E5_impl*
end;//TTranslate2TextTest.ApplyTools
{$IfEnd} // NOT Defined(NoVCM)

function TTranslate2TextTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TTranslate2TextTest.GetFolder

function TTranslate2TextTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C3463D800E5';
end;//TTranslate2TextTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
