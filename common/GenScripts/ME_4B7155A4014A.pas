unit atTestChatOperation;

// ћодуль: "w:\quality\test\garant6x\AdapterTest\Operations\atTestChatOperation.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "TatTestChatOperation" MUID: (4B7155A4014A)

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatTestChatOperation = class(TatOperationBase)
  protected
   procedure ExecuteSelf; override;
   procedure InitParamList; override;
 end;//TatTestChatOperation

implementation

uses
 l3ImplUses
 , atChatWorker
 , SysUtils
 , atUserListHelper
 , Windows
 , atLogger
 , Classes
 , atCommon
;

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
    Logger.Error('ќбъект дл€ работы с чатом не создан. ¬озможно, использование чата запрещено на сервере.');
    Exit;
  end;

  // «аполн€ем контакт лист
  l_UserList := TatUserListHelper.GetAdapterTestUIDs(true);
  if (l_UserList = nil) then
  begin
    Logger.Error('Ќельз€ тестировать чат - поговорить не с кем');
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

      // нужно ли что-то добавл€ть?
      if   ( (l_MaxTalksCount <> -1) AND ( Length(l_ContactList) >= l_MaxTalksCount) )
        OR ( Length(l_ContactList) >= Length(l_UserList) ) then
        break;

      // провер€ем, есть ли рассматриваемый uid в контакт-листе
      l_IsAlwaysAdded := false;
      for j := Low(l_ContactList) to High(l_ContactList) do
        if l_UserList[i] = l_ContactList[j] then
        begin
          l_IsAlwaysAdded := true;
          break;
        end;

      // добавл€ем, если еще не добавлен
      if NOT l_IsAlwaysAdded then
        l_ChatWorker.AddUser(l_UserList[i]);
    end;

  // “еперь начинаем разговоры со всем контакт-листом
  l_ContactList := l_ChatWorker.GetContactListUIDs(true, true);
  for j := Low(l_ContactList) to High(l_ContactList) do
    if NOT l_ChatWorker.StartConversation(l_ContactList[j]) then
      Logger.Error('Ќе удалось начать разговор с пользователем %d', [l_ContactList[j]]);

  // √оворим
    // пока не истек таймаут
  l_DeadLine := GetTickCount + l_TimeOut;
  while (l_TimeOut = -1) OR (GetTickCount < l_DeadLine) do
  begin
    // начинаем разговор со всеми пользовател€ми от которых есть непрочитанные сообщени€
    l_UIDSWithUnreadedMessages := l_ChatWorker.UIDsWithUnreadedMessages;
    if (l_UIDSWithUnreadedMessages <> nil) then
      for i := Low(l_UIDSWithUnreadedMessages) to High(l_UIDSWithUnreadedMessages) do
        if NOT l_ChatWorker.StartConversation(l_UIDSWithUnreadedMessages[i]) then
          Logger.Error('Ќе удалось начать ответный разговор с пользователем %d', [l_UIDSWithUnreadedMessages[i]]);

    l_IsAnySent := false;
    l_IsCompleted := l_ChatWorker.ConversationsCount <> 0;
    // обрабатываем все открытые разговоры
    for i := 0 to l_ChatWorker.ConversationsCount-1 do
      with l_ChatWorker.ConversationByIndex[i] do
      begin
        ProcessNewMessages;
        // если можно еще посылать сообщени€
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

    // если посланы все сообщени€, то прекращаем
    if l_IsCompleted then break;
    //
    if NOT l_IsAnySent then Sleep(l_AfterSentDelay);
  end;

  // «аканчиваем все разговоры
  while (l_ChatWorker.ConversationsCount > 0) do
  begin
    {$IFDEF DEBUG}
    Logger.Info('¬ызываем l_ChatWorker.FinishConversation(%d)', [l_ChatWorker.ConversationByIndex[0].UserID]);
    {$ENDIF}
    l_ChatWorker.FinishConversation( l_ChatWorker.ConversationByIndex[0].UserID );
    {$IFDEF DEBUG}
    Logger.Info('¬ызвали l_ChatWorker.FinishConversation');
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
    Add( ParamType.Create('max_talks_count', '—о сколькими пользовател€ми разговаривать', '-1') );
    Add( ParamType.Create('messages_to_sent', '—колько посыласть сообщений каждому пользователю', '10') );
    Add( ParamType.Create('timeout', 'ћаксимально врем€ выполнени€', '-1') );
    Add( ParamType.Create('after_sent_delay', '«адержка после посылки сообщени€', '2000') );
  end;
//#UC END# *48089F3701B4_4B7155A4014A_impl*
end;//TatTestChatOperation.InitParamList

end.
