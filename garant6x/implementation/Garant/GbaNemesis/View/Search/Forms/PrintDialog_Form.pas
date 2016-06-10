unit PrintDialog_Form;

{ $Id: PrintDialog_Form.pas,v 1.26 2016/05/26 01:08:38 lulin Exp $ }

// $Log: PrintDialog_Form.pas,v $
// Revision 1.26  2016/05/26 01:08:38  lulin
// - перегенерация.
//
// Revision 1.25  2016/05/16 13:47:06  lulin
// - так правильнее.
//
// Revision 1.24  2016/05/05 09:16:08  morozov
// {RequestLink: 622825943}
//
// Revision 1.23  2016/05/05 06:56:55  lulin
// - синхронизируем настройки из диалога с принтером.
//
// Revision 1.22  2016/05/04 16:54:49  lulin
// {RequestLink:611828637}
//
// Revision 1.21  2016/04/28 15:53:50  lulin
// {RequestLink:621474995} Заточка для хитровыделенных.
//
// Revision 1.20  2015/06/03 15:03:56  lulin
// - правим зависимости.
//
// Revision 1.19  2015/06/03 15:01:02  lulin
// - правим зависимости.
//
// Revision 1.18  2014/08/19 12:02:17  kostitsin
// {requestlink: 562594400 }
//
// Revision 1.17  2014/08/19 11:26:48  kostitsin
// {requestlink: 562594400 }
//
// Revision 1.16  2013/12/12 12:07:29  morozov
// {RequestLink: 508450259}
//
// Revision 1.15  2013/01/22 15:59:20  kostitsin
// [$424399029]
//
// Revision 1.14  2011/12/21 10:34:29  kostitsin
// http://mdp.garant.ru/pages/viewpage.action?pageId=316114187&focusedCommentId=321985271&#comment-321985271
//
// Revision 1.13  2011/12/16 14:03:14  kostitsin
// http://mdp.garant.ru/pages/viewpage.action?pageId=316114187
//
// Revision 1.12  2011/11/16 17:35:57  lulin
// {RequestLink:232098711}
//
// Revision 1.11  2010/07/30 13:23:49  lulin
// {RequestLink:197496539}.
//
// Revision 1.10  2010/07/02 10:17:00  oman
// - fix: {RequestLink:222036047}
//
// Revision 1.9  2010/06/30 08:46:41  oman
// - fix: {RequestLink:220595917}
//
// Revision 1.8  2009/12/07 12:44:39  oman
// - fix: {RequestLink:172988439}
//
// Revision 1.7  2009/12/03 11:22:32  oman
// - fix: {RequestLink:172986900}
//
// Revision 1.6  2009/11/20 11:46:54  oman
// - fix: {RequestLink:146899387}
//
// Revision 1.5  2009/11/18 13:06:35  lulin
// - используем базовые параметры операции.
//
// Revision 1.4  2009/11/12 14:33:08  lulin
// - убираем возможность менять список параметров.
//
// Revision 1.3  2009/11/10 12:29:55  lulin
// - перестаём выливать идентификаторы внутренних операций.
//
// Revision 1.2  2009/10/02 16:06:47  lulin
// - диалог печати переведён на фабрику.
//
// Revision 1.137  2009/09/24 13:31:14  lulin
// - модуль Common начинаем переносить на модель.
//
// Revision 1.136  2009/09/15 13:13:49  lulin
// - сделана фабрика для формы печати.
//
// Revision 1.135  2009/08/04 11:25:42  lulin
// [$159351827].
//
// Revision 1.134  2009/07/31 17:29:55  lulin
// - убираем мусор.
//
// Revision 1.133  2009/02/20 18:50:53  lulin
// - <K>: 136941122. Убираем передачу параметров при запросе состояния операции.
//
// Revision 1.132  2009/02/20 13:44:15  lulin
// - <K>: 136941122.
//
// Revision 1.131  2009/02/10 19:03:55  lulin
// - <K>: 133891247. Вычищаем морально устаревший модуль.
//
// Revision 1.130  2009/02/10 17:45:11  lulin
// - <K>: 133891247. Выделяем интерфейсы Preview.
//
// Revision 1.129  2009/01/15 11:45:34  oman
// - fix: Откручиваем шорткаты "+"/"-" (К-112723164)
//
// Revision 1.128  2008/10/24 06:16:57  oman
// - fix: Реанимация печати справки (К-121160178)
//
// Revision 1.127  2008/08/04 12:44:19  oman
// - fix: Запрещаем область печати для встроенных объектов (K-105579231)
//
// Revision 1.126  2008/08/04 12:05:36  oman
// - fix: Текущую страницу спрашиваем только у превью документа (K-105579231)
//
// Revision 1.125  2008/08/01 10:55:45  oman
// - fix: Пытаемся превью текстов документов строить отложенно (K-105578604)
//
// Revision 1.124  2008/07/30 10:43:45  oman
// - new: Модификация диалога печати (К-104432770)
//
// Revision 1.123  2008/07/30 06:29:32  oman
// - new: Заготовки интерфейсов (К-104432770)
//
// Revision 1.122  2008/07/25 13:04:33  oman
// - new: Заготовки интерфейсов (К-104432770)
//
// Revision 1.121  2008/07/25 12:17:30  oman
// - new: Заготовки интерфейсов (К-104432770)
//
// Revision 1.120  2008/07/25 11:47:00  oman
// - new: Внешний вид диалога печати (К-104432770)
//
// Revision 1.119  2008/07/07 14:27:09  lulin
// - подготавливаемся к переименованию.
//
// Revision 1.118  2008/05/15 18:16:29  lulin
// - вычищаем ненужное.
//
// Revision 1.117  2008/05/13 16:24:28  lulin
// - изменения в рамках <K>: 90441490.
//
// Revision 1.116  2007/07/19 13:55:25  mmorozov
// - add units;
//
// Revision 1.115  2007/03/28 19:43:04  lulin
// - ЭлПаковский редактор переводим на строки с кодировкой.
//
// Revision 1.114  2007/03/20 13:31:59  lulin
// - используем строки с кодировкой.
//
// Revision 1.113  2007/03/20 11:38:18  lulin
// - не теряем кодировку при присваивании заголовков форм и контролов.
//
// Revision 1.112  2007/01/19 09:47:20  lulin
// - выделяем интерфейс параметров для создания формы.
//
// Revision 1.111  2007/01/17 14:03:03  lulin
// - вычищены последние нефиксированные параметры в тестах операций.
//
// Revision 1.110  2006/12/11 09:56:24  oman
// - fix: в ComplexDocumentPreview можно было установить в качестве
//   current совершенно любое preview.
//
// Revision 1.109  2006/12/06 10:02:23  lulin
// - cleanup: вычищены свойства по-умолчанию.
//
// Revision 1.108  2006/12/06 08:00:38  lulin
// - везде используем одни и те же метки.
//
// Revision 1.107  2006/12/05 14:15:55  lulin
// - контрол переехал в визуальную библиотеку.
//
// Revision 1.106  2006/11/03 09:46:00  oman
// Merge with B_NEMESIS_6_4_0
//
// Revision 1.105.4.2  2006/10/31 09:04:07  oman
// - fix: Если выбран интервал, то печатаем весь документ (cq23327)
//
// Revision 1.105.4.1  2006/10/25 07:29:50  oman
// Продолжаем избавлятся от StdStr
//
// Revision 1.105  2006/04/17 14:42:36  oman
// - new beh: перекладываем StdStr в _StdRes
//
// Revision 1.104  2006/03/31 07:42:20  lulin
// - изменен тип параметров, подаваемый в Execte операции.
//
// Revision 1.103  2006/03/30 15:31:33  lulin
// - изменен тип параметров в _OnTest.
//
// Revision 1.102  2006/03/30 14:01:46  lulin
// - операция инициализации разделена на две - с параметрами и без - для того, чтобы в итоге избавится от первой.
//
// Revision 1.101  2006/03/22 15:12:21  lulin
// - вычищены устаревшие Internal-операции.
//
// Revision 1.100  2006/03/16 07:58:40  oman
// - new beh: переход с _OnTest на _OnGetState для операций
//
// Revision 1.99  2006/02/04 08:12:37  oman
// - fix: Если при сохранении в файл отказаться от выбора далог закрывался.
//
// Revision 1.98  2006/02/03 14:52:34  oman
// - fix: Была возможность оставить диалог открытым после печати.
//
// Revision 1.97  2006/02/02 16:58:03  oman
// - fix: можно было послать задание на печать не завершив предыдущего
// - fix: Печать была недоступна без готового превью
//
// Revision 1.96  2006/01/31 17:12:06  oman
// - fix: Запрещаем операцию "Печать" если превью в процессе переделки
//
// Revision 1.95  2006/01/20 11:06:34  migel
// - fix: разрешение/запрещение специфичных для ознакомительной версии операций.
//
// Revision 1.94  2005/12/01 06:10:43  lulin
// - интерфейс preview перенесен в более общую библиотеку.
//
// Revision 1.93  2005/11/01 14:42:12  lulin
// - bug fix: слишком поздно присваивался индекс текущего принтера.
//
// Revision 1.92  2005/10/10 11:43:25  lulin
// - cleanup: используем интерфейсы из правильной библиотеки.
//
// Revision 1.91  2005/10/06 10:49:38  lulin
// - класс панелей переехал в более правильное место.
//
// Revision 1.90  2005/10/06 09:17:09  lulin
// - базовый класс панелей переехал в более правильное место.
//
// Revision 1.89  2005/06/09 09:51:17  mmorozov
// change: TComboBoxQS заменен на TvtComboBoxQS;
//
// Revision 1.88  2005/05/27 14:46:36  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.87  2005/04/25 06:58:28  fireton
// - небольшая подчистка кода
//
// Revision 1.86  2005/03/02 14:31:07  lulin
// - поправлено форматирование.
//
// Revision 1.85  2005/01/26 14:30:54  lulin
// - bug fix: не все кнопки прятались.
//
// Revision 1.84  2005/01/26 14:13:28  lulin
// - new behavior: если нету принтера, то запрещаем кнопку печати.
//
// Revision 1.83  2005/01/24 11:10:19  fireton
// - add: добавлена поддержка печати в файл
//
// Revision 1.82  2005/01/20 16:23:45  lulin
// - вычищены ненужные операции.
//
// Revision 1.81  2005/01/18 10:50:25  fireton
// - причесываем обработку ошибки при неправильном диапазоне страниц
//
// Revision 1.80  2005/01/18 10:02:18  fireton
// - причесываем обработку ошибки при неправильном диапазоне страниц
//
// Revision 1.79  2005/01/17 15:59:30  lulin
// - вернул возможность печати текущей страницы документа.
//
// Revision 1.78  2005/01/15 11:52:08  fireton
// - bug fix: корректная обработка ошибочного диапазона страниц
//
// Revision 1.77  2004/12/30 11:49:21  lulin
// - интерфейсы относящиеся к Preview переехали в библиотеку AFW.
//
// Revision 1.76  2004/12/29 14:06:22  lulin
// - evGraph и Preview полностью переведены с класса TPrinter на интерфейс _Il3Printer.
//
// Revision 1.75  2004/12/28 15:56:35  lulin
// - remove unit: nsPrintParams.
//
// Revision 1.74  2004/12/28 15:19:24  lulin
// - cleanup: вычищены процедуры, ставшие ненужными.
//
// Revision 1.73  2004/12/28 14:29:31  lulin
// - new interface: _Il3Printer.
// - new class: Tl3Printer.
//
// Revision 1.72  2004/12/28 12:54:03  lulin
// - cleanup: убрал Никитинское preview.
//

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, l3Interfaces,
  vcmBase, vcmEntityForm, vcmEntities,
  StdCtrls,
  ImgList, ExtCtrls, vtSpin, vcmBaseEntities,
  eeButton, eeCheckBox, AbstractDropDown,
  DropDownTree, vtComboBoxQS, OvcBase,  vcmComponent,
  vtPanel, vtPngImgList, afwInterfaces, afwControl, vtLabel, vtGroupBox,
  
  evMultiSelectEditorWindow, evCustomEditor, evEditorWithOperations,
  evCustomMemo, evCustomEdit, elCustomEdit, elCustomButtonEdit,
  ctButtonEdit, ctAbstractEdit, EditableBox, FakeBox, afwControlPrim,
  afwBaseControl, afwTextControlPrim, afwTextControl, nevControl,
  nscCombobox,
  PreviewInterfaces,
  l3InterfacedComponent,
  evCustomEditorWindowModelPart,

  PrimPrintDialogOptions_Form, evCustomEditorWindowPrim, evCustomEditorModelPart,
  evCustomEditorWindow,
  vtRadioButton, vtCheckBox
  ;

type
  TvcmEntityFormRef = TPrimPrintDialogOptionsForm;
  
  Ten_PrintDialog = class(TvcmEntityFormRef)
    FormPanel: TvtPanel;
    PrinterGroupBox: TvtGroupBox;
    PrinterNameLabel: TvtLabel;
    SettingsButton: TeeButton;
    cbPrinter: TvtComboBoxQS;
    PrintAreaGroupBox: TvtGroupBox;
    lbOddEven: TvtLabel;
    rbPrintAll: TvtRadioButton;
    rbPrintCurrent: TvtRadioButton;
    rbPrintSelected: TvtRadioButton;
    rbPrintInterval: TvtRadioButton;
    edPrintInterval: TnscEditWithoutPlusMinusShortcut;
    cbOddEven: TvtComboBoxQS;
    CopyGroupBox: TvtGroupBox;
    lbCopyCount: TvtLabel;
    CollatePaintBox: TPaintBox;
    CollateCheckBox: TvtCheckBox;
    edCopyCount: TvtSpinEdit;
    Entities: TvcmEntities;
    CollateImageList: TvtNonFixedPngImageList;
    PrintObjectsGroupBox: TvtGroupBox;
    poDocumentNames: TvtRadioButton;
    poDocumentTexts: TvtRadioButton;
    cbPrintInfo: TvtCheckBox;
    procedure SettingsButtonClick(Sender: TObject);
    procedure CollateCheckBoxClick(Sender: TObject);
    procedure CollatePaintBoxPaint(Sender: TObject);
    procedure edPrintIntervalChange(Sender: TObject);
    procedure edPrintIntervalKeyPress(Sender: TObject; var Key: Char);
    procedure vcmEntityFormCloseQuery(Sender: TObject;
      var CanClose: Boolean);
    procedure poDocumentNamesClick(Sender: TObject);
    procedure poDocumentTextsClick(Sender: TObject);
   protected
    procedure WMWinIniChange(var aMessage: TMessage); message WM_WININICHANGE;
      {-}
    procedure UpdateState; override;
      {-}
    function  UpdatePrintersList: Boolean; override;
      {-}
    procedure UpdateSuperKind(aKind: TnsSuperPreviewKind);
      {-}
  end;//Ten_PrintDialog

implementation

uses
  WinSpool,
  StdRes,
  Math,
  l3PrinterInterfaces
  ;

{$R *.DFM}

procedure Ten_PrintDialog.SettingsButtonClick(Sender: TObject);
var
 l_pDM         : PDeviceMode;
 l_Device,
 l_Driver,
 l_Port        : Array[0..255] of Char;
 l_hPrinter,
 l_hDeviceMode : THandle;
 l_NeedUpdate  : Bool;
 l_Printer     : Il3Printer;
begin
 if (f_Preview <> nil) then
 begin
  l_Printer := f_Preview.Printer;
  l_Printer.PrinterIndex := cbPrinter.ItemIndex;
  l_Printer.Copies := edCopyCount.AsInteger;
  l_Printer.Collate := CollateCheckBox.Checked;
  {$If not defined(Admin) AND not defined(Monitorings)}
  TdmStdRes.ToPrinterSettings(f_Preview.Printer);
  {$IfEnd}
  l_NeedUpdate := false;
 //Получаем данные о принтере
  l_Printer := f_Preview.Printer;
  if (l_Printer <> nil) then
  begin
   l_Printer.GetPrinter(l_Device, l_Driver, l_Port, l_hDeviceMode);
//Открываем принтер и получаем его дескриптор
   if OpenPrinter(l_Device, l_hPrinter, nil) then
    try
//Получаем указатель на структуру DEVMODE}
     l_pDM := GlobalLock(l_hDeviceMode);
     try
//Собственно вызываем диалоговое окно
      if (IDOK = DocumentProperties(
       Self.Handle,
       l_hPrinter,
       l_Device,
       l_pDM^,
       l_pDM^,
       DM_IN_BUFFER or DM_OUT_BUFFER or DM_IN_PROMPT)) then
      begin
//Отправляем настройки обратно в принтер
       l_Printer.SetPrinter(l_Device, l_Driver, l_Port, l_hDeviceMode);
//Сохраняем настройки
       l_NeedUpdate := true;
      end;//IDOK = DocumentProperties
     finally
      GlobalUnlock(l_hDeviceMode);
     end;//try..finally
    finally
     ClosePrinter(l_hPrinter);
    end;//try..finally
    if l_NeedUpdate then
    begin
     // http://mdp.garant.ru/pages/viewpage.action?pageId=621474995
     edCopyCount.AsInteger := l_Printer.Copies;
     CollateCheckBox.Checked := l_Printer.Collate;
     // http://mdp.garant.ru/pages/viewpage.action?pageId=621474995
    {$If not defined(Admin) AND not defined(Monitorings)}
     TdmStdRes.FromPrinterSettings(f_Preview.Printer);
    {$IfEnd}
     f_Preview.Printer.Orientation := l3_poPortrait;
    end;
  end;//l_Printer <> nil
  ManualUpdateActions;
 end;//f_Preview <> nil
end;

procedure Ten_PrintDialog.WMWinIniChange(var aMessage: TMessage);
begin
 inherited;
 UpdateState;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=622825943
end;

procedure Ten_PrintDialog.UpdateState;
var
 l_OK      : Boolean;
 l_Preview : IafwComplexDocumentPreview;
 l_SuperPreview: InsSuperComplexDocumentPreview;
 l_NotTiny: Boolean;
begin
 if Supports(f_Preview, InsSuperComplexDocumentPreview, l_SuperPreview) then
 begin
  poDocumentNames.Checked := l_SuperPreview.SuperContentKind = ns_spkDocumentTitles;
  poDocumentNames.Enabled := l_SuperPreview.DocumentTexts <> nil;
  poDocumentTexts.Checked := l_SuperPreview.SuperContentKind = ns_spkDocumentTexts;
  poDocumentTexts.Enabled := l_SuperPreview.DocumentTexts <> nil;
 end
 else
 begin
  poDocumentNames.Checked := False;
  poDocumentNames.Enabled := False;
  poDocumentTexts.Checked := True;
  poDocumentTexts.Enabled := False;
 end;

 rbPrintAll.Enabled := false;
 rbPrintSelected.Enabled := false;
 rbPrintInterval.Enabled := false;
 edPrintInterval.Enabled := false;
 cbOddEven.Enabled := false;
 cbOddEven.ItemIndex := 0;
 rbPrintCurrent.Enabled := false;
 cbPrintInfo.Enabled := false;
 cbPrintInfo.Checked := false;

 if (f_Preview <> nil) AND f_Preview.Printer.HasPrinter then
 begin
  edCopyCount.AsInteger := f_Preview.Printer.Copies;
  CollateCheckBox.Checked := f_Preview.Printer.Collate;
 end;//(f_Preview <> nil) AND f_Preview.Printer.HasPrinter
 
 l_OK := UpdatePrintersList;
 if l_Ok AND (f_Preview <> nil) AND f_Preview.Printer.HasPrinter then
 begin
  l_notTiny := not Supports(f_Preview, InsTinyPreview);
  rbPrintAll.Enabled := l_notTiny;
  rbPrintAll.Checked := true;
  // - типа хотим печатать весь документ
  cbOddEven.Enabled := l_notTiny;
  lbOddEven.Enabled := l_notTiny;
  // - можно выбрать четные/нечетные
  cbPrinter.ItemIndex := f_Preview.Printer.PrinterIndex;
  // - выставляем принтер, на который печатали в прошлый раз
  rbPrintInterval.Enabled := l_notTiny;
  edPrintInterval.Enabled := l_notTiny;
  // - можно печатать диапазон страниц
  rbPrintCurrent.Enabled := l_notTiny and f_Preview.HasCurrentPage;
  // - можно печатать текущую страницу
  if l_notTiny and Supports(f_Preview, IafwComplexDocumentPreview, l_Preview) then
   try
    rbPrintSelected.Enabled := (l_Preview.Selection <> nil);
    rbPrintSelected.Checked := (l_Preview.Selection = l_Preview.Current);
    rbPrintCurrent.Enabled := (l_Preview.Document <> nil) and l_Preview.Document.HasCurrentPage;
    cbPrintInfo.Enabled := (l_Preview.Info <> nil);
   finally
    l_Preview := nil;
   end//try..finally
  else
   rbPrintCurrent.Enabled := l_notTiny and f_Preview.HasCurrentPage;
 end;//l_Ok AND (f_Preview <> nil)
end;

function Ten_PrintDialog.UpdatePrintersList: Boolean;
var
 i               : Integer;
 l_PrintersCount : Integer;
 l_ActivePrinter : Integer;
 l_Printer       : Il3Printer;
begin
 Result := false;
 if (f_Preview <> nil) then
 begin
  if cbPrinter.Items.Count > 0 then
   l_ActivePrinter := cbPrinter.ItemIndex
  else
   l_ActivePrinter := -1;
  cbPrinter.Items.Clear;
  l_Printer := f_Preview.Printer;
  if (l_Printer <> nil) then
  begin
   l_Printer.Refresh;
   l_PrintersCount := l_Printer.Printers.Count;
   if (l_PrintersCount > 0) then
   begin
    if (l_ActivePrinter < 0) or (l_ActivePrinter >= l_PrintersCount) then
     l_ActivePrinter := l_Printer.PrinterIndex;
    for i := 0 to l_PrintersCount - 1 do
     cbPrinter.Items.Add(l_Printer.Printers.Strings[i]);
    cbPrinter.ItemIndex := Math.Min(l_ActivePrinter, cbPrinter.Items.Count - 1);
    cbPrinter.Enabled := true;      
    SettingsButton.Enabled := true;
    Result := true;
   end;//l_PrintersCount > 0
  end;//l_Printer <> nil
 end;//f_Preview <> nil
 if not Result then
 begin
  cbPrinter.Items.Add(vcmConstString(str_plPrinterAbsent));
  cbPrinter.ItemIndex := 0;
  cbPrinter.Enabled := false;
  SettingsButton.Enabled := false;
 end;//not Result
end;

procedure Ten_PrintDialog.CollateCheckBoxClick(Sender: TObject);
begin
 CollatePaintBox.Invalidate;
end;

procedure Ten_PrintDialog.CollatePaintBoxPaint(Sender: TObject);
var
 n : Integer;
begin
 if (CollateCheckBox.Checked) then
  n := 1
 else
  n := 0;
 CollateImageList.Draw(CollatePaintBox.Canvas, 0, 0, n);
end;

procedure Ten_PrintDialog.edPrintIntervalChange(Sender: TObject);
begin
 if not rbPrintInterval.Checked then
  rbPrintInterval.Checked := true;
end;

procedure Ten_PrintDialog.edPrintIntervalKeyPress(Sender: TObject;
  var Key: Char);
begin
  with edPrintInterval do
    case Key of
      #8,//backspace
      '0'..'9',
      ',',
      '-',
      ' '{,
      c_InfoPrefix}:;
      else
        Key := #0;
    end;
end;

procedure Ten_PrintDialog.vcmEntityFormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 if CanClose AND (f_Preview <> nil) AND f_Preview.InProcess then
 begin
  CanClose := false;
  f_Preview.Stop(Handle);
 end;//CanClose
end;

procedure Ten_PrintDialog.poDocumentNamesClick(Sender: TObject);
begin
 UpdateSuperKind(ns_spkDocumentTitles);
end;

procedure Ten_PrintDialog.poDocumentTextsClick(Sender: TObject);
begin
 UpdateSuperKind(ns_spkDocumentTexts);
end;

procedure Ten_PrintDialog.UpdateSuperKind(aKind: TnsSuperPreviewKind);
var
 l_SuperPreview: InsSuperComplexDocumentPreview;
begin
 if Supports(f_Preview, InsSuperComplexDocumentPreview, l_SuperPreview) then
 begin
  l_SuperPreview.SuperContentKind := aKind;
  UpdateState;
 end;
end;

end.

