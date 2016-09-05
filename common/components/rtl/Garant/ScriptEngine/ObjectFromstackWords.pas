unit ObjectFromstackWords;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ObjectFromstackWords.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ObjectFromstackWords" MUID: (507698410297)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwAxiomaticsResNameGetter
 , kwPopClassInherits
 , SysUtils
 , l3RTTI
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *507698410297impl_uses*
 //#UC END# *507698410297impl_uses*
;

type
 TkwPopObjectInherits = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:Inherits }
  private
   function Inherits(const aCtx: TtfwContext;
    aObject: TObject;
    const aClass: TtfwStackValue): Boolean;
    {* Реализация слова скрипта pop:Object:Inherits }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectInherits

 TkwPopObjectClassName = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:ClassName }
  private
   function ClassName(const aCtx: TtfwContext;
    aObject: TObject): AnsiString;
    {* Реализация слова скрипта pop:Object:ClassName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectClassName

 TkwPopObjectGetFloatProp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:GetFloatProp }
  private
   function GetFloatProp(const aCtx: TtfwContext;
    aObject: TObject;
    const aName: AnsiString): Integer;
    {* Реализация слова скрипта pop:Object:GetFloatProp }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectGetFloatProp

 TkwPopObjectGetInterfaceProp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:GetInterfaceProp }
  private
   function GetInterfaceProp(const aCtx: TtfwContext;
    aObject: TObject;
    const aName: AnsiString): IUnknown;
    {* Реализация слова скрипта pop:Object:GetInterfaceProp }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectGetInterfaceProp

 TkwPopObjectGetObjProp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:GetObjProp }
  private
   function GetObjProp(const aCtx: TtfwContext;
    aObject: TObject;
    const aName: AnsiString): TObject;
    {* Реализация слова скрипта pop:Object:GetObjProp }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectGetObjProp

 TkwPopObjectGetOrdProp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:GetOrdProp }
  private
   function GetOrdProp(const aCtx: TtfwContext;
    aObject: TObject;
    const aName: AnsiString): Integer;
    {* Реализация слова скрипта pop:Object:GetOrdProp }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectGetOrdProp

 TkwPopObjectGetStrProp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:GetStrProp }
  private
   function GetStrProp(const aCtx: TtfwContext;
    aObject: TObject;
    const aName: AnsiString): AnsiString;
    {* Реализация слова скрипта pop:Object:GetStrProp }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectGetStrProp

 TkwPopObjectHasProp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:HasProp }
  private
   function HasProp(const aCtx: TtfwContext;
    aObject: TObject;
    const aName: AnsiString): Boolean;
    {* Реализация слова скрипта pop:Object:HasProp }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectHasProp

 TkwPopObjectRTTIInfo = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:RTTIInfo }
  private
   function RTTIInfo(const aCtx: TtfwContext;
    aObject: TObject): AnsiString;
    {* Реализация слова скрипта pop:Object:RTTIInfo }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectRTTIInfo

 TkwPopObjectSetFloatProp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:SetFloatProp }
  private
   procedure SetFloatProp(const aCtx: TtfwContext;
    aObject: TObject;
    const aName: AnsiString;
    aValue: Integer);
    {* Реализация слова скрипта pop:Object:SetFloatProp }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectSetFloatProp

 TkwPopObjectSetOrdProp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:SetOrdProp }
  private
   procedure SetOrdProp(const aCtx: TtfwContext;
    aObject: TObject;
    const aName: AnsiString;
    aValue: Integer);
    {* Реализация слова скрипта pop:Object:SetOrdProp }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectSetOrdProp

 TkwPopObjectSetStrProp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Object:SetStrProp }
  private
   procedure SetStrProp(const aCtx: TtfwContext;
    aObject: TObject;
    const aName: AnsiString;
    const aValue: AnsiString);
    {* Реализация слова скрипта pop:Object:SetStrProp }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopObjectSetStrProp

 TObjectFromstackWordsResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TObjectFromstackWordsResNameGetter

function TkwPopObjectInherits.Inherits(const aCtx: TtfwContext;
 aObject: TObject;
 const aClass: TtfwStackValue): Boolean;
 {* Реализация слова скрипта pop:Object:Inherits }
//#UC START# *561275A50363_561275A50363_4807745602C8_Word_var*

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

//#UC END# *561275A50363_561275A50363_4807745602C8_Word_var*
begin
//#UC START# *561275A50363_561275A50363_4807745602C8_Word_impl*
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
//#UC END# *561275A50363_561275A50363_4807745602C8_Word_impl*
end;//TkwPopObjectInherits.Inherits

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

function TkwPopObjectClassName.ClassName(const aCtx: TtfwContext;
 aObject: TObject): AnsiString;
 {* Реализация слова скрипта pop:Object:ClassName }
//#UC START# *561276140246_561276140246_4807745602C8_Word_var*
//#UC END# *561276140246_561276140246_4807745602C8_Word_var*
begin
//#UC START# *561276140246_561276140246_4807745602C8_Word_impl*
 if (aObject = nil) then
  Result := 'Запросили имя класса у nil'
 else
  Result := aObject.ClassName;
//#UC END# *561276140246_561276140246_4807745602C8_Word_impl*
end;//TkwPopObjectClassName.ClassName

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

function TkwPopObjectGetFloatProp.GetFloatProp(const aCtx: TtfwContext;
 aObject: TObject;
 const aName: AnsiString): Integer;
 {* Реализация слова скрипта pop:Object:GetFloatProp }
//#UC START# *5612877900FD_5612877900FD_4807745602C8_Word_var*
//#UC END# *5612877900FD_5612877900FD_4807745602C8_Word_var*
begin
//#UC START# *5612877900FD_5612877900FD_4807745602C8_Word_impl*
 Result := Trunc(TypInfo.GetFloatProp(aObject, aName));
//#UC END# *5612877900FD_5612877900FD_4807745602C8_Word_impl*
end;//TkwPopObjectGetFloatProp.GetFloatProp

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

function TkwPopObjectGetInterfaceProp.GetInterfaceProp(const aCtx: TtfwContext;
 aObject: TObject;
 const aName: AnsiString): IUnknown;
 {* Реализация слова скрипта pop:Object:GetInterfaceProp }
//#UC START# *5612879D0254_5612879D0254_4807745602C8_Word_var*
//#UC END# *5612879D0254_5612879D0254_4807745602C8_Word_var*
begin
//#UC START# *5612879D0254_5612879D0254_4807745602C8_Word_impl*
 Result := TypInfo.GetInterfaceProp(aObject, aName);
//#UC END# *5612879D0254_5612879D0254_4807745602C8_Word_impl*
end;//TkwPopObjectGetInterfaceProp.GetInterfaceProp

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
 aCtx.rEngine.PushIntf(GetInterfaceProp(aCtx, l_aObject, l_aName), TypeInfo(IUnknown));
end;//TkwPopObjectGetInterfaceProp.DoDoIt

function TkwPopObjectGetObjProp.GetObjProp(const aCtx: TtfwContext;
 aObject: TObject;
 const aName: AnsiString): TObject;
 {* Реализация слова скрипта pop:Object:GetObjProp }
//#UC START# *561287BB03E6_561287BB03E6_4807745602C8_Word_var*
//#UC END# *561287BB03E6_561287BB03E6_4807745602C8_Word_var*
begin
//#UC START# *561287BB03E6_561287BB03E6_4807745602C8_Word_impl*
 Result := TypInfo.GetObjectProp(aObject, aName);
//#UC END# *561287BB03E6_561287BB03E6_4807745602C8_Word_impl*
end;//TkwPopObjectGetObjProp.GetObjProp

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

function TkwPopObjectGetOrdProp.GetOrdProp(const aCtx: TtfwContext;
 aObject: TObject;
 const aName: AnsiString): Integer;
 {* Реализация слова скрипта pop:Object:GetOrdProp }
//#UC START# *561287D60299_561287D60299_4807745602C8_Word_var*
//#UC END# *561287D60299_561287D60299_4807745602C8_Word_var*
begin
//#UC START# *561287D60299_561287D60299_4807745602C8_Word_impl*
 Result := TypInfo.GetOrdProp(aObject, aName);
//#UC END# *561287D60299_561287D60299_4807745602C8_Word_impl*
end;//TkwPopObjectGetOrdProp.GetOrdProp

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

function TkwPopObjectGetStrProp.GetStrProp(const aCtx: TtfwContext;
 aObject: TObject;
 const aName: AnsiString): AnsiString;
 {* Реализация слова скрипта pop:Object:GetStrProp }
//#UC START# *561287F1013D_561287F1013D_4807745602C8_Word_var*
//#UC END# *561287F1013D_561287F1013D_4807745602C8_Word_var*
begin
//#UC START# *561287F1013D_561287F1013D_4807745602C8_Word_impl*
 Result := TypInfo.GetStrProp(aObject, aName);
//#UC END# *561287F1013D_561287F1013D_4807745602C8_Word_impl*
end;//TkwPopObjectGetStrProp.GetStrProp

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

function TkwPopObjectHasProp.HasProp(const aCtx: TtfwContext;
 aObject: TObject;
 const aName: AnsiString): Boolean;
 {* Реализация слова скрипта pop:Object:HasProp }
//#UC START# *5612881202CE_5612881202CE_4807745602C8_Word_var*
//#UC END# *5612881202CE_5612881202CE_4807745602C8_Word_var*
begin
//#UC START# *5612881202CE_5612881202CE_4807745602C8_Word_impl*
 Result := TypInfo.IsPublishedProp(aObject, aName);
//#UC END# *5612881202CE_5612881202CE_4807745602C8_Word_impl*
end;//TkwPopObjectHasProp.HasProp

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

function TkwPopObjectRTTIInfo.RTTIInfo(const aCtx: TtfwContext;
 aObject: TObject): AnsiString;
 {* Реализация слова скрипта pop:Object:RTTIInfo }
//#UC START# *5612883002F0_5612883002F0_4807745602C8_Word_var*
//#UC END# *5612883002F0_5612883002F0_4807745602C8_Word_var*
begin
//#UC START# *5612883002F0_5612883002F0_4807745602C8_Word_impl*
 Result := l3FormatRTTIInfo(aObject);
//#UC END# *5612883002F0_5612883002F0_4807745602C8_Word_impl*
end;//TkwPopObjectRTTIInfo.RTTIInfo

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

procedure TkwPopObjectSetFloatProp.SetFloatProp(const aCtx: TtfwContext;
 aObject: TObject;
 const aName: AnsiString;
 aValue: Integer);
 {* Реализация слова скрипта pop:Object:SetFloatProp }
//#UC START# *5612884C014B_5612884C014B_4807745602C8_Word_var*
//#UC END# *5612884C014B_5612884C014B_4807745602C8_Word_var*
begin
//#UC START# *5612884C014B_5612884C014B_4807745602C8_Word_impl*
 TypInfo.SetFloatProp(aObject, aName, aValue);
//#UC END# *5612884C014B_5612884C014B_4807745602C8_Word_impl*
end;//TkwPopObjectSetFloatProp.SetFloatProp

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

procedure TkwPopObjectSetOrdProp.SetOrdProp(const aCtx: TtfwContext;
 aObject: TObject;
 const aName: AnsiString;
 aValue: Integer);
 {* Реализация слова скрипта pop:Object:SetOrdProp }
//#UC START# *5612887002C3_5612887002C3_4807745602C8_Word_var*
//#UC END# *5612887002C3_5612887002C3_4807745602C8_Word_var*
begin
//#UC START# *5612887002C3_5612887002C3_4807745602C8_Word_impl*
 TypInfo.SetOrdProp(aObject, aName, aValue);
//#UC END# *5612887002C3_5612887002C3_4807745602C8_Word_impl*
end;//TkwPopObjectSetOrdProp.SetOrdProp

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

procedure TkwPopObjectSetStrProp.SetStrProp(const aCtx: TtfwContext;
 aObject: TObject;
 const aName: AnsiString;
 const aValue: AnsiString);
 {* Реализация слова скрипта pop:Object:SetStrProp }
//#UC START# *5612889D0092_5612889D0092_4807745602C8_Word_var*
//#UC END# *5612889D0092_5612889D0092_4807745602C8_Word_var*
begin
//#UC START# *5612889D0092_5612889D0092_4807745602C8_Word_impl*
 TypInfo.SetStrProp(aObject, aName, aValue);
//#UC END# *5612889D0092_5612889D0092_4807745602C8_Word_impl*
end;//TkwPopObjectSetStrProp.SetStrProp

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

class function TObjectFromstackWordsResNameGetter.ResName: AnsiString;
begin
 Result := 'ObjectFromstackWords';
end;//TObjectFromstackWordsResNameGetter.ResName

{$R ObjectFromstackWords.res}

initialization
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
 TObjectFromstackWordsResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TObject));
 {* Регистрация типа TObject }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(IUnknown));
 {* Регистрация типа IUnknown }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
{$IfEnd} // NOT Defined(NoScripts)

end.
