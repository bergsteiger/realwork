unit nscRegister;
{* Модуль для регистрации компонент библиотеки. }

{ Библиотека "Nemesis Controls" }
{ Начал: Люлин А.В.             }
{ Модуль: nscRegister -                 }
{ Начат: 17.11.2004 21:21       }
{ $Id: nscRegister.pas,v 1.41 2014/08/22 09:46:47 kostitsin Exp $ }

// $Log: nscRegister.pas,v $
// Revision 1.41  2014/08/22 09:46:47  kostitsin
// чиню библиотеки компонент
//
// Revision 1.40  2014/08/21 11:14:05  kostitsin
// чиню библиотеки компонент
//
// Revision 1.39  2014/07/02 14:45:31  lulin
// - собираем библиотеки.
//
// Revision 1.38  2013/02/19 11:40:46  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.37  2012/11/12 10:25:06  fireton
// - не собирался AllArchiComponents7
//
// Revision 1.36  2012/04/06 15:20:01  lulin
// {RequestLink:237994598}
//
// Revision 1.35  2011/02/17 09:59:53  lulin
// {RequestLink:253659765}.
// - вычищаем мусорок.
//
// Revision 1.34  2010/01/27 13:15:21  oman
// - new: развлекаемся с деревами {RequestLink:182452345}
//
// Revision 1.33  2009/11/09 11:20:57  lulin
// - промежуточный коммит избавления от внутренних операций без параметров.
//
// Revision 1.32  2009/09/03 06:52:37  oman
// - new: Зачистка - {RequestLink:159369920}
//
// Revision 1.31  2009/08/18 14:36:56  lulin
// {RequestLink:158795592}. Подготавливаем инфраструктуру.
//
// Revision 1.30  2009/08/13 10:54:57  lulin
// - чистка кода.
//
// Revision 1.29  2009/01/15 11:44:37  oman
// - fix: Откручиваем шорткаты "+"/"-" (К-112723164)
//
// Revision 1.28  2009/01/12 10:07:20  oman
// - new: Готовим компонент для дочерней зоны (К-113508400)
//
// Revision 1.27  2008/06/26 06:14:48  oman
// - new: Выделяем новый компонент (cq29374)
//
// Revision 1.26  2008/06/24 12:29:28  oman
// - new: Заготовка для нового компонента (cq29374)
//
// Revision 1.25  2007/12/06 11:11:26  lulin
// - cleanup.
//
// Revision 1.24  2007/05/03 12:44:12  oman
// - new: Новый паге-контрол для базового поиска - борюсь сл шритами...
//
// Revision 1.23  2007/03/30 11:02:55  oman
// Cleanup (ContextParams)
//
// Revision 1.22  2007/03/20 09:05:03  lulin
// - избавляемся от чужого редактора.
//
// Revision 1.21  2007/03/15 15:28:00  oman
// - new: Первое приближение визуального компонента для
//  контекстной фильтрации (cq24456)
//
// Revision 1.20  2007/03/06 13:36:38  mmorozov
// - new: панель задач;
//
// Revision 1.19  2007/02/09 13:13:50  oman
// - new: Новый компонент-редактор, умеющий подгонять свою
//  высоту (cq24331)
//
// Revision 1.18  2006/12/07 14:21:02  mmorozov
// - new: используем единые настройки для компонента с вкладками (CQ: OIT5-23819);
//
// Revision 1.17  2006/09/28 14:05:24  oman
// - new: _TnscComboBoxQS с контролем и исправлением вставляемой из клипборда
//  строки (cq22776)
//
// Revision 1.16  2006/06/23 10:33:21  oman
// - new beh: Новый компонент nscComboBoxWithReadOnly
//
// Revision 1.15  2005/12/09 08:30:48  oman
// - new behavior: Компонент TnscGroupBox публикующий событие OnResize.
// Поскольку управлять размерами контролов лежащих на GroupBox надо именно
// при его Resize, а не в TForm.OnResize...
//
// Revision 1.14  2005/11/23 13:18:29  oman
// - new: Компонент TnscComboBoxWithPwdChar
//
// Revision 1.13  2005/06/22 06:16:46  mmorozov
// new: register _TnscReminder;
//
// Revision 1.12  2005/03/05 10:56:19  am
// new: новый контрол - TnscTreeView
//
// Revision 1.11  2004/12/29 14:59:48  am
// new: наследник комбобокса с публикацией операций Cut/Copy/Paste/Delete
//
// Revision 1.10  2004/12/23 12:59:05  lulin
// - компоненты перенесены на "правильную" страницу.
//
// Revision 1.9  2004/12/23 12:51:15  lulin
// - new unit: nscTextSource.
//
// Revision 1.8  2004/12/23 12:45:49  lulin
// - new unit: nscTreeSource.
//
// Revision 1.7  2004/12/22 19:06:15  lulin
// - new class: TnscStatusBar.
//
// Revision 1.6  2004/12/21 17:33:29  lulin
// - new class: TnscPreviewPanel.
//
// Revision 1.5  2004/12/17 12:39:38  mmorozov
// new: регистрация TnscContextParams;
//
// Revision 1.4  2004/12/09 10:17:35  mmorozov
// new: регистрация компонента TnscLister;
//
// Revision 1.3  2004/12/04 14:37:03  mmorozov
// new: регистрация nscHideField;
//
// Revision 1.2  2004/11/26 16:50:31  am
// change: регистрируем _TnscRemindersLine
//
// Revision 1.1  2004/11/17 18:39:10  lulin
// - new unit: nscEditor.
//

{$I nscDefine.inc }

interface
{$If defined(Nemesis)}
{$IfNDef NoVCM}
uses
  Classes
  ;

procedure Register;
{$EndIf NoVCM}
{$IfEnd} //Nemesis
implementation
{$If defined(Nemesis)}
{$IfNDef NoVCM}
uses
  DesignIntf,
  ImgList,

  evImageIndexProperty,

  // nsPage

  nscEditor,
  nscHideField,
  nscLister,
  nscPreviewPanel,
  {$If defined(Nemesis)}
  nscStatusBar,
  {$IfEnd}
  nscComboBox,
  nscTreeView,
  nscReminder,
  nscGroupBox,
  nscPageControl,
  nscNavigator,
  nscSimpleEditor,
  nscTasksPanelView,
  nscTreeComboWithHistory,
  nscTreeComboWithHistoryAndOperations,
  nscChatMemo,

  // nsComponentsPage

  nscRemindersLine,
  nscTreeSource,
  nscTextSource,
  nscContextFilter,
  nscFormsPageControl,
  nscComboBoxWithReadOnly,
  nscFocusLabel,
  nscTreeViewHotTruck
  ;

const
  nsPage = 'Nemesis Controls';
  nsComponentsPage = 'Nemesis Components';

{$If defined(Nemesis)}
type
 TnscContextFilterImageIndexProperty = class(TevImageIndexProperty)
 protected
  function GetImages : TCustomImageList;
   override;
    {-}
 end;//TevSubPanelImageIndexProperty
{$IfEnd} 


procedure Register;
begin
 RegisterComponents(nsPage, [{TnscReminder,}
                             TnscEditor,
                             {TnscHideField,}
                             TnscLister,
                             TnscTreeView,
                             TnscPreviewPanel,
                             {$If defined(Nemesis)}
                             TnscStatusBar,
                             {$IfEnd}
                             TnscComboBox,
                             TnscEdit,
                             TnscComboBoxWithPwdChar,
                             {$If defined(Nemesis)}
                             TnscComboBoxWithReadOnly,
                             TnscTreeComboWithHistoryAndOperations,
                             {$IfEnd}
                             TnscGroupBox,
                             TnscPageControl,
                             TnscNavigator,
                             TnscSimpleEditor,
                             {$If defined(Nemesis)}
                             TnscTasksPanelView,
                             TnscContextFilter,
                             {$IfEnd}
                             //TnscFullPageControl,
                             TnscTreeComboWithHistory,
                             TnscFormsPageControl,
                             TnscEditWithoutPlusMinusShortcut,
                             {$If defined(Nemesis)}
                             TnscChatMemo,
                             TnscFocusLabel,
                             {$IfEnd}
                             TnscTreeViewHotTruck]);
 {$If defined(Nemesis)}
 RegisterComponents(nsComponentsPage, [{TnscRemindersLine,}
                                       {TnscTreeSource,}
                                       TnscTextSource]);

 RegisterPropertyEditor(TypeInfo(TImageIndex), TnscContextFilter, '', TnscContextFilterImageIndexProperty);
 {$IfEnd}
end;

{ TnscContextFilterImageIndexProperty }
{$If defined(Nemesis)}
function TnscContextFilterImageIndexProperty.GetImages: TCustomImageList;
var
 l_C : TPersistent;
begin
 Result := nil;
 l_C := GetComponent(0);
 if (l_C Is TnscContextFilter) then
  Result := TnscContextFilter(l_C).Images;
end;
{$IfEnd}

{$EndIf NoVCM}
{$IfEnd} //Nemesis
end.

