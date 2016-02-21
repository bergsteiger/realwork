unit LinesTest;
 {* Тестирование отрисовки линий. }

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\LinesTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Abstract_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TextEditorVisitor
 {$IfEnd} // NOT Defined(NoVCM)
 , l3FrameLinesSpy
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
 , l3InternalInterfaces
;

type
 TLinesTest = {abstract} class(TTextEditorVisitor, Il3FrameLinesLogger)
  {* Тестирование отрисовки линий. }
  private
   f_ObjID: Integer;
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   {$IfEnd} // NOT Defined(NoVCM)
   function OpenLinesLog(const aCanvas: Il3InfoCanvas;
    aObjID: Integer): AnsiString;
   procedure CloseLinesLog(const aLogName: AnsiString);
   function GetPrecision: Integer;
   {$If NOT Defined(NotTunedDUnit)}
   function FileForOutput: AnsiString; override;
    {* Стандартный файл для вывода, для текщего теста }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TLinesTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$If NOT Defined(NoVCM)}
procedure TLinesTest.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
//#UC START# *4BE419AF0217_4DA6907500D9_var*
//#UC END# *4BE419AF0217_4DA6907500D9_var*
begin
//#UC START# *4BE419AF0217_4DA6907500D9_impl*
 Tl3FrameLinesSpy.Instance.SetLogger(Self, False);
 try
  aForm.Text.Repaint;
 finally
  Tl3FrameLinesSpy.Instance.RemoveLogger(Self);
 end;
//#UC END# *4BE419AF0217_4DA6907500D9_impl*
end;//TLinesTest.DoVisit
{$IfEnd} // NOT Defined(NoVCM)

function TLinesTest.OpenLinesLog(const aCanvas: Il3InfoCanvas;
 aObjID: Integer): AnsiString;
//#UC START# *4D00C91B03B2_4DA6907500D9_var*
//#UC END# *4D00C91B03B2_4DA6907500D9_var*
begin
//#UC START# *4D00C91B03B2_4DA6907500D9_impl*
 Result := OutputPath + KPage + '_' + IntToStr(aObjID) + '.lines';
 f_ObjID := aObjID;
//#UC END# *4D00C91B03B2_4DA6907500D9_impl*
end;//TLinesTest.OpenLinesLog

procedure TLinesTest.CloseLinesLog(const aLogName: AnsiString);
//#UC START# *4D00C9410153_4DA6907500D9_var*
//#UC END# *4D00C9410153_4DA6907500D9_var*
begin
//#UC START# *4D00C9410153_4DA6907500D9_impl*
 CheckOutputWithInput(ChangeFileExt(ExtractFileName(aLogName), EtalonSuffix + '.lines'));
//#UC END# *4D00C9410153_4DA6907500D9_impl*
end;//TLinesTest.CloseLinesLog

function TLinesTest.GetPrecision: Integer;
//#UC START# *4FA3D5A500A9_4DA6907500D9_var*
//#UC END# *4FA3D5A500A9_4DA6907500D9_var*
begin
//#UC START# *4FA3D5A500A9_4DA6907500D9_impl*
 Result := 100;
//#UC END# *4FA3D5A500A9_4DA6907500D9_impl*
end;//TLinesTest.GetPrecision

{$If NOT Defined(NotTunedDUnit)}
function TLinesTest.FileForOutput: AnsiString;
 {* Стандартный файл для вывода, для текщего теста }
//#UC START# *4B4F588B0241_4DA6907500D9_var*
//#UC END# *4B4F588B0241_4DA6907500D9_var*
begin
//#UC START# *4B4F588B0241_4DA6907500D9_impl*
 Result := OutputPath + KPage + '_' + IntToStr(f_ObjID) + '.lines';
//#UC END# *4B4F588B0241_4DA6907500D9_impl*
end;//TLinesTest.FileForOutput
{$IfEnd} // NOT Defined(NotTunedDUnit)

function TLinesTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TLinesTest.GetFolder

function TLinesTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4DA6907500D9';
end;//TLinesTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
