package dsparser.tc;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Collection;

import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

// Для работы с проектом TestComplete
public class TCProject {

	private final static XPathFactory xPathFactory = XPathFactory.newInstance();
	
	private final File mdsFile;
	
	public TCProject(File mdsFile)
	{ 
		this.mdsFile = mdsFile;
	}
	
	// Возвращает .tcScript файл, в котором хранится список подключенных модулей
	protected File GetTCScriptFile() throws Exception
	{
		XPath xPath = xPathFactory.newXPath();
		InputSource inputSource = new InputSource(new FileInputStream(mdsFile));
		String relpath = (String) xPath.evaluate(
				"//Node[Prp[@value='Script']]/Node[@name='item data']/Prp[@name='relpath']/@value",
				inputSource,
				XPathConstants.STRING
			);
		
		return new File(mdsFile.getParentFile(), relpath);
	}
	
	// Возвращает .sd файлы модулей, подключенных в проект
	public Collection<File> GetUnitFiles() throws Exception
	{		
		File tcScriptFile = GetTCScriptFile();
		InputSource inputSource = new InputSource(new FileInputStream(tcScriptFile));

		XPath xPath = xPathFactory.newXPath();
		NodeList values = (NodeList) xPath.evaluate(
				"//Node[@name='item data']/Prp[@name='relpath']/@value"
				, inputSource
				, XPathConstants.NODESET
			);
			
		Collection<File> retval = new ArrayList<File>();		
		for (int i = 0; i < values.getLength(); i++) {
				String relpath = values.item(i).getNodeValue();
				retval.add( new File(tcScriptFile.getParent(), relpath) );
		}

		return retval;
	}

	
	
}
