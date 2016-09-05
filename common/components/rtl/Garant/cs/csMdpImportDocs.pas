unit csMdpImportDocs;

// Модуль: "w:\common\components\rtl\Garant\cs\csMdpImportDocs.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsMdpImportDocs" MUID: (55EEC220007F)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , k2Base
;

type
 TcsMdpImportDocs = class(TddProcessTask)
  protected
   function pm_GetMail: AnsiString;
   procedure pm_SetMail(const aValue: AnsiString);
   function pm_GetErrorMail: AnsiString;
   procedure pm_SetErrorMail(const aValue: AnsiString);
   function pm_GetMaxCount: Integer;
   procedure pm_SetMaxCount(aValue: Integer);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property Mail: AnsiString
    read pm_GetMail
    write pm_SetMail;
   property ErrorMail: AnsiString
    read pm_GetErrorMail
    write pm_SetErrorMail;
   property MaxCount: Integer
    read pm_GetMaxCount
    write pm_SetMaxCount;
 end;//TcsMdpImportDocs
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , mdpImportDocs_Const
 //#UC START# *55EEC220007Fimpl_uses*
 //#UC END# *55EEC220007Fimpl_uses*
;

function TcsMdpImportDocs.pm_GetMail: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrMail]);
end;//TcsMdpImportDocs.pm_GetMail

procedure TcsMdpImportDocs.pm_SetMail(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrMail, nil] := (aValue);
end;//TcsMdpImportDocs.pm_SetMail

function TcsMdpImportDocs.pm_GetErrorMail: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrErrorMail]);
end;//TcsMdpImportDocs.pm_GetErrorMail

procedure TcsMdpImportDocs.pm_SetErrorMail(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrErrorMail, nil] := (aValue);
end;//TcsMdpImportDocs.pm_SetErrorMail

function TcsMdpImportDocs.pm_GetMaxCount: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrMaxCount]);
end;//TcsMdpImportDocs.pm_GetMaxCount

procedure TcsMdpImportDocs.pm_SetMaxCount(aValue: Integer);
begin
 TaggedData.IntW[k2_attrMaxCount, nil] := (aValue);
end;//TcsMdpImportDocs.pm_SetMaxCount

class function TcsMdpImportDocs.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typmdpImportDocs;
end;//TcsMdpImportDocs.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
