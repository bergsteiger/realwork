program F1ServerChecker;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  atLogger,
  scParameters in 'scParameters.pas',
  scAdapterWorker in 'scAdapterWorker.pas',
  JwaWinBase in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinBase.pas',
  JwaNtStatus in 'w:\common\components\rtl\external\JEDI\Win32API\JwaNtStatus.pas',
  JwaWinNT in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinNT.pas',
  JwaWinType in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinType.pas';


  const
    EC_OK = 0;
    EC_UNKNOWN_ERROR = 1;
    //
    EC_INVALID_INI_FILE = 10;
    EC_CAN_NOT_FIND_INI_FILE = 11;
    //
    EC_CANNOT_INIT_ADAPTER = 20;
    // LS - login status
    EC_LS_UNKNOWN_ERROR = 100;
    EC_LS_ALREADY_LOGGED = 101;
    EC_LS_NO_MORE_PROFILES = 102;
    EC_LS_LOGIN_DUPLICATE = 103;
    EC_LS_SHUTDOWN_INITED = 104;
    EC_LS_WRONG_AUTHENTICATION = 105;
    // LG - logout status
    EC_LG_UNKNOWN_ERROR = 200;
    // adapter initialisation
    EC_AI_UNKNOWN_ERROR = 300;
    EC_AI_NO_SERVER = 301;


  function DoCheck : Integer;
    var
      l_Parameters : TscParameters;
      l_AdapterWorker : TscAdapterWorker;
  begin
    Result := EC_OK;

    try
      // получаем настройки
      try
        l_Parameters := TscParameters.Create;
      except
        on EInvalidINIFile do
          begin
            Logger.Error('Плохой INI-файл (не содержит нужных параметров)');
            Result := EC_INVALID_INI_FILE;
          end;
        on ECanNotFindINIFile do
          begin
            Logger.Error('INI-файл не найден');
            Result := EC_CAN_NOT_FIND_INI_FILE;
          end;  
        else
          Raise;
      end;
      if Result <> EC_OK then Exit;

      // загружаем адаптер
      try
        l_AdapterWorker := TscAdapterWorker.Create();
      except
        on ex : Exception do
        begin
          Logger.Exception(ex);
          Result := EC_CANNOT_INIT_ADAPTER;
        end;
      end;
      if Result <> EC_OK then Exit;

      case l_AdapterWorker.InitAdapter of
        iasOK :
          begin
            Logger.Info('Успешно инициализировали адаптер');
          end;
        iasUnknownError :
          begin
            Logger.Error('При попытке инициализации адаптера произошла неизвестная ошибка');
            Result := EC_AI_UNKNOWN_ERROR;
          end;
        iasNoServer :
          begin
            Logger.Error('Не могу подключиться к серверу');
            Result := EC_AI_NO_SERVER;
          end;
      end;
      if Result <> EC_OK then Exit;


      // делаем логин
      Logger.Info('Логинимся пользователем "%s" с логином "%s"', [l_Parameters.UserName, l_Parameters.Password]);
      case l_AdapterWorker.Login(l_Parameters.UserName, l_Parameters.Password) of
        lnsOK:
          begin
            Logger.Info('Успешно залогинилсь');
          end;
        lnsUnknownError :
          begin
            Logger.Error('При попытке логина произошла неизвестная ошибка');
            Result := EC_LS_UNKNOWN_ERROR;
          end;
        lnsAlreadyLogged :
          begin
            Logger.Error('Пользователь уже работает в системе');
            Result := EC_LS_ALREADY_LOGGED;
          end;
        lnsNoMoreProfiles :
          begin
            Logger.Error('Невозможно создать нового пользователя потому что не позволяют лицензионные настройки базы');
            Result := EC_LS_NO_MORE_PROFILES;
          end;
        lnsLoginDuplicate :
          begin
            Logger.Error('Невозможно создать нового пользователя потому что такой пользователь уже существует');
            Result := EC_LS_LOGIN_DUPLICATE;
          end;
        lnsShutdownInited :
          begin
            Logger.Error('Начата остановка сервера');
            Result := EC_LS_SHUTDOWN_INITED;
          end;
        lnsWrongAuthentication :
          begin
            Logger.Error('Неправильный логин/пароль');
            Result := EC_LS_WRONG_AUTHENTICATION;
          end;
      end;
      if Result <> EC_OK then Exit;
      
      // теперь логаут
      Logger.Info('Делаем логаут');
      case l_AdapterWorker.Logout of
        lgsOK :
          begin
            Logger.Info('Успешно сделали логаут');
          end;
        lgsUnknownError :
          begin
            Logger.Error('При попытке логаута произошла неизвестная ошибка');
            Result := EC_LG_UNKNOWN_ERROR;
          end;
      end;
      if Result <> EC_OK then Exit;

      // если дошли до сюда, значит успешно зашли/вышли и можно с чистой совестью выходить
      Logger.Info('Проверка завершена - считаем что сервер жив');
    finally
      FreeAndNil(l_AdapterWorker);
      FreeAndNil(l_Parameters);
    end;
  end;


begin
  try
    ExitCode := DoCheck;
  except
    on ex: Exception do
    begin
      Logger.Exception(ex);
      ExitCode := EC_UNKNOWN_ERROR;
    end;
  end;
  Logger.Info('Код ошибки: %d', [ExitCode]);
end.
