{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Bindings.Evaluator;

interface

uses
  System.SysUtils, System.Rtti, System.Character, System.Generics.Collections,
  System.Bindings.EvalProtocol, System.Bindings.Consts;

/// <summary>Compiles an expression. The expression can be evaluated only
/// after it has been compiled.</summary>
/// <param name="Source">The source of the expression that is going to be compiled.</param>
/// <param name="RootScope">The scope that will be searched for built-in
/// operators and other global symbols that can be used inside an expression.
/// If it is not nil, the compiler will add to it wrappers for the tokens in the
/// expression.</param>
/// <returns>An interface that can be used to evaluate the compiled expression.</returns>
function Compile(const Source: string; const RootScope: IScope = nil): ICompiledBinding;

type
  /// <summary>Enumeration for built-in operators. It is used internally by
  /// the expression compiler.</summary>
  TBuiltinOp = (boAdd, boSubtract, boMultiply, boDivide, boNegate,
    boEqualTo, boNotEqual, boLessThan, 
    boLessEqual, boGreaterThan, boGreaterEqual);

const
  /// <summary>These names are looked up in the root scope at evaluation time.
  /// They designate the names for the built-in operators.</summary>
  BuiltinOpName: array[TBuiltinOp] of string = (
    '$add', '$subtract', '$multiply', '$divide', '$negate',
    '$equalto', '$notequal', '$lessthan',
    '$lessequal', '$greaterthan', '$greaterequal'
  );

var
  EvalFormatSettings: TFormatSettings;

implementation

uses
  System.Bindings.Search;

const
                                                                          
  SelfIdentifier = 'SELF';

type
  // An ultra-simple stack machine for evaluating expressions, only 7 operations.
  TCompiledBinding = class(TInterfacedObject, ICompiledBinding, ICompiledBindingWrappers,
    IDebugBinding)
  private type
    TOp = (
       opReturn { return tos }
      ,opPush { 1 op arg (value), -> value }
      ,opPop { value -> } // not currently used; use to eval exprs in stmt context without growing the stack
      ,opLookup { 1 op arg (name), scope -> value }
      ,opLookupRoot { 1 op arg (name), -> value }
      ,opLookupGroup { 1 op arg (int order), -> value }
      ,opInvokeIndirect { 1 op arg (argCount), invokable args... -> returnValue }
      ,opInvokeDirect { 2 op args (name, argCount), args... -> returnValue }
      // consider adding conditional jump for "if"
      );
  private const
    OpArgCount: array[TOp] of Integer = (
      // return, push, pop, lookup, lookuproot, lookupgroup, invokeindirect invokedirect
      0, 1, 0, 1, 1, 1, 1, 2
    );
  private
    FWrappers: TWrapperDictionary;
    FComplete: Boolean; // true when all the wrappers have been gathered in the dictionary
    FPhase: TCompiledBindingPhaseType;
    FConstCount: Integer;
    FOpCount: Integer;
    // constant table; is indexed by arguments to operators
    FConsts: TArray<TValue>;
    FOps: TArray<Byte>;
    function AddConst(const AValue: TValue): Word;
    procedure AddOp(AOp: TOp);
    procedure AddOpArg(AOp: TOp; Arg: Word);
    procedure AddOpValue(AOp: TOp; Val: TValue);
    procedure AddOpArg2(AOp: TOp; Arg1, Arg2: Word);

    // collects the subwrappers of the dynamic instances and adds them to the
    // dictionary of wrappers for the binding
    procedure CollectDynInstSubWrprs(const StartScopeEnumerable: IScopeEnumerable);

    { ICompiledBinding }
    function GetPhase: TCompiledBindingPhaseType; inline;

    { ICompiledBindingWrappers }
    function GetWrappers: TWrapperDictionary; inline;

    { IDumpBinding }
    procedure Dump(const W: TProc<string>);
  public
    constructor Create;
    destructor Destroy; override;

    { ICompiledBinding }
    function Evaluate(ARoot: IScope;
      ASubscriptionCallback: TSubscriptionNotification;
      {out} Subscriptions: TList<ISubscription>): IValue;

    property Phase: TCompiledBindingPhaseType read GetPhase;

    { ICompiledBindingWrappers }
    property Wrappers: TWrapperDictionary read GetWrappers;
  end;

  // If TEvaluator grows state needed during parsing (like custom operators)
  // then consider moving it into interface section.
  TEvaluator = class
  private type
    // Semantics of TPrio: the Prio argument to ParsePrio is used to determine
    // whether or not to parse the right hand side of a binary operator, or 
    // whether to exit to caller instead. The priority names are chosen
    // such that the comparison used is if <op-prio> <= Prio then Exit 
    // otherwise loop.
    // The value of the Prio argument to ParsePrio is essentially the lowest
    // precedence you *don't* want to parse. So prRelOp would only parse
    // addition, multiplication, dot, etc., because prAddOp > Prio; but
    // it wouldn't parse relational operators (<, > etc.) because 
    // prRelOp <= Prio.
    // The reason this is done is because it works out nicely in explicit
    // (rather than table-driven) scenarios: to determine whether or not
    // to parse '+' for addition, you would check prAddOp <= Prio; and if
    // you do want to parse it, you recurse with ParsePrio(prAddOp).
    TPrio = (prNon = -1, prTop = 10, prAssign = 20, prRelOp = 30,
      prAddOp = 40, prMulOp = 50, prDotOp = 60);
  private type
    TParser = class
    private type
      // it is important that the tokens that form pairs, such as <tkLParen, tkRParen>
      // or <tkLBracket, tkRBracket>, are declared consecutively
      TToken = (tkEof, tkIdent, tkInteger, tkFloat, tkString,
        tkPlus, tkMinus, tkAsterisk, tkSlash,
        tkEqualTo, tkNotEqual, tkLessThan, tkGreaterThan, 
        tkLessEqual, tkGreaterEqual,
        tkLParen, tkRParen, tkLBracket, tkRBracket,
        tkDot, tkComma, tkSemicolon, tkAssign);
    private
      FSource: string;
      FCurrPos: PChar;
      FCurrTok: TToken;
      FStringToken: string;
      FIntegerToken: Int64;
      FFloatToken: Extended;
      FBinding: TCompiledBinding; // permits generation of intermediate code during parsing
      FRootScope: IScope;
      FScopeStack: TStack<IScope>;
      FInvalidScope: Boolean;

      function GetTopScope: IScope;

      // returns the name of a given token type
      class function TokenName(Tok: TToken): string;
      // it implements the lexer for the parser
      procedure NextToken;
      procedure Expect(Tok: TToken);
      procedure Eat(Tok: TToken);
      function SkipIf(Tok: TToken): Boolean;

      // the parser engine
      procedure ParsePrio(Prio: TPrio; Skip: Boolean = False);

      // adds a wrapper in TopScope for Name by generating a lookup on the
      // current scope; if the top scope is nil, it returns nil;
      // if the underlying of top scope has a physical representation for
      // an entity (property or method) designated by Name, it returns the
      // wrapper for it; it adds the wrapper only if InvalidScope is False
      function EnsureWrapper(const Name: String): IInterface;
      // clears the scope stack and puts the root scope in it
      procedure InitScopeStack;
      // pops scopes until the top scope becomes Scope; if Scope is not found
      // among the stack, the only root scope remains in the stack
      procedure PopUntil(const Scope: IScope);
      // pops the rootscope that is pushed to save the indexes of an indexed property
      // or the parameters of a function
      procedure PopParamScope;
      // checks if Wrapper has a scope and if so, it pushes it on the stack and
      // returns True; otherwise it does nothing and returns False
      procedure PushWrapperScope(const Wrapper: IInterface);

      // sets the owner binding of the wrappers in StartScope to the current
      // compiled binding in a depth-first manner
      procedure UpdateWrappersBinding(const StartScopeEnumerable: IScopeEnumerable);

      // the scope attached to the compiler
      property RootScope: IScope read FRootScope;
      // a stack of scopes with the first element being RootScope; if RootScope
      // is nil, this property is nil too
      property ScopeStack: TStack<IScope> read FScopeStack;
      // returns the top of the stack or nil if not available
      property TopScope: IScope read GetTopScope;
    public
      constructor Create(const ASource: string; const RootScope: IScope);
      destructor Destroy; override;

      function Parse: ICompiledBinding;
    end;

  public
    function Compile(const ASource: string; const RootScope: IScope): ICompiledBinding;
  end;

function Compile(const Source: string; const RootScope: IScope = nil): ICompiledBinding;
var
  LEvaluator: TEvaluator;
begin
  LEvaluator := TEvaluator.Create;
  try
    Result := LEvaluator.Compile(Source, RootScope);
  finally
    LEvaluator.Free;
  end;
end;
  
{ TEvaluator.TParser }

function TEvaluator.TParser.EnsureWrapper(const Name: String): IInterface;
var
  LScopeSymbols: IScopeSymbols;
  ScopeSelf: IScopeSelf;
begin
  Result := nil;
  if Assigned(TopScope) then
  begin
    // suppose that Name has a physical representation as a property/method
    // and add it to the scope symbols so that we can later generate the lookup
    if Supports(TopScope, IScopeSymbols, LScopeSymbols) then
      LScopeSymbols.Add(Name);

    if SameText(Name, SelfIdentifier) and Supports(TopScope, IScopeSelf, ScopeSelf) then
      Result := ScopeSelf.GetSelf;
    // check if there is a physical representation for Name in the TopScope
    if Result = nil then
      Result := TopScope.Lookup(Name);

                                                                                        
// the lookup() always generated a wrapper, be it a dynamic group, object wrapper or normal group
    // there is no physical representation for Name; it is wrongly used,
    // so remove it from the scope symbols; the error will be raised at evaluation time
//    if not Assigned(Result) and Assigned(LScopeSymbols) then
//      LScopeSymbols.Remove(Name);
  end;
end;

constructor TEvaluator.TParser.Create(const ASource: string; const RootScope: IScope);
begin
  FSource := ASource;
  FCurrPos := PChar(FSource);
  FBinding := Default(TCompiledBinding);
  FRootScope := RootScope;

  if Assigned(FRootScope) then
  begin
    FScopeStack := TStack<IScope>.Create;
    InitScopeStack;
  end;

  NextToken;
end;

destructor TEvaluator.TParser.Destroy;
begin
  FScopeStack.Free;

  inherited;
end;

procedure TEvaluator.TParser.Eat(Tok: TToken);
begin
  Expect(Tok);
  NextToken;
end;

procedure TEvaluator.TParser.Expect(Tok: TToken);
begin
  if Tok <> FCurrTok then
    raise EEvaluatorError.CreateFmt(sParserUnexpected,
      [TokenName(Tok), TokenName(FCurrTok)]);
end;

function TEvaluator.TParser.GetTopScope: IScope;
begin
  Result := nil;
  if Assigned(ScopeStack) and (ScopeStack.Count > 0) then
    Result := ScopeStack.Peek;
end;

procedure TEvaluator.TParser.InitScopeStack;
begin
  if Assigned(ScopeStack) then
  begin
    ScopeStack.Clear;
    ScopeStack.Push(RootScope);
    FInvalidScope := False;
  end;
end;

procedure SetToken(Self: TEvaluator.TParser; tok: TEvaluator.TParser.TToken; cp: PChar); inline;
begin
  Self.FCurrTok := tok;
  Self.FCurrPos := cp;
end;

procedure TEvaluator.TParser.NextToken;
var
  cp, start: PChar;
begin
  // use local variable so hopefully compiler will use a register
  cp := FCurrPos;

  // handle whitespace and end of file; consider adding comment support here
  while cp^.IsWhiteSpace do
    Inc(cp);
  if cp^ = #0 then
  begin
    FCurrPos := cp;
    FCurrTok := tkEof;
    Exit;
  end;

  // determine token type based on first character
  case cp^ of
    '0'..'9': // number of some kind
    begin
      start := cp;
      Inc(cp);
      while (cp^ >= '0') and (cp^ <= '9') do
        Inc(cp);
      
      if (cp^ <> '.') and (cp^ <> 'e') and (cp^ <> 'E') then
      begin
        SetString(FStringToken, start, cp - start);
        FIntegerToken := StrToInt64(FStringToken);
        SetToken(Self, tkInteger, cp);
        Exit;
      end;
      
      if cp^ = '.' then
      begin
        Inc(cp);
        if not ((cp^ >= '0') and (cp^ <= '9')) then
          raise EEvaluatorError.Create(sInvalidFloatingPt);
        while (cp^ >= '0') and (cp^ <= '9') do
          Inc(cp);
      end;
      
      if (cp^ = 'e') or (cp^ = 'E') then
      begin
        Inc(cp);
        if (cp^ = '-') or (cp^ = '+') then
          Inc(cp);
        if not ((cp^ >= '0') and (cp^ <= '9')) then
          raise EEvaluatorError.Create(sInvalidFloatingPtExpt);
        while (cp^ >= '0') and (cp^ <= '9') do
          Inc(cp);
      end;

      SetString(FStringToken, start, cp - start);
      FFloatToken := StrToFloat(FStringToken, EvalFormatSettings);
      SetToken(Self, tkFloat, cp);
    end;

    'a'..'z', 'A'..'Z', '_': // identifier
    begin
      start := cp;
      Inc(cp);
      while True do
        case cp^ of
          'a'..'z', 'A'..'Z', '_', '0'..'9':
            Inc(cp);
        else
          Break;
        end;
      SetString(FStringToken, start, cp - start);
      SetToken(Self, tkIdent, cp);
    end;

    '''': // string
    begin
      Inc(cp);
      start := cp;
      while True do
      begin
        case cp^ of
          #0:
            raise EEvaluatorError.Create(sUnterminatedString);

          '''':
          begin
            SetString(FStringToken, start, cp - start);
            SetToken(Self, tkString, cp + 1);
            Break;
          end;

        else
          Inc(cp);
        end;
      end;
    end;

    '"': // alt string (easier Pascal embedding)
    begin
      Inc(cp);
      start := cp;
      while True do
      begin
        case cp^ of
          #0:
            raise EEvaluatorError.Create(sUnterminatedString);

          '"':
          begin
            SetString(FStringToken, start, cp - start);
            SetToken(Self, tkString, cp + 1);
            Break;
          end;

        else
          Inc(cp);
        end;
      end;
    end;

    // single-character operators
    '+': SetToken(Self, tkPlus, cp + 1);
    '-': SetToken(Self, tkMinus, cp + 1);
    '*': SetToken(Self, tkAsterisk, cp + 1);
    '/': SetToken(Self, tkSlash, cp + 1);
    '(': SetToken(Self, tkLParen, cp + 1);
    ')': SetToken(Self, tkRParen, cp + 1);
    '[': SetToken(Self, tkLBracket, cp + 1);
    ']': SetToken(Self, tkRBracket, cp + 1);
    '.': SetToken(Self, tkDot, cp + 1);
    ';': SetToken(Self, tkSemicolon, cp + 1);
    ',': SetToken(Self, tkComma, cp + 1);
    '=': SetToken(Self, tkEqualTo, cp + 1);
    '!': SetToken(Self, tkNotEqual, cp + 1);

    // multi-character operators
    ':':
    begin
      if cp[1] <> '=' then
        raise EEvaluatorError.CreateFmt(sInvalidOperator, [cp[0] + cp[1]]);
      SetToken(Self, tkAssign, cp + 2);
    end;

    '<':
      case cp[1] of
        '=': SetToken(Self, tkLessEqual, cp + 2);
        '>': SetToken(Self, tkNotEqual, cp + 2);
      else
        SetToken(Self, tkLessThan, cp + 1);
      end;

    '>':
    begin
      if cp[1] = '=' then
        SetToken(Self, tkGreaterEqual, cp + 2)
      else
        SetToken(Self, tkGreaterThan, cp + 1);
    end;

  else
    raise EEvaluatorError.CreateFmt(sInvalidOperatorNum, [Ord(cp^)]);
  end;
end;

function TEvaluator.TParser.Parse: ICompiledBinding;
var
  RootScopeEnumerable: IScopeEnumerable;
  WrprDict: TWrapperDictionary;
begin
  WrprDict := nil;
  try
    // object instance is used to generate intermediate code during parsing
    FBinding := TCompiledBinding.Create;
    // keep a reference to the binding because in the parsing process the created
    // wrappers will refer the binding with weak references
    Result := FBinding;

    // make the the input wrappers aware of the binding
    FBinding.FPhase := cbpPrepareCompilation;
    if Supports(RootScope, IScopeEnumerable, RootScopeEnumerable) then
      UpdateWrappersBinding(RootScopeEnumerable);

    FBinding.FPhase := cbpCompiling;
    // start compiling the expression
    ParsePrio(prTop);
    FBinding.AddOp(opReturn);

    // the first trache of wrappers is generated after compilation; add these
    // wrappers to the dictionary; the second trache of wrappers consits
    // by the sub-wrappers of the dynamic groups and dynamic instance wrappers;
    // these sub-wrappers will be generated only at evaluation-time
    WrprDict := TBindingSearch.DepthGetWrappers(FRootScope);
    TBindingSearch.CopyWrprs(WrprDict, FBinding.Wrappers);

    // check if the compilation ended correctly
    if FCurrTok <> tkEof then
      raise EEvaluatorError.Create(sExpectedEOF);
  finally
    // the expression is compiled
    FBinding.FPhase := cbpCompiled;
    FBinding := nil;
    WrprDict.Free;
  end;
end;

// Mostly table-driven priority parser for binary operators, and using recursive 
// descent for factors and arguments. Generates RPN code directly.
// It uses what Vaughan Pratt calls "Top Down Operator Precedenc"; ok explanation
// is at Crockford's site: http://javascript.crockford.com/tdop/tdop.html
// It has two nice features: it avoids a lot of recursion that normally needs
// to occur with recursive descent used to specify precedence, and because it's
// table driven with actual values for precedence, it can support custom operators.
procedure TEvaluator.TParser.ParsePrio(Prio: TPrio; Skip: Boolean);

  function ParseArgs(StopTok: TToken): Word;
  var
    count: Integer;
  begin
    count := 0;
    if FCurrTok <> StopTok then
      repeat
        ParsePrio(prAssign);
        PopUntil(RootScope); // get back to the function/array property context

        Inc(count);
      until not SkipIf(tkComma);
    if count > High(Word) then
      raise EEvaluatorError.Create(sTooManyArgs);
    Result := count;
  end;

  procedure ParseFactor(Skip: Boolean);
  var
    LWrapper: IInterface;
    LGroup: IGroup;
    LOrder: Integer;
  begin
    if Skip then
      NextToken;
    case FCurrTok of
      tkIdent:
        begin
          // create a wrapper for the current identifier; if the identifier
          // denotes an indexed property or a method, grab a new result wrapper
          // for it and make its scope the top one
          LGroup := nil;
          LOrder := 0;
          LWrapper := EnsureWrapper(FStringToken);
          if Supports(LWrapper, IGroup, LGroup) then
            LOrder := LGroup.Add(LWrapper);
          PushWrapperScope(LWrapper);

          // generate program code for searching the wrapper; if we deal with a
          // result wrapper, add code to search it in the group
          FBinding.AddOpValue(opLookupRoot, FStringToken);
          if Assigned(LGroup) then
            FBinding.AddOpValue(opLookupGroup, LOrder);
        end;
      tkInteger: FBinding.AddOpValue(opPush, FIntegerToken);
      tkFloat: FBinding.AddOpValue(opPush, FFloatToken);
      tkString: FBinding.AddOpValue(opPush, FStringToken);
      
      tkMinus:
      begin
        // go back on the scope stack to put the other parameter for minus
        // in the scope of the expression
        PopUntil(RootScope);

        // parse the second operand and add the instruction
        ParseFactor(True);
        FBinding.AddOpArg2(opInvokeDirect, 
          FBinding.AddConst(BuiltinOpName[boNegate]), 1); // 1 arg to unary
        Exit; // musn't skip token again
      end;
      
      tkPlus: 
      begin
        ParseFactor(True);
        Exit;
      end;
      
      tkLParen:
      begin
        ParsePrio(prAssign, True);
        Expect(tkRParen);
      end;
    else
      raise EEvaluatorError.Create(sExpectedIdentifier);
    end;
    NextToken;
  end;

const
  BuiltinOpMap: array[TToken] of TBuiltinOp = (
    // tkEof, tkIdent, tkInteger, tkFloat, tkString,
    TBuiltinOp(-1), TBuiltinOp(-1), TBuiltinOp(-1), TBuiltinOp(-1), TBuiltinOp(-1),
    // tkPlus, tkMinus, tkAsterisk, tkSlash,
    boAdd, boSubtract, boMultiply, boDivide,
    // tkEqualTo, tkNotEqual, tkLessThan, tkGreaterThan, 
    boEqualTo, boNotEqual, boLessThan, boGreaterThan,
    // tkLessEqual, tkGreaterEqual,
    boLessEqual, boGreaterEqual,
    // tkLParen, tkRParen, tkLBracket, tkRBracket,
    TBuiltinOp(-1), TBuiltinOp(-1), TBuiltinOp(-1), TBuiltinOp(-1),
    // tkDot, tkComma, tkSemicolon, tkAssign
    TBuiltinOp(-1), TBuiltinOp(-1), TBuiltinOp(-1), TBuiltinOp(-1)
  );
  BuiltinPrio: array[TToken] of TPrio = (
    // tkEof, tkIdent, tkInteger, tkFloat, tkString,
    prNon, prNon, prNon, prNon, prNon,
    // tkPlus, tkMinus, tkAsterisk, tkSlash,
    prAddOp, prAddOp, prMulOp, prMulOp,
    // tkEqualTo, tkNotEqual, tkLessThan, tkGreaterThan, 
    prRelOp, prRelOp, prRelOp, prRelOp,
    // tkLessEqual, tkGreaterEqual,
    prRelOp, prRelOp,
    // tkLParen, tkRParen, tkLBracket, tkRBracket
    prNon, prNon, prNon, prNon,
    // tkDot, tkComma, tkSemicolon, tkAssign
    prNon, prNon, prNon, prNon
  );
var
  operatorPrio: TPrio;
  builtin: TBuiltinOp;
  tokenPair: TToken;
  LWrapper: IInterface;
  LGroup: IGroup;
  LOrder: Integer;
begin
  ParseFactor(Skip);
  
  while True do
  begin
    operatorPrio := BuiltinPrio[FCurrTok];
    if operatorPrio <> prNon then
    begin
      builtin := BuiltinOpMap[FCurrTok];
      if operatorPrio <= Prio then
        Break;

      // the next operand must be added in the expression scope,
      // no matter it is a function parameter or an array indexer
      PopUntil(RootScope);

      // parse the second operand and add the instruction
      ParsePrio(operatorPrio, True);
      FBinding.AddOpArg2(opInvokeDirect, 
        FBinding.AddConst(BuiltinOpName[builtin]), 2); // 2 arguments to binary
    end
    else
      case FCurrTok of
        tkLParen, tkLBracket: // method / procedure call / indexed property
        begin
          tokenPair := Succ(FCurrTok); // select the appropriate closing paranthesis/bracket
          ScopeStack.Push(RootScope); // the parameters/indexers will be put in the expression scope

          // parse the parameters/indexers of the function/property
          NextToken;
          FBinding.AddOpArg(opInvokeIndirect, ParseArgs(tokenPair));

          PopParamScope; // pop the scopes for the function
          Eat(tokenPair);
        end;

        tkDot:
        begin
          // the next token must be an identifier
          NextToken;
                                                                                                      
          if FCurrTok = tkEof then
            FStringToken := ''
          else
            Expect(tkIdent);

          // create a wrapper for the token; in case the token represents
          // an indexed property or a method, put on the scope stack the
          // scope of a new result wrapper for that token
          LGroup := nil;
          LOrder := 0;
          LWrapper := EnsureWrapper(FStringToken);
          if Supports(LWrapper, IGroup, LGroup) then
            LOrder := LGroup.Add(LWrapper);
          PushWrapperScope(LWrapper);

          // add the program instruction for the identifier; in case we deal
          // with an indexed property or a method, add code to
          FBinding.AddOpValue(opLookup, FStringToken);
          if Assigned(LGroup) then
            FBinding.AddOpValue(opLookupGroup, LOrder);
          NextToken;
        end;
        // can consider handling custom operators here (tkIdent)
      else
        Break;
      end;
  end;
end;

procedure TEvaluator.TParser.PopParamScope;
var
  LRttiChild: IRttiChild;
  LRecordChild: IRecordChild;
  LMember: TRttiMember;
begin
  // pop the previously pushed root scope and pop until you reach
  // the previous context of parameters/indexers (if any)
  ScopeStack.Pop;

  // we need to pop out the scope of the function only if the function didn't have
  // a result type of an object type;
  // wrappers that support only IChild are considered that they can variably return objects
  // because they aren't tied to physical RTTI information
  LMember := nil;
  if Supports(TopScope, IRttiChild, LRttiChild) then
    LMember := LRttiChild.Member
  else
  if Supports(TopScope, IRecordChild, LRecordChild) then
    LMember := LRecordChild.Member;

  if Assigned(LMember) and
     not TBindingSearch.PermitsObjectWrapper(LMember) then
    PopUntil(RootScope);
end;

procedure TEvaluator.TParser.PopUntil(const Scope: IScope);
begin
  if Assigned(ScopeStack) and Assigned(Scope) then
  begin
    while (ScopeStack.Count > 0) and (TopScope <> Scope) do
      ScopeStack.Pop;

    // Scope was not found on the stack; reinitialize the scope stack
    if ScopeStack.Count = 0 then
      InitScopeStack;
  end;
end;

procedure TEvaluator.TParser.PushWrapperScope(const Wrapper: IInterface);
var
  LScope: IScope;
begin
  if Supports(Wrapper, IScope, LScope) then
    ScopeStack.Push(LScope);
end;

function TEvaluator.TParser.SkipIf(Tok: TToken): Boolean;
begin
  Result := FCurrTok = Tok;
  if Result then
    NextToken;
end;

class function TEvaluator.TParser.TokenName(Tok: TToken): string;
const
  TokStr: array[TToken] of string = (
    '<eof>', '<ident>', '<integer>', '<float>', '<string>',
    '"+"', '"-"', '"*"', '"/"', '"="', '"<>"', '"<"', '">"',
    '"<="', '">="', '"("', '")"', '"["', '"]"', '"."', '","', '";"', '":="');
begin
  Result := TokStr[Tok];
end;

procedure TEvaluator.TParser.UpdateWrappersBinding(const StartScopeEnumerable: IScopeEnumerable);
var
  ScopeEnumerable: IScopeEnumerable;
  WrapperBinding: IWrapperBinding;
  Wrapper: IInterface;
begin
  if Assigned(StartScopeEnumerable) then
    for Wrapper in StartScopeEnumerable do
    begin
      // set the owner binding of the wrapper to the current compiled binding
      if Supports(Wrapper, IWrapperBinding, WrapperBinding) then
        WrapperBinding.SetBinding(FBinding);
      // the wrapper contains sub-wrappers, so go in-depth
      if Supports(Wrapper, IScopeEnumerable, ScopeEnumerable) then
        UpdateWrappersBinding(ScopeEnumerable);
    end;
end;

{ TEvaluator }

function TEvaluator.Compile(const ASource: string; const RootScope: IScope): ICompiledBinding;
var
  Parser: TParser;
begin
  Parser := TParser.Create(ASource, RootScope);
  try
    Result := Parser.Parse;
  finally
    Parser.Free;
  end;
end;

{ TCompiledBinding }

function TCompiledBinding.AddConst(const AValue: TValue): Word;
begin
  // consider duplicate constant detection and elimination
  if FConstCount = High(Word) then
    raise EEvaluatorError.Create(sExpressionTooComplex);
  if FConstCount = Length(FConsts) then
    SetLength(FConsts, Length(FConsts) * 2);
  FConsts[FConstCount] := AValue;
  Result := Word(FConstCount);
  Inc(FConstCount);
end;

procedure TCompiledBinding.AddOp(AOp: TOp);
begin
  if FOpCount = Length(FOps) then
    SetLength(FOps, Length(FOps) * 2);
  FOps[FOpCount] := Ord(AOp);
  Inc(FOpCount);
end;

procedure TCompiledBinding.AddOpArg(AOp: TOp; Arg: Word);
begin
  if FOpCount + SizeOf(Word) >= Length(FOps) then
    SetLength(FOps, Length(FOps) * 2);
  FOps[FOpCount] := Ord(AOp);
  PWord(@FOps[FOpCount + 1])^ := Arg;
  Inc(FOpCount, 1 + SizeOf(Word));
end;

procedure TCompiledBinding.AddOpArg2(AOp: TOp; Arg1, Arg2: Word);
begin
  while FOpCount + SizeOf(Word) * 2 >= Length(FOps) do
    SetLength(FOps, Length(FOps) * 2);
  FOps[FOpCount] := Ord(AOp);
  PWord(@FOps[FOpCount + 1])^ := Arg1;
  PWord(@FOps[FOpCount + 1 + SizeOf(Word)])^ := Arg2;
  Inc(FOpCount, 1 + SizeOf(Word) * 2);
end;

procedure TCompiledBinding.AddOpValue(AOp: TOp; Val: TValue);
begin
  AddOpArg(AOp, AddConst(Val));
end;

procedure TCompiledBinding.CollectDynInstSubWrprs(const StartScopeEnumerable: IScopeEnumerable);
var
  Wrpr: IInterface;
  WrprScope: IScope;
  WrprEnumerable: IScopeEnumerable;
  WrprDict: TWrapperDictionary;
begin
  WrprDict := nil;
  if Assigned(StartScopeEnumerable) then
    for Wrpr in StartScopeEnumerable do
      // walk depth-first the dynamic instance and add to the Wrappers dictionary
      // all its subwrappers
      if Supports(Wrpr, IDynamicInstance) and Supports(Wrpr, IScope, WrprScope) then
        try
          WrprDict := TBindingSearch.DepthGetWrappers(WrprScope);
          TBindingSearch.CopyWrprs(WrprDict, FWrappers);
        finally
          WrprDict.Free;
        end
      else // walk the wrappers until we find a dynamic instance wrapper
        if Supports(Wrpr, IScopeEnumerable, WrprEnumerable) then
          CollectDynInstSubWrprs(WrprEnumerable);
end;

constructor TCompiledBinding.Create;
begin
  SetLength(FOps, 4); // need at least 3 for growth in AddOpArg
  SetLength(FConsts, 4);

  FPhase := cbpEmpty;
  FWrappers := TWrapperDictionary.Create;
end;

destructor TCompiledBinding.Destroy;
begin
  FWrappers.Free;

  inherited;
end;

procedure TCompiledBinding.Dump(const W: TProc<string>);
var
  i: Integer;
const
  OpNames: array[TOp] of string = (
    'return',
    'push', { 1 op arg (value), -> value }
    'pop',
    'lookup', { 1 op arg }
    'lookuproot', { 1 op arg }
    'lookupgroup', { 1 op arg }
    'invokeindirect', { 1 op arg }
    'invokedirect' { 2 op args }
  );
begin
  W('Constant table:');
  for i := 0 to FConstCount - 1 do
    W(Format('  %d: %s', [i, FConsts[i].ToString]));
  
  W('Program body:');
  i := 0;
  while i < FOpCount do
  begin
    case OpArgCount[TOp(FOps[i])] of
      0: W(Format('  %d: %s', [i, OpNames[TOp(FOps[i])]]));
      1: W(Format('  %d: %s %d', [i, OpNames[TOp(FOps[i])], 
        PWord(@FOps[i + 1])^]));
      2: W(Format('  %d: %s %d %d', [i, OpNames[TOp(FOps[i])], 
        PWord(@FOps[i + 1])^, PWord(@FOps[i + 1 + SizeOf(Word)])^]));
    end;
    Inc(i, 1 + OpArgCount[TOp(FOps[i])] * SizeOf(Word));
  end;
end;

function TCompiledBinding.Evaluate(
  ARoot: IScope;
  ASubscriptionCallback: TSubscriptionNotification;
  Subscriptions: TList<ISubscription>): IValue;
var
  stack: TArray<IInterface>;
  tos, ip: Integer;
  op: TOp;
  shouldSubscribe: Boolean;

  function PopValue: IInterface;
  begin
    if tos < 0 then
      raise EEvaluatorError.Create(sEvalStackOverflow);
    Result := stack[tos];
    Dec(tos);
  end;
  
  procedure PushValue(const AValue: IInterface);
  var
    subs: ISubscribable;
  begin
   Inc(tos);
    if tos >= Length(stack) then
      raise EEvaluatorError.Create(sEvalStackOverflow);
    stack[tos] := AValue;
    if shouldSubscribe and Supports(AValue, ISubscribable, subs) then
      Subscriptions.Add(subs.Subscribe(ASubscriptionCallback));
  end;

  function PopArgs(Count: Integer): TArray<IValue>;
  begin
    SetLength(Result, Count);
    // args pushed from left to right => PopValue from right to left
    while count > 0 do
    begin
      Dec(count);
      Result[count] := PopValue as IValue;
    end;
  end;

  function Lookup(const Value: IInterface; const Name: string): IInterface; overload;
  var
    scope: IScope;
    scopeSelf: IScopeSelf;
  begin
    if (SameText(Name, SelfIdentifier)) and Supports(Value, IScopeSelf, scopeSelf) then
    begin
      Result := scopeSelf.GetSelf;
      if Result <> nil then
        Exit;
    end;
    if Supports(Value, IScope, scope) then
    begin
      Result := scope.Lookup(Name);
      if Result <> nil then
        Exit;
    end;
    raise EEvaluatorError.CreateFmt(sLookupError, [Name]);
  end;

  function Lookup(const Value: IInterface; Order: Integer): IInterface; overload;
  var
    LGroup: IGroup;
  begin
    if Supports(Value, IGroup, LGroup) then
      Result := LGroup.Wrappers[Order]
    else
      raise EEvaluatorError.Create(sUnsupportedGroup);
  end;

  function Invoke(const Value: IInterface; const Args: TArray<IValue>): IValue;
  var
    LInvokable: IInvokable;
    LArguments: IArguments;
  begin
    if not Supports(Value, IInvokable, LInvokable) and
       not Supports(Value, IArguments, LArguments) then
      raise EEvaluatorError.Create(sInvokeError);

    if Assigned(LInvokable) then
      Result := LInvokable.Invoke(Args)
    else
    begin
      if not Supports(Value, IValue, Result) then
        raise EEvaluatorError.Create(sUnsupportedWrapper);

      // setting the arguments for the indexed property will make the GetValue
      // routine of IValue to return the correct result
      LArguments.SetArgs(AdaptArguments(Args));
    end;
  end;

var
  RootEnumerable: IScopeEnumerable;
  args: array[0..1] of Integer;
  i: Integer;
  LArray: TArray<IValue>;
begin
  try
    try
      if FOpCount = 0 then
        Exit(nil);

      // prepare the wrappers for a new evaluation
      FPhase := cbpPrepareEvaluation;
      if Supports(ARoot, IScopeEnumerable, RootEnumerable) then
        TBindingSearch.PrepareWrappersForEvaluation(RootEnumerable);

      // check if there are any subscriptions
      shouldSubscribe := (@ASubscriptionCallback <> nil) and (Subscriptions <> nil);

      // start evaluation
      FPhase := cbpEvaluating;
      SetLength(stack, 32);
      tos := -1;
      ip := 0;
      while (ip >= 0) and (ip < FOpCount) do
      begin
        op := TOp(FOps[ip]);
        Inc(ip);
        for i := 0 to OpArgCount[op] - 1 do
        begin
          args[i] := PWord(@FOps[ip])^;
          Inc(ip, SizeOf(Word));
        end;

        case op of
          opReturn: Exit(PopValue as IValue);
          opPush: PushValue(TValueWrapper.Create(FConsts[args[0]]));
          opPop: PopValue;
          opLookup: PushValue(Lookup(PopValue, FConsts[args[0]].AsString));
          opLookupRoot: PushValue(Lookup(ARoot, FConsts[args[0]].AsString));
          opLookupGroup: PushValue(Lookup(PopValue, FConsts[args[0]].AsInteger));
          opInvokeIndirect:
          begin
            LArray := PopArgs(args[0]);
            PushValue(Invoke(PopValue, LArray));
          end;
          opInvokeDirect: PushValue(Invoke(Lookup(ARoot, FConsts[args[0]].AsString), PopArgs(args[1])));
        end;
      end;
    except
      on Exception do
      begin
        FPhase := cbpEvaluationError;
        raise;
      end;
    end;
  finally
    if FPhase <> cbpEvaluationError then
    begin
      // the dictionary of wrappers is completed after the first successfull
      // evaluation; because there may be dynamic groups and dynamic instances
      // that connect to their fixed groups and fixed instances only after
      // the first evaluation
      if not FComplete then
      begin
        CollectDynInstSubWrprs(RootEnumerable);
        FComplete := True;
      end;

      FPhase := cbpEvaluated;
    end;
  end;
end;

function TCompiledBinding.GetPhase: TCompiledBindingPhaseType;
begin
  Result := FPhase;
end;

function TCompiledBinding.GetWrappers: TWrapperDictionary;
begin
  Result := FWrappers;
end;

initialization
  // Use '.' decimal separator when parsing literals
  EvalFormatSettings := TFormatSettings.Create('en-US');
end.
