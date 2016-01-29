unit evTextParaOp;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evTextParaOp -  }
{ Начат: 02.04.2001 14:12 }
{ $Id: evTextParaOp.pas,v 1.47 2015/01/19 18:36:36 lulin Exp $ }

// $Log: evTextParaOp.pas,v $
// Revision 1.47  2015/01/19 18:36:36  lulin
// {RequestLink:580710025}
//
// Revision 1.46  2014/04/30 11:23:52  lulin
// - выпрямляем зависимости.
//
// Revision 1.45  2014/04/11 15:30:29  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.44  2014/04/08 17:13:19  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.43  2014/04/04 17:53:34  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.42  2014/04/03 17:10:25  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.41  2014/03/21 16:24:50  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.40  2013/11/06 12:41:04  lulin
// - атомарные типы теперь тоже не имеют постоянного идентификатора для сохранения в поток.
//
// Revision 1.39  2012/04/20 14:56:33  lulin
// {RequestLink:283610570}
//
// Revision 1.38  2010/05/04 15:41:11  lulin
// {RequestLink:208701762}.
// - bug fix: не работал сдвиг сегментов при Undo вставки символа.
//
// Revision 1.37  2010/04/16 13:02:04  lulin
// {RequestLink:204112481}.
// - теряли сегменты при объединении абзацев.
//
// Revision 1.36  2010/02/25 13:45:58  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.35  2009/07/23 13:42:11  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.34  2009/07/23 08:14:39  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.33  2009/07/20 16:44:04  lulin
// - убираем из некоторых листьевых параграфов хранение типа конкретного тега, вместо этого "плодим" под каждый тип тега свой тип класса.
//
// Revision 1.32  2009/06/02 16:12:53  lulin
// - выделяем внутренние интерфейсы в отдельные модули.
//
// Revision 1.31  2009/06/02 12:26:32  lulin
// [$148572872].
//
// Revision 1.30  2008/05/07 18:29:48  lulin
// - изменения в рамках <K>: 90441963.
//
// Revision 1.29  2007/12/04 12:47:06  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.27.4.9  2007/09/14 13:26:07  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.27.4.8.2.2  2007/09/12 17:08:16  lulin
// - cleanup.
//
// Revision 1.27.4.8.2.1  2007/09/12 15:23:02  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.27.4.8  2007/06/25 13:29:07  lulin
// - cleanup.
//
// Revision 1.27.4.7  2005/12/26 13:26:49  lulin
// - bug fix: не всегда отображалось изменение комментариев (CQ OIT5-18865).
//
// Revision 1.27.4.6  2005/12/02 20:04:04  lulin
// - bug fix: асинхронное удаление параграфа портило Undo-буфер.
//
// Revision 1.27.4.5  2005/11/11 21:52:13  lulin
// - bug fix: убраны утечки объектов документа, связанные с неправильным владением Undo-буфером.
//
// Revision 1.27.4.4  2005/11/09 15:28:25  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.27.4.3  2005/09/20 07:41:28  lulin
// - bug fix: не склеивались Undo-записи, которым положено было бы склеиваться.
//
// Revision 1.27.4.2  2005/06/22 11:38:29  lulin
// - cleanup.
//
// Revision 1.27.4.1  2005/05/18 12:42:47  lulin
// - отвел новую ветку.
//
// Revision 1.26.2.3  2005/05/18 12:32:10  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.26.2.2  2005/04/28 09:18:30  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.26.2.1  2005/04/13 14:31:51  lulin
// - вместо безликих тегов используем параграфы.
//
// Revision 1.26.4.1  2005/04/23 16:07:25  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.27  2005/04/28 15:03:38  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.26.4.1  2005/04/23 16:07:25  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.26  2005/04/01 14:48:50  lulin
// - доточка напильником - чтобы "парень" скомпилировался.
//
// Revision 1.25  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.24  2005/03/23 14:14:13  lulin
// - убран ненужный утилитный класс.
//
// Revision 1.23  2005/03/19 16:39:51  lulin
// - спрятаны ненужные методы.
//
// Revision 1.22  2005/03/11 17:13:05  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.21  2005/03/11 16:26:39  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.20  2005/03/10 17:44:02  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.19  2005/03/09 15:43:12  lulin
// - remove method: Tk2AtomR._AssignCloneParams.
// - new class: Tk2TT - утилитные функции для работы с тегами (структурами документа) не инкапсулированные самими тегами (в частности туда перенесен метод _AssignCloneParams).
//
// Revision 1.18  2005/03/04 15:49:02  lulin
// - спрятана процедура Tk2Type.New.
//
// Revision 1.17  2005/02/03 15:05:55  lulin
// - bug fix: вставка строки не взводила флажок модифицированности.
//
// Revision 1.16  2005/02/03 14:33:43  lulin
// - для Undo-записей используем фабричные методы ToUndo, вместо конструкторов.
//
// Revision 1.15  2004/09/21 12:55:41  lulin
// - Release заменил на Cleanup.
//
// Revision 1.14  2004/06/18 11:19:17  law
// - cleanup.
//
// Revision 1.13  2004/06/17 12:07:39  law
// - remove method: _TevTextPara.Dir_DeleteText.
// - new proc: evDir_DeleteText.
//
// Revision 1.12  2004/06/17 11:16:16  law
// - remove method: _TevTextPara.Dir_InsertText.
// - new proc: evDir_InsertText.
//
// Revision 1.11  2004/06/17 10:34:13  law
// - избавляемся от знания о _TevBasePara и _TevBaseParaList.
//
// Revision 1.10  2002/12/19 17:21:49  law
// - rename unit: evBsePar -> evBasePara.
//
// Revision 1.9  2002/11/05 15:19:16  law
// - bug fix.
//
// Revision 1.8  2002/11/05 15:18:29  law
// - bug fix: неправильно работало Undo после вставки текста взамен ссылки (см. _TestSet\Segments\Hyperlinks\6.evd).
//
// Revision 1.7  2002/10/17 14:52:31  law
// - cleanup.
//
// Revision 1.6  2002/02/15 15:51:17  law
// - comments: xHelpGen.
//
// Revision 1.5  2002/02/08 15:31:51  law
// - rename unit: evTxtPar -> evTextPara.
//
// Revision 1.4  2002/01/10 15:23:59  law
// - bug fix: не компилировалось с директивой l3ConsoleApp.
//
// Revision 1.3  2001/11/09 10:16:06  law
// - new interface: _IevTextOpProcessor.
//
// Revision 1.2  2001/09/26 12:03:35  law
// - bug fix: проблема с Undo ссылок. Задача №770. См. _TestSet\Segments\Hyperlinks\3.evd .
//
// Revision 1.1  2001/04/02 11:29:55  law
// - операции над текстовым параграфом вынесены в модуль evTextParaOp.
//

{$I evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3Interfaces,

  k2Interfaces,
  k2InternalInterfaces,
  k2Op,

  evBseOp,

  nevTools
  ;

type  
  OevInsertString = class(TevParaOperation)
    private
    {internal fields}
      f_Pos : Long;
      f_S   : Tl3String;
    protected
    {internal methods}
      function CanJoinWith(anOperation: Tk2Op): Bool;
        override;
        {-}
      function CanLinkWith(anOperation: Tk2Op): Bool;
        override;
        {-}
      function DoJoin(anOperation: Tk2Op): Tk2Op;
        override;
        {-соединяет две операции и возвращает:
          nil  - соединение неудачно
          Self - соединение удачно и все поместилось в старую запись
          New  - распределена новая операция }
      procedure DoUndo(const Container: InevOp);
        override;
        {-отменить операцию}
      procedure DoRedo(const Container: InevOp);
        override;
        {-повторить операцию}
      procedure OpUndo(const Context : InevOp);
        virtual;
        {-}
      procedure OpRedo(const Context : InevOp);
        virtual;
        {-}
      function pm_GetFlags: Tl3OperationFlags;
        override;
        {-}
    public
    // public methods
      class procedure ToUndo(const anOpPack : InevOp;
                             aPara    : Tl3Variant;
                             aPos           : Long;
                             aSt            : Tl3CustomString);
        {-}
      constructor Create(aPara : Tl3Variant;
                         aPos        : Long;
                         aSt         : Tl3CustomString);
        reintroduce;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    {public properties}
      property S: Tl3String
        read f_S;
        {-}
  end;{OevInsertString}

  OevInsertString1 = class(OevInsertString)
    protected
    {internal methods}
      procedure OpRedo(const Context : InevOp);
        override;
        {-}
  end;{OevInsertString1}

  OevDeleteString = class(OevInsertString)
    protected
    {internal methods}
      function DoJoin(anOperation: Tk2Op): Tk2Op;
        override;
        {-соединяет две операции и возвращает:
          nil  - соединение неудачно
          Self - соединение удачно и все поместилось в старую запись
          New  - распределена новая операция }
      procedure OpUndo(const Context: InevOp);
        override;
        {-}
      procedure OpRedo(const Context: InevOp);
        override;
        {-}
      function pm_GetFlags: Tl3OperationFlags;
        override;
        {-}
      function CanJoinWith(anOperation: Tk2Op): Bool;
        override;
        {-}
      function CanLinkWith(anOperation: Tk2Op): Bool;
        override;
        {-}
  end;{OevDeleteString}

  OevDeleteString1 = class(OevDeleteString)
    protected
    {internal methods}
      procedure OpUndo(const Context : InevOp);
        override;
        {-}
  end;{OevDeleteString1}

  TevOpJoinParas = class(TevParaOperation)
    private
    {internal fields}
      f_SecondPara : Tl3Variant;
    protected
    {internal methods}
      procedure DoIt(const Container: InevOp);
        {-}
    public
    // public methods
      class procedure ToUndo(const anOpPack : InevOp;
                             aPara    : Tl3Variant;
                             aSecond  : Tl3Variant);
        {-}
      constructor Create(aPara   : Tl3Variant;
                         aSecond : Tl3Variant);
        reintroduce;
        {-}
      procedure Cleanup;
        override;
        {-}
  end;//TevOpJoinParas

  OevJoinParas = class(TevOpJoinParas)
    protected
    {internal methods}
      procedure DoRedo(const Container: InevOp);
        override;
        {-повторить операцию}
  end;{OevJoinParas}

  OevBreakPara = class(TevOpJoinParas)
    protected
    {internal methods}
      procedure DoUndo(const Container: InevOp);
        override;
        {-отменить операцию}
  end;{OevBreakPara}

implementation

{$IfNDef k2ForEditor}
//  !!! Ошибка: не определена директива k2ForEditor.
{$EndIf  k2ForEditor}

uses
  SysUtils,
  
  l3InternalInterfaces,

  k2Tags,

  evInternalInterfaces,
  evSegLst,
  evParaTools,
  evTextParaTools,
  evTextManipulationInterfaces
  ;

procedure InsString(O: OevInsertString; ForJoin: Bool; const Context : InevOp);
var
 l_Processor : InevProcessor;
 Processor   : IevTextOpProcessor;
begin
 l_Processor := Context.Processor;
 try
  Processor := (l_Processor As IevTextOpProcessor);
  Processor.CheckTextOp(O.f_S, l3_opInsert);
  if ForJoin then
  begin
   if evDir_InsertText(O.Para(Context) As InevTextPara, O.f_S, O.f_Pos, false, false, Context) then
    Processor.TextOp(O.f_S, l3_opInsert);
  end//ForJoin
  else
  begin
   if evDir_InsertText(O.Para(Context) As InevTextPara, O.f_S, O.f_Pos, true, false, Context) then
    Processor.TextOp(O.f_S, l3_opInsert);
  end;{ForJoin}
 finally
  l_Processor := nil;
 end;//try..finally
end;

procedure DelString(O: OevInsertString; const Context : InevOp);
var
 Processor : InevProcessor;
begin
 Processor := Context.Processor;
 try
  if evDir_DeleteText(O.Para(Context) As InevTextPara, O.f_Pos, O.f_S.Len, nil, Context) then
   (Processor As IevTextOpProcessor).TextOp(O.f_S, l3_opDelete);
 finally
  Processor := nil;
 end;//try..finally
end;

// start class OevInsertString

constructor OevInsertString.Create(aPara : Tl3Variant;
                                   aPos        : Long;
                                   aSt         : Tl3CustomString);
  {virtual;}
  {-}
begin
 inherited Create(aPara);
 f_Pos := aPos;
 f_S := Tl3String.Make(aSt);
end;

class procedure OevInsertString.ToUndo(const anOpPack : InevOp;
                                       aPara    : Tl3Variant;
                                       aPos           : Long;
                                       aSt            : Tl3CustomString);
  {-}
var
 l_Op : OevInsertString;
begin
 if (anOpPack <> nil) AND anOpPack.SaveUndo then
 begin
  l_Op := Create(aPara, aPos, aSt);
  try
   anOpPack.MarkModified(aPara);
   l_Op.Put(anOpPack, true);
  finally
   l3Free(l_Op);
  end;//try..finally
 end;//anOpPack <> nil
end;

procedure OevInsertString.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_S);
 inherited;
end;

function OevInsertString.CanJoinWith(anOperation: Tk2Op): Bool;
  {override;}
  {-}
var
 OIS: OevInsertString absolute anOperation;
begin
 Result := (anOperation Is OevInsertString) AND (ofInsert in anOperation.Flags);
 if Result then
  Result := TagInst.IsSame(OIS.TagInst) AND (f_Pos + f_S.Len = OIS.f_Pos);
end;

function OevInsertString.CanLinkWith(anOperation: Tk2Op): Bool;
  {override;}
  {-}
begin
 Result := inherited CanLinkWith(anOperation) AND (ofInsert in anOperation.Flags);
 if not Result then Result := (anOperation Is OevBreakPara) AND (ofInsert in Flags);
end;

function OevInsertString.DoJoin(anOperation: Tk2Op): Tk2Op;
  {override;}
  {-соединяет две операции и возвращает:
    nil  - соединение неудачно
    Self - соединение удачно и все поместилось в старую запись
    New  - распределена новая операция }
var
 OIS: OevInsertString absolute anOperation;
begin
 f_S.JoinWith(OIS.f_S);
 Result := Self;
end;

procedure OevInsertString.DoUndo(const Container: InevOp);
  {override;}
  {-отменить операцию}
begin
 OpUndo(Container);
 inherited;
end;

procedure OevInsertString.DoRedo(const Container: InevOp);
  {override;}
  {-повторить операцию}
begin
 OpRedo(Container);
 inherited;
end;

procedure OevInsertString.OpUndo(const Context : InevOp);
  {virtual;}
  {-}
begin
 DelString(Self, Context);
end;

procedure OevInsertString.OpRedo(const Context : InevOp);
  {virtual;}
  {-}
begin
 InsString(Self, false, Context);
end;

function OevInsertString.pm_GetFlags: Tl3OperationFlags;
  {override;}
  {-}
begin
 Result := [ofInsert, ofModify, ofCanUndo, ofCanRedo];
end;

// start class OevInsertString1

procedure OevInsertString1.OpRedo(const Context : InevOp);
  {override;}
  {-}
begin
 InsString(Self, true, Context);
end;

// start class OevDeleteString

procedure OevDeleteString.OpUndo(const Context: InevOp);
  {override;}
  {-}
begin
 InsString(Self, false, Context);
end;

procedure OevDeleteString.OpRedo(const Context: InevOp);
  {override;}
  {-}
begin
 DelString(Self, Context);
end;

function OevDeleteString.pm_GetFlags: Tl3OperationFlags;
  {override;}
  {-}
begin
 Result := [ofDelete, ofModify, ofCanUndo, ofCanRedo];
end;

function OevDeleteString.CanJoinWith(anOperation: Tk2Op): Bool;
  {override;}
  {-}
var
 ODS : OevDeleteString absolute anOperation;
begin
 Result := (anOperation <> nil) AND
           (anOperation.ClassType = ClassType) AND
           // - проверка без использования оператора As
           // - для предотвращения склеивания OevDeleteString и OevDeleteString1
           (ofDelete in anOperation.Flags);
 if Result then Result := TagInst.IsSame(ODS.TagInst) AND
                          ((f_Pos = ODS.f_Pos) OR (f_Pos = ODS.f_Pos + ODS.f_S.Len));
end;

function OevDeleteString.DoJoin(anOperation: Tk2Op): Tk2Op;
  {override;}
  {-соединяет две операции и возвращает:
    nil  - соединение неудачно
    Self - соединение удачно и все поместилось в старую запись
    New  - распределена новая операция }
var
 ODS : OevDeleteString absolute anOperation;
begin
 if (anOperation Is OevDeleteString) AND (f_Pos = ODS.f_Pos + ODS.f_S.Len) then begin
  f_Pos := ODS.f_Pos;
  f_S.Insert(ODS.f_S, 0);
  Result := Self;
 end else Result := inherited DoJoin(anOperation);
end;

function OevDeleteString.CanLinkWith(anOperation: Tk2Op): Bool;
  {override;}
  {-}
begin
 Result := inherited CanLinkWith(anOperation) AND (ofDelete in anOperation.Flags);
 if not Result then Result := (anOperation Is OevJoinParas) AND (ofDelete in Flags);
end;

// start class OevDeleteString1 

procedure OevDeleteString1.OpUndo(const Context: InevOp);
  {override;}
  {-}
begin
 InsString(Self, true, Context);
end;

// start class OevBreakPara 

procedure OevBreakPara.DoUndo(const Container: InevOp);
  {override;}
  {-отменить операцию}
begin
 DoIt(Container);
 inherited;
end;

// start class OevJoinParas 

procedure OevJoinParas.DoRedo(const Container: InevOp);
  {override;}
  {-повторить операцию}
begin
 DoIt(Container);
 inherited;
end;

// start class TevOpJoinParas

constructor TevOpJoinParas.Create(aPara   : Tl3Variant;
                                  aSecond : Tl3Variant);
  {-}
begin
 inherited Create(aPara);
 aSecond.SetRef(f_SecondPara);
end;

class procedure TevOpJoinParas.ToUndo(const anOpPack : InevOp;
                                      aPara    : Tl3Variant;
                                      aSecond  : Tl3Variant);
  {-}
var
 l_Op : TevOpJoinParas;
begin
 if (anOpPack <> nil) then
 begin
  l_Op := Create(aPara, aSecond);
  try
   anOpPack.MarkModified(aPara);
   l_Op.Put(anOpPack, true);
  finally
   l3Free(l_Op);
  end;//try...finally
 end;//anOpPack <> nil
end;

procedure TevOpJoinParas.Cleanup;
  {override;}
  {-}
begin
 FreeAndNil(f_SecondPara);
 inherited;
end;

procedure TevOpJoinParas.DoIt(const Container: InevOp);
  {override;}
  {-повторить операцию}
var
 l_Para : InevPara;
 l_O    : InevObject;
 l_Segs : Tl3Variant;
begin
 l_Segs := f_SecondPara.Attr[k2_tiSegments];
 if l_Segs.IsValid then
 begin
  l_Para := Para(Container);
  if not l_Para.AsObject.QT(InevObject, l_O) then
   Assert(false);
  evSegments_AddSegments(l_O,
                         //l_Para.Attr[k2_tiSegments],
                         f_SecondPara.Attr[k2_tiSegments],
                         0, evTextLength(l_Para.AsObject),
                         nil);
 end;//l_Segs.IsValid
 inherited;
end;

end.

