program FormatTest;

uses
  Forms,
  FormatTestForm in 'FormatTestForm.pas' {Form1},
  ViewForm in 'ViewForm.pas' {CompareViewForm},
  dd_lcDateNumberFormatter,
  dd_lcStartDocFormatter,
  dd_lcTitleFormatter,
  dd_lcTextStyleCorrector,
  dd_lcJudgeFormatter,
  dd_lcResolutionFormatter,
  dd_lcCityNameFormatter,
  dd_lcTextSplitter,
  afSourceDetector,
  afTitleCollector,
  afStyleReplacer,
  afDocumentCleaner,
  afSignFormatter,
  afTextNormalizer,
  afEmptyParaEliminator in '..\..\..\..\..\common\components\rtl\Garant\dd\AutoFormat\afEmptyParaEliminator.pas',
  afAppendixFormatter in '..\..\..\..\..\common\components\rtl\Garant\dd\AutoFormat\afAppendixFormatter.pas',
  afTextReplacer in '..\..\..\..\..\common\components\rtl\Garant\dd\AutoFormat\afTextReplacer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Проверка форматирования текстов';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
