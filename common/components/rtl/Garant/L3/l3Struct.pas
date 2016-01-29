unit l3Struct;
{* ���������. }

{ ���������� "L3 (Low Level Library)" }
{ �����: ����� �.�. �                 }
{ ������: l3Struct - �������� ��������� �������� (Object) }
{ �����: 12.04.98 16:27               }
{ $Id: l3Struct.pas,v 1.5 2013/05/24 15:59:50 lulin Exp $ }

// $Log: l3Struct.pas,v $
// Revision 1.5  2013/05/24 15:59:50  lulin
// - �������� ������������� ��� XE4.
//
// Revision 1.4  2001/07/27 15:46:04  law
// - comments: xHelpGen.
//
// Revision 1.3  2000/12/15 15:19:02  law
// - ��������� ��������� Log.
//

{$I l3Define.inc }

interface

uses
  l3Types
  ;

type
  Tl3OrderKeyPrim = {$IfDef XE4}record{$Else}object{$EndIf}
   {* ���� ����������, ��� �������. }
    public
    // public fields
      Primary : Long;
      Delta   : Long;
  {$IfDef XE4}
    public
    // public methods
      function Compare(const K: Tl3OrderKeyPrim): Long;
        {* - ���������� ��� �����. }
      function Pred: Tl3OrderKeyPrim;
        {* - ���������� ��������. }
      function Succ: Tl3OrderKeyPrim;
        {* - ��������� ��������. }
      function StrengthPred: Tl3OrderKeyPrim;
        {* - ���������� "�������" ��������. }
      function StrengthSucc: Tl3OrderKeyPrim;
        {* - ��������� "�������" ��������. }
      procedure SetNull;
        {* - �������� ����. }
  {$EndIf  XE4}
  end;{Tl3OrderKeyPrim}

  {$IfDef XE4}
  Tl3OrderKey = Tl3OrderKeyPrim;
  {$Else XE4}
  Tl3OrderKey = object(Tl3OrderKeyPrim)
   {* ���� ����������. }
    public
    {public methods}
      function Compare(const K: Tl3OrderKeyPrim): Long;
        {* - ���������� ��� �����. }
      function Pred: Tl3OrderKey;
        {* - ���������� ��������. }
      function Succ: Tl3OrderKey;
        {* - ��������� ��������. }
      function StrengthPred: Tl3OrderKey;
        {* - ���������� "�������" ��������. }
      function StrengthSucc: Tl3OrderKey;
        {* - ��������� "�������" ��������. }
      procedure SetNull;
        {* - �������� ����. }
  end;{Tl3OrderKey}
  {$EndIf XE4}

implementation

{ start object Tl3OrderKey }

function Tl3OrderKey.Compare(const K: Tl3OrderKeyPrim): Long;
  {-���������� ��� �����}
begin
 Result := Primary - K.Primary;
 if (Result = 0) then Result := Delta - K.Delta;
end;

function Tl3OrderKey.Pred: Tl3OrderKey;
  {-���������� ��������}
begin
 Result.Primary := Primary;
 Result.Delta := System.Pred(Delta);
end;

function Tl3OrderKey.Succ: Tl3OrderKey;
  {-��������� ��������}
begin
 Result.Primary := Primary;
 Result.Delta := System.Succ(Delta);
end;

function Tl3OrderKey.StrengthPred: Tl3OrderKey;
  {-���������� "�������" ��������}
begin
 Result.Primary := System.Pred(Primary);
 Result.Delta := 0;
end;

function Tl3OrderKey.StrengthSucc: Tl3OrderKey;
  {-��������� "�������" ��������}
begin
 Result.Primary := System.Succ(Primary);
 Result.Delta := 0;
end;

procedure Tl3OrderKey.SetNull;
  {-�������� ����}
begin
 Primary := 0;
 Delta := 0;
end;

end.

