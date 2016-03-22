unit ddDocTextFilterer;

{ $Id: ddDocTextFilterer.pas,v 1.6 2015/11/26 08:45:43 lukyanets Exp $ }

// $Log: ddDocTextFilterer.pas,v $
// Revision 1.6  2015/11/26 08:45:43  lukyanets
//  ќнстанты переехали
//
// Revision 1.5  2015/05/20 14:02:21  lulin
// - рисуем на модели.
//
// Revision 1.4  2015/05/19 13:23:21  lulin
// - рисуем на модели.
//
// Revision 1.3  2014/08/06 14:21:21  voba
// - rename _Tm3DBFiler.Index -> _Tm3DBFiler.ObjectIndex
//
// Revision 1.2  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.1  2011/06/23 08:02:32  fireton
// - правим справки на предмет источников опубликовани€
//

interface
uses
 l3Types,
 l3ProtoObject,
 l3Filer,

 k2TagFilter,

 m3DBInterfaces,
 m3DB,

 evEvdRd,
 evdWriter,

 DT_Types,

 ddTypes,

 m3DBFiler
 ;

type
 TddDocumentTextFilterer = class(Tl3ProtoObject)
 private
  f_OnError  : TddErrorEvent;
  f_DB       : Im3DB;
  f_Reader   : TevCustomEvdReader;
  f_Writer   : TevdCustomNativeWriter;
  f_OutFiler : Tm3DBFiler;
  f_InFiler  : Tl3CustomFiler;
  f_Filter   : Tk2TagFilter;
  procedure pm_SetFilter(const Value: Tk2TagFilter); virtual;
  procedure pm_SetOnError(const Value: TddErrorEvent);
 protected
  procedure DoOnSetOnError; virtual;
  procedure Cleanup; override;
  procedure DoError(const aDescript: AnsiString; aCategory: Integer);
 public
  constructor Create(const aDocProgressProc: Tl3ProgressProc = nil);
  procedure ProcessOneID(aDocID: TDocID);
  property Filter: Tk2TagFilter read f_Filter write pm_SetFilter;
  property OnError: TddErrorEvent read f_OnError write pm_SetOnError;
 end;

implementation
uses
 SysUtils,

 l3FileUtils,

 m3StorageInterfaces,

 daSchemeConsts,

 DT_Const,
 DT_Serv;

const
 cDocTextFiltererReportLevel = 1;

constructor TddDocumentTextFilterer.Create(const aDocProgressProc: Tl3ProgressProc = nil);
var
 l_Name: AnsiString;
begin
 inherited Create;
 l_Name := ConcatDirName(ExcludeTrailingBackslash(GlobalHtServer.FamilyTbl.FamilyPath(CurrentFamily)), 'bserv001');
 f_DB := Tm3DB.Make(l_Name, nil, aDocProgressProc);
 f_InFiler := Tl3CustomFiler.Create;
 f_InFiler.Mode := l3_fmRead;
 f_Reader := TevCustomEvdReader.Create;
 f_Reader.Filer := f_InFiler;
 f_Writer := TevdCustomNativeWriter.Create;
 f_Writer.Binary := True;
 f_OutFiler := Tm3DBFiler.Create(f_DB);
 f_OutFiler.Mode := l3_fmWrite;
 f_Writer.Filer := f_OutFiler;
end;

procedure TddDocumentTextFilterer.Cleanup;
begin
 FreeAndNil(f_OutFiler);
 FreeAndNil(f_Writer);
 FreeAndNil(f_Reader);
 FreeAndNil(f_InFiler);
 inherited;
end;

procedure TddDocumentTextFilterer.DoError(const aDescript: AnsiString; aCategory: Integer);
begin
 if Assigned(f_OnError) then
  f_OnError(aDescript, aCategory);
end;

procedure TddDocumentTextFilterer.DoOnSetOnError;
begin
 // empty in base class
end;

procedure TddDocumentTextFilterer.pm_SetFilter(const Value: Tk2TagFilter);
begin
 f_Filter := Value;
 f_Reader.Generator := f_Filter;
 if f_Filter <> nil then
  f_Filter.Generator := f_Writer;
end;

procedure TddDocumentTextFilterer.pm_SetOnError(const Value: TddErrorEvent);
begin
 f_OnError := Value;
 DoOnSetOnError;
end;

procedure TddDocumentTextFilterer.ProcessOneID(aDocID: TDocID);
var
 l_Doc: Im3DBDocument;
begin
 Assert(Filter <> nil);
 l_Doc := f_DB.GetDocument(aDocID);
 f_InFiler.Handle := aDocID;
 f_InFiler.COMStream := l_Doc.Open(m3_saRead, m3_dsMain);
 f_OutFiler.Handle := aDocID;
 f_OutFiler.PartSelector := m3_dsMain;
 f_OutFiler.ObjectIndex := 0;
 f_OutFiler.Open;
 try
  f_Reader.Execute;
 finally
  f_InFiler.COMStream := nil;
  f_OutFiler.Close;
 end;
end;




(*











  procedure CheckOneDocument(const aDocID: TDocID);
  var
   l_Doc: Im3DBDocument;
  begin
   l_Doc := l_DB.GetDocument(aDocID);
   l_InFiler.Handle := aDocID;
   l_InFiler.COMStream := l_Doc.Open(m3_saRead, m3_dsMain);
   l_OutFiler.Handle := aDocID;
   l_OutFiler.PartSelector := m3_dsMain;
   l_OutFiler.Index := 0;
   l_OutFiler.Open;
   try
    l_Reader.Execute;
   finally
    l_InFiler.COMStream := nil;
    l_OutFiler.Close;
   end;
  end;






  l_Name := ConcatDirName(ExcludeTrailingBackslash(GlobalHtServer.FamilyTbl.FamilyPath(CurrentFamily)), 'bserv001');
  l_DB := Tm3DB.Make(l_Name, nil, aProgressor.Update);
  try
   l_InFiler := Tl3CustomFiler.Create;
   try
    l_InFiler.Mode := l3_fmRead;
    l_Reader := TevCustomEvdReader.Create;
    try
     l_Reader.Filer := l_InFiler;
     l_Filter := TddMisspellCorrectFilter.Create;
     try
      l_Filter.OnError:= SpellError;
      l_Reader.Generator := l_Filter;
      l_Writer := TevdCustomNativeWriter.Create;
      try
       l_Filter.Generator := l_Writer;
       l_Writer.Binary := True;
       l_OutFiler := Tm3DBFiler.Create(l_DB);
       try
        l_OutFiler.Mode := l3_fmWrite;
        l_Writer.Filer := l_OutFiler;

        DocumentServer.Family := CurrentFamily;
        while not (l_TopicListFiler.EOF) do
        begin
         l_SRString := l_TopicListFiler.Readln;
         CurDocID := ddParsePairsString(l_SRString, l_Filter);
         if CurDocID > 0 then
         begin
          l_DocID:= Linkserver(CurrentFamily).Renum.ConvertToRealNumber(CurDocID);
          f_IsRelated := False;
          if l_DocID > 0 then
          begin
           CheckOneDocument(l_DocID);
           l_RelID := DocumentServer.FileTbl.GetRelated(l_DocID, l_Tmp);
           if l_RelID > 0 then
           begin
            f_IsRelated := True;
            CheckOneDocument(l_RelID);
           end;
          end
          else
           SpellError(' документа нет в базе', 0);
         end; // CurDocID > 0
        end; // while not EOF
       finally
        FreeAndNil(l_OutFiler);
       end;
      finally
       FreeAndNil(l_Writer);
      end;
     finally
      FreeAndNil(l_Filter);
     end;
    finally
     FreeAndNil(l_Reader);
    end;
   finally
    FreeAndNil(l_InFiler);
   end;
  finally
   l_DB := nil;
  end;//try..finally
*)
end.