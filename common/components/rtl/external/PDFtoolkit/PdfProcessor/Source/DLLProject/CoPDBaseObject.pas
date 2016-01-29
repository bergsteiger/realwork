unit CoPDBaseObject;

interface

uses
  PDBaseObjectIntf, PDBaseObject;

type
  TgtCoPDBaseObject = class(TInterfacedObject, IgtPDBaseObject)
  private
    FBaseObject: TgtPDBaseObject;
  public
    constructor Create(ABaseObj: TgtPDBaseObject);
    function IsBoolean: WordBool; virtual;
    function IsInteger: WordBool; virtual;
    function IsReal: WordBool; virtual;
    function IsNumber: WordBool; virtual;
    function IsString: WordBool;
    function IsName: WordBool; overload;
    function IsNull: WordBool; virtual;

   //Type checking for complex functions
    function IsArray: WordBool; virtual;
    function IsDict: WordBool; overload; virtual;
    function IsStream: WordBool; virtual;
    function IsIndirectRef: WordBool; virtual;

   //Type checking for special objects
    function IsCommand: WordBool; overload; virtual;
    function IsError: WordBool; virtual;
    function IsEOF: WordBool; virtual;

   //Special type checking
    function IsName(const AName: WideString): WordBool; overload ; virtual;
    function IsCommand(const ACommand: WideString): WordBool; overload; virtual;
    function IsDict(const ADictType: WideString): WordBool; overload; virtual;

   //Returns a Copy of the object
    function Clone: IgtPDBaseObject; virtual; abstract;

    //Returns a Copy of the object
    procedure Assign(ASourceObj: IgtPDBaseObject); virtual;

    function GetType: Integer;
    function GetTypeName: WideString;

//    function SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
//      XRef: TgtObject): Cardinal; virtual;

  protected
    property BaseObject: TgtPDBaseObject read FBaseObject write FBaseObject;
  end;
implementation

{ TgtCoPDBaseObject }

procedure TgtCoPDBaseObject.Assign(ASourceObj: IgtPDBaseObject);
begin
  FBaseObject.Assign(TgtCoPDBaseObject(ASourceObj).FBaseObject);
end;

constructor TgtCoPDBaseObject.Create(ABaseObj: TgtPDBaseObject);
begin
  FBaseObject := ABaseObj;
end;

function TgtCoPDBaseObject.GetType: Integer;
var
  LType: TgtPDObjTypes;
begin
  LType := FBaseObject.GetType;
  if LType = otBoolean then Result := $00000000
  else
  if LType = otInteger then Result := $00000001
  else
  if LType = otReal then Result := $00000002
  else
  if LType = otString then Result := $00000003
  else
  if LType = otName then Result := $00000004
  else
  if LType = otCommand then Result := $00000005
  else
  if LType = otNull then Result := $00000006
  else
  if LType = otEOF then Result := $00000007
  else
  if LType = otError then Result := $00000008
  else
  if LType = otArray then Result := $00000009
  else
  if LType = otDict then Result := $0000000A
  else
  if LType = otIndirectRef then Result := $0000000B
  else
  if LType = otStream then Result := $0000000C
  else
  Result := $0000000D;
end;

function TgtCoPDBaseObject.GetTypeName: WideString;
begin
  Result := FBaseObject.GetTypeName;
end;

function TgtCoPDBaseObject.IsArray: WordBool;
begin
  Result := FBaseObject.IsArray;
end;

function TgtCoPDBaseObject.IsBoolean: WordBool;
begin
  Result := FBaseObject.IsBoolean;
end;

function TgtCoPDBaseObject.IsCommand: WordBool;
begin
  Result := FBaseObject.IsCommand;
end;

function TgtCoPDBaseObject.IsCommand(const ACommand: WideString): WordBool;
begin
  Result := FBaseObject.IsCommand(ACommand);
end;

function TgtCoPDBaseObject.IsDict(const ADictType: WideString): WordBool;
begin
  Result := FBaseObject.IsDict(ADictType);
end;

function TgtCoPDBaseObject.IsDict: WordBool;
begin
  Result := FBaseObject.IsDict;
end;

function TgtCoPDBaseObject.IsEOF: WordBool;
begin
  Result := FBaseObject.IsEOF;
end;

function TgtCoPDBaseObject.IsError: WordBool;
begin
  Result := FBaseObject.IsError;
end;

function TgtCoPDBaseObject.IsIndirectRef: WordBool;
begin
  Result := FBaseObject.IsIndirectRef;
end;

function TgtCoPDBaseObject.IsInteger: WordBool;
begin
  Result := FBaseObject.IsInteger;
end;

function TgtCoPDBaseObject.IsName: WordBool;
begin
  Result := FBaseObject.IsName;
end;

function TgtCoPDBaseObject.IsName(const AName: WideString): WordBool;
begin
  Result := FBaseObject.IsName(AName);
end;

function TgtCoPDBaseObject.IsNull: WordBool;
begin
  Result := FBaseObject.IsNull;
end;

function TgtCoPDBaseObject.IsNumber: WordBool;
begin
  Result := FBaseObject.IsNumber;
end;

function TgtCoPDBaseObject.IsReal: WordBool;
begin
  Result := FBaseObject.IsReal;
end;

function TgtCoPDBaseObject.IsStream: WordBool;
begin
  Result := FBaseObject.IsStream;
end;

function TgtCoPDBaseObject.IsString: WordBool;
begin
  Result := FBaseObject.IsString;
end;

end.
