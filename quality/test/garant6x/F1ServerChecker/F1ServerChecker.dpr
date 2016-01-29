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
      // �������� ���������
      try
        l_Parameters := TscParameters.Create;
      except
        on EInvalidINIFile do
          begin
            Logger.Error('������ INI-���� (�� �������� ������ ����������)');
            Result := EC_INVALID_INI_FILE;
          end;
        on ECanNotFindINIFile do
          begin
            Logger.Error('INI-���� �� ������');
            Result := EC_CAN_NOT_FIND_INI_FILE;
          end;  
        else
          Raise;
      end;
      if Result <> EC_OK then Exit;

      // ��������� �������
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
            Logger.Info('������� ���������������� �������');
          end;
        iasUnknownError :
          begin
            Logger.Error('��� ������� ������������� �������� ��������� ����������� ������');
            Result := EC_AI_UNKNOWN_ERROR;
          end;
        iasNoServer :
          begin
            Logger.Error('�� ���� ������������ � �������');
            Result := EC_AI_NO_SERVER;
          end;
      end;
      if Result <> EC_OK then Exit;


      // ������ �����
      Logger.Info('��������� ������������� "%s" � ������� "%s"', [l_Parameters.UserName, l_Parameters.Password]);
      case l_AdapterWorker.Login(l_Parameters.UserName, l_Parameters.Password) of
        lnsOK:
          begin
            Logger.Info('������� �����������');
          end;
        lnsUnknownError :
          begin
            Logger.Error('��� ������� ������ ��������� ����������� ������');
            Result := EC_LS_UNKNOWN_ERROR;
          end;
        lnsAlreadyLogged :
          begin
            Logger.Error('������������ ��� �������� � �������');
            Result := EC_LS_ALREADY_LOGGED;
          end;
        lnsNoMoreProfiles :
          begin
            Logger.Error('���������� ������� ������ ������������ ������ ��� �� ��������� ������������ ��������� ����');
            Result := EC_LS_NO_MORE_PROFILES;
          end;
        lnsLoginDuplicate :
          begin
            Logger.Error('���������� ������� ������ ������������ ������ ��� ����� ������������ ��� ����������');
            Result := EC_LS_LOGIN_DUPLICATE;
          end;
        lnsShutdownInited :
          begin
            Logger.Error('������ ��������� �������');
            Result := EC_LS_SHUTDOWN_INITED;
          end;
        lnsWrongAuthentication :
          begin
            Logger.Error('������������ �����/������');
            Result := EC_LS_WRONG_AUTHENTICATION;
          end;
      end;
      if Result <> EC_OK then Exit;
      
      // ������ ������
      Logger.Info('������ ������');
      case l_AdapterWorker.Logout of
        lgsOK :
          begin
            Logger.Info('������� ������� ������');
          end;
        lgsUnknownError :
          begin
            Logger.Error('��� ������� ������� ��������� ����������� ������');
            Result := EC_LG_UNKNOWN_ERROR;
          end;
      end;
      if Result <> EC_OK then Exit;

      // ���� ����� �� ����, ������ ������� �����/����� � ����� � ������ �������� ��������
      Logger.Info('�������� ��������� - ������� ��� ������ ���');
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
  Logger.Info('��� ������: %d', [ExitCode]);
end.
