unit evBseOp;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evBseOp - описание базовой операции}
{ Начат: 01.10.1997 14:01 }
{ $Id: evBseOp.pas,v 1.72 2015/01/19 18:36:35 lulin Exp $ }

// $Log: evBseOp.pas,v $
// Revision 1.72  2015/01/19 18:36:35  lulin
// {RequestLink:580710025}
//
// Revision 1.71  2014/05/19 14:26:43  lulin
// {RequestLink:530275254}
//
// Revision 1.70  2014/04/09 13:12:03  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.69  2014/04/08 17:13:19  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.68  2014/04/08 12:35:09  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.67  2014/04/03 17:10:24  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.66  2014/03/21 12:39:22  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.65  2013/11/06 12:41:03  lulin
// - атомарные типы теперь тоже не имеют постоянного идентификатора для сохранения в поток.
//
// Revision 1.64  2011/04/27 14:23:55  lulin
// {RequestLink:265391680}.
//
// Revision 1.63  2010/02/02 07:42:49  dinishev
// [$179077291]
//
// Revision 1.62  2009/07/23 13:42:10  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.61  2009/07/23 08:14:38  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.60  2009/07/06 13:32:06  lulin
// - возвращаемся от интерфейсов к объектам.
//
// Revision 1.59  2009/06/24 15:53:21  lulin
// {RequestLink:140286381}.
//
// Revision 1.58  2009/06/02 12:26:31  lulin
// [$148572872].
//
// Revision 1.57  2009/04/14 18:11:54  lulin
// [$143396720]. Подготовительная работа.
//
// Revision 1.56  2009/04/07 16:09:41  lulin
// [$140837386]. №13.
//
// Revision 1.55  2008/02/08 19:58:22  lulin
// - <TDN>: 55.
//
// Revision 1.54  2008/02/05 09:57:37  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.53  2007/12/04 12:46:59  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.51.4.19  2007/08/10 19:01:28  lulin
// - cleanup.
//
// Revision 1.51.4.18  2007/06/25 13:29:06  lulin
// - cleanup.
//
// Revision 1.51.4.17  2006/11/10 17:15:54  lulin
// - объединил с веткой.
//
// Revision 1.51.4.16.26.1  2006/11/08 13:46:49  lulin
// - cleanup.
//
// Revision 1.51.4.16  2006/01/16 11:31:03  lulin
// - убран метод удаления параграфа, т.к. для этих целей полностью подходит метод удаления тега.
//
// Revision 1.51.4.15  2006/01/16 10:46:48  lulin
// - не используем напрямую, тег отвечающий за признак сформатированности параграфа.
//
// Revision 1.51.4.14  2006/01/12 13:16:48  lulin
// - bug fix: не склеиваем операции в пачки, т.к. на дереве есть проблемы с удалением.
//
// Revision 1.51.4.13  2005/12/08 08:33:23  lulin
// - держим ссылку на тег, а не на его инструмент.
//
// Revision 1.51.4.12  2005/12/02 20:04:04  lulin
// - bug fix: асинхронное удаление параграфа портило Undo-буфер.
//
// Revision 1.51.4.11  2005/11/09 15:28:22  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.51.4.10  2005/11/07 14:08:31  lulin
// - от безликих тегов переходим к параграфам.
//
// Revision 1.51.4.9  2005/11/05 07:33:33  lulin
// - cleanup: убраны ненужные преобразования объекта к параграфу.
//
// Revision 1.51.4.8  2005/10/18 11:26:06  lulin
// - реализация Undo-записи удаления/добавления пачки параграфов, перенесена в правильное место.
//
// Revision 1.51.4.7  2005/10/18 10:55:39  lulin
// - cleanup.
//
// Revision 1.51.4.6  2005/09/20 07:41:28  lulin
// - bug fix: не склеивались Undo-записи, которым положено было бы склеиваться.
//
// Revision 1.51.4.5  2005/08/31 12:04:34  lulin
// - удален ненужный модуль.
//
// Revision 1.51.4.4  2005/08/31 11:01:14  lulin
// - теперь метод удаления параграфа не глобальный, а привязан к интерфейсу _InevParaListModify.
//
// Revision 1.51.4.3  2005/08/31 10:10:14  lulin
// - bug fix: при удалении параграфа не весь документ перерисовывался.
//
// Revision 1.51.4.2  2005/07/07 13:09:27  lulin
// - упорядочены названия интерфейсов.
//
// Revision 1.51.4.1  2005/05/18 12:42:45  lulin
// - отвел новую ветку.
//
// Revision 1.50.2.3  2005/05/18 12:32:07  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.50.2.2  2005/04/28 09:18:28  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.50.2.1  2005/04/13 14:31:51  lulin
// - вместо безликих тегов используем параграфы.
//
// Revision 1.50.4.2  2005/04/23 16:07:24  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.50.4.1  2005/04/21 14:46:54  lulin
// - избавляемся от обертки над тегами - теперь объекты посредством шаблонов сами реализуют интерфейс _Ik2Tag.
//
// Revision 1.51  2005/04/28 15:03:37  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.50.4.2  2005/04/23 16:07:24  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.50.4.1  2005/04/21 14:46:54  lulin
// - избавляемся от обертки над тегами - теперь объекты посредством шаблонов сами реализуют интерфейс _Ik2Tag.
//
// Revision 1.50  2005/04/01 14:48:50  lulin
// - доточка напильником - чтобы "парень" скомпилировался.
//
// Revision 1.49  2005/04/01 09:53:06  lulin
// - проверка на то, что параграф уже вставлен в какой-то список перенесена в более правильное место - ближе к реальной вставке параграфа.
//
// Revision 1.48  2005/04/01 08:35:29  lulin
// - remove proc: evDir_InsertPara (пользуйтесь инструментом InevParaList).
//
// Revision 1.47  2005/03/31 15:47:23  lulin
// - new methods: InevPara._LockFormatting, UnlockFormatting, Unformat.
//
// Revision 1.46  2005/03/28 11:32:07  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.45  2005/03/24 15:25:51  lulin
// - удалены ненужные методы.
//
// Revision 1.44  2005/03/21 13:42:58  lulin
// - убраны ненужные методы.
//
// Revision 1.43  2005/03/10 07:05:10  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.42  2005/03/09 18:40:19  lulin
// - remove method: Tk2AtomR.DeleteChild.
// - new method: _Ik2Tag.DeleteChild.
//
// Revision 1.41  2005/03/09 17:05:20  lulin
// - remove method: Tk2AtomR._InsertChild.
// - new method: _Ik2Tag._InsertChild.
//
// Revision 1.40  2005/02/03 14:33:43  lulin
// - для Undo-записей используем фабричные методы ToUndo, вместо конструкторов.
//
// Revision 1.39  2004/10/18 16:18:56  lulin
// - remove unit: evTagTools.
//
// Revision 1.38  2004/10/18 15:41:42  lulin
// - remove method: TevTag.Unformat.
// - new proc: evUnformatPara.
//
// Revision 1.37  2004/09/21 12:55:40  lulin
// - Release заменил на Cleanup.
//
// Revision 1.36  2004/06/29 14:26:40  law
// - избавляемся от метода Tk2AtomR._Set.
//
// Revision 1.35  2004/06/17 10:34:13  law
// - избавляемся от знания о _TevBasePara и _TevBaseParaList.
//
// Revision 1.34  2004/06/17 10:19:15  law
// - remove method: _TevBaseParaList.Dir_InsertPara.
// - new proc: evDir_InsertPara.
//
// Revision 1.33  2004/06/17 10:06:14  law
// - remove method: _TevBaseParaList.Dir_DeletePara.
// - new proc: evDir_DeletePara.
//
// Revision 1.32  2002/12/20 17:24:41  law
// - rename field: f_P -> _f_Para.
//
// Revision 1.31  2002/12/19 17:21:48  law
// - rename unit: evBsePar -> evBasePara.
//
// Revision 1.30  2002/10/17 14:52:30  law
// - cleanup.
//
// Revision 1.29  2002/02/15 15:51:17  law
// - comments: xHelpGen.
//
// Revision 1.28  2002/02/08 12:14:48  law
// - new unit: evParaList.
//
// Revision 1.27  2002/02/07 17:56:08  law
// - cleanup: из _TevBasePara убраны знания о _TevBaseParaList.
//
// Revision 1.26  2002/02/07 16:12:15  law
// - cleanup: убраны ненужные ссылки на evTxtPar.
//
// Revision 1.25  2002/01/10 15:23:59  law
// - bug fix: не компилировалось с директивой l3ConsoleApp.
//
// Revision 1.24  2001/11/09 10:16:06  law
// - new interface: _IevTextOpProcessor.
//
// Revision 1.23  2001/08/31 08:50:06  law
// - cleanup: первые шаги к кроссплатформенности.
//
// Revision 1.22  2001/08/28 12:55:12  law
// - rename unit: evUtils -> l3Utils.
//
// Revision 1.21  2001/04/02 11:29:54  law
// - операции над текстовым параграфом вынесены в модуль evTextParaOp.
//
// Revision 1.20  2001/03/26 13:50:23  law
// - убран класс Wk2Handle.
//
// Revision 1.19  2001/03/13 11:35:36  law
// - убран ненужный параметр.
//
// Revision 1.18  2000/12/15 15:10:34  law
// - вставлены директивы Log.
//

{$Include evDefine.inc }

interface

uses
  Classes,

  l3Types,
  l3Base,
  l3Interfaces,
  l3Variant,

  k2Interfaces,
  k2InternalInterfaces,
  k2Op,

  nevTools
  ;

type
  TevParaOperation = class(Tk2Op)
    {-операция применяемая к конкретному параграфу}
    private
    // property fields
      f_Para: Tl3Variant;
    protected
    // property methods
      function Para(const anOp: InevOp): InevPara;
        {-}  
    public
    // public methods
      constructor Create(aPara : Tl3Variant);
        reintroduce;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public properties
      property TagInst: Tl3Variant
        read f_Para;
        {-}
  end;//TevParaOperation

  OevDeletePara = class(TevParaOperation)
    private
    // internal fields
      f_PID         : Long;
      f_DeletedPara : Tl3Variant;
    protected
    // property methods
      function pm_GetDeletedPara: Tl3Variant;
        {-}
    protected
    // internal methods
      function  OpUndo(const Container: InevOp): Bool;
        virtual;
        {-}
      function  OpRedo(const Container: InevOp): Bool;
        virtual;
        {-}
      procedure DoUndo(const Container: InevOp);
        override;
        {-отменить операцию}
      procedure DoRedo(const Container: InevOp);
        override;
        {-повторить операцию}
      function CanLinkWith(anOperation: Tk2Op): Bool;
        override;
        {-}
      function pm_GetFlags: Tl3OperationFlags;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      class procedure ToUndo(const anOpPack  : InevOp;
                             aParaList : Tl3Variant;
                             aPID            : Long;
                             aPara     : Tl3Variant);
        {-}
      constructor Create(aParaList : Tl3Variant;
                         aPID            : Long;
                         aPara     : Tl3Variant);
        reintroduce;
        {-}
      {$IfDef Nemesis}
      function  RestrictJoin: Boolean;
        override;
        {-}
      {$EndIf Nemesis}
    public
    // public properties
      property PID: Long
        read f_PID;
        {-}
      property DeletedPara : Tl3Variant
        read pm_GetDeletedPara;
        {-}
  end;//OevDeletePara

  OevInsertPara = class(OevDeletePara)
    protected
    // internal methods
      function  OpUndo(const Container: InevOp): Bool;
        override;
        {-}
      function  OpRedo(const Container: InevOp): Bool;
        override;
        {-}
      function DoJoin(anOperation: Tk2Op): Tk2Op;
        override;
        {-соединяет две операции и возвращает:
          nil  - соединение неудачно
          Self - соединение удачно и все поместилось в старую запись
          New  - распределена новая операция }
      function CanJoinWith(anOperation: Tk2Op): Bool;
        override;
        {-}
      function CanLinkWith(anOperation: Tk2Op): Bool;
        override;
        {-}
      function pm_GetFlags: Tl3OperationFlags;
        override;
        {-}
  end;//OevInsertPara

implementation

{$IfNDef k2ForEditor}
//  !!! Ошибка: не определена директива k2ForEditor.
{$EndIf  k2ForEditor}

uses
  SysUtils,
  
  l3MinMax,
  l3Chars,
  l3InternalInterfaces,

  k2Tags,
  k2Base,
  
  evConst,

  evTextParaOp,
  evParaPackOperation{,
  evParaTools}
  ;

// start class TevParaOperation 

constructor TevParaOperation.Create(aPara: Tl3Variant);
  {virtual;}
  {-}
begin
 inherited Create;
 aPara.Box.SetRef(f_Para);
end;

procedure TevParaOperation.Cleanup;
  {override;}
  {-}
begin
 FreeAndNil(f_Para);
 inherited;
end;

function TevParaOperation.Para(const anOp: InevOp): InevPara;
  {-}
begin
 if (f_Para = nil) then
  Result := nil
 else
 begin
  if (anOp = nil) then
  begin
   if not f_Para.QT(InevPara, Result, nil) then
    Assert(false);
  end
  else
  begin
   if not f_Para.QT(InevPara, Result, anOp.Processor) then
    Assert(false);
  end;//anOp = nil
 end;//f_Para = nil
end;

// start class OevDeletePara

constructor OevDeletePara.Create(aParaList : Tl3Variant;
                                 aPID            : Long;
                                 aPara     : Tl3Variant);
  {virtual;}
  {-}
begin
 inherited Create(aParaList);
 f_PID := aPID;
 aPara.Box.SetRef(f_DeletedPara);
end;

class procedure OevDeletePara.ToUndo(const anOpPack  : InevOp;
                                     aParaList : Tl3Variant;
                                     aPID            : Long;
                                     aPara     : Tl3Variant);
  {-}
var
 l_Op : OevDeletePara;
begin
 if (anOpPack <> nil) AND anOpPack.SaveUndo then
 begin
  l_Op := Create(aParaList, aPID, aPara);
  try
   l_Op.Put(anOpPack, True);
  finally
   l3Free(l_Op);
  end;//try..finally
 end;//anOpPack <> nil
end;

procedure OevDeletePara.Cleanup;
  {override;}
  {-}
begin
 FreeAndNil(f_DeletedPara);
 inherited;
end;

{$IfDef Nemesis}
function OevDeletePara.RestrictJoin: Boolean;
  //override;
  {-}
begin
 Result := true;
end;
{$EndIf Nemesis}

function OevDeletePara.pm_GetDeletedPara: Tl3Variant;
  {-}
begin
 Result := f_DeletedPara;
end;

function  OevDeletePara.OpUndo(const Container: InevOp): Bool;
  {virtual;}
  {-}
begin
 Result := Para(Container).AsList.Modify.InsertPara(Pred(f_PID), DeletedPara, Container);
end;

function  OevDeletePara.OpRedo(const Container: InevOp): Bool;
  {virtual;}
  {-}
var
 l_D : Il3TagRef;  
begin
 if not TagInst.DeleteChild(Pred(f_PID), Container, l_D) then
  Assert(false, 'http://mdp.garant.ru/pages/viewpage.action?pageId=265391680');
 l_D.AsObject.SetRef(f_DeletedPara); 
 Result := true;
end;

procedure OevDeletePara.DoUndo(const Container: InevOp);
  {override;}
  {-отменить операцию}
begin
 OpUndo(Container);
 inherited;
end;

procedure OevDeletePara.DoRedo(const Container: InevOp);
  {override;}
  {-повторить операцию}
begin
 OpRedo(Container);
 inherited;
end;

function OevDeletePara.CanLinkWith(anOperation: Tk2Op): Bool;
  {override;}
  {-}
begin
 Result := inherited CanLinkWith(anOperation);
 if not Result then Result := (anOperation Is OevDeleteString);
end;

function OevDeletePara.pm_GetFlags: Tl3OperationFlags;
  {override;}
  {-}
begin
 Result := [ofDelete, ofModify, ofCanUndo, ofCanRedo];
end;

// start class OevInsertPara

function  OevInsertPara.OpUndo(const Container: InevOp): Bool;
  {override;}
  {-}
begin
 Result := inherited OpRedo(Container);
end;

function  OevInsertPara.OpRedo(const Container: InevOp): Bool;
  {override;}
  {-}
begin
 Result := inherited OpUndo(Container);
end;

function OevInsertPara.DoJoin(anOperation: Tk2Op): Tk2Op;
  {override;}
  {-соединяет две операции и возвращает:
    nil  - соединение неудачно
    Self - соединение удачно и все поместилось в старую запись
    New  - распределена новая операция }
var
 OIP : OevInsertPara absolute anOperation;
 O   : Ok2AddChildren;
begin
 if (anOperation Is OevInsertPara) AND (ofInsert in anOperation.Flags) AND
    TagInst.IsSame(OIP.TagInst) then
 begin
  if (PID = Pred(OIP.PID)) OR (PID = OIP.PID) then
  begin
   O := Ok2AddChildren.Create;
   try
    O.SetParam(TagInst,
               Tk2Type(TagInst.TagType).ArrayProp[k2_tiChildren],
               Pred(PID));
    if (PID = OIP.PID) then
    begin
     O.Deleted.Add(OIP.f_DeletedPara);
     O.Deleted.Add(f_DeletedPara);
    end//PID = OIP.PID
    else
    begin
     O.Deleted.Add(f_DeletedPara);
     O.Deleted.Add(OIP.f_DeletedPara);
    end;//PID = OIP.PID
    Result := O;
   except
    l3Free(O);
    raise;
   end;{try..finally}
  end//PID = Pred(OIP.PID)
  else
   Result := nil;
 end//anOperation Is OevInsertPara
 else
  Result := nil;
end;

function OevInsertPara.CanJoinWith(anOperation: Tk2Op): Bool;
  {override;}
  {-}
begin
 Result := true;
end;

function OevInsertPara.CanLinkWith(anOperation: Tk2Op): Bool;
  {override;}
  {-}
begin
 Result := inherited CanLinkWith(anOperation);
 if not Result then Result := (anOperation Is OevBreakPara) OR
                              ((anOperation Is OevInsertString) AND (ofInsert In anOperation.Flags));
end;

function OevInsertPara.pm_GetFlags: Tl3OperationFlags;
  {override;}
  {-}
begin
 Result := [ofInsert, ofModify, ofCanUndo, ofCanRedo];
end;

end.
