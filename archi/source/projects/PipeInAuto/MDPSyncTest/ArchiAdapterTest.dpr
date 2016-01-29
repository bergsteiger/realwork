program ArchiAdapterTest;

uses
  Forms,
  WIndows,
  Main in 'Main.pas' {Form2},
  ArchiAdapter in '..\..\..\..\..\MDProcess\ArchiAdapter\ArchiAdapter.pas',
  GardocsUnit in '..\..\..\..\..\MDProcess\ArchiAdapterLib\GardocsUnit.pas',
  IOUnit in '..\..\..\..\..\shared\GCI\IOUnit.pas';

{$R *.res}

begin
  SetErrorMode(SEM_FAILCRITICALERRORS or SEM_NOALIGNMENTFAULTEXCEPT or SEM_NOGPFAULTERRORBOX or SEM_NOOPENFILEERRORBOX);
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
