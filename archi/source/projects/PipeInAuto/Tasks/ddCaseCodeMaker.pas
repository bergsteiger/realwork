unit ddCaseCodeMaker;
{ Автоматическое создание Номеров дел для Постановлений Федеральных Арбитражных судов }

interface

Uses
 l3Base, l3TempMemoryStream, l3Filer,
 csServerTaskTypes, csProcessTask,
 dt_Types, l3CustomString, ddProgressObj, CsExport,
 csMessageManager,
 ddCaseCodeTaskPrim,
 ddProcessTaskPrim,
 SewerPipe
 ;

type
 TalcuCaseCodeMaker = class(Tl3Base)
 private
  f_Filer: Tl3CustomFiler;
  f_Stream: Tl3TempMemoryStream;
  f_TopicNo: Integer;
  f_OutPipe: TSewerPipe;
 public
  function Execute(aTask: TddProcessTask; aProgressor: TddProgressObject): Boolean;
  procedure Abort;
 end;

type
 TddCaseCodeTask = class(TddCaseCodeTaskPrim)
 private
  f_Maker: TalcuCaseCodeMaker;
 protected
  procedure DoRun(const aContext: TddRunContext); override;
  function GetDescription: AnsiString; override;
  procedure DoAbort; override;
 public
  class function CanAsyncRun: Boolean; override;
  {$If defined(AppServerSide)}
  procedure SetupServerSideConfigParams; override;
  {$IfEnd defined(AppServerSide)}
 end;

implementation

Uses
 ddImportPipeKernel,
 daSchemeConsts,
 dd_lcCaseCodeGenerator, Document_Const, ddAppConfig, dtIntf, DT_Sab, dt_Doc, DT_Const,
 DT_Serv, evdWriter, evEvdRd, Classes, DT_User, DT_UserConst, DT_IFltr,
 SysUtils, csTaskTypes, ddServerTask;

procedure TalcuCaseCodeMaker.Abort;
begin
  f_OutPipe.Aborted := True;
end;

function TalcuCaseCodeMaker.Execute(aTask: TddProcessTask; aProgressor:
    TddProgressObject): Boolean;
var
 l_Maker: TlcCaseCodeGenerator;
 l_Writer: TevdNativeWriter;
 l_Sab: ISab;
begin
 // Экспортируем во временный файл
 f_OutPipe:= TSewerPipe.Create;
 try
  f_outPipe.Progressor:= aProgressor;
  f_OutPipe.ExportDocument:= True;
  Assert(TddCaseCodeTask(aTask).DiapasonType in [tdSingle, tdNumList]);
  if TddCaseCodeTask(aTask).DiapasonType = tdNumList then
  begin
   DocumentServer.Family:= CurrentFamily;
   l_Sab:= MakeValueSet(DocumentServer.FileTbl, fID_Fld, TcsExport(aTask).SABStream);
   l_Sab.Sort;
   f_OutPipe.DocSab := l_Sab;
  end
  else
   f_OutPipe.MakeSingleDocSab(TcsExport(aTask).DocID, False);

  l_Maker:= TlcCaseCodeGenerator.Create(nil);
  try
   f_OutPipe.Writer:= l_Maker;
   l_Maker.Generator:= nil; //l_Writer;
   Result:= f_OutPipe.Execute;
  finally
   l3Free(l_Maker);
  end;
 finally
  l3Free(f_OutPipe);
 end;
end;

class function TddCaseCodeTask.CanAsyncRun: Boolean;
begin
  Result := True;
end;

procedure TddCaseCodeTask.DoAbort;
begin
  inherited DoAbort;
  f_Maker.Abort;
end;

procedure TddCaseCodeTask.DoRun(const aContext: TddRunContext);
begin
 f_Maker := TalcuCaseCodeMaker.Create;
 try
  f_Maker.Execute(Self, aContext.rProgressor)
 finally
  FreeAndNil(f_Maker);
 end;
end;

function TddCaseCodeTask.GetDescription: AnsiString;
begin
 Result:= 'Расстановка Номеров дел в постановлениях ФАС';
end;

  {$If defined(AppServerSide)}
procedure TddCaseCodeTask.SetupServerSideConfigParams;
begin
  inherited;
  DiapasonType          := tdNumList;
  ExportEmptyKW         := False;
  ExportDocument        := True;
  ExportRTFBody         := False;
  ExportKW              := False;
  ExportDocImage        := False;
  MultiUser             := True;
  Family                := CurrentFamily;
  InternalFormat        := False;
  OutFileType           := outEVD;
  SeparateFiles         := divNone;
  DocumentFileNameMask  := '';
  ReferenceFileNameMask := '';
  ObjTopicFileName      := '';
  KWFileName            := '';
  OutputFileSize        := 0;
  ExportAnnoTopics      := False;
  AnnoTopicFileName     := 'Archianno.nsr';
end;
  {$IfEnd defined(AppServerSide)}

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\dd\ddCaseCodeMaker.pas initialization enter'); {$EndIf}
 RegisterTaskClass(cs_ttCaseCode, TddCaseCodeTask, 'Создание номеров дел для постановлений ФАС');
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\dd\ddCaseCodeMaker.pas initialization leave'); {$EndIf}
end.
