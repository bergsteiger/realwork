program LayeredForm_demo;

uses
  Forms,
  LayeredFormDemo in 'LayeredFormDemo.pas' {MainForm},
  LayeredForm in 'LayeredForm.pas',
  vcmMainForm in 'W:\common\components\gui\Garant\VCM\implementation\Visual\vcmMainForm.pas',
  vcmModule in 'W:\common\components\gui\Garant\VCM\implementation\vcmModule.pas',
  DataModule in 'DataModule.pas' {moDocument: TDataModule},
  vcmEntityForm in 'W:\common\components\gui\Garant\VCM\implementation\Visual\vcmEntityForm.pas',
  MyEntity in 'MyEntity.pas' {MyEntityForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
