unit csAutoAnnoExport;

interface

uses
  csExport,
  DT_Types,
  csAutoAnnoExportPrim
  ;

type
 TcsAutoAnnoExport = class(TcsAutoAnnoExportPrim)
 public
  constructor Create(aUserID: TUserID); override;
 end;//TcsAutoAnnoExport

implementation

uses
  csTaskTypes,
  daSchemeConsts,
  DT_Const
  ;

constructor TcsAutoAnnoExport.Create(aUserID: TUserID);
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
