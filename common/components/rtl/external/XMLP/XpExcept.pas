{*********************************************************}
{* XMLPartner: XpExcept.PAS 2.56                         *}
{* Copyright (c) TurboPower Software Co 2002             *}
{* All rights reserved.                                  *}
{*********************************************************}
{* XMLPartner: XMLPartner's exception classes            *}
{*********************************************************}

{$I XpDefine.inc}

unit XpExcept;

interface

uses
  SysUtils,
  XpBase;

{Include error strings}
{$I XpExcept.inc}

type
  EXpException = class(Exception);

  EXpStreamError = class(EXpException)
  private
    seFilePos : Longint;
  public
    constructor CreateError(const FilePos : Longint;
                            const Reason  : DOMString);

    property FilePos : Longint
       read seFilePos;
  end;

  EXpFilterError = class(EXpStreamError)
  private
    feReason  : DOMString;
    feLine    : Longint;
    feLinePos : Longint;
  public
    constructor CreateError(const FilePos, Line, LinePos : Longint;
                            const Reason : DOMString);

    property Reason : DOMString
       read feReason;
    property Line : Longint
       read feLine;
    property LinePos : Longint
       read feLinePos;
  end;

  EXpParserError = class(EXpFilterError)
  protected
    peURL : DOMString;
  public
    constructor CreateError({const FilePos,} Line, LinePos : Longint;
                            const Url, Reason : DOMString);

    property URL : DOMString
       read peURL;
  end;

implementation

constructor EXpStreamError.CreateError(const FilePos : Longint;
                                       const Reason  : DOMString);
begin
  inherited Create(Reason);

  seFilePos := FilePos;
end;
{******************************************************************************}
constructor EXpFilterError.CreateError(const FilePos,
                                             Line,
                                             LinePos : Longint;
                                       const Reason  : DOMString);
begin
  inherited CreateError(FilePos, Reason);

  feLine := Line;
  feLinePos := LinePos;
  feReason := Reason;
end;
{******************************************************************************}
constructor EXpParserError.CreateError(Line,
                                       LinePos : Longint;
                                 const Url,
                                       Reason  : DOMString);
begin
  inherited CreateError(FilePos, Line, LinePos, Reason);
  peUrl := Url;
end;

end.
