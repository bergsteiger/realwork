unit nsQuestions;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\nsQuestions.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsQuestions" MUID: (4F9A9C6803D4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
 , l3MessageID
;

const
 {* Локализуемые строки Asks }
 str_DocumentEMailSelection_CheckCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentEMailSelection_CheckCaption'; rValue : 'Всегда пересылать выделенный фрагмент');
  {* 'Всегда пересылать выделенный фрагмент' }
 str_DocumentEMailSelection_SettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentEMailSelection_SettingsCaption'; rValue : 'Пересылка по EMail');
  {* 'Пересылка по EMail' }
 str_DocumentEMailSelection_LongHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentEMailSelection_LongHint'; rValue : 'Подтверждение при пересылке выделенного фрагмента');
  {* 'Подтверждение при пересылке выделенного фрагмента' }
 str_ListEMailSelection_CheckCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListEMailSelection_CheckCaption'; rValue : 'Всегда пересылать выделенные элементы ');
  {* 'Всегда пересылать выделенные элементы ' }
 str_ListEMailSelection_SettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListEMailSelection_SettingsCaption'; rValue : 'Пересылка по EMail');
  {* 'Пересылка по EMail' }
 str_ListEMailSelection_LongHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListEMailSelection_LongHint'; rValue : 'Подтверждение при пересылке выделенных элементов');
  {* 'Подтверждение при пересылке выделенных элементов' }
 str_ListPrintSelectedConfirmation_CheckCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListPrintSelectedConfirmation_CheckCaption'; rValue : 'Всегда печатать выделенные элементы');
  {* 'Всегда печатать выделенные элементы' }
 str_ListPrintSelectedConfirmation_SettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListPrintSelectedConfirmation_SettingsCaption'; rValue : 'Печать');
  {* 'Печать' }
 str_ListPrintSelectedConfirmation_LongHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListPrintSelectedConfirmation_LongHint'; rValue : 'Подтверждение при печати выделенных элементов');
  {* 'Подтверждение при печати выделенных элементов' }
 str_PrintSelectedConfirmation_CheckCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintSelectedConfirmation_CheckCaption'; rValue : 'Всегда печатать выделенный фрагмент');
  {* 'Всегда печатать выделенный фрагмент' }
 str_PrintSelectedConfirmation_SettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintSelectedConfirmation_SettingsCaption'; rValue : 'Печать');
  {* 'Печать' }
 str_PrintSelectedConfirmation_LongHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintSelectedConfirmation_LongHint'; rValue : 'Подтверждение при печати выделенного фрагмента');
  {* 'Подтверждение при печати выделенного фрагмента' }
 str_ExportSelectionToWord_CheckCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ExportSelectionToWord_CheckCaption'; rValue : 'Всегда экспортировать выделенный фрагмент');
  {* 'Всегда экспортировать выделенный фрагмент' }
 str_ExportSelectionToWord_SettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ExportSelectionToWord_SettingsCaption'; rValue : 'Экспорт в MS-Word');
  {* 'Экспорт в MS-Word' }
 str_ExportSelectionToWord_LongHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ExportSelectionToWord_LongHint'; rValue : 'Подтверждение при открытии в MS-Word выделенного фрагмента');
  {* 'Подтверждение при открытии в MS-Word выделенного фрагмента' }
 str_ListExportSelectionToWord_CheckCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListExportSelectionToWord_CheckCaption'; rValue : 'Всегда экспортировать выделенные элементы');
  {* 'Всегда экспортировать выделенные элементы' }
 str_ListExportSelectionToWord_SettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListExportSelectionToWord_SettingsCaption'; rValue : 'Экспорт в MS-Word');
  {* 'Экспорт в MS-Word' }
 str_ListExportSelectionToWord_LongHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListExportSelectionToWord_LongHint'; rValue : 'Подтверждение при открытии в MS-Word выделенных элементов');
  {* 'Подтверждение при открытии в MS-Word выделенных элементов' }
 str_DocumentEMailSelection: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'DocumentEMailSelection'; rValue : 'Переслать по E-mail:');
  {* 'Переслать по E-mail:' }
 str_ListEMailSelection: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ListEMailSelection'; rValue : 'Пересылка по EMail');
  {* 'Пересылка по EMail' }
 str_ListPrintSelectedConfirmation: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ListPrintSelectedConfirmation'; rValue : 'Печатать:');
  {* 'Печатать:' }
 str_PrintSelectedConfirmation: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'PrintSelectedConfirmation'; rValue : 'Печатать:');
  {* 'Печатать:' }
 str_ExportSelectionToWord: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ExportSelectionToWord'; rValue : 'Экспортировать в MS-Word');
  {* 'Экспортировать в MS-Word' }
 str_ListExportSelectionToWord: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ListExportSelectionToWord'; rValue : 'Экспортировать в MS-Word:');
  {* 'Экспортировать в MS-Word:' }
 str_ConsultDocumentsNotFound: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ConsultDocumentsNotFound'; rValue : 'Информация по данному запросу отсутствует в установленном у Вас комплекте.');
  {* 'Информация по данному запросу отсутствует в установленном у Вас комплекте.' }
 str_ConsultDocumentsNotFoundNoSpec: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ConsultDocumentsNotFoundNoSpec'; rValue : 'Информация по данному запросу отсутствует в установленном у Вас комплекте.');
  {* 'Информация по данному запросу отсутствует в установленном у Вас комплекте.' }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
;

const
 {* Варианты выбора для диалога DocumentEMailSelection }
 str_DocumentEMailSelection_Choice_Selection: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentEMailSelection_Choice_Selection'; rValue : 'Выделенный фрагмент');
  {* 'Выделенный фрагмент' }
 str_DocumentEMailSelection_Choice_WholeDocument: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentEMailSelection_Choice_WholeDocument'; rValue : 'Документ целиком');
  {* 'Документ целиком' }
 {* Варианты выбора для диалога ListEMailSelection }
 str_ListEMailSelection_Choice_Selected: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListEMailSelection_Choice_Selected'; rValue : 'Выделенные элементы');
  {* 'Выделенные элементы' }
 str_ListEMailSelection_Choice_WholeList: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListEMailSelection_Choice_WholeList'; rValue : 'Список целиком');
  {* 'Список целиком' }
 {* Варианты выбора для диалога ListPrintSelectedConfirmation }
 str_ListPrintSelectedConfirmation_Choice_Selected: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListPrintSelectedConfirmation_Choice_Selected'; rValue : 'Выделенные элементы');
  {* 'Выделенные элементы' }
 str_ListPrintSelectedConfirmation_Choice_WholeList: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListPrintSelectedConfirmation_Choice_WholeList'; rValue : 'Список целиком');
  {* 'Список целиком' }
 {* Варианты выбора для диалога PrintSelectedConfirmation }
 str_PrintSelectedConfirmation_Choice_Selected: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintSelectedConfirmation_Choice_Selected'; rValue : 'Выделенный фрагмент');
  {* 'Выделенный фрагмент' }
 str_PrintSelectedConfirmation_Choice_WholeDocument: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintSelectedConfirmation_Choice_WholeDocument'; rValue : 'Документ целиком');
  {* 'Документ целиком' }
 {* Варианты выбора для диалога ExportSelectionToWord }
 str_ExportSelectionToWord_Choice_Selected: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ExportSelectionToWord_Choice_Selected'; rValue : 'Выделенный фрагмент');
  {* 'Выделенный фрагмент' }
 str_ExportSelectionToWord_Choice_WholeDocument: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ExportSelectionToWord_Choice_WholeDocument'; rValue : 'Документ целиком');
  {* 'Документ целиком' }
 {* Варианты выбора для диалога ListExportSelectionToWord }
 str_ListExportSelectionToWord_Choice_Selected: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListExportSelectionToWord_Choice_Selected'; rValue : 'Выделенные элементы');
  {* 'Выделенные элементы' }
 str_ListExportSelectionToWord_Choice_WholeList: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListExportSelectionToWord_Choice_WholeList'; rValue : 'Список целиком');
  {* 'Список целиком' }
 {* Варианты выбора для диалога ConsultDocumentsNotFound }
 str_ConsultDocumentsNotFound_Choice_Spec: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ConsultDocumentsNotFound_Choice_Spec'; rValue : 'Обратиться к специалистам Правовой поддержки онлайн');
  {* 'Обратиться к специалистам Правовой поддержки онлайн' }
 str_ConsultDocumentsNotFound_Choice_Back: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ConsultDocumentsNotFound_Choice_Back'; rValue : 'Вернуться в карточку и изменить условия запроса');
  {* 'Вернуться в карточку и изменить условия запроса' }
 {* Варианты выбора для диалога ConsultDocumentsNotFoundNoSpec }
 str_ConsultDocumentsNotFoundNoSpec_Choice_Back: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ConsultDocumentsNotFoundNoSpec_Choice_Back'; rValue : 'Вернуться в карточку и изменить условия запроса');
  {* 'Вернуться в карточку и изменить условия запроса' }

initialization
 str_DocumentEMailSelection_CheckCaption.Init;
 {* Инициализация str_DocumentEMailSelection_CheckCaption }
 str_DocumentEMailSelection_SettingsCaption.Init;
 {* Инициализация str_DocumentEMailSelection_SettingsCaption }
 str_DocumentEMailSelection_LongHint.Init;
 {* Инициализация str_DocumentEMailSelection_LongHint }
 str_ListEMailSelection_CheckCaption.Init;
 {* Инициализация str_ListEMailSelection_CheckCaption }
 str_ListEMailSelection_SettingsCaption.Init;
 {* Инициализация str_ListEMailSelection_SettingsCaption }
 str_ListEMailSelection_LongHint.Init;
 {* Инициализация str_ListEMailSelection_LongHint }
 str_ListPrintSelectedConfirmation_CheckCaption.Init;
 {* Инициализация str_ListPrintSelectedConfirmation_CheckCaption }
 str_ListPrintSelectedConfirmation_SettingsCaption.Init;
 {* Инициализация str_ListPrintSelectedConfirmation_SettingsCaption }
 str_ListPrintSelectedConfirmation_LongHint.Init;
 {* Инициализация str_ListPrintSelectedConfirmation_LongHint }
 str_PrintSelectedConfirmation_CheckCaption.Init;
 {* Инициализация str_PrintSelectedConfirmation_CheckCaption }
 str_PrintSelectedConfirmation_SettingsCaption.Init;
 {* Инициализация str_PrintSelectedConfirmation_SettingsCaption }
 str_PrintSelectedConfirmation_LongHint.Init;
 {* Инициализация str_PrintSelectedConfirmation_LongHint }
 str_ExportSelectionToWord_CheckCaption.Init;
 {* Инициализация str_ExportSelectionToWord_CheckCaption }
 str_ExportSelectionToWord_SettingsCaption.Init;
 {* Инициализация str_ExportSelectionToWord_SettingsCaption }
 str_ExportSelectionToWord_LongHint.Init;
 {* Инициализация str_ExportSelectionToWord_LongHint }
 str_ListExportSelectionToWord_CheckCaption.Init;
 {* Инициализация str_ListExportSelectionToWord_CheckCaption }
 str_ListExportSelectionToWord_SettingsCaption.Init;
 {* Инициализация str_ListExportSelectionToWord_SettingsCaption }
 str_ListExportSelectionToWord_LongHint.Init;
 {* Инициализация str_ListExportSelectionToWord_LongHint }
 str_DocumentEMailSelection.Init;
 str_DocumentEMailSelection.AddChoice(str_DocumentEMailSelection_Choice_Selection);
 str_DocumentEMailSelection.AddChoice(str_DocumentEMailSelection_Choice_WholeDocument);
 str_DocumentEMailSelection.AddDefaultChoice(str_DocumentEMailSelection_Choice_Selection);
 str_DocumentEMailSelection.SetNeedCheck(true);
 str_DocumentEMailSelection.SetCheckCaption(str_DocumentEMailSelection_CheckCaption);
 str_DocumentEMailSelection.SetSettingsCaption(str_DocumentEMailSelection_SettingsCaption);
 str_DocumentEMailSelection.SetLongHint(str_DocumentEMailSelection_LongHint);
 str_DocumentEMailSelection.SetDlgType(mtConfirmation);
 {* Инициализация str_DocumentEMailSelection }
 str_ListEMailSelection.Init;
 str_ListEMailSelection.AddChoice(str_ListEMailSelection_Choice_Selected);
 str_ListEMailSelection.AddChoice(str_ListEMailSelection_Choice_WholeList);
 str_ListEMailSelection.AddDefaultChoice(str_ListEMailSelection_Choice_Selected);
 str_ListEMailSelection.SetNeedCheck(true);
 str_ListEMailSelection.SetCheckCaption(str_ListEMailSelection_CheckCaption);
 str_ListEMailSelection.SetSettingsCaption(str_ListEMailSelection_SettingsCaption);
 str_ListEMailSelection.SetLongHint(str_ListEMailSelection_LongHint);
 str_ListEMailSelection.SetDlgType(mtConfirmation);
 {* Инициализация str_ListEMailSelection }
 str_ListPrintSelectedConfirmation.Init;
 str_ListPrintSelectedConfirmation.AddChoice(str_ListPrintSelectedConfirmation_Choice_Selected);
 str_ListPrintSelectedConfirmation.AddChoice(str_ListPrintSelectedConfirmation_Choice_WholeList);
 str_ListPrintSelectedConfirmation.AddDefaultChoice(str_ListPrintSelectedConfirmation_Choice_Selected);
 str_ListPrintSelectedConfirmation.SetNeedCheck(true);
 str_ListPrintSelectedConfirmation.SetCheckCaption(str_ListPrintSelectedConfirmation_CheckCaption);
 str_ListPrintSelectedConfirmation.SetSettingsCaption(str_ListPrintSelectedConfirmation_SettingsCaption);
 str_ListPrintSelectedConfirmation.SetLongHint(str_ListPrintSelectedConfirmation_LongHint);
 str_ListPrintSelectedConfirmation.SetDlgType(mtConfirmation);
 {* Инициализация str_ListPrintSelectedConfirmation }
 str_PrintSelectedConfirmation.Init;
 str_PrintSelectedConfirmation.AddChoice(str_PrintSelectedConfirmation_Choice_Selected);
 str_PrintSelectedConfirmation.AddChoice(str_PrintSelectedConfirmation_Choice_WholeDocument);
 str_PrintSelectedConfirmation.AddDefaultChoice(str_PrintSelectedConfirmation_Choice_Selected);
 str_PrintSelectedConfirmation.SetNeedCheck(true);
 str_PrintSelectedConfirmation.SetCheckCaption(str_PrintSelectedConfirmation_CheckCaption);
 str_PrintSelectedConfirmation.SetSettingsCaption(str_PrintSelectedConfirmation_SettingsCaption);
 str_PrintSelectedConfirmation.SetLongHint(str_PrintSelectedConfirmation_LongHint);
 str_PrintSelectedConfirmation.SetDlgType(mtConfirmation);
 {* Инициализация str_PrintSelectedConfirmation }
 str_ExportSelectionToWord.Init;
 str_ExportSelectionToWord.AddChoice(str_ExportSelectionToWord_Choice_Selected);
 str_ExportSelectionToWord.AddChoice(str_ExportSelectionToWord_Choice_WholeDocument);
 str_ExportSelectionToWord.AddDefaultChoice(str_ExportSelectionToWord_Choice_Selected);
 str_ExportSelectionToWord.SetNeedCheck(true);
 str_ExportSelectionToWord.SetCheckCaption(str_ExportSelectionToWord_CheckCaption);
 str_ExportSelectionToWord.SetSettingsCaption(str_ExportSelectionToWord_SettingsCaption);
 str_ExportSelectionToWord.SetLongHint(str_ExportSelectionToWord_LongHint);
 str_ExportSelectionToWord.SetDlgType(mtConfirmation);
 {* Инициализация str_ExportSelectionToWord }
 str_ListExportSelectionToWord.Init;
 str_ListExportSelectionToWord.AddChoice(str_ListExportSelectionToWord_Choice_Selected);
 str_ListExportSelectionToWord.AddChoice(str_ListExportSelectionToWord_Choice_WholeList);
 str_ListExportSelectionToWord.AddDefaultChoice(str_ListExportSelectionToWord_Choice_Selected);
 str_ListExportSelectionToWord.SetNeedCheck(true);
 str_ListExportSelectionToWord.SetCheckCaption(str_ListExportSelectionToWord_CheckCaption);
 str_ListExportSelectionToWord.SetSettingsCaption(str_ListExportSelectionToWord_SettingsCaption);
 str_ListExportSelectionToWord.SetLongHint(str_ListExportSelectionToWord_LongHint);
 str_ListExportSelectionToWord.SetDlgType(mtConfirmation);
 {* Инициализация str_ListExportSelectionToWord }
 str_ConsultDocumentsNotFound.Init;
 str_ConsultDocumentsNotFound.AddChoice(str_ConsultDocumentsNotFound_Choice_Spec);
 str_ConsultDocumentsNotFound.AddChoice(str_ConsultDocumentsNotFound_Choice_Back);
 str_ConsultDocumentsNotFound.AddCustomChoice(str_ConsultDocumentsNotFound_Choice_Spec);
 str_ConsultDocumentsNotFound.SetDlgType(mtWarning);
 {* Инициализация str_ConsultDocumentsNotFound }
 str_ConsultDocumentsNotFoundNoSpec.Init;
 str_ConsultDocumentsNotFoundNoSpec.AddChoice(str_ConsultDocumentsNotFoundNoSpec_Choice_Back);
 str_ConsultDocumentsNotFoundNoSpec.SetDlgType(mtWarning);
 {* Инициализация str_ConsultDocumentsNotFoundNoSpec }
 str_DocumentEMailSelection_Choice_Selection.Init;
 {* Инициализация str_DocumentEMailSelection_Choice_Selection }
 str_DocumentEMailSelection_Choice_WholeDocument.Init;
 {* Инициализация str_DocumentEMailSelection_Choice_WholeDocument }
 str_ListEMailSelection_Choice_Selected.Init;
 {* Инициализация str_ListEMailSelection_Choice_Selected }
 str_ListEMailSelection_Choice_WholeList.Init;
 {* Инициализация str_ListEMailSelection_Choice_WholeList }
 str_ListPrintSelectedConfirmation_Choice_Selected.Init;
 {* Инициализация str_ListPrintSelectedConfirmation_Choice_Selected }
 str_ListPrintSelectedConfirmation_Choice_WholeList.Init;
 {* Инициализация str_ListPrintSelectedConfirmation_Choice_WholeList }
 str_PrintSelectedConfirmation_Choice_Selected.Init;
 {* Инициализация str_PrintSelectedConfirmation_Choice_Selected }
 str_PrintSelectedConfirmation_Choice_WholeDocument.Init;
 {* Инициализация str_PrintSelectedConfirmation_Choice_WholeDocument }
 str_ExportSelectionToWord_Choice_Selected.Init;
 {* Инициализация str_ExportSelectionToWord_Choice_Selected }
 str_ExportSelectionToWord_Choice_WholeDocument.Init;
 {* Инициализация str_ExportSelectionToWord_Choice_WholeDocument }
 str_ListExportSelectionToWord_Choice_Selected.Init;
 {* Инициализация str_ListExportSelectionToWord_Choice_Selected }
 str_ListExportSelectionToWord_Choice_WholeList.Init;
 {* Инициализация str_ListExportSelectionToWord_Choice_WholeList }
 str_ConsultDocumentsNotFound_Choice_Spec.Init;
 {* Инициализация str_ConsultDocumentsNotFound_Choice_Spec }
 str_ConsultDocumentsNotFound_Choice_Back.Init;
 {* Инициализация str_ConsultDocumentsNotFound_Choice_Back }
 str_ConsultDocumentsNotFoundNoSpec_Choice_Back.Init;
 {* Инициализация str_ConsultDocumentsNotFoundNoSpec_Choice_Back }

end.
