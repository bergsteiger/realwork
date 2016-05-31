unit ddAppConfigUtils;

// ������: "w:\common\components\rtl\Garant\dd\ddAppConfigUtils.pas"
// ���������: "UtilityPack"
// ������� ������: "ddAppConfigUtils" MUID: (51D559ED033C)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddConfigStorages
 , ddAppConfigTypes
 , l3ProtoObject
;

type
 TddItemLink = class(Tl3ProtoObject)
  private
   Item: TddVisualConfigItem;
   Next: TddItemLink;
  public
   constructor Create(aItem: TddVisualConfigItem;
    aNext: TddItemLink); reintroduce;
 end;//TddItemLink

function ExecuteNodeDialog(aNode: TddAppConfigNode;
 aValidate: Boolean = False): Boolean;
function MakeString(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefault: AnsiString;
 aNext: TddItemLink = nil): TddItemLink; overload;
function MakeString(const aCaption: AnsiString;
 const aDefault: AnsiString;
 aPassChar: AnsiChar;
 aNext: TddItemLink = nil): TddItemLink; overload;
function MakeFileName(const aCaption: AnsiString;
 const aFilter: AnsiString;
 const aDefault: AnsiString;
 aNext: TddItemLink = nil): TddItemLink; overload;
function MakeFileName(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aFilter: AnsiString;
 const aDefault: AnsiString;
 aNext: TddItemLink = nil): TddItemLink; overload;
function MakeInteger(const aCaption: AnsiString;
 aDefault: Integer;
 aNext: TddItemLink = nil): TddItemLink; overload;
function MakeInteger(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aDefault: Integer;
 aNext: TddItemLink = nil): TddItemLink; overload;
procedure AppendNode(aNode: TddAppConfigNode;
 aItems: TddItemLink);
{$If NOT Defined(Nemesis)}
function MakeDefaultStorage: IddConfigStorage;
{$IfEnd} // NOT Defined(Nemesis)
function MakeFolderName(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefault: AnsiString;
 aNext: TddItemLink = nil): TddItemLink; overload;
function MakeFolderName(const aCaption: AnsiString;
 const aDefault: AnsiString;
 aNext: TddItemLink = nil): TddItemLink; overload;
function MakeDate(const aCaption: AnsiString;
 aDefault: TDateTime;
 aNext: TddItemLink = nil): TddItemLink;
function MakeNode(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aLabelTop: Boolean;
 aItems: TddItemLink): TddAppConfigNode;
function MakeBoolean(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aDefault: Boolean;
 aNext: TddItemLink = nil): TddItemLink; overload;
function MakeStrings(const aCaption: AnsiString;
 aNext: TddItemLink = nil): TddItemLink;
function MakeCustomItem(aItem: TddVisualConfigItem;
 aNext: TddItemLink = nil): TddItemLink;
function MakeBoolean(const aCaption: AnsiString;
 aDefault: Boolean;
 aNext: TddItemLink = nil): TddItemLink; overload;
function MakeString(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefault: AnsiString;
 aPassChar: AnsiChar;
 aNext: TddItemLink = nil): TddItemLink; overload;
function MakeString(const aCaption: AnsiString;
 const aDefault: AnsiString;
 aNext: TddItemLink = nil): TddItemLink; overload;
function MakeDivider(const aCaption: AnsiString;
 aNext: TddItemLink = nil): TddItemLink;
{$If NOT Defined(Nemesis)}
function MakeTime(const aCaption: AnsiString;
 aDefault: TDateTime;
 aNext: TddItemLink = nil): TddItemLink;
{$IfEnd} // NOT Defined(Nemesis)

implementation

uses
 l3ImplUses
 , SysUtils
 , Windows
 , Math
 , StrUtils
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , ddAppConfigSimpleBFrame
 , ddAppConfigStrings
 , ddAppConfigConst
 , ddAppConfigDates
 , ddAppConfigLists
 , afwVCL
 {$If NOT Defined(Nemesis)}
 , ddIniStorage
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Base
;

function ExecuteNodeDialog(aNode: TddAppConfigNode;
 aValidate: Boolean = False): Boolean;
//#UC START# *52307C3D02F6_51D559ED033C_var*
var
 l_Dlg: TForm;
 l_ButtonsPanel: TSimpleButtonsFrame;
 l_Work: TCustomFrame;
 l_Ok: Boolean;
 l_Msg: AnsiString;

 procedure lp_RecalcFormSize;
 var
  l_MaxHeight, l_CurHeight: Integer;
  l_MaxWidth: Integer;
  l_Height, l_Width: Integer;
 begin
  l_MaxWidth := 450;
  l_MaxHeight := 230;
  IddConfigNode(aNode).FrameSize(l_Dlg, l_Height, l_Width);
  if not aNode.IsVerticalScrollBar then
   l_MaxHeight := Max(l_MaxHeight, l_Height);
  if not aNode.IsHorizontalScrollBar then
   l_MaxWidth := Max(l_MaxWidth, l_Width);

  // ������������� ��������
  l_Height := l_ButtonsPanel.Height + l_MaxHeight;
  { TODO -o������� ����� -c�������� : ��������� ��������� �������� }
  l_CurHeight := MulDiv(l_Width, 10, 14);
  if l_CurHeight < l_Height then
   l_Width := MulDiv(l_Height, 14, 10)
  else
   l_Height := l_CurHeight;
  l_Dlg.ClientHeight := l_Height;
  l_Dlg.ClientWidth := l_Width;
 end;

 function DialogCaption: String;
 var
  l_Index: Integer;
 begin
  if aNode.HasValue('Caption') then
   Result := aNode.AsString['Caption']
  else
   Result := aNode.Caption;
 end;
//#UC END# *52307C3D02F6_51D559ED033C_var*
begin
//#UC START# *52307C3D02F6_51D559ED033C_impl*
 Result := False;
 l_Dlg := TForm.Create(nil{Application.MainForm});
 AfwHackControlFont(l_Dlg);
 with l_Dlg do
 try
  BorderStyle := bsDialog;
  Position := poScreenCenter;
  Caption := DialogCaption;
  l_ButtonsPanel := TSimpleButtonsFrame.Create(l_Dlg);
  l_ButtonsPanel.Align := alBottom;
  l_ButtonsPanel.Parent := l_Dlg;
  lp_RecalcFormSize;
  l_Work := IddConfigNode(aNode).CreateFrame(l_Dlg, 0);
  IddConfigNode(aNode).SetControlValues(False);
  
  l_Ok := True;
  repeat
   Result := IsPositiveResult(ShowModal);
   if Result then
   begin
    Result := True;
    IddConfigNode(aNode).GetControlValues;
    { TODO -o������� ����� -c������ : �� ��������������� ���� Changed }
    if aValidate then
    begin
     l_Ok := not aNode.IsRequired(l_Msg);
     if not l_Ok then
      MessageDlg(Format('�� ��������� ������������ ���� "%s"', [l_Msg]), mtError, [mbOk], 0);
    end
    else
     l_Ok := True;
   end // Result
   else
   begin
    Result := False;
    l_Ok := True;
   end;
 until l_Ok;
  IddConfigNode(aNode).ClearControls;
 finally
  FreeAndNil(l_Dlg);
 end
//#UC END# *52307C3D02F6_51D559ED033C_impl*
end;//ExecuteNodeDialog

function MakeString(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefault: AnsiString;
 aNext: TddItemLink = nil): TddItemLink;
//#UC START# *52307D2E00B5_51D559ED033C_var*
//#UC END# *52307D2E00B5_51D559ED033C_var*
begin
//#UC START# *52307D2E00B5_51D559ED033C_impl*
 Result := MakeString(aAlias, aCaption, aDefault, #0, aNext);
//#UC END# *52307D2E00B5_51D559ED033C_impl*
end;//MakeString

function MakeString(const aCaption: AnsiString;
 const aDefault: AnsiString;
 aPassChar: AnsiChar;
 aNext: TddItemLink = nil): TddItemLink;
//#UC START# *52307D6901A1_51D559ED033C_var*
//#UC END# *52307D6901A1_51D559ED033C_var*
begin
//#UC START# *52307D6901A1_51D559ED033C_impl*
 Result := MakeString('Item', aCaption, aDefault, aPassChar, aNext);
//#UC END# *52307D6901A1_51D559ED033C_impl*
end;//MakeString

function MakeFileName(const aCaption: AnsiString;
 const aFilter: AnsiString;
 const aDefault: AnsiString;
 aNext: TddItemLink = nil): TddItemLink;
//#UC START# *52307DAE02AF_51D559ED033C_var*
var
 l_Value: TddConfigValue;
//#UC END# *52307DAE02AF_51D559ED033C_var*
begin
//#UC START# *52307DAE02AF_51D559ED033C_impl*
 l_Value:= ddEmptyValue;
 l_Value.AsString:= aDefault;
 Result:= MakeCustomItem(TddFileNameConfigItem.Create('Item', aCaption, l_Value), aNext);
 TddFileNameConfigItem(Result.Item).FilterMask:= aFilter;
//#UC END# *52307DAE02AF_51D559ED033C_impl*
end;//MakeFileName

function MakeFileName(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aFilter: AnsiString;
 const aDefault: AnsiString;
 aNext: TddItemLink = nil): TddItemLink;
//#UC START# *52307DDE001A_51D559ED033C_var*
var
 l_Value: TddConfigValue;
//#UC END# *52307DDE001A_51D559ED033C_var*
begin
//#UC START# *52307DDE001A_51D559ED033C_impl*
 l_Value := ddEmptyValue;
 l_Value.AsString := aDefault;
 Result := MakeCustomItem(TddFileNameConfigItem.Create(aAlias, aCaption, l_Value), aNext);
 TddFileNameConfigItem(Result.Item).FilterMask := aFilter;
//#UC END# *52307DDE001A_51D559ED033C_impl*
end;//MakeFileName

function MakeInteger(const aCaption: AnsiString;
 aDefault: Integer;
 aNext: TddItemLink = nil): TddItemLink;
//#UC START# *52307E12007E_51D559ED033C_var*
//#UC END# *52307E12007E_51D559ED033C_var*
begin
//#UC START# *52307E12007E_51D559ED033C_impl*
 Result := MakeInteger('IntegerItem', aCaption, aDefault, aNext);
//#UC END# *52307E12007E_51D559ED033C_impl*
end;//MakeInteger

function MakeInteger(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aDefault: Integer;
 aNext: TddItemLink = nil): TddItemLink;
//#UC START# *52307E30023F_51D559ED033C_var*
var
 l_Value: TddConfigValue;
//#UC END# *52307E30023F_51D559ED033C_var*
begin
//#UC START# *52307E30023F_51D559ED033C_impl*
 l_Value := ddEmptyIntValue;
 l_Value.AsInteger := aDefault;
 Result := MakeCustomItem(TddIntegerConfigItem.Create(aAlias, aCaption, l_Value), aNext);
//#UC END# *52307E30023F_51D559ED033C_impl*
end;//MakeInteger

procedure AppendNode(aNode: TddAppConfigNode;
 aItems: TddItemLink);
//#UC START# *52307E6B0051_51D559ED033C_var*
var
 l_ItemLink: TddItemLink;
//#UC END# *52307E6B0051_51D559ED033C_var*
begin
//#UC START# *52307E6B0051_51D559ED033C_impl*
 while aItems <> nil do
 begin
  if aItems.Item.Alias = '' then
   aItems.Item.Alias := 'Item' + IntToStr(aNode.Count);
  aNode.AddItem(aItems.Item);
  l_ItemLink := aItems.Next;
  l3Free(aItems);
  aItems := l_ItemLink;
 end;
//#UC END# *52307E6B0051_51D559ED033C_impl*
end;//AppendNode

{$If NOT Defined(Nemesis)}
function MakeDefaultStorage: IddConfigStorage;
//#UC START# *52307E89023B_51D559ED033C_var*
//#UC END# *52307E89023B_51D559ED033C_var*
begin
//#UC START# *52307E89023B_51D559ED033C_impl*
 Result := TddIniStorage.Create(ChangeFileExt(Application.ExeName, '.ini'));
//#UC END# *52307E89023B_51D559ED033C_impl*
end;//MakeDefaultStorage
{$IfEnd} // NOT Defined(Nemesis)

function MakeFolderName(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefault: AnsiString;
 aNext: TddItemLink = nil): TddItemLink;
//#UC START# *52307ED502A2_51D559ED033C_var*
var
 l_Value: TddConfigValue;
//#UC END# *52307ED502A2_51D559ED033C_var*
begin
//#UC START# *52307ED502A2_51D559ED033C_impl*
 l_Value := ddEmptyValue;
 l_Value.AsString := aDefault;
 Result := MakeCustomItem(TddFolderNameConfigItem.Create(aAlias, aCaption, l_Value), aNext);
//#UC END# *52307ED502A2_51D559ED033C_impl*
end;//MakeFolderName

function MakeFolderName(const aCaption: AnsiString;
 const aDefault: AnsiString;
 aNext: TddItemLink = nil): TddItemLink;
//#UC START# *52307EFF0216_51D559ED033C_var*
//#UC END# *52307EFF0216_51D559ED033C_var*
begin
//#UC START# *52307EFF0216_51D559ED033C_impl*
 Result := MakeFolderName('FolderItem', aCaption, aDefault, aNext);
//#UC END# *52307EFF0216_51D559ED033C_impl*
end;//MakeFolderName

function MakeDate(const aCaption: AnsiString;
 aDefault: TDateTime;
 aNext: TddItemLink = nil): TddItemLink;
//#UC START# *52307F4602C7_51D559ED033C_var*
var
 l_Value: TddConfigValue;
//#UC END# *52307F4602C7_51D559ED033C_var*
begin
//#UC START# *52307F4602C7_51D559ED033C_impl*
 l_Value := ddEmptyValue;
 l_Value.AsDateTime := aDefault;
 Result := MakeCustomItem(TddDateConfigItem.Create('Item', aCaption, l_Value), aNext);
//#UC END# *52307F4602C7_51D559ED033C_impl*
end;//MakeDate

function MakeNode(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aLabelTop: Boolean;
 aItems: TddItemLink): TddAppConfigNode;
//#UC START# *52307F8F0103_51D559ED033C_var*
var
 l_ItemLink: TddItemLink;
//#UC END# *52307F8F0103_51D559ED033C_var*
begin
//#UC START# *52307F8F0103_51D559ED033C_impl*
 Result := TddAppConfigNode.Create(IfThen(aAlias = '', 'Params', aAlias), aCaption);
 Result.LabelTop := aLabelTop;
 while aItems <> nil do
 begin
  if Result.HasValue(aItems.Item.Alias) then
   aItems.Item.Alias := 'Item'+IntToStr(Result.Count);
  Result.AddItem(aItems.Item);
  l_ItemLink := aItems.Next;
  l3Free(aItems);
  aItems := l_ItemLink;
 end;
//#UC END# *52307F8F0103_51D559ED033C_impl*
end;//MakeNode

function MakeBoolean(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aDefault: Boolean;
 aNext: TddItemLink = nil): TddItemLink;
//#UC START# *5230801702A0_51D559ED033C_var*
var
 l_Value: TddConfigValue;
//#UC END# *5230801702A0_51D559ED033C_var*
begin
//#UC START# *5230801702A0_51D559ED033C_impl*
 l_Value := ddEmptyValue;
 l_Value.AsBoolean := aDefault;
 Result := MakeCustomItem(TddBooleanConfigItem.Create(aAlias, aCaption, l_Value), aNext);
//#UC END# *5230801702A0_51D559ED033C_impl*
end;//MakeBoolean

function MakeStrings(const aCaption: AnsiString;
 aNext: TddItemLink = nil): TddItemLink;
//#UC START# *523080530337_51D559ED033C_var*
//#UC END# *523080530337_51D559ED033C_var*
begin
//#UC START# *523080530337_51D559ED033C_impl*
 Result := TddItemLink.Create(TddStringListConfigItem.Make('Item', aCaption), aNext);
//#UC END# *523080530337_51D559ED033C_impl*
end;//MakeStrings

function MakeCustomItem(aItem: TddVisualConfigItem;
 aNext: TddItemLink = nil): TddItemLink;
//#UC START# *523080A201D2_51D559ED033C_var*
//#UC END# *523080A201D2_51D559ED033C_var*
begin
//#UC START# *523080A201D2_51D559ED033C_impl*
 Result := TddItemLink.Create(aItem, aNext);
//#UC END# *523080A201D2_51D559ED033C_impl*
end;//MakeCustomItem

function MakeBoolean(const aCaption: AnsiString;
 aDefault: Boolean;
 aNext: TddItemLink = nil): TddItemLink;
//#UC START# *523081B70301_51D559ED033C_var*
//#UC END# *523081B70301_51D559ED033C_var*
begin
//#UC START# *523081B70301_51D559ED033C_impl*
 Result := MakeBoolean('BooleanItem', aCaption, aDefault, aNext);
//#UC END# *523081B70301_51D559ED033C_impl*
end;//MakeBoolean

function MakeString(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aDefault: AnsiString;
 aPassChar: AnsiChar;
 aNext: TddItemLink = nil): TddItemLink;
//#UC START# *5230831903A5_51D559ED033C_var*
var
 l_Value: TddConfigValue;
//#UC END# *5230831903A5_51D559ED033C_var*
begin
//#UC START# *5230831903A5_51D559ED033C_impl*
 l_Value := ddEmptyValue;
 l_Value.AsString := aDefault;
 Result := MakeCustomItem(TddStringConfigItem.Create(aAlias, aCaption, l_Value), aNext);
 TddStringConfigItem(Result.Item).PasswordChar := AnsiChar(aPassChar);
//#UC END# *5230831903A5_51D559ED033C_impl*
end;//MakeString

function MakeString(const aCaption: AnsiString;
 const aDefault: AnsiString;
 aNext: TddItemLink = nil): TddItemLink;
//#UC START# *523083C403D7_51D559ED033C_var*
//#UC END# *523083C403D7_51D559ED033C_var*
begin
//#UC START# *523083C403D7_51D559ED033C_impl*
 Result := MakeString(aCaption, aDefault, #0, aNext);
//#UC END# *523083C403D7_51D559ED033C_impl*
end;//MakeString

function MakeDivider(const aCaption: AnsiString;
 aNext: TddItemLink = nil): TddItemLink;
//#UC START# *5230842302DB_51D559ED033C_var*
//#UC END# *5230842302DB_51D559ED033C_var*
begin
//#UC START# *5230842302DB_51D559ED033C_impl*
 Result := MakeCustomItem(TddDividerConfigItem.Create('DividerItem', aCaption, ddEmptyValue), aNext);
//#UC END# *5230842302DB_51D559ED033C_impl*
end;//MakeDivider

{$If NOT Defined(Nemesis)}
function MakeTime(const aCaption: AnsiString;
 aDefault: TDateTime;
 aNext: TddItemLink = nil): TddItemLink;
//#UC START# *523084490017_51D559ED033C_var*
var
 l_Value: TddConfigValue;
//#UC END# *523084490017_51D559ED033C_var*
begin
//#UC START# *523084490017_51D559ED033C_impl*
 l_Value := ddEmptyValue;
 l_Value.AsDateTime := aDefault;
 Result := MakeCustomItem(TddTimeConfigItem.Create('Item', aCaption, l_Value), aNext);
//#UC END# *523084490017_51D559ED033C_impl*
end;//MakeTime
{$IfEnd} // NOT Defined(Nemesis)

constructor TddItemLink.Create(aItem: TddVisualConfigItem;
 aNext: TddItemLink);
//#UC START# *52307CDE03D5_522F684203BF_var*
//#UC END# *52307CDE03D5_522F684203BF_var*
begin
//#UC START# *52307CDE03D5_522F684203BF_impl*
 inherited Create;
 Item := aItem;
 Next := aNext;
//#UC END# *52307CDE03D5_522F684203BF_impl*
end;//TddItemLink.Create

end.
