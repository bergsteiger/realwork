unit MoveSubTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/MoveSubTest.pas"
// Начат: 16.09.2010 16:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TMoveSubTest
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
  TextViaEditorProcessorWithNavigate,
  evCustomEditorWindow,
  l3Variant
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _CursorMover_Parent_ = TTextViaEditorProcessorWithNavigate;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 TMoveSubTest = {abstract} class(_CursorMover_)
 protected
 // realized methods
   procedure Navigate(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); override;
     {* Устанавливает курсор или выделение }
   procedure DoProcess(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); override;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TMoveSubTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  nevTools,
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

// start class TMoveSubTest

procedure TMoveSubTest.Navigate(aText: TevCustomEditorWindow;
  const anOp: Il3OpPack);
//#UC START# *4C4FE56300FB_4C920D930026_var*
//#UC END# *4C4FE56300FB_4C920D930026_var*
begin
//#UC START# *4C4FE56300FB_4C920D930026_impl*
 aText.Selection.ProcessCommand(ev_msgMove, ev_ocBottomRight, anOp, 1);
//#UC END# *4C4FE56300FB_4C920D930026_impl*
end;//TMoveSubTest.Navigate

procedure TMoveSubTest.DoProcess(aText: TevCustomEditorWindow;
  const anOp: Il3OpPack);
//#UC START# *4C9214F6002C_4C920D930026_var*
var
 l_Sub : IevSub;
//#UC END# *4C9214F6002C_4C920D930026_var*
begin
//#UC START# *4C9214F6002C_4C920D930026_impl*
 with aText do
 begin
  l_Sub := TextSource.DocumentContainer.SubList.NewSub;
  l_Sub.ID := 1;
  l_Sub.SetTo(Selection.Cursor.MostInner.Obj.AsObject);
 end;//with aText
//#UC END# *4C9214F6002C_4C920D930026_impl*
end;//TMoveSubTest.DoProcess

function TMoveSubTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TMoveSubTest.GetFolder

function TMoveSubTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C920D930026';
end;//TMoveSubTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.