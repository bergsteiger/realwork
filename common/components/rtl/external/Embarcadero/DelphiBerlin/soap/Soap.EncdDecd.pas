{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Soap.EncdDecd;

interface

uses System.Classes, System.SysUtils;

procedure EncodeStream(Input, Output: TStream); inline; // deprecated 'Use TNetEncoding.Base64.Encode';
procedure DecodeStream(Input, Output: TStream); inline; // deprecated 'Use TNetEncoding.Base64.Decode';
function  EncodeString(const Input: string): string; inline; // deprecated 'Use TNetEncoding.Base64.Encode';
function  DecodeString(const Input: string): string; inline; // deprecated 'Use TNetEncoding.Base64.Decode';

{$IFDEF NEXTGEN}
function  DecodeBase64(const Input: string): TBytes; inline; // deprecated 'Use TNetEncoding.Base64.DecodeStringToBytes';
function  EncodeBase64(const Input: Pointer; Size: Integer): string; inline; // deprecated 'Use TNetEncoding.Base64.EncodeBytesToString';
{$ELSE !NEXTGEN}
function  DecodeBase64(const Input: AnsiString): TBytes; inline; // deprecated 'Use TNetEncoding.Base64.DecodeStringToBytes';
function  EncodeBase64(const Input: Pointer; Size: Integer): AnsiString; inline; // deprecated 'Use TNetEncoding.Base64.EncodeBytesToString';
{$ENDIF NEXTGEN}

implementation

uses System.NetEncoding;

procedure EncodeStream(Input, Output: TStream);
begin
  TNetEncoding.Base64.Encode(Input, Output);
end;

procedure DecodeStream(Input, Output: TStream);
begin
  TNetEncoding.Base64.Decode(Input, Output);
end;

function EncodeString(const Input: string): string;
begin
  Result := TNetEncoding.Base64.Encode(Input);
end;

function DecodeString(const Input: string): string;
begin
  Result := TNetEncoding.Base64.Decode(Input);
end;

{$IFDEF NEXTGEN}
function DecodeBase64(const Input: string): TBytes;
begin
  Result := TNetEncoding.Base64.DecodeStringToBytes(Input);
end;

function EncodeBase64(const Input: Pointer; Size: Integer): string;
begin
 Result := TNetEncoding.Base64.EncodeBytesToString(Input, Size);
end;
{$ELSE !NEXTGEN}
function DecodeBase64(const Input: AnsiString): TBytes;
begin
  Result := TNetEncoding.Base64.DecodeStringToBytes(string(Input));
end;

function EncodeBase64(const Input: Pointer; Size: Integer): AnsiString;
begin
  Result := AnsiString(TNetEncoding.Base64.EncodeBytesToString(Input, Size));
end;
{$ENDIF NEXTGEN}

end.
