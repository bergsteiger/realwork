unit PDContents;

interface

uses
  Classes, Contnrs, PDElement, PDContentStream, gtObject, PDExportDevice, PDBaseObject,
  PDRect;

type

  TgtPDContents = class(TgtPDElement)
  private
    FContentStrmList: TObjectList;

    function GetStream(Index: Integer): TgtPDContentStream;
    function GetStreamCount: Integer;
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
    destructor Destroy; override;
    procedure Update; override;
    procedure Display(ExportDev: TgtPDExportDevice; hDPI, vDPI: Double;
      PageNum, Rotate: Integer; Box: TgtPDRect; CropBox: TgtPDRect;
      RenderAnnots: Boolean = True);
    procedure AddStream(Stream: TgtPDContentStream; AtFirst: Boolean;
      AtIndex: Integer = -1);
    property StreamCount: Integer read GetStreamCount;
    property Streams[Index: Integer]: TgtPDContentStream read GetStream;
  end;

implementation

uses
  gtConstants, gtMethods, PDArray, PDState, PDIndirectRef, PDDocument, PDPage,
  PDDictionary;

{ TgtPDContents }

procedure TgtPDContents.AddStream(Stream: TgtPDContentStream; AtFirst: Boolean;
  AtIndex: Integer = -1);
var
  LObj, LObj2, LArray: TgtPDBaseObject;
begin
  if (FBaseObject.IsArray) then
  begin
    LObj := TgtPDIndirectRef.Create(Stream.BaseObject.ObjNumber,
      Stream.BaseObject.GenNumber);
    if ((AtFirst) and (AtIndex = -1)) then
    begin
      if Assigned(GetStream(0)) then
        FContentStrmList.Insert(0, Stream);
      TgtPDArray(FBaseObject).Insert(LObj, 0);
    end
    else if ((not (AtFirst)) and (AtIndex = -1)) then
    begin
      if Assigned(GetStream(0)) then
        FContentStrmList.Add(Stream);
      TgtPDArray(FBaseObject).Add(LObj);
    end
    else if (AtIndex <> -1) then
    begin
      if Assigned(GetStream(0)) then
        FContentStrmList.Insert(AtIndex, Stream);    
      TgtPDArray(FBaseObject).Insert(LObj, AtIndex);
    end;
  end
  else if (FBaseObject.IsStream) then
  begin
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
      TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
    //Create an indirect ref for contents array
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc,
      TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0);
    LArray.IsChanged := True;
    //Create an indirectref for the new contentstream to be added
    LObj := TgtPDIndirectRef.Create(Stream.BaseObject.ObjNumber,
      Stream.BaseObject.GenNumber);
    //Create an indirectref for the existing contentstream
    LObj2 := TgtPDIndirectRef.Create(FBaseObject.ObjNumber, FBaseObject.GenNumber);
    //Now add the existing and new contentstreams to the content array
    if ((AtFirst) or (AtIndex <> -1)) then
    begin
      if Assigned(GetStream(0)) then
        FContentStrmList.Insert(0, Stream);
      TgtPDArray(LArray).Add(LObj);
      TgtPDArray(LArray).Add(LObj2);
    end
    else if ((not (AtFirst)) and (AtIndex = -1)) then
    begin
      if Assigned(GetStream(0)) then
        FContentStrmList.Add(Stream);    
      TgtPDArray(LArray).Add(LObj2);
      TgtPDArray(LArray).Add(LObj);
    end;
    TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LArray);
    LObj := TgtPDIndirectRef.Create(LArray.ObjNumber, LArray.GenNumber);
    //Resetting the Contents value to indirectref of new contents array
    TgtPDDictionary(TgtPDPage(FParentElement).BaseObject).SetKeyValue(PDF_CONTENTS, LObj);
    TgtPDPage(FParentElement).Contents.FBaseObject := LArray;
  end;
end;

(**
 *  Constructor
 *  @param AParentDoc is the Document for this object
 *  @param AParentElement is the parent Dictionary for this object
 *  @param ABaseObject is the Object defining this object(Content Dict in this case)
 *  @algorithm
 *         a.	Assign parameter AParentDoc to FParentDoc
 *         b.	Assign parameter AParentElement to FParentElement
 *         c.	Assign parameter ABaseObject to FBaseObject
 *
 *)

constructor TgtPDContents.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
end;

destructor TgtPDContents.Destroy;
begin
  FreeObject(FContentStrmList);
  inherited;
end;

type
  TgtHackContenetStream = class(TgtPDContentStream) end;

procedure TgtPDContents.Display(ExportDev: TgtPDExportDevice; hDPI,
  vDPI: Double; PageNum, Rotate: Integer; Box, CropBox: TgtPDRect;
  RenderAnnots: Boolean);

var
  I, J: Integer;
  LState: TgtPDState;
begin
  if StreamCount > 0 then
  begin
    if Assigned(TgtHackContenetStream(Streams[0]).State) then
      TgtHackContenetStream(Streams[0]).State.Free;
    TgtHackContenetStream(Streams[0]).State := TgtPDState.Create(hDPI, vDPI,
      Rotate, CropBox);
    ExportDev.StartPage(PageNum, TgtHackContenetStream(Streams[0]).State);

    if Assigned(CropBox) then
    begin
      if CropBox.IsValid then
      begin
        TgtHackContenetStream(Streams[0]).State.MoveTo(CropBox.Left, CropBox.Top);
        TgtHackContenetStream(Streams[0]).State.LineTo(CropBox.Right, CropBox.Top);
        TgtHackContenetStream(Streams[0]).State.LineTo(CropBox.Right, CropBox.Bottom);
        TgtHackContenetStream(Streams[0]).State.LineTo(CropBox.Left, CropBox.Bottom);
        TgtHackContenetStream(Streams[0]).State.ClosePath;
        ExportDev.Clip(TgtHackContenetStream(Streams[0]).State);
        TgtHackContenetStream(Streams[0]).State.ClearPath;
      end;
    end;

    for I := 0 to StreamCount - 1 do
    begin
      if I > 0 then
      begin
        TgtHackContenetStream(Streams[I]).State :=
          TgtHackContenetStream(Streams[I - 1]).State.Copy;
        for J := 0 to TgtHackContenetStream(Streams[I - 1]).NumArgs - 1 do
        begin
          TgtHackContenetStream(Streams[I]).Args[J] :=
            TgtHackContenetStream(Streams[I - 1]).Args[J];
          TgtHackContenetStream(Streams[I - 1]).Args[J] := nil;
        end;
        TgtHackContenetStream(Streams[I]).NumArgs :=
          TgtHackContenetStream(Streams[I - 1]).NumArgs;
        TgtHackContenetStream(Streams[I - 1]).NumArgs := 0;

        TgtHackContenetStream(Streams[I]).FFontChanged :=
          TgtHackContenetStream(Streams[I - 1]).FFontChanged;
      end;
      Streams[I].Display(ExportDev, hDPI, vDPI, PageNum, Rotate, Box, CropBox);
    end;

    if RenderAnnots then
      TgtPDPage(FParentElement).RenderAnnots(ExportDev, hDPI, vDPI, CropBox);

    ExportDev.EndPage;
  end
  else
  begin
    LState := TgtPDState.Create(hDPI, vDPI, Rotate, CropBox);
    ExportDev.StartPage(PageNum, LState);
    if RenderAnnots then
      TgtPDPage(FParentElement).RenderAnnots(ExportDev, hDPI, vDPI, CropBox);
    ExportDev.EndPage;
    LState.Free;
  end;
end;

(*
 *  Gets the Stream from the Index position
 *
 *  @returns ContentStream from Index position
 *  @algorithm
 *    1.  Start
 *    2.  IF Index < StreamCount THEN
 *    3.  begin
 *       a. IF FContentStreamList is not Assigned THEN
 *       b. begin
 *          i.   IF FBaseObject is Array THEN
 *          ii.  begin
 *              1.  Loop LI from 0 to Count - 1
 *              2.  begin
 *                 a. LContentObj := get from the array with LI
 *                 b. Create and Add TgtPDContentStream object to FContentStreamList with LContentObj
 *              3.  End
 *          iii. End
 *          iv. Else
 *            Create and Add TgtPDContentStream object to FContentStreamList with FBaseObject
 *       c. End
 *       d. IF Assigned FContentStreamList THEn
 *          i.  Result := FContentStreamList.Items[Index] as TgtPDContentStream
 *    4.  End
 *    5.  End
 *)

function TgtPDContents.GetStream(Index: Integer): TgtPDContentStream;
var
  LI: Integer;
  LContentObj: TgtPDBaseObject;
begin
  Result := nil;
  if (Index < GetStreamCount) then
  begin
    if not Assigned(FContentStrmList) then
    begin
      FContentStrmList := TObjectList.Create(True);
      if FBaseObject.IsArray then
      begin
        for LI := 0 to GetStreamCount - 1 do
        begin
          LContentObj := TgtPDArray(FBaseObject).Get(LI);
          if LContentObj.IsStream then
            FContentStrmList.Add(TgtPDContentStream.Create(FParentDoc, Self, LContentObj))
//          else
//            raise
        end;
      end
      else
        FContentStrmList.Add(TgtPDContentStream.Create(FParentDoc, Self, FBaseObject));
    end;
    if Assigned(FContentStrmList) then
      Result := TgtPDContentStream(FContentStrmList.Items[Index]);
  end;
end;

(*
 *  Gets the count of the contents object
 *
 *  @returns Count of the contents object
 *  @algorithm
 *        1.  Start
 *        2.  Result := 1
 *        3.  IF the BaseObject is Array object THEN
 *           a.  Result := Get the Length of the BaseObject by Typecasting it
 *               into Array object
 *        4.  End
 *)

function TgtPDContents.GetStreamCount: Integer;
begin
  Result := 1;
  if Assigned(FBaseObject) and FBaseObject.IsArray then
    Result := TgtPDArray(FBaseObject).GetLength;
end;

procedure TgtPDContents.Update;
begin
  inherited;

end;

end.
