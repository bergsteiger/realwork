unit ListInfoKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы ListInfo }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\ListInfoKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , List_Module
 {$If Defined(Nemesis)}
 , nscEditor
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTextSource
 {$IfEnd} // Defined(Nemesis)
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_ListInfo = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы ListInfo
----
*Пример использования*:
[code]
'aControl' форма::ListInfo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_ListInfo

 Tkw_ListInfo_Control_ListInfoViewer = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ListInfoViewer
----
*Пример использования*:
[code]
контрол::ListInfoViewer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ListInfo_Control_ListInfoViewer

 Tkw_ListInfo_Control_ListInfoViewer_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ListInfoViewer
----
*Пример использования*:
[code]
контрол::ListInfoViewer:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ListInfo_Control_ListInfoViewer_Push

 Tkw_ListInfo_Component_TextSource = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TextSource
----
*Пример использования*:
[code]
компонент::TextSource TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ListInfo_Component_TextSource

 TkwEfListInfoListInfoViewer = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefListInfo.ListInfoViewer
[panel]Контрол ListInfoViewer формы TefListInfo[panel]
*Тип результата:* TnscEditor
*Пример:*
[code]
OBJECT VAR l_TnscEditor
 aefListInfo .TefListInfo.ListInfoViewer >>> l_TnscEditor
[code]  }
  private
   function ListInfoViewer(const aCtx: TtfwContext;
    aefListInfo: TefListInfo): TnscEditor;
    {* Реализация слова скрипта .TefListInfo.ListInfoViewer }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfListInfoListInfoViewer

 TkwEfListInfoTextSource = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefListInfo.TextSource
[panel]Контрол TextSource формы TefListInfo[panel]
*Тип результата:* TnscTextSource
*Пример:*
[code]
OBJECT VAR l_TnscTextSource
 aefListInfo .TefListInfo.TextSource >>> l_TnscTextSource
[code]  }
  private
   function TextSource(const aCtx: TtfwContext;
    aefListInfo: TefListInfo): TnscTextSource;
    {* Реализация слова скрипта .TefListInfo.TextSource }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfListInfoTextSource

class function Tkw_Form_ListInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::ListInfo';
end;//Tkw_Form_ListInfo.GetWordNameForRegister

function Tkw_Form_ListInfo.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8B54C59B0DC1_var*
//#UC END# *4DDFD2EA0116_8B54C59B0DC1_var*
begin
//#UC START# *4DDFD2EA0116_8B54C59B0DC1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8B54C59B0DC1_impl*
end;//Tkw_Form_ListInfo.GetString

class function Tkw_ListInfo_Control_ListInfoViewer.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ListInfoViewer';
end;//Tkw_ListInfo_Control_ListInfoViewer.GetWordNameForRegister

function Tkw_ListInfo_Control_ListInfoViewer.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AF0DF54C9A79_var*
//#UC END# *4DDFD2EA0116_AF0DF54C9A79_var*
begin
//#UC START# *4DDFD2EA0116_AF0DF54C9A79_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AF0DF54C9A79_impl*
end;//Tkw_ListInfo_Control_ListInfoViewer.GetString

class procedure Tkw_ListInfo_Control_ListInfoViewer.RegisterInEngine;
//#UC START# *52A086150180_AF0DF54C9A79_var*
//#UC END# *52A086150180_AF0DF54C9A79_var*
begin
//#UC START# *52A086150180_AF0DF54C9A79_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_AF0DF54C9A79_impl*
end;//Tkw_ListInfo_Control_ListInfoViewer.RegisterInEngine

procedure Tkw_ListInfo_Control_ListInfoViewer_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_79DCA22F52FF_var*
//#UC END# *4DAEEDE10285_79DCA22F52FF_var*
begin
//#UC START# *4DAEEDE10285_79DCA22F52FF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_79DCA22F52FF_impl*
end;//Tkw_ListInfo_Control_ListInfoViewer_Push.DoDoIt

class function Tkw_ListInfo_Control_ListInfoViewer_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ListInfoViewer:push';
end;//Tkw_ListInfo_Control_ListInfoViewer_Push.GetWordNameForRegister

class function Tkw_ListInfo_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::TextSource';
end;//Tkw_ListInfo_Component_TextSource.GetWordNameForRegister

function Tkw_ListInfo_Component_TextSource.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_EC6F65E42CD5_var*
//#UC END# *4DDFD2EA0116_EC6F65E42CD5_var*
begin
//#UC START# *4DDFD2EA0116_EC6F65E42CD5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_EC6F65E42CD5_impl*
end;//Tkw_ListInfo_Component_TextSource.GetString

class procedure Tkw_ListInfo_Component_TextSource.RegisterInEngine;
//#UC START# *52A086150180_EC6F65E42CD5_var*
//#UC END# *52A086150180_EC6F65E42CD5_var*
begin
//#UC START# *52A086150180_EC6F65E42CD5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_EC6F65E42CD5_impl*
end;//Tkw_ListInfo_Component_TextSource.RegisterInEngine

function TkwEfListInfoListInfoViewer.ListInfoViewer(const aCtx: TtfwContext;
 aefListInfo: TefListInfo): TnscEditor;
 {* Реализация слова скрипта .TefListInfo.ListInfoViewer }
//#UC START# *2331C87FA947_6C1002171F6A_var*
//#UC END# *2331C87FA947_6C1002171F6A_var*
begin
//#UC START# *2331C87FA947_6C1002171F6A_impl*
 !!! Needs to be implemented !!!
//#UC END# *2331C87FA947_6C1002171F6A_impl*
end;//TkwEfListInfoListInfoViewer.ListInfoViewer

procedure TkwEfListInfoListInfoViewer.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6C1002171F6A_var*
//#UC END# *4DAEEDE10285_6C1002171F6A_var*
begin
//#UC START# *4DAEEDE10285_6C1002171F6A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6C1002171F6A_impl*
end;//TkwEfListInfoListInfoViewer.DoDoIt

class function TkwEfListInfoListInfoViewer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefListInfo.ListInfoViewer';
end;//TkwEfListInfoListInfoViewer.GetWordNameForRegister

procedure TkwEfListInfoListInfoViewer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEfListInfoListInfoViewer.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwEfListInfoListInfoViewer.ParamsTypes

function TkwEfListInfoTextSource.TextSource(const aCtx: TtfwContext;
 aefListInfo: TefListInfo): TnscTextSource;
 {* Реализация слова скрипта .TefListInfo.TextSource }
//#UC START# *4BEE9B3C05FA_288FE0C200C7_var*
//#UC END# *4BEE9B3C05FA_288FE0C200C7_var*
begin
//#UC START# *4BEE9B3C05FA_288FE0C200C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BEE9B3C05FA_288FE0C200C7_impl*
end;//TkwEfListInfoTextSource.TextSource

procedure TkwEfListInfoTextSource.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_288FE0C200C7_var*
//#UC END# *4DAEEDE10285_288FE0C200C7_var*
begin
//#UC START# *4DAEEDE10285_288FE0C200C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_288FE0C200C7_impl*
end;//TkwEfListInfoTextSource.DoDoIt

class function TkwEfListInfoTextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefListInfo.TextSource';
end;//TkwEfListInfoTextSource.GetWordNameForRegister

procedure TkwEfListInfoTextSource.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEfListInfoTextSource.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwEfListInfoTextSource.ParamsTypes

initialization
 Tkw_Form_ListInfo.RegisterInEngine;
 {* Регистрация Tkw_Form_ListInfo }
 Tkw_ListInfo_Control_ListInfoViewer.RegisterInEngine;
 {* Регистрация Tkw_ListInfo_Control_ListInfoViewer }
 Tkw_ListInfo_Control_ListInfoViewer_Push.RegisterInEngine;
 {* Регистрация Tkw_ListInfo_Control_ListInfoViewer_Push }
 Tkw_ListInfo_Component_TextSource.RegisterInEngine;
 {* Регистрация Tkw_ListInfo_Component_TextSource }
 TkwEfListInfoListInfoViewer.RegisterInEngine;
 {* Регистрация efListInfo_ListInfoViewer }
 TkwEfListInfoTextSource.RegisterInEngine;
 {* Регистрация efListInfo_TextSource }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefListInfo));
 {* Регистрация типа ListInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* Регистрация типа TnscEditor }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTextSource));
 {* Регистрация типа TnscTextSource }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
