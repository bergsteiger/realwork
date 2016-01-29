{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDXRefEntry;

interface

uses
  gtObject;

type

  TgtPDXRefEntrytype =
    (
    xeFree,
    xeUnCompressed,
    xeCompressed
    );

  (**
   *  This class represent each item in the XRef table
   *)

  TgtPDXRefEntry = class(TgtObject)
  private
    FOffset: Cardinal;
    FGenNum: Cardinal;
    FEntryType: TgtPDXRefEntrytype;
  public
    constructor Create; overload;
    constructor Create(AOffset, AGenNum: Cardinal; AEntryType:
      TgtPDXRefEntrytype); overload;

    function GetEntryType: TgtPDXRefEntrytype;
    function GetGenNum: Cardinal;
    function GetOffset: Cardinal;
    procedure SetEntryType(const Value: TgtPDXRefEntrytype);
    procedure SetGenNum(const Value: Cardinal);
    procedure SetOffset(const Value: Cardinal);
    property Offset: Cardinal read GetOffset write SetOffset;
    property GenNum: Cardinal read GetGenNum write SetGenNum;
    property EntryType: TgtPDXRefEntrytype read GetEntryType write SetEntryType;
  end;

implementation

{ TgtPDXRefEntry }

  (**
   *  Constructor
   *)

constructor TgtPDXRefEntry.Create;
begin
  Offset := $FFFFFFFF;
  GenNum := $FFFFFFFF;
  EntryType := xeFree;
end;

  (**
   *  Constructor
   *
   *  @param AOffset is the Offset value in this entry
   *  @param AGenNum is the generation number in this entry
   *)

constructor TgtPDXRefEntry.Create(AOffset, AGenNum: Cardinal;
  AEntryType: TgtPDXRefEntrytype);
begin
  Offset := AOffset;
  GenNum := AGenNum;
  EntryType := AEntryType;
end;

function TgtPDXRefEntry.GetEntryType: TgtPDXRefEntrytype;
begin
  Result := FEntryType;
end;

function TgtPDXRefEntry.GetGenNum: Cardinal;
begin
  Result := FGenNum;
end;

function TgtPDXRefEntry.GetOffset: Cardinal;
begin
  Result := FOffset;
end;

procedure TgtPDXRefEntry.SetEntryType(const Value: TgtPDXRefEntrytype);
begin
  FEntryType := Value;
end;

procedure TgtPDXRefEntry.SetGenNum(const Value: Cardinal);
begin
  FGenNum := Value;
end;

procedure TgtPDXRefEntry.SetOffset(const Value: Cardinal);
begin
  FOffset := Value;
end;

end.
