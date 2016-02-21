unit PictureKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Picture }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\PictureKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

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
  {* ����� ������� ��� �������������� ����� Picture
----
*������ �������������*:
[code]
'aControl' �����::Picture TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Picture

 Tkw_Picture_Component_ieIO = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ieIO
----
*������ �������������*:
[code]
���������::ieIO TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Picture_Component_ieIO

 Tkw_Picture_Control_ieViewer = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ieViewer
----
*������ �������������*:
[code]
�������::ieViewer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Picture_Control_ieViewer

 Tkw_Picture_Control_ieViewer_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ieViewer
----
*������ �������������*:
[code]
�������::ieViewer:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Picture_Control_ieViewer_Push

 Tkw_Picture_Component_ieProc = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ieProc
----
*������ �������������*:
[code]
���������::ieProc TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Picture_Component_ieProc

 TkwPictureFormIeIO = {final} class(TtfwPropertyLike)
  {* ����� ������� .TPictureForm.ieIO
[panel]������� ieIO ����� TPictureForm[panel]
*��� ����������:* TImageEnIO
*������:*
[code]
OBJECT VAR l_TImageEnIO
 aPictureForm .TPictureForm.ieIO >>> l_TImageEnIO
[code]  }
  private
   function ieIO(const aCtx: TtfwContext;
    aPictureForm: TPictureForm): TImageEnIO;
    {* ���������� ����� ������� .TPictureForm.ieIO }
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
  {* ����� ������� .TPictureForm.ieViewer
[panel]������� ieViewer ����� TPictureForm[panel]
*��� ����������:* TImageEnView
*������:*
[code]
OBJECT VAR l_TImageEnView
 aPictureForm .TPictureForm.ieViewer >>> l_TImageEnView
[code]  }
  private
   function ieViewer(const aCtx: TtfwContext;
    aPictureForm: TPictureForm): TImageEnView;
    {* ���������� ����� ������� .TPictureForm.ieViewer }
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
  {* ����� ������� .TPictureForm.ieProc
[panel]������� ieProc ����� TPictureForm[panel]
*��� ����������:* TImageEnProc
*������:*
[code]
OBJECT VAR l_TImageEnProc
 aPictureForm .TPictureForm.ieProc >>> l_TImageEnProc
[code]  }
  private
   function ieProc(const aCtx: TtfwContext;
    aPictureForm: TPictureForm): TImageEnProc;
    {* ���������� ����� ������� .TPictureForm.ieProc }
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
 Result := '�����::Picture';
end;//Tkw_Form_Picture.GetWordNameForRegister

function Tkw_Form_Picture.GetString: AnsiString;
begin
 Result := 'PictureForm';
end;//Tkw_Form_Picture.GetString

class function Tkw_Picture_Component_ieIO.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::ieIO';
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
 Result := '�������::ieViewer';
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
 Result := '�������::ieViewer:push';
end;//Tkw_Picture_Control_ieViewer_Push.GetWordNameForRegister

class function Tkw_Picture_Component_ieProc.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::ieProc';
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
 {* ���������� ����� ������� .TPictureForm.ieIO }
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
   RunnerError('������ ��� ��������� ��������� aPictureForm: TPictureForm : ' + E.Message, aCtx);
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
 RunnerError('������ ����������� �������� readonly �������� ieIO', aCtx);
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
 {* ���������� ����� ������� .TPictureForm.ieViewer }
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
   RunnerError('������ ��� ��������� ��������� aPictureForm: TPictureForm : ' + E.Message, aCtx);
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
 RunnerError('������ ����������� �������� readonly �������� ieViewer', aCtx);
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
 {* ���������� ����� ������� .TPictureForm.ieProc }
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
   RunnerError('������ ��� ��������� ��������� aPictureForm: TPictureForm : ' + E.Message, aCtx);
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
 RunnerError('������ ����������� �������� readonly �������� ieProc', aCtx);
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
 {* ����������� Tkw_Form_Picture }
 Tkw_Picture_Component_ieIO.RegisterInEngine;
 {* ����������� Tkw_Picture_Component_ieIO }
 Tkw_Picture_Control_ieViewer.RegisterInEngine;
 {* ����������� Tkw_Picture_Control_ieViewer }
 Tkw_Picture_Control_ieViewer_Push.RegisterInEngine;
 {* ����������� Tkw_Picture_Control_ieViewer_Push }
 Tkw_Picture_Component_ieProc.RegisterInEngine;
 {* ����������� Tkw_Picture_Component_ieProc }
 TkwPictureFormIeIO.RegisterInEngine;
 {* ����������� PictureForm_ieIO }
 TkwPictureFormIeViewer.RegisterInEngine;
 {* ����������� PictureForm_ieViewer }
 TkwPictureFormIeProc.RegisterInEngine;
 {* ����������� PictureForm_ieProc }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPictureForm));
 {* ����������� ���� Picture }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImageEnIO));
 {* ����������� ���� TImageEnIO }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImageEnView));
 {* ����������� ���� TImageEnView }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImageEnProc));
 {* ����������� ���� TImageEnProc }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
