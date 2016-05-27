unit csDictEditQueryPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\csDictEditQueryPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsDictEditQueryPrim" MUID: (53B27A6E01FC)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , k2Base
;

type
 TcsDictEditQueryPrim = class(TddProcessTask)
  protected
   function pm_GetFamily: Integer;
   procedure pm_SetFamily(aValue: Integer);
   function pm_GetDictType: Integer;
   procedure pm_SetDictType(aValue: Integer);
   function pm_GetOperation: Integer;
   procedure pm_SetOperation(aValue: Integer);
   function pm_GetID: Integer;
   procedure pm_SetID(aValue: Integer);
   function pm_GetParentID: Integer;
   procedure pm_SetParentID(aValue: Integer);
   function pm_GetNextID: Integer;
   procedure pm_SetNextID(aValue: Integer);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property Family: Integer
    read pm_GetFamily
    write pm_SetFamily;
   property DictType: Integer
    read pm_GetDictType
    write pm_SetDictType;
   property Operation: Integer
    read pm_GetOperation
    write pm_SetOperation;
   property ID: Integer
    read pm_GetID
    write pm_SetID;
   property ParentID: Integer
    read pm_GetParentID
    write pm_SetParentID;
   property NextID: Integer
    read pm_GetNextID
    write pm_SetNextID;
 end;//TcsDictEditQueryPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , DictEditQuery_Const
;

function TcsDictEditQueryPrim.pm_GetFamily: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrFamily]);
end;//TcsDictEditQueryPrim.pm_GetFamily

procedure TcsDictEditQueryPrim.pm_SetFamily(aValue: Integer);
begin
 TaggedData.IntW[k2_attrFamily, nil] := (aValue);
end;//TcsDictEditQueryPrim.pm_SetFamily

function TcsDictEditQueryPrim.pm_GetDictType: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrDictType]);
end;//TcsDictEditQueryPrim.pm_GetDictType

procedure TcsDictEditQueryPrim.pm_SetDictType(aValue: Integer);
begin
 TaggedData.IntW[k2_attrDictType, nil] := (aValue);
end;//TcsDictEditQueryPrim.pm_SetDictType

function TcsDictEditQueryPrim.pm_GetOperation: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrOperation]);
end;//TcsDictEditQueryPrim.pm_GetOperation

procedure TcsDictEditQueryPrim.pm_SetOperation(aValue: Integer);
begin
 TaggedData.IntW[k2_attrOperation, nil] := (aValue);
end;//TcsDictEditQueryPrim.pm_SetOperation

function TcsDictEditQueryPrim.pm_GetID: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrID]);
end;//TcsDictEditQueryPrim.pm_GetID

procedure TcsDictEditQueryPrim.pm_SetID(aValue: Integer);
begin
 TaggedData.IntW[k2_attrID, nil] := (aValue);
end;//TcsDictEditQueryPrim.pm_SetID

function TcsDictEditQueryPrim.pm_GetParentID: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrParentID]);
end;//TcsDictEditQueryPrim.pm_GetParentID

procedure TcsDictEditQueryPrim.pm_SetParentID(aValue: Integer);
begin
 TaggedData.IntW[k2_attrParentID, nil] := (aValue);
end;//TcsDictEditQueryPrim.pm_SetParentID

function TcsDictEditQueryPrim.pm_GetNextID: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrNextID]);
end;//TcsDictEditQueryPrim.pm_GetNextID

procedure TcsDictEditQueryPrim.pm_SetNextID(aValue: Integer);
begin
 TaggedData.IntW[k2_attrNextID, nil] := (aValue);
end;//TcsDictEditQueryPrim.pm_SetNextID

class function TcsDictEditQueryPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typDictEditQuery;
end;//TcsDictEditQueryPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
