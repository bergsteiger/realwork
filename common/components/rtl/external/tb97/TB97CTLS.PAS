unit TB97Ctls;

{
  Toolbar97
  Copyright (C) 1998-99 by Jordan Russell
  For conditions of distribution and use, see LICENSE.TXT.

  TToolbarButton97 & TEdit97
}
{ $Id: TB97CTLS.PAS,v 1.147 2015/01/15 13:50:33 lulin Exp $ }

// $Log: TB97CTLS.PAS,v $
// Revision 1.147  2015/01/15 13:50:33  lulin
// {RequestLink:585926571}. Используем Interlocked.
//
// Revision 1.146  2014/11/13 06:34:02  morozov
// {RequestLink: 565491811}
//
// Revision 1.145  2014/10/29 11:59:54  morozov
// {RequestLink: 570120685}
//
// Revision 1.144  2014/10/29 11:55:40  morozov
// {RequestLink: 570120685}
//
// Revision 1.143  2014/10/27 06:58:54  morozov
// {RequestLink: 569236920}
//
// Revision 1.142  2014/10/22 12:55:39  morozov
// {RequestLink: 565491798}
//
// Revision 1.141  2014/09/26 12:12:29  morozov
// {RequestLink: 565491811}
//
// Revision 1.140  2014/07/22 11:11:00  morozov
// {RequestLink: 340174500} - SizeGripPanel ресайзила не ту форму
//
// Revision 1.139  2014/03/18 19:14:17  kostitsin
// {requestlink: 259894118 }
//
// Revision 1.138  2013/12/13 17:10:15  kostitsin
// [$508169367]
//
// Revision 1.137  2013/04/05 12:05:06  lulin
// - портируем.
//
// Revision 1.136  2012/10/03 13:07:40  kostitsin
// [$397284161]
//
// Revision 1.135  2012/09/21 14:34:41  kostitsin
// [$395663838]
//
// Revision 1.134  2012/09/18 12:40:15  kostitsin
// [$392696006] - не изменяем размеры панелей, если это не требуется
//
// Revision 1.133  2012/09/11 13:53:10  kostitsin
// [$390584299]
//
// Revision 1.132  2012/09/10 10:32:23  kostitsin
// [$390584299]
//
// Revision 1.131  2012/09/06 13:30:08  kostitsin
// [$390583658]
//
// Revision 1.130  2012/09/05 16:57:09  kostitsin
// [$390576528]
//
// Revision 1.129  2012/09/05 13:02:07  kostitsin
// [$390568127]
//
// Revision 1.128  2012/09/03 13:11:12  kostitsin
// [$390570974]
//
// Revision 1.127  2012/08/31 11:59:42  kostitsin
// [$390568127]
//
// Revision 1.126  2012/08/29 14:49:05  kostitsin
// [$378542059],
// [$378560607]
//
// Revision 1.125  2012/08/29 13:04:30  kostitsin
// [$378542059]
//
// Revision 1.124  2012/08/29 09:42:38  kostitsin
// [$378542059]
//
// Revision 1.123  2012/03/22 07:39:38  lulin
// - учимся делать оглавление неплавающим.
//
// Revision 1.121  2011/12/21 14:02:53  gensnet
// http://mdp.garant.ru/pages/viewpage.action?pageId=287214455
//
// Revision 1.120  2011/12/21 11:38:09  gensnet
// http://mdp.garant.ru/pages/viewpage.action?pageId=287214455
//
// Revision 1.119  2011/09/14 09:10:51  vkuprovich
// {RequestLink:281521636}
//
// Revision 1.118  2011/09/12 19:26:43  vkuprovich
// {RequestLink:228688499}
// Подсветка тулбарных кнопок
//
// Revision 1.117  2011/06/17 11:59:12  lulin
// {RequestLink:228688486}.
//
// Revision 1.116  2010/02/10 13:32:33  oman
// - fix: {RequestLink:190677880}
//
// Revision 1.115  2010/02/02 11:59:00  oman
// - new: {RequestLink:185827761}
//
// Revision 1.114  2009/10/21 07:19:55  oman
// - fix: {RequestLink:166856836}
//
// Revision 1.113  2008/08/12 11:49:49  oman
// - fix: В InfoCanvas залипает PasswordChar - выделил правильный метод ее получения (K-108232754)
// - fix: Избавляемся от f_RestrictWrap - ибо залипает в мозгах (K-96482169)
//
// Revision 1.112  2008/08/08 11:16:59  lulin
// - <K>: 96482147.
//
// Revision 1.111  2008/08/06 09:43:11  oman
// - fix: Шаманим с многострочной последней кнопкой (K-96482568)
//
// Revision 1.110  2008/02/19 13:59:11  oman
// - new: Логика с количеством строк в иконках вынесена в тулбарные кнопки (cq10920)
//
// Revision 1.109  2008/02/14 19:32:36  lulin
// - изменены имена файлов с примесями.
//
// Revision 1.108  2008/02/14 17:09:08  lulin
// - cleanup.
//
// Revision 1.107  2008/02/14 14:12:21  lulin
// - <K>: 83920106.
//
// Revision 1.106  2008/02/07 08:37:56  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.105  2008/02/06 09:30:47  lulin
// - базовые списки объектов выделяем в отдельные файлы.
//
// Revision 1.104  2008/01/31 18:53:40  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.103  2008/01/25 12:06:57  lulin
// - синхронизируем имена с моделью.
//
// Revision 1.102  2008/01/25 11:32:12  lulin
// - синхронизируем имена с моделью.
//
// Revision 1.101  2007/08/22 09:05:58  oman
// - fix: Зацикливались на подноке ширины для однословных
//  однострочных заголовках (cq26444)
//
// Revision 1.100  2007/08/14 19:31:49  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.99  2007/04/20 13:26:47  lulin
// - cleanup.
//
// Revision 1.98  2007/04/20 13:24:06  lulin
// - не пишем мусор.
//
// Revision 1.97  2007/04/20 13:09:57  lulin
// - bug fix: некорректно обрабатывали отрицательную ширину.
//
// Revision 1.96  2007/04/20 12:47:00  lulin
// - cleanup.
//
// Revision 1.95  2007/04/20 12:04:44  lulin
// - bug fix: при хождении по истории опять кнопки не нарезались в несколько строк (CQ OIT5-24967).
//
// Revision 1.94  2007/04/20 09:06:20  lulin
// - убираем ненужную функциональность.
//
// Revision 1.93  2007/04/20 08:31:21  lulin
// - cleanup.
//
// Revision 1.92  2007/04/19 13:24:14  lulin
// - cleanup.
//
// Revision 1.91  2007/04/19 12:51:28  lulin
// - cleanup.
//
// Revision 1.90  2007/04/19 11:10:29  lulin
// - если самая краяняя правая кнопка умещается в две строки, то не обрезаем ее текст (CQ OIT5-25091).
//
// Revision 1.88  2007/04/18 10:59:31  lulin
// - переупорядочиваем код.
//
// Revision 1.87  2007/04/18 10:50:17  lulin
// - переименовываем метод в соответствии с его назначением.
//
// Revision 1.86  2007/04/18 10:29:54  lulin
// - выделяем метод.
//
// Revision 1.85  2007/04/18 10:10:17  lulin
// - уменьшаем ограничение размера кнопки.
//
// Revision 1.84  2007/04/18 08:56:33  lulin
// - cleanup.
//
// Revision 1.83  2007/04/17 13:26:30  lulin
// - bug fix: надписи на кнопках иногда нарезались не по словам, а внутри слова (CQ OIT5-25068).
//
// Revision 1.82  2007/04/09 13:36:00  fireton
// - bugfix
//
// Revision 1.81  2007/04/09 11:40:17  fireton
// - bugfix
//
// Revision 1.80  2007/04/04 14:08:34  lulin
// - делаем стрелочку поменьше.
//
// Revision 1.79  2007/04/04 11:15:18  lulin
// - увеличиваем размеры стрелок.
//
// Revision 1.78  2007/04/04 07:47:03  lulin
// - делаем ширину с небольшим запасом.
//
// Revision 1.77  2007/04/03 14:18:10  lulin
// - не пытаемся переформатировать однострочные заголовки.
//
// Revision 1.76  2007/04/03 13:52:54  lulin
// - увеличиваем ширину кнопки так, чтобы текст в итоге влез, без всяких многоточий.
//
// Revision 1.75  2007/04/03 13:01:27  lulin
// - не пересчитываем два раза размер кнопки.
//
// Revision 1.74  2007/04/03 12:22:04  lulin
// - делаем размер многострочной кнопки по ширине максимальной строки.
//
// Revision 1.73  2007/04/02 13:26:34  lulin
// - bug fix: иногда строки переносились тогда когда не надо.
//
// Revision 1.72  2007/04/02 12:58:08  lulin
// - уменьшаем область видимости переменных.
//
// Revision 1.71  2007/04/02 12:39:02  lulin
// - не записываем мусор.
//
// Revision 1.70  2007/04/02 08:47:19  lulin
// - для заголовков кнопок используем строки с кодировкой.
//
// Revision 1.69  2007/04/02 07:21:34  lulin
// - убрано устаревшее свойство.
//
// Revision 1.68  2007/04/02 06:34:03  lulin
// - вычищено ненужное свойство.
//
// Revision 1.67  2007/04/02 05:59:55  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.66  2007/04/02 05:48:37  lulin
// - теперь длинные заголовки кнопок умеют резаться в несколько строк, если это возможно, а также - обрезаться с многоточием, если в несколько строк не влезают.
//
// Revision 1.65  2007/03/30 12:51:45  lulin
// - bug fix: поборол AV из за неправильного порядка освобождения объектов при отрисовке.
//
// Revision 1.64  2007/03/30 12:40:21  lulin
// - рисуем на "родной" канве.
//
// Revision 1.63  2007/03/30 08:39:17  lulin
// - используем "родную" канву для рисования.
//
// Revision 1.62  2007/03/30 08:11:43  lulin
// - cleanup.
//
// Revision 1.61  2006/12/11 14:15:51  lulin
// - bug fix: yt ,skb cby[hjybpbhjdfys pyfxtybt gj-evjkxfyb. b pyfxtybt bybwbfkbpfwbb//
//
// Revision 1.60  2006/07/19 11:19:09  mmorozov
// - warnings, hints fix;
// - bugfix: простые кнопки с иконками потолстели, неправильно вычислялась необходимость отрисовки выпадющей стрелки;
//
// Revision 1.59  2006/07/19 08:17:33  mmorozov
// - bugfix: для кнопок со стрелкой неверно считался размер (CQ: OIT500021668);
//
// Revision 1.58  2006/02/20 14:59:06  mmorozov
// - bugfix: при определенных условиях пропадала дополнительная кнопка для открытия списка не вместившихся на панель инструментов компонентов + сопутствующий рефакторинг (CQ: 17421);
//
// Revision 1.57  2005/06/09 14:13:10  mmorozov
// new: кнопки toolbar-а поддерживают интерфейс _ITB97Ctrl (кнопки с подписями теперь по умолчанию с изменяемыми размерами);
//
// Revision 1.56  2005/04/04 11:33:25  mmorozov
// bugfix: при вычислении размера кнопки toobar-а не инициализировался шрифт канвы, в результате кнопки наезжали друг на друга (проявлялось в случае не русской кодовой страницы по умолчанию);
//
// Revision 1.55  2005/01/31 13:12:23  mmorozov
// bugfix: защита MouseUp от удаления кнопки во время обработки;
//
// Revision 1.54  2005/01/12 14:01:21  lulin
// - new methods: Tafw.BeginOp/EndOp.
//
// Revision 1.53  2004/11/15 12:09:10  mmorozov
// - место для комментария;
//
// Revision 1.52  2004/10/22 14:20:50  mmorozov
// bugfix: при добавлении в кеш не очищалось поле FImageList у Ttb97ButtonGlyph;
//
// Revision 1.51  2004/10/21 19:32:40  mmorozov
// cleanup: RealImageSize;
//
// Revision 1.50  2004/10/20 10:40:47  lulin
// - new behavior: увеличиваем частоту использования пула объектов.
//
// Revision 1.49  2004/10/19 12:10:13  mmorozov
// new: type TtbToolbarButtonSize;
// new: global var g_tbToolbarButtonSize;
// new behaviour: в _AdjustSize используется g_tbToolbarButtonSize;
// bugfix: кнопки имели размер больше toolbar-а в следствии чего не видна была нижняя и верхняя граница;
//
// Revision 1.48  2004/10/15 13:33:10  lulin
// - bug fix: в _AdjustSize учитываем AutoSize.
//
// Revision 1.47  2004/09/29 12:34:22  am
// bugfix: _AdjustSize - глючило для случая без установленных _Images но с Glyth
// change: не выполняем вычислений в _AdjustSize для случая, когда размер был явно выставлен пользователем в Design time.
//
// Revision 1.46  2004/09/22 12:10:25  mmorozov
// new: TCustomToolbarButton97 поддерживает Itb97Control;
//
// Revision 1.45  2004/09/16 11:31:13  lulin
// - навел подобие порядка с регистрацией компонент библиотеки.
//
// Revision 1.44  2004/09/14 14:31:25  am
// change: поменял TToolbarSep на TDropWindowSeparator
//
// Revision 1.43  2004/09/14 09:42:00  lulin
// - Ttb97DropdownList сделан наследником от Tl3InterfacedComponent.
//
// Revision 1.42  2004/09/14 09:30:58  lulin
// - Ttb97ButtonGlyph сделан наследником от Tl3CacheableBase.
//
// Revision 1.41  2004/09/14 09:14:27  lulin
// - cleanup: редко используемые поля убраны под define'ы.
// - упорядочено наследование.
// - поправлены имена.
//
// Revision 1.40  2004/09/14 08:15:29  lulin
// - TGlyphList переименован в Ttb97GlyphList.
//
// Revision 1.39  2004/09/14 08:10:40  lulin
// - _Ttb97GlyphCache сделан наследником от Ttb97List.
//
// Revision 1.38  2004/09/13 16:26:26  lulin
// - new unit: tb97List.
// - перевел Toolbar 97 на Ttb97List.
//
// Revision 1.37  2004/09/13 15:50:35  lulin
// - cleanup: выкинул лишний модуль из Toolbar 97.
// - bug fix: за Мишей - не компилировался VCM.
//
// Revision 1.36  2004/09/13 12:52:10  lulin
// - в Toolbar97 прикрутили слежение за памятью.
//
// Revision 1.35  2004/09/09 13:36:40  fireton
// - change behaviour: увеличиваем кнопки на тулбарах
//
// Revision 1.34  2004/09/08 11:22:51  lulin
// - new define: l3NoTrace.
// - new define: l3TraceObjects.
//
// Revision 1.33  2004/09/02 17:27:14  mmorozov
// bugfix: при изменении размера иконок кнопка DisplayMode = dmTextOnly оставалась большой;
// new: property TCustomToolbarButton97.RealImageSize (размер иконки на основе которой отрисована кнопка);
//
// Revision 1.32  2004/09/02 13:39:49  am
// bugfix: AV при закрытии
//
// Revision 1.31  2004/08/27 08:44:21  mmorozov
// new: property TCustomToolbarButton97.ProtectedClick (см. комментарий к property ProtectedClick);
//
// Revision 1.30  2004/07/30 14:10:39  fireton
// - коррекция _AdjustSize
//
// Revision 1.29  2004/07/27 12:51:42  law
// - new behavior: кнопки перестраивают свою высоту и ширину по ImageList'у.
//
// Revision 1.27  2004/07/23 15:02:21  fireton
// - add: добавлено событие OnCustomGlyphDraw
//
// Revision 1.26  2004/07/22 07:11:39  fireton
// - bug fix: условная компиляция для AllEverestComponents (обход некомпиляции ImgList в design-time)
//
// Revision 1.25  2004/07/21 15:55:21  law
// - добавлены виртуальные методы для расширения функциональности ImageList'а.
//
// Revision 1.24  2004/07/21 15:34:01  fireton
// - подхачка для работы с TvtPngImageList
//
// Revision 1.23  2004/07/15 11:40:07  am
// new: TToolbarSep, разделитель, не привязанный к тулбару, для выпадающего окна
//
// Revision 1.22  2004/05/31 12:17:29  am
// change: Action.Update после Click'а.
//
// Revision 1.21  2004/04/09 14:41:56  law
// - new behavior: сделан контроль за объектами TToolbarButton97ActionLink, TCustomToolbarButton97, TEdit97.
//
// Revision 1.20  2004/03/27 17:58:05  am
// bugfix: неправильно вычислялась ширина комбо-кнопки с DisplayMode = dmBoth
//
// Revision 1.19  2004/01/15 15:25:07  law
// - change: Free заменил на tb97Free.
//
// Revision 1.18  2003/12/29 14:57:51  nikitin75
// TCustomToolbarButton97._Paint: if Locked call inherited only;
//
// Revision 1.17  2003/12/27 15:15:15  am
// bugfix:
//
// Revision 1.16  2003/12/27 10:18:01  am
// new: кнопка выпадающего меню у элемента, этого меню не имеющего - дизейблится.
//
// Revision 1.15  2003/12/22 13:19:10  am
// new: Новый тулбар. Тулбары внутри дока нельзя перемещать вручную, при недостатке места
// они автоматически схлопываются справа налево, при увеличении свободного места -
// автоматически развёртываются.
//
// Revision 1.14.2.1  2003/11/28 10:34:36  am
// временная ветка для Шуры
//
// Revision 1.13  2003/10/22 17:03:33  mmorozov
// - merge с Toolbar97Version = '1.78a';
//
// Revision 1.12  2003/08/29 12:49:50  law
// - bug fix: Текст на кнопке "Искать" ППР выходит за рамки (увеличил кнопку еще на 2 пикселя).
//
// Revision 1.11  2003/08/27 08:29:44  law
// - bug fix: Текст на кнопке Искать ППР выходит за рамки.
//
// Revision 1.10  2003/08/01 11:46:13  law
// - bug fix: не "залипали" кнопки.
//
// Revision 1.9  2003/07/25 15:56:36  law
// - bug fix: подравниваем кнопку при смене текста.
//
// Revision 1.8  2003/07/24 12:17:41  law
// - new behavior: сделана подгонка ширины кнопки.
//
// Revision 1.7  2003/07/22 14:22:53  law
// - new behavior: практически избавились от мерцания toolbar'ов (для Toolbar 97).
//
// Revision 1.6  2002/01/22 16:22:04  voba
// bug fix
//
// Revision 1.5  2001/10/04 16:02:54  law
// - new class: TCustomToolbarButton97.
//
// Revision 1.4  2001/04/13 08:28:00  law
// - new method: добавлен новый виртуальный метод DoClick.
//

interface

{$Include TB97Ver.inc}

uses
  Windows,
  Messages,
  Classes,
  Controls,
  Forms,
  Menus,
  Graphics,
  Buttons,
  ImgList,
  ActnList,
  StdCtrls,
  ExtCtrls,
  TB97,
  tb97List,
  tb97GraphicControl,
  TB97ExtInterfaces,

  l3Interfaces,
  l3InternalInterfaces
  ;

const
  DefaultDropdownArrowWidth = 9;

type
  Ttb97GlyphSize = (gsDefault, gs16, gs24, gs32);

const
 cGlyphSize: array[Ttb97GlyphSize] of TSize = ((cx:0; cy:0), (cx:16; cy:16), (cx:24; cy:24), (cx:32; cy:32));

type
  TButtonDisplayMode = (dmBoth, dmGlyphOnly, dmGlyphAndFakeText, dmTextOnly);
  TButtonState97 = (bsUp, bsDisabled, bsDown, bsExclusive, bsMouseIn);
  TNumGlyphs97 = 1..5;
  TButtonDropdownEvent = procedure(Sender: TObject;
    var ShowMenu, RemoveClicks: Boolean) of object;

  TCustomGlyphDrawEvent = procedure(Sender: TObject; const aCanvas: Il3Canvas;
      aRect: TRect; aState: TButtonState97) of object;


  TCustomToolbarButton97 = class(Ttb97GraphicTextControl,
                                 Itb97Control,
                                 ITB97Ctrl)
  private
  // ITB97Ctrl
    function Get_FullWidth : Integer;
      {-}
    function Get_IsSizeable : Boolean;
      {-}
    function Get_MinWidth : Integer;
      {-}
    procedure SetGlyphSize(const Value: Ttb97GlyphSize);
  private
    FEllipsis: Boolean;
    FNeedAdjustSize: Boolean;
    FAllowAllUp: Boolean;
    FAlignment: TAlignment;
    FCancel: Boolean;
    FDefault: Boolean;
    FDisplayMode: TButtonDisplayMode;
    FDown: Boolean;
    FDropdownAlways: Boolean;
    FDropdownArrow: Boolean;
    FDropdownArrowWidth: Integer;
    FDropdownCombo: Boolean;
    FDropdownMenu: TPopupMenu;
    {$IfNdef tb97AlwaysFlat}
    FFlat: Boolean;
    {$EndIf  tb97AlwaysFlat}
    FGlyph: Pointer;
    FGroupIndex: Integer;
    FHelpContext: THelpContext;
    FLayout: TButtonLayout;
    FMargin: Integer;
    FModalResult: TModalResult;
    FNoBorder: Boolean;
    FOpaque: Boolean;
    FShowBorderWhenInactive: Boolean;
    {$IfDef tb97NeedSpacing}
    FSpacing: Integer;
    {$EndIf tb97NeedSpacing}
    {$IfDef tb97NeedWordWrap}
    FWordWrap: Boolean;
    {$EndIf tb97NeedWordWrap}
    {$IfDef tb97NeedOnDropdown}
    FOnDropdown: TButtonDropdownEvent;
    {$EndIf tb97NeedOnDropdown}
    {$IfDef tb97NeedMouseEvents}
    FOnMouseEnter, FOnMouseExit: TNotifyEvent;
    {$EndIf tb97NeedMouseEvents}
    { Internal }
    FInClick: Boolean;
    FMouseInControl: Boolean;
    FMouseIsDown: Boolean;
    FMenuIsDown: Boolean;
    {$IfDef tb97NeedCustomGlyphDraw}
    FOnCustomGlyphDraw: TCustomGlyphDrawEvent;
    {$EndIf tb97NeedCustomGlyphDraw}
    FUsesDropdown: Boolean;
    fIndex : Integer;
    FGlyphSize: Ttb97GlyphSize;
  private
  // интерфейс Itb97Control
    procedure pm_SetIndex(const Value : Integer);
      {-}
    function pm_GetIndex : Integer;
      {-}
    function pm_NeedDropArrow: Boolean;
      {* - наличие выпадающей стрелочки. }
  protected
  // private methods
    procedure GlyphChanged(Sender: TObject);
    procedure UpdateExclusive;
    procedure SetAlignment(Value: TAlignment);
    procedure SetAllowAllUp(Value: Boolean);
    procedure SetDown(Value: Boolean);
    procedure SetDisplayMode(Value: TButtonDisplayMode);
    procedure SetDropdownAlways(Value: Boolean);
    procedure SetDropdownArrow(Value: Boolean);
    function  GetDropdownArrowWidth: Integer;
    procedure SetDropdownArrowWidth(Value: Integer);
    procedure SetDropdownCombo(Value: Boolean);
    procedure SetDropdownMenu(Value: TPopupMenu);
    function  GetFlat: Boolean;
    procedure SetFlat(Value: Boolean);
    function GlyphStored: Boolean;
      virtual;
    function GetGlyph: TBitmap;
    procedure SetGlyph (Value: TBitmap);
    function GlyphMaskStored: Boolean;
      virtual;
    function GetGlyphMask: TBitmap;
    procedure SetGlyphMask (Value: TBitmap);
    procedure SetGroupIndex (Value: Integer);
    function GetImageIndex: Integer;
    procedure SetImageIndex (Value: Integer);
    function GetImages: TCustomImageList;
    procedure SetImages (Value: TCustomImageList);
    procedure SetLayout (Value: TButtonLayout);
    procedure SetMargin (Value: Integer);
    procedure SetNoBorder (Value: Boolean);
    function GetNumGlyphs: TNumGlyphs97;
    procedure SetNumGlyphs (Value: TNumGlyphs97);
    procedure SetOpaque (Value: Boolean);
    function  GetSpacing: Integer;
    procedure SetSpacing(Value: Integer);
    function  GetWordWrap: Boolean;
    procedure SetWordWrap(Value: Boolean);
    procedure RemoveButtonMouseTimer;
    procedure Redraw (const Erase: Boolean);
    function PointInButton (X, Y: Integer): Boolean;
    procedure ButtonMouseTimerHandler (Sender: TObject);
    function IsCheckedStored: Boolean;
    function IsHelpContextStored: Boolean;
    function IsImageIndexStored: Boolean;
    procedure WMLButtonDblClk (var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure CMEnabledChanged (var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMDialogChar (var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMDialogKey (var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMFontChanged (var Message: TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged (var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMSysColorChange (var Message: TMessage); message CM_SYSCOLORCHANGE;
    {$IfDef tb97NeedCustomGlyphDraw}
    procedure SetOnCustomGlyphDraw(const Value: TCustomGlyphDrawEvent);
    {$EndIf tb97NeedCustomGlyphDraw}
    procedure WMCancelMode (var Message: TWMCancelMode); message WM_CANCELMODE;
  protected
    FState: TButtonState97;
    function GetPalette: HPALETTE; override;
    procedure Loaded; override;
    procedure Notification (AComponent: TComponent; Operation: TOperation); override;
    procedure MouseDown (Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove (Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp (Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    function GetIsAutoCenter: Boolean; virtual;
    procedure DoPaint(const aCN: Il3Canvas);
      override;
    procedure ActionChange (Sender: TObject; CheckDefaults: Boolean); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure AssignTo (Dest: TPersistent); override;
    procedure DoClick;
      virtual;
      {-}
    function IsGtbToolbarButtonSizeNeeded: Boolean; virtual;
    procedure AdjustSize; override;
      {-}
    procedure CalcSizeAndGetText(var aSize : TSize;
                                 var aText : Tl3WString);
      {-}
    function  FitToSize(const aCN   : Il3InfoCanvas;
                        const aText : Tl3WString;
                        aWidth      : Integer;
                        aHeight     : Integer;
                        var theRect : TRect): Boolean;
      {-}
    procedure DoFitToWidth(aWidth: Integer);
      {-}
    procedure DoUnFitToWidth(aWidth: Integer);
      {-}
    procedure Expand;
      {-}
    procedure CalcSize(var aSize : TSize);
      virtual;
      {-}
    function GetHBorder: Integer; virtual;
    function GetVBorder: Integer; virtual;
    function NeedAutoDown: Boolean;
      virtual;
      {-}
    function AutoAllUp: Boolean;
      virtual;
      {-}
    procedure Cleanup;
      override;
      {-}
    function InfoCanvas: Il3InfoCanvas;
      {-}
  protected
  // properties
    property NeedDropArrow: Boolean
      read pm_NeedDropArrow;
      {* - наличие выпадающей стрелочки. }
  public
  // methods
    constructor Create(AOwner: TComponent);
      override;
      {-}
    procedure Click;
      override;
      {-}
    procedure MouseEntered;
      {-}
    procedure MouseLeft;
      {-}
    function  Locked: Boolean;
      {-}
  public
    property Canvas;
      {-}
(*    property ProtectedClick : Boolean
      read FProtectedClick
      write FProtectedClick;
      {* - используется в методе Click и говорит о необходимости использовать
           скобки tb97StartOp, tb97EndOp (чтобы форма не умерла до момента
           выхода из Click).

           Сделано потому что в Немезисе, который присваивает обработчики
           g_tb97StartOp и g_tb97EndOp в этих операциях сначала запоминается
           компонент в котором находится фокус, потом ему этот фокус
           возвращается (g_tb97EndOp). В результате в карточке запроса в
           обработчике Click создаётся новое поле, в него передаётся фокус,
           потом забирается фокус и поле удаляется, потому, что пустое. }*)
  public
    property Action;
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify{taCenter};
    property AllowAllUp: Boolean read FAllowAllUp write SetAllowAllUp default False;
    property Anchors;
    property Cancel: Boolean read FCancel write FCancel default False;
    property Color default cDefBack;
    property Constraints;
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex default 0;
    property Default: Boolean read FDefault write FDefault default False;
    property DisplayMode: TButtonDisplayMode read FDisplayMode write SetDisplayMode default dmBoth;
    property Down: Boolean read FDown write SetDown stored IsCheckedStored default False;
    property DragCursor;
    property DragMode;
    property DropdownAlways: Boolean read FDropdownAlways write SetDropdownAlways default False;
    property DropdownArrow: Boolean read FDropdownArrow write SetDropdownArrow default True;
    property DropdownArrowWidth: Integer
      read GetDropdownArrowWidth
      write SetDropdownArrowWidth
      default DefaultDropdownArrowWidth;
      {-}
    property DropdownCombo: Boolean read FDropdownCombo write SetDropdownCombo default False;
    property DropdownMenu: TPopupMenu read FDropdownMenu write SetDropdownMenu;
    property Caption;
    property FullWidth : Integer
      read Get_FullWidth;
      {* - обычный размер компонента, для вычисления и размещения компонентов. }
    property IsSizeable : Boolean
      read Get_IsSizeable;
      {* - компонент может изменять размеры. }
    property MinWidth : Integer
      read Get_MinWidth;
      {* - минимальный размер до которого может сжиматься компонент. }
    property Enabled;
    property Flat: Boolean
      read GetFlat
      write SetFlat
      default True;
      {-}
    property Font;
    property Glyph: TBitmap
      read GetGlyph
      write SetGlyph
      stored GlyphStored;
    property GlyphMask: TBitmap
      read GetGlyphMask
      write SetGlyphMask
      stored GlyphMaskStored;
    property GlyphSize: Ttb97GlyphSize read FGlyphSize write SetGlyphSize default gsDefault; 
    property HelpContext: THelpContext read FHelpContext write FHelpContext stored IsHelpContextStored default 0;
    property ImageIndex: Integer read GetImageIndex write SetImageIndex stored IsImageIndexStored default -1;
    property Images: TCustomImageList read GetImages write SetImages;
    property Layout: TButtonLayout read FLayout write SetLayout default blGlyphLeft;
    property Margin: Integer read FMargin write SetMargin default -1;
    property ModalResult: TModalResult read FModalResult write FModalResult default 0;
    property NoBorder: Boolean read FNoBorder write SetNoBorder default False;
    property NumGlyphs: TNumGlyphs97 read GetNumGlyphs write SetNumGlyphs default 1;
    property Opaque: Boolean
      read FOpaque
      write SetOpaque
      default True;
      {-}
    property ParentFont;
    property ParentColor default False;
    property ParentShowHint;
    property ShowBorderWhenInactive: Boolean read FShowBorderWhenInactive write FShowBorderWhenInactive default False;
    property ShowHint;
    property Spacing: Integer read GetSpacing write SetSpacing default 4;
    property Visible;
    property WordWrap: Boolean
      read GetWordWrap
      write SetWordWrap
      default False;
      {-}
    property OnClick;
    {$IfDef tb97NeedCustomGlyphDraw}
    property OnCustomGlyphDraw: TCustomGlyphDrawEvent
      read FOnCustomGlyphDraw
      write SetOnCustomGlyphDraw;
      {-}
    {$EndIf tb97NeedCustomGlyphDraw}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    {$IfDef tb97NeedOnDropdown}
    property OnDropdown: TButtonDropdownEvent
      read FOnDropdown
      write FOnDropdown;
    {$EndIf tb97NeedOnDropdown}
    property OnEndDrag;
    property OnMouseDown;
    {$IfDef tb97NeedMouseEvents}
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseExit: TNotifyEvent read FOnMouseExit write FOnMouseExit;
    {$EndIf tb97NeedMouseEvents}
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property Ellipsis: Boolean read FEllipsis write FEllipsis default True;
  end;//TCustomToolbarButton97

  TCustomToolbarPanel97 = class(TCustomToolbarButton97,
                                Il3WndProcListener)
   private
    FStretch: Boolean;
    FNotifyLock: Boolean;
    FProgressIndicator: Boolean;
    FProgressTimer: TTimer;
    //FProgressPosition: Integer;
    procedure SetStretch(aValue: Boolean);
    procedure SetProgressIndicator(const Value: Boolean);
   protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure CleanUp; override;
//    procedure AdjustSize; override;
    function GetHBorder: Integer; override;
    function GetVBorder: Integer; override;
    function IsGtbToolbarButtonSizeNeeded: Boolean; override;
    procedure DoPaintProgress;
    procedure OnProgressTimer(aSender: TObject);
    procedure DoPaint(const aCN: Il3Canvas); override;
   protected
    procedure WndProcListenerNotify(Msg: PCWPStruct;
      var theResult: Tl3HookProcResult);
   public
    constructor Create(AOwner: TComponent); override;
    property Stretch: Boolean read FStretch write SetStretch;
    property ProgressIndicator: Boolean read FProgressIndicator write SetProgressIndicator;
    procedure AdjustSize; override;
  end;

  TSizeGripPanel = class(TCustomToolbarButton97,
                         Il3WndProcListener)
  private
    FGripVisible: Boolean;
    FCapture: Boolean;
    FCapturePos: TPoint;
    procedure SetGripVisible(const Value: Boolean);
    procedure CheckCanSize;
   protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure AdjustSize; override;
    procedure DoPaint(const aCN: Il3Canvas); override;
    procedure CleanUp; override;
    function GetFormToResize: TCustomForm; virtual;
   protected
    procedure WndProcListenerNotify(Msg: PCWPStruct;
      var theResult: Tl3HookProcResult);
   public
    constructor Create(AOwner: TComponent); override;
    property GripVisible: Boolean read FGripVisible write SetGripVisible;
  end;

  TToolbarButton97 = class(TCustomToolbarButton97)
  published
    property Action;
    property Alignment;
    property AllowAllUp;
    property Anchors;
    property Cancel;
    property Color;
    property Constraints;
    property GroupIndex;
    property Default;
    property DisplayMode;
    property Down;
    property DragCursor;
    property DragMode;
    property DropdownAlways;
    property DropdownArrow;
    property DropdownArrowWidth;
    property DropdownCombo;
    property DropdownMenu;
    property Caption;
    property Enabled;
    property Flat;
    property Font;
    property Glyph;
    property GlyphMask;
    property HelpContext;
    property ImageIndex;
    property Images;
    property Layout;
    property Margin;
    property ModalResult;
    property NoBorder;
    property NumGlyphs;
    property Opaque;
    property ParentFont;
    property ParentColor;
    property ParentShowHint;
    property ShowBorderWhenInactive;
    property ShowHint;
    property Spacing;
    property Visible;
    property WordWrap;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    {$IfDef tb97NeedOnDropdown}
    property OnDropdown;
    {$EndIf tb97NeedOnDropdown}
    property OnEndDrag;
    property OnMouseDown;
    {$IfDef tb97NeedMouseEvents}
    property OnMouseEnter;
    property OnMouseExit;
    {$EndIf tb97NeedMouseEvents}
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    {$IfDef tb97NeedCustomGlyphDraw}
    property OnCustomGlyphDraw;
    {$EndIf tb97NeedCustomGlyphDraw}
  end;//TToolbarButton97

  { TToolButtonActionLink }

  TToolbarButton97ActionLink = class(TControlActionLink)
  protected
    FClient: TCustomToolbarButton97;
    procedure AssignClient (AClient: TObject); override;
    function IsCheckedLinked: Boolean; override;
    function IsHelpContextLinked: Boolean; override;
    function IsImageIndexLinked: Boolean; override;
    procedure SetChecked (Value: Boolean); override;
    procedure SetHelpContext (Value: THelpContext); override;
    procedure SetImageIndex (Value: Integer); override;
  public
    class function NewInstance: TObject;
      override;
      {* - функция распределения памяти под экземпляр объекта. Перекрыта, для контроля за памятью на объекты. }
    procedure FreeInstance;
      override;
      {* - функция освобождения памяти экземпляра объекта. Перекрыта, для контроля за памятью на объекты. }
  end;//TToolbarButton97ActionLink

  TToolbarButton97ActionLinkClass = class of TToolbarButton97ActionLink;

  { TEdit97 }

  _l3Unknown_Parent_ = TCustomEdit;
  {$Define _UnknownIsComponent}
  {$Include l3Unknown.imp.pas}
  TEdit97 = class(_l3Unknown_)
  private
    MouseInControl: Boolean;
    procedure DrawNCArea (const DrawToDC: Boolean; const ADC: HDC;
      const Clip: HRGN);
    procedure NewAdjustHeight;
    procedure CMEnabledChanged (var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged (var Message: TMessage); message CM_FONTCHANGED;
    procedure CMMouseEnter (var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave (var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMKillFocus (var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMNCCalcSize (var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint (var Message: TMessage); message WM_NCPAINT;
    procedure WMPrint (var Message: TMessage); message WM_PRINT;
    procedure WMPrintClient (var Message: TMessage); message WM_PRINTCLIENT;
    procedure WMSetFocus (var Message: TWMSetFocus); message WM_SETFOCUS;
  protected
    procedure Loaded; override;
    {$I l3DefineCleanup.inc}
  public
    constructor Create (AOwner: TComponent);
      override;
      {-}
  published
    property AutoSelect;
    property Anchors;
    property Align;
    property BiDiMode;
    property CharCase;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;//TEdit97

  TDropWindowSeparator = class(Ttb97GraphicControl)
  private
    FDockType: TDockType;
  protected
    procedure DoPaint(const aCN: Il3Canvas);
      override;
  public
    constructor Create (AOwner: TComponent; aDockType: TDockType);
      reintroduce;
  published
    property Width;
    property Height;
    property Visible;
  end;//TDropWindowSeparator

var
  ButtonsStayDown: Boolean = True;
  ButtonMouseInControl: TCustomToolbarButton97 = nil;

function ControlIs97Control (AControl: TControl): Boolean;
procedure Register97ControlClass (AClass: TClass);
procedure Unregister97ControlClass (AClass: TClass);

type
 TtbToolbarButtonSize = procedure (aToolbarButton : TCustomToolbarButton97) of Object;
   {* - размер кнопки может быть меньше чем toolbar-а, потому что его размер
        устанавливается по размеру самого большого компонента. }

var
 g_tbToolbarButtonSize : TtbToolbarButtonSize = nil;
 g_ProgressPosition: Integer = 20;

implementation

uses
  SysUtils,
  Consts,
  CommCtrl,
  TB97Cmn,
  tb97Mem,

  l3Base,
  l3InterfacedComponent,
  l3ScreenIC,
  l3String,
  l3Bitmap,
  l3Units,
  l3MinMax,
  l3Math,
  l3ObjectList,
  l3CacheableBase,
  l3ListenersManager,
  l3Defaults,
  l3Interlocked,

  afwFacade,
  afwDrawing,

  vtPngImgList,
  vtInterfaces,
  
  TB97Tlbr,
  l3Canvas;

{$Include l3Unknown.imp.pas}

var
  { See TCustomToolbarButton97.ButtonMouseTimerHandler for info on this }
  ButtonMouseTimer: TTimer = nil;

  Control97List: Ttb97List = nil;

  Edit97Count: Integer = 0;
  g_Colors: array[0..100] of TColor;

////////////////////////////////////////////////////////////////////////////////
const
  cDropDownComboSpace = 2;
  cDW                 = 4;
  cDH                 = 4;
  cSpacing            = 4;
////////////////////////////////////////////////////////////////////////////////

function ControlIs97Control (AControl: TControl): Boolean;
var
  I: Integer;
begin
  Result := False;
  if Assigned(AControl) and Assigned(Control97List) then
    for I := 0 to Control97List.Count-1 do
      if AControl is TClass(Control97List[I]) then
      begin
        Result := True;
        Break;
      end;
end;

procedure Register97ControlClass (AClass: TClass);
begin
  if Control97List = nil then
   Control97List := Ttb97List.Make;
  Control97List.Add (AClass);
end;

procedure Unregister97ControlClass (AClass: TClass);
begin
  if Assigned(Control97List) then
  begin
    Control97List.Remove (AClass);
    if Control97List.Count = 0 then
    begin
      tb97Free(Control97List);
      Control97List := nil;
    end;
  end;
end;

{ TToolbarButton97ActionLink - internal }

procedure TToolbarButton97ActionLink.AssignClient (AClient: TObject);
begin
  inherited AssignClient(AClient);
  FClient := AClient as TCustomToolbarButton97;
end;

function TToolbarButton97ActionLink.IsCheckedLinked: Boolean;
begin
  Result := inherited IsCheckedLinked and
    (FClient.Down = (Action as TCustomAction).Checked);
end;

function TToolbarButton97ActionLink.IsHelpContextLinked: Boolean;
begin
  Result := inherited IsHelpContextLinked and
    (FClient.HelpContext = (Action as TCustomAction).HelpContext);
end;

function TToolbarButton97ActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and
    (FClient.ImageIndex = (Action as TCustomAction).ImageIndex);
end;

procedure TToolbarButton97ActionLink.SetChecked (Value: Boolean);
begin
  if IsCheckedLinked then
   FClient.Down := Value;
end;

procedure TToolbarButton97ActionLink.SetHelpContext (Value: THelpContext);
begin
  if IsHelpContextLinked then
   FClient.HelpContext := Value;
end;

procedure TToolbarButton97ActionLink.SetImageIndex (Value: Integer);
begin
  if IsImageIndexLinked then
   FClient.ImageIndex := Value;
end;

class function TToolbarButton97ActionLink.NewInstance: TObject;
  //override;
  {* - функция распределения памяти под экземпляр объекта. Перекрыта, для контроля за памятью на объекты. }
begin
 Result := inherited NewInstance;
 {$IfDef l3TraceObjects}
 l3System.RegisterObject(Result);
 {$EndIf l3TraceObjects}
end;

procedure TToolbarButton97ActionLink.FreeInstance;
  //override;
  {* - функция освобождения памяти экземпляра объекта. Перекрыта, для контроля за памятью на объекты. }
begin
 {$IfDef l3TraceObjects}
 l3System.UnregisterObject(Self);
 {$EndIf l3TraceObjects}
 inherited FreeInstance;
end;

{ TToolbarButton97 - internal }

type
  Ttb97GlyphList = class(TImageList)
  private
    Used: TBits;
    FCount: Integer;
    function AllocateIndex: Integer;
  public
    constructor CreateSize (AWidth, AHeight: Integer);
    destructor Destroy; override;
    function Add (Image, Mask: TBitmap): Integer;
    function AddMasked (Image: TBitmap; MaskColor: TColor): Integer;
    procedure Delete (Index: Integer);
    property Count: Integer read FCount;
  end;//Ttb97GlyphList

  Ttb97GlyphCache = class(Tl3ObjectList)
  public
    function GetList(AWidth, AHeight: Integer): Ttb97GlyphList;
    procedure ReturnList(List: Ttb97GlyphList);
    function Empty: Boolean;
  end;//Ttb97GlyphCache

  TBoolInt = record
    B: Boolean;
    I: Integer;
  end;

  TCustomImageListAccess = class(TCustomImageList);

  Ttb97ButtonGlyph = class(Tl3CacheableBase)
  private
    FOriginal, FOriginalMask: TBitmap;
    FGlyphList: array[Boolean] of Ttb97GlyphList;
    FImageIndex: Integer;
    FImageList: TCustomImageList;
    FImageChangeLink: TChangeLink;
    FIndexs: array[Boolean, TButtonState97] of Integer;
    FTransparentColor: TColor;
    FNumGlyphs: TNumGlyphs97;
    FGlyphSize: Ttb97GlyphSize;
    FOnChange: TNotifyEvent;
    procedure GlyphChanged (Sender: TObject);
    procedure SetGlyph (Value: TBitmap);
    procedure SetGlyphMask (Value: TBitmap);
    procedure SetNumGlyphs (Value: TNumGlyphs97);
    procedure UpdateNumGlyphs;
    procedure Invalidate;
    function CreateButtonGlyph (State: TButtonState97): TBoolInt;
    procedure DrawButtonGlyph(const aCanvas  : Il3Canvas;
                              const GlyphPos : TPoint;
                              State          : TButtonState97);
    procedure DrawButtonText(const aCanvas  : Il3Canvas;
                             const aCaption : Tl3WString;
                             TextBounds     : TRect;
                             aWordWrap      : Boolean;
                             anEllipsis     : Boolean;
                             Alignment      : TAlignment;
                             State          : TButtonState97);
    procedure DrawButtonDropArrow(const aCanvas : Il3Canvas;
                                  X, Y, AWidth  : Integer;
                                  State         : TButtonState97);
    procedure CalcButtonLayout(const aCanvas  : Il3Canvas;
                               const Client   : TRect;
                               const anOffset : TPoint;
                               DrawGlyph      : Boolean;
                               DrawCaption    : Boolean;
                               const aCaption : Tl3WString;
                               var aWordWrap  : Boolean;
                               AutoCenter     : Boolean;
                               Layout         : TButtonLayout;
                               Margin         : Integer;
                               Spacing        : Integer;
                               DropArrow      : Boolean;
                               DropArrowWidth : Integer;
                               var GlyphPos   : TPoint;
                               var ArrowPos   : TPoint;
                               var TextBounds : TRect);
      {* - определяет координаты отрисовки иконки и текста. }
    procedure CalcGlyphSize(var aSize : TSize);
      {* - размер иконки. }
    procedure Cleanup;
      override;
      {-}
  public
    constructor Create;
      reintroduce;
    { returns the text rectangle }
    function Draw(const aCanvas  : Il3Canvas;
                  const Client   : TRect;
                  const Offset   : TPoint;
                  DrawGlyph,
                  DrawCaption    : Boolean;
                  const aCaption : Tl3WString;
                  aWordWrap      : Boolean;
                  anEllipsis     : Boolean;
                  Alignment      : TAlignment;
                  Layout         : TButtonLayout;
                  Margin,
                  Spacing        : Integer;
                  DropArrow      : Boolean;
                  DropArrowWidth : Integer;
                  State          : TButtonState97;
                  AutoCenter     : Boolean) : TRect;
       {-}
    property Glyph: TBitmap read FOriginal write SetGlyph;
    property GlyphMask: TBitmap read FOriginalMask write SetGlyphMask;
    property NumGlyphs: TNumGlyphs97 read FNumGlyphs write SetNumGlyphs;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property GlyphSize: Ttb97GlyphSize read FGlyphSize write FGlyphSize default gsDefault;
  end;//Ttb97ButtonGlyph

{ Ttb97GlyphList }

constructor Ttb97GlyphList.CreateSize(AWidth, AHeight: Integer);
begin
  inherited CreateSize (AWidth, AHeight);
  Used := TBits.Create;
end;

destructor Ttb97GlyphList.Destroy;
begin
  tb97Free(Used);
  inherited;
end;

function Ttb97GlyphList.AllocateIndex: Integer;
begin
  Result := Used.OpenBit;
  if Result >= Used.Size then
  begin
    Result := inherited Add(nil, nil);
    Used.Size := Result + 1;
  end;
  Used[Result] := True;
end;

function Ttb97GlyphList.Add(Image, Mask: TBitmap): Integer;
begin
  Result := AllocateIndex;
  Replace (Result, Image, Mask);
  Inc (FCount);
end;

function Ttb97GlyphList.AddMasked(Image: TBitmap; MaskColor: TColor): Integer;
  procedure BugfreeReplaceMasked (Index: Integer; NewImage: TBitmap; MaskColor: TColor);
    procedure CheckImage (Image: TGraphic);
    begin
      if Image = nil then
       Exit;
      if (Image.Height < Height) or (Image.Width < Width) then
        raise EInvalidOperation.Create(SInvalidImageSize);
    end;
  var
    TempIndex: Integer;
    Image, Mask: TBitmap;
  begin
    if HandleAllocated then
    begin
      CheckImage(NewImage);
      TempIndex := inherited AddMasked(NewImage, MaskColor);
      if TempIndex <> -1 then
        try
          Image := nil;
          Mask := nil;
          try
            Image := Tl3Bitmap.Create;
            Image.Height := Height;
            Image.Width := Width;
            Mask := Tl3Bitmap.Create;
            Mask.Monochrome := True;
            { ^ Prevents the "invisible glyph" problem when used with certain
                color schemes. (Fixed in Delphi 3.01) }
            Mask.Height := Height;
            Mask.Width := Width;
            ImageList_Draw (Handle, TempIndex, Image.Canvas.Handle, 0, 0, ILD_NORMAL);
            ImageList_Draw (Handle, TempIndex, Mask.Canvas.Handle, 0, 0, ILD_MASK);
            if not ImageList_Replace(Handle, Index, Image.Handle, Mask.Handle) then
              raise EInvalidOperation.Create(SReplaceImage);
          finally
            tb97Free(Image);
            tb97Free(Mask);
          end;
        finally
          inherited Delete(TempIndex);
        end
      else
        raise EInvalidOperation.Create(SReplaceImage);
    end;
    Change;
  end;
begin
  Result := AllocateIndex;
  { This works two very serious bugs in the Delphi 2/BCB and Delphi 3
    implementations of the ReplaceMasked method. In the Delphi 2 and BCB
    versions of the ReplaceMasked method, it incorrectly uses ILD_NORMAL as
    the last parameter for the second ImageList_Draw call, in effect causing
    all white colors to be considered transparent also. And in the Delphi 2/3
    and BCB versions it doesn't set Monochrome to True on the Mask bitmap,
    causing the bitmaps to be invisible on certain color schemes. }
  BugfreeReplaceMasked (Result, Image, MaskColor);
  Inc (FCount);
end;

procedure Ttb97GlyphList.Delete(Index: Integer);
begin
  if Used[Index] then
  begin
    Dec(FCount);
    Used[Index] := False;
  end;
end;

{ Ttb97GlyphCache }

function Ttb97GlyphCache.GetList(AWidth, AHeight: Integer): Ttb97GlyphList;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
  begin
    Result := Ttb97GlyphList(Items[I]);
    with Result do
      if (AWidth = Width) and (AHeight = Height) then
       Exit;
  end;
  Result := Ttb97GlyphList.CreateSize(AWidth, AHeight);
  Add(Result);
end;

procedure Ttb97GlyphCache.ReturnList(List: Ttb97GlyphList);
begin
  if List = nil then
   Exit;
  if List.Count = 0 then
  begin
    Remove(List);
    tb97Free(List);
  end;
end;

function Ttb97GlyphCache.Empty: Boolean;
begin
  Result := Count = 0;
end;

var
  GlyphCache: Ttb97GlyphCache = nil;
  Pattern: TBitmap = nil;
  PatternBtnFace, PatternBtnHighlight: TColor;
  ButtonCount: Integer = 0;

procedure CreateBrushPattern;
var
  X, Y: Integer;
begin
  PatternBtnFace := GetSysColor(COLOR_BTNFACE);
  PatternBtnHighlight := GetSysColor(COLOR_BTNHIGHLIGHT);
  Pattern := Tl3Bitmap.Create;
  with Pattern do
  begin
    Width := 8;
    Height := 8;
    with Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := cDefBack;
      FillRect (Rect(0, 0, Width, Height));
      for Y := 0 to 7 do
        for X := 0 to 7 do
          if Odd(Y) = Odd(X) then  { toggles between even/odd pixels }
            Pixels[X, Y] := clBtnHighlight;     { on even/odd rows }
    end;
  end;
end;


{ Ttb97ButtonGlyph }

constructor Ttb97ButtonGlyph.Create;
var
  B: Boolean;
  I: TButtonState97;
begin
  inherited Create;
  FImageIndex := -1;
  FOriginal := Tl3Bitmap.Create;
  FOriginal.OnChange := GlyphChanged;
  FOriginalMask := Tl3Bitmap.Create;
  FOriginalMask.OnChange := GlyphChanged;
  FNumGlyphs := 1;
  FGlyphSize := gsDefault;
  for B := False to True do
    for I := Low(I) to High(I) do
      FIndexs[B, I] := -1;
  if GlyphCache = nil then
    GlyphCache := Ttb97GlyphCache.Make;
end;

procedure Ttb97ButtonGlyph.Cleanup;
  {-}
begin
  tb97Free(FOriginalMask);
  tb97Free(FOriginal);
  tb97Free(FImageChangeLink);
  Invalidate;
  if Assigned(GlyphCache) and GlyphCache.Empty then
  begin
   tb97Free(GlyphCache);
   GlyphCache := nil;
  end;//Assigned(GlyphCache)..
  FImageList := nil;
  FGlyphSize := gsDefault;
  inherited;
end;

procedure Ttb97ButtonGlyph.Invalidate;
var
  B: Boolean;
  I: TButtonState97;
begin
  for B := False to True do
  begin
    for I := Low(I) to High(I) do
      if FIndexs[B, I] <> -1 then
      begin
        FGlyphList[B].Delete (FIndexs[B, I]);
        FIndexs[B, I] := -1;
      end;
    GlyphCache.ReturnList (FGlyphList[B]);
    FGlyphList[B] := nil;
  end;
end;

procedure Ttb97ButtonGlyph.GlyphChanged (Sender: TObject);
begin
  if (Sender = FOriginal) and (FOriginal.Width <> 0) and (FOriginal.Height <> 0) then
    FTransparentColor := FOriginal.Canvas.Pixels[0, FOriginal.Height-1] or $02000000;
  Invalidate;
  if Assigned(FOnChange) then
   FOnChange (Self);
end;

procedure Ttb97ButtonGlyph.UpdateNumGlyphs;
var
  Glyphs: Integer;
begin
  if (FOriginal.Width <> 0) and (FOriginal.Height <> 0) and
     (FOriginal.Width mod FOriginal.Height = 0) then
  begin
    Glyphs := FOriginal.Width div FOriginal.Height;
    if Glyphs > High(TNumGlyphs97) then
     Glyphs := 1;
  end
  else
    Glyphs := 1;
  SetNumGlyphs (Glyphs);
end;

procedure Ttb97ButtonGlyph.SetGlyph (Value: TBitmap);
begin
  Invalidate;
  FOriginal.Assign (Value);
  UpdateNumGlyphs;
end;

procedure Ttb97ButtonGlyph.SetGlyphMask (Value: TBitmap);
begin
  Invalidate;
  FOriginalMask.Assign (Value);
end;

procedure Ttb97ButtonGlyph.SetNumGlyphs (Value: TNumGlyphs97);
begin
  Invalidate;
  if (FImageList <> nil) or (Value < Low(TNumGlyphs97)) or
     (Value > High(TNumGlyphs97)) then
    FNumGlyphs := 1
  else
    FNumGlyphs := Value;
  GlyphChanged (nil);
end;

function Ttb97ButtonGlyph.CreateButtonGlyph (State: TButtonState97): TBoolInt;
const
  ROP_DSPDxax = $00E20746;
  ROP_PSDPxax = $00B8074A;
  ROP_DSna = $00220326;  { D & ~S }

  procedure GenerateMaskBitmapFromDIB (const MaskBitmap, SourceBitmap: TBitmap;
    const SourceOffset, SourceSize: TPoint; TransColors: array of TColor);
  { This a special procedure meant for generating monochrome masks from
    >4 bpp color DIB sections. Because each video driver seems to sport its own
    interpretation of how to handle DIB sections, a workaround procedure like
    this was necessary. }
  type
    TColorArray = array[0..536870910] of TColorRef;
  var
    Info: packed record
      Header: TBitmapInfoHeader;
      Colors: array[0..1] of TColorRef;
    end;
    W, H: Integer;
    I, Y, X: Integer;
    Pixels: ^TColorArray;
    Pixel: ^TColorRef;
    MonoPixels: Pointer;
    MonoPixel, StartMonoPixel: ^Byte;
    MonoScanLineSize, CurBit: Integer;
    DC: HDC;
    MaskBmp: HBITMAP;
  begin
    W := SourceBitmap.Width;
    H := SourceBitmap.Height;
    MonoScanLineSize := SourceSize.X div 8;
    if SourceSize.X mod 8 <> 0 then
      Inc (MonoScanLineSize);
    if MonoScanLineSize mod 4 <> 0 then  { Compensate for scan line boundary }
      MonoScanLineSize := (MonoScanLineSize and not 3) + 4;
    MonoPixels := tb97AllocMem(MonoScanLineSize * SourceSize.Y);  { AllocMem is used because it initializes to zero }
    try
      tb97GetMem(Pixels, W * H * 4);
      try
        l3FillChar (Info, SizeOf(Info), 0);
        with Info do
        begin
          with Header do
          begin
            biSize := SizeOf(TBitmapInfoHeader);
            biWidth := W;
            biHeight := -H;  { negative number makes it a top-down DIB }
            biPlanes := 1;
            biBitCount := 32;
            {biCompression := BI_RGB;}  { implied due to the l3FillChar zeroing }
          end;
          {Colors[0] := clBlack;}  { implied due to the l3FillChar zeroing }
          Colors[1] := clWhite;
        end;
        DC := CreateCompatibleDC(0);
        GetDIBits (DC, SourceBitmap.Handle, 0, H, Pixels, PBitmapInfo(@Info)^,
          DIB_RGB_COLORS);
        DeleteDC (DC);

        for I := 0 to High(TransColors) do
          if TransColors[I] = -1 then
            TransColors[I] := Pixels[W * (H-1)] and $FFFFFF;
              { ^ 'and' operation is necessary because the high byte is undefined }

        MonoPixel := MonoPixels;
        for Y := SourceOffset.Y to SourceOffset.Y+SourceSize.Y-1 do
        begin
          StartMonoPixel := MonoPixel;
          CurBit := 7;
          Pixel := @Pixels[(Y * W) + SourceOffset.X];
          for X := 0 to SourceSize.X-1 do
          begin
            for I := 0 to High(TransColors) do
              if Pixel^ and $FFFFFF = Cardinal(TransColors[I]) then
              begin
                { ^ 'and' operation is necessary because the high byte is undefined }
                MonoPixel^ := MonoPixel^ or (1 shl CurBit);
                Break;
              end;
            Dec (CurBit);
            if CurBit < 0 then
            begin
              Inc (Integer(MonoPixel));
              CurBit := 7;
            end;
            Inc (Integer(Pixel), SizeOf(Longint));  { proceed to the next pixel }
          end;
          Integer(MonoPixel) := Integer(StartMonoPixel) + MonoScanLineSize;
        end;
      finally
        tb97FreeMem(Pixels);
      end;

      { Write new bits into a new HBITMAP, and assign this handle to MaskBitmap }
      MaskBmp := CreateBitmap(SourceSize.X, SourceSize.Y, 1, 1, nil);
      with Info.Header do
      begin
        biWidth := SourceSize.X;
        biHeight := -SourceSize.Y;  { negative number makes it a top-down DIB }
        biPlanes := 1;
        biBitCount := 1;
      end;
      DC := CreateCompatibleDC(0);
      SetDIBits (DC, MaskBmp, 0, SourceSize.Y, MonoPixels, PBitmapInfo(@Info)^,
        DIB_RGB_COLORS);
      DeleteDC (DC);
    finally
      tb97FreeMem(MonoPixels);
    end;

    MaskBitmap.Handle := MaskBmp;
  end;
  procedure GenerateMaskBitmap (const MaskBitmap, SourceBitmap: TBitmap;
    const SourceOffset, SourceSize: TPoint; const TransColors: array of TColor);
  { Returns handle of a monochrome bitmap, with pixels in SourceBitmap of color
    TransColor set to white in the resulting bitmap. All other colors of
    SourceBitmap are set to black in the resulting bitmap. This uses the
    regular ROP_DSPDxax BitBlt method. }
  var
    CanvasHandle: HDC;
    SaveBkColor: TColorRef;
    DC: HDC;
    MaskBmp, SaveBmp: HBITMAP;
    I: Integer;
  const
    ROP: array[Boolean] of DWORD = (SRCPAINT, SRCCOPY);
  begin
    CanvasHandle := SourceBitmap.Canvas.Handle;

    MaskBmp := CreateBitmap(SourceSize.X, SourceSize.Y, 1, 1, nil);
    DC := CreateCompatibleDC(0);
    SaveBmp := SelectObject(DC, MaskBmp);
    SaveBkColor := GetBkColor(CanvasHandle);
    for I := 0 to High(TransColors) do
    begin
      SetBkColor (CanvasHandle, ColorToRGB(TransColors[I]));
      BitBlt (DC, 0, 0, SourceSize.X, SourceSize.Y, CanvasHandle,
        SourceOffset.X, SourceOffset.Y, ROP[I = 0]);
    end;
    SetBkColor (CanvasHandle, SaveBkColor);
    SelectObject (DC, SaveBmp);
    DeleteDC (DC);

    MaskBitmap.Handle := MaskBmp;
  end;
  procedure ReplaceBitmapColorsFromMask (const MaskBitmap, DestBitmap: TBitmap;
    const DestOffset, DestSize: TPoint; const ReplaceColor: TColor);
  var
    DestDC: HDC;
    SaveBrush: HBRUSH;
    SaveTextColor, SaveBkColor: TColorRef;
  begin
    DestDC := DestBitmap.Canvas.Handle;

    SaveBrush := SelectObject(DestDC, CreateSolidBrush(ColorToRGB(ReplaceColor)));
    SaveTextColor := SetTextColor(DestDC, clBlack);
    SaveBkColor := SetBkColor(DestDC, clWhite);
    BitBlt (DestDC, DestOffset.X, DestOffset.Y, DestSize.X, DestSize.Y,
      MaskBitmap.Canvas.Handle, 0, 0, ROP_DSPDxax);
    SetBkColor (DestDC, SaveBkColor);
    SetTextColor (DestDC, SaveTextColor);
    DeleteObject (SelectObject(DestDC, SaveBrush));
  end;
  function CopyBitmapToDDB (const SourceBitmap: TBitmap): TBitmap;
  { Makes a device-dependent duplicate of SourceBitmap. The color palette,
    if any, is preserved. }
  var
    SB: HBITMAP;
    SavePalette: HPALETTE;
    DC: HDC;
    BitmapInfo: packed record
      Header: TBitmapInfoHeader;
      Colors: array[0..255] of TColorRef;
    end;
    Bits: Pointer;
  begin
    Result := Tl3Bitmap.Create;
    try
      Result.Palette := CopyPalette(SourceBitmap.Palette);
      Result.Width := SourceBitmap.Width;
      Result.Height := SourceBitmap.Height;
      SB := SourceBitmap.Handle;
      if SB = 0 then
       Exit;  { it would have a null handle if its width or height was zero }
      SavePalette := 0;
      DC := CreateCompatibleDC(0);
      try
        if Result.Palette <> 0 then
        begin
          SavePalette := SelectPalette(DC, Result.Palette, False);
          RealizePalette (DC);
        end;
        BitmapInfo.Header.biSize := SizeOf(TBitmapInfoHeader);
        BitmapInfo.Header.biBitCount := 0;  { instructs GetDIBits not to fill in the color table }
        { First retrieve the BitmapInfo header only }
        if GetDIBits(DC, SB, 0, 0, nil, PBitmapInfo(@BitmapInfo)^, DIB_RGB_COLORS) <> 0 then
        begin
          tb97GetMem(Bits, BitmapInfo.Header.biSizeImage);
          try
            { Then read the actual bits }
            if GetDIBits(DC, SB, 0, SourceBitmap.Height, Bits, PBitmapInfo(@BitmapInfo)^, DIB_RGB_COLORS) <> 0 then
              { And copy them to the resulting bitmap }
              SetDIBits (DC, Result.Handle, 0, SourceBitmap.Height, Bits, PBitmapInfo(@BitmapInfo)^, DIB_RGB_COLORS);
          finally
            tb97FreeMem(Bits);
          end;
        end;
      finally
        if SavePalette <> 0 then
         SelectPalette (DC, SavePalette, False);
        DeleteDC (DC);
      end;
    except
      tb97Free(Result);
      raise;
    end;
  end;
const
  ROPs: array[Boolean] of DWORD = (ROP_PSDPxax, ROP_DSPDxax);
var
  OriginalBmp, OriginalMaskBmp, TmpImage, DDB, MonoBmp, MaskBmp, UseMaskBmp: TBitmap;
  I: TButtonState97;
  B: Boolean;
  AddPixels, IWidth, IHeight, IWidthA, IHeightA: Integer;
  IRect, IRectA, SourceRect, R: TRect;
  DC: HDC;
  UsesMask: Boolean;
  IsHighColorDIB: Boolean;
begin
  if (State <> bsDisabled) and (Ord(State) >= NumGlyphs) then
    State := bsUp;
  Result.B := True;
  Result.I := FIndexs[True, State];
  if Result.I = -1 then
  begin
    Result.B := False;
    Result.I := FIndexs[False, State];
  end;
  if Result.I <> -1 then
   Exit;
  if FImageList = nil then
  begin
    if (FOriginal.Width = 0) or (FOriginal.Height = 0) then
     Exit;
    UsesMask := (FOriginalMask.Width <> 0) and (FOriginalMask.Height <> 0);
  end
  else
  begin
    if (FImageIndex < 0) or (FImageIndex >= FImageList.Count) then
     Exit;
    UsesMask := False;
  end;
  B := State <> bsDisabled;
  { + AddPixels is to make sure the highlight color on generated disabled glyphs
    doesn't get cut off }
  if FImageList = nil then
  begin
    IWidthA := FOriginal.Width div FNumGlyphs;
    IHeightA := FOriginal.Height;
  end
  else
  begin
    IWidthA := TCustomImageListAccess(FImageList).Width;
    IHeightA := TCustomImageListAccess(FImageList).Height;
  end;
  IRectA := Rect(0, 0, IWidthA, IHeightA);
  AddPixels := Ord(State = bsDisabled);
  IWidth := IWidthA + AddPixels;
  IHeight := IHeightA + AddPixels;
  IRect := Rect(0, 0, IWidth, IHeight);
  if FGlyphList[B] = nil then
  begin
    if GlyphCache = nil then
      GlyphCache := Ttb97GlyphCache.Make;
    FGlyphList[B] := GlyphCache.GetList(IWidth, IHeight);
  end;
  IsHighColorDIB := (FImageList = nil) and (FOriginal.PixelFormat > pf4bit);
  OriginalBmp := nil;
  OriginalMaskBmp := nil;
  TmpImage := nil;
  MaskBmp := nil;
  try
    OriginalBmp := Tl3Bitmap.Create;
    OriginalBmp.Assign (FOriginal);
    OriginalMaskBmp := Tl3Bitmap.Create;
    OriginalMaskBmp.Assign (FOriginalMask);
    TmpImage := Tl3Bitmap.Create;
    TmpImage.Width := IWidth;
    TmpImage.Height := IHeight;
    TmpImage.Canvas.Brush.Color := cDefBack;
    if FImageList = nil then
      TmpImage.Palette := CopyPalette(OriginalBmp.Palette);
    I := State;
    if Ord(I) >= NumGlyphs then
     I := bsUp;
    SourceRect := Bounds(Ord(I) * IWidthA, 0, IWidthA, IHeightA);
    if FImageList <> nil then
    begin
      MaskBmp := Tl3Bitmap.Create;
      MaskBmp.Monochrome := True;
      MaskBmp.Width := IWidthA;
      MaskBmp.Height := IHeightA;
      ImageList_Draw (FImageList.Handle, FImageIndex, MaskBmp.Canvas.Handle,
        0, 0, ILD_MASK);
    end;

    if State <> bsDisabled then
    begin
      if FImageList = nil then
      begin
        TmpImage.Canvas.CopyRect (IRectA, OriginalBmp.Canvas, SourceRect);
        if not UsesMask then
        begin
          { Use clDefault instead of FTransparentColor whereever possible to
            ensure compatibility with all video drivers when using high-color
            (> 4 bpp) DIB glyphs }
          FIndexs[B, State] := FGlyphList[B].AddMasked(TmpImage, clDefault);
        end
        else
        begin
          MonoBmp := Tl3Bitmap.Create;
          try
            MonoBmp.Monochrome := True;
            MonoBmp.Width := IWidth;
            MonoBmp.Height := IHeight;
            MonoBmp.Canvas.CopyRect (IRectA, OriginalMaskBmp.Canvas, SourceRect);
            FIndexs[B, State] := FGlyphList[B].Add(TmpImage, MonoBmp);
          finally
            tb97Free(MonoBmp);
          end;
        end;
      end
      else
      begin
        ImageList_Draw (FImageList.Handle, FImageIndex, TmpImage.Canvas.Handle,
          0, 0, ILD_NORMAL);
        FIndexs[B, State] := FGlyphList[B].Add(TmpImage, MaskBmp);
      end;
    end
    else
    begin
      MonoBmp := nil;
      DDB := nil;
      try
        MonoBmp := Tl3Bitmap.Create;
        { Uses the CopyBitmapToDDB to work around a Delphi 3 flaw. If you copy
          a DIB to a second bitmap via Assign, change the HandleType of the
          second bitmap to bmDDB, then try to read the Handle property, Delphi
          converts it back to a DIB. }
        if FImageList = nil then
          DDB := CopyBitmapToDDB(OriginalBmp)
        else
        begin
          DDB := Tl3Bitmap.Create;
          DDB.Width := IWidthA;
          DDB.Height := IHeightA;
          ImageList_Draw (FImageList.Handle, FImageIndex, DDB.Canvas.Handle,
            0, 0, ILD_NORMAL);
        end;
        if NumGlyphs > 1 then
          with TmpImage.Canvas do
          begin
            CopyRect (IRectA, DDB.Canvas, SourceRect);

            { Convert white to clBtnHighlight }
            if not IsHighColorDIB then
              GenerateMaskBitmap (MonoBmp, DDB, SourceRect.TopLeft,
                IRectA.BottomRight, [GetNearestColor(OriginalBmp.Canvas.Handle, clWhite)])
            else
              GenerateMaskBitmapFromDIB (MonoBmp, OriginalBmp, SourceRect.TopLeft,
                IRectA.BottomRight, [clWhite]);
            ReplaceBitmapColorsFromMask (MonoBmp, TmpImage, IRectA.TopLeft,
              IRectA.BottomRight, clBtnHighlight);

            { Convert gray to clBtnShadow }
            if not IsHighColorDIB then
              GenerateMaskBitmap (MonoBmp, DDB, SourceRect.TopLeft,
                IRectA.BottomRight, [GetNearestColor(OriginalBmp.Canvas.Handle, clGray)])
            else
              GenerateMaskBitmapFromDIB (MonoBmp, OriginalBmp, SourceRect.TopLeft,
                IRectA.BottomRight, [clGray]);
            ReplaceBitmapColorsFromMask (MonoBmp, TmpImage, IRectA.TopLeft,
              IRectA.BottomRight, clBtnShadow);

            if not UsesMask then
            begin
              { Generate the transparent mask in MonoBmp. The reason why
                it doesn't just use a mask color is because the mask needs
                to be of the glyph -before- the clBtnHighlight/Shadow were
                translated }
              if not IsHighColorDIB then
                GenerateMaskBitmap (MonoBmp, DDB,
                  SourceRect.TopLeft, IRectA.BottomRight, FTransparentColor)
              else
                GenerateMaskBitmapFromDIB (MonoBmp, OriginalBmp,
                  SourceRect.TopLeft, IRectA.BottomRight, [-1]);
            end
            else
              MonoBmp.Canvas.CopyRect (IRectA, OriginalMaskBmp.Canvas, SourceRect);
            with MonoBmp do
            begin
              Width := Width + AddPixels;
              Height := Height + AddPixels;
              { Set the additional bottom and right row on disabled glyph
                masks to white so that it always shines through, since the
                bottom and right row on TmpImage was left uninitialized }
              Canvas.Pen.Color := clWhite;
              Canvas.PolyLine ([Point(0, Height-1), Point(Width-1, Height-1),
                Point(Width-1, -1)]);
            end;

            FIndexs[B, State] := FGlyphList[B].Add(TmpImage, MonoBmp);
          end
        else
        begin
          { Create a disabled version }
          begin
            { The new Office 97 / MFC look }
            if not UsesMask and (FImageList = nil) then
            begin
              with TmpImage.Canvas do
              begin
                if not IsHighColorDIB then
                  GenerateMaskBitmap (MonoBmp, DDB, IRectA.TopLeft,
                    IRectA.BottomRight, [FTransparentColor, clWhite, clSilver])
                else
                  GenerateMaskBitmapFromDIB (MonoBmp, OriginalBmp,
                    SourceRect.TopLeft, IRectA.BottomRight, [-1, clWhite, clSilver]);
              end;
            end
            else
            begin
              { Generate the mask in MonoBmp. Make clWhite and clSilver transparent. }
              if not IsHighColorDIB then
                GenerateMaskBitmap (MonoBmp, DDB, SourceRect.TopLeft,
                  IRectA.BottomRight, [clWhite, clSilver])
              else
                GenerateMaskBitmapFromDIB (MonoBmp, OriginalBmp, SourceRect.TopLeft,
                  IRectA.BottomRight, [clWhite, clSilver]);
              if FImageList = nil then
                UseMaskBmp := OriginalMaskBmp
              else
                UseMaskBmp := MaskBmp;
              { and all the white colors in UseMaskBmp }
              with Tl3Bitmap.Create do
                try
                  Monochrome := True;
                  Width := UseMaskBmp.Width;
                  Height := UseMaskBmp.Height;
                  R := Rect(0, 0, Width, Height);
                  Canvas.CopyRect (R, UseMaskBmp.Canvas, R);
                  DC := Canvas.Handle;
                  with MonoBmp.Canvas do
                  begin
                    BitBlt (Handle, 0, 0, IWidthA, IHeightA, DC,
                      SourceRect.Left, SourceRect.Top, ROP_DSna);
                    BitBlt (Handle, 0, 0, IWidthA, IHeightA, DC,
                      SourceRect.Left, SourceRect.Top, SRCPAINT);
                  end;
                finally
                  Free;
                end;
            end;
          end;

          with TmpImage.Canvas do
          begin
            Brush.Color := cDefBack;
            FillRect (IRect);
            Brush.Color := clBtnHighlight;
            DC := Handle;
            SetTextColor (DC, clBlack);
            SetBkColor (DC, clWhite);
            BitBlt (DC, 1, 1, IWidthA, IHeightA,
              MonoBmp.Canvas.Handle, 0, 0, ROPs[false]);
            Brush.Color := clBtnShadow;
            DC := Handle;
            SetTextColor (DC, clBlack);
            SetBkColor (DC, clWhite);
            BitBlt (DC, 0, 0, IWidthA, IHeightA,
              MonoBmp.Canvas.Handle, 0, 0, ROPs[false]);
          end;

          FIndexs[B, State] := FGlyphList[B].AddMasked(TmpImage, cDefBack);
        end;
      finally
        tb97Free(DDB);
        tb97Free(MonoBmp);
      end;
    end;
  finally
    tb97Free(MaskBmp);
    tb97Free(TmpImage);
    tb97Free(OriginalMaskBmp);
    tb97Free(OriginalBmp);
  end;
  Result.B := B;
  Result.I := FIndexs[B, State];
  { Note: Due to a bug in graphics.pas, Delphi 2's VCL crashes if Dormant is
    called on an empty bitmap, so to prevent this it must check Width/Height
    first }
    FOriginal.Dormant;
    FOriginalMask.Dormant;
end;

procedure Ttb97ButtonGlyph.DrawButtonGlyph(const aCanvas: Il3Canvas; const GlyphPos: TPoint;
  State: TButtonState97);
var
  Index: TBoolInt;
  vtGlyphSize: TvtPILSize;
begin
  if (FImageList <> nil) and
    {$IFDEF DesignTimeLibrary}
     (FImageList is TvtPngImageList)
    {$ELSE}
     {$IfDef l3HackedVCL}
     FImageList.IsSmart
     {$Else}
     (FImageList is TvtPngImageList)
     {$EndIf}
    {$ENDIF}
     then
  begin
   if FGlyphSize = gsDefault then
    FImageList.Draw(aCanvas.Canvas, GlyphPos.X, GlyphPos.Y, FImageIndex, State <> bsDisabled)
   else
   begin
    vtGlyphSize := TvtPILSize(Ord(FGlyphSize) - 1);
    TvtPngImageList(FImageList).DrawGlyphSpecified(FImageIndex,
                                                   aCanvas.Canvas,
                                                   vtGlyphSize,
                                                   bpp24,
                                                   GlyphPos.X,
                                                   GlyphPos.Y,
                                                   State <> bsDisabled);
   end;
  end else
  begin
   Index := CreateButtonGlyph(State);
   if Index.I <> -1 then
    ImageList_DrawEx (FGlyphList[Index.B].Handle, Index.I, aCanvas.DC,
       GlyphPos.X, GlyphPos.Y, 0, 0, CLR_NONE, CLR_NONE, ILD_TRANSPARENT);
  end;//FImageList <> nil
end;

procedure Ttb97ButtonGlyph.DrawButtonText(const aCanvas  : Il3Canvas;
                                          const aCaption : Tl3WString;
                                          TextBounds     : TRect;
                                          aWordWrap      : Boolean;
                                          anEllipsis     : Boolean;
                                          Alignment      : TAlignment;
                                          State          : TButtonState97);
const
  AlignmentFlags: array[TAlignment] of UINT = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  Format: UINT;
begin
  if anEllipsis
   then Format := DT_END_ELLIPSIS or DT_VCENTER or AlignmentFlags[Alignment]
   else Format := DT_VCENTER or AlignmentFlags[Alignment];
  if not aWordWrap
   then Format := Format or DT_SINGLELINE
   else Format := Format or DT_WORDBREAK;
  with aCanvas do
  begin
    //Canvas.Brush.Style := bsClear;
    if State = bsDisabled then
    begin
      OffsetRect(TextBounds, 1, 1);
      Font.ForeColor := clBtnHighlight;
      DrawText(aCaption, TextBounds, Format);
      OffsetRect (TextBounds, -1, -1);
      Font.ForeColor := clBtnShadow;
      DrawText(aCaption, TextBounds, Format);
    end
    else
      DrawText(aCaption, TextBounds, Format);
  end;//with aCanvas
end;

procedure Ttb97ButtonGlyph.DrawButtonDropArrow(const aCanvas : Il3Canvas;
                                               X, Y, AWidth  : Integer;
                                               State         : TButtonState97);
var
 l_D : Integer;
begin
 with aCanvas.Canvas do
 begin
  l_D := AWidth div 2;
  X := X + l_D - 1;
  Dec(l_D, l_D div 2);
  if (State = bsDisabled) then
  begin
   Pen.Color := clBtnHighlight;
   Brush.Color := clBtnHighlight;
   Inc(X);
   Inc(Y);
   Polygon ([Point(X - l_D, Y), Point(X + l_D, Y), Point(X, Y + l_D)]);
   Dec(X);
   Dec(Y);
   Pen.Color := clBtnShadow;
   Brush.Color := clBtnShadow;
   Polygon ([Point(X - l_D, Y), Point(X + l_D, Y), Point(X, Y + l_D)]);
  end//State = bsDisabled
  else
  begin
   Pen.Color := Font.Color;
   Brush.Color := Font.Color;
   Polygon ([Point(X - l_D, Y), Point(X + l_D, Y), Point(X, Y + l_D)]);
  end;//State = bsDisabled
 end;//with aCanvas.Canvas
end;

procedure Ttb97ButtonGlyph.CalcGlyphSize(var aSize : TSize);
begin
 l3FillChar(aSize, SizeOf(aSize), 0);
 if FImageList = nil then
 begin
  if FOriginal <> nil then
  begin
   aSize.cx := FOriginal.Width div FNumGlyphs;
   aSize.cy := FOriginal.Height;
  end;
 end
 else
 begin
 {$IF DEFined(DesignTimeLibrary) OR not Defined(l3HackedVCL)}
  if FImageList is TvtPngImageList then
   if FGlyphSize <> gsDefault then
    aSize := cGlyphSize[FGlyphSize]
   else
   with TvtPngImageList(FImageList){$ifNDef XE}.ImageExtent(FImageIndex){$EndIf} do
   begin
    {$ifDef XE}
    aSize.cx := Width;
    aSize.cy := Height;
    {$Else}
    aSize.cx := X;
    aSize.cy := Y;
    {$EndIf}
   end
  else
  begin
   aSize.cx := FImageList.Width;
   aSize.cy := FImageList.Height;
  end;
 {$ELSE}
  if FGlyphSize <> gsDefault then
   aSize := cGlyphSize[FGlyphSize]
  else
  with FImageList.ImageExtent(FImageIndex) do
  begin
   aSize.cx := X;
   aSize.cy := Y;
  end;
 {$IfEND}
 end;
end;

procedure Ttb97ButtonGlyph.CalcButtonLayout (const aCanvas  : Il3Canvas;
                                             const Client   : TRect;
                                             const anOffset : TPoint;
                                             DrawGlyph      : Boolean;
                                             DrawCaption    : Boolean;
                                             const aCaption : Tl3WString;
                                             var aWordWrap  : Boolean;
                                             AutoCenter     : Boolean;
                                             Layout         : TButtonLayout;
                                             Margin         : Integer;
                                             Spacing        : Integer;
                                             DropArrow      : Boolean;
                                             DropArrowWidth : Integer;
                                             var GlyphPos   : TPoint;
                                             var ArrowPos   : TPoint;
                                             var TextBounds : TRect);
var
  ArrowSize: TPoint;
  
////////////////////////////////////////////////////////////////////////////////
  procedure lpCheckBounds;
  const
   cGlyphMargin = 6;
  var
   lDelta : Integer;
  begin
   lDelta := 0;
   // Правая граница прямоугольника для вывода текста не может быть больше
   // клиентской области
   if (TextBounds.Right > Client.Right - ArrowSize.X) then
   begin
    TextBounds.Right := Client.Right - ArrowSize.X;
    ArrowPos.X := TextBounds.Right;
   end;//TextBounds.Right
   // Иконка не вместилась
   if DrawGlyph then
    if (GlyphPos.X < 0) then
    begin
     lDelta := Abs(GlyphPos.X) + cGlyphMargin;
     GlyphPos.X := cGlyphMargin;
    end;
   // Исправим прямоугольник с текстом если он больше клиентской области
   if DrawCaption then
    if lDelta > 0 then
     Inc(TextBounds.Left, Succ(lDelta));
  end;
////////////////////////////////////////////////////////////////////////////////

var
  l_TextPos         : TPoint;
  ClientSize        : TPoint;
  GlyphSize         : TPoint;
  TextSize          : TPoint;
  HasGlyph          : Boolean;
  TotalSize         : TPoint;
  Format            : UINT;
  Margin1           : Integer;
  Spacing1          : Integer;
  LayoutLeftOrRight : Boolean;
  lSize             : TSize;
  l_ML : Il3MultiLines;
begin
  { calculate the item sizes }
  ClientSize := Point(Client.Right-Client.Left, Client.Bottom-Client.Top);

  GlyphSize.X := 0;
  GlyphSize.Y := 0;
  if DrawGlyph then
  begin
   CalcGlyphSize(lSize);
   GlyphSize.X := lSize.cx;
   GlyphSize.Y := lSize.cy;
  end;
  HasGlyph := (GlyphSize.X <> 0) and (GlyphSize.Y <> 0);

  if DropArrow then
  begin
   ArrowSize.X := DropArrowWidth;
   ArrowSize.Y := 3;
  end
  else
  begin
   ArrowSize.X := 0;
   ArrowSize.Y := 0;
  end;//DropArrow

  LayoutLeftOrRight := Layout in [blGlyphLeft, blGlyphRight];
  if not LayoutLeftOrRight and not HasGlyph then
  begin
    Layout := blGlyphLeft;
    LayoutLeftOrRight := True;
  end;

  if DrawCaption and not l3IsNil(aCaption) then
  begin
    TextBounds := Rect(0, 0, Client.Right - Client.Left, 0);
    if LayoutLeftOrRight then
      Dec (TextBounds.Right, ArrowSize.X);
    Format := DT_CALCRECT;
    if aWordWrap then
    begin
      Format := Format or DT_WORDBREAK;
      Margin1 := 4;
      if LayoutLeftOrRight and HasGlyph then
      begin
        if Spacing = -1 then
          Spacing1 := 4
        else
          Spacing1 := Spacing;
        Dec (TextBounds.Right, GlyphSize.X + Spacing1);
        if Margin <> -1 then
          Margin1 := Margin
        else
        if Spacing <> -1 then
          Margin1 := Spacing;
      end;
      Dec (TextBounds.Right, Margin1 * 2);
     l_ML := aCanvas.DrawText (aCaption, TextBounds, Format);
     aWordWrap := not l_ML.IsSingle and not (l_ML.HasBreakInWord OR (TextBounds.Bottom > ClientSize.Y + 3));
     if not aWordWrap then
      Format := Format and (not DT_WORDBREAK);
    end;//aWordWrap
    if not aWordWrap then
    begin
     Format := Format or DT_END_ELLIPSIS;
     aCanvas.DrawText(aCaption, TextBounds, Format);
    end;//aWordWrap
    TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom -
      TextBounds.Top);
  end//DrawCaption
  else
  begin
    TextBounds := Rect(0, 0, 0, 0);
    TextSize := Point(0,0);
  end;//DrawCaption

  { If the layout has the glyph on the right or the left, then both the
    text and the glyph are centered vertically.  If the glyph is on the top
    or the bottom, then both the text and the glyph are centered horizontally.}
  if LayoutLeftOrRight then
  begin
   GlyphPos.Y := (ClientSize.Y - GlyphSize.Y + 1) div 2;
   l_TextPos.Y := (ClientSize.Y - TextSize.Y + 1) div 2;
  end//LayoutLeftOrRight
  else
  begin
   GlyphPos.X := (ClientSize.X - GlyphSize.X - ArrowSize.X + 1) div 2;
   l_TextPos.X := (ClientSize.X - TextSize.X + 1) div 2;
   if not HasGlyph then
     ArrowPos.X := l_TextPos.X + TextSize.X
   else
     ArrowPos.X := GlyphPos.X + GlyphSize.X;
  end;//LayoutLeftOrRight

  { if there is no text or no bitmap, then Spacing is irrelevant }
  if (TextSize.X = 0) or (TextSize.Y = 0) or not HasGlyph then
    Spacing := 0;

  { adjust Margin and Spacing }
  if not AutoCenter then
   if Margin = -1 then
   begin
     if Spacing = -1 then
     begin
       TotalSize := Point(GlyphSize.X + TextSize.X + ArrowSize.X,
         GlyphSize.Y + TextSize.Y);
       if LayoutLeftOrRight then
         Margin := (ClientSize.X - TotalSize.X) div 3
       else
         Margin := (ClientSize.Y - TotalSize.Y) div 3;
       Spacing := Margin;
     end
     else
     begin
       TotalSize := Point(GlyphSize.X + Spacing + TextSize.X + ArrowSize.X,
         GlyphSize.Y + Spacing + TextSize.Y);
       if LayoutLeftOrRight then
         Margin := (ClientSize.X - TotalSize.X + 1) div 2
       else
         Margin := (ClientSize.Y - TotalSize.Y + 1) div 2;
     end;
   end
  else
  begin
    if Spacing = -1 then
    begin
      TotalSize := Point(ClientSize.X - (Margin + GlyphSize.X + ArrowSize.X),
        ClientSize.Y - (Margin + GlyphSize.Y));
      if LayoutLeftOrRight then
        Spacing := (TotalSize.X - TextSize.X) div 2
      else
        Spacing := (TotalSize.Y - TextSize.Y) div 2;
    end;
  end;

  case Layout of
    blGlyphLeft: begin
        GlyphPos.X := Margin;
        l_TextPos.X := GlyphPos.X + GlyphSize.X + Spacing;
        ArrowPos.X := l_TextPos.X + TextSize.X;
      end;
    blGlyphRight: begin
        ArrowPos.X := ClientSize.X - Margin - ArrowSize.X;
        GlyphPos.X := ArrowPos.X - GlyphSize.X;
        l_TextPos.X := GlyphPos.X - Spacing - TextSize.X;
      end;
    blGlyphTop: begin
        GlyphPos.Y := Margin;
        l_TextPos.Y := GlyphPos.Y + GlyphSize.Y + Spacing;
      end;
    blGlyphBottom: begin
        GlyphPos.Y := ClientSize.Y - Margin - GlyphSize.Y;
        l_TextPos.Y := GlyphPos.Y - Spacing - TextSize.Y;
      end;
  end;//case Layout
  Inc (ArrowPos.X);
  if not HasGlyph then
    ArrowPos.Y := l_TextPos.Y + (TextSize.Y - ArrowSize.Y) div 2
  else
    ArrowPos.Y := GlyphPos.Y + (GlyphSize.Y - ArrowSize.Y) div 2;

  { fixup the result variables }
  with GlyphPos do
  begin
    Inc (X, Client.Left + anOffset.X);
    Inc (Y, Client.Top + anOffset.Y);
  end;//with GlyphPos
  with ArrowPos do
  begin
    Inc (X, Client.Left + anOffset.X);
    Inc (Y, Client.Top + anOffset.Y);
  end;//with GlyphPos
{  if aWordWrap then
   l_TextPos.Y := Max(0, l_TextPos.Y);}
  OffsetRect(TextBounds, l_TextPos.X + Client.Left + anOffset.X,
    l_TextPos.Y + Client.Top + anOffset.Y);
////////////////////////////////////////////////////////////////////////////////
  lpCheckBounds;
////////////////////////////////////////////////////////////////////////////////
end;

function Ttb97ButtonGlyph.Draw(const aCanvas  : Il3Canvas;
                               const Client   : TRect;
                               const Offset   : TPoint;
                               DrawGlyph      : Boolean;
                               DrawCaption    : Boolean;
                               const aCaption : Tl3WString;
                               aWordWrap      : Boolean;
                               anEllipsis     : Boolean;
                               Alignment      : TAlignment;
                               Layout         : TButtonLayout;
                               Margin         : Integer;
                               Spacing        : Integer;
                               DropArrow      : Boolean;
                               DropArrowWidth : Integer;
                               State          : TButtonState97;
                               AutoCenter     : Boolean) : TRect;
var
 GlyphPos, ArrowPos: TPoint;
 l_Wrap: Boolean;
begin
 l_Wrap := aWordWrap;
 CalcButtonLayout(aCanvas, Client, Offset, DrawGlyph, DrawCaption, aCaption,
   l_Wrap, AutoCenter, Layout, Margin, Spacing, DropArrow, DropArrowWidth, GlyphPos,
   ArrowPos, Result);
 if DrawGlyph then
  DrawButtonGlyph(aCanvas, GlyphPos, State);
 if DrawCaption then
  DrawButtonText(aCanvas, aCaption, Result, l_Wrap, anEllipsis, Alignment, State);
 if DropArrow then
   DrawButtonDropArrow(aCanvas, ArrowPos.X, ArrowPos.Y, DropArrowWidth, State);
end;

{ TToolbarButton97 }

procedure ButtonHookProc (Code: THookProcCode; Wnd: HWND; WParam: WPARAM; LParam: LPARAM);
var
  P: TPoint;
begin
  case Code of
    hpSendActivateApp:
      if (WParam = 0) and Assigned(ButtonMouseInControl) and
         not ButtonMouseInControl.FShowBorderWhenInactive then
        ButtonMouseInControl.MouseLeft;
    hpPostMouseMove: begin
        if Assigned(ButtonMouseInControl) then
        begin
          GetCursorPos (P);
          if FindDragTarget(P, True) <> ButtonMouseInControl then
            ButtonMouseInControl.MouseLeft;
        end;
      end;
  end;
end;

constructor TCustomToolbarButton97.Create (AOwner: TComponent);
begin
  inherited;
  (* По умолчанию элемента в списке нет *)
  FEllipsis := True;
  fIndex := -1;
  FNeedAdjustSize := True;
  if ButtonMouseTimer = nil then
  begin
    ButtonMouseTimer := TTimer.Create(nil);
    ButtonMouseTimer.Enabled := False;
    ButtonMouseTimer.Interval := 125;  { 8 times a second }
  end;

  InstallHookProc (ButtonHookProc, [hpSendActivateApp, hpPostMouseMove],
    csDesigning in ComponentState);

  SetBounds (Left, Top, 23, 22);
  ControlStyle := [csCaptureMouse, csDoubleClicks, csOpaque];
  Color := cDefBack;
  FGlyph := Ttb97ButtonGlyph.Create;
  Ttb97ButtonGlyph(FGlyph).OnChange := GlyphChanged;
  ParentFont := True;
  FAlignment := taLeftJustify;//taCenter;
  FGlyphSize := gsDefault;
  {$IfNdef tb97AlwaysFlat}
  FFlat := True;
  {$EndIf tb97AlwaysFlat}
  FOpaque := True;
  {$IfDef tb97NeedSpacing}
  FSpacing := 4;
  {$EndIf tb97NeedSpacing}
  FMargin := -1;
  FLayout := blGlyphLeft;
  FDropdownArrow := True;
  FDropdownArrowWidth := DefaultDropdownArrowWidth;
  Inc(ButtonCount);
end;

procedure TCustomToolbarButton97.Cleanup;
begin
  RemoveButtonMouseTimer;
  tb97Free(Ttb97ButtonGlyph(FGlyph));
  { The Notification method, which is sometimes called while the component is
    being destroyed, reads FGlyph and expects it to be valid, so it must be
    reset to nil }
  FGlyph := nil;
  UninstallHookProc (ButtonHookProc);
  Dec(ButtonCount);
  if (ButtonCount = 0) then
  begin
   tb97Free(Pattern);
   tb97Free(ButtonMouseTimer);
  end;//ButtonCount = 0
  FGlyphSize := gsDefault;
  FEllipsis := True;
  inherited;
end;

function TCustomToolbarButton97.GetIsAutoCenter: Boolean;
begin
 Result := False;
end;

procedure TCustomToolbarButton97.DoPaint(const aCN: Il3Canvas);
const
  EdgeStyles: array[Boolean, Boolean] of UINT = (
    (EDGE_RAISED, EDGE_SUNKEN),
    (BDR_RAISEDINNER, BDR_SUNKENOUTER));
  FlagStyles: array[Boolean] of UINT = (BF_RECT or BF_SOFT or BF_MIDDLE, BF_RECT);
  
{$IfDef NemesisToolButtonStyle}
type
  TToolButtonState = (tbsNone, tbsDown, tbsSelect, tbsDownSelect);
const
  cToolButtonBackground: array[TToolButtonState] of TColor = (clNone, $00F3E7D1, $00F3E7D1, $00E1B293);
  cBorderColor = $00FF8888;
{$EndIf NemesisToolButtonStyle}
var
  UseBmp     : Boolean;
  l_Bmp      : Tl3Bitmap;
  l_DC       : Il3Canvas;
  l_F        : Il3Font;
  PaintRect,
  R          : TRect;
  Offset     : TPoint;
  StateDownOrExclusive, DropdownComboShown, UseDownAppearance, DrawBorder: Boolean;
  {$IfDef NemesisToolButtonStyle}
  l_ToolButtonState: TToolButtonState;
  {$EndIf NemesisToolButtonStyle}
begin
 if Locked then
 begin
  inherited;
  Exit;
 end;//Locked
 //UseBmp := false;
 UseBmp := Opaque or not Flat;
 if UseBmp then
  l_Bmp := Tl3Bitmap.Create
 else
  l_Bmp := nil;
 try
  l_DC := nil;
  try
   if UseBmp then
   begin
    l_Bmp.Width := Width;
    l_Bmp.Height := Height;
    l_DC := l_Bmp.CanvasEx;
   end//UseBmp
   else
    l_DC := aCN;

   {$IfDef NemesisToolButtonStyle}
   l_ToolButtonState := tbsNone;
   if not (csDesigning in ComponentState) and (FState <> bsDisabled) then
   begin
    if FMouseInControl then
     case (FState) of
       bsMouseIn,
       bsUp:
       begin
        l_ToolButtonState := tbsSelect;
       end;
       bsDown,
       bsExclusive:
       begin
        l_ToolButtonState := tbsDownSelect;
       end;
     else
       l_ToolButtonState := tbsNone;
     end
    else
     if (FState in [bsDown, bsExclusive]) then
      l_ToolButtonState := tbsDown;
   end;
   if l_ToolButtonState = tbsNone then
    l_DC.BackColor := Color
   else
   begin
    l_DC.BackColor := cToolButtonBackground[l_ToolButtonState];
    l_DC.Canvas.Pen.Color := cBorderColor;
   end;
   {$Else NemesisToolButtonStyle}
   l_DC.BackColor := Color;
   {$EndIf NemesisToolButtonStyle}
   l_DC.BeginPaint;
   try
    l_DC.DrawEnabled := true;
    if UseBmp then
    begin
     l_DC.FillRect(Tl3SRect(ClientRect));
    end;//UseBmp
    l_F := l_DC.Font;
    try
     l_F.AssignFont(Self.Font);
    finally
     l_F := nil;
    end;//try..finally

    PaintRect := Rect(0, 0, Width, Height);
    StateDownOrExclusive := FState in [bsDown, bsExclusive];
    DropdownComboShown := FDropdownCombo {and FUsesDropdown};
    UseDownAppearance := (FState = bsExclusive) or
      ((FState = bsDown) and (not DropdownComboShown or not FMenuIsDown));
    DrawBorder := (csDesigning in ComponentState) or
      (not FNoBorder and (not Flat or StateDownOrExclusive or (FMouseInControl and (FState <> bsDisabled))));
    if DropdownComboShown then
    begin
      {$IfDef NemesisToolButtonStyle}
      R := PaintRect;
      Dec(R.Right, cDropDownComboSpace);
      R.Left := R.Right - DropdownArrowWidth;
      l_DC.FillRect(Tl3SRect(R));
      if l_ToolButtonState in [tbsDown, tbsSelect, tbsDownSelect] then
        Rectangle(l_DC.DC, R.Left, R.Top, R.Right, R.Bottom);
      {$Else NemesisToolButtonStyle}
      if DrawBorder then
      begin
        R := PaintRect;
        Dec(R.Right, cDropDownComboSpace);
        R.Left := R.Right - DropdownArrowWidth;
        DrawEdge(l_DC.DC, R,
          EdgeStyles[Flat, StateDownOrExclusive and FMenuIsDown],
          FlagStyles[Flat]);
      end;//DrawBorder
      {$EndIf NemesisToolButtonStyle}
      Dec (PaintRect.Right, DropdownArrowWidth + cDropDownComboSpace);
    end;//DropdownComboShown
    {$IfDef NemesisToolButtonStyle}
    l_DC.FillRect(Tl3SRect(PaintRect));
    if l_ToolButtonState in [tbsDown, tbsSelect, tbsDownSelect] then
     with PaintRect do
      Rectangle(l_DC.DC, Left, Top, Right, Bottom);
    {$Else NemesisToolButtonStyle}
    if DrawBorder then
     DrawEdge (l_DC.DC, PaintRect, EdgeStyles[Flat, UseDownAppearance],
      FlagStyles[Flat]);
    {$EndIf NemesisToolButtonStyle}
    if not FNoBorder then
    begin
      if Flat then
        InflateRect (PaintRect, -1, -1)
      else
        InflateRect (PaintRect, -2, -2);
    end;//not FNoBorder

    if UseDownAppearance then
    begin
      if (FState = bsExclusive) and (not Flat or not FMouseInControl) and
         not FMenuIsDown then
      begin
       {$IfDef NemesisToolButtonStyle}
        with l_DC.Canvas do
        begin
         if l_ToolButtonState in [tbsDown, tbsSelect, tbsDownSelect] then
          with PaintRect do
           Rectangle(Left, Top, Right, Bottom);
         FillRect(PaintRect);
        end;//with l_DC.Canvas
       {$Else NemesisToolButtonStyle}
        if Pattern = nil then
         CreateBrushPattern;
        with l_DC.Canvas do
        begin
         Brush.Bitmap := Pattern;
         FillRect(PaintRect);
        end;//with l_DC.Canvas
       {$EndIf NemesisToolButtonStyle}
      end;
      Offset.X := 1;
      Offset.Y := 1;
    end
    else
    begin
      Offset.X := 0;
      Offset.Y := 0;
    end;

    {$IfDef tb97NeedCustomGlyphDraw}
    if Assigned(FOnCustomGlyphDraw) then
     FOnCustomGlyphDraw(Self, l_DC, PaintRect, FState)
    else
    {$EndIf tb97NeedCustomGlyphDraw}
     Ttb97ButtonGlyph(FGlyph).Draw(l_DC, PaintRect, Offset,
       FDisplayMode <> dmTextOnly, (FDisplayMode <> dmGlyphOnly) and (FDisplayMode <> dmGlyphAndFakeText),
       l3PCharLen(CCaption), WordWrap, FEllipsis, FAlignment, FLayout, FMargin, Spacing,
       NeedDropArrow, DropdownArrowWidth, FState, GetIsAutoCenter);
    if DropdownComboShown then
    begin
     if FUsesDropDown then
      Ttb97ButtonGlyph(FGlyph).DrawButtonDropArrow (l_DC, Width-DropdownArrowWidth-2,
        Height div 2 - 1, DropdownArrowWidth, FState)
     else
      Ttb97ButtonGlyph(FGlyph).DrawButtonDropArrow (l_DC, Width-DropdownArrowWidth-2,
        Height div 2 - 1, DropdownArrowWidth, bsDisabled);
    end;//DropdownComboShown    
   finally
    l_DC.EndPaint;
   end;//try..finally
  finally
   l_DC := nil;
  end;//try..finally
  if UseBmp then
   aCN.Canvas.Draw(0, 0, l_Bmp);
 finally
  l3Free(l_Bmp);
 end;//try..finally
end;

procedure TCustomToolbarButton97.RemoveButtonMouseTimer;
begin
  if ButtonMouseInControl = Self then
  begin
    ButtonMouseTimer.Enabled := False;
    ButtonMouseInControl := nil;
  end;
end;

procedure TCustomToolbarButton97.Loaded;
var
  State: TButtonState97;
begin
  inherited;
  FNeedAdjustSize := False;
  if Enabled then
    State := bsUp
  else
    State := bsDisabled;
  Ttb97ButtonGlyph(FGlyph).CreateButtonGlyph (State);
end;

procedure TCustomToolbarButton97.Notification (AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = DropdownMenu then
     DropdownMenu := nil;
    if Assigned(FGlyph) and (AComponent = Images) then
     Images := nil;
  end;
end;

function TCustomToolbarButton97.PointInButton (X, Y: Integer): Boolean;
begin
  Result := (X >= 0) and
    (X < ClientWidth-((DropdownArrowWidth+cDropDownComboSpace) * Ord(FDropdownCombo and FUsesDropdown))) and
    (Y >= 0) and (Y < ClientHeight);
end;

procedure TCustomToolbarButton97.MouseDown (Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if not Enabled then
  begin
    inherited;
    Exit;
  end;
  if (Button <> mbLeft) then
  begin
    MouseEntered;
    inherited;
  end
  else
  begin
    { Если ткнули в задизейбленную стрелку - выходим }
    if FDropdownCombo and (X >= Width-(DropdownArrowWidth+cDropDownComboSpace)) and
      (FDropDownMenu=nil) then
    begin
     inherited;
     Exit;
    end;

    { We know mouse has to be over the control if the mouse went down. }
    MouseEntered;
    FMenuIsDown := FUsesDropdown and (not FDropdownCombo or
      (X >= Width-(DropdownArrowWidth+cDropDownComboSpace)));

    try
      if not FDown then
      begin
        FState := bsDown;
        Redraw (True);
      end
      else
        if FAllowAllUp then
          Redraw (True);
      if not FMenuIsDown then
        FMouseIsDown := True;
      inherited;
      if FMenuIsDown then
        Click;
    finally
      FMenuIsDown := False;
    end;//try..finally
  end;//Button <> mbLeft
end;

procedure TCustomToolbarButton97.MouseMove (Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
  NewState: TButtonState97;
  PtInButton: Boolean;
begin
  inherited;

  { Check if mouse just entered the control. It works better to check this
    in MouseMove rather than using CM_MOUSEENTER, since the VCL doesn't send
    a CM_MOUSEENTER in all cases
    Use FindDragTarget instead of PtInRect since we want to check based on
    the Z order }
  P := ClientToScreen(Point(X, Y));
  if (ButtonMouseInControl <> Self) and (FindDragTarget(P, True) = Self) then
  begin
    if Assigned(ButtonMouseInControl) then
      ButtonMouseInControl.MouseLeft;
    { Like Office 97, only draw the active borders when the application is active }
    if FShowBorderWhenInactive or ApplicationIsActive then
    begin
      ButtonMouseInControl := Self;
      ButtonMouseTimer.OnTimer := ButtonMouseTimerHandler;
      ButtonMouseTimer.Enabled := True;
      MouseEntered;
    end;
  end;

  if FMouseIsDown then
  begin
    PtInButton := PointInButton(X, Y);
    if FDown then
      NewState := bsExclusive
    else
    begin
      if PtInButton then
        NewState := bsDown
      else
        NewState := bsUp;
    end;
    if NewState <> FState then
    begin
      FState := NewState;
      Redraw (True);
    end;
  end;
end;

procedure TCustomToolbarButton97.WMCancelMode (var Message: TWMCancelMode);
begin
  if FMouseIsDown then
  begin
    FMouseIsDown := False;
    MouseLeft;
  end;
  { Delphi's default processing of WM_CANCELMODE sends a "fake" WM_LBUTTONUP
    message to the control, so inherited must only be called after setting
    FMouseIsDown to False }
  inherited;
end;

procedure TCustomToolbarButton97.MouseUp (Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
 afw.BeginOp;
 try
  { Remove active border when right button is clicked }
  if (Button = mbRight) and Enabled then
  begin
    FMouseIsDown := False;
    MouseLeft;
  end;
  inherited;
  if (Button = mbLeft) and FMouseIsDown then
  begin
    FMouseIsDown := False;
    if PointInButton(X, Y) then
    begin
      if (Parent = nil) then
        Exit;
      Click;
      /// нужно для Немезиса, можно одефайнить ///
      if not (csDesigning in ComponentState) and (ActionLink <> nil) then
        ActionLink.Update;
      ///
    end
    else
      MouseLeft;
  end;
 finally
  afw.EndOp;
 end;
end;

procedure TCustomToolbarButton97.DoClick;
  //virtual;
  {-}
begin
 inherited Click;
end;

procedure TCustomToolbarButton97.CalcSizeAndGetText(var aSize : TSize;
                                                    var aText : Tl3WString);
  {-}
var
 l_DW  : Integer;
 l_DH  : Integer;
 l_CN  : Il3InfoCanvas;

type
 TIconSize = (lis16, lis24, lis32);

 function lp_CalcSizes: TIconSize;
 var l_size: Integer;
 begin
  if (Images <> nil) then
   l_size := Images.Height
  else
   l_size := 16;
  if l_size <= 16 then
   Result := lis16
  else
   if l_size <= 24 then
    Result := lis24
   else
    Result := lis32;
 end;

const
 lc_LinesCount: array[TIconSize, Boolean] of integer = ((1, 1), (2, 2), (3, 2));

begin
 if (Screen.PixelsPerInch < 120)
  then l_DW := GetHBorder
  else l_DW := GetHBorder + 4;
 l_DH := GetVBorder;
 l3AssignNil(aText);
 Case DisplayMode of
  dmBoth, dmGlyphAndFakeText:
  begin
   if (Images <> nil) then
   begin
    aSize.cx := Images.Width + l_DW;
    l_CN := InfoCanvas;
    aSize.cy := Max(Images.Height,
                    l_CN.LP2DP(l3PointY(l_CN.AverageCharHeight)).Y * lc_LinesCount[lp_CalcSizes, Screen.PixelsPerInch >= 120]) + l_DH;
   end//Images <> nil
   else
   if (Glyph <> nil) then
    aSize.cx := Glyph.Width + l_DW;

   if DisplayMode = dmGlyphAndFakeText then
     Inc(aSize.cx, l_DW)
   else
     aText := l3PCharLen(CCaption);
  end;//dmBoth
  dmTextOnly:
  begin
   l_CN := InfoCanvas;
   aSize.cy := l_CN.LP2DP(l3PointY(l_CN.AverageCharHeight)).Y * lc_LinesCount[lp_CalcSizes, Screen.PixelsPerInch >= 120] + l_DH;
   aText := l3PCharLen(CCaption);
  end;
  dmGlyphOnly:
  begin
   if (Images <> nil) then
   begin
    aSize.cx := Images.Width + l_DW;
    aSize.cy := Images.Height + l_DH;
   end//Images <> nil
   else
   if (Glyph <> nil) then
    aSize.cx := Glyph.Width + l_DW;
  end;//dmGlyphOnly
 end;//Case DisplayMode
 if DropDownCombo or NeedDropArrow then
  Inc(aSize.cx, (DropdownArrowWidth + cDropDownComboSpace)); //am
 if not l3IsNil(aText) then
  Inc(aSize.cx, l_DW);
end;

function TCustomToolbarButton97.FitToSize(const aCN   : Il3InfoCanvas;
                                          const aText : Tl3WString;
                                          aWidth      : Integer;
                                          aHeight     : Integer;
                                          var theRect : TRect): Boolean;
  {-}
var
 l_ML : Il3MultiLines;
begin
 l3FillChar(theRect, SizeOf(theRect), 0);
 theRect.Right := aWidth;
 l_ML := aCN.DrawText(aText, theRect, DT_WORDBREAK or DT_CALCRECT);
 if l_ML.HasBreakInWord OR (theRect.Bottom > aHeight + 3) then
  Result := l_ML.IsSingle
 else
  Result := True;
end;

procedure TCustomToolbarButton97.DoFitToWidth(aWidth: Integer);
  {-}
var
 l_Size : TSize;
 l_S    : Tl3WString;
 l_CN   : Il3InfoCanvas;
 l_R    : TRect;
begin
 if (aWidth < 0) then
  Exit;
 Width := aWidth;
 if WordWrap then
 begin
  l3FillChar(l_Size, SizeOf(l_Size), 0);
  CalcSizeAndGetText(l_Size, l_S);
  if not l3IsNil(l_S) then
  begin
   l_CN := InfoCanvas;
   try
    FitToSize(l_CN, l_S, aWidth - l_Size.cx - l_CN.pxAverageCharWidth - 2, l_Size.cy, l_R);
   finally
    l_CN := nil;
   end;//try..finally
  end;//not l3IsNil(l_S)
 end;//WordWrap
end;

procedure TCustomToolbarButton97.DoUnFitToWidth(aWidth: Integer);
  {-}
begin                             
 Width := aWidth;
end;

procedure TCustomToolbarButton97.Expand;
  {-}
begin
 DoFitToWidth(Get_FullWidth);
end;

procedure TCustomToolbarButton97.CalcSize(var aSize : TSize);
const
 cMul = 2;
var
 l_CN  : Il3InfoCanvas;
 l_S   : Tl3WString;
 l_R   : TRect;
 l_Mul : Integer;
begin
 l3FillChar(aSize, SizeOf(aSize), 0);
 if not AutoSize then
  Exit;
  // - ибо нефига
 if (csLoading in ComponentState) then
 begin
  FNeedAdjustSize := False;
  Exit;
 end;//csLoading in ComponentState
 if not FNeedAdjustSize then
  Exit;
 CalcSizeAndGetText(aSize, l_S);
 if not l3IsNil(l_S) then
 begin
  l_CN := InfoCanvas;
  try
   if WordWrap then
   begin
    l_Mul := cMul;
    while not FitToSize(l_CN, l_S, aSize.cy * l_Mul, aSize.cy, l_R) do
     Inc(l_Mul);
    Inc(aSize.cx, l_R.Right);
   end//WordWrap
   else
    Inc(aSize.cx, l_CN.LP2DP(l_CN.TextExtent(l_S)).X);
   Inc(aSize.cx, l_CN.pxAverageCharWidth);
  finally
   l_CN := nil;
  end;//try..finally
 end;//not l3IsNil(l_S)
end;

function TCustomToolbarButton97.IsGtbToolbarButtonSizeNeeded: Boolean; 
begin
 Result := True;
end;

procedure TCustomToolbarButton97.AdjustSize;
  //override;
  {-}
var
 l_Size   : TSize;
 l_Width  : Integer;
 l_Height : Integer;
begin
 l_Width := Width;
 l_Height := Height;
 // Посчитаем
 CalcSize(l_Size);
 // Установим размеры
 if (l_Size.cx > 0) then
  l_Width := l_Size.cx;
 if (l_Size.cy > 0) then
  l_Height := l_Size.cy;
 SetBounds(Left, Top, l_Width, l_Height);
 // Пользовательский обработчик
 if IsGtbToolbarButtonSizeNeeded then
  if Assigned(g_tbToolbarButtonSize) then
   g_tbToolbarButtonSize(Self);
end;

function TCustomToolbarButton97.GetHBorder: Integer;
begin
 Result := cDW;
end;

function TCustomToolbarButton97.GetVBorder: Integer;
begin
 Result := cDH;
end;

function TCustomToolbarButton97.NeedAutoDown: Boolean;
  //virtual;
  {-}
begin
 Result := true;
end;

type
 THack = class(TMenuItem);

procedure TCustomToolbarButton97.Click;
var
  Popup, ShowMenu, RemoveClicks: Boolean;
  SaveAlignment: TPopupAlignment;
  SaveTrackButton: TTrackButton;
  PopupPt: TPoint;
  RepostList: Ttb97List; {pointers to TMsg's}
  Msg: TMsg;
  Repost: Boolean;
  I: Integer;
  P: TPoint;
  Form: TCustomForm;
  DockPos: TGetToolbarDockPosType;
  l_Width: Integer;
  l_ItemHeight: Integer;
  l_ItemWidth: Integer;
  l_IDX: Integer;
  l_Canvas: TCanvas;
  l_NonClientMetrics: TNonClientMetrics;
  l_MonitorSize: TRect;
begin
 //if FProtectedClick then
  afw.BeginOp;
 try
  FInClick := True;
  try
    if (GroupIndex <> 0) and not FMenuIsDown AND NeedAutoDown then
      SetDown (not FDown);

    Popup := FUsesDropdown and (not FDropdownCombo or FMenuIsDown);
    if ButtonsStayDown or Popup then
    begin
      if FState in [bsUp, bsMouseIn] then
      begin
        FState := bsDown;
        Redraw (True);
      end;
    end
    else
    begin
      if FState = bsDown then
      begin
        if FDown and (FGroupIndex <> 0) then
          FState := bsExclusive
        else
          FState := bsUp;
        Redraw (True);
      end;
    end;

    { Stop tracking }
    MouseLeft;
    if not Popup then
    begin
      Form := GetParentForm(Self);
      if Form <> nil then
       Form.ModalResult := ModalResult;
      inherited;
    end
    else
    begin
      if not FDropdownCombo then
        inherited;
      { It must release its capture before displaying the popup menu since
        this control uses csCaptureMouse. If it doesn't, the VCL seems to
        get confused and think the mouse is still captured even after the
        popup menu is displayed, causing mouse problems after the menu is
        dismissed. }
      MouseCapture := False;
      ShowMenu := Assigned(FDropdownMenu);
      RemoveClicks := True;
      {$IfDef tb97NeedOnDropdown}
      if Assigned(FOnDropdown) then
        FOnDropdown (Self, ShowMenu, RemoveClicks);
      {$EndIf tb97NeedOnDropdown}  
      try
        if Assigned(FDropdownMenu) and ShowMenu then
        begin
          SaveAlignment := DropdownMenu.Alignment;
          SaveTrackButton := DropdownMenu.TrackButton;
          try
            DropdownMenu.Alignment := paLeft;
            PopupPt := Point(0, Height);
            if Assigned(GetToolbarDockPosProc) then
            begin
              DockPos := GetToolbarDockPosProc(Parent);
              { Drop out right or left side }
              case DockPos of
                gtpLeft: PopupPt := Point(Width, 0);
                gtpRight: begin
                    PopupPt := Point(0, 0);
                    DropdownMenu.Alignment := paRight;
                  end;
              end;
            end;
            PopupPt := ClientToScreen(PopupPt);
            if DropdownMenu.Alignment = paLeft then
            begin
             l_Width := 0;
             l_Canvas := TControlCanvas.Create;
             try
              l_Canvas.Handle := InfoCanvas.DC;
              l_Canvas.Font := Screen.MenuFont;
              for l_IDX := 0 to DropdownMenu.Items.Count - 1 do
              begin
               l_ItemHeight := 0;
               l_ItemWidth := 0;
               THack(DropdownMenu.Items[l_IDX]).MeasureItem(l_Canvas, l_ItemWidth, l_ItemHeight);
               if l_ItemWidth > l_Width then
                l_Width := l_ItemWidth;
              end;
             finally
              FreeAndNil(l_Canvas);
             end;
             l_NonClientMetrics.cbSize := sizeof(NonClientMetrics);
             if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @l_NonClientMetrics, 0) then
              Inc(l_Width, l_NonClientMetrics.iMenuWidth);

             l_MonitorSize := Screen.MonitorFromPoint(PopupPt).WorkareaRect;

             if (PopupPt.X + l_Width) > l_MonitorSize.Right then
             begin
              Inc(PopupPt.X, Width);
              if PopupPt.X > l_MonitorSize.Right then
               PopupPt.X := l_MonitorSize.Right - 1;
              DropdownMenu.Alignment := paRight;
             end;
            end;
            with DropdownMenu do
            begin
              PopupComponent := Self;
              if NewStyleControls then
                TrackButton := tbLeftButton
              else
                TrackButton := tbRightButton;
              Popup (PopupPt.X, PopupPt.Y);
            end;//with DropdownMenu
          finally
            DropdownMenu.Alignment := SaveAlignment;
            DropdownMenu.TrackButton := SaveTrackButton;
          end;//try..finally
        end;
      finally
        if RemoveClicks then
        begin
          { To prevent a mouse click from redisplaying the menu, filter all
            mouse up/down messages, and repost the ones that don't need
            removing. This is sort of bulky, but it's the only way I could
            find that works perfectly and like Office 97. }
          RepostList := Ttb97List.Make;
          try
            while PeekMessage(Msg, 0, WM_LBUTTONDOWN, WM_MBUTTONDBLCLK,
               PM_REMOVE or PM_NOYIELD) do
               { ^ The WM_LBUTTONDOWN to WM_MBUTTONDBLCLK range encompasses all
                 of the DOWN and DBLCLK messages for the three buttons }
              with Msg do
              begin
                Repost := True;
                case Message of
                  WM_QUIT: begin
                      { Throw back any WM_QUIT messages }
                      PostQuitMessage (wParam);
                      Break;
                    end;
                  WM_LBUTTONDOWN, WM_LBUTTONDBLCLK,
                  WM_RBUTTONDOWN, WM_RBUTTONDBLCLK,
                  WM_MBUTTONDOWN, WM_MBUTTONDBLCLK: begin
                      P := SmallPointToPoint(TSmallPoint(lParam));
                      Windows.ClientToScreen (hwnd, P);
                      if FindDragTarget(P, True) = Self then
                        Repost := False;
                    end;
                end;
                if Repost then
                begin
                  RepostList.Add (tb97AllocMem(SizeOf(TMsg)));
                  PMsg(RepostList.Last)^ := Msg;
                end;
              end;
          finally
            for I := 0 to RepostList.Count-1 do
            begin
              with PMsg(RepostList[I])^ do
                PostMessage (hwnd, message, wParam, lParam);
              tb97FreeMemPrim(RepostList[I]);
            end;
            tb97Free(RepostList);
          end;
        end;
      end;
    end;
  finally
    FInClick := False;
    if FState = bsDown then
      FState := bsUp;
    { Need to check if it's destroying in case the OnClick handler freed
      the button. If it doesn't check this here, it can sometimes cause an
      access violation }
    if not(csDestroying in ComponentState) and
       (Parent <> nil) then
     if FDropdownArrow or FDropdownCombo then
     begin
       Redraw (True);
       MouseLeft;
     end;
  end;
 finally
  //if FProtectedClick then
   afw.EndOp;
 end;//try..finally
end;

function TCustomToolbarButton97.GetPalette: HPALETTE;
begin
  Result := Glyph.Palette;
end;

function TCustomToolbarButton97.GlyphStored: Boolean;
  {-}
begin
  Result := (FGlyph <> nil) AND (Ttb97ButtonGlyph(FGlyph).Glyph <> nil) AND
            not Ttb97ButtonGlyph(FGlyph).Glyph.Empty AND
            (Ttb97ButtonGlyph(FGlyph).Glyph.Width > 0);
end;

function TCustomToolbarButton97.GetGlyph: TBitmap;
begin
  Result := Ttb97ButtonGlyph(FGlyph).Glyph;
end;

procedure TCustomToolbarButton97.SetGlyph (Value: TBitmap);
begin
  Ttb97ButtonGlyph(FGlyph).Glyph := Value;
  Redraw (True);
end;

function TCustomToolbarButton97.GlyphMaskStored: Boolean;
  {-}
begin
  Result := (FGlyph <> nil) AND (Ttb97ButtonGlyph(FGlyph).GlyphMask <> nil) AND
            not Ttb97ButtonGlyph(FGlyph).GlyphMask.Empty AND
            (Ttb97ButtonGlyph(FGlyph).GlyphMask.Width > 0);
end;

function TCustomToolbarButton97.GetGlyphMask: TBitmap;
begin
  Result := Ttb97ButtonGlyph(FGlyph).GlyphMask;
end;

procedure TCustomToolbarButton97.SetGlyphMask (Value: TBitmap);
begin
  Ttb97ButtonGlyph(FGlyph).GlyphMask := Value;
  Redraw (True);
end;

function TCustomToolbarButton97.GetImageIndex: Integer;
begin
  Result := Ttb97ButtonGlyph(FGlyph).FImageIndex;
end;

procedure TCustomToolbarButton97.SetImageIndex (Value: Integer);
begin
  if Ttb97ButtonGlyph(FGlyph).FImageIndex <> Value then
  begin
    Ttb97ButtonGlyph(FGlyph).FImageIndex := Value;
    if Assigned(Ttb97ButtonGlyph(FGlyph).FImageList) then
      Ttb97ButtonGlyph(FGlyph).GlyphChanged (nil);
  end;
end;

function TCustomToolbarButton97.GetImages: TCustomImageList;
begin
  Result := Ttb97ButtonGlyph(FGlyph).FImageList;
end;

procedure TCustomToolbarButton97.SetImages (Value: TCustomImageList);
begin
  with Ttb97ButtonGlyph(FGlyph) do
    if FImageList <> Value then
    begin
      if FImageList <> nil then
        FImageList.UnRegisterChanges (FImageChangeLink);
      FImageList := Value;
      if FImageList <> nil then
      begin
        if FImageChangeLink = nil then
        begin
          FImageChangeLink := TChangeLink.Create;
          FImageChangeLink.OnChange := GlyphChanged;
        end;
        FImageList.RegisterChanges(FImageChangeLink);
        FImageList.FreeNotification(Self);
        AdjustSize;
      end
      else
      begin
        tb97Free(FImageChangeLink);
        FImageChangeLink := nil;
      end;
      UpdateNumGlyphs;
    end;
end;

function TCustomToolbarButton97.GetNumGlyphs: TNumGlyphs97;
begin
  Result := Ttb97ButtonGlyph(FGlyph).NumGlyphs;
end;

procedure TCustomToolbarButton97.SetNumGlyphs (Value: TNumGlyphs97);
begin
  if Value < Low(TNumGlyphs97) then
    Value := Low(TNumGlyphs97)
  else
  if Value > High(TNumGlyphs97) then
    Value := High(TNumGlyphs97);
  if Value <> Ttb97ButtonGlyph(FGlyph).NumGlyphs then
  begin
    Ttb97ButtonGlyph(FGlyph).NumGlyphs := Value;
    Redraw (True);
  end;
end;

function TCustomToolbarButton97.Get_FullWidth : Integer;
  {-}
var
 lSize : TSize;
begin
 if Get_IsSizeable then
 begin
  CalcSize(lSize);
  Result := lSize.cx;
 end//Get_IsSizeable
 else
  Result := Width;
end;

function TCustomToolbarButton97.Get_IsSizeable : Boolean;
  {-}
begin
 Result := DisplayMode in [dmTextOnly, dmBoth];
end;

function TCustomToolbarButton97.Get_MinWidth : Integer;
  {-}
var
 lStr  : Il3CString;
 lRect : TRect;
 lSize : TSize;
 l_CN  : Il3InfoCanvas;
begin
 Result := 0;
 if Get_IsSizeable then
 begin
  // Иконка
  if (DisplayMode in [dmBoth, dmGlyphAndFakeText, dmGlyphOnly]) and Assigned(Glyph) then
  begin
   Ttb97ButtonGlyph(FGlyph).CalcGlyphSize(lSize);
   Result := lSize.cx;
  end;
  // Текст
  if (DisplayMode in [dmBoth, dmGlyphAndFakeText, dmTextOnly]) and not l3IsNil(CCaption) then
  begin
   // Расстояние между иконкой и текстом
   if Result > 0 then
    Inc(Result, cSpacing);
   // Размер текста
   lStr := l3Cat(l3Cat(nil, l3CharEx(CCaption, 0)), '...');
   SetRectEmpty(lRect);
   l_CN := InfoCanvas;
   with l_CN do
   begin
    DrawText(l3PCharLen(lStr), lRect, DT_SINGLELINE or DT_CALCRECT);
    Inc(Result, lRect.Right);
   end;//with l_CN
  end;//DisplayMode in [dmBoth, dmTextOnly]
  // Дополнительное пространство
  Inc(Result, GetHBorder);
 end//Get_IsSizeable
 else
  Result := Width;
end;

procedure TCustomToolbarButton97.pm_SetIndex(const Value : Integer);
begin
 fIndex := Value;
end;

function TCustomToolbarButton97.pm_NeedDropArrow: Boolean;
  {* - наличие выпадающей стрелочки. }
begin
 Result := FDropdownArrow and not FDropdownCombo and FUsesDropdown;
end;

function TCustomToolbarButton97.pm_GetIndex : Integer;
begin
 Result := fIndex;
end;

procedure TCustomToolbarButton97.GlyphChanged(Sender: TObject);
begin
 if not (csDestroying in ComponentState) then
 begin
  AdjustSize;
  Redraw(True);
 end;
end;

procedure TCustomToolbarButton97.UpdateExclusive;
var
  I: Integer;
  Ctl: TControl;
begin
  if (FGroupIndex <> 0) and (Parent <> nil) then
    with Parent do
      for I := 0 to ControlCount-1 do
      begin
        Ctl := Controls[I];
        if (Ctl <> Self) and (Ctl is TCustomToolbarButton97) then
          with TCustomToolbarButton97(Ctl) do
            if FGroupIndex = Self.FGroupIndex then
            begin
              if Self.Down and FDown then
              begin
                FDown := False;
                FState := bsUp;
                Redraw (True);
              end;
              FAllowAllUp := Self.AllowAllUp;
            end;
      end;
end;

procedure TCustomToolbarButton97.SetDown (Value: Boolean);
begin
  if FGroupIndex = 0 then
    Value := False;
  if Value <> FDown then
  begin
    if FDown and (not FAllowAllUp) then
     Exit;
    FDown := Value;
    if not Enabled then
      FState := bsDisabled
    else
    begin
      if Value then
        FState := bsExclusive
      else
        FState := bsUp;
    end;
    Redraw (True);
    if Value then
     UpdateExclusive;
  end;
end;

function TCustomToolbarButton97.GetFlat: Boolean;
begin
 {$Ifdef tb97AlwaysFlat}
 Result := true;
 {$Else  tb97AlwaysFlat}
 Result := FFlat;
 {$EndIf tb97AlwaysFlat}
end;

procedure TCustomToolbarButton97.SetFlat(Value: Boolean);
begin
 {$IfNdef tb97AlwaysFlat}
  if FFlat <> Value then
  begin
    FFlat := Value;
    if Opaque or not FFlat then
      ControlStyle := ControlStyle + [csOpaque]
    else
      ControlStyle := ControlStyle - [csOpaque];
    Redraw (True);
  end;
 {$EndIf  tb97AlwaysFlat} 
end;

procedure TCustomToolbarButton97.SetGroupIndex (Value: Integer);
begin
  if FGroupIndex <> Value then
  begin
    FGroupIndex := Value;
    UpdateExclusive;
  end;
end;

procedure TCustomToolbarButton97.SetLayout (Value: TButtonLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Redraw (True);
  end;
end;

procedure TCustomToolbarButton97.SetMargin (Value: Integer);
begin
  if (FMargin <> Value) and (Value >= -1) then
  begin
    FMargin := Value;
    Redraw (True);
  end;
end;

procedure TCustomToolbarButton97.SetNoBorder (Value: Boolean);
begin
  if FNoBorder <> Value then
  begin
    FNoBorder := Value;
    Invalidate;
  end;
end;

procedure TCustomToolbarButton97.SetOpaque (Value: Boolean);
begin
  if (FOpaque <> Value) then
  begin
    FOpaque := Value;
    if FOpaque or not Flat then
      ControlStyle := ControlStyle + [csOpaque]
    else
      ControlStyle := ControlStyle - [csOpaque];
    Invalidate;
  end;//FOpaque <> Value
end;

procedure TCustomToolbarButton97.Redraw (const Erase: Boolean);
var
  AddedOpaque: Boolean;
begin
  if Opaque or not Flat or not Erase then
  begin
    { Temporarily add csOpaque to the style. This prevents Invalidate from
      erasing, which isn't needed when Erase is false. }
    AddedOpaque := False;
    if not(csOpaque in ControlStyle) then
    begin
      AddedOpaque := True;
      ControlStyle := ControlStyle + [csOpaque];
    end;
    try
      Invalidate;
    finally
      if AddedOpaque then
        ControlStyle := ControlStyle - [csOpaque];
    end;
  end
  else
  if not(Opaque or not Flat) then
    Invalidate;
end;

function TCustomToolbarButton97.GetSpacing: Integer;
begin
 {$IfDef tb97NeedSpacing}
  Result := FSpacing;
 {$Else  tb97NeedSpacing}
  Result := 4;
 {$EndIf tb97NeedSpacing}
end;

procedure TCustomToolbarButton97.SetSpacing(Value: Integer);
begin
  {$IfDef tb97NeedSpacing}
  if Value <> FSpacing then
  begin
    FSpacing := Value;
    Redraw (True);
  end;
  {$EndIf tb97NeedSpacing}
end;

procedure TCustomToolbarButton97.SetAllowAllUp (Value: Boolean);
begin
  if FAllowAllUp <> Value then
  begin
    FAllowAllUp := Value;
    UpdateExclusive;
  end;
end;

procedure TCustomToolbarButton97.SetDropdownMenu (Value: TPopupMenu);
var
  NewUsesDropdown: Boolean;
begin
  if FDropdownMenu <> Value then
  begin
    FDropdownMenu := Value;
    if Assigned(Value) then
     Value.FreeNotification(Self);
    NewUsesDropdown := FDropdownAlways or Assigned(Value);
    if FUsesDropdown <> NewUsesDropdown then
    begin
      FUsesDropdown := NewUsesDropdown;
      if FDropdownArrow or FDropdownCombo then
        Redraw (True);
    end;//FUsesDropdown <> NewUsesDropdown
  end;//FDropdownMenu <> Value
end;

function TCustomToolbarButton97.GetWordWrap: Boolean;
begin
 {$IfDef tb97NeedWordWrap}
  Result := FWordWrap;
 {$Else  tb97NeedWordWrap}
  Result := false;
 {$EndIf tb97NeedWordWrap}
end;

procedure TCustomToolbarButton97.SetWordWrap (Value: Boolean);
begin
  {$IfDef tb97NeedWordWrap}
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    Redraw (True);
  end;
  {$EndIf tb97NeedWordWrap}
end;

procedure TCustomToolbarButton97.SetAlignment (Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Redraw (True);
  end;
end;

procedure TCustomToolbarButton97.SetDropdownAlways (Value: Boolean);
var
  NewUsesDropdown: Boolean;
begin
  if FDropdownAlways <> Value then
  begin
    FDropdownAlways := Value;
    NewUsesDropdown := Value or Assigned(FDropdownMenu);
    if FUsesDropdown <> NewUsesDropdown then
    begin
      FUsesDropdown := NewUsesDropdown;
      if FDropdownArrow or FDropdownCombo then
        Redraw (True);
    end;
  end;
end;

procedure TCustomToolbarButton97.SetDropdownArrow (Value: Boolean);
begin
  if FDropdownArrow <> Value then
  begin
    FDropdownArrow := Value;
    Redraw (True);
  end;
end;

function TCustomToolbarButton97.GetDropdownArrowWidth: Integer;
  {-}
begin
 Result := FDropdownArrowWidth;
 if not (csDesigning in ComponentState) then
 begin
  if (Height > 23) then
   Result := l3MulDiv(Result, 3, 2);
 end;//not (csDesigning in ComponentState)
end;

procedure TCustomToolbarButton97.SetDropdownArrowWidth (Value: Integer);
var
  Diff: Integer;
begin
  if Value < 7 then
   Value := 7;
  if (FDropdownArrowWidth <> Value) then
  begin
    Diff := Value - FDropdownArrowWidth;
    FDropdownArrowWidth := Value;
    if not(csLoading in ComponentState) and FDropdownCombo then
      Width := Width + Diff;
    Redraw (True);
  end;//FDropdownArrowWidth <> Value
end;

procedure TCustomToolbarButton97.SetDropdownCombo (Value: Boolean);
var
  W: Integer;
begin
  if FDropdownCombo <> Value then
  begin
    FDropdownCombo := Value;
    if not(csLoading in ComponentState) then
    begin
      if Value then
        Width := Width + (DropdownArrowWidth + cDropDownComboSpace)
      else
      begin
        W := Width - (DropdownArrowWidth + cDropDownComboSpace);
        if W < 1 then
         W := 1;
        Width := W;
      end;
    end;
    Redraw (True);
  end;
end;

procedure TCustomToolbarButton97.SetDisplayMode (Value: TButtonDisplayMode);
begin
  if FDisplayMode <> Value then
  begin
    FDisplayMode := Value;
    AdjustSize;
    Redraw(True);
  end;
end;

function TCustomToolbarButton97.IsCheckedStored: Boolean;
begin
  Result := (ActionLink = nil) or not TToolbarButton97ActionLink(ActionLink).IsCheckedLinked;
end;

function TCustomToolbarButton97.IsHelpContextStored: Boolean;
begin
  Result := (ActionLink = nil) or not TToolbarButton97ActionLink(ActionLink).IsHelpContextLinked;
end;

function TCustomToolbarButton97.IsImageIndexStored: Boolean;
begin
  Result := (ActionLink = nil) or not TToolbarButton97ActionLink(ActionLink).IsImageIndexLinked;
end;

function TCustomToolbarButton97.AutoAllUp: Boolean;
  //virtual;
  {-}
begin
 Result := AllowAllUp;
end;

procedure TCustomToolbarButton97.ActionChange (Sender: TObject; CheckDefaults: Boolean);
begin
  inherited;
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.GroupIndex = 0) then
      begin
        Self.GroupIndex := GroupIndex;
        if (Self.GroupIndex <> 0) then
         Self.AllowAllUp := AutoAllUp;
      end;//not CheckDefaults or (Self.GroupIndex = 0)
      if not CheckDefaults or (Self.Down = False) then
        Self.Down := Checked;
      if not CheckDefaults or (Self.HelpContext = 0) then
        Self.HelpContext := HelpContext;
      if not CheckDefaults or (Self.ImageIndex = -1) then
        Self.ImageIndex := ImageIndex;
    end;
end;

function TCustomToolbarButton97.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TToolbarButton97ActionLink;
end;

procedure TCustomToolbarButton97.AssignTo(Dest: TPersistent);
begin
  inherited;
  if Dest is TCustomAction then
    TCustomAction(Dest).Checked := Self.Down;
end;

procedure TCustomToolbarButton97.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  inherited;
  if FDown then
   DblClick;
end;

procedure TCustomToolbarButton97.CMEnabledChanged(var Message: TMessage);
begin
  if not Enabled then
  begin
    FState := bsDisabled;
    FMouseInControl := False;
    FMouseIsDown := False;
    RemoveButtonMouseTimer;
    Perform (WM_CANCELMODE, 0, 0);
  end
  else
  if FState = bsDisabled then
    if FDown and (FGroupIndex <> 0) then
      FState := bsExclusive
    else
      FState := bsUp;
  Redraw (True);
end;

procedure TCustomToolbarButton97.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and Assigned(Parent) and Parent.CanFocus and
       Enabled and Visible and (DisplayMode <> dmGlyphOnly) and (DisplayMode <> dmGlyphAndFakeText) then
    begin
      { NOTE: There is a bug in TSpeedButton where accelerator keys are still
        processed even when the button is not visible. The 'and Visible'
        corrects it, so TToolbarButton97 doesn't have this problem. }
      Click;
      Result := 1;
    end
    else
      inherited;
end;

procedure TCustomToolbarButton97.CMDialogKey (var Message: TCMDialogKey);
begin
  with Message do
    if (((CharCode = VK_RETURN) and FDefault) or
        ((CharCode = VK_ESCAPE) and FCancel)) and
       (KeyDataToShiftState(Message.KeyData) = []) and
       Assigned(Parent) and Parent.CanFocus and Enabled and Visible then
    begin
      Click;
      Result := 1;
    end
    else
      inherited;
end;

procedure TCustomToolbarButton97.CMFontChanged(var Message: TMessage);
begin
  Redraw(True);
end;

procedure TCustomToolbarButton97.CMTextChanged(var Message: TMessage);
begin
 Redraw(True);
 if AutoSize then
  AdjustSize;
end;

procedure TCustomToolbarButton97.CMSysColorChange (var Message: TMessage);
begin
  inherited;
  if Assigned(Pattern) and
     ((PatternBtnFace <> TColor(GetSysColor(COLOR_BTNFACE))) or
      (PatternBtnHighlight <> TColor(GetSysColor(COLOR_BTNHIGHLIGHT)))) then
  begin
    tb97Free(Pattern);
    Pattern := nil;
  end;
  with Ttb97ButtonGlyph(FGlyph) do
  begin
    Invalidate;
    CreateButtonGlyph (FState);
  end;
end;

procedure TCustomToolbarButton97.MouseEntered;
begin
  if Enabled and not FMouseInControl then
  begin
    FMouseInControl := True;
    if FState = bsUp then
      FState := bsMouseIn;
    if Flat or (NumGlyphs >= 5) then
      Redraw (FDown or (NumGlyphs >= 5));
    {$IfDef tb97NeedMouseEvents}
    if Assigned(FOnMouseEnter) then
      FOnMouseEnter (Self);
    {$EndIf tb97NeedMouseEvents}  
  end;
end;

procedure TCustomToolbarButton97.MouseLeft;
var
  OldState: TButtonState97;
begin
  if Enabled and FMouseInControl and not FMouseIsDown then
  begin
    FMouseInControl := False;
    RemoveButtonMouseTimer;
    OldState := FState;
    if (FState = bsMouseIn) or (not FInClick and (FState = bsDown)) then
    begin
      if FDown and (FGroupIndex <> 0) then
        FState := bsExclusive
      else
        FState := bsUp;
    end;
    if Flat or ((NumGlyphs >= 5) or ((OldState = bsMouseIn) xor (FState <> OldState))) then
      Redraw (True);
    {$IfDef tb97NeedMouseEvents}
    if Assigned(FOnMouseExit) then
      FOnMouseExit (Self);
    {$EndIf tb97NeedMouseEvents}  
  end;
end;

function TCustomToolbarButton97.Locked: Boolean;
  {-}
begin
 Result := (Parent Is TCustomToolWindow97) AND TCustomToolWindow97(Parent).Locked; 
end;

procedure TCustomToolbarButton97.ButtonMouseTimerHandler (Sender: TObject);
var
  P: TPoint;
begin
  { The button mouse timer is used to periodically check if mouse has left.
    Normally it receives a CM_MOUSELEAVE, but the VCL does not send a
    CM_MOUSELEAVE if the mouse is moved quickly from the button to another
    application's window. For some reason, this problem doesn't seem to occur
    on Windows NT 4 -- only 95 and 3.x.

    The timer (which ticks 8 times a second) is only enabled when the
    application is active and the mouse is over a button, so it uses virtually
    no processing power.

    For something interesting to try: If you want to know just how often this
    is called, try putting a Beep call in here }

  GetCursorPos (P);
  if FindDragTarget(P, True) <> Self then
    MouseLeft;
end;

{$IfDef tb97NeedCustomGlyphDraw}
procedure TCustomToolbarButton97.SetOnCustomGlyphDraw(const Value: TCustomGlyphDrawEvent);
begin
 FOnCustomGlyphDraw := Value;
 Invalidate;
end;
{$EndIf tb97NeedCustomGlyphDraw}

procedure TCustomToolbarButton97.SetGlyphSize(const Value: Ttb97GlyphSize);
begin
 if FGlyphSize <> Value then
 begin
  FGlyphSize := Value;
  if Assigned(FGlyph) then
   Ttb97ButtonGlyph(FGlyph).GlyphSize := Value;
  Invalidate;
 end;
end;

{ TEdit97 - internal }

constructor TEdit97.Create (AOwner: TComponent);
begin
  inherited;
  AutoSize := False;
  Ctl3D := False;
  BorderStyle := bsNone;
  ControlStyle := ControlStyle - [csFramed]; {fixes a VCL bug with Win 3.x}
  Height := 19;
  if Edit97Count = 0 then
    Register97ControlClass (TEdit97);
  Inc (Edit97Count);
end;

type
 _Unknown_Child_ = TEdit97;
{$I l3ImplCleanup.inc}
begin
  Dec (Edit97Count);
  if Edit97Count = 0 then
    Unregister97ControlClass (TEdit97);
  inherited;
end;

procedure TEdit97.CMMouseEnter (var Message: TMessage);
begin
  inherited;
  MouseInControl := True;
  DrawNCArea (False, 0, 0);
end;

procedure TEdit97.CMMouseLeave (var Message: TMessage);
begin
  inherited;
  MouseInControl := False;
  DrawNCArea (False, 0, 0);
end;

procedure TEdit97.NewAdjustHeight;
var
  DC: HDC;
  SaveFont: HFONT;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics (DC, Metrics);
  SelectObject (DC, SaveFont);
  ReleaseDC (0, DC);

  Height := Metrics.tmHeight + 6;
end;

procedure TEdit97.Loaded;
begin
  inherited;
  if not(csDesigning in ComponentState) then
    NewAdjustHeight;
end;

procedure TEdit97.CMEnabledChanged (var Message: TMessage);
const
  EnableColors: array[Boolean] of TColor = (cDefBack, clWindow);
begin
  inherited;
  Color := EnableColors[Enabled];
  { Ensure non-client area is invalidated as well }
  if HandleAllocated then
    RedrawWindow (Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ERASE or
      RDW_NOCHILDREN);
end;

procedure TEdit97.CMFontChanged (var Message: TMessage);
begin
  inherited;
  if not((csDesigning in ComponentState) and (csLoading in ComponentState)) then
    NewAdjustHeight;
end;

procedure TEdit97.WMSetFocus (var Message: TWMSetFocus);
begin
  inherited;
  if not(csDesigning in ComponentState) then
    DrawNCArea (False, 0, 0);
end;

procedure TEdit97.WMKillFocus (var Message: TWMKillFocus);
begin
  inherited;
  if not(csDesigning in ComponentState) then
    DrawNCArea(False, 0, 0);
end;

procedure TEdit97.WMNCCalcSize (var Message: TWMNCCalcSize);
begin
  InflateRect(Message.CalcSize_Params^.rgrc[0], -3, -3);
end;

procedure TEdit97.WMNCPaint (var Message: TMessage);
begin
  DrawNCArea (False, 0, HRGN(Message.WParam));
end;

procedure TEdit97.DrawNCArea (const DrawToDC: Boolean; const ADC: HDC;
  const Clip: HRGN);
var
  DC: HDC;
  R: TRect;
  BtnFaceBrush, WindowBrush: HBRUSH;
begin
  if not DrawToDC then
    DC := GetWindowDC(Handle)
  else
    DC := ADC;
  try
    { Use update region }
    if not DrawToDC then
      SelectNCUpdateRgn (Handle, DC, Clip);

    { This works around WM_NCPAINT problem described at top of source code }
    {no!  R := Rect(0, 0, Width, Height);}
    GetWindowRect (Handle, R);  OffsetRect (R, -R.Left, -R.Top);
    BtnFaceBrush := GetSysColorBrush(COLOR_BTNFACE);
    WindowBrush := GetSysColorBrush(COLOR_WINDOW);
    if ((csDesigning in ComponentState) and Enabled) or
       (not(csDesigning in ComponentState) and
        (Focused or (MouseInControl and not ControlIs97Control(Screen.ActiveControl)))) then
    begin
      DrawEdge (DC, R, BDR_SUNKENOUTER, BF_RECT or BF_ADJUST);
      with R do
      begin
        FillRect (DC, Rect(Left, Top, Left+1, Bottom-1), BtnFaceBrush);
        FillRect (DC, Rect(Left, Top, Right-1, Top+1), BtnFaceBrush);
      end;
      DrawEdge (DC, R, BDR_SUNKENINNER, BF_BOTTOMRIGHT);
      InflateRect (R, -1, -1);
      FrameRect (DC, R, WindowBrush);
    end
    else
    begin
      FrameRect (DC, R, BtnFaceBrush);
      InflateRect (R, -1, -1);
      FrameRect (DC, R, BtnFaceBrush);
      InflateRect (R, -1, -1);
      FrameRect (DC, R, WindowBrush);
    end;
  finally
    if not DrawToDC then
      ReleaseDC (Handle, DC);
  end;
end;

procedure EditNCPaintProc (Wnd: HWND; DC: HDC; AppData: Longint);
begin
  TEdit97(AppData).DrawNCArea (True, DC, 0);
end;

procedure TEdit97.WMPrint(var Message: TMessage);
begin
  HandleWMPrint(Handle, Message, EditNCPaintProc, Longint(Self));
end;

procedure TEdit97.WMPrintClient(var Message: TMessage);
begin
  HandleWMPrintClient(Self, Message);
end;

constructor TDropWindowSeparator.Create (AOwner: TComponent; aDockType: TDockType);
begin
  inherited Create(AOwner);
  FDockType := aDockType;
  if FDockType = dtLeftRight then
   Width := 6
  else
   Height := 6;
  ControlStyle := ControlStyle - [csOpaque, csCaptureMouse];
end;

procedure TDropWindowSeparator.DoPaint(const aCN: Il3Canvas);
var
 Z: Integer;
begin
  inherited;
  with aCN.Canvas do
  begin
    if (FDockType <> dtLeftRight) then
    begin
      Z := Width div 2;
      Pen.Color := clBtnShadow;
      MoveTo (Z-1, 0);  LineTo (Z-1, Height);
      Pen.Color := clBtnHighlight;
      MoveTo (Z, 0);  LineTo (Z, Height);
    end//FDockType <> dtLeftRight
    else
    begin
      Z := Height div 2;
      Pen.Color := clBtnShadow;
      MoveTo (0, Z-1);  LineTo (Width, Z-1);
      Pen.Color := clBtnHighlight;
      MoveTo (0, Z);  LineTo (Width, Z);
    end;//FDockType <> dtLeftRight
  end;//with aCN.Canvas
end;

function TCustomToolbarButton97.InfoCanvas: Il3InfoCanvas;
begin
 Result := L3CrtIC;
 Result.Font.AssignFont(Font);
 Result.PasswordChar := #0;
end;

{ TCustomToolbarPanel97 }

procedure TCustomToolbarPanel97.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//
end;

procedure TCustomToolbarPanel97.MouseMove(Shift: TShiftState; X,
  Y: Integer);
begin
//  inherited;

end;

procedure TCustomToolbarPanel97.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//  inherited;

end;

constructor TCustomToolbarPanel97.Create(AOwner: TComponent);
begin
 inherited;
 DisplayMode := dmTextOnly;
 Alignment := taLeftJustify;
end;

procedure TCustomToolbarPanel97.SetStretch(aValue: Boolean);
begin
 if aValue
  then Tl3ListenersManager.AddWndProcListener(Self)
  else Tl3ListenersManager.RemoveWndProcListener(Self);
 if FStretch <> aValue then
 begin
  FStretch := aValue;
  AdjustSize;
 end;
end;

procedure TCustomToolbarPanel97.CleanUp;
begin
 l3Free(FProgressTimer);
 FStretch := False;
 Tl3ListenersManager.RemoveWndProcListener(Self);
 inherited;
end;

procedure TCustomToolbarPanel97.AdjustSize;
var
 I: Integer;
 l_ToolBar: TCustomToolbar97;
 l_Control: TControl;
 l_StretchCount: Integer;
 l_OtherWidth: Integer;
 l_Size: TSize;
 l_S: Tl3WString;
begin
 if not Assigned(Parent) or (csDestroying in (ComponentState + Parent.ComponentState)) then
  Exit;

 if not FStretch then
 begin
  inherited;
  Exit;
 end;

 CalcSizeAndGetText(l_Size, l_S);

 if Parent is TCustomToolbar97
  then l_ToolBar := Parent as TCustomToolbar97
  else Exit;

 l_StretchCount := 0;
 l_OtherWidth := 0;
 for I := 0 to l_ToolBar.OrderedControlsCount - 1 do
 begin
  l_Control := l_ToolBar.OrderedControls[I];
  if not l_Control.Visible or (l_Control is Ttb97MoreButton) then
   Continue;
  if (l_Control is TCustomToolbarPanel97) and TCustomToolbarPanel97(l_Control).Stretch then
  begin
   Inc(l_StretchCount);
   Continue;
  end;
  l_OtherWidth := l_OtherWidth + l_Control.Width;
 end;
 Assert(l_StretchCount > 0);
 if Width <> (l_ToolBar.ClientWidth - l_OtherWidth) div l_StretchCount then
  SetBounds(Left, Top, (l_ToolBar.ClientWidth - l_OtherWidth) div l_StretchCount, l_Size.cy);
end;

function TCustomToolbarPanel97.GetHBorder: Integer;
begin
 Result := 1;
end;

function TCustomToolbarPanel97.GetVBorder: Integer;
begin
 Result := 1;
end;

function TCustomToolbarPanel97.IsGtbToolbarButtonSizeNeeded: Boolean;
begin
 Result := False;
end;

procedure TCustomToolbarPanel97.DoPaint(const aCN: Il3Canvas);
begin
 inherited DoPaint(aCN);
 if FProgressIndicator then
  DoPaintProgress;
end;

type
 TPercent = 0..100;

procedure InitGradient(aSelfColor: TColor);

  function CalcGradient(aFromColor, aToColor: TColor; aPosition: TPercent): TColor;
  var
   R1, G1, B1: Integer;
   R2, G2, B2: Integer;
  begin
   R1 := aFromColor and $FF;
   R2 := aToColor and $FF;
   G1 := (aFromColor and $FF00) shr 8;
   G2 := (aToColor and $FF00) shr 8;
   B1 := (aFromColor and $FF0000) shr 16;
   B2 := (aToColor and $FF0000) shr 16;
   Result := (R1 + aPosition * (R2 - R1) div 100) and $FF +
             ((G1 + aPosition * (G2 - G1) div 100) and $FF) shl 8 +
             ((B1 + aPosition * (B2 - B1) div 100) and $FF) shl 16;
  end;

var
 I: Integer;                
begin
 if g_Colors[0] <> aSelfColor then
 begin
  g_Colors[0] := aSelfColor;
  for I := 1 to 100 do
   g_Colors[I] := CalcGradient(aSelfColor, cGarant2011GradientStartColor, I);
 end;
end;

procedure TCustomToolbarPanel97.DoPaintProgress;
const
 cMaxPercent = 100;
 cProgressIndicatorSize = 20; //%
var
 cProgressIndicatorLength: Integer; // pixels
 cProgressIndicatorItemSize: Single;
 cTextWidth: Integer;

 procedure InitConsts;
 var
  I: Integer;
  l_Rect: TRect;
 begin
  SetRectEmpty(l_Rect);
  with InfoCanvas do
  begin
   DrawText(l3PCharLen(CCaption), l_Rect, DT_SINGLELINE or DT_CALCRECT);
   cTextWidth := l_Rect.Right + cSpacing * 2;                                 // размер текста в пикселях + отступ
  end;//with l_CN

  if ClientWidth <> cTextWidth
   then cProgressIndicatorItemSize := (ClientWidth - cTextWidth) / cMaxPercent
   else cProgressIndicatorItemSize := 1;

  cProgressIndicatorLength := Trunc(cProgressIndicatorItemSize * cProgressIndicatorSize); // длина прогресс-индикатора в пикселях
  InitGradient(Self.Color);
 end;

 procedure FillRect(aRect: TRect);
 begin
  Canvas.Canvas.FillRect(aRect);
 end;

 procedure LineAt(aPos: Integer);
 begin
  Canvas.Canvas.MoveTo(aPos, 0);
  Canvas.Canvas.LineTo(aPos, Height);
 end;

var
 l_Tail, l_Head, I: Integer;
 l_Direction: Integer;
 l_Position: Integer;
begin
 InitConsts;

 Inc(g_ProgressPosition);

 if cProgressIndicatorLength <= 0 then
  Exit; // нечего рисовать

 if g_ProgressPosition < cMaxPercent
  then l_Direction := +1
  else l_Direction := -1;
 l_Position := g_ProgressPosition mod cMaxPercent;
 l_Head := Trunc(l_Position * cProgressIndicatorItemSize);
 if l_Direction = +1 then
 begin
  l_Tail := cTextWidth + Abs(l_Head - cProgressIndicatorLength);
  l_Head := cTextWidth + l_Head;
 end else
 begin
  l_Head := ClientWidth - l_Head;
  l_Tail := l_Head + cProgressIndicatorLength;
  if l_Tail > ClientWidth then
   l_Tail := 2 * ClientWidth - l_Tail;
 end;

 Canvas.BeginPaint;
 try
  if l_Direction = +1 then
  begin
   if l_Position > cProgressIndicatorSize then
   begin
    for I := 0 to l_Head - l_Tail do
    begin
     Canvas.Canvas.Pen.Color := g_Colors[I * cMaxPercent div cProgressIndicatorLength];
     Canvas.Canvas.Brush.Color := g_Colors[I * cMaxPercent div cProgressIndicatorLength];
     if I = 0
      then FillRect(Rect(l_Tail + I - (Trunc(cProgressIndicatorItemSize) + 1), 0, l_Tail + I, Height))
      else LineAt(l_Tail + I);
    end;
   end else
   begin
    if l_Tail > l_Head then
     for I := 0 to l_Tail - l_Head do
     begin
      Canvas.Canvas.Pen.Color := g_Colors[I * cMaxPercent div cProgressIndicatorLength];
      Canvas.Canvas.Brush.Color := g_Colors[I * cMaxPercent div cProgressIndicatorLength];
      if I = 0
       then FillRect(Rect(l_Tail - I, 0, l_Tail - I - (Trunc(cProgressIndicatorItemSize) + 1), Height))
       else LineAt(l_Tail - I);
     end;
    for I := 0 to l_Head - cTextWidth do
    begin
     Canvas.Canvas.Pen.Color := g_Colors[(I + l_Tail - cTextWidth) * cMaxPercent div cProgressIndicatorLength];
     LineAt(cTextWidth + I);
    end;
   end;
  end else
  begin
   if l_Position > cProgressIndicatorSize then
   begin
    for I := 0 to l_Tail - l_Head do
    begin
     Canvas.Canvas.Pen.Color := g_Colors[cMaxPercent - I * cMaxPercent div cProgressIndicatorLength];
     Canvas.Canvas.Brush.Color := g_Colors[cMaxPercent - I * cMaxPercent div cProgressIndicatorLength];
     if I = l_Tail - l_Head
      then FillRect(Rect(l_Head + I, 0, l_Head + I + (Trunc(cProgressIndicatorItemSize) + 1), Height))
      else LineAt(l_Head + I);
    end;
   end else
   begin
    if l_Head > l_Tail then
     for I := 0 to l_Head - l_Tail do
     begin
      Canvas.Canvas.Pen.Color := g_Colors[I * cMaxPercent div cProgressIndicatorLength];
      Canvas.Canvas.Brush.Color := g_Colors[I * cMaxPercent div cProgressIndicatorLength];
      LineAt(l_Tail + I);
     end;
    for I := 0 to ClientWidth - l_Head do
    begin
     Canvas.Canvas.Pen.Color := g_Colors[cMaxPercent - I * cMaxPercent div cProgressIndicatorLength];
     Canvas.Canvas.Brush.Color := g_Colors[cMaxPercent - I * cMaxPercent div cProgressIndicatorLength];
     if I = 0
      then FillRect(Rect(l_Head + I, 0, l_Head + I + (Trunc(cProgressIndicatorItemSize) + 1), Height))
      else LineAt(l_Head + I);
    end;
   end;
  end;
 finally
  Canvas.EndPaint;
 end;

 if g_ProgressPosition >= 2 * cMaxPercent - 1 then
  g_ProgressPosition := 0;
end;

procedure TCustomToolbarPanel97.OnProgressTimer(aSender: TObject);
begin
 Invalidate;
end;

procedure TCustomToolbarPanel97.WndProcListenerNotify(Msg: PCWPStruct;
  var theResult: Tl3HookProcResult);
begin
 if not FNotifyLock and (Msg.message = WM_SIZE) then
  if Assigned(Parent) and Parent.HandleAllocated and (Parent.Handle = Msg.hwnd) then
   if not (csDestroying in (ComponentState + Parent.ComponentState)) then
   try
    FNotifyLock := True;
    AdjustSize;
    theResult.Result := 1;
   finally
    FNotifyLock := False;
   end;
end;

procedure TCustomToolbarPanel97.SetProgressIndicator(const Value: Boolean);
begin
 if FProgressIndicator = Value then
  Exit;

 FProgressIndicator := Value;
 if FProgressIndicator then
 begin
  FProgressTimer := TTimer.Create(Self);
  FProgressTimer.OnTimer := OnProgressTimer;
  FProgressTimer.Interval := 30;
  //FProgressPosition := 0;
 end else
  l3Free(FProgressTimer);
end;

{ TSizeGripPanel }

procedure TSizeGripPanel.AdjustSize;
var
 l_Size: TSize;
 l_S: Tl3WString;
begin
 if csDestroying in (ComponentState + Parent.ComponentState) then
  Exit;
 CalcSizeAndGetText(l_Size, l_S);
 SetBounds(Left, Top, 15, l_Size.cy);
end;

constructor TSizeGripPanel.Create(AOwner: TComponent);
begin
 inherited;
 FCapture := False;
 FGripVisible := True;
 Tl3ListenersManager.AddWndProcListener(Self);
end;

procedure TSizeGripPanel.DoPaint(const aCN: Il3Canvas);
var
 R: TRect;
begin
 inherited;
 CheckCanSize; 
 if FGripVisible then
  if (GetFormToResize.WindowState <> wsMaximized) then
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=565491811
  begin
   R := ClientRect;
   R.Left := R.Right - 15;
   Inc(R.Top, 4);
   Dec(R.Bottom);
   AwfDrawSizeGrip(aCN.Canvas.Handle, R, cDefBack);
  end;//Color <> clBtnFace
end;

procedure TSizeGripPanel.CleanUp;
begin
 Tl3ListenersManager.RemoveWndProcListener(Self);
 inherited;
end;

procedure TSizeGripPanel.WndProcListenerNotify(Msg: PCWPStruct; var theResult: Tl3HookProcResult);
var
 l_Form: TCustomForm;
begin
 if not (csDestroying in ComponentState) then
  if {FGripVisible and not FCapture }True then
   if (Msg.message = WM_WINDOWPOSCHANGED) then
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=565491798
   begin
    l_Form := GetFormToResize;
    // - http://mdp.garant.ru/pages/viewpage.action?pageId=565491811
    if Assigned(l_Form) and l_Form.HandleAllocated then
     if (l_Form.Handle = Msg.hwnd) then
      CheckCanSize;
   end;
end;

procedure TSizeGripPanel.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
 l_Form: TCustomForm;
begin
 if (Button <> mbLeft) or (csDestroying in ComponentState) then
  Exit;
 l_Form := GetFormToResize;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=565491811
 if Assigned(l_Form) and (l_Form.WindowState <> wsMaximized) then
 begin
  FCapture := True;
  FCapturePos := Point(X, Y);
 end;
end;

procedure TSizeGripPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
 l_Form: TCustomForm;
begin
 if FCapture then
 begin
  l_Form := GetFormToResize;
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=565491811
  if (l_Form <> nil) and
   (not (csDestroying in l_Form.ComponentState)) then
    with l_Form do
     SetBounds(Left, Top, Width + (X - FCapturePos.X), Height + (Y - FCapturePos.Y));
 end;
end;

procedure TSizeGripPanel.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
 FCapture := False;
end;

procedure TSizeGripPanel.SetGripVisible(const Value: Boolean);
begin
 FGripVisible := Value;
 if FGripVisible
  then Cursor := crSizeNWSE
  else Cursor := crDefault;
 Invalidate;
end;

procedure TSizeGripPanel.CheckCanSize;
const
 cCursorsArr: array[Boolean] of TCursor = (crDefault, crSizeNWSE);
var
 l_Form: TCustomForm;
 l_WasVisible: Boolean;
begin
 l_WasVisible := FGripVisible;
 l_Form := GetFormToResize;
 if (l_Form = nil) or (csDestroying in l_Form.ComponentState) then
 begin
  FGripVisible := False;
  Cursor := crDefault;
  Exit;
 end
 else
  FGripVisible := (not (csDestroying in l_Form.ComponentState)) and
                  (l_Form.HandleAllocated) and
                  (l_Form.WindowState <> wsMaximized);
 Cursor := cCursorsArr[FGripVisible];
 if (l_WasVisible <> FGripVisible) then
 begin
  Invalidate;
  if (not FGripVisible) then
   FCapture := False;
 end;
end;

function TSizeGripPanel.GetFormToResize: TCustomForm;
begin
 Result := afw.GetParentForm(Self);
end;

initialization
 l3FillChar(g_Colors, SizeOf(g_Colors));
end.
