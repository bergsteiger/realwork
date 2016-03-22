unit ddAppConfigDataAdapters;

// Модуль: "w:\common\components\rtl\Garant\dd\ddAppConfigDataAdapters.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddAppConfigDataAdapters" MUID: (5214CC01030F)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddAppConfigBase
 , ddConfigStorages
 , ddAppConfigTypes
 , ddAppConfigConst
 , l3ProtoPersistentRefList
 , Classes
;

type
 TddBaseConfigDataAdapter = class(TddAppConfigBase)
  private
   f_Alias: AnsiString;
    {* Поле для свойства Alias }
   f_IsChanged: Boolean;
    {* Поле для свойства IsChanged }
  protected
   procedure pm_SetAlias(const aValue: AnsiString); virtual;
   procedure pm_SetIsChanged(aValue: Boolean);
   function pm_GetCount: Integer; virtual;
   function pm_GetObjects(anIndex: Integer): TObject; virtual;
   function pm_GetStrings(anIndex: Integer): AnsiString; virtual;
   procedure SetIsChangedToItems(aValue: Boolean); virtual;
   procedure ClearFields; override;
  public
   function AddItem: Integer; virtual;
   function AsObject: TObject; virtual;
   function DeleteItem(anIndex: Integer): Boolean; virtual;
   function DownItem(anIndex: Integer): Boolean; virtual;
   function EditItem(anIndex: Integer): Boolean; virtual;
   procedure Load(const aStorage: IddConfigStorage;
    const anAlias: AnsiString); virtual;
   procedure Save(const aStorage: IddConfigStorage;
    const anAlias: AnsiString); virtual;
   function UpItem(anIndex: Integer): Boolean; virtual;
   procedure ClearItems; virtual; abstract;
  public
   property Alias: AnsiString
    read f_Alias
    write pm_SetAlias;
   property IsChanged: Boolean
    read f_IsChanged
    write pm_SetIsChanged;
   property Count: Integer
    read pm_GetCount;
   property Objects[anIndex: Integer]: TObject
    read pm_GetObjects;
   property Strings[anIndex: Integer]: AnsiString
    read pm_GetStrings;
 end;//TddBaseConfigDataAdapter

 TddSimpleListDataAdapter = class(TddBaseConfigDataAdapter)
  private
   f_Items: Tl3ProtoPersistentRefList;
   f_DataConfig: TddAppConfigNode;
    {* Поле для свойства DataConfig }
  protected
   procedure pm_SetDataConfig(aValue: TddAppConfigNode);
   function pm_GetValues(anIndex: Integer;
    const anAlias: AnsiString): TddConfigValue; virtual;
   procedure pm_SetValues(anIndex: Integer;
    const anAlias: AnsiString;
    const aValue: TddConfigValue); virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure pm_SetAlias(const aValue: AnsiString); override;
   function pm_GetCount: Integer; override;
   function pm_GetObjects(anIndex: Integer): TObject; override;
   function pm_GetStrings(anIndex: Integer): AnsiString; override;
   procedure SetIsChangedToItems(aValue: Boolean); override;
  public
   function MakeItem: TddAppConfigNode;
   constructor Make(const anAlias: AnsiString); reintroduce;
   procedure ClearItems; override;
   procedure Assign(Source: TPersistent); override;
   function AddItem: Integer; override;
   function AsObject: TObject; override;
   function DeleteItem(anIndex: Integer): Boolean; override;
   function DownItem(anIndex: Integer): Boolean; override;
   function EditItem(anIndex: Integer): Boolean; override;
   procedure Load(const aStorage: IddConfigStorage;
    const anAlias: AnsiString); override;
   procedure Save(const aStorage: IddConfigStorage;
    const anAlias: AnsiString); override;
   function UpItem(anIndex: Integer): Boolean; override;
   constructor Create; override;
  public
   property DataConfig: TddAppConfigNode
    read f_DataConfig
    write pm_SetDataConfig;
   property Values[anIndex: Integer; const anAlias: AnsiString]: TddConfigValue
    read pm_GetValues
    write pm_SetValues;
 end;//TddSimpleListDataAdapter

 TddStringDataAdapter = class(TddBaseConfigDataAdapter)
  private
   f_Strings: TStrings;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function pm_GetCount: Integer; override;
   function pm_GetStrings(anIndex: Integer): AnsiString; override;
  public
   function GetStrings: TStrings;
   procedure ClearItems; override;
   procedure Assign(Source: TPersistent); override;
   function AsObject: TObject; override;
   function DeleteItem(anIndex: Integer): Boolean; override;
   function DownItem(anIndex: Integer): Boolean; override;
   function EditItem(anIndex: Integer): Boolean; override;
   procedure Load(const aStorage: IddConfigStorage;
    const anAlias: AnsiString); override;
   procedure Save(const aStorage: IddConfigStorage;
    const anAlias: AnsiString); override;
   function UpItem(anIndex: Integer): Boolean; override;
   constructor Create; override;
 end;//TddStringDataAdapter

implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
 , l3Base
 , Math
 , ddAppConfigStrings
 , ddAppConfigUtils
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TddBaseConfigDataAdapter.pm_SetAlias(const aValue: AnsiString);
//#UC START# *522EDF8F0390_5214CC1D02F4set_var*
//#UC END# *522EDF8F0390_5214CC1D02F4set_var*
begin
//#UC START# *522EDF8F0390_5214CC1D02F4set_impl*
 f_Alias := aValue;
//#UC END# *522EDF8F0390_5214CC1D02F4set_impl*
end;//TddBaseConfigDataAdapter.pm_SetAlias

procedure TddBaseConfigDataAdapter.pm_SetIsChanged(aValue: Boolean);
//#UC START# *522EDFCE0135_5214CC1D02F4set_var*
//#UC END# *522EDFCE0135_5214CC1D02F4set_var*
begin
//#UC START# *522EDFCE0135_5214CC1D02F4set_impl*
 if f_IsChanged <> aValue then
 begin
  f_IsChanged := aValue;
  SetIsChangedToItems(aValue);
 end;
//#UC END# *522EDFCE0135_5214CC1D02F4set_impl*
end;//TddBaseConfigDataAdapter.pm_SetIsChanged

function TddBaseConfigDataAdapter.pm_GetCount: Integer;
//#UC START# *522EDFF601C6_5214CC1D02F4get_var*
//#UC END# *522EDFF601C6_5214CC1D02F4get_var*
begin
//#UC START# *522EDFF601C6_5214CC1D02F4get_impl*
 Result := 0;
//#UC END# *522EDFF601C6_5214CC1D02F4get_impl*
end;//TddBaseConfigDataAdapter.pm_GetCount

function TddBaseConfigDataAdapter.pm_GetObjects(anIndex: Integer): TObject;
//#UC START# *522EE02F00FF_5214CC1D02F4get_var*
//#UC END# *522EE02F00FF_5214CC1D02F4get_var*
begin
//#UC START# *522EE02F00FF_5214CC1D02F4get_impl*
 Result := nil;
//#UC END# *522EE02F00FF_5214CC1D02F4get_impl*
end;//TddBaseConfigDataAdapter.pm_GetObjects

function TddBaseConfigDataAdapter.pm_GetStrings(anIndex: Integer): AnsiString;
//#UC START# *522EE0530101_5214CC1D02F4get_var*
//#UC END# *522EE0530101_5214CC1D02F4get_var*
begin
//#UC START# *522EE0530101_5214CC1D02F4get_impl*
 Result := '';
//#UC END# *522EE0530101_5214CC1D02F4get_impl*
end;//TddBaseConfigDataAdapter.pm_GetStrings

procedure TddBaseConfigDataAdapter.SetIsChangedToItems(aValue: Boolean);
//#UC START# *522EE0A00116_5214CC1D02F4_var*
//#UC END# *522EE0A00116_5214CC1D02F4_var*
begin
//#UC START# *522EE0A00116_5214CC1D02F4_impl*
//#UC END# *522EE0A00116_5214CC1D02F4_impl*
end;//TddBaseConfigDataAdapter.SetIsChangedToItems

function TddBaseConfigDataAdapter.AddItem: Integer;
//#UC START# *522EE0C502CE_5214CC1D02F4_var*
//#UC END# *522EE0C502CE_5214CC1D02F4_var*
begin
//#UC START# *522EE0C502CE_5214CC1D02F4_impl*
 Result := -1;
//#UC END# *522EE0C502CE_5214CC1D02F4_impl*
end;//TddBaseConfigDataAdapter.AddItem

function TddBaseConfigDataAdapter.AsObject: TObject;
//#UC START# *522EE0DF0080_5214CC1D02F4_var*
//#UC END# *522EE0DF0080_5214CC1D02F4_var*
begin
//#UC START# *522EE0DF0080_5214CC1D02F4_impl*
 Result := Self;
//#UC END# *522EE0DF0080_5214CC1D02F4_impl*
end;//TddBaseConfigDataAdapter.AsObject

function TddBaseConfigDataAdapter.DeleteItem(anIndex: Integer): Boolean;
//#UC START# *522EE0FB0163_5214CC1D02F4_var*
//#UC END# *522EE0FB0163_5214CC1D02F4_var*
begin
//#UC START# *522EE0FB0163_5214CC1D02F4_impl*
 Result := False;
//#UC END# *522EE0FB0163_5214CC1D02F4_impl*
end;//TddBaseConfigDataAdapter.DeleteItem

function TddBaseConfigDataAdapter.DownItem(anIndex: Integer): Boolean;
//#UC START# *522EE15F026E_5214CC1D02F4_var*
//#UC END# *522EE15F026E_5214CC1D02F4_var*
begin
//#UC START# *522EE15F026E_5214CC1D02F4_impl*
 Result := False;
//#UC END# *522EE15F026E_5214CC1D02F4_impl*
end;//TddBaseConfigDataAdapter.DownItem

function TddBaseConfigDataAdapter.EditItem(anIndex: Integer): Boolean;
//#UC START# *522EE19901B6_5214CC1D02F4_var*
//#UC END# *522EE19901B6_5214CC1D02F4_var*
begin
//#UC START# *522EE19901B6_5214CC1D02F4_impl*
 Result := False;
//#UC END# *522EE19901B6_5214CC1D02F4_impl*
end;//TddBaseConfigDataAdapter.EditItem

procedure TddBaseConfigDataAdapter.Load(const aStorage: IddConfigStorage;
 const anAlias: AnsiString);
//#UC START# *522EE1B9018D_5214CC1D02F4_var*
//#UC END# *522EE1B9018D_5214CC1D02F4_var*
begin
//#UC START# *522EE1B9018D_5214CC1D02F4_impl*
//#UC END# *522EE1B9018D_5214CC1D02F4_impl*
end;//TddBaseConfigDataAdapter.Load

procedure TddBaseConfigDataAdapter.Save(const aStorage: IddConfigStorage;
 const anAlias: AnsiString);
//#UC START# *522EE1D7016D_5214CC1D02F4_var*
//#UC END# *522EE1D7016D_5214CC1D02F4_var*
begin
//#UC START# *522EE1D7016D_5214CC1D02F4_impl*
//#UC END# *522EE1D7016D_5214CC1D02F4_impl*
end;//TddBaseConfigDataAdapter.Save

function TddBaseConfigDataAdapter.UpItem(anIndex: Integer): Boolean;
//#UC START# *522EE1F7018F_5214CC1D02F4_var*
//#UC END# *522EE1F7018F_5214CC1D02F4_var*
begin
//#UC START# *522EE1F7018F_5214CC1D02F4_impl*
 Result := False;
//#UC END# *522EE1F7018F_5214CC1D02F4_impl*
end;//TddBaseConfigDataAdapter.UpItem

procedure TddBaseConfigDataAdapter.ClearFields;
begin
 Alias := '';
 inherited;
end;//TddBaseConfigDataAdapter.ClearFields

procedure TddSimpleListDataAdapter.pm_SetDataConfig(aValue: TddAppConfigNode);
//#UC START# *522EE27A017F_522EDF570036set_var*
//#UC END# *522EE27A017F_522EDF570036set_var*
begin
//#UC START# *522EE27A017F_522EDF570036set_impl*
 l3Free(f_DataConfig);
 f_DataConfig:= aValue;
//#UC END# *522EE27A017F_522EDF570036set_impl*
end;//TddSimpleListDataAdapter.pm_SetDataConfig

function TddSimpleListDataAdapter.pm_GetValues(anIndex: Integer;
 const anAlias: AnsiString): TddConfigValue;
//#UC START# *522EE2F603A2_522EDF570036get_var*
//#UC END# *522EE2F603A2_522EDF570036get_var*
begin
//#UC START# *522EE2F603A2_522EDF570036get_impl*
 if InRange(anIndex, 0, Pred(Count)) then
  Result := TddAppConfigNode(Objects[anIndex]).ItemByAlias[anAlias].Value
 else
  raise EListError.CreateFmt('Отсутствует элемент с индексом %d в списке из %d элементов', [anIndex, Count]);
//#UC END# *522EE2F603A2_522EDF570036get_impl*
end;//TddSimpleListDataAdapter.pm_GetValues

procedure TddSimpleListDataAdapter.pm_SetValues(anIndex: Integer;
 const anAlias: AnsiString;
 const aValue: TddConfigValue);
//#UC START# *522EE2F603A2_522EDF570036set_var*
//#UC END# *522EE2F603A2_522EDF570036set_var*
begin
//#UC START# *522EE2F603A2_522EDF570036set_impl*
//#UC END# *522EE2F603A2_522EDF570036set_impl*
end;//TddSimpleListDataAdapter.pm_SetValues

function TddSimpleListDataAdapter.MakeItem: TddAppConfigNode;
//#UC START# *522EE4200381_522EDF570036_var*
var
 l_Node: TddAppConfigNode;
 l_Alias: AnsiString;
//#UC END# *522EE4200381_522EDF570036_var*
begin
//#UC START# *522EE4200381_522EDF570036_impl*
 l_Alias := Alias + 'I' + IntToStr(f_Items.Count);
 Result := DataConfig.Clone;
 Result.Alias := l_Alias;
//#UC END# *522EE4200381_522EDF570036_impl*
end;//TddSimpleListDataAdapter.MakeItem

constructor TddSimpleListDataAdapter.Make(const anAlias: AnsiString);
//#UC START# *522EE43E0110_522EDF570036_var*
//#UC END# *522EE43E0110_522EDF570036_var*
begin
//#UC START# *522EE43E0110_522EDF570036_impl*
 Create;
 f_DataConfig.Alias:= anAlias;
//#UC END# *522EE43E0110_522EDF570036_impl*
end;//TddSimpleListDataAdapter.Make

procedure TddSimpleListDataAdapter.ClearItems;
//#UC START# *56D93DBD039D_522EDF570036_var*
//#UC END# *56D93DBD039D_522EDF570036_var*
begin
//#UC START# *56D93DBD039D_522EDF570036_impl*
 f_Items.Clear;
//#UC END# *56D93DBD039D_522EDF570036_impl*
end;//TddSimpleListDataAdapter.ClearItems

procedure TddSimpleListDataAdapter.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_522EDF570036_var*
var
 I: Integer;
 l_Item: TddBaseConfigItem;
//#UC END# *478CF34E02CE_522EDF570036_var*
begin
//#UC START# *478CF34E02CE_522EDF570036_impl*
 if Source is TddSimpleListDataAdapter then
 begin
  f_DataConfig.Assign(TddSimpleListDataAdapter(Source).DataConfig);
  f_Items.Clear;
  for I := 0 to TddSimpleListDataAdapter(Source).f_Items.Hi do
  begin
   l_Item:= (TddSimpleListDataAdapter(Source).f_Items.Items[I] As TddBaseConfigItem).Clone;
   try
    f_Items.Add(l_Item);
   finally
    l3Free(l_Item);
   end;
  end;
  Alias:= TddSimpleListDataAdapter(Source).Alias;
 end
 else
  inherited;
//#UC END# *478CF34E02CE_522EDF570036_impl*
end;//TddSimpleListDataAdapter.Assign

procedure TddSimpleListDataAdapter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_522EDF570036_var*
//#UC END# *479731C50290_522EDF570036_var*
begin
//#UC START# *479731C50290_522EDF570036_impl*
 inherited;
 l3Free(f_Items);
 l3Free(f_DataConfig);
//#UC END# *479731C50290_522EDF570036_impl*
end;//TddSimpleListDataAdapter.Cleanup

procedure TddSimpleListDataAdapter.pm_SetAlias(const aValue: AnsiString);
//#UC START# *522EDF8F0390_522EDF570036set_var*
var
 I: Integer; 
//#UC END# *522EDF8F0390_522EDF570036set_var*
begin
//#UC START# *522EDF8F0390_522EDF570036set_impl*
 inherited;
 for I := 0 to f_Items.Hi do
  TddAppConfigNode(Objects[I]).Alias := Format('%sI%d', [Alias, i]);
//#UC END# *522EDF8F0390_522EDF570036set_impl*
end;//TddSimpleListDataAdapter.pm_SetAlias

function TddSimpleListDataAdapter.pm_GetCount: Integer;
//#UC START# *522EDFF601C6_522EDF570036get_var*
//#UC END# *522EDFF601C6_522EDF570036get_var*
begin
//#UC START# *522EDFF601C6_522EDF570036get_impl*
 Result := f_Items.Count;
//#UC END# *522EDFF601C6_522EDF570036get_impl*
end;//TddSimpleListDataAdapter.pm_GetCount

function TddSimpleListDataAdapter.pm_GetObjects(anIndex: Integer): TObject;
//#UC START# *522EE02F00FF_522EDF570036get_var*
//#UC END# *522EE02F00FF_522EDF570036get_var*
begin
//#UC START# *522EE02F00FF_522EDF570036get_impl*
 Result := f_Items[anIndex];
//#UC END# *522EE02F00FF_522EDF570036get_impl*
end;//TddSimpleListDataAdapter.pm_GetObjects

function TddSimpleListDataAdapter.pm_GetStrings(anIndex: Integer): AnsiString;
//#UC START# *522EE0530101_522EDF570036get_var*
//#UC END# *522EE0530101_522EDF570036get_var*
begin
//#UC START# *522EE0530101_522EDF570036get_impl*
 Result := TddAppConfigNode(f_Items.Items[anIndex]).Caption;
//#UC END# *522EE0530101_522EDF570036get_impl*
end;//TddSimpleListDataAdapter.pm_GetStrings

procedure TddSimpleListDataAdapter.SetIsChangedToItems(aValue: Boolean);
//#UC START# *522EE0A00116_522EDF570036_var*
var
 I: Integer;
//#UC END# *522EE0A00116_522EDF570036_var*
begin
//#UC START# *522EE0A00116_522EDF570036_impl*
 for I := 0 to Pred(Count) do
  TddAppConfigNode(Objects[I]).Changed := aValue;
//#UC END# *522EE0A00116_522EDF570036_impl*
end;//TddSimpleListDataAdapter.SetIsChangedToItems

function TddSimpleListDataAdapter.AddItem: Integer;
//#UC START# *522EE0C502CE_522EDF570036_var*
var
 l_Node: TddAppConfigNode;
//#UC END# *522EE0C502CE_522EDF570036_var*
begin
//#UC START# *522EE0C502CE_522EDF570036_impl*
 l_Node:= MakeItem;
 try
  Result:= f_Items.Add(l_Node);
 finally
  l3Free(l_Node);
 end;
//#UC END# *522EE0C502CE_522EDF570036_impl*
end;//TddSimpleListDataAdapter.AddItem

function TddSimpleListDataAdapter.AsObject: TObject;
//#UC START# *522EE0DF0080_522EDF570036_var*
//#UC END# *522EE0DF0080_522EDF570036_var*
begin
//#UC START# *522EE0DF0080_522EDF570036_impl*
 Result := Self;
//#UC END# *522EE0DF0080_522EDF570036_impl*
end;//TddSimpleListDataAdapter.AsObject

function TddSimpleListDataAdapter.DeleteItem(anIndex: Integer): Boolean;
//#UC START# *522EE0FB0163_522EDF570036_var*
//#UC END# *522EE0FB0163_522EDF570036_var*
begin
//#UC START# *522EE0FB0163_522EDF570036_impl*
 Result := True;
 f_Items.Delete(anIndex);
//#UC END# *522EE0FB0163_522EDF570036_impl*
end;//TddSimpleListDataAdapter.DeleteItem

function TddSimpleListDataAdapter.DownItem(anIndex: Integer): Boolean;
//#UC START# *522EE15F026E_522EDF570036_var*
//#UC END# *522EE15F026E_522EDF570036_var*
begin
//#UC START# *522EE15F026E_522EDF570036_impl*
 Result := True;
 f_Items.Exchange(anIndex, Succ(anIndex));
//#UC END# *522EE15F026E_522EDF570036_impl*
end;//TddSimpleListDataAdapter.DownItem

function TddSimpleListDataAdapter.EditItem(anIndex: Integer): Boolean;
//#UC START# *522EE19901B6_522EDF570036_var*
var
 l_Node: TddAppConfigNode;
 l_Alias: AnsiString;
//#UC END# *522EE19901B6_522EDF570036_var*
begin
//#UC START# *522EE19901B6_522EDF570036_impl*
 if anIndex < 0 then
  // Новый элемент
  l_Node:= MakeItem
 else
  l_Node:= TddAppConfigNode(f_Items.Items[anIndex]);
 Result:= ExecuteNodeDialog(l_Node);
 if Result then
 begin
  l_Node.Caption:= l_Node.Items[0].StringValue;
  if anIndex < 0 then
   f_Items.Add(l_Node);
 end;
 if anIndex < 0 then
  l3Free(l_Node);
//#UC END# *522EE19901B6_522EDF570036_impl*
end;//TddSimpleListDataAdapter.EditItem

procedure TddSimpleListDataAdapter.Load(const aStorage: IddConfigStorage;
 const anAlias: AnsiString);
//#UC START# *522EE1B9018D_522EDF570036_var*
var
 l_Count, I: Integer;
 l_Node: TddAppConfigNode;
//#UC END# *522EE1B9018D_522EDF570036_var*
begin
//#UC START# *522EE1B9018D_522EDF570036_impl*
 l_Count := aStorage.ReadInteger(anAlias + '.Count', 0);
 for I := 0 to Pred(l_Count) do
 begin
  l_Node := MakeItem;
  try
   l_Node.Load(aStorage);
   if l_Node.AsString['Caption'] <> '' then
    l_Node.Caption := l_Node.AsString['Caption'];
   f_Items.Add(l_Node);
  finally
   l3Free(l_Node);
  end;
 end;
//#UC END# *522EE1B9018D_522EDF570036_impl*
end;//TddSimpleListDataAdapter.Load

procedure TddSimpleListDataAdapter.Save(const aStorage: IddConfigStorage;
 const anAlias: AnsiString);
//#UC START# *522EE1D7016D_522EDF570036_var*
var
 I: Integer;
//#UC END# *522EE1D7016D_522EDF570036_var*
begin
//#UC START# *522EE1D7016D_522EDF570036_impl*
 aStorage.WriteInteger(anAlias + '.Count', f_Items.Count);
 for I := 0 to f_Items.Hi do
  IddConfigNode(TddAppConfigNode(Objects[I])).SaveData(aStorage);
//#UC END# *522EE1D7016D_522EDF570036_impl*
end;//TddSimpleListDataAdapter.Save

function TddSimpleListDataAdapter.UpItem(anIndex: Integer): Boolean;
//#UC START# *522EE1F7018F_522EDF570036_var*
//#UC END# *522EE1F7018F_522EDF570036_var*
begin
//#UC START# *522EE1F7018F_522EDF570036_impl*
 Result:= True;
 f_Items.Exchange(anIndex, Pred(anIndex));
//#UC END# *522EE1F7018F_522EDF570036_impl*
end;//TddSimpleListDataAdapter.UpItem

constructor TddSimpleListDataAdapter.Create;
//#UC START# *5301EC5A006A_522EDF570036_var*
//#UC END# *5301EC5A006A_522EDF570036_var*
begin
//#UC START# *5301EC5A006A_522EDF570036_impl*
 inherited Create;
 f_Items := Tl3ProtoPersistentRefList.Make;
 f_DataConfig := TddAppConfigNode.Create('Adapter', 'Новый элемент');
 f_DataConfig.AddItem(TddStringConfigItem.Create('Caption', 'Название', ddEmptyValue))
//#UC END# *5301EC5A006A_522EDF570036_impl*
end;//TddSimpleListDataAdapter.Create

function TddStringDataAdapter.GetStrings: TStrings;
//#UC START# *522EE4E000E1_522EDF6702AF_var*
//#UC END# *522EE4E000E1_522EDF6702AF_var*
begin
//#UC START# *522EE4E000E1_522EDF6702AF_impl*
 Result := f_Strings;
//#UC END# *522EE4E000E1_522EDF6702AF_impl*
end;//TddStringDataAdapter.GetStrings

procedure TddStringDataAdapter.ClearItems;
//#UC START# *56D93DBD039D_522EDF6702AF_var*
//#UC END# *56D93DBD039D_522EDF6702AF_var*
begin
//#UC START# *56D93DBD039D_522EDF6702AF_impl*
 f_Strings.Clear;
//#UC END# *56D93DBD039D_522EDF6702AF_impl*
end;//TddStringDataAdapter.ClearItems

procedure TddStringDataAdapter.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_522EDF6702AF_var*
//#UC END# *478CF34E02CE_522EDF6702AF_var*
begin
//#UC START# *478CF34E02CE_522EDF6702AF_impl*
 if Source is TddStringDataAdapter then
  f_Strings.Assign(TddStringDataAdapter(Source).GetStrings)
 else
  inherited;
//#UC END# *478CF34E02CE_522EDF6702AF_impl*
end;//TddStringDataAdapter.Assign

procedure TddStringDataAdapter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_522EDF6702AF_var*
//#UC END# *479731C50290_522EDF6702AF_var*
begin
//#UC START# *479731C50290_522EDF6702AF_impl*
 l3Free(f_Strings);
 inherited;
//#UC END# *479731C50290_522EDF6702AF_impl*
end;//TddStringDataAdapter.Cleanup

function TddStringDataAdapter.pm_GetCount: Integer;
//#UC START# *522EDFF601C6_522EDF6702AFget_var*
//#UC END# *522EDFF601C6_522EDF6702AFget_var*
begin
//#UC START# *522EDFF601C6_522EDF6702AFget_impl*
 Result := f_Strings.Count;
//#UC END# *522EDFF601C6_522EDF6702AFget_impl*
end;//TddStringDataAdapter.pm_GetCount

function TddStringDataAdapter.pm_GetStrings(anIndex: Integer): AnsiString;
//#UC START# *522EE0530101_522EDF6702AFget_var*
//#UC END# *522EE0530101_522EDF6702AFget_var*
begin
//#UC START# *522EE0530101_522EDF6702AFget_impl*
 Result := f_Strings[anIndex];
//#UC END# *522EE0530101_522EDF6702AFget_impl*
end;//TddStringDataAdapter.pm_GetStrings

function TddStringDataAdapter.AsObject: TObject;
//#UC START# *522EE0DF0080_522EDF6702AF_var*
//#UC END# *522EE0DF0080_522EDF6702AF_var*
begin
//#UC START# *522EE0DF0080_522EDF6702AF_impl*
 Result := f_Strings;
//#UC END# *522EE0DF0080_522EDF6702AF_impl*
end;//TddStringDataAdapter.AsObject

function TddStringDataAdapter.DeleteItem(anIndex: Integer): Boolean;
//#UC START# *522EE0FB0163_522EDF6702AF_var*
//#UC END# *522EE0FB0163_522EDF6702AF_var*
begin
//#UC START# *522EE0FB0163_522EDF6702AF_impl*
 Result := True;
 f_Strings.Delete(anIndex);
//#UC END# *522EE0FB0163_522EDF6702AF_impl*
end;//TddStringDataAdapter.DeleteItem

function TddStringDataAdapter.DownItem(anIndex: Integer): Boolean;
//#UC START# *522EE15F026E_522EDF6702AF_var*
//#UC END# *522EE15F026E_522EDF6702AF_var*
begin
//#UC START# *522EE15F026E_522EDF6702AF_impl*
 Result := True;
 f_Strings.Exchange(anIndex, Succ(anIndex));
//#UC END# *522EE15F026E_522EDF6702AF_impl*
end;//TddStringDataAdapter.DownItem

function TddStringDataAdapter.EditItem(anIndex: Integer): Boolean;
//#UC START# *522EE19901B6_522EDF6702AF_var*
var
 l_S: String;
//#UC END# *522EE19901B6_522EDF6702AF_var*
begin
//#UC START# *522EE19901B6_522EDF6702AF_impl*
 if anIndex > -1 then
  l_S := f_Strings[anIndex]
 else
  l_S := '';
 Result := InputQuery('Редактирование элемента', 'Введите текст элемента', l_S);
 if Result then
  if anIndex = -1 then
   f_Strings.Add(l_S)
  else
   f_Strings.Strings[anIndex] := l_S;
//#UC END# *522EE19901B6_522EDF6702AF_impl*
end;//TddStringDataAdapter.EditItem

procedure TddStringDataAdapter.Load(const aStorage: IddConfigStorage;
 const anAlias: AnsiString);
//#UC START# *522EE1B9018D_522EDF6702AF_var*
var
 I: Integer;
 l_Count: Integer;
//#UC END# *522EE1B9018D_522EDF6702AF_var*
begin
//#UC START# *522EE1B9018D_522EDF6702AF_impl*
  inherited;
  l_Count := aStorage.ReadInteger(anAlias + 'Count', 0);
  for I := 0 to Pred(l_Count) do
   f_Strings.Add(l3Str(aStorage.ReadString(anAlias + IntToStr(I), '')));
//#UC END# *522EE1B9018D_522EDF6702AF_impl*
end;//TddStringDataAdapter.Load

procedure TddStringDataAdapter.Save(const aStorage: IddConfigStorage;
 const anAlias: AnsiString);
//#UC START# *522EE1D7016D_522EDF6702AF_var*
var
 I: Integer;
//#UC END# *522EE1D7016D_522EDF6702AF_var*
begin
//#UC START# *522EE1D7016D_522EDF6702AF_impl*
 inherited;
 aStorage.WriteInteger(anAlias + 'Count', f_Strings.Count);
 for I := 0 to Pred(f_Strings.Count) do
  aStorage.WriteString(anAlias + IntToStr(I), f_Strings.Strings[I]);
//#UC END# *522EE1D7016D_522EDF6702AF_impl*
end;//TddStringDataAdapter.Save

function TddStringDataAdapter.UpItem(anIndex: Integer): Boolean;
//#UC START# *522EE1F7018F_522EDF6702AF_var*
//#UC END# *522EE1F7018F_522EDF6702AF_var*
begin
//#UC START# *522EE1F7018F_522EDF6702AF_impl*
 Result := True;
 f_Strings.Exchange(anIndex, Pred(anIndex));
//#UC END# *522EE1F7018F_522EDF6702AF_impl*
end;//TddStringDataAdapter.UpItem

constructor TddStringDataAdapter.Create;
//#UC START# *5301EC5A006A_522EDF6702AF_var*
//#UC END# *5301EC5A006A_522EDF6702AF_var*
begin
//#UC START# *5301EC5A006A_522EDF6702AF_impl*
 inherited;
 f_Strings := TStringList.Create;
//#UC END# *5301EC5A006A_522EDF6702AF_impl*
end;//TddStringDataAdapter.Create

end.
