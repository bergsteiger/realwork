unit ConsultationMarkKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� ConsultationMark }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\ConsultationMarkKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Consultation_Module
 , vtGroupBox
 , vtRadioButton
 , vtPanel
 , vtLabel
 , eeMemoWithEditOperations
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
 Tkw_Form_ConsultationMark = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� ConsultationMark
----
*������ �������������*:
[code]
'aControl' �����::ConsultationMark TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_ConsultationMark

 Tkw_ConsultationMark_Control_gbMark = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� gbMark
----
*������ �������������*:
[code]
�������::gbMark TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ConsultationMark_Control_gbMark

 Tkw_ConsultationMark_Control_gbMark_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ConsultationMark_Control_rbNotSure

 Tkw_ConsultationMark_Control_rbNotSure_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ConsultationMark_Control_rbTwo

 Tkw_ConsultationMark_Control_rbTwo_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ConsultationMark_Control_rbThree

 Tkw_ConsultationMark_Control_rbThree_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ConsultationMark_Control_rbFour

 Tkw_ConsultationMark_Control_rbFour_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ConsultationMark_Control_rbFive

 Tkw_ConsultationMark_Control_rbFive_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ConsultationMark_Control_pnlHelp

 Tkw_ConsultationMark_Control_pnlHelp_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ConsultationMark_Control_lblHelp

 Tkw_ConsultationMark_Control_lblHelp_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ConsultationMark_Control_gbComment

 Tkw_ConsultationMark_Control_gbComment_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ConsultationMark_Control_mComment

 Tkw_ConsultationMark_Control_mComment_Push = {final} class(TkwBynameControlPush)
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
  {* ����� ������� .Ten_ConsultationMark.gbMark
[panel]������� gbMark ����� Ten_ConsultationMark[panel]
*��� ����������:* TvtGroupBox
*������:*
[code]
OBJECT VAR l_TvtGroupBox
 aen_ConsultationMark .Ten_ConsultationMark.gbMark >>> l_TvtGroupBox
[code]  }
  private
   function gbMark(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TvtGroupBox;
    {* ���������� ����� ������� .Ten_ConsultationMark.gbMark }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnConsultationMarkGbMark

 TkwEnConsultationMarkRbNotSure = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConsultationMark.rbNotSure
[panel]������� rbNotSure ����� Ten_ConsultationMark[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_ConsultationMark .Ten_ConsultationMark.rbNotSure >>> l_TvtRadioButton
[code]  }
  private
   function rbNotSure(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
    {* ���������� ����� ������� .Ten_ConsultationMark.rbNotSure }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnConsultationMarkRbNotSure

 TkwEnConsultationMarkRbTwo = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConsultationMark.rbTwo
[panel]������� rbTwo ����� Ten_ConsultationMark[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_ConsultationMark .Ten_ConsultationMark.rbTwo >>> l_TvtRadioButton
[code]  }
  private
   function rbTwo(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
    {* ���������� ����� ������� .Ten_ConsultationMark.rbTwo }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnConsultationMarkRbTwo

 TkwEnConsultationMarkRbThree = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConsultationMark.rbThree
[panel]������� rbThree ����� Ten_ConsultationMark[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_ConsultationMark .Ten_ConsultationMark.rbThree >>> l_TvtRadioButton
[code]  }
  private
   function rbThree(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
    {* ���������� ����� ������� .Ten_ConsultationMark.rbThree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnConsultationMarkRbThree

 TkwEnConsultationMarkRbFour = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConsultationMark.rbFour
[panel]������� rbFour ����� Ten_ConsultationMark[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_ConsultationMark .Ten_ConsultationMark.rbFour >>> l_TvtRadioButton
[code]  }
  private
   function rbFour(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
    {* ���������� ����� ������� .Ten_ConsultationMark.rbFour }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnConsultationMarkRbFour

 TkwEnConsultationMarkRbFive = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConsultationMark.rbFive
[panel]������� rbFive ����� Ten_ConsultationMark[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_ConsultationMark .Ten_ConsultationMark.rbFive >>> l_TvtRadioButton
[code]  }
  private
   function rbFive(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
    {* ���������� ����� ������� .Ten_ConsultationMark.rbFive }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnConsultationMarkRbFive

 TkwEnConsultationMarkPnlHelp = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConsultationMark.pnlHelp
[panel]������� pnlHelp ����� Ten_ConsultationMark[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aen_ConsultationMark .Ten_ConsultationMark.pnlHelp >>> l_TvtPanel
[code]  }
  private
   function pnlHelp(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TvtPanel;
    {* ���������� ����� ������� .Ten_ConsultationMark.pnlHelp }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnConsultationMarkPnlHelp

 TkwEnConsultationMarkLblHelp = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConsultationMark.lblHelp
[panel]������� lblHelp ����� Ten_ConsultationMark[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aen_ConsultationMark .Ten_ConsultationMark.lblHelp >>> l_TvtLabel
[code]  }
  private
   function lblHelp(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TvtLabel;
    {* ���������� ����� ������� .Ten_ConsultationMark.lblHelp }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnConsultationMarkLblHelp

 TkwEnConsultationMarkGbComment = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConsultationMark.gbComment
[panel]������� gbComment ����� Ten_ConsultationMark[panel]
*��� ����������:* TvtGroupBox
*������:*
[code]
OBJECT VAR l_TvtGroupBox
 aen_ConsultationMark .Ten_ConsultationMark.gbComment >>> l_TvtGroupBox
[code]  }
  private
   function gbComment(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TvtGroupBox;
    {* ���������� ����� ������� .Ten_ConsultationMark.gbComment }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnConsultationMarkGbComment

 TkwEnConsultationMarkMComment = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConsultationMark.mComment
[panel]������� mComment ����� Ten_ConsultationMark[panel]
*��� ����������:* TeeMemoWithEditOperations
*������:*
[code]
OBJECT VAR l_TeeMemoWithEditOperations
 aen_ConsultationMark .Ten_ConsultationMark.mComment >>> l_TeeMemoWithEditOperations
[code]  }
  private
   function mComment(const aCtx: TtfwContext;
    aen_ConsultationMark: Ten_ConsultationMark): TeeMemoWithEditOperations;
    {* ���������� ����� ������� .Ten_ConsultationMark.mComment }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnConsultationMarkMComment

class function Tkw_Form_ConsultationMark.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::ConsultationMark';
end;//Tkw_Form_ConsultationMark.GetWordNameForRegister

function Tkw_Form_ConsultationMark.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_0086675B6B83_var*
//#UC END# *4DDFD2EA0116_0086675B6B83_var*
begin
//#UC START# *4DDFD2EA0116_0086675B6B83_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_0086675B6B83_impl*
end;//Tkw_Form_ConsultationMark.GetString

class function Tkw_ConsultationMark_Control_gbMark.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbMark';
end;//Tkw_ConsultationMark_Control_gbMark.GetWordNameForRegister

function Tkw_ConsultationMark_Control_gbMark.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_118FE6A612B7_var*
//#UC END# *4DDFD2EA0116_118FE6A612B7_var*
begin
//#UC START# *4DDFD2EA0116_118FE6A612B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_118FE6A612B7_impl*
end;//Tkw_ConsultationMark_Control_gbMark.GetString

class procedure Tkw_ConsultationMark_Control_gbMark.RegisterInEngine;
//#UC START# *52A086150180_118FE6A612B7_var*
//#UC END# *52A086150180_118FE6A612B7_var*
begin
//#UC START# *52A086150180_118FE6A612B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_118FE6A612B7_impl*
end;//Tkw_ConsultationMark_Control_gbMark.RegisterInEngine

procedure Tkw_ConsultationMark_Control_gbMark_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8B30EAB1C18A_var*
//#UC END# *4DAEEDE10285_8B30EAB1C18A_var*
begin
//#UC START# *4DAEEDE10285_8B30EAB1C18A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8B30EAB1C18A_impl*
end;//Tkw_ConsultationMark_Control_gbMark_Push.DoDoIt

class function Tkw_ConsultationMark_Control_gbMark_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbMark:push';
end;//Tkw_ConsultationMark_Control_gbMark_Push.GetWordNameForRegister

class function Tkw_ConsultationMark_Control_rbNotSure.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbNotSure';
end;//Tkw_ConsultationMark_Control_rbNotSure.GetWordNameForRegister

function Tkw_ConsultationMark_Control_rbNotSure.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7B79325E0A7A_var*
//#UC END# *4DDFD2EA0116_7B79325E0A7A_var*
begin
//#UC START# *4DDFD2EA0116_7B79325E0A7A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7B79325E0A7A_impl*
end;//Tkw_ConsultationMark_Control_rbNotSure.GetString

class procedure Tkw_ConsultationMark_Control_rbNotSure.RegisterInEngine;
//#UC START# *52A086150180_7B79325E0A7A_var*
//#UC END# *52A086150180_7B79325E0A7A_var*
begin
//#UC START# *52A086150180_7B79325E0A7A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7B79325E0A7A_impl*
end;//Tkw_ConsultationMark_Control_rbNotSure.RegisterInEngine

procedure Tkw_ConsultationMark_Control_rbNotSure_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DD80E9E3BC24_var*
//#UC END# *4DAEEDE10285_DD80E9E3BC24_var*
begin
//#UC START# *4DAEEDE10285_DD80E9E3BC24_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DD80E9E3BC24_impl*
end;//Tkw_ConsultationMark_Control_rbNotSure_Push.DoDoIt

class function Tkw_ConsultationMark_Control_rbNotSure_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbNotSure:push';
end;//Tkw_ConsultationMark_Control_rbNotSure_Push.GetWordNameForRegister

class function Tkw_ConsultationMark_Control_rbTwo.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbTwo';
end;//Tkw_ConsultationMark_Control_rbTwo.GetWordNameForRegister

function Tkw_ConsultationMark_Control_rbTwo.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_EA306136E4F7_var*
//#UC END# *4DDFD2EA0116_EA306136E4F7_var*
begin
//#UC START# *4DDFD2EA0116_EA306136E4F7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_EA306136E4F7_impl*
end;//Tkw_ConsultationMark_Control_rbTwo.GetString

class procedure Tkw_ConsultationMark_Control_rbTwo.RegisterInEngine;
//#UC START# *52A086150180_EA306136E4F7_var*
//#UC END# *52A086150180_EA306136E4F7_var*
begin
//#UC START# *52A086150180_EA306136E4F7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_EA306136E4F7_impl*
end;//Tkw_ConsultationMark_Control_rbTwo.RegisterInEngine

procedure Tkw_ConsultationMark_Control_rbTwo_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F4BF94F0783C_var*
//#UC END# *4DAEEDE10285_F4BF94F0783C_var*
begin
//#UC START# *4DAEEDE10285_F4BF94F0783C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F4BF94F0783C_impl*
end;//Tkw_ConsultationMark_Control_rbTwo_Push.DoDoIt

class function Tkw_ConsultationMark_Control_rbTwo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbTwo:push';
end;//Tkw_ConsultationMark_Control_rbTwo_Push.GetWordNameForRegister

class function Tkw_ConsultationMark_Control_rbThree.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbThree';
end;//Tkw_ConsultationMark_Control_rbThree.GetWordNameForRegister

function Tkw_ConsultationMark_Control_rbThree.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_391E219F54C0_var*
//#UC END# *4DDFD2EA0116_391E219F54C0_var*
begin
//#UC START# *4DDFD2EA0116_391E219F54C0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_391E219F54C0_impl*
end;//Tkw_ConsultationMark_Control_rbThree.GetString

class procedure Tkw_ConsultationMark_Control_rbThree.RegisterInEngine;
//#UC START# *52A086150180_391E219F54C0_var*
//#UC END# *52A086150180_391E219F54C0_var*
begin
//#UC START# *52A086150180_391E219F54C0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_391E219F54C0_impl*
end;//Tkw_ConsultationMark_Control_rbThree.RegisterInEngine

procedure Tkw_ConsultationMark_Control_rbThree_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_227391332298_var*
//#UC END# *4DAEEDE10285_227391332298_var*
begin
//#UC START# *4DAEEDE10285_227391332298_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_227391332298_impl*
end;//Tkw_ConsultationMark_Control_rbThree_Push.DoDoIt

class function Tkw_ConsultationMark_Control_rbThree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbThree:push';
end;//Tkw_ConsultationMark_Control_rbThree_Push.GetWordNameForRegister

class function Tkw_ConsultationMark_Control_rbFour.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbFour';
end;//Tkw_ConsultationMark_Control_rbFour.GetWordNameForRegister

function Tkw_ConsultationMark_Control_rbFour.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E0D3D888E0D9_var*
//#UC END# *4DDFD2EA0116_E0D3D888E0D9_var*
begin
//#UC START# *4DDFD2EA0116_E0D3D888E0D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E0D3D888E0D9_impl*
end;//Tkw_ConsultationMark_Control_rbFour.GetString

class procedure Tkw_ConsultationMark_Control_rbFour.RegisterInEngine;
//#UC START# *52A086150180_E0D3D888E0D9_var*
//#UC END# *52A086150180_E0D3D888E0D9_var*
begin
//#UC START# *52A086150180_E0D3D888E0D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E0D3D888E0D9_impl*
end;//Tkw_ConsultationMark_Control_rbFour.RegisterInEngine

procedure Tkw_ConsultationMark_Control_rbFour_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_661E127E17A8_var*
//#UC END# *4DAEEDE10285_661E127E17A8_var*
begin
//#UC START# *4DAEEDE10285_661E127E17A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_661E127E17A8_impl*
end;//Tkw_ConsultationMark_Control_rbFour_Push.DoDoIt

class function Tkw_ConsultationMark_Control_rbFour_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbFour:push';
end;//Tkw_ConsultationMark_Control_rbFour_Push.GetWordNameForRegister

class function Tkw_ConsultationMark_Control_rbFive.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbFive';
end;//Tkw_ConsultationMark_Control_rbFive.GetWordNameForRegister

function Tkw_ConsultationMark_Control_rbFive.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_313D31B5C832_var*
//#UC END# *4DDFD2EA0116_313D31B5C832_var*
begin
//#UC START# *4DDFD2EA0116_313D31B5C832_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_313D31B5C832_impl*
end;//Tkw_ConsultationMark_Control_rbFive.GetString

class procedure Tkw_ConsultationMark_Control_rbFive.RegisterInEngine;
//#UC START# *52A086150180_313D31B5C832_var*
//#UC END# *52A086150180_313D31B5C832_var*
begin
//#UC START# *52A086150180_313D31B5C832_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_313D31B5C832_impl*
end;//Tkw_ConsultationMark_Control_rbFive.RegisterInEngine

procedure Tkw_ConsultationMark_Control_rbFive_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_66CFD6054E2B_var*
//#UC END# *4DAEEDE10285_66CFD6054E2B_var*
begin
//#UC START# *4DAEEDE10285_66CFD6054E2B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_66CFD6054E2B_impl*
end;//Tkw_ConsultationMark_Control_rbFive_Push.DoDoIt

class function Tkw_ConsultationMark_Control_rbFive_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbFive:push';
end;//Tkw_ConsultationMark_Control_rbFive_Push.GetWordNameForRegister

class function Tkw_ConsultationMark_Control_pnlHelp.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlHelp';
end;//Tkw_ConsultationMark_Control_pnlHelp.GetWordNameForRegister

function Tkw_ConsultationMark_Control_pnlHelp.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D5885EA40FCB_var*
//#UC END# *4DDFD2EA0116_D5885EA40FCB_var*
begin
//#UC START# *4DDFD2EA0116_D5885EA40FCB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D5885EA40FCB_impl*
end;//Tkw_ConsultationMark_Control_pnlHelp.GetString

class procedure Tkw_ConsultationMark_Control_pnlHelp.RegisterInEngine;
//#UC START# *52A086150180_D5885EA40FCB_var*
//#UC END# *52A086150180_D5885EA40FCB_var*
begin
//#UC START# *52A086150180_D5885EA40FCB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_D5885EA40FCB_impl*
end;//Tkw_ConsultationMark_Control_pnlHelp.RegisterInEngine

procedure Tkw_ConsultationMark_Control_pnlHelp_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FC2521E59BA7_var*
//#UC END# *4DAEEDE10285_FC2521E59BA7_var*
begin
//#UC START# *4DAEEDE10285_FC2521E59BA7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FC2521E59BA7_impl*
end;//Tkw_ConsultationMark_Control_pnlHelp_Push.DoDoIt

class function Tkw_ConsultationMark_Control_pnlHelp_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlHelp:push';
end;//Tkw_ConsultationMark_Control_pnlHelp_Push.GetWordNameForRegister

class function Tkw_ConsultationMark_Control_lblHelp.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblHelp';
end;//Tkw_ConsultationMark_Control_lblHelp.GetWordNameForRegister

function Tkw_ConsultationMark_Control_lblHelp.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_83E8C1A835A2_var*
//#UC END# *4DDFD2EA0116_83E8C1A835A2_var*
begin
//#UC START# *4DDFD2EA0116_83E8C1A835A2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_83E8C1A835A2_impl*
end;//Tkw_ConsultationMark_Control_lblHelp.GetString

class procedure Tkw_ConsultationMark_Control_lblHelp.RegisterInEngine;
//#UC START# *52A086150180_83E8C1A835A2_var*
//#UC END# *52A086150180_83E8C1A835A2_var*
begin
//#UC START# *52A086150180_83E8C1A835A2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_83E8C1A835A2_impl*
end;//Tkw_ConsultationMark_Control_lblHelp.RegisterInEngine

procedure Tkw_ConsultationMark_Control_lblHelp_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_ACA53177E8C9_var*
//#UC END# *4DAEEDE10285_ACA53177E8C9_var*
begin
//#UC START# *4DAEEDE10285_ACA53177E8C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_ACA53177E8C9_impl*
end;//Tkw_ConsultationMark_Control_lblHelp_Push.DoDoIt

class function Tkw_ConsultationMark_Control_lblHelp_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblHelp:push';
end;//Tkw_ConsultationMark_Control_lblHelp_Push.GetWordNameForRegister

class function Tkw_ConsultationMark_Control_gbComment.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbComment';
end;//Tkw_ConsultationMark_Control_gbComment.GetWordNameForRegister

function Tkw_ConsultationMark_Control_gbComment.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9657597A81C9_var*
//#UC END# *4DDFD2EA0116_9657597A81C9_var*
begin
//#UC START# *4DDFD2EA0116_9657597A81C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9657597A81C9_impl*
end;//Tkw_ConsultationMark_Control_gbComment.GetString

class procedure Tkw_ConsultationMark_Control_gbComment.RegisterInEngine;
//#UC START# *52A086150180_9657597A81C9_var*
//#UC END# *52A086150180_9657597A81C9_var*
begin
//#UC START# *52A086150180_9657597A81C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_9657597A81C9_impl*
end;//Tkw_ConsultationMark_Control_gbComment.RegisterInEngine

procedure Tkw_ConsultationMark_Control_gbComment_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B9AAAEC2E11B_var*
//#UC END# *4DAEEDE10285_B9AAAEC2E11B_var*
begin
//#UC START# *4DAEEDE10285_B9AAAEC2E11B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B9AAAEC2E11B_impl*
end;//Tkw_ConsultationMark_Control_gbComment_Push.DoDoIt

class function Tkw_ConsultationMark_Control_gbComment_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbComment:push';
end;//Tkw_ConsultationMark_Control_gbComment_Push.GetWordNameForRegister

class function Tkw_ConsultationMark_Control_mComment.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::mComment';
end;//Tkw_ConsultationMark_Control_mComment.GetWordNameForRegister

function Tkw_ConsultationMark_Control_mComment.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E2078C247487_var*
//#UC END# *4DDFD2EA0116_E2078C247487_var*
begin
//#UC START# *4DDFD2EA0116_E2078C247487_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E2078C247487_impl*
end;//Tkw_ConsultationMark_Control_mComment.GetString

class procedure Tkw_ConsultationMark_Control_mComment.RegisterInEngine;
//#UC START# *52A086150180_E2078C247487_var*
//#UC END# *52A086150180_E2078C247487_var*
begin
//#UC START# *52A086150180_E2078C247487_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E2078C247487_impl*
end;//Tkw_ConsultationMark_Control_mComment.RegisterInEngine

procedure Tkw_ConsultationMark_Control_mComment_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DBA48F967BE6_var*
//#UC END# *4DAEEDE10285_DBA48F967BE6_var*
begin
//#UC START# *4DAEEDE10285_DBA48F967BE6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DBA48F967BE6_impl*
end;//Tkw_ConsultationMark_Control_mComment_Push.DoDoIt

class function Tkw_ConsultationMark_Control_mComment_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::mComment:push';
end;//Tkw_ConsultationMark_Control_mComment_Push.GetWordNameForRegister

function TkwEnConsultationMarkGbMark.gbMark(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TvtGroupBox;
 {* ���������� ����� ������� .Ten_ConsultationMark.gbMark }
//#UC START# *A23E58F755E1_08E015178ADF_var*
//#UC END# *A23E58F755E1_08E015178ADF_var*
begin
//#UC START# *A23E58F755E1_08E015178ADF_impl*
 !!! Needs to be implemented !!!
//#UC END# *A23E58F755E1_08E015178ADF_impl*
end;//TkwEnConsultationMarkGbMark.gbMark

procedure TkwEnConsultationMarkGbMark.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_08E015178ADF_var*
//#UC END# *4DAEEDE10285_08E015178ADF_var*
begin
//#UC START# *4DAEEDE10285_08E015178ADF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_08E015178ADF_impl*
end;//TkwEnConsultationMarkGbMark.DoDoIt

class function TkwEnConsultationMarkGbMark.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.gbMark';
end;//TkwEnConsultationMarkGbMark.GetWordNameForRegister

procedure TkwEnConsultationMarkGbMark.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_08E015178ADF_var*
//#UC END# *52D00B00031A_08E015178ADF_var*
begin
//#UC START# *52D00B00031A_08E015178ADF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_08E015178ADF_impl*
end;//TkwEnConsultationMarkGbMark.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwEnConsultationMarkGbMark.ParamsTypes

function TkwEnConsultationMarkRbNotSure.rbNotSure(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
 {* ���������� ����� ������� .Ten_ConsultationMark.rbNotSure }
//#UC START# *2CE3B78803F7_102A22C548B7_var*
//#UC END# *2CE3B78803F7_102A22C548B7_var*
begin
//#UC START# *2CE3B78803F7_102A22C548B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *2CE3B78803F7_102A22C548B7_impl*
end;//TkwEnConsultationMarkRbNotSure.rbNotSure

procedure TkwEnConsultationMarkRbNotSure.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_102A22C548B7_var*
//#UC END# *4DAEEDE10285_102A22C548B7_var*
begin
//#UC START# *4DAEEDE10285_102A22C548B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_102A22C548B7_impl*
end;//TkwEnConsultationMarkRbNotSure.DoDoIt

class function TkwEnConsultationMarkRbNotSure.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.rbNotSure';
end;//TkwEnConsultationMarkRbNotSure.GetWordNameForRegister

procedure TkwEnConsultationMarkRbNotSure.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_102A22C548B7_var*
//#UC END# *52D00B00031A_102A22C548B7_var*
begin
//#UC START# *52D00B00031A_102A22C548B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_102A22C548B7_impl*
end;//TkwEnConsultationMarkRbNotSure.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwEnConsultationMarkRbNotSure.ParamsTypes

function TkwEnConsultationMarkRbTwo.rbTwo(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
 {* ���������� ����� ������� .Ten_ConsultationMark.rbTwo }
//#UC START# *654BA6F682D0_1361F312A549_var*
//#UC END# *654BA6F682D0_1361F312A549_var*
begin
//#UC START# *654BA6F682D0_1361F312A549_impl*
 !!! Needs to be implemented !!!
//#UC END# *654BA6F682D0_1361F312A549_impl*
end;//TkwEnConsultationMarkRbTwo.rbTwo

procedure TkwEnConsultationMarkRbTwo.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1361F312A549_var*
//#UC END# *4DAEEDE10285_1361F312A549_var*
begin
//#UC START# *4DAEEDE10285_1361F312A549_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1361F312A549_impl*
end;//TkwEnConsultationMarkRbTwo.DoDoIt

class function TkwEnConsultationMarkRbTwo.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.rbTwo';
end;//TkwEnConsultationMarkRbTwo.GetWordNameForRegister

procedure TkwEnConsultationMarkRbTwo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_1361F312A549_var*
//#UC END# *52D00B00031A_1361F312A549_var*
begin
//#UC START# *52D00B00031A_1361F312A549_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_1361F312A549_impl*
end;//TkwEnConsultationMarkRbTwo.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwEnConsultationMarkRbTwo.ParamsTypes

function TkwEnConsultationMarkRbThree.rbThree(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
 {* ���������� ����� ������� .Ten_ConsultationMark.rbThree }
//#UC START# *84B5FE5A6382_DCFA687F0AB6_var*
//#UC END# *84B5FE5A6382_DCFA687F0AB6_var*
begin
//#UC START# *84B5FE5A6382_DCFA687F0AB6_impl*
 !!! Needs to be implemented !!!
//#UC END# *84B5FE5A6382_DCFA687F0AB6_impl*
end;//TkwEnConsultationMarkRbThree.rbThree

procedure TkwEnConsultationMarkRbThree.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DCFA687F0AB6_var*
//#UC END# *4DAEEDE10285_DCFA687F0AB6_var*
begin
//#UC START# *4DAEEDE10285_DCFA687F0AB6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DCFA687F0AB6_impl*
end;//TkwEnConsultationMarkRbThree.DoDoIt

class function TkwEnConsultationMarkRbThree.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.rbThree';
end;//TkwEnConsultationMarkRbThree.GetWordNameForRegister

procedure TkwEnConsultationMarkRbThree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_DCFA687F0AB6_var*
//#UC END# *52D00B00031A_DCFA687F0AB6_var*
begin
//#UC START# *52D00B00031A_DCFA687F0AB6_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_DCFA687F0AB6_impl*
end;//TkwEnConsultationMarkRbThree.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwEnConsultationMarkRbThree.ParamsTypes

function TkwEnConsultationMarkRbFour.rbFour(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
 {* ���������� ����� ������� .Ten_ConsultationMark.rbFour }
//#UC START# *C5051E3C904E_017B75B3B73E_var*
//#UC END# *C5051E3C904E_017B75B3B73E_var*
begin
//#UC START# *C5051E3C904E_017B75B3B73E_impl*
 !!! Needs to be implemented !!!
//#UC END# *C5051E3C904E_017B75B3B73E_impl*
end;//TkwEnConsultationMarkRbFour.rbFour

procedure TkwEnConsultationMarkRbFour.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_017B75B3B73E_var*
//#UC END# *4DAEEDE10285_017B75B3B73E_var*
begin
//#UC START# *4DAEEDE10285_017B75B3B73E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_017B75B3B73E_impl*
end;//TkwEnConsultationMarkRbFour.DoDoIt

class function TkwEnConsultationMarkRbFour.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.rbFour';
end;//TkwEnConsultationMarkRbFour.GetWordNameForRegister

procedure TkwEnConsultationMarkRbFour.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_017B75B3B73E_var*
//#UC END# *52D00B00031A_017B75B3B73E_var*
begin
//#UC START# *52D00B00031A_017B75B3B73E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_017B75B3B73E_impl*
end;//TkwEnConsultationMarkRbFour.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwEnConsultationMarkRbFour.ParamsTypes

function TkwEnConsultationMarkRbFive.rbFive(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
 {* ���������� ����� ������� .Ten_ConsultationMark.rbFive }
//#UC START# *C87CB7ECD919_B408A9A1DAB5_var*
//#UC END# *C87CB7ECD919_B408A9A1DAB5_var*
begin
//#UC START# *C87CB7ECD919_B408A9A1DAB5_impl*
 !!! Needs to be implemented !!!
//#UC END# *C87CB7ECD919_B408A9A1DAB5_impl*
end;//TkwEnConsultationMarkRbFive.rbFive

procedure TkwEnConsultationMarkRbFive.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B408A9A1DAB5_var*
//#UC END# *4DAEEDE10285_B408A9A1DAB5_var*
begin
//#UC START# *4DAEEDE10285_B408A9A1DAB5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B408A9A1DAB5_impl*
end;//TkwEnConsultationMarkRbFive.DoDoIt

class function TkwEnConsultationMarkRbFive.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.rbFive';
end;//TkwEnConsultationMarkRbFive.GetWordNameForRegister

procedure TkwEnConsultationMarkRbFive.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_B408A9A1DAB5_var*
//#UC END# *52D00B00031A_B408A9A1DAB5_var*
begin
//#UC START# *52D00B00031A_B408A9A1DAB5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_B408A9A1DAB5_impl*
end;//TkwEnConsultationMarkRbFive.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwEnConsultationMarkRbFive.ParamsTypes

function TkwEnConsultationMarkPnlHelp.pnlHelp(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TvtPanel;
 {* ���������� ����� ������� .Ten_ConsultationMark.pnlHelp }
//#UC START# *6D3336D8B01D_85E1FBE51015_var*
//#UC END# *6D3336D8B01D_85E1FBE51015_var*
begin
//#UC START# *6D3336D8B01D_85E1FBE51015_impl*
 !!! Needs to be implemented !!!
//#UC END# *6D3336D8B01D_85E1FBE51015_impl*
end;//TkwEnConsultationMarkPnlHelp.pnlHelp

procedure TkwEnConsultationMarkPnlHelp.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_85E1FBE51015_var*
//#UC END# *4DAEEDE10285_85E1FBE51015_var*
begin
//#UC START# *4DAEEDE10285_85E1FBE51015_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_85E1FBE51015_impl*
end;//TkwEnConsultationMarkPnlHelp.DoDoIt

class function TkwEnConsultationMarkPnlHelp.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.pnlHelp';
end;//TkwEnConsultationMarkPnlHelp.GetWordNameForRegister

procedure TkwEnConsultationMarkPnlHelp.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_85E1FBE51015_var*
//#UC END# *52D00B00031A_85E1FBE51015_var*
begin
//#UC START# *52D00B00031A_85E1FBE51015_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_85E1FBE51015_impl*
end;//TkwEnConsultationMarkPnlHelp.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwEnConsultationMarkPnlHelp.ParamsTypes

function TkwEnConsultationMarkLblHelp.lblHelp(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TvtLabel;
 {* ���������� ����� ������� .Ten_ConsultationMark.lblHelp }
//#UC START# *C16FF77D9FFB_BD995E557E53_var*
//#UC END# *C16FF77D9FFB_BD995E557E53_var*
begin
//#UC START# *C16FF77D9FFB_BD995E557E53_impl*
 !!! Needs to be implemented !!!
//#UC END# *C16FF77D9FFB_BD995E557E53_impl*
end;//TkwEnConsultationMarkLblHelp.lblHelp

procedure TkwEnConsultationMarkLblHelp.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BD995E557E53_var*
//#UC END# *4DAEEDE10285_BD995E557E53_var*
begin
//#UC START# *4DAEEDE10285_BD995E557E53_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BD995E557E53_impl*
end;//TkwEnConsultationMarkLblHelp.DoDoIt

class function TkwEnConsultationMarkLblHelp.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.lblHelp';
end;//TkwEnConsultationMarkLblHelp.GetWordNameForRegister

procedure TkwEnConsultationMarkLblHelp.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_BD995E557E53_var*
//#UC END# *52D00B00031A_BD995E557E53_var*
begin
//#UC START# *52D00B00031A_BD995E557E53_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_BD995E557E53_impl*
end;//TkwEnConsultationMarkLblHelp.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwEnConsultationMarkLblHelp.ParamsTypes

function TkwEnConsultationMarkGbComment.gbComment(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TvtGroupBox;
 {* ���������� ����� ������� .Ten_ConsultationMark.gbComment }
//#UC START# *1661EACD5277_5E131FAEC04F_var*
//#UC END# *1661EACD5277_5E131FAEC04F_var*
begin
//#UC START# *1661EACD5277_5E131FAEC04F_impl*
 !!! Needs to be implemented !!!
//#UC END# *1661EACD5277_5E131FAEC04F_impl*
end;//TkwEnConsultationMarkGbComment.gbComment

procedure TkwEnConsultationMarkGbComment.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5E131FAEC04F_var*
//#UC END# *4DAEEDE10285_5E131FAEC04F_var*
begin
//#UC START# *4DAEEDE10285_5E131FAEC04F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5E131FAEC04F_impl*
end;//TkwEnConsultationMarkGbComment.DoDoIt

class function TkwEnConsultationMarkGbComment.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.gbComment';
end;//TkwEnConsultationMarkGbComment.GetWordNameForRegister

procedure TkwEnConsultationMarkGbComment.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_5E131FAEC04F_var*
//#UC END# *52D00B00031A_5E131FAEC04F_var*
begin
//#UC START# *52D00B00031A_5E131FAEC04F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_5E131FAEC04F_impl*
end;//TkwEnConsultationMarkGbComment.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwEnConsultationMarkGbComment.ParamsTypes

function TkwEnConsultationMarkMComment.mComment(const aCtx: TtfwContext;
 aen_ConsultationMark: Ten_ConsultationMark): TeeMemoWithEditOperations;
 {* ���������� ����� ������� .Ten_ConsultationMark.mComment }
//#UC START# *B825D48A3113_780807DC0F9A_var*
//#UC END# *B825D48A3113_780807DC0F9A_var*
begin
//#UC START# *B825D48A3113_780807DC0F9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *B825D48A3113_780807DC0F9A_impl*
end;//TkwEnConsultationMarkMComment.mComment

procedure TkwEnConsultationMarkMComment.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_780807DC0F9A_var*
//#UC END# *4DAEEDE10285_780807DC0F9A_var*
begin
//#UC START# *4DAEEDE10285_780807DC0F9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_780807DC0F9A_impl*
end;//TkwEnConsultationMarkMComment.DoDoIt

class function TkwEnConsultationMarkMComment.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConsultationMark.mComment';
end;//TkwEnConsultationMarkMComment.GetWordNameForRegister

procedure TkwEnConsultationMarkMComment.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_780807DC0F9A_var*
//#UC END# *52D00B00031A_780807DC0F9A_var*
begin
//#UC START# *52D00B00031A_780807DC0F9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_780807DC0F9A_impl*
end;//TkwEnConsultationMarkMComment.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwEnConsultationMarkMComment.ParamsTypes

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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_ConsultationMark));
 {* ����������� ���� ConsultationMark }
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
