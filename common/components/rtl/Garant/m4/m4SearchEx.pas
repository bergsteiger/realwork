unit m4SearchEx;
{* ѕоискова€ машина с возможностью поиска формул. }

{ Ѕиблиотека "M4"         }
{ јвтор: Ћюлин ј.¬. ©     }
{ ћодуль: m4SearchEx -    }
{ Ќачат: 19.12.2001 12:29 }
{ $Id: m4SearchEx.pas,v 1.7 2014/09/11 14:42:02 lulin Exp $ }

// $Log: m4SearchEx.pas,v $
// Revision 1.7  2014/09/11 14:42:02  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.6  2011/05/18 12:10:36  lulin
// {RequestLink:266409354}.
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
// Revision 1.2  2004/09/21 11:22:31  lulin
// - Release заменил на Cleanup.
//
// Revision 1.1  2004/09/02 07:15:23  law
// - cleanup.
//
// Revision 1.12  2003/02/18 18:07:05  law
// - optimization: добавл€ем документ в список найденных только один раз.
//
// Revision 1.11  2002/09/10 08:26:08  law
// - change: вместо Tm3DocumentAddress используем Im4Address.
//
// Revision 1.10  2002/04/24 15:46:05  law
// - bug fix: повисал поиск по названию.
//
// Revision 1.9  2002/04/19 12:01:57  law
// - new behavior: сделано получение списка адресов (дл€ подсветки).
//
// Revision 1.8  2002/04/19 09:19:17  law
// - new unit: m4DocumentAddress.
//
// Revision 1.7  2002/03/05 16:12:40  law
// - new behavior: реализован простейший поиск по полной базе документов.
//
// Revision 1.6  2002/03/01 10:07:09  law
// - change type: _IStorage -> Im3IndexedStorage.
//
// Revision 1.5  2001/12/26 18:26:22  law
// - bug fix: заточка под баг Delphi 5.
//
// Revision 1.4  2001/12/26 13:33:42  law
// - new behavior: попытка уменьшить врем€ жизни корневого хранилища.
//
// Revision 1.3  2001/12/25 16:53:07  voba
// - bug fix: совместимость с Delphi5.
//
// Revision 1.2  2001/12/20 14:12:12  law
// - new behavior: сделано использование морфологического разбора при поиске и индексации.
//
// Revision 1.1  2001/12/19 15:37:57  law
// - new behavior: сделаны поисковые операции »Ћ» и ».
//

{$Include m4Define.inc}

interface

uses
  ActiveX,
  
  l3Types,
  l3Base,
  l3LongintList,
  l3ProtoObject,

  m3StorageInterfaces,
  m3IdxInt,
  m3Index,

  m4Search,
  m4DocumentAddress
  ;

type
  Tm4SearchEngineTools = class;

  Tm4SearchEngine = class(Tl3ProtoObject)
   {* ѕоискова€ машина с возможностью поиска формул. }
    private
    // internal fields
      f_Searcher : Im3IndexSearcher;
      f_Extended : Bool;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      procedure CheckExtended(aTools: Tm4SearchEngineTools);
        {-}
    public
    // public methods
      constructor Create(const anIndexStorage: Im3IndexedStorage);
        reintroduce;
        overload;
        {* - создает поисковую машину. }
      constructor Create(const anIndexStorageName: String);
        overload;
        {* - создает поисковую машину. }
      function Search(anExpr       : Tm4BaseExpression;
                      theAddresses : Pm4Addresses = nil): Tl3LongintList;
        {* - ищет формулу. }
    public
    // public properties
      property Searcher: Im3IndexSearcher
        read f_Searcher
        write f_Searcher;
        {* - поискова€ машина. }
  end;//Tm4SearchEngine

  Tm4SearchEngineTools = class(Tm3ParaIndexBuilderTools)
    private
    // internal fields
      f_Extended : Bool;
    public
    // public methods
      function  Get(const AStream: IStream;
                    const AItem: Pointer;
                    const AItemSize: LongInt): LongBool;
        override;
        {* - считать адрес. }
      function  Compare(const AVal1: Pointer;
                        const AVal2: Pointer;
                        const ASize: LongInt): Integer;
        override;
        {-}
  end;//Tm4SearchEngineTools

implementation

uses
  Math,
  
  {$IfNDef Delphi6}
  l3Const,
  {$EndIf  Delphi6}

  l3Chars,
  l3String,

  m3DocumentAddress,
  m3StorageTools,
  m3IdxCla
  ;

// start class Tm4SearchEngine

constructor Tm4SearchEngine.Create(const anIndexStorage: Im3IndexedStorage);
  //reintroduce;
  {-}
var
 l_PackageStorageTools : Tm4SearchEngineTools;
begin
 inherited Create;
 l_PackageStorageTools := Tm4SearchEngineTools.Create(anIndexStorage);
 try
  CheckExtended(l_PackageStorageTools);
 finally
  l3Free(l_PackageStorageTools);
 end;//try.finally
end;

constructor Tm4SearchEngine.Create(const anIndexStorageName: String);
  //overload;
  {* - создает поисковую машину. }
var
 l_PackageStorageTools : Tm4SearchEngineTools;
begin
 inherited Create;
 l_PackageStorageTools := Tm4SearchEngineTools.Create(anIndexStorageName);
 try
  CheckExtended(l_PackageStorageTools);
 finally
  l3Free(l_PackageStorageTools);
 end;//try.finally
end;

procedure Tm4SearchEngine.CheckExtended(aTools: Tm4SearchEngineTools);
  {-}
var
 l_Stream : IStream;
begin
 f_Extended := l3IOk(m3COMSafeOpenStream(aTools.GetRootStorage(true),
                                         l3PCharLen(WideString('summary')),
                                         STGM_READ or STGM_SHARE_EXCLUSIVE,
                                         false,
                                         l_Stream)) AND (l_Stream <> nil);
 aTools.f_Extended := f_Extended;
 if f_Extended then
  Searcher := Tm3IndexSearcher.MakeInterface(aTools,
                                             aTools,
                                             aTools,
                                             aTools,
                                             aTools,
                                             SizeOf(Tm3DocumentAddress))
 else
  Searcher := Tm3IndexSearcher.MakeInterface(aTools,
                                             aTools,
                                             aTools,
                                             aTools,
                                             aTools,
                                             SizeOf(Tm3WordAddress));
end;
  
procedure Tm4SearchEngine.Cleanup;
  //override;
  {-}
begin
 Searcher := nil;
 inherited;
end;

function Tm4SearchEngine.Search(anExpr       : Tm4BaseExpression;
                                theAddresses : Pm4Addresses = nil): Tl3LongintList;
  {* - ищет формулу. }

var
 l_Normalizater : Im3Normalizater;
 l_Address      : Im4Address;
 l_Prev         : Long;
 l_This         : Long;
begin
 Result := nil;
 if (theAddresses <> nil) then
  theAddresses^ := nil;
 if (anExpr <> nil) then begin
  l_Normalizater := Searcher.GetNormalizater;
  try
   Result := Tl3LongintList.Create;
   try
    if f_Extended then begin
     Result.Sorted := true;
     l_Prev := -1;
     if (theAddresses = nil) then begin
      while anExpr.GetElement(Searcher, l_Normalizater, f_Extended, l_Address) do begin
       l_This := l_Address.Address.rDocument;
       if (l_This > l_Prev) then begin
        with Result do
         Insert(Count, l_This);
        l_Prev := l_This;
       end;//l_This <> l_Prev
      end;//while
     end else begin
      theAddresses^ := Tm4Addresses.Create;
      try
       while anExpr.GetElement(Searcher, l_Normalizater, f_Extended, l_Address) do begin
        l_This := l_Address.Address.rDocument;
        if (l_This > l_Prev) then begin
         with Result do
          Insert(Count, l_This);
         l_Prev := l_This;
        end;//l_This <> l_Prev
        theAddresses^.Add(l_Address);
       end;//while anExpr.GetElement..
      except
       l3Free(theAddresses^);
       raise;
      end;//try..except
     end;//theAddress = nil
    end else begin
     while anExpr.GetElement(Searcher, l_Normalizater, f_Extended, l_Address) do
      Result.Add(l_Address.Address.rPara);
    end;//f_Extended
   except
    l3Free(Result);
    raise;
   end;//try..except
  finally
   l_Normalizater := nil;
  end;//try..finally
 end;//anExpr <> nil
end;

// start class Tm4SearchEngineTools

function Tm4SearchEngineTools.Get(const AStream: IStream;
                                  const AItem: Pointer;
                                  const AItemSize: LongInt): LongBool;
  //override;
  {* - считать адрес. }
var
 l_Result : hResult;
begin
 l_Result := aStream.Read(aItem, aItemSize, nil);
 Result := l3IOk(l_Result) AND (l_Result <> S_False);
end;

function Tm4SearchEngineTools.Compare(const AVal1: Pointer;
                                      const AVal2: Pointer;
                                      const ASize: LongInt): Integer;
  //override;
  {-}
begin
 if f_Extended then begin
  if (aSize <> SizeOf(Tm3DocumentAddress)) then
   Result := -1
  else begin
   Result := Pm3DocumentAddress(AVal1).rDocument - Pm3DocumentAddress(AVal2).rDocument;
   if (Result = 0) then
    Result := inherited Compare(aVal1, aVal2, SizeOf(Tm3WordAddress))
   else
    Result := Sign(Result); 
  end;
 end else
  Result := inherited Compare(aVal1, aVal2, aSize);
end;

end.

