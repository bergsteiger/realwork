unit ncsGetPartialTaskDescriptionExecutor;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsGetPartialTaskDescriptionExecutor.pas"
// Стереотип: "SimpleClass"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , ncsMessageInterfaces
;

type
 TncsGetPartialTaskDescriptionExecutor = class(Tl3ProtoObject, IncsExecutor)
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
 end;//TncsGetPartialTaskDescriptionExecutor
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , ncsGetTaskDescriptionReply
 , ncsGetPartialTaskDescription
 , SysUtils
 , ncsFileDesc
 , l3Stream
 , Classes
 , l3Types
 , l3CRCUtils
;

constructor TncsGetPartialTaskDescriptionExecutor.Create(const aBasePath: AnsiString;
 const aFileName: AnsiString);
//#UC START# *54B7B6C70011_54B7B37003C6_var*
//#UC END# *54B7B6C70011_54B7B37003C6_var*
begin
//#UC START# *54B7B6C70011_54B7B37003C6_impl*
 inherited Create;
 f_BasePath := aBasePath;
 f_FileName := aFileName;
//#UC END# *54B7B6C70011_54B7B37003C6_impl*
end;//TncsGetPartialTaskDescriptionExecutor.Create

class function TncsGetPartialTaskDescriptionExecutor.Make(const aBasePath: AnsiString;
 const aFileName: AnsiString): IncsExecutor;
var
 l_Inst : TncsGetPartialTaskDescriptionExecutor;
begin
 l_Inst := Create(aBasePath, aFileName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TncsGetPartialTaskDescriptionExecutor.Make

procedure TncsGetPartialTaskDescriptionExecutor.Execute(const aContext: TncsExecuteContext);
//#UC START# *54607DDC0159_54B7B37003C6_var*
var
 l_Reply: TncsGetTaskDescriptionReply;
 l_Message: TncsGetPartialTaskDescription;
 l_FileDesc: TncsFileDesc;
 l_Stream: TStream;
//#UC END# *54607DDC0159_54B7B37003C6_var*
begin
//#UC START# *54607DDC0159_54B7B37003C6_impl*
 l_Message := (aContext.rMessage as TncsGetPartialTaskDescription);
 l_Reply := TncsGetTaskDescriptionReply.Create(aContext.rMessage);
 l_Reply.RemoteFolder := IncludeTrailingPathDelimiter(f_BasePath);
 try
  l_FileDesc := TncsFileDesc.Create;
  try
   l_FileDesc.Name := ExtractRelativePath(f_BasePath, f_FileName);
   l_FileDesc.DateTime := FileAge(f_FileName);
   l_Stream := Tl3FileStream.Create(f_FileName, l3_fmRead);
   try
    l_FileDesc.Size := l_Stream.Size;
    l_FileDesc.CRC := l3CalcCRC32(l_Stream);
   finally
    FreeAndNil(l_Stream);
   end;
   l_Reply.FileDesc.Add(l_FileDesc.TaggedData);
  finally
   FreeAndNil(l_FileDesc);
  end;
  aContext.rTransporter.Send(l_Reply);
 finally
  FreeAndNil(l_Reply);
 end;
//#UC END# *54607DDC0159_54B7B37003C6_impl*
end;//TncsGetPartialTaskDescriptionExecutor.Execute
{$IfEnd} // NOT Defined(Nemesis)

end.
