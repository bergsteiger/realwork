unit m4SearchExEx;
{* Высокоуровневые утилиты поиска по индексу. }

{ Библиотека "M4"         }
{ Автор: Люлин А.В. ©     }
{ Модуль: m4SearchExEx -  }
{ Начат: 25.12.2001 15:57 }
{ $Id: m4SearchExEx.pas,v 1.6 2014/09/11 14:42:02 lulin Exp $ }

// $Log: m4SearchExEx.pas,v $
// Revision 1.6  2014/09/11 14:42:02  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.5  2009/03/19 16:28:32  lulin
// [$139443095].
//
// Revision 1.4  2008/03/20 09:48:44  lulin
// - cleanup.
//
// Revision 1.3  2008/02/07 14:44:50  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.2  2007/12/06 11:41:03  lulin
// - cleanup.
//
// Revision 1.1  2004/09/02 07:15:23  law
// - cleanup.
//
// Revision 1.4  2002/04/19 09:19:17  law
// - new unit: m4DocumentAddress.
//
// Revision 1.3  2002/03/01 10:07:09  law
// - change type: _IStorage -> Im3IndexedStorage.
//
// Revision 1.2  2001/12/26 13:35:57  law
// - new behavior: попытка уменьшить время жизни корневого хранилища.
//
// Revision 1.1  2001/12/25 13:08:49  law
// - new unit: m4SearchExEx.
//

{$I m4Define.inc}

interface

uses
  l3Types,
  l3Base,
  l3LongintList,

  m3StorageInterfaces,

  m4DocumentAddress
  ;

function m4SearchByFormula(const anIndexFileName : String;
                           const aString         : Tl3PCharLen;
                           theAddresses          : Pm4Addresses = nil): Tl3LongintList;
  overload;
  {* - ищет в индексном файле по поисковой формуле. }
function m4SearchByFormula(const anIndex : Im3IndexedStorage;
                           const aString : Tl3PCharLen;
                           theAddresses  : Pm4Addresses = nil): Tl3LongintList;
  overload;
  {* - ищет в индексе по поисковой формуле. }

implementation

uses
//  m3StgMgr,
  
  m4Search,
  m4SearchFormula,
  m4SearchEx,
  l3String
  ;

function m4SearchByFormula(const anIndex : Im3IndexedStorage;
                           const aString : Tl3PCharLen;
                           theAddresses  : Pm4Addresses = nil): Tl3LongintList;
  {* - ищет в индексе по поисковой формуле. }
var
 l_Expr     : Tm4BaseExpression;
 l_Searcher : Tm4SearchEngine;
begin
 if (theAddresses <> nil) then
  theAddresses^ := nil;
 l_Expr := m4ParseSearchFormula(aString);
 try
  if (l_Expr = nil) then
   Result := nil
  else begin
   l_Searcher := Tm4SearchEngine.Create(anIndex);
   try
    Result := l_Searcher.Search(l_Expr, theAddresses);
   finally
    l3Free(l_Searcher);
   end;//try..finally
  end;//l_Expr = nil
 finally
  l3Free(l_Expr);
 end;//try..finally
end;

function m4SearchByFormula(const anIndexFileName : String;
                           const aString         : Tl3PCharLen;
                           theAddresses          : Pm4Addresses = nil): Tl3LongintList;
  //overload;
  {* - ищет в индексном файле по поисковой формуле. }
var
 l_Expr     : Tm4BaseExpression;
 l_Searcher : Tm4SearchEngine;
begin
 if (theAddresses <> nil) then
  theAddresses^ := nil;
 l_Expr := m4ParseSearchFormula(aString);
 try
  if (l_Expr = nil) then
   Result := nil
  else begin
   l_Searcher := Tm4SearchEngine.Create(anIndexFileName);
   try
    l3System.Msg2Log(l3Str(aString));
    Result := l_Searcher.Search(l_Expr, theAddresses);
   finally
    l3Free(l_Searcher);
   end;//try..finally
  end;//l_Expr = nil
 finally
  l3Free(l_Expr);
 end;//try..finally
end;
(*begin
 Result := m4SearchByFormula(Tm3ReadModeStorageManager.MakeInterface(anIndexFileName), aString, theAddresses);
end;*)

end.

