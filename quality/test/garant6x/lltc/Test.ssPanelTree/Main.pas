unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, SsPanelTree, StdCtrls, Buttons, Grids,
  ImgList, Outline, Menus;

type
  TForm1 = class(TForm)
    procedure FormClick(Sender: TObject);
  private
    { Private declarations }
    ssPanelTree: TSsPanelTree;
  public
    { Public declarations }
  end;

	TFunction = function: string;

var
  Form1: TForm1;

implementation

{$R *.dfm}
//..................................................................................................
procedure RunTest(ClearFunction, TestFunction: TFunction);
var i:string;
begin
  ClearFunction;
	i:=TestFunction;
	if i<>'' then
  	ShowMessage(i);
end;

//..................................................................................................
function TestFont: string;
var
  f: TFont;
  l: TLabel;
  a: TSsPanelNode;
begin
//Создаем ноду, кладем на нее Label и меняем шрифт дерева
	Result:='';
	with Form1 do begin
    a:=SsPanelTree.AddChildTo(nil);

    l:=TLabel.Create(a);
    l.Parent:=TSsPanelNode(a);
    l.Visible:=FALSE;

    f:=SsPanelTree.Font;
    f.Height:=58;
    f.Charset:=GREEK_CHARSET;
    f.Color:=clRed;
    f.Color:=clRed;
    f.Style:=[fsBold];
    f.Name:='Courier New';
    SsPanelTree.PanelsFont:=f;

    if (a.Font.Height<>f.Height) OR
      (a.Font.Charset<>f.Charset) OR
      (a.Font.Style<>f.Style) OR
      (a.Font.Name<>f.Name) OR
      (a.Font.Color<>f.Color) then
    begin
        Result:='TestFont. Проверка применения шрифта не пройдена. Шрифт не применяется к панелям';
    end;

    if (l.Font.Height<>f.Height) OR
      (l.Font.Charset<>f.Charset) OR
      (l.Font.Style<>f.Style) OR
      (l.Font.Name<>f.Name) OR
      (l.Font.Color<>f.Color) then
    begin
        Result:=Result+#13#10+'TestFont. Проверка применения шрифта не пройдена. Шрифт не применяется к элементам панелей';
    end;

    l.Free;
    a.Free;

  end;
end;

//..................................................................................................
function TestCreateDeleteNode: string;
//Создаем ноду c AOwner=дерево и тут же удаляем
var
	a: TSsPanelNode;
begin
	Result:='';
	with Form1 do
  begin
		try
			a:=TSsPanelNode.Create(SsPanelTree);
	  	a.Free;
	  except
		  Result:='TestCreateDeleteNode. Проверка создание-удаление с owner=дерево не пройдена';
	  end;
	end;
end;

//..................................................................................................
function TestAddDelete: string;
//Создаем ноду, кладем на нее Label и меняем шрифт дерева
var a: TSsPanelNode;
begin
	Result:='';
	with Form1 do
  begin
		try
			a:=SsPanelTree.AddChildTo(nil);
			SsPanelTree.Delete(a);
  	except
    	Result:='TestInsertDelete.Проверка добавления-уничтожения элемента не пройдена';
	    exit;
   	end;
	end;
end;

//..................................................................................................
function TestTwiceDelete: string;
//Создаем ноду, и удаляем ее дважды
var a: TSsPanelNode;
begin
	Result:='';
	with Form1 do
  begin
		try
			a:=SsPanelTree.AddChildTo(nil);
			SsPanelTree.Delete(a);
			SsPanelTree.Delete(a);
  	except
	  	on e: exception do
    	begin
		    if e.Message<>'Попытка удаления отсутствующего узла' then
        begin
				  Result:='TestTwiceDelete. Проверка вторичного удаления элемента не пройдена. Исключение не верное.';
        end;
	      exit;
    	end;
  	end;
	  Result:='TestTwiceDelete. Проверка вторичного удаления элемента не пройдена. Исключение не возникло.';
	end;
end;

//..................................................................................................
function TestJunctionDelete: string;
//Создаем ноду, в ней ноду, потом первую удаляем, потом вторую :)
var a, b: TSsPanelNode;
begin
	Result:='';
	with Form1 do
  begin
		try
			a:=SsPanelTree.AddChildTo(nil);
			b:=SsPanelTree.AddChildTo(a);
			SsPanelTree.Delete(a);
  	except
	  	on e: exception do
    	begin
			  Result:='TestJunctionDelete. Проверка удаления узловой панели не пройдена.';
		    exit;
    	end;
  	end;
    try
			SsPanelTree.Delete(b)
    except
		  Result:='TestJunctionDelete. Проверка удаления подпанели не пройдена.';
    end;
	end;
end;

//..................................................................................................
function TestSelect: string;
//Создаем ноды и ходим меж ними
var
	ss: TList;
	i,j,k: longint;
begin
	Result:='';
	with Form1 do
  begin
  	try
      ss:=TList.Create;
      ss.Add(SsPanelTree.AddChildTo); //0
      ss.Add(ssPanelTree.AddChildTo); //1
      ss.Add(ssPanelTree.AddChildTo); //2
      ss.Add(ssPanelTree.AddChildTo); //3
      ss.Add(ssPanelTree.AddChildTo); //4
      ss.Add(ssPanelTree.AddChildTo(TSsPanelNode(ss[2]))); //5
      ss.Add(ssPanelTree.AddChildTo(TSsPanelNode(ss[2]))); //6
      ss.Add(ssPanelTree.AddChildTo(TSsPanelNode(ss[2]))); //7
      ss.Add(ssPanelTree.AddChildTo(TSsPanelNode(ss[2]))); //8
      ss.Add(ssPanelTree.AddChildTo(TSsPanelNode(ss[7]))); //9
      ss.Add(ssPanelTree.AddChildTo(TSsPanelNode(ss[9]))); //10
      ss.Add(ssPanelTree.AddChildTo(TSsPanelNode(ss[10]))); //11}
      ssPanelTree.ActiveNode:=TSsPanelNode(ss[0]);
      ssPanelTree.SelectNext;
      ssPanelTree.SelectNext;
      ssPanelTree.SelectNext;
      ssPanelTree.SelectNext;
      if ssPanelTree.ActiveNode<>ss[4] then
        Result:=Result+#13#10+'TestSelect. Проверка Select не пройдена, так как активна неправильная Node';
    except
    	on e: exception do
	    	Result:=Result+#13#10+'TestSelect. Проверка Select не пройдена, так как exception '+e.Message;
    end;

    try
      i:=0;
      for j:=0 to 11 do
      begin
  	    if TSsPanelNode(ss[j]).IsActive then inc(i);
      end;
      if i<>1 then
        Result:=Result+#13#10+'TestSelect. Проверка Активных нод не пройдена, так как кол-во активных элементов равно ' + inttostr(i);
    except
    	on e: exception do
	    	Result:=Result+#13#10+'TestSelect. Проверка Активных нод не пройдена, так как exception '+e.Message;
    end;

    try
      for j:=0 to 99 do
      begin
  		  if random(4)<2 then
        begin
	      	k:=random(12);
        	TSsPanelNode(ss[k]).Collapse;
        	TSsPanelNode(ss[k]).Collapse;
          if TSsPanelNode(ss[k]).IsExpanded then
          	Result:=Result+#13#10+'TestSelect. Collapse-IsExpanded возвратил неверное значение';
        end
        else
        begin
	      	k:=random(12);
        	TSsPanelNode(ss[k]).Expand;
        	TSsPanelNode(ss[k]).Expand;
//          if not TSsPanelNode(ss[k]).IsExpanded then
//          	Result:=Result+#13#10+'TestSelect. Expand-IsExpanded возвратил неверное значение';
        end;
      end;
    except
    	on e: exception do
	    	Result:=Result+#13#10+'TestSelect. Проверка Активных нод не пройдена, так как exception '+e.Message;
    end;
    ss.Free;
  end;
end;

//..................................................................................................
function TestInsertBefore: string;
//Создаем ноды и лейблы на них
var
	ss, labels: TList;

	procedure InsertPanelWithLabel(parentPanelIndex: longint; labelText: string);
  begin
  	if parentPanelIndex=-1 then
      ss.Add(Form1.SsPanelTree.InsertBefore)
    else
      ss.Add(Form1.SsPanelTree.InsertBefore(TSsPanelNode(ss[parentPanelIndex])));
	  labels.Add(TLabel.Create(nil));
    TLabel(labels.Last).Caption:=labelText;
  end;
begin
	Result:='';
	with Form1 do
  begin
  	try
      ss:=TList.Create;
      labels:=TList.Create;
      InsertPanelWithLabel(-1,'0');
      InsertPanelWithLabel(-1,'1');
      InsertPanelWithLabel(-1,'2');
      InsertPanelWithLabel(-1,'3');
      InsertPanelWithLabel(1,'4');
      InsertPanelWithLabel(1,'5');
      InsertPanelWithLabel(1,'6');
      InsertPanelWithLabel(4,'7');
      InsertPanelWithLabel(7,'8');
      InsertPanelWithLabel(-1,'9');
      InsertPanelWithLabel(5,'10');
      InsertPanelWithLabel(4,'11');
    except
    	on e: exception do
	    	Result:=Result+#13#10+'TestInsertBefore. Проверка InsertBefore не успешна exception: '+e.Message;
    end;
  end;
end;

//..................................................................................................
function TestParentTree: string;
//Проверка что после создания панели у нее будет правильное дерево в свойстве указано.
var
	a: TSsPanelNode;
begin
	Result:='';
	with Form1 do
  begin
  	try
    	a:=ssPanelTree.AddChildTo;
      if a.Tree<>ssPanelTree then
				Result:=Result+#13#10+'TestPanelTree. Не установилось ssPanelNode.Tree после создания AddChildTo';

    	a:=ssPanelTree.InsertBefore;
      if a.Tree<>ssPanelTree then
				Result:=Result+#13#10+'TestPanelTree. Не установилось свойство ssPanelNode.Tree после создания InsertBefore';
    except
    	on e: exception do
	    	Result:=Result+#13#10+'TestPanelTree. exception: '+e.Message;
    end;
  end;
end;

//..................................................................................................
function TestMemoryLeaks: string;
//Проверка, что память не теряется при добавлении и удалении панелей
var
	a: TSsPanelNode;
  i:longint;
  memstat1, memstat2:TMEMORYSTATUS;
begin
	Result:='';
	with Form1 do
  begin
  	try
		  GlobalMemoryStatus(memstat1);
    	for i:=0 to 1000 do
      begin
	    	a:=ssPanelTree.AddChildTo;
				ssPanelTree.Delete(a);
      end;
		  GlobalMemoryStatus(memstat2);

    	Result:=Result+#13#10+'TestMemoryLeaks. AddChildTo-Delete. Съелось (байт): '+
      	IntToStr((memstat1.dwAvailPhys+memstat1.dwAvailPageFile+memstat1.dwAvailVirtual)-(memstat2.dwAvailPhys+memstat2.dwAvailPageFile+memstat2.dwAvailVirtual));

    	a:=ssPanelTree.AddChildTo;
    	for i:=0 to 40 do
      begin
      	ssPanelTree.AddChildTo(a);
      end;
		  GlobalMemoryStatus(memstat1);
      for i:=0 to 10 do
      begin
      	a.Collapse;
        Invalidate;
        Refresh;
        a.Expand;
        Invalidate;
        Refresh;
      end;
		  GlobalMemoryStatus(memstat2);

    	Result:=Result+#13#10+'TestMemoryLeaks. Expand-Collapse. Съелось (байт): '+
      	IntToStr(longint((memstat1.dwAvailPhys+memstat1.dwAvailPageFile+memstat1.dwAvailVirtual)-(memstat2.dwAvailPhys+memstat2.dwAvailPageFile+memstat2.dwAvailVirtual)));

    except
    	on e: exception do
	    	Result:=Result+#13#10+'TestMemoryLeaks. exception: '+e.Message;
    end;
  end;
end;

//..................................................................................................
function TestCrossKind: string;
//Проверка, что работает CrossKind
var
	a: TSsPanelNode;
  i:longint;
begin
	Result:='';
	with Form1 do
  begin
  	try
    	ssPanelTree.CrossKind:=ckPlus;
			ssPanelTree.IconOpenBranch:=TIcon.Create;
      ssPanelTree.IconOpenBranch.LoadFromFile('Icon1.ico');
			ssPanelTree.IconClosedBranch:=TIcon.Create;
      ssPanelTree.IconClosedBranch.LoadFromFile('Icon2.ico');
      ssPanelTree.AddChildTo(ssPanelTree.AddChildTo(nil));
      ssPanelTree.AddChildTo(ssPanelTree.AddChildTo(nil));
    	ssPanelTree.CrossKind:=ckIcon;
    except
    	on e: exception do
	    	Result:=Result+#13#10+'TestCrossKind. exception: '+e.Message;
    end;
	end;
end;

//..................................................................................................
function TestItems: string;
//Проверка, что работает Items и ItemsCount
var
	a: TSsPanelNode;
  i:longint;
  t:TList;
begin
	t:=TList.Create;
	Result:='';
	with Form1 do
  begin
  	try
			a:=ssPanelTree.AddChildTo;
      t.Add(TLabel.Create(a));
      TLabel(t.Last).Parent:=a;
      if a.ItemsCount<>t.Count then
				Result:=Result+#13#10+'TestItems. После добавления 1 TLabel ItemsCount выдает неверное кол-во:'+IntToStr(a.ItemsCount);
      for i:=0 to 19 do
      begin
	      t.Add(TLabel.Create(a));
  	    TLabel(t.Last).Parent:=a;
      end;
      if a.ItemsCount<>t.Count then
				Result:=Result+#13#10+'TestItems. После добавления TLabel ItemsCount выдает неверное кол-во:'+IntToStr(a.ItemsCount);
      for i:=0 to 20 do
      	TLabel(t[i]).Free;
      t.Free;
      if a.ItemsCount<>0 then
				Result:=Result+#13#10+'TestItems. После удаления всех TLabel ItemsCount выдает неверное кол-во:'+IntToStr(a.ItemsCount);
    except
    	on e: exception do
	    	Result:=Result+#13#10+'TestItems. exception: '+e.Message;
    end;
  end;
end;

//..................................................................................................
function Beginning: string;
//Проверка, что работает Items и ItemsCount
begin
	Result:='';
  if Form1.ssPanelTree<>nil then Form1.ssPanelTree.Free;
	Form1.ssPanelTree:=TSsPanelTree.Create(Form1);
  with Form1.ssPanelTree do
  begin
  	Parent := Form1;
    Left:=0;
    Top:=0;
    Width:=400;
    Height:=400;
    Visible:=TRUE;
  end;
end;


//..................................................................................................
procedure TForm1.FormClick(Sender: TObject);
begin
  RunTest(Beginning,TestSelect);
	RunTest(Beginning,TestFont);
	RunTest(Beginning,TestCrossKind);
  RunTest(Beginning,TestCreateDeleteNode);
  RunTest(Beginning,TestAddDelete);
  RunTest(Beginning,TestTwiceDelete);
  RunTest(Beginning,TestJunctionDelete);
  RunTest(Beginning,TestInsertBefore);
	RunTest(Beginning,TestParentTree);
  RunTest(Beginning,TestMemoryLeaks);
	RunTest(Beginning,TestItems);
  ShowMessage('ОКОНЧЕНО');
end;

end.
