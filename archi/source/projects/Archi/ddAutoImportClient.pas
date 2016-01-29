Unit ddAutoImportClient;

// $Id: ddAutoImportClient.pas,v 1.15 2015/04/07 09:08:05 lukyanets Exp $ 

// $Log: ddAutoImportClient.pas,v $
// Revision 1.15  2015/04/07 09:08:05  lukyanets
// Изолируем домашний каталог
//
// Revision 1.14  2015/03/31 14:08:43  lukyanets
// Начинаем изолировать GlobalHTServer
//
// Revision 1.13  2015/01/16 11:46:14  lukyanets
// Давим паразитное сообщение
//
// Revision 1.12  2014/12/29 10:47:20  lukyanets
// Запрещаем дублирование имен
//
// Revision 1.11  2014/12/29 08:02:45  lukyanets
// Перетрахиваем код
//
// Revision 1.10  2014/09/09 05:28:37  lukyanets
// Не собиралось. Переименовали CurUserID в UserID
//
// Revision 1.9  2014/08/12 11:09:25  lukyanets
// {Requestlink:560730919}. Починили AACImport с клиента
//
// Revision 1.8  2014/08/12 10:01:20  lukyanets
// {Requestlink:560730919}. Починили AACImport с клиента
//
// Revision 1.7  2014/08/11 14:02:59  lukyanets
// {Requestlink:560730919}. Готовимся вытащить AACImport на клиента
//
// Revision 1.6  2014/08/11 10:41:21  lukyanets
// {Requestlink:560730919}. Различаем посыл с клиента и с сервера
//
// Revision 1.5  2014/08/08 10:01:42  lukyanets
// {Requestlink:560730919}. Завели alcuAACImport
//
// Revision 1.4  2014/07/11 13:57:29  lulin
// - заворачиваем SourceFiles в теги.
//
// Revision 1.3  2014/07/07 12:10:44  lulin
// - движемся к константности TaskType.
//
// Revision 1.2  2014/05/29 17:08:58  lulin
// - чистим код.
//
// Revision 1.1  2014/05/29 16:44:44  lulin
// - перекладываем проектнозависимый файл в правильное место.
//
// Revision 1.28  2014/05/29 16:40:18  lulin
// - переименовываем безликое свойство.
//
// Revision 1.27  2014/02/12 12:35:27  lulin
// - рефакторим списки заданий.
//
// Revision 1.26  2012/02/16 06:34:05  narry
// - Не собиралось
//
// Revision 1.25  2011/05/16 11:43:39  narry
// Ручной импорт "подготовленных" постановлений (266408732)
//  - Новый параметр создания задачи на импорт
//
// Revision 1.24  2010/07/14 07:31:11  narry
// - К226001558
//
// Revision 1.23  2010/02/24 10:24:24  narry
// - удаление зависимости проектов от парня
//
// Revision 1.22  2009/11/10 09:12:33  narry
// - обновление
//
// Revision 1.21  2009/04/13 09:19:53  narry
// - разделение определения типов и реализации
//
// Revision 1.20  2007/11/27 10:41:12  fireton
// - имя папки в письме об окончании импорта
//
// Revision 1.19  2007/07/24 12:32:50  narry
// - рефакторинг системы сообщений
//
// Revision 1.18  2006/03/07 12:27:34  narry
// - изменение: новая технология передачи заданий
//
// Revision 1.17  2005/12/01 11:35:35  narry
// - обновление: переход на новый способ передачи задач
//
// Revision 1.16  2005/03/25 12:17:26  voba
// - расширение списка параметров задания на импорт
//
// Revision 1.15  2004/09/14 15:58:03  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.14  2003/12/17 14:39:10  voba
// - code format
//
// Revision 1.13  2003/12/17 12:09:07  narry
// - update
//
// Revision 1.12  2003/12/17 11:53:13  narry
// - add: расширение списка параметров сообщения на импорт - отслеживание Группы Доступа "Передано в регионы"
//
// Revision 1.11  2003/04/19 12:30:36  law
// - new file: ddDefine.inc.
//
// Revision 1.10  2003/04/04 17:05:36  narry
// - update & new: новый фильтр - *,evd
//
// Revision 1.9  2002/07/17 08:29:07  narry
// - bug fix: Access violation при создании задания на импорт
//
// Revision 1.8  2002/07/15 14:20:09  narry
// - update
//
// Revision 1.7  2002/02/19 13:53:29  narry
// - update
//
// Revision 1.6  2001/11/22 13:58:42  narry
// - update : начало реализации Групп доступа
//
// Revision 1.5  2001/09/04 13:58:59  voba
// - rename unit: MyUtil -> l3FileUtils.
//
// Revision 1.4  2000/12/15 15:29:53  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }

interface

Uses
  l3Base;

type
 TarImportKind = (ar_ikDoc, ar_ikAnnotation, ar_ikAAC);

function CreateImportTask(aImportKind: TarImportKind; DeleteIncluded: Boolean): Boolean;

implementation

Uses
  Forms, Sysutils,
  l3FileUtils,
  daDataProvider,
  ddAIClientDlg, ddConst, ArchiUserRequestManager,
  csImport,

  csAACImport
  ;

function CreateImportTask(aImportKind: TarImportKind; DeleteIncluded: Boolean): Boolean;
var
  Dlg: TAIClientDialog;
  l_Task : TcsImportTaskItem;

const
 cCaption: array [TarImportKind] of String = (
  'Импорт документов', // ar_ikDoc,
  'Импорт аннотаций', // ar_ikAnnotation,
  'Импорт подготовленных постановлений' // ar_ikAAC
 );
begin
 Dlg:= TAIClientDialog.Create(Application);
 try
  Dlg.BaseDir:= Format('%s.%d', [GetUniqFileName(GlobalDataProvider.GlobalHomePath,
                                                 alcuPrefix, '', True),
                                 GlobalDataProvider.UserID]);
  Dlg.IsAnnotation := aImportKind = ar_ikAnnotation;
  Dlg.Caption:= cCaption[aImportKind];
  Result := false;
  if Dlg.Execute then
  begin
   if aImportKind = ar_ikAAC then
   begin
    l_Task:= TcsAACImport.Create(GlobalDataProvider.UserID);
    TcsAACImport(l_Task).ManualMode := True;
    TcsAACImport(l_Task).CreatedByServer := False;
    TcsAACImport(l_Task).Description := 'Импорт подготовленных постановлений';
   end
   else
    l_Task := TcsImportTaskItem.Create(GlobalDataProvider.UserID);
   try
    l_Task.IsRegion := aImportKind in [ar_ikDoc, ar_ikAnnotation];
    l_Task.IsAnnotation := aImportKind = ar_ikAnnotation;
    l_Task.DeleteIncluded := DeleteIncluded;
    l_Task.SourceFiles.CopyFrom(Dlg.FileList);
    l_Task.SourceDir := ExtractFilePath(l_Task.SourceFiles[0]);
    Result:= ArchiRequestManager.SendTask(l_Task);
   finally
    l3Free(l_Task);
   end;
  end
  else
   Result := True;
 finally
  Dlg.Free;
 end; // Dlg
end;

end.
