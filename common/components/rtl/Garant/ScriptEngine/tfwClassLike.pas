unit tfwClassLike;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwClassLike.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwClassLike" MUID: (55CCAE000335)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , kwCompiledWordPrimPrim
 , tfwWordRefList
;

type
 TtfwClassLikeRunner = class(TkwCompiledWordPrimPrim)
  private
   f_LeftWordRefs: TtfwWordRefList;
  protected
   procedure PushParams(const aCtx: TtfwContext);
   procedure DoDoIt(const aCtx: TtfwContext); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo; override;
  public
   constructor Create(aWordProducer: TtfwWord;
    const aCtx: TtfwContext;
    aLeftWordRefs: TtfwWordRefList); reintroduce;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetValue(const aCtx: TtfwContext): TtfwStackValue; override;
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   function LeftWordRefParamsCount(const aCtx: TtfwContext): Integer; override;
   function GetLeftWordRefValue(const aCtx: TtfwContext;
    anIndex: Integer): TtfwWord; override;
   function LeftWordRefValuesCount(const aCtx: TtfwContext): Integer; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure SetValue(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TtfwClassLikeRunner

 TtfwClassLike = {abstract} class(TtfwRegisterableWord)
  protected
   function BindParams: Boolean; virtual;
   function StrictChecking: Boolean; virtual;
   procedure PushAdditionalParams(const aCtx: TtfwContext); override;
  public
   function LeftWordRefParamsCount(const aCtx: TtfwContext): Integer; override;
   function MakeRefForCompile(const aCtx: TtfwContext;
    aSNI: TtfwSuppressNextImmediate): TtfwWord; override;
   procedure SetValue(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TtfwClassLike
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwCompiledWordPrim
 , TypInfo
 , tfwValueTypes
 , SysUtils
 //#UC START# *55CCAE000335impl_uses*
 //#UC END# *55CCAE000335impl_uses*
;

constructor TtfwClassLikeRunner.Create(aWordProducer: TtfwWord;
 const aCtx: TtfwContext;
 aLeftWordRefs: TtfwWordRefList);
//#UC START# *55EEDC7E039C_55EEDC5001F3_var*
//#UC END# *55EEDC7E039C_55EEDC5001F3_var*
begin
//#UC START# *55EEDC7E039C_55EEDC5001F3_impl*
 inherited Create(aWordProducer, aCtx, aWordProducer.Key);
 aLeftWordRefs.SetRefTo(f_LeftWordRefs);
//#UC END# *55EEDC7E039C_55EEDC5001F3_impl*
end;//TtfwClassLikeRunner.Create

procedure TtfwClassLikeRunner.PushParams(const aCtx: TtfwContext);
//#UC START# *5617E35E018C_55EEDC5001F3_var*
var
 l_Index : Integer;
//#UC END# *5617E35E018C_55EEDC5001F3_var*
begin
//#UC START# *5617E35E018C_55EEDC5001F3_impl*
 for l_Index := 0 to Pred(f_LeftWordRefs.Count) do
  f_LeftWordRefs.Items[l_Index].DoIt(aCtx);
//#UC END# *5617E35E018C_55EEDC5001F3_impl*
end;//TtfwClassLikeRunner.PushParams

procedure TtfwClassLikeRunner.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55EEDC5001F3_var*
//#UC END# *4DAEEDE10285_55EEDC5001F3_var*
begin
//#UC START# *4DAEEDE10285_55EEDC5001F3_impl*
 PushParams(aCtx);
 WordProducer.DoIt(aCtx);
//#UC END# *4DAEEDE10285_55EEDC5001F3_impl*
end;//TtfwClassLikeRunner.DoDoIt

procedure TtfwClassLikeRunner.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55EEDC5001F3_var*
//#UC END# *479731C50290_55EEDC5001F3_var*
begin
//#UC START# *479731C50290_55EEDC5001F3_impl*
 FreeAndNil(f_LeftWordRefs);
 inherited;
//#UC END# *479731C50290_55EEDC5001F3_impl*
end;//TtfwClassLikeRunner.Cleanup

function TtfwClassLikeRunner.pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo;
//#UC START# *52CFC11603C8_55EEDC5001F3get_var*
//#UC END# *52CFC11603C8_55EEDC5001F3get_var*
begin
//#UC START# *52CFC11603C8_55EEDC5001F3get_impl*
 Result := WordProducer.ResultTypeInfo[aCtx];
//#UC END# *52CFC11603C8_55EEDC5001F3get_impl*
end;//TtfwClassLikeRunner.pm_GetResultTypeInfo

procedure TtfwClassLikeRunner.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_55EEDC5001F3_var*
//#UC END# *52D00B00031A_55EEDC5001F3_var*
begin
//#UC START# *52D00B00031A_55EEDC5001F3_impl*
 PushParams(aCtx);
 WordProducer.SetValuePrim(aValue, aCtx);
//#UC END# *52D00B00031A_55EEDC5001F3_impl*
end;//TtfwClassLikeRunner.SetValuePrim

function TtfwClassLikeRunner.GetValue(const aCtx: TtfwContext): TtfwStackValue;
//#UC START# *52D399A00173_55EEDC5001F3_var*
//#UC END# *52D399A00173_55EEDC5001F3_var*
begin
//#UC START# *52D399A00173_55EEDC5001F3_impl*
 Result := WordProducer.GetValue(aCtx);
//#UC END# *52D399A00173_55EEDC5001F3_impl*
end;//TtfwClassLikeRunner.GetValue

function TtfwClassLikeRunner.RightParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *52E9282B0271_55EEDC5001F3_var*
//#UC END# *52E9282B0271_55EEDC5001F3_var*
begin
//#UC START# *52E9282B0271_55EEDC5001F3_impl*
 Result := WordProducer.RightParamsCount(aCtx);
//#UC END# *52E9282B0271_55EEDC5001F3_impl*
end;//TtfwClassLikeRunner.RightParamsCount

function TtfwClassLikeRunner.LeftWordRefParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *53E4914101D2_55EEDC5001F3_var*
//#UC END# *53E4914101D2_55EEDC5001F3_var*
begin
//#UC START# *53E4914101D2_55EEDC5001F3_impl*
 Result := WordProducer.LeftWordRefParamsCount(aCtx);
//#UC END# *53E4914101D2_55EEDC5001F3_impl*
end;//TtfwClassLikeRunner.LeftWordRefParamsCount

function TtfwClassLikeRunner.GetLeftWordRefValue(const aCtx: TtfwContext;
 anIndex: Integer): TtfwWord;
//#UC START# *53E4A3C100AB_55EEDC5001F3_var*
//#UC END# *53E4A3C100AB_55EEDC5001F3_var*
begin
//#UC START# *53E4A3C100AB_55EEDC5001F3_impl*
 CompilerAssert(f_LeftWordRefs <> nil, 'Нету значений для левых параметров по ссылке', aCtx);
 CompilerAssert((anIndex >= 0) AND (anIndex < f_LeftWordRefs.Count), 'Нету значения для левого параметра по ссылке, для индекса ' + IntToStr(anIndex), aCtx);
 Result := f_LeftWordRefs.Items[anIndex];
//#UC END# *53E4A3C100AB_55EEDC5001F3_impl*
end;//TtfwClassLikeRunner.GetLeftWordRefValue

function TtfwClassLikeRunner.LeftWordRefValuesCount(const aCtx: TtfwContext): Integer;
//#UC START# *53E4A96A0085_55EEDC5001F3_var*
//#UC END# *53E4A96A0085_55EEDC5001F3_var*
begin
//#UC START# *53E4A96A0085_55EEDC5001F3_impl*
 if (f_LeftWordRefs = nil) then
  Result := 0
 else
  Result := f_LeftWordRefs.Count; 
//#UC END# *53E4A96A0085_55EEDC5001F3_impl*
end;//TtfwClassLikeRunner.LeftWordRefValuesCount

function TtfwClassLikeRunner.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_55EEDC5001F3_var*
//#UC END# *559687E6025A_55EEDC5001F3_var*
begin
//#UC START# *559687E6025A_55EEDC5001F3_impl*
 Result := WordProducer.GetAllParamsCount(aCtx);
//#UC END# *559687E6025A_55EEDC5001F3_impl*
end;//TtfwClassLikeRunner.GetAllParamsCount

procedure TtfwClassLikeRunner.SetValue(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *56096688024A_55EEDC5001F3_var*
//#UC END# *56096688024A_55EEDC5001F3_var*
begin
//#UC START# *56096688024A_55EEDC5001F3_impl*
 PushParams(aCtx);
 WordProducer.SetValue(aValue, aCtx);
//#UC END# *56096688024A_55EEDC5001F3_impl*
end;//TtfwClassLikeRunner.SetValue

function TtfwClassLike.BindParams: Boolean;
//#UC START# *5617C8A30023_55CCAE000335_var*
//#UC END# *5617C8A30023_55CCAE000335_var*
begin
//#UC START# *5617C8A30023_55CCAE000335_impl*
 //Result := false;
 Result := true;
//#UC END# *5617C8A30023_55CCAE000335_impl*
end;//TtfwClassLike.BindParams

function TtfwClassLike.StrictChecking: Boolean;
//#UC START# *561916700342_55CCAE000335_var*
//#UC END# *561916700342_55CCAE000335_var*
begin
//#UC START# *561916700342_55CCAE000335_impl*
 Result := false;
//#UC END# *561916700342_55CCAE000335_impl*
end;//TtfwClassLike.StrictChecking

function TtfwClassLike.LeftWordRefParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *53E4914101D2_55CCAE000335_var*
//#UC END# *53E4914101D2_55CCAE000335_var*
begin
//#UC START# *53E4914101D2_55CCAE000335_impl*
 if BindParams then
  Result := GetAllParamsCount(aCtx) - RightParamsCount(aCtx)
 else
  Result := 0; 
//#UC END# *53E4914101D2_55CCAE000335_impl*
end;//TtfwClassLike.LeftWordRefParamsCount

function TtfwClassLike.MakeRefForCompile(const aCtx: TtfwContext;
 aSNI: TtfwSuppressNextImmediate): TtfwWord;
//#UC START# *55CB5B8C004E_55CCAE000335_var*
var
 l_LeftWordRefCount : Integer;
 l_CodeIndex : Integer;
 l_Code : TtfwWordRefList;
 l_Index : Integer;
 l_AllParamsValid : Boolean;
 l_Refs : TtfwWordRefList;
 l_Types : PTypeInfoArray;
 l_TI : TtfwWordInfo;
 l_TypeIndex : Integer;
 l_ParamType : PTypeInfo;
//#UC END# *55CB5B8C004E_55CCAE000335_var*
begin
//#UC START# *55CB5B8C004E_55CCAE000335_impl*
 if (aSNI = tfw_sniNo) then 
 begin
  //if BindParams then
  if false then
  begin
   l_LeftWordRefCount := Self.LeftWordRefParamsCount(aCtx);
   if (l_LeftWordRefCount > 0) AND (aCtx.rWordCompilingNow <> nil) then
   begin
    l_CodeIndex := aCtx.rWordCompilingNow.CodeCount;
    if (l_LeftWordRefCount <= l_CodeIndex) then
    begin
     Dec(l_CodeIndex);
     if (aCtx.rWordCompilingNow Is TkwCompiledWordPrim) then
     begin
      l_Code := TkwCompiledWordPrim(aCtx.rWordCompilingNow).GetCode(aCtx);
      if (l_Code <> nil) then
      begin
       l_AllParamsValid := true;
       l_Types := ParamsTypes;
       l_TypeIndex := RightParamsCount(aCtx);
       for l_Index := l_CodeIndex downto l_CodeIndex - l_LeftWordRefCount + 1 do
       begin
        if not l_Code.Items[l_Index].IsCompleted(aCtx) then
        begin
         l_AllParamsValid := false;
         break;
        end;//not l_Code.Items[l_Index].IsCompleted(aCtx)
        l_TI := l_Code.Items[l_Index].ResultTypeInfo[aCtx];
        l_ParamType := l_Types[l_TypeIndex];
        if (l_TI.ValueTypes.AcceptableBy(TtfwTypeInfo_C(l_ParamType)) = tfw_vtaNo) then
        begin
         l_AllParamsValid := false;
         break;
        end; 
        Inc(l_TypeIndex);
       end;//for l_Index
       if l_AllParamsValid then
       begin
        l_Refs := TtfwWordRefList.Create;
        try
         while (l_LeftWordRefCount > 0) do
         begin
          l_Refs.Insert(0, l_Code.Items[l_CodeIndex]);
          l_Code.Delete(l_CodeIndex);
          Dec(l_LeftWordRefCount);
          Dec(l_CodeIndex);
         end;//l_LeftWordRefCount > 0)
         Result := TtfwClassLikeRunner.Create(Self, aCtx, l_Refs);
        finally
         FreeAndNil(l_Refs);
        end;//try..finally 
        Exit;
       end;//l_AllParamsValid 
      end;//l_Code <> nil 
     end;//aContext.rWordCompilingNow Is TkwCompiledWordPrim
    end;//l_LeftWordRefCount <= l_CodeIndex
   end;//l_LeftWordRefCount > 0
  end;//BindParams
 end;//aSNI = tfw_sniNo
 Result := inherited MakeRefForCompile(aCtx, aSNI);
//#UC END# *55CB5B8C004E_55CCAE000335_impl*
end;//TtfwClassLike.MakeRefForCompile

procedure TtfwClassLike.PushAdditionalParams(const aCtx: TtfwContext);
//#UC START# *55EED3920052_55CCAE000335_var*
//#UC END# *55EED3920052_55CCAE000335_var*
begin
//#UC START# *55EED3920052_55CCAE000335_impl*
 inherited;
//#UC END# *55EED3920052_55CCAE000335_impl*
end;//TtfwClassLike.PushAdditionalParams

procedure TtfwClassLike.SetValue(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *56096688024A_55CCAE000335_var*
//#UC END# *56096688024A_55CCAE000335_var*
begin
//#UC START# *56096688024A_55CCAE000335_impl*
 SetValuePrim(aValue, aCtx);
//#UC END# *56096688024A_55CCAE000335_impl*
end;//TtfwClassLike.SetValue

initialization
 TtfwClassLikeRunner.RegisterClass;
 {* Регистрация TtfwClassLikeRunner }
 TtfwClassLike.RegisterClass;
 {* Регистрация TtfwClassLike }
{$IfEnd} // NOT Defined(NoScripts)

end.
