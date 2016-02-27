unit ncsFileDesc;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsFileDesc.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3Variant
 , k2Base
 , Classes
;

type
 _evdTagHolder_Parent_ = Tl3Tag;
 {$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}
 TncsFileDesc = class(_evdTagHolder_)
  protected
   function pm_GetName: AnsiString;
   procedure pm_SetName(const aValue: AnsiString);
   function pm_GetCRC: Cardinal;
   procedure pm_SetCRC(aValue: Cardinal);
   function pm_GetDateTime: Integer;
   procedure pm_SetDateTime(aValue: Integer);
   function pm_GetSize: Int64;
   procedure pm_SetSize(aValue: Int64);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property Name: AnsiString
    read pm_GetName
    write pm_SetName;
   property CRC: Cardinal
    read pm_GetCRC
    write pm_SetCRC;
   property DateTime: Integer
    read pm_GetDateTime
    write pm_SetDateTime;
   property Size: Int64
    read pm_GetSize
    write pm_SetSize;
 end;//TncsFileDesc
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , FileDesc_Const
 , SysUtils
 , evdNativeWriter
 , l3Filer
 , l3Types
 , k2TagGen
 , evdNativeReader
 , k2DocumentBuffer
;

{$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}

function TncsFileDesc.pm_GetName: AnsiString;
//#UC START# *253C8AC17454_546C52C001EDget_var*
//#UC END# *253C8AC17454_546C52C001EDget_var*
begin
//#UC START# *253C8AC17454_546C52C001EDget_impl*
 !!! Needs to be implemented !!!
//#UC END# *253C8AC17454_546C52C001EDget_impl*
end;//TncsFileDesc.pm_GetName

procedure TncsFileDesc.pm_SetName(const aValue: AnsiString);
//#UC START# *253C8AC17454_546C52C001EDset_var*
//#UC END# *253C8AC17454_546C52C001EDset_var*
begin
//#UC START# *253C8AC17454_546C52C001EDset_impl*
 !!! Needs to be implemented !!!
//#UC END# *253C8AC17454_546C52C001EDset_impl*
end;//TncsFileDesc.pm_SetName

function TncsFileDesc.pm_GetCRC: Cardinal;
//#UC START# *7F5542D15E0D_546C52C001EDget_var*
//#UC END# *7F5542D15E0D_546C52C001EDget_var*
begin
//#UC START# *7F5542D15E0D_546C52C001EDget_impl*
 !!! Needs to be implemented !!!
//#UC END# *7F5542D15E0D_546C52C001EDget_impl*
end;//TncsFileDesc.pm_GetCRC

procedure TncsFileDesc.pm_SetCRC(aValue: Cardinal);
//#UC START# *7F5542D15E0D_546C52C001EDset_var*
//#UC END# *7F5542D15E0D_546C52C001EDset_var*
begin
//#UC START# *7F5542D15E0D_546C52C001EDset_impl*
 !!! Needs to be implemented !!!
//#UC END# *7F5542D15E0D_546C52C001EDset_impl*
end;//TncsFileDesc.pm_SetCRC

function TncsFileDesc.pm_GetDateTime: Integer;
//#UC START# *54C47EC3BF67_546C52C001EDget_var*
//#UC END# *54C47EC3BF67_546C52C001EDget_var*
begin
//#UC START# *54C47EC3BF67_546C52C001EDget_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C47EC3BF67_546C52C001EDget_impl*
end;//TncsFileDesc.pm_GetDateTime

procedure TncsFileDesc.pm_SetDateTime(aValue: Integer);
//#UC START# *54C47EC3BF67_546C52C001EDset_var*
//#UC END# *54C47EC3BF67_546C52C001EDset_var*
begin
//#UC START# *54C47EC3BF67_546C52C001EDset_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C47EC3BF67_546C52C001EDset_impl*
end;//TncsFileDesc.pm_SetDateTime

function TncsFileDesc.pm_GetSize: Int64;
//#UC START# *A278B43F8E2B_546C52C001EDget_var*
//#UC END# *A278B43F8E2B_546C52C001EDget_var*
begin
//#UC START# *A278B43F8E2B_546C52C001EDget_impl*
 !!! Needs to be implemented !!!
//#UC END# *A278B43F8E2B_546C52C001EDget_impl*
end;//TncsFileDesc.pm_GetSize

procedure TncsFileDesc.pm_SetSize(aValue: Int64);
//#UC START# *A278B43F8E2B_546C52C001EDset_var*
//#UC END# *A278B43F8E2B_546C52C001EDset_var*
begin
//#UC START# *A278B43F8E2B_546C52C001EDset_impl*
 !!! Needs to be implemented !!!
//#UC END# *A278B43F8E2B_546C52C001EDset_impl*
end;//TncsFileDesc.pm_SetSize

class function TncsFileDesc.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_546C52C001ED_var*
//#UC END# *53AC03EE01FD_546C52C001ED_var*
begin
//#UC START# *53AC03EE01FD_546C52C001ED_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_546C52C001ED_impl*
end;//TncsFileDesc.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
