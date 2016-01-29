unit ExprEditForm;

{$Include l3Define.inc}

{ $Id: ExprEditForm.pas,v 1.38 2015/04/23 10:18:42 dinishev Exp $}

// $Log: ExprEditForm.pas,v $
// Revision 1.38  2015/04/23 10:18:42  dinishev
// Убрал лишнее...
//
// Revision 1.37  2015/04/09 11:42:31  dinishev
// {Requestlink:583082850}
//
// Revision 1.36  2015/03/17 10:04:02  lulin
// - перетряхиваем зависимости.
//
// Revision 1.35  2014/01/29 12:18:56  dinishev
// Избавился от лишнего модуля.
//
// Revision 1.34  2013/04/17 14:19:22  lulin
// - портируем.
//
// Revision 1.33  2012/08/15 06:05:42  dinishev
// {Requestlink:382407838}
//
// Revision 1.32  2012/03/12 12:06:16  dinishev
// {Requestlink:344130696}
//
// Revision 1.31  2011/05/27 13:29:16  dinishev
// Более корректно проверяем изменился или текст формулы.
//
// Revision 1.30  2011/04/28 10:15:18  dinishev
// Выделяем сообщения для общих диалогов.
//
// Revision 1.29  2011/04/21 07:53:42  dinishev           
// [$264898177]
//
// Revision 1.28  2011/04/20 14:52:08  dinishev
// [$263750307]
//
// Revision 1.27  2011/04/20 13:52:53  dinishev
// [$263750307]
//
// Revision 1.26  2010/04/02 14:52:49  lulin
// {RequestLink:100008248}.
//
// Revision 1.25  2010/04/01 13:18:57  fireton
// - позволяем пробелы в формулах
//
// Revision 1.24  2010/02/18 08:08:06  fireton
// - SystemR (система с правой фигурной скобкой)
//
// Revision 1.23  2008/10/13 13:37:49  dinishev
// <K> : 84640081
//
// Revision 1.22  2008/10/09 11:29:27  dinishev
// Подготавливаемся к <K> : 89103144
//
// Revision 1.21  2008/10/01 11:13:27  lulin
// - <K>: 120718563.
//
// Revision 1.20  2008/06/28 15:50:13  lulin
// - добавлены примеры.
//
// Revision 1.19  2008/06/27 20:02:02  lulin
// - добавлены примеры.
//
// Revision 1.18  2008/06/27 11:01:49  lulin
// - <K>: 95489703.
//
// Revision 1.17  2008/06/23 10:14:44  dinishev
// Избавляемся от лишних IFDEF'ов
//
// Revision 1.16  2008/05/04 06:59:10  lulin
// - убираем концевые пробелы.
//
// Revision 1.15  2008/04/16 12:17:29  lulin
// - выделяем фасад для скрытия различий старого и нового редакторов.
//
// Revision 1.14  2008/04/16 11:50:22  lulin
// - выделяем фасад для скрытия различий старого и нового редакторов.
//
// Revision 1.13  2008/04/15 17:14:34  lulin
// - автоматизируем переключение между версиями редактора.
//
// Revision 1.12  2008/04/15 16:46:06  lulin
// - передаём вью в качестве параметра.
//
// Revision 1.11  2008/04/15 08:26:34  dinishev
// Восстанавливаем старый редактор
//
// Revision 1.10  2008/04/09 17:57:06  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.9  2007/12/03 09:49:06  dinishev
// Используем редактор из ветки
//
// Revision 1.8  2007/11/16 13:31:39  fireton
// + функция Circle() - диакретический кружочек
//
// Revision 1.7  2007/11/16 11:33:58  fireton
// - bug fix: подвисания при наборе формул
//
// Revision 1.6  2007/11/06 09:35:17  fireton
// - bug fix: небольшая помарка при стирании формулы
//
// Revision 1.5  2007/10/25 06:19:58  voba
// no message
//
// Revision 1.4  2007/10/11 13:54:45  fireton
// - делаем отступы при отрисовке формул (нивелируем разницу между рассчитаным и реальным размерами)
//
// Revision 1.3  2007/07/11 13:27:02  fireton
// - переход на TevMemo
//
// Revision 1.2  2007/06/25 14:02:36  fireton
// - доделки
//
// Revision 1.1  2007/06/22 15:06:38  fireton
// - первый коммит
//

{$Include l3Define.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, OvcBase, 
  evEditorWindow, evMultiSelectEditorWindow, evCustomEditor,
  evEditorWithOperations, evEditorInterfaces, evMemo, ExprEditControls,
  ActnList, afwControl, evCustomMemo, afwControlPrim, afwBaseControl,
  nevControl, evCustomEditorWindowPrim, evCustomEditorWindowModelPart,
  evCustomEditorModelPart, l3WinControlCanvas, evCustomEditorWindow, vtForm;

type
  TExprEditor = class(TvtForm)
    sbResult: TScrollBox;
    Label1: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    imgResult: TImage;
    UpdateTimer: TTimer;
    lblError: TLabel;
    lblPos: TLabel;
    btnRenew: TButton;
    memExpr: TevMemo;
    Panel1: TPanel;
    ebGreekCaps: TExprButton;
    ebGreekSmall: TExprButton;
    ebMathSymbols: TExprButton;
    Bevel1: TBevel;
    ebmathOperators: TExprButton;
    ebRelOperators: TExprButton;
    ebBrackets: TExprButton;
    ebDiacretic: TExprButton;
    ebDiffs: TExprButton;
    ebMathFunctions: TExprButton;
    Bevel2: TBevel;
    ebFormat: TExprButton;
    ebMathFormat: TExprButton;
    procedure UpdateTimerTimer(Sender: TObject);
    procedure memExprChange(Sender: TObject);
    procedure memExprKeyPress(Sender: TObject; var Key: Char);
    procedure memExprKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure memExprClick(Sender: TObject);
    procedure btnRenewClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ExprInsert(aExpr: TExprViewRecord);
    procedure memExprParaChange(Sender: TObject;
      const TextPara: IedTextParagraph);
  private
    f_Formula: string;
    f_UpdatingPreview: Boolean;
    procedure pm_SetFormula(const Value: string);
    procedure RestartUpdateTimer;
    procedure UpdatePosDisplay;
    function UpdatePreview(DisplayError: Boolean = False): Boolean;
    { Private declarations }
  public
    property Formula: string read f_Formula write pm_SetFormula;
    { Public declarations }
  end;

var
  ExprEditor: TExprEditor;

implementation

{$IFDEF Archi}
{$INCLUDE ArchiDefine.inc}
{$ENDIF Archi}

uses
 l3Base,
 l3String,
 l3Interfaces,

 evIntf,
 evOp,
 evInternalInterfaces,

 ExprDraw,
 ExprMake,

 evCommonRes,

 vtDialogs,

 nevTools,
 
 evCommonTypes,
 evFacadTextSource,
 evFacadeSelection,
 evFacadeCursor,
 evFacadeUtils
  ;

{$R *.dfm}

const
 ceaGreekCaps: array[0..23] of TExprViewRecord = (
    (rPre:''; rPar:'Alpha'; rSuf:''), (rPre:''; rPar:'Beta'; rSuf:''), (rPre:''; rPar:'Gamma'; rSuf:''),
    (rPre:''; rPar:'Delta'; rSuf:''), (rPre:''; rPar:'Epsilon'; rSuf:''), (rPre:''; rPar:'Zeta'; rSuf:''),
    (rPre:''; rPar:'Eta'; rSuf:''), (rPre:''; rPar:'Theta'; rSuf:''), (rPre:''; rPar:'Iota'; rSuf:''),
    (rPre:''; rPar:'Kappa'; rSuf:''), (rPre:''; rPar:'Lambda'; rSuf:''), (rPre:''; rPar:'Mu'; rSuf:''),
    (rPre:''; rPar:'Nu'; rSuf:''), (rPre:''; rPar:'Xi'; rSuf:''), (rPre:''; rPar:'Omicron'; rSuf:''),
    (rPre:''; rPar:'Pi'; rSuf:''), (rPre:''; rPar:'Rho'; rSuf:''), (rPre:''; rPar:'Sigma'; rSuf:''),
    (rPre:''; rPar:'Tau'; rSuf:''), (rPre:''; rPar:'Upsilon'; rSuf:''), (rPre:''; rPar:'Phi'; rSuf:''),
    (rPre:''; rPar:'Chi'; rSuf:''), (rPre:''; rPar:'Psi'; rSuf:''), (rPre:''; rPar:'Omega'; rSuf:'')
 );

 ceaGreekSmall: array[0..23] of TExprViewRecord = (
    (rPre:''; rPar:'alpha'; rSuf:''), (rPre:''; rPar:'beta'; rSuf:''), (rPre:''; rPar:'gamma'; rSuf:''),
    (rPre:''; rPar:'delta'; rSuf:''), (rPre:''; rPar:'epsilon'; rSuf:''), (rPre:''; rPar:'zeta'; rSuf:''),
    (rPre:''; rPar:'eta'; rSuf:''), (rPre:''; rPar:'theta'; rSuf:''), (rPre:''; rPar:'iota'; rSuf:''),
    (rPre:''; rPar:'kappa'; rSuf:''), (rPre:''; rPar:'lambda'; rSuf:''), (rPre:''; rPar:'mu'; rSuf:''),
    (rPre:''; rPar:'nu'; rSuf:''), (rPre:''; rPar:'xi'; rSuf:''), (rPre:''; rPar:'omicron'; rSuf:''),
    (rPre:''; rPar:'pi'; rSuf:''), (rPre:''; rPar:'rho'; rSuf:''), (rPre:''; rPar:'sigma'; rSuf:''),
    (rPre:''; rPar:'tau'; rSuf:''), (rPre:''; rPar:'upsilon'; rSuf:''), (rPre:''; rPar:'phi'; rSuf:''),
    (rPre:''; rPar:'chi'; rSuf:''), (rPre:''; rPar:'psi'; rSuf:''), (rPre:''; rPar:'omega'; rSuf:'')
 );

 ceaMathSymbols: array[0..10] of TExprViewRecord = (
    (rPre:'Angle&'; rPar:'alpha'; rSuf:''), (rPre:'Angle('; rPar:'ABC'; rSuf:')'), (rPre:''; rPar:'Inf'; rSuf:''),
    (rPre:''; rPar:'Nabla'; rSuf:''), (rPre:''; rPar:'PLambda'; rSuf:''), (rPre:''; rPar:'Plank'; rSuf:''),
    (rPre:''; rPar:'Exists'; rSuf:''),
    (rPre:''; rPar:'Any'; rSuf:''),
    (rPre:''; rPar:'%O/'; rSuf:''),
    (rPre:''; rPar:'%(C)'; rSuf:''),
    (rPre:''; rPar:'%(R)'; rSuf:'')
 );

 ceaMathOperators: array[0..13] of TExprViewRecord = (
    (rPre:''; rPar:'a'; rSuf:'+b'),
    (rPre:''; rPar:'a'; rSuf:'-b'),
    (rPre:''; rPar:'a'; rSuf:'+-b'),
    (rPre:''; rPar:'a'; rSuf:'-+b'),

    (rPre:''; rPar:'a'; rSuf:'*b'),
    (rPre:''; rPar:'a'; rSuf:'*.b'),
    (rPre:''; rPar:'a'; rSuf:'*+b'),

    (rPre:''; rPar:'a'; rSuf:'/b'),
    (rPre:''; rPar:'a'; rSuf:'//b'),
    (rPre:''; rPar:'a'; rSuf:'/+b'),

    (rPre:''; rPar:'a'; rSuf:'!'),
    (rPre:'Fact('; rPar:'a+b'; rSuf:')'),

    (rPre:''; rPar:'a'; rSuf:'%(+)b'),
    (rPre:''; rPar:'a'; rSuf:'%(*)b')
 );

 ceaRelOperators: array[0..31] of TExprViewRecord = (
    (rPre:''; rPar:'a'; rSuf:'<b'), (rPre:''; rPar:'a'; rSuf:'<~b'), (rPre:''; rPar:'a'; rSuf:'<=b'),
    (rPre:''; rPar:'a'; rSuf:'<<b'),(rPre:''; rPar:'a'; rSuf:'>b'), (rPre:''; rPar:'a'; rSuf:'>~b'),
    (rPre:''; rPar:'a'; rSuf:'>=b'), (rPre:''; rPar:'a'; rSuf:'>>b'), (rPre:''; rPar:'a'; rSuf:'=b'),
    (rPre:''; rPar:'a'; rSuf:'~~b'), (rPre:''; rPar:'a'; rSuf:'~b'), (rPre:''; rPar:'a'; rSuf:'=~b'),
    (rPre:''; rPar:'a'; rSuf:'==~b'),
    (rPre:''; rPar:'a'; rSuf:'<>b'), (rPre:''; rPar:'a'; rSuf:'==b'), (rPre:''; rPar:'a'; rSuf:'->b'),

    (rPre:''; rPar:'a'; rSuf:'<==b'),
    (rPre:''; rPar:'a'; rSuf:'<=>b'),
    (rPre:''; rPar:'a'; rSuf:'==>b'),

    (rPre:''; rPar:'_a'; rSuf:'&Parallel&_b'),
    (rPre:''; rPar:'_a'; rSuf:'&Perpendicular&_b'),

    (rPre:''; rPar:'a'; rSuf:'%Cb'),
    (rPre:''; rPar:'a'; rSuf:'%C/b'),
    (rPre:''; rPar:'a'; rSuf:'%C-b'),

    (rPre:''; rPar:'a'; rSuf:'%cb'),
    (rPre:''; rPar:'a'; rSuf:'%c-b'),

    (rPre:''; rPar:'a'; rSuf:'%Eb'),
    (rPre:''; rPar:'a'; rSuf:'%E/b'),

    (rPre:''; rPar:'a'; rSuf:'%Ub'),
    (rPre:''; rPar:'a'; rSuf:'%Rb'),

    (rPre:''; rPar:'a'; rSuf:'%Ab'),
    (rPre:''; rPar:'a'; rSuf:'%Vb')
 );

 ceaBrackets: array[0..6] of TExprViewRecord = (
    (rPre:'('; rPar:'a*b'; rSuf:')'), (rPre:'!('; rPar:'a*b'; rSuf:')'), (rPre:'['; rPar:'a+b'; rSuf:']'),
    (rPre:'{'; rPar:'a+b'; rSuf:'}'),(rPre:'Abs('; rPar:'a-b'; rSuf:')'), (rPre:'|'; rPar:'a+b'; rSuf:'|'),
    (rPre:'Brackets((],'; rPar:'0&comma&1'; rSuf:')')
 );

 ceaDiacretic: array[0..15] of TExprViewRecord = (
    (rPre:'_'; rPar:'a'; rSuf:''), (rPre:'Vect('; rPar:'a+b'; rSuf:')'), (rPre:''; rPar:'f(x)'; rSuf:'`'),
    (rPre:'Strokes('; rPar:'a'; rSuf:',2)'),(rPre:'Points('; rPar:'y'; rSuf:',3)'), (rPre:''; rPar:'Psi'; rSuf:'^Asterix'),
    (rPre:'Cap('; rPar:'x'; rSuf:')'),(rPre:'Line('; rPar:'a+b'; rSuf:')'), (rPre:'Tilde('; rPar:'sigma'; rSuf:')'),
    (rPre:'Circle('; rPar:'Delta'; rSuf:')'),

    (rPre:'ldq('; rPar:'Y'; rSuf:')'),
    (rPre:'dq('; rPar:'Y'; rSuf:')'),
    (rPre:'rdq('; rPar:'Y'; rSuf:')'),

    (rPre:'lsq('; rPar:'Y'; rSuf:')'),
    (rPre:'sq('; rPar:'Y'; rSuf:')'),
    (rPre:'rsq('; rPar:'Y'; rSuf:')')
 );

 ceaDiffs: array[0..7] of TExprViewRecord = (
    (rPre:'Diff('; rPar:'x'; rSuf:',n)'), (rPre:'DiffN('; rPar:'x'; rSuf:',n)'),(rPre:'DiffR('; rPar:'x'; rSuf:',n)'),
    (rPre:'DiffRF('; rPar:'f(x)'; rSuf:',x,n)'), (rPre:'PDiff('; rPar:'x'; rSuf:',n)'), (rPre:'PDiffN('; rPar:'x'; rSuf:',n)'),
    (rPre:'PDiffR('; rPar:'x'; rSuf:',n)'), (rPre:'PDiffRF('; rPar:'f(x)'; rSuf:',x,n)')
 );

 ceaMathFunctions: array[0..9] of TExprViewRecord = (
    (rPre:'Func('; rPar:'a*x'; rSuf:',x)'), (rPre:'Int('; rPar:'x'; rSuf:',0,Inf)'), (rPre:'IntM(3,'; rPar:'x'; rSuf:',0,y)'),
    (rPre:'Circ('; rPar:'_E'; rSuf:',L,M)'), (rPre:'Lim(x->0,'; rPar:'f(x)'; rSuf:')'),(rPre:'log(a,'; rPar:'x'; rSuf:')'),
    (rPre:'Root(3,'; rPar:'x-1'; rSuf:')'), (rPre:'Sqrt('; rPar:'x^2+y^2'; rSuf:')'), (rPre:'Summa('; rPar:'a_i'; rSuf:',i=0,N)'),
    (rPre:'Prod('; rPar:'a_i'; rSuf:',i=0,N)')
 );

 ceaMathFormat: array[0..7] of TExprViewRecord = (
    (rPre:'StandC('; rPar:'0<=i<n'; rSuf:',i<>j)'),
    (rPre:'StandL('; rPar:'0<=i<n'; rSuf:',i<>j)'),
    (rPre:'StandR('; rPar:'0<=i<n'; rSuf:',i<>j)'),
    (rPre:'System('; rPar:'x+y=5'; rSuf:',x*y=6)'),
    (rPre:'SystemR('; rPar:'x-y=12'; rSuf:',x*y=8)'),
    (rPre:'|Matrix('; rPar:'2'; rSuf:',2,_e_x,_e_y,x_a,y_a)|'),
    (rPre:'|x|=Case('; rPar:'-x'; rSuf:',x<0,0,x=0,x,x>0)'),
    (rPre:'At('; rPar:'DiffRF(f,x)'; rSuf:',x=0)=1')
 );

 ceaCustomFormat: array[0..17] of TExprViewRecord = (
    (rPre:''; rPar:'a0'; rSuf:''),
    (rPre:'Ind('; rPar:'a'; rSuf:',n)'),
    (rPre:''; rPar:'a'; rSuf:'_i'),
    (rPre:''; rPar:'x'; rSuf:'^(2//3)'),
    (rPre:'Pow('; rPar:'x'; rSuf:',(5*x))'),
    (rPre:''; rPar:'x'; rSuf:'&y'),
    (rPre:''; rPar:'a1,a2,...,a_k'; rSuf:''),
    (rPre:''; rPar:'x&comma(15)&y'; rSuf:''),
    (rPre:''; rPar:'#0.03'; rSuf:''),
    (rPre:'Num('; rPar:'0.00123456'; rSuf:')'),
    (rPre:''; rPar:'x=2&space(15)&y=5'; rSuf:''),
    (rPre:'String("'; rPar:'Некий текст'; rSuf:'")'),
    (rPre:''; rPar:'Empty^2'; rSuf:''),
    (rPre:''; rPar:'Symbol(198)=1'; rSuf:''),

    (rPre:''; rPar:'xSymbol($c2)=1'; rSuf:''),

    (rPre:'String("'; rPar:'Coca-cola'; rSuf:'")&Symbol($2122)'),

    (rPre:'String('; rPar:'#@$A3" - фунт, "#@$A5" - иена"'; rSuf:')'),
    (rPre:'String('; rPar:'#@$a1'; rSuf:')')
 );



function TExprEditor.UpdatePreview(DisplayError: Boolean = False): Boolean;
var
 l_Expr : Tl3Expr;
 l_Pos  : Integer;
begin
 Result := False;
 if not f_UpdatingPreview then
 begin
  f_UpdatingPreview := True;
  try
   //memExpr.Text := Trim(memExpr.Text);
   if memExpr.Text <> '' then
   try
    l_Expr := SafeBuildExpr(memExpr.Text);
    try
     with imgResult.Picture.Bitmap do
     begin
      Width := 2000;
      Height := 1000;
      Canvas.Brush.Style:=bsSolid;
      Canvas.Brush.Color:=clWindow;
      Canvas.FillRect(Rect(0,0,Width,Height))
     end;
     l_Expr.Canvas := imgResult.Picture.Bitmap.Canvas;
     l_Expr.Font.Size := 14;
     l_Expr.Draw(0, 0, ehLeft, evTop);
     with imgResult.Picture.Bitmap do
     begin
      Width := l_Expr.Width;
      Height := l_Expr.Height;
     end;
     imgResult.Width := l_Expr.Width;
     imgResult.Height := l_Expr.Height;
     lblError.Visible := False;
     imgResult.Visible := True;
     Result := True;
    finally
     l3Free(l_Expr);
    end;
   except
    on E: EIncorrectExpr do
     if DisplayError then
     begin
      lblError.Caption := E.Message;
      lblError.Visible := True;
      imgResult.Visible := False;
      if E.Position > 0 then
       l_Pos := E.Position - 1
      else
       l_Pos := 0;
      evAssignSelection(memExpr, l_Pos, '');
      memExpr.SetFocus;
      UpdatePosDisplay;
     end;
   end
   else
   begin
    imgResult.Height := 10;
    imgResult.Width  := 10;
    with imgResult.Picture.Bitmap do
    begin
     Width  := 10;
     Height := 10;
     Canvas.Brush.Style := bsSolid;
     Canvas.Brush.Color := clWindow;
     Canvas.FillRect(Rect(0, 0, Width, Height));
     lblError.Visible := False;
     imgResult.Visible := True;
    end;
    Result := False;
   end;
  finally
   f_UpdatingPreview := False;
   UpdateTimer.Enabled := False;
  end;
 end;
end;

procedure TExprEditor.UpdateTimerTimer(Sender: TObject);
begin
 UpdatePreview;
end;

procedure TExprEditor.memExprChange(Sender: TObject);
begin
 RestartUpdateTimer;
end;

procedure TExprEditor.memExprKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  UpdatePreview(True);
 if Key in [#13, #10] then
  Key := #0;
end;

procedure TExprEditor.RestartUpdateTimer;
begin
 if not Assigned(UpdateTimer) then
  Exit;
 UpdateTimer.Enabled := False;
 UpdateTimer.Enabled := True;
end;

procedure TExprEditor.memExprKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 UpdatePosDisplay;
end;

procedure TExprEditor.UpdatePosDisplay;
begin
 lblPos.Caption := Format('позиция: %d', [evGetMostInnerPos(memExpr)]);
end;

procedure TExprEditor.FormShow(Sender: TObject);
begin
 memExpr.Text := f_Formula;
 evSetTextParaLimit(memExpr.TextSource, 1);
 UpdatePosDisplay;
 UpdatePreview;
end;

procedure TExprEditor.pm_SetFormula(const Value: string);
begin
 f_Formula := Value;
 if Visible then
 begin
  memExpr.Text := f_Formula;
  UpdatePreview;
 end;
end;

procedure TExprEditor.memExprClick(Sender: TObject);
begin
 UpdatePosDisplay;
end;

procedure TExprEditor.btnRenewClick(Sender: TObject);
begin
 UpdatePreview(True);
end;

procedure TExprEditor.btnCancelClick(Sender: TObject);
begin
 ModalResult := mrCancel;
end;

procedure TExprEditor.btnOKClick(Sender: TObject);
var
 l_WasSame: Boolean;
begin
 if UpdatePreview(True) then
 begin
  l_WasSame := f_Formula = memExpr.Text;
  f_Formula := memExpr.Text;
  if memExpr.Modified or not l_WasSame then
   ModalResult := mrOK
  else
   ModalResult := mrCancel;
 end
 else
  vtMessageDlg(str_sidIEmtyFormula.AsCStr, mtError);
end;

procedure TExprEditor.FormCreate(Sender: TObject);
begin
 memExpr.NeedReplaceQuotes := false;
 ebGreekCaps.SetArray(ceaGreekCaps);
 ebGreekSmall.SetArray(ceaGreekSmall);
 ebMathSymbols.SetArray(ceaMathSymbols);
 ebMathOperators.SetArray(ceaMathOperators);
 ebRelOperators.SetArray(ceaRelOperators);
 ebBrackets.SetArray(ceaBrackets);
 ebDiacretic.SetArray(ceaDiacretic);
 ebDiffs.SetArray(ceaDiffs);
 ebMathFunctions.SetArray(ceaMathFunctions);
 ebMathFormat.SetArray(ceaMathFormat);
 ebFormat.SetArray(ceaCustomFormat);
end;

procedure TExprEditor.ExprInsert(aExpr: TExprViewRecord);
var
 l_CurSel: string;
 l_ToInsert: string;
 l_SavedPos: Integer;
 l_Block : TnevIRange;
 l_Pos: Integer;
begin
 l_Block := evGetSel(memExpr);
 l_CurSel := evGetSelString(l_Block);
 // запоминаем текущую позицию курсора
 l_SavedPos := evGetMostInnerEntryPos(memExpr);
 if ((aExpr.rPre = '') and (aExpr.rSuf = '')) or (l_CurSel='') then
  l_CurSel := aExpr.rPar;

 l_ToInsert := aExpr.rPre + l_CurSel + aExpr.rSuf;
 evInsertText2Memo(memExpr, l_Block, l_ToInsert);

 // выделяем, что надо
 l_Pos := l_SavedPos + Length(aExpr.rPre);
 evAssignSelection(memExpr, l_Pos, l_CurSel);

 memExpr.SetFocus;
end;

procedure TExprEditor.memExprParaChange(Sender: TObject;
  const TextPara: IedTextParagraph);
begin
 UpdatePosDisplay;
end;

end.
