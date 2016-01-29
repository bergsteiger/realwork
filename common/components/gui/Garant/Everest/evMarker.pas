unit evMarker;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evMarker -      }
{ Начат: 26.01.2000 16:16 }
{ $Id: evMarker.pas,v 1.93 2014/04/30 11:23:52 lulin Exp $ }

// $Log: evMarker.pas,v $
// Revision 1.93  2014/04/30 11:23:52  lulin
// - выпрямляем зависимости.
//
// Revision 1.92  2014/04/08 12:35:09  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.91  2014/04/07 17:56:59  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.90  2014/03/28 12:15:22  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.89  2014/03/27 14:19:58  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.88  2014/03/18 17:40:22  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.87  2014/03/18 15:56:59  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.86  2014/03/11 11:37:09  lulin
// - чистим код.
//
// Revision 1.85  2013/12/26 12:49:12  lulin
// {RequestLink:509706011}
//
// Revision 1.84  2013/12/25 15:10:30  lulin
// {RequestLink:509706011}
// - перетрясаем модель.
//
// Revision 1.83  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.82  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.81  2012/01/27 07:45:59  dinishev
// Bug fix: нет реакции на сдвиг маркеров левого отступа параграфа.
//
// Revision 1.80  2011/11/25 13:56:30  dinishev
// {Requestlink:109904163}. Заточка марекров.
//
// Revision 1.79  2011/10/07 12:26:00  dinishev
// {Requestlink:290947845}
//
// Revision 1.78  2011/09/15 18:32:06  lulin
// {RequestLink:278824896}.
//
// Revision 1.77  2011/09/14 07:51:44  lulin
// {RequestLink:278824896}.
//
// Revision 1.76  2011/09/02 14:00:43  dinishev
// Bug fix: не проходили тесты в Арчи.
//
// Revision 1.75  2011/09/01 13:44:25  lulin
// {RequestLink:280006084}.
//
// Revision 1.74  2011/08/04 09:46:29  dinishev
// [$235058873]. Округление для маркеров.
//
// Revision 1.73  2011/07/08 17:05:07  lulin
// {RequestLink:228688745}.
//
// Revision 1.72  2009/07/23 13:42:11  lulin
// - переносим процессор операций туда куда надо.                
//
// Revision 1.71  2009/07/23 08:14:39  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.70  2009/07/06 13:32:06  lulin
// - возвращаемся от интерфейсов к объектам.
//
// Revision 1.69  2009/07/01 15:26:05  lulin
// - убрана ненужная функциональность.
//
// Revision 1.68  2009/06/25 12:57:30  lulin
// - вычищаем ненужный контекст.
//
// Revision 1.67  2009/06/03 08:43:57  lulin
// - используем интерфейсы с модели.
//
// Revision 1.66  2009/04/23 06:14:41  dinishev
// <K> : 142613601
//
// Revision 1.65  2009/04/14 18:11:54  lulin
// [$143396720]. Подготовительная работа.
//
// Revision 1.64  2009/04/09 14:12:36  lulin
// [$140837386]. №15.
//
// Revision 1.63  2009/04/07 16:18:31  lulin
// [$140837386]. Чистка кода.
//
// Revision 1.62  2009/04/03 17:51:27  lulin
// [$140837386]. Ликвидируем старорежимную примесь.
//
// Revision 1.61  2009/03/31 12:04:36  lulin
// [$140286997].
//
// Revision 1.60  2009/03/04 13:32:46  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.59  2008/09/29 12:21:14  lulin
// - выкидываем ненужную функциональность.
//
// Revision 1.58  2008/08/14 13:08:45  lulin
// - переносим метод в рамках <K>: 108626698.
//
// Revision 1.57  2008/05/08 16:10:55  lulin
// - изменения в рамках <K>: 90442475.
//
// Revision 1.56  2008/05/08 11:58:48  lulin
// - bug fix: не копировали все параметры маркера.
//
// Revision 1.55  2008/05/07 18:29:48  lulin
// - изменения в рамках <K>: 90441963.
//
// Revision 1.54  2008/05/07 13:04:23  lulin
// - изменения в рамках <K>: 90441635.
//
// Revision 1.53  2008/04/16 07:34:53  lulin
// - cleanup.
//
// Revision 1.52  2008/04/10 14:34:05  lulin
// - <K>: 89098970.
//
// Revision 1.51  2008/04/08 17:24:58  lulin
// - поправлено имя метода.
//
// Revision 1.50  2008/02/21 19:24:14  lulin
// - упрощаем наследование.
//
// Revision 1.49  2008/02/21 18:37:17  lulin
// - вычищен ненужный параметр.
//
// Revision 1.48  2008/02/21 18:13:20  lulin
// - избавляемся от ненужных типов.
//
// Revision 1.47  2008/02/21 16:04:26  lulin
// - упрощаем наследование.
//
// Revision 1.46  2007/12/07 14:37:43  dinishev
// Bug fix: неправильно отрисовывался маркер правого отступа
//
// Revision 1.45  2007/12/04 12:47:02  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.41.4.11  2007/11/28 13:08:30  dinishev
// Не обновлялись маркеры на линейке
//
// Revision 1.41.4.10  2007/09/14 13:26:05  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.41.4.9.2.1  2007/09/12 16:14:07  lulin
// - убран ненужный параметр по-умолчанию.
//
// Revision 1.41.4.9  2007/09/06 09:37:36  lulin
// - переименовано свойство.
//
// Revision 1.41.4.8  2007/06/19 08:48:24  dinishev
// Cleanup
//
// Revision 1.41.4.7  2007/02/12 18:06:13  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.41.4.6  2006/07/21 11:40:26  lulin
// - имя метода убрано из комментариев - чтобы не находилось контекстным поиском.
//
// Revision 1.41.4.5  2006/07/21 11:35:25  lulin
// - имя метода убрано из комментариев - чтобы не находилось контекстным поиском.
//
// Revision 1.41.4.4  2005/11/16 18:32:59  lulin
// - в событие сообщающее об изменении тега подаем старое и новое значение тега.
//
// Revision 1.41.4.3  2005/11/09 15:28:24  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.41.4.2  2005/09/23 16:03:55  lulin
// - выделен модуль с общими интерфейсами.
//
// Revision 1.41.4.1  2005/05/18 12:42:47  lulin
// - отвел новую ветку.
//
// Revision 1.37.2.4  2005/05/18 12:32:09  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.37.2.3  2005/04/28 09:18:29  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.37.2.2  2005/04/08 13:35:05  lulin
// - _Processor стал обязательным параметром.
//
// Revision 1.37.2.1  2005/04/08 11:42:08  lulin
// - теперь инструменты получают нотификацию об удалении тегов.
//
// Revision 1.40.2.1  2005/04/23 16:07:25  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.40  2005/04/21 05:11:38  lulin
// - используем _Box (пока из-за постоянных преобразований туда и обратно - по скорости стало только хуже).
//
// Revision 1.39  2005/04/20 17:40:50  lulin
// - избавился от промежуточного интерфейса Ik2TagBoxQT.
//
// Revision 1.38  2005/04/12 09:53:06  lulin
// - объединил с веткой - в попытках починить List Index Out Of Bounds.
//
// Revision 1.37.2.2  2005/04/08 13:35:05  lulin
// - _Processor стал обязательным параметром.
//
// Revision 1.37.2.1  2005/04/08 11:42:08  lulin
// - теперь инструменты получают нотификацию об удалении тегов.
//
// Revision 1.41  2005/04/28 15:03:38  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.40.2.1  2005/04/23 16:07:25  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.40  2005/04/21 05:11:38  lulin
// - используем _Box (пока из-за постоянных преобразований туда и обратно - по скорости стало только хуже).
//
// Revision 1.39  2005/04/20 17:40:50  lulin
// - избавился от промежуточного интерфейса Ik2TagBoxQT.
//
// Revision 1.38  2005/04/12 09:53:06  lulin
// - объединил с веткой - в попытках починить List Index Out Of Bounds.
//
// Revision 1.37.2.2  2005/04/08 13:35:05  lulin
// - _Processor стал обязательным параметром.
//
// Revision 1.37.2.1  2005/04/08 11:42:08  lulin
// - теперь инструменты получают нотификацию об удалении тегов.
//
// Revision 1.37  2005/04/07 16:20:41  lulin
// - new method: Ik2TagBox._MakeInterface.
//
// Revision 1.36  2005/04/07 15:42:05  lulin
// - cleanup.
//
// Revision 1.35  2005/04/05 09:55:26  lulin
// - используем IevShape.
//
// Revision 1.34  2005/04/04 09:56:28  lulin
// - TevMarker теперь полноценный _Ik2TagTool.
//
// Revision 1.33  2005/03/28 11:32:07  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.32  2005/03/25 17:09:01  lulin
// - избавляемся от метода Tk2AtomW.sLong.
//
// Revision 1.31  2005/03/10 14:58:38  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.30  2005/03/10 07:05:11  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.29  2004/11/10 11:06:08  lulin
// - new interface: IevTagShape.
// - remove interface: IevVisualShapedTag.
//
// Revision 1.28  2004/11/09 17:06:24  lulin
// - переходим от классов к интерфейсам.
//
// Revision 1.27  2004/11/09 13:37:56  lulin
// - переходим от классов к интерфейсам.
//
// Revision 1.26  2004/11/02 15:28:56  lulin
// - new behavior: не выводим на линейку маркеры для Readonly параметров.
//
// Revision 1.25  2003/05/23 16:33:45  law
// - cleanup: используем IevMarker вместо TevMarker.
//
// Revision 1.24  2003/05/23 15:00:10  law
// - new behavior: в исполнении WordLike не даем изменять размер бумаги и отступы на странице.
//
// Revision 1.23  2003/05/23 14:34:22  law
// - change: TevMarker.Acc - теперь Read-Only.
//
// Revision 1.22  2003/05/16 12:04:08  law
// - bug fix: AV при изменении несуществующего параметра параграфа.
//
// Revision 1.21  2002/11/19 15:32:46  law
// - rename method: Tk2AtomR._rAtom -> _rAtom.
//
// Revision 1.20  2002/07/12 12:38:49  law
// - bug fix: не пускаем наверх ошибки от удаленного параграфа.
//
// Revision 1.19  2002/07/09 12:02:20  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.18  2001/11/23 16:44:54  law
// - change: замена использования TevMarker на IevMarker.
//
// Revision 1.17  2001/09/07 08:53:01  law
// - rename procedures: evPointX -> l3PointX, evPointY -> l3PointY.
//
// Revision 1.16  2001/09/07 07:05:41  law
// - delete methods: _Tl3Base._ParentToClient и _Tl3Base._ClientToParent.
//
// Revision 1.15  2001/04/24 12:40:44  law
// - new behavior:
//  1. Немного поправлена линейка - иногда не перерисовывались засечки.
//  2. Немного изменен алгоритм вычисления шрифта выделения - теперь выделение на больших файлах появляется без задержки.
//
// Revision 1.14  2001/04/13 16:04:58  law
// - bug fix: запрещено изменение значений маркаров в режиме Read-Only.
//
// Revision 1.13  2001/04/04 15:19:21  law
// - new prop: к интерфейсу IevMarker добавлены свойства Level и Para.
//
// Revision 1.12  2001/04/04 12:40:03  law
// - new interfaces: IevMarker, IevTableColumnMarker.
//
// Revision 1.11  2001/03/28 13:48:33  law
// - new behavior: по другому организован алгоритм изменения размера ячеек таблиц.
//
// Revision 1.10  2001/01/25 13:54:53  law
// - к интерфейсу IedParagraphFormatting добавлено свойство FirstIndent.
//
// Revision 1.9  2000/12/15 15:10:36  law
// - вставлены директивы Log.
//

{$Include evDefine.inc }

interface

uses
  Classes,

  l3Interfaces,
  l3Types,
  l3Base,
  l3ProtoObject,

  k2Interfaces,
  k2InternalInterfaces,
  k2TagTool,
  k2Base,
  k2ToolPrim,

  evInternalInterfaces,

  nevBase,
  nevTools
  ;

type
  _nevParaTool_Parent_ = Tk2TagTool;
  {$Include nevParaTool.imp.pas}
  TevMarker = class(_nevParaTool_, IevMarker)
  private
  {property fields}
    f_Type  : Tk2CustomProperty;
    f_Acc   : Long;
    f_Hint  : Il3CString;
    f_Style : TevParaMarkerStyle;
    f_View  : InevView;
  protected
  {property methods}
    function  pm_GetLevel: Long;
      {-}
    function DoGetValue: Long;
      virtual;
      {-}
    function  pm_GetValue: Long;
      {-}
    function  DoGetClientValue: Long;
      virtual;
      {-}
    function  pm_GetClientValue: Long;
      {-}
    procedure SetClientValue(aValue: Long; const aContext: InevOp);
      virtual;
      {-}
    function  pm_GetParaInst: InevPara;
      {-}
    function  pm_GetPara: InevPara;
    procedure pm_SetPara(const aValue: InevPara);
      {-}
    function  Get_TagIndex: Long;
      {-}
    function  Get_Acc: Long;
      {-}
    function  Get_Style: TevParaMarkerStyle;
      {-}
    function  Get_Hint: Il3CString;
      {-}
    function Get_View: InevView;
      {-}
    procedure Set_View(const aView: InevView);
      {-}    
  protected
  // internal methods
    procedure Cleanup;
      override;
      {-}
    procedure DoSetValue(aValue: Long; const Context: InevOp);
      virtual;
      {-}
    function  GetLevel(aPara: Tl3Variant): Long;
      {-}
    procedure TagChanged(aNew: Tl3Variant);
      override;
      {-}
    property View: InevView
      read f_View;
      {-}   
  public
  // public methods
    constructor Create(const aView : InevView;
                       aPara : Tl3Variant;
                       aTag        : Long;
                       aStyle      : TevParaMarkerStyle;
                       const aHint : Il3CString = nil);
      reintroduce;
      virtual;
      {-}
    procedure Assign(P: Tk2ToolPrim);
      override;
      {-}
    procedure SetValue(aValue: Long; const Context: InevOp);
      {-}
    function  MakeCopy(const aTagWrap: InevPara): IevMarker;
      {-}
    procedure IevMarker_SetValue(aValue: Long; const Context: InevOp);
      {* - Установить новое значение параметра. }
    procedure IevMarker.SetValue = IevMarker_SetValue;
      {-}
    function  CompareLevel(aTagWrap: Tl3Variant): Long;
      {* - Сравнить уровени вложенности маркера и тега. }
    function  Compare(const aMarker: IevMarker): Long;
      {* - Сравнивает маркеры. }
  public
  // public properties
    property HitType: Tk2CustomProperty
      read f_Type
      write f_Type;
      {-}
    property Level: Long
      read pm_GetLevel;
      {-}
    property Value: Long
      read pm_GetValue;
      {-}
    property Style: TevParaMarkerStyle
      read f_Style
      write f_Style;
      {-}
    property Para: InevPara
      read pm_GetPara
      write pm_SetPara;
      {-}
    property ParaInst: InevPara
      read pm_GetParaInst;
      {-}  
    property Hint: Il3CString
      read f_Hint
      write f_Hint;
      {-}  
    property ClientValue: Long
      read pm_GetClientValue;
      {-}
    property Acc: Long
      read f_Acc;
      {-}
  end;//TevMarker
  RevMarker = class of TevMarker;

implementation

uses
  SysUtils,

  l3Variant,
  l3Units,

  k2Tags,
  k2Except,

  SBSCell_Const,

  evParaTools,

  Para_Const
  ;

{$Include nevParaTool.imp.pas}

// start class TevMarker

constructor TevMarker.Create(const aView : InevView;
                             aPara : Tl3Variant;
                             aTag        : Long;
                             aStyle      : TevParaMarkerStyle;
                             const aHint : Il3CString);
  {virtual;}
  {-}
begin
 inherited Create(aPara);
 f_View := aView;
 //Para := aPara;
 f_Type := Tk2Prop(Tk2Type(aPara.TagType).Prop[aTag]);
 Style := aStyle;
 f_Acc  := Value;
 Hint := aHint;
end;

procedure TevMarker.Cleanup;
  {override;}
  {-}
begin
 f_View := nil;
 f_Acc := 0;
 Para := nil;
 f_Type := nil;
 f_Hint := nil;
 inherited;
end;

function TevMarker.GetLevel(aPara: Tl3Variant): Long;
  {-}
var
 l_Parent : Tl3Variant;
begin
 Result := 0;
 l_Parent := aPara.Owner;
 while l_Parent.IsValid AND l_Parent.IsKindOf(k2_typPara) do
 begin
  Inc(Result);
  l_Parent := l_Parent.Owner;
 end;//while l_Parent.IsValid..
end;

function TevMarker.pm_GetLevel: Long;
  {-}
begin
 Result := GetLevel(ParaInst.AsObject);
end;

function TevMarker.pm_GetValue: Long;
  {-}
begin
 Result := DoGetValue;
end;

function TevMarker.pm_GetClientValue: Long;
  {virtual;}
  {-}
begin
 Result := DoGetClientValue;
end;

procedure TevMarker.SetClientValue(aValue: Long; const aContext: InevOp);
  {virtual;}
  {-}
begin
 if (HitType <> nil) then
 begin
  ParaInst.AsObject.IntW[HitType.TagIndex, aContext] := aValue;
  ParaInst.Invalidate([nev_spExtent]);
 end; // if (HitType <> nil) then
end;

function TevMarker.pm_GetParaInst: InevPara;
  {-}
begin
 Result := inherited ParaX;
end;

function TevMarker.pm_GetPara: InevPara;
  {-}
begin
 Result := ParaInst;
end;

procedure TevMarker.pm_SetPara(const aValue: InevPara);
  {-}
begin
 if (aValue = nil) then
  SetTagQT(nil)
 else 
  SetTagQT(aValue.AsObject);
end;

procedure TevMarker.Assign(P: Tk2ToolPrim);
  {override;}
  {-}
begin
 if (P is TevMarker) then 
 begin
  Para := TevMarker(P).Para;
  HitType := TevMarker(P).HitType;
  f_Acc := TevMarker(P).Acc;
  Hint := TevMarker(P).Hint;
  Style := TevMarker(P).Style;
  f_View :=  TevMarker(P).View;
 end 
 else
  inherited;
end;

procedure TevMarker.DoSetValue(aValue: Long; const Context: InevOp);
  {-}
var
 l_FI: TnevFormatInfoPrim;
begin
 if (Self.Value <> aValue) then
 begin
  l_FI := View.FormatInfoByPara(ParaInst);
  if l_FI = nil then
   SetClientValue(aValue, Context)
  else
   SetClientValue(l_FI.ParentToClient(l3PointX(aValue)).X, Context);
  ParaInst.OwnerPara.Invalidate([nev_spExtent]);
 end;//Self.Value <> Value
end;

procedure TevMarker.SetValue(aValue: Long; const Context: InevOp);
  {-}
begin
 if (Context <> nil) then
  Context.CheckReadOnly;
 DoSetValue(aValue, Context);
end;

function TevMarker.MakeCopy(const aTagWrap: InevPara): IevMarker;
  {-}
type
 RevMarker = class of TevMarker;
var
 l_T : TevMarker;
begin
 l_T := RevMarker(ClassType).Create(f_View, TagInst, HitType.TagIndex, Style, Hint);
 try
  l_T.Assign(Self);
  l_T.SetTagQT(aTagWrap.AsObject);
  Result := l_T;
 finally
  l3Free(l_T);
 end;//try..finally
end;

procedure TevMarker.TagChanged(aNew: Tl3Variant);
  //override;
  {-}
begin
 inherited;
 if (aNew <> nil) then
 begin
  if (HitType <> nil) then
   HitType := Tk2Prop(Tk2Type(aNew.TagType).Prop[HitType.TagIndex]);
 end;//aNew <> nil
end;

procedure TevMarker.IevMarker_SetValue(aValue: Long; const Context: InevOp);
  {* - Установить новое значение параметра. }
begin
 SetValue(aValue, Context);
end;

function TevMarker.CompareLevel(aTagWrap: Tl3Variant): Long;
  {* - Сравнить уровени вложенности маркера и тега. }
begin
 Result := Level - GetLevel(aTagWrap);
end;

function TevMarker.Compare(const aMarker: IevMarker): Long;
  {* - Сравнивает маркеры. }
begin
 if (aMarker = nil) then
  Result := 1
 else
 begin
  Result := f_Type.TagIndex - aMarker.TagIndex;
  if (Result = 0) then 
   Result := Value - aMarker.Value;
  if (Result = 0) then 
   Result := Acc - aMarker.Acc;
 end;//aMarker = nil
end;

function TevMarker.Get_TagIndex: Long;
  {-}
begin
 if (HitType = nil) then
  Result := 0
 else
  Result := HitType.TagIndex; 
end;

function TevMarker.Get_Acc: Long;
  {-}
begin
 Result := Acc;
end;

function TevMarker.Get_Style: TevParaMarkerStyle;
  {-}
begin
 Result := Style;
end;

function TevMarker.Get_Hint: Il3CString;
  {-}
begin
 Result := Hint;
end;

function TevMarker.Get_View: InevView;
  {-}
begin
 Result := View;
end;

procedure TevMarker.Set_View(const aView: InevView);
begin
 if aView <> f_View then
  f_View := aView;
end;

function TevMarker.DoGetClientValue: Long;
begin
 if (HitType = nil) then
  Result := 0
 else
  Result := ParaInst.AsObject.IntA[HitType.TagIndex];
end;

function TevMarker.DoGetValue: Long;
var
 l_FI: TnevFormatInfoPrim;
begin
 try
  l_FI := View.FormatInfoByPara(ParaInst);
  if l_FI = nil then
   Result := ClientValue
  else
   Result := l_FI.ClientToParent(ClientValue);
 except
  on Ek2ConversionError do
   Result := 0;
 end;//try..except
end;

end.

