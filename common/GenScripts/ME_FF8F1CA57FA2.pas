unit BaseSearchCardKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� BaseSearchCard }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\BaseSearchCardKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , BaseSearch_Module
 , vtPanel
 {$If Defined(Nemesis)}
 , nscHideField
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscLister
 {$IfEnd} // Defined(Nemesis)
 , nscSimpleEditor
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
 Tkw_Form_BaseSearchCard = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� BaseSearchCard
----
*������ �������������*:
[code]
'aControl' �����::BaseSearchCard TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_BaseSearchCard

 Tkw_BaseSearchCard_Control_pnlMain = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlMain
----
*������ �������������*:
[code]
�������::pnlMain TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_BaseSearchCard_Control_pnlMain

 Tkw_BaseSearchCard_Control_pnlMain_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlMain
----
*������ �������������*:
[code]
�������::pnlMain:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_BaseSearchCard_Control_pnlMain_Push

 Tkw_BaseSearchCard_Control_hfBaseSearch = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� hfBaseSearch
----
*������ �������������*:
[code]
�������::hfBaseSearch TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_BaseSearchCard_Control_hfBaseSearch

 Tkw_BaseSearchCard_Control_hfBaseSearch_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� hfBaseSearch
----
*������ �������������*:
[code]
�������::hfBaseSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_BaseSearchCard_Control_hfBaseSearch_Push

 Tkw_BaseSearchCard_Control_lrBaseSearch = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lrBaseSearch
----
*������ �������������*:
[code]
�������::lrBaseSearch TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_BaseSearchCard_Control_lrBaseSearch

 Tkw_BaseSearchCard_Control_lrBaseSearch_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lrBaseSearch
----
*������ �������������*:
[code]
�������::lrBaseSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_BaseSearchCard_Control_lrBaseSearch_Push

 Tkw_BaseSearchCard_Control_CardTextLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� CardTextLabel
----
*������ �������������*:
[code]
�������::CardTextLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_BaseSearchCard_Control_CardTextLabel

 Tkw_BaseSearchCard_Control_CardTextLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� CardTextLabel
----
*������ �������������*:
[code]
�������::CardTextLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_BaseSearchCard_Control_CardTextLabel_Push

 TkwEnBaseSearchCardPnlMain = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_BaseSearchCard.pnlMain
[panel]������� pnlMain ����� Ten_BaseSearchCard[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aen_BaseSearchCard .Ten_BaseSearchCard.pnlMain >>> l_TvtPanel
[code]  }
  private
   function pnlMain(const aCtx: TtfwContext;
    aen_BaseSearchCard: Ten_BaseSearchCard): TvtPanel;
    {* ���������� ����� ������� .Ten_BaseSearchCard.pnlMain }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnBaseSearchCardPnlMain

 TkwEnBaseSearchCardHfBaseSearch = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_BaseSearchCard.hfBaseSearch
[panel]������� hfBaseSearch ����� Ten_BaseSearchCard[panel]
*��� ����������:* TnscHideField
*������:*
[code]
OBJECT VAR l_TnscHideField
 aen_BaseSearchCard .Ten_BaseSearchCard.hfBaseSearch >>> l_TnscHideField
[code]  }
  private
   function hfBaseSearch(const aCtx: TtfwContext;
    aen_BaseSearchCard: Ten_BaseSearchCard): TnscHideField;
    {* ���������� ����� ������� .Ten_BaseSearchCard.hfBaseSearch }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnBaseSearchCardHfBaseSearch

 TkwEnBaseSearchCardLrBaseSearch = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_BaseSearchCard.lrBaseSearch
[panel]������� lrBaseSearch ����� Ten_BaseSearchCard[panel]
*��� ����������:* TnscLister
*������:*
[code]
OBJECT VAR l_TnscLister
 aen_BaseSearchCard .Ten_BaseSearchCard.lrBaseSearch >>> l_TnscLister
[code]  }
  private
   function lrBaseSearch(const aCtx: TtfwContext;
    aen_BaseSearchCard: Ten_BaseSearchCard): TnscLister;
    {* ���������� ����� ������� .Ten_BaseSearchCard.lrBaseSearch }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnBaseSearchCardLrBaseSearch

 TkwEnBaseSearchCardCardTextLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_BaseSearchCard.CardTextLabel
[panel]������� CardTextLabel ����� Ten_BaseSearchCard[panel]
*��� ����������:* TnscSimpleEditor
*������:*
[code]
OBJECT VAR l_TnscSimpleEditor
 aen_BaseSearchCard .Ten_BaseSearchCard.CardTextLabel >>> l_TnscSimpleEditor
[code]  }
  private
   function CardTextLabel(const aCtx: TtfwContext;
    aen_BaseSearchCard: Ten_BaseSearchCard): TnscSimpleEditor;
    {* ���������� ����� ������� .Ten_BaseSearchCard.CardTextLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnBaseSearchCardCardTextLabel

class function Tkw_Form_BaseSearchCard.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::BaseSearchCard';
end;//Tkw_Form_BaseSearchCard.GetWordNameForRegister

function Tkw_Form_BaseSearchCard.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_66C44BA842AF_var*
//#UC END# *4DDFD2EA0116_66C44BA842AF_var*
begin
//#UC START# *4DDFD2EA0116_66C44BA842AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_66C44BA842AF_impl*
end;//Tkw_Form_BaseSearchCard.GetString

class function Tkw_BaseSearchCard_Control_pnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlMain';
end;//Tkw_BaseSearchCard_Control_pnlMain.GetWordNameForRegister

function Tkw_BaseSearchCard_Control_pnlMain.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_381AC4FD9D93_var*
//#UC END# *4DDFD2EA0116_381AC4FD9D93_var*
begin
//#UC START# *4DDFD2EA0116_381AC4FD9D93_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_381AC4FD9D93_impl*
end;//Tkw_BaseSearchCard_Control_pnlMain.GetString

class procedure Tkw_BaseSearchCard_Control_pnlMain.RegisterInEngine;
//#UC START# *52A086150180_381AC4FD9D93_var*
//#UC END# *52A086150180_381AC4FD9D93_var*
begin
//#UC START# *52A086150180_381AC4FD9D93_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_381AC4FD9D93_impl*
end;//Tkw_BaseSearchCard_Control_pnlMain.RegisterInEngine

procedure Tkw_BaseSearchCard_Control_pnlMain_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A7C66FDE2A79_var*
//#UC END# *4DAEEDE10285_A7C66FDE2A79_var*
begin
//#UC START# *4DAEEDE10285_A7C66FDE2A79_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A7C66FDE2A79_impl*
end;//Tkw_BaseSearchCard_Control_pnlMain_Push.DoDoIt

class function Tkw_BaseSearchCard_Control_pnlMain_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlMain:push';
end;//Tkw_BaseSearchCard_Control_pnlMain_Push.GetWordNameForRegister

class function Tkw_BaseSearchCard_Control_hfBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::hfBaseSearch';
end;//Tkw_BaseSearchCard_Control_hfBaseSearch.GetWordNameForRegister

function Tkw_BaseSearchCard_Control_hfBaseSearch.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5DD7EC0BC050_var*
//#UC END# *4DDFD2EA0116_5DD7EC0BC050_var*
begin
//#UC START# *4DDFD2EA0116_5DD7EC0BC050_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5DD7EC0BC050_impl*
end;//Tkw_BaseSearchCard_Control_hfBaseSearch.GetString

class procedure Tkw_BaseSearchCard_Control_hfBaseSearch.RegisterInEngine;
//#UC START# *52A086150180_5DD7EC0BC050_var*
//#UC END# *52A086150180_5DD7EC0BC050_var*
begin
//#UC START# *52A086150180_5DD7EC0BC050_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5DD7EC0BC050_impl*
end;//Tkw_BaseSearchCard_Control_hfBaseSearch.RegisterInEngine

procedure Tkw_BaseSearchCard_Control_hfBaseSearch_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9CE6F7AC81C8_var*
//#UC END# *4DAEEDE10285_9CE6F7AC81C8_var*
begin
//#UC START# *4DAEEDE10285_9CE6F7AC81C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9CE6F7AC81C8_impl*
end;//Tkw_BaseSearchCard_Control_hfBaseSearch_Push.DoDoIt

class function Tkw_BaseSearchCard_Control_hfBaseSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::hfBaseSearch:push';
end;//Tkw_BaseSearchCard_Control_hfBaseSearch_Push.GetWordNameForRegister

class function Tkw_BaseSearchCard_Control_lrBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lrBaseSearch';
end;//Tkw_BaseSearchCard_Control_lrBaseSearch.GetWordNameForRegister

function Tkw_BaseSearchCard_Control_lrBaseSearch.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D042842DC65F_var*
//#UC END# *4DDFD2EA0116_D042842DC65F_var*
begin
//#UC START# *4DDFD2EA0116_D042842DC65F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D042842DC65F_impl*
end;//Tkw_BaseSearchCard_Control_lrBaseSearch.GetString

class procedure Tkw_BaseSearchCard_Control_lrBaseSearch.RegisterInEngine;
//#UC START# *52A086150180_D042842DC65F_var*
//#UC END# *52A086150180_D042842DC65F_var*
begin
//#UC START# *52A086150180_D042842DC65F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_D042842DC65F_impl*
end;//Tkw_BaseSearchCard_Control_lrBaseSearch.RegisterInEngine

procedure Tkw_BaseSearchCard_Control_lrBaseSearch_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D965E88B544C_var*
//#UC END# *4DAEEDE10285_D965E88B544C_var*
begin
//#UC START# *4DAEEDE10285_D965E88B544C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D965E88B544C_impl*
end;//Tkw_BaseSearchCard_Control_lrBaseSearch_Push.DoDoIt

class function Tkw_BaseSearchCard_Control_lrBaseSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lrBaseSearch:push';
end;//Tkw_BaseSearchCard_Control_lrBaseSearch_Push.GetWordNameForRegister

class function Tkw_BaseSearchCard_Control_CardTextLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::CardTextLabel';
end;//Tkw_BaseSearchCard_Control_CardTextLabel.GetWordNameForRegister

function Tkw_BaseSearchCard_Control_CardTextLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C36B4FEB9127_var*
//#UC END# *4DDFD2EA0116_C36B4FEB9127_var*
begin
//#UC START# *4DDFD2EA0116_C36B4FEB9127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C36B4FEB9127_impl*
end;//Tkw_BaseSearchCard_Control_CardTextLabel.GetString

class procedure Tkw_BaseSearchCard_Control_CardTextLabel.RegisterInEngine;
//#UC START# *52A086150180_C36B4FEB9127_var*
//#UC END# *52A086150180_C36B4FEB9127_var*
begin
//#UC START# *52A086150180_C36B4FEB9127_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_C36B4FEB9127_impl*
end;//Tkw_BaseSearchCard_Control_CardTextLabel.RegisterInEngine

procedure Tkw_BaseSearchCard_Control_CardTextLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3000A2360AD1_var*
//#UC END# *4DAEEDE10285_3000A2360AD1_var*
begin
//#UC START# *4DAEEDE10285_3000A2360AD1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3000A2360AD1_impl*
end;//Tkw_BaseSearchCard_Control_CardTextLabel_Push.DoDoIt

class function Tkw_BaseSearchCard_Control_CardTextLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::CardTextLabel:push';
end;//Tkw_BaseSearchCard_Control_CardTextLabel_Push.GetWordNameForRegister

function TkwEnBaseSearchCardPnlMain.pnlMain(const aCtx: TtfwContext;
 aen_BaseSearchCard: Ten_BaseSearchCard): TvtPanel;
 {* ���������� ����� ������� .Ten_BaseSearchCard.pnlMain }
//#UC START# *0A20442D75CC_C1D4470B9513_var*
//#UC END# *0A20442D75CC_C1D4470B9513_var*
begin
//#UC START# *0A20442D75CC_C1D4470B9513_impl*
 !!! Needs to be implemented !!!
//#UC END# *0A20442D75CC_C1D4470B9513_impl*
end;//TkwEnBaseSearchCardPnlMain.pnlMain

procedure TkwEnBaseSearchCardPnlMain.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C1D4470B9513_var*
//#UC END# *4DAEEDE10285_C1D4470B9513_var*
begin
//#UC START# *4DAEEDE10285_C1D4470B9513_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C1D4470B9513_impl*
end;//TkwEnBaseSearchCardPnlMain.DoDoIt

class function TkwEnBaseSearchCardPnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_BaseSearchCard.pnlMain';
end;//TkwEnBaseSearchCardPnlMain.GetWordNameForRegister

procedure TkwEnBaseSearchCardPnlMain.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C1D4470B9513_var*
//#UC END# *52D00B00031A_C1D4470B9513_var*
begin
//#UC START# *52D00B00031A_C1D4470B9513_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C1D4470B9513_impl*
end;//TkwEnBaseSearchCardPnlMain.SetValuePrim

function TkwEnBaseSearchCardPnlMain.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C1D4470B9513_var*
//#UC END# *551544E2001A_C1D4470B9513_var*
begin
//#UC START# *551544E2001A_C1D4470B9513_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C1D4470B9513_impl*
end;//TkwEnBaseSearchCardPnlMain.GetResultTypeInfo

function TkwEnBaseSearchCardPnlMain.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_C1D4470B9513_var*
//#UC END# *559687E6025A_C1D4470B9513_var*
begin
//#UC START# *559687E6025A_C1D4470B9513_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_C1D4470B9513_impl*
end;//TkwEnBaseSearchCardPnlMain.GetAllParamsCount

function TkwEnBaseSearchCardPnlMain.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C1D4470B9513_var*
//#UC END# *5617F4D00243_C1D4470B9513_var*
begin
//#UC START# *5617F4D00243_C1D4470B9513_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C1D4470B9513_impl*
end;//TkwEnBaseSearchCardPnlMain.ParamsTypes

function TkwEnBaseSearchCardHfBaseSearch.hfBaseSearch(const aCtx: TtfwContext;
 aen_BaseSearchCard: Ten_BaseSearchCard): TnscHideField;
 {* ���������� ����� ������� .Ten_BaseSearchCard.hfBaseSearch }
//#UC START# *5EE2B67AC37A_CAA6BD51B722_var*
//#UC END# *5EE2B67AC37A_CAA6BD51B722_var*
begin
//#UC START# *5EE2B67AC37A_CAA6BD51B722_impl*
 !!! Needs to be implemented !!!
//#UC END# *5EE2B67AC37A_CAA6BD51B722_impl*
end;//TkwEnBaseSearchCardHfBaseSearch.hfBaseSearch

procedure TkwEnBaseSearchCardHfBaseSearch.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CAA6BD51B722_var*
//#UC END# *4DAEEDE10285_CAA6BD51B722_var*
begin
//#UC START# *4DAEEDE10285_CAA6BD51B722_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CAA6BD51B722_impl*
end;//TkwEnBaseSearchCardHfBaseSearch.DoDoIt

class function TkwEnBaseSearchCardHfBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_BaseSearchCard.hfBaseSearch';
end;//TkwEnBaseSearchCardHfBaseSearch.GetWordNameForRegister

procedure TkwEnBaseSearchCardHfBaseSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_CAA6BD51B722_var*
//#UC END# *52D00B00031A_CAA6BD51B722_var*
begin
//#UC START# *52D00B00031A_CAA6BD51B722_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_CAA6BD51B722_impl*
end;//TkwEnBaseSearchCardHfBaseSearch.SetValuePrim

function TkwEnBaseSearchCardHfBaseSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_CAA6BD51B722_var*
//#UC END# *551544E2001A_CAA6BD51B722_var*
begin
//#UC START# *551544E2001A_CAA6BD51B722_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_CAA6BD51B722_impl*
end;//TkwEnBaseSearchCardHfBaseSearch.GetResultTypeInfo

function TkwEnBaseSearchCardHfBaseSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_CAA6BD51B722_var*
//#UC END# *559687E6025A_CAA6BD51B722_var*
begin
//#UC START# *559687E6025A_CAA6BD51B722_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_CAA6BD51B722_impl*
end;//TkwEnBaseSearchCardHfBaseSearch.GetAllParamsCount

function TkwEnBaseSearchCardHfBaseSearch.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_CAA6BD51B722_var*
//#UC END# *5617F4D00243_CAA6BD51B722_var*
begin
//#UC START# *5617F4D00243_CAA6BD51B722_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_CAA6BD51B722_impl*
end;//TkwEnBaseSearchCardHfBaseSearch.ParamsTypes

function TkwEnBaseSearchCardLrBaseSearch.lrBaseSearch(const aCtx: TtfwContext;
 aen_BaseSearchCard: Ten_BaseSearchCard): TnscLister;
 {* ���������� ����� ������� .Ten_BaseSearchCard.lrBaseSearch }
//#UC START# *8BEB55BB73D6_C952194702DA_var*
//#UC END# *8BEB55BB73D6_C952194702DA_var*
begin
//#UC START# *8BEB55BB73D6_C952194702DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *8BEB55BB73D6_C952194702DA_impl*
end;//TkwEnBaseSearchCardLrBaseSearch.lrBaseSearch

procedure TkwEnBaseSearchCardLrBaseSearch.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C952194702DA_var*
//#UC END# *4DAEEDE10285_C952194702DA_var*
begin
//#UC START# *4DAEEDE10285_C952194702DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C952194702DA_impl*
end;//TkwEnBaseSearchCardLrBaseSearch.DoDoIt

class function TkwEnBaseSearchCardLrBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_BaseSearchCard.lrBaseSearch';
end;//TkwEnBaseSearchCardLrBaseSearch.GetWordNameForRegister

procedure TkwEnBaseSearchCardLrBaseSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C952194702DA_var*
//#UC END# *52D00B00031A_C952194702DA_var*
begin
//#UC START# *52D00B00031A_C952194702DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C952194702DA_impl*
end;//TkwEnBaseSearchCardLrBaseSearch.SetValuePrim

function TkwEnBaseSearchCardLrBaseSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C952194702DA_var*
//#UC END# *551544E2001A_C952194702DA_var*
begin
//#UC START# *551544E2001A_C952194702DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C952194702DA_impl*
end;//TkwEnBaseSearchCardLrBaseSearch.GetResultTypeInfo

function TkwEnBaseSearchCardLrBaseSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_C952194702DA_var*
//#UC END# *559687E6025A_C952194702DA_var*
begin
//#UC START# *559687E6025A_C952194702DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_C952194702DA_impl*
end;//TkwEnBaseSearchCardLrBaseSearch.GetAllParamsCount

function TkwEnBaseSearchCardLrBaseSearch.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C952194702DA_var*
//#UC END# *5617F4D00243_C952194702DA_var*
begin
//#UC START# *5617F4D00243_C952194702DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C952194702DA_impl*
end;//TkwEnBaseSearchCardLrBaseSearch.ParamsTypes

function TkwEnBaseSearchCardCardTextLabel.CardTextLabel(const aCtx: TtfwContext;
 aen_BaseSearchCard: Ten_BaseSearchCard): TnscSimpleEditor;
 {* ���������� ����� ������� .Ten_BaseSearchCard.CardTextLabel }
//#UC START# *062C1AB7AABF_A6D5CED27A65_var*
//#UC END# *062C1AB7AABF_A6D5CED27A65_var*
begin
//#UC START# *062C1AB7AABF_A6D5CED27A65_impl*
 !!! Needs to be implemented !!!
//#UC END# *062C1AB7AABF_A6D5CED27A65_impl*
end;//TkwEnBaseSearchCardCardTextLabel.CardTextLabel

procedure TkwEnBaseSearchCardCardTextLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A6D5CED27A65_var*
//#UC END# *4DAEEDE10285_A6D5CED27A65_var*
begin
//#UC START# *4DAEEDE10285_A6D5CED27A65_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A6D5CED27A65_impl*
end;//TkwEnBaseSearchCardCardTextLabel.DoDoIt

class function TkwEnBaseSearchCardCardTextLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_BaseSearchCard.CardTextLabel';
end;//TkwEnBaseSearchCardCardTextLabel.GetWordNameForRegister

procedure TkwEnBaseSearchCardCardTextLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A6D5CED27A65_var*
//#UC END# *52D00B00031A_A6D5CED27A65_var*
begin
//#UC START# *52D00B00031A_A6D5CED27A65_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A6D5CED27A65_impl*
end;//TkwEnBaseSearchCardCardTextLabel.SetValuePrim

function TkwEnBaseSearchCardCardTextLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_A6D5CED27A65_var*
//#UC END# *551544E2001A_A6D5CED27A65_var*
begin
//#UC START# *551544E2001A_A6D5CED27A65_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A6D5CED27A65_impl*
end;//TkwEnBaseSearchCardCardTextLabel.GetResultTypeInfo

function TkwEnBaseSearchCardCardTextLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_A6D5CED27A65_var*
//#UC END# *559687E6025A_A6D5CED27A65_var*
begin
//#UC START# *559687E6025A_A6D5CED27A65_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_A6D5CED27A65_impl*
end;//TkwEnBaseSearchCardCardTextLabel.GetAllParamsCount

function TkwEnBaseSearchCardCardTextLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_A6D5CED27A65_var*
//#UC END# *5617F4D00243_A6D5CED27A65_var*
begin
//#UC START# *5617F4D00243_A6D5CED27A65_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A6D5CED27A65_impl*
end;//TkwEnBaseSearchCardCardTextLabel.ParamsTypes

initialization
 Tkw_Form_BaseSearchCard.RegisterInEngine;
 {* ����������� Tkw_Form_BaseSearchCard }
 Tkw_BaseSearchCard_Control_pnlMain.RegisterInEngine;
 {* ����������� Tkw_BaseSearchCard_Control_pnlMain }
 Tkw_BaseSearchCard_Control_pnlMain_Push.RegisterInEngine;
 {* ����������� Tkw_BaseSearchCard_Control_pnlMain_Push }
 Tkw_BaseSearchCard_Control_hfBaseSearch.RegisterInEngine;
 {* ����������� Tkw_BaseSearchCard_Control_hfBaseSearch }
 Tkw_BaseSearchCard_Control_hfBaseSearch_Push.RegisterInEngine;
 {* ����������� Tkw_BaseSearchCard_Control_hfBaseSearch_Push }
 Tkw_BaseSearchCard_Control_lrBaseSearch.RegisterInEngine;
 {* ����������� Tkw_BaseSearchCard_Control_lrBaseSearch }
 Tkw_BaseSearchCard_Control_lrBaseSearch_Push.RegisterInEngine;
 {* ����������� Tkw_BaseSearchCard_Control_lrBaseSearch_Push }
 Tkw_BaseSearchCard_Control_CardTextLabel.RegisterInEngine;
 {* ����������� Tkw_BaseSearchCard_Control_CardTextLabel }
 Tkw_BaseSearchCard_Control_CardTextLabel_Push.RegisterInEngine;
 {* ����������� Tkw_BaseSearchCard_Control_CardTextLabel_Push }
 TkwEnBaseSearchCardPnlMain.RegisterInEngine;
 {* ����������� en_BaseSearchCard_pnlMain }
 TkwEnBaseSearchCardHfBaseSearch.RegisterInEngine;
 {* ����������� en_BaseSearchCard_hfBaseSearch }
 TkwEnBaseSearchCardLrBaseSearch.RegisterInEngine;
 {* ����������� en_BaseSearchCard_lrBaseSearch }
 TkwEnBaseSearchCardCardTextLabel.RegisterInEngine;
 {* ����������� en_BaseSearchCard_CardTextLabel }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_BaseSearchCard));
 {* ����������� ���� BaseSearchCard }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscHideField));
 {* ����������� ���� TnscHideField }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscLister));
 {* ����������� ���� TnscLister }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscSimpleEditor));
 {* ����������� ���� TnscSimpleEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
