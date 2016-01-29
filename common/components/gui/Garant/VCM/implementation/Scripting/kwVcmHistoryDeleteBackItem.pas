unit kwVcmHistoryDeleteBackItem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM$Scripting"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwVcmHistoryDeleteBackItem.pas"
// �����: 28.09.2011 11:37
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::vcm_History_DeleteBackItem
//
// ������� ���� ������� ������� �� ������ Back.
// *������:*
// {code}
// ���::�����_�����_��������������_��������
// 'AT_PHARM_NAME' '�������' Search:SetAttribute
// 'AT_PHARM_ATC' 'A. ��������������� ����� � ����� �������' Search:SetAttribute
// 'AT_PHARM_ATC' 'B. ��������� �������� �� ������������� � �����' Search:SetAttribute
// Ok
// OnTest
// vcm:history:DeleteBackItem
// {code}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}
type
 _VCMWord_Parent_ = TtfwRegisterableWord;
 {$Include ..\Scripting\VCMWord.imp.pas}
 TkwVcmHistoryDeleteBackItem = {scriptword} class(_VCMWord_)
  {* ������� ���� ������� ������� �� ������ Back.
 *������:*
[code]
 ���::�����_�����_��������������_��������
 'AT_PHARM_NAME' '�������' Search:SetAttribute
 'AT_PHARM_ATC' 'A. ��������������� ����� � ����� �������' Search:SetAttribute
 'AT_PHARM_ATC' 'B. ��������� �������� �� ������������� � �����' Search:SetAttribute
 Ok
 OnTest
 vcm:history:DeleteBackItem
[code] }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmHistoryDeleteBackItem
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  vcmForm
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  StdRes,
  vcmBase,
  afwAnswer
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}

{$Include ..\Scripting\VCMWord.imp.pas}

// start class TkwVcmHistoryDeleteBackItem

procedure TkwVcmHistoryDeleteBackItem.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E82CEBA0299_var*
//#UC END# *4DAEEDE10285_4E82CEBA0299_var*
begin
//#UC START# *4DAEEDE10285_4E82CEBA0299_impl*
 if (vcmDispatcher.History <> nil) then
  vcmDispatcher.History.DeleteBackItem;
//#UC END# *4DAEEDE10285_4E82CEBA0299_impl*
end;//TkwVcmHistoryDeleteBackItem.DoDoIt

class function TkwVcmHistoryDeleteBackItem.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:History:DeleteBackItem';
end;//TkwVcmHistoryDeleteBackItem.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� vcm_History_DeleteBackItem
 TkwVcmHistoryDeleteBackItem.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.