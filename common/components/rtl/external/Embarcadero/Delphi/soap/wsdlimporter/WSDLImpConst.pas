{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit WSDLImpConst;

{$IFNDEF VER150}
{$INCLUDE 'CompVer.inc'}
{$ENDIF}

interface

uses
  WSDLImpWriter, WSDLModelIntf;

// This function is used in both the IDE's WSDL Importer Wizard and WSDLImp.exe to
// to determine if the option is handled by the options page (Wizard) or is a code gen option (WSDLImp.exe)
function IsOptionHandledByOptionsPage(const Flag: WSDLGenFlags): Boolean;

{$IFDEF LINUX}
{ Linux linebreaks don't work in code previewer }
const

  SLineBreak = #13#10;

{$ENDIF}

{$DEFINE USE_FREE_AND_NIL}


type

  TIntfImplOption = (iiCBuilder, iiPascal, iiPascalIntf, iiPascalImpl, iiCBuilderIntf, iiCBuilderImpl);

const

  fnOptionsFile = 'WSDLImp.ini';


sCommentDivider =
'//---------------------------------------------------------------------------' + sLineBreak;

{ C++ specific constants }

// Include statement of an Imported SOAP header
//
sInclude_WS = '#include "%s.h"'            + sLineBreak;

// Standard Include used in .CPP files
//
sStandardSourceInclude =
                     '#pragma hdrstop'                         + sLineBreak +
                                                                 sLineBreak +
                     '#if !defined(%0:sH)'                     + sLineBreak +
                     '#include "%0:s.h"'                       + sLineBreak +
                     '#endif'                                  + sLineBreak + sLineBreak;
sStandardSourceIncludeVCL  =
                     '#include <vcl.h>'                        + sLineBreak + sStandardSourceInclude;
sStandardSourceIncludeCLX  =
                     '#include <clx.h>'                        + sLineBreak + sStandardSourceInclude;
sStandardSourceIncludeSystem  =
                     '#include <System.hpp>'                   + sLineBreak + sStandardSourceInclude;

// Guard used in Headers
//
sHdrGuardBegin     = '#ifndef   %0:sH'                         + sLineBreak +
                     '#define   %0:sH'                         + sLineBreak +
                                                                 sLineBreak +
                     '#include <System.hpp>'                   + sLineBreak +
                     '#include <InvokeRegistry.hpp>'           + sLineBreak +
                     '#include <XSBuiltIns.hpp>'               + sLineBreak;

sClientHeaders     = '#include <SOAPHTTPClient.hpp>'           + sLineBreak + sLineBreak;

sCppRemoteClass    = '#if !defined(SOAP_REMOTABLE_CLASS)'      + sLineBreak +
                     '#define SOAP_REMOTABLE_CLASS __declspec(delphiclass)' + sLineBreak +
                     '#endif'                                  + sLineBreak;
sCppIsOptn =
                     '#if !defined(IS_OPTN)'                   + sLineBreak +
                     '#define IS_OPTN 0x0001'                  + sLineBreak +
                     '#endif'                                  + sLineBreak;
sCppIsUnbd =
                     '#if !defined(IS_UNBD)'                   + sLineBreak +
                     '#define IS_UNBD 0x0002'                  + sLineBreak +
                     '#endif'                                  + sLineBreak;
sCppIsNlbl =
                     '#if !defined(IS_NLBL)'                   + sLineBreak +
                     '#define IS_NLBL 0x0004'                  + sLineBreak +
                     '#endif'                                  + sLineBreak;
sCppIsUnql =
                     '#if !defined(IS_UNQL)'                   + sLineBreak +
                     '#define IS_UNQL 0x0008'                  + sLineBreak +
                     '#endif'                                  + sLineBreak;
sCppIsAttr =
                     '#if !defined(IS_ATTR)'                   + sLineBreak +
                     '#define IS_ATTR 0x0010'                  + sLineBreak +
                     '#endif'                                  + sLineBreak;
sCppIsText =
                     '#if !defined(IS_TEXT)'                   + sLineBreak +
                     '#define IS_TEXT 0x0020'                  + sLineBreak +
                     '#endif'                                  + sLineBreak;
sCppIsAny =
                     '#if !defined(IS_ANY)'                    + sLineBreak +
                     '#define IS_ANY 0x0040'                   + sLineBreak +
                     '#endif'                                  + sLineBreak;
sCppIsRef =
                     '#if !defined(IS_REF)'                    + sLineBreak +
                     '#define IS_REF 0x0080'                   + sLineBreak +
                     '#endif'                                  + sLineBreak;
sCppIsQual =
                     '#if !defined(IS_QUAL)'                   + sLineBreak +
                     '#define IS_QUAL 0x0100'                  + sLineBreak +
                     '#endif'                                  + sLineBreak;
sCppIsOut =
                     '#if !defined(IS_OUT)'                    + sLineBreak +
                     '#define IS_OUT 0x0200'                   + sLineBreak +
                     '#endif'                                  + sLineBreak;
sHdrGuardEnd       =                                             sLineBreak +
                     '#endif // %0:sH'                         + sLineBreak;

// Namespace block in Headers
//
sNamespaceHdrBegin = sLineBreak +
                     'namespace NS_%0:s {'                     + sLineBreak + sLineBreak;
sNamespaceHdrEnd   = sLineBreak +
                     '};     // NS_%0:s'                       + sLineBreak + sLineBreak;

sNamespaceUsing    = '#if !defined(NO_IMPLICIT_NAMESPACE_USE)' + sLineBreak +
                     'using  namespace NS_%0:s;'               + sLineBreak +
                     '#endif'                                  + sLineBreak + sLineBreak;

// Namespace block in Source
//
sNamespaceSrcBegin = 'namespace NS_%s {'                       + sLineBreak;
sNamespaceSrcEnd   = sLineBreak +
                     '};     // NS_%s'                         + sLineBreak;

sInterfaceDecl     = '__interface INTERFACE_UUID("%s") %s : public %s'  + sLineBreak +
                     '{'                                       + sLineBreak +
                     'public:'                                 + sLineBreak;
sInterfaceDeclEnd  = '};'                                      + sLineBreak +
                     'typedef DelphiInterface<%0:s> _di_%0:s;' + sLineBreak
                                                               + sLineBreak;
sIntfFactoryDecl   = '_di_%0:s Get%0:s(bool useWSDL=false, System::String addr= System::String(), Soaphttpclient::THTTPRIO* HTTPRIO=0);' + sLineBreak + sLineBreak;
sImplDecl          = 'class T%0:sImpl : public InvokeRegistry::TInvokableClass, public %0:s'+ sLineBreak +
                     '{'                                                                    + sLineBreak +
                     'public:'                                                              + sLineBreak + sLineBreak +
                     '  /* %0:s */'                                                         + sLineBreak;
sImplOther         = sLineBreak +
                     '  /* IUnknown */'                                                                      + sLineBreak +
                     '  HRESULT STDMETHODCALLTYPE QueryInterface(const GUID& IID, void **Obj)'               + sLineBreak +
                     '                        { return GetInterface(IID, Obj) ? S_OK : E_NOINTERFACE; }'     + sLineBreak +
                     '  ULONG STDMETHODCALLTYPE AddRef() { return System::TInterfacedObject::_AddRef();  }'  + sLineBreak +
                     '  ULONG STDMETHODCALLTYPE Release(){ return System::TInterfacedObject::_Release(); }'  + sLineBreak;
sImplEnd           = '};'                                      + sLineBreak + sLineBreak;
sMethImpl          = '{'                                                        + sLineBreak +
                     '  /* TODO : Implement WebService method %s */'            + sLineBreak +
                     '%s}'                                                      + sLineBreak + sLineBreak;
sReturnDecl        = '  %s %s;'                                                 + sLineBreak;
sReturnTempl       = '  return %s;'                                             + sLineBreak;
sReturnNewTempl    = '  return new %s();'                                       + sLineBreak;

sFactoryImpl       = '_di_%0:s Get%0:s(bool useWSDL, System::String addr, Soaphttpclient::THTTPRIO* HTTPRIO)' + sLineBreak +
                     '{'                                                        + sLineBreak +
                     '  static const char* defWSDL= "%1:s";'                    + sLineBreak +
                     '  static const char* defURL = "%2:s";'                    + sLineBreak +
                     '  static const char* defSvc = "%3:s";'                    + sLineBreak +
                     '  static const char* defPrt = "%4:s";'                    + sLineBreak +
                     '  if (addr=="")'                                          + sLineBreak +
                     '    addr = useWSDL ? defWSDL : defURL;'                   + sLineBreak +
                     '  Soaphttpclient::THTTPRIO* rio = HTTPRIO ? HTTPRIO : new Soaphttpclient::THTTPRIO(0);'   + sLineBreak +
                     '  if (useWSDL) {'                                         + sLineBreak +
                     '    rio->WSDLLocation = addr;'                            + sLineBreak +
                     '    rio->Service = defSvc;'                               + sLineBreak +
                     '    rio->Port = defPrt;'                                  + sLineBreak +
                     '  } else {'                                               + sLineBreak +
                     '    rio->URL = addr;'                                     + sLineBreak +
                     '  }'                                                      + sLineBreak +
                     '  _di_%0:s service;'                                      + sLineBreak +
                     '  rio->QueryInterface(service);'                          + sLineBreak +
                     '  if (!service && !HTTPRIO)'                                          + sLineBreak +
                     '    delete rio;'                                          + sLineBreak +
                     '  return service;'                                        + sLineBreak +
                     '}'                                                        + sLineBreak + sLineBreak;

sInitRoutineBeg    = 'static void RegTypes()'                  + sLineBreak +
                     '{'                                       + sLineBreak;

sInitRoutineEnd    = '}'                                       + sLineBreak +
                     '#pragma startup RegTypes 32'             + sLineBreak;

sRegInterface1     = '  InvRegistry()->RegisterInterface(__delphirtti(%s), L"%s", L"%s");'   + sLineBreak;
sRegInterface2     = '  InvRegistry()->RegisterInterface(__delphirtti(%s), L"%s", L"%s",'    + sLineBreak +
                     '                                   "", L"%s");'                        + sLineBreak;
sRegSOAPAction     = '  InvRegistry()->RegisterDefaultSOAPAction(__delphirtti(%s), L"%s");'  + sLineBreak;
sRegAllSOAPAction  = '  InvRegistry()->RegisterAllSOAPActions(__delphirtti(%s), L"%s");'     + sLineBreak;

{$IFDEF UNICODE}
sRegParamNames     = '  InvRegistry()->RegisterReturnParamNames(__delphirtti(%s), L"%s");'    + sLineBreak;
{$ELSE}
sRegParamNames     = '  InvRegistry()->RegisterReturnParamNames(__delphirtti(%s), "%s");'    + sLineBreak;
{$ENDIF}
sRegInvokeOptDoc   = '  InvRegistry()->RegisterInvokeOptions(__delphirtti(%s), ioDocument);' + sLineBreak;
sRegInvokeOptLit   = '  InvRegistry()->RegisterInvokeOptions(__delphirtti(%s), ioLiteral);'  + sLineBreak;
sRegInvokeOptSOAP12= '  InvRegistry()->RegisterInvokeOptions(__delphirtti(%s), ioSOAP12);' + sLineBreak;

{$IFDEF UNICODE}
sRegMethodRenamed  = '  InvRegistry()->RegisterExternalMethName(__delphirtti(%s), L"%s", L"%s");'           + sLineBreak;
sRegParamRenamed   = '  InvRegistry()->RegisterExternalParamName(__delphirtti(%s), L"%s", L"%s", L"%s");'    + sLineBreak;
sRegMemberRenamed  = '  RemClassRegistry()->RegisterExternalPropName(__typeinfo(%s), L"%s", L"%s");'        + sLineBreak;
sRegMemberRenamedE = '  RemClassRegistry()->RegisterExternalPropName(GetClsMemberTypeInfo(__typeinfo(%0:s_TypeInfoHolder)), L"%s", L"%s");'     + sLineBreak;
{$ELSE}
sRegMethodRenamed  = '  InvRegistry()->RegisterExternalMethName(__delphirtti(%s), "%s", L"%s");'           + sLineBreak;
sRegParamRenamed   = '  InvRegistry()->RegisterExternalParamName(__delphirtti(%s), "%s", "%s", L"%s");'    + sLineBreak;
sRegMemberRenamed  = '  RemClassRegistry()->RegisterExternalPropName(__typeinfo(%s), "%s", L"%s");'        + sLineBreak;
sRegMemberRenamedE = '  RemClassRegistry()->RegisterExternalPropName(GetClsMemberTypeInfo(__typeinfo(%0:s_TypeInfoHolder)), "%s", L"%s");'     + sLineBreak;
{$ENDIF}

sRegHolderTypeInfo1= '  RemClassRegistry()->RegisterXSInfo(GetClsMemberTypeInfo(__typeinfo(%0:s_TypeInfoHolder)), L"%1:s", L"%0:s");'          + sLineBreak;
sRegHolderTypeInfo2= '  RemClassRegistry()->RegisterXSInfo(GetClsMemberTypeInfo(__typeinfo(%0:s_TypeInfoHolder)), L"%1:s", L"%0:s", L"%2:s");' + sLineBreak;

sRegArrayTypeInfo1 = '  RemClassRegistry()->RegisterXSInfo(__delphirtti(%s), L"%s", L"%s");'         + sLineBreak;
sRegArrayTypeInfo2 = '  RemClassRegistry()->RegisterXSInfo(__delphirtti(%s), L"%s", L"%s", L"%s");'  + sLineBreak;


sRegClassSerOptsCpp= '  RemClassRegistry()->RegisterSerializeOptions(__classid(%s), (TSerializationOptions() %s));'      + sLineBreak;
sRegInfoSerOptsCpp = '  RemClassRegistry()->RegisterSerializeOptions(__delphirtti(%s), (TSerializationOptions() %s));'   + sLineBreak;


sRegClass1         = '  RemClassRegistry()->RegisterXSClass(__classid(%s), L"%s", L"%s");'              + sLineBreak;
sRegClass2         = '  RemClassRegistry()->RegisterXSClass(__classid(%s), L"%s", L"%s", L"%s");'       + sLineBreak;

sRegImpl           = '  InvRegistry()->RegisterInvokableClass(__classid(T%sImpl));'                     + sLineBreak;

sRegHeaderClass    = '  InvRegistry()->RegisterHeaderClass(__classid(T%sImpl), L"%s");'                 + sLineBreak;

sProxyClassDecl    = 'class %0:s_Proxy : public Soaphttpclient::THTTPRIO, public virtual %0:s {'+ sLineBreak;

sTypeInfoHolder    = 'class %0:s_TypeInfoHolder : public TObject {'+ sLineBreak +
                     '  %0:s __instanceType;'     + sLineBreak +
                     'public:'                    + sLineBreak +
                     '__published:'               + sLineBreak +
                     '  __property %0:s __propType = { read=__instanceType };' + sLineBreak +
                     '};'                         + sLineBreak;


sStoredAsAttribute = ', stored = AS_ATTRIBUTE';
sStoredAsUnbounded = ', stored = AS_UNBOUNDED';

sRemoteBaseClass   = 'TRemotable';
sRemoteClassDecl   = 'class %0:s : public %1:s {' + sLineBreak +
                     'private:'                   + sLineBreak;
sRemoteClassPublic = 'public:'                    + sLineBreak;
sRemoteClassPublish= '__published:'               + sLineBreak;
sRemoteClassCtr    = '  __fastcall  %s();'        + sLineBreak;
sRemoteClassDtr    = '  __fastcall ~%s();'        + sLineBreak;

sMemberField          = '  %-15s F%s;';
sSpecifiedField       = '  %-15s F%s_Specified;';
sSpecifiedStoredProcF = ', stored = F%s_Specified';
sSpecifiedStoredProcI = ', stored = %s_Specified';

sRemoteClassSetter = '  void __fastcall Set%0:s(%1:s _prop_val)'  + sLineBreak +
                     '  {  F%0:s = _prop_val;  }'     + sLineBreak;
sRemoteClassSetter2= '  void __fastcall Set%0:s(%1:s _prop_val;)'  + sLineBreak +
                     '  {  F%0:s = _prop_val; F%0:s_Specified = true; }'+ sLineBreak;

sRemoteClassGetter = '  %1:s __fastcall Get%0:s()'+ sLineBreak +
                     '  {  return F%0:s;  }'      + sLineBreak;

sRemoteClassSetterIdx =
                     '  void __fastcall Set%0:s(int Index, %1:s _prop_val)'  + sLineBreak +
                     '  {  F%0:s = _prop_val;  }'     + sLineBreak;
sRemoteClassSetterIdx2 =
                     '  void __fastcall Set%0:s(int Index, %1:s _prop_val)'  + sLineBreak +
                     '  {  F%0:s = _prop_val; F%0:s_Specified = true;  }'    + sLineBreak;

sRemoteClassGetterIdx =
                     '  %1:s __fastcall Get%0:s(int Index)'+ sLineBreak +
                     '  {  return F%0:s;  }'      + sLineBreak;

sSpecifiedStoredProcIdx =
                     '  bool __fastcall %0:s_Specified(int Index)' + sLineBreak +
                     '  {  return F%0:s_Specified;  } ' + sLineBreak;

sRemoteClsCtrImpl  = '__fastcall %0:s::%0:s()'    + sLineBreak +
                     '{'                          + sLineBreak +
                     '%1:s'                       +
                     '}'                          + sLineBreak;

sRemoteClsDtrImpl  = '__fastcall %0:s::~%0:s()'   + sLineBreak +
                     '{'                          + sLineBreak +
                     '%1:s'                       +
                     '}'                          + sLineBreak;

sDefaultArrayImpl  = '  int  GetLength() const  { return F%0:s.get_length(); }'     + sLineBreak +
                     '  void SetLength(int len) { F%0:s.set_length(len); }'         + sLineBreak;
sDefaultArrayImplIdx='  int  GetLength() const  { return F%0:s.get_length(); }'     + sLineBreak +
                     '  void SetLength(int len) { F%0:s_Specified = true; F%0:s.set_length(len); }'   + sLineBreak;
sDefaultArrayImplOp= '  %1:s& operator[](int index) { return F%0:s[index]; }'       + sLineBreak +
                     '  __property int Len = { read=GetLength, write=SetLength };' + sLineBreak;
sDefaultArrayImplOpIdx =
                     '  %1:s& operator[](int index) { F%0:s_Specified = true; return F%0:s[index]; }' + sLineBreak +
                     '  __property int Len = { read=GetLength, write=SetLength };' + sLineBreak;

sCtrInitLine       = '%s'+
                     '  %s= new %s();'            + sLineBreak;
sDtrClsLine        = '%s'+
                     '  delete %s;'               + sLineBreak;
sDtrArrayLine      = '%s'+
                     '  for(int i=0; i<%1:s.Length; i++)'      + sLineBreak +
                     '    if (%1:s[i])'                        + sLineBreak +
                     '      delete %1:s[i];'      + sLineBreak;
sCtrDtrEnd         = '}'                          + sLineBreak;
sRemoteClassDeclEnd= '};'                         + sLineBreak;

sOperationInfo     = '  // %s';

sCppComment        = '/* %s */';
sPasComment        = '{ %s }';
sLineComment       = '// %s';

sCppCommentIdent   = '  /* %s */';
sPasCommentIdent   = '  { %s }';

sPasCommentLF      = '{ %s }'  + sLineBreak;

sTypeError         = '[TYPE ERROR: %s]';

sPortTypeSignature = 'Name(%s), Namespace(%s), BindingName(%s), Service(%s), Port(%s)';

{ Pascal constants }
sUDDIOperator   = 'sUDDIOperator';
sUDDIBindingKey = 'sUDDIBindingKey';

sUnitBeg  =  'unit %0:s;'                                       + sLineBreak +
                                                                  sLineBreak +
             'interface'                                        + sLineBreak +
                                                                  sLineBreak +
             'uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns%s;'     + sLineBreak;
sConstBeg  =                                                      sLineBreak +
             'const'                                            + sLineBreak;

{ NOTE: This is temporary. Ideally it would be defined in the SOAP runtime,
        same as 'AS_ATTRIBUTE' but that would require an interface change }
sPasIsOptn = '  IS_OPTN = $0001;'                            + sLineBreak;
sPasIsUnbd = '  IS_UNBD = $0002;'                            + sLineBreak;
sPasIsNlbl = '  IS_NLBL = $0004;'                            + sLineBreak;
sPasIsUnql = '  IS_UNQL = $0008;'                            + sLineBreak;
sPasIsAttr = '  IS_ATTR = $0010;'                            + sLineBreak;
sPasIsText = '  IS_TEXT = $0020;'                            + sLineBreak;
sPasIsAny  = '  IS_ANY  = $0040;'                            + sLineBreak;
sPasIsRef  = '  IS_REF  = $0080;'                            + sLineBreak;
sPasIsQual = '  IS_QUAL = $0100;'                            + sLineBreak;
{ NOTE: $0200 is taken for C++ IS_OUT }

sIS_OPTN      = 'IS_OPTN';
sIS_UNBD      = 'IS_UNBD';
sIS_NLBL      = 'IS_NLBL';
sIS_UNQL      = 'IS_UNQL';
sIS_ATTR      = 'IS_ATTR';
sIS_TEXT      = 'IS_TEXT';
sIS_ANY       = 'IS_ANY';
sIS_REF       = 'IS_REF';
sIS_QUAL      = 'IS_QUAL';
sIS_OUT       = 'IS_OUT';

sUDDIConst    = '  '+sUDDIOperator+'   = ''%s'';'               + sLineBreak +
                '  '+sUDDIBindingKey+' = ''%s'';'               + sLineBreak;

sTypeBeg  =                                                       sLineBreak +
             'type'                                             + sLineBreak + sLineBreak;

sSOAPMidas = ', SOAPMidas';

sUnitImpl =  sLineBreak + sLineBreak +
             'implementation'                                   + sLineBreak;
sUnitUses =  '  uses SysUtils;'                                 + sLineBreak +
                                                                  sLineBreak;
sUnitType =  'type'                                             + sLineBreak +
                                                                  sLineBreak;

sRegProcPrefix = 'RegisterTypeProc';
sRegProcStart  = 'procedure '+sRegProcPrefix+'%d;'              + sLineBreak +
                 'begin'                                        + sLineBreak;
sRegProcEnd    = 'end;'                                         + sLineBreak
                                                                + sLineBreak;
sRegProcCall   =  '  '+sRegProcPrefix+'%d;'                     + sLineBreak;
sUnitInit =  'initialization'                                   + sLineBreak;

sUnitEnd  =  sLineBreak +
             'end.';

sRemoteClassDeclPas      = '  %0:s = class(%1:s)'         + sLineBreak +
                           '  private'                    + sLineBreak;
sRemoteClassPublicPas    = '  public'                     + sLineBreak;
sRemoteClassPublishPas   = '  published'                  + sLineBreak;
sRemoteClassCtrPas       = '    constructor Create; override;'      + sLineBreak;
sRemoteClassDtrPas       = '    destructor Destroy; override;'      + sLineBreak;
sRemoteClassSetterPas    = '    procedure Set%0:s(const A%1:s: %1:s);'    + sLineBreak;
sRemoteClassGetterPas    = '    function  Get%0:s: %1:s;'                 + sLineBreak;
sRemoteClassSetterPasIdx = '    procedure Set%0:s(Index: Integer; const A%1:s: %1:s);'    + sLineBreak;
sRemoteClassGetterPasIdx = '    function  Get%0:s(Index: Integer): %1:s;'                 + sLineBreak;
sSpecifiedFieldPas       = '    F%s_Specified: boolean;';
sSpecifiedStoredProcPasF = ' stored F%s_Specified';
sSpecifiedStoredProcPasI = ' stored %s_Specified';

sSpecifiedStoredProcDeclPasIdx =
                        '    function  %s_Specified(Index: Integer): boolean;'   + sLineBreak;

sSpecifiedStoredProcImplPasIdx=
                            'function %0:s.%1:s_Specified(Index: Integer): boolean;'  + sLineBreak +
                            'begin'                                         + sLineBreak +
                            '  Result := F%1:s_Specified;'                  + sLineBreak +
                            'end;'                                          + sLineBreak;

sRemoteClassSetterImplPas = 'procedure %0:s.Set%1:s(const A%2:s: %2:s);'    + sLineBreak +
                            'begin'                                         + sLineBreak +
                            '  F%1:s := A%2:s;'                             + sLineBreak +
                            'end;'                                          + sLineBreak;

sRemoteClassSetterImplPas2= 'procedure %0:s.Set%1:s(const A%2:s: %2:s);'    + sLineBreak +
                            'begin'                                         + sLineBreak +
                            '  F%1:s := A%2:s;'                             + sLineBreak +
                            '  F%1:s_Specified := True;'                    + sLineBreak +
                            'end;'                                          + sLineBreak;

sRemoteClassGetterImplPas = 'function %0:s.Get%1:s: %2:s;'                  + sLineBreak +
                            'begin'                                         + sLineBreak +
                            '  Result := F%1:s;'                            + sLineBreak +
                            'end;'                                          + sLineBreak;

sRemoteClassSetterImplPasIdx =
                            'procedure %0:s.Set%1:s(Index: Integer; const A%2:s: %2:s);'    + sLineBreak +
                            'begin'                                         + sLineBreak +
                            '  F%1:s := A%2:s;'                             + sLineBreak +
                            'end;'                                          + sLineBreak;

sRemoteClassSetterImplPasIdx2=
                            'procedure %0:s.Set%1:s(Index: Integer; const A%2:s: %2:s);'    + sLineBreak +
                            'begin'                                         + sLineBreak +
                            '  F%1:s := A%2:s;'                             + sLineBreak +
                            '  F%1:s_Specified := True;'                    + sLineBreak +
                            'end;'                                          + sLineBreak;

sRemoteClassGetterImplPasIdx =
                            'function %0:s.Get%1:s(Index: Integer): %2:s;'                  + sLineBreak +
                            'begin'                                         + sLineBreak +
                            '  Result := F%1:s;'                            + sLineBreak +
                            'end;'                                          + sLineBreak;

sArrayAsClassDecl     = '';

sRemoteClassDeclEndPas= '  end;'                       + sLineBreak;
sRemoteClsCtrImplPas1 = 'constructor %0:s.Create;'     + sLineBreak +
                        'begin'                        + sLineBreak +
                        '  inherited Create;'          + sLineBreak;
sRemoteClsCtrImplPas2 = '  FSerializationOptions := [%s];' + sLineBreak;
sRemoteClsCtrImplPas3 = 'end;'                         + sLineBreak;
sRemoteClsDtrImplPas1 = 'destructor %0:s.Destroy;'     + sLineBreak +
                        'begin'                        + sLineBreak;
sRemoteClsDtrImplPas2 = 'destructor %0:s.Destroy;'     + sLineBreak +
                        'var'                          + sLineBreak +
                        '  I: Integer;'                + sLineBreak +
                        'begin'                        + sLineBreak;
{$IFDEF USE_FREE_AND_NIL}
sRemoteClsDtrImplPas3 = '  for I := 0 to System.Length(%0:s)-1 do'   + sLineBreak +
                        '    SysUtils.FreeAndNil(%0:s[I]);'          + sLineBreak +
                        '  System.SetLength(%0:s, 0);'               + sLineBreak;
{$ELSE}
sRemoteClsDtrImplPas3 = '  for I := 0 to System.Length(%0:s)-1 do'   + sLineBreak +
                        '    if Assigned(%0:s[I]) then'              + sLineBreak +
                        '      %0:s[I].Free;'                        + sLineBreak +
                        '  System.SetLength(%0:s, 0);'               + sLineBreak;
{$ENDIF}
{$IFDEF USE_FREE_AND_NIL}
sRemoteClsDtrImplPas4 = '  SysUtils.FreeAndNil(%0:s);'        + sLineBreak;
{$ELSE}
sRemoteClsDtrImplPas4 = '  if Assigned(%0:s) then'     + sLineBreak +
                        '    %0:s.Free;'               + sLineBreak;
{$ENDIF}
sRemoteClsDtrImplPas5 = '  inherited Destroy;'         + sLineBreak +
                        'end;'                         + sLineBreak;

sInterfaceDeclPas     = '  %s = interface(%s)'                      + sLineBreak +
                        '  [''%s'']'                                + sLineBreak;
sInterfaceDeclEndPas  = '  end;'                                    + sLineBreak + sLineBreak;

{ For cases where WSDL has Binding }
sIntfFactoryDeclPas1  = 'function Get%0:s(UseWSDL: Boolean=System.False; Addr: string=''''; HTTPRIO: THTTPRIO = nil): %0:s;'  + sLineBreak;
sFactoryImplPas1      = 'function Get%0:s(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): %0:s;'  + sLineBreak +
                        'const'                                                    + sLineBreak +
                        '  defWSDL = ''%1:s'';'                                    + sLineBreak +
                        '  defURL  = ''%2:s'';'                                    + sLineBreak +
                        '  defSvc  = ''%3:s'';'                                    + sLineBreak +
                        '  defPrt  = ''%4:s'';'                                    + sLineBreak +
                        'var'                                                      + sLineBreak +
                        '  RIO: THTTPRIO;'                                         + sLineBreak +
                        'begin'                                                    + sLineBreak +
                        '  Result := nil;'                                         + sLineBreak +
                        '  if (Addr = '''') then'                                  + sLineBreak +
                        '  begin'                                                  + sLineBreak +
                        '    if UseWSDL then'                                      + sLineBreak +
                        '      Addr := defWSDL'                                    + sLineBreak +
                        '    else'                                                 + sLineBreak +
                        '      Addr := defURL;'                                    + sLineBreak +
                        '  end;'                                                   + sLineBreak +
                        '  if HTTPRIO = nil then'                                  + sLineBreak +
                        '    RIO := THTTPRIO.Create(nil)'                          + sLineBreak +
                        '  else'                                                   + sLineBreak +
                        '    RIO := HTTPRIO;'                                      + sLineBreak +
                        '  try'                                                    + sLineBreak +
                        '    Result := (RIO as %0:s);'                             + sLineBreak +
                        '    if UseWSDL then'                                      + sLineBreak +
                        '    begin'                                                + sLineBreak +
                        '      RIO.WSDLLocation := Addr;'                          + sLineBreak +
                        '      RIO.Service := defSvc;'                             + sLineBreak +
                        '      RIO.Port := defPrt;'                                + sLineBreak +
                        '    end else'                                             + sLineBreak +
                        '      RIO.URL := Addr;'                                   + sLineBreak +
                        '  finally'                                                + sLineBreak +
                        '    if (Result = nil) and (HTTPRIO = nil) then'           + sLineBreak +
                        '      RIO.Free;'                                          + sLineBreak +
                        '  end;'                                                   + sLineBreak +
                        'end;'                                                     + sLineBreak +
                                                                                    sLineBreak;
{ For cases where we have a URL but no binding }
sIntfFactoryDeclPas2  = 'function Get%0:s(const Addr: string=''''): %0:s;'         + sLineBreak;
sFactoryImplPas2      = 'function Get%0:s(const Addr: string): %0:s;'              + sLineBreak +
                        'const'                                                    + sLineBreak +
                        '  defURL  = ''%1:s'';'                                    + sLineBreak +
                        'var'                                                      + sLineBreak +
                        '  RIO: THTTPRIO;'                                         + sLineBreak +
                        'begin'                                                    + sLineBreak +
                        '  Result := nil;'                                         + sLineBreak +
                        '  RIO := THTTPRIO.Create(nil);'                           + sLineBreak +
                        '  try'                                                    + sLineBreak +
                        '    Result := (RIO as %0:s);'                             + sLineBreak +
                        '    if (Addr = '''') then'                                + sLineBreak +
                        '      RIO.URL := defURL'                                  + sLineBreak +
                        '    else'                                                 + sLineBreak +
                        '      RIO.URL := Addr;'                                   + sLineBreak +
                        '  finally'                                                + sLineBreak +
                        '    if Result = nil then'                                 + sLineBreak +
                        '      RIO.Free;'                                          + sLineBreak +
                        '  end;'                                                   + sLineBreak +
                        'end;'                                                     + sLineBreak +
                                                                                    sLineBreak;
sImplDeclPas          = '  %0:sImpl = class(TInvokableClass, %0:s)' + sLineBreak +
                        '  public'                                  + sLineBreak +
                        '    { %0:s }'                              + sLineBreak;
sImplDeclPas2         = '  T%0:s = class(TInvokableClass, %0:s)'     + sLineBreak +
                        '  public'                                  + sLineBreak +
                        '    { %0:s }'                              + sLineBreak;
sImplDeclEndPas       = '  end;'                                    + sLineBreak + sLineBreak;

sImplSuffix           = 'Impl';

sIntfSuffix           = 'Intf';

sDummyImplPas         = 'begin'                                     + sLineBreak +
                        '  { TODO - Implement method %s }'          + sLineBreak +
                        'end;'                                      + sLineBreak + sLineBreak;

{0: Element Type Name }
sDefaultArrayDeclPas  = '    function   Get%0:sArray(Index: Integer): %0:s;       '           + sLineBreak +
                        '    procedure  Set%0:sArray(Index: Integer; const Item: %0:s);'      + sLineBreak +
                        '    function   Get%0:sArrayLength: Integer;'                         + sLineBreak +
                        '    procedure  Set%0:sArrayLength(Len: Integer);'                    + sLineBreak +
                                                                                                sLineBreak +
                        '    property   %0:sArray[Index: Integer]: %0:s read Get%0:sArray write Set%0:sArray; default;' + sLineBreak +
                        '    property   Len: Integer read Get%0:sArrayLength write Set%0:sArrayLength;'                 + sLineBreak;

{ 0: Class Type Name, 1: Element Type Name, 2: Member Name }
sDefaultArrayImplPas  = 'function %0:s.Get%1:sArray(Index: Integer): %1:s;' + sLineBreak +
                        'begin'                                                           + sLineBreak +
                        '  Result := F%2:s[Index];'                                       + sLineBreak +
                        'end;'                                                            + sLineBreak +
                                                                                            sLineBreak +
                        'procedure %0:s.Set%1:sArray(Index: Integer; const Item: %1:s);'  + sLineBreak +
                        'begin'                                                           + sLineBreak +
                        '   F%2:s[Index] := Item;'                                        + sLineBreak +
                        'end;'                                                            + sLineBreak +
                                                                                            sLineBreak +
                        'function %0:s.Get%1:sArrayLength: Integer;'                      + sLineBreak +
                        'begin'                                                           + sLineBreak +
                        '  if Assigned(F%2:s) then'                                       + sLineBreak +
                        '    Result := System.Length(F%2:s)'                                     + sLineBreak +
                        '  else'                                                          + sLineBreak +
                        '    Result := 0;'                                                + sLineBreak +
                        'end;'                                                            + sLineBreak +
                                                                                            sLineBreak +
                        'procedure %0:s.Set%1:sArrayLength(Len: Integer);'                + sLineBreak +
                        'begin'                                                           + sLineBreak +
                        '  System.SetLength(F%2:s, Len);'                                 + sLineBreak +
                        'end;'                                                            + sLineBreak + sLineBreak;

sRegInterfacePas3     = '  InvRegistry.RegisterInterface(TypeInfo(%s), ''%s'', ''%s'', '''', ''%s'', ''%s'');'  + sLineBreak;
sRegInterfacePas2     = '  InvRegistry.RegisterInterface(TypeInfo(%s), ''%s'', ''%s'', '''', ''%s'');'          + sLineBreak;
sRegInterfacePas1     = '  InvRegistry.RegisterInterface(TypeInfo(%s), ''%s'', ''%s'');'                        + sLineBreak;
sRegInvokableClass    = '  InvRegistry.RegisterInvokableClass(%s);'                                             + sLineBreak;

sRegSOAPActionPas     = '  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(%s), ''%s'');'                        + sLineBreak;
sRegAllSOAPActionPas  = '  InvRegistry.RegisterAllSOAPActions(TypeInfo(%s), %s);'                               + sLineBreak;

sRegUDDIInfoPas       = '  InvRegistry.RegisterUDDIInfo(TypeInfo(%s), ''%s'', ''%s'');'                         + sLineBreak;
sRegParamNamesPasBeg  = '  InvRegistry.RegisterReturnParamNames(TypeInfo(%s), ';

sRegInvokeOptDocPas   = '  InvRegistry.RegisterInvokeOptions(TypeInfo(%s), ioDocument);'                        + sLineBreak;
sRegInvokeOptLitPas   = '  InvRegistry.RegisterInvokeOptions(TypeInfo(%s), ioLiteral);'                         + sLineBreak;
sRegInvokeOptUDDIPas  = '  InvRegistry.RegisterInvokeOptions(TypeInfo(%s), ioHasUDDIInfo);'                     + sLineBreak;
sRegInvokeOptSOAP12Pas= '  InvRegistry.RegisterInvokeOptions(TypeInfo(%s), ioSOAP12);'                          + sLineBreak;

sRegMethodRenamedPas  = '  InvRegistry.RegisterExternalMethName(TypeInfo(%s), ''%s'', ''%s'');'             + sLineBreak;
sRegParamRenamedPas   = '  InvRegistry.RegisterExternalParamName(TypeInfo(%s), ''%s'', ''%s'', ''%s'');'    + sLineBreak;
sRegMemberRenamedPas  = '  RemClassRegistry.RegisterExternalPropName(TypeInfo(%s), ''%s'', ''%s'');'        + sLineBreak;

// Delphi Param Registration
sRegParamInfoPas       = '  InvRegistry.RegisterParamInfo(TypeInfo(%s), ''%s'', ''%s'', ''%s'','                 + sLineBreak +
                         '                                ''%s'', %s);'                                          + sLineBreak;
sRegParamInfoPasNoOpts = '  InvRegistry.RegisterParamInfo(TypeInfo(%s), ''%s'', ''%s'', ''%s'','                 + sLineBreak +
                         '                                ''%s'');'                                              + sLineBreak;
sRegParamInfoPasNoInfo = '  InvRegistry.RegisterParamInfo(TypeInfo(%s), ''%s'', ''%s'', ''%s'', '''');'          + sLineBreak;

// C++ Param Registration
sRegParamInfoCpp       = '  InvRegistry()->RegisterParamInfo(__delphirtti(%s), "%s", "%s", L"%s",'               + sLineBreak +
                         '                                   L"%s", %s);'                                        + sLineBreak;
sRegParamInfoCppNoOpts = '  InvRegistry()->RegisterParamInfo(__delphirtti(%s), "%s", "%s", L"%s",'               + sLineBreak +
                         '                                   L"%s");'                                            + sLineBreak;
sRegParamInfoCppNoInfo = '  InvRegistry()->RegisterParamInfo(__delphirtti(%s), "%s", "%s", L"%s", L"");'         + sLineBreak;

// Delphi Method Registration
sRegMethodInfoPas       = '  InvRegistry.RegisterMethodInfo(TypeInfo(%s), ''%s'', ''%s'','               + sLineBreak +
                          '                                 ''%s'', %s);'                                + sLineBreak;
sRegMethodInfoPasNoOpts = '  InvRegistry.RegisterMethodInfo(TypeInfo(%s), ''%s'', ''%s'','               + sLineBreak +
                          '                                 ''%s'');'                                    + sLineBreak;
sRegMethodInfoPasNoInfo = '  InvRegistry.RegisterMethodInfo(TypeInfo(%s), ''%s'', ''%s'', '''');'        + sLineBreak;

// C++ Method Registration
sRegMethodInfoCpp       = '  InvRegistry()->RegisterMethodInfo(__delphirtti(%s), "%s", "%s",'            + sLineBreak +
                          '                                    "%s", %s);'                               + sLineBreak;
sRegMethodInfoCppNoOpts = '  InvRegistry()->RegisterMethodInfo(__delphirtti(%s), "%s", "%s",'            + sLineBreak +
                          '                                    "%s" );'                                  + sLineBreak;
sRegMethodInfoCppNoInfo = '  InvRegistry()->RegisterMethodInfo(__delphirtti(%s), "%s", "%s", "" );'      + sLineBreak;

{ Class, Namespace, Name, ExternalName }
sRegClassPas2         = '  RemClassRegistry.RegisterXSClass(%s, ''%s'', ''%s'', ''%s'');'           + sLineBreak;
{ Class, Namespace, Name }
sRegClassPas1         = '  RemClassRegistry.RegisterXSClass(%s, ''%s'', ''%s'');'                   + sLineBreak;
{ Interface, Namespace, Name, ExternalName }
sRegTypePas2          = '  RemClassRegistry.RegisterXSInfo(TypeInfo(%s), ''%s'', ''%s'', ''%s'');'  + sLineBreak;
{ Interface, Namespace, Name }
sRegTypePas1          = '  RemClassRegistry.RegisterXSInfo(TypeInfo(%s), ''%s'', ''%s'');'          + sLineBreak;


sRegClassSerialOptsPas= '  RemClassRegistry.RegisterSerializeOptions(%s, %s);'                      + sLineBreak;
sRegInfoSerialOptsPas = '  RemClassRegistry.RegisterSerializeOptions(TypeInfo(%s), %s);'            + sLineBreak;

sRegHeaderPas1        = '  InvRegistry.RegisterHeaderClass(TypeInfo(%s), %s, %s, %s);'              + sLineBreak;
sRegHeaderPas2        = '  InvRegistry.RegisterHeaderClass(TypeInfo(%s), %s, ''%s'', ''%s'');'      + sLineBreak;
sRegHeaderMethPas     = '  InvRegistry.RegisterHeaderMethod(TypeInfo(%s), %s, ''%s'', %s, %s);'     + sLineBreak;

sRegFaultPas          = '  InvRegistry.RegisterException(TypeInfo(%s), %s);'                        + sLineBreak;
sRegFaultMethPas      = '  InvRegistry.RegisterExceptionMethod(TypeInfo(%s), %s, ''%s'');'          + sLineBreak;

sUnitSuffix           = '_WS';

SPasFileExt           = '.pas';
SCppFileExt           = '.cpp';
SHFileExt             = '.h';
{$IFDEF MSWINDOWS}
SDfmExt               = '.dfm';
{$ENDIF}
{$IFDEF LINUX}
SDfmExt               = '.xfm';
{$ENDIF}

XMLItemInfoComment: array[XMLItemInfo] of string = ('global',
                                                    'predefined',
                                                    '<element>',
                                                    '<complexType>',
                                                    '<simpleType>',
                                                    '<attribute>',
                                                    '<attributeGroup>',
                                                    '<group>',
                                                    'unbounded',
                                                    'alias',
                                                    'nillable',
                                                    'mixed'
                                                );

resourcestring

sImportWSDL = 'Import WSDL';
sImportWSDLEllipsis = 'Import WSDL...';

{ Wizard Reg }
SNewXMLDataBinding = 'XML Data Binding';

{ Wizard Form }
SWSDLDefExt        = '.wsdl';
SSourceFilter      = 'WSDL Files (*.wsdl, *.xml)|*.wsdl;*.xml|XML Files (*.xml)|*.xml|All files (*.*)|*.*';

SConfirmClose      = 'Are you sure you want to close the WSDL Importer Wizard?';
sNoBindingsFound   = 'No supported Bindings found in document';


sWSDLInfoBeg =
   '// ************************************************************************ //' + #13#10 +
   '// The types declared in this file were generated from data read from the'      + #13#10 +
   '// WSDL File described below:'                                                  + #13#10 +
   '// WSDL     : %0:s'                                                             + #13#10;

sImportInfo =
   '//  >Import : %s' + #13#10;

sEncodingInfo =
   '// Encoding : %s' + #13#10;

sVersionInfo =
   '// Version  : %s' + #13#10;

sSchemaRef =
   '// SchemaRef: %s' + #13#10;

sServices =
   '// Services : %s' + #13#10;

sPorts =
   '// Ports    : [Srvc %d] - %s' + #13#10;

sGenOptions =
   '// Codegen  : %s' + #13#10;

sWSDLInfoEnd =
   '// (%s - %s)'+ #13#10 +
   '// ************************************************************************ //' + #13#10 + #13#10;

sInfoBeg =
   '// ************************************************************************ //';

sInfoEnd =
   '// ************************************************************************ //' + #13#10;

sPredefinedInfo =
   '%0:s// The following types, referred to in the WSDL document are not being represented'     + #13#10 +
   '%0:s// in this file. They are either aliases[@] of other types represented or were referred'+ #13#10 +
   '%0:s// to but never[!] declared in the document. The types from the latter category'        + #13#10 +
   '%0:s// typically map to predefined/known XML or Embarcadero types; however, they could also '   + #13#10 +
   '%0:s// indicate incorrect WSDL documents that failed to declare or import a schema type.'   + #13#10;

sPredefinedTypes =
   '// !:%-15s - %s';

sDuplicateTypes =
   '// @:%-15s - %s';

sWarningInfoBegin =
   '%0:s// [WARNINGS]************************************************************** //';

sWarningInfo =
   '%0:s// %1:s';

sWarningInfoEnd =
   '%0:s// ************************************************************************ //';

sRegProcInfo =
   '// ************************************************************************ //' + #13#10 +
   '// This routine registers the interfaces and types exposed by the WebService.'  + #13#10;

sBindInfoGeneric =
   '// Info      : %s';

sExternalName =
   '// Name      : %s';

sSerialization =
   '// Serializtn: [%s]';

sXMLInfo       =
   '// XML       : %s';

sNamespaceInfo =
   '// Namespace : %s';

sSOAPActionInfo =
   '// soapAction: %s';

sTransportInfo =
   '// transport : %s';

sStyleInfo =
   '// style     : %s';
   
sUseInfo =
   '// use       : %s';   

sBindingInfo =
   '// binding   : %s';

sServiceInf =
   '// service   : %s';

sPortInfo =
   '// port      : %s';

sURLInfo =
   '// URL       : %s';   

sServerImpl  =  '%s - Server implementation class';

sBindInfoLocalName =
   '// LocalName : %s';

sBindInfoBaseType =
   '// BaseType  : %s';

sBindInfoBound =
   '// Bound     : %s';

sForwardDecl    =                                                                 #13#10 +
   '// *********************************************************************//' + #13#10 +
   '// Forward declaration of types defined in WSDL                           ' + #13#10 +
   '// *********************************************************************//' + #13#10;

sFeedbackRead      = 'Reading: %s';
sFeedbackWrite     = 'Writing: %s';
sFeedbackImp       = 'Import : %s';
sFeedbackDone      = 'Done   : %s';
sFeedbackUDDI      = 'UDDI   : %s';
sFeedbackSkip      = '(Skip) : %s';
sFeedbackError     = '*Error*: %s';
sFeedbackError2    = '       > %s';
sFeedbackDebug     = '(Debug): %s';
sWritingType       = '(Write): %s';
sReadingType       = '(Read) : %s';
sSortingType       = '(Sort) : %s:%d - %s';
sMovingType        = '(Move) : %s:%d -> %s:%d, (%s: %s)';
sDottedLine        = '------------------------------------------------';

sMissingDefinition = '*Error*: ''%s'' - Missing <definition> node of namespace "%s"';
sGenericTypeError  = '*Error*: ''%s'' - Invalid Type Definition encountered';
sComplexTypeError  = '*Error*: ''%s'' - Complex Type Definition Error, type="%s"';
sBindableTypeError = '*Error*: ''%s'' - %s';
sSchemaError       = '*Error*: ''%s'' - Invalid schema detected';
sGenericError      = '*Error*: %s';
sSummaryFeedback1  = 'Summary: Successfully imported %d of %d. %d failed:';
sSummaryFeedback2  = 'Summary: Successfully imported %d of %d Entries';
sFailureFeedback   =  #9'%s';
sSchemaWarning     = 'Warning: ''%s'' - Error in processing XML Schema';
sUnwindWarningIn   = 'Warning: Input  Literal parameters of %s() cannot be unwrapped';
sUnwindWarningOut  = 'Warning: Output Literal parameters of %s() cannot be unwrapped';


sWarningHeader     = '  { ================== WARNING ================== }';
sWarningAttribute  = '  { WARNING - Attribute - Name:%s, Type:%s }';

sCircularTypeLink  = 'Circular reference detected in type: %s';

sUnableToSort      = 'Unable to sort type ''%s'' due to circular reference!';
sUnableToSortTypes = 'Unable to sort types ''%s'' and ''%s'' due to circular references!';

{ Import Options }
sVerboseOpt        = 'Generate &verbose information about types and interfaces';
sSkipHTTPBindOpt   = 'Process only SOAP binding types';
sMapNamedArrays    = 'Map pure collections to wrapper class t&ypes';
sSkipUnusedTypes   = 'Do not emit unused &types';
sImportFaults      = 'Import Fau&lt Types';
sValidateEnum      = 'Validate Enumeration members';
sImportHeaders     = 'Import &Header Types';
sGenTrueGUID       = 'Generate interface GUIDs using &COM API';
sCollapseAliases   = 'Collapse simple alias types';
sForceSOAP11       = '&Process only WSDL Binding extensions for the SOAP 1.1 Protocol';
sForceSOAP12       = 'Process &only WSDL Binding extensions for the SOAP 1.2 Protocol';
sOneOutParamIsReturn = '&One out parameter is return value';
sGenServerImpl     = 'Generate &server implementation instead of client proxies';
sGenerateWarnings  = 'Generate &warning comments';
sAmbiguousComplexTypesAsArray = 'Ambiguous Complex Types are considered arrays';
sAutoDestroyMembers = 'Generate &destructors for remotable types';
sMapStringsToWideStrings = '&Map String to WideString';
sOutputLiteralTypes = '&Emit wrapper element Types';
sUnwindLiteralTypes = '&Unwrap wrapper elements (wrapped doc|lit services)';
sIgnoreSchemaErrors = 'Ignore Schema Errors';

sProcessRefSchemas = 'Process included &and imported schemas';
sStrongClassAliases= 'Gene&rate class aliases as class types';
sAllowOutParameters     = 'Allow out &parameters';
sUseSettersAndGetters   = 'Use Setters a&nd Getters for properties';
sProcessNillableOptional= 'Process n&illable and optional elements';
sUseXSTypeForSimpleNillable = 'Use T&XSxxxx classes for simple nillable types';
sUseScopedEnumerations = '&Generate scoped enumerations';
sCreateArrayElemTypeAlias = 'Generate alias for the element of pure collections';

sCouldNotUnwrapDocLitElementWrapper = 'Cannot unwrap';
sCUInputMessageHasMoreThanOnePart = 'Input message has more than one part';
sCUOutputMessageHasMoreThanOnePart= 'Output message has more than one part';
sCUInputPartRefersToTypeNotElement= 'Input part does not refer to an element';
sCUOutputPartRefersToTypeNotElement='Output part does not refer to an element';
sCUInputWrapperElementNotSameAsOperationName = 'Input element wrapper name does not match operation''s name';
sCUInputPartNotAComplexType = 'The input part is not a complex type';
sCUOutputPartNotAComplexType= 'The output part is not a complex type';
sCUMoreThanOneStrictlyOutMembersWereFound = 'More than one strictly out element was found';
sCUTypeNeedsSpecialSerialization = 'Wrapper type needs special serialization';
sCUOutputElementIsAPureCollection= 'Output element is a pure collection';

sMethodHeaders = 'Headers';

sWSDLImportError = 'WSDL Import Error';
sErrorImportingWSDL1 = 'An error was encountered importing ''%s''';
sErrorImportingWSDL2 = 'Please verify that you''ve entered the correct URL/file and that it''s a valid WSDL file.';
sErrorImportingWSDL3 = 'Do you want to try again?';

const

CannotUnwrapStr: array[CannotUnwrap] of String = (
                                            sCUInputMessageHasMoreThanOnePart,
                                            sCUOutputMessageHasMoreThanOnePart,
                                            sCUInputPartRefersToTypeNotElement,
                                            sCUOutputPartRefersToTypeNotElement,
                                            sCUInputWrapperElementNotSameAsOperationName,
                                            sCUInputPartNotAComplexType,
                                            sCUOutputPartNotAComplexType,
                                            sCUMoreThanOneStrictlyOutMembersWereFound,
                                            sCUTypeNeedsSpecialSerialization,
                                            sCUOutputElementIsAPureCollection
                                                   );

  OptionsSection            = 'Import Options';         { do not localize }
  DeclareNamespace          = 'DeclaredNamespace';      { do not localize }
  OneParamIsReturnSetting   = 'OneParamIsResult';       { do not localize }
  UnwindLiteralParamsSetting= 'UnwindLitParams';        { do not localize }
  GenDestructorsSetting     = 'GenDestructors';         { do not localize }
  IgnoreSchemaErrorsSetting = 'IgnoreSchemaErrors';     { do not localize }
  GenWarningsSetting        = 'GenWarnings';            { do not localize }
  GenLiteralTypesSetting    = 'GenLitTypes';            { do not localize }
  AmbTypesAsArraySetting    = 'AmbiguousTypesAsArray';  { do not localize }
  GenServerSetting          = 'GenServerImpl';          { do not localize }
  MapStringToWideStrSetting = 'MapStringToWS';          { do not localize }
  MapPureCollToClass        = 'MapPureCollToClass';     { do not localize }
  UseClassForAttr           = 'UseClassForAttr';        { do not localize }
  ProcessFaults             = 'ProcessFaults';          { do not localize }
  SkipUnusedTypes           = 'SkipUnusedTypes';        { do not localize }
  SkipHttpBindings          = 'SkipHttpBindings';       { do not localize }
  VerboseMode               = 'VerboseMode';            { do not localize }
  ValidateEnumMembers       = 'ValidateEnumMembers';    { do not localize }
  ProcessHeaders            = 'ProcessHeaders';         { do not localize }
  GenTrueGUIDs              = 'GenerateTrueGUIDs';      { do not localize }
  ProcessRefSchemas         = 'ProcessRefSchemas';      { do not localize }
  StrongClassAliases        = 'StrongClassAliases';     { do not localize }
  AllowMultipleOutParams    = 'AllowMultipleOutParams'; { do not localize }
  UseSettersAndGetters      = 'UseSettersAndGetters';   { do not localize }
  ProcessNillableOptional   = 'ProcessNillableOptional';{ do not localize }
  UseXSForSimpleNillable    = 'UseXSForSimpleNillable'; { do not localize }
  UseScopedEnumerations     = 'UseScopedEnumerations';  { do not localize }
  ForceSOAP11               = 'ForceSOAP11';            { do not localize }
  ForceSOAP12               = 'ForceSOAP12';            { do not localize }
  CreateArrayElemTypeAlias  = 'CreateArrayElemTypeAlias';{ do not localize }

  OptStrings: array[WSDLGenFlags] of string  =
                ('',                                { wfDebug }
                 VerboseMode,                       { wfVerbose }
                 SkipHttpBindings,                  { wfSkipHttpBindings }
                 OneParamIsReturnSetting,           { wfOneOutIsReturn }
                 GenServerSetting,                  { wfServer }
                 '',                                { wfUseXMLBindingManager }
                 AmbTypesAsArraySetting,            { wfAmbiguousComplexTypesAsArray }
                 UnwindLiteralParamsSetting,        { wfUnwindLiteralTypes }
                 GenLiteralTypesSetting,            { wfOutputLiterayTypes }
                 MapStringToWideStrSetting,         { wfMapStringsToWideStrings }
                 IgnoreSchemaErrorsSetting,         { wfIgnoreSchemaErrors }
                 '',                                { wfAutoInitMembers }
                 GenDestructorsSetting,             { wfAutoDestroyMembers }
                 '',                                { wfQuietMode }
                 '',                                { wfSelectiveCodeGen }
                 GenWarningsSetting,                { wfGenerateWarnings }
                 MapPureCollToClass,                { wfMapArraysToClasses }
                 DeclareNamespace,                  { wfTypesInNamespace }
                 SkipUnusedTypes,                   { wfSkipUnusedTypes }
                 UseClassForAttr,                   { wfUseSerializerClassForAttrs }
                 ValidateEnumMembers,               { wfValidateEnumMembers }
                 ProcessFaults,                     { wfProcessFaults }
                 ProcessHeaders,                    { wfProcessHeaders }
                 GenTrueGUIDs,                      { wfGenTrueGUIDs }
                 ProcessRefSchemas,                 { wfProcessRefSchemas }
                 StrongClassAliases,                { wfStrongClassAliases}
                 AllowMultipleOutParams,            { wfAllowOutParameters}
                 UseSettersAndGetters,              { wfUseSettersAndGetters }
                 ProcessNillableOptional,           { wfProcessOptionalNillable }
                 UseXSForSimpleNillable,            { wfUseXSTypeForSimpleNillable }
                 UseScopedEnumerations,             { wfUseScopedEnumerations }
                 ForceSOAP11,                       { wfForceSOAP11 }
                 ForceSOAP12,                       { wfForceSOAP12 }
                 CreateArrayElemTypeAlias,          { wfCreateArrayElemTypeAlias }
                 ''                                 { wfLastOption }
                 );

  OptDescriptions: array[WSDLGenFlags] of string =
                ('',                                { wfDebug }
                 sVerboseOpt,                       { wfVerbose }
                 sSkipHTTPBindOpt,                  { wfSkipHttpBindings }
                 sOneOutParamIsReturn,              { wfOneOutIsReturn }
                 sGenServerImpl,                    { wfServer }
                 '',                                { wfUseXMLBindingManager }
                 sAmbiguousComplexTypesAsArray,     { wfAmbiguousComplexTypesAsArray }
                 sUnwindLiteralTypes,               { wfUnwindLiteralTypes }
                 sOutputLiteralTypes,               { wfOutputLiterayTypes }
                 sMapStringsToWideStrings,          { wfMapStringsToWideStrings }
                 sIgnoreSchemaErrors,               { wfIgnoreSchemaErrors }
                 '',                                { wfAutoInitMembers }
                 sAutoDestroyMembers,               { wfAutoDestroyMembers }
                 '',                                { wfQuietMode }
                 '',                                { wfSelectiveCodeGen }
                 sGenerateWarnings,                 { wfGenerateWarnings }
                 sMapNamedArrays,                   { wfMapArraysToClasses }
                 '',                                { wfTypesInNamespace }
                 sSkipUnusedTypes,                  { wfSkipUnusedTypes }
                 '',                                { wfUseSerializerClassForAttrs }
                 sValidateEnum,                     { wfValidateEnumMembers }
                 sImportFaults,                     { wfProcessFaults }
                 sImportHeaders,                    { wfProcessHeaders }
                 sGenTrueGUID,                      { wfGenTrueGUIDs }
                 sProcessRefSchemas,                { wfProcessRefSchemas }
                 sStrongClassAliases,               { wfStrongClassAliases }
                 sAllowOutParameters,               { wfAllowOutParameters }
                 sUseSettersAndGetters,             { wfUseSettersAndGetters }
                 sProcessNillableOptional,          { wfProcessNillableOptional }
                 sUseXSTypeForSimpleNillable,       { wfUseXSTypeForSimpleNillable }
                 sUseScopedEnumerations,            { wfUseScopedEnumerations }
                 sForceSOAP11,                      { wfForceSOAP11 }
                 sForceSOAP12,                      { wfForceSOAP12 }
                 sCreateArrayElemTypeAlias,         { wfCreateArrayElemTypeAlias }
                 ''                                 { wfLastOption }
                 );

  OptHiddenOptions: array[WSDLGenFlags] of Boolean =
                (True,                              { wfDebug } // Debugging output
                 False,                             { wfVerbose }
                 True,                              { wfSkipHttpBindings } //Removed temporarily until it can be properly implemented
                 False,                             { wfOneOutIsReturn }
                 False,                             { wfServer }
                 True,                              { wfUseXMLBindingManager } // Deprecated
                 True,                              { wfAmbiguousComplexTypesAsArray } // Deprecated
                 False,                             { wfUnwindLiteralTypes }
                 False,                             { wfOutputLiterayTypes }
                 False,                             { wfMapStringsToWideStrings }
                 True,                              { wfIgnoreSchemaErrors } // Deprecated (MarkE fixes Schema problems)
                 True,                              { wfAutoInitMembers }   // Never properly implemented
                 False,                             { wfAutoDestroyMembers }
                 True,                              { wfQuietMode }  // Hidden option for testing (does not emit date)
                 True,                              { wfSelectiveCodeGen } // Deprecated was used by old Importer
                 False,                             { wfGenerateWarnings }
                 False,                             { wfMapArraysToClasses }
                 True,                              { wfTypesInNamespace }  // Always ON (Only applicable to C++)
                 False,                             { wfSkipUnusedTypes }
                 True,                              { wfUseSerializerClassForAttrs } // Deprecated
                 True,                              { wfValidateEnumMembers }  //Not safe to turn off, Will generate code with keywords in enumerations
                 False,                             { wfProcessFaults }
                 False,                             { wfProcessHeaders }
                 False,                             { wfGenTrueGUIDs }
                 False,                             { wfProcessRefSchemas }
                 False,                             { wfStrongClassAliases }
                 False,                             { wfAllowOutParameters } // NA for C++
                 False,                             { wfUseSettersAndGetters }
                 False,                             { wfProcessNillableOptional }
                 False,                             { wfUseXSTypeForSimpleNillable }
                 False,                             { wfUseScopedEnumerations }
                 False,                             { wfForceSOAP11 }
                 False,                             { wfForceSOAP12 }
                 True,                              { wfCreateArrayElemTypeAlias }
                 True                               { wfLastOption }
                 );

  OptCommandLineFlags: array[WSDLGenFlags] of string  =
                ('debug',                           { wfDebug }
                 'v',                               { wfVerbose }
                 '',                                { wfSkipHttpBindings }
                 'o',                               { wfOneOutIsReturn }
                 's',                               { wfServer }
                 '',                                { wfUseXMLBindingManager }
                 '',                                { wfAmbiguousComplexTypesAsArray }
                 'u',                               { wfUnwindLiteralTypes }
                 'l',                               { wfOutputLiterayTypes }
                 'w',                               { wfMapStringsToWideStrings }
                 '',                                { wfIgnoreSchemaErrors }
                 '',                                { wfAutoInitMembers }
                 'd',                               { wfAutoDestroyMembers }
                 '',                                { wfQuietMode }
                 '',                                { wfSelectiveCodeGen }
                 'i',                               { wfGenerateWarnings }
                 'k',                               { wfMapArraysToClasses }
                 '',                                { wfTypesInNamespace }
                 't',                               { wfSkipUnusedTypes }
                 '',                                { wfUseSerializerClassForAttrs }
                 'j',                               { wfValidateEnumMembers }
                 'f',                               { wfProcessFaults }
                 'h',                               { wfProcessHeaders }
                 'g',                               { wfGenTrueGUIDs }
                 'p',                               { wfProcessRefSchemas }
                 'x',                               { wfStrongClassAliases}
                 'm',                               { wfAllowOutParameters}
                 'b',                               { wfUseSettersAndGetters }
                 'a',                               { wfProcessOptionalNillable }
                 'z',                               { wfUseXSTypeForSimpleNillable }
                 'e',                               { wfUseScopedEnumerations }
                 'SOAP11',                          { wfForceSOAP11 }
                 'SOAP12',                          { wfForceSOAP12 }
                 'r',                               { wfCreateArrayElemTypeAlias }
                 ''                                 { wfLastOption }
                 );

implementation

function IsOptionHandledByOptionsPage(const Flag: WSDLGenFlags): Boolean;
begin
  Result := Length(OptCommandLineFlags[Flag]) = 1;
end;

end.
