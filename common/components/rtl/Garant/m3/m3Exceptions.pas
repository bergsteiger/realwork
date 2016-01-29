unit m3Exceptions;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3Exceptions.pas"
// Родные Delphi интерфейсы (.pas)
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\m3\m3Define.inc}

interface

uses
  l3Except,
  l3Base
  ;

type
  Em3Exception = class(El3Exception)
   public
    class procedure Check(aCondition: Boolean; const aMessage: String); overload;
  end;//Em3Exception

  Em3NoIndex = class(Em3Exception)
  end;//Em3NoIndex

  Em3InvalidStream = class(Em3Exception)
  end;//Em3InvalidStream

  Em3NilStream = class(Em3InvalidStream)
  end;//Em3NilStream

  Em3InvalidPositionOfRoot = class(Em3Exception)
  end;//Em3InvalidPositionOfRoot

  Em3InvalidOldPositionOfRoot = class(Em3InvalidPositionOfRoot)
   public
    class procedure Check(aPosition: Int64; aRootSize: Int64); overload;
  end;//Em3InvalidOldPositionOfRoot

  Em3InvalidNewPositionOfRoot = class(Em3InvalidPositionOfRoot)
   public
    class procedure Check(aPosition: Int64; aRootSize: Int64); overload;
  end;//Em3InvalidNewPositionOfRoot

  Tm3Int64Predicate = function (aPosition: Int64; aName: Tl3CustomString): Boolean of object;

  Em3InvalidStoreData = class(Em3Exception)
   public
    class procedure Check(aCondition: Boolean; const aMessage: String; aName: Tl3String; aData: Int64); overload;
    class procedure Check(aCondition: Tm3Int64Predicate; const aMessage: String; aName: Tl3String; aData: Int64); overload;
  end;//Em3InvalidStoreData

  Em3InvalidStreamSize = class(Em3InvalidStoreData)
   public
    class procedure Check(aCondition: Tm3Int64Predicate; aName: Tl3String; aData: Int64); overload;
  end;//Em3InvalidStreamSize

  Em3InvalidStreamPos = class(Em3InvalidStoreData)
   public
    class procedure Check(aCondition: Tm3Int64Predicate; aName: Tl3String; aData: Int64); overload;
  end;//Em3InvalidStreamPos

implementation

uses
  SysUtils
  ;

class procedure Em3InvalidOldPositionOfRoot.Check(aPosition: Int64; aRootSize: Int64);
begin
 Check(aPosition = aRootSize, Format('Неверная старая позиция рутового потока. aPosition = %d. aRootSize = %d', [aPosition, aRootSize]));
end;

class procedure Em3InvalidNewPositionOfRoot.Check(aPosition: Int64; aRootSize: Int64);
begin
 Check(aPosition = aRootSize, Format('Неверная новая позиция рутового потока. aPosition = %d. aRootSize = %d', [aPosition, aRootSize]));
end;

class procedure Em3Exception.Check(aCondition: Boolean; const aMessage: String);
begin
 if not aCondition then
  raise Self.Create(aMessage);
end;

class procedure Em3InvalidStoreData.Check(aCondition: Boolean; const aMessage: String; aName: Tl3String; aData: Int64);
begin
 Check(aCondition, Format('Документ #%S. %s: %d', [aName.AsString, aMessage, aData]));
end;

class procedure Em3InvalidStoreData.Check(aCondition: Tm3Int64Predicate; const aMessage: String; aName: Tl3String; aData: Int64);
begin
 Assert(Assigned(aCondition));
 Check(aCondition(aData, aName), aMessage, aName, aData);
end;

class procedure Em3InvalidStreamSize.Check(aCondition: Tm3Int64Predicate; aName: Tl3String; aData: Int64);
begin
 Check(aCondition, 'Неправильный размер потока', aName, aData);
end;

class procedure Em3InvalidStreamPos.Check(aCondition: Tm3Int64Predicate; aName: Tl3String; aData: Int64);
begin
 Check(aCondition, 'Неправильный указатель потока', aName, aData);
end;

end.