unit PictureEtalonsWorkingPack;

interface

uses
 l3IntfUses
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , l3PicturePathService
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwEnabledSaveRTFPictures = class(TtfwGlobalKeyWord)
  {* ����� ������� EnabledSaveRTFPictures
[panel]�������� ����� ���������� �������� ��� ������� �� RTF/DOC/DOCX. ����� �������� ����� ������ �������� �� RTF, �.�.���� ������������.[panel]
*������:*
[code]
 EnabledSaveRTFPictures
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEnabledSaveRTFPictures
 
 TkwGeneratePDFForEtalon = class(TtfwGlobalKeyWord)
  {* ����� ������� GeneratePDFForEtalon
[panel]*������*:
[code]
aFlag GeneratePDFForEtalon
[code]
��� aFlag - true ��� false.
��������/��������� ����� ��������� ���������� PDF, ������� ������ ������������ ��� ���������. ����� ���������� ��� ������ ��������, �.�.���� ������������ � False.[panel]
*������:*
[code]
 aValue GeneratePDFForEtalon
[code]  }
  procedure GeneratePDFForEtalon(const aCtx: TtfwContext;
   aValue: Boolean);
   {* ���������� ����� ������� GeneratePDFForEtalon }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGeneratePDFForEtalon
 
end.
