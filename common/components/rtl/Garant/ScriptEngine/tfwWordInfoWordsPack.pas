unit tfwWordInfoWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Axiomatics"
// ������: "tfwWordInfoWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$Axiomatics::Words RTTI::tfwWordInfoWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3Interfaces,
  tfwScriptingInterfaces,
  tfwValueTypes,
  tfwClassLike,
  tfwPropertyLike,
  tfwScriptingTypes,
  tfwTypeInfo
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwPopWordInfoIncludeModifier = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:IncludeModifier
*��� ����������:* TtfwWordInfo
*������:*
[code]
OBJECT VAR l_TtfwWordInfo
 aModifier aWordInfo pop:WordInfo:IncludeModifier >>> l_TtfwWordInfo
[code]  }
 private
 // private methods
   function IncludeModifier(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    aModifier: TtfwWordModifier): TtfwWordInfo;
     {* ���������� ����� ������� pop:WordInfo:IncludeModifier }
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
 end;//TkwPopWordInfoIncludeModifier

// start class TkwPopWordInfoIncludeModifier

function TkwPopWordInfoIncludeModifier.IncludeModifier(const aCtx: TtfwContext;
  aWordInfo: TtfwWordInfo;
  aModifier: TtfwWordModifier): TtfwWordInfo;
 {-}
begin
 Result := aWordInfo.IncludeModifier(aModifier);
end;//TkwPopWordInfoIncludeModifier.IncludeModifier

procedure TkwPopWordInfoIncludeModifier.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWordInfo : TtfwWordInfo;
 l_aModifier : TtfwWordModifier;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aModifier := TtfwWordModifier(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aModifier: TtfwWordModifier : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((IncludeModifier(aCtx, l_aWordInfo, l_aModifier)));
end;//TkwPopWordInfoIncludeModifier.DoDoIt

class function TkwPopWordInfoIncludeModifier.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:WordInfo:IncludeModifier';
end;//TkwPopWordInfoIncludeModifier.GetWordNameForRegister

function TkwPopWordInfoIncludeModifier.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwWordInfo);
end;//TkwPopWordInfoIncludeModifier.GetResultTypeInfo

function TkwPopWordInfoIncludeModifier.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopWordInfoIncludeModifier.GetAllParamsCount

function TkwPopWordInfoIncludeModifier.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), TypeInfo(TtfwWordModifier)]);
end;//TkwPopWordInfoIncludeModifier.ParamsTypes

type
 TkwPopWordInfoEmpty = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:Empty
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aWordInfo pop:WordInfo:Empty >>> l_Boolean
[code]  }
 private
 // private methods
   function Empty(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo): Boolean;
     {* ���������� ����� ������� pop:WordInfo:Empty }
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
 end;//TkwPopWordInfoEmpty

// start class TkwPopWordInfoEmpty

function TkwPopWordInfoEmpty.Empty(const aCtx: TtfwContext;
  aWordInfo: TtfwWordInfo): Boolean;
 {-}
begin
 Result := aWordInfo.Empty;
end;//TkwPopWordInfoEmpty.Empty

procedure TkwPopWordInfoEmpty.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWordInfo : TtfwWordInfo;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((Empty(aCtx, l_aWordInfo)));
end;//TkwPopWordInfoEmpty.DoDoIt

class function TkwPopWordInfoEmpty.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:WordInfo:Empty';
end;//TkwPopWordInfoEmpty.GetWordNameForRegister

function TkwPopWordInfoEmpty.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordInfoEmpty.GetResultTypeInfo

function TkwPopWordInfoEmpty.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordInfoEmpty.GetAllParamsCount

function TkwPopWordInfoEmpty.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo)]);
end;//TkwPopWordInfoEmpty.ParamsTypes

type
 TkwPopWordInfoHasWordModifier = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:HasWordModifier
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aModifier aWordInfo pop:WordInfo:HasWordModifier >>> l_Boolean
[code]  }
 private
 // private methods
   function HasWordModifier(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    aModifier: TtfwWordModifier): Boolean;
     {* ���������� ����� ������� pop:WordInfo:HasWordModifier }
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
 end;//TkwPopWordInfoHasWordModifier

// start class TkwPopWordInfoHasWordModifier

function TkwPopWordInfoHasWordModifier.HasWordModifier(const aCtx: TtfwContext;
  aWordInfo: TtfwWordInfo;
  aModifier: TtfwWordModifier): Boolean;
//#UC START# *6F1830859A21_4280F4A50B03_var*
//#UC END# *6F1830859A21_4280F4A50B03_var*
begin
//#UC START# *6F1830859A21_4280F4A50B03_impl*
 Result := aWordInfo.Has(aModifier);
//#UC END# *6F1830859A21_4280F4A50B03_impl*
end;//TkwPopWordInfoHasWordModifier.HasWordModifier

procedure TkwPopWordInfoHasWordModifier.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWordInfo : TtfwWordInfo;
 l_aModifier : TtfwWordModifier;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aModifier := TtfwWordModifier(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aModifier: TtfwWordModifier : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((HasWordModifier(aCtx, l_aWordInfo, l_aModifier)));
end;//TkwPopWordInfoHasWordModifier.DoDoIt

class function TkwPopWordInfoHasWordModifier.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:WordInfo:HasWordModifier';
end;//TkwPopWordInfoHasWordModifier.GetWordNameForRegister

function TkwPopWordInfoHasWordModifier.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordInfoHasWordModifier.GetResultTypeInfo

function TkwPopWordInfoHasWordModifier.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopWordInfoHasWordModifier.GetAllParamsCount

function TkwPopWordInfoHasWordModifier.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), TypeInfo(TtfwWordModifier)]);
end;//TkwPopWordInfoHasWordModifier.ParamsTypes

type
 TkwPopWordInfoIncludeTypeModifier = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:IncludeTypeModifier
*��� ����������:* TtfwWordInfo
*������:*
[code]
OBJECT VAR l_TtfwWordInfo
 aType aWordInfo pop:WordInfo:IncludeTypeModifier >>> l_TtfwWordInfo
[code]  }
 private
 // private methods
   function IncludeTypeModifier(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    aType: TtfwValueType): TtfwWordInfo;
     {* ���������� ����� ������� pop:WordInfo:IncludeTypeModifier }
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
 end;//TkwPopWordInfoIncludeTypeModifier

// start class TkwPopWordInfoIncludeTypeModifier

function TkwPopWordInfoIncludeTypeModifier.IncludeTypeModifier(const aCtx: TtfwContext;
  aWordInfo: TtfwWordInfo;
  aType: TtfwValueType): TtfwWordInfo;
 {-}
begin
 Result := aWordInfo.IncludeTypeModifier(aType);
end;//TkwPopWordInfoIncludeTypeModifier.IncludeTypeModifier

procedure TkwPopWordInfoIncludeTypeModifier.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWordInfo : TtfwWordInfo;
 l_aType : TtfwValueType;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
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
 aCtx.rEngine.PushObj((IncludeTypeModifier(aCtx, l_aWordInfo, l_aType)));
end;//TkwPopWordInfoIncludeTypeModifier.DoDoIt

class function TkwPopWordInfoIncludeTypeModifier.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:WordInfo:IncludeTypeModifier';
end;//TkwPopWordInfoIncludeTypeModifier.GetWordNameForRegister

function TkwPopWordInfoIncludeTypeModifier.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwWordInfo);
end;//TkwPopWordInfoIncludeTypeModifier.GetResultTypeInfo

function TkwPopWordInfoIncludeTypeModifier.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopWordInfoIncludeTypeModifier.GetAllParamsCount

function TkwPopWordInfoIncludeTypeModifier.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), TypeInfo(TtfwValueType)]);
end;//TkwPopWordInfoIncludeTypeModifier.ParamsTypes

type
 TkwPopWordInfoHasValueType = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:HasValueType
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aType aWordInfo pop:WordInfo:HasValueType >>> l_Boolean
[code]  }
 private
 // private methods
   function HasValueType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    aType: TtfwValueType): Boolean;
     {* ���������� ����� ������� pop:WordInfo:HasValueType }
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
 end;//TkwPopWordInfoHasValueType

// start class TkwPopWordInfoHasValueType

function TkwPopWordInfoHasValueType.HasValueType(const aCtx: TtfwContext;
  aWordInfo: TtfwWordInfo;
  aType: TtfwValueType): Boolean;
//#UC START# *AEC40CE6A30A_E77A7D4C22A1_var*
//#UC END# *AEC40CE6A30A_E77A7D4C22A1_var*
begin
//#UC START# *AEC40CE6A30A_E77A7D4C22A1_impl*
 Result := aWordInfo.Has(aType);
//#UC END# *AEC40CE6A30A_E77A7D4C22A1_impl*
end;//TkwPopWordInfoHasValueType.HasValueType

procedure TkwPopWordInfoHasValueType.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWordInfo : TtfwWordInfo;
 l_aType : TtfwValueType;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
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
 aCtx.rEngine.PushBool((HasValueType(aCtx, l_aWordInfo, l_aType)));
end;//TkwPopWordInfoHasValueType.DoDoIt

class function TkwPopWordInfoHasValueType.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:WordInfo:HasValueType';
end;//TkwPopWordInfoHasValueType.GetWordNameForRegister

function TkwPopWordInfoHasValueType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordInfoHasValueType.GetResultTypeInfo

function TkwPopWordInfoHasValueType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopWordInfoHasValueType.GetAllParamsCount

function TkwPopWordInfoHasValueType.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), TypeInfo(TtfwValueType)]);
end;//TkwPopWordInfoHasValueType.ParamsTypes

type
 TkwPopWordInfoAcceptsValue = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:AcceptsValue
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aValue aWordInfo pop:WordInfo:AcceptsValue >>> l_Boolean
[code]  }
 private
 // private methods
   function AcceptsValue(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    const aValue: TtfwStackValue): Boolean;
     {* ���������� ����� ������� pop:WordInfo:AcceptsValue }
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
 end;//TkwPopWordInfoAcceptsValue

// start class TkwPopWordInfoAcceptsValue

function TkwPopWordInfoAcceptsValue.AcceptsValue(const aCtx: TtfwContext;
  aWordInfo: TtfwWordInfo;
  const aValue: TtfwStackValue): Boolean;
 {-}
begin
 Result := aWordInfo.AcceptsValue(aValue);
end;//TkwPopWordInfoAcceptsValue.AcceptsValue

procedure TkwPopWordInfoAcceptsValue.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWordInfo : TtfwWordInfo;
 l_aValue : TtfwStackValue;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
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
 aCtx.rEngine.PushBool((AcceptsValue(aCtx, l_aWordInfo, l_aValue)));
end;//TkwPopWordInfoAcceptsValue.DoDoIt

class function TkwPopWordInfoAcceptsValue.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:WordInfo:AcceptsValue';
end;//TkwPopWordInfoAcceptsValue.GetWordNameForRegister

function TkwPopWordInfoAcceptsValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordInfoAcceptsValue.GetResultTypeInfo

function TkwPopWordInfoAcceptsValue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopWordInfoAcceptsValue.GetAllParamsCount

function TkwPopWordInfoAcceptsValue.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), @tfw_tiStruct]);
end;//TkwPopWordInfoAcceptsValue.ParamsTypes

type
 TkwPopWordInfoHasAccessType = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:HasAccessType
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 anAccess aWordInfo pop:WordInfo:HasAccessType >>> l_Boolean
[code]  }
 private
 // private methods
   function HasAccessType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    anAccess: TtfwAccessType): Boolean;
     {* ���������� ����� ������� pop:WordInfo:HasAccessType }
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
 end;//TkwPopWordInfoHasAccessType

// start class TkwPopWordInfoHasAccessType

function TkwPopWordInfoHasAccessType.HasAccessType(const aCtx: TtfwContext;
  aWordInfo: TtfwWordInfo;
  anAccess: TtfwAccessType): Boolean;
//#UC START# *DE32097D5418_E7485F00A9C9_var*
//#UC END# *DE32097D5418_E7485F00A9C9_var*
begin
//#UC START# *DE32097D5418_E7485F00A9C9_impl*
 Result := aWordInfo.Has(anAccess);
//#UC END# *DE32097D5418_E7485F00A9C9_impl*
end;//TkwPopWordInfoHasAccessType.HasAccessType

procedure TkwPopWordInfoHasAccessType.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWordInfo : TtfwWordInfo;
 l_anAccess : TtfwAccessType;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anAccess := TtfwAccessType(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anAccess: TtfwAccessType : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((HasAccessType(aCtx, l_aWordInfo, l_anAccess)));
end;//TkwPopWordInfoHasAccessType.DoDoIt

class function TkwPopWordInfoHasAccessType.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:WordInfo:HasAccessType';
end;//TkwPopWordInfoHasAccessType.GetWordNameForRegister

function TkwPopWordInfoHasAccessType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordInfoHasAccessType.GetResultTypeInfo

function TkwPopWordInfoHasAccessType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopWordInfoHasAccessType.GetAllParamsCount

function TkwPopWordInfoHasAccessType.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), TypeInfo(TtfwAccessType)]);
end;//TkwPopWordInfoHasAccessType.ParamsTypes

type
 TkwPopWordInfoIncludeAccesType = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:IncludeAccesType
*��� ����������:* TtfwWordInfo
*������:*
[code]
OBJECT VAR l_TtfwWordInfo
 anAccess aWordInfo pop:WordInfo:IncludeAccesType >>> l_TtfwWordInfo
[code]  }
 private
 // private methods
   function IncludeAccesType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    anAccess: TtfwAccessType): TtfwWordInfo;
     {* ���������� ����� ������� pop:WordInfo:IncludeAccesType }
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
 end;//TkwPopWordInfoIncludeAccesType

// start class TkwPopWordInfoIncludeAccesType

function TkwPopWordInfoIncludeAccesType.IncludeAccesType(const aCtx: TtfwContext;
  aWordInfo: TtfwWordInfo;
  anAccess: TtfwAccessType): TtfwWordInfo;
 {-}
begin
 Result := aWordInfo.IncludeAccesType(anAccess);
end;//TkwPopWordInfoIncludeAccesType.IncludeAccesType

procedure TkwPopWordInfoIncludeAccesType.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWordInfo : TtfwWordInfo;
 l_anAccess : TtfwAccessType;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anAccess := TtfwAccessType(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anAccess: TtfwAccessType : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((IncludeAccesType(aCtx, l_aWordInfo, l_anAccess)));
end;//TkwPopWordInfoIncludeAccesType.DoDoIt

class function TkwPopWordInfoIncludeAccesType.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:WordInfo:IncludeAccesType';
end;//TkwPopWordInfoIncludeAccesType.GetWordNameForRegister

function TkwPopWordInfoIncludeAccesType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwWordInfo);
end;//TkwPopWordInfoIncludeAccesType.GetResultTypeInfo

function TkwPopWordInfoIncludeAccesType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopWordInfoIncludeAccesType.GetAllParamsCount

function TkwPopWordInfoIncludeAccesType.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), TypeInfo(TtfwAccessType)]);
end;//TkwPopWordInfoIncludeAccesType.ParamsTypes

type
 TkwPopWordInfoValueTypes = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:ValueTypes
*��� ����������:* TtfwValueTypes
*������:*
[code]
OBJECT VAR l_TtfwValueTypes
 aWordInfo pop:WordInfo:ValueTypes >>> l_TtfwValueTypes
[code]  }
 private
 // private methods
   function ValueTypes(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo): TtfwValueTypes;
     {* ���������� ����� ������� pop:WordInfo:ValueTypes }
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
 end;//TkwPopWordInfoValueTypes

// start class TkwPopWordInfoValueTypes

function TkwPopWordInfoValueTypes.ValueTypes(const aCtx: TtfwContext;
  aWordInfo: TtfwWordInfo): TtfwValueTypes;
 {-}
begin
 Result := aWordInfo.ValueTypes;
end;//TkwPopWordInfoValueTypes.ValueTypes

procedure TkwPopWordInfoValueTypes.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWordInfo : TtfwWordInfo;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ValueTypes(aCtx, l_aWordInfo)));
end;//TkwPopWordInfoValueTypes.DoDoIt

class function TkwPopWordInfoValueTypes.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:WordInfo:ValueTypes';
end;//TkwPopWordInfoValueTypes.GetWordNameForRegister

function TkwPopWordInfoValueTypes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwValueTypes);
end;//TkwPopWordInfoValueTypes.GetResultTypeInfo

function TkwPopWordInfoValueTypes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordInfoValueTypes.GetAllParamsCount

function TkwPopWordInfoValueTypes.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo)]);
end;//TkwPopWordInfoValueTypes.ParamsTypes

type
 TkwPopWordInfoIncludeLinkType = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:IncludeLinkType
*��� ����������:* TtfwWordInfo
*������:*
[code]
OBJECT VAR l_TtfwWordInfo
 aLinkType aWordInfo pop:WordInfo:IncludeLinkType >>> l_TtfwWordInfo
[code]  }
 private
 // private methods
   function IncludeLinkType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    aLinkType: TtfwLinkType): TtfwWordInfo;
     {* ���������� ����� ������� pop:WordInfo:IncludeLinkType }
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
 end;//TkwPopWordInfoIncludeLinkType

// start class TkwPopWordInfoIncludeLinkType

function TkwPopWordInfoIncludeLinkType.IncludeLinkType(const aCtx: TtfwContext;
  aWordInfo: TtfwWordInfo;
  aLinkType: TtfwLinkType): TtfwWordInfo;
 {-}
begin
 Result := aWordInfo.IncludeLinkType(aLinkType);
end;//TkwPopWordInfoIncludeLinkType.IncludeLinkType

procedure TkwPopWordInfoIncludeLinkType.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWordInfo : TtfwWordInfo;
 l_aLinkType : TtfwLinkType;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aLinkType := TtfwLinkType(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLinkType: TtfwLinkType : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((IncludeLinkType(aCtx, l_aWordInfo, l_aLinkType)));
end;//TkwPopWordInfoIncludeLinkType.DoDoIt

class function TkwPopWordInfoIncludeLinkType.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:WordInfo:IncludeLinkType';
end;//TkwPopWordInfoIncludeLinkType.GetWordNameForRegister

function TkwPopWordInfoIncludeLinkType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwWordInfo);
end;//TkwPopWordInfoIncludeLinkType.GetResultTypeInfo

function TkwPopWordInfoIncludeLinkType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopWordInfoIncludeLinkType.GetAllParamsCount

function TkwPopWordInfoIncludeLinkType.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), TypeInfo(TtfwLinkType)]);
end;//TkwPopWordInfoIncludeLinkType.ParamsTypes

type
 TkwPopWordInfoHasLinkType = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:HasLinkType
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aLinkType aWordInfo pop:WordInfo:HasLinkType >>> l_Boolean
[code]  }
 private
 // private methods
   function HasLinkType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    aLinkType: TtfwLinkType): Boolean;
     {* ���������� ����� ������� pop:WordInfo:HasLinkType }
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
 end;//TkwPopWordInfoHasLinkType

// start class TkwPopWordInfoHasLinkType

function TkwPopWordInfoHasLinkType.HasLinkType(const aCtx: TtfwContext;
  aWordInfo: TtfwWordInfo;
  aLinkType: TtfwLinkType): Boolean;
//#UC START# *C3E1AB4AA1BE_1B2BFB318FE4_var*
//#UC END# *C3E1AB4AA1BE_1B2BFB318FE4_var*
begin
//#UC START# *C3E1AB4AA1BE_1B2BFB318FE4_impl*
 Result := aWordInfo.Has(aLinkType);
//#UC END# *C3E1AB4AA1BE_1B2BFB318FE4_impl*
end;//TkwPopWordInfoHasLinkType.HasLinkType

procedure TkwPopWordInfoHasLinkType.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWordInfo : TtfwWordInfo;
 l_aLinkType : TtfwLinkType;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aLinkType := TtfwLinkType(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLinkType: TtfwLinkType : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((HasLinkType(aCtx, l_aWordInfo, l_aLinkType)));
end;//TkwPopWordInfoHasLinkType.DoDoIt

class function TkwPopWordInfoHasLinkType.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:WordInfo:HasLinkType';
end;//TkwPopWordInfoHasLinkType.GetWordNameForRegister

function TkwPopWordInfoHasLinkType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopWordInfoHasLinkType.GetResultTypeInfo

function TkwPopWordInfoHasLinkType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopWordInfoHasLinkType.GetAllParamsCount

function TkwPopWordInfoHasLinkType.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), TypeInfo(TtfwLinkType)]);
end;//TkwPopWordInfoHasLinkType.ParamsTypes

type
 TkwPopWordInfoCompare = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:Compare
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anOther aWordInfo pop:WordInfo:Compare >>> l_Integer
[code]  }
 private
 // private methods
   function Compare(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo;
    anOther: TtfwWordInfo): Integer;
     {* ���������� ����� ������� pop:WordInfo:Compare }
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
 end;//TkwPopWordInfoCompare

// start class TkwPopWordInfoCompare

function TkwPopWordInfoCompare.Compare(const aCtx: TtfwContext;
  aWordInfo: TtfwWordInfo;
  anOther: TtfwWordInfo): Integer;
 {-}
begin
 Result := aWordInfo.Compare(anOther);
end;//TkwPopWordInfoCompare.Compare

procedure TkwPopWordInfoCompare.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWordInfo : TtfwWordInfo;
 l_anOther : TtfwWordInfo;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo, true));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anOther: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Compare(aCtx, l_aWordInfo, l_anOther)));
end;//TkwPopWordInfoCompare.DoDoIt

class function TkwPopWordInfoCompare.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:WordInfo:Compare';
end;//TkwPopWordInfoCompare.GetWordNameForRegister

function TkwPopWordInfoCompare.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopWordInfoCompare.GetResultTypeInfo

function TkwPopWordInfoCompare.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopWordInfoCompare.GetAllParamsCount

function TkwPopWordInfoCompare.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo), TypeInfo(TtfwWordInfo)]);
end;//TkwPopWordInfoCompare.ParamsTypes

type
 TkwPopWordInfoToString = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:ToString
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aWordInfo pop:WordInfo:ToString >>> l_Il3CString
[code]  }
 private
 // private methods
   function ToString(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo): Il3CString;
     {* ���������� ����� ������� pop:WordInfo:ToString }
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
 end;//TkwPopWordInfoToString

// start class TkwPopWordInfoToString

function TkwPopWordInfoToString.ToString(const aCtx: TtfwContext;
  aWordInfo: TtfwWordInfo): Il3CString;
 {-}
begin
 Result := aWordInfo.ToString;
end;//TkwPopWordInfoToString.ToString

procedure TkwPopWordInfoToString.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWordInfo : TtfwWordInfo;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((ToString(aCtx, l_aWordInfo)));
end;//TkwPopWordInfoToString.DoDoIt

class function TkwPopWordInfoToString.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:WordInfo:ToString';
end;//TkwPopWordInfoToString.GetWordNameForRegister

function TkwPopWordInfoToString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwPopWordInfoToString.GetResultTypeInfo

function TkwPopWordInfoToString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordInfoToString.GetAllParamsCount

function TkwPopWordInfoToString.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo)]);
end;//TkwPopWordInfoToString.ParamsTypes

type
 TkwPopWordInfoTypeName = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� pop:WordInfo:TypeName
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aWordInfo pop:WordInfo:TypeName >>> l_Il3CString
[code]  }
 private
 // private methods
   function TypeName(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo): Il3CString;
     {* ���������� ����� ������� pop:WordInfo:TypeName }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoTypeName

// start class TkwPopWordInfoTypeName

function TkwPopWordInfoTypeName.TypeName(const aCtx: TtfwContext;
  aWordInfo: TtfwWordInfo): Il3CString;
 {-}
begin
 Result := aWordInfo.TypeName;
end;//TkwPopWordInfoTypeName.TypeName

procedure TkwPopWordInfoTypeName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWordInfo : TtfwWordInfo;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((TypeName(aCtx, l_aWordInfo)));
end;//TkwPopWordInfoTypeName.DoDoIt

class function TkwPopWordInfoTypeName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:WordInfo:TypeName';
end;//TkwPopWordInfoTypeName.GetWordNameForRegister

procedure TkwPopWordInfoTypeName.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� TypeName', aCtx);
end;//TkwPopWordInfoTypeName.SetValuePrim

function TkwPopWordInfoTypeName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwPopWordInfoTypeName.GetResultTypeInfo

function TkwPopWordInfoTypeName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordInfoTypeName.GetAllParamsCount

function TkwPopWordInfoTypeName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo)]);
end;//TkwPopWordInfoTypeName.ParamsTypes

type
 TkwPopWordInfoLinkType = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� pop:WordInfo:LinkType
*��� ����������:* TtfwLinkType
*������:*
[code]
TtfwLinkType VAR l_TtfwLinkType
 aWordInfo pop:WordInfo:LinkType >>> l_TtfwLinkType
[code]  }
 private
 // private methods
   function LinkType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo): TtfwLinkType;
     {* ���������� ����� ������� pop:WordInfo:LinkType }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoLinkType

// start class TkwPopWordInfoLinkType

function TkwPopWordInfoLinkType.LinkType(const aCtx: TtfwContext;
  aWordInfo: TtfwWordInfo): TtfwLinkType;
 {-}
begin
 Result := aWordInfo.LinkType;
end;//TkwPopWordInfoLinkType.LinkType

procedure TkwPopWordInfoLinkType.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWordInfo : TtfwWordInfo;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Ord(LinkType(aCtx, l_aWordInfo)));
end;//TkwPopWordInfoLinkType.DoDoIt

class function TkwPopWordInfoLinkType.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:WordInfo:LinkType';
end;//TkwPopWordInfoLinkType.GetWordNameForRegister

procedure TkwPopWordInfoLinkType.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� LinkType', aCtx);
end;//TkwPopWordInfoLinkType.SetValuePrim

function TkwPopWordInfoLinkType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwLinkType);
end;//TkwPopWordInfoLinkType.GetResultTypeInfo

function TkwPopWordInfoLinkType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordInfoLinkType.GetAllParamsCount

function TkwPopWordInfoLinkType.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo)]);
end;//TkwPopWordInfoLinkType.ParamsTypes

type
 TkwPopWordInfoAccessType = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� pop:WordInfo:AccessType
*��� ����������:* TtfwAccessType
*������:*
[code]
TtfwAccessType VAR l_TtfwAccessType
 aWordInfo pop:WordInfo:AccessType >>> l_TtfwAccessType
[code]  }
 private
 // private methods
   function AccessType(const aCtx: TtfwContext;
    aWordInfo: TtfwWordInfo): TtfwAccessType;
     {* ���������� ����� ������� pop:WordInfo:AccessType }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfoAccessType

// start class TkwPopWordInfoAccessType

function TkwPopWordInfoAccessType.AccessType(const aCtx: TtfwContext;
  aWordInfo: TtfwWordInfo): TtfwAccessType;
 {-}
begin
 Result := aWordInfo.AccessType;
end;//TkwPopWordInfoAccessType.AccessType

procedure TkwPopWordInfoAccessType.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWordInfo : TtfwWordInfo;
begin
 try
  l_aWordInfo := TtfwWordInfo(aCtx.rEngine.PopObjAs(TtfwWordInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWordInfo: TtfwWordInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Ord(AccessType(aCtx, l_aWordInfo)));
end;//TkwPopWordInfoAccessType.DoDoIt

class function TkwPopWordInfoAccessType.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:WordInfo:AccessType';
end;//TkwPopWordInfoAccessType.GetWordNameForRegister

procedure TkwPopWordInfoAccessType.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� AccessType', aCtx);
end;//TkwPopWordInfoAccessType.SetValuePrim

function TkwPopWordInfoAccessType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwAccessType);
end;//TkwPopWordInfoAccessType.GetResultTypeInfo

function TkwPopWordInfoAccessType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopWordInfoAccessType.GetAllParamsCount

function TkwPopWordInfoAccessType.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordInfo)]);
end;//TkwPopWordInfoAccessType.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_WordInfo_IncludeModifier
 TkwPopWordInfoIncludeModifier.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_WordInfo_Empty
 TkwPopWordInfoEmpty.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_WordInfo_HasWordModifier
 TkwPopWordInfoHasWordModifier.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_WordInfo_IncludeTypeModifier
 TkwPopWordInfoIncludeTypeModifier.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_WordInfo_HasValueType
 TkwPopWordInfoHasValueType.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_WordInfo_AcceptsValue
 TkwPopWordInfoAcceptsValue.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_WordInfo_HasAccessType
 TkwPopWordInfoHasAccessType.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_WordInfo_IncludeAccesType
 TkwPopWordInfoIncludeAccesType.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_WordInfo_ValueTypes
 TkwPopWordInfoValueTypes.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_WordInfo_IncludeLinkType
 TkwPopWordInfoIncludeLinkType.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_WordInfo_HasLinkType
 TkwPopWordInfoHasLinkType.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_WordInfo_Compare
 TkwPopWordInfoCompare.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_WordInfo_ToString
 TkwPopWordInfoToString.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_WordInfo_TypeName
 TkwPopWordInfoTypeName.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_WordInfo_LinkType
 TkwPopWordInfoLinkType.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_WordInfo_AccessType
 TkwPopWordInfoAccessType.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwWordInfo
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWordInfo));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwWordModifier
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWordModifier));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwValueType
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwValueType));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwStackValue
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwAccessType
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwAccessType));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwValueTypes
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwValueTypes));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwLinkType
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwLinkType));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Il3CString
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
{$IfEnd} //not NoScripts

end.