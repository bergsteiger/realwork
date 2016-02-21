unit PictureKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Picture }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\PictureKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Document_Module
 {$If NOT Defined(NoImageEn)}
 , imageenio
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If NOT Defined(NoImageEn)}
 , imageenview
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If NOT Defined(NoImageEn)}
 , imageenproc
 {$IfEnd} // NOT Defined(NoImageEn)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_Picture = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Picture
----
*Пример использования*:
[code]
'aControl' форма::Picture TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Picture

 Tkw_Picture_Component_ieIO = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ieIO
----
*Пример использования*:
[code]
компонент::ieIO TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Picture_Component_ieIO

 Tkw_Picture_Control_ieViewer = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ieViewer
----
*Пример использования*:
[code]
контрол::ieViewer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Picture_Control_ieViewer

 Tkw_Picture_Control_ieViewer_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ieViewer
----
*Пример использования*:
[code]
контрол::ieViewer:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Picture_Control_ieViewer_Push

 Tkw_Picture_Component_ieProc = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ieProc
----
*Пример использования*:
[code]
компонент::ieProc TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Picture_Component_ieProc

 TkwPictureFormIeIO = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TPictureForm.ieIO
[panel]Контрол ieIO формы TPictureForm[panel]
*Тип результата:* TImageEnIO
*Пример:*
[code]
OBJECT VAR l_TImageEnIO
 aPictureForm .TPictureForm.ieIO >>> l_TImageEnIO
[code]  }
  private
   function ieIO(const aCtx: TtfwContext;
    aPictureForm: TPictureForm): TImageEnIO;
    {* Реализация слова скрипта .TPictureForm.ieIO }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPictureFormIeIO

 TkwPictureFormIeViewer = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TPictureForm.ieViewer
[panel]Контрол ieViewer формы TPictureForm[panel]
*Тип результата:* TImageEnView
*Пример:*
[code]
OBJECT VAR l_TImageEnView
 aPictureForm .TPictureForm.ieViewer >>> l_TImageEnView
[code]  }
  private
   function ieViewer(const aCtx: TtfwContext;
    aPictureForm: TPictureForm): TImageEnView;
    {* Реализация слова скрипта .TPictureForm.ieViewer }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPictureFormIeViewer

 TkwPictureFormIeProc = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TPictureForm.ieProc
[panel]Контрол ieProc формы TPictureForm[panel]
*Тип результата:* TImageEnProc
*Пример:*
[code]
OBJECT VAR l_TImageEnProc
 aPictureForm .TPictureForm.ieProc >>> l_TImageEnProc
[code]  }
  private
   function ieProc(const aCtx: TtfwContext;
    aPictureForm: TPictureForm): TImageEnProc;
    {* Реализация слова скрипта .TPictureForm.ieProc }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPictureFormIeProc

class function Tkw_Form_Picture.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Picture';
end;//Tkw_Form_Picture.GetWordNameForRegister

function Tkw_Form_Picture.GetString: AnsiString;
begin
 Result := 'PictureForm';
end;//Tkw_Form_Picture.GetString

class function Tkw_Picture_Component_ieIO.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::ieIO';
end;//Tkw_Picture_Component_ieIO.GetWordNameForRegister

function Tkw_Picture_Component_ieIO.GetString: AnsiString;
begin
 Result := 'ieIO';
end;//Tkw_Picture_Component_ieIO.GetString

class procedure Tkw_Picture_Component_ieIO.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TImageEnIO);
end;//Tkw_Picture_Component_ieIO.RegisterInEngine

class function Tkw_Picture_Control_ieViewer.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ieViewer';
end;//Tkw_Picture_Control_ieViewer.GetWordNameForRegister

function Tkw_Picture_Control_ieViewer.GetString: AnsiString;
begin
 Result := 'ieViewer';
end;//Tkw_Picture_Control_ieViewer.GetString

class procedure Tkw_Picture_Control_ieViewer.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TImageEnView);
end;//Tkw_Picture_Control_ieViewer.RegisterInEngine

procedure Tkw_Picture_Control_ieViewer_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AB3DE42513C0_var*
//#UC END# *4DAEEDE10285_AB3DE42513C0_var*
begin
//#UC START# *4DAEEDE10285_AB3DE42513C0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AB3DE42513C0_impl*
end;//Tkw_Picture_Control_ieViewer_Push.DoDoIt

class function Tkw_Picture_Control_ieViewer_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ieViewer:push';
end;//Tkw_Picture_Control_ieViewer_Push.GetWordNameForRegister

class function Tkw_Picture_Component_ieProc.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::ieProc';
end;//Tkw_Picture_Component_ieProc.GetWordNameForRegister

function Tkw_Picture_Component_ieProc.GetString: AnsiString;
begin
 Result := 'ieProc';
end;//Tkw_Picture_Component_ieProc.GetString

class procedure Tkw_Picture_Component_ieProc.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TImageEnProc);
end;//Tkw_Picture_Component_ieProc.RegisterInEngine

function TkwPictureFormIeIO.ieIO(const aCtx: TtfwContext;
 aPictureForm: TPictureForm): TImageEnIO;
 {* Реализация слова скрипта .TPictureForm.ieIO }
begin
 Result := aPictureForm.ieIO;
end;//TkwPictureFormIeIO.ieIO

procedure TkwPictureFormIeIO.DoDoIt(const aCtx: TtfwContext);
var l_aPictureForm: TPictureForm;
begin
 try
  l_aPictureForm := TPictureForm(aCtx.rEngine.PopObjAs(TPictureForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPictureForm: TPictureForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ieIO(aCtx, l_aPictureForm));
end;//TkwPictureFormIeIO.DoDoIt

class function TkwPictureFormIeIO.GetWordNameForRegister: AnsiString;
begin
 Result := '.TPictureForm.ieIO';
end;//TkwPictureFormIeIO.GetWordNameForRegister

procedure TkwPictureFormIeIO.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ieIO', aCtx);
end;//TkwPictureFormIeIO.SetValuePrim

function TkwPictureFormIeIO.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TImageEnIO);
end;//TkwPictureFormIeIO.GetResultTypeInfo

function TkwPictureFormIeIO.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPictureFormIeIO.GetAllParamsCount

function TkwPictureFormIeIO.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TPictureForm)]);
end;//TkwPictureFormIeIO.ParamsTypes

function TkwPictureFormIeViewer.ieViewer(const aCtx: TtfwContext;
 aPictureForm: TPictureForm): TImageEnView;
 {* Реализация слова скрипта .TPictureForm.ieViewer }
begin
 Result := aPictureForm.ieViewer;
end;//TkwPictureFormIeViewer.ieViewer

procedure TkwPictureFormIeViewer.DoDoIt(const aCtx: TtfwContext);
var l_aPictureForm: TPictureForm;
begin
 try
  l_aPictureForm := TPictureForm(aCtx.rEngine.PopObjAs(TPictureForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPictureForm: TPictureForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ieViewer(aCtx, l_aPictureForm));
end;//TkwPictureFormIeViewer.DoDoIt

class function TkwPictureFormIeViewer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TPictureForm.ieViewer';
end;//TkwPictureFormIeViewer.GetWordNameForRegister

procedure TkwPictureFormIeViewer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ieViewer', aCtx);
end;//TkwPictureFormIeViewer.SetValuePrim

function TkwPictureFormIeViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TImageEnView);
end;//TkwPictureFormIeViewer.GetResultTypeInfo

function TkwPictureFormIeViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPictureFormIeViewer.GetAllParamsCount

function TkwPictureFormIeViewer.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TPictureForm)]);
end;//TkwPictureFormIeViewer.ParamsTypes

function TkwPictureFormIeProc.ieProc(const aCtx: TtfwContext;
 aPictureForm: TPictureForm): TImageEnProc;
 {* Реализация слова скрипта .TPictureForm.ieProc }
begin
 Result := aPictureForm.ieProc;
end;//TkwPictureFormIeProc.ieProc

procedure TkwPictureFormIeProc.DoDoIt(const aCtx: TtfwContext);
var l_aPictureForm: TPictureForm;
begin
 try
  l_aPictureForm := TPictureForm(aCtx.rEngine.PopObjAs(TPictureForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPictureForm: TPictureForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ieProc(aCtx, l_aPictureForm));
end;//TkwPictureFormIeProc.DoDoIt

class function TkwPictureFormIeProc.GetWordNameForRegister: AnsiString;
begin
 Result := '.TPictureForm.ieProc';
end;//TkwPictureFormIeProc.GetWordNameForRegister

procedure TkwPictureFormIeProc.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ieProc', aCtx);
end;//TkwPictureFormIeProc.SetValuePrim

function TkwPictureFormIeProc.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TImageEnProc);
end;//TkwPictureFormIeProc.GetResultTypeInfo

function TkwPictureFormIeProc.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPictureFormIeProc.GetAllParamsCount

function TkwPictureFormIeProc.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TPictureForm)]);
end;//TkwPictureFormIeProc.ParamsTypes

initialization
 Tkw_Form_Picture.RegisterInEngine;
 {* Регистрация Tkw_Form_Picture }
 Tkw_Picture_Component_ieIO.RegisterInEngine;
 {* Регистрация Tkw_Picture_Component_ieIO }
 Tkw_Picture_Control_ieViewer.RegisterInEngine;
 {* Регистрация Tkw_Picture_Control_ieViewer }
 Tkw_Picture_Control_ieViewer_Push.RegisterInEngine;
 {* Регистрация Tkw_Picture_Control_ieViewer_Push }
 Tkw_Picture_Component_ieProc.RegisterInEngine;
 {* Регистрация Tkw_Picture_Component_ieProc }
 TkwPictureFormIeIO.RegisterInEngine;
 {* Регистрация PictureForm_ieIO }
 TkwPictureFormIeViewer.RegisterInEngine;
 {* Регистрация PictureForm_ieViewer }
 TkwPictureFormIeProc.RegisterInEngine;
 {* Регистрация PictureForm_ieProc }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPictureForm));
 {* Регистрация типа Picture }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImageEnIO));
 {* Регистрация типа TImageEnIO }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImageEnView));
 {* Регистрация типа TImageEnView }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImageEnProc));
 {* Регистрация типа TImageEnProc }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
