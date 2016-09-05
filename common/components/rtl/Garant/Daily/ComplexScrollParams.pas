unit ComplexScrollParams;

// Модуль: "w:\common\components\rtl\Garant\Daily\ComplexScrollParams.pas"
// Стереотип: "TestCase"
// Элемент модели: "TComplexScrollParams" MUID: (4D7777390386)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TextEditorVisitor
 {$IfEnd} // NOT Defined(NoVCM)
 , nevVScrollerSpy
 , Types
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TComplexScrollParams = {abstract} class({$If NOT Defined(NoVCM)}
 TTextEditorVisitor
 {$IfEnd} // NOT Defined(NoVCM)
 , InevVScrollerPosLogger)
  protected
   function GetSubNumber(aFirst: Boolean): Integer; virtual;
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   {$IfEnd} // NOT Defined(NoVCM)
   function OpenLog: AnsiString;
   procedure CloseLog(const aLogName: AnsiString);
   {$If NOT Defined(NotTunedDUnit)}
   function FileForOutput: AnsiString; override;
    {* Стандартный файл для вывода, для текщего теста }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* Размеры формы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TComplexScrollParams
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
 //#UC START# *4D7777390386impl_uses*
 //#UC END# *4D7777390386impl_uses*
;

{$If NOT Defined(NoVCM)}
function TComplexScrollParams.GetSubNumber(aFirst: Boolean): Integer;
//#UC START# *4D7779F503A4_4D7777390386_var*
//#UC END# *4D7779F503A4_4D7777390386_var*
begin
//#UC START# *4D7779F503A4_4D7777390386_impl*
 Result := 1;
//#UC END# *4D7779F503A4_4D7777390386_impl*
end;//TComplexScrollParams.GetSubNumber

procedure TComplexScrollParams.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
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

{$If NOT Defined(NotTunedDUnit)}
function TComplexScrollParams.FileForOutput: AnsiString;
 {* Стандартный файл для вывода, для текщего теста }
//#UC START# *4B4F588B0241_4D7777390386_var*
//#UC END# *4B4F588B0241_4D7777390386_var*
begin
//#UC START# *4B4F588B0241_4D7777390386_impl*
 Result := OutputPath + KPage + '.poss';
//#UC END# *4B4F588B0241_4D7777390386_impl*
end;//TComplexScrollParams.FileForOutput
{$IfEnd} // NOT Defined(NotTunedDUnit)

function TComplexScrollParams.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4D7777390386_var*
//#UC END# *4C08CF700318_4D7777390386_var*
begin
//#UC START# *4C08CF700318_4D7777390386_impl*
 Result.X := 1000;
 Result.Y := 700;
//#UC END# *4C08CF700318_4D7777390386_impl*
end;//TComplexScrollParams.FormExtent

function TComplexScrollParams.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TComplexScrollParams.GetFolder

function TComplexScrollParams.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D7777390386';
end;//TComplexScrollParams.GetModelElementGUID
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
