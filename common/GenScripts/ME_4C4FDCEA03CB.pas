unit K228691360;
 {* [RequestLink:228691360] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K228691360.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , InsertStreamTest
 , evCustomEditorWindow
 , l3Variant
;

type
 _CursorMover_Parent_ = TInsertStreamTest;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 TK228691360 = class(_CursorMover_)
  {* [RequestLink:228691360] }
  protected
   function TextForInsert: AnsiString; override;
    {* Текст для вставки }
   procedure Navigate(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); override;
    {* Устанавливает курсор или выделение }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK228691360
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evMsgCode
 , evOp
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
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

function TK228691360.TextForInsert: AnsiString;
 {* Текст для вставки }
//#UC START# *4C4FDCBA002F_4C4FDCEA03CB_var*
//#UC END# *4C4FDCBA002F_4C4FDCEA03CB_var*
begin
//#UC START# *4C4FDCBA002F_4C4FDCEA03CB_impl*
 Result := #13#10;
//#UC END# *4C4FDCBA002F_4C4FDCEA03CB_impl*
end;//TK228691360.TextForInsert

procedure TK228691360.Navigate(aText: TevCustomEditorWindow;
 const anOp: Il3OpPack);
 {* Устанавливает курсор или выделение }
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
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK228691360.GetFolder

function TK228691360.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C4FDCEA03CB';
end;//TK228691360.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK228691360.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
