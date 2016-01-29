unit vcmSettings;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmSettings -   }
{ Начат: 31.07.2003 14:27 }
{ $Id: vcmSettings.pas,v 1.126 2015/02/26 09:29:06 kostitsin Exp $ }

// $Log: vcmSettings.pas,v $
// Revision 1.126  2015/02/26 09:29:06  kostitsin
// List*ner -> Listener
//
// Revision 1.125  2015/02/25 13:53:27  kostitsin
// List*ner -> Listener
//
// Revision 1.124  2014/07/17 11:49:27  morozov
// {RequestLink: 340174500}
//
// Revision 1.123  2014/07/16 11:59:28  morozov
// {RequestLink: 554580396}
//
// Revision 1.122  2014/07/14 08:33:51  morozov
// {RequestLink: 554580396}
//
// Revision 1.121  2013/11/07 08:07:35  morozov
// {RequestLink: 271750647}
//
// Revision 1.120  2013/05/21 08:14:13  lulin
// - собираем тестовый проект нового генератора под XE3.
//
// Revision 1.119  2013/01/22 15:52:20  kostitsin
// [$424399029]
//
// Revision 1.118  2012/05/28 16:50:07  kostitsin
// [$367201314]
//
// Revision 1.117  2012/04/11 15:28:38  lulin
// - пытаемся разобраться с "галочками".
//
// Revision 1.116  2012/04/09 08:38:54  lulin
// {RequestLink:237994598}
// - думаем о VGScene.
//
// Revision 1.115  2012/04/04 08:56:55  lulin
// {RequestLink:237994598}
//
// Revision 1.114  2012/03/20 09:33:09  lulin
// {RequestLink:333552196}
//
// Revision 1.113  2011/09/21 18:13:31  lulin
// {RequestLink:278836572}.
//
// Revision 1.112  2011/05/18 17:45:28  lulin
// {RequestLink:266409354}.
//
// Revision 1.111  2009/12/21 12:12:05  oman
// - fix: {RequestLink:174719194}
//
// Revision 1.110  2009/09/30 15:22:58  lulin
// - убираем ненужное приведение ко вполне понятным интерфейсам.
//
// Revision 1.109  2009/08/21 07:00:12  oman
// - fix:  {RequestLink:159364476}
//
// Revision 1.108  2009/08/17 11:56:11  lulin
// {RequestLink:129240934}. №37.
//
// Revision 1.107  2009/08/04 16:52:59  lulin
// - наконец-то дошли до вызова сравнения редакций, которое падает.
//
// Revision 1.106  2009/03/19 14:20:26  oman
// - fix: Сохраняем размеры пропорциональных панелей (К-139441130)
//
// Revision 1.105  2009/03/18 09:28:41  oman
// - fix: Возвращаем префикс-группу (К-139441026)
//
// Revision 1.104  2009/03/13 13:18:27  oman
// - fix: Писали под одним именем, а читали под другим (К-139436530)
//
// Revision 1.103  2009/02/12 17:09:12  lulin
// - <K>: 135604584. Выделен модуль с внутренними константами.
//
// Revision 1.102  2008/11/11 14:34:07  lulin
// - убран ненужный параметр.
//
// Revision 1.101  2008/06/04 10:51:20  mmorozov
// - new: возможность найстройки доступных для редактирования панели инструментов операций (CQ: OIT5-28281);
//
// Revision 1.100  2008/04/02 14:22:11  lulin
// - cleanup.
//
// Revision 1.99  2008/01/24 11:30:41  oman
// - new: Пишем/читаем  размеры пропорционально (cq24598)
//
// Revision 1.98  2008/01/23 08:27:44  oman
// - fix: При записи/чтении размеров зон ищем родителя с подходящим
//  выравниванием (cq24598)
//
// Revision 1.97  2007/12/28 17:59:38  lulin
// - удалена ненужная глобальная переменная - ссылка на метод получения настроек.
//
// Revision 1.96  2007/12/28 17:49:41  lulin
// - удален ненужный глобальный метод.
//
// Revision 1.95  2007/09/19 15:40:09  mmorozov
// - bugfix: окно не становилось на место предыдущего закрытого (CQ: OIT5- 26671), подробно см. в K<49513268>;
//
// Revision 1.94  2007/04/05 07:59:23  lulin
// - избавляемся от лишних преобразований строк при записи в настройки.
//
// Revision 1.93  2007/04/04 13:13:59  mmorozov
// - new: в функции работы с настройками добавлена возможность определения Default и Group;
//
// Revision 1.92  2007/02/07 17:48:39  lulin
// - избавляемся от копирования строк при чтении из настроек.
//
// Revision 1.91  2006/04/18 09:03:53  oman
// cleanup (убирание rCaption из vcmPathPair)
//
// Revision 1.90  2006/02/26 15:34:40  mmorozov
// - bugfix: правильно восстанавливаем размер для всячески выровненных компонентов (CQ: 19794);
//
// Revision 1.89  2006/01/18 09:26:08  oman
// - new behavior: для настроек в методы Save добавлен параметр "сделать по умолчанию"
//   (по аналогии с Load)
//
// Revision 1.88  2005/12/08 13:16:39  oman
// - new behavior: убран класс TvcmSettings. Модуль vcmGBLInterfaces теперь
// не нужен
//
// Revision 1.87  2005/10/12 05:36:57  lulin
// - bug fix: не записывались строки в настройки (CQ OIT5-16921).
//
// Revision 1.86  2005/09/21 08:35:24  dolgop
// - change: изменения, связанные с появлением IString в Settings
//
// Revision 1.85  2005/08/10 14:01:33  mmorozov
// change: afw.Application.Settings - > _afwSettings;
//
// Revision 1.84  2005/07/14 16:02:46  lulin
// - new behavior: в run-time получаем ID операции по ее имени из информации, содержащейся в MenuManager'е.
//
// Revision 1.83  2005/07/12 07:25:49  mmorozov
// opt: TvcmSettings.LoadParam;
//
// Revision 1.82  2005/07/06 16:40:31  mmorozov
// bugfix: при вызове _vcmLoadParam в списке параметров был пропущен нетипизированный параметр по умолчанию (строка), вместо него подавалось логическое значение, в следствии чего в _vcmLoadParam происходило Invalid pointer _operation;
//
// Revision 1.81  2005/06/30 07:52:43  cyberz
// READY FOR TIE-TEMPLATE GENERATION
//
// Revision 1.80  2005/06/23 16:10:13  mmorozov
// change: afw.Application.Settings не инициализируется в секции инициализации;
// change: сигнатура методов чтения записи настроек;
// change: ходим через одни ворота, _vcmLoadParam и vcmSaveParam используют afw.Application.Settings. Из _vcmLoadParam и vcmSaveParam все нужное перенесено в TvcmSettings.LoadParam, TvcmSettings.SaveParam, исправлены ошибки (для некоторых типов данных не написан код для восстановления из настроек);
//
// Revision 1.79  2005/03/31 09:29:51  dinishev
// Не компилировалась версия
//
// Revision 1.78  2005/03/31 09:24:47  dinishev
// Не компилировалась версия
//
// Revision 1.77  2005/03/31 09:02:55  migel
// - fix: не компилировалось (вынесли `vcmCopyPath` и `vcmCatPath` в интерфейсную секцию - иначе не собирались мониторинги).
//
// Revision 1.76  2005/03/14 14:20:24  lulin
// - bug fix.
//
// Revision 1.75  2005/03/14 14:14:06  lulin
// - new method: IafwSettings._Clone.
//
// Revision 1.74  2005/03/14 14:05:09  lulin
// - транслируем запрос настроек (ISettings) внутреннему объекту.
//
// Revision 1.73  2005/03/14 13:21:23  lulin
// - bug fix: до _Preview-таки не доходило сообщение о необходимости перестроения после смены настроек.
//
// Revision 1.72  2005/03/14 12:22:21  lulin
// - new behavior: теперь диалог настройки печати сохраняет/читает настройки через интерфейс IafwSettings.
//
// Revision 1.71  2005/03/14 11:29:50  lulin
// - new behavior: теперь _Preview реагирует на изменение настроек (в частности колонтитулов).
//
// Revision 1.70  2005/03/14 10:56:44  lulin
// - new methods: IafwSettings.LoadCardinal, SaveCardinal.
//
// Revision 1.69  2005/03/14 10:47:43  lulin
// - new methods: IafwSettings.AddListener, RemoveListener.
//
// Revision 1.68  2005/01/12 12:47:37  lulin
// - перевел модуль afwFacade в глобальных процедур на метакласс.
//
// Revision 1.67  2005/01/11 08:19:52  lulin
// - bug fix: не компилировалось.
//
// Revision 1.66  2004/12/28 18:41:09  lulin
// - new prop: IafwApplication.Settings.
//
// Revision 1.65  2004/12/16 13:52:52  mmorozov
// new: class TvcmSettings;
// new: global function _vcm_Settings;
//
// Revision 1.64  2004/11/12 13:32:21  mmorozov
// new: field _TvcmFormParams.rFloatWindowBounds;
// new: consts cFloatLeft, cFloatTop, cFloatWidth, cFloatHeight;
// new: global func and proc vcmLoadFloatBounds, vcmSaveFloatBounds;
// new: при загрузке, чтении параметров формы читаем положение плавающей формы;
//
// Revision 1.63  2004/11/10 14:19:17  mmorozov
// new: field - _TvcmFormParams.rFloatWindowState;
// new: setting id - cFloatWindowState;
// remove: function AdjustIfOutOfView;
// new: запись, чтение параметра формы FloatWindowState;
//
// Revision 1.62  2004/10/08 04:53:13  mmorozov
// bugfix: не комплировалось (используем define vcmUseSettings);
//
// Revision 1.61  2004/10/07 12:40:10  mmorozov
// change: TForm -> TCustomForm;
// new: functions vcmIsCanMaximized, _vcmIsSetBoundsRect, _vcmLoadFormControls (overload), _vcmLoadFormStateAndBounds;
// new: type TvcmHackCustomForm;
//
// Revision 1.60  2004/09/23 11:47:17  am
// change: в vcmSaveShortcut теперь нужно подавать и дефолтные значения шорткатов тоже.
//
// Revision 1.59  2004/08/18 11:11:33  mmorozov
// bugfix: при чтении положения из настроек игнорируем установленное Maximized для форм у которых BorderStyle = (bsDialog, bsSingle, bsNone), устанавливаем только Left, Top;
//
// Revision 1.58  2004/07/21 09:10:06  mmorozov
// bugfix: восстановление модальных окон, которые при открытии максимизировались приводило с сворачиванию их в трубочку;
//
// Revision 1.57  2004/07/20 11:11:57  am
// bugfix: TvcmToolbarPositions.rFloatX/rFloatY могут быть и отрицательными
//
// Revision 1.56  2004/07/13 07:22:19  am
// change: при сохранении тулбара, независимо от его состояния, сохраняем плавающие координаты
//
// Revision 1.55  2004/06/29 10:49:12  mmorozov
// new behaviour: при вычитывании размеров формы из настроек, проверяем что они являются допустимыми (не выходят за пределы экрана);
//
// Revision 1.54  2004/06/11 07:08:50  mmorozov
// bugfix: не верно сохранялось значение по умолчанию;
// new: группа при чтении, сохранении настройки может быть пустой;
//
// Revision 1.53  2004/06/04 14:49:40  mmorozov
// - переход на новые настройки;
//
// Revision 1.52  2004/05/27 13:04:17  am
// new: vcmCleanShortcut.
// change: vcmSaveShortcut\vcmLoadShortcut
//
// Revision 1.51  2004/05/25 12:00:56  am
// new: vcmSaveShortcut\vcmLoadShortcut
//
// Revision 1.50  2004/04/10 10:42:59  am
// change: доп. параметр (Visible) в SaveIntParam, SaveParam
//
// Revision 1.49  2004/04/07 12:10:30  am
// change: при нажатии "Восстановить всё" сбрасываемся к дефолтным настройкам
//
// Revision 1.48  2004/04/05 13:56:09  nikitin75
// - переходим на IStringOld;
//
// Revision 1.47  2004/03/29 17:07:53  mmorozov
// new: пишем/читаем FloatID формы;
//
// Revision 1.46  2004/03/26 10:46:17  am
// new: LoadFastenMode\SaveFastenMode
//
// Revision 1.45  2004/03/24 12:28:52  law
// - bug fix: неправильно переключались нижние закладки.
//
// Revision 1.44  2004/03/23 17:42:27  law
// - new behavior: при сохранении зон не сохраняем высоту/ширину <= Control.Constraints.
//
// Revision 1.43  2004/03/23 13:42:42  law
// - new behavior: сохраняем размеры зон (CQ OIT5-6694).
//
// Revision 1.42  2004/03/16 17:09:14  mmorozov
// new: устанавливаем размеры для форм у которых BorderStyle = bsSizeable или bsSizeToolWin, остальным высталяем верхний левый;
//
// Revision 1.41  2004/03/16 08:47:56  am
// new: Сохранение формы плавающего тулбара
//
// Revision 1.40  2004/03/15 14:34:19  demon
// - bug fix: по-другому сохраняем состав Toolbar'ов по умолчанию.
//
// Revision 1.39  2004/03/15 12:37:00  law
// - new behavior: не показываем VCM настройки в форме для пользователя.
//
// Revision 1.38  2004/03/11 17:02:38  law
// - bug fix: неправильно показывалась форма выбора атрибутов из ППР.
// - new behavior: запоминаем/восстанавливаем состояние формы Floating.
//
// Revision 1.36  2004/03/11 12:19:32  law
// - bug fix: неправильно определялся путь к контролу, в котором "лежит" плавающая форма.
//
// Revision 1.35  2004/03/10 16:56:51  law
// - extract method: vcmSaveLayout - сохраняет позицию и размеры формы.
//
// Revision 1.34  2004/03/10 14:18:29  am
// new: vcmSaveCardinalParamS, vcmSaveToolbarPos пользует функции с суффиксом S
//
// Revision 1.33  2004/03/05 17:10:24  law
// - new behavior: формы встраиваются в тот док, который был запомнен в настройках.
//
// Revision 1.32  2004/03/05 15:30:30  law
// - change: в vcmLoad*Param передаем массив пар, а не массив строк.
//
// Revision 1.31  2004/03/04 19:32:54  law
// - new behavior: сделано сохранение имени дока для встроенных форм.
//
// Revision 1.30  2004/03/04 18:53:05  law
// - new behavior: изменен алгоритм получения пути для настроек формы.
// - ne procs: _vcmSaveStrParam, vcmSaveStrParamS.
//
// Revision 1.29  2004/03/04 16:09:08  law
// - new behavior: читаем настройки без Exception'ов.
//
// Revision 1.28  2004/03/04 13:00:42  am
// change: признак существования тулбара сохраняем отдельно (cVisibleName)
//
// Revision 1.27  2004/03/04 08:09:14  am
// new: vcmSaveToolbarPos/vcmLoadToolbarPos
//
// Revision 1.26  2004/03/01 17:42:51  law
// - new type: TvcmPath.
//
// Revision 1.25  2004/03/01 17:30:07  law
// - new method: _vcmGetFormPath.
//
// Revision 1.24  2004/03/01 17:10:47  law
// - new proc: _vcmGetFormPathEntry.
//
// Revision 1.23  2004/03/01 16:38:14  law
// - bug fix.
//
// Revision 1.22  2004/03/01 16:33:08  law
// - new type: TvcmPathPairs.
//
// Revision 1.21  2004/03/01 16:21:15  law
// - new behavior: при записи положения и размеров форм указываем осмысленные значения по умолчанию.
//
// Revision 1.20  2004/03/01 15:34:31  law
// - bug fix: в настройки пишем более правильный заголовок осносной формы.
//
// Revision 1.19  2004/03/01 14:44:44  am
// new methods: vcmSaveToolbarPos, vcmLoadToolbarPos
//
// Revision 1.18  2004/03/01 13:53:26  law
// - new behavior: сохраняем/восстанавливаем положение и размеры всех плавающих и модальных форм.
//
// Revision 1.17  2004/03/01 12:09:02  law
// - change: задел на сохранение позиции и размеров всех "плавающих" форм, а не только основной.
//
// Revision 1.16  2004/02/26 16:32:13  law
// - new behavior: сохраняем размеры и положение основной формы.
//
// Revision 1.15  2004/02/26 15:54:22  law
// - new behavior: сохраняем состояние Maximized основной формы.
//
// Revision 1.14  2004/02/20 13:36:01  am
// change: убраны идентификаторы групп
//
// Revision 1.13  2004/02/20 09:34:27  am
// *** empty log message ***
//
// Revision 1.12  2004/02/19 09:51:50  am
// bugfixs: запись значений
//
// Revision 1.11  2004/02/18 09:19:22  am
// *** empty log message ***
//
// Revision 1.10  2004/02/18 09:11:04  am
// new: у message'ей появилось свойство Key - путь, по которому они сохраняются в настройках
// change: в vcmSettings есть возможность сохранять в группу, отличную от _vcmGroup,
//         передавая группу в пути и выставляя aGroupInPath
//
// Revision 1.9  2004/02/09 14:00:26  law
// - new behavior: читаем из настроек и информацию об операциях модулей тоже.
//
// Revision 1.8  2004/02/06 12:13:42  law
// - new behavior: сохраняем/читаем необходимость наличия разделителя.
//
// Revision 1.7  2004/02/05 19:40:07  law
// - new behavior: строим Toolbar'ы по сохраненным настройкам. Пока не учитываются разделители, операции модулей, порядок операций и неправильно читается первая копия основного окна. Завтра буду добивать это дело.
//
// Revision 1.6  2004/02/05 17:00:32  law
// - new behavior: вычитываем Toolbar'ы из настроек, но пока плюем на то, что прочитали.
//
// Revision 1.5  2004/01/30 16:32:15  law
// - new behavior: записываем/читаем результат диалога.
//
// Revision 1.4  2003/12/17 14:35:34  dk3
// new settings
//
// Revision 1.3  2003/07/31 16:02:21  law
// - new param: vcmSaveParam - aDefault.
//
// Revision 1.2  2003/07/31 15:43:54  law
// - new behavior: сделано сохранение позиций кнопок.
//
// Revision 1.1  2003/07/31 11:50:00  law
// - new behavior: сохранение настроек toolbar'а в базу (пока не работает GblAdapter).
//

{$Include vcmDefine.inc }

interface

uses
  Types,
  Classes,

  Controls,
  Forms,

  l3Interfaces,
  {$IfDef vcmNeedL3}
  l3IID,
  {$EndIf vcmNeedL3}

  afwInterfaces,

  vcmInterfaces,
  vcmExternalInterfaces,

  vcmBase,
  vcmContainerForm,
  vcmAction
  ;

type
  TvcmPathPair = record
    rName    : AnsiString;
  end;//TvcmPathPair

  TvcmPathPairs = array of TvcmPathPair;

  TvcmButtonParams = record
    rVisible  : Boolean;
    rPos      : Cardinal;
    rNeedSep  : Boolean;
    rIconText : Boolean;
  end;//TvcmButtonParams

  TvcmToolbarPositions = record
    rPos           : Integer;
    rRow           : Integer;
    rFloating      : Boolean;
    rDock          : Cardinal;
    rFloatingWidth : Cardinal;
    rFloatX        : Integer;
    rFloatY        : Integer;
  end;//TvcmToolbarPositions

  TvcmFormParams = record
    rFloating          : Boolean;
    rFloatingVisible   : Boolean;
    rParent            : IvcmCString;
    rFloatID           : Integer;
      {* - идентификатор плавающего окна. }
    rFloatWindowState  : Integer;
      {* - состояние плавающего окна. }
    rFloatWindowBounds : TRect;
      {* - положение плавающей формы. }
  end;//TvcmFormParams

const
  vcmGroup = 'Настройки форм';
  vcmAvailableOpsForCustomizeToolbar = 'vcmAvailableFormOpsForCustomize';
   // - доступные для настройки операции;

function  vcmPathPair(const aName    : AnsiString): TvcmPathPair;
  {-}
function  vcmLoadParam(const aPath  : array of TvcmPathPair;
                       aType        : Byte;
                       out aValue;
                       const aDefault;
                       aLoadDefault : boolean = false;
                       const aGroup : AnsiString = vcmGroup): Boolean;
  {-}
function  vcmLoadStrParam(const aPath  : array of TvcmPathPair;
                          out aValue   : IvcmCString;
                          aLoadDefault : boolean = false;
                          const aGroup : AnsiString = vcmGroup): Boolean;
  {-}
function  vcmLoadBoolParam(const aPath    : array of TvcmPathPair;
                           out aValue     : Boolean;
                           aLoadDefault   : Boolean = false;
                           const aGroup   : AnsiString = vcmGroup): Boolean;
  {-}
function  vcmLoadIntParam(const aPath    : array of TvcmPathPair;
                          out aValue     : Integer;
                          const aGroup   : AnsiString = vcmGroup;
                          aLoadDefault   : Boolean = false;
                          const aDefault : Integer = 0): Boolean;
  {-}
function  vcmLoadCardinalParam(const aPath    : array of TvcmPathPair;
                               out aValue     : Cardinal;
                               aLoadDefault   : Boolean = false): Boolean;
  {-}
procedure vcmSaveParam(const aPath  : array of TvcmPathPair; 
                       aType        : Byte;
                       const aValue;
                       const aDefault;
                       const aGroup : AnsiString = vcmGroup);
  {-}
procedure vcmSaveStrParam(const aPath    : array of TvcmPathPair;
                          const aValue   : IvcmCString;
                          const aDefault : ANSIString = '';
                          const aGroup   : AnsiString = vcmGroup);
  {-}
procedure vcmSaveStrParamS(const aPath  : array of TvcmPathPair;
                           const aValue : IvcmCString;
                           const aGroup : AnsiString = vcmGroup);
  {-}
procedure vcmSaveBoolParam(const aPath  : array of TvcmPathPair;
                           aValue       : Boolean;
                           aDefault     : Boolean = true;
                           const aGroup : AnsiString = vcmGroup);
  {-}
procedure vcmSaveBoolParamS(const aPath : array of TvcmPathPair;
                            aValue      : Boolean);
  {-}
procedure vcmSaveIntParam(const aPath  : array of TvcmPathPair;
                          aValue       : Integer;
                          aDefault     : Integer = 0;
                          const aGroup : AnsiString = vcmGroup);
  {-}
procedure vcmSaveIntParamS(const aPath  : array of TvcmPathPair;
                           aValue       : Integer;
                           const aGroup : AnsiString = vcmGroup);
  {-}
procedure vcmSaveCardinalParam(const aPath  : array of TvcmPathPair;
                               aValue       : Cardinal;
                               aDefault     : Cardinal = 0;
                               const aGroup : AnsiString = vcmGroup);
  {-}
procedure vcmSaveCardinalParamS(const aPath : array of TvcmPathPair;
                               aValue       : Cardinal;
                               const aGroup : AnsiString = vcmGroup);
  {-}
procedure vcmCopyPath(const A : array of TvcmPathPair;
                      out B   : TvcmPathPairs);
  {-}
procedure vcmCatPath(const A : array of TvcmPathPair;
                     const B : array of TvcmPathPair;
                     out C   : TvcmPathPairs);
  {-}
function vcmArrayPathPairToString(const aValue : array of TvcmPathPair) : AnsiString;
  {* - преобразует "array of TvcmPathPair" в единый строковый идентификатор. }
function  vcmLoadToolbarVisible(const aUtName  : AnsiString;
                                const aTbName  : AnsiString;
                                out   aVisible : Boolean): Boolean;
  {-}
function  vcmLoadButtonParams(const aUtName : AnsiString;
                              const aTbName : AnsiString;
                              const aEnName : AnsiString;
                              const aOpName : AnsiString;
                              out theParams : TvcmButtonParams): Boolean;
  {-}
function vcmLoadShortcut(const aContOpName : AnsiString;
                         const aOpName     : AnsiString;
                         out aShortcut     : Cardinal;
                         out aSecShort     : IvcmCString): Boolean;
  {-}
procedure vcmSaveShortcut(const aOpContName      : AnsiString;
                          const aOpName          : AnsiString;
                          const aShortcut        : Cardinal;
                          const aSecShort        : IvcmCString;
                          const aDefaultShortcut : Cardinal;
                          const aDefaultSecShort : AnsiString);
  {-}
procedure vcmSaveToolbarAction(const aUtName : AnsiString;
                               const aTbName : AnsiString;
                               anAction      : TvcmAction;
                               anEnabled     : Boolean;
                               anIndex       : Cardinal = High(Cardinal);
                               aNeedSep      : Boolean = false;
                               aIconText     : Boolean = false);
  {-}
procedure vcmSaveToolbarPos(const aUtName : AnsiString;
                            const aTbName : AnsiString;
                            aParams       : TvcmToolbarPositions);
  {-}
function vcmLoadToolbarPos(const aUtName : AnsiString;
                           const aTbName : AnsiString;
                           out aParams   : TvcmToolbarPositions): Boolean;
  {-}
procedure vcmCleanToolbar(const aUTName  : AnsiString;
                          const aTBName  : AnsiString);
  {-}
procedure vcmCleanShortcut(const aOpContName : AnsiString;
                           const aOpName     : AnsiString);
  {-}
procedure vcmLoadForm(aForm: TCustomForm);
  {-}
procedure vcmSaveForm(aForm: TCustomForm);
  {-}
function vcmExtractGroup(aPath: AnsiString): AnsiString;
  {-}
function vcmExtractPath(aPath: AnsiString): AnsiString;
  {-}
function vcmLoadFormParams(anOwner       : TObject;
                           aForm         : TCustomForm;
                           out theParams : TvcmFormParams): Boolean;
  {-}
procedure vcmGetFormPath(aForm       : TwinControl;
                         out thePath : TvcmPathPairs;
                         aCheckUp    : Boolean = true);
  {-}
function vcmLoadFastenMode(out theParam : boolean): boolean;
  {-}
procedure vcmSaveFastenMode(aMode : boolean);
  {-}
procedure vcmLoadFormControls(aForm : TvcmContainerForm);
  overload;
  {-}
procedure vcmLoadFormControls(const aPath : array of TvcmPathPair;
                              const aForm       : TvcmContainerForm);
  overload;
  {-}
function vcmLoadFormStateAndBounds(aForm : TCustomForm) : Boolean;
  {-}

implementation

uses
  TypInfo,

  Math,
  SysUtils,

  {$IfDef vcmNeedL3}
  l3Base,
  {$EndIf vcmNeedL3}

  afwFacade,
  afwConsts,

  vcmModuleAction,
  vcmEntityAction,

  vcmZonesCollectionItem,

  vcmEntityForm,
  vcmMainForm,

  vcmUtils,
  vcmInternalConst,

  vtPanel
  ;

type
  TvcmHackCustomForm = class(TCustomForm);
    {* - сделан для доступа к protected полям TCustomForm. }

function Extract(Var aPath:AnsiString; Var aNewStr:AnsiString):boolean;
Var
 l_Pos:integer;
begin
 if aPath='' then
 begin
  Result:=false;
  exit;
 end;

 Result:=true;
 l_Pos:=Pos(g_afwPathSep, aPath);
 if l_Pos>0 then
 begin
  aNewStr:=copy(aPath, 1, l_Pos-1);
  aPath:=copy(aPath, l_Pos+1, Length(aPath)-l_Pos);
 end
 else
 begin
  aNewStr:=aPath;
  aPath:='';
 end;
end;

function vcmExtractGroup(aPath: AnsiString): AnsiString;
Var
 l_Pos:integer;
begin
 Result:=aPath;
 l_Pos:=Pos(g_afwPathSep, aPath);
 if l_Pos>0 then
 begin
  Result:=copy(aPath, 1, l_Pos-1);
 end;
end;

function vcmExtractPath(aPath: AnsiString): AnsiString;
Var
 l_Pos:integer;
begin
 Result:='';
 l_Pos:=Pos(g_afwPathSep, aPath);
 if l_Pos>0 then
 begin
  Result:=copy(aPath, l_Pos+1, Length(aPath)-l_Pos);
 end;
end;

function vcmPathPair(const aName    : AnsiString): TvcmPathPair;
begin
 Result.rName := aName;
end;

function vcmLoadParam(const aPath  : array of TvcmPathPair;
                      aType        : Byte;
                      out aValue;
                      const aDefault;
                      aLoadDefault : Boolean;
                      const aGroup : AnsiString): Boolean;
{$IfDef vcmUseSettings}
var
 l_Settings  : IafwSettings;
 l_Path      : AnsiString;
 l_Index     : Integer;
{$EndIf vcmUseSettings}
begin
 Result := False;
 {$IfDef vcmUseSettings}
 l_Settings := afw.Application.Settings;
 if (l_Settings <> nil) then
 begin
  // Путь настройки
  l_Path := '';
  for l_Index := Low(aPath) to High(aPath) do
   if (l_Path = '') then
    l_Path := aPath[l_Index].rName
   else
    l_Path := l_Path + g_afwPathSep + aPath[l_Index].rName;
  if (l_Path <> '') then
  begin
   if (aGroup <> '') then
    l_Path := aGroup + g_afwPathSep + l_Path;
   // Читаем
   Result := l_Settings.LoadParam(l_Path, aType, aValue, aDefault,
    aLoadDefault);
  end;//if (l_Path <> '') then
 end;//if (l_Settings <> nil) then
 {$EndIf vcmUseSettings}
end;

procedure vcmSaveParam(const aPath  : array of TvcmPathPair;
                       aType        : Byte;
                       const aValue;
                       const aDefault;
                       const aGroup : AnsiString);
{$IfDef vcmUseSettings}
var
 l_Settings : IafwSettings;
 l_Path     : AnsiString;
 l_Index    : Integer;
 l_Name     : AnsiString;
 l_NewName  : AnsiString;
{$EndIf vcmUseSettings}
begin
 {$IfDef vcmUseSettings}
 l_Settings := afw.Settings;
 if (l_Settings <> nil) then
 try
  l_Path := '';
  for l_Index := Low(aPath) to High(aPath) do
   with aPath[l_Index] do
   begin
    l_Name := rName;
    while Extract(l_Name, l_NewName) do
    begin
     if (l_Path = '') then
      l_Path := l_NewName
     else
      l_Path := l_Path + g_afwPathSep + l_NewName;
     if (l_Index = High(aPath)) then
     begin
      // добавим группу если она определена
      if (aGroup <> '') then
       l_Path := aGroup + g_afwPathSep + l_Path;
      l_Settings.SaveParam(l_Path, aType, aValue, aDefault, False);
     end;//l_Index = High(aPath)
    end;//while Extract(l_Name, l_NewName)
   end;//with aPath[l_Index]
 finally
  l_Settings := nil;
 end;//try..finally
 {$EndIf vcmUseSettings}
end;

procedure vcmSaveStrParam(const aPath    : array of TvcmPathPair;
                          const aValue   : IvcmCString;
                          const aDefault : ANSIString = '';
                          const aGroup   : AnsiString = vcmGroup);
  {-}
begin
 vcmSaveParam(aPath, vtANSIString, aValue, aDefault, aGroup);
end;

procedure vcmSaveStrParamS(const aPath  : array of TvcmPathPair;
                           const aValue : IvcmCString;
                           const aGroup : AnsiString = vcmGroup);
  {-}
begin
 vcmSaveStrParam(aPath, aValue, vcmStr(aValue), aGroup);
end;

procedure vcmSaveBoolParam(const aPath  : array of TvcmPathPair;
                           aValue       : Boolean;
                           aDefault     : Boolean = true;
                           const aGroup : AnsiString = vcmGroup);
begin
 vcmSaveParam(aPath, vtBoolean, aValue, aDefault, aGroup);
end;

procedure vcmSaveBoolParamS(const aPath : array of TvcmPathPair;
                            aValue      : Boolean);
  {-}
begin
 vcmSaveBoolParam(aPath, aValue, aValue);
end;

procedure vcmSaveIntParam(const aPath  : array of TvcmPathPair;
                          aValue       : Integer;
                          aDefault     : Integer;
                          const aGroup : AnsiString);
begin
 vcmSaveParam(aPath, vtInteger, aValue, aDefault, aGroup);
end;

procedure vcmSaveIntParamS(const aPath  : array of TvcmPathPair;
                           aValue       : Integer;
                           const aGroup : AnsiString = vcmGroup);
  {-}
begin
 vcmSaveIntParam(aPath, aValue, aValue, aGroup);
end;

procedure vcmSaveCardinalParam(const aPath  : array of TvcmPathPair;
                               aValue       : Cardinal;
                               aDefault     : Cardinal = 0;
                               const aGroup : AnsiString = vcmGroup);
begin
 vcmSaveParam(aPath, vtInteger, aValue, aDefault, aGroup);
end;

procedure vcmSaveCardinalParamS(const aPath : array of TvcmPathPair;
                               aValue       : Cardinal;
                               const aGroup : AnsiString = vcmGroup);
begin
 vcmSaveParam(aPath, vtInteger, aValue, aValue, aGroup);
end;

const
 cToolbars          : TvcmPathPair = (rName: 'Toolbars');
 cPosition          : TvcmPathPair = (rName: 'Position');
 cNeedSep           : TvcmPathPair = (rName: 'NeedSep');
 cMaximized         : TvcmPathPair = (rName: 'Maximized');
 cLeft              : TvcmPathPair = (rName: 'Left');
 cTop               : TvcmPathPair = (rName: 'Top');
 cWidth             : TvcmPathPair = (rName: 'Width');
 cHeight            : TvcmPathPair = (rName: 'Height');
 cParentWidth       : TvcmPathPair = (rName: 'ParentWidth');
 cParentHeight      : TvcmPathPair = (rName: 'ParentHeight');
 // Константы для записи положения плавающего окна /////////////////////////////
 cFloatLeft         : TvcmPathPair = (rName: 'FloatLeft');
 cFloatTop          : TvcmPathPair = (rName: 'FloatTop');
 cFloatWidth        : TvcmPathPair = (rName: 'FloatWidth');
 cFloatHeight       : TvcmPathPair = (rName: 'FloatHeight');
 ///////////////////////////////////////////////////////////////////////////////
 cToolbarPos        : TvcmPathPair = (rName: 'Position');
 cToolbarRow        : TvcmPathPair = (rName: 'Row');
 cToolbarDock       : TvcmPathPair = (rName: 'Dock');
 cToolbarFloat      : TvcmPathPair = (rName: 'Floating');
 cToolbarWidth      : TvcmPathPair = (rName: 'Width');
 cToolbarFloatX     : TvcmPathPair = (rName: 'FloatX');
 cToolbarFloatY     : TvcmPathPair = (rName: 'FloatY');
 cVisible           : TvcmPathPair = (rName: 'Visible');
 cZone              : TvcmPathPair = (rName: 'Zone');
 cIconText          : TvcmPathPair = (rName: 'IconText');
 cFastenToolbars    : TvcmPathPair = (rName: 'FastenToolbars');
 cFloatWindowID     : TvcmPathPair = (rName: 'FloatWindowID');
 cFloatWindowState  : TvcmPathPair = (rName: 'FloatWindowState');
 cFloatingVisible  : TvcmPathPair = (rName: 'FloatingVisible');
 cDefaultPositions  : TvcmPathPair = (rName: 'DefaultPositions');
 cDefaultOperations : TvcmPathPair = (rName: 'DefaultOperations');
 cDefaultShortcut   : TvcmPathPair = (rName: 'DefaultShortcut');
 cShortcuts         : TvcmPathPair = (rName: 'Shortcuts');
 cShortcut          : TvcmPathPair = (rName: 'Shortcut');
 cSecondaryShortcut : TvcmPathPair = (rName: 'SecShortcut');

procedure vcmCopyPath(const A : array of TvcmPathPair;
                      out B   : TvcmPathPairs);
  {-}
var
 l_ALen  : Integer;
 l_Index : Integer;
begin
 l_ALen := Succ(High(A));
 SetLength(B, l_ALen);
 for l_Index := 0 to Pred(l_ALen) do
  B[l_Index] := A[l_Index];
end;

procedure vcmCatPath(const A : array of TvcmPathPair;
                     const B : array of TvcmPathPair;
                     out C   : TvcmPathPairs);
  {-}
var
 l_ALen  : Integer;
 l_BLen  : Integer;
 l_Index : Integer;
begin
 l_ALen := Succ(High(A));
 l_BLen := Succ(High(B));
 SetLength(C, l_ALen + l_BLen);
 for l_Index := 0 to Pred(l_ALen) do
  C[l_Index] := A[l_Index];
 for l_Index := 0 to Pred(l_BLen) do
  C[l_ALen + l_Index] := B[l_Index];
end;

function vcmArrayPathPairToString(const aValue : array of TvcmPathPair) : AnsiString;
  {* - преобразует "array of TvcmPathPair" в единый строковый идентификатор. }
var
 lIndex : Integer;
begin
 Result := '';
 for lIndex := Low(aValue) to High(aValue) do
 begin
  if Result <> '' then
   Result := Result + g_afwPathSep;
  Result := Result + aValue[lIndex].rName;
 end;
end;

function vcmLoadToolbarVisible(const aUtName : AnsiString;
                               const aTbName : AnsiString;
                               out aVisible  : Boolean): Boolean;
  {-}
Var
 l_LoadDefault : boolean;
begin
 if not vcmLoadBoolParam([
                   vcmPathPair(aUtName),
                   cToolbars,
                   vcmPathPair(aTbName),
                   cDefaultOperations
                  ], l_LoadDefault) then
  l_LoadDefault := false;
 Result := vcmLoadBoolParam([
                             vcmPathPair(aUtName),
                             cToolbars,
                             vcmPathPair(aTbName),
                             cVisible
                            ],
                            aVisible,
                            l_LoadDefault);
end;

procedure vcmSaveToolbarAction(const aUtName : AnsiString;
                               const aTbName : AnsiString;
                               anAction      : TvcmAction;
                               anEnabled     : Boolean;
                               anIndex       : Cardinal = High(Cardinal);
                               aNeedSep      : Boolean = false;
                               aIconText     : Boolean = false);
  {-}
{$IfDef vcmUseSettings}
var
 l_Name   : AnsiString;
 l_OpName : AnsiString;
{$EndIf vcmUseSettings}
begin
 {$IfDef vcmUseSettings}
 if Assigned(afw.Application.Settings) then
 begin
  if (anAction <> nil) then
  begin
   if (anAction Is TvcmEntityAction) then
   begin
    with TvcmEntityAction(anAction).EntityDef do
     l_Name := Name;
    with TvcmEntityAction(anAction).OpDef do
     l_OpName := Name;
   end
   else if (anAction Is TvcmModuleAction) then
   begin
    with g_Dispatcher.GetModuleByID(TvcmModuleAction(anAction).ModuleID).ModuleDef do
     l_Name := Name;
    with TvcmModuleAction(anAction).OpDef do
     l_OpName := Name;
   end else
    Exit;
   vcmSaveBoolParamS([
                      vcmPathPair(aUtName),
                      cToolbars,
                      vcmPathPair(aTbName),
                      cDefaultOperations
                     ],
                     false);
   vcmSaveBoolParamS([
                     vcmPathPair(aUtName),
                     cToolbars,
                     vcmPathPair(aTbName),
                     cVisible
                    ],
                     true);
   vcmSaveBoolParamS([
                     vcmPathPair(aUtName),
                     cToolbars,
                     vcmPathPair(aTbName),
                     vcmPathPair(l_Name),
                     vcmPathPair(l_OpName)
                    ],
                     anEnabled);
   vcmSaveCardinalParamS([
                         vcmPathPair(aUtName),
                         cToolbars,
                         vcmPathPair(aTbName),
                         vcmPathPair(l_Name),
                         vcmPathPair(l_OpName),
                         cPosition
                        ],
                        anIndex);
   vcmSaveBoolParamS([
                     vcmPathPair(aUtName),
                     cToolbars,
                     vcmPathPair(aTbName),
                     vcmPathPair(l_Name),
                     vcmPathPair(l_OpName),
                     cNeedSep
                    ],
                    aNeedSep);
   vcmSaveBoolParamS([
                     vcmPathPair(aUtName),
                     cToolbars,
                     vcmPathPair(aTbName),
                     vcmPathPair(l_Name),
                     vcmPathPair(l_OpName),
                     cIconText
                    ],
                    aIconText);
  end;//anAction <> nil
 end;//g_Dispatcher <> nil..
 {$EndIf vcmUseSettings}
end;

procedure vcmSaveToolbarPos(const aUtName : AnsiString;
                            const aTbName : AnsiString;
                            aParams       : TvcmToolbarPositions);
  {-}
begin
 vcmSaveBoolParamS([
                    vcmPathPair(aUtName),
                    cToolbars,
                    vcmPathPair(aTbName),
                    cDefaultPositions
                   ],
                   false);

 vcmSaveCardinalParamS([
                       vcmPathPair(aUtName),
                       cToolbars,
                       vcmPathPair(aTbName),
                       cToolbarPos
                      ],
                      Cardinal(aParams.rPos));
 vcmSaveCardinalParamS([
                       vcmPathPair(aUtName),
                       cToolbars,
                       vcmPathPair(aTbName),
                       cToolbarRow
                      ],
                      Cardinal(aParams.rRow));
 vcmSaveBoolParamS([
                   vcmPathPair(aUtName),
                   cToolbars,
                   vcmPathPair(aTbName),
                   cToolbarFloat
                  ],
                  aParams.rFloating);
 vcmSaveCardinalParamS([
                       vcmPathPair(aUtName),
                       cToolbars,
                       vcmPathPair(aTbName),
                       cToolbarDock
                      ],
                      aParams.rDock);
 vcmSaveCardinalParamS([
                       vcmPathPair(aUtName),
                       cToolbars,
                       vcmPathPair(aTbName),
                       cToolbarWidth
                      ],
                      aParams.rFloatingWidth);
 vcmSaveCardinalParamS([
                       vcmPathPair(aUtName),
                       cToolbars,
                       vcmPathPair(aTbName),
                       cToolbarFloatX
                      ],
                      Cardinal(aParams.rFloatX));
 vcmSaveCardinalParamS([
                       vcmPathPair(aUtName),
                       cToolbars,
                       vcmPathPair(aTbName),
                       cToolbarFloatY
                      ],
                      Cardinal(aParams.rFloatY));
end;

procedure vcmSaveShortcut(const aOpContName      : AnsiString;
                          const aOpName          : AnsiString;
                          const aShortcut        : Cardinal;
                          const aSecShort        : IvcmCString;
                          const aDefaultShortcut : Cardinal;
                          const aDefaultSecShort : AnsiString);
  {-}
begin
 vcmSaveBoolParamS([
                    cShortcuts,
                    vcmPathPair(aOpContName),
                    vcmPathPair(aOpName),
                    cDefaultShortcut
                    ],
                    false);
 vcmSaveCardinalParam([
                        cShortcuts,
                        vcmPathPair(aOpContName),
                        vcmPathPair(aOpName),
                        cShortcut
                        ],
                        aShortcut,
                        aDefaultShortcut);
 vcmSaveStrParam([
                  cShortcuts,
                  vcmPathPair(aOpContName),
                  vcmPathPair(aOpName),
                  cSecondaryShortcut
                  ],
                  aSecShort,
                  aDefaultSecShort);
end;

function vcmLoadToolbarPos(const aUtName : AnsiString;
                           const aTbName : AnsiString;
                           out aParams   : TvcmToolbarPositions): Boolean;
  {-}
Var
 l_LoadDefault: boolean;
begin
 if not vcmLoadBoolParam([
                   vcmPathPair(aUtName),
                   cToolbars,
                   vcmPathPair(aTbName),
                   cDefaultPositions
                  ], l_LoadDefault) then
  l_LoadDefault := false;                  

 Result := vcmLoadCardinalParam([vcmPathPair(aUtName),
                                 cToolbars,
                                 vcmPathPair(aTbName),
                                 cToolbarPos],
                                 Cardinal(aParams.rPos),
                                 l_LoadDefault) and
           vcmLoadCardinalParam([vcmPathPair(aUtName),
                                 cToolbars,
                                 vcmPathPair(aTbName),
                                 cToolbarRow],
                                 Cardinal(aParams.rRow),
                                 l_LoadDefault) and
           vcmLoadBoolParam([vcmPathPair(aUtName),
                             cToolbars,
                             vcmPathPair(aTbName),
                             cToolbarFloat],
                             aParams.rFloating,
                             l_LoadDefault) and
           vcmLoadCardinalParam([vcmPathPair(aUtName),
                                 cToolbars,
                                 vcmPathPair(aTbName),
                                 cToolbarDock],
                                 aParams.rDock,
                                 l_LoadDefault) and
           vcmLoadCardinalParam([vcmPathPair(aUtName),
                                 cToolbars,
                                 vcmPathPair(aTbName),
                                 cToolbarWidth],
                                 aParams.rFloatingWidth,
                                 l_LoadDefault) and
           vcmLoadCardinalParam([vcmPathPair(aUtName),
                                 cToolbars,
                                 vcmPathPair(aTbName),
                                 cToolbarFloatX],
                                 Cardinal(aParams.rFloatX),
                                 l_LoadDefault) and
           vcmLoadCardinalParam([vcmPathPair(aUtName),
                                 cToolbars,
                                 vcmPathPair(aTbName),
                                 cToolbarFloatY],
                                 Cardinal(aParams.rFloatY),
                                 l_LoadDefault);
end;

function vcmLoadButtonParams(const aUtName : AnsiString;
                             const aTbName : AnsiString;
                             const aEnName : AnsiString;
                             const aOpName : AnsiString;
                             out theParams : TvcmButtonParams): Boolean;
  {-}
Var
 l_LoadDefault: boolean;  
begin
 if not vcmLoadBoolParam([
                   vcmPathPair(aUtName),
                   cToolbars,
                   vcmPathPair(aTbName),
                   cDefaultOperations
                  ], l_LoadDefault) then
  l_LoadDefault := false;                  

 Result := vcmLoadBoolParam([vcmPathPair(aUtName),
                             cToolbars,
                             vcmPathPair(aTbName),
                             vcmPathPair(aEnName),
                             vcmPathPair(aOpName)],
                             theParams.rVisible,
                             l_LoadDefault) AND
           vcmLoadCardinalParam([vcmPathPair(aUtName),
                                 cToolbars,
                                 vcmPathPair(aTbName),
                                 vcmPathPair(aEnName),
                                 vcmPathPair(aOpName),
                                 cPosition],
                                 theParams.rPos,
                                 l_LoadDefault) AND
           vcmLoadBoolParam([vcmPathPair(aUtName),
                             cToolbars,
                             vcmPathPair(aTbName),
                             vcmPathPair(aEnName),
                             vcmPathPair(aOpName),
                             cNeedSep],
                             theParams.rNeedSep,
                             l_LoadDefault) AND
           vcmLoadBoolParam([vcmPathPair(aUtName),
                             cToolbars,
                             vcmPathPair(aTbName),
                             vcmPathPair(aEnName),
                             vcmPathPair(aOpName),
                             cIconText],
                             theParams.rIconText,
                             l_LoadDefault);
end;

function vcmLoadShortcut(const aContOpName : AnsiString;
                         const aOpName     : AnsiString;
                         out aShortcut     : Cardinal;
                         out aSecShort     : IvcmCString): Boolean;
  {-}
Var
 l_LoadDefault: boolean;
begin
 if not vcmLoadBoolParam([
                          cShortcuts,
                          vcmPathPair(aContOpName),
                          vcmPathPair(aOpName),
                          cDefaultShortcut],
                          l_LoadDefault) then
  l_LoadDefault := false;
                    
 Result := vcmLoadCardinalParam([
                                 cShortcuts,
                                 vcmPathPair(aContOpName),
                                 vcmPathPair(aOpName),
                                 cShortcut],
                                 aShortcut,
                                 l_LoadDefault) AND
           vcmLoadStrParam([
                            cShortcuts,
                            vcmPathPair(aContOpName),
                            vcmPathPair(aOpName),
                            cSecondaryShortcut],
                            aSecShort,
                            l_LoadDefault);
end;

function  vcmLoadStrParam(const aPath  : array of TvcmPathPair;
                          out aValue   : IvcmCString;
                          aLoadDefault : boolean;
                          const aGroup : AnsiString): Boolean;
  {-}
var
 lStr : AnsiString;
begin
 lStr := '';
 Result := vcmLoadParam(aPath, vtANSIString, aValue, lStr, aLoadDefault, aGroup);
end;

function  vcmLoadBoolParam(const aPath    : array of TvcmPathPair;
                           out aValue     : Boolean;
                           aLoadDefault   : Boolean = False;
                           const aGroup   : AnsiString = vcmGroup): Boolean;
  {-}
var
 lBool : Boolean;
begin
 lBool := False;
 Result := vcmLoadParam(aPath, vtBoolean, aValue, lBool, aLoadDefault, aGroup);
end;

function  vcmLoadIntParam(const aPath    : array of TvcmPathPair;
                          out aValue     : Integer;
                          const aGroup   : AnsiString;
                          aLoadDefault   : Boolean;
                          const aDefault : Integer): Boolean;
  {-}
begin
 Result := vcmLoadParam(aPath, vtInteger, aValue, aDefault, aLoadDefault, aGroup);
end;

function  vcmLoadCardinalParam(const aPath  : array of TvcmPathPair;
                               out aValue   : Cardinal;
                               aLoadDefault : Boolean = False): Boolean;
  {-}
var
 lCar : Cardinal;
begin
 lCar := 0;
 Result := vcmLoadParam(aPath, vtInteger, aValue, lCar, aLoadDefault);
end;

type
 THackWinControl = class(TWinControl);

function vcmGetFormPathEntry(aForm: TWinControl): TvcmPathPair;
begin
 if (aForm Is TvcmEntityForm) AND
    (TvcmEntityForm(aForm).CurUserTypeDef <> nil) then
 begin
  with TvcmEntityForm(aForm).CurUserTypeDef do
   Result.rName := Name + TvcmEntityForm(aForm).SettingsSuffix;
 end//aForm Is TvcmEntityForm
 else
 begin
  if (aForm Is TvcmEntityForm) then
   Result.rName := TvcmEntityForm(aForm).FormID.rName
  else
   Result.rName := THackWinControl(aForm).Caption;
 end;//TvcmEntityForm(aForm).CurUserTypeDef <> nil
end;

function vcmLoadFormRect(const aPath : array of TvcmPathPair;
                         aForm       : TCustomForm;
                         out theRect : TRect): Boolean;
  {-}
var
 l_PPath : TvcmPathPairs;
begin
 Result := false;
 vcmCatPath(aPath, cTop, l_PPath);
 if vcmLoadIntParam(l_PPath, theRect.Top) then
  Result := true
 else
  theRect.Top := aForm.Top;
 vcmCatPath(aPath, cLeft, l_PPath);
 if vcmLoadIntParam(l_PPath, theRect.Left) then
  Result := true
 else
  theRect.Left := aForm.Left;
 vcmCatPath(aPath, cHeight, l_PPath);
 if vcmLoadIntParam(l_PPath, theRect.Bottom) then
  Result := true
 else
  theRect.Bottom := aForm.Height;
 theRect.Bottom := theRect.Top + theRect.Bottom;
 vcmCatPath(aPath, cWidth, l_PPath);
 if vcmLoadIntParam(l_PPath, theRect.Right) then
  Result := true
 else
  theRect.Right := aForm.Width;
 theRect.Right := theRect.Left + theRect.Right;
end;

procedure vcmLoadFloatBounds(const aPath : array of TvcmPathPair;
                             out theRect : TRect);
{* - читает положение плавающей формы, для данной формы. }
var
 l_PPath : TvcmPathPairs;
begin
 vcmCatPath(aPath, cFloatTop,    l_PPath); vcmLoadIntParam(l_PPath, theRect.Top);
 vcmCatPath(aPath, cFloatLeft,   l_PPath); vcmLoadIntParam(l_PPath, theRect.Left);
 vcmCatPath(aPath, cFloatHeight, l_PPath); vcmLoadIntParam(l_PPath, theRect.Bottom);
 vcmCatPath(aPath, cFloatWidth,  l_PPath); vcmLoadIntParam(l_PPath, theRect.Right);
end;

procedure vcmSaveFloatBounds(const aPath   : array of TvcmPathPair;
                             const theRect : TRect);
{* - записывает положение плавающей формы, для данной формы. }
var
 l_PPath : TvcmPathPairs;
begin
 // пустой theRect означает, что форма не была плавающей
 if IsRectEmpty(theRect) then
  Exit;
 vcmCatPath(aPath, cFloatTop,    l_PPath); vcmSaveIntParam(l_PPath, theRect.Top);
 vcmCatPath(aPath, cFloatLeft,   l_PPath); vcmSaveIntParam(l_PPath, theRect.Left);
 vcmCatPath(aPath, cFloatHeight, l_PPath); vcmSaveIntParam(l_PPath, theRect.Bottom);
 vcmCatPath(aPath, cFloatWidth,  l_PPath); vcmSaveIntParam(l_PPath, theRect.Right);
end;

function vcmLoadExtent(const aPath    : array of TvcmPathPair;
                        const aControl : TControl) : Boolean;
  {-}
var
 l_Value : Integer;
 l_Path  : TvcmPathPairs;
 l_ParentValue: Integer;
 l_NeedAlign: Boolean;
 l_ParentControl: IafwProportionalControl;
begin
 Result := false;
 l_NeedAlign := False;
 if aControl.Align = alClient then
  Exit;
 if aControl.Parent = nil then
  Exit;
 Supports(aControl.Parent, IafwProportionalControl, l_ParentControl);
 vcmCatPath(aPath, cWidth, l_Path);
 if vcmLoadIntParam(l_Path, l_Value) and
   (aControl.Align in [alNone, alLeft, alRight]) then
 begin
  vcmCatPath(aPath, cParentWidth, l_Path);
  if Assigned(l_ParentControl) and
     vcmLoadIntParam(l_Path, l_ParentValue) and
     (l_ParentValue <> aControl.Parent.Width) then
  begin
   if l_ParentValue = 0 then
    l_ParentValue := aControl.Parent.Width;
   l_Value := (aControl.Parent.Width * l_Value) div l_ParentValue;
  end;//Assigned(l_ParentControl) and vcmLoadIntParam(l_Path, l_ParentValue) and (l_ParentValue <> aControl.Parent.Width)
  aControl.Width := l_Value;
  l_NeedAlign := True;
 end;//vcmLoadIntParam(l_Path, l_Value)
 vcmCatPath(aPath, cHeight, l_Path);
 if vcmLoadIntParam(l_Path, l_Value) and
   (aControl.Align in [alNone, alTop, alBottom]) then
 begin
  vcmCatPath(aPath, cParentHeight, l_Path);
  if Assigned(l_ParentControl) and
     vcmLoadIntParam(l_Path, l_ParentValue) and
     (l_ParentValue <> aControl.Parent.Height) then
  begin
   if l_ParentValue = 0 then
    l_ParentValue := aControl.Parent.Height;
   l_Value := (aControl.Parent.Height * l_Value) div l_ParentValue;
  end;//Assigned(l_ParentControl) and vcmLoadIntParam(l_Path, l_ParentValue) and (l_ParentValue <> aControl.Parent.Height)
  aControl.Height := l_Value;
  l_NeedAlign := True;
 end;//vcmLoadIntParam(l_Path, l_Value)
 if l_NeedAlign then
  Result := true;
 if l_NeedAlign and Assigned(l_ParentControl) then
  l_ParentControl.NotifyLoaded;
end;

function vcmGetNonClientAlignedControl(const aControl: TControl;
                                       const aForm: TvcmContainerForm): TControl;
begin
 Result := aControl;
 while (Result <> nil) and (Result <> aForm) and (Result.Align = alClient) do
  Result := Result.Parent;
 if Result = aForm then
  Result := nil;
end;

procedure vcmLoadOwnedControl(const aPath: array of TvcmPathPair;
                              const aControl: TControl;
                              const aForm: TvcmContainerForm);
var
 l_Path : TvcmPathPairs;
 l_Control: TControl;
begin
 l_Control := vcmGetNonClientAlignedControl(aControl, aForm);
 if Assigned(l_Control) then
 begin
  vcmCatPath(aPath, [vcmPathPair(l_Control.Name)], l_Path);
  if not vcmLoadExtent(l_Path, l_Control) then
  begin
(*   if (l_Control.Name = 'RightNavigator') then
    vcmCatPath(aPath, [vcmPathPair('fRightNavigator')], l_Path)
   else
   if (l_Control.Name = 'LeftNavigator') then
    vcmCatPath(aPath, [vcmPathPair('fLeftNavigator')], l_Path)
   else
    Exit;
   vcmLoadExtent(l_Path, l_Control);*)
  end;//not vcmLoadExtent(l_Path, l_Control)
 end;//Assigned(l_Control)
end;

procedure vcmLoadFormControls(aForm : TvcmContainerForm);
var
 l_Path : TvcmPathPairs;
begin
 vcmGetFormPath(aForm, l_Path);
 vcmLoadFormControls(l_Path, aForm);
end;

procedure vcmLoadFormControls(const aPath: array of TvcmPathPair;
                              const aForm: TvcmContainerForm);
  {-}
var
 l_Index : Integer;
 l_Zone  : TvcmZonesCollectionItem;
begin
 with aForm.Zones do
  for l_Index := 0 to Pred(Count) do
  begin
   l_Zone := TvcmZonesCollectionItem(Items[l_Index]);
   if (l_Zone.Control Is TControl) then
    vcmLoadOwnedControl(aPath, TControl(l_Zone.Control), aForm);
  end;//for l_Index
end;

function vcmIsCanMaximized(aForm : TCustomForm) : Boolean;
var
 l_Form: IvcmSizeableForm;
begin
 if Supports(aForm, IvcmSizeableForm, l_Form) then
 begin
  try
   Result := l_Form.CanBeMaximized;
  finally
   l_Form := nil;
  end;//try..finally
 end
 else
  Result := (not (aForm.BorderStyle in [bsDialog, bsSingle, bsNone]));
end;

function vcmIsSetBoundsRect(aForm : TCustomForm) : Boolean;
var
 l_Form: IvcmSizeableForm;
begin
 if Supports(aForm, IvcmSizeableForm, l_Form) then
 begin
  try
   Result := l_Form.CanChangeSize;
  finally
   l_Form := nil;
  end;
 end
 else
  Result := (aForm.BorderStyle in [bsSizeable, bsSizeToolWin]);
end;

function vcmLoadFormStateAndBounds(aForm : TCustomForm) : Boolean;
var
 l_Path      : TvcmPathPairs;
 l_PPath     : TvcmPathPairs;
 l_Maximized : Boolean;
 l_Rect      : TRect;
begin
 Result := False;
 (* Maximized property *)
 vcmGetFormPath(aForm, l_Path);
 (* Bounds property *)
 vcmCatPath(l_Path, cMaximized, l_PPath);
 if vcmLoadBoolParam(l_PPath, l_Maximized) and (l_Maximized) and
  vcmIsCanMaximized(aForm) then
 begin
  aForm.WindowState := wsMaximized;
  Result := True;
 end//vcmLoadBoolParam(l_PPath, l_Maximized) and (l_Maximized)
 else
 if vcmIsSetBoundsRect(aForm) and
  vcmLoadFormRect(l_Path, aForm, l_Rect) then
 begin
  with aForm do
   SetBounds(l_Rect.Left, l_Rect.Top, Width, Height);
  Result := True;
 end;//vcmIsSetBoundsRect(aForm)
end;

procedure vcmLoadForm(aForm: TCustomForm);
  {-}
var
 l_Path      : TvcmPathPairs;
 l_PPath     : TvcmPathPairs;
 l_Maximized : Boolean;
 l_NeedLoad  : Boolean;
 l_ChangePos : Boolean;
 l_Rect      : TRect;
 l_IsMain    : Boolean;
 l_IsMainContainer: Boolean;
begin
 if (aForm Is TvcmEntityForm) then
  if TvcmEntityForm(aForm).NeedSaveInSettings then
  begin
   vcmGetFormPath(aForm, l_Path);
   l_ChangePos := false;
   l_IsMain := (aForm Is TvcmMainForm);
   l_IsMainContainer := Supports(aForm, IafwMainFormContainer);
   if l_IsMain OR l_IsMainContainer then
    l_NeedLoad := True
   else
    l_NeedLoad := (TvcmEntityForm(aForm).ZoneType in vcm_NotContainedForm);
   if l_NeedLoad then
   begin
    vcmCatPath(l_Path, cMaximized, l_PPath);
    if vcmLoadBoolParam(l_PPath, l_Maximized) AND l_Maximized then
    begin
     (* максимизируем *)
     if vcmIsCanMaximized(aForm) then
     begin
      aForm.WindowState := wsMaximized;
      l_ChangePos := true;
     end//vcmIsCanMaximized(aForm)
     (* форма с неизменяемыми размерами установим Left, Top *)
     else
     if vcmLoadFormRect(l_Path, aForm, l_Rect) then
     begin
      aForm.Left := l_Rect.Left;
      aForm.Top := l_Rect.Top;
     end;//vcmLoadFormRect(l_Path, aForm, l_Rect)
    end//vcmLoadBoolParam(l_PPath, l_Maximized) AND l_Maximized
    else
    begin
     if vcmLoadFormRect(l_Path, aForm, l_Rect) then
     begin
      l_Rect := vcmUtils.vcmCheckWindowBounds(l_Rect);
 //     l_ChangePos := true;
      // - это тоже не глупость (!) с включенной этой строчкое неправильно
      //   показывалось окно выбора атрибута в ППР, при этом с папками все ОК
      if vcmIsSetBoundsRect(aForm) then
       aForm.BoundsRect := l_Rect
      else
      begin
       aForm.Left := l_Rect.Left;
       aForm.Top := l_Rect.Top;
      end;//vcmIsSetBoundsRect(aForm)
 (*     Assert(aForm.Height > 0,
             Format('Высота формы %s, считанная из настроек почему-то оказалась <= 0', [aForm.ClassName]));*)
     end;//vcmLoadFormRect(l_Path, aForm, l_Rect)
    end;//vcmLoadBoolParam(l_PPath, l_Maximized) AND l_Maximized
   end//l_NeedLoad
   else
   if l_IsMain OR l_IsMainContainer then
    l_ChangePos := true;
    // - это не глупость (!) это серьезно уменьшает время открытия нового окна
   if l_ChangePos and
      (
        // Для главной формы с WindowState = wsMaximized нужно установить
        // aForm.Position в котором вызывается RecreateWnd, иначе при создании
        // пунктов меню придёт WMSize с SizeType = SIZENORMAL и Maximized слетит:
        l_IsMain or
        // Для остальных форм (они у нас модальные) не вызываем, потому что в
        // этом случае при восстановлении окно сворачивается в трубочку:
        (aForm.WindowState <> wsMaximized)
      ) then
    TvcmHackCustomForm(aForm).Position := poDefault;
 (*  Assert(l_IsMain OR
          (aForm.Height > 0) OR
          not(aForm.Parent Is TvtCustomPanel),
          Format('Высота формы %s почему-то оказалась <= 0', [aForm.ClassName]));*)
   if l_IsMain OR (aForm Is TvcmContainerForm) then
    vcmLoadFormControls(l_Path, TvcmContainerForm(aForm));
  end;//aForm Is TvcmEntityForm
end;//vcmLoadForm

procedure vcmGetFormPath(aForm       : TWinControl;
                         out thePath : TvcmPathPairs;
                         aCheckUp    : Boolean = true);
  {-}
var
 l_Ofs   : Integer;
 l_Len   : Integer;
 l_Index : Integer;
 l_Zone  : AnsiString;
 l_Path  : TvcmPathPairs;
 l_Cont  : IvcmContainer;
begin
 l_Ofs := 0;
 if (aForm Is TvcmEntityForm) AND not (aForm Is TvcmMainForm) then
 begin
  if not (TvcmEntityForm(aForm).ZoneType in vcm_NotContainedForm) then
  begin
   l_Zone := GetEnumName(TypeInfo(TvcmZoneType), Ord(TvcmEntityForm(aForm).ZoneType));
   Assert(l_Zone <> '');
   SetLength(l_Path, Succ(l_Ofs));
   l_Path[l_Ofs] := vcmPathPair(l_Zone);
   Inc(l_Ofs);
  end;//not (TvcmEntityForm(aForm).ZoneType in vcm_NotContainedForm)
 end;//aForm Is TvcmEntityForm..
 SetLength(l_Path, Succ(l_Ofs));
 l_Path[l_Ofs] := vcmGetFormPathEntry(aForm);
 if aCheckUp AND (aForm Is TvcmEntityForm) then
 begin
  while true do
  begin
   l_Cont := TvcmEntityForm(aForm).Container;
   if (l_Cont = nil) OR l_Cont.IsNull then
    break;
   l_Len := Length(l_Path);
   SetLength(l_Path, Succ(l_Len));
   aForm := l_Cont.AsForm.VCLWinControl As TCustomForm;
   l_Path[l_Len] := vcmGetFormPathEntry(aForm);
  end;//while true
 end;//aForm Is TvcmEntityForm
 l_Len := Length(l_Path);
 if (l_Len = 1) then
  thePath := l_Path
 else
 begin
  SetLength(thePath, l_Len);
  for l_Index := 0 to Pred(l_Len) do
   thePath[l_Index] := l_Path[Pred(l_Len) - l_Index];
 end;//l_Len = 1
end;

function vcmLoadFastenMode(out theParam : boolean): boolean;
begin
 Result := vcmLoadBoolParam([cFastenToolbars], theParam);
end;

procedure vcmSaveFastenMode(aMode : boolean);
begin
 vcmSaveBoolParamS([cFastenToolbars], aMode);
end;

procedure vcmSaveExtent(const aPath    : array of TvcmPathPair;
                        const aControl : TControl);
  {-}
var
 l_Path : TvcmPathPairs;
 l_ControlWidth: Integer;
 l_ControlHeight: Integer;
begin
 if Assigned(aControl.Parent) and Supports(aControl.Parent, IafwProportionalControl) then
  with aControl.Parent do
  begin
   vcmCatPath(aPath, cParentWidth, l_Path);
   vcmSaveIntParamS(l_Path, Width);
   vcmCatPath(aPath, cParentHeight, l_Path);
   vcmSaveIntParamS(l_Path, Height);
  end;
 //http://mdp.garant.ru/pages/viewpage.action?pageId=271750647
 (*if (aControl.Width >= aControl.Constraints.MinWidth + 5) then
 begin*)
  vcmCatPath(aPath, cWidth, l_Path);
  l_ControlWidth := Max(aControl.Constraints.MinWidth, aControl.Width);
  vcmSaveIntParamS(l_Path, l_ControlWidth);
 (*end;//..Width..*)
 //http://mdp.garant.ru/pages/viewpage.action?pageId=271750647
(* if (aControl.Height >= aControl.Constraints.MinHeight + 5) then
 begin*)
  vcmCatPath(aPath, cHeight, l_Path);
  l_ControlHeight := Max(aControl.Constraints.MinHeight, aControl.Height);
  vcmSaveIntParamS(l_Path, l_ControlHeight);
(* end;//..Height.. *)
end;

procedure vcmSaveOwnedControl(const aPath: array of TvcmPathPair;
                              const aControl: TControl;
                              const aForm: TvcmContainerForm);
var
 l_Path : TvcmPathPairs;
 l_Control: TControl;
begin
 l_Control := vcmGetNonClientAlignedControl(aControl, aForm);
 if Assigned(l_Control) then
 begin
  vcmCatPath(aPath, [vcmPathPair(l_Control.Name)], l_Path);
  vcmSaveExtent(l_Path, l_Control);
 end;//Assigned(l_Control) then
end;

procedure vcmSaveLayout(const aPath : array of TvcmPathPair;
                        aForm       : TCustomForm);
  {-}
var
 l_Path : TvcmPathPairs;
begin
 vcmCatPath(aPath, cMaximized, l_Path);
 vcmSaveBoolParamS(l_Path, aForm.WindowState = wsMaximized);
 vcmCatPath(aPath, cTop, l_Path);
 vcmSaveIntParamS(l_Path, aForm.Top);
 vcmCatPath(aPath, cLeft, l_Path);
 vcmSaveIntParamS(l_Path, aForm.Left);
 vcmSaveExtent(aPath, aForm);
end;

procedure vcmSaveFormControls(const aPath: array of TvcmPathPair;
                              const aForm: TvcmContainerForm);
  {-}
var
 l_Index : Integer;
 l_Zone  : TvcmZonesCollectionItem;
begin
 with aForm.Zones do
  for l_Index := 0 to Pred(Count) do
  begin
   l_Zone := TvcmZonesCollectionItem(Items[l_Index]);
   if (l_Zone.Control Is TControl) then
    vcmSaveOwnedControl(aPath, TControl(l_Zone.Control), aForm);
  end;//for l_Index
end;

procedure vcmSaveForm(aForm: TCustomForm);
  {-}
var
 l_NeedSave : Boolean;
 l_Path     : TvcmPathPairs;
 l_PPath    : TvcmPathPairs;
 l_Parent   : TControl;
 l_Saved    : Boolean;
 l_Floating : Boolean;
 l_PForm    : TCustomForm;
 l_IsMainContainer: Boolean;
begin
 if (aForm Is TvcmEntityForm) then
  if TvcmEntityForm(aForm).NeedSaveInSettings then
  begin
   vcmGetFormPath(aForm, l_Path);
   l_IsMainContainer := Supports(aForm, IafwMainFormContainer);
   if ((aForm Is TvcmMainForm) AND (aForm.Parent = nil)) OR l_IsMainContainer then
   begin
    l_NeedSave := true;
   end
   else
   begin
    l_NeedSave := (TvcmEntityForm(aForm).ZoneType in vcm_NotContainedForm);
    if not l_NeedSave then
    begin
     // - это встроенная форма - надо записать позицию ее дока
     l_PForm := nil;
     l_Saved := false;
     l_Floating := false;
     l_Parent := aForm.Parent;
     while (l_Parent <> nil) do
     begin
      if (l_Parent.Name <> '') then
      begin
       if not l_Saved then
       begin
        l_Saved := true;
        vcmCatPath(l_Path, cZone, l_PPath);
        vcmSaveStrParamS(l_PPath, vcmCStr(l_Parent.Name));
       end;//not l_Saved
      end;//l_Parent.Name <> ''
      if (l_Parent.Parent = nil) then
      begin
       if (not l_Saved AND not (l_Parent Is TvcmMainForm)) then
       begin
        l_Floating := l_Floating OR true;
        if (l_PForm = nil) AND (l_Parent Is TCustomForm) then
         l_PForm := TCustomForm(l_Parent);
       end;//(not l_Saved AND not (l_Parent Is TvcmMainForm))
       if (l_Parent.Owner Is TControl) then
        l_Parent := TControl(l_Parent.Owner)
       else
        l_Parent := nil;
      end//l_Parent.Parent = nil
      else
       l_Parent := l_Parent.Parent;
     end;//while (l_Parent <> nil)
     vcmCatPath(l_Path, cToolbarFloat, l_PPath);
     vcmSaveBoolParamS(l_PPath, l_Floating);
     if (aForm is TvcmEntityForm) then
     begin
      { Идентификатор плавающей формы }
      if (TvcmEntityForm(aForm).FloatID > 0) then
      begin
       vcmCatPath(l_Path, cFloatWindowID, l_PPath);
       vcmSaveIntParam(l_PPath, TvcmEntityForm(aForm).FloatID);
      end;
      { Состояние плавающей формы }
      vcmCatPath(l_Path, cFloatWindowState, l_PPath);
      vcmSaveIntParam(l_PPath, TvcmEntityForm(aForm).FloatWindowState);
      vcmCatPath(l_Path, cFloatingVisible, l_PPath);
      vcmSaveBoolParam(l_PPath, TvcmEntityForm(aForm).FloatingVisible);
      { Расположение плавающей формы, в которой находилась форма }
      vcmSaveFloatBounds(l_Path, TvcmEntityForm(aForm).FloatWindowBounds);
     end;
     if l_Floating then
     begin
      if (l_PForm = nil) then
       l_PForm := aForm;
      vcmSaveLayout(l_Path, l_PForm);
     end;//l_Floating
    end;//not l_NeedSave
   end;//aForm Is TvcmMainForm
   if l_NeedSave then
    vcmSaveLayout(l_Path, aForm);
   if (aForm Is TvcmContainerForm) then
    vcmSaveFormControls(l_Path, TvcmContainerForm(aForm));
  end;//aForm Is TvcmEntityForm
end;

function vcmLoadFormParams(anOwner       : TObject;
                           aForm         : TCustomForm;
                           out theParams : TvcmFormParams): Boolean;
  {-}
var
 l_OPath : TvcmPathPairs;
 l_FPath : TvcmPathPairs;
 l_LPath : TvcmPathPairs;
begin
 if (anOwner Is TCustomForm) then
  vcmGetFormPath(TForm(anOwner), l_OPath);
 vcmGetFormPath(aForm, l_FPath, false);
 vcmCatPath(l_OPath, l_FPath, l_LPath);
 l_FPath := l_LPath;
 vcmCatPath(l_FPath, cZone, l_LPath);
 Result := vcmLoadStrParam(l_LPath, theParams.rParent);
 if Result then
 begin
  vcmCatPath(l_FPath, cToolbarFloat, l_LPath);
  if not vcmLoadBoolParam(l_LPath, theParams.rFloating) then
   theParams.rFloating := False;
  vcmCatPath(l_FPath, cFloatingVisible, l_LPath);
  if not vcmLoadBoolParam(l_LPath, theParams.rFloatingVisible) then
   theParams.rFloatingVisible := true;
  { Идентификатор плавающего навигатора }
  vcmCatPath(l_FPath, cFloatWindowID, l_LPath);
  vcmLoadIntParam(l_LPath, theParams.rFloatID);
  { Состояние плавающего окна }
  vcmCatPath(l_FPath, cFloatWindowState, l_LPath);
  vcmLoadIntParam(l_LPath, theParams.rFloatWindowState);
  { Положение плавающего окна }
  vcmLoadFloatBounds(l_FPath, theParams.rFloatWindowBounds);
 end;//Result
end;

procedure vcmCleanToolbar(const aUTName    : AnsiString;
                          const aTBName    : AnsiString);
begin
 vcmSaveBoolParamS([
                       vcmPathPair(aUtName),
                       cToolbars,
                       vcmPathPair(aTbName),
                       cDefaultOperations
                      ],
                      true);
 vcmSaveBoolParamS([
                       vcmPathPair(aUtName),
                       cToolbars,
                       vcmPathPair(aTbName),
                       cDefaultPositions
                      ],
                      true);
end;

procedure vcmCleanShortcut(const aOpContName : AnsiString;
                           const aOpName     : AnsiString);
begin
 vcmSaveBoolParamS([
                    cShortcuts,
                    vcmPathPair(aOpContName),
                    vcmPathPair(aOpName),
                    cDefaultShortcut
                    ],
                    true);
end;

end.
