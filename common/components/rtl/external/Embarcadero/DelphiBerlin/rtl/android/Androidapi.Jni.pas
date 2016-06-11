{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.Jni;

interface

(*$HPPEMIT '#include <jni.h>' *)

{.$DEFINE DEBUGUTILS}

type
  va_list = Pointer;
  {$EXTERNALSYM va_list}
  JNIInt     = Integer;
  JNILong    = Int64;
  JNIByte    = Shortint;
  TByteArray = array of Byte;
  TIntegerArray = array of Integer;

const
  JNI_VERSION_1_1 = JNIInt($00010001);
  {$EXTERNALSYM JNI_VERSION_1_1}
  JNI_VERSION_1_2 = JNIInt($00010002);
  {$EXTERNALSYM JNI_VERSION_1_2}
  JNI_VERSION_1_4 = JNIInt($00010004);
  {$EXTERNALSYM JNI_VERSION_1_4}
  JNI_VERSION_1_6 = JNIInt($00010006);
  {$EXTERNALSYM JNI_VERSION_1_6}

  // JBoolean constants
  JNI_FALSE = 0;
  {$EXTERNALSYM JNI_FALSE}
  JNI_TRUE  = 1;
  {$EXTERNALSYM JNI_TRUE}

  // possible return values for JNI functions.
  JNI_OK        =  0;  // success
  {$EXTERNALSYM JNI_OK}
  JNI_ERR       = -1;  // unknown error
  {$EXTERNALSYM JNI_ERR}
  JNI_EDETACHED = -2;  // thread detached from the VM
  {$EXTERNALSYM JNI_EDETACHED}
  JNI_EVERSION  = -3;  // JNI version error
  {$EXTERNALSYM JNI_EVERSION}
  JNI_ENOMEM    = -4;  // not enough memory
  {$EXTERNALSYM JNI_ENOMEM}
  JNI_EEXIST    = -5;  // VM already created
  {$EXTERNALSYM JNI_EEXIST}
  JNI_EINVAL    = -6;  // invalid arguments
  {$EXTERNALSYM JNI_EINVAL}

  // used in ReleaseScalarArrayElements
  JNI_COMMIT = 1;
  {$EXTERNALSYM JNI_COMMIT}
  JNI_ABORT  = 2;
  {$EXTERNALSYM JNI_ABORT}


type
  // JNI Types
  JNIBoolean = Byte;
  JNIChar    = WideChar;
  JNIShort   = Smallint;
  JNIFloat   = Single;
  JNIDouble  = Double;
  JNISize    = JNIInt;
  _JNIObject = record
  end;

  JNIObject       = ^_JNIObject;
  JNIClass        = JNIObject;
  JNIThrowable    = JNIObject;
  JNIString       = JNIObject;
  JNIArray        = JNIObject;
  JNIBooleanArray = JNIArray;
  JNIByteArray    = JNIArray;
  JNICharArray    = JNIArray;
  JNIShortArray   = JNIArray;
  JNIIntArray     = JNIArray;
  JNILongArray    = JNIArray;
  JNIFloatArray   = JNIArray;
  JNIDoubleArray  = JNIArray;
  JNIObjectArray  = JNIArray;

  JNIWeak = JNIObject;
  JNIRef  = JNIObject;

  JNIValue = packed record
  case Integer of
    0: (z: JNIBoolean);
    1: (b: JNIByte   );
    2: (c: JNIChar   );
    3: (s: JNIShort  );
    4: (i: JNIInt    );
    5: (j: JNILong   );
    6: (f: JNIFloat  );
    7: (d: JNIDouble );
    8: (l: JNIObject );
  end;

  TJNIValueArray = array of JNIValue;

  JNIFieldID = ^_JNIFieldID;
  _JNIFieldID = record
  end;

  JNIMethodID = ^_JNIMethodID;
  _JNIMethodID = record
  end;

  //PPointer       = ^Pointer;
  PJNIByte         = ^JNIByte;
  PJNIBoolean      = ^JNIBoolean;
  PJNIChar         = ^JNIChar;
  PJNIShort        = ^JNIShort;
  PJNIInt          = ^JNIInt;
  PJNILong         = ^JNILong;
  PJNIFloat        = ^JNIFloat;
  PJNIDouble       = ^JNIDouble;
  PJNIString       = ^JNIString;
  PJNISize         = ^JNISize;
  PJNIClass        = ^JNIClass;
  PJNIObject       = ^JNIObject;
  PJNIThrowable    = ^JNIThrowable;
  PJNIArray        = ^JNIArray;
  PJNIByteArray    = ^JNIByteArray;
  PJNIBooleanArray = ^JNIBooleanArray;
  PJNICharArray    = ^JNICharArray;
  PJNIShortArray   = ^JNIShortArray;
  PJNIIntArray     = ^JNIIntArray;
  PJNILongArray    = ^JNILongArray;
  PJNIFloatArray   = ^JNIFloatArray;
  PJNIDoubleArray  = ^JNIDoubleArray;
  PJNIObjectArray  = ^JNIObjectArray;
  PJNIFieldID      = ^JNIFieldID;
  PJNIMethodID     = ^JNIMethodID;
  PJNIValue        = ^JNIValue;
  PJNIWeak         = ^JNIWeak;
  PJNIRef          = ^JNIRef;
  
  JNIObjectRefType=(JNIInvalidRefType=0,
                  JNILocalRefType=1,
                  JNIGlobalRefType=2,
      JNIWeakGlobalRefType=3);

  // used in RegisterNatives to describe native method name, signature,
  // and function pointer.
  PJNINativeMethod = ^JNINativeMethod;
  JNINativeMethod = packed record
    name: MarshaledAString;
    signature: MarshaledAString;
    fnPtr: Pointer;
  end;
  {$EXTERNALSYM JNINativeMethod}

  PJavaVMAttachArgs = ^JavaVMAttachArgs;
  JavaVMAttachArgs = packed record
    version: JNIInt;
    name: MarshaledAString;
    group: JNIObject;
  end;
  {$EXTERNALSYM JavaVMAttachArgs}


  // JNI Native Method Interface.
  JNIEnv              = ^JNINativeInterface;
  {$EXTERNALSYM JNIEnv}
  PJNIEnv             = ^JNIEnv;
  PPJNIEnv            = ^PJNIEnv;
  PJNINativeInterface = ^JNINativeInterface;

  // JNI Invocation Interface.
  JavaVM              = ^JNIInvokeInterface;
  {$EXTERNALSYM JavaVM}
  PJavaVM             = ^JavaVM;
  PPJavaVM            = ^PJavaVM;
  PJNIInvokeInterface = ^JNIInvokeInterface;

  JNINativeInterface = packed record
    reserved0: Pointer;
    reserved1: Pointer;
    reserved2: Pointer;
    reserved3: Pointer;

    GetVersion: function(Env: PJNIEnv): JNIInt; cdecl;
    DefineClass: function(Env: PJNIEnv; const Name: MarshaledAString; Loader: JNIObject; const Buf: PJNIByte; Len: JNISize): JNIClass; cdecl;
    FindClass: function(Env: PJNIEnv; const Name: MarshaledAString): JNIClass; cdecl;

    // Reflection Support
    FromReflectedMethod: function(Env: PJNIEnv; Method: JNIObject): JNIMethodID; cdecl;
    FromReflectedField: function(Env: PJNIEnv; Field: JNIObject): JNIFieldID; cdecl;
    ToReflectedMethod: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; IsStatic: JNIBoolean): JNIObject; cdecl;

    GetSuperclass: function(Env: PJNIEnv; Sub: JNIClass): JNIClass; cdecl;
    IsAssignableFrom: function(Env: PJNIEnv; Sub: JNIClass; Sup: JNIClass): JNIBoolean; cdecl;

    // Reflection Support
    ToReflectedField: function(Env: PJNIEnv; AClass: JNIClass; FieldID: JNIFieldID; IsStatic: JNIBoolean): JNIObject; cdecl;

    Throw: function(Env: PJNIEnv; Obj: JNIThrowable): JNIInt; cdecl;
    ThrowNew: function(Env: PJNIEnv; AClass: JNIClass; const Msg: MarshaledAString): JNIInt; cdecl;
    ExceptionOccurred: function(Env: PJNIEnv): JNIThrowable; cdecl;
    ExceptionDescribe: procedure(Env: PJNIEnv); cdecl;
    ExceptionClear: procedure(Env: PJNIEnv); cdecl;
    FatalError: procedure(Env: PJNIEnv; const Msg: MarshaledAString); cdecl;

    // Local Reference Management
    PushLocalFrame: function(Env: PJNIEnv; Capacity: JNIInt): JNIInt; cdecl;
    PopLocalFrame: function(Env: PJNIEnv; Result: JNIObject): JNIObject; cdecl;

    NewGlobalRef: function(Env: PJNIEnv; LObj: JNIObject): JNIObject; cdecl;
    DeleteGlobalRef: procedure(Env: PJNIEnv; GRef: JNIObject); cdecl;
    DeleteLocalRef: procedure(Env: PJNIEnv; Obj: JNIObject); cdecl;
    IsSameObject: function(Env: PJNIEnv; Obj1: JNIObject; Obj2: JNIObject): JNIBoolean; cdecl;

    // Local Reference Management
    NewLocalRef: function(Env: PJNIEnv; Ref: JNIObject): JNIObject; cdecl;
    EnsureLocalCapacity: function(Env: PJNIEnv; Capacity: JNIInt): JNIInt; cdecl;

    AllocObject: function(Env: PJNIEnv; AClass: JNIClass): JNIObject; cdecl;
    NewObject: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID): JNIObject; cdecl;
    NewObjectV: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list): JNIObject; cdecl;
    NewObjectA: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue): JNIObject; cdecl;

    GetObjectClass: function(Env: PJNIEnv; Obj: JNIObject): JNIClass; cdecl;
    IsInstanceOf: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass): JNIBoolean; cdecl;

    GetMethodID: function(Env: PJNIEnv; AClass: JNIClass; const Name: MarshaledAString; const Sig: MarshaledAString): JNIMethodID; cdecl;

    CallObjectMethod: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID): JNIObject; cdecl;
    CallObjectMethodV: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: va_list): JNIObject; cdecl;
    CallObjectMethodA: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: PJNIValue): JNIObject; cdecl;

    CallBooleanMethod: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID): JNIBoolean; cdecl;
    CallBooleanMethodV: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: va_list): JNIBoolean; cdecl;
    CallBooleanMethodA: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: PJNIValue): JNIBoolean; cdecl;

    CallByteMethod: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID): JNIByte; cdecl;
    CallByteMethodV: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: va_list): JNIByte; cdecl;
    CallByteMethodA: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: PJNIValue): JNIByte; cdecl;

    CallCharMethod: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID): JNIChar; cdecl;
    CallCharMethodV: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: va_list): JNIChar; cdecl;
    CallCharMethodA: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: PJNIValue): JNIChar; cdecl;

    CallShortMethod: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID): JNIShort; cdecl;
    CallShortMethodV: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: va_list): JNIShort; cdecl;
    CallShortMethodA: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: PJNIValue): JNIShort; cdecl;

    CallIntMethod: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID): JNIInt; cdecl;
    CallIntMethodV: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: va_list): JNIInt; cdecl;
    CallIntMethodA: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: PJNIValue): JNIInt; cdecl;

    CallLongMethod: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID): JNILong; cdecl;
    CallLongMethodV: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: va_list): JNILong; cdecl;
    CallLongMethodA: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: PJNIValue): JNILong; cdecl;

    CallFloatMethod: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID): JNIFloat; cdecl;
    CallFloatMethodV: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: va_list): JNIFloat; cdecl;
    CallFloatMethodA: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: PJNIValue): JNIFloat; cdecl;

    CallDoubleMethod: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID): JNIDouble; cdecl;
    CallDoubleMethodV: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: va_list): JNIDouble; cdecl;
    CallDoubleMethodA: function(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: PJNIValue): JNIDouble; cdecl;

    CallVoidMethod: procedure(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID); cdecl;
    CallVoidMethodV: procedure(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: va_list); cdecl;
    CallVoidMethodA: procedure(Env: PJNIEnv; Obj: JNIObject; MethodID: JNIMethodID; Args: PJNIValue); cdecl;

    CallNonvirtualObjectMethod: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID): JNIObject; cdecl;
    CallNonvirtualObjectMethodV: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list): JNIObject; cdecl;
    CallNonvirtualObjectMethodA: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue): JNIObject; cdecl;

    CallNonvirtualBooleanMethod: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID): JNIBoolean; cdecl;
    CallNonvirtualBooleanMethodV: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list): JNIBoolean; cdecl;
    CallNonvirtualBooleanMethodA: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue): JNIBoolean; cdecl;

    CallNonvirtualByteMethod: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID): JNIByte; cdecl;
    CallNonvirtualByteMethodV: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list): JNIByte; cdecl;
    CallNonvirtualByteMethodA: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue): JNIByte; cdecl;

    CallNonvirtualCharMethod: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID): JNIChar; cdecl;
    CallNonvirtualCharMethodV: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list): JNIChar; cdecl;
    CallNonvirtualCharMethodA: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue): JNIChar; cdecl;

    CallNonvirtualShortMethod: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID): JNIShort; cdecl;
    CallNonvirtualShortMethodV: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list): JNIShort; cdecl;
    CallNonvirtualShortMethodA: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue): JNIShort; cdecl;

    CallNonvirtualIntMethod: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID): JNIInt; cdecl;
    CallNonvirtualIntMethodV: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list): JNIInt; cdecl;
    CallNonvirtualIntMethodA: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue): JNIInt; cdecl;

    CallNonvirtualLongMethod: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID): JNILong; cdecl;
    CallNonvirtualLongMethodV: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list): JNILong; cdecl;
    CallNonvirtualLongMethodA: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue): JNILong; cdecl;

    CallNonvirtualFloatMethod: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID): JNIFloat; cdecl;
    CallNonvirtualFloatMethodV: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list): JNIFloat; cdecl;
    CallNonvirtualFloatMethodA: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue): JNIFloat; cdecl;

    CallNonvirtualDoubleMethod: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID): JNIDouble; cdecl;
    CallNonvirtualDoubleMethodV: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list): JNIDouble; cdecl;
    CallNonvirtualDoubleMethodA: function(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue): JNIDouble; cdecl;

    CallNonvirtualVoidMethod: procedure(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID); cdecl;
    CallNonvirtualVoidMethodV: procedure(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list); cdecl;
    CallNonvirtualVoidMethodA: procedure(Env: PJNIEnv; Obj: JNIObject; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue); cdecl;

    GetFieldID: function(Env: PJNIEnv; AClass: JNIClass; const Name: MarshaledAString; const Sig: MarshaledAString): JNIFieldID; cdecl;

    GetObjectField: function(Env: PJNIEnv; Obj: JNIObject; FieldID: JNIFieldID): JNIObject; cdecl;
    GetBooleanField: function(Env: PJNIEnv; Obj: JNIObject; FieldID: JNIFieldID): JNIBoolean; cdecl;
    GetByteField: function(Env: PJNIEnv; Obj: JNIObject; FieldID: JNIFieldID): JNIByte; cdecl;
    GetCharField: function(Env: PJNIEnv; Obj: JNIObject; FieldID: JNIFieldID): JNIChar; cdecl;
    GetShortField: function(Env: PJNIEnv; Obj: JNIObject; FieldID: JNIFieldID): JNIShort; cdecl;
    GetIntField: function(Env: PJNIEnv; Obj: JNIObject; FieldID: JNIFieldID): JNIInt; cdecl;
    GetLongField: function(Env: PJNIEnv; Obj: JNIObject; FieldID: JNIFieldID): JNILong; cdecl;
    GetFloatField: function(Env: PJNIEnv; Obj: JNIObject; FieldID: JNIFieldID): JNIFloat; cdecl;
    GetDoubleField: function(Env: PJNIEnv; Obj: JNIObject; FieldID: JNIFieldID): JNIDouble; cdecl;

    SetObjectField: procedure(Env: PJNIEnv; Obj: JNIObject; FieldID: JNIFieldID; Val: JNIObject); cdecl;
    SetBooleanField: procedure(Env: PJNIEnv; Obj: JNIObject; FieldID: JNIFieldID; Val: JNIBoolean); cdecl;
    SetByteField: procedure(Env: PJNIEnv; Obj: JNIObject; FieldID: JNIFieldID; Val: JNIByte); cdecl;
    SetCharField: procedure(Env: PJNIEnv; Obj: JNIObject; FieldID: JNIFieldID; Val: JNIChar); cdecl;
    SetShortField: procedure(Env: PJNIEnv; Obj: JNIObject; FieldID: JNIFieldID; Val: JNIShort); cdecl;
    SetIntField: procedure(Env: PJNIEnv; Obj: JNIObject; FieldID: JNIFieldID; Val: JNIInt); cdecl;
    SetLongField: procedure(Env: PJNIEnv; Obj: JNIObject; FieldID: JNIFieldID; Val: JNILong); cdecl;
    SetFloatField: procedure(Env: PJNIEnv; Obj: JNIObject; FieldID: JNIFieldID; Val: JNIFloat); cdecl;
    SetDoubleField: procedure(Env: PJNIEnv; Obj: JNIObject; FieldID: JNIFieldID; Val: JNIDouble); cdecl;

    GetStaticMethodID: function(Env: PJNIEnv; AClass: JNIClass; const Name: MarshaledAString; const Sig: MarshaledAString): JNIMethodID; cdecl;

    CallStaticObjectMethod: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID): JNIObject; cdecl;
    CallStaticObjectMethodV: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list): JNIObject; cdecl;
    CallStaticObjectMethodA: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue): JNIObject; cdecl;

    CallStaticBooleanMethod: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID): JNIBoolean; cdecl;
    CallStaticBooleanMethodV: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list): JNIBoolean; cdecl;
    CallStaticBooleanMethodA: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue): JNIBoolean; cdecl;

    CallStaticByteMethod: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID): JNIByte; cdecl;
    CallStaticByteMethodV: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list): JNIByte; cdecl;
    CallStaticByteMethodA: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue): JNIByte; cdecl;

    CallStaticCharMethod: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID): JNIChar; cdecl;
    CallStaticCharMethodV: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list): JNIChar; cdecl;
    CallStaticCharMethodA: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue): JNIChar; cdecl;

    CallStaticShortMethod: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID): JNIShort; cdecl;
    CallStaticShortMethodV: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list): JNIShort; cdecl;
    CallStaticShortMethodA: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue): JNIShort; cdecl;

    CallStaticIntMethod: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID): JNIInt; cdecl;
    CallStaticIntMethodV: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list): JNIInt; cdecl;
    CallStaticIntMethodA: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue): JNIInt; cdecl;

    CallStaticLongMethod: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID): JNILong; cdecl;
    CallStaticLongMethodV: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list): JNILong; cdecl;
    CallStaticLongMethodA: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue): JNILong; cdecl;

    CallStaticFloatMethod: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID): JNIFloat; cdecl;
    CallStaticFloatMethodV: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list): JNIFloat; cdecl;
    CallStaticFloatMethodA: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue): JNIFloat; cdecl;

    CallStaticDoubleMethod: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID): JNIDouble; cdecl;
    CallStaticDoubleMethodV: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list): JNIDouble; cdecl;
    CallStaticDoubleMethodA: function(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue): JNIDouble; cdecl;

    CallStaticVoidMethod: procedure(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID); cdecl;
    CallStaticVoidMethodV: procedure(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: va_list); cdecl;
    CallStaticVoidMethodA: procedure(Env: PJNIEnv; AClass: JNIClass; MethodID: JNIMethodID; Args: PJNIValue); cdecl;

    GetStaticFieldID: function(Env: PJNIEnv; AClass: JNIClass; const Name: MarshaledAString; const Sig: MarshaledAString): JNIFieldID; cdecl;
    GetStaticObjectField: function(Env: PJNIEnv; AClass: JNIClass; FieldID: JNIFieldID): JNIObject; cdecl;
    GetStaticBooleanField: function(Env: PJNIEnv; AClass: JNIClass; FieldID: JNIFieldID): JNIBoolean; cdecl;
    GetStaticByteField: function(Env: PJNIEnv; AClass: JNIClass; FieldID: JNIFieldID): JNIByte; cdecl;
    GetStaticCharField: function(Env: PJNIEnv; AClass: JNIClass; FieldID: JNIFieldID): JNIChar; cdecl;
    GetStaticShortField: function(Env: PJNIEnv; AClass: JNIClass; FieldID: JNIFieldID): JNIShort; cdecl;
    GetStaticIntField: function(Env: PJNIEnv; AClass: JNIClass; FieldID: JNIFieldID): JNIInt; cdecl;
    GetStaticLongField: function(Env: PJNIEnv; AClass: JNIClass; FieldID: JNIFieldID): JNILong; cdecl;
    GetStaticFloatField: function(Env: PJNIEnv; AClass: JNIClass; FieldID: JNIFieldID): JNIFloat; cdecl;
    GetStaticDoubleField: function(Env: PJNIEnv; AClass: JNIClass; FieldID: JNIFieldID): JNIDouble; cdecl;

    SetStaticObjectField: procedure(Env: PJNIEnv; AClass: JNIClass; FieldID: JNIFieldID; Val: JNIObject); cdecl;
    SetStaticBooleanField: procedure(Env: PJNIEnv; AClass: JNIClass; FieldID: JNIFieldID; Val: JNIBoolean); cdecl;
    SetStaticByteField: procedure(Env: PJNIEnv; AClass: JNIClass; FieldID: JNIFieldID; Val: JNIByte); cdecl;
    SetStaticCharField: procedure(Env: PJNIEnv; AClass: JNIClass; FieldID: JNIFieldID; Val: JNIChar); cdecl;
    SetStaticShortField: procedure(Env: PJNIEnv; AClass: JNIClass; FieldID: JNIFieldID; Val: JNIShort); cdecl;
    SetStaticIntField: procedure(Env: PJNIEnv; AClass: JNIClass; FieldID: JNIFieldID; Val: JNIInt); cdecl;
    SetStaticLongField: procedure(Env: PJNIEnv; AClass: JNIClass; FieldID: JNIFieldID; Val: JNILong); cdecl;
    SetStaticFloatField: procedure(Env: PJNIEnv; AClass: JNIClass; FieldID: JNIFieldID; Val: JNIFloat); cdecl;
    SetStaticDoubleField: procedure(Env: PJNIEnv; AClass: JNIClass; FieldID: JNIFieldID; Val: JNIDouble); cdecl;

    NewString: function(Env: PJNIEnv; const Unicode: PJNIChar; Len: JNISize): JNIString; cdecl;
    GetStringLength: function(Env: PJNIEnv; Str: JNIString): JNISize; cdecl;
    GetStringChars: function(Env: PJNIEnv; Str: JNIString; IsCopy: PJNIBoolean): PJNIChar; cdecl;
    ReleaseStringChars: procedure(Env: PJNIEnv; Str: JNIString; const Chars: PJNIChar); cdecl;

    NewStringUTF: function(Env: PJNIEnv; const UTF: MarshaledAString): JNIString; cdecl;
    GetStringUTFLength: function(Env: PJNIEnv; Str: JNIString): JNISize; cdecl;
    GetStringUTFChars: function(Env: PJNIEnv; Str: JNIString; IsCopy: PJNIBoolean): MarshaledAString; cdecl;
    ReleaseStringUTFChars: procedure(Env: PJNIEnv; Str: JNIString; const Chars: MarshaledAString); cdecl;

    GetArrayLength: function(Env: PJNIEnv; AArray: JNIArray): JNISize; cdecl;

    NewObjectArray: function(Env: PJNIEnv; Len: JNISize; AClass: JNIClass; Init: JNIObject): JNIObjectArray; cdecl;
    GetObjectArrayElement: function(Env: PJNIEnv; AArray: JNIObjectArray; Index: JNISize): JNIObject; cdecl;
    SetObjectArrayElement: procedure(Env: PJNIEnv; AArray: JNIObjectArray; Index: JNISize; Val: JNIObject); cdecl;

    NewBooleanArray: function(Env: PJNIEnv; Len: JNISize): JNIBooleanArray; cdecl;
    NewByteArray: function(Env: PJNIEnv; Len: JNISize): JNIByteArray; cdecl;
    NewCharArray: function(Env: PJNIEnv; Len: JNISize): JNICharArray; cdecl;
    NewShortArray: function(Env: PJNIEnv; Len: JNISize): JNIShortArray; cdecl;
    NewIntArray: function(Env: PJNIEnv; Len: JNISize): JNIIntArray; cdecl;
    NewLongArray: function(Env: PJNIEnv; Len: JNISize): JNILongArray; cdecl;
    NewFloatArray: function(Env: PJNIEnv; Len: JNISize): JNIFloatArray; cdecl;
    NewDoubleArray: function(Env: PJNIEnv; Len: JNISize): JNIDoubleArray; cdecl;

    GetBooleanArrayElements: function(Env: PJNIEnv; AArray: JNIBooleanArray; IsCopy: PJNIBoolean): PJNIBoolean; cdecl;
    GetByteArrayElements: function(Env: PJNIEnv; AArray: JNIByteArray; IsCopy: PJNIBoolean): PJNIByte; cdecl;
    GetCharArrayElements: function(Env: PJNIEnv; AArray: JNICharArray; IsCopy: PJNIBoolean): PJNIChar; cdecl;
    GetShortArrayElements: function(Env: PJNIEnv; AArray: JNIShortArray; IsCopy: PJNIBoolean): PJNIShort; cdecl;
    GetIntArrayElements: function(Env: PJNIEnv; AArray: JNIIntArray; IsCopy: PJNIBoolean): PJNIInt; cdecl;
    GetLongArrayElements: function(Env: PJNIEnv; AArray: JNILongArray; IsCopy: PJNIBoolean): PJNILong; cdecl;
    GetFloatArrayElements: function(Env: PJNIEnv; AArray: JNIFloatArray; IsCopy: PJNIBoolean): PJNIFloat; cdecl;
    GetDoubleArrayElements: function(Env: PJNIEnv; AArray: JNIDoubleArray; IsCopy: PJNIBoolean): PJNIDouble; cdecl;

    ReleaseBooleanArrayElements: procedure(Env: PJNIEnv; AArray: JNIBooleanArray; Elems: PJNIBoolean; Mode: JNIInt); cdecl;
    ReleaseByteArrayElements: procedure(Env: PJNIEnv; AArray: JNIByteArray; Elems: PJNIByte; Mode: JNIInt); cdecl;
    ReleaseCharArrayElements: procedure(Env: PJNIEnv; AArray: JNICharArray; Elems: PJNIChar; Mode: JNIInt); cdecl;
    ReleaseShortArrayElements: procedure(Env: PJNIEnv; AArray: JNIShortArray; Elems: PJNIShort; Mode: JNIInt); cdecl;
    ReleaseIntArrayElements: procedure(Env: PJNIEnv; AArray: JNIIntArray; Elems: PJNIInt; Mode: JNIInt); cdecl;
    ReleaseLongArrayElements: procedure(Env: PJNIEnv; AArray: JNILongArray; Elems: PJNILong; Mode: JNIInt); cdecl;
    ReleaseFloatArrayElements: procedure(Env: PJNIEnv; AArray: JNIFloatArray; Elems: PJNIFloat; Mode: JNIInt); cdecl;
    ReleaseDoubleArrayElements: procedure(Env: PJNIEnv; AArray: JNIDoubleArray; Elems: PJNIDouble; Mode: JNIInt); cdecl;

    GetBooleanArrayRegion: procedure(Env: PJNIEnv; AArray: JNIBooleanArray; Start: JNISize; Len: JNISize; Buf: PJNIBoolean); cdecl;
    GetByteArrayRegion: procedure(Env: PJNIEnv; AArray: JNIByteArray; Start: JNISize; Len: JNISize; Buf: PJNIByte); cdecl;
    GetCharArrayRegion: procedure(Env: PJNIEnv; AArray: JNICharArray; Start: JNISize; Len: JNISize; Buf: PJNIChar); cdecl;
    GetShortArrayRegion: procedure(Env: PJNIEnv; AArray: JNIShortArray; Start: JNISize; Len: JNISize; Buf: PJNIShort); cdecl;
    GetIntArrayRegion: procedure(Env: PJNIEnv; AArray: JNIIntArray; Start: JNISize; Len: JNISize; Buf: PJNIInt); cdecl;
    GetLongArrayRegion: procedure(Env: PJNIEnv; AArray: JNILongArray; Start: JNISize; Len: JNISize; Buf: PJNILong); cdecl;
    GetFloatArrayRegion: procedure(Env: PJNIEnv; AArray: JNIFloatArray; Start: JNISize; Len: JNISize; Buf: PJNIFloat); cdecl;
    GetDoubleArrayRegion: procedure(Env: PJNIEnv; AArray: JNIDoubleArray; Start: JNISize; Len: JNISize; Buf: PJNIDouble); cdecl;

    SetBooleanArrayRegion: procedure(Env: PJNIEnv; AArray: JNIBooleanArray; Start: JNISize; Len: JNISize; Buf: PJNIBoolean); cdecl;
    SetByteArrayRegion: procedure(Env: PJNIEnv; AArray: JNIByteArray; Start: JNISize; Len: JNISize; Buf: PJNIByte); cdecl;
    SetCharArrayRegion: procedure(Env: PJNIEnv; AArray: JNICharArray; Start: JNISize; Len: JNISize; Buf: PJNIChar); cdecl;
    SetShortArrayRegion: procedure(Env: PJNIEnv; AArray: JNIShortArray; Start: JNISize; Len: JNISize; Buf: PJNIShort); cdecl;
    SetIntArrayRegion: procedure(Env: PJNIEnv; AArray: JNIIntArray; Start: JNISize; Len: JNISize; Buf: PJNIInt); cdecl;
    SetLongArrayRegion: procedure(Env: PJNIEnv; AArray: JNILongArray; Start: JNISize; Len: JNISize; Buf: PJNILong); cdecl;
    SetFloatArrayRegion: procedure(Env: PJNIEnv; AArray: JNIFloatArray; Start: JNISize; Len: JNISize; Buf: PJNIFloat); cdecl;
    SetDoubleArrayRegion: procedure(Env: PJNIEnv; AArray: JNIDoubleArray; Start: JNISize; Len: JNISize; Buf: PJNIDouble); cdecl;

    RegisterNatives: function(Env: PJNIEnv; AClass: JNIClass; const Methods: PJNINativeMethod; NMethods: JNIInt): JNIInt; cdecl;
    UnregisterNatives: function(Env: PJNIEnv; AClass: JNIClass): JNIInt; cdecl;

    MonitorEnter: function(Env: PJNIEnv; Obj: JNIObject): JNIInt; cdecl;
    MonitorExit: function(Env: PJNIEnv; Obj: JNIObject): JNIInt; cdecl;

    GetJavaVM: function(Env: PJNIEnv; VM: PPJavaVM): JNIInt; cdecl;

    // String Operations
    GetStringRegion: procedure(Env: PJNIEnv; Str: JNIString; Start: JNISize; Len: JNISize; Buf: PJNIChar); cdecl;
    GetStringUTFRegion: procedure(Env: PJNIEnv; Str: JNIString; Start: JNISize; Len: JNISize; Buf: MarshaledAString); cdecl;

    // Array Operations
    GetPrimitiveArrayCritical: function(Env: PJNIEnv; AArray: JNIArray; IsCopy: PJNIBoolean): Pointer; cdecl;
    ReleasePrimitiveArrayCritical: procedure(Env: PJNIEnv; AArray: JNIArray; CArray: Pointer; Mode: JNIInt); cdecl;

    // String Operations
    GetStringCritical: function(Env: PJNIEnv; Str: JNIString; IsCopy: PJNIBoolean): PJNIChar; cdecl;
    ReleaseStringCritical: procedure(Env: PJNIEnv; Str: JNIString; CString: PJNIChar); cdecl;

    // Weak Global References
    NewWeakGlobalRef: function(Env: PJNIEnv; Obj: JNIObject): JNIWeak; cdecl;
    DeleteWeakGlobalRef: procedure(Env: PJNIEnv; Ref: JNIWeak); cdecl;

    // Exceptions
    ExceptionCheck: function(Env: PJNIEnv): JNIBoolean; cdecl;

    // J2SDK1_4
   NewDirectByteBuffer: function(Env: PJNIEnv; Address: Pointer; Capacity: JNILong): JNIObject; cdecl;
   GetDirectBufferAddress: function(Env: PJNIEnv; Buf: JNIObject): Pointer; cdecl;
   GetDirectBufferCapacity: function(Env: PJNIEnv; Buf: JNIObject): JNILong; cdecl;

    // J2SDK1_6
   GetObjectRefType: function(Env: PJNIEnv; AObject: JNIObject): JNIObjectRefType; cdecl;
  end;
  {$EXTERNALSYM JNINativeInterface}


  JNIInvokeInterface = packed record
    reserved0: Pointer;
    reserved1: Pointer;
    reserved2: Pointer;

    DestroyJavaVM: function(PVM: PJavaVM): JNIInt; cdecl;
    AttachCurrentThread: function(PVM: PJavaVM; PEnv: PPJNIEnv; Args: Pointer): JNIInt; cdecl;
    DetachCurrentThread: function(PVM: PJavaVM): JNIInt; cdecl;
    GetEnv: function(PVM: PJavaVM; PEnv: PPJNIEnv; Version: JNIInt): JNIInt; cdecl;
    AttachCurrentThreadAsDaemon: function(PVM: PJavaVM; PEnv: PPJNIEnv; Args: PJavaVMAttachArgs): JNIInt; cdecl;
  end;
  {$EXTERNALSYM JNIInvokeInterface}

  // Defined by native libraries.
  TJNI_OnLoad = function(PVM: PJavaVM; Reserved: Pointer): JNIInt; cdecl;
  TJNI_OnUnload = procedure(PVM: PJavaVM; Reserved: Pointer); cdecl;


function JNIStringToString(Env: PJNIEnv; JStr: JNIString): string;
function StringToJNIString(Env: PJNIEnv; const Str: string): JNIString;

function ArgsToJNIValues(const Args: array of const): TJNIValueArray;
procedure HandleJNIException(Env: PJNIEnv);

var
  DoRaiseJNIException: procedure(const JNIExceptionClassName: string; const Msg: string);

implementation

uses
  Posix.Pthread,
{$IFDEF DEBUGUTILS}
  Androidapi.Log,
{$ENDIF}
  Posix.SysTypes;

var
  EmptyJNIString: array of Char;

{**************************************}
{**************************************}
{** Static helper functions          **}
{**************************************}
{**************************************}

{ Wrap native exception to java.lang.Exception }
procedure JNI_ThrowException(Env: PJNIEnv; const MsgException: string);
var
  jc: JNIObject;
  Ptr: TPtrWrapper;
begin
  Ptr := TMarshal.AllocStringAsUtf8(MsgException);
  jc := Env^.FindClass(Env, 'java/lang/Exception');
  Env^.ThrowNew(Env, jc, Ptr.ToPointer);
  TMarshal.FreeMem(Ptr);
end;

{ Convert JavaJNIString to string }
function JNIStringToString(Env: PJNIEnv; JStr: JNIString): string;
var
  Chars: PJNIChar;
begin
  Result := '';
  if (JStr = nil) then Exit;

  Chars := nil;

  try
    Chars := Env^.GetStringChars(Env, JStr, nil);
    HandleJNIException(Env);
    SetString(Result, PWideChar(Chars), Env^.GetStringLength(Env, JStr));
  finally
    if Chars <> nil then Env^.ReleaseStringChars(Env, JStr, Chars);
  end;
end;

{ Convert string to JavaJNIString }
{ allows conversion without TJNIEnv instance }
function StringToJNIString(Env: PJNIEnv; const Str: string): JNIString;
var
  Len: Integer;
begin
  Len := Length(Str);
  if Len > 0 then
    Result := Env^.NewString(Env, PJNIChar(@Str[0]), Len)
  else
    Result := Env^.NewString(Env, PJNIChar(@EmptyJNIString[0]), 0);
end;

{ Convert byte array to JNIByteArray }
function JNI_BytesToJNIByteArray(Env: PJNIEnv; const Bytes: TByteArray): JNIByteArray;
var
  len: Cardinal;
  byteArray: JNIByteArray;
begin
  if bytes = nil then
  begin
    Result := nil;
    Exit;
  end;

  len := High(Bytes)+1;
  byteArray := Env^.NewByteArray(Env, Len);
  Env^.SetByteArrayRegion(Env, byteArray, 0, len, @Bytes[0]);
  Result := byteArray;
end;

{ Convert integer array to JNIIntArray }
function JNI_IntegersToJNIIntArray(Env: PJNIEnv; const arr: TIntegerArray): JNIIntArray;
var
  len: Cardinal;
  intArray: JNIIntArray;
begin
  if arr = nil then
  begin
    Result := nil;
    Exit;
  end;

  len := High(arr)+1;
  intArray := Env^.NewIntArray(Env, Len);
  Env^.SetIntArrayRegion(Env, intArray, 0, len, @arr[0]);
  Result := intArray;
end;

{
  This function is useful to convert from Delphi basic types
  to JNI basic types.

  Notice that Double types are not supporte because TVarRec doesn't
  difference between Single and Double. So we decided to
  convert vtExtended to JNIFloat because is the most common use in
  (Android) Java API. If you need to use Double parameters
  you must construct the JNIValue array by hand (not using this
  function).
}
function ArgsToJNIValues(const Args: array of const): TJNIValueArray;
var
  I: Integer;
begin
  SetLength(Result, Length(Args));
  for I := 0 to High(Args) do
    case Args[I].VType of
      vtInteger:
        Result[I].i := JNIInt(Args[I].VInteger);
      vtBoolean:
        Result[I].z := JNIBoolean(Args[I].VBoolean);
      vtWideChar:
        Result[I].c := JNIChar(Args[I].VWideChar);
      vtInt64:
        Result[I].j := JNILong(Args[I].VInt64^);
      vtPointer, vtObject:
        Result[I].l := JNIObject(Args[I].VObject);
      vtExtended:
        Result[I].f := Args[I].VExtended^;
    end;
end;

var
  FExceptionMutex: pthread_mutex_t;

procedure HandleJNIException(Env: PJNIEnv);
var
  Excpt: JNIThrowable;
  Clazz, JavaClazz: JNIClass;
  MethodID: JNIMethodID;
  StacktraceJString: JNIString;
  Chars: PJNIChar;
  StrException: string;
  JNIExceptionClassName: string;
  JNIClassName: JNIString;
begin
  if Env = nil then Exit;

  if Env^.ExceptionCheck(Env) = 1 then
  begin
    pthread_mutex_lock(FExceptionMutex);
{$IFDEF DEBUGUTILS}
    LOGE('HandleJNIException: A JNI exception occurred.');
{$ENDIF}
    Excpt := Env^.ExceptionOccurred(Env);
    Env^.ExceptionDescribe(Env);
    Env^.ExceptionClear(Env);

    if Excpt <> nil then
    begin
      Clazz := nil;
      JavaClazz := nil;
      StacktraceJString := nil;
      JNIClassName := nil;
      try
        Clazz := Env^.GetObjectClass(Env, Excpt);
        if Env^.ExceptionCheck(Env) = 1 then
        begin
          Env^.ExceptionDescribe(Env);
          Env^.ExceptionClear(Env);
{$IFDEF DEBUGUTILS}
          LOGE('HandleJNIException: Error getting object class for exception.');
{$ENDIF}
          Exit;
        end;

        MethodID := Env^.GetMethodID(Env, Clazz, 'toString', '()Ljava/lang/String;');
        if Env^.ExceptionCheck(Env) = 1 then
        begin
          Env^.ExceptionDescribe(Env);
          Env^.ExceptionClear(Env);
{$IFDEF DEBUGUTILS}
          LOGE('HandleJNIException: Error getting method ID for toString().');
{$ENDIF}
          Exit;
        end;

        StacktraceJString := Env^.CallObjectMethod(Env, Excpt, MethodID);
        if Env^.ExceptionCheck(Env) = 1 then
        begin
          Env^.ExceptionDescribe(Env);
          Env^.ExceptionClear(Env);
{$IFDEF DEBUGUTILS}
          LOGE('HandleJNIException: Error calling toString() on exception.');
{$ENDIF}
          Exit;
        end;

        StrException := '';
        Chars := Env^.GetStringChars(Env, StacktraceJString, nil);
        if Chars <> nil then
        begin
          SetString(StrException, PWideChar(Chars), Env^.GetStringLength(Env, StacktraceJString));
          Env^.ReleaseStringChars(Env, StacktraceJString, Chars);
        end;

        JavaClazz := Env^.FindClass(Env, 'java/lang/Class');
        if Env^.ExceptionCheck(Env) = 1 then
        begin
          Env^.ExceptionDescribe(Env);
          Env^.ExceptionClear(Env);
{$IFDEF DEBUGUTILS}
          LOGE('HandleJNIException: Error getting java/lang/Class class for exception.');
{$ENDIF}
          Exit;
        end;

        MethodID := Env^.GetMethodID(Env, JavaClazz, 'toString', '()Ljava/lang/String;');
        if Env^.ExceptionCheck(Env) = 1 then
        begin
          Env^.ExceptionDescribe(Env);
          Env^.ExceptionClear(Env);
{$IFDEF DEBUGUTILS}
          LOGE('HandleJNIException: Error getting method ID for toString().');
{$ENDIF}
          Exit;
        end;

        JNIClassName := Env^.CallObjectMethod(Env, Clazz, MethodID);
        if Env^.ExceptionCheck(Env) = 1 then
        begin
          Env^.ExceptionDescribe(Env);
          Env^.ExceptionClear(Env);
{$IFDEF DEBUGUTILS}
          LOGE('HandleJNIException: Error calling toString() on exception.');
{$ENDIF}
          Exit;
        end;

        JNIExceptionClassName := '';
        Chars := Env^.GetStringChars(Env, JNIClassName, nil);
        if Chars <> nil then
        begin
          SetString(JNIExceptionClassName, PWideChar(Chars), Env^.GetStringLength(Env, JNIClassName));
          Env^.ReleaseStringChars(Env, JNIClassName, Chars);
        end;

{$IFDEF DEBUGUTILS}
        LOGE(MarshaledAString(Utf8Encode('HandleJNIException: ' + StrException)));
{$ENDIF}
      finally
        if Excpt <> nil then
          Env^.DeleteLocalRef(Env, Excpt);
        if Clazz <> nil then
          Env^.DeleteLocalRef(Env, Clazz);
        if JavaClazz <> nil then
          Env^.DeleteLocalRef(Env, JavaClazz);
        if StacktraceJString <> nil then
          Env^.DeleteLocalRef(Env, StacktraceJString);
        if JNIClassName <> nil then
          Env^.DeleteLocalRef(Env, JNIClassName);

        pthread_mutex_unlock(FExceptionMutex);
      end;
      if Assigned(DoRaiseJNIException) then
        DoRaiseJNIException(JNIExceptionClassName, StrException);
    end
    else
    begin
      pthread_mutex_unlock(FExceptionMutex);
{$IFDEF DEBUGUTILS}
      LOGE(MarshaledAString(Utf8Encode('HandleJNIException: The exception is nil.')));
{$ENDIF}
    end;
  end;
end;

initialization
  SetLength(EmptyJNIString, 1);
  EmptyJNIString[0] := #0;
  pthread_mutex_init(FExceptionMutex, nil);

finalization
  pthread_mutex_destroy(FExceptionMutex);

end.
