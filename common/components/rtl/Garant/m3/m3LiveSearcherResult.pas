unit m3LiveSearcherResult;

{ Библиотека "M3"         }
{ Автор: Люлин А.В. ©     }
{ Модуль: m3LiveSearcherResult - }
{ Начат: 19.02.2003 14:07 }
{ $Id: m3LiveSearcherResult.pas,v 1.3 2009/03/19 16:28:30 lulin Exp $ }

// $Log: m3LiveSearcherResult.pas,v $
// Revision 1.3  2009/03/19 16:28:30  lulin
// [$139443095].
//
// Revision 1.2  2008/02/14 17:30:34  lulin
// - cleanup.
//
// Revision 1.1  2004/09/02 08:09:48  law
// - cleanup.
//
// Revision 1.1  2003/02/19 14:11:13  law
// - new class: Tm3LiveSearcherResult.
//

{$I m3Define.inc}

interface

uses
  ActiveX,
  
  l3Types,
  l3Base,
  l3CacheableBase,

  m3IdxInt
  ;

type
  Tm3LiveSearcherResult = class(Tl3CacheableBase, Im3IndexSearcherResult)
    private
    // internal fields
      f_Stream   : IStream;
      f_ItemSize : Long;
    private
    // interface methods
      // Im3IndexSearcherResult
      procedure Reset;
        {* - переместиться на начало. }
      function  GetCount: LongInt;
        {* - получить количество элементов. }
      function  Get(const anItem     : Pointer;
                    const anItemSize : LongInt): LongBool;
        {* - получить текущий элемент. }
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(const aStream : IStream;
                         anItemSize    : Long);
        reintroduce;
        {-}
      class function Make(const aStream : IStream;
                          anItemSize    : Long): Im3IndexSearcherResult;
        {-}
  end;//Tm3LiveSearcherResult

implementation

uses
  m2COMLib
  ;

// start class Tm3LiveSearcherResult

constructor Tm3LiveSearcherResult.Create(const aStream : IStream;
                                         anItemSize    : Long);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_Stream := aStream;
 f_ItemSize := anItemSize;
end;

class function Tm3LiveSearcherResult.Make(const aStream : IStream;
                                          anItemSize    : Long): Im3IndexSearcherResult;
  {-}
var
 l_Result : Tm3LiveSearcherResult;
begin
 l_Result := Tm3LiveSearcherResult.Create(aStream, anItemSize);
 try
  Result := l_Result; 
 finally
  l3Free(l_Result);
 end;//try..finally
end;

procedure Tm3LiveSearcherResult.Cleanup;
  //override;
  {-}
begin
 f_Stream := nil;
 inherited;
end;

procedure Tm3LiveSearcherResult.Reset;
  {* - переместиться на начало. }
begin
 if (f_Stream <> nil) then
  m2COMSeek(f_Stream, 0, STREAM_SEEK_SET);
end;

function  Tm3LiveSearcherResult.GetCount: LongInt;
  {* - получить количество элементов. }
begin
 if (f_Stream = nil) then
  Result := 0
 else
  Result := m2COMGetSize(f_Stream) div f_ItemSize; 
end;

function Tm3LiveSearcherResult.Get(const anItem     : Pointer;
                                   const anItemSize : LongInt): LongBool;
  {* - получить текущий элемент. }
var
 l_Result : hResult;
begin
 Assert(f_ItemSize = anItemSize);
 if (f_Stream = nil) then
  Result := false
 else begin
  l_Result := f_Stream.Read(anItem, anItemSize, nil);
  Result := l3IOk(l_Result) AND (l_Result <> S_False);
 end;//f_Stream = nil
end;

end.

