unit evdXMLReader;

{ Библиотека "EVD"        }
{ Начал: Люлин А.В.       }
{ Модуль: evdXMLReader -  }
{ Начат: 24.11.2006 16:31 }
{ $Id: evdXMLReader.pas,v 1.19 2014/04/03 17:10:37 lulin Exp $ }

// $Log: evdXMLReader.pas,v $
// Revision 1.19  2014/04/03 17:10:37  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.18  2013/10/21 15:43:12  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.17  2013/10/21 10:31:00  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.16  2010/11/30 11:47:10  lulin
// {RequestLink:228688602}.
// - борьба с предупреждениями.
//
// Revision 1.15  2009/07/03 16:24:09  lulin
// - шаг к переходу от интерфейсов к объектам.
//
// Revision 1.14  2009/04/21 10:03:36  narry
// - выделение базового потомка
//
// Revision 1.13  2009/03/04 14:17:49  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.12  2007/08/09 18:05:28  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.11  2006/11/24 19:25:32  lulin
// - указываем константность параметров.
//
// Revision 1.10  2006/11/24 19:21:17  lulin
// - корректно используем Unicode строки.
//
// Revision 1.9  2006/11/24 17:20:46  lulin
// - читаем любую Windows кодировку.
//
// Revision 1.8  2006/11/24 17:07:10  lulin
// - понимаем кодировку _1251 без шаманства.
//
// Revision 1.7  2006/11/24 16:54:17  lulin
// - bug fix: не определяли стили разметки.
//
// Revision 1.6  2006/11/24 16:41:09  lulin
// - научились понимать кодировку _1251.
//
// Revision 1.5  2006/11/24 15:22:49  lulin
// - завелось чтение атрибутов.
//
// Revision 1.4  2006/11/24 14:39:30  lulin
// - завелось чтение.
//
// Revision 1.3  2006/11/24 13:41:29  lulin
// - подготовлена обвязка.
//
// Revision 1.2  2006/11/24 13:34:09  lulin
// - используем сторонний парсер.
//
// Revision 1.1  2006/11/24 13:32:00  lulin
// - добавлен читатель XML в терминах EVD.
//

{$Include evdDefine.inc }

interface

uses
  l3Types,
  l3Base,

  evdCustomXMLReader,

  k2Reader,

  XpBase,
  XpParser
  ;

type
  TevdElement = (evd_elNone, evd_elChild, evd_elTag, evd_elAtom);
  
  TevdXMLReader = class(TevdCustomXMLReader)
    private
    // internal fields
      f_E      : TevdElement;
      f_Name   : String;
      f_Val    : DOMString;
    protected
    // internal methods
      procedure FillName(sValue : DOMString);
        {-}
      procedure StartElement(oOwner : TObject;
                             const sValue : DOMString);
        {-}
      procedure EndElement(oOwner : TObject;
                           const sValue : DOMString);
        {-}
      procedure DoAttribute(oOwner     : TObject;
                            const sName,
                            sValue     : DOMString;
                            bSpecified : Boolean);
        {-}
  end;//TevdXMLReader

implementation

uses
  SysUtils,
  StrUtils,

  l3String,
  l3Filer,

  k2Interfaces,
  k2Tags,
  k2Base,
  
  XpChrFlt,

  TextPara_Const,
  Segment_Const
  ;

const
 cChild = 'c:';
 cTag   = 'a:';
 cAtom  = 'p:';
 cVal   = 'v';

procedure TevdXMLReader.FillName(sValue : DOMString);
  {-}
begin
 f_Name := sValue;
 if AnsiStartsStr(cChild, sValue) then
 begin
  f_E := evd_elChild;
  Delete(f_Name, 1, Length(cChild));
 end//AnsiStartsStr(cChild, sValue)
 else
 if AnsiStartsStr(cTag, sValue) then
 begin
  f_E := evd_elTag;
  Delete(f_Name, 1, Length(cTag));
 end//AnsiStartsStr(cTag, sValue)
 else
 if AnsiStartsStr(cAtom, sValue) then
 begin
  f_E := evd_elAtom;
  Delete(f_Name, 1, Length(cAtom));
 end//AnsiStartsStr(cAtom, sValue)
 else
 begin
  f_Name := '';
  f_E := evd_elNone;
 end;//AnsiStartsStr(cAtom, sValue)
end;

procedure TevdXMLReader.StartElement(oOwner : TObject;
                                     const sValue : DOMString);
  {-}
begin
 FillName(sValue);
 if (f_E = evd_elTag) then
  StartObject(GetObjectID(f_Name, false))
 else
 if (f_E = evd_elChild) then
  StartObject(GetObjectID(f_Name, true));
end;

procedure TevdXMLReader.EndElement(oOwner : TObject;
                                   const sValue : DOMString);
  {-}
var
 l_ID : Integer;
 l_CT : Tk2TypePrim;
 l_S  : Tl3String;
begin
 //if (f_E = evd_elNone) then
  FillName(sValue);
 if (f_E in [evd_elChild, evd_elTag]) then
  Finish
 else
 if (f_E = evd_elAtom) then
 begin
  l_ID := GetObjectID(f_Name, false);
  if (l_ID = k2_tiStyle) then
  begin
   l_CT := CurrentType;
   if l_CT.IsKindOf(k2_typTextPara) OR l_CT.IsKindOf(k2_typSegment) then
    try
     AddIntegerAtom(l_ID, StrToInt(f_Val));
     Exit;
    except
     on EConvertError do;
    end;//try..except
  end;//l_ID = k2_tiStyle
  l_S := Tl3String.Make(l3PCharLen(f_Val));
  try
   AddStringAtom(l_ID, l_S.AsWStr);
  finally
   l3Free(l_S);
  end;//try..finally
 end;//f_E = evd_elAtom
 f_E := evd_elNone;
end;

procedure TevdXMLReader.DoAttribute(oOwner     : TObject;
                                    const sName,
                                    sValue     : DOMString;
                                    bSpecified : Boolean);
  {-}
begin
 if (sName = cVal) then
  f_Val := sValue;
end;
  
end.

