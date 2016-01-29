unit evChangeCodePage;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evChangeCodePage - }
{ Начат: 19.11.2002 12:22 }
{ $Id: evChangeCodePage.pas,v 1.6 2009/07/23 13:42:10 lulin Exp $ }

// $Log: evChangeCodePage.pas,v $
// Revision 1.6  2009/07/23 13:42:10  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.5  2007/12/04 12:46:59  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.3.14.3  2007/08/14 14:29:57  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.3.14.2  2005/11/09 15:28:22  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.3.14.1  2005/06/21 13:13:08  lulin
// - cleanup: удалены ненужные методы.
//
// Revision 1.3  2005/02/03 14:33:43  lulin
// - для Undo-записей используем фабричные методы ToUndo, вместо конструкторов.
//
// Revision 1.2  2004/09/21 12:55:40  lulin
// - Release заменил на Cleanup.
//
// Revision 1.1  2002/11/19 09:32:02  law
// - new unit: evChangeCodePage.
//

{$Include evDefine.inc }

interface

uses
  l3Interfaces,
  l3Types,
  l3Base,

  k2Op,

  nevBase
  ;

type
  OevChangeCodePage = class(Tk2Op)
    protected
     f_OldS : Tl3String;
     f_NewS : Tl3String;
     f_S    : Tl3String;
    protected
      procedure DoUndo(const Container: InevOp);
        override;
        {-отменить операцию}
      procedure DoRedo(const Container: InevOp);
        override;
        {-повторить операцию}
      procedure Cleanup;
        override;
        {-}
    public
      class procedure ToUndo(const anOpPack : InevOp;
                             OCS, NCS       : Long;
                             S              : Tl3CustomString);
        {-}
      constructor Create(OCS, NCS : Long;
                         S        : Tl3CustomString);
        reintroduce;                 
        {-}
    public
    // public properties
      property NewS: Tl3String
        read f_NewS;
        {-}
  end;//OevChangeCodePage

implementation

// start class OevChangeCodePage 

constructor OevChangeCodePage.Create(OCS, NCS : Long;
                                    S        : Tl3CustomString);
  {reintroduce;}
  {-}
begin
 inherited Create;
 l3Set(f_S, S);
 f_OldS := S.Clone;
 f_NewS := S.Clone;
 f_NewS.CodePage := NCS;
end;

class procedure OevChangeCodePage.ToUndo(const anOpPack : InevOp;
                                         OCS, NCS       : Long;
                                         S              : Tl3CustomString);
  {-}
var
 l_Op : OevChangeCodePage;
begin
 if (anOpPack <> nil) AND
    (OCS <> NCS) then 
 begin
  l_Op := Create(OCS, NCS, S);
  try
   l_Op.Put(anOpPack);
  finally
   l3Free(l_Op);
  end;//try..finally
 end;//anOpPack <> nil
end;

procedure OevChangeCodePage.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_OldS);
 l3Free(f_NewS);
 l3Free(f_S);
 inherited;
end;

procedure OevChangeCodePage.DoUndo(const Container: InevOp);
  {override;}
  {-отменить операцию}
begin
 f_S._CodePage := f_OldS.CodePage;
 l3Move(f_OldS.St^, f_S.St^, f_OldS.Len);
 inherited;
end;

procedure OevChangeCodePage.DoRedo(const Container: InevOp);
  {override;}
  {-повторить операцию}
begin
 f_S._CodePage := f_NewS.CodePage;
 l3Move(f_NewS.St^, f_S.St^, f_NewS.Len);
 inherited;
end;

end.

