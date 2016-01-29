unit ComplexScrollParams;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/ComplexScrollParams.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TComplexScrollParams
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
  TextEditorVisitor
  {$IfEnd} //nsTest AND not NoVCM
  ,
  nevVScrollerSpy,
  Types
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TComplexScrollParams = {abstract} class(TTextEditorVisitor, InevVScrollerPosLogger)
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
   {$IfEnd} //nsTest AND not NoVCM
   function OpenLog: AnsiString;
   procedure CloseLog(const aLogName: AnsiString);
 protected
 // overridden protected methods
    {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   function FileForOutput: AnsiString; override;
     {* Стандартный файл для вывода, для текщего теста }
    {$IfEnd} //nsTest AND not NotTunedDUnit
   {$If defined(nsTest) AND not defined(NoVCM)}
   function FormExtent: TPoint; override;
     {* Размеры формы }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   function GetSubNumber(aFirst: Boolean): Integer; virtual;
 end;//TComplexScrollParams
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

// start class TComplexScrollParams

function TComplexScrollParams.GetSubNumber(aFirst: Boolean): Integer;
//#UC START# *4D7779F503A4_4D7777390386_var*
//#UC END# *4D7779F503A4_4D7777390386_var*
begin
//#UC START# *4D7779F503A4_4D7777390386_impl*
 Result := 1;
//#UC END# *4D7779F503A4_4D7777390386_impl*
end;//TComplexScrollParams.GetSubNumber

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TComplexScrollParams.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4D7777390386_var*
//#UC END# *4BE419AF0217_4D7777390386_var*
begin
//#UC START# *4BE419AF0217_4D7777390386_impl*
 aForm.Text.ShowVersionComments := False;
 TnevVScrollerSpy.Instance.SetLogger(Self);
 try
  if TnevVScrollerSpy.Instance.StartLog then
  begin
   try
    with aForm.Text do
    begin
     TextSource.DocumentContainer.SubList.Sub[GetSubNumber(True)].Select(Selection);
     TextSource.DocumentContainer.SubList.Sub[GetSubNumber(False)].Select(Selection);
     TextSource.DocumentContainer.SubList.Sub[GetSubNumber(True)].Select(Selection);
    end; // with aForm.Text do
   finally
    TnevVScrollerSpy.Instance.FinishLog;
   end;
  end;
 finally
  TnevVScrollerSpy.Instance.RemoveLogger(Self);
 end;
//#UC END# *4BE419AF0217_4D7777390386_impl*
end;//TComplexScrollParams.DoVisit
{$IfEnd} //nsTest AND not NoVCM

function TComplexScrollParams.OpenLog: AnsiString;
//#UC START# *4DAEB0DE00D1_4D7777390386_var*
//#UC END# *4DAEB0DE00D1_4D7777390386_var*
begin
//#UC START# *4DAEB0DE00D1_4D7777390386_impl*
 Result := OutputPath + KPage + '.poss';
//#UC END# *4DAEB0DE00D1_4D7777390386_impl*
end;//TComplexScrollParams.OpenLog

procedure TComplexScrollParams.CloseLog(const aLogName: AnsiString);
//#UC START# *4DAEB0F30186_4D7777390386_var*
//#UC END# *4DAEB0F30186_4D7777390386_var*
begin
//#UC START# *4DAEB0F30186_4D7777390386_impl*
 CheckOutputWithInput(ChangeFileExt(ExtractFileName(aLogName), EtalonSuffix + '.poss'));
//#UC END# *4DAEB0F30186_4D7777390386_impl*
end;//TComplexScrollParams.CloseLog

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
function TComplexScrollParams.FileForOutput: AnsiString;
//#UC START# *4B4F588B0241_4D7777390386_var*
//#UC END# *4B4F588B0241_4D7777390386_var*
begin
//#UC START# *4B4F588B0241_4D7777390386_impl*
 Result := OutputPath + KPage + '.poss';
//#UC END# *4B4F588B0241_4D7777390386_impl*
end;//TComplexScrollParams.FileForOutput
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NoVCM)}
function TComplexScrollParams.FormExtent: TPoint;
//#UC START# *4C08CF700318_4D7777390386_var*
//#UC END# *4C08CF700318_4D7777390386_var*
begin
//#UC START# *4C08CF700318_4D7777390386_impl*
 Result.X := 1000;
 Result.Y := 700;
//#UC END# *4C08CF700318_4D7777390386_impl*
end;//TComplexScrollParams.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TComplexScrollParams.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TComplexScrollParams.GetFolder

function TComplexScrollParams.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D7777390386';
end;//TComplexScrollParams.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.