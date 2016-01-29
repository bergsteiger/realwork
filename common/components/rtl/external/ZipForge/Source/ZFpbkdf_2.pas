unit ZFPBKDF_2;


interface


{$i STD.INC}

uses
  SysUtils, ZFKeyDeriv;

type

TPBKDF2 = class (TObject)
   private

      //the number of iterations
      FIterationNumber : Integer;
      //salt value for the password-based key derivation function
      FSaltValue : PByteArray;
      //the length of the salt value
      FSaltLength : Integer;
      //password
      FPassword : AnsiString;

   public
     //Create PBKDF2 object, based on the password, salt of the length SaltSize and the given number of iterations
     constructor Create(Password : AnsiString; SaltSize : Integer; Iterations : Integer);  overload;

     constructor Create(Password : AnsiString; Salt : PByteArray; SaltLength : Integer; Iterations : Integer);  overload;

     destructor Destroy; override;

     procedure GetKeyBytes(Cb : Integer; var Key : PByteArray);

     procedure Initialize();

     procedure Reset();

     function IterationCount : Integer;

     function GetSaltValue : PByteArray;

end;


implementation

     constructor TPBKDF2.Create(Password : AnsiString; SaltSize : Integer; Iterations : Integer);
     var Data : PByteArray;
         i : Integer;
     begin
        GetMem(Data, SaltSize);
        Self.FSaltLength := SaltSize;
        Randomize;
        for i := 0 to SaltSize - 1 do
           Data[i] := Byte(Random(255));

        Self.FPassword := Password;

        Self.FSaltValue := Data;
        Self.FIterationNumber := Iterations;

        Self.Initialize();
     end;

     destructor TPBKDF2.Destroy;
     begin
       FreeMem(Self.FSaltValue);
     end;

     constructor TPBKDF2.Create(Password : AnsiString; Salt : PByteArray; SaltLength : Integer; Iterations : Integer);
     var i : Integer;
     begin
        Self.FPassword := Password;
        Self.FSaltLength := SaltLength;
        GetMem(Self.FSaltValue, SaltLength);
        for i := 0 to SaltLength - 1 do
            Self.FSaltValue^[i] := Salt^[i];
        Self.FIterationNumber := Iterations;
        Self.Initialize;
     end;

     procedure TPBKDF2.GetKeyBytes(Cb : Integer; var Key : PByteArray);
     var Pass : array [1..32767] of AnsiChar;
         i : Integer;
     begin
       GetMem(Key, Cb);
       for i := 1 to Length(Self.FPassword) do
           Pass[i] := Self.FPassword[i];
       PBKDF2(@Pass, Length(Self.FPassword), Self.FSaltValue, Self.FSaltLength, Self.FIterationNumber, Key^, Cb);
     end;

     procedure TPBKDF2.Initialize();
     begin
     end;

     procedure TPBKDF2.Reset();
     begin
     end;

     function TPBKDF2.IterationCount : Integer;
     begin
        Result := Self.FIterationNumber;
     end;

     function TPBKDF2.GetSaltValue : PByteArray;
     var Res : PByteArray;
         i : Integer;
     begin
        GetMem(Res, Self.FSaltLength);
        for i:=0 to Self.FSaltLength-1 do
           Res[i]:=Self.FSaltValue[i];
        Result := Res;
     end;

end.


