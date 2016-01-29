unit K228692531;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K228692531.pas"
// Начат: 28.07.2010 15:02
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K228692531
//
// {RequestLink:228692531}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  InsertStreamTest,
  evCustomEditorWindow,
  l3Variant
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _CursorMover_Parent_ = TInsertStreamTest;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 TK228692531 = class(_CursorMover_)
  {* [RequestLink:228692531] }
 protected
 // realized methods
   function TextForInsert: AnsiString; override;
     {* Текст для вставки }
   procedure Navigate(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); override;
     {* Устанавливает курсор или выделение }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK228692531
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
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

// start class TK228692531

function TK228692531.TextForInsert: AnsiString;
//#UC START# *4C4FDCBA002F_4C500E2C0117_var*
//#UC END# *4C4FDCBA002F_4C500E2C0117_var*
begin
//#UC START# *4C4FDCBA002F_4C500E2C0117_impl*
 Result := 'a'#13#10'b';
//#UC END# *4C4FDCBA002F_4C500E2C0117_impl*
end;//TK228692531.TextForInsert

procedure TK228692531.Navigate(aText: TevCustomEditorWindow;
  const anOp: Il3OpPack);
//#UC START# *4C4FE56300FB_4C500E2C0117_var*
//#UC END# *4C4FE56300FB_4C500E2C0117_var*
begin
//#UC START# *4C4FE56300FB_4C500E2C0117_impl*
 aText.Selection.ProcessCommand(ev_msgMove, ev_ocParaDown, anOp, 1);
 aText.Selection.ProcessCommand(ev_msgMove, ev_ocExtParaDown, anOp, 1);
 aText.Selection.ProcessCommand(ev_msgMove, ev_ocExtCharRight, anOp, 1);
//#UC END# *4C4FE56300FB_4C500E2C0117_impl*
end;//TK228692531.Navigate

function TK228692531.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK228692531.GetFolder

function TK228692531.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C500E2C0117';
end;//TK228692531.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK228692531.Suite);

end.