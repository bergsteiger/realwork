unit k2StackGenerator;
{* ���������� ����� �� ������ �������� ���������. }

{ ���������� "K-2"        }
{ �����: ����� �.�. �     }
{ ������: k2StackGenerator - }
{ �����: 18.09.2002 10:17 }
{ $Id: k2StackGenerator.pas,v 1.80 2015/05/21 11:37:08 lulin Exp $ }

// $Log: k2StackGenerator.pas,v $
// Revision 1.80  2015/05/21 11:37:08  lulin
// - ����������� �����������.
//
// Revision 1.79  2014/06/24 14:53:34  lulin
// - ������ ����������� ��������� � ��������� ������.
//
// Revision 1.78  2014/05/14 13:11:46  lulin
// {RequestLink:517789752}.
//
// Revision 1.77  2014/05/13 17:46:54  lulin
// {RequestLink:517789752}.
//
// Revision 1.76  2014/04/30 15:03:20  lulin
// - ���������� �����������.
//
// Revision 1.75  2014/04/11 16:48:23  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.74  2014/04/08 17:13:26  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.73  2014/03/27 14:20:07  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.72  2014/03/20 12:24:03  lulin
// - ������������� ������ � ������.
//
// Revision 1.71  2014/02/28 14:54:26  lulin
// - ������������� ����������.
//
// Revision 1.70  2013/10/23 12:26:04  lulin
// - ������������� ������������ ���� ���� ���������� � ������.
//
// Revision 1.69  2013/10/22 16:45:06  lulin
// - ������������ ������� �����, ����� ��������� �� "���������" � ����������������.
//
// Revision 1.68  2013/10/18 14:11:33  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.67  2013/10/17 16:47:01  lulin
// - ������ �� ���������� �� ��������� Enum.
//
// Revision 1.66  2013/04/04 11:21:38  lulin
// - ���������.
//
// Revision 1.65  2011/10/05 11:06:33  voba
// - k : 281525254 ������ � ��������
//
// Revision 1.64  2011/09/19 13:30:04  lulin
// - �������� ������ ��������.
//
// Revision 1.63  2011/02/22 18:07:07  lulin
// {RequestLink:182157315}.
//
// Revision 1.62  2010/11/30 11:47:12  lulin
// {RequestLink:228688602}.
// - ������ � ����������������.
//
// Revision 1.61  2010/02/24 18:15:45  lulin
// - ����������� �� ��������� � �������� ���������, ������������ � ���������� �� ������ ���������.
//
// Revision 1.60  2009/07/03 16:24:13  lulin
// - ��� � �������� �� ����������� � ��������.
//
// Revision 1.59  2009/03/04 17:38:13  lulin
// - <K>: 137470629. ����� �������� ���������.
//
// Revision 1.58  2009/03/04 13:33:12  lulin
// - <K>: 137470629. ���������� �������������� ����� � ������ � ������� �� �� ����� �������.
//
// Revision 1.57  2009/03/03 17:27:26  lulin
// - <K>: 137470629. ��������� ��������� ����������� ����.
//
// Revision 1.56  2008/03/21 14:09:29  lulin
// - cleanup.
//
// Revision 1.55  2008/02/29 08:24:09  lulin
// - bug fix: �� ��������� ����������.
//
// Revision 1.54  2008/02/07 19:13:15  lulin
// - ����������� �� ������� ������������� ������� ������� �������.
//
// Revision 1.53  2008/02/06 09:30:53  lulin
// - ������� ������ �������� �������� � ��������� �����.
//
// Revision 1.52  2008/02/05 18:20:40  lulin
// - ������� �������� �������� �����.
//
// Revision 1.51  2007/09/07 14:47:43  lulin
// - ��������� �������� ���������� �������� ������.
//
// Revision 1.50  2007/08/29 12:22:46  lulin
// - cleanup.
//
// Revision 1.49  2007/08/28 15:27:08  lulin
// - cleanup.
//
// Revision 1.48  2007/08/21 11:39:50  lulin
// - ����������� �� �������������� �����������.
//
// Revision 1.47  2007/08/14 14:30:10  lulin
// - ������������ ����������� ������ ������.
//
// Revision 1.46  2007/08/14 11:24:59  lulin
// - ����������� �� ������ � ��������� ������.
//
// Revision 1.45  2007/08/13 15:19:37  lulin
// - ����������� �� ���������� ����.
//
// Revision 1.44  2007/08/13 14:58:39  voba
// - bug fix �� ����
//
// Revision 1.43  2007/08/13 11:11:25  lulin
// - ������� ������������ ������ ��� 32 ��������� ����.
//
// Revision 1.42  2007/08/10 08:39:39  lulin
// - ������� ������ ������������� �������� ������.
//
// Revision 1.41  2007/08/09 18:59:31  lulin
// - cleanup.
//
// Revision 1.40  2007/08/09 14:55:28  lulin
// - ����������� �� ��������� ������������� �����������.
//
// Revision 1.39  2007/08/09 13:41:56  lulin
// - ����������� �� �������� ��������.
//
// Revision 1.38  2007/08/09 13:01:46  lulin
// - ��������� �������� �� �������� ������ � ������������� �������� ����������.
//
// Revision 1.37  2007/08/09 11:46:39  lulin
// - cleanup.
//
// Revision 1.36  2007/08/09 11:29:10  lulin
// - cleanup.
//
// Revision 1.35  2007/08/09 11:19:27  lulin
// - cleanup.
//
// Revision 1.34  2007/08/09 10:36:28  lulin
// - ��������� �������� ������� ������� ������ ������� ����� ��� ������ EVD.
//
// Revision 1.33  2007/08/09 10:07:31  lulin
// - �������������� ���.
//
// Revision 1.32  2007/08/09 09:17:55  lulin
// - cleanup.
//
// Revision 1.31  2007/07/20 06:07:01  oman
// - fix: ������������� ������ (cq25820)
//
// Revision 1.30  2007/03/05 09:19:34  lulin
// - cleanup.
//
// Revision 1.29  2006/04/11 17:55:28  lulin
// - ������������ ��� ������ ��������� ����� (�� ������ ���� ��� ����� ������� � �������� 20% ������������������).
//
// Revision 1.28  2005/04/28 15:04:09  lulin
// - ��������� ����� B_Tag_Box � HEAD.
//
// Revision 1.27.4.3  2005/04/23 10:38:01  lulin
// - ��������� �� ������������� �������������� �����.
//
// Revision 1.27.4.2  2005/04/23 09:42:49  lulin
// - ��������� ���������� ��������� ��������� ������ �����������.
//
// Revision 1.27.4.1  2005/04/22 10:40:30  lulin
// - cleanup: ������ �������� ���������.
//
// Revision 1.27  2005/04/04 06:44:07  lulin
// - � ����� � ���������� ��������� ������� � ������ ���������� K-2, ������� ���������� "��������" ��������� � ���������/������������ ������� �����.
//
// Revision 1.26  2005/03/25 17:09:17  lulin
// - ����������� �� ������ Tk2AtomW.sLong.
//
// Revision 1.25  2005/03/22 17:03:07  lulin
// - �������� �������� ������. ���� ����������������� �������� - �� � �������� �� 1 ��� ������.
//
// Revision 1.24  2005/03/22 10:38:03  lulin
// - cleanup.
//
// Revision 1.23  2005/03/21 11:12:01  lulin
// - new procs: _k2NullDef, k2NullType.
//
// Revision 1.22  2005/03/21 10:05:06  lulin
// - new interface: _Ik2Type.
//
// Revision 1.21  2005/03/21 06:45:01  lulin
// - ������ �������� ������.
//
// Revision 1.20  2004/11/04 17:43:46  lulin
// - new interface: _Ik2TypeTable.
//
// Revision 1.19  2004/10/19 15:49:43  lulin
// - new behavior: � ������ TevCustomTextSource.GetGenerator � ������� ����������� ������������ TevDocumentContainerRestorer - ����� ���� ����������� � ������� ������������ ��������� ���������, ����� ���������� ��������.
//
// Revision 1.18  2004/10/19 15:01:04  lulin
// - ����������� �� ������ ������ ��� TevHighLevelDocumentGenerator.
//
// Revision 1.17  2004/09/21 12:04:25  lulin
// - Release ������� �� Cleanup.
//
// Revision 1.16  2004/06/02 14:45:53  law
// - rename method: Tk2BaseStackGenerator.Atom2String -> VariantAsString.
// - ������ ������ ��� ����� ���������� � ���������� �� �������� � ��������� _1252.
//
// Revision 1.15  2004/06/01 16:51:27  law
// - ������ ����������� Tl3VList.MakePersistent - ����������� _Tl3ObjectRefList.
//
// Revision 1.14  2004/05/31 11:44:36  law
// - new class: _Tl3PVList - ������ � ������������ �������� �������������/������������ ������.
//
// Revision 1.13  2004/05/14 14:49:04  law
// - ���������� �������� � ��������.
//
// Revision 1.12  2004/05/14 14:08:57  law
// - change: TevVariant ������������ � Tk2Variant � �������� � k2Types.
//
// Revision 1.11  2004/05/12 10:49:22  law
// - bug fix: �������� ��� ������ ������ � "�����" ��������-������������ ���������.
//
// Revision 1.10  2004/04/12 13:29:32  law
// - new: �������� ��� ���������� "��������� ������", �� �������� ShortName ������ �������������� �� �������, � �������� �����.
//
// Revision 1.9  2004/01/12 16:24:59  nikitin75
// ��������� ����� ��������� ������;
//
// Revision 1.8  2003/06/27 13:01:11  law
// - new behavior: ��������� Assert'�.
//
// Revision 1.7  2002/11/22 10:34:42  law
// - new class: Tk2CustomStackGeneratorExEx.
//
// Revision 1.6  2002/11/21 18:33:09  law
// - _move and rename class: evStrGen.TevBaseFileGenerator -> k2StackGenerator.Tk2CustomStackGeneratorEx.
//
// Revision 1.5  2002/10/01 16:21:53  law
// - bug fix: �� ��������������� ��� ��������� _evDebug.
//
// Revision 1.4  2002/09/23 12:18:20  law
// - new prop: Tk2ChildrenProperty._DefaultChildType.
//
// Revision 1.3  2002/09/18 09:02:46  law
// - new behavior: ��� ������ � evd-����� �������� ��� ���� ��������� ���� �� ���������.
//
// Revision 1.2  2002/09/18 07:33:22  law
// - cleanup.
//
// Revision 1.1  2002/09/18 07:08:03  law
// - new units: k2StackGenerator, _k2Ver.
// - new behavior: Tk2CustomReader ������ ����������� �� Tk2CustomStackGenerator � �������������� ��������� ��� ���������.
//

{$Include k2Define.inc }

interface

uses
  {$IfOpt D-}
  Classes,
  {$EndIf}

  l3Types,
  l3Interfaces,
  l3Base,
  l3CObjectList,
  l3Variant,

  k2Types,
  k2Interfaces,
  k2Base,
  k2InternalInterfaces,
  k2TagGen,
  k2Prim
  ;

type
  Tk2BaseStackGenerator = class(Tk2TagGenerator{, Ik2TypeTableSource})
   {* ������� ����������� ����� ��� ����������� ����� �� ������ �������� ���������. }
    protected
    // property methods
      function  pm_GetCurrentType: Tk2Type;
        override;
        {-}
      function  pm_GetTopType(Index: Long): Tk2Type;
        {-}
      function  pm_GetTopObject(Index: Long): Tk2Base;
        virtual;
        {-}
    protected
    // internal methods
      function  FindProperty(TagID: Long): Tk2Base;
        {-}
    public
    // public methods
      function  GetObjectID(const aName: AnsiString; aChild: Bool): Long;
        override;
        {-}
      function  VariantAsInteger(AtomIndex: Long; const Value: Tk2Variant): Long;
        {-}
      function  VariantAsString(const Value: Tk2Variant): Tl3CustomString;
        {-}
    public
    // public properties
      property TopObject[Index: Long]: Tk2Base
        read pm_GetTopObject;
        {-}
      property TopType[Index: Long]: Tk2Type
        read pm_GetTopType;
        {* - ��� ������� �� ������ ����������� -Index �� ��������. }
  end;//Tk2BaseStackGenerator

  Tk2CustomStackGenerator = class(Tk2BaseStackGenerator)
   {* ������� ����� ��� ����������� ����� �� ������ �������� ���������. }
    private
    // property fields
      f_Types     : Tl3CObjectList;
      // - �.�. �� ��� ������ ������� �����, �� ���� ������� �� ������ - ��� ������
    protected
    // property methods
      function  pm_GetTopObject(Index: Long): Tk2Base;
        override;
        {-}
      procedure OpenStream;
        override;
        {-}
      procedure CloseStream(NeedUndo: Bool);
        override;
        {-���������� ���� ��� � ����� ���������}
      procedure CloseStructure(NeedUndo: Bool);
        override;
        {-���������� �� ������������� ������}
      procedure Cleanup;
        override;
        {-}
    protected
    // internal properties
      property Types: Tl3CObjectList
        read f_Types;
        {-}
    public
    // public methods
      procedure StartChild(TypeID: Tl3VariantDef);
        override;
        {-}
      procedure StartTag(TagID: Long);
        override;
        {-}
  end;//Tk2CustomStackGenerator

  Tk2CustomStackGeneratorEx = class(Tk2CustomStackGenerator)
   {* ������������� ��������������� ����� ����������� �����. }
    protected
    // internal methods
      procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
        override;
        {-}
    public
    // public methods
      procedure AddAtom(AtomIndex: Long; aValue: Tl3Variant);
        override;
        {-}
  end;//Tk2CustomStackGeneratorEx
  {* ����������� ������ ������ AddAtom � ������ AddAtomEx. }

  Tk2CustomStackGeneratorExEx = class(Tk2CustomStackGeneratorEx, Il3DocIDSource)
    private
    // internal fields
      f_DocID : Long;
    protected
    // property methods
      function  pm_GetDocID: Long;
      procedure pm_SetDocID(aValue: Long);
        virtual;
        {-}
    public
    // public properties
      property DocID: Long
        read f_DocID;
        {-}
  end;//Tk2CustomStackGeneratorExEx

implementation

uses
  TypInfo,
  SysUtils,

  l3InterfacesMisc,

  k2Const,
  k2Facade,
  k2Tags,
  k2Except,
  k2Strings,
  k2Empty_Const,
  k2Attributes{,

  Document_Const}
  ;

// start class Tk2BaseStackGenerator

function Tk2BaseStackGenerator.GetObjectID(const aName: AnsiString; aChild: Bool): Long;
  {override;}
  {-}

 procedure RaiseNotDefined;
 var
  l_Msg : AnsiString;
 begin//RaiseNotDefined
(*  if not aChild then
  begin
   if ANSISameText(aName, 'Checked') then
   begin
    Result := GetObjectID('Checks', aChild);
    Exit;
   end;//ANSISameText(aName, 'Checked')
  end;//not aChild*)
  if aChild then
   l_Msg := '��� "%s" �� ������'
  else
   l_Msg := '��� "%s" �� ���������';
  raise Ek2NotFound.CreateFmt(l_Msg, [aName]);
 end;//RaiseNotDefined

 procedure RaiseNoChildren(const aCT: Tk2Type);
 begin//RaiseNoChildren
  raise Ek2NotFound.CreateFmt('Type %s has no children', [aCT.AsString]);
 end;//RaiseNoChildren

 procedure Recover(const aCT: Tk2Type);
 var
  l_CT   : Tk2Type;
  l_DC   : Tk2Type;
 begin//Recover
  l3System.Msg2Log(Format('Type %s has no children', [aCT.AsString]));
  l3System.Msg2Log('Trying to recover');
  Finish;
  // !!! ���� - ����� ��� ��� ���������� � ����� ������ �������� ������� - � ���
  //     Recover - ������ �������� �� ���� Finish.
  l_CT := CurrentType;
  l_DC := Tk2Type(l_CT.DefaultChildTypeID);
  if (l_DC <> nil) AND (l_DC <> k2_typEmpty) then
  begin
   Result := l_DC.ID;
   l3System.Msg2Log(Format('Recovered to %s %d', [l_CT.AsString, Result]));
  end//(l_DC <> nil) AND (l_DC <> k2_typEmpty)
  else
   RaiseNoChildren(l_CT);
 end;//Recover

var
 l_CT : Tk2Type;
 l_DC : Tk2Type;
begin
 l_CT := CurrentType;
 if aChild then
 begin
  if (aName = '') then
  begin
   if (l_CT = nil) then
   begin
    //Result := k2_idDocument;
    Result := -1;
    Assert(false);
   end//l_CT = nil
   else
   begin
    l_DC := Tk2Type(l_CT.DefaultChildTypeID);
    if (l_DC = nil) OR (l_DC = k2_typEmpty) then
     Recover(l_CT)
    else
     Result := l_DC.ID;
   end;//l_CT = nil
  end//aName = ''
  else
  begin
   l_CT := TypeTable.TypeByName[aName];
   if (l_CT = nil) then
    Result := -1
   else
    Result := l_CT.ID;
  end;//aName = ''
 end//aChild
 else
  Result := Tk2Attributes.Instance.IDByName(aName);
//  Result := GetEnumValue(TypeInfo(_Tk2TagID), '_k2_ti' + aName);
 if (Result < 0) then
  RaiseNotDefined;
 if aChild then Result := -Result;
end;

function  Tk2BaseStackGenerator.VariantAsInteger(AtomIndex: Long; const Value: Tk2Variant): Long;
  {-}

 procedure RaiseInvalidType;
 begin//RaiseInvalidType
  raise Ek2ConversionError.Create(k2_errInvalidType);
  Result := 0;
 end;//RaiseInvalidType
  
begin
 Case Value.Kind of
  k2_vkInteger:
   Result := Value.AsInteger;
  k2_vkString :
   Result := Tk2Type(CurrentType.Prop[AtomIndex].AtomType).StrToTag(Value.AsString.AsString).AsLong;
  else
   RaiseInvalidType;
 end;//Case Value.Kind
end;

function Tk2BaseStackGenerator.VariantAsString(const Value: Tk2Variant): Tl3CustomString;
  {-}
begin
 if Value.AsVariant.IsNull then
  Result := nil
 else
  Case Value.Kind of
   k2_vkInteger:
   begin
    Result := Tl3String.Create;
    Result.AsString := IntToStr(Value.AsInteger);
   end;//ev_tkInteger
   k2_vkString:
    Result := Value.AsString.Use;
   else
    ConvertErrorEx(Value.Kind);
  end;//Case Value.Kind
end;

function Tk2BaseStackGenerator.pm_GetCurrentType: Tk2Type;
  {-}
begin
 Result := TopType[0];
end;

function Tk2BaseStackGenerator.pm_GetTopType(Index: Long): Tk2Type;
  {-}
var
 l_TO : Tk2Base;
begin
 l_TO := TopObject[Index];
 if (l_TO = nil) then
  Result := nil
 else
  Result := Tk2Type(l_TO.TagType);
end;

function Tk2BaseStackGenerator.pm_GetTopObject(Index: Long): Tk2Base;
  //virtual;
  {-}
begin
 Result := nil;
end;

function Tk2BaseStackGenerator.FindProperty(TagID: Long): Tk2Base;
  {-}
var
 AT   : Tk2Type;
begin
 if (TagID >= 0) then
 begin
  AT := CurrentType;
  if (AT = nil) then
   Result := nil
  else
   Result := AT.Prop[TagID];
 end//TagID >= 0
 else
  Result := TypeTable.TypeByHandle[-TagID];
end;

// start class Tk2CustomStackGenerator 

procedure Tk2CustomStackGenerator.OpenStream;
  {override;}
  {-}
begin
 inherited;
 f_Types := Tl3CObjectList.Make;
 //f_Types.Capacity := 32;
end;

procedure Tk2CustomStackGenerator.CloseStream(NeedUndo: Bool);
  {override;}
  {-���������� ���� ��� � ����� ���������}
begin
 l3Free(f_Types);
 inherited;
end;

procedure Tk2CustomStackGenerator.CloseStructure(NeedUndo: Bool);
  {override;}
  {-���������� �� ������������� ������}
begin
 f_Types.DeleteLast;
 inherited;
end;

procedure Tk2CustomStackGenerator.StartChild(TypeID: Tl3VariantDef);
  {override;}
  {-}
begin
 //if (f_Types = nil) then
 // f_Types := Tl3CObjectList.Make;
 inherited;
 Assert(f_Types <> nil);
 f_Types.Add(TypeID);
end;

procedure Tk2CustomStackGenerator.StartTag(TagID: Long);
  {override;}
  {-}
begin
 inherited;
 Assert(f_Types <> nil);
 f_Types.Add(FindProperty(TagID));
end;

function Tk2CustomStackGenerator.pm_GetTopObject(Index: Long): Tk2Base;
  {-}
begin
 if (f_Types = nil) then
  Result := nil
 else
 begin
  {$IfOpt D+}
  with f_Types do
   if (Count > Index) then
    Result := Items[Hi - Index] As Tk2Base
   else
    Result := nil;
  {$Else}
  try
   with f_Types do
    Result := Tk2Base(Items[Hi - Index]);
  except
   on EListError do
    Result := nil;
  end;{try..except}
  {$EndIf}
 end;//f_Types = nil
end;

// start class Tk2CustomStackGeneratorEx

procedure Tk2CustomStackGeneratorEx.AddAtom(AtomIndex: Long; aValue: Tl3Variant);
  {override;}
  {-}
begin
 inherited;
 // - ������� ������ ������ �����, ��� ������ � ���������� ������ (!!!)
 if (AtomIndex >= 0) then
  TranslateAddAtom(AtomIndex, aValue);
end;

procedure Tk2CustomStackGeneratorEx.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
  {override;}
  {-}
begin
 //ConvertErrorEx(Value.Kind);
 // - ���� ���� ������, �� ������ �� ���� �������� inherited
end;

// start class Tk2CustomStackGeneratorExEx

function Tk2CustomStackGeneratorExEx.pm_GetDocID: Long;
  {-}
begin
 Result := f_DocID;
end;

procedure Tk2CustomStackGeneratorExEx.pm_SetDocID(aValue: Long);
  {-}
begin
 f_DocID := aValue;
end;

procedure Tk2CustomStackGenerator.Cleanup;
begin
 l3Free(f_Types);
 inherited;
end;

end.

