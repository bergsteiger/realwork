unit ListInfoKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/List/ListInfoKeywordsPack.pas"
// Начат: 31.08.2009 20:51
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Работа с документом и списком документов::WorkWithList::View::List::List$FP::ListInfoKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы ListInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(Nemesis)}
  ,
  nscEditor
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTextSource
  {$IfEnd} //Nemesis
  ,
  ListInfo_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_ListInfo = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы ListInfo
----
*Пример использования*:
[code]
'aControl' форма::ListInfo TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_ListInfo

// start class Tkw_Form_ListInfo

class function Tkw_Form_ListInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::ListInfo';
end;//Tkw_Form_ListInfo.GetWordNameForRegister

function Tkw_Form_ListInfo.GetString: AnsiString;
 {-}
begin
 Result := 'efListInfo';
end;//Tkw_Form_ListInfo.GetString

type
  Tkw_ListInfo_Control_ListInfoViewer = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола ListInfoViewer
----
*Пример использования*:
[code]
контрол::ListInfoViewer TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ListInfo_Control_ListInfoViewer

// start class Tkw_ListInfo_Control_ListInfoViewer

class function Tkw_ListInfo_Control_ListInfoViewer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ListInfoViewer';
end;//Tkw_ListInfo_Control_ListInfoViewer.GetWordNameForRegister

function Tkw_ListInfo_Control_ListInfoViewer.GetString: AnsiString;
 {-}
begin
 Result := 'ListInfoViewer';
end;//Tkw_ListInfo_Control_ListInfoViewer.GetString

class procedure Tkw_ListInfo_Control_ListInfoViewer.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_ListInfo_Control_ListInfoViewer.RegisterInEngine

type
  Tkw_ListInfo_Control_ListInfoViewer_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола ListInfoViewer
----
*Пример использования*:
[code]
контрол::ListInfoViewer:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ListInfo_Control_ListInfoViewer_Push

// start class Tkw_ListInfo_Control_ListInfoViewer_Push

procedure Tkw_ListInfo_Control_ListInfoViewer_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ListInfoViewer');
 inherited;
end;//Tkw_ListInfo_Control_ListInfoViewer_Push.DoDoIt

class function Tkw_ListInfo_Control_ListInfoViewer_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ListInfoViewer:push';
end;//Tkw_ListInfo_Control_ListInfoViewer_Push.GetWordNameForRegister

type
  Tkw_ListInfo_Component_TextSource = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола TextSource
----
*Пример использования*:
[code]
компонент::TextSource TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ListInfo_Component_TextSource

// start class Tkw_ListInfo_Component_TextSource

class function Tkw_ListInfo_Component_TextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'компонент::TextSource';
end;//Tkw_ListInfo_Component_TextSource.GetWordNameForRegister

function Tkw_ListInfo_Component_TextSource.GetString: AnsiString;
 {-}
begin
 Result := 'TextSource';
end;//Tkw_ListInfo_Component_TextSource.GetString

class procedure Tkw_ListInfo_Component_TextSource.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTextSource);
end;//Tkw_ListInfo_Component_TextSource.RegisterInEngine

type
  TkwEfListInfoListInfoViewer = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefListInfo.ListInfoViewer
[panel]Контрол ListInfoViewer формы TefListInfo[panel]
*Тип результата:* TnscEditor
*Пример:*
[code]
OBJECT VAR l_TnscEditor
 aefListInfo .TefListInfo.ListInfoViewer >>> l_TnscEditor
[code]  }
  private
  // private methods
   function ListInfoViewer(const aCtx: TtfwContext;
     aefListInfo: TefListInfo): TnscEditor;
     {* Реализация слова скрипта .TefListInfo.ListInfoViewer }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfListInfoListInfoViewer

// start class TkwEfListInfoListInfoViewer

function TkwEfListInfoListInfoViewer.ListInfoViewer(const aCtx: TtfwContext;
  aefListInfo: TefListInfo): TnscEditor;
 {-}
begin
 Result := aefListInfo.ListInfoViewer;
end;//TkwEfListInfoListInfoViewer.ListInfoViewer

procedure TkwEfListInfoListInfoViewer.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefListInfo : TefListInfo;
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
 aCtx.rEngine.PushObj((ListInfoViewer(aCtx, l_aefListInfo)));
end;//TkwEfListInfoListInfoViewer.DoDoIt

class function TkwEfListInfoListInfoViewer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefListInfo.ListInfoViewer';
end;//TkwEfListInfoListInfoViewer.GetWordNameForRegister

procedure TkwEfListInfoListInfoViewer.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ListInfoViewer', aCtx);
end;//TkwEfListInfoListInfoViewer.SetValuePrim

function TkwEfListInfoListInfoViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEditor);
end;//TkwEfListInfoListInfoViewer.GetResultTypeInfo

function TkwEfListInfoListInfoViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfListInfoListInfoViewer.GetAllParamsCount

function TkwEfListInfoListInfoViewer.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefListInfo)]);
end;//TkwEfListInfoListInfoViewer.ParamsTypes

type
  TkwEfListInfoTextSource = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefListInfo.TextSource
[panel]Контрол TextSource формы TefListInfo[panel]
*Тип результата:* TnscTextSource
*Пример:*
[code]
OBJECT VAR l_TnscTextSource
 aefListInfo .TefListInfo.TextSource >>> l_TnscTextSource
[code]  }
  private
  // private methods
   function TextSource(const aCtx: TtfwContext;
     aefListInfo: TefListInfo): TnscTextSource;
     {* Реализация слова скрипта .TefListInfo.TextSource }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfListInfoTextSource

// start class TkwEfListInfoTextSource

function TkwEfListInfoTextSource.TextSource(const aCtx: TtfwContext;
  aefListInfo: TefListInfo): TnscTextSource;
 {-}
begin
 Result := aefListInfo.TextSource;
end;//TkwEfListInfoTextSource.TextSource

procedure TkwEfListInfoTextSource.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefListInfo : TefListInfo;
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
 aCtx.rEngine.PushObj((TextSource(aCtx, l_aefListInfo)));
end;//TkwEfListInfoTextSource.DoDoIt

class function TkwEfListInfoTextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefListInfo.TextSource';
end;//TkwEfListInfoTextSource.GetWordNameForRegister

procedure TkwEfListInfoTextSource.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству TextSource', aCtx);
end;//TkwEfListInfoTextSource.SetValuePrim

function TkwEfListInfoTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTextSource);
end;//TkwEfListInfoTextSource.GetResultTypeInfo

function TkwEfListInfoTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfListInfoTextSource.GetAllParamsCount

function TkwEfListInfoTextSource.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefListInfo)]);
end;//TkwEfListInfoTextSource.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_ListInfo
 Tkw_Form_ListInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ListInfo_Control_ListInfoViewer
 Tkw_ListInfo_Control_ListInfoViewer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ListInfo_Control_ListInfoViewer_Push
 Tkw_ListInfo_Control_ListInfoViewer_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ListInfo_Component_TextSource
 Tkw_ListInfo_Component_TextSource.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efListInfo_ListInfoViewer
 TkwEfListInfoListInfoViewer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efListInfo_TextSource
 TkwEfListInfoTextSource.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа ListInfo
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefListInfo));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscEditor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscTextSource
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTextSource));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.