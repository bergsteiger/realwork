unit atTestChatOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atTestChatOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatTestChatOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atOperationBase
  ;

type
 TatTestChatOperation = class(TatOperationBase)
 protected
 // realized methods
   procedure ExecuteSelf; override;
 protected
 // overridden protected methods
   procedure InitParamList; override;
 end;//TatTestChatOperation

implementation

uses
  atChatWorker,
  SysUtils,
  atUserListHelper,
  Windows,
  atLogger,
  Classes,
  atCommon
  ;

// start class TatTestChatOperation

procedure TatTestChatOperation.ExecuteSelf;
//#UC START# *48089F460352_4B7155A4014A_var*
  var
    l_MaxTalksCount, l_MessagesToSent, l_TimeOut, l_AfterSentDelay : Integer;
    l_ChatWorker : TatChatWorker;
    l_ContactList, l_UserList, l_UIDSWithUnreadedMessages : TatArrayOfUID;
    i, j : Integer;
    l_MyUID : Longword;
    l_IsAlwaysAdded, l_IsCompleted, l_IsAnySent : boolean;
    l_DeadLine : DWORD;
//#UC END# *48089F460352_4B7155A4014A_var*
begin
//#UC START# *48089F460352_4B7155A4014A_impl*
  inherited;
  //
  l_MaxTalksCount := Parameters['max_talks_count'].AsInt;
  l_MessagesToSent := Parameters['messages_to_sent'].AsInt;
  l_TimeOut := Parameters['timeout'].AsInt;
  l_AfterSentDelay := Parameters['after_sent_delay'].AsInt;
  //
  l_ChatWorker := ExecutionContext.GblAdapterWorker.ChatWorker;
  if (l_ChatWorker = nil) then
  begin
    Logger.Error('Объект для работы с чатом не создан. Возможно, использование чата запрещено на сервере.');
    Exit;
  end;

  // Заполняем контакт лист
  l_UserList := TatUserListHelper.GetAdapterTestUIDs(true);
  if (l_UserList = nil) then
  begin
    Logger.Error('Нельзя тестировать чат - поговорить не с кем');
    Exit;
  end;
  //
  l_MyUID := TatUserListHelper.GetMyUID;
  with TList.Create do
  try
    for i := Low(l_UserList) to High(l_UserList) do Add(Pointer(l_UserList[i]));
    Sort(Less);
    for i := Low(l_UserList) to High(l_UserList) do l_UserList[i] := Integer(Items[i]);
  finally
    Free;
  end;
  //
  for i := Low(l_UserList) to High(l_UserList) do
    if l_MyUID < l_UserList[i] then
    begin
      l_ContactList := l_ChatWorker.GetContactListUIDs(true, true);

      // нужно ли что-то добавлять?
      if   ( (l_MaxTalksCount <> -1) AND ( Length(l_ContactList) >= l_MaxTalksCount) )
        OR ( Length(l_ContactList) >= Length(l_UserList) ) then
        break;

      // проверяем, есть ли рассматриваемый uid в контакт-листе
      l_IsAlwaysAdded := false;
      for j := Low(l_ContactList) to High(l_ContactList) do
        if l_UserList[i] = l_ContactList[j] then
        begin
          l_IsAlwaysAdded := true;
          break;
        end;

      // добавляем, если еще не добавлен
      if NOT l_IsAlwaysAdded then
        l_ChatWorker.AddUser(l_UserList[i]);
    end;

  // Теперь начинаем разговоры со всем контакт-листом
  l_ContactList := l_ChatWorker.GetContactListUIDs(true, true);
  for j := Low(l_ContactList) to High(l_ContactList) do
    if NOT l_ChatWorker.StartConversation(l_ContactList[j]) then
      Logger.Error('Не удалось начать разговор с пользователем %d', [l_ContactList[j]]);

  // Говорим
    // пока не истек таймаут
  l_DeadLine := GetTickCount + l_TimeOut;
  while (l_TimeOut = -1) OR (GetTickCount < l_DeadLine) do
  begin
    // начинаем разговор со всеми пользователями от которых есть непрочитанные сообщения
    l_UIDSWithUnreadedMessages := l_ChatWorker.UIDsWithUnreadedMessages;
    if (l_UIDSWithUnreadedMessages <> nil) then
      for i := Low(l_UIDSWithUnreadedMessages) to High(l_UIDSWithUnreadedMessages) do
        if NOT l_ChatWorker.StartConversation(l_UIDSWithUnreadedMessages[i]) then
          Logger.Error('Не удалось начать ответный разговор с пользователем %d', [l_UIDSWithUnreadedMessages[i]]);

    l_IsAnySent := false;
    l_IsCompleted := l_ChatWorker.ConversationsCount <> 0;
    // обрабатываем все открытые разговоры
    for i := 0 to l_ChatWorker.ConversationsCount-1 do
      with l_ChatWorker.ConversationByIndex[i] do
      begin
        ProcessNewMessages;
        // если можно еще посылать сообщения
        if (MessagesSent < l_MessagesToSent) AND (MessagesSent <= MessagesReceived) then
        begin
          try
            SendMessage('сообщение');
          except
            on oEx : Exception do
            begin
              WriteLn(oEx.ClassName + ' : ' + oEx.Message);
              Logger.Exception(oEx, 'SendMessage');
            end;
          end;
          Sleep(l_AfterSentDelay);
          l_IsAnySent := true;
        end;

        l_IsCompleted := l_IsCompleted AND (MessagesSent = l_MessagesToSent);
      end;

    // если посланы все сообщения, то прекращаем
    if l_IsCompleted then break;
    //
    if NOT l_IsAnySent then Sleep(l_AfterSentDelay);
  end;

  // Заканчиваем все разговоры
  while (l_ChatWorker.ConversationsCount > 0) do
  begin
    {$IFDEF DEBUG}
    Logger.Info('Вызываем l_ChatWorker.FinishConversation(%d)', [l_ChatWorker.ConversationByIndex[0].UserID]);
    {$ENDIF}
    l_ChatWorker.FinishConversation( l_ChatWorker.ConversationByIndex[0].UserID );
    {$IFDEF DEBUG}
    Logger.Info('Вызвали l_ChatWorker.FinishConversation');
    {$ENDIF}
  end;

//#UC END# *48089F460352_4B7155A4014A_impl*
end;//TatTestChatOperation.ExecuteSelf

procedure TatTestChatOperation.InitParamList;
//#UC START# *48089F3701B4_4B7155A4014A_var*
//#UC END# *48089F3701B4_4B7155A4014A_var*
begin
//#UC START# *48089F3701B4_4B7155A4014A_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('max_talks_count', 'Со сколькими пользователями разговаривать', '-1') );
    Add( ParamType.Create('messages_to_sent', 'Сколько посыласть сообщений каждому пользователю', '10') );
    Add( ParamType.Create('timeout', 'Максимально время выполнения', '-1') );
    Add( ParamType.Create('after_sent_delay', 'Задержка после посылки сообщения', '2000') );
  end;
//#UC END# *48089F3701B4_4B7155A4014A_impl*
end;//TatTestChatOperation.InitParamList

end.