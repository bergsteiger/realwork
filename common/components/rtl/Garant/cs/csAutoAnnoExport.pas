unit csAutoAnnoExport;

interface

uses
  csExport,
  daTypes,
  csAutoAnnoExportPrim
  ;

type
 TcsAutoAnnoExport = class(TcsAutoAnnoExportPrim)
 public
  constructor Create(aUserID: TdaUserID); override;
 end;//TcsAutoAnnoExport

implementation

uses
  csTaskTypes,
  daSchemeConsts,
  DT_Const,
  dt_Types
  ;

constructor TcsAutoAnnoExport.Create(aUserID: TdaUserID);
begin
  inherited;
  DiapasonType          := tdNumList;
  ExportEmptyKW         := False;
  ExportDocument        := False;
  ExportRTFBody         := False;
  ExportKW              := False;
  ExportDocImage        := False;
  MultiUser             := True;
  Family                := CurrentFamily;
  InternalFormat        := False;
  OutFileType           := outNSRC;
  SeparateFiles         := divNone;
  DocumentFileNameMask  := '';
  ReferenceFileNameMask := '';
  ObjTopicFileName      := '';
  KWFileName            := '';
  OutputFileSize        := 0;
  ExportAnnoTopics      := True;
  AnnoTopicFileName     := 'Archianno.nsr';
end;

initialization

end.
