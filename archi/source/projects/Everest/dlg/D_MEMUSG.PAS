unit D_MemUsg;

{ $Id: D_MEMUSG.PAS,v 1.17 2014/04/30 13:11:39 lulin Exp $ }

// $Log: D_MEMUSG.PAS,v $
// Revision 1.17  2014/04/30 13:11:39  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.16  2007/12/05 13:51:29  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.14.2.1  2006/12/21 16:22:18  dinishev
// Bug fix: Everest в ветке не компилировался
//
// Revision 1.14  2005/12/28 13:08:14  lulin
// - new build.
//
// Revision 1.13  2005/07/05 11:59:02  lulin
// - bug fix: не компилировалось.
//
// Revision 1.12  2005/05/27 14:44:28  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.11  2005/05/26 15:38:28  lulin
// - базовая канва вывода теперь избавлена от знания о контролах управления.
//
// Revision 1.10  2005/03/21 16:30:06  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.9  2005/03/21 12:33:39  lulin
// - bug fix: не компилировалось.
//
// Revision 1.8  2004/03/15 14:22:46  law
// - change: переделки в связи с изменением библиотек компонентов.
//
// Revision 1.7  2002/04/06 11:33:56  law
// - Delphi 6.0.
//
// Revision 1.6.2.1  2002/02/07 15:23:05  law
// - rename class: IevBlock -> TevBlock, для того чтобы не путать его с интерфейсом.
//
// Revision 1.6  2001/04/02 11:30:27  law
// - убраны ненужные AutoCreat формы.
//
// Revision 1.5  2000/12/15 16:22:06  law
// - вставлены директивы Log.
//

{$I evDefine.inc}

interface

uses
  Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, OvcBase,
  l3Types,
   vtLister, vtOutliner, afwControl, afwInputControl;

type
  TMemoryUsageDlg = class(TForm)
    btOk: TBitBtn;
    btHelp: TBitBtn;
    lbLocalMemory: TLabel;
    lbGlobalMemory: TLabel;
    lbObjectMemory: TLabel;
    lbObjectCount: TLabel;
    pnTagTree: TPanel;
    spTreeAndSummary: TSplitter;
    TagTree: TvtOutliner;
    spTreeAndClasses: TSplitter;
    memClasses: TMemo;
    pnSummary: TPanel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function MemoryUsageDlg: TMemoryUsageDlg;
  {-}
  
implementation

uses
  SysUtils,
  
  l3Base
  ;

{$R *.DFM}

var
  l_MemoryUsageDlg: TMemoryUsageDlg = nil;

function SepInt(I: LongInt): string;
var
 D : Double;
 C : Char;
begin
 D := I;
 C := ThousandSeparator;
 try
  ThousandSeparator := ',';
  Result := Format('%n', [D]);
  {$IFDEF WIN32}
  SetLength(Result, Length(Result)-3);
  {$ELSE  WIN32}
  Result[0] := Char(Ord(Result[0])-3);
  {$ENDIF WIN32}
 finally
  ThousandSeparator := C;
 end;{try..finally}
end;

procedure TMemoryUsageDlg.FormShow(Sender: TObject);
{$IfDef l3TraceClasses}
var
 i  : Long;
 CL : TStrings;
{$EndIf l3TraceClasses}
begin
 with l3Base.l3System do begin
  lbLocalMemory.Caption := 'Локальная память: ' + SepInt(LocalMemUsed) + ' байт';
  lbGlobalMemory.Caption := 'Глобальная память: ' + SepInt(GlobalMemUsed) + ' байт';
  lbObjectMemory.Caption := 'Память на объекты: ' + SepInt(ObjectMemUsed) + ' байт';
  lbObjectCount.Caption := 'Количество объектов: ' + SepInt(ObjectCount) + ' штук';
 end;//with l3Base.l3System
 {$IfDef k2TagTree}
 TagTree.TreeStruct := GetStandardTypeTable.TagTree;
 {$Else  k2TagTree}
 TagTree.Visible := false;
 memClasses.Align := alClient;
 {$EndIf k2TagTree}
 memClasses.Clear;
 {$IfDef l3TraceClasses}
 with memClasses.Lines do begin
  BeginUpdate;
  try
   CL := l3System.ClassList;
   if (CL <> nil) then
    for i := 0 to Pred(CL.Count) do
     Add(CL[i] + ' = ' + IntToStr(Long(CL.Objects[i])));
  finally
   EndUpdate;
  end;{try..finally}
 end;{with memClasses}
 {$Else  l3TraceClasses}
 memClasses.Visible := false;
 {$EndIf l3TraceClasses}
 if not memClasses.Visible AND not TagTree.Visible then begin
  pnTagTree.Visible := false;
  pnSummary.Align := alClient;
 end;//not memClasses.Visible..
end;

function MemoryUsageDlg: TMemoryUsageDlg;
  {-}
begin
 if (l_MemoryUsageDlg = nil) then
  l_MemoryUsageDlg := TMemoryUsageDlg.Create(Application);
 Result := l_MemoryUsageDlg;
end;

end.
