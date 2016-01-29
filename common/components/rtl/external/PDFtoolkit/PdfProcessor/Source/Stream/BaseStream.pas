{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit BaseStream;

interface

uses
  Classes, Stream;

type

(**
 * Base class for File stream
 *)
  TgtBaseStream = class(TgtStream)
  public
    function MakeSubStream(AStart: Longint; ALength: Longint;
      ALimited: Boolean): TgtStream; virtual; abstract;
    function GetBaseStream: TgtStream; override;
    function GetUndecodedStream: TgtStream; override;

    //TgtBaseStream
    function GetStart: Longint; virtual; abstract;
    procedure MoveStart(Delta: Int64); virtual; abstract;
  end;

implementation

{ TgtBaseStream }

function TgtBaseStream.GetBaseStream: TgtStream;
begin
  Result := Self;
end;

function TgtBaseStream.GetUndecodedStream: TgtStream;
begin
  Result := Self;
end;

end.
