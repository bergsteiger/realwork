unit tfwValueStack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Core"
// ������: "tfwValueStack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::ScriptEngineCore::TtfwValueStack
//
// ���� ����������. ���� ����������/��������� ���������� ��� ���������� �������.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  tfwValueList,
  tfwTypeInfo,
  l3Interfaces,
  l3Variant,
  Types,
  TypInfo
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TtfwValueStack = class(TtfwValueList)
  {* ���� ����������. ���� ����������/��������� ���������� ��� ���������� �������. }
 protected
 // realized methods
   function Get_ValuesCount: Integer;
 public
 // realized methods
   procedure PushInt(aValue: Integer);
   function PopInt: Integer;
   procedure PushBool(aValue: Boolean);
   function PopBool: Boolean;
   function IsTopBool: Boolean;
   procedure PushString(const aString: AnsiString); overload; 
   procedure PushString(const aString: Il3CString); overload; 
   procedure PushString(aString: Tl3PrimString); overload; 
   function IsTopString: Boolean;
   function PopDelphiString: AnsiString;
   function PopString: Il3CString;
   function IsTopInt: Boolean;
   procedure Dup;
   procedure Drop;
   procedure Swap;
   procedure Push(const aValue: TtfwStackValue);
   function Pop: TtfwStackValue;
   function IsTopType(aType: TtfwValueType): Boolean;
   procedure PushObj(aValue: TObject);
   function PopObj: TObject;
   procedure DupIfNotZero;
   procedure Rot;
   procedure Pick;
   procedure InvertRot;
   procedure Swap2;
   procedure Over2;
   procedure Dup2;
   procedure Drop2;
   procedure Nip;
   procedure Tuck;
   procedure Over;
   procedure Roll;
   function PopIntf(const aGUID: TGUID): IUnknown; overload; 
   function PopIntf: IUnknown; overload; 
   function IsTopIntf: Boolean;
     {* ���������� - ����� �� �� �������� ����� ��������� }
   procedure PushString(const aString: Tl3WString); overload; 
   procedure PushFile(const aFile: ItfwFile);
   function PopFile: ItfwFile;
   function IsTopObj: Boolean;
   function IsTopChar: Boolean;
   procedure PushChar(aChar: AnsiChar);
   function PopChar: AnsiChar;
   procedure PushWStr(const aStr: Tl3WString);
   function PopPrintable: Il3CString;
   procedure PushClass(aClass: TClass);
   function PopClass: TClass;
   function IsTopClass: Boolean;
   function PopObjAs(aClass: TClass;
     aAllowNil: Boolean = true): Pointer;
   function PopClassAs(aClass: TClass): Pointer;
   function PopWideString: WideString;
   procedure PushWideString(const aValue: WideString);
   function PopPoint: TPoint;
   procedure PushPoint(const aPoint: TPoint);
   procedure PushList(const aList: ItfwValueList);
   function PopList: ItfwValueList;
   procedure DupN(aN: Integer);
   procedure DropN(aN: Integer);
   function Top: PtfwStackValue;
   procedure PushIntf(const anIntf: IUnknown;
     aType: PTypeInfo);
 protected
 // protected methods
   function PLast: PtfwStackValue;
 public
 // public methods
   function PrevTop(aDelta: Integer;
     aNeedPop: Boolean): TtfwStackValue;
     {* �������� �������� �������������� ��������. }
 end;//TtfwValueStack
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  l3String,
  l3Base,
  l3StringEx
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TtfwValueStack

function TtfwValueStack.PrevTop(aDelta: Integer;
  aNeedPop: Boolean): TtfwStackValue;
//#UC START# *4DF069C60159_4DB009CF0103_var*
var
 l_Index: Integer;
//#UC END# *4DF069C60159_4DB009CF0103_var*
begin
//#UC START# *4DF069C60159_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > aDelta, '���������� ��������� ������ ��� ����� ������');
 l_Index := Count - aDelta - 1;
 Result := ItemSlot(l_Index)^;
 if aNeedPop then
  Delete(l_Index);
//#UC END# *4DF069C60159_4DB009CF0103_impl*
end;//TtfwValueStack.PrevTop

function TtfwValueStack.PLast: PtfwStackValue;
//#UC START# *55EFF78F01D7_4DB009CF0103_var*
//#UC END# *55EFF78F01D7_4DB009CF0103_var*
begin
//#UC START# *55EFF78F01D7_4DB009CF0103_impl*
 Result := ItemSlot(Count - 1);
//#UC END# *55EFF78F01D7_4DB009CF0103_impl*
end;//TtfwValueStack.PLast

procedure TtfwValueStack.PushInt(aValue: Integer);
//#UC START# *4DB008F503BE_4DB009CF0103_var*
//#UC END# *4DB008F503BE_4DB009CF0103_var*
begin
//#UC START# *4DB008F503BE_4DB009CF0103_impl*
 with GrowByOne^ do
 begin
  rType := tfw_vtInt;
  rInteger := aValue;
 end;//with GrowByOne^
 //Add(TtfwStackValue_C(aValue));
//#UC END# *4DB008F503BE_4DB009CF0103_impl*
end;//TtfwValueStack.PushInt

function TtfwValueStack.PopInt: Integer;
//#UC START# *4DB0090A0000_4DB009CF0103_var*
var
 l_V : PtfwStackValue;
//#UC END# *4DB0090A0000_4DB009CF0103_var*
begin
//#UC START# *4DB0090A0000_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 0, '���� ������');
 l_V := pLast;
 EtfwCheck.IsTrue(l_V.rType = tfw_vtInt, '������ ���� �����');
 Result := l_V.rInteger;
 DeleteLast;
//#UC END# *4DB0090A0000_4DB009CF0103_impl*
end;//TtfwValueStack.PopInt

procedure TtfwValueStack.PushBool(aValue: Boolean);
//#UC START# *4DB013A10166_4DB009CF0103_var*
//#UC END# *4DB013A10166_4DB009CF0103_var*
begin
//#UC START# *4DB013A10166_4DB009CF0103_impl*
 with GrowByOne^ do
 begin
  rType := tfw_vtBool;
  if aValue then
   rInteger := 1
  else
   rInteger := 0;
 end;//with GrowByOne^
 //Add(TtfwStackValue_C(aValue));
//#UC END# *4DB013A10166_4DB009CF0103_impl*
end;//TtfwValueStack.PushBool

function TtfwValueStack.PopBool: Boolean;
//#UC START# *4DB013AF01C9_4DB009CF0103_var*
//#UC END# *4DB013AF01C9_4DB009CF0103_var*
begin
//#UC START# *4DB013AF01C9_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 0, '���� ������');
 Result := pLast.AsBoolean;
 DeleteLast;
//#UC END# *4DB013AF01C9_4DB009CF0103_impl*
end;//TtfwValueStack.PopBool

function TtfwValueStack.IsTopBool: Boolean;
//#UC START# *4DB04213007C_4DB009CF0103_var*
//#UC END# *4DB04213007C_4DB009CF0103_var*
begin
//#UC START# *4DB04213007C_4DB009CF0103_impl*
 if Empty then
  Result := false
 else
  Result := (pLast.rType = tfw_vtBool); 
//#UC END# *4DB04213007C_4DB009CF0103_impl*
end;//TtfwValueStack.IsTopBool

procedure TtfwValueStack.PushString(const aString: AnsiString);
//#UC START# *4DB047EF0005_4DB009CF0103_var*
//#UC END# *4DB047EF0005_4DB009CF0103_var*
begin
//#UC START# *4DB047EF0005_4DB009CF0103_impl*
 PushString(TtfwCStringFactory.C(aString));
//#UC END# *4DB047EF0005_4DB009CF0103_impl*
end;//TtfwValueStack.PushString

procedure TtfwValueStack.PushString(const aString: Il3CString);
//#UC START# *4DB0480002EF_4DB009CF0103_var*
//#UC END# *4DB0480002EF_4DB009CF0103_var*
begin
//#UC START# *4DB0480002EF_4DB009CF0103_impl*
 with GrowByOne^ do
 begin
  rType := tfw_vtStr;
  rString := aString;
 end;//with GrowByOne^
 //Add(TtfwStackValue_C(aString));
//#UC END# *4DB0480002EF_4DB009CF0103_impl*
end;//TtfwValueStack.PushString

procedure TtfwValueStack.PushString(aString: Tl3PrimString);
//#UC START# *4DB0480A0174_4DB009CF0103_var*
//#UC END# *4DB0480A0174_4DB009CF0103_var*
begin
//#UC START# *4DB0480A0174_4DB009CF0103_impl*
 PushString(TtfwCStringFactory.C(aString));
//#UC END# *4DB0480A0174_4DB009CF0103_impl*
end;//TtfwValueStack.PushString

function TtfwValueStack.IsTopString: Boolean;
//#UC START# *4DB0488A0157_4DB009CF0103_var*
//#UC END# *4DB0488A0157_4DB009CF0103_var*
begin
//#UC START# *4DB0488A0157_4DB009CF0103_impl*
 if Empty then
  Result := false
 else
  Result := (pLast.rType = tfw_vtStr); 
//#UC END# *4DB0488A0157_4DB009CF0103_impl*
end;//TtfwValueStack.IsTopString

function TtfwValueStack.PopDelphiString: AnsiString;
//#UC START# *4DB0489C0129_4DB009CF0103_var*
//#UC END# *4DB0489C0129_4DB009CF0103_var*
begin
//#UC START# *4DB0489C0129_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 0, '���� ������');
 Result := pLast.AsDelphiString;
 DeleteLast;
//#UC END# *4DB0489C0129_4DB009CF0103_impl*
end;//TtfwValueStack.PopDelphiString

function TtfwValueStack.PopString: Il3CString;
//#UC START# *4DB1784F0388_4DB009CF0103_var*
//#UC END# *4DB1784F0388_4DB009CF0103_var*
begin
//#UC START# *4DB1784F0388_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 0, '���� ������');
 Result := pLast.AsString;
 DeleteLast;
//#UC END# *4DB1784F0388_4DB009CF0103_impl*
end;//TtfwValueStack.PopString

function TtfwValueStack.IsTopInt: Boolean;
//#UC START# *4DB17E8502F0_4DB009CF0103_var*
//#UC END# *4DB17E8502F0_4DB009CF0103_var*
begin
//#UC START# *4DB17E8502F0_4DB009CF0103_impl*
 if Empty then
  Result := false
 else
  Result := (pLast.rType = tfw_vtInt); 
//#UC END# *4DB17E8502F0_4DB009CF0103_impl*
end;//TtfwValueStack.IsTopInt

procedure TtfwValueStack.Dup;
//#UC START# *4DB6EE5E031F_4DB009CF0103_var*
//#UC END# *4DB6EE5E031F_4DB009CF0103_var*
begin
//#UC START# *4DB6EE5E031F_4DB009CF0103_impl*
 Add(Last);
//#UC END# *4DB6EE5E031F_4DB009CF0103_impl*
end;//TtfwValueStack.Dup

procedure TtfwValueStack.Drop;
//#UC START# *4DB6F04F02D2_4DB009CF0103_var*
//#UC END# *4DB6F04F02D2_4DB009CF0103_var*
begin
//#UC START# *4DB6F04F02D2_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 0, '���� ������');
 DeleteLast;
//#UC END# *4DB6F04F02D2_4DB009CF0103_impl*
end;//TtfwValueStack.Drop

procedure TtfwValueStack.Swap;
//#UC START# *4DB704AA00BF_4DB009CF0103_var*
//#UC END# *4DB704AA00BF_4DB009CF0103_var*
begin
//#UC START# *4DB704AA00BF_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 1, '������ ���� ������ ������ �������� � �����');
 Exchange(Count - 1, Count - 2);
//#UC END# *4DB704AA00BF_4DB009CF0103_impl*
end;//TtfwValueStack.Swap

procedure TtfwValueStack.Push(const aValue: TtfwStackValue);
//#UC START# *4DBAF89E0328_4DB009CF0103_var*
//#UC END# *4DBAF89E0328_4DB009CF0103_var*
begin
//#UC START# *4DBAF89E0328_4DB009CF0103_impl*
 GrowByOne^ := aValue;
 //Add(aValue);
//#UC END# *4DBAF89E0328_4DB009CF0103_impl*
end;//TtfwValueStack.Push

function TtfwValueStack.Pop: TtfwStackValue;
//#UC START# *4DBAF8B002CA_4DB009CF0103_var*
//#UC END# *4DBAF8B002CA_4DB009CF0103_var*
begin
//#UC START# *4DBAF8B002CA_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 0, '���� ������');
 Result := pLast^;
 DeleteLast;
//#UC END# *4DBAF8B002CA_4DB009CF0103_impl*
end;//TtfwValueStack.Pop

function TtfwValueStack.IsTopType(aType: TtfwValueType): Boolean;
//#UC START# *4DBAF8C200E2_4DB009CF0103_var*
//#UC END# *4DBAF8C200E2_4DB009CF0103_var*
begin
//#UC START# *4DBAF8C200E2_4DB009CF0103_impl*
 if Empty then
  Result := false
 else
  Result := (pLast.rType = aType); 
//#UC END# *4DBAF8C200E2_4DB009CF0103_impl*
end;//TtfwValueStack.IsTopType

procedure TtfwValueStack.PushObj(aValue: TObject);
//#UC START# *4DBAF910011B_4DB009CF0103_var*
//#UC END# *4DBAF910011B_4DB009CF0103_var*
begin
//#UC START# *4DBAF910011B_4DB009CF0103_impl*
 with GrowByOne^ do
 begin
  rType := tfw_vtObj;
  rInteger := Integer(aValue);
 end;//with GrowByOne^
 //Add(TtfwStackValue_C(aValue));
//#UC END# *4DBAF910011B_4DB009CF0103_impl*
end;//TtfwValueStack.PushObj

function TtfwValueStack.PopObj: TObject;
//#UC START# *4DBAF9210150_4DB009CF0103_var*
//#UC END# *4DBAF9210150_4DB009CF0103_var*
begin
//#UC START# *4DBAF9210150_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 0, '���� ������');
 Result := pLast.AsObject;
 DeleteLast;
//#UC END# *4DBAF9210150_4DB009CF0103_impl*
end;//TtfwValueStack.PopObj

procedure TtfwValueStack.DupIfNotZero;
//#UC START# *4DCBD16302CD_4DB009CF0103_var*
var
 l_L : PtfwStackValue;
//#UC END# *4DCBD16302CD_4DB009CF0103_var*
begin
//#UC START# *4DCBD16302CD_4DB009CF0103_impl*
 l_L := pLast;
 if (l_L.rInteger <> 0) AND (l_L.rType = tfw_vtInt) then
  Add(Last);
//#UC END# *4DCBD16302CD_4DB009CF0103_impl*
end;//TtfwValueStack.DupIfNotZero

procedure TtfwValueStack.Rot;
//#UC START# *4DEF28E400E0_4DB009CF0103_var*
var
 l_BottomID: Integer;
//#UC END# *4DEF28E400E0_4DB009CF0103_var*
begin
//#UC START# *4DEF28E400E0_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 2, '������ ���� ������ ���� ��������� � �����');
 l_BottomID := Count - 3;
 Exchange(l_BottomID, l_BottomID + 1);
 Inc(l_BottomID);
 Exchange(l_BottomID, l_BottomID + 1);
//#UC END# *4DEF28E400E0_4DB009CF0103_impl*
end;//TtfwValueStack.Rot

procedure TtfwValueStack.Pick;
//#UC START# *4DEF5D850232_4DB009CF0103_var*
//#UC END# *4DEF5D850232_4DB009CF0103_var*
begin
//#UC START# *4DEF5D850232_4DB009CF0103_impl*
 if IsTopInt then
  Add(PrevTop(PopInt, False))
 else
  EtfwCheck.Fail('������ ���� �����');
//#UC END# *4DEF5D850232_4DB009CF0103_impl*
end;//TtfwValueStack.Pick

procedure TtfwValueStack.InvertRot;
//#UC START# *4DEF5FBB0157_4DB009CF0103_var*
var
 l_TopID: Integer;
//#UC END# *4DEF5FBB0157_4DB009CF0103_var*
begin
//#UC START# *4DEF5FBB0157_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 2, '������ ���� ������ ���� ��������� � �����');
 l_TopID := Count - 1;
 Exchange(l_TopID, l_TopID - 1);
 Dec(l_TopID);
 Exchange(l_TopID, l_TopID - 1);
//#UC END# *4DEF5FBB0157_4DB009CF0103_impl*
end;//TtfwValueStack.InvertRot

procedure TtfwValueStack.Swap2;
//#UC START# *4DEF5FE202B1_4DB009CF0103_var*
var
 l_TopID: Integer;
//#UC END# *4DEF5FE202B1_4DB009CF0103_var*
begin
//#UC START# *4DEF5FE202B1_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 3, '������ ���� ������ ��� ��������� � �����');
 l_TopID := Count - 1;
 Exchange(l_TopID - 2, l_TopID);
 Exchange(l_TopID - 1, l_TopID - 3);
//#UC END# *4DEF5FE202B1_4DB009CF0103_impl*
end;//TtfwValueStack.Swap2

procedure TtfwValueStack.Over2;
//#UC START# *4DEF5FF802E6_4DB009CF0103_var*
//#UC END# *4DEF5FF802E6_4DB009CF0103_var*
begin
//#UC START# *4DEF5FF802E6_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 3, '������ ���� ������ ��� ��������� � �����');
 Add(PrevTop(3, False));
 Add(PrevTop(3, False));
//#UC END# *4DEF5FF802E6_4DB009CF0103_impl*
end;//TtfwValueStack.Over2

procedure TtfwValueStack.Dup2;
//#UC START# *4DEF60050174_4DB009CF0103_var*
//#UC END# *4DEF60050174_4DB009CF0103_var*
begin
//#UC START# *4DEF60050174_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 1, '������ ���� ������ ������ �������� � �����');
 Add(PrevTop(1, False));
 Add(PrevTop(1, False));
//#UC END# *4DEF60050174_4DB009CF0103_impl*
end;//TtfwValueStack.Dup2

procedure TtfwValueStack.Drop2;
//#UC START# *4DEF6013023F_4DB009CF0103_var*
//#UC END# *4DEF6013023F_4DB009CF0103_var*
begin
//#UC START# *4DEF6013023F_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 1, '������ ���� ������ ������ �������� � �����');
 DeleteLast;
 DeleteLast;
//#UC END# *4DEF6013023F_4DB009CF0103_impl*
end;//TtfwValueStack.Drop2

procedure TtfwValueStack.Nip;
//#UC START# *4DEF602000E4_4DB009CF0103_var*
//#UC END# *4DEF602000E4_4DB009CF0103_var*
begin
//#UC START# *4DEF602000E4_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 1, '������ ���� ������ ������ �������� � �����');
 Delete(Count - 2);
//#UC END# *4DEF602000E4_4DB009CF0103_impl*
end;//TtfwValueStack.Nip

procedure TtfwValueStack.Tuck;
//#UC START# *4DEF602B03A2_4DB009CF0103_var*
//#UC END# *4DEF602B03A2_4DB009CF0103_var*
begin
//#UC START# *4DEF602B03A2_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 1, '������ ���� ������ ������ �������� � �����');
 Insert(Count - 2, Last);
//#UC END# *4DEF602B03A2_4DB009CF0103_impl*
end;//TtfwValueStack.Tuck

procedure TtfwValueStack.Over;
//#UC START# *4DF06491010E_4DB009CF0103_var*
//#UC END# *4DF06491010E_4DB009CF0103_var*
begin
//#UC START# *4DF06491010E_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 1, '������ ���� ������ ������ �������� � �����');
 Add(PrevTop(1, False));
//#UC END# *4DF06491010E_4DB009CF0103_impl*
end;//TtfwValueStack.Over

procedure TtfwValueStack.Roll;
//#UC START# *4DF0649B0073_4DB009CF0103_var*
var
 l_Index: Integer;
//#UC END# *4DF0649B0073_4DB009CF0103_var*
begin
//#UC START# *4DF0649B0073_4DB009CF0103_impl*
 //if IsTopInt then
  Add(PrevTop(PopInt, True))
// else
//  EtfwCheck.Fail(False);
 //#UC END# *4DF0649B0073_4DB009CF0103_impl*
end;//TtfwValueStack.Roll

function TtfwValueStack.PopIntf(const aGUID: TGUID): IUnknown;
//#UC START# *4EB274C402BC_4DB009CF0103_var*
//#UC END# *4EB274C402BC_4DB009CF0103_var*
begin
//#UC START# *4EB274C402BC_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 0, '���� ������');
 Result := pLast.AsIntf(aGUID);
 DeleteLast;
//#UC END# *4EB274C402BC_4DB009CF0103_impl*
end;//TtfwValueStack.PopIntf

function TtfwValueStack.PopIntf: IUnknown;
//#UC START# *4EB274E201C2_4DB009CF0103_var*
//#UC END# *4EB274E201C2_4DB009CF0103_var*
begin
//#UC START# *4EB274E201C2_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 0, '���� ������');
 Result := pLast.AsIntf;
 DeleteLast;
//#UC END# *4EB274E201C2_4DB009CF0103_impl*
end;//TtfwValueStack.PopIntf

function TtfwValueStack.IsTopIntf: Boolean;
//#UC START# *4EB2759D021C_4DB009CF0103_var*
//#UC END# *4EB2759D021C_4DB009CF0103_var*
begin
//#UC START# *4EB2759D021C_4DB009CF0103_impl*
 if Empty then
  Result := false
 else
  Result := (pLast.rType = tfw_vtIntf); 
//#UC END# *4EB2759D021C_4DB009CF0103_impl*
end;//TtfwValueStack.IsTopIntf

function TtfwValueStack.Get_ValuesCount: Integer;
//#UC START# *4F3E34A1009A_4DB009CF0103get_var*
//#UC END# *4F3E34A1009A_4DB009CF0103get_var*
begin
//#UC START# *4F3E34A1009A_4DB009CF0103get_impl*
 Result := Count;
//#UC END# *4F3E34A1009A_4DB009CF0103get_impl*
end;//TtfwValueStack.Get_ValuesCount

procedure TtfwValueStack.PushString(const aString: Tl3WString);
//#UC START# *4F4749150158_4DB009CF0103_var*
//#UC END# *4F4749150158_4DB009CF0103_var*
begin
//#UC START# *4F4749150158_4DB009CF0103_impl*
 PushString(TtfwCStringFactory.C(aString));
//#UC END# *4F4749150158_4DB009CF0103_impl*
end;//TtfwValueStack.PushString

procedure TtfwValueStack.PushFile(const aFile: ItfwFile);
//#UC START# *4F4FD9790124_4DB009CF0103_var*
//#UC END# *4F4FD9790124_4DB009CF0103_var*
begin
//#UC START# *4F4FD9790124_4DB009CF0103_impl*
 Add(TtfwStackValue_C(aFile));
//#UC END# *4F4FD9790124_4DB009CF0103_impl*
end;//TtfwValueStack.PushFile

function TtfwValueStack.PopFile: ItfwFile;
//#UC START# *4F4FD99A0182_4DB009CF0103_var*
//#UC END# *4F4FD99A0182_4DB009CF0103_var*
begin
//#UC START# *4F4FD99A0182_4DB009CF0103_impl*
 pLast.CheckTypeIs(tfw_vtFile);
 Result := ItfwFile(pLast.AsIntf);
 DeleteLast;
//#UC END# *4F4FD99A0182_4DB009CF0103_impl*
end;//TtfwValueStack.PopFile

function TtfwValueStack.IsTopObj: Boolean;
//#UC START# *4F4FDC210286_4DB009CF0103_var*
//#UC END# *4F4FDC210286_4DB009CF0103_var*
begin
//#UC START# *4F4FDC210286_4DB009CF0103_impl*
 if Empty then
  Result := false
 else
  Result := (pLast.rType = tfw_vtObj); 
//#UC END# *4F4FDC210286_4DB009CF0103_impl*
end;//TtfwValueStack.IsTopObj

function TtfwValueStack.IsTopChar: Boolean;
//#UC START# *4F4FDCFB0195_4DB009CF0103_var*
//#UC END# *4F4FDCFB0195_4DB009CF0103_var*
begin
//#UC START# *4F4FDCFB0195_4DB009CF0103_impl*
 if Empty then
  Result := false
 else
  Result := (pLast.rType = tfw_vtChar); 
//#UC END# *4F4FDCFB0195_4DB009CF0103_impl*
end;//TtfwValueStack.IsTopChar

procedure TtfwValueStack.PushChar(aChar: AnsiChar);
//#UC START# *4F4FDD140127_4DB009CF0103_var*
//#UC END# *4F4FDD140127_4DB009CF0103_var*
begin
//#UC START# *4F4FDD140127_4DB009CF0103_impl*
 Add(TtfwStackValue_C(aChar));
//#UC END# *4F4FDD140127_4DB009CF0103_impl*
end;//TtfwValueStack.PushChar

function TtfwValueStack.PopChar: AnsiChar;
//#UC START# *4F4FDD38028A_4DB009CF0103_var*
//#UC END# *4F4FDD38028A_4DB009CF0103_var*
begin
//#UC START# *4F4FDD38028A_4DB009CF0103_impl*
 Result := pLast.AsChar;
 DeleteLast;
//#UC END# *4F4FDD38028A_4DB009CF0103_impl*
end;//TtfwValueStack.PopChar

procedure TtfwValueStack.PushWStr(const aStr: Tl3WString);
//#UC START# *4F4FE1DC0081_4DB009CF0103_var*
//#UC END# *4F4FE1DC0081_4DB009CF0103_var*
begin
//#UC START# *4F4FE1DC0081_4DB009CF0103_impl*
 PushString(TtfwCStringFactory.ViewOf(aStr));
 //Add(TtfwStackValue_C(aStr));
//#UC END# *4F4FE1DC0081_4DB009CF0103_impl*
end;//TtfwValueStack.PushWStr

function TtfwValueStack.PopPrintable: Il3CString;
//#UC START# *4F4FEB6100A7_4DB009CF0103_var*
//#UC END# *4F4FEB6100A7_4DB009CF0103_var*
begin
//#UC START# *4F4FEB6100A7_4DB009CF0103_impl*
 Result := pLast.AsPrintable;
 DeleteLast;
//#UC END# *4F4FEB6100A7_4DB009CF0103_impl*
end;//TtfwValueStack.PopPrintable

procedure TtfwValueStack.PushClass(aClass: TClass);
//#UC START# *508526FE0229_4DB009CF0103_var*
//#UC END# *508526FE0229_4DB009CF0103_var*
begin
//#UC START# *508526FE0229_4DB009CF0103_impl*
 with GrowByOne^ do
 begin
  rType := tfw_vtClass;
  rInteger := Integer(aClass);
 end;//with GrowByOne^
 //Add(TtfwStackValue_C(aClass));
//#UC END# *508526FE0229_4DB009CF0103_impl*
end;//TtfwValueStack.PushClass

function TtfwValueStack.PopClass: TClass;
//#UC START# *5085273502AA_4DB009CF0103_var*
//#UC END# *5085273502AA_4DB009CF0103_var*
begin
//#UC START# *5085273502AA_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count > 0, '���� ������');
 Result := pLast.AsClass;
 DeleteLast;
//#UC END# *5085273502AA_4DB009CF0103_impl*
end;//TtfwValueStack.PopClass

function TtfwValueStack.IsTopClass: Boolean;
//#UC START# *5085275F0044_4DB009CF0103_var*
//#UC END# *5085275F0044_4DB009CF0103_var*
begin
//#UC START# *5085275F0044_4DB009CF0103_impl*
 if Empty then
  Result := false
 else
  Result := (pLast.rType = tfw_vtClass);
//#UC END# *5085275F0044_4DB009CF0103_impl*
end;//TtfwValueStack.IsTopClass

function TtfwValueStack.PopObjAs(aClass: TClass;
  aAllowNil: Boolean = true): Pointer;
//#UC START# *54F7390300EC_4DB009CF0103_var*
//#UC END# *54F7390300EC_4DB009CF0103_var*
begin
//#UC START# *54F7390300EC_4DB009CF0103_impl*
 Result := Pop.AsObject(aClass, aAllowNil);
//#UC END# *54F7390300EC_4DB009CF0103_impl*
end;//TtfwValueStack.PopObjAs

function TtfwValueStack.PopClassAs(aClass: TClass): Pointer;
//#UC START# *54F8664200B0_4DB009CF0103_var*
//#UC END# *54F8664200B0_4DB009CF0103_var*
begin
//#UC START# *54F8664200B0_4DB009CF0103_impl*
 Result := Pop.AsClass(aClass);
//#UC END# *54F8664200B0_4DB009CF0103_impl*
end;//TtfwValueStack.PopClassAs

function TtfwValueStack.PopWideString: WideString;
//#UC START# *54F9C2A502E9_4DB009CF0103_var*
var
 l_S : Tl3Str;
//#UC END# *54F9C2A502E9_4DB009CF0103_var*
begin
//#UC START# *54F9C2A502E9_4DB009CF0103_impl*
 l_S := Tl3Str(l3PCharLen(PopString));
 Result := l_S.AsWideString;
//#UC END# *54F9C2A502E9_4DB009CF0103_impl*
end;//TtfwValueStack.PopWideString

procedure TtfwValueStack.PushWideString(const aValue: WideString);
//#UC START# *54F9C2CF0044_4DB009CF0103_var*
//#UC END# *54F9C2CF0044_4DB009CF0103_var*
begin
//#UC START# *54F9C2CF0044_4DB009CF0103_impl*
 PushString(l3CStr(aValue));
//#UC END# *54F9C2CF0044_4DB009CF0103_impl*
end;//TtfwValueStack.PushWideString

function TtfwValueStack.PopPoint: TPoint;
//#UC START# *54F9C6530229_4DB009CF0103_var*
//#UC END# *54F9C6530229_4DB009CF0103_var*
begin
//#UC START# *54F9C6530229_4DB009CF0103_impl*
 Result.Y := PopInt;
 Result.X := PopInt;
//#UC END# *54F9C6530229_4DB009CF0103_impl*
end;//TtfwValueStack.PopPoint

procedure TtfwValueStack.PushPoint(const aPoint: TPoint);
//#UC START# *54F9C66902E3_4DB009CF0103_var*
//#UC END# *54F9C66902E3_4DB009CF0103_var*
begin
//#UC START# *54F9C66902E3_4DB009CF0103_impl*
 PushInt(aPoint.X);
 PushInt(aPoint.Y);
//#UC END# *54F9C66902E3_4DB009CF0103_impl*
end;//TtfwValueStack.PushPoint

procedure TtfwValueStack.PushList(const aList: ItfwValueList);
//#UC START# *5510153F001C_4DB009CF0103_var*
//#UC END# *5510153F001C_4DB009CF0103_var*
begin
//#UC START# *5510153F001C_4DB009CF0103_impl*
 with GrowByOne^ do
 begin
  rType := tfw_vtList;
  ItfwValueList(rString) := aList;
 end;//with GrowByOne^
 //Push(TtfwStackValue_C(aList));
//#UC END# *5510153F001C_4DB009CF0103_impl*
end;//TtfwValueStack.PushList

function TtfwValueStack.PopList: ItfwValueList;
//#UC START# *551015680218_4DB009CF0103_var*
//#UC END# *551015680218_4DB009CF0103_var*
begin
//#UC START# *551015680218_4DB009CF0103_impl*
 pLast.CheckTypeIs(tfw_vtList);
 Result := ItfwValueList(Pop.AsIntf);
//#UC END# *551015680218_4DB009CF0103_impl*
end;//TtfwValueStack.PopList

procedure TtfwValueStack.DupN(aN: Integer);
//#UC START# *55E848EA003D_4DB009CF0103_var*
var
 l_Index : Integer;
//#UC END# *55E848EA003D_4DB009CF0103_var*
begin
//#UC START# *55E848EA003D_4DB009CF0103_impl*
 for l_Index := (Count - aN) to Pred(Count) do
  Add(ItemSlot(l_Index)^);
//#UC END# *55E848EA003D_4DB009CF0103_impl*
end;//TtfwValueStack.DupN

procedure TtfwValueStack.DropN(aN: Integer);
//#UC START# *55E84904001E_4DB009CF0103_var*
var
 l_Index : Integer;
//#UC END# *55E84904001E_4DB009CF0103_var*
begin
//#UC START# *55E84904001E_4DB009CF0103_impl*
 EtfwCheck.IsTrue(Count >= aN, '��������� � ����� ������, ��� �������� �������');
 for l_Index := 0 to Pred(aN) do
  DeleteLast;
//#UC END# *55E84904001E_4DB009CF0103_impl*
end;//TtfwValueStack.DropN

function TtfwValueStack.Top: PtfwStackValue;
//#UC START# *5601534A0012_4DB009CF0103_var*
//#UC END# *5601534A0012_4DB009CF0103_var*
begin
//#UC START# *5601534A0012_4DB009CF0103_impl*
 Result := pLast; 
//#UC END# *5601534A0012_4DB009CF0103_impl*
end;//TtfwValueStack.Top

procedure TtfwValueStack.PushIntf(const anIntf: IUnknown;
  aType: PTypeInfo);
//#UC START# *5613FA08013C_4DB009CF0103_var*
//#UC END# *5613FA08013C_4DB009CF0103_var*
begin
//#UC START# *5613FA08013C_4DB009CF0103_impl*
 with GrowByOne^ do
 begin
  rType := tfw_vtIntf;
  IUnknown(rString) := anIntf;
 end;//with GrowByOne^
//#UC END# *5613FA08013C_4DB009CF0103_impl*
end;//TtfwValueStack.PushIntf

{$IfEnd} //not NoScripts

end.