// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit map_int;

interface

uses
  orbtypes;

type

  ILongInterfaceMap = interface
  ['{61252F5A-4D23-11d4-9D27-204C4F4F5020}']
    procedure Put(Key: _ulong; Item: IUnknown);
    function Get(Key: _ulong): IUnknown;
    procedure clear();
    procedure erase(Key: _ulong);
    procedure Delete(Index: Integer);
    function count(): integer;
    function IndexOf(Item: IUnknown): integer;
    function Items(Index: integer): IUnknown;
    property Item[Key: _ulong]: IUnknown read Get write Put; default;
  end;

  ILongObjectMap = interface
    ['{49481980-CA85-4F61-BF8D-F731299BFD02}']
    procedure Put(Key: long; Item: TObject);
    function Get(Key: long): TObject;
    procedure clear();
    procedure erase(Key: long);
    procedure Delete(Index: Integer);
    function count(): integer;
    function IndexOf(Item: TObject): integer;
    function Items(Index: integer): TObject;
    property Item[Key: long]: TObject read Get write Put; default;
  end;

  IInterfaceLongMap = interface
  ['{61252F5B-4D23-11d4-9D27-204C4F4F5020}']
    procedure Put(Key: IUnknown;Item: long);
    function Get(Key: IUnknown): long;
    function IndexOf(Key: IUnknown): integer;
    procedure erase(Key: IUnknown);
    property Item[Key: IUnknown]: long read Get write Put; default;
  end;

  TInterfaceInterfaceMapCompare = function(const Item1, Item2: IInterface): boolean;

  IInterfaceInterfaceMap = interface
  ['{61252F5C-4D23-11d4-9D27-204C4F4F5020}']
    procedure Put(Key: IUnknown;Item: IUnknown);
    function Get(Key: IUnknown): IUnknown;
    function IndexOf(Key: IUnknown): integer;
    procedure Delete(Index: Integer);
    property Item[Key: IUnknown]: IUnknown read Get write Put; default;
    procedure erase(Key: IUnknown);
    function Count: integer;
    function Second(Index: Integer): IUnknown;
    function Find(Key: IInterface): IInterface; overload;
    procedure SetCompareFunc(AFunc: TInterfaceInterfaceMapCompare);
    procedure clear();
  end;

  IInterfaceStack = interface
  ['{22F20EEF-A3C8-4A74-93D8-96345AF0FC2E}']
    function Count: integer;
    function Peek: IInterface;
    function Pop: IInterface;
    procedure Push(const AIntf: IInterface);
    procedure Lock;
    procedure Unlock;
  end;

  IStringInterfaceMap = interface
  ['{4D921A6A-210C-46C9-8206-9497EBCACA14}']
    procedure Put(Key: AnsiString; const Item: IInterface);
    function Get(Key: AnsiString): IInterface;
    procedure Clear();
    procedure Erase(const Key: AnsiString);
    procedure Delete(Index: Integer);
    function Count(): Integer;
    function IndexOf(const Item: IInterface): AnsiString;
    function Items(Index: integer): IInterface;
    procedure Lock;
    procedure Unlock;

    property Item[Key: AnsiString]: IInterface read Get write Put; default;
  end;

implementation    

end.
