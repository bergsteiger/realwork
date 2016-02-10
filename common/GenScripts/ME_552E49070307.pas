unit PageControlWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\PageControlWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ElPgCtl
 , l3Interfaces
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopPageControlFindPageByCaption = {final} class(TtfwClassLike)
  {* Слово скрипта pop:PageControl:FindPageByCaption
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aCaption aPageControl pop:PageControl:FindPageByCaption >>> l_Integer
[code]  }
  private
   function FindPageByCaption(const aCtx: TtfwContext;
    aPageControl: TElCustomPageControl;
    const aCaption: Il3CString): Integer;
    {* Реализация слова скрипта pop:PageControl:FindPageByCaption }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopPageControlFindPageByCaption

 TkwPopPageControlPageCaptionByIndex = {final} class(TtfwClassLike)
  {* Слово скрипта pop:PageControl:PageCaptionByIndex
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 anIndex aPageControl pop:PageControl:PageCaptionByIndex >>> l_String
[code]  }
  private
   function PageCaptionByIndex(const aCtx: TtfwContext;
    aPageControl: TElCustomPageControl;
    anIndex: Integer): AnsiString;
    {* Реализация слова скрипта pop:PageControl:PageCaptionByIndex }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopPageControlPageCaptionByIndex

 TkwPopPageControlPageByIndex = {final} class(TtfwClassLike)
  {* Слово скрипта pop:PageControl:PageByIndex
*Тип результата:* TElTabSheet
*Пример:*
[code]
OBJECT VAR l_TElTabSheet
 anIndex aPageControl pop:PageControl:PageByIndex >>> l_TElTabSheet
[code]  }
  private
   function PageByIndex(const aCtx: TtfwContext;
    aPageControl: TElCustomPageControl;
    anIndex: Integer): TElTabSheet;
    {* Реализация слова скрипта pop:PageControl:PageByIndex }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopPageControlPageByIndex

 TkwPopPageControlGetAllPageCaptions = {final} class(TtfwClassLike)
  {* Слово скрипта pop:PageControl:GetAllPageCaptions
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aPageControl pop:PageControl:GetAllPageCaptions >>> l_String
[code]  }
  private
   function GetAllPageCaptions(const aCtx: TtfwContext;
    aPageControl: TElCustomPageControl): AnsiString;
    {* Реализация слова скрипта pop:PageControl:GetAllPageCaptions }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopPageControlGetAllPageCaptions

function TkwPopPageControlFindPageByCaption.FindPageByCaption(const aCtx: TtfwContext;
 aPageControl: TElCustomPageControl;
 const aCaption: Il3CString): Integer;
 {* Реализация слова скрипта pop:PageControl:FindPageByCaption }
//#UC START# *FCC6A46AF340_39ABBBDC9493_var*
var
 I, l_PageNum: Integer;
//#UC END# *FCC6A46AF340_39ABBBDC9493_var*
begin
//#UC START# *FCC6A46AF340_39ABBBDC9493_impl*
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
//#UC END# *FCC6A46AF340_39ABBBDC9493_impl*
end;//TkwPopPageControlFindPageByCaption.FindPageByCaption

procedure TkwPopPageControlFindPageByCaption.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_39ABBBDC9493_var*
//#UC END# *4DAEEDE10285_39ABBBDC9493_var*
begin
//#UC START# *4DAEEDE10285_39ABBBDC9493_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_39ABBBDC9493_impl*
end;//TkwPopPageControlFindPageByCaption.DoDoIt

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
//#UC START# *5617F4D00243_39ABBBDC9493_var*
//#UC END# *5617F4D00243_39ABBBDC9493_var*
begin
//#UC START# *5617F4D00243_39ABBBDC9493_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_39ABBBDC9493_impl*
end;//TkwPopPageControlFindPageByCaption.ParamsTypes

function TkwPopPageControlPageCaptionByIndex.PageCaptionByIndex(const aCtx: TtfwContext;
 aPageControl: TElCustomPageControl;
 anIndex: Integer): AnsiString;
 {* Реализация слова скрипта pop:PageControl:PageCaptionByIndex }
//#UC START# *600644323CE8_1C7B18964322_var*
var
 I : Integer;
//#UC END# *600644323CE8_1C7B18964322_var*
begin
//#UC START# *600644323CE8_1C7B18964322_impl*
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
//#UC END# *600644323CE8_1C7B18964322_impl*
end;//TkwPopPageControlPageCaptionByIndex.PageCaptionByIndex

procedure TkwPopPageControlPageCaptionByIndex.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1C7B18964322_var*
//#UC END# *4DAEEDE10285_1C7B18964322_var*
begin
//#UC START# *4DAEEDE10285_1C7B18964322_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1C7B18964322_impl*
end;//TkwPopPageControlPageCaptionByIndex.DoDoIt

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
//#UC START# *5617F4D00243_1C7B18964322_var*
//#UC END# *5617F4D00243_1C7B18964322_var*
begin
//#UC START# *5617F4D00243_1C7B18964322_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1C7B18964322_impl*
end;//TkwPopPageControlPageCaptionByIndex.ParamsTypes

function TkwPopPageControlPageByIndex.PageByIndex(const aCtx: TtfwContext;
 aPageControl: TElCustomPageControl;
 anIndex: Integer): TElTabSheet;
 {* Реализация слова скрипта pop:PageControl:PageByIndex }
//#UC START# *2BB966C33F13_CF3FBFFD21B3_var*
//#UC END# *2BB966C33F13_CF3FBFFD21B3_var*
begin
//#UC START# *2BB966C33F13_CF3FBFFD21B3_impl*
 RunnerAssert(anIndex >= 0, 'Давай положительное число!', aCtx);
 RunnerAssert(anIndex < aPageControl.PageCount, 'На PageControl меньше вкладок!', aCtx);
 Result := aPageControl.Pages[anIndex];
//#UC END# *2BB966C33F13_CF3FBFFD21B3_impl*
end;//TkwPopPageControlPageByIndex.PageByIndex

procedure TkwPopPageControlPageByIndex.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CF3FBFFD21B3_var*
//#UC END# *4DAEEDE10285_CF3FBFFD21B3_var*
begin
//#UC START# *4DAEEDE10285_CF3FBFFD21B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CF3FBFFD21B3_impl*
end;//TkwPopPageControlPageByIndex.DoDoIt

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
//#UC START# *5617F4D00243_CF3FBFFD21B3_var*
//#UC END# *5617F4D00243_CF3FBFFD21B3_var*
begin
//#UC START# *5617F4D00243_CF3FBFFD21B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_CF3FBFFD21B3_impl*
end;//TkwPopPageControlPageByIndex.ParamsTypes

function TkwPopPageControlGetAllPageCaptions.GetAllPageCaptions(const aCtx: TtfwContext;
 aPageControl: TElCustomPageControl): AnsiString;
 {* Реализация слова скрипта pop:PageControl:GetAllPageCaptions }
//#UC START# *29701A9D9F2B_2A5E921BA82F_var*
var
 l_Captions: AnsiString;
 I: Integer;
//#UC END# *29701A9D9F2B_2A5E921BA82F_var*
begin
//#UC START# *29701A9D9F2B_2A5E921BA82F_impl*
 l_Captions := '';
 for I := 0 to aPageControl.PageCount - 1 do
  if aPageControl.Pages[I].TabVisible then
   if (Length(l_Captions) > 0) then
    l_Captions := l_Captions + ' | ' + l3Str(aPageControl.Pages[I].Caption)
   else
    l_Captions := l3Str(aPageControl.Pages[I].Caption);

 Result := l_Captions;
//#UC END# *29701A9D9F2B_2A5E921BA82F_impl*
end;//TkwPopPageControlGetAllPageCaptions.GetAllPageCaptions

procedure TkwPopPageControlGetAllPageCaptions.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2A5E921BA82F_var*
//#UC END# *4DAEEDE10285_2A5E921BA82F_var*
begin
//#UC START# *4DAEEDE10285_2A5E921BA82F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2A5E921BA82F_impl*
end;//TkwPopPageControlGetAllPageCaptions.DoDoIt

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
//#UC START# *5617F4D00243_2A5E921BA82F_var*
//#UC END# *5617F4D00243_2A5E921BA82F_var*
begin
//#UC START# *5617F4D00243_2A5E921BA82F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2A5E921BA82F_impl*
end;//TkwPopPageControlGetAllPageCaptions.ParamsTypes

initialization
 TkwPopPageControlFindPageByCaption.RegisterInEngine;
 {* Регистрация pop_PageControl_FindPageByCaption }
 TkwPopPageControlPageCaptionByIndex.RegisterInEngine;
 {* Регистрация pop_PageControl_PageCaptionByIndex }
 TkwPopPageControlPageByIndex.RegisterInEngine;
 {* Регистрация pop_PageControl_PageByIndex }
 TkwPopPageControlGetAllPageCaptions.RegisterInEngine;
 {* Регистрация pop_PageControl_GetAllPageCaptions }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElCustomPageControl));
 {* Регистрация типа TElCustomPageControl }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElTabSheet));
 {* Регистрация типа TElTabSheet }
{$IfEnd} // NOT Defined(NoScripts)

end.
