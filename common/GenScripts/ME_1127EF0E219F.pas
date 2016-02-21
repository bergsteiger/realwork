unit PrintDialogKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� PrintDialog }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\PrintDialogKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CommonSearch_Module
 , vtRadioButton
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , vtSpinEdit
 , vtCheckBox
 , vtComboBoxQS
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
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
 Tkw_Form_PrintDialog = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� PrintDialog
----
*������ �������������*:
[code]
'aControl' �����::PrintDialog TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Form_PrintDialog

 Tkw_PrintDialog_Control_poDocumentNames = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� poDocumentNames
----
*������ �������������*:
[code]
�������::poDocumentNames TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_PrintDialog_Control_poDocumentNames

 Tkw_PrintDialog_Control_poDocumentNames_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� poDocumentNames
----
*������ �������������*:
[code]
�������::poDocumentNames:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PrintDialog_Control_poDocumentNames_Push

 Tkw_PrintDialog_Control_rbPrintSelected = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� rbPrintSelected
----
*������ �������������*:
[code]
�������::rbPrintSelected TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_PrintDialog_Control_rbPrintSelected

 Tkw_PrintDialog_Control_rbPrintSelected_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� rbPrintSelected
----
*������ �������������*:
[code]
�������::rbPrintSelected:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PrintDialog_Control_rbPrintSelected_Push

 Tkw_PrintDialog_Control_rbPrintCurrent = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� rbPrintCurrent
----
*������ �������������*:
[code]
�������::rbPrintCurrent TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_PrintDialog_Control_rbPrintCurrent

 Tkw_PrintDialog_Control_rbPrintCurrent_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� rbPrintCurrent
----
*������ �������������*:
[code]
�������::rbPrintCurrent:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PrintDialog_Control_rbPrintCurrent_Push

 Tkw_PrintDialog_Control_edPrintInterval = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edPrintInterval
----
*������ �������������*:
[code]
�������::edPrintInterval TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_PrintDialog_Control_edPrintInterval

 Tkw_PrintDialog_Control_edPrintInterval_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edPrintInterval
----
*������ �������������*:
[code]
�������::edPrintInterval:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PrintDialog_Control_edPrintInterval_Push

 Tkw_PrintDialog_Control_edCopyCount = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edCopyCount
----
*������ �������������*:
[code]
�������::edCopyCount TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_PrintDialog_Control_edCopyCount

 Tkw_PrintDialog_Control_edCopyCount_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edCopyCount
----
*������ �������������*:
[code]
�������::edCopyCount:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PrintDialog_Control_edCopyCount_Push

 Tkw_PrintDialog_Control_CollateCheckBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� CollateCheckBox
----
*������ �������������*:
[code]
�������::CollateCheckBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_PrintDialog_Control_CollateCheckBox

 Tkw_PrintDialog_Control_CollateCheckBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� CollateCheckBox
----
*������ �������������*:
[code]
�������::CollateCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PrintDialog_Control_CollateCheckBox_Push

 Tkw_PrintDialog_Control_cbOddEven = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� cbOddEven
----
*������ �������������*:
[code]
�������::cbOddEven TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_PrintDialog_Control_cbOddEven

 Tkw_PrintDialog_Control_cbOddEven_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� cbOddEven
----
*������ �������������*:
[code]
�������::cbOddEven:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PrintDialog_Control_cbOddEven_Push

 Tkw_PrintDialog_Control_poDocumentTexts = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� poDocumentTexts
----
*������ �������������*:
[code]
�������::poDocumentTexts TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_PrintDialog_Control_poDocumentTexts

 Tkw_PrintDialog_Control_poDocumentTexts_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� poDocumentTexts
----
*������ �������������*:
[code]
�������::poDocumentTexts:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PrintDialog_Control_poDocumentTexts_Push

 Tkw_PrintDialog_Control_rbPrintAll = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� rbPrintAll
----
*������ �������������*:
[code]
�������::rbPrintAll TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_PrintDialog_Control_rbPrintAll

 Tkw_PrintDialog_Control_rbPrintAll_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� rbPrintAll
----
*������ �������������*:
[code]
�������::rbPrintAll:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PrintDialog_Control_rbPrintAll_Push

 Tkw_PrintDialog_Control_rbPrintInterval = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� rbPrintInterval
----
*������ �������������*:
[code]
�������::rbPrintInterval TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_PrintDialog_Control_rbPrintInterval

 Tkw_PrintDialog_Control_rbPrintInterval_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� rbPrintInterval
----
*������ �������������*:
[code]
�������::rbPrintInterval:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PrintDialog_Control_rbPrintInterval_Push

 Tkw_PrintDialog_Control_cbPrinter = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� cbPrinter
----
*������ �������������*:
[code]
�������::cbPrinter TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_PrintDialog_Control_cbPrinter

 Tkw_PrintDialog_Control_cbPrinter_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� cbPrinter
----
*������ �������������*:
[code]
�������::cbPrinter:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PrintDialog_Control_cbPrinter_Push

 Tkw_PrintDialog_Control_cbPrintInfo = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� cbPrintInfo
----
*������ �������������*:
[code]
�������::cbPrintInfo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_PrintDialog_Control_cbPrintInfo

 Tkw_PrintDialog_Control_cbPrintInfo_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� cbPrintInfo
----
*������ �������������*:
[code]
�������::cbPrintInfo:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PrintDialog_Control_cbPrintInfo_Push

 TkwEnPrintDialogPoDocumentNames = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_PrintDialog.poDocumentNames
[panel]������� poDocumentNames ����� Ten_PrintDialog[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_PrintDialog .Ten_PrintDialog.poDocumentNames >>> l_TvtRadioButton
[code]  }
  private
   function poDocumentNames(const aCtx: TtfwContext;
    aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
    {* ���������� ����� ������� .Ten_PrintDialog.poDocumentNames }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnPrintDialogPoDocumentNames

 TkwEnPrintDialogRbPrintSelected = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_PrintDialog.rbPrintSelected
[panel]������� rbPrintSelected ����� Ten_PrintDialog[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_PrintDialog .Ten_PrintDialog.rbPrintSelected >>> l_TvtRadioButton
[code]  }
  private
   function rbPrintSelected(const aCtx: TtfwContext;
    aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
    {* ���������� ����� ������� .Ten_PrintDialog.rbPrintSelected }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnPrintDialogRbPrintSelected

 TkwEnPrintDialogRbPrintCurrent = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_PrintDialog.rbPrintCurrent
[panel]������� rbPrintCurrent ����� Ten_PrintDialog[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_PrintDialog .Ten_PrintDialog.rbPrintCurrent >>> l_TvtRadioButton
[code]  }
  private
   function rbPrintCurrent(const aCtx: TtfwContext;
    aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
    {* ���������� ����� ������� .Ten_PrintDialog.rbPrintCurrent }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnPrintDialogRbPrintCurrent

 TkwEnPrintDialogEdPrintInterval = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_PrintDialog.edPrintInterval
[panel]������� edPrintInterval ����� Ten_PrintDialog[panel]
*��� ����������:* TnscEditWithoutPlusMinusShortcut
*������:*
[code]
OBJECT VAR l_TnscEditWithoutPlusMinusShortcut
 aen_PrintDialog .Ten_PrintDialog.edPrintInterval >>> l_TnscEditWithoutPlusMinusShortcut
[code]  }
  private
   function edPrintInterval(const aCtx: TtfwContext;
    aen_PrintDialog: Ten_PrintDialog): TnscEditWithoutPlusMinusShortcut;
    {* ���������� ����� ������� .Ten_PrintDialog.edPrintInterval }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnPrintDialogEdPrintInterval

 TkwEnPrintDialogEdCopyCount = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_PrintDialog.edCopyCount
[panel]������� edCopyCount ����� Ten_PrintDialog[panel]
*��� ����������:* TvtSpinEdit
*������:*
[code]
OBJECT VAR l_TvtSpinEdit
 aen_PrintDialog .Ten_PrintDialog.edCopyCount >>> l_TvtSpinEdit
[code]  }
  private
   function edCopyCount(const aCtx: TtfwContext;
    aen_PrintDialog: Ten_PrintDialog): TvtSpinEdit;
    {* ���������� ����� ������� .Ten_PrintDialog.edCopyCount }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnPrintDialogEdCopyCount

 TkwEnPrintDialogCollateCheckBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_PrintDialog.CollateCheckBox
[panel]������� CollateCheckBox ����� Ten_PrintDialog[panel]
*��� ����������:* TvtCheckBox
*������:*
[code]
OBJECT VAR l_TvtCheckBox
 aen_PrintDialog .Ten_PrintDialog.CollateCheckBox >>> l_TvtCheckBox
[code]  }
  private
   function CollateCheckBox(const aCtx: TtfwContext;
    aen_PrintDialog: Ten_PrintDialog): TvtCheckBox;
    {* ���������� ����� ������� .Ten_PrintDialog.CollateCheckBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnPrintDialogCollateCheckBox

 TkwEnPrintDialogCbOddEven = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_PrintDialog.cbOddEven
[panel]������� cbOddEven ����� Ten_PrintDialog[panel]
*��� ����������:* TvtComboBoxQS
*������:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aen_PrintDialog .Ten_PrintDialog.cbOddEven >>> l_TvtComboBoxQS
[code]  }
  private
   function cbOddEven(const aCtx: TtfwContext;
    aen_PrintDialog: Ten_PrintDialog): TvtComboBoxQS;
    {* ���������� ����� ������� .Ten_PrintDialog.cbOddEven }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnPrintDialogCbOddEven

 TkwEnPrintDialogPoDocumentTexts = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_PrintDialog.poDocumentTexts
[panel]������� poDocumentTexts ����� Ten_PrintDialog[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_PrintDialog .Ten_PrintDialog.poDocumentTexts >>> l_TvtRadioButton
[code]  }
  private
   function poDocumentTexts(const aCtx: TtfwContext;
    aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
    {* ���������� ����� ������� .Ten_PrintDialog.poDocumentTexts }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnPrintDialogPoDocumentTexts

 TkwEnPrintDialogRbPrintAll = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_PrintDialog.rbPrintAll
[panel]������� rbPrintAll ����� Ten_PrintDialog[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_PrintDialog .Ten_PrintDialog.rbPrintAll >>> l_TvtRadioButton
[code]  }
  private
   function rbPrintAll(const aCtx: TtfwContext;
    aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
    {* ���������� ����� ������� .Ten_PrintDialog.rbPrintAll }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnPrintDialogRbPrintAll

 TkwEnPrintDialogRbPrintInterval = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_PrintDialog.rbPrintInterval
[panel]������� rbPrintInterval ����� Ten_PrintDialog[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_PrintDialog .Ten_PrintDialog.rbPrintInterval >>> l_TvtRadioButton
[code]  }
  private
   function rbPrintInterval(const aCtx: TtfwContext;
    aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
    {* ���������� ����� ������� .Ten_PrintDialog.rbPrintInterval }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnPrintDialogRbPrintInterval

 TkwEnPrintDialogCbPrinter = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_PrintDialog.cbPrinter
[panel]������� cbPrinter ����� Ten_PrintDialog[panel]
*��� ����������:* TvtComboBoxQS
*������:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aen_PrintDialog .Ten_PrintDialog.cbPrinter >>> l_TvtComboBoxQS
[code]  }
  private
   function cbPrinter(const aCtx: TtfwContext;
    aen_PrintDialog: Ten_PrintDialog): TvtComboBoxQS;
    {* ���������� ����� ������� .Ten_PrintDialog.cbPrinter }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnPrintDialogCbPrinter

 TkwEnPrintDialogCbPrintInfo = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_PrintDialog.cbPrintInfo
[panel]������� cbPrintInfo ����� Ten_PrintDialog[panel]
*��� ����������:* TvtCheckBox
*������:*
[code]
OBJECT VAR l_TvtCheckBox
 aen_PrintDialog .Ten_PrintDialog.cbPrintInfo >>> l_TvtCheckBox
[code]  }
  private
   function cbPrintInfo(const aCtx: TtfwContext;
    aen_PrintDialog: Ten_PrintDialog): TvtCheckBox;
    {* ���������� ����� ������� .Ten_PrintDialog.cbPrintInfo }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnPrintDialogCbPrintInfo

class function Tkw_Form_PrintDialog.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::PrintDialog';
end;//Tkw_Form_PrintDialog.GetWordNameForRegister

function Tkw_Form_PrintDialog.GetString: AnsiString;
begin
 Result := 'en_PrintDialog';
end;//Tkw_Form_PrintDialog.GetString

class procedure Tkw_Form_PrintDialog.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(Ten_PrintDialog);
end;//Tkw_Form_PrintDialog.RegisterInEngine

class function Tkw_PrintDialog_Control_poDocumentNames.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::poDocumentNames';
end;//Tkw_PrintDialog_Control_poDocumentNames.GetWordNameForRegister

function Tkw_PrintDialog_Control_poDocumentNames.GetString: AnsiString;
begin
 Result := 'poDocumentNames';
end;//Tkw_PrintDialog_Control_poDocumentNames.GetString

class procedure Tkw_PrintDialog_Control_poDocumentNames.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_PrintDialog_Control_poDocumentNames.RegisterInEngine

procedure Tkw_PrintDialog_Control_poDocumentNames_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D91C6C315D12_var*
//#UC END# *4DAEEDE10285_D91C6C315D12_var*
begin
//#UC START# *4DAEEDE10285_D91C6C315D12_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D91C6C315D12_impl*
end;//Tkw_PrintDialog_Control_poDocumentNames_Push.DoDoIt

class function Tkw_PrintDialog_Control_poDocumentNames_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::poDocumentNames:push';
end;//Tkw_PrintDialog_Control_poDocumentNames_Push.GetWordNameForRegister

class function Tkw_PrintDialog_Control_rbPrintSelected.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbPrintSelected';
end;//Tkw_PrintDialog_Control_rbPrintSelected.GetWordNameForRegister

function Tkw_PrintDialog_Control_rbPrintSelected.GetString: AnsiString;
begin
 Result := 'rbPrintSelected';
end;//Tkw_PrintDialog_Control_rbPrintSelected.GetString

class procedure Tkw_PrintDialog_Control_rbPrintSelected.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_PrintDialog_Control_rbPrintSelected.RegisterInEngine

procedure Tkw_PrintDialog_Control_rbPrintSelected_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2230ACC8B4F3_var*
//#UC END# *4DAEEDE10285_2230ACC8B4F3_var*
begin
//#UC START# *4DAEEDE10285_2230ACC8B4F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2230ACC8B4F3_impl*
end;//Tkw_PrintDialog_Control_rbPrintSelected_Push.DoDoIt

class function Tkw_PrintDialog_Control_rbPrintSelected_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbPrintSelected:push';
end;//Tkw_PrintDialog_Control_rbPrintSelected_Push.GetWordNameForRegister

class function Tkw_PrintDialog_Control_rbPrintCurrent.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbPrintCurrent';
end;//Tkw_PrintDialog_Control_rbPrintCurrent.GetWordNameForRegister

function Tkw_PrintDialog_Control_rbPrintCurrent.GetString: AnsiString;
begin
 Result := 'rbPrintCurrent';
end;//Tkw_PrintDialog_Control_rbPrintCurrent.GetString

class procedure Tkw_PrintDialog_Control_rbPrintCurrent.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_PrintDialog_Control_rbPrintCurrent.RegisterInEngine

procedure Tkw_PrintDialog_Control_rbPrintCurrent_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_712B86EE28A8_var*
//#UC END# *4DAEEDE10285_712B86EE28A8_var*
begin
//#UC START# *4DAEEDE10285_712B86EE28A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_712B86EE28A8_impl*
end;//Tkw_PrintDialog_Control_rbPrintCurrent_Push.DoDoIt

class function Tkw_PrintDialog_Control_rbPrintCurrent_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbPrintCurrent:push';
end;//Tkw_PrintDialog_Control_rbPrintCurrent_Push.GetWordNameForRegister

class function Tkw_PrintDialog_Control_edPrintInterval.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edPrintInterval';
end;//Tkw_PrintDialog_Control_edPrintInterval.GetWordNameForRegister

function Tkw_PrintDialog_Control_edPrintInterval.GetString: AnsiString;
begin
 Result := 'edPrintInterval';
end;//Tkw_PrintDialog_Control_edPrintInterval.GetString

class procedure Tkw_PrintDialog_Control_edPrintInterval.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEditWithoutPlusMinusShortcut);
end;//Tkw_PrintDialog_Control_edPrintInterval.RegisterInEngine

procedure Tkw_PrintDialog_Control_edPrintInterval_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B9E6CD75543D_var*
//#UC END# *4DAEEDE10285_B9E6CD75543D_var*
begin
//#UC START# *4DAEEDE10285_B9E6CD75543D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B9E6CD75543D_impl*
end;//Tkw_PrintDialog_Control_edPrintInterval_Push.DoDoIt

class function Tkw_PrintDialog_Control_edPrintInterval_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edPrintInterval:push';
end;//Tkw_PrintDialog_Control_edPrintInterval_Push.GetWordNameForRegister

class function Tkw_PrintDialog_Control_edCopyCount.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edCopyCount';
end;//Tkw_PrintDialog_Control_edCopyCount.GetWordNameForRegister

function Tkw_PrintDialog_Control_edCopyCount.GetString: AnsiString;
begin
 Result := 'edCopyCount';
end;//Tkw_PrintDialog_Control_edCopyCount.GetString

class procedure Tkw_PrintDialog_Control_edCopyCount.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSpinEdit);
end;//Tkw_PrintDialog_Control_edCopyCount.RegisterInEngine

procedure Tkw_PrintDialog_Control_edCopyCount_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_65583DDF4B94_var*
//#UC END# *4DAEEDE10285_65583DDF4B94_var*
begin
//#UC START# *4DAEEDE10285_65583DDF4B94_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_65583DDF4B94_impl*
end;//Tkw_PrintDialog_Control_edCopyCount_Push.DoDoIt

class function Tkw_PrintDialog_Control_edCopyCount_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edCopyCount:push';
end;//Tkw_PrintDialog_Control_edCopyCount_Push.GetWordNameForRegister

class function Tkw_PrintDialog_Control_CollateCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::CollateCheckBox';
end;//Tkw_PrintDialog_Control_CollateCheckBox.GetWordNameForRegister

function Tkw_PrintDialog_Control_CollateCheckBox.GetString: AnsiString;
begin
 Result := 'CollateCheckBox';
end;//Tkw_PrintDialog_Control_CollateCheckBox.GetString

class procedure Tkw_PrintDialog_Control_CollateCheckBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_PrintDialog_Control_CollateCheckBox.RegisterInEngine

procedure Tkw_PrintDialog_Control_CollateCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1A6B75D465B2_var*
//#UC END# *4DAEEDE10285_1A6B75D465B2_var*
begin
//#UC START# *4DAEEDE10285_1A6B75D465B2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1A6B75D465B2_impl*
end;//Tkw_PrintDialog_Control_CollateCheckBox_Push.DoDoIt

class function Tkw_PrintDialog_Control_CollateCheckBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::CollateCheckBox:push';
end;//Tkw_PrintDialog_Control_CollateCheckBox_Push.GetWordNameForRegister

class function Tkw_PrintDialog_Control_cbOddEven.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbOddEven';
end;//Tkw_PrintDialog_Control_cbOddEven.GetWordNameForRegister

function Tkw_PrintDialog_Control_cbOddEven.GetString: AnsiString;
begin
 Result := 'cbOddEven';
end;//Tkw_PrintDialog_Control_cbOddEven.GetString

class procedure Tkw_PrintDialog_Control_cbOddEven.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_PrintDialog_Control_cbOddEven.RegisterInEngine

procedure Tkw_PrintDialog_Control_cbOddEven_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8769F2E9B4DC_var*
//#UC END# *4DAEEDE10285_8769F2E9B4DC_var*
begin
//#UC START# *4DAEEDE10285_8769F2E9B4DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8769F2E9B4DC_impl*
end;//Tkw_PrintDialog_Control_cbOddEven_Push.DoDoIt

class function Tkw_PrintDialog_Control_cbOddEven_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbOddEven:push';
end;//Tkw_PrintDialog_Control_cbOddEven_Push.GetWordNameForRegister

class function Tkw_PrintDialog_Control_poDocumentTexts.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::poDocumentTexts';
end;//Tkw_PrintDialog_Control_poDocumentTexts.GetWordNameForRegister

function Tkw_PrintDialog_Control_poDocumentTexts.GetString: AnsiString;
begin
 Result := 'poDocumentTexts';
end;//Tkw_PrintDialog_Control_poDocumentTexts.GetString

class procedure Tkw_PrintDialog_Control_poDocumentTexts.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_PrintDialog_Control_poDocumentTexts.RegisterInEngine

procedure Tkw_PrintDialog_Control_poDocumentTexts_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E457D109B53_var*
//#UC END# *4DAEEDE10285_4E457D109B53_var*
begin
//#UC START# *4DAEEDE10285_4E457D109B53_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4E457D109B53_impl*
end;//Tkw_PrintDialog_Control_poDocumentTexts_Push.DoDoIt

class function Tkw_PrintDialog_Control_poDocumentTexts_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::poDocumentTexts:push';
end;//Tkw_PrintDialog_Control_poDocumentTexts_Push.GetWordNameForRegister

class function Tkw_PrintDialog_Control_rbPrintAll.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbPrintAll';
end;//Tkw_PrintDialog_Control_rbPrintAll.GetWordNameForRegister

function Tkw_PrintDialog_Control_rbPrintAll.GetString: AnsiString;
begin
 Result := 'rbPrintAll';
end;//Tkw_PrintDialog_Control_rbPrintAll.GetString

class procedure Tkw_PrintDialog_Control_rbPrintAll.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_PrintDialog_Control_rbPrintAll.RegisterInEngine

procedure Tkw_PrintDialog_Control_rbPrintAll_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F39604799DD8_var*
//#UC END# *4DAEEDE10285_F39604799DD8_var*
begin
//#UC START# *4DAEEDE10285_F39604799DD8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F39604799DD8_impl*
end;//Tkw_PrintDialog_Control_rbPrintAll_Push.DoDoIt

class function Tkw_PrintDialog_Control_rbPrintAll_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbPrintAll:push';
end;//Tkw_PrintDialog_Control_rbPrintAll_Push.GetWordNameForRegister

class function Tkw_PrintDialog_Control_rbPrintInterval.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbPrintInterval';
end;//Tkw_PrintDialog_Control_rbPrintInterval.GetWordNameForRegister

function Tkw_PrintDialog_Control_rbPrintInterval.GetString: AnsiString;
begin
 Result := 'rbPrintInterval';
end;//Tkw_PrintDialog_Control_rbPrintInterval.GetString

class procedure Tkw_PrintDialog_Control_rbPrintInterval.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_PrintDialog_Control_rbPrintInterval.RegisterInEngine

procedure Tkw_PrintDialog_Control_rbPrintInterval_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4BF6A6BD3409_var*
//#UC END# *4DAEEDE10285_4BF6A6BD3409_var*
begin
//#UC START# *4DAEEDE10285_4BF6A6BD3409_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4BF6A6BD3409_impl*
end;//Tkw_PrintDialog_Control_rbPrintInterval_Push.DoDoIt

class function Tkw_PrintDialog_Control_rbPrintInterval_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::rbPrintInterval:push';
end;//Tkw_PrintDialog_Control_rbPrintInterval_Push.GetWordNameForRegister

class function Tkw_PrintDialog_Control_cbPrinter.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbPrinter';
end;//Tkw_PrintDialog_Control_cbPrinter.GetWordNameForRegister

function Tkw_PrintDialog_Control_cbPrinter.GetString: AnsiString;
begin
 Result := 'cbPrinter';
end;//Tkw_PrintDialog_Control_cbPrinter.GetString

class procedure Tkw_PrintDialog_Control_cbPrinter.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_PrintDialog_Control_cbPrinter.RegisterInEngine

procedure Tkw_PrintDialog_Control_cbPrinter_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_12F749EE252C_var*
//#UC END# *4DAEEDE10285_12F749EE252C_var*
begin
//#UC START# *4DAEEDE10285_12F749EE252C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_12F749EE252C_impl*
end;//Tkw_PrintDialog_Control_cbPrinter_Push.DoDoIt

class function Tkw_PrintDialog_Control_cbPrinter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbPrinter:push';
end;//Tkw_PrintDialog_Control_cbPrinter_Push.GetWordNameForRegister

class function Tkw_PrintDialog_Control_cbPrintInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbPrintInfo';
end;//Tkw_PrintDialog_Control_cbPrintInfo.GetWordNameForRegister

function Tkw_PrintDialog_Control_cbPrintInfo.GetString: AnsiString;
begin
 Result := 'cbPrintInfo';
end;//Tkw_PrintDialog_Control_cbPrintInfo.GetString

class procedure Tkw_PrintDialog_Control_cbPrintInfo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_PrintDialog_Control_cbPrintInfo.RegisterInEngine

procedure Tkw_PrintDialog_Control_cbPrintInfo_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D216CC1D7351_var*
//#UC END# *4DAEEDE10285_D216CC1D7351_var*
begin
//#UC START# *4DAEEDE10285_D216CC1D7351_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D216CC1D7351_impl*
end;//Tkw_PrintDialog_Control_cbPrintInfo_Push.DoDoIt

class function Tkw_PrintDialog_Control_cbPrintInfo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbPrintInfo:push';
end;//Tkw_PrintDialog_Control_cbPrintInfo_Push.GetWordNameForRegister

function TkwEnPrintDialogPoDocumentNames.poDocumentNames(const aCtx: TtfwContext;
 aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
 {* ���������� ����� ������� .Ten_PrintDialog.poDocumentNames }
begin
 Result := aen_PrintDialog.poDocumentNames;
end;//TkwEnPrintDialogPoDocumentNames.poDocumentNames

procedure TkwEnPrintDialogPoDocumentNames.DoDoIt(const aCtx: TtfwContext);
var l_aen_PrintDialog: Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(poDocumentNames(aCtx, l_aen_PrintDialog));
end;//TkwEnPrintDialogPoDocumentNames.DoDoIt

class function TkwEnPrintDialogPoDocumentNames.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_PrintDialog.poDocumentNames';
end;//TkwEnPrintDialogPoDocumentNames.GetWordNameForRegister

procedure TkwEnPrintDialogPoDocumentNames.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� poDocumentNames', aCtx);
end;//TkwEnPrintDialogPoDocumentNames.SetValuePrim

function TkwEnPrintDialogPoDocumentNames.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnPrintDialogPoDocumentNames.GetResultTypeInfo

function TkwEnPrintDialogPoDocumentNames.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnPrintDialogPoDocumentNames.GetAllParamsCount

function TkwEnPrintDialogPoDocumentNames.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogPoDocumentNames.ParamsTypes

function TkwEnPrintDialogRbPrintSelected.rbPrintSelected(const aCtx: TtfwContext;
 aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
 {* ���������� ����� ������� .Ten_PrintDialog.rbPrintSelected }
begin
 Result := aen_PrintDialog.rbPrintSelected;
end;//TkwEnPrintDialogRbPrintSelected.rbPrintSelected

procedure TkwEnPrintDialogRbPrintSelected.DoDoIt(const aCtx: TtfwContext);
var l_aen_PrintDialog: Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(rbPrintSelected(aCtx, l_aen_PrintDialog));
end;//TkwEnPrintDialogRbPrintSelected.DoDoIt

class function TkwEnPrintDialogRbPrintSelected.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_PrintDialog.rbPrintSelected';
end;//TkwEnPrintDialogRbPrintSelected.GetWordNameForRegister

procedure TkwEnPrintDialogRbPrintSelected.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� rbPrintSelected', aCtx);
end;//TkwEnPrintDialogRbPrintSelected.SetValuePrim

function TkwEnPrintDialogRbPrintSelected.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnPrintDialogRbPrintSelected.GetResultTypeInfo

function TkwEnPrintDialogRbPrintSelected.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnPrintDialogRbPrintSelected.GetAllParamsCount

function TkwEnPrintDialogRbPrintSelected.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogRbPrintSelected.ParamsTypes

function TkwEnPrintDialogRbPrintCurrent.rbPrintCurrent(const aCtx: TtfwContext;
 aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
 {* ���������� ����� ������� .Ten_PrintDialog.rbPrintCurrent }
begin
 Result := aen_PrintDialog.rbPrintCurrent;
end;//TkwEnPrintDialogRbPrintCurrent.rbPrintCurrent

procedure TkwEnPrintDialogRbPrintCurrent.DoDoIt(const aCtx: TtfwContext);
var l_aen_PrintDialog: Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(rbPrintCurrent(aCtx, l_aen_PrintDialog));
end;//TkwEnPrintDialogRbPrintCurrent.DoDoIt

class function TkwEnPrintDialogRbPrintCurrent.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_PrintDialog.rbPrintCurrent';
end;//TkwEnPrintDialogRbPrintCurrent.GetWordNameForRegister

procedure TkwEnPrintDialogRbPrintCurrent.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� rbPrintCurrent', aCtx);
end;//TkwEnPrintDialogRbPrintCurrent.SetValuePrim

function TkwEnPrintDialogRbPrintCurrent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnPrintDialogRbPrintCurrent.GetResultTypeInfo

function TkwEnPrintDialogRbPrintCurrent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnPrintDialogRbPrintCurrent.GetAllParamsCount

function TkwEnPrintDialogRbPrintCurrent.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogRbPrintCurrent.ParamsTypes

function TkwEnPrintDialogEdPrintInterval.edPrintInterval(const aCtx: TtfwContext;
 aen_PrintDialog: Ten_PrintDialog): TnscEditWithoutPlusMinusShortcut;
 {* ���������� ����� ������� .Ten_PrintDialog.edPrintInterval }
begin
 Result := aen_PrintDialog.edPrintInterval;
end;//TkwEnPrintDialogEdPrintInterval.edPrintInterval

procedure TkwEnPrintDialogEdPrintInterval.DoDoIt(const aCtx: TtfwContext);
var l_aen_PrintDialog: Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edPrintInterval(aCtx, l_aen_PrintDialog));
end;//TkwEnPrintDialogEdPrintInterval.DoDoIt

class function TkwEnPrintDialogEdPrintInterval.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_PrintDialog.edPrintInterval';
end;//TkwEnPrintDialogEdPrintInterval.GetWordNameForRegister

procedure TkwEnPrintDialogEdPrintInterval.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� edPrintInterval', aCtx);
end;//TkwEnPrintDialogEdPrintInterval.SetValuePrim

function TkwEnPrintDialogEdPrintInterval.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEditWithoutPlusMinusShortcut);
end;//TkwEnPrintDialogEdPrintInterval.GetResultTypeInfo

function TkwEnPrintDialogEdPrintInterval.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnPrintDialogEdPrintInterval.GetAllParamsCount

function TkwEnPrintDialogEdPrintInterval.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogEdPrintInterval.ParamsTypes

function TkwEnPrintDialogEdCopyCount.edCopyCount(const aCtx: TtfwContext;
 aen_PrintDialog: Ten_PrintDialog): TvtSpinEdit;
 {* ���������� ����� ������� .Ten_PrintDialog.edCopyCount }
begin
 Result := aen_PrintDialog.edCopyCount;
end;//TkwEnPrintDialogEdCopyCount.edCopyCount

procedure TkwEnPrintDialogEdCopyCount.DoDoIt(const aCtx: TtfwContext);
var l_aen_PrintDialog: Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edCopyCount(aCtx, l_aen_PrintDialog));
end;//TkwEnPrintDialogEdCopyCount.DoDoIt

class function TkwEnPrintDialogEdCopyCount.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_PrintDialog.edCopyCount';
end;//TkwEnPrintDialogEdCopyCount.GetWordNameForRegister

procedure TkwEnPrintDialogEdCopyCount.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� edCopyCount', aCtx);
end;//TkwEnPrintDialogEdCopyCount.SetValuePrim

function TkwEnPrintDialogEdCopyCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSpinEdit);
end;//TkwEnPrintDialogEdCopyCount.GetResultTypeInfo

function TkwEnPrintDialogEdCopyCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnPrintDialogEdCopyCount.GetAllParamsCount

function TkwEnPrintDialogEdCopyCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogEdCopyCount.ParamsTypes

function TkwEnPrintDialogCollateCheckBox.CollateCheckBox(const aCtx: TtfwContext;
 aen_PrintDialog: Ten_PrintDialog): TvtCheckBox;
 {* ���������� ����� ������� .Ten_PrintDialog.CollateCheckBox }
begin
 Result := aen_PrintDialog.CollateCheckBox;
end;//TkwEnPrintDialogCollateCheckBox.CollateCheckBox

procedure TkwEnPrintDialogCollateCheckBox.DoDoIt(const aCtx: TtfwContext);
var l_aen_PrintDialog: Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(CollateCheckBox(aCtx, l_aen_PrintDialog));
end;//TkwEnPrintDialogCollateCheckBox.DoDoIt

class function TkwEnPrintDialogCollateCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_PrintDialog.CollateCheckBox';
end;//TkwEnPrintDialogCollateCheckBox.GetWordNameForRegister

procedure TkwEnPrintDialogCollateCheckBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� CollateCheckBox', aCtx);
end;//TkwEnPrintDialogCollateCheckBox.SetValuePrim

function TkwEnPrintDialogCollateCheckBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwEnPrintDialogCollateCheckBox.GetResultTypeInfo

function TkwEnPrintDialogCollateCheckBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnPrintDialogCollateCheckBox.GetAllParamsCount

function TkwEnPrintDialogCollateCheckBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogCollateCheckBox.ParamsTypes

function TkwEnPrintDialogCbOddEven.cbOddEven(const aCtx: TtfwContext;
 aen_PrintDialog: Ten_PrintDialog): TvtComboBoxQS;
 {* ���������� ����� ������� .Ten_PrintDialog.cbOddEven }
begin
 Result := aen_PrintDialog.cbOddEven;
end;//TkwEnPrintDialogCbOddEven.cbOddEven

procedure TkwEnPrintDialogCbOddEven.DoDoIt(const aCtx: TtfwContext);
var l_aen_PrintDialog: Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(cbOddEven(aCtx, l_aen_PrintDialog));
end;//TkwEnPrintDialogCbOddEven.DoDoIt

class function TkwEnPrintDialogCbOddEven.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_PrintDialog.cbOddEven';
end;//TkwEnPrintDialogCbOddEven.GetWordNameForRegister

procedure TkwEnPrintDialogCbOddEven.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� cbOddEven', aCtx);
end;//TkwEnPrintDialogCbOddEven.SetValuePrim

function TkwEnPrintDialogCbOddEven.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwEnPrintDialogCbOddEven.GetResultTypeInfo

function TkwEnPrintDialogCbOddEven.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnPrintDialogCbOddEven.GetAllParamsCount

function TkwEnPrintDialogCbOddEven.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogCbOddEven.ParamsTypes

function TkwEnPrintDialogPoDocumentTexts.poDocumentTexts(const aCtx: TtfwContext;
 aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
 {* ���������� ����� ������� .Ten_PrintDialog.poDocumentTexts }
begin
 Result := aen_PrintDialog.poDocumentTexts;
end;//TkwEnPrintDialogPoDocumentTexts.poDocumentTexts

procedure TkwEnPrintDialogPoDocumentTexts.DoDoIt(const aCtx: TtfwContext);
var l_aen_PrintDialog: Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(poDocumentTexts(aCtx, l_aen_PrintDialog));
end;//TkwEnPrintDialogPoDocumentTexts.DoDoIt

class function TkwEnPrintDialogPoDocumentTexts.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_PrintDialog.poDocumentTexts';
end;//TkwEnPrintDialogPoDocumentTexts.GetWordNameForRegister

procedure TkwEnPrintDialogPoDocumentTexts.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� poDocumentTexts', aCtx);
end;//TkwEnPrintDialogPoDocumentTexts.SetValuePrim

function TkwEnPrintDialogPoDocumentTexts.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnPrintDialogPoDocumentTexts.GetResultTypeInfo

function TkwEnPrintDialogPoDocumentTexts.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnPrintDialogPoDocumentTexts.GetAllParamsCount

function TkwEnPrintDialogPoDocumentTexts.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogPoDocumentTexts.ParamsTypes

function TkwEnPrintDialogRbPrintAll.rbPrintAll(const aCtx: TtfwContext;
 aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
 {* ���������� ����� ������� .Ten_PrintDialog.rbPrintAll }
begin
 Result := aen_PrintDialog.rbPrintAll;
end;//TkwEnPrintDialogRbPrintAll.rbPrintAll

procedure TkwEnPrintDialogRbPrintAll.DoDoIt(const aCtx: TtfwContext);
var l_aen_PrintDialog: Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(rbPrintAll(aCtx, l_aen_PrintDialog));
end;//TkwEnPrintDialogRbPrintAll.DoDoIt

class function TkwEnPrintDialogRbPrintAll.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_PrintDialog.rbPrintAll';
end;//TkwEnPrintDialogRbPrintAll.GetWordNameForRegister

procedure TkwEnPrintDialogRbPrintAll.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� rbPrintAll', aCtx);
end;//TkwEnPrintDialogRbPrintAll.SetValuePrim

function TkwEnPrintDialogRbPrintAll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnPrintDialogRbPrintAll.GetResultTypeInfo

function TkwEnPrintDialogRbPrintAll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnPrintDialogRbPrintAll.GetAllParamsCount

function TkwEnPrintDialogRbPrintAll.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogRbPrintAll.ParamsTypes

function TkwEnPrintDialogRbPrintInterval.rbPrintInterval(const aCtx: TtfwContext;
 aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
 {* ���������� ����� ������� .Ten_PrintDialog.rbPrintInterval }
begin
 Result := aen_PrintDialog.rbPrintInterval;
end;//TkwEnPrintDialogRbPrintInterval.rbPrintInterval

procedure TkwEnPrintDialogRbPrintInterval.DoDoIt(const aCtx: TtfwContext);
var l_aen_PrintDialog: Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(rbPrintInterval(aCtx, l_aen_PrintDialog));
end;//TkwEnPrintDialogRbPrintInterval.DoDoIt

class function TkwEnPrintDialogRbPrintInterval.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_PrintDialog.rbPrintInterval';
end;//TkwEnPrintDialogRbPrintInterval.GetWordNameForRegister

procedure TkwEnPrintDialogRbPrintInterval.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� rbPrintInterval', aCtx);
end;//TkwEnPrintDialogRbPrintInterval.SetValuePrim

function TkwEnPrintDialogRbPrintInterval.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnPrintDialogRbPrintInterval.GetResultTypeInfo

function TkwEnPrintDialogRbPrintInterval.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnPrintDialogRbPrintInterval.GetAllParamsCount

function TkwEnPrintDialogRbPrintInterval.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogRbPrintInterval.ParamsTypes

function TkwEnPrintDialogCbPrinter.cbPrinter(const aCtx: TtfwContext;
 aen_PrintDialog: Ten_PrintDialog): TvtComboBoxQS;
 {* ���������� ����� ������� .Ten_PrintDialog.cbPrinter }
begin
 Result := aen_PrintDialog.cbPrinter;
end;//TkwEnPrintDialogCbPrinter.cbPrinter

procedure TkwEnPrintDialogCbPrinter.DoDoIt(const aCtx: TtfwContext);
var l_aen_PrintDialog: Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(cbPrinter(aCtx, l_aen_PrintDialog));
end;//TkwEnPrintDialogCbPrinter.DoDoIt

class function TkwEnPrintDialogCbPrinter.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_PrintDialog.cbPrinter';
end;//TkwEnPrintDialogCbPrinter.GetWordNameForRegister

procedure TkwEnPrintDialogCbPrinter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� cbPrinter', aCtx);
end;//TkwEnPrintDialogCbPrinter.SetValuePrim

function TkwEnPrintDialogCbPrinter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwEnPrintDialogCbPrinter.GetResultTypeInfo

function TkwEnPrintDialogCbPrinter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnPrintDialogCbPrinter.GetAllParamsCount

function TkwEnPrintDialogCbPrinter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogCbPrinter.ParamsTypes

function TkwEnPrintDialogCbPrintInfo.cbPrintInfo(const aCtx: TtfwContext;
 aen_PrintDialog: Ten_PrintDialog): TvtCheckBox;
 {* ���������� ����� ������� .Ten_PrintDialog.cbPrintInfo }
begin
 Result := aen_PrintDialog.cbPrintInfo;
end;//TkwEnPrintDialogCbPrintInfo.cbPrintInfo

procedure TkwEnPrintDialogCbPrintInfo.DoDoIt(const aCtx: TtfwContext);
var l_aen_PrintDialog: Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(cbPrintInfo(aCtx, l_aen_PrintDialog));
end;//TkwEnPrintDialogCbPrintInfo.DoDoIt

class function TkwEnPrintDialogCbPrintInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_PrintDialog.cbPrintInfo';
end;//TkwEnPrintDialogCbPrintInfo.GetWordNameForRegister

procedure TkwEnPrintDialogCbPrintInfo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� cbPrintInfo', aCtx);
end;//TkwEnPrintDialogCbPrintInfo.SetValuePrim

function TkwEnPrintDialogCbPrintInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwEnPrintDialogCbPrintInfo.GetResultTypeInfo

function TkwEnPrintDialogCbPrintInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnPrintDialogCbPrintInfo.GetAllParamsCount

function TkwEnPrintDialogCbPrintInfo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogCbPrintInfo.ParamsTypes

initialization
 Tkw_Form_PrintDialog.RegisterInEngine;
 {* ����������� Tkw_Form_PrintDialog }
 Tkw_PrintDialog_Control_poDocumentNames.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_poDocumentNames }
 Tkw_PrintDialog_Control_poDocumentNames_Push.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_poDocumentNames_Push }
 Tkw_PrintDialog_Control_rbPrintSelected.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_rbPrintSelected }
 Tkw_PrintDialog_Control_rbPrintSelected_Push.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_rbPrintSelected_Push }
 Tkw_PrintDialog_Control_rbPrintCurrent.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_rbPrintCurrent }
 Tkw_PrintDialog_Control_rbPrintCurrent_Push.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_rbPrintCurrent_Push }
 Tkw_PrintDialog_Control_edPrintInterval.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_edPrintInterval }
 Tkw_PrintDialog_Control_edPrintInterval_Push.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_edPrintInterval_Push }
 Tkw_PrintDialog_Control_edCopyCount.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_edCopyCount }
 Tkw_PrintDialog_Control_edCopyCount_Push.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_edCopyCount_Push }
 Tkw_PrintDialog_Control_CollateCheckBox.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_CollateCheckBox }
 Tkw_PrintDialog_Control_CollateCheckBox_Push.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_CollateCheckBox_Push }
 Tkw_PrintDialog_Control_cbOddEven.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_cbOddEven }
 Tkw_PrintDialog_Control_cbOddEven_Push.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_cbOddEven_Push }
 Tkw_PrintDialog_Control_poDocumentTexts.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_poDocumentTexts }
 Tkw_PrintDialog_Control_poDocumentTexts_Push.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_poDocumentTexts_Push }
 Tkw_PrintDialog_Control_rbPrintAll.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_rbPrintAll }
 Tkw_PrintDialog_Control_rbPrintAll_Push.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_rbPrintAll_Push }
 Tkw_PrintDialog_Control_rbPrintInterval.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_rbPrintInterval }
 Tkw_PrintDialog_Control_rbPrintInterval_Push.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_rbPrintInterval_Push }
 Tkw_PrintDialog_Control_cbPrinter.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_cbPrinter }
 Tkw_PrintDialog_Control_cbPrinter_Push.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_cbPrinter_Push }
 Tkw_PrintDialog_Control_cbPrintInfo.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_cbPrintInfo }
 Tkw_PrintDialog_Control_cbPrintInfo_Push.RegisterInEngine;
 {* ����������� Tkw_PrintDialog_Control_cbPrintInfo_Push }
 TkwEnPrintDialogPoDocumentNames.RegisterInEngine;
 {* ����������� en_PrintDialog_poDocumentNames }
 TkwEnPrintDialogRbPrintSelected.RegisterInEngine;
 {* ����������� en_PrintDialog_rbPrintSelected }
 TkwEnPrintDialogRbPrintCurrent.RegisterInEngine;
 {* ����������� en_PrintDialog_rbPrintCurrent }
 TkwEnPrintDialogEdPrintInterval.RegisterInEngine;
 {* ����������� en_PrintDialog_edPrintInterval }
 TkwEnPrintDialogEdCopyCount.RegisterInEngine;
 {* ����������� en_PrintDialog_edCopyCount }
 TkwEnPrintDialogCollateCheckBox.RegisterInEngine;
 {* ����������� en_PrintDialog_CollateCheckBox }
 TkwEnPrintDialogCbOddEven.RegisterInEngine;
 {* ����������� en_PrintDialog_cbOddEven }
 TkwEnPrintDialogPoDocumentTexts.RegisterInEngine;
 {* ����������� en_PrintDialog_poDocumentTexts }
 TkwEnPrintDialogRbPrintAll.RegisterInEngine;
 {* ����������� en_PrintDialog_rbPrintAll }
 TkwEnPrintDialogRbPrintInterval.RegisterInEngine;
 {* ����������� en_PrintDialog_rbPrintInterval }
 TkwEnPrintDialogCbPrinter.RegisterInEngine;
 {* ����������� en_PrintDialog_cbPrinter }
 TkwEnPrintDialogCbPrintInfo.RegisterInEngine;
 {* ����������� en_PrintDialog_cbPrintInfo }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_PrintDialog));
 {* ����������� ���� PrintDialog }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtRadioButton));
 {* ����������� ���� TvtRadioButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditWithoutPlusMinusShortcut));
 {* ����������� ���� TnscEditWithoutPlusMinusShortcut }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSpinEdit));
 {* ����������� ���� TvtSpinEdit }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCheckBox));
 {* ����������� ���� TvtCheckBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtComboBoxQS));
 {* ����������� ���� TvtComboBoxQS }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

end.
