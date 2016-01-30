{$IfNDef DocumentPresentation_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentPresentation.imp.pas"
// ���������: "VCMForm"

{$Define DocumentPresentation_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _DocumentPresentation_ = {abstract} class(_DocumentPresentation_Parent_)
  {* ������������� ��������� }
  protected
   procedure DoDocumentShowTechCommentsExecute; virtual;
   function DocumentIsValid: Boolean; virtual; abstract;
    {* ���� �� ��������, ������� � ������ }
   procedure InvertVersionCommentsVisibleByUser;
   procedure VersionCommentsVisibleInvertedByUser(NewState: Boolean); virtual;
  public
   procedure ShowJurorComments; override;
    {* �������� ����������� ����������� }
   procedure ShowUserComments; override;
    {* �������� ����������� ������������ }
   procedure ShowVersionComments; override;
    {* �������� ���������� � ������ }
   procedure ShowCommentsGroup; override;
    {* ����������� }
   procedure ShowSpecial; override;
    {* ���������� ����������� }
   procedure ShowInfo; override;
    {* ���������� ����� }
   procedure ShowTechComments; override;
    {* �������� ����������� ����������� }
   procedure ShowJurorComments; override;
    {* ��������/������ ����������� ������� }
   procedure ShowUserComments; override;
    {* ��������/������ ��� ����������� }
   procedure ShowTechComments; override;
    {* ���������� ����������� ����������� }
   procedure ShowVersionComments; override;
    {* ��������/��������� ���������� �� ���������� ��������� }
 end;//_DocumentPresentation_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_DocumentPresentation_ = _DocumentPresentation_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else DocumentPresentation_imp}

{$IfNDef DocumentPresentation_imp_impl}

{$Define DocumentPresentation_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
procedure _DocumentPresentation_.DoDocumentShowTechCommentsExecute;
//#UC START# *4C8DCD3B015C_4A7C0BF5008B_var*
//#UC END# *4C8DCD3B015C_4A7C0BF5008B_var*
begin
//#UC START# *4C8DCD3B015C_4A7C0BF5008B_impl*
 with _Instance_R_(Self).Text do
  ShowTechComments := not ShowTechComments;
//#UC END# *4C8DCD3B015C_4A7C0BF5008B_impl*
end;//_DocumentPresentation_.DoDocumentShowTechCommentsExecute

procedure _DocumentPresentation_.InvertVersionCommentsVisibleByUser;
//#UC START# *4AAA14D80350_4A7C0BF5008B_var*
var
 l_State: Boolean;
//#UC END# *4AAA14D80350_4A7C0BF5008B_var*
begin
//#UC START# *4AAA14D80350_4A7C0BF5008B_impl*
 with _Instance_R_(Self).Text do
 begin
  l_State := ShowVersionComments;
  ShowVersionComments := not(ShowVersionComments);
  if l_State <> ShowVersionComments then
   VersionCommentsVisibleInvertedByUser(ShowVersionComments);
 end;
//#UC END# *4AAA14D80350_4A7C0BF5008B_impl*
end;//_DocumentPresentation_.InvertVersionCommentsVisibleByUser

procedure _DocumentPresentation_.VersionCommentsVisibleInvertedByUser(NewState: Boolean);
//#UC START# *4AAA150A0244_4A7C0BF5008B_var*
//#UC END# *4AAA150A0244_4A7C0BF5008B_var*
begin
//#UC START# *4AAA150A0244_4A7C0BF5008B_impl*
 // Do nothing;
//#UC END# *4AAA150A0244_4A7C0BF5008B_impl*
end;//_DocumentPresentation_.VersionCommentsVisibleInvertedByUser

procedure _DocumentPresentation_.ShowJurorComments;
 {* �������� ����������� ����������� }
//#UC START# *4A7C0AFD02BA_4A7C0BF5008B_var*
//#UC END# *4A7C0AFD02BA_4A7C0BF5008B_var*
begin
//#UC START# *4A7C0AFD02BA_4A7C0BF5008B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A7C0AFD02BA_4A7C0BF5008B_impl*
end;//_DocumentPresentation_.ShowJurorComments

procedure _DocumentPresentation_.ShowUserComments;
 {* �������� ����������� ������������ }
//#UC START# *4A7C0B1D0319_4A7C0BF5008B_var*
//#UC END# *4A7C0B1D0319_4A7C0BF5008B_var*
begin
//#UC START# *4A7C0B1D0319_4A7C0BF5008B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A7C0B1D0319_4A7C0BF5008B_impl*
end;//_DocumentPresentation_.ShowUserComments

procedure _DocumentPresentation_.ShowVersionComments;
 {* �������� ���������� � ������ }
//#UC START# *4A7C0B4503AB_4A7C0BF5008B_var*
//#UC END# *4A7C0B4503AB_4A7C0BF5008B_var*
begin
//#UC START# *4A7C0B4503AB_4A7C0BF5008B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A7C0B4503AB_4A7C0BF5008B_impl*
end;//_DocumentPresentation_.ShowVersionComments

procedure _DocumentPresentation_.ShowCommentsGroup;
 {* ����������� }
//#UC START# *4A7C14810289_4A7C0BF5008B_var*
//#UC END# *4A7C14810289_4A7C0BF5008B_var*
begin
//#UC START# *4A7C14810289_4A7C0BF5008B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A7C14810289_4A7C0BF5008B_impl*
end;//_DocumentPresentation_.ShowCommentsGroup

procedure _DocumentPresentation_.ShowSpecial;
 {* ���������� ����������� }
//#UC START# *4A7C18B20241_4A7C0BF5008B_var*
//#UC END# *4A7C18B20241_4A7C0BF5008B_var*
begin
//#UC START# *4A7C18B20241_4A7C0BF5008B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A7C18B20241_4A7C0BF5008B_impl*
end;//_DocumentPresentation_.ShowSpecial

procedure _DocumentPresentation_.ShowInfo;
 {* ���������� ����� }
//#UC START# *4A7C1F420169_4A7C0BF5008B_var*
//#UC END# *4A7C1F420169_4A7C0BF5008B_var*
begin
//#UC START# *4A7C1F420169_4A7C0BF5008B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A7C1F420169_4A7C0BF5008B_impl*
end;//_DocumentPresentation_.ShowInfo

procedure _DocumentPresentation_.ShowTechComments;
 {* �������� ����������� ����������� }
//#UC START# *4A82C33A0105_4A7C0BF5008B_var*
//#UC END# *4A82C33A0105_4A7C0BF5008B_var*
begin
//#UC START# *4A82C33A0105_4A7C0BF5008B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A82C33A0105_4A7C0BF5008B_impl*
end;//_DocumentPresentation_.ShowTechComments

procedure _DocumentPresentation_.ShowJurorComments;
 {* ��������/������ ����������� ������� }
//#UC START# *4C7BAA4800A7_4A7C0BF5008B_var*
//#UC END# *4C7BAA4800A7_4A7C0BF5008B_var*
begin
//#UC START# *4C7BAA4800A7_4A7C0BF5008B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BAA4800A7_4A7C0BF5008B_impl*
end;//_DocumentPresentation_.ShowJurorComments

procedure _DocumentPresentation_.ShowUserComments;
 {* ��������/������ ��� ����������� }
//#UC START# *4C7BAA9102F7_4A7C0BF5008B_var*
//#UC END# *4C7BAA9102F7_4A7C0BF5008B_var*
begin
//#UC START# *4C7BAA9102F7_4A7C0BF5008B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BAA9102F7_4A7C0BF5008B_impl*
end;//_DocumentPresentation_.ShowUserComments

procedure _DocumentPresentation_.ShowTechComments;
 {* ���������� ����������� ����������� }
//#UC START# *4C7BAADA039E_4A7C0BF5008B_var*
//#UC END# *4C7BAADA039E_4A7C0BF5008B_var*
begin
//#UC START# *4C7BAADA039E_4A7C0BF5008B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BAADA039E_4A7C0BF5008B_impl*
end;//_DocumentPresentation_.ShowTechComments

procedure _DocumentPresentation_.ShowVersionComments;
 {* ��������/��������� ���������� �� ���������� ��������� }
//#UC START# *4C7BAC9C0105_4A7C0BF5008B_var*
//#UC END# *4C7BAC9C0105_4A7C0BF5008B_var*
begin
//#UC START# *4C7BAC9C0105_4A7C0BF5008B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BAC9C0105_4A7C0BF5008B_impl*
end;//_DocumentPresentation_.ShowVersionComments
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf DocumentPresentation_imp_impl}

{$EndIf DocumentPresentation_imp}

