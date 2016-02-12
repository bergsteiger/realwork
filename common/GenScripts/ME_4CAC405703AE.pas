unit DrawTestPrim;
 {* Базовый тест для отрисовки и сравнения. }

// Модуль: "w:\common\components\gui\Garant\Daily\DrawTestPrim.pas"
// Стереотип: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextEditorVisitor
 , evCustomEditorWindow
 , PrimTextLoad_Form
 , nevTools
 , nevShapesPaintedSpy
;

type
 _DrawOutputSupport_Parent_ = TTextEditorVisitor;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\DrawOutputSupport.imp.pas}
 TDrawTestPrim = {abstract} class(_DrawOutputSupport_)
  {* Базовый тест для отрисовки и сравнения. }
  private
   f_Editor: TevCustomEditorWindow;
  protected
   procedure DoBeforeDrawing(aForm: TPrimTextLoadForm); virtual; abstract;
    {* Произвести какие-нибудь операции перед отрисовкой. }
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   {$If NOT Defined(NoScripts)}
   function DoOpenLog(const aView: InevView): AnsiString; override;
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   procedure DoCloseLog(const aLogName: AnsiString); override;
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NotTunedDUnit)}
   function FileForOutput: AnsiString; override;
    {* Стандартный файл для вывода, для текщего теста }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   function WebStyle: Boolean; override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$If NOT Defined(NotTunedDUnit)}
   function RaiseIfEtalonCreated: Boolean; override;
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TDrawTestPrim
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , TestFrameWork
 , vcmBase
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$If not Declared(_FormClass_)}type _FormClass_ = TPrimTextLoadForm;{$IfEnd}

{$Include w:\common\components\rtl\Garant\ScriptEngine\DrawOutputSupport.imp.pas}

procedure TDrawTestPrim.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
//#UC START# *4BE419AF0217_4CAC405703AE_var*
//#UC END# *4BE419AF0217_4CAC405703AE_var*
begin
//#UC START# *4BE419AF0217_4CAC405703AE_impl*
 DoBeforeDrawing(aForm);
 aForm.Text.View.ClearShapes;
 // - чтобы почистить всю предыдущую историю отрисовок редактора
 SaveDrawing(aForm.Text);
//#UC END# *4BE419AF0217_4CAC405703AE_impl*
end;//TDrawTestPrim.DoVisit

{$If NOT Defined(NoScripts)}
function TDrawTestPrim.DoOpenLog(const aView: InevView): AnsiString;
//#UC START# *4E1C0C6C026C_4CAC405703AE_var*
//#UC END# *4E1C0C6C026C_4CAC405703AE_var*
begin
//#UC START# *4E1C0C6C026C_4CAC405703AE_impl*
 Result := OutputPath + KPage + '.shapes';
//#UC END# *4E1C0C6C026C_4CAC405703AE_impl*
end;//TDrawTestPrim.DoOpenLog
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
procedure TDrawTestPrim.DoCloseLog(const aLogName: AnsiString);
//#UC START# *4E1C0C8C0007_4CAC405703AE_var*
//#UC END# *4E1C0C8C0007_4CAC405703AE_var*
begin
//#UC START# *4E1C0C8C0007_4CAC405703AE_impl*
 CheckOutputWithInput(ChangeFileExt(ExtractFileName(aLogName), EtalonSuffix + '.shapes'));
//#UC END# *4E1C0C8C0007_4CAC405703AE_impl*
end;//TDrawTestPrim.DoCloseLog
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NotTunedDUnit)}
function TDrawTestPrim.FileForOutput: AnsiString;
 {* Стандартный файл для вывода, для текщего теста }
//#UC START# *4B4F588B0241_4CAC405703AE_var*
//#UC END# *4B4F588B0241_4CAC405703AE_var*
begin
//#UC START# *4B4F588B0241_4CAC405703AE_impl*
 Result := OutputPath + KPage + '.shapes';
//#UC END# *4B4F588B0241_4CAC405703AE_impl*
end;//TDrawTestPrim.FileForOutput
{$IfEnd} // NOT Defined(NotTunedDUnit)

function TDrawTestPrim.WebStyle: Boolean;
//#UC START# *4C08CF4300BE_4CAC405703AE_var*
//#UC END# *4C08CF4300BE_4CAC405703AE_var*
begin
//#UC START# *4C08CF4300BE_4CAC405703AE_impl*
 Result := False;
//#UC END# *4C08CF4300BE_4CAC405703AE_impl*
end;//TDrawTestPrim.WebStyle

function TDrawTestPrim.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TDrawTestPrim.GetFolder

{$If NOT Defined(NotTunedDUnit)}
function TDrawTestPrim.RaiseIfEtalonCreated: Boolean;
//#UC START# *4CA5DAD4014C_4CAC405703AE_var*
//#UC END# *4CA5DAD4014C_4CAC405703AE_var*
begin
//#UC START# *4CA5DAD4014C_4CAC405703AE_impl*
 Result := False;
//#UC END# *4CA5DAD4014C_4CAC405703AE_impl*
end;//TDrawTestPrim.RaiseIfEtalonCreated
{$IfEnd} // NOT Defined(NotTunedDUnit)

function TDrawTestPrim.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CAC405703AE';
end;//TDrawTestPrim.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
