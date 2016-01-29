unit k2DocumentBuffer;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: k2DocumentBuffer - }
{ Начат: 16.03.2004 17:53 }
{ $Id: k2DocumentBuffer.pas,v 1.9 2014/04/29 13:38:56 lulin Exp $ }

// $Log: k2DocumentBuffer.pas,v $
// Revision 1.9  2014/04/29 13:38:56  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.8  2014/04/09 14:19:32  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.7  2014/04/08 17:13:26  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.6  2014/04/08 14:17:06  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.5  2009/12/23 19:13:24  lulin
// - сделан тест разбивщика на разделы.
//
// Revision 1.4  2009/09/07 10:17:49  voba
// - opt. Убрали ненужную буфферизацию бинарных данных
//
// Revision 1.3  2006/12/21 14:39:08  voba
// - new methods in Tk2DocumentBuffer: _FinishAll, IsFinished
//
// Revision 1.2  2006/01/10 08:42:20  lulin
// - не компилировался Эверест.
//
// Revision 1.1  2005/06/23 13:42:57  lulin
// - буфер документа переехал в папку K2.
//
// Revision 1.8.4.4  2005/06/22 17:53:03  lulin
// - типы переименованы в соответствии с названием библиотеки.
//
// Revision 1.8.4.3  2005/06/22 17:34:09  lulin
// - генератор документа в памяти перенесен в "правильную" библиотеку.
//
// Revision 1.8.4.2  2005/06/22 17:06:34  lulin
// - cleanup.
//
// Revision 1.8.4.1  2005/05/18 12:42:46  lulin
// - отвел новую ветку.
//
// Revision 1.7.2.1  2005/04/28 09:18:28  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.7.4.1  2005/04/21 15:36:39  lulin
// - окончательно избавился от необходимости обертки.
//
// Revision 1.7  2005/03/28 11:32:07  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.6  2005/03/16 19:21:53  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.5  2004/11/04 14:40:35  lulin
// - bug fix: не падаем с AV если поток не был корректно открыт, а сообщаем об этом пользователю.
//
// Revision 1.4  2004/09/21 12:55:40  lulin
// - Release заменил на Cleanup.
//
// Revision 1.3  2004/06/30 12:04:06  law
// - изменен тип свойства TevDocumentBuffer.Root - Ik2TagWrap -> _Ik2Tag.
//
// Revision 1.2  2004/06/29 14:26:41  law
// - избавляемся от метода Tk2AtomR._Set.
//
// Revision 1.1  2004/03/16 15:20:47  law
// - new unit: evDocumentBuffer.
//

{$Include k2Define.inc }

interface

uses
  k2InternalInterfaces,
  k2Interfaces,
  k2TagGen,
  k2DocumentGenerator
  ;

type
  Tk2DocumentBuffer = class(Tk2DocumentGenerator)
   {*! Буфер образа документа. }
    private
    // property fields
      f_Root : Tl3Variant;
    protected
    // property methods
      procedure pm_SetRoot(Value: Tl3Variant);
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      procedure CloseStructure(NeedUndo: Boolean);
        override;
        {-вызывается на закрывающуюся скобку}
    public
     procedure FinishAll;
        {-закрывает все открытые структуры}

     function IsFinished : Boolean;
        {-все открытые структуры закрыты?}

    // public properties
      property Root: Tl3Variant
        read f_Root
        write pm_SetRoot;
        {* - корневой тег. }
      property Tags;  
  end;//Tk2DocumentBuffer

implementation

uses
  k2NullTagImpl
  ;

// start class Tk2DocumentBuffer

procedure Tk2DocumentBuffer.Cleanup;
  {override;}
  {-}
begin
 Root := nil;
 inherited;
end;

procedure Tk2DocumentBuffer.pm_SetRoot(Value: Tl3Variant);
  {-}
begin
 Value.SetRef(f_Root);
end;

procedure Tk2DocumentBuffer.CloseStructure(NeedUndo: Boolean);
  {override;}
  {-вызывается на закрывающуюся скобку}
begin
 if (f_Tags <> nil) AND (f_Tags.Count = 1) then
 begin
  if not NeedUndo {AND not f_Tags.Empty }then
   Root := f_Tags.Top^.Box
  else
   Root := nil;
 end;//f_Tags <> nil..
 inherited;
end;

procedure Tk2DocumentBuffer.FinishAll;
  {-закрывает все открытые структуры}
begin
 if (f_Tags <> nil) then
  while f_Tags.Count > 0 do
   Finish;
end;

function Tk2DocumentBuffer.IsFinished : Boolean;
  {-все открытые структуры закрыты?}
begin
 Result := (f_Tags = nil) or (f_Tags.Count = 0);
end;

end.

