unit OldNSRCFlagCnahge;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Модуль: "w:/common/components/gui/Garant/Daily/OldNSRCFlagCnahge.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TOldNSRCFlagCnahge
//
// Изменить флаг "Выливать в псевдографику" во всех таблицах в документе.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  ChangeAllTablesTest,
  evCustomEditor
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TOldNSRCFlagCnahge = {abstract} class(TChangeAllTablesTest)
  {* Изменить флаг "Выливать в псевдографику" во всех таблицах в документе. }
 protected
 // realized methods
   procedure ApplyEditorTool(aEditor: TevCustomEditor); override;
     {* Вызов инструмента из редактора }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TOldNSRCFlagCnahge
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  TestFrameWork,
  vcmBase,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

// start class TOldNSRCFlagCnahge

procedure TOldNSRCFlagCnahge.ApplyEditorTool(aEditor: TevCustomEditor);
//#UC START# *4C3FF0DB0072_4C3FEBB500B2_var*
//#UC END# *4C3FF0DB0072_4C3FEBB500B2_var*
begin
//#UC START# *4C3FF0DB0072_4C3FEBB500B2_impl*
 aEditor.SetOldNSRCFlag;
//#UC END# *4C3FF0DB0072_4C3FEBB500B2_impl*
end;//TOldNSRCFlagCnahge.ApplyEditorTool

function TOldNSRCFlagCnahge.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TOldNSRCFlagCnahge.GetFolder

function TOldNSRCFlagCnahge.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C3FEBB500B2';
end;//TOldNSRCFlagCnahge.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.