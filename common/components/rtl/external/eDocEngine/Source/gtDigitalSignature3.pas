{ *************************************************************************** }
{ }
{ Gnostice eDocEngine }
{ }
{ Copyright © 2002-2011 Gnostice Information Technologies Private Limited }
{ http://www.gnostice.com }
{ }
{ *************************************************************************** }

{ ------------------------------------ }
{ Editor Options }
{ ------------------------------------ }
{ }
{ Tab Stops = 2 }
{ Use Tab Character = True }
{ }
{ ------------------------------------ }
unit gtDigitalSignature3;

interface

uses
 gtEnvelope3, gtJwaWinCrypt3;

type

  TgtDigitalIntf = class(TObject)
    private
      FPKCS7: TgtPKCS7;
      FCertContext: PCertContext;
    protected
    public
      constructor Creccate;
      destructor Destroy; override;
      property PKCS7: TgtPKCS7 read FPKCS7 write FPKCS7;
      property CertContext: PCertContext read FCertContext write FCertContext;

  end;

implementation
constructor TgtDigitalIntf.Creccate;
begin
  PKCS7 := TgtPKCS7.Create;
end;
destructor TgtDigitalIntf.Destroy;
begin
  PKCS7.Free;
inherited;
end;
{$EXTERNALSYM TgtDigitalIntf}
end.
