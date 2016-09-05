unit ncsGetFilePartExecutor;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsGetFilePartExecutor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsGetFilePartExecutor" MUID: (54B7B3D203C6)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , ncsMessageInterfaces
;

type
 TncsGetFilePartExecutor = class(Tl3ProtoObject, IncsExecutor)
  private
   f_FileName: AnsiString;
   f_BasePath: AnsiString;
  protected
   procedure Execute(const aContext: TncsExecuteContext);
  public
   constructor Create(const aBasePath: AnsiString;
    const aFileName: AnsiString); reintroduce;
   class function Make(const aBasePath: AnsiString;
    const aFileName: AnsiString): IncsExecutor; reintroduce;
 end;//TncsGetFilePartExecutor
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , ncsPushFilePart
 , Math
 , SysUtils
 , l3Types
 , Classes
 , l3Stream
 , ncsGetFilePartReply
 , ncsGetFilePart
 //#UC START# *54B7B3D203C6impl_uses*
 //#UC END# *54B7B3D203C6impl_uses*
;

constructor TncsGetFilePartExecutor.Create(const aBasePath: AnsiString;
 const aFileName: AnsiString);
//#UC START# *54B7B6E402A1_54B7B3D203C6_var*
//#UC END# *54B7B6E402A1_54B7B3D203C6_var*
begin
//#UC START# *54B7B6E402A1_54B7B3D203C6_impl*
 inherited Create;
 f_BasePath := aBasePath;
 f_FileName := aFileName;
//#UC END# *54B7B6E402A1_54B7B3D203C6_impl*
end;//TncsGetFilePartExecutor.Create

class function TncsGetFilePartExecutor.Make(const aBasePath: AnsiString;
 const aFileName: AnsiString): IncsExecutor;
var
 l_Inst : TncsGetFilePartExecutor;
begin
 l_Inst := Create(aBasePath, aFileName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TncsGetFilePartExecutor.Make

procedure TncsGetFilePartExecutor.Execute(const aContext: TncsExecuteContext);
//#UC START# *54607DDC0159_54B7B3D203C6_var*
var
 l_Message: TncsGetFilePart;
 l_Reply: TncsGetFilePartReply;
 l_Stream: TStream;
 l_FileName: AnsiString;
 l_ToCopyCount: Int64;
 l_PushMessage: TncsPushFilePart;
//#UC END# *54607DDC0159_54B7B3D203C6_var*
begin
//#UC START# *54607DDC0159_54B7B3D203C6_impl*
 l_Message := aContext.rMessage as TncsGetFilePart;
 l_Reply := TncsGetFilePartReply.Create(l_Message);
 try
  l_Reply.IsSuccess := False;
  l_FileName := {IncludeTrailingPathDelimiter(f_BasePath) + }f_FileName;
  if FileExists(l_FileName) then
  begin
   l_Stream := Tl3FileStream.Create(l_FileName, l3_fmRead);
   try
    if l_Stream.Size < (l_Message.Offset + l_Message.PartSize) then
     Exit;
    if l_Message.PartSize < 0 then
     Exit;
    l_Stream.Seek(l_Message.Offset, soBeginning);
    l_ToCopyCount := l_Stream.Size - l_Message.Offset;
    while l_ToCopyCount > 0 do
    begin
     if not aContext.rTransporter.Processing then
      Exit;
     l_PushMessage := TncsPushFilePart.Create;
     try
      l_PushMessage.TaskID := l_Message.TaskID;
      l_PushMessage.FileName := l_Message.FileName;
      l_PushMessage.Offset := l_Stream.Position;
      l_PushMessage.PartSize := Min(l_Message.PartSize, l_ToCopyCount);
      l_PushMessage.Data.CopyFrom(l_Stream, l_PushMessage.PartSize);
      aContext.rTransporter.Send(l_PushMessage);
      Dec(l_ToCopyCount, l_PushMessage.PartSize);
     finally
      FreeAndNil(l_PushMessage);
     end;
    end;
    l_Reply.IsSuccess := True;
   finally
    FreeAndNil(l_Stream);
   end;
  end;
  aContext.rTransporter.Send(l_Reply);
 finally
  FreeAndNil(l_Reply);
 end;
//#UC END# *54607DDC0159_54B7B3D203C6_impl*
end;//TncsGetFilePartExecutor.Execute
{$IfEnd} // NOT Defined(Nemesis)

end.
