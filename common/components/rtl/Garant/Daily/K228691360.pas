unit K228691360;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K228691360.pas"
// Начат: 28.07.2010 11:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K228691360
//
// {RequestLink:228691360}
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
 TK228691360 = class(_CursorMover_)
  {* [RequestLink:228691360] }
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
 end;//TK228691360
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evMsgCode,
  evOp,
  TestFrameWork
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

// start class TK228691360

function TK228691360.TextForInsert: AnsiString;
//#UC START# *4C4FDCBA002F_4C4FDCEA03CB_var*
//#UC END# *4C4FDCBA002F_4C4FDCEA03CB_var*
begin
//#UC START# *4C4FDCBA002F_4C4FDCEA03CB_impl*
 Result := #13#10;
//#UC END# *4C4FDCBA002F_4C4FDCEA03CB_impl*
end;//TK228691360.TextForInsert

procedure TK228691360.Navigate(aText: TevCustomEditorWindow;
  const anOp: Il3OpPack);
//#UC START# *4C4FE56300FB_4C4FDCEA03CB_var*
//#UC END# *4C4FE56300FB_4C4FDCEA03CB_var*
begin
//#UC START# *4C4FE56300FB_4C4FDCEA03CB_impl*
 aText.Selection.ProcessCommand(ev_msgMove, ev_ocParaDown, anOp, 1);
 aText.Selection.ProcessCommand(ev_msgMove, ev_ocExtParaDown, anOp, 1);
 aText.Selection.ProcessCommand(ev_msgMove, ev_ocExtCharRight, anOp, 1);
// aText.Selection.ProcessCommand(ev_msgMove, ev_ocWordRight, anOp, 1);
// aText.Selection.ProcessCommand(ev_msgMove, ev_ocExtWordRight, anOp, 1);
//#UC END# *4C4FE56300FB_4C4FDCEA03CB_impl*
end;//TK228691360.Navigate

function TK228691360.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK228691360.GetFolder

function TK228691360.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C4FDCEA03CB';
end;//TK228691360.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK228691360.Suite);

end.