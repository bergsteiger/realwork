unit evRangeTools;
{* Вспомогательные функции для работы с блоками. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evRangeTools -  }
{ Начат: 07.09.2001 12:55 }
{ $Id: evRangeTools.pas,v 1.4 2015/03/11 10:17:54 dinishev Exp $ }

// $Log: evRangeTools.pas,v $
// Revision 1.4  2015/03/11 10:17:54  dinishev
// {Requestlink:589881168}. Убрал лишние проверки.
//
// Revision 1.3  2015/02/27 10:33:37  dinishev
// {Requestlink:589881168}
//
// Revision 1.2  2012/04/20 06:27:36  lulin
// {RequestLink:356847447}
//
// Revision 1.1  2009/09/14 11:28:04  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.6  2009/07/14 14:56:27  lulin
// {RequestLink:141264340}. №25.
//
// Revision 1.5  2008/11/11 11:09:23  lulin
// - <K>: 122672539.
//
// Revision 1.4  2008/05/28 07:58:23  lulin
// - <CQ>: 29146.
//
// Revision 1.3  2008/04/11 12:01:31  lulin
// - <K>: 89100701.
//
// Revision 1.2  2007/12/04 12:47:04  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.2.1  2005/06/16 14:59:14  lulin
// - cleanup: удалены ненужные зависимости.
//

{$Include evDefine.inc }

interface

uses
  nevTools
  ;

type
  TevBlockCompareResult = (ev_bcrLeft, ev_bcrLeftNear, ev_bcrLeftContains,
                           ev_bcrContains, ev_bcrEQ, ev_bcrContained,
                           ev_bcrRightContains, ev_bcrRightNear, ev_bcrRight,
                           ev_bcrLeftEQ, ev_bcrRightEQ,
                           ev_bcrLeftContained, ev_bcrRightContained);
    {-}
  TevBlockCompareResults = set of TevBlockCompareResult;
    {-}

const
  ev_bcrsLeft = [ev_bcrLeft, ev_bcrLeftNear];
    {-}
  ev_bcrsRight = [ev_bcrRight, ev_bcrRightNear];
    {-}
  ev_bcrsContains = [ev_bcrContains, ev_bcrRightContains, ev_bcrLeftContains,
                     ev_bcrRightEQ, ev_bcrLeftEQ];
    {-}
  ev_bcrsContained = [ev_bcrContained, ev_bcrLeftContained, ev_bcrRightContained];
    {-}
  ev_bcrsEQ = [ev_bcrEQ];
    {-}

function evCompareBlocks(const A: InevRange;
                         const B: InevRange): TevBlockCompareResult;
  {-}
function evBlockContains(const A: InevRange;
                         const B: InevRange): Boolean;
  {-}
function evBlockContained(const A: InevRange;
                          const B: InevRange): Boolean;
  {-}
function evBlockLeftTo(const A: InevRange;
                       const B: InevRange): Boolean;
  {-}
function evBlockRightTo(const A: InevRange;
                        const B: InevRange): Boolean;
  {-}
function evBlockEQ(const A: InevRange;
                   const B: InevRange): Boolean;
  {-}

implementation

function evCompareBlocks(const A: InevRange;
                         const B: InevRange): TevBlockCompareResult;
  {-}
var
 l_AStart     : InevBasePoint;
 l_AFinish    : InevBasePoint;
 l_BStart     : InevBasePoint;
 l_BFinish    : InevBasePoint;

 l_StartDiff  : Integer;
 l_FinishDiff : Integer;

 l_AFinishDiffBStart : Integer;
 l_AStartDiffBFinish : Integer;
begin
 A.GetBorderPoints(l_AStart, l_AFinish);
 B.GetBorderPoints(l_BStart, l_BFinish);

 if (l_AStart = nil) then
 begin
  l_AStartDiffBFinish := -1;
  if (l_BStart = nil) then
   l_StartDiff := 0
  else
   l_StartDiff := -1;
 end//l_AStart = nil
 else
 begin
  l_AStartDiffBFinish := l_AStart.Compare(l_BFinish);
  l_StartDiff := l_AStart.Compare(l_BStart);
 end;//l_AStart = nil

 if (l_AFinish = nil) then
 begin
  l_AFinishDiffBStart := 1;
  if (l_BFinish = nil) then
   l_FinishDiff := 0
  else
   l_FinishDiff := 1;
 end//l_AFinish = nil
 else
 begin
  l_FinishDiff := l_AFinish.Compare(l_BFinish);
  l_AFinishDiffBStart := l_AFinish.Compare(l_BStart);
 end;//l_AFinish = nil

 if (l_StartDiff < 0) then
 begin
  if (l_FinishDiff < 0) then
  begin
   if (l_AFinishDiffBStart < 0) then
    Result := ev_bcrLeft
   else
   if (l_AFinishDiffBStart = 0) then
    Result := ev_bcrLeftNear
   else
    Result := ev_bcrLeftContains;  
  end
  else
  if (l_FinishDiff = 0) then
   Result := ev_bcrRightEQ
  else
   Result := ev_bcrContains; 
 end//l_StartDiff < 0
 else
 if (l_StartDiff = 0) then
 begin
  if (l_FinishDiff < 0) then
   Result := ev_bcrRightContained
  else
  if (l_FinishDiff = 0) then
   Result := ev_bcrEQ
  else
   Result := ev_bcrLeftEQ; 
 end//l_StartDiff = 0
 else
 begin
  if (l_FinishDiff < 0) then
   Result := ev_bcrContained
  else
  if (l_FinishDiff = 0) then
   Result := ev_bcrLeftContained
  else
  begin
   if (l_AStartDiffBFinish < 0) then
    Result := ev_bcrRightContains
   else
   if (l_AStartDiffBFinish = 0) then
    Result := ev_bcrRightNear
   else
    Result := ev_bcrRight;
  end;//l_FinishDiff > 0
 end;//l_StartDiff > 0
end;

function evBlockContains(const A: InevRange;
                         const B: InevRange): Boolean;
  {-}
begin
 Result := evCompareBlocks(A, B) in ev_bcrsContains;
end;

function evBlockContained(const A: InevRange;
                          const B: InevRange): Boolean;
  {-}
begin
 Result := evCompareBlocks(A, B) in ev_bcrsContained;
end;

function evBlockLeftTo(const A: InevRange;
                       const B: InevRange): Boolean;
  {-}
begin
 Result := evCompareBlocks(A, B) in ev_bcrsLeft;
end;

function evBlockRightTo(const A: InevRange;
                        const B: InevRange): Boolean;
  {-}
begin
 Result := evCompareBlocks(A, B) in ev_bcrsRight;
end;

function evBlockEQ(const A: InevRange;
                   const B: InevRange): Boolean;
  {-}
begin
 Result := evCompareBlocks(A, B) in ev_bcrsEQ;
end;

end.

