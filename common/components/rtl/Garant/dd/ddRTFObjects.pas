unit ddRTFObjects;

// $Id: ddRTFObjects.pas,v 1.38 2014/08/08 08:13:03 dinishev Exp $ 

// $Log: ddRTFObjects.pas,v $
// Revision 1.38  2014/08/08 08:13:03  dinishev
// Cleanup
//
// Revision 1.37  2014/05/27 12:04:11  lulin
// - чистим код.
//
// Revision 1.36  2014/05/27 11:17:50  lulin
// - чистим код.
//
// Revision 1.35  2014/04/17 08:14:47  dinishev
// Чистка кода.
//
// Revision 1.34  2014/02/14 15:33:53  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.33  2013/07/18 12:15:19  dinishev
// Вычищаем кучу неиспользованного кода.
//
// Revision 1.32  2013/04/05 12:04:30  lulin
// - портируем.
//
// Revision 1.31  2013/01/22 12:34:19  narry
// Рефакторинг RTFReader
//
// Revision 1.30  2011/02/09 11:34:21  narry
// К253657673. Чтение картинок из RTF
//
// Revision 1.29  2010/11/30 11:47:16  lulin
// {RequestLink:228688602}.
// - борьба с предупреждениями.
//
// Revision 1.28  2010/02/24 18:16:27  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.27  2009/07/23 08:15:11  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.26  2008/03/21 14:09:22  lulin
// - cleanup.
//
// Revision 1.25  2008/02/14 09:40:33  lulin
// - удалён ненужный класс.
//
// Revision 1.24  2008/02/13 20:20:06  lulin
// - <TDN>: 73.
//
// Revision 1.23  2008/02/12 12:53:15  lulin
// - избавляемся от излишнего метода на базовом классе.
//
// Revision 1.22  2008/02/06 15:37:00  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.21  2008/02/05 09:58:00  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.20  2008/02/01 15:14:44  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.19  2008/01/31 20:09:55  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.18  2006/06/06 11:03:38  oman
// warning fix + пара функций превращена в процедуры.
//
// Revision 1.17  2006/05/06 13:31:05  lulin
// - cleanup.
//
// Revision 1.16  2005/04/19 15:41:42  lulin
// - переходим на "правильный" ProcessMessages.
//
// Revision 1.15  2004/09/21 12:21:05  lulin
// - Release заменил на Cleanup.
//
// Revision 1.14  2004/06/01 16:51:23  law
// - удален конструктор Tl3VList.MakePersistent - пользуйтесь _Tl3ObjectRefList.
//
// Revision 1.13  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.12  2000/12/15 15:29:55  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }

interface

Uses
  Classes,
  l3Base, l3Types,


  ddBase, RTFTypes,
  l3ObjectRefList
  , ddRTFKeywords,

  l3ProtoObject,
  l3ProtoObjectRefList
  ;

type
  TddRTFAtomType = (dd_rtfGroup, dd_rtfKeyword, dd_rtfText);

  TddRTFAtom = class(Tl3ProtoObject)
  {Надеюсь, что Шура не обидится и не будет обвинять меня в плагиате}
  private
   f_Type: TddRTFAtomType;
   f_Text: Tl3String;
   f_Keyword: TSYM;
   f_HasParam: Boolean;
   f_Param: Long;
   f_Content: Tl3ProtoObjectRefList;
  protected
   procedure Cleanup; override;
  public
   constructor MakeGroup;
   constructor MakeKeyword(aKeyword: TSYM; aHasParam: Boolean; aParam: Long; aText:
       Tl3String = nil);
   constructor MakeText(aText: Tl3String);

   procedure Clear; virtual;

   procedure PushState;
   procedure AddKeyword(aKeyword: TSYM; aHasParam: Boolean; aParam: Long; aText: Tl3String = nil);
   procedure AddText(aText: Tl3String); overload;
   procedure AddText(aText: AnsiChar); overload;
  public
   property AtomType: TddRTFAtomType
     read f_Type;
   property Content: Tl3ProtoObjectRefList
     read f_Content;
   property Text: Tl3String
     read f_Text write f_Text;
   property Keyword: TSYM read f_Keyword;
   property HasParam: Boolean
     read f_HasParam write f_HasParam;
   property Param: Long
     read f_Param write f_Param;
  end;


implementation

Uses
  SysUtils, Windows, Forms,

  l3Chars,

  afwFacade,

  Unicode,
  ddRTFconst
  ;

constructor TddRTFAtom.MakeGroup;
begin
 inherited Create;
 f_Keyword := nil;
 f_Type := dd_rtfGroup;
 f_Content := Tl3ProtoObjectRefList.Make;
end;

constructor TddRTFAtom.MakeKeyword(aKeyword: TSYM; aHasParam: Boolean; aParam:
    Long; aText: Tl3String = nil);
begin
 inherited Create;
 f_Type := dd_rtfKeyword;
 f_Keyword := aKeyword;
 f_HasParam := aHasParam;
 f_Param := aParam;
 if aKeyword = nil then
 begin
  f_Text := Tl3String.Create;
  f_Text.Assign(aText);
 end;
end;

constructor TddRTFAtom.MakeText(aText: Tl3String);
begin
 inherited Create;
 f_Type := dd_rtfText;
 f_Text := Tl3String.Create;
 f_Text.Assign(aText);
end;

procedure TddRTFAtom.Cleanup;
begin
 l3Free(f_Text);
 l3Free(f_Content);
 inherited;
end;

procedure TddRTFAtom.Clear;
begin
 case f_Type of
  dd_rtfGroup  : f_Content.Clear;
  dd_rtfKeyword: if f_Text <> nil then f_Text.Clear;
  dd_rtfText   : f_Text.Clear;
 end;
end;

procedure TddRTFAtom.PushState;
var
  A: TddRTFAtom;
begin
 if AtomType = dd_rtfGroup then
 begin
  A := TddRTFAtom.MakeGroup;
  try
   Content.Add(A);
  finally
   l3Free(A);
  end;
 end;
end;

procedure TddRTFAtom.AddKeyword(aKeyword: TSYM; aHasParam: Boolean; aParam: Long; aText: Tl3String
    = nil);
var
 A: TddRTFAtom;
begin
 if AtomType = dd_rtfGroup then
 begin
  A := TddRTFAtom.MakeKeyword(aKeyword, aHasParam, aParam, aText);
  try
   Content.Add(A);
  finally
   l3Free(A);
  end;
 end;
end;

procedure TddRTFAtom.AddText(aText: Tl3String);
var
 A: TddRTFAtom;
begin
 if AtomType = dd_rtfGroup then
 begin
  A := TddRTFAtom.MakeText(aText);
  try
   Content.Add(A);
  finally
   l3Free(A);
  end;
 end;
end;

procedure TddRTFAtom.AddText(aText: AnsiChar);
var
 A: TddRTFAtom;
 l_Text: Tl3String;
begin
 if AtomType = dd_rtfGroup then
 begin
  l_Text := Tl3String.Create;
  try
   l_Text.Append(aText);
   A := TddRTFAtom.MakeText(l_Text);
   try
    Content.Add(A);
   finally
    l3Free(A);
   end;
  finally
   l3Free(l_Text);
  end;
 end;
end;

end.

