unit ListInfoKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы ListInfo }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\ListInfoKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ListInfoKeywordsPack" MUID: (4A9BF56C0166_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , ListInfo_Form
 , tfwPropertyLike
 {$If Defined(Nemesis)}
 , nscEditor
 {$IfEnd} // Defined(Nemesis)
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 {$If Defined(Nemesis)}
 , nscTextSource
 {$IfEnd} // Defined(Nemesis)
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4A9BF56C0166_Packimpl_uses*
 //#UC END# *4A9BF56C0166_Packimpl_uses*
;

type
 TkwEfListInfoListInfoViewer = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefListInfo.ListInfoViewer }
  private
   function ListInfoViewer(const aCtx: TtfwContext;
    aefListInfo: TefListInfo): TnscEditor;
    {* Реализация слова скрипта .TefListInfo.ListInfoViewer }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfListInfoListInfoViewer

 TkwEfListInfoTextSource = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefListInfo.TextSource }
  private
   function TextSource(const aCtx: TtfwContext;
    aefListInfo: TefListInfo): TnscTextSource;
    {* Реализация слова скрипта .TefListInfo.TextSource }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfListInfoTextSource

 Tkw_Form_ListInfo = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы ListInfo
----
*Пример использования*:
[code]форма::ListInfo TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_ListInfo

 Tkw_ListInfo_Control_ListInfoViewer = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ListInfoViewer
----
*Пример использования*:
[code]контрол::ListInfoViewer TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ListInfo_Control_ListInfoViewer

 Tkw_ListInfo_Control_ListInfoViewer_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ListInfoViewer
----
*Пример использования*:
[code]контрол::ListInfoViewer:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ListInfo_Control_ListInfoViewer_Push

 Tkw_ListInfo_Component_TextSource = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TextSource
----
*Пример использования*:
[code]компонент::TextSource TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ListInfo_Component_TextSource

function TkwEfListInfoListInfoViewer.ListInfoViewer(const aCtx: TtfwContext;
 aefListInfo: TefListInfo): TnscEditor;
 {* Реализация слова скрипта .TefListInfo.ListInfoViewer }
begin
 Result := aefListInfo.ListInfoViewer;
end;//TkwEfListInfoListInfoViewer.ListInfoViewer

class function TkwEfListInfoListInfoViewer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefListInfo.ListInfoViewer';
end;//TkwEfListInfoListInfoViewer.GetWordNameForRegister

function TkwEfListInfoListInfoViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEditor);
end;//TkwEfListInfoListInfoViewer.GetResultTypeInfo

function TkwEfListInfoListInfoViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfListInfoListInfoViewer.GetAllParamsCount

function TkwEfListInfoListInfoViewer.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefListInfo)]);
end;//TkwEfListInfoListInfoViewer.ParamsTypes

procedure TkwEfListInfoListInfoViewer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ListInfoViewer', aCtx);
end;//TkwEfListInfoListInfoViewer.SetValuePrim

procedure TkwEfListInfoListInfoViewer.DoDoIt(const aCtx: TtfwContext);
var l_aefListInfo: TefListInfo;
begin
 try
  l_aefListInfo := TefListInfo(aCtx.rEngine.PopObjAs(TefListInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefListInfo: TefListInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ListInfoViewer(aCtx, l_aefListInfo));
end;//TkwEfListInfoListInfoViewer.DoDoIt

function TkwEfListInfoTextSource.TextSource(const aCtx: TtfwContext;
 aefListInfo: TefListInfo): TnscTextSource;
 {* Реализация слова скрипта .TefListInfo.TextSource }
begin
 Result := aefListInfo.TextSource;
end;//TkwEfListInfoTextSource.TextSource

class function TkwEfListInfoTextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefListInfo.TextSource';
end;//TkwEfListInfoTextSource.GetWordNameForRegister

function TkwEfListInfoTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTextSource);
end;//TkwEfListInfoTextSource.GetResultTypeInfo

function TkwEfListInfoTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfListInfoTextSource.GetAllParamsCount

function TkwEfListInfoTextSource.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefListInfo)]);
end;//TkwEfListInfoTextSource.ParamsTypes

procedure TkwEfListInfoTextSource.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству TextSource', aCtx);
end;//TkwEfListInfoTextSource.SetValuePrim

procedure TkwEfListInfoTextSource.DoDoIt(const aCtx: TtfwContext);
var l_aefListInfo: TefListInfo;
begin
 try
  l_aefListInfo := TefListInfo(aCtx.rEngine.PopObjAs(TefListInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefListInfo: TefListInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TextSource(aCtx, l_aefListInfo));
end;//TkwEfListInfoTextSource.DoDoIt

function Tkw_Form_ListInfo.GetString: AnsiString;
begin
 Result := 'efListInfo';
end;//Tkw_Form_ListInfo.GetString

class procedure Tkw_Form_ListInfo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TefListInfo);
end;//Tkw_Form_ListInfo.RegisterInEngine

class function Tkw_Form_ListInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::ListInfo';
end;//Tkw_Form_ListInfo.GetWordNameForRegister

function Tkw_ListInfo_Control_ListInfoViewer.GetString: AnsiString;
begin
 Result := 'ListInfoViewer';
end;//Tkw_ListInfo_Control_ListInfoViewer.GetString

class procedure Tkw_ListInfo_Control_ListInfoViewer.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_ListInfo_Control_ListInfoViewer.RegisterInEngine

class function Tkw_ListInfo_Control_ListInfoViewer.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ListInfoViewer';
end;//Tkw_ListInfo_Control_ListInfoViewer.GetWordNameForRegister

procedure Tkw_ListInfo_Control_ListInfoViewer_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ListInfoViewer');
 inherited;
end;//Tkw_ListInfo_Control_ListInfoViewer_Push.DoDoIt

class function Tkw_ListInfo_Control_ListInfoViewer_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ListInfoViewer:push';
end;//Tkw_ListInfo_Control_ListInfoViewer_Push.GetWordNameForRegister

function Tkw_ListInfo_Component_TextSource.GetString: AnsiString;
begin
 Result := 'TextSource';
end;//Tkw_ListInfo_Component_TextSource.GetString

class procedure Tkw_ListInfo_Component_TextSource.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTextSource);
end;//Tkw_ListInfo_Component_TextSource.RegisterInEngine

class function Tkw_ListInfo_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::TextSource';
end;//Tkw_ListInfo_Component_TextSource.GetWordNameForRegister

initialization
 TkwEfListInfoListInfoViewer.RegisterInEngine;
 {* Регистрация efListInfo_ListInfoViewer }
 TkwEfListInfoTextSource.RegisterInEngine;
 {* Регистрация efListInfo_TextSource }
 Tkw_Form_ListInfo.RegisterInEngine;
 {* Регистрация Tkw_Form_ListInfo }
 Tkw_ListInfo_Control_ListInfoViewer.RegisterInEngine;
 {* Регистрация Tkw_ListInfo_Control_ListInfoViewer }
 Tkw_ListInfo_Control_ListInfoViewer_Push.RegisterInEngine;
 {* Регистрация Tkw_ListInfo_Control_ListInfoViewer_Push }
 Tkw_ListInfo_Component_TextSource.RegisterInEngine;
 {* Регистрация Tkw_ListInfo_Component_TextSource }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefListInfo));
 {* Регистрация типа TefListInfo }
{$If Defined(Nemesis)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* Регистрация типа TnscEditor }
{$IfEnd} // Defined(Nemesis)
{$If Defined(Nemesis)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTextSource));
 {* Регистрация типа TnscTextSource }
{$IfEnd} // Defined(Nemesis)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
