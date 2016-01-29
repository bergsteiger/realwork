// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit ssl_int;

interface

uses
  orbtypes,Classes,addr_int,code_int,iior_int,SysUtils,comp_int;

{$I dorb.inc}
  
type
  (*
   * The security spec says that AssociationOptions is
   * unsigned short, but Visibroker defines it as unsigned long.
   * I dont know whether this is a bug in VB or whether the
   * spec changed the definition (perhaps it was an enum before?).
   * For compatibility with VB we use unsigned long as well...
   *)
{$IFDEF MTDORB_SSL_VB_COMPAT}
  AssociationOptions = _ulong;
{$ELSE}
  AssociationOptions = _ushort;
{$ENDIF}

  ISSLPrincipal = interface(IPrincipal)
  ['{8CC321AD-F495-4E83-A021-B7F1B156348D}']
  end;

  ISSLAddress = interface(IAddress)
  ['{2E4F1484-B85B-493F-989B-B407BD74FB37}']
    function content(): IAddress;
    procedure set_content(const addr: IAddress);
  end;

  ISSLProfile = interface(IIORProfile)
  ['{88B0C476-9A0A-4409-9C81-95152D75A1EA}']
    function IORProfile(): IIORProfile;
  end;

  ISSLComponent = interface(IORBComponent)
  ['{5E0175FC-24F4-452D-B01C-96E2349DAF07}']
    function port(): _ushort;
  end;

  ISSLTransport = interface(ITransport)
  ['{DC73C39D-25CB-4A52-9AC9-6969830010A5}']
    function accept(): boolean;
  end;

implementation
end.
