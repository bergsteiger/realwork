unit tfwValueTypesWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "tfwValueTypesWordsPack" MUID: (55C3714E020D)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3Interfaces
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwValueTypes
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopValueTypesCompare = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ValueTypes:Compare }
  private
   function Compare(const aCtx: TtfwContext;
    aValueTypes: TtfwValueTypes;
    anOther: TtfwValueTypes): Integer;
    {* Реализация слова скрипта pop:ValueTypes:Compare }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopValueTypesCompare

 TkwPopValueTypesAcceptsValue = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ValueTypes:AcceptsValue }
  private
   function AcceptsValue(const aCtx: TtfwContext;
    aValueTypes: TtfwValueTypes;
    const aValue: TtfwStackValue): Boolean;
    {* Реализация слова скрипта pop:ValueTypes:AcceptsValue }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopValueTypesAcceptsValue

 TkwPopValueTypesAdd = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ValueTypes:Add }
  private
   function Add(const aCtx: TtfwContext;
    aValueTypes: TtfwValueTypes;
    anOther: TtfwValueTypes): TtfwValueTypes;
    {* Реализация слова скрипта pop:ValueTypes:Add }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopValueTypesAdd

 TkwPopValueTypesHas = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ValueTypes:Has }
  private
   function Has(const aCtx: TtfwContext;
    aValueTypes: TtfwValueTypes;
    aType: TtfwValueType): Boolean;
    {* Реализация слова скрипта pop:ValueTypes:Has }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopValueTypesHas

 TkwPopValueTypesEQ = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ValueTypes:EQ }
  private
   function EQ(const aCtx: TtfwContext;
    aValueTypes: TtfwValueTypes;
    anOther: TtfwValueTypes): Boolean;
    {* Реализация слова скрипта pop:ValueTypes:EQ }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopValueTypesEQ

 TkwPopValueTypesDefaultValue = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ValueTypes:DefaultValue }
  private
   function DefaultValue(const aCtx: TtfwContext;
    aValueTypes: TtfwValueTypes): TtfwStackValue;
    {* Реализация слова скрипта pop:ValueTypes:DefaultValue }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopValueTypesDefaultValue

 TkwPopValueTypesMakeCustomName = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ValueTypes:MakeCustomName }
  private
   function MakeCustomName(const aCtx: TtfwContext;
    aValueTypes: TtfwValueTypes;
    const aName: Il3CString): TtfwValueTypes;
    {* Реализация слова скрипта pop:ValueTypes:MakeCustomName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopValueTypesMakeCustomName

 TkwPopValueTypesAccepts = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ValueTypes:Accepts }
  private
   function Accepts(const aCtx: TtfwContext;
    aValueTypes: TtfwValueTypes;
    anOther: TtfwValueTypes): TtfwValueTypesAccepts;
    {* Реализация слова скрипта pop:ValueTypes:Accepts }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopValueTypesAccepts

 TkwPopValueTypesName = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:ValueTypes:Name }
  private
   function Name(const aCtx: TtfwContext;
    aValueTypes: TtfwValueTypes): Il3CString;
    {* Реализация слова скрипта pop:ValueTypes:Name }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopValueTypesName

function TkwPopValueTypesCompare.Compare(const aCtx: TtfwContext;
 aValueTypes: TtfwValueTypes;
 anOther: TtfwValueTypes): Integer;
 {* Реализация слова скрипта pop:ValueTypes:Compare }
begin
 Result := aValueTypes.Compare(anOther);
end;//TkwPopValueTypesCompare.Compare

class function TkwPopValueTypesCompare.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ValueTypes:Compare';
end;//TkwPopValueTypesCompare.GetWordNameForRegister

function TkwPopValueTypesCompare.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopValueTypesCompare.GetResultTypeInfo

function TkwPopValueTypesCompare.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopValueTypesCompare.GetAllParamsCount

function TkwPopValueTypesCompare.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwValueTypes), TypeInfo(TtfwValueTypes)]);
end;//TkwPopValueTypesCompare.ParamsTypes

procedure TkwPopValueTypesCompare.DoDoIt(const aCtx: TtfwContext);
var l_aValueTypes: TtfwValueTypes;
var l_anOther: TtfwValueTypes;
begin
 try
  l_aValueTypes := TtfwValueTypes(aCtx.rEngine.PopObjAs(TtfwValueTypes));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValueTypes: TtfwValueTypes : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := TtfwValueTypes(aCtx.rEngine.PopObjAs(TtfwValueTypes));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anOther: TtfwValueTypes : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Compare(aCtx, l_aValueTypes, l_anOther));
end;//TkwPopValueTypesCompare.DoDoIt

function TkwPopValueTypesAcceptsValue.AcceptsValue(const aCtx: TtfwContext;
 aValueTypes: TtfwValueTypes;
 const aValue: TtfwStackValue): Boolean;
 {* Реализация слова скрипта pop:ValueTypes:AcceptsValue }
begin
 Result := aValueTypes.AcceptsValue(aValue);
end;//TkwPopValueTypesAcceptsValue.AcceptsValue

class function TkwPopValueTypesAcceptsValue.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ValueTypes:AcceptsValue';
end;//TkwPopValueTypesAcceptsValue.GetWordNameForRegister

function TkwPopValueTypesAcceptsValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopValueTypesAcceptsValue.GetResultTypeInfo

function TkwPopValueTypesAcceptsValue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopValueTypesAcceptsValue.GetAllParamsCount

function TkwPopValueTypesAcceptsValue.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwValueTypes), @tfw_tiStruct]);
end;//TkwPopValueTypesAcceptsValue.ParamsTypes

procedure TkwPopValueTypesAcceptsValue.DoDoIt(const aCtx: TtfwContext);
var l_aValueTypes: TtfwValueTypes;
var l_aValue: TtfwStackValue;
begin
 try
  l_aValueTypes := TtfwValueTypes(aCtx.rEngine.PopObjAs(TtfwValueTypes));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValueTypes: TtfwValueTypes : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(AcceptsValue(aCtx, l_aValueTypes, l_aValue));
end;//TkwPopValueTypesAcceptsValue.DoDoIt

function TkwPopValueTypesAdd.Add(const aCtx: TtfwContext;
 aValueTypes: TtfwValueTypes;
 anOther: TtfwValueTypes): TtfwValueTypes;
 {* Реализация слова скрипта pop:ValueTypes:Add }
begin
 Result := aValueTypes.Add(anOther);
end;//TkwPopValueTypesAdd.Add

class function TkwPopValueTypesAdd.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ValueTypes:Add';
end;//TkwPopValueTypesAdd.GetWordNameForRegister

function TkwPopValueTypesAdd.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwValueTypes);
end;//TkwPopValueTypesAdd.GetResultTypeInfo

function TkwPopValueTypesAdd.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopValueTypesAdd.GetAllParamsCount

function TkwPopValueTypesAdd.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwValueTypes), TypeInfo(TtfwValueTypes)]);
end;//TkwPopValueTypesAdd.ParamsTypes

procedure TkwPopValueTypesAdd.DoDoIt(const aCtx: TtfwContext);
var l_aValueTypes: TtfwValueTypes;
var l_anOther: TtfwValueTypes;
begin
 try
  l_aValueTypes := TtfwValueTypes(aCtx.rEngine.PopObjAs(TtfwValueTypes));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValueTypes: TtfwValueTypes : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := TtfwValueTypes(aCtx.rEngine.PopObjAs(TtfwValueTypes));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anOther: TtfwValueTypes : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Add(aCtx, l_aValueTypes, l_anOther));
end;//TkwPopValueTypesAdd.DoDoIt

function TkwPopValueTypesHas.Has(const aCtx: TtfwContext;
 aValueTypes: TtfwValueTypes;
 aType: TtfwValueType): Boolean;
 {* Реализация слова скрипта pop:ValueTypes:Has }
begin
 Result := aValueTypes.Has(aType);
end;//TkwPopValueTypesHas.Has

class function TkwPopValueTypesHas.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ValueTypes:Has';
end;//TkwPopValueTypesHas.GetWordNameForRegister

function TkwPopValueTypesHas.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopValueTypesHas.GetResultTypeInfo

function TkwPopValueTypesHas.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopValueTypesHas.GetAllParamsCount

function TkwPopValueTypesHas.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwValueTypes), TypeInfo(TtfwValueType)]);
end;//TkwPopValueTypesHas.ParamsTypes

procedure TkwPopValueTypesHas.DoDoIt(const aCtx: TtfwContext);
var l_aValueTypes: TtfwValueTypes;
var l_aType: TtfwValueType;
begin
 try
  l_aValueTypes := TtfwValueTypes(aCtx.rEngine.PopObjAs(TtfwValueTypes));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValueTypes: TtfwValueTypes : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aType := TtfwValueType(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aType: TtfwValueType : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Has(aCtx, l_aValueTypes, l_aType));
end;//TkwPopValueTypesHas.DoDoIt

function TkwPopValueTypesEQ.EQ(const aCtx: TtfwContext;
 aValueTypes: TtfwValueTypes;
 anOther: TtfwValueTypes): Boolean;
 {* Реализация слова скрипта pop:ValueTypes:EQ }
begin
 Result := aValueTypes.EQ(anOther);
end;//TkwPopValueTypesEQ.EQ

class function TkwPopValueTypesEQ.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ValueTypes:EQ';
end;//TkwPopValueTypesEQ.GetWordNameForRegister

function TkwPopValueTypesEQ.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopValueTypesEQ.GetResultTypeInfo

function TkwPopValueTypesEQ.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopValueTypesEQ.GetAllParamsCount

function TkwPopValueTypesEQ.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwValueTypes), TypeInfo(TtfwValueTypes)]);
end;//TkwPopValueTypesEQ.ParamsTypes

procedure TkwPopValueTypesEQ.DoDoIt(const aCtx: TtfwContext);
var l_aValueTypes: TtfwValueTypes;
var l_anOther: TtfwValueTypes;
begin
 try
  l_aValueTypes := TtfwValueTypes(aCtx.rEngine.PopObjAs(TtfwValueTypes));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValueTypes: TtfwValueTypes : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := TtfwValueTypes(aCtx.rEngine.PopObjAs(TtfwValueTypes));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anOther: TtfwValueTypes : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(EQ(aCtx, l_aValueTypes, l_anOther));
end;//TkwPopValueTypesEQ.DoDoIt

function TkwPopValueTypesDefaultValue.DefaultValue(const aCtx: TtfwContext;
 aValueTypes: TtfwValueTypes): TtfwStackValue;
 {* Реализация слова скрипта pop:ValueTypes:DefaultValue }
begin
 Result := aValueTypes.DefaultValue;
end;//TkwPopValueTypesDefaultValue.DefaultValue

class function TkwPopValueTypesDefaultValue.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ValueTypes:DefaultValue';
end;//TkwPopValueTypesDefaultValue.GetWordNameForRegister

function TkwPopValueTypesDefaultValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiStruct;
end;//TkwPopValueTypesDefaultValue.GetResultTypeInfo

function TkwPopValueTypesDefaultValue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopValueTypesDefaultValue.GetAllParamsCount

function TkwPopValueTypesDefaultValue.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwValueTypes)]);
end;//TkwPopValueTypesDefaultValue.ParamsTypes

procedure TkwPopValueTypesDefaultValue.DoDoIt(const aCtx: TtfwContext);
var l_aValueTypes: TtfwValueTypes;
begin
 try
  l_aValueTypes := TtfwValueTypes(aCtx.rEngine.PopObjAs(TtfwValueTypes));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValueTypes: TtfwValueTypes : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.Push(DefaultValue(aCtx, l_aValueTypes));
end;//TkwPopValueTypesDefaultValue.DoDoIt

function TkwPopValueTypesMakeCustomName.MakeCustomName(const aCtx: TtfwContext;
 aValueTypes: TtfwValueTypes;
 const aName: Il3CString): TtfwValueTypes;
 {* Реализация слова скрипта pop:ValueTypes:MakeCustomName }
//#UC START# *55CDF4C902F2_55CDF4C902F2_55BF2B000047_Word_var*
//#UC END# *55CDF4C902F2_55CDF4C902F2_55BF2B000047_Word_var*
begin
//#UC START# *55CDF4C902F2_55CDF4C902F2_55BF2B000047_Word_impl*
 Result := aValueTypes.MakeCustomName(aName);
//#UC END# *55CDF4C902F2_55CDF4C902F2_55BF2B000047_Word_impl*
end;//TkwPopValueTypesMakeCustomName.MakeCustomName

class function TkwPopValueTypesMakeCustomName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ValueTypes:MakeCustomName';
end;//TkwPopValueTypesMakeCustomName.GetWordNameForRegister

function TkwPopValueTypesMakeCustomName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwValueTypes);
end;//TkwPopValueTypesMakeCustomName.GetResultTypeInfo

function TkwPopValueTypesMakeCustomName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopValueTypesMakeCustomName.GetAllParamsCount

function TkwPopValueTypesMakeCustomName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwValueTypes), @tfw_tiString]);
end;//TkwPopValueTypesMakeCustomName.ParamsTypes

procedure TkwPopValueTypesMakeCustomName.DoDoIt(const aCtx: TtfwContext);
var l_aValueTypes: TtfwValueTypes;
var l_aName: Il3CString;
begin
 try
  l_aValueTypes := TtfwValueTypes(aCtx.rEngine.PopObjAs(TtfwValueTypes));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValueTypes: TtfwValueTypes : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(MakeCustomName(aCtx, l_aValueTypes, l_aName));
end;//TkwPopValueTypesMakeCustomName.DoDoIt

function TkwPopValueTypesAccepts.Accepts(const aCtx: TtfwContext;
 aValueTypes: TtfwValueTypes;
 anOther: TtfwValueTypes): TtfwValueTypesAccepts;
 {* Реализация слова скрипта pop:ValueTypes:Accepts }
//#UC START# *560D01EA014E_560D01EA014E_55BF2B000047_Word_var*
//#UC END# *560D01EA014E_560D01EA014E_55BF2B000047_Word_var*
begin
//#UC START# *560D01EA014E_560D01EA014E_55BF2B000047_Word_impl*
 Result := aValueTypes.Accepts(anOther);
//#UC END# *560D01EA014E_560D01EA014E_55BF2B000047_Word_impl*
end;//TkwPopValueTypesAccepts.Accepts

class function TkwPopValueTypesAccepts.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ValueTypes:Accepts';
end;//TkwPopValueTypesAccepts.GetWordNameForRegister

function TkwPopValueTypesAccepts.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwValueTypesAccepts);
end;//TkwPopValueTypesAccepts.GetResultTypeInfo

function TkwPopValueTypesAccepts.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopValueTypesAccepts.GetAllParamsCount

function TkwPopValueTypesAccepts.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwValueTypes), TypeInfo(TtfwValueTypes)]);
end;//TkwPopValueTypesAccepts.ParamsTypes

procedure TkwPopValueTypesAccepts.DoDoIt(const aCtx: TtfwContext);
var l_aValueTypes: TtfwValueTypes;
var l_anOther: TtfwValueTypes;
begin
 try
  l_aValueTypes := TtfwValueTypes(aCtx.rEngine.PopObjAs(TtfwValueTypes));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValueTypes: TtfwValueTypes : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := TtfwValueTypes(aCtx.rEngine.PopObjAs(TtfwValueTypes));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anOther: TtfwValueTypes : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Ord(Accepts(aCtx, l_aValueTypes, l_anOther)));
end;//TkwPopValueTypesAccepts.DoDoIt

function TkwPopValueTypesName.Name(const aCtx: TtfwContext;
 aValueTypes: TtfwValueTypes): Il3CString;
 {* Реализация слова скрипта pop:ValueTypes:Name }
begin
 Result := aValueTypes.Name;
end;//TkwPopValueTypesName.Name

class function TkwPopValueTypesName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ValueTypes:Name';
end;//TkwPopValueTypesName.GetWordNameForRegister

function TkwPopValueTypesName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopValueTypesName.GetResultTypeInfo

function TkwPopValueTypesName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopValueTypesName.GetAllParamsCount

function TkwPopValueTypesName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwValueTypes)]);
end;//TkwPopValueTypesName.ParamsTypes

procedure TkwPopValueTypesName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Name', aCtx);
end;//TkwPopValueTypesName.SetValuePrim

procedure TkwPopValueTypesName.DoDoIt(const aCtx: TtfwContext);
var l_aValueTypes: TtfwValueTypes;
begin
 try
  l_aValueTypes := TtfwValueTypes(aCtx.rEngine.PopObjAs(TtfwValueTypes));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValueTypes: TtfwValueTypes : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Name(aCtx, l_aValueTypes));
end;//TkwPopValueTypesName.DoDoIt

initialization
 TkwPopValueTypesCompare.RegisterInEngine;
 {* Регистрация pop_ValueTypes_Compare }
 TkwPopValueTypesAcceptsValue.RegisterInEngine;
 {* Регистрация pop_ValueTypes_AcceptsValue }
 TkwPopValueTypesAdd.RegisterInEngine;
 {* Регистрация pop_ValueTypes_Add }
 TkwPopValueTypesHas.RegisterInEngine;
 {* Регистрация pop_ValueTypes_Has }
 TkwPopValueTypesEQ.RegisterInEngine;
 {* Регистрация pop_ValueTypes_EQ }
 TkwPopValueTypesDefaultValue.RegisterInEngine;
 {* Регистрация pop_ValueTypes_DefaultValue }
 TkwPopValueTypesMakeCustomName.RegisterInEngine;
 {* Регистрация pop_ValueTypes_MakeCustomName }
 TkwPopValueTypesAccepts.RegisterInEngine;
 {* Регистрация pop_ValueTypes_Accepts }
 TkwPopValueTypesName.RegisterInEngine;
 {* Регистрация pop_ValueTypes_Name }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwValueTypes));
 {* Регистрация типа TtfwValueTypes }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwValueTypesAccepts));
 {* Регистрация типа TtfwValueTypesAccepts }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwValueType));
 {* Регистрация типа TtfwValueType }
{$IfEnd} // NOT Defined(NoScripts)

end.
