unit FileProcessingPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Axiomatics"
// ������: "FileProcessingPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$Axiomatics::FileProcessing::FileProcessingPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3Interfaces,
  l3Types,
  l3Filer,
  l3CProtoObject,
  tfwScriptingInterfaces,
  tfwRegisterableWord,
  tfwWordWorkerEx,
  tfwAxiomaticsResNameGetter,
  tfwTypeInfo,
  tfwClassLike,
  tfwGlobalKeyWord
  ;

type
 TtfwFile = class(Tl3CProtoObject, ItfwFile)
 private
 // private fields
   f_Filer : Tl3CustomDosFiler;
 protected
 // realized methods
   function ReadLn: Il3CString;
   procedure WriteLn(const aString: Il3CString);
   procedure WriteChar(aChar: AnsiChar);
   function ReadWStrLn: Tl3WString;
   procedure WriteWStrLn(const aStr: Tl3WString);
   procedure WriteWStr(const aStr: Tl3WString);
   function EOF: Boolean;
 public
 // realized methods
   procedure ForEach(aLambda: TtfwWordPrim;
     const aCtx: TtfwContext);
   procedure ForEachBack(aLambda: TtfwWordPrim;
     const aCtx: TtfwContext);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
 public
 // public methods
   constructor CreateRead(const aFileName: AnsiString);
   constructor CreateWrite(const aFileName: AnsiString);
   class function MakeRead(const aFileName: AnsiString): ItfwFile; reintroduce;
     {* ��������� ������� TtfwFile.MakeRead }
   class function MakeWrite(const aFileName: AnsiString): ItfwFile; reintroduce;
     {* ��������� ������� TtfwFile.MakeWrite }
 end;//TtfwFile
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  SysUtils,
  l3String,
  l3FileUtils,
  l3Base,
  tfwScriptingTypes,
  TypInfo,
  tfwTypeRegistrator
  ;

type
//#UC START# *23408B0EC0B1ci*
//#UC END# *23408B0EC0B1ci*
//#UC START# *23408B0EC0B1cit*
//#UC END# *23408B0EC0B1cit*
 TFileProcessingPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
 public
 // realized methods
   class function ResName: AnsiString; override;
//#UC START# *23408B0EC0B1publ*
//#UC END# *23408B0EC0B1publ*
 end;//TFileProcessingPackResNameGetter

// start class TFileProcessingPackResNameGetter

class function TFileProcessingPackResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'FileProcessingPack';
end;//TFileProcessingPackResNameGetter.ResName

 {$R FileProcessingPack.res}

type
 TkwFileOpenRead = {final scriptword} class(TtfwRegisterableWord)
  {* ����� ������� File:OpenRead
*��� ����������:* ItfwFile
*������:*
[code]
FILE VAR l_ItfwFile
 aName File:OpenRead >>> l_ItfwFile
[code]  }
 private
 // private methods
   function OpenRead(const aCtx: TtfwContext;
    const aName: AnsiString): ItfwFile;
     {* ���������� ����� ������� File:OpenRead }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileOpenRead

// start class TkwFileOpenRead

function TkwFileOpenRead.OpenRead(const aCtx: TtfwContext;
  const aName: AnsiString): ItfwFile;
//#UC START# *1138E576E816_E10DA0D7493D_var*
//#UC END# *1138E576E816_E10DA0D7493D_var*
begin
//#UC START# *1138E576E816_E10DA0D7493D_impl*
 Result := TtfwFile.MakeRead(aCtx.rCaller.ResolveInputFilePath(aName));
//#UC END# *1138E576E816_E10DA0D7493D_impl*
end;//TkwFileOpenRead.OpenRead

procedure TkwFileOpenRead.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aName : AnsiString;
begin
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushFile((OpenRead(aCtx, l_aName)));
end;//TkwFileOpenRead.DoDoIt

class function TkwFileOpenRead.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'File:OpenRead';
end;//TkwFileOpenRead.GetWordNameForRegister

function TkwFileOpenRead.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwFile);
end;//TkwFileOpenRead.GetResultTypeInfo

function TkwFileOpenRead.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwFileOpenRead.GetAllParamsCount

function TkwFileOpenRead.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(AnsiString)]);
end;//TkwFileOpenRead.ParamsTypes

type
 TkwFileOpenWrite = {final scriptword} class(TtfwRegisterableWord)
  {* ����� ������� File:OpenWrite
*��� ����������:* ItfwFile
*������:*
[code]
FILE VAR l_ItfwFile
 aName File:OpenWrite >>> l_ItfwFile
[code]  }
 private
 // private methods
   function OpenWrite(const aCtx: TtfwContext;
    const aName: AnsiString): ItfwFile;
     {* ���������� ����� ������� File:OpenWrite }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileOpenWrite

// start class TkwFileOpenWrite

function TkwFileOpenWrite.OpenWrite(const aCtx: TtfwContext;
  const aName: AnsiString): ItfwFile;
//#UC START# *C3A7BCE24C3B_1CA3472F7177_var*
//#UC END# *C3A7BCE24C3B_1CA3472F7177_var*
begin
//#UC START# *C3A7BCE24C3B_1CA3472F7177_impl*
 Result := TtfwFile.MakeWrite(aCtx.rCaller.ResolveOutputFilePath(aName));
//#UC END# *C3A7BCE24C3B_1CA3472F7177_impl*
end;//TkwFileOpenWrite.OpenWrite

procedure TkwFileOpenWrite.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aName : AnsiString;
begin
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushFile((OpenWrite(aCtx, l_aName)));
end;//TkwFileOpenWrite.DoDoIt

class function TkwFileOpenWrite.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'File:OpenWrite';
end;//TkwFileOpenWrite.GetWordNameForRegister

function TkwFileOpenWrite.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwFile);
end;//TkwFileOpenWrite.GetResultTypeInfo

function TkwFileOpenWrite.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwFileOpenWrite.GetAllParamsCount

function TkwFileOpenWrite.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(AnsiString)]);
end;//TkwFileOpenWrite.ParamsTypes

type
 TkwFileEOF = {final scriptword} class(TtfwClassLike)
  {* ����� ������� File:EOF
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aFile File:EOF >>> l_Boolean
[code]  }
 private
 // private methods
   function EOF(const aCtx: TtfwContext;
    const aFile: ItfwFile): Boolean;
     {* ���������� ����� ������� File:EOF }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileEOF

// start class TkwFileEOF

function TkwFileEOF.EOF(const aCtx: TtfwContext;
  const aFile: ItfwFile): Boolean;
//#UC START# *509E2E3CFD11_2B33C78BBAB9_var*
//#UC END# *509E2E3CFD11_2B33C78BBAB9_var*
begin
//#UC START# *509E2E3CFD11_2B33C78BBAB9_impl*
 Result := aFile.EOF;
//#UC END# *509E2E3CFD11_2B33C78BBAB9_impl*
end;//TkwFileEOF.EOF

procedure TkwFileEOF.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aFile : ItfwFile;
begin
 try
  l_aFile := aCtx.rEngine.PopFile;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFile: ItfwFile : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((EOF(aCtx, l_aFile)));
end;//TkwFileEOF.DoDoIt

class function TkwFileEOF.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'File:EOF';
end;//TkwFileEOF.GetWordNameForRegister

function TkwFileEOF.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwFileEOF.GetResultTypeInfo

function TkwFileEOF.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwFileEOF.GetAllParamsCount

function TkwFileEOF.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile)]);
end;//TkwFileEOF.ParamsTypes

type
 TkwFileReadLn = {final scriptword} class(TtfwClassLike)
  {* ����� ������� File:ReadLn
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aFile File:ReadLn >>> l_Il3CString
[code]  }
 private
 // private methods
   function ReadLn(const aCtx: TtfwContext;
    const aFile: ItfwFile): Il3CString;
     {* ���������� ����� ������� File:ReadLn }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileReadLn

// start class TkwFileReadLn

function TkwFileReadLn.ReadLn(const aCtx: TtfwContext;
  const aFile: ItfwFile): Il3CString;
//#UC START# *47F929C35E76_324E0BCF3B98_var*
//#UC END# *47F929C35E76_324E0BCF3B98_var*
begin
//#UC START# *47F929C35E76_324E0BCF3B98_impl*
 Result := aFile.ReadLn;
//#UC END# *47F929C35E76_324E0BCF3B98_impl*
end;//TkwFileReadLn.ReadLn

procedure TkwFileReadLn.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aFile : ItfwFile;
begin
 try
  l_aFile := aCtx.rEngine.PopFile;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFile: ItfwFile : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((ReadLn(aCtx, l_aFile)));
end;//TkwFileReadLn.DoDoIt

class function TkwFileReadLn.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'File:ReadLn';
end;//TkwFileReadLn.GetWordNameForRegister

function TkwFileReadLn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwFileReadLn.GetResultTypeInfo

function TkwFileReadLn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwFileReadLn.GetAllParamsCount

function TkwFileReadLn.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile)]);
end;//TkwFileReadLn.ParamsTypes

type
 TkwFileWriteLn = {final scriptword} class(TtfwClassLike)
  {* ����� ������� File:WriteLn
*������:*
[code]
 aValue aFile File:WriteLn
[code]  }
 private
 // private methods
   procedure WriteLn(const aCtx: TtfwContext;
    const aFile: ItfwFile;
    const aValue: Il3CString);
     {* ���������� ����� ������� File:WriteLn }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileWriteLn

// start class TkwFileWriteLn

procedure TkwFileWriteLn.WriteLn(const aCtx: TtfwContext;
  const aFile: ItfwFile;
  const aValue: Il3CString);
//#UC START# *7E6964328B7F_D6A86D931B42_var*
//#UC END# *7E6964328B7F_D6A86D931B42_var*
begin
//#UC START# *7E6964328B7F_D6A86D931B42_impl*
 aFile.WriteLn(aValue);
//#UC END# *7E6964328B7F_D6A86D931B42_impl*
end;//TkwFileWriteLn.WriteLn

procedure TkwFileWriteLn.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aFile : ItfwFile;
 l_aValue : Il3CString;
begin
 try
  l_aFile := aCtx.rEngine.PopFile;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFile: ItfwFile : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 WriteLn(aCtx, l_aFile, l_aValue);
end;//TkwFileWriteLn.DoDoIt

class function TkwFileWriteLn.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'File:WriteLn';
end;//TkwFileWriteLn.GetWordNameForRegister

function TkwFileWriteLn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwFileWriteLn.GetResultTypeInfo

function TkwFileWriteLn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwFileWriteLn.GetAllParamsCount

function TkwFileWriteLn.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile), @tfw_tiString]);
end;//TkwFileWriteLn.ParamsTypes

type
 TkwFileWriteChar = {final scriptword} class(TtfwClassLike)
  {* ����� ������� File:WriteChar
*������:*
[code]
 aValue aFile File:WriteChar
[code]  }
 private
 // private methods
   procedure WriteChar(const aCtx: TtfwContext;
    const aFile: ItfwFile;
    aValue: AnsiChar);
     {* ���������� ����� ������� File:WriteChar }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileWriteChar

// start class TkwFileWriteChar

procedure TkwFileWriteChar.WriteChar(const aCtx: TtfwContext;
  const aFile: ItfwFile;
  aValue: AnsiChar);
//#UC START# *8B2200CCBE22_B530B64F8857_var*
//#UC END# *8B2200CCBE22_B530B64F8857_var*
begin
//#UC START# *8B2200CCBE22_B530B64F8857_impl*
 aFile.WriteChar(aValue);
//#UC END# *8B2200CCBE22_B530B64F8857_impl*
end;//TkwFileWriteChar.WriteChar

procedure TkwFileWriteChar.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aFile : ItfwFile;
 l_aValue : AnsiChar;
begin
 try
  l_aFile := aCtx.rEngine.PopFile;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFile: ItfwFile : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.PopChar;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: AnsiChar : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 WriteChar(aCtx, l_aFile, l_aValue);
end;//TkwFileWriteChar.DoDoIt

class function TkwFileWriteChar.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'File:WriteChar';
end;//TkwFileWriteChar.GetWordNameForRegister

function TkwFileWriteChar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwFileWriteChar.GetResultTypeInfo

function TkwFileWriteChar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwFileWriteChar.GetAllParamsCount

function TkwFileWriteChar.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile), TypeInfo(AnsiChar)]);
end;//TkwFileWriteChar.ParamsTypes

type
 TkwFileWriteStr = {final scriptword} class(TtfwClassLike)
  {* ����� ������� File:WriteStr
*������:*
[code]
 aValue aFile File:WriteStr
[code]  }
 private
 // private methods
   procedure WriteStr(const aCtx: TtfwContext;
    const aFile: ItfwFile;
    const aValue: Il3CString);
     {* ���������� ����� ������� File:WriteStr }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileWriteStr

// start class TkwFileWriteStr

procedure TkwFileWriteStr.WriteStr(const aCtx: TtfwContext;
  const aFile: ItfwFile;
  const aValue: Il3CString);
//#UC START# *BF1D3E215CF5_0016E31D4F5B_var*
//#UC END# *BF1D3E215CF5_0016E31D4F5B_var*
begin
//#UC START# *BF1D3E215CF5_0016E31D4F5B_impl*
 aFile.WriteWStr(l3PCharLen(aValue));
//#UC END# *BF1D3E215CF5_0016E31D4F5B_impl*
end;//TkwFileWriteStr.WriteStr

procedure TkwFileWriteStr.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aFile : ItfwFile;
 l_aValue : Il3CString;
begin
 try
  l_aFile := aCtx.rEngine.PopFile;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFile: ItfwFile : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 WriteStr(aCtx, l_aFile, l_aValue);
end;//TkwFileWriteStr.DoDoIt

class function TkwFileWriteStr.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'File:WriteStr';
end;//TkwFileWriteStr.GetWordNameForRegister

function TkwFileWriteStr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwFileWriteStr.GetResultTypeInfo

function TkwFileWriteStr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwFileWriteStr.GetAllParamsCount

function TkwFileWriteStr.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile), @tfw_tiString]);
end;//TkwFileWriteStr.ParamsTypes

type
 TkwFileReadLines = {final scriptword} class(TtfwWordWorkerEx)
  {* ����� ������� File:ReadLines
*������:*
[code]
 aFile File:ReadLines aWord
[code]  }
 private
 // private methods
   procedure ReadLines(const aCtx: TtfwContext;
    aWord: TtfwWord;
    const aFile: ItfwFile);
     {* ���������� ����� ������� File:ReadLines }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure DoRun(const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileReadLines

// start class TkwFileReadLines

procedure TkwFileReadLines.ReadLines(const aCtx: TtfwContext;
  aWord: TtfwWord;
  const aFile: ItfwFile);
//#UC START# *B66526463736_4D96B2094588_var*
//#UC END# *B66526463736_4D96B2094588_var*
begin
//#UC START# *B66526463736_4D96B2094588_impl*
 aFile.ForEach(aWord, aCtx);
//#UC END# *B66526463736_4D96B2094588_impl*
end;//TkwFileReadLines.ReadLines

class function TkwFileReadLines.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'File:ReadLines';
end;//TkwFileReadLines.GetWordNameForRegister

function TkwFileReadLines.RightParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwFileReadLines.RightParamsCount

procedure TkwFileReadLines.DoRun(const aCtx: TtfwContext);
 {-}
var
 l_aWord : TtfwWord;
 l_aFile : ItfwFile;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFile := aCtx.rEngine.PopFile;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFile: ItfwFile : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ReadLines(aCtx, l_aWord, l_aFile);
end;//TkwFileReadLines.DoRun

function TkwFileReadLines.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwFileReadLines.GetResultTypeInfo

function TkwFileReadLines.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1 + 1;
end;//TkwFileReadLines.GetAllParamsCount

function TkwFileReadLines.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), TypeInfo(ItfwFile)]);
end;//TkwFileReadLines.ParamsTypes

type
 TkwFileWriteWStr = {final scriptword} class(TtfwClassLike)
  {* ����� ������� File:WriteWStr
*������:*
[code]
 aValue aFile File:WriteWStr
[code]  }
 private
 // private methods
   procedure WriteWStr(const aCtx: TtfwContext;
    const aFile: ItfwFile;
    const aValue: TtfwStackValue);
     {* ���������� ����� ������� File:WriteWStr }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileWriteWStr

// start class TkwFileWriteWStr

procedure TkwFileWriteWStr.WriteWStr(const aCtx: TtfwContext;
  const aFile: ItfwFile;
  const aValue: TtfwStackValue);
//#UC START# *EA5DBDC19650_12D9E8420555_var*
//#UC END# *EA5DBDC19650_12D9E8420555_var*
begin
//#UC START# *EA5DBDC19650_12D9E8420555_impl*
 Case aValue.rType of
  tfw_vtStr:
   aFile.WriteWStr(aValue.AsString.AsWStr);
(*  tfw_vtWStr:
   aFile.WriteWStr(aValue.AsWString);*)
  else
   BadValueType(aValue.rType, aCtx);
 end;//Case aValue.rType
//#UC END# *EA5DBDC19650_12D9E8420555_impl*
end;//TkwFileWriteWStr.WriteWStr

procedure TkwFileWriteWStr.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aFile : ItfwFile;
 l_aValue : TtfwStackValue;
begin
 try
  l_aFile := aCtx.rEngine.PopFile;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFile: ItfwFile : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 WriteWStr(aCtx, l_aFile, l_aValue);
end;//TkwFileWriteWStr.DoDoIt

class function TkwFileWriteWStr.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'File:WriteWStr';
end;//TkwFileWriteWStr.GetWordNameForRegister

function TkwFileWriteWStr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwFileWriteWStr.GetResultTypeInfo

function TkwFileWriteWStr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwFileWriteWStr.GetAllParamsCount

function TkwFileWriteWStr.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile), @tfw_tiStruct]);
end;//TkwFileWriteWStr.ParamsTypes

type
 TkwFileReadWStrLn = {final scriptword} class(TtfwClassLike)
  {* ����� ������� File:ReadWStrLn
*��� ����������:* Tl3PCharLen
*������:*
[code]
W-STRING VAR l_Tl3PCharLen
 aFile File:ReadWStrLn >>> l_Tl3PCharLen
[code]  }
 private
 // private methods
   function ReadWStrLn(const aCtx: TtfwContext;
    const aFile: ItfwFile): Tl3PCharLen;
     {* ���������� ����� ������� File:ReadWStrLn }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileReadWStrLn

// start class TkwFileReadWStrLn

function TkwFileReadWStrLn.ReadWStrLn(const aCtx: TtfwContext;
  const aFile: ItfwFile): Tl3PCharLen;
//#UC START# *062B42A458F5_6F89E50D4B41_var*
//#UC END# *062B42A458F5_6F89E50D4B41_var*
begin
//#UC START# *062B42A458F5_6F89E50D4B41_impl*
 Result := Tl3PCharLen(aFile.ReadWStrLn);
//#UC END# *062B42A458F5_6F89E50D4B41_impl*
end;//TkwFileReadWStrLn.ReadWStrLn

procedure TkwFileReadWStrLn.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aFile : ItfwFile;
begin
 try
  l_aFile := aCtx.rEngine.PopFile;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFile: ItfwFile : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushWStr((ReadWStrLn(aCtx, l_aFile)));
end;//TkwFileReadWStrLn.DoDoIt

class function TkwFileReadWStrLn.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'File:ReadWStrLn';
end;//TkwFileReadWStrLn.GetWordNameForRegister

function TkwFileReadWStrLn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiWString;
end;//TkwFileReadWStrLn.GetResultTypeInfo

function TkwFileReadWStrLn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwFileReadWStrLn.GetAllParamsCount

function TkwFileReadWStrLn.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile)]);
end;//TkwFileReadWStrLn.ParamsTypes

type
 TkwFileWriteWStrLn = {final scriptword} class(TtfwClassLike)
  {* ����� ������� File:WriteWStrLn
*������:*
[code]
 aValue aFile File:WriteWStrLn
[code]  }
 private
 // private methods
   procedure WriteWStrLn(const aCtx: TtfwContext;
    const aFile: ItfwFile;
    const aValue: TtfwStackValue);
     {* ���������� ����� ������� File:WriteWStrLn }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileWriteWStrLn

// start class TkwFileWriteWStrLn

procedure TkwFileWriteWStrLn.WriteWStrLn(const aCtx: TtfwContext;
  const aFile: ItfwFile;
  const aValue: TtfwStackValue);
//#UC START# *5BB0C2B29FB4_2C287EC9B0C3_var*
//#UC END# *5BB0C2B29FB4_2C287EC9B0C3_var*
begin
//#UC START# *5BB0C2B29FB4_2C287EC9B0C3_impl*
 Case aValue.rType of
  tfw_vtStr:
   aFile.WriteWStrLn(aValue.AsString.AsWStr);
(*  tfw_vtWStr:
   aFile.WriteWStrLn(aValue.AsWString);*)
  else
   BadValueType(aValue.rType, aCtx);
 end;//Case aValue.rType
//#UC END# *5BB0C2B29FB4_2C287EC9B0C3_impl*
end;//TkwFileWriteWStrLn.WriteWStrLn

procedure TkwFileWriteWStrLn.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aFile : ItfwFile;
 l_aValue : TtfwStackValue;
begin
 try
  l_aFile := aCtx.rEngine.PopFile;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFile: ItfwFile : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 WriteWStrLn(aCtx, l_aFile, l_aValue);
end;//TkwFileWriteWStrLn.DoDoIt

class function TkwFileWriteWStrLn.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'File:WriteWStrLn';
end;//TkwFileWriteWStrLn.GetWordNameForRegister

function TkwFileWriteWStrLn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwFileWriteWStrLn.GetResultTypeInfo

function TkwFileWriteWStrLn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwFileWriteWStrLn.GetAllParamsCount

function TkwFileWriteWStrLn.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile), @tfw_tiStruct]);
end;//TkwFileWriteWStrLn.ParamsTypes

type
 TkwDeleteFile = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� DeleteFile
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aName DeleteFile >>> l_Boolean
[code]  }
 private
 // private methods
   function DeleteFile(const aCtx: TtfwContext;
    const aName: AnsiString): Boolean;
     {* ���������� ����� ������� DeleteFile }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDeleteFile

// start class TkwDeleteFile

function TkwDeleteFile.DeleteFile(const aCtx: TtfwContext;
  const aName: AnsiString): Boolean;
//#UC START# *8A54E0B1468F_01A4D246A0C9_var*
//#UC END# *8A54E0B1468F_01A4D246A0C9_var*
begin
//#UC START# *8A54E0B1468F_01A4D246A0C9_impl*
 Result := SysUtils.DeleteFile(aName);
//#UC END# *8A54E0B1468F_01A4D246A0C9_impl*
end;//TkwDeleteFile.DeleteFile

procedure TkwDeleteFile.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aName : AnsiString;
begin
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((DeleteFile(aCtx, l_aName)));
end;//TkwDeleteFile.DoDoIt

class function TkwDeleteFile.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'DeleteFile';
end;//TkwDeleteFile.GetWordNameForRegister

function TkwDeleteFile.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwDeleteFile.GetResultTypeInfo

function TkwDeleteFile.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwDeleteFile.GetAllParamsCount

function TkwDeleteFile.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(AnsiString)]);
end;//TkwDeleteFile.ParamsTypes

type
 TkwRenameFile = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� RenameFile
[panel]RenameFile - ��������������� ����.
*������:* aOldFileName aNewFileName RenameFile
* aNewFileName - ����� ��� �����.
* aOldFileName - ������ ��� �����.
� ���� ���������� ��������� ��������: true - ���� �������, false - ���� �������������� �� ����������.[panel]
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 anOldName aNewName RenameFile >>> l_Boolean
[code]  }
 private
 // private methods
   function RenameFile(const aCtx: TtfwContext;
    const aNewName: AnsiString;
    const anOldName: AnsiString): Boolean;
     {* ���������� ����� ������� RenameFile }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRenameFile

// start class TkwRenameFile

function TkwRenameFile.RenameFile(const aCtx: TtfwContext;
  const aNewName: AnsiString;
  const anOldName: AnsiString): Boolean;
//#UC START# *4B30612C1E84_269C162F0F47_var*
//#UC END# *4B30612C1E84_269C162F0F47_var*
begin
//#UC START# *4B30612C1E84_269C162F0F47_impl*
 Result := SysUtils.RenameFile(anOldName, aNewName);
//#UC END# *4B30612C1E84_269C162F0F47_impl*
end;//TkwRenameFile.RenameFile

procedure TkwRenameFile.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aNewName : AnsiString;
 l_anOldName : AnsiString;
begin
 try
  l_aNewName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOldName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anOldName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((RenameFile(aCtx, l_aNewName, l_anOldName)));
end;//TkwRenameFile.DoDoIt

class function TkwRenameFile.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'RenameFile';
end;//TkwRenameFile.GetWordNameForRegister

function TkwRenameFile.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwRenameFile.GetResultTypeInfo

function TkwRenameFile.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwRenameFile.GetAllParamsCount

function TkwRenameFile.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(AnsiString), TypeInfo(AnsiString)]);
end;//TkwRenameFile.ParamsTypes

type
 TkwCopyFilesByMask = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� CopyFilesByMask
[panel]CopyFilesByMask- �������� ����� �� �����..
*������:* 
[code]
 aFileMask aDestDir aSourceDir  CopyFilesByMask
[code]
* aSourceDir - ���������� ������ ��������.
* aDestDir - ���������� ���� ��������.
* aFileMask - �����, �� ������� �������� �����.
��������� ����� �� ����������. ���� ���������� ������, �� ����� Exception[panel]
*������:*
[code]
 aFileMask aDestDir aSourceDir CopyFilesByMask
[code]  }
 private
 // private methods
   procedure CopyFilesByMask(const aCtx: TtfwContext;
    const aSourceDir: AnsiString;
    const aDestDir: AnsiString;
    const aFileMask: AnsiString);
     {* ���������� ����� ������� CopyFilesByMask }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCopyFilesByMask

// start class TkwCopyFilesByMask

procedure TkwCopyFilesByMask.CopyFilesByMask(const aCtx: TtfwContext;
  const aSourceDir: AnsiString;
  const aDestDir: AnsiString;
  const aFileMask: AnsiString);
//#UC START# *B545E742BFBB_5478B1531C0E_var*
//#UC END# *B545E742BFBB_5478B1531C0E_var*
begin
//#UC START# *B545E742BFBB_5478B1531C0E_impl*
 l3FileUtils.CopyFilesByMask(aSourceDir, aDestDir, aFileMask);
//#UC END# *B545E742BFBB_5478B1531C0E_impl*
end;//TkwCopyFilesByMask.CopyFilesByMask

procedure TkwCopyFilesByMask.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSourceDir : AnsiString;
 l_aDestDir : AnsiString;
 l_aFileMask : AnsiString;
begin
 try
  l_aSourceDir := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSourceDir: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDestDir := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDestDir: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFileMask := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFileMask: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CopyFilesByMask(aCtx, l_aSourceDir, l_aDestDir, l_aFileMask);
end;//TkwCopyFilesByMask.DoDoIt

class function TkwCopyFilesByMask.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'CopyFilesByMask';
end;//TkwCopyFilesByMask.GetWordNameForRegister

function TkwCopyFilesByMask.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCopyFilesByMask.GetResultTypeInfo

function TkwCopyFilesByMask.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 3;
end;//TkwCopyFilesByMask.GetAllParamsCount

function TkwCopyFilesByMask.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(AnsiString), TypeInfo(AnsiString), TypeInfo(AnsiString)]);
end;//TkwCopyFilesByMask.ParamsTypes

type
 TkwCopyFile = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� CopyFile
[panel]CopyFile - �������� ����.
*������:*  aCopyMode aDestFile aSourceFile CopyFile
* aSourceFile - ��� ��������� �����
* aDestFile - ��� �����, ���� ��������
* aCopyMode - ����� ����������� �����.
��������� ����� �� ����������. ���� ���������� ������, �� ����� Exception[panel]
*������:*
[code]
 aCopyMode aDestFile aSourceFile CopyFile
[code]  }
 private
 // private methods
   procedure CopyFile(const aCtx: TtfwContext;
    const aSourceFile: AnsiString;
    const aDestFile: AnsiString;
    aCopyMode: Integer);
     {* ���������� ����� ������� CopyFile }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCopyFile

// start class TkwCopyFile

procedure TkwCopyFile.CopyFile(const aCtx: TtfwContext;
  const aSourceFile: AnsiString;
  const aDestFile: AnsiString;
  aCopyMode: Integer);
//#UC START# *7B442954EEE8_C4E46637B80B_var*
//#UC END# *7B442954EEE8_C4E46637B80B_var*
begin
//#UC START# *7B442954EEE8_C4E46637B80B_impl*
 l3FileUtils.CopyFile(aSourceFile, aDestFile, aCopyMode);
//#UC END# *7B442954EEE8_C4E46637B80B_impl*
end;//TkwCopyFile.CopyFile

procedure TkwCopyFile.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSourceFile : AnsiString;
 l_aDestFile : AnsiString;
 l_aCopyMode : Integer;
begin
 try
  l_aSourceFile := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSourceFile: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDestFile := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDestFile: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aCopyMode := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCopyMode: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CopyFile(aCtx, l_aSourceFile, l_aDestFile, l_aCopyMode);
end;//TkwCopyFile.DoDoIt

class function TkwCopyFile.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'CopyFile';
end;//TkwCopyFile.GetWordNameForRegister

function TkwCopyFile.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCopyFile.GetResultTypeInfo

function TkwCopyFile.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 3;
end;//TkwCopyFile.GetAllParamsCount

function TkwCopyFile.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(AnsiString), TypeInfo(AnsiString), TypeInfo(Integer)]);
end;//TkwCopyFile.ParamsTypes

type
 TkwPureDir = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� PureDir
[panel]PureDir - ������� ����������.
*������:* aDirName PureDir
* aDirName  - ��� ����������.[panel]
*������:*
[code]
 aName PureDir
[code]  }
 private
 // private methods
   procedure PureDir(const aCtx: TtfwContext;
    const aName: AnsiString);
     {* ���������� ����� ������� PureDir }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPureDir

// start class TkwPureDir

procedure TkwPureDir.PureDir(const aCtx: TtfwContext;
  const aName: AnsiString);
//#UC START# *4475F8181332_C77B92459A8E_var*
//#UC END# *4475F8181332_C77B92459A8E_var*
begin
//#UC START# *4475F8181332_C77B92459A8E_impl*
 l3FileUtils.PureDir(aName);
//#UC END# *4475F8181332_C77B92459A8E_impl*
end;//TkwPureDir.PureDir

procedure TkwPureDir.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aName : AnsiString;
begin
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 PureDir(aCtx, l_aName);
end;//TkwPureDir.DoDoIt

class function TkwPureDir.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'PureDir';
end;//TkwPureDir.GetWordNameForRegister

function TkwPureDir.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPureDir.GetResultTypeInfo

function TkwPureDir.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwPureDir.GetAllParamsCount

function TkwPureDir.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(AnsiString)]);
end;//TkwPureDir.ParamsTypes

type
 TkwDeleteFilesByMask = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� DeleteFilesByMask
[panel]DeleteFilesByMask - ������� ����������.
*������:* aMask aDirName DeleteFilesByMask
* aDirName  - ��� ����������.
* aMask - �����, �� ������� ���������� �����.[panel]
*������:*
[code]
 aMask aDirName DeleteFilesByMask
[code]  }
 private
 // private methods
   procedure DeleteFilesByMask(const aCtx: TtfwContext;
    const aDirName: AnsiString;
    const aMask: AnsiString);
     {* ���������� ����� ������� DeleteFilesByMask }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDeleteFilesByMask

// start class TkwDeleteFilesByMask

procedure TkwDeleteFilesByMask.DeleteFilesByMask(const aCtx: TtfwContext;
  const aDirName: AnsiString;
  const aMask: AnsiString);
//#UC START# *4757446F5D1B_E5B04DD6635F_var*
//#UC END# *4757446F5D1B_E5B04DD6635F_var*
begin
//#UC START# *4757446F5D1B_E5B04DD6635F_impl*
 l3FileUtils.DeleteFilesByMask(aDirName, aMask);
//#UC END# *4757446F5D1B_E5B04DD6635F_impl*
end;//TkwDeleteFilesByMask.DeleteFilesByMask

procedure TkwDeleteFilesByMask.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDirName : AnsiString;
 l_aMask : AnsiString;
begin
 try
  l_aDirName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDirName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aMask := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMask: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DeleteFilesByMask(aCtx, l_aDirName, l_aMask);
end;//TkwDeleteFilesByMask.DoDoIt

class function TkwDeleteFilesByMask.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'DeleteFilesByMask';
end;//TkwDeleteFilesByMask.GetWordNameForRegister

function TkwDeleteFilesByMask.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwDeleteFilesByMask.GetResultTypeInfo

function TkwDeleteFilesByMask.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwDeleteFilesByMask.GetAllParamsCount

function TkwDeleteFilesByMask.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(AnsiString), TypeInfo(AnsiString)]);
end;//TkwDeleteFilesByMask.ParamsTypes

type
 TkwProcessFilesWithMask = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� ProcessFilesWithMask
[panel]ProcessFilesWithMask - ���������� ����� �� ����� � �������� ���������� � �������� ��� ������� ���������� �������.
*������:*
aProc aFileMask aDirName ProcessFilesWithMask
* aProc - �������, ������� ���������� ��� ������� �����. � ���� ��� ������ ���������� ��� �����.
* aFileMask - �����, �� ������� ���������� �����, �������� '*.script'
* aDirName - ����, �� �������� ������ �����.
*������:*
[code]
: PrintFileName
 .
;

@ PrintFileName '*.script' 'w:\archi\source\projects\Archi\TestSet\Scripts\' ProcessFilesWithMask
[code]
� ���������� ����� ������ ���� � ���_�������.prn � ������� ������ � ������� ������.
*����������:* ���� �� ���� ���� �� ������, �� ������� �� ����� ������� �� ����. �� �����������, �� ������ �� �����, �� ����� ������ � ����� �� ��������. ����� �� ��������� ����������� �� �����������. ��� ����� ���������� � ������ �����.[panel]
*������:*
[code]
 aProc aFileMask aDirName ProcessFilesWithMask
[code]  }
 private
 // private methods
   procedure ProcessFilesWithMask(const aCtx: TtfwContext;
    const aDirName: AnsiString;
    const aFileMask: AnsiString;
    aProc: TtfwWord);
     {* ���������� ����� ������� ProcessFilesWithMask }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwProcessFilesWithMask

// start class TkwProcessFilesWithMask

procedure TkwProcessFilesWithMask.ProcessFilesWithMask(const aCtx: TtfwContext;
  const aDirName: AnsiString;
  const aFileMask: AnsiString;
  aProc: TtfwWord);
//#UC START# *332776E818ED_F43FC392309A_var*
var
 l_SearchRec  : TSearchRec;
 l_FindResult : Integer;
//#UC END# *332776E818ED_F43FC392309A_var*
begin
//#UC START# *332776E818ED_F43FC392309A_impl*
 if not DirectoryExists(aDirName) then
 begin
  Assert(False, Format('���������� %s �� ����������', [aDirName]));
  Exit;
 end; // if not DirectoryExists(aDirName) then
 l_FindResult := FindFirst(ConcatDirName(aDirName, aFileMask),
                           faAnyFile,
                           l_SearchRec);
 try
  while (l_FindResult = 0) do
  begin
   if (l_SearchRec.Attr and (faDirectory or faVolumeID or faSymLink)) = 0 then
   begin
    aCtx.rEngine.PushString(ConcatDirName(aDirName, l_SearchRec.Name));
    aProc.DoIt(aCtx);
   end; // if (l_SearchRec.Attr and (faDirectory or faVolumeID or faSymLink)) = 0 then
   l_FindResult := FindNext(l_SearchRec);
  end; // while l_FindResult = 0 do
 finally
  SysUtils.FindClose(l_SearchRec);
 end;//try..finally
//#UC END# *332776E818ED_F43FC392309A_impl*
end;//TkwProcessFilesWithMask.ProcessFilesWithMask

procedure TkwProcessFilesWithMask.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDirName : AnsiString;
 l_aFileMask : AnsiString;
 l_aProc : TtfwWord;
begin
 try
  l_aDirName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDirName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFileMask := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFileMask: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aProc := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord, true));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aProc: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ProcessFilesWithMask(aCtx, l_aDirName, l_aFileMask, l_aProc);
end;//TkwProcessFilesWithMask.DoDoIt

class function TkwProcessFilesWithMask.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ProcessFilesWithMask';
end;//TkwProcessFilesWithMask.GetWordNameForRegister

function TkwProcessFilesWithMask.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwProcessFilesWithMask.GetResultTypeInfo

function TkwProcessFilesWithMask.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 3;
end;//TkwProcessFilesWithMask.GetAllParamsCount

function TkwProcessFilesWithMask.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(AnsiString), TypeInfo(AnsiString), TypeInfo(TtfwWord)]);
end;//TkwProcessFilesWithMask.ParamsTypes

type
 TkwProcessSubDirs = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� ProcessSubDirs
[panel]ProcessSubDirs - ���������� ���������� � �������� ���������� � �������� ��� ������� ���������� �������.
*������:*
aProc aDirName ProcessSubDirs
* aProc - �������, ������� ���������� ��� ������ ����������. � ���� ��� ������ ���������� ��� ����������.
* aDirName - ����, �� �������� ������ ����������.
*������:*
[code]
: PrintFileName
 .
;

@ PrintFileName 'w:\archi\source\projects\Archi\TestSet\' ProcessSubDirs
[code]
� ���������� ����� ������ ���� � ���_�������.prn � ������� ���������� � ������� ������.
*����������:* ���� �� ���� ����������  �� �������, �� ������� �� ����� ������� �� ����.[panel]
*������:*
[code]
 aProc aDirName ProcessSubDirs
[code]  }
 private
 // private methods
   procedure ProcessSubDirs(const aCtx: TtfwContext;
    const aDirName: AnsiString;
    aProc: TtfwWord);
     {* ���������� ����� ������� ProcessSubDirs }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwProcessSubDirs

// start class TkwProcessSubDirs

procedure TkwProcessSubDirs.ProcessSubDirs(const aCtx: TtfwContext;
  const aDirName: AnsiString;
  aProc: TtfwWord);
//#UC START# *3A2CA042D20F_4D6340E72B1A_var*
var
 l_SearchRec : TSearchRec;
 l_FindResult: Integer;
//#UC END# *3A2CA042D20F_4D6340E72B1A_var*
begin
//#UC START# *3A2CA042D20F_4D6340E72B1A_impl*
 if not DirectoryExists(aDirName) then
 begin
  Assert(False, Format('���������� %s �� ����������', [aDirName]));
  Exit;
 end; // if not DirectoryExists(l_DirName) then
 l_FindResult := FindFirst(ConcatDirName(aDirName, '*.*'),
                           faDirectory ,
                           l_SearchRec);
 try
  while (l_FindResult = 0) do
  begin
   if ((l_SearchRec.Attr and faDirectory) <> 0) and (l_SearchRec.Name <> '.') and (l_SearchRec.Name <> '..') then
   begin
    aCtx.rEngine.PushString(ConcatDirName(aDirName, l_SearchRec.Name));
    aProc.DoIt(aCtx);
   end; // if (l_SearchRec.Attr and (faDirectory or faVolumeID or faSymLink)) = 0 then
   l_FindResult := FindNext(l_SearchRec);
  end; // while l_FindResult = 0 do
 finally
  SysUtils.FindClose(l_SearchRec);
 end;//try..finally
//#UC END# *3A2CA042D20F_4D6340E72B1A_impl*
end;//TkwProcessSubDirs.ProcessSubDirs

procedure TkwProcessSubDirs.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDirName : AnsiString;
 l_aProc : TtfwWord;
begin
 try
  l_aDirName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDirName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aProc := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord, true));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aProc: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ProcessSubDirs(aCtx, l_aDirName, l_aProc);
end;//TkwProcessSubDirs.DoDoIt

class function TkwProcessSubDirs.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ProcessSubDirs';
end;//TkwProcessSubDirs.GetWordNameForRegister

function TkwProcessSubDirs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwProcessSubDirs.GetResultTypeInfo

function TkwProcessSubDirs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwProcessSubDirs.GetAllParamsCount

function TkwProcessSubDirs.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(AnsiString), TypeInfo(TtfwWord)]);
end;//TkwProcessSubDirs.ParamsTypes
// start class TtfwFile

constructor TtfwFile.CreateRead(const aFileName: AnsiString);
//#UC START# *4F4FD849026C_4F4FD77B03CC_var*
//#UC END# *4F4FD849026C_4F4FD77B03CC_var*
begin
//#UC START# *4F4FD849026C_4F4FD77B03CC_impl*
 inherited Create;
 f_Filer := Tl3CustomDosFiler.Make(aFileName, l3_fmRead, false, 1000);
 f_Filer.Open;
//#UC END# *4F4FD849026C_4F4FD77B03CC_impl*
end;//TtfwFile.CreateRead

constructor TtfwFile.CreateWrite(const aFileName: AnsiString);
//#UC START# *4F4FD85F033A_4F4FD77B03CC_var*
//#UC END# *4F4FD85F033A_4F4FD77B03CC_var*
begin
//#UC START# *4F4FD85F033A_4F4FD77B03CC_impl*
 inherited Create;
 f_Filer := Tl3CustomDosFiler.Make(aFileName, l3_fmWrite, false, 1000);
 f_Filer.Open;
//#UC END# *4F4FD85F033A_4F4FD77B03CC_impl*
end;//TtfwFile.CreateWrite

class function TtfwFile.MakeRead(const aFileName: AnsiString): ItfwFile;
var
 l_Inst : TtfwFile;
begin
 l_Inst := CreateRead(aFileName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

class function TtfwFile.MakeWrite(const aFileName: AnsiString): ItfwFile;
var
 l_Inst : TtfwFile;
begin
 l_Inst := CreateWrite(aFileName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TtfwFile.ReadLn: Il3CString;
//#UC START# *4F4E4E7E0350_4F4FD77B03CC_var*
//#UC END# *4F4E4E7E0350_4F4FD77B03CC_var*
begin
//#UC START# *4F4E4E7E0350_4F4FD77B03CC_impl*
 Result := TtfwCStringFactory.C(f_Filer.ReadLn);
//#UC END# *4F4E4E7E0350_4F4FD77B03CC_impl*
end;//TtfwFile.ReadLn

procedure TtfwFile.WriteLn(const aString: Il3CString);
//#UC START# *4F4E4EA7007D_4F4FD77B03CC_var*
//#UC END# *4F4E4EA7007D_4F4FD77B03CC_var*
begin
//#UC START# *4F4E4EA7007D_4F4FD77B03CC_impl*
 f_Filer.WriteLn(l3PCharLen(aString));
//#UC END# *4F4E4EA7007D_4F4FD77B03CC_impl*
end;//TtfwFile.WriteLn

procedure TtfwFile.WriteChar(aChar: AnsiChar);
//#UC START# *4F4FDC540264_4F4FD77B03CC_var*
//#UC END# *4F4FDC540264_4F4FD77B03CC_var*
begin
//#UC START# *4F4FDC540264_4F4FD77B03CC_impl*
 f_Filer.Write(aChar);
//#UC END# *4F4FDC540264_4F4FD77B03CC_impl*
end;//TtfwFile.WriteChar

function TtfwFile.ReadWStrLn: Tl3WString;
//#UC START# *4F4FE16A0269_4F4FD77B03CC_var*
//#UC END# *4F4FE16A0269_4F4FD77B03CC_var*
begin
//#UC START# *4F4FE16A0269_4F4FD77B03CC_impl*
 Result := f_Filer.ReadLn;
//#UC END# *4F4FE16A0269_4F4FD77B03CC_impl*
end;//TtfwFile.ReadWStrLn

procedure TtfwFile.WriteWStrLn(const aStr: Tl3WString);
//#UC START# *4F4FE19301A1_4F4FD77B03CC_var*
//#UC END# *4F4FE19301A1_4F4FD77B03CC_var*
begin
//#UC START# *4F4FE19301A1_4F4FD77B03CC_impl*
 f_Filer.WriteLn(aStr);
//#UC END# *4F4FE19301A1_4F4FD77B03CC_impl*
end;//TtfwFile.WriteWStrLn

procedure TtfwFile.WriteWStr(const aStr: Tl3WString);
//#UC START# *4F4FE1B40314_4F4FD77B03CC_var*
//#UC END# *4F4FE1B40314_4F4FD77B03CC_var*
begin
//#UC START# *4F4FE1B40314_4F4FD77B03CC_impl*
 f_Filer.Write(aStr);
//#UC END# *4F4FE1B40314_4F4FD77B03CC_impl*
end;//TtfwFile.WriteWStr

function TtfwFile.EOF: Boolean;
//#UC START# *4F50821201E7_4F4FD77B03CC_var*
//#UC END# *4F50821201E7_4F4FD77B03CC_var*
begin
//#UC START# *4F50821201E7_4F4FD77B03CC_impl*
 Result := f_Filer.EOF;
//#UC END# *4F50821201E7_4F4FD77B03CC_impl*
end;//TtfwFile.EOF

procedure TtfwFile.ForEach(aLambda: TtfwWordPrim;
  const aCtx: TtfwContext);
//#UC START# *52E23B7A00EC_4F4FD77B03CC_var*
var
 l_S : Tl3WString;
//#UC END# *52E23B7A00EC_4F4FD77B03CC_var*
begin
//#UC START# *52E23B7A00EC_4F4FD77B03CC_impl*
 while not f_Filer.EOF do
 begin
  l_S := f_Filer.ReadLn;
  if not l3IsNil(l_S) OR not f_Filer.EOF then
  begin
  // - ��� ����� �� ������������ ������ ������ � ����� ������
   aCtx.rEngine.PushWStr(l_S);
   try
    aLambda.DoIt(aCtx);
   except
    on EtfwBreakIterator do
     break;
    on EtfwBreak do
     break;
    on EtfwContinue do
     continue;
   end;//try..except
  end;//not l3IsNil(l_S) OR not f_Filer.EOF  
 end;//not f_Filer.EOF
//#UC END# *52E23B7A00EC_4F4FD77B03CC_impl*
end;//TtfwFile.ForEach

procedure TtfwFile.ForEachBack(aLambda: TtfwWordPrim;
  const aCtx: TtfwContext);
//#UC START# *52E23BB102FA_4F4FD77B03CC_var*
//#UC END# *52E23BB102FA_4F4FD77B03CC_var*
begin
//#UC START# *52E23BB102FA_4F4FD77B03CC_impl*
 TtfwWord(aLambda).RunnerError('������� ����� �� ����� �����, �� ����������', aCtx);
//#UC END# *52E23BB102FA_4F4FD77B03CC_impl*
end;//TtfwFile.ForEachBack

procedure TtfwFile.Cleanup;
//#UC START# *479731C50290_4F4FD77B03CC_var*
//#UC END# *479731C50290_4F4FD77B03CC_var*
begin
//#UC START# *479731C50290_4F4FD77B03CC_impl*
 f_Filer.Close;
 FreeAndNil(f_Filer);
 inherited;
//#UC END# *479731C50290_4F4FD77B03CC_impl*
end;//TtfwFile.Cleanup
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� ������������ �����������
 TFileProcessingPackResNameGetter.Register;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� File_OpenRead
 TkwFileOpenRead.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� File_OpenWrite
 TkwFileOpenWrite.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� File_EOF
 TkwFileEOF.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� File_ReadLn
 TkwFileReadLn.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� File_WriteLn
 TkwFileWriteLn.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� File_WriteChar
 TkwFileWriteChar.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� File_WriteStr
 TkwFileWriteStr.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� File_ReadLines
 TkwFileReadLines.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� File_WriteWStr
 TkwFileWriteWStr.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� File_ReadWStrLn
 TkwFileReadWStrLn.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� File_WriteWStrLn
 TkwFileWriteWStrLn.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� DeleteFile
 TkwDeleteFile.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� RenameFile
 TkwRenameFile.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� CopyFilesByMask
 TkwCopyFilesByMask.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� CopyFile
 TkwCopyFile.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� PureDir
 TkwPureDir.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� DeleteFilesByMask
 TkwDeleteFilesByMask.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ProcessFilesWithMask
 TkwProcessFilesWithMask.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ProcessSubDirs
 TkwProcessSubDirs.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� String
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiString));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� ItfwFile
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwFile));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Il3CString
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Char
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiChar));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwWord
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwStackValue
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Tl3PCharLen
 TtfwTypeRegistrator.RegisterType(@tfw_tiWString);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts

end.