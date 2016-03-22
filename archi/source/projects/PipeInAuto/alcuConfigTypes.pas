unit alcuConfigTypes;
{ Специальные типы для настройки Парня }

{ $Id: alcuConfigTypes.pas,v 1.58 2016/03/04 09:34:31 lukyanets Exp $ }

// $Log: alcuConfigTypes.pas,v $
// Revision 1.58  2016/03/04 09:34:31  lukyanets
// Отвалились вложенные задания
//
// Revision 1.57  2015/12/02 12:14:32  lukyanets
// Падали на кривом инишнике
//
// Revision 1.56  2015/11/26 08:45:26  lukyanets
// КОнстанты переехали
//
// Revision 1.55  2015/10/14 07:07:55  lukyanets
// Cleanup
//
// Revision 1.54  2015/10/12 11:01:58  lukyanets
// Задаем пользователя для импорта из Гардок
//
// Revision 1.53  2015/10/09 13:01:53  lukyanets
// Пишем в лог от чьего имени выполняется задача
//
// Revision 1.52  2015/07/28 13:31:07  lulin
// - перерисовываем.
//
// Revision 1.51  2015/07/02 11:40:59  lukyanets
// Описываем словари
//
// Revision 1.50  2015/07/02 07:34:38  lukyanets
// Описываем словари
//
// Revision 1.49  2015/06/24 13:38:36  lukyanets
// Убираем излишний рестарт
//
// Revision 1.48  2015/04/13 15:19:35  lukyanets
// Снабжаем настройки понятием ReadOnly
//
// Revision 1.47  2015/02/03 12:22:35  kostitsin
// {requestlink:587438065}
//
// Revision 1.46  2015/02/02 07:53:55  fireton
// - не собиралось
//
// Revision 1.45  2014/12/22 12:35:57  fireton
// - TalcuWeekChecklineItem
//
// Revision 1.44  2014/09/11 12:45:40  lukyanets
// В инишник пишем типы задач которые *можно* отцеплять
//
// Revision 1.43  2014/09/05 12:38:57  lukyanets
// Рожаем RegionImportTask
//
// Revision 1.42  2014/08/19 12:13:16  kostitsin
// {requestlink: 562594400 }
//
// Revision 1.41  2014/08/07 14:02:21  lukyanets
// {Requestlink:556143119}. Вытащили ручки для отключения конкретных типов задач
//
// Revision 1.40  2014/08/01 11:30:34  lukyanets
// {Requestlink:558466572}. Переопределяем Define
//
// Revision 1.39  2014/07/28 11:45:23  lukyanets
// {Requestlink:557844282}. Прикручиваем серверный ddAppConfig
//
// Revision 1.38  2014/02/14 15:33:23  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.37  2014/02/13 12:14:46  lulin
// - рефакторим безликие списки.
//
// Revision 1.36  2013/09/19 09:30:41  fireton
// - перекрывались не те методы
//
// Revision 1.35  2013/09/11 16:36:15  kostitsin
// [$476838236]
//
// Revision 1.34  2013/09/05 09:27:32  kostitsin
// [$476838236] - закончил c ddAppConfigTypes
//
// Revision 1.33  2013/09/05 09:22:59  kostitsin
// [$476838236] - закончил c ddAppConfigTypes
//
// Revision 1.32  2013/08/29 08:47:20  kostitsin
// [$476838236]
//
// Revision 1.31  2013/08/28 05:15:03  fireton
// - не собиралось
//
// Revision 1.30  2013/01/17 10:29:52  fireton
// - не собиралось
//
// Revision 1.29  2013/01/11 12:14:40  narry
// * автоматическая упаковка результатов экспорта Хаванского (ЭХ)
// * автоматическое копироване ЭХ на FTP
// * дельта экспорта МЦФР
//
// Revision 1.28  2012/10/18 07:37:18  narry
// Обновление
//
// Revision 1.27  2012/10/02 07:25:08  narry
// Обновление
//
// Revision 1.26  2011/06/14 13:17:52  narry
// Реализовать автоэкспорт документов (268338975)
//
// Revision 1.25  2011/05/06 07:58:20  narry
// Не сохраняется выбор в списке Групп доступа (265410101)
//
// Revision 1.24  2011/03/23 11:56:56  narry
// K254352041. Цеплять исходный rtf или doc к судебной практике в виде образа
//
// Revision 1.23  2010/09/24 12:41:07  voba
// - k : 235046326
//
// Revision 1.22  2010/04/20 10:20:22  narry
// - обновление списка запросов
//
// Revision 1.21  2010/04/20 09:38:01  narry
// - контролы для выбора поискового запроса
//
// Revision 1.20  2009/11/10 08:20:06  narry
// - обновление
// - экспорт произвольных аннотаций в Прайм
//
// Revision 1.19  2009/05/27 12:29:20  narry
// - Обновление
//
// Revision 1.18  2009/03/17 09:28:33  narry
// - карта элементов календаря
// - корректное вычисление размеров vtCheckList
//
// Revision 1.17  2009/02/20 13:28:09  narry
// - обновление
//
// Revision 1.16  2009/01/23 16:21:46  narry
// - рефакторинг
//
// Revision 1.15  2008/10/13 12:38:41  narry
// - промежуточное обновление
//
// Revision 1.14  2008/07/28 09:55:42  fireton
// - автоподстановка периодичности заданий
// - required типы заданий
//
// Revision 1.13  2008/07/24 15:17:08  narry
// - возможность задать количество строк списка элементов словаря
//
// Revision 1.12  2008/07/24 11:50:46  fireton
// - уведомление клиента об изменениях заданий в планировщике
//
// Revision 1.11  2008/07/14 08:06:10  narry
// - косметика
//
// Revision 1.10  2008/07/12 12:36:02  fireton
// - рефакторинг DT_Dict
//
// Revision 1.9  2008/07/09 09:03:11  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.8  2008/06/24 07:42:31  narry
// - заплатка для комбодерева
//
// Revision 1.7  2008/06/10 14:15:27  narry
// - запись в ББ информации о проведенной АК
// - исправление ошибки импорта - запись "престижа" в документ, идущий перед пропущенным
//
// Revision 1.6  2008/05/26 10:01:20  narry
// - рефакторинг редактирования заданий
//
// Revision 1.5  2008/05/14 11:16:25  narry
// - новые элементы конфигурации для работы со словарями
//
// Revision 1.4  2008/02/27 15:55:22  narry
// - возможность выполнить файл после экспорта
// - условия компиляции
// - файл deleted.lst
// - время в смс
// - условия компиляции
// - другое
//
// Revision 1.3  2008/02/19 15:52:19  narry
// - перенос настроек из garant\base.ini в Конфигурацию
//
// Revision 1.2  2007/11/26 13:25:32  narry
// - обновление
//

{$I alcuDefine.inc}

interface

uses
 daTypes,
 dt_Types, dt_Const, dt_AttrSchema, dt_DictTypes,
 ddAppConfigTypes, ddConfigStorages,
 CheckLst,  StdCtrls,
 l3Interfaces, l3Base, l3ValueMap, l3TypedIntegerValueMap, Controls, l3LongintList, alcuSchedulerFrame, classes,
 ddScheduler, Forms, ddAppConfigDataAdapters, ddAppConfigConst, DT_AskList, l3Tree_TLB,
 l3TreeInterfaces;

type
  TalcuEmailAdapter = class(TddBaseConfigDataAdapter)
  protected
    function pm_GetCount: Integer; override;
    function pm_GetStrings(Index: Integer): string; override;
  public
    function DeleteItem(Index: Integer): Boolean; override;
    function EditItem(Index: Integer): Boolean; override;
    procedure ClearItems; override;
    procedure Load(const aStorage: IddConfigStorage; const aAlias: AnsiString); override;
    procedure Save(const aStorage: IddConfigStorage; const aAlias: AnsiString); override;
  end;

  TalcuUserListMap = class(Tl3IntegerValueMap)
  private
   f_UserList: TStringList;
   function pm_GetValidItems: Boolean;
   procedure RefreshList;
  protected
 // protected methods
    function DoDisplayNameToValue(const aDisplayName: Il3CString): Integer; override;
     {* Функция очистки полей объекта. }
   procedure DoGetDisplayNames(const aList: Il3StringsEx); override;
   function DoValueToDisplayName(aValue: Integer): Il3CString; override;
   function GetMapSize: Integer; override;
  protected
   procedure Cleanup; override;
  public
   constructor Make;
   property ValidItems: Boolean read pm_GetValidItems;
  end;

  TalcuUserListComboItem = class(TddComboBoxConfigItem)
  private
   f_Map: TalcuUserListMap;
  protected
   procedure CheckLoadItems; override;
   procedure Cleanup; override;
  public
   constructor Make(const aAlias, aCaption: String; aMasterItem: TddBaseConfigItem = nil;
       aMasterIndex: Integer = -1);
   procedure GetValueFromControl; override;
  end;

  TalcuDictionaryMap = class(Tl3IntegerValueMap)
  private
   f_DictID: TdaDictionaryType;
   function pm_GetValidItems: Boolean;
  protected
 // protected methods
    function DoDisplayNameToValue(const aDisplayName: Il3CString): Integer; override;
     {* Функция очистки полей объекта. }
   procedure DoGetDisplayNames(const aList: Il3StringsEx); override;
    function DoValueToDisplayName(aValue: Integer): Il3CString; override;
   function GetMapSize: Integer; override;
  public
   constructor Make(aDictID: TdaDictionaryType);
   property ValidItems: Boolean read pm_GetValidItems;
  end;

  TalcuDictionaryComboItem = class(TddComboBoxConfigItem)
  public
   constructor Make(const aAlias, aCaption: String; aDictID: TdaDictionaryType; aMasterItem: TddBaseConfigItem = nil;
       aMasterIndex: Integer = -1);
   procedure GetValueFromControl; override;
  end;

  TalcuDictionaryTreeItem = class(TddVisualConfigItem)
  private
   f_DictID: TdaDictionaryType;
   f_MultiSelect: Boolean;
   f_Rows: Integer;
   f_SelectedList: Tl3LongintList;
   procedure ConvertValue2Object;
   function IsExtItem(aNode: Il3Node): Boolean;
   procedure Str2Value(aStr: String);
   function Value2Str: String;
  protected
   procedure Cleanup; override;
   function ConstructControl(var aLeft, aMaxLeft, aTop: Integer; aParent: TWinControl): TControl; override;
   procedure AdjustReadOnly(aControl: TControl); override;
   procedure _OnTreeChange(Sender: TObject; Index : LongInt; var SelectedState : Integer);
  public
   constructor Create(const aAlias, aCaption: AnsiString; const aDefaultValue: TddConfigValue; aMasterItem: TddBaseConfigItem = nil); override;
   constructor Make(const aAlias, aCaption: String; aDictID: TdaDictionaryType; aMultiSelect: Boolean; aRows:
       Integer = 5; aMasterItem: TddBaseConfigItem = nil); overload;
   constructor Make(const aAlias, aCaption: String; aDictID: TdaDictionaryType; aMultiSelect: Boolean; const
       aDefault: String; aRows: Integer = 5; aMasterItem: TddBaseConfigItem = nil); overload;
   procedure Assign(P: TPersistent); override;
   function ControlHeight(aParent: TWinControl): Integer; override;
   procedure GetValueFromControl; override;
   procedure LoadValue(const aStorage: IddConfigStorage); override;
   procedure SaveValue(const aStorage: IddConfigStorage); override;
   procedure SetValueToControl(aDefault : Boolean); override;
   property Rows: Integer read f_Rows write f_Rows;
  end;


 TalcuDictComboTreeItem = class(TalcuDictionaryTreeItem)
 protected
  function ConstructControl(var aLeft, aMaxLeft, aTop: Integer; aParent: TWinControl): TControl; override;
  procedure AdjustReadOnly(aControl: TControl); override;
  procedure _OnChange(Sender: TObject);
 public
  function ControlHeight(aParent: TWinControl): Integer; override;
  procedure GetValueFromControl; override;
  procedure SetValueToControl(aDefault: Boolean); override;
 end;

  TalcuAsyncRunTaskItem = class(TddVisualConfigItem)
  private
   f_Rows: Integer;
   f_List: Tl3LongintList;
   procedure ConvertValue2Object;
   procedure Str2Value(aStr: String);
   function Value2Str: String;
   function MakeTaskTree: Il3SimpleRootNode;
  protected
   procedure Cleanup; override;
   function ConstructControl(var aLeft, aMaxLeft, aTop: Integer; aParent: TWinControl): TControl; override;
   procedure AdjustReadOnly(aControl: TControl); override;
   procedure _OnTreeChange(Sender: TObject; Index : LongInt; var SelectedState : Integer);
  public
   constructor Create(const aAlias, aCaption: AnsiString; const aDefaultValue: TddConfigValue; aMasterItem: TddBaseConfigItem = nil); override;
   constructor Make(const aAlias, aCaption: String; aRows:
       Integer = 5; aMasterItem: TddBaseConfigItem = nil); overload;
   procedure Assign(P: TPersistent); override;
   function ControlHeight(aParent: TWinControl): Integer; override;
   procedure GetValueFromControl; override;
   procedure LoadValue(const aStorage: IddConfigStorage); override;
   procedure SaveValue(const aStorage: IddConfigStorage); override;
   procedure SetValueToControl(aDefault : Boolean); override;
   property Rows: Integer read f_Rows write f_Rows;
  end;

  TalcuWeekChecklineItem = class(TddVisualConfigItem)
  private
   f_Boxes: array [1..7] of TCheckBox;
  protected
   function ConstructControl(var aLeft, aMaxLeft, aTop: Integer; aParent: TWinControl): TControl; override;
   procedure AdjustReadOnly(aControl: TControl); override;
     {* Функция очистки полей объекта. }
   procedure DoEnabled; override;
   procedure SetValueToControl(aDefault: Boolean); override;
   procedure GetValueFromControl; override;
  public
   constructor Create(const aAlias, aCaption: AnsiString; const aDefaultValue: TddConfigValue; aMasterItem:
    TddBaseConfigItem = nil); override;
   constructor Make(const aAlias, aCaption: AnsiString; aMasterItem: TddBaseConfigItem = nil); overload;
   function ControlHeight(aParent: TWinControl): Integer; override;
  end;

  TalcuSchedulerNode = class(TddCustomConfigNode)
  private
    f_Frame: TSchedulerFrame;
    f_Scheduler: TddScheduler;
  protected
    procedure LoadValue(const aStorage: IddConfigStorage); override;
    procedure Release; override;
    function pm_GetValue: TddConfigValue; override;
    function pm_GetChanged: Boolean; override;
    procedure pm_SetChanged(Value: Boolean); override;
    procedure pm_SetValue(const Value: TddConfigValue); override;
    procedure SaveValue(const aStorage: IddConfigStorage); override;
  public
    constructor Create(const aAlias, aCaption: String);
    procedure DoClearControls; override;
    function DoCreateFrame(aOwner: TComponent; aTag: Integer): TCustomFrame; override;
    procedure DoFrameSize(aParent: TWinControl; out aHeight, aWidth: Integer);
            override;
    procedure DoGetControlValues; override;
    function IsRequired(out aMessage: String): Boolean; override;
    procedure PostEdit; override;
    procedure DoSetControlValues(aDefault: Boolean); override;
  end;

 TalcuQueryComboboxItem = class(TddComboBoxConfigItem)
 public
  constructor Make(const aAlias, aCaption: String; aMasterItem: TddBaseConfigItem = nil;
      aMasterIndex: Integer = -1);
  procedure GetValueFromControl; override;
 end;

type
  TalcuQueryMap = class(Tl3ValueMap, Il3StringValueMap)
  private
    f_QueryList: TQueryList;
    function DisplayNameToValue(const aDisplayName: Il3CString): Il3CString;
    procedure ReloadQueries;
    function ValueToDisplayName(const aValue: Il3CString): Il3CString;
  protected
    procedure Cleanup; override;
   procedure DoGetDisplayNames(const aList: Il3StringsEx); override;
   function GetMapSize: Integer; override;
  public
   constructor Make;
  end;

 TalcuQueryCheckListItem = class(TddCheckListConfigItem)
  constructor Create(const aAlias, aCaption: AnsiString; const aDefaultValue:
      TddConfigValue; aMasterItem: TddBaseConfigItem = nil); override;
  private
  f_QueryList: TQueryList;
 protected
  procedure Cleanup; override;
 end;

function DictComboItem(aAlias, aCaption: String; aDict: TdaDictionaryType; aMultiSelect: Boolean):
    TalcuDictionaryComboItem;

function FTPParams(aPrefix, aCaption: String): TddBaseConfigItem;

implementation

uses
 SysUtils,
 l3Bits, l3String,
 ddUtils,
 {$IFNDEF Service}
 daSchemeConsts,
 dt_Dict,
 {$ENDIF}
 alcuMailServer, alcuEmailNotifyDlg, alcuRegionEditDlg, ExtCtrls, Windows, Graphics,
 l3VCLStrings, vtOutliner, rxStrUtils, vtLister, l3Nodes, daInterfaces,
 l3Tree, {AbstractDropDown,} ctTypes, FakeBox, StrUtils, ddAppConfigStrings, alcuTypes,
 dt_Serv, ddAppConfig, l3ObjectRefList1, dt_DictIntf, csTaskTypes, ddServerTask,
 ddTaskClassManager, k2Facade, k2Base, dt_User,
 vtComboTree
 ;

function DictComboItem(aAlias, aCaption: String; aDict: TdaDictionaryType; aMultiSelect: Boolean):
    TalcuDictionaryComboItem;
begin
 // TODO -cMM: DictComboItem default body inserted
 Result:= nil;
end;

function FTPParams(aPrefix, aCaption: String): TddBaseConfigItem;
var
 l_Item: TddBaseConfigItem;
begin
 Result := TddGroupConfigItem.SimpleCreate(aPrefix+'FTPParams', aCaption);
 with TddGroupConfigItem(Result) do
 begin
  LabelTop:= False;
  Add(TddStringConfigItem.Make(aPrefix+'FTPServer', 'Сервер'));
  Add(TddStringConfigItem.Make(aPrefix+'FTPUser', 'Пользователь'));
  l_Item:= Add(TddStringConfigItem.Make(aPrefix+'FTPPassword', 'Пароль'));
  TddStringConfigItem(l_Item).PasswordChar:= '*';
  Add(TddBooleanConfigItem.Create(aPrefix+'FTPPassive', 'Пассивный режим', ddEmptyValue));
  Add(TddStringConfigItem.Make(aPrefix+'FTPFolder', 'Папка на сервере'));
 end;
end;


type
 TalcuTreeComboBox = class(TvtComboTree)
 public
  property SizeableTree;
  property ShowGripper;
 end;


{ TalcuEmailAdapter }

function TalcuEmailAdapter.DeleteItem(Index: Integer): Boolean;
begin
  Result:= True;
  alcuMail.EmailNotifyList.Objects[Index].Free;
  alcuMail.EmailNotifyList.Delete(Index);
end;

function TalcuEmailAdapter.EditItem(Index: Integer): Boolean;
var
  l_Email: TddEmailNotify;
  l_Index: Integer;
  l_S: string;
begin
  if Index < 0 then
   l_Email:= TddEmailNotify.Create
  else
   l_Email:= TddEmailNotify(alcuMail.EmailNotifyList.Objects[Index]);

  with TEmailNotifyDialog.Create(nil) do
  try
   editAddress.Text:= l_Email.Address;
   editComment.Text:= l_Email.Comment;
   cbOnlyErrors.Checked:= l_Email.OnlyErrors;
   for l_Index:= 0 to EventsList.Total-1 do
    EventsList.Selected[l_Index]:= l3TestBit(l_Email.Events, l_Index);
   Result:= False;
   if (ShowModal = mrOk) and (editAddress.Text <> '') then
   begin
    Result:= true;
    l_Email.Address:= editAddress.Text;
    l_Email.Comment:= editComment.Text;
    l_Email.OnlyErrors:= cbOnlyErrors.Checked;
    l_Email.Events:= 0;
    for l_Index:= 0 to EventsList.Total-1 do
     if EventsList.Selected[l_Index] then
      l3SetBit(l_Email.Events, l_Index);
    if l_Email.Comment <> '' then
     l_S:= l_Email.Comment
    else
     l_S:= l_Email.Address;
    if Index < 0 then
     alcuMail.EmailNotifyList.AddObject(l_S, l_Email)
    else
     alcuMail.EmailNotifyList.Strings[Index]:= l_S;
   end // ShowModal
   else
   if Index < 0 then
    l3Free(l_Email);
  finally
   Free;
  end; // with EmailNotifyDialog
end;

function TalcuEmailAdapter.pm_GetCount: Integer;
begin
  Result:= alcuMail.EmailNotifyList.Count;
end;

function TalcuEmailAdapter.pm_GetStrings(Index: Integer): string;
begin
  Result:= alcuMail.EmailNotifyList.Strings[Index];
end;

procedure TalcuEmailAdapter.Load(const aStorage: IddConfigStorage; const aAlias: AnsiString);
var
  i, l_Count: Integer;
  l_S: string;
  l_Email: TddEmailNotify;
begin
  with aStorage do
  begin
   Section:= aAlias;
   l_Count:= ReadInteger('EmailCount', 0);
   for i:= 0 to Pred(l_Count) do
   begin
    Section:= aAlias;
    l_S:= l3Str(ReadString(IntToStr(Succ(i)), ''));
    if l_S <> '' then
    begin
     l_Email:= TddEmailNotify.Create;
     Section:= l_S;
     l_Email.Address:= l3Str(ReadString('Address', ''));
     l_Email.Comment:= l3Str(ReadString('Comment', ''));
     l_Email.Events:= ReadInteger('Events', 0);
     l_Email.OnlyErrors:= ReadBool('OnlyErrors', True);
     if l_Email.Address <> '' then
     begin
      if l_Email.Comment <> '' then
       alcuMail.EmailNotifyList.AddObject(l_Email.Comment, l_EMail)
      else
       alcuMail.EmailNotifyList.AddObject(l_Email.Address, l_EMail)
     end
     else
      l3Free(l_Email);
    end; // l_S <> ''
   end; // i
  end;
end;

procedure TalcuEmailAdapter.Save(const aStorage: IddConfigStorage; const aAlias: AnsiString);
var
  i, l_Count: Integer;
  l_S: string;
  l_Email: TddEmailNotify;
begin
  with aStorage do
  begin
   Section:= aAlias;
   WriteInteger('EmailCount', alcuMail.EmailNotifyList.Count);
   for i:= 0 to Pred(alcuMail.EmailNotifyList.Count) do
   begin
    Section:= aAlias;
    l_Email:= TddEmailNotify(alcuMail.EmailNotifyList.Objects[i]);
    WriteString(IntToStr(Succ(i)), l_Email.Address);
    Section:= l_Email.Address;
    WriteString('Address', l_Email.Address);
    WriteString('Comment', l_Email.Comment);
    WriteInteger('Events', l_Email.Events);
    WriteBool('OnlyErrors', l_Email.OnlyErrors);
   end; // i
  end; // with aIni
end;

{ TalcuEmailAdapter }

{
****************************** TalcuEmailAdapter *******************************
}

constructor TalcuDictionaryMap.Make(aDictID: TdaDictionaryType);
var
 l_Rec: Tl3ValueMapID;
begin
 l_Rec.rName:= 'Словарь';
 l_Rec.rID:= Ord(aDictID);
 Create(l_Rec, TypeInfo(Integer));
 f_DictID:= aDictID;
end;

function TalcuDictionaryMap.DoDisplayNameToValue(const aDisplayName: Il3CString): Integer;
var
 i: Integer;
 l_Value: String;
begin
 {$IFNDEF Service}
 if ValidItems then
 begin
  l_Value:= l3Str(aDisplayName);
  for i:= 0 to Pred(DictServer(CurrentFamily).DictList[f_DictID].Count) do
   if DictServer(CurrentFamily).DictList[f_DictID].Strings[i] = l_Value then
    Result:= DictServer(CurrentFamily).DictList[f_DictID].DataInt[i];
 end
 else
 {$ENDIF}
  Result:= -1
end;

procedure TalcuDictionaryMap.DoGetDisplayNames(const aList: Il3StringsEx);
var
 l_Index: Integer;
begin
 inherited;
 {$IFNDEF Service}
 if ValidItems then
 begin
  aList.Add('Выберите элемент словаря');
  for l_Index := 0 to Pred(DictServer(CurrentFamily).DictList[f_DictID].Count) Do
   aList.Add(l3CStr(DictServer(CurrentFamily).DictList[f_DictID].Strings[l_Index]));
 end;
 {$ENDIF}
end;

function TalcuDictionaryMap.DoValueToDisplayName(aValue: Integer): Il3CString;
var
 i: Integer;
begin
 Result:= nil;
 {$IFNDEF Service}
 if ValidItems then
 begin
  if aValue = -1 then
   Result:= l3CStr('Выберите элемент словаря')
  else
  for i:= 0 to Pred(DictServer(CurrentFamily).DictList[f_DictID].Count) do
   if DictServer(CurrentFamily).DictList[f_DictID].DataInt[i] = aValue then
    Result:= l3CStr(DictServer(CurrentFamily).DictList[f_DictID].Strings[i]);
 end;
 {$ENDIF}
end;

function TalcuDictionaryMap.GetMapSize: Integer;
begin
 {$IFNDEF Service}
 if ValidItems then
  Result := Succ(DictServer(CurrentFamily).DictList[f_DictID].Count)
 else
 {$ENDIF}
  Result:= 0;
end;

function TalcuDictionaryMap.pm_GetValidItems: Boolean;
begin
 {$IFDEF Service}
 Result:= False;
 {$ELSE}
 Result := GlobalHTServer <> nil;
 {$ENDIF}
end;

constructor TalcuDictionaryComboItem.Make(const aAlias, aCaption: String; aDictID: TdaDictionaryType; aMasterItem:
    TddBaseConfigItem = nil; aMasterIndex: Integer = -1);
var
 l_Map: TalcuDictionaryMap;
 l_DefValue: TddConfigValue;
begin
 l_Map:= TalcuDictionaryMap.Make(aDictID);
 try
  l_DefValue.Kind:= dd_vkInteger;
  l_DefValue.AsInteger:= -1;
  Create(aAlias, aCaption, l_DefValue, l_Map, aMasterItem, aMasterIndex);
 finally
  l3Free(l_Map);
 end;
end;

procedure TalcuDictionaryComboItem.GetValueFromControl;
begin
 if TComboBox(Control).Text <> '' then
  Value := CalcValue(l3CStr(TComboBox(Control).Text));
end;

constructor TalcuDictionaryTreeItem.Create(const aAlias, aCaption: AnsiString; const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
begin
 inherited;    
 f_SelectedList:= Tl3LongintList.Make;
 f_Rows:= 6;
 f_Multiselect:= True;
 if Value.Kind = dd_vkObject then
  ConvertValue2Object;
end;

constructor TalcuDictionaryTreeItem.Make(const aAlias, aCaption: String; aDictID: TdaDictionaryType;
    aMultiSelect: Boolean; aRows: Integer = 5; aMasterItem: TddBaseConfigItem = nil);
begin
  Create(aAlias, aCaption, ddEmptyObjectValue, aMasterItem);
  f_DictID:= aDictID;
  f_Rows := aRows;
  f_MultiSelect:= aMultiSelect;
end;

constructor TalcuDictionaryTreeItem.Make(const aAlias, aCaption: String; aDictID: TdaDictionaryType;
    aMultiSelect: Boolean; const aDefault: String; aRows: Integer = 5; aMasterItem:
    TddBaseConfigItem = nil);
begin
  Create(aAlias, aCaption, MakeStrValue(aDefault), aMasterItem);
  f_DictID:= aDictID;
  f_Rows := aRows;
  f_MultiSelect:= aMultiSelect;
end;

procedure TalcuDictionaryTreeItem.Assign(P: TPersistent);
begin
 if P is TalcuDictionaryTreeItem then
 begin
  inherited;
  f_Value.AsObject:= f_SelectedList;
  Rows := TalcuDictionaryTreeItem(P).Rows;
  f_DictID:= TalcuDictionaryTreeItem(P).f_DictID;
  f_MultiSelect:= TalcuDictionaryTreeItem(P).f_MultiSelect;
  f_SelectedList.Assign(TalcuDictionaryTreeItem(P).f_SelectedList);
 end
 else
  inherited;
end;

procedure TalcuDictionaryTreeItem.Cleanup;
begin
 l3Free(f_SelectedList);
 inherited;
end;

function TalcuDictionaryTreeItem.ConstructControl(var aLeft, aMaxLeft, aTop: Integer; aParent: TWinControl):
    TControl;
begin
 {$IFNDEF Service}
 if GlobalHTServer <> nil then
 begin
  Result:= TvtOutliner.Create(aParent);
  Result.Height:= ControlHeight(aParent);
  with TvtOutliner(Result) do
  begin
   if (f_DictID <> da_dlNone) then
   begin
    DictServer(CurrentFamily).Family:= CurrentFamily;
    TreeStruct.RootNode := DictServer(CurrentFamily).DictRootNode[f_DictID];
   end; // (DictServer <> nil) and (f_DictID <> da_dlNone)
   MultiSelect:= f_Multiselect;
   PickedList:= True;
   OnSelectChanged:= _OnTreeChange;
  end; // TvtOutliner(Result)
 end
 else
 {$ENDIF}
  Result:= TEdit.Create(aParent);
 Result.Parent:= aParent as TWinControl;
 Result.Left:= aLeft;
 Result.Top:= aTop;
 Result.Width:= aParent.ClientWidth - aLeft - c_ConfigItemRight;
end;

function TalcuDictionaryTreeItem.ControlHeight(aParent: TWinControl): Integer;
begin
 with TvtOutliner.Create(aParent) do
 try
  Parent:= aParent;
  Result:= RowHeight*f_Rows+5;
 finally
  Free;
 end;
end;

procedure TalcuDictionaryTreeItem.ConvertValue2Object;
begin
 f_Value.Kind:= dd_vkObject;
 f_Value.AsObject:= f_SelectedList;
end;

procedure TalcuDictionaryTreeItem.GetValueFromControl;
{$IFNDEF Service}
function lp_FindNode(const Intf: Il3Node): Boolean;
var
 l_DictNode: IDictNode;
begin
 Result:= True;
 if Supports(Intf, IDictNode, l_DictNode) then
 begin
  if (f_DictID = da_dlCorSources) and not IsExtItem(Intf) then
   exit;
  if TvtOutliner(Control).CTree.SelectedNode[Intf] then
   f_SelectedList.Add(l_DictNode.Handle);
 end;
end;
{$ENDIF}
begin
 {$IFNDEF Service}
 if GlobalHTServer <> nil then
 begin
  f_SelectedList.Clear;
  TvtOutliner(Control).CTree.IterateF(l3L2NA(@lp_FindNode));
 end
 else
 {$ENDIF}
  Str2Value(TEdit(Control).Text);
 ObjectValue := f_SelectedList;
end;

function TalcuDictionaryTreeItem.IsExtItem(aNode: Il3Node): Boolean;
var
 l_ExtItem: Il3ExtItemNode;
begin
 Result := Supports(aNode, Il3ExtItemNode, l_ExtItem);
end;

procedure TalcuDictionaryTreeItem.LoadValue(const aStorage: IddConfigStorage);
begin
 Str2Value(l3Str(aStorage.ReadString(Alias, '')));
end;

procedure TalcuDictionaryTreeItem.SaveValue(const aStorage: IddConfigStorage);
begin
 aStorage.WriteString(Alias, Value2Str);
end;

procedure TalcuDictionaryTreeItem.SetValueToControl(aDefault : Boolean);
var
 l_Index: Integer;
 l_Name: String;
 l_Node: Il3Node;
{$IFNDEF Service}
function lp_FindNode(const Intf: Il3Node): Boolean;
var
 l_DictNode: IDictNode;
begin
 Result:= True;
 if Supports(Intf, IDictNode, l_DictNode) then
 begin
  if (f_DictID = da_dlCorSources) and not IsExtItem(Intf) then
   exit;
   if f_SelectedList.IndexOf(l_DictNode.Handle) <> -1 then
    TvtOutliner(Control).CTree.SelectedNode[Intf]:= true;
 end; // Supports(Intf, IDictNode, l_DictNode)
end;
{$ENDIF}
begin
 {$IFNDEF Service}
 if GlobalHTServer <> nil then
  with TvtOutliner(Control) do
  begin
   vlbDeselectAllItems;
   if aDefault then
   begin
    if DefaultValue.Kind = dd_vkString then
    begin // несколько названий элементов
     l_Name:= DefaultValue.AsString;
     l_Node:= CTree.SearchByName(CTRee.CNodes[0], PChar(l_Name), 0);
     if l_Node <> nil then
      TvtOutliner(Control).CTree.SelectedNode[l_Node]:= true;
    end
   end
   else
    if Value.Kind = dd_vkString then
    begin // несколько названий элементов
     l_Name:= Value.AsString;
     l_Node:= CTree.SearchByName(CTRee.CNodes[0], PChar(l_Name), 0);
     if l_Node <> nil then
      TvtOutliner(Control).CTree.SelectedNode[l_Node]:= true;
     ConvertValue2Object;
    end
    else
     CTree.IterateF(l3L2NA(@lp_FindNode));
  end
 else
 {$ENDIF}
  TEdit(Control).Text:= Value2Str;
end;

procedure TalcuDictionaryTreeItem.Str2Value(aStr: String);
var
 i: Integer;
 l_ID: Integer;
begin
 f_SelectedList.Clear;
 for i:= 1 to WordCount(aStr, [';',',']) do
 begin
  l_ID:= StrToIntDef(ExtractWord(i, aStr, [';',',']), 0);
  if l_ID > 0 then
   f_SelectedList.Add(l_ID);
 end;
end;

function TalcuDictionaryTreeItem.Value2Str: String;
var
 l_Index: Integer;
begin
 Result:= '';
 for l_Index:= 0 to f_SelectedList.Hi do
  Result:= Format('%s;%d', [Result, f_SelectedList.Items[l_Index]]);
 if AnsiStartsText(';', Result) then
  Delete(Result, 1, 1);
end;

procedure TalcuDictionaryTreeItem._OnTreeChange(Sender: TObject; Index : LongInt; var SelectedState : Integer);
begin
  Changed:= True;
end;

procedure TalcuDictComboTreeItem.AdjustReadOnly(aControl: TControl);
begin
 if aControl is TalcuTreeComboBox then
  TalcuTreeComboBox(aControl).ReadOnly := ReadOnly;
 if aControl is TEdit then
  TEdit(aControl).ReadOnly := ReadOnly;
end;

function TalcuDictComboTreeItem.ConstructControl(var aLeft, aMaxLeft, aTop: Integer; aParent: TWinControl): TControl;
begin
 {$IFNDEF Service}
 if GlobalHTServer <> nil then
 begin
  Result := TalcuTreeComboBox.Create(aParent);
  with TalcuTreeComboBox(Result) do
  begin
   Style       := csDropDownList;
   SizeableTree:= False;
   ShowGripper := False;
   OnChange    := _OnChange;
   DictServer(CurrentFamily).Family:= CurrentFamily;
   RootNode := DictServer(CurrentFamily).DictRootNode[f_DictID];
   { Добавить мнимый узел
   1. Получить от RootNode I3Node
   2. Создать узел с помощью l3Nodes.MakeNode
   3. Вставать в RootNode InsertChildBefore
   }
  end; // with TalcuTreeComboBox(Result)
 end
 else
 {$ENDIF}
  Result := TEdit.Create(aParent);
 with Result do
 begin
  Parent      := aParent;
  Top         := aTop;
  Left        := aLeft;
  Width       := aParent.ClientWidth - aLeft - c_ConfigItemRight;
 end; // with Result
end;

function TalcuDictComboTreeItem.ControlHeight(aParent: TWinControl): Integer;
var
  lComboBox: TvtComboTree;
begin
  lComboBox := TvtComboTree.Create(nil);
  try
   lComboBox.Parent := aParent;
   Result := lComboBox.Height;
  finally
   FreeAndNil(lComboBox);
  end;
end;

procedure TalcuDictComboTreeItem.GetValueFromControl;
{$IFNDEF Service}
var
 l_DictNode: IDictNode;
 l_Ext: Il3ExtItemNode;
{$ENDIF}
begin
 f_SelectedList.Clear;
 {$IFNDEF Service}
 if GlobalHTServer <> nil then
 begin
  if (f_DictID <> da_dlCorSources) or
     ((f_DictID = da_dlCorSources) and Supports(TalcuTreeComboBox(Control).CurrentNode, Il3ExtItemNode, l_Ext)) then
   if Supports(TalcuTreeComboBox(Control).CurrentNode, IDictNode, l_DictNode) then
    f_SelectedList.Add(l_DictNode.Handle)
 end
 else
 {$ENDIF}
  f_SelectedList.Add(StrToIntDef(TEdit(Control).Text, 0));
end;

procedure TalcuDictComboTreeItem.SetValueToControl(aDefault: Boolean);
{$IFNDEF Service}
function lp_FindNode(const Intf: Il3Node): Boolean;
var
 l_DictNode: IDictNode;
begin
 Result:= True;
 if Supports(Intf, IDictNode, l_DictNode) then
 begin
  if (f_DictID = da_dlCorSources) and not IsExtItem(Intf) then
   exit;
  if l_DictNode.Handle = f_SelectedList.First then
  begin
   TalcuTreeComboBox(Control).CurrentNode:= Intf;
   Result:= False;
  end; // f_SelectedList.IndexOf(l_DictNode.Handle) <> -1
 end; // Supports(Intf, IDictNode, l_DictNode)
end;
{$ENDIF}
begin
 if not f_SelectedList.Empty then
  {$IFNDEF Service}
  if (GlobalHTServer <> nil) then
  begin
   if f_DictID = da_dlCorSources then
   begin
    l3IterateSubTreeF(DictServer(CurrentFamily).Dict[f_DictID].RootNode, l3L2NA(@lp_FindNode));
    //DictServer(CurrentFamily).Dict[f_DictID].RootNode.IterateF(l3L2NA(@lp_FindNode));
   end
   else
    TalcuTreeComboBox(Control).CurrentNode := DictServer(CurrentFamily).Dict[f_DictID].FindNodeByID(f_SelectedList.First)
  end
  else
  {$ENDIF}
   TEdit(Control).Text:= IntToStr(f_SelectedList.Items[0])
end;

procedure TalcuDictComboTreeItem._OnChange(Sender: TObject);
begin
 Changed:= True;
end;

{
****************************** TalcuSchedulerNode ******************************
}
constructor TalcuSchedulerNode.Create(const aAlias, aCaption: String);
{1 Создание узла "Задания" }
begin
  inherited Create(aAlias, aCaption);
  f_Scheduler:= TddScheduler.Create;
end;

procedure TalcuSchedulerNode.DoClearControls;
begin
  f_Frame:= nil;
end;

function TalcuSchedulerNode.DoCreateFrame(aOwner: TComponent; aTag: Integer): TCustomFrame;
begin
  f_Frame:= TSchedulerFrame.Create(aOwner);
  Result:= f_Frame;
end;

procedure TalcuSchedulerNode.DoFrameSize(aParent: TWinControl; out aHeight,
        aWidth: Integer);
begin
  aHeight:= 300;
  aWidth:= 390;
end;

procedure TalcuSchedulerNode.DoGetControlValues;
{1 Считывание списка заданий из окна конфигурации }
begin
  f_Scheduler.Assign(f_Frame.ConfigScheduler);
end;

function TalcuSchedulerNode.pm_GetValue: TddConfigValue;
begin
 Result:= ddEmptyValue;
 Result.Kind:= dd_vkObject;
 Result.AsObject:= f_Scheduler;
end;

function TalcuSchedulerNode.IsRequired(out aMessage: String): Boolean;
begin
 Result := f_Scheduler.IsRequredViolated(aMessage);
end;

procedure TalcuSchedulerNode.LoadValue(const aStorage: IddConfigStorage);
{1 Загрузка списка заданий }
begin
  f_Scheduler.LoadFrom(aStorage, Alias);
end;

function TalcuSchedulerNode.pm_GetChanged: Boolean;
begin
 Result := f_Scheduler.IsChanged;
end;

procedure TalcuSchedulerNode.pm_SetChanged(Value: Boolean);
begin
 if Value <> f_Scheduler.IsChanged then
 begin
  f_Scheduler.IsChanged := Value;
 end;
 inherited;
end;

procedure TalcuSchedulerNode.PostEdit;
begin
 f_Scheduler.PostChanges;
end;

procedure TalcuSchedulerNode.Release;
begin
  f_Scheduler.Free;
  inherited Release;
end;

procedure TalcuSchedulerNode.SaveValue(const aStorage: IddConfigStorage);
{1 Сохранение списка заданий }
begin
  f_Scheduler.SaveTo(aStorage, Alias);
end;

procedure TalcuSchedulerNode.DoSetControlValues(aDefault: Boolean);
{1 Установка списка заданий в окно конфигурации }
begin
  f_Frame.ConfigScheduler:= f_Scheduler;
end;

procedure TalcuSchedulerNode.pm_SetValue(const Value: TddConfigValue);
begin
end;

constructor TalcuQueryComboboxItem.Make(const aAlias, aCaption: String; aMasterItem:
    TddBaseConfigItem = nil; aMasterIndex: Integer = -1);
var
 l_Map: TalcuQueryMap;
 l_DefValue: TddConfigValue;
begin
 l_Map:= TalcuQueryMap.Make;
 try
  l_DefValue.Kind:= dd_vkString;
  l_DefValue.AsString:= '';
  Create(aAlias, aCaption, l_DefValue, l_Map, aMasterItem, aMasterIndex);
 finally
  l3Free(l_Map);
 end;
end;

procedure TalcuQueryComboboxItem.GetValueFromControl;
begin
 if TComboBox(Control).Text <> '' then
  Value := CalcValue(l3CStr(TComboBox(Control).Text));
end;

constructor TalcuQueryMap.Make;
var
 l_Rec: Tl3ValueMapID;
begin
 l_Rec.rName:= 'QueryList';
 l_Rec.rID:= 1;
 Create(l_Rec);
 f_QueryList:= TQueryList.Make;
end;

procedure TalcuQueryMap.Cleanup;
begin
 FreeAndNil(f_QueryList);
 inherited;
end;

function TalcuQueryMap.DisplayNameToValue(const aDisplayName: Il3CString): Il3CString;
var
 i: integer;
begin
 Result:= nil;
 for i:= 0 to f_QueryList.Hi do
  if  l3Same(f_QueryList[i].Name, aDisplayName) then
  begin
   Result:= l3CStr(f_QueryList[i].FileName);
   exit;
  end;
end;

procedure TalcuQueryMap.DoGetDisplayNames(const aList: Il3StringsEx);
var
 l_Index: Integer;
begin
 inherited;
 ReloadQueries;
 for l_Index := 0 to f_QueryList.Hi Do
  aList.Add(l3CStr(f_QueryList[l_Index].Name));
end;

function TalcuQueryMap.GetMapSize: Integer;
begin
 ReloadQueries;
 Result:= f_QueryList.Count;
end;

procedure TalcuQueryMap.ReloadQueries;
begin
 {$IFDEF UserQuery}
 f_QueryList.QueriesPath:= ddAppConfiguration.AsString['sqFolder'];
 f_QueryList.LoadAsksList;
 {$endif}
end;

function TalcuQueryMap.ValueToDisplayName(const aValue: Il3CString): Il3CString;
var
 i: integer;
begin
 Result:= l3CStr('Выберите запрос на поиск');
 ReloadQueries;
 for i:= 0 to f_QueryList.Hi do
  if  l3Same(f_QueryList[i].FileName, aValue) then
  begin
   Result:= l3CStr(f_QueryList[i].Name);
   exit;
  end;
end;

constructor TalcuQueryCheckListItem.Create(const aAlias, aCaption: AnsiString; const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
var
 i: Integer;
begin
 inherited;
 f_QueryList:= TQueryList.Make;
 f_QueryList.QueriesPath:= ddAppConfiguration.AsString['sqFolder'];
 f_QueryList.LoadAsksList;
 for i:= 0 to f_QueryList.Hi do
  Add(f_QueryList.Items[i].Name);
end;

procedure TalcuQueryCheckListItem.Cleanup;
begin
 FreeAndNil(f_QueryList);
 inherited;
end;

procedure TalcuEmailAdapter.ClearItems;
begin
 Assert(False, 'ClearItems don''t implemented');
end;

{ TalcuAsyncRunTaskItem }

procedure TalcuAsyncRunTaskItem._OnTreeChange(Sender: TObject;
  Index: Integer; var SelectedState: Integer);
begin
  Changed:= True;
end;

procedure TalcuAsyncRunTaskItem.Assign(P: TPersistent);
begin
 if P is TalcuAsyncRunTaskItem then
 begin
  inherited;
  f_Value.AsObject:= f_List;
  Rows := TalcuAsyncRunTaskItem(P).Rows;
  f_List.Assign(TalcuAsyncRunTaskItem(P).f_List);
 end
 else
  inherited;
end;

procedure TalcuAsyncRunTaskItem.Cleanup;
begin
 l3Free(f_List);
 inherited;
end;

function TalcuAsyncRunTaskItem.ConstructControl(var aLeft, aMaxLeft,
  aTop: Integer; aParent: TWinControl): TControl;
begin
 {$IFNDEF Service}
  Result:= TvtOutliner.Create(aParent);
  Result.Height:= ControlHeight(aParent);
  with TvtOutliner(Result) do
  begin
   TreeStruct.RootNode := MakeTaskTree;
   MultiSelect:= True;
   PickedList:= True;
   OnSelectChanged:= _OnTreeChange;
  end; // TvtOutliner(Result)
 {$ELSE}
  Result:= TEdit.Create(aParent);
 {$ENDIF}
 Result.Parent:= aParent as TWinControl;
 Result.Left:= aLeft;
 Result.Top:= aTop;
 Result.Width:= aParent.ClientWidth - aLeft - c_ConfigItemRight;
end;

function TalcuAsyncRunTaskItem.ControlHeight(
  aParent: TWinControl): Integer;
begin
 with TvtOutliner.Create(aParent) do
 try
  Parent:= aParent;
  Result:= RowHeight*f_Rows+5;
 finally
  Free;
 end;
end;

procedure TalcuAsyncRunTaskItem.ConvertValue2Object;
begin
 f_Value.Kind:= dd_vkObject;
 f_Value.AsObject:= f_List;
end;

constructor TalcuAsyncRunTaskItem.Create(const aAlias,
  aCaption: AnsiString; const aDefaultValue: TddConfigValue;
  aMasterItem: TddBaseConfigItem);
begin
 inherited;    
 f_List:= Tl3LongintList.Make;
 f_Rows:= 6;
 if Value.Kind = dd_vkObject then
  ConvertValue2Object;
end;

procedure TalcuAsyncRunTaskItem.GetValueFromControl;
{$IFNDEF Service}
function lp_FindNode(const Intf: Il3Node): Boolean;
var
 l_Node: Il3HandleNode;
begin
 Result:= True;
 if (Intf.ParentNode <> nil) and TvtOutliner(Control).CTree.SelectedNode[Intf] and Supports(Intf, Il3HandleNode, l_Node) then
  f_List.Add(l_Node.Handle);
end;
{$ENDIF}
begin
 {$IFNDEF Service}
 f_List.Clear;
 TvtOutliner(Control).CTree.IterateF(l3L2NA(@lp_FindNode));
 {$ELSE}
 Str2Value(TEdit(Control).Text);
 {$ENDIF}
 ObjectValue := f_List;
end;

procedure TalcuAsyncRunTaskItem.LoadValue(
  const aStorage: IddConfigStorage);
begin
 Str2Value(l3Str(aStorage.ReadString(Alias, '')));
end;

constructor TalcuAsyncRunTaskItem.Make(const aAlias, aCaption: String;
  aRows: Integer; aMasterItem: TddBaseConfigItem);
begin
  Create(aAlias, aCaption, ddEmptyObjectValue, aMasterItem);
  f_Rows := aRows;
end;

procedure TalcuAsyncRunTaskItem.SaveValue(
  const aStorage: IddConfigStorage);
begin
 aStorage.WriteString(Alias, Value2Str);
end;

procedure TalcuAsyncRunTaskItem.SetValueToControl(aDefault: Boolean);
var
 l_Index: Integer;
 l_Name: String;
 l_Node: Il3Node;
{$IFNDEF Service}
function lp_FindNode(const Intf: Il3Node): Boolean;
var
 l_Node: Il3HandleNode;
begin
 Result:= True;
 if Supports(Intf, Il3HandleNode, l_Node) then
 begin
  if f_List.IndexOf(l_Node.Handle) <> -1 then
   TvtOutliner(Control).CTree.SelectedNode[Intf]:= True;
 end; // Supports(Intf, IDictNode, l_DictNode)
end;
{$ENDIF}
begin
 {$IFNDEF Service}
  with TvtOutliner(Control) do
  begin
   vlbDeSelectAllItems;
   if aDefault then
   begin
    if DefaultValue.Kind = dd_vkString then
    begin // несколько названий элементов
     l_Name:= DefaultValue.AsString;
     l_Node:= CTree.SearchByName(CTRee.CNodes[0], PChar(l_Name), 0);
     if l_Node <> nil then
      TvtOutliner(Control).CTree.SelectedNode[l_Node]:= True;
    end
   end
   else
    if Value.Kind = dd_vkString then
    begin // несколько названий элементов
     l_Name:= Value.AsString;
     l_Node:= CTree.SearchByName(CTRee.CNodes[0], PChar(l_Name), 0);
     if l_Node <> nil then
      TvtOutliner(Control).CTree.SelectedNode[l_Node]:= True;
     ConvertValue2Object;
    end
    else
     CTree.IterateF(l3L2NA(@lp_FindNode));
  end
 {$ELSE}
  TEdit(Control).Text:= Value2Str;
 {$ENDIF}
end;

procedure TalcuAsyncRunTaskItem.Str2Value(aStr: String);
var
 i: Integer;
 l_ID: Integer;
 l_Type: Tk2Type;
begin
 f_List.Clear;
 for i:= 1 to WordCount(aStr, [';',',']) do
 begin
  l_Type := K2.TypeTable.TypeByName[ExtractWord(i, aStr, [';',','])];
  if l_Type <> nil then
   f_List.Add(l_Type.ID);
 end;
end;

function TalcuAsyncRunTaskItem.Value2Str: String;
var
 l_Index: Integer;
begin
 Result:= '';
 for l_Index:= 0 to f_List.Hi do
  Result:= Format('%s;%s', [Result,  K2.TypeTable.TypeByHandle[f_List.Items[l_Index]].AsString]);
 if AnsiStartsText(';', Result) then
  Delete(Result, 1, 1);
end;

function TalcuAsyncRunTaskItem.MakeTaskTree: Il3SimpleRootNode;
var
  l_IDX: TcsTaskType;
  l_TaskClass: TddTaskClass;
  l_Description: AnsiString;
  l_RootNode: Tl3UsualNode;
  l_Node: Tl3UsualNode;
begin
  l_RootNode := Tl3UsualNode.Create;
  try
    l_RootNode.Text := l3PCharLen('TaskRoot');
    for l_IDX := Low(l_IDX) to High(l_IDX) do
    begin
      l_TaskClass := TddTaskClassManager.Instance.GetClass(l_IDX, l_Description);
      if Assigned(l_TaskClass) and l_TaskClass.CanAsyncRun then
      begin
        l_Node := Tl3UsualNode.Create;
        try
          l_Node.Text := l3PCharLen(l_Description);
          l_Node.Handle := l_TaskClass.TaskTaggedDataType.ID;
          Il3Node(l_RootNode).InsertChild(l_Node);
        finally
          FreeAndNil(l_Node);
        end;
      end;
    end;
    Result := l_RootNode;
  finally
    FreeAndNil(l_RootNode);
  end;
end;

constructor TalcuWeekChecklineItem.Create(const aAlias, aCaption: AnsiString; const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem);
begin
 inherited Create(aAlias, aCaption, aDefaultValue, aMasterItem);
end;

constructor TalcuWeekChecklineItem.Make(const aAlias, aCaption: AnsiString; aMasterItem: TddBaseConfigItem = nil);
const
 cFullWeekValue : TddConfigValue = (Kind: dd_vkInteger; AsInteger: $7F);
begin
 Create(aAlias, aCaption, cFullWeekValue, aMasterItem);
 LabelTop := True;
end;

function TalcuWeekChecklineItem.ConstructControl(var aLeft, aMaxLeft, aTop: Integer; aParent: TWinControl): TControl;
const
 cWeekLabels: array [1..7] of string = ('Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс');
var
 I: Integer;
 l_Box: TCheckBox;
 l_CaptWidth: Integer;
 l_CurLeft: Integer;
 l_Lbl: TLabel;
begin
 Result := TPanel.Create(aParent);
 Result.Left := aLeft;
 Result.Top  := aTop;
 Result.Width := aMaxLeft - aLeft;
 Result.Parent := aParent;
 TPanel(Result).BorderStyle := bsNone;
 TPanel(Result).BevelInner := bvNone;
 TPanel(Result).BevelOuter := bvNone;
 //TPanel(Result).Color := clGreen;
 l_Lbl := TLabel.Create(nil);
 try
  l_Lbl.Parent := TPanel(Result);
  l_Lbl.Caption := 'ЖЖ';
  l_CaptWidth := l_Lbl.Width;
 finally
  FreeAndNil(l_Lbl);
 end;
 l_CurLeft := 2;
 for I := 1 to 7 do
 begin
  l_Box := TCheckBox.Create(aParent);
  l_Box.Parent := TPanel(Result);
  l_Box.Caption := cWeekLabels[I];
  l_Box.Top := 2;
  l_Box.Left := l_CurLeft;
  if I > 5 then
   l_Box.Font.Color := clRed;
  l_Box.Width := GetSystemMetrics(SM_CXMENUCHECK) + 4 + l_CaptWidth + 10;
  l_CurLeft := l_CurLeft + l_Box.Width;
  f_Boxes[I] := l_Box;
 end;
 Result.Height := 4 + l_Box.Height;
 Result.Width := l_Box.Left + l_Box.Width + 20;
end;

function TalcuWeekChecklineItem.ControlHeight(aParent: TWinControl): Integer;
begin
 with TCheckBox.Create(aParent) do
 try
  Parent := aParent;
  Result := Height + 4 {gap};
 finally
  Free;
 end;
end;

procedure TalcuWeekChecklineItem.DoEnabled;
var
 I: Integer;
begin
 inherited DoEnabled;
 if Control <> nil then
  for I := 1 to 7 do
   f_Boxes[I].Enabled := Enabled;
end;

procedure TalcuWeekChecklineItem.GetValueFromControl;
var
 l_Value: TddConfigValue;
 I : Integer;
begin
 l_Value.Kind := dd_vkInteger;
 l_Value.AsInteger := 0;
 for I := 1 to 7 do
  if f_Boxes[I].Checked then
   l3SetBit(l_Value.AsInteger, I-1);
 Value := l_Value;
end;

procedure TalcuWeekChecklineItem.SetValueToControl(aDefault: Boolean);
var
 I: Integer;
 l_Value: Integer;
begin
 l_Value := Value.AsInteger;
 for I := 1 to 7 do
  f_Boxes[I].Checked := l3TestBit(l_Value, I-1);
end;

procedure TalcuDictionaryTreeItem.AdjustReadOnly(aControl: TControl);
begin
 if aControl is TvtOutliner then
  TvtOutliner(aControl).ReadOnly := ReadOnly;
 if aControl is TEdit then
  TEdit(aControl).ReadOnly := ReadOnly;
end;

procedure TalcuAsyncRunTaskItem.AdjustReadOnly(aControl: TControl);
begin
 if aControl is TvtOutliner then
  TvtOutliner(aControl).ReadOnly := ReadOnly;
 if aControl is TEdit then
  TEdit(aControl).ReadOnly := ReadOnly;
end;

procedure TalcuWeekChecklineItem.AdjustReadOnly(aControl: TControl);
var
 I: Integer;
begin
 for I := 1 to 7 do
  f_Boxes[I].Enabled := not ReadOnly;
end;

{ TalcuUserListMap }

procedure TalcuUserListMap.Cleanup;
begin
  FreeAndNil(f_UserList);
  inherited;
end;

function TalcuUserListMap.DoDisplayNameToValue(
  const aDisplayName: Il3CString): Integer;
var
 i: Integer;
 l_Value: String;
begin
 {$IFNDEF Service}
 if ValidItems then
 begin
  Result := usServerService;
  l_Value := l3Str(aDisplayName);
  for i := 0 to f_UserList.Count - 1 do
   if f_UserList[i] = l_Value then
    Result:= Integer(f_UserList.Objects[i]);
 end
 else
 {$ENDIF}
  Result:= usServerService
end;

procedure TalcuUserListMap.DoGetDisplayNames(const aList: Il3StringsEx);
var
 i: Integer;
begin
 inherited;
 {$IFNDEF Service}
 if ValidItems then
  for i := 0 to f_UserList.Count - 1 do
   aList.Add(l3CStr(f_UserList[i]));
 {$ENDIF}
end;

function TalcuUserListMap.DoValueToDisplayName(
  aValue: Integer): Il3CString;
var
 i: Integer;
begin
 Result:= nil;
 {$IFNDEF Service}
 if ValidItems then
 begin
  for i:= 0 to f_UserList.Count - 1  do
   if Integer(f_UserList.Objects[i]) = aValue then
    Result:= l3CStr(f_UserList[i]);
 end;
 {$ENDIF}
end;

function TalcuUserListMap.GetMapSize: Integer;
begin
 {$IFNDEF Service}
 if ValidItems then
 begin
//  RefreshList;
  Result := f_UserList.Count + 1
 end
 else
 {$ENDIF}
  Result:= 0;
end;

constructor TalcuUserListMap.Make;
var
 l_Rec: Tl3ValueMapID;
begin
 l_Rec.rName:= 'Пользователи';
 l_Rec.rID:= Ord(mtUsers);
 Create(l_Rec, TypeInfo(Integer));
 f_UserList := TStringList.Create;
end;

function TalcuUserListMap.pm_GetValidItems: Boolean;
begin
 {$IFDEF Service}
 Result:= False;
 {$ELSE}
 Result := GlobalHTServer <> nil;
 {$ENDIF}
end;

procedure TalcuUserListMap.RefreshList;
begin
 if UserManager <> nil then
  UserManager.GetFiltredUserList(f_UserList);
end;

{ TalcuUserListComboItem }

procedure TalcuUserListComboItem.CheckLoadItems;
begin
 f_Map.RefreshList;
 inherited;
end;

procedure TalcuUserListComboItem.Cleanup;
begin
  FreeAndNil(f_Map);
  inherited;
end;

procedure TalcuUserListComboItem.GetValueFromControl;
begin
 if TComboBox(Control).Text <> '' then
  Value := CalcValue(l3CStr(TComboBox(Control).Text));
end;

constructor TalcuUserListComboItem.Make(const aAlias, aCaption: String;
  aMasterItem: TddBaseConfigItem; aMasterIndex: Integer);
var
 l_DefValue: TddConfigValue;
begin
 f_Map:= TalcuUserListMap.Make;
 l_DefValue.Kind:= dd_vkInteger;
 l_DefValue.AsInteger:= usServerService;
 Create(aAlias, aCaption, l_DefValue, f_Map, aMasterItem, aMasterIndex);
end;

end.
