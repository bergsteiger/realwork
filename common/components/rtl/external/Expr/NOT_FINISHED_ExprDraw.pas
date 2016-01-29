unit NOT_FINISHED_ExprDraw;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Expr"
// ������: "w:/common/components/rtl/external/Expr/NOT_FINISHED_ExprDraw.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Expr::ExprDraw::ExprDraw
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\Expr\l3Define.inc}

interface

uses
  l3Interfaces,
  l3Core,
  l3Base,
  l3PrinterInterfaces
  ;

type
 TExprCapStyle = (
   ecPoints
 , ecVector
 , ecCap
 , ecTilde
 , ecLine
 );//TExprCapStyle

 TExprBracket = (
   ebNone
 , ebRound
 , ebSquare
 , ebFigure
 , ebModule
 );//TExprBracket

 TExprVertAlign = (
   evTop
 , evCenter
 , evBottom
 );//TExprVertAlign

 TExprHorAlign = (
   ehLeft
 , ehCenter
 , ehRight
 );//TExprHorAlign

 TExprOrigin = (
   eoTop
 , eoBottom
 );//TExprOrigin

 Tl3ExprMetric = (
   tcWidth
 , tcHeight
 , tcPowerXPos
 , tcPowerYPos
 , tcIndexXPos
 , tcIndexYPos
 , tcCapDX
 , tcCapDY
 , tcMidLineUp
 , tcMidlineDn
 , tcSymbolWidth
 , tcSymbolHeight
 );//Tl3ExprMetric

 Tl3Expr = class(Tl3Base)
  {* ������� ������� ��� ���� ������� ���������� ExprDraw �������� Tl3Expr. �� ������������ ���������
����������������: �������� ���� �������������� ������� (�������� Width � Height), ���������,
����������� ��� ����� ��������� ����������� ���� (�������� MidLineUp, MidLineDown, PowerXPos,
PowerYPos, IndexXPos, IndexYPos, CapDXRight, CapDXLeft, CapDY). ���� ���� �� �������� ��������,
�� ���� FParent �������� ��������� �� ������������ ����. �������� Next ������������ ��� ����������
������� �������. ��������� ������ ��� ����� ���������� ����� �� �������. �������� Font � Canvas
������������ ��� ������� ������ � ����� �����������. �� ��������� ������������ ����� Times New Roman,
������������� ������ �������� ������������, ��� ��� ��� ������� ������� �������������� ������ ���
���� ���������. ��������� ������ ������ �� ����� ������, ��� ��� ������ ���� ��� ������������� ����
�����, ������������ ��� ��������� ���������. ������������ �������� ������, ������� ����� �����
��������� - ��� ��� ������. ������ ������� ������ ��� ��������� ���� ������, ����� ���������
���������� ���� ������ (���� ������ �� ����������� �������� ����� �� ������ ������, ��� � ������: �
��������� ������� ������������� ��������� �������� ������ �������� �����, ��������, ��� ����������
�������� ��� ������� �������). ����� ����� ����������� ��������� ���� � ��������� ���� ���������
�����. �������������� ������� � ��������� �� ����� ���� ��������� �� ����, ��� ������ ���������
����� � �����. }
 private
 // private fields
   f_Next : Tl3Expr;
    {* ���� ��� �������� Next}
   f_Font : TFont;
    {* ���� ��� �������� Font}
   f_Canvas : TCanvas;
    {* ���� ��� �������� Canvas}
 protected
 // property methods
   procedure pm_SetNext(aValue: Tl3Expr); virtual;
   function pm_GetColor: Tl3Color; virtual;
   procedure pm_SetColor(aValue: Tl3Color); virtual;
   procedure pm_SetFont(aValue: TFont); virtual;
   procedure pm_SetCanvas(aValue: TCanvas); virtual;
   function pm_GetWidth: Integer; virtual;
   function pm_GetHeight: Integer; virtual;
   function pm_GetMidLineUp: Integer; virtual;
   function pm_GetMidLineDn: Integer; virtual;
   function pm_GetPowerXPos: Integer; virtual;
   function pm_GetPowerYPos: Integer; virtual;
   function pm_GetIndexXPos: Integer; virtual;
   function pm_GetIndexYPos: Integer; virtual;
   function pm_GetCapDXLeft: Integer; virtual;
   function pm_GetCapDXRight: Integer; virtual;
   function pm_GetCapDY: Integer; virtual;
 public
 // public methods
   function FTType: Integer; virtual;
     {* ������� FTType ���������� ���������� ������ efXXXX, ������� ������������ � ���������� ExprMake ���
������������ ��������� � ������� ������� "*". ������ ����� ����������, ����� �� ��������� ����
�������� ��� ����� �����, ������, �������� �� ��� ������ � �.�. }
   constructor Create; reintroduce; virtual;
   procedure AddNext(aValue: Tl3Expr); virtual;
   function CutOff: Tl3Expr; virtual;
   procedure Draw(X: Integer;
    Y: Integer;
    HorAlign: TExprHorAlign;
    VertAlign: TExprVertAlign); virtual;
     {* ������ �������. }
 public
 // public properties
   property Next: Tl3Expr
     read f_Next
     write pm_SetNext;
     {* �������� Next ������������ ��� ���������� ������� �������. ��������� ������ ��� ����� ���������� ����� �� �������. }
   property Color: Tl3Color
     read pm_GetColor
     write pm_SetColor;
     {* �������� Color ���������� ����, ������� ����� ������������ ���������. ���� ����� ���� clNone,
������������ ���� ������������� ����. ���� ��� ��������� ���� ����� ���� clNone, ������������
������ ����. }
   property Font: TFont
     read f_Font
     write pm_SetFont;
     {* �������� Font � Canvas
������������ ��� ������� ������ � ����� �����������. �� ��������� ������������ ����� Times New Roman,
������������� ������ �������� ������������, ��� ��� ��� ������� ������� �������������� ������ ���
���� ���������. ��������� ������ ������ �� ����� ������, ��� ��� ������ ���� ��� ������������� ����
�����, ������������ ��� ��������� ���������. ������������ �������� ������, ������� ����� �����
��������� - ��� ��� ������. ������ ������� ������ ��� ��������� ���� ������, ����� ���������
���������� ���� ������ (���� ������ �� ����������� �������� ����� �� ������ ������, ��� � ������: �
��������� ������� ������������� ��������� �������� ������ �������� �����, ��������, ��� ����������
�������� ��� ������� �������). ����� ����� ����������� ��������� ���� � ��������� ���� ���������
�����. �������������� ������� � ��������� �� ����� ���� ��������� �� ����, ��� ������ ���������
����� � �����. }
   property Canvas: TCanvas
     read f_Canvas
     write pm_SetCanvas;
     {* �������� Font � Canvas
������������ ��� ������� ������ � ����� �����������. �� ��������� ������������ ����� Times New Roman,
������������� ������ �������� ������������, ��� ��� ��� ������� ������� �������������� ������ ���
���� ���������. ��������� ������ ������ �� ����� ������, ��� ��� ������ ���� ��� ������������� ����
�����, ������������ ��� ��������� ���������. ������������ �������� ������, ������� ����� �����
��������� - ��� ��� ������. ������ ������� ������ ��� ��������� ���� ������, ����� ���������
���������� ���� ������ (���� ������ �� ����������� �������� ����� �� ������ ������, ��� � ������: �
��������� ������� ������������� ��������� �������� ������ �������� �����, ��������, ��� ����������
�������� ��� ������� �������). ����� ����� ����������� ��������� ���� � ��������� ���� ���������
�����. �������������� ������� � ��������� �� ����� ���� ��������� �� ����, ��� ������ ���������
����� � �����. }
   property Width: Integer
     read pm_GetWidth;
     {* ������ ������������� �������. }
   property Height: Integer
     read pm_GetHeight;
     {* ������ ������������� �������. }
   property MidLineUp: Integer
     read pm_GetMidLineUp;
     {* MidLineUp, MidLineDown - ���������� (� �������) �� ������� ����� �� �������� � ������� ���� ���������.
������� ����� - ��� �����, �� ������� ������ ������ ���� "-", ���� ��� ��������� ����� ����������. }
   property MidLineDn: Integer
     read pm_GetMidLineDn;
     {* MidLineUp, MidLineDown - ���������� (� �������) �� ������� ����� �� �������� � ������� ���� ���������.
������� ����� - ��� �����, �� ������� ������ ������ ���� "-", ���� ��� ��������� ����� ����������. }
   property PowerXPos: Integer
     read pm_GetPowerXPos;
     {* PowerXPos, PowerYPos - ���� ��������� ����������� ������� ������, �� ��� ��������� ������������ ���
������� ��� ���������. }
   property PowerYPos: Integer
     read pm_GetPowerYPos;
     {* PowerXPos, PowerYPos - ���� ��������� ����������� ������� ������, �� ��� ��������� ������������ ���
������� ��� ���������. }
   property IndexXPos: Integer
     read pm_GetIndexXPos;
     {* IndexXPos, IndexYPos - ����������� ���� ��� ������� �������. }
   property IndexYPos: Integer
     read pm_GetIndexYPos;
     {* IndexXPos, IndexYPos - ����������� ���� ��� ������� �������. }
   property CapDXLeft: Integer
     read pm_GetCapDXLeft;
     {* CapDXLeft, CapDXRight, CapDY - ���������, �������������� ��� ���������������� ��������������� �����
(�������, ������ � �.�.), ���� �� �������� ��� ����������. }
   property CapDXRight: Integer
     read pm_GetCapDXRight;
     {* CapDXLeft, CapDXRight, CapDY - ���������, �������������� ��� ���������������� ��������������� �����
(�������, ������ � �.�.), ���� �� �������� ��� ����������. }
   property CapDY: Integer
     read pm_GetCapDY;
     {* CapDXLeft, CapDXRight, CapDY - ���������, �������������� ��� ���������������� ��������������� �����
(�������, ������ � �.�.), ���� �� �������� ��� ����������. }
 end;//Tl3Expr

 TExprStrokes = class(Tl3Expr)
  {* ����� TExprStrokes ������������ ��� ����������� ��������, �������� ������������ �����������.
������������ ��������� � ������� TExprIndex: ������� ������� � TExprIndex.Son, TExprStrokes
������������ ��� ������� ������. }
 end;//TExprStrokes

 TExprSpace = class(Tl3Expr)
  {* ����� TExprSpace ������������ ��� ��������, ������� � ������� ������� ������������. ��������
������������ Space ����� ������ ����� ������� � �������� ������ (���� ������� ������ �������� �����
������ ������������ ����� � ������� "+"). }
 end;//TExprSpace

 TExprNumber = class(Tl3Expr)
  {* ����� TExprNumber ������������ ��� ����������� ����� � ������� ��� ���������������� �����. ����
�������� ������������ ExpVal ����� True, ������������ ���������������� �����, � ��������� ������ -
�������. }
 end;//TExprNumber

 TExprExpNumber = class(TExprNumber)
  {* ����� TExprExpNumber �������� ����������� TExprNumber. ������ ��� ����������� ����� � ������������
������� ���������� ��������������� �����. }
 end;//TExprExpNumber

 TExprEmpty = class(Tl3Expr)
  {* ����� TExprEmpty ������������ ��� ����������� ��������� � ������� �������, �� �������, ������ ������
�������� ������. ������������ ������ � TExprIndex ��� �������� ��������, "������� � �������". }
 end;//TExprEmpty

 TExprSimple = class(Tl3Expr)
  {* ����� TExprSimple ������ ��� ����������� �������� ������. ����� ��������� ������ �������. }
 end;//TExprSimple

 TExprFuncName = class(TExprSimple)
  {* ����� TExprFuncName �������� ����������� ������ TExprSimple. �� ��������� ��� ������� � ��� ������,
����� ��� ������� ������ �������. �������������� ������� ArgNeedBrackets ����� �������, ����� ��������
�� ���������� � ������, ���� ��� �� �������� �����������. ����� �������� ��� ���������������
�����������, ������������ �������� TExprFuncName.ArgNeedBrackets, �� ������ ����� ��� TExprArgument. }
 end;//TExprFuncName

 TExprCustomText = class(TExprSimple)
  {* ����� TExprCustomText �������� ����������� TExprSimple. � ��� ������� ����� ������� ����� � ������ ���������� � ����� ����������. }
 end;//TExprCustomText

 TExprVar = class(TExprSimple)
  {* ����� TExprVar �������� ����������� TExprSimple. ������� ������� - ����� ��������� �� ������ �������,
� ��������, ��� ��� ������� ��� ����������� ���������� � ����������. }
 end;//TExprVar

 TExprAsterix = class(TExprSimple)
  {* ����� TExprAsterix �������� ����������� ������ TExprSimple. ������������ ��� ����������� �������� (*),
��������� �� �����������. ��� �������� ������������ � �������� �������� ������� (� ��������� ��������
��������� � ������� ������� ������� ���������� ���������� ��������). }
 end;//TExprAsterix

 TExprParent = class(Tl3Expr)
  {* ����� TExprParent �������� ������� ������� ��� ���� �����������-���������. �������� Son ����� ������
������ ��������� �� �������� ���� ������ ���������. ��������� ���������� TExprParent �� ����� ������,
��� ��� ��� ���������������� ����� ������ �������� � ���������� �������� � ������ ��������� ���������.

�������� ��������� � ���������, �� ������� ��������� �������� Next, ������ ����������� �� ������.
���� ����� ������� � �������, �������������� � ������� �������� Next, ��� ����� �� ������ �� ���
������� � ��� ���������, ������������� � ��� �������. ������ ������, �������� �������� Next �����
�� ������������ ����� �������, ���� �� ������� ����, ��� �����, ���� � ����� ���������� ����� ��
�������. ��, ��� ������ ���������� � �������, ����� �������������� ������������ ����� ������� ������
� �������. � ������ �������, ���������, ���������� ��������� Son, �������� ������������ ������
���������, ������������� ����� �������. � �������� ������� ����� �������� �����, �����������
���������� ������. Son ��������� �� ����������� ���������. �����, ��������, ����� ��������� �������
���������, ���� ����� �������� Son.Width � Son.Height � ���������� � ���������� ��������� �������
����� ���������� �����. ��� ������ ������� Draw ���� ����� ������ ���� ����������� �����, � �����
�������� Son.Draw ��� ����������� ������������ ���������. ����� �������, �������� Next ������������
��� ����������� ������� �������, ������ ��, ��� ����� ������ � ����� �������, �� ����� �� ������������.
� �������� Son ������������ ��� ������� ���������, ����������� ������ ���� ���������, �������
������� �������. }
 end;//TExprParent

 TExprCap = class(TExprParent)
  {* ����� TExprCap �������� ����������� TExprParent. ������ ��� ����������, �� ������� ��������� Son,
�������������� ����. �������� ��������� �����:

ecPoints - �����, ������������ ����������� �� �������
ecVector - �������, ������������ ������
ecCap - "������" (^)
ecTilde - ������ (~)
ecLine - ������ �����

����������� �������� �������� Count, ������� ����� ����� ����� ��� ����� ecPoints. ��� ������ ������
���� �������� ������������. }
 end;//TExprCap

 TExprMatrix = class(TExprParent)
  {* TExprMatrix �������� ����������� TExprParent. ������������ ��� ������ �������. ������� �������
������������ ����������� ������������ HorSize � VertSize. ����� ������� ������� ������� �������
���������� Son, ������ ����� � ������� ������ - Son.Next � ��� ����� ����� ������� ������ ����. ����
������� �������, ��� HorSize*VertSize, ��� ����������� ������� ������ �������� ������������ (������
��� �� ������������ ��� �������� �������� ������ �������, ��� ����� �������� � ��������� ���� �������).
���� ������� �������� ������ ���������, ��� HorSize*VertSize, ������, �� ������� �� ������� �����,
����� �������. }
 end;//TExprMatrix

 TExprCase = class(TExprParent)
  {* ����� TExprCase �������� ����������� TExprParent. ���� ����� ������������ ��� ����������� ����������
�����������: ��������� ��������� ��������� ����� �������� �������, ����� ������� �������� �������,
����� ������ ������� ������������. Son ��������� �� ������ �������, Son.Next - �� ������� ���
������������, Son.Next.Next - �� ������ �������, Son.Next.Next.Next - �� ������� ��� ������������
� �.�. ���� ������� �������� �������� ����� �����, ��������� ������� ������� ��� �������. }
 end;//TExprCase

 TExprStand = class(TExprParent)
  {* ����� TExprStand �������� ����������� TExprParent. ������������ ��� ������ ���������� ��������� �
���� ��������. ������ ��������� ���������, �� ������� ��������� Son, ��� ��� - Son.Next, ��� ���� -
Son.Next.Next � ��� ����� �� ����� �������. �������� ������������ Align ����������, ����� �� ���������
������������� �� ������ ����, �� ������� ���� ��� �� ������. }
 end;//TExprStand

 TExprExtSymbol = class(Tl3Expr)
  {* ����� TExprExtSymbol ������������ ��� ����������� ��������� ��������, ������� ��� � �����������
��������� ANSI. � TExprExtSymbol ������������ ��������� Unicode. ������� ��������� ������ �������.

��� �������� ���������� ���������, ���������� ���� ����� ������������ ��������:
esPlus - ���� "+"
esMinus - ���� "-" (�����, � �� �����!)
esLess - ���� "<"
esEqual - ���� "="
esGreater - ���� ">"
esNotEqual - ���� "�� �����"
esMultiply - ���� ��������� � ���� �����
esLessOrEqual - ���� "������ ��� �����"
esGreaterOrEqual - ���� "������ ��� �����"
esApproxEqual - ���� "�������� �����"
esCrossMultiply - ���� ��������� � ���� ������ ������
esDivide - ���� ������� � ���� ����� � ����� ����� � ������.
esTilde - ���� ������
esEquivalent - ���� "������������"
esArrow - ������� ����� ������� (���� "��������� �")
esSlash - ������� � ���� ����� �����
esEllipsis - ����������
esInfinum - �������������
esPartDiff - ���� "�������� �������������" (�������� d) }
 end;//TExprExtSymbol

 TExprPlank = class(TExprExtSymbol)
  {* ����� TExprPlank �������� ����������� TExprExtSymbol. ������������ ��� ����������� "h � ������",
������� ����� ������������ � ��������� ��������. ��������� ��������. }
 end;//TExprPlank

 TExprNabla = class(TExprExtSymbol)
  {* ����� TExprNabla �������� ����������� TExprExtSymbol. ������������ ��� ����������� ������� "�����".
����� ������ ���������� � ��������� Unicode, ������� ��� ����������� ������������ ��������� ���������
������, ��������� �� 180 ��������. }
 end;//TExprNabla

 TExprLambda = class(TExprExtSymbol)
  {* ����� TExprLambda �������� ����������� TExprExtSymbol. ������������ ��� ����������� "������ � ������",
������� ����� ������������ � ��������� ��������. ����� ������ ���������� � ������ Unicode, �������
����� � ������ ��������������� �������. }
 end;//TExprLambda

 TExprComma = class(TExprExtSymbol)
  {* ����� TExprComma �������� ����������� TExprExtSymbol. ������������ ��� ����������� �������.
�������������� ������� NeedBrackets (����� ���������, ���������� �������, ����������� ��� �������������
� ������). }
 end;//TExprComma

 TExprSign = class(TExprExtSymbol)
  {* ����� TExprSign �������� ����������� TExprExtSymbol. ������������ ��� ����������� ��������� ��������,
� ��� ����� � ���, ������� ��� � ��������� Unicode. ����������� ����� �������� ���������� �� ���������
���� ���������� ����������� ���������, ��������� �������� �������.

��� �������������� ���������� ��������� ���� ��� ������� �������� (��������, "+", "-" � �.�.)
������������� ������������ ������� TExprSign, � �� TExprExtSymbol ��� TExprSimple. ������� ��� � ���,
��� TExprSign �������������� ������� NeedBrackets, ������� �������� ��������� ���������� ������.

��� ����������� �������� ���������� ��������� ���������:
esMuchLess - ���� "����� ������" (<<)
esMuchGreater - ���� "����� ������" (>>)
esApproxLess - ���� "������ ��� �������" (���� "������" � ������� ��� ���)
esApproxGreater - ���� "������ ��� �������" (���� "������" � ������� ��� ���)
esPlusMinus - ���� "����-�����"
esMinusPlus - ���� "�����-����"
esAlmostEqual - ���� "����� ��� �������" (���� ��������� � ������� ��� ���)
esParallel - ���� "�����������" (��� ������������ �����)
esPerpendicular - ���� "���������������" (�������������� ����� ����� � ������������ ����������)
esAngle - ���� ���� }
 end;//TExprSign

 TExprChain = class(TExprParent)
  {* ����� TExprChain �������� ����������� TExprParent. ���� ����� ������ ��� ����������� ������� ���������.
������ � ������� ��������� Son, ����� Son.Next, ����� - Son.Next.Next � ��� �����, ���� �� �����
��������� ����� �������. }
 end;//TExprChain

 TExprBigParent = class(TExprParent)
  {* ����� TExprBigParent �������� ����������� ������ TExprParent. � �� ��������� ������ �� ��� ����
�������� ���� - �������� Daughter. ���� ����� �������� ������� ��� ���������� ���������, � �������
���� ��� ��������� �����. �������� ������ ��������� ����� ������� ������� �����, � ������� ���� ��
�������� ��������� ���������� ���������, � ������ - �����������. }
 end;//TExprBigParent

 TExprLim = class(TExprParent)
  {* ����� TExprLim �������� ����������� TExprParent. ���� ����� ��������� ���� ������� (lim), � ��� ��� -
���������, �� ������� ��������� Son. ����� ���������� ��� ����������� ������������� � TExprCommonFunc:
TExprCommonFunc.Son ��������� �� ��������� TExprLim, � TExprCommonFunc.Daughter - �� ���������, ���
�������� ����������� ������. }
 end;//TExprLim

 TExprTwinParent = class(TExprParent)
  {* ����� TExprTwinParent �������� ����������� ������ TExprParent. � �� ��������� ��������� �� ���
�������� ����-��������. �������� ���������, ��� �������� ����� ������������ ����� �����, ��������
��������������� ���������. Son ��������� �� �� ���������, �������� ����������� �������, � Twin1 �
Twin2 - �� ������� � ������ �������. }
 end;//TExprTwinParent

 TExprIndex = class(TExprTwinParent)
  {* ����� TExprIndex �������� ����������� TExprTwinParent. ������������ ��� ����������� ��������� � �������
��� ������ ��������. Son ��������� �� ���������, �������� ����������� �������, Twin1 - ������ ������,
Twin2 - ������� ������. Twin1 ��� Twin2 ����� ���� ����� nil - � ���� ������ ��������� ����������
������ ���� ������. ������� ������ ����� ������������ ��� ���������� �������. }
 end;//TExprIndex

 TExprGroupOp = class(TExprTwinParent)
  {* ����� TExprGroupOp �������� ����������� ������ TExprTwinParent. ��� ������� ����� ��� ���� ���������
���� ����� ��� ���������. ��� ��� ��������� ��������������� �������� ���������: Son ��������� ��
���������, ������� ����� ����� ����� ��� ���������, Twin1 - ������� ��� ������, Twin2 - ��� ���.
Twin1 � Twin2 ����� ���� ����� nil ������������ ��� �� ������. � ���� ������ ��� ������ �/��� ���
��� ������ �� �������. }
 end;//TExprGroupOp

 TExprIntegral = class(TExprGroupOp)
  {* ����� TExprIntegral �������� ����������� TExprGroupOp. ��������� ����������� ��� ������������
��������. �������� ������������ Mult ����� ��������� ���������. ���� Mult<=0, �������� ������
��������� ������������� ��������� (��� ������� ���������, ����������, ��� ���� ������ ���������). }
 end;//TExprIntegral

 TExprSumma = class(TExprGroupOp)
  {* ����� TExprSumma �������� ����������� TExprGroupOp. ��������� ����� (� ������� ��������� ����� �����). }
 end;//TExprSumma

 TExprProd = class(TExprGroupOp)
  {* ����� TExprProd �������� ����������� TExprGroupOp. ��������� ������������ (� ������� ��������� �����
��). }
 end;//TExprProd

 TExprCirc = class(TExprGroupOp)
  {* ����� TExprCirc �������� ����������� TExprGroupOp. ��������� ���������� (�������� � ��������). }
 end;//TExprCirc

 TExprBracketed = class(TExprChain)
  {* ����� TExprBracketed �������� ����������� TExprChain. �� ������� ������� ���������, ����������� �
������. �������� �������, ����������, �������� � ������ ������ (�������� ����������� ebXXXX).
������ ����� ���� ��������� (��������, ����������� ������ �������, � ����������� - ����������).
�������� ����� �������, ����� ������ ����� ������ � ����� ������� ���������. ��������� �����������
� ������ ������ � ��� ������, ���� ������� IsBracketed ���������� True. }
 end;//TExprBracketed

 TExprRatio = class(TExprBigParent)
  {* ����� TExprRatio �������� ����������� ������ TExprBigParent. ��������� ������� �����. Son ��������� ��
���������, Daughter - �� �����������. }
 end;//TExprRatio

 TExprRoot = class(TExprBigParent)
  {* ����� TExprRoot �������� ����������� ������ TExprBigParent. ��������� ���������� �����. Son ���������
�� ����������� ���������, Daughter - �� ���������� ������� �����. ��� Daughter ����������� ��������
nil. � ���� ������ ���������� ������� ����� ������ �� �������� (���������� ������). }
 end;//TExprRoot

 TExprAtValue = class(TExprBigParent)
  {* ����� TExprAtValue �������� ����������� ������ TExprBigParent. ��������� "�������� ��� �������".
������������ ��� ��������� �������: ����� ���������, �� ������� ��������� Son, �������� ������������
�����, � ������ �� �� ����� ������� ���������, �� ������� ��������� Daughter. }
 end;//TExprAtValue

 TExprCommonFunc = class(TExprBigParent)
  {* ����� TExprCommonFunc �������� ����������� ������ TExprBigParent. �� ��������� "�����" �������,
� �������� "�����" ������� ����� �������������� ����� ���������. Son ��������� �� "���" �������,
Daughter - �� � ��������. }
 end;//TExprCommonFunc

 TExprFunc = class(TExprCommonFunc)
  {* ����� TExprFunc �������� ����������� TExprCommonFunc. �� ��������� ������������ �������, ��� �������
�������� ������� ����������� ����. ����������� ��� ������ ����� ������� ���� ��� ����������� �����
�������. ���� ��� ����� ����� 1 ������, �� ������������ ����� TExprVar, ���� ��� ������� - �����
TExprFuncName. � ������ ������ ��� ������� ������� ��������, � �������� ������ ����������� � ������,
��� ��� � ������ TExprVar ������� ArgNeedBrackets �� �������������� ��������������� �������. �� ������
������ ��� ������� ������� ������ �������, � �������� ����������� � ������ ���� ��� �������������. }
 end;//TExprFunc

 TExprRound = class(TExprBracketed)
  {* ����� TExprRound �������� ����������� TExprBracketed. �� �������������� ������� FTType. ���� �����
������������ ����������� ExprMake ��� ���������� ������ ������. }
 end;//TExprRound

 TExprArgument = class(TExprBracketed)
  {* ����� TExprArgument �������� ����������� TExprBracketed. � �� ������������ ����������� ����� �������,
����� ������ ������ ���� ��������. ����� ����, �������������� ������� IsBracketed ����� �������, �����
��� ���������� True ������ � ��� ������, ���� ���� �� ���� �� ����� �������, �� ������� ���������
Son, ��������� � ������� (�.�. ��� ������� NeedBrackets ���������� True). � ������� ���������,
��������, ����, ����������� ����� "+" � "-". ����� �������, ���� ������� ��������� ������������ �����
����� ���������� ���������, ��� ����������� � ������, ���� ��� ������������ ���������� ���������� -
�� �����������. ��� ��������� � ���, ��� ������������ ��������� ������� (��������, cos 2x, �� cos(x+y)).
���� �� ����� ������������ ��� ���������� ��������� ����������: ���� � ������� ��������� ���� ��������
�������� ��� ���������, �� ����������� � ������, ���� ���, �� �� �����������.

� ����� ����� ��������� ������� SetBrackets, ������� ���������� �������� ������ ���������� �� ����,
���� �� � ������� ����������� � ������� ����.

���� ����� TExprArgument ������������ ��� �������� ������� (� ���� ������ ��� ������������ ����
�������� ����������� ������ TExprCommonFunc), �� ���������� �������������� ������� �������������
������ ��� �����������, ����� �� ������ ���������.

��� ���������� ������ ������� ��� ����������� ��������� ������ ������� ��������, ����� �� ���������
�����-�� ��� ����� � ������ ��� ���. � ���� ������ ����� ������������ ������ TExprBracketed �
TExprChain. �� ��� ������������������ ���������� ������ (��������, � ������� ���������� ExprMake)
������ ����� ����� ���� ����� ��������. }
 end;//TExprArgument

 TExprBase = class(TExprBracketed)
  {* ����� TExprBase �������� ����������� TExprBracketed. �� ���������� ���������, ����������� � �������
������, ���� �������, �� ������� ��������� Son, �������� ����� ������ ����. � ��������� ������
��������� � ������ �� �����������. ��� ��������� � ���, ��� ������ ������������ ���� ��� ����������
� ������� (��������, x^2, �� (2x)^2).

����� TExprBase, ��� � TExprArgument, ������������ ������ ��� ������������� ���������� ������. }
 end;//TExprBase

 TExprContainer = class
 end;//TExprContainer

implementation

uses
  l3Drawer
  ;

// start class Tl3Expr

procedure Tl3Expr.pm_SetNext(aValue: Tl3Expr);
//#UC START# *473DB85F009F_47398921031Eset_var*
//#UC END# *473DB85F009F_47398921031Eset_var*
begin
//#UC START# *473DB85F009F_47398921031Eset_impl*
 f_Next := aValue;
//#UC END# *473DB85F009F_47398921031Eset_impl*
end;//Tl3Expr.pm_SetNext

function Tl3Expr.pm_GetColor: Tl3Color;
//#UC START# *473DB86E0051_47398921031Eget_var*
//#UC END# *473DB86E0051_47398921031Eget_var*
begin
//#UC START# *473DB86E0051_47398921031Eget_impl*
 assert(false, 'Tl3Expr.pm_GetColor not implemented');
//#UC END# *473DB86E0051_47398921031Eget_impl*
end;//Tl3Expr.pm_GetColor

procedure Tl3Expr.pm_SetColor(aValue: Tl3Color);
//#UC START# *473DB86E0051_47398921031Eset_var*
//#UC END# *473DB86E0051_47398921031Eset_var*
begin
//#UC START# *473DB86E0051_47398921031Eset_impl*
 assert(false, 'Tl3Expr.pm_SetColor not implemented');
//#UC END# *473DB86E0051_47398921031Eset_impl*
end;//Tl3Expr.pm_SetColor

procedure Tl3Expr.pm_SetFont(aValue: TFont);
//#UC START# *473DB87F03DA_47398921031Eset_var*
//#UC END# *473DB87F03DA_47398921031Eset_var*
begin
//#UC START# *473DB87F03DA_47398921031Eset_impl*
 f_Font := aValue;
//#UC END# *473DB87F03DA_47398921031Eset_impl*
end;//Tl3Expr.pm_SetFont

procedure Tl3Expr.pm_SetCanvas(aValue: TCanvas);
//#UC START# *473DB88D0113_47398921031Eset_var*
//#UC END# *473DB88D0113_47398921031Eset_var*
begin
//#UC START# *473DB88D0113_47398921031Eset_impl*
 f_Canvas := aValue;
//#UC END# *473DB88D0113_47398921031Eset_impl*
end;//Tl3Expr.pm_SetCanvas

function Tl3Expr.pm_GetWidth: Integer;
//#UC START# *473DB89D02ED_47398921031Eget_var*
//#UC END# *473DB89D02ED_47398921031Eget_var*
begin
//#UC START# *473DB89D02ED_47398921031Eget_impl*
 assert(false, 'Tl3Expr.pm_GetWidth not implemented');
//#UC END# *473DB89D02ED_47398921031Eget_impl*
end;//Tl3Expr.pm_GetWidth

function Tl3Expr.pm_GetHeight: Integer;
//#UC START# *473DB8B30353_47398921031Eget_var*
//#UC END# *473DB8B30353_47398921031Eget_var*
begin
//#UC START# *473DB8B30353_47398921031Eget_impl*
 assert(false, 'Tl3Expr.pm_GetHeight not implemented');
//#UC END# *473DB8B30353_47398921031Eget_impl*
end;//Tl3Expr.pm_GetHeight

function Tl3Expr.pm_GetMidLineUp: Integer;
//#UC START# *473DB8FE02D9_47398921031Eget_var*
//#UC END# *473DB8FE02D9_47398921031Eget_var*
begin
//#UC START# *473DB8FE02D9_47398921031Eget_impl*
 assert(false, 'Tl3Expr.pm_GetMidLineUp not implemented');
//#UC END# *473DB8FE02D9_47398921031Eget_impl*
end;//Tl3Expr.pm_GetMidLineUp

function Tl3Expr.pm_GetMidLineDn: Integer;
//#UC START# *473DB90D0135_47398921031Eget_var*
//#UC END# *473DB90D0135_47398921031Eget_var*
begin
//#UC START# *473DB90D0135_47398921031Eget_impl*
 assert(false, 'Tl3Expr.pm_GetMidLineDn not implemented');
//#UC END# *473DB90D0135_47398921031Eget_impl*
end;//Tl3Expr.pm_GetMidLineDn

function Tl3Expr.pm_GetPowerXPos: Integer;
//#UC START# *473DB91702CA_47398921031Eget_var*
//#UC END# *473DB91702CA_47398921031Eget_var*
begin
//#UC START# *473DB91702CA_47398921031Eget_impl*
 assert(false, 'Tl3Expr.pm_GetPowerXPos not implemented');
//#UC END# *473DB91702CA_47398921031Eget_impl*
end;//Tl3Expr.pm_GetPowerXPos

function Tl3Expr.pm_GetPowerYPos: Integer;
//#UC START# *473DB92400E8_47398921031Eget_var*
//#UC END# *473DB92400E8_47398921031Eget_var*
begin
//#UC START# *473DB92400E8_47398921031Eget_impl*
 assert(false, 'Tl3Expr.pm_GetPowerYPos not implemented');
//#UC END# *473DB92400E8_47398921031Eget_impl*
end;//Tl3Expr.pm_GetPowerYPos

function Tl3Expr.pm_GetIndexXPos: Integer;
//#UC START# *473DB92F0134_47398921031Eget_var*
//#UC END# *473DB92F0134_47398921031Eget_var*
begin
//#UC START# *473DB92F0134_47398921031Eget_impl*
 assert(false, 'Tl3Expr.pm_GetIndexXPos not implemented');
//#UC END# *473DB92F0134_47398921031Eget_impl*
end;//Tl3Expr.pm_GetIndexXPos

function Tl3Expr.pm_GetIndexYPos: Integer;
//#UC START# *473DB93C01DD_47398921031Eget_var*
//#UC END# *473DB93C01DD_47398921031Eget_var*
begin
//#UC START# *473DB93C01DD_47398921031Eget_impl*
 assert(false, 'Tl3Expr.pm_GetIndexYPos not implemented');
//#UC END# *473DB93C01DD_47398921031Eget_impl*
end;//Tl3Expr.pm_GetIndexYPos

function Tl3Expr.pm_GetCapDXLeft: Integer;
//#UC START# *473DB94602C8_47398921031Eget_var*
//#UC END# *473DB94602C8_47398921031Eget_var*
begin
//#UC START# *473DB94602C8_47398921031Eget_impl*
 assert(false, 'Tl3Expr.pm_GetCapDXLeft not implemented');
//#UC END# *473DB94602C8_47398921031Eget_impl*
end;//Tl3Expr.pm_GetCapDXLeft

function Tl3Expr.pm_GetCapDXRight: Integer;
//#UC START# *473DB9560299_47398921031Eget_var*
//#UC END# *473DB9560299_47398921031Eget_var*
begin
//#UC START# *473DB9560299_47398921031Eget_impl*
 assert(false, 'Tl3Expr.pm_GetCapDXRight not implemented');
//#UC END# *473DB9560299_47398921031Eget_impl*
end;//Tl3Expr.pm_GetCapDXRight

function Tl3Expr.pm_GetCapDY: Integer;
//#UC START# *473DB97D0187_47398921031Eget_var*
//#UC END# *473DB97D0187_47398921031Eget_var*
begin
//#UC START# *473DB97D0187_47398921031Eget_impl*
 assert(false, 'Tl3Expr.pm_GetCapDY not implemented');
//#UC END# *473DB97D0187_47398921031Eget_impl*
end;//Tl3Expr.pm_GetCapDY

function Tl3Expr.FTType: Integer;
//#UC START# *473DB9890039_47398921031E_var*
//#UC END# *473DB9890039_47398921031E_var*
begin
//#UC START# *473DB9890039_47398921031E_impl*
 assert(false, 'Tl3Expr.FTType not implemented');
//#UC END# *473DB9890039_47398921031E_impl*
end;//Tl3Expr.FTType

constructor Tl3Expr.Create;
//#UC START# *473DB99802C6_47398921031E_var*
//#UC END# *473DB99802C6_47398921031E_var*
begin
//#UC START# *473DB99802C6_47398921031E_impl*
 assert(false, 'Tl3Expr.Create not implemented');
//#UC END# *473DB99802C6_47398921031E_impl*
end;//Tl3Expr.Create

procedure Tl3Expr.AddNext(aValue: Tl3Expr);
//#UC START# *473DB9A80279_47398921031E_var*
//#UC END# *473DB9A80279_47398921031E_var*
begin
//#UC START# *473DB9A80279_47398921031E_impl*
 assert(false, 'Tl3Expr.AddNext not implemented');
//#UC END# *473DB9A80279_47398921031E_impl*
end;//Tl3Expr.AddNext

function Tl3Expr.CutOff: Tl3Expr;
//#UC START# *473DB9B700A4_47398921031E_var*
//#UC END# *473DB9B700A4_47398921031E_var*
begin
//#UC START# *473DB9B700A4_47398921031E_impl*
 assert(false, 'Tl3Expr.CutOff not implemented');
//#UC END# *473DB9B700A4_47398921031E_impl*
end;//Tl3Expr.CutOff

procedure Tl3Expr.Draw(X: Integer;
  Y: Integer;
  HorAlign: TExprHorAlign;
  VertAlign: TExprVertAlign);
//#UC START# *473DBBB100F1_47398921031E_var*
//#UC END# *473DBBB100F1_47398921031E_var*
begin
//#UC START# *473DBBB100F1_47398921031E_impl*
 assert(false, 'Tl3Expr.Draw not implemented');
//#UC END# *473DBBB100F1_47398921031E_impl*
end;//Tl3Expr.Draw
end.