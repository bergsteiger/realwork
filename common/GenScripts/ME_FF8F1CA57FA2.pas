unit BaseSearchCardKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� BaseSearchCard }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\BaseSearchCardKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , BaseSearchCard_Form
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
begin
 Result := 'en_BaseSearchCard';
end;//Tkw_Form_BaseSearchCard.GetString

class function Tkw_BaseSearchCard_Control_pnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlMain';
end;//Tkw_BaseSearchCard_Control_pnlMain.GetWordNameForRegister

function Tkw_BaseSearchCard_Control_pnlMain.GetString: AnsiString;
begin
 Result := 'pnlMain';
end;//Tkw_BaseSearchCard_Control_pnlMain.GetString

class procedure Tkw_BaseSearchCard_Control_pnlMain.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_BaseSearchCard_Control_pnlMain.RegisterInEngine

procedure Tkw_BaseSearchCard_Control_pnlMain_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlMain');
 inherited;
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
begin
 Result := 'hfBaseSearch';
end;//Tkw_BaseSearchCard_Control_hfBaseSearch.GetString

class procedure Tkw_BaseSearchCard_Control_hfBaseSearch.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_BaseSearchCard_Control_hfBaseSearch.RegisterInEngine

procedure Tkw_BaseSearchCard_Control_hfBaseSearch_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfBaseSearch');
 inherited;
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
begin
 Result := 'lrBaseSearch';
end;//Tkw_BaseSearchCard_Control_lrBaseSearch.GetString

class procedure Tkw_BaseSearchCard_Control_lrBaseSearch.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscLister);
end;//Tkw_BaseSearchCard_Control_lrBaseSearch.RegisterInEngine

procedure Tkw_BaseSearchCard_Control_lrBaseSearch_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lrBaseSearch');
 inherited;
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
begin
 Result := 'CardTextLabel';
end;//Tkw_BaseSearchCard_Control_CardTextLabel.GetString

class procedure Tkw_BaseSearchCard_Control_CardTextLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscSimpleEditor);
end;//Tkw_BaseSearchCard_Control_CardTextLabel.RegisterInEngine

procedure Tkw_BaseSearchCard_Control_CardTextLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('CardTextLabel');
 inherited;
end;//Tkw_BaseSearchCard_Control_CardTextLabel_Push.DoDoIt

class function Tkw_BaseSearchCard_Control_CardTextLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::CardTextLabel:push';
end;//Tkw_BaseSearchCard_Control_CardTextLabel_Push.GetWordNameForRegister

function TkwEnBaseSearchCardPnlMain.pnlMain(const aCtx: TtfwContext;
 aen_BaseSearchCard: Ten_BaseSearchCard): TvtPanel;
 {* ���������� ����� ������� .Ten_BaseSearchCard.pnlMain }
begin
 Result := aen_BaseSearchCard.pnlMain;
end;//TkwEnBaseSearchCardPnlMain.pnlMain

procedure TkwEnBaseSearchCardPnlMain.DoDoIt(const aCtx: TtfwContext);
var l_aen_BaseSearchCard: Ten_BaseSearchCard;
begin
 try
  l_aen_BaseSearchCard := Ten_BaseSearchCard(aCtx.rEngine.PopObjAs(Ten_BaseSearchCard));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_BaseSearchCard: Ten_BaseSearchCard : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlMain(aCtx, l_aen_BaseSearchCard));
end;//TkwEnBaseSearchCardPnlMain.DoDoIt

class function TkwEnBaseSearchCardPnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_BaseSearchCard.pnlMain';
end;//TkwEnBaseSearchCardPnlMain.GetWordNameForRegister

procedure TkwEnBaseSearchCardPnlMain.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlMain', aCtx);
end;//TkwEnBaseSearchCardPnlMain.SetValuePrim

function TkwEnBaseSearchCardPnlMain.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnBaseSearchCardPnlMain.GetResultTypeInfo

function TkwEnBaseSearchCardPnlMain.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnBaseSearchCardPnlMain.GetAllParamsCount

function TkwEnBaseSearchCardPnlMain.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_BaseSearchCard)]);
end;//TkwEnBaseSearchCardPnlMain.ParamsTypes

function TkwEnBaseSearchCardHfBaseSearch.hfBaseSearch(const aCtx: TtfwContext;
 aen_BaseSearchCard: Ten_BaseSearchCard): TnscHideField;
 {* ���������� ����� ������� .Ten_BaseSearchCard.hfBaseSearch }
begin
 Result := aen_BaseSearchCard.hfBaseSearch;
end;//TkwEnBaseSearchCardHfBaseSearch.hfBaseSearch

procedure TkwEnBaseSearchCardHfBaseSearch.DoDoIt(const aCtx: TtfwContext);
var l_aen_BaseSearchCard: Ten_BaseSearchCard;
begin
 try
  l_aen_BaseSearchCard := Ten_BaseSearchCard(aCtx.rEngine.PopObjAs(Ten_BaseSearchCard));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_BaseSearchCard: Ten_BaseSearchCard : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfBaseSearch(aCtx, l_aen_BaseSearchCard));
end;//TkwEnBaseSearchCardHfBaseSearch.DoDoIt

class function TkwEnBaseSearchCardHfBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_BaseSearchCard.hfBaseSearch';
end;//TkwEnBaseSearchCardHfBaseSearch.GetWordNameForRegister

procedure TkwEnBaseSearchCardHfBaseSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� hfBaseSearch', aCtx);
end;//TkwEnBaseSearchCardHfBaseSearch.SetValuePrim

function TkwEnBaseSearchCardHfBaseSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnBaseSearchCardHfBaseSearch.GetResultTypeInfo

function TkwEnBaseSearchCardHfBaseSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnBaseSearchCardHfBaseSearch.GetAllParamsCount

function TkwEnBaseSearchCardHfBaseSearch.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_BaseSearchCard)]);
end;//TkwEnBaseSearchCardHfBaseSearch.ParamsTypes

function TkwEnBaseSearchCardLrBaseSearch.lrBaseSearch(const aCtx: TtfwContext;
 aen_BaseSearchCard: Ten_BaseSearchCard): TnscLister;
 {* ���������� ����� ������� .Ten_BaseSearchCard.lrBaseSearch }
begin
 Result := aen_BaseSearchCard.lrBaseSearch;
end;//TkwEnBaseSearchCardLrBaseSearch.lrBaseSearch

procedure TkwEnBaseSearchCardLrBaseSearch.DoDoIt(const aCtx: TtfwContext);
var l_aen_BaseSearchCard: Ten_BaseSearchCard;
begin
 try
  l_aen_BaseSearchCard := Ten_BaseSearchCard(aCtx.rEngine.PopObjAs(Ten_BaseSearchCard));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_BaseSearchCard: Ten_BaseSearchCard : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lrBaseSearch(aCtx, l_aen_BaseSearchCard));
end;//TkwEnBaseSearchCardLrBaseSearch.DoDoIt

class function TkwEnBaseSearchCardLrBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_BaseSearchCard.lrBaseSearch';
end;//TkwEnBaseSearchCardLrBaseSearch.GetWordNameForRegister

procedure TkwEnBaseSearchCardLrBaseSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lrBaseSearch', aCtx);
end;//TkwEnBaseSearchCardLrBaseSearch.SetValuePrim

function TkwEnBaseSearchCardLrBaseSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscLister);
end;//TkwEnBaseSearchCardLrBaseSearch.GetResultTypeInfo

function TkwEnBaseSearchCardLrBaseSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnBaseSearchCardLrBaseSearch.GetAllParamsCount

function TkwEnBaseSearchCardLrBaseSearch.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_BaseSearchCard)]);
end;//TkwEnBaseSearchCardLrBaseSearch.ParamsTypes

function TkwEnBaseSearchCardCardTextLabel.CardTextLabel(const aCtx: TtfwContext;
 aen_BaseSearchCard: Ten_BaseSearchCard): TnscSimpleEditor;
 {* ���������� ����� ������� .Ten_BaseSearchCard.CardTextLabel }
begin
 Result := aen_BaseSearchCard.CardTextLabel;
end;//TkwEnBaseSearchCardCardTextLabel.CardTextLabel

procedure TkwEnBaseSearchCardCardTextLabel.DoDoIt(const aCtx: TtfwContext);
var l_aen_BaseSearchCard: Ten_BaseSearchCard;
begin
 try
  l_aen_BaseSearchCard := Ten_BaseSearchCard(aCtx.rEngine.PopObjAs(Ten_BaseSearchCard));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_BaseSearchCard: Ten_BaseSearchCard : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(CardTextLabel(aCtx, l_aen_BaseSearchCard));
end;//TkwEnBaseSearchCardCardTextLabel.DoDoIt

class function TkwEnBaseSearchCardCardTextLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_BaseSearchCard.CardTextLabel';
end;//TkwEnBaseSearchCardCardTextLabel.GetWordNameForRegister

procedure TkwEnBaseSearchCardCardTextLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� CardTextLabel', aCtx);
end;//TkwEnBaseSearchCardCardTextLabel.SetValuePrim

function TkwEnBaseSearchCardCardTextLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscSimpleEditor);
end;//TkwEnBaseSearchCardCardTextLabel.GetResultTypeInfo

function TkwEnBaseSearchCardCardTextLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnBaseSearchCardCardTextLabel.GetAllParamsCount

function TkwEnBaseSearchCardCardTextLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_BaseSearchCard)]);
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
