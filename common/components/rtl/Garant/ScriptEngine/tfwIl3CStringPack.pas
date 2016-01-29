unit tfwIl3CStringPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Axiomatics"
// ������: "tfwIl3CStringPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$Axiomatics::StringProcessing::tfwIl3CStringPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3Interfaces,
  tfwScriptingInterfaces,
  tfwRegisterableWord,
  tfwWordWorkerEx,
  tfwAxiomaticsResNameGetter,
  tfwClassLike
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  l3String,
  l3Types,
  l3Chars,
  l3Base,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
//#UC START# *1C3B459FC59Bci*
//#UC END# *1C3B459FC59Bci*
//#UC START# *1C3B459FC59Bcit*
//#UC END# *1C3B459FC59Bcit*
 TtfwIl3CStringPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
 public
 // realized methods
   class function ResName: AnsiString; override;
//#UC START# *1C3B459FC59Bpubl*
//#UC END# *1C3B459FC59Bpubl*
 end;//TtfwIl3CStringPackResNameGetter

// start class TtfwIl3CStringPackResNameGetter

class function TtfwIl3CStringPackResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'tfwIl3CStringPack';
end;//TtfwIl3CStringPackResNameGetter.ResName

 {$R tfwIl3CStringPack.res}

type
 TkwStartsStr = {final scriptword} class(TtfwClassLike)
  {* ����� ������� StartsStr
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSubStr aString StartsStr >>> l_Boolean
[code]  }
 private
 // private methods
   function StartsStr(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aSubStr: Il3CString): Boolean;
     {* ���������� ����� ������� StartsStr }
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
 end;//TkwStartsStr

// start class TkwStartsStr

function TkwStartsStr.StartsStr(const aCtx: TtfwContext;
  const aString: Il3CString;
  const aSubStr: Il3CString): Boolean;
//#UC START# *ADBAC1D0C450_0093B3082714_var*
//#UC END# *ADBAC1D0C450_0093B3082714_var*
begin
//#UC START# *ADBAC1D0C450_0093B3082714_impl*
 Result := l3Starts(aSubStr, aString, false);
//#UC END# *ADBAC1D0C450_0093B3082714_impl*
end;//TkwStartsStr.StartsStr

procedure TkwStartsStr.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_aSubStr : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aSubStr := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSubStr: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((StartsStr(aCtx, l_aString, l_aSubStr)));
end;//TkwStartsStr.DoDoIt

class function TkwStartsStr.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'StartsStr';
end;//TkwStartsStr.GetWordNameForRegister

function TkwStartsStr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwStartsStr.GetResultTypeInfo

function TkwStartsStr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwStartsStr.GetAllParamsCount

function TkwStartsStr.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwStartsStr.ParamsTypes

type
 TkwStartsText = {final scriptword} class(TtfwClassLike)
  {* ����� ������� StartsText
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSubStr aString StartsText >>> l_Boolean
[code]  }
 private
 // private methods
   function StartsText(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aSubStr: Il3CString): Boolean;
     {* ���������� ����� ������� StartsText }
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
 end;//TkwStartsText

// start class TkwStartsText

function TkwStartsText.StartsText(const aCtx: TtfwContext;
  const aString: Il3CString;
  const aSubStr: Il3CString): Boolean;
//#UC START# *2B44D7EFA4A8_9996D7566EDE_var*
//#UC END# *2B44D7EFA4A8_9996D7566EDE_var*
begin
//#UC START# *2B44D7EFA4A8_9996D7566EDE_impl*
 Result := l3Starts(aSubStr, aString, true);
//#UC END# *2B44D7EFA4A8_9996D7566EDE_impl*
end;//TkwStartsText.StartsText

procedure TkwStartsText.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_aSubStr : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aSubStr := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSubStr: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((StartsText(aCtx, l_aString, l_aSubStr)));
end;//TkwStartsText.DoDoIt

class function TkwStartsText.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'StartsText';
end;//TkwStartsText.GetWordNameForRegister

function TkwStartsText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwStartsText.GetResultTypeInfo

function TkwStartsText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwStartsText.GetAllParamsCount

function TkwStartsText.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwStartsText.ParamsTypes

type
 TkwEndsStr = {final scriptword} class(TtfwClassLike)
  {* ����� ������� EndsStr
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSubStr aString EndsStr >>> l_Boolean
[code]  }
 private
 // private methods
   function EndsStr(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aSubStr: Il3CString): Boolean;
     {* ���������� ����� ������� EndsStr }
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
 end;//TkwEndsStr

// start class TkwEndsStr

function TkwEndsStr.EndsStr(const aCtx: TtfwContext;
  const aString: Il3CString;
  const aSubStr: Il3CString): Boolean;
//#UC START# *E58966F67546_397C461D6C30_var*
//#UC END# *E58966F67546_397C461D6C30_var*
begin
//#UC START# *E58966F67546_397C461D6C30_impl*
 Result := l3Ends(aSubStr, aString, false);
//#UC END# *E58966F67546_397C461D6C30_impl*
end;//TkwEndsStr.EndsStr

procedure TkwEndsStr.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_aSubStr : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aSubStr := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSubStr: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((EndsStr(aCtx, l_aString, l_aSubStr)));
end;//TkwEndsStr.DoDoIt

class function TkwEndsStr.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'EndsStr';
end;//TkwEndsStr.GetWordNameForRegister

function TkwEndsStr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwEndsStr.GetResultTypeInfo

function TkwEndsStr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwEndsStr.GetAllParamsCount

function TkwEndsStr.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwEndsStr.ParamsTypes

type
 TkwEndsText = {final scriptword} class(TtfwClassLike)
  {* ����� ������� EndsText
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSubStr aString EndsText >>> l_Boolean
[code]  }
 private
 // private methods
   function EndsText(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aSubStr: Il3CString): Boolean;
     {* ���������� ����� ������� EndsText }
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
 end;//TkwEndsText

// start class TkwEndsText

function TkwEndsText.EndsText(const aCtx: TtfwContext;
  const aString: Il3CString;
  const aSubStr: Il3CString): Boolean;
//#UC START# *187F940B5F16_8997C15C6CA8_var*
//#UC END# *187F940B5F16_8997C15C6CA8_var*
begin
//#UC START# *187F940B5F16_8997C15C6CA8_impl*
 Result := l3Ends(aSubStr, aString, true);
//#UC END# *187F940B5F16_8997C15C6CA8_impl*
end;//TkwEndsText.EndsText

procedure TkwEndsText.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_aSubStr : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aSubStr := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSubStr: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((EndsText(aCtx, l_aString, l_aSubStr)));
end;//TkwEndsText.DoDoIt

class function TkwEndsText.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'EndsText';
end;//TkwEndsText.GetWordNameForRegister

function TkwEndsText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwEndsText.GetResultTypeInfo

function TkwEndsText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwEndsText.GetAllParamsCount

function TkwEndsText.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwEndsText.ParamsTypes

type
 TkwSameStr = {final scriptword} class(TtfwClassLike)
  {* ����� ������� SameStr
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 anOther aString SameStr >>> l_Boolean
[code]  }
 private
 // private methods
   function SameStr(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString): Boolean;
     {* ���������� ����� ������� SameStr }
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
 end;//TkwSameStr

// start class TkwSameStr

function TkwSameStr.SameStr(const aCtx: TtfwContext;
  const aString: Il3CString;
  const anOther: Il3CString): Boolean;
//#UC START# *4D25C99A6BEB_2309401B7CC1_var*
//#UC END# *4D25C99A6BEB_2309401B7CC1_var*
begin
//#UC START# *4D25C99A6BEB_2309401B7CC1_impl*
 Result := l3Same(aString, anOther, false);
//#UC END# *4D25C99A6BEB_2309401B7CC1_impl*
end;//TkwSameStr.SameStr

procedure TkwSameStr.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_anOther : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anOther: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((SameStr(aCtx, l_aString, l_anOther)));
end;//TkwSameStr.DoDoIt

class function TkwSameStr.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'SameStr';
end;//TkwSameStr.GetWordNameForRegister

function TkwSameStr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwSameStr.GetResultTypeInfo

function TkwSameStr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwSameStr.GetAllParamsCount

function TkwSameStr.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwSameStr.ParamsTypes

type
 TkwSameText = {final scriptword} class(TtfwClassLike)
  {* ����� ������� SameText
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 anOther aString SameText >>> l_Boolean
[code]  }
 private
 // private methods
   function SameText(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString): Boolean;
     {* ���������� ����� ������� SameText }
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
 end;//TkwSameText

// start class TkwSameText

function TkwSameText.SameText(const aCtx: TtfwContext;
  const aString: Il3CString;
  const anOther: Il3CString): Boolean;
//#UC START# *883992DDC504_9FC28ACB9AA1_var*
//#UC END# *883992DDC504_9FC28ACB9AA1_var*
begin
//#UC START# *883992DDC504_9FC28ACB9AA1_impl*
 Result := l3Same(aString, anOther, true);
//#UC END# *883992DDC504_9FC28ACB9AA1_impl*
end;//TkwSameText.SameText

procedure TkwSameText.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_anOther : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anOther: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((SameText(aCtx, l_aString, l_anOther)));
end;//TkwSameText.DoDoIt

class function TkwSameText.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'SameText';
end;//TkwSameText.GetWordNameForRegister

function TkwSameText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwSameText.GetResultTypeInfo

function TkwSameText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwSameText.GetAllParamsCount

function TkwSameText.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwSameText.ParamsTypes

type
 TkwCompareStr = {final scriptword} class(TtfwClassLike)
  {* ����� ������� CompareStr
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anOther aString CompareStr >>> l_Integer
[code]  }
 private
 // private methods
   function CompareStr(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString): Integer;
     {* ���������� ����� ������� CompareStr }
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
 end;//TkwCompareStr

// start class TkwCompareStr

function TkwCompareStr.CompareStr(const aCtx: TtfwContext;
  const aString: Il3CString;
  const anOther: Il3CString): Integer;
//#UC START# *60E71D4C9014_C670925F6482_var*
//#UC END# *60E71D4C9014_C670925F6482_var*
begin
//#UC START# *60E71D4C9014_C670925F6482_impl*
 Result := l3Compare(l3PCharLen(anOther), l3PCharLen(aString));
//#UC END# *60E71D4C9014_C670925F6482_impl*
end;//TkwCompareStr.CompareStr

procedure TkwCompareStr.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_anOther : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anOther: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((CompareStr(aCtx, l_aString, l_anOther)));
end;//TkwCompareStr.DoDoIt

class function TkwCompareStr.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'CompareStr';
end;//TkwCompareStr.GetWordNameForRegister

function TkwCompareStr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwCompareStr.GetResultTypeInfo

function TkwCompareStr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwCompareStr.GetAllParamsCount

function TkwCompareStr.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwCompareStr.ParamsTypes

type
 TkwCompareText = {final scriptword} class(TtfwClassLike)
  {* ����� ������� CompareText
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anOther aString CompareText >>> l_Integer
[code]  }
 private
 // private methods
   function CompareText(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString): Integer;
     {* ���������� ����� ������� CompareText }
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
 end;//TkwCompareText

// start class TkwCompareText

function TkwCompareText.CompareText(const aCtx: TtfwContext;
  const aString: Il3CString;
  const anOther: Il3CString): Integer;
//#UC START# *53DA3FC40405_0E02A0729BA6_var*
//#UC END# *53DA3FC40405_0E02A0729BA6_var*
begin
//#UC START# *53DA3FC40405_0E02A0729BA6_impl*
 Result := l3Compare(l3PCharLen(anOther), l3PCharLen(aString), l3_siCaseUnsensitive);
//#UC END# *53DA3FC40405_0E02A0729BA6_impl*
end;//TkwCompareText.CompareText

procedure TkwCompareText.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_anOther : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anOther: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((CompareText(aCtx, l_aString, l_anOther)));
end;//TkwCompareText.DoDoIt

class function TkwCompareText.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'CompareText';
end;//TkwCompareText.GetWordNameForRegister

function TkwCompareText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwCompareText.GetResultTypeInfo

function TkwCompareText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwCompareText.GetAllParamsCount

function TkwCompareText.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwCompareText.ParamsTypes

type
 TkwStrToInt = {final scriptword} class(TtfwClassLike)
  {* ����� ������� StrToInt
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aString StrToInt >>> l_Integer
[code]  }
 private
 // private methods
   function StrToInt(const aCtx: TtfwContext;
    const aString: Il3CString): Integer;
     {* ���������� ����� ������� StrToInt }
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
 end;//TkwStrToInt

// start class TkwStrToInt

function TkwStrToInt.StrToInt(const aCtx: TtfwContext;
  const aString: Il3CString): Integer;
//#UC START# *108F78D959BF_09008856C703_var*
//#UC END# *108F78D959BF_09008856C703_var*
begin
//#UC START# *108F78D959BF_09008856C703_impl*
 Result := SysUtils.StrToInt(l3Str(aString));
//#UC END# *108F78D959BF_09008856C703_impl*
end;//TkwStrToInt.StrToInt

procedure TkwStrToInt.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((StrToInt(aCtx, l_aString)));
end;//TkwStrToInt.DoDoIt

class function TkwStrToInt.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'StrToInt';
end;//TkwStrToInt.GetWordNameForRegister

function TkwStrToInt.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwStrToInt.GetResultTypeInfo

function TkwStrToInt.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStrToInt.GetAllParamsCount

function TkwStrToInt.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStrToInt.ParamsTypes

type
 TkwCat = {final scriptword} class(TtfwClassLike)
  {* ����� ������� Cat
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 anOther aString Cat >>> l_Il3CString
[code]  }
 private
 // private methods
   function Cat(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString): Il3CString;
     {* ���������� ����� ������� Cat }
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
 end;//TkwCat

// start class TkwCat

function TkwCat.Cat(const aCtx: TtfwContext;
  const aString: Il3CString;
  const anOther: Il3CString): Il3CString;
//#UC START# *0AEEC1805BCE_DD57CECF347C_var*
//#UC END# *0AEEC1805BCE_DD57CECF347C_var*
begin
//#UC START# *0AEEC1805BCE_DD57CECF347C_impl*
 Result := TtfwCStringFactory.Cat(anOther, aString);
//#UC END# *0AEEC1805BCE_DD57CECF347C_impl*
end;//TkwCat.Cat

procedure TkwCat.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_anOther : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anOther: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((Cat(aCtx, l_aString, l_anOther)));
end;//TkwCat.DoDoIt

class function TkwCat.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Cat';
end;//TkwCat.GetWordNameForRegister

function TkwCat.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwCat.GetResultTypeInfo

function TkwCat.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwCat.GetAllParamsCount

function TkwCat.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwCat.ParamsTypes

type
 TkwStringConsistsOf = {final scriptword} class(TtfwClassLike)
  {* ����� ������� string:ConsistsOf
[panel]���������, ��� ������ aString ������� ������ �� �������� ������ aDelims[panel]
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aDelims aString string:ConsistsOf >>> l_Boolean
[code]  }
 private
 // private methods
   function StringConsistsOf(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aDelims: Il3CString): Boolean;
     {* ���������� ����� ������� string:ConsistsOf }
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
 end;//TkwStringConsistsOf

// start class TkwStringConsistsOf

function TkwStringConsistsOf.StringConsistsOf(const aCtx: TtfwContext;
  const aString: Il3CString;
  const aDelims: Il3CString): Boolean;
//#UC START# *C17F9AF1604A_5F306006344B_var*
var
 l_S1 : Tl3WString;
 l_S2 : Tl3WString;
 l_C : TChars;
 l_Index : Integer;
//#UC END# *C17F9AF1604A_5F306006344B_var*
begin
//#UC START# *C17F9AF1604A_5F306006344B_impl*
 l_S1 := l3PCharLen(aDelims);
 l_S2 := l3PCharLen(aString);
 if l3IsNil(l_S1) then
  Result := l3IsNil(l_S2)
  // - ����� �������� �� ����� �������� ������ �� �������� ������� ��������� 
 else
 if (l_S1.SLen = 1) then
  Result := l3AllCharsInCharSet(l_S2, [l_S1.S[0]])
 else
 begin
  l_C := [];
  for l_Index := 0 to Pred(l_S1.SLen) do
   l_C := l_C + [l_S1.S[l_Index]];
  Result := l3AllCharsInCharSet(l_S2, l_C);
 end;//l_S1.SLen = 1
//#UC END# *C17F9AF1604A_5F306006344B_impl*
end;//TkwStringConsistsOf.StringConsistsOf

procedure TkwStringConsistsOf.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_aDelims : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDelims := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDelims: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((StringConsistsOf(aCtx, l_aString, l_aDelims)));
end;//TkwStringConsistsOf.DoDoIt

class function TkwStringConsistsOf.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:ConsistsOf';
end;//TkwStringConsistsOf.GetWordNameForRegister

function TkwStringConsistsOf.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwStringConsistsOf.GetResultTypeInfo

function TkwStringConsistsOf.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwStringConsistsOf.GetAllParamsCount

function TkwStringConsistsOf.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwStringConsistsOf.ParamsTypes

type
 TkwStringHasAnyOf = {final scriptword} class(TtfwClassLike)
  {* ����� ������� string:HasAnyOf
[panel]���������, ��� ������ aString �������� ���� �� ���� ������ �� aDelims[panel]
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aDelims aString string:HasAnyOf >>> l_Boolean
[code]  }
 private
 // private methods
   function StringHasAnyOf(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aDelims: Il3CString): Boolean;
     {* ���������� ����� ������� string:HasAnyOf }
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
 end;//TkwStringHasAnyOf

// start class TkwStringHasAnyOf

function TkwStringHasAnyOf.StringHasAnyOf(const aCtx: TtfwContext;
  const aString: Il3CString;
  const aDelims: Il3CString): Boolean;
//#UC START# *4E5E3C364C71_2256016890B3_var*
var
 l_S1 : Tl3WString;
 l_S2 : Tl3WString;
 l_C : TChars;
 l_Index : Integer;
//#UC END# *4E5E3C364C71_2256016890B3_var*
begin
//#UC START# *4E5E3C364C71_2256016890B3_impl*
 l_S1 := l3PCharLen(aDelims);
 l_S2 := l3PCharLen(aString);
 if l3IsNil(l_S1) then
  Result := true
  // - ����� ������ �������� ������� �� ������� ���������, ������� ���
 else
 if (l_S1.SLen = 1) then
  Result := l3CharSetPresent(l_S2, [l_S1.S[0]])
 else
 begin
  l_C := [];
  for l_Index := 0 to Pred(l_S1.SLen) do
   l_C := l_C + [l_S1.S[l_Index]];
  Result := l3CharSetPresent(l_S2, l_C);
 end;//l_S1.SLen = 1
//#UC END# *4E5E3C364C71_2256016890B3_impl*
end;//TkwStringHasAnyOf.StringHasAnyOf

procedure TkwStringHasAnyOf.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_aDelims : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDelims := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDelims: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((StringHasAnyOf(aCtx, l_aString, l_aDelims)));
end;//TkwStringHasAnyOf.DoDoIt

class function TkwStringHasAnyOf.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:HasAnyOf';
end;//TkwStringHasAnyOf.GetWordNameForRegister

function TkwStringHasAnyOf.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwStringHasAnyOf.GetResultTypeInfo

function TkwStringHasAnyOf.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwStringHasAnyOf.GetAllParamsCount

function TkwStringHasAnyOf.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwStringHasAnyOf.ParamsTypes

type
 TkwStringPos = {final scriptword} class(TtfwClassLike)
  {* ����� ������� string:Pos
[panel]'���� ���� ���' '��' string:Pos .[panel]
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anOther aString string:Pos >>> l_Integer
[code]  }
 private
 // private methods
   function StringPos(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString): Integer;
     {* ���������� ����� ������� string:Pos }
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
 end;//TkwStringPos

// start class TkwStringPos

function TkwStringPos.StringPos(const aCtx: TtfwContext;
  const aString: Il3CString;
  const anOther: Il3CString): Integer;
//#UC START# *A3206F78A2FD_851E99BEB53B_var*
//#UC END# *A3206F78A2FD_851E99BEB53B_var*
begin
//#UC START# *A3206F78A2FD_851E99BEB53B_impl*
 Result := l3Pos(anOther, aString);
//#UC END# *A3206F78A2FD_851E99BEB53B_impl*
end;//TkwStringPos.StringPos

procedure TkwStringPos.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_anOther : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anOther: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((StringPos(aCtx, l_aString, l_anOther)));
end;//TkwStringPos.DoDoIt

class function TkwStringPos.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:Pos';
end;//TkwStringPos.GetWordNameForRegister

function TkwStringPos.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwStringPos.GetResultTypeInfo

function TkwStringPos.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwStringPos.GetAllParamsCount

function TkwStringPos.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwStringPos.ParamsTypes

type
 TkwStringPosEx = {final scriptword} class(TtfwClassLike)
  {* ����� ������� string:PosEx
[panel]6 '���� ���� ����' '��' string:PosEx .[panel]
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aPos anOther aString string:PosEx >>> l_Integer
[code]  }
 private
 // private methods
   function StringPosEx(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString;
    aPos: Integer): Integer;
     {* ���������� ����� ������� string:PosEx }
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
 end;//TkwStringPosEx

// start class TkwStringPosEx

function TkwStringPosEx.StringPosEx(const aCtx: TtfwContext;
  const aString: Il3CString;
  const anOther: Il3CString;
  aPos: Integer): Integer;
//#UC START# *F7FE00F8B33E_24901BF384F4_var*
//#UC END# *F7FE00F8B33E_24901BF384F4_var*
begin
//#UC START# *F7FE00F8B33E_24901BF384F4_impl*
 Result := l3PosEx(anOther, aString, aPos);
//#UC END# *F7FE00F8B33E_24901BF384F4_impl*
end;//TkwStringPosEx.StringPosEx

procedure TkwStringPosEx.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_anOther : Il3CString;
 l_aPos : Integer;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anOther: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aPos := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aPos: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((StringPosEx(aCtx, l_aString, l_anOther, l_aPos)));
end;//TkwStringPosEx.DoDoIt

class function TkwStringPosEx.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:PosEx';
end;//TkwStringPosEx.GetWordNameForRegister

function TkwStringPosEx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwStringPosEx.GetResultTypeInfo

function TkwStringPosEx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2 + 1;
end;//TkwStringPosEx.GetAllParamsCount

function TkwStringPosEx.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString, TypeInfo(Integer)]);
end;//TkwStringPosEx.ParamsTypes

type
 TkwStringSplit = {final scriptword} class(TtfwClassLike)
  {* ����� ������� string:Split
[panel]��������� ������ �� ��� �� ��������� �����������.

������:
[code]
'ABC:DEF' ':' string:Split
[code]
�������� �� �����:
'ABC' ':DEF'[panel]
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_theTail
STRING VAR l_Il3CString
 anOther aString string:Split >>> l_theTail >>> l_Il3CString
[code]  }
 private
 // private methods
   function StringSplit(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString;
    out theTail: Il3CString): Il3CString;
     {* ���������� ����� ������� string:Split }
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
 end;//TkwStringSplit

// start class TkwStringSplit

function TkwStringSplit.StringSplit(const aCtx: TtfwContext;
  const aString: Il3CString;
  const anOther: Il3CString;
  out theTail: Il3CString): Il3CString;
//#UC START# *2D11D07B402C_AA63BC1F51EC_var*
var
(* l_P : Il3CString;
 l_S : Il3CString;*)
 l_Len : Integer;
//#UC END# *2D11D07B402C_AA63BC1F51EC_var*
begin
//#UC START# *2D11D07B402C_AA63BC1F51EC_impl*
 l_Len := l3Len(aString);
 if (l_Len = 1) then
  l3Split(anOther, l3Char(aString, 0), Result, theTail)
 else
  l3Split(anOther, aString, Result, theTail);
(* if (l_Len = 1) then
  l3Split(anOther, l3Char(aString, 0), l_P, l_S)
 else
  l3Split(anOther, aString, l_P, l_S);
 aCtx.rEngine.PushString(l_P);
 aCtx.rEngine.PushString(l_S);*)
//#UC END# *2D11D07B402C_AA63BC1F51EC_impl*
end;//TkwStringSplit.StringSplit

procedure TkwStringSplit.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_anOther : Il3CString;
 l_theTail : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anOther: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((StringSplit(aCtx, l_aString, l_anOther, l_theTail)));
 aCtx.rEngine.PushString(l_theTail);
end;//TkwStringSplit.DoDoIt

class function TkwStringSplit.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:Split';
end;//TkwStringSplit.GetWordNameForRegister

function TkwStringSplit.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwStringSplit.GetResultTypeInfo

function TkwStringSplit.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwStringSplit.GetAllParamsCount

function TkwStringSplit.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwStringSplit.ParamsTypes

type
 TkwStringReplace = {final scriptword} class(TtfwClassLike)
  {* ����� ������� string:Replace
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aMain aFrom aString string:Replace >>> l_Il3CString
[code]  }
 private
 // private methods
   function StringReplace(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aFrom: Il3CString;
    const aMain: Il3CString): Il3CString;
     {* ���������� ����� ������� string:Replace }
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
 end;//TkwStringReplace

// start class TkwStringReplace

function TkwStringReplace.StringReplace(const aCtx: TtfwContext;
  const aString: Il3CString;
  const aFrom: Il3CString;
  const aMain: Il3CString): Il3CString;
//#UC START# *DD442A0F03CD_8CA688C2805E_var*
//#UC END# *DD442A0F03CD_8CA688C2805E_var*
begin
//#UC START# *DD442A0F03CD_8CA688C2805E_impl*
 Result := l3StringReplace(aMain,
                           l3PCharLen(aFrom),
                           l3PCharLen(aString), [rfReplaceAll])
//#UC END# *DD442A0F03CD_8CA688C2805E_impl*
end;//TkwStringReplace.StringReplace

procedure TkwStringReplace.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_aFrom : Il3CString;
 l_aMain : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFrom := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFrom: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aMain := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMain: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((StringReplace(aCtx, l_aString, l_aFrom, l_aMain)));
end;//TkwStringReplace.DoDoIt

class function TkwStringReplace.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:Replace';
end;//TkwStringReplace.GetWordNameForRegister

function TkwStringReplace.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwStringReplace.GetResultTypeInfo

function TkwStringReplace.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2 + 1;
end;//TkwStringReplace.GetAllParamsCount

function TkwStringReplace.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString, @tfw_tiString]);
end;//TkwStringReplace.ParamsTypes

type
 TkwStringReplaceFirst = {final scriptword} class(TtfwClassLike)
  {* ����� ������� string:ReplaceFirst
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aMain aFrom aString string:ReplaceFirst >>> l_Il3CString
[code]  }
 private
 // private methods
   function StringReplaceFirst(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aFrom: Il3CString;
    const aMain: Il3CString): Il3CString;
     {* ���������� ����� ������� string:ReplaceFirst }
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
 end;//TkwStringReplaceFirst

// start class TkwStringReplaceFirst

function TkwStringReplaceFirst.StringReplaceFirst(const aCtx: TtfwContext;
  const aString: Il3CString;
  const aFrom: Il3CString;
  const aMain: Il3CString): Il3CString;
//#UC START# *9B83E2E03D3D_FF1E0A42BBEF_var*
//#UC END# *9B83E2E03D3D_FF1E0A42BBEF_var*
begin
//#UC START# *9B83E2E03D3D_FF1E0A42BBEF_impl*
 Result := l3StringReplace(aMain,
                           l3PCharLen(aFrom),
                           l3PCharLen(aString), [{rfReplaceAll}])
//#UC END# *9B83E2E03D3D_FF1E0A42BBEF_impl*
end;//TkwStringReplaceFirst.StringReplaceFirst

procedure TkwStringReplaceFirst.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_aFrom : Il3CString;
 l_aMain : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFrom := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFrom: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aMain := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMain: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((StringReplaceFirst(aCtx, l_aString, l_aFrom, l_aMain)));
end;//TkwStringReplaceFirst.DoDoIt

class function TkwStringReplaceFirst.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:ReplaceFirst';
end;//TkwStringReplaceFirst.GetWordNameForRegister

function TkwStringReplaceFirst.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwStringReplaceFirst.GetResultTypeInfo

function TkwStringReplaceFirst.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2 + 1;
end;//TkwStringReplaceFirst.GetAllParamsCount

function TkwStringReplaceFirst.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString, @tfw_tiString]);
end;//TkwStringReplaceFirst.ParamsTypes

type
 TkwTextReplace = {final scriptword} class(TtfwClassLike)
  {* ����� ������� text:Replace
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aMain aFrom aString text:Replace >>> l_Il3CString
[code]  }
 private
 // private methods
   function TextReplace(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aFrom: Il3CString;
    const aMain: Il3CString): Il3CString;
     {* ���������� ����� ������� text:Replace }
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
 end;//TkwTextReplace

// start class TkwTextReplace

function TkwTextReplace.TextReplace(const aCtx: TtfwContext;
  const aString: Il3CString;
  const aFrom: Il3CString;
  const aMain: Il3CString): Il3CString;
//#UC START# *77C319AE08A3_6F240EDBC3AE_var*
//#UC END# *77C319AE08A3_6F240EDBC3AE_var*
begin
//#UC START# *77C319AE08A3_6F240EDBC3AE_impl*
 Result := l3StringReplace(aMain,
                           l3PCharLen(aFrom),
                           l3PCharLen(aString), [rfReplaceAll, rfIgnoreCase])
//#UC END# *77C319AE08A3_6F240EDBC3AE_impl*
end;//TkwTextReplace.TextReplace

procedure TkwTextReplace.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_aFrom : Il3CString;
 l_aMain : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFrom := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFrom: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aMain := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMain: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((TextReplace(aCtx, l_aString, l_aFrom, l_aMain)));
end;//TkwTextReplace.DoDoIt

class function TkwTextReplace.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'text:Replace';
end;//TkwTextReplace.GetWordNameForRegister

function TkwTextReplace.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwTextReplace.GetResultTypeInfo

function TkwTextReplace.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2 + 1;
end;//TkwTextReplace.GetAllParamsCount

function TkwTextReplace.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString, @tfw_tiString]);
end;//TkwTextReplace.ParamsTypes

type
 TkwTextReplaceFirst = {final scriptword} class(TtfwClassLike)
  {* ����� ������� text:ReplaceFirst
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aMain aFrom aString text:ReplaceFirst >>> l_Il3CString
[code]  }
 private
 // private methods
   function TextReplaceFirst(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aFrom: Il3CString;
    const aMain: Il3CString): Il3CString;
     {* ���������� ����� ������� text:ReplaceFirst }
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
 end;//TkwTextReplaceFirst

// start class TkwTextReplaceFirst

function TkwTextReplaceFirst.TextReplaceFirst(const aCtx: TtfwContext;
  const aString: Il3CString;
  const aFrom: Il3CString;
  const aMain: Il3CString): Il3CString;
//#UC START# *C0B325EEBDF3_0527F8C9DF24_var*
//#UC END# *C0B325EEBDF3_0527F8C9DF24_var*
begin
//#UC START# *C0B325EEBDF3_0527F8C9DF24_impl*
 Result := l3StringReplace(aMain,
                           l3PCharLen(aFrom),
                           l3PCharLen(aString), [{rfReplaceAll,} rfIgnoreCase])
//#UC END# *C0B325EEBDF3_0527F8C9DF24_impl*
end;//TkwTextReplaceFirst.TextReplaceFirst

procedure TkwTextReplaceFirst.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_aFrom : Il3CString;
 l_aMain : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFrom := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFrom: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aMain := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMain: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((TextReplaceFirst(aCtx, l_aString, l_aFrom, l_aMain)));
end;//TkwTextReplaceFirst.DoDoIt

class function TkwTextReplaceFirst.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'text:ReplaceFirst';
end;//TkwTextReplaceFirst.GetWordNameForRegister

function TkwTextReplaceFirst.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwTextReplaceFirst.GetResultTypeInfo

function TkwTextReplaceFirst.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2 + 1;
end;//TkwTextReplaceFirst.GetAllParamsCount

function TkwTextReplaceFirst.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString, @tfw_tiString]);
end;//TkwTextReplaceFirst.ParamsTypes

type
 TkwStringChar = {final scriptword} class(TtfwClassLike)
  {* ����� ������� string:[i]
*��� ����������:* Char
*������:*
[code]
CHAR VAR l_Char
 anIndex aString string:[i] >>> l_Char
[code]  }
 private
 // private methods
   function StringChar(const aCtx: TtfwContext;
    const aString: Il3CString;
    anIndex: Integer): AnsiChar;
     {* ���������� ����� ������� string:[i] }
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
 end;//TkwStringChar

// start class TkwStringChar

function TkwStringChar.StringChar(const aCtx: TtfwContext;
  const aString: Il3CString;
  anIndex: Integer): AnsiChar;
//#UC START# *46139320DD2A_9597582C9BD4_var*
//#UC END# *46139320DD2A_9597582C9BD4_var*
begin
//#UC START# *46139320DD2A_9597582C9BD4_impl*
 Result := aString.AsWStr.S[anIndex];
//#UC END# *46139320DD2A_9597582C9BD4_impl*
end;//TkwStringChar.StringChar

procedure TkwStringChar.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_anIndex : Integer;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushChar((StringChar(aCtx, l_aString, l_anIndex)));
end;//TkwStringChar.DoDoIt

class function TkwStringChar.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:[i]';
end;//TkwStringChar.GetWordNameForRegister

function TkwStringChar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiChar);
end;//TkwStringChar.GetResultTypeInfo

function TkwStringChar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwStringChar.GetAllParamsCount

function TkwStringChar.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, TypeInfo(Integer)]);
end;//TkwStringChar.ParamsTypes

type
 TkwStringCodePage = {final scriptword} class(TtfwClassLike)
  {* ����� ������� string:CodePage
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aString string:CodePage >>> l_Integer
[code]  }
 private
 // private methods
   function StringCodePage(const aCtx: TtfwContext;
    const aString: Il3CString): Integer;
     {* ���������� ����� ������� string:CodePage }
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
 end;//TkwStringCodePage

// start class TkwStringCodePage

function TkwStringCodePage.StringCodePage(const aCtx: TtfwContext;
  const aString: Il3CString): Integer;
//#UC START# *6C0D8D8B8728_6CAF85926E0C_var*
//#UC END# *6C0D8D8B8728_6CAF85926E0C_var*
begin
//#UC START# *6C0D8D8B8728_6CAF85926E0C_impl*
 Result := aString.AsWStr.SCodePage;
//#UC END# *6C0D8D8B8728_6CAF85926E0C_impl*
end;//TkwStringCodePage.StringCodePage

procedure TkwStringCodePage.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((StringCodePage(aCtx, l_aString)));
end;//TkwStringCodePage.DoDoIt

class function TkwStringCodePage.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:CodePage';
end;//TkwStringCodePage.GetWordNameForRegister

function TkwStringCodePage.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwStringCodePage.GetResultTypeInfo

function TkwStringCodePage.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStringCodePage.GetAllParamsCount

function TkwStringCodePage.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringCodePage.ParamsTypes

type
 TkwStringLen = {final scriptword} class(TtfwClassLike)
  {* ����� ������� string:Len
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aString string:Len >>> l_Integer
[code]  }
 private
 // private methods
   function StringLen(const aCtx: TtfwContext;
    const aString: Il3CString): Integer;
     {* ���������� ����� ������� string:Len }
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
 end;//TkwStringLen

// start class TkwStringLen

function TkwStringLen.StringLen(const aCtx: TtfwContext;
  const aString: Il3CString): Integer;
//#UC START# *1D5A300A0055_0BA6E62BEF84_var*
//#UC END# *1D5A300A0055_0BA6E62BEF84_var*
begin
//#UC START# *1D5A300A0055_0BA6E62BEF84_impl*
 if (aString = nil) then
  Result := 0
 else
  Result := aString.AsWStr.SLen;
//#UC END# *1D5A300A0055_0BA6E62BEF84_impl*
end;//TkwStringLen.StringLen

procedure TkwStringLen.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((StringLen(aCtx, l_aString)));
end;//TkwStringLen.DoDoIt

class function TkwStringLen.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:Len';
end;//TkwStringLen.GetWordNameForRegister

function TkwStringLen.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwStringLen.GetResultTypeInfo

function TkwStringLen.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStringLen.GetAllParamsCount

function TkwStringLen.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringLen.ParamsTypes

type
 TkwStringToChar = {final scriptword} class(TtfwClassLike)
  {* ����� ������� string:ToChar
*��� ����������:* Char
*������:*
[code]
CHAR VAR l_Char
 aString string:ToChar >>> l_Char
[code]  }
 private
 // private methods
   function StringToChar(const aCtx: TtfwContext;
    const aString: Il3CString): AnsiChar;
     {* ���������� ����� ������� string:ToChar }
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
 end;//TkwStringToChar

// start class TkwStringToChar

function TkwStringToChar.StringToChar(const aCtx: TtfwContext;
  const aString: Il3CString): AnsiChar;
//#UC START# *3F9E9C8EDF9E_CA33F456975C_var*
//#UC END# *3F9E9C8EDF9E_CA33F456975C_var*
begin
//#UC START# *3F9E9C8EDF9E_CA33F456975C_impl*
 RunnerAssert(aString.AsWStr.SLen = 1, '����� ������ ������ ��������� 1', aCtx);
 Result := aString.AsWStr.S[0];
//#UC END# *3F9E9C8EDF9E_CA33F456975C_impl*
end;//TkwStringToChar.StringToChar

procedure TkwStringToChar.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushChar((StringToChar(aCtx, l_aString)));
end;//TkwStringToChar.DoDoIt

class function TkwStringToChar.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:ToChar';
end;//TkwStringToChar.GetWordNameForRegister

function TkwStringToChar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiChar);
end;//TkwStringToChar.GetResultTypeInfo

function TkwStringToChar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStringToChar.GetAllParamsCount

function TkwStringToChar.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringToChar.ParamsTypes

type
 TkwCharToString = {final scriptword} class(TtfwRegisterableWord)
  {* ����� ������� char:ToString
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aChar char:ToString >>> l_Il3CString
[code]  }
 private
 // private methods
   function CharToString(const aCtx: TtfwContext;
    aChar: AnsiChar): Il3CString;
     {* ���������� ����� ������� char:ToString }
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
 end;//TkwCharToString

// start class TkwCharToString

function TkwCharToString.CharToString(const aCtx: TtfwContext;
  aChar: AnsiChar): Il3CString;
//#UC START# *E29B58F41653_4C3CAF64FEF3_var*
//#UC END# *E29B58F41653_4C3CAF64FEF3_var*
begin
//#UC START# *E29B58F41653_4C3CAF64FEF3_impl*
 Result := TtfwCStringFactory.C(aChar);
//#UC END# *E29B58F41653_4C3CAF64FEF3_impl*
end;//TkwCharToString.CharToString

procedure TkwCharToString.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aChar : AnsiChar;
begin
 try
  l_aChar := aCtx.rEngine.PopChar;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aChar: AnsiChar : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((CharToString(aCtx, l_aChar)));
end;//TkwCharToString.DoDoIt

class function TkwCharToString.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'char:ToString';
end;//TkwCharToString.GetWordNameForRegister

function TkwCharToString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwCharToString.GetResultTypeInfo

function TkwCharToString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwCharToString.GetAllParamsCount

function TkwCharToString.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(AnsiChar)]);
end;//TkwCharToString.ParamsTypes

type
 TkwCharDupe = {final scriptword} class(TtfwClassLike)
  {* ����� ������� char:Dupe
[panel]���������� ������ ������� ���, ������� �������[panel]
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aCount aString char:Dupe >>> l_Il3CString
[code]  }
 private
 // private methods
   function CharDupe(const aCtx: TtfwContext;
    const aString: Il3CString;
    aCount: Integer): Il3CString;
     {* ���������� ����� ������� char:Dupe }
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
 end;//TkwCharDupe

// start class TkwCharDupe

function TkwCharDupe.CharDupe(const aCtx: TtfwContext;
  const aString: Il3CString;
  aCount: Integer): Il3CString;
//#UC START# *E230CFBF78A9_355A8C3D70FA_var*
//#UC END# *E230CFBF78A9_355A8C3D70FA_var*
begin
//#UC START# *E230CFBF78A9_355A8C3D70FA_impl*
 Result := TtfwCStringFactory.C(ev_psFixLen('', aCount, l3Char(aString, 0)));
//#UC END# *E230CFBF78A9_355A8C3D70FA_impl*
end;//TkwCharDupe.CharDupe

procedure TkwCharDupe.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_aCount : Integer;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aCount := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCount: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((CharDupe(aCtx, l_aString, l_aCount)));
end;//TkwCharDupe.DoDoIt

class function TkwCharDupe.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'char:Dupe';
end;//TkwCharDupe.GetWordNameForRegister

function TkwCharDupe.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwCharDupe.GetResultTypeInfo

function TkwCharDupe.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwCharDupe.GetAllParamsCount

function TkwCharDupe.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, TypeInfo(Integer)]);
end;//TkwCharDupe.ParamsTypes

type
 TkwStringInc = {final scriptword} class(TtfwClassLike)
  {* ����� ������� string:++
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aString string:++ >>> l_Il3CString
[code]  }
 private
 // private methods
   function StringInc(const aCtx: TtfwContext;
    const aString: Il3CString): Il3CString;
     {* ���������� ����� ������� string:++ }
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
 end;//TkwStringInc

// start class TkwStringInc

function TkwStringInc.StringInc(const aCtx: TtfwContext;
  const aString: Il3CString): Il3CString;
//#UC START# *FF3E231E9FA3_F3116B965978_var*
var
 l_P : Tl3PCharLen;
//#UC END# *FF3E231E9FA3_F3116B965978_var*
begin
//#UC START# *FF3E231E9FA3_F3116B965978_impl*
 l_P := l3PCharLen(aString);
 l_P.Shift(+1);
 Result := TtfwCStringFactory.ViewOf(l_P);
//#UC END# *FF3E231E9FA3_F3116B965978_impl*
end;//TkwStringInc.StringInc

procedure TkwStringInc.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((StringInc(aCtx, l_aString)));
end;//TkwStringInc.DoDoIt

class function TkwStringInc.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:++';
end;//TkwStringInc.GetWordNameForRegister

function TkwStringInc.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwStringInc.GetResultTypeInfo

function TkwStringInc.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStringInc.GetAllParamsCount

function TkwStringInc.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringInc.ParamsTypes

type
 TkwStringShift = {final scriptword} class(TtfwClassLike)
  {* ����� ������� string:+
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aDelta aString string:+ >>> l_Il3CString
[code]  }
 private
 // private methods
   function StringShift(const aCtx: TtfwContext;
    const aString: Il3CString;
    aDelta: Integer): Il3CString;
     {* ���������� ����� ������� string:+ }
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
 end;//TkwStringShift

// start class TkwStringShift

function TkwStringShift.StringShift(const aCtx: TtfwContext;
  const aString: Il3CString;
  aDelta: Integer): Il3CString;
//#UC START# *89A4BEF62C61_EFB7A59A9041_var*
var
 l_P : Tl3PCharLen;
//#UC END# *89A4BEF62C61_EFB7A59A9041_var*
begin
//#UC START# *89A4BEF62C61_EFB7A59A9041_impl*
 l_P := l3PCharLen(aString);
 l_P.Shift(aDelta);
 Result := TtfwCStringFactory.ViewOf(l_P);
//#UC END# *89A4BEF62C61_EFB7A59A9041_impl*
end;//TkwStringShift.StringShift

procedure TkwStringShift.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
 l_aDelta : Integer;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDelta := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDelta: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((StringShift(aCtx, l_aString, l_aDelta)));
end;//TkwStringShift.DoDoIt

class function TkwStringShift.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:+';
end;//TkwStringShift.GetWordNameForRegister

function TkwStringShift.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwStringShift.GetResultTypeInfo

function TkwStringShift.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwStringShift.GetAllParamsCount

function TkwStringShift.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString, TypeInfo(Integer)]);
end;//TkwStringShift.ParamsTypes

type
 TkwStringFirstChar = {final scriptword} class(TtfwClassLike)
  {* ����� ������� string:[]
*��� ����������:* Char
*������:*
[code]
CHAR VAR l_Char
 aString string:[] >>> l_Char
[code]  }
 private
 // private methods
   function StringFirstChar(const aCtx: TtfwContext;
    const aString: Il3CString): AnsiChar;
     {* ���������� ����� ������� string:[] }
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
 end;//TkwStringFirstChar

// start class TkwStringFirstChar

function TkwStringFirstChar.StringFirstChar(const aCtx: TtfwContext;
  const aString: Il3CString): AnsiChar;
//#UC START# *16E4F9B79ECC_4E9A5EC5FAC6_var*
//#UC END# *16E4F9B79ECC_4E9A5EC5FAC6_var*
begin
//#UC START# *16E4F9B79ECC_4E9A5EC5FAC6_impl*
 if l3IsNil(aString) then
  Result := #0
 else
  Result := aString.AsWStr.S[0];
//#UC END# *16E4F9B79ECC_4E9A5EC5FAC6_impl*
end;//TkwStringFirstChar.StringFirstChar

procedure TkwStringFirstChar.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aString : Il3CString;
begin
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushChar((StringFirstChar(aCtx, l_aString)));
end;//TkwStringFirstChar.DoDoIt

class function TkwStringFirstChar.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:[]';
end;//TkwStringFirstChar.GetWordNameForRegister

function TkwStringFirstChar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiChar);
end;//TkwStringFirstChar.GetResultTypeInfo

function TkwStringFirstChar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStringFirstChar.GetAllParamsCount

function TkwStringFirstChar.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringFirstChar.ParamsTypes

type
 TkwVarDecLen = {final scriptword} class(TtfwWordWorkerEx)
  {* ����� ������� string:--Len!
*������:*
[code]
 string:--Len! aVar
[code]  }
 private
 // private methods
   procedure VarDecLen(const aCtx: TtfwContext;
    aVar: TtfwWord);
     {* ���������� ����� ������� string:--Len! }
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
 end;//TkwVarDecLen

// start class TkwVarDecLen

procedure TkwVarDecLen.VarDecLen(const aCtx: TtfwContext;
  aVar: TtfwWord);
//#UC START# *9CC163BCA241_5B249AD9723E_var*
var
 l_P : Tl3PCharLen;
//#UC END# *9CC163BCA241_5B249AD9723E_var*
begin
//#UC START# *9CC163BCA241_5B249AD9723E_impl*
 Tl3WString(l_P) := l3PCharLen(aVar.GetValue(aCtx).AsString);
 Dec(l_P.SLen);
 Assert(l_P.SLen >= 0);
 aVar.SetValue(TtfwCStringFactoryEx.ViewOf(l_P), aCtx);
//#UC END# *9CC163BCA241_5B249AD9723E_impl*
end;//TkwVarDecLen.VarDecLen

class function TkwVarDecLen.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:--Len!';
end;//TkwVarDecLen.GetWordNameForRegister

function TkwVarDecLen.RightParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwVarDecLen.RightParamsCount

procedure TkwVarDecLen.DoRun(const aCtx: TtfwContext);
 {-}
var
 l_aVar : TtfwWord;
begin
 try
  l_aVar := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aVar: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 VarDecLen(aCtx, l_aVar);
end;//TkwVarDecLen.DoRun

function TkwVarDecLen.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwVarDecLen.GetResultTypeInfo

function TkwVarDecLen.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwVarDecLen.GetAllParamsCount

function TkwVarDecLen.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwVarDecLen.ParamsTypes

type
 TkwVarInc = {final scriptword} class(TtfwWordWorkerEx)
  {* ����� ������� string:++!
*������:*
[code]
 string:++! aVar
[code]  }
 private
 // private methods
   procedure VarInc(const aCtx: TtfwContext;
    aVar: TtfwWord);
     {* ���������� ����� ������� string:++! }
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
 end;//TkwVarInc

// start class TkwVarInc

procedure TkwVarInc.VarInc(const aCtx: TtfwContext;
  aVar: TtfwWord);
//#UC START# *D3130F58366C_FF4D82AA3241_var*
var
 l_P : Tl3PCharLen;
//#UC END# *D3130F58366C_FF4D82AA3241_var*
begin
//#UC START# *D3130F58366C_FF4D82AA3241_impl*
 Tl3WString(l_P) := l3PCharLen(aVar.GetValue(aCtx).AsString);
 l_P.Shift(+1);
 aVar.SetValue(TtfwCStringFactoryEx.ViewOf(l_P), aCtx);
//#UC END# *D3130F58366C_FF4D82AA3241_impl*
end;//TkwVarInc.VarInc

class function TkwVarInc.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:++!';
end;//TkwVarInc.GetWordNameForRegister

function TkwVarInc.RightParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwVarInc.RightParamsCount

procedure TkwVarInc.DoRun(const aCtx: TtfwContext);
 {-}
var
 l_aVar : TtfwWord;
begin
 try
  l_aVar := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aVar: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 VarInc(aCtx, l_aVar);
end;//TkwVarInc.DoRun

function TkwVarInc.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwVarInc.GetResultTypeInfo

function TkwVarInc.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwVarInc.GetAllParamsCount

function TkwVarInc.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwVarInc.ParamsTypes

type
 TkwRSplitTo = {final scriptword} class(TtfwWordWorkerEx)
  {* ����� ������� string:RSplitTo!
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aDelim string:RSplitTo! aVar >>> l_Il3CString
[code]  }
 private
 // private methods
   function RSplitTo(const aCtx: TtfwContext;
    aVar: TtfwWord;
    const aDelim: Il3CString): Il3CString;
     {* ���������� ����� ������� string:RSplitTo! }
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
 end;//TkwRSplitTo

// start class TkwRSplitTo

function TkwRSplitTo.RSplitTo(const aCtx: TtfwContext;
  aVar: TtfwWord;
  const aDelim: Il3CString): Il3CString;
//#UC START# *6BE7506C040A_D442EF995DFF_var*
var
 l_V : Il3CString;
 l_P : Tl3PCharLen;
 l_WS : Tl3WString;
 l_Found : PAnsiChar;

 //l_Pref : Il3CString;
 //l_Suff : Il3CString;
//#UC END# *6BE7506C040A_D442EF995DFF_var*
begin
//#UC START# *6BE7506C040A_D442EF995DFF_impl*
 l_V := aVar.GetValue(aCtx).AsString;
 Tl3WString(l_P) := l3PCharLen(l_V);
 l_WS := l3PCharLen(aDelim);
 Assert(not l3IsNil(l_WS));
 Assert(l_P.SLen >= 0);
 Assert(l3IsAnsi(l_P.SCodePage));
 if (l_WS.SLen = 1) then
 begin
  l_Found := ev_lpRScan(l_WS.S[0], l_P.S, l_P.SLen);
  if (l_Found = nil) then
  begin
   Result := TtfwCStringFactory.C(l_P);
   aVar.SetValue(TtfwCStringFactoryEx.ViewOf(''), aCtx);
  end//l_Found = nil
  else
  begin
   Result := TtfwCStringFactory.C(l3Copy(l_P, l_Found - l_P.S + 1));
   aVar.SetValue(TtfwCStringFactoryEx.ViewOf(l3PCharLen(l_P.S, l_Found - l_P.S, l_P.SCodePage)), aCtx);
  end;//l_Found = nil
 end//l_WS.SLen = 1
 else
 begin
  //l3Split(l_V, aDelim, l_Pref, l_Suff);
  //aCtx.rEngine.PushString(l_Pref);
  //aVar.Value := TtfwStackValue_C(l_Suff);
  Assert(false, '���� �� �����������');
  Result := nil;
 end;//l_WS.SLen = 1
//#UC END# *6BE7506C040A_D442EF995DFF_impl*
end;//TkwRSplitTo.RSplitTo

class function TkwRSplitTo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:RSplitTo!';
end;//TkwRSplitTo.GetWordNameForRegister

function TkwRSplitTo.RightParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwRSplitTo.RightParamsCount

procedure TkwRSplitTo.DoRun(const aCtx: TtfwContext);
 {-}
var
 l_aVar : TtfwWord;
 l_aDelim : Il3CString;
begin
 try
  l_aVar := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aVar: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDelim := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDelim: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((RSplitTo(aCtx, l_aVar, l_aDelim)));
end;//TkwRSplitTo.DoRun

function TkwRSplitTo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwRSplitTo.GetResultTypeInfo

function TkwRSplitTo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwRSplitTo.GetAllParamsCount

function TkwRSplitTo.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), @tfw_tiString]);
end;//TkwRSplitTo.ParamsTypes

type
 TkwVarShift = {final scriptword} class(TtfwWordWorkerEx)
  {* ����� ������� string:+!
*������:*
[code]
 aNum string:+! aVar
[code]  }
 private
 // private methods
   procedure VarShift(const aCtx: TtfwContext;
    aVar: TtfwWord;
    aNum: Integer);
     {* ���������� ����� ������� string:+! }
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
 end;//TkwVarShift

// start class TkwVarShift

procedure TkwVarShift.VarShift(const aCtx: TtfwContext;
  aVar: TtfwWord;
  aNum: Integer);
//#UC START# *9E35DCA8A090_E1736F173AD3_var*
var
 l_P : Tl3PCharLen;
//#UC END# *9E35DCA8A090_E1736F173AD3_var*
begin
//#UC START# *9E35DCA8A090_E1736F173AD3_impl*
 Tl3WString(l_P) := l3PCharLen(aVar.GetValue(aCtx).AsString);
 l_P.Shift(aNum);
 aVar.SetValue(TtfwCStringFactoryEx.ViewOf(l_P), aCtx);
//#UC END# *9E35DCA8A090_E1736F173AD3_impl*
end;//TkwVarShift.VarShift

class function TkwVarShift.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:+!';
end;//TkwVarShift.GetWordNameForRegister

function TkwVarShift.RightParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwVarShift.RightParamsCount

procedure TkwVarShift.DoRun(const aCtx: TtfwContext);
 {-}
var
 l_aVar : TtfwWord;
 l_aNum : Integer;
begin
 try
  l_aVar := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aVar: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aNum := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNum: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 VarShift(aCtx, l_aVar, l_aNum);
end;//TkwVarShift.DoRun

function TkwVarShift.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwVarShift.GetResultTypeInfo

function TkwVarShift.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwVarShift.GetAllParamsCount

function TkwVarShift.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), TypeInfo(Integer)]);
end;//TkwVarShift.ParamsTypes

type
 TkwSplitTo = {final scriptword} class(TtfwWordWorkerEx)
  {* ����� ������� string:SplitTo!
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aDelim string:SplitTo! aVar >>> l_Il3CString
[code]  }
 private
 // private methods
   function SplitTo(const aCtx: TtfwContext;
    aVar: TtfwWord;
    const aDelim: Il3CString): Il3CString;
     {* ���������� ����� ������� string:SplitTo! }
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
 end;//TkwSplitTo

// start class TkwSplitTo

function TkwSplitTo.SplitTo(const aCtx: TtfwContext;
  aVar: TtfwWord;
  const aDelim: Il3CString): Il3CString;
//#UC START# *94300FB9FFA5_BF0C6B892128_var*
var
 l_V : Il3CString;
 l_P : Tl3PCharLen;
 l_WS : Tl3WString;
 l_Rest : Tl3WString;

 l_Pref : Il3CString;
 l_Suff : Il3CString;
//#UC END# *94300FB9FFA5_BF0C6B892128_var*
begin
//#UC START# *94300FB9FFA5_BF0C6B892128_impl*
 l_V := aVar.GetValue(aCtx).AsString;
 Tl3WString(l_P) := l3PCharLen(l_V);
 l_WS := l3PCharLen(aDelim);
 Assert(not l3IsNil(l_WS));
 Assert(l_P.SLen >= 0);
 if (l_WS.SLen = 1) then
 begin
  l_Rest := l3FindChar(l_WS.S[0], l_P);
  if not l3IsNil(l_P) then
   if (l_P.S[l_P.SLen - 1] = l_WS.S[0]) then
    Dec(l_P.SLen);
  Result := TtfwCStringFactory.C(l_P);
  aVar.SetValue(TtfwCStringFactoryEx.ViewOf(l_Rest), aCtx);
 end//l_WS.SLen = 1
 else
 begin
  l3Split(l_V, aDelim, l_Pref, l_Suff);
  Result := l_Pref;
  aVar.SetValue(TtfwStackValue_C(l_Suff), aCtx);
  //Assert(false, '���� �� �����������');
 end;//l_WS.SLen = 1
//#UC END# *94300FB9FFA5_BF0C6B892128_impl*
end;//TkwSplitTo.SplitTo

class function TkwSplitTo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:SplitTo!';
end;//TkwSplitTo.GetWordNameForRegister

function TkwSplitTo.RightParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwSplitTo.RightParamsCount

procedure TkwSplitTo.DoRun(const aCtx: TtfwContext);
 {-}
var
 l_aVar : TtfwWord;
 l_aDelim : Il3CString;
begin
 try
  l_aVar := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aVar: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDelim := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDelim: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((SplitTo(aCtx, l_aVar, l_aDelim)));
end;//TkwSplitTo.DoRun

function TkwSplitTo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwSplitTo.GetResultTypeInfo

function TkwSplitTo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwSplitTo.GetAllParamsCount

function TkwSplitTo.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), @tfw_tiString]);
end;//TkwSplitTo.ParamsTypes

type
 TkwVarPushCharAndInc = {final scriptword} class(TtfwWordWorkerEx)
  {* ����� ������� string:[]++!
*��� ����������:* Char
*������:*
[code]
CHAR VAR l_Char
 string:[]++! aVar >>> l_Char
[code]  }
 private
 // private methods
   function VarPushCharAndInc(const aCtx: TtfwContext;
    aVar: TtfwWord): AnsiChar;
     {* ���������� ����� ������� string:[]++! }
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
 end;//TkwVarPushCharAndInc

// start class TkwVarPushCharAndInc

function TkwVarPushCharAndInc.VarPushCharAndInc(const aCtx: TtfwContext;
  aVar: TtfwWord): AnsiChar;
//#UC START# *5123A135DDBC_6014F0D564E4_var*
var
 l_P : Tl3PCharLen;
//#UC END# *5123A135DDBC_6014F0D564E4_var*
begin
//#UC START# *5123A135DDBC_6014F0D564E4_impl*
 Tl3WString(l_P) := aVar.GetValue(aCtx).AsString.AsWStr;
 Result := l_P.S^;
 l_P.Shift(+1);
 aVar.SetValue(TtfwCStringFactoryEx.ViewOf(l_P), aCtx);
//#UC END# *5123A135DDBC_6014F0D564E4_impl*
end;//TkwVarPushCharAndInc.VarPushCharAndInc

class function TkwVarPushCharAndInc.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'string:[]++!';
end;//TkwVarPushCharAndInc.GetWordNameForRegister

function TkwVarPushCharAndInc.RightParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwVarPushCharAndInc.RightParamsCount

procedure TkwVarPushCharAndInc.DoRun(const aCtx: TtfwContext);
 {-}
var
 l_aVar : TtfwWord;
begin
 try
  l_aVar := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aVar: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushChar((VarPushCharAndInc(aCtx, l_aVar)));
end;//TkwVarPushCharAndInc.DoRun

function TkwVarPushCharAndInc.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiChar);
end;//TkwVarPushCharAndInc.GetResultTypeInfo

function TkwVarPushCharAndInc.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwVarPushCharAndInc.GetAllParamsCount

function TkwVarPushCharAndInc.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwVarPushCharAndInc.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� ������������ �����������
 TtfwIl3CStringPackResNameGetter.Register;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� StartsStr
 TkwStartsStr.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� StartsText
 TkwStartsText.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� EndsStr
 TkwEndsStr.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� EndsText
 TkwEndsText.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� SameStr
 TkwSameStr.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� SameText
 TkwSameText.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� CompareStr
 TkwCompareStr.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� CompareText
 TkwCompareText.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� StrToInt
 TkwStrToInt.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Cat
 TkwCat.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� string_ConsistsOf
 TkwStringConsistsOf.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� string_HasAnyOf
 TkwStringHasAnyOf.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� string_Pos
 TkwStringPos.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� string_PosEx
 TkwStringPosEx.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� string_Split
 TkwStringSplit.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� string_Replace
 TkwStringReplace.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� string_ReplaceFirst
 TkwStringReplaceFirst.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� text_Replace
 TkwTextReplace.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� text_ReplaceFirst
 TkwTextReplaceFirst.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� string_Char
 TkwStringChar.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� string_CodePage
 TkwStringCodePage.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� string_Len
 TkwStringLen.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� string_ToChar
 TkwStringToChar.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� char_ToString
 TkwCharToString.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� char_Dupe
 TkwCharDupe.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� string_Inc
 TkwStringInc.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� string_Shift
 TkwStringShift.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� string_FirstChar
 TkwStringFirstChar.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� VarDecLen
 TkwVarDecLen.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� VarInc
 TkwVarInc.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� RSplitTo
 TkwRSplitTo.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� VarShift
 TkwVarShift.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� SplitTo
 TkwSplitTo.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� VarPushCharAndInc
 TkwVarPushCharAndInc.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Il3CString
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Char
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiChar));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwWord
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
{$IfEnd} //not NoScripts

end.