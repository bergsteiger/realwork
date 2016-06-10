unit ddAppConfigStrings;

// Модуль: "w:\common\components\rtl\Garant\dd\ddAppConfigStrings.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddAppConfigStrings" MUID: (4B9E62980158)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddAppConfigTypes
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
 , ddAppConfigConst
 , ddConfigStorages
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TddStringConfigItem = class(TddVisualConfigItem)
  private
   f_PasswordChar: AnsiChar;
  private
   procedure DoOnChange(Sender: TObject);
  protected
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
   procedure AdjustReadOnly(aControl: TControl); override;
  public
   constructor Make(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefault: AnsiString = '';
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
   function MinWidth(aParent: TWinControl): Integer; override;
  public
   property PasswordChar: AnsiChar
    read f_PasswordChar
    write f_PasswordChar;
 end;//TddStringConfigItem

 TddFillType = (
  dd_ftAsIs
  , dd_ftFull
  , dd_ftShort
 );//TddFillType

 TddBrowseConfigItem = class(TddStringConfigItem)
  private
   f_BrowseButton: TButton;
   f_TestButton: TButton;
   f_AllowTest: Boolean;
   f_TestButtonCaption: AnsiString;
   f_PathFill: TddFillType;
  protected
   function MakeFullPath(const aValue: AnsiString): AnsiString; virtual;
   function MakeShortPath(const aValue: AnsiString): AnsiString; virtual;
   procedure OnBrowseClick(Sender: TObject); virtual; abstract;
   procedure OnTestClick(Sender: TObject); virtual; abstract;
   function CorrectValue(const aValue: AnsiString): AnsiString;
   function pm_GetEnabled: Boolean; override;
   procedure pm_SetEnabled(aValue: Boolean); override;
   function pm_GetStringValue: AnsiString; override;
   procedure pm_SetStringValue(const aValue: AnsiString); override;
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
   procedure AdjustReadOnly(aControl: TControl); override;
   procedure ClearFields; override;
  public
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); override;
   function MinWidth(aParent: TWinControl): Integer; override;
  public
   property AllowTest: Boolean
    read f_AllowTest
    write f_AllowTest;
   property TestButtonCaption: AnsiString
    read f_TestButtonCaption
    write f_TestButtonCaption;
   property PathFill: TddFillType
    read f_PathFill
    write f_PathFill;
 end;//TddBrowseConfigItem

 TddFolderNameConfigItem = class(TddBrowseConfigItem)
  private
   f_AllowProcessDir: Boolean;
  private
   procedure Validate;
  protected
   procedure OnBrowseClick(Sender: TObject); override;
   procedure OnTestClick(Sender: TObject); override;
  public
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); override;
   procedure GetValueFromControl; override;
  public
   property AllowProcessDir: Boolean
    read f_AllowProcessDir
    write f_AllowProcessDir;
 end;//TddFolderNameConfigItem

 TddFileNameConfigItem = class(TddBrowseConfigItem)
  private
   f_FilterMask: AnsiString;
  protected
   procedure OnBrowseClick(Sender: TObject); override;
   procedure OnTestClick(Sender: TObject); override;
   procedure ClearFields; override;
  public
   property FilterMask: AnsiString
    read f_FilterMask
    write f_FilterMask;
 end;//TddFileNameConfigItem

 TddSoundFileNameConfigItem = class(TddFileNameConfigItem)
  protected
   procedure OnTestClick(Sender: TObject); override;
  public
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); override;
 end;//TddSoundFileNameConfigItem

 TddTextConfigItem = class(TddVisualConfigItem)
  protected
   procedure DoOnChange(Sender: TObject);
   function ConstructControl(var aLeft: Integer;
    var aMaxLeft: Integer;
    var aTop: Integer;
    aParent: TWinControl): TControl; override;
   procedure AdjustReadOnly(aControl: TControl); override;
  public
   constructor Make(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefault: AnsiString = '';
    aMasterItem: TddBaseConfigItem = nil); reintroduce;
   function ControlHeight(aParent: TWinControl): Integer; override;
   procedure GetValueFromControl; override;
   procedure SetValueToControl(aDefault: Boolean); override;
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); override;
   procedure LoadValue(const aStorage: IddConfigStorage); override;
   procedure SaveValue(const aStorage: IddConfigStorage); override;
   function MinWidth(aParent: TWinControl): Integer; override;
 end;//TddTextConfigItem

implementation

uses
 l3ImplUses
 , ddAppConfigStringsRes
 , l3Base
 , l3String
 , SysUtils
 , StrUtils
 , l3Base64
 , l3FileUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , FileCtrl
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , MMSystem
 , l3Utils
;

const
 PasswordPrefix = 'Base64:';

function MaskCRLF(const aString: AnsiString): AnsiString;
//#UC START# *523039D00197_4B9E62980158_var*
//#UC END# *523039D00197_4B9E62980158_var*
begin
//#UC START# *523039D00197_4B9E62980158_impl*
 Result := StringReplace(aString, #13#10, '<13><10>', [rfReplaceAll]);
//#UC END# *523039D00197_4B9E62980158_impl*
end;//MaskCRLF

function UnMaskCRLF(const aString: AnsiString): AnsiString;
//#UC START# *523039F8035E_4B9E62980158_var*
//#UC END# *523039F8035E_4B9E62980158_var*
begin
//#UC START# *523039F8035E_4B9E62980158_impl*
 Result := StringReplace(aString, '<13><10>', #13#10, [rfReplaceAll]);
//#UC END# *523039F8035E_4B9E62980158_impl*
end;//UnMaskCRLF

procedure TddStringConfigItem.DoOnChange(Sender: TObject);
//#UC START# *523037EC01EB_4B9E62B50054_var*
//#UC END# *523037EC01EB_4B9E62B50054_var*
begin
//#UC START# *523037EC01EB_4B9E62B50054_impl*
 Changed := True;
//#UC END# *523037EC01EB_4B9E62B50054_impl*
end;//TddStringConfigItem.DoOnChange

constructor TddStringConfigItem.Make(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefault: AnsiString = '';
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5230388E009E_4B9E62B50054_var*
var
 l_Default: TddConfigValue;
//#UC END# *5230388E009E_4B9E62B50054_var*
begin
//#UC START# *5230388E009E_4B9E62B50054_impl*
 l3FillChar(l_Default, SizeOf(l_Default), 0);
 l_Default.Kind := dd_vkString;
 l_Default.AsString := aDefault;
 Create(aAlias, aCaption, l_Default, aMasterItem);
//#UC END# *5230388E009E_4B9E62B50054_impl*
end;//TddStringConfigItem.Make

function TddStringConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_4B9E62B50054_var*
//#UC END# *521761BB03DE_4B9E62B50054_var*
begin
//#UC START# *521761BB03DE_4B9E62B50054_impl*
 Result := TEdit.Create(aParent);
 Result.Parent := aParent;
 Result.Top := aTop;
 Result.Left := aLeft;
 Result.Width := aParent.ClientWidth - aLeft - c_ConfigItemRight;
 TEdit(Result).PasswordChar := Char(PasswordChar);
 TEdit(Result).OnChange := DoOnChange;
//#UC END# *521761BB03DE_4B9E62B50054_impl*
end;//TddStringConfigItem.ConstructControl

function TddStringConfigItem.ControlHeight(aParent: TWinControl): Integer;
//#UC START# *521B053F03C3_4B9E62B50054_var*
var
 l_Edit: TEdit;
//#UC END# *521B053F03C3_4B9E62B50054_var*
begin
//#UC START# *521B053F03C3_4B9E62B50054_impl*
 l_Edit := TEdit.Create(aParent);
 try
  l_Edit.Parent := aParent;
  Result := l_Edit.Height;
 finally
  l_Edit.Free;
 end;
//#UC END# *521B053F03C3_4B9E62B50054_impl*
end;//TddStringConfigItem.ControlHeight

procedure TddStringConfigItem.GetValueFromControl;
//#UC START# *521B058801FD_4B9E62B50054_var*
//#UC END# *521B058801FD_4B9E62B50054_var*
begin
//#UC START# *521B058801FD_4B9E62B50054_impl*
 StringValue := (Control as TEdit).Text;
//#UC END# *521B058801FD_4B9E62B50054_impl*
end;//TddStringConfigItem.GetValueFromControl

procedure TddStringConfigItem.SetValueToControl(aDefault: Boolean);
//#UC START# *521B07030052_4B9E62B50054_var*
//#UC END# *521B07030052_4B9E62B50054_var*
begin
//#UC START# *521B07030052_4B9E62B50054_impl*
 if aDefault then
  (Control as TEdit).Text := DefaultValue.AsString
 else
  (Control as TEdit).Text := StringValue;
//#UC END# *521B07030052_4B9E62B50054_impl*
end;//TddStringConfigItem.SetValueToControl

procedure TddStringConfigItem.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_4B9E62B50054_var*
//#UC END# *478CF34E02CE_4B9E62B50054_var*
begin
//#UC START# *478CF34E02CE_4B9E62B50054_impl*
 inherited;
 if Source is TddStringConfigItem then
  PasswordChar := TddStringConfigItem(Source).PasswordChar;
//#UC END# *478CF34E02CE_4B9E62B50054_impl*
end;//TddStringConfigItem.Assign

constructor TddStringConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_4B9E62B50054_var*
//#UC END# *5217273F000F_4B9E62B50054_var*
begin
//#UC START# *5217273F000F_4B9E62B50054_impl*
 inherited Create(aAlias, aCaption, aDefaultValue, aMasterItem);
 f_Value.Kind := dd_vkString;
//#UC END# *5217273F000F_4B9E62B50054_impl*
end;//TddStringConfigItem.Create

procedure TddStringConfigItem.LoadValue(const aStorage: IddConfigStorage);
//#UC START# *52172B72014C_4B9E62B50054_var*
var
 l_S: String;
//#UC END# *52172B72014C_4B9E62B50054_var*
begin
//#UC START# *52172B72014C_4B9E62B50054_impl*
 StringValue := l3Str(aStorage.ReadString(Alias, DefaultValue.AsString));
 if PasswordChar <> '' then
 begin
  if AnsiStartsStr(PasswordPrefix, StringValue) then
   StringValue := l3Decrypt(l3DecodeBase64(Copy(StringValue, Length(PasswordPrefix)+1, Length(StringValue)-Length(PasswordPrefix))))
  else
   StringValue := l3Decrypt(StringValue);
 end;
//#UC END# *52172B72014C_4B9E62B50054_impl*
end;//TddStringConfigItem.LoadValue

procedure TddStringConfigItem.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_4B9E62B50054_var*
//#UC END# *52172CA801E3_4B9E62B50054_var*
begin
//#UC START# *52172CA801E3_4B9E62B50054_impl*
 if PasswordChar <> '' then
  aStorage.WriteString(Alias, PasswordPrefix + l3EncodeBase64(l3Encrypt(Value.AsString)))
 else
  aStorage.WriteString(Alias, Value.AsString);
//#UC END# *52172CA801E3_4B9E62B50054_impl*
end;//TddStringConfigItem.SaveValue

function TddStringConfigItem.MinWidth(aParent: TWinControl): Integer;
//#UC START# *521B061A0387_4B9E62B50054_var*
//#UC END# *521B061A0387_4B9E62B50054_var*
begin
//#UC START# *521B061A0387_4B9E62B50054_impl*
 Result := 250;
//#UC END# *521B061A0387_4B9E62B50054_impl*
end;//TddStringConfigItem.MinWidth

procedure TddStringConfigItem.AdjustReadOnly(aControl: TControl);
//#UC START# *552BB745031E_4B9E62B50054_var*
//#UC END# *552BB745031E_4B9E62B50054_var*
begin
//#UC START# *552BB745031E_4B9E62B50054_impl*
 if aControl is TEdit then
  TEdit(aControl).ReadOnly := ReadOnly;
//#UC END# *552BB745031E_4B9E62B50054_impl*
end;//TddStringConfigItem.AdjustReadOnly

function TddBrowseConfigItem.MakeFullPath(const aValue: AnsiString): AnsiString;
//#UC START# *52303E6A0263_523038C603B2_var*
//#UC END# *52303E6A0263_523038C603B2_var*
begin
//#UC START# *52303E6A0263_523038C603B2_impl*
 // Дополнить путь путем к приложению
 if l3IsRelativePath(aValue) then
  Result := ConcatDirName(ExtractFilePath(Application.ExeName), aValue)
 else
  Result := aValue;
//#UC END# *52303E6A0263_523038C603B2_impl*
end;//TddBrowseConfigItem.MakeFullPath

function TddBrowseConfigItem.MakeShortPath(const aValue: AnsiString): AnsiString;
//#UC START# *52303E8E0116_523038C603B2_var*
//#UC END# *52303E8E0116_523038C603B2_var*
begin
//#UC START# *52303E8E0116_523038C603B2_impl*
 // Выдернуть короткий путь
 Result := ExtractRelativePath(ExtractFilePath(Application.ExeName), aValue);
//#UC END# *52303E8E0116_523038C603B2_impl*
end;//TddBrowseConfigItem.MakeShortPath

function TddBrowseConfigItem.CorrectValue(const aValue: AnsiString): AnsiString;
//#UC START# *52303F550316_523038C603B2_var*
//#UC END# *52303F550316_523038C603B2_var*
begin
//#UC START# *52303F550316_523038C603B2_impl*
 case PathFill of
  dd_ftFull: Result := MakeFullPath(aValue);
  dd_ftShort: Result := MakeShortPath(aValue);
 else
  Result := aValue;
 end;
//#UC END# *52303F550316_523038C603B2_impl*
end;//TddBrowseConfigItem.CorrectValue

function TddBrowseConfigItem.pm_GetEnabled: Boolean;
//#UC START# *521722C103B5_523038C603B2get_var*
//#UC END# *521722C103B5_523038C603B2get_var*
begin
//#UC START# *521722C103B5_523038C603B2get_impl*
 Result := inherited pm_GetEnabled;
//#UC END# *521722C103B5_523038C603B2get_impl*
end;//TddBrowseConfigItem.pm_GetEnabled

procedure TddBrowseConfigItem.pm_SetEnabled(aValue: Boolean);
//#UC START# *521722C103B5_523038C603B2set_var*
//#UC END# *521722C103B5_523038C603B2set_var*
begin
//#UC START# *521722C103B5_523038C603B2set_impl*
 inherited pm_SetEnabled(aValue);
 if Control <> nil then
 begin
  if AllowTest then
   f_TestButton.Enabled := Enabled;
  f_BrowseButton.Enabled := Enabled;
 end; // Control <> nil
//#UC END# *521722C103B5_523038C603B2set_impl*
end;//TddBrowseConfigItem.pm_SetEnabled

function TddBrowseConfigItem.pm_GetStringValue: AnsiString;
//#UC START# *521724F702D9_523038C603B2get_var*
//#UC END# *521724F702D9_523038C603B2get_var*
begin
//#UC START# *521724F702D9_523038C603B2get_impl*
 Result := CorrectValue(f_Value.AsString);
//#UC END# *521724F702D9_523038C603B2get_impl*
end;//TddBrowseConfigItem.pm_GetStringValue

procedure TddBrowseConfigItem.pm_SetStringValue(const aValue: AnsiString);
//#UC START# *521724F702D9_523038C603B2set_var*
//#UC END# *521724F702D9_523038C603B2set_var*
begin
//#UC START# *521724F702D9_523038C603B2set_impl*
 inherited;
//#UC END# *521724F702D9_523038C603B2set_impl*
end;//TddBrowseConfigItem.pm_SetStringValue

constructor TddBrowseConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_523038C603B2_var*
//#UC END# *5217273F000F_523038C603B2_var*
begin
//#UC START# *5217273F000F_523038C603B2_impl*
 inherited Create(aAlias, aCaption, aDefaultValue, aMasterItem);
 TestButtonCaption := str_ddcmCheckButton.AsStr;
 AllowTest := False;
 f_PathFill := dd_ftAsIs;
//#UC END# *5217273F000F_523038C603B2_impl*
end;//TddBrowseConfigItem.Create

function TddBrowseConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_523038C603B2_var*
var
 l_Delta: Integer;
//#UC END# *521761BB03DE_523038C603B2_var*
begin
//#UC START# *521761BB03DE_523038C603B2_impl*
 if AllowTest then
  l_Delta := 3 * c_ConfigItemLeft + GetCanvas(aParent).TextWidth(TestButtonCaption)
 else
  l_Delta := 0;
 // Строка ввода
 Result := TEdit.Create(aParent);
 Result.Parent := aParent;
 Result.Top := aTop;
 Result.Left := aLeft;
 Result.Width := aParent.ClientWidth - aLeft - 2*c_ConfigItemLeft-Result.Height{это ширина Browse} - l_Delta;
 TEdit(Result).OnChange := DoOnChange;
 // кнопка "просмотр"
 f_BrowseButton := TButton.Create(aParent);
 f_BrowseButton.Parent := aParent;
 f_BrowseButton.Left := Result.Left+Result.Width+c_ConfigItemLeft;
 f_BrowseButton.Top := aTop;
 f_BrowseButton.Width := Result.Height;
 f_BrowseButton.Height := Result.Height;
 f_BrowseButton.Caption := '...';
 f_BrowseButton.OnClick := OnBrowseClick;
 // кнопка "тест"
 if AllowTest then
 begin
  f_TestButton := TButton.Create(aParent);
  f_TestButton.Parent := aParent;
  f_TestButton.Left := f_BrowseButton.Left+f_BrowseButton.Width+c_ConfigItemLeft;
  f_TestButton.Top := aTop;
  f_TestButton.Width := l_Delta-c_ConfigItemLeft;
  f_TestButton.Height := Result.Height;
  f_TestButton.Caption := TestButtonCaption;
  f_TestButton.OnClick := OnTestClick;
 end; // AllowTest
//#UC END# *521761BB03DE_523038C603B2_impl*
end;//TddBrowseConfigItem.ConstructControl

function TddBrowseConfigItem.MinWidth(aParent: TWinControl): Integer;
//#UC START# *521B061A0387_523038C603B2_var*
//#UC END# *521B061A0387_523038C603B2_var*
begin
//#UC START# *521B061A0387_523038C603B2_impl*
 Result := inherited MinWidth(aParent){Строка ввода} + c_ConfigItemLeft + 25{кнопка Browse};
 if AllowTest then
  Inc(Result, 2 * c_ConfigItemLeft + 75);
//#UC END# *521B061A0387_523038C603B2_impl*
end;//TddBrowseConfigItem.MinWidth

procedure TddBrowseConfigItem.AdjustReadOnly(aControl: TControl);
//#UC START# *552BB745031E_523038C603B2_var*
//#UC END# *552BB745031E_523038C603B2_var*
begin
//#UC START# *552BB745031E_523038C603B2_impl*
 if aControl is TEdit then
  TEdit(aControl).ReadOnly := ReadOnly;
 if Assigned(f_BrowseButton) then
  f_BrowseButton.Enabled := not ReadOnly;
 if Assigned(f_TestButton) then
  f_TestButton.Enabled := not ReadOnly;
//#UC END# *552BB745031E_523038C603B2_impl*
end;//TddBrowseConfigItem.AdjustReadOnly

procedure TddBrowseConfigItem.ClearFields;
begin
 TestButtonCaption := '';
 inherited;
end;//TddBrowseConfigItem.ClearFields

procedure TddFolderNameConfigItem.Validate;
//#UC START# *5446141E00FA_523038DB01A5_var*
//#UC END# *5446141E00FA_523038DB01A5_var*
begin
//#UC START# *5446141E00FA_523038DB01A5_impl*
 if not AllowProcessDir and l3IsProcessFolder((Control as TEdit).Text) then
  raise EddInvalidValue.CreateFmt('Ссылаться на каталог с программой (%s) запрещено', [ParamStr(0)], Self);
//#UC END# *5446141E00FA_523038DB01A5_impl*
end;//TddFolderNameConfigItem.Validate

procedure TddFolderNameConfigItem.OnBrowseClick(Sender: TObject);
//#UC START# *52303EBD00B4_523038DB01A5_var*
var
 S: String;
//#UC END# *52303EBD00B4_523038DB01A5_var*
begin
//#UC START# *52303EBD00B4_523038DB01A5_impl*
 S := (Control as TEdit).Text;

// {$IFDEF RxLibrary}
// if BrowseDirectory(S, Caption, 0) then
//  (Control as TEdit).Text := S;
// {$ELSE}
 if SelectDirectory(S, [sdAllowCreate, sdPerformCreate, sdPrompt], 0) then
  (Control as TEdit).Text := S;
// {$ENDIF}
//#UC END# *52303EBD00B4_523038DB01A5_impl*
end;//TddFolderNameConfigItem.OnBrowseClick

procedure TddFolderNameConfigItem.OnTestClick(Sender: TObject);
//#UC START# *52303ECC02B3_523038DB01A5_var*
//#UC END# *52303ECC02B3_523038DB01A5_var*
begin
//#UC START# *52303ECC02B3_523038DB01A5_impl*
//#UC END# *52303ECC02B3_523038DB01A5_impl*
end;//TddFolderNameConfigItem.OnTestClick

constructor TddFolderNameConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_523038DB01A5_var*
//#UC END# *5217273F000F_523038DB01A5_var*
begin
//#UC START# *5217273F000F_523038DB01A5_impl*
 inherited;
 f_AllowProcessDir := True;
//#UC END# *5217273F000F_523038DB01A5_impl*
end;//TddFolderNameConfigItem.Create

procedure TddFolderNameConfigItem.GetValueFromControl;
//#UC START# *521B058801FD_523038DB01A5_var*
//#UC END# *521B058801FD_523038DB01A5_var*
begin
//#UC START# *521B058801FD_523038DB01A5_impl*
 Validate;
 inherited;
//#UC END# *521B058801FD_523038DB01A5_impl*
end;//TddFolderNameConfigItem.GetValueFromControl

procedure TddFileNameConfigItem.OnBrowseClick(Sender: TObject);
//#UC START# *52303EBD00B4_523038EA00E7_var*
//#UC END# *52303EBD00B4_523038EA00E7_var*
begin
//#UC START# *52303EBD00B4_523038EA00E7_impl*
 // Показываем окно выбора файла
 with TOpenDialog.Create(nil) do
 try
  Title := Caption;
  Filter := FilterMask;
  FileName := (Control as TEdit).Text;
  if Execute then
   (Control as TEdit).Text := FileName;
 finally
  Free;
 end;
//#UC END# *52303EBD00B4_523038EA00E7_impl*
end;//TddFileNameConfigItem.OnBrowseClick

procedure TddFileNameConfigItem.OnTestClick(Sender: TObject);
//#UC START# *52303ECC02B3_523038EA00E7_var*
//#UC END# *52303ECC02B3_523038EA00E7_var*
begin
//#UC START# *52303ECC02B3_523038EA00E7_impl*
//#UC END# *52303ECC02B3_523038EA00E7_impl*
end;//TddFileNameConfigItem.OnTestClick

procedure TddFileNameConfigItem.ClearFields;
begin
 FilterMask := '';
 inherited;
end;//TddFileNameConfigItem.ClearFields

constructor TddSoundFileNameConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_523038F9027B_var*
//#UC END# *5217273F000F_523038F9027B_var*
begin
//#UC START# *5217273F000F_523038F9027B_impl*
 inherited Create(aAlias, aCaption, aDefaultValue, aMasterItem);
 FilterMask := str_ddcmSoundFiles.AsStr;
 AllowTest := True;
//#UC END# *5217273F000F_523038F9027B_impl*
end;//TddSoundFileNameConfigItem.Create

procedure TddSoundFileNameConfigItem.OnTestClick(Sender: TObject);
//#UC START# *52303ECC02B3_523038F9027B_var*
//#UC END# *52303ECC02B3_523038F9027B_var*
begin
//#UC START# *52303ECC02B3_523038F9027B_impl*
 sndPlaySound(nil, SND_NODEFAULT);
 sndPlaySoundA(PAnsiChar((Control as TEdit).Text), SND_NOSTOP or SND_ASYNC or SND_NODEFAULT);
//#UC END# *52303ECC02B3_523038F9027B_impl*
end;//TddSoundFileNameConfigItem.OnTestClick

constructor TddTextConfigItem.Make(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefault: AnsiString = '';
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5230411D0123_5230390C00FC_var*
var
 l_Default: TddConfigValue;
//#UC END# *5230411D0123_5230390C00FC_var*
begin
//#UC START# *5230411D0123_5230390C00FC_impl*
 l3FillChar(l_Default, SizeOf(l_Default), 0);
 l_Default.Kind := dd_vkString;
 l_Default.AsString := aDefault;
 Create(aAlias, aCaption, l_Default, aMasterItem);
//#UC END# *5230411D0123_5230390C00FC_impl*
end;//TddTextConfigItem.Make

procedure TddTextConfigItem.DoOnChange(Sender: TObject);
//#UC START# *52304145029D_5230390C00FC_var*
//#UC END# *52304145029D_5230390C00FC_var*
begin
//#UC START# *52304145029D_5230390C00FC_impl*
 Changed := True;
//#UC END# *52304145029D_5230390C00FC_impl*
end;//TddTextConfigItem.DoOnChange

function TddTextConfigItem.ConstructControl(var aLeft: Integer;
 var aMaxLeft: Integer;
 var aTop: Integer;
 aParent: TWinControl): TControl;
//#UC START# *521761BB03DE_5230390C00FC_var*
//#UC END# *521761BB03DE_5230390C00FC_var*
begin
//#UC START# *521761BB03DE_5230390C00FC_impl*
 Result := TMemo.Create(aParent);
 Result.Parent := aParent;
 Result.Top := aTop;
 Result.Left := aLeft;
 Result.Width := aParent.ClientWidth - aLeft - c_ConfigItemRight;
 TMemo(Result).OnChange := DoOnChange;
//#UC END# *521761BB03DE_5230390C00FC_impl*
end;//TddTextConfigItem.ConstructControl

function TddTextConfigItem.ControlHeight(aParent: TWinControl): Integer;
//#UC START# *521B053F03C3_5230390C00FC_var*
var
 l_Memo: TMemo;
//#UC END# *521B053F03C3_5230390C00FC_var*
begin
//#UC START# *521B053F03C3_5230390C00FC_impl*
 l_Memo := TMemo.Create(aParent);
 try
  l_Memo.Parent := aParent;
  Result := l_Memo.Height;
 finally
  l_Memo.Free;
 end;
//#UC END# *521B053F03C3_5230390C00FC_impl*
end;//TddTextConfigItem.ControlHeight

procedure TddTextConfigItem.GetValueFromControl;
//#UC START# *521B058801FD_5230390C00FC_var*
//#UC END# *521B058801FD_5230390C00FC_var*
begin
//#UC START# *521B058801FD_5230390C00FC_impl*
 StringValue := (Control as TMemo).Lines.Text;
//#UC END# *521B058801FD_5230390C00FC_impl*
end;//TddTextConfigItem.GetValueFromControl

procedure TddTextConfigItem.SetValueToControl(aDefault: Boolean);
//#UC START# *521B07030052_5230390C00FC_var*
//#UC END# *521B07030052_5230390C00FC_var*
begin
//#UC START# *521B07030052_5230390C00FC_impl*
 if aDefault then
  (Control as TMemo).Text := DefaultValue.AsString
 else
  (Control as TMemo).Text := StringValue;
//#UC END# *521B07030052_5230390C00FC_impl*
end;//TddTextConfigItem.SetValueToControl

constructor TddTextConfigItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5217273F000F_5230390C00FC_var*
//#UC END# *5217273F000F_5230390C00FC_var*
begin
//#UC START# *5217273F000F_5230390C00FC_impl*
 inherited Create(aAlias, aCaption, aDefaultValue, aMasterItem);
 f_Value.Kind := dd_vkString;
//#UC END# *5217273F000F_5230390C00FC_impl*
end;//TddTextConfigItem.Create

procedure TddTextConfigItem.LoadValue(const aStorage: IddConfigStorage);
//#UC START# *52172B72014C_5230390C00FC_var*
//#UC END# *52172B72014C_5230390C00FC_var*
begin
//#UC START# *52172B72014C_5230390C00FC_impl*
 StringValue := UnMaskCRLF(l3Str(aStorage.ReadString(Alias, DefaultValue.AsString)));
//#UC END# *52172B72014C_5230390C00FC_impl*
end;//TddTextConfigItem.LoadValue

procedure TddTextConfigItem.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_5230390C00FC_var*
//#UC END# *52172CA801E3_5230390C00FC_var*
begin
//#UC START# *52172CA801E3_5230390C00FC_impl*
 aStorage.WriteString(Alias, MaskCRLF(Value.AsString));
//#UC END# *52172CA801E3_5230390C00FC_impl*
end;//TddTextConfigItem.SaveValue

function TddTextConfigItem.MinWidth(aParent: TWinControl): Integer;
//#UC START# *521B061A0387_5230390C00FC_var*
//#UC END# *521B061A0387_5230390C00FC_var*
begin
//#UC START# *521B061A0387_5230390C00FC_impl*
 Result := 250;
//#UC END# *521B061A0387_5230390C00FC_impl*
end;//TddTextConfigItem.MinWidth

procedure TddTextConfigItem.AdjustReadOnly(aControl: TControl);
//#UC START# *552BB745031E_5230390C00FC_var*
//#UC END# *552BB745031E_5230390C00FC_var*
begin
//#UC START# *552BB745031E_5230390C00FC_impl*
 if aControl is TMemo then
  TMemo(aControl).ReadOnly := ReadOnly;
//#UC END# *552BB745031E_5230390C00FC_impl*
end;//TddTextConfigItem.AdjustReadOnly

end.
