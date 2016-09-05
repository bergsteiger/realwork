unit OldNSRCFlagCnahge;
 {* Изменить флаг "Выливать в псевдографику" во всех таблицах в документе. }

// Модуль: "w:\common\components\gui\Garant\Daily\OldNSRCFlagCnahge.pas"
// Стереотип: "TestCase"
// Элемент модели: "TOldNSRCFlagCnahge" MUID: (4C3FEBB500B2)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , ChangeAllTablesTest
 , evCustomEditor
;

type
 TOldNSRCFlagCnahge = {abstract} class(TChangeAllTablesTest)
  {* Изменить флаг "Выливать в псевдографику" во всех таблицах в документе. }
  protected
   procedure ApplyEditorTool(aEditor: TevCustomEditor); override;
    {* Вызов инструмента из редактора }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TOldNSRCFlagCnahge
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4C3FEBB500B2impl_uses*
 //#UC END# *4C3FEBB500B2impl_uses*
;

procedure TOldNSRCFlagCnahge.ApplyEditorTool(aEditor: TevCustomEditor);
 {* Вызов инструмента из редактора }
//#UC START# *4C3FF0DB0072_4C3FEBB500B2_var*
//#UC END# *4C3FF0DB0072_4C3FEBB500B2_var*
begin
//#UC START# *4C3FF0DB0072_4C3FEBB500B2_impl*
 aEditor.SetOldNSRCFlag;
//#UC END# *4C3FF0DB0072_4C3FEBB500B2_impl*
end;//TOldNSRCFlagCnahge.ApplyEditorTool

function TOldNSRCFlagCnahge.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TOldNSRCFlagCnahge.GetFolder

function TOldNSRCFlagCnahge.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C3FEBB500B2';
end;//TOldNSRCFlagCnahge.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
