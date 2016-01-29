unit ScrollByArrow;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/ScrollByArrow.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TScrollByArrow
//
// Прокрутка документа стрелкой на клавиатуре.
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
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimScrollTest
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _CursorMover_Parent_ = TPrimScrollTest;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 _ScrollSupport_Parent_ = _CursorMover_;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\ScrollSupport.imp.pas}
 TScrollByArrow = {abstract} class(_ScrollSupport_)
  {* Прокрутка документа стрелкой на клавиатуре. }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TScrollByArrow
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evMsgCode,
  evOp,
  l3InternalInterfaces
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\ScrollSupport.imp.pas}

// start class TScrollByArrow

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TScrollByArrow.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4CE282AD019D_var*
//#UC END# *4BE419AF0217_4CE282AD019D_var*
begin
//#UC START# *4BE419AF0217_4CE282AD019D_impl*
 GotoDocumentBottom(aForm);
 while not aForm.Text.View.TopAnchor.AtStart do
 begin
  if not Il3CommandTarget(aForm.Text).ProcessCommand(ev_ocLineUp, True, 1) then Break;
  if ShouldStop then Break;
  Application.ProcessMessages;
 end;//while not Text.View.IsDocumentTailVisible
//#UC END# *4BE419AF0217_4CE282AD019D_impl*
end;//TScrollByArrow.DoVisit
{$IfEnd} //nsTest AND not NoVCM

function TScrollByArrow.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TScrollByArrow.GetFolder

function TScrollByArrow.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CE282AD019D';
end;//TScrollByArrow.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.