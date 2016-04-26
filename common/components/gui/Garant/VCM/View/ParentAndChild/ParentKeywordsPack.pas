unit ParentKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Parent }

// Модуль: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\ParentKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ParentKeywordsPack" MUID: (A7368FD6A294)

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtPanel
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Parent_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
;

type
 Tkw_Form_Parent = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Parent
----
*Пример использования*:
[code]
'aControl' форма::Parent TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Parent

 Tkw_Parent_Control_ParentZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ParentZone
----
*Пример использования*:
[code]
контрол::ParentZone TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Parent_Control_ParentZone

 Tkw_Parent_Control_ParentZone_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола ParentZone
----
*Пример использования*:
[code]
контрол::ParentZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Parent_Control_ParentZone_Push

 TkwParentFormParentZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TParentForm.ParentZone
[panel]Контрол ParentZone формы TParentForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aParentForm .TParentForm.ParentZone >>> l_TvtPanel
[code]  }
  private
   function ParentZone(const aCtx: TtfwContext;
    aParentForm: TParentForm): TvtPanel;
    {* Реализация слова скрипта .TParentForm.ParentZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParentFormParentZone

function Tkw_Form_Parent.GetString: AnsiString;
begin
 Result := 'ParentForm';
end;//Tkw_Form_Parent.GetString

class function Tkw_Form_Parent.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Parent';
end;//Tkw_Form_Parent.GetWordNameForRegister

function Tkw_Parent_Control_ParentZone.GetString: AnsiString;
begin
 Result := 'ParentZone';
end;//Tkw_Parent_Control_ParentZone.GetString

class procedure Tkw_Parent_Control_ParentZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Parent_Control_ParentZone.RegisterInEngine

class function Tkw_Parent_Control_ParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZone';
end;//Tkw_Parent_Control_ParentZone.GetWordNameForRegister

procedure Tkw_Parent_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ParentZone');
 inherited;
end;//Tkw_Parent_Control_ParentZone_Push.DoDoIt

class function Tkw_Parent_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZone:push';
end;//Tkw_Parent_Control_ParentZone_Push.GetWordNameForRegister

function TkwParentFormParentZone.ParentZone(const aCtx: TtfwContext;
 aParentForm: TParentForm): TvtPanel;
 {* Реализация слова скрипта .TParentForm.ParentZone }
begin
 Result := aParentForm.ParentZone;
end;//TkwParentFormParentZone.ParentZone

procedure TkwParentFormParentZone.DoDoIt(const aCtx: TtfwContext);
var l_aParentForm: TParentForm;
begin
 try
  l_aParentForm := TParentForm(aCtx.rEngine.PopObjAs(TParentForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aParentForm: TParentForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ParentZone(aCtx, l_aParentForm));
end;//TkwParentFormParentZone.DoDoIt

procedure TkwParentFormParentZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ParentZone', aCtx);
end;//TkwParentFormParentZone.SetValuePrim

function TkwParentFormParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwParentFormParentZone.GetResultTypeInfo

function TkwParentFormParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwParentFormParentZone.GetAllParamsCount

function TkwParentFormParentZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TParentForm)]);
end;//TkwParentFormParentZone.ParamsTypes

class function TkwParentFormParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TParentForm.ParentZone';
end;//TkwParentFormParentZone.GetWordNameForRegister

initialization
 Tkw_Form_Parent.RegisterInEngine;
 {* Регистрация Tkw_Form_Parent }
 Tkw_Parent_Control_ParentZone.RegisterInEngine;
 {* Регистрация Tkw_Parent_Control_ParentZone }
 Tkw_Parent_Control_ParentZone_Push.RegisterInEngine;
 {* Регистрация Tkw_Parent_Control_ParentZone_Push }
 TkwParentFormParentZone.RegisterInEngine;
 {* Регистрация ParentForm_ParentZone }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TParentForm));
 {* Регистрация типа Parent }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
