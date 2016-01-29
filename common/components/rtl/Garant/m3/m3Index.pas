unit m3Index;

{ Библиотека "M3"         }
{ Автор: Люлин А.В. ©     }
{ Модуль: m3Index -       }
{ Начат: 19.12.2001 12:57 }
{ $Id: m3Index.pas,v 1.8 2014/11/05 12:28:56 lulin Exp $ }

// $Log: m3Index.pas,v $
// Revision 1.8  2014/11/05 12:28:56  lulin
// - перетряхиваем код.
//
// Revision 1.7  2014/09/11 14:07:32  lulin
// - постоянную часть теперь открывваем в режиме на чтение БЕЗ залочек.
//
// Revision 1.6  2014/02/13 10:31:39  lulin
// - рефакторим безликие списки.
//
// Revision 1.5  2013/04/12 16:25:08  lulin
// - отлаживаем под XE3.
//
// Revision 1.4  2009/03/19 16:28:30  lulin
// [$139443095].
//
// Revision 1.3  2005/02/14 15:12:01  lulin
// - изменены сигнатуры методов.
//
// Revision 1.2  2004/09/21 11:22:27  lulin
// - Release заменил на Cleanup.
//
// Revision 1.1  2004/09/02 08:09:48  law
// - cleanup.
//
// Revision 1.8  2002/02/21 15:58:16  law
// - optimization.
//
// Revision 1.7  2002/02/20 14:14:05  law
// - bug fix: неправильная функция сравнения адресов.
//
// Revision 1.6  2001/12/26 18:26:21  law
// - bug fix: заточка под баг Delphi 5.
//
// Revision 1.5  2001/12/26 13:33:41  law
// - new behavior: попытка уменьшить время жизни корневого хранилища.
//
// Revision 1.4  2001/12/24 14:44:57  voba
// - bug fix: подключили новый индексатор к Архивариусу.
//
// Revision 1.3  2001/12/20 14:12:11  law
// - new behavior: сделано использование морфологического разбора при поиске и индексации.
//
// Revision 1.2  2001/12/19 16:17:33  law
// - new behavior: реализована операция НО НЕ.
//
// Revision 1.1  2001/12/19 15:37:56  law
// - new behavior: сделаны поисковые операции ИЛИ и И.
//

{$I m3Define.inc}

interface

uses
  ActiveX,

  l3Types,
  l3Base,
  l3ProtoObject,

  m3StorageInterfaces,
  m3IdxInt
  ;

type
  Tm3ParaIndexBuilderTools = class(Tl3ProtoObject,
                                   Im3IndexStorageManager,
                                   Im3IndexReader,
                                   Im3IndexWriter,
                                   Im3IndexComparer,
                                   Im3Normalizater)
    private
    // property fields
      f_IndexStorage     : Im3IndexedStorage;
      f_IndexStorageName : AnsiString;
      f_Normalizater     : Im3Normalizater;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(const anIndexStorage: Im3IndexedStorage);
        reintroduce;
        overload;
        {-}
      constructor Create(const anIndexStorageName: AnsiString);
        overload;
        {-}
      function  GetRootStorage(const AReadOnly: LongBool): Im3IndexedStorage;
        {* - возвращает хранилище для индекса. }
      function  Get(const AStream: IStream;
                    const AItem: Pointer;
                    const AItemSize: LongInt): LongBool;
        virtual;            
        {* - считать адрес. }
      procedure Put(const AStream: IStream;
                    const AItem: Pointer;
                    const AItemSize: LongInt);
        {* - положить адрес. }
      function  Compare(const AVal1: Pointer;
                        const AVal2: Pointer;
                        const ASize: LongInt): Integer;
        virtual;                
        {* - сравнивает два адреса. }
    public
    // public properties
      property IndexStorage: Im3IndexedStorage
        read f_IndexStorage
        write f_IndexStorage;
        {-}
      property Normalizater: Im3Normalizater
        read f_Normalizater
        write f_Normalizater
        implements Im3Normalizater;
        {-}
  end;//Tm3ParaIndexBuilderTools

  Tm3_WordAddress = packed object
   {* Адрес слова. }
    public
    // public fields
      rPara : Longint;
        {* - параграф. }
      rWord : Word;
        {* - слово. }
  end;//Tm3_WordAddress

  Tm3WordAddress = packed object(Tm3_WordAddress)
   {* Адрес слова. }
    public
    // public methods
      function Compare(const aValue: Tm3_WordAddress): Integer;
        {* - сравнивает два адреса. }
      function CaseCompare(const aValue: Tm3_WordAddress): Integer;
        {* - сравнивает два адреса. Возвращает (-1, 0, +1). }
      function CaseHighCompare(const aValue: Tm3_WordAddress): Integer;
        {* - сравнивает старшие элементы двух адресов. Возвращает (-1, 0, +1). }
      function CaseLowCompare(const aValue: Tm3_WordAddress): Integer;
        {* - сравнивает младшие элементы двух адресов. Возвращает (-1, 0, +1). }
      function LowCompare(const aValue: Tm3_WordAddress): Integer;
        {* - сравнивает младшие элементы двух адресов. }
      function EQ(const aValue: Tm3_WordAddress): Bool;
        {* - проверяет два адреса на эквивалентность. }
  end;//Tm3WordAddress
  Pm3WordAddress = ^Tm3WordAddress;

  Rm3ParaIndexBuilderTools = class of Tm3ParaIndexBuilderTools;

const
  m3NullWordAddress : Tm3WordAddress = (rPara : -1; rWord : 0);  

implementation

uses
  {$IfDef Delphi6}
  Math,
  {$Else  Delphi6}
  l3Math,
  {$EndIf Delphi6}

  m2COMLib,

  m3StgMgr,
  m3Morph
  ;

// start class Tm3ParaIndexBuilderTools

constructor Tm3ParaIndexBuilderTools.Create(const anIndexStorage: Im3IndexedStorage);
  //reintroduce;
  {-}
begin
 inherited Create;
 IndexStorage := anIndexStorage;
 Normalizater := Tm3MorphNormalizater.MakeInterface;
end;

constructor Tm3ParaIndexBuilderTools.Create(const anIndexStorageName: AnsiString);
  //overload;
  {-}
begin
 inherited Create;
 f_IndexStorageName := anIndexStorageName;
 Normalizater := Tm3MorphNormalizater.MakeInterface;
end;

procedure Tm3ParaIndexBuilderTools.Cleanup;
  //override;
  {-}
begin
 Normalizater := nil;
 IndexStorage := nil;
 inherited;
end;

function Tm3ParaIndexBuilderTools.GetRootStorage(const AReadOnly: LongBool): Im3IndexedStorage;
  {* - возвращает хранилище для индекса. }
begin
 Result := IndexStorage;
 if (Result = nil) then begin
  if aReadOnly then
   Result := {Tm3ReadModeStorageManager}Tm3ConstantStorageManager.MakeInterface(f_IndexStorageName)
  else
   Result := Tm3FullModeStorageManager.MakeInterface(f_IndexStorageName);
 end;//Result = nil
end;

function Tm3ParaIndexBuilderTools.Get(const AStream: IStream;
                                      const AItem: Pointer;
                                      const AItemSize: LongInt): LongBool;
  {* - считать адрес. }
begin
 Result := false;
end;

procedure Tm3ParaIndexBuilderTools.Put(const AStream: IStream;
                                       const AItem: Pointer;
                                       const AItemSize: LongInt);
  {* - положить адрес. }
begin
 m2COMWriteBuffer(aStream, aItem^, aItemSize);
end;

function Tm3ParaIndexBuilderTools.Compare(const AVal1: Pointer;
                                          const AVal2: Pointer;
                                          const ASize: LongInt): Integer;
  {* - сравнивает два адреса. }
begin
 if (aSize <> SizeOf(Tm3_WordAddress)) then
  Result := -1
 else 
  Result := Pm3WordAddress(aVal1)^.CaseCompare(Pm3WordAddress(aVal2)^);
end;

// start objetc Tm3WordAddress

function Tm3WordAddress.Compare(const aValue: Tm3_WordAddress): Integer;
  {* - сравнивает два адреса. }
begin
 Result := rPara - aValue.rPara;
 if (Result = 0) then
  Result := Long(rWord) - Long(aValue.rWord);
end;

function Tm3WordAddress.EQ(const aValue: Tm3_WordAddress): Bool;
  {* - проверяет два адреса на эквивалентность. }
begin
 Result := (Compare(aValue) = 0);
end;

function Tm3WordAddress.CaseCompare(const aValue: Tm3_WordAddress): Integer;
  {* - сравнивает два адреса. Возвращает (-1, 0, +1). }
begin
 Result := Sign(Compare(aValue));
end;

function Tm3WordAddress.CaseHighCompare(const aValue: Tm3_WordAddress): Integer;
  {* - сравнивает старшие элементы двух адресов. Возвращает (-1, 0, +1). }
begin
 Result := Sign(rPara - aValue.rPara);
end;

function Tm3WordAddress.CaseLowCompare(const aValue: Tm3_WordAddress): Integer;
  {* - сравнивает младшие элементы двух адресов. Возвращает (-1, 0, +1). }
begin
 Result := Sign(LowCompare(aValue));
end;

function Tm3WordAddress.LowCompare(const aValue: Tm3_WordAddress): Integer;
  {* - сравнивает младшие элементы двух адресов. }
begin
 Result := (Long(rWord) - Long(aValue.rWord));
end;

end.

