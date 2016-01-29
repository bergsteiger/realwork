unit ddMDPIntegrationTestData;

{ $Id: ddMDPIntegrationTestData.pas,v 1.2 2013/04/11 16:46:28 lulin Exp $ }

// $Log: ddMDPIntegrationTestData.pas,v $
// Revision 1.2  2013/04/11 16:46:28  lulin
// - отлаживаем под XE3.
//
// Revision 1.1  2013/03/15 08:40:40  fireton
// - новый функционал
//

interface
uses
 GarDocsUnit,
 ArchiAdapter;

function GetTestSet1(const anAdapter: IArchiAdapterDll): IGardocList;

implementation
uses
 SysUtils,
 ActiveX,

 l3Base,
 l3Types,
 l3Stream,
 l3DateTimeBox, Classes;

const
 c_DocNum1 = 777888777;

function LoadFile(const aAdapter: IArchiAdapterDll; const aFileName: AnsiString): IStream;
var
 l_St: Tl3FileStream;
 l_ISt: IStream;
 l_Size: Int64;
 l_R, l_W: Largeint;
begin
 Result := aAdapter.MakeStream;
 l_St := Tl3FileStream.Create(aFileName, l3_fmRead);
 try
  l_Size := l_St.Size;
  l_ISt := l3Stream2IStream(l_St);
  l_ISt.CopyTo(Result, l_Size, l_R, l_W);
  Result.Seek(0, STREAM_SEEK_SET, l_R);
 finally
  FreeAndNil(l_St);
 end;
end;

function GetTestSet1(const anAdapter: IArchiAdapterDll): IGardocList;
var
 l_GD: TGardoc;
 l_IM: TImage;
begin
 Result := anAdapter.MakeGardocList;

 l3FillChar(l_GD, SizeOf(TGardoc));
 l_GD.rType := anAdapter.MakeString('ПРИКАЗ');
 l_GD.rNumber := anAdapter.MakeString('123/ФУФ');
 l_GD.rDate.rDay := 10;
 l_GD.rDate.rMounth := 10;
 l_GD.rDate.rYear := 2010;
 l_GD.rOgvList := anAdapter.MakeStringList;
 l_GD.rOgvList.Add(anAdapter.MakeString('Минэкономразвития России (Министерство экономического развития РФ)'));
 l_GD.rTitle := anAdapter.MakeString('ПРИКАЗ Минэкономразвития России от 10.10.2010 №123/ФУФ');
 l_GD.rBlocks := anAdapter.MakeStringList;
 l_GD.rBlocks.Add(anAdapter.MakeString('ARH'));
 l_GD.rTopic := c_DocNum1;
 l_GD.rImages := anAdapter.MakeImageList; // первый раз он пустой, без образов
 l_GD.rConfluenceId := 1234567;
 l3DateTimeToBox(Now, l_GD.rTimestamp);
 l_GD.rState := gsNEW;
 l_GD.rGardocType := gtDoc;
 l_GD.rUrgency := guOrdinary;
 Result.Add(l_GD);

 l_GD.rState := gsUPDATED;

 l3FillChar(l_IM, SizeOf(TImage));
 l_IM.rData := LoadFile(anAdapter, 'mdp_image1.doc');
 l_IM.rType := giDOC;
 l_IM.rSrcTitle := anAdapter.MakeString('[Получено по рассылке]');
 l_IM.rSrcNumber := anAdapter.MakeString('1');
 l_IM.rLabels := anAdapter.MakeStringList;
 l_IM.rLabels.Add(anAdapter.MakeString('gardoc_image_main'));
 l_GD.rImages.Add(l_IM);

 l_IM.rData := LoadFile(anAdapter, 'mdp_image2.rtf');
 l_IM.rSrcNumber := anAdapter.MakeString('2');
 l_IM.rType := giRTF;
 l_GD.rImages.Add(l_IM);

 l_IM.rData := LoadFile(anAdapter, 'mdp_image3.rtf');
 l_IM.rType := giRTF;
 l_IM.rSrcNumber := anAdapter.MakeString('3');
 l_IM.rLabels.Clear;
 l_GD.rImages.Add(l_IM);

 l_IM.rData := LoadFile(anAdapter, 'mdp_image4.nsr');
 l_IM.rType := giNSR;
 l_IM.rSrcNumber := anAdapter.MakeString('4');
 l_IM.rLabels.Add(anAdapter.MakeString('gardoc_image_main'));
 l_GD.rImages.Add(l_IM);

 Result.Add(l_GD);
end;

end.