library F1ShellDriver;

{$Include W:\common\components\rtl\Garant\L3\l3Define.inc}
{$Undef l3UseSSE} 

uses
  ComObj,
  ComServ,
  Windows,
  //
  nsIntegration in 'nsIntegration.pas',
  LocaleMessages in '..\..\launcher\i18n\LocaleMessages.pas',
  JwaWinBase in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinBase.pas',
  JwaNtStatus in 'w:\common\components\rtl\external\JEDI\Win32API\JwaNtStatus.pas',
  JwaWinNT in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinNT.pas',
  JwaWinType in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinType.pas',
  //
  adxAddIn,
  //
  F1ShellDriver_IMPL in 'F1ShellDriver_IMPL.pas' {F1ShellAddInModule: TAddInModule} {F1Shell: CoClass},
  F1ShellDriver_TLB in 'F1ShellDriver_TLB.pas';

{$R *.res}
{$R *.tlb}

type
 TDummyComServer = class(TObject)
 private
  procedure FactoryRegister(Factory: TComObjectFactory);
  procedure FactoryUnRegister(Factory: TComObjectFactory);
 end;

procedure TDummyComServer.FactoryRegister(Factory: TComObjectFactory);
begin
 UpdateFactory(Factory, True);
end;

procedure TDummyComServer.FactoryUnRegister(Factory: TComObjectFactory);
begin
 UpdateFactory(Factory, False);
end;

function DllRegisterServer: HResult;
begin
 Result := E_FAIL;
 //
 try
  if CheckConfigSection then
  begin
   RegisterToHKCU := True;
   //
   with TDummyComServer.Create do
    try
     ComClassManager.ForEachFactory(ComServer, FactoryRegister);
    finally
     Free;
    end;
   Result := S_OK;
  end;
 except
 end;
 //
 if (Result <> S_OK) then
  Result := ComServ.DllRegisterServer;
end;

function DllUnregisterServer: HResult;
begin
 Result := E_FAIL;
 //
 try
  if CheckConfigSection then
  begin
   RegisterToHKCU := True;
   //
   with TDummyComServer.Create do
    try
     ComClassManager.ForEachFactory(ComServer, FactoryUnRegister);
    finally
     Free;
    end;
   //
   Result := S_OK;
  end;
 except
 end;
 //
 if (Result <> S_OK) then
  Result := ComServ.DllUnregisterServer;
end;

exports
 DllGetClassObject name 'DllGetClassObject',
 DllCanUnloadNow name 'DllCanUnloadNow',
 DllRegisterServer name 'DllRegisterServer',
 DllUnregisterServer name 'DllUnregisterServer',
 //
 IsGarantInstalled name 'IsGarantInstalled',
 GarantProcessCommand name 'GarantProcessCommand',
 GarantDemoProcessCommand name 'GarantDemoProcessCommand',
 GarantShowLink name 'GarantShowLink',
 GarantDemoShowLink name 'GarantDemoShowLink';

begin
end.
