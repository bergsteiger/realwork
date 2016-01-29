unit PageSetup_Form;

{ Окно настроек страницы }

// $Id: PageSetup_Form.pas,v 1.11 2015/06/03 15:01:02 lulin Exp $

// $Log: PageSetup_Form.pas,v $
// Revision 1.11  2015/06/03 15:01:02  lulin
// - правим зависимости.
//
// Revision 1.10  2015/01/23 17:47:16  kostitsin
// рисуем TeeMemo
//
// Revision 1.9  2014/08/19 12:02:17  kostitsin
// {requestlink: 562594400 }
//
// Revision 1.8  2014/08/19 11:26:48  kostitsin
// {requestlink: 562594400 }
//
// Revision 1.7  2013/05/16 11:07:56  morozov
// {RequestLink:449678181}
//
// Revision 1.6  2013/04/24 09:35:57  lulin
// - портируем.
//
// Revision 1.5  2013/01/22 15:59:20  kostitsin
// [$424399029]
//
// Revision 1.4  2011/11/16 17:35:57  lulin
// {RequestLink:232098711}
//
// Revision 1.3  2011/10/25 11:18:20  lulin
// {RequestLink:271752635}.
//
// Revision 1.2  2010/09/09 13:16:51  lulin
// {RequestLink:197496539}.
//
// Revision 1.152  2009/12/24 10:21:41  oman
// - fix: {RequestLink:175539723}
//
// Revision 1.151  2009/11/18 13:06:02  lulin
// - используем базовые параметры операции.
//
// Revision 1.150  2009/11/12 14:32:28  lulin
// - убираем возможность менять список параметров.
//
// Revision 1.149  2009/10/02 14:38:03  lulin
// - форма настройки страницы переведена на фабрику.
//
// Revision 1.148  2009/09/15 12:50:19  lulin
// - сделана фабрика для формы настроек принтера.
//
// Revision 1.147  2009/02/10 19:03:55  lulin
// - <K>: 133891247. Вычищаем морально устаревший модуль.
//
// Revision 1.146  2009/02/10 12:53:44  lulin
// - <K>: 133891247. Выделяем интерфейсы настройки.
//
// Revision 1.145  2009/01/28 07:11:14  oman
// - fix: Последствия изменения дефолтного шрифта (К-136252423)
//
// Revision 1.144  2009/01/13 08:10:58  oman
// - new: Новый макрос для колонтитулов (К-121144891)
//
// Revision 1.143  2008/12/29 11:34:08  oman
// - fix: Чистим ненужные константы и операции (К-122675365)
//
// Revision 1.142  2008/07/07 14:27:09  lulin
// - подготавливаемся к переименованию.
//
// Revision 1.141  2008/05/15 18:16:29  lulin
// - вычищаем ненужное.
//
// Revision 1.140  2008/05/13 16:24:28  lulin
// - изменения в рамках <K>: 90441490.
//
// Revision 1.139  2008/02/04 14:03:43  oman
// - new: Предупреждение о редакциях (cq20237, 11152)
//
// Revision 1.138  2008/02/04 10:09:51  oman
// - new: Заготовки для макроса "Статус документа" (cq20237, 11152)
//
// Revision 1.137  2008/01/29 09:29:56  oman
// - new: Упрощение параметров страницы - Внешний вид (cq28293)
//
// Revision 1.136  2008/01/29 09:04:03  oman
// - new: Упрощение параметров страницы - Потроха готовы (cq28293)
//
// Revision 1.135  2008/01/29 08:01:03  oman
// - new: Упрощение параметров страницы - Убираем пока комбобокс (cq28293)
//
// Revision 1.134  2008/01/25 11:25:31  oman
// - new: Размер бумаги берем только из принтера (cq27281)
//
// Revision 1.133  2008/01/10 07:23:30  oman
// Переход на новый адаптер
//
// Revision 1.132.2.1  2007/11/23 10:41:09  oman
// cleanup
//
// Revision 1.132  2007/10/26 13:36:30  oman
// - fix: Не обновлялся размер бумаги (cq27211)
//
// Revision 1.131  2007/08/14 19:31:50  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.130  2007/04/02 12:17:06  lulin
// - используем родные кнопки.
//
// Revision 1.129  2007/03/20 13:58:38  lulin
// - cleanup.
//
// Revision 1.128  2007/03/16 13:58:28  lulin
// - переходим на собственную функцию форматирования строк.
//
// Revision 1.127  2007/02/05 14:36:22  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.126  2007/01/19 09:47:20  lulin
// - выделяем интерфейс параметров для создания формы.
//
// Revision 1.125  2007/01/17 14:03:03  lulin
// - вычищены последние нефиксированные параметры в тестах операций.
//
// Revision 1.124  2006/12/07 14:18:10  mmorozov
// - new: используем единые настройки для компонента с вкладками (CQ: OIT5-23819);
//
// Revision 1.123  2006/12/07 12:40:48  lulin
// - повторный переход на "правильные" панели.
//
// Revision 1.122  2006/12/05 14:15:55  lulin
// - контрол переехал в визуальную библиотеку.
//
// Revision 1.121  2006/12/04 13:45:31  oman
// - fix: Константа для определения минимальной печатной области
//  вынесена в l3/ev (cq23103)
// - fix: Поля устанавливаем исходя из "квадрата" min(Height, Width) (cq23103)
//
// Revision 1.120  2006/11/22 14:07:24  lulin
// - bug fix: не собиралось.
//
// Revision 1.119  2006/11/22 13:17:51  oman
// Merge from B_NEMESIS_6_4
//
// Revision 1.118  2006/11/20 10:17:57  oman
// Merge from B_NEMESIS_6_4
//
// Revision 1.117  2006/11/13 10:18:26  oman
// Merge from B_NEMESIS_6_4
//
// Revision 1.116.8.3  2006/11/22 13:14:57  oman
// - fix: Макрос "внутренний номер" доступен только для внутренней
//  версии (cq23719)
//
// Revision 1.116.8.2  2006/11/20 09:42:56  oman
// - Новые макросы для печати (cq23193)
//
// Revision 1.116.8.1  2006/11/13 10:02:57  oman
// - fix: Убираем неиспользуемую на печати настройку "Использовать
//  настройку документа"  (cq23576)
//
// Revision 1.116  2006/05/18 10:53:06  mmorozov
// - new: использование компонентов - наследников редактора с разным набором операций;
//
// Revision 1.115  2006/05/03 14:25:44  oman
// - change: сведение редактирования настроек к одним воротам
// - new beh: операция "восстановить все" для списка конфигураций (cq20377)
//
// Revision 1.114  2006/04/21 06:57:43  oman
// - унификация работы с настройками. Подготовка с заведению
// операции "Восстановить все" для списка конфигураций.
//
// Revision 1.113  2006/04/19 14:36:25  lulin
// - cleanup.
//
// Revision 1.112  2006/03/31 07:42:20  lulin
// - изменен тип параметров, подаваемый в Execte операции.
//
// Revision 1.111  2006/03/30 15:31:33  lulin
// - изменен тип параметров в _OnTest.
//
// Revision 1.110  2006/03/30 14:01:46  lulin
// - операция инициализации разделена на две - с параметрами и без - для того, чтобы в итоге избавится от первой.
//
// Revision 1.109  2006/01/26 17:49:06  oman
// - fix: на некоторых принтерах при открытии неверно выставлялся флаг модифицированности
//
// Revision 1.108  2006/01/20 14:45:22  oman
// cleanup (вычистил закомментированный бизнес-объект)
//
// Revision 1.107  2006/01/19 16:03:11  oman
// - fix: неверно вычислялась доступность операция "восстановить"
//
// Revision 1.106  2006/01/18 09:34:07  oman
// - new behavior: выделение с рефакторингом бизнес-объекта по редактированию настроек
//
// Revision 1.105  2005/12/09 12:25:06  oman
// - new behavior: В полях отсупа не заменяем "0" на ""
// - fix: Некорректно обрабатывался размер бумаги "Из документа"
//
// Revision 1.104  2005/12/01 12:06:52  oman
// - new behavior: конпка Ок доступна тепрь только если есть изменения.
//
// Revision 1.103  2005/11/30 15:35:53  oman
// - fix: Не сохранялись настройки страницы
//
// Revision 1.102  2005/10/06 10:49:38  lulin
// - класс панелей переехал в более правильное место.
//
// Revision 1.101  2005/10/06 09:17:09  lulin
// - базовый класс панелей переехал в более правильное место.
//
// Revision 1.100  2005/06/09 09:51:17  mmorozov
// change: TComboBoxQS заменен на TvtComboBoxQS;
//
// Revision 1.99  2005/05/30 11:38:48  lulin
// - new unit: vtGroupBox.
//
// Revision 1.98  2005/05/30 10:00:21  lulin
// - метки переехали в библиотеку VT.
//
// Revision 1.97  2005/05/27 14:46:36  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.96  2005/05/13 15:38:37  fireton
// - bug fix: параметры страницы сбрасывались значениями из принтера
//
// Revision 1.95  2005/04/21 07:38:20  fireton
// - bug fix: Range Check error - неправильно вычислялся максимальный размер страницы (непонятно, зачем он вообще вычислялся)
//
// Revision 1.94  2005/04/13 08:48:07  fireton
// - add: добавляем возможность выводить в колонитулах полное название документа
//
// Revision 1.93  2005/03/15 15:30:39  fireton
// - add: вкручивание настройки по использованию форматирования документа
//
// Revision 1.92  2005/03/14 14:23:05  lulin
// - вернул временно закомментированный код.
//
// Revision 1.91  2005/03/14 12:26:13  lulin
// - new behavior: теперь диалог настройки печати сохраняет/читает настройки через интерфейс IafwSettings.
//
// Revision 1.90  2005/02/22 13:46:57  lulin
// - сделана учет размеров и ориентации страницы, а также правого и левого отступов.
//
// Revision 1.89  2005/02/22 10:30:45  lulin
// - new behavior: сделана возможность печати нижнего колонтитула.
//
// Revision 1.88  2005/01/21 14:36:30  fireton
// - bug fix: ошибка при вводе больших чисел в ширину/высоту
//
// Revision 1.87  2005/01/11 11:46:46  fireton
// - bug fix: range check error при вводе больших чисел в размер страницы
//
// Revision 1.86  2004/12/30 11:49:21  lulin
// - интерфейсы относящиеся к Preview переехали в библиотеку AFW.
//
// Revision 1.85  2004/12/28 16:23:20  lulin
// - new unit: evHAFPainterEx.
//
// Revision 1.84  2004/12/28 15:38:08  lulin
// - new unit: evHAFPainterMacros.
//
// Revision 1.83  2004/12/28 14:29:31  lulin
// - new interface: _Il3Printer.
// - new class: Tl3Printer.
//
// Revision 1.82  2004/12/16 11:15:07  fireton
// - bug fix: отрицательные значения полей можно было ввести с клавиатуры
//
// Revision 1.81  2004/12/08 15:01:05  fireton
// - bug fix: поля не могут быть больше ширины/высоты страницы
//
// Revision 1.80  2004/12/06 14:34:14  lulin
// - интерфейсы перенесены в "правильное" место.
//
// Revision 1.79  2004/12/03 14:21:33  fireton
// - bug fix: в сеттингах не запоминался размер страницы
// - bug fix: более корректная отработка исключений
//

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vcmInterfaces, vcmBase, vcmEntityForm, vcmEntities, StdCtrls,
  ComCtrls, ExtCtrls, ImgList, vtSpin, Buttons,
  l3Interfaces,
  l3InternalInterfaces,
  vcmBaseEntities,
  OvcBase,  eeButton, ElXPThemedControl, 
  AbstractDropDown, DropDownTree, vtComboBoxQS, evTypes, eeMemo, ElPgCtl,
  Printers, evEditorWindow, evMultiSelectEditorWindow, evEditor, evMemo,
  vcmComponent, vtPanel, vtPngImgList, vtLabel, vtGroupBox,
  evCustomEditor, evEditorWithOperations, afwInterfaces, afwControl, nsPageSetup,
  nscPageControl, tb97GraphicControl, TB97Ctls, vtSpeedButton,
  afwCustomCommonControl, nevControl, evCustomMemo, evCustomEdit,
  elCustomEdit, elCustomButtonEdit, ctButtonEdit, ctAbstractEdit,
  EditableBox, FakeBox, afwTextControlPrim, afwTextControl,
  afwCustomCommonTextControlPrim, afwCustomCommonTextControl,
  afwControlPrim, afwBaseControl, afwCustomCommonControlPrim,
  l3InterfacedComponent,

  ConfigInterfaces, evCustomEditorWindowModelPart,

  vcmExternalInterfaces,

  PrimPageSetup_Form, evCustomEditorWindowPrim, evCustomEditorModelPart,

  PrimPageSetupOptions_Form, evCustomEditorWindow,
  eeMemoWithEditOperations
  ;

type

  TnsPixRectMode = (
   rmPage,
   rmClient,
   rmUpLeftColontitul,
   rmUpRightColontitul,
   rmDownLeftColontitul,
   rmDownRightColontitul
  );

  Ten_PageSetup = class(TvcmEntityFormRef)
    Entities: TvcmEntities;
    PortraitLadscapeImageList: TvtNonFixedPngImageList;
    SettingsPageControl: TnscPageControl;
    MarginsTabSheet: TElTabSheet;
    LeftMarginLabel: TvtLabel;
    LeftMarginUnitsLabel: TvtLabel;
    UpMarginLabel: TvtLabel;
    UpMarginUnitsLabel: TvtLabel;
    RightMarginLabel: TvtLabel;
    RightMarginUnitsLabel: TvtLabel;
    DownMarginLabel: TvtLabel;
    DownMarginUnitsLabel: TvtLabel;
    LeftMarginEdit: TvtSpinEdit;
    UpMarginEdit: TvtSpinEdit;
    RightMarginEdit: TvtSpinEdit;
    DownMarginEdit: TvtSpinEdit;
    PreviewGroupBox: TvtGroupBox;
    ColontitulPaintBox: TPaintBox;
    HeaderTabSheet: TElTabSheet;
    ColontitulsPanel: TvtPanel;
    ColontitulLabel: TvtLabel;
    AddMacroButton: TvtSpeedButton;
    ColontitulComboBox: TvtComboBoxQS;
    ColontitulFomatMemo: TeeMemoWithEditOperations;
    PageTabSheet: TElTabSheet;
    vtLabel1: TvtLabel;
    OrientationGroupBox: TvtGroupBox;
    PaperFormatLabel: TvtLabel;
    PageWidthLabel: TvtLabel;
    PageHeightLabel: TvtLabel;
    procedure ColontitulComboBoxChange(Sender: TObject);
    procedure ColontitulPaintBoxPaint(Sender: TObject);
    procedure ColontitulPaintBoxMouseDown(Sender : TObject;
                                          Button : TMouseButton;
                                          Shift  : TShiftState;
                                          X, Y   : Integer);
    procedure SettingsPageControlChange(Sender: TObject);
    procedure PortraitButtonClick(Sender: TObject);
    procedure LandscapeButtonClick(Sender: TObject);
    procedure PortraitLadscapePaintBoxPaint(Sender: TObject);
    procedure LeftMarginEditChange(Sender: TObject);
    procedure AddMacroButtonClick(Sender: TObject);
    procedure SettingsPageControlChanging(Sender: TObject;
      NewPage: TElTabSheet; var AllowChange: Boolean);
    procedure ColontitulFomatMemoTextSourceChangeModified(Sender: TObject);
    procedure LeftMarginEditKeyPress(Sender: TObject; var Key: Char);
    procedure vcmEntityFormCloseQueryEx(Sender: TObject;
      var CanClose: Boolean; aCaller: TCustomForm);
    procedure vcmEntityFormRefShow(Sender: TObject);
  private
  // internal fields
    f_SettingPageFormat : Boolean;
  private
  // internal fields
    procedure Save(SaveAsDefault: Boolean = False); override;
      {-}
    procedure EnableControls;
      {-}
    procedure SetColontitulComboBoxItemIndex(aIndex : Integer); override;
      {-}
    procedure FromGUIColontituls;
      {-}
    procedure ToGUIColontituls; override;
      {-}
    procedure FromGUIMargins;
      {-}
    procedure ToGUIMargins; override;
      {-}
    procedure ReadPageFormats; override;
      {-}
    procedure SetPageFormat(aOrientation : Integer); override;
      {-}
    function GetPageWidth : Double;
      {-}
    function GetPageHeight : Double;
      {-}
    procedure CetPixRect(out aRect : TRect; aMode : TnsPixRectMode);
      {-}
    procedure MacroAdd(const aString: AnsiString); override;
      {-}
    procedure AdjustControlsPlacement;
  end;

implementation

uses
  Math,

  l3String,
  l3Base,

  afwFacade,
  
  evHAFPainterMacros,
  evDef,

  DataAdapter,
  StdRes,

  nsSettings,
  nsConfiguration,
  nsTypes
  ;

{$R *.DFM}

//Ten_PageSetup

procedure Ten_PageSetup.SetColontitulComboBoxItemIndex(aIndex : Integer);
begin
 if (SettingsPageControl.ActivePage = HeaderTabSheet) or
    (SettingsPageControl.ActivePage = PageTabSheet) then
  ColontitulComboBox.ItemIndex := aIndex;
end;

procedure Ten_PageSetup.FromGUIColontituls;
var
 l_Index: TevPageColontituls;
begin
 if ((SettingsPageControl.ActivePage = HeaderTabSheet) or
     (SettingsPageControl.ActivePage = PageTabSheet)) and
         (f_CurrentColontitul >= 0) then
 begin
  if (SettingsPageControl.ActivePage = HeaderTabSheet) then
   l_Index := TevPageColontituls(Ord(pcUpLeftFirst) + f_CurrentColontitul)
  else
  if (SettingsPageControl.ActivePage = PageTabSheet) then
   l_Index := TevPageColontituls(Ord(pcUpLeft) + f_CurrentColontitul)
  else
   raise Exception.Create('');

  f_PageSetup.Colontituls[l_Index] := ColontitulFomatMemo.Buffer;
 end;
end;

procedure Ten_PageSetup.ToGUIColontituls;
var
 l_UpLeft,
 l_UpRight,
 l_DownLeft,
 l_DownRight : Tl3WString;

begin
// ColontitulsPanel.Parent := nil;
 if not((SettingsPageControl.ActivePage = HeaderTabSheet) or
        (SettingsPageControl.ActivePage = PageTabSheet)) then
  exit;
//
 if (ColontitulComboBox.ItemIndex < 0) then
  ColontitulComboBox.ItemIndex := 0;
//
 if (SettingsPageControl.ActivePage = HeaderTabSheet) then
 begin
  l_UpLeft := f_PageSetup.Colontituls[pcUpLeftFirst];
  l_UpRight := f_PageSetup.Colontituls[pcUpRightFirst];
  l_DownLeft := f_PageSetup.Colontituls[pcDownLeftFirst];
  l_DownRight := f_PageSetup.Colontituls[pcDownRightFirst];
  ColontitulsPanel.Parent := HeaderTabSheet;
 end//SettingsPageControl.ActivePage = HeaderTabSheet
 else
 if (SettingsPageControl.ActivePage = PageTabSheet) then
 begin
  l_UpLeft := f_PageSetup.Colontituls[pcUpLeft];
  l_UpRight := f_PageSetup.Colontituls[pcUpRight];
  l_DownLeft := f_PageSetup.Colontituls[pcDownLeft];
  l_DownRight := f_PageSetup.Colontituls[pcDownRight];
  ColontitulsPanel.Parent := PageTabSheet;
 end;//SettingsPageControl.ActivePage = PageTabSheet
 ColontitulFomatMemo.Text := ''; {* Clear; *}
 case ColontitulComboBox.ItemIndex of
  0 : begin
       EnableControls;
       ColontitulFomatMemo.Buffer := l_UpLeft;
      end;
  1 : begin
       EnableControls;
       ColontitulFomatMemo.Buffer := l_UpRight;
      end;
  2 : begin
       EnableControls;
       ColontitulFomatMemo.Buffer := l_DownLeft;
      end;
  3 : begin
       EnableControls;
       ColontitulFomatMemo.Buffer := l_DownRight;
      end;
 end;//case ColontitulComboBox.ItemIndex
//
 f_CurrentColontitul := ColontitulComboBox.ItemIndex;
 ColontitulPaintBox.Invalidate;
end;

procedure Ten_PageSetup.FromGUIMargins;
var
 lCalcClientWidth, lCalcClientHeight: Extended;
 l_PaperSquare: Extended;
begin
 if (SettingsPageControl.ActivePage <> MarginsTabSheet) then
  exit;
//
 with f_PageSetup do
 begin
  with PaperSize[PaperFormatIndex] do
   l_PaperSquare := Min(X, Y) / 10;
  lCalcClientWidth := l_PaperSquare - (LeftMarginEdit.AsInteger + RightMarginEdit.AsInteger);
  if lCalcClientWidth < (def_cmMinPrintArea/10.0) then
  begin
   if (Metrics[pmLeftMargin] = LeftMarginEdit.AsInteger) then
    RightMarginEdit.AsInteger:= Trunc(l_PaperSquare - Metrics[pmLeftMargin] - (def_cmMinPrintArea/10.0))
   else
    LeftMarginEdit.AsInteger := Trunc(l_PaperSquare - Metrics[pmRightMargin] - (def_cmMinPrintArea/10.0));
  end;

  lCalcClientHeight := l_PaperSquare - (UpMarginEdit.AsInteger + DownMarginEdit.AsInteger);
  if lCalcClientHeight < (def_cmMinPrintArea/10.0) then
  begin
   if (Metrics[pmUpMargin] = UpMarginEdit.AsInteger) then
    DownMarginEdit.AsInteger:= Trunc(l_PaperSquare - Metrics[pmUpMargin] - (def_cmMinPrintArea/10.0))
   else
    UpMarginEdit.AsInteger := Trunc(l_PaperSquare - Metrics[pmDownMargin] - (def_cmMinPrintArea/10.0));
  end;

  Metrics[pmLeftMargin] := LeftMarginEdit.AsInteger;
  Metrics[pmRightMargin] := RightMarginEdit.AsInteger;
  Metrics[pmUpMargin] := UpMarginEdit.AsInteger;
  Metrics[pmDownMargin] := DownMarginEdit.AsInteger;
 end; {with..}
end;

procedure Ten_PageSetup.ToGUIMargins;
begin
 if (SettingsPageControl.ActivePage <> MarginsTabSheet) then
  exit;
// PaperSettingsPanel.Visible := True;
 LeftMarginEdit.OnChange := nil;
 LeftMarginEdit.Text := FloatToStr(f_PageSetup.Metrics[pmLeftMargin]);
 LeftMarginEdit.OnChange := LeftMarginEditChange;
 RightMarginEdit.OnChange := nil;
 RightMarginEdit.Text := FloatToStr(f_PageSetup.Metrics[pmRightMargin]);
 RightMarginEdit.OnChange := LeftMarginEditChange;
 UpMarginEdit.OnChange := nil;
 UpMarginEdit.Text := FloatToStr(f_PageSetup.Metrics[pmUpMargin]);
 UpMarginEdit.OnChange := LeftMarginEditChange;
 DownMarginEdit.OnChange := nil;
 DownMarginEdit.Text := FloatToStr(f_PageSetup.Metrics[pmDownMargin]);
 DownMarginEdit.OnChange := LeftMarginEditChange;
end;

procedure Ten_PageSetup.ReadPageFormats;        
begin
 PaperFormatLabel.CCaption := vcmFmt(str_PaperFormatLabel,[f_PageSetup.PaperFormats[f_PageSetup.PaperFormatIndex]]);
 SetPageFormat(f_PageSetup.Orientation);
end;

procedure Ten_PageSetup.SetPageFormat(aOrientation : Integer);
begin
// Дабы избежать рекурсивного вызова
 if not f_SettingPageFormat then
 begin
  f_SettingPageFormat := True;
  try
   f_PageSetup.SetPageFormat(aOrientation);
(*   case (f_PageSetup.Orientation) of
    DMORIENT_PORTRAIT : PortraitButton.Checked := True;
    DMORIENT_LANDSCAPE : LandscapeButton.Checked := True;
    else begin
     PortraitButton.Checked := False;
     LandscapeButton.Checked := False;
    end;
   end;*)

   PageWidthLabel.CCaption := vcmFmt(str_PaperWidthLabel,[GetPageWidth]);
   PageHeightLabel.CCaption := vcmFmt(str_PaperHeightLabel,[GetPageHeight]);

   //PortraitLadscapePaintBox.Invalidate;
   ColontitulPaintBox.Invalidate;
  finally
   f_SettingPageFormat := False;
  end;
 end;
end;

function Ten_PageSetup.GetPageWidth : Double;
begin
 if (f_PageSetup.Orientation = DMORIENT_LANDSCAPE) then
  Result := f_PageSetup.PaperSize[f_PageSetup.PaperFormatIndex].Y / 10
 else
  Result := f_PageSetup.PaperSize[f_PageSetup.PaperFormatIndex].X / 10;
end;

function Ten_PageSetup.GetPageHeight : Double;
begin
 if (f_PageSetup.Orientation = DMORIENT_LANDSCAPE) then
  Result := f_PageSetup.PaperSize[f_PageSetup.PaperFormatIndex].X / 10
 else
  Result := f_PageSetup.PaperSize[f_PageSetup.PaperFormatIndex].Y / 10;
end;

procedure Ten_PageSetup.ColontitulComboBoxChange(Sender: TObject);
begin
 FromGUIColontituls;
 ToGUIColontituls;
end;

procedure Ten_PageSetup.ColontitulPaintBoxPaint(Sender: TObject);
var
 l_Rect1,
 l_Rect : TRect;
begin
//Paper rect shadow
 CetPixRect(l_Rect, rmPage);
 ColontitulPaintBox.Canvas.Pen.Color := clBtnText;
 ColontitulPaintBox.Canvas.Pen.Mode := pmCopy;
 ColontitulPaintBox.Canvas.Pen.Style := psSolid;
 if f_DisableControls then
  ColontitulPaintBox.Canvas.Brush.Color := clLtGray
 else
  ColontitulPaintBox.Canvas.Brush.Color := clWindow;//clInfoBk
 ColontitulPaintBox.Canvas.Brush.Style := bsSolid;
 ColontitulPaintBox.Canvas.Rectangle(l_Rect);
//Paper rect shadow
 ColontitulPaintBox.Canvas.Pen.Color := cl3DDkShadow;
 ColontitulPaintBox.Canvas.MoveTo(l_Rect.Left + 1, l_Rect.Bottom);
 ColontitulPaintBox.Canvas.LineTo(l_Rect.Right, l_Rect.Bottom);
 ColontitulPaintBox.Canvas.LineTo(l_Rect.Right, l_Rect.Top);
//User rect
 CetPixRect(l_Rect, rmClient);
 ColontitulPaintBox.Canvas.Pen.Color := clWindowFrame;
 ColontitulPaintBox.Canvas.Pen.Style := psDot;//psDash;
 ColontitulPaintBox.Canvas.Brush.Style := bsClear;
 ColontitulPaintBox.Canvas.Rectangle(l_Rect);
//Colontitls
 CetPixRect(l_Rect1, rmUpRightColontitul);
 ColontitulPaintBox.Canvas.MoveTo(l_Rect.Left, l_Rect1.Bottom - 1);
 ColontitulPaintBox.Canvas.LineTo(l_Rect.Right, l_Rect1.Bottom - 1);
 ColontitulPaintBox.Canvas.MoveTo(l_Rect1.Left, l_Rect1.Top);
 ColontitulPaintBox.Canvas.LineTo(l_Rect1.Left, l_Rect1.Bottom);
 CetPixRect(l_Rect1, rmDownRightColontitul);
 ColontitulPaintBox.Canvas.MoveTo(l_Rect.Left, l_Rect1.Top);
 ColontitulPaintBox.Canvas.LineTo(l_Rect.Right, l_Rect1.Top);
 ColontitulPaintBox.Canvas.MoveTo(l_Rect1.Left, l_Rect1.Top);
 ColontitulPaintBox.Canvas.LineTo(l_Rect1.Left, l_Rect1.Bottom);
//
 if (SettingsPageControl.ActivePage = HeaderTabSheet) or
    (SettingsPageControl.ActivePage = PageTabSheet) then begin
  case ColontitulComboBox.ItemIndex of
   0 : begin
        CetPixRect(l_Rect, rmUpLeftColontitul);
        l_Rect.Right := l_Rect.Right + 1;
       end;
   1 : CetPixRect(l_Rect, rmUpRightColontitul);
   2 : begin
        CetPixRect(l_Rect, rmDownLeftColontitul);
        l_Rect.Right := l_Rect.Right + 1;
       end;
   3 : CetPixRect(l_Rect, rmDownRightColontitul);
  end;
//  ColontitulPaintBox.Canvas.Pen.Color := clRed;
  l_Rect.Top := l_Rect.Top + 1;
  l_Rect.Left := l_Rect.Left + 1;
  ColontitulPaintBox.Canvas.Pen.Style := psClear;
  ColontitulPaintBox.Canvas.Brush.Color := clGrayText;
  if (ColontitulFomatMemo.Text = '') then
   ColontitulPaintBox.Canvas.Brush.Style := bsDiagCross
  else
   ColontitulPaintBox.Canvas.Brush.Style := bsSolid;
  ColontitulPaintBox.Canvas.Rectangle(l_Rect);
 end;
end;

procedure Ten_PageSetup.ColontitulPaintBoxMouseDown(Sender : TObject;
                                                    Button : TMouseButton;
                                                    Shift  : TShiftState;
                                                    X, Y   : Integer);
var
 l_Rect : TRect;
 function InRect(aRect : TRect; X, Y : Integer) : Bool;
 begin
  if ((X > aRect.Left) and (aRect.Right > X) and
      (Y > aRect.Top) and (aRect.Bottom > Y)) then
   result := True
  else
   result := False;
 end;
begin
 CetPixRect(l_Rect, rmUpLeftColontitul);
 if (InRect(l_Rect, X, Y)) then begin
  SetColontitulComboBoxItemIndex(0);
  exit;
 end;
 CetPixRect(l_Rect, rmUpRightColontitul);
 if (InRect(l_Rect, X, Y)) then begin
  SetColontitulComboBoxItemIndex(1);
  exit;
 end;
 CetPixRect(l_Rect, rmDownLeftColontitul);
 if (InRect(l_Rect, X, Y)) then begin
  SetColontitulComboBoxItemIndex(2);
  exit;
 end;
 CetPixRect(l_Rect, rmDownRightColontitul);
 if (InRect(l_Rect, X, Y)) then begin
  SetColontitulComboBoxItemIndex(3);
  exit;
 end;
end;

procedure Ten_PageSetup.SettingsPageControlChange(Sender: TObject);
begin
 ToGUIColontituls;
 ToGUIMargins;
//
 PreviewGroupBox.Parent := SettingsPageControl.ActivePage;
end;

procedure Ten_PageSetup.PortraitButtonClick(Sender: TObject);
begin
 if not f_SettingPageFormat then
  SetPageFormat(DMORIENT_PORTRAIT);
end;

procedure Ten_PageSetup.LandscapeButtonClick(Sender: TObject);
begin
 if not f_SettingPageFormat then
  SetPageFormat(DMORIENT_LANDSCAPE);
end;

procedure Ten_PageSetup.PortraitLadscapePaintBoxPaint(Sender: TObject);
begin
(* PortraitLadscapeImageList.Draw(PortraitLadscapePaintBox.Canvas,
                                0,
                                0,
                                f_PageSetup.Orientation);*)
end;

procedure Ten_PageSetup.LeftMarginEditChange(Sender: TObject);
begin
 FromGUIMargins;
 ColontitulPaintBox.Invalidate;
end;

procedure Ten_PageSetup.CetPixRect(out aRect: TRect; aMode: TnsPixRectMode);
const
 c_Margin = 12;
var
 l_Width,
 l_Height,
 l_X0,
 l_Y0,
 l_BoxWidth,
 l_BoxHeight: Integer;
 l_kXY: Double;
begin
 l3FillChar(aRect, SizeOf(aRect), 0);
 l_BoxWidth := ColontitulPaintBox.Width - c_Margin*2;
 l_BoxHeight := ColontitulPaintBox.Height - c_Margin*2;

 if ((GetPageWidth > 0) and (l_BoxWidth > 0) and
     (GetPageHeight > 0) and (l_BoxHeight > 0)) then
 begin
  l_kXY := Min(l_BoxWidth/GetPageWidth, l_BoxHeight/GetPageHeight);
  l_kXY := Min(l_kXY, Min(l_BoxWidth/GetPageHeight, l_BoxHeight/GetPageWidth));
  l_Width := Round(l_kXY*GetPageWidth + 0.5);
  l_Height := Round(l_kXY*GetPageHeight + 0.5);
  l_X0 := c_Margin + Round((l_BoxWidth - l_Width)/2.0 + 0.5);
  l_Y0 := c_Margin + Round((l_BoxHeight - l_Height)/2.0 + 0.5);

  case aMode of
   rmPage :
     begin
      aRect.Left := l_X0;
      aRect.Top := l_Y0;
      aRect.Right := l_X0 + l_Width;
      aRect.Bottom := l_Y0 + l_Height;
     end;
   rmClient :
     begin
      aRect.Left := l_X0 + Max(1, Round(l_kXY*f_PageSetup.Metrics[pmLeftMargin] + 0.5));
      aRect.Top := l_Y0 + Max(1, Round(l_kXY*f_PageSetup.Metrics[pmUpMargin] + 0.5));
      aRect.Right := l_X0 + l_Width - Max(1, Round(l_kXY*f_PageSetup.Metrics[pmRightMargin] + 0.5));
      aRect.Bottom := l_Y0 + l_Height - Max(1, Round(l_kXY*f_PageSetup.Metrics[pmDownMargin] + 0.5));
     end;
   rmUpLeftColontitul :
     begin
      aRect.Left := l_X0 + Max(1, Round(l_kXY*f_PageSetup.Metrics[pmLeftMargin] + 0.5));
      aRect.Top := l_Y0 + Max(1, Round(l_kXY*f_PageSetup.Metrics[pmUpMargin] + 0.5));
      aRect.Right := l_X0 + Round(l_kXY*(GetPageWidth - (f_PageSetup.Metrics[pmRightMargin] - f_PageSetup.Metrics[pmLeftMargin]))/2.0 + 0.5);
      aRect.Bottom := l_Y0 + Round(l_kXY*(f_PageSetup.Metrics[pmUpMargin] + c_PreviewColontitulHeight) + 0.5);
     end;
   rmUpRightColontitul :
     begin
      aRect.Left := l_X0 + Round(l_kXY*(GetPageWidth - (f_PageSetup.Metrics[pmRightMargin] - f_PageSetup.Metrics[pmLeftMargin]))/2.0 + 0.5);
      aRect.Top := l_Y0 + Max(1, Round(l_kXY*f_PageSetup.Metrics[pmUpMargin] + 0.5));
      aRect.Right := l_X0 + l_Width - Max(1, Round(l_kXY*f_PageSetup.Metrics[pmRightMargin] + 0.5));
      aRect.Bottom := l_Y0 + Round(l_kXY*(f_PageSetup.Metrics[pmUpMargin] + c_PreviewColontitulHeight) + 0.5);
     end;
   rmDownLeftColontitul :
     begin
      aRect.Left := l_X0 + Max(1, Round(l_kXY*f_PageSetup.Metrics[pmLeftMargin] + 0.5));
      aRect.Top := l_Y0 + l_Height - Round(l_kXY*(f_PageSetup.Metrics[pmDownMargin] + c_PreviewColontitulHeight) + 0.5);
      aRect.Right := l_X0 + Round(l_kXY*(GetPageWidth - (f_PageSetup.Metrics[pmRightMargin] - f_PageSetup.Metrics[pmLeftMargin]))/2.0 + 0.5);
      aRect.Bottom := l_Y0 + l_Height - Max(1, Round(l_kXY*f_PageSetup.Metrics[pmDownMargin] + 0.5));
     end;
   rmDownRightColontitul :
     begin
      aRect.Left := l_X0 + Round(l_kXY*(GetPageWidth - (f_PageSetup.Metrics[pmRightMargin] - f_PageSetup.Metrics[pmLeftMargin]))/2.0 + 0.5);
      aRect.Top := l_Y0 + l_Height - Round(l_kXY*(f_PageSetup.Metrics[pmDownMargin] + c_PreviewColontitulHeight) + 0.5);
      aRect.Right := l_X0 + l_Width - Max(1, Round(l_kXY*f_PageSetup.Metrics[pmRightMargin] + 0.5));
      aRect.Bottom := l_Y0 + l_Height - Max(1, Round(l_kXY*f_PageSetup.Metrics[pmDownMargin] + 0.5));
     end;
  end;
 end;
end;

procedure Ten_PageSetup.MacroAdd(const aString: AnsiString);
begin
 ColontitulFomatMemo.InsertBuf(l3PCharLen(aString));
end;

procedure Ten_PageSetup.AddMacroButtonClick(Sender: TObject);
var
 l_Point: TPoint;
begin
 if Assigned(ColontitulFomatMemo.PopupMenu) then begin
  l_Point.X := 0;
  l_Point.Y := AddMacroButton.Height;
  l_Point := AddMacroButton.ClientToScreen(l_Point);
  ColontitulFomatMemo.PopupMenu.PopupComponent := ColontitulFomatMemo;
  ColontitulFomatMemo.PopupMenu.Popup(l_Point.X, l_Point.Y);
 end;
end;

procedure Ten_PageSetup.Save(SaveAsDefault: Boolean = False);
begin
 FromGUIColontituls;
 FromGUIMargins;
 f_PageSetup.Save(SaveAsDefault);
end;

procedure Ten_PageSetup.SettingsPageControlChanging(Sender: TObject;
  NewPage: TElTabSheet; var AllowChange: Boolean);
begin
 FromGUIColontituls;
 FromGUIMargins;
end;

procedure Ten_PageSetup.EnableControls;
begin
 f_DisableControls := False;
 ColontitulFomatMemo.Enabled := True;
 AddMacroButton.Enabled := True;
 //PreviewGroupBox.Enabled := True;
end;

procedure Ten_PageSetup.ColontitulFomatMemoTextSourceChangeModified(
  Sender: TObject);
begin
 if ColontitulFomatMemo.TextSource.Modified and Assigned(f_PageSetup) then
  f_PageSetup.MarkModified;
end;

procedure Ten_PageSetup.LeftMarginEditKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not (Key in ['0'..'9','.', #8]) then
  Key := #0;
end;

procedure Ten_PageSetup.vcmEntityFormCloseQueryEx(Sender: TObject;
  var CanClose: Boolean; aCaller: TCustomForm);
begin
 if not defDataAdapter.InTerminateProcess then
 begin
  if (ModalResult = mrCancel) and f_PageSetup.Modified then
   if Ask(qr_SavePageSetup) then
    f_PageSetup.Load
   else
    CanClose := False;
 end;
end;

procedure Ten_PageSetup.vcmEntityFormRefShow(Sender: TObject);
begin
 AdjustControlsPlacement;
end;

procedure Ten_PageSetup.AdjustControlsPlacement;
type
 TControlBounds = record
  Top    : integer;
  Left   : integer;
  Right  : integer;
  Bottom : integer;
 end;

const
 LC_CONTROL_VERTICAL_SPACEMENT = 2;

var
 l_DC : HDC;
 l_DPIX : integer;
 l_DPIY : integer;

 function lp_GetControlBounds(AControl: TControl): TControlBounds;
 begin
  Result.Top := AControl.Top;
  Result.Left := AControl.Left;
  Result.Right := AControl.Left + AControl.Width;
  Result.Bottom := AControl.Top + AControl.Height;
 end;

 function lp_ScaleX(AX : integer): integer;
 begin
  Result := MulDiv(AX, l_DPIX, 96);
 end;

 function lp_ScaleY(AY : integer): integer;
 begin
  Result := MulDiv(AY, l_DPIY, 96);
 end;

 function lp_IsControlUnder(AObjectControl: TControl; ASubjectControl: TControl): boolean;
 var
  l_ObjectControlBounds: TControlBounds;
  l_SubjectControlBounds: TControlBounds;
 begin
  l_ObjectControlBounds := lp_GetControlBounds(AObjectControl);
  l_SubjectControlBounds := lp_GetControlBounds(ASubjectControl);

  Result := (l_SubjectControlBounds.Top > l_ObjectControlBounds.Bottom) and
  // ASubjectControl шире AObjectControl
  (((l_SubjectControlBounds.Left <= l_ObjectControlBounds.Left)
   and (l_SubjectControlBounds.Right >= l_ObjectControlBounds.Right))
  // левый край ASubjectControl находится под AObjectControl
  or ((l_SubjectControlBounds.Left >= l_ObjectControlBounds.Left)
   and (l_SubjectControlBounds.Left <= (l_ObjectControlBounds.Right))
  // правый край ASubjectControl находится под AObjectControl
  or ((l_SubjectControlBounds.Right >= l_ObjectControlBounds.Left)
   and (l_SubjectControlBounds.Right <= l_ObjectControlBounds.Right))));
 end;

 procedure lp_AdjustControlsTop(AContainer: TControl; AControls: array of TControl);
 var
  l_Index : integer;
  l_ControlTop : integer;
  l_TotalHeight : integer;
  l_SubjectControl : TControl;
  l_VertDelta : integer;
  l_ContainerPrevHeight : integer;
  l_OldContainerBottom : integer;
  l_SubjectRelativeTop : integer;
 begin
  l_ControlTop := 0;
  l_TotalHeight := 0;
  for l_Index := Low(AControls) to High(AControls) do
  begin
   if l_Index = Low(AControls) then
   begin
    AControls[l_Index].Top := lp_ScaleY(AControls[l_index].Top);
    l_ControlTop := AControls[l_Index].Top;
    Continue;
   end;//if l_Index := Low(AControls)
   l_ControlTop := l_ControlTop +
    AControls[Pred(l_Index)].Height + LC_CONTROL_VERTICAL_SPACEMENT;
   AControls[l_Index].Top := lp_ScaleY(AControls[l_Index].Top); (*l_ControlTop;*)
   l_TotalHeight := AControls[l_Index].Top + AControls[l_Index].Height;
  end;//for l_Index := Low(AControls) to High(AControls)
  if (AContainer.ClientHeight <= l_TotalHeight) then
  begin
   l_OldContainerBottom := AContainer.Top + AContainer.Height;
   l_VertDelta := (l_TotalHeight - AContainer.ClientHeight) + LC_CONTROL_VERTICAL_SPACEMENT;
   if (AContainer.Parent <> nil) then
   begin
    // Сдвигаем вниз все нижележащие контролы
    for l_Index := 0 to AContainer.Parent.ControlCount - 1 do
    begin
     l_SubjectControl := AContainer.Parent.Controls[l_Index];
     if lp_IsControlUnder(AContainer, l_SubjectControl) then
      l_SubjectControl.Top := l_SubjectControl.Top + l_VertDelta;
    end;//for l_Index := 0
    AContainer.ClientHeight := AContainer.ClientHeight + l_VertDelta;
   end;//if (AContainer.Parent <> nil)
  end;//if (AContainer.ClientHeight <= l_TotalHeight)
 end;//lp_AdjustControlsTop

begin
 l_DC := GetDC(0);
 try
  l_DPIX := GetDeviceCaps(l_DC, LOGPIXELSX);
  l_DPIY := GetDeviceCaps(l_DC, LOGPIXELSY);
 finally
  ReleaseDC(0, l_DC);
 end;
 lp_AdjustControlsTop(OrientationGroupBox, [PaperFormatLabel, PageWidthLabel,
  PageHeightLabel]);
end;

end.