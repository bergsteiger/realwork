unit CreateFilterKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Filters/CreateFilterKeywordsPack.pas"
// Начат: 29.10.2010 15:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Основные прецеденты::Filters::View::Filters::Filters$FP::CreateFilterKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы CreateFilter$Form
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
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtLabel,
  CreateFilter_Form,
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
  Tkw_Form_CreateFilter = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы CreateFilter$Form
----
*Пример использования*:
[code]
'aControl' форма::CreateFilter TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_CreateFilter

// start class Tkw_Form_CreateFilter

class function Tkw_Form_CreateFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::CreateFilter';
end;//Tkw_Form_CreateFilter.GetWordNameForRegister

function Tkw_Form_CreateFilter.GetString: AnsiString;
 {-}
begin
 Result := 'CreateFilterForm';
end;//Tkw_Form_CreateFilter.GetString

type
  Tkw_CreateFilter_Control_NameLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола NameLabel
----
*Пример использования*:
[code]
контрол::NameLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CreateFilter_Control_NameLabel

// start class Tkw_CreateFilter_Control_NameLabel

class function Tkw_CreateFilter_Control_NameLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::NameLabel';
end;//Tkw_CreateFilter_Control_NameLabel.GetWordNameForRegister

function Tkw_CreateFilter_Control_NameLabel.GetString: AnsiString;
 {-}
begin
 Result := 'NameLabel';
end;//Tkw_CreateFilter_Control_NameLabel.GetString

class procedure Tkw_CreateFilter_Control_NameLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_CreateFilter_Control_NameLabel.RegisterInEngine

type
  Tkw_CreateFilter_Control_NameLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола NameLabel
----
*Пример использования*:
[code]
контрол::NameLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CreateFilter_Control_NameLabel_Push

// start class Tkw_CreateFilter_Control_NameLabel_Push

procedure Tkw_CreateFilter_Control_NameLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('NameLabel');
 inherited;
end;//Tkw_CreateFilter_Control_NameLabel_Push.DoDoIt

class function Tkw_CreateFilter_Control_NameLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::NameLabel:push';
end;//Tkw_CreateFilter_Control_NameLabel_Push.GetWordNameForRegister

type
  Tkw_CreateFilter_Control_FilterName = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FilterName
----
*Пример использования*:
[code]
контрол::FilterName TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CreateFilter_Control_FilterName

// start class Tkw_CreateFilter_Control_FilterName

class function Tkw_CreateFilter_Control_FilterName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FilterName';
end;//Tkw_CreateFilter_Control_FilterName.GetWordNameForRegister

function Tkw_CreateFilter_Control_FilterName.GetString: AnsiString;
 {-}
begin
 Result := 'FilterName';
end;//Tkw_CreateFilter_Control_FilterName.GetString

class procedure Tkw_CreateFilter_Control_FilterName.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_CreateFilter_Control_FilterName.RegisterInEngine

type
  Tkw_CreateFilter_Control_FilterName_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FilterName
----
*Пример использования*:
[code]
контрол::FilterName:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CreateFilter_Control_FilterName_Push

// start class Tkw_CreateFilter_Control_FilterName_Push

procedure Tkw_CreateFilter_Control_FilterName_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FilterName');
 inherited;
end;//Tkw_CreateFilter_Control_FilterName_Push.DoDoIt

class function Tkw_CreateFilter_Control_FilterName_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FilterName:push';
end;//Tkw_CreateFilter_Control_FilterName_Push.GetWordNameForRegister

type
  TkwCreateFilterFormNameLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TCreateFilterForm.NameLabel
[panel]Контрол NameLabel формы TCreateFilterForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aCreateFilterForm .TCreateFilterForm.NameLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function NameLabel(const aCtx: TtfwContext;
     aCreateFilterForm: TCreateFilterForm): TvtLabel;
     {* Реализация слова скрипта .TCreateFilterForm.NameLabel }
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
  end;//TkwCreateFilterFormNameLabel

// start class TkwCreateFilterFormNameLabel

function TkwCreateFilterFormNameLabel.NameLabel(const aCtx: TtfwContext;
  aCreateFilterForm: TCreateFilterForm): TvtLabel;
 {-}
begin
 Result := aCreateFilterForm.NameLabel;
end;//TkwCreateFilterFormNameLabel.NameLabel

procedure TkwCreateFilterFormNameLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCreateFilterForm : TCreateFilterForm;
begin
 try
  l_aCreateFilterForm := TCreateFilterForm(aCtx.rEngine.PopObjAs(TCreateFilterForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCreateFilterForm: TCreateFilterForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((NameLabel(aCtx, l_aCreateFilterForm)));
end;//TkwCreateFilterFormNameLabel.DoDoIt

class function TkwCreateFilterFormNameLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCreateFilterForm.NameLabel';
end;//TkwCreateFilterFormNameLabel.GetWordNameForRegister

procedure TkwCreateFilterFormNameLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству NameLabel', aCtx);
end;//TkwCreateFilterFormNameLabel.SetValuePrim

function TkwCreateFilterFormNameLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwCreateFilterFormNameLabel.GetResultTypeInfo

function TkwCreateFilterFormNameLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCreateFilterFormNameLabel.GetAllParamsCount

function TkwCreateFilterFormNameLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCreateFilterForm)]);
end;//TkwCreateFilterFormNameLabel.ParamsTypes

type
  TkwCreateFilterFormFilterName = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TCreateFilterForm.FilterName
[panel]Контрол FilterName формы TCreateFilterForm[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aCreateFilterForm .TCreateFilterForm.FilterName >>> l_TnscEdit
[code]  }
  private
  // private methods
   function FilterName(const aCtx: TtfwContext;
     aCreateFilterForm: TCreateFilterForm): TnscEdit;
     {* Реализация слова скрипта .TCreateFilterForm.FilterName }
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
  end;//TkwCreateFilterFormFilterName

// start class TkwCreateFilterFormFilterName

function TkwCreateFilterFormFilterName.FilterName(const aCtx: TtfwContext;
  aCreateFilterForm: TCreateFilterForm): TnscEdit;
 {-}
begin
 Result := aCreateFilterForm.FilterName;
end;//TkwCreateFilterFormFilterName.FilterName

procedure TkwCreateFilterFormFilterName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCreateFilterForm : TCreateFilterForm;
begin
 try
  l_aCreateFilterForm := TCreateFilterForm(aCtx.rEngine.PopObjAs(TCreateFilterForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCreateFilterForm: TCreateFilterForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FilterName(aCtx, l_aCreateFilterForm)));
end;//TkwCreateFilterFormFilterName.DoDoIt

class function TkwCreateFilterFormFilterName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TCreateFilterForm.FilterName';
end;//TkwCreateFilterFormFilterName.GetWordNameForRegister

procedure TkwCreateFilterFormFilterName.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FilterName', aCtx);
end;//TkwCreateFilterFormFilterName.SetValuePrim

function TkwCreateFilterFormFilterName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEdit);
end;//TkwCreateFilterFormFilterName.GetResultTypeInfo

function TkwCreateFilterFormFilterName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCreateFilterFormFilterName.GetAllParamsCount

function TkwCreateFilterFormFilterName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCreateFilterForm)]);
end;//TkwCreateFilterFormFilterName.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_CreateFilter
 Tkw_Form_CreateFilter.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CreateFilter_Control_NameLabel
 Tkw_CreateFilter_Control_NameLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CreateFilter_Control_NameLabel_Push
 Tkw_CreateFilter_Control_NameLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CreateFilter_Control_FilterName
 Tkw_CreateFilter_Control_FilterName.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CreateFilter_Control_FilterName_Push
 Tkw_CreateFilter_Control_FilterName_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация CreateFilterForm_NameLabel
 TkwCreateFilterFormNameLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация CreateFilterForm_FilterName
 TkwCreateFilterFormFilterName.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа CreateFilter$Form
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCreateFilterForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscEdit
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.