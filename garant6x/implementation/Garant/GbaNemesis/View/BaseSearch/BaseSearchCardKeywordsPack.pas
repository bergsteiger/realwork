unit BaseSearchCardKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaseSearch/BaseSearchCardKeywordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 �������� ����������::BaseSearch::View::BaseSearch$Module::BaseSearch::BaseSearchCardKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� BaseSearchCard
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
  vtPanel,
  BaseSearchCard_Form
  {$If defined(Nemesis)}
  ,
  nscHideField
  {$IfEnd} //Nemesis
  ,
  nscSimpleEditor,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString
  {$If defined(Nemesis)}
  ,
  nscLister
  {$IfEnd} //Nemesis
  ,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_BaseSearchCard = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� BaseSearchCard
----
*������ �������������*:
[code]
'aControl' �����::BaseSearchCard TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_BaseSearchCard

// start class Tkw_Form_BaseSearchCard

class function Tkw_Form_BaseSearchCard.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::BaseSearchCard';
end;//Tkw_Form_BaseSearchCard.GetWordNameForRegister

function Tkw_Form_BaseSearchCard.GetString: AnsiString;
 {-}
begin
 Result := 'en_BaseSearchCard';
end;//Tkw_Form_BaseSearchCard.GetString

type
  Tkw_BaseSearchCard_Control_pnlMain = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pnlMain
----
*������ �������������*:
[code]
�������::pnlMain TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_BaseSearchCard_Control_pnlMain

// start class Tkw_BaseSearchCard_Control_pnlMain

class function Tkw_BaseSearchCard_Control_pnlMain.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlMain';
end;//Tkw_BaseSearchCard_Control_pnlMain.GetWordNameForRegister

function Tkw_BaseSearchCard_Control_pnlMain.GetString: AnsiString;
 {-}
begin
 Result := 'pnlMain';
end;//Tkw_BaseSearchCard_Control_pnlMain.GetString

class procedure Tkw_BaseSearchCard_Control_pnlMain.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_BaseSearchCard_Control_pnlMain.RegisterInEngine

type
  Tkw_BaseSearchCard_Control_pnlMain_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pnlMain
----
*������ �������������*:
[code]
�������::pnlMain:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_BaseSearchCard_Control_pnlMain_Push

// start class Tkw_BaseSearchCard_Control_pnlMain_Push

procedure Tkw_BaseSearchCard_Control_pnlMain_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlMain');
 inherited;
end;//Tkw_BaseSearchCard_Control_pnlMain_Push.DoDoIt

class function Tkw_BaseSearchCard_Control_pnlMain_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlMain:push';
end;//Tkw_BaseSearchCard_Control_pnlMain_Push.GetWordNameForRegister

type
  Tkw_BaseSearchCard_Control_hfBaseSearch = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� hfBaseSearch
----
*������ �������������*:
[code]
�������::hfBaseSearch TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_BaseSearchCard_Control_hfBaseSearch

// start class Tkw_BaseSearchCard_Control_hfBaseSearch

class function Tkw_BaseSearchCard_Control_hfBaseSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::hfBaseSearch';
end;//Tkw_BaseSearchCard_Control_hfBaseSearch.GetWordNameForRegister

function Tkw_BaseSearchCard_Control_hfBaseSearch.GetString: AnsiString;
 {-}
begin
 Result := 'hfBaseSearch';
end;//Tkw_BaseSearchCard_Control_hfBaseSearch.GetString

class procedure Tkw_BaseSearchCard_Control_hfBaseSearch.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_BaseSearchCard_Control_hfBaseSearch.RegisterInEngine

type
  Tkw_BaseSearchCard_Control_hfBaseSearch_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� hfBaseSearch
----
*������ �������������*:
[code]
�������::hfBaseSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_BaseSearchCard_Control_hfBaseSearch_Push

// start class Tkw_BaseSearchCard_Control_hfBaseSearch_Push

procedure Tkw_BaseSearchCard_Control_hfBaseSearch_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('hfBaseSearch');
 inherited;
end;//Tkw_BaseSearchCard_Control_hfBaseSearch_Push.DoDoIt

class function Tkw_BaseSearchCard_Control_hfBaseSearch_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::hfBaseSearch:push';
end;//Tkw_BaseSearchCard_Control_hfBaseSearch_Push.GetWordNameForRegister

type
  Tkw_BaseSearchCard_Control_lrBaseSearch = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� lrBaseSearch
----
*������ �������������*:
[code]
�������::lrBaseSearch TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_BaseSearchCard_Control_lrBaseSearch

// start class Tkw_BaseSearchCard_Control_lrBaseSearch

class function Tkw_BaseSearchCard_Control_lrBaseSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::lrBaseSearch';
end;//Tkw_BaseSearchCard_Control_lrBaseSearch.GetWordNameForRegister

function Tkw_BaseSearchCard_Control_lrBaseSearch.GetString: AnsiString;
 {-}
begin
 Result := 'lrBaseSearch';
end;//Tkw_BaseSearchCard_Control_lrBaseSearch.GetString

class procedure Tkw_BaseSearchCard_Control_lrBaseSearch.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscLister);
end;//Tkw_BaseSearchCard_Control_lrBaseSearch.RegisterInEngine

type
  Tkw_BaseSearchCard_Control_lrBaseSearch_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� lrBaseSearch
----
*������ �������������*:
[code]
�������::lrBaseSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_BaseSearchCard_Control_lrBaseSearch_Push

// start class Tkw_BaseSearchCard_Control_lrBaseSearch_Push

procedure Tkw_BaseSearchCard_Control_lrBaseSearch_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lrBaseSearch');
 inherited;
end;//Tkw_BaseSearchCard_Control_lrBaseSearch_Push.DoDoIt

class function Tkw_BaseSearchCard_Control_lrBaseSearch_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::lrBaseSearch:push';
end;//Tkw_BaseSearchCard_Control_lrBaseSearch_Push.GetWordNameForRegister

type
  Tkw_BaseSearchCard_Control_CardTextLabel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� CardTextLabel
----
*������ �������������*:
[code]
�������::CardTextLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_BaseSearchCard_Control_CardTextLabel

// start class Tkw_BaseSearchCard_Control_CardTextLabel

class function Tkw_BaseSearchCard_Control_CardTextLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::CardTextLabel';
end;//Tkw_BaseSearchCard_Control_CardTextLabel.GetWordNameForRegister

function Tkw_BaseSearchCard_Control_CardTextLabel.GetString: AnsiString;
 {-}
begin
 Result := 'CardTextLabel';
end;//Tkw_BaseSearchCard_Control_CardTextLabel.GetString

class procedure Tkw_BaseSearchCard_Control_CardTextLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscSimpleEditor);
end;//Tkw_BaseSearchCard_Control_CardTextLabel.RegisterInEngine

type
  Tkw_BaseSearchCard_Control_CardTextLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� CardTextLabel
----
*������ �������������*:
[code]
�������::CardTextLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_BaseSearchCard_Control_CardTextLabel_Push

// start class Tkw_BaseSearchCard_Control_CardTextLabel_Push

procedure Tkw_BaseSearchCard_Control_CardTextLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('CardTextLabel');
 inherited;
end;//Tkw_BaseSearchCard_Control_CardTextLabel_Push.DoDoIt

class function Tkw_BaseSearchCard_Control_CardTextLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::CardTextLabel:push';
end;//Tkw_BaseSearchCard_Control_CardTextLabel_Push.GetWordNameForRegister

type
  TkwEnBaseSearchCardPnlMain = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_BaseSearchCard.pnlMain
[panel]������� pnlMain ����� Ten_BaseSearchCard[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aen_BaseSearchCard .Ten_BaseSearchCard.pnlMain >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlMain(const aCtx: TtfwContext;
     aen_BaseSearchCard: Ten_BaseSearchCard): TvtPanel;
     {* ���������� ����� ������� .Ten_BaseSearchCard.pnlMain }
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
  end;//TkwEnBaseSearchCardPnlMain

// start class TkwEnBaseSearchCardPnlMain

function TkwEnBaseSearchCardPnlMain.PnlMain(const aCtx: TtfwContext;
  aen_BaseSearchCard: Ten_BaseSearchCard): TvtPanel;
 {-}
begin
 Result := aen_BaseSearchCard.pnlMain;
end;//TkwEnBaseSearchCardPnlMain.PnlMain

procedure TkwEnBaseSearchCardPnlMain.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_BaseSearchCard : Ten_BaseSearchCard;
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
 aCtx.rEngine.PushObj((PnlMain(aCtx, l_aen_BaseSearchCard)));
end;//TkwEnBaseSearchCardPnlMain.DoDoIt

class function TkwEnBaseSearchCardPnlMain.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_BaseSearchCard.pnlMain';
end;//TkwEnBaseSearchCardPnlMain.GetWordNameForRegister

procedure TkwEnBaseSearchCardPnlMain.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnlMain', aCtx);
end;//TkwEnBaseSearchCardPnlMain.SetValuePrim

function TkwEnBaseSearchCardPnlMain.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnBaseSearchCardPnlMain.GetResultTypeInfo

function TkwEnBaseSearchCardPnlMain.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnBaseSearchCardPnlMain.GetAllParamsCount

function TkwEnBaseSearchCardPnlMain.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_BaseSearchCard)]);
end;//TkwEnBaseSearchCardPnlMain.ParamsTypes

type
  TkwEnBaseSearchCardHfBaseSearch = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_BaseSearchCard.hfBaseSearch
[panel]������� hfBaseSearch ����� Ten_BaseSearchCard[panel]
*��� ����������:* TnscHideField
*������:*
[code]
OBJECT VAR l_TnscHideField
 aen_BaseSearchCard .Ten_BaseSearchCard.hfBaseSearch >>> l_TnscHideField
[code]  }
  private
  // private methods
   function HfBaseSearch(const aCtx: TtfwContext;
     aen_BaseSearchCard: Ten_BaseSearchCard): TnscHideField;
     {* ���������� ����� ������� .Ten_BaseSearchCard.hfBaseSearch }
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
  end;//TkwEnBaseSearchCardHfBaseSearch

// start class TkwEnBaseSearchCardHfBaseSearch

function TkwEnBaseSearchCardHfBaseSearch.HfBaseSearch(const aCtx: TtfwContext;
  aen_BaseSearchCard: Ten_BaseSearchCard): TnscHideField;
 {-}
begin
 Result := aen_BaseSearchCard.hfBaseSearch;
end;//TkwEnBaseSearchCardHfBaseSearch.HfBaseSearch

procedure TkwEnBaseSearchCardHfBaseSearch.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_BaseSearchCard : Ten_BaseSearchCard;
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
 aCtx.rEngine.PushObj((HfBaseSearch(aCtx, l_aen_BaseSearchCard)));
end;//TkwEnBaseSearchCardHfBaseSearch.DoDoIt

class function TkwEnBaseSearchCardHfBaseSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_BaseSearchCard.hfBaseSearch';
end;//TkwEnBaseSearchCardHfBaseSearch.GetWordNameForRegister

procedure TkwEnBaseSearchCardHfBaseSearch.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� hfBaseSearch', aCtx);
end;//TkwEnBaseSearchCardHfBaseSearch.SetValuePrim

function TkwEnBaseSearchCardHfBaseSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnBaseSearchCardHfBaseSearch.GetResultTypeInfo

function TkwEnBaseSearchCardHfBaseSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnBaseSearchCardHfBaseSearch.GetAllParamsCount

function TkwEnBaseSearchCardHfBaseSearch.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_BaseSearchCard)]);
end;//TkwEnBaseSearchCardHfBaseSearch.ParamsTypes

type
  TkwEnBaseSearchCardLrBaseSearch = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_BaseSearchCard.lrBaseSearch
[panel]������� lrBaseSearch ����� Ten_BaseSearchCard[panel]
*��� ����������:* TnscLister
*������:*
[code]
OBJECT VAR l_TnscLister
 aen_BaseSearchCard .Ten_BaseSearchCard.lrBaseSearch >>> l_TnscLister
[code]  }
  private
  // private methods
   function LrBaseSearch(const aCtx: TtfwContext;
     aen_BaseSearchCard: Ten_BaseSearchCard): TnscLister;
     {* ���������� ����� ������� .Ten_BaseSearchCard.lrBaseSearch }
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
  end;//TkwEnBaseSearchCardLrBaseSearch

// start class TkwEnBaseSearchCardLrBaseSearch

function TkwEnBaseSearchCardLrBaseSearch.LrBaseSearch(const aCtx: TtfwContext;
  aen_BaseSearchCard: Ten_BaseSearchCard): TnscLister;
 {-}
begin
 Result := aen_BaseSearchCard.lrBaseSearch;
end;//TkwEnBaseSearchCardLrBaseSearch.LrBaseSearch

procedure TkwEnBaseSearchCardLrBaseSearch.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_BaseSearchCard : Ten_BaseSearchCard;
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
 aCtx.rEngine.PushObj((LrBaseSearch(aCtx, l_aen_BaseSearchCard)));
end;//TkwEnBaseSearchCardLrBaseSearch.DoDoIt

class function TkwEnBaseSearchCardLrBaseSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_BaseSearchCard.lrBaseSearch';
end;//TkwEnBaseSearchCardLrBaseSearch.GetWordNameForRegister

procedure TkwEnBaseSearchCardLrBaseSearch.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� lrBaseSearch', aCtx);
end;//TkwEnBaseSearchCardLrBaseSearch.SetValuePrim

function TkwEnBaseSearchCardLrBaseSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscLister);
end;//TkwEnBaseSearchCardLrBaseSearch.GetResultTypeInfo

function TkwEnBaseSearchCardLrBaseSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnBaseSearchCardLrBaseSearch.GetAllParamsCount

function TkwEnBaseSearchCardLrBaseSearch.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_BaseSearchCard)]);
end;//TkwEnBaseSearchCardLrBaseSearch.ParamsTypes

type
  TkwEnBaseSearchCardCardTextLabel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_BaseSearchCard.CardTextLabel
[panel]������� CardTextLabel ����� Ten_BaseSearchCard[panel]
*��� ����������:* TnscSimpleEditor
*������:*
[code]
OBJECT VAR l_TnscSimpleEditor
 aen_BaseSearchCard .Ten_BaseSearchCard.CardTextLabel >>> l_TnscSimpleEditor
[code]  }
  private
  // private methods
   function CardTextLabel(const aCtx: TtfwContext;
     aen_BaseSearchCard: Ten_BaseSearchCard): TnscSimpleEditor;
     {* ���������� ����� ������� .Ten_BaseSearchCard.CardTextLabel }
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
  end;//TkwEnBaseSearchCardCardTextLabel

// start class TkwEnBaseSearchCardCardTextLabel

function TkwEnBaseSearchCardCardTextLabel.CardTextLabel(const aCtx: TtfwContext;
  aen_BaseSearchCard: Ten_BaseSearchCard): TnscSimpleEditor;
 {-}
begin
 Result := aen_BaseSearchCard.CardTextLabel;
end;//TkwEnBaseSearchCardCardTextLabel.CardTextLabel

procedure TkwEnBaseSearchCardCardTextLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_BaseSearchCard : Ten_BaseSearchCard;
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
 aCtx.rEngine.PushObj((CardTextLabel(aCtx, l_aen_BaseSearchCard)));
end;//TkwEnBaseSearchCardCardTextLabel.DoDoIt

class function TkwEnBaseSearchCardCardTextLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_BaseSearchCard.CardTextLabel';
end;//TkwEnBaseSearchCardCardTextLabel.GetWordNameForRegister

procedure TkwEnBaseSearchCardCardTextLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� CardTextLabel', aCtx);
end;//TkwEnBaseSearchCardCardTextLabel.SetValuePrim

function TkwEnBaseSearchCardCardTextLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscSimpleEditor);
end;//TkwEnBaseSearchCardCardTextLabel.GetResultTypeInfo

function TkwEnBaseSearchCardCardTextLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnBaseSearchCardCardTextLabel.GetAllParamsCount

function TkwEnBaseSearchCardCardTextLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_BaseSearchCard)]);
end;//TkwEnBaseSearchCardCardTextLabel.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_BaseSearchCard
 Tkw_Form_BaseSearchCard.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_BaseSearchCard_Control_pnlMain
 Tkw_BaseSearchCard_Control_pnlMain.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_BaseSearchCard_Control_pnlMain_Push
 Tkw_BaseSearchCard_Control_pnlMain_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_BaseSearchCard_Control_hfBaseSearch
 Tkw_BaseSearchCard_Control_hfBaseSearch.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_BaseSearchCard_Control_hfBaseSearch_Push
 Tkw_BaseSearchCard_Control_hfBaseSearch_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_BaseSearchCard_Control_lrBaseSearch
 Tkw_BaseSearchCard_Control_lrBaseSearch.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_BaseSearchCard_Control_lrBaseSearch_Push
 Tkw_BaseSearchCard_Control_lrBaseSearch_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_BaseSearchCard_Control_CardTextLabel
 Tkw_BaseSearchCard_Control_CardTextLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_BaseSearchCard_Control_CardTextLabel_Push
 Tkw_BaseSearchCard_Control_CardTextLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_BaseSearchCard_pnlMain
 TkwEnBaseSearchCardPnlMain.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_BaseSearchCard_hfBaseSearch
 TkwEnBaseSearchCardHfBaseSearch.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_BaseSearchCard_lrBaseSearch
 TkwEnBaseSearchCardLrBaseSearch.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_BaseSearchCard_CardTextLabel
 TkwEnBaseSearchCardCardTextLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� BaseSearchCard
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_BaseSearchCard));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscHideField
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscHideField));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscLister
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscLister));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscSimpleEditor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscSimpleEditor));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.