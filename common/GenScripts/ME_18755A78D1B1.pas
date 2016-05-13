unit ConsultationMarkKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� ConsultationMark }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\ConsultationMarkKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "ConsultationMarkKeywordsPack" MUID: (18755A78D1B1)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtGroupBox
 , vtRadioButton
 , vtPanel
 , vtLabel
 , eeMemoWithEditOperations
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , ConsultationMark_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , TypInfo
 , tfwTypeInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 Tkw_Form_ConsultationMark = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� ConsultationMark
----
*������ �������������*:
[code]
'aControl' �����::ConsultationMark TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_ConsultationMark

 Tkw_ConsultationMark_Control_gbMark = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� gbMark
----
*������ �������������*:
[code]
�������::gbMark TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_gbMark

 Tkw_ConsultationMark_Control_gbMark_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� gbMark
----
*������ �������������*:
[code]
�������::gbMark:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_gbMark_Push

 Tkw_ConsultationMark_Control_rbNotSure = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� rbNotSure
----
*������ �������������*:
[code]
�������::rbNotSure TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_rbNotSure

 Tkw_ConsultationMark_Control_rbNotSure_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� rbNotSure
----
*������ �������������*:
[code]
�������::rbNotSure:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_rbNotSure_Push

 Tkw_ConsultationMark_Control_rbTwo = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� rbTwo
----
*������ �������������*:
[code]
�������::rbTwo TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_rbTwo

 Tkw_ConsultationMark_Control_rbTwo_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� rbTwo
----
*������ �������������*:
[code]
�������::rbTwo:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_rbTwo_Push

 Tkw_ConsultationMark_Control_rbThree = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� rbThree
----
*������ �������������*:
[code]
�������::rbThree TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_rbThree

 Tkw_ConsultationMark_Control_rbThree_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� rbThree
----
*������ �������������*:
[code]
�������::rbThree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_rbThree_Push

 Tkw_ConsultationMark_Control_rbFour = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� rbFour
----
*������ �������������*:
[code]
�������::rbFour TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_rbFour

 Tkw_ConsultationMark_Control_rbFour_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� rbFour
----
*������ �������������*:
[code]
�������::rbFour:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_rbFour_Push

 Tkw_ConsultationMark_Control_rbFive = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� rbFive
----
*������ �������������*:
[code]
�������::rbFive TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_rbFive

 Tkw_ConsultationMark_Control_rbFive_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� rbFive
----
*������ �������������*:
[code]
�������::rbFive:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_rbFive_Push

 Tkw_ConsultationMark_Control_pnlHelp = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlHelp
----
*������ �������������*:
[code]
�������::pnlHelp TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_pnlHelp

 Tkw_ConsultationMark_Control_pnlHelp_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnlHelp
----
*������ �������������*:
[code]
�������::pnlHelp:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_pnlHelp_Push

 Tkw_ConsultationMark_Control_lblHelp = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblHelp
----
*������ �������������*:
[code]
�������::lblHelp TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_lblHelp

 Tkw_ConsultationMark_Control_lblHelp_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� lblHelp
----
*������ �������������*:
[code]
�������::lblHelp:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_lblHelp_Push

 Tkw_ConsultationMark_Control_gbComment = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� gbComment
----
*������ �������������*:
[code]
�������::gbComment TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_gbComment

 Tkw_ConsultationMark_Control_gbComment_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� gbComment
----
*������ �������������*:
[code]
�������::gbComment:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_gbComment_Push

 Tkw_ConsultationMark_Control_mComment = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� mComment
----
*������ �������������*:
[code]
�������::mComment TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_mComment

 Tkw_ConsultationMark_Control_mComment_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� mComment
----
*������ �������������*:
[code]
�������::mComment:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConsultationMark_Control_mComment_Push

 TkwEnConsultationMarkGbMark = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConsultationMark.gbMark }
  private
   function gbMark(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TvtGroupBox;
    {* ���������� ����� ������� .Ten_ConsultationMark.gbMark }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnConsultationMarkGbMark

 TkwEnConsultationMarkRbNotSure = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConsultationMark.rbNotSure }
  private
   function rbNotSure(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
    {* ���������� ����� ������� .Ten_ConsultationMark.rbNotSure }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnConsultationMarkRbNotSure

 TkwEnConsultationMarkRbTwo = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConsultationMark.rbTwo }
  private
   function rbTwo(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
    {* ���������� ����� ������� .Ten_ConsultationMark.rbTwo }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnConsultationMarkRbTwo

 TkwEnConsultationMarkRbThree = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConsultationMark.rbThree }
  private
   function rbThree(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
    {* ���������� ����� ������� .Ten_ConsultationMark.rbThree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnConsultationMarkRbThree

 TkwEnConsultationMarkRbFour = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConsultationMark.rbFour }
  private
   function rbFour(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
    {* ���������� ����� ������� .Ten_ConsultationMark.rbFour }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnConsultationMarkRbFour

 TkwEnConsultationMarkRbFive = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConsultationMark.rbFive }
  private
   function rbFive(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
    {* ���������� ����� ������� .Ten_ConsultationMark.rbFive }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnConsultationMarkRbFive

 TkwEnConsultationMarkPnlHelp = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConsultationMark.pnlHelp }
  private
   function pnlHelp(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TvtPanel;
    {* ���������� ����� ������� .Ten_ConsultationMark.pnlHelp }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnConsultationMarkPnlHelp

 TkwEnConsultationMarkLblHelp = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConsultationMark.lblHelp }
  private
   function lblHelp(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TvtLabel;
    {* ���������� ����� ������� .Ten_ConsultationMark.lblHelp }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnConsultationMarkLblHelp

 TkwEnConsultationMarkGbComment = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConsultationMark.gbComment }
  private
   function gbComment(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TvtGroupBox;
    {* ���������� ����� ������� .Ten_ConsultationMark.gbComment }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnConsultationMarkGbComment

 TkwEnConsultationMarkMComment = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConsultationMark.mComment }
  private
   function mComment(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TeeMemoWithEditOperations;
    {* ���������� ����� ������� .Ten_ConsultationMark.mComment }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnConsultationMarkMComment

function Tkw_Form_ConsultationMark.GetString: AnsiString;
begin
 Result := 'en_ConsultationMark';
end;//Tkw_Form_ConsultationMark.GetString

class function Tkw_Form_ConsultationMark.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::ConsultationMark';
end;//Tkw_Form_ConsultationMark.GetWordNameForRegister

function Tkw_ConsultationMark_Control_gbMark.GetString: AnsiString;
begin
 Result := 'gbMark';
end;//Tkw_ConsultationMark_Control_gbMark.GetString

class procedure Tkw_ConsultationMark_Control_gbMark.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_ConsultationMark_Control_gbMark.RegisterInEngine

class function Tkw_ConsultationMark_Control_gbMark.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbMark';
end;//Tkw_ConsultationMark_Control_gbMark.GetWordNameForRegister

procedure Tkw_ConsultationMark_Control_gbMark_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('gbMark');
 inherited;
end;//Tkw_ConsultationMark_Control_gbMark_Push.DoDoIt

class function Tkw_ConsultationMark_Control_gbMark_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbMark:push';
end;//Tkw_ConsultationMark_Control_gbMark_Push.GetWordNameForRegister

function Tkw_ConsultationMark_Control_rbNotSure.GetString: AnsiString;
begin
 Result := 'rbNotSure';
end;//Tkw_ConsultationMark_Control_rbNotSure.GetString

class procedure Tkw_ConsultationMark_Control_rbNotSure.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_ConsultationMark_Control_rbNotSure.RegisterInEngine

class function Tkw_ConsultationMark_Control_rbNotSure.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbNotSure';
end;//Tkw_ConsultationMark_Control_rbNotSure.GetWordNameForRegister

procedure Tkw_ConsultationMark_Control_rbNotSure_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('rbNotSure');
 inherited;
end;//Tkw_ConsultationMark_Control_rbNotSure_Push.DoDoIt

class function Tkw_ConsultationMark_Control_rbNotSure_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbNotSure:push';
end;//Tkw_ConsultationMark_Control_rbNotSure_Push.GetWordNameForRegister

function Tkw_ConsultationMark_Control_rbTwo.GetString: AnsiString;
begin
 Result := 'rbTwo';
end;//Tkw_ConsultationMark_Control_rbTwo.GetString

class procedure Tkw_ConsultationMark_Control_rbTwo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_ConsultationMark_Control_rbTwo.RegisterInEngine

class function Tkw_ConsultationMark_Control_rbTwo.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbTwo';
end;//Tkw_ConsultationMark_Control_rbTwo.GetWordNameForRegister

procedure Tkw_ConsultationMark_Control_rbTwo_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('rbTwo');
 inherited;
end;//Tkw_ConsultationMark_Control_rbTwo_Push.DoDoIt

class function Tkw_ConsultationMark_Control_rbTwo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbTwo:push';
end;//Tkw_ConsultationMark_Control_rbTwo_Push.GetWordNameForRegister

function Tkw_ConsultationMark_Control_rbThree.GetString: AnsiString;
begin
 Result := 'rbThree';
end;//Tkw_ConsultationMark_Control_rbThree.GetString

class procedure Tkw_ConsultationMark_Control_rbThree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_ConsultationMark_Control_rbThree.RegisterInEngine

class function Tkw_ConsultationMark_Control_rbThree.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbThree';
end;//Tkw_ConsultationMark_Control_rbThree.GetWordNameForRegister

procedure Tkw_ConsultationMark_Control_rbThree_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('rbThree');
 inherited;
end;//Tkw_ConsultationMark_Control_rbThree_Push.DoDoIt

class function Tkw_ConsultationMark_Control_rbThree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbThree:push';
end;//Tkw_ConsultationMark_Control_rbThree_Push.GetWordNameForRegister

function Tkw_ConsultationMark_Control_rbFour.GetString: AnsiString;
begin
 Result := 'rbFour';
end;//Tkw_ConsultationMark_Control_rbFour.GetString

class procedure Tkw_ConsultationMark_Control_rbFour.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_ConsultationMark_Control_rbFour.RegisterInEngine

class function Tkw_ConsultationMark_Control_rbFour.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbFour';
end;//Tkw_ConsultationMark_Control_rbFour.GetWordNameForRegister

procedure Tkw_ConsultationMark_Control_rbFour_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('rbFour');
 inherited;
end;//Tkw_ConsultationMark_Control_rbFour_Push.DoDoIt

class function Tkw_ConsultationMark_Control_rbFour_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbFour:push';
end;//Tkw_ConsultationMark_Control_rbFour_Push.GetWordNameForRegister

function Tkw_ConsultationMark_Control_rbFive.GetString: AnsiString;
begin
 Result := 'rbFive';
end;//Tkw_ConsultationMark_Control_rbFive.GetString

class procedure Tkw_ConsultationMark_Control_rbFive.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_ConsultationMark_Control_rbFive.RegisterInEngine

class function Tkw_ConsultationMark_Control_rbFive.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbFive';
end;//Tkw_ConsultationMark_Control_rbFive.GetWordNameForRegister

procedure Tkw_ConsultationMark_Control_rbFive_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('rbFive');
 inherited;
end;//Tkw_ConsultationMark_Control_rbFive_Push.DoDoIt

class function Tkw_ConsultationMark_Control_rbFive_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbFive:push';
end;//Tkw_ConsultationMark_Control_rbFive_Push.GetWordNameForRegister

function Tkw_ConsultationMark_Control_pnlHelp.GetString: AnsiString;
begin
 Result := 'pnlHelp';
end;//Tkw_ConsultationMark_Control_pnlHelp.GetString

class procedure Tkw_ConsultationMark_Control_pnlHelp.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ConsultationMark_Control_pnlHelp.RegisterInEngine

class function Tkw_ConsultationMark_Control_pnlHelp.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlHelp';
end;//Tkw_ConsultationMark_Control_pnlHelp.GetWordNameForRegister

procedure Tkw_ConsultationMark_Control_pnlHelp_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlHelp');
 inherited;
end;//Tkw_ConsultationMark_Control_pnlHelp_Push.DoDoIt

class function Tkw_ConsultationMark_Control_pnlHelp_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlHelp:push';
end;//Tkw_ConsultationMark_Control_pnlHelp_Push.GetWordNameForRegister

function Tkw_ConsultationMark_Control_lblHelp.GetString: AnsiString;
begin
 Result := 'lblHelp';
end;//Tkw_ConsultationMark_Control_lblHelp.GetString

class procedure Tkw_ConsultationMark_Control_lblHelp.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_ConsultationMark_Control_lblHelp.RegisterInEngine

class function Tkw_ConsultationMark_Control_lblHelp.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblHelp';
end;//Tkw_ConsultationMark_Control_lblHelp.GetWordNameForRegister

procedure Tkw_ConsultationMark_Control_lblHelp_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblHelp');
 inherited;
end;//Tkw_ConsultationMark_Control_lblHelp_Push.DoDoIt

class function Tkw_ConsultationMark_Control_lblHelp_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblHelp:push';
end;//Tkw_ConsultationMark_Control_lblHelp_Push.GetWordNameForRegister

function Tkw_ConsultationMark_Control_gbComment.GetString: AnsiString;
begin
 Result := 'gbComment';
end;//Tkw_ConsultationMark_Control_gbComment.GetString

class procedure Tkw_ConsultationMark_Control_gbComment.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_ConsultationMark_Control_gbComment.RegisterInEngine

class function Tkw_ConsultationMark_Control_gbComment.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbComment';
end;//Tkw_ConsultationMark_Control_gbComment.GetWordNameForRegister

procedure Tkw_ConsultationMark_Control_gbComment_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('gbComment');
 inherited;
end;//Tkw_ConsultationMark_Control_gbComment_Push.DoDoIt

class function Tkw_ConsultationMark_Control_gbComment_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbComment:push';
end;//Tkw_ConsultationMark_Control_gbComment_Push.GetWordNameForRegister

function Tkw_ConsultationMark_Control_mComment.GetString: AnsiString;
begin
 Result := 'mComment';
end;//Tkw_ConsultationMark_Control_mComment.GetString

class procedure Tkw_ConsultationMark_Control_mComment.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeMemoWithEditOperations);
end;//Tkw_ConsultationMark_Control_mComment.RegisterInEngine

class function Tkw_ConsultationMark_Control_mComment.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::mComment';
end;//Tkw_ConsultationMark_Control_mComment.GetWordNameForRegister

procedure Tkw_ConsultationMark_Control_mComment_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('mComment');
 inherited;
end;//Tkw_ConsultationMark_Control_mComment_Push.DoDoIt

class function Tkw_ConsultationMark_Control_mComment_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::mComment:push';
end;//Tkw_ConsultationMark_Control_mComment_Push.GetWordNameForRegister

function TkwEnConsultationMarkGbMark.gbMark(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TvtGroupBox;
 {* ���������� ����� ������� .Ten_ConsultationMark.gbMark }
begin
 Result := aen_ConsultationMark.gbMark;
end;//TkwEnConsultationMarkGbMark.gbMark

procedure TkwEnConsultationMarkGbMark.DoDoIt(const aCtx: TtfwContext);
var l_aen_ConsultationMark: Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(gbMark(aCtx, l_aen_ConsultationMark));
end;//TkwEnConsultationMarkGbMark.DoDoIt

class function TkwEnConsultationMarkGbMark.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.gbMark';
end;//TkwEnConsultationMarkGbMark.GetWordNameForRegister

function TkwEnConsultationMarkGbMark.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwEnConsultationMarkGbMark.GetResultTypeInfo

function TkwEnConsultationMarkGbMark.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnConsultationMarkGbMark.GetAllParamsCount

function TkwEnConsultationMarkGbMark.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkGbMark.ParamsTypes

procedure TkwEnConsultationMarkGbMark.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� gbMark', aCtx);
end;//TkwEnConsultationMarkGbMark.SetValuePrim

function TkwEnConsultationMarkRbNotSure.rbNotSure(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
 {* ���������� ����� ������� .Ten_ConsultationMark.rbNotSure }
begin
 Result := aen_ConsultationMark.rbNotSure;
end;//TkwEnConsultationMarkRbNotSure.rbNotSure

procedure TkwEnConsultationMarkRbNotSure.DoDoIt(const aCtx: TtfwContext);
var l_aen_ConsultationMark: Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(rbNotSure(aCtx, l_aen_ConsultationMark));
end;//TkwEnConsultationMarkRbNotSure.DoDoIt

class function TkwEnConsultationMarkRbNotSure.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.rbNotSure';
end;//TkwEnConsultationMarkRbNotSure.GetWordNameForRegister

function TkwEnConsultationMarkRbNotSure.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnConsultationMarkRbNotSure.GetResultTypeInfo

function TkwEnConsultationMarkRbNotSure.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnConsultationMarkRbNotSure.GetAllParamsCount

function TkwEnConsultationMarkRbNotSure.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkRbNotSure.ParamsTypes

procedure TkwEnConsultationMarkRbNotSure.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� rbNotSure', aCtx);
end;//TkwEnConsultationMarkRbNotSure.SetValuePrim

function TkwEnConsultationMarkRbTwo.rbTwo(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
 {* ���������� ����� ������� .Ten_ConsultationMark.rbTwo }
begin
 Result := aen_ConsultationMark.rbTwo;
end;//TkwEnConsultationMarkRbTwo.rbTwo

procedure TkwEnConsultationMarkRbTwo.DoDoIt(const aCtx: TtfwContext);
var l_aen_ConsultationMark: Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(rbTwo(aCtx, l_aen_ConsultationMark));
end;//TkwEnConsultationMarkRbTwo.DoDoIt

class function TkwEnConsultationMarkRbTwo.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.rbTwo';
end;//TkwEnConsultationMarkRbTwo.GetWordNameForRegister

function TkwEnConsultationMarkRbTwo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnConsultationMarkRbTwo.GetResultTypeInfo

function TkwEnConsultationMarkRbTwo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnConsultationMarkRbTwo.GetAllParamsCount

function TkwEnConsultationMarkRbTwo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkRbTwo.ParamsTypes

procedure TkwEnConsultationMarkRbTwo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� rbTwo', aCtx);
end;//TkwEnConsultationMarkRbTwo.SetValuePrim

function TkwEnConsultationMarkRbThree.rbThree(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
 {* ���������� ����� ������� .Ten_ConsultationMark.rbThree }
begin
 Result := aen_ConsultationMark.rbThree;
end;//TkwEnConsultationMarkRbThree.rbThree

procedure TkwEnConsultationMarkRbThree.DoDoIt(const aCtx: TtfwContext);
var l_aen_ConsultationMark: Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(rbThree(aCtx, l_aen_ConsultationMark));
end;//TkwEnConsultationMarkRbThree.DoDoIt

class function TkwEnConsultationMarkRbThree.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.rbThree';
end;//TkwEnConsultationMarkRbThree.GetWordNameForRegister

function TkwEnConsultationMarkRbThree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnConsultationMarkRbThree.GetResultTypeInfo

function TkwEnConsultationMarkRbThree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnConsultationMarkRbThree.GetAllParamsCount

function TkwEnConsultationMarkRbThree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkRbThree.ParamsTypes

procedure TkwEnConsultationMarkRbThree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� rbThree', aCtx);
end;//TkwEnConsultationMarkRbThree.SetValuePrim

function TkwEnConsultationMarkRbFour.rbFour(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
 {* ���������� ����� ������� .Ten_ConsultationMark.rbFour }
begin
 Result := aen_ConsultationMark.rbFour;
end;//TkwEnConsultationMarkRbFour.rbFour

procedure TkwEnConsultationMarkRbFour.DoDoIt(const aCtx: TtfwContext);
var l_aen_ConsultationMark: Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(rbFour(aCtx, l_aen_ConsultationMark));
end;//TkwEnConsultationMarkRbFour.DoDoIt

class function TkwEnConsultationMarkRbFour.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.rbFour';
end;//TkwEnConsultationMarkRbFour.GetWordNameForRegister

function TkwEnConsultationMarkRbFour.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnConsultationMarkRbFour.GetResultTypeInfo

function TkwEnConsultationMarkRbFour.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnConsultationMarkRbFour.GetAllParamsCount

function TkwEnConsultationMarkRbFour.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkRbFour.ParamsTypes

procedure TkwEnConsultationMarkRbFour.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� rbFour', aCtx);
end;//TkwEnConsultationMarkRbFour.SetValuePrim

function TkwEnConsultationMarkRbFive.rbFive(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
 {* ���������� ����� ������� .Ten_ConsultationMark.rbFive }
begin
 Result := aen_ConsultationMark.rbFive;
end;//TkwEnConsultationMarkRbFive.rbFive

procedure TkwEnConsultationMarkRbFive.DoDoIt(const aCtx: TtfwContext);
var l_aen_ConsultationMark: Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(rbFive(aCtx, l_aen_ConsultationMark));
end;//TkwEnConsultationMarkRbFive.DoDoIt

class function TkwEnConsultationMarkRbFive.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.rbFive';
end;//TkwEnConsultationMarkRbFive.GetWordNameForRegister

function TkwEnConsultationMarkRbFive.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnConsultationMarkRbFive.GetResultTypeInfo

function TkwEnConsultationMarkRbFive.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnConsultationMarkRbFive.GetAllParamsCount

function TkwEnConsultationMarkRbFive.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkRbFive.ParamsTypes

procedure TkwEnConsultationMarkRbFive.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� rbFive', aCtx);
end;//TkwEnConsultationMarkRbFive.SetValuePrim

function TkwEnConsultationMarkPnlHelp.pnlHelp(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TvtPanel;
 {* ���������� ����� ������� .Ten_ConsultationMark.pnlHelp }
begin
 Result := aen_ConsultationMark.pnlHelp;
end;//TkwEnConsultationMarkPnlHelp.pnlHelp

procedure TkwEnConsultationMarkPnlHelp.DoDoIt(const aCtx: TtfwContext);
var l_aen_ConsultationMark: Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlHelp(aCtx, l_aen_ConsultationMark));
end;//TkwEnConsultationMarkPnlHelp.DoDoIt

class function TkwEnConsultationMarkPnlHelp.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.pnlHelp';
end;//TkwEnConsultationMarkPnlHelp.GetWordNameForRegister

function TkwEnConsultationMarkPnlHelp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnConsultationMarkPnlHelp.GetResultTypeInfo

function TkwEnConsultationMarkPnlHelp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnConsultationMarkPnlHelp.GetAllParamsCount

function TkwEnConsultationMarkPnlHelp.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkPnlHelp.ParamsTypes

procedure TkwEnConsultationMarkPnlHelp.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlHelp', aCtx);
end;//TkwEnConsultationMarkPnlHelp.SetValuePrim

function TkwEnConsultationMarkLblHelp.lblHelp(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TvtLabel;
 {* ���������� ����� ������� .Ten_ConsultationMark.lblHelp }
begin
 Result := aen_ConsultationMark.lblHelp;
end;//TkwEnConsultationMarkLblHelp.lblHelp

procedure TkwEnConsultationMarkLblHelp.DoDoIt(const aCtx: TtfwContext);
var l_aen_ConsultationMark: Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblHelp(aCtx, l_aen_ConsultationMark));
end;//TkwEnConsultationMarkLblHelp.DoDoIt

class function TkwEnConsultationMarkLblHelp.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.lblHelp';
end;//TkwEnConsultationMarkLblHelp.GetWordNameForRegister

function TkwEnConsultationMarkLblHelp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnConsultationMarkLblHelp.GetResultTypeInfo

function TkwEnConsultationMarkLblHelp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnConsultationMarkLblHelp.GetAllParamsCount

function TkwEnConsultationMarkLblHelp.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkLblHelp.ParamsTypes

procedure TkwEnConsultationMarkLblHelp.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblHelp', aCtx);
end;//TkwEnConsultationMarkLblHelp.SetValuePrim

function TkwEnConsultationMarkGbComment.gbComment(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TvtGroupBox;
 {* ���������� ����� ������� .Ten_ConsultationMark.gbComment }
begin
 Result := aen_ConsultationMark.gbComment;
end;//TkwEnConsultationMarkGbComment.gbComment

procedure TkwEnConsultationMarkGbComment.DoDoIt(const aCtx: TtfwContext);
var l_aen_ConsultationMark: Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(gbComment(aCtx, l_aen_ConsultationMark));
end;//TkwEnConsultationMarkGbComment.DoDoIt

class function TkwEnConsultationMarkGbComment.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.gbComment';
end;//TkwEnConsultationMarkGbComment.GetWordNameForRegister

function TkwEnConsultationMarkGbComment.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwEnConsultationMarkGbComment.GetResultTypeInfo

function TkwEnConsultationMarkGbComment.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnConsultationMarkGbComment.GetAllParamsCount

function TkwEnConsultationMarkGbComment.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkGbComment.ParamsTypes

procedure TkwEnConsultationMarkGbComment.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� gbComment', aCtx);
end;//TkwEnConsultationMarkGbComment.SetValuePrim

function TkwEnConsultationMarkMComment.mComment(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TeeMemoWithEditOperations;
 {* ���������� ����� ������� .Ten_ConsultationMark.mComment }
begin
 Result := aen_ConsultationMark.mComment;
end;//TkwEnConsultationMarkMComment.mComment

procedure TkwEnConsultationMarkMComment.DoDoIt(const aCtx: TtfwContext);
var l_aen_ConsultationMark: Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(mComment(aCtx, l_aen_ConsultationMark));
end;//TkwEnConsultationMarkMComment.DoDoIt

class function TkwEnConsultationMarkMComment.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.mComment';
end;//TkwEnConsultationMarkMComment.GetWordNameForRegister

function TkwEnConsultationMarkMComment.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeMemoWithEditOperations);
end;//TkwEnConsultationMarkMComment.GetResultTypeInfo

function TkwEnConsultationMarkMComment.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnConsultationMarkMComment.GetAllParamsCount

function TkwEnConsultationMarkMComment.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkMComment.ParamsTypes

procedure TkwEnConsultationMarkMComment.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� mComment', aCtx);
end;//TkwEnConsultationMarkMComment.SetValuePrim

initialization
 Tkw_Form_ConsultationMark.RegisterInEngine;
 {* ����������� Tkw_Form_ConsultationMark }
 Tkw_ConsultationMark_Control_gbMark.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_gbMark }
 Tkw_ConsultationMark_Control_gbMark_Push.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_gbMark_Push }
 Tkw_ConsultationMark_Control_rbNotSure.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_rbNotSure }
 Tkw_ConsultationMark_Control_rbNotSure_Push.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_rbNotSure_Push }
 Tkw_ConsultationMark_Control_rbTwo.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_rbTwo }
 Tkw_ConsultationMark_Control_rbTwo_Push.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_rbTwo_Push }
 Tkw_ConsultationMark_Control_rbThree.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_rbThree }
 Tkw_ConsultationMark_Control_rbThree_Push.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_rbThree_Push }
 Tkw_ConsultationMark_Control_rbFour.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_rbFour }
 Tkw_ConsultationMark_Control_rbFour_Push.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_rbFour_Push }
 Tkw_ConsultationMark_Control_rbFive.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_rbFive }
 Tkw_ConsultationMark_Control_rbFive_Push.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_rbFive_Push }
 Tkw_ConsultationMark_Control_pnlHelp.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_pnlHelp }
 Tkw_ConsultationMark_Control_pnlHelp_Push.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_pnlHelp_Push }
 Tkw_ConsultationMark_Control_lblHelp.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_lblHelp }
 Tkw_ConsultationMark_Control_lblHelp_Push.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_lblHelp_Push }
 Tkw_ConsultationMark_Control_gbComment.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_gbComment }
 Tkw_ConsultationMark_Control_gbComment_Push.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_gbComment_Push }
 Tkw_ConsultationMark_Control_mComment.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_mComment }
 Tkw_ConsultationMark_Control_mComment_Push.RegisterInEngine;
 {* ����������� Tkw_ConsultationMark_Control_mComment_Push }
 TkwEnConsultationMarkGbMark.RegisterInEngine;
 {* ����������� en_ConsultationMark_gbMark }
 TkwEnConsultationMarkRbNotSure.RegisterInEngine;
 {* ����������� en_ConsultationMark_rbNotSure }
 TkwEnConsultationMarkRbTwo.RegisterInEngine;
 {* ����������� en_ConsultationMark_rbTwo }
 TkwEnConsultationMarkRbThree.RegisterInEngine;
 {* ����������� en_ConsultationMark_rbThree }
 TkwEnConsultationMarkRbFour.RegisterInEngine;
 {* ����������� en_ConsultationMark_rbFour }
 TkwEnConsultationMarkRbFive.RegisterInEngine;
 {* ����������� en_ConsultationMark_rbFive }
 TkwEnConsultationMarkPnlHelp.RegisterInEngine;
 {* ����������� en_ConsultationMark_pnlHelp }
 TkwEnConsultationMarkLblHelp.RegisterInEngine;
 {* ����������� en_ConsultationMark_lblHelp }
 TkwEnConsultationMarkGbComment.RegisterInEngine;
 {* ����������� en_ConsultationMark_gbComment }
 TkwEnConsultationMarkMComment.RegisterInEngine;
 {* ����������� en_ConsultationMark_mComment }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_ConsultationMark));
 {* ����������� ���� Ten_ConsultationMark }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGroupBox));
 {* ����������� ���� TvtGroupBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtRadioButton));
 {* ����������� ���� TvtRadioButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeMemoWithEditOperations));
 {* ����������� ���� TeeMemoWithEditOperations }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
