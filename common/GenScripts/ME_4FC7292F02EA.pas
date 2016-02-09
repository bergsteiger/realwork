unit MenuWordsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\MenuWordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , Menus
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Controls
 , Forms
 , l3ScreenService
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *B4809E50CD0Fci*
 //#UC END# *B4809E50CD0Fci*
 //#UC START# *B4809E50CD0Fcit*
 //#UC END# *B4809E50CD0Fcit*
 TMenuWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  public
   class function ResName: AnsiString; override;
 //#UC START# *B4809E50CD0Fpubl*
 //#UC END# *B4809E50CD0Fpubl*
 end;//TMenuWordsPackResNameGetter

 TMenuItemFriend = {abstract} class(TMenuItem)
  {* ���� ��� TMenuItem }
 end;//TMenuItemFriend

 TkwMenuItemClick = {final} class(TtfwClassLike)
  {* ����� ������� menuitem:Click
*������:*
[code]
 aMenuItem menuitem:Click
[code]  }
  private
   procedure Click(const aCtx: TtfwContext;
    aMenuItem: TMenuItem);
    {* ���������� ����� ������� menuitem:Click }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMenuItemClick

 TkwMenuItemGetItem = {final} class(TtfwClassLike)
  {* ����� ������� menuitem:GetItem
*��� ����������:* TMenuItem
*������:*
[code]
OBJECT VAR l_TMenuItem
 anIndex aMenuItem menuitem:GetItem >>> l_TMenuItem
[code]  }
  private
   function GetItem(const aCtx: TtfwContext;
    aMenuItem: TMenuItem;
    anIndex: Integer): TMenuItem;
    {* ���������� ����� ������� menuitem:GetItem }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMenuItemGetItem

 TkwMenuItemGetMenuHeight = {final} class(TtfwClassLike)
  {* ����� ������� menuitem:GetMenuHeight
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aMenuItem menuitem:GetMenuHeight >>> l_Integer
[code]  }
  private
   function GetMenuHeight(const aCtx: TtfwContext;
    aMenuItem: TMenuItem): Integer;
    {* ���������� ����� ������� menuitem:GetMenuHeight }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMenuItemGetMenuHeight

 TkwMenuItemCaption = {final} class(TtfwPropertyLike)
  {* ����� ������� menuitem:GetCaption
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aMenuItem menuitem:GetCaption >>> l_String
[code]  }
  private
   function Caption(const aCtx: TtfwContext;
    aMenuItem: TMenuItem): AnsiString;
    {* ���������� ����� ������� menuitem:GetCaption }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMenuItemCaption

 TkwMenuItemCount = {final} class(TtfwPropertyLike)
  {* ����� ������� menuitem:GetCount
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aMenuItem menuitem:GetCount >>> l_Integer
[code]  }
  private
   function Count(const aCtx: TtfwContext;
    aMenuItem: TMenuItem): Integer;
    {* ���������� ����� ������� menuitem:GetCount }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMenuItemCount

 TkwMenuItemEnabled = {final} class(TtfwPropertyLike)
  {* ����� ������� menuitem:IsEnabled
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aMenuItem menuitem:IsEnabled >>> l_Boolean
[code]  }
  private
   function Enabled(const aCtx: TtfwContext;
    aMenuItem: TMenuItem): Boolean;
    {* ���������� ����� ������� menuitem:IsEnabled }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMenuItemEnabled

 TkwMenuItemVisible = {final} class(TtfwPropertyLike)
  {* ����� ������� menuitem:IsVisible
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aMenuItem menuitem:IsVisible >>> l_Boolean
[code]  }
  private
   function Visible(const aCtx: TtfwContext;
    aMenuItem: TMenuItem): Boolean;
    {* ���������� ����� ������� menuitem:IsVisible }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMenuItemVisible

class function TMenuWordsPackResNameGetter.ResName: AnsiString;
begin
  Result := 'MenuWordsPack';
end;//TMenuWordsPackResNameGetter.ResName

 {$R MenuWordsPack.res}

procedure TkwMenuItemClick.Click(const aCtx: TtfwContext;
 aMenuItem: TMenuItem);
 {* ���������� ����� ������� menuitem:Click }
//#UC START# *FE880101357B_639406FE8331_var*
//#UC END# *FE880101357B_639406FE8331_var*
begin
//#UC START# *FE880101357B_639406FE8331_impl*
 !!! Needs to be implemented !!!
//#UC END# *FE880101357B_639406FE8331_impl*
end;//TkwMenuItemClick.Click

procedure TkwMenuItemClick.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_639406FE8331_var*
//#UC END# *4DAEEDE10285_639406FE8331_var*
begin
//#UC START# *4DAEEDE10285_639406FE8331_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_639406FE8331_impl*
end;//TkwMenuItemClick.DoDoIt

class function TkwMenuItemClick.GetWordNameForRegister: AnsiString;
begin
 Result := 'menuitem:Click';
end;//TkwMenuItemClick.GetWordNameForRegister

function TkwMenuItemClick.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwMenuItemClick.GetResultTypeInfo

function TkwMenuItemClick.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMenuItemClick.GetAllParamsCount

function TkwMenuItemClick.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_639406FE8331_var*
//#UC END# *5617F4D00243_639406FE8331_var*
begin
//#UC START# *5617F4D00243_639406FE8331_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_639406FE8331_impl*
end;//TkwMenuItemClick.ParamsTypes

function TkwMenuItemGetItem.GetItem(const aCtx: TtfwContext;
 aMenuItem: TMenuItem;
 anIndex: Integer): TMenuItem;
 {* ���������� ����� ������� menuitem:GetItem }
//#UC START# *E7D62A88975C_89C28B4155A9_var*
//#UC END# *E7D62A88975C_89C28B4155A9_var*
begin
//#UC START# *E7D62A88975C_89C28B4155A9_impl*
 Result := aMenuItem.Items[anIndex];
 Result.InitiateAction;
//#UC END# *E7D62A88975C_89C28B4155A9_impl*
end;//TkwMenuItemGetItem.GetItem

procedure TkwMenuItemGetItem.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_89C28B4155A9_var*
//#UC END# *4DAEEDE10285_89C28B4155A9_var*
begin
//#UC START# *4DAEEDE10285_89C28B4155A9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_89C28B4155A9_impl*
end;//TkwMenuItemGetItem.DoDoIt

class function TkwMenuItemGetItem.GetWordNameForRegister: AnsiString;
begin
 Result := 'menuitem:GetItem';
end;//TkwMenuItemGetItem.GetWordNameForRegister

function TkwMenuItemGetItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TMenuItem);
end;//TkwMenuItemGetItem.GetResultTypeInfo

function TkwMenuItemGetItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwMenuItemGetItem.GetAllParamsCount

function TkwMenuItemGetItem.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_89C28B4155A9_var*
//#UC END# *5617F4D00243_89C28B4155A9_var*
begin
//#UC START# *5617F4D00243_89C28B4155A9_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_89C28B4155A9_impl*
end;//TkwMenuItemGetItem.ParamsTypes

function TkwMenuItemGetMenuHeight.GetMenuHeight(const aCtx: TtfwContext;
 aMenuItem: TMenuItem): Integer;
 {* ���������� ����� ������� menuitem:GetMenuHeight }
//#UC START# *F09CA18F756D_F44EDB26B480_var*
var
 I: Integer;
 l_Width, l_Height, l_TotalHeight: Integer;
 l_Canvas: TControlCanvas;
//#UC END# *F09CA18F756D_F44EDB26B480_var*
begin
//#UC START# *F09CA18F756D_F44EDB26B480_impl*
 l_TotalHeight := 0;
 l_Canvas := TControlCanvas.Create;
 try
  l_Canvas.Handle := Tl3ScreenService.Instance.IC.DC;
  l_Canvas.Font := Screen.MenuFont;
  for I := 0 to aMenuItem.Count - 1 do
  begin
   l_Height := 0;
   TMenuItemFriend(aMenuItem.Items[I]).MeasureItem(l_Canvas, l_Width, l_Height);
   l_TotalHeight := l_TotalHeight + l_Height;
  end;//for I
 finally
  FreeAndNil(l_Canvas);
 end;//try..finally
 Result := l_TotalHeight;
//#UC END# *F09CA18F756D_F44EDB26B480_impl*
end;//TkwMenuItemGetMenuHeight.GetMenuHeight

procedure TkwMenuItemGetMenuHeight.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F44EDB26B480_var*
//#UC END# *4DAEEDE10285_F44EDB26B480_var*
begin
//#UC START# *4DAEEDE10285_F44EDB26B480_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F44EDB26B480_impl*
end;//TkwMenuItemGetMenuHeight.DoDoIt

class function TkwMenuItemGetMenuHeight.GetWordNameForRegister: AnsiString;
begin
 Result := 'menuitem:GetMenuHeight';
end;//TkwMenuItemGetMenuHeight.GetWordNameForRegister

function TkwMenuItemGetMenuHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwMenuItemGetMenuHeight.GetResultTypeInfo

function TkwMenuItemGetMenuHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMenuItemGetMenuHeight.GetAllParamsCount

function TkwMenuItemGetMenuHeight.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F44EDB26B480_var*
//#UC END# *5617F4D00243_F44EDB26B480_var*
begin
//#UC START# *5617F4D00243_F44EDB26B480_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F44EDB26B480_impl*
end;//TkwMenuItemGetMenuHeight.ParamsTypes

function TkwMenuItemCaption.Caption(const aCtx: TtfwContext;
 aMenuItem: TMenuItem): AnsiString;
 {* ���������� ����� ������� menuitem:GetCaption }
//#UC START# *03C94E0DC3DE_8BC1AB992E7A_var*
//#UC END# *03C94E0DC3DE_8BC1AB992E7A_var*
begin
//#UC START# *03C94E0DC3DE_8BC1AB992E7A_impl*
 !!! Needs to be implemented !!!
//#UC END# *03C94E0DC3DE_8BC1AB992E7A_impl*
end;//TkwMenuItemCaption.Caption

procedure TkwMenuItemCaption.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8BC1AB992E7A_var*
//#UC END# *4DAEEDE10285_8BC1AB992E7A_var*
begin
//#UC START# *4DAEEDE10285_8BC1AB992E7A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8BC1AB992E7A_impl*
end;//TkwMenuItemCaption.DoDoIt

class function TkwMenuItemCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'menuitem:GetCaption';
end;//TkwMenuItemCaption.GetWordNameForRegister

procedure TkwMenuItemCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_8BC1AB992E7A_var*
//#UC END# *52D00B00031A_8BC1AB992E7A_var*
begin
//#UC START# *52D00B00031A_8BC1AB992E7A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_8BC1AB992E7A_impl*
end;//TkwMenuItemCaption.SetValuePrim

function TkwMenuItemCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwMenuItemCaption.GetResultTypeInfo

function TkwMenuItemCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMenuItemCaption.GetAllParamsCount

function TkwMenuItemCaption.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_8BC1AB992E7A_var*
//#UC END# *5617F4D00243_8BC1AB992E7A_var*
begin
//#UC START# *5617F4D00243_8BC1AB992E7A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8BC1AB992E7A_impl*
end;//TkwMenuItemCaption.ParamsTypes

function TkwMenuItemCount.Count(const aCtx: TtfwContext;
 aMenuItem: TMenuItem): Integer;
 {* ���������� ����� ������� menuitem:GetCount }
//#UC START# *CA20A0E7C888_E34D149B8718_var*
//#UC END# *CA20A0E7C888_E34D149B8718_var*
begin
//#UC START# *CA20A0E7C888_E34D149B8718_impl*
 !!! Needs to be implemented !!!
//#UC END# *CA20A0E7C888_E34D149B8718_impl*
end;//TkwMenuItemCount.Count

procedure TkwMenuItemCount.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E34D149B8718_var*
//#UC END# *4DAEEDE10285_E34D149B8718_var*
begin
//#UC START# *4DAEEDE10285_E34D149B8718_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E34D149B8718_impl*
end;//TkwMenuItemCount.DoDoIt

class function TkwMenuItemCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'menuitem:GetCount';
end;//TkwMenuItemCount.GetWordNameForRegister

procedure TkwMenuItemCount.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E34D149B8718_var*
//#UC END# *52D00B00031A_E34D149B8718_var*
begin
//#UC START# *52D00B00031A_E34D149B8718_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E34D149B8718_impl*
end;//TkwMenuItemCount.SetValuePrim

function TkwMenuItemCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwMenuItemCount.GetResultTypeInfo

function TkwMenuItemCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMenuItemCount.GetAllParamsCount

function TkwMenuItemCount.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E34D149B8718_var*
//#UC END# *5617F4D00243_E34D149B8718_var*
begin
//#UC START# *5617F4D00243_E34D149B8718_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E34D149B8718_impl*
end;//TkwMenuItemCount.ParamsTypes

function TkwMenuItemEnabled.Enabled(const aCtx: TtfwContext;
 aMenuItem: TMenuItem): Boolean;
 {* ���������� ����� ������� menuitem:IsEnabled }
//#UC START# *D753B3DC40BE_BDC4E91C886F_var*
//#UC END# *D753B3DC40BE_BDC4E91C886F_var*
begin
//#UC START# *D753B3DC40BE_BDC4E91C886F_impl*
 !!! Needs to be implemented !!!
//#UC END# *D753B3DC40BE_BDC4E91C886F_impl*
end;//TkwMenuItemEnabled.Enabled

procedure TkwMenuItemEnabled.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BDC4E91C886F_var*
//#UC END# *4DAEEDE10285_BDC4E91C886F_var*
begin
//#UC START# *4DAEEDE10285_BDC4E91C886F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BDC4E91C886F_impl*
end;//TkwMenuItemEnabled.DoDoIt

class function TkwMenuItemEnabled.GetWordNameForRegister: AnsiString;
begin
 Result := 'menuitem:IsEnabled';
end;//TkwMenuItemEnabled.GetWordNameForRegister

procedure TkwMenuItemEnabled.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_BDC4E91C886F_var*
//#UC END# *52D00B00031A_BDC4E91C886F_var*
begin
//#UC START# *52D00B00031A_BDC4E91C886F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_BDC4E91C886F_impl*
end;//TkwMenuItemEnabled.SetValuePrim

function TkwMenuItemEnabled.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwMenuItemEnabled.GetResultTypeInfo

function TkwMenuItemEnabled.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMenuItemEnabled.GetAllParamsCount

function TkwMenuItemEnabled.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_BDC4E91C886F_var*
//#UC END# *5617F4D00243_BDC4E91C886F_var*
begin
//#UC START# *5617F4D00243_BDC4E91C886F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_BDC4E91C886F_impl*
end;//TkwMenuItemEnabled.ParamsTypes

function TkwMenuItemVisible.Visible(const aCtx: TtfwContext;
 aMenuItem: TMenuItem): Boolean;
 {* ���������� ����� ������� menuitem:IsVisible }
//#UC START# *D9ABAB31B79C_5633D99495D3_var*
//#UC END# *D9ABAB31B79C_5633D99495D3_var*
begin
//#UC START# *D9ABAB31B79C_5633D99495D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *D9ABAB31B79C_5633D99495D3_impl*
end;//TkwMenuItemVisible.Visible

procedure TkwMenuItemVisible.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5633D99495D3_var*
//#UC END# *4DAEEDE10285_5633D99495D3_var*
begin
//#UC START# *4DAEEDE10285_5633D99495D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5633D99495D3_impl*
end;//TkwMenuItemVisible.DoDoIt

class function TkwMenuItemVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'menuitem:IsVisible';
end;//TkwMenuItemVisible.GetWordNameForRegister

procedure TkwMenuItemVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_5633D99495D3_var*
//#UC END# *52D00B00031A_5633D99495D3_var*
begin
//#UC START# *52D00B00031A_5633D99495D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_5633D99495D3_impl*
end;//TkwMenuItemVisible.SetValuePrim

function TkwMenuItemVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwMenuItemVisible.GetResultTypeInfo

function TkwMenuItemVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMenuItemVisible.GetAllParamsCount

function TkwMenuItemVisible.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_5633D99495D3_var*
//#UC END# *5617F4D00243_5633D99495D3_var*
begin
//#UC START# *5617F4D00243_5633D99495D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_5633D99495D3_impl*
end;//TkwMenuItemVisible.ParamsTypes

initialization
 TMenuWordsPackResNameGetter.Register;
 {* ����������� ������������ ����������� }
 TkwMenuItemClick.RegisterInEngine;
 {* ����������� MenuItem_Click }
 TkwMenuItemGetItem.RegisterInEngine;
 {* ����������� MenuItem_GetItem }
 TkwMenuItemGetMenuHeight.RegisterInEngine;
 {* ����������� MenuItem_GetMenuHeight }
 TkwMenuItemCaption.RegisterInEngine;
 {* ����������� MenuItem_Caption }
 TkwMenuItemCount.RegisterInEngine;
 {* ����������� MenuItem_Count }
 TkwMenuItemEnabled.RegisterInEngine;
 {* ����������� MenuItem_Enabled }
 TkwMenuItemVisible.RegisterInEngine;
 {* ����������� MenuItem_Visible }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMenuItem));
 {* ����������� ���� TMenuItem }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* ����������� ���� Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* ����������� ���� Boolean }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
