unit nsNotifiers;

// $Id: nsNotifiers.pas,v 1.23 2016/09/13 18:31:59 kostitsin Exp $

// $Log: nsNotifiers.pas,v $
// Revision 1.23  2016/09/13 18:31:59  kostitsin
// {requestlink: 630194905 }
//
// Revision 1.22  2016/08/04 12:43:09  lulin
// - перегенерация.
//
// Revision 1.21  2016/07/26 16:17:11  lulin
// - перегенерация.
//
// Revision 1.20  2016/07/25 13:01:17  lulin
// - перегенерация.
//
// Revision 1.19  2016/07/15 11:25:37  lulin
// - выпрямляем зависимости.
//
// Revision 1.18  2015/09/18 11:00:16  kostitsin
// {requestlink: 606129273 }
//
// Revision 1.17  2015/08/19 13:17:33  morozov
// {RequestLink: 605819551}
//
// Revision 1.16  2014/10/02 11:21:00  kostitsin
// {requestlink: 235046973 }
//
// Revision 1.15  2013/06/19 09:48:33  morozov
// {RequestLink:428876920}
//
// Revision 1.14  2012/08/03 13:05:04  kostitsin
// [$380616604]
//  - nsNotifiers
//
// Revision 1.13  2012/04/05 15:51:09  lulin
// {RequestLink:237994598}
//
// Revision 1.12  2011/11/16 17:35:15  lulin
// {RequestLink:232098711}
//
// Revision 1.11  2010/12/20 16:18:48  lulin
// - уменьшаем количество дёрганий технических комментариев.
//
// Revision 1.10  2010/09/22 10:27:36  oman
// - new: {RequestLink:234366672}
//
// Revision 1.9  2010/09/09 10:28:39  dolgop
// -chg: вычищаем predefined_data для мониторингов
// (http://mdp.garant.ru/x/KIxPCg)
//
// Revision 1.8  2010/04/21 11:40:34  lulin
// {RequestLink:139438698}.
//
// Revision 1.7  2010/04/20 14:34:05  oman
// - new: {RequestLink:185205022}
//
// Revision 1.6  2010/04/20 10:18:13  oman
// - new: {RequestLink:185205022}
//
// Revision 1.5  2010/04/20 09:59:43  oman
// Жизнь поменялась
//
// Revision 1.4  2009/12/02 17:21:39  lulin
// {RequestLink:172984885}.
//
// Revision 1.3  2009/11/12 15:31:45  lulin
// {RequestLink:171540596}.
//
// Revision 1.2  2009/09/28 11:31:53  lulin
// - избавляемся от внутренних опреация модуля Папки, связанных с документами на контроле.
//
// Revision 1.1  2009/09/14 11:28:53  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.98  2009/09/09 18:55:15  lulin
// - переносим на модель код проектов.
//
// Revision 1.97  2009/08/25 14:13:02  lulin
// {RequestLink:159367405}.
//
// Revision 1.96  2009/08/25 12:47:57  lulin
// {RequestLink:159367405}.
//
// Revision 1.95  2009/08/24 18:24:01  lulin
// - выпрямляем зависимости.
//
// Revision 1.94  2009/08/24 08:36:35  lulin
// - переносим системные операции на модель.
//
// Revision 1.93  2009/08/14 14:57:43  lulin
// {RequestLink:129240934}. №42.
//
// Revision 1.92  2009/08/12 11:59:58  oman
// - new: Пользуем фабрику диспетчера - {RequestLink:152408792}
//
// Revision 1.91  2009/07/31 07:20:32  oman
// - new: Обрабатываем нотификацию - {RequestLink:152408792}
//
// Revision 1.90  2009/07/30 12:07:52  oman
// - new: Готовимся обрабатывать нотификации - {RequestLink:152408792}
//
// Revision 1.89  2009/07/23 13:38:18  oman
// - new: Переносим на модель - {RequestLink:152408792}
//
// Revision 1.88  2009/06/26 10:58:22  oman
// - new: Подписываемся на нотификацию - [$152408792]
//
// Revision 1.87  2009/06/03 12:55:39  oman
// - new: не собирались - [$148014435]
//
// Revision 1.86  2009/06/03 12:27:43  oman
// - new: компилируемся - [$148014435]
//
// Revision 1.85  2009/06/03 10:43:13  oman
// - new: Готовим проекты к отпилу - [$148014435]
//
// Revision 1.84  2009/03/16 11:30:32  migel
// - fix: не проверяли наличие диспетчера.
//
// Revision 1.83  2009/03/12 11:31:50  lulin
// - <K>: 139430482. Вставлены скобки - http://mdp.garant.ru/pages/viewpage.action?pageId=139430482&focusedCommentId=139433264#comment-139433264
//
// Revision 1.82  2009/02/10 19:03:13  lulin
// - <K>: 133891247. Вычищаем морально устаревший модуль.
//
// Revision 1.81  2008/12/05 10:13:13  oman
// - fix: Более радикальное лечение - меню гасилось не всегда (К-111739456)
//
// Revision 1.80  2008/11/07 14:07:02  oman
// - fix: Убираем popup menu до показа диалога (К-111739456)
//
// Revision 1.79  2008/10/21 12:01:41  lulin
// - <K>: 121156800.
//
// Revision 1.78  2008/08/28 12:12:51  lulin
// - <K>: 89100161.
//
// Revision 1.77  2008/08/21 06:31:35  oman
// - fix: Перепроверяем наличие связи по нотификации (К-109511093)
//
// Revision 1.76  2008/08/06 12:12:43  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=93264761&focusedCommentId=106987926#comment-106987926
//
// Revision 1.75  2008/08/05 06:50:08  lulin
// - <K>: 93264761.
//
// Revision 1.74  2008/01/10 08:26:46  mmorozov
// - change: сначала уведомляем об обновлении данных адаптер, потом всех остальных слушателей (CQ: OIT5-28184);
//
// Revision 1.73  2008/01/10 07:23:10  oman
// Переход на новый адаптер
//
// Revision 1.72  2007/12/25 11:31:36  mmorozov
// - new: подписка на обновление данных приложения (CQ: OIT5-27823);
//
// Revision 1.71  2007/12/21 07:12:16  mmorozov
// - new: подписка на уведомление об обновлении данных (CQ: OIT5-27823);
//
// Revision 1.70  2007/12/19 10:59:38  mmorozov
// - подписываемся на уведомления данных приложения (CQ: OIT5-27823);
//
// Revision 1.69  2007/05/17 12:02:56  oman
// cleanup
//
// Revision 1.68  2007/03/09 11:56:02  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.67  2007/02/02 13:23:48  lulin
// - упрощаем преобразование строк.
//
// Revision 1.66  2007/01/23 10:06:20  lulin
// - интерфейсу формы добавлен метод показа в модальном режиме.
//
// Revision 1.65  2007/01/22 09:17:39  oman
// - fix: Получали StorageLocked на переключении баз при открытом
//  окне контекстного поиска (cq24169)
//
// Revision 1.64  2007/01/20 15:30:18  lulin
// - разделяем параметры операции для выполнения и для тестирования.
//
// Revision 1.63  2006/12/22 12:22:03  mmorozov
// - MERGE WITH B_NEMESIS_6_4;
//
// Revision 1.60.4.3  2006/12/22 11:59:45  mmorozov
// - new behaviour: перечитываем заголовок окна по завершении обноавления базы;
//
// Revision 1.62  2006/11/16 14:29:40  mmorozov
// MERGE WITH B_NEMESIS_6_4 (new: обновление заголовка окна при переключении базы (CQ: OIT5-23663));
//
// Revision 1.61  2006/11/15 15:59:25  oman
// Merge from B_NEMESIS_6_4
//
// Revision 1.60.4.1  2006/11/15 15:55:26  oman
// - fix: Если открывалась новостная лента, а потом закрылась, то
//  дерево новостной ленты при переключении не обновится => AV
//  (cq23647)
//
// Revision 1.60  2006/10/03 13:29:28  mmorozov
// - new: сообщаем пользовалю об отключенном доступе к консультациям (CQ: OIT500022637);
//
// Revision 1.59  2006/09/29 07:18:21  mmorozov
// - new behaviour: при рассылке уведомлений о консультациях проверяем наличие менеджера консультаций;
//
// Revision 1.58  2006/09/27 14:43:52  mmorozov
// - bugfix: не обрабатываем нотификации если приложение в режиме разрушения (CQ: OIT500022375)
//
// Revision 1.57  2006/08/01 09:29:10  mmorozov
// - new: обработка нотификации о отправке консультаций (CQ: OIT500021819);
//
// Revision 1.56  2006/07/28 14:23:49  mmorozov
// - new: обработка открытия запросов из папки "Исходящие запросы";
// - new: обработка нотификации при отправке консультаций (не прошла валидацию, нет связи с сервером);
//
// Revision 1.55  2006/05/12 07:14:29  mmorozov
// - изменения накопившиеся за время отсутствия CVS;
//
// Revision 1.54  2006/03/24 14:48:24  lulin
// - cleanup: избавляемся от косвенного приведения интерфейсов.
//
// Revision 1.53  2005/11/30 16:56:12  lulin
// - при синхронизации посылаем объект, а не буфер.
//
// Revision 1.52  2005/11/22 17:01:12  lulin
// - класс-обертка над нодой для реализации документа выделен в отдельный модуль.
//
// Revision 1.51  2005/11/22 10:02:16  demon
// - new behavior: удалена старая нотификация об обновлении списка пользователей и все сопутствующие ей операции перечитывания этого дерева
//
// Revision 1.50  2005/10/25 09:18:32  demon
// - new behavior: выделен отдельный объект (и модуль) TnsThreadNotifier для обработки нотификаций не в основной триаде
//
// Revision 1.49  2005/10/11 14:14:49  migel
// - fix: при апдейте базы запрещаем вызов _onTest.
//
// Revision 1.48  2005/09/02 12:35:27  demon
// - new behavior: Отработана нотификация о Logout'е
//
// Revision 1.47  2005/08/17 15:21:34  demon
// - fix: AV при обработки нотификации о создании пользователя
//
// Revision 1.46  2005/08/16 13:28:28  demon
// - new behavior: обработана нотификация об изменении списка пользователей
//
// Revision 1.45  2005/06/30 07:48:05  cyberz
// READY FOR TIE-TEMPLATE GENERATION
//
// Revision 1.44  2005/06/28 10:40:13  demon
// - fix: при обновлении десктопной версии неверно обрабатывались нотификации об обновлении
//
// Revision 1.43  2005/06/06 12:09:15  demon
// - new behavior: оптимизирован код присвоения нотификаторов
//
// Revision 1.42  2005/06/03 14:07:36  demon
// - new behavior: Нотификации об обновлении, смерти сервера и еще часть переведены на новый механизм.
//
// Revision 1.41  2005/05/03 12:45:53  mmorozov
// new: определяем иконку для AsyncMessageWindow;
//
// Revision 1.40  2005/04/20 08:54:18  mmorozov
// change: в качестве потока долгой фильтрации используется Tl3AsincMessageWindow;
//
// Revision 1.39  2005/04/18 13:14:42  demon
// - new behavior: Сбрасываем кэш документов после обновления.
//
// Revision 1.38  2005/04/14 14:46:28  dk3
// fix for:
// по приходу _Shutdown'а до логина молча гасим оболочку
//
// Revision 1.37  2005/04/13 14:27:26  demon
// - new behavior: Отработана ситуация прихода End раньше Start при нотификации о длительном процессе. При этом ничего не выводим.
//
// Revision 1.36  2005/04/11 12:42:11  demon
// - fix: временно вставлена задержка в обработчик нотификации об изменении общего профиля
//
// Revision 1.35  2005/04/08 09:49:08  dinishev
// Обработка сообщений от сервера (о его выключении и обновлении).
//
// Revision 1.34  2005/04/07 10:35:02  demon
// - new behavior: обработана нотификация об изменении Prdefined_Data
//
// Revision 1.33  2005/03/29 14:16:31  demon
// - new behavior: доделана обработка нотификации о длительном процессе
//
// Revision 1.32  2005/03/28 11:41:55  demon
// - new behavior: параметр нотификации теперь интерфейс INotify
//
// Revision 1.31  2005/03/25 15:45:03  migel
// - change: вернули обратно значение константы.
//
// Revision 1.30  2005/03/25 13:32:33  demon
// - new behavior: new object TnsOnLongProcess
//
// Revision 1.29  2005/03/04 14:41:09  dinishev
// Директива Monitorings для уменшения количества подключаемых модулей
//
// Revision 1.28  2005/02/11 14:35:05  am
// change: по приходу _Shutdown'а до логина молча гасим оболочку
//
// Revision 1.27  2005/01/17 13:45:28  fireton
// - add: добавляем реакцию оболочки на ошибки при обновлении
//
// Revision 1.26  2005/01/15 12:06:39  fireton
// - коррекция объявления TnsOnUpdate.FireCompleted
//
// Revision 1.25  2004/11/16 15:36:59  am
// change: изменил механизм поднимания окна с сообщением об обновлении
//
// Revision 1.24  2004/11/12 16:08:19  am
// change: убрал лок на момент апдейта (формы всё-равно спрятаны). С локом не отрисовывается форма апдейта.
//
// Revision 1.23  2004/11/12 15:00:34  am
// change: поменялась модель нотификаций об апдейтах. Теперь по первой нотификации прячем все формы, поднимаем форму с сообшением об апдейте и крутим цикл с ProcessMessages, пока не будет выставлен флажок. По второй нотификации - выставляем флажок.
//
// Revision 1.22  2004/11/12 07:52:12  am
// change: промежуточный коммит для синхронизации с адаптерными инками
//
// Revision 1.21  2004/11/05 08:09:04  am
// change: значение timeout'а в TnsShutdown.Fire приходит с адаптера
//
// Revision 1.20  2004/11/05 07:43:10  am
// change: значение timeout'а в TnsShutdown.Fire приходит с адаптера
//
// Revision 1.19  2004/11/02 16:09:35  am
// new: TnsOnServerShutdown - класс, на котором дёргается callback метод при завершении работы сервера
//
// Revision 1.18  2004/11/02 14:59:38  zakharov
// added _shutdown notifier
//
// Revision 1.17  2004/10/28 15:52:34  demon
// - new behavior: изменен принцип обработки нотификации об изменении папок
//
// Revision 1.16  2004/09/09 15:21:49  am
// change: перевод словаря на новые деревья
//
// Revision 1.15  2004/09/07 16:22:03  law
// - перевел Nemesis на кешированные обьекты.
//
// Revision 1.14  2004/07/07 07:50:18  am
// change: Cleanup
//
// Revision 1.13  2004/07/02 09:20:55  am
// change: очистка кэша новых деревьев
//
// Revision 1.12  2004/03/30 07:26:04  demon
// - new: вывод формы UpdateMessage во время синхронизации данных после обновления
//
// Revision 1.11  2004/03/26 20:12:36  migel
// - change: переделана синхронизация вызовов с основным потоком.
//
// Revision 1.10  2004/03/24 13:13:30  migel
// - fix: сброс внутренних кешей при обновлении базы.
//
// Revision 1.9  2004/03/22 13:28:32  migel
// - fix: сбрасываем дерево, типизирующее респондентов/корреспондентов, при получении нотификации об обновлении.
//
// Revision 1.8  2004/02/27 09:29:48  demon
// - new behavior: сброс кэшированных словарей
//
// Revision 1.7  2004/02/25 13:48:17  demon
// - add: комментарии
//
// Revision 1.6  2004/02/25 13:38:50  demon
// - new: начата реализация операции рассылки нотификаций об обновлении.
//
// Revision 1.5  2004/02/25 12:32:54  demon
// - new: добавлен объект реализующий прием нотификации об Обновлении.
//
// Revision 1.4  2004/02/20 12:38:01  migel
// - add: метод для синхронного вызова с возможностью возврата результата.
//
// Revision 1.3  2004/02/19 14:37:53  migel
// - fix: при вызове метода нотификации "переключаемся" на основную триаду и выполняем запуск метода из нее.
//
// Revision 1.2  2004/02/18 18:47:52  cyberz
// many fixes and refactoring for Security
//
// Revision 1.1  2004/02/17 12:59:28  demon
// - new: модуль для реализации объектов-нотификаций
//

{$Include nsDefine.inc}

interface

uses
  Classes,
  SyncObjs,

  l3Interfaces,
  
  vcmInterfaces,

  evDocumentsCache,

  StdRes,

  FoldersUnit,
  NotifyUnit,
  UnderControlUnit,

  nsThreadNotifier
  ;

type
 TnsOnLongProcess = class(TnsThreadNotifier, IListener)
  private
   f_Counter: Integer;
   f_Thread: TThread;
   f_CriticalSection: TCriticalSection;

   function  StartProcess: Boolean;
   procedure FinishProcess;

   procedure Fire(const aNotify: INotification); stdcall;
  protected
   procedure Cleanup; override;
   procedure InitFields; override;
  public
   class function Make: IListener;
 end;

 TnsSynchronizedNotification = class(TnsThreadNotifier, IListener)
  private
    f_UpdateComplete: ByteBool;
  private
  // internal methods
    procedure Fire(const aNotify: INotification);
      stdcall;
      {-}
  protected
  // protected methods
    procedure UpdateStarted(aDataPtr: Tl3DataHolder);
      {-}
    procedure UpdateFinished(aDataPtr: Tl3DataHolder);
      {-}
    procedure Shutdown(aDataPtr: Tl3DataHolder);
      {-}
    procedure Logout(aDataPtr: Tl3DataHolder);
      {-}
    procedure MonitoringUpdateEvent(aDataPtr: Tl3DataHolder);
      {-}
    procedure UnreadConsultationsChanged(aDataPtr: Tl3DataHolder);
      {-}
    procedure InternetConnected(aDataPtr: Tl3DataHolder);
      {-}
    procedure InternetDisConnected(aDataPtr: Tl3DataHolder);
      {-}
    procedure ConsulationNoConnection(aDataPtr: Tl3DataHolder);
      {-}
    procedure ConsulationNoSubscription(aDataPtr: Tl3DataHolder);
      {-}
(*    procedure CancelPopups(aDataPtr: Tl3DataHolder);
      {-}
    procedure DoLockActionUpdate(aDataPtr: Tl3DataHolder);
      {-}
    procedure DoUnLockActionUpdate(aDataPtr: Tl3DataHolder);
      {-}*)
   procedure Cleanup; override;
  public
  // public methods
    class function Make: IListener;
      {-}
 end;

 {$If not (defined(Monitorings) or defined(Admin))}
 TnsOnControlledChange = class(TnsThreadNotifier, IControlledChangeNotifier)
 private
  procedure Fire; stdcall;
  procedure FireImplementation(aDataPtr: Tl3DataHolder);
 end;
 {$IfEnd}

 {$If not (defined(Monitorings) or defined(Admin))}
 TnsOnExternalFolderChange = class(TnsThreadNotifier, IExternalFoldersChangeNotifier)
 private
  procedure Fire(const aNotifyData: TNotifyData); stdcall;
  procedure FireImplementation(aDataPtr: Tl3DataHolder);
 end;
 {$IfEnd}

  {$If not (defined(Monitorings) or defined(Admin))}
 TnsChatNotifier = class(TnsThreadNotifier, IListener)
 private
  procedure Fire(const aNotify: INotification);
    stdcall;
  procedure MessagesReceived(aDataPtr: Tl3DataHolder);
  procedure ContactListChanged(aDataPtr: Tl3DataHolder);
 end;
  {$IfEnd not (defined(Monitorings) or defined(Admin))}

implementation

uses
 Windows,
 Messages,
 SysUtils,
 Forms,

 l3Base,
 l3AsincMessageWindow,

 afwFacade,
 afwInterfaces,

 vcmBase,
 vcmForm,
 vcmDispatcher,

 BaseTypesUnit,
 IOUnit,

 DataAdapter,

 nsTypes,
 nsNotificationManager,
 nsUnderControlNotificationManager,
 {$If not (defined(Monitorings) or defined(Admin))}
 bsConsultationManager,
 {$IfEnd}
 nsAttributeTreeCacheNew,

 Autoreferat_InternalOperations_Controls,
 PrimCommon_Module
 , F1_Without_Usecases_System_Controls
 , Base_Operations_F1Services_Contracts
 , F1_Application_Template_Services
 ;

const
 cDefTimeOut = 30;

// Start class TnsOnLongProcess

procedure TnsOnLongProcess.InitFields;
begin
 inherited;
 f_CriticalSection := TCriticalSection.Create;
end;

class function TnsOnLongProcess.Make: IListener;
var
 l_Obj: TnsOnLongProcess;
begin
 l_Obj := TnsOnLongProcess.Create;
 try
  Result := l_Obj;
 finally
  vcmFree(l_Obj);
 end;
end;

function TnsOnLongProcess.StartProcess: Boolean;
begin
 Result := f_Counter = 0;
 Inc(f_Counter);
end;

procedure TnsOnLongProcess.FinishProcess;
begin
 Dec(f_Counter);
end;

procedure TnsOnLongProcess.Fire(const aNotify: INotification);

 procedure lpThreadCreate(const aCaption : Il3CString = nil);
 begin
  f_Thread := Tl3AsincMessageWindow.Create(aCaption,
   dmStdRes.ilAsyncMessageWindow, StdRes.camw_Wait);
 end;

var
 l_Data: IVariant;
 l_String: IString;
begin
 f_CriticalSection.Enter;
 try
  case aNotify.GetId of
   NT_LONG_OPERATION_START:
    if StartProcess then
    begin
     aNotify.GetData(l_Data);
     if l_Data <> nil then
      try
       l_Data.GetString(l_String);
       try
        lpThreadCreate(nsCStr(l_String));
       finally
        l_String := nil;
       end;
      finally
       l_Data := nil;
      end
     else
      lpThreadCreate;
    end;
   NT_LONG_OPERATION_END:
    begin
     if Assigned(f_Thread) then
     begin
      f_Thread.Terminate;
      f_Thread.WaitFor;
      FreeAndNil(f_Thread);
     end;
     FinishProcess;
    end;
  end;
 finally
  f_CriticalSection.Leave;
 end;
end;

procedure TnsOnLongProcess.Cleanup;
begin
 FreeAndNil(f_Thread);
 FreeAndNil(f_CriticalSection);
 f_Counter := 0;
 inherited;
end;

// Start class TnsSynchronizedNotification

class function TnsSynchronizedNotification.Make: IListener;
var
 l_Obj: TnsSynchronizedNotification;
begin
 l_Obj := TnsSynchronizedNotification.Create;
 try
  Result := l_Obj;
 finally
  vcmFree(l_Obj);
 end;
end;

procedure TnsSynchronizedNotification.Cleanup;
begin
 inherited;
end;

procedure TnsSynchronizedNotification.Fire(const aNotify: INotification);
 //stdcall;
var
 l_Data: IVariant;
 l_TimeOut: LongInt;
 l_Type: TNotifyType;
 l_UpdResult: ByteBool;
begin
 try
  l_Type := aNotify.GetId;
  case l_Type of
   NT_MONITORING_UPDATE:
     Synchronize(MonitoringUpdateEvent);
   NT_SHUTDOWN:
    begin
     aNotify.GetData(l_Data);
     if Assigned(l_Data) then
      l_TimeOut := l_Data.GetLong
     else
      l_TimeOut := cDefTimeOut;
     Synchronize(Shutdown, @l_Timeout, SizeOf(l_Timeout));
    end;
   NT_BASE_UPDATE_START:
   begin
(*    Synchronize(DoLockActionUpdate);
    try
     Synchronize(CancelPopups);*)
     Synchronize(UpdateStarted);
(*    finally
     Synchronize(DoUnlockActionUpdate);
    end;//try..finally*)
   end;//NT_BASE_UPDATE_START
   NT_BASE_UPDATE_END,
   NT_BASE_UPDATE_FAILED:
    begin
     l_UpdResult := l_Type = NT_BASE_UPDATE_END;
     Synchronize(UpdateFinished, @l_UpdResult, SizeOf(l_UpdResult));
    end;//NT_BASE_UPDATE_END
   NT_LOGOUT:
    begin
     aNotify.GetData(l_Data);
     if Assigned(l_Data) then
      l_TimeOut := l_Data.GetLong
     else
      l_TimeOut := cDefTimeOut;
     Synchronize(Logout, @l_Timeout, SizeOf(l_Timeout));
    end;//NT_LOGOUT
   NT_CONSULTATION_RECEIVED:
    Synchronize(UnreadConsultationsChanged);
   NT_CONSULTATION_NOT_SENT:
    Synchronize(ConsulationNoConnection);
   NT_NO_SUBSCRIPTION:
    Synchronize(ConsulationNoSubscription);
   NT_INTERNET_AVAILABLE:
    Synchronize(InternetConnected);
   NT_INTERNET_NOT_AVAILABLE:
    Synchronize(InternetDisConnected);
  end;//case l_Type
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;
end;

procedure TnsSynchronizedNotification.UpdateStarted(aDataPtr: Tl3DataHolder);

  procedure lp_NotifyDataUpdate;
  var
   l_Data     : IafwApplicationData;
  begin
   l_Data := afw.Application.Data;
   if (l_Data <> nil) then
   try
    TvcmDispatcher.Instance.FormDispatcher.Lock;
    try
     defDataAdapter.FinishDataUpdate;
      // - уведомить адаптер об обновлении данных необходимо раньше, чем
      //   остальных слушателей, т.к. слушатели используют данные адаптера при
      //   обновлении.
     l_Data.FinishUpdate;
    finally
     TvcmDispatcher.Instance.FormDispatcher.UnLock;
    end;//try..finally
   finally
    l_Data := nil;
   end;//try..finally
  end;//lp_NotifyDataUpdate

  procedure lp_ShowUpdateWindow;
  var
   l_MessageForm : IvcmEntityForm;
  begin
   l_MessageForm := TLongProcessService.Instance.MakeUpdateMessage;
   try
    l_MessageForm.ShowModal;
   finally
    l_MessageForm := nil;
   end;//try..finally
   TvcmDispatcher.Instance.As_IvcmDispatcher.EndCancelModal;
  end;//lp_ShowUpdateWindow

  procedure CancelPopups;
    {-}
  begin
   EndMenu;
   PostMessage(Application.Handle, WM_CANCELMODE, 0, 0);
   afw.ProcessMessages;
  end;

begin
 // Попытка побороть улетающий курсор в списке при переключении баз
 // http://mdp.garant.ru/pages/viewpage.action?pageId=428876920
 Sleep(2000);
 Assert(GetCurrentThreadID = MainThreadID);
 if TvcmDispatcher.Exists then
  // - если g_Dispatcher = nil, то это значит работает только сам Updater.
 begin
  TvcmDispatcher.Instance.As_IvcmDispatcher.LockActionUpdate;
  try
   CancelPopups;
   lp_ShowUpdateWindow;
   if not f_UpdateComplete then
    defDataAdapter.AbnormalTermination(err_UpdateDataDestroyed);
   lp_NotifyDataUpdate;
  finally
   TvcmDispatcher.Instance.As_IvcmDispatcher.UnlockActionUpdate;
  end;//try..finally
 end;//if Assigned(g_Dispatcher) then
end;//UpdateStarted

procedure TnsSynchronizedNotification.UpdateFinished(aDataPtr: Tl3DataHolder);
type
 PByteBool = ^ByteBool;
begin
 Assert(GetCurrentThreadID = MainThreadID);
 f_UpdateComplete := PBytebool(aDataPtr.Data)^;
 // Если g_Dispatcher = nil, то это значит работает только сам Updater:
 if TvcmDispatcher.Exists then
 begin
  // Обновим заголовок приложения, нужно делать до рассылки потому, что
  // главные формы, будут использовать его для корретировки своих
  // CaptionPrefix:
  DefDataAdapter.DefineApplicationTitle;
  TvcmDispatcher.Instance.As_IvcmDispatcher.BeginCancelModal;
 end;//if Assigned(g_Dispatcher) then
end;//UpdateFinished

procedure TnsSynchronizedNotification.Shutdown(aDataPtr: Tl3DataHolder);
var
 l_Params: IvcmExecuteParams;
 l_Form: IvcmEntityForm;
begin
 Assert(GetCurrentThreadID = MainThreadID);

 if (defDataAdapter = nil) or
    (defDataAdapter.CommonInterfaces = nil) or
    not TvcmDispatcher.Exists then
 begin
  Application.Terminate;
  Exit;
 end;
 TShutdownService.Instance.MakeShutdownWindow(PLongWord(aDataPtr.Data)^, wkShutDown);
end;

procedure TnsSynchronizedNotification.LogOut(aDataPtr: Tl3DataHolder);
var
 l_Params: IvcmExecuteParams;
 l_Form: IvcmEntityForm;
begin
 Assert(GetCurrentThreadID = MainThreadID);

 if (defDataAdapter = nil) or
    (defDataAdapter.CommonInterfaces = nil) or
    not TvcmDispatcher.Exists then
 begin
  Application.Terminate;
  Exit;
 end;
 TShutdownService.Instance.MakeShutdownWindow(PLongWord(aDataPtr.Data)^, wkLogout);
end;

procedure TnsSynchronizedNotification.ConsulationNoSubscription(aDataPtr: Tl3DataHolder);
  {-}
begin
 // Если менеджер не создан значит еще никто не подписался на нотификацию и
 // рассылать ее не нужно. Такое возможно при разрушении приложения, когда
 // объекты отписаны и менеджер освобожден, но нотификация ждала своей обработки
 // в очереди сообщений:
 {$If not defined(Admin) AND not defined(Monitorings)}
 if IsConsultationManagerAssigned then
  g_ConsultationManager.NoSubscription;
 {$IfEnd} 
end;

(*procedure TnsSynchronizedNotification.CancelPopups(aDataPtr: Tl3DataHolder);
  {-}
begin
 EndMenu;
 PostMessage(Application.Handle, WM_CANCELMODE, 0, 0);
 afw.ProcessMessages;
end;

procedure TnsSynchronizedNotification.DoLockActionUpdate(aDataPtr: Tl3DataHolder);
  {-}
begin
 if Assigned(g_Dispatcher) then
  g_Dispatcher.LockActionUpdate;
end;

procedure TnsSynchronizedNotification.DoUnLockActionUpdate(aDataPtr: Tl3DataHolder);
  {-}
begin
 if Assigned(g_Dispatcher) then
  g_Dispatcher.UnLockActionUpdate;
end;*)

procedure TnsSynchronizedNotification.ConsulationNoConnection(aDataPtr: Tl3DataHolder);
  {-}
begin
 // Если менеджер не создан значит еще никто не подписался на нотификацию и
 // рассылать ее не нужно. Такое возможно при разрушении приложения, когда
 // объекты отписаны и менеджер освобожден, но нотификация ждала своей обработки
 // в очереди сообщений:
 {$If not defined(Admin) AND not defined(Monitorings)}
 if IsConsultationManagerAssigned then
  g_ConsultationManager.NoConnection;
 {$IfEnd} 
end;

procedure TnsSynchronizedNotification.UnreadConsultationsChanged(aDataPtr: Tl3DataHolder);
  {-}
begin
 // Если менеджер не создан значит еще никто не подписался на нотификацию и
 // рассылать ее не нужно. Такое возможно при разрушении приложения, когда
 // объекты отписаны и менеджер освобожден, но нотификация ждала своей обработки
 // в очереди сообщений:
 {$If not defined(Admin) AND not defined(Monitorings)}
 if IsConsultationManagerAssigned then
  g_ConsultationManager.UnreadChanged;
 {$IfEnd} 
end;

procedure TnsSynchronizedNotification.MonitoringUpdateEvent(aDataPtr: Tl3DataHolder);
begin
 Assert(GetCurrentThreadID = MainThreadID);

 Sleep(1000); // !!! времянка, т.к. иначе не успевает обновится дерево на адаптере.
 (*if Assigned(g_Dispatcher) then // Если g_Dispatcher = nil, то это значит, что оболочка еще не стартовала
  {$If not defined(Admin) AND not defined(Monitorings)}
  op_System_CommonDataChanged.Broadcast;
  {$Else}
  // - ничего не делаем
  //g_Dispatcher.EntityOperationBroadcast(op_System_CommonDataChanged);
  {$IfEnd}*)
 {$If not defined(Admin) AND not defined(Monitorings)}
 TnsNotificationManager.NotifyListeners(ntMonitoringUpdate);
 {$IfEnd}
end;

procedure TnsSynchronizedNotification.InternetConnected(
  aDataPtr: Tl3DataHolder);
begin
 // Если менеджер не создан значит еще никто не подписался на нотификацию и
 // рассылать ее не нужно. Такое возможно при разрушении приложения, когда
 // объекты отписаны и менеджер освобожден, но нотификация ждала своей обработки
 // в очереди сообщений:
 {$If not defined(Admin) AND not defined(Monitorings)}
 if IsConsultationManagerAssigned then
  g_ConsultationManager.InternetConnected;
 {$IfEnd}
end;

{$If not (defined(Monitorings) or defined(Admin))}
{ TnsChatNotifier }

procedure TnsChatNotifier.Fire(const aNotify: INotification);
var
 l_Data: IVariant;
 l_UID: LongInt;
begin
 try
  case aNotify.GetID of
   NT_NEW_CHAT_MESSAGES_RECEIVED:
    begin
     aNotify.GetData(l_Data);
     if Assigned(l_Data) then
      l_UID := l_Data.GetLong
     else
     begin
      Assert(False);
      l_UID := 0;
     end;
     Synchronize(MessagesReceived, @l_UID, SizeOf(l_UID));
    end;
   NT_CHAT_CONTACT_ADDED,
   NT_CHAT_CONTACT_REMOVED:
    begin
     Synchronize(ContactListChanged);
    end;
   end;
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;
end;

procedure TnsChatNotifier.MessagesReceived(aDataPtr: Tl3DataHolder);
var
 l_Params: IvcmExecuteParams;
 l_Form: IvcmEntityForm;
begin
 Assert(GetCurrentThreadID = MainThreadID);

 if (defDataAdapter = nil) or
    (defDataAdapter.CommonInterfaces = nil) or
    not TvcmDispatcher.Exists then
 begin
  Exit;
 end;
 TChatService.Instance.MakeChatDispatcher.MessagesReceived(PLongWord(aDataPtr.Data)^);
end;

procedure TnsChatNotifier.ContactListChanged(aDataPtr: Tl3DataHolder);
begin
 Assert(GetCurrentThreadID = MainThreadID);

 if (defDataAdapter = nil) or
    (defDataAdapter.CommonInterfaces = nil) or
    not TvcmDispatcher.Exists then
 begin
  Exit;
 end;
 TChatService.Instance.MakeChatDispatcher.ContactListChanged;
end;
  {$IfEnd not (defined(Monitorings) or defined(Admin))}

{$If not (defined(Monitorings) or defined(Admin))}
// Start class TnsOnExternalFolderChange

procedure TnsOnExternalFolderChange.Fire(const aNotifyData: TNotifyData);
begin
 try
  Synchronize(FireImplementation,
              @aNotifyData, SizeOf(aNotifyData),
              [aNotifyData.rDoneNotifier, aNotifyData.rFolder]);
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;
end;

procedure TnsOnExternalFolderChange.FireImplementation(aDataPtr: Tl3DataHolder);
begin
 if not TvcmDispatcher.Exists then
  Exit;
 Assert(GetCurrentThreadID = MainThreadID);
 with PNotifyData(aDataPtr.Data)^ do
 begin
  try
   // посылка сообщения об изменении структуры дереву папок
    TFoldersService.Instance.RefreshStructure(rFolder, rStatus);
  finally
   with TnsDoneNotifierThread.Create(rDoneNotifier) do
   try
    FreeOnTerminate := True;
    Resume;
   except
    on E: Exception do
    begin
     l3System.Exception2Log(E);
     Free;
    end;
   end;//try..except
  end;//try..finally
 end;//with PNotifyData(aDataPtr.Data)^
end;
{$IfEnd}

{$If not (defined(Monitorings) or defined(Admin))}
// Start class TnsOnControlledChange

procedure TnsOnControlledChange.Fire;
begin
 try
  Synchronize(FireImplementation);
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;
end;

procedure TnsOnControlledChange.FireImplementation(aDataPtr: Tl3DataHolder);
begin
 if not TvcmDispatcher.Exists then
  Exit;
 Assert(GetCurrentThreadID = MainThreadID);
 TnsUnderControlNotificationManager.Instance.SetChangedNotification; 
end;
{$IfEnd}

procedure TnsSynchronizedNotification.InternetDisConnected(
  aDataPtr: Tl3DataHolder);
begin
 // Если менеджер не создан значит еще никто не подписался на нотификацию и
 // рассылать ее не нужно. Такое возможно при разрушении приложения, когда
 // объекты отписаны и менеджер освобожден, но нотификация ждала своей обработки
 // в очереди сообщений:
 {$If not defined(Admin) AND not defined(Monitorings)}
 if IsConsultationManagerAssigned then
  g_ConsultationManager.InternetDisConnected;
 {$IfEnd}
end;

end.
