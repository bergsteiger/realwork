const

  lexIID2 = '%IID2%';
  lexCLSID2 = '%CLSID2%';

  ProjectModuleST: string =
    'library %PROJECT_NAME%;' + chCR +
    '' + chCR +
    'uses' + chCR +
    '  ComServ,' + chCR +
    '  %PROJECT_NAME%_TLB in '#39'%PROJECT_NAME%_TLB.pas'#39',' + chCR +
    '  %PROJECT_NAME%_IMPL in '#39'%PROJECT_NAME%_IMPL.pas'#39' {%MODULE_TYPE%: T%MODULE_TYPE%} {%COCLASS_NAME%Recognizer: CoClass} {%COCLASS_NAME%Action: CoClass};' + chCR +
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

  IMPLModuleST: string =
    'unit %PROJECT_NAME%_IMPL;' + chCR +
    '' + chCR +
    'interface' + chCR +
    '' + chCR +
    'uses' + chCR +
    '  %COMMON_UNIT_LIST%, adxSmartTag, adxSmartTagTLB, %PROJECT_NAME%_TLB;' + chCR +
    '' + chCR +
    'type' + chCR +
    '  T%COCLASS_NAME%Recognizer = class(TadxRecognizerObject, I%COCLASS_NAME%Recognizer)' + chCR +
    '  protected' + chCR +
    '  end;' + chCR +
    '' + chCR +
    '  T%COCLASS_NAME%Action = class(TadxActionObject, I%COCLASS_NAME%Action)' + chCR +
    '  protected' + chCR +
    '  end;' + chCR +
    '' + chCR +
    '  TSmartTagModule = class(TadxSmartTagModule)' + chCR +
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
    '  TadxRecognizerFactory.Create(ComServer, T%COCLASS_NAME%Recognizer,' + chCR +
    '    CLASS_%COCLASS_NAME%Recognizer, TSmartTagModule);' + chCR +
    '' + chCR +
    '  TadxActionFactory.Create(ComServer, T%COCLASS_NAME%Action,' + chCR +
    '    CLASS_%COCLASS_NAME%Action, TSmartTagModule);' + chCR +
    '' + chCR +
    'end.' + chCR;

  IMPLModuleDFMST: string =
    'object SmartTagModule: TSmartTagModule' + chCR +
    '  OldCreateOrder = False' + chCR +
    '  NamespaceURI = ' + #39 + '%COCLASS_NAME%' + #39 + chCR +
    '  Left = 290' + chCR +
    '  Top = 170' + chCR +
    '  Height = 400' + chCR +
    '  Width = 380' + chCR +
    '  Names = (' + chCR +
    '    ' + #39 + '0=MySmartTagLibrary1' + #39 + ')' + chCR +
    '  Descriptions = (' + chCR +
    '    ' + #39 + '0=MySmartTagLibrary1 Description' + #39 + ')' + chCR +
    'end' + chCR;

  TLBModuleST: string =
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
    '  IID_I%COCLASS_NAME%Recognizer: TGUID = '#39'%IID%'#39';' + chCR +
    '  CLASS_%COCLASS_NAME%Recognizer: TGUID = '#39'%CLSID%'#39';' + chCR +
    '  IID_I%COCLASS_NAME%Action: TGUID = '#39'%IID2%'#39';' + chCR +
    '  CLASS_%COCLASS_NAME%Action: TGUID = '#39'%CLSID2%'#39';' + chCR +
    ''  + chCR +
    'type' + chCR +
    '  I%COCLASS_NAME%Recognizer = interface(IDispatch)' + chCR +
    '    ['#39'%IID%'#39']' + chCR +
    '  end;' + chCR +
    '' + chCR +
    '  I%COCLASS_NAME%RecognizerDisp = dispinterface' + chCR +
    '    ['#39'%IID%'#39']' + chCR +
    '  end;' + chCR +
    '' + chCR +
    '  I%COCLASS_NAME%Action = interface(IDispatch)' + chCR +
    '    ['#39'%IID2%'#39']' + chCR +
    '  end;' + chCR +
    '' + chCR +
    '  I%COCLASS_NAME%ActionDisp = dispinterface' + chCR +
    '    ['#39'%IID2%'#39']' + chCR +
    '  end;' + chCR +
    '' + chCR +
    'implementation' + chCR +
    '' + chCR +
    'end.';

    RIDLModuleST: string =
    '[' + chCR +
    '   uuid(%LIBID%),' + chCR +
    '   version(1.0),' + chCR +
    '   helpstring("%PROJECT_NAME% Library")' + chCR +
    chCR +
    ']' + chCR +
    'library %PROJECT_NAME%' + chCR +
    '{' + chCR +
    chCR +
    '   importlib("stdole2.tlb");' + chCR +
    chCR +
    '   interface I%COCLASS_NAME%Recognizer;' + chCR +
    '   coclass %COCLASS_NAME%Recognizer;' + chCR +
    '   interface I%COCLASS_NAME%Action;' + chCR +
    '   coclass %COCLASS_NAME%Action;' + chCR +
    chCR +
    chCR +
    '   [' + chCR +
    '     uuid(%IID%),' + chCR +
    '     version(1.0),' + chCR +
    '     helpstring("Dispatch interface for %COCLASS_NAME%Recognizer Object"),' + chCR +
    '     dual,' + chCR +
    '     oleautomation' + chCR +
    '   ]' + chCR +
    '   interface I%COCLASS_NAME%Recognizer: IDispatch' + chCR +
    '   {' + chCR +
    '   };' + chCR +
    chCR +
    '   ['+ chCR +
    '     uuid(%IID2%),'+ chCR +
    '     version(1.0),'+ chCR +
    '     helpstring("Dispatch interface for %COCLASS_NAME%Action Object"),'+ chCR +
    '     dual,'+ chCR +
    '     oleautomation'+ chCR +
    '   ]'+ chCR +
    '   interface I%COCLASS_NAME%Action: IDispatch'+ chCR +
    '   {'+ chCR +
    '   };'+ chCR +
    chCR +
    '   [' + chCR +
    '     uuid(%CLSID%),' + chCR +
    '     version(1.0),' + chCR +
    '     helpstring("%COCLASS_NAME%Recognizer Object")' + chCR +
    '   ]' + chCR +
    '   coclass %COCLASS_NAME%Recognizer' + chCR +
    '   {' + chCR +
    '     [default] interface I%COCLASS_NAME%Recognizer;' + chCR +
    '   };' + chCR +
    chCR +
    '   [' + chCR +
    '     uuid(%CLSID2%),' + chCR +
    '     version(1.0),' + chCR +
    '     helpstring("%COCLASS_NAME%Action Object")' + chCR +
    '   ]' + chCR +
    '   coclass %COCLASS_NAME%Action' + chCR +
    '   {' + chCR +
    '     [default] interface I%COCLASS_NAME%Action;' + chCR +
    '   };' + chCR +
    chCR +
    '};' + chCR;

