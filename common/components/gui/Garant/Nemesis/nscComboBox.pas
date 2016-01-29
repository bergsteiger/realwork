unit nscCombobox;
{* }

{ $Id: nscComboBox.pas,v 1.3 2015/07/28 13:31:31 lulin Exp $ }

// $Log: nscComboBox.pas,v $
// Revision 1.3  2015/07/28 13:31:31  lulin
// - рефакторинг работы с типами.
//
// Revision 1.2  2015/03/12 10:12:54  lulin
// - перетряхиваем слова.
//
// Revision 1.1  2013/08/15 10:28:22  kostitsin
// nscCombobox.pas -> nscComboBox.pas
//
// Revision 1.60  2011/01/29 16:35:00  lulin
// {RequestLink:228688602}.
// - вычищаем мусор.
//
// Revision 1.59  2009/11/09 11:20:55  lulin
// - промежуточный коммит избавления от внутренних операций без параметров.
//
// Revision 1.58  2009/01/19 11:11:34  oman
// - fix: Излишне глотали Alt++ (К-112723164)
//
// Revision 1.57  2009/01/15 11:44:35  oman
// - fix: Откручиваем шорткаты "+"/"-" (К-112723164)
//
// Revision 1.56  2008/09/04 11:16:08  lulin
// - <K>: 88080895.
//
// Revision 1.55  2008/08/01 11:28:19  oman
// - fix: Открываем Home/End для редактируемых комбобоксов (K-105578687)
//
// Revision 1.54  2008/07/17 07:07:38  oman
// - fix: Более корректно выделяем хвост (К-103448796)
//
// Revision 1.53  2008/07/08 11:26:23  lulin
// - избавился от хранения и выставления свойства IsList.
// - починил выбор в списке пользователей.
//
// Revision 1.52  2008/07/07 14:27:03  lulin
// - подготавливаемся к переименованию.
//
// Revision 1.51  2008/07/02 13:27:31  oman
// - fix: Откручиваем заточки (К-91848911)
//
// Revision 1.50  2008/07/02 11:41:59  oman
// - fix: Свойство названо в соответствии со своим значением (К-96474339)
//
// Revision 1.49  2008/07/02 10:56:33  oman
// - new: Неправильно делалось выделение (К-96474339)
//
// Revision 1.48  2008/07/02 09:29:33  oman
// - new: Более правильное место флага для вставки данных (К-96474339)
//
// Revision 1.47  2008/07/02 06:24:21  oman
// Cleanup
//
// Revision 1.46  2008/07/01 12:11:13  oman
// - new: При втсавке из клипборда пищим и выделяем зафильтрованное (К-96474339)
//
// Revision 1.45  2008/06/26 11:18:35  oman
// - fix: Боремся с перетрансляцией ввода (cq11768)
//
// Revision 1.44  2008/06/26 09:48:15  oman
// - fix: Пытаемся бороться с паразитным OnChange (cq11768)
//
// Revision 1.43  2008/06/26 09:13:48  oman
// - fix: Пытаемся бороться с паразитным OnChange (cq11768)
// - fix: Выделяем лишний хвост (cq11768)
//
// Revision 1.42  2008/06/26 06:14:46  oman
// - new: Выделяем новый компонент (cq29374)
//
// Revision 1.41  2008/06/26 05:53:25  oman
// - new: Меняем предка (cq29374)
//
// Revision 1.40  2008/06/24 12:29:26  oman
// - new: Заготовка для нового компонента (cq29374)
//
// Revision 1.39  2008/06/17 14:07:38  oman
// - new: Цвет для пустого хинта (cq29206)
//
// Revision 1.38  2008/05/30 06:26:22  lulin
// - <K>: 92766380.
//
// Revision 1.37  2008/05/30 06:11:23  lulin
// - <K>: 92766363.
//
// Revision 1.36  2008/05/21 17:05:12  lulin
// - <K>: 90441490.
//
// Revision 1.35  2008/05/21 13:51:01  lulin
// - <K>: 90448804.
//
// Revision 1.34  2008/05/15 20:15:17  lulin
// - тотальная чистка.
//
// Revision 1.33  2008/05/15 18:53:45  lulin
// - подготавливаемся к переносу на модель.
//
// Revision 1.32  2008/05/15 17:31:35  lulin
// - чистка использования модулей.
// - убираем неочевидную логику скроллирования.
//
// Revision 1.31  2008/05/14 19:05:04  lulin
// - <K>: 90446006.
//
// Revision 1.30  2008/05/13 16:24:09  lulin
// - изменения в рамках <K>: 90441490.
//
// Revision 1.29  2008/04/25 06:48:15  oman
// - fix: Не прокидывали нотификацию об изменении (cq28948)
//
// Revision 1.28  2007/12/07 16:22:37  lulin
// - переименовываем файл, чтобы не путать с другой библиотекой.
//
// Revision 1.27  2007/10/10 12:32:19  oman
// - fix: Публиковали не все операции
//
// Revision 1.26  2007/09/12 09:24:24  oman
// - new: Приделали третий клик для выделения всего текста (cq26647)
//
// Revision 1.25  2007/09/11 11:34:27  oman
// - fix: Запиливаем серый минус по аналогии с КЗ (cq26638)
//
// Revision 1.24  2007/07/27 09:02:44  oman
// - fix: Если установлен символ пароля, запрещаем копировать из
//  редактора (cq26085)
//
// Revision 1.23  2007/07/25 08:55:29  oman
// - fix: При вставке из клипборда не проходил OnChange
//
// Revision 1.22  2007/07/24 07:15:34  oman
// - fix: После вставки из клипборда не выделяем вставленное (cq26018)
//
// Revision 1.21  2007/07/20 05:50:55  oman
// - fix: Поддержка операций (cq25976)
//
// Revision 1.20  2007/07/19 13:56:08  oman
// - fix: Поддержка операций (cq25976)
//
// Revision 1.19  2007/03/29 15:54:26  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.18  2007/03/28 19:42:49  lulin
// - ЭлПаковский редактор переводим на строки с кодировкой.
//
// Revision 1.17  2007/03/19 14:49:13  lulin
// - выделен базовый класс редакторов.
//
// Revision 1.16  2007/03/14 19:03:41  lulin
// - cleanup.
//
// Revision 1.15  2007/03/06 07:57:43  oman
// - fix: Функции не возвращали результата
//
// Revision 1.14  2007/02/14 14:24:05  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.13  2007/01/20 15:31:00  lulin
// - разделяем параметры операции для выполнения и для тестирования.
//
// Revision 1.12  2007/01/19 14:38:21  mmorozov
// - new: сохранение состояния в историю;
//
// Revision 1.11  2007/01/17 17:53:31  lulin
// - сужаем список параметров для тестирования операции.
//
// Revision 1.10  2007/01/17 14:02:35  lulin
// - вычищены последние нефиксированные параметры в тестах операций.
//
// Revision 1.9  2006/09/29 07:12:13  oman
// - new: _TnscComboBoxQS с контролем и исправлением вставляемой из клипборда
//  строки - окончательный вариант (cq22776)
//
// Revision 1.8  2006/09/28 15:01:30  oman
// - new: _TnscComboBoxQS с контролем и исправлением вставляемой из клипборда
//  строки - более замороченный вариант (cq22776)
//
// Revision 1.7  2006/09/28 14:05:22  oman
// - new: _TnscComboBoxQS с контролем и исправлением вставляемой из клипборда
//  строки (cq22776)
//
// Revision 1.6  2006/07/04 10:51:18  oman
// - fix: Если контрол публикует операцию, то он должен перестать
//  обрабатывать соответствующую команду.
//
// Revision 1.5  2006/06/23 10:33:19  oman
// - new beh: Новый компонент nscComboBoxWithReadOnly
//
// Revision 1.4  2006/06/21 09:09:54  oman
// - fix: Если опубликовали операцию, то давим обработку команд от
//  шорткатов (cq21215)
//
// Revision 1.3  2006/02/15 09:36:17  mmorozov
// - change: test операций;
//
// Revision 1.2  2005/11/23 13:18:27  oman
// - new: Компонент TnscComboBoxWithPwdChar
//
// Revision 1.1  2004/12/29 14:59:24  am
// new: наследник комбобокса с публикацией операций Cut/Copy/Paste/Delete
//

{$Include nscDefine.inc}

interface

uses
  Classes,
  Messages,
  Controls,
  Windows,
  
  l3Interfaces,
  l3Types,
  l3InternalInterfaces,

  vcmExternalInterfaces,

  ctTypes,
  FakeBox,
  nscConst,
  vtComboTree
  ;

type
  TnscComboBox = class(TvtComboTree)
  {* Выпадающий список публикующий операции. }
  private
    procedure CNKeyDown(var Message: TWMKeyDown);
      message CN_KEYDOWN;
      {-}
  protected
   function TranslateHomeEndToDropDown: Boolean;
     override;
     {-}
  public
   constructor Create(AOwner:TComponent);
     override;
     {-}
  published
    property Anchors;
    property Ctl3D;
    property Hint;
    property TabOrder;
    property ParentFont;
    property OnChange;
    property ParentColor;
    property ParentCtl3D;
    property ParentShowHint;
    property ShowHint;
    property EmptyHint;
    property EmptyHintColor default cDefaultContextEmptyColor;
    property Font;
  end;//TnscComboBox

  TnscEdit = class(TnscComboBox)
  {* Выпадающий список с опубликованным полем PasswordChar. }
  public
  // public methods
   constructor Create(AOwner:TComponent);
     override;
     {-}
  public
  // public properties
    property ComboStyle
      default ct_cbEdit;
      {-}
  published
  // published properties
    property MaxLength;
  end;//TnscEdit

  TnscEditWithoutPlusMinusShortcut = class(TnscEdit)
  private
   procedure CNKeyDown(var Message: TWMKeyDown);
     message CN_KEYDOWN;
  published
    property OnKeyPress;
  end;

  TnscComboBoxWithFilter = class(TnscEdit)
  private
   f_DroppingData: Boolean;
  private
   procedure pm_SetCaretPos(aPos: Integer);
    {-}
   function pm_GetCaretPos: Integer;
    {-}
  protected
   function DoDoDrop(aFormat       : Tl3ClipboardFormat;
                   const aMedium : Tl3StoragePlace;
                   var dwEffect  : Longint): Boolean;
     override;
     {-}
  public
   procedure SelectTail(aStartPos: Cardinal);
     {-}
  public
   property CaretPos: Integer
    read pm_GetCaretPos
    write pm_SetCaretPos;
     {-}
   property DroppingData: Boolean
    read f_DroppingData;
     {-}
  end;//TnscComboBoxWithFilter

  TnscComboBoxWithPwdChar = class(TnscEdit)
  {* Выпадающий список с опубликованным полем PasswordChar. }
  protected
   function CopyAllowed: Boolean;
     override;
     {-}
   function CutAllowed: Boolean;
     override;
     {-}
  published
  // published properties
    property PasswordChar;
      {-}
  end;//TnscComboBoxWithPwdChar

implementation

uses
  SysUtils,
  DateUtils,
  Forms,

  OvcConst,

  l3Base,
  l3String,

  //vcmDefaultOperations,

  elCustomEdit,

  evOp,
  evEditorWindow,

  EditableBox
  ;

// start class TnscEdit

constructor TnscEdit.Create(AOwner:TComponent);
  //override;
  {-}
begin
 inherited;
 ComboStyle := ct_cbEdit;
end;

{ TnscComboBoxWithPwdChar }

function TnscComboBoxWithPwdChar.CopyAllowed: Boolean;
begin
 if PasswordChar <> '' then
  Result := False
 else
  Result := inherited CopyAllowed;
end;

function TnscComboBoxWithPwdChar.CutAllowed: Boolean;
begin
 if PasswordChar <> '' then
  Result := False
 else
  Result := inherited CutAllowed;
end;

constructor TnscComboBox.Create(AOwner: TComponent);
begin
 inherited Create(aOwner);
 EmptyHintColor := cDefaultContextEmptyColor;
end;

procedure TnscComboBox.CNKeyDown(var Message: TWMKeyDown);
begin
 if Message.CharCode = VK_SUBTRACT then
  Message.CharCode := cMinusKeyCode;
 inherited; 
end;

{ TnscComboBoxWithFilter }

procedure TnscComboBoxWithFilter.SelectTail(aStartPos: Cardinal);
begin
// SelStart := aStartPos;
// SelLength := TextLen - aStartPos;
 CaretX := aStartPos;
 ProcessCommand(ev_ocExtLineEnd, False, 1);
end;

procedure TnscComboBoxWithFilter.pm_SetCaretPos(aPos: Integer);
begin
 CaretX := aPos;
end;

function TnscComboBoxWithFilter.pm_GetCaretPos: Integer;
begin
 Result := CaretX;
end;

function TnscComboBoxWithFilter.DoDoDrop(aFormat: Tl3ClipboardFormat;
  const aMedium: Tl3StoragePlace; var dwEffect: Integer): Boolean;
begin
 f_DroppingData := True;
 try
  Result := inherited DoDoDrop(aFormat, aMedium, dwEffect);
 finally
  f_DroppingData := False;
 end;
end;

function TnscComboBox.TranslateHomeEndToDropDown: Boolean;
begin
 Result := not (ComboStyle in ReadOnlyComboStyles);
end;

{ TnscEditWithoutPlusMinusShortcut }

procedure TnscEditWithoutPlusMinusShortcut.CNKeyDown(
  var Message: TWMKeyDown);
begin
 if (Message.CharCode = VK_SUBTRACT) and (KeyDataToShiftState(Message.KeyData) = []) then
  Message.CharCode := cMinusKeyCode;
 if (Message.CharCode = VK_ADD) and (KeyDataToShiftState(Message.KeyData) = []) then
  Message.CharCode := cPlusKeyCode;
 inherited;
end;

end.
