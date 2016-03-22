unit ncsOneFileDeliverer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/ncsOneFileDeliverer.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ResultDelivery::TncsOneFileDeliverer
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  Classes,
  l3ProtoObject,
  ddProgressObj,
  ncsMessageInterfaces,
  ncsFileDesc,
  ncsTaskedFileDesc,
  ncsMessage
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsOneFileDeliverer = class(Tl3ProtoObject, IncsExecutor, IncsMessageExecutorFactory)
 private
 // private fields
   f_Transporter : IncsTransporter;
   f_LocalPath : AnsiString;
   f_TaskID : AnsiString;
   f_Stream : TStream;
   f_Progressor : TddProgressObject;
   f_LocalDesc : TncsTaskedFileDesc;
    {* ���� ��� �������� LocalDesc}
 private
 // private methods
   function CheckContinue(aRemoteDesc: TncsFileDesc): Boolean;
   procedure InitNew(aRemoteDesc: TncsFileDesc);
   function LocalControlFileName: AnsiString;
   function LocalPartialFileName: AnsiString;
   procedure SaveControl;
     {* ��������� ������ SaveControl }
   function LocalFileName: AnsiString;
 protected
 // realized methods
   procedure Execute(const aContext: TncsExecuteContext);
   function MakeExecutor(aMessage: TncsMessage): IncsExecutor;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
 public
 // public methods
   constructor Create(const aTransporter: IncsTransporter;
     const aTaskID: AnsiString;
     const aLocalPath: AnsiString;
     aRemoteDesc: TncsFileDesc); reintroduce;
   procedure CommitDelivery;
     {* ��������� ������ CommitDelivery }
   function DoProcess(aProgressor: TddProgressObject): Boolean; overload; 
 public
 // public properties
   property LocalDesc: TncsTaskedFileDesc
     read f_LocalDesc;
 end;//TncsOneFileDeliverer
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3FileUtils,
  SysUtils,
  l3Stream,
  l3Types,
  l3CRCUtils,
  ncsGetFilePartReply,
  ncsGetFilePart,
  Math,
  ncsPushFilePart,
  ncsMessageExecutorFactory,
  ncsProfile,
  l3Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

const
   { cFilesExtensions }
  cControlExt = '.control';
  cPartialExt = '.partial';

// start class TncsOneFileDeliverer

function TncsOneFileDeliverer.CheckContinue(aRemoteDesc: TncsFileDesc): Boolean;
//#UC START# *5473254E0090_546F3804032D_var*
var
 l_Stream: TStream;
//#UC END# *5473254E0090_546F3804032D_var*
begin
//#UC START# *5473254E0090_546F3804032D_impl*
 Result := False;
 if FileExists(LocalControlFileName) then
 begin
  l_Stream := Tl3FileStream.Create(LocalControlFileName, l3_fmRead);
  try
   f_LocalDesc.LoadFromEVD(l_Stream);
   Assert(f_LocalDesc.Name <> '');
  finally
   FreeAndNil(l_Stream);
  end;
  if not FileExists(LocalPartialFileName) then
   Exit;
  if f_LocalDesc.TaskID <> f_TaskID then
   Exit;
  if f_LocalDesc.CRC <> aRemoteDesc.CRC then
   Exit;
  if f_LocalDesc.DateTime <> aRemoteDesc.DateTime then
   Exit;
  if f_LocalDesc.Size <> aRemoteDesc.Size then
   Exit;
  Result := True;
 end
//#UC END# *5473254E0090_546F3804032D_impl*
end;//TncsOneFileDeliverer.CheckContinue

procedure TncsOneFileDeliverer.InitNew(aRemoteDesc: TncsFileDesc);
//#UC START# *5473255F03A1_546F3804032D_var*
var
 l_Stream: TStream;
//#UC END# *5473255F03A1_546F3804032D_var*
begin
//#UC START# *5473255F03A1_546F3804032D_impl*
 f_LocalDesc.TaskID := f_TaskID;
 f_LocalDesc.CopiedSize := 0;
 f_LocalDesc.CRC := aRemoteDesc.CRC;
 f_LocalDesc.Size := aRemoteDesc.Size;
 f_LocalDesc.DateTime := aRemoteDesc.DateTime;
 ForceDirectories(ExtractFilePath(LocalPartialFileName));
 l_Stream := Tl3FileStream.Create(LocalPartialFileName, l3_fmCreateReadWrite);
 try
  l_Stream.Size := f_LocalDesc.Size;
 finally
  FreeAndNil(l_Stream);
 end;
//#UC END# *5473255F03A1_546F3804032D_impl*
end;//TncsOneFileDeliverer.InitNew

function TncsOneFileDeliverer.LocalControlFileName: AnsiString;
//#UC START# *54732616034A_546F3804032D_var*
//#UC END# *54732616034A_546F3804032D_var*
begin
//#UC START# *54732616034A_546F3804032D_impl*
 Result := f_LocalPath + f_LocalDesc.Name + cControlExt;
//#UC END# *54732616034A_546F3804032D_impl*
end;//TncsOneFileDeliverer.LocalControlFileName

function TncsOneFileDeliverer.LocalPartialFileName: AnsiString;
//#UC START# *5473263D00AC_546F3804032D_var*
//#UC END# *5473263D00AC_546F3804032D_var*
begin
//#UC START# *5473263D00AC_546F3804032D_impl*
 Result := f_LocalPath + f_LocalDesc.Name + cPartialExt;
//#UC END# *5473263D00AC_546F3804032D_impl*
end;//TncsOneFileDeliverer.LocalPartialFileName

procedure TncsOneFileDeliverer.SaveControl;
//#UC START# *5474A3BD0077_546F3804032D_var*
var
 l_Stream: TStream;
//#UC END# *5474A3BD0077_546F3804032D_var*
begin
//#UC START# *5474A3BD0077_546F3804032D_impl*
 g_SaveControl.Start;
 try
  l_Stream := Tl3FileStream.Create(LocalControlFileName, l3_fmCreateReadWrite);
  try
   f_LocalDesc.SaveToEVD(l_Stream, nil);
  finally
   FreeAndNil(l_Stream);
  end;
 finally
  g_SaveControl.Stop;
 end; 
//#UC END# *5474A3BD0077_546F3804032D_impl*
end;//TncsOneFileDeliverer.SaveControl

function TncsOneFileDeliverer.LocalFileName: AnsiString;
//#UC START# *5474A7B201FC_546F3804032D_var*
//#UC END# *5474A7B201FC_546F3804032D_var*
begin
//#UC START# *5474A7B201FC_546F3804032D_impl*
 Result := f_LocalPath + f_LocalDesc.Name;
//#UC END# *5474A7B201FC_546F3804032D_impl*
end;//TncsOneFileDeliverer.LocalFileName

constructor TncsOneFileDeliverer.Create(const aTransporter: IncsTransporter;
  const aTaskID: AnsiString;
  const aLocalPath: AnsiString;
  aRemoteDesc: TncsFileDesc);
//#UC START# *546F389A0156_546F3804032D_var*
//#UC END# *546F389A0156_546F3804032D_var*
begin
//#UC START# *546F389A0156_546F3804032D_impl*
 inherited Create;
 f_Transporter := aTransporter;
 f_LocalPath := aLocalPath;
 f_LocalDesc := TncsTaskedFileDesc.Create;
 f_LocalDesc.Name := aRemoteDesc.Name;
 f_TaskID := aTaskID;
 if not CheckContinue(aRemoteDesc) then
  InitNew(aRemoteDesc);
//#UC END# *546F389A0156_546F3804032D_impl*
end;//TncsOneFileDeliverer.Create

procedure TncsOneFileDeliverer.CommitDelivery;
//#UC START# *5474A3D400D5_546F3804032D_var*
//#UC END# *5474A3D400D5_546F3804032D_var*
begin
//#UC START# *5474A3D400D5_546F3804032D_impl*
 RenameFileSafe(LocalPartialFileName, LocalFileName);
 if FileExists(LocalControlFileName) then
  DeleteFile(LocalControlFileName);
//#UC END# *5474A3D400D5_546F3804032D_impl*
end;//TncsOneFileDeliverer.CommitDelivery

function TncsOneFileDeliverer.DoProcess(aProgressor: TddProgressObject): Boolean;
//#UC START# *5472E6E201EE_546F3804032D_var*
var
 l_Message: TncsGetFilePart;
 l_RawReply: TncsMessage;

const
 cPartSize = 31*1024;
//#UC END# *5472E6E201EE_546F3804032D_var*
begin
//#UC START# *5472E6E201EE_546F3804032D_impl*
 aProgressor.SetRefTo(f_Progressor);
 try
  TncsMessageExecutorFactory.Instance.Register(Self);
  try
   Result := LocalDesc.CopiedSize = LocalDesc.Size;
   if Assigned(aProgressor) then
    aProgressor.IncProgress(LocalDesc.CopiedSize);
   if not Result then
   begin
    l_RawReply := nil;
    if not FileExists(LocalPartialFileName) then
     raise EInOutError.Create('File not found');
    f_Stream := Tl3FileStream.Create(LocalPartialFileName, l3_fmExclusiveReadWrite);
    try
     repeat
      if not f_Transporter.Processing then
      begin
       l3System.Msg2Log('������ �������� - ����� �����');
       Exit;
      end;
      l_Message := TncsGetFilePart.Create;
      try
       l_Message.TaskID := f_TaskID;
       l_Message.FileName := LocalDesc.Name;
       l_Message.Offset := LocalDesc.CopiedSize;
       l_Message.PartSize := Min(cPartSize, LocalDesc.Size - LocalDesc.CopiedSize);
       f_Transporter.Send(l_Message);
       FreeAndNil(l_RawReply);
       try
        g_WaitFile.Start;
        try
         if not f_Transporter.WaitForReply(l_Message, l_RawReply) then
         begin
          l3System.Msg2Log('������ �������� - �� ��������� ������ �� ������ �����');
          Exit;
         end;
        finally
         g_WaitFile.Stop;
        end;
        if not (l_RawReply is TncsGetFilePartReply) then
        begin
         l3System.Msg2Log('������ �������� - �������������� ����� �� ������ �����');
         Exit;
        end;
        if not TncsGetFilePartReply(l_RawReply).IsSuccess then
        begin
         l3System.Msg2Log('������ �������� - ���������� ����� �� ������ �����');
         Exit;
        end;
       finally
        FreeAndNil(l_RawReply);
       end;
      finally
       FreeAndNil(l_Message);
      end;
      if LocalDesc.CopiedSize = LocalDesc.Size then
      begin
       if (l3CalcCRC32(f_Stream) = LocalDesc.CRC) then
       begin
        Result := True;
        Break;
       end
       else
       begin
        LocalDesc.CopiedSize := 0;
        if Assigned(aProgressor) then
         aProgressor.IncProgress(-LocalDesc.Size);
        SaveControl;
       end;
      end
      else
       l3System.Msg2Log('�������� ������ - �������� ������ ����� ������� �� ������');
     until False;
    finally
     SaveControl;
     FreeAndNil(f_Stream);
    end;
   end;
  finally
   TncsMessageExecutorFactory.Instance.UnRegister(Self);
  end;
 finally
  FreeAndNil(f_Progressor);
 end;
//#UC END# *5472E6E201EE_546F3804032D_impl*
end;//TncsOneFileDeliverer.DoProcess

procedure TncsOneFileDeliverer.Execute(const aContext: TncsExecuteContext);
//#UC START# *54607DDC0159_546F3804032D_var*
var
 l_Message: TncsPushFilePart;
//#UC END# *54607DDC0159_546F3804032D_var*
begin
//#UC START# *54607DDC0159_546F3804032D_impl*
 g_ReceivePartFile.Start;
 try
  l_Message := aContext.rMessage as TncsPushFilePart;
  f_Stream.Seek(l_Message.Offset, soBeginning);
 g_WriteFile.Start;
  l_Message.Data.CopyTo(f_Stream, l_Message.PartSize);
 g_WriteFile.Stop;
  LocalDesc.CopiedSize := LocalDesc.CopiedSize + l_Message.PartSize;
//  SaveControl;
  if Assigned(f_Progressor) then
   f_Progressor.IncProgress(l_Message.PartSize);
 finally
  g_ReceivePartFile.Stop;
 end; 
//#UC END# *54607DDC0159_546F3804032D_impl*
end;//TncsOneFileDeliverer.Execute

function TncsOneFileDeliverer.MakeExecutor(aMessage: TncsMessage): IncsExecutor;
//#UC START# *546082B801F3_546F3804032D_var*
//#UC END# *546082B801F3_546F3804032D_var*
begin
//#UC START# *546082B801F3_546F3804032D_impl*
 if (aMessage is TncsPushFilePart) and (TncsPushFilePart(aMessage).TaskID = f_TaskID) and (TncsPushFilePart(aMessage).FileName = LocalDesc.Name) then
  Result := Self
 else
  Result := nil;
//#UC END# *546082B801F3_546F3804032D_impl*
end;//TncsOneFileDeliverer.MakeExecutor

procedure TncsOneFileDeliverer.Cleanup;
//#UC START# *479731C50290_546F3804032D_var*
//#UC END# *479731C50290_546F3804032D_var*
begin
//#UC START# *479731C50290_546F3804032D_impl*
 f_Transporter := nil;
 FreeAndNil(f_LocalDesc);
 inherited;
//#UC END# *479731C50290_546F3804032D_impl*
end;//TncsOneFileDeliverer.Cleanup

{$IfEnd} //not Nemesis

end.