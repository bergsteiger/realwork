unit vcmMessagesCollectionItem;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmMessagesCollectionItem - }
{ Начат: 21.02.2003 16:19 }
{ $Id: vcmMessagesCollectionItem.pas,v 1.36 2013/04/25 14:22:38 lulin Exp $ }

// $Log: vcmMessagesCollectionItem.pas,v $
// Revision 1.36  2013/04/25 14:22:38  lulin
// - портируем.
//
// Revision 1.35  2012/04/28 10:38:51  lulin
// {RequestLink:361404275}
//
// Revision 1.34  2012/04/27 15:57:56  lulin
// {RequestLink:361404275}
//
// Revision 1.33  2011/12/08 16:30:03  lulin
// {RequestLink:273590436}
// - чистка кода.
//
// Revision 1.32  2011/06/27 16:50:19  lulin
// {RequestLink:254944102}.
// - чистим мусорок.
//
// Revision 1.31  2011/06/27 14:56:41  lulin
// {RequestLink:254944102}.
// [$271749095].
//
// Revision 1.30  2011/02/28 14:08:36  lulin
// {RequestLink:254944075}.
// - чистка кода.
//
// Revision 1.29  2011/02/11 18:16:33  vkuprovich
// {RequestLink:253231185]
//
// Revision 1.28  2011/02/07 18:34:27  vkuprovich
// {RequestLink:252519379]
// Чекбокс умеет умеет запоминать дефолтный выбор.
//
// Revision 1.27  2009/12/07 15:29:57  oman
// - new: {RequestLink:171542365}
//
// Revision 1.26  2009/02/20 13:07:06  lulin
// - <K>: 136941122.
//
// Revision 1.25  2008/10/10 08:52:48  oman
// - fix: Требуем уникальности имени (К-121146270)
//
// Revision 1.24  2008/07/15 12:46:04  lulin
// - <K>: 100958755.
//
// Revision 1.23  2008/07/15 09:48:27  oman
// - new: Перестриваим ширину кнопок в запросах по требованию (К-96484708)
//
// Revision 1.22  2008/07/15 09:02:58  oman
// - new: Выбираем кнопку для закрытия подтверждения крестиком (К-100008730)
//
// Revision 1.20  2008/07/09 16:13:23  lulin
// - <K>: 100008415.
//
// Revision 1.19  2008/07/09 13:02:25  lulin
// - добавлен список выборов, <K>: 100008415.
//
// Revision 1.18  2008/07/09 12:47:27  lulin
// - чистка кода.
//
// Revision 1.17  2008/07/08 13:41:18  lulin
// - чистка кода.
//
// Revision 1.16  2007/03/16 13:56:54  lulin
// - переходим на собственную функцию форматирования строк.
//
// Revision 1.15  2006/11/03 11:00:32  lulin
// - объединил с веткой 6.4.
//
// Revision 1.14.6.2  2006/10/18 08:36:28  lulin
// - выливаем подсказки для сообщений.
//
// Revision 1.14.6.1  2006/10/18 08:00:31  lulin
// - заголовок для настроек приобрел общее название.
//
// Revision 1.14  2006/04/06 14:43:55  dinishev
// Переделка диалога с дополнительной кнопкой
//
// Revision 1.13  2006/04/06 06:05:14  oman
// - new beh: В мессагах уделен Key, переименован ShortCaption => _ControlCaption,
//  добавлен _ControlHint
//
// Revision 1.12  2006/03/23 13:31:00  lulin
// - cleanup.
//
// Revision 1.11  2004/09/02 14:25:45  law
// - new behavior: не добавляем к сообщению пунктуацию или оно уже заканчивается пунктуацией (CQ OIT5-7840).
//
// Revision 1.10  2004/06/10 14:22:40  mmorozov
// new: TvcmMessageCategory = AnsiString;
// new: property TvcmMessagesCollectionItem._Category;
// new: property TvcmMessagesCollectionItem._ControlCaption;
// new: method TvcmMessagesCollectionItem.VisibleControlCaption;
// new: method TvcmMessagesCollectionItem.IsStoredControlCaption;
//
// Revision 1.9  2004/02/18 10:24:08  am
// *** empty log message ***
//
// Revision 1.8  2004/02/18 09:40:29  am
// *** empty log message ***
//
// Revision 1.7  2004/01/30 16:29:55  law
// - new behavior: не даем установить диалогу mtConfirmation меньше 2-х кнопок.
//
// Revision 1.6  2004/01/30 13:10:58  law
// - new prop: TvcmMessagesCollectionItem.NeedCheck.
//
// Revision 1.5  2004/01/28 13:58:12  law
// - new prop: TvcmMessagesCollectionItem._VisibleCaption.
//
// Revision 1.4  2004/01/28 10:44:48  law
// - new behavior: устанавливаем Buttons при установке DlgType.
//
// Revision 1.3  2004/01/28 07:45:28  law
// - new prop: TvcmMessagesCollectionItem.HelpCtx.
//
// Revision 1.2  2004/01/28 07:33:36  law
// - new props: TvcmMessagesCollectionItem.DlgType, Buttons.
//
// Revision 1.1  2004/01/27 16:52:57  law
// - new units: vcmMessagesCollection, vcmMessagesCollectionItem.
//

{$Include vcmDefine.inc }

interface

uses
  Classes,
  Dialogs,

  l3VCLStrings,

  vcmExternalInterfaces,
  vcmInterfaces,
  vcmBaseCollectionItem
  ;

type
  TvcmMessagesCollectionItem = class(TvcmBaseCollectionItem)
    private
    // internal fields
      f_DlgType             : TMsgDlgType;
      f_Buttons             : TMsgDlgButtons;
      f_HelpCtx             : Integer;
      f_NeedCheck           : Boolean;
      f_ControlCaption      : AnsiString;
      f_ControlHint         : AnsiString;
      f_CustomButtonCaption : AnsiString;
      f_CancelButton        : TMsgDlgBtn;
      f_DefaultButton       : TMsgDlgBtn;
    protected
    // property methods
      procedure pm_SetDlgType(aValue: TMsgDlgType);
        {-}
      procedure pm_SetButtons(aValue: TMsgDlgButtons);
        {-}
      procedure pm_SetControlCaption(const Value: AnsiString);
        {-}
      procedure ChangeCaption(const anOld, aNew: AnsiString);
        override;
        {-}
{$IfDef DesignTimeLibrary}
      procedure ChangeName(const anOld, aNew: AnsiString);
        override;
        {-}
{$EndIf DesignTimeLibrary}
      function IsStoredControlCaption : Boolean;
        {-}
      function IsStoredControlHint : Boolean;
        {-}
    protected
    // internal methods
      function ButtonsCount(aButtons: TMsgDlgButtons): Integer;
        {-}
      function ButtonsStored: Boolean;
        {-}
      function DefaultButtons: TMsgDlgButtons;
        {-}
      function DefaultNeedCheck: Boolean;
        {-}
      function NeedCheckStored: Boolean;
        {-}
    public
    // public methods
      constructor Create(Collection: TCollection);
        override;
        {-}
    published
    // published properties
      property DlgType : TMsgDlgType
        read f_DlgType
        write pm_SetDlgType
        default mtCustom;
        {-}
      property Buttons: TMsgDlgButtons
        read f_Buttons
        write pm_SetButtons
        stored ButtonsStored;
      property HelpCtx : Integer
        read f_HelpCtx
        write f_HelpCtx
        default 0;
        {-}
      property NeedCheck: Boolean
        read f_NeedCheck
        write f_NeedCheck
        stored NeedCheckStored;
        {-}
      property SettingsCaption : AnsiString
        read f_ControlCaption
        write pm_SetControlCaption
        stored IsStoredControlCaption;
        {* - короткое название сообщения, используется при редактировании выбора
             пользователя в настройках. }
      property LongHint : AnsiString
        read f_ControlHint
        write f_ControlHint
        stored IsStoredControlHint;
        {* - хинт сообщения, используется при редактировании выбора
             пользователя в настройках. }
      property CustomButtonCaption : AnsiString
        read f_CustomButtonCaption
        write f_CustomButtonCaption;
        {* - текст для дополнительной кнопки. }
      property CancelButton: TMsgDlgBtn
        read f_CancelButton
        write f_CancelButton
        default mbCancel;
        {* - Какая кнопка будет считаться Cancel - ESC и крестик }
      property DefaultButton: TMsgDlgBtn
        read f_DefaultButton
        write f_DefaultButton
        default mbOk;
        {* - Какая кнопка будет считаться умолчательной }
  end;//TvcmMessagesCollectionItem

implementation

uses
  SysUtils,
  
  {$IfDef vcmNeedL3}
  l3String,
  {$EndIf vcmNeedL3}
  
{$IfDef DesignTimeLibrary}
  vcmMessagesCollection,
  RtlConsts,
{$EndIf DesignTimeLibrary}

  vcmBase
  ;

// start class TvcmMessagesCollectionItem

constructor TvcmMessagesCollectionItem.Create(Collection: TCollection);
  //override;
  {-}
begin
 inherited Create(Collection);
 DlgType := mtCustom;
 Buttons := DefaultButtons;
 HelpCtx := 0;
 CancelButton := mbCancel;
 DefaultButton := mbOk;
end;

procedure TvcmMessagesCollectionItem.pm_SetDlgType(aValue: TMsgDlgType);
  {-}
begin
 if (f_DlgType <> aValue) then
 begin
  f_DlgType := aValue;
  Buttons := DefaultButtons;
 end;//f_DlgType <> aValue
end;

procedure TvcmMessagesCollectionItem.pm_SetButtons(aValue: TMsgDlgButtons);
  {-}
begin
 if (f_Buttons <> aValue) then
 begin
  if (ButtonsCount(aValue) <= 1) AND (DlgType = mtConfirmation) then
   Exit;
  f_Buttons := aValue;
  NeedCheck := DefaultNeedCheck;
 end;//f_Buttons <> aValue
end;

function TvcmMessagesCollectionItem.ButtonsStored: Boolean;
  {-}
begin
 Result := Buttons <> DefaultButtons;
end;

function TvcmMessagesCollectionItem.DefaultButtons: TMsgDlgButtons;
  {-}
begin
 Case DlgType of
  mtWarning,
  mtInformation,
  mtError,
  mtCustom :
   Result := [mbOk];
  mtConfirmation :
   Result := [mbYes, mbNo];
  else
   Result := [mbOk];
 end;//Case DlgType
end;

function TvcmMessagesCollectionItem.ButtonsCount(aButtons: TMsgDlgButtons): Integer;
  {-}
var
 l_Index : TMsgDlgBtn;
begin
 Result := 0;
 for l_Index := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
 begin
  if (l_Index in aButtons) then
   Inc(Result);
 end;//for l_Index
end;

function TvcmMessagesCollectionItem.DefaultNeedCheck: Boolean;
  {-}
begin
 Result := (ButtonsCount(Buttons) > 1);
end;

function TvcmMessagesCollectionItem.NeedCheckStored: Boolean;
  {-}
begin
 Result := (NeedCheck <> DefaultNeedCheck);
end;

procedure TvcmMessagesCollectionItem.pm_SetControlCaption(const Value : AnsiString);
  {-}
begin
 if f_ControlCaption = f_ControlHint then
  f_ControlHint := Value;
 f_ControlCaption := Value;
end;

procedure TvcmMessagesCollectionItem.ChangeCaption(const anOld, aNew: AnsiString);
begin
 if anOld = f_ControlCaption then  
  f_ControlCaption := aNew;
end;

function TvcmMessagesCollectionItem.IsStoredControlCaption: Boolean;
begin
 Result := Caption <> SettingsCaption;
end;

function TvcmMessagesCollectionItem.IsStoredControlHint: Boolean;
begin
 Result := SettingsCaption <> LongHint;
end;

{$IfDef DesignTimeLibrary}
procedure TvcmMessagesCollectionItem.ChangeName(const anOld, aNew: AnsiString);
var
 l_IDX: Integer;
begin
 if (aNew <> '') and (Collection <> nil) and (Collection is TvcmMessagesCollection) then
  with TvcmMessagesCollection(Collection) do
   for l_IDX := 0 to Count - 1 do
    if (Items[l_IDX] <> Self) and (ANSISameText(Items[l_IDX].Name, aNew)) then
     raise EComponentError.CreateResFmt(@SDuplicateName, ['Messages.' + aNew]);
 inherited;
end;
{$EndIf DesignTimeLibrary}

end.

