{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{                Static Midas Library                   }
{*******************************************************}

unit MidasLib;

interface

implementation

uses Winapi.Windows, Winapi.ActiveX, Datasnap.DSIntf, System.Win.Crtl;

function DllGetDataSnapClassObject(const CLSID, IID: TGUID; var Obj): HResult; stdcall; external;

{$L midas.obj}
{$L bcd.obj}
{$IFDEF CPUX86}
{$R midas.res}
{$L cpprtl.obj}
{$ELSE}
{$R midas64.res}
{$ENDIF CPUX86}

initialization
  RegisterMidasLib(@DllGetDataSnapClassObject);
finalization
end.
