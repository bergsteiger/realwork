{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDCommand;

interface

uses
  PDBaseObject, Stream;

type
  (**
   *  TgtPDCommand
   *    This class represents the PDF Command object of a PDF document
   *)
  TgtPDCommand = class(TgtPDBaseObject)
  private
    FValue: AnsiString;
  public
    constructor Create(AValue: AnsiString);
    function IsCommand: Boolean; overload; override;
    function IsCommand(const ACommand: AnsiString): Boolean; overload; override;
    function Clone: TgtPDBaseObject; override;

    procedure Assign(ASourceObj: TgtPDBaseObject); override;

    function Value: AnsiString;
  end;

implementation

{$IFNDEF DOTNET}uses SysUtils{$ENDIF};

{ TgtPDCommand }

  (**
   * Creates an Command object with a different copy from the Source document
   *
   * @param ASourceObj is the source document from where the current
   *         object need to be created
   *)

procedure TgtPDCommand.Assign(ASourceObj: TgtPDBaseObject);
begin
  inherited;

end;

  (**
   * Gets a copy of the current object
   * @return Copy of current object(Command)
   *)

function TgtPDCommand.Clone: TgtPDBaseObject;
begin
  Result := TgtPDCommand.Create(FValue);
end;

  (**
   * Constructor
   * @param AValue is the command with which this object has to be created
   *)

constructor TgtPDCommand.Create(AValue: AnsiString);
begin
  FValue := AValue;
  FIsChanged := False;
end;

  (**
   * True if the object is Command
   * @return True if the object is Command Object
   *)

function TgtPDCommand.IsCommand: Boolean;
begin
  Result := True;
end;

  (**
   * True if the parameter passed(ACommand) is Command
   * @return True if the object passed is Command Object
   *)

function TgtPDCommand.IsCommand(const ACommand: AnsiString): Boolean;
begin
  Result := False;
{$IFDEF DOTNET}
  if (System.AnsiString.Compare(ACommand, FValue, True) = 0) then
    Result := True
{$ELSE}
  if (CompareStr(ACommand, FValue) = 0) then
    Result := True
{$ENDIF}
end;

  (**
   * Gets the value of this object (Command it represents)
   * @return AnsiString(Command) value of this object
   *)

function TgtPDCommand.Value: AnsiString;
begin
  Result := FValue;
end;

end.
