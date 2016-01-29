package euml.diagram.providers;

import org.eclipse.core.runtime.IAdaptable;
import org.eclipse.emf.ecore.EAttribute;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.gmf.runtime.common.core.service.AbstractProvider;
import org.eclipse.gmf.runtime.common.core.service.IOperation;
import org.eclipse.gmf.runtime.common.ui.services.parser.GetParserOperation;
import org.eclipse.gmf.runtime.common.ui.services.parser.IParser;
import org.eclipse.gmf.runtime.common.ui.services.parser.IParserProvider;
import org.eclipse.gmf.runtime.emf.type.core.IElementType;
import org.eclipse.gmf.runtime.emf.ui.services.parser.ParserHintAdapter;
import org.eclipse.gmf.runtime.notation.View;

import euml.EumlPackage;
import euml.diagram.edit.parts.AttributeEditPart;
import euml.diagram.edit.parts.ClassNameEditPart;
import euml.diagram.edit.parts.OperationEditPart;
import euml.diagram.edit.parts.PackageNameEditPart;
import euml.diagram.parsers.MessageFormatParser;
import euml.diagram.part.UmlVisualIDRegistry;

/**
 * @generated
 */
public class UmlParserProvider extends AbstractProvider implements
		IParserProvider {

	/**
	 * @generated
	 */
	private IParser className_5001Parser;

	/**
	 * @generated
	 */
	private IParser getClassName_5001Parser() {
		if (className_5001Parser == null) {
			className_5001Parser = createClassName_5001Parser();
		}
		return className_5001Parser;
	}

	/**
	 * @generated
	 */
	protected IParser createClassName_5001Parser() {
		EAttribute[] features = new EAttribute[] { EumlPackage.eINSTANCE
				.getNamedElement_Name(), };
		MessageFormatParser parser = new MessageFormatParser(features);
		return parser;
	}

	/**
	 * @generated
	 */
	private IParser packageName_5002Parser;

	/**
	 * @generated
	 */
	private IParser getPackageName_5002Parser() {
		if (packageName_5002Parser == null) {
			packageName_5002Parser = createPackageName_5002Parser();
		}
		return packageName_5002Parser;
	}

	/**
	 * @generated
	 */
	protected IParser createPackageName_5002Parser() {
		EAttribute[] features = new EAttribute[] { EumlPackage.eINSTANCE
				.getNamedElement_Name(), };
		MessageFormatParser parser = new MessageFormatParser(features);
		return parser;
	}

	/**
	 * @generated
	 */
	private IParser attribute_3001Parser;

	/**
	 * @generated
	 */
	private IParser getAttribute_3001Parser() {
		if (attribute_3001Parser == null) {
			attribute_3001Parser = createAttribute_3001Parser();
		}
		return attribute_3001Parser;
	}

	/**
	 * @generated
	 */
	protected IParser createAttribute_3001Parser() {
		EAttribute[] features = new EAttribute[] { EumlPackage.eINSTANCE
				.getNamedElement_Name(), };
		MessageFormatParser parser = new MessageFormatParser(features);
		return parser;
	}

	/**
	 * @generated
	 */
	private IParser operation_3002Parser;

	/**
	 * @generated
	 */
	private IParser getOperation_3002Parser() {
		if (operation_3002Parser == null) {
			operation_3002Parser = createOperation_3002Parser();
		}
		return operation_3002Parser;
	}

	/**
	 * @generated
	 */
	protected IParser createOperation_3002Parser() {
		EAttribute[] features = new EAttribute[] { EumlPackage.eINSTANCE
				.getNamedElement_Name(), };
		MessageFormatParser parser = new MessageFormatParser(features);
		return parser;
	}

	/**
	 * @generated
	 */
	protected IParser getParser(int visualID) {
		switch (visualID) {
		case ClassNameEditPart.VISUAL_ID:
			return getClassName_5001Parser();
		case PackageNameEditPart.VISUAL_ID:
			return getPackageName_5002Parser();
		case AttributeEditPart.VISUAL_ID:
			return getAttribute_3001Parser();
		case OperationEditPart.VISUAL_ID:
			return getOperation_3002Parser();
		}
		return null;
	}

	/**
	 * @generated
	 */
	public IParser getParser(IAdaptable hint) {
		String vid = (String) hint.getAdapter(String.class);
		if (vid != null) {
			return getParser(UmlVisualIDRegistry.getVisualID(vid));
		}
		View view = (View) hint.getAdapter(View.class);
		if (view != null) {
			return getParser(UmlVisualIDRegistry.getVisualID(view));
		}
		return null;
	}

	/**
	 * @generated
	 */
	public boolean provides(IOperation operation) {
		if (operation instanceof GetParserOperation) {
			IAdaptable hint = ((GetParserOperation) operation).getHint();
			if (UmlElementTypes.getElement(hint) == null) {
				return false;
			}
			return getParser(hint) != null;
		}
		return false;
	}

	/**
	 * @generated
	 */
	public static class HintAdapter extends ParserHintAdapter {

		/**
		 * @generated
		 */
		private final IElementType elementType;

		/**
		 * @generated
		 */
		public HintAdapter(IElementType type, EObject object, String parserHint) {
			super(object, parserHint);
			assert type != null;
			elementType = type;
		}

		/**
		 * @generated
		 */
		public Object getAdapter(Class adapter) {
			if (IElementType.class.equals(adapter)) {
				return elementType;
			}
			return super.getAdapter(adapter);
		}
	}

}
