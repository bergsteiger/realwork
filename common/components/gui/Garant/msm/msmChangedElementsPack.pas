unit msmChangedElementsPack;

// Модуль: "w:\common\components\gui\Garant\msm\msmChangedElementsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "msmChangedElementsPack" MUID: (57E323D500C6)

{$Include w:\common\components\msm.inc}

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
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
 , msmChangedElements
 , msmDeletedElements
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *57E323D500C6impl_uses*
 //#UC END# *57E323D500C6impl_uses*
;

type
 TkwMsmAddChangedElement = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта msm:AddChangedElement }
  private
   procedure msm_AddChangedElement(const aCtx: TtfwContext;
    aWord: TtfwWord);
    {* Реализация слова скрипта msm:AddChangedElement }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsmAddChangedElement

 TkwMsmIsDeletedElement = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта msm:IsDeletedElement }
  private
   function msm_IsDeletedElement(const aCtx: TtfwContext;
    aWord: TtfwWord): Boolean;
    {* Реализация слова скрипта msm:IsDeletedElement }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsmIsDeletedElement

procedure TkwMsmAddChangedElement.msm_AddChangedElement(const aCtx: TtfwContext;
 aWord: TtfwWord);
 {* Реализация слова скрипта msm:AddChangedElement }
//#UC START# *57E2AB6700A6_57E2AB6700A6_Word_var*
//#UC END# *57E2AB6700A6_57E2AB6700A6_Word_var*
begin
//#UC START# *57E2AB6700A6_57E2AB6700A6_Word_impl*
 TmsmChangedElements.Instance.Add(aWord);
//#UC END# *57E2AB6700A6_57E2AB6700A6_Word_impl*
end;//TkwMsmAddChangedElement.msm_AddChangedElement

class function TkwMsmAddChangedElement.GetWordNameForRegister: AnsiString;
begin
 Result := 'msm:AddChangedElement';
end;//TkwMsmAddChangedElement.GetWordNameForRegister

function TkwMsmAddChangedElement.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwMsmAddChangedElement.GetResultTypeInfo

function TkwMsmAddChangedElement.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMsmAddChangedElement.GetAllParamsCount

function TkwMsmAddChangedElement.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwMsmAddChangedElement.ParamsTypes

procedure TkwMsmAddChangedElement.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 msm_AddChangedElement(aCtx, l_aWord);
end;//TkwMsmAddChangedElement.DoDoIt

function TkwMsmIsDeletedElement.msm_IsDeletedElement(const aCtx: TtfwContext;
 aWord: TtfwWord): Boolean;
 {* Реализация слова скрипта msm:IsDeletedElement }
//#UC START# *57F7C0C9002F_57F7C0C9002F_Word_var*
var
 l_Index : Integer;
//#UC END# *57F7C0C9002F_57F7C0C9002F_Word_var*
begin
//#UC START# *57F7C0C9002F_57F7C0C9002F_Word_impl*
 Result := TmsmDeletedElements.Instance.FindData(aWord, l_Index);
//#UC END# *57F7C0C9002F_57F7C0C9002F_Word_impl*
end;//TkwMsmIsDeletedElement.msm_IsDeletedElement

class function TkwMsmIsDeletedElement.GetWordNameForRegister: AnsiString;
begin
 Result := 'msm:IsDeletedElement';
end;//TkwMsmIsDeletedElement.GetWordNameForRegister

function TkwMsmIsDeletedElement.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwMsmIsDeletedElement.GetResultTypeInfo

function TkwMsmIsDeletedElement.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMsmIsDeletedElement.GetAllParamsCount

function TkwMsmIsDeletedElement.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwMsmIsDeletedElement.ParamsTypes

procedure TkwMsmIsDeletedElement.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(msm_IsDeletedElement(aCtx, l_aWord));
end;//TkwMsmIsDeletedElement.DoDoIt

initialization
 TkwMsmAddChangedElement.RegisterInEngine;
 {* Регистрация msm_AddChangedElement }
 TkwMsmIsDeletedElement.RegisterInEngine;
 {* Регистрация msm_IsDeletedElement }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
