unit VGComboBoxPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\VGComboBoxPack.pas"
// Стереотип: "ScriptKeywordsPack"

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
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *4797480437D2ci*
 //#UC END# *4797480437D2ci*
 //#UC START# *4797480437D2cit*
 //#UC END# *4797480437D2cit*
 TVGComboBoxPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *4797480437D2publ*
 //#UC END# *4797480437D2publ*
 end;//TVGComboBoxPackResNameGetter

 TkwVgComboBoxGetText = {final} class(TtfwClassLike)
  {* Слово скрипта vg:ComboBox:GetText
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aComboBox vg:ComboBox:GetText >>> l_String
[code]  }
  private
   function vg_ComboBox_GetText(const aCtx: TtfwContext;
    aComboBox: TvgComboBox): AnsiString;
    {* Реализация слова скрипта vg:ComboBox:GetText }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgComboBoxGetText

 TkwVgComboBoxItemHeight = {final} class(TtfwClassLike)
  {* Слово скрипта vg:ComboBox:ItemHeight
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aComboBox vg:ComboBox:ItemHeight >>> l_Integer
[code]  }
  private
   function vg_ComboBox_ItemHeight(const aCtx: TtfwContext;
    aComboBox: TvgComboBox): Integer;
    {* Реализация слова скрипта vg:ComboBox:ItemHeight }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgComboBoxItemHeight

 TkwVgComboBoxItemIndex = {final} class(TtfwClassLike)
  {* Слово скрипта vg:ComboBox:ItemIndex
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aComboBox vg:ComboBox:ItemIndex >>> l_Integer
[code]  }
  private
   function vg_ComboBox_ItemIndex(const aCtx: TtfwContext;
    aComboBox: TvgComboBox): Integer;
    {* Реализация слова скрипта vg:ComboBox:ItemIndex }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgComboBoxItemIndex

 TkwVgComboBoxGetItem = {final} class(TtfwClassLike)
  {* Слово скрипта vg:ComboBox:GetItem
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 anIndex aComboBox vg:ComboBox:GetItem >>> l_String
[code]  }
  private
   function vg_ComboBox_GetItem(const aCtx: TtfwContext;
    aComboBox: TvgComboBox;
    anIndex: Integer): AnsiString;
    {* Реализация слова скрипта vg:ComboBox:GetItem }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgComboBoxGetItem

 TkwVgComboBoxGetHighLightItemIndex = {final} class(TtfwClassLike)
  {* Слово скрипта vg:ComboBox:GetHighLightItemIndex
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aComboBox vg:ComboBox:GetHighLightItemIndex >>> l_Integer
[code]  }
  private
   function vg_ComboBox_GetHighLightItemIndex(const aCtx: TtfwContext;
    aComboBox: TvgComboBox): Integer;
    {* Реализация слова скрипта vg:ComboBox:GetHighLightItemIndex }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgComboBoxGetHighLightItemIndex

class function TVGComboBoxPackResNameGetter.ResName: AnsiString;
begin
  Result := 'VGComboBoxPack';
end;//TVGComboBoxPackResNameGetter.ResName

 {$R VGComboBoxPack.res}

function TkwVgComboBoxGetText.vg_ComboBox_GetText(const aCtx: TtfwContext;
 aComboBox: TvgComboBox): AnsiString;
 {* Реализация слова скрипта vg:ComboBox:GetText }
//#UC START# *E6AB0BAEC690_3D1B97A2F7D1_var*
//#UC END# *E6AB0BAEC690_3D1B97A2F7D1_var*
begin
//#UC START# *E6AB0BAEC690_3D1B97A2F7D1_impl*
 Result := aComboBox.ListBox.Selected.Binding['text'];
//#UC END# *E6AB0BAEC690_3D1B97A2F7D1_impl*
end;//TkwVgComboBoxGetText.vg_ComboBox_GetText

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

function TkwVgComboBoxItemHeight.vg_ComboBox_ItemHeight(const aCtx: TtfwContext;
 aComboBox: TvgComboBox): Integer;
 {* Реализация слова скрипта vg:ComboBox:ItemHeight }
//#UC START# *3D92BC0DA86C_6AF76187796E_var*
//#UC END# *3D92BC0DA86C_6AF76187796E_var*
begin
//#UC START# *3D92BC0DA86C_6AF76187796E_impl*
 Result := Round(aComboBox.ItemHeight);
//#UC END# *3D92BC0DA86C_6AF76187796E_impl*
end;//TkwVgComboBoxItemHeight.vg_ComboBox_ItemHeight

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

function TkwVgComboBoxItemIndex.vg_ComboBox_ItemIndex(const aCtx: TtfwContext;
 aComboBox: TvgComboBox): Integer;
 {* Реализация слова скрипта vg:ComboBox:ItemIndex }
//#UC START# *FD2233CED588_E6401AA7CFD9_var*
//#UC END# *FD2233CED588_E6401AA7CFD9_var*
begin
//#UC START# *FD2233CED588_E6401AA7CFD9_impl*
 Result := aComboBox.ItemIndex;
//#UC END# *FD2233CED588_E6401AA7CFD9_impl*
end;//TkwVgComboBoxItemIndex.vg_ComboBox_ItemIndex

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

function TkwVgComboBoxGetItem.vg_ComboBox_GetItem(const aCtx: TtfwContext;
 aComboBox: TvgComboBox;
 anIndex: Integer): AnsiString;
 {* Реализация слова скрипта vg:ComboBox:GetItem }
//#UC START# *543B6C62927E_F404139FE541_var*
//#UC END# *543B6C62927E_F404139FE541_var*
begin
//#UC START# *543B6C62927E_F404139FE541_impl*
 Result := aComboBox.ListBox.Items[anIndex].Binding['text'];
//#UC END# *543B6C62927E_F404139FE541_impl*
end;//TkwVgComboBoxGetItem.vg_ComboBox_GetItem

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

function TkwVgComboBoxGetHighLightItemIndex.vg_ComboBox_GetHighLightItemIndex(const aCtx: TtfwContext;
 aComboBox: TvgComboBox): Integer;
 {* Реализация слова скрипта vg:ComboBox:GetHighLightItemIndex }
//#UC START# *7E4219389025_4E17F992CC09_var*
var
 l_Item: TvgListBoxItem;
//#UC END# *7E4219389025_4E17F992CC09_var*
begin
//#UC START# *7E4219389025_4E17F992CC09_impl*
 l_Item := aComboBox.ListBox.HighlightItem;
 if Assigned(l_Item) 
  then Result := l_Item.Index
  else Result := -1;
//#UC END# *7E4219389025_4E17F992CC09_impl*
end;//TkwVgComboBoxGetHighLightItemIndex.vg_ComboBox_GetHighLightItemIndex

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

initialization
 TVGComboBoxPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgComboBox));
 {* Регистрация типа TvgComboBox }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoScripts)

end.
