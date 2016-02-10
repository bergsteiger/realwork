unit ObjectFromstackWords;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ObjectFromstackWords.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwPopClassInherits
 , SysUtils
 , l3RTTI
 , tfwScriptingTypes
 , tfwTypeRegistrator
;

type
 //#UC START# *695731F3434Eci*
 //#UC END# *695731F3434Eci*
 //#UC START# *695731F3434Ecit*
 //#UC END# *695731F3434Ecit*
 TObjectFromstackWordsResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *695731F3434Epubl*
 //#UC END# *695731F3434Epubl*
 end;//TObjectFromstackWordsResNameGetter

 TkwPopObjectInherits = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:Inherits
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aClass aObject pop:Object:Inherits >>> l_Boolean
[code]  }
  private
   function Inherits(const aCtx: TtfwContext;
    aObject: TObject;
    const aClass: TtfwStackValue): Boolean;
    {* Реализация слова скрипта pop:Object:Inherits }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectInherits

 TkwPopObjectClassName = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:ClassName
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aObject pop:Object:ClassName >>> l_String
[code]  }
  private
   function ClassName(const aCtx: TtfwContext;
    aObject: TObject): AnsiString;
    {* Реализация слова скрипта pop:Object:ClassName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectClassName

 TkwPopObjectGetFloatProp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:GetFloatProp
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aName aObject pop:Object:GetFloatProp >>> l_Integer
[code]  }
  private
   function GetFloatProp(const aCtx: TtfwContext;
    aObject: TObject;
    const aName: AnsiString): Integer;
    {* Реализация слова скрипта pop:Object:GetFloatProp }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectGetFloatProp

 TkwPopObjectGetInterfaceProp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:GetInterfaceProp
*Тип результата:* IUnknown
*Пример:*
[code]
INTERFACE VAR l_IUnknown
 aName aObject pop:Object:GetInterfaceProp >>> l_IUnknown
[code]  }
  private
   function GetInterfaceProp(const aCtx: TtfwContext;
    aObject: TObject;
    const aName: AnsiString): IUnknown;
    {* Реализация слова скрипта pop:Object:GetInterfaceProp }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectGetInterfaceProp

 TkwPopObjectGetObjProp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:GetObjProp
*Тип результата:* TObject
*Пример:*
[code]
OBJECT VAR l_TObject
 aName aObject pop:Object:GetObjProp >>> l_TObject
[code]  }
  private
   function GetObjProp(const aCtx: TtfwContext;
    aObject: TObject;
    const aName: AnsiString): TObject;
    {* Реализация слова скрипта pop:Object:GetObjProp }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectGetObjProp

 TkwPopObjectGetOrdProp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:GetOrdProp
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aName aObject pop:Object:GetOrdProp >>> l_Integer
[code]  }
  private
   function GetOrdProp(const aCtx: TtfwContext;
    aObject: TObject;
    const aName: AnsiString): Integer;
    {* Реализация слова скрипта pop:Object:GetOrdProp }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectGetOrdProp

 TkwPopObjectGetStrProp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:GetStrProp
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aName aObject pop:Object:GetStrProp >>> l_String
[code]  }
  private
   function GetStrProp(const aCtx: TtfwContext;
    aObject: TObject;
    const aName: AnsiString): AnsiString;
    {* Реализация слова скрипта pop:Object:GetStrProp }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectGetStrProp

 TkwPopObjectHasProp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:HasProp
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aName aObject pop:Object:HasProp >>> l_Boolean
[code]  }
  private
   function HasProp(const aCtx: TtfwContext;
    aObject: TObject;
    const aName: AnsiString): Boolean;
    {* Реализация слова скрипта pop:Object:HasProp }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectHasProp

 TkwPopObjectRTTIInfo = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:RTTIInfo
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aObject pop:Object:RTTIInfo >>> l_String
[code]  }
  private
   function RTTIInfo(const aCtx: TtfwContext;
    aObject: TObject): AnsiString;
    {* Реализация слова скрипта pop:Object:RTTIInfo }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectRTTIInfo

 TkwPopObjectSetFloatProp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:SetFloatProp
*Пример:*
[code]
 aValue aName aObject pop:Object:SetFloatProp
[code]  }
  private
   procedure SetFloatProp(const aCtx: TtfwContext;
    aObject: TObject;
    const aName: AnsiString;
    aValue: Integer);
    {* Реализация слова скрипта pop:Object:SetFloatProp }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectSetFloatProp

 TkwPopObjectSetOrdProp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:SetOrdProp
*Пример:*
[code]
 aValue aName aObject pop:Object:SetOrdProp
[code]  }
  private
   procedure SetOrdProp(const aCtx: TtfwContext;
    aObject: TObject;
    const aName: AnsiString;
    aValue: Integer);
    {* Реализация слова скрипта pop:Object:SetOrdProp }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectSetOrdProp

 TkwPopObjectSetStrProp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:SetStrProp
*Пример:*
[code]
 aValue aName aObject pop:Object:SetStrProp
[code]  }
  private
   procedure SetStrProp(const aCtx: TtfwContext;
    aObject: TObject;
    const aName: AnsiString;
    const aValue: AnsiString);
    {* Реализация слова скрипта pop:Object:SetStrProp }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectSetStrProp

class function TObjectFromstackWordsResNameGetter.ResName: AnsiString;
begin
  Result := 'ObjectFromstackWords';
end;//TObjectFromstackWordsResNameGetter.ResName

 {$R ObjectFromstackWords.res}

function TkwPopObjectInherits.Inherits(const aCtx: TtfwContext;
 aObject: TObject;
 const aClass: TtfwStackValue): Boolean;
 {* Реализация слова скрипта pop:Object:Inherits }
//#UC START# *8E2028C997CB_C6231F1FCA26_var*

 function IsInherits(anObject: TClass; const aClass: AnsiString): Boolean;
 begin//IsInherits
  if (anObject = nil) then
   Result := false
  else
  if AnsiSameText(anObject.ClassName, aClass) then
   Result := true
  else
   Result := IsInherits(anObject.ClassParent, aClass);
 end;//IsInherits

//#UC END# *8E2028C997CB_C6231F1FCA26_var*
begin
//#UC START# *8E2028C997CB_C6231F1FCA26_impl*
 Case aClass.rType of
  tfw_vtClass:
   if (aObject = nil) then
    Result := false
   else
    Result := aObject.ClassType.InheritsFrom(aClass.AsClass);
  tfw_vtStr:
   if (aObject = nil) then
    Result := false
   else
    Result := IsInherits(aObject.ClassType, aClass.AsDelphiString);
  else
  begin
   Result := false;
   BadValueType(aClass.rType, aCtx);
  end;//else
 end;//Case aClass.rType
//#UC END# *8E2028C997CB_C6231F1FCA26_impl*
end;//TkwPopObjectInherits.Inherits

procedure TkwPopObjectInherits.DoDoIt(const aCtx: TtfwContext);
var l_aObject: TObject;
var l_aClass: TtfwStackValue;
begin
 try
  l_aObject := TObject(aCtx.rEngine.PopObjAs(TObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aObject: TObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aClass := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aClass: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Inherits(aCtx, l_aObject, l_aClass));
end;//TkwPopObjectInherits.DoDoIt

class function TkwPopObjectInherits.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Object:Inherits';
end;//TkwPopObjectInherits.GetWordNameForRegister

function TkwPopObjectInherits.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopObjectInherits.GetResultTypeInfo

function TkwPopObjectInherits.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopObjectInherits.GetAllParamsCount

function TkwPopObjectInherits.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TObject), @tfw_tiStruct]);
end;//TkwPopObjectInherits.ParamsTypes

function TkwPopObjectClassName.ClassName(const aCtx: TtfwContext;
 aObject: TObject): AnsiString;
 {* Реализация слова скрипта pop:Object:ClassName }
//#UC START# *DB3E01510FFF_7B6D4B0B5715_var*
//#UC END# *DB3E01510FFF_7B6D4B0B5715_var*
begin
//#UC START# *DB3E01510FFF_7B6D4B0B5715_impl*
 if (aObject = nil) then
  Result := 'Запросили имя класса у nil'
 else
  Result := aObject.ClassName;
//#UC END# *DB3E01510FFF_7B6D4B0B5715_impl*
end;//TkwPopObjectClassName.ClassName

procedure TkwPopObjectClassName.DoDoIt(const aCtx: TtfwContext);
var l_aObject: TObject;
begin
 try
  l_aObject := TObject(aCtx.rEngine.PopObjAs(TObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aObject: TObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(ClassName(aCtx, l_aObject));
end;//TkwPopObjectClassName.DoDoIt

class function TkwPopObjectClassName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Object:ClassName';
end;//TkwPopObjectClassName.GetWordNameForRegister

function TkwPopObjectClassName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopObjectClassName.GetResultTypeInfo

function TkwPopObjectClassName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopObjectClassName.GetAllParamsCount

function TkwPopObjectClassName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TObject)]);
end;//TkwPopObjectClassName.ParamsTypes

function TkwPopObjectGetFloatProp.GetFloatProp(const aCtx: TtfwContext;
 aObject: TObject;
 const aName: AnsiString): Integer;
 {* Реализация слова скрипта pop:Object:GetFloatProp }
//#UC START# *B092970B7218_EDA57987A3B6_var*
//#UC END# *B092970B7218_EDA57987A3B6_var*
begin
//#UC START# *B092970B7218_EDA57987A3B6_impl*
 Result := Trunc(TypInfo.GetFloatProp(aObject, aName));
//#UC END# *B092970B7218_EDA57987A3B6_impl*
end;//TkwPopObjectGetFloatProp.GetFloatProp

procedure TkwPopObjectGetFloatProp.DoDoIt(const aCtx: TtfwContext);
var l_aObject: TObject;
var l_aName: AnsiString;
begin
 try
  l_aObject := TObject(aCtx.rEngine.PopObjAs(TObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aObject: TObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(GetFloatProp(aCtx, l_aObject, l_aName));
end;//TkwPopObjectGetFloatProp.DoDoIt

class function TkwPopObjectGetFloatProp.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Object:GetFloatProp';
end;//TkwPopObjectGetFloatProp.GetWordNameForRegister

function TkwPopObjectGetFloatProp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopObjectGetFloatProp.GetResultTypeInfo

function TkwPopObjectGetFloatProp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopObjectGetFloatProp.GetAllParamsCount

function TkwPopObjectGetFloatProp.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TObject), @tfw_tiString]);
end;//TkwPopObjectGetFloatProp.ParamsTypes

function TkwPopObjectGetInterfaceProp.GetInterfaceProp(const aCtx: TtfwContext;
 aObject: TObject;
 const aName: AnsiString): IUnknown;
 {* Реализация слова скрипта pop:Object:GetInterfaceProp }
//#UC START# *A6C646A9D4FA_AB78BA187455_var*
//#UC END# *A6C646A9D4FA_AB78BA187455_var*
begin
//#UC START# *A6C646A9D4FA_AB78BA187455_impl*
 Result := TypInfo.GetInterfaceProp(aObject, aName);
//#UC END# *A6C646A9D4FA_AB78BA187455_impl*
end;//TkwPopObjectGetInterfaceProp.GetInterfaceProp

procedure TkwPopObjectGetInterfaceProp.DoDoIt(const aCtx: TtfwContext);
var l_aObject: TObject;
var l_aName: AnsiString;
begin
 try
  l_aObject := TObject(aCtx.rEngine.PopObjAs(TObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aObject: TObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(GetInterfaceProp(aCtx, l_aObject, l_aName),IUnknown);
end;//TkwPopObjectGetInterfaceProp.DoDoIt

class function TkwPopObjectGetInterfaceProp.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Object:GetInterfaceProp';
end;//TkwPopObjectGetInterfaceProp.GetWordNameForRegister

function TkwPopObjectGetInterfaceProp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(IUnknown);
end;//TkwPopObjectGetInterfaceProp.GetResultTypeInfo

function TkwPopObjectGetInterfaceProp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopObjectGetInterfaceProp.GetAllParamsCount

function TkwPopObjectGetInterfaceProp.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TObject), @tfw_tiString]);
end;//TkwPopObjectGetInterfaceProp.ParamsTypes

function TkwPopObjectGetObjProp.GetObjProp(const aCtx: TtfwContext;
 aObject: TObject;
 const aName: AnsiString): TObject;
 {* Реализация слова скрипта pop:Object:GetObjProp }
//#UC START# *C3A777545BCF_BA0E0748BC5D_var*
//#UC END# *C3A777545BCF_BA0E0748BC5D_var*
begin
//#UC START# *C3A777545BCF_BA0E0748BC5D_impl*
 Result := TypInfo.GetObjectProp(aObject, aName);
//#UC END# *C3A777545BCF_BA0E0748BC5D_impl*
end;//TkwPopObjectGetObjProp.GetObjProp

procedure TkwPopObjectGetObjProp.DoDoIt(const aCtx: TtfwContext);
var l_aObject: TObject;
var l_aName: AnsiString;
begin
 try
  l_aObject := TObject(aCtx.rEngine.PopObjAs(TObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aObject: TObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetObjProp(aCtx, l_aObject, l_aName));
end;//TkwPopObjectGetObjProp.DoDoIt

class function TkwPopObjectGetObjProp.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Object:GetObjProp';
end;//TkwPopObjectGetObjProp.GetWordNameForRegister

function TkwPopObjectGetObjProp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TObject);
end;//TkwPopObjectGetObjProp.GetResultTypeInfo

function TkwPopObjectGetObjProp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopObjectGetObjProp.GetAllParamsCount

function TkwPopObjectGetObjProp.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TObject), @tfw_tiString]);
end;//TkwPopObjectGetObjProp.ParamsTypes

function TkwPopObjectGetOrdProp.GetOrdProp(const aCtx: TtfwContext;
 aObject: TObject;
 const aName: AnsiString): Integer;
 {* Реализация слова скрипта pop:Object:GetOrdProp }
//#UC START# *902589FCB14D_AB11F1E6DB9D_var*
//#UC END# *902589FCB14D_AB11F1E6DB9D_var*
begin
//#UC START# *902589FCB14D_AB11F1E6DB9D_impl*
 Result := TypInfo.GetOrdProp(aObject, aName);
//#UC END# *902589FCB14D_AB11F1E6DB9D_impl*
end;//TkwPopObjectGetOrdProp.GetOrdProp

procedure TkwPopObjectGetOrdProp.DoDoIt(const aCtx: TtfwContext);
var l_aObject: TObject;
var l_aName: AnsiString;
begin
 try
  l_aObject := TObject(aCtx.rEngine.PopObjAs(TObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aObject: TObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(GetOrdProp(aCtx, l_aObject, l_aName));
end;//TkwPopObjectGetOrdProp.DoDoIt

class function TkwPopObjectGetOrdProp.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Object:GetOrdProp';
end;//TkwPopObjectGetOrdProp.GetWordNameForRegister

function TkwPopObjectGetOrdProp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopObjectGetOrdProp.GetResultTypeInfo

function TkwPopObjectGetOrdProp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopObjectGetOrdProp.GetAllParamsCount

function TkwPopObjectGetOrdProp.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TObject), @tfw_tiString]);
end;//TkwPopObjectGetOrdProp.ParamsTypes

function TkwPopObjectGetStrProp.GetStrProp(const aCtx: TtfwContext;
 aObject: TObject;
 const aName: AnsiString): AnsiString;
 {* Реализация слова скрипта pop:Object:GetStrProp }
//#UC START# *FA828528EED2_B3D2E54183FE_var*
//#UC END# *FA828528EED2_B3D2E54183FE_var*
begin
//#UC START# *FA828528EED2_B3D2E54183FE_impl*
 Result := TypInfo.GetStrProp(aObject, aName);
//#UC END# *FA828528EED2_B3D2E54183FE_impl*
end;//TkwPopObjectGetStrProp.GetStrProp

procedure TkwPopObjectGetStrProp.DoDoIt(const aCtx: TtfwContext);
var l_aObject: TObject;
var l_aName: AnsiString;
begin
 try
  l_aObject := TObject(aCtx.rEngine.PopObjAs(TObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aObject: TObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(GetStrProp(aCtx, l_aObject, l_aName));
end;//TkwPopObjectGetStrProp.DoDoIt

class function TkwPopObjectGetStrProp.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Object:GetStrProp';
end;//TkwPopObjectGetStrProp.GetWordNameForRegister

function TkwPopObjectGetStrProp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopObjectGetStrProp.GetResultTypeInfo

function TkwPopObjectGetStrProp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopObjectGetStrProp.GetAllParamsCount

function TkwPopObjectGetStrProp.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TObject), @tfw_tiString]);
end;//TkwPopObjectGetStrProp.ParamsTypes

function TkwPopObjectHasProp.HasProp(const aCtx: TtfwContext;
 aObject: TObject;
 const aName: AnsiString): Boolean;
 {* Реализация слова скрипта pop:Object:HasProp }
//#UC START# *C4DA28B83595_6EBCA1F985F5_var*
//#UC END# *C4DA28B83595_6EBCA1F985F5_var*
begin
//#UC START# *C4DA28B83595_6EBCA1F985F5_impl*
 Result := TypInfo.IsPublishedProp(aObject, aName);
//#UC END# *C4DA28B83595_6EBCA1F985F5_impl*
end;//TkwPopObjectHasProp.HasProp

procedure TkwPopObjectHasProp.DoDoIt(const aCtx: TtfwContext);
var l_aObject: TObject;
var l_aName: AnsiString;
begin
 try
  l_aObject := TObject(aCtx.rEngine.PopObjAs(TObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aObject: TObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(HasProp(aCtx, l_aObject, l_aName));
end;//TkwPopObjectHasProp.DoDoIt

class function TkwPopObjectHasProp.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Object:HasProp';
end;//TkwPopObjectHasProp.GetWordNameForRegister

function TkwPopObjectHasProp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopObjectHasProp.GetResultTypeInfo

function TkwPopObjectHasProp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopObjectHasProp.GetAllParamsCount

function TkwPopObjectHasProp.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TObject), @tfw_tiString]);
end;//TkwPopObjectHasProp.ParamsTypes

function TkwPopObjectRTTIInfo.RTTIInfo(const aCtx: TtfwContext;
 aObject: TObject): AnsiString;
 {* Реализация слова скрипта pop:Object:RTTIInfo }
//#UC START# *C6405BCAA6A5_0725EE68AD3B_var*
//#UC END# *C6405BCAA6A5_0725EE68AD3B_var*
begin
//#UC START# *C6405BCAA6A5_0725EE68AD3B_impl*
 Result := l3FormatRTTIInfo(aObject);
//#UC END# *C6405BCAA6A5_0725EE68AD3B_impl*
end;//TkwPopObjectRTTIInfo.RTTIInfo

procedure TkwPopObjectRTTIInfo.DoDoIt(const aCtx: TtfwContext);
var l_aObject: TObject;
begin
 try
  l_aObject := TObject(aCtx.rEngine.PopObjAs(TObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aObject: TObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(RTTIInfo(aCtx, l_aObject));
end;//TkwPopObjectRTTIInfo.DoDoIt

class function TkwPopObjectRTTIInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Object:RTTIInfo';
end;//TkwPopObjectRTTIInfo.GetWordNameForRegister

function TkwPopObjectRTTIInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopObjectRTTIInfo.GetResultTypeInfo

function TkwPopObjectRTTIInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopObjectRTTIInfo.GetAllParamsCount

function TkwPopObjectRTTIInfo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TObject)]);
end;//TkwPopObjectRTTIInfo.ParamsTypes

procedure TkwPopObjectSetFloatProp.SetFloatProp(const aCtx: TtfwContext;
 aObject: TObject;
 const aName: AnsiString;
 aValue: Integer);
 {* Реализация слова скрипта pop:Object:SetFloatProp }
//#UC START# *4D07D0C5DD70_529CD18EA056_var*
//#UC END# *4D07D0C5DD70_529CD18EA056_var*
begin
//#UC START# *4D07D0C5DD70_529CD18EA056_impl*
 TypInfo.SetFloatProp(aObject, aName, aValue);
//#UC END# *4D07D0C5DD70_529CD18EA056_impl*
end;//TkwPopObjectSetFloatProp.SetFloatProp

procedure TkwPopObjectSetFloatProp.DoDoIt(const aCtx: TtfwContext);
var l_aObject: TObject;
var l_aName: AnsiString;
var l_aValue: Integer;
begin
 try
  l_aObject := TObject(aCtx.rEngine.PopObjAs(TObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aObject: TObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetFloatProp(aCtx, l_aObject, l_aName, l_aValue);
end;//TkwPopObjectSetFloatProp.DoDoIt

class function TkwPopObjectSetFloatProp.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Object:SetFloatProp';
end;//TkwPopObjectSetFloatProp.GetWordNameForRegister

function TkwPopObjectSetFloatProp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopObjectSetFloatProp.GetResultTypeInfo

function TkwPopObjectSetFloatProp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwPopObjectSetFloatProp.GetAllParamsCount

function TkwPopObjectSetFloatProp.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TObject), @tfw_tiString, TypeInfo(Integer)]);
end;//TkwPopObjectSetFloatProp.ParamsTypes

procedure TkwPopObjectSetOrdProp.SetOrdProp(const aCtx: TtfwContext;
 aObject: TObject;
 const aName: AnsiString;
 aValue: Integer);
 {* Реализация слова скрипта pop:Object:SetOrdProp }
//#UC START# *F069028D7CFF_A2938530A58A_var*
//#UC END# *F069028D7CFF_A2938530A58A_var*
begin
//#UC START# *F069028D7CFF_A2938530A58A_impl*
 TypInfo.SetOrdProp(aObject, aName, aValue);
//#UC END# *F069028D7CFF_A2938530A58A_impl*
end;//TkwPopObjectSetOrdProp.SetOrdProp

procedure TkwPopObjectSetOrdProp.DoDoIt(const aCtx: TtfwContext);
var l_aObject: TObject;
var l_aName: AnsiString;
var l_aValue: Integer;
begin
 try
  l_aObject := TObject(aCtx.rEngine.PopObjAs(TObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aObject: TObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetOrdProp(aCtx, l_aObject, l_aName, l_aValue);
end;//TkwPopObjectSetOrdProp.DoDoIt

class function TkwPopObjectSetOrdProp.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Object:SetOrdProp';
end;//TkwPopObjectSetOrdProp.GetWordNameForRegister

function TkwPopObjectSetOrdProp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopObjectSetOrdProp.GetResultTypeInfo

function TkwPopObjectSetOrdProp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwPopObjectSetOrdProp.GetAllParamsCount

function TkwPopObjectSetOrdProp.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TObject), @tfw_tiString, TypeInfo(Integer)]);
end;//TkwPopObjectSetOrdProp.ParamsTypes

procedure TkwPopObjectSetStrProp.SetStrProp(const aCtx: TtfwContext;
 aObject: TObject;
 const aName: AnsiString;
 const aValue: AnsiString);
 {* Реализация слова скрипта pop:Object:SetStrProp }
//#UC START# *D79D3014F0CB_798893499F18_var*
//#UC END# *D79D3014F0CB_798893499F18_var*
begin
//#UC START# *D79D3014F0CB_798893499F18_impl*
 TypInfo.SetStrProp(aObject, aName, aValue);
//#UC END# *D79D3014F0CB_798893499F18_impl*
end;//TkwPopObjectSetStrProp.SetStrProp

procedure TkwPopObjectSetStrProp.DoDoIt(const aCtx: TtfwContext);
var l_aObject: TObject;
var l_aName: AnsiString;
var l_aValue: AnsiString;
begin
 try
  l_aObject := TObject(aCtx.rEngine.PopObjAs(TObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aObject: TObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetStrProp(aCtx, l_aObject, l_aName, l_aValue);
end;//TkwPopObjectSetStrProp.DoDoIt

class function TkwPopObjectSetStrProp.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Object:SetStrProp';
end;//TkwPopObjectSetStrProp.GetWordNameForRegister

function TkwPopObjectSetStrProp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopObjectSetStrProp.GetResultTypeInfo

function TkwPopObjectSetStrProp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwPopObjectSetStrProp.GetAllParamsCount

function TkwPopObjectSetStrProp.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TObject), @tfw_tiString, @tfw_tiString]);
end;//TkwPopObjectSetStrProp.ParamsTypes

initialization
 TObjectFromstackWordsResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwPopObjectInherits.RegisterInEngine;
 {* Регистрация pop_Object_Inherits }
 TkwPopObjectClassName.RegisterInEngine;
 {* Регистрация pop_Object_ClassName }
 TkwPopObjectGetFloatProp.RegisterInEngine;
 {* Регистрация pop_Object_GetFloatProp }
 TkwPopObjectGetInterfaceProp.RegisterInEngine;
 {* Регистрация pop_Object_GetInterfaceProp }
 TkwPopObjectGetObjProp.RegisterInEngine;
 {* Регистрация pop_Object_GetObjProp }
 TkwPopObjectGetOrdProp.RegisterInEngine;
 {* Регистрация pop_Object_GetOrdProp }
 TkwPopObjectGetStrProp.RegisterInEngine;
 {* Регистрация pop_Object_GetStrProp }
 TkwPopObjectHasProp.RegisterInEngine;
 {* Регистрация pop_Object_HasProp }
 TkwPopObjectRTTIInfo.RegisterInEngine;
 {* Регистрация pop_Object_RTTIInfo }
 TkwPopObjectSetFloatProp.RegisterInEngine;
 {* Регистрация pop_Object_SetFloatProp }
 TkwPopObjectSetOrdProp.RegisterInEngine;
 {* Регистрация pop_Object_SetOrdProp }
 TkwPopObjectSetStrProp.RegisterInEngine;
 {* Регистрация pop_Object_SetStrProp }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TObject));
 {* Регистрация типа TObject }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(IUnknown));
 {* Регистрация типа IUnknown }
{$IfEnd} // NOT Defined(NoScripts)

end.
