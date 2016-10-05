unit GroupPropertyKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы GroupProperty }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\GroupPropertyKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "GroupPropertyKeywordsPack" MUID: (4AA8E3E20024_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , GroupProperty_Form
 , tfwPropertyLike
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , vtLabel
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4AA8E3E20024_Packimpl_uses*
 //#UC END# *4AA8E3E20024_Packimpl_uses*
;

type
 TkwEfGroupPropertyEdName = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefGroupProperty.edName }
  private
   function edName(const aCtx: TtfwContext;
    aefGroupProperty: TefGroupProperty): TnscEdit;
    {* Реализация слова скрипта .TefGroupProperty.edName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfGroupPropertyEdName

 TkwEfGroupPropertyLabel1 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefGroupProperty.Label1 }
  private
   function Label1(const aCtx: TtfwContext;
    aefGroupProperty: TefGroupProperty): TvtLabel;
    {* Реализация слова скрипта .TefGroupProperty.Label1 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfGroupPropertyLabel1

 Tkw_Form_GroupProperty = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы GroupProperty
----
*Пример использования*:
[code]форма::GroupProperty TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_GroupProperty

 Tkw_GroupProperty_Control_edName = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edName
----
*Пример использования*:
[code]контрол::edName TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_GroupProperty_Control_edName

 Tkw_GroupProperty_Control_edName_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edName
----
*Пример использования*:
[code]контрол::edName:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_GroupProperty_Control_edName_Push

 Tkw_GroupProperty_Control_Label1 = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Label1
----
*Пример использования*:
[code]контрол::Label1 TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_GroupProperty_Control_Label1

 Tkw_GroupProperty_Control_Label1_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Label1
----
*Пример использования*:
[code]контрол::Label1:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_GroupProperty_Control_Label1_Push

function TkwEfGroupPropertyEdName.edName(const aCtx: TtfwContext;
 aefGroupProperty: TefGroupProperty): TnscEdit;
 {* Реализация слова скрипта .TefGroupProperty.edName }
begin
 Result := aefGroupProperty.edName;
end;//TkwEfGroupPropertyEdName.edName

class function TkwEfGroupPropertyEdName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefGroupProperty.edName';
end;//TkwEfGroupPropertyEdName.GetWordNameForRegister

function TkwEfGroupPropertyEdName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwEfGroupPropertyEdName.GetResultTypeInfo

function TkwEfGroupPropertyEdName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfGroupPropertyEdName.GetAllParamsCount

function TkwEfGroupPropertyEdName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefGroupProperty)]);
end;//TkwEfGroupPropertyEdName.ParamsTypes

procedure TkwEfGroupPropertyEdName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edName', aCtx);
end;//TkwEfGroupPropertyEdName.SetValuePrim

procedure TkwEfGroupPropertyEdName.DoDoIt(const aCtx: TtfwContext);
var l_aefGroupProperty: TefGroupProperty;
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
 aCtx.rEngine.PushObj(edName(aCtx, l_aefGroupProperty));
end;//TkwEfGroupPropertyEdName.DoDoIt

function TkwEfGroupPropertyLabel1.Label1(const aCtx: TtfwContext;
 aefGroupProperty: TefGroupProperty): TvtLabel;
 {* Реализация слова скрипта .TefGroupProperty.Label1 }
begin
 Result := aefGroupProperty.Label1;
end;//TkwEfGroupPropertyLabel1.Label1

class function TkwEfGroupPropertyLabel1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefGroupProperty.Label1';
end;//TkwEfGroupPropertyLabel1.GetWordNameForRegister

function TkwEfGroupPropertyLabel1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfGroupPropertyLabel1.GetResultTypeInfo

function TkwEfGroupPropertyLabel1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfGroupPropertyLabel1.GetAllParamsCount

function TkwEfGroupPropertyLabel1.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefGroupProperty)]);
end;//TkwEfGroupPropertyLabel1.ParamsTypes

procedure TkwEfGroupPropertyLabel1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Label1', aCtx);
end;//TkwEfGroupPropertyLabel1.SetValuePrim

procedure TkwEfGroupPropertyLabel1.DoDoIt(const aCtx: TtfwContext);
var l_aefGroupProperty: TefGroupProperty;
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
 aCtx.rEngine.PushObj(Label1(aCtx, l_aefGroupProperty));
end;//TkwEfGroupPropertyLabel1.DoDoIt

function Tkw_Form_GroupProperty.GetString: AnsiString;
begin
 Result := 'efGroupProperty';
end;//Tkw_Form_GroupProperty.GetString

class procedure Tkw_Form_GroupProperty.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TefGroupProperty);
end;//Tkw_Form_GroupProperty.RegisterInEngine

class function Tkw_Form_GroupProperty.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::GroupProperty';
end;//Tkw_Form_GroupProperty.GetWordNameForRegister

function Tkw_GroupProperty_Control_edName.GetString: AnsiString;
begin
 Result := 'edName';
end;//Tkw_GroupProperty_Control_edName.GetString

class procedure Tkw_GroupProperty_Control_edName.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_GroupProperty_Control_edName.RegisterInEngine

class function Tkw_GroupProperty_Control_edName.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edName';
end;//Tkw_GroupProperty_Control_edName.GetWordNameForRegister

procedure Tkw_GroupProperty_Control_edName_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edName');
 inherited;
end;//Tkw_GroupProperty_Control_edName_Push.DoDoIt

class function Tkw_GroupProperty_Control_edName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edName:push';
end;//Tkw_GroupProperty_Control_edName_Push.GetWordNameForRegister

function Tkw_GroupProperty_Control_Label1.GetString: AnsiString;
begin
 Result := 'Label1';
end;//Tkw_GroupProperty_Control_Label1.GetString

class procedure Tkw_GroupProperty_Control_Label1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_GroupProperty_Control_Label1.RegisterInEngine

class function Tkw_GroupProperty_Control_Label1.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Label1';
end;//Tkw_GroupProperty_Control_Label1.GetWordNameForRegister

procedure Tkw_GroupProperty_Control_Label1_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Label1');
 inherited;
end;//Tkw_GroupProperty_Control_Label1_Push.DoDoIt

class function Tkw_GroupProperty_Control_Label1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Label1:push';
end;//Tkw_GroupProperty_Control_Label1_Push.GetWordNameForRegister

initialization
 TkwEfGroupPropertyEdName.RegisterInEngine;
 {* Регистрация efGroupProperty_edName }
 TkwEfGroupPropertyLabel1.RegisterInEngine;
 {* Регистрация efGroupProperty_Label1 }
 Tkw_Form_GroupProperty.RegisterInEngine;
 {* Регистрация Tkw_Form_GroupProperty }
 Tkw_GroupProperty_Control_edName.RegisterInEngine;
 {* Регистрация Tkw_GroupProperty_Control_edName }
 Tkw_GroupProperty_Control_edName_Push.RegisterInEngine;
 {* Регистрация Tkw_GroupProperty_Control_edName_Push }
 Tkw_GroupProperty_Control_Label1.RegisterInEngine;
 {* Регистрация Tkw_GroupProperty_Control_Label1 }
 Tkw_GroupProperty_Control_Label1_Push.RegisterInEngine;
 {* Регистрация Tkw_GroupProperty_Control_Label1_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefGroupProperty));
 {* Регистрация типа TefGroupProperty }
{$If Defined(Nemesis)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
 {* Регистрация типа TnscEdit }
{$IfEnd} // Defined(Nemesis)
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
