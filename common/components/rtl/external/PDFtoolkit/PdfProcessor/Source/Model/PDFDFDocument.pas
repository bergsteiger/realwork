{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDFDFDocument;

interface

uses
  gtObject, gtMethods, gtConstants, PDElement, PDBaseObject, PDDictionary,
  Stream, Classes, FileStream, PDXRef;

type
  TgtPDFDFDocument = class(TgtPDElement)
  private
    FHeader: AnsiString;                 //Header for the FDF Document
    FIsOwned: Boolean;               //Indicates whether the stream is owned by the class
    FTrailer: TgtPDDictionary;       //Treiler of the FDF Document
    FRoot: TgtPDDictionary;          //Root Object
    FBody: TgtPDDictionary;          //Body Dict
    FStream: TgtStream;              //Stream where the FDF document is saved
    FFile: TFileStream;              //Stream where FDF is saved when only path is provided
    FFileName: AnsiString;               //Path to where the FDF need to be saved
    FXref: TgtPDXRef;

    procedure InitDocument;          //Inits and Writes the header
    procedure WriteFDFBody;            //Creates and writes the body
    procedure WriteFDFTriler;
    procedure FinalizeDocument;
    function CreateFieldsArray: TgtPDBaseObject;
  public
    constructor Create(AParentDoc: TgtObject; AStream: TgtStream;
      AIsOwned: Boolean = False); overload;
    constructor Create(AParentDoc: TgtObject; FDFDocumentPath: AnsiString); overload;
    destructor Destroy; override;
    procedure Update; override;

    function ExportToFDFDocument: Boolean;
  end;

implementation

uses
  PDModelException, PDDocument, PDArray, PDFormField, PDString, PDName,
  PDIndirectRef, SysUtils, BaseStream;

type
  THackFormField = class(TgtPDFormField)

  end;
  
{ TgtPDFDFDocument }
  
constructor TgtPDFDFDocument.Create(AParentDoc: TgtObject; AStream: TgtStream;
  AIsOwned: Boolean);
begin
  FParentDoc := AParentDoc;
  FStream := AStream;
  FIsOwned := AIsOwned;
  FFileName := '';
  FFile := nil;
end;

constructor TgtPDFDFDocument.Create(AParentDoc: TgtObject;
  FDFDocumentPath: AnsiString);
begin
  FParentDoc := AParentDoc;
  FFileName := FDFDocumentPath;
  FIsOwned := True;
  FStream := nil;
end;

procedure TgtPDFDFDocument.WriteFDFBody;
var
  LFieldsArray: TgtPDArray;
  LDocFileName, LVersion: AnsiString;
begin
  //Release all previously assigned objects
  if Assigned(FBody) then FreeObject(FBody);
  if Assigned(FRoot) then FreeObject(FRoot);

  //Create the Root Dictionary with ObjectNumber one and GenNumber Zero
  FRoot := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);

  //Create FDF Dictionary
  FBody := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);

  //Creates Fields Array which holds each FormField objects
  LFieldsArray := CreateFieldsArray as TgtPDArray;

  //Writes Field Array into FDF Dictionary
  FBody.Add(PDF_FIELDS, LFieldsArray);

  //Writes the Body into the Root object
  FRoot.Add(FDF, FBody);

  //Add version to the Root object
  case TgtPDDocument(FParentDoc).Version of
    v12: LVersion := '1.2';
    v13: LVersion := '1.3';
    v14: LVersion := '1.4';
    v15: LVersion := '1.5';
    v16: LVersion := '1.6';
    v17: LVersion := '1.7';
  end;
  FBody.Add(PDF_VERSION, TgtPDString.Create(LVersion, False));

  //Writes the filename of  the document to FDF
  LDocFileName := TgtPDDocument(FParentDoc).GetFileName;
  if ExtractFilePath(LDocFileName) = ExtractFilePath(FFileName) then
  begin
    LDocFileName := ExtractFileName(LDocFileName);
  end;
  FBody.Add(PDF_F, TgtPDString.Create(LDocFileName, False));
  FBody.Add(PDF_UF, TgtPDString.Create(LDocFileName, False));

  //Write the Body to the stream
  FStream.Write('1 0 obj' + CRLF);
  FRoot.SaveToStream(FStream, False, FXref);
  FStream.Write(CRLF + 'endobj' + CRLF);
end;

procedure TgtPDFDFDocument.WriteFDFTriler;
var
  LInstenceID, LPermanentID: AnsiString;
  LIDArray: TgtPDArray;
  LObj: TgtPDBaseObject;
begin
  //Free previously allocated objects
  if Assigned(FTrailer) then
    FreeObject(FTrailer);

  //Create Trailer Dictionary
  FTrailer := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  LObj := TgtPDIndirectRef.Create(1, 0);
  FTrailer.Add(PDF_ROOT, LObj);

  //Add the ID of the Document if present
  TgtPDDocument(FParentDoc).BaseDoc.GetDocID(LInstenceID, LPermanentID);
  if LInstenceID <> '' then
  begin
    LIDArray := TgtPDArray.Create(TgtPDDocument(FParentDoc));
    LIDArray.Add(TgtPDString.Create(LInstenceID, False));
    LIDArray.Add(TgtPDString.Create(LPermanentID, False));
    FTrailer.Add(PDF_ID, LIDArray);
  end;

  //Writing Trailer Dictionary
  FStream.Write(PDF_TRAILER);
  FStream.Write(CRLF);
  //This is to make the writer think that this object is already written.
  //The Dictionary with ObjNum 1 is already there in the document, So by
  //setting the IsWritten falg to true will ignore the writting. After the
  //writting process it is reset to false so that, the document can be saved
  //after FDF exporting
  TgtPDDocument(FParentDoc).BaseDoc.GetDocRoot.IsWritten := True;
  FTrailer.SaveToStream(FStream, False, FXref);
  TgtPDDocument(FParentDoc).BaseDoc.GetDocRoot.IsWritten := False;
  FStream.Write(CRLF);
end;

function TgtPDFDFDocument.CreateFieldsArray: TgtPDBaseObject;
var
  LFieldsArray: TgtPDArray;
  LField: TgtPDDictionary;
  LObj: TgtPDBaseObject;
  LI, LJ: Integer;
  LFormField: TgtPDFormField;
begin
  //Create Fields Array
  LFieldsArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);

  //Traverse through each page to get the FormFields
  for LI := 1 to TgtPDDocument(FParentDoc).PageCount do
  begin
    //Traversing each form field in a page
    for LJ := 1 to TgtPDDocument(FParentDoc).Pages[LI].GetFormFieldCount do
    begin
      //Get the form field object
      LFormField := TgtPDDocument(FParentDoc).Pages[LI].GetFormField(LJ);
      //Create field Dictionary
      if (LFormField.FormFieldType <> ftButton) then
      begin
        LField := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
        //Add name of the field to the Dict
        LField.Add(PDF_T, TgtPDString.Create(THackFormField(LFormField).FieldName, False));

        //For radio button, check box it requires a name object rather than a
        //AnsiString object
        case LFormField.FormFieldType of
          ftText, ftListBox, ftComboBox:
            begin
              LObj := TgtPDString.Create(THackFormField(LFormField).Value, False);
            end;
          ftCheckBox, ftRadio:
            begin
              LObj := TgtPDName.Create(THackFormField(LFormField).Value);
            end;
        end;
        //Add Value to the Dict
        LField.Add(PDF_V, LObj);
        LObj := nil;
        //Add the field to Fields array
        LFieldsArray.Add(LField);
      end;
    end;
  end;
  Result := LFieldsArray;
end;

destructor TgtPDFDFDocument.Destroy;
begin
  if FIsOwned then
  begin
   if Assigned(FFile) then FreeObject(FFile);
   if Assigned(FStream) then FreeObject(FStream);
  end;
  inherited;
end;

function TgtPDFDFDocument.ExportToFDFDocument: Boolean;
begin
  Result := False;
  //Initialise the FDF document
  InitDocument;
  //Write the Root
  WriteFDFBody;
  //Create Trailer
  WriteFDFTriler;
  //Finalise the FDF Document
  FinalizeDocument;
  Result := True;
end;

procedure TgtPDFDFDocument.FinalizeDocument;
begin
  //Writes EndOfFile
  FStream.Write(PDF_EOF);

  //Free all allocated objects
  if Assigned(FRoot) then FreeObject(FRoot);
  if Assigned(FXref) then FreeObject(FXref);  
end;

procedure TgtPDFDFDocument.InitDocument;
begin
  //Creates the Stream if the file name is provided
  if not Assigned(FStream) then
  begin
    try
      FFile := TFileStream.Create(FFileName, fmCreate);
      FStream := TgtFileStream.Create(FFile, 0, 0, False);
    except
      on E: EFCreateError do
        raise ExFileCreateError.Create(ErrFileCreateError);
    end;
  end;
  //Creates the Xref for the writting process
  FXref := TgtPDXRef.Create(TgtPDDocument(FParentDoc).BaseDoc,
    TgtBaseStream(FStream));
  FHeader := '%FDF-' + FloatToStringLocale(FDF_VERSION) + CRLF;
  //Writes the header for FDF
  FStream.Write(FHeader);
end;

procedure TgtPDFDFDocument.Update;
begin
  inherited;

end;

end.
