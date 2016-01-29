unit PreviewWithLinesTestBefore235875079;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Модуль: "w:/common/components/gui/Garant/Daily/PreviewWithLinesTestBefore235875079.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TPreviewWithLinesTestBefore235875079
//
// Тест печати с логом отрисованных линий
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
  PreviewTestBefore235875079,
  l3FrameLinesSpy,
  PrimTextLoad_Form,
  l3InternalInterfaces
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TPreviewWithLinesTestBefore235875079 = {abstract} class(TPreviewTestBefore235875079, Il3FrameLinesLogger)
  {* Тест печати с логом отрисованных линий }
 private
 // private fields
   f_CurrentLinesOutput : AnsiString;
 protected
 // realized methods
   function OpenLinesLog(const aCanvas: Il3InfoCanvas;
     aObjID: Integer): AnsiString;
   procedure CloseLinesLog(const aLogName: AnsiString);
   function GetPrecision: Integer;
 protected
 // overridden protected methods
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TPreviewWithLinesTestBefore235875079
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  SysUtils,
  l3String,
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

// start class TPreviewWithLinesTestBefore235875079

function TPreviewWithLinesTestBefore235875079.OpenLinesLog(const aCanvas: Il3InfoCanvas;
  aObjID: Integer): AnsiString;
//#UC START# *4D00C91B03B2_4D00D88F0282_var*
var
 l_WN : String;
//#UC END# *4D00C91B03B2_4D00D88F0282_var*
begin
//#UC START# *4D00C91B03B2_4D00D88F0282_impl*
 if (f_LogNumber = 0) then
  l_WN := ''
 else
  l_WN := '.' + l3LeftPadChar(IntToStr(f_LogNumber), 2, '0');
 f_LogNumber := aCanvas.PageWidthNumber;
 Result := Format('%s%s.%s%s.%d.lines',
                  [OutputPath,
                   KPage,
                   l3LeftPadChar(IntToStr(aCanvas.PageNumber), 4, '0'),
                   l_WN,
                   aObjID
                  ]);
 f_CurrentLinesOutput := Result;
//#UC END# *4D00C91B03B2_4D00D88F0282_impl*
end;//TPreviewWithLinesTestBefore235875079.OpenLinesLog

procedure TPreviewWithLinesTestBefore235875079.CloseLinesLog(const aLogName: AnsiString);
//#UC START# *4D00C9410153_4D00D88F0282_var*
var
 l_PrevOutput: string;
//#UC END# *4D00C9410153_4D00D88F0282_var*
begin
//#UC START# *4D00C9410153_4D00D88F0282_impl*
  l_PrevOutput := f_CurrentOutput;
  try
   f_CurrentOutput := f_CurrentLinesOutput;
   CheckOutputWithInput(ChangeFileExt(ExtractFileName(aLogName), EtalonSuffix + '.lines'),
                        #0,
                        '',
                        True);
  finally
   f_CurrentOutput := l_PrevOutput;
  end;
//#UC END# *4D00C9410153_4D00D88F0282_impl*
end;//TPreviewWithLinesTestBefore235875079.CloseLinesLog

function TPreviewWithLinesTestBefore235875079.GetPrecision: Integer;
//#UC START# *4FA3D5A500A9_4D00D88F0282_var*
//#UC END# *4FA3D5A500A9_4D00D88F0282_var*
begin
//#UC START# *4FA3D5A500A9_4D00D88F0282_impl*
 Result := 100;
//#UC END# *4FA3D5A500A9_4D00D88F0282_impl*
end;//TPreviewWithLinesTestBefore235875079.GetPrecision

procedure TPreviewWithLinesTestBefore235875079.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4D00D88F0282_var*
//#UC END# *4BE419AF0217_4D00D88F0282_var*
begin
//#UC START# *4BE419AF0217_4D00D88F0282_impl*
 Tl3FrameLinesSpy.Instance.SetLogger(Self, True);
 try
  inherited;
 finally
  Tl3FrameLinesSpy.Instance.RemoveLogger(Self);
 end;
//#UC END# *4BE419AF0217_4D00D88F0282_impl*
end;//TPreviewWithLinesTestBefore235875079.DoVisit

function TPreviewWithLinesTestBefore235875079.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TPreviewWithLinesTestBefore235875079.GetFolder

function TPreviewWithLinesTestBefore235875079.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D00D88F0282';
end;//TPreviewWithLinesTestBefore235875079.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.