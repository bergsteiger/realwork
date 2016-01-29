unit vcmContentSimpleReader;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmContentSimpleReader - }
{ Начат: 10.03.2006 18:52 }
{ $Id: vcmContentSimpleReader.pas,v 1.3 2009/12/14 11:46:47 lulin Exp $ }

// $Log: vcmContentSimpleReader.pas,v $
// Revision 1.3  2009/12/14 11:46:47  lulin
// - готовимся к возврату более простых строк.
//
// Revision 1.2  2006/06/23 13:08:22  oman
// - fix: если файл кончился до вычитывания всех терминов ничего не делаем
//
// Revision 1.1  2006/03/10 18:22:01  lulin
// - работа над заливкой/выливкой строковых ресурсов.
//

{$Include vcmDefine.inc }

interface

uses
  l3Interfaces,
  l3Reader,

  vcmExternalInterfaces
  ;

type
  TvcmContentSimpleReader = class(Tl3Reader)
    private
    // internal fields
      f_Res  : IvcmResources;
    protected
    // internal methods
      procedure DoRead;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(const aFileName : String;
                         const aRes      : IvcmResources);
        reintroduce;
        overload;
        {-}
      class function Make(const aFileName : String;
                          const aRes      : IvcmResources): Il3Reader;
        reintroduce;
        overload;
        {-}
  end;//TvcmContentSimpleReader

implementation

uses
  StrUtils,

  l3Chars,
  l3Base,
  l3String,

  vcmContentConst
  ;

// start class TvcmContentSimpleReader

constructor TvcmContentSimpleReader.Create(const aFileName : String;
                                           const aRes      : IvcmResources);
  //reintroduce;
  //overload;
  {-}
begin
 inherited Create(aFileName);
 f_Res := aRes;
end;

class function TvcmContentSimpleReader.Make(const aFileName : String;
                                            const aRes      : IvcmResources): Il3Reader;
  //reintroduce;
  //overload;
  {-}
var
 l_Writer : TvcmContentSimpleReader;
begin
 l_Writer := Create(aFileName, aRes);
 try
  Result := l_Writer;
 finally
  l3Free(l_Writer);
 end;//try..finally
end;

procedure TvcmContentSimpleReader.Cleanup;
  //override;
  {-}
begin
 f_Res := nil;
 inherited;
end;

procedure TvcmContentSimpleReader.DoRead;
  //override;
  {-}

 procedure ReadTerm(var aTerm: String);
 var
  l_Str : String;
 begin//ReadTerm
  while not Filer.EOF do
  begin
   l_Str := l3PCharLen2String(Filer.ReadLn);
   if ANSIStartsText(c_vcmValueEnd, l_Str) then
    break;
   if (aTerm = '') then
    aTerm := l_Str
   else
    aTerm := aTerm + cc_EOL + l_Str;
  end;//while not Filer.EOF
 end;//ReadTerm
  
var
 l_Key   : String;
 l_Diff  : Integer;
 l_Rus   : String;
 l_Alien : String;
begin
 while not Filer.EOF do
 begin
  l_Key := l3PCharLen2String(Filer.ReadLn);
  if Filer.EOF then
   Break;
  if ANSIStartsText(c_vcmOpenKey, l_Key) then
  begin
   l_Diff := Length(c_vcmOpenKey);
   l_Key := Copy(l_Key, l_Diff + 1, Length(l_Key) - l_Diff);
  end;//ANSIStartsText(c_vcmOpenKey, l_Key)
  if ANSIEndsText(c_vcmCloseKey, l_Key) then
   SetLength(l_Key, Length(l_Key)-Length(c_vcmCloseKey));
  l_Rus := '';
  l_Alien := '';
  ReadTerm(l_Rus);
  if Filer.EOF then
   Break;
  ReadTerm(l_Alien);
  if Filer.EOF then
   Break;
  if (f_Res <> nil) then
   f_Res.Define(l_Key, l_Rus, l_Alien);
 end;//while not Filer.EOF
end;
  
end.

