{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNIMarshal;

interface

{.$DEFINE DEBUGUTILS}

uses
  System.TypInfo;

type
  ///
  ///  Java methods are invoked by two separate mechanisms, depending
  ///  on their return type.
  TRetKind = (
    ///  Return native type. (Integer, Boolean, etc)
    rkBoolean,
    rkByte,
    rkChar,
    rkShort,
    rkInt,
    rkLong,
    rkFloat,
    rkDouble,
    rkVoid,
    ///  Function returning an Java object  (JString, JArray, ...)
    rkObject,
    rkConstructor,
    rkInstance);


  ///
  ///  Java methods are invoked depending on instance type
  TMethodKind = (
    mkObjectMethod,
    mkClassMethod,
    mkPropertySetMethod,
    mkPropertyGetMethod,
    mkClassPropertySetMethod,
    mkClassPropertyGetMethod);


 TMarshalOpKind = (
    ///
    ///  Copy data from source to destination.  Size is specified in the operation.
    moCopy,

    ///  Get the JNIObject from Delphi Object
    moJNIObject,
    moJNIArray
                   );

  TMarshalOp = record
    ///
    ///  Size, in bytes, of data to copy.
    Size: ShortInt;
    ///
    ///  The kind of the operation.
    Kind: TMarshalOpKind;
  end;

  ///
  ///  To invoke a JNI method from Pascal, we need some precomputed
  ///  information.  This record holds the information that is not specific
  ///  to the parameters, or that controls how the JNI
  ///  must be invoked.  The marshaling data that this record refers to
  ///  includes a considerable amount of the additional context required
  ///  to make the invocation possible.
  JNIMethodInvokeData = record
    ///
    ///  Size, in bytes, of data required by Args (Length(Params) * 8).
    Size: Integer;
    ///
    ///  Parameter marshaler used to prepare the Delphi arguments to JNI.
    Params: TArray<TMarshalOp>;
    ///
    ///  The method to call can be a static method or a class method or a setter/getter from a property.
    MethodType: TMethodKind;
    ///
    ///  The instance required to do the call (JNIClass or JNIObject).
    Instance: Pointer;
    ///
    ///  The return type of the method or the type of the setter if we are calling to a property.
    RetKind: TRetKind;
    ///
    ///  If the return type is rkIRET, then this field will by the type
    ///  we have to 'convert' to.
    JavaType: PTypeInfo;
    ///
    ///  The pointer that identifies the method or field we are calling. Can be JMethodID or JFieldID, depends on MethodType
    MethodID: Pointer;
    RetClsID: Pointer;
  end;
  PJNIMethodInvokeData = ^JNIMethodInvokeData;

implementation

uses
  Androidapi.JNIBridge,
{$IFDEF DEBUGUTILS}
  System.Classes,
  System.SysUtils,
{$ENDIF}
  Androidapi.Jni,
  Androidapi.Consts;


{$IFDEF DEBUGUTILS}
procedure BinToHexStringList(B: TBytes; SL: TStringList; BytesByLine: Integer = 8; Separator: string = ' ');
var
  Dest: string;
  I: Integer;
begin
  if Assigned(SL) then
  begin
    SL.Clear;
    for I := 0 to Length(B) - 1 do
    begin
      Dest := Dest + IntTohex(B[I], 2);
      if ((I + 1) mod BytesByLine) <> 0 then
        Dest := Dest + Separator
      else
        Dest := Dest + #13;
    end;
    SL.Text := Dest;
  end;
end;

function BinToHexString(p: Pointer; Size: Integer): string;
var
  B: TBytes;
  SL: TStringList;
begin
  Result := '';
  SetLength(B, Size);
  SL := TStringList.Create;
  try
    B := BytesOf(P, Size);
    BinToHexStringList(B, SL, 4);
    Result := SL.Text;
  finally
    Sl.Free;
  end;
end;

{$ENDIF}

procedure ExecJNI(SrcParams, DstParams, PResult: Pointer; InvokeData: PJNIMethodInvokeData); cdecl;
var
  Src: PByte;
  JArraySrc: TArray<Pointer>;
  CntJArraySrc: Integer;
  ARMRegister: Byte;
  WrappedIntf: IInterface;
  WrappedObj: TObject;
  LInstance: Pointer;

  procedure SkipResultField;
  begin
    if (InvokeData.RetKind = rkObject) or (InvokeData.RetKind = rkConstructor) or (InvokeData.RetKind = rkInstance) then
    begin
      // R0 : Result pointer. Skip it
      Inc(ARMRegister);
      Inc(Src, SizeOf(Pointer));
    end;
  end;

  procedure CopyObjectInstance;
  begin
    // Src and ARMRegister points next of user parameter
    // Get Object instance from top of user parameter.
    LInstance := Pointer(PNativeInt(Src - SizeOf(Pointer))^);
    LInstance := (IJava(LInstance) as ILocalObject).GetObjectID;
  end;

  procedure ProcessArrays;
  var
    I: Integer;
    Arr: TJavaBasicArray;
  begin
    for I := 0 to CntJArraySrc - 1 do
    begin
      if Pointer(JArraySrc[I]^) <> nil then
      begin
        Arr := TJavaBasicArray(PPointer(JArraySrc[I])^);
        { if we returned FElements need to copy back changes before using the array}
        if (Arr <> nil) and Arr.ElementsAccessed and Arr.IsCopy then
          Arr.RefreshValues;
      end;
    end;

  end;

  procedure ProccessParameters;
  var
    I: Integer;
    Param: TMarshalOp;
    Dst: PByte;
  begin
    Dst := DstParams;
    PInt64(Dst)^ := 0;
    if Length(InvokeData.Params) <= 0 then 
      Exit;
    SetLength(JArraySrc, 20);
    for I := 0 to Length(InvokeData.Params) - 1 do
    begin
      Param := InvokeData.Params[I];
      case Param.Kind of
        moJNIObject:
        begin
          XFormInterface(Src, Dst);
          Inc(Src, SizeOf(Pointer));
          Inc(ARMRegister);
        end;

        moJNIArray:
        begin
          JArraySrc[CntJArraySrc] := Src;
          Inc(CntJArraySrc);
          XFormClass(Src, Dst);
          Inc(Src, SizeOf(Pointer));
          Inc(ARMRegister);
        end;

        moCopy:
        begin
          case Param.Size of
            1, 2, 4:
            begin
              PInt64(Dst)^ := Integer(PInteger(Src)^);
              Inc(Src, SizeOf(Pointer));
              Inc(ARMRegister);
            end;

            8:
            begin
              if (ARMRegister = 1) or (ARMRegister = 3) then
              begin
                Inc(ARMRegister);
                Inc(Src, SizeOf(Pointer));
              end;

              PInt64(Dst)^ := Int64(PInt64(Src)^);
              Inc(Src, SizeOf(Pointer) * 2);
              Inc(ARMRegister, 2);
            end;
          end;
        end;
      end;
      Inc(Dst, 8);
    end;
  end;

  procedure ProcessResult;
  var
    Res: Pointer;
  begin
    if InvokeData.MethodType <> mkPropertySetMethod then
    begin
      case InvokeData.RetKind of
        rkObject, rkConstructor:
          begin
            Res := Pointer(PNativeInt((PByte(SrcParams) - SizeOf(Pointer)))^); // r0 -> destination var
            IInterface(Res^) := WrappedIntf;
          end;
        rkInstance:
          begin
            Res := Pointer(PNativeInt((PByte(SrcParams) - SizeOf(Pointer)))^); // r0 -> destination var
            TObject(Res^) := WrappedObj;
          end;
      end;
    end;
  end;

var
  AJNIObject: JNIObject;
  JNIEnv: PJniEnv;
begin
  if InvokeData.MethodID = nil then
    raise EJNIFatal.CreateRes(@SJNIUnknownMethod);
  CntJArraySrc := 0;
  JNIEnv := TJNIResolver.GetJNIEnv;
  Src := SrcParams;
  ARMRegister := 1;
  PInt64(PResult)^ := 0; // Initialize result buffer
  case InvokeData.MethodType of
    mkObjectMethod:
      begin
        SkipResultField;
        CopyObjectInstance;
        ProccessParameters;
        case InvokeData.RetKind of
          rkBoolean:
            PByte(PResult)^ := JNIEnv^.CallBooleanMethodA(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, DstParams);
          rkByte:
            PByte(PResult)^ := JNIEnv^.CallByteMethodA(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, DstParams);
          rkChar:
            PChar(PResult)^ := JNIEnv^.CallCharMethodA(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, DstParams);
          rkShort:
            PSmallInt(PResult)^ := JNIEnv^.CallShortMethodA(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, DstParams);
          rkInt:
            PInteger(PResult)^ := JNIEnv^.CallIntMethodA(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, DstParams);
          rkLong:
            PInt64(PResult)^ := JNIEnv^.CallLongMethodA(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, DstParams);
          rkFloat:
            PSingle(PResult)^ := JNIEnv^.CallFloatMethodA(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, DstParams);
          rkDouble:
            PDouble(PResult)^ := JNIEnv^.CallDoubleMethodA(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, DstParams);
          rkVoid:
            JNIEnv^.CallVoidMethodA(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, DstParams);
          rkObject:
            begin
              AJNIObject := JNIEnv^.CallObjectMethodA(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, DstParams);
              HandleJNIException(JNIEnv);
              WrapJNIReturn(AJNIObject, InvokeData.RetClsID, InvokeData.JavaType, WrappedIntf);
            end;
          rkInstance:
            begin
              AJNIObject := JNIEnv^.CallObjectMethodA(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, DstParams);
              HandleJNIException(JNIEnv);
              WrappedObj := WrapJNIArray(AJNIObject, InvokeData.JavaType);
            end;
          rkConstructor:
            begin
              AJNIObject := JNIEnv^.NewObjectA(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, DstParams);
              HandleJNIException(JNIEnv);
              WrapJNIReturn(AJNIObject, InvokeData.RetClsID, InvokeData.JavaType, WrappedIntf);
            end;
        end;
      end;

    mkClassMethod:
      begin
        SkipResultField;
        //CopyObjectInstance; // No Instance
        ProccessParameters;
        case InvokeData.RetKind of
          rkBoolean:
            PByte(PResult)^ := JNIEnv^.CallStaticBooleanMethodA(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, DstParams);
          rkByte:
            PByte(PResult)^ := JNIEnv^.CallStaticByteMethodA(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, DstParams);
          rkChar:
            PChar(PResult)^ := JNIEnv^.CallStaticCharMethodA(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, DstParams);
          rkShort:
            PSmallInt(PResult)^ := JNIEnv^.CallStaticShortMethodA(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, DstParams);
          rkInt:
            PInteger(PResult)^ := JNIEnv^.CallStaticIntMethodA(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, DstParams);
          rkLong:
            PInt64(PResult)^ := JNIEnv^.CallStaticLongMethodA(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, DstParams);
          rkFloat:
            PSingle(PResult)^ := JNIEnv^.CallStaticFloatMethodA(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, DstParams);
          rkDouble:
            PDouble(PResult)^ := JNIEnv^.CallStaticDoubleMethodA(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, DstParams);
          rkVoid:
            JNIEnv^.CallStaticVoidMethodA(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, DstParams);
          rkObject:
            begin
              AJNIObject := JNIEnv^.CallStaticObjectMethodA(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, DstParams);
              HandleJNIException(JNIEnv);
              WrapJNIReturn(AJNIObject, InvokeData.RetClsID, InvokeData.JavaType, WrappedIntf);
            end;
          rkInstance:
            begin
              AJNIObject := JNIEnv^.CallStaticObjectMethodA(JNIEnv, JNIObject(InvokeData.Instance), InvokeData.MethodID, DstParams);
              HandleJNIException(JNIEnv);
              WrappedObj := WrapJNIArray(AJNIObject, InvokeData.JavaType);
            end;
          rkConstructor:
            begin
              AJNIObject := JNIEnv^.NewObjectA(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, DstParams);
              HandleJNIException(JNIEnv);
              WrapJNIReturn(AJNIObject, InvokeData.RetClsID, InvokeData.JavaType, WrappedIntf);
            end;
        end;
      end;

    mkPropertySetMethod:
      begin
        //SkipResultField;    // No return
        CopyObjectInstance;
        //ProccessParameters; // Top is a parameter
        case InvokeData.RetKind of
          rkBoolean:
            JNIEnv^.SetBooleanField(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, PJNIBoolean(Src)^);
          rkByte:
            JNIEnv^.SetByteField(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, PJNIByte(Src)^);
          rkChar:
            JNIEnv^.SetCharField(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, PJNIChar(Src)^);
          rkShort:
            JNIEnv^.SetShortField(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, PJNIShort(Src)^);
          rkInt:
            JNIEnv^.SetIntField(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, PJNIInt(Src)^);
          rkLong:
            JNIEnv^.SetLongField(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, PJNILong(Src)^);
          rkFloat:
            JNIEnv^.SetFloatField(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, PJNIFloat(Src)^);
          rkDouble:
            JNIEnv^.SetDoubleField(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, PJNIDouble(Src)^);
          rkObject:
            begin
              XFormInterface(Src, DstParams);
              JNIEnv^.SetObjectField(JNIEnv, JNIObject(LInstance), InvokeData.MethodID, PJNIObject(DstParams)^);
            end;
        end;
      end;

    mkPropertyGetMethod:
      begin
        SkipResultField;
        CopyObjectInstance;
        //ProccessParameters; // No parameter.
        case InvokeData.RetKind of
          rkBoolean:
            PByte(PResult)^ := JNIEnv^.GetBooleanField(JNIEnv, JNIObject(LInstance), InvokeData.MethodID);
          rkByte:
            PByte(PResult)^ := JNIEnv^.GetByteField(JNIEnv, JNIObject(LInstance), InvokeData.MethodID);
          rkChar:
            PChar(PResult)^ := JNIEnv^.GetCharField(JNIEnv, JNIObject(LInstance), InvokeData.MethodID);
          rkShort:
            PSmallInt(PResult)^ := JNIEnv^.GetShortField(JNIEnv, JNIObject(LInstance), InvokeData.MethodID);
          rkInt:
            PInteger(PResult)^ := JNIEnv^.GetIntField(JNIEnv, JNIObject(LInstance), InvokeData.MethodID);
          rkLong:
            PInt64(PResult)^ := JNIEnv^.GetLongField(JNIEnv, JNIObject(LInstance), InvokeData.MethodID);
          rkFloat:
            PSingle(PResult)^ := JNIEnv^.GetFloatField(JNIEnv, JNIObject(LInstance), InvokeData.MethodID);
          rkDouble:
            PDouble(PResult)^ := JNIEnv^.GetDoubleField(JNIEnv, JNIObject(LInstance), InvokeData.MethodID);
          rkObject:
            begin
              AJNIObject := JNIEnv^.GetObjectField(JNIEnv, JNIObject(LInstance), InvokeData.MethodID);
              HandleJNIException(JNIEnv);
              WrapJNIReturn(AJNIObject, InvokeData.RetClsID, InvokeData.JavaType, WrappedIntf);
            end;
          rkInstance:
            begin
              AJNIObject := JNIEnv^.GetObjectField(JNIEnv, JNIObject(LInstance), InvokeData.MethodID);
              HandleJNIException(JNIEnv);
              WrappedObj := WrapJNIArray(AJNIObject, InvokeData.JavaType);
            end;
        end;
      end;

    mkClassPropertySetMethod:
      begin
        //SkipResultField;    // No return
        //CopyObjectInstance; // No Instance
        //ProccessParameters; // Top is a parameter
        case InvokeData.RetKind of
          rkBoolean:
            JNIEnv^.SetStaticBooleanField(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, PJNIBoolean(Src)^);
          rkByte:
            JNIEnv^.SetStaticByteField(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, PJNIByte(Src)^);
          rkChar:
            JNIEnv^.SetStaticCharField(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, PJNIChar(Src)^);
          rkShort:
            JNIEnv^.SetStaticShortField(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, PJNIShort(Src)^);
          rkInt:
            JNIEnv^.SetStaticIntField(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, PJNIInt(Src)^);
          rkLong:
            JNIEnv^.SetStaticLongField(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, PJNILong(Src)^);
          rkFloat:
            JNIEnv^.SetStaticFloatField(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, PJNIFloat(Src)^);
          rkDouble:
            JNIEnv^.SetStaticDoubleField(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, PJNIDouble(Src)^);
          rkObject:
            begin
              XFormInterface(Src, DstParams);
              JNIEnv^.SetStaticObjectField(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID, PJNIObject(DstParams)^);
            end;
        end;
      end;

    mkClassPropertyGetMethod:
      begin
        //SkipResultField;    // No Instance nor parameters, no need to adjust parameter list.
        //CopyObjectInstance; // No Instance
        //ProccessParameters; // No paameter
        case InvokeData.RetKind of
          rkBoolean:
            PByte(PResult)^ := JNIEnv^.GetStaticBooleanField(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID);
          rkByte:
            PByte(PResult)^ := JNIEnv^.GetStaticByteField(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID);
          rkChar:
            PChar(PResult)^ := JNIEnv^.GetStaticCharField(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID);
          rkShort:
            PSmallInt(PResult)^ := JNIEnv^.GetStaticShortField(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID);
          rkInt:
            PInteger(PResult)^ := JNIEnv^.GetStaticIntField(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID);
          rkLong:
            PInt64(PResult)^ := JNIEnv^.GetStaticLongField(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID);
          rkFloat:
            PSingle(PResult)^ := JNIEnv^.GetStaticFloatField(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID);
          rkDouble:
            PDouble(PResult)^ := JNIEnv^.GetStaticDoubleField(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID);
          rkObject:
            begin
              AJNIObject := JNIEnv^.GetStaticObjectField(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID);
              HandleJNIException(JNIEnv);
              WrapJNIReturn(AJNIObject, InvokeData.RetClsID, InvokeData.JavaType, WrappedIntf);
            end;
          rkInstance:
            begin
              AJNIObject := JNIEnv^.GetStaticObjectField(JNIEnv, JNIClass(InvokeData.Instance), InvokeData.MethodID);
              HandleJNIException(JNIEnv);
              WrappedObj := WrapJNIArray(AJNIObject, InvokeData.JavaType);
            end;
        end;
      end;
  end;
  ProcessResult;
  HandleJNIException(JNIEnv);
  ProcessArrays;
end;

exports
  ExecJNI name 'ExecJNI';


end.
