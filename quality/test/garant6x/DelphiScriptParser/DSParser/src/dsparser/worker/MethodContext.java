package dsparser.worker;

import java.lang.ref.WeakReference;
import java.util.EnumSet;


//  онтекст дл€ метода.
public class MethodContext extends BaseContext {
	
	private final WeakReference<UnitContext> unit_context;
		
	public MethodContext(String name, UnitContext unit_context)
	{		
		super( String.format("method %s from %s", name, unit_context.context_name));
		//		
		this.unit_context = new WeakReference<UnitContext>(unit_context);
	}
	
	@Override
	protected Symbol GetAvailableSymbol(String name, EnumSet<IdType> id_type) {
		// ищем идентификатор среди локальных (только константы и переменные)
		Symbol ret = GetLocalSymbol(name, id_type);
		if (ret == null) {
			// ищем идентификатор в модуле
			ret = unit_context.get().GetAvailableSymbol(name, id_type);
		}
		return ret;			
	}
}
