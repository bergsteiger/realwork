{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.ASE.Lexer;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Defaults, System.TypInfo;

type
  TASEToken = (atUnknown, atEOF, atKeyWord, atIdent, atString, atInteger,
    atFloat, atColon, atOpenBracket, atCloseBracket, atComma);

  TKeyWord = (kw_UNKNOWN, // special position, for all unknown key words
    kw_3DSMAX_ASCIIEXPORT,
    kw_COMMENT,
    kw_SCENE,
      kw_SCENE_FILENAME,
      kw_SCENE_FIRSTFRAME,
      kw_SCENE_LASTFRAME,
      kw_SCENE_FRAMESPEED,
      kw_SCENE_TICKSPERFRAME,
      kw_SCENE_BACKGROUND_STATIC,
      kw_SCENE_AMBIENT_STATIC,
    kw_MATERIAL_LIST,
      kw_MATERIAL_COUNT,
      kw_MATERIAL,
        kw_MATERIAL_NAME,
        kw_MATERIAL_CLASS,
        kw_MATERIAL_AMBIENT,
        kw_MATERIAL_DIFFUSE,
        kw_MATERIAL_SPECULAR,
        kw_MATERIAL_SHINE,
        kw_MATERIAL_SHINESTRENGTH,
        kw_MATERIAL_TRANSPARENCY,
        kw_MATERIAL_WIRESIZE,
        kw_MATERIAL_SHADING,
        kw_MATERIAL_XP_FALLOFF,
        kw_MATERIAL_SELFILLUM,
        kw_MATERIAL_FALLOFF,
        kw_MATERIAL_XP_TYPE,
        kw_NUMSUBMTLS,
        kw_SUBMATERIAL,
        kw_MAP_DIFFUSE,
          kw_MAP_NAME,
          kw_MAP_CLASS,
          kw_MAP_SUBNO,
          kw_MAP_AMOUNT,
          kw_BITMAP,
          kw_MAP_TYPE,
          kw_UVW_U_OFFSET,
          kw_UVW_V_OFFSET,
          kw_UVW_U_TILING,
          kw_UVW_V_TILING,
          kw_UVW_ANGLE,
          kw_UVW_BLUR,
          kw_UVW_BLUR_OFFSET,
          kw_UVW_NOUSE_AMT,
          kw_UVW_NOISE_SIZE,
          kw_UVW_NOISE_LEVEL,
          kw_UVW_NOISE_PHASE,
          kw_BITMAP_FILTER,
    kw_GEOMOBJECT,
      kw_NODE_NAME,
      kw_NODE_TM,
        // kw_NODE_NAME,
        kw_INHERIT_POS,
        kw_INHERIT_ROT,
        kw_INHERIT_SCL,
        kw_TM_ROW0,
        kw_TM_ROW1,
        kw_TM_ROW2,
        kw_TM_ROW3,
        kw_TM_POS,
        kw_TM_ROTAXIS,
        kw_TM_ROTANGLE,
        kw_TM_SCALE,
        kw_TM_SCALEAXIS,
        kw_TM_SCALEAXISANG,
      kw_MESH,
        kw_TIMEVALUE,
        kw_MESH_NUMVERTEX,
        kw_MESH_NUMFACES,
        kw_MESH_VERTEX_LIST,
          kw_MESH_VERTEX,
        kw_MESH_FACE_LIST,
          kw_MESH_FACE,
          kw_MESH_SMOOTHING,
          kw_MESH_MTLID,
        kw_MESH_NUMTVERTEX,
        kw_MESH_TVERTLIST,
          kw_MESH_TVERT,
        kw_MESH_NUMTVFACES,
        kw_MESH_TFACELIST,
          kw_MESH_TFACE,
        kw_MESH_NORMALS,
          kw_MESH_FACENORMAL,
          kw_MESH_VERTEXNORMAL,
    kw_PROP_MOTIONBLUR,
    kw_PROP_CASTSHADOW,
    kw_PROP_RECVSHADOW,
    kw_MATERIAL_REF
  );

  TKeyWordRec = record
    Str: string;
    Hash: Integer;
  end;

const
{$J+}
  // hash table for fast text processing
  // completed in implementation section
  KEY_WORDS: array[TKeyWord] of TKeyWordRec = (
    (Str: ''                         ),
    (Str: '*3DSMAX_ASCIIEXPORT'      ),
    (Str: '*COMMENT'                 ),
    (Str: '*SCENE'                   ),
    (Str: '*SCENE_FILENAME'          ),
    (Str: '*SCENE_FIRSTFRAME'        ),
    (Str: '*SCENE_LASTFRAME'         ),
    (Str: '*SCENE_FRAMESPEED'        ),
    (Str: '*SCENE_TICKSPERFRAME'     ),
    (Str: '*SCENE_BACKGROUND_STATIC' ),
    (Str: '*SCENE_AMBIENT_STATIC'    ),
    (Str: '*MATERIAL_LIST'           ),
    (Str: '*MATERIAL_COUNT'          ),
    (Str: '*MATERIAL'                ),
    (Str: '*MATERIAL_NAME'           ),
    (Str: '*MATERIAL_CLASS'          ),
    (Str: '*MATERIAL_AMBIENT'        ),
    (Str: '*MATERIAL_DIFFUSE'        ),
    (Str: '*MATERIAL_SPECULAR'       ),
    (Str: '*MATERIAL_SHINE'          ),
    (Str: '*MATERIAL_SHINESTRENGTH'  ),
    (Str: '*MATERIAL_TRANSPARENCY'   ),
    (Str: '*MATERIAL_WIRESIZE'       ),
    (Str: '*MATERIAL_SHADING'        ),
    (Str: '*MATERIAL_XP_FALLOFF'     ),
    (Str: '*MATERIAL_SELFILLUM'      ),
    (Str: '*MATERIAL_FALLOFF'        ),
    (Str: '*MATERIAL_XP_TYPE'        ),
    (Str: '*NUMSUBMTLS'              ),
    (Str: '*SUBMATERIAL'             ),
    (Str: '*MAP_DIFFUSE'             ),
    (Str: '*MAP_NAME'                ),
    (Str: '*MAP_CLASS'               ),
    (Str: '*MAP_SUBNO'               ),
    (Str: '*MAP_AMOUNT'              ),
    (Str: '*BITMAP'                  ),
    (Str: '*MAP_TYPE'                ),
    (Str: '*UVW_U_OFFSET'            ),
    (Str: '*UVW_V_OFFSET'            ),
    (Str: '*UVW_U_TILING'            ),
    (Str: '*UVW_V_TILING'            ),
    (Str: '*UVW_ANGLE'               ),
    (Str: '*UVW_BLUR'                ),
    (Str: '*UVW_BLUR_OFFSET'         ),
    (Str: '*UVW_NOUSE_AMT'           ),
    (Str: '*UVW_NOISE_SIZE'          ),
    (Str: '*UVW_NOISE_LEVEL'         ),
    (Str: '*UVW_NOISE_PHASE'         ),
    (Str: '*BITMAP_FILTER'           ),
    (Str: '*GEOMOBJECT'              ),
    (Str: '*NODE_NAME'               ),
    (Str: '*NODE_TM'                 ),
    (Str: '*INHERIT_POS'             ),
    (Str: '*INHERIT_ROT'             ),
    (Str: '*INHERIT_SCL'             ),
    (Str: '*TM_ROW0'                 ),
    (Str: '*TM_ROW1'                 ),
    (Str: '*TM_ROW2'                 ),
    (Str: '*TM_ROW3'                 ),
    (Str: '*TM_POS'                  ),
    (Str: '*TM_ROTAXIS'              ),
    (Str: '*TM_ROTANGLE'             ),
    (Str: '*TM_SCALE'                ),
    (Str: '*TM_SCALEAXIS'            ),
    (Str: '*TM_SCALEAXISANG'         ),
    (Str: '*MESH'                    ),
    (Str: '*TIMEVALUE'               ),
    (Str: '*MESH_NUMVERTEX'          ),
    (Str: '*MESH_NUMFACES'           ),
    (Str: '*MESH_VERTEX_LIST'        ),
    (Str: '*MESH_VERTEX'             ),
    (Str: '*MESH_FACE_LIST'          ),
    (Str: '*MESH_FACE'               ),
    (Str: '*MESH_SMOOTHING'          ),
    (Str: '*MESH_MTLID'              ),
    (Str: '*MESH_NUMTVERTEX'         ),
    (Str: '*MESH_TVERTLIST'          ),
    (Str: '*MESH_TVERT'              ),
    (Str: '*MESH_NUMTVFACES'         ),
    (Str: '*MESH_TFACELIST'          ),
    (Str: '*MESH_TFACE'              ),
    (Str: '*MESH_NORMALS'            ),
    (Str: '*MESH_FACENORMAL'         ),
    (Str: '*MESH_VERTEXNORMAL'       ),
    (Str: '*PROP_MOTIONBLUR'         ),
    (Str: '*PROP_CASTSHADOW'         ),
    (Str: '*PROP_RECVSHADOW'         ),
    (Str: '*MATERIAL_REF'            )
  );
{$J-}

type
  TAseLexer = class
  strict private
    procedure StringToKeyWord;
    procedure SkipBlanks; inline;
  private
    FAhead: Boolean;
    FASE: TextFile;
    FToken: TASEToken;

    FUseCommaToken: Boolean;

    FIdxCurChar: Integer;

    FLine: string;
    FLineId: Integer;
    FString: string;
    FKeyWord: TKeyWord;
    FFormatSettings: TFormatSettings;

    function GetTokenFloat: Single;
    function GetTokenInteger: Integer;
    function GetChar: Char;
  public
    constructor Create(const AFileName: string);
    destructor Destroy; override;

    function NextToken: TASEToken;
    procedure NextTokenExpected(AToken: TASEToken); inline;
    function IsExpectedToken(AToken: TASEToken): boolean;
    property Token: TASEToken read FToken;

    procedure SkipKeyWordBlock;

    function IsDigit: Boolean;
    function IsChar: Boolean;
    function IsCharUpper: Boolean;

    property TokenKeyWord: TKeyWord read FKeyWord;
    property TokenString: string read FString;
    property TokenIdent: string read FString;
    property TokenFloat: Single read GetTokenFloat;
    property TokenInteger: Integer read GetTokenInteger;
    property CurrentChar: Char read GetChar;

    property Ahead: boolean read FAhead write FAhead;
    property UseCommaToken: boolean read FUseCommaToken write FUseCommaToken;
  end;

  EAseLexerError = class(Exception);

implementation

uses
  FMX.Consts;

{ TAseParser }

constructor TAseLexer.Create(const AFileName: string);
begin
  AssignFile(FASE, AFileName);
  Reset(FASE);
  FFormatSettings := TFormatSettings.Create;
end;

destructor TAseLexer.Destroy;
begin
  CloseFile(FAse);
  inherited;
end;

function TAseLexer.GetChar: Char;
begin
  if (0 <= FIdxCurChar) and (FIdxCurChar < FLine.Length) then
    Result := FLine.Chars[FIdxCurChar]
  else
    Result := #0;
end;

function TAseLexer.GetTokenFloat: Single;
begin
  Result := StrToFloat(FString, FFormatSettings);
end;

function TAseLexer.GetTokenInteger: Integer;
begin
  Result := StrToInt(FString);
end;

function TAseLexer.NextToken: TASEToken;
begin
  if FAhead then
  begin
    FAhead := False;
    Exit(FToken);
  end;

  if FToken = atEOF then
    Exit(atEOF);

  while True do
  begin
    if CurrentChar = #0 then
    begin
      if EOF(FASE) then
      begin
        FToken := atEOF;
        Exit(atEOF);
      end;

      ReadLn(FASE, FLine);
      Inc(FLineId);
      if FLine = '' then
        Continue;
      FIdxCurChar := 0;
    end;

    SkipBlanks;

    if CurrentChar <> #0 then
      Break;
  end;

  FToken := atUnknown;

  case CurrentChar of
    '*':
      begin
        FString := '*';
        Inc(FIdxCurChar);

        while IsDigit or IsCharUpper or (CurrentChar = '_') do
        begin
          FString := FString + CurrentChar;
          Inc(FIdxCurChar);
        end;

        FToken := atKeyWord;
        StringToKeyWord;
      end;
    '"':
      begin
        FString := '';
        Inc(FIdxCurChar);

        // $D -> CL
        // $A -> CR
        while not (Byte(CurrentChar) in [Byte(#10), Byte(#13), Byte(#0), Byte('"')]) do
        begin
          FString := FString + CurrentChar;
          Inc(FIdxCurChar);
        end;

        if CurrentChar <> '"' then
          raise EAseLexerError.CreateResFmt(@SAseLexerCharError, [FLineId, '"', CurrentChar])
        else
          Inc(FIdxCurChar);

        FToken := atString;
      end;
    '{':
      begin
        FToken := atOpenBracket;
        Inc(FIdxCurChar);
      end;
    '}':
      begin
        FToken := atCloseBracket;
        Inc(FIdxCurChar);
      end;
    ':':
      begin
        FToken := atColon;
        Inc(FIdxCurChar);
      end;
    'a'..'z', 'A'..'Z', '_':
      begin
        FString := CurrentChar;
        Inc(FIdxCurChar);

        while IsDigit or IsChar or (CurrentChar = '_') do
        begin
          FString := FString + CurrentChar;
          Inc(FIdxCurChar);
        end;

        FToken := atIdent;
      end;
    '-', '0'..'9':
      begin
        FString := CurrentChar;
        Inc(FIdxCurChar);

        while IsDigit do
        begin
          FString := FString + CurrentChar;
          Inc(FIdxCurChar);
        end;

        if (not FUseCommaToken and (Byte(CurrentChar) in [Byte('.'), Byte(',')]))
          or (CurrentChar = '.') then
        begin
          FFormatSettings.DecimalSeparator := CurrentChar;
          FString := FString + CurrentChar;
          Inc(FIdxCurChar);
          while IsDigit do
          begin
            FString := FString + CurrentChar;
            Inc(FIdxCurChar);
          end;
          FToken := atFloat;
        end
        else
          FToken := atInteger;
      end;
    ',':
      if FUseCommaToken then
      begin
        FToken := atComma;
        Inc(FIdxCurChar);
      end;
    else
      Inc(FIdxCurChar);
  end;

  Result := FToken;
end;

procedure TAseLexer.NextTokenExpected(AToken: TASEToken);
var
  ExpectedTokenOk: Boolean;
begin
  NextToken;
  ExpectedTokenOk:= IsExpectedToken(AToken);
  if not ExpectedTokenOk then
    raise EAseLexerError.CreateResFmt(@SAseLexerTokenError, [FLineId,
        GetEnumName(TypeInfo(TASEToken), Integer(AToken)),
        GetEnumName(TypeInfo(TASEToken), Integer(FToken))]);
end;

procedure TAseLexer.SkipBlanks;
begin
  while Byte(CurrentChar) in [$1..$20] do
    Inc(FIdxCurChar);
end;

procedure TAseLexer.SkipKeyWordBlock;
var
  LBracketCount: Integer;
begin
  Assert(Token = atKeyWord);

  if NextToken = atOpenBracket then
  begin
    LBracketCount := 1;
    repeat
      case NextToken of
        atOpenBracket: Inc(LBracketCount);
        atCloseBracket: Dec(LBracketCount);
        atEOF: Exit;
      end;
    until (Token = atEOF) or (LBracketCount = 0);
    // NextToken;
  end
  else
  begin
    while not (NextToken in [atKeyWord, atEOF, atCloseBracket]) do
    {none};

    FAhead := True;
  end;
end;

procedure TAseLexer.StringToKeyWord;
var
  kw: TKeyWord;
  LHash: Integer;
begin
  {$IFDEF NEXTGEN}
  {$ZEROBASEDSTRINGS ON}
  LHash := BobJenkinsHash(FString[0], FString.Length * SizeOf(FString.Chars[0]), 2004);
  {$ZEROBASEDSTRINGS OFF}
  {$ELSE}
  LHash := BobJenkinsHash(FString[1], FString.Length * SizeOf(FString.Chars[0]), 2004);
  {$ENDIF}

  FKeyWord := kw_UNKNOWN;
  for kw := Succ(Low(TKeyWord)) to High(TKeyWord) do
    if KEY_WORDS[kw].Hash = LHash then
      if SameStr(FString, KEY_WORDS[kw].Str) then
      begin
        FKeyWord := kw;
        Exit;
      end;
end;

function TAseLexer.IsChar: Boolean;
begin
  Result := Byte(CurrentChar) in [Byte('A')..Byte('Z'), Byte('a')..Byte('z')];
end;

function TAseLexer.IsCharUpper: Boolean;
begin
  Result := Byte(CurrentChar) in [Byte('A')..Byte('Z')];
end;

function TAseLexer.IsDigit: Boolean;
begin
  Result := Byte(CurrentChar) in [Byte('0')..Byte('9')];
end;

function TAseLexer.IsExpectedToken(AToken: TASEToken): boolean;
begin
  Result:= True;
  if FToken <> AToken then
  begin
     Result:= False;
//     raise EAseLexerError.CreateResFmt(@SAseLexerTokenError, [FLineId,
//        GetEnumName(TypeInfo(TASEToken), Integer(AToken)),
//        GetEnumName(TypeInfo(TASEToken), Integer(FToken))]);
  end;
end;

procedure InitializeKeyWordsHash;
var
  kw: TKeyWord;
begin
  for kw := Succ(Low(TKeyWord)) to High(TKeyWord) do
  {$IFDEF NEXTGEN}
  {$ZEROBASEDSTRINGS ON}
    KEY_WORDS[kw].Hash := BobJenkinsHash(KEY_WORDS[kw].Str[0],
      KEY_WORDS[kw].Str.Length * SizeOf(KEY_WORDS[kw].Str.Chars[0]), 2004);
  {$ZEROBASEDSTRINGS OFF}
  {$ELSE}
    KEY_WORDS[kw].Hash := BobJenkinsHash(KEY_WORDS[kw].Str[1],
      KEY_WORDS[kw].Str.Length * SizeOf(KEY_WORDS[kw].Str.Chars[0]), 2004);
  {$ENDIF}
end;

begin
  InitializeKeyWordsHash;
end.
