{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBCommon;

{$T-,H+,X+,R-}

interface

uses System.Variants, System.SysUtils, System.Classes, Data.DB, Data.SqlTimSt, System.StrUtils;

type
  TCANOperator = (
    coNOTDEFINED,                      {                                   }
    coISBLANK,                         { coUnary;  is operand blank.      }
    coNOTBLANK,                        { coUnary;  is operand not blank.  }
    coEQ,                              { coBinary, coCompare; equal.     }
    coNE,                              { coBinary; NOT equal.             }
    coGT,                              { coBinary; greater than.          }
    coLT,                              { coBinary; less than.             }
    coGE,                              { coBinary; greater or equal.      }
    coLE,                              { coBinary; less or equal.         }
    coNOT,                             { coUnary; NOT                     }
    coAND,                             { coBinary; AND                    }
    coOR,                              { coBinary; OR                     }
    coTUPLE2,                          { coUnary; Entire record is operand. }
    coFIELD2,                          { coUnary; operand is field        }
    coCONST2,                          { coUnary; operand is constant     }
    coMINUS,                           { coUnary;  minus. }
    coADD,                             { coBinary; addition. }
    coSUB,                             { coBinary; subtraction. }
    coMUL,                             { coBinary; multiplication. }
    coDIV,                             { coBinary; division. }
    coMOD,                             { coBinary; modulo division. }
    coREM,                             { coBinary; remainder of division. }
    coSUM,                             { coBinary, accumulate sum of. }
    coCOUNT,                           { coBinary, accumulate count of. }
    coMIN,                             { coBinary, find minimum of. }
    coMAX,                             { coBinary, find maximum of. }
    coAVG,                             { coBinary, find average of. }
    coCONT,                            { coBinary; provides a link between two }
    coUDF2,                            { coBinary; invokes a User defined fn }
    coCONTINUE2,                       { coUnary; Stops evaluating records }
    coLIKE,                            { coCompare, extended binary compare        }
    coIN,                              { coBinary field in list of values }
    coLIST2,                           { List of constant values of same type }
    coUPPER,                           { coUnary: upper case }
    coLOWER,                           { coUnary: lower case }
    coFUNC2,                           { coFunc: Function }
    coLISTELEM2,                       { coListElem: List Element }
    coASSIGN                           { coBinary: Field assignment }
  );

  NODEClass = (                         { Node Class }
    nodeNULL,                           { Null node                   }
    nodeUNARY,                          { Node is a unary             }
    nodeBINARY,                         { Node is a binary            }
    nodeCOMPARE,                        { Node is a compare           }
    nodeFIELD,                          { Node is a field             }
    nodeCONST,                          { Node is a constant          }
    nodeTUPLE,                          { Node is a record }
    nodeCONTINUE,                       { Node is a continue node     }
    nodeUDF,                            { Node is a UDF node }
    nodeLIST,                           { Node is a LIST node }
    nodeFUNC,                           { Node is a Function node }
    nodeLISTELEM                        { Node is a List Element node }
  );

  IDENTIFIEROption = (                  { Identifier handling options              }
    idKeepQuotes,                       { Keep the quotes on the identifier        }
    idMixCase,                          { Allow mix case unquoted identifiers      }
    idMakeLowerCase,                    { Change unquoted identifiers to lowercase }
    idMakeUpperCase                     { Change unquoted identifiers to uppercase }
  );

const
  CANEXPRSIZE        = 10; { SizeOf(CANExpr) }
  CANHDRSIZE         = 8;  { SizeOf(CANHdr) }
  CANEXPRVERSION     = 2;


type
  TExprData = array of Byte;
  TFieldMap = array[TFieldType] of Byte;

{ TFilterExpr }

type

  TParserOption = (poExtSyntax, poAggregate, poDefaultExpr, poUseOrigNames,
                   poFieldNameGiven, poFieldDepend);
  TParserOptions = set of TParserOption;

  TExprNodeKind = (enField, enConst, enOperator, enFunc);
  TExprScopeKind = (skField, skAgg, skConst);

  PExprNode = ^TExprNode;
  TExprNode = record
    FNext: PExprNode;
    FKind: TExprNodeKind;
    FPartial: Boolean;
    FOperator: TCANOperator;
    FData: Variant;
    FLeft: PExprNode;
    FRight: PExprNode;
    FDataType: TFieldType;
    FDataSize: Integer;
    FArgs: TList;
    FScopeKind: TExprScopeKind;
  end;

  TFilterExpr = class
  private
    [Weak]FDataSet: TDataSet;
    FFieldMap: TFieldMap;
    FOptions: TFilterOptions;
    FParserOptions: TParserOptions;
    FNodes: PExprNode;
    FExprBuffer: TExprData;
    FExprBufSize: Integer;
    FExprNodeSize: Integer;
    FExprDataSize: Integer;
    FFieldName: string;
    [Weak]FDependentFields: TBits;
    FUnicodeEnabled: Boolean;
    function FieldFromNode(Node: PExprNode): TField;
    function GetExprData(Pos, Size: Integer): PByte;
    function PutConstBCD(const Value: Variant; Decimals: Integer): Integer;
    function PutConstFMTBCD(const Value: Variant; Decimals: Integer): Integer;
    function PutConstBool(const Value: Variant): Integer;
    function PutConstDate(const Value: Variant): Integer;
    function PutConstDateTime(const Value: Variant): Integer;
    function PutConstSQLTimeStamp(const Value: Variant): Integer;
    function PutConstSQLTimeStampOffset(const Value: Variant): Integer;
    function PutConstSingle(const Value: Variant): Integer;
    function PutConstFloat(const Value: Variant): Integer;
    function PutConstInt(DataType: TFieldType; const Value: Variant): Integer;
    function PutConstInt64(DataType: TFieldType; const Value: Variant): Integer;
    function PutConstNode(DataType: TFieldType; Data: PByte;
      Size: Integer): Integer;
{$IFNDEF NEXTGEN}
    function PutConstAnsiStr(const Value: AnsiString): Integer;
{$ENDIF !NEXTGEN}
    function PutConstUnicodeStr(const Value: string): Integer;
    function PutConstTime(const Value: Variant): Integer;
    function PutData(Data: PByte; Size: Integer): Integer;
    function PutExprNode(Node: PExprNode; ParentOp: TCANOperator): Integer;
    function PutFieldNode(Field: TField; Node: PExprNode): Integer;
    function PutNode(NodeType: NodeClass; OpType: TCANOperator;
      OpCount: Integer): Integer;
    procedure SetNodeOp(Node, Index: Integer; Data: NativeInt);
    function PutConstant(Node: PExprNode): Integer;
    function GetFieldByName(Name: string) : TField;
  public
    constructor Create(DataSet: TDataSet; Options: TFilterOptions;
      ParseOptions: TParserOptions; const FieldName: string; DepFields: TBits;
      FieldMap: TFieldMap; UnicodeEnabled: Boolean = False);
    destructor Destroy; override;
    function NewCompareNode(Field: TField; Operator: TCANOperator;
      const Value: Variant): PExprNode;
    function NewNode(Kind: TExprNodeKind; Operator: TCANOperator;
      const Data: Variant; Left, Right: PExprNode): PExprNode;
    function GetFilterData(Root: PExprNode): TExprData;
    property DataSet: TDataSet write FDataSet;
  end;

{ TExprParser }

  TExprToken = (etEnd, etSymbol, etName, etLiteral,  etLParen, etRParen,
    etEQ, etNE, etGE, etLE, etGT, etLT, etADD, etSUB, etMUL, etDIV,
    etComma, etLIKE, etISNULL, etISNOTNULL, etIN);

  TExprParser = class
  private
    FDecimalSeparator: Char;
    FFilter: TFilterExpr;
    FFieldMap: TFieldMap;
    FText: string;
    FSourcePtr: PChar;
    FTokenPtr: PChar;
    FTokenString: string;
    FStrTrue: string;
    FStrFalse: string;
    FToken: TExprToken;
    FPrevToken: TExprToken;
    FFilterData: TExprData;
    FNumericLit: Boolean;
    FDataSize: Integer;
    FParserOptions: TParserOptions;
    FFieldName: string;
    [Weak]FDataSet: TDataSet;
    [Weak]FDependentFields: TBits;
    FUnicodeEnabled: Boolean;
    procedure NextToken;
    function NextTokenIsLParen : Boolean;
    function ParseExpr: PExprNode;
    function ParseExpr2: PExprNode;
    function ParseExpr3: PExprNode;
    function ParseExpr4: PExprNode;
    function ParseExpr5: PExprNode;
    function ParseExpr6: PExprNode;
    function ParseExpr7: PExprNode;
    function TokenName: string;
    function TokenSymbolIs(const S: string): Boolean;
    function TokenSymbolIsFunc(const S: string) : Boolean;
    procedure GetFuncResultInfo(Node: PExprNode);
    procedure TypeCheckArithOp(Node: PExprNode);
    procedure GetScopeKind(Root, Left, Right : PExprNode);
  public
    constructor Create(DataSet: TDataSet; const Text: string;
      Options: TFilterOptions; ParserOptions: TParserOptions;
      const FieldName: string; DepFields: TBits; FieldMap: TFieldMap;
      UnicodeEnabled: Boolean = False);
    destructor Destroy; override;
    procedure SetExprParams(const Text: string; Options: TFilterOptions;
      ParserOptions: TParserOptions; const FieldName: string);
    property FilterData: TExprData read FFilterData;
    property DataSize: Integer read FDataSize;
  end;

{ Field Origin parser }

type
  TFieldInfo = record
    DatabaseName: string;
    TableName: string;
    OriginalFieldName: string;
  end;

function GetFieldInfo(const Origin: string; var FieldInfo: TFieldInfo): Boolean;

{ SQL Parser }

type
  TSQLToken = (stUnknown, stTableName, stFieldName, stAscending, stDescending, stSelect,
    stFrom, stWhere, stGroupBy, stHaving, stUnion, stPlan, stOrderBy, stForUpdate,
    stEnd, stPredicate, stValue, stIsNull, stIsNotNull, stLike, stAnd, stOr,
    stNumber, stAllFields, stComment, stDistinct);

const
  SQLSections = [stSelect, stFrom, stWhere, stGroupBy, stHaving, stUnion,
    stPlan, stOrderBy, stForUpdate];

{$IFNDEF NEXTGEN}
function NextSQLToken(var p: PAnsiChar; out Token: AnsiString; CurSection: TSQLToken): TSQLToken; overload;
{$ENDIF !NEXTGEN}
function NextSQLToken(var p: PChar; out Token: string; CurSection: TSQLToken): TSQLToken; overload;

function GetIndexForOrderBy(const SQL: string; DataSet: TDataSet): TIndexDef;
function GetTableNameFromSQL(const SQL: string): string;
function GetTableNameFromQuery(const SQL: string): string;
function AddParamSQLForDetail(Params: TParams; SQL: string; Native: Boolean; QuoteChar: string = ''): string;
function IsMultiTableQuery(const SQL: string): Boolean;
function SQLRequiresParams(const SQL: string): Boolean;

{ Warning: These function will be renamed in a future version of Delphi }
function NextSQLTokenEx(var p: PChar; out Token: string; CurSection: TSQLToken; IdOption: IDENTIFIEROption): TSQLToken; overload;
{$IFNDEF NEXTGEN}
function NextSQLTokenEx(var p: PAnsiChar; out Token: AnsiString; CurSection: TSQLToken; IdOption: IDENTIFIEROption): TSQLToken; overload;
{$ENDIF NEXTGEN}
function GetTableNameFromSQLEx(const SQL: string; IdOption: IDENTIFIEROption): string;

{$IFNDEF NEXTGEN}
function MetaDataFromUnicode(const Value: string): RawByteString; inline;
function MetaDataToUnicode(const Value: RawByteString): string; inline;
{$ENDIF !NEXTGEN}

implementation

uses Data.DBConsts, Data.FMTBcd
{$IFDEF MACOS}
  , Macapi.CoreFoundation
{$ENDIF MACOS}
;

{ Unicode Helpers }

// Common routine to be used in all places where a string needs to be converted
// to an AnsiString so that it can be passed to older BDE and DBClient APIs.
// Currently this is done by UTF8 encoding the data, but using a common routine
// allows this to be changed in just one place if a different approach is more appropriate.
{$IFNDEF NEXTGEN}
function MetaDataFromUnicode(const Value: string): RawByteString;
begin
  Result := UTF8Encode(Value);
end;

// Same as above, but converts from AnsiString to string
function MetaDataToUnicode(const Value: RawByteString): string;
begin
  Result := UTF8ToString(Value);
end;
{$ENDIF !NEXTGEN}

{ SQL Parser }

{ Ansi version }

{$IFNDEF NEXTGEN}
function SameSQLText(const S1, S2: AnsiString): Boolean; inline;
begin
  Result := SameText(string(S1), string(S2));
end;

function NextSQLToken(var p: PAnsiChar; out Token: AnsiString; CurSection: TSQLToken): TSQLToken;
var
  DotStart: Boolean;

  function NextTokenIs(Value: AnsiString; var Str: AnsiString): Boolean;
  var
    Tmp: PAnsiChar;
    S: AnsiString;
  begin
    Tmp := p;
    NextSQLToken(Tmp, S, CurSection);
    Result := SameSQLText(Value, S);
    if Result then
    begin
      Str := Str + AnsiString(' ') + S;
      p := Tmp;
    end;
  end;

  function GetSQLToken(var Str: AnsiString): TSQLToken;
  var
    l: PAnsiChar;
    s: AnsiString;
  begin
    if Length(Str) = 0 then
      Result := stEnd else
    if (Str = '*') and (CurSection = stSelect) then
      Result := stAllFields else
    if DotStart then
      Result := stFieldName else
    if (SameSQLText('DISTINCT', Str) and (CurSection = stSelect)) then
      Result := stDistinct else
    if SameSQLText('ASC', Str) or SameSQLText('ASCENDING', Str) then
      Result := stAscending else
    if SameSQLText('DESC', Str) or SameSQLText('DESCENDING', Str) then
      Result := stDescending else
    if SameSQLText('SELECT', Str) then
      Result := stSelect else
    if SameSQLText('AND', Str) then
      Result := stAnd else
    if SameSQLText('OR', Str) then
      Result := stOr else
    if SameSQLText('LIKE', Str) then
      Result := stLike else
    if SameSQLText('IS', Str) then
    begin
      if NextTokenIs('NULL', Str) then
        Result := stIsNull else
      begin
        l := p;
        s := Str;
        if NextTokenIs('NOT', Str) and NextTokenIs('NULL', Str) then
          Result := stIsNotNull else
        begin
          p := l;
          Str := s;
          Result := stValue;
        end;
      end;
    end else
    if SameSQLText('FROM', Str) then
      Result := stFrom else
    if SameSQLText('WHERE', Str) then
      Result := stWhere else
    if SameSQLText('GROUP', Str) and NextTokenIs('BY', Str) then
      Result := stGroupBy else
    if SameSQLText('HAVING', Str) then
      Result := stHaving else
    if SameSQLText('UNION', Str) then
      Result := stUnion else
    if SameSQLText('PLAN', Str) then
      Result := stPlan else
    if SameSQLText('FOR', Str) and NextTokenIs('UPDATE', Str) then
      Result := stForUpdate else
    if SameSQLText('ORDER', Str) and NextTokenIs('BY', Str)  then
      Result := stOrderBy else
    if SameSQLText('NULL', Str) then
      Result := stValue else
    if CurSection = stFrom then
      Result := stTableName else
      Result := stFieldName;
  end;

var
  TokenStart: PAnsiChar;

  procedure StartToken;
  begin
    if not Assigned(TokenStart) then
      TokenStart := p;
  end;

var
  Literal: AnsiChar;
  Mark: PAnsiChar;
begin
  TokenStart := nil;
  DotStart := False;
  while True do
  begin
    case p^ of
      '"','''','`':
      begin
        StartToken;
        Literal := AnsiChar(p^);
        Mark := p;
        repeat Inc(p) until (p^ in [Literal,#0]);
        if p^ = #0 then
        begin
          p := Mark;
          Inc(p);
        end else
        begin
          Inc(p);
          SetString(Token, TokenStart, p - TokenStart);
          Mark := PAnsiChar(Token);
          Token := AnsiExtractQuotedStr(Mark, Literal);
          if DotStart then
            Result := stFieldName else
          if p^ = '.' then
            Result := stTableName else
            Result := stValue;
          Exit;
        end;
      end;
      '/':
      begin
        StartToken;
        Inc(p);
        if p^ in ['/','*'] then
        begin
          if p^ = '*' then
          begin
            repeat Inc(p) until (p = #0) or ((p^ = '*') and (p[1] = '/'));
          end else
            while not (p^ in [#0, #10, #13]) do Inc(p);
          SetString(Token, TokenStart, p - TokenStart);
          Result := stComment;
          Exit;
        end;
      end;
      ' ', #10, #13, ',', '(':
      begin
        if Assigned(TokenStart) then
        begin
          SetString(Token, TokenStart, p - TokenStart);
          Result := GetSQLToken(Token);
          Exit;
        end else
          while (p^ in [' ', #10, #13, ',', '(']) do Inc(p);
      end;
      '.':
      begin
        if Assigned(TokenStart) then
        begin
          SetString(Token, TokenStart, p - TokenStart);
          Result := stTableName;
          Exit;
        end else
        begin
          DotStart := True;
          Inc(p);
        end;
      end;
      '=','<','>':
      begin
        if not Assigned(TokenStart) then
        begin
          TokenStart := p;
          while p^ in ['=','<','>'] do Inc(p);
          SetString(Token, TokenStart, p - TokenStart);
          Result := stPredicate;
          Exit;
        end;
        Inc(p);
      end;
      '0'..'9':
      begin
        if not Assigned(TokenStart) then
        begin
          TokenStart := p;
          while p^ in ['0'..'9','.'] do Inc(p);
          SetString(Token, TokenStart, p - TokenStart);
          Result := stNumber;
          Exit;
        end else
          Inc(p);
      end;
      #0:
      begin
        if Assigned(TokenStart) then
        begin
          SetString(Token, TokenStart, p - TokenStart);
          Result := GetSQLToken(Token);
          Exit;
        end else
        begin
          Result := stEnd;
          Token := '';
          Exit;
        end;
      end;
    else
      StartToken;
      Inc(p);
    end;
  end;
end;
{$ENDIF NEXTGEN}

{ Wide version }

function NextSQLTokenEx(var p: PChar; out Token: string; CurSection: TSQLToken; IdOption: IDENTIFIEROption): TSQLToken;
var
  DotStart: Boolean;

  function NextTokenIs(Value: string; var Str: string): Boolean;
  var
    Tmp: PChar;
    S: string;
  begin
    Tmp := p;
    NextSQLTokenEx(Tmp, S, CurSection, IdOption);
    Result := string.Compare(Value, S, True) = 0;
    if Result then
    begin
      Str := Str + ' ' + S;
      p := Tmp;
    end;
  end;

  function GetSQLToken(var Str: string): TSQLToken;
  var
    l: PChar;
    s: string;
  begin
    if Str.Length = 0 then
      Result := stEnd else
    if (Str = '*') and (CurSection = stSelect) then
      Result := stAllFields else
    if DotStart then
      Result := stFieldName else
    if (string.Compare('DISTINCT', Str, True) = 0) and (CurSection = stSelect) then
      Result := stDistinct else
    if (string.Compare('ASC', Str, True) = 0) or (string.Compare('ASCENDING', Str, True) = 0) then
      Result := stAscending else
    if (string.Compare('DESC', Str, True) = 0) or (string.Compare('DESCENDING', Str, True) = 0) then
      Result := stDescending else
    if string.Compare('SELECT', Str, True) = 0 then
      Result := stSelect else
    if string.Compare('AND', Str, True) = 0 then
      Result := stAnd else
    if string.Compare('OR', Str, True) = 0 then
      Result := stOr else
    if string.Compare('LIKE', Str, True) = 0 then
      Result := stLike else
    if (string.Compare('IS', Str, True) = 0) then
    begin
      if NextTokenIs('NULL', Str) then
        Result := stIsNull else
      begin
        l := p;
        s := Str;
        if NextTokenIs('NOT', Str) and NextTokenIs('NULL', Str) then
          Result := stIsNotNull else
        begin
          p := l;
          Str := s;
          Result := stValue;
        end;
      end;
    end else
    if string.Compare('FROM', Str, True) = 0 then
      Result := stFrom else
    if string.Compare('WHERE', Str, True) = 0 then
      Result := stWhere else
    if (string.Compare('GROUP', Str, True) = 0) and NextTokenIs('BY', Str) then
      Result := stGroupBy else
    if string.Compare('HAVING', Str, True) = 0 then
      Result := stHaving else
    if string.Compare('UNION', Str, True) = 0 then
      Result := stUnion else
    if string.Compare('PLAN', Str, True) = 0 then
      Result := stPlan else
    if (string.Compare('FOR', Str, True) = 0) and NextTokenIs('UPDATE', Str) then
      Result := stForUpdate else
    if (string.Compare('ORDER', Str, True) = 0) and NextTokenIs('BY', Str)  then
      Result := stOrderBy else
    if string.Compare('NULL', Str, True) = 0 then
      Result := stValue else
    if CurSection = stFrom then
      Result := stTableName else
      Result := stFieldName;
  end;

  procedure AdjustId(TokenType: TSQLToken; var Token: string; IdOption: IDENTIFIEROption);
  begin
    case TokenType of
      stFieldName,
      stTableName:
      case IdOption of
        idMakeLowerCase: Token := LowerCase(Token);
        idMakeUpperCase: Token := UpperCase(Token);
      end;
    end;
  end;

var
  TokenStart: PChar;

  procedure StartToken;
  begin
    if not Assigned(TokenStart) then
      TokenStart := p;
  end;
var
  Literal: Char;
  Mark: PChar;
begin
  TokenStart := nil;
  DotStart := False;
  while True do
  begin
    case p^ of
      '[':
      begin
        StartToken;
        Mark := p;
        repeat Inc(p) until ((p^ = ']') or (p^ = #0));
        if p^ = #0 then
        begin
          // no end token, restart
          p := Mark;
          Inc(p);
        end else
        begin
          // consume ']'
          Inc(p);
          // get the token
          if IdOption = idKeepQuotes then
            SetString(Token, TokenStart, p - TokenStart)
          else
            SetString(Token, TokenStart + 1, p - TokenStart - 2);
          // determine the token type
          if DotStart then
            Result := stFieldName else
          if p^ = '.' then
            Result := stTableName else
            Result := stValue;
          Exit;
        end;
      end;
      '"','''','`':
      begin
        StartToken;
        Literal := p^;
        Mark := p;
        repeat Inc(p) until ((p^ = Literal) or (p^ = #0));
        if p^ = #0 then
        begin
          p := Mark;
          Inc(p);
        end else
        begin
          Inc(p);
          SetString(Token, TokenStart, p - TokenStart);
          Mark := PChar(Token);
          if IdOption = idKeepQuotes then
            SetString(Token, TokenStart, p - TokenStart)
          else
            Token := AnsiExtractQuotedStr(Mark, Literal);
          if DotStart then
            Result := stFieldName else
          if p^ = '.' then
            Result := stTableName else
            Result := stValue;
          Exit;
        end;
      end;
      '/':
      begin
        StartToken;
        Inc(p);
        if (p^ = '/') or (p^ = '*') then
        begin
          if p^ = '*' then
          begin
            repeat Inc(p) until (p^ = #0) or ((p^ = '*') and (p[1] = '/'));
          end else
            while not ((p^ = #0) or (p^ = #10) or (p^ = #13)) do Inc(p);
          SetString(Token, TokenStart, p - TokenStart);
          Result := stComment;
          Exit;
        end;
      end;
      ' ', #10, #13, ',', '(':
      begin
        if Assigned(TokenStart) then
        begin
          SetString(Token, TokenStart, p - TokenStart);
          Result := GetSQLToken(Token);
          AdjustId(Result, Token, IdOption);
          Exit;
        end else
          while ((p^ = ' ') or (p^ = #10) or (p^ = #13) or (p^ = ',') or (p^ = '(')) do Inc(p);
      end;
      '.':
      begin
        if Assigned(TokenStart) then
        begin
          SetString(Token, TokenStart, p - TokenStart);
          Result := stTableName;
          AdjustId(Result, Token, IdOption);
          Exit;
        end else
        begin
          DotStart := True;
          Inc(p);
        end;
      end;
      '=','<','>':
      begin
        if not Assigned(TokenStart) then
        begin
          TokenStart := p;
          while ((p^ = '=') or (p^ = '<') or (p^ = '>')) do Inc(p);
          SetString(Token, TokenStart, p - TokenStart);
          Result := stPredicate;
          Exit;
        end;
        Inc(p);
      end;
      '0'..'9':
      begin
        if not Assigned(TokenStart) then
        begin
          TokenStart := p;
          while ((p^ = '.') or ((p^ >= '0') and (p^ <= '9'))) do Inc(p);
          SetString(Token, TokenStart, p - TokenStart);
          Result := stNumber;
          Exit;
        end else
          Inc(p);
      end;
      #0:
      begin
        if Assigned(TokenStart) then
        begin
          SetString(Token, TokenStart, p - TokenStart);
          Result := GetSQLToken(Token);
          AdjustId(Result, Token, IdOption);
          Exit;
        end else
        begin
          Result := stEnd;
          Token := '';
          Exit;
        end;
      end;
    else
      StartToken;
      Inc(p);
    end;
  end;
end;

{$IFNDEF NEXTGEN}
function NextSQLTokenEx(var p: PAnsiChar; out Token: AnsiString; CurSection: TSQLToken; IdOption: IDENTIFIEROption): TSQLToken;
begin
  Result := NextSQLToken(p, Token, CurSection);
end;
{$ENDIF}

function NextSQLToken(var p: PChar; out Token: string; CurSection: TSQLToken): TSQLToken;
begin
  Result := NextSQLTokenEx(p, Token, CurSection, idMixCase);
end;

function AddParamSQLForDetail(Params: TParams; SQL: string; Native: Boolean; QuoteChar: string = ''): string;
const
  SWhere = ' where ';     { do not localize }
  SAnd = ' and ';         { do not localize }

  function GenerateParamSQL: string;
  var
    I: Integer;
    ParamName: string;
  begin
    for I := 0 to Params.Count -1 do
    begin
      if QuoteChar = '"' then
        ParamName := '"' + Params[I].Name.Replace('"', '""', [rfReplaceAll]) + '"'
      else
        ParamName := QuoteChar + Params[I].Name + QuoteChar;
      if I > 0 then Result := Result + SAnd;
      if Native then
        Result := Result + string.Format('%s = ?', [ParamName])
      else
        Result := Result + string.Format('%s = :%s', [ParamName, ParamName]);
    end;
    if Result.ToLower.IndexOf(SWhere) > -1 then
      Result := SAnd + Result
    else
      Result := SWhere + Result;
  end;

  function AddWhereClause: string;
  var
    Start: PChar;
    Rest, FName: string;
    SQLToken, CurSection: TSQLToken;
  begin
    Start := PChar(SQL);
    CurSection := stUnknown;
    repeat
      SQLToken := NextSQLToken(Start, FName, CurSection);
    until SQLToken in [stFrom, stEnd];
    if SQLToken = stFrom then
      NextSQLToken(Start, FName, CurSection);
    Rest := string(Start);
    if Rest = '' then
      Result := SQL + ' ' + GenerateParamSQL
    else
      Result := SQL.Substring(0, SQL.IndexOf(Rest) + 1) + ' ' + GenerateParamSQL + Rest;
  end;

begin
  Result := SQL;
  if (Params.Count > 0) then
    Result := AddWhereClause;
end;

// SQL might be a direct tablename;
function GetTableNameFromQuery(const SQL: string): string;
begin
  if SQL.ToLower.IndexOf('select') < 0 then
    Result := SQL
  else
    Result := GetTableNameFromSQL(SQL);
end;

function GetTableNameFromSQL(const SQL: string): string;
begin
  Result := GetTableNameFromSQLEx(SQL,idMixCase);
end;

function GetTableNameFromSQLEx(const SQL: string; IdOption: IDENTIFIEROption): string;
var
  Start: PChar;
  Token: string;
  SQLToken, CurSection: TSQLToken;
begin
  Result := '';
  Start := PChar(SQL);
  CurSection := stUnknown;
  repeat
    SQLToken := NextSQLTokenEx(Start, Token, CurSection, IdOption);
    if SQLToken in SQLSections then CurSection := SQLToken;
  until SQLToken in [stEnd, stFrom];
  if SQLToken = stFrom then
  begin
    repeat
      SQLToken := NextSQLTokenEx(Start, Token, CurSection, IdOption);
      if SQLToken in SQLSections then
        CurSection := SQLToken else
      // stValue is returned if TableNames contain quote chars.
      if (SQLToken = stTableName) or (SQLToken = stValue) then
      begin
        if AnsiRightStr(Token, 1) = ';' then
          Token := AnsiLeftStr(Token, Token.Length-1);
        if AnsiRightStr(Token, 1) = ')' then
          Token := AnsiLeftStr(Token, Token.Length-1);
        Result := Trim(Token);
        while (Start[0] = '.') and not (SQLToken in [stEnd]) do
        begin
          SQLToken := NextSqlTokenEx(Start, Token, CurSection, IdOption);
          Result := Result + '.' + Token;
        end;
        Exit;
      end;
    until (CurSection <> stFrom) or (SQLToken in [stEnd, stTableName]);
  end;
end;

function IsMultiTableQuery(const SQL: string): Boolean;
const
  SInnerJoin = 'inner join ';       { do not localize }
  SOuterJoin = 'outer join ';       { do not localize }
var
  Start: PChar;
  SResult, Token: string;
  SQLToken, CurSection: TSQLToken;
begin
  SResult := '';
  Start := PChar(SQL);
  CurSection := stUnknown;
  Result := True;
  repeat
    SQLToken := NextSQLToken(Start, Token, CurSection);
    if SQLToken in SQLSections then CurSection := SQLToken;
  until SQLToken in [stEnd, stFrom];
  if SQLToken = stFrom then
  begin
    repeat
      SQLToken := NextSQLToken(Start, Token, CurSection);
      if SQLToken in SQLSections then
        CurSection := SQLToken else
      // stValue is returned if TableNames contain quote chars.
      if (SQLToken = stTableName) or (SQLToken = stValue) then
      begin
        SResult := Token;
        while (Start[0] = '.') and not (SQLToken in [stEnd]) do
        begin
          SQLToken := NextSqlToken(Start, Token, CurSection);
          SResult := SResult + '.' + Token;
        end;
        if (Start[0] = ',') or (Start[1] = ',') then
          exit;
        SQLToken := NextSqlToken(Start, Token, CurSection);
        if SQLToken in SQLSections then CurSection := SQLToken;
        if Assigned(StrPos(Start, SInnerJoin)) or
           Assigned(StrPos(Start, SOuterJoin)) then
          Exit;
        SQLToken := NextSqlToken(Start, Token, CurSection);
        if (SQLToken = stTableName) then
          Exit;
        Result := False;
        Exit;
      end;
    until (CurSection <> stFrom) or (SQLToken in [stEnd, stTableName]);
  end;
end;

{ Midas sets parameters, but sometimes SQL Statement doesn't use parameters }
{ This function is designed to verify that statement uses params before setting them }
function SQLRequiresParams(const SQL: string): Boolean;
const
  SSelect = 'select';
  SDelete = 'delete';      { Do not localize }
  SUpdate = 'update';      { Do not localize }
  SInsert = 'insert';      { Do not localize }
var
  Start: PChar;
  QStart: string;
  Value: string;
  SQLToken: TSQLToken;
  Params: TParams;
begin
  Params := TParams.Create(nil);
  try
    QStart := Params.ParseSQL(SQL, False);
    while (QStart.Length > 1) and (QStart.Chars[0] = ' ') do
      QStart := QStart.Substring(1, QStart.Length - 1);
    QStart := QStart.Substring(0, 6).ToLower;
    Result := QStart = sInsert;  { inserts will use params }
    if not Result then
    begin
      Result := (QStart = SSelect) or
            (QStart = SUpdate) or (QStart = SDelete);
      if Result then  { update, select and delete need 'where' for params }
      begin
        SQLToken := stUnknown;
        Start := PChar(SQL);
        repeat
          SQLToken := NextSQLToken(Start, Value, SQLToken);
          Result := SQLToken in [stWhere];
        until SQLToken in [stEnd, stWhere];
      end;
    end;
  finally
    Params.Free;
  end;
end;

function GetIndexForOrderBy(const SQL: string; DataSet: TDataSet): TIndexDef;

  function AddField(const Fields, NewField: string): string;
  begin
    Result := Fields;
    if Fields <> '' then
      Result := Fields + ';' + NewField else
      Result := NewField;
  end;

var
  Start: PChar;
  Token, LastField, SaveField: string;
  SQLToken, CurSection: TSQLToken;
  FieldIndex: Integer;
begin
  Result := nil;
  Start := PChar(SQL);
  CurSection := stUnknown;
  repeat
    SQLToken := NextSQLToken(Start, Token, CurSection);
    if SQLToken in SQLSections then CurSection := SQLToken;
  until SQLToken in [stEnd, stOrderBy];
  if SQLToken = stOrderBy then
  begin
    Result := TIndexDef.Create(nil);
    try
      LastField := '';
      repeat
        SQLToken := NextSQLToken(Start, Token, CurSection);
        if SQLToken in SQLSections then
          CurSection := SQLToken else
          case SQLToken of
            stTableName: ;
            stFieldName:
            begin
              LastField := Token;
              { Verify that we parsed a valid field name, not something like "UPPER(Foo)" }
              if not Assigned(Dataset.FindField(LastField)) then continue;
              Result.Fields := AddField(Result.Fields, LastField);
              SaveField := LastField;
            end;
            stAscending: ;
            stDescending:
              Result.DescFields := AddField(Result.DescFields, SaveField);
            stNumber:
            begin
              FieldIndex := StrToInt(Token);
              if DataSet.FieldCount >= FieldIndex then
                LastField := DataSet.Fields[FieldIndex - 1].FieldName else
              if DataSet.FieldDefs.Count >= FieldIndex then
                LastField := DataSet.FieldDefs[FieldIndex - 1].Name
              else
                { DB2 specific syntax "FETCH FIRST n ROWS ONLY" is blocked here,
                  so commenting out the following line }
                //SysUtils.Abort;
                continue;
              { Verify that we parsed a valid field name, not something like "UPPER(Foo)" }
              if not Assigned(Dataset.FindField(LastField)) then
                continue;
              Result.Fields := AddField(Result.Fields, LastField);
              SaveField := LastField;
            end;
          end;
      until (CurSection <> stOrderBy) or (SQLToken = stEnd);
    finally
      if Result.Fields = '' then
      begin
        Result.Free;
        Result := nil;
      end;
    end;
  end;
end;

function GetFieldInfo(const Origin: string; var FieldInfo: TFieldInfo): Boolean;
var
  Current: PChar;
  Values: array[0..4] of string;
  I: Integer;

  function GetPChar(const S: string): PChar;
  begin
    if S <> '' then Result := PChar(S) else Result := '';
  end;

  procedure Split(const S: string);
  begin
    Current := PChar(S);
  end;

  function NextItem: string;
  var
    C: PChar;
    I: PChar;
    Terminator: Char;
    Ident: array[0..1023] of Char;
  begin
    Result := '';
    C := Current;
    I := Ident;
    while ((C^ = '.') or (C^ = ' ') or (C^ = #0)) do
      if C^ = #0 then Exit else Inc(C);
    Terminator := '.';
    if C^ = '"' then
    begin
      Terminator := '"';
      Inc(C);
    end;
    while (C^ <> Terminator) and (C^ <> #0) do
    begin
      if C^ = '\' then
      begin
        Inc(C);
        if C^ = #0 then Dec(C);
      end;
      I^ := C^;
      Inc(C);
      Inc(I);
    end;
    SetString(Result, Ident, I - Ident);
    if (Terminator = '"') and (C^ <> #0) then Inc(C);
    Current := C;
  end;

  function PopValue: PChar;
  begin
    if I >= 0 then
    begin
      Result := GetPChar(Values[I]);
      Dec(I);
    end else Result := '';
  end;

begin
  Result := False;
  if (Origin = '') then Exit;
  Split(Origin);
  I := -1;
  repeat
    Inc(I);
    Values[I] := NextItem;
  until (Values[I] = '') or (I = High(Values));
  if I = High(Values) then Exit;
  Dec(I);
  FieldInfo.OriginalFieldName := PopValue;
  FieldInfo.TableName := PopValue;
  FieldInfo.DatabaseName := PopValue;
  Result := (FieldInfo.OriginalFieldName <> '') and (FieldInfo.TableName <> '');
end;

const
  AnsiStringFieldTypes = [ftString, ftFixedChar, ftGuid];
  UnicodeStringFieldTypes = [ftWideString, ftFixedWideChar];
  StringFieldTypes = AnsiStringFieldTypes + UnicodeStringFieldTypes;
  BlobFieldTypes = [ftBlob, ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle,
    ftTypedBinary, ftOraBlob, ftOraClob, ftWideMemo];

function IsNumeric(DataType: TFieldType): Boolean;
begin
  Result := DataType in [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency,
    ftBCD, ftAutoInc, ftLargeint, ftFMTBcd, ftShortint, ftByte, ftSingle,
    ftLongWord, ftExtended];
end;

function IsTemporal(DataType: TFieldType): Boolean;
begin
  Result := DataType in [ftDate, ftTime, ftDateTime, ftTimeStamp, ftTimeStampOffset];
end;

{ TFilterExpr }

constructor TFilterExpr.Create(DataSet: TDataSet; Options: TFilterOptions;
  ParseOptions: TParserOptions; const FieldName: string; DepFields: TBits;
  FieldMap: TFieldMap; UnicodeEnabled: Boolean);
begin
  FFieldMap := FieldMap;
  FDataSet := DataSet;
  FOptions := Options;
  FFieldName := FieldName;
  FParserOptions := ParseOptions;
  FDependentFields := DepFields;
  FUnicodeEnabled := UnicodeEnabled;
end;

destructor TFilterExpr.Destroy;
var
  Node: PExprNode;
begin
  SetLength(FExprBuffer, 0);
  while FNodes <> nil do
  begin
    Node := FNodes;
    FNodes := Node.FNext;
    if (Node.FArgs <> nil) then
      Node.FArgs.Free;
    Dispose(Node);
  end;
end;

function TFilterExpr.FieldFromNode(Node: PExprNode): TField;
begin
  Result := GetFieldByName(Node.FData);
  if not (Result.FieldKind in [fkData, fkInternalCalc]) then
    DatabaseErrorFmt(SExprBadField, [Result.FieldName]);
end;

function TFilterExpr.GetExprData(Pos, Size: Integer): PByte;
begin
  SetLength(FExprBuffer, FExprBufSize + Size);
  Move(FExprBuffer[Pos], FExprBuffer[Pos + Size], FExprBufSize - Pos);
  Inc(FExprBufSize, Size);
  Result := PByte(FExprBuffer) + Pos;
end;

function TFilterExpr.GetFilterData(Root: PExprNode): TExprData;
begin
  FExprBufSize := CANExprSize;
  SetLength(FExprBuffer, FExprBufSize);
  PutExprNode(Root, coNOTDEFINED);
  PWord(@FExprBuffer[0])^ := CANEXPRVERSION;                { iVer }
  PWord(@FExprBuffer[2])^ := FExprBufSize;                  { iTotalSize }
  PWord(@FExprBuffer[4])^ := $FFFF;                         { iNodes }
  PWord(@FExprBuffer[6])^ := CANEXPRSIZE;                   { iNodeStart }
  PWord(@FExprBuffer[8])^ := FExprNodeSize + CANEXPRSIZE;   { iLiteralStart }
  Result := FExprBuffer;
end;

function TFilterExpr.NewCompareNode(Field: TField; Operator: TCANOperator;
  const Value: Variant): PExprNode;
var
  ConstExpr: PExprNode;
begin
  ConstExpr := NewNode(enConst, coNOTDEFINED, Value, nil, nil);
  ConstExpr.FDataType := Field.DataType;
  ConstExpr.FDataSize := Field.Size;
  Result := NewNode(enOperator, Operator, Unassigned,
    NewNode(enField, coNOTDEFINED, Field.FieldName, nil, nil), ConstExpr);
end;

function TFilterExpr.NewNode(Kind: TExprNodeKind; Operator: TCANOperator;
  const Data: Variant; Left, Right: PExprNode): PExprNode;
var
  Field : TField;
begin
  New(Result);
  Result.FNext := FNodes;
  Result.FKind := Kind;
  Result.FPartial := False;
  Result.FOperator := Operator;
  Result.FData := Data;
  Result.FLeft := Left;
  Result.FRight := Right;
  FNodes := Result;
  FNodes.FArgs := nil;
  if Kind = enField then
  begin
    Field := GetFieldByName(Data);
    if Field = nil then
      DatabaseErrorFmt(SFieldNotFound, [Data]);
    Result.FDataType := Field.DataType;
    Result.FDataSize := Field.Size;
  end;
end;

function TFilterExpr.PutConstBCD(const Value: Variant;
  Decimals: Integer): Integer;
var
  C: Currency;
  BCD: TBcd;
begin
  if VarType(Value) = varString then
    C := StrToCurr(TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(TVarData(Value).VString)))
  else
    C := Value;
  CurrToBCD(C, BCD, 32, Decimals);
  Result := PutConstNode(ftBCD, @BCD, 18);
end;

function TFilterExpr.PutConstFMTBCD(const Value: Variant;
  Decimals: Integer): Integer;
var
  BCD: TBcd;
begin
  if VarType(Value) = varString then
    BCD := StrToBcd(TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(TVarData(Value).VString)))
  else
    BCD := VarToBcd(Value);
  Result := PutConstNode(ftBCD, @BCD, 18);
end;

function TFilterExpr.PutConstBool(const Value: Variant): Integer;
var
  B: WordBool;
begin
  B := Value;
  Result := PutConstNode(ftBoolean, @B, SizeOf(WordBool));
end;

function TFilterExpr.PutConstDate(const Value: Variant): Integer;
var
  DateTime: TDateTime;
  TimeStamp: TTimeStamp;
begin
  if VarType(Value) = varString then
  begin
    if not TryStrToDate(TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(TVarData(Value).VString)), DateTime) then
      DateTime := VarToDateTime(Value);
  end
  else
    DateTime := VarToDateTime(Value);
  TimeStamp := DateTimeToTimeStamp(DateTime);
  Result := PutConstNode(ftDate, @TimeStamp.Date, 4);
end;

function TFilterExpr.PutConstDateTime(const Value: Variant): Integer;
var
  DateTime: TDateTime;
  DateData: Double;
begin
  if VarType(Value) = varString then
  begin
    if not TryStrToDate(TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(TVarData(Value).VString)), DateTime) then
      DateTime := VarToDateTime(Value);
  end
  else
    DateTime := VarToDateTime(Value);
  DateData := TimeStampToMSecs(DateTimeToTimeStamp(DateTime));
  Result := PutConstNode(ftDateTime, @DateData, 8);
end;

function TFilterExpr.PutConstSQLTimeStamp(const Value: Variant): Integer;
var
  TimeStamp: TSQLTimeStamp;
begin
  if VarType(Value) = varString then
    TimeStamp := StrToSQLTimeStamp(TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(TVarData(Value).VString)))
  else
    TimeStamp := VarToSQLTimeStamp(Value);
  Result := PutConstNode(ftTimeStamp, @TimeStamp, 16);
end;

function TFilterExpr.PutConstSQLTimeStampOffset(const Value: Variant): Integer;
var
  TimeStampOffset: TSQLTimeStampOffset;
begin
  if VarType(Value) = varString then
    TimeStampOffset := StrToSQLTimeStampOffset(TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(TVarData(Value).VString)))
  else
    TimeStampOffset := VarToSQLTimeStampOffset(Value);
  Result := PutConstNode(ftTimeStampOffset, @TimeStampOffset, 16);
end;

function TFilterExpr.PutConstSingle(const Value: Variant): Integer;
var
  F: Single;
begin
  if VarType(Value) = varString then
    F := StrToFloat(TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(TVarData(Value).VString)))
  else
    F := Value;
  Result := PutConstNode(ftSingle, @F, SizeOf(Single));
end;

function TFilterExpr.PutConstFloat(const Value: Variant): Integer;
var
  F: Double;
begin
  if VarType(Value) = varString then
    F := StrToFloat(TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(TVarData(Value).VString)))
  else
    F := Value;
  Result := PutConstNode(ftFloat, @F, SizeOf(Double));
end;

function TFilterExpr.PutConstInt(DataType: TFieldType;
  const Value: Variant): Integer;
var
  I, Size: Integer;
begin
  if VarType(Value) = varString then
    I := StrToInt(TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(TVarData(Value).VString)))
  else
    I := Value;
  Size := 2;
  case DataType of
    ftByte:
      if (I < 0) or (I > 255) then DatabaseError(SExprRangeError);
    ftShortint:
      if (I < -128) or (I > 127) then DatabaseError(SExprRangeError);
    ftSmallint:
      if (I < -32768) or (I > 32767) then DatabaseError(SExprRangeError);
    ftWord:
      if (I < 0) or (I > 65535) then DatabaseError(SExprRangeError);
  else
    Size := 4;
  end;
  Result := PutConstNode(DataType, @I, Size);
end;

function TFilterExpr.PutConstInt64(DataType: TFieldType; const Value: Variant): Integer;
var
  IntValue: LargeInt;
begin
  IntValue := Value;
  Result := PutConstNode(DataType, @IntValue, SizeOf(IntValue));
end;

function TFilterExpr.PutConstNode(DataType: TFieldType; Data: PByte;
  Size: Integer): Integer;
begin
  Result := PutNode(nodeCONST, coCONST2, 3);
  SetNodeOp(Result, 0, FFieldMap[DataType]);
  SetNodeOp(Result, 1, Size);
  SetNodeOp(Result, 2, PutData(Data, Size));
end;

{$IFNDEF NEXTGEN}
function TFilterExpr.PutConstAnsiStr(const Value: AnsiString): Integer;
var
  Str: AnsiString;
  Buffer: array[0..255] of Byte;
begin
  if Length(Value) >= SizeOf(Buffer) then
    Str := Copy(Value, 1, SizeOf(Buffer) - 1) else
    Str := Value;
  FDataSet.Translate(PAnsiChar(Str), PAnsiChar(@Buffer), True);
  Result := PutConstNode(ftString, @Buffer, Length(Str) + 1);
end;
{$ENDIF !NEXTGEN}

function TFilterExpr.PutConstUnicodeStr(const Value: string): Integer;
var
  buffer: array of word;
  Len : Integer;
begin
  // Midas expects Length field at head of data.
  // See TCustomClientDataSet.DataConvert
  Len := Value.Length;
  SetLength(buffer, Len + 1); // add length information.
  buffer[0] := Len * 2;
  if Value <> '' then
    Move(Value[Low(Value)], Buffer[1], Len*2);
//  buffer[Len+1] := 0;
  // Midas expects fldUNICODE type for UNICODE data.
  // BDE doesn't support UNICODE field type.
  Result := PutConstNode(TFieldType(ftUnknown), @buffer[0], (Len+1)*2);
  SetNodeOp(Result, 0, $1007); // DSIntf.fldUNICODE
end;

function TFilterExpr.PutConstTime(const Value: Variant): Integer;
var
  DateTime: TDateTime;
  TimeStamp: TTimeStamp;
begin
  if VarType(Value) = varString then
    DateTime := StrToTime(TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(TVarData(Value).VString)))
  else
    DateTime := VarToDateTime(Value);
  TimeStamp := DateTimeToTimeStamp(DateTime);
  Result := PutConstNode(ftTime, @TimeStamp.Time, 4);
end;

function TFilterExpr.PutData(Data: PByte; Size: Integer): Integer;
begin
  Move(Data^, GetExprData(FExprBufSize, Size)^, Size);
  Result := FExprDataSize;
  Inc(FExprDataSize, Size);
end;

function TFilterExpr.PutConstant(Node: PExprNode): Integer;
begin
  Result := 0;
  case Node.FDataType of
    ftSmallInt, ftShortint, ftByte, ftInteger, ftWord, ftAutoInc:
      Result := PutConstInt(Node.FDataType, Node.FData);
    ftSingle:
      Result := PutConstSingle(Node.FData);
    ftFloat, ftCurrency, ftExtended:
      Result := PutConstFloat(Node.FData);
{$IFNDEF NEXTGEN}
    ftString, ftFixedChar, ftGuid:
      Result := PutConstAnsiStr(AnsiString(Node.FData));
{$ELSE}
    ftString, ftFixedChar, ftGuid,
{$ENDIF !NEXTGEN}
    ftWideString, ftFixedWideChar:
      Result := PutConstUnicodeStr(string(Node.FData));
    ftDate:
      Result := PutConstDate(Node.FData);
    ftTime:
      Result := PutConstTime(Node.FData);
    ftDateTime:
      Result := PutConstDateTime(Node.FData);
    ftTimeStamp:
      Result := PutConstSQLTimeStamp(Node.FData);
    ftTimeStampOffset:
      Result := PutConstSQLTimeStampOffset(Node.FData);
    ftBoolean:
      Result := PutConstBool(Node.FData);
    ftBCD:
      Result := PutConstBCD(Node.FData, Node.FDataSize);
    ftFMTBcd:
      Result := PutConstFMTBCD(Node.FData, Node.FDataSize);
    ftLongWord, ftLargeint:
      Result := PutConstInt64(Node.FDataType, Node.FData);
    else
      DatabaseErrorFmt(SExprBadConst, [Node.FData]);
  end;
end;

function TFilterExpr.PutExprNode(Node: PExprNode; ParentOp: TCANOperator): Integer;
const
  ReverseOperator: array[coEQ..coLE] of TCANOperator = (coEQ, coNE, coLT,
    coGT, coLE, coGE);
  BoolFalse: WordBool = False;
var
  Field: TField;
  Left, Right, Temp : PExprNode;
  LeftPos, RightPos, ListElem, PrevListElem, I: Integer;
  Operator: TCANOperator;
  CaseInsensitive, PartialLength, L:  Integer;
{$IFNDEF NEXTGEN}
  AnsiS: AnsiString;
{$ENDIF !NEXTGEN}
  WideS: string;
  M: TMarshaller;
begin
  Result := 0;
  case Node.FKind of
    enField:
      begin
        Field := FieldFromNode(Node);
        if (ParentOp in [coOR, coNOT, coAND, coNOTDEFINED]) and
           (Field.DataType = ftBoolean) then
        begin
          Result := PutNode(nodeBINARY, coNE, 2);
          SetNodeOp(Result, 0, PutFieldNode(Field, Node));
          SetNodeOp(Result, 1, PutConstNode(ftBoolean, @BoolFalse, SizeOf(WordBool)));
        end
        else
          Result := PutFieldNode(Field, Node);
      end;
    enConst:
      Result := PutConstant(Node);
    enOperator:
      case Node.FOperator of
        coIN:
          begin
            Result := PutNode(nodeBINARY, coIN, 2);
            SetNodeOp(Result, 0, PutExprNode(Node.FLeft,Node.FOperator));
            ListElem := PutNode(nodeLISTELEM, coLISTELEM2, 2);
            SetNodeOp(Result, 1, ListElem);
            PrevListElem := ListElem;
            for I := 0 to Node.FArgs.Count - 1 do
            begin
              LeftPos := PutExprNode(Node.FArgs.Items[I],Node.FOperator);
              if I = 0 then
                begin
                  SetNodeOp(PrevListElem, 0, LeftPos);
                  SetNodeOp(PrevListElem, 1, 0);
                end
              else
                begin
                  ListElem := PutNode(nodeLISTELEM, coLISTELEM2, 2);
                  SetNodeOp(ListElem, 0, LeftPos);
                  SetNodeOp(ListElem, 1, 0);
                  SetNodeOp(PrevListElem, 1, ListElem);
                  PrevListElem := ListElem;
                end;
              end;
          end;
        coNOT,
        coISBLANK,
        coNOTBLANK:
          begin
            Result := PutNode(nodeUNARY, Node.FOperator, 1);
            SetNodeOp(Result, 0, PutExprNode(Node.FLeft,Node.FOperator));
          end;
        coEQ..coLE,
        coAND,coOR,
        coADD..coDIV,
        coLIKE,
        coASSIGN:
          begin
            Operator := Node.FOperator;
            Left := Node.FLeft;
            Right := Node.FRight;
            if (Operator in [coEQ..coLE]) and (Right.FKind = enField) and
               (Left.FKind <> enField) then
            begin
              Temp := Left;
              Left := Right;
              Right := Temp;
              Operator := ReverseOperator[Operator];
            end;

            Result := 0;
            if (Left.FKind = enField) and (Right.FKind = enConst)
               and ((Node.FOperator = coEQ)  or (Node.FOperator = coNE)
               or (Node.FOperator = coLIKE)) then
            begin
              if VarIsNull(Right.FData) then
              begin
                case Node.FOperator of
                  coEQ: Operator := coISBLANK;
                  coNE: Operator := coNOTBLANK;
                else
                  DatabaseError(SExprBadNullTest);
                end;
                Result := PutNode(nodeUNARY, Operator, 1);
                SetNodeOp(Result, 0, PutExprNode(Left,Node.FOperator));
              end
{$IFNDEF NEXTGEN}
              else if (Right.FDataType in AnsiStringFieldTypes) then
              begin
                AnsiS := AnsiString(Right.FData);
                L := Length(AnsiS);
                if L <> 0 then
                begin
                  CaseInsensitive := 0;
                  PartialLength := 0;
                  if foCaseInsensitive in FOptions then CaseInsensitive := 1;
                  if Node.FPartial then PartialLength := L else
                    if not (foNoPartialCompare in FOptions) and (L > 1) and
                      (AnsiS[L] = '*') then
                    begin
                      Delete(AnsiS, L, 1);
                      PartialLength := L - 1;
                    end;
                  if (CaseInsensitive <> 0) or (PartialLength <> 0) then
                  begin
                    Result := PutNode(nodeCOMPARE, Operator, 4);
                    SetNodeOp(Result, 0, CaseInsensitive);
                    SetNodeOp(Result, 1, PartialLength);
                    SetNodeOp(Result, 2, PutExprNode(Left,Node.FOperator));
                    SetNodeOp(Result, 3, PutConstAnsiStr(AnsiS));
                  end;
                end;
              end
              else if (Right.FDataType in UnicodeStringFieldTypes) then
{$ELSE}
              else if (Right.FDataType in UnicodeStringFieldTypes) or (Right.FDataType in AnsiStringFieldTypes) then
{$ENDIF !NEXTGEN}
              begin
                WideS := string(Right.FData);                                                         
                L := WideS.Length;
                if L <> 0 then
                begin
                  CaseInsensitive := 0;
                  PartialLength := 0;
                  if foCaseInsensitive in FOptions then CaseInsensitive := 1;
                  if Node.FPartial then PartialLength := L else
                    if not (foNoPartialCompare in FOptions) and (L > 1) and
                      (WideS.Chars[L-1] = '*') then
                    begin
                      WideS.Remove(L - 1, 1);
                      PartialLength := L - 1;
                    end;
                  if (CaseInsensitive <> 0) or (PartialLength <> 0) then
                  begin
                    Result := PutNode(nodeCOMPARE, Operator, 4);
                    SetNodeOp(Result, 0, CaseInsensitive);
                    SetNodeOp(Result, 1, PartialLength);                                                                   
                    SetNodeOp(Result, 2, PutExprNode(Left,Node.FOperator));
                    SetNodeOp(Result, 3, PutConstUnicodeStr(WideS));
                  end;
                end;
              end;
            end;

            if Result = 0 then
            begin
              if (Operator = coISBLANK) or (Operator = coNOTBLANK) then
              begin
                Result := PutNode(nodeUNARY, Operator, 1);
                LeftPos := PutExprNode(Left,Node.FOperator);
                SetNodeOp(Result, 0, LeftPos);
              end else
              begin
                Result := PutNode(nodeBINARY, Operator, 2);
                LeftPos := PutExprNode(Left,Node.FOperator);
                RightPos := PutExprNode(Right,Node.FOperator);
                SetNodeOp(Result, 0, LeftPos);
                SetNodeOp(Result, 1, RightPos);
              end;
            end;
          end;
      end;
    enFunc:
      begin
        Result := PutNode(nodeFUNC, coFUNC2, 2);
        if VarIsArray(Node.FData) then
          SetNodeOp(Result, 0,  PutData(PByte(TArray<Byte>(Node.FData)),
            Length(TArray<Byte>(Node.FData)) + 1))
        else
          SetNodeOp(Result, 0, PutData(M.AsAnsi(VarToStr(Node.FData)).ToPointer,
            VarToStr(Node.FData).Length + 1));
        if Node.FArgs <> nil then
        begin
          ListElem := PutNode(nodeLISTELEM, coLISTELEM2, 2);
          SetNodeOp(Result, 1, ListElem);
          PrevListElem := ListElem;
          for I := 0 to Node.FArgs.Count - 1 do
          begin
            LeftPos := PutExprNode(Node.FArgs.Items[I],Node.FOperator);
            if I = 0 then
            begin
              SetNodeOp(PrevListElem, 0, LeftPos);
              SetNodeOp(PrevListElem, 1, 0);
            end
            else
            begin
              ListElem := PutNode(nodeLISTELEM, coLISTELEM2, 2);
              SetNodeOp(ListElem, 0, LeftPos);
              SetNodeOp(ListElem, 1, 0);
              SetNodeOp(PrevListElem, 1, ListElem);
              PrevListElem := ListElem;
            end;
          end;
        end else
          SetNodeOp(Result, 1, 0);
      end;
  end;
end;


function TFilterExpr.PutFieldNode(Field: TField; Node: PExprNode): Integer;
{$IFNDEF NEXTGEN}
var
  Buffer: array[0..255] of AnsiChar;
begin
  if poFieldNameGiven in FParserOptions then
    FDataSet.Translate(PAnsiChar(MetaDataFromUnicode(Field.FieldName)), @Buffer, True)
  else
  begin
    if FUnicodeEnabled then
      FDataSet.Translate(PAnsiChar(MetaDataFromUnicode(Node.FData)), @Buffer, True)
    else
      FDataSet.Translate(PAnsiChar(AnsiString(Node.FData)), @Buffer, True);
  end;
  Result := PutNode(nodeFIELD, coFIELD2, 2);
  SetNodeOp(Result, 0, Field.FieldNo);
  SetNodeOp(Result, 1, PutData(@Buffer, Length(Buffer) + 1));
end;
{$ELSE}
{$IFNDEF POSIX}
const
  CP_UTF8 = 65001;
{$ENDIF !POSIX}
var
  Buffer: array[0..255] of Byte;
  M: TMarshaller;
  Ptr: Pointer;
  DataLen: Integer;
begin
  if poFieldNameGiven in FParserOptions then
  begin
    Ptr := M.AsUTF8(Field.FieldName).ToPointer;
    DataLen := Field.FieldName.Length;
    if DataLen < Length(Buffer) then
      Move(Ptr^, Buffer[0], DataLen+1)
    else
    begin
      Move(Ptr^, Buffer[0], Length(Buffer) - 1);
      Buffer[Length(Buffer)-1] := 0;
    end;
  end
  else
  begin
    if FUnicodeEnabled then
    begin
      DataLen := LocaleCharsFromUnicode(CP_UTF8, 0, PWideChar(string(Node.FData)), Length(string(Node.FData)) + 1, nil, 0, nil, nil);
      Ptr := M.AsUTF8(Node.FData).ToPointer;
    end
    else
    begin
      DataLen := LocaleCharsFromUnicode(DefaultSystemCodePage, 0, PWideChar(string(Node.FData)), Length(string(Node.FData)) + 1, nil, 0, nil, nil);
      Ptr := M.AsAnsi(Node.FData).ToPointer;
    end;
    if DataLen < Length(Buffer) then
      Move(Ptr^, Buffer[0], DataLen)
    else
    begin
      Move(Ptr^, Buffer[0], Length(Buffer) - 1);
      Buffer[Length(Buffer)-1] := 0;
    end;
  end;
  Result := PutNode(nodeFIELD, coFIELD2, 2);
  SetNodeOp(Result, 0, Field.FieldNo);
  SetNodeOp(Result, 1, PutData(@Buffer, Length(Buffer) + 1));
end;
{$ENDIF !NEXTGEN}

function TFilterExpr.PutNode(NodeType: NodeClass; OpType: TCANOperator;
  OpCount: Integer): Integer;
var
  Size: Integer;
  Data: PByte;
begin
  Size := CANHDRSIZE + OpCount * SizeOf(Word);
  Data := GetExprData(CANEXPRSIZE + FExprNodeSize, Size);
  PInteger(@Data[0])^ := Integer(NodeType); { CANHdr.nodeClass }
  PInteger(@Data[4])^ := Integer(OpType);   { CANHdr.coOp }
  Result := FExprNodeSize;
  Inc(FExprNodeSize, Size);
end;

procedure TFilterExpr.SetNodeOp(Node, Index: Integer; Data: NativeInt);
begin
  PWordArray(PByte(FExprBuffer) + (CANEXPRSIZE + Node +
    CANHDRSIZE))^[Index] := Data;
end;

function TFilterExpr.GetFieldByName(Name: string) : TField;
var
  I: Integer;
  F: TField;
  FieldInfo: TFieldInfo;
begin
  Result := nil;
  if poFieldNameGiven in FParserOptions then
    Result := FDataSet.FieldByName(FFieldName)
  else if poUseOrigNames in FParserOptions then
  begin
    for I := 0 to FDataset.FieldCount - 1 do
    begin
      F := FDataSet.Fields[I];
      if GetFieldInfo(F.Origin, FieldInfo) and
         (CompareStr(Name, FieldInfo.OriginalFieldName) = 0) then
      begin
        Result := F;
        Exit;
      end;
    end;
  end;
  if Result = nil then
    Result := FDataSet.FieldByName(Name);
  if (Result <> nil) and (Result.FieldKind = fkCalculated) and (poAggregate in FParserOptions) then
    DatabaseErrorFmt(SExprNoAggOnCalcs, [Result.FieldName]);
  if (poFieldDepend in FParserOptions) and (Result <> nil) and
     (FDependentFields <> nil) then
    FDependentFields[Result.FieldNo-1] := True;
end;

constructor TExprParser.Create(DataSet: TDataSet; const Text: string;
  Options: TFilterOptions; ParserOptions: TParserOptions; const FieldName: string;
  DepFields: TBits; FieldMap: TFieldMap; UnicodeEnabled: Boolean );
begin
  FDecimalSeparator := Char(FormatSettings.DecimalSeparator);
  FFieldMap := FieldMap;
  FStrTrue := STextTrue;
  FStrFalse := STextFalse;
  FDataSet := DataSet;
  FDependentFields := DepFields;
  FUnicodeEnabled := UnicodeEnabled;
  FFilter := TFilterExpr.Create(DataSet, Options, ParserOptions, FieldName,
    DepFields, FieldMap, FUnicodeEnabled);
  if Text <> '' then
    SetExprParams(Text, Options, ParserOptions, FieldName);
end;

destructor TExprParser.Destroy;
begin
  FFilter.Free;
end;

procedure  TExprParser.SetExprParams(const Text: string; Options: TFilterOptions;
  ParserOptions: TParserOptions; const FieldName: string);
var
  Root, DefField: PExprNode;
begin
  FParserOptions := ParserOptions;
  if FFilter <> nil then
    FFilter.Free;
  FFilter := TFilterExpr.Create(FDataSet, Options, ParserOptions, FieldName,
    FDependentFields, FFieldMap, FUnicodeEnabled);
  FText := Text;
  FSourcePtr := PChar(Text);
  FFieldName := FieldName;
  NextToken;
  Root := ParseExpr;
  if FToken <> etEnd then DatabaseError(SExprTermination);
  if (poAggregate in FParserOptions) and (Root.FScopeKind <> skAgg) then
     DatabaseError(SExprNotAgg);
  if (not (poAggregate in FParserOptions)) and (Root.FScopeKind = skAgg) then
     DatabaseError(SExprNoAggFilter);
  if poDefaultExpr in ParserOptions then
  begin
    DefField := FFilter.NewNode(enField, coNOTDEFINED, FFieldName, nil, nil);
    if (IsTemporal(DefField.FDataType) and (Root.FDataType in StringFieldTypes)) or
       ((DefField.FDataType = ftBoolean ) and (Root.FDataType in StringFieldTypes)) then
      Root.FDataType := DefField.FDataType;

    if not ((IsTemporal(DefField.FDataType) and IsTemporal(Root.FDataType))
       or (IsNumeric(DefField.FDataType) and IsNumeric(Root.FDataType))
       or ((DefField.FDataType in StringFieldTypes) and (Root.FDataType in StringFieldTypes))
       or ((DefField.FDataType = ftBoolean) and (Root.FDataType = ftBoolean))) then
      DatabaseError(SExprTypeMis);
    Root := FFilter.NewNode(enOperator, coASSIGN, Unassigned, Root, DefField);
  end;

  if not (poAggregate in FParserOptions) and not(poDefaultExpr in ParserOptions)
     and (Root.FDataType <> ftBoolean ) then
     DatabaseError(SExprIncorrect);

  FFilterData := FFilter.GetFilterData(Root);
  FDataSize := FFilter.FExprBufSize;
end;

function TExprParser.NextTokenIsLParen : Boolean;
var
  P : PChar;
begin
  P := FSourcePtr;
  while (P^ <> #0) and (P^ <= ' ') do Inc(P);
  Result := P^ = '(';
end;

function EndOfLiteral(var P : PChar): Boolean;
var
  FName: string;
  PTemp: PChar;
begin
  Inc(P);
  Result := P^ <> '''';
  if Result then
  begin      // now, look for 'John's Horse'
    if StrScan(P, '''') <> nil then     // found another '
    begin
      PTemp := P;  // don't advance P
      while ((PTemp[0] = ' ') or (PTemp[0] = ')')) do Inc(PTemp);
      if NextSQLToken(PTemp, FName, stValue) in [stFieldName, stUnknown] then
      begin   // 'John's Horse' case: not really end of literal
        Result := False;
        Dec(P);
      end;
    end;
  end;
end;

procedure TExprParser.NextToken;
var
  P, TokenStart: PChar;
  L: Integer;
  StrBuf: array of Char;

  procedure Skip(const TheSet: string);

    function CharInStr(C: Char; const S: string): Boolean; inline;
    var
      LChar: Char;
    begin
      for LChar in S do
        if C = LChar then
          Exit(True);
      Result := False;
    end;

  begin
    while True do
    begin
      if (P^ >= #$0100) or CharInStr(P^, TheSet) then
        Inc(P)
      else
        Exit;
    end;
  end;

begin
  SetLength(StrBuf, 256);
  FPrevToken := FToken;
  FTokenString := '';
  P := FSourcePtr;
  while (P^ <> #0) and (P^ <= ' ') do Inc(P);
  if (P^ <> #0) and (P^ = '/') and (P[1] <> #0) and (P[1] = '*') then
  begin
    P := P + 2;
    while (P^ <> #0) and (P^ <> '*') do Inc(P);
    if (P^ = '*') and (P[1] <> #0) and (P[1] =  '/')  then
      P := P + 2
    else
      DatabaseErrorFmt(SExprInvalidChar, [P^]);
  end;
  while (P^ <> #0) and (P^ <= ' ') do Inc(P);
  FTokenPtr := P;
  case P^ of
    'A'..'Z', 'a'..'z', '_', WideChar($0081)..WideChar($00fe), #$0100..#$FFFD:
      begin
        TokenStart := P;
        Skip('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.[]');
        SetString(FTokenString, TokenStart, P - TokenStart);
        FToken := etSymbol;
        if string.Compare(FTokenString, 'LIKE', True) = 0 then   { do not localize }
          FToken := etLIKE
        else if string.Compare(FTokenString, 'IN', True) = 0 then   { do not localize }
          FToken := etIN
        else if string.Compare(FTokenString, 'IS', True) = 0 then    { do not localize }
        begin
          while (P^ <> #0) and (P^ <= ' ') do Inc(P);
          TokenStart := P;
          Skip('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz');
          SetString(FTokenString, TokenStart, P - TokenStart);
          if string.Compare(FTokenString, 'NOT', True)= 0 then  { do not localize }
          begin
            while (P^ <> #0) and (P^ <= ' ') do Inc(P);
            TokenStart := P;
            Skip('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz');
            SetString(FTokenString, TokenStart, P - TokenStart);
            if string.Compare(FTokenString, 'NULL', True) = 0 then
              FToken := etISNOTNULL
            else
              DatabaseError(SInvalidKeywordUse);
          end
          else if string.Compare (FTokenString, 'NULL', True) = 0  then  { do not localize }
          begin
            FToken := etISNULL;
          end
          else
            DatabaseError(SInvalidKeywordUse);
        end;
      end;
    '[':
      begin
        Inc(P);
        TokenStart := P;
        P := StrScan(P, ']');
        if P = nil then DatabaseError(SExprNameError);
        SetString(FTokenString, TokenStart, P - TokenStart);
        FToken := etName;
        Inc(P);
      end;
    '''':
      begin
        Inc(P);
        L := 0;
        while True do
        begin
          if P^ = #0 then DatabaseError(SExprStringError);
          if (P^ = '''') and EndOfLiteral(P) then Break;
          if L >= Length(StrBuf) - 1 then
            SetLength(StrBuf, Length(StrBuf)*2);
          if L < Length(StrBuf) - 1 then
          begin
            StrBuf[L] := P^;
            Inc(L);
          end;
          Inc(P);
        end;
        SetString(FTokenString, PChar(StrBuf), L);
        FToken := etLiteral;
        FNumericLit := False;
      end;
    '-', '0'..'9':
      begin
        if (FPrevToken <> etLiteral) and (FPrevToken <> etName) and
           (FPrevToken <> etSymbol)and (FPrevToken <> etRParen) then
          begin
            TokenStart := P;
            Inc(P);
            while (((P^ >= '0') and (P^ <= '9')) or (P^ = 'e') or (P^ = 'E') or (P^ = '+') or
                   (P^ = '-')) or (p^ = FDecimalSeparator) do
              Inc(P);
            if ((P-1)^ = ',') and (FDecimalSeparator = ',') and (P^ = ' ') then
              Dec(P);
            SetString(FTokenString, TokenStart, P - TokenStart);
            FToken := etLiteral;
            FNumericLit := True;
          end
        else
         begin
           FToken := etSUB;
           Inc(P);
         end;
      end;
    '(':
      begin
        Inc(P);
        FToken := etLParen;
      end;
    ')':
      begin
        Inc(P);
        FToken := etRParen;
      end;
    '<':
      begin
        Inc(P);
        case P^ of
          '=':
            begin
              Inc(P);
              FToken := etLE;
            end;
          '>':
            begin
              Inc(P);
              FToken := etNE;
            end;
        else
          FToken := etLT;
        end;
      end;
    '=':
      begin
        Inc(P);
        FToken := etEQ;
      end;
    '>':
      begin
        Inc(P);
        if P^ = '=' then
        begin
          Inc(P);
          FToken := etGE;
        end else
          FToken := etGT;
      end;
    '+':
      begin
        Inc(P);
        FToken := etADD;
      end;
    '*':
      begin
        Inc(P);
        FToken := etMUL;
      end;
    '/':
      begin
        Inc(P);
        FToken := etDIV;
      end;
    ',':
      begin
        Inc(P);
        FToken := etComma;
      end;
    #0:
      FToken := etEnd;
  else
    DatabaseErrorFmt(SExprInvalidChar, [P^]);
  end;
  FSourcePtr := P;
end;

function TExprParser.ParseExpr: PExprNode;
begin
  Result := ParseExpr2;
  while TokenSymbolIs('OR') do
  begin
    NextToken;
    Result := FFilter.NewNode(enOperator, coOR, Unassigned,
      Result, ParseExpr2);
    GetScopeKind(Result, Result.FLeft, Result.FRight);
    Result.FDataType := ftBoolean;
  end;
end;

function TExprParser.ParseExpr2: PExprNode;
begin
  Result := ParseExpr3;
  while TokenSymbolIs('AND') do
  begin
    NextToken;
    Result := FFilter.NewNode(enOperator, coAND, Unassigned,
      Result, ParseExpr3);
    GetScopeKind(Result, Result.FLeft, Result.FRight);
    Result.FDataType := ftBoolean;
  end;
end;

function TExprParser.ParseExpr3: PExprNode;
begin
  if TokenSymbolIs('NOT') then
  begin
    NextToken;
    Result := FFilter.NewNode(enOperator, coNOT, Unassigned,
      ParseExpr4, nil);
    Result.FDataType := ftBoolean;
  end else
    Result := ParseExpr4;
  GetScopeKind(Result, Result.FLeft, Result.FRight);
end;


function TExprParser.ParseExpr4: PExprNode;
const
  Operators: array[etEQ..etLT] of TCANOperator = (
    coEQ, coNE, coGE, coLE, coGT, coLT);
var
  Operator: TCANOperator;
  Left, Right: PExprNode;
begin
  Result := ParseExpr5;
  if (FToken in [etEQ..etLT]) or (FToken = etLIKE)
     or (FToken = etISNULL) or (FToken = etISNOTNULL)
     or (FToken = etIN) then
  begin
    case FToken of
      etEQ..etLT:
        Operator := Operators[FToken];
      etLIKE:
        Operator := coLIKE;
      etISNULL:
        Operator := coISBLANK;
      etISNOTNULL:
        Operator := coNOTBLANK;
      etIN:
        Operator := coIN;
      else
        Operator := coNOTDEFINED;
    end;
    NextToken;
    Left := Result;
    if Operator = coIN then
    begin
      if FToken <> etLParen then
        DatabaseErrorFmt(SExprNoLParen, [TokenName]);
      NextToken;
      Result := FFilter.NewNode(enOperator, coIN, Unassigned,
                 Left, nil);
      Result.FDataType := ftBoolean;
      if FToken <> etRParen then
      begin
        Result.FArgs := TList.Create;
        repeat
          Right := ParseExpr;
          if IsTemporal(Left.FDataType) then
            Right.FDataType := Left.FDataType
          else if (Right.FKind = enConst) and (Right.FDataType = ftString) and
              (Left.FDataType = ftWideString) then
            Right.FDataType := ftWideString;
          Result.FArgs.Add(Right);
          if (FToken <> etComma) and (FToken <> etRParen) then
            DatabaseErrorFmt(SExprNoRParenOrComma, [TokenName]);
          if FToken = etComma then NextToken;
        until (FToken = etRParen) or (FToken = etEnd);
        if FToken <> etRParen then
          DatabaseErrorFmt(SExprNoRParen, [TokenName]);
        NextToken;
      end else
        DatabaseError(SExprEmptyInList);
    end else
    begin
      if (Operator <> coISBLANK) and (Operator <> coNOTBLANK) then
        Right := ParseExpr5
      else
        Right := nil;
      Result := FFilter.NewNode(enOperator, Operator, Unassigned,
        Left, Right);
      if Right <> nil then
      begin
        if (Left.FKind = enField) and (Right.FKind = enConst) then
          begin
            Right.FDataType := Left.FDataType;
            Right.FDataSize := Left.FDataSize;
          end
        else if (Right.FKind = enField) and (Left.FKind = enConst) then
          begin
            Left.FDataType := Right.FDataType;
            Left.FDataSize := Right.FDataSize;
          end
        else if (Left.FDataType = ftWideString) and (Right.FKind = enConst) and (Right.FDataType = ftString) then
          begin
            Right.FDataType := ftWideString;
          end
      end;
      if (Left.FDataType in BlobFieldTypes) and (Operator = coLIKE) then
      begin
        if Right.FKind = enConst then
        begin
          if Left.FDataType = ftWideMemo then
            Right.FDataType := ftWideString
          else
            Right.FDataType := ftString;
        end;
      end
      else if (Operator <> coISBLANK) and (Operator <> coNOTBLANK)
         and ((Left.FDataType in (BlobFieldTypes + [ftBytes])) or
         ((Right <> nil) and (Right.FDataType in (BlobFieldTypes + [ftBytes])))) then
        DatabaseError(SExprTypeMis);
      Result.FDataType := ftBoolean;
      if Right <> nil then
      begin
        if IsTemporal(Left.FDataType) and (Right.FDataType in StringFieldTypes) then
          Right.FDataType := Left.FDataType
        else if IsTemporal(Right.FDataType) and (Left.FDataType in StringFieldTypes) then
          Left.FDataType := Right.FDataType;
      end;
      GetScopeKind(Result, Left, Right);
    end;
  end;
end;

function TExprParser.ParseExpr5: PExprNode;
const
  Operators: array[etADD..etDIV] of TCANOperator = (
    coADD, coSUB, coMUL, coDIV);
var
  Operator: TCANOperator;
  Left, Right: PExprNode;
begin
  Result := ParseExpr6;
  while FToken in [etADD, etSUB] do
  begin
    if not (poExtSyntax in FParserOptions) then
      DatabaseError(SExprNoArith);
    Operator := Operators[FToken];
    Left := Result;
    NextToken;
    Right := ParseExpr6;
    Result := FFilter.NewNode(enOperator, Operator, Unassigned, Left, Right);
    TypeCheckArithOp(Result);
    GetScopeKind(Result, Left, Right);
  end;
end;

function TExprParser.ParseExpr6: PExprNode;
const
  Operators: array[etADD..etDIV] of TCANOperator = (
    coADD, coSUB, coMUL, coDIV);
var
  Operator: TCANOperator;
  Left, Right: PExprNode;
begin
  Result := ParseExpr7;
  while FToken in [etMUL, etDIV] do
  begin
    if not (poExtSyntax in FParserOptions) then
      DatabaseError(SExprNoArith);
    Operator := Operators[FToken];
    Left := Result;
    NextToken;
    Right := ParseExpr7;
    Result := FFilter.NewNode(enOperator, Operator, Unassigned, Left, Right);
    TypeCheckArithOp(Result);
    GetScopeKind(Result, Left, Right);
  end;
end;


function TExprParser.ParseExpr7: PExprNode;
var
  FuncName: string;
begin
  case FToken of
    etSymbol:
      if (poExtSyntax in FParserOptions)
         and  NextTokenIsLParen and TokenSymbolIsFunc(FTokenString) then
        begin
          Funcname := FTokenString;
          NextToken;
          if FToken <> etLParen then 
            DatabaseErrorFmt(SExprNoLParen, [TokenName]); 
          NextToken;
          if (string.Compare(FuncName, 'count', True) = 0) and (FToken = etMUL) then
          begin
            FuncName := 'COUNT(*)';
            NextToken;
          end;
          Result := FFilter.NewNode(enFunc, coNOTDEFINED, FuncName,
                    nil, nil);
          if FToken <> etRParen then
          begin
            Result.FArgs := TList.Create;
            repeat
              Result.FArgs.Add(ParseExpr);
              if (FToken <> etComma) and (FToken <> etRParen) then
                DatabaseErrorFmt(SExprNoRParenOrComma, [TokenName]); 
              if FToken = etComma then NextToken;
            until (FToken = etRParen) or (FToken = etEnd);
          end else 
            Result.FArgs := nil;

          GetFuncResultInfo(Result);
        end
      else if TokenSymbolIs('NULL') then
        begin
          Result := FFilter.NewNode(enConst, coNOTDEFINED, System.Variants.Null, nil, nil);
          Result.FScopeKind := skConst;
        end
      else if TokenSymbolIs(FStrTrue) then
        begin
          Result := FFilter.NewNode(enConst, coNOTDEFINED, 1, nil, nil);
          Result.FScopeKind := skConst;
        end
      else if TokenSymbolIs(FStrFalse) then
        begin
          Result := FFilter.NewNode(enConst, coNOTDEFINED, 0, nil, nil);
          Result.FScopeKind := skConst;
        end
      else
        begin
          Result := FFilter.NewNode(enField, coNOTDEFINED, FTokenString, nil, nil);
          Result.FScopeKind := skField;
        end;
    etName:
      begin
        Result := FFilter.NewNode(enField, coNOTDEFINED, FTokenString, nil, nil);
        Result.FScopeKind := skField;
      end;
    etLiteral:
      begin
        Result := FFilter.NewNode(enConst, coNOTDEFINED, FTokenString, nil, nil);
        if FNumericLit then Result.FDataType := ftFloat else
            Result.FDataType := ftString;
        Result.FScopeKind := skConst;
      end;
    etLParen:
      begin
        NextToken;
        Result := ParseExpr;
        if FToken <> etRParen then DatabaseErrorFmt(SExprNoRParen, [TokenName]);
      end;
  else
    DatabaseErrorFmt(SExprExpected, [TokenName]);
    Result := nil;
  end;
  NextToken;
end;

procedure  TExprParser.GetScopeKind(Root, Left, Right : PExprNode);
begin
  if (Left = nil) and (Right = nil) then Exit;
  if Right = nil then
  begin
    Root.FScopeKind := Left.FScopeKind;
    Exit;
  end;
  if ((Left.FScopeKind = skField) and (Right.FScopeKind = skAgg))
     or ((Left.FScopeKind = skAgg) and (Right.FScopeKind = skField)) then
    DatabaseError(SExprBadScope);
  if (Left.FScopeKind = skConst) and (Right.FScopeKind = skConst) then
    Root.FScopeKind := skConst
  else if (Left.FScopeKind = skAgg) or (Right.FScopeKind = skAgg) then
    Root.FScopeKind := skAgg
  else if (Left.FScopeKind = skField) or (Right.FScopeKind = skField) then
    Root.FScopeKind := skField;
end;

procedure TExprParser.GetFuncResultInfo(Node : PExprNode);
begin
  Node.FDataType := ftString;
  if (string.Compare(Node.FData, 'COUNT(*)', True) <> 0 )
     and (string.Compare(Node.FData,'GETDATE', True) <> 0 )
     and ( (Node.FArgs = nil ) or ( Node.FArgs.Count = 0) ) then
      DatabaseError(SExprTypeMis);

  if (Node.FArgs <> nil) and (Node.FArgs.Count > 0) then
     Node.FScopeKind := PExprNode(Node.FArgs.Items[0]).FScopeKind;
  if (string.Compare(Node.FData , 'SUM', True) = 0) or
     (string.Compare(Node.FData , 'AVG', True) = 0) then
  begin
    Node.FDataType := ftFloat;
    Node.FScopeKind := skAgg;
  end
  else if (string.Compare(Node.FData , 'MIN', True) = 0) or
          (string.Compare(Node.FData , 'MAX', True) = 0) then
  begin
    Node.FDataType := PExprNode(Node.FArgs.Items[0]).FDataType;
    Node.FScopeKind := skAgg;
  end
  else if  (string.Compare(Node.FData , 'COUNT', True) = 0) or
           (string.Compare(Node.FData , 'COUNT(*)', True) = 0) then
  begin
    Node.FDataType := ftInteger;
    Node.FScopeKind := skAgg;
  end
  else if (string.Compare(Node.FData , 'YEAR', True) = 0) or
          (string.Compare(Node.FData , 'MONTH', True) = 0) or
          (string.Compare(Node.FData , 'DAY', True) = 0) or
          (string.Compare(Node.FData , 'HOUR', True) = 0) or
          (string.Compare(Node.FData , 'MINUTE', True) = 0) or
          (string.Compare(Node.FData , 'SECOND', True) = 0 ) then
  begin
    Node.FDataType := ftInteger;
    Node.FScopeKind := PExprNode(Node.FArgs.Items[0]).FScopeKind;
  end
  else if string.Compare(Node.FData , 'GETDATE', True) = 0  then
  begin
    Node.FDataType := ftDateTime;
    Node.FScopeKind := skConst;
  end
  else if string.Compare(Node.FData , 'DATE', True) = 0  then
  begin
    Node.FDataType := ftDate;
    Node.FScopeKind := PExprNode(Node.FArgs.Items[0]).FScopeKind;
  end
  else if string.Compare(Node.FData , 'TIME', True) = 0  then
  begin
    Node.FDataType := ftTime;
    Node.FScopeKind := PExprNode(Node.FArgs.Items[0]).FScopeKind;
  end
  else if (string.Compare(Node.FData , 'UPPER', True) = 0) or
          (string.Compare(Node.FData , 'LOWER', True) = 0 ) or
          (string.Compare(Node.FData , 'SUBSTRING', True) = 0) then
  begin
    Node.FDataType := PExprNode(Node.FArgs.Items[0]).FDataType;
  end
  else if (string.Compare(Node.FData , 'TRIM', True) = 0) or
          (string.Compare(Node.FData , 'TRIMLEFT', True) = 0 ) or
          (string.Compare(Node.FData , 'TRIMRIGHT', True) = 0 ) then
  begin
    Node.FDataType := PExprNode(Node.FArgs.Items[0]).FDataType;
    if (Node.FArgs.Count = 2) then
      PExprNode(Node.FArgs.Items[1]).FDataType := PExprNode(Node.FArgs.Items[0]).FDataType;
  end;
end;

function TExprParser.TokenName: string;
begin
  if FSourcePtr = FTokenPtr then Result := SExprNothing else
  begin
    SetString(Result, FTokenPtr, FSourcePtr - FTokenPtr);
    Result := '''' + Result + '''';
  end;
end;

function TExprParser.TokenSymbolIs(const S: string): Boolean;
begin
  Result := (FToken = etSymbol) and (string.Compare(FTokenString, S, True) = 0);
end;


function TExprParser.TokenSymbolIsFunc(const S: string) : Boolean;
begin
  Result := (string.Compare(S, 'UPPER', True) = 0) or
            (string.Compare(S, 'LOWER', True) = 0) or
            (string.Compare(S, 'SUBSTRING', True) = 0) or
            (string.Compare(S, 'TRIM', True) = 0) or
            (string.Compare(S, 'TRIMLEFT', True) = 0) or
            (string.Compare(S, 'TRIMRIGHT', True) = 0) or
            (string.Compare(S, 'YEAR', True) = 0) or
            (string.Compare(S, 'MONTH', True) = 0) or
            (string.Compare(S, 'DAY', True) = 0) or
            (string.Compare(S, 'HOUR', True) = 0) or
            (string.Compare(S, 'MINUTE', True) = 0) or
            (string.Compare(S, 'SECOND', True) = 0) or
            (string.Compare(S, 'GETDATE', True) = 0) or
            (string.Compare(S, 'DATE', True) = 0) or
            (string.Compare(S, 'TIME', True) = 0) or
            (string.Compare(S, 'SUM', True) = 0) or
            (string.Compare(S, 'MIN', True) = 0) or
            (string.Compare(S, 'MAX', True) = 0) or
            (string.Compare(S, 'AVG', True) = 0) or
            (string.Compare(S, 'COUNT', True) = 0);

end;

procedure  TExprParser.TypeCheckArithOp(Node: PExprNode);
begin
  if IsNumeric(Node.FLeft.FDataType) and IsNumeric(Node.FRight.FDataType)  then
    Node.FDataType := ftFloat
  else if (Node.FLeft.FDataType in AnsiStringFieldTypes) and
     (Node.FRight.FDataType in AnsiStringFieldTypes) and (Node.FOperator = coADD) then
    Node.FDataType := ftString
  else if (Node.FLeft.FDataType in UnicodeStringFieldTypes) and
     (Node.FRight.FDataType in UnicodeStringFieldTypes) and (Node.FOperator = coADD) then
    Node.FDataType := ftWideString
  else if IsTemporal(Node.FLeft.FDataType) and IsNumeric(Node.FRight.FDataType) and
     (Node.FOperator = coADD) then
    Node.FDataType := ftDateTime
  else if IsTemporal(Node.FLeft.FDataType) and IsNumeric(Node.FRight.FDataType) and
     (Node.FOperator = coSUB) then
    Node.FDataType := Node.FLeft.FDataType
  else if IsTemporal(Node.FLeft.FDataType) and IsTemporal(Node.FRight.FDataType) and
     (Node.FOperator = coSUB) then
    Node.FDataType := ftFloat
  else if (Node.FLeft.FDataType in AnsiStringFieldTypes + UnicodeStringFieldTypes) and IsTemporal(Node.FRight.FDataType) and
     (Node.FOperator = coSUB) then
  begin
    Node.FLeft.FDataType := Node.FRight.FDataType;
    Node.FDataType := ftFloat;
  end
  else if ( Node.FLeft.FDataType in AnsiStringFieldTypes + UnicodeStringFieldTypes) and IsNumeric(Node.FRight.FDataType ) and
       (Node.FLeft.FKind = enConst) then
    Node.FLeft.FDataType := ftDateTime
  else if ((Node.FLeft.FDataType in UnicodeStringFieldTypes) or
           (Node.FRight.FDataType in UnicodeStringFieldTypes)) and (Node.FOperator = coADD) then
  begin
    if not (Node.FLeft.FDataType in UnicodeStringFieldTypes) and (Node.FLeft.FKind = enConst) then
      Node.FLeft.FDataType := ftWideString;
    if not (Node.FRight.FDataType in UnicodeStringFieldTypes) and (Node.FRight.FKind = enConst) then
      Node.FRight.FDataType := ftWideString;
    Node.FDataType := ftWideString;
  end
  else
    DatabaseError(SExprTypeMis);
end;

end.
