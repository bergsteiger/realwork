unit NOT_COMPLETED_csDictEditQueryPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_COMPLETED_csDictEditQueryPrim.pas"
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
//#UC START# *75BC6533A630_53B27A6E01FCget_var*
//#UC END# *75BC6533A630_53B27A6E01FCget_var*
begin
//#UC START# *75BC6533A630_53B27A6E01FCget_impl*
 !!! Needs to be implemented !!!
//#UC END# *75BC6533A630_53B27A6E01FCget_impl*
end;//TcsDictEditQueryPrim.pm_GetFamily

procedure TcsDictEditQueryPrim.pm_SetFamily(aValue: Integer);
//#UC START# *75BC6533A630_53B27A6E01FCset_var*
//#UC END# *75BC6533A630_53B27A6E01FCset_var*
begin
//#UC START# *75BC6533A630_53B27A6E01FCset_impl*
 !!! Needs to be implemented !!!
//#UC END# *75BC6533A630_53B27A6E01FCset_impl*
end;//TcsDictEditQueryPrim.pm_SetFamily

function TcsDictEditQueryPrim.pm_GetDictType: Integer;
//#UC START# *E28DB204BDDA_53B27A6E01FCget_var*
//#UC END# *E28DB204BDDA_53B27A6E01FCget_var*
begin
//#UC START# *E28DB204BDDA_53B27A6E01FCget_impl*
 !!! Needs to be implemented !!!
//#UC END# *E28DB204BDDA_53B27A6E01FCget_impl*
end;//TcsDictEditQueryPrim.pm_GetDictType

procedure TcsDictEditQueryPrim.pm_SetDictType(aValue: Integer);
//#UC START# *E28DB204BDDA_53B27A6E01FCset_var*
//#UC END# *E28DB204BDDA_53B27A6E01FCset_var*
begin
//#UC START# *E28DB204BDDA_53B27A6E01FCset_impl*
 !!! Needs to be implemented !!!
//#UC END# *E28DB204BDDA_53B27A6E01FCset_impl*
end;//TcsDictEditQueryPrim.pm_SetDictType

function TcsDictEditQueryPrim.pm_GetOperation: Integer;
//#UC START# *E5B01D3DCF61_53B27A6E01FCget_var*
//#UC END# *E5B01D3DCF61_53B27A6E01FCget_var*
begin
//#UC START# *E5B01D3DCF61_53B27A6E01FCget_impl*
 !!! Needs to be implemented !!!
//#UC END# *E5B01D3DCF61_53B27A6E01FCget_impl*
end;//TcsDictEditQueryPrim.pm_GetOperation

procedure TcsDictEditQueryPrim.pm_SetOperation(aValue: Integer);
//#UC START# *E5B01D3DCF61_53B27A6E01FCset_var*
//#UC END# *E5B01D3DCF61_53B27A6E01FCset_var*
begin
//#UC START# *E5B01D3DCF61_53B27A6E01FCset_impl*
 !!! Needs to be implemented !!!
//#UC END# *E5B01D3DCF61_53B27A6E01FCset_impl*
end;//TcsDictEditQueryPrim.pm_SetOperation

function TcsDictEditQueryPrim.pm_GetID: Integer;
//#UC START# *57E8CBA42C3C_53B27A6E01FCget_var*
//#UC END# *57E8CBA42C3C_53B27A6E01FCget_var*
begin
//#UC START# *57E8CBA42C3C_53B27A6E01FCget_impl*
 !!! Needs to be implemented !!!
//#UC END# *57E8CBA42C3C_53B27A6E01FCget_impl*
end;//TcsDictEditQueryPrim.pm_GetID

procedure TcsDictEditQueryPrim.pm_SetID(aValue: Integer);
//#UC START# *57E8CBA42C3C_53B27A6E01FCset_var*
//#UC END# *57E8CBA42C3C_53B27A6E01FCset_var*
begin
//#UC START# *57E8CBA42C3C_53B27A6E01FCset_impl*
 !!! Needs to be implemented !!!
//#UC END# *57E8CBA42C3C_53B27A6E01FCset_impl*
end;//TcsDictEditQueryPrim.pm_SetID

function TcsDictEditQueryPrim.pm_GetParentID: Integer;
//#UC START# *2610F05DA82F_53B27A6E01FCget_var*
//#UC END# *2610F05DA82F_53B27A6E01FCget_var*
begin
//#UC START# *2610F05DA82F_53B27A6E01FCget_impl*
 !!! Needs to be implemented !!!
//#UC END# *2610F05DA82F_53B27A6E01FCget_impl*
end;//TcsDictEditQueryPrim.pm_GetParentID

procedure TcsDictEditQueryPrim.pm_SetParentID(aValue: Integer);
//#UC START# *2610F05DA82F_53B27A6E01FCset_var*
//#UC END# *2610F05DA82F_53B27A6E01FCset_var*
begin
//#UC START# *2610F05DA82F_53B27A6E01FCset_impl*
 !!! Needs to be implemented !!!
//#UC END# *2610F05DA82F_53B27A6E01FCset_impl*
end;//TcsDictEditQueryPrim.pm_SetParentID

function TcsDictEditQueryPrim.pm_GetNextID: Integer;
//#UC START# *F8482228B27F_53B27A6E01FCget_var*
//#UC END# *F8482228B27F_53B27A6E01FCget_var*
begin
//#UC START# *F8482228B27F_53B27A6E01FCget_impl*
 !!! Needs to be implemented !!!
//#UC END# *F8482228B27F_53B27A6E01FCget_impl*
end;//TcsDictEditQueryPrim.pm_GetNextID

procedure TcsDictEditQueryPrim.pm_SetNextID(aValue: Integer);
//#UC START# *F8482228B27F_53B27A6E01FCset_var*
//#UC END# *F8482228B27F_53B27A6E01FCset_var*
begin
//#UC START# *F8482228B27F_53B27A6E01FCset_impl*
 !!! Needs to be implemented !!!
//#UC END# *F8482228B27F_53B27A6E01FCset_impl*
end;//TcsDictEditQueryPrim.pm_SetNextID

class function TcsDictEditQueryPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53B27A6E01FC_var*
//#UC END# *53AC03EE01FD_53B27A6E01FC_var*
begin
//#UC START# *53AC03EE01FD_53B27A6E01FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53B27A6E01FC_impl*
end;//TcsDictEditQueryPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
