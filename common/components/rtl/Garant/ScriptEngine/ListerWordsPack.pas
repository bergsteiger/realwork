unit ListerWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ListerWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ListerWordsPack" MUID: (552E47C10290)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , vtLister
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *552E47C10290impl_uses*
 //#UC END# *552E47C10290impl_uses*
;

type
 TvtCustomListerFriend = {abstract} class(TvtCustomLister)
  {* Друг к классу TvtCustomLister }
 end;//TvtCustomListerFriend

 TkwPopListerSelectWithShift = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Lister:SelectWithShift }
  private
   procedure SelectWithShift(const aCtx: TtfwContext;
    aLister: TvtCustomLister;
    aFinish: Integer);
    {* Реализация слова скрипта pop:Lister:SelectWithShift }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopListerSelectWithShift

 TkwPopListerGetSelected = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Lister:GetSelected }
  private
   function GetSelected(const aCtx: TtfwContext;
    aLister: TvtCustomLister;
    anIndex: Integer): Boolean;
    {* Реализация слова скрипта pop:Lister:GetSelected }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopListerGetSelected

 TkwPopListerFooterCaption = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Lister:FooterCaption }
  private
   function FooterCaption(const aCtx: TtfwContext;
    aLister: TvtCustomLister): AnsiString;
    {* Реализация слова скрипта pop:Lister:FooterCaption }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopListerFooterCaption

 TkwPopListerCurrent = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Lister:Current }
  private
   function Current(const aCtx: TtfwContext;
    aLister: TvtCustomLister): Integer;
    {* Реализация слова скрипта pop:Lister:Current }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopListerCurrent

procedure TkwPopListerSelectWithShift.SelectWithShift(const aCtx: TtfwContext;
 aLister: TvtCustomLister;
 aFinish: Integer);
 {* Реализация слова скрипта pop:Lister:SelectWithShift }
//#UC START# *552E482B0030_552E482B0030_515062D301C4_Word_var*
//#UC END# *552E482B0030_552E482B0030_515062D301C4_Word_var*
begin
//#UC START# *552E482B0030_552E482B0030_515062D301C4_Word_impl*
 aLister.SelectItems(aFinish);
//#UC END# *552E482B0030_552E482B0030_515062D301C4_Word_impl*
end;//TkwPopListerSelectWithShift.SelectWithShift

class function TkwPopListerSelectWithShift.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Lister:SelectWithShift';
end;//TkwPopListerSelectWithShift.GetWordNameForRegister

function TkwPopListerSelectWithShift.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopListerSelectWithShift.GetResultTypeInfo

function TkwPopListerSelectWithShift.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopListerSelectWithShift.GetAllParamsCount

function TkwPopListerSelectWithShift.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomLister), TypeInfo(Integer)]);
end;//TkwPopListerSelectWithShift.ParamsTypes

procedure TkwPopListerSelectWithShift.DoDoIt(const aCtx: TtfwContext);
var l_aLister: TvtCustomLister;
var l_aFinish: Integer;
begin
 try
  l_aLister := TvtCustomLister(aCtx.rEngine.PopObjAs(TvtCustomLister));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLister: TvtCustomLister : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFinish := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFinish: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SelectWithShift(aCtx, l_aLister, l_aFinish);
end;//TkwPopListerSelectWithShift.DoDoIt

function TkwPopListerGetSelected.GetSelected(const aCtx: TtfwContext;
 aLister: TvtCustomLister;
 anIndex: Integer): Boolean;
 {* Реализация слова скрипта pop:Lister:GetSelected }
//#UC START# *552E485701AB_552E485701AB_515062D301C4_Word_var*
//#UC END# *552E485701AB_552E485701AB_515062D301C4_Word_var*
begin
//#UC START# *552E485701AB_552E485701AB_515062D301C4_Word_impl*
 Result := aLister.Selected[anIndex];
//#UC END# *552E485701AB_552E485701AB_515062D301C4_Word_impl*
end;//TkwPopListerGetSelected.GetSelected

class function TkwPopListerGetSelected.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Lister:GetSelected';
end;//TkwPopListerGetSelected.GetWordNameForRegister

function TkwPopListerGetSelected.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopListerGetSelected.GetResultTypeInfo

function TkwPopListerGetSelected.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopListerGetSelected.GetAllParamsCount

function TkwPopListerGetSelected.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomLister), TypeInfo(Integer)]);
end;//TkwPopListerGetSelected.ParamsTypes

procedure TkwPopListerGetSelected.DoDoIt(const aCtx: TtfwContext);
var l_aLister: TvtCustomLister;
var l_anIndex: Integer;
begin
 try
  l_aLister := TvtCustomLister(aCtx.rEngine.PopObjAs(TvtCustomLister));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLister: TvtCustomLister : ' + E.Message, aCtx);
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
 aCtx.rEngine.PushBool(GetSelected(aCtx, l_aLister, l_anIndex));
end;//TkwPopListerGetSelected.DoDoIt

function TkwPopListerFooterCaption.FooterCaption(const aCtx: TtfwContext;
 aLister: TvtCustomLister): AnsiString;
 {* Реализация слова скрипта pop:Lister:FooterCaption }
//#UC START# *552E48AF00FD_552E48AF00FD_515062D301C4_Word_var*
//#UC END# *552E48AF00FD_552E48AF00FD_515062D301C4_Word_var*
begin
//#UC START# *552E48AF00FD_552E48AF00FD_515062D301C4_Word_impl*
 Result := TvtCustomListerFriend(aLister).FooterCaption;
//#UC END# *552E48AF00FD_552E48AF00FD_515062D301C4_Word_impl*
end;//TkwPopListerFooterCaption.FooterCaption

class function TkwPopListerFooterCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Lister:FooterCaption';
end;//TkwPopListerFooterCaption.GetWordNameForRegister

function TkwPopListerFooterCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopListerFooterCaption.GetResultTypeInfo

function TkwPopListerFooterCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopListerFooterCaption.GetAllParamsCount

function TkwPopListerFooterCaption.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomLister)]);
end;//TkwPopListerFooterCaption.ParamsTypes

procedure TkwPopListerFooterCaption.DoDoIt(const aCtx: TtfwContext);
var l_aLister: TvtCustomLister;
begin
 try
  l_aLister := TvtCustomLister(aCtx.rEngine.PopObjAs(TvtCustomLister));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLister: TvtCustomLister : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(FooterCaption(aCtx, l_aLister));
end;//TkwPopListerFooterCaption.DoDoIt

function TkwPopListerCurrent.Current(const aCtx: TtfwContext;
 aLister: TvtCustomLister): Integer;
 {* Реализация слова скрипта pop:Lister:Current }
begin
 Result := aLister.Current;
end;//TkwPopListerCurrent.Current

class function TkwPopListerCurrent.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Lister:Current';
end;//TkwPopListerCurrent.GetWordNameForRegister

function TkwPopListerCurrent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopListerCurrent.GetResultTypeInfo

function TkwPopListerCurrent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopListerCurrent.GetAllParamsCount

function TkwPopListerCurrent.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomLister)]);
end;//TkwPopListerCurrent.ParamsTypes

procedure TkwPopListerCurrent.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Current', aCtx);
end;//TkwPopListerCurrent.SetValuePrim

procedure TkwPopListerCurrent.DoDoIt(const aCtx: TtfwContext);
var l_aLister: TvtCustomLister;
begin
 try
  l_aLister := TvtCustomLister(aCtx.rEngine.PopObjAs(TvtCustomLister));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLister: TvtCustomLister : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Current(aCtx, l_aLister));
end;//TkwPopListerCurrent.DoDoIt

initialization
 TkwPopListerSelectWithShift.RegisterInEngine;
 {* Регистрация pop_Lister_SelectWithShift }
 TkwPopListerGetSelected.RegisterInEngine;
 {* Регистрация pop_Lister_GetSelected }
 TkwPopListerFooterCaption.RegisterInEngine;
 {* Регистрация pop_Lister_FooterCaption }
 TkwPopListerCurrent.RegisterInEngine;
 {* Регистрация pop_Lister_Current }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCustomLister));
 {* Регистрация типа TvtCustomLister }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
