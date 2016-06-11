{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

library StdVcl40;

uses
  System.Win.ComServ,
  StdMain in 'StdMain.pas',
  PicPP in 'PicPP.pas' {PicturePropPage: TPropertyPage},
  ColorPP in 'ColorPP.pas' {ColorPropPage: TPropertyPage},
  StringPP in 'StringPP.pas' {StringsPropPage: TPropertyPage},
  FontPP in 'FontPP.pas' {FontPropPage: TPropertyPage};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.RES}
{$R *.TLB}

begin
end.
