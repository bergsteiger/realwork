unit ImsmModelElementListWordsPack;

// Модуль: "w:\common\components\gui\Garant\msm\ImsmModelElementListWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ImsmModelElementListWordsPack" MUID: (58095A5103B5)

{$Include w:\common\components\msm.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , msmModelElements
 , msmEvents
 , tfwScriptingInterfaces
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwClassLike
 , TypInfo
 , msmModelElement
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *58095A5103B5impl_uses*
 //#UC END# *58095A5103B5impl_uses*
;

type
 TkwPopMsmModelElementListAdd = {final} class(TtfwClassLike)
  {* Слово скрипта pop:msmModelElementList:Add }
  private
   procedure Add(const aCtx: TtfwContext;
    const amsmModelElementList: ImsmModelElementList;
    anItem: TtfwWord);
    {* Реализация слова скрипта pop:msmModelElementList:Add }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopMsmModelElementListAdd

 TkwMsmModelElementListMake = {final} class(TtfwClassLike)
  {* Слово скрипта msmModelElementList:Make }
  private
   function Make(const aCtx: TtfwContext;
    aWord: TtfwWord;
    const aName: AnsiString): ImsmModelElementList;
    {* Реализация слова скрипта msmModelElementList:Make }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsmModelElementListMake

procedure TkwPopMsmModelElementListAdd.Add(const aCtx: TtfwContext;
 const amsmModelElementList: ImsmModelElementList;
 anItem: TtfwWord);
 {* Реализация слова скрипта pop:msmModelElementList:Add }
//#UC START# *58095A9B0031_58095A9B0031_57AAD83D0151_Word_var*
//#UC END# *58095A9B0031_58095A9B0031_57AAD83D0151_Word_var*
begin
//#UC START# *58095A9B0031_58095A9B0031_57AAD83D0151_Word_impl*
 amsmModelElementList.Add(anItem);
//#UC END# *58095A9B0031_58095A9B0031_57AAD83D0151_Word_impl*
end;//TkwPopMsmModelElementListAdd.Add

class function TkwPopMsmModelElementListAdd.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:msmModelElementList:Add';
end;//TkwPopMsmModelElementListAdd.GetWordNameForRegister

function TkwPopMsmModelElementListAdd.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopMsmModelElementListAdd.GetResultTypeInfo

function TkwPopMsmModelElementListAdd.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopMsmModelElementListAdd.GetAllParamsCount

function TkwPopMsmModelElementListAdd.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ImsmModelElementList), TypeInfo(TtfwWord)]);
end;//TkwPopMsmModelElementListAdd.ParamsTypes

procedure TkwPopMsmModelElementListAdd.DoDoIt(const aCtx: TtfwContext);
var l_amsmModelElementList: ImsmModelElementList;
var l_anItem: TtfwWord;
begin
 try
  l_amsmModelElementList := ImsmModelElementList(aCtx.rEngine.PopIntf(ImsmModelElementList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра amsmModelElementList: ImsmModelElementList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anItem := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anItem: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Add(aCtx, l_amsmModelElementList, l_anItem);
end;//TkwPopMsmModelElementListAdd.DoDoIt

function TkwMsmModelElementListMake.Make(const aCtx: TtfwContext;
 aWord: TtfwWord;
 const aName: AnsiString): ImsmModelElementList;
 {* Реализация слова скрипта msmModelElementList:Make }
//#UC START# *580962690025_580962690025_57AAD83D0151_Word_var*
//#UC END# *580962690025_580962690025_57AAD83D0151_Word_var*
begin
//#UC START# *580962690025_580962690025_57AAD83D0151_Word_impl*
 Result := TmsmModelElement.MakeFromWord(aWord).MEList[aName];
//#UC END# *580962690025_580962690025_57AAD83D0151_Word_impl*
end;//TkwMsmModelElementListMake.Make

class function TkwMsmModelElementListMake.GetWordNameForRegister: AnsiString;
begin
 Result := 'msmModelElementList:Make';
end;//TkwMsmModelElementListMake.GetWordNameForRegister

function TkwMsmModelElementListMake.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ImsmModelElementList);
end;//TkwMsmModelElementListMake.GetResultTypeInfo

function TkwMsmModelElementListMake.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwMsmModelElementListMake.GetAllParamsCount

function TkwMsmModelElementListMake.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ImsmModelElementList), TypeInfo(TtfwWord), @tfw_tiString]);
end;//TkwMsmModelElementListMake.ParamsTypes

procedure TkwMsmModelElementListMake.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
var l_aName: AnsiString;
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
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(Make(aCtx, l_aWord, l_aName), TypeInfo(ImsmModelElementList));
end;//TkwMsmModelElementListMake.DoDoIt

initialization
 TkwPopMsmModelElementListAdd.RegisterInEngine;
 {* Регистрация pop_msmModelElementList_Add }
 TkwMsmModelElementListMake.RegisterInEngine;
 {* Регистрация msmModelElementList_Make }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ImsmModelElementList));
 {* Регистрация типа ImsmModelElementList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
{$IfEnd} // NOT Defined(NoScripts)

end.
