package dsparser.worker;

import java.io.*;
import java.util.regex.Pattern;


// Таблица символов инифиализирующаяся из файла. Для предопределенных идентификаторов.
public class PredefinedSymTable extends SymTable {

	public PredefinedSymTable(String pathToFile)
	{
		try {
			BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(pathToFile)));
			String str;		
			final Pattern comment = Pattern.compile("//.*");
			while((str = br.readLine()) != null)
				if (!comment.matcher(str).matches())
				{
					str = str.trim();
					if (!str.isEmpty())
						Add(str, 0, 0);
				}
		} catch (Exception ex) {
			System.err.println(ex);
			System.exit(1);
		}
		
	}
}
