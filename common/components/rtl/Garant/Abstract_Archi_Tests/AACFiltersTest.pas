unit AACFiltersTest;
 {* [Requestlink:294595323] }

// Модуль: "w:\common\components\rtl\Garant\Abstract_Archi_Tests\AACFiltersTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "AACFiltersTest" MUID: (4EA5222A020E)
// Имя типа: "TAACFiltersTest"

{$Include w:\common\components\rtl\Garant\Abstract_Archi_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TAACFiltersTest = {abstract} class({$If NOT Defined(NotTunedDUnit)}
 TBaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 )
  {* [Requestlink:294595323] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure DoIt;
 end;//TAACFiltersTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evEvdWriter
 , k2TagGen
 , dd_lcTextFormatter
 , dd_lcSectionEliminator
 , ddSpaceTrimmer
 , dd_lcTableEliminator
 , evEvdReader
 , dd_lcPageNumberEliminator
 , dd_lcVASCodeCorrector
 , dd_lcYearCodeCorrector
 , dd_lcTypeConverter
 , dd_lcSourceConverter
 , TextPara_Const
 , SysUtils
 , dd_lcVASSourceCorrector
 , dd_lcResolutionFormatter
 , dd_lcJudgeFormatter
 , dd_lcDateNumberFormatter
 , dd_lcCityNameFormatter
 , dd_lcTitleFormatter
 , dd_lcStartDocFormatter
 , dd_lcTextStyleCorrector
 , dd_lcTextSplitter
 , TestFrameWork
;

{$If NOT Defined(NotTunedDUnit)}
procedure TAACFiltersTest.DoIt;
//#UC START# *4EA570A1013B_4EA5222A020E_var*
var
 l_Gen              : Tk2TagGenerator;
 l_R                : Tdd_lcResolutionFormatter;
 l_J                : Tdd_lcJudgeFormatter;
 l_Folder           : String;
 l_InName           : String;
 l_OutName          : String;
 l_DisableParserLog : Boolean;
//#UC END# *4EA570A1013B_4EA5222A020E_var*
begin
//#UC START# *4EA570A1013B_4EA5222A020E_impl*
 l_Gen := nil;
 try
  l_Folder := DataSubFolder + '\';
  l_InName := FileFromCurrent(l_Folder + KPage, FolderMode);
  l_OutName := FileForOutput;
  TevEvdStorageWriter.SetTo(l_Gen, l_OutName);
  
  Tdd_lcJudgeFormatter.SetTo(l_Gen);
  l_J:= Tdd_lcJudgeFormatter(l_Gen);
  Tdd_lcResolutionFormatter.SetTo(l_Gen);
  l_R:= Tdd_lcResolutionFormatter(l_Gen);
  Tdd_lcDateNumberFormatter.SetTo(l_Gen);
  Tdd_lcCityFormatter.SetTo(l_Gen);
  l_R.AddBodyStartNotifier(Tdd_lcCityFormatter(l_Gen));
  Tdd_lcTitleFormatter.SetTo(l_Gen);
  Tdd_lcStartDocFormatter.SetTo(l_Gen);
  Tdd_lcTextStyleCorrector.SetTo(l_Gen);
  TlcTableEliminator2.SetTo(l_Gen);
  l_R.AddBodyStartNotifier(TlcTableEliminator2(l_Gen));
  l_J.AddBodyFinishNotifier(TlcTableEliminator2(l_Gen));
  Tdd_lcSectionEliminator.SetTo(l_Gen);
  TddSpaceTrimmerFilter.SetTo(l_Gen);
  Tdd_lcTextSplitter.SetTo(l_Gen, #10);
  l_R.AddBodyStartNotifier(Tdd_lcTextSplitter(l_Gen));
  Tdd_lcPageNumberEliminator.SetTo(l_Gen, k2_idTextPara);
  Tdd_lcVASCodeCorrector.SetTo(l_Gen);
  Tdd_lcYearCodeCorrector.SetTo(l_Gen);
  Tdd_lcTypeConverter2.SetTo(l_Gen);
  Tdd_lcTypeConverter2(l_Gen).LoadSources(FileFromCurrent(l_Folder + 'lcSourceConvertFile.dat', FolderMode));
  Tdd_lcSourceConverterFilter.SetTo(l_Gen, FileFromCurrent(l_Folder + 'lcSourceFile.dat', FolderMode));
  Tdd_lcTypeConverter.SetTo(l_Gen, FileFromCurrent(l_Folder + 'lcTypeSyno.dat', FolderMode));
  Tdd_lcVASSourceCorrector.SetTo(l_Gen);
  
  TevEvdStorageReader.SetTo(l_Gen, l_InName);
  TevEvdStorageReader(l_Gen).Execute;  
  CheckOutputWithInput(ChangeFileExt(l_InName, EtalonSuffix + '.evd'), '%');
 finally
  FreeAndNil(l_Gen);
 end;
//#UC END# *4EA570A1013B_4EA5222A020E_impl*
end;//TAACFiltersTest.DoIt

function TAACFiltersTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Filters';
end;//TAACFiltersTest.GetFolder

function TAACFiltersTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4EA5222A020E';
end;//TAACFiltersTest.GetModelElementGUID
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
