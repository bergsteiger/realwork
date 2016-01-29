unit InsertSectionBreak;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/InsertSectionBreak.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TInsertSectionBreak
//
// Тест на вставку разрыва раздела.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Abstract_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evCustomEditorWindow
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextViaEditorProcessor
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _CursorMover_Parent_ = TTextViaEditorProcessor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 TInsertSectionBreak = {abstract} class(_CursorMover_)
  {* Тест на вставку разрыва раздела. }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* Собственно процесс обработки текста }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
     {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function WebStyle: Boolean; override;
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   function MoveCursorCount: Integer; virtual; abstract;
   procedure CheckPara(const aText: TevCustomEditorWindow); virtual; abstract;
 end;//TInsertSectionBreak
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evdTypes,
  TestFrameWork,
  evMsgCode,
  evOp
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

// start class TInsertSectionBreak

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TInsertSectionBreak.Process(aForm: TPrimTextLoadForm);
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
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TInsertSectionBreak.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4E158BBC032C_var*
//#UC END# *4C07AC6F036D_4E158BBC032C_var*
begin
//#UC START# *4C07AC6F036D_4E158BBC032C_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4E158BBC032C_impl*
end;//TInsertSectionBreak.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TInsertSectionBreak.WebStyle: Boolean;
//#UC START# *4C08CF4300BE_4E158BBC032C_var*
//#UC END# *4C08CF4300BE_4E158BBC032C_var*
begin
//#UC START# *4C08CF4300BE_4E158BBC032C_impl*
 Result := False;
//#UC END# *4C08CF4300BE_4E158BBC032C_impl*
end;//TInsertSectionBreak.WebStyle
{$IfEnd} //nsTest AND not NoVCM

function TInsertSectionBreak.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TInsertSectionBreak.GetFolder

function TInsertSectionBreak.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E158BBC032C';
end;//TInsertSectionBreak.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.