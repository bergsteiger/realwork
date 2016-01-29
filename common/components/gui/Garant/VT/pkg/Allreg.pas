unit Allreg;

{ $Id: Allreg.pas,v 1.62 2015/06/19 05:19:54 fireton Exp $ }

// $Log: Allreg.pas,v $
// Revision 1.62  2015/06/19 05:19:54  fireton
// - не собиралось
//
// Revision 1.61  2015/05/29 11:53:47  kostitsin
// no message
//
// Revision 1.60  2015/04/24 14:54:18  lulin
// - правильный define.
//
// Revision 1.59  2015/04/24 14:25:46  kostitsin
// no message
//
// Revision 1.58  2014/07/01 12:04:59  lulin
// - пытаемся собрать несобирающееся.
//
// Revision 1.57  2013/01/28 12:01:02  lulin
// - изыскания по NoVCM.
//
// Revision 1.56  2012/04/06 15:20:05  lulin
// {RequestLink:237994598}
//
// Revision 1.55  2009/09/03 06:52:35  oman
// - new: Зачистка - {RequestLink:159369920}
//
// Revision 1.54  2009/08/13 10:55:02  lulin
// - чистка кода.
//
// Revision 1.53  2009/03/23 15:09:04  lulin
// [$139442655]. Переименовываем файл.
//
// Revision 1.52  2009/03/23 14:54:22  lulin
// [$139442655]. Переименовываем новый контрол.
//
// Revision 1.51  2009/03/23 14:40:21  lulin
// [$139442655]. Убиваем старый контрол.
//
// Revision 1.50  2009/03/17 07:32:18  oman
// - fix: Заготовки контрола (К-137463980)
//
// Revision 1.49  2009/01/26 12:50:49  fireton
// - TvtCheckBox
//
// Revision 1.48  2008/07/25 04:32:54  mmorozov
// - new: опубликован компонент для показа flash;
//
// Revision 1.47  2008/07/22 10:41:16  mmorozov
// - new: компонент-переключатель (K<103940871>);
//
// Revision 1.46  2008/05/28 06:52:23  mmorozov
// - new: опубликован TvtDblClickDateEdit;
//
// Revision 1.45  2008/01/23 13:18:07  oman
// - new: Новый компонент vtProportionalPanel (cq24598)
//
// Revision 1.44  2007/12/12 07:45:26  voba
// no message
//
// Revision 1.43  2007/12/11 13:58:31  voba
// no message
//
// Revision 1.42  2007/12/05 10:37:55  lulin
// - компонент-времянка.
//
// Revision 1.41  2007/07/19 14:17:19  fireton
// - TvtComboTree
//
// Revision 1.40  2007/07/11 13:27:50  fireton
// - добавлен компонент - кнопка для редактора формул
//
// Revision 1.39  2007/04/12 06:34:18  oman
// - fix: Более правильное свойство для vtReminger.ImageIndex
//
// Revision 1.38  2007/03/29 17:02:39  lulin
// - отделяем мух от котлет.
//
// Revision 1.37  2007/03/20 10:46:32  lulin
// - регистрируем родной диалог сохранения.
// - используем строки с кодировкой.
//
// Revision 1.36  2006/12/15 11:37:18  lulin
// - удален ненужный модуль.
//
// Revision 1.35  2005/11/30 13:08:19  voba
// no message
//
// Revision 1.34  2005/08/11 09:10:22  voba
// no message
//
// Revision 1.33  2005/06/09 10:27:01  mmorozov
// new: регистрация _TvtReminder, _TvtRemindersLine;
//
// Revision 1.32  2005/06/09 09:49:02  mmorozov
// new: регистрация _TvtComboBoxQS, TvtNavigator;
//
// Revision 1.31  2005/05/30 13:02:24  lulin
// - new unit: vtStringLister.
//

interface

Procedure Register;

{$R *.res}

implementation

uses
  Classes,
  imgList,
  DesignIntf,
  DesignEditors,

  vtDirector,{Directory Navigator}
  TextSrch, {BM Text File Search}
  vtOutliner,
  vtLister,
  vtStringLister,
  vtHideField,
  vtCalendarPanel,
  w95Meter,
  vtCombo,
  vtDateEdit,
  vtSpin,
  vtGrids,
  vtHeader,
  BackPnl,
  vtCtrls,
  ADVMenus,
  ActnList,
  vtMenus,
  vtStatusBar,
  vtSizeablePanel,
  vtBndLabel,
  vtGradientWaitbar,
  vtShockwaveEx,
      
  vtForm,
  vtPropEditors,

  vtPngImgList,
  vtPngImgListCEditor,
  vtSpeedButton,
  vtTreeSource,
  vtGroupBox,
  vtGroupBoxEx,
  vtLabel,
  vtButton,
  {$IfNDef NoVCM}
  vtNavigator,
  {$EndIf  NoVCM}
  vtComboBoxQS,
  {$IfNDef NoVGScene}
  //vtRemindersLine,
  //vtReminder,
  {$EndIf  NoVGScene}
  vtSaveDialog,
  vtFocusLabel,
  vtImageForm,
  vtRadioButton,
  vtCheckBox,
  vtDblClickDateEdit,

  vtComboTree,
  vtColorBox,
  vtProportionalPanel,

  ExprEditControls
  ;

type
 TvtFrameModule = class(TCustomModule)
  public
   function Nestable: Boolean; override;
  end;

 function TvtFrameModule.Nestable: Boolean;
 begin
  Result := True;
 end;

const
 vtPage = 'VoBa';

procedure Register;
begin
 //RegisterComponents(vtPage, [TvtReminder]);
 //RegisterComponents(vtPage, [TvtRemindersLine]);
 RegisterComponents(vtPage, [TvtComboBoxQS]);
// RegisterComponents(vtPage, [TvtNavigator]);
 RegisterComponents(vtPage, [TvtDirNavigator]);
 RegisterComponents(vtPage, [TvtTreeSource]);
 RegisterComponents(vtPage, [TvtOutliner]);
 RegisterComponents(vtPage, [TvtSimpleComboEdit]);
 RegisterComponents(vtPage, [TvtComboEdit, TvtDateEdit]);
 RegisterComponents(vtPage, [TvtComboEdit, TvtDblClickDateEdit]);
 RegisterComponents(vtPage, [TvtSpinEdit]);
 RegisterComponents(vtPage, [TvtStringGrid]);

 RegisterComponents(vtPage, [TvtHideField]);
 RegisterComponents(vtPage, [TvtLister,TvtDStringLister]);
 RegisterComponents(vtPage, [TvtStringLister]);
 RegisterComponents(vtPage, [TvtDataLister]);
 RegisterComponents(vtPage, [TvtIStrListLister]);

 RegisterComponents(vtPage, [TVEdit, TvtComboBox]);
 RegisterComponents(vtPage, [TvtSpeedButton]);
 RegisterComponents(vtPage, [TW95Meter]);
 RegisterComponents(vtPage, [TvtSplitter]);

 RegisterComponents(vtPage, [TvtImage]);
 RegisterComponents(vtPage, [TvtGroupBox]);
 RegisterComponents(vtPage, [TvtGroupBoxEx]);
 RegisterComponents(vtPage, [TvtLabel]);
 RegisterComponents(vtPage, [TvtButton]);
 RegisterComponents(vtPage, [TvtHeader]);
 RegisterComponents(vtPage, [TvtSizeablePanel]);
 RegisterComponents(vtPage, [TvtProportionalPanel]);
 RegisterComponents(vtPage, [TvtBoundedLabel]);
 RegisterComponents(vtPage, [TvtGradientWaitbar]);
 RegisterComponents(vtPage, [TvtRadioButton]);
 RegisterComponents(vtPage, [TvtShockwaveFlashEx]);
 RegisterComponents(vtPage, [TvtCheckBox]);

 RegisterComponents(vtPage, [TBackPanel]);
 RegisterComponents(vtPage, [TMDIBackground]);
 RegisterComponents(vtPage, [TvtCalendarPanel]);
 RegisterComponents(vtPage, [TFontSizeComboBox]);
 RegisterComponents(vtPage, [TSpeedBarComboBox]);

 RegisterComponents(vtPage, [TvtImageForm]);

 RegisterComponents(vtPage, [TLinkPopUpMenu]);
 RegisterComponents(vtPage, [TSystemMenuItem]);
 RegisterComponents(vtPage, [TSystemMenu]);
 RegisterComponents(vtPage, [TvtFocusLabel]);
 RegisterComponents(vtPage, [TvtSaveDialog]);

 RegisterActions('StdMsgAction', [TvtStdMsgAction], nil);

 RegisterComponents(vtPage, [TvtStatusBar, TdfsStatusBar]);

 RegisterComponents(vtPage, [TExprButton]);

 RegisterComponents(vtPage, [TvtComboTree]);

 RegisterComponents(vtPage, [TvtColorBox]);

 RegisterComponents(vtPage, [TvtPngImageList, TvtNonFixedPngImageList, TvtFixedSizeProxyPngImageList]);
 RegisterComponentEditor(TvtPngImageList, TPILEditor);
 RegisterComponentEditor(TvtNonFixedPngImageList, TNFPILEditor);

 RegisterCustomModule(TvtFrame,TvtFrameModule);
 RegisterComponentEditor(TvtStatusBar, TvtStatusBarEditor);

(*  { TvtReminder.TImageIndex }
 RegisterPropertyEditor( TypeInfo(TImageIndex),
                         TvtReminder,
                         '',
                         TvtReminderImageIndexProperty );*)

end;

end.
