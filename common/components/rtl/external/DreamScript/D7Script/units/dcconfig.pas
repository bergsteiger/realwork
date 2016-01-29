{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcconfig;
{.$I dc.inc}
{$I dcprod.inc}

{$IFDEF D3}
{ Uncomment this define if you don't want to compile registration of
  VCL components with your application}
//{$DEFINE LIGHTVERSION}
{$ENDIF}

interface

uses
  dcsystem,sysutils,dialogs,dcAppRes,dcreg

 {$IFDEF DREAMTREE}
 {$IFDEF CSDELPHI}
   {$IFDEF D3}
   ,csdelphi
   {$ENDIF}
 {$ENDIF}
 {$ENDIF}

{$IFNDEF LIGHTVERSION}
{$IFDEF QREP}
  ,vclqrreg // register quick report components
{$ENDIF}
{$IFDEF PRODELPHI}
  ,vcldbreg // register db-aware components
{$ENDIF}
  ,vclstdreg // register standard components
{$ENDIF}
;

implementation

initialization
(* Don't uncomment
 {$IFNDEF LIGHTVERSION}
   if CompiledWithPackages then
     ShowMessage('You compiled application with packages.'#13#10+
            'Please uncomment define "WITHPACKAGES" in dcconfig.pas');
 {$ELSE}
   if not CompiledWithPackages then
     ShowMessage('You compiled application without packages.'#13#10+
            'Please comment out define "WITHPACKAGES" in dcconfig.pas');
 {$ENDIF}
*)
end.
