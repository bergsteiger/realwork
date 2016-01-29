unit TypeInfoPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Axiomatics"
// ������: "TypeInfoPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$Axiomatics::Words RTTI::TypeInfoPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3Interfaces,
  tfwScriptingInterfaces,
  tfwMainDictionary,
  tfwAxiomaticsResNameGetter,
  tfwScriptingTypes,
  tfwTypeInfo,
  tfwClassLike,
  tfwGlobalKeyWord
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  l3String,
  tfwScriptEngineExInterfaces,
  tfwStandardDictionaries,
  tfwStandardDictionaryListIterator,
  tfwInitedDictionariesListIterator,
  tfwDictionaryListIterator,
  tfwWordsIterator,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
//#UC START# *B848CAD2CFA5ci*
//#UC END# *B848CAD2CFA5ci*
//#UC START# *B848CAD2CFA5cit*
//#UC END# *B848CAD2CFA5cit*
 TTypeInfoPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
 public
 // realized methods
   class function ResName: AnsiString; override;
//#UC START# *B848CAD2CFA5publ*
//#UC END# *B848CAD2CFA5publ*
 end;//TTypeInfoPackResNameGetter

// start class TTypeInfoPackResNameGetter

class function TTypeInfoPackResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'TypeInfoPack';
end;//TTypeInfoPackResNameGetter.ResName

 {$R TypeInfoPack.res}

type
 TkwIsArray = {final scriptword} class(TtfwClassLike)
  {* ����� ������� IsArray
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsArray >>> l_Boolean
[code]  }
 private
 // private methods
   function IsArray(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
     {* ���������� ����� ������� IsArray }
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
 end;//TkwIsArray

// start class TkwIsArray

function TkwIsArray.IsArray(const aCtx: TtfwContext;
  const aSV: TtfwStackValue): Boolean;
//#UC START# *15B838867296_758F80018751_var*
//#UC END# *15B838867296_758F80018751_var*
begin
//#UC START# *15B838867296_758F80018751_impl*
 Result := (aSV.rType = tfw_vtList);
//#UC END# *15B838867296_758F80018751_impl*
end;//TkwIsArray.IsArray

procedure TkwIsArray.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSV : TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((IsArray(aCtx, l_aSV)));
end;//TkwIsArray.DoDoIt

class function TkwIsArray.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IsArray';
end;//TkwIsArray.GetWordNameForRegister

function TkwIsArray.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwIsArray.GetResultTypeInfo

function TkwIsArray.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwIsArray.GetAllParamsCount

function TkwIsArray.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsArray.ParamsTypes

type
 TkwIsVoid = {final scriptword} class(TtfwClassLike)
  {* ����� ������� IsVoid
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsVoid >>> l_Boolean
[code]  }
 private
 // private methods
   function IsVoid(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
     {* ���������� ����� ������� IsVoid }
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
 end;//TkwIsVoid

// start class TkwIsVoid

function TkwIsVoid.IsVoid(const aCtx: TtfwContext;
  const aSV: TtfwStackValue): Boolean;
//#UC START# *C4B2F87508DA_0707D9C010E3_var*
//#UC END# *C4B2F87508DA_0707D9C010E3_var*
begin
//#UC START# *C4B2F87508DA_0707D9C010E3_impl*
 Result := (aSV.rType = tfw_vtVoid);
//#UC END# *C4B2F87508DA_0707D9C010E3_impl*
end;//TkwIsVoid.IsVoid

procedure TkwIsVoid.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSV : TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((IsVoid(aCtx, l_aSV)));
end;//TkwIsVoid.DoDoIt

class function TkwIsVoid.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IsVoid';
end;//TkwIsVoid.GetWordNameForRegister

function TkwIsVoid.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwIsVoid.GetResultTypeInfo

function TkwIsVoid.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwIsVoid.GetAllParamsCount

function TkwIsVoid.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsVoid.ParamsTypes

type
 TkwIsObj = {final scriptword} class(TtfwClassLike)
  {* ����� ������� IsObj
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsObj >>> l_Boolean
[code]  }
 private
 // private methods
   function IsObj(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
     {* ���������� ����� ������� IsObj }
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
 end;//TkwIsObj

// start class TkwIsObj

function TkwIsObj.IsObj(const aCtx: TtfwContext;
  const aSV: TtfwStackValue): Boolean;
//#UC START# *99DC3EB5BE4F_257BCAC433BA_var*
//#UC END# *99DC3EB5BE4F_257BCAC433BA_var*
begin
//#UC START# *99DC3EB5BE4F_257BCAC433BA_impl*
 Result := (aSV.rType = tfw_vtObj);
//#UC END# *99DC3EB5BE4F_257BCAC433BA_impl*
end;//TkwIsObj.IsObj

procedure TkwIsObj.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSV : TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((IsObj(aCtx, l_aSV)));
end;//TkwIsObj.DoDoIt

class function TkwIsObj.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IsObj';
end;//TkwIsObj.GetWordNameForRegister

function TkwIsObj.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwIsObj.GetResultTypeInfo

function TkwIsObj.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwIsObj.GetAllParamsCount

function TkwIsObj.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsObj.ParamsTypes

type
 TkwIsIntf = {final scriptword} class(TtfwClassLike)
  {* ����� ������� IsIntf
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsIntf >>> l_Boolean
[code]  }
 private
 // private methods
   function IsIntf(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
     {* ���������� ����� ������� IsIntf }
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
 end;//TkwIsIntf

// start class TkwIsIntf

function TkwIsIntf.IsIntf(const aCtx: TtfwContext;
  const aSV: TtfwStackValue): Boolean;
//#UC START# *2091967DFD07_475E881B9090_var*
//#UC END# *2091967DFD07_475E881B9090_var*
begin
//#UC START# *2091967DFD07_475E881B9090_impl*
 Result := (aSV.rType = tfw_vtIntf);
//#UC END# *2091967DFD07_475E881B9090_impl*
end;//TkwIsIntf.IsIntf

procedure TkwIsIntf.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSV : TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((IsIntf(aCtx, l_aSV)));
end;//TkwIsIntf.DoDoIt

class function TkwIsIntf.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IsIntf';
end;//TkwIsIntf.GetWordNameForRegister

function TkwIsIntf.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwIsIntf.GetResultTypeInfo

function TkwIsIntf.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwIsIntf.GetAllParamsCount

function TkwIsIntf.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsIntf.ParamsTypes

type
 TkwIsChar = {final scriptword} class(TtfwClassLike)
  {* ����� ������� IsChar
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsChar >>> l_Boolean
[code]  }
 private
 // private methods
   function IsChar(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
     {* ���������� ����� ������� IsChar }
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
 end;//TkwIsChar

// start class TkwIsChar

function TkwIsChar.IsChar(const aCtx: TtfwContext;
  const aSV: TtfwStackValue): Boolean;
//#UC START# *07ECD13EA5B8_ACCFB9C57546_var*
//#UC END# *07ECD13EA5B8_ACCFB9C57546_var*
begin
//#UC START# *07ECD13EA5B8_ACCFB9C57546_impl*
 Result := (aSV.rType = tfw_vtChar);
//#UC END# *07ECD13EA5B8_ACCFB9C57546_impl*
end;//TkwIsChar.IsChar

procedure TkwIsChar.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSV : TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((IsChar(aCtx, l_aSV)));
end;//TkwIsChar.DoDoIt

class function TkwIsChar.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IsChar';
end;//TkwIsChar.GetWordNameForRegister

function TkwIsChar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwIsChar.GetResultTypeInfo

function TkwIsChar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwIsChar.GetAllParamsCount

function TkwIsChar.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsChar.ParamsTypes

type
 TkwIsString = {final scriptword} class(TtfwClassLike)
  {* ����� ������� IsString
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsString >>> l_Boolean
[code]  }
 private
 // private methods
   function IsString(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
     {* ���������� ����� ������� IsString }
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
 end;//TkwIsString

// start class TkwIsString

function TkwIsString.IsString(const aCtx: TtfwContext;
  const aSV: TtfwStackValue): Boolean;
//#UC START# *35FB3393AF28_689D96A305FE_var*
//#UC END# *35FB3393AF28_689D96A305FE_var*
begin
//#UC START# *35FB3393AF28_689D96A305FE_impl*
 Result := (aSV.rType = tfw_vtStr);
//#UC END# *35FB3393AF28_689D96A305FE_impl*
end;//TkwIsString.IsString

procedure TkwIsString.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSV : TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((IsString(aCtx, l_aSV)));
end;//TkwIsString.DoDoIt

class function TkwIsString.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IsString';
end;//TkwIsString.GetWordNameForRegister

function TkwIsString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwIsString.GetResultTypeInfo

function TkwIsString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwIsString.GetAllParamsCount

function TkwIsString.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsString.ParamsTypes

type
 TkwIsInt = {final scriptword} class(TtfwClassLike)
  {* ����� ������� IsInt
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsInt >>> l_Boolean
[code]  }
 private
 // private methods
   function IsInt(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
     {* ���������� ����� ������� IsInt }
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
 end;//TkwIsInt

// start class TkwIsInt

function TkwIsInt.IsInt(const aCtx: TtfwContext;
  const aSV: TtfwStackValue): Boolean;
//#UC START# *5961904482C4_1E29EA0B90A4_var*
//#UC END# *5961904482C4_1E29EA0B90A4_var*
begin
//#UC START# *5961904482C4_1E29EA0B90A4_impl*
 Result := (aSV.rType = tfw_vtInt);
//#UC END# *5961904482C4_1E29EA0B90A4_impl*
end;//TkwIsInt.IsInt

procedure TkwIsInt.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSV : TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((IsInt(aCtx, l_aSV)));
end;//TkwIsInt.DoDoIt

class function TkwIsInt.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IsInt';
end;//TkwIsInt.GetWordNameForRegister

function TkwIsInt.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwIsInt.GetResultTypeInfo

function TkwIsInt.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwIsInt.GetAllParamsCount

function TkwIsInt.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsInt.ParamsTypes

type
 TkwIsClass = {final scriptword} class(TtfwClassLike)
  {* ����� ������� IsClass
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsClass >>> l_Boolean
[code]  }
 private
 // private methods
   function IsClass(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
     {* ���������� ����� ������� IsClass }
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
 end;//TkwIsClass

// start class TkwIsClass

function TkwIsClass.IsClass(const aCtx: TtfwContext;
  const aSV: TtfwStackValue): Boolean;
//#UC START# *91B47D0849F0_D8E9C4F61308_var*
//#UC END# *91B47D0849F0_D8E9C4F61308_var*
begin
//#UC START# *91B47D0849F0_D8E9C4F61308_impl*
 Result := (aSV.rType = tfw_vtClass);
//#UC END# *91B47D0849F0_D8E9C4F61308_impl*
end;//TkwIsClass.IsClass

procedure TkwIsClass.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSV : TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((IsClass(aCtx, l_aSV)));
end;//TkwIsClass.DoDoIt

class function TkwIsClass.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IsClass';
end;//TkwIsClass.GetWordNameForRegister

function TkwIsClass.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwIsClass.GetResultTypeInfo

function TkwIsClass.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwIsClass.GetAllParamsCount

function TkwIsClass.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsClass.ParamsTypes

type
 TkwToPrintable = {final scriptword} class(TtfwClassLike)
  {* ����� ������� ToPrintable
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aSV ToPrintable >>> l_Il3CString
[code]  }
 private
 // private methods
   function ToPrintable(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Il3CString;
     {* ���������� ����� ������� ToPrintable }
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
 end;//TkwToPrintable

// start class TkwToPrintable

function TkwToPrintable.ToPrintable(const aCtx: TtfwContext;
  const aSV: TtfwStackValue): Il3CString;
//#UC START# *8C01CED67FCB_0B39C51FE7D1_var*
//#UC END# *8C01CED67FCB_0B39C51FE7D1_var*
begin
//#UC START# *8C01CED67FCB_0B39C51FE7D1_impl*
 Result := aSV.AsPrintable;
//#UC END# *8C01CED67FCB_0B39C51FE7D1_impl*
end;//TkwToPrintable.ToPrintable

procedure TkwToPrintable.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSV : TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((ToPrintable(aCtx, l_aSV)));
end;//TkwToPrintable.DoDoIt

class function TkwToPrintable.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ToPrintable';
end;//TkwToPrintable.GetWordNameForRegister

function TkwToPrintable.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwToPrintable.GetResultTypeInfo

function TkwToPrintable.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwToPrintable.GetAllParamsCount

function TkwToPrintable.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwToPrintable.ParamsTypes

type
 TkwIsBool = {final scriptword} class(TtfwClassLike)
  {* ����� ������� IsBool
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsBool >>> l_Boolean
[code]  }
 private
 // private methods
   function IsBool(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
     {* ���������� ����� ������� IsBool }
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
 end;//TkwIsBool

// start class TkwIsBool

function TkwIsBool.IsBool(const aCtx: TtfwContext;
  const aSV: TtfwStackValue): Boolean;
//#UC START# *65885D693C21_805A190E934E_var*
//#UC END# *65885D693C21_805A190E934E_var*
begin
//#UC START# *65885D693C21_805A190E934E_impl*
 Result := (aSV.rType = tfw_vtBool);
//#UC END# *65885D693C21_805A190E934E_impl*
end;//TkwIsBool.IsBool

procedure TkwIsBool.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSV : TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((IsBool(aCtx, l_aSV)));
end;//TkwIsBool.DoDoIt

class function TkwIsBool.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IsBool';
end;//TkwIsBool.GetWordNameForRegister

function TkwIsBool.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwIsBool.GetResultTypeInfo

function TkwIsBool.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwIsBool.GetAllParamsCount

function TkwIsBool.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsBool.ParamsTypes

type
 TkwIsTypeOf = {final scriptword} class(TtfwClassLike)
  {* ����� ������� IsTypeOf
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aType aSV IsTypeOf >>> l_Boolean
[code]  }
 private
 // private methods
   function IsTypeOf(const aCtx: TtfwContext;
    const aSV: TtfwStackValue;
    aType: TtfwValueType): Boolean;
     {* ���������� ����� ������� IsTypeOf }
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
 end;//TkwIsTypeOf

// start class TkwIsTypeOf

function TkwIsTypeOf.IsTypeOf(const aCtx: TtfwContext;
  const aSV: TtfwStackValue;
  aType: TtfwValueType): Boolean;
//#UC START# *97D860339C94_482D1ABE67DA_var*
//#UC END# *97D860339C94_482D1ABE67DA_var*
begin
//#UC START# *97D860339C94_482D1ABE67DA_impl*
 Result := (aSV.rType = aType);
//#UC END# *97D860339C94_482D1ABE67DA_impl*
end;//TkwIsTypeOf.IsTypeOf

procedure TkwIsTypeOf.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSV : TtfwStackValue;
 l_aType : TtfwValueType;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aType := TtfwValueType(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aType: TtfwValueType : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((IsTypeOf(aCtx, l_aSV, l_aType)));
end;//TkwIsTypeOf.DoDoIt

class function TkwIsTypeOf.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IsTypeOf';
end;//TkwIsTypeOf.GetWordNameForRegister

function TkwIsTypeOf.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwIsTypeOf.GetResultTypeInfo

function TkwIsTypeOf.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwIsTypeOf.GetAllParamsCount

function TkwIsTypeOf.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct, TypeInfo(TtfwValueType)]);
end;//TkwIsTypeOf.ParamsTypes

type
 TkwIsNil = {final scriptword} class(TtfwClassLike)
  {* ����� ������� IsNil
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsNil >>> l_Boolean
[code]  }
 private
 // private methods
   function IsNil(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
     {* ���������� ����� ������� IsNil }
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
 end;//TkwIsNil

// start class TkwIsNil

function TkwIsNil.IsNil(const aCtx: TtfwContext;
  const aSV: TtfwStackValue): Boolean;
//#UC START# *1AC4F2BEB556_1D17EAE13A3E_var*
//#UC END# *1AC4F2BEB556_1D17EAE13A3E_var*
begin
//#UC START# *1AC4F2BEB556_1D17EAE13A3E_impl*
 Case aSV.rType of
  tfw_vtNil:
   Result := true;
  tfw_vtVoid:
   Result := false;
  tfw_vtObj:
   Result := (aSV.AsObject = nil);
  tfw_vtIntf:
   Result := (aSV.AsIntf = nil);
  tfw_vtFile:
   Result := (aSV.AsIntf = nil);
  tfw_vtList:
   Result := (aSV.AsIntf = nil);
  tfw_vtStr:
   Result := l3IsNil(aSV.AsString);
  else
  begin
   Result := false;
   BadValueType(aSV.rType, aCtx);
  end;//else
 end;//Case aSV.rType
//#UC END# *1AC4F2BEB556_1D17EAE13A3E_impl*
end;//TkwIsNil.IsNil

procedure TkwIsNil.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSV : TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((IsNil(aCtx, l_aSV)));
end;//TkwIsNil.DoDoIt

class function TkwIsNil.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IsNil';
end;//TkwIsNil.GetWordNameForRegister

function TkwIsNil.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwIsNil.GetResultTypeInfo

function TkwIsNil.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwIsNil.GetAllParamsCount

function TkwIsNil.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsNil.ParamsTypes

type
 TkwCtxIncludeModifier = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:IncludeModifier
[panel]�������� ����������� � ���������� � ����[panel]
*������:*
[code]
 aModifier Ctx:IncludeModifier
[code]  }
 private
 // private methods
   procedure CtxIncludeModifier(const aCtx: TtfwContext;
    aModifier: TtfwWordModifier);
     {* ���������� ����� ������� Ctx:IncludeModifier }
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
 end;//TkwCtxIncludeModifier

// start class TkwCtxIncludeModifier

procedure TkwCtxIncludeModifier.CtxIncludeModifier(const aCtx: TtfwContext;
  aModifier: TtfwWordModifier);
//#UC START# *38D90DF7C305_C05D38D44F64_var*
//#UC END# *38D90DF7C305_C05D38D44F64_var*
begin
//#UC START# *38D90DF7C305_C05D38D44F64_impl*
 aCtx.SetWordInfo(aCtx.rTypeInfo.IncludeModifier(aModifier));
//#UC END# *38D90DF7C305_C05D38D44F64_impl*
end;//TkwCtxIncludeModifier.CtxIncludeModifier

procedure TkwCtxIncludeModifier.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aModifier : TtfwWordModifier;
begin
 try
  l_aModifier := TtfwWordModifier(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aModifier: TtfwWordModifier : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CtxIncludeModifier(aCtx, l_aModifier);
end;//TkwCtxIncludeModifier.DoDoIt

class function TkwCtxIncludeModifier.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:IncludeModifier';
end;//TkwCtxIncludeModifier.GetWordNameForRegister

function TkwCtxIncludeModifier.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCtxIncludeModifier.GetResultTypeInfo

function TkwCtxIncludeModifier.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwCtxIncludeModifier.GetAllParamsCount

function TkwCtxIncludeModifier.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordModifier)]);
end;//TkwCtxIncludeModifier.ParamsTypes

type
 TkwCtxPushCompiler = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:PushCompiler
*��� ����������:* TtfwCompiler
*������:*
[code]
OBJECT VAR l_TtfwCompiler
 Ctx:PushCompiler >>> l_TtfwCompiler
[code]  }
 private
 // private methods
   function CtxPushCompiler(const aCtx: TtfwContext): TtfwCompiler;
     {* ���������� ����� ������� Ctx:PushCompiler }
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
 end;//TkwCtxPushCompiler

// start class TkwCtxPushCompiler

function TkwCtxPushCompiler.CtxPushCompiler(const aCtx: TtfwContext): TtfwCompiler;
//#UC START# *CDAA2A6A2AD7_76B2C4302847_var*
//#UC END# *CDAA2A6A2AD7_76B2C4302847_var*
begin
//#UC START# *CDAA2A6A2AD7_76B2C4302847_impl*
 Result := aCtx.rCompiler;
//#UC END# *CDAA2A6A2AD7_76B2C4302847_impl*
end;//TkwCtxPushCompiler.CtxPushCompiler

procedure TkwCtxPushCompiler.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushObj((CtxPushCompiler(aCtx)));
end;//TkwCtxPushCompiler.DoDoIt

class function TkwCtxPushCompiler.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:PushCompiler';
end;//TkwCtxPushCompiler.GetWordNameForRegister

function TkwCtxPushCompiler.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwCompiler);
end;//TkwCtxPushCompiler.GetResultTypeInfo

function TkwCtxPushCompiler.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCtxPushCompiler.GetAllParamsCount

function TkwCtxPushCompiler.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxPushCompiler.ParamsTypes

type
 TkwCtxPushFinder = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:PushFinder
*��� ����������:* TtfwKeywordFinder
*������:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 Ctx:PushFinder >>> l_TtfwKeywordFinder
[code]  }
 private
 // private methods
   function CtxPushFinder(const aCtx: TtfwContext): TtfwKeywordFinder;
     {* ���������� ����� ������� Ctx:PushFinder }
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
 end;//TkwCtxPushFinder

// start class TkwCtxPushFinder

function TkwCtxPushFinder.CtxPushFinder(const aCtx: TtfwContext): TtfwKeywordFinder;
//#UC START# *ECD8F9EEA9F6_E129F00B5D0B_var*
//#UC END# *ECD8F9EEA9F6_E129F00B5D0B_var*
begin
//#UC START# *ECD8F9EEA9F6_E129F00B5D0B_impl*
 Result := aCtx.rKeyWords;
//#UC END# *ECD8F9EEA9F6_E129F00B5D0B_impl*
end;//TkwCtxPushFinder.CtxPushFinder

procedure TkwCtxPushFinder.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushObj((CtxPushFinder(aCtx)));
end;//TkwCtxPushFinder.DoDoIt

class function TkwCtxPushFinder.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:PushFinder';
end;//TkwCtxPushFinder.GetWordNameForRegister

function TkwCtxPushFinder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwKeywordFinder);
end;//TkwCtxPushFinder.GetResultTypeInfo

function TkwCtxPushFinder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCtxPushFinder.GetAllParamsCount

function TkwCtxPushFinder.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxPushFinder.ParamsTypes

type
 TkwPopCompilerSetToCtx = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� pop:Compiler:SetToCtx
*������:*
[code]
 aCompiler pop:Compiler:SetToCtx
[code]  }
 private
 // private methods
   procedure PopCompilerSetToCtx(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler);
     {* ���������� ����� ������� pop:Compiler:SetToCtx }
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
 end;//TkwPopCompilerSetToCtx

// start class TkwPopCompilerSetToCtx

procedure TkwPopCompilerSetToCtx.PopCompilerSetToCtx(const aCtx: TtfwContext;
  aCompiler: TtfwCompiler);
//#UC START# *7547D1BE3A40_DCE6B328F683_var*
//#UC END# *7547D1BE3A40_DCE6B328F683_var*
begin
//#UC START# *7547D1BE3A40_DCE6B328F683_impl*
 PtfwContext(@aCtx)^.rCompiler := aCompiler;
//#UC END# *7547D1BE3A40_DCE6B328F683_impl*
end;//TkwPopCompilerSetToCtx.PopCompilerSetToCtx

procedure TkwPopCompilerSetToCtx.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCompiler : TtfwCompiler;
begin
 try
  l_aCompiler := TtfwCompiler(aCtx.rEngine.PopObjAs(TtfwCompiler));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCompiler: TtfwCompiler : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 PopCompilerSetToCtx(aCtx, l_aCompiler);
end;//TkwPopCompilerSetToCtx.DoDoIt

class function TkwPopCompilerSetToCtx.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Compiler:SetToCtx';
end;//TkwPopCompilerSetToCtx.GetWordNameForRegister

function TkwPopCompilerSetToCtx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopCompilerSetToCtx.GetResultTypeInfo

function TkwPopCompilerSetToCtx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwPopCompilerSetToCtx.GetAllParamsCount

function TkwPopCompilerSetToCtx.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwCompiler)]);
end;//TkwPopCompilerSetToCtx.ParamsTypes

type
 TkwPopFinderSetToCtx = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� pop:Finder:SetToCtx
*������:*
[code]
 aFinder pop:Finder:SetToCtx
[code]  }
 private
 // private methods
   procedure PopFinderSetToCtx(const aCtx: TtfwContext;
    aFinder: TtfwKeywordFinder);
     {* ���������� ����� ������� pop:Finder:SetToCtx }
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
 end;//TkwPopFinderSetToCtx

// start class TkwPopFinderSetToCtx

procedure TkwPopFinderSetToCtx.PopFinderSetToCtx(const aCtx: TtfwContext;
  aFinder: TtfwKeywordFinder);
//#UC START# *F415B417142F_5222729B474B_var*
//#UC END# *F415B417142F_5222729B474B_var*
begin
//#UC START# *F415B417142F_5222729B474B_impl*
 PtfwContext(@aCtx).rKeyWords := aFinder;
//#UC END# *F415B417142F_5222729B474B_impl*
end;//TkwPopFinderSetToCtx.PopFinderSetToCtx

procedure TkwPopFinderSetToCtx.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aFinder : TtfwKeywordFinder;
begin
 try
  l_aFinder := TtfwKeywordFinder(aCtx.rEngine.PopObjAs(TtfwKeywordFinder, true));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFinder: TtfwKeywordFinder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 PopFinderSetToCtx(aCtx, l_aFinder);
end;//TkwPopFinderSetToCtx.DoDoIt

class function TkwPopFinderSetToCtx.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Finder:SetToCtx';
end;//TkwPopFinderSetToCtx.GetWordNameForRegister

function TkwPopFinderSetToCtx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopFinderSetToCtx.GetResultTypeInfo

function TkwPopFinderSetToCtx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwPopFinderSetToCtx.GetAllParamsCount

function TkwPopFinderSetToCtx.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwKeywordFinder)]);
end;//TkwPopFinderSetToCtx.ParamsTypes

type
 TkwNotImplemented = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� NotImplemented
*������:*
[code]
 NotImplemented
[code]  }
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
 end;//TkwNotImplemented

// start class TkwNotImplemented

procedure TkwNotImplemented.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_723DBAD5D836_var*
//#UC END# *4DAEEDE10285_723DBAD5D836_var*
begin
//#UC START# *4DAEEDE10285_723DBAD5D836_impl*
 RunnerError('�� �����������', aCtx);
//#UC END# *4DAEEDE10285_723DBAD5D836_impl*
end;//TkwNotImplemented.DoDoIt

class function TkwNotImplemented.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'NotImplemented';
end;//TkwNotImplemented.GetWordNameForRegister

function TkwNotImplemented.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwNotImplemented.GetResultTypeInfo

function TkwNotImplemented.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwNotImplemented.GetAllParamsCount

type
 TkwCtxNewWordDefinitor = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:NewWordDefinitor
*��� ����������:* TtfwNewWordDefinitor
*������:*
[code]
OBJECT VAR l_TtfwNewWordDefinitor
 Ctx:NewWordDefinitor >>> l_TtfwNewWordDefinitor
[code]  }
 private
 // private methods
   function CtxNewWordDefinitor(const aCtx: TtfwContext): TtfwNewWordDefinitor;
     {* ���������� ����� ������� Ctx:NewWordDefinitor }
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
 end;//TkwCtxNewWordDefinitor

// start class TkwCtxNewWordDefinitor

function TkwCtxNewWordDefinitor.CtxNewWordDefinitor(const aCtx: TtfwContext): TtfwNewWordDefinitor;
//#UC START# *A3EE7AAF51AE_727C5ED83D51_var*
//#UC END# *A3EE7AAF51AE_727C5ED83D51_var*
begin
//#UC START# *A3EE7AAF51AE_727C5ED83D51_impl*
 Assert(aCtx.rCompiler <> nil);
 Result := aCtx.rCompiler.NewWordDefinitor;
//#UC END# *A3EE7AAF51AE_727C5ED83D51_impl*
end;//TkwCtxNewWordDefinitor.CtxNewWordDefinitor

procedure TkwCtxNewWordDefinitor.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushObj((CtxNewWordDefinitor(aCtx)));
end;//TkwCtxNewWordDefinitor.DoDoIt

class function TkwCtxNewWordDefinitor.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:NewWordDefinitor';
end;//TkwCtxNewWordDefinitor.GetWordNameForRegister

function TkwCtxNewWordDefinitor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwNewWordDefinitor);
end;//TkwCtxNewWordDefinitor.GetResultTypeInfo

function TkwCtxNewWordDefinitor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCtxNewWordDefinitor.GetAllParamsCount

function TkwCtxNewWordDefinitor.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxNewWordDefinitor.ParamsTypes

type
 TkwCtxClearTypeInfo = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:ClearTypeInfo
*������:*
[code]
 Ctx:ClearTypeInfo
[code]  }
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
 end;//TkwCtxClearTypeInfo

// start class TkwCtxClearTypeInfo

procedure TkwCtxClearTypeInfo.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A118FE89A230_var*
//#UC END# *4DAEEDE10285_A118FE89A230_var*
begin
//#UC START# *4DAEEDE10285_A118FE89A230_impl*
 aCtx.SetWordInfo(TtfwWordInfoE.Instance);
//#UC END# *4DAEEDE10285_A118FE89A230_impl*
end;//TkwCtxClearTypeInfo.DoDoIt

class function TkwCtxClearTypeInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:ClearTypeInfo';
end;//TkwCtxClearTypeInfo.GetWordNameForRegister

function TkwCtxClearTypeInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCtxClearTypeInfo.GetResultTypeInfo

function TkwCtxClearTypeInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCtxClearTypeInfo.GetAllParamsCount

type
 TkwCtxSetWordProducerForCompiledClass = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:SetWordProducerForCompiledClass
*������:*
[code]
 aProducer Ctx:SetWordProducerForCompiledClass
[code]  }
 private
 // private methods
   procedure CtxSetWordProducerForCompiledClass(const aCtx: TtfwContext;
    aProducer: TtfwWord);
     {* ���������� ����� ������� Ctx:SetWordProducerForCompiledClass }
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
 end;//TkwCtxSetWordProducerForCompiledClass

// start class TkwCtxSetWordProducerForCompiledClass

procedure TkwCtxSetWordProducerForCompiledClass.CtxSetWordProducerForCompiledClass(const aCtx: TtfwContext;
  aProducer: TtfwWord);
//#UC START# *FAD614919182_6940038A26AA_var*
//#UC END# *FAD614919182_6940038A26AA_var*
begin
//#UC START# *FAD614919182_6940038A26AA_impl*
 PtfwContext(@aCtx)^.rWordProducerForCompiledClass := aProducer;
//#UC END# *FAD614919182_6940038A26AA_impl*
end;//TkwCtxSetWordProducerForCompiledClass.CtxSetWordProducerForCompiledClass

procedure TkwCtxSetWordProducerForCompiledClass.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aProducer : TtfwWord;
begin
 try
  l_aProducer := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord, true));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aProducer: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CtxSetWordProducerForCompiledClass(aCtx, l_aProducer);
end;//TkwCtxSetWordProducerForCompiledClass.DoDoIt

class function TkwCtxSetWordProducerForCompiledClass.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:SetWordProducerForCompiledClass';
end;//TkwCtxSetWordProducerForCompiledClass.GetWordNameForRegister

function TkwCtxSetWordProducerForCompiledClass.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCtxSetWordProducerForCompiledClass.GetResultTypeInfo

function TkwCtxSetWordProducerForCompiledClass.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwCtxSetWordProducerForCompiledClass.GetAllParamsCount

function TkwCtxSetWordProducerForCompiledClass.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwCtxSetWordProducerForCompiledClass.ParamsTypes

type
 TkwCtxSetNewWordName = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:SetNewWordName
*������:*
[code]
 aValue Ctx:SetNewWordName
[code]  }
 private
 // private methods
   procedure CtxSetNewWordName(const aCtx: TtfwContext;
    const aValue: Il3CString);
     {* ���������� ����� ������� Ctx:SetNewWordName }
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
 end;//TkwCtxSetNewWordName

// start class TkwCtxSetNewWordName

procedure TkwCtxSetNewWordName.CtxSetNewWordName(const aCtx: TtfwContext;
  const aValue: Il3CString);
//#UC START# *88A555297CD8_C23B404259CC_var*
//#UC END# *88A555297CD8_C23B404259CC_var*
begin
//#UC START# *88A555297CD8_C23B404259CC_impl*
 PtfwContext(@aCtx)^.rNewWordName := aValue;
//#UC END# *88A555297CD8_C23B404259CC_impl*
end;//TkwCtxSetNewWordName.CtxSetNewWordName

procedure TkwCtxSetNewWordName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aValue : Il3CString;
begin
 try
  l_aValue := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CtxSetNewWordName(aCtx, l_aValue);
end;//TkwCtxSetNewWordName.DoDoIt

class function TkwCtxSetNewWordName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:SetNewWordName';
end;//TkwCtxSetNewWordName.GetWordNameForRegister

function TkwCtxSetNewWordName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCtxSetNewWordName.GetResultTypeInfo

function TkwCtxSetNewWordName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwCtxSetNewWordName.GetAllParamsCount

function TkwCtxSetNewWordName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwCtxSetNewWordName.ParamsTypes

type
 TkwCtxIncludeTypeModifier = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:IncludeTypeModifier
*������:*
[code]
 aType Ctx:IncludeTypeModifier
[code]  }
 private
 // private methods
   procedure CtxIncludeTypeModifier(const aCtx: TtfwContext;
    aType: TtfwValueType);
     {* ���������� ����� ������� Ctx:IncludeTypeModifier }
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
 end;//TkwCtxIncludeTypeModifier

// start class TkwCtxIncludeTypeModifier

procedure TkwCtxIncludeTypeModifier.CtxIncludeTypeModifier(const aCtx: TtfwContext;
  aType: TtfwValueType);
//#UC START# *C76389C21A2D_286CAF6C6B6A_var*
//#UC END# *C76389C21A2D_286CAF6C6B6A_var*
begin
//#UC START# *C76389C21A2D_286CAF6C6B6A_impl*
 aCtx.SetWordInfo(aCtx.rTypeInfo.IncludeTypeModifier(aType));
//#UC END# *C76389C21A2D_286CAF6C6B6A_impl*
end;//TkwCtxIncludeTypeModifier.CtxIncludeTypeModifier

procedure TkwCtxIncludeTypeModifier.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aType : TtfwValueType;
begin
 try
  l_aType := TtfwValueType(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aType: TtfwValueType : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CtxIncludeTypeModifier(aCtx, l_aType);
end;//TkwCtxIncludeTypeModifier.DoDoIt

class function TkwCtxIncludeTypeModifier.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:IncludeTypeModifier';
end;//TkwCtxIncludeTypeModifier.GetWordNameForRegister

function TkwCtxIncludeTypeModifier.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCtxIncludeTypeModifier.GetResultTypeInfo

function TkwCtxIncludeTypeModifier.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwCtxIncludeTypeModifier.GetAllParamsCount

function TkwCtxIncludeTypeModifier.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwValueType)]);
end;//TkwCtxIncludeTypeModifier.ParamsTypes

type
 TkwCtxWordDefiningNow = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:WordDefiningNow
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 Ctx:WordDefiningNow >>> l_TtfwWord
[code]  }
 private
 // private methods
   function CtxWordDefiningNow(const aCtx: TtfwContext): TtfwWord;
     {* ���������� ����� ������� Ctx:WordDefiningNow }
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
 end;//TkwCtxWordDefiningNow

// start class TkwCtxWordDefiningNow

function TkwCtxWordDefiningNow.CtxWordDefiningNow(const aCtx: TtfwContext): TtfwWord;
//#UC START# *03F9D805A35E_F9DC6877556A_var*
//#UC END# *03F9D805A35E_F9DC6877556A_var*
begin
//#UC START# *03F9D805A35E_F9DC6877556A_impl*
 Result := aCtx.rWordDefiningNow;
//#UC END# *03F9D805A35E_F9DC6877556A_impl*
end;//TkwCtxWordDefiningNow.CtxWordDefiningNow

procedure TkwCtxWordDefiningNow.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushObj((CtxWordDefiningNow(aCtx)));
end;//TkwCtxWordDefiningNow.DoDoIt

class function TkwCtxWordDefiningNow.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:WordDefiningNow';
end;//TkwCtxWordDefiningNow.GetWordNameForRegister

function TkwCtxWordDefiningNow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwWord);
end;//TkwCtxWordDefiningNow.GetResultTypeInfo

function TkwCtxWordDefiningNow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCtxWordDefiningNow.GetAllParamsCount

function TkwCtxWordDefiningNow.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxWordDefiningNow.ParamsTypes

type
 TkwCtxKeyWordDefiningNow = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:KeyWordDefiningNow
*��� ����������:* TtfwKeyWord
*������:*
[code]
OBJECT VAR l_TtfwKeyWord
 Ctx:KeyWordDefiningNow >>> l_TtfwKeyWord
[code]  }
 private
 // private methods
   function CtxKeyWordDefiningNow(const aCtx: TtfwContext): TtfwKeyWord;
     {* ���������� ����� ������� Ctx:KeyWordDefiningNow }
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
 end;//TkwCtxKeyWordDefiningNow

// start class TkwCtxKeyWordDefiningNow

function TkwCtxKeyWordDefiningNow.CtxKeyWordDefiningNow(const aCtx: TtfwContext): TtfwKeyWord;
//#UC START# *256B4C029617_1C2D3DEAE952_var*
//#UC END# *256B4C029617_1C2D3DEAE952_var*
begin
//#UC START# *256B4C029617_1C2D3DEAE952_impl*
 Result := aCtx.rKeyWordDefiningNow;
//#UC END# *256B4C029617_1C2D3DEAE952_impl*
end;//TkwCtxKeyWordDefiningNow.CtxKeyWordDefiningNow

procedure TkwCtxKeyWordDefiningNow.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushObj((CtxKeyWordDefiningNow(aCtx)));
end;//TkwCtxKeyWordDefiningNow.DoDoIt

class function TkwCtxKeyWordDefiningNow.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:KeyWordDefiningNow';
end;//TkwCtxKeyWordDefiningNow.GetWordNameForRegister

function TkwCtxKeyWordDefiningNow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwKeyWord);
end;//TkwCtxKeyWordDefiningNow.GetResultTypeInfo

function TkwCtxKeyWordDefiningNow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCtxKeyWordDefiningNow.GetAllParamsCount

function TkwCtxKeyWordDefiningNow.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxKeyWordDefiningNow.ParamsTypes

type
 TkwCtxIncludeAccessType = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:IncludeAccessType
*������:*
[code]
 anAccess Ctx:IncludeAccessType
[code]  }
 private
 // private methods
   procedure CtxIncludeAccessType(const aCtx: TtfwContext;
    anAccess: TtfwAccessType);
     {* ���������� ����� ������� Ctx:IncludeAccessType }
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
 end;//TkwCtxIncludeAccessType

// start class TkwCtxIncludeAccessType

procedure TkwCtxIncludeAccessType.CtxIncludeAccessType(const aCtx: TtfwContext;
  anAccess: TtfwAccessType);
//#UC START# *AA17108711E6_7AAC4F1C32BA_var*
//#UC END# *AA17108711E6_7AAC4F1C32BA_var*
begin
//#UC START# *AA17108711E6_7AAC4F1C32BA_impl*
 aCtx.SetWordInfo(aCtx.rTypeInfo.IncludeAccesType(anAccess));
//#UC END# *AA17108711E6_7AAC4F1C32BA_impl*
end;//TkwCtxIncludeAccessType.CtxIncludeAccessType

procedure TkwCtxIncludeAccessType.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_anAccess : TtfwAccessType;
begin
 try
  l_anAccess := TtfwAccessType(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anAccess: TtfwAccessType : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CtxIncludeAccessType(aCtx, l_anAccess);
end;//TkwCtxIncludeAccessType.DoDoIt

class function TkwCtxIncludeAccessType.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:IncludeAccessType';
end;//TkwCtxIncludeAccessType.GetWordNameForRegister

function TkwCtxIncludeAccessType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCtxIncludeAccessType.GetResultTypeInfo

function TkwCtxIncludeAccessType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwCtxIncludeAccessType.GetAllParamsCount

function TkwCtxIncludeAccessType.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwAccessType)]);
end;//TkwCtxIncludeAccessType.ParamsTypes

type
 TkwCtxIncludeLinkType = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:IncludeLinkType
*������:*
[code]
 aLinkType Ctx:IncludeLinkType
[code]  }
 private
 // private methods
   procedure CtxIncludeLinkType(const aCtx: TtfwContext;
    aLinkType: TtfwLinkType);
     {* ���������� ����� ������� Ctx:IncludeLinkType }
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
 end;//TkwCtxIncludeLinkType

// start class TkwCtxIncludeLinkType

procedure TkwCtxIncludeLinkType.CtxIncludeLinkType(const aCtx: TtfwContext;
  aLinkType: TtfwLinkType);
//#UC START# *23B154B4DBB8_53FBB3F9AAFD_var*
//#UC END# *23B154B4DBB8_53FBB3F9AAFD_var*
begin
//#UC START# *23B154B4DBB8_53FBB3F9AAFD_impl*
 aCtx.SetWordInfo(aCtx.rTypeInfo.IncludeLinkType(aLinkType));
//#UC END# *23B154B4DBB8_53FBB3F9AAFD_impl*
end;//TkwCtxIncludeLinkType.CtxIncludeLinkType

procedure TkwCtxIncludeLinkType.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLinkType : TtfwLinkType;
begin
 try
  l_aLinkType := TtfwLinkType(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLinkType: TtfwLinkType : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CtxIncludeLinkType(aCtx, l_aLinkType);
end;//TkwCtxIncludeLinkType.DoDoIt

class function TkwCtxIncludeLinkType.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:IncludeLinkType';
end;//TkwCtxIncludeLinkType.GetWordNameForRegister

function TkwCtxIncludeLinkType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCtxIncludeLinkType.GetResultTypeInfo

function TkwCtxIncludeLinkType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwCtxIncludeLinkType.GetAllParamsCount

function TkwCtxIncludeLinkType.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwLinkType)]);
end;//TkwCtxIncludeLinkType.ParamsTypes

type
 TkwCtxValueTypes = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:ValueTypes
*��� ����������:* TtfwValueTypes
*������:*
[code]
OBJECT VAR l_TtfwValueTypes
 Ctx:ValueTypes >>> l_TtfwValueTypes
[code]  }
 private
 // private methods
   function CtxValueTypes(const aCtx: TtfwContext): TtfwValueTypes;
     {* ���������� ����� ������� Ctx:ValueTypes }
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
 end;//TkwCtxValueTypes

// start class TkwCtxValueTypes

function TkwCtxValueTypes.CtxValueTypes(const aCtx: TtfwContext): TtfwValueTypes;
//#UC START# *352E66091EEC_2701D2795604_var*
//#UC END# *352E66091EEC_2701D2795604_var*
begin
//#UC START# *352E66091EEC_2701D2795604_impl*
 Result := aCtx.rTypeInfo.ValueTypes;
//#UC END# *352E66091EEC_2701D2795604_impl*
end;//TkwCtxValueTypes.CtxValueTypes

procedure TkwCtxValueTypes.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushObj((CtxValueTypes(aCtx)));
end;//TkwCtxValueTypes.DoDoIt

class function TkwCtxValueTypes.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:ValueTypes';
end;//TkwCtxValueTypes.GetWordNameForRegister

function TkwCtxValueTypes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwValueTypes);
end;//TkwCtxValueTypes.GetResultTypeInfo

function TkwCtxValueTypes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCtxValueTypes.GetAllParamsCount

function TkwCtxValueTypes.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxValueTypes.ParamsTypes

type
 TkwCtxSetValueTypes = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:SetValueTypes
*������:*
[code]
 aTypes Ctx:SetValueTypes
[code]  }
 private
 // private methods
   procedure CtxSetValueTypes(const aCtx: TtfwContext;
    aTypes: TtfwValueTypes);
     {* ���������� ����� ������� Ctx:SetValueTypes }
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
 end;//TkwCtxSetValueTypes

// start class TkwCtxSetValueTypes

procedure TkwCtxSetValueTypes.CtxSetValueTypes(const aCtx: TtfwContext;
  aTypes: TtfwValueTypes);
//#UC START# *712E549F6918_0501B6DEBAE2_var*
//#UC END# *712E549F6918_0501B6DEBAE2_var*
begin
//#UC START# *712E549F6918_0501B6DEBAE2_impl*
 aCtx.SetWordInfo(TtfwWordInfo.Make(aTypes, [], tfw_atNone, tfw_ltNone));
//#UC END# *712E549F6918_0501B6DEBAE2_impl*
end;//TkwCtxSetValueTypes.CtxSetValueTypes

procedure TkwCtxSetValueTypes.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTypes : TtfwValueTypes;
begin
 try
  l_aTypes := TtfwValueTypes(aCtx.rEngine.PopObjAs(TtfwValueTypes, true));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTypes: TtfwValueTypes : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CtxSetValueTypes(aCtx, l_aTypes);
end;//TkwCtxSetValueTypes.DoDoIt

class function TkwCtxSetValueTypes.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:SetValueTypes';
end;//TkwCtxSetValueTypes.GetWordNameForRegister

function TkwCtxSetValueTypes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCtxSetValueTypes.GetResultTypeInfo

function TkwCtxSetValueTypes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwCtxSetValueTypes.GetAllParamsCount

function TkwCtxSetValueTypes.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwValueTypes)]);
end;//TkwCtxSetValueTypes.ParamsTypes

type
 TkwCtxIncludeValueTypes = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:IncludeValueTypes
*������:*
[code]
 aTypes Ctx:IncludeValueTypes
[code]  }
 private
 // private methods
   procedure CtxIncludeValueTypes(const aCtx: TtfwContext;
    aTypes: TtfwValueTypes);
     {* ���������� ����� ������� Ctx:IncludeValueTypes }
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
 end;//TkwCtxIncludeValueTypes

// start class TkwCtxIncludeValueTypes

procedure TkwCtxIncludeValueTypes.CtxIncludeValueTypes(const aCtx: TtfwContext;
  aTypes: TtfwValueTypes);
//#UC START# *A48D2ADCEACA_183633344722_var*
//#UC END# *A48D2ADCEACA_183633344722_var*
begin
//#UC START# *A48D2ADCEACA_183633344722_impl*
 aCtx.SetWordInfo(TtfwWordInfo.Make(aCtx.rTypeInfo.ValueTypes.Add(aTypes), aCtx.rTypeInfo.Modifiers, aCtx.rTypeInfo.AccessType, aCtx.rTypeInfo.LinkType));
//#UC END# *A48D2ADCEACA_183633344722_impl*
end;//TkwCtxIncludeValueTypes.CtxIncludeValueTypes

procedure TkwCtxIncludeValueTypes.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTypes : TtfwValueTypes;
begin
 try
  l_aTypes := TtfwValueTypes(aCtx.rEngine.PopObjAs(TtfwValueTypes, true));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTypes: TtfwValueTypes : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CtxIncludeValueTypes(aCtx, l_aTypes);
end;//TkwCtxIncludeValueTypes.DoDoIt

class function TkwCtxIncludeValueTypes.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:IncludeValueTypes';
end;//TkwCtxIncludeValueTypes.GetWordNameForRegister

function TkwCtxIncludeValueTypes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwCtxIncludeValueTypes.GetResultTypeInfo

function TkwCtxIncludeValueTypes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwCtxIncludeValueTypes.GetAllParamsCount

function TkwCtxIncludeValueTypes.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwValueTypes)]);
end;//TkwCtxIncludeValueTypes.ParamsTypes

type
 TkwCtxWordInfo = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:WordInfo
*��� ����������:* TtfwWordInfo
*������:*
[code]
OBJECT VAR l_TtfwWordInfo
 Ctx:WordInfo >>> l_TtfwWordInfo
[code]  }
 private
 // private methods
   function CtxWordInfo(const aCtx: TtfwContext): TtfwWordInfo;
     {* ���������� ����� ������� Ctx:WordInfo }
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
 end;//TkwCtxWordInfo

// start class TkwCtxWordInfo

function TkwCtxWordInfo.CtxWordInfo(const aCtx: TtfwContext): TtfwWordInfo;
//#UC START# *FFF18757733C_3BE27B131D46_var*
//#UC END# *FFF18757733C_3BE27B131D46_var*
begin
//#UC START# *FFF18757733C_3BE27B131D46_impl*
 Result := aCtx.rTypeInfo;
//#UC END# *FFF18757733C_3BE27B131D46_impl*
end;//TkwCtxWordInfo.CtxWordInfo

procedure TkwCtxWordInfo.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushObj((CtxWordInfo(aCtx)));
end;//TkwCtxWordInfo.DoDoIt

class function TkwCtxWordInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:WordInfo';
end;//TkwCtxWordInfo.GetWordNameForRegister

function TkwCtxWordInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwWordInfo);
end;//TkwCtxWordInfo.GetResultTypeInfo

function TkwCtxWordInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCtxWordInfo.GetAllParamsCount

function TkwCtxWordInfo.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxWordInfo.ParamsTypes

type
 TkwCtxResolveIncludedFilePath = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:ResolveIncludedFilePath
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aFileName Ctx:ResolveIncludedFilePath >>> l_String
[code]  }
 private
 // private methods
   function CtxResolveIncludedFilePath(const aCtx: TtfwContext;
    const aFileName: AnsiString): AnsiString;
     {* ���������� ����� ������� Ctx:ResolveIncludedFilePath }
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
 end;//TkwCtxResolveIncludedFilePath

// start class TkwCtxResolveIncludedFilePath

function TkwCtxResolveIncludedFilePath.CtxResolveIncludedFilePath(const aCtx: TtfwContext;
  const aFileName: AnsiString): AnsiString;
//#UC START# *C1B1C109F815_880CCE28EDF4_var*
//#UC END# *C1B1C109F815_880CCE28EDF4_var*
begin
//#UC START# *C1B1C109F815_880CCE28EDF4_impl*
 Result := aCtx.ResolveIncludedFilePath(aFileName);
//#UC END# *C1B1C109F815_880CCE28EDF4_impl*
end;//TkwCtxResolveIncludedFilePath.CtxResolveIncludedFilePath

procedure TkwCtxResolveIncludedFilePath.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aFileName : AnsiString;
begin
 try
  l_aFileName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFileName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((CtxResolveIncludedFilePath(aCtx, l_aFileName)));
end;//TkwCtxResolveIncludedFilePath.DoDoIt

class function TkwCtxResolveIncludedFilePath.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:ResolveIncludedFilePath';
end;//TkwCtxResolveIncludedFilePath.GetWordNameForRegister

function TkwCtxResolveIncludedFilePath.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwCtxResolveIncludedFilePath.GetResultTypeInfo

function TkwCtxResolveIncludedFilePath.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwCtxResolveIncludedFilePath.GetAllParamsCount

function TkwCtxResolveIncludedFilePath.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(AnsiString)]);
end;//TkwCtxResolveIncludedFilePath.ParamsTypes

type
 TkwCtxMainDictionary = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:MainDictionary
*��� ����������:* TtfwMainDictionary
*������:*
[code]
OBJECT VAR l_TtfwMainDictionary
 Ctx:MainDictionary >>> l_TtfwMainDictionary
[code]  }
 private
 // private methods
   function CtxMainDictionary(const aCtx: TtfwContext): TtfwMainDictionary;
     {* ���������� ����� ������� Ctx:MainDictionary }
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
 end;//TkwCtxMainDictionary

// start class TkwCtxMainDictionary

function TkwCtxMainDictionary.CtxMainDictionary(const aCtx: TtfwContext): TtfwMainDictionary;
//#UC START# *F12DBD5766C9_F387799EAE1E_var*
//#UC END# *F12DBD5766C9_F387799EAE1E_var*
begin
//#UC START# *F12DBD5766C9_F387799EAE1E_impl*
 Result := (aCtx.rEngine As ItfwScriptEngineEx).MainDictionary;
//#UC END# *F12DBD5766C9_F387799EAE1E_impl*
end;//TkwCtxMainDictionary.CtxMainDictionary

procedure TkwCtxMainDictionary.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushObj((CtxMainDictionary(aCtx)));
end;//TkwCtxMainDictionary.DoDoIt

class function TkwCtxMainDictionary.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:MainDictionary';
end;//TkwCtxMainDictionary.GetWordNameForRegister

function TkwCtxMainDictionary.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwMainDictionary);
end;//TkwCtxMainDictionary.GetResultTypeInfo

function TkwCtxMainDictionary.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCtxMainDictionary.GetAllParamsCount

function TkwCtxMainDictionary.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxMainDictionary.ParamsTypes

type
 TkwCtxStandardDictionaries = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:StandardDictionaries
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 Ctx:StandardDictionaries >>> l_ItfwValueList
[code]  }
 private
 // private methods
   function CtxStandardDictionaries(const aCtx: TtfwContext): ItfwValueList;
     {* ���������� ����� ������� Ctx:StandardDictionaries }
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
 end;//TkwCtxStandardDictionaries

// start class TkwCtxStandardDictionaries

function TkwCtxStandardDictionaries.CtxStandardDictionaries(const aCtx: TtfwContext): ItfwValueList;
//#UC START# *9CB880934455_7FC312875F45_var*
//#UC END# *9CB880934455_7FC312875F45_var*
begin
//#UC START# *9CB880934455_7FC312875F45_impl*
 Result := TtfwStandardDictionaryListIterator.Make(TtfwStandardDictionaries.Instance);
//#UC END# *9CB880934455_7FC312875F45_impl*
end;//TkwCtxStandardDictionaries.CtxStandardDictionaries

procedure TkwCtxStandardDictionaries.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushList((CtxStandardDictionaries(aCtx)));
end;//TkwCtxStandardDictionaries.DoDoIt

class function TkwCtxStandardDictionaries.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:StandardDictionaries';
end;//TkwCtxStandardDictionaries.GetWordNameForRegister

function TkwCtxStandardDictionaries.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwCtxStandardDictionaries.GetResultTypeInfo

function TkwCtxStandardDictionaries.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCtxStandardDictionaries.GetAllParamsCount

function TkwCtxStandardDictionaries.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxStandardDictionaries.ParamsTypes

type
 TkwCtxDictionaries = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:Dictionaries
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 Ctx:Dictionaries >>> l_ItfwValueList
[code]  }
 private
 // private methods
   function CtxDictionaries(const aCtx: TtfwContext): ItfwValueList;
     {* ���������� ����� ������� Ctx:Dictionaries }
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
 end;//TkwCtxDictionaries

// start class TkwCtxDictionaries

function TkwCtxDictionaries.CtxDictionaries(const aCtx: TtfwContext): ItfwValueList;
//#UC START# *78F97FD56568_2A2848913C0E_var*
//#UC END# *78F97FD56568_2A2848913C0E_var*
begin
//#UC START# *78F97FD56568_2A2848913C0E_impl*
 Result := TtfwDictionaryListIterator.Make((aCtx.rEngine As ItfwScriptEngineEx).Dictionaries);
//#UC END# *78F97FD56568_2A2848913C0E_impl*
end;//TkwCtxDictionaries.CtxDictionaries

procedure TkwCtxDictionaries.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushList((CtxDictionaries(aCtx)));
end;//TkwCtxDictionaries.DoDoIt

class function TkwCtxDictionaries.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:Dictionaries';
end;//TkwCtxDictionaries.GetWordNameForRegister

function TkwCtxDictionaries.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwCtxDictionaries.GetResultTypeInfo

function TkwCtxDictionaries.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCtxDictionaries.GetAllParamsCount

function TkwCtxDictionaries.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxDictionaries.ParamsTypes

type
 TkwCtxInitedDictionaries = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:InitedDictionaries
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 Ctx:InitedDictionaries >>> l_ItfwValueList
[code]  }
 private
 // private methods
   function CtxInitedDictionaries(const aCtx: TtfwContext): ItfwValueList;
     {* ���������� ����� ������� Ctx:InitedDictionaries }
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
 end;//TkwCtxInitedDictionaries

// start class TkwCtxInitedDictionaries

function TkwCtxInitedDictionaries.CtxInitedDictionaries(const aCtx: TtfwContext): ItfwValueList;
//#UC START# *7DD94B76F5AF_2B152A45C4EE_var*
//#UC END# *7DD94B76F5AF_2B152A45C4EE_var*
begin
//#UC START# *7DD94B76F5AF_2B152A45C4EE_impl*
 Result := TtfwInitedDictionariesListIterator.Make((aCtx.rEngine As ItfwScriptEngineEx).InitedDictionaries);
//#UC END# *7DD94B76F5AF_2B152A45C4EE_impl*
end;//TkwCtxInitedDictionaries.CtxInitedDictionaries

procedure TkwCtxInitedDictionaries.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushList((CtxInitedDictionaries(aCtx)));
end;//TkwCtxInitedDictionaries.DoDoIt

class function TkwCtxInitedDictionaries.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:InitedDictionaries';
end;//TkwCtxInitedDictionaries.GetWordNameForRegister

function TkwCtxInitedDictionaries.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwCtxInitedDictionaries.GetResultTypeInfo

function TkwCtxInitedDictionaries.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCtxInitedDictionaries.GetAllParamsCount

function TkwCtxInitedDictionaries.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxInitedDictionaries.ParamsTypes

type
 TkwCtxDisabledForHelp = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:DisabledForHelp
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 Ctx:DisabledForHelp >>> l_ItfwValueList
[code]  }
 private
 // private methods
   function CtxDisabledForHelp(const aCtx: TtfwContext): ItfwValueList;
     {* ���������� ����� ������� Ctx:DisabledForHelp }
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
 end;//TkwCtxDisabledForHelp

// start class TkwCtxDisabledForHelp

function TkwCtxDisabledForHelp.CtxDisabledForHelp(const aCtx: TtfwContext): ItfwValueList;
//#UC START# *F777D1BA53D9_DDA19C1F4E5B_var*
//#UC END# *F777D1BA53D9_DDA19C1F4E5B_var*
begin
//#UC START# *F777D1BA53D9_DDA19C1F4E5B_impl*
 Result := TtfwWordsIterator.Make((aCtx.rEngine As ItfwScriptEngineEx).DisabledForHelp);
//#UC END# *F777D1BA53D9_DDA19C1F4E5B_impl*
end;//TkwCtxDisabledForHelp.CtxDisabledForHelp

procedure TkwCtxDisabledForHelp.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushList((CtxDisabledForHelp(aCtx)));
end;//TkwCtxDisabledForHelp.DoDoIt

class function TkwCtxDisabledForHelp.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Ctx:DisabledForHelp';
end;//TkwCtxDisabledForHelp.GetWordNameForRegister

function TkwCtxDisabledForHelp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwCtxDisabledForHelp.GetResultTypeInfo

function TkwCtxDisabledForHelp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwCtxDisabledForHelp.GetAllParamsCount

function TkwCtxDisabledForHelp.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxDisabledForHelp.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� ������������ �����������
 TTypeInfoPackResNameGetter.Register;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� IsArray
 TkwIsArray.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� IsVoid
 TkwIsVoid.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� IsObj
 TkwIsObj.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� IsIntf
 TkwIsIntf.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� IsChar
 TkwIsChar.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� IsString
 TkwIsString.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� IsInt
 TkwIsInt.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� IsClass
 TkwIsClass.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ToPrintable
 TkwToPrintable.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� IsBool
 TkwIsBool.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� IsTypeOf
 TkwIsTypeOf.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� IsNil
 TkwIsNil.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_IncludeModifier
 TkwCtxIncludeModifier.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_PushCompiler
 TkwCtxPushCompiler.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_PushFinder
 TkwCtxPushFinder.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Compiler_SetToCtx
 TkwPopCompilerSetToCtx.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Finder_SetToCtx
 TkwPopFinderSetToCtx.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� NotImplemented
 TkwNotImplemented.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_NewWordDefinitor
 TkwCtxNewWordDefinitor.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_ClearTypeInfo
 TkwCtxClearTypeInfo.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_SetWordProducerForCompiledClass
 TkwCtxSetWordProducerForCompiledClass.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_SetNewWordName
 TkwCtxSetNewWordName.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_IncludeTypeModifier
 TkwCtxIncludeTypeModifier.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_WordDefiningNow
 TkwCtxWordDefiningNow.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_KeyWordDefiningNow
 TkwCtxKeyWordDefiningNow.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_IncludeAccessType
 TkwCtxIncludeAccessType.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_IncludeLinkType
 TkwCtxIncludeLinkType.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_ValueTypes
 TkwCtxValueTypes.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_SetValueTypes
 TkwCtxSetValueTypes.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_IncludeValueTypes
 TkwCtxIncludeValueTypes.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_WordInfo
 TkwCtxWordInfo.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_ResolveIncludedFilePath
 TkwCtxResolveIncludedFilePath.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_MainDictionary
 TkwCtxMainDictionary.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_StandardDictionaries
 TkwCtxStandardDictionaries.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_Dictionaries
 TkwCtxDictionaries.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_InitedDictionaries
 TkwCtxInitedDictionaries.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Ctx_DisabledForHelp
 TkwCtxDisabledForHelp.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwStackValue
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
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
// ����������� ���� TtfwValueType
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwValueType));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwWordModifier
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWordModifier));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwCompiler
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwCompiler));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwKeywordFinder
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeywordFinder));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwNewWordDefinitor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwNewWordDefinitor));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwWord
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwKeyWord
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeyWord));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwAccessType
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwAccessType));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwLinkType
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwLinkType));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwValueTypes
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwValueTypes));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwWordInfo
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWordInfo));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� String
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiString));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwMainDictionary
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwMainDictionary));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� ItfwValueList
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwValueList));
{$IfEnd} //not NoScripts

end.