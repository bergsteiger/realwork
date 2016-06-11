{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Presentation.Factory;

interface

{$SCOPEDENUMS ON}

uses
  System.Generics.Collections, System.SysUtils, FMX.Controls.Presentation, FMX.Controls;

type

  { TPresentationProxyFactory }

  /// <summary>Base class of exception for group exception in <c>TPresentationProxyFactory</c></summary>
  EPresentationProxy = class(Exception);

  /// <summary>Dictionary type for storing pair class of Presentation Proxy and presentation name</summary>
  TPresentationDictionary = TDictionary<string, TPresentationProxyClass>;

  /// <summary>Factory for creating presentation prxoy of control by presentation name</summary>
  TPresentationProxyFactory = class
  private
    FPresentations: TPresentationDictionary;
    class var FCurrent: TPresentationProxyFactory;
    class function GetCurrent: TPresentationProxyFactory; static;
    function NormalizePresentationName(const APresentationName: string): string;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>Destroys default factory. See a <c>TPresentationProxyFactory.Current</c></summary>
    class destructor DestroyDefault;
    /// <summary>Generates presentation name for specified control's class and type.</summary>
    class function GeneratePresentationName(const AControlClass: TClass; const AControlType: TControlType): string;

    { Registration }
    /// <summary>Tries to register presentation proxy class with specified name. If factory already has presentation proxy
    /// with the same name, it will rise exception <c>EPresentationProxy</c></summary>
    procedure Register(const APresentationName: string; const APresentationProxyClass: TPresentationProxyClass); overload;
    /// <summary>Tries to register presentation proxy class with specified control class and control type.
    /// If factory already has presentation proxy with the same name, it will rise exception
    /// <c>EPresentationProxy</c></summary>
    procedure Register(const AControlClass: TClass; const AControlType: TControlType;
      const APresentationProxyClass: TPresentationProxyClass); overload;
    /// <summary>Unregisters specified presentation proxy class by name</summary>
    procedure Unregister(const APresentationName: string); overload;
    /// <summary>Unregisters specified presentation proxy class by name and presentation proxy class.</summary>
    procedure Unregister(const APresentationName: string; const APresentationProxyClass: TPresentationProxyClass); overload;
    /// <summary>Unregisters specified presentation proxy class by control class and control type.</summary>
    procedure Unregister(const AControlClass: TClass; const AControlType: TControlType); overload;
    /// <summary>Unregisters specified presentation proxy class by control class, control type and presentation proxy class.</summary>
    procedure Unregister(const AControlClass: TClass; const AControlType: TControlType;
      const APresentationProxyClass: TPresentationProxyClass); overload;
    /// <summary>Replaces existing presentation proxy class with a new by name</summary>
    procedure Replace(const APresentationName: string; const APresentationProxyClass: TPresentationProxyClass); overload;
    /// <summary>Replaces existing presentation proxy class with a new by control class and control type</summary>
    procedure Replace(const AControlClass: TClass; const AControlType: TControlType; const APresentationProxyClass: TPresentationProxyClass); overload;
    /// <summary>Returns True if factory has presentation proxy with specified name. Returns False otherwise.</summary>
    function Supported(const APresentationName: string): Boolean; overload;
    /// <summary>Returns True if factory has presentation proxy with specified name. Returns False otherwise.</summary>
    function Supported(const AControlClass: TClass; const AControlType: TControlType): Boolean; overload;

    { Creation }
    /// <summary>Creates instance of presentation proxy by specified name and casts to specified type <c>T</c>.</summary>
    /// <remarks>If factory doesn't have specified presentation proxy, it will rise <c>EPresentationProxy</c>
    /// exception. If type <c>T</c> is not compatible with found presentation proxy class, It will return nil.</remarks>
    function CreatePresentationProxy<T: TPresentationProxy>(const APresentationName: string): T;
    /// <summary>Try to find presentation proxy class by specified name. If factory doesn't have presentation,
    /// it will return nil.</summary>
    function FindPresentationProxyClass(const APresentationName: string): TPresentationProxyClass;
  public
    /// <summary>Default presentations factory. It is singleton</summary>
    class property Current: TPresentationProxyFactory read GetCurrent;
    /// <summary>Returns dictionary of all registered notification names and them presentation Proxies</summary>
    property Presentations: TPresentationDictionary read FPresentations;
  end;

implementation

uses
  FMX.Types, FMX.Consts {$IFDEF MACOS}, Macapi.CoreFoundation{$ENDIF};

{ TPresentationProxyFactory }

constructor TPresentationProxyFactory.Create;
begin
  FPresentations := TPresentationDictionary.Create;
end;

function TPresentationProxyFactory.CreatePresentationProxy<T>(const APresentationName: string): T;
var
  PresentationClass: TPresentationProxyClass;
begin
  if FPresentations.TryGetValue(NormalizePresentationName(APresentationName), PresentationClass) then
    Result := PresentationClass.Create as T
  else
    raise EPresentationProxy.Create(Format(SPresentationProxyClassNotFound, [APresentationName]));
end;

class destructor TPresentationProxyFactory.DestroyDefault;
begin
  FreeAndNil(FCurrent);
end;

destructor TPresentationProxyFactory.Destroy;
begin
  FPresentations.Free;
  inherited;
end;

function TPresentationProxyFactory.FindPresentationProxyClass(const APresentationName: string): TPresentationProxyClass;
var
  ImplementorClass: TPresentationProxyClass;
begin
  if FPresentations.TryGetValue(NormalizePresentationName(APresentationName), ImplementorClass) then
    Result := ImplementorClass
  else
    Result := nil;
end;

class function TPresentationProxyFactory.GeneratePresentationName(const AControlClass: TClass;
  const AControlType: TControlType): string;
begin
  if AControlClass = nil then
    raise EPresentationProxy.Create(SControlClassIsNil);
  Result := Format('%s-%s', [AControlClass.ClassName.Substring(1), AControlType.ToString]);
end;

class function TPresentationProxyFactory.GetCurrent: TPresentationProxyFactory;
begin
  if FCurrent = nil then
    FCurrent := TPresentationProxyFactory.Create;
  Result := FCurrent;
end;

procedure TPresentationProxyFactory.Register(const APresentationName: string;
  const APresentationProxyClass: TPresentationProxyClass);
begin
  if APresentationProxyClass = nil then
    raise EPresentationProxy.Create(SPresentationProxyClassIsNil);
  if NormalizePresentationName(APresentationName).IsEmpty then
    raise EPresentationProxy.Create(SPresentationProxyNameIsEmpty);
  if Supported(APresentationName) then
    raise EPresentationProxy.CreateFmt(SPresentationAlreadyRegistered, [APresentationProxyClass.ClassName,
      APresentationName]);

  FPresentations.Add(NormalizePresentationName(APresentationName), APresentationProxyClass);
end;

procedure TPresentationProxyFactory.Register(const AControlClass: TClass; const AControlType: TControlType;
  const APresentationProxyClass: TPresentationProxyClass);
begin
  Register(GeneratePresentationName(AControlClass, AControlType), APresentationProxyClass);
end;

procedure TPresentationProxyFactory.Replace(const AControlClass: TClass; const AControlType: TControlType;
  const APresentationProxyClass: TPresentationProxyClass);
begin
  Replace(GeneratePresentationName(AControlClass, AControlType), APresentationProxyClass);
end;

procedure TPresentationProxyFactory.Replace(const APresentationName: string;
  const APresentationProxyClass: TPresentationProxyClass);
begin
  if APresentationProxyClass = nil then
    raise EPresentationProxy.Create(SPresentationProxyClassIsNil);
  if NormalizePresentationName(APresentationName).IsEmpty then
    raise EPresentationProxy.Create(SPresentationProxyNameIsEmpty);

  Unregister(APresentationName);
  Register(APresentationName, APresentationProxyClass);
end;

function TPresentationProxyFactory.Supported(const AControlClass: TClass; const AControlType: TControlType): Boolean;
begin
  if AControlClass <> nil then
    Result := Supported(GeneratePresentationName(AControlClass, AControlType))
  else  
    Result := False;
end;

function TPresentationProxyFactory.Supported(const APresentationName: string): Boolean;
begin
  Result := FPresentations.ContainsKey(NormalizePresentationName(APresentationName));
end;

procedure TPresentationProxyFactory.Unregister(const AControlClass: TClass; const AControlType: TControlType);
begin
  if AControlClass <> nil then
    Unregister(GeneratePresentationName(AControlClass, AControlType));
end;

procedure TPresentationProxyFactory.Unregister(const APresentationName: string;
  const APresentationProxyClass: TPresentationProxyClass);
var
  ImplementorClass: TPresentationProxyClass;
begin
  ImplementorClass := FindPresentationProxyClass(APresentationName);
  if ImplementorClass = APresentationProxyClass then
    Unregister(APresentationName);
end;

procedure TPresentationProxyFactory.Unregister(const APresentationName: string);
begin
  FPresentations.Remove(NormalizePresentationName(APresentationName));
end;

procedure TPresentationProxyFactory.Unregister(const AControlClass: TClass; const AControlType: TControlType;
  const APresentationProxyClass: TPresentationProxyClass);
begin
  if AControlClass <> nil then
    Unregister(GeneratePresentationName(AControlClass, AControlType), APresentationProxyClass);
end;

function TPresentationProxyFactory.NormalizePresentationName(const APresentationName: string): string;
begin
  Result := APresentationName.Trim.ToLower;
end;

end.
