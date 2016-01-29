unit evTextParaOpEx;

{ Библиотека "Эверест"     }
{ Автор: Люлин А.В. ©      }
{ Модуль: evTextParaOpEx - }
{ Начат: 02.04.2001 18:09  }
{ $Id: evTextParaOpEx.pas,v 1.20 2014/04/10 16:32:21 lulin Exp $ }

// $Log: evTextParaOpEx.pas,v $
// Revision 1.20  2014/04/10 16:32:21  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.19  2014/03/18 11:09:50  dinishev
// {Requestlink:521610561}
//
// Revision 1.18  2013/04/04 11:18:52  lulin
// - портируем.
//
// Revision 1.17  2009/07/23 13:42:11  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.16  2009/03/31 12:04:37  lulin
// [$140286997].
//
// Revision 1.15  2008/05/08 16:10:55  lulin
// - изменения в рамках <K>: 90442475.
//
// Revision 1.14  2008/05/07 18:29:48  lulin
// - изменения в рамках <K>: 90441963.
//
// Revision 1.13  2008/04/09 17:57:08  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.12  2008/03/28 10:33:24  dinishev
// Bug fix: отъехало конвертирование при переходе в новый Everest
//
// Revision 1.11  2007/12/04 12:47:06  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.8.8.4  2007/09/14 13:26:07  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.8.8.3.2.1  2007/09/12 15:23:02  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.8.8.3  2007/08/14 15:19:22  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.8.8.2  2005/11/09 15:28:25  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.8.8.1  2005/07/19 08:25:03  lulin
// - избавился от посылки сообщений для конвертации текста параграфа - перевел конвертацию на общий механизм Search/_Replace.
//
// Revision 1.8  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.7  2005/03/19 16:39:51  lulin
// - спрятаны ненужные методы.
//
// Revision 1.6  2005/02/03 14:33:43  lulin
// - для Undo-записей используем фабричные методы ToUndo, вместо конструкторов.
//
// Revision 1.5  2004/09/21 12:55:41  lulin
// - Release заменил на Cleanup.
//
// Revision 1.4  2002/02/08 15:31:51  law
// - rename unit: evTxtPar -> evTextPara.
//
// Revision 1.3  2001/12/27 15:03:29  law
// - new constructors: добавлены два конструктора Tl3String.Make.
//
// Revision 1.2  2001/04/02 15:26:53  law
// - сделано объединение двух операций _OevTextConvert.
//
// Revision 1.1  2001/04/02 14:54:04  law
// - new behavior: в нулевом приближении сделан режим overwrite.
//

{$Include evDefine.inc }

interface

uses
  l3Interfaces,
  l3Types,
  l3Base,

  k2Interfaces,
  k2Op,
  k2InternalInterfaces,

  nevBase
  ;

type
  OevTextConvert = class(Tk2Op)
    private
    // internal fields
      f_OS  : Tl3String;
      f_NS  : Tl3String;
      f_Pos : Long;
      f_P   : Tl3Variant;
    protected
    // internal methods
      procedure DoUndo(const Container: InevOp);
        override;
        {-отменить операцию}
      procedure DoRedo(const Container: InevOp);
        override;
        {-повторить операцию}
      procedure Cleanup;
        override;
        {-}
      function  GetStart(out aCodePage: Integer): PAnsiChar;
        {-}
      function CanJoinWith(anOperation: Tk2Op): Bool;
        override;
        {-}
      function DoJoin(anOperation: Tk2Op): Tk2Op;
        override;
        {-соединяет две операции и возвращает:
          nil  - соединение неудачно
          Self - соединение удачно и все поместилось в старую запись
          New  - распределена новая операция }
    public
    // public methods
      class procedure ToUndo(const anOpPack : InevOp;
                             aPara    : Tl3Variant;
                             aPos           : Long;
                             const anOld    : Tl3PCharLen;
                             const aNew     : Tl3PCharLen);
        {-}
      constructor Create(aPara : Tl3Variant;
                         aPos        : Long;
                         const anOld : Tl3PCharLen;
                         const aNew  : Tl3PCharLen);
        reintroduce;
        {-}
  end;//OevTextConvert

implementation

uses
  SysUtils,
  
  l3InterfacesMisc,
  
  k2Tags,

  nevTools
  ;

// start class OevTextConvert

constructor OevTextConvert.Create(aPara : Tl3Variant;
                                  aPos        : Long;
                                  const anOld : Tl3PCharLen;
                                  const aNew  : Tl3PCharLen);
  //reintroduce;
  {-}
begin
 inherited Create;
 aPara.SetRef(f_P);
 f_Pos := aPos;
 f_OS := Tl3String.Make(anOld);
 f_NS := Tl3String.Make(aNew);
end;

class procedure OevTextConvert.ToUndo(const anOpPack : InevOp;
                                      aPara    : Tl3Variant;
                                      aPos           : Long;
                                      const anOld    : Tl3PCharLen;
                                      const aNew     : Tl3PCharLen);
  {-}
var
 l_Op : OevTextConvert;
begin
 if (anOpPack <> nil) then
 begin
  l_Op := Create(aPara, aPos, anOld, aNew);
  try
   l_Op.Put(anOpPack);
  finally
   l3Free(l_Op);
  end;//try..finally
 end;//anOpPack <> nil
end;

procedure OevTextConvert.Cleanup;
  {override;}
  {-}
begin
 FreeAndNil(f_P);
 l3Free(f_OS);
 l3Free(f_NS);
 inherited;
end;

function OevTextConvert.GetStart(out aCodePage: Integer): PAnsiChar;
  {-}
begin
 aCodePage := f_OS.CodePage;
 with f_P.Attr[k2_tiText] do
  if IsValid then
   with (AsObject As Tl3CustomString) do
   begin
    aCodePage := CodePage;
    Result := St + f_Pos;
   end // with (AsObject As Tl3CustomString) do
  else
   Result := nil; 
end;

procedure OevTextConvert.DoUndo(const Container: InevOp);
  {override;}
  {-отменить операцию}
var
 l_CP    : Integer;
 l_Start : PAnsiChar;
 l_Para  : InevPara;
begin
 l_Start := GetStart(l_CP);
 if (l_Start <> nil) then
 begin
  if l_CP <> f_OS.CodePage then
   f_OS.CodePage := l_CP;
  if l_CP = CP_Unicode then
   l3Move(f_OS.St^, l_Start^, f_OS.Len * SizeOf(WideChar))
  else
   l3Move(f_OS.St^, l_Start^, f_OS.Len);
  if f_P.QT(InevPara, l_Para) then
   l_Para.Invalidate([nev_spExtent]);
 end;
end;

procedure OevTextConvert.DoRedo(const Container: InevOp);
  {override;}
  {-повторить операцию}
var
 l_CP    : Integer;
 l_Start : PAnsiChar;
 l_Para  : InevPara; 
begin
 l_Start := GetStart(l_CP);
 if (l_Start <> nil) then
 begin
  if l_CP <> f_NS.CodePage then
   f_NS.CodePage := l_CP;
  if l_CP = CP_Unicode then
   l3Move(f_NS.St^, l_Start^, f_NS.Len * SizeOf(WideChar))
  else
   l3Move(f_NS.St^, l_Start^, f_NS.Len);
  if f_P.QT(InevPara, l_Para) then
   l_Para.Invalidate([nev_spExtent]);
 end; 
end;

function OevTextConvert.CanJoinWith(anOperation: Tk2Op): Bool;
  //override;
  {-}
begin
 Result := true;
end;

function OevTextConvert.DoJoin(anOperation: Tk2Op): Tk2Op;
  //override;
  {-соединяет две операции и возвращает:
    nil  - соединение неудачно
    Self - соединение удачно и все поместилось в старую запись
    New  - распределена новая операция }
begin
 if (anOperation Is OevTextConvert) AND
    f_P.IsSame(OevTextConvert(anOperation).f_P) AND
    (f_Pos + f_OS.Len = OevTextConvert(anOperation).f_Pos) then begin
  f_OS.JoinWith(OevTextConvert(anOperation).f_OS);
  f_NS.JoinWith(OevTextConvert(anOperation).f_NS);
  Result := Self;  
 end else
  Result := nil;   
end;

end.

