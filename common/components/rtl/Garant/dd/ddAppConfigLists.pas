unit ddAppConfigLists;

// Модуль: "w:\common\components\rtl\Garant\dd\ddAppConfigLists.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddAppConfigLists" MUID: (4B9E5DE1008B)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddAppConfigTypes
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , ddAppConfigDataAdapters
 , ddAppConfigConst
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
 , ddConfigStorages
 , ddAppConfigUtils
;

type
 TddListConfigItem = class(TddVisualConfigItem)
  private
   f_AddButton: TButton;
   f_DeleteButton: TButton;
   f_EditButton: TButton;
   f_DownButton: TButton;
   f_UpButton: TButton;
   f_ListBox: TListBox;
   f_DataAdapter: TddBaseConfigDataAdapter;
   f_ShowMoveButtons: Boolean;
  private
   procedure AddButtonCLick(Sender: TObject);
   procedure DeleteButtonClick(Sender: TObject);
   procedure DownButtonClick(Sender: TObject);
   procedure EditButtonClick(Sender: TObject);
   procedure ListDblClick(Sender: TObject);
   procedure UpButtonCLick(Sender: TObject);
  protected
   procedure pm_SetDataAdapter(aValue: TddBaseConfigDataAdapter);
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure pm_SetAlias(const aValue: AnsiString); override;
   function pm_GetBooleanValue: Boolean; override;
   procedure pm_SetBooleanValue(aValue: Boolean); override;
   function pm_GetChanged: Boolean; override;
   procedure pm_SetChanged(aValue: Boolean); override;
   function pm_GetValue: TddConfigValue; override;
   procedure pm_SetValue(const aValue: TddConfigValue); override;
   function pm_GetLabelTop: Boolean; override;
   procedure pm_SetLabelTop(aValue: Boolean); override;
  public
   constructor Make(const aAlias: AnsiString;
    const aCaption: AnsiString;
    aDataAdapter: TddBaseConfigDataAdapter;
    aMasterItem: TddBaseConfigItem = nil); reintroduce;
   function ControlHeight(aParent: TWinControl): Integer; override;
   procedure GetValueFromControl; override;
   procedure SetValueToControl(aDefault: Boolean); override;
   procedure Assign(Source: TPersistent); override;
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); override;
   procedure LoadValue(const aStorage: IddConfigStorage); override;
   procedure SaveValue(const aStorage: IddConfigStorage); override;
  public
   property DataAdapter: TddBaseConfigDataAdapter
    read f_DataAdapter
    write pm_SetDataAdapter;
   property ShowMoveButtons: Boolean
    read f_ShowMoveButtons
    write f_ShowMoveButtons;
 end;//TddListConfigItem

 TddSimpleListConfigItem = {final} class(TddListConfigItem)
  protected
   function pm_GetConfig: TddAppConfigNode;
   function pm_GetTitleCaption: AnsiString;
   procedure pm_SetTitleCaption(const aValue: AnsiString);
  public
   constructor Make(const aAlias: AnsiString;
    const aCaption: AnsiString;
    aMasterItem: TddBaseConfigItem = nil); reintroduce; overload;
   constructor Make(const aAlias: AnsiString;
    const aCaption: AnsiString;
    aItems: TddItemLink;
    aMasterItem: TddBaseConfigItem = nil); reintroduce; overload;
  public
   property Config: TddAppConfigNode
    read pm_GetConfig;
   property TitleCaption: AnsiString
    read pm_GetTitleCaption
    write pm_SetTitleCaption;
 end;//TddSimpleListConfigItem

 TddStringListConfigItem = class(TddListConfigItem)
  public
   constructor Make(const aAlias: AnsiString;
    const aCaption: AnsiString;
    aMasterItem: TddBaseConfigItem = nil); reintroduce;
 end;//TddStringListConfigItem

implementation

uses
 l3ImplUses
 , ddAppConfigListsRes
 , l3Base
 , l3String
 , vtGroupBox
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TddListConfigItem.pm_SetDataAdapter(aValue: TddBaseConfigDataAdapter);
//#UC START# *522F5D3D03D0_4B9E5DF90347set_var*
//#UC END# *522F5D3D03D0_4B9E5DF90347set_var*
begin
//#UC START# *522F5D3D03D0_4B9E5DF90347set_impl*
 if f_DataAdapter <> aValue then
 begin
  l3Set(f_DataAdapter, aValue);
  f_DataAdapter.Alias := Alias;
 end; // f_DataAdapter <> aValue
//#UC END# *522F5D3D03D0_4B9E5DF90347set_impl*
end;//TddListConfigItem.pm_SetDataAdapter

procedure TddListConfigItem.AddButtonCLick(Sender: TObject);
//#UC START# *522F5E79020B_4B9E5DF90347_var*
//#UC END# *522F5E79020B_4B9E5DF90347_var*
begin
//#UC START# *522F5E79020B_4B9E5DF90347_impl*
  if DataAdapter.EditItem(-1) then
  begin
   SetValueToControl(False);
   Changed:= True;
  end;
//#UC END# *522F5E79020B_4B9E5DF90347_impl*
end;//TddListConfigItem.AddButtonCLick

procedure TddListConfigItem.DeleteButtonClick(Sender: TObject);
//#UC START# *522F5EAC02DA_4B9E5DF90347_var*
var
 i: Integer;
//#UC END# *522F5EAC02DA_4B9E5DF90347_var*
begin
//#UC START# *522F5EAC02DA_4B9E5DF90347_impl*
 I:= f_ListBox.ItemIndex;
 if I > -1 then
  if MessageDlg(Format(str_ddcmConfirmDeleteConfigValue.AsStr, [DataAdapter.Strings[i]]),
                mtConfirmation, mbOkCancel, 0) = mrOk then
   if DataAdapter.DeleteItem(I) then
   begin
    SetValueToControl(False);
    Changed:= True;
   end;
//#UC END# *522F5EAC02DA_4B9E5DF90347_impl*
end;//TddListConfigItem.DeleteButtonClick

procedure TddListConfigItem.DownButtonClick(Sender: TObject);
//#UC START# *522F5E9A0363_4B9E5DF90347_var*
var
 I: Integer;
//#UC END# *522F5E9A0363_4B9E5DF90347_var*
begin
//#UC START# *522F5E9A0363_4B9E5DF90347_impl*
 I:= f_ListBox.ItemIndex;
 if I < Pred(f_ListBox.Items.Count) then
  if DataAdapter.DownItem(I) then
  begin
   SetValueToControl(False);
   f_ListBox.ItemIndex:= Succ(I);
   Changed:= True;
  end;
//#UC END# *522F5E9A0363_4B9E5DF90347_impl*
end;//TddListConfigItem.DownButtonClick

procedure TddListConfigItem.EditButtonClick(Sender: TObject);
//#UC START# *522F5EBB00C1_4B9E5DF90347_var*
var
 I: Integer;
//#UC END# *522F5EBB00C1_4B9E5DF90347_var*
begin
//#UC START# *522F5EBB00C1_4B9E5DF90347_impl*
 I:= f_ListBox.ItemIndex;
 if I > -1 then
  if DataAdapter.EditItem(I) then
  begin
   SetValueToControl(False);
   Changed:= True;
  end;
//#UC END# *522F5EBB00C1_4B9E5DF90347_impl*
end;//TddListConfigItem.EditButtonClick

procedure TddListConfigItem.ListDblClick(Sender: TObject);
//#UC START# *522F5E4502F9_4B9E5DF90347_var*
//#UC END# *522F5E4502F9_4B9E5DF90347_var*
begin
//#UC START# *522F5E4502F9_4B9E5DF90347_impl*
 if DataAdapter <> nil then
  EditButtonClick(Self);
//#UC END# *522F5E4502F9_4B9E5DF90347_impl*
end;//TddListConfigItem.ListDblClick

procedure TddListConfigItem.UpButtonCLick(Sender: TObject);
//#UC START# *522F5E8C0163_4B9E5DF90347_var*
var
 I: Integer;
//#UC END# *522F5E8C0163_4B9E5DF90347_var*
begin
//#UC START# *522F5E8C0163_4B9E5DF90347_impl*
 I:= f_ListBox.ItemIndex;
 if I > 0 then
  if DataAdapter.UpItem(I) then
  begin
   SetValueToControl(False);
   f_ListBox.ItemIndex:= Pred(I);
   Changed:= True;
  end;
//#UC END# *522F5E8C0163_4B9E5DF90347_impl*
end;//TddListConfigItem.UpButtonCLick

constructor TddListConfigItem.Make(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aDataAdapter: TddBaseConfigDataAdapter;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *522F60FA01BA_4B9E5DF90347_var*
//#UC END# *522F60FA01BA_4B9E5DF90347_var*
begin
//#UC START# *522F60FA01BA_4B9E5DF90347_impl*
 Create(aAlias, aCaption, ddEmptyValue, aMasterItem);
 DataAdapter:= aDataAdapter;
 f_Value.Kind:= dd_vkObject;
 f_Value.AsObject:= DataAdapter.AsObject;
//#UC END# *522F60FA01BA_4B9E5DF90347_impl*
end;//TddListConfigItem.Make

function TddListConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_4B9E5DF90347_var*
var
 l_Top, l_Left: Integer;
 l_ButtonWidth: Integer;
//#UC END# *521761BB03DE_4B9E5DF90347_var*
begin
//#UC START# *521761BB03DE_4B9E5DF90347_impl*
 { Группа элементов }
 Result:= TvtGroupBox.Create(aParent);
 with Result do
 begin
  Parent:= aParent as TWinControl;
  Left:= aLeft;                                
  Top:= aTop;
  Width:= aParent.ClientWidth - aLeft - c_ConfigItemRight;
  Height:= ControlHeight(aParent);
 end;
 TvtGroupBox(Result).Caption:= Caption;
 { Список }
 l_ButtonWidth:= GetCanvas(aParent).TextWidth(str_ddcmChangeConfigValue.AsStr) + c_ConfigItemLeft + c_ConfigItemRight;
 f_ListBox:= TListBox.Create(Result);
 f_ListBox.Parent:= Result as TWinControl;
 l_Top:= LabelHeight(aParent) + c_ConfigItemTop;
 f_ListBox.Top:= l_Top;
 f_ListBox.Height:= 25*3 + 5*c_ConfigItemTop; { Три кнопки, два двойных промежутка }
 {$IFNDEF Nemesis}
 if ShowMoveButtons then
  f_ListBox.Height:= f_ListBox.Height + 25*2 + 3*c_ConfigItemTop;
 {$ENDIF}
 f_ListBox.Left:= c_ConfigItemLeft;
 f_ListBox.Width:= Result.ClientWidth - 3*c_ConfigItemLeft - l_ButtonWidth;
 f_ListBox.OnDblClick:= ListDblClick;
 { Кнопки }
 l_Left:= Result.ClientWidth - (l_ButtonWidth + c_ConfigItemLeft);
 f_AddButton:= Tbutton.Create(Result);
 f_AddButton.Width:= l_ButtonWidth;
 f_AddButton.Parent:= Result as TWinControl;
 f_AddButton.Top:= l_Top;
 f_AddButton.Left:= l_Left;
 with (f_AddButton as TButton) do
 begin
  Caption:= str_ddcmAddConfigValue.AsStr;
  Enabled:= Assigned(DataAdapter);
  OnClick:= AddButtonClick;
 end;
 Inc(l_Top, f_AddButton.Height+2*c_ConfigItemTop);
 f_EditButton:= Tbutton.Create(Result);
 f_EditButton.Width:= l_ButtonWidth;
 f_EditButton.Parent:= Result as TWinControl;
 f_EditButton.Top:= l_Top;
 f_EditButton.Left:= l_Left;
 with (f_EditButton as TButton) do
 begin
  Caption:= str_ddcmChangeConfigValue.AsStr;
  Enabled:= Assigned(DataAdapter);
  OnClick:= EditButtonClick;
 end;
 Inc(l_Top, f_EditButton.Height+2*c_ConfigItemTop);
 f_DeleteButton:= Tbutton.Create(Result);
 f_DeleteButton.Width:= l_ButtonWidth;
 f_DeleteButton.Parent:= Result as TWinControl;
 f_DeleteButton.Top:= l_Top;
 f_DeleteButton.Left:= l_Left;
 with (f_DeleteButton as TButton) do
 begin
  Caption:= str_ddcmDeleteConfigValue.AsStr;
  Enabled:= Assigned(DataAdapter);
  OnClick:= DeleteButtonClick;
 end;
 {$IFNDEF Nemesis}
 // перемещение элементов
 if ShowMoveButtons then
 begin
  Inc(l_Top, f_DeleteButton.Height+2*c_ConfigItemTop);
  f_UpButton:= Tbutton.Create(Result);
  f_UpButton.Width:= l_ButtonWidth;
  f_UpButton.Parent:= Result as TWinControl;
  f_UpButton.Top:= l_Top;
  f_UpButton.Left:= l_Left;
  with (f_UpButton as TButton) do
  begin
   Caption:= 'Вверх';
   Enabled:= Assigned(DataAdapter);
   OnClick:= UpButtonClick;
  end; // with (f_UpButton
  Inc(l_Top, f_UpButton.Height+2*c_ConfigItemTop);
  f_DownButton:= Tbutton.Create(Result);
  f_DownButton.Width:= l_ButtonWidth;
  f_DownButton.Parent:= Result as TWinControl;
  f_DownButton.Top:= l_Top;
  f_DownButton.Left:= l_Left;
  with (f_DownButton as TButton) do
  begin
   Caption:= 'Вниз';
   Enabled:= Assigned(DataAdapter);
   OnClick:= DownButtonClick;
  end; 
 end; // ShowMoveButtons
 {$ENDIF}
//#UC END# *521761BB03DE_4B9E5DF90347_impl*
end;//TddListConfigItem.ConstructControl

function TddListConfigItem.ControlHeight(aParent: TWinControl): Integer;
//#UC START# *521B053F03C3_4B9E5DF90347_var*
//#UC END# *521B053F03C3_4B9E5DF90347_var*
begin
//#UC START# *521B053F03C3_4B9E5DF90347_impl*
 Result:= 25 * 3 + {Три кнопки }
          4 * c_ConfigItemTop + {Промежутки между кнопками}
          LabelHeight(aParent) +
          4 * c_ConfigItemTop;
 {$IFNDEF Nemesis}
 if ShowMoveButtons then
  Inc(Result, 25 * 2 + 4 * c_ConfigItemTop);
 {$ENDIF}
//#UC END# *521B053F03C3_4B9E5DF90347_impl*
end;//TddListConfigItem.ControlHeight

procedure TddListConfigItem.GetValueFromControl;
//#UC START# *521B058801FD_4B9E5DF90347_var*
//#UC END# *521B058801FD_4B9E5DF90347_var*
begin
//#UC START# *521B058801FD_4B9E5DF90347_impl*
//#UC END# *521B058801FD_4B9E5DF90347_impl*
end;//TddListConfigItem.GetValueFromControl

procedure TddListConfigItem.SetValueToControl(aDefault: Boolean);
//#UC START# *521B07030052_4B9E5DF90347_var*
var
 i: Integer;
//#UC END# *521B07030052_4B9E5DF90347_var*
begin
//#UC START# *521B07030052_4B9E5DF90347_impl*
 // заполняем список строками
 if DataAdapter <> nil then
 begin
  f_ListBox.Items.Clear;
  for i:= 0 to Pred(DataAdapter.Count) do
   f_ListBox.Items.Add(DataAdapter.Strings[i]);
  f_EditButton.Enabled:= DataAdapter.Count > 0;
  f_DeleteButton.Enabled:= DataAdapter.Count > 0;
 end; // Assigned(aItem.DataAdapter)
//#UC END# *521B07030052_4B9E5DF90347_impl*
end;//TddListConfigItem.SetValueToControl

procedure TddListConfigItem.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_4B9E5DF90347_var*
//#UC END# *478CF34E02CE_4B9E5DF90347_var*
begin
//#UC START# *478CF34E02CE_4B9E5DF90347_impl*
 inherited;
 if Source is TddListConfigItem then
 begin
  FreeAndNil(f_DataAdapter);
  f_DataAdapter := TddListConfigItem(Source).DataAdapter.Clone;
 end
//#UC END# *478CF34E02CE_4B9E5DF90347_impl*
end;//TddListConfigItem.Assign

procedure TddListConfigItem.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4B9E5DF90347_var*
//#UC END# *479731C50290_4B9E5DF90347_var*
begin
//#UC START# *479731C50290_4B9E5DF90347_impl*
 l3Free(f_DataAdapter);
 inherited;
//#UC END# *479731C50290_4B9E5DF90347_impl*
end;//TddListConfigItem.Cleanup

procedure TddListConfigItem.pm_SetAlias(const aValue: AnsiString);
//#UC START# *52171FCA00C1_4B9E5DF90347set_var*
//#UC END# *52171FCA00C1_4B9E5DF90347set_var*
begin
//#UC START# *52171FCA00C1_4B9E5DF90347set_impl*
 inherited;
 if DataAdapter <> nil then
  DataAdapter.Alias := aValue;
//#UC END# *52171FCA00C1_4B9E5DF90347set_impl*
end;//TddListConfigItem.pm_SetAlias

function TddListConfigItem.pm_GetBooleanValue: Boolean;
//#UC START# *52171FDF0382_4B9E5DF90347get_var*
//#UC END# *52171FDF0382_4B9E5DF90347get_var*
begin
//#UC START# *52171FDF0382_4B9E5DF90347get_impl*
 if Control <> nil then
  Result:= (Control as TCheckBox).Checked
 else
  Result:= inherited pm_GetBooleanValue;
//#UC END# *52171FDF0382_4B9E5DF90347get_impl*
end;//TddListConfigItem.pm_GetBooleanValue

procedure TddListConfigItem.pm_SetBooleanValue(aValue: Boolean);
//#UC START# *52171FDF0382_4B9E5DF90347set_var*
//#UC END# *52171FDF0382_4B9E5DF90347set_var*
begin
//#UC START# *52171FDF0382_4B9E5DF90347set_impl*
 inherited;
//#UC END# *52171FDF0382_4B9E5DF90347set_impl*
end;//TddListConfigItem.pm_SetBooleanValue

function TddListConfigItem.pm_GetChanged: Boolean;
//#UC START# *5217205002F2_4B9E5DF90347get_var*
//#UC END# *5217205002F2_4B9E5DF90347get_var*
begin
//#UC START# *5217205002F2_4B9E5DF90347get_impl*
 Result := inherited pm_GetChanged;
//#UC END# *5217205002F2_4B9E5DF90347get_impl*
end;//TddListConfigItem.pm_GetChanged

procedure TddListConfigItem.pm_SetChanged(aValue: Boolean);
//#UC START# *5217205002F2_4B9E5DF90347set_var*
//#UC END# *5217205002F2_4B9E5DF90347set_var*
begin
//#UC START# *5217205002F2_4B9E5DF90347set_impl*
 inherited;
 if DataAdapter <> nil then
  DataAdapter.IsChanged:= aValue;
//#UC END# *5217205002F2_4B9E5DF90347set_impl*
end;//TddListConfigItem.pm_SetChanged

function TddListConfigItem.pm_GetValue: TddConfigValue;
//#UC START# *521725130281_4B9E5DF90347get_var*
//#UC END# *521725130281_4B9E5DF90347get_var*
begin
//#UC START# *521725130281_4B9E5DF90347get_impl*
 Result := ddEmptyObjectValue;
 Result.AsObject := DataAdapter;
//#UC END# *521725130281_4B9E5DF90347get_impl*
end;//TddListConfigItem.pm_GetValue

procedure TddListConfigItem.pm_SetValue(const aValue: TddConfigValue);
//#UC START# *521725130281_4B9E5DF90347set_var*
//#UC END# *521725130281_4B9E5DF90347set_var*
begin
//#UC START# *521725130281_4B9E5DF90347set_impl*
 if aValue.Kind <> dd_vkObject then
  raise EddInvalidValue.Create('');
 DataAdapter := aValue.AsObject as TddBaseConfigDataAdapter;
 Changed := True;
//#UC END# *521725130281_4B9E5DF90347set_impl*
end;//TddListConfigItem.pm_SetValue

constructor TddListConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_4B9E5DF90347_var*
//#UC END# *5217273F000F_4B9E5DF90347_var*
begin
//#UC START# *5217273F000F_4B9E5DF90347_impl*
 inherited Create(aAlias, aCaption, aDefaultValue, aMasterItem);
 Labeled:= False;
 f_ShowMoveButtons:= False;
//#UC END# *5217273F000F_4B9E5DF90347_impl*
end;//TddListConfigItem.Create

procedure TddListConfigItem.LoadValue(const aStorage: IddConfigStorage);
//#UC START# *52172B72014C_4B9E5DF90347_var*
//#UC END# *52172B72014C_4B9E5DF90347_var*
begin
//#UC START# *52172B72014C_4B9E5DF90347_impl*
 if DataAdapter <> nil then
  DataAdapter.Load(aStorage, Alias);
//#UC END# *52172B72014C_4B9E5DF90347_impl*
end;//TddListConfigItem.LoadValue

procedure TddListConfigItem.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_4B9E5DF90347_var*
//#UC END# *52172CA801E3_4B9E5DF90347_var*
begin
//#UC START# *52172CA801E3_4B9E5DF90347_impl*
 if DataAdapter <> nil then
  DataAdapter.Save(aStorage, Alias);
//#UC END# *52172CA801E3_4B9E5DF90347_impl*
end;//TddListConfigItem.SaveValue

function TddListConfigItem.pm_GetLabelTop: Boolean;
//#UC START# *5217602C020A_4B9E5DF90347get_var*
//#UC END# *5217602C020A_4B9E5DF90347get_var*
begin
//#UC START# *5217602C020A_4B9E5DF90347get_impl*
 Result := inherited pm_GetLabelTop;
//#UC END# *5217602C020A_4B9E5DF90347get_impl*
end;//TddListConfigItem.pm_GetLabelTop

procedure TddListConfigItem.pm_SetLabelTop(aValue: Boolean);
//#UC START# *5217602C020A_4B9E5DF90347set_var*
//#UC END# *5217602C020A_4B9E5DF90347set_var*
begin
//#UC START# *5217602C020A_4B9E5DF90347set_impl*
 inherited pm_SetLabelTop(True);
//#UC END# *5217602C020A_4B9E5DF90347set_impl*
end;//TddListConfigItem.pm_SetLabelTop

function TddSimpleListConfigItem.pm_GetConfig: TddAppConfigNode;
//#UC START# *522F62CB01EC_522F629801CAget_var*
//#UC END# *522F62CB01EC_522F629801CAget_var*
begin
//#UC START# *522F62CB01EC_522F629801CAget_impl*
 Result := (DataAdapter as TddSimpleListDataAdapter).DataConfig;
//#UC END# *522F62CB01EC_522F629801CAget_impl*
end;//TddSimpleListConfigItem.pm_GetConfig

function TddSimpleListConfigItem.pm_GetTitleCaption: AnsiString;
//#UC START# *522F62FC023F_522F629801CAget_var*
//#UC END# *522F62FC023F_522F629801CAget_var*
begin
//#UC START# *522F62FC023F_522F629801CAget_impl*
 Result := (DataAdapter as TddSimpleListDataAdapter).DataConfig.Items[0].Caption;
//#UC END# *522F62FC023F_522F629801CAget_impl*
end;//TddSimpleListConfigItem.pm_GetTitleCaption

procedure TddSimpleListConfigItem.pm_SetTitleCaption(const aValue: AnsiString);
//#UC START# *522F62FC023F_522F629801CAset_var*
//#UC END# *522F62FC023F_522F629801CAset_var*
begin
//#UC START# *522F62FC023F_522F629801CAset_impl*
 if TitleCaption <> aValue then
  (DataAdapter as TddSimpleListDataAdapter).DataConfig.Items[0].Caption := aValue;
//#UC END# *522F62FC023F_522F629801CAset_impl*
end;//TddSimpleListConfigItem.pm_SetTitleCaption

constructor TddSimpleListConfigItem.Make(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *522F631301D6_522F629801CA_var*
var
 l_DA: TddSimpleListDataAdapter;
//#UC END# *522F631301D6_522F629801CA_var*
begin
//#UC START# *522F631301D6_522F629801CA_impl*
 l_DA:= TddSimpleListDataAdapter.Make(aAlias);
 try
  inherited Make(aAlias, aCaption, l_DA, aMasterItem);
 finally
  l3Free(l_DA);
 end;
//#UC END# *522F631301D6_522F629801CA_impl*
end;//TddSimpleListConfigItem.Make

constructor TddSimpleListConfigItem.Make(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aItems: TddItemLink;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *522F634D02E1_522F629801CA_var*
var
 l_DA: TddSimpleListDataAdapter;
//#UC END# *522F634D02E1_522F629801CA_var*
begin
//#UC START# *522F634D02E1_522F629801CA_impl*
 l_DA:= TddSimpleListDataAdapter.Make(aAlias);
 try
  l_DA.DataConfig:= MakeNode('Adapter', 'Новый элемент', False, aItems);
  inherited Make(aAlias, aCaption, l_DA, aMasterItem);
 finally
  l3Free(l_DA);
 end;
//#UC END# *522F634D02E1_522F629801CA_impl*
end;//TddSimpleListConfigItem.Make

constructor TddStringListConfigItem.Make(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *522F638F01DD_522F636B02B5_var*
var
 l_A: TddBaseConfigDataAdapter;
//#UC END# *522F638F01DD_522F636B02B5_var*
begin
//#UC START# *522F638F01DD_522F636B02B5_impl*
 l_A:= TddStringDataAdapter.Create;
 try
  inherited Make(aAlias, aCaption, l_A, aMasterItem);
 finally
  l3Free(l_A);
 end
//#UC END# *522F638F01DD_522F636B02B5_impl*
end;//TddStringListConfigItem.Make

end.
