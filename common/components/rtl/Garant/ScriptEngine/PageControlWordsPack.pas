unit PageControlWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\PageControlWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "PageControlWordsPack" MUID: (552E49070307)

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
 , ElPgCtl
 , tfwClassLike
 , tfwScriptingInterfaces
 , l3Interfaces
 , TypInfo
 , l3String
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopPageControlFindPageByCaption = {final} class(TtfwClassLike)
  {* Слово скрипта pop:PageControl:FindPageByCaption }
  private
   function FindPageByCaption(const aCtx: TtfwContext;
    aPageControl: TElCustomPageControl;
    const aCaption: Il3CString): Integer;
    {* Реализация слова скрипта pop:PageControl:FindPageByCaption }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopPageControlFindPageByCaption

 TkwPopPageControlPageCaptionByIndex = {final} class(TtfwClassLike)
  {* Слово скрипта pop:PageControl:PageCaptionByIndex }
  private
   function PageCaptionByIndex(const aCtx: TtfwContext;
    aPageControl: TElCustomPageControl;
    anIndex: Integer): AnsiString;
    {* Реализация слова скрипта pop:PageControl:PageCaptionByIndex }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopPageControlPageCaptionByIndex

 TkwPopPageControlPageByIndex = {final} class(TtfwClassLike)
  {* Слово скрипта pop:PageControl:PageByIndex }
  private
   function PageByIndex(const aCtx: TtfwContext;
    aPageControl: TElCustomPageControl;
    anIndex: Integer): TElTabSheet;
    {* Реализация слова скрипта pop:PageControl:PageByIndex }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopPageControlPageByIndex

 TkwPopPageControlGetAllPageCaptions = {final} class(TtfwClassLike)
  {* Слово скрипта pop:PageControl:GetAllPageCaptions }
  private
   function GetAllPageCaptions(const aCtx: TtfwContext;
    aPageControl: TElCustomPageControl): AnsiString;
    {* Реализация слова скрипта pop:PageControl:GetAllPageCaptions }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopPageControlGetAllPageCaptions

function TkwPopPageControlFindPageByCaption.FindPageByCaption(const aCtx: TtfwContext;
 aPageControl: TElCustomPageControl;
 const aCaption: Il3CString): Integer;
 {* Реализация слова скрипта pop:PageControl:FindPageByCaption }
//#UC START# *552E497A03E2_552E497A03E2_4E36C0C3014B_Word_var*
var
 I, l_PageNum: Integer;
//#UC END# *552E497A03E2_552E497A03E2_4E36C0C3014B_Word_var*
begin
//#UC START# *552E497A03E2_552E497A03E2_4E36C0C3014B_Word_impl*
 l_PageNum := 0;
 for I := 0 to aPageControl.PageCount - 1 do
  if aPageControl.Pages[I].TabVisible then
  begin
   if l3Same(aPageControl.Pages[I].Caption, aCaption) then
   begin
    Result := l_PageNum;
    Exit;
   end;
   Inc(l_PageNum);
  end;
 RunnerError('Вкладка не найдена!', aCtx);
 Result := -1;
//#UC END# *552E497A03E2_552E497A03E2_4E36C0C3014B_Word_impl*
end;//TkwPopPageControlFindPageByCaption.FindPageByCaption

class function TkwPopPageControlFindPageByCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:PageControl:FindPageByCaption';
end;//TkwPopPageControlFindPageByCaption.GetWordNameForRegister

function TkwPopPageControlFindPageByCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopPageControlFindPageByCaption.GetResultTypeInfo

function TkwPopPageControlFindPageByCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopPageControlFindPageByCaption.GetAllParamsCount

function TkwPopPageControlFindPageByCaption.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TElCustomPageControl), @tfw_tiString]);
end;//TkwPopPageControlFindPageByCaption.ParamsTypes

procedure TkwPopPageControlFindPageByCaption.DoDoIt(const aCtx: TtfwContext);
var l_aPageControl: TElCustomPageControl;
var l_aCaption: Il3CString;
begin
 try
  l_aPageControl := TElCustomPageControl(aCtx.rEngine.PopObjAs(TElCustomPageControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPageControl: TElCustomPageControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aCaption := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCaption: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(FindPageByCaption(aCtx, l_aPageControl, l_aCaption));
end;//TkwPopPageControlFindPageByCaption.DoDoIt

function TkwPopPageControlPageCaptionByIndex.PageCaptionByIndex(const aCtx: TtfwContext;
 aPageControl: TElCustomPageControl;
 anIndex: Integer): AnsiString;
 {* Реализация слова скрипта pop:PageControl:PageCaptionByIndex }
//#UC START# *552E49BC0078_552E49BC0078_4E36C0C3014B_Word_var*
var
 I : Integer;
//#UC END# *552E49BC0078_552E49BC0078_4E36C0C3014B_Word_var*
begin
//#UC START# *552E49BC0078_552E49BC0078_4E36C0C3014B_Word_impl*
 RunnerAssert(anIndex >= 0, 'Давай положительное число!', aCtx);
 RunnerAssert(anIndex < aPageControl.PageCount, 'На PageControl меньше вкладок!', aCtx);
 for I := 0 to aPageControl.PageCount - 1 do
  if aPageControl.Pages[I].TabVisible then
  begin
   if anIndex = 0 then
   begin
    Result := aPageControl.Pages[I].Caption;
    Break;
   end;
   Dec(anIndex);
  end;
//#UC END# *552E49BC0078_552E49BC0078_4E36C0C3014B_Word_impl*
end;//TkwPopPageControlPageCaptionByIndex.PageCaptionByIndex

class function TkwPopPageControlPageCaptionByIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:PageControl:PageCaptionByIndex';
end;//TkwPopPageControlPageCaptionByIndex.GetWordNameForRegister

function TkwPopPageControlPageCaptionByIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopPageControlPageCaptionByIndex.GetResultTypeInfo

function TkwPopPageControlPageCaptionByIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopPageControlPageCaptionByIndex.GetAllParamsCount

function TkwPopPageControlPageCaptionByIndex.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TElCustomPageControl), TypeInfo(Integer)]);
end;//TkwPopPageControlPageCaptionByIndex.ParamsTypes

procedure TkwPopPageControlPageCaptionByIndex.DoDoIt(const aCtx: TtfwContext);
var l_aPageControl: TElCustomPageControl;
var l_anIndex: Integer;
begin
 try
  l_aPageControl := TElCustomPageControl(aCtx.rEngine.PopObjAs(TElCustomPageControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPageControl: TElCustomPageControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(PageCaptionByIndex(aCtx, l_aPageControl, l_anIndex));
end;//TkwPopPageControlPageCaptionByIndex.DoDoIt

function TkwPopPageControlPageByIndex.PageByIndex(const aCtx: TtfwContext;
 aPageControl: TElCustomPageControl;
 anIndex: Integer): TElTabSheet;
 {* Реализация слова скрипта pop:PageControl:PageByIndex }
//#UC START# *552E49E00306_552E49E00306_4E36C0C3014B_Word_var*
//#UC END# *552E49E00306_552E49E00306_4E36C0C3014B_Word_var*
begin
//#UC START# *552E49E00306_552E49E00306_4E36C0C3014B_Word_impl*
 RunnerAssert(anIndex >= 0, 'Давай положительное число!', aCtx);
 RunnerAssert(anIndex < aPageControl.PageCount, 'На PageControl меньше вкладок!', aCtx);
 Result := aPageControl.Pages[anIndex];
//#UC END# *552E49E00306_552E49E00306_4E36C0C3014B_Word_impl*
end;//TkwPopPageControlPageByIndex.PageByIndex

class function TkwPopPageControlPageByIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:PageControl:PageByIndex';
end;//TkwPopPageControlPageByIndex.GetWordNameForRegister

function TkwPopPageControlPageByIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElTabSheet);
end;//TkwPopPageControlPageByIndex.GetResultTypeInfo

function TkwPopPageControlPageByIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopPageControlPageByIndex.GetAllParamsCount

function TkwPopPageControlPageByIndex.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TElCustomPageControl), TypeInfo(Integer)]);
end;//TkwPopPageControlPageByIndex.ParamsTypes

procedure TkwPopPageControlPageByIndex.DoDoIt(const aCtx: TtfwContext);
var l_aPageControl: TElCustomPageControl;
var l_anIndex: Integer;
begin
 try
  l_aPageControl := TElCustomPageControl(aCtx.rEngine.PopObjAs(TElCustomPageControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPageControl: TElCustomPageControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(PageByIndex(aCtx, l_aPageControl, l_anIndex));
end;//TkwPopPageControlPageByIndex.DoDoIt

function TkwPopPageControlGetAllPageCaptions.GetAllPageCaptions(const aCtx: TtfwContext;
 aPageControl: TElCustomPageControl): AnsiString;
 {* Реализация слова скрипта pop:PageControl:GetAllPageCaptions }
//#UC START# *552E4A5E02C9_552E4A5E02C9_4E36C0C3014B_Word_var*
var
 l_Captions: AnsiString;
 I: Integer;
//#UC END# *552E4A5E02C9_552E4A5E02C9_4E36C0C3014B_Word_var*
begin
//#UC START# *552E4A5E02C9_552E4A5E02C9_4E36C0C3014B_Word_impl*
 l_Captions := '';
 for I := 0 to aPageControl.PageCount - 1 do
  if aPageControl.Pages[I].TabVisible then
   if (Length(l_Captions) > 0) then
    l_Captions := l_Captions + ' | ' + l3Str(aPageControl.Pages[I].Caption)
   else
    l_Captions := l3Str(aPageControl.Pages[I].Caption);

 Result := l_Captions;
//#UC END# *552E4A5E02C9_552E4A5E02C9_4E36C0C3014B_Word_impl*
end;//TkwPopPageControlGetAllPageCaptions.GetAllPageCaptions

class function TkwPopPageControlGetAllPageCaptions.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:PageControl:GetAllPageCaptions';
end;//TkwPopPageControlGetAllPageCaptions.GetWordNameForRegister

function TkwPopPageControlGetAllPageCaptions.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopPageControlGetAllPageCaptions.GetResultTypeInfo

function TkwPopPageControlGetAllPageCaptions.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopPageControlGetAllPageCaptions.GetAllParamsCount

function TkwPopPageControlGetAllPageCaptions.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TElCustomPageControl)]);
end;//TkwPopPageControlGetAllPageCaptions.ParamsTypes

procedure TkwPopPageControlGetAllPageCaptions.DoDoIt(const aCtx: TtfwContext);
var l_aPageControl: TElCustomPageControl;
begin
 try
  l_aPageControl := TElCustomPageControl(aCtx.rEngine.PopObjAs(TElCustomPageControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPageControl: TElCustomPageControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(GetAllPageCaptions(aCtx, l_aPageControl));
end;//TkwPopPageControlGetAllPageCaptions.DoDoIt

initialization
 TkwPopPageControlFindPageByCaption.RegisterInEngine;
 {* Регистрация pop_PageControl_FindPageByCaption }
 TkwPopPageControlPageCaptionByIndex.RegisterInEngine;
 {* Регистрация pop_PageControl_PageCaptionByIndex }
 TkwPopPageControlPageByIndex.RegisterInEngine;
 {* Регистрация pop_PageControl_PageByIndex }
 TkwPopPageControlGetAllPageCaptions.RegisterInEngine;
 {* Регистрация pop_PageControl_GetAllPageCaptions }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElCustomPageControl));
 {* Регистрация типа TElCustomPageControl }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElTabSheet));
 {* Регистрация типа TElTabSheet }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
{$IfEnd} // NOT Defined(NoScripts)

end.
