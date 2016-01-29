unit evdXMLWriter;

{ Библиотека "EVD"        }
{ Начал: Люлин А.В.       }
{ Модуль: evdXMLWriter -  }
{ Начат: 21.11.2006 16:00 }
{ $Id: evdXMLWriter.pas,v 1.22 2014/09/01 09:42:07 lulin Exp $ }

// $Log: evdXMLWriter.pas,v $
// Revision 1.22  2014/09/01 09:42:07  lulin
// - начинаем делать возможность задавать тегам артибуты типа "множество".
//
// Revision 1.21  2014/04/22 10:56:16  lulin
// - прячем ненужный метод.
//
// Revision 1.20  2014/04/11 16:48:22  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.19  2014/03/27 14:20:05  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.18  2013/10/18 14:11:31  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.17  2012/08/30 13:37:58  kostitsin
//  - [$3380616762]
//
// Revision 1.16  2012/08/23 15:19:09  lulin
// {RequestLink:385025566}
//
// Revision 1.15  2012/08/23 15:05:28  lulin
// {RequestLink:385025566}
//
// Revision 1.14  2012/07/27 11:06:26  voba
// - меняем filer на лету
//
// Revision 1.13  2010/06/30 13:37:39  lulin
// {RequestLink:221249627}.
// - падали на неопределённом свойстве, а не должны.
//
// Revision 1.12  2009/07/03 16:24:09  lulin
// - шаг к переходу от интерфейсов к объектам.
//
// Revision 1.11  2008/02/05 18:20:38  lulin
// - удалено ненужное свойство строк.
//
// Revision 1.10  2008/02/05 12:49:20  lulin
// - упрощаем базовые объекты.
//
// Revision 1.9  2007/08/09 14:55:25  lulin
// - избавляемся от излишнего использования интерфейсов.
//
// Revision 1.8  2007/08/09 13:01:44  lulin
// - изолируем потомков от излишних знаний о внутренностях базового генератора.
//
// Revision 1.7  2006/11/25 14:31:50  lulin
// - корректнее записываем текст, который в кодировке, отличной от кодировки записываемого файла.
//
// Revision 1.6  2006/11/24 18:05:35  lulin
// - не пишем атрибуты с пустым значением.
//
// Revision 1.5  2006/11/22 11:08:23  lulin
// - короче определяем пространства имен.
//
// Revision 1.4  2006/11/22 10:55:44  lulin
// - делаем так, чтобы браузер умел открывать.
//
// Revision 1.3  2006/11/22 10:37:36  lulin
// - тип элемента кодируем префиксами.
//
// Revision 1.2  2006/11/21 15:18:02  lulin
// - сделана запись атомарных атрибутов.
//
// Revision 1.1  2006/11/21 14:30:21  lulin
// - начат писатель EVD в XML.
//

{$Include evdDefine.inc }

interface

uses
  l3Interfaces,
  l3Filer,
  l3Variant,
  
  k2Types,
  k2Interfaces,
  k2FileGenerator
  ;

type
  TevdXMLWriter = class(Tk2CustomFileGenerator)
    private
    // internal fields
      f_Writer : Il3XMLWriter;
    protected
    // internal fields
      procedure OpenStream;
        override;
        {-}
      procedure CloseStream(NeedUndo: Boolean);
        override;
        {-вызывается один раз в конце генерации}
      procedure FilerChanged(aFiler: Tl3CustomFiler);
       override;
        {-}
      procedure StartTag(TagID: Integer);
        override;
        {-}
      procedure StartChild(TypeID: Tl3VariantDef);
        override;
        {-}
      procedure CloseStructure(NeedUndo: Boolean);
        override;
        {-}
      procedure AddAtomEx(AtomIndex: Integer; const Value: Tk2Variant);
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
  end;//TevdXMLWriter

implementation

uses
  TypInfo,
  Classes,
  SysUtils,

  jclMime,

  l3Memory,
  l3XMLWriter,

  k2Tags,
  k2Base
  ;
  
// start class TevdXMLWriter

procedure TevdXMLWriter.Cleanup;
  //override;
  {-}
begin
 if f_Writer <> nil then
  f_Writer.Finish;
 f_Writer := nil;
 inherited;
end;

procedure TevdXMLWriter.FilerChanged(aFiler: Tl3CustomFiler);
begin
 if f_Writer <> nil then
  f_Writer.Finish;
 f_Writer := nil;

 if aFiler <> nil then
 begin
  f_Writer := Tl3XMLWriter.Make(aFiler);
  f_Writer.Start;
 end;
end;

procedure TevdXMLWriter.OpenStream;
  //override;
  {-}
begin
 inherited;
 if not Assigned(f_Writer) then
 begin
  f_Writer := Tl3XMLWriter.Make(Filer.COMStream);
  f_Writer.Start;
 end;
end;

procedure TevdXMLWriter.CloseStream(NeedUndo: Boolean);
  //override;
  {-вызывается один раз в конце генерации}
begin
 if (f_Writer <> nil) then
  f_Writer.Finish;
 //f_Writer := nil;
 inherited;
end;

procedure TevdXMLWriter.StartTag(TagID: Integer);
  //override;
  {-}
var
 l_O : Tk2Base;
begin
 inherited;
 l_O := TopObject[0];
 f_Writer.OpenLevel(Format('a:%s', [l_O.AsString]));
end;

procedure TevdXMLWriter.StartChild(TypeID: Tl3VariantDef);
  //override;
  {-}
var
 l_O : Tk2Type;
 l_S : String;
begin
 Assert(Assigned(f_Writer), 'TevdXMLWriter.StartChild');
 inherited;
 l_O := CurrentType;
 if (Types.Hi = 0) then
  l_S := 'xmlns:c="c" xmlns:a="a" xmlns:p="p" xmlns:t="t" xmlns:b="b"'
 else
  l_S := '';
 f_Writer.OpenLevel(Format('c:%s', [l_O.AsString]), l_S);
end;

procedure TevdXMLWriter.CloseStructure(NeedUndo: Boolean);
  //override;
  {-}
begin
 f_Writer.CloseLevel;
 inherited;
end;

procedure TevdXMLWriter.AddAtomEx(AtomIndex: Integer; const Value: Tk2Variant);
  //override;
  {-}
var
 l_Name  : String;
 l_Value : String;
 l_AT    : Tk2Type;
 l_Prop  : Tk2CustomProperty;
 l_B     : Tk2Base;
 l_InStream : TStream;
 l_OutStream : Tl3StringStream;
begin
 if (AtomIndex <> k2_tiChildren) then
 begin
  l_B := FindProperty(AtomIndex);
  if (l_B = nil) then
   Exit;
  l_Prop := Tk2CustomProperty(l_B.AsProp);
  l_Name := l_Prop.AsString;
  Case Value.Kind of
   k2_vkInteger:
   begin
    l_AT := Tk2Type(l_Prop.AtomType);
    Case l_AT.AtomType^.Kind of
     tkInteger,
     tkEnumeration,
     tkSet:
      l_Value := f_Writer.CS(Value.AsVariant.AsString);
     else
      l_Value := IntToStr(Value.AsInteger);
    end;//Case l_AT.AtomType^.Kind
   end;//k2_vkInteger
   k2_vkString:
    l_Value := f_Writer.CS(Value.AsString.AsWStr);
   k2_vkTransparent:
   begin
    f_Writer.OpenLevel(Format('t:%s', [l_Name]));
    f_Writer.CloseLevel;
    Exit;
   end;//k2_vkTransparent
   k2_vkStream:
   begin
    l_InStream := Value.AsStream;
    l_OutStream := Tl3StringStream.Create;
    try
     //MimeEncodeStream(l_InStream, l_OutStream);
     MimeEncodeStreamNoCRLF(l_InStream, l_OutStream);
     f_Writer.OpenLevel(Format('b:%s', [l_Name]), Format('v="%s"', [l_OutStream._String.AsString]));
     f_Writer.CloseLevel;
    finally
     FreeAndNil(l_OutStream);
    end;//try..finally
    Exit;
    //assert(false);
   end;//k2_vkStream
   else
    Assert(false);
  end;//Case Value.Kind
  if (l_Value <> '') then
  begin
   f_Writer.OpenLevel(Format('p:%s', [l_Name]), Format('v="%s"', [l_Value]));
   f_Writer.CloseLevel;
  end;//l_Value <> ''
 end;//AtomIndex <> k2_tiChildren
end;

end.

