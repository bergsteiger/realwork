{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXMetaDataUtil;

interface

type
  TDBXMetaDataUtil = class
  public
    class function QuoteIdentifier(const UnquotedIdentifier: string; const QuoteChar: string; const QuotePrefix: string; const QuoteSuffix: string): string; static;
    class function UnquotedIdentifier(const QuotedIdentifier: string; const QuoteChar: string; const QuotePrefix: string; const QuoteSuffix: string): string; static;
  end;

implementation

uses
  Data.DBXPlatform,
  System.StrUtils,
  System.SysUtils;

class function TDBXMetaDataUtil.QuoteIdentifier(const UnquotedIdentifier: string; const QuoteChar: string; const QuotePrefix: string; const QuoteSuffix: string): string;
var
  Buffer: TStringBuilder;
  From, Index: Integer;
  QuotedIdentifier: string;
begin
  Buffer := TStringBuilder.Create;
  try
    Index := UnquotedIdentifier.IndexOf(QuoteSuffix);
    if (Index < 0) or (QuoteSuffix.Length = 0) then
    begin
      Buffer.Append(QuotePrefix);
      Buffer.Append(UnquotedIdentifier);
      Buffer.Append(QuoteSuffix);
    end
    else
    begin
      Buffer.Append(QuoteChar);
      From := 0;
      Index := UnquotedIdentifier.IndexOf(QuoteChar);
      if QuoteChar.Length > 0 then
        while Index >= 0 do
        begin
          IncrAfter(Index);
          Buffer.Append(UnquotedIdentifier.Substring(From, Index - From));
          Buffer.Append(QuoteChar);
          From := Index;
          Index := UnquotedIdentifier.IndexOf(QuoteChar, From);
        end;
      Buffer.Append(UnquotedIdentifier.Substring(From, UnquotedIdentifier.Length - From));
      Buffer.Append(QuoteChar);
    end;
    QuotedIdentifier := Buffer.ToString;
    Result := QuotedIdentifier;
  finally
    Buffer.Free;
  end;
end;

class function TDBXMetaDataUtil.UnquotedIdentifier(const QuotedIdentifier: string; const QuoteChar: string; const QuotePrefix: string; const QuoteSuffix: string): string;
var
  DoubleEndQuote, Identifier: string;
  From, Index: Integer;
  Buffer: TStringBuilder;
begin
  Identifier := QuotedIdentifier;
  if Identifier.StartsWith(QuotePrefix) and Identifier.EndsWith(QuoteSuffix) then
    Identifier := Identifier.Substring(QuotePrefix.Length, Identifier.Length - QuoteSuffix.Length - QuotePrefix.Length)
  else if Identifier.StartsWith(QuoteChar) and Identifier.EndsWith(QuoteChar) then
  begin
    Identifier := Identifier.Substring(QuotePrefix.Length, Identifier.Length - QuoteSuffix.Length - QuotePrefix.Length);
    DoubleEndQuote := QuoteChar + QuoteChar;
    Index := Identifier.IndexOf(DoubleEndQuote);
    if Index >= 0 then
    begin
      Buffer := TStringBuilder.Create;
      try
        From := 0;
        while Index >= 0 do
        begin
          Buffer.Append(Identifier.Substring(From, Index - From));
          Buffer.Append(QuoteChar);
          From := Index + DoubleEndQuote.Length;
          Index := Identifier.IndexOf(DoubleEndQuote,From);
        end;
        Buffer.Append(Identifier.Substring(From, Identifier.Length - From));
        Identifier := Buffer.ToString;
      finally
        Buffer.Free;
      end;
    end;
  end;
  Result := Identifier;
end;

end.
