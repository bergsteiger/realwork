unit k2TagTool;
{* Базовые классы для инструментов, манипулирующих тегами. }

{ Библиотека "K-2"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: k2TagTool -     }
{ Начат: 31.03.2005 13:20 }
{ $Id: k2TagTool.pas,v 1.112 2015/02/26 09:29:00 kostitsin Exp $ }

// $Log: k2TagTool.pas,v $
// Revision 1.112  2015/02/26 09:29:00  kostitsin
// List*ner -> Listener
//
// Revision 1.111  2015/02/25 13:53:20  kostitsin
// List*ner -> Listener
//
// Revision 1.110  2015/01/19 17:03:43  lulin
// {RequestLink:580710025}
//
// Revision 1.109  2015/01/19 16:50:49  lulin
// {RequestLink:580710025}
//
// Revision 1.108  2014/04/29 13:38:56  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.107  2014/04/29 12:04:04  lulin
// - вычищаем ненужный метод.
//
// Revision 1.106  2014/04/08 17:13:26  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.105  2014/04/08 12:35:19  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.104  2014/04/07 17:57:11  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.103  2014/04/03 17:10:39  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.102  2014/03/24 10:42:08  lulin
// {RequestLink:522793127}
//
// Revision 1.101  2014/03/18 15:57:07  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.100  2014/03/14 13:27:33  lulin
// - удаляем ненужный интерфейс.
//
// Revision 1.99  2014/03/13 15:46:03  lulin
// - разделяем реализацию Tag и _Box.
//
// Revision 1.98  2014/03/12 11:45:40  lulin
// - выделяем базового предка.
//
// Revision 1.97  2014/03/11 11:37:13  lulin
// - чистим код.
//
// Revision 1.96  2014/03/05 11:33:16  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.95  2013/12/26 12:49:19  lulin
// {RequestLink:509706011}
//
// Revision 1.94  2013/12/25 15:10:33  lulin
// {RequestLink:509706011}
// - перетрясаем модель.
//
// Revision 1.93  2012/10/26 19:12:34  lulin
// - вычищаем поддержку ветки редактора.
//
// Revision 1.92  2012/10/26 16:44:14  lulin
// - вычищаем поддержку ветки редактора.
//
// Revision 1.91  2011/08/04 09:45:11  dinishev
// [$235058873]. Округление для маркеров.
//
// Revision 1.90  2009/07/23 13:42:34  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.89  2009/07/23 08:46:41  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.88  2009/07/23 08:15:03  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.87  2009/07/20 16:44:08  lulin
// - убираем из некоторых листьевых параграфов хранение типа конкретного тега, вместо этого "плодим" под каждый тип тега свой тип класса.
//
// Revision 1.86  2009/07/15 15:12:26  lulin
// - удалено ненужное свойство списков параграфов.
//
// Revision 1.85  2009/07/10 16:15:48  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.84  2009/07/10 15:04:49  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.83  2009/07/10 13:56:01  lulin
// - избавляемся от лишнего виртуального метода.
//
// Revision 1.82  2009/07/10 13:03:31  lulin
// - чистка кода.
//
// Revision 1.81  2009/07/09 14:54:29  lulin
// {RequestLink:140837386}. №3.
//
// Revision 1.80  2009/07/01 15:26:10  lulin
// - убрана ненужная функциональность.
//
// Revision 1.79  2009/06/29 14:15:51  lulin
// {RequestLink:154075236}. №6.
//
// Revision 1.78  2009/06/26 17:22:28  lulin
// - предотвращаем возможные поломки в ветке в Архивариусе.
//
// Revision 1.77  2009/06/26 17:16:20  lulin
// [$154075236]. Удаляем ненужную подписку к событиям (пока может кое-что разломаться).
//
// Revision 1.76  2009/04/16 15:03:21  lulin
// [$143396720]. №9.
//
// Revision 1.75  2009/04/16 08:51:11  lulin
// [$144146829]. Недовычистил обращение к процессору.
//
// Revision 1.74  2009/04/15 18:49:41  lulin
// [$143396720]. Основательно перетрясаем модель.
//
// Revision 1.73  2009/04/14 18:42:27  lulin
// [$143396720]. Вычищаем.
//
// Revision 1.72  2009/04/14 18:12:01  lulin
// [$143396720]. Подготовительная работа.
//
// Revision 1.71  2009/04/09 14:12:56  lulin
// [$140837386]. №15.
//
// Revision 1.70  2009/04/07 16:18:33  lulin
// [$140837386]. Чистка кода.
//
// Revision 1.69  2009/04/07 16:09:48  lulin
// [$140837386]. №13.
//
// Revision 1.68  2009/03/05 16:20:42  lulin
// - <K>: 137470629. Убрана ненужная ссылка на тип по идентификатору.
//
// Revision 1.67  2009/02/26 12:25:11  lulin
// - <K>: 137465982. №1
//
// Revision 1.66  2009/02/26 10:21:28  lulin
// - <K>: 137465982. №1
//
// Revision 1.65  2009/02/25 17:43:47  lulin
// - <K>: 90441983. Переносим на модель.
//
// Revision 1.64  2008/09/17 12:53:53  lulin
// - переносим TnevLeafPara на модель.
//
// Revision 1.63  2008/09/17 08:54:23  lulin
// - переносим TnevPara на модель.
//
// Revision 1.62  2008/09/16 11:51:55  lulin
// - переносим TnevParaList на модель.
//
// Revision 1.61  2008/04/08 17:25:04  lulin
// - поправлено имя метода.
//
// Revision 1.60  2008/02/21 16:04:28  lulin
// - упрощаем наследование.
//
// Revision 1.59  2008/02/08 17:06:20  lulin
// - класс _Tk2TagObject переехал на модель.
//
// Revision 1.58  2007/08/21 11:39:50  lulin
// - избавляемся от предупреждений компилятора.
//
// Revision 1.57  2006/04/18 07:25:36  lulin
// - bug fix: не очищали явным образом ссылку на родителя.
//
// Revision 1.56  2006/04/12 06:16:04  oman
// Не компилировалось - не хватало k2Strings
//
// Revision 1.55  2005/11/16 18:39:35  lulin
// - bug fix: было потеряно событие о смене тега.
//
// Revision 1.54  2005/11/16 18:33:01  lulin
// - в событие сообщающее об изменении тега подаем старое и новое значение тега.
//
// Revision 1.53  2005/11/11 17:01:37  lulin
// - bug fix: зависала оболочка при переключении документа с пустого на непустой (CQ OIT5-17961).
//
// Revision 1.52  2005/11/09 15:28:38  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.51  2005/08/25 05:35:02  mmorozov
// new: полезный код для работы с Tl3Bool вынесен в l3Utils;
//
// Revision 1.50  2005/08/24 06:10:26  mmorozov
// change: изжит Tk2Bool вместо него используется Tl3Bool;
//
// Revision 1.49  2005/08/23 07:19:11  mmorozov
// change: названия перечислимого типа Tk2Bool, который стал Tl3Bool;
//
// Revision 1.48  2005/06/30 16:54:01  lulin
// - исправления - чтобы собирался и правильно работал Архивариус.
//
// Revision 1.47  2005/06/30 16:38:22  lulin
// - выключено кеширование атрибутов тегов, как вредное и приводящее к лишней нотификации и в силу этого к замедлению при загрузке документа.
//
// Revision 1.46  2005/06/14 14:51:58  lulin
// - new interface: InevSelection.
// - remove interface: IevSelection.
//
// Revision 1.45  2005/05/31 08:15:25  lulin
// - new behavior: корректнее присваиваем инструменты для работы с тегами.
//
// Revision 1.44  2005/04/28 15:04:09  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.43.2.3  2005/04/23 16:07:35  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.43.2.2  2005/04/23 12:44:13  lulin
// - cleanup.
//
// Revision 1.43.2.1  2005/04/21 14:47:03  lulin
// - избавляемся от обертки над тегами - теперь объекты посредством шаблонов сами реализуют интерфейс _Ik2Tag.
//
// Revision 1.43  2005/04/21 05:49:12  lulin
// - подготовка к объединению шаблонов.
//
// Revision 1.42  2005/04/21 05:27:04  lulin
// - в шаблонах объединил интерфейс и реализацию - чтобы удобнее читать/править было.
//
// Revision 1.41  2005/04/20 17:40:57  lulin
// - избавился от промежуточного интерфейса Ik2TagBoxQT.
//
// Revision 1.40  2005/04/20 16:31:20  lulin
// - добавлен шаблон для реализации собственно тега.
//
// Revision 1.39  2005/04/20 16:09:46  lulin
// - используем шаблон.
//
// Revision 1.38  2005/04/20 15:54:21  lulin
// - добавлен шаблон для реализации Ik2TagWrap.
//
// Revision 1.37  2005/04/20 15:16:46  lulin
// - new method: Ik2TagBox.rLong.
//
// Revision 1.36  2005/04/20 14:51:44  lulin
// - объединены две ветки инструментов тегов.
//
// Revision 1.35  2005/04/15 08:59:57  lulin
// - теперь держим ссылку на тег, а не собственно тег.
//
// Revision 1.34  2005/04/12 09:53:09  lulin
// - объединил с веткой - в попытках починить List Index Out Of Bounds.
//
// Revision 1.33.2.2  2005/04/08 12:00:38  lulin
// - _Processor стал обязательным параметром.
//
// Revision 1.33.2.1  2005/04/08 11:42:11  lulin
// - теперь инструменты получают нотификацию об удалении тегов.
//
// Revision 1.33  2005/04/07 16:40:29  lulin
// - new method: _Ik2TagTool._SignalChildIsDead.
//
// Revision 1.32  2005/04/07 16:20:43  lulin
// - new method: Ik2TagBox.MakeInterface.
//
// Revision 1.31  2005/04/07 16:05:07  lulin
// - new method: Ik2TagBox.MakeInterface.
//
// Revision 1.30  2005/04/07 11:26:20  lulin
// - cleanup.
//
// Revision 1.29  2005/04/07 11:20:22  lulin
// - cleanup.
//
// Revision 1.28  2005/04/07 09:12:14  lulin
// - переходим на использование параграфов.
//
// Revision 1.27  2005/04/06 14:34:04  lulin
// - bug fix: отдавали не тот интерфейс, который нас просили.
//
// Revision 1.26  2005/04/06 13:49:11  lulin
// - new class: _Tk2NullTool.
// - new proc: _k2NullTool.
//
// Revision 1.25  2005/04/06 08:47:20  lulin
// - связываем инструменты в цепочки для более быстрого получения интересующего инструмента.
//
// Revision 1.24  2005/04/05 16:07:07  lulin
// - new behavior: теперь иструменты имеют возможность получать нотификацию об изменении атрибутов.
//
// Revision 1.23  2005/04/05 07:35:26  lulin
// - bug fix: забывали очистить ссылки на родителей.
//
// Revision 1.22  2005/04/04 16:22:48  lulin
// - new prop: _Ik2TagTool._ParentTool.
//
// Revision 1.21  2005/04/04 15:46:31  lulin
// - используем параграф, вместо "безликого" тега.
//
// Revision 1.20  2005/04/04 14:51:49  lulin
// - new method: _Ik2TagTool._IsSame.
//
// Revision 1.19  2005/04/04 14:17:46  lulin
// - при кешировании учитываем - можно ли это делать.
//
// Revision 1.18  2005/04/04 12:57:21  lulin
// - у шаблонов выделен общий предок.
//
// Revision 1.17  2005/04/04 12:11:32  lulin
// - переименованы файлы с шаблонами.
//
// Revision 1.16  2005/04/04 09:56:31  lulin
// - TevMarker теперь полноценный _Ik2TagTool.
//
// Revision 1.15  2005/04/04 08:00:09  lulin
// - cleanup.
//
// Revision 1.14  2005/04/01 16:56:00  lulin
// - new behavior: теперь все инструменты, которыми в данный момент пользуются, получают сообщения о событиях происходящих с тегами.
//
// Revision 1.13  2005/04/01 16:36:41  lulin
// - объединение списков параграфов переведено на InevParaList.
//
// Revision 1.12  2005/04/01 16:23:34  lulin
// - разрешаем кешировать состояния тегов, т.к. снялась проблема, что кеш очищался позже, чем таблица тегов.
//
// Revision 1.11  2005/04/01 13:22:00  lulin
// - добавлены интерфейсы InevPoint*.
//
// Revision 1.10  2005/04/01 11:05:22  lulin
// - сообщаем курсорам о вставке параграфов посредством механизма событий.
//
// Revision 1.9  2005/03/31 16:26:48  lulin
// - new behavior: если инструмент сам поддерживает другой инструмент, то он не запрашивает его у параграфа (тега).
//
// Revision 1.8  2005/03/31 16:24:08  lulin
// - InevParaList теперь наследуется от InevPara.
//
// Revision 1.7  2005/03/31 16:13:15  lulin
// - new methods: InevPara.OwnerTag, OwnerPara.
//
// Revision 1.6  2005/03/31 14:58:46  lulin
// - new method: _Ik2TagTool.QT.
//
// Revision 1.5  2005/03/31 13:12:43  lulin
// - добавлены модификаторы reintroduce.
//
// Revision 1.4  2005/03/31 12:34:15  lulin
// - new unit: nevParaList.
//
// Revision 1.3  2005/03/31 11:15:36  lulin
// - new class: _Tk2ProcTagTool.
//
// Revision 1.2  2005/03/31 09:42:49  lulin
// - new interface: InevParaList.
//
// Revision 1.1  2005/03/31 09:27:12  lulin
// - new unit: k2TagTool.
//

{$Include k2Define.inc }

interface

uses
  Classes,

  l3Interfaces,
  l3Types,
  l3IID,
  l3ProtoObject,
  l3Variant,

  k2BaseTypes,
  k2Interfaces,

  k2Const,
  k2Base,
  k2ToolPrim,
  k2InterfaceFactory
  ;

type
 _k2TagHolder_Parent_ = Tk2ToolPrim;
 {$Include k2TagHolder.imp.pas}
 _k2TagBox_Parent_ = _k2TagHolder_;
 {$Include k2TagBox.imp.pas}
 Tk2TagPointer = class(_k2TagBox_, Ik2TagListener, Ik2TagTool)
    private
    // property fields
      f_ParentTool : Ik2TagTool;
    protected
    // interfaces methods
      // Ik2TagListener
      function  GetExcludeEvents: Tk2EventIDs;
        virtual;
      function  ExcludeEvents: Tk2EventIDs;
        {-}
      procedure DoFire(const anEvent : Tk2Event;
                     const anOp    : Ik2Op);
        virtual;
      procedure Fire(const anEvent : Tk2Event;
                     const anOp    : Ik2Op);
        {* - сообщение о том, что с тегом что-то произошло. }
      // Ik2TagTool
      function  GetParentTool: Ik2TagTool;
        virtual;
      function  pm_GetParentTool: Ik2TagTool;
      procedure pm_SetParentTool(const aValue: Ik2TagTool);
        {-}
   function GetAsBox: Tl3Variant; override;
    protected
    // property methods
      procedure pm_SetTarget(aValue: Tl3Variant);
        {-}
    protected
    // internal methods
      function cvCheck(aValue : Tl3Bool; out theValue: Boolean): Boolean;
        overload;
        {-}
      function cvSet(aValue       : Boolean;
                     out theValue : Tl3Bool): Boolean;
        overload;
        {-}
      function cvCheck(const aValue : Tk2Integer; out theValue: Integer): Boolean;
        overload;
        {-}
      function cvSet(aValue       : Integer;
                     out theValue : Tk2Integer): Integer;
        overload;
        {-}
      procedure cvReset(out theValue: Tk2Integer);
        overload;
        {-}
      procedure TagChanged(aNew: Tl3Variant);
        virtual;
        {-}
      function  NeedEvents: Boolean;
        virtual;
        {-} 
      procedure SetTagQT(aTag: Tl3Variant);
        override;
        {-}
      procedure ClearParents;
        virtual;
        {-}
      procedure ClearTagCache;
        virtual;
        {-}
      function  CanCacheTagState: Boolean;
        virtual;
        {-}
      procedure Cleanup;
        override;
        {-}
    protected
    // internal properties
      property TagInst: Tl3Variant
        read GetRedirect;
        {-}
    public
    // public methods
      constructor Create(aTag: Tl3Variant);
        reintroduce;
        virtual;
        {-}
      class function Make(aTag: Tl3Variant): Ik2TagTool;
        reintroduce;
        virtual;
        {-}
      procedure Assign(aSource: Tk2ToolPrim);
        override;
        {-}
    public
    // public properties
      property Target: Tl3Variant
        write pm_SetTarget;
        {* - цель на которую указывает объект. }
      property ParentTool: Ik2TagTool
        read pm_GetParentTool
        write pm_SetParentTool;
        {* - инструмент родительского тега. }
  end;//Tk2TagPointer

  Tk2TagTool = Tk2TagPointer;

implementation

uses
  SysUtils,
  
  l3Except,
  l3Const,
  l3Base,
  l3Utils,
  l3InterfacesMisc,

  k2Facade,
  k2Tags,
  k2NullTagImpl
  ;

type _Instance_R_ = Tk2TagPointer;

{$Include k2TagHolder.imp.pas}

{$Include k2TagBox.imp.pas}

// start class Tk2TagPointer

constructor Tk2TagPointer.Create(aTag: Tl3Variant);
  //reintroduce;
  //virtual;
  {-}
begin
 inherited Create;
 SetTagQT(aTag);
end;

class function Tk2TagPointer.Make(aTag: Tl3Variant): Ik2TagTool;
  //reintroduce;
  //virtual;
  {-}
var
 l_Tool : Tk2TagPointer;
begin
 l_Tool := Create(aTag);
 try
  Result := l_Tool;
 finally
  l3Free(l_Tool);
 end;//try..finally
end;

procedure Tk2TagPointer.Cleanup;
  //override;
  {-}
begin
 Target := nil;
 f_ParentTool := nil;
 inherited;
end;

procedure Tk2TagPointer.Assign(aSource: Tk2ToolPrim);
  //override;
  {-}
begin
 if (Self <> aSource) then
 begin
  if (aSource Is Tk2TagPointer) then
   Assert(false)
  else
   inherited;
 end;//Self <> aSource
end;

function Tk2TagPointer.GetParentTool: Ik2TagTool;
  {-}
begin
 Result := f_ParentTool;
end;

function Tk2TagPointer.pm_GetParentTool: Ik2TagTool;
  {-}
begin
 Result := GetParentTool;
end;

procedure Tk2TagPointer.pm_SetParentTool(const aValue: Ik2TagTool);
  {-}
begin
 f_ParentTool := aValue;
end;

function Tk2TagPointer.GetAsBox: Tl3Variant;
begin
 Result := Redirect.Box;
end;

procedure Tk2TagPointer.pm_SetTarget(aValue: Tl3Variant);
  {-}
begin
 SetTagQT(aValue);
end;

function Tk2TagPointer.cvCheck(aValue : Tl3Bool; out theValue: Boolean): Boolean;
  {-}
begin
 Result := l3BoolCheck(aValue, theValue);
end;

function Tk2TagPointer.cvSet(aValue       : Boolean;
                             out theValue : Tl3Bool): Boolean;
  {-}
begin
 Result := aValue;
 if Result then
  theValue := l3_bTrue
 else
  theValue := l3_bFalse;
end;

function Tk2TagPointer.cvCheck(const aValue : Tk2Integer; out theValue: Integer): Boolean;
  //overload;
  {-}
begin
 if not aValue.rIsSet then
  Result := false
 else
 begin
  Result := true;
  theValue := aValue.rValue;
 end;//not aValue.rIsSet
end;

function Tk2TagPointer.cvSet(aValue       : Integer;
                             out theValue : Tk2Integer): Integer;
  //overload;
  {-}
begin
 Result := aValue;
 theValue.rIsSet := true;
 theValue.rValue := aValue;
end;

procedure Tk2TagPointer.cvReset(out theValue: Tk2Integer);
  //overload;
  {-}
begin
 theValue.rIsSet := false;
end;

function Tk2TagPointer.NeedEvents: Boolean;
  //virtual;
  {-}
begin
 Result := false;
end;

procedure Tk2TagPointer.SetTagQT(aTag: Tl3Variant);
  {-}
var
 l_Tag : Tl3Variant;
begin
 if (aTag = nil) then
 begin
  if (Redirect <> nil) then
  begin
   if NeedEvents AND not StoreToOldCache then
    k2.RemoveListener(Self);
   //Redirect.RemoveTool(Self);
   TagChanged(aTag);
   Redirect := nil;
  end;//Redirect <> nil
 end//aTag = nil
 else
 begin
  l_Tag := aTag;
  if (Redirect = nil) OR not IsSame(l_Tag) then
  begin
   if (Redirect <> nil) then
   begin
    if NeedEvents AND not StoreToOldCache then
     k2.RemoveListener(Self);
    //Redirect.RemoveTool(Self);
   end;//Redirect <> nil
   Assert(Self <> l_Tag);
   TagChanged(l_Tag);
   Redirect := l_Tag;
   if (Redirect <> nil) then
   begin
    //Redirect.AddTool(Self);
    if NeedEvents AND not StoreToOldCache then
     k2.AddListener(Self);
   end;//Redirect <> nil
  end;//...IsSame(l_Tag)
 end;//aTag = nil
end;

procedure Tk2TagPointer.TagChanged(aNew: Tl3Variant);
  //virtual;
  {-}
begin
 ClearTagCache;
end;
  
procedure Tk2TagPointer.ClearParents;
  //virtual;
  {-}
begin
 f_ParentTool := nil;
end;

procedure Tk2TagPointer.ClearTagCache;
  //virtual;
  {-}
begin
 ClearParents;
end;

function Tk2TagPointer.CanCacheTagState: Boolean;
  //virtual;
  {-}
begin
 Result := true;
end;

function Tk2TagPointer.GetExcludeEvents: Tk2EventIDs;
  //virtual;
  {-}
begin
 Result := [k2_eidAttrChanged];
end;

function Tk2TagPointer.ExcludeEvents: Tk2EventIDs;
  //virtual;
  {-}
begin
 Result := GetExcludeEvents;
end;

procedure Tk2TagPointer.DoFire(const anEvent : Tk2Event;
                             const anOp    : Ik2Op);
  //virtual;
  {* - сообщение о том, что с тегом что-то произошло. }
begin
 if (anEvent.ID = k2_eidTypeTableWillBeDestroyed) then
 begin
  TagChanged(nil);
  Redirect := nil;
 end;//anEvent.ID = k2_eidTypeTableWillBeDestroyed
end;

procedure Tk2TagPointer.Fire(const anEvent : Tk2Event;
                             const anOp    : Ik2Op);
  //virtual;
  {* - сообщение о том, что с тегом что-то произошло. }
begin
 DoFire(anEvent, anOp);
end;

end.

