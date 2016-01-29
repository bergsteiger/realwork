unit K228692538;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K228692538.pas"
// Начат: 28.07.2010 15:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K228692538
//
// {RequestLink:228692538}
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
 TK228692538 = class(_CursorMover_)
  {* [RequestLink:228692538] }
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
 end;//TK228692538
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

// start class TK228692538

function TK228692538.TextForInsert: AnsiString;
//#UC START# *4C4FDCBA002F_4C501524004F_var*
//#UC END# *4C4FDCBA002F_4C501524004F_var*
begin
//#UC START# *4C4FDCBA002F_4C501524004F_impl*
 Result := #13#10;
//#UC END# *4C4FDCBA002F_4C501524004F_impl*
end;//TK228692538.TextForInsert

procedure TK228692538.Navigate(aText: TevCustomEditorWindow;
  const anOp: Il3OpPack);
//#UC START# *4C4FE56300FB_4C501524004F_var*
//#UC END# *4C4FE56300FB_4C501524004F_var*
begin
//#UC START# *4C4FE56300FB_4C501524004F_impl*
 aText.Selection.ProcessCommand(ev_msgMove, ev_ocExtWordRight, anOp, 1);
//#UC END# *4C4FE56300FB_4C501524004F_impl*
end;//TK228692538.Navigate

function TK228692538.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK228692538.GetFolder

function TK228692538.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C501524004F';
end;//TK228692538.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK228692538.Suite);

end.