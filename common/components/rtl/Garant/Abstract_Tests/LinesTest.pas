unit LinesTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/LinesTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TLinesTest
//
// Тестирование отрисовки линий.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Abstract_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextEditorVisitor
  {$IfEnd} //nsTest AND not NoVCM
  ,
  l3FrameLinesSpy
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  ,
  l3InternalInterfaces
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TLinesTest = {abstract} class(TTextEditorVisitor, Il3FrameLinesLogger)
  {* Тестирование отрисовки линий. }
 private
 // private fields
   f_ObjID : Integer;
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
   {$IfEnd} //nsTest AND not NoVCM
   function OpenLinesLog(const aCanvas: Il3InfoCanvas;
     aObjID: Integer): AnsiString;
   procedure CloseLinesLog(const aLogName: AnsiString);
   function GetPrecision: Integer;
 protected
 // overridden protected methods
    {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   function FileForOutput: AnsiString; override;
     {* Стандартный файл для вывода, для текщего теста }
    {$IfEnd} //nsTest AND not NotTunedDUnit
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TLinesTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
  TestFrameWork
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TLinesTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TLinesTest.DoVisit(aForm: TPrimTextLoadForm);
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
{$IfEnd} //nsTest AND not NoVCM

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

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
function TLinesTest.FileForOutput: AnsiString;
//#UC START# *4B4F588B0241_4DA6907500D9_var*
//#UC END# *4B4F588B0241_4DA6907500D9_var*
begin
//#UC START# *4B4F588B0241_4DA6907500D9_impl*
 Result := OutputPath + KPage + '_' + IntToStr(f_ObjID) + '.lines';
//#UC END# *4B4F588B0241_4DA6907500D9_impl*
end;//TLinesTest.FileForOutput
{$IfEnd} //nsTest AND not NotTunedDUnit

function TLinesTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TLinesTest.GetFolder

function TLinesTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DA6907500D9';
end;//TLinesTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.