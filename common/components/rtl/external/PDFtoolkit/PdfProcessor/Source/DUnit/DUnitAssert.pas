unit DUnitAssert;
// Assert extension for DUnit
// (c) 2007  Tiriss - http://www.tiriss.com
//
// VERSION: V1.1
//
// PURPOSE
// Assert for DUnit allows to use the (NUnit) Assert.AreEqual etc. syntax to be used in Delphi's DUnit
// It was created to
// * make switching between (C#).Net and Delphi easier
// * be able to only learn one syntax.
//
// HOME
// http://www.tiriss.com/AssertForDUnit
//
// LICENSE
// This sourcecode is free software. It comes without any warranty, to the extent permitted by applicable law.
// You can redistribute it and/or modify it under the term that you keep a clear reference to its original home
// (http://www.tiriss.com/AssertForDUnit)
//
// ADDITIONS
// This is still a work in progress (like most software), the TDunitAssert class is far from complete
// If you have additions, and would like them to be considered to be added, then please send them to tiriss@tiriss.com

interface

uses
  TestFramework;

//compatibility with previous Delphi versions
// todo check Delphi versions other then 5,7 & 2007
{$IFDEF CONDITIONALEXPRESSIONS}
  {$IF COMPILERVERSION >= 17}
    {$DEFINE INLINES}
    {$DEFINE DEPRECATED} 
  {$IFEND}
{$ENDIF}

{$IFDEF VER130} // Delphi 5 doesn't have IInterface yet
type
  IInterface = IUnknown;
{$ELSE}
  {$IFNDEF VER140}
    //{$DEFINE DEPRECATED} // deprecated is in D7 and up, but even gives compile warning on implementation!
  {$ENDIF}
{$ENDIF}

type
  /// <summary>
  /// TDunitAssert is a Compatibility class to be able to use Assert (like C#) instead of Check
  /// By defining string as const and using inline we have (almost) no overhead for this!
  /// For example: overhead is 1 instruction/4 bytes for the IsTrue case
    /// </summary>
  TDunitAssert = class
  private
    FTestCase: TTestCase;
  protected
    property TestCase: TTestCase read FTestCase;
  public
    constructor Create(aTestCase: TTestCase);
    procedure AreEqual(aExpected, aActual: Boolean; const aMessage: string = ''); overload; {$IFDEF USEINLINE}inline;{$ENDIF}
    procedure AreEqual(aExpected, aActual : Extended; delta : Extended; const aMessage : string = ''); overload; {$IFDEF USEINLINE}inline;{$ENDIF}
    procedure AreEqual(aExpected, aActual: Extended; const aMessage: string = ''); overload; {$IFDEF USEINLINE}inline;{$ENDIF}
    procedure AreEqual(aExpected, aActual: Integer; const aMessage: string = ''); overload; {$IFDEF USEINLINE}inline;{$ENDIF}
    procedure AreEqual(const aExpected, aActual: string; const aMessage: string = ''); overload; {$IFDEF USEINLINE}inline;{$ENDIF}
    procedure AreEqual(aExpected, aActual: TClass; const aMessage: string = ''); overload; {$IFDEF USEINLINE}inline;{$ENDIF}
    procedure AreEqual(aExpected, aActual: WideString; const aMessage: string = ''); overload; {$IFDEF USEINLINE}inline;{$ENDIF}
    procedure AreSame(aExpected, aActual: IInterface; const aMessage: string = ''); overload; {$IFDEF USEINLINE}inline;{$ENDIF}
    procedure AreSame(aExpected, aActual: TObject; const aMessage: string = ''); overload; {$IFDEF USEINLINE}inline;{$ENDIF}
    procedure IsTrue(aCondition: Boolean; const aMessage: string=''); {$IFDEF USEINLINE}inline;{$ENDIF}
    procedure IsFalse(aCondition: Boolean; const aMessage: string=''); {$IFDEF USEINLINE}inline;{$ENDIF}
    procedure IsNotNull(aObj: TObject; const aMessage: string=''); overload; {$IFDEF USEINLINE}inline;{$ENDIF}
    procedure IsNotNull(aObj: IInterface; const aMessage: string=''); overload; {$IFDEF USEINLINE}inline;{$ENDIF}
    procedure IsNull(aObj: TObject; const aMessage: string=''); overload; {$IFDEF USEINLINE}inline;{$ENDIF}
    /// <summary>
    /// AreEqualString is for earlier Delphi versions that give "Ambiguous overloaded call to 'CheckEquals'"
    /// </summary>
    procedure AreEqualString(const aExpected, aActual: string; const aMessage: string = ''); overload; {$IFDEF DEPRECATED}deprecated;{$ENDIF}{$IFDEF USEINLINE}inline;{$ENDIF}
    /// <summary>
    /// AreEqualWideString is for earlier Delphi versions that give "Ambiguous overloaded call to 'CheckEquals'"
    /// </summary>
    procedure AreEqualWideString(const aExpected, aActual: WideString; const aMessage: string = ''); overload; {$IFDEF DEPRECATED}deprecated;{$ENDIF}{$IFDEF USEINLINE}inline;{$ENDIF}
    procedure IsNull(aObj: IInterface; const aMessage: string=''); overload; {$IFDEF USEINLINE}inline;{$ENDIF}
  end;

  {$M+}
  /// <summary>
  /// Compatibility class to be able to use Assert instead of Check
  /// inherit your test class from this to be able to use the Assert syntax
  /// </summary>
  TAssertTestCase = class(TTestCase)
  private
    FAssert: TDunitAssert;
  protected
    /// <summary>
    /// CreateAssert allows descendant to create their own (extended) TDunitAssert class
    /// </summary>
    /// <returns> TDUnitAssert
    /// </returns>
    function CreateAssert: TDUnitAssert; virtual;
  public
    constructor Create(MethodName: string); override;
    destructor Destroy; override;
    property Assert: TDunitAssert read FAssert;
  end;
  {$M-}

implementation

uses SysUtils;

{ TDUnitAssert }

constructor TDunitAssert.Create(aTestCase: TTestCase);
begin
  FTestCase := aTestCase;
end;

procedure TDunitAssert.AreEqual(aExpected, aActual: Boolean; const aMessage: string = '');
begin
  FTestCase.CheckEquals(aExpected, aActual, aMessage);
end;

procedure TDunitAssert.AreEqual(aExpected, aActual : Extended; delta : Extended; const aMessage : string = '');
begin
  FTestCase.CheckEquals(aExpected, aActual, delta, aMessage);
end;

procedure TDunitAssert.AreEqual(aExpected, aActual: Extended; const aMessage: string = '');
begin
  FTestCase.CheckEquals(aExpected, aActual, aMessage);
end;

procedure TDunitAssert.AreEqual(aExpected, aActual: Integer; const aMessage: string = '');
begin
  FTestCase.CheckEquals(aExpected, aActual, aMessage);
end;

procedure TDunitAssert.AreEqual(const aExpected, aActual: string; const aMessage: string = '');
begin
  {$IFNDEF VER130}
  FTestCase.CheckEquals(aExpected, aActual, aMessage);
  {$ELSE} // D5
  AreEqualString(aExpected, aActual, aMessage);
  {$ENDIF}
end;

procedure TDunitAssert.AreEqual(aExpected, aActual: TClass; const aMessage: string = '');
begin
  FTestCase.CheckEquals(aExpected, aActual, aMessage);
end;

procedure TDunitAssert.AreEqual(aExpected, aActual: WideString; const aMessage: string = '');
begin
  {$IFNDEF VER130}
  FTestCase.CheckEquals(aExpected, aActual, aMessage);
  {$ELSE} // D5
  AreEqualWideString(aExpected, aActual, aMessage);
  {$ENDIF}
end;

// for Delphi 5 compatibility
procedure TDunitAssert.AreEqualString(const aExpected, aActual: string; const aMessage: string = '');
begin
  if aExpected <> aActual then
    FTestCase.FailNotEquals(aExpected, aActual, aMessage, CallerAddr);
end;

// for Delphi 5 compatibility
procedure TDunitAssert.AreEqualWideString(const aExpected, aActual: WideString; const aMessage: string = '');
begin
  if aExpected <> aActual then
     FTestCase.FailNotEquals(aExpected, aActual, aMessage, CallerAddr);
end;

procedure TDunitAssert.AreSame(aExpected, aActual: IInterface; const aMessage: string = '');
begin
  FTestCase.CheckSame(aExpected, aActual, aMessage);
end;

procedure TDunitAssert.AreSame(aExpected, aActual: TObject; const aMessage: string = '');
begin
  FTestCase.CheckSame(aExpected, aActual, aMessage);
end;

procedure TDunitAssert.IsTrue(aCondition: Boolean; const aMessage: string='');
begin
  FTestCase.CheckTrue(aCondition, aMessage)
end;

procedure TDunitAssert.IsFalse(aCondition: Boolean; const aMessage: string='');
begin
  FTestCase.CheckFalse(aCondition, aMessage)
end;

procedure TDunitAssert.IsNotNull(aObj: TObject; const aMessage: string='');
begin
    FTestCase.CheckNotNull(aObj, aMessage);
end;

procedure TDunitAssert.IsNotNull(aObj: IInterface; const aMessage: string='');
begin
  FTestCase.CheckNotNull(aObj, FTestCase.NotSameErrorMessage('interface', PtrToStr(Pointer(aObj)), aMessage));
end;

procedure TDunitAssert.IsNull(aObj: TObject; const aMessage: string='');
begin
  FTestCase.CheckNull(aObj, aMessage);
end;

procedure TDunitAssert.IsNull(aObj: IInterface; const aMessage: string='');
begin
  FTestCase.CheckNull(aObj, aMessage);
end;

{ TAssertTestCase }

constructor TAssertTestCase.Create(MethodName: string);
begin
  inherited;
  FAssert := CreateAssert;
end;

destructor TAssertTestCase.Destroy;
begin
  FreeAndNil(FAssert);
  inherited;
end;

function TAssertTestCase.CreateAssert: TDUnitAssert;
begin
  Result := TDUnitAssert.Create(Self);
end;


initialization
end.

