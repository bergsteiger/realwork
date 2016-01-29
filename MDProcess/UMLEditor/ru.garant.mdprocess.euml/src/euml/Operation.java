/**
 * <copyright>
 * </copyright>
 *
 * $Id: Operation.java,v 1.1 2009/02/25 06:20:00 pugin Exp $
 */
package euml;


/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Operation</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link euml.Operation#getReturnType <em>Return Type</em>}</li>
 * </ul>
 * </p>
 *
 * @see euml.EumlPackage#getOperation()
 * @model
 * @generated
 */
public interface Operation extends NamedElement {
	/**
	 * Returns the value of the '<em><b>Return Type</b></em>' reference.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Return Type</em>' reference isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Return Type</em>' reference.
	 * @see #setReturnType(euml.Class)
	 * @see euml.EumlPackage#getOperation_ReturnType()
	 * @model
	 * @generated
	 */
	euml.Class getReturnType();

	/**
	 * Sets the value of the '{@link euml.Operation#getReturnType <em>Return Type</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Return Type</em>' reference.
	 * @see #getReturnType()
	 * @generated
	 */
	void setReturnType(euml.Class value);

} // Operation
