unit ExprDraw;

{ $Id: ExprDraw.pas,v 1.45 2015/10/14 11:55:45 lulin Exp $ }

// $Log: ExprDraw.pas,v $
// Revision 1.45  2015/10/14 11:55:45  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=598136171&focusedCommentId=609593801#comment-609593801
//
// Revision 1.44  2015/10/14 11:52:12  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=598136171&focusedCommentId=609593801#comment-609593801
//
// Revision 1.43  2014/07/17 12:51:36  dinishev
// {Requestlink:554581587}. Убрал свои запилы по передаче цвета фона. Просто отрисовываем без фона.
//
// Revision 1.42  2014/07/10 10:22:07  dinishev
// {Requestlink:553427148}. Пользуемся тем, что в момент рендеринга формулы фон нам известен. Ибо код выставления альфы смущает.
//
// Revision 1.41  2013/04/11 14:53:56  lulin
// - портируем.
//
// Revision 1.40  2010/04/02 14:52:49  lulin
// {RequestLink:100008248}.
//
// Revision 1.39  2010/03/31 13:57:05  lulin
// {RequestLink:200084559}.
// - добавлена поддержка оператора "строка".
//
// Revision 1.38  2010/03/26 15:37:46  lulin
// {RequestLink:199591594}.
// - оптимизируем мальца.
//
// Revision 1.37  2010/03/26 15:30:37  lulin
// {RequestLink:199591594}.
//
// Revision 1.36  2008/07/15 20:49:08  lulin
// - при рисовании формулы учитываем выделение.
//
// Revision 1.35  2008/07/15 20:23:25  lulin
// - при рисовании формулы учитываем выделение.
//
// Revision 1.34  2008/07/15 18:32:31  lulin
// - рефакторинг отрисовки формул - код обобщён.
//
// Revision 1.33  2008/07/15 16:53:41  lulin
// - продолжаем бороться с <K>: 102957837.
//
// Revision 1.32  2008/06/28 19:01:34  lulin
// - чистка.
//
// Revision 1.31  2008/06/28 18:59:37  lulin
// - убрано дублирование констант.
//
// Revision 1.30  2008/06/28 18:24:04  lulin
// - чистка.
//
// Revision 1.29  2008/06/28 18:10:30  lulin
// - используем массив преобразований.
//
// Revision 1.28  2008/06/28 15:50:36  lulin
// - причёсываем код.
// - добавлены оборотные операторы вкючения.
//
// Revision 1.27  2008/06/28 13:49:34  lulin
// - причёсываем код.
//
// Revision 1.26  2008/06/27 20:17:08  lulin
// - добавлена Юникодная строка.
//
// Revision 1.25  2008/06/27 20:02:59  lulin
// - добавлен диаметр и диакритические " и '.
// - добавлена возможность явно указать Юникод - #@.
//
// Revision 1.24  2008/06/27 15:58:11  lulin
// - <K>: 95489947.
//
// Revision 1.23  2008/06/27 14:07:20  lulin
// - <K>: 95489730.
//
// Revision 1.22  2008/01/18 10:31:34  fireton
// - мелкая правка
//
// Revision 1.21  2007/11/28 17:10:06  lulin
// - боремся с канвой, неподдерживающей рисование.
//
// Revision 1.20  2007/11/19 07:46:23  lulin
// - используем правильную процедуру освобождения объектов.
//
// Revision 1.19  2007/11/16 13:30:55  fireton
// + функция Circle() - диакретический кружочек
//
// Revision 1.18  2007/11/14 13:15:54  lulin
// - для Немезиса выводим формулы напрямую, а не через картинку.
//
// Revision 1.17  2007/11/12 17:29:52  lulin
// - с битовой маски переходим на множество.
//
// Revision 1.16  2007/11/12 17:00:52  lulin
// - попытка рисования формул без кеширования (пока безуспешно).
//
// Revision 1.15  2007/11/09 08:52:46  fireton
// - bug fix: отрисовка квадратных скобок
//
// Revision 1.14  2007/11/06 09:34:28  fireton
// - отрисовка формул с применением GDI+
//
// Revision 1.13  2007/10/24 14:40:33  fireton
// - bug fix: починка отрисовки корней
//
// Revision 1.12  2007/10/22 10:11:16  lulin
// - изменил имя базового класса.
//
// Revision 1.11  2007/10/16 10:18:09  lulin
// - избавляемся от ненужных динамических методов.
//
// Revision 1.10  2007/10/16 10:15:07  lulin
// - избавляемся от ненужных плавающих операций.
//
// Revision 1.9  2007/10/11 13:54:08  fireton
// - делаем отступы при отрисовке формул (нивелируем разницу между рассчитаным и реальным размерами)
//
// Revision 1.8  2007/08/14 17:14:27  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.7  2007/07/23 05:20:47  oman
// warning fix
//
// Revision 1.6  2007/07/12 08:26:17  fireton
// - предотвращение зацикливания при рисовании корня
//
// Revision 1.5  2007/07/09 11:39:40  fireton
// - отрисовка корня и фигурных скобок (исправление)
//
// Revision 1.4  2007/07/04 11:41:12  fireton
// - отрисовка скобок символами Unicode
//
// Revision 1.3  2007/07/03 14:05:22  fireton
// - отрисовка интеграла, суммы, произведения и хитрого интеграла с кружочком символами Unicode
//
// Revision 1.2  2002/12/15 11:56:56  law
// no message
//

{$Include l3Define.inc }

interface

uses
  Windows,
  Classes,
  SysUtils,
  Graphics,
  Math,

  l3Interfaces,
  l3Base,
  l3InternalInterfaces
  ;

type
  TMyOp = (
   opMyNULL,
   opRoundPlus,
   opRoundMul,
   opIn,
   opNotIn,
   opCopy,
   opRight,
   opInclude,
   opNotInclude,
   opIncludeOrEq,
   opDiametr,
   opInvertInclude,
   opInvertIncludeOrEq,
   opString,
   opJoin, // объединение %U
   opIntersest, // пересечние %R
   opAlmostEqual2, // ==~ - знак равенства с тильдой сверху
   opConsequence, // <==>
   opConsequenceLeft, // <==
   opConsequenceRight, // ==>
   opOR, // %V
   opAND // %A
  );//TMyOp

  TOp = (                                    
   opNULL,
   opNotEqual,       // <> - не равно                         1
   opGreaterOrEqual, // >= - больше или равно                 2
   opLessOrEqual,    // <= - меньше или равно                 3
   opMuchGreater,    // >> - много больше                     4
   opMuchLess,       // << - много меньше                     5
   opArrow,          // -> - стрелка (стремится к пределу)    6
   opApproxEqual,    // ~~ - примерно равно                   7
   opPlusMinus,      // +- - плюс-минус                       8
   opMinusPlus,      // -+ - минус-плюс                       9
   opEquivalent,     // == - тождественно                     10
   opDivide,         // /+ - знак "минус с точкой снизу и точкой сверху" 11
   opCrossMultiply,  // *+ - косой крест                      12
   opEllipsis,       // ... - эллипсис                        13
   opApproxGreater,  // >~ - больше или порядка               14
   opApproxLess,     // <~ - меньше или порядка               15
   opSlash,          // // - делить символом "/", без дроби   16
   opStrictBracket,  // !( - обязательная скобка (закрывается обычной) 17
   opMultiply,       // *. - умножение точкой                 18
   opOrderMultiply,  // ** - умножение без перестановки множителей 19
   opAlmostEqual     // =~ - знак равенства с тильдой сверху  20
  );

const
  MyOpCode : array [TMyOp] of Integer = (
   0,     // opMyNULL
   $c5,   // opRoundPlus
   $c4,   // opRoundMul
   $ce,   // opIn
   $cf,   // opNotIn
   $A9,   // opCopy
   $AE,   // opRight
   $cc,   // opInclude
   $cb,   // opNotInclude
   $cd,   // opIncludeOrEq
   $c6,   // opDiametr
   $c9,   // opInvertInclude
   $ca,   // opInvertIncludeOrEq
   0,     // opString
   $c7,   // opJoin, // объединение %U
   $c8,   // opIntersest, // пересечние %R
   $40,   // opAlmostEqual2, // ==~ - знак равенства с тильдой сверху
   $DB,   // opConsequence, // <==>
   $DC,   // opConsequenceLeft,// <==
   $DE,   // opConsequenceRight// ==>
   $DA,   // opOr, // %V
   $D9    // opAND, // %A
  );//MyOpCode

const
         efLeft=1;
         efRight=2;
         efNegative=4;
         efRoundBrackets=24;
         efBrackets=16;
         efNumber=32;

const
// Ненастоящие коды символов:         
         esMuchLess = 1;
         esMuchGreater = 2;
         esApproxLess = 3;
         esApproxGreater = 4;
         esPlusMinus = 5;
         esMinusPlus = 6;
         esAlmostEqual = 7;
         esParallel = 10;
         esPerpendicular = 11;
         esAngle = 12;
const
 // Настоящие коды символов:
         esPlus=43;
         esMinus=8722;
         esLess=60;
         esEqual=61;
         esGreater=62;
         esNotEqual=8800;
         esMultiply=183;
         esLessOrEqual=8804;
         esGreaterOrEqual=8805;
         esApproxEqual=8776;
         esCrossMultiply=215;
         esDivide=247;
         esTilde=126;
         esEquivalent=8801;
         esArrow=8594;
         esSlash=47;

         esEllipsis=8230;
         esInfinum=8734;
         esPartDiff=8706;

type
  Tl3ExprMetric = (
         tcWidth,
         tcHeight,
         tcPowerXPos,
         tcPowerYPos,
         tcIndexXPos,
         tcIndexYPos,
         tcCapDX,
         tcCapDY,
         tcMidLineUp,
         tcMidlineDn,
         tcSymbolWidth,
         tcSymbolHeight
         );
  Tl3ExprMetrics = set of Tl3ExprMetric;
         
const
  tcCellSize = tcSymbolWidth;
  tcAll = [Low(Tl3ExprMetric) .. High(Tl3ExprMetric)];

    type TExprOrigin=(eoTop,eoBottom);

         TExprHorAlign=(ehLeft,ehCenter,ehRight);
         TExprVertAlign=(evTop,evCenter,evBottom);

         TExprBracket=(ebNone,ebRound,ebSquare,ebFigure,ebModule);

         TExprCapStyle=(ecPoints, ecVector, ecCap, ecTilde, ecLine, ecCircle,
                        ecRDQ, ecLDQ, ecDQ,
                        ecRSQ, ecLSQ, ecSQ);

         Tl3Expr=class(Tl3Base)
                     private
                      FParent:Tl3Expr;
                      FNext:Tl3Expr;
                      FColor:TColor;
                      FFont:TFont;
                      FWidth,FHeight,FMidLineUp,FMidLineDn,FPowerXPos,FPowerYPos,FIndexXPos,FIndexYPos,FCapDY,FCapDXLeft,FCapDXRight:Integer;
                      FCanvas:TCanvas;
                      ToChange:Tl3ExprMetrics;
                      function DrawSymbolOnCanvas(
                       aChar: PWideChar;         // символ Unicode, который рисуем
                       aHeight, aWidth: Integer; // высота и ширина символа в пикселях, если ширина=0, то рисуется пропорционально высоте
                       aX, aY: Integer;          // позиция отрисовки
                       aGrowCoeff: Double = 1.0;  // коэффициент "роста" (реальная высота будет aHeight*aGrowCoeff, ширина - аналогично)
                       aVShiftCoeff: Double = 0.0; // смещение по вертикали (в долях от высоты символа, с учетом aGrowCoeff)
                       aHShiftCoeff: Double = 0.0  // смещение по горизонтали
                      ): TSize;
                      procedure SetNext(Value:Tl3Expr);
                      function GetColor:TColor;
                      procedure SetLineWidth;
                      procedure SetFont(NewFont:TFont);
                      procedure SetCanvas(Value:TCanvas);
                      procedure SetColor(Value:TColor);
                      procedure FontNotify(Sender:TObject);
                      function GetWidth:Integer;
                      function GetHeight:Integer;
                      function GetMidLineUp:Integer;
                      function GetMidLineDn:Integer;
                      function GetPowerXPos:Integer;
                      function GetPowerYPos:Integer;
                      function GetIndexXPos:Integer;
                      function GetIndexYPos:Integer;
                      function GetCapDXLeft:Integer;
                      function GetCapDXRight:Integer;
                      function GetCapDY:Integer;
                      procedure SetParent(Value:Tl3Expr);
                     protected
                      WX,WY:Integer;
                      RWX,RWY:Extended;
                      property Parent:Tl3Expr read FParent write SetParent;
                      procedure DynaSetFont;virtual;
                      procedure DynaSetCanvas;virtual;
                      procedure SetCanvasFont;virtual;
                      procedure SetPenAndBrush;
                      procedure ConvertCoords(var X,Y:Integer;HorAlign:TExprHorAlign;VertAlign:TExprVertAlign);
                      procedure AssignCanvas(Value:TCanvas;EWX,EWY:Integer;ERWX,ERWY:Extended);
                      procedure AssignFont(NewFont:TFont;EWX,EWY:Integer;ERWX,ERWY:Extended);
                      procedure Paint(X,Y:Integer);virtual;
                      function NeedBrackets:Boolean;virtual;
                      function ArgNeedBrackets:Boolean;virtual;
                      function CalcWidth:Integer;virtual;
                      function CalcHeight:Integer;virtual;
                      function CalcMidLine(Origin:TExprOrigin):Integer;virtual;
                      function CalcPowerXPos:Integer;virtual;
                      function CalcIndexXPos:Integer;virtual;
                      function CalcPowerYPos:Integer;virtual;
                      function CalcIndexYPos:Integer;virtual;
                      function CalcCapDY:Integer;virtual;
                      procedure CalcCapDX(var DLeft,DRight:Integer);virtual;
                      procedure Release;override;
                     public
                      property Next:Tl3Expr read FNext write SetNext;
                      property Color:TColor read GetColor write SetColor;
                      property Font:TFont read FFont write SetFont;
                      property Canvas:TCanvas read FCanvas write SetCanvas;
                      property Width:Integer read GetWidth;
                      property Height:Integer read GetHeight;
                      property MidLineUp:Integer read GetMidLineUp;
                      property MidLineDn:Integer read GetMidLineDn;
                      property PowerXPos:Integer read GetPowerXPos;
                      property PowerYPos:Integer read GetPowerYPos;
                      property IndexXPos:Integer read GetIndexXPos;
                      property IndexYPos:Integer read GetIndexYPos;
                      property CapDXLeft:Integer read GetCapDXLeft;
                      property CapDXRight:Integer read GetCapDXRight;
                      property CapDY:Integer read GetCapDY;
                      function FTType:Integer;virtual;
                      constructor Create; reintroduce;
                      procedure AddNext(aValue    :Tl3Expr);
                      function CutOff:Tl3Expr;
                      procedure Draw(X,Y:Integer;HorAlign:TExprHorAlign;VertAlign:TExprVertAlign);
                    end;

         TExprParent=class(Tl3Expr)
                      private
                       FSon:Tl3Expr;
                       procedure SetSon(Value:Tl3Expr);
                       procedure SetSonFont;virtual;
                       procedure SetSonCanvas;virtual;
                      protected
                       procedure DynaSetFont;override;
                       procedure DynaSetCanvas;override;
                       procedure Release;override;
                      public
                       property Son:Tl3Expr read FSon write SetSon;
                       constructor Create(ASon:Tl3Expr);
                       function CutOffSon:Tl3Expr;
                     end;

         TExprBigParent=class(TExprParent)
                         private
                          FDaughter:Tl3Expr;
                          procedure SetDaughter(Value:Tl3Expr);
                          procedure SetDaughterFont;virtual;
                          procedure SetDaughterCanvas;virtual;
                         protected
                          procedure DynaSetCanvas;override;
                          procedure DynaSetFont;override;
                       procedure Release;override;
                         public
                          property Daughter:Tl3Expr read FDaughter write SetDaughter;
                          constructor Create(ASon,ADaughter:Tl3Expr);
                          function CutOffDaughter:Tl3Expr;
                        end;

         TExprChain=class(TExprParent)
                     private
                      procedure CalcOverAbove(var Over,Above:Integer);
                     protected
                      procedure Paint(X,Y:Integer);override;
                      function CalcCapDY:Integer;override;
                      procedure CalcCapDX(var DLeft,DRight:Integer);override;
                      function CalcMidLine(Origin:TExprOrigin):Integer;override;
                      function CalcWidth:Integer;override;
                      function CalcHeight:Integer;override;
                     public
                      procedure BuildUpChain(Value:Tl3Expr);
                      function FTType:Integer;override;
                    end;

         TExprSimple=class(Tl3Expr)
                      protected
                       S:AnsiString;
                       procedure Paint(X,Y:Integer);override;
                       function CalcWidth:Integer;override;
                       function CalcHeight:Integer;override;
                       function CalcCapDY:Integer;override;
                      public
                       constructor Create(const Expr:AnsiString);
                     end;

         TExprUnicode=class(Tl3Expr)
                      protected
                       S:widestring;
                       procedure Paint(X,Y:Integer);override;
                       function CalcWidth:Integer;override;
                       function CalcHeight:Integer;override;
                       function CalcCapDY:Integer;override;
                      public
                       constructor Create(const Expr:widestring);
                     end;

         TExprVar=class(TExprSimple)
                   protected
                    procedure SetCanvasFont;override;
                    //function CalcCapDY:Integer;override;
                    procedure CalcCapDX(var DLeft,DRight:Integer);override;
                    function CalcPowerXPos:Integer;override;
                    function CalcIndexXPos:Integer;override;
                  end;

         TExprCustomText=class(TExprSimple)
                          protected
                           FFontStyle:TFontStyles;
                           FFontName:AnsiString;
                           procedure SetCanvasFont;override;
                          public
                           constructor Create(Expr:AnsiString;FontStyle:TFontStyles=[fsBold];FontName:AnsiString='Times New Roman');
                         end;

         TExprNumber=class(Tl3Expr)
                      private
                       FNumber:Extended;
                       SM,SE:AnsiString;
                       ExpVal:Boolean;
                       procedure SetNumber(Value:Extended);
                      protected
                       function NumToStr:AnsiString;virtual;
                       function CalcCapDY:Integer;override;
                       procedure Paint(X,Y:Integer);override;
                       function CalcWidth:Integer;override;
                       function CalcHeight:Integer;override;
                       function CalcMidLine(Origin:TExprOrigin):Integer;override;
                      public
                       property Number:Extended read FNumber write SetNumber;
                       constructor Create(A:Extended;ExpForm:Boolean);
                       function FTType:Integer;override;
                     end;

         TExprExpNumber=class(TExprNumber)
                         private
                          FPrecision,FDigits,FMaxDeg:Integer;
                         protected
                          function NumToStr:AnsiString;override;
                         public
                          constructor Create(A:Extended;Precision:Integer=4;Digits:Integer=4;MaxDeg:Integer=2);
                        end;

         TExprRatio=class(TExprBigParent)
                     protected
                      procedure Paint(X,Y:Integer);override;
                      function CalcWidth:Integer;override;
                      function CalcHeight:Integer;override;
                      function CalcMidLine(Origin:TExprOrigin):Integer;override;
                    end;

         TExprRoot=class(TExprBigParent)
                    private
                     procedure SetDaughterFont;override;
                     procedure SetDaughterCanvas;override;
                    protected
                     procedure Paint(X,Y:Integer);override;
                     function CalcWidth:Integer;override;
                     function CalcHeight:Integer;override;
                     function CalcMidLine(Origin:TExprOrigin):Integer;override;
                   end;

         TExprBracketed=class(TExprChain)
                         protected
                          Left,Right:TExprBracket;
                          procedure Paint(X,Y:Integer);override;
                          function IsBracketed:Boolean;virtual;
                          function CalcCapDY:Integer;override;
                          procedure CalcCapDX(var DLeft,DRight:Integer);override;
                          function CalcWidth:Integer;override;
                          function CalcHeight:Integer;override;
                          function CalcMidLine(Origin:TExprOrigin):Integer;override;
                         public
                          constructor Create(ASon:Tl3Expr;LeftBracket,RightBracket:TExprBracket);
                          function FTType:Integer;override;
                          procedure RemoveBrackets;
                        end;

         TExprRound=class(TExprBracketed)
                     public
                      constructor Create(ASon:Tl3Expr);
                      function FTType:Integer;override;
                     end;

         TExprExtSymbol=class(Tl3Expr)
                         public
                          Symbol:Integer;
                         protected
                          procedure Paint(X,Y:Integer);override;
                          function CalcCapDY:Integer;override;
                          procedure CalcCapDX(var DLeft,DRight:Integer);override;
                          function CalcPowerXPos:Integer;override;
                          function CalcWidth:Integer;override;
                          function CalcHeight:Integer;override;
                         public
                          constructor Create(aSymbolCode:Integer);
                        end;

         TExprPlank=class(TExprExtSymbol)
                     protected
                      procedure SetCanvasFont;override;
                      function CalcCapDY:Integer;override;
                      procedure CalcCapDX(var DLeft,DRight:Integer);override;
                     public
                      constructor Create;
                     end;

         TExprSign=class(TExprExtSymbol)
                    protected
                     function NeedBrackets:Boolean;override;
                     procedure Paint(X,Y:Integer);override;
                     function CalcCapDY:Integer;override;
                     function CalcWidth:Integer;override;
                    public
                     function FTType:Integer;override;
                   end;
                   
         TExprSymbolSign = class(TExprSign)
                    protected
                     procedure SetCanvasFont;override;
                     function  SymbolStr: AnsiString;
                     procedure Paint(X,Y:Integer);override;
                     function CalcWidth:Integer;override;
         end;//TExprSymbolSign

         TExprTwinParent=class(TExprParent)
                          private
                           Twins:array[1..2] of Tl3Expr;
                           procedure SetTwins(Index:Integer;Value:Tl3Expr);
                          protected
                           procedure DynaSetFont;override;
                           procedure DynaSetCanvas;override;
                       procedure Release;override;
                          public
                           property Twin1:Tl3Expr index 1 read Twins[1] write SetTwins;
                           property Twin2:Tl3Expr index 2 read Twins[2] write SetTwins;
                           constructor Create(ASon,FirstTwin,SecondTwin:Tl3Expr);
                         end;

         TExprIndex=class(TExprTwinParent)
                     protected
                      function CalcCapDY:Integer;override;
                      procedure Paint(X,Y:Integer);override;
                      function CalcWidth:Integer;override;
                      function CalcHeight:Integer;override;
                      function CalcMidLine(Origin:TExprOrigin):Integer;override;
                     public
                      function ArgNeedBrackets:Boolean;override;
                      function FTType:Integer;override;
                    end;

         TExprArgument=class(TExprBracketed)
                        protected
                         ForcedBrackets:Boolean;
                         function IsBracketed:Boolean;override;
                        public
                         constructor Create(ASon:Tl3Expr);
                         procedure SetBrackets;
                       end;

         TExprCommonFunc=class(TExprBigParent)
                          protected
                           procedure Paint(X,Y:Integer);override;
                           function CalcWidth:Integer;override;
                           function CalcHeight:Integer;override;
                           function CalcMidLine(Origin:TExprOrigin):Integer;override;
                          public
                           function ArgumentNeedBrackets:Boolean;
                           function FTType:Integer;override;
                         end;

         TExprFuncName=class(TExprSimple)
                        protected
                         function ArgNeedBrackets:Boolean;override;
                       end;

         TExprFunc=class(TExprCommonFunc)
                    public
                     constructor Create(FuncName:AnsiString;ADaughter:Tl3Expr);
                   end;

         TExprBase=class(TExprBracketed)
                    protected
                     function IsBracketed:Boolean;override;
                    public
                     constructor Create(ASon:Tl3Expr);
                   end;

         TExprComma=class(TExprExtSymbol)
                     protected
                      function NeedBrackets:Boolean;override;
                      function CalcCapDY:Integer;override;
                     public
                      constructor Create;
                    end;

         TExprLim=class(TExprParent)
                   protected
                    procedure SetSonFont;override;
                    procedure SetSonCanvas;override;
                    procedure Paint(X,Y:Integer);override;
                    function ArgNeedBrackets:Boolean;override;
                    function CalcWidth:Integer;override;
                    function CalcHeight:Integer;override;
                    function CalcMidLine(Origin:TExprOrigin):Integer;override;
                  end;

         TExprSpace=class(Tl3Expr)
                     private
                      N:Integer;
                     protected
                      function CalcWidth:Integer;override;
                     public
                      constructor Create(Space:Integer);
                     end;

         TExprStrokes=class(Tl3Expr)
                       private
                        N:Integer;
                       protected
                        procedure Paint(X,Y:Integer);override;
                        function CalcWidth:Integer;override;
                        function CalcHeight:Integer;override;
                       public
                        constructor Create(Strokes:Integer);
                      end;

         TExprAtValue=class(TExprBigParent)
                       private
                        procedure SetDaughterFont;override;
                        procedure SetDaughterCanvas;override;
                       protected
                        procedure Paint(X,Y:Integer);override;
                        function CalcWidth:Integer;override;
                        function CalcHeight:Integer;override;
                        function CalcMidLine(Origin:TExprOrigin):Integer;override;
                       public
                        function FTType:Integer;override;
                      end;

         TExprCap=class(TExprParent)
                   private
                    Style:TExprCapStyle;
                    N:Integer;
                   protected
                    function CapWidth:Integer;
                    function CapHeight:Integer;
                    function SelfHeight:Integer;
                    function CalcPowerXPos:Integer;override;
                    function CalcPowerYPos:Integer;override;
                    function CalcIndexXPos:Integer;override;
                    function CalcCapDY:Integer;override;
                    procedure Paint(X,Y:Integer);override;
                    function CalcWidth:Integer;override;
                    function CalcHeight:Integer;override;
                    function CalcMidLine(Origin:TExprOrigin):Integer;override;
                   public
                    constructor Create(ASon:Tl3Expr;CapStyle:TExprCapStyle;Count:Integer);
                    function FTType:Integer;override;
                  end;

         TExprStand=class(TExprParent)
                     private
                      Alg:TExprHorAlign;
                     protected
                      procedure Paint(X,Y:Integer);override;
                      function CalcWidth:Integer;override;
                      function CalcHeight:Integer;override;
                     public
                      constructor Create(ASon:Tl3Expr;Align:TExprHorAlign);
                    end;

         TExprMatrix=class(TExprParent)
                      private
                       HS,VS:Integer;
                       FCX,FCY:Integer;
                      protected
                       procedure GetCellSize(var CX,CY:Integer);
                       procedure Paint(X,Y:Integer);override;
                       function CalcWidth:Integer;override;
                       function CalcHeight:Integer;override;
                       function GetCellWidth:Integer;
                       function GetCellHeight:Integer;
                      public
                       constructor Create(ASon:Tl3Expr;HorSize,VertSize:Integer);
                     end;

         TExprGroupOp=class(TExprTwinParent)
                       private
                        FSymbolHeight,FSymbolWidth:Integer;
                       protected
                        function CalcSymbolHeight:Integer;
                        function CalcSymbolWidth:Integer;virtual;abstract;
                        procedure DrawSymbol(X,Y:Integer);virtual;abstract;
                        procedure Paint(X,Y:Integer);override;
                        function GetSymbolWidth:Integer;
                        function GetSymbolHeight:Integer;
                        function CalcWidth:Integer;override;
                        function CalcHeight:Integer;override;
                        function CalcMidLine(Origin:TExprOrigin):Integer;override;
                       public
                        constructor Create(ASon,FirstTwin,SecondTwin:Tl3Expr);
                      end;

         TExprSumma=class(TExprGroupOp)
                     protected
                      function CalcSymbolWidth:Integer;override;
                      procedure DrawSymbol(X,Y:Integer); override;
                    end;

         TExprProd=class(TExprGroupOp)
                    protected
                     function CalcSymbolWidth:Integer;override;
                     procedure DrawSymbol(X,Y:Integer); override;
                   end;

         TExprCirc=class(TExprGroupOp)
                    protected
                     function CalcSymbolWidth:Integer;override;
                     procedure DrawSymbol(X,Y:Integer); override;
                   end;

         TExprIntegral=class(TExprGroupOp)
                        private
                         K:Integer;
                        protected
                         function CalcSymbolWidth:Integer;override;
                         procedure DrawSymbol(X,Y:Integer); override;
                        public
                         constructor Create(ASon,FirstTwin,SecondTwin:Tl3Expr;Mult:Integer);
                       end;

         TExprLambda=class(TExprExtSymbol)
                      protected
                       procedure Paint(X,Y:Integer);override;
                      public
                       constructor Create;
                     end;

         TExprNabla=class(TExprExtSymbol)
                     protected
                      procedure Paint(X,Y:Integer);override;
                     public
                      constructor Create;
                    end;

         TExprAsterix=class(TExprSimple)
                       protected
                        procedure Paint(X,Y:Integer);override;
                       public
                        constructor Create;
                      end;

         TExprCase=class(TExprParent)
                    protected
                     procedure Paint(X,Y:Integer);override;
                     function CalcWidth:Integer;override;
                     function CalcHeight:Integer;override;
                   end;

         TExprEmpty=class(Tl3Expr)
                     protected
                      function CalcHeight:Integer;override;
                    end;

 TExprContainer = class(TExprParent, Il3Renderer)
 private
  f_ForWMF: Boolean;
  f_Padding: Integer;
  f_YOfs : Integer;
  f_XOfs : Integer;
  f_WidthDelta : Integer;
 protected
   procedure Render(aCanvas: TCanvas; const aColors: Il3EffectiveColors);
     {* Отрисовать картинку }
   function CalcExtent(const aFont: Il3Font): Tl3_SPoint;
     {-}
  function CalcWidth: Integer; override;
  function CalcHeight: Integer; override;
  procedure Paint(X,Y:Integer); override;
  procedure SetForWMF(aValue: Boolean);
  procedure Cleanup; override;
 public
  constructor Create(aSon: Tl3Expr);
//  property Padding: Integer read f_Padding write f_Padding;
 end;

implementation

uses
  l3Math,
  l3Drawer,
  l3Chars,
  l3Canvas
  ;

   {Tl3Expr}

   constructor Tl3Expr.Create;
    begin
     inherited Create;
     FNext:=nil;
     Parent:=nil;
     FColor:=clNone;
     FFont:=TFont.Create;
     FFont.Name:='Times New Roman';
     FFont.Charset:=Russian_Charset;
     FFont.OnChange:=FontNotify;
     FWidth:=0;
     FHeight:=0;
     FMidLineUp:=0;
     FMidLineDn:=0;
     FPowerXPos:=0;
     FPowerYPos:=0;
     FIndexXPos:=0;
     FIndexYPos:=0;
     FCapDXLeft:=0;
     FCapDXRight:=0;
     FCapDY:=0;
     WX:=0;
     WY:=0;
     RWX:=0;
     RWY:=0;
     ToChange:=[];
     FCanvas:=nil
    end;

   procedure Tl3Expr.Release;
    begin
     l3Free(FNext);
     FreeAndNil(FFont);
     inherited;
    end;

   procedure Tl3Expr.SetNext;
    begin
     if Assigned(FNext) then
      FreeAndNil(FNext);
     FNext:=Value;
     if Assigned(FNext) then
      FNext.Parent:=Parent;
    end;

   procedure Tl3Expr.SetParent;
    begin
     if FParent<>Value then
      begin
       FParent:=Value;
       if Assigned(FNext) then
        FNext.Parent:=Parent
      end
    end;

   function Tl3Expr.GetColor;
    begin
     if FColor<>clNone then
      Result:=FColor
     else
      if Assigned(Parent) then
       Result:=Parent.Color
      else
       Result:=clBlack
    end;

   procedure Tl3Expr.SetColor;
    begin
     if Value<>FColor then
      begin
       FColor:=Value;
       if Assigned(FNext) then
        FNext.Color:=Value
      end
    end;

   procedure Tl3Expr.SetCanvas;
    begin
     if FCanvas<>Value then
      begin
       FCanvas:=Value;
       if Assigned(Canvas) then
        begin
         ToChange:=tcAll;
         SetLineWidth
        end
       else
        ToChange:=[];
       DynaSetCanvas
      end
    end;

   procedure Tl3Expr.AssignCanvas;
    begin
     if FCanvas<>Value then
      begin
       FCanvas:=Value;
       if Assigned(Canvas) then
        ToChange:=tcAll
       else
        ToChange:=[];
       WX:=EWX;
       WY:=EWY;
       RWX:=ERWX;
       RWY:=ERWY;
       DynaSetCanvas
      end
    end;

   procedure Tl3Expr.SetLineWidth;
    var H:Extended;
        M2:TMat2;
        GM:TGlyphMetrics;
        l_DC : hDC;
        l_Factor : Extended;
     begin
      SetCanvasFont;
      H:=Canvas.TextHeight('+');
      RWX:=H/27.6;
      l_DC := Canvas.Handle;
      Assert(l_DC <> 0);
      l_Factor := GetDeviceCaps(l_DC,LogPixelSY)/GetDeviceCaps(l_DC,LogPixelSX);
      RWY:=RWX*l_Factor;
      l3ZeroMemory(@M2,SizeOf(M2));
      M2.eM11.value:=1;
      M2.eM22.value:=1;
      l3ZeroMemory(@GM,SizeOf(GM));
      if (GetGlyphOutline(l_DC,Cardinal('_'),GGO_Metrics,GM,0,nil,M2) <= 0) then
       Assert(false); 
      WY:=GM.gmBlackBoxY;
      WX:=Round(WY*l_Factor);
     end;

   procedure Tl3Expr.SetFont;
    begin
     FFont.Assign(NewFont);
     if Assigned(Canvas) then
      SetLineWidth;
     DynaSetFont
    end;

   procedure Tl3Expr.AssignFont;
    begin
     FFont.Assign(NewFont);
     WX:=EWX;
     WY:=EWY;
     RWX:=ERWX;
     RWY:=ERWY;
     DynaSetFont
    end;

   procedure Tl3Expr.FontNotify;
    begin
     if Assigned(Canvas) then
      SetLineWidth;
     DynaSetFont
    end;

   procedure Tl3Expr.DynaSetCanvas;
    begin
     if Assigned(Next) then
      Next.AssignCanvas(Canvas,WX,WY,RWX,RWY)
    end;

   procedure Tl3Expr.DynaSetFont;
    begin
     ToChange:=tcAll;
     if Assigned(Next) then
      Next.AssignFont(Font,WX,WY,RWX,RWY)
    end;

   procedure Tl3Expr.AddNext;
    var P:Tl3Expr;
     begin
      P:=Self;
      while Assigned(P.Next) do
       P:=P.Next;
      P.FNext:=aValue;
      P.FNext.Font:=Font;
      P.FNext.Canvas:=Canvas
     end;

   function Tl3Expr.CutOff;
    begin
     Result:=FNext;
     FNext:=nil
    end;

   function Tl3Expr.NeedBrackets;
    begin
     Result:=False
    end;

   function Tl3Expr.ArgNeedBrackets;
    begin
     Result:=True
    end;

   function Tl3Expr.FTType;
    begin
     Result:=efLeft or efRight
    end;

   function Tl3Expr.CalcPowerXPos;
    begin
     Result:=Width
    end;

   function Tl3Expr.CalcIndexXPos;
    begin
     Result:=Width
    end;

   function Tl3Expr.CalcPowerYPos;
    begin
     SetCanvasFont;
     Result:=Canvas.TextHeight('A') div 2
    end;

   function Tl3Expr.CalcIndexYPos;
    begin
     SetCanvasFont;
     Result:=Height-Canvas.TextHeight('A') div 2-2
    end;

   function Tl3Expr.CalcCapDY;
    begin
     Result:=0
    end;

   procedure Tl3Expr.CalcCapDX;
    begin
     DLeft:=0;
     DRight:=0
    end;

   function Tl3Expr.CalcMidLine;
    begin
     if Origin=eoTop then
      Result:=Height div 2
     else
      Result:=-((Height-1) div 2)
    end;

   procedure Tl3Expr.SetCanvasFont;
    begin
     Canvas.Font:=Font;
     Canvas.Font.Color:=Color
    end;

   procedure Tl3Expr.SetPenAndBrush;
    begin
     Canvas.Pen.Style := psSolid;
     Canvas.Pen.Width := 1;
     Canvas.Pen.Color := Color;
     Canvas.Brush.Style := bsSolid;
     Canvas.Brush.Color := Color
    end;

   procedure Tl3Expr.ConvertCoords;
    begin
     case HorAlign of
      ehCenter:Dec(X,Width div 2);
      ehRight:Dec(X,Width-1)
     end;
     case VertAlign of
      evCenter:Dec(Y,MidLineUp);
      evBottom:Dec(Y,Height-1)
     end
    end;

   function Tl3Expr.CalcWidth;
    begin
     Result:=0
    end;

   function Tl3Expr.CalcHeight;
    begin
     Result:=0
    end;

   procedure Tl3Expr.Paint;
    begin
    end;

   procedure Tl3Expr.Draw;
    begin
     ConvertCoords(X,Y,HorAlign,VertAlign);
     {if Self is Tl3Expr then
      begin
       Canvas.Pen.Color:=clRed;
       Canvas.Brush.Style:=bsClear;
       Canvas.Rectangle(X,Y,X+Width,Y+Height)
      end;}
     SetBkMode(Canvas.Handle,Transparent);
     SetTextAlign(Canvas.Handle,TA_Top or TA_Left);
     SetCanvasFont;
     Paint(X,Y);
    end;

function Tl3Expr.DrawSymbolOnCanvas(aChar: PWideChar; aHeight, aWidth: Integer; aX, aY: Integer; aGrowCoeff: Double
    = 1.0; aVShiftCoeff: Double = 0.0; aHShiftCoeff: Double = 0.0): TSize;
var
 LF:TLogFont;
 NewFont,OldFont:HFont;
 OldMode: Integer;
 l_Grow  : Integer;
 l_VShift: Integer;
 l_Height: Integer;
 l_HShift: Integer;
 l_OldColor: Integer;
begin
 OldMode := GetMapMode(Canvas.Handle);
 try
  l_Height := Round(aHeight * aGrowCoeff);
  l_VShift := Round(l_Height * aVShiftCoeff);
  SetMapMode(Canvas.Handle, MM_TEXT);
  with LF do
  begin
   lfHeight := l_Height;
   lfWidth:= Round(aWidth * aGrowCoeff);
   lfEscapement := 0;
   lfOrientation := 0;
   lfWeight:= FW_BOLD;
   lfItalic := 0;
   lfUnderline := 0;
   lfStrikeOut:= 0;
   lfCharSet := DEFAULT_CHARSET;
   lfOutPrecision:=OUT_TT_PRECIS;
   lfClipPrecision:= CLIP_DEFAULT_PRECIS;
   lfQuality := DEFAULT_QUALITY; //Default_Quality;
   lfPitchAndFamily:=Default_Pitch;
   StrPCopy(lfFaceName, 'Times New Roman');
  end;

  NewFont := CreateFontIndirect(LF);
  OldFont := SelectObject(Canvas.Handle, NewFont);
  SetTextColor(Canvas.Handle, ColorToRGB(Color));
  SetBkMode(Canvas.Handle, TRANSPARENT);
  GetTextExtentPoint32W(Canvas.Handle, aChar, 1, Result);
  l_HShift := Round(Result.CX * aHShiftCoeff);

  {l_OldColor := Canvas.Pen.Color;
  try
   Canvas.Pen.Color := clRed;
   Canvas.Rectangle(aX - (Result.cx div 2) + l_HShift, aY - (Result.cy div 2) + l_VShift, aX + (Result.cx div 2) + l_HShift, aY + (Result.cy div 2) + l_VShift);
  finally
   Canvas.Pen.Color := l_OldColor;
  end;}
   
  TextOutW(Canvas.Handle, aX - (Result.cx div 2) + l_HShift, aY - (Result.cy div 2) + l_VShift, aChar, 1);

  SelectObject(Canvas.Handle,OldFont);
  DeleteObject(NewFont);
 finally
  SetMapMode(Canvas.Handle, OldMode);
 end;
end;

   function Tl3Expr.GetWidth;
    begin
     if tcWidth in ToChange then
      begin
       FWidth:=CalcWidth;
       ToChange:=ToChange - [tcWidth]
      end;
     Result:=FWidth
    end;

   function Tl3Expr.GetHeight;
    begin
     if tcHeight in ToChange then
      begin
       FHeight:=CalcHeight;
       ToChange:=ToChange - [tcHeight]
      end;
     Result:=FHeight
    end;

   function Tl3Expr.GetMidLineUp;
    begin
     if tcMidLineUp in ToChange then
      begin
       FMidLineUp:=CalcMidLine(eoTop);
       ToChange:=ToChange - [tcMidLineUp]
      end;
     Result:=FMidLineUp
    end;

   function Tl3Expr.GetMidLineDn;
    begin
     if tcMidLineDn in ToChange then
      begin
       FMidLineDn:=CalcMidLine(eoBottom);
       ToChange:=ToChange - [tcMidLineDn]
      end;
     Result:=FMidLineDn
    end;

   function Tl3Expr.GetPowerXPos;
    begin
     if tcPowerXPos in ToChange then
      begin
       FPowerXPos:=CalcPowerXPos;
       ToChange:=ToChange - [tcPowerXPos]
      end;
     Result:=FPowerXPos
    end;

   function Tl3Expr.GetPowerYPos;
    begin
     if tcPowerYPos in ToChange then
      begin
       FPowerYPos:=CalcPowerYPos;
       ToChange:=ToChange - [tcPowerYPos]
      end;
     Result:=FPowerYPos
    end;

   function Tl3Expr.GetIndexXPos;
    begin
     if tcIndexXPos in ToChange then
      begin
       FIndexXPos:=CalcIndexXPos;
       ToChange:=ToChange - [tcIndexXPos]
      end;
     Result:=FIndexXPos
    end;

   function Tl3Expr.GetIndexYPos;
    begin
     if tcIndexYPos in ToChange then
      begin
       FIndexYPos:=CalcIndexYPos;
       ToChange:=ToChange - [tcIndexYPos]
      end;
     Result:=FIndexYPos
    end;

   function Tl3Expr.GetCapDXLeft;
    begin
     if tcCapDX in ToChange then
      begin
       CalcCapDX(FCapDXLeft,FCapDXRight);
       ToChange:=ToChange - [tcCapDX]
      end;
     Result:=FCapDXLeft
    end;

   function Tl3Expr.GetCapDXRight;
    begin
     if tcCapDX in ToChange then
      begin
       CalcCapDX(FCapDXLeft,FCapDXRight);
       ToChange:=ToChange - [tcCapDX]
      end;
     Result:=FCapDXRight
    end;

   function Tl3Expr.GetCapDY;
    begin
     if tcCapDY in ToChange then
      begin
       FCapDY:=CalcCapDY;
       ToChange:=ToChange - [tcCapDY]
      end;
     Result:=FCapDY
    end;

   {TExprParent}

   constructor TExprParent.Create;
    begin
     inherited Create;
     Son:=ASon
    end;

   procedure TExprParent.Release;
    begin
     l3Free(FSon);
     inherited;
    end;

   procedure TExprParent.SetSon;
    begin
     l3Free(FSon);
     FSon:=Value;
     if Assigned(FSon) then
      begin
       FSon.Parent:=Self;
       SetSonFont;
       SetSonCanvas
      end;
     ToChange:=tcAll;
    end;

   procedure TExprParent.DynaSetFont;
    begin
     inherited DynaSetFont;
     SetSonFont
    end;

   procedure TExprParent.DynaSetCanvas;
    begin
     inherited DynaSetCanvas;
     SetSonCanvas
    end;

   procedure TExprParent.SetSonFont;
    begin
     if Assigned(FSon) then
      FSon.AssignFont(Font,WX,WY,RWX,RWY)
    end;

   procedure TExprParent.SetSonCanvas;
    begin
     if Assigned(FSon) then
      Son.AssignCanvas(Canvas,WX,WY,RWX,RWY)
    end;

   function TExprParent.CutOffSon;
    begin
     Result:=FSon;
     FSon:=nil;
     ToChange:=tcAll;
    end;

   {TExprBigParent}

   constructor TExprBigParent.Create;
    begin
     inherited Create(ASon);
     Daughter:=ADaughter
    end;

   procedure TExprBigParent.Release;
    begin
     l3Free(FDaughter);
     inherited;
    end;

   procedure TExprBigParent.SetDaughter;
    begin
     l3Free(FDaughter);
     FDaughter:=Value;
     if Assigned(FDaughter) then
      begin
       FDaughter.Parent:=Self;
       SetDaughterFont;
       SetDaughterCanvas
      end;
     ToChange:=tcAll;
    end;

   procedure TExprBigParent.DynaSetFont;
    begin
     inherited DynaSetFont;
     SetDaughterFont
    end;

   procedure TExprBigParent.DynaSetCanvas;
    begin
     inherited DynaSetCanvas;
     SetDaughterCanvas
    end;

   procedure TExprBigParent.SetDaughterFont;
    begin
     if Assigned(FDaughter) then
      FDaughter.AssignFont(Font,WX,WY,RWX,RWY)
    end;

   procedure TExprBigParent.SetDaughterCanvas;
    begin
     if Assigned(FDaughter) then
      FDaughter.AssignCanvas(Canvas,WX,WY,RWX,RWY)
    end;

   function TExprBigParent.CutOffDaughter;
    begin
     Result:=FDaughter;
     FDaughter:=nil;
     ToChange:=tcAll;
    end;

   {TExprChain}

   procedure TExprChain.CalcOverAbove;
    var P:Tl3Expr;
     begin
      Over:=0;
      Above:=0;
      P:=Son;
      while Assigned(P) do
       with P do
        begin
         Over:=MaxIntValue([Over,MidLineUp+1]);
         Above:=MaxIntValue([Above,Height-MidLineUp-1]);
         P:=Next
        end
     end;

   procedure TExprChain.BuildUpChain;
    var P:Tl3Expr;
     begin
      if Assigned(Son) then
       begin
        P:=Son;
        while Assigned(P.Next) do
         P:=P.Next;
        P.Next:=Value;
        Value.Parent:=Self
       end
      else
       Son:=Value;
      ToChange:=tcAll;
     end;

   function TExprChain.CalcWidth;
    var P:Tl3Expr;
     begin
      Result:=0;
      P:=Son;
      while Assigned(P) do
       begin
        Inc(Result,P.Width);
        P:=P.Next
       end
     end;

   function TExprChain.CalcHeight;
    var Over,Above:Integer;
     begin
      CalcOverAbove(Over,Above);
      Result:=Over+Above
     end;

   function TExprChain.CalcMidLine;
    var Over,Above:Integer;
     begin
      CalcOverAbove(Over,Above);
      if Origin=eoTop then
       Result:=Over-1
      else
       Result:=-Above
     end;

   function TExprChain.FTType;
    var P:Tl3Expr;
     begin
      P:=Son;
      while Assigned(P.Next) do
       P:=P.Next;
      Result:=Son.FTType and efLeft or P.FTType and efRight or Son.FTType and efNegative
     end;

   procedure TExprChain.Paint;
    var P:Tl3Expr;
     begin
      Inc(Y,MidLineUp);
      P:=Son;
      while Assigned(P) do
       with P do
        begin
         Draw(X,Y,ehLeft,evCenter);
         Inc(X,Width);
         P:=Next
        end
     end;

   function TExprChain.CalcCapDY;
    var P:Tl3Expr;
        DY:Integer;
     begin
      Result:=MaxInt;
      P:=Son;
      while Assigned(P) do
       begin
        DY:=P.CapDY;
        if DY<Result then
         Result:=DY;
        P:=P.Next
       end
     end;

   procedure TExprChain.CalcCapDX;
    var P:Tl3Expr;
     begin
      DLeft:=Son.CapDXLeft;
      P:=Son;
      while Assigned(P.Next) do
       P:=P.Next;
      DRight:=P.CapDXRight
     end;

   {TExprSimple}

   constructor TExprSimple.Create;
    begin
     inherited Create;
     S:=Expr
    end;

   function TExprSimple.CalcWidth;
    var ABC:TABC;
     begin
      SetCanvasFont;
      Result:=Canvas.TextWidth(S);
      if GetCharABCWidths(Canvas.Handle,Integer(S[1]),Integer(S[1]),ABC) and (ABC.abcA<0) then
       Dec(Result,ABC.abcA);
      if GetCharABCWidths(Canvas.Handle,Integer(S[Length(S)]),Integer(S[Length(S)]),ABC) and (ABC.abcC<0) then
       Dec(Result,ABC.abcC)
     end;

   function TExprSimple.CalcHeight;
    begin
     SetCanvasFont;
     Result:=Canvas.TextHeight(S)
    end;

   procedure TExprSimple.Paint;
    var ABC:TABC;
     begin
      SetCanvasFont;
      if GetCharABCWidths(Canvas.Handle,Integer(S[1]),Integer(S[1]),ABC) and (ABC.abcA<0) then
       Canvas.TextOut(X-ABC.abcA,Y,S)
      else
       Canvas.TextOut(X,Y,S)
     end;

   function TExprSimple.CalcCapDY;
    var DY:Extended;
     begin
      case S[1] of
       'A'..'Z','А'..'И','К'..'Я':DY:=4;
       'a','c','e','g','m'..'s','u'..'z','а'..'и','к'..'я':DY:=9.5;
       'b','d','f','h','k','l':DY:=4;
       'i','j','t','й','ё':DY:=7;
       'Ё','Й':DY:=2.5
      else
       DY:=0
      end;
      Result:=Round(DY*RWY)
     end;

   {TExprUnicode}

   constructor TExprUnicode.Create;
    begin
     inherited Create;
     S:=Expr
    end;

   function TExprUnicode.CalcWidth;
    var Size:TSize;
        ABC:TABC;
     begin
      SetCanvasFont;
      GetTextExtentPoint32W(Canvas.Handle,@S[1],Length(S),Size);
      Result:=Size.CX;
      if GetCharABCWidths(Canvas.Handle,Integer(S[1]),Integer(S[1]),ABC) then
       begin
        if ABC.abcA<0 then
         Dec(Result,ABC.abcA);
        if ABC.abcC<0 then
         Dec(Result,ABC.abcC)
       end
     end;

   function TExprUnicode.CalcHeight;
    var Size:TSize;
     begin
      SetCanvasFont;
      GetTextExtentPoint32W(Canvas.Handle,@S[1],Length(S),Size);
      Result:=Size.CY
     end;

   procedure TExprUnicode.Paint;
    var ABC:TABC;
     begin
      SetCanvasFont;
      if GetCharABCWidths(Canvas.Handle,Integer(S[1]),Integer(S[1]),ABC) and (ABC.abcA<0) then
       TextOutW(Canvas.Handle,X-ABC.abcA,Y,@S[1],Length(S))
      else
       TextOutW(Canvas.Handle,X,Y,@S[1],Length(S))
     end;

   function TExprUnicode.CalcCapDY;
    var DY:Extended;
     begin
      case S[1] of
       #913..#929,#931..#937:DY:=4;
       #945,#947,#949,#951,#953,#954,#956,#957,#959..#961,#963..#969:DY:=8.8;
       #946,#948,#950,#952,#955,#958:DY:=4;
       WideChar(esEllipsis):DY:=MaxInt/RWY-1;
      else
       DY:=0
      end;
      Result:=Round(DY*RWY);
     end;

   {TExprVar}

   procedure TExprVar.SetCanvasFont;
    begin
     Canvas.Font:=Font;
     Canvas.Font.Style:=Canvas.Font.Style+[fsItalic];
     Canvas.Font.Color:=Color
    end;

   {function TExprVar.CalcCapDY;
    var DY:Extended;
     begin
      case S[1] of
       'A'..'Z':DY:=4;
       'a','c','e','g','m'..'s','u'..'z':DY:=9.5;
       'b','d','f','h','k','l':DY:=4;
       'i','j','t':DY:=7
      else
       DY:=0
      end;
      Result:=Round(DY*RWY)
     end;}

   procedure TExprVar.CalcCapDX;
    var DX:Extended;
     begin
      case S[1] of
       'A','f':DX:=5;
       'B','D'..'F','L','P','R'..'T','Y','Z','a'..'e','g'..'o','q'..'t','y'..'z':DX:=1;
       'C','G'..'K','M'..'O','Q','X','p':DX:=2;
       'U'..'W':DX:=1.5;
       'u','v','w':DX:=-0.5
      else
       DX:=0
      end;
      DLeft:=Round(DX*RWX);
      case S[Length(S)] of
       'A','f':DX:=5.5;
       'B','D'..'F','I','P','R','X':DX:=4;
       'C','G','H','J'..'L','O','Q','S','U'..'W','Y','Z','p':DX:=2;
       'M','N':DX:=1.5;
       'T':DX:=2.4;
       'a'..'e','g','h','k','m'..'o','q'..'s','u'..'z':DX:=1;
       'i','j','l','t':DX:=3
      else
       DX:=0
      end;
      DRight:=Round(DX*RWX)
     end;

   function TExprVar.CalcIndexXPos;
    var DX:Extended;
     begin
      case S[Length(S)] of
       'R':DX:=1.5;
       'W':DX:=6;
       'x':DX:=1;
      else
       DX:=3
      end;
      Result:=inherited CalcIndexXPos-Round(DX*RWX)
     end;

   function TExprVar.CalcPowerXPos;
    var DX:Integer;
     begin
      DX:=0;
      case S[Length(S)] of
       'f','d':DX:=2;
       'r':DX:=1
      end;
      Result:=inherited CalcPowerXPos+Round(DX*RWX)
     end;

   {TExprCustomText}

   constructor TExprCustomText.Create;
    begin
     inherited Create(Expr);
     FFontStyle:=FontStyle;
     FFontName:=FontName
    end;

   procedure TExprCustomText.SetCanvasFont;
    begin
     Canvas.Font:=Font;
     Canvas.Font.Name:=FFontName;
     Canvas.Font.Style:=FFontStyle;
     Canvas.Font.Color:=Color
    end;

   {TExprNumber}

   constructor TExprNumber.Create;
    begin
     inherited Create;
     ExpVal:=ExpForm;
     if A=0 then
      FNumber:=1
     else
      FNumber:=0;
     Number:=A
    end;

   function TExprNumber.NumToStr;
    begin
     if ExpVal then
      Result:=FloatToStrF(Number,ffExponent,14,0)
     else
      Result:=FloatToStr(Number)
    end;

   procedure TExprNumber.SetNumber;
    var S:AnsiString;
        P:Integer;
     begin
      if Value<>FNumber then
       begin
        FNumber:=Value;
        S:=NumToStr;
        P:=Pos('E',S);
        if P=0 then
         begin
          SM:=FloatToStr(StrToFloat(S));
          SE:=''
         end
        else
         begin
          SM:=Copy(S,1,P-1);
          SE:=Copy(S,P+1,MaxInt);
          SM:=FloatToStr(StrToFloat(SM));
          if SE[1]='+' then
           Delete(SE,1,1);
          while (SE[1]='0') and (Length(SE)>1) do
           Delete(SE,1,1);
          P:=Pos('.',SM);
          if P>0 then
           begin
            while SM[Length(SM)]='0' do
             Delete(SM,Length(SM),1);
            if SM[Length(SM)]='.' then
             Delete(SM,Length(SM),1)
           end
         end;
        ToChange:=ToChange + [tcWidth, tcHeight, tcCapDY]
       end
     end;

   function TExprNumber.CalcWidth;
    begin
     SetCanvasFont;
     if SE<>'' then
      begin
       if SM='1' then
        Result:=Canvas.TextWidth('10')
       else
        Result:=Canvas.TextWidth(SM+'·10');
       Canvas.Font.Height:=Round(0.7*Canvas.Font.Height);
       Inc(Result,Canvas.TextWidth(SE))
      end
     else
      Result:=Canvas.TextWidth(SM);
    end;

   function TExprNumber.CalcHeight;
    begin
     SetCanvasFont;
     Result:=Canvas.TextHeight(SM);
     if SE<>'' then
      Result:=Round(1.2*Result)
    end;

   function TExprNumber.CalcCapDY;
    begin
     if SE='' then
      Result:=Round(8*RWY)
     else
      Result:=Round(3*RWY)
    end;

   function TExprNumber.CalcMidLine;
    var H:Integer;
     begin
      if (SE='') then
       Result:=inherited CalcMidLine(Origin)
      else
       begin
        SetCanvasFont;
        H:=Canvas.TextHeight(SM);
        if Origin=eoTop then
         Result:=H div 2+Round(H*0.2)
        else
         Result:=-((H-1) div 2)
       end
     end;

   function TExprNumber.FTType;
    begin
     Result:=efRight or efNegative*Integer(Number<0)
    end;

   procedure TExprNumber.Paint;
    var H,W:Integer;
     begin
      SetCanvasFont;
      if SE='' then
       Canvas.TextOut(X,Y,SM)
      else
       with Canvas do
        begin
         H:=Round(0.2*TextHeight(SM));
         if SM='1' then
          begin
           TextOut(X,Y+H,'10');
           W:=TextWidth('10')
          end
         else
          begin
           TextOut(X,Y+H,SM+'·10');
           W:=TextWidth(SM+'·10')
          end;
         Font.Height:=Round(0.7*Canvas.Font.Height);
         TextOut(X+W,Y,SE)
        end
     end;

   {TExprExpNumber}

   constructor TExprExpNumber.Create;
    begin
     FPrecision:=Precision;
     FDigits:=Digits;
     FMaxDeg:=MaxDeg;
     inherited Create(A,False);
    end;

   function TExprExpNumber.NumToStr;
    begin
     if (FNumber<>0) and (Log10(Abs(FNumber))<=-FMaxDeg) then
      Result:=FloatToStrF(FNumber,ffExponent,FPrecision,1)
     else
      Result:=FloatToStrF(FNumber,ffFixed,FPrecision,FDigits)
    end;

   {TExprRatio}

   function TExprRatio.CalcWidth;
    begin
     Result:=8*WX+MaxIntValue([Son.Width,Daughter.Width])
    end;

   function TExprRatio.CalcHeight;
    begin
     Result:=3*WY+Son.Height+Daughter.Height
    end;

   function TExprRatio.CalcMidLine;
    begin
     if Origin=eoTop then
      Result:=Son.Height+WY+WY div 2
     else
      Result:=-Daughter.Height-WY-WY div 2
    end;

   procedure TExprRatio.Paint;
    var XC,YC:Integer;
     begin
      YC:=MidLineUp;
      XC:=Width div 2;
      Son.Draw(X+XC,Y+YC-WY-WY div 2,ehCenter,evBottom);
      Daughter.Draw(X+XC,Y+YC+WY+WY div 2,ehCenter,evTop);
      with Canvas do
       begin
        SetPenAndBrush;
        Rectangle(X+3*WX,Y+YC-WY div 2,X+Width-3*WX+1,Y+YC+WY div 2+WY and 1)
       end
     end;

   {TExprRoot}

   function TExprRoot.CalcWidth;
    begin
     Result:=Son.Width+8*WX+Round((Son.Height+WY)/2);
     if Assigned(Daughter) then
      Inc(Result,MaxIntValue([0,Daughter.Width-5*WX]))
    end;

   function TExprRoot.CalcHeight;
    begin
     Result:=3*WY+Son.Height;
     if Assigned(Daughter) then
      Inc(Result,MaxIntValue([0,Daughter.Height-4*WY]))
    end;

   function TExprRoot.CalcMidLine;
    begin
     if Origin=eoBottom then
      Result:=Son.MidLineDn
     else
      if Assigned(Daughter) and (Daughter.Height>4*WY) then
       Result:=Son.MidLineUp-WY+Daughter.Height
      else
       Result:=Son.MidLineUp+3*WY
    end;

   procedure TExprRoot.SetDaughterFont;
    var TmpFont:TFont;
     begin
      if Assigned(Daughter) then
       begin
        TmpFont:=TFont.Create;
        TmpFont.Assign(Font);
        TmpFont.Height:=Round(0.7*Font.Height);
        Daughter.Font:=TmpFont;
        FreeAndNil(TmpFont);
       end
     end;

   procedure TExprRoot.SetDaughterCanvas;
    begin
     if Assigned(Daughter) then
      Daughter.Canvas:=Canvas
    end;

   procedure TExprRoot.Paint;
    var DX,DY,I,W,H:Integer;
        Pt:array[1..12] of TPoint;
        l_D: Tl3Drawer;
     begin
      H:=3*WY+Son.Height;
      W:=Son.Width+8*WX+Round((Son.Height+WY)/2);
      Pt[1]:=Point(X+WX,Y+6*WY);
      Pt[2]:=Point(X+6*WX-1,Y+6*WY);
      Pt[3]:=Point(X+6*WX-1,Y+Round(H-3*Sqrt(3)*WY));
      Pt[4]:=Point(X+W-3*WX-Son.Width-WX div 2-1,Y+WY);
      Pt[5]:=Point(X+W-WX-1,Y+WY);
      Pt[6]:=Point(X+W-WX-1,Y+4*WY-1);
      Pt[7]:=Point(X+W-2*WX,Y+4*WY-1);
      Pt[8]:=Point(X+W-2*WX,Y+2*WY-1);
      Pt[9]:=Point(X+W-3*WX-Son.Width-1,Y+2*WY-1);
      Pt[10]:=Point(X+4*WX,Y+H);
      Pt[11]:=Point(X+4*WX,Y+7*WY-1);
      Pt[12]:=Point(X+WX,Y+7*WY-1);

      if Assigned(Daughter) then
       begin
        DX:=MaxIntValue([0,Daughter.Width-5*WX]);
        DY:=MaxIntValue([0,Daughter.Height-4*WY]);
        for I:=1 to 12 do
         begin
          Inc(Pt[I].X,DX);
          Inc(Pt[I].Y,DY)
         end;
        Daughter.Draw(Pt[2].X,Pt[2].Y-WY,ehRight,evBottom)
       end;
      Son.Draw(Pt[9].X,Pt[9].Y+WY,ehLeft,evTop);
      SetPenAndBrush;
      l_D := Tl3Drawer.Create(Canvas);
      try
       l_D.DrawPolygon(Pt);
       l_D.FillPolygon(Pt);
      finally
       l3Free(l_D);
      end;
     end;

   {TExprBracketed}

   constructor TExprBracketed.Create;
    begin
     inherited Create(ASon);
     Left:=LeftBracket;
     Right:=RightBracket
    end;

   function TExprBracketed.IsBracketed;
    begin
     Result:=True
    end;

   function TExprBracketed.FTType;
    begin
     if IsBracketed and (Left<>ebNone) and (Right<>ebNone) then
      begin
       Result:=efLeft or efRight or efBrackets;
       if (Left=ebRound) and (Right=ebRound) then
        Result:=Result or efRoundBrackets
      end
     else
      Result:=inherited FTType
    end;

   function TExprBracketed.CalcWidth;
    begin
     Result:=inherited CalcWidth;
     if IsBracketed then
      begin
       case Left of
        ebRound:Inc(Result,Round(Height*0.191192)+2*WX);
        ebSquare:Inc(Result,Round(Height*0.1)+5*WX);
        ebFigure:Inc(Result, Round(Height*0.2)+2*WX);
        ebModule:Inc(Result,3*WX)
       end;
       case Right of
        ebRound:Inc(Result,Round(Height*0.191192)+2*WX);
        ebSquare:Inc(Result,Round(Height*0.1)+5*WX);
        ebFigure:Inc(Result, Round(Height*0.2)+2*WX);
        ebModule:Inc(Result,3*WX)
       end
      end
    end;

   function TExprBracketed.CalcHeight;
    begin
     Result:=inherited CalcHeight;
     Inc(Result,2*WY);
     if IsBracketed and ((Left=ebFigure) or (Right=ebFigure)) then
      if Odd(Result-WY) then
       Inc(Result)
    end;

   function TExprBracketed.CalcMidLine;
    begin
     if (Origin=eoTop) then
      Result:=inherited CalcMidLine(eoTop)+WY
     else
      begin
       Result:=inherited CalcMidLine(eoBottom)-WY;
       if IsBracketed and ((Left=ebFigure) or (Right=ebFigure)) then
        if Odd(Result-WY) then
         Dec(Result)
      end
    end;

   procedure TExprBracketed.Paint;
   var
    W,H,KH,DX,N:Integer;
    l_SymWidth: Integer;

        Pt:array[1..46] of TPoint;
     begin
      if not IsBracketed or ((Left=ebNone) and (Right=ebNone)) then
       inherited Paint(X,Y)
      else
       begin
        W:=inherited CalcWidth;
        H:=Height;
        case Left of
         ebNone:DX:=0;
         ebRound:begin
                  DX:=Round(H*0.191192);
                  l_SymWidth := Round(H*0.195);
                  DrawSymbolOnCanvas(#$0028, H, l_SymWidth, X, Y + H div 2, 1.2, -0.1, 0.5);
                  Inc(DX,2*WX);
                 end;
         ebSquare:begin
                   DX := Round(H*0.1)+2*WX;
                   l_SymWidth := Round(H*0.17);
                   DrawSymbolOnCanvas(#$005B, H, l_SymWidth, X, Y + H div 2, 1.2, -0.1, 0.4);
                  end;
         ebFigure:begin
                   DX:=Round(H*0.2);
                   l_SymWidth := Round(H*0.17);
                   DrawSymbolOnCanvas(#$007B, H, l_SymWidth, X, Y + H div 2, 1.2, -0.1, 0.4);
                   Inc(DX,2*WX);
                  end;
         ebModule:begin
                   DX:=3*WX;
                   Pt[1].X:=X+WX;
                   Pt[1].Y:=Y+WY;
                   Pt[2]:=Pt[1];
                   Pt[3].X:=X+2*WX-1;
                   Pt[3].Y:=Y+WY;
                   Pt[4]:=Pt[3];
                   Pt[5]:=Pt[4];
                   for N:=6 to 10 do
                    begin
                     Pt[N].X:=Pt[11-N].X;
                     Pt[N].Y:=2*Y+H-1-Pt[11-N].Y
                    end;
                   N:=10
                  end;
        end;
        if Left = ebModule then
         with Canvas do
          begin
           BeginPath(Handle);
           PolyBezier(Slice(Pt,N));
           CloseFigure(Handle);
           EndPath(Handle);
           SetPenAndBrush;
           StrokeAndFillPath(Handle)
          end;
        Inc(DX,X);
        inherited Paint(DX,Y);
        Inc(DX,W);
        case Right of
         ebRound:begin
                  Inc(DX,2*WX);
                  l_SymWidth := Round(H*0.195);
                  DrawSymbolOnCanvas(#$29, H, l_SymWidth, DX, Y + H div 2, 1.2, -0.1, 0.5);
                 end;
         ebSquare:begin
                   Inc(DX,2*WX);
                   l_SymWidth := Round(H*0.17);
                   DrawSymbolOnCanvas(#$005D, H, l_SymWidth, DX, Y + H div 2, 1.2, -0.1, 0.6);
                  end;
         ebFigure:begin
                   Inc(DX,2*WX);
                   l_SymWidth := Round(H*0.17);
                   DrawSymbolOnCanvas(#$007D, H, l_SymWidth, DX, Y + H div 2, 1.2, -0.1, 0.6);
                  end;
         ebModule:begin
                   Pt[1].X:=DX+WX;
                   Pt[1].Y:=Y+WY;
                   Pt[2]:=Pt[1];
                   Pt[3].X:=DX+2*WX-1;
                   Pt[3].Y:=Y+WY;
                   Pt[4]:=Pt[3];
                   Pt[5]:=Pt[4];
                   for N:=6 to 10 do
                    begin
                     Pt[N].X:=Pt[11-N].X;
                     Pt[N].Y:=2*Y+H-1-Pt[11-N].Y
                    end;
                   N:=10
                  end
        end;
         if Right = ebModule then
         with Canvas do
          begin
           BeginPath(Handle);
           PolyBezier(Slice(Pt,N));
           CloseFigure(Handle);
           EndPath(Handle);
           SetPenAndBrush;
           StrokeAndFillPath(Handle)
          end
       end
     end;

   function TExprBracketed.CalcCapDY;
    begin
     if IsBRacketed and ((Left<>ebNone) or (Right<>ebNone)) then
      Result:=0
     else
      Result:=inherited CalcCapDY;
    end;

   procedure TExprBracketed.CalcCapDX;
    begin
     if IsBRacketed and ((Left<>ebNone) or (Right<>ebNone)) then
      begin
       DLeft:=0;
       DRight:=0
      end
     else
      inherited CalcCapDX(DLeft,DRight)
    end;

   procedure TExprBracketed.RemoveBrackets;
    begin
     Left:=ebNone;
     Right:=ebNone;
     ToChange:=ToChange + [tcWidth, tcHeight, tcCapDX, tcCapDY];
    end;

   {TExprRound}

   constructor TExprRound.Create;
    begin
     inherited Create(ASon,ebRound,ebRound)
    end;

   function TExprRound.FTType;
    begin
     Result:=efLeft or efRight or efBrackets;
    end;

   {TExprExtSymbol}

   constructor TExprExtSymbol.Create(aSymbolCode:Integer);
    begin
     inherited Create;
     Symbol:=aSymbolCode;
    end;

   function TExprExtSymbol.CalcWidth;
    var Size:TSize;
        ABC:TABC;
     begin
      SetCanvasFont;
      GetTextExtentPoint32W(Canvas.Handle,@Symbol,1,Size);
      Result:=Size.CX;
      if GetCharABCWidths(Canvas.Handle,Symbol,Symbol,ABC) then
       begin
        if ABC.abcA<0 then
         Dec(Result,ABC.abcA);
        if ABC.abcC<0 then
         Dec(Result,ABC.abcC)
       end
     end;

   function TExprExtSymbol.CalcHeight;
    var Size:TSize;
     begin
      SetCanvasFont;
      GetTextExtentPoint32W(Canvas.Handle,@Symbol,1,Size);
      Result:=Size.CY
     end;

   procedure TExprExtSymbol.Paint;
    var ABC:TABC;
     begin
      SetCanvasFont;
      if GetCharABCWidths(Canvas.Handle,Symbol,Symbol,ABC) and (ABC.abcA<0) then
       TextOutW(Canvas.Handle,X-ABC.abcA,Y,@Symbol,1)
      else
       TextOutW(Canvas.Handle,X,Y,@Symbol,1)
     end;

   function TExprExtSymbol.CalcCapDY;
    var DY:Extended;
     begin
      case Symbol of
       913..929,931..937:DY:=4;
       945,947,949,951,953,954,956,957,959..961,963..969:DY:=8.8;
       946,948,950,952,955,958:DY:=4;
       esEllipsis:DY:=MaxInt/RWY-1;
      else
       DY:=0
      end;
      Result:=Round(DY*RWY);
     end;

   procedure TExprExtSymbol.CalcCapDX;
    var DX:Extended;
     begin
      case Symbol of
       913,915..929,931..937,952:DX:=1;
      else
       DX:=0
      end;
      DLeft:=Round(DX*RWX);
      case Symbol of
       913..929,931..937:DX:=-1;
       949:DX:=1;
       952:DX:=-0.5
      else
       DX:=0
      end;
      DRight:=Round(DX*RWX)
     end;

   function TExprExtSymbol.CalcPowerXPos;
    var DX:Integer;
     begin
      DX:=0;
      case Symbol of
       esPartDiff:DX:=2;
      end;
      Result:=inherited CalcPowerXPos+Round(DX*RWX)
     end;

   {TExprPlank}

   constructor TExprPlank.Create;
    begin
     inherited Create(295)
    end;

   procedure TExprPlank.SetCanvasFont;
    begin
     inherited SetCanvasFont;
     Canvas.Font.Style:=Canvas.Font.Style+[fsItalic]
    end;

   function TExprPlank.CalcCapDY;
    begin
     Result:=Round(4*RWY)
    end;

   procedure TExprPlank.CalcCapDX;
    begin
     DLeft:=Round(RWX);
     DRight:=DLeft
    end;

   {TExprSymbolSign}

   procedure TExprSymbolSign.SetCanvasFont;
   begin
    inherited;
    Canvas.Font.Name := 'Symbol';
   end;

   function TExprSymbolSign.SymbolStr: AnsiString;
   begin
    Result := AnsiChar(Symbol);
   end;

   procedure TExprSymbolSign.Paint;
     var
      l_S : AnsiString;
      ABC : TABC;
     begin
      SetCanvasFont;
      l_S := SymbolStr;
      if GetCharABCWidths(Canvas.Handle,Integer(l_S[1]),Integer(l_S[1]),ABC) and (ABC.abcA<0) then
       Canvas.TextOut(X-ABC.abcA,Y,l_S)
      else
       Canvas.TextOut(X,Y-2,l_S)
     end;

   function TExprSymbolSign.CalcWidth;
    var
     l_S : AnsiString;
     ABC : TABC;
    begin
     SetCanvasFont;
     l_S := SymbolStr;
     Result:=Canvas.TextWidth(l_S);
     if GetCharABCWidths(Canvas.Handle,Integer(l_S[1]),Integer(l_S[1]),ABC) and (ABC.abcA<0) then
      Dec(Result,ABC.abcA);
     if GetCharABCWidths(Canvas.Handle,Integer(l_S[Length(l_S)]),Integer(l_S[Length(l_S)]),ABC) and (ABC.abcC<0) then
      Dec(Result,ABC.abcC);
    end;

   {TExprSign}

   function TExprSign.CalcWidth;
    var
     l_S : AnsiString;
     ABC : TABC;
    begin
     SetCanvasFont;
     case Symbol of
      esMuchLess,esMuchGreater:Result:=Round(1.7*Canvas.TextWidth('<'));
      esApproxLess,esApproxGreater:Result:=Canvas.TextWidth('<');
      esPlusMinus,esMinusPlus:Result:=Canvas.TextWidth('+');
      esAlmostEqual:Result:=Canvas.TextWidth('~');
      esParallel:Result:=4*WX;
      esPerpendicular,esAngle:begin
                               Result:=Canvas.TextWidth('_');
                               if Odd(Result)<>Odd(WX) then
                                Inc(Result)
                              end;
     else
      Result:=inherited CalcWidth
     end;
     Inc(Result,4*WX)
    end;

   procedure TExprSign.Paint;
    var Y1,XL,XR,XC:Integer;
        TM:TTextMetric;
        Pt:array[1..4] of TPoint;
        GM:TGlyphMetrics;
        M2:TMat2;
        OM:TOutlineTextMetric;
     var
      l_S : AnsiString;
      ABC : TABC;
     begin
      SetCanvasFont;
      case Symbol of
       esMuchLess:begin
                   Canvas.TextOut(X+2*WX,Y,'<');
                   Canvas.TextOut(X+2*WX+Round(0.7*Canvas.TextWidth('<')),Y,'<')
                  end;
       esMuchGreater:begin
                      Canvas.TextOut(X+2*WX,Y,'>');
                      Canvas.TextOut(X+2*WX+Round(0.7*Canvas.TextWidth('>')),Y,'>')
                     end;
       esApproxLess:begin
                     Canvas.TextOut(X+2*WX,Y,'<');
                     Canvas.TextOut(X+2*WX,Y+Round(7*RWY),'~')
                    end;
       esApproxGreater:begin
                        Canvas.TextOut(X+2*WX,Y,'>');
                        Canvas.TextOut(X+2*WX,Y+Round(7*RWY),'~')
                       end;
       esPlusMinus:begin
                    Canvas.TextOut(X+2*WX,Y-WY,'+');
                    SetPenAndBrush;
                    l3ZeroMemory(@M2,SizeOf(M2));
                    M2.eM11.value:=1;
                    M2.eM22.value:=1;
                    l3ZeroMemory(@GM,SizeOf(GM));
                    GetGlyphOutline(Canvas.Handle,Cardinal('+'),GGO_Native,GM,0,nil,M2);
                    GetOutlineTextMetrics(Canvas.Handle,SizeOf(OM),@OM);
                    Y1:=Y+OM.otmTextMetrics.tmHeight-OM.otmTextMetrics.tmDescent-GM.gmptGlyphOrigin.y+GM.gmBlackBoxY;
                    Canvas.Rectangle(X+2*WX+GM.gmptGlyphOrigin.x,Y1,X+2*WX+GM.gmptGlyphOrigin.x+GM.gmBlackBoxX,Y1+WY)
                   end;
       esMinusPlus:begin
                    Canvas.TextOut(X+2*WX,Y+WY,'+');
                    SetPenAndBrush;
                    l3ZeroMemory(@M2,SizeOf(M2));
                    M2.eM11.value:=1;
                    M2.eM22.value:=1;
                    l3ZeroMemory(@GM,SizeOf(GM));
                    GetGlyphOutline(Canvas.Handle,Cardinal('+'),GGO_Native,GM,0,nil,M2);
                    GetOutlineTextMetrics(Canvas.Handle,SizeOf(OM),@OM);
                    Y1:=Y+OM.otmTextMetrics.tmHeight-OM.otmTextMetrics.tmDescent-GM.gmptGlyphOrigin.y-WY;
                    Canvas.Rectangle(X+2*WX+GM.gmptGlyphOrigin.x,Y1,X+2*WX+GM.gmptGlyphOrigin.x+GM.gmBlackBoxX,Y1+WY)
                   end;
       esAlmostEqual:begin
                      Canvas.TextOut(X+2*WX,Y-Round(4.5*RWY),'~');
                      SetPenAndBrush;
                      Y1:=Y+Round(15.5*RWY);
                      Canvas.Rectangle(X+2*WX+Round(0.5*RWX),Y1,X+Width-2*WX-Round(0.6*RWX),Y1+WY)
                     end;
       esParallel:begin
                   GetTextMetrics(Canvas.Handle,TM);
                   SetPenAndBrush;
                   Canvas.Rectangle(X+2*WX,Y+TM.tmDescent,X+3*WX,Y+TM.tmAscent+1);
                   Canvas.Rectangle(X+5*WX,Y+TM.tmDescent,X+6*WX,Y+TM.tmAscent+1)
                  end;
       esPerpendicular:begin
                        GetTextMetrics(Canvas.Handle,TM);
                        SetPenAndBrush;
                        XL:=X+2*WX;
                        XR:=X+Width-2*WX;
                        XC:=X+(Width-WX) div 2;
                        Canvas.Rectangle(XL,Y+TM.tmAscent+1-WY,XR,Y+TM.tmAscent+1);
                        Canvas.Rectangle(XC,Y+TM.tmDescent+Round(4*RWY),XC+WX,Y+TM.tmAscent+1)
                       end;
       esAngle:begin
                GetTextMetrics(Canvas.Handle,TM);
                SetPenAndBrush;
                XL:=X+2*WX;
                XR:=X+Width-2*WX;
                XC:=X+(Width) div 2;
                Canvas.Rectangle(XL,Y+TM.tmAscent+1-WY,XR,Y+TM.tmAscent+1);
                Pt[1]:=Point(XL,Y+TM.tmAscent+1-WY);
                Pt[2]:=Point(XC,Y+TM.tmDescent+Round(4*RWY));
                Pt[3]:=Point(Pt[2].X,Pt[2].Y+WY-1);
                Pt[4]:=Point(Pt[1].X,Pt[1].Y+WY-1);
                Canvas.Polygon(Pt)
               end;
      else
       inherited Paint(X+2*WX,Y)
      end
     end;

   function TExprSign.FTType;
    begin
     Result:=efNegative*Integer((Symbol=esMinus) or (Symbol=esPlusMinus) or (Symbol=esMinusPlus))
    end;

   function TExprSign.NeedBrackets;
    begin
     Result:=(Symbol=esMinus) or (Symbol=esPlus) or (Symbol=esPlusMinus) or (Symbol=esMinusPlus) or
             (Symbol=MyOpCode[opRoundPlus]) or (Symbol=MyOpCode[opRoundMul]);
    end;

   function TExprSign.CalcCapDY;
    begin
     Result:=MaxInt
    end;

   {TExprTwinParent}

   constructor TExprTwinParent.Create;
    begin
     inherited Create(ASon);
     Twin1:=FirstTwin;
     Twin2:=SecondTwin
    end;

   procedure TExprTwinParent.Release;
    begin
     l3Free(Twins[1]);
     l3Free(Twins[2]);
     inherited;
    end;

   procedure TExprTwinParent.SetTwins;
    begin
     l3Free(Twins[Index]);
     Twins[Index]:=Value;
     if Assigned(Twins[Index]) then
      with Twins[Index] do
       begin
        Parent:=Self;
        Font:=Self.Font;
        Font.Height:=Round(0.7*Font.Height);
        Canvas:=FCanvas
       end;
     ToChange:=tcAll;
    end;

   procedure TExprTwinParent.DynaSetFont;
    var TmpFont:TFont;
    begin
     inherited DynaSetFont;
     TmpFont:=TFont.Create;
     TmpFont.Assign(Font);
     TmpFont.Height:=Round(0.7*Font.Height);
     if Assigned(Twin1) then
      Twin1.Font:=TmpFont;
     if Assigned(Twin2) then
      Twin2.Font:=TmpFont;
     FreeAndNil(TmpFont);
    end;

   procedure TExprTwinParent.DynaSetCanvas;
    begin
     inherited DynaSetCanvas;
     if Assigned(Twin1) then
      Twin1.Canvas:=Canvas;
     if Assigned(Twin2) then
      Twin2.Canvas:=Canvas
    end;

   {TExprIndex}

   function TExprIndex.CalcWidth;
    var W1,W2,W3:Integer;
     begin
      W1:=Son.Width;
      if Assigned(Twin1) then
       W2:=Son.IndexXPos+Twin1.Width
      else
       W2:=0;
      if Assigned(Twin2) then
       W3:=Son.PowerXPos+Twin2.Width
      else
       W3:=0;
      Result:=MaxIntValue([W1,W2,W3])
     end;

   function TExprIndex.CalcHeight;
    begin
     Result:=Son.Height;
     if Assigned(Twin1) then
      Inc(Result,MaxIntValue([0,Twin1.Height-Result+Son.IndexYPos]));
     if Assigned(Twin2) then
      Inc(Result,MaxIntValue([0,Twin2.Height-Son.PowerYPos]))
    end;

   function TExprIndex.CalcMidLine;
    begin
     if Origin=eoTop then
      if not Assigned(Twin2) then
       Result:=Son.MidLineUp
      else
       Result:=Son.MidLineUp+MaxIntValue([0,Twin2.Height-Son.PowerYPos])
     else
      if not Assigned(Twin1) then
       Result:=Son.MidLineDn
      else
       Result:=Son.MidLineDn-MaxIntValue([0,Twin1.Height-Son.Height+Son.IndexYPos])
    end;

   function TExprIndex.CalcCapDY;
    begin
     if Assigned(Twin2) then
      Result:=Twin2.CapDY
     else
      Result:=Son.CapDY
    end;

   procedure TExprIndex.Paint;
    var DY:Integer;
     begin
      if Assigned(Twin2) then
       begin
        DY:=MaxIntValue([0,Twin2.Height-Son.PowerYPos]);
        Twin2.Draw(X+Son.PowerXPos,Y+DY+Son.PowerYPos,ehLeft,evBottom)
       end
      else
       DY:=0;
      Son.Draw(X,Y+DY,ehLeft,evTop);
      if Assigned(Twin1) then
       Twin1.Draw(X+Son.IndexXPos,Y+DY+Son.IndexYPos,ehLeft,evTop)
     end;

   function TExprIndex.ArgNeedBrackets;
    begin
     Result:=not (Son is TExprFuncName)
    end;

   function TExprIndex.FTType;
    begin
     FTType:=Son.FTType or efRight
    end;

   {TExprArgument}

   constructor TExprArgument.Create;
    begin
     inherited Create(ASon,ebRound,ebRound);
     ForcedBrackets:=False
    end;

   function TExprArgument.IsBracketed;
    var P:Tl3Expr;
     begin
      if (ForcedBrackets) or ((Parent is TExprCommonFunc) and (TExprCommonFunc(Parent).ArgumentNeedBrackets)) then
       Result:=True
      else
       begin
        P:=Son;
        while Assigned(P) do
         begin
          if P.NeedBrackets then
           begin
            Result:=True;
            Exit
           end;
          P:=P.Next
         end;
        Result:=False;
       end
     end;

   procedure TExprArgument.SetBrackets;
    begin
     ForcedBrackets:=True;
     ToChange:=tcAll;
    end;

   {TExprCommonFunc}

   function TExprCommonFunc.CalcWidth;
    begin
     Result:=Son.Width;
     Inc(Result,3*WX+Daughter.Width);
    end;

   function TExprCommonFunc.CalcHeight;
    begin
     Result:=MidLineUp-MidLineDn+1
    end;

   function TExprCommonFunc.CalcMidLine;
    begin
     if Origin=eoTop then
      Result:=MaxIntValue([Son.MidLineUp,Daughter.MidLineUp])
     else
      Result:=MinIntValue([Son.MidLineDn,Daughter.MidLineDn])
    end;

   procedure TExprCommonFunc.Paint;
    var DX,DY:Integer;
     begin
      DY:=Y+MidLineUp-Son.MidLineUp;
      Son.Draw(X,DY,ehLeft,evTop);
      DX:=X+3*WX+Son.Width;
      DY:=Y+MidLineUp-Daughter.MidLineUp;
      Daughter.Draw(DX,DY,ehLeft,evTop)
     end;

   function TExprCommonFunc.FTType;
    begin
     Result:=efLeft+efRight*Integer(Daughter.FTType and efBrackets>0)
    end;

   function TExprCommonFunc.ArgumentNeedBrackets;
    begin
     Result:=Son.ArgNeedBrackets
    end;

   {TExprFuncName}

   function TExprFuncName.ArgNeedBrackets;
    begin
     Result:=False
    end;

   {TExprFunc}

   constructor TExprFunc.Create;
    begin
     inherited Create(nil,ADaughter);
     if Length(FuncName)=1 then
      Son:=TExprVar.Create(FuncName)
     else
      Son:=TExprFuncName.Create(FuncName)
    end;

   {TExprBase}

   constructor TExprBase.Create;
    begin
     inherited Create(ASon,ebRound,ebRound)
    end;

   function TExprBase.IsBracketed;
    begin
     Result:=Assigned(Son.Next)
    end;

   {TExprComma}

   constructor TExprComma.Create;
    begin
     inherited Create(44)
    end;

   function TExprComma.NeedBrackets;
    begin
     Result:=True
    end;

   function TExprComma.CalcCapDY;
    begin
     Result:=MaxInt
    end;

   {TExprLim}

   procedure TExprLim.SetSonFont;
    var TmpFont:TFont;
     begin
      if Assigned(Son) then
       begin
        TmpFont:=TFont.Create;
        TmpFont.Assign(Font);
        TmpFont.Height:=Round(0.7*Font.Height);
        Son.Font:=TmpFont;
        FreeAndNil(TmpFont);
       end
     end;

   procedure TExprLim.SetSonCanvas;
    begin
     if Assigned(Son) then
      Son.Canvas:=Canvas
    end;

   function TExprLim.CalcWidth;
    begin
     SetCanvasFont;
     Result:=Canvas.TextWidth('lim');
     Result:=MaxIntValue([Result,Son.Width])
    end;

   function TExprLim.CalcHeight;
    begin
     SetCanvasFont;
     Result:=Canvas.TextHeight('lim');
     Inc(Result,Son.Height)
    end;

   function TExprLim.CalcMidLine;
    var H:Integer;
     begin
      SetCanvasFont;
      H:=Canvas.TextHeight('lim');
      if Origin=eoTop then
       Result:=H div 2
      else
       Result:=-((H-1) div 2)-Son.Height
     end;

   procedure TExprLim.Paint;
    var W2:Integer;
        LSize:TSize;
     begin
      SetCanvasFont;
      LSize:=Canvas.TextExtent('lim');
      W2:=Son.Width;
      SetCanvasFont;
      Canvas.TextOut(X+MaxIntValue([0,(W2-LSize.CX) div 2]),Y,'lim');
      Son.Draw(X+MaxIntValue([0,(LSize.CX-W2) div 2]),Y+LSize.CY,ehLeft,evTop)
     end;

   function TExprLim.ArgNeedBrackets;
    begin
     Result:=False
    end;

   {TExprSpace}

   constructor TExprSpace.Create;
    begin
     inherited Create;
     N:=Space
    end;

   function TExprSpace.CalcWidth;
    begin
     Result:=N*WX
    end;

   {TExprStrokes}

   constructor TExprStrokes.Create;
    begin
     inherited Create;
     N:=Strokes
    end;

   function TExprStrokes.CalcWidth;
    begin
     Result:=WX*(4*N+2)
    end;

   function TExprStrokes.CalcHeight;
    begin
     SetCanvasFont;
     Result:=Round(0.6*Canvas.TextHeight('A'))
    end;

   procedure TExprStrokes.Paint;
    var I:Integer;
        Pt:array[1..3] of TPoint;
     begin
      SetPenAndBrush;
      Pt[1].X:=X+2*WX;
      Pt[1].Y:=Y+Round(2*RWY);
      Pt[2].X:=X+4*WX-1;
      Pt[2].Y:=Pt[1].Y;
      Pt[3].X:=X+2*WX;
      Pt[3].Y:=Pt[1].Y+6*WY-1;
      for I:=1 to N do
       begin
        Canvas.Polygon(Pt);
        Inc(Pt[1].X,4*WX);
        Inc(Pt[2].X,4*WX);
        Inc(Pt[3].X,4*WX)
       end;
     end;

   {TExprAtValue}

   procedure TExprAtValue.SetDaughterFont;
    var TmpFont:TFont;
     begin
      if Assigned(Daughter) then
       begin
        TmpFont:=TFont.Create;
        TmpFont.Assign(Font);
        TmpFont.Height:=Round(0.7*Font.Height);
        Daughter.Font:=TmpFont;
        FreeAndNil(TmpFont);
       end
     end;

   procedure TExprAtValue.SetDaughterCanvas;
    begin
     if Assigned(Daughter) then
      Daughter.Canvas:=Canvas
    end;

   function TExprAtValue.CalcWidth;
    begin
     Result:=Son.Width+3*WX+Daughter.Width
    end;

   function TExprAtValue.CalcHeight;
    begin
     Result:=MaxIntValue([Son.Height,Daughter.Height])
    end;

   function TExprAtValue.CalcMidLine;
    var DH:Integer;
     begin
      DH:=MaxIntValue([0,Daughter.Height-Son.Height]);
      if Origin=eoTop then
       Result:=Son.MidLineUp+DH
      else
       Result:=Son.MidLineDn
     end;

   procedure TExprAtValue.Paint;
    var H1,H2,DH,W:Integer;
     begin
      H1:=Son.Height;
      H2:=Daughter.Height;
      DH:=MaxIntValue([0,H2-H1]);
      H1:=MaxIntValue([H1,H2]);
      Son.Draw(X,Y+DH,ehLeft,evTop);
      W:=X+Son.Width;
      SetPenAndBrush;
      Canvas.Rectangle(W,Y,W+WX,Y+H1);
      Daughter.Draw(W+3*WX,Y+H1,ehLeft,evBottom)
     end;

   function TExprAtValue.FTType;
    begin
     if Son.FTType and efLeft>0 then
      Result:=efLeft
     else
      Result:=0
    end;

   {TExprCap}

   constructor TExprCap.Create;
    begin
     inherited Create(ASon);
     Style:=CapStyle;
     N:=Count
    end;

   function TExprCap.CalcWidth;
    var DLeft,DRight,W,CX:Integer;
     begin
      Result:=Son.Width;
      DLeft:=Son.CapDXLeft;
      DRight:=Son.CapDXRight;
      if Style in [ecVector,ecLine] then
       begin
        if DLeft<0 then
         Dec(Result,DLeft);
        if DRight>0 then
         Inc(Result,DRight)
       end
      else
       begin
        W:=CapWidth div 2;
        CX:=(DLeft+DRight+Result) div 2;
        Result:=MaxIntValue([CX,W])+MaxIntValue([Result-CX,W])
       end
     end;

   function TExprCap.CalcHeight;
    begin
     Result:=Son.Height+SelfHeight
    end;

   function TExprCap.CalcMidLine;
    begin
     if Origin=eoTop then
      Result:=Son.MidLineUp+SelfHeight
     else
      Result:=Son.MidLineDn
    end;

   function TExprCap.CalcPowerXPos;
    begin
     if Width=Son.Width then
      Result:=Son.PowerXPos
     else
      Result:=inherited CalcPowerXPos
    end;

   function TExprCap.CalcPowerYPos;
    begin
     Result:=Son.PowerYPos+SelfHeight
    end;

   function TExprCap.CalcIndexXPos;
    var DL,DX:Integer;
     begin
      DL:=Son.GetCapDXLeft;
      if Style in [ecPoints,ecCap,ecTilde,ecCircle,ecRDQ,ecLDQ,ecDQ,ecRSQ, ecLSQ, ecSQ] then
       DX:=MaxIntValue([CapWidth div 2-(DL+Son.Width+Son.GetCapDXRight) div 2,0])
      else
       DX:=MaxIntValue([0,-DL]);
      Result:=Son.CalcIndexXPos+DX
     end;

   function TExprCap.CapWidth;
    begin
     SetCanvasFont;
     case Style of
      ecPoints:Result:=WX*(4*N-2);
      ecCap:Result:=Canvas.TextWidth('^');
      ecTilde:Result:=Canvas.TextWidth('~');
      ecCircle: Result := Canvas.TextWidth('°');
      ecRDQ: Result := Canvas.TextWidth(cc_RDoubleQuote);
      ecLDQ: Result := Canvas.TextWidth(cc_LDoubleQuote);
      ecDQ: Result := Canvas.TextWidth(cc_DoubleQuote);

      ecRSQ: Result := Canvas.TextWidth(cc_RSingleQuote);
      ecLSQ: Result := Canvas.TextWidth(cc_LSingleQuote);
      ecSQ: Result := Canvas.TextWidth(cc_SingleQuote);
     end
    end;

   function TExprCap.CapHeight;
    begin
     case Style of
      ecPoints:Result:=5*WY;
      ecVector:Result:=6*WY;
      ecCap:Result:=11*WY;
      ecTilde:Result:=6*WY;
      ecLine:Result:=4*WY;
      ecCircle:Result:=10*WY;
      ecRDQ,
      ecLDQ,
      ecDQ:
       Result:=5*WY;
      ecRSQ,
      ecLSQ,
      ecSQ:
       Result:=5*WY;
     else
      Result:=0
     end
    end;

   function TExprCap.SelfHeight;
    begin
     Result:=MaxIntValue([0,CapHeight-Son.CapDY])
    end;

   function TExprCap.CalcCapDY;
    begin
     Result:=MaxIntValue([0,Son.CapDY-CapHeight])
    end;

   procedure TExprCap.Paint;
    var DY,DX,W,DLEft,DRight:Integer;
        LX,RX:Integer;
        Pt:array[1..8] of TPoint;
        TW,CX:Integer;
        I:Integer;
     begin
      DY:=Y+SelfHeight;
      DLeft:=Son.CapDXLeft;
      DRight:=Son.CapDXRight;
      W:=Width;
      if Style in [ecPoints,ecCap,ecTilde, ecCircle, ecRDQ, ecLDQ, ecDQ, ecRSQ, ecLSQ, ecSQ] then
       begin
        TW:=CapWidth div 2;
        CX:=(DLeft+Son.Width+DRight) div 2;
        DX:=MaxIntValue([TW-CX,0])
       end
      else
       DX:=MaxIntValue([0,-DLeft]);
      Son.Draw(X+DX,DY,ehLeft,evTop);
      Inc(DY,Son.CapDY-WY);
      SetPenAndBrush;
      SetBkMode(Canvas.Handle,Transparent);
      LX:=X+MaxIntValue([0,DLeft]);
      RX:=X+W+MinIntValue([0,DRight]);
      case Style of
       ecPoints:begin
                 for I:=0 to N-1 do
                  begin
                   LX:=X+DX+CX-TW;
                   RX:=LX+2*WX;
                   Canvas.Ellipse(LX+4*WX*I,DY-3*WY,RX+4*WX*I,DY-WY)
                  end
                end;
       ecVector:if Odd(WY) then
                 begin
                  Pt[1].X:=LX;
                  Pt[1].Y:=DY-3*WY;
                  Pt[2].X:=RX-2*WY;
                  Pt[2].Y:=Pt[1].Y;
                  Pt[3].X:=Pt[2].X;
                  Pt[3].Y:=Pt[2].Y-WY;
                  Pt[4].X:=RX-1;
                  Pt[4].Y:=Pt[2].Y+WY div 2;
                  Pt[5].X:=Pt[3].X;
                  Pt[5].Y:=Pt[3].Y+3*WY-1;
                  Pt[6].X:=Pt[5].X;
                  Pt[6].Y:=Pt[5].Y-WY;
                  Pt[7].X:=Pt[1].X;
                  Pt[7].Y:=Pt[6].Y;
                  Canvas.Polygon(Slice(Pt,7))
                 end
                else
                 begin
                  Pt[1].X:=LX;
                  Pt[1].Y:=DY-3*WY;
                  Pt[2].X:=RX-2*WY;
                  Pt[2].Y:=Pt[1].Y;
                  Pt[3].X:=Pt[2].X;
                  Pt[3].Y:=Pt[2].Y-WY;
                  Pt[4].X:=RX-1;
                  Pt[4].Y:=Pt[2].Y+WY div 2-1;
                  Pt[5].X:=Pt[4].X;
                  Pt[5].Y:=Pt[4].Y+1;
                  Pt[6].X:=Pt[3].X;
                  Pt[6].Y:=Pt[3].Y+3*WY-1;
                  Pt[7].X:=Pt[6].X;
                  Pt[7].Y:=Pt[6].Y-WY;
                  Pt[8].X:=Pt[1].X;
                  Pt[8].Y:=Pt[7].Y;
                  Canvas.Polygon(Pt)
                 end;
       ecCap:begin
              SetCanvasFont;
              Canvas.TextOut(X+DX+CX-TW,DY-Round(15*RWY),'^');
             end;
       ecTilde:begin
                SetCanvasFont;
                Canvas.TextOut(X+DX+CX-TW,DY-Round(18.5*RWY),'~');
               end;
       ecLine:begin
               SetCanvasFont;
               Canvas.Rectangle(LX,DY-2*WY,RX,DY-WY);
              end;
       ecCircle:begin
                 SetCanvasFont;
                 Canvas.TextOut(X+DX+CX-TW,DY-Round(14*RWY),'°');
                end;
       ecRDQ:begin
                 SetCanvasFont;
                 Canvas.TextOut(X+DX+CX-TW,DY-Round(12*RWY),cc_RDoubleQuote);
                end;
       ecLDQ:begin
                 SetCanvasFont;
                 Canvas.TextOut(X+DX+CX-TW,DY-Round(12*RWY),cc_LDoubleQuote);
                end;
       ecDQ:begin
                 SetCanvasFont;
                 Canvas.TextOut(X+DX+CX-TW,DY-Round(12*RWY),cc_DoubleQuote);
                end;
       ecRSQ:begin
                 SetCanvasFont;
                 Canvas.TextOut(X+DX+CX-TW,DY-Round(12*RWY),cc_RSingleQuote);
                end;
       ecLSQ:begin
                 SetCanvasFont;
                 Canvas.TextOut(X+DX+CX-TW,DY-Round(12*RWY),cc_LSingleQuote);
                end;
       ecSQ:begin
                 SetCanvasFont;
                 Canvas.TextOut(X+DX+CX-TW,DY-Round(12*RWY),cc_SingleQuote);
                end;
      end
     end;

   function TExprCap.FTType;
    begin
     Result:=Son.FTType
    end;

   {TExprStand}

   constructor TExprStand.Create;
    begin
     inherited Create(ASon);
     Alg:=Align
    end;

   function TExprStand.CalcWidth;
    var P:Tl3Expr;
     begin
      Result:=Son.Width;
      P:=Son.Next;
      while Assigned(P) do
       begin
        Result:=MaxIntValue([Result,P.Width]);
        P:=P.Next
       end
     end;

   function TExprStand.CalcHeight;
    var P:Tl3Expr;
     begin
      Result:=Son.Height;
      P:=Son.Next;
      while Assigned(P) do
       begin
        Inc(Result,P.Height);
        P:=P.Next
       end
     end;

   procedure TExprStand.Paint;
    var P:Tl3Expr;
        W:Integer;
     begin
      W:=Width;
      P:=Son;
      while Assigned(P) do
       begin
        case Alg of
         ehLeft:P.Draw(X,Y,ehLeft,evTop);
         ehCenter:P.Draw(X+W div 2,Y,ehCenter,evTop);
         ehRight:P.Draw(X+W,Y,ehRight,evTop)
        end;
        Inc(Y,P.Height);
        P:=P.Next
       end
     end;

   {TExprMatrix}

   constructor TExprMatrix.Create;
    begin
     inherited Create(ASon);
     HS:=HorSize;
     VS:=VertSize
    end;

   procedure TExprMatrix.GetCellSize;
    var P:Tl3Expr;
        Over,Above:Integer;
     begin
      CX:=0;
      Over:=0;
      Above:=0;
      P:=Son;
      while Assigned(P) do
       with P do
        begin
         Over:=MaxIntValue([Over,MidLineUp+1]);
         Above:=MaxIntValue([Above,Height-MidLineUp-1]);
         CX:=MaxIntValue([CX,Width]);
         P:=Next
        end;
      CY:=Over+Above
     end;

   function TExprMatrix.GetCellWidth;
    begin
     if tcCellSize in ToChange then
      begin
       GetCellSize(FCX,FCY);
       ToChange:=ToChange - [tcCellSize]
      end;
     Result:=FCX
    end;

   function TExprMatrix.GetCellHeight;
    begin
     if tcCellSize in ToChange then
      begin
       GetCellSize(FCX,FCY);
       ToChange:=ToChange - [tcCellSize]
      end;
     Result:=FCY
    end;

   function TExprMatrix.CalcWidth;
    begin
     Result:=GetCellWidth*HS+WX*(4+6*(HS-1))
    end;

   function TExprMatrix.CalcHeight;
    begin
     Result:=GetCellHeight*VS
    end;

   procedure TExprMatrix.Paint;
    var CX,CY:Integer;
        DX:Integer;
        I,J:Integer;
        P:Tl3Expr;
     begin
      GetCellSize(CX,CY);
      CX:=GetCellWidth;
      CY:=GetCellHeight;
      P:=Son;
      Inc(Y,CY div 2);
      for J:=0 to VS-1 do
       begin
        DX:=X+2*WX+CX div 2;
        for I:=0 to HS-1 do
         if Assigned(P) then
          begin
           P.Draw(DX,Y,ehCenter,evCenter);
           P:=P.Next;
           Inc(DX,CX+6*WX)
          end;
        Inc(Y,CY)
       end
     end;

   {TExprGroupOp}

   constructor TExprGroupOp.Create;
    begin
     inherited Create(ASon,FirstTwin,SecondTwin);
     FSymbolHeight:=0;
     FSymbolWidth:=0
    end;

   function TExprGroupOp.CalcSymbolHeight;
    var H:Integer;
        P:Tl3Expr;
     begin
      if (Son is TExprChain) and (Son.FTType and efRoundBrackets=0) then
       begin
        P:=TExprChain(Son).Son;
        while Assigned(P) do
         begin
          if P is TExprGroupOp then
           begin
            Result:=TExprGroupOp(P).GetSymbolHeight;
            Exit
           end;
          P:=P.Next
         end
       end;
      if Son is TExprGroupOp then
       Result:=TExprGroupOp(Son).GetSymbolHeight
      else
       begin
        H:=MaxIntValue([Son.MidLineUp,-Son.MidLineDn]);
        SetCanvasFont;
        Result:=Round(2.25*MaxIntValue([H,Canvas.TextHeight('A') div 2]))
       end
     end;

   function TExprGroupOp.GetSymbolWidth;
    begin
     if tcSymbolWidth in ToChange then
      begin
       FSymbolWidth:=CalcSymbolWidth;
       ToChange:=ToChange - [tcSymbolWidth]
      end;
     Result:=FSymbolWidth
    end;

   function TExprGroupOp.GetSymbolHeight;
    begin
     if tcSymbolHeight in ToChange then
      begin
       FSymbolHeight:=CalcSymbolHeight;
       ToChange:=ToChange - [tcSymbolHeight]
      end;
     Result:=FSymbolHeight
    end;

   function TExprGroupOp.CalcWidth;
    var W1,W2:Integer;
     begin
      if Assigned(Twin1) then
       W1:=Twin1.Width
      else
       W1:=0;
      if Assigned(Twin2) then
       W2:=Twin2.Width
      else
       W2:=0;
      Result:=MaxIntValue([W1,W2,GetSymbolWidth])+Son.Width+5*WX
     end;

   function TExprGroupOp.CalcHeight;
    var H1,H2,SH1,SH2:Integer;
     begin
      if Son is TExprGroupOp then
       with TExprGroupOp(Son) do
        begin
         if Assigned(Twin1) then
          SH1:=Twin1.Height
         else
          SH1:=0;
         if Assigned(Twin2) then
          SH2:=Twin2.Height
         else
          SH2:=0
        end
      else
       begin
        SH1:=0;
        SH2:=0
       end;
      if Assigned(Twin1) then
       H1:=Twin1.Height
      else
       H1:=2*WY;
      if Assigned(Twin2) then
       H2:=Twin2.Height
      else
       H2:=2*WY;
      Result:=GetSymbolHeight+MaxIntValue([H1,SH1])+MaxIntValue([H2,SH2])
     end;

   function TExprGroupOp.CalcMidLine;
    var H,SH:Integer;
     begin
      if Origin=eoTop then
       begin
        if (Son is TExprGroupOp) and Assigned(TExprGroupOp(Son).Twin2) then
         SH:=TExprGroupOp(Son).Twin2.Height
        else
         SH:=0;
        if Assigned(Twin2) then
         H:=Twin2.Height
        else
         H:=2*WY;
        Result:=GetSymbolHeight div 2+MaxIntValue([H,SH])
       end
      else
       begin
        if (Son is TExprGroupOp) and Assigned(TExprGroupOp(Son).Twin1) then
         SH:=TExprGroupOp(Son).Twin1.Height
        else
         SH:=0;
        if Assigned(Twin1) then
         H:=Twin1.Height
        else
         H:=2*WY;
        Result:=-((GetSymbolHeight-1) div 2+MaxIntValue([H,SH]))
       end
     end;

   procedure TExprGroupOp.Paint;
    var W1,W2,H,HS:Integer;
     begin
      if Assigned(Twin1) then
       W1:=Twin1.Width
      else
       W1:=0;
      if Assigned(Twin2) then
       W2:=Twin2.Width
      else
       W2:=0;
      W1:=MaxIntValue([W1,W2,GetSymbolWidth]);
      W2:=X+W1 div 2+2*WX;
      H:=MidLineUp;
      HS:=GetSymbolHeight div 2;
      if Assigned(Twin2) then
       Twin2.Draw(W2,Y+H-HS,ehCenter,evBottom);
      if Assigned(Twin1) then
       Twin1.Draw(W2,Y+H+HS,ehCenter,evTop);
      DrawSymbol(W2,Y+H);
      Son.Draw(X+W1+5*WX,Y+H,ehLeft,evCenter);
     end;

   {TExprSumma}

   function TExprSumma.CalcSymbolWidth;
    begin
     Result:=Round(GetSymbolHeight*0.739*GetDeviceCaps(Canvas.Handle,LogPixelSX)/GetDeviceCaps(Canvas.Handle,LogPixelSY))
    end;

   procedure TExprSumma.DrawSymbol;
   var
    H: Integer;
   begin
    H:=GetSymbolHeight;
    DrawSymbolOnCanvas( #8721, H, 0, X, Y, 1.2, -0.09);
   end;

   {TExprProd}

   function TExprProd.CalcSymbolWidth;
    begin
     Result:=Round(GetSymbolHeight*0.8561*GetDeviceCaps(Canvas.Handle,LogPixelSX)/GetDeviceCaps(Canvas.Handle,LogPixelSY))
    end;

   procedure TExprProd.DrawSymbol;
   var
    H:Integer;
   begin
    H:=GetSymbolHeight;
    DrawSymbolOnCanvas( #$220F, H, 0, X, Y, 1.2, -0.07);
    Exit;
   end;

   {TExprCirc}

   function TExprCirc.CalcSymbolWidth;
    begin
     Result:=Round(GetSymbolHeight*0.2687*GetDeviceCaps(Canvas.Handle,LogPixelSX)/GetDeviceCaps(Canvas.Handle,LogPixelSY))
    end;

   procedure TExprCirc.DrawSymbol(X,Y:Integer);
   var
    H: Integer;
   begin
    H:=GetSymbolHeight;
    DrawSymbolOnCanvas( #8747, H, 0, X, Y, 1.15, 0.06);
    DrawSymbolOnCanvas( #$25CB, H, 0, X, Y, 0.8, -0.03, 0.015);
   end;

   {TExprIntegral}

   const
    c_IntegralWidthCoeff: Double = 0.267;

   constructor TExprIntegral.Create;
    begin
     inherited Create(ASon,FirstTwin,SecondTwin);
     K:=Mult
    end;

   function TExprIntegral.CalcSymbolWidth;
    var Size:TSize;
        Ch:WideChar;
     begin
      Result:=Round(GetSymbolHeight*c_IntegralWidthCoeff*GetDeviceCaps(Canvas.Handle,LogPixelSX)/GetDeviceCaps(Canvas.Handle,LogPixelSY));
      if K<1 then
       begin
        Ch:=WideChar(8230);
        GetTextExtentPoint32W(Canvas.Handle,@Ch,1,Size);
        Result:=3*Result+4*WX+Size.CX
       end
      else
       Result:=Result*K+WX*(K-1)
     end;

   procedure TExprIntegral.DrawSymbol;
   var
    I:Integer;
    H,W,HW:Integer;
    Ch:WideChar;

    procedure DrawOneIntegral(aCurX: Integer);
    begin
     DrawSymbolOnCanvas( #8747, H, 0, aCurX, Y, 1.15, 0.06, 0.3);
    end;

   begin
    H:=GetSymbolHeight;
    HW:=Round(H*c_IntegralWidthCoeff*GetDeviceCaps(Canvas.Handle,LogPixelSX)/GetDeviceCaps(Canvas.Handle,LogPixelSY));
    W:=GetSymbolWidth;

    Dec(X,W div 2);
    if K<1 then
    begin
     DrawOneIntegral(X);
     DrawOneIntegral(X+HW+WX);
     Ch:=WideChar(8230);
     SetBkMode(Canvas.Handle,Transparent);
     TextOutW(Canvas.Handle,X+2*HW+3*WX,Y+(H div 2)-Canvas.TextHeight('A'),@Ch,1);
     DrawOneIntegral(X+W-HW);
    end
    else
     for I:=0 to K-1 do
      DrawOneIntegral(X+I*(HW+WX));
   end;

   {TExprLambda}

   constructor TExprLambda.Create;
    begin
     inherited Create(955)
    end;

   procedure TExprLambda.Paint;
    var DY:Integer;
     begin
      inherited Paint(X,Y);
      DY:=Y+Round(9*RWY);
      SetPenAndBrush;
      Canvas.Rectangle(X+Round(1.5*RWX),DY,X+Width-Round(2*RWX),DY+WY)
     end;

   {TExprNabla}

   constructor TExprNabla.Create;
    begin
     inherited Create(916)
    end;

   procedure TExprNabla.Paint;
    var LF:TLogFont;
        NewFont,OldFont:HFont;
        Size:TSize;
     begin
      with LF,Font do
       begin
        lfHeight:=-MulDiv(GetDeviceCaps(Canvas.Handle,LogPixelSY),Font.Size,72);
        lfWidth:=0;
        lfEscapement:=1800;
        lfOrientation:=1800;
        if fsBold in Style then
         lfWeight:=FW_Bold
        else
         lfWeight:=FW_Normal;
        lfItalic:=Byte(fsItalic in Style);
        lfUnderline:=Byte(fsUnderline in Style);
        lfStrikeOut:=Byte(fsStrikeOut in Style);
        lfCharSet:=Byte(CharSet);
        lfOutPrecision:=Out_Default_Precis;
        lfClipPrecision:=Clip_Default_Precis;
        lfQuality:=Default_Quality;
        case Pitch of
         fpVariable:lfPitchAndFamily:=Variable_Pitch;
         fpFixed:lfPitchAndFamily:=Fixed_Pitch
        else
         lfPitchAndFamily:=Default_Pitch
        end;
        StrPCopy(lfFaceName,Name)
       end;
      SetBkMode(Canvas.Handle,Transparent);
      NewFont:=CreateFontIndirect(LF);
      OldFont:=SelectObject(Canvas.Handle,NewFont);
      SetTextColor(Canvas.Handle,ColorToRGB(Color));
      GetTextExtentPoint32W(Canvas.Handle,#916,1,Size);
      TextOutW(Canvas.Handle,X+Size.CX,Y+Size.CY,#916,1);
      SelectObject(Canvas.Handle,OldFont);
      DeleteObject(NewFont)
     end;

   {TExprAsterix}

   constructor TExprAsterix.Create;
    begin
     inherited Create('*')
    end;

   procedure TExprAsterix.Paint;
    begin
     SetCanvasFont;
     Canvas.TextOut(X,Y+Round(8*RWY),'*')
    end;

   {TExprCase}

   function TExprCase.CalcWidth;
    var W1,W2,I:Integer;
        P:Tl3Expr;
     begin
      W1:=0;
      W2:=0;
      P:=Son;
      I:=1;
      while Assigned(P) do
       begin
        if Odd(I) then
         W1:=MaxIntValue([W1,P.Width])
        else
         W2:=MaxIntValue([W2,P.Width]);
        Inc(I);
        P:=P.Next
       end;
      Result:=18*WX+W1+W2
     end;

   function TExprCase.CalcHeight;
    var H1,H2,I:Integer;
        P:Tl3Expr;
     begin
      Result:=0;
      P:=Son;
      I:=1;
      while Assigned(P) do
       begin
        if Odd(I) then
         begin
          H1:=P.MidLineUp;
          H2:=-P.MidLineDn
         end
        else
         begin
          Inc(Result,MaxIntValue([H1,P.MidLineUp]));
          Inc(Result,MaxIntValue([H2,-P.MidLineDn]));
          if Assigned(P.Next) then
           Inc(Result,2*WY)
         end;
        Inc(I);
        P:=P.Next
       end;
      if not Odd(Result) then
       Inc(Result)
     end;

   procedure TExprCase.Paint;
    var KH,I,H,W,H1,H2,DX:Integer;
        Pt:array[1..46] of TPoint;
        P,PP:Tl3Expr;
     begin
      H:=Height;
      W:=X+Width;
      KH:=(H-11*WY) div 2+1;
      Pt[1].X:=X+WX;
      Pt[1].Y:=Y+KH+5*WY-1;
      Pt[2].X:=X+2*WX-1;
      Pt[2].Y:=Y+KH+5*WY-1;
      Pt[3].X:=X+3*WX;
      Pt[3].Y:=Y+KH+4*WY-2;
      Pt[4].X:=Pt[3].X;
      Pt[4].Y:=Y+KH+3*WY-1;
      Pt[5]:=Pt[4];
      Pt[6].X:=Pt[5].X;
      Pt[6].Y:=Y+3*WY-1;
      Pt[7]:=Pt[6];
      Pt[8].X:=Pt[7].X;
      Pt[8].Y:=Y+WY;
      Pt[9].X:=Pt[7].X+WX;
      Pt[9].Y:=Y+WY;
      Pt[10].X:=X+7*WX-1;
      Pt[10].Y:=Y+WY;
      Pt[11]:=Pt[10];
      Pt[12].X:=Pt[10].X;
      Pt[12].Y:=Y+2*WY-1;
      Pt[13]:=Pt[12];
      Pt[14].X:=X+5*WX-1;
      Pt[14].Y:=Y+2*WY-1;
      Pt[15]:=Pt[14];
      Pt[16].X:=X+5*WX-1;
      Pt[16].Y:=Y+3*WY-1;
      Pt[17]:=Pt[16];
      Pt[18].X:=Pt[17].X;
      Pt[18].Y:=Y+KH+3*WY-1;
      Pt[19].X:=Pt[18].X;
      Pt[19].Y:=Pt[4].Y;
      Pt[20].X:=Pt[19].X;
      Pt[20].Y:=Pt[3].Y-WY;
      Pt[21].X:=X+5*WX-2;
      Pt[21].Y:=Pt[2].Y;
      Pt[22].X:=X+3*WX-1;
      Pt[22].Y:=Pt[1].Y;
      Pt[23]:=Pt[22];
      for I:=24 to 46 do
       begin
        Pt[I].X:=Pt[47-I].X;
        Pt[I].Y:=2*Y+H-1-Pt[47-I].Y
       end;
      BeginPath(Canvas.Handle);
      Canvas.PolyBezier(Pt);
      EndPath(Canvas.Handle);
      SetPenAndBrush;
      StrokeAndFillPath(Canvas.Handle);
      DX:=X+7*WX;
      H:=Y;
      P:=Son;
      I:=1;
      while Assigned(P) do
       begin
        if Odd(I) then
         begin
          H1:=P.MidLineUp;
          H2:=-P.MidLineDn;
          PP:=P;
         end
        else
         begin
          H1:=MaxIntValue([H1,P.MidLineUp]);
          H2:=MaxIntValue([H2,-P.MidLineDn]);
          Inc(H,H1);
          PP.Draw(DX,H,ehLeft,evCenter);
          P.Draw(W,H,ehRight,evCenter);
          Inc(H,H2);
          Inc(H,2*WY)
         end;
        Inc(I);
        P:=P.Next
       end
     end;

   {TExprEmpty}

   function TExprEmpty.CalcHeight;
    begin
     SetCanvasFont;
     Result:=Canvas.TextHeight('A')
    end;

constructor TExprContainer.Create(aSon: Tl3Expr);
begin
 inherited Create(aSon);
 if (aSon Is TExprUnicode) then
 begin
  f_Padding := 0;
  f_XOfs := 1;
  f_YOfs := 1;
  f_WidthDelta := 1;
 end//aSon Is TExprUnicode
 else
 begin
  f_Padding := 5;
  f_XOfs := 0;
  f_YOfs := 0;
  f_WidthDelta := 0;
 end;//aSon Is TExprUnicode
 f_ForWMF := False;
end;

function TExprContainer.CalcWidth: Integer;
var
 l_Pad: Integer;
begin
 l_Pad := l3MulDiv(Son.Height, f_Padding, 100);
 Result := Son.Width + l_Pad*{$IfDef Nemesis}5{$Else}3{$EndIf}{2} + f_WidthDelta;
end;

function TExprContainer.CalcHeight: Integer;
var
 l_Pad: Integer;
begin
 l_Pad := l3MulDiv(Son.Height, f_Padding, 100);
 Result := Son.Height + l_Pad*2;
end;

procedure TExprContainer.Paint(X,Y:Integer);
var
 l_Pad: Integer;
begin
 l_Pad := l3MulDiv(Son.Height, f_Padding, 100);
 Son.Draw(X + l_Pad + f_XOfs, Y + l_Pad + f_YOfs, ehLeft, evTop);
end;

procedure TExprContainer.Render(aCanvas: TCanvas; const aColors: Il3EffectiveColors);
  {* Отрисовать картинку }
var
 l_FC : TColor;
begin
 Canvas := aCanvas;
 try
  aCanvas.Brush.Style := bsSolid;
  l_FC := Color;
  try
   if (aColors = nil) then
   begin
    aCanvas.Brush.Color := clWindow;
    if f_ForWMF then
     aCanvas.Brush.Style := bsClear;
    aCanvas.FillRect(Rect(0, 0, Width, Height));
   end//aColors = nil
   else
   begin
    aColors.Font.ForeColor := l_FC;
    aColors.CheckColors;
    Color := aColors.FontColor;
   end;//aColors = nil
   Draw(0, 0, ehLeft, evTop);
  finally
   Color := l_FC;
  end;//try..finally
 finally
  Canvas := nil;
 end;//try..finally
end;
  
function TExprContainer.CalcExtent(const aFont: Il3Font): Tl3_SPoint;
  {-}
var
 l_C  : TCanvas;
 l_IC : Il3InfoCanvas;
begin
 l_IC := Tl3Canvas.MakeForScreen;
 try
  l_C := (l_IC As Il3Canvas).Canvas;
  try
   Canvas := l_C;
   if (aFont = nil) then
   begin
    Font.Size := 12;
    Color := clBlack;
   end//aFont = nil
   else
   begin
    Font.Name := aFont.Name;
    Font.Size := aFont.Size;
    Color := aFont.ForeColor;
   end;//aFont = nil
   Result.X := Width;
   Result.Y := Height;
  finally
   l_C := nil;
   Canvas := nil;
  end;//try..finally
 finally
  l_IC := nil;
 end;//try..finally
end;
  
procedure TExprContainer.SetForWMF(aValue: Boolean);
begin
 f_ForWMF := aValue;
end;

procedure TExprContainer.Cleanup;
begin
 f_ForWMF := False;
 inherited;
end;

end.
