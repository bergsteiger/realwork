unit NOT_FINISHED_orb;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "MTDOrb"
// ������: "w:/common/components/rtl/external/MTDOrb/src/orb/NOT_FINISHED_orb.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::MTDOrb::orb::orb
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

interface

{$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
uses
  Classes,
  orb_int
  ;

type
 TLocalORBObject = class
 end;//TLocalORBObject
function ORB_Init(props: TStrings): IORB;
{$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit

implementation

{$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
// unit methods

function ORB_Init(props: TStrings): IORB;
//#UC START# *4CA1CCDD0268_4CA0D35D00BF_var*
//#UC END# *4CA1CCDD0268_4CA0D35D00BF_var*
begin
//#UC START# *4CA1CCDD0268_4CA0D35D00BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CA1CCDD0268_4CA0D35D00BF_impl*
end;//ORB_Init
{$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit

end.