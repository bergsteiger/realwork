unit archiHTInit;
// $Id: archiHTInit.pas,v 1.18 2015/05/26 15:17:44 lukyanets Exp $

// $Log: archiHTInit.pas,v $
// Revision 1.18  2015/05/26 15:17:44  lukyanets
// Чистим залочки более гуманно
//
// Revision 1.17  2015/03/06 08:14:30  lukyanets
// Выкидываем ошметки
//
// Revision 1.16  2015/02/26 11:59:15  lukyanets
// Cleanup
//
// Revision 1.15  2014/10/17 10:34:24  lukyanets
// Не выводим лишнего в лог
//
// Revision 1.14  2014/10/15 07:11:46  lukyanets
// Функция не возвращала результат
//
// Revision 1.13  2014/10/10 07:03:32  lukyanets
// Чиним мелкие огрехи
//
// Revision 1.12  2014/10/09 13:13:36  lukyanets
// Готовим фабрику параметров
//
// Revision 1.11  2014/10/09 10:28:23  lukyanets
// Обобщаем код
//
// Revision 1.10  2014/10/09 09:59:54  lukyanets
// Избавляемся от лишнего синглетона
//
// Revision 1.9  2014/10/09 07:42:46  lukyanets
// Обобщаем код
//
// Revision 1.8  2014/10/08 13:07:33  lukyanets
// Переносим процедуры в правильное место
//
// Revision 1.7  2014/10/03 12:14:32  lukyanets
// Объединяем "синглетон"
//
// Revision 1.6  2014/09/19 07:41:27  lukyanets
// {RequestLink:565273246} - Заготовили транспорт
//
// Revision 1.5  2014/09/11 09:14:44  dinishev
// {Requestlink:565007367}
//
// Revision 1.4  2014/09/10 13:21:45  voba
// - Рефакторинг процедуры ввода пароля
//
// Revision 1.3  2013/11/12 09:56:08  dinishev
// Возможная утечка.
//
// Revision 1.2  2013/10/31 11:47:46  dinishev
// {Requestlink:497228462}. Подвисший указатель.
//
// Revision 1.1  2013/10/31 07:31:30  dinishev
// {Requestlink:497228462}
//
// Revision 1.7  2013/04/19 13:04:38  lulin
// - портируем.
//
// Revision 1.6  2013/04/01 09:08:45  voba
// - Запил от Дудко, не запускался в standalone
//
// Revision 1.5  2012/11/21 07:40:05  voba
// no message
//
// Revision 1.4  2012/11/21 06:04:03  dinishev
// Вырубаем запрос пароля для ArchiTest
//
// Revision 1.3  2012/11/20 13:53:36  narry
// Всегда спрашивать логин-пароль
//
// Revision 1.2  2012/02/20 08:47:57  narry
// Сообщение о состоянии экспорта (340167865)
//

interface

Uses
 daTypes;

function InitArchiBaseEngine(
    aPromptUserPasswordProc: TGetLoginPasswordProc = nil; aQuiteMode: Boolean =
    False): Boolean; overload;

procedure DoneArchiBaseEngine;

implementation

Uses
 SysUtils,
 l3IniFile,

 DT_Const,

 ddHTInit,
 ddClientBaseEngine,

 m3Endings;

function InitArchiBaseEngine(
    aPromptUserPasswordProc: TGetLoginPasswordProc = nil; aQuiteMode: Boolean =
    False): Boolean;
begin
 Result := InitBaseEngine(aPromptUserPasswordProc, aQuiteMode, False, False, False);
 if Assigned(g_BaseEngine) then
 begin
  if g_BaseEngine.IsStarted then
   InitEndings(g_BaseEngine.GetFamilyPath(CurrentFamily));
 end;
end;

procedure DoneArchiBaseEngine;
begin
 DoneClientBaseEngine;
end;

end.
