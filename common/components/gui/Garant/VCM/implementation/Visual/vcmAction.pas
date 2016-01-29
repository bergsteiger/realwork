unit vcmAction;
{* Базовая операция библиотеки vcm для привязки к меню. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmAction -     }
{ Начат: 25.02.2003 19:52 }
{ $Id: vcmAction.pas,v 1.127 2015/06/03 12:26:29 lulin Exp $ }

// $Log: vcmAction.pas,v $
// Revision 1.127  2015/06/03 12:26:29  lulin
// - пытаемся разрулить зависимости.
//
// Revision 1.126  2015/01/15 14:03:28  lulin
// {RequestLink:585926571}. Используем Interlocked.
//
// Revision 1.125  2014/02/18 10:01:29  lulin
// - для несортируемых списков убираем возможность поставить флаг сортировки.
//
// Revision 1.124  2013/05/16 13:53:25  lulin
// - ищем странную ошибку в пачке тестов - http://mdp.garant.ru/pages/viewpage.action?pageId=454531065&focusedCommentId=454534395#comment-454534395.
//
// Revision 1.123  2013/05/16 13:51:08  lulin
// - ищем странную ошибку в пачке тестов - http://mdp.garant.ru/pages/viewpage.action?pageId=454531065&focusedCommentId=454534395#comment-454534395.
//
// Revision 1.122  2013/04/05 12:02:41  lulin
// - портируем.
//
// Revision 1.121  2012/04/11 15:29:02  lulin
// - пытаемся разобраться с "галочками".
//
// Revision 1.120  2012/04/11 13:09:20  kostitsin
// [$357337109]
//
// Revision 1.119  2011/12/07 17:48:20  lulin
// {RequestLink:273590436}
//
// Revision 1.118  2009/11/06 13:06:23  lulin
// - избавился от ручной передачи параметров через поле Data.
//
// Revision 1.117  2009/10/16 17:00:46  lulin
// {RequestLink:159360578}. №52.
//
// Revision 1.116  2009/10/16 15:14:30  lulin
// {RequestLink:159360578}. №52.
//
// Revision 1.115  2009/10/14 13:24:16  lulin
// - чистка кода.
//
// Revision 1.114  2009/10/05 06:46:09  lulin
// {RequestLink:159360578}. №51.
//
// Revision 1.113  2009/02/20 17:29:21  lulin
// - чистка комментариев.
//
// Revision 1.112  2008/08/11 11:28:43  lulin
// - <K>: 107839863.
//
// Revision 1.111  2008/04/02 14:22:15  lulin
// - cleanup.
//
// Revision 1.110  2008/03/19 14:23:47  lulin
// - cleanup.
//
// Revision 1.109  2008/02/14 19:32:33  lulin
// - изменены имена файлов с примесями.
//
// Revision 1.108  2008/02/14 14:12:17  lulin
// - <K>: 83920106.
//
// Revision 1.107  2008/02/07 08:37:46  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.106  2008/01/25 12:06:52  lulin
// - синхронизируем имена с моделью.
//
// Revision 1.105  2008/01/25 11:32:07  lulin
// - синхронизируем имена с моделью.
//
// Revision 1.104  2007/12/20 08:35:23  lulin
// - подгоняем интерфейсы под модель.
//
// Revision 1.103  2007/09/26 06:18:09  mmorozov
// - change: вместо использования TvcmAction используем IvcmAction + правки ошибок при переходе на использование _SelectedString вместо Caption (в рамках работы над CQ: OIT5-26741 + K<50758978>);
//
// Revision 1.102  2007/09/25 03:55:32  mmorozov
// - new behaviour: для чтения\изменения текущего выбранного значения для операций типа vcm_otDate, vcm_otCombo, vcm_otEditCombo используем свойство параметров _SelectedString, раньше Caption. Тем самым Caption для этих типов операций стал изменяемым (в рамках работы CQ: OIT5-26741);
//
// Revision 1.101  2007/08/13 17:23:32  lulin
// - cleanup.
//
// Revision 1.100  2007/08/08 13:26:04  lulin
// - были недоступны пункты меню (<K>-34505100).
//
// Revision 1.99  2007/07/10 12:40:12  lulin
// - теперь если у формы в фокусе нет операции, то транслируем операцию форме в Parent-зоне (CQ-25867, <K>-29392957).
//
// Revision 1.98  2007/06/28 14:56:16  lulin
// - cleanup.
//
// Revision 1.97  2007/04/26 11:43:09  oman
// - fix: Жирность в пункте меню теперь делается не типом операции
//  vcm_otLabel, а флагом vcm_ofDefault (cq24612)
//
// Revision 1.96  2007/04/13 11:46:55  lulin
// - не делаем лишние телодвижения.
//
// Revision 1.95  2007/04/13 11:42:18  lulin
// - не переприсваиваем оригинальную строку.
//
// Revision 1.94  2007/04/13 11:35:24  lulin
// - bug fix: не освобождались ресурсы.
//
// Revision 1.93  2007/04/13 10:54:16  oman
// - fix: При перкрытии свойств Caption и Hint не учитывали, что
//  унаследованные свойства могут изменить без нашего ведома -
//  починяем синхронизацию (cq25036)
//
// Revision 1.92  2007/04/12 08:11:53  lulin
// - используем строки с кодировкой.
//
// Revision 1.91  2007/04/11 13:31:06  lulin
// - используем строки с кодировкой.
//
// Revision 1.90  2007/04/11 12:04:29  lulin
// - для заголовка экшена используем строки с кодировкой.
//
// Revision 1.89  2007/04/11 10:07:11  lulin
// - cleanup.
//
// Revision 1.88  2007/02/13 13:28:26  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.87  2007/02/13 12:09:03  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.86  2007/01/22 15:30:12  lulin
// - избавляемся от нефиксированных параметров при выполнении пользовательской операции.
//
// Revision 1.85  2007/01/20 15:31:10  lulin
// - разделяем параметры операции для выполнения и для тестирования.
//
// Revision 1.84  2007/01/18 13:24:44  lulin
// - разводим в стороны параметры для теста и для выполнения.
//
// Revision 1.83  2007/01/18 13:13:46  lulin
// - разводим в стороны параметры для теста и для выполнения.
//
// Revision 1.82  2007/01/18 10:49:35  lulin
// - заменяем объект менеджера памяти на интерфейс.
//
// Revision 1.81  2007/01/18 09:06:53  lulin
// - с общих параметров убраны тестовые опции.
//
// Revision 1.80  2007/01/17 14:02:47  lulin
// - вычищены последние нефиксированные параметры в тестах операций.
//
// Revision 1.79  2007/01/17 12:27:32  lulin
// - избавляемся от нефиксированного параметра - расширенной подсказки операции.
//
// Revision 1.78  2007/01/16 14:27:32  lulin
// - избавляемся от нефиксированного параметра - подсказки операции.
//
// Revision 1.77  2007/01/16 14:13:14  lulin
// - избавляемся от нефиксированного параметра - заголовка операции.
//
// Revision 1.76  2007/01/16 13:47:33  lulin
// - избавляемся от нефиксированного параметра - горячей клавиши.
//
// Revision 1.75  2007/01/16 12:06:39  lulin
// - избавляемся от нефиксированного параметра - индекс картинки.
//
// Revision 1.74  2007/01/16 08:51:10  lulin
// - избавляемся от нефиксированного параметра - текущая нода.
//
// Revision 1.73  2007/01/15 18:33:03  lulin
// - избавляемся от нефиксированного параметра - показывать корень или нет.
//
// Revision 1.72  2007/01/15 17:54:27  lulin
// - избавляемся от нефиксированного параметра.
//
// Revision 1.71  2007/01/15 17:25:40  lulin
// - cleanup.
//
// Revision 1.70  2007/01/15 14:56:51  lulin
// - при построении меню используем операции модуля из списка строк.
//
// Revision 1.69  2007/01/15 12:59:25  lulin
// - цвет фона теперь берем из шрифта.
//
// Revision 1.68  2007/01/15 12:47:28  lulin
// - теперь шрифт создаем только по требованию - когда его реально хотят заполнить.
//
// Revision 1.67  2007/01/11 13:23:48  lulin
// - cleanup.
//
// Revision 1.66  2007/01/11 12:52:18  lulin
// - теперь список нод создаем только по требованию - когда его реально хотят заполнить.
//
// Revision 1.65  2007/01/11 11:15:08  lulin
// - вводим "родные" ноды.
//
// Revision 1.64  2007/01/10 18:00:31  lulin
// - cleanup.
//
// Revision 1.63  2007/01/10 17:27:43  lulin
// - теперь список строк создаем только по требованию - когда его реально хотят заполнить.
//
// Revision 1.62  2007/01/10 16:12:42  lulin
// - cleanup.
//
// Revision 1.61  2007/01/10 16:03:51  lulin
// - cleanup.
//
// Revision 1.60  2007/01/10 15:56:02  lulin
// - cleanup.
//
// Revision 1.59  2007/01/10 15:40:09  lulin
// - cleanup.
//
// Revision 1.58  2007/01/10 14:19:48  lulin
// - вычищена ненужная функциональность.
//
// Revision 1.57  2007/01/10 13:58:46  lulin
// - от параметра по индексу переходим к свойству в параметрах операции.
//
// Revision 1.56  2007/01/10 12:22:31  lulin
// - прячем поле.
//
// Revision 1.55  2007/01/10 11:57:53  lulin
// - cleanup.
//
// Revision 1.54  2007/01/05 11:35:27  lulin
// - убран вредный параметр операции.
//
// Revision 1.53  2006/12/10 18:32:23  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.52  2006/12/08 14:21:04  lulin
// - очищаем кешированные компоненты так, как будто они заново родились.
//
// Revision 1.51  2006/12/05 12:29:52  lulin
// - создаем свой, "более умный" шрифт.
//
// Revision 1.50  2006/09/21 13:06:31  mmorozov
// - new behaviour: в нотификации о выполнении операции подается выполняемая операция в виде IvcmOperationDef;
//
// Revision 1.49  2006/09/20 14:59:14  mmorozov
// - new: событие выполения операции пользователем (в рамках работы журнал работы пользователя);
//
// Revision 1.48  2006/04/24 11:29:28  oman
// - fix: при совпадении _Hint и _LongHint переставали обновлятся хинты у контролов
//
// Revision 1.47  2006/04/14 13:40:24  lulin
// - запрещаем перекрывать деструктор.
//
// Revision 1.46  2006/04/14 12:11:19  lulin
// - файлу с шаблоном дано более правильное название.
//
// Revision 1.45  2006/04/14 11:53:08  lulin
// - объединил интерфейс и реализацию _Unknown_ в один файл.
//
// Revision 1.44  2006/03/31 07:41:49  lulin
// - изменен тип параметров, подаваемый в Execte операции.
//
// Revision 1.43  2006/03/06 12:03:12  oman
// - new behavior: указание "правильного" провисания ресурсов при добавлении объектов в кэш
//
// Revision 1.42  2005/10/14 10:30:03  lulin
// - bug fix: был AV при прерывании построения _Preview (CQ OIT5-16964).
//
// Revision 1.41  2005/09/29 10:54:53  mmorozov
// new: блокировка Action.Update;
//
// Revision 1.40  2004/11/05 14:49:19  lulin
// - bug fix: выставляем шрифту русскую локаль.
//
// Revision 1.39  2004/11/02 16:50:07  am
// change: перед покладанием TvcmAction в кэш выставляем Font.Color в дефолтное значение (clWindowText)
//
// Revision 1.38  2004/10/12 10:28:02  am
// change: Use\Free в LockUpdate\UnlockUpdate
//
// Revision 1.37  2004/10/05 11:41:51  lulin
// - bug fix: при вызове операции, однажды запрещенной не вызывался OnTest и поэтому она больше не вызывалась, через метод _Operation, а не из контрола (CQ OIT5-9844).
//
// Revision 1.36  2004/09/22 14:56:49  lulin
// - bug fix: не очищался список нод.
//
// Revision 1.35  2004/09/22 14:54:34  lulin
// - bug fix: не очищались списки строк.
//
// Revision 1.34  2004/09/17 11:23:01  lulin
// - параметр vcm_opStrings переименован в _vcm_opItems, и ему изменен тип с _IvcmHolder на _IvcmStrings (!).
//
// Revision 1.33  2004/09/15 13:58:03  lulin
// - new unit: _vcmStringList.
//
// Revision 1.32  2004/09/15 13:35:56  lulin
// - при попадании в кеш не очищаем f_Font, f_SubNodes, f_Strings, f_OldStrings.
//
// Revision 1.31  2004/09/15 13:29:05  lulin
// - TvcmAction и TvcmWinControlActionLink переведен на "шаблон" l3Unknown.
//
// Revision 1.30  2004/09/13 10:19:45  lulin
// - оптимизация не распределяем заранее f_OldStrings.
//
// Revision 1.29  2004/09/11 12:01:52  lulin
// - cleanup: избавляемся от прямого использования деструкторов.
//
// Revision 1.28  2004/09/08 12:49:47  lulin
// - bug fix: убран ненужный и крайне вредный код.
//
// Revision 1.27  2004/09/08 11:22:46  lulin
// - new define: _l3NoTrace.
// - new define: l3TraceObjects.
//
// Revision 1.26  2004/07/19 11:03:10  law
// - сделал "прореживание" дерганий OnTest (CQ OIT5-6989).
//
// Revision 1.25  2004/06/02 10:20:50  law
// - удален конструктор Tl3VList.MakeIUnknown - пользуйтесь _Tl3InterfaceList.Make.
//
// Revision 1.24  2004/04/20 15:57:24  mmorozov
// new: property TvcmAction.CurrentItem;
//
// Revision 1.23  2004/04/19 15:52:50  mmorozov
// new: field TvcmAction.f_OldStrings - значение f_Strings до изменений;
// new: method TvcmAction.IsStringsChange;
// new: method TvcmAction.SaveStrings;
// new behaviour: _Strings создаются в конструкторе TvcmAction;
//
// Revision 1.22  2004/04/09 12:12:44  law
// - new behavior: прикручен контроль за TvcmWinControlActionLink.
//
// Revision 1.21  2004/04/08 19:58:13  law
// - new behavior: прикручен контроль за TvcmAction.
//
// Revision 1.20  2004/02/13 14:04:18  law
// - new behavior: операции типа vcm_otCombo умеют попадать в меню.
//
// Revision 1.19  2004/01/15 10:55:54  am
// change: DoExecute. На время выполнения операции иконка курсора заменяется на crHourGlass
//
// Revision 1.18  2004/01/14 11:46:33  law
// - new const: _vcm_opBackColor, _vcm_opFont.
//
// Revision 1.17  2004/01/09 12:20:38  law
// - bug fix: Для операций типа vcm_otTyper при создании формы сразу вызывается OnExecute - а это не правильно (CQ OIT5-5803).
//
// Revision 1.16  2003/12/30 13:51:50  law
// - new interface: IvcmAction.
//
// Revision 1.15  2003/12/30 13:41:56  law
// - bug fix: не переобновляем Action'ы Popup-Menu привязанного к кнопке, когда это меню открыто.
//
// Revision 1.14  2003/12/26 16:51:20  law
// - new behavior: переделана логика обработки BottonCombo - теперь если меню нету, то и стрелки вниз нету.
// - bug fix: иногда при восстановлении из истории портился _Caption главного окна.
//
// Revision 1.13  2003/12/11 17:59:13  law
// - new const: _vcm_opPlainLevel.
// - new behavior: строим меню "отбитое пробелами (как в Гаранте)" начиная с уровня вложенности _vcm_opPlainLevel (CQ OIT5-5467).
//
// Revision 1.12  2003/12/09 16:12:50  law
// - new _operation param: _vcm_opShowRoot.
//
// Revision 1.11  2003/12/09 15:45:53  law
// - bug fix: в OnTest не подавалась корректная CurrentNode.
//
// Revision 1.10  2003/12/09 14:22:28  law
// - new class: TvcmWinControlActionLink.
//
// Revision 1.9  2003/11/17 13:36:43  law
// - new const: _vcm_opSubNodes - список дочерних элементов, пока не обрабатывается, но уже можно заполнять.
//
// Revision 1.8  2003/07/25 10:06:00  law
// - new method: TvcmAction.EQ.
//
// Revision 1.7  2003/04/25 16:34:47  law
// - cleanup: _IvcmParams._Dispatcher - теперь Read-Only.
//
// Revision 1.6  2003/04/09 15:52:35  law
// - new _operation type: vcm_otDate.
//
// Revision 1.5  2003/04/09 14:51:34  law
// - new behavior: сделал обработку списка строк у ComboBox'а.
//
// Revision 1.4  2003/04/09 13:08:14  law
// - new behavior: в нулевом приближении сделал обработку операции с типом vcm_otCombo.
//
// Revision 1.3  2003/04/08 08:39:33  law
// - new const: _vcm_opCaption - еще один параметр операции - Название.
//
// Revision 1.2  2003/04/03 15:43:55  law
// - change: из TvcmMainForm выделил класс TvcmDispatcher.
//
// Revision 1.1  2003/04/01 12:54:49  law
// - переименовываем MVC в VCM.
//
// Revision 1.12  2003/03/27 14:36:54  law
// - new prop: операция теперь имеет картинку.
//
// Revision 1.11  2003/03/27 12:41:30  law
// - обновил модель.
//
// Revision 1.10  2003/03/26 14:58:06  law
// - change: добавляем ActionList по умолчанию для всей библиотеки.
//
// Revision 1.9  2003/03/25 10:34:26  law
// - new prop: TvcmOperationsCollectionItem.ShortCut.
//
// Revision 1.8  2003/03/25 09:56:55  law
// - new prop: TvcmOperationsCollectionItem._Hint, TvcmOperationsCollectionItem._LongHint.
//
// Revision 1.7  2003/03/24 16:26:04  law
// - cleanup.
//
// Revision 1.6  2003/03/24 14:04:07  law
// - change: продолжаем заковыривать все относящееся к операции в _IvcmParams.
//
// Revision 1.5  2003/03/24 13:25:48  law
// - change: продолжаем заковыривать все относящееся к операции в _IvcmParams.
//
// Revision 1.4  2003/03/21 18:30:47  law
// - change: делаем шаги к заковыриванию всего относящегося к операции в _IvcmParams.
//
// Revision 1.3  2003/02/27 10:59:50  law
// - comments: xHelpGen.
//
// Revision 1.2  2003/02/26 16:22:43  law
// - new behavior: сделана обработка операция и создание форм.
//
// Revision 1.1  2003/02/25 17:59:46  law
// - new behavior: начал писать обвязку для выполнения операций модуля.
//

{$Include vcmDefine.inc }

interface

{$If not defined(NoVCM)}
uses
  Windows,
  
  Classes,

  ActnList,

  Graphics,

  vcmInterfaces,
  vcmExternalInterfaces,
  vcmBase,
  vcmStringList
  ;

type
  TvcmAction = class;

  _l3Unknown_Parent_ = TCustomAction;
  {$Define _UnknownIsBaseComponent}
  {$IfNDef vcmNeedL3}
   {$Define _UnknownNotNeedL3}
  {$EndIf  vcmNeedL3}
  {$Include l3Unknown.imp.pas}
  TvcmAction = class(_l3Unknown_, IvcmAction)
   {* Базовая операция библиотеки vcm для привязки к меню. }
    private
    // internal fields
      f_LockUpdate        : Integer;
      f_LockExecute       : Integer;
      f_OldStrings        : IvcmStrings;
        {* - сохраняем значение f_Strings, чтобы определить изменились ли оно. }
      f_Strings           : IvcmItems;
      f_SubNodes          : IvcmNodes;
      f_Font              : IvcmFont;
      f_Caption           : IvcmCString;
      f_Hint              : IvcmCString;
      f_ChangeCount       : Integer;
      f_IsDefault         : Boolean;
      f_SelectedString    : IvcmCString;
      f_OldSelectedString : IvcmCString;
    private
    // IvcmAction
      function pm_GetSelectedString: IvcmCString;
      procedure pm_SetSelectedString(const aValue: IvcmCString);
        {-}
      function pm_GetIsDefault: Boolean;
      procedure pm_SetIsDefault(aValue: Boolean);
        {-}
      function pm_GetSubItems: IvcmItems;
        {-}
      function pm_GetSubNodes: IvcmNodes;
        {-}
      function pm_GetFont: IvcmFont;
        {-}
      function pm_GetCaption: IvcmCString;
      procedure pm_SetCaption(const aValue: IvcmCString);
        {-}
      function pm_GetHint: IvcmCString;
      procedure pm_SetHint(const aValue: IvcmCString);
        {-}
      function pm_GetIsSelectedStringChanged: Boolean;
        {* - изменилась ли выбранное значение. }
      function pm_GetIsStringsChanged : Boolean;
        {* - проверяет изменилось значение строк. }
      function IsUpdateLocked: Boolean;
        {-}
      procedure LockUpdate;
        {-}
      procedure UnlockUpdate;
        {-}
      function IsExecuteLocked: Boolean;
        {-}
      procedure LockExecute;
        {-}
      procedure UnlockExecute;
        {-}
      function  HasInfoForCombo: Boolean;
        {-}
      procedure SaveStrings;
        {* - сохраняет текущее значение строк. }
      procedure IvcmAction_Execute;
      procedure IvcmAction.Execute = IvcmAction_Execute;
        {* - выполнить действие. }
    protected
    // property methods
      function  pm_GetDispatcher: IvcmDispatcher;
        {-}
    protected
    // internal methods
      {$IfDef l3CheckUnfreedResources}
      function CheckUnfreedResource(aPtrToResource: Pointer): Boolean;
       override;
      {$EndIf l3CheckUnfreedResources}
      procedure DoExecute(Sender: TObject);
        overload;
        {* - реализация операции. }
      procedure DoExecute;
        overload;
        virtual;
        {* - реализация операции. Для перекрытия в потомках. }
      function  DoMakeExecuteParams : IvcmExecuteParams;
        virtual;
        {-}
      function  MakeExecuteParams : IvcmExecuteParams;
        {-}
      procedure SetParams(const aParams: IvcmTestParams);
        {-}
      procedure DoUpdate;
        virtual;
        {-}
      class function IsCacheable: Boolean;
        override;
        {-}
      procedure Release;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
      procedure BeforeAddToCache;
        override;
        {-}
      procedure CallDestroy;
        override;
        {-}
      function CalcOperationHint(const aHint, aLongHint: IvcmCString): IvcmCString;
        {-}
      procedure Change;
       override;
        {* - Поскольку перекрыли Caption и Hint нужно обновлять их в обратную сторону }
    protected
    // properties
      property SelectedString: IvcmCString
        read pm_GetSelectedString
        write pm_SetSelectedString;
        {* - содержит выбранное при выполнении действия значение. }
      property OldSelectedString: IvcmCString
        read f_OldSelectedString
        write f_OldSelectedString;
        {* - значение свойства до вызова SetParams, необходимо для отслеживания
             изменения выбранного значения. }
      property SubItems: IvcmItems
        read pm_GetSubItems;
        {-}
      property SubNodes: IvcmNodes
        read pm_GetSubNodes;
        {-}
      property Font: IvcmFont
        read pm_GetFont;
        {-}
      property IsDefault: Boolean
        read pm_GetIsDefault
        write pm_SetIsDefault;
        {-}
      property Caption: IvcmCString
        read pm_GetCaption
        write pm_SetCaption;
        {-}
      property Hint: IvcmCString
        read pm_GetHint
        write pm_SetHint;
        {-}
    public
    // public methods
      constructor Create(anOwner: TComponent);
        override;
        {-}
      function  Update: Boolean;
        override;
        {-}
      function  EQ(anAction: TvcmAction): Boolean;
        virtual;
        {-}
      function  MakeTestParams: IvcmTestParams;
        virtual;
        {-}
    public
    // public properties
      property Dispatcher: IvcmDispatcher
        read pm_GetDispatcher;
        {* - диспетчер приложения. }
  end;//TvcmAction

function  vcmGetActionList: TCustomActionList;
  {-}
procedure vcmSetActionList(aValue: TCustomActionList);
  {-}
{$IfEnd}  

implementation

{$If not defined(NoVCM)}
uses
  SysUtils,

  ImgList,
  Controls,
  Forms

  {$IfDef vcmNeedL3}
  ,
  l3Base,
  l3Interfaces,
  l3String,
  l3Interlocked
  {$EndIf vcmNeedL3}
  ;

var
 g_ActionList : TCustomActionList = nil;

function vcmGetActionList: TCustomActionList;
  {-}
begin
 if (g_ActionList = nil) then
  g_ActionList := TCustomActionList.Create(Application);
 Result := g_ActionList;
end;

procedure vcmSetActionList(aValue: TCustomActionList);
  {-}
begin
 g_ActionList := aValue;
end;

{$Include l3Unknown.imp.pas}

// start class TvcmAction

constructor TvcmAction.Create(anOwner: TComponent);
  //override;
  {-}
begin
 inherited;
 ActionList := vcmGetActionList;
 OnExecute := DoExecute;
end;

procedure TvcmAction.Cleanup;
  //virtual;
  {-}
begin
 f_OldSelectedString := nil;
 f_SelectedString := nil;
 f_LockUpdate := 0;
 f_LockExecute := 0;
 Caption := nil;
 Hint := nil;
 inherited;
end;

procedure TvcmAction.Release;
  //override;
  {-}
begin
 f_Font := nil;
 f_SubNodes := nil;
 f_Strings := nil;
 f_OldStrings := nil;
 inherited;
end;

procedure TvcmAction.BeforeAddToCache;
  //override;
  {-}
begin
 if (f_Strings <> nil) then
  f_Strings.Clear;
 if (f_OldStrings <> nil) then
  f_OldStrings.Clear;
 if (f_SubNodes <> nil) then
  f_SubNodes.Clear; 
 if (f_Font <> nil) then
 begin
  f_Font.ForeColor := clWindowText;
  f_Font.BackColor := clDefault;
 end;//f_Font <> nil
 try
  inherited;
 finally
  ActionComponent := nil;
 end;//try..finally 
end;

procedure TvcmAction.CallDestroy;
  //override;
  {-}
begin
 {$IfDef l3HackedVCL}
 if (FClients <> nil) then
  // - обходим неаккуратность стандартного деструктора
  try
   inherited;
  except
  // http://mdp.garant.ru/pages/viewpage.action?pageId=454531065&focusedCommentId=454534395#comment-454534395
   try
    FClients := nil;
    l3System.Msg2Log('CallDestroy fail - http://mdp.garant.ru/pages/viewpage.action?pageId=454531065&focusedCommentId=454534395#comment-454534395');
    l3System.Msg2Log(ClassName);
    l3System.Msg2Log(Name);
    l3System.Msg2Log(l3Str(Caption));
   except
    l3System.Msg2Log('Write params fail');
   end;//try..except
  end;//try..except
 {$Else  l3HackedVCL}
 inherited;
 {$EndIf l3HackedVCL}
end;
  
class function TvcmAction.IsCacheable: Boolean;
  //override;
  {-}
begin
 Result := true;
end;

{$IfDef l3CheckUnfreedResources}
function TvcmAction.CheckUnfreedResource(aPtrToResource: Pointer): Boolean;
begin
 Result := (aPtrToResource = @f_OldStrings) or
           (aPtrToResource = @f_Strings) or
           (aPtrToResource = @f_SubNodes) or
           (aPtrToResource = @f_Font) or
           Inherited CheckUnfreedResource(aPtrToResource);
end;
{$EndIf l3CheckUnfreedResources}

procedure TvcmAction.DoExecute(Sender: TObject);
  {-}
var
  l_Cursor : TCursor;
begin
 if not IsExecuteLocked then
 begin
  l_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
   DoExecute;
  finally
   Screen.Cursor := l_Cursor;
  end;//try..finally                                
 end;//not IsExecuteLocked
end;

procedure TvcmAction.DoExecute;
  //virtual;
  {-}
begin
end;

function TvcmAction.pm_GetDispatcher: IvcmDispatcher;
  {-}
begin
 Result := vcmDispatcher;
end;

procedure TvcmAction.pm_SetCaption(const aValue: IvcmCString);
  {-}
begin
 if not vcmSame(f_Caption, aValue) then
 begin
  Inc(f_ChangeCount);
  try
   inherited Caption := vcmStr(aValue);
  except
   // http://mdp.garant.ru/pages/viewpage.action?pageId=107839863&focusedCommentId=107839973#comment-107839973
  end;
  Dec(f_ChangeCount);
 end;//not vcmSame(f_Caption, aValue)
 f_Caption := aValue;
end;

procedure TvcmAction.pm_SetHint(const aValue: IvcmCString);
  {-}
begin
 if not vcmSame(f_Hint, aValue) then
 begin
  Inc(f_ChangeCount);
  try
   inherited Hint := vcmStr(aValue);
  except
   // http://mdp.garant.ru/pages/viewpage.action?pageId=107839863&focusedCommentId=107839973#comment-107839973
  end;
  Dec(f_ChangeCount);
 end;//not vcmSame(f_Hint, aValue)
 f_Hint := aValue;
end;

function TvcmAction.DoMakeExecuteParams : IvcmExecuteParams;
  {-}
begin
 Result := TvcmExecuteParams.Make;
 Result.ItemIndex := -1;
end;

function TvcmAction.MakeExecuteParams : IvcmExecuteParams;
  {-}
begin
 Result := DoMakeExecuteParams;
end;

function TvcmAction.MakeTestParams: IvcmTestParams;
  {-}
var
 l_Hint  : IvcmCString;
 l_DPos  : Integer;
 l_Index : Integer;
 l_AL    : IvcmActionLink;
begin
 l_Index := 0;
 while (l_Index < {$IfDef XE}ClientCount{$Else}FClients.Count{$EndIf}) do
 begin
  if Supports(TBasicActionLink({$IfDef XE}Clients{$Else}FClients{$EndIf}[l_Index]), IvcmActionLink, l_AL) then
   try
    l_AL.ParamsChanging(Self);
   finally
    l_AL := nil;
   end;//try..finally
  Inc(l_Index); 
 end;//l_Index < FClients.Count
 Result := TvcmTestParams.Make;
 Result.Op.Flag[vcm_ofEnabled] := true;
 Result.Op.Flag[vcm_ofVisible] := true;
 Result.Op.Flag[vcm_ofChecked] := false;
 Result.Op.Flag[vcm_ofDefault] := IsDefault;
 l_Hint := Hint;
 l_DPos := Pos('|', vcmStr(l_Hint));
 if (l_DPos = 0) then
 begin
  Result.Op.Hint := l_Hint;
  Result.Op.LongHint := l_Hint;
 end//l_DPos = 0
 else
 begin
  Result.Op.Hint := vcmCopy(l_Hint, 0, Pred(l_DPos));
  Result.Op.LongHint := vcmCopy(l_Hint, l_DPos, vcmLen(l_Hint) - l_DPos);
 end;//l_DPos = 0
 Result.Op.Caption := Caption; 
 Result.Op.ImageIndex := Integer(ImageIndex);
 Result.Op.ShortCut := Integer(ShortCut);
 Result.Op.SubItems := f_Strings;
 Result.Op.SubNodes := f_SubNodes;
 Result.Op.SelectedString := SelectedString;
end;//MakeTestParams

procedure TvcmAction.SetParams(const aParams: IvcmTestParams);
  {-}
var
 l_Index : Integer;
 l_AL    : IvcmActionLink;
begin
 if (aParams.DoneStatus in [vcm_dsNoEntity, vcm_dsExcludedInUserType, vcm_dsDone]) then
 begin
  if ({$IfDef XE}ClientCount > 0{$Else}FClients <> nil{$EndIf}) then
  begin
   with aParams.Op do
   begin
    if HasSubItems then
     f_Strings := SubItems
    else
     if (f_Strings <> nil) then
      f_Strings.Clear;
    if HasSubNodes then
     f_SubNodes := SubNodes
    else
     if (f_SubNodes <> nil) then
      f_SubNodes.Clear;
    if HasFont then
     f_Font := Font
    else
     if (f_Font <> nil) then
      f_Font := nil;
    if not Dispatcher.FormDispatcher.Locked then
    begin
     Enabled := Flag[vcm_ofEnabled];
     Visible := Flag[vcm_ofVisible];
    end;
    Checked := Flag[vcm_ofChecked];
    IsDefault := Flag[vcm_ofDefault];
   end;//with aParams.Op
   Hint := CalcOperationHint(aParams.Op.Hint, aParams.Op.LongHint);
   ShortCut := TShortCut(aParams.Op.ShortCut);
   ImageIndex := TImageIndex(aParams.Op.ImageIndex);
   if not Dispatcher.FormDispatcher.Locked then
    Caption := aParams.Op.Caption;
   SelectedString := aParams.Op.SelectedString;
   l_Index := 0;
   while (l_Index < {$IfDef XE}ClientCount{$Else}FClients.Count{$EndIf}) do
   begin
    if Supports(TBasicActionLink({$IfDef XE}Clients{$Else}FClients{$EndIf}[l_Index]), IvcmActionLink, l_AL) then
     try
      l_AL.ParamsChanged(Self);
     finally
      l_AL := nil;
     end;//try..finally
    Inc(l_Index);
   end;//while (l_Index < FClients.Count)
   OldSelectedString := SelectedString;
  end;//FClients <> nil
 end;//aParams.DoneStatus in ..
end;

procedure TvcmAction.DoUpdate;
  //virtual;
  {-}
begin
end;

function TvcmAction.Update: Boolean;
  //override;
  {-}
begin
 //inherited Update;
 // - это убрано, потому, что вызывает крайне неэффективный код, да и все равно это нафиг для VCM не нужно.
 if ({$IfDef XE}ClientCount = 0{$Else}FClients = nil{$EndIf}) then
  Result := false
 else
 begin
  Result := true;
  if not g_Dispatcher.IsLockActionUpdate and not IsUpdateLocked then
   DoUpdate;
 end;//FClients = nil
end;

function TvcmAction.EQ(anAction: TvcmAction): Boolean;
  //virtual;
  {-}
begin
 Result := (Self = anAction);
end;

function TvcmAction.IsUpdateLocked: Boolean;
  {-}
begin
 Result := (f_LockUpdate > 0);
end;

procedure TvcmAction.LockUpdate;
  {-}
begin
 Inc(f_LockUpdate);
 Use;
end;

procedure TvcmAction.UnlockUpdate;
  {-}
begin
 Dec(f_LockUpdate);
 if (f_LockUpdate < 0) then
  f_LockUpdate := 0;
 Free; 
end;

function TvcmAction.IsExecuteLocked: Boolean;
  {-}
begin
 Result := (f_LockExecute > 0);
end;

procedure TvcmAction.LockExecute;
  {-}
begin
 Inc(f_LockExecute);
end;

procedure TvcmAction.UnlockExecute;
  {-}
begin
 Dec(f_LockExecute);
 if (f_LockExecute < 0) then
  f_LockExecute := 0;
end;

function TvcmAction.HasInfoForCombo: Boolean;
  {-}
begin
 Result := ((f_Strings <> nil) AND (f_Strings.Count > 0)) OR
           ((f_SubNodes <> nil) AND (f_SubNodes.Count >= 1));
end;

function TvcmAction.pm_GetIsSelectedStringChanged: Boolean;
  {* - изменилась ли выбранное значение. }
begin
 Result := not vcmSame(OldSelectedString, SelectedString);
end;//pm_GetIsSelectedStringChanged

function TvcmAction.pm_GetIsStringsChanged: Boolean;
begin
 if (f_OldStrings = nil) then
  Result := (f_Strings <> nil) AND (f_Strings.Count > 0)
 else
  Result := (f_Strings = nil) OR not f_Strings.EQ(f_OldStrings);
end;

procedure TvcmAction.SaveStrings;
begin
 if (f_OldStrings = nil) then
  if (f_Strings <> nil) AND (f_Strings.Count > 0) then
   f_OldStrings := TvcmStringList.Make
  else
   Exit;
 f_OldStrings.Assign(f_Strings);
end;

function TvcmAction.CalcOperationHint(const aHint, aLongHint: IvcmCString): IvcmCString;
begin
 if vcmSame(aHint, aLongHint) then
  Result := aHint
 else
  Result := vcmCat(vcmCat(aHint, '|'), aLongHint);
end;

procedure TvcmAction.Change;
begin
 inherited Change;
 if (f_ChangeCount = 0) then
 begin
  if (inherited Caption = '') then
   Caption := nil
  else
   Caption := vcmCStr(inherited Caption);
  if (inherited Hint = '') then
   Hint := nil
  else
   Hint := vcmCStr(inherited Hint);
 end;//f_ChangeCount = 0
end;

procedure TvcmAction.pm_SetIsDefault(aValue: Boolean);
begin
 if f_IsDefault <> aValue then
 begin
  f_IsDefault := aValue;
 end;
end;

function TvcmAction.pm_GetSelectedString: IvcmCString;
begin
 Result := f_SelectedString;
end;

procedure TvcmAction.pm_SetSelectedString(const aValue: IvcmCString);
begin
 f_SelectedString := aValue;
end;

function TvcmAction.pm_GetFont: IvcmFont;
begin
 Result := f_Font;
end;

function TvcmAction.pm_GetSubItems: IvcmItems;
begin
 Result := f_Strings;
end;

function TvcmAction.pm_GetSubNodes: IvcmNodes;
begin
 Result := f_SubNodes;
end;

function TvcmAction.pm_GetIsDefault: Boolean;
begin
 Result := f_IsDefault;
end;

function TvcmAction.pm_GetCaption: IvcmCString;
begin
 Result := f_Caption;
end;

function TvcmAction.pm_GetHint: IvcmCString;
begin
 Result := f_Hint;
end;

procedure TvcmAction.IvcmAction_Execute;
begin
 Execute;
end;
{$IfEnd}

end.

