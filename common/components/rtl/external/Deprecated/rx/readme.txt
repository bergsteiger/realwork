HHHH       H            H        HHHH       H  H
H   H  HH  H  HHH  H HH    HHH  H     HH   H  HHH H   H  HHH  H HH  HH
H   H H  H H H  H  HH   H H     HH   H  H HHH  H  H H H H  H  HH   H  H
HHHH  H  H H H  H  H    H  HH     HH H  H  H   H   HHH  H  H  H    HHH   
H      HH  H  HHHH H    H    H     H  HH   H    H  H H   HHHH H    H   
H                         HHH  HHHH       H                         HHH

 ----------------------------
-=   Patch на RXLib 2.75.   =-
 ----------------------------
         Версия 1.5

Неофициальный набор исправленных и дополненных файлов RXLib 2.75 и
не вошедших в Rx275fix.zip.

Все внесенные изменения отмечены в тексте PAS-файлов комментариями вида // Polaris

Все тестировалось на Delphi 3 C/S Update Pack 2 (build 5.83),
                     Delphi 4 C/S Update Pack 3 (build 5.108),
                     Delphi 5 Ent Update Pack 1 (build 6.18),
                     Delphi 6 Ent (build 6.163),
                     BCB    4 Ent (build 14.4),
                     BCB    5 Ent (build 12.34).

СОСТАВ (в скобках указана версия)
~~~~~~
RxDBComb.pas
------------
TRxDBComboBox: 
1. свойство EnableValues default True.
2.(1.0) свойство Style default csDropDownList. Теперь установка Style в 
   csSingle или csDropDown приводит к EnableValues = False.
3.(1.2) Добавлено свойство Align.

ToolEdit.pas (изменен для Polaris Library)
------------
1. TPopupWindow: Show стал virtual.
2. TCustomComboEdit: FButton, FPopupVisible, FFocused, SetShowCaret, SetDirectInput перенесены
из секции private в protected. DoChange стал virtual.
TCustomDateEdit:
3.(1.2) добавлены свойства MinDate, MaxDate и DateAutoBetween (управляет результатом при 
        выходе даты за ограничения).
4.(1.2) SetDate поднят в protected и сделан virtual.
5.(1.3) свойство DateAutoBetween теперь управляет MinDate и MaxDate: 
        если новое MinDate больше MaxDate, то MinDate := MaxDate.
TCustomComboEdit: 
6.(1.2) Ctrl-Enter вставляла перевод каретки.
7.(1.3) Теперь правильно работает выравнивание вправо и по центру. (ошибка после п.1.2)
8.(1.3) Ctrl-Tab вставляла символ табуляции.
9.(1.3) Был вылет при создании компоненты, если менять GlyphKind в методе Create потомка.
10.(1.3) Отступ справа уменьшен на 2 точки.

PickDate.pas
------------
1. TSelectDateDlg: Заменены TButton на TBitBtn.
2. Изменен вызов SelectDate для отображения диалога выбора даты (при CalendarStyle=csDialog)
в TDateEdit и TDBDateEdit не в центре экрана, а также как и popup - около компонента.
3.(1.2) SelectDate: при Sender=nil календарь будет появляться по умолчанию (по центру).
4.(1.2) Изменения в формах, связанные с добавлением свойств MinDate и MaxDate.

RxCConst.pas, RxCConst.r32
--------------------------
1.(1.2) Добавлены сообщения об ошибках для TDateEdit.

RxLookup.pas
------------
TRxLookupControl: изменены
1. поведение KeyValue - при отсутствии значения KeyValue возвращает
значение Null, а не Unassigned.
2. метод ResetField для исключения очистки поля по Esc, если не в режиме dsEdit.
3. метод SetValue - не вызывалось событие OnChange при установленных значениях
DataField, DataSource при попытке изменения свойства KeyValue.
4.(1.0) добавлено свойство EmptyStrIsNull, которое позволяет при пустом EmptyValue сохранять
в поля и возвращать KeyValue значения NULL (=True) или пустую строку (=False).

TRxDBLookupCombo: изменены
5. метод KeyPress - после срабатывания Esc на очистку поля не продолжать обработку
нажатия.
6. метод KeyValueChanged - раньше не отображалось DisplayEmpty, если DataField является
lookup-полем и равно Null.
7.(1.0) правая граница текста сдвинута на два пиксела влево при выравнивании влево 
   (в соответствии со стандартными combo-компонентами Delphi).
8.(1.2) Добавлено свойство Align.
9.(1.3) Выравнивание устанавливается в соответствии с Alignment от DataField при непустом значении.

RxCombos.pas
------------
TColorComboBox:
1. Дополнен массив ColorValues до 41. Добавлено свойство AllColors - 
использовать ли все цвета.
2. Свойство ColorNames заполняется значениями из ресурса rxcombos.r32.
3.(1.0) ColorValues дополнен до 44 константами из VCLUtils.
4.(1.1) Внесены изменения в соответствии с Rx275fix.zip.
5.(1.3) Добавляет выбор произвольного цвета, если установлено coIncludeOther в Options.
6.(1.3) Исправлены ошибки формирования списка цветов при изменении Options.

rRxCombo.pas  [Добавлен как интерфейс к rxcombos.rc для TColorComboBox]
------------
1.(1.0) Добавлены 3 цвета.
2.(1.1) Добавлены 2 "цвета" (None и Default).

RxCombos.r32
------------
1. Добавлены строковые ресурсы - названия цветов.
2.(1.0) Добавлены 3 цвета.
3.(1.1) Добавлены 2 "цвета" (None и Default).

ToolEdit.r32
------------
1. FEDITBMP: папка покрашена в желтый цвет.

RxCtl.dpk,RxCtl4.dpk,RxCtl5.dpk,RxCtl.bpk,RxCtl4.bpk,RxCtl5.bpk
---------------------------------------------------------------
1.(1.1) Добавлен в секцию contains модуль rrxcombo.pas.
2.(1.2) AppUtils.pas заменен на RxAppUtils.pas. (только rxctl5.dpk)
3.(1.4) Внесены изменения и в RxCtl.bpk,RxCtl4.bpk,RxCtl5.bpk.

RxAppUtils.pas
--------------
1.(1.2) Добавлен для совместимости с пакетом Borland Integrated Translation Environment.
   Тоже самое, что и AppUtils.pas.

Speedbar.pas, rxremlog.pas, Rxlogin.pas, Rxhints.pas, rxgrids.pas, Rxgrdcpt.pas, Rxdbctrl.pas,
Pictedit.pas, Placemnt.pas, Mrulist.pas, LoginDlg.pas, Dbutils.pas, Dbsecur.pas, BdeUtils.pas, 
Appevent.pas, Icoledit.pas
---------------------------------------------------------------------------------------------
1.(1.2) (D5) AppUtils заменен на RxAppUtils в uses. Для совместимости с пакетом Borland Integrated
Translation Environment.

RxSpin.pas
----------
1.(1.2) Добавлено TRxSpinButton.ButtonStyle - значения sbsDefault и sbsClassic (кнопки как TSpinButton из Samples).
Немного изменена отрисовка 'кнопок'.
2.(1.2) Добавлен TRxCustomSpinEdit.
TRxCustomSpinEdit:
3.(1.2) ButtonKind - добавлено значение bkClassic (соответствует TRxSpinButton.ButtonStyle=sbsClassic).
4.(1.2) Добавлено свойства Alignment и Align.
5.(1.2) Не возникает искл. ситуация при очистке поля ввода при отладке с опцией Stop on Delphi Exceptions.
6.(1.2) TRxSpinButton - cтандартные DownGlyph и UpGlyph не сохраняются в DFM-файле.
TRxCustomSpinEdit:
7.(1.3) Добавлены свойства CheckMinValue и CheckMaxValue: если значение свойства MinValue равно 0 и 
CheckMinValue равно False то нижняя граница не проверяется. Аналогично для MaxValue и CheckMaxValue.
8.(1.4) При вставке из буфера обмена неверного текста остается старое значение.
9.(1.4) Добавлено свойство CheckOnExit.

RxSpin.r32
----------
1.(1.2) Ресурсы для sbsClassic кнопок.

RxCtrls.pas
-----------
TRxSpeedButton:
1.(1.2) Добавлено свойство FlatStandard - (True - как у Borland).
2.(1.2) Изменена отрисовка каемок для Flat=True.

RxCalc.pas
----------
1.(1.2) Добавлены кнопки sqrt, 1/x, % в PopupCalculator. Увеличены размеры кнопок = и +.

CurrEdit.pas
------------
1.(1.2) TRxCalcEdit, TCurrencyEdit, др. - добавлено свойство Align.
2.(1.3) TCustomNumEdit - ButtonWidth = 21.
3.(1.4) TCustomNumEdit, TRxCalcEdit, TCurrencyEdit - добавлено свойство DecimalPlaceRound - 
округлять до DecimalPlaces.

RxDBCtrl.pas
------------
1.(1.2) TRxDBGrid - теперь правильно отрисовывает фиксированные колонки после сдвига формы над ними.
2.(1.2) TDBDateEdit - изменения, связанные с изменением TDateEdit.
TRxDBCalcEdit:
3.(1.3) Добавлено свойство EmptyIsNull.
4.(1.3) Если значение поля NULL, то показывается пусто.
5.(1.4) TRxDBCalcEdit - добавлено свойство DecimalPlaceRound из TCustomNumEdit.

6.(1.5) TRxDBGrid - добавлено свойство AutoAppend (автоматическое добавление записи при перемещении 
за последнюю запись).

RxResExp.pas
------------
1.(1.2) TRxProjectResExpert не проверял при создании наличие пункта меню Resources.

LoginDlg.pas
------------
1.(1.3) Закрывается БД перед присваиванием нового алиаса.

RxCtl6.*, RxDB6.*, RxBDE6.*, DclRx6.*, DclRxDB6.*, DclRxBD6.*, RxStrUtils.pas
-----------------------------------------------------------------------------
1.(1.5) Добавлены для совместимости с Delphi 6.

AniFile.pas, BDEUtils.pas, CheckItm.pas, ClipMon.pas, CurrEdit.pas, DateUtil.pas, 
DBFilter.pas, DBUtils.pas, ExcptDlg.pas, FileUtil.pas, GradEdit.pas, HintProp.pas, 
IcoLEdit.pas, MinMaxEd.pas, ObjStr.pas, PgMngrEd.pas, PicClip.pas, PickDate.pas, 
PictEdit.pas, Placemnt.pas, PresrDsn.pas, RxAppUtils.pas, RxBDEReg.pas, RxCalc.pas,
RxClock.pas, RxColors.pas, RxConst.pas, RxCtlReg.pas, RxCtrls.pas, RxDBComb.pas,
RxDBCtrl.pas, RxDBReg.pas, RxDice.pas, RxDsgn.pas, RxGIF.pas, RxGrids.pas, RxIni.pas,
RxLookup.pas, RxMemDS.pas, RxMenus.pas, RxProps.pas, RxQuery.pas, RxResExp.pas,
RxSpin.pas, RxTooReg.pas, SBEdit.pas, SelDSFrm.pas, SpeedBar.pas, StrHlder.pas,
StrLEdit.pas, TimerLst.pas, TImLstEd.pas, ToolEdit.pas, VCLUtils.pas
------------------------------------------------------------------------------------
1. (1.5) Исправлены для совместимости с Delphi 6:
  - в uses StrUtils заменен на RxStrUtils;
  - в uses добавлены Variants, RTLConsts;
  - в uses DsgnIntf заменен на DesignIntf, DesignEditors;
  - IFormDesigner заменен на IDesigner;
  - устранены конфликты методов;
  - оставлены почти все Warnings, связанные с поддержкой Delphi нескольких платформ и
    переносами отдельных функций и классов из одного модуля в другой.

УСТАНОВКА
~~~~~~~~~
Для того, чтобы применить эти изменения, необходимо переписать все файлы в папку Units,
которая находится в той папке, куда Вы установили RXLib. Затем перекомпилировать пакеты
Delphi3: rxctl, rxdb, dclrxctl, dclrxdb.
Delphi4: rxctl4, rxdb4, dclrx4, dclrxdb4.
Delphi5: rxctl5, rxdb5, rxbde5, dclrx5, dclrxdb5, dclrxbd5.
Delphi6: rxctl6, rxdb6, rxbde6, dclrx6, dclrxdb6, dclrxbd6.
BCB4   : rxctl4, rxdb4, dclrx4, dclrxdb4.
BCB5   : rxctl5, rxdb5, rxbde5, dclrx5, dclrxdb5, dclrxbd5.


31.07.01

Спасибо за внимание,

Краснодар, Россия
                                        Благодарности
Polaris Software 			Bergamot
http://polesoft.da.ru                   http://come.to/bergamot
polesoft@mail.ru			bergamot@chat.ru