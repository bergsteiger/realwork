unit DrawTestPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Модуль: "w:/common/components/gui/Garant/Daily/DrawTestPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TDrawTestPrim
//
// Базовый тест для отрисовки и сравнения.
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
  evCustomEditorWindow,
  TextEditorVisitor,
  PrimTextLoad_Form,
  nevTools,
  nevShapesPaintedSpy
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 _DrawOutputSupport_Parent_ = TTextEditorVisitor;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\DrawOutputSupport.imp.pas}
 TDrawTestPrim = {abstract} class(_DrawOutputSupport_)
  {* Базовый тест для отрисовки и сравнения. }
 private
 // private fields
   f_Editor : TevCustomEditorWindow;
 protected
 // realized methods
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
   {$If not defined(NoScripts)}
   function DoOpenLog(const aView: InevView): AnsiString; override;
   {$IfEnd} //not NoScripts
   {$If not defined(NoScripts)}
   procedure DoCloseLog(const aLogName: AnsiString); override;
   {$IfEnd} //not NoScripts
 protected
 // overridden protected methods
    {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   function FileForOutput: AnsiString; override;
     {* Стандартный файл для вывода, для текщего теста }
    {$IfEnd} //nsTest AND not NotTunedDUnit
   function WebStyle: Boolean; override;
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
    {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   function RaiseIfEtalonCreated: Boolean; override;
    {$IfEnd} //nsTest AND not NotTunedDUnit
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   procedure DoBeforeDrawing(aForm: TPrimTextLoadForm); virtual; abstract;
     {* Произвести какие-нибудь операции перед отрисовкой. }
 end;//TDrawTestPrim
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  SysUtils,
  TestFrameWork,
  vcmBase
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

{$Include w:\common\components\rtl\Garant\ScriptEngine\DrawOutputSupport.imp.pas}

// start class TDrawTestPrim

procedure TDrawTestPrim.DoVisit(aForm: TPrimTextLoadForm);
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

{$If not defined(NoScripts)}
function TDrawTestPrim.DoOpenLog(const aView: InevView): AnsiString;
//#UC START# *4E1C0C6C026C_4CAC405703AE_var*
//#UC END# *4E1C0C6C026C_4CAC405703AE_var*
begin
//#UC START# *4E1C0C6C026C_4CAC405703AE_impl*
 Result := OutputPath + KPage + '.shapes';
//#UC END# *4E1C0C6C026C_4CAC405703AE_impl*
end;//TDrawTestPrim.DoOpenLog
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
procedure TDrawTestPrim.DoCloseLog(const aLogName: AnsiString);
//#UC START# *4E1C0C8C0007_4CAC405703AE_var*
//#UC END# *4E1C0C8C0007_4CAC405703AE_var*
begin
//#UC START# *4E1C0C8C0007_4CAC405703AE_impl*
 CheckOutputWithInput(ChangeFileExt(ExtractFileName(aLogName), EtalonSuffix + '.shapes'));
//#UC END# *4E1C0C8C0007_4CAC405703AE_impl*
end;//TDrawTestPrim.DoCloseLog
{$IfEnd} //not NoScripts

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
function TDrawTestPrim.FileForOutput: AnsiString;
//#UC START# *4B4F588B0241_4CAC405703AE_var*
//#UC END# *4B4F588B0241_4CAC405703AE_var*
begin
//#UC START# *4B4F588B0241_4CAC405703AE_impl*
 Result := OutputPath + KPage + '.shapes';
//#UC END# *4B4F588B0241_4CAC405703AE_impl*
end;//TDrawTestPrim.FileForOutput
{$IfEnd} //nsTest AND not NotTunedDUnit

function TDrawTestPrim.WebStyle: Boolean;
//#UC START# *4C08CF4300BE_4CAC405703AE_var*
//#UC END# *4C08CF4300BE_4CAC405703AE_var*
begin
//#UC START# *4C08CF4300BE_4CAC405703AE_impl*
 Result := False;
//#UC END# *4C08CF4300BE_4CAC405703AE_impl*
end;//TDrawTestPrim.WebStyle

function TDrawTestPrim.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TDrawTestPrim.GetFolder

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
function TDrawTestPrim.RaiseIfEtalonCreated: Boolean;
//#UC START# *4CA5DAD4014C_4CAC405703AE_var*
//#UC END# *4CA5DAD4014C_4CAC405703AE_var*
begin
//#UC START# *4CA5DAD4014C_4CAC405703AE_impl*
 Result := False;
//#UC END# *4CA5DAD4014C_4CAC405703AE_impl*
end;//TDrawTestPrim.RaiseIfEtalonCreated
{$IfEnd} //nsTest AND not NotTunedDUnit

function TDrawTestPrim.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CAC405703AE';
end;//TDrawTestPrim.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.