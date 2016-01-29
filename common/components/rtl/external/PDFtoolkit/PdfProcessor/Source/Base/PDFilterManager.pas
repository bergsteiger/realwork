{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDFilterManager;

interface

uses
  gtObject, Stream, PDStream, PDDictionary, PDBaseObject;

type
  (**
   * TgtPDFilterManager
   *    This class is responsible for identifying the filter used in the
   * partcular Dictionary. It also creates the appropriate Filter object for
   * Decoding the stream.
   *)
  TgtPDFilterManager = class(TgtObject)
  private
    class function MakeFilter(AName: AnsiString; AParams: TgtPDBaseObject; ADict: TgtPDDictionary;
      AStream: TgtStream): TgtStream;
  public
    class function GetFilter(ADict: TgtPDBaseObject; AStream: TgtStream)
      : TgtPDStream;
  end;

implementation

uses
  PDConsts, PDName, PDArray, PDNull, PDBaseExceptions, EOFStream, PDInteger,
  FlateStream, FileStream, gtLogger, ASCII85Stream, ASCIIHexStream, CCITTStream,
  DCTStream, JBIG2Stream, JPXStream, LZWStream, RunLengthStream, PDBoolean;

{ TgtPDFilterManager }

  (**
   *    This function is responsible for finding the Filter and other related
   *  information used in the Dictionary and calling MakeFilter to create the
   *  appropriate Filter object(Filter Stream Object)
   *
   *  @param ADict is the dictionary which has the information for decoding a stream
   *  @param AStream is the Stream that need to be decoded
   *
   *  @return TgtPDStream is Filter stream object with the corresponding filter
   *
   *  @exception ExInvalidObject is raised if Dictionary containing decode
   *             information in nil
   *  @exception ExInvalidStream is raised if the stream to be decoded is nil
   *)

class function TgtPDFilterManager.GetFilter(ADict: TgtPDBaseObject;
  AStream: TgtStream): TgtPDStream;
var
  LObj, LObj2, LParams, LParams2: TgtPDBaseObject;
  LDict: TgtPDDictionary;
  I: Integer;
begin
  if (ADict = nil) then
  begin
    raise ExInvalidObject.Create(ErrInvalidObject);
  end;

  if (AStream = nil) then
  begin
    raise ExInvalidStream.Create(ErrInvalidStream);
  end;

  Result := nil;
  LDict := TgtPDDictionary(ADict);
  LObj := LDict.LookUpClone(PD_FILTER);
  if not Assigned(LObj) or LObj.IsNull then
  begin
    LObj.Free;
    LObj := LDict.LookUpClone(PD_F);
  end;
  LParams := LDict.LookUpClone(PD_DECODEPARAMS);
  if not Assigned(LParams) or LParams.IsNull then
  begin
    LParams.Free;
    LParams := LDict.LookUpClone(PD_DP);
  end;

//  if Assigned(LObj) and LObj.IsNull then LObj.Free;
  if Assigned(LParams) and LParams.IsArray then
  begin
    if TgtPDArray(LParams).GetLength = 0 then
    begin
      LParams.Free;
      LParams := TgtPDNull.Create;
    end
    else
    begin
      if TgtPDArray(LParams).Get(0).IsDict and
        (TgtPDDictionary(TgtPDArray(LParams).Get(0)).GetLength = 0) then
      begin
        LParams.Free;
        LParams := TgtPDNull.Create;
      end;
    end;
  end;                   

  if (not Assigned(LObj) or LObj.IsNull) and (not Assigned(LParams) or LParams.IsNull) then
  begin
    Result := TgtPDStream.Create(AStream, ADict);
  end
  else
    if LObj.IsName then
    begin
      AStream := TgtPDFilterManager.MakeFilter(TgtPDName(LObj).Value, LParams, LDict,
        AStream);
      Result := TgtPDStream.Create(AStream, nil);
    end
    else if LObj.IsArray then
    begin
      for I := 0 to TgtPDArray(LObj).GetLength - 1 do
      begin
        LObj2 := TgtPDArray(LObj).GetClone(I);
        LParams2 := nil;
        if LParams.IsArray then
          LParams2 := TgtPDArray(LParams).GetClone(I);
        if LObj2.IsName then
        begin
          AStream := TgtPDFilterManager.MakeFilter(TgtPDName(LObj2).Value,
            LParams2, LDict, AStream);
        end
        else
        begin
{$IFDEF DEBUG}
          Logger.LogError('Bad filter name');
{$ENDIF}
          Result := TgtPDStream.Create(TgtEOFStream.Create(AStream), nil);
          Exit;
        end;
        if Assigned(LObj2) then LObj2.Free;
        if Assigned(LParams2) then LParams2.Free;
      end;
      Result := TgtPDStream.Create(AStream, nil);
    end
    else if not LObj.IsNull then
    begin
{$IFDEF DEBUG}
      Logger.LogError('Bad "Filter" attribute in stream');
{$ENDIF}
    end;
  LObj.Free;
  if Assigned(LParams) then LParams.Free;
  if Assigned(Result) then
  begin
    Result.SetDict(LDict);
  end;
end;

  (**
   *    This function creates the corresponding Filter stream object with the
   *  Filter name mentioned (AName)
   *
   *  @param AName is the name of the Filter which Filter object need to be created
   *  @param AParams is a Dictionary which has the additional information that
   *         is required for decoding certain streams
   *  @param ADict is the Dictionary of a Stream object
   *  @param AStream is the stream which need to be decoded
   *)

class function TgtPDFilterManager.MakeFilter(AName: AnsiString;
  AParams: TgtPDBaseObject; ADict: TgtPDDictionary; AStream: TgtStream): TgtStream;
var
  LPred, LColoums, LColors, Lbits, LEarlyChange: Integer;
  LObj: TgtPDBaseObject;
  LEncoding: Integer;
  LEndOfLine: Boolean;
  LByteAlign: Boolean;
  LRows: Integer;
  LEndOfBlock: Boolean;
  LImageMask: Boolean;
  LBlack: Boolean;
  LColorXForm: Integer;
begin
  if (AName = PD_FLATEDECODE) or (AName = PD_Fl) then
  begin
    LPred := 1;
    LColoums := 1;
    LColors := 1;
    Lbits := 8;
    if Assigned(AParams) and AParams.IsDict then
    begin
      LObj := TgtPDDictionary(AParams).LookUp(PD_PREDICTOR);
      if Assigned(LObj) and LObj.IsInteger then
        LPred := TgtPDInteger(LObj).Value;

      LObj := TgtPDDictionary(AParams).LookUp(PD_COLUMNS);
      if Assigned(LObj) and LObj.IsInteger then
        LColoums := TgtPDInteger(LObj).Value;

      LObj := TgtPDDictionary(AParams).LookUp(PD_COLORS);
      if Assigned(LObj) and LObj.IsInteger then
        LColors := TgtPDInteger(LObj).Value;

      LObj := TgtPDDictionary(AParams).LookUp(PD_BITSPERCOMP);
      if Assigned(LObj) and LObj.IsInteger then
        Lbits := TgtPDInteger(LObj).Value;
    end;
    Result := TgtFlateStream.Create(AStream, LPred, LColoums,
      LColors, Lbits, True);
  end
  else if (AName = PD_ASCIIHEXDECODE) or (AName = PD_AHx) then
  begin
    Result := TgtASCIIHexStream.Create(AStream);
  end
  else if (AName = PD_ASCII85DECODE) or (AName = PD_A85) then
  begin
    Result := TgtASCII85Stream.Create(AStream, True);
  end
  else if (AName = PD_LZWDECODE) or (AName = PD_LZW) then
  begin
    LPred := 1;
    LColoums := 1;
    LColors := 1;
    Lbits := 8;
    LEarlyChange := 1;
    if Assigned(AParams) and AParams.IsDict then
    begin
      LObj := TgtPDDictionary(AParams).LookUp(PD_PREDICTOR);
      if Assigned(LObj) and LObj.IsInteger then
        LPred := TgtPDInteger(LObj).Value;

      LObj := TgtPDDictionary(AParams).LookUp(PD_COLUMNS);
      if Assigned(LObj) and LObj.IsInteger then
        LColoums := TgtPDInteger(LObj).Value;

      LObj := TgtPDDictionary(AParams).LookUp(PD_COLORS);
      if Assigned(LObj) and LObj.IsInteger then
        LColors := TgtPDInteger(LObj).Value;

      LObj := TgtPDDictionary(AParams).LookUp(PD_BITSPERCOMP);
      if Assigned(LObj) and LObj.IsInteger then
        Lbits := TgtPDInteger(LObj).Value;

      LObj := TgtPDDictionary(AParams).LookUp(PD_EARLYCHANGE);
      if Assigned(LObj) and LObj.IsInteger then
        LEarlyChange := TgtPDInteger(LObj).Value;
    end;

    Result := TgtLZWStream.Create(AStream, True, LPred,
      LColoums, LColors, Lbits, LEarlyChange);
  end
  else if (AName = PD_RUNLENGTHDECODE) or (AName = PD_RL) then
  begin
    Result := TgtRunLengthStream.Create(AStream, True);
  end
  else if (AName = PD_CCITTFAXDECODE) or (AName = PD_CCF) then
  begin
    LEncoding := 0;
    LEndOfLine := False;
    LByteAlign := False;
    LImageMask := False;
    LColoums := 1728;
    LRows := 0;
    LEndOfBlock := True;
    LBlack := False;

    if Assigned(AParams) and AParams.IsDict then
    begin
      LObj := TgtPDDictionary(AParams).LookUp(PD_K);
      if Assigned(LObj) and LObj.IsInteger then
        LEncoding := TgtPDInteger(LObj).Value;

      LObj := TgtPDDictionary(AParams).LookUp(PD_ENDOFLINE);
      if Assigned(LObj) and LObj.IsBoolean then
        LEndOfLine := TgtPDBoolean(LObj).Value;

      LObj := TgtPDDictionary(AParams).LookUp(PD_ENCODEDBYTEALIG);
      if Assigned(LObj) and LObj.IsBoolean then
        LByteAlign := TgtPDBoolean(LObj).Value;

      LObj := TgtPDDictionary(AParams).LookUp(PD_COLUMNS);
      if Assigned(LObj) and LObj.IsInteger then
        LColoums := TgtPDInteger(LObj).Value;

      LObj := TgtPDDictionary(AParams).LookUp(PD_ROWS);
      if Assigned(LObj) and LObj.IsInteger then
        LRows := TgtPDInteger(LObj).Value;

      LObj := TgtPDDictionary(AParams).LookUp(PD_ENDOFBLOCK);
      if Assigned(LObj) and LObj.IsBoolean then
        LEndOfBlock := TgtPDBoolean(LObj).Value;

      LObj := TgtPDDictionary(AParams).LookUp(PD_BLACKIS1);
      if Assigned(LObj) and LObj.IsBoolean then
        LBlack := TgtPDBoolean(LObj).Value;

    end;
//    LObj := TgtPDDictionary(ADict).LookUp(PD_IMAGEMASK);
//    if Assigned(LObj) and LObj.IsBoolean then
//      LImageMask := TgtPDBoolean(LObj).Value;
//
//    LBlack := LBlack or LImageMask;

    Result := TgtCCITTStream.Create(AStream, LEncoding,
      LEndOfLine, LByteAlign, LColoums, LRows, LEndOfBlock, LBlack, True);
  end
  else if (AName = PD_DCTDECODE) or (AName = PD_DCT) then
  begin
    LColorXForm := -1;

    if Assigned(AParams) and AParams.IsDict then
    begin
      LObj := TgtPDDictionary(AParams).LookUp(PD_COLORTRANSFORM);
      if Assigned(LObj) and LObj.IsInteger then
        LColorXForm := TgtPDInteger(LObj).Value;
    end;

    Result := TgtDCTStream.Create(AStream, True,
      LColorXForm);
  end
//  else if (AName = PD_JBIG2DECODE) then
//  begin
//
//  end
  else if (AName = PD_JPXDECODE) then
  begin
    Result := TgtJPXStream.Create(AStream, True);
  end
  else
  begin
{$IFDEF DEBUG}
    Logger.LogError('Unknown filter %s', [AName]);
{$ENDIF}
    Result := TgtEOFStream.Create(AStream);
  end;
end;

end.
