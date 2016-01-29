program vcmTranslationManager;

uses
  Forms,
  enLocalizationManager in 'enLocalizationManager.pas' {en_LocalizationManager},
  vcmLocalizationManager in 'vcmLocalizationManager.pas',
  enDifference in 'enDifference.pas' {en_Difference};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Ten_LocalizationManager, en_LocalizationManager);
  Application.CreateForm(Ten_Difference, en_Difference);
  Application.Run;
end.
