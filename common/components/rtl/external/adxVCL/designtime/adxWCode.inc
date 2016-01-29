const
  chCR = #13#10;
  chQ = #39;
  //chBDS = #239#187#191;
  chBDS = '';

  // Lexemes
  lexProjectName = '%PROJECT_NAME%';
  lexModuleType = '%MODULE_TYPE%';
  lexAddInCoClassName = '%COCLASS_NAME%';
  lexUnitList = '%COMMON_UNIT_LIST%';
  lexLIBID = '%LIBID%';
  lexIID = '%IID%';
  lexCLSID = '%CLSID%';
  // Delphi 2005
  lexProjectGUID = '%PROJECT_GUID%';
//------------------------------------------------------------------------------
  lexToolsPropPage = '%TOOLS_PROP_NAME%';
  lexToolsPropPageTitle = '%TOOLS_PROP_TITLE%';
  lexFoldersPropPage = '%FOLDERS_PROP_NAME%';
  lexFoldersPropPageTitle = '%FOLDERS_PROP_TITLE%';
  lexToolsIID = '%TOOLS_IID%';
  lexToolsDIID = '%TOOLS_DIID%';
  lexToolsCLSID = '%TOOLS_CLSID%';
  lexFoldersIID = '%FOLDERS_IID%';
  lexFoldersDIID = '%FOLDERS_DIID%';
  lexFoldersCLSID = '%FOLDERS_CLSID%';
  lexEnumIID= '%ENUM_IID%';

  lexRegisterStuff = '%REGISTER%';

  {$IFDEF ADX_VCL5}
  UnitList = 'SysUtils, ComObj, ComServ, ActiveX';
  {$ELSE}
  UnitList = 'SysUtils, ComObj, ComServ, ActiveX, Variants';
  {$ENDIF}

  // Source code of project module (DLL)
  ProjectModule: string =
    'library %PROJECT_NAME%;' + chCR +
    '' + chCR +
    'uses' + chCR +
    '  ComServ,' + chCR +
    '  %PROJECT_NAME%_TLB in '#39'%PROJECT_NAME%_TLB.pas'#39',' + chCR +
    '  %PROJECT_NAME%_IMPL in '#39'%PROJECT_NAME%_IMPL.pas'#39' {%MODULE_TYPE%: T%MODULE_TYPE%} {%COCLASS_NAME%: CoClass};' + chCR +
    '%REGISTER%' + chCR +
    'exports' + chCR +
    '  DllGetClassObject,' + chCR +
    '  DllCanUnloadNow,' + chCR +
    '  DllRegisterServer,' + chCR +
    '  DllUnregisterServer;' + chCR +
    '' + chCR +
    '{$R *.TLB}' + chCR +
    '' + chCR +
    '{$R *.RES}' + chCR +
    '' + chCR +
    'begin' + chCR +
    'end.' + chCR;

  RegisterINIFile: string =
    '[Config]' + chCR +
    'Privileges=User' + chCR;

  RegisterStuff: string =
    'type' + chCR +
    '  TDummyComServer = class(TObject)' + chCR +
    '  private' + chCR +
    '    procedure FactoryRegister(Factory: TComObjectFactory);' + chCR +
    '    procedure FactoryUnRegister(Factory: TComObjectFactory);' + chCR +
    '  end;' + chCR +
    '' + chCR +
    'procedure TDummyComServer.FactoryRegister(Factory: TComObjectFactory);' + chCR +
    'begin' + chCR +
    '  UpdateFactory(Factory, True);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure TDummyComServer.FactoryUnRegister(Factory: TComObjectFactory);' + chCR +
    'begin' + chCR +
    '  UpdateFactory(Factory, False);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function DllRegisterServer: HResult;' + chCR +
    'begin' + chCR +
    '  Result := E_FAIL;' + chCR +
    '  try' + chCR +
    '    if CheckConfigSection() then begin' + chCR +
    '      RegisterToHKCU := True;' + chCR +
    '      with TDummyComServer.Create do' + chCR +
    '        try' + chCR +
    '          ComClassManager.ForEachFactory(ComServer, FactoryRegister);' + chCR +
    '        finally' + chCR +
    '          Free;' + chCR +
    '        end;' + chCR +
    '      Result := S_OK;' + chCR +
    '    end;' + chCR +
    '  except' + chCR +
    '  end;' + chCR +
    '  if Result <> S_OK then Result := ComServ.DllRegisterServer();' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function DllUnregisterServer: HResult;' + chCR +
    'begin' + chCR +
    '  Result := E_FAIL;' + chCR +
    '  try' + chCR +
    '    if CheckConfigSection() then begin' + chCR +
    '      RegisterToHKCU := True;' + chCR +
    '      with TDummyComServer.Create do' + chCR +
    '        try' + chCR +
    '          ComClassManager.ForEachFactory(ComServer, FactoryUnRegister);' + chCR +
    '        finally' + chCR +
    '          Free;' + chCR +
    '        end;' + chCR +
    '      Result := S_OK;' + chCR +
    '    end;' + chCR +
    '  except' + chCR +
    '  end;' + chCR +
    '  if Result <> S_OK then Result := ComServ.DllUnregisterServer();' + chCR +
    'end;' + chCR;

  // Source code of project module (EXE)
  ProjectAppModule: string =
    'program %PROJECT_NAME%;' + chCR +
    '' + chCR +
    'uses' + chCR +
    '  Forms,' + chCR +
    '  %PROJECT_NAME%_TLB in '#39'%PROJECT_NAME%_TLB.pas'#39',' + chCR +
    '  %PROJECT_NAME%_IMPL in '#39'%PROJECT_NAME%_IMPL.pas'#39' {%MODULE_TYPE%: T%MODULE_TYPE%};' + chCR +
    '' + chCR +
    '{$R *.TLB}' + chCR +
    '' + chCR +
    '{$R *.RES}' + chCR +
    '' + chCR +
    'begin' + chCR +
    '  Application.Initialize;' + chCR +
    '  Application.Run;' + chCR +
    'end.' + chCR;

  // Source code of add-in's interface implementation module
  IMPLModule: string =
    'unit %PROJECT_NAME%_IMPL;' + chCR +
    '' + chCR +
    'interface' + chCR +
    '' + chCR +
    'uses' + chCR +
    '  %COMMON_UNIT_LIST%, Office2000, adxAddIn, %PROJECT_NAME%_TLB;' + chCR +
    '' + chCR +
    'type' + chCR +
    '  T%COCLASS_NAME% = class(TadxAddin, I%COCLASS_NAME%)' + chCR +
    '  end;' + chCR +
    '' + chCR +
    '  TAddInModule = class(TadxCOMAddInModule)' + chCR +
    '  private' + chCR +
    '  protected' + chCR +
    '  public' + chCR +
    '  end;' + chCR +
    '' + chCR +
    'implementation' + chCR +
    '' + chCR +
    '{$R *.dfm}' + chCR +
    '' + chCR +
    'initialization' + chCR +
    '  TadxFactory.Create(ComServer, T%COCLASS_NAME%, CLASS_%COCLASS_NAME%, TAddInModule);' + chCR +
    '' + chCR +
    'end.' + chCR;

  IMPLModuleDFM: string =
    'object AddInModule: TAddInModule' + chCR +
    '  OldCreateOrder = True' + chCR +
    '  AddInName = '#39 + '%COCLASS_NAME%' + #39 + chCR +
    '  LoadBehavior = 3' + chCR +
    '  SupportedApps = [ohaExcel]' + chCR +
    '  TaskPanes = <>' + chCR +
    '  Left = 225' + chCR +
    '  Top = 140' + chCR +
    '  Height = 400' + chCR +
    '  Width = 380' + chCR +
    'end' + chCR;

  IMPLModule_XL: string =
    'unit %PROJECT_NAME%_IMPL;' + chCR +
    '' + chCR +
    'interface' + chCR +
    '' + chCR +
    'uses' + chCR +
    '  %COMMON_UNIT_LIST%, adxMSFormsControls, adxAddIn, %PROJECT_NAME%_TLB;' + chCR +
    '' + chCR +
    'type' + chCR +
    '  T%COCLASS_NAME% = class(TadxAddin, I%COCLASS_NAME%)' + chCR +
    '  end;' + chCR +
    '' + chCR +
    '  TAddInModule = class(TadxExcelSheetModule)' + chCR +
    '  private' + chCR +
    '  protected' + chCR +
    '  public' + chCR +
    '  end;' + chCR +
    '' + chCR +
    'implementation' + chCR +
    '' + chCR +
    '{$R *.dfm}' + chCR +
    '' + chCR +
    'initialization' + chCR +
    '  TadxFactory.Create(ComServer, T%COCLASS_NAME%, CLASS_%COCLASS_NAME%, TAddInModule);' + chCR +
    '' + chCR +
    'end.' + chCR;

  IMPLModuleDFM_XL: string =
    'object AddInModule: TAddInModule' + chCR +
    '  OldCreateOrder = True' + chCR +
    '  AddInName = '#39 + '%COCLASS_NAME%' + #39 + chCR +
    '  LoadBehavior = 3' + chCR +
    '  SupportedApps = [ohaExcel]' + chCR +
    '  Left = 225' + chCR +
    '  Top = 140' + chCR +
    '  Height = 400' + chCR +
    '  Width = 380' + chCR +
    'end' + chCR;

  IMPLModule_WD: string =
    'unit %PROJECT_NAME%_IMPL;' + chCR +
    '' + chCR +
    'interface' + chCR +
    '' + chCR +
    'uses' + chCR +
    '  %COMMON_UNIT_LIST%, adxMSFormsControls, adxAddIn, %PROJECT_NAME%_TLB;' + chCR +
    '' + chCR +
    'type' + chCR +
    '  T%COCLASS_NAME% = class(TadxAddin, I%COCLASS_NAME%)' + chCR +
    '  end;' + chCR +
    '' + chCR +
    '  TAddInModule = class(TadxWordDocumentModule)' + chCR +
    '  private' + chCR +
    '  protected' + chCR +
    '  public' + chCR +
    '  end;' + chCR +
    '' + chCR +
    'implementation' + chCR +
    '' + chCR +
    '{$R *.dfm}' + chCR +
    '' + chCR +
    'initialization' + chCR +
    '  TadxFactory.Create(ComServer, T%COCLASS_NAME%, CLASS_%COCLASS_NAME%, TAddInModule);' + chCR +
    '' + chCR +
    'end.' + chCR;

  IMPLModuleDFM_WD: string =
    'object AddInModule: TAddInModule' + chCR +
    '  OldCreateOrder = True' + chCR +
    '  AddInName = '#39 + '%COCLASS_NAME%' + #39 + chCR +
    '  LoadBehavior = 3' + chCR +
    '  SupportedApps = [ohaWord]' + chCR +
    '  Left = 225' + chCR +
    '  Top = 140' + chCR +
    '  Height = 400' + chCR +
    '  Width = 380' + chCR +
    'end' + chCR;

  IMPLModuleOutlook: string =
    'unit %PROJECT_NAME%_IMPL;' + chCR +
    '' + chCR +
    'interface' + chCR +
    '' + chCR +
    'uses' + chCR +
    '  %COMMON_UNIT_LIST%, Office2000, adxAddIn, %PROJECT_NAME%_TLB,' + chCR +
    '  Outlook2000;' + chCR +
    '' + chCR +
    'type' + chCR +
    '  T%COCLASS_NAME% = class(TadxAddin, I%COCLASS_NAME%)' + chCR +
    '  end;' + chCR +
    '' + chCR +
    '  TAddInModule = class(TadxCOMAddInModule)' + chCR +
    '    procedure adxCOMAddInModuleAddInInitialize(Sender: TObject);' + chCR +
    '    procedure adxCOMAddInModuleAddInFinalize(Sender: TObject);' + chCR +
    '  private' + chCR +
    '  protected' + chCR +
    '%PROTECTED_DECL%' +
    '  public' + chCR +
    '  end;' + chCR +
    '' + chCR +
    'var' + chCR +
    '  adx%COCLASS_NAME%: TAddInModule;' + chCR +
    '' + chCR +
    'implementation' + chCR +
    '' + chCR +
    '{$R *.dfm}' + chCR +
    '' + chCR +
    'procedure TAddInModule.adxCOMAddInModuleAddInInitialize(Sender: TObject);' + chCR +
    'begin' + chCR +
    '  adx%COCLASS_NAME% := Self;' + chCR +
    '' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure TAddInModule.adxCOMAddInModuleAddInFinalize(Sender: TObject);' + chCR +
    'begin' + chCR +
    '' + chCR +
    '  adx%COCLASS_NAME% := nil;' + chCR +
    'end;' + chCR +
    '' + chCR +
    '%CODE%' + chCR +
    'initialization' + chCR +
    '  TadxFactory.Create(ComServer, T%COCLASS_NAME%, CLASS_%COCLASS_NAME%, TAddInModule);' + chCR +
    '' + chCR +
    'end.' + chCR;

  IMPLModuleOutlookDFM: string =
    'object AddInModule: TAddInModule' + chCR +
    '  OldCreateOrder = True' + chCR +
    '  AddInName = '#39 + '%COCLASS_NAME%' + #39 + chCR +
    '  LoadBehavior = 3' + chCR +
    '  SupportedApps = [ohaOutlook]' + chCR +
    '  OnAddInInitialize = adxCOMAddInModuleAddInInitialize' + chCR +
    '  OnAddInFinalize = adxCOMAddInModuleAddInFinalize' + chCR +
    '  TaskPanes = <%TASK_PANES%>' + chCR +
    '  Left = 225' + chCR +
    '  Top = 140' + chCR +
    '  Height = 400' + chCR +
    '  Width = 380' + chCR +
    'end' + chCR;

  IMPLModuleTaskPaneDFM: string =
    'object AddInModule: TAddInModule' + chCR +
    '  OldCreateOrder = True' + chCR +
    '  AddInName = '#39 + '%COCLASS_NAME%' + #39 + chCR +
    '  LoadBehavior = 3' + chCR +
    '  SupportedApps = [ohaExcel]' + chCR +
    '  OnAddInInitialize = adxCOMAddInModuleAddInInitialize' + chCR +
    '  OnAddInFinalize = adxCOMAddInModuleAddInFinalize' + chCR +
    '  TaskPanes = <%TASK_PANES%>' + chCR +
    '  Left = 225' + chCR +
    '  Top = 140' + chCR +
    '  Height = 400' + chCR +
    '  Width = 380' + chCR +
    'end' + chCR;

  IMPLModuleTaskPane: string =
    'unit %PROJECT_NAME%_IMPL;' + chCR +
    '' + chCR +
    'interface' + chCR +
    '' + chCR +
    'uses' + chCR +
    '  %COMMON_UNIT_LIST%, Office2000, adxAddIn, %PROJECT_NAME%_TLB;' + chCR +
    '' + chCR +
    'type' + chCR +
    '  T%COCLASS_NAME% = class(TadxAddin, I%COCLASS_NAME%)' + chCR +
    '  end;' + chCR +
    '' + chCR +
    '  TAddInModule = class(TadxCOMAddInModule)' + chCR +
    '    procedure adxCOMAddInModuleAddInInitialize(Sender: TObject);' + chCR +
    '    procedure adxCOMAddInModuleAddInFinalize(Sender: TObject);' + chCR +
    '  private' + chCR +
    '  protected' + chCR +
    '  public' + chCR +
    '  end;' + chCR +
    '' + chCR +
    'var' + chCR +
    '  adx%COCLASS_NAME%: TAddInModule;' + chCR +
    '' + chCR +
    'implementation' + chCR +
    '' + chCR +
    '{$R *.dfm}' + chCR +
    '' + chCR +
    'procedure TAddInModule.adxCOMAddInModuleAddInInitialize(Sender: TObject);' + chCR +
    'begin' + chCR +
    '  adx%COCLASS_NAME% := Self;' + chCR +
    '' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure TAddInModule.adxCOMAddInModuleAddInFinalize(Sender: TObject);' + chCR +
    'begin' + chCR +
    '' + chCR +
    '  adx%COCLASS_NAME% := nil;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'initialization' + chCR +
    '  TadxFactory.Create(ComServer, T%COCLASS_NAME%, CLASS_%COCLASS_NAME%, TAddInModule);' + chCR +
    '' + chCR +
    'end.' + chCR;

  IMPLModuleRTD: string =
    'unit %PROJECT_NAME%_IMPL;' + chCR +
    '' + chCR +
    'interface' + chCR +
    '' + chCR +
    'uses' + chCR +
    '  SysUtils, Classes, ComServ, %PROJECT_NAME%_TLB, adxRTDServ;' + chCR +
    '' + chCR +
    'type' + chCR +
    '  T%COCLASS_NAME% = class(TadxRTDServer, I%COCLASS_NAME%);' + chCR +
    '' + chCR +
    '  TRTDServerModule = class(TadxXLRTDServerModule)' + chCR +
    '  private' + chCR +
    '  protected' + chCR +
    '  public' + chCR +
    '  end;' + chCR +
    '' + chCR +
    'implementation' + chCR +
    '' + chCR +
    '{$R *.dfm}' + chCR +
    '' + chCR +
    'initialization' + chCR +
    '  TadxRTDFactory.Create(ComServer, T%COCLASS_NAME%, CLASS_%COCLASS_NAME%, TRTDServerModule);' + chCR +
    '' + chCR +
    'end.' + chCR;

  IMPLModuleRTD_DFM: string =
    'object RTDServerModule: TRTDServerModule' + chCR +
    '  OldCreateOrder = True' + chCR +
    '  Left = 225' + chCR +
    '  Top = 140' + chCR +
    '  Height = 400' + chCR +
    '  Width = 380' + chCR +
    'end' + chCR;

  // Source code of type library
  TLBModule: string =
    'unit %PROJECT_NAME%_TLB;' + chCR +
    ''  + chCR +
    '{$TYPEDADDRESS OFF}' + chCR +
    ''  + chCR +
    'interface' + chCR +
    '' + chCR +
    'uses %COMMON_UNIT_LIST%;' + chCR +
    '' + chCR +
    'const' + chCR +
    '  %PROJECT_NAME%MajorVersion = 1;' + chCR +
    '  %PROJECT_NAME%MinorVersion = 0;' + chCR +
    '' + chCR +
    '  LIBID_%PROJECT_NAME%: TGUID = '#39'%LIBID%'#39';' + chCR +
    '' + chCR +
    '  IID_I%COCLASS_NAME%: TGUID = '#39'%IID%'#39';' + chCR +
    '  CLASS_%COCLASS_NAME%: TGUID = '#39'%CLSID%'#39';' + chCR +
    ''  + chCR +
    'type' + chCR +
    '  I%COCLASS_NAME% = interface(IDispatch)' + chCR +
    '    ['#39'%IID%'#39']' + chCR +
    '  end;' + chCR +
    '' + chCR +
    '  I%COCLASS_NAME%Disp = dispinterface' + chCR +
    '    ['#39'%IID%'#39']' + chCR +
    '  end;' + chCR +
    '' + chCR +
    'implementation' + chCR +
    '' + chCR +
    'end.';

  RIDLModuleEnum: string =
    chCR +
    '  [' + chCR +
    '    uuid(%ENUM_IID1%),' + chCR +
    '    version(1.0)' + chCR +
    '  ]' + chCR +
    '  enum TxActiveFormBorderStyle' + chCR +
    '  {' + chCR +
    '    [helpstring("afbNone")]' + chCR +
    '    afbNone = 0,' + chCR +
    '    [helpstring("afbSingle")]' + chCR +
    '    afbSingle = 1,' + chCR +
    '    [helpstring("afbSunken")]' + chCR +
    '    afbSunken = 2,' + chCR +
    '    [helpstring("afbRaised")]' + chCR +
    '    afbRaised = 3' + chCR +
    '  };' + chCR +
    chCR +
    '  [' + chCR +
    '    uuid(%ENUM_IID2%),' + chCR +
    '    version(1.0)' + chCR +
    '  ]' + chCR +
    '  enum TxPrintScale' + chCR +
    '  {' + chCR +
    '    [helpstring("poNone")]' + chCR +
    '    poNone = 0,' + chCR +
    '    [helpstring("poProportional")]' + chCR +
    '    poProportional = 1,' + chCR +
    '    [helpstring("poPrintToFit")]' + chCR +
    '    poPrintToFit = 2' + chCR +
    '  };' + chCR +
    chCR +
    '  [' + chCR +
    '    uuid(%ENUM_IID3%),' + chCR +
    '    version(1.0)' + chCR +
    '  ]' + chCR +
    '  enum TxMouseButton' + chCR +
    '  {' + chCR +
    '    [helpstring("mbLeft")]' + chCR +
    '    mbLeft = 0,' + chCR +
    '    [helpstring("mbRight")]' + chCR +
    '    mbRight = 1,' + chCR +
    '    [helpstring("mbMiddle")]' + chCR +
    '    mbMiddle = 2' + chCR +
    '  };' +
    chCR;

  RIDLLBModule: string =
    '  interface I%TOOLS_PROP_NAME%;' + chCR +
    '  dispinterface I%TOOLS_PROP_NAME%Events;' + chCR +
    '  coclass %TOOLS_PROP_NAME%;'+
    chCR;

  RIDLModuleTools: string =
    chCR +
    '  [' + chCR +
    '    uuid(%TOOLS_IID%),' + chCR +
    '    version(1.0),' + chCR +
    '    helpstring("Dispatch interface for %TOOLS_PROP_NAME% Control"),' + chCR +
    '    dual,' + chCR +
    '    oleautomation' + chCR +
    '  ]' + chCR +
    '  interface I%TOOLS_PROP_NAME%: IDispatch' + chCR +
    '  {' + chCR +
    '    [propget, id(0x00000001), hidden]' + chCR +
    '    HRESULT _stdcall Visible([out, retval] VARIANT_BOOL* Value);' + chCR +
    '    [propput, id(0x00000001), hidden]' + chCR +
    '    HRESULT _stdcall Visible([in] VARIANT_BOOL Value);' + chCR +
    '    [propget, id(0x00000002)]' + chCR +
    '    HRESULT _stdcall AutoScroll([out, retval] VARIANT_BOOL* Value);' + chCR +
    '    [propput, id(0x00000002)]' + chCR +
    '    HRESULT _stdcall AutoScroll([in] VARIANT_BOOL Value);' + chCR +
    '    [propget, id(0x00000003)]' + chCR +
    '    HRESULT _stdcall AutoSize([out, retval] VARIANT_BOOL* Value);' + chCR +
    '    [propput, id(0x00000003)]' + chCR +
    '    HRESULT _stdcall AutoSize([in] VARIANT_BOOL Value);' + chCR +
    '    [propget, id(0x00000004)]' + chCR +
    '    HRESULT _stdcall AxBorderStyle([out, retval] enum TxActiveFormBorderStyle* Value);' + chCR +
    '    [propput, id(0x00000004)]' + chCR +
    '    HRESULT _stdcall AxBorderStyle([in] enum TxActiveFormBorderStyle Value);' + chCR +
    '    [propget, id(0xFFFFFDFA)]' + chCR +
    '    HRESULT _stdcall Caption([out, retval] BSTR* Value);' + chCR +
    '    [propput, id(0xFFFFFDFA)]' + chCR +
    '    HRESULT _stdcall Caption([in] BSTR Value);' + chCR +
    '    [propget, id(0x00000005)]' + chCR +
    '    HRESULT _stdcall Color([out, retval] long* Value);' + chCR +
    '    [propput, id(0x00000005)]' + chCR +
    '    HRESULT _stdcall Color([in] long Value);' + chCR +
    '    [propget, id(0x00000006)]' + chCR +
    '    HRESULT _stdcall KeyPreview([out, retval] VARIANT_BOOL* Value);' + chCR +
    '    [propput, id(0x00000006)]' + chCR +
    '    HRESULT _stdcall KeyPreview([in] VARIANT_BOOL Value);' + chCR +
    '    [propget, id(0x00000007)]' + chCR +
    '    HRESULT _stdcall PixelsPerInch([out, retval] long* Value);' + chCR +
    '    [propput, id(0x00000007)]' + chCR +
    '    HRESULT _stdcall PixelsPerInch([in] long Value);' + chCR +
    '    [propget, id(0x00000008)]' + chCR +
    '    HRESULT _stdcall PrintScale([out, retval] enum TxPrintScale* Value);' + chCR +
    '    [propput, id(0x00000008)]' + chCR +
    '    HRESULT _stdcall PrintScale([in] enum TxPrintScale Value);' + chCR +
    '    [propget, id(0x00000009)]' + chCR +
    '    HRESULT _stdcall Scaled([out, retval] VARIANT_BOOL* Value);' + chCR +
    '    [propput, id(0x00000009)]' + chCR +
    '    HRESULT _stdcall Scaled([in] VARIANT_BOOL Value);' + chCR +
    '    [propget, id(0x0000000A), hidden]' + chCR +
    '    HRESULT _stdcall Active([out, retval] VARIANT_BOOL* Value);' + chCR +
    '    [propget, id(0x0000000B), hidden]' + chCR +
    '    HRESULT _stdcall DropTarget([out, retval] VARIANT_BOOL* Value);' + chCR +
    '    [propput, id(0x0000000B), hidden]' + chCR +
    '    HRESULT _stdcall DropTarget([in] VARIANT_BOOL Value);' + chCR +
    '    [propget, id(0x0000000C), hidden]' + chCR +
    '    HRESULT _stdcall HelpFile([out, retval] BSTR* Value);' + chCR +
    '    [propput, id(0x0000000C), hidden]' + chCR +
    '    HRESULT _stdcall HelpFile([in] BSTR Value);' + chCR +
    '    [propget, id(0x0000000D), hidden]' + chCR +
    '    HRESULT _stdcall DoubleBuffered([out, retval] VARIANT_BOOL* Value);' + chCR +
    '    [propput, id(0x0000000D), hidden]' + chCR +
    '    HRESULT _stdcall DoubleBuffered([in] VARIANT_BOOL Value);' + chCR +
    '    [propget, id(0x0000000E), hidden]' + chCR +
    '    HRESULT _stdcall VisibleDockClientCount([out, retval] long* Value);' + chCR +
    '    [propget, id(0xFFFFFDFE), hidden]' + chCR +
    '    HRESULT _stdcall Enabled([out, retval] VARIANT_BOOL* Value);' + chCR +
    '    [propput, id(0xFFFFFDFE), hidden]' + chCR +
    '    HRESULT _stdcall Enabled([in] VARIANT_BOOL Value);' + chCR +
    '    [propget, id(0x0000000F)]' + chCR +
    '    HRESULT _stdcall Cursor([out, retval] short* Value);' + chCR +
    '    [propput, id(0x0000000F)]' + chCR +
    '    HRESULT _stdcall Cursor([in] short Value);' + chCR +
    '  };' + chCR +
    chCR +
    '  [' + chCR +
    '    uuid(%TOOLS_DIID%),' + chCR +
    '    version(1.0),' + chCR +
    '    helpstring("Events interface for %TOOLS_PROP_NAME% Control")' + chCR +
    '  ]' + chCR +
    '  dispinterface I%TOOLS_PROP_NAME%Events' + chCR +
    '  {' + chCR +
    '    properties:' + chCR +
    '    methods:' + chCR +
    '    [id(0x00000001)]' + chCR +
    '    void OnActivate(void);' + chCR +
    '    [id(0x00000002)]' + chCR +
    '    void OnClick(void);' + chCR +
    '    [id(0x00000003)]' + chCR +
    '    void OnCreate(void);' + chCR +
    '    [id(0x00000005)]' + chCR +
    '    void OnDblClick(void);' + chCR +
    '    [id(0x00000006)]' + chCR +
    '    void OnDestroy(void);' + chCR +
    '    [id(0x00000007)]' + chCR +
    '    void OnDeactivate(void);' + chCR +
    '    [id(0x0000000B)]' + chCR +
    '    void OnKeyPress([in, out] short* Key);' + chCR +
    '    [id(0x00000010)]' + chCR +
    '    void OnPaint(void);' + chCR +
    '  };' + chCR +
    chCR +
    '  [' + chCR +
    '    uuid(%TOOLS_CLSID%),' + chCR +
    '    version(1.0),' + chCR +
    '    helpstring("%TOOLS_PROP_NAME% Control"),' + chCR +
    '    control' + chCR +
    '  ]' + chCR +
    '  coclass %TOOLS_PROP_NAME%' + chCR +
    '  {' + chCR +
    '    [default] interface I%TOOLS_PROP_NAME%;' + chCR +
    '    [default, source] dispinterface I%TOOLS_PROP_NAME%Events;' + chCR +
    '  };' +
    chCR;

  RIDLModule: string =
    '[' + chCR +
    '  uuid(%LIBID%),' + chCR +
    '  version(1.0),' + chCR +
    '  helpstring("%PROJECT_NAME% Library")' + chCR +
    chCR +
    ']' + chCR +
    'library %PROJECT_NAME%' + chCR +
    '{' + chCR +
    chCR +
    '  importlib("stdole2.tlb");' + chCR +
    chCR +
    '  interface I%COCLASS_NAME%;' + chCR +
    '  coclass %COCLASS_NAME%;' + chCR +
    '%RIDLLBModule%' + chCR +
    '%RIDLModuleEnum%' + chCR +
    '  [' + chCR +
    '    uuid(%IID%),' + chCR +
    '    version(1.0),' + chCR +
    '    helpstring("Dispatch interface for %COCLASS_NAME% Object"),' + chCR +
    '    dual,' + chCR +
    '    oleautomation' + chCR +
    '  ]' + chCR +
    '  interface I%COCLASS_NAME%: IDispatch' + chCR +
    '  {' + chCR +
    '  };' + chCR +
    chCR +
    '  [' + chCR +
    '    uuid(%CLSID%),' + chCR +
    '    version(1.0),' + chCR +
    '    helpstring("%COCLASS_NAME% Object")' + chCR +
    '  ]' + chCR +
    '  coclass %COCLASS_NAME%' + chCR +
    '  {' + chCR +
    '    [default] interface I%COCLASS_NAME%;' + chCR +
    '  };' + chCR +
    '%RIDLModuleTools%'+ chCR +
    '};' + chCR;

//------------------------------------------------------------------------------
  OutlookProjectModule: string =
    '  %TOOLS_PROP_NAME% in '#39'%TOOLS_PROP_NAME%.pas'#39' {%TOOLS_PROP_NAME%: TActiveForm} {%TOOLS_PROP_NAME%: CoClass},' + chCR;


  ProtectedDeclOptions: string =
    '    procedure OptionsPagesAdd(ASender: TObject;' + chCR +
    '      const Pages: PropertyPages); override;' + chCR;

  ProtectedDeclFolders: string =
    '    procedure NameSpaceOptionsPagesAdd(ASender: TObject;' + chCR +
    '      const Pages: PropertyPages; const Folder: MAPIFolder); override;' + chCR;

  OptionsAddingCode: string =
    '  Pages.Add('#39'%PROJECT_NAME%.%TOOLS_PROP_NAME%'#39', '#39'%TOOLS_PROP_TITLE%'#39');' + chCR;

  FolderConditionalCode: string =
    '  if GetFullFolderName(Folder) = '#39'%FOLDER_NAME%'#39' then' + chCR;

  FolderAddingCode: string =
    '  Pages.Add('#39'%PROJECT_NAME%.%FOLDERS_PROP_NAME%'#39', '#39'%FOLDERS_PROP_TITLE%'#39');' + chCR;

  OptionsCode: string =
    'procedure TAddInModule.OptionsPagesAdd(ASender: TObject; const Pages: PropertyPages);' + chCR +
    'begin' + chCR +
    '%OPTION_ADDING%' +
    'end;' + chCR;

  FoldersCode: string =
    'procedure TAddInModule.NameSpaceOptionsPagesAdd(ASender: TObject;' + chCR +
    '  const Pages: PropertyPages; const Folder: MAPIFolder);' + chCR +
    '' + chCR +
    '  function GetFullFolderName(const AFolder: MAPIFolder): string;' + chCR +
    '  var' + chCR +
    '    IDisp: IDispatch;' + chCR +
    '    Folder: MAPIFolder;' + chCR +
    '  begin' + chCR +
    '    Result := '#39''#39';' + chCR +
    '    Folder := AFolder;' + chCR +
    '    while Assigned(Folder) do begin' + chCR +
    '      Result := '#39'\'#39' + Folder.Name + Result;' + chCR +
    '      try' + chCR +
    '        IDisp := Folder.Parent;' + chCR +
    '        if Assigned(IDisp) then' + chCR +
    '          IDisp.QueryInterface(IID_MAPIFolder, Folder);' + chCR +
    '      except' + chCR +
    '        Break;' + chCR +
    '      end;' + chCR +
    '    end;' + chCR +
    '    IDisp := nil;' + chCR +
    '    Folder := nil;' + chCR +
    '    if Result <> '#39''#39' then Delete(Result, 1, 1);' + chCR +
    '  end;' + chCR +
    '' + chCR +
    'begin' + chCR +
    '%FOLDER_ADDING%' +
    'end;' + chCR;

  // source code of PropertyPage
  PASModule: string =
    'unit %TOOLS_PROP_NAME%;' + chCR +
  {$IFNDEF ADX_VCL5}
    '' + chCR +
    '{$WARN SYMBOL_PLATFORM OFF}' + chCR +
  {$ENDIF}
    '' + chCR +
    'interface' + chCR +
    '' + chCR +
    'uses' + chCR +
    '  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,' + chCR +
    '  ActiveX, AxCtrls, %PROJECT_NAME%_TLB, %PROJECT_NAME%_IMPL, StdVcl,' + chCR +
    '  Outlook2000, StdCtrls;' + chCR +
    '' + chCR +
    'type' + chCR +
    '  T%TOOLS_PROP_NAME% = class(TActiveForm, I%TOOLS_PROP_NAME%, PropertyPage)' + chCR +
    '    Label1: TLabel;' + chCR +
{$IFDEF ADX_VCL11}
    '    //Edit1: TEdit;' + chCR +
    '    //procedure Edit1Change(Sender: TObject);' + chCR +
{$ELSE}
    '    Edit1: TEdit;' + chCR +
    '    procedure Edit1Change(Sender: TObject);' + chCR +
{$ENDIF}
    '  private' + chCR +
    '    FDirty: WordBool;' + chCR +
    '    FPropertyPageSite: PropertyPageSite;' + chCR +
    '    FEvents: I%TOOLS_PROP_NAME%Events;' + chCR +
    '    procedure ActivateEvent(Sender: TObject);' + chCR +
    '    procedure ClickEvent(Sender: TObject);' + chCR +
    '    procedure CreateEvent(Sender: TObject);' + chCR +
    '    procedure DblClickEvent(Sender: TObject);' + chCR +
    '    procedure DeactivateEvent(Sender: TObject);' + chCR +
    '    procedure DestroyEvent(Sender: TObject);' + chCR +
    '    procedure KeyPressEvent(Sender: TObject; var Key: Char);' + chCR +
    '    procedure PaintEvent(Sender: TObject);' + chCR +
    '  protected' + chCR +
    '    procedure DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage); override;' + chCR +
    '    procedure EventSinkChanged(const EventSink: IUnknown); override;' + chCR +
    '    function Get_Active: WordBool; safecall;' + chCR +
    '    function Get_AutoScroll: WordBool; safecall;' + chCR +
    '    function Get_AutoSize: WordBool; safecall;' + chCR +
    '    function Get_AxBorderStyle: TxActiveFormBorderStyle; safecall;' + chCR +
    '    function Get_Caption: WideString; safecall;' + chCR +
    '    function Get_Color: Integer; safecall;' + chCR +
    '    function Get_Cursor: Smallint; safecall;' + chCR +
    '    function Get_DoubleBuffered: WordBool; safecall;' + chCR +
    '    function Get_DropTarget: WordBool; safecall;' + chCR +
    '    function Get_Enabled: WordBool; safecall;' + chCR +
    '    function Get_HelpFile: WideString; safecall;' + chCR +
    '    function Get_KeyPreview: WordBool; safecall;' + chCR +
    '    function Get_PixelsPerInch: Integer; safecall;' + chCR +
    '    function Get_PrintScale: TxPrintScale; safecall;' + chCR +
    '    function Get_Scaled: WordBool; safecall;' + chCR +
    '    function Get_Visible: WordBool; safecall;' + chCR +
    '    function Get_VisibleDockClientCount: Integer; safecall;' + chCR +
    '    procedure Set_AutoScroll(Value: WordBool); safecall;' + chCR +
    '    procedure Set_AutoSize(Value: WordBool); safecall;' + chCR +
    '    procedure Set_AxBorderStyle(Value: TxActiveFormBorderStyle); safecall;' + chCR +
    '    procedure Set_Caption(const Value: WideString); safecall;' + chCR +
    '    procedure Set_Color(Value: Integer); safecall;' + chCR +
    '    procedure Set_Cursor(Value: Smallint); safecall;' + chCR +
    '    procedure Set_DoubleBuffered(Value: WordBool); safecall;' + chCR +
    '    procedure Set_DropTarget(Value: WordBool); safecall;' + chCR +
    '    procedure Set_Enabled(Value: WordBool); safecall;' + chCR +
    '    procedure Set_HelpFile(const Value: WideString); safecall;' + chCR +
    '    procedure Set_KeyPreview(Value: WordBool); safecall;' + chCR +
    '    procedure Set_PixelsPerInch(Value: Integer); safecall;' + chCR +
    '    procedure Set_PrintScale(Value: TxPrintScale); safecall;' + chCR +
    '    procedure Set_Scaled(Value: WordBool); safecall;' + chCR +
    '    procedure Set_Visible(Value: WordBool); safecall;' + chCR +
    '    { Outlook PropertyPage }' + chCR +
    '    function GetPageInfo(var HelpFile: WideString;' + chCR +
    '      var HelpContext: Integer): HResult; stdcall;' + chCR +
    '    function Get_Dirty(out Dirty: WordBool): HResult; stdcall;' + chCR +
    '    function Apply: HResult; stdcall;' + chCR +
    '  public' + chCR +
    '    procedure Initialize; override;' + chCR +
    '    destructor Destroy; override;' + chCR +
    '    //' + chCR +
    '    procedure GetPropertyPageSite;' + chCR +
    '    procedure UpdatePropertyPageSite;' + chCR +
    '  end;' + chCR +
    '' + chCR +
    'implementation' + chCR +
    '' + chCR +
    'uses ComObj, ComServ;' + chCR +
    '' + chCR +
    '{$R *.DFM}' + chCR +
    '' + chCR +
    '{ T%TOOLS_PROP_NAME% }' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage);' + chCR +
    'begin' + chCR +
    '  { Define property pages here.  Property pages are defined by calling' + chCR +
    '    DefinePropertyPage with the class id of the page.  For example,' + chCR +
    '      DefinePropertyPage(Class_%TOOLS_PROP_NAME%); }' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.EventSinkChanged(const EventSink: IUnknown);' + chCR +
    'begin' + chCR +
    '  FEvents := EventSink as I%TOOLS_PROP_NAME%Events;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Initialize;' + chCR +
    'begin' + chCR +
    '  inherited Initialize;' + chCR +
    '  OnActivate := ActivateEvent;' + chCR +
    '  OnClick := ClickEvent;' + chCR +
    '  OnCreate := CreateEvent;' + chCR +
    '  OnDblClick := DblClickEvent;' + chCR +
    '  OnDeactivate := DeactivateEvent;' + chCR +
    '  OnDestroy := DestroyEvent;' + chCR +
    '  OnKeyPress := KeyPressEvent;' + chCR +
    '  OnPaint := PaintEvent;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_Active: WordBool;' + chCR +
    'begin' + chCR +
    '  Result := Active;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_AutoScroll: WordBool;' + chCR +
    'begin' + chCR +
    '  Result := AutoScroll;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_AutoSize: WordBool;' + chCR +
    'begin' + chCR +
    '  Result := AutoSize;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_AxBorderStyle: TxActiveFormBorderStyle;' + chCR +
    'begin' + chCR +
    '  Result := Ord(AxBorderStyle);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_Caption: WideString;' + chCR +
    'begin' + chCR +
    '  Result := WideString(Caption);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_Color: Integer;' + chCR +
    'begin' + chCR +
    '  Result := Integer(Color);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_Cursor: Smallint;' + chCR +
    'begin' + chCR +
    '  Result := Smallint(Cursor);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_DoubleBuffered: WordBool;' + chCR +
    'begin' + chCR +
    '  Result := DoubleBuffered;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_DropTarget: WordBool;' + chCR +
    'begin' + chCR +
    '  Result := DropTarget;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_Enabled: WordBool;' + chCR +
    'begin' + chCR +
    '  Result := Enabled;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_HelpFile: WideString;' + chCR +
    'begin' + chCR +
    '  Result := WideString(HelpFile);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_KeyPreview: WordBool;' + chCR +
    'begin' + chCR +
    '  Result := KeyPreview;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_PixelsPerInch: Integer;' + chCR +
    'begin' + chCR +
    '  Result := PixelsPerInch;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_PrintScale: TxPrintScale;' + chCR +
    'begin' + chCR +
    '  Result := Ord(PrintScale);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_Scaled: WordBool;' + chCR +
    'begin' + chCR +
    '  Result := Scaled;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_Visible: WordBool;' + chCR +
    'begin' + chCR +
    '  Result := Visible;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_VisibleDockClientCount: Integer;' + chCR +
    'begin' + chCR +
    '  Result := VisibleDockClientCount;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.ActivateEvent(Sender: TObject);' + chCR +
    'begin' + chCR +
    '  if FEvents <> nil then FEvents.OnActivate;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.ClickEvent(Sender: TObject);' + chCR +
    'begin' + chCR +
    '  if FEvents <> nil then FEvents.OnClick;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.CreateEvent(Sender: TObject);' + chCR +
    'begin' + chCR +
    '  if FEvents <> nil then FEvents.OnCreate;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.DblClickEvent(Sender: TObject);' + chCR +
    'begin' + chCR +
    '  if FEvents <> nil then FEvents.OnDblClick;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.DeactivateEvent(Sender: TObject);' + chCR +
    'begin' + chCR +
    '  if FEvents <> nil then FEvents.OnDeactivate;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.DestroyEvent(Sender: TObject);' + chCR +
    'begin' + chCR +
    '  if FEvents <> nil then FEvents.OnDestroy;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.KeyPressEvent(Sender: TObject; var Key: Char);' + chCR +
    'var' + chCR +
    '  TempKey: Smallint;' + chCR +
    'begin' + chCR +
    '  TempKey := Smallint(Key);' + chCR +
    '  if FEvents <> nil then FEvents.OnKeyPress(TempKey);' + chCR +
    '  Key := Char(TempKey);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.PaintEvent(Sender: TObject);' + chCR +
    'begin' + chCR +
    '  if FEvents <> nil then FEvents.OnPaint;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_AutoScroll(Value: WordBool);' + chCR +
    'begin' + chCR +
    '  AutoScroll := Value;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_AutoSize(Value: WordBool);' + chCR +
    'begin' + chCR +
    '  AutoSize := Value;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_AxBorderStyle(Value: TxActiveFormBorderStyle);' + chCR +
    'begin' + chCR +
    '  AxBorderStyle := TActiveFormBorderStyle(Value);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_Caption(const Value: WideString);' + chCR +
    'begin' + chCR +
    '  Caption := TCaption(Value);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_Color(Value: Integer);' + chCR +
    'begin' + chCR +
    '  Color := TColor(Value);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_Cursor(Value: Smallint);' + chCR +
    'begin' + chCR +
    '  Cursor := TCursor(Value);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_DoubleBuffered(Value: WordBool);' + chCR +
    'begin' + chCR +
    '  DoubleBuffered := Value;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_DropTarget(Value: WordBool);' + chCR +
    'begin' + chCR +
    '  DropTarget := Value;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_Enabled(Value: WordBool);' + chCR +
    'begin' + chCR +
    '  Enabled := Value;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_HelpFile(const Value: WideString);' + chCR +
    'begin' + chCR +
    '  HelpFile := String(Value);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_KeyPreview(Value: WordBool);' + chCR +
    'begin' + chCR +
    '  KeyPreview := Value;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_PixelsPerInch(Value: Integer);' + chCR +
    'begin' + chCR +
    '  PixelsPerInch := Value;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_PrintScale(Value: TxPrintScale);' + chCR +
    'begin' + chCR +
    '  PrintScale := TPrintScale(Value);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_Scaled(Value: WordBool);' + chCR +
    'begin' + chCR +
    '  Scaled := Value;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_Visible(Value: WordBool);' + chCR +
    'begin' + chCR +
    '  Visible := Value;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'destructor T%TOOLS_PROP_NAME%.Destroy;' + chCR +
    'var' + chCR +
    '  ParkingHandle: HWND;' + chCR +
    'begin' + chCR +
    '  ParkingHandle := FindWindowEx(0, 0, '#39'DAXParkingWindow'#39', nil);' + chCR +
    '  if ParkingHandle <> 0 then' + chCR +
    '    SendMessage(ParkingHandle, WM_CLOSE, 0, 0);' + chCR +
    '  inherited Destroy;' + chCR +
    'end;' + chCR +
    '' + chCR +
    '{ Outlook PropertyPage }' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.GetPageInfo(var HelpFile: WideString;' + chCR +
    '  var HelpContext: Integer): HResult;' + chCR +
    'begin' + chCR +
    '  HelpFile := '#39#39';' + chCR +
    '  HelpContext := 0;' + chCR +
    '  Result := S_OK;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_Dirty(out Dirty: WordBool): HResult;' + chCR +
    'begin' + chCR +
    '  Dirty := FDirty;' + chCR +
    '  Result := S_OK;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Apply: HResult;' + chCR +
    'begin' + chCR +
    '  // TODO - put your code here' + chCR +
    '  FDirty := False;' + chCR +
    '  Result := S_OK;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.GetPropertyPageSite;' + chCR +
    'begin' + chCR +
    '  if FPropertyPageSite = nil then' + chCR +
    '    if Assigned(ActiveFormControl) then' + chCR +
    '      if Assigned(ActiveFormControl.ClientSite) then' + chCR +
    '        ActiveFormControl.ClientSite.QueryInterface(IID_PropertyPageSite, FPropertyPageSite);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.UpdatePropertyPageSite;' + chCR +
    'begin' + chCR +
    '  if Assigned(FPropertyPageSite) and not FDirty then' + chCR +
    '  begin' + chCR +
    '    FDirty := True;' + chCR +
    '    FPropertyPageSite.OnStatusChange;' + chCR +
    '  end;' + chCR +
    'end;' + chCR +
    '' + chCR +
{$IFDEF ADX_VCL11}
    '//procedure T%TOOLS_PROP_NAME%.Edit1Change(Sender: TObject);' + chCR +
    '//begin' + chCR +
    '//  GetPropertyPageSite;' + chCR +
    '//  // TODO - put your code here' + chCR +
    '//  UpdatePropertyPageSite;' + chCR +
    '//end;' + chCR +
{$ELSE}
    'procedure T%TOOLS_PROP_NAME%.Edit1Change(Sender: TObject);' + chCR +
    'begin' + chCR +
    '  GetPropertyPageSite;' + chCR +
    '  // TODO - put your code here' + chCR +
    '  UpdatePropertyPageSite;' + chCR +
    'end;' + chCR +
{$ENDIF}
    '' + chCR +
    'initialization' + chCR +
    '  TActiveFormFactory.Create(' + chCR +
    '    ComServer,' + chCR +
    '    TActiveFormControl,' + chCR +
    '    T%TOOLS_PROP_NAME%,' + chCR +
    '    Class_%TOOLS_PROP_NAME%,' + chCR +
    '    1,' + chCR +
    '    '#39#39',' + chCR +
    '    OLEMISC_SIMPLEFRAME or OLEMISC_ACTSLIKELABEL,' + chCR +
    '    tmApartment);' + chCR +
    'end.' + chCR;

  DFMModuleOptions: string =
    'object %TOOLS_PROP_NAME%: T%TOOLS_PROP_NAME%' + chCR +
    '  Left = 200' + chCR +
    '  Top = 115' + chCR +
    '  Width = 440' + chCR +
    '  Height = 450' + chCR +
    '  AxBorderStyle = afbNone' + chCR +
    '  Caption = '#39'%TOOLS_PROP_NAME%'#39 + chCR +
    '  Color = clBtnFace' + chCR +
    '  Font.Charset = DEFAULT_CHARSET' + chCR +
    '  Font.Color = clWindowText' + chCR +
    '  Font.Height = -11' + chCR +
    '  Font.Name = '#39'MS Sans Serif'#39 + chCR +
    '  Font.Style = []' + chCR +
    '  OldCreateOrder = False' + chCR +
    '  PixelsPerInch = 96' + chCR +
    '  TextHeight = 13' + chCR +
    '  object Label1: TLabel' + chCR +
    '    Left = 20' + chCR +
    '    Top = 5' + chCR +
    '    Width = 179' + chCR +
    '    Height = 34' + chCR +
    '    Caption = '#39'OptionsPage'#39 + chCR +
    '    Font.Charset = DEFAULT_CHARSET' + chCR +
    '    Font.Color = clBtnShadow' + chCR +
    '    Font.Height = -29' + chCR +
    '    Font.Name = '#39'Arial'#39 + chCR +
    '    Font.Style = [fsBold]' + chCR +
    '    ParentFont = False' + chCR +
    '  end' + chCR +
{$IFNDEF ADX_VCL11}
    '  object Edit1: TEdit' + chCR +
    '    Left = 20' + chCR +
    '    Top = 50' + chCR +
    '    Width = 121' + chCR +
    '    Height = 21' + chCR +
    '    TabOrder = 0' + chCR +
    '    Text = '#39'Edit1'#39 + chCR +
    '    OnChange = Edit1Change' + chCR +
    '  end' + chCR +
{$ENDIF}
    'end' + chCR;

  DFMModuleFolders: string =
    'object %TOOLS_PROP_NAME%: T%TOOLS_PROP_NAME%' + chCR +
    '  Left = 200' + chCR +
    '  Top = 115' + chCR +
    '  Width = 440' + chCR +
    '  Height = 450' + chCR +
    '  AxBorderStyle = afbNone' + chCR +
    '  Caption = '#39'%TOOLS_PROP_NAME%'#39 + chCR +
    '  Color = clBtnFace' + chCR +
    '  Font.Charset = DEFAULT_CHARSET' + chCR +
    '  Font.Color = clWindowText' + chCR +
    '  Font.Height = -11' + chCR +
    '  Font.Name = '#39'MS Sans Serif'#39 + chCR +
    '  Font.Style = []' + chCR +
    '  OldCreateOrder = False' + chCR +
    '  PixelsPerInch = 96' + chCR +
    '  TextHeight = 13' + chCR +
    '  object Label1: TLabel' + chCR +
    '    Left = 20' + chCR +
    '    Top = 5' + chCR +
    '    Width = 179' + chCR +
    '    Height = 34' + chCR +
    '    Caption = '#39'PropPage'#39 + chCR +
    '    Font.Charset = DEFAULT_CHARSET' + chCR +
    '    Font.Color = clBtnShadow' + chCR +
    '    Font.Height = -29' + chCR +
    '    Font.Name = '#39'Arial'#39 + chCR +
    '    Font.Style = [fsBold]' + chCR +
    '    ParentFont = False' + chCR +
    '  end' + chCR +
{$IFNDEF ADX_VCL11}
    '  object Edit1: TEdit' + chCR +
    '    Left = 20' + chCR +
    '    Top = 50' + chCR +
    '    Width = 121' + chCR +
    '    Height = 21' + chCR +
    '    TabOrder = 0' + chCR +
    '    Text = '#39'Edit1'#39 + chCR +
    '    OnChange = Edit1Change' + chCR +
    '  end' + chCR +
{$ENDIF}
    'end' + chCR;

  // source code of Task Pane
  TaskPanePASModule: string =
    'unit %TOOLS_PROP_NAME%;' + chCR +
  {$IFNDEF ADX_VCL5}
    '' + chCR +
    '{$WARN SYMBOL_PLATFORM OFF}' + chCR +
  {$ENDIF}
    '' + chCR +
    'interface' + chCR +
    '' + chCR +
    'uses' + chCR +
    '  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,' + chCR +
    '  ActiveX, AxCtrls, %PROJECT_NAME%_TLB, %PROJECT_NAME%_IMPL, StdVcl,' + chCR +
    '  StdCtrls;' + chCR +
    '' + chCR +
    'type' + chCR +
    '  T%TOOLS_PROP_NAME% = class(TActiveForm, I%TOOLS_PROP_NAME%)' + chCR +
    '    Label1: TLabel;' + chCR +
    '  private' + chCR +
    '    FEvents: I%TOOLS_PROP_NAME%Events;' + chCR +
    '    procedure ActivateEvent(Sender: TObject);' + chCR +
    '    procedure ClickEvent(Sender: TObject);' + chCR +
    '    procedure CreateEvent(Sender: TObject);' + chCR +
    '    procedure DblClickEvent(Sender: TObject);' + chCR +
    '    procedure DeactivateEvent(Sender: TObject);' + chCR +
    '    procedure DestroyEvent(Sender: TObject);' + chCR +
    '    procedure KeyPressEvent(Sender: TObject; var Key: Char);' + chCR +
    '    procedure PaintEvent(Sender: TObject);' + chCR +
    '    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;' + chCR +
    '  protected' + chCR +
    '    procedure DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage); override;' + chCR +
    '    procedure EventSinkChanged(const EventSink: IUnknown); override;' + chCR +
    '    function Get_Active: WordBool; safecall;' + chCR +
    '    function Get_AutoScroll: WordBool; safecall;' + chCR +
    '    function Get_AutoSize: WordBool; safecall;' + chCR +
    '    function Get_AxBorderStyle: TxActiveFormBorderStyle; safecall;' + chCR +
    '    function Get_Caption: WideString; safecall;' + chCR +
    '    function Get_Color: Integer; safecall;' + chCR +
    '    function Get_Cursor: Smallint; safecall;' + chCR +
    '    function Get_DoubleBuffered: WordBool; safecall;' + chCR +
    '    function Get_DropTarget: WordBool; safecall;' + chCR +
    '    function Get_Enabled: WordBool; safecall;' + chCR +
    '    function Get_HelpFile: WideString; safecall;' + chCR +
    '    function Get_KeyPreview: WordBool; safecall;' + chCR +
    '    function Get_PixelsPerInch: Integer; safecall;' + chCR +
    '    function Get_PrintScale: TxPrintScale; safecall;' + chCR +
    '    function Get_Scaled: WordBool; safecall;' + chCR +
    '    function Get_Visible: WordBool; safecall;' + chCR +
    '    function Get_VisibleDockClientCount: Integer; safecall;' + chCR +
    '    procedure Set_AutoScroll(Value: WordBool); safecall;' + chCR +
    '    procedure Set_AutoSize(Value: WordBool); safecall;' + chCR +
    '    procedure Set_AxBorderStyle(Value: TxActiveFormBorderStyle); safecall;' + chCR +
    '    procedure Set_Caption(const Value: WideString); safecall;' + chCR +
    '    procedure Set_Color(Value: Integer); safecall;' + chCR +
    '    procedure Set_Cursor(Value: Smallint); safecall;' + chCR +
    '    procedure Set_DoubleBuffered(Value: WordBool); safecall;' + chCR +
    '    procedure Set_DropTarget(Value: WordBool); safecall;' + chCR +
    '    procedure Set_Enabled(Value: WordBool); safecall;' + chCR +
    '    procedure Set_HelpFile(const Value: WideString); safecall;' + chCR +
    '    procedure Set_KeyPreview(Value: WordBool); safecall;' + chCR +
    '    procedure Set_PixelsPerInch(Value: Integer); safecall;' + chCR +
    '    procedure Set_PrintScale(Value: TxPrintScale); safecall;' + chCR +
    '    procedure Set_Scaled(Value: WordBool); safecall;' + chCR +
    '    procedure Set_Visible(Value: WordBool); safecall;' + chCR +
    '  public' + chCR +
    '    procedure Initialize; override;' + chCR +
    '    destructor Destroy; override;' + chCR +
    '  end;' + chCR +
    '' + chCR +
    'implementation' + chCR +
    '' + chCR +
    'uses ComObj, ComServ;' + chCR +
    '' + chCR +
    '{$R *.DFM}' + chCR +
    '' + chCR +
    '{ T%TOOLS_PROP_NAME% }' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage);' + chCR +
    'begin' + chCR +
    '  { Define property pages here.  Property pages are defined by calling' + chCR +
    '    DefinePropertyPage with the class id of the page.  For example,' + chCR +
    '      DefinePropertyPage(Class_%TOOLS_PROP_NAME%); }' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.EventSinkChanged(const EventSink: IUnknown);' + chCR +
    'begin' + chCR +
    '  FEvents := EventSink as I%TOOLS_PROP_NAME%Events;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Initialize;' + chCR +
    'begin' + chCR +
    '  inherited Initialize;' + chCR +
    '  OnActivate := ActivateEvent;' + chCR +
    '  OnClick := ClickEvent;' + chCR +
    '  OnCreate := CreateEvent;' + chCR +
    '  OnDblClick := DblClickEvent;' + chCR +
    '  OnDeactivate := DeactivateEvent;' + chCR +
    '  OnDestroy := DestroyEvent;' + chCR +
    '  OnKeyPress := KeyPressEvent;' + chCR +
    '  OnPaint := PaintEvent;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_Active: WordBool;' + chCR +
    'begin' + chCR +
    '  Result := Active;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_AutoScroll: WordBool;' + chCR +
    'begin' + chCR +
    '  Result := AutoScroll;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_AutoSize: WordBool;' + chCR +
    'begin' + chCR +
    '  Result := AutoSize;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_AxBorderStyle: TxActiveFormBorderStyle;' + chCR +
    'begin' + chCR +
    '  Result := Ord(AxBorderStyle);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_Caption: WideString;' + chCR +
    'begin' + chCR +
    '  Result := WideString(Caption);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_Color: Integer;' + chCR +
    'begin' + chCR +
    '  Result := Integer(Color);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_Cursor: Smallint;' + chCR +
    'begin' + chCR +
    '  Result := Smallint(Cursor);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_DoubleBuffered: WordBool;' + chCR +
    'begin' + chCR +
    '  Result := DoubleBuffered;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_DropTarget: WordBool;' + chCR +
    'begin' + chCR +
    '  Result := DropTarget;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_Enabled: WordBool;' + chCR +
    'begin' + chCR +
    '  Result := Enabled;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_HelpFile: WideString;' + chCR +
    'begin' + chCR +
    '  Result := WideString(HelpFile);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_KeyPreview: WordBool;' + chCR +
    'begin' + chCR +
    '  Result := KeyPreview;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_PixelsPerInch: Integer;' + chCR +
    'begin' + chCR +
    '  Result := PixelsPerInch;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_PrintScale: TxPrintScale;' + chCR +
    'begin' + chCR +
    '  Result := Ord(PrintScale);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_Scaled: WordBool;' + chCR +
    'begin' + chCR +
    '  Result := Scaled;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_Visible: WordBool;' + chCR +
    'begin' + chCR +
    '  Result := Visible;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function T%TOOLS_PROP_NAME%.Get_VisibleDockClientCount: Integer;' + chCR +
    'begin' + chCR +
    '  Result := VisibleDockClientCount;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.ActivateEvent(Sender: TObject);' + chCR +
    'begin' + chCR +
    '  if FEvents <> nil then FEvents.OnActivate;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.ClickEvent(Sender: TObject);' + chCR +
    'begin' + chCR +
    '  if FEvents <> nil then FEvents.OnClick;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.CreateEvent(Sender: TObject);' + chCR +
    'begin' + chCR +
    '  if FEvents <> nil then FEvents.OnCreate;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.DblClickEvent(Sender: TObject);' + chCR +
    'begin' + chCR +
    '  if FEvents <> nil then FEvents.OnDblClick;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.DeactivateEvent(Sender: TObject);' + chCR +
    'begin' + chCR +
    '  if FEvents <> nil then FEvents.OnDeactivate;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.DestroyEvent(Sender: TObject);' + chCR +
    'begin' + chCR +
    '  if FEvents <> nil then FEvents.OnDestroy;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.KeyPressEvent(Sender: TObject; var Key: Char);' + chCR +
    'var' + chCR +
    '  TempKey: Smallint;' + chCR +
    'begin' + chCR +
    '  TempKey := Smallint(Key);' + chCR +
    '  if FEvents <> nil then FEvents.OnKeyPress(TempKey);' + chCR +
    '  Key := Char(TempKey);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.PaintEvent(Sender: TObject);' + chCR +
    'begin' + chCR +
    '  if FEvents <> nil then FEvents.OnPaint;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_AutoScroll(Value: WordBool);' + chCR +
    'begin' + chCR +
    '  AutoScroll := Value;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_AutoSize(Value: WordBool);' + chCR +
    'begin' + chCR +
    '  AutoSize := Value;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_AxBorderStyle(Value: TxActiveFormBorderStyle);' + chCR +
    'begin' + chCR +
    '  AxBorderStyle := TActiveFormBorderStyle(Value);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_Caption(const Value: WideString);' + chCR +
    'begin' + chCR +
    '  Caption := TCaption(Value);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_Color(Value: Integer);' + chCR +
    'begin' + chCR +
    '  Color := TColor(Value);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_Cursor(Value: Smallint);' + chCR +
    'begin' + chCR +
    '  Cursor := TCursor(Value);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_DoubleBuffered(Value: WordBool);' + chCR +
    'begin' + chCR +
    '  DoubleBuffered := Value;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_DropTarget(Value: WordBool);' + chCR +
    'begin' + chCR +
    '  DropTarget := Value;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_Enabled(Value: WordBool);' + chCR +
    'begin' + chCR +
    '  Enabled := Value;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_HelpFile(const Value: WideString);' + chCR +
    'begin' + chCR +
    '  HelpFile := String(Value);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_KeyPreview(Value: WordBool);' + chCR +
    'begin' + chCR +
    '  KeyPreview := Value;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_PixelsPerInch(Value: Integer);' + chCR +
    'begin' + chCR +
    '  PixelsPerInch := Value;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_PrintScale(Value: TxPrintScale);' + chCR +
    'begin' + chCR +
    '  PrintScale := TPrintScale(Value);' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_Scaled(Value: WordBool);' + chCR +
    'begin' + chCR +
    '  Scaled := Value;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.Set_Visible(Value: WordBool);' + chCR +
    'begin' + chCR +
    '  Visible := Value;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'destructor T%TOOLS_PROP_NAME%.Destroy;' + chCR +
    'var' + chCR +
    '  ParkingHandle: HWND;' + chCR +
    'begin' + chCR +
    '  ParkingHandle := FindWindowEx(0, 0, '#39'DAXParkingWindow'#39', nil);' + chCR +
    '  if ParkingHandle <> 0 then' + chCR +
    '    SendMessage(ParkingHandle, WM_CLOSE, 0, 0);' + chCR +
    '  inherited Destroy;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'function SearchForHWND(const AControl: TWinControl; Focused: HWND): boolean;' + chCR +
    'var' + chCR +
    '  i: Integer;' + chCR +
    'begin' + chCR +
    '  Result := (AControl.Handle = Focused);' + chCR +
    '  if not Result then' + chCR +
    '    for i := 0 to AControl.ControlCount - 1 do' + chCR +
    '      if AControl.Controls[i] is TWinControl then begin' + chCR +
    '        if TWinControl(AControl.Controls[i]).Handle = Focused then begin' + chCR +
    '          Result := True;' + chCR +
    '          Break;' + chCR +
    '        end' + chCR +
    '        else' + chCR +
    '          if TWinControl(AControl.Controls[i]).ControlCount > 0 then begin' + chCR +
    '            Result := SearchForHWND(TWinControl(AControl.Controls[i]), Focused);' + chCR +
    '            if Result then Break;' + chCR +
    '          end;' + chCR +
    '      end;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'procedure T%TOOLS_PROP_NAME%.WMMouseActivate(var Message: TWMMouseActivate);' + chCR +
    'var' + chCR +
    '  FocusedWindow: HWND;' + chCR +
    '  CursorPos: TPoint;' + chCR +
    'begin' + chCR +
    '  inherited;' + chCR +
    '  FocusedWindow := Windows.GetFocus;' + chCR +
    '  if not SearchForHWND(Self, FocusedWindow) then begin' + chCR +
    '    Windows.GetCursorPos(CursorPos);' + chCR +
    '    FocusedWindow := WindowFromPoint(CursorPos);' + chCR +
    '    Windows.SetFocus(FocusedWindow);' + chCR +
    '    Message.Result := MA_ACTIVATE;' + chCR +
    '  end;' + chCR +
    'end;' + chCR +
    '' + chCR +
    'initialization' + chCR +
    '  TActiveFormFactory.Create(' + chCR +
    '    ComServer,' + chCR +
    '    TActiveFormControl,' + chCR +
    '    T%TOOLS_PROP_NAME%,' + chCR +
    '    Class_%TOOLS_PROP_NAME%,' + chCR +
    '    1,' + chCR +
    '    '#39#39',' + chCR +
    '    OLEMISC_SIMPLEFRAME or OLEMISC_ACTSLIKELABEL,' + chCR +
    '    tmApartment);' + chCR +
    'end.' + chCR;

  TaskPaneDFMModuleOptions: string =
    'object %TOOLS_PROP_NAME%: T%TOOLS_PROP_NAME%' + chCR +
    '  Left = 200' + chCR +
    '  Top = 115' + chCR +
    '  Width = 440' + chCR +
    '  Height = 450' + chCR +
    '  AxBorderStyle = afbNone' + chCR +
    '  Caption = '#39'%TOOLS_PROP_NAME%'#39 + chCR +
    '  Color = clBtnFace' + chCR +
    '  Font.Charset = DEFAULT_CHARSET' + chCR +
    '  Font.Color = clWindowText' + chCR +
    '  Font.Height = -11' + chCR +
    '  Font.Name = '#39'MS Sans Serif'#39 + chCR +
    '  Font.Style = []' + chCR +
    '  OldCreateOrder = False' + chCR +
    '  PixelsPerInch = 96' + chCR +
    '  TextHeight = 13' + chCR +
    '  object Label1: TLabel' + chCR +
    '    Left = 20' + chCR +
    '    Top = 5' + chCR +
    '    Width = 135' + chCR +
    '    Height = 34' + chCR +
    '    Caption = '#39'Task Pane'#39 + chCR +
    '    Font.Charset = DEFAULT_CHARSET' + chCR +
    '    Font.Color = clBtnShadow' + chCR +
    '    Font.Height = -29' + chCR +
    '    Font.Name = '#39'Arial'#39 + chCR +
    '    Font.Style = [fsBold]' + chCR +
    '    ParentFont = False' + chCR +
    '  end' + chCR +
    'end' + chCR;

  TToolsLBModule: string =
    '  IID_I%TOOLS_PROP_NAME%: TGUID = '#39'%TOOLS_IID%'#39';' + chCR +
    '  DIID_I%TOOLS_PROP_NAME%Events: TGUID = '#39'%TOOLS_DIID%'#39';' + chCR +
    '  CLASS_%TOOLS_PROP_NAME%: TGUID = '#39'%TOOLS_CLSID%'#39';' + chCR;

  TFoldersLBModule: string =
    '  IID_I%FOLDERS_PROP_NAME%: TGUID = '#39'%FOLDERS_IID%'#39';' + chCR +
    '  DIID_I%FOLDERS_PROP_NAME%Events: TGUID = '#39'%FOLDERS_DIID%'#39';' + chCR +
    '  CLASS_%FOLDERS_PROP_NAME%: TGUID = '#39'%FOLDERS_CLSID%'#39';' + chCR;

  TPropPageProperties: string =
    '' + chCR +
    '// Constants for enum TxActiveFormBorderStyle' + chCR +
    'type' + chCR +
    '  TxActiveFormBorderStyle = TOleEnum;' + chCR +
    'const' + chCR +
    '  afbNone = $00000000;' + chCR +
    '  afbSingle = $00000001;' + chCR +
    '  afbSunken = $00000002;' + chCR +
    '  afbRaised = $00000003;' + chCR +
    '' + chCR +
    '// Constants for enum TxPrintScale' + chCR +
    'type' + chCR +
    '  TxPrintScale = TOleEnum;' + chCR +
    'const' + chCR +
    '  poNone = $00000000;' + chCR +
    '  poProportional = $00000001;' + chCR +
    '  poPrintToFit = $00000002;' + chCR +
    '' + chCR +
    '// Constants for enum TxMouseButton' + chCR +
    'type' + chCR +
    '  TxMouseButton = TOleEnum;' + chCR +
    'const' + chCR +
    '  mbLeft = $00000000;' + chCR +
    '  mbRight = $00000001;' + chCR +
    '  mbMiddle = $00000002;';

  TLBModule2: string =
  'type' + chCR +
  '  I%TOOLS_PROP_NAME% = interface(IDispatch)' + chCR +
  '    ['#39'%TOOLS_IID%'#39']' + chCR +
  '    function  Get_Visible: WordBool; safecall;' + chCR +
  '    procedure Set_Visible(Value: WordBool); safecall;' + chCR +
  '    function  Get_AutoScroll: WordBool; safecall;' + chCR +
  '    procedure Set_AutoScroll(Value: WordBool); safecall;' + chCR +
  '    function  Get_AutoSize: WordBool; safecall;' + chCR +
  '    procedure Set_AutoSize(Value: WordBool); safecall;' + chCR +
  '    function  Get_AxBorderStyle: TxActiveFormBorderStyle; safecall;' + chCR +
  '    procedure Set_AxBorderStyle(Value: TxActiveFormBorderStyle); safecall;' + chCR +
  '    function  Get_Caption: WideString; safecall;' + chCR +
  '    procedure Set_Caption(const Value: WideString); safecall;' + chCR +
  '    function  Get_Color: Integer; safecall;' + chCR +
  '    procedure Set_Color(Value: Integer); safecall;' + chCR +
  '    function  Get_KeyPreview: WordBool; safecall;' + chCR +
  '    procedure Set_KeyPreview(Value: WordBool); safecall;' + chCR +
  '    function  Get_PixelsPerInch: Integer; safecall;' + chCR +
  '    procedure Set_PixelsPerInch(Value: Integer); safecall;' + chCR +
  '    function  Get_PrintScale: TxPrintScale; safecall;' + chCR +
  '    procedure Set_PrintScale(Value: TxPrintScale); safecall;' + chCR +
  '    function  Get_Scaled: WordBool; safecall;' + chCR +
  '    procedure Set_Scaled(Value: WordBool); safecall;' + chCR +
  '    function  Get_Active: WordBool; safecall;' + chCR +
  '    function  Get_DropTarget: WordBool; safecall;' + chCR +
  '    procedure Set_DropTarget(Value: WordBool); safecall;' + chCR +
  '    function  Get_HelpFile: WideString; safecall;' + chCR +
  '    procedure Set_HelpFile(const Value: WideString); safecall;' + chCR +
  '    function  Get_DoubleBuffered: WordBool; safecall;' + chCR +
  '    procedure Set_DoubleBuffered(Value: WordBool); safecall;' + chCR +
  '    function  Get_VisibleDockClientCount: Integer; safecall;' + chCR +
  '    function  Get_Enabled: WordBool; safecall;' + chCR +
  '    procedure Set_Enabled(Value: WordBool); safecall;' + chCR +
  '    function  Get_Cursor: Smallint; safecall;' + chCR +
  '    procedure Set_Cursor(Value: Smallint); safecall;' + chCR +
  '    property Visible: WordBool read Get_Visible write Set_Visible;' + chCR +
  '    property AutoScroll: WordBool read Get_AutoScroll write Set_AutoScroll;' + chCR +
  '    property AutoSize: WordBool read Get_AutoSize write Set_AutoSize;' + chCR +
  '    property AxBorderStyle: TxActiveFormBorderStyle read Get_AxBorderStyle write Set_AxBorderStyle;' + chCR +
  '    property Caption: WideString read Get_Caption write Set_Caption;' + chCR +
  '    property Color: Integer read Get_Color write Set_Color;' + chCR +
  '    property KeyPreview: WordBool read Get_KeyPreview write Set_KeyPreview;' + chCR +
  '    property PixelsPerInch: Integer read Get_PixelsPerInch write Set_PixelsPerInch;' + chCR +
  '    property PrintScale: TxPrintScale read Get_PrintScale write Set_PrintScale;' + chCR +
  '    property Scaled: WordBool read Get_Scaled write Set_Scaled;' + chCR +
  '    property Active: WordBool read Get_Active;' + chCR +
  '    property DropTarget: WordBool read Get_DropTarget write Set_DropTarget;' + chCR +
  '    property HelpFile: WideString read Get_HelpFile write Set_HelpFile;' + chCR +
  '    property DoubleBuffered: WordBool read Get_DoubleBuffered write Set_DoubleBuffered;' + chCR +
  '    property VisibleDockClientCount: Integer read Get_VisibleDockClientCount;' + chCR +
  '    property Enabled: WordBool read Get_Enabled write Set_Enabled;' + chCR +
  '    property Cursor: Smallint read Get_Cursor write Set_Cursor;' + chCR +
  '  end;' + chCR +
  '' + chCR +
  '  I%TOOLS_PROP_NAME%Disp = dispinterface' + chCR +
  '    ['#39'%TOOLS_IID%'#39']' + chCR +
  '    property Visible: WordBool dispid 1;' + chCR +
  '    property AutoScroll: WordBool dispid 2;' + chCR +
  '    property AutoSize: WordBool dispid 3;' + chCR +
  '    property AxBorderStyle: TxActiveFormBorderStyle dispid 4;' + chCR +
  '    property Caption: WideString dispid -518;' + chCR +
  '    property Color: Integer dispid 5;' + chCR +
  '    property KeyPreview: WordBool dispid 6;' + chCR +
  '    property PixelsPerInch: Integer dispid 7;' + chCR +
  '    property PrintScale: TxPrintScale dispid 8;' + chCR +
  '    property Scaled: WordBool dispid 9;' + chCR +
  '    property Active: WordBool readonly dispid 10;' + chCR +
  '    property DropTarget: WordBool dispid 11;' + chCR +
  '    property HelpFile: WideString dispid 12;' + chCR +
  '    property DoubleBuffered: WordBool dispid 13;' + chCR +
  '    property VisibleDockClientCount: Integer readonly dispid 14;' + chCR +
  '    property Enabled: WordBool dispid -514;' + chCR +
  '    property Cursor: Smallint dispid 15;' + chCR +
  '  end;' + chCR +
  '' + chCR +
  '  I%TOOLS_PROP_NAME%Events = dispinterface' + chCR +
  '    ['#39'%TOOLS_DIID%'#39']' + chCR +
  '    procedure OnActivate; dispid 1;' + chCR +
  '    procedure OnClick; dispid 2;' + chCR +
  '    procedure OnCreate; dispid 3;' + chCR +
  '    procedure OnDblClick; dispid 5;' + chCR +
  '    procedure OnDestroy; dispid 6;' + chCR +
  '    procedure OnDeactivate; dispid 7;' + chCR +
  '    procedure OnKeyPress(var Key: Smallint); dispid 11;' + chCR +
  '    procedure OnPaint; dispid 16;' + chCR +
  '  end;' + chCR +
  '' + chCR;



  BdsProjModule: string =
  chBDS +
  '<?xml version="1.0" encoding="utf-8"?>' + chCR +
  '<BorlandProject>' + chCR +
  '  <PersonalityInfo>' + chCR +
  '    <Option>' + chCR +
  '      <Option Name="Personality">Delphi.Personality</Option>' + chCR +
  '      <Option Name="ProjectType"></Option>' + chCR +
  '      <Option Name="Version">1.0</Option>' + chCR +
  '      <Option Name="GUID">%PROJECT_GUID%</Option>' + chCR +
  '    </Option>' + chCR +
  '  </PersonalityInfo>' + chCR +
  '  <Delphi.Personality>' + chCR +
  '    <Source>' + chCR +
  '      <Source Name="MainSource">%PROJECT_NAME%.dpr</Source>' + chCR +
  '    </Source>' + chCR +
  '    <FileVersion>' + chCR +
  '      <FileVersion Name="Version">7.0</FileVersion>' + chCR +
  '    </FileVersion>' + chCR +
  '    <Compiler>' + chCR +
  '      <Compiler Name="A">8</Compiler>' + chCR +
  '      <Compiler Name="B">0</Compiler>' + chCR +
  '      <Compiler Name="C">1</Compiler>' + chCR +
  '      <Compiler Name="D">1</Compiler>' + chCR +
  '      <Compiler Name="E">0</Compiler>' + chCR +
  '      <Compiler Name="F">0</Compiler>' + chCR +
  '      <Compiler Name="G">1</Compiler>' + chCR +
  '      <Compiler Name="H">1</Compiler>' + chCR +
  '      <Compiler Name="I">1</Compiler>' + chCR +
  '      <Compiler Name="J">0</Compiler>' + chCR +
  '      <Compiler Name="K">0</Compiler>' + chCR +
  '      <Compiler Name="L">1</Compiler>' + chCR +
  '      <Compiler Name="M">0</Compiler>' + chCR +
  '      <Compiler Name="N">1</Compiler>' + chCR +
  '      <Compiler Name="O">1</Compiler>' + chCR +
  '      <Compiler Name="P">1</Compiler>' + chCR +
  '      <Compiler Name="Q">0</Compiler>' + chCR +
  '      <Compiler Name="R">0</Compiler>' + chCR +
  '      <Compiler Name="S">0</Compiler>' + chCR +
  '      <Compiler Name="T">0</Compiler>' + chCR +
  '      <Compiler Name="U">0</Compiler>' + chCR +
  '      <Compiler Name="V">1</Compiler>' + chCR +
  '      <Compiler Name="W">0</Compiler>' + chCR +
  '      <Compiler Name="X">1</Compiler>' + chCR +
  '      <Compiler Name="Y">1</Compiler>' + chCR +
  '      <Compiler Name="Z">1</Compiler>' + chCR +
  '      <Compiler Name="ShowHints">True</Compiler>' + chCR +
  '      <Compiler Name="ShowWarnings">True</Compiler>' + chCR +
  '      <Compiler Name="UnitAliases">WinTypes=Windows;WinProcs=Windows;DbiTypes=BDE;DbiProcs=BDE;DbiErrs=BDE;</Compiler>' + chCR +
  '      <Compiler Name="NamespacePrefix"></Compiler>' + chCR +
  '      <Compiler Name="GenerateDocumentation">False</Compiler>' + chCR +
  '      <Compiler Name="DefaultNamespace"></Compiler>' + chCR +
  '      <Compiler Name="SymbolDeprecated">True</Compiler>' + chCR +
  '      <Compiler Name="SymbolLibrary">True</Compiler>' + chCR +
  '      <Compiler Name="SymbolPlatform">True</Compiler>' + chCR +
  '      <Compiler Name="SymbolExperimental">True</Compiler>' + chCR +
  '      <Compiler Name="UnitLibrary">True</Compiler>' + chCR +
  '      <Compiler Name="UnitPlatform">True</Compiler>' + chCR +
  '      <Compiler Name="UnitDeprecated">True</Compiler>' + chCR +
  '      <Compiler Name="UnitExperimental">True</Compiler>' + chCR +
  '      <Compiler Name="HResultCompat">True</Compiler>' + chCR +
  '      <Compiler Name="HidingMember">True</Compiler>' + chCR +
  '      <Compiler Name="HiddenVirtual">True</Compiler>' + chCR +
  '      <Compiler Name="Garbage">True</Compiler>' + chCR +
  '      <Compiler Name="BoundsError">True</Compiler>' + chCR +
  '      <Compiler Name="ZeroNilCompat">True</Compiler>' + chCR +
  '      <Compiler Name="StringConstTruncated">True</Compiler>' + chCR +
  '      <Compiler Name="ForLoopVarVarPar">True</Compiler>' + chCR +
  '      <Compiler Name="TypedConstVarPar">True</Compiler>' + chCR +
  '      <Compiler Name="AsgToTypedConst">True</Compiler>' + chCR +
  '      <Compiler Name="CaseLabelRange">True</Compiler>' + chCR +
  '      <Compiler Name="ForVariable">True</Compiler>' + chCR +
  '      <Compiler Name="ConstructingAbstract">True</Compiler>' + chCR +
  '      <Compiler Name="ComparisonFalse">True</Compiler>' + chCR +
  '      <Compiler Name="ComparisonTrue">True</Compiler>' + chCR +
  '      <Compiler Name="ComparingSignedUnsigned">True</Compiler>' + chCR +
  '      <Compiler Name="CombiningSignedUnsigned">True</Compiler>' + chCR +
  '      <Compiler Name="UnsupportedConstruct">True</Compiler>' + chCR +
  '      <Compiler Name="FileOpen">True</Compiler>' + chCR +
  '      <Compiler Name="FileOpenUnitSrc">True</Compiler>' + chCR +
  '      <Compiler Name="BadGlobalSymbol">True</Compiler>' + chCR +
  '      <Compiler Name="DuplicateConstructorDestructor">True</Compiler>' + chCR +
  '      <Compiler Name="InvalidDirective">True</Compiler>' + chCR +
  '      <Compiler Name="PackageNoLink">True</Compiler>' + chCR +
  '      <Compiler Name="PackageThreadVar">True</Compiler>' + chCR +
  '      <Compiler Name="ImplicitImport">True</Compiler>' + chCR +
  '      <Compiler Name="HPPEMITIgnored">True</Compiler>' + chCR +
  '      <Compiler Name="NoRetVal">True</Compiler>' + chCR +
  '      <Compiler Name="UseBeforeDef">True</Compiler>' + chCR +
  '      <Compiler Name="ForLoopVarUndef">True</Compiler>' + chCR +
  '      <Compiler Name="UnitNameMismatch">True</Compiler>' + chCR +
  '      <Compiler Name="NoCFGFileFound">True</Compiler>' + chCR +
  '      <Compiler Name="MessageDirective">True</Compiler>' + chCR +
  '      <Compiler Name="ImplicitVariants">True</Compiler>' + chCR +
  '      <Compiler Name="UnicodeToLocale">True</Compiler>' + chCR +
  '      <Compiler Name="LocaleToUnicode">True</Compiler>' + chCR +
  '      <Compiler Name="ImagebaseMultiple">True</Compiler>' + chCR +
  '      <Compiler Name="SuspiciousTypecast">True</Compiler>' + chCR +
  '      <Compiler Name="PrivatePropAccessor">True</Compiler>' + chCR +
  '      <Compiler Name="UnsafeType">False</Compiler>' + chCR +
  '      <Compiler Name="UnsafeCode">False</Compiler>' + chCR +
  '      <Compiler Name="UnsafeCast">False</Compiler>' + chCR +
  '      <Compiler Name="OptionTruncated">True</Compiler>' + chCR +
  '      <Compiler Name="WideCharReduced">True</Compiler>' + chCR +
  '      <Compiler Name="DuplicatesIgnored">True</Compiler>' + chCR +
  '    </Compiler>' + chCR +
  '    <Linker>' + chCR +
  '      <Linker Name="MapFile">0</Linker>' + chCR +
  '      <Linker Name="OutputObjs">0</Linker>' + chCR +
  '      <Linker Name="ConsoleApp">1</Linker>' + chCR +
  '      <Linker Name="DebugInfo">False</Linker>' + chCR +
  '      <Linker Name="RemoteSymbols">False</Linker>' + chCR +
  '      <Linker Name="GenerateDRC">False</Linker>' + chCR +
  '      <Linker Name="MinStackSize">16384</Linker>' + chCR +
  '      <Linker Name="MaxStackSize">1048576</Linker>' + chCR +
  '      <Linker Name="ImageBase">4194304</Linker>' + chCR +
  '      <Linker Name="ExeDescription"></Linker>' + chCR +
  '    </Linker>' + chCR +
  '    <Directories>' + chCR +
  '      <Directories Name="OutputDir"></Directories>' + chCR +
  '      <Directories Name="UnitOutputDir"></Directories>' + chCR +
  '      <Directories Name="PackageDLLOutputDir"></Directories>' + chCR +
  '      <Directories Name="PackageDCPOutputDir"></Directories>' + chCR +
  '      <Directories Name="SearchPath">$(BDS)\Imports</Directories>' + chCR +
  '      <Directories Name="Packages"></Directories>' + chCR +
  '      <Directories Name="Conditionals"></Directories>' + chCR +
  '      <Directories Name="DebugSourceDirs"></Directories>' + chCR +
  '      <Directories Name="UsePackages">False</Directories>' + chCR +
  '    </Directories>' + chCR +
  '    <Parameters>' + chCR +
  '      <Parameters Name="RunParams"></Parameters>' + chCR +
  '      <Parameters Name="HostApplication"></Parameters>' + chCR +
  '      <Parameters Name="Launcher"></Parameters>' + chCR +
  '      <Parameters Name="UseLauncher">False</Parameters>' + chCR +
  '      <Parameters Name="DebugCWD"></Parameters>' + chCR +
  '      <Parameters Name="RemoteHost"></Parameters>' + chCR +
  '      <Parameters Name="RemotePath"></Parameters>' + chCR +
  '      <Parameters Name="RemoteLauncher"></Parameters>' + chCR +
  '      <Parameters Name="RemoteCWD"></Parameters>' + chCR +
  '      <Parameters Name="RemoteDebug">False</Parameters>' + chCR +
  '    </Parameters>' + chCR +
  '    <Language>' + chCR +
  '      <Language Name="ActiveLang"></Language>' + chCR +
  '      <Language Name="ProjectLang">$00000000</Language>' + chCR +
  '      <Language Name="RootDir"></Language>' + chCR +
  '    </Language>' + chCR +
  '    <VersionInfo>' + chCR +
  '      <VersionInfo Name="IncludeVerInfo">False</VersionInfo>' + chCR +
  '      <VersionInfo Name="AutoIncBuild">False</VersionInfo>' + chCR +
  '      <VersionInfo Name="MajorVer">1</VersionInfo>' + chCR +
  '      <VersionInfo Name="MinorVer">0</VersionInfo>' + chCR +
  '      <VersionInfo Name="Release">0</VersionInfo>' + chCR +
  '      <VersionInfo Name="Build">0</VersionInfo>' + chCR +
  '      <VersionInfo Name="Debug">False</VersionInfo>' + chCR +
  '      <VersionInfo Name="PreRelease">False</VersionInfo>' + chCR +
  '      <VersionInfo Name="Special">False</VersionInfo>' + chCR +
  '      <VersionInfo Name="Private">False</VersionInfo>' + chCR +
  '      <VersionInfo Name="DLL">False</VersionInfo>' + chCR +
  '      <VersionInfo Name="Locale">1033</VersionInfo>' + chCR +
  '      <VersionInfo Name="CodePage">1252</VersionInfo>' + chCR +
  '    </VersionInfo>' + chCR +
  '    <VersionInfoKeys>' + chCR +
  '      <VersionInfoKeys Name="CompanyName"></VersionInfoKeys>' + chCR +
  '      <VersionInfoKeys Name="FileDescription"></VersionInfoKeys>' + chCR +
  '      <VersionInfoKeys Name="FileVersion">1.0.0.0</VersionInfoKeys>' + chCR +
  '      <VersionInfoKeys Name="InternalName"></VersionInfoKeys>' + chCR +
  '      <VersionInfoKeys Name="LegalCopyright"></VersionInfoKeys>' + chCR +
  '      <VersionInfoKeys Name="LegalTrademarks"></VersionInfoKeys>' + chCR +
  '      <VersionInfoKeys Name="OriginalFilename"></VersionInfoKeys>' + chCR +
  '      <VersionInfoKeys Name="ProductName"></VersionInfoKeys>' + chCR +
  '      <VersionInfoKeys Name="ProductVersion">1.0.0.0</VersionInfoKeys>' + chCR +
  '      <VersionInfoKeys Name="Comments"></VersionInfoKeys>' + chCR +
  '    </VersionInfoKeys>' + chCR +
  '  </Delphi.Personality>' + chCR +
  '</BorlandProject>' + chCR +
  '' + chCR;


  D11ProjModule: string =
  chBDS +
  '<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">' + chCR +
  '  <PropertyGroup>' + chCR +
  '    <ProjectGuid>%PROJECT_GUID%</ProjectGuid>' + chCR +
  '    <MainSource>%PROJECT_NAME%.dpr</MainSource>' + chCR +
  '    <Configuration Condition=" '+ chQ+ '$(Configuration)'+ chQ+ ' == '+ chQ+ chQ+ ' ">Debug</Configuration>' + chCR +
  '    <Platform Condition=" '+ chQ+ '$(Platform)'+ chQ+ ' == '+ chQ+ chQ+ ' ">AnyCPU</Platform>' + chCR +
  '    <DCC_DCCCompiler>DCC32</DCC_DCCCompiler>' + chCR +
  '    <DCC_DependencyCheckOutputName>%PROJECT_NAME%.dll</DCC_DependencyCheckOutputName>' + chCR +
  '  </PropertyGroup>' + chCR +
  '  <PropertyGroup Condition=" '+ chQ+ '$(Configuration)|$(Platform)'+ chQ+ ' == '+ chQ+ 'Release|AnyCPU'+ chQ+ ' ">' + chCR +
  '    <Version>7.0</Version>' + chCR +
  '    <DCC_DebugInformation>False</DCC_DebugInformation>' + chCR +
  '    <DCC_LocalDebugSymbols>False</DCC_LocalDebugSymbols>' + chCR +
  '    <DCC_SymbolReferenceInfo>0</DCC_SymbolReferenceInfo>' + chCR +
  '    <DCC_Define>RELEASE</DCC_Define>' + chCR +
  '  </PropertyGroup>' + chCR +
  '  <PropertyGroup Condition=" '+ chQ+ '$(Configuration)|$(Platform)'+ chQ+ ' == '+ chQ+ 'Debug|AnyCPU'+ chQ+ ' ">' + chCR +
  '    <Version>7.0</Version>' + chCR +
  '    <DCC_Define>DEBUG</DCC_Define>' + chCR +
  '  </PropertyGroup>' + chCR +
  '  <ProjectExtensions>' + chCR +
  '    <Borland.Personality>Delphi.Personality</Borland.Personality>' + chCR +
  '    <Borland.ProjectType>VCLApplication</Borland.ProjectType>' + chCR +
  '    <BorlandProject>' + chCR +
  '      <BorlandProject xmlns="">' + chCR +
  '        <Delphi.Personality>' + chCR +
  '          <Parameters>' + chCR +
  '            <Parameters Name="UseLauncher">False</Parameters>' + chCR +
  '            <Parameters Name="LoadAllSymbols">True</Parameters>' + chCR +
  '            <Parameters Name="LoadUnspecifiedSymbols">False</Parameters>' + chCR +
  '          </Parameters>' + chCR +
  '          <VersionInfo>' + chCR +
  '            <VersionInfo Name="IncludeVerInfo">False</VersionInfo>' + chCR +
  '            <VersionInfo Name="AutoIncBuild">False</VersionInfo>' + chCR +
  '            <VersionInfo Name="MajorVer">1</VersionInfo>' + chCR +
  '            <VersionInfo Name="MinorVer">0</VersionInfo>' + chCR +
  '            <VersionInfo Name="Release">0</VersionInfo>' + chCR +
  '            <VersionInfo Name="Build">0</VersionInfo>' + chCR +
  '            <VersionInfo Name="Debug">False</VersionInfo>' + chCR +
  '            <VersionInfo Name="PreRelease">False</VersionInfo>' + chCR +
  '            <VersionInfo Name="Special">False</VersionInfo>' + chCR +
  '            <VersionInfo Name="Private">False</VersionInfo>' + chCR +
  '            <VersionInfo Name="DLL">False</VersionInfo>' + chCR +
  '            <VersionInfo Name="Locale">1049</VersionInfo>' + chCR +
  '            <VersionInfo Name="CodePage">1251</VersionInfo>' + chCR +
  '          </VersionInfo>' + chCR +
  '          <VersionInfoKeys>' + chCR +
  '            <VersionInfoKeys Name="CompanyName"></VersionInfoKeys>' + chCR +
  '            <VersionInfoKeys Name="FileDescription"></VersionInfoKeys>' + chCR +
  '            <VersionInfoKeys Name="FileVersion">1.0.0.0</VersionInfoKeys>' + chCR +
  '            <VersionInfoKeys Name="InternalName"></VersionInfoKeys>' + chCR +
  '            <VersionInfoKeys Name="LegalCopyright"></VersionInfoKeys>' + chCR +
  '            <VersionInfoKeys Name="LegalTrademarks"></VersionInfoKeys>' + chCR +
  '            <VersionInfoKeys Name="OriginalFilename"></VersionInfoKeys>' + chCR +
  '            <VersionInfoKeys Name="ProductName"></VersionInfoKeys>' + chCR +
  '            <VersionInfoKeys Name="ProductVersion">1.0.0.0</VersionInfoKeys>' + chCR +
  '            <VersionInfoKeys Name="Comments"></VersionInfoKeys>' + chCR +
  '          </VersionInfoKeys>' + chCR +
  '          <Source>' + chCR +
  '            <Source Name="MainSource">%PROJECT_NAME%.dpr</Source>' + chCR +
  '          </Source>' + chCR +
  '        </Delphi.Personality>' + chCR +
  '      </BorlandProject>' + chCR +
  '    </BorlandProject>' + chCR +
  '  </ProjectExtensions>' + chCR +
  '  <ItemGroup />' + chCR +
  '  <ItemGroup>' + chCR +
  '    <DelphiCompile Include="%PROJECT_NAME%.dpr">' + chCR +
  '      <MainSource>MainSource</MainSource>' + chCR +
  '    </DelphiCompile>' + chCR +
  '    <DCCReference Include="%PROJECT_NAME%_IMPL.pas">' + chCR +
  '      <Form>AddInModule</Form>' + chCR +
  '      <CoClasses>%COCLASS_NAME%</CoClasses>' + chCR +
  '    </DCCReference>' + chCR +
  '    <DCCReference Include="%PROJECT_NAME%_TLB.pas" />' + chCR +
  '  </ItemGroup>' + chCR +
  '  <Import Project="$(MSBuildBinPath)\Borland.Delphi.Targets" />' + chCR +
  '</Project>' + chCR +
  '' + chCR;


  D12ProjModule: string =
  chBds +
	'<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">' + chCR +
	'	<PropertyGroup>' + chCR +
	'		<ProjectGuid>%PROJECT_GUID%</ProjectGuid>' + chCR +
	'		<MainSource>%PROJECT_NAME%.dpr</MainSource>' + chCR +
	'		<Configuration Condition=" '+ chQ+ '$(Configuration)'+ chQ+ ' == '+ chQ+ chQ+ ' ">Debug</Configuration>' + chCR +
	'		<Platform Condition=" '+ chQ+ '$(Platform)'+ chQ+ ' == '+ chQ+ chQ+ ' ">AnyCPU</Platform>' + chCR +
	'		<DCC_DCCCompiler>DCC32</DCC_DCCCompiler>' + chCR +
	'		<DCC_DependencyCheckOutputName>%PROJECT_NAME%.dll</DCC_DependencyCheckOutputName>' + chCR +
	'		<ProjectVersion>12.0</ProjectVersion>' + chCR +
	'		<Config Condition="'+ chQ+ '$(Config)'+ chQ+ '=='+ chQ+ chQ+ '">Debug</Config>' + chCR +
	'	</PropertyGroup>' + chCR +
	'	<PropertyGroup Condition="'+ chQ+ '$(Config)'+ chQ+ '=='+ chQ+ 'Base'+ chQ+ ' or '+ chQ+ '$(Base)'+ chQ+ '!='+ chQ+ chQ+ '">' + chCR +
	'		<Base>true</Base>' + chCR +
	'	</PropertyGroup>' + chCR +
	'	<PropertyGroup Condition="'+ chQ+ '$(Config)'+ chQ+ '=='+ chQ+ 'Release'+ chQ+ ' or '+ chQ+ '$(Cfg_1)'+ chQ+ '!='+ chQ+ chQ+ '">' + chCR +
	'		<Cfg_1>true</Cfg_1>' + chCR +
	'		<CfgParent>Base</CfgParent>' + chCR +
	'		<Base>true</Base>' + chCR +
	'	</PropertyGroup>' + chCR +
	'	<PropertyGroup Condition="'+ chQ+ '$(Config)'+ chQ+ '=='+ chQ+ 'Debug'+ chQ+ ' or '+ chQ+ '$(Cfg_2)'+ chQ+ '!='+ chQ+ chQ+ '">' + chCR +
	'		<Cfg_2>true</Cfg_2>' + chCR +
	'		<CfgParent>Base</CfgParent>' + chCR +
	'		<Base>true</Base>' + chCR +
	'	</PropertyGroup>' + chCR +
	'	<PropertyGroup Condition="'+ chQ+ '$(Base)'+ chQ+ '!='+ chQ+ chQ+'">' + chCR +
	'		<DCC_DependencyCheckOutputName>%PROJECT_NAME%.dll</DCC_DependencyCheckOutputName>' + chCR +
	'		<GenDll>true</GenDll>' + chCR +
	'	</PropertyGroup>' + chCR +
	'	<PropertyGroup Condition="'+ chQ+ '$(Cfg_1)'+ chQ+ '!='+ chQ+ chQ+ '">' + chCR +
	'		<Version>7.0</Version>' + chCR +
	'		<DCC_DebugInformation>False</DCC_DebugInformation>' + chCR +
	'		<DCC_LocalDebugSymbols>False</DCC_LocalDebugSymbols>' + chCR +
	'		<DCC_SymbolReferenceInfo>0</DCC_SymbolReferenceInfo>' + chCR +
	'		<DCC_Define>RELEASE;$(DCC_Define)</DCC_Define>' + chCR +
	'	</PropertyGroup>' + chCR +
	'	<PropertyGroup Condition="'+ chQ+ '$(Cfg_2)'+ chQ+ '!='+ chQ+ chQ+ '">' + chCR +
	'		<Version>7.0</Version>' + chCR +
	'		<DCC_Define>DEBUG;$(DCC_Define)</DCC_Define>' + chCR +
	'	</PropertyGroup>' + chCR +
	'	<ItemGroup>' + chCR +
	'		<DelphiCompile Include="%PROJECT_NAME%.dpr">' + chCR +
	'			<MainSource>MainSource</MainSource>' + chCR +
	'		</DelphiCompile>' + chCR +
	'		<DCCReference Include="%PROJECT_NAME%_TLB.pas"/>' + chCR +
	'		<DCCReference Include="%PROJECT_NAME%_IMPL.pas">' + chCR +
	'			<Form>AddInModule</Form>' + chCR +
	'			<DesignClass>TAddInModule</DesignClass>' + chCR +
	'			<CoClasses>%COCLASS_NAME%</CoClasses>' + chCR +
	'		</DCCReference>' + chCR +
  '   <RidlCompile Include="%PROJECT_NAME%.ridl"/>' + chCR +
	'		<BuildConfiguration Include="Base">' + chCR +
	'			<Key>Base</Key>' + chCR +
	'		</BuildConfiguration>' + chCR +
	'		<BuildConfiguration Include="Debug">' + chCR +
	'			<Key>Cfg_2</Key>' + chCR +
	'			<CfgParent>Base</CfgParent>' + chCR +
	'		</BuildConfiguration>' + chCR +
	'		<BuildConfiguration Include="Release">' + chCR +
	'			<Key>Cfg_1</Key>' + chCR +
	'			<CfgParent>Base</CfgParent>' + chCR +
	'		</BuildConfiguration>' + chCR +
	'	</ItemGroup>' + chCR +
	'	<Import Project="$(BDS)\Bin\CodeGear.Delphi.Targets" Condition="Exists('+ chQ+ '$(BDS)\Bin\CodeGear.Delphi.Targets'+ chQ+ ')"/>' + chCR +
	'	<ProjectExtensions>' + chCR +
	'		<Borland.Personality>Delphi.Personality.12</Borland.Personality>' + chCR +
	'		<Borland.ProjectType>VCLApplication</Borland.ProjectType>' + chCR +
	'		<BorlandProject>' + chCR +
	'			<Delphi.Personality>' + chCR +
	'				<Parameters>' + chCR +
	'					<Parameters Name="UseLauncher">False</Parameters>' + chCR +
	'					<Parameters Name="LoadAllSymbols">True</Parameters>' + chCR +
	'					<Parameters Name="LoadUnspecifiedSymbols">False</Parameters>' + chCR +
	'				</Parameters>' + chCR +
	'				<VersionInfo>' + chCR +
	'					<VersionInfo Name="IncludeVerInfo">False</VersionInfo>' + chCR +
	'					<VersionInfo Name="AutoIncBuild">False</VersionInfo>' + chCR +
	'					<VersionInfo Name="MajorVer">1</VersionInfo>' + chCR +
	'					<VersionInfo Name="MinorVer">0</VersionInfo>' + chCR +
	'					<VersionInfo Name="Release">0</VersionInfo>' + chCR +
	'					<VersionInfo Name="Build">0</VersionInfo>' + chCR +
	'					<VersionInfo Name="Debug">False</VersionInfo>' + chCR +
	'					<VersionInfo Name="PreRelease">False</VersionInfo>' + chCR +
	'					<VersionInfo Name="Special">False</VersionInfo>' + chCR +
	'					<VersionInfo Name="Private">False</VersionInfo>' + chCR +
	'					<VersionInfo Name="DLL">False</VersionInfo>' + chCR +
	'					<VersionInfo Name="Locale">1049</VersionInfo>' + chCR +
	'					<VersionInfo Name="CodePage">1251</VersionInfo>' + chCR +
	'				</VersionInfo>' + chCR +
	'				<VersionInfoKeys>' + chCR +
	'					<VersionInfoKeys Name="CompanyName"/>' + chCR +
	'					<VersionInfoKeys Name="FileDescription"/>' + chCR +
	'					<VersionInfoKeys Name="FileVersion">1.0.0.0</VersionInfoKeys>' + chCR +
	'					<VersionInfoKeys Name="InternalName"/>' + chCR +
	'					<VersionInfoKeys Name="LegalCopyright"/>' + chCR +
	'					<VersionInfoKeys Name="LegalTrademarks"/>' + chCR +
	'					<VersionInfoKeys Name="OriginalFilename"/>' + chCR +
	'					<VersionInfoKeys Name="ProductName"/>' + chCR +
	'					<VersionInfoKeys Name="ProductVersion">1.0.0.0</VersionInfoKeys>' + chCR +
	'					<VersionInfoKeys Name="Comments"/>' + chCR +
	'				</VersionInfoKeys>' + chCR +
	'				<Source>' + chCR +
	'					<Source Name="MainSource">%PROJECT_NAME%.dpr</Source>' + chCR +
	'				</Source>' + chCR +
	'			</Delphi.Personality>' + chCR +
	'			<ActiveXProjectInfo>' + chCR +
	'				<version>1</version>' + chCR +
	'			</ActiveXProjectInfo>' + chCR +
	'		</BorlandProject>' + chCR +
	'		<ProjectFileVersion>12</ProjectFileVersion>' + chCR +
	'	</ProjectExtensions>' + chCR +
	'</Project>' + chCR;

  ISSScript: string =
  '[Setup]' + chCR +
  'AppName                = %PROJECT_NAME%' + chCR +
  'AppVerName             = %PROJECT_NAME% 1.0' + chCR +
  'OutputBaseFilename     = %PROJECT_NAME%-v100' + chCR +
  'DefaultDirName         = {pf}\%PROJECT_NAME%' + chCR +
  'OutputDir              = _Setup' + chCR +
  '' + chCR +
  '[Files]' + chCR +
  '; Add-in dll' + chCR +
  'Source: "%PROJECT_NAME%.dll";                                     DestDir: "{app}"; Flags: regserver' + chCR +
  '%GDIPLUS%' + chCR +
  '%INI_FILE%' + chCR +
  '' + chCR;

  WIXScript: string =
  '<?xml version="1.0" encoding="UTF-8"?>' + chCR +
  '<Wix xmlns="http://schemas.microsoft.com/wix/2006/wi">' + chCR +
  '    <Product Id="%GUID1%"' + chCR +
  '        UpgradeCode="%GUID2%"' + chCR +
  '        Version="1.0.0.0"' + chCR +
  '        Language="1033"' + chCR +
  '        Name="Application Name"' + chCR +
  '        Manufacturer="Manufacturer Name">' + chCR +
  '' + chCR +
  '        <Package InstallerVersion="300" Compressed="yes" InstallPrivileges="elevated" InstallScope="perMachine"/>' + chCR +
  '        <Media Id="1" Cabinet="application.cab" EmbedCab="yes" />' + chCR +
  '' + chCR +
  '        <Directory Id="TARGETDIR" Name="SourceDir">' + chCR +
  '            <Directory Id="ProgramFilesFolder">' + chCR +
  '                <Directory Id="APPLICATIONROOTDIRECTORY" Name="Application Name"/>' + chCR +
  '            </Directory>' + chCR +
  '        </Directory>' + chCR +
  '' + chCR +
  '        <DirectoryRef Id="APPLICATIONROOTDIRECTORY">' + chCR +
  '            <Component Id="%PROJECT_NAME%.dll" Guid="%GUID3%">' + chCR +
  '                <File Id="%PROJECT_NAME%.dll" Source="%PROJECT_NAME%.dll" SelfRegCost="5000" KeyPath="yes"/>' + chCR +
  '%GDIPLUS%' + chCR +
  '%INI_FILE%' + chCR +
  '            </Component>' + chCR +
  '        </DirectoryRef>' + chCR +
  '' + chCR +
  '        <Feature Id="MainApplication" Title="Main Application" Level="1">' + chCR +
  '            <ComponentRef Id="%PROJECT_NAME%.dll" />' + chCR +
  '        </Feature>' + chCR +
  '' + chCR +
  '        <Property Id="WIXUI_INSTALLDIR" Value="APPLICATIONROOTDIRECTORY" />' + chCR +
  '        <UIRef Id="WixUI_InstallDir"/>' + chCR +
  '' + chCR +
  '        <!-- TODO' + chCR +
  '' + chCR +
  '        <WixVariable Id="WixUILicenseRtf" Value="license.rtf" />' + chCR +
  '' + chCR +
  '        -->' + chCR +
  '' + chCR +
  '    </Product>' + chCR +
  '</Wix>' + chCR +
  '' + chCR;

  WIXBat: string =
  '"C:\Program Files\Windows Installer XML v3\bin\candle.exe" %PROJECT_NAME%.wxs -ext WixUIExtension -ext WixUtilExtension' + chCR +
  '"C:\Program Files\Windows Installer XML v3\bin\light.exe" %PROJECT_NAME%.wixobj -ext WixUIExtension -ext WixUtilExtension'  + chCR;

