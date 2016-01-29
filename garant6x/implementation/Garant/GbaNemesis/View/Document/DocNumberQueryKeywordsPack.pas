unit DocNumberQueryKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/DocNumberQueryKeywordsPack.pas"
// Начат: 05.02.2009 19:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Работа с документом и списком документов::Document::View::Document::Document::DocNumberQueryKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы DocNumberQuery
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
  DocNumberQuery_Form
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtLabel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  vtCheckBox,
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
  Tkw_Form_DocNumberQuery = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы DocNumberQuery
----
*Пример использования*:
[code]
'aControl' форма::DocNumberQuery TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_DocNumberQuery

// start class Tkw_Form_DocNumberQuery

class function Tkw_Form_DocNumberQuery.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::DocNumberQuery';
end;//Tkw_Form_DocNumberQuery.GetWordNameForRegister

function Tkw_Form_DocNumberQuery.GetString: AnsiString;
 {-}
begin
 Result := 'DocNumberQueryForm';
end;//Tkw_Form_DocNumberQuery.GetString

type
  Tkw_DocNumberQuery_Control_Label1 = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола Label1
----
*Пример использования*:
[code]
контрол::Label1 TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_DocNumberQuery_Control_Label1

// start class Tkw_DocNumberQuery_Control_Label1

class function Tkw_DocNumberQuery_Control_Label1.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Label1';
end;//Tkw_DocNumberQuery_Control_Label1.GetWordNameForRegister

function Tkw_DocNumberQuery_Control_Label1.GetString: AnsiString;
 {-}
begin
 Result := 'Label1';
end;//Tkw_DocNumberQuery_Control_Label1.GetString

class procedure Tkw_DocNumberQuery_Control_Label1.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_DocNumberQuery_Control_Label1.RegisterInEngine

type
  Tkw_DocNumberQuery_Control_Label1_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола Label1
----
*Пример использования*:
[code]
контрол::Label1:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_DocNumberQuery_Control_Label1_Push

// start class Tkw_DocNumberQuery_Control_Label1_Push

procedure Tkw_DocNumberQuery_Control_Label1_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Label1');
 inherited;
end;//Tkw_DocNumberQuery_Control_Label1_Push.DoDoIt

class function Tkw_DocNumberQuery_Control_Label1_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Label1:push';
end;//Tkw_DocNumberQuery_Control_Label1_Push.GetWordNameForRegister

type
  Tkw_DocNumberQuery_Control_edNumber = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола edNumber
----
*Пример использования*:
[code]
контрол::edNumber TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_DocNumberQuery_Control_edNumber

// start class Tkw_DocNumberQuery_Control_edNumber

class function Tkw_DocNumberQuery_Control_edNumber.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edNumber';
end;//Tkw_DocNumberQuery_Control_edNumber.GetWordNameForRegister

function Tkw_DocNumberQuery_Control_edNumber.GetString: AnsiString;
 {-}
begin
 Result := 'edNumber';
end;//Tkw_DocNumberQuery_Control_edNumber.GetString

class procedure Tkw_DocNumberQuery_Control_edNumber.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscComboBox);
end;//Tkw_DocNumberQuery_Control_edNumber.RegisterInEngine

type
  Tkw_DocNumberQuery_Control_edNumber_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола edNumber
----
*Пример использования*:
[code]
контрол::edNumber:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_DocNumberQuery_Control_edNumber_Push

// start class Tkw_DocNumberQuery_Control_edNumber_Push

procedure Tkw_DocNumberQuery_Control_edNumber_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edNumber');
 inherited;
end;//Tkw_DocNumberQuery_Control_edNumber_Push.DoDoIt

class function Tkw_DocNumberQuery_Control_edNumber_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edNumber:push';
end;//Tkw_DocNumberQuery_Control_edNumber_Push.GetWordNameForRegister

type
  Tkw_DocNumberQuery_Control_cbInternal = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола cbInternal
----
*Пример использования*:
[code]
контрол::cbInternal TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_DocNumberQuery_Control_cbInternal

// start class Tkw_DocNumberQuery_Control_cbInternal

class function Tkw_DocNumberQuery_Control_cbInternal.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::cbInternal';
end;//Tkw_DocNumberQuery_Control_cbInternal.GetWordNameForRegister

function Tkw_DocNumberQuery_Control_cbInternal.GetString: AnsiString;
 {-}
begin
 Result := 'cbInternal';
end;//Tkw_DocNumberQuery_Control_cbInternal.GetString

class procedure Tkw_DocNumberQuery_Control_cbInternal.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_DocNumberQuery_Control_cbInternal.RegisterInEngine

type
  Tkw_DocNumberQuery_Control_cbInternal_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола cbInternal
----
*Пример использования*:
[code]
контрол::cbInternal:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_DocNumberQuery_Control_cbInternal_Push

// start class Tkw_DocNumberQuery_Control_cbInternal_Push

procedure Tkw_DocNumberQuery_Control_cbInternal_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('cbInternal');
 inherited;
end;//Tkw_DocNumberQuery_Control_cbInternal_Push.DoDoIt

class function Tkw_DocNumberQuery_Control_cbInternal_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::cbInternal:push';
end;//Tkw_DocNumberQuery_Control_cbInternal_Push.GetWordNameForRegister

type
  TkwDocNumberQueryFormLabel1 = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TDocNumberQueryForm.Label1
[panel]Контрол Label1 формы TDocNumberQueryForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aDocNumberQueryForm .TDocNumberQueryForm.Label1 >>> l_TvtLabel
[code]  }
  private
  // private methods
   function Label1(const aCtx: TtfwContext;
     aDocNumberQueryForm: TDocNumberQueryForm): TvtLabel;
     {* Реализация слова скрипта .TDocNumberQueryForm.Label1 }
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
  end;//TkwDocNumberQueryFormLabel1

// start class TkwDocNumberQueryFormLabel1

function TkwDocNumberQueryFormLabel1.Label1(const aCtx: TtfwContext;
  aDocNumberQueryForm: TDocNumberQueryForm): TvtLabel;
 {-}
begin
 Result := aDocNumberQueryForm.Label1;
end;//TkwDocNumberQueryFormLabel1.Label1

procedure TkwDocNumberQueryFormLabel1.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDocNumberQueryForm : TDocNumberQueryForm;
begin
 try
  l_aDocNumberQueryForm := TDocNumberQueryForm(aCtx.rEngine.PopObjAs(TDocNumberQueryForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDocNumberQueryForm: TDocNumberQueryForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Label1(aCtx, l_aDocNumberQueryForm)));
end;//TkwDocNumberQueryFormLabel1.DoDoIt

class function TkwDocNumberQueryFormLabel1.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TDocNumberQueryForm.Label1';
end;//TkwDocNumberQueryFormLabel1.GetWordNameForRegister

procedure TkwDocNumberQueryFormLabel1.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Label1', aCtx);
end;//TkwDocNumberQueryFormLabel1.SetValuePrim

function TkwDocNumberQueryFormLabel1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwDocNumberQueryFormLabel1.GetResultTypeInfo

function TkwDocNumberQueryFormLabel1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwDocNumberQueryFormLabel1.GetAllParamsCount

function TkwDocNumberQueryFormLabel1.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TDocNumberQueryForm)]);
end;//TkwDocNumberQueryFormLabel1.ParamsTypes

type
  TkwDocNumberQueryFormEdNumber = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TDocNumberQueryForm.edNumber
[panel]Контрол edNumber формы TDocNumberQueryForm[panel]
*Тип результата:* TnscComboBox
*Пример:*
[code]
OBJECT VAR l_TnscComboBox
 aDocNumberQueryForm .TDocNumberQueryForm.edNumber >>> l_TnscComboBox
[code]  }
  private
  // private methods
   function EdNumber(const aCtx: TtfwContext;
     aDocNumberQueryForm: TDocNumberQueryForm): TnscComboBox;
     {* Реализация слова скрипта .TDocNumberQueryForm.edNumber }
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
  end;//TkwDocNumberQueryFormEdNumber

// start class TkwDocNumberQueryFormEdNumber

function TkwDocNumberQueryFormEdNumber.EdNumber(const aCtx: TtfwContext;
  aDocNumberQueryForm: TDocNumberQueryForm): TnscComboBox;
 {-}
begin
 Result := aDocNumberQueryForm.edNumber;
end;//TkwDocNumberQueryFormEdNumber.EdNumber

procedure TkwDocNumberQueryFormEdNumber.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDocNumberQueryForm : TDocNumberQueryForm;
begin
 try
  l_aDocNumberQueryForm := TDocNumberQueryForm(aCtx.rEngine.PopObjAs(TDocNumberQueryForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDocNumberQueryForm: TDocNumberQueryForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdNumber(aCtx, l_aDocNumberQueryForm)));
end;//TkwDocNumberQueryFormEdNumber.DoDoIt

class function TkwDocNumberQueryFormEdNumber.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TDocNumberQueryForm.edNumber';
end;//TkwDocNumberQueryFormEdNumber.GetWordNameForRegister

procedure TkwDocNumberQueryFormEdNumber.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству edNumber', aCtx);
end;//TkwDocNumberQueryFormEdNumber.SetValuePrim

function TkwDocNumberQueryFormEdNumber.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscComboBox);
end;//TkwDocNumberQueryFormEdNumber.GetResultTypeInfo

function TkwDocNumberQueryFormEdNumber.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwDocNumberQueryFormEdNumber.GetAllParamsCount

function TkwDocNumberQueryFormEdNumber.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TDocNumberQueryForm)]);
end;//TkwDocNumberQueryFormEdNumber.ParamsTypes

type
  TkwDocNumberQueryFormCbInternal = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TDocNumberQueryForm.cbInternal
[panel]Контрол cbInternal формы TDocNumberQueryForm[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aDocNumberQueryForm .TDocNumberQueryForm.cbInternal >>> l_TvtCheckBox
[code]  }
  private
  // private methods
   function CbInternal(const aCtx: TtfwContext;
     aDocNumberQueryForm: TDocNumberQueryForm): TvtCheckBox;
     {* Реализация слова скрипта .TDocNumberQueryForm.cbInternal }
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
  end;//TkwDocNumberQueryFormCbInternal

// start class TkwDocNumberQueryFormCbInternal

function TkwDocNumberQueryFormCbInternal.CbInternal(const aCtx: TtfwContext;
  aDocNumberQueryForm: TDocNumberQueryForm): TvtCheckBox;
 {-}
begin
 Result := aDocNumberQueryForm.cbInternal;
end;//TkwDocNumberQueryFormCbInternal.CbInternal

procedure TkwDocNumberQueryFormCbInternal.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDocNumberQueryForm : TDocNumberQueryForm;
begin
 try
  l_aDocNumberQueryForm := TDocNumberQueryForm(aCtx.rEngine.PopObjAs(TDocNumberQueryForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDocNumberQueryForm: TDocNumberQueryForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((CbInternal(aCtx, l_aDocNumberQueryForm)));
end;//TkwDocNumberQueryFormCbInternal.DoDoIt

class function TkwDocNumberQueryFormCbInternal.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TDocNumberQueryForm.cbInternal';
end;//TkwDocNumberQueryFormCbInternal.GetWordNameForRegister

procedure TkwDocNumberQueryFormCbInternal.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству cbInternal', aCtx);
end;//TkwDocNumberQueryFormCbInternal.SetValuePrim

function TkwDocNumberQueryFormCbInternal.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwDocNumberQueryFormCbInternal.GetResultTypeInfo

function TkwDocNumberQueryFormCbInternal.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwDocNumberQueryFormCbInternal.GetAllParamsCount

function TkwDocNumberQueryFormCbInternal.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TDocNumberQueryForm)]);
end;//TkwDocNumberQueryFormCbInternal.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_DocNumberQuery
 Tkw_Form_DocNumberQuery.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DocNumberQuery_Control_Label1
 Tkw_DocNumberQuery_Control_Label1.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DocNumberQuery_Control_Label1_Push
 Tkw_DocNumberQuery_Control_Label1_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DocNumberQuery_Control_edNumber
 Tkw_DocNumberQuery_Control_edNumber.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DocNumberQuery_Control_edNumber_Push
 Tkw_DocNumberQuery_Control_edNumber_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DocNumberQuery_Control_cbInternal
 Tkw_DocNumberQuery_Control_cbInternal.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DocNumberQuery_Control_cbInternal_Push
 Tkw_DocNumberQuery_Control_cbInternal_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация DocNumberQueryForm_Label1
 TkwDocNumberQueryFormLabel1.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация DocNumberQueryForm_edNumber
 TkwDocNumberQueryFormEdNumber.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация DocNumberQueryForm_cbInternal
 TkwDocNumberQueryFormCbInternal.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа DocNumberQuery
 TtfwTypeRegistrator.RegisterType(TypeInfo(TDocNumberQueryForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscComboBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscComboBox));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtCheckBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCheckBox));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.