program mdpSyncPrj;

uses
  Forms,
  alcuMDP in '..\Process\alcuMDP.pas',
  alcuUtils in '..\Server\alcuUtils.pas',
  alcuCommands in '..\alcuCommands.pas',
  alcuMailServer in '..\Server\alcuMailServer.pas',
  alcuTypes in '..\Core\alcuTypes.pas',
  alcuStrings in '..\Core\alcuStrings.pas',
  alcuZipUtils in '..\Process\alcuZipUtils.pas',
  GarDocsUnit in 'W:\MDProcess\ArchiAdapterLib\GarDocsUnit.pas',
  ArchiAdapter in 'W:\MDProcess\ArchiAdapter\ArchiAdapter.pas',
  mdpSyncMainForm in 'mdpSyncMainForm.pas' {MDPSyncForm},

  JwaWinBase in 'W:\common\components\rtl\external\JEDI\Win32API\JwaWinBase.pas',
  JwaNtStatus in 'W:\common\components\rtl\external\JEDI\Win32API\JwaNtStatus.pas',
  JwaWinNT in 'W:\common\components\rtl\external\JEDI\Win32API\JwaWinNT.pas',
  JwaWinType in 'W:\common\components\rtl\external\JEDI\Win32API\JwaWinType.pas'
  ;

{$R *.res}
{$R versioninfo.res}

begin
  Application.Initialize;
  Application.Title := 'Синхронизация с MDP. Архивариус';
  Application.CreateForm(TMDPSyncForm, MDPSyncForm);
  Application.Run;
end.
