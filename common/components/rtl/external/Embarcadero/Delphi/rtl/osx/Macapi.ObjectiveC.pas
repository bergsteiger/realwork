{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Macapi.ObjectiveC;

interface

{.$DEFINE DEBUGUTILS}

uses
  System.Rtti,
  System.Generics.Collections,
  System.SysUtils,
  System.TypInfo,
{$IFDEF DEBUGUTILS}
  System.Internal.DebugUtils,
{$ENDIF}
  System.RTLConsts,
  Macapi.OCMarshal,
  Macapi.ObjCRuntime,
  Macapi.Consts;

{$IF Defined(CPUX86) and Defined(ASSEMBLER) and not Defined(PUREPASCAL)}
  {$DEFINE X86ASM}
{$ENDIF}

const
  IID_ILocalObject_Name = '{55351304-9562-4039-BF44-AA5792DB6C30}';
  IID_ILocalObject: TGUID = IID_ILocalObject_Name;
  IID_IObjectiveC_Name = '{3E7B0A40-F6AB-4FF5-9BE0-92DCB2909899}';
  IID_IObjectiveC: TGUID = IID_IObjectiveC_Name;
  IID_IObjectiveCInstance_Name = '{B72015CE-B78D-4718-87D2-B639AA153818}';
  IID_IObjectiveCInstance: TGUID = IID_IObjectiveCInstance_Name;
  IID_IObjectiveCClass_Name = '{ADD1B823-793E-4E51-867B-A01CC83B7739}';
  IID_IObjectiveCClass: TGUID = IID_IObjectiveCClass_Name;

type
{$M+}

  ///
  ///  ObjectiveC method overloading doesn't work the same as Pascal method
  ///  overloading works.  In ObjectiveC, you add additional names to the
  ///  overloaded parameters to distinguish the methods, and the compiler
  ///  convolves those names into the overall method name.  This attribute
  ///  allows the declarer of an ObjectiveC interface in Pascal to specifically
  ///  set the method name that will be used when constructing or finding the
  ///  ObjectiveC method to invoke for a given ObjectiveC method.
  ///
  MethodNameAttribute = class(TCustomAttribute)
  private
    FMethodName: String;
  public
    property Name: String read FMethodName;
    constructor Create(Name: String);
  end;
   
  ///
  ///  All ObjectiveC objects, whether local or imports must use this interface
  ///  as the 'root' interface.  Local objects are Delphi implemented objects
  ///  that implement some ObjectiveC protocol or interface.  Imports are
  ///  ObjectiveC objects, created by the ObjectiveC runtime that have been
  ///  wrapped in dynamically created interfaces for access from Delphi.
  ///
  ///  Interfaces that describe ObjectiveC class methods must derive from
  ///  <code>IObjectiveCClass</code>.  Interfaces that describe ObjectiveC
  ///  instance methods must derive from <code>IObjectiveCInstance</code>.
  ///  Interfaces that describe ObjectiveC protocols should only derive
  ///  from <code>IObjectiveC</code>.
  IObjectiveC = interface(IInterface)
    [IID_IObjectiveC_Name]
  end;

  ///
  ///  Root interface describing ObjectiveC classes.  All classes
  ///  include the <code>alloc</code> method.  Custom allocators
  ///  may be defined by ObjectiveC class interfaces in addition to
  ///  this method.
  IObjectiveCClass = interface(IObjectiveC)
    [IID_IObjectiveCClass_Name]
    ///
    ///  The always present allocator method.  We use this to
    ///  allocate instances of ObjectiveC objects.
    function alloc: Pointer; cdecl;
  end;

  ///
  ///  Root interface describing ObjectiveC instance methods.
  ///  All instances have access to an <code>init</code> method,
  ///  typically implemented in <code>NSObject</code>.
  IObjectiveCInstance = interface(IObjectiveC)
    [IID_IObjectiveCInstance_Name]
    ///  The always present 'default' constructor.
    function init: Pointer; cdecl;
  end;
{$M-}

  ///
  ///  ObjectiveC methods are invoked by three separate mechanisms, depending
  ///  on their return type.
  TRetKind = (
    ///  Normal cdecl function return.
    rkNormal,
    ///  Cdecl Function returns a floating point value.
    rkFPRET,
    ///  Cdecl function returns a large structure (> 8 bytes) by value.
    rkSRET,
    ///  Function returning an ObjectiveC object
    rkIRET);

//  TOCVTable = class;

  ///
  ///  To invoke an ObjectiveC method from Pascal, we need some precomputed
  ///  information.  This record holds the information that is not specific
  ///  to the parameters, or that controls how the ObjectiveC runtime
  ///  must be invoked.  The marshaling data that this record refers to
  ///  includes a considerable amount of the additional context required
  ///  to make the invocation possible.
  OCMethodInvokeData = record
    ///
    ///  Parameter marshaler used to copy the Delphi arguments to ObjectiveC.
    Marshaler: TMarshaler;
    ///
    ///  The return type of the method.
    RetKind: TRetKind;

    ///
    ///  The amount of stack space required by the marshaler.  This space
    ///  will be allocated locally when we invoke the method, and the
    ///  marshaler will be invoked to copy the args to it.
    ParamSize: Integer;

    ///  If the return type is rkIRET, then this field will by the type
    ///  we have to 'convert' to.
    ObjectiveCType: PTypeInfo;

    ///  If the return type is rkIRET, then this field will by the vtable
    ///  for the wrapped object.
    /// TODO: it would be nice to cache this, but there are recursion issues.
    /// Specifically, if we try to create it while we're creating another vtable
    /// we loop, because the vtable cache doesn't get set up with partial vtables.
    /// We should come back to this to relieve performance pressure on WrapObjectiveCReturn.
//    VTable: TOCVTable;
  end;
  POCMethodInvokeData = ^OCMethodInvokeData;

  ///
  ///  Alias type to make reading this code a little easier.
  TRawVTable = TRawVirtualClass.TVTable;

  ///
  ///  ObjectiveC objects are accessed via interfaces.  This vtable object
  ///  implements a Delphi vtable that will invoke the ObjectiveC runtime
  ///  for method calls.  These vtables will be used to construct
  ///  <code>TOCImport</code> objects, which are virtual classes.
  ///
  ///  For any given ObjectiveC interface, we may have to create two types
  ///  of vtables.  One for normal references, and one for super class
  ///  references.  References to an ObjectiveC interface that is the super
  ///  type of an ObjectiveC object instance require a different method
  ///  of invocation, including different parameter lists and marshaling.
  ///
  TOCVTable = class(TRawVTable)
  private
    ///  We hold on to this because the vtable entries will be pointing
    ///  into it.
    FMethodInfoData: TArray<OCMethodInvokeData>;

    ///  See the <code>Guids</code> property.
    FGuids: TArray<TGUID>;

  protected
    ///
    ///  When we construct the virtual class using this vtable, we need
    ///  to give a list of guids that the vtable matches.  Since we are
    ///  representing ObjectiveC objects as a 'hiearchy' of interfaces,
    ///  a single vtable can safely represent a swatch of ObjectiveC
    ///  interfaces.  We need to hold all those guids to allow us to
    ///  manage casting up and down the hiearchy in Delphi code, and to
    ///  allow us to build superclass references on the fly.
    property Guids: TArray<TGUID> read FGuids;

    ///
    ///  Creates a vtable for an ObjectiveC object given the type info
    ///  of the interface.  The vtable may be for an ObjectiveC instance,
    ///  or class.
    constructor Create(P: PTypeInfo; IsSuperClass: Boolean);
  end;

  ///
  ///  Exception thrown for various failures.  Most failures are due to incorrect
  ///  type declarations, where a Delphi interface type for an ObjectiveC type
  ///  does not match.  Some are pure runtime issues.  The message and context
  ///  of the exception will provide some diagnostic information.
  EObjectiveC = class(Exception);

  ///
  ///  Fatal exception issued when something sufficiently had happens that it is
  ///  questionable about the state of the runtime.  An example would be if
  ///  an exception is raised when the ObjectiveC runtime is calling a Delphi
  ///  implementation of a protocol, and we know the exception will be propagated
  ///  back through the ObjectiveC runtime.  This will cause the ObjectiveC runtime
  ///  to be forcefully unwound by the Delphi RTL, and potentially left in an
  ///  inconsistent state.  How you chose to respond to this exception is up to you.
  EObjectiveCFatal = class(EObjectiveC);

  ///
  ///  Both import objects and local objects implement this interface.  We use it
  ///  as a common means of getting to key data when dealing with marshaling parameters.
  ILocalObject = interface(IObjectiveC)
    [IID_ILocalObject_Name]
    ///  Returns the ObjectiveC instance ID of this object.  Both local and import
    ///  objects will always have this.  In some cases, e.g. references to ObjectiveC
    ///  classes, this will actually be an ObjectiveC class id, not an instance id.
    function GetObjectID: Pointer;
  end;

  ///
  ///  The three basic ObjectiveC interface types (Class, Instance and Protocol),
  ///  all have rules that their declarations have to respect.  The runtime support
  ///  here, however, will process the declared types in a lazy fashion, constructing
  ///  marshaling interfaces to ObjectiveC only on demand for a given interface.  So
  ///  validation of all of the declarations in an interface is delayed.
  ///
  ///  In order to support user controllable validation of ObjectiveC type declarations,
  ///  we provide some validation methods that will do everything we do in a lazy
  ///  fashion, but do it under the control of a single API call.  The APIs here will
  ///  throw <code>EObjectiveC</code> exceptions if a rule is violated in the declaration
  ///  of an ObjectiveC type interface.
  ///
  ///  The rules for an ObjectiveC class interface, which represents the interface used
  ///  to call ObjectiveC class methods are:
  ///  <list>
  ///  <item>Root interface must be <code>IObjectiveCClass</code>.</item>
  ///  <item>Must have method RTTI enabled.</item>
  ///  <item>All methods must be cdecl.</item>
  ///  <item>All method parameters must have valid ObjectiveC types.</item>
  ///  </list>
  ///
  ///
  ///  The rules for an ObjectiveC instance interface, which represents the interface used
  ///  to call ObjectiveC instance methods are:
  ///  <list>
  ///  <item>Root interface must be <code>IObjectiveCInstance</code>.</item>
  ///  <item>Must have method RTTI enabled.</item>
  ///  <item>All methods must be cdecl.</item>
  ///  <item>All method parameters must have valid ObjectiveC types.</item>
  ///  </list>
  ///
  ///
  ///  The rules for an ObjectiveC class protocol, which represents the interface used
  ///  to implement ObjectiveC protocols are:
  ///  <list>
  ///  <item>Root interface must be <code>IObjectiveCProtocol</code>.</item>
  ///  <item>Must have method RTTI enabled.</item>
  ///  <item>All methods must be cdecl.</item>
  ///  <item>All method parameters must have valid ObjectiveC types.</item>
  ///  </list>
  ///
  ///
  ///  Valid ObjectiveC parameter types are: ObjectiveC instances, basic integral
  ///  types, such as Integer, floating point types, pointer types, and record types.
  ///  For pointer types, the pointer is handed to ObjectiveC unchanged.  Whether or
  ///  not the ObjectiveC function understands the data that it points to is up to
  ///  the user.  For record types, the data of the record is copied verbatim, without
  ///  any interpretation of its contents whatever.  It is up to the user to ensure
  ///  that the record contents are compatible with a given ObjectiveC API.
  ///
  TOCValidate = class
  strict private
    class procedure ValidateTypeHierarchy(P: PTypeInfo; RequiredRoot: PTypeInfo;
                                          ErrMsg: PResStringRec); static;
    class procedure ValidateMethods(P: PTypeInfo); static;
  protected
    class procedure ValidateClassHierarchy(P: PTypeInfo); static;
    class procedure ValidateInstanceHierarchy(P: PTypeInfo); static;
    class procedure ValidateProtocolHierarchy(P: PTypeInfo); static;
  public
    ///
    ///  Validates an ObjectiveC Class interface type.  Throws an <code>EObjectiveC</code>
    ///  with a detailed error message if validation fails.
    class procedure ValidateClassType(P: PTypeInfo); static;

    ///
    ///  Validates an ObjectiveC Instance interface type.  Throws an <code>EObjectiveC</code>
    ///  with a detailed error message if validation fails.
    class procedure ValidateInstanceType(P: PTypeInfo); static;

    ///
    ///  Validates an ObjectiveC Protocol interface type.  Throws an <code>EObjectiveC</code>
    ///  with a detailed error message if validation fails.
    class procedure ValidateProtocolType(P: PTypeInfo); static;
  end;

  ///
  ///  TOCImport needs to hold relatively little, because the vast bulk of
  ///  information required to invoke methods is actually referred to by
  ///  the vtable thunks themselves.  The only thing needed from the import
  ///  instances proper are the object and class ids, the latter being for
  ///  super class references.
  TOCImport = class(TRawVirtualClass, ILocalObject)
  protected
    FID: Pointer;
    FClsID: Pointer;
    FVTable: TOCVTable;
    function GetObjectID: Pointer;
  public
    ///
    ///  <param name="ID">ObjectiveC ID.  This can either be an instance or a class,
    ///  depending on which we are creating.</param>
    ///  <param name="ClsID">ObjectiveC Class ID.  This is only set to non-zero
    ///  if we are creating a wrapper for a super-class reference to the given
    ///  ID parameter.  The <code>ClsID</code> should be the ObjectiveC class of the
    ///  parent of the given <code>ID</code>.</param>
    ///  <param name="VTable">The vtable that will be used for invoking methods.
    ///  If this is a super-class reference, then it should be the appropriate
    ///  vtable.</param>
    constructor Create(ID: Pointer; ClsID: Pointer; VTable: TOCVTable);
    destructor Destroy; override;
  end;

  ///
  ///  A generic class that we use to make the declaration of ObjectiveC
  ///  object factories easier.  Most ObjectiveC objects use the default allocator
  ///  in <code>NSObject</code>.  In our model, we split the class methods
  ///  and instance methods into two interfaces.  This class blends the
  ///  two interfaces into one factory that can produce instances of ObjectiveC
  ///  objects, or provide a reference to a singleton instance representing
  ///  the ObjectiveC class.
  TOCGenericImport<C: IObjectiveCClass; T: IObjectiveCInstance> = class(TOCImport)
  strict private
    class var FInstanceVTable: TOCVtable;
    class var FClassVTable: TOCVTable;
    class var FOCClass: C;
    class function GetOCClass: C; static;
    class function GetInstanceVTable: TOCVTable;

  public
    ///  In the rare case that an ObjectiveC object has a custom allocator
    ///  (e.g. <code>NSApplication</code>, the implementation of the factory
    ///  must manually allocate instances, using the <code>Alloc</code> method
    ///  of this generic, and then call <code>Wrap</code> to wrap a virtual
    ///  class around the resulting raw ObjectiveC pointer.  This method
    ///  then returns an instance of the requested ObjectiveC interface.
    class function Wrap(P: Pointer): T;

    ///
    ///  Provides the ObjectiveC class object for this type.  You can use the
    ///  resulting interface to call ObjectiveC class methods, rather than
    ///  instance methods.
    class property OCClass: C read GetOCClass;

    ///
    ///  Creates an instance of the object.  This may raise an <code>EObjectiveC</code>
    ///  exception, in the event that we were unable to create the meta-data for
    ///  the class, or if there is an error in the ObjectiveC runtime.  Both are
    ///  usually due to errors in the type descriptions in the ObjectiveC interface
    ///  declarations.  Do not use this for instances that you want to call some
    ///  custom constructor on.  This method will call the default 'init' constructor
    ///  on the instance, which can be bad in some cases.  There are some objects that
    ///  do not like to be constructed twice (e.g. NSString).
    class function Create: T; overload;

    ///
    ///  Creates an unconstructed instance of the object.  This is pretty much
    ///  the same as <code>Create</code>, except that it doesn't call the init
    ///  method on the object created.  Use this if you are expressing a custom
    ///  constructor in your ObjectiveC stub declaration.
    class function Alloc: T; overload;

    ///
    ///  Used by custom constructors to set the internal ObjectiveC object pointer
    ///  to a new value.  The ObjectiveC model for constructors is generally for them
    ///  to be named 'init', and for them to return a pointer to an ObjectiveC instance
    ///  of the same type.  Sometimes they return themselves, sometimes not.  When we
    ///  allocate an ObjectiveC object, we get back one instance.  When we call the
    ///  constructor, we may get back a different instance.  This is in particular
    ///  the case with <code>NSString</code>, for example.  If you define a custom
    ///  constructor for an ObjectiveC import, you must remember to call this
    ///  method with the return value of the ObjectiveC constructor.
    class procedure Init(O: T; P: Pointer);
  end;

  TProtocols = array of PTypeInfo;

  ///
  ///  This is the base class for local implementations of ObjectiveC objects.  You must
  ///  derive from this base class if you want to implement an ObjectiveC protocol, or
  ///  derive from an ObjectiveC class.
  TOCLocal = class(TInterfacedObject, ILocalObject, IObjectiveC)
  private
    FObjectID: Pointer;
    FSuper: IObjectiveCInstance;

    function GetSuper: IObjectiveCInstance;
  protected
    function GetObjectID: Pointer;
    procedure UpdateObjectID(Val: Pointer);
    ///
    ///  If this returns non-nil, it provides the type info of an ObjectiveC class
    ///  interface.  That interface must be an interface that is not defined in
    ///  ObjectiveC already.  It will be used to define the class name of the
    ///  ObjectiveC class we register with the ObjectiveC runtime.  The interface
    ///  passed here <emphasis>must</emphasis> derive from <code>NSObject</code>.
    ///  Any methods defined in this interface will be added to the list of methods
    ///  that we advertise as implemented by this class.
    ///
    ///  The primary use of this method is to allow you to define a class that
    ///  derives from an existing ObjectiveC class.  If all you want to do is to
    ///  implement a protocol, then you do not need to implement this method.  Your
    ///  object will automatically end up deriving from <code>NSObject</code>,
    ///  exporting only those methods declared in interfaces that you implement
    ///  that are derived from IObjectiveCProtocol.
    ///
    ///  It is permissible to implement this method, and to implement no interfaces
    ///  that are protocol interfaces.
    function GetObjectiveCClass: PTypeInfo; virtual;

    ///
    ///  If you need to get your super class instance, you can call this method.
    ///  You will have to cast it to the appropriate interface type.
    property Super: IObjectiveCInstance read GetSuper;

    constructor Create;
  public
    destructor Destroy; override;
  end;

  ///
  ///  This cache holds vtables and super class vtables for all ObjectiveC
  ///  import types.  A vtable in here might be for an ObjectiveC class, or
  ///  for an ObjectiveC instance.  We create vtables on the fly, when they
  ///  are requested.
  TVTableCache = class
  strict private
    class var VTables: TDictionary<PTypeInfo, TOCVTable>;
    class var SuperVTables: TDictionary<PTypeInfo, TOCVTable>;

    class constructor Create;

  protected
    ///
    ///  The primary source for instance vtables.  If the vtable isn't present in
    ///  the cache, we'll create it.  May throw an exception if the type
    ///  info doesn't represent a valid ObjectiveC type description.
    class function GetVTable(P: PTypeInfo): TOCVTable;

    ///  The primary source for super class reference vtables.  Similar in nature
    ///  to GetVTable;
    class function GetSuperVTable(P: PTypeInfo): TOCVTable;
  end;

///
///  ObjectiveC methods have names recorded in the ObjectiveC runtime.
///  The format of the names depends on the parameters, and in particular
///  the parameter names.  This function will take a Delphi RTTI method
///  and produce the mangled name that will match the ObjectiveC runtime's
///  expectation of that method.  The mangling includes only the method
///  name.  The method signature is a separate item.
function MangleMethodName(const Method: TRttiMethod): string;

///
///  ObjectiveC types follow a specific mangling scheme.  This function
///  returns the mangling for a given Delphi type.  It may raise an
///  <code>EObjectiveC</code> exception if the type cannot be represented
///  as an ObjectiveC type.
function MangleType(const RttiType: TRttiType): string; overload;

///
///  Mangles the parameters of an ObjectiveC method into a signature.  Note that
///  the signature scheme documented by Apple is not the actual scheme generated
///  by gcc.  The signature generated by this function will not currently match
///  the gcc signature mangling.  This is not currently an issue, as the signatures
///  are used only internally here.  You should not count on the stability of the
///  output of this method, however.  We will probably be changing it in the future
///  to more closely match the gcc signatures.
function MangleParameters(const Method: TRttiMethod): string;

///
///  The mangled signature for a complete method includes the return type.
///  This function produces that mangling.
function MangleMethodType(const Method: TRttiMethod): string;

///
///  A mechanism for registering a TOCLocal subclass with the Objective C runtime
///  without instantiating it. This is useful if some other mechanism will
///  instantiate the object by using the Objective C runtime method objc_getClass.
///  Cls is the TOCLocal subclass.
///  Implementing is the interface (typically a protocol) which is implemented by
///  this class.
procedure RegisterObjectiveCClass(Cls: TClass; Implementing: PTypeInfo);

procedure WrapInterface(ObjCId: Pointer; ObjType: Pointer; out Obj);
{$IFDEF CPUARM}
// Added in interface to be visible by rtlhelper.a
procedure WrapObjectiveCReturn(ObjCId: Pointer; InvokeData: POCMethodInvokeData; out Obj);
function GetObjectiveCObject(P: Pointer): Pointer;
{$ENDIF CPUARM}

implementation

uses Macapi.OCBlocks, System.Math;

{$WARN UNSAFE_VOID_POINTER OFF}

type
  TDelphiMethodInvokeData = class
    Marshaler: TMarshaler;
    ParamSize: Integer;
    Code: Pointer; // method address
    HasLargeStructReturn: Boolean;
    HasInterfaceReturn: Boolean;
  end;

  TRegisteredDelphiClass = class
  strict private
    ///
    ///  Pointer to ObjectiveC methods for the registered class.  Used for
    ///  setting implementation methods to safety stubs when a class is
    ///  being unregistered.
    FMethods: PPointer;

    ///  Count of the methods in FMethods.
    FMethodsCount: Integer;

    ///
    ///  The ObjectiveC class ID for this class.  Used for allocating instances
    ///  of the class on the ObjectiveC side.  These instances are the proxy
    ///  instances that delegate to the Delphi implementation, be it for a class
    ///  type, or protocol type.
    FClassID: Pointer;

    ///
    ///  The ObjectiveC class ID of the super class of this type.  Needed for
    ///  when we make super class references.
    FSuperClassID: Pointer;

    constructor Create(ClassID: Pointer; SuperClass: Pointer;
                       Methods: Pointer; MethodsCount: Integer);

    ///
    ///  When we are creating ObjectiveC instances to represent Delphi objects,
    ///  we have no virtual class representing the ObjectiveC class that we can
    ///  use to call the 'alloc' method.  So we call 'alloc' manually via this
    ///  selector.
    class var AllocSelector: Pointer;

    class var TypeMap: TDictionary<PTypeInfo, TRegisteredDelphiClass>;

    ///
    ///  Constructs our class vars. Mostly here to keep the monitor sane.
    class constructor Create;
  protected
    destructor Destroy; override;
    function CreateObj(const O: TOCLocal): Pointer;

    property SuperClassID: Pointer read FSuperClassID;

    class function RegisterClass(P: PTypeInfo; Implementing: PTypeInfo)
      : TRegisteredDelphiClass;
    class function GetRegisteredClass(P: PTypeInfo): TRegisteredDelphiClass;
  end;

  ///  Used for converting a Pascal object reference into an ObjectiveC ID
  ///  and selector for a method call into ObjectiveC.
  TSelfContext = class(TInterfacedObject)
  private
    FSelector: SEL;
    procedure XForm(Src: Pointer; Dest: Pointer);
    constructor Create(Selector: SEL);
  end;

  ///  Used for converting an ObjectiveC ID into a predetermined interface type.
  ///  This is used when ObjectiveC passes an interface as a parameter to a method
  ///  on a call into Delphi from ObjectiveC.
  TConvObjID = class(TInterfacedObject)
  private
    FTypeInfo: PTypeInfo;
    FVTable: TOCVTable;
    procedure XForm(Src: Pointer; Dest: Pointer);
    constructor Create(P: PTypeInfo; VTable: TOCVTable);
  end;

constructor MethodNameAttribute.Create(Name: String);
begin
  FMethodName := Name;
end;

///
///  Call this whenever you go to look up RTTI for something and you couldn't
///  find it.  Note that you should only do this for cases where you reasonably
///  believe that the user passed in the right sort of type, and you just can't
///  find the RTTI for it, with the probably cause being that the user forgot to
///  include {$M+}.  Don't call this if you were hoping to find a method in
///  a class, and it wasn't there, possibly because the user forgot to put it there.
///
///  <param name="Name">Name of the type we couldn't find RTTI for</param>
procedure NoRtti(Name: string);
begin
  raise EObjectiveC.CreateResFmt(@SObjectiveCRTTINotAvailable, [Name]);
end;

procedure BadObjCType(Name: string);
begin
  raise EObjectiveC.CreateResFmt(@SInvalidObjectiveCType, [Name]);
end;

procedure ObjectiveCClassNotFound(Name: string);
begin
  raise EObjectiveC.CreateResFmt(@SObjectiveCClassNotFound, [Name]);
end;

procedure TSelfContext.XForm(Src: Pointer; Dest: Pointer);
var
  Imp: TOCImport;
begin
  Imp := TOCImport(TRawVirtualClass.GetInstanceFromInterface(PPointer(Src)^));
{$IFDEF DEBUGUTILS}
  TDebugUtils.DebugPrint('oc.import.invoke', 'self->obj 0x%x->0x%x for call to ''%s''',
             [IntPtr(PPointer(Src)^), IntPtr(Imp.GetObjectID), MarshaledAString(FSelector)]);
{$ENDIF}
  PPointer(Dest)^ := Imp.GetObjectID;
  PPointer(PByte(Dest) + SizeOf(Pointer))^ := FSelector;
end;

constructor TSelfContext.Create(Selector: SEL);
begin
  FSelector := Selector;
end;

constructor TConvObjID.Create(P: PTypeInfo; VTable: TOCVTable);
begin
  FTypeInfo := P;
  FVTable := VTable;
end;

procedure TConvObjID.XForm(Src: Pointer; Dest: Pointer);
var
  {
    The implementation here will allocate a wrapper object around the ObjectiveC
    object.  An interface for that object is obtained, and stuffed onto the stack
    as an argument to some Delphi method.  The way we do it here, the object
    is supposed to end up with a 0 reference count, so that when the called method
    returns, it will free the wrapper object (because it will addref and release
    the interface for the argument).  In ARC, we have to prevent the compiler from
    addref/releasing the object here, or it will be freed before we get a chance
    to use it, since the interface is never stored as an actual refcounted entity
    here.  So we mark the object unsafe.
  }
  [unsafe] Imp: TOCImport;
  P: Pointer;
begin
  Imp := TOCImport.Create(PPointer(Src)^, nil, FVTable);
  P := Imp.FindInterface(GetTypeData(FTypeInfo)^.Guid);
  PPointer(Dest)^ := P;
{$IFDEF DEBUGUTILS}
  TDebugUtils.DebugPrint('oc.local.invoke', 'wrapping %s object 0x%p -> 0x%p',
             [string(FTypeInfo^.NameFld.ToString), PPointer(Src)^, P]);
{$ENDIF}
end;

function HasInterfaceReturn(const Method: TRttiMethod): Boolean;
var
  RetType: TRttiType;
begin
  RetType := Method.ReturnType;
  if Assigned(RetType) and (RetType.TypeKind = tkInterface) then
    Result := True
  else
    Result := False;
end;

function IsLargeStruct(const RT: TRttiType): Boolean;
begin
{$IFDEF CPUARM}
  if Assigned(RT) and (RT.TypeKind = tkRecord) then
{$ELSE}
  if Assigned(RT) and (RT.TypeKind = tkRecord) and
       (RT.TypeSize > 8) then
{$ENDIF}
    Result := True
  else
    Result := False;
end;

function HasLargeStructReturn(const Method: TRttiMethod): Boolean;
var
  RetType: TRttiType;
begin
  RetType := Method.ReturnType;
  if IsLargeStruct(RetType) then
  begin
{$IFDEF DEBUGUTILS}
    TDebugUtils.DebugPrint('oc.metadata.build', '    has struct return of %d bytes',
               [RetType.TypeSize]);
{$ENDIF}
    Result := True;
  end
  else
    Result := False;
end;

///
///  Returns true if the return type is an interface that represents
///  an ObjectiveC object.
function HasObjectiveCReturn(const Method: TRttiMethod): Boolean;
var
  RetType: TRttiType;
begin
  RetType := Method.ReturnType;
  if Assigned(RetType) and (RetType.TypeKind = tkInterface) then
  begin
{$IFDEF DEBUGUTILS}
    TDebugUtils.DebugPrint('oc.metadata.build', '    has ObjectiveC return');
{$ENDIF}
    Result := True;
  end
  else
    Result := False;
end;

// XForm a self ptr to a obj_super record for a super class call
procedure XFormSelfSuper(Src: Pointer; Dest: Pointer);
var
  Imp: TOCImport;
begin
{$IFDEF DEBUGUTILS}
  TDebugUtils.DebugPrint('oc.super.invoke', 'transforming super reference, Self = 0x%p',
             [PPointer(Src)^]);
{$ENDIF}
  Imp := TOCImport(TRawVirtualClass.GetInstanceFromInterface(PPointer(Src)^));
  PPointer(Dest)^ := Imp.FID;
  PPointer(PByte(Dest) + SizeOf(Pointer))^ := Imp.FClsID;
{$IFDEF DEBUGUTILS}
  TDebugUtils.DebugPrint('oc.super.invoke', 'Obj ID = 0x%p, Cls ID = 0x%p',
             [Imp.FID, Imp.FClsID]);
{$ENDIF}
end;

// XForm an interface to an ObjectiveC object
procedure XFormInterface(Src: Pointer; Dest: Pointer);
var
  Intf: IObjectiveC;
  LocalObject: ILocalObject;
begin
{$IFDEF DEBUGUTILS}
  TDebugUtils.DebugPrint('oc.import.invoke', 'xforminterface src= 0x%x  @Intf= 0x%p  Src= 0x%p', [IntPtr(PPointer(Src)^),Pointer(@Intf),Src]);
{$ENDIF}
  if PPointer(Src)^ = nil then
    PPointer(Dest)^ := nil
  else
  begin
    Intf := IObjectiveC(PPointer(Src)^);
    if Intf.QueryInterface(IID_ILocalObject, LocalObject) <> 0 then
      raise EObjectiveCFatal.CreateRes(@SOCInvokeError);
    PPointer(Dest)^ := LocalObject.GetObjectID;
  end;
end;

///  Transforms an ObjectiveC ID to a self pointer, for an incoming method call
///  to a Delphi implementation of an ObjectiveC class or Protocol. Only used for the
///  self pointer for Delphi implementations.
procedure XFormObjIDToSelf(Src: Pointer; Dest: Pointer);
begin
  object_getInstanceVariable(PPointer(Src)^, 'FMXImplObject', PPointer(Dest)^);
{$IFDEF DEBUGUTILS}
  TDebugUtils.DebugPrint('oc.metadata.RegisterPascal', 'retrieved FMXImplObject = 0x%x  classname =  %s', [IntPtr(Dest^), TObject(Dest^).ClassName]);
{$ENDIF}
end;

function BuildBasicImportMarshalingInfo(const Method: TRttiMethod;
                                        var Src: Integer;
                                        var Dest: Integer;
                                        Ops: TList<TMarshalOp>): Integer;
var
  Size: Integer;
  Op: TMarshalOp;
  Param: TRttiParameter;
  ParamType: TRttiType;
begin
  Size := 0;
  for Param in Method.GetParameters do
  begin
    ParamType := Param.ParamType;
    case ParamType.TypeKind of
      tkInteger, tkChar, tkWChar, tkEnumeration:
        begin
          Op.Kind := moCopy;
          Op.Src := Src;
          Op.Dest := Dest;
          Op.Size := sizeof(Integer);
          Inc(Size, sizeof(Integer));
          Inc(Src, sizeof(Integer));
          Inc(Dest, sizeof(Integer));
          Ops.Add(Op);
        end;
      tkFloat:
        begin
          Op.Kind := moCopy;
          Op.Src := Src;
          Op.Dest := Dest;
          case GetTypeData(ParamType.Handle).FloatType of
            ftDouble:
              begin
                Op.Size := sizeof(Double);
                Inc(Size, sizeof(Double));
                Inc(Src, sizeof(Double));
                Inc(Dest, sizeof(Double));
              end;
            ftSingle:
              begin
                Op.Size := sizeof(Integer);
                Inc(Size, sizeof(Integer));
                Inc(Src, sizeof(Integer));
                Inc(Dest, sizeof(Integer));
              end;
          end;
          Ops.Add(Op);
        end;
      tkInt64:
        begin
          Op.Kind := moCopy;
          Op.Src := Src;
          Op.Dest := Dest;
          Op.Size := sizeof(Int64);
          Inc(Size, sizeof(Int64));
          Inc(Src, sizeof(Int64));
          Inc(Dest, sizeof(Int64));
          Ops.Add(Op);
        end;
      tkPointer:
        begin
          Op.Kind := moCopy;
          Op.Src := Src;
          Op.Dest := Dest;
          Op.Size := sizeof(Pointer);
          Inc(Size, sizeof(Pointer));
          Inc(Src, sizeof(Pointer));
          Inc(Dest, sizeof(Pointer));
          Ops.Add(Op);
        end;
      tkRecord:
        begin
          Op.Kind := moCopy;
          Op.Src := Src;
          Op.Dest := Dest;
          Op.Size := ParamType.TypeSize;
          Inc(Size, Op.Size);
          Inc(Src, Op.Size);
          Inc(Dest, Op.Size);
          Ops.Add(Op);
        end;
      tkInterface:
        begin
          Op.Kind := moXForm;
          Op.Src := Src;
          Op.Dest := Dest;
          Op.XFormProc := @XFormInterface;
          Inc(Size, sizeof(Pointer));
          Inc(Src, sizeof(Pointer));
          Inc(Dest, sizeof(Pointer));
          Ops.Add(Op);
        end;
      tkMethod:
        begin
          Op.Kind := moXFormWithContext;
          Op.Src := Src;
          Op.Dest := Dest;
          Op.Context := TGetBlockType.Create(ParamType.Handle);
          Op._XFormContextProc := @TGetBlockType.XForm;
          Inc(Size, sizeof(TMethod));
          Inc(Src, sizeof(TMethod));
          Inc(Dest, sizeof(TMethod));
          Ops.Add(Op);
        end;
    else
      BadObjCType(ParamType.Name);
    end;
  end;
  Result := Size;
end;

///
///  Builds marshaling information for a call from Delphi into a ObjectiveC super class
///  reference.  These calls will always originate from a virtual interface.
function BuildSuperImportMarshalingInfo(const Method: TRttiMethod;
                                        Selector: SEL;
                                        out OpArray: TArray<TMarshalOp>): Integer;
var
  Ops: TList<TMarshalOp>;
  Op: TMarshalOp;
  SuperRef: TMarshalOp;
  SelfXForm: TMarshalOp;
  Src: Integer;
  Dest: Integer;
  Size: Integer;
  Base: Integer;
begin

  // case 1 (simple call):
  // Src -> self param1 param2
  // Dest -> PSuper Sel param1 param2 [ObjID ClsID]
  //           \_________________________/
  //
  // case 2 (large structure return):
  // Src -> SRET self param1 param2
  // Dest -> SRET PSuper Sel param1 param2 [ObjID ClsID]
  //                \_________________________/
  //
  // case 3 (interface return (ObjectiveC Object):
  // Src -> IRET self param1 param2
  // Dest -> PSuper Sel param1 param2 [ObjID ClsID]
  //           \_________________________/
  Ops := TList<TMarshalOp>.Create;

  // Base will be the offset to the always present arguments in the destination
  // buffer.  If there is an SRET argument, Base will be non-zero.
  Base := 0;

  if HasLargeStructReturn(Method) then
  begin
    // copy in the SRET parameter
    Op.Kind := moCopy;
    Op.Src := 0;
    Op.Dest := 0;
    Op.Size := SizeOf(Pointer);
    Ops.Add(Op);
    Base := SizeOf(Pointer);
    // get past the incoming SRET pointer
    Src := SizeOf(Pointer);
  end
  else if HasObjectiveCReturn(Method) then
    // get past the incoming IRET pointer
    Src := SizeOf(Pointer)
  else
    Src := 0;

  // A reference to the obj_super appears.  We don't know the
  // address of the local yet, so we won't save it in the ops array just yet
  SuperRef.Kind := moLocalRef;
  SuperRef.Src := 0; // not used
  SuperRef.Dest := Base;  // comes right after the SRET, if any
  Ops.Add(SuperRef);

  // Do the selector separately from the Self conversion
  Op.Kind := moStore;
  Op.Src := 0; // not used
  Op.Dest := Base + SizeOf(Pointer); // comes right after the obj_super reference
  Op.Value := IntPtr(Selector);
  Ops.Add(Op);

  SelfXForm.Src := Src;
  Inc(Src, SizeOf(Pointer)); // get past the Self pointer
  Dest := Base + SizeOf(Pointer) * 2; // [SRET] + @obj_super + Selector
  Size := Dest;
  Inc(Size, BuildBasicImportMarshalingInfo(Method, Src, Dest, Ops));

  // now we know the offset to the local for the obj_super
  SuperRef.Offset := Size;
  Ops.Add(SuperRef);

  // This will be the obj_super conversion.
  // so we'll set up the source, now, and save it off
// doesn't need context - a flat fn will do
// switch buildInvokeetc to use moStore for selector, and do the same.
  SelfXForm.Kind := moXForm;
  SelfXForm.Dest := SuperRef.Offset;
  SelfXForm.XFormProc := XFormSelfSuper;
//  XFSelf := TSelfContext.Create(need the class id here);
//  ContextMethod.Code := @TSuperContext.XForm;
//  ContextMethod.Data := XFSelf;
//  SelfXForm.XFormContextProc := TXFormWithContextProc(ContextMethod);
  Ops.Add(SelfXForm);
  Inc(Size, SizeOf(Pointer) * 2); // allocate room for super_class struct

  OpArray := Ops.ToArray;
  Ops.Free;
  Result := Size;
end;

///
///  Builds marshaling information for a call from Delphi into ObjectiveC.
///  These calls will always originate from a virtual interface.
function BuildImportMarshalingInfo(const Method: TRttiMethod;
                                   Selector: SEL;
                                   out OpArray: TArray<TMarshalOp>): Integer;
var
  Ops: TList<TMarshalOp>;
  Op: TMarshalOp;
  Src: Integer;
  Dest: Integer;
  Size: Integer;
begin

  // case 1 (simple call):
  // Src -> self param1 param2
  // Dest -> ObjID Sel param1 param2
  //
  // case 2 (large structure return):
  // Src -> SRET self param1 param2
  // Dest -> SRET ObjID Sel param1 param2
  //
  // case 3 (interface return (ObjectiveC Object):
  // Src -> IRET self param1 param2
  // Dest -> ObjID Sel param1 param2
  Ops := TList<TMarshalOp>.Create;

  Src := 0;
  Dest := 0;
  Size := 0;

  if HasLargeStructReturn(Method) then
  begin
    Op.Kind := moCopy;
    Op.Src := 0;
    Op.Dest := 0;
    OP.Size := SizeOf(Pointer);
    Ops.Add(Op);
    Src := SizeOf(Pointer);
    Dest := SizeOf(Pointer);
    Size := SizeOf(Pointer);
  end
  else if HasObjectiveCReturn(Method) then
  begin
    // There is a return result pointer sitting at the front
    Src := SizeOf(Pointer);
  end;
  Op.Kind := moXFormWithContext;
  Op.Src := Src;
  Op.Dest := Dest;
  Op.Context := TSelfContext.Create(Selector);
  Op._XFormContextProc := @TSelfContext.XForm;
  Ops.Add(Op);
  Inc(Src, SizeOf(Pointer));
  Inc(Dest, SizeOf(Pointer) * 2);
  Inc(Size, SizeOf(Pointer) * 2);

  Inc(Size, BuildBasicImportMarshalingInfo(Method, Src, Dest, Ops));

  OpArray := Ops.ToArray;
  Ops.Free;
  Result := Size;
end;

///
///  Builds marshaling information for a call into a Delphi method from
///  ObjectiveC land.
function BuildLocalMarshalingInfo(const Method: TRttiMethod;
                                  out OpArray: TArray<TMarshalOp>): Integer;
var
  Ops: TList<TMarshalOp>;
  Op: TMarshalOp;
  IntfResultOp: TMarshalOp;
  Param: TRttiParameter;
  Src: Integer;
  Dest: Integer;
  ParamType: TRttiType;
  Size: Integer;
begin

  // case 1 (simple call):
  // Src -> ObjID Sel param1 param2
  // Dest -> self param1 param2
  //
  // case 2 (large structure return):
  // Src -> SRET ObjID Sel param1 param2
  // Dest -> SRET self param1 param2
{$IFDEF DEBUGUTILS}
  TDebugUtils.DebugPrint('oc.metadata.build.marshalinfo', 'building marshaling info for method %s', [Method.Name]);
{$ENDIF}
  Ops := TList<TMarshalOp>.Create;

  Size := 0;
  Src := 0;
  Dest := 0;

  if HasLargeStructReturn(Method) then
  begin
    Op.Kind := moCopy;
    Op.Src := 0;
    Op.Dest := 0;
    Op.Size := SizeOf(Pointer);
    Ops.Add(Op);
    Src := SizeOf(Pointer);
    Dest := SizeOf(Pointer);
    Size := SizeOf(Pointer);
  end;

  if HasInterfaceReturn(Method) then
  begin
    IntfResultOp.Kind := moLocalRef;
    IntfResultOp.Src := 0; // not used
    IntfResultOp.Dest := 0; // the interface result pointer comes before Self
    Dest := SizeOf(Pointer);
    Size := SizeOf(Pointer);
  end;

  Op.Kind := moXForm;
  Op.Src := Src;
  Op.Dest := Dest;
  Op.XFormProc := @XFormObjIDToSelf;
  Ops.Add(Op);
  Inc(Dest, SizeOf(Pointer));
  Inc(Src, Sizeof(Pointer) * 2); // ObjId and SEL
  Inc(Size, Sizeof(Pointer));

  for Param in Method.GetParameters do
  begin
{$IFDEF DEBUGUTILS}
    TDebugUtils.DebugPrint('oc.metadata.build.marshalinfo',
               'marshaling info for %s', [Param.ToString]);
{$ENDIF}
    ParamType := Param.ParamType;
    case ParamType.TypeKind of
      tkInteger, tkChar, tkEnumeration:
        begin
{$IFDEF DEBUGUTILS}
          TDebugUtils.DebugPrint('oc.metadata.build.marshalinfo',
                     '  32bit integral type');
{$ENDIF}
          Op.Kind := moCopy;
          Op.Src := Src;
          Op.Dest := Dest;
          Op.Size := sizeof(Integer);
          Inc(Size, sizeof(Integer));
          Inc(Src, sizeof(Integer));
          Inc(Dest, sizeof(Integer));
          Ops.Add(Op);
        end;
      tkFloat:
        begin
          Op.Kind := moCopy;
          Op.Src := Src;
          Op.Dest := Dest;
          case GetTypeData(ParamType.Handle).FloatType of
            ftDouble:
              begin
                Op.Size := sizeof(Double);
                Inc(Size, sizeof(Double));
                Inc(Src, sizeof(Double));
                Inc(Dest, sizeof(Double));
              end;
            ftSingle:
              begin
                Op.Size := sizeof(Integer);
                Inc(Size, sizeof(Integer));
                Inc(Src, sizeof(Integer));
                Inc(Dest, sizeof(Integer));
              end;
          end;
          Ops.Add(Op);
        end;
      tkInt64:
        begin
{$IFDEF DEBUGUTILS}
          TDebugUtils.DebugPrint('oc.metadata.build.marshalinfo',
                     '  64bit integral type');
{$ENDIF}
          Op.Kind := moCopy;
          Op.Src := Src;
          Op.Dest := Dest;
          Op.Size := sizeof(Int64);
          Inc(Size, sizeof(Int64));
          Inc(Src, sizeof(Int64));
          Inc(Dest, sizeof(Int64));
          Ops.Add(Op);
        end;
      tkPointer:
        begin
{$IFDEF DEBUGUTILS}
          TDebugUtils.DebugPrint('oc.metadata.build.marshalinfo',
                     '  pointer type');
{$ENDIF}
          Op.Kind := moCopy;
          Op.Src := Src;
          Op.Dest := Dest;
          Op.Size := sizeof(Pointer);
          Inc(Size, sizeof(Pointer));
          Inc(Src, sizeof(Pointer));
          Inc(Dest, sizeof(Pointer));
          Ops.Add(Op);
        end;
      tkRecord:
        begin
{$IFDEF DEBUGUTILS}
          TDebugUtils.DebugPrint('oc.metadata.build.marshalinfo',
                     '  record type');
{$ENDIF}
          Op.Kind := moCopy;
          Op.Src := Src;
          Op.Dest := Dest;
          Op.Size := ParamType.TypeSize;
          Inc(Size, Op.Size);
          Inc(Src, Op.Size);
          Inc(Dest, Op.Size);
          Ops.Add(Op);
        end;
      tkInterface:
        begin
{$IFDEF DEBUGUTILS}
          TDebugUtils.DebugPrint('oc.metadata.build.marshalinfo',
                     '  interface type');
{$ENDIF}
          Op.Kind := moXFormWithContext;
          Op.Src := Src;
          Op.Dest := Dest;
          Op.Context := TConvObjID.Create(ParamType.Handle, TVTableCache.GetVTable(ParamType.Handle));
          Op._XFormContextProc := @TConvObjID.XForm;
          Inc(Size, sizeof(Pointer));
          Inc(Src, sizeof(Pointer));
          Inc(Dest, sizeof(Pointer));
          Ops.Add(Op);
        end;
    else
      BadObjCType(ParamType.Name);
    end;
  end;

  if HasInterfaceReturn(Method) then
  begin
    IntfResultOp.Offset := Dest;
    Op.Kind := moStore;
    Op.Src := 0; // not used
    Op.Dest := Dest;
    Op.Size := SizeOf(Pointer);
    Op.Value := 0;
    Ops.Add(Op);
    Inc(Size, SizeOf(Pointer));
    Ops.Add(IntfResultOp);
  end;

  OpArray := Ops.ToArray;
  Ops.Free;
  Result := Size;
end;

function MangleMethodType(const Method: TRttiMethod): string;
var
  MangledReturnType: string;
begin
  if Assigned(Method.ReturnType) then
    MangledReturnType := MangleType(Method.ReturnType)
  else
    MangledReturnType := 'v';
  Result := MangledReturnType + '@:' + MangleParameters(Method);
end;

function MangleMethodName(const Method: TRttiMethod): string;
var
  Param: TRttiParameter;
  First: Boolean;
  Buff: TStringBuilder;
  Attr: TCustomAttribute;
begin
  for Attr in Method.GetAttributes do
  begin
    if (Attr is MethodNameAttribute) then
      Exit(MethodNameAttribute(Attr).Name);
  end;
  First := True;
  Buff := TStringBuilder.Create;
  Buff.Append(Method.Name);
  for Param in Method.GetParameters do
  begin
    if First then
    begin
      Buff.Append(':');
      First := False;
    end
    else
    begin
      Buff.Append(Param.Name);
      Buff.Append(':');
    end;
  end;
  Result := Buff.toString;
  Buff.Free;
end;

procedure MangleType(Buff: TStringBuilder; const RttiType: TRttiType); overload;
var
  Kind: TTypeKind;
  RecType: TRttiRecordType;
  Field: TRttiField;
begin
  Kind := RttiType.TypeKind;
//  TTypeKind = (tkUnknown, tkInteger, tkChar, tkEnumeration, tkFloat,
//    tkString, tkSet, tkClass, tkMethod, tkWChar, tkLString, tkWString,
//    tkVariant, tkArray, tkRecord, tkInterface, tkInt64, tkDynArray, tkUString,
//    tkClassRef, tkPointer, tkProcedure);
//writeln('mangle: ' + RttiType.toString);
  case Kind of
     tkInteger: Buff.Append('i');
     tkInt64: Buff.Append('q');
     tkFloat: Buff.Append('f');
     tkEnumeration: Buff.Append('B'); // FIXME!
//     tkBoolean: Buff.Append('B');
     tkChar: Buff.Append('c');
     tkPointer: Buff.Append('^');
     tkRecord:
       begin
         Buff.Append('{');
         RecType := RttiType.AsRecord;
         Buff.Append(RecType.Name);
         Buff.Append('=');
         for Field in RecType.GetFields do
         begin
           MangleType(Buff, Field.FieldType);
         end;
         Buff.Append('}');
       end;
     tkInterface: Buff.Append('@');
  else
  begin
    BadObjCType(RttiType.ToString);
  end;
  end;
end;

function MangleType(const RttiType: TRttiType): string; overload;
var
  Buff: TStringBuilder;
begin
  Buff := TStringBuilder.Create;
  MangleType(Buff, RttiType);
  Result := Buff.toString;
  Buff.Free;
end;

function MangleParameters(const Method: TRttiMethod): string;
var
  Param: TRttiParameter;
  Buff: TStringBuilder;
begin
  Buff := TStringBuilder.Create;
  for Param in Method.GetParameters do
    MangleType(Buff, Param.ParamType);
  Result := Buff.toString;
  Buff.Free;
end;

function SelectorForMethod(const Method: TRttiMethod): SEL;
var
  MangledName: string;
  M: TMarshaller;
begin
  MangledName := MangleMethodName(Method);
  Result := sel_registerName(M.AsAnsi(MangledName, CP_UTF8).ToPointer);
end;

function BuildOCMethodInvokeData(const Method: TRttiMethod; IsSuperReference: Boolean):
  OCMethodInvokeData;
var
  Ops: TArray<TMarshalOp>;
  RetType: TRttiType;
  Selector: SEL;
begin
  Selector := SelectorForMethod(Method);
  if IsSuperReference then
    Result.ParamSize := BuildSuperImportMarshalingInfo(Method, Selector, Ops)
  else
    Result.ParamSize := BuildImportMarshalingInfo(Method, Selector, Ops);
  Result.Marshaler := TMarshaler.Create(Ops);
  RetType := Method.ReturnType;
  Result.RetKind := rkNormal;
  if Assigned(RetType) then
  begin
    if IsLargeStruct(RetType) then
      Result.RetKind := rkSRET
    else if RetType.TypeKind = tkFloat then
      Result.RetKind := rkFPRET
    else if HasObjectiveCReturn(Method) then
    begin
      Result.RetKind := rkIRET;
      Result.ObjectiveCType := RetType.Handle;
//      Result.VTable := TVTableCache.GetVTable(RetType.Handle);
    end;
  end;
end;

procedure GetMethodsInVTableOrder(const RttiType: TRttiType; Methods:TList<TRttiMethod>); overload;
var
  BaseType: TRttiType;
  Method: TRttiMethod;
begin
  BaseType := RttiType.BaseType;
  if Assigned(BaseType) then
    GetMethodsInVTableOrder(BaseType, Methods);
  for Method in RttiType.GetDeclaredMethods do
    Methods.Add(Method);
end;

function GetMethodsInVTableOrder(const RttiType: TRttiType): TList<TRttiMethod>; overload;
begin
  Result := TList<TRttiMethod>.Create;
  GetMethodsInVTableOrder(RttiType, Result);
end;

function BuildInvokeData(P: PTypeInfo; IsSuperReference: Boolean):
  TArray<OCMethodInvokeData>;
var
  Method: TRttiMethod;
  RttiType: TRttiType;
  Context: TRttiContext;
  List: TList<OCMethodInvokeData>;
  Methods: TList<TRttiMethod>;
begin
{$IFDEF DEBUGUTILS}
  TDebugUtils.DebugPrint('oc.metadata.build',
             'Building invoke data for ''%s''', [string(P^.NameFld.ToString)]);
{$ENDIF}
  List := TList<OCMethodInvokeData>.Create;
  Context := TRttiContext.Create;
  RttiType := Context.GetType(P);
  if not Assigned(RttiType) then
    NoRtti(string(P^.NameFld.ToString));

  Methods := GetMethodsInVTableOrder(RttiType);
  for Method in Methods do
  begin
{$IFDEF DEBUGUTILS}
    TDebugUtils.DebugPrint('oc.metadata.build', '  %s (vt idx = %d)',
               [Method.ToString, Method.VirtualIndex]);
{$ENDIF}
    if Method.CallingConvention <> ccCdecl then
      raise EObjectiveC.CreateResFmt(@SMethodMustBeCDecl,
                                     [Method.Name, string(P^.NameFld.ToString)]);
    List.Add(BuildOCMethodInvokeData(Method, IsSuperReference));
  end;
  Result := List.ToArray;
  Methods.Free;
  Context.Free;
  List.Free;
end;

function GetObjectiveCObject(P: Pointer): Pointer;
var
  Intf: IObjectiveC;
  LocalObject: ILocalObject;
begin
  if PPointer(P)^ = nil then
    Result := nil
  else
  begin
    Intf := IObjectiveC(PPointer(P)^);
    if Intf.QueryInterface(IID_ILocalObject, LocalObject) <> 0 then
      raise EObjectiveCFatal.CreateRes(@SOCInvokeError);
    Result := LocalObject.GetObjectID;
  end;
end;

procedure DispatchToDelphi;
{$IF Defined(CPUARM)}
    cdecl; varargs;  external 'librtlhelper.a' name 'DispatchToDelphi';
{$ELSEIF Defined(CPUX86)}
asm
//  int 3
  // stack has: CTXT EBP RA ARGS
  MOV EAX, [EBP - 4]
  MOV ECX, [EAX].TDelphiMethodInvokeData.ParamSize
  ADD ECX, $F
  SUB ESP, ECX
  AND ESP, $FFFFFFF0
  MOV EAX, [EAX].TDelphiMethodInvokeData.Marshaler
  LEA EDX, [EBP + 8]
  MOV ECX, ESP
  CALL TMarshaler.Execute
  MOV EAX, [EBP - 4]
  MOV EAX, [EAX].TDelphiMethodInvokeData.Code
  CALL EAX
  MOV ECX, [EBP - 4]
  CMP BYTE PTR[ECX].TDelphiMethodInvokeData.HasInterfaceReturn, 0
  JNE @@intfret
  CMP BYTE PTR[ECX].TDelphiMethodInvokeData.HasLargeStructReturn, 0
  JE @@done
  LEAVE
  RET 4
@@intfret:
  MOV EAX, [ESP]
  CALL GetObjectiveCObject
@@done:
  LEAVE
end;
{$ELSE OTHERCPU}
  {$MESSAGE Fatal 'Method not implemented for CPU'}
{$ENDIF OTHERCPU}

procedure WrapInterface(ObjCId: Pointer; ObjType: Pointer; out Obj);
var
  Imp: TOCImport;
  P: PTypeInfo;
  V: TOCVTable;
begin
  if ObjCId = nil then
  begin
    Pointer(Obj) := nil;
    Exit;
  end;
  P := ObjType;
  V := TVTableCache.GetVTable(P);

  Imp := TOCImport.Create(ObjCId, nil, V);
  if Imp.QueryInterface(GetTypeData(P)^.Guid, Obj) <> S_OK then
    raise EObjectiveC.CreateResFmt(@SInternalBindingError, [string(PTypeInfo(ObjType)^.NameFld.ToString)]);
end;

procedure WrapObjectiveCReturn(ObjCId: Pointer; InvokeData: POCMethodInvokeData;
                               out Obj);
var
  Imp: TOCImport;
  P: PTypeInfo;
  V: TOCVTable;
begin
  if ObjCId = nil then
  begin
    Pointer(Obj) := nil;
    Exit;
  end;
  P := InvokeData^.ObjectiveCType;
  V := TVTableCache.GetVTable(P);
  Imp := TOCImport.Create(ObjCId, nil, V);
  if Imp.QueryInterface(GetTypeData(P)^.Guid, Obj) <> S_OK then
    raise EObjectiveC.CreateResFmt(@SInternalBindingError, [string(InvokeData^.ObjectiveCType^.NameFld.ToString)]);
end;

{$IFDEF X86ASM}
 // offset of FPU/SSE Ccontrol word. It is related with System.Rtti.TFirstStageIntercept.
const
  FPCWOFFSET = 16;
  MXCSROFFSET = 20;
{$ENDIF X86ASM}

procedure DispatchToImport;
{$IF Defined(CPUARM)}
    cdecl; varargs;  external 'librtlhelper.a' name 'DispatchToImport';
{$ELSEIF Defined(CPUX86)}
asm
//  int 3
  // Read and save the original FPU control word.
  PUSH 0
  FNSTCW [ESP].Word
  // and disable all exceptions
  MOV EAX, [ESP]
  OR  EAX, $003F // mask all exceptions
  PUSH EAX
  FLDCW [ESP].Word
  POP EAX
  PUSH 0
  STMXCSR [ESP].DWORD
  MOV EAX, [ESP]
  OR  EAX, $1F80 // mask all exceptions
  PUSH EAX
  LDMXCSR [ESP].DWord
  POP EAX
  // stack has: CTXT EBP RA ARGS
  MOV EAX, [EBP - 4]
  MOV ECX, [EAX].OCMethodInvokeData.ParamSize
  ADD ECX, $F
  SUB ESP, ECX
  AND ESP, $FFFFFFF0
  MOV EAX, [EAX].OCMethodInvokeData.Marshaler
  LEA EDX, [EBP + 8]
  MOV ECX, ESP
  CALL TMarshaler.Execute
  MOV EAX, [EBP - 4]
  CMP [EAX].OCMethodInvokeData.RetKind, rkFPRET
  JE @@fpret
  CMP [EAX].OCMethodInvokeData.RetKind, rkSRET
  JE @@sret
  CMP [EAX].OCMethodInvokeData.RetKind, rkIRET
  JE @@iret
  CALL objc_msgSend
  JMP @@done
@@fpret:
  CALL objc_msgSend_fpret
  JMP @@done
@@sret:
  CALL objc_msgSend_stret
  FNCLEX
  FLDCW   [EBP-FPCWOFFSET].Word
  LDMXCSR [EBP - MXCSROFFSET]
  LEAVE
  RET 4
@@iret:
  CALL objc_msgSend
  // EAX = raw ObjectiveC object
  MOV EDX, [EBP - 4] // invoke data
  MOV ECX, [EBP + 8] // first param is pointer to interface return
  CALL WrapObjectiveCReturn
@@done:
  FNCLEX
  FLDCW   [EBP - FPCWOFFSET]
  LDMXCSR [EBP - MXCSROFFSET]
  LEAVE
end;
{$ELSE OTHERCPU}
  {$MESSAGE Fatal 'Method not implemented for CPU'}
{$ENDIF OTHERCPU}

procedure DispatchToImportSuper;
{$IF Defined(CPUARM)}
    cdecl; varargs;  external 'librtlhelper.a' name 'DispatchToImportSuper';
{$ELSEIF Defined(CPUX86)}
asm
  PUSH 0
  FNSTCW [ESP].Word
  // and disable all exceptions
  MOV EAX, [ESP]
  OR  EAX, $003F // mask all exceptions
  PUSH EAX
  FLDCW [ESP].Word
  POP EAX
  PUSH 0
  STMXCSR [ESP].DWORD
  MOV EAX, [ESP]
  OR  EAX, $1F80 // mask all exceptions
  PUSH EAX
  LDMXCSR [ESP].DWord
  POP EAX
  // stack has: CTXT EBP RA ARGS
  MOV EAX, [EBP - 4]
  MOV ECX, [EAX].OCMethodInvokeData.ParamSize
  ADD ECX, $F
  SUB ESP, ECX
  AND ESP, $FFFFFFF0 // alignment
  MOV EAX, [EAX].OCMethodInvokeData.Marshaler
  LEA EDX, [EBP + 8]
  MOV ECX, ESP
  CALL TMarshaler.Execute
  MOV EAX, [EBP - 4]
// docs say to use sendSuper for FP return.
//  CMP [EAX].TOCImportMetaData.MethodInvokeData.RetKind, rkFPRET
//  JE @@fpret
  CMP [EAX].OCMethodInvokeData.RetKind, rkSRET
  JE @@sret
  CMP [EAX].OCMethodInvokeData.RetKind, rkIRET
  JE @@iret
  CALL objc_msgSendSuper
  JMP @@done
//@@fpret:
//  CALL objc_msgSend_fpret
//  JMP @@done
@@sret:
  CALL objc_msgSendSuper_stret
  FNCLEX
  FLDCW   [EBP-FPCWOFFSET].Word
  LDMXCSR [EBP - MXCSROFFSET]
  LEAVE
  RET 4
@@iret:
  CALL objc_msgSendSuper
  // EAX = raw ObjectiveC object
  MOV EDX, [EBP - 4] // invoke data
  MOV ECX, [EBP + 8] // first param is pointer to interface return
  CALL WrapObjectiveCReturn
@@done:
  FNCLEX
  FLDCW   [EBP-FPCWOFFSET].Word
  LDMXCSR [EBP - MXCSROFFSET]
  MOV ESP, EBP
  POP EBP
end;
{$ELSE OTHERCPU}
  {$MESSAGE Fatal 'Method not implemented for CPU'}
{$ENDIF OTHERCPU}

constructor TOCVTable.Create(P: PTypeInfo;
                             IsSuperClass: Boolean);
var
  I: Integer;
  GuidCount: Integer;
  Parent: PTypeInfo;
  function GetParent(P: PTypeInfo): PTypeInfo;
  var
    PP: PPTypeInfo;
  begin
    PP := GetTypeData(P).IntfParent;
    if Assigned(PP) then
      Result := PP^
    else
      Result := nil;
  end;
begin
{$IFDEF DEBUGUTILS}
  TDebugUtils.DebugPrint('oc.vtable.create', 'Creating vtable for ''%s''', [string(P^.NameFld.ToString)]);
{$ENDIF}
  FMethodInfoData := BuildInvokeData(P, IsSuperClass);
  inherited Create(Length(FMethodInfoData));
  Parent := GetParent(P);
  GuidCount := 1;
  while Parent <> nil do
  begin
    Inc(GuidCount);
    Parent := GetParent(Parent);
  end;

  SetLength(FGuids, GuidCount);

  for I := 0 to GuidCount - 1 do
  begin
    FGuids[I] := GetTypeData(P)^.Guid;
{$IFDEF DEBUGUTILS}
    TDebugUtils.DebugPrint('oc.vtable.create', '  %s %s', [string(P^.NameFld.ToString), GUIDToString(FGuids[I])]);
{$ENDIF}
    P := GetParent(P);
  end;

  /// TODO: SetVTableSlot may someday change to include a callee pop amount for unwinding support.
  for I := 0 to Length(FMethodInfoData) - 1 do
    if IsSuperClass then
      SetVTableSlot(I, @DispatchToImportSuper, @FMethodInfoData[I])
    else
      SetVTableSlot(I, @DispatchToImport, @FMethodInfoData[I]);
end;

function TOCImport.GetObjectID: Pointer;
begin
  Result := FID;
end;

constructor TOCImport.Create(ID: Pointer; ClsID: Pointer; VTable: TOCVTable);
begin
  inherited Create(VTable.Guids, VTable);
  FID := ID;
  FClsID := ClsID;
end;

destructor TOCImport.Destroy;
begin
//  TDebugUtils.DebugPrint('oc.import.dtor', 'import 0x%p being destroyed', [Self]);
end;

///  Checks to see that the given type (assumed to be an interface type) has RTTI
///  for its methods.  Since we use the M+ directive on the base interface types,
///  this is redundant, but it doesn't hurt to make the check in case the day
///  comes that the M+ inheritance on interfaces changes its behaviour, and
///  inheritance of method rtti settings follows the inheritance of method RTTI
///  for classes.
procedure CheckForRtti(P: PTypeInfo);
var
  MethodTable: PIntfMethodTable;
begin
//  PB := @GetTypeData(P)^.IntfUnit;
//  Inc(PB, PB^ + 1); // skip the short string
//  MethodTable := PIntfMethodTable(PB);
  MethodTable := GetTypeData(P).IntfMethods;
  if (MethodTable^.Count > 0) and (MethodTable^.RttiCount = $FFFF) then
    NoRtti(string(P^.NameFld.ToString));
end;

class procedure TOCValidate.ValidateTypeHierarchy(P: PTypeInfo; RequiredRoot: PTypeInfo;
                                                  ErrMsg: PResStringRec);
var
  PP: PPTypeInfo;
  procedure BadType;
  begin
    raise EObjectiveC.CreateResFmt(ErrMsg, [string(P^.NameFld.ToString)]);
  end;
begin
  if P^.Kind <> tkInterface then
    BadType;
{$IFDEF DEBUGUTILS}
  TDebugUtils.DebugPrint('oc.checkrtti.typehierarchy', '===');
{$ENDIF}
  while P <> nil do
  begin
{$IFDEF DEBUGUTILS}
    TDebugUtils.DebugPrint('oc.checkrtti.typehierarchy', 'checking rtti for P = %s, RequiredRoot = %s', [string(P^.NameFld.ToString), string(RequiredRoot^.NameFld.ToString)]);
{$ENDIF}
    CheckForRtti(P);
    if P = RequiredRoot then
      Exit;
    PP := GetTypeData(P).IntfParent;
    if Assigned(PP) then
      P := PP^
    else
      P := nil;
  end;
  BadType;
end;

///
///  ObjectiveC class types must be interface types, and they must 'derive'
///  from IObjectiveCClass.
class procedure TOCValidate.ValidateClassHierarchy(P: PTypeInfo);
begin
  TOCValidate.ValidateTypeHierarchy(P, TypeInfo(IObjectiveCClass), @SBadObjectiveCClass);
end;

///
///  ObjectiveC instance types must be interface types, and they must 'derive'
///  from IObjectiveCInstance.
class procedure TOCValidate.ValidateInstanceHierarchy(P: PTypeInfo);
begin
  TOCValidate.ValidateTypeHierarchy(P, TypeInfo(IObjectiveCInstance), @SBadObjectiveCInstance);
end;

///
///  ObjectiveC protocol types must be interface types, and they must 'derive'
///  from IObjectiveC.
class procedure TOCValidate.ValidateProtocolHierarchy(P: PTypeInfo);
begin
  TOCValidate.ValidateTypeHierarchy(P, TypeInfo(IObjectiveC), @SBadObjectiveCProtocol);
end;

class procedure TOCValidate.ValidateMethods(P: PTypeInfo);
var
  InvData: TArray<OCMethodInvokeData>;
begin
  InvData := BuildInvokeData(P, False);
end;

class procedure TOCValidate.ValidateClassType(P: PTypeInfo);
begin
  TOCValidate.ValidateClassHierarchy(P);
  TOCValidate.ValidateMethods(P);
end;

class procedure TOCValidate.ValidateInstanceType(P: PTypeInfo);
begin
  TOCValidate.ValidateInstanceHierarchy(P);
  TOCValidate.ValidateMethods(P);
end;

class procedure TOCValidate.ValidateProtocolType(P: PTypeInfo);
begin
  TOCValidate.ValidateProtocolHierarchy(P);
  TOCValidate.ValidateMethods(P);
end;

///TODO: multi-thread possibility of a one time small leak
///  In the future, it would be nice to protect the creation of the ObjectiveC class
///  vtable with a monitor, so that we won't leak any memory in the very rare
///  case that two threads enter this function for the first time in a race pattern.
///  To do that, we'd have a class constructor to create an object to sync the monitor
///  to.  Unfortunately, there is a compiler bug that class constructors for generics
///  are not called.  We could sync on a single class var in TOCImport, but then
///  all ObjectiveC import creations could become serialized across all threads, and
///  that would be pretty bad.
class function TOCGenericImport<C,T>.GetOCClass: C;
var
  ClassImport: TOCImport;
  ClsID: Pointer;
  ITypeInfo: PTypeInfo;
  CTypeInfo: PTypeInfo;
  M: TMarshaller;
begin
  if not Assigned(FOCClass) then
  begin
    TOCValidate.ValidateClassHierarchy(TypeInfo(C));
    TOCValidate.ValidateInstanceHierarchy(TypeInfo(T));
    ITypeInfo := TypeInfo(T);
    CTypeInfo := TypeInfo(C);
    ClsID := objc_getClass(M.AsAnsi(ITypeInfo^.NameFld.ToString, CP_UTF8).ToPointer);
    if not Assigned(ClsId) then
      raise EObjectiveC.CreateResFmt(@SObjectiveCClassNotFound, [string(ITypeInfo^.NameFld.ToString)]);
    FClassVTable := TOCVTable.Create(CTypeInfo, False);
    ClassImport := TOCImport.Create(ClsId, nil, FClassVTable);
    if ClassImport.QueryInterface(GetTypeData(CTypeInfo)^.Guid, FOCClass) <> 0 then
      raise EObjectiveC.CreateResFmt(@SInternalBindingError, [string(ITypeInfo^.NameFld.ToString)]);
  end;
  Result := FOCCLass;
end;

class function TOCGenericImport<C,T>.GetInstanceVTable: TOCVTable;
begin
  if not Assigned(FInstanceVTable) then
    FInstanceVTable := TVTableCache.GetVTable(TypeInfo(T));
  Result := FInstanceVTable;
end;

class function TOCGenericImport<C,T>.Alloc: T;
var
  Cls: C;
  ObjID: Pointer;
  Obj: TOCImport;
  ITypeInfo: PTypeInfo;
begin
  ITypeInfo := TypeInfo(T);
{$IFDEF DEBUGUTILS}
  TDebugUtils.DebugPrint('oc.import.create', 'Creating instance of ''%s''', [string(ITypeInfo^.NameFld.ToString)]);
{$ENDIF}
  Cls := GetOCClass;
  ObjID := Cls.alloc;
  Obj := TOCImport.Create(ObjID, nil, GetInstanceVTable);
  if Obj.QueryInterface(GetTypeData(ITypeInfo)^.Guid, Result) <> 0 then
    raise EObjectiveC.CreateResFmt(@SInternalBindingError, [string(ITypeInfo^.NameFld.ToString)]);
end;

class function TOCGenericImport<C,T>.Wrap(P: Pointer): T;
var
  ObjID: Pointer;
  Obj: TOCImport;
  ITypeInfo: PTypeInfo;
begin
  ITypeInfo := TypeInfo(T);
{$IFDEF DEBUGUTILS}
  TDebugUtils.DebugPrint('oc.import.create', 'wrapping instance of ''%s'' around 0x%x',
             [string(ITypeInfo^.NameFld.ToString), IntPtr(P)]);
{$ENDIF}
  Obj := TOCImport.Create(P, nil, GetInstanceVTable);
  if Obj.QueryInterface(GetTypeData(ITypeInfo)^.Guid, Result) <> 0 then
    raise EObjectiveC.CreateResFmt(@SInternalBindingError, [string(ITypeInfo^.NameFld.ToString)]);
end;

class function TOCGenericImport<C,T>.Create: T;
var
  P: Pointer;
begin
  Result := Alloc;
  // and call the constructor
  P := Result.init;
{$IFDEF DEBUGUTILS}
  TDebugUtils.DebugPrint('oc.import.create', 'Value from default ctor = 0x%x', [IntPtr(P)]);
{$ENDIF}
  Init(Result, P);
end;

class procedure TOCGenericImport<C,T>.Init(O: T; P: Pointer);
var
  Imp: TOCImport;
begin
  Imp := TOCImport(TRawVirtualClass.GetInstanceFromInterface(PPointer(@O)^));
{$IFDEF DEBUGUTILS}
  TDebugUtils.DebugPrint('oc.instance.init', 'Initing ''%s'' with 0x%x.  Old value = 0x%x',
             [Imp.ClassName, IntPtr(P), IntPtr(Imp.FID)]);
{$ENDIF}
  Imp.FID := P;
end;

class constructor TVTableCache.Create;
begin
  VTables := TDictionary<PTypeInfo, TOCVTable>.Create;
  SuperVTables := TDictionary<PTypeInfo, TOCVTable>.Create;
end;

class function TVTableCache.GetVTable(P: PTypeInfo): TOCVTable;
begin
  TMonitor.Enter(VTables);
  try
    if not VTables.ContainsKey(P) then
    begin
      Result := TOCVTable.Create(P, False);
      VTables.Add(P, Result);
    end
    else
      Result := VTables.Items[P];
  finally
    TMonitor.Exit(VTables);
  end;
end;

class function TVTableCache.GetSuperVTable(P: PTypeInfo): TOCVTable;
begin
  TMonitor.Enter(VTables);
  try
    if not SuperVTables.ContainsKey(P) then
    begin
      Result := TOCVTable.Create(P, True);
      SuperVTables.Add(P, Result);
    end
    else
      Result := SuperVTables.Items[P];
  finally
    TMonitor.Exit(VTables);
  end;
end;

///  Given a method, and a list of methods potentially from some other type,
///  finds the corresponding method in that list.  By corresponding, we mean
///  matching in signature.
///
function FindCorrespondingMethod(const Method: TRttiMethod; const Methods: TArray<TRttiMethod>) : TRttiMethod;
var
  Candidate: TRttiMethod;
  N, S : string;
begin
  Result := nil;
  N := Method.Name;
  S := Method.toString;
  for Candidate in Methods do
    if (Candidate.Name = N) and (Candidate.toString = S) then
    begin
      Result := Candidate;
      break;
    end;
end;

function BuildLocalInvokeData(const Method: TRttiMethod): TDelphiMethodInvokeData;
var
  Ops: TArray<TMarshalOp>;
begin
  Result := TDelphiMethodInvokeData.Create;
  Result.Code := Method.CodeAddress;
  Result.ParamSize := BuildLocalMarshalingInfo(Method, Ops);
  Result.Marshaler := TMarshaler.Create(Ops);
  Result.HasLargeStructReturn := HasLargeStructReturn(Method);
  Result.HasInterfaceReturn := HasInterfaceReturn(Method);
end;

class constructor TRegisteredDelphiClass.Create;
begin
  AllocSelector := sel_registerName('alloc');
  TypeMap := TDictionary<PTypeInfo, TRegisteredDelphiClass>.Create;
end;

constructor TRegisteredDelphiClass.Create(ClassID: Pointer; SuperClass: Pointer;
                                          Methods: Pointer;
                                          MethodsCount: Integer);
begin
  FClassID := ClassID;
  FSuperClassID := SuperClass;
  FMethods := Methods;
  FMethodsCount := MethodsCount;
end;

destructor TRegisteredDelphiClass.Destroy;
begin
                                                               
  // then free methods
//  free(Methods);
  inherited Destroy;
end;

function TRegisteredDelphiClass.CreateObj(const O: TOCLocal): Pointer;
begin
  Result := objc_msgSend(FClassId, AllocSelector);
  if Assigned(Result) then
  begin
    object_setInstanceVariable(Result, 'FMXImplObject', O);
{$IFDEF DEBUGUTILS}
    TDebugUtils.DebugPrint('oc.metadata.RegisterPascal', 'Set FMXImplObject = 0x%x', [IntPtr(O)]);
{$ENDIF}
  end;
end;

class function TRegisteredDelphiClass.GetRegisteredClass(P: PTypeInfo): TRegisteredDelphiClass;
begin
  TMonitor.Enter(TypeMap);
  try
    Result := TypeMap.Items[P];
  finally
    TMonitor.Exit(TypeMap);
  end;
end;

class function TRegisteredDelphiClass.RegisterClass(P: PTypeInfo;
                                                    Implementing: PTypeInfo)
  : TRegisteredDelphiClass;
var
  Context: TRttiContext;
  RttiType: TRttiType;
  InstanceType: TRttiInstanceType;
  TP: TRttiType; // temp used for error checking
  ImplementingType: TRttiInterfaceType;
  Protocol: TRttiInterfaceType;
  MethodsHash: TDictionary<string, TRttiMethod>;
  AllMethods: TArray<TPair<string, TRttiMethod>>;
  Methods: TArray<TRttiMethod>;
  Method: TRttiMethod;
  ClassMethod: TRttiMethod;
  Pair: TPair<string, TRttiMethod>;
  ObjCClassName: string;
  Thunk: Pointer;
  BytesToPop: Integer;
  ObjCClassId: Pointer;
  SuperClass: Pointer;
  SuperClassName: string;
  MethodName: string;
  MangledName: string;
  InvokeData: TDelphiMethodInvokeData;
  OCMethods: Pointer;
  OCMethodsCount: Integer;
  OCProtocol: Pointer;
  M: TMarshaller;
  procedure FailRegistration;
  begin
    raise EObjectiveC.CreateResFmt(@SObjCClassRegistrationFailed, [string(P^.NameFld.ToString)]);
  end;
begin
  TMonitor.Enter(TypeMap);
  Result := nil; // quiet the compiler warning
  try
    if TypeMap.ContainsKey(P) then
      Exit(TypeMap.Items[P]);

    Context := TRttiContext.Create;
    InstanceType := TRttiInstanceType(Context.GetType(P));
    Methods := InstanceType.GetMethods;

    MethodsHash := TDictionary<string, TRttiMethod>.Create;

    ObjCClassName := string(P^.NameFld.ToString);

{$IFDEF DEBUGUTILS}
    TDebugUtils.DebugPrint('oc.metadata.RegisterPascal', 'registering meta data local object %s',
               [ObjCClassName]);
{$ENDIF}

    // Now we go through all the protocols, gathering up all their methods
    // as well.
    for Protocol in InstanceType.GetImplementedInterfaces do
    begin
{$IFDEF DEBUGUTILS}
      TDebugUtils.DebugPrint('oc.metadata.RegisterPascal',  'checking protocol %s', [string(Protocol.Handle^.NameFld.ToString)]);
{$ENDIF}
      try
        if (Protocol.GUID = ILocalObject) or (Protocol.GUID = IInterface) then
          continue;
        TOCValidate.ValidateProtocolHierarchy(Protocol.Handle);
      except
//        on E: EObjectiveC do
        begin
//          Writeln('** exception caught:' + E.ClassName);
          continue;
        end
      end;
      RttiType := Protocol;
      for Method in RttiType.GetMethods do
      begin
{$IFDEF DEBUGUTILS}
        TDebugUtils.DebugPrint('oc.metadata.RegisterPascal', 'adding method %s', [Method.Name]);
{$ENDIF}
                                                                    
        if Method.CallingConvention <> ccCdecl then
          raise EObjectiveC.CreateResFmt(@SMethodMustBeCDecl,
                                         [Method.Name, string(Protocol.Handle^.NameFld.ToString)]);
        MethodsHash.AddOrSetValue(Method.toString, Method);
      end;
    end;

    if Assigned(Implementing) then
    begin
      // Go through the methods that are declared in the 'implementing' interface.
      // These are the ones we say we'll be implementing. The class name will be the
      // name of that interface, not the name of the Delphi class.
{$IFDEF DEBUGUTILS}
      TDebugUtils.DebugPrint('oc.metadata.RegisterPascal', 'class claims to implement %s',
                 [string(Implementing^.NameFld.ToString)]);
{$ENDIF}
      TP := Context.GetType(Implementing);
      if not Assigned(TP) then
        NoRtti(string(Implementing^.NameFld.ToString));
      TOCValidate.ValidateInstanceHierarchy(Implementing);
      if not (TP is TRttiInterfaceType) then
        BadObjCType(TP.toString);
      ImplementingType := TRttiInterfaceType(TP);
      for Method in ImplementingType.GetMethods do
        if Method.Parent = ImplementingType then
        begin
{$IFDEF DEBUGUTILS}
          TDebugUtils.DebugPrint('oc.metadata.RegisterPascal', '  must implement %s',
                     [Method.toString]);
{$ENDIF}
          if Method.CallingConvention <> ccCdecl then
          raise EObjectiveC.CreateResFmt(@SMethodMustBeCDecl,
                                         [Method.Name, string(Implementing^.NameFld.ToString)]);
          MethodsHash.AddOrSetValue(Method.toString, Method);
        end;
      ObjCClassName := ImplementingType.Name;

                                                                                 
      // RTTI var to avoid the usage
      SuperClassName := ImplementingType.BaseType.ToString;
{$IFDEF DEBUGUTILS}
      TDebugUtils.DebugPrint('oc.metadata.RegisterPascal', 'super class will be %s', [SuperClassName]);
{$ENDIF}
      SuperClass := objc_getClass(M.AsAnsi(SuperClassName, CP_UTF8).ToPointer);
      if not Assigned(SuperClass) then
        ObjectiveCClassNotFound(SuperClassName);
    end
    else
    begin
{$IFDEF DEBUGUTILS}
      TDebugUtils.DebugPrint('oc.metadata.RegisterPascal', 'super class will be NSObject');
{$ENDIF}
      SuperClass := objc_getClass('NSObject');
    end;

                                                                           
    ObjCClassId := objc_allocateClassPair(SuperClass, M.AsAnsi(ObjCClassName).ToPointer, 0);
    if not Assigned(ObjCClassId) then
      FailRegistration;

{$IFDEF DEBUGUTILS}
    TDebugUtils.DebugPrint('oc.metadata.RegisterPascal', 'ObjectiveC class id is 0x%x',
               [IntPtr(ObjCClassId)]);
{$ENDIF}

    // Flatten the array for iteration
    AllMethods := MethodsHash.ToArray;
    MethodsHash.Free;

    for Pair in AllMethods do
    begin
      Method := Pair.Value;
      ClassMethod := FindCorrespondingMethod(Method, Methods);
      if not Assigned(ClassMethod) then
        raise EObjectiveC.CreateResFmt(@SMethodNotFound,
                                       [Method.ToString, string(P^.NameFld.ToString)]);

      MethodName := MangleMethodName(ClassMethod);
      MangledName := MangleMethodType(ClassMethod);
{$IFDEF DEBUGUTILS}
      TDebugUtils.DebugPrint('oc.metadata.RegisterPascal', 'method %s -> %s', [Method.toString, MethodName]);
      TDebugUtils.DebugPrint('oc.metadata.RegisterPascal.mangled', 'selector = ''%s''',
                 [MangledName]);
{$ENDIF}
      InvokeData := BuildLocalInvokeData(ClassMethod);
      //
      // While it is technically not allowed to throw an exception past an ObjectiveC method,
      // we'll do the 'right' thing and set up the data to allow the unwinder to do the
      // cleanup of the stack properly.
      //
      if (InvokeData.HasLargeStructReturn) then
        BytesToPop := SizeOf(Pointer)
      else
        BytesToPop := 0;
      Thunk := TRawVTable.AllocateRawThunk(@DispatchToDelphi, InvokeData, BytesToPop);
{$IFDEF AUTOREFCOUNT}
                                                 
      InvokeData.__ObjAddRef;
{$ENDIF AUTOREFCOUNT}
      if class_addMethod(ObjCClassId, sel_registerName(M.AsAnsi(MethodName, CP_UTF8).ToPointer),
                         Thunk,
                         M.AsAnsi(MangledName, CP_UTF8).ToPointer) = NO then
      begin
        FailRegistration;
      end;
    end;

    if class_addIvar(ObjCClassId, 'FMXImplObject',
                     SizeOf(Pointer), Round(Log2(SizeOf(Pointer))), '?') = NO then
      FailRegistration;

    // Add protocols
    for Protocol in InstanceType.GetImplementedInterfaces do
    begin
{$IFDEF DEBUGUTILS}
        TDebugUtils.DebugPrint('oc.metadata.registerprotocol',  'claims to implement protocol %s', [string(Protocol.Handle^.NameFld.ToString)]);
{$ENDIF}
        if (Protocol.GUID = ILocalObject) or (Protocol.GUID = IInterface) or (Protocol.GUID = IObjectiveC) then
          continue;
        OCProtocol := objc_getProtocol(M.AsAnsi(Protocol.Handle^.NameFld.ToString, CP_UTF8).ToPointer);
        if OCProtocol <> nil then
        begin
          class_addProtocol(ObjCClassId, OCProtocol);
{$IFDEF DEBUGUTILS}
          TDebugUtils.DebugPrint('oc.metadata.registerprotocol',  '    registering protocol %s', [string(Protocol.Handle^.NameFld.ToString)]);
{$ENDIF}
        end;
    end;

    objc_registerClassPair(ObjCClassId);

    OCMethods := class_copyMethodList(ObjCClassID, OCMethodsCount);
    Result := TRegisteredDelphiClass.Create(ObjCClassID, SuperClass, OCMethods, OCMethodsCount);
    TypeMap.Add(P, Result);
  finally
    Context.Free;
    TMonitor.Exit(TypeMap);
  end;
end;

function TOCLocal.GetObjectID: Pointer;
begin
  Result := FObjectID;
end;

function TOCLocal.GetObjectiveCClass: PTypeInfo;
begin
  Result := nil;
end;

function TOCLocal.GetSuper: IObjectiveCInstance;
var
  SuperVTable: TOCVTable;
  SuperImport: TOCImport;
  ClassInfo: TRegisteredDelphiClass;
  OCTypeInfo: PTypeInfo;
begin
  if not Assigned(FSuper) then
  begin
    OCTypeInfo := GetObjectiveCClass;
{$IFDEF DEBUGUTILS}
    TDebugUtils.DebugPrint('oc.super', 'Setting up super class for ''%s''', [string(OCTypeInfo^.NameFld.ToString)]);
    TDebugUtils.DebugPrint('oc.super', '  Pascal class is ''%s''', [Self.ClassName]);
{$ENDIF}
    SuperVTable := TVTableCache.GetSuperVTable(OCTypeInfo);
    ClassInfo := TRegisteredDelphiClass.GetRegisteredClass(Self.ClassType.ClassInfo);
    SuperImport := TOCImport.Create(FObjectID, ClassInfo.SuperClassID, SuperVTable);
    if SuperImport.QueryInterface(IID_IObjectiveCInstance, FSuper) <> 0 then
      raise EObjectiveC.CreateResFmt(@SInternalBindingError, [Self.ClassName]);
  end;
  Result := FSuper;
end;

procedure TOCLocal.UpdateObjectID(Val: Pointer);
begin
  if Val <> FObjectID then
  begin
    FObjectID := Val;
    FSuper := nil;
  end;
end;

constructor TOCLocal.Create;
var
  CType: PTypeInfo;
  Reg: TRegisteredDelphiClass;
begin
  CType := PTypeInfo(Self.ClassType.ClassInfo);
  Reg := TRegisteredDelphiClass.RegisterClass(CType, GetObjectiveCClass);
  FObjectID := Reg.CreateObj(Self);
{$IFDEF DEBUGUTILS}
  TDebugUtils.DebugPrint('oc.local.create', 'Created instance of ''%s'' ObjID = 0x%x',
             [Self.ClassName, IntPtr(FObjectID)]);
{$ENDIF}
  if not Assigned(FObjectID) then
    raise EObjectiveC.CreateResFmt(@SErrorCreatingOCObject, [string(CType^.NameFld.ToString)]);
end;

destructor TOCLocal.Destroy;
begin
                              
{$IFDEF DEBUGUTILS}
  TDebugUtils.DebugPrint('oc.local.destroy', 'Destroying instance of ''%s'' ObjID = 0x%x',
    [Self.ClassName, IntPtr(FObjectID)]);
{$ENDIF}
  inherited Destroy;
end;

procedure RegisterObjectiveCClass(Cls: TClass; Implementing: PTypeInfo);
var
  CType: PTypeInfo;
begin
  CType := PTypeInfo(Cls.ClassInfo);
  TRegisteredDelphiClass.RegisterClass(CType, Implementing);
end;

end.

