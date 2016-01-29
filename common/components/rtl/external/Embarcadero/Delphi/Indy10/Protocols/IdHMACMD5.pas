{
  $Project$
  $Workfile$
  $Revision: 1.2 $
  $DateUTC$
  $Id: IdHMACMD5.pas,v 1.2 2013/05/24 13:30:16 lulin Exp $

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log: IdHMACMD5.pas,v $
  Revision 1.2  2013/05/24 13:30:16  lulin
  - �������� ��������� XE4.

}
{
  HMAC specification on the NIST website
  http://csrc.nist.gov/publications/fips/fips198/fips-198a.pdf
}

unit IdHMACMD5;

interface

{$i IdCompilerDefines.inc}

uses
  IdFIPS,
  IdGlobal,
  IdHash, IdHashMessageDigest, IdHMAC;

type
  TIdHMACMD5 = class(TIdHMAC)
  protected
    procedure SetHashVars; override;
    function IsIntFAvail : Boolean; override;
    function InitIntFInst(const AKey : TIdBytes) : TIdHMACIntCtx; override;
    procedure InitHash; override;
  end;

implementation

{ TIdHMACMD5 }

procedure TIdHMACMD5.InitHash;
begin
  FHash := TIdHashMessageDigest5.Create;
end;

function TIdHMACMD5.InitIntFInst(const AKey: TIdBytes): TIdHMACIntCtx;
begin
  Result := GetHMACMD5HashInst(AKey);
end;

function TIdHMACMD5.IsIntFAvail: Boolean;
begin
  Result := inherited IsIntFAvail and IsHMACMD5Avail;
end;

procedure TIdHMACMD5.SetHashVars;
begin
  FHashName := 'MD5';
  FHashSize := 16;
  FBlockSize := 64;
end;

end.
