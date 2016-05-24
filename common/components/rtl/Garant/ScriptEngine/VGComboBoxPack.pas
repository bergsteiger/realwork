unit VGComboBoxPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\VGComboBoxPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "VGComboBoxPack" MUID: (551D4B5B02FF)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , vg_listbox
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwAxiomaticsResNameGetter
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwVgComboBoxGetText = {final} class(TtfwClassLike)
  {* Слово скрипта vg:ComboBox:GetText }
  private
   function vg_ComboBox_GetText(const aCtx: TtfwContext;
    aComboBox: TvgComboBox): AnsiString;
    {* Реализация слова скрипта vg:ComboBox:GetText }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgComboBoxGetText

 TkwVgComboBoxItemHeight = {final} class(TtfwClassLike)
  {* Слово скрипта vg:ComboBox:ItemHeight }
  private
   function vg_ComboBox_ItemHeight(const aCtx: TtfwContext;
    aComboBox: TvgComboBox): Integer;
    {* Реализация слова скрипта vg:ComboBox:ItemHeight }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgComboBoxItemHeight

 TkwVgComboBoxItemIndex = {final} class(TtfwClassLike)
  {* Слово скрипта vg:ComboBox:ItemIndex }
  private
   function vg_ComboBox_ItemIndex(const aCtx: TtfwContext;
    aComboBox: TvgComboBox): Integer;
    {* Реализация слова скрипта vg:ComboBox:ItemIndex }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgComboBoxItemIndex

 TkwVgComboBoxGetItem = {final} class(TtfwClassLike)
  {* Слово скрипта vg:ComboBox:GetItem }
  private
   function vg_ComboBox_GetItem(const aCtx: TtfwContext;
    aComboBox: TvgComboBox;
    anIndex: Integer): AnsiString;
    {* Реализация слова скрипта vg:ComboBox:GetItem }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgComboBoxGetItem

 TkwVgComboBoxGetHighLightItemIndex = {final} class(TtfwClassLike)
  {* Слово скрипта vg:ComboBox:GetHighLightItemIndex }
  private
   function vg_ComboBox_GetHighLightItemIndex(const aCtx: TtfwContext;
    aComboBox: TvgComboBox): Integer;
    {* Реализация слова скрипта vg:ComboBox:GetHighLightItemIndex }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgComboBoxGetHighLightItemIndex

 TVGComboBoxPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TVGComboBoxPackResNameGetter

function TkwVgComboBoxGetText.vg_ComboBox_GetText(const aCtx: TtfwContext;
 aComboBox: TvgComboBox): AnsiString;
 {* Реализация слова скрипта vg:ComboBox:GetText }
//#UC START# *551D4BD8016D_551D4BD8016D_4D3D71CE0254_Word_var*
//#UC END# *551D4BD8016D_551D4BD8016D_4D3D71CE0254_Word_var*
begin
//#UC START# *551D4BD8016D_551D4BD8016D_4D3D71CE0254_Word_impl*
 Result := aComboBox.ListBox.Selected.Binding['text'];
//#UC END# *551D4BD8016D_551D4BD8016D_4D3D71CE0254_Word_impl*
end;//TkwVgComboBoxGetText.vg_ComboBox_GetText

class function TkwVgComboBoxGetText.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:ComboBox:GetText';
end;//TkwVgComboBoxGetText.GetWordNameForRegister

function TkwVgComboBoxGetText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwVgComboBoxGetText.GetResultTypeInfo

function TkwVgComboBoxGetText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVgComboBoxGetText.GetAllParamsCount

function TkwVgComboBoxGetText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgComboBox)]);
end;//TkwVgComboBoxGetText.ParamsTypes

procedure TkwVgComboBoxGetText.DoDoIt(const aCtx: TtfwContext);
var l_aComboBox: TvgComboBox;
begin
 try
  l_aComboBox := TvgComboBox(aCtx.rEngine.PopObjAs(TvgComboBox));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComboBox: TvgComboBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(vg_ComboBox_GetText(aCtx, l_aComboBox));
end;//TkwVgComboBoxGetText.DoDoIt

function TkwVgComboBoxItemHeight.vg_ComboBox_ItemHeight(const aCtx: TtfwContext;
 aComboBox: TvgComboBox): Integer;
 {* Реализация слова скрипта vg:ComboBox:ItemHeight }
//#UC START# *551D4BFD035D_551D4BFD035D_4D3D71CE0254_Word_var*
//#UC END# *551D4BFD035D_551D4BFD035D_4D3D71CE0254_Word_var*
begin
//#UC START# *551D4BFD035D_551D4BFD035D_4D3D71CE0254_Word_impl*
 Result := Round(aComboBox.ItemHeight);
//#UC END# *551D4BFD035D_551D4BFD035D_4D3D71CE0254_Word_impl*
end;//TkwVgComboBoxItemHeight.vg_ComboBox_ItemHeight

class function TkwVgComboBoxItemHeight.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:ComboBox:ItemHeight';
end;//TkwVgComboBoxItemHeight.GetWordNameForRegister

function TkwVgComboBoxItemHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwVgComboBoxItemHeight.GetResultTypeInfo

function TkwVgComboBoxItemHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVgComboBoxItemHeight.GetAllParamsCount

function TkwVgComboBoxItemHeight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgComboBox)]);
end;//TkwVgComboBoxItemHeight.ParamsTypes

procedure TkwVgComboBoxItemHeight.DoDoIt(const aCtx: TtfwContext);
var l_aComboBox: TvgComboBox;
begin
 try
  l_aComboBox := TvgComboBox(aCtx.rEngine.PopObjAs(TvgComboBox));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComboBox: TvgComboBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(vg_ComboBox_ItemHeight(aCtx, l_aComboBox));
end;//TkwVgComboBoxItemHeight.DoDoIt

function TkwVgComboBoxItemIndex.vg_ComboBox_ItemIndex(const aCtx: TtfwContext;
 aComboBox: TvgComboBox): Integer;
 {* Реализация слова скрипта vg:ComboBox:ItemIndex }
//#UC START# *551D4C2C037F_551D4C2C037F_4D3D71CE0254_Word_var*
//#UC END# *551D4C2C037F_551D4C2C037F_4D3D71CE0254_Word_var*
begin
//#UC START# *551D4C2C037F_551D4C2C037F_4D3D71CE0254_Word_impl*
 Result := aComboBox.ItemIndex;
//#UC END# *551D4C2C037F_551D4C2C037F_4D3D71CE0254_Word_impl*
end;//TkwVgComboBoxItemIndex.vg_ComboBox_ItemIndex

class function TkwVgComboBoxItemIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:ComboBox:ItemIndex';
end;//TkwVgComboBoxItemIndex.GetWordNameForRegister

function TkwVgComboBoxItemIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwVgComboBoxItemIndex.GetResultTypeInfo

function TkwVgComboBoxItemIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVgComboBoxItemIndex.GetAllParamsCount

function TkwVgComboBoxItemIndex.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgComboBox)]);
end;//TkwVgComboBoxItemIndex.ParamsTypes

procedure TkwVgComboBoxItemIndex.DoDoIt(const aCtx: TtfwContext);
var l_aComboBox: TvgComboBox;
begin
 try
  l_aComboBox := TvgComboBox(aCtx.rEngine.PopObjAs(TvgComboBox));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComboBox: TvgComboBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(vg_ComboBox_ItemIndex(aCtx, l_aComboBox));
end;//TkwVgComboBoxItemIndex.DoDoIt

function TkwVgComboBoxGetItem.vg_ComboBox_GetItem(const aCtx: TtfwContext;
 aComboBox: TvgComboBox;
 anIndex: Integer): AnsiString;
 {* Реализация слова скрипта vg:ComboBox:GetItem }
//#UC START# *552BC81F01C4_552BC81F01C4_4D3D71CE0254_Word_var*
//#UC END# *552BC81F01C4_552BC81F01C4_4D3D71CE0254_Word_var*
begin
//#UC START# *552BC81F01C4_552BC81F01C4_4D3D71CE0254_Word_impl*
 Result := aComboBox.ListBox.Items[anIndex].Binding['text'];
//#UC END# *552BC81F01C4_552BC81F01C4_4D3D71CE0254_Word_impl*
end;//TkwVgComboBoxGetItem.vg_ComboBox_GetItem

class function TkwVgComboBoxGetItem.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:ComboBox:GetItem';
end;//TkwVgComboBoxGetItem.GetWordNameForRegister

function TkwVgComboBoxGetItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwVgComboBoxGetItem.GetResultTypeInfo

function TkwVgComboBoxGetItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwVgComboBoxGetItem.GetAllParamsCount

function TkwVgComboBoxGetItem.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgComboBox), TypeInfo(Integer)]);
end;//TkwVgComboBoxGetItem.ParamsTypes

procedure TkwVgComboBoxGetItem.DoDoIt(const aCtx: TtfwContext);
var l_aComboBox: TvgComboBox;
var l_anIndex: Integer;
begin
 try
  l_aComboBox := TvgComboBox(aCtx.rEngine.PopObjAs(TvgComboBox));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComboBox: TvgComboBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(vg_ComboBox_GetItem(aCtx, l_aComboBox, l_anIndex));
end;//TkwVgComboBoxGetItem.DoDoIt

function TkwVgComboBoxGetHighLightItemIndex.vg_ComboBox_GetHighLightItemIndex(const aCtx: TtfwContext;
 aComboBox: TvgComboBox): Integer;
 {* Реализация слова скрипта vg:ComboBox:GetHighLightItemIndex }
//#UC START# *552BD85E001F_552BD85E001F_4D3D71CE0254_Word_var*
var
 l_Item: TvgListBoxItem;
//#UC END# *552BD85E001F_552BD85E001F_4D3D71CE0254_Word_var*
begin
//#UC START# *552BD85E001F_552BD85E001F_4D3D71CE0254_Word_impl*
 l_Item := aComboBox.ListBox.HighlightItem;
 if Assigned(l_Item) 
  then Result := l_Item.Index
  else Result := -1;
//#UC END# *552BD85E001F_552BD85E001F_4D3D71CE0254_Word_impl*
end;//TkwVgComboBoxGetHighLightItemIndex.vg_ComboBox_GetHighLightItemIndex

class function TkwVgComboBoxGetHighLightItemIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:ComboBox:GetHighLightItemIndex';
end;//TkwVgComboBoxGetHighLightItemIndex.GetWordNameForRegister

function TkwVgComboBoxGetHighLightItemIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwVgComboBoxGetHighLightItemIndex.GetResultTypeInfo

function TkwVgComboBoxGetHighLightItemIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVgComboBoxGetHighLightItemIndex.GetAllParamsCount

function TkwVgComboBoxGetHighLightItemIndex.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgComboBox)]);
end;//TkwVgComboBoxGetHighLightItemIndex.ParamsTypes

procedure TkwVgComboBoxGetHighLightItemIndex.DoDoIt(const aCtx: TtfwContext);
var l_aComboBox: TvgComboBox;
begin
 try
  l_aComboBox := TvgComboBox(aCtx.rEngine.PopObjAs(TvgComboBox));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComboBox: TvgComboBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(vg_ComboBox_GetHighLightItemIndex(aCtx, l_aComboBox));
end;//TkwVgComboBoxGetHighLightItemIndex.DoDoIt

class function TVGComboBoxPackResNameGetter.ResName: AnsiString;
begin
 Result := 'VGComboBoxPack';
end;//TVGComboBoxPackResNameGetter.ResName

{$R VGComboBoxPack.res}

initialization
 TkwVgComboBoxGetText.RegisterInEngine;
 {* Регистрация vg_ComboBox_GetText }
 TkwVgComboBoxItemHeight.RegisterInEngine;
 {* Регистрация vg_ComboBox_ItemHeight }
 TkwVgComboBoxItemIndex.RegisterInEngine;
 {* Регистрация vg_ComboBox_ItemIndex }
 TkwVgComboBoxGetItem.RegisterInEngine;
 {* Регистрация vg_ComboBox_GetItem }
 TkwVgComboBoxGetHighLightItemIndex.RegisterInEngine;
 {* Регистрация vg_ComboBox_GetHighLightItemIndex }
 TVGComboBoxPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgComboBox));
 {* Регистрация типа TvgComboBox }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoScripts)

end.
