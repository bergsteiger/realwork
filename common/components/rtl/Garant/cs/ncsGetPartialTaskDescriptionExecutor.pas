unit ncsGetPartialTaskDescriptionExecutor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsGetPartialTaskDescriptionExecutor.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::TaskSend::TncsGetPartialTaskDescriptionExecutor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject,
  ncsMessageInterfaces
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsGetPartialTaskDescriptionExecutor = class(Tl3ProtoObject, IncsExecutor)
 private
 // private fields
   f_FileName : AnsiString;
   f_BasePath : AnsiString;
 protected
 // realized methods
   procedure Execute(const aContext: TncsExecuteContext);
 public
 // public methods
   constructor Create(const aBasePath: AnsiString;
     const aFileName: AnsiString); reintroduce;
   class function Make(const aBasePath: AnsiString;
     const aFileName: AnsiString): IncsExecutor; reintroduce;
     {* Сигнатура фабрики TncsGetPartialTaskDescriptionExecutor.Make }
 end;//TncsGetPartialTaskDescriptionExecutor
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  ncsGetTaskDescriptionReply,
  ncsGetPartialTaskDescription,
  SysUtils,
  ncsFileDesc,
  l3Stream,
  Classes,
  l3Types,
  l3CRCUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsGetPartialTaskDescriptionExecutor

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
end;

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

{$IfEnd} //not Nemesis

end.