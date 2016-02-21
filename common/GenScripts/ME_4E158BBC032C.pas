unit InsertSectionBreak;
 {* Тест на вставку разрыва раздела. }

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\InsertSectionBreak.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Abstract_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TextViaEditorProcessor
 {$IfEnd} // NOT Defined(NoVCM)
 , evCustomEditorWindow
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _CursorMover_Parent_ = TTextViaEditorProcessor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 TInsertSectionBreak = {abstract} class(_CursorMover_)
  {* Тест на вставку разрыва раздела. }
  protected
   function MoveCursorCount: Integer; virtual; abstract;
   procedure CheckPara(const aText: TevCustomEditorWindow); virtual; abstract;
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* Собственно процесс обработки текста }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function WebStyle: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TInsertSectionBreak
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evdTypes
 , TestFrameWork
 , evMsgCode
 , evOp
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$If not Declared(_FormClass_)}type _FormClass_ = TPrimTextLoadForm;{$IfEnd}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TInsertSectionBreak.Process(aForm: TPrimTextLoadForm);
 {* Собственно процесс обработки текста }
//#UC START# *4BE13147032C_4E158BBC032C_var*
var
 i: Integer;
//#UC END# *4BE13147032C_4E158BBC032C_var*
begin
//#UC START# *4BE13147032C_4E158BBC032C_impl*
 for i := 0 to MoveCursorCount - 1 do
  aForm.Text.Selection.Cursor.MostInner.Move(aForm.Text.View, ev_ocParaDown);
 aForm.Text.InsertPageBreak(True, ev_poLandscape);
 CheckPara(aForm.Text);
//#UC END# *4BE13147032C_4E158BBC032C_impl*
end;//TInsertSectionBreak.Process
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TInsertSectionBreak.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4E158BBC032C_var*
//#UC END# *4C07AC6F036D_4E158BBC032C_var*
begin
//#UC START# *4C07AC6F036D_4E158BBC032C_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4E158BBC032C_impl*
end;//TInsertSectionBreak.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TInsertSectionBreak.WebStyle: Boolean;
//#UC START# *4C08CF4300BE_4E158BBC032C_var*
//#UC END# *4C08CF4300BE_4E158BBC032C_var*
begin
//#UC START# *4C08CF4300BE_4E158BBC032C_impl*
 Result := False;
//#UC END# *4C08CF4300BE_4E158BBC032C_impl*
end;//TInsertSectionBreak.WebStyle
{$IfEnd} // NOT Defined(NoVCM)

function TInsertSectionBreak.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TInsertSectionBreak.GetFolder

function TInsertSectionBreak.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E158BBC032C';
end;//TInsertSectionBreak.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
