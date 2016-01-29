unit scAdapterWorker;

interface

  uses
    GblAdapter
    , StartUnit
    , SettingsUnit
    , FoldersUnit
    ;

  type
    TscLoginStatus = (lnsUnknownError, lnsOK, lnsAlreadyLogged, lnsNoMoreProfiles, lnsLoginDuplicate, lnsShutdownInited, lnsWrongAuthentication);
    TscLogoutStatus = (lgsUnknownError, lgsOK);
    TscInitAdapterStatus = (iasOK, iasUnknownError, iasNoServer);

    TscAdapterWorker = class
      private
        f_GblAdapterDll : IGblAdapterDll;
        f_Authorization : IAuthorization;
        f_SettingsManager : ISettingsManager;
        f_ConfigurationManager : IConfigurationManager;
        f_Configuration : IConfiguration;
        f_Common : ICommon;
        f_MyDocuments : IFoldersNode;
        f_Folders : IFolders;
        //
        f_IsLoggedIn : boolean;
        f_ComponentsStarted : boolean;
        procedure pm_CloseAdapter;
      public
        constructor Create;
        function InitAdapter : TscInitAdapterStatus;
        destructor Destroy; override;
        function Login(const aUserName : String; aPassword : String) : TscLoginStatus;
        function Logout : TscLogoutStatus;
    end;

implementation

  uses
    SysUtils
    //
    , SecurityUnit
    , BaseTreeSupportUnit
    //
    , atLogger
    ;

{ TscAdapterWorker }

  constructor TscAdapterWorker.Create;
  begin
    inherited;
    //
    f_IsLoggedIn := false;
    f_ComponentsStarted := false;
  end;

  destructor TscAdapterWorker.Destroy;
  begin
    if f_IsLoggedIn then Logout;
    pm_CloseAdapter;
    //
    inherited;
  end;

  function TscAdapterWorker.Login(const aUserName : String; aPassword : String): TscLoginStatus;
    var
      l_Root : INode;
  begin
    Result := lnsUnknownError;
    try
      try
        f_Authorization.Login( PAnsiChar(aUserName), PAnsiChar(aPassword) );
      except
        on EWrongAuthentication do
          f_Authorization.Autoregistration('F1ServerChecker', PAnsiChar(aUserName), PAnsiChar(aPassword), '');
        else
          Raise;
      end;
      //
      Result := lnsOK;
    except
      on EWrongAuthentication do
        Result := lnsWrongAuthentication;
      on ENoMoreProfiles do
        Result := lnsNoMoreProfiles;
      on ELoginDuplicate do
        Result := lnsLoginDuplicate;
      on EShutdownInited do
        Result := lnsShutdownInited;
      on EAlreadyLogged do
        Result := lnsAlreadyLogged;
      on ex : Exception do
      begin
        Logger.Exception(ex, 'Логин');
        Result := lnsUnknownError;
      end;
    end;
    //
    if Result = lnsOK then
    begin
      f_Common := f_GblAdapterDll.MakeCommon;
      //
      f_ConfigurationManager := f_GblAdapterDll.MakeConfigurationManager;
      f_ConfigurationManager.GetActive(f_Configuration);
      f_Configuration.GetSettings(f_SettingsManager);
      //
      f_Folders := f_GblAdapterDll.MakeFolders;
      f_Folders.GetRoot(l_Root);
      l_Root.GetChild(0, f_MyDocuments);
    end;
  end;

  function TscAdapterWorker.Logout : TscLogoutStatus;
  begin
    Result := lgsUnknownError;
    try
      f_IsLoggedIn := false;
      //
      f_Common := nil;
      f_MyDocuments := nil;
      f_Folders := nil;
      f_SettingsManager := nil;
      f_Configuration := nil;
      f_SettingsManager := nil;
      //
      f_Authorization.Logout;
      Result := lgsOK;
    except
      on ex : Exception do
      begin
        Logger.Exception(ex, 'Логаут');
        Result := lgsUnknownError;
      end;
    end;
  end;

  procedure TscAdapterWorker.pm_CloseAdapter;
  begin
    f_Authorization := nil;
    if f_ComponentsStarted then
    begin
      Logger.Info('Останавливаем компоненты');
      f_GblAdapterDll.MakeComponentManager.Stop;
      Logger.Info('Компоненты остановлены');
      f_ComponentsStarted := false;
    end;
    f_GblAdapterDll := nil;
  end;

  function TscAdapterWorker.InitAdapter : TscInitAdapterStatus;
  begin
    Result := iasOK;
    //
    Logger.Info('Загружаем адаптер');
    f_GblAdapterDll := TGblAdapterDll.Make;
    Logger.Info('Адаптер загружен');
    //
    Logger.Info('Запускаем компоненты');
    try
      f_GblAdapterDll.MakeComponentManager.Start;
      f_ComponentsStarted := true;
    except
      on ENoServer do
        Result := iasNoServer;
      on ex : Exception do
      begin
        Logger.Exception(ex, 'Инициализация адаптера');
        Result := iasUnknownError
      end;
    end;
    Logger.Info('Компоненты запущены');
    //
    if (Result = iasOK) then
    begin
      Logger.Info('Получаем интерфейс авторизации');
      while f_Authorization = nil do
      try
        f_Authorization := f_GblAdapterDll.MakeAuthorization;
      except
        on EXMLImportRunning do Sleep(100);
        else
          Raise;
      end;
      Logger.Info('Получили интерфейс авторизации');
    end;
  end;

end.
