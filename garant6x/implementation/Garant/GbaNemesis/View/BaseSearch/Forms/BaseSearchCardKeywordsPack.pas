unit BaseSearchCardKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� BaseSearchCard }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\BaseSearchCardKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "BaseSearchCardKeywordsPack" MUID: (4AB7A34401D0_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , BaseSearchCard_Form
 , tfwPropertyLike
 , vtPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 {$If Defined(Nemesis)}
 , nscHideField
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscLister
 {$IfEnd} // Defined(Nemesis)
 , nscSimpleEditor
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwEnBaseSearchCardPnlMain = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_BaseSearchCard.pnlMain }
  private
   function pnlMain(const aCtx: TtfwContext;
    aen_BaseSearchCard: Ten_BaseSearchCard): TvtPanel;
    {* ���������� ����� ������� .Ten_BaseSearchCard.pnlMain }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnBaseSearchCardPnlMain

 TkwEnBaseSearchCardHfBaseSearch = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_BaseSearchCard.hfBaseSearch }
  private
   function hfBaseSearch(const aCtx: TtfwContext;
    aen_BaseSearchCard: Ten_BaseSearchCard): TnscHideField;
    {* ���������� ����� ������� .Ten_BaseSearchCard.hfBaseSearch }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnBaseSearchCardHfBaseSearch

 TkwEnBaseSearchCardLrBaseSearch = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_BaseSearchCard.lrBaseSearch }
  private
   function lrBaseSearch(const aCtx: TtfwContext;
    aen_BaseSearchCard: Ten_BaseSearchCard): TnscLister;
    {* ���������� ����� ������� .Ten_BaseSearchCard.lrBaseSearch }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnBaseSearchCardLrBaseSearch

 TkwEnBaseSearchCardCardTextLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_BaseSearchCard.CardTextLabel }
  private
   function CardTextLabel(const aCtx: TtfwContext;
    aen_BaseSearchCard: Ten_BaseSearchCard): TnscSimpleEditor;
    {* ���������� ����� ������� .Ten_BaseSearchCard.CardTextLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnBaseSearchCardCardTextLabel

 Tkw_Form_BaseSearchCard = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� BaseSearchCard
----
*������ �������������*:
[code]�����::BaseSearchCard TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_BaseSearchCard

 Tkw_BaseSearchCard_Control_pnlMain = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlMain
----
*������ �������������*:
[code]�������::pnlMain TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_BaseSearchCard_Control_pnlMain

 Tkw_BaseSearchCard_Control_pnlMain_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlMain
----
*������ �������������*:
[code]�������::pnlMain:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_BaseSearchCard_Control_pnlMain_Push

 Tkw_BaseSearchCard_Control_hfBaseSearch = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� hfBaseSearch
----
*������ �������������*:
[code]�������::hfBaseSearch TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_BaseSearchCard_Control_hfBaseSearch

 Tkw_BaseSearchCard_Control_hfBaseSearch_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� hfBaseSearch
----
*������ �������������*:
[code]�������::hfBaseSearch:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_BaseSearchCard_Control_hfBaseSearch_Push

 Tkw_BaseSearchCard_Control_lrBaseSearch = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lrBaseSearch
----
*������ �������������*:
[code]�������::lrBaseSearch TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_BaseSearchCard_Control_lrBaseSearch

 Tkw_BaseSearchCard_Control_lrBaseSearch_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lrBaseSearch
----
*������ �������������*:
[code]�������::lrBaseSearch:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_BaseSearchCard_Control_lrBaseSearch_Push

 Tkw_BaseSearchCard_Control_CardTextLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� CardTextLabel
----
*������ �������������*:
[code]�������::CardTextLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_BaseSearchCard_Control_CardTextLabel

 Tkw_BaseSearchCard_Control_CardTextLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� CardTextLabel
----
*������ �������������*:
[code]�������::CardTextLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_BaseSearchCard_Control_CardTextLabel_Push

function TkwEnBaseSearchCardPnlMain.pnlMain(const aCtx: TtfwContext;
 aen_BaseSearchCard: Ten_BaseSearchCard): TvtPanel;
 {* ���������� ����� ������� .Ten_BaseSearchCard.pnlMain }
begin
 Result := aen_BaseSearchCard.pnlMain;
end;//TkwEnBaseSearchCardPnlMain.pnlMain

class function TkwEnBaseSearchCardPnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_BaseSearchCard.pnlMain';
end;//TkwEnBaseSearchCardPnlMain.GetWordNameForRegister

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

procedure TkwEnBaseSearchCardPnlMain.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlMain', aCtx);
end;//TkwEnBaseSearchCardPnlMain.SetValuePrim

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

function TkwEnBaseSearchCardHfBaseSearch.hfBaseSearch(const aCtx: TtfwContext;
 aen_BaseSearchCard: Ten_BaseSearchCard): TnscHideField;
 {* ���������� ����� ������� .Ten_BaseSearchCard.hfBaseSearch }
begin
 Result := aen_BaseSearchCard.hfBaseSearch;
end;//TkwEnBaseSearchCardHfBaseSearch.hfBaseSearch

class function TkwEnBaseSearchCardHfBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_BaseSearchCard.hfBaseSearch';
end;//TkwEnBaseSearchCardHfBaseSearch.GetWordNameForRegister

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

procedure TkwEnBaseSearchCardHfBaseSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� hfBaseSearch', aCtx);
end;//TkwEnBaseSearchCardHfBaseSearch.SetValuePrim

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

function TkwEnBaseSearchCardLrBaseSearch.lrBaseSearch(const aCtx: TtfwContext;
 aen_BaseSearchCard: Ten_BaseSearchCard): TnscLister;
 {* ���������� ����� ������� .Ten_BaseSearchCard.lrBaseSearch }
begin
 Result := aen_BaseSearchCard.lrBaseSearch;
end;//TkwEnBaseSearchCardLrBaseSearch.lrBaseSearch

class function TkwEnBaseSearchCardLrBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_BaseSearchCard.lrBaseSearch';
end;//TkwEnBaseSearchCardLrBaseSearch.GetWordNameForRegister

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

procedure TkwEnBaseSearchCardLrBaseSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lrBaseSearch', aCtx);
end;//TkwEnBaseSearchCardLrBaseSearch.SetValuePrim

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

function TkwEnBaseSearchCardCardTextLabel.CardTextLabel(const aCtx: TtfwContext;
 aen_BaseSearchCard: Ten_BaseSearchCard): TnscSimpleEditor;
 {* ���������� ����� ������� .Ten_BaseSearchCard.CardTextLabel }
begin
 Result := aen_BaseSearchCard.CardTextLabel;
end;//TkwEnBaseSearchCardCardTextLabel.CardTextLabel

class function TkwEnBaseSearchCardCardTextLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_BaseSearchCard.CardTextLabel';
end;//TkwEnBaseSearchCardCardTextLabel.GetWordNameForRegister

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

procedure TkwEnBaseSearchCardCardTextLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� CardTextLabel', aCtx);
end;//TkwEnBaseSearchCardCardTextLabel.SetValuePrim

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

function Tkw_Form_BaseSearchCard.GetString: AnsiString;
begin
 Result := 'en_BaseSearchCard';
end;//Tkw_Form_BaseSearchCard.GetString

class procedure Tkw_Form_BaseSearchCard.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(Ten_BaseSearchCard);
end;//Tkw_Form_BaseSearchCard.RegisterInEngine

class function Tkw_Form_BaseSearchCard.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::BaseSearchCard';
end;//Tkw_Form_BaseSearchCard.GetWordNameForRegister

function Tkw_BaseSearchCard_Control_pnlMain.GetString: AnsiString;
begin
 Result := 'pnlMain';
end;//Tkw_BaseSearchCard_Control_pnlMain.GetString

class procedure Tkw_BaseSearchCard_Control_pnlMain.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_BaseSearchCard_Control_pnlMain.RegisterInEngine

class function Tkw_BaseSearchCard_Control_pnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlMain';
end;//Tkw_BaseSearchCard_Control_pnlMain.GetWordNameForRegister

procedure Tkw_BaseSearchCard_Control_pnlMain_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlMain');
 inherited;
end;//Tkw_BaseSearchCard_Control_pnlMain_Push.DoDoIt

class function Tkw_BaseSearchCard_Control_pnlMain_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlMain:push';
end;//Tkw_BaseSearchCard_Control_pnlMain_Push.GetWordNameForRegister

function Tkw_BaseSearchCard_Control_hfBaseSearch.GetString: AnsiString;
begin
 Result := 'hfBaseSearch';
end;//Tkw_BaseSearchCard_Control_hfBaseSearch.GetString

class procedure Tkw_BaseSearchCard_Control_hfBaseSearch.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_BaseSearchCard_Control_hfBaseSearch.RegisterInEngine

class function Tkw_BaseSearchCard_Control_hfBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::hfBaseSearch';
end;//Tkw_BaseSearchCard_Control_hfBaseSearch.GetWordNameForRegister

procedure Tkw_BaseSearchCard_Control_hfBaseSearch_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfBaseSearch');
 inherited;
end;//Tkw_BaseSearchCard_Control_hfBaseSearch_Push.DoDoIt

class function Tkw_BaseSearchCard_Control_hfBaseSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::hfBaseSearch:push';
end;//Tkw_BaseSearchCard_Control_hfBaseSearch_Push.GetWordNameForRegister

function Tkw_BaseSearchCard_Control_lrBaseSearch.GetString: AnsiString;
begin
 Result := 'lrBaseSearch';
end;//Tkw_BaseSearchCard_Control_lrBaseSearch.GetString

class procedure Tkw_BaseSearchCard_Control_lrBaseSearch.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscLister);
end;//Tkw_BaseSearchCard_Control_lrBaseSearch.RegisterInEngine

class function Tkw_BaseSearchCard_Control_lrBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lrBaseSearch';
end;//Tkw_BaseSearchCard_Control_lrBaseSearch.GetWordNameForRegister

procedure Tkw_BaseSearchCard_Control_lrBaseSearch_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lrBaseSearch');
 inherited;
end;//Tkw_BaseSearchCard_Control_lrBaseSearch_Push.DoDoIt

class function Tkw_BaseSearchCard_Control_lrBaseSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lrBaseSearch:push';
end;//Tkw_BaseSearchCard_Control_lrBaseSearch_Push.GetWordNameForRegister

function Tkw_BaseSearchCard_Control_CardTextLabel.GetString: AnsiString;
begin
 Result := 'CardTextLabel';
end;//Tkw_BaseSearchCard_Control_CardTextLabel.GetString

class procedure Tkw_BaseSearchCard_Control_CardTextLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscSimpleEditor);
end;//Tkw_BaseSearchCard_Control_CardTextLabel.RegisterInEngine

class function Tkw_BaseSearchCard_Control_CardTextLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::CardTextLabel';
end;//Tkw_BaseSearchCard_Control_CardTextLabel.GetWordNameForRegister

procedure Tkw_BaseSearchCard_Control_CardTextLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('CardTextLabel');
 inherited;
end;//Tkw_BaseSearchCard_Control_CardTextLabel_Push.DoDoIt

class function Tkw_BaseSearchCard_Control_CardTextLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::CardTextLabel:push';
end;//Tkw_BaseSearchCard_Control_CardTextLabel_Push.GetWordNameForRegister

initialization
 TkwEnBaseSearchCardPnlMain.RegisterInEngine;
 {* ����������� en_BaseSearchCard_pnlMain }
 TkwEnBaseSearchCardHfBaseSearch.RegisterInEngine;
 {* ����������� en_BaseSearchCard_hfBaseSearch }
 TkwEnBaseSearchCardLrBaseSearch.RegisterInEngine;
 {* ����������� en_BaseSearchCard_lrBaseSearch }
 TkwEnBaseSearchCardCardTextLabel.RegisterInEngine;
 {* ����������� en_BaseSearchCard_CardTextLabel }
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
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_BaseSearchCard));
 {* ����������� ���� Ten_BaseSearchCard }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscHideField));
 {* ����������� ���� TnscHideField }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscLister));
 {* ����������� ���� TnscLister }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscSimpleEditor));
 {* ����������� ���� TnscSimpleEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
