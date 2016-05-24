unit vtComboBoxWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\vtComboBoxWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "vtComboBoxWordsPack" MUID: (54EC8C7C011E)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , StdCtrls
 , vtComboTree
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwAxiomaticsResNameGetter
 , tfwAxiomaticsResNameGetters
 , vtComboBoxQS
 , l3TreeInterfaces
 , l3Filer
 , l3Types
 , l3Interfaces
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TCustomComboBoxFriend = {abstract} class(TCustomComboBox)
  {* Друг к классу TCustomComboBox }
 end;//TCustomComboBoxFriend

 TkwPopComboBoxDropDown = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ComboBox:DropDown }
  private
   procedure DropDown(const aCtx: TtfwContext;
    aComboBox: TCustomComboBox;
    aValue: Boolean);
    {* Реализация слова скрипта pop:ComboBox:DropDown }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComboBoxDropDown

 TkwPopComboBoxGetItemIndex = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ComboBox:GetItemIndex }
  private
   function GetItemIndex(const aCtx: TtfwContext;
    aComboBox: TCustomComboBox): Integer;
    {* Реализация слова скрипта pop:ComboBox:GetItemIndex }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComboBoxGetItemIndex

 TkwPopComboBoxIndexOf = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ComboBox:IndexOf }
  private
   function IndexOf(const aCtx: TtfwContext;
    aComboBox: TCustomComboBox;
    const aString: AnsiString): Integer;
    {* Реализация слова скрипта pop:ComboBox:IndexOf }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComboBoxIndexOf

 TkwPopComboBoxSelectItem = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ComboBox:SelectItem }
  private
   procedure SelectItem(const aCtx: TtfwContext;
    aComboBox: TCustomComboBox;
    const aString: AnsiString);
    {* Реализация слова скрипта pop:ComboBox:SelectItem }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComboBoxSelectItem

 TkwPopComboBoxSetItemIndex = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ComboBox:SetItemIndex }
  private
   procedure SetItemIndex(const aCtx: TtfwContext;
    aComboBox: TCustomComboBox;
    anIndex: Integer);
    {* Реализация слова скрипта pop:ComboBox:SetItemIndex }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComboBoxSetItemIndex

 TkwPopComboBoxSaveItems = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ComboBox:SaveItems }
  private
   procedure SaveItems(const aCtx: TtfwContext;
    aComboBox: TCustomComboBox;
    const aFileName: AnsiString);
    {* Реализация слова скрипта pop:ComboBox:SaveItems }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComboBoxSaveItems

 TkwPopComboTreeDropDown = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ComboTree:DropDown }
  private
   procedure DropDown(const aCtx: TtfwContext;
    aComboTree: TvtComboTree;
    aValue: Boolean);
    {* Реализация слова скрипта pop:ComboTree:DropDown }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComboTreeDropDown

 TkwPopComboTreeGetItemIndex = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ComboTree:GetItemIndex }
  private
   function GetItemIndex(const aCtx: TtfwContext;
    aComboTree: TvtComboTree): Integer;
    {* Реализация слова скрипта pop:ComboTree:GetItemIndex }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComboTreeGetItemIndex

 TkwPopComboTreeIndexOf = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ComboTree:IndexOf }
  private
   function IndexOf(const aCtx: TtfwContext;
    aComboTree: TvtComboTree;
    const aString: AnsiString): Integer;
    {* Реализация слова скрипта pop:ComboTree:IndexOf }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComboTreeIndexOf

 TkwPopComboTreeSelectItem = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ComboTree:SelectItem }
  private
   procedure SelectItem(const aCtx: TtfwContext;
    aComboTree: TvtComboTree;
    const aString: AnsiString);
    {* Реализация слова скрипта pop:ComboTree:SelectItem }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComboTreeSelectItem

 TkwPopComboTreeSetItemIndex = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ComboTree:SetItemIndex }
  private
   procedure SetItemIndex(const aCtx: TtfwContext;
    aComboTree: TvtComboTree;
    anIndex: Integer);
    {* Реализация слова скрипта pop:ComboTree:SetItemIndex }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComboTreeSetItemIndex

 TkwPopComboTreeSaveItems = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ComboTree:SaveItems }
  private
   procedure SaveItems(const aCtx: TtfwContext;
    aComboTree: TvtComboTree;
    const aFileName: AnsiString);
    {* Реализация слова скрипта pop:ComboTree:SaveItems }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComboTreeSaveItems

 TvtComboBoxWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TvtComboBoxWordsPackResNameGetter

procedure TkwPopComboBoxDropDown.DropDown(const aCtx: TtfwContext;
 aComboBox: TCustomComboBox;
 aValue: Boolean);
 {* Реализация слова скрипта pop:ComboBox:DropDown }
//#UC START# *55B7A59500C7_55B7A59500C7_5049DA2A035D_Word_var*
//#UC END# *55B7A59500C7_55B7A59500C7_5049DA2A035D_Word_var*
begin
//#UC START# *55B7A59500C7_55B7A59500C7_5049DA2A035D_Word_impl*
 aCombobox.DroppedDown := aValue;
//#UC END# *55B7A59500C7_55B7A59500C7_5049DA2A035D_Word_impl*
end;//TkwPopComboBoxDropDown.DropDown

class function TkwPopComboBoxDropDown.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ComboBox:DropDown';
end;//TkwPopComboBoxDropDown.GetWordNameForRegister

function TkwPopComboBoxDropDown.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopComboBoxDropDown.GetResultTypeInfo

function TkwPopComboBoxDropDown.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopComboBoxDropDown.GetAllParamsCount

function TkwPopComboBoxDropDown.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomComboBox), TypeInfo(Boolean)]);
end;//TkwPopComboBoxDropDown.ParamsTypes

procedure TkwPopComboBoxDropDown.DoDoIt(const aCtx: TtfwContext);
var l_aComboBox: TCustomComboBox;
var l_aValue: Boolean;
begin
 try
  l_aComboBox := TCustomComboBox(aCtx.rEngine.PopObjAs(TCustomComboBox));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComboBox: TCustomComboBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DropDown(aCtx, l_aComboBox, l_aValue);
end;//TkwPopComboBoxDropDown.DoDoIt

function TkwPopComboBoxGetItemIndex.GetItemIndex(const aCtx: TtfwContext;
 aComboBox: TCustomComboBox): Integer;
 {* Реализация слова скрипта pop:ComboBox:GetItemIndex }
//#UC START# *55B7A5B502F8_55B7A5B502F8_5049DA2A035D_Word_var*
//#UC END# *55B7A5B502F8_55B7A5B502F8_5049DA2A035D_Word_var*
begin
//#UC START# *55B7A5B502F8_55B7A5B502F8_5049DA2A035D_Word_impl*
 Result := aCombobox.ItemIndex;
//#UC END# *55B7A5B502F8_55B7A5B502F8_5049DA2A035D_Word_impl*
end;//TkwPopComboBoxGetItemIndex.GetItemIndex

class function TkwPopComboBoxGetItemIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ComboBox:GetItemIndex';
end;//TkwPopComboBoxGetItemIndex.GetWordNameForRegister

function TkwPopComboBoxGetItemIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopComboBoxGetItemIndex.GetResultTypeInfo

function TkwPopComboBoxGetItemIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopComboBoxGetItemIndex.GetAllParamsCount

function TkwPopComboBoxGetItemIndex.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomComboBox)]);
end;//TkwPopComboBoxGetItemIndex.ParamsTypes

procedure TkwPopComboBoxGetItemIndex.DoDoIt(const aCtx: TtfwContext);
var l_aComboBox: TCustomComboBox;
begin
 try
  l_aComboBox := TCustomComboBox(aCtx.rEngine.PopObjAs(TCustomComboBox));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComboBox: TCustomComboBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(GetItemIndex(aCtx, l_aComboBox));
end;//TkwPopComboBoxGetItemIndex.DoDoIt

function TkwPopComboBoxIndexOf.IndexOf(const aCtx: TtfwContext;
 aComboBox: TCustomComboBox;
 const aString: AnsiString): Integer;
 {* Реализация слова скрипта pop:ComboBox:IndexOf }
//#UC START# *55B7A5CD03A9_55B7A5CD03A9_5049DA2A035D_Word_var*
//#UC END# *55B7A5CD03A9_55B7A5CD03A9_5049DA2A035D_Word_var*
begin
//#UC START# *55B7A5CD03A9_55B7A5CD03A9_5049DA2A035D_Word_impl*
 Result := aCombobox.Items.IndexOf(aString);
//#UC END# *55B7A5CD03A9_55B7A5CD03A9_5049DA2A035D_Word_impl*
end;//TkwPopComboBoxIndexOf.IndexOf

class function TkwPopComboBoxIndexOf.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ComboBox:IndexOf';
end;//TkwPopComboBoxIndexOf.GetWordNameForRegister

function TkwPopComboBoxIndexOf.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopComboBoxIndexOf.GetResultTypeInfo

function TkwPopComboBoxIndexOf.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopComboBoxIndexOf.GetAllParamsCount

function TkwPopComboBoxIndexOf.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomComboBox), @tfw_tiString]);
end;//TkwPopComboBoxIndexOf.ParamsTypes

procedure TkwPopComboBoxIndexOf.DoDoIt(const aCtx: TtfwContext);
var l_aComboBox: TCustomComboBox;
var l_aString: AnsiString;
begin
 try
  l_aComboBox := TCustomComboBox(aCtx.rEngine.PopObjAs(TCustomComboBox));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComboBox: TCustomComboBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aString := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(IndexOf(aCtx, l_aComboBox, l_aString));
end;//TkwPopComboBoxIndexOf.DoDoIt

procedure TkwPopComboBoxSelectItem.SelectItem(const aCtx: TtfwContext;
 aComboBox: TCustomComboBox;
 const aString: AnsiString);
 {* Реализация слова скрипта pop:ComboBox:SelectItem }
//#UC START# *55B7A5FB0027_55B7A5FB0027_5049DA2A035D_Word_var*
//#UC END# *55B7A5FB0027_55B7A5FB0027_5049DA2A035D_Word_var*
begin
//#UC START# *55B7A5FB0027_55B7A5FB0027_5049DA2A035D_Word_impl*
 aComboTree.ItemIndex := aComboTree.Items.IndexOf(aString);
//#UC END# *55B7A5FB0027_55B7A5FB0027_5049DA2A035D_Word_impl*
end;//TkwPopComboBoxSelectItem.SelectItem

class function TkwPopComboBoxSelectItem.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ComboBox:SelectItem';
end;//TkwPopComboBoxSelectItem.GetWordNameForRegister

function TkwPopComboBoxSelectItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopComboBoxSelectItem.GetResultTypeInfo

function TkwPopComboBoxSelectItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopComboBoxSelectItem.GetAllParamsCount

function TkwPopComboBoxSelectItem.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomComboBox), @tfw_tiString]);
end;//TkwPopComboBoxSelectItem.ParamsTypes

procedure TkwPopComboBoxSelectItem.DoDoIt(const aCtx: TtfwContext);
var l_aComboBox: TCustomComboBox;
var l_aString: AnsiString;
begin
 try
  l_aComboBox := TCustomComboBox(aCtx.rEngine.PopObjAs(TCustomComboBox));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComboBox: TCustomComboBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aString := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SelectItem(aCtx, l_aComboBox, l_aString);
end;//TkwPopComboBoxSelectItem.DoDoIt

procedure TkwPopComboBoxSetItemIndex.SetItemIndex(const aCtx: TtfwContext;
 aComboBox: TCustomComboBox;
 anIndex: Integer);
 {* Реализация слова скрипта pop:ComboBox:SetItemIndex }
//#UC START# *55B7A6200240_55B7A6200240_5049DA2A035D_Word_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *55B7A6200240_55B7A6200240_5049DA2A035D_Word_var*
begin
//#UC START# *55B7A6200240_55B7A6200240_5049DA2A035D_Word_impl*
 if (aComboTree is TvtComboBoxQS) then //561950536
  aComboTree.ItemIndex := anIndex
 else
 begin
  l_Node := aComboTree.Tree.GetNode(anIndex);
  aComboTree.Tree.GotoOnNode(l_Node);
  aComboTree.ShowNode(l_Node, True);
 end;//aComboTree is TvtComboBoxQS
//#UC END# *55B7A6200240_55B7A6200240_5049DA2A035D_Word_impl*
end;//TkwPopComboBoxSetItemIndex.SetItemIndex

class function TkwPopComboBoxSetItemIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ComboBox:SetItemIndex';
end;//TkwPopComboBoxSetItemIndex.GetWordNameForRegister

function TkwPopComboBoxSetItemIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopComboBoxSetItemIndex.GetResultTypeInfo

function TkwPopComboBoxSetItemIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopComboBoxSetItemIndex.GetAllParamsCount

function TkwPopComboBoxSetItemIndex.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomComboBox), TypeInfo(Integer)]);
end;//TkwPopComboBoxSetItemIndex.ParamsTypes

procedure TkwPopComboBoxSetItemIndex.DoDoIt(const aCtx: TtfwContext);
var l_aComboBox: TCustomComboBox;
var l_anIndex: Integer;
begin
 try
  l_aComboBox := TCustomComboBox(aCtx.rEngine.PopObjAs(TCustomComboBox));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComboBox: TCustomComboBox : ' + E.Message, aCtx);
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
 SetItemIndex(aCtx, l_aComboBox, l_anIndex);
end;//TkwPopComboBoxSetItemIndex.DoDoIt

procedure TkwPopComboBoxSaveItems.SaveItems(const aCtx: TtfwContext;
 aComboBox: TCustomComboBox;
 const aFileName: AnsiString);
 {* Реализация слова скрипта pop:ComboBox:SaveItems }
//#UC START# *55B7A69E02F1_55B7A69E02F1_5049DA2A035D_Word_var*
var
 l_S: AnsiString;
 l_Filer : Tl3CustomDosFiler;
//#UC END# *55B7A69E02F1_55B7A69E02F1_5049DA2A035D_Word_var*
begin
//#UC START# *55B7A69E02F1_55B7A69E02F1_5049DA2A035D_Word_impl*
 l_S := aCtx.rCaller.ResolveOutputFilePath(aFileName);
 l_S := ChangeFileExt(l_S, '.cmbx');
 l_Filer := Tl3CustomDosFiler.Make(l_S, l3_fmWrite, false);
 try
  l_Filer.Open;
  try
   l_Filer.WriteLn((aComboTree.Items as Il3Strings).Items.Text);
  finally
   l_Filer.Close;
  end;
 finally
  FreeAndNil(l_Filer);
 end;//try..finally
//#UC END# *55B7A69E02F1_55B7A69E02F1_5049DA2A035D_Word_impl*
end;//TkwPopComboBoxSaveItems.SaveItems

class function TkwPopComboBoxSaveItems.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ComboBox:SaveItems';
end;//TkwPopComboBoxSaveItems.GetWordNameForRegister

function TkwPopComboBoxSaveItems.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopComboBoxSaveItems.GetResultTypeInfo

function TkwPopComboBoxSaveItems.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopComboBoxSaveItems.GetAllParamsCount

function TkwPopComboBoxSaveItems.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomComboBox), @tfw_tiString]);
end;//TkwPopComboBoxSaveItems.ParamsTypes

procedure TkwPopComboBoxSaveItems.DoDoIt(const aCtx: TtfwContext);
var l_aComboBox: TCustomComboBox;
var l_aFileName: AnsiString;
begin
 try
  l_aComboBox := TCustomComboBox(aCtx.rEngine.PopObjAs(TCustomComboBox));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComboBox: TCustomComboBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFileName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFileName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SaveItems(aCtx, l_aComboBox, l_aFileName);
end;//TkwPopComboBoxSaveItems.DoDoIt

procedure TkwPopComboTreeDropDown.DropDown(const aCtx: TtfwContext;
 aComboTree: TvtComboTree;
 aValue: Boolean);
 {* Реализация слова скрипта pop:ComboTree:DropDown }
//#UC START# *55B7A59500C7_55B7A59500C7_55B780E60398_Word_var*
//#UC END# *55B7A59500C7_55B7A59500C7_55B780E60398_Word_var*
begin
//#UC START# *55B7A59500C7_55B7A59500C7_55B780E60398_Word_impl*
 aCombobox.DroppedDown := aValue;
//#UC END# *55B7A59500C7_55B7A59500C7_55B780E60398_Word_impl*
end;//TkwPopComboTreeDropDown.DropDown

class function TkwPopComboTreeDropDown.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ComboTree:DropDown';
end;//TkwPopComboTreeDropDown.GetWordNameForRegister

function TkwPopComboTreeDropDown.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopComboTreeDropDown.GetResultTypeInfo

function TkwPopComboTreeDropDown.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopComboTreeDropDown.GetAllParamsCount

function TkwPopComboTreeDropDown.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtComboTree), TypeInfo(Boolean)]);
end;//TkwPopComboTreeDropDown.ParamsTypes

procedure TkwPopComboTreeDropDown.DoDoIt(const aCtx: TtfwContext);
var l_aComboTree: TvtComboTree;
var l_aValue: Boolean;
begin
 try
  l_aComboTree := TvtComboTree(aCtx.rEngine.PopObjAs(TvtComboTree));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComboTree: TvtComboTree : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DropDown(aCtx, l_aComboTree, l_aValue);
end;//TkwPopComboTreeDropDown.DoDoIt

function TkwPopComboTreeGetItemIndex.GetItemIndex(const aCtx: TtfwContext;
 aComboTree: TvtComboTree): Integer;
 {* Реализация слова скрипта pop:ComboTree:GetItemIndex }
//#UC START# *55B7A5B502F8_55B7A5B502F8_55B780E60398_Word_var*
//#UC END# *55B7A5B502F8_55B7A5B502F8_55B780E60398_Word_var*
begin
//#UC START# *55B7A5B502F8_55B7A5B502F8_55B780E60398_Word_impl*
 Result := aCombobox.ItemIndex;
//#UC END# *55B7A5B502F8_55B7A5B502F8_55B780E60398_Word_impl*
end;//TkwPopComboTreeGetItemIndex.GetItemIndex

class function TkwPopComboTreeGetItemIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ComboTree:GetItemIndex';
end;//TkwPopComboTreeGetItemIndex.GetWordNameForRegister

function TkwPopComboTreeGetItemIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopComboTreeGetItemIndex.GetResultTypeInfo

function TkwPopComboTreeGetItemIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopComboTreeGetItemIndex.GetAllParamsCount

function TkwPopComboTreeGetItemIndex.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtComboTree)]);
end;//TkwPopComboTreeGetItemIndex.ParamsTypes

procedure TkwPopComboTreeGetItemIndex.DoDoIt(const aCtx: TtfwContext);
var l_aComboTree: TvtComboTree;
begin
 try
  l_aComboTree := TvtComboTree(aCtx.rEngine.PopObjAs(TvtComboTree));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComboTree: TvtComboTree : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(GetItemIndex(aCtx, l_aComboTree));
end;//TkwPopComboTreeGetItemIndex.DoDoIt

function TkwPopComboTreeIndexOf.IndexOf(const aCtx: TtfwContext;
 aComboTree: TvtComboTree;
 const aString: AnsiString): Integer;
 {* Реализация слова скрипта pop:ComboTree:IndexOf }
//#UC START# *55B7A5CD03A9_55B7A5CD03A9_55B780E60398_Word_var*
//#UC END# *55B7A5CD03A9_55B7A5CD03A9_55B780E60398_Word_var*
begin
//#UC START# *55B7A5CD03A9_55B7A5CD03A9_55B780E60398_Word_impl*
 Result := aCombobox.Items.IndexOf(aString);
//#UC END# *55B7A5CD03A9_55B7A5CD03A9_55B780E60398_Word_impl*
end;//TkwPopComboTreeIndexOf.IndexOf

class function TkwPopComboTreeIndexOf.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ComboTree:IndexOf';
end;//TkwPopComboTreeIndexOf.GetWordNameForRegister

function TkwPopComboTreeIndexOf.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopComboTreeIndexOf.GetResultTypeInfo

function TkwPopComboTreeIndexOf.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopComboTreeIndexOf.GetAllParamsCount

function TkwPopComboTreeIndexOf.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtComboTree), @tfw_tiString]);
end;//TkwPopComboTreeIndexOf.ParamsTypes

procedure TkwPopComboTreeIndexOf.DoDoIt(const aCtx: TtfwContext);
var l_aComboTree: TvtComboTree;
var l_aString: AnsiString;
begin
 try
  l_aComboTree := TvtComboTree(aCtx.rEngine.PopObjAs(TvtComboTree));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComboTree: TvtComboTree : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aString := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(IndexOf(aCtx, l_aComboTree, l_aString));
end;//TkwPopComboTreeIndexOf.DoDoIt

procedure TkwPopComboTreeSelectItem.SelectItem(const aCtx: TtfwContext;
 aComboTree: TvtComboTree;
 const aString: AnsiString);
 {* Реализация слова скрипта pop:ComboTree:SelectItem }
//#UC START# *55B7A5FB0027_55B7A5FB0027_55B780E60398_Word_var*
//#UC END# *55B7A5FB0027_55B7A5FB0027_55B780E60398_Word_var*
begin
//#UC START# *55B7A5FB0027_55B7A5FB0027_55B780E60398_Word_impl*
 aComboTree.ItemIndex := aComboTree.Items.IndexOf(aString);
//#UC END# *55B7A5FB0027_55B7A5FB0027_55B780E60398_Word_impl*
end;//TkwPopComboTreeSelectItem.SelectItem

class function TkwPopComboTreeSelectItem.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ComboTree:SelectItem';
end;//TkwPopComboTreeSelectItem.GetWordNameForRegister

function TkwPopComboTreeSelectItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopComboTreeSelectItem.GetResultTypeInfo

function TkwPopComboTreeSelectItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopComboTreeSelectItem.GetAllParamsCount

function TkwPopComboTreeSelectItem.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtComboTree), @tfw_tiString]);
end;//TkwPopComboTreeSelectItem.ParamsTypes

procedure TkwPopComboTreeSelectItem.DoDoIt(const aCtx: TtfwContext);
var l_aComboTree: TvtComboTree;
var l_aString: AnsiString;
begin
 try
  l_aComboTree := TvtComboTree(aCtx.rEngine.PopObjAs(TvtComboTree));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComboTree: TvtComboTree : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aString := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SelectItem(aCtx, l_aComboTree, l_aString);
end;//TkwPopComboTreeSelectItem.DoDoIt

procedure TkwPopComboTreeSetItemIndex.SetItemIndex(const aCtx: TtfwContext;
 aComboTree: TvtComboTree;
 anIndex: Integer);
 {* Реализация слова скрипта pop:ComboTree:SetItemIndex }
//#UC START# *55B7A6200240_55B7A6200240_55B780E60398_Word_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *55B7A6200240_55B7A6200240_55B780E60398_Word_var*
begin
//#UC START# *55B7A6200240_55B7A6200240_55B780E60398_Word_impl*
 if (aComboTree is TvtComboBoxQS) then //561950536
  aComboTree.ItemIndex := anIndex
 else
 begin
  l_Node := aComboTree.Tree.GetNode(anIndex);
  aComboTree.Tree.GotoOnNode(l_Node);
  aComboTree.ShowNode(l_Node, True);
 end;//aComboTree is TvtComboBoxQS
//#UC END# *55B7A6200240_55B7A6200240_55B780E60398_Word_impl*
end;//TkwPopComboTreeSetItemIndex.SetItemIndex

class function TkwPopComboTreeSetItemIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ComboTree:SetItemIndex';
end;//TkwPopComboTreeSetItemIndex.GetWordNameForRegister

function TkwPopComboTreeSetItemIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopComboTreeSetItemIndex.GetResultTypeInfo

function TkwPopComboTreeSetItemIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopComboTreeSetItemIndex.GetAllParamsCount

function TkwPopComboTreeSetItemIndex.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtComboTree), TypeInfo(Integer)]);
end;//TkwPopComboTreeSetItemIndex.ParamsTypes

procedure TkwPopComboTreeSetItemIndex.DoDoIt(const aCtx: TtfwContext);
var l_aComboTree: TvtComboTree;
var l_anIndex: Integer;
begin
 try
  l_aComboTree := TvtComboTree(aCtx.rEngine.PopObjAs(TvtComboTree));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComboTree: TvtComboTree : ' + E.Message, aCtx);
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
 SetItemIndex(aCtx, l_aComboTree, l_anIndex);
end;//TkwPopComboTreeSetItemIndex.DoDoIt

procedure TkwPopComboTreeSaveItems.SaveItems(const aCtx: TtfwContext;
 aComboTree: TvtComboTree;
 const aFileName: AnsiString);
 {* Реализация слова скрипта pop:ComboTree:SaveItems }
//#UC START# *55B7A69E02F1_55B7A69E02F1_55B780E60398_Word_var*
var
 l_S: AnsiString;
 l_Filer : Tl3CustomDosFiler;
//#UC END# *55B7A69E02F1_55B7A69E02F1_55B780E60398_Word_var*
begin
//#UC START# *55B7A69E02F1_55B7A69E02F1_55B780E60398_Word_impl*
 l_S := aCtx.rCaller.ResolveOutputFilePath(aFileName);
 l_S := ChangeFileExt(l_S, '.cmbx');
 l_Filer := Tl3CustomDosFiler.Make(l_S, l3_fmWrite, false);
 try
  l_Filer.Open;
  try
   l_Filer.WriteLn((aComboTree.Items as Il3Strings).Items.Text);
  finally
   l_Filer.Close;
  end;
 finally
  FreeAndNil(l_Filer);
 end;//try..finally
//#UC END# *55B7A69E02F1_55B7A69E02F1_55B780E60398_Word_impl*
end;//TkwPopComboTreeSaveItems.SaveItems

class function TkwPopComboTreeSaveItems.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ComboTree:SaveItems';
end;//TkwPopComboTreeSaveItems.GetWordNameForRegister

function TkwPopComboTreeSaveItems.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopComboTreeSaveItems.GetResultTypeInfo

function TkwPopComboTreeSaveItems.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopComboTreeSaveItems.GetAllParamsCount

function TkwPopComboTreeSaveItems.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtComboTree), @tfw_tiString]);
end;//TkwPopComboTreeSaveItems.ParamsTypes

procedure TkwPopComboTreeSaveItems.DoDoIt(const aCtx: TtfwContext);
var l_aComboTree: TvtComboTree;
var l_aFileName: AnsiString;
begin
 try
  l_aComboTree := TvtComboTree(aCtx.rEngine.PopObjAs(TvtComboTree));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComboTree: TvtComboTree : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFileName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFileName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SaveItems(aCtx, l_aComboTree, l_aFileName);
end;//TkwPopComboTreeSaveItems.DoDoIt

class function TvtComboBoxWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'vtComboBoxWordsPack';
end;//TvtComboBoxWordsPackResNameGetter.ResName

{$R vtComboBoxWordsPack.res}

initialization
 TkwPopComboBoxDropDown.RegisterInEngine;
 {* Регистрация pop_ComboBox_DropDown }
 TkwPopComboBoxGetItemIndex.RegisterInEngine;
 {* Регистрация pop_ComboBox_GetItemIndex }
 TkwPopComboBoxIndexOf.RegisterInEngine;
 {* Регистрация pop_ComboBox_IndexOf }
 TkwPopComboBoxSelectItem.RegisterInEngine;
 {* Регистрация pop_ComboBox_SelectItem }
 TkwPopComboBoxSetItemIndex.RegisterInEngine;
 {* Регистрация pop_ComboBox_SetItemIndex }
 TkwPopComboBoxSaveItems.RegisterInEngine;
 {* Регистрация pop_ComboBox_SaveItems }
 TkwPopComboTreeDropDown.RegisterInEngine;
 {* Регистрация pop_ComboTree_DropDown }
 TkwPopComboTreeGetItemIndex.RegisterInEngine;
 {* Регистрация pop_ComboTree_GetItemIndex }
 TkwPopComboTreeIndexOf.RegisterInEngine;
 {* Регистрация pop_ComboTree_IndexOf }
 TkwPopComboTreeSelectItem.RegisterInEngine;
 {* Регистрация pop_ComboTree_SelectItem }
 TkwPopComboTreeSetItemIndex.RegisterInEngine;
 {* Регистрация pop_ComboTree_SetItemIndex }
 TkwPopComboTreeSaveItems.RegisterInEngine;
 {* Регистрация pop_ComboTree_SaveItems }
 TvtComboBoxWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCustomComboBox));
 {* Регистрация типа TCustomComboBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtComboTree));
 {* Регистрация типа TvtComboTree }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
