unit StrShop;

{ $Id: StrShop.pas,v 1.63 2015/10/06 13:49:46 voba Exp $ }

interface
 uses
  Classes;

  Const
   sidBase  = 56000;
  {Question}
   {sidLinkQst        = sidBase + 100;}
   //sidDelQst         = sidBase + 101;
   //sidDelNumQst      = sidBase + 102;
   //sidPutHomeQst     = sidBase + 103;
   //sidPutHomeNumQst  = sidBase + 104;
   //sidLinkDocQst     = sidBase + 105;
   //sidLinkDocNumQst  = sidBase + 106;

  {Information}
   //sidDontInitInf    = sidBase + 1000;
   //sidDontOpenInf    = sidBase + 1001;
   //sidDontDelInf     = sidBase + 1002;

  {Attention}
   //sidDocAlreadyEdited = sidBase + 2000;
   //sidNoSelectItems    = sidBase + 2001;
   //sidNoSelectPrizn    = sidBase + 2002;
   //sidNoPresentPrizn   = sidBase + 2003;

  {Error}
   //sidNoActiveFamily = sidBase + 3000;

  {DataNumRecConst}
//   NumOfDNStr = 6;
//   sidFirstDataNumRec = sidBase + 4000;

  {LogJrnlTypeConst}
//   NumOfLJStr = 9;
//   sidLogJrnlType = sidBase + 4000 + NumOfDNStr;


   sidBaseII = sidBase + 4100;

  ResourceString
   sidDelQst         ='Вы действительно хотите удалить'^M'"%S"?';
   //sidDelNumQst      ='Вы действительно хотите удалить'^M'%D документов?'^C;
   //sidPutHomeQst     ='Вы действительно хотите поместить'^M'"%S" в личный каталог?'^C;
   //sidPutHomeNumQst  ='Вы действительно хотите поместить %d документов в личный катало?'^C;
   //sidLinkDocQst     ='Вы действительно хотите привязать'^M'"%S"'^M'к "%S"?'^C;
   //sidLinkDocNumQst  ='Вы действительно хотите привязать %D документов'^M'к "%S"?'^C;

   {
 sidDontInitInf, "Нет доступа к системе.\nБлокировка или отсутствие системных таблиц.\003"
 sidDontDelInf, "Не могу удалить документ\n\042%S\042\nВозможно он редактируется.\003"
 sidDontOpenInf, "Не могу открыть документ\n\042%S\042\nВозможно он уже редактируется.\003"
}

{
 sidDocAlreadyEdited, "Документ \042%S\042\nуже редактируется.\003"
 sidNoPresentPrizn, "Закладка указывает на удаленный признак.\003"
 sidNoActiveFamily, "Базы документов отсутствуют или недоступны.\003"
 sidNoSelectItems, "Нет выделенных документов.\003"
 sidNoSelectPrizn, "Нет выделенных признаков.\003"
}

   {Error}

   sidProcessDone  = 'Процесс успешно завершен.';
   sidProcessDoneFmt  = 'Процесс %s успешно завершен.';

   sidCannotAddHyperLink = 'Не удалось добавить ссылку. :(';

   sidDocumentWithNumber = 'Документ № %d';

   sidChangeGroupQst    = 'Изменить группу ключевого выражения "%S"';

   sidEWDocPlugged      = ' Документ подключен';
   sidEWDocUnPlugged    = ' Документ не подключен';
   sidEWJurUnpower      = 'Этот документ уже утратил юридическую силу.';
   sidEWOpenOtherUser   = 'Этап открыт другим пользователем.';
   sidEWNotUniq         = 'Не уникальное значение %S.';
   sidFieldEmptyErr     = 'Поле "%S" не может быть пустым.';
   sidXFieldEmptyErr    = 'Поле не может быть пустым.';
   sidCanNotBeEmpty     = '%S не может быть пустым.';
   sidNotIncludedWarning = 'Документ не подключен.'^M'Продолжить?';

   sidFindEnd           = 'Больше найденных слов нет.';
   sidNoFindAnother     = 'Искомый элемент не найден.';
   //sidNoSuchDoc         = 'Документов не найдено.';
   sidNoSuchDoc         =  'Не найдено ни одного документа.';
   sidNoSubSelected     = 'Сначала выберите метку.';
   sidNoDocPresent      = 'Документ с ID = %d отсутствует.';
   sidWrongDocID        = 'Ошибка определения внутреннего номера документа %d.';
   sidDocPresent        = 'Документ с ID = %d уже существует.';
   sidDocLoadFault      = 'Не удалось загрузить документ с ID = %d.'^M'Ошибка: %s.';
   sidMakeCopyFault     = 'Копия не создалась';
   sidEmptyReference    = 'Информация для ссылки отсутствует.';
   sidDocsAdded         = 'Добавлено %d элементов.';
   sidNotCompatibleData = 'Несовместимые типы данных.';
   sidNotValidHyperAddress = 'Недопустимый адрес гиперссылки %d.%d.';
   sidSprForbidden      = 'У документов этого типа справок не бывает';

   sidRecordIsDoublet         = 'Такая запись уже существует.';
   
   sidDoubletHyperAddress     = 'Гиперссылка уже ссылается на адрес %d.%d.';
   sidQstDelDoublet           = 'Удалить повтор?';
   sidQstContinue             = 'Продолжить?';
   sidEmptyHyperAddress       = 'Адрес гиперссылки не задан.';
   sidSetRefConfirm           = 'Вы все еще хотите установить гиперссылку?';
   sidDeleteHLinkInSelectQst  = 'Вы действительно хотите удалить все ссылки в выделенном фрагменте?';

   sidBlockInTableDeny  = 'Нельзя добавить блок в таблицу';


   sidBlockAttrWillLost = 'Атрибуты блока (RTF-копия) будут утеряны. Продолжить?';
   sidLinkedSubDelQst   = 'На метку ссылаются. Вы все равно хотите удалить ее?';
   sidLinkedDocDelQst   = 'На документ ссылаются. Вы все равно хотите удалить его?';
   sidReadOnlyText      = 'Текст открыт только на чтение.'^M+'Невозможно установить метку.';
   sidHLinkInProcess    = 'Процесс проставления ссылки не окончен.';
   sidDocNumberFmt      = '(Внутренний ID : %D, ID справки : %D)';
   sidAssMaskDeny       = 'Документ будет открыт со следующими ограничениями : ';
   sidSprAbout          = 'СПРАВКА О';
   sidSaveDocSetAsk     = 'Выборка "%S" была отредактирована.'^M'Записать?';
   sidDelDocAsk         = 'Вы действительно хотите УДАЛИТЬ документ'^M'"%S"?';
   sidDelDocSetAsk      = 'Вы действительно хотите УДАЛИТЬ выборку'^M'"%S"?';
   sidSomeDelAsk        = 'Вы действительно хотите УДАЛИТЬ %S?';
   sidDeleteDenied      = 'Удаление невозможно: %s';
   sidDocLockDeny       = 'В данный момент документ находится на редактировании.'^M+
                          'Попробуйте повторить операцию позже.';
   sidAccessDeny        = 'Нет прав доступа';

   sidWarnAddNotSure    = 'Не забудьте исправить комментарий в Периоде неуверенности в изменяемом документе';
   sidAlienSpr          = 'ID - номер существующей справки.'^M+
                          'Вы хотите связать другую справку с документом?';
   sidNonDefProp        = 'Поле "%S" не заполнено.';
   sidOverSizeProp      = 'Поле "%S" содержит слишком длинную строку.';
   sidDocIdNonDef       = 'DocID Not defined.';
   sidSprLoadError      = 'Не удалось загрузить справку.'^M+
                          'Создать новую?';

   sidNoEqItems         = 'Для "%S" эквивалентных нет.';

   sidQstDelAllBlocks   = 'Вы действительно хотите преобразовать все блоки в метки?';
   sidQstAutoClassification  = 'Вы действительно хотите отправить документы на автоклассификацию?';
   sidQstacceptAutoclasses  = 'Вы действительно хотите принять автоклассы?';

   sidQstRunSetMOJNotReg  = 'Вы действительно хотите запустить макрос "%s"';

   sidMakeRefProcess     = 'Установка ссылки : "%s"';

   sidDictItemNotLeaf    = 'Элемент словаря содержит вложенные.';

   sidDelWrongSprAsk     = 'Документ имеет справку, которая не полагается документу такого типа. Справка будет удалена.';

   sidOperationConfirm   = 'Вы действительно хотите выполнить операцию'^M'"%s"?';

   sidOp_SubNameCorrect  = 'Исправление имен меток';

   sidWrongPageDiapason  = 'Неверный диапазон страниц. Ни одна страница не попадает в диапазон.'^M'файл : "%s"';
   sidDefDiapasonErr     = 'TfrmImgViewer: ошибка в определении диапазона страниц ("%s").'^M'файл : "%s"';
   sidTIFFFormatErr      = 'Некорректный файл TIFF : "%s"';

   {Macro}
   sidMacroDocNotPublish = 'Текст %s официально опубликован не был';

   scFmtFuterCounter     = '%d из %d';
   scFmtCounter          = '(%d/%d)';
   scFmtFuterID          = 'ID = %d';
   scFmtFuterID2         = '  ID : %d (Гарант ID : %d)';

   scDocID               = 'ID документа';
   scSprID               = 'ID справки';
   scShortName           = 'Короткое название';
   scFullName            = 'Полное название';

   sidUserInputModify = 'внесены изменения';

   sidUserInputModify2 = 'В настоящий документ внесены изменения следующими документами:';

   sidUserModifyShortSrch = '(с изм. и доп. от ';
   sidUserModifyShortSrch2 = '(с изменениями и дополнениями)'; {!! смотри Dt_EditionFltr StripNameSuffix.sidUserModifyShortSrch2}
   sidUserModifyFullSrch    = '(с изменениями от ';
   sidUserModifyFullRegSrch = '\(с изменениями от .+\)';
   sidUserOldEditNamePrefix = 'Извлечения из ';

   //Все файлы|*.*|Редактор Эверест|*.evd|ANSI (Windows) текст|*.doc|OEM (DOS) текст|*.txt|Rich text format|*.rtf
   sidTXTDlgFilter = 'ANSI (Windows) текст|*.txt';
   sidLSTDlgFilter = 'Список документов|*.lst';
   sidEvdDlgFilter = 'Редактор Эверест|*.evd';
   sidTextOutDlgFilter = 'Редактор Эверест|*.evd|ANSI (Windows) текст|*.doc|OEM (DOS) текст|*.txt|Rich text format|*.rtf';
   sidDocImageDlgFilter = 'Образ документа|*.tif;*.jpg;*.gif;*.png;*.bmp;*.htm;*.html;*.xml;*.pdf;*.txt;*.chm;*.doc;*xls|Все файлы|*.*';

   sidVerLinkCycle = 'Последовательность редакций зациклена';
   sidVerLinkNonFutureEdition = 'Нарушена последовательность редакций';

   sidIDOlEditionNotDefined = 'ID документа старой редакции не задан';
   sidBadDocStructure = 'Документ поврежден. Часть данных потеряна.';
   sidAACLeftBlockNotPresent = 'Нет корреспондирующей команды для левого блока.';
   sidAACRightBlockNotPresent = 'Нет корреспондирующей команды для правого блока.';
 //function SSLoadStr(Ident: Word): string;
 //function GetAssMaskStr(aMask : Longint) : String;
 //function GetAssGroupName(piAssGroupID : integer) : String;

// procedure LoadStringList(Lst : TStrings; NumOfString : Integer; FirstID : Word);

implementation
 Uses SysUtils;

// {$R PromStr.res}
 {PromStr.rc}

(* procedure LoadStringList(Lst : TStrings; NumOfString : Integer; FirstID : Word);
  var
   I : Word;
  begin
   For I := FirstID to FirstID + Pred(NumOfString) do
    Lst.Add(LoadStr(I));
  end;

 function SSLoadStr(Ident: Word): string;
  begin
   If Ident < sidBaseII
    then LoadStr(Ident);
  end;
 *)

end.
