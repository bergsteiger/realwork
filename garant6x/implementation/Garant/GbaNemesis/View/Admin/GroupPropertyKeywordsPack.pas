unit GroupPropertyKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/GroupPropertyKeywordsPack.pas"
// Начат: 07.09.2009 18:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Администратор::Admin::View::Admin::Admin::GroupPropertyKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы GroupProperty
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin) AND not defined(NoScripts)}
uses
  GroupProperty_Form
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
  tfwPropertyLike
  ;

{$IfEnd} //Admin AND not NoScripts

implementation

{$If defined(Admin) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_GroupProperty = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы GroupProperty
----
*Пример использования*:
[code]
'aControl' форма::GroupProperty TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_GroupProperty

// start class Tkw_Form_GroupProperty

class function Tkw_Form_GroupProperty.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::GroupProperty';
end;//Tkw_Form_GroupProperty.GetWordNameForRegister

function Tkw_Form_GroupProperty.GetString: AnsiString;
 {-}
begin
 Result := 'efGroupProperty';
end;//Tkw_Form_GroupProperty.GetString

type
  Tkw_GroupProperty_Control_edName = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола edName
----
*Пример использования*:
[code]
контрол::edName TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_GroupProperty_Control_edName

// start class Tkw_GroupProperty_Control_edName

class function Tkw_GroupProperty_Control_edName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edName';
end;//Tkw_GroupProperty_Control_edName.GetWordNameForRegister

function Tkw_GroupProperty_Control_edName.GetString: AnsiString;
 {-}
begin
 Result := 'edName';
end;//Tkw_GroupProperty_Control_edName.GetString

class procedure Tkw_GroupProperty_Control_edName.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_GroupProperty_Control_edName.RegisterInEngine

type
  Tkw_GroupProperty_Control_edName_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола edName
----
*Пример использования*:
[code]
контрол::edName:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_GroupProperty_Control_edName_Push

// start class Tkw_GroupProperty_Control_edName_Push

procedure Tkw_GroupProperty_Control_edName_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edName');
 inherited;
end;//Tkw_GroupProperty_Control_edName_Push.DoDoIt

class function Tkw_GroupProperty_Control_edName_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edName:push';
end;//Tkw_GroupProperty_Control_edName_Push.GetWordNameForRegister

type
  Tkw_GroupProperty_Control_Label1 = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_GroupProperty_Control_Label1

// start class Tkw_GroupProperty_Control_Label1

class function Tkw_GroupProperty_Control_Label1.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Label1';
end;//Tkw_GroupProperty_Control_Label1.GetWordNameForRegister

function Tkw_GroupProperty_Control_Label1.GetString: AnsiString;
 {-}
begin
 Result := 'Label1';
end;//Tkw_GroupProperty_Control_Label1.GetString

class procedure Tkw_GroupProperty_Control_Label1.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_GroupProperty_Control_Label1.RegisterInEngine

type
  Tkw_GroupProperty_Control_Label1_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_GroupProperty_Control_Label1_Push

// start class Tkw_GroupProperty_Control_Label1_Push

procedure Tkw_GroupProperty_Control_Label1_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Label1');
 inherited;
end;//Tkw_GroupProperty_Control_Label1_Push.DoDoIt

class function Tkw_GroupProperty_Control_Label1_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Label1:push';
end;//Tkw_GroupProperty_Control_Label1_Push.GetWordNameForRegister

type
  TkwEfGroupPropertyEdName = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefGroupProperty.edName
[panel]Контрол edName формы TefGroupProperty[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aefGroupProperty .TefGroupProperty.edName >>> l_TnscEdit
[code]  }
  private
  // private methods
   function EdName(const aCtx: TtfwContext;
     aefGroupProperty: TefGroupProperty): TnscEdit;
     {* Реализация слова скрипта .TefGroupProperty.edName }
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
  end;//TkwEfGroupPropertyEdName

// start class TkwEfGroupPropertyEdName

function TkwEfGroupPropertyEdName.EdName(const aCtx: TtfwContext;
  aefGroupProperty: TefGroupProperty): TnscEdit;
 {-}
begin
 Result := aefGroupProperty.edName;
end;//TkwEfGroupPropertyEdName.EdName

procedure TkwEfGroupPropertyEdName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefGroupProperty : TefGroupProperty;
begin
 try
  l_aefGroupProperty := TefGroupProperty(aCtx.rEngine.PopObjAs(TefGroupProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefGroupProperty: TefGroupProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdName(aCtx, l_aefGroupProperty)));
end;//TkwEfGroupPropertyEdName.DoDoIt

class function TkwEfGroupPropertyEdName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefGroupProperty.edName';
end;//TkwEfGroupPropertyEdName.GetWordNameForRegister

procedure TkwEfGroupPropertyEdName.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству edName', aCtx);
end;//TkwEfGroupPropertyEdName.SetValuePrim

function TkwEfGroupPropertyEdName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEdit);
end;//TkwEfGroupPropertyEdName.GetResultTypeInfo

function TkwEfGroupPropertyEdName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfGroupPropertyEdName.GetAllParamsCount

function TkwEfGroupPropertyEdName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefGroupProperty)]);
end;//TkwEfGroupPropertyEdName.ParamsTypes

type
  TkwEfGroupPropertyLabel1 = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefGroupProperty.Label1
[panel]Контрол Label1 формы TefGroupProperty[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefGroupProperty .TefGroupProperty.Label1 >>> l_TvtLabel
[code]  }
  private
  // private methods
   function Label1(const aCtx: TtfwContext;
     aefGroupProperty: TefGroupProperty): TvtLabel;
     {* Реализация слова скрипта .TefGroupProperty.Label1 }
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
  end;//TkwEfGroupPropertyLabel1

// start class TkwEfGroupPropertyLabel1

function TkwEfGroupPropertyLabel1.Label1(const aCtx: TtfwContext;
  aefGroupProperty: TefGroupProperty): TvtLabel;
 {-}
begin
 Result := aefGroupProperty.Label1;
end;//TkwEfGroupPropertyLabel1.Label1

procedure TkwEfGroupPropertyLabel1.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefGroupProperty : TefGroupProperty;
begin
 try
  l_aefGroupProperty := TefGroupProperty(aCtx.rEngine.PopObjAs(TefGroupProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefGroupProperty: TefGroupProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Label1(aCtx, l_aefGroupProperty)));
end;//TkwEfGroupPropertyLabel1.DoDoIt

class function TkwEfGroupPropertyLabel1.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefGroupProperty.Label1';
end;//TkwEfGroupPropertyLabel1.GetWordNameForRegister

procedure TkwEfGroupPropertyLabel1.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Label1', aCtx);
end;//TkwEfGroupPropertyLabel1.SetValuePrim

function TkwEfGroupPropertyLabel1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfGroupPropertyLabel1.GetResultTypeInfo

function TkwEfGroupPropertyLabel1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfGroupPropertyLabel1.GetAllParamsCount

function TkwEfGroupPropertyLabel1.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefGroupProperty)]);
end;//TkwEfGroupPropertyLabel1.ParamsTypes
{$IfEnd} //Admin AND not NoScripts

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_Form_GroupProperty
 Tkw_Form_GroupProperty.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_GroupProperty_Control_edName
 Tkw_GroupProperty_Control_edName.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_GroupProperty_Control_edName_Push
 Tkw_GroupProperty_Control_edName_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_GroupProperty_Control_Label1
 Tkw_GroupProperty_Control_Label1.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_GroupProperty_Control_Label1_Push
 Tkw_GroupProperty_Control_Label1_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация efGroupProperty_edName
 TkwEfGroupPropertyEdName.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация efGroupProperty_Label1
 TkwEfGroupPropertyLabel1.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа GroupProperty
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefGroupProperty));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TnscEdit
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //Admin AND not NoScripts

end.