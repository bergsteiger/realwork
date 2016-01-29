unit PictureKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/PictureKeywordsPack.pas"
// �����: 05.02.2009 19:28
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Document::Document::PictureKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� Picture
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  Picture_Form
  {$If not defined(NoImageEn)}
  ,
  imageenview
  {$IfEnd} //not NoImageEn
  
  {$If not defined(NoImageEn)}
  ,
  imageenio
  {$IfEnd} //not NoImageEn
  
  {$If not defined(NoImageEn)}
  ,
  imageenproc
  {$IfEnd} //not NoImageEn
  ,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  tfwPropertyLike,
  l3TreeInterfaces,
  bsTypes
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator,
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

type
  Tkw_Form_Picture = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� Picture
----
*������ �������������*:
[code]
'aControl' �����::Picture TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_Picture

// start class Tkw_Form_Picture

class function Tkw_Form_Picture.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::Picture';
end;//Tkw_Form_Picture.GetWordNameForRegister

function Tkw_Form_Picture.GetString: AnsiString;
 {-}
begin
 Result := 'PictureForm';
end;//Tkw_Form_Picture.GetString

type
  Tkw_Picture_Component_ieIO = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ieIO
----
*������ �������������*:
[code]
���������::ieIO TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Picture_Component_ieIO

// start class Tkw_Picture_Component_ieIO

class function Tkw_Picture_Component_ieIO.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���������::ieIO';
end;//Tkw_Picture_Component_ieIO.GetWordNameForRegister

function Tkw_Picture_Component_ieIO.GetString: AnsiString;
 {-}
begin
 Result := 'ieIO';
end;//Tkw_Picture_Component_ieIO.GetString

class procedure Tkw_Picture_Component_ieIO.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TImageEnIO);
end;//Tkw_Picture_Component_ieIO.RegisterInEngine

type
  Tkw_Picture_Control_ieViewer = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ieViewer
----
*������ �������������*:
[code]
�������::ieViewer TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Picture_Control_ieViewer

// start class Tkw_Picture_Control_ieViewer

class function Tkw_Picture_Control_ieViewer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ieViewer';
end;//Tkw_Picture_Control_ieViewer.GetWordNameForRegister

function Tkw_Picture_Control_ieViewer.GetString: AnsiString;
 {-}
begin
 Result := 'ieViewer';
end;//Tkw_Picture_Control_ieViewer.GetString

class procedure Tkw_Picture_Control_ieViewer.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TImageEnView);
end;//Tkw_Picture_Control_ieViewer.RegisterInEngine

type
  Tkw_Picture_Control_ieViewer_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ieViewer
----
*������ �������������*:
[code]
�������::ieViewer:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Picture_Control_ieViewer_Push

// start class Tkw_Picture_Control_ieViewer_Push

procedure Tkw_Picture_Control_ieViewer_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ieViewer');
 inherited;
end;//Tkw_Picture_Control_ieViewer_Push.DoDoIt

class function Tkw_Picture_Control_ieViewer_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ieViewer:push';
end;//Tkw_Picture_Control_ieViewer_Push.GetWordNameForRegister

type
  Tkw_Picture_Component_ieProc = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ieProc
----
*������ �������������*:
[code]
���������::ieProc TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Picture_Component_ieProc

// start class Tkw_Picture_Component_ieProc

class function Tkw_Picture_Component_ieProc.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���������::ieProc';
end;//Tkw_Picture_Component_ieProc.GetWordNameForRegister

function Tkw_Picture_Component_ieProc.GetString: AnsiString;
 {-}
begin
 Result := 'ieProc';
end;//Tkw_Picture_Component_ieProc.GetString

class procedure Tkw_Picture_Component_ieProc.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TImageEnProc);
end;//Tkw_Picture_Component_ieProc.RegisterInEngine

type
  TkwPictureFormIeIO = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TPictureForm.ieIO
[panel]������� ieIO ����� TPictureForm[panel]
*��� ����������:* TImageEnIO
*������:*
[code]
OBJECT VAR l_TImageEnIO
 aPictureForm .TPictureForm.ieIO >>> l_TImageEnIO
[code]  }
  private
  // private methods
   function IeIO(const aCtx: TtfwContext;
     aPictureForm: TPictureForm): TImageEnIO;
     {* ���������� ����� ������� .TPictureForm.ieIO }
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
  end;//TkwPictureFormIeIO

// start class TkwPictureFormIeIO

function TkwPictureFormIeIO.IeIO(const aCtx: TtfwContext;
  aPictureForm: TPictureForm): TImageEnIO;
 {-}
begin
 Result := aPictureForm.ieIO;
end;//TkwPictureFormIeIO.IeIO

procedure TkwPictureFormIeIO.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aPictureForm : TPictureForm;
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
 aCtx.rEngine.PushObj((IeIO(aCtx, l_aPictureForm)));
end;//TkwPictureFormIeIO.DoDoIt

class function TkwPictureFormIeIO.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TPictureForm.ieIO';
end;//TkwPictureFormIeIO.GetWordNameForRegister

procedure TkwPictureFormIeIO.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ieIO', aCtx);
end;//TkwPictureFormIeIO.SetValuePrim

function TkwPictureFormIeIO.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TImageEnIO);
end;//TkwPictureFormIeIO.GetResultTypeInfo

function TkwPictureFormIeIO.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPictureFormIeIO.GetAllParamsCount

function TkwPictureFormIeIO.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TPictureForm)]);
end;//TkwPictureFormIeIO.ParamsTypes

type
  TkwPictureFormIeViewer = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TPictureForm.ieViewer
[panel]������� ieViewer ����� TPictureForm[panel]
*��� ����������:* TImageEnView
*������:*
[code]
OBJECT VAR l_TImageEnView
 aPictureForm .TPictureForm.ieViewer >>> l_TImageEnView
[code]  }
  private
  // private methods
   function IeViewer(const aCtx: TtfwContext;
     aPictureForm: TPictureForm): TImageEnView;
     {* ���������� ����� ������� .TPictureForm.ieViewer }
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
  end;//TkwPictureFormIeViewer

// start class TkwPictureFormIeViewer

function TkwPictureFormIeViewer.IeViewer(const aCtx: TtfwContext;
  aPictureForm: TPictureForm): TImageEnView;
 {-}
begin
 Result := aPictureForm.ieViewer;
end;//TkwPictureFormIeViewer.IeViewer

procedure TkwPictureFormIeViewer.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aPictureForm : TPictureForm;
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
 aCtx.rEngine.PushObj((IeViewer(aCtx, l_aPictureForm)));
end;//TkwPictureFormIeViewer.DoDoIt

class function TkwPictureFormIeViewer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TPictureForm.ieViewer';
end;//TkwPictureFormIeViewer.GetWordNameForRegister

procedure TkwPictureFormIeViewer.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ieViewer', aCtx);
end;//TkwPictureFormIeViewer.SetValuePrim

function TkwPictureFormIeViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TImageEnView);
end;//TkwPictureFormIeViewer.GetResultTypeInfo

function TkwPictureFormIeViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPictureFormIeViewer.GetAllParamsCount

function TkwPictureFormIeViewer.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TPictureForm)]);
end;//TkwPictureFormIeViewer.ParamsTypes

type
  TkwPictureFormIeProc = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TPictureForm.ieProc
[panel]������� ieProc ����� TPictureForm[panel]
*��� ����������:* TImageEnProc
*������:*
[code]
OBJECT VAR l_TImageEnProc
 aPictureForm .TPictureForm.ieProc >>> l_TImageEnProc
[code]  }
  private
  // private methods
   function IeProc(const aCtx: TtfwContext;
     aPictureForm: TPictureForm): TImageEnProc;
     {* ���������� ����� ������� .TPictureForm.ieProc }
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
  end;//TkwPictureFormIeProc

// start class TkwPictureFormIeProc

function TkwPictureFormIeProc.IeProc(const aCtx: TtfwContext;
  aPictureForm: TPictureForm): TImageEnProc;
 {-}
begin
 Result := aPictureForm.ieProc;
end;//TkwPictureFormIeProc.IeProc

procedure TkwPictureFormIeProc.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aPictureForm : TPictureForm;
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
 aCtx.rEngine.PushObj((IeProc(aCtx, l_aPictureForm)));
end;//TkwPictureFormIeProc.DoDoIt

class function TkwPictureFormIeProc.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TPictureForm.ieProc';
end;//TkwPictureFormIeProc.GetWordNameForRegister

procedure TkwPictureFormIeProc.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ieProc', aCtx);
end;//TkwPictureFormIeProc.SetValuePrim

function TkwPictureFormIeProc.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TImageEnProc);
end;//TkwPictureFormIeProc.GetResultTypeInfo

function TkwPictureFormIeProc.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPictureFormIeProc.GetAllParamsCount

function TkwPictureFormIeProc.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TPictureForm)]);
end;//TkwPictureFormIeProc.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_Picture
 Tkw_Form_Picture.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Picture_Component_ieIO
 Tkw_Picture_Component_ieIO.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Picture_Control_ieViewer
 Tkw_Picture_Control_ieViewer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Picture_Control_ieViewer_Push
 Tkw_Picture_Control_ieViewer_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Picture_Component_ieProc
 Tkw_Picture_Component_ieProc.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� PictureForm_ieIO
 TkwPictureFormIeIO.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� PictureForm_ieViewer
 TkwPictureFormIeViewer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� PictureForm_ieProc
 TkwPictureFormIeProc.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� Picture
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPictureForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TImageEnIO
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImageEnIO));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TImageEnView
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImageEnView));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TImageEnProc
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImageEnProc));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.