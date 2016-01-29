unit nsIntegrationInterface;

interface

uses
 Windows;

{$INCLUDE 'nsIntergationConstants.inc'}

function IsGarantInstalled: integer; stdcall;

function GarantProcessCommand(aCommand: DWORD; OpenInNewWindow: Bool;
 aTimeOut: DWORD):integer; stdcall;

function GarantDemoProcessCommand(aPath: PChar; anIntegrationKey: PChar;
 aCommand: DWORD; OpenInNewWindow: Bool; aTimeOut: DWORD):integer; stdcall;

function GarantShowLink(aRef:PChar; OpenInNewWindow: Bool; aTimeOut: DWORD):integer; stdcall;

function GarantDemoShowLink(aPath: PChar; anIntegrationKey: PChar; aRef:PChar;
 OpenInNewWindow: Bool; aTimeOut: DWORD):integer; stdcall;

implementation

const
 c_LibName = 'F1ShellDriver.dll';

function IsGarantInstalled; external c_LibName name 'IsGarantInstalled';

function GarantProcessCommand; external c_LibName name 'GarantProcessCommand';

function GarantDemoProcessCommand; external c_LibName name 'GarantDemoProcessCommand';

function GarantShowLink; external c_LibName name 'GarantShowLink';

function GarantDemoShowLink; external c_LibName name 'GarantDemoShowLink';

end.
