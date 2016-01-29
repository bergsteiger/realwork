{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXEncryption;

interface

uses
  Data.DBXPlatform,
  System.SysUtils;

type
  
  /// <summary> Cypher class using PC1 128bit key encryption algorithm.
  /// </summary>
  /// <remarks>  
  ///  Details at http://membres.lycos.fr/pc1/.
  /// 
  /// </remarks>
  TPC1Cypher = class sealed
  private
    ///Remporary field for use only while implementing this as an XOR Cypher
    TEMPXORVeri: Byte;
  public
    
    /// <summary> Default constructor.
    /// </summary>
    constructor Create; overload;
    
    /// <summary> Key based constructor
    ///
    /// </summary>
    /// <param name="key">String - Symmetric key</param>
    constructor Create(const Key: string); overload;
    
    /// <summary> Encrypts the byte argument using the encryption key.
    /// </summary>
    /// <remarks> 
    /// </remarks>
    /// <param name="c">byte - un-encrypted byte</param>
    /// <returns>encrypted byte</returns>
    function Cypher(const C: Byte): Byte;
    
    /// <summary> Decrypts the encrypted byte
    ///  
    /// </summary>
    /// <param name="c">byte - encrypted byte</param>
    /// <returns>byte - decrypted byte</returns>
    function Decypher(const C: Byte): Byte;
    
    /// <summary> Set the 128bit (16 bytes) key. They key is formed from the ASCII code
    /// </summary>
    /// <remarks> They key is formed from the ASCII code
    ///  of the character string passed as argument. If the key is shorter, space 
    ///  character is appended. If the key is longer, only the first 16 characters
    ///  are used. After internal key is build the parameter is preserved for 
    ///  future use.
    ///   
    /// </remarks>
    /// <param name="key">String - string out of which key is made, should not be null</param>
    /// <returns>boolean - false if the key was partially used</returns>
    function SetEncryptionKey(const Key: string): Boolean;
    
    /// <summary> Resets the encryption registers, the object can be reused for a new 
    ///  encryption or decryption.
    /// </summary>
    procedure Reset;
  protected
    function GetEncryptionKey: string;
  private
    
    /// <returns>false is key length was different from KEYLEN and eventually space
    ///  characters were added</returns>
    function Init: Boolean;
    function Assemble: Integer;
    function Code(const I: Integer): Integer;
  private
    FSi: Integer;
    FX1a2: Integer;
    FX1a0: TDBXInt32s;
    
    /// <summary> Key holder
    /// </summary>
    FCle: TArray<Byte>;
    
    /// <summary> User password
    /// </summary>
    FCypherKey: string;
  public
    property EncryptionKey: string read GetEncryptionKey;
  private
    const Keylen = 16;
  end;

implementation
uses
  Data.DBXCommon,
  System.Math,
  Data.DBXClientResStrs;

function GenerateKey(KeyLength: Integer): string;
const
  Chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!';
var
  I, Len: Integer;
begin
  Randomize;
  Len := Chars.Length;
  Result := '';
  for I := 0 to KeyLength - 1 do
    Result := Result + Chars.Chars[Random(Len)];
end;

constructor TPC1Cypher.Create;
begin
  SetLength(FX1a0,8);
  SetLength(FCle,Keylen);
  inherited Create;
  SetEncryptionKey(GenerateKey(16));
end;

constructor TPC1Cypher.Create(const Key: string);
begin
  SetLength(FX1a0,8);
  SetLength(FCle,Keylen);
  inherited Create;
  SetEncryptionKey(Key);
end;

function TPC1Cypher.Init: Boolean;
var
  I, Len: Integer;
begin
  Len := Min(FCypherKey.Length, Keylen);
  for I := 0 to Len - 1 do
    FCle[I] := Ord(FCypherKey.Chars[I]);
  for I := Len to 15 do
    FCle[I] := Byte(32);
  for I := 0 to Length(FX1a0) - 1 do
    FX1a0[I] := 0;
  FSi := 0;
  FX1a2 := 0;
  Result := Len <> Keylen;
end;

function TPC1Cypher.Assemble: Integer;
var
  Inter: Integer;
begin
  FX1a0[0] := ((FCle[0] and 255) shl 8) or (FCle[1] and 255);
  Inter := Code(0);
  FX1a0[1] := FX1a0[0] xor (((FCle[2] and 255) shl 8) or (FCle[3] and 255));
  Inter := Inter xor Code(1);
  FX1a0[2] := FX1a0[1] xor (((FCle[4] and 255) shl 8) or (FCle[5] and 255));
  Inter := Inter xor Code(2);
  FX1a0[3] := FX1a0[2] xor (((FCle[6] and 255) shl 8) or (FCle[7] and 255));
  Inter := Inter xor Code(3);
  FX1a0[4] := FX1a0[3] xor (((FCle[8] and 255) shl 8) or (FCle[9] and 255));
  Inter := Inter xor Code(4);
  FX1a0[5] := FX1a0[4] xor (((FCle[10] and 255) shl 8) or (FCle[11] and 255));
  Inter := Inter xor Code(5);
  FX1a0[6] := FX1a0[5] xor (((FCle[12] and 255) shl 8) or (FCle[13] and 255));
  Inter := Inter xor Code(6);
  FX1a0[7] := FX1a0[6] xor (((FCle[14] and 255) shl 8) or (FCle[15] and 255));
  Inter := Inter xor Code(7);
  Result := Inter;
end;

function TPC1Cypher.Code(const I: Integer): Integer;
var
  Dx: Integer;
  Ax: Integer;
  Cx: Integer;
  Bx: Integer;
  Tmp: Integer;
begin
  Dx := FX1a2 + I;
  Ax := FX1a0[I];
  Cx := 346;
  Bx := 20021;
  Tmp := Ax;
  Ax := FSi;
  FSi := Tmp;
  Tmp := Ax;
  Ax := Dx;
  Dx := Tmp;
  if Ax <> 0 then
    Ax := Ax * Bx;
  Tmp := Ax;
  Ax := Cx;
  Cx := Tmp;
  if Ax <> 0 then
  begin
    Ax := Ax * FSi;
    Cx := Cx + Ax;
  end;
  Tmp := Ax;
  Ax := FSi;
  FSi := Tmp;
  Ax := Ax * Bx;
  Dx := Dx + Cx;
  IncrAfter(Ax);
  FX1a2 := Dx;
  FX1a0[I] := Ax;
  Result := Ax xor Dx;
end;

function TPC1Cypher.Cypher(const C: Byte): Byte;
var
  Inter: Integer;
  Cfc: Integer;
  Cfd: Integer;
  Compte: Integer;
begin
  Inter := Assemble;
  Cfc := (Inter shr 8) and 255;
  Cfd := (Inter and 255);
  for compte := 0 to 15 do
    FCle[Compte] := Byte(((FCle[Compte] and 255) xor (C and 255)));
  Result := Byte((C xor (Cfc xor Cfd)));
end;

function TPC1Cypher.Decypher(const C: Byte): Byte;
var
  Inter: Integer;
  Cfc: Integer;
  Cfd: Integer;
  Res: Byte;
  Compte: Integer;
begin
  Inter := Assemble;
  Cfc := (Inter shr 8) and 255;
  Cfd := (Inter and 255);
  Res := Byte((C xor (Cfc xor Cfd)));
  for compte := 0 to 15 do
    FCle[Compte] := Byte(((FCle[Compte] and 255) xor (Res and 255)));
  Result := Res;
end;

function TPC1Cypher.SetEncryptionKey(const Key: string): Boolean;
var
  I: Integer;
begin
  if Key.IsEmpty then
    raise TDBXError.Create(0, SKeyNotNull);
  FCypherKey := Key;
  Result := Init;

  TEMPXORVeri := 0;

  for I := 1 to Key.Length do
  begin
    TEMPXORVeri := TEMPXORVeri xor Ord(Key.Chars[I-1]);
  end;
end;

function TPC1Cypher.GetEncryptionKey: string;
begin
  Result := FCypherKey;
end;

procedure TPC1Cypher.Reset;
begin
  Init;
end;

end.

