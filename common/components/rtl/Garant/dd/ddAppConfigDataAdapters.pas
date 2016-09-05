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
   f_IsChanged: Boolean;
   f_IsEditing: Boolean;
  protected
   procedure pm_SetAlias(const aValue: AnsiString); virtual;
   procedure pm_SetIsChanged(aValue: Boolean);
   function pm_GetCount: Integer; virtual; abstract;
   function pm_GetObjects(anIndex: Integer): TObject; virtual; abstract;
   function pm_GetStrings(anIndex: Integer): AnsiString; virtual; abstract;
   function pm_GetEditCount: Integer; virtual; abstract;
   function pm_GetEditObjects(anIndex: Integer): TObject; virtual; abstract;
   function pm_GetEditStrings(anIndex: Integer): AnsiString; virtual; abstract;
   procedure SetIsChangedToItems(aValue: Boolean); virtual;
   procedure DoBeginEdit; virtual; abstract;
   procedure DoEndEdit; virtual; abstract;
   procedure DoPostChanges; virtual; abstract;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   function AsObject: TObject; virtual;
   function DeleteItem(anIndex: Integer): Boolean; virtual; abstract;
   function EditItem(anIndex: Integer): Boolean; virtual; abstract;
   procedure Load(const aStorage: IddConfigStorage;
    const anAlias: AnsiString); virtual; abstract;
   procedure Save(const aStorage: IddConfigStorage;
    const anAlias: AnsiString); virtual; abstract;
   procedure BeginEdit;
   procedure EndEdit;
   procedure PostChanges;
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
   property EditCount: Integer
    read pm_GetEditCount;
   property EditObjects[anIndex: Integer]: TObject
    read pm_GetEditObjects;
   property EditStrings[anIndex: Integer]: AnsiString
    read pm_GetEditStrings;
   property IsEditing: Boolean
    read f_IsEditing;
 end;//TddBaseConfigDataAdapter

 TddSimpleListDataAdapter = class(TddBaseConfigDataAdapter)
  private
   f_Items: Tl3ProtoPersistentRefList;
   f_EditItems: Tl3ProtoPersistentRefList;
   f_DataConfig: TddAppConfigNode;
  protected
   procedure pm_SetDataConfig(aValue: TddAppConfigNode);
   function pm_GetValues(anIndex: Integer;
    const anAlias: AnsiString): TddConfigValue; virtual;
   procedure pm_SetValues(anIndex: Integer;
    const anAlias: AnsiString;
    const aValue: TddConfigValue); virtual;
   function MakeItem: TddAppConfigNode;
   function pm_GetCount: Integer; override;
   function pm_GetObjects(anIndex: Integer): TObject; override;
   function pm_GetStrings(anIndex: Integer): AnsiString; override;
   procedure DoBeginEdit; override;
   procedure DoEndEdit; override;
   procedure DoPostChanges; override;
   function pm_GetEditCount: Integer; override;
   function pm_GetEditObjects(anIndex: Integer): TObject; override;
   function pm_GetEditStrings(anIndex: Integer): AnsiString; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure pm_SetAlias(const aValue: AnsiString); override;
   procedure SetIsChangedToItems(aValue: Boolean); override;
  public
   constructor Make(const anAlias: AnsiString); reintroduce;
   function AddItem: Integer;
   procedure ClearItems;
   function DeleteItem(anIndex: Integer): Boolean; override;
   function EditItem(anIndex: Integer): Boolean; override;
   procedure Load(const aStorage: IddConfigStorage;
    const anAlias: AnsiString); override;
   procedure Save(const aStorage: IddConfigStorage;
    const anAlias: AnsiString); override;
   procedure Assign(Source: TPersistent); override;
   function AsObject: TObject; override;
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
   f_EditStrings: TStrings;
  protected
   function pm_GetCount: Integer; override;
   function pm_GetObjects(anIndex: Integer): TObject; override;
   function pm_GetStrings(anIndex: Integer): AnsiString; override;
   procedure DoBeginEdit; override;
   procedure DoEndEdit; override;
   procedure DoPostChanges; override;
   function pm_GetEditCount: Integer; override;
   function pm_GetEditObjects(anIndex: Integer): TObject; override;
   function pm_GetEditStrings(anIndex: Integer): AnsiString; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   function GetStrings: TStrings;
   function DeleteItem(anIndex: Integer): Boolean; override;
   function EditItem(anIndex: Integer): Boolean; override;
   procedure Load(const aStorage: IddConfigStorage;
    const anAlias: AnsiString); override;
   procedure Save(const aStorage: IddConfigStorage;
    const anAlias: AnsiString); override;
   procedure Assign(Source: TPersistent); override;
   function AsObject: TObject; override;
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
 , ddTemporaryStorage
 //#UC START# *5214CC01030Fimpl_uses*
 //#UC END# *5214CC01030Fimpl_uses*
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

procedure TddBaseConfigDataAdapter.SetIsChangedToItems(aValue: Boolean);
//#UC START# *522EE0A00116_5214CC1D02F4_var*
//#UC END# *522EE0A00116_5214CC1D02F4_var*
begin
//#UC START# *522EE0A00116_5214CC1D02F4_impl*
//#UC END# *522EE0A00116_5214CC1D02F4_impl*
end;//TddBaseConfigDataAdapter.SetIsChangedToItems

function TddBaseConfigDataAdapter.AsObject: TObject;
//#UC START# *522EE0DF0080_5214CC1D02F4_var*
//#UC END# *522EE0DF0080_5214CC1D02F4_var*
begin
//#UC START# *522EE0DF0080_5214CC1D02F4_impl*
 Result := Self;
//#UC END# *522EE0DF0080_5214CC1D02F4_impl*
end;//TddBaseConfigDataAdapter.AsObject

procedure TddBaseConfigDataAdapter.BeginEdit;
//#UC START# *57A312D003D6_5214CC1D02F4_var*
//#UC END# *57A312D003D6_5214CC1D02F4_var*
begin
//#UC START# *57A312D003D6_5214CC1D02F4_impl*
 Assert(not IsEditing);
 f_IsEditing := True;
 DoBeginEdit;
//#UC END# *57A312D003D6_5214CC1D02F4_impl*
end;//TddBaseConfigDataAdapter.BeginEdit

procedure TddBaseConfigDataAdapter.EndEdit;
//#UC START# *57A312E20168_5214CC1D02F4_var*
//#UC END# *57A312E20168_5214CC1D02F4_var*
begin
//#UC START# *57A312E20168_5214CC1D02F4_impl*
 Assert(IsEditing);
 DoEndEdit;
 f_IsEditing := False;
//#UC END# *57A312E20168_5214CC1D02F4_impl*
end;//TddBaseConfigDataAdapter.EndEdit

procedure TddBaseConfigDataAdapter.PostChanges;
//#UC START# *57A312F900C7_5214CC1D02F4_var*
//#UC END# *57A312F900C7_5214CC1D02F4_var*
begin
//#UC START# *57A312F900C7_5214CC1D02F4_impl*
 Assert(IsEditing);
 DoPostChanges;
//#UC END# *57A312F900C7_5214CC1D02F4_impl*
end;//TddBaseConfigDataAdapter.PostChanges

procedure TddBaseConfigDataAdapter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5214CC1D02F4_var*
//#UC END# *479731C50290_5214CC1D02F4_var*
begin
//#UC START# *479731C50290_5214CC1D02F4_impl*
 Assert(not IsEditing);
 inherited;
//#UC END# *479731C50290_5214CC1D02F4_impl*
end;//TddBaseConfigDataAdapter.Cleanup

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

function TddSimpleListDataAdapter.AddItem: Integer;
//#UC START# *57A05EC4018F_522EDF570036_var*
var
 l_Node: TddAppConfigNode;
//#UC END# *57A05EC4018F_522EDF570036_var*
begin
//#UC START# *57A05EC4018F_522EDF570036_impl*
 l_Node:= MakeItem;
 try
  Result:= f_Items.Add(l_Node);
 finally
  l3Free(l_Node);
 end;
//#UC END# *57A05EC4018F_522EDF570036_impl*
end;//TddSimpleListDataAdapter.AddItem

procedure TddSimpleListDataAdapter.ClearItems;
//#UC START# *56D93DBD039D_522EDF570036_var*
//#UC END# *56D93DBD039D_522EDF570036_var*
begin
//#UC START# *56D93DBD039D_522EDF570036_impl*
 f_Items.Clear;
//#UC END# *56D93DBD039D_522EDF570036_impl*
end;//TddSimpleListDataAdapter.ClearItems

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

function TddSimpleListDataAdapter.DeleteItem(anIndex: Integer): Boolean;
//#UC START# *522EE0FB0163_522EDF570036_var*
//#UC END# *522EE0FB0163_522EDF570036_var*
begin
//#UC START# *522EE0FB0163_522EDF570036_impl*
 Result := True;
 f_EditItems.Delete(anIndex);
//#UC END# *522EE0FB0163_522EDF570036_impl*
end;//TddSimpleListDataAdapter.DeleteItem

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
  l_Node:= TddAppConfigNode(f_EditItems.Items[anIndex]);
 Result:= ExecuteNodeDialog(l_Node);
 if Result then
 begin
  l_Node.Caption:= l_Node.Items[0].StringValue;
  if anIndex < 0 then
   f_EditItems.Add(l_Node);
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

procedure TddSimpleListDataAdapter.DoBeginEdit;
//#UC START# *57A316CA0116_522EDF570036_var*
var
 l_IDX: Integer;
 l_Item: TddAppConfigNode;
//#UC END# *57A316CA0116_522EDF570036_var*
begin
//#UC START# *57A316CA0116_522EDF570036_impl*
 f_EditItems := Tl3ProtoPersistentRefList.Make;
 for l_IDX := 0 to Count - 1 do
 begin
  l_Item := TddAppConfigNode(Objects[l_IDX]).Clone;
  try
   f_EditItems.Add(l_Item);
  finally
   FreeAndNil(l_Item);
  end;
 end;
//#UC END# *57A316CA0116_522EDF570036_impl*
end;//TddSimpleListDataAdapter.DoBeginEdit

procedure TddSimpleListDataAdapter.DoEndEdit;
//#UC START# *57A316E00019_522EDF570036_var*
//#UC END# *57A316E00019_522EDF570036_var*
begin
//#UC START# *57A316E00019_522EDF570036_impl*
 FreeAndNil(f_EditItems);
//#UC END# *57A316E00019_522EDF570036_impl*
end;//TddSimpleListDataAdapter.DoEndEdit

procedure TddSimpleListDataAdapter.DoPostChanges;
//#UC START# *57A316F503DF_522EDF570036_var*
var
 l_IDX: Integer;
 l_Item: TddAppConfigNode;
//#UC END# *57A316F503DF_522EDF570036_var*
begin
//#UC START# *57A316F503DF_522EDF570036_impl*
 f_Items.Clear;
 for l_IDX := 0 to EditCount - 1 do
 begin
  l_Item := TddAppConfigNode(EditObjects[l_IDX]).Clone;
  try
   f_Items.Add(l_Item);
  finally
   FreeAndNil(l_Item);
  end;
 end;
//#UC END# *57A316F503DF_522EDF570036_impl*
end;//TddSimpleListDataAdapter.DoPostChanges

function TddSimpleListDataAdapter.pm_GetEditCount: Integer;
//#UC START# *57A438DA0057_522EDF570036get_var*
//#UC END# *57A438DA0057_522EDF570036get_var*
begin
//#UC START# *57A438DA0057_522EDF570036get_impl*
 Result := f_EditItems.Count;
//#UC END# *57A438DA0057_522EDF570036get_impl*
end;//TddSimpleListDataAdapter.pm_GetEditCount

function TddSimpleListDataAdapter.pm_GetEditObjects(anIndex: Integer): TObject;
//#UC START# *57A439130358_522EDF570036get_var*
//#UC END# *57A439130358_522EDF570036get_var*
begin
//#UC START# *57A439130358_522EDF570036get_impl*
 Result := f_EditItems[anIndex];
//#UC END# *57A439130358_522EDF570036get_impl*
end;//TddSimpleListDataAdapter.pm_GetEditObjects

function TddSimpleListDataAdapter.pm_GetEditStrings(anIndex: Integer): AnsiString;
//#UC START# *57A4394A01DA_522EDF570036get_var*
//#UC END# *57A4394A01DA_522EDF570036get_var*
begin
//#UC START# *57A4394A01DA_522EDF570036get_impl*
 Result := TddAppConfigNode(f_EditItems.Items[anIndex]).Caption;
//#UC END# *57A4394A01DA_522EDF570036get_impl*
end;//TddSimpleListDataAdapter.pm_GetEditStrings

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

function TddSimpleListDataAdapter.AsObject: TObject;
//#UC START# *522EE0DF0080_522EDF570036_var*
//#UC END# *522EE0DF0080_522EDF570036_var*
begin
//#UC START# *522EE0DF0080_522EDF570036_impl*
 Result := Self;
//#UC END# *522EE0DF0080_522EDF570036_impl*
end;//TddSimpleListDataAdapter.AsObject

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

function TddStringDataAdapter.pm_GetCount: Integer;
//#UC START# *522EDFF601C6_522EDF6702AFget_var*
//#UC END# *522EDFF601C6_522EDF6702AFget_var*
begin
//#UC START# *522EDFF601C6_522EDF6702AFget_impl*
 Result := f_Strings.Count;
//#UC END# *522EDFF601C6_522EDF6702AFget_impl*
end;//TddStringDataAdapter.pm_GetCount

function TddStringDataAdapter.pm_GetObjects(anIndex: Integer): TObject;
//#UC START# *522EE02F00FF_522EDF6702AFget_var*
//#UC END# *522EE02F00FF_522EDF6702AFget_var*
begin
//#UC START# *522EE02F00FF_522EDF6702AFget_impl*
 Result := nil;
//#UC END# *522EE02F00FF_522EDF6702AFget_impl*
end;//TddStringDataAdapter.pm_GetObjects

function TddStringDataAdapter.pm_GetStrings(anIndex: Integer): AnsiString;
//#UC START# *522EE0530101_522EDF6702AFget_var*
//#UC END# *522EE0530101_522EDF6702AFget_var*
begin
//#UC START# *522EE0530101_522EDF6702AFget_impl*
 Result := f_Strings[anIndex];
//#UC END# *522EE0530101_522EDF6702AFget_impl*
end;//TddStringDataAdapter.pm_GetStrings

function TddStringDataAdapter.DeleteItem(anIndex: Integer): Boolean;
//#UC START# *522EE0FB0163_522EDF6702AF_var*
//#UC END# *522EE0FB0163_522EDF6702AF_var*
begin
//#UC START# *522EE0FB0163_522EDF6702AF_impl*
 Result := True;
 f_EditStrings.Delete(anIndex);
//#UC END# *522EE0FB0163_522EDF6702AF_impl*
end;//TddStringDataAdapter.DeleteItem

function TddStringDataAdapter.EditItem(anIndex: Integer): Boolean;
//#UC START# *522EE19901B6_522EDF6702AF_var*
var
 l_S: String;
//#UC END# *522EE19901B6_522EDF6702AF_var*
begin
//#UC START# *522EE19901B6_522EDF6702AF_impl*
 if anIndex > -1 then
  l_S := f_EditStrings[anIndex]
 else
  l_S := '';
 Result := InputQuery('Редактирование элемента', 'Введите текст элемента', l_S);
 if Result then
  if anIndex = -1 then
   f_EditStrings.Add(l_S)
  else
   f_EditStrings.Strings[anIndex] := l_S;
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
 aStorage.WriteInteger(anAlias + 'Count', f_Strings.Count);
 for I := 0 to Pred(f_Strings.Count) do
  aStorage.WriteString(anAlias + IntToStr(I), f_Strings.Strings[I]);
//#UC END# *522EE1D7016D_522EDF6702AF_impl*
end;//TddStringDataAdapter.Save

procedure TddStringDataAdapter.DoBeginEdit;
//#UC START# *57A316CA0116_522EDF6702AF_var*
//#UC END# *57A316CA0116_522EDF6702AF_var*
begin
//#UC START# *57A316CA0116_522EDF6702AF_impl*
 f_EditStrings := TStringList.Create;
 f_EditStrings.Assign(f_Strings);
//#UC END# *57A316CA0116_522EDF6702AF_impl*
end;//TddStringDataAdapter.DoBeginEdit

procedure TddStringDataAdapter.DoEndEdit;
//#UC START# *57A316E00019_522EDF6702AF_var*
//#UC END# *57A316E00019_522EDF6702AF_var*
begin
//#UC START# *57A316E00019_522EDF6702AF_impl*
 FreeAndNil(f_EditStrings);
//#UC END# *57A316E00019_522EDF6702AF_impl*
end;//TddStringDataAdapter.DoEndEdit

procedure TddStringDataAdapter.DoPostChanges;
//#UC START# *57A316F503DF_522EDF6702AF_var*
//#UC END# *57A316F503DF_522EDF6702AF_var*
begin
//#UC START# *57A316F503DF_522EDF6702AF_impl*
 f_Strings.Assign(f_EditStrings);
//#UC END# *57A316F503DF_522EDF6702AF_impl*
end;//TddStringDataAdapter.DoPostChanges

function TddStringDataAdapter.pm_GetEditCount: Integer;
//#UC START# *57A438DA0057_522EDF6702AFget_var*
//#UC END# *57A438DA0057_522EDF6702AFget_var*
begin
//#UC START# *57A438DA0057_522EDF6702AFget_impl*
 Result := f_EditStrings.Count;
//#UC END# *57A438DA0057_522EDF6702AFget_impl*
end;//TddStringDataAdapter.pm_GetEditCount

function TddStringDataAdapter.pm_GetEditObjects(anIndex: Integer): TObject;
//#UC START# *57A439130358_522EDF6702AFget_var*
//#UC END# *57A439130358_522EDF6702AFget_var*
begin
//#UC START# *57A439130358_522EDF6702AFget_impl*
 Result := nil;
//#UC END# *57A439130358_522EDF6702AFget_impl*
end;//TddStringDataAdapter.pm_GetEditObjects

function TddStringDataAdapter.pm_GetEditStrings(anIndex: Integer): AnsiString;
//#UC START# *57A4394A01DA_522EDF6702AFget_var*
//#UC END# *57A4394A01DA_522EDF6702AFget_var*
begin
//#UC START# *57A4394A01DA_522EDF6702AFget_impl*
 Result := f_EditStrings[anIndex];
//#UC END# *57A4394A01DA_522EDF6702AFget_impl*
end;//TddStringDataAdapter.pm_GetEditStrings

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

function TddStringDataAdapter.AsObject: TObject;
//#UC START# *522EE0DF0080_522EDF6702AF_var*
//#UC END# *522EE0DF0080_522EDF6702AF_var*
begin
//#UC START# *522EE0DF0080_522EDF6702AF_impl*
 Result := f_Strings;
//#UC END# *522EE0DF0080_522EDF6702AF_impl*
end;//TddStringDataAdapter.AsObject

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
