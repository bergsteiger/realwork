package dsparser.worker;


import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;
import java.util.TreeMap;


public class SymTable {
	//private final CaseInsensitiveMap table = new CaseInsensitiveMap();
	private final Map<String, Symbol> table = new TreeMap<String, Symbol>(String.CASE_INSENSITIVE_ORDER);
	
	public void Add(String name, Integer line, Integer pos)
	{
		table.put(name, new Symbol(name, line, pos));
	}
	
	public boolean IsExists(String name)
	{
		return table.containsKey(name);
	}
	
	public Symbol Get(String name)
	{
		return (Symbol)table.get(name);
	}
	
	// Возвращает символы, использовавшиеся use_threshhold или меньше раз
	public Collection<Symbol> GetUsedSymbols(int use_threshold)
	{
		Collection<Symbol> result = new ArrayList<Symbol>(); 
		for (Symbol s : table.values())
			if (s.uses_count <= use_threshold)
				result.add(s);
		return result;
	}
}
