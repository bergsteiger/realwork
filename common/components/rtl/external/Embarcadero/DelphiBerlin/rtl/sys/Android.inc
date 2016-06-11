{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}
const
  AndroidLib = '/usr/lib/libandroid.so';

type
  PAConfiguration = Pointer;
  PAAssetManager = Pointer;

  ANativeActivity = record
    callbacks : Pointer;
    vm : Pointer;
    env : Pointer;
    clazz : Pointer;
    internalDataPath : MarshaledAString;
    externalDataPath : MarshaledAString;
    sdkVersion : Int32;
    instance : Pointer;
    assetManager : PAAssetManager;
  end;
  PANativeActivity = ^ANativeActivity;

function AConfiguration_new: PAConfiguration; cdecl;
  external AndroidLib name 'AConfiguration_new'

procedure AConfiguration_delete(Config: PAConfiguration); cdecl;
  external AndroidLib name 'AConfiguration_delete'

procedure AConfiguration_fromAssetManager(OutConfig: PAConfiguration;AssetManager: PAAssetManager); cdecl;
  external AndroidLib name 'AConfiguration_fromAssetManager'

procedure AConfiguration_getLanguage(Config: PAConfiguration; OutLanguage: MarshaledAString); cdecl;
  external AndroidLib name 'AConfiguration_getLanguage'

procedure AConfiguration_getCountry(Config: PAConfiguration; OutCountry:  MarshaledAString); cdecl;
  external AndroidLib name 'AConfiguration_getCountry'

procedure ANativeActivity_finish(Activity: Pointer); cdecl;
  external AndroidLib name 'ANativeActivity_finish'


// JNI

type

  _JNIObject = record
  end;

  JNIObject       = ^_JNIObject;
  JNIClass        = JNIObject;
  JNIString       = JNIObject;

  JNIFieldID = ^_JNIFieldID;
  _JNIFieldID = record
  end;

  JNIMethodID = ^_JNIMethodID;
  _JNIMethodID = record
  end;

  JNIEnv              = ^JNINativeInterface;
  PJNIEnv             = ^JNIEnv;
  PPJNIEnv            = ^PJNIEnv;

  JavaVM              = ^JNIInvokeInterface;
  PJavaVM             = ^JavaVM;
  PPJavaVM            = ^PJavaVM;

  JNINativeInterface = packed record
    r1: array[0..22] of Pointer;
    DeleteLocalRef: procedure(Env: PJNIEnv; Obj: JNIObject); cdecl;
    r2: array[0..6] of Pointer;
    GetObjectClass: function(Env: PJNIEnv; Obj: JNIObject): JNIClass; cdecl;
    r3: Pointer;
    GetMethodID: function(Env: PJNIEnv; AClass: JNIClass; const Name: MarshaledAString; const Sig: MarshaledAString): JNIMethodID; cdecl;
    r4: array[0..1] of Pointer;
    CallObjectMethodA: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: Pointer): JNIObject; cdecl;
    r5: array[0..56] of Pointer;
    GetFieldID: function(Env: PJNIEnv; AClass: JNIClass; const Name: MarshaledAString; const Sig: MarshaledAString): JNIFieldID; cdecl;
    GetObjectField: function(Env: PJNIEnv; Obj: JNIObject; FieldID: JNIFieldID): JNIObject; cdecl;
    r6: array[0..67] of Pointer;
    GetStringLength: function(Env: PJNIEnv; Str: JNIString): Integer; cdecl;
    GetStringChars: function(Env: PJNIEnv; Str: JNIString; IsCopy: Pointer): Pointer; cdecl;
    ReleaseStringChars: procedure(Env: PJNIEnv; Str: JNIString; const Chars: Pointer); cdecl;
    r7: array[0..65] of Pointer;
  end;

  JNIInvokeInterface = packed record
    reserved0: Pointer;
    reserved1: Pointer;
    reserved2: Pointer;
    DestroyJavaVM: Pointer;
    AttachCurrentThread: function(PVM: PJavaVM; PEnv: PPJNIEnv; Args: Pointer): Integer; cdecl;
    DetachCurrentThread: Pointer;
    GetEnv: Pointer;
    AttachCurrentThreadAsDaemon: Pointer;
  end;


function JNIStringToString(Env: PJNIEnv; JStr: JNIString): string;
var
  Chars: Pointer;
begin
  Result := '';
  if JStr <> nil then
  begin
    Chars := Env^.GetStringChars(Env, JStr, nil);
    SetString(Result, PWideChar(Chars), Env^.GetStringLength(Env, JStr));
    if Chars <> nil then
      Env^.ReleaseStringChars(Env, JStr, Chars);
  end;
end;

function GetAndroidLocaleNameJNI: string;
var
  PEnv: PJniEnv;

  ContextClass: JNIClass;
  LgetResourcesFuncID: JNIMethodID;
  LJResources: JNIObject;

  ResourcesClass: JNIClass;
  LgetConfigurationFuncID: JNIMethodID;
  LJConfiguration: JNIObject;

  ConfigurationClass: JNIClass;
  LgetlocaleFieldID: JNIFieldID;
  LJLocale: JNIObject;

  LocaleClass: JNIClass;
  LgetCountryFuncID: JNIMethodID;
  LJCountry: JNIObject;

  LgetLanguageFuncID: JNIMethodID;
  LJLanguage: JNIObject;

begin
  PJavaVM(System.JavaMachine)^.AttachCurrentThread(System.JavaMachine, @PEnv, nil);

  //getResources().getConfiguration().locale.getLanguage() + '_' + getResources().getConfiguration().locale.getCountry()

  // getResources()
  ContextClass := PEnv^.GetObjectClass(PEnv, System.JavaContext);
  LgetResourcesFuncID := PEnv^.GetMethodID(PEnv, ContextClass, 'getResources', '()Landroid/content/res/Resources;');
  LJResources := PEnv^.CallObjectMethodA(PEnv, System.JavaContext, LgetResourcesFuncID, nil);

  // getConfiguration()
  ResourcesClass := PEnv^.GetObjectClass(PEnv, LJResources);
  LgetConfigurationFuncID := PEnv^.GetMethodID(PEnv, ResourcesClass, 'getConfiguration', '()Landroid/content/res/Configuration;');
  LJConfiguration := PEnv^.CallObjectMethodA(PEnv, LJResources, LgetConfigurationFuncID, nil);

  // locale
  ConfigurationClass := PEnv^.GetObjectClass(PEnv, LJConfiguration);
  LgetlocaleFieldID := PEnv^.GetFieldID(PEnv, ConfigurationClass, 'locale', 'Ljava/util/Locale;');
  LJLocale := PEnv^.GetObjectField(PEnv, LJConfiguration, LgetlocaleFieldID);

  // getLanguage()
  LocaleClass := PEnv^.GetObjectClass(PEnv, LJLocale);
  LgetLanguageFuncID := PEnv^.GetMethodID(PEnv, LocaleClass, 'getLanguage', '()Ljava/lang/String;');
  LJLanguage := PEnv^.CallObjectMethodA(PEnv, LJLocale, LgetLanguageFuncID, nil);

  Result := JNIStringToString(PEnv, LJLanguage);


  // getCountry()
  LgetCountryFuncID := PEnv^.GetMethodID(PEnv, LocaleClass, 'getCountry', '()Ljava/lang/String;');
  LJCountry := PEnv^.CallObjectMethodA(PEnv, LJLocale, LgetCountryFuncID, nil);

  Result := Result + '_' + JNIStringToString(PEnv, LJCountry);

  PEnv^.DeleteLocalRef(PEnv, LJLanguage);
  PEnv^.DeleteLocalRef(PEnv, LJCountry);
  PEnv^.DeleteLocalRef(PEnv, LocaleClass);

  PEnv^.DeleteLocalRef(PEnv, ConfigurationClass);
  PEnv^.DeleteLocalRef(PEnv, LJLocale);

  PEnv^.DeleteLocalRef(PEnv, ResourcesClass);
  PEnv^.DeleteLocalRef(PEnv, LJConfiguration);

  PEnv^.DeleteLocalRef(PEnv, ContextClass);
  PEnv^.DeleteLocalRef(PEnv, LJResources);
end;


function GetAndroidLocaleName: string;
var
  Lang, Country: MarshaledAString;
  AConfiguration: PAConfiguration;
begin
  if System.DelphiActivity <> nil then
  begin
    Lang := System.AllocMem(3);
    Country := System.AllocMem(3);
    AConfiguration := AConfiguration_new();
    AConfiguration_fromAssetManager(AConfiguration, PANativeActivity(System.DelphiActivity)^.assetManager);
    AConfiguration_getLanguage(AConfiguration, Lang);
    AConfiguration_getCountry(AConfiguration, Country);
    Result := string(Lang + '_' + Country);
    FreeMem(Lang);
    FreeMem(Country);
    AConfiguration_delete(AConfiguration);
  end
  else
    Result := GetAndroidLocaleNameJNI;
end;

