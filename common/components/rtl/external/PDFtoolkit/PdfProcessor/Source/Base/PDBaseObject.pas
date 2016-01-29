{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDBaseObject;

interface

uses
  Classes, gtObject, Stream;

type
  (**
   * This enumeration defines all types of PDF objects
   *)
  TgtPDObjTypes =
    (
    otBoolean,
    otInteger,
    otReal,
    otString,
    otName,
    otCommand,

    otNull,
    otEOF,
    otError,

    otArray,
    otDict,
    otIndirectRef,
    otStream,

    otNone
    );

  TgtPDBaseObject = class;

  TgtEnumObjectsEvent = procedure(Value: TgtPDBaseObject;
    var Continue: Boolean) of object;

  TgtPDBaseObjects = array of TgtPDBaseObject;

  (**
   *  TgtPDBaseObject
   *    This is the base class for all PDF objects.
   *)

  TgtPDBaseObject = class(TgtObject)
  private
    function GetObjNumber: Cardinal;
    function GetGenNumber: Cardinal;

    procedure SetGenNumber(Value: Cardinal);
    procedure SetObjNumber(Value: Cardinal);
  protected
    FObjNumber: Cardinal;
    FGenNumber: Cardinal;
    FIsWritten: Boolean;
    FIsChanged: Boolean;
  public
    destructor Destroy; override;

   //Type Checking for simple objects
    function IsBoolean: Boolean; virtual;
    function IsInteger: Boolean; virtual;
    function IsReal: Boolean; virtual;
    function IsNumber: Boolean;
    function IsString: Boolean; virtual;
    function IsName: Boolean; overload; virtual;
    function IsNull: Boolean; virtual;

   //Type checking for complex functions
    function IsArray: Boolean; virtual;
    function IsDict: Boolean; overload; virtual;
    function IsStream: Boolean; virtual;
    function IsIndirectRef: Boolean; virtual;

   //Type checking for special objects
    function IsCommand: Boolean; overload; virtual;
    function IsError: Boolean; virtual;
    function IsEOF: Boolean; virtual;

   //Special type checking
    function IsName(const AName: AnsiString): Boolean; overload; virtual;
    function IsCommand(const ACommand: AnsiString): Boolean; overload; virtual;
    function IsDict(const ADictType: AnsiString): Boolean; overload; virtual;

   //Returns a Copy of the object
    function Clone: TgtPDBaseObject; virtual; abstract;

    //Returns a Copy of the object                                 
    procedure Assign(ASourceObj: TgtPDBaseObject); virtual;

    function GetType: TgtPDObjTypes;
    function GetTypeName: AnsiString;

    function SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
      XRef: TgtObject): Cardinal; virtual;

    property GenNumber: Cardinal read GetGenNumber write SetGenNumber;
    property ObjNumber: Cardinal read GetObjNumber write SetObjNumber;
    property IsChanged: Boolean read FIsChanged write FIsChanged;
    property IsWritten: Boolean read FIsWritten write FIsWritten;
  end;

const
  TgtPDObjTypeNames: array[TgtPDObjTypes] of AnsiString = ('boolean', 'integer',
    'real', 'AnsiString', 'name', 'command', 'null', 'eof', 'error', 'array',
    'dict', 'indirect ref', 'stream', 'none');

implementation

{ TgtPDBaseObject }


  (**
   * Destructor
   *)

procedure TgtPDBaseObject.Assign(ASourceObj: TgtPDBaseObject);
begin
  FObjNumber := ASourceObj.ObjNumber;
  FGenNumber := ASourceObj.GenNumber;
end;

destructor TgtPDBaseObject.Destroy;
begin

  inherited;
end;

  (**
   * Gets the Type of the object it holds currently
   *
   * @return TgtPDObjTypes is the type of the object (integer, Dictionary etc..)
   *)

function TgtPDBaseObject.GetGenNumber: Cardinal;
begin
  Result := FGenNumber;
end;

function TgtPDBaseObject.GetObjNumber: Cardinal;
begin
  Result := FObjNumber;
end;

function TgtPDBaseObject.GetType: TgtPDObjTypes;
begin
  if IsBoolean then
    Result := otBoolean
  else if IsInteger then
    Result := otInteger
  else if IsReal then
    Result := otReal
  else if IsString then
    Result := otString
  else if IsName then
    Result := otName
  else if IsNull then
    Result := otNull
  else if IsArray then
    Result := otArray
  else if IsDict then
    Result := otDict
  else if IsStream then
    Result := otStream
  else if IsIndirectRef then
    Result := otIndirectRef
  else if IsCommand then
    Result := otCommand
  else if IsError then
    Result := otError
  else if IsEOF then
    Result := otEOF
  else Result := otNone;
end;

function TgtPDBaseObject.GetTypeName: AnsiString;
begin
  Result := TgtPDObjTypeNames[GetType];
end;

(**
   * True if the object is an array
   *
   * @return True if the Object is Array Object
   *)

function TgtPDBaseObject.IsArray: Boolean;
begin
  Result := False;
end;

  (**
   * True if the object is a boolean
   *
   * @return True if the Object is Boolean Object
   *)

function TgtPDBaseObject.IsBoolean: Boolean;
begin
  Result := False;
end;

  (**
   * True if the object is a Command
   *
   * @return True if the Object is Command Object
   *)

function TgtPDBaseObject.IsCommand: Boolean;
begin
  Result := False;
end;

  (**
   * True if the parameter passed is a Command object
   *
   * @param ACommand is the command object that need to be checked
   *
   * @return True if the ACommand is Command Object
   *)

function TgtPDBaseObject.IsCommand(const ACommand: AnsiString): Boolean;
begin
  Result := False;
end;

  (**
   * True if the object passed is a Dictionary
   *
   * @param ADictType is the object that need to be checked
   *
   * @return True if the Object passed is Dictionary Object
   *)

function TgtPDBaseObject.IsDict(const ADictType: AnsiString): Boolean;
begin
  Result := False;
end;

  (**
   * True if the object is a Dictionary
   *
   * @return True if the Object is Dictionary Object
   *)

function TgtPDBaseObject.IsDict: Boolean;
begin
  Result := False;
end;

  (**
   * True if the object is End of Line
   *
   * @return True if the Object is EOF Object
   *)

function TgtPDBaseObject.IsEOF: Boolean;
begin
  Result := False;
end;

  (**
   * True if the object is an Error
   *
   * @return True if the Object is Error Object
   *)

function TgtPDBaseObject.IsError: Boolean;
begin
  Result := False;
end;

  (**
   * True if the object is an Indirect Reference
   *
   * @return True if the Object is Indirect Reference Object
   *)

function TgtPDBaseObject.IsIndirectRef: Boolean;
begin
  Result := False;
end;

  (**
   * True if the object is an Integer
   *
   * @return True if the Object is Integer Object
   *)

function TgtPDBaseObject.IsInteger: Boolean;
begin
  Result := False;
end;

  (**
   * True if the parameter passed is a Name
   *
   * @param AName is the object that need to be checked
   *
   * @return True if the Object passed is Name Object
   *)

function TgtPDBaseObject.IsName(const AName: AnsiString): Boolean;
begin
  Result := False;
end;

  (**
   * True if the object is a Name
   *
   * @return True if the Object is Name Object
   *)

function TgtPDBaseObject.IsName: Boolean;
begin
  Result := False;
end;

  (**
   * True if the object is a Null
   *
   * @return True if the Object is Null Object
   *)

function TgtPDBaseObject.IsNull: Boolean;
begin
  Result := False;
end;

  (**
   * True if the object is a Number
   *
   * @return True if the Object is Number Object
   *)

function TgtPDBaseObject.IsNumber: Boolean;
begin
  Result := IsInteger or IsReal;
end;

  (**
   * True if the object is a Real
   *
   * @return True if the Object is Real Object
   *)

function TgtPDBaseObject.IsReal: Boolean;
begin
  Result := False;
end;

  (**
   * True if the object is a Stream
   *
   * @return True if the Object is Stream Object
   *)

function TgtPDBaseObject.IsStream: Boolean;
begin
  Result := False;
end;

  (**
   * True if the object is an AnsiString
   *
   * @return True if the Object is AnsiString Object
   *)

function TgtPDBaseObject.IsString: Boolean;
begin
  Result := False;
end;

  (**
   * This function will writes the corresponding object into the stream provided
   *
   * @param Stream is the stream where the object need to be written into
   * @param OnlyChanged is the flag that determines if the object is changed
   * @param XRef is the Xreference table of this object
   *
   * @return Count bytes written into the Stream
   *)

function TgtPDBaseObject.SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
  XRef: TgtObject): Cardinal;
begin
  //Error
  Result := 0;
end;

  (**
   * Sets the Generation Number of the Object
   *
   * @param Value is the Generation number that need  to be set for this object
   *)

procedure TgtPDBaseObject.SetGenNumber(Value: Cardinal);
begin
  FGenNumber := Value;
end;

  (**
   * Sets the Object Number of the Object
   *
   * @param Value is the Object number that need  to be set for this object
   *)

procedure TgtPDBaseObject.SetObjNumber(Value: Cardinal);
begin
  FObjNumber := Value;
end;

end.
