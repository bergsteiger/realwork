{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDReader;

interface

uses
  Classes, gtObject, PDXRef, BaseStream, PDBaseObject;

type
 (**
  * Implements the logic needed for reading Portable Documents. Every PDBaseDoc
  * will contain a Reader object. The Reader takes care of optimized loading of
  * a document, Reconstructiong the document if needed(depending upon user
  * options) and fetching PDF objects from the PDF file.
  *)
  TgtPDReader = class(TgtObject)
  private
    //Cross reference table for the PDF file
    FXRef: TgtPDXRef;
    //Stream which points to the PDF file (Internal Implementation)
    FStream: TgtBaseStream;
    //Stream which points to the PDF file
    FFile: TStream;
    // The parent document, while using type cast to TgtPDBaseDoc
    FParentDoc: TgtObject;
  public
    constructor Create(ParentDoc: TgtObject);
    destructor Destroy; override;

    function GetFileStream: TStream;
    function GetXRef: TgtPDXRef;

    procedure LoadFromFile(const Filename: AnsiString);
    procedure LoadFromStream(Stream: TStream);
    function Fetch(ObjectNumber: Cardinal): TgtPDBaseObject;
    function GetTrailer: TgtPDBaseObject;

    //The cross reference table of the PDF file
    property XRef: TgtPDXRef read GetXRef;
    //The Stream pointing to the PDF file
    property FileStream: TStream read GetFileStream;
  end;

implementation

uses
  FileStream, SysUtils, PDBaseExceptions;

{ TgtPDReader }

 (**
  * Constructor
  *
  * @param ParentDoc The parent document object
  *)

constructor TgtPDReader.Create(ParentDoc: TgtObject);
begin
  FParentDoc := ParentDoc;
end;

 (**
  * Destructor
  *
  *)

destructor TgtPDReader.Destroy;
begin
  if Assigned(FXRef) then FreeAndNil(FXRef);
  if Assigned(FStream) then FreeAndNil(FStream);
  FFile := nil;
  inherited;
end;

 (**
  * Fetches the PDF object having Object Number as  <ObjectNumber>
  *
  * @param  ObjectNumber Object Number of the PDF object that has to be fetched
  * @return The PDF object with requested Object number
  *         if PDF does not contain object with the request objectnumber the
  *         nil is returned
  *)

function TgtPDReader.Fetch(ObjectNumber: Cardinal): TgtPDBaseObject;
begin
  Result := nil;

  if Assigned(FXRef) then Result := FXRef.Fetch(ObjectNumber);

  if Assigned(Result) then
  begin
    if Result.IsError then
      FreeAndNil(Result)
    else
      Result.IsWritten := False;
  end;
end;

 (**
  * Gets the Trailer object of the PDF file
  *
  * @return The trailer dictionary of the PDF file
  *
  *)

function TgtPDReader.GetFileStream: TStream;
begin
  Result := FFile;
end;

function TgtPDReader.GetTrailer: TgtPDBaseObject;
var
  LTrialer: TgtPDBaseObject;
begin
  Result := nil;
  LTrialer := FXRef.GetTrailorDict;
  if Assigned(LTrialer) then
    Result := LTrialer.Clone;
end;

function TgtPDReader.GetXRef: TgtPDXRef;
begin
  Result := FXRef;
end;

(**
  * Loads the PDF file from disk
  *
  * @param FileName the file name and path of the file to be loaded
  * @exception ExFileNotFound If file not found
  * @exception ExFileIOError If file open error
  *)

procedure TgtPDReader.LoadFromFile(const Filename: AnsiString);
var
  LStream: TStream;
begin
  if not FileExists(Filename) then
  begin
    raise ExFileNotFound.Create(ErrFileNotFound);
  end;
  try
    LStream := TFileStream.Create(Filename, $0000 + $0010); //fmOpenRead + fmShareExclusive
  except
    on E: EFOpenError do
      raise ExFileOpenError.Create(ErrFileOpenError);
  end;
  LoadFromStream(LStream);
end;

 (**
  * Loads the PDF file from stream
  *
  * @param Stream the Stream variable containg the file to be loaded
  *
  *)

procedure TgtPDReader.LoadFromStream(Stream: TStream);
begin
  FFile := Stream;
  FStream := TgtFileStream.Create(TFileStream(FFile), 0, 0, False);
  FXRef := TgtPDXRef.Create(FParentDoc, FStream);
  FXRef.GenerateTable;
end;

end.
